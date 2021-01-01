local _, MDT = ...
local L = MDT.L
local db
local twipe,tinsert,tremove,tgetn,CreateFrame = table.wipe,table.insert,table.remove,table.getn,CreateFrame

-- return true if a is more lower-left than b
local function is_lower_left(a, b)
    if a[1] < b[1] then return true end
    if a[1] > b[1] then return false end
    if a[2] < b[2] then return true end
    if a[2] > b[2] then return true end
    return false
end

-- return true if c is left of line a-b
local function is_left_of(a, b, c)
    local u1 = b[1] - a[1]
    local v1 = b[2] - a[2]
    local u2 = c[1] - a[1]
    local v2 = c[2] - a[2]
    return u1 * v2 - v1 * u2 < 0
end

local function convex_hull(pts)
    local lower_left = 1
    for i = 2, #pts do
        if is_lower_left(pts[i], pts[lower_left]) then lower_left = i end
    end

    local hull = {}
    local final = 1
    repeat
        table.insert(hull, lower_left)
        final = 1
        for j = 2, #pts do
            if lower_left == final or is_left_of(pts[lower_left], pts[final], pts[j]) then final = j end
        end
        lower_left = final
    until final == hull[1]

    local hullpts = {}
    for _, index in ipairs(hull) do
        table.insert(hullpts, pts[index])
    end
    return hullpts
end

local function catmull_rom(t, p0, p1, p2, p3,blipFactor)
    local ax = 2 * p1[1]
    local ay = 2 * p1[2]
    local bx = p2[1] - p0[1]
    local by = p2[2] - p0[2]
    local cx = 2 * p0[1] - 5 * p1[1] + 4 * p2[1] - p3[1]
    local cy = 2 * p0[2] - 5 * p1[2] + 4 * p2[2] - p3[2]
    local dx = -p0[1] + 3 * p1[1] - 3 * p2[1] + p3[1]
    local dy = -p0[2] + 3 * p1[2] - 3 * p2[2] + p3[2]

    local rx = 0.5 * (ax + (bx * t) + (cx * t * t) + (dx * t * t * t))
    local ry = 0.5 * (ay + (by * t) + (cy * t * t) + (dy * t * t * t))
    return {rx, ry,blipFactor}
end

local function wrap_index(index, len)
    if index < 1 then return len
    elseif index > (len+1) then return 2
    elseif index > len then return 1
    else return index end
end

local function isCloseMatch(num1,num2)
    return math.abs(num1 - num2) < 0.001;
end

