local _, MDT = ...
local tinsert, tremove = table.insert, table.remove

---Pulls other than the current one fade this far towards the panel background. Outlines and pull labels stay opaque:
---WoW fades each texture on its own, so a see-through outline would show its round joins through its lines.
local DIM = 0.4
---Outlines draw in rotating sublevels so pulls rarely share one; the current and hovered pulls draw above them all.
local TOP_SUBLEVEL = 7

---A pull's color at full strength, or faded for pulls other than the current one.
---@param r number
---@param g number
---@param b number
---@param bright boolean
---@return number r, number g, number b
function MDT:PullTone(r, g, b, bright)
  if bright then return r, g, b end
  local fill = MDT.UI.Theme.Rgba("bg.panel")
  return r + (fill[1] - r) * DIM, g + (fill[2] - g) * DIM, b + (fill[3] - b) * DIM
end

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
  local size = #texturePool
  if size == 0 then
    return MDT.main_frame.mapPanelFrame:CreateTexture(nil, "OVERLAY", nil, 0)
  else
    local tex = texturePool[size]
    tremove(texturePool, size)
    tex:SetRotation(0)
    tex:SetTexCoord(0, 1, 0, 1)
    tex:ClearAllPoints()
    tex.coords = nil
    tex.points = nil
    tex.pullIdx, tex.color, tex.sublevel = nil, nil, nil
    return tex
  end
end

---The outline each drawn pull got, by pull index; the pull labels place themselves by these.
local outlines = {}

---Colors an outline texture at full strength and above the other outlines, or faded in its own sublevel.
local function toneTexture(tex, bright)
  local color = tex.color
  tex:SetVertexColor(MDT:PullTone(color.r, color.g, color.b, bright))
  tex:SetDrawLayer("ARTWORK", bright and TOP_SUBLEVEL or tex.sublevel)
end

function MDT:PullClickAreaOnEnter(pullIdx)
  for _, tex in pairs(activeTextures) do
    if tex.pullIdx == pullIdx then toneTexture(tex, true) end
  end
  MDT:HighlightPullLabel(pullIdx)
end

function MDT:PullClickAreaOnLeave()
  local current = MDT:GetCurrentPull()
  for _, tex in pairs(activeTextures) do toneTexture(tex, tex.pullIdx == current) end
  MDT:HighlightPullLabel(nil)
end

---Test access to the textures drawing a pull's outline.
---@param pullIdx integer
---@return table[]
function MDT:GetPullOutlineTextures(pullIdx)
  local found = {}
  for _, tex in ipairs(activeTextures) do
    if tex.pullIdx == pullIdx then found[#found + 1] = tex end
  end
  return found
end

local previousPulls

---Releases the outlines of the given pulls, or of every pull.
---@param pullsToRelease table<integer, true>?
---@param keepLabels boolean? leaves the pull labels up for a redraw that places them again
function MDT:ReleaseHullTextures(pullsToRelease, keepLabels)
  for i = #activeTextures, 1, -1 do
    local tex = activeTextures[i]
    if not pullsToRelease or pullsToRelease[tex.pullIdx] then
      tex:Hide()
      tinsert(texturePool, tex)
      tremove(activeTextures, i)
    end
  end
  if pullsToRelease then
    for pullIdx in pairs(pullsToRelease) do outlines[pullIdx] = nil end
  else
    wipe(outlines)
    if not keepLabels then MDT:HidePullLabels() end
    previousPulls = nil
  end
end

function MDT:DrawHullCircle(x, y, size, color, bright, layerSublevel, pullIdx)
  local circle = getTexture()
  circle:SetTexture("Interface\\AddOns\\MythicDungeonTools\\Textures\\Circle_White")
  circle.color, circle.sublevel = color, layerSublevel
  toneTexture(circle, bright)
  circle:SetWidth(1.1 * size)
  circle:SetHeight(1.1 * size)
  circle:ClearAllPoints()
  circle:SetPoint("CENTER", MDT.main_frame.mapPanelTile1, "TOPLEFT", x, y)
  circle:Show()
  circle.pullIdx = pullIdx
  tinsert(activeTextures, circle)
end

function MDT:DrawHullLine(x, y, a, b, size, color, bright, smooth, layerSublevel, lineFactor, pullIdx)
  local line = getTexture()
  line:SetTexture("Interface\\AddOns\\MythicDungeonTools\\Textures\\Square_White")
  DrawLine(line, MDT.main_frame.mapPanelTile1, x, y, a, b, size, lineFactor and lineFactor or 1.1, "TOPLEFT")
  line.color, line.sublevel = color, layerSublevel
  toneTexture(line, bright)
  line:Show()
  line.coords = { x, y, a, b }
  line.pullIdx = pullIdx
  tinsert(activeTextures, line)
  if smooth == true then
    MDT:DrawHullCircle(x, y, size * 0.9, color, bright, layerSublevel, pullIdx)
  end
end

---Draws a pull's outline around its enemies and returns the outline's points.
---@return number[][]?
function MDT:DrawHull(vertices, pullColor, pullIdx)
  local isCurrent = MDT:GetCurrentPull() == pullIdx
  local sizeMultiplier = 0.8
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
      --layerSublevel go from -8 to 6; 7 is kept for the current and hovered pulls
      --we rotate through the layerSublevel to avoid collisions
      MDT:DrawHullLine(a[1], a[2], b[1], b[2], sizeMultiplier * 3 * (MDT.scaleMultiplier[MDT:GetDB().currentDungeonIdx] or 1), pullColor, isCurrent,
        true, pullIdx % 15 - 8, 1, pullIdx)
    end
  end
  return hull
end

local function getPullVertices(p, blips)
  local vertices = {}
  for enemyIdx, clones in pairs(p) do
    if tonumber(enemyIdx) then
      for _, cloneIdx in pairs(clones) do
        if MDT:IsCloneIncluded(enemyIdx, cloneIdx) then
          for _, blip in pairs(blips) do
            if (blip.enemyIdx == enemyIdx) and (blip.cloneIdx == cloneIdx) then
              local endX, endY = select(4, blip:GetPoint())
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
      MDT:ReleaseHullTextures(nil, true)
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
      outlines[pullIdx] = MDT:DrawHull(vertices, { r = r, g = g, b = b, a = 1 }, pullIdx)
      coroutine.yield()
    end
    -- Every label is placed again: a changed pull moves the running totals of the pulls after it.
    MDT:PlacePullLabels(pulls, outlines)
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
