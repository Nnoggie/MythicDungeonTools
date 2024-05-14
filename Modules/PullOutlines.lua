local _, MDT = ...
local twipe, tinsert, tremove, tgetn = table.wipe, table.insert, table.remove, table.getn

local NONACTIVE_ALPHA = 0.5

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
  if not pts or #pts == 0 then return end
  local lower_left = 1
  for i = 2, #pts do
    if not pts[i][1] or not pts[lower_left][1] then return end
    if is_lower_left(pts[i], pts[lower_left]) then lower_left = i end
  end

  local hull = {}
  local final = 1
  local tries = 0
  repeat
    table.insert(hull, lower_left)
    final = 1
    for j = 2, #pts do
      if lower_left == final or is_left_of(pts[lower_left], pts[final], pts[j]) then final = j end
    end
    lower_left = final
    tries = tries + 1
  until final == hull[1] or tries > 100 --deadlocked here otherwise?!?

  local hullpts = {}
  for _, index in ipairs(hull) do
    table.insert(hullpts, pts[index])
  end
  return hullpts
end

local function cross(a, b)
  return a[1] * b[2] - a[2] * b[1]
end

local function area(points)
  local res = cross(points[#points], points[1])
  for i = 1, #points - 1 do
    res = res + cross(points[i], points[i + 1])
  end
  return math.abs(res) / 2
end

local function centroid(pts)
  local rx = 0
  local ry = 0
  for k, v in pairs(pts) do
    if not v[1] or not v[2] then return end
    rx = rx + v[1]
    ry = ry + v[2]
  end
  rx = rx / #pts
  ry = ry / #pts
  return { rx, ry }
end

local function expand_polygon(poly, numCirclePoints)
  local res = {}
  local resIndex = 1
  for i = 1, #poly do
    local x = poly[i][1]
    local y = poly[i][2]
    local r = poly[i][3] * 10
    local adjustedNumPoints = math.max(1, math.floor(numCirclePoints * poly[i][3]))
    if not x or not y or not r then return end
    for j = 1, adjustedNumPoints do
      local cx = x + r * math.cos(2 * math.pi / adjustedNumPoints * j)
      local cy = y + r * math.sin(2 * math.pi / adjustedNumPoints * j)
      res[resIndex] = { cx, cy, r }
      resIndex = resIndex + 1
    end
  end

  return res
end

---TexturePool
local activeTextures = {}
local texturePool = {}
local function getTexture()
  local size = tgetn(texturePool)
  if size == 0 then
    return MDT.main_frame.mapPanelFrame:CreateTexture(nil, "OVERLAY", nil, 0)
  else
    local tex = texturePool[size]
    tremove(texturePool, size)
    tex.isCircle = nil
    tex:SetRotation(0)
    tex:SetTexCoord(0, 1, 0, 1)
    tex:ClearAllPoints()
    tex.coords = nil
    tex.points = nil
    tex.pullIdx = nil
    return tex
  end
end

--make a pool for fontStrings
local activeFontStrings = {}
local fontStringPool = {}
local frameIndex = 0

local getFSFrameByPullIdx = function(pullIdx)
  for _, frame in pairs(activeFontStrings) do
    if frame.pullIdx == pullIdx then
      return frame
    end
  end
end

function MDT:PullClickAreaOnEnter(pullIdx)
  local fsFrame = getFSFrameByPullIdx(pullIdx)
  if not fsFrame then return end
  fsFrame.fs:SetScale(1.25)
  fsFrame.fs:SetAlpha(1)
  for _, tex in pairs(activeTextures) do
    if tex.pullIdx == pullIdx then
      tex:SetAlpha(1)
    end
  end
end

function MDT:PullClickAreaOnLeave()
  for _, fsFrame in pairs(activeFontStrings) do
    local isCurrentPull = fsFrame.pullIdx == MDT:GetCurrentPull()
    fsFrame.fs:SetScale(1)
    fsFrame.fs:SetAlpha(isCurrentPull and 1 or NONACTIVE_ALPHA)
  end
  for _, tex in pairs(activeTextures) do
    local isCurrentPull = tex.pullIdx == MDT:GetCurrentPull()
    if tex.isCircle then
      tex:SetAlpha(isCurrentPull and 1 or 0)
    else
      tex:SetAlpha(isCurrentPull and 1 or NONACTIVE_ALPHA)
    end
  end
end

local function getFontString()
  local size = tgetn(fontStringPool)
  if size == 0 then
    local fsFrame = CreateFrame("Frame", "MDTFontStringContainerFrame"..frameIndex, MDT.main_frame.mapPanelFrame)
    frameIndex = frameIndex + 1
    fsFrame:SetFrameStrata("HIGH")
    fsFrame:SetFrameLevel(100)
    fsFrame:SetWidth(40)
    fsFrame:SetHeight(40)
    local clickArea = CreateFrame("Button", "MDTFontString"..frameIndex.."ClickArea", fsFrame)
    clickArea:SetAllPoints(fsFrame)
    clickArea:SetFrameStrata("MEDIUM")
    clickArea:SetScript("OnClick", function(self, button, down)
      if button == "LeftButton" then
        MDT:SetSelectionToPull(self:GetParent().pullIdx)
        MDT:PullClickAreaOnEnter(self:GetParent().pullIdx)
      end
    end)
    clickArea:SetScript("OnEnter", function(self)
      MDT:PullClickAreaOnEnter(self:GetParent().pullIdx)
    end)
    clickArea:SetScript("OnLeave", function(self)
      MDT:PullClickAreaOnLeave()
    end)
    fsFrame.clickArea = clickArea
    local fs = fsFrame:CreateFontString(nil, "OVERLAY", nil)
    fs:SetPoint("CENTER", 0, 0)
    fs:SetJustifyH("CENTER")
    fs:SetJustifyV("MIDDLE")
    fs:SetTextColor(1, 1, 1, 1)
    local font = GameFontNormalMed3Outline
    fs:SetFontObject(font)
    fsFrame.fs = fs
    return fsFrame
  else
    local fsFrame = fontStringPool[size]
    tremove(fontStringPool, size)
    fsFrame.fs:SetText("")
    return fsFrame
  end
end

local previousPulls

function MDT:ReleaseHullTextures(pullsToRelease)
  for i = #activeTextures, 1, -1 do
    local tex = activeTextures[i]
    if not pullsToRelease or pullsToRelease[tex.pullIdx] then
      tex:Hide()
      tinsert(texturePool, tex)
      tremove(activeTextures, i)
    end
  end
  for i = #activeFontStrings, 1, -1 do
    local fsFrame = activeFontStrings[i]
    if not pullsToRelease or pullsToRelease[fsFrame.pullIdx] then
      fsFrame:Hide()
      tinsert(fontStringPool, fsFrame)
      tremove(activeFontStrings, i)
    end
  end
  if not pullsToRelease then previousPulls = nil end
end

function MDT:DrawHullFontString(hull, pullIdx)
  --2. get centroid of each pull
  local center
  if hull and hull[#hull] then
    if #hull > 2 then
      center = centroid(hull)
      if not center then return end
      center[1] = center[1]
      center[2] = center[2]
    elseif #hull == 2 then
      local x1 = hull[1][1]
      local y1 = hull[1][2]
      local x2 = hull[2][1]
      local y2 = hull[2][2]
      if not x1 or not y1 or not x2 or not y2 then return end
      center = { (x1 + x2) / 2, (y1 + y2) / 2 }
    elseif #hull == 1 then
      local x1 = hull[1][1]
      local y1 = hull[1][2]
      if not x1 or not y1 then return end
      center = { x1, y1 + 15 }
    end
  end
  if not center then return end
  local fsFrame = getFontString()
  fsFrame.pullIdx = pullIdx
  if MDT:GetCurrentPull() == pullIdx then
    fsFrame.fs:SetTextColor(1, 1, 1, 1)
  else
    fsFrame.fs:SetTextColor(1, 1, 1, NONACTIVE_ALPHA)
  end
  fsFrame.fs:SetText(pullIdx)
  fsFrame:ClearAllPoints()
  fsFrame:SetSize(40, 40)
  fsFrame:SetPoint("CENTER", MDT.main_frame.mapPanelTile1, "TOPLEFT", center[1], center[2])
  fsFrame:Show()
  tinsert(activeFontStrings, fsFrame)
end

function MDT:DrawHullCircle(x, y, size, color, alpha, layer, layerSublevel, pullIdx)
  local circle = getTexture()
  circle:SetDrawLayer(layer, layerSublevel)
  circle:SetTexture("Interface\\AddOns\\MythicDungeonTools\\Textures\\Circle_White")
  local a = alpha ~= 1 and 0 or alpha
  circle:SetVertexColor(color.r, color.g, color.b, a)
  circle:SetWidth(1.1 * size)
  circle:SetHeight(1.1 * size)
  circle:ClearAllPoints()
  circle:SetPoint("CENTER", MDT.main_frame.mapPanelTile1, "TOPLEFT", x, y)
  circle:Show()
  circle.pullIdx = pullIdx
  circle.isCircle = true
  tinsert(activeTextures, circle)
end

function MDT:DrawHullLine(x, y, a, b, size, color, alpha, smooth, layer, layerSublevel, lineFactor, pullIdx)
  local line = getTexture()
  line:SetTexture("Interface\\AddOns\\MythicDungeonTools\\Textures\\Square_White")
  line:SetVertexColor(color.r, color.g, color.b, alpha)
  DrawLine(line, MDT.main_frame.mapPanelTile1, x, y, a, b, size, lineFactor and lineFactor or 1.1, "TOPLEFT")
  line:SetDrawLayer(layer, layerSublevel)
  line:Show()
  line.coords = { x, y, a, b }
  line.pullIdx = pullIdx
  tinsert(activeTextures, line)
  if smooth == true then
    MDT:DrawHullCircle(x, y, size * 0.9, color, alpha, layer, layerSublevel, pullIdx)
  end
end

function MDT:DrawHull(vertices, pullColor, pullIdx)
  local isCurrent = MDT:GetCurrentPull() == pullIdx
  local sizeMultiplier = 0.8
  local alpha = isCurrent and 1 or NONACTIVE_ALPHA
  local hull = convex_hull(vertices)
  if hull then
    -- expand_polygon: higher value = more points = more expensive = smoother outlines
    hull = expand_polygon(hull, 30)
    hull = convex_hull(hull)
    if not hull then return end
    for i = 1, #hull do
      local a = hull[i]
      local b = hull[1]
      if i ~= #hull then b = hull[i + 1] end
      --layerSublevel go from -8 to 7
      --we rotate through the layerSublevel to avoid collisions
      MDT:DrawHullLine(a[1], a[2], b[1], b[2], sizeMultiplier * 3 * (MDT.scaleMultiplier[MDT:GetDB().currentDungeonIdx] or 1), pullColor, alpha,
        true, "ARTWORK", pullIdx % 16 - 8, 1, pullIdx)
    end
  end
end

local function getPullVertices(p, blips)
  local vertices = {}
  for enemyIdx, clones in pairs(p) do
    if tonumber(enemyIdx) then
      for _, cloneIdx in pairs(clones) do
        if MDT:IsCloneIncluded(enemyIdx, cloneIdx) then
          for _, blip in pairs(blips) do
            if (blip.enemyIdx == enemyIdx) and (blip.cloneIdx == cloneIdx) then
              local endPoint, endRelativeTo, endRelativePoint, endX, endY = blip:GetPoint()
              table.insert(vertices, { endX, endY, blip.normalScale })
              break
            end
          end
        end
      end
    end
  end
  return vertices
end

local function getPullsToDraw(newPulls)
  local changedPulls = {}
  local removedPulls = {}

  if not previousPulls then
    return newPulls, removedPulls
  end

  for pullIdx, pull in pairs(newPulls) do
    --pull additions
    if not previousPulls[pullIdx] then
      changedPulls[pullIdx] = pull
    else
      --enemy or clone additions to existing pulls
      local changed = false
      for enemyIdx, clones in pairs(pull) do
        if type(enemyIdx) == "number" then
          if not previousPulls[pullIdx][enemyIdx] then
            changed = true
            break
          else
            for _, cloneIdx in pairs(clones) do
              local found = false
              for _, previousCloneIdx in pairs(previousPulls[pullIdx][enemyIdx]) do
                if cloneIdx == previousCloneIdx then
                  found = true
                  break
                end
              end
              if not found then
                changed = true
                break
              end
            end
          end
        end
      end
      if changed then
        changedPulls[pullIdx] = pull
      end
      --sublevel stuff
    end
  end


  for pullIdx, pull in pairs(previousPulls) do
    --removed pulls
    if not newPulls[pullIdx] then
      removedPulls[pullIdx] = true
    else
      --enemy and clone removal from existing pulls
      for enemyIdx, clones in pairs(pull) do
        if type(enemyIdx) == "number" then
          if newPulls[pullIdx][enemyIdx] then
            for _, cloneIdx in pairs(clones) do
              local found = false
              for _, newCloneIdx in pairs(newPulls[pullIdx][enemyIdx]) do
                if cloneIdx == newCloneIdx then
                  found = true
                  break
                end
              end
              if not found then
                changedPulls[pullIdx] = newPulls[pullIdx]
                break
              end
            end
          else
            changedPulls[pullIdx] = newPulls[pullIdx]
          end
        end
      end
    end
  end

  return changedPulls, removedPulls
end

function MDT:DrawAllHulls(pulls, force)
  MDT:CancelAsync("DrawAllHulls")
  MDT:Async(function()
    --get changed/removed pulls, release those textures, q them up for redraw
    local preset = MDT:GetCurrentPreset()
    pulls = pulls or preset.value.pulls
    local pullsToDraw, removedPulls
    if force then
      pullsToDraw = pulls
      MDT:ReleaseHullTextures()
    else
      pullsToDraw, removedPulls = getPullsToDraw(pulls)
      local pullsToRelease = {}
      for pullIdx, _ in pairs(pullsToDraw) do
        pullsToRelease[pullIdx] = true
      end
      for pullIdx, _ in pairs(removedPulls) do
        pullsToRelease[pullIdx] = true
      end
      MDT:ReleaseHullTextures(pullsToRelease)
    end

    local blips = MDT:GetDungeonEnemyBlips()
    local vertices
    for pullIdx, p in pairs(pullsToDraw) do
      local r, g, b = MDT:DungeonEnemies_GetPullColor(pullIdx, pullsToDraw)
      vertices = getPullVertices(p, blips)
      MDT:DrawHull(vertices, { r = r, g = g, b = b, a = 1 }, pullIdx)
      MDT:DrawHullFontString(vertices, pullIdx)
      coroutine.yield()
    end
    previousPulls = CopyTable(pulls)
  end, "DrawAllHulls", true)
end

function MDT:FindClosestPull(x, y)
  local preset = MDT:GetCurrentPreset()
  local blips = MDT:GetDungeonEnemyBlips()
  local vertices, hull, center
  local centers = {}
  --1. construct all hulls of pulls in this sublevel
  for pullIdx, p in pairs(preset.value.pulls) do
    vertices = getPullVertices(p, blips)
    hull = convex_hull(vertices)
    --2. get centroid of each pull
    if hull and hull[#hull] then
      if #hull > 2 then
        center = centroid(hull)
        centers[pullIdx] = center
      elseif #hull == 2 then
        local x1 = hull[1][1]
        local y1 = hull[1][2]
        local x2 = hull[2][1]
        local y2 = hull[2][2]
        centers[pullIdx] = { (x1 + x2) / 2, (y1 + y2) / 2 }
      elseif #hull == 1 then
        local x1 = hull[1][1]
        local y1 = hull[1][2]
        centers[pullIdx] = { x1, y1 }
      end
    end
  end
  --3. find closest centroid
  local centerDist = math.huge
  local centerIndex
  for k, center in pairs(centers) do
    local squaredDist = (x - center[1]) ^ 2 + (y - center[2]) ^ 2
    if squaredDist < centerDist then
      centerDist = squaredDist
      centerIndex = k
    end
  end
  if centerIndex then
    return centerIndex, centers[centerIndex][1], centers[centerIndex][2]
  end
end