local function smooth_contour(points, steps)
    steps = steps or 5
    local res = {}

    for i = 1, #points do
        local p0 = points[wrap_index(i - 1, #points)]
        local p1 = points[i]
        local p2 = points[wrap_index(i + 1, #points)]
        local p3 = points[wrap_index(i + 2, #points)]

        for t = 0, 1, 1/steps do
            local oldx = res[#res] and res[#res][1]
            local oldy = res[#res] and res[#res][2]
            local point = catmull_rom(t, p0, p1, p2, p3,points[i][3])
            --don't add point if previous point is the same
            if not oldx or not isCloseMatch(point[1],oldx) or not isCloseMatch(point[2],oldy) then
                --don't add point if first point is the same
                if not oldx or not isCloseMatch(point[1],res[1][1]) or not isCloseMatch(point[2],res[1][2]) then
                    table.insert(res, point)
                end
            end
        end
    end
    return res
end

local function cross(a,b)
    return a[1] * b[2] - a[2] * b[1]
end

local function area(points)
    local res = cross(points[#points], points[1])
    for i = 1, #points-1 do
        res = res + cross(points[i], points[i+1])
    end
    return math.abs(res)/2
end

local function centroid(pts)
    local rx = 0
    local ry = 0

    local area = area(pts)
    for i = 1, #pts-1 do
        rx = rx + ((pts[i][1] + pts[i+1][1]) * ((pts[i][1] * pts[i+1][2]) - (pts[i+1][1] * pts[i][2])))
        ry = ry + ((pts[i][2] + pts[i+1][2]) * ((pts[i][1] * pts[i+1][2]) - (pts[i+1][1] * pts[i][2])))
    end
    rx = rx + ((pts[#pts][1] + pts[1][1]) * ((pts[#pts][1] * pts[1][2]) - (pts[1][1] * pts[#pts][2])))
    ry = ry + ((pts[#pts][2] + pts[1][2]) * ((pts[#pts][1] * pts[1][2]) - (pts[1][1] * pts[#pts][2])))
    rx = rx / (area * 6)
    ry = ry / (area * 6)
    return {rx, ry}
end

local function expand_polygon(poly, offset)
    local c = centroid(poly)
    local res = {}
    for i = 1, #poly do
        local dx = poly[i][1]-c[1]
        local dy = poly[i][2]-c[2]
        local len = math.sqrt(dx^2+dy^2)
        local offsetx = (dx/len)*offset
        local offsety = (dy/len)*offset
        res[i] = {poly[i][1]+offsetx, poly[i][2]+offsety}
    end
    return res
end

---TexturePool
local activeTextures = {}
local texturePool = {}
local function getTexture()
    local size = tgetn(texturePool)
    if size == 0 then
        return MDT.main_frame.mapPanelFrame:CreateTexture(nil, "OVERLAY")
    else
        local tex = texturePool[size]
        tremove(texturePool, size)
        tex:SetRotation(0)
        tex:SetTexCoord(0, 1, 0, 1)
        tex:ClearAllPoints()
        tex.coords = nil
        tex.points = nil
        return tex
    end
end
local function releaseTexture(tex)
    tex:Hide()
    tinsert(texturePool,tex)
end

---ReleaseAllActiveTextures
function MDT:ReleaseHullTextures()
    for k,tex in pairs(activeTextures) do
        releaseTexture(tex)
    end
    twipe(activeTextures)
end

function MDT:DrawHullCircle(x, y, size, color, layer, layerSublevel)
    local circle = getTexture()
    circle:SetDrawLayer(layer, layerSublevel)
    circle:SetTexture("Interface\\AddOns\\MythicDungeonTools\\Textures\\Circle_White")
    circle:SetVertexColor(color.r,color.g,color.b,color.a)
    circle:SetWidth(1.1*size)
    circle:SetHeight(1.1*size)
    circle:ClearAllPoints()
    circle:SetPoint("CENTER", MDT.main_frame.mapPanelTile1,"TOPLEFT",x,y)
    circle:Show()
    tinsert(activeTextures,circle)
end

function MDT:DrawHullLine(x, y, a, b, size, color, smooth, layer, layerSublevel, lineFactor)
    local line = getTexture()
    line:SetTexture("Interface\\AddOns\\MythicDungeonTools\\Textures\\Square_White")
    line:SetVertexColor(color.r,color.g,color.b,color.a)
    DrawLine(line, MDT.main_frame.mapPanelTile1, x, y, a, b, size, lineFactor and lineFactor or 1.1,"TOPLEFT")
    line:SetDrawLayer(layer, layerSublevel)
    line:Show()
    line.coords = {x,y,a,b}
    tinsert(activeTextures,line)
    if smooth == true  then
        MDT:DrawHullCircle(x,y,size,color,layer,layerSublevel)
    end
end

function MDT:DrawHull(vertices,pullColor)

    local hull = convex_hull(vertices)
    if hull and hull[#hull] and #hull>2 then

        hull = expand_polygon(hull,7*(MDT.scaleMultiplier[MDT:GetDB().currentDungeonIdx] or 1))
        --hull = smooth_contour(hull,10)
        for i = 1, #hull do
            local a = hull[i]
            local b = hull[1]
            if i ~= #hull then b = hull[i+1] end
            MDT:DrawHullLine(a[1], a[2], b[1], b[2], 3*(MDT.scaleMultiplier[MDT:GetDB().currentDungeonIdx] or 1), pullColor, true, "ARTWORK", -8, 1)
        end
    end
end

local function getPullVertices(p,blips)
    local vertices = {}
    for enemyIdx,clones in pairs(p) do
        if tonumber(enemyIdx) then
            for _,cloneIdx in pairs(clones) do
                if MDT:IsCloneIncluded(enemyIdx, cloneIdx) then
                    for _,blip in pairs(blips) do
                        if (blip.enemyIdx == enemyIdx) and (blip.cloneIdx == cloneIdx) then
                            local endPoint, endRelativeTo, endRelativePoint, endX, endY = blip:GetPoint()
                            table.insert(vertices, {endX, endY, blip.data.scale})
                            break
                        end
                    end
                end
            end
        end
    end
    return vertices
end

function MDT:DrawAllHulls(pulls)
    MDT:ReleaseHullTextures()
    local preset = MDT:GetCurrentPreset()
    local blips = MDT:GetDungeonEnemyBlips()
    local vertices
    pulls = pulls or preset.value.pulls
    for pullIdx,p in pairs(pulls) do
        local r,g,b = MDT:DungeonEnemies_GetPullColor(pullIdx,pulls)
        vertices = getPullVertices(p,blips)
        MDT:DrawHull(vertices,{r=r, g=g, b=b, a=1})
    end
end

function MDT:FindClosestPull(x,y)
    local preset = MDT:GetCurrentPreset()
    local blips = MDT:GetDungeonEnemyBlips()
    local vertices,hull,center
    local centers = {}
    --1. construct all hulls of pulls in this sublevel
    for pullIdx,p in pairs(preset.value.pulls) do
        vertices = getPullVertices(p,blips)
        hull = convex_hull(vertices)
        --2. get centroid of each pull
        if hull and hull[#hull] then
            if #hull>2 then
                center = centroid(hull)
                centers[pullIdx]=center
            elseif #hull==2 then
                local x1 = hull[1][1]
                local y1 = hull[1][2]
                local x2 = hull[2][1]
                local y2 = hull[2][2]
                centers[pullIdx] = {(x1+x2)/2,(y1+y2)/2}
            elseif #hull==1 then
                local x1 = hull[1][1]
                local y1 = hull[1][2]
                centers[pullIdx] = {x1,y1}
            end
        end
    end
    --3. find closest centroid
    local centerDist = math.huge
    local centerIndex
    for k,center in pairs(centers) do
        local squaredDist = (x-center[1])^2+(y-center[2])^2
        if squaredDist<centerDist then
            centerDist = squaredDist
            centerIndex = k
        end
    end
    if centerIndex then
        return centerIndex,centers[centerIndex][1],centers[centerIndex][2]
    end

end