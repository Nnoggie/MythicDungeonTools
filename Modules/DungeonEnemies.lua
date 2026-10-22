local _, MDT = ...
local db
local tonumber, tinsert, pairs, ipairs, tostring, twipe, max, min, tremove, floor, DrawLine = tonumber, table.insert, pairs,
    ipairs, tostring, table.wipe, math.max, math.min, table.remove, math.floor, DrawLine
local L = MDT.L
local blips = {}
local preset
local patrolColor = { 0, 0.5, 1, 0.8 }
local MIN_OVERLAP_BUCKET_SIZE = 9
local BLIP_FRAME_SIZE = 13
local BLIP_VISUAL_SIZE = 30
-- POI frames sit at level 4; sharing a level would interleave blip and POI draw layers
local BLIP_BASE_FRAME_LEVEL = 5

function MDT:GetDungeonEnemyBlips()
  return blips
end

---The enemy being dragged on the map; the enemy and pull cards stay closed meanwhile.
local draggedBlip

---Whether an enemy is being dragged. A blip hidden mid-drag, by the window closing or the map redrawing, gets no
---OnDragStop, so a drag also ends with its blip or the mouse button.
---@return boolean
function MDT:IsEnemyDragging()
  if draggedBlip and not (draggedBlip:IsVisible() and IsMouseButtonDown("LeftButton")) then draggedBlip = nil end
  return draggedBlip ~= nil
end

---Tints a blip's portrait in its pull's color. A spell icon shown in the portrait keeps its own colors; the tint waits
---until the enemy's portrait is back.
local function tintPortrait(blip, r, g, b)
  if blip.spellPortrait then
    blip.portraitTint = { r, g, b }
    return
  end
  blip.texture_Portrait:SetVertexColor(r, g, b, 1)
end

---Shows a spell's icon in a blip's portrait, in the icon's own colors, until nil puts the enemy's portrait back.
---@param blip table
---@param icon (string|number)?
function MDT:DungeonEnemies_SetSpellPortrait(blip, icon)
  local texture = blip.texture_Portrait
  if icon then
    if not blip.spellPortrait then blip.portraitTint = { texture:GetVertexColor() } end
    blip.spellPortrait = icon
    MDT.UI.Icon.SetZoomed(texture, icon)
    texture:SetVertexColor(1, 1, 1, 1)
    return
  end
  if not blip.spellPortrait then return end
  blip.spellPortrait = nil
  texture:SetTexCoord(0, 1, 0, 1)
  if blip.portraitIsTexture then
    texture:SetTexture(blip.portrait)
  else
    SetPortraitTextureFromCreatureDisplayID(texture, blip.portrait)
  end
  local tint = blip.portraitTint or { 1, 1, 1 }
  texture:SetVertexColor(tint[1], tint[2], tint[3], 1)
end

--From http://wow.gamepedia.com/UI_coordinates
function MDT:DoFramesOverlap(frameA, frameB, offset)
  if not frameA or not frameB then return end
  offset = offset or 0
  --frameA = frameA.texture_Background
  --frameB = frameB.texture_Background

  local sA, sB = frameA:GetEffectiveScale(), frameB:GetEffectiveScale();
  if not sA or not sB then return end

  local frameALeft = frameA:GetLeft() - offset
  local frameARight = frameA:GetRight() + offset
  local frameABottom = frameA:GetBottom() - offset
  local frameATop = frameA:GetTop() + offset

  local frameBLeft = frameB:GetLeft()
  local frameBRight = frameB:GetRight()
  local frameBBottom = frameB:GetBottom()
  local frameBTop = frameB:GetTop()

  if not frameALeft or not frameARight or not frameABottom or not frameATop then return end
  if not frameBLeft or not frameBRight or not frameBBottom or not frameBTop then return end

  return ((frameALeft * sA) < (frameBRight * sB))
      and ((frameBLeft * sB) < (frameARight * sA))
      and ((frameABottom * sA) < (frameBTop * sB))
      and ((frameBBottom * sB) < (frameATop * sA));
end

MDTDungeonEnemyMixin = {};

local defaultSizes = {
  ["texture_Background"] = 20,
  ["texture_Portrait"] = 15,
  ["texture_MouseHighlight"] = 20,
  ["texture_SelectedHighlight"] = 20,
  ["texture_Dragon"] = 26,
  ["texture_Indicator"] = 20,
  ["texture_PullIndicator"] = 23,
  ["texture_DragDown"] = 8,
  ["texture_DragLeft"] = 8,
  ["texture_DragRight"] = 8,
  ["texture_DragUp"] = 8,
  ["texture_OverlayIcon"] = 12,
  ["mask_PortraitMask"] = 20,
}

function MDTDungeonEnemyMixin:updateSizes(scale)
  for tex, size in pairs(defaultSizes) do
    self[tex]:SetSize(size * self.normalScale * scale, size * self.normalScale * scale)
  end
end

function MDTDungeonEnemyMixin:SetFrameLevelAboveOverlaps(overlapCandidates)
  local raise = BLIP_BASE_FRAME_LEVEL
  for _, other in ipairs(overlapCandidates or blips) do
    local visualOffset = (BLIP_VISUAL_SIZE - BLIP_FRAME_SIZE) * 0.5 * (self.normalScale + other.normalScale)
    if MDT:DoFramesOverlap(self, other, visualOffset) then
      raise = max(raise, other:GetFrameLevel() + 1)
    end
  end
  self:SetFrameLevel(raise)
end

function MDT:DisplayBlipModifierLabels(modifier)
  for _, blip in pairs(blips) do
    blip.textLocked = true
    local text = (modifier == "alt" and blip.clone.g and "G"..blip.clone.g) or (modifier == "ctrl" and MDT:GetCloneEnemyForces(blip.data, blip.clone)) or ""
    blip.fontstring_Text1:SetText(text)
    blip.fontstring_Text1:Show()
  end
end

function MDT:HideAllBlipLabels(force)
  for _, blip in pairs(blips) do
    if force or blip.textLocked then
      blip.fontstring_Text1:Hide()
      blip.textLocked = nil
    end
  end
end

function MDT:SetUpModifiers(frame)
  if MDT:GetDB().devMode then return end
  local ONUPDATE_INTERVAL = 0.1
  local timeSinceLastUpdate = 0
  frame:SetScript("OnUpdate", function(self, elapsed)
    timeSinceLastUpdate = timeSinceLastUpdate + elapsed
    if timeSinceLastUpdate >= ONUPDATE_INTERVAL then
      timeSinceLastUpdate = 0
      local modifier = (IsAltKeyDown() and "alt") or (IsControlKeyDown() and "ctrl")
      local overMDT = frame:IsMouseOver() or frame.sidePanel:IsMouseOver() or frame.topPanel:IsMouseOver() or frame.bottomPanel:IsMouseOver()
      if modifier and overMDT then
        MDT:DisplayBlipModifierLabels(modifier)
        local statusText = (modifier == "alt" and L["altKeyDownStatusText"]) or (modifier == "ctrl" and L["ctrlKeyDownStatusText"])
        MDT.main_frame.statusString:SetText(statusText)
        MDT.main_frame.statusString:Show()
      else
        MDT:HideAllBlipLabels()
        MDT.main_frame.statusString:Hide()
      end
    end
  end)
end

function MDTDungeonEnemyMixin:OnEnter()
  if MDT:DungeonEnemies_IsBoxSelecting() then
    self.hoverSuppressed = true
    return
  end
  self:updateSizes(1.2)
  self.sizesDirty = true
  self:SetFrameLevel(self:GetFrameLevel() + 5)
  self:DisplayPatrol(true)
  MDT:DisplayBlipTooltip(self, true)
  if not db.devMode then
    if self.textLocked then return end
    self.fontstring_Text1:SetText(MDT:GetCloneEnemyForces(self.data, self.clone))
    self.fontstring_Text1:Show()
    if self.clone.g then
      for _, blip in pairs(blips) do
        if blip.clone.g == self.clone.g then
          blip.fontstring_Text1:SetText(MDT:GetCloneEnemyForces(blip.data, blip.clone))
          blip.fontstring_Text1:Show()
        end
      end
    end
  end
end

function MDTDungeonEnemyMixin:OnLeave()
  if self.hoverSuppressed then
    self.hoverSuppressed = nil
    return
  end
  self:updateSizes(1)
  self.sizesDirty = nil
  self:SetFrameLevel(self:GetFrameLevel() - 5)
  if db.devMode then
    if not self.devSelected then self:DisplayPatrol(false) end
  else
    self:DisplayPatrol(false)
  end
  MDT:DisplayBlipTooltip(self, false)
  if not db.devMode then
    if self.textLocked then return end
    self.fontstring_Text1:Hide()
    if not self.clone.g then return end
    for _, blip in pairs(blips) do
      if blip.clone.g == self.clone.g then
        blip.fontstring_Text1:Hide()
      end
    end
  end
end

local function updateDragPreviewPosition(preview, cursorX, cursorY)
  preview:ClearAllPoints()
  preview:SetPoint("CENTER", MDT.main_frame.mapPanelTile1, "TOPLEFT", cursorX + preview.offsetX, cursorY + preview.offsetY)
end

---The grabbed enemy's preview sits centered on the cursor; group members keep their distance from it.
local function setupDragPreview(preview, blip, grabbed, cursorX, cursorY)
  local _, _, _, blipX, blipY = blip:GetPoint()
  local _, _, _, grabbedX, grabbedY = grabbed:GetPoint()
  preview.offsetX = (blipX or 0) - (grabbedX or 0)
  preview.offsetY = (blipY or 0) - (grabbedY or 0)
  preview:SetFrameStrata("HIGH")
  preview:SetFrameLevel(120)
  preview:SetAlpha(0.5)
  preview:EnableMouse(false)
  preview:SetSize(blip.normalScale * 13, blip.normalScale * 13)
  preview.texture_Background:SetSize(blip.normalScale * 20, blip.normalScale * 20)
  preview.texture_Background:SetVertexColor(1, 1, 1, 1)
  preview.texture_Portrait:SetSize(blip.normalScale * 15, blip.normalScale * 15)
  preview.texture_Portrait:SetVertexColor(1, 1, 1, 1)
  preview.texture_Portrait:SetDesaturated(false)
  if blip.data.iconTexture then
    preview.texture_Portrait:SetTexture(blip.data.iconTexture)
  else
    SetPortraitTextureFromCreatureDisplayID(preview.texture_Portrait, blip.data.displayId or 39490)
  end
  updateDragPreviewPosition(preview, cursorX, cursorY)
  preview:Show()
end

local function getDraggedBlips(blip, ignoreGrouped)
  local draggedBlips = { blip }
  if ignoreGrouped or not blip.clone.g then return draggedBlips end
  for _, otherBlip in pairs(blips) do
    if otherBlip ~= blip and otherBlip.clone.g == blip.clone.g and otherBlip:IsShown() and otherBlip:IsEnabled() then
      tinsert(draggedBlips, otherBlip)
    end
  end
  return draggedBlips
end

local function showDragPreviews(blip, ignoreGrouped)
  MDT.dungeonEnemyDragPreview_framePool:ReleaseAll()
  local cursorX, cursorY = MDT:GetCursorPosition()
  for _, draggedBlip in pairs(getDraggedBlips(blip, ignoreGrouped)) do
    setupDragPreview(MDT.dungeonEnemyDragPreview_framePool:Acquire(), draggedBlip, blip, cursorX, cursorY)
  end
end

local function updateDragPreviews(cursorX, cursorY)
  for _, preview in pairs(MDT.dungeonEnemyDragPreview_framePool.active) do
    updateDragPreviewPosition(preview, cursorX, cursorY)
  end
end

local DRAG_TARGET_UPDATE_INTERVAL = 0.1

local function setUpMouseHandlers(self)
  self:SetScript("OnMouseDown", function(self, button)

  end)
  local tempPulls
  local targetPull
  local dragPreviewIgnoreGrouped
  local dragPreviewHullState
  self:SetScript("OnDragStart", function()
    draggedBlip = self
    MDT:HidePullListCards()
    local x, y, scale
    local dragTargetUpdateElapsed = DRAG_TARGET_UPDATE_INTERVAL
    preset = MDT:GetCurrentPreset()
    tempPulls = CopyTable(preset.value.pulls)
    targetPull = nil
    dragPreviewHullState = nil
    dragPreviewIgnoreGrouped = IsControlKeyDown()
    showDragPreviews(self, dragPreviewIgnoreGrouped)
    local _, _, _, blipX, blipY = self:GetPoint()
    self:SetScript("OnUpdate", function(_, elapsed)
      local nx, ny = MDT:GetCursorPosition()
      if x ~= nx or y ~= ny then
        x, y = nx, ny
        local ignoreGrouped = IsControlKeyDown()
        if ignoreGrouped ~= dragPreviewIgnoreGrouped then
          dragPreviewIgnoreGrouped = ignoreGrouped
          tempPulls = CopyTable(preset.value.pulls)
          targetPull = nil
          dragPreviewHullState = nil
          dragTargetUpdateElapsed = DRAG_TARGET_UPDATE_INTERVAL
          showDragPreviews(self, dragPreviewIgnoreGrouped)
        end
        updateDragPreviews(x, y)
        dragTargetUpdateElapsed = dragTargetUpdateElapsed + (elapsed or 0)
        if dragTargetUpdateElapsed < DRAG_TARGET_UPDATE_INTERVAL then return end
        dragTargetUpdateElapsed = 0
        --find closest pull and measure distance
        local pullIdx, centerX, centerY = MDT:FindClosestPull(x, y)
        if not centerX then
          targetPull = nil
          return
        end
        local distBlip = (centerX - blipX) ^ 2 + (centerY - blipY) ^ 2
        local distCursor = (centerX - x) ^ 2 + (centerY - y) ^ 2
        local isClose = distCursor < 1 / 3 * distBlip or distBlip < 150
        if not isClose then
          MDT:DungeonEnemies_AddOrRemoveBlipToCurrentPull(self, false, ignoreGrouped, tempPulls, nil, true)
          MDT:DungeonEnemies_UpdateSelected(MDT:GetCurrentPull(), tempPulls)
          targetPull = nil
          if dragPreviewHullState ~= false then
            dragPreviewHullState = false
            MDT:DrawAllHulls(CopyTable(tempPulls), true)
          end
        elseif pullIdx ~= targetPull or dragPreviewHullState ~= pullIdx then
          targetPull = pullIdx
          MDT:DungeonEnemies_AddOrRemoveBlipToCurrentPull(self, true, ignoreGrouped, tempPulls, pullIdx, true)
          MDT:DungeonEnemies_UpdateSelected(MDT:GetCurrentPull(), tempPulls)
          dragPreviewHullState = pullIdx
          MDT:DrawAllHulls(CopyTable(tempPulls), true)
        end
      end
    end)
  end)
  self:SetScript("OnDragStop", function()
    draggedBlip = nil
    self:SetScript("OnUpdate", nil)
    MDT.dungeonEnemyDragPreview_framePool:ReleaseAll()
    MDT:CancelAsync("DrawAllHulls")
    preset.value.pulls = tempPulls
    MDT:DungeonEnemies_UpdateSelected(MDT:GetCurrentPull(), tempPulls)
    MDT:SetSelectionToPull(targetPull)
    MDT:RefreshSidebar()
    MDT:DrawAllHulls(nil, true)
    if MDT.liveSessionActive and MDT:GetCurrentPreset().uid == MDT.livePresetUID then
      MDT:LiveSession_SendPulls(MDT:GetPulls())
    end
  end)
end

local iconColors = {
  { 1,   .92, 0,    1 },
  { .98, .57, 0,    1 },
  { .83, .22, .9,   1 },
  { .04, .95, 0,    1 },
  { .7,  .82, .875, 1 },
  { 0,   .71, 1,    1 },
  { 1,   .24, .168, 1 },
  { .98, .98, .98,  1 },
}

local createEnemyContextMenu = function(frame)
  MDT:GetCurrentPreset().value.enemyAssignments = MDT:GetCurrentPreset().value.enemyAssignments or {}
  local assignments = MDT:GetCurrentPreset().value.enemyAssignments
  local function isSelected(index)
    local assignment = assignments[frame.enemyIdx] and assignments[frame.enemyIdx][frame.cloneIdx]
    return assignment ~= nil and assignment == index
  end
  local function select(index)
    assignments[frame.enemyIdx] = assignments[frame.enemyIdx] or {}
    assignments[frame.enemyIdx][frame.cloneIdx] = index ~= 0 and index or nil
    frame:SetUp(frame.data, frame.clone)
    if not db.hasSeenAssignmentWarning then
      MDT.UI.Dialogs.Confirm({ key = "assignmentWarning", width = 450, title = L["Warning"], text = L["assignmentWarning"], confirm = { text = L["Okay"], onClick = function() end } })
      db.hasSeenAssignmentWarning = true
    end
  end
  local markers = {}
  for i = 1, 8 do
    local iconPath = ICON_LIST[i].."16:16:|t"
    local color = CreateColor(unpack(iconColors[i]))
    local iconName = WrapTextInColor(_G["RAID_TARGET_"..i], color)
    markers[#markers + 1] = { kind = "choice", text = iconPath.." "..iconName, checked = isSelected(i), onSelect = function() select(i) end }
  end
  markers[#markers + 1] = { kind = "choice", text = L["None"], checked = isSelected(0), onSelect = function() select(0) end }
  markers[#markers + 1] = { text = L["Clear all Markers"], onSelect = function()
    twipe(assignments)
    MDT:Async(function()
      MDT:DungeonEnemies_UpdateEnemiesAsync()
    end, "ClearAllMarkers")
  end }
  MDT:CreateContextMenu(MDT.main_frame, {
    { kind = "title", text = L[frame.data.name] },
    { kind = "submenu", text = L["Set Target Marker"], items = markers },
    { text = L["Open Enemy Info"], onSelect = function() MDT:ShowEnemyInfoFrame(frame) end },
  })
end

function MDTDungeonEnemyMixin:OnClick(button, down)
  --always deselect toolbar tool
  MDT:UpdateSelectedToolbarTool()
  if button == "LeftButton" then
    if IsShiftKeyDown() and not self.selected then
      local newPullIdx = MDT:GetCurrentPull() + 1
      MDT:PresetsAddPull(newPullIdx)
      MDT:GetCurrentPreset().value.selection = { newPullIdx }
      MDT:SetSelectionToPull(newPullIdx)
    end
    MDT:DungeonEnemies_AddOrRemoveBlipToCurrentPull(self, not self.selected, IsControlKeyDown())
    MDT:DungeonEnemies_UpdateSelected(MDT:GetCurrentPull())
    MDT:RefreshSidebar()
    MDT:DrawAllHulls()
    if MDT.liveSessionActive and MDT:GetCurrentPreset().uid == MDT.livePresetUID then
      MDT:LiveSession_SendPulls(MDT:GetPulls())
    end
  elseif button == "RightButton" then
    if db.devMode then
      if IsAltKeyDown() then
        MDT.dungeonEnemies[db.currentDungeonIdx][self.enemyIdx].clones[self.cloneIdx] = nil
        self:Hide()
      else
        self.devSelected = (not self.devSelected) or nil
        self:DisplayPatrol(self.devSelected)
        for blipIdx, blip in pairs(blips) do
          if blip ~= self then
            blip.devSelected = nil
          end
          if blip.devSelected then
            blip.texture_Portrait:SetVertexColor(1, 0, 0, 1)
          else
            blip.texture_Portrait:SetVertexColor(1, 1, 1, 1)
          end
        end
      end
      MDT:UpdateMap()
    else
      createEnemyContextMenu(self)
    end
  end
end

local patrolPoints = {}
local patrolLines = {}

function MDT:GetPatrolBlips()
  return patrolPoints
end

function MDTDungeonEnemyMixin:DisplayPatrol(shown)
  local scale = MDT:GetScale()

  --Hide all points/line
  for _, point in pairs(patrolPoints) do point:Hide() end
  for _, line in pairs(patrolLines) do line:Hide() end
  if not shown then return end

  if self.clone.patrol then
    local firstWaypointBlip
    local oldWaypointBlip
    for patrolIdx, waypoint in ipairs(self.clone.patrol) do
      patrolPoints[patrolIdx] = patrolPoints[patrolIdx] or
          MDT.main_frame.mapPanelFrame:CreateTexture("MDTDungeonPatrolPoint"..patrolIdx, "BACKGROUND", nil, 0)


      patrolPoints[patrolIdx]:SetDrawLayer("OVERLAY", 2)
      patrolPoints[patrolIdx]:SetTexture("Interface\\Worldmap\\X_Mark_64Grey")
      patrolPoints[patrolIdx]:SetSize(4 * scale, 4 * scale)
      patrolPoints[patrolIdx]:SetVertexColor(0, 0.2, 0.5, 0.6)
      patrolPoints[patrolIdx]:ClearAllPoints()
      patrolPoints[patrolIdx]:SetPoint("CENTER", MDT.main_frame.mapPanelTile1, "TOPLEFT", waypoint.x * scale,
        waypoint.y * scale)
      patrolPoints[patrolIdx].x = waypoint.x
      patrolPoints[patrolIdx].y = waypoint.y
      patrolPoints[patrolIdx]:Show()

      patrolLines[patrolIdx] = patrolLines[patrolIdx] or
          MDT.main_frame.mapPanelFrame:CreateTexture("MDTDungeonPatrolLine"..patrolIdx, "BACKGROUND", nil, 0)
      patrolLines[patrolIdx]:SetDrawLayer("OVERLAY", 1)
      patrolLines[patrolIdx]:SetTexture("Interface\\AddOns\\MythicDungeonTools\\Textures\\Square_White")
      patrolLines[patrolIdx]:SetVertexColor(0, 0.2, 0.5, 0.6)
      patrolLines[patrolIdx]:Show()

      --connect 2 waypoints
      if oldWaypointBlip then
        local _, _, _, startX, startY = patrolPoints[patrolIdx]:GetPoint()
        local _, _, _, endX, endY = oldWaypointBlip:GetPoint()
        DrawLine(patrolLines[patrolIdx], MDT.main_frame.mapPanelTile1, startX, startY, endX, endY, 1 * scale, 1,
          "TOPLEFT")
        patrolLines[patrolIdx]:Show()
      else
        firstWaypointBlip = patrolPoints[patrolIdx]
      end
      oldWaypointBlip = patrolPoints[patrolIdx]
    end
    --connect last 2 waypoints
    if firstWaypointBlip and oldWaypointBlip then
      local _, _, _, startX, startY = firstWaypointBlip:GetPoint()
      local _, _, _, endX, endY = oldWaypointBlip:GetPoint()
      DrawLine(patrolLines[1], MDT.main_frame.mapPanelTile1, startX, startY, endX, endY, 1 * scale, 1, "TOPLEFT")
      patrolLines[1]:Show()
    end
  else
    --find patrol leader if no patrol
    for _, blip in pairs(blips) do
      if blip:IsShown() and blip.clone.g and self.clone.g then
        if blip.clone.g == self.clone.g and blip.clone.patrol then
          blip:DisplayPatrol(shown)
        end
      end
    end
  end
end

---Forces against health: how much of the dungeon's forces an enemy gives per health it has.
---@param count number
---@param health number
---@return number
local function efficiency(count, health)
  local totalCount = MDT.dungeonTotalCount[db.currentDungeonIdx].normal
  return 2.5 * (count / totalCount) * 13000 / (health / 20000)
end

---The current dungeon's typical efficiency: the median over its enemy types, leaving out bosses and enemies that give
---no forces. Colors compare with it, so they need no tuning when a season changes enemy health.
---@return number?
local function typicalEfficiency()
  local scores = {}
  for _, enemy in pairs(MDT.dungeonEnemies[db.currentDungeonIdx] or {}) do
    if not enemy.isBoss and (enemy.count or 0) > 0 and (enemy.health or 0) > 0 then
      scores[#scores + 1] = efficiency(enemy.count, enemy.health)
    end
  end
  if #scores == 0 then return nil end
  table.sort(scores)
  local middle = (#scores + 1) / 2
  return (scores[floor(middle)] + scores[math.ceil(middle)]) / 2
end

---An efficiency score rounded to one decimal, and its color as hex. The color rates the score against the dungeon's
---typical enemy on a ratio scale: half as efficient is red, as efficient yellow, twice as efficient green.
---@return string score
---@return string colorHex
function MDT:GetEfficiencyScore(count, health)
  local score = efficiency(count, health)
  local typical = typicalEfficiency()
  local value
  if not typical then
    value = score / 10
  elseif score <= 0 then
    value = 0
  else
    value = 0.5 + 0.5 * math.log(score / typical) / math.log(2)
  end
  value = max(0, min(1, value))
  --https://stackoverflow.com/a/7947812/17380548
  local colorHex = MDT:RGBToHex(min(1, 2 * (1 - value)), min(1, 2 * value), 0)
  return MDT:Round(score, 1), colorHex
end

function MDT:GetEfficiencyScoreString(count, health)
  local score, colorHex = MDT:GetEfficiencyScore(count, health)
  return ("|cFF%s%s|r"):format(colorHex, score)
end

function MDT:GetCurrentDevmodeBlip()
  for blipIdx, blip in pairs(blips) do
    if blip.devSelected then
      return blip
    end
  end
end

--make blip movable in devMode and store new position
local function blipDevModeSetup(blip)
  blip:SetMovable(true)
  blip:RegisterForDrag("LeftButton")

  local groupColors = {
    [1] = { 1, 0, 0, 1 },
    [2] = { 0, 1, 0, 1 },
    [3] = { 0, 0, 1, 1 },
    [4] = { 1, 0, 1, 1 },
    [5] = { 0, 1, 1, 1 },
  }
  local function updateBlipText()
    if db.devModeBlipTextHidden then
      blip.fontstring_Text1:SetText("")
      return
    end
    blip.fontstring_Text1:Show()
    blip.fontstring_Text1:SetText((blip.clone.g or "").."  "..
      WrapTextInColorCode((blip.clone.scale or ""), "ffffffff"))
    if blip.clone.g then blip.fontstring_Text1:SetTextColor(unpack(groupColors[blip.clone.g % 5 + 1])) end
  end
  blip.UpdateBlipText = updateBlipText

  local xOffset, yOffset
  blip:SetScript("OnMouseDown", function()
    local x, y = MDT:GetCursorPosition()
    local scale = MDT:GetScale()
    x = x * (1 / scale)
    y = y * (1 / scale)
    local nx = MDT.dungeonEnemies[db.currentDungeonIdx][blip.enemyIdx].clones[blip.cloneIdx].x
    local ny = MDT.dungeonEnemies[db.currentDungeonIdx][blip.enemyIdx].clones[blip.cloneIdx].y
    xOffset = x - nx
    yOffset = y - ny
  end)
  local moveGroup
  local movePatrol
  blip:SetScript("OnDragStart", function()
    if not db.devModeBlipsMovable then return end
    if IsShiftKeyDown() then
      moveGroup = true
    end
    if not IsControlKeyDown() then
      movePatrol = true
    end
    blip:StartMoving()
  end)
  blip:SetScript("OnDragStop", function()
    if not db.devModeBlipsMovable then return end
    if IsShiftKeyDown() then
      moveGroup = true
    end
    if not IsControlKeyDown() then
      movePatrol = true
    end
    local x, y = MDT:GetCursorPosition()
    local scale = MDT:GetScale()
    x = x * (1 / scale)
    y = y * (1 / scale)
    x = x - xOffset
    y = y - yOffset
    local deltaX = x - MDT.dungeonEnemies[db.currentDungeonIdx][blip.enemyIdx].clones[blip.cloneIdx].x
    local deltaY = y - MDT.dungeonEnemies[db.currentDungeonIdx][blip.enemyIdx].clones[blip.cloneIdx].y
    if moveGroup then
      for enemyIdx, data in pairs(MDT.dungeonEnemies[db.currentDungeonIdx]) do
        for cloneIdx, clone in pairs(data.clones) do
          if clone.g == blip.clone.g then
            clone.x = clone.x + deltaX
            clone.y = clone.y + deltaY
            --move blip
            local cloneBlip = MDT:GetBlip(enemyIdx, cloneIdx)
            if cloneBlip then
              cloneBlip:ClearAllPoints()
              cloneBlip:SetPoint("CENTER", MDT.main_frame.mapPanelTile1, "TOPLEFT", clone.x * scale, clone.y * scale)
            end
          end
        end
      end
    end

    if movePatrol and blip.clone.patrol then
      for patrolIdx, waypoint in pairs(blip.clone.patrol) do
        waypoint.x = waypoint.x + deltaX
        waypoint.y = waypoint.y + deltaY
        MDT.dungeonEnemies[db.currentDungeonIdx][blip.enemyIdx].clones[blip.cloneIdx].patrol[patrolIdx].x = waypoint.x
        MDT.dungeonEnemies[db.currentDungeonIdx][blip.enemyIdx].clones[blip.cloneIdx].patrol[patrolIdx].y = waypoint.y
      end
      blip:DisplayPatrol(true)
      movePatrol = nil
    end

    blip:StopMovingOrSizing()
    blip:ClearAllPoints()
    blip:SetPoint("CENTER", MDT.main_frame.mapPanelTile1, "TOPLEFT", x * scale, y * scale)
    MDT.dungeonEnemies[db.currentDungeonIdx][blip.enemyIdx].clones[blip.cloneIdx].x = x
    MDT.dungeonEnemies[db.currentDungeonIdx][blip.enemyIdx].clones[blip.cloneIdx].y = y
    moveGroup = nil
  end)
  blip:SetScript("OnMouseWheel", function(self, delta)
    if not db.devModeBlipsScrollable then return end
    -- alt scroll to scale blip and connected blips
    if IsAltKeyDown() then
      if IsShiftKeyDown() then
        -- scale whole sublevel
        for _, data in pairs(MDT.dungeonEnemies[db.currentDungeonIdx]) do
          for _, clone in pairs(data.clones) do
            if clone.sublevel == MDT:GetCurrentSubLevel() then
              clone.scale = (clone.scale or 1) + delta * 0.1
            end
          end
        end
      elseif IsControlKeyDown() then
        -- only scale this specific blip
        local clone = MDT.dungeonEnemies[db.currentDungeonIdx][self.enemyIdx].clones[self.cloneIdx]
        clone.scale = (clone.scale or 1) + delta * 0.1
      else
        -- only scale this blip and it's connected blips
        if blip.clone.g then
          for _, data in pairs(MDT.dungeonEnemies[db.currentDungeonIdx]) do
            for _, clone in pairs(data.clones) do
              if clone.g == blip.clone.g then
                clone.scale = (clone.scale or 1) + delta * 0.1
              end
            end
          end
        else
          blip.clone.scale = (blip.clone.scale or 1) + delta * 0.1
        end
      end
      MDT:UpdateMap()
    else
      if not blip.clone.g then
        local maxGroup = 0
        for _, data in pairs(MDT.dungeonEnemies[db.currentDungeonIdx]) do
          for _, clone in pairs(data.clones) do
            maxGroup = (clone.g and (clone.g > maxGroup)) and clone.g or maxGroup
          end
        end
        if IsControlKeyDown() then
          maxGroup = maxGroup + 1
        end
        blip.clone.g = maxGroup
      else
        local blipGroup = blip.clone.g
        if IsShiftKeyDown() then
          --change group of all connected blips
          for enemyIdx, data in pairs(MDT.dungeonEnemies[db.currentDungeonIdx]) do
            for cloneIdx, clone in pairs(data.clones) do
              if clone.g == blipGroup then
                clone.g = blipGroup + delta
                local cloneBlip = MDT:GetBlip(enemyIdx, cloneIdx)
                cloneBlip.UpdateBlipText()
              end
            end
          end
        else
          blip.clone.g = blip.clone.g + delta
          updateBlipText()
        end
      end
    end
  end)
  updateBlipText()
end

local function resetBlipDevModeSetup(blip)
  blip.textLocked = nil
  blip.fontstring_Text1:Hide()
  if blip.devModeSetup then
    blip.devSelected = nil
    blip.UpdateBlipText = nil
    blip.fontstring_Text1:SetTextColor(1, 1, 1, 1)
    setUpMouseHandlers(blip)
    blip:SetScript("OnMouseWheel", nil)
    blip:SetMovable(false)
    blip.devModeSetup = nil
  end
end

function MDTDungeonEnemyMixin:SetUp(data, clone, overlapCandidates, currentPreset)
  local scale = MDT:GetScale()
  self:ClearAllPoints()
  self:SetPoint("CENTER", MDT.main_frame.mapPanelTile1, "TOPLEFT", clone.x * scale, clone.y * scale)
  if not self.setupInitialized then
    self.texture_Portrait:SetDesaturated(false)
    self.texture_MouseHighlight:SetAlpha(0.4)
    MDT.UI.Fonts.Apply(self.fontstring_Text1, 12)
    setUpMouseHandlers(self)
    self.setupInitialized = true
  end
  local cloneScale = clone.scale or 1
  local normalScale = cloneScale * data.scale * (data.isBoss and 1.7 or 1) *
      (MDT.scaleMultiplier[db.currentDungeonIdx] or 1) * scale * 0.6
  if self.normalScale ~= normalScale or self.sizesDirty then
    self.normalScale = normalScale
    self.sizesDirty = nil
    self:SetSize(normalScale * BLIP_FRAME_SIZE, normalScale * BLIP_FRAME_SIZE)
    self:updateSizes(1)
    local textScale = math.max(0.2, normalScale * 10)
    MDT.UI.Fonts.Apply(self.fontstring_Text1, textScale, "OUTLINE")
  end
  self:SetFrameLevelAboveOverlaps(overlapCandidates)
  local count = MDT:GetCloneEnemyForces(data, clone)
  self.fontstring_Text1:SetText((clone.isBoss and count == 0 and "") or count)
  local isBoss = data.isBoss and true or false
  if self.isBoss ~= isBoss then
    self.isBoss = isBoss
    if isBoss then self.texture_Dragon:Show() else self.texture_Dragon:Hide() end
  end
  local hasPatrol = clone.patrol and true or false
  if self.hasPatrol ~= hasPatrol then
    self.hasPatrol = hasPatrol
    if hasPatrol then
      self.texture_Background:SetVertexColor(unpack(patrolColor))
    else
      self.texture_Background:SetVertexColor(1, 1, 1, 1)
    end
  end
  self.data = data
  self.clone = clone
  self:Show()
  self:SetScript("OnUpdate", nil)
  tinsert(blips, self)
  -- A reused frame may still show a spell icon for the enemy it had before.
  if self.spellPortrait then
    self.spellPortrait, self.portrait = nil, nil
    self.texture_Portrait:SetTexCoord(0, 1, 0, 1)
  end
  local portrait = data.iconTexture or data.displayId or 39490
  local portraitIsTexture = data.iconTexture and true or false
  if self.portrait ~= portrait or self.portraitIsTexture ~= portraitIsTexture then
    self.portrait = portrait
    self.portraitIsTexture = portraitIsTexture
    if portraitIsTexture then
      self.texture_Portrait:SetTexture(portrait)
    else
      SetPortraitTextureFromCreatureDisplayID(self.texture_Portrait, portrait)
    end
  end
  self.texture_Indicator:Hide()
  local assignments = (currentPreset or MDT:GetCurrentPreset()).value.enemyAssignments
  local assignment = assignments and assignments[self.enemyIdx] and assignments[self.enemyIdx][self.cloneIdx]
  if not self.assignmentInitialized or self.assignment ~= assignment then
    self.assignmentInitialized = true
    self.assignment = assignment
    if assignment then
      self.texture_OverlayIcon:Show()
      if assignment >= 1 and assignment <= 8 then
        self.texture_OverlayIcon:SetTexture("Interface\\TargetingFrame\\UI-RaidTargetingIcon_"..assignment)
      else
        --TODO: other pre set icons, sheep, sap etc they will have specific indexes
      end
    else
      self.texture_OverlayIcon:Hide()
    end
  end
  if db.devMode then
    blipDevModeSetup(self)
    self.devModeSetup = true
  else
    resetBlipDevModeSetup(self)
  end
end

---DungeonEnemies_HideAllBlips
---Used to hide blips during scaling changes to the map
function MDT:DungeonEnemies_HideAllBlips()
  MDT.dungeonEnemyDragPreview_framePool:ReleaseAll()
  MDT.dungeonEnemies_framePool:ReleaseAll()
end

function MDT:DungeonEnemies_UpdateEnemiesAsync()
  MDT.dungeonEnemyDragPreview_framePool:ReleaseAll()
  MDT.dungeonEnemies_framePool:ReleaseAll()
  coroutine.yield()
  twipe(blips)
  if not db then db = MDT:GetDB() end
  local enemies = MDT.dungeonEnemies[db.currentDungeonIdx]
  if not enemies then return end
  preset = MDT:GetCurrentPreset()

  local currentSublevel = MDT:GetCurrentSubLevel()
  local overlapBuckets = {}
  local overlapCandidates = {}
  local visibleEnemies = {}
  local overlapBucketSize = MIN_OVERLAP_BUCKET_SIZE
  local dungeonScale = MDT.scaleMultiplier[db.currentDungeonIdx] or 1

  for enemyIdx, data in pairs(enemies) do
    for cloneIdx, clone in pairs(data["clones"]) do
      --check sublevel
      if clone.sublevel == currentSublevel or (not clone.sublevel) then
        local visualScale = (clone.scale or 1) * data.scale * (data.isBoss and 1.7 or 1)
        overlapBucketSize = max(overlapBucketSize, visualScale * dungeonScale * 0.6 * BLIP_VISUAL_SIZE)
        tinsert(visibleEnemies, {
          enemyIdx = enemyIdx,
          cloneIdx = cloneIdx,
          data = data,
          clone = clone,
        })
      end
    end
  end
  table.sort(visibleEnemies, function(a, b)
    if a.enemyIdx ~= b.enemyIdx then return a.enemyIdx < b.enemyIdx end
    return a.cloneIdx < b.cloneIdx
  end)
  for _, enemy in ipairs(visibleEnemies) do
    local clone = enemy.clone
    twipe(overlapCandidates)
    local bucketX = floor(clone.x / overlapBucketSize)
    local bucketY = floor(clone.y / overlapBucketSize)
    for x = bucketX - 1, bucketX + 1 do
      local column = overlapBuckets[x]
      if column then
        for y = bucketY - 1, bucketY + 1 do
          local bucket = column[y]
          if bucket then
            for _, candidate in ipairs(bucket) do
              tinsert(overlapCandidates, candidate)
            end
          end
        end
      end
    end
    local blip = MDT.dungeonEnemies_framePool:Acquire()
    blip.enemyIdx = enemy.enemyIdx
    blip.cloneIdx = enemy.cloneIdx
    blip:SetUp(enemy.data, clone, overlapCandidates, preset)
    local column = overlapBuckets[bucketX]
    if not column then
      column = {}
      overlapBuckets[bucketX] = column
    end
    local bucket = column[bucketY]
    if not bucket then
      bucket = {}
      column[bucketY] = bucket
    end
    tinsert(bucket, blip)
    coroutine.yield()
  end
end

function MDT:DungeonEnemies_CreateFramePools()
  db = self:GetDB()
  MDT.dungeonEnemies_framePool = MDT.CreateFramePool("Button", MDT.main_frame.mapPanelFrame, "MDTDungeonEnemyTemplate")
  MDT.dungeonEnemyDragPreview_framePool = MDT.CreateFramePool("Frame", MDT.main_frame.mapPanelFrame,
    "MDTDungeonEnemyDragPreviewTemplate")
end

function MDT:GetBlip(enemyIdx, cloneIdx)
  for blipIdx, blip in pairs(blips) do
    if blip.enemyIdx == enemyIdx and blip.cloneIdx == cloneIdx then
      return blip
    end
  end
end

local function isCloneConstrained(clone)
  if not clone.constrained then return false end
  local amount = 0
  local data = MDT.dungeonEnemies[db.currentDungeonIdx]
  for enemyIdx, enemy in pairs(data) do
    for cloneIdx, c in pairs(enemy.clones) do
      if c.constrained and c.constrained.index == clone.constrained.index and MDT:IsCloneInPulls(enemyIdx, cloneIdx) then
        amount = amount + 1
      end
    end
  end
  if amount >= clone.constrained.amount then
    print(L["MDT: Cannot add enemy - you are trying to add too many enemies of the same kind"])
    return true
  end
  return false
end

---DungeonEnemies_AddOrRemoveBlipToCurrentPull
---Adds or removes an enemy clone and all it's linked npcs to the currently selected pull
function MDT:DungeonEnemies_AddOrRemoveBlipToCurrentPull(blip, add, ignoreGrouped, pulls, pull, ignoreUpdates)
  local preset = self:GetCurrentPreset()
  local enemyIdx = blip.enemyIdx
  local cloneIdx = blip.cloneIdx
  pull = pull or preset.value.currentPull
  pulls = pulls or preset.value.pulls or {}
  pulls[pull] = pulls[pull] or {}
  pulls[pull][enemyIdx] = pulls[pull][enemyIdx] or {}
  --remove clone from all other pulls first
  for pullIdx, p in pairs(pulls) do
    if pullIdx ~= pull and p[enemyIdx] then
      for k, v in pairs(p[enemyIdx]) do
        if v == cloneIdx then
          tremove(pulls[pullIdx][enemyIdx], k)
        end
      end
    end
  end
  if add then
    if isCloneConstrained(blip.clone) then return end
    if blip then blip.selected = true end
    local found = false
    for _, v in pairs(pulls[pull][enemyIdx]) do
      if v == cloneIdx then found = true end
    end
    if found == false and blip:IsEnabled() then
      tinsert(pulls[pull][enemyIdx], cloneIdx)
    end
  else
    blip.selected = false
    for k, v in pairs(pulls[pull][enemyIdx]) do
      if v == cloneIdx then
        tremove(pulls[pull][enemyIdx], k)
      end
    end
  end
  --linked npcs
  if not ignoreGrouped then
    for idx, otherBlip in pairs(blips) do
      if blip.clone.g and otherBlip.clone.g == blip.clone.g and blip ~= otherBlip then
        self:DungeonEnemies_AddOrRemoveBlipToCurrentPull(otherBlip, add, true, pulls, pull, ignoreUpdates)
      end
    end
  end
end

local BOX_SELECTION_MIN_DRAG = 4
local BOX_SELECTION_UPDATE_INTERVAL = 0.05
local boxSelection

local function getBoxSelectionFrame()
  local frame = MDT.main_frame.boxSelectionFrame
  if frame then return frame end
  frame = CreateFrame("Frame", nil, MDT.main_frame.mapPanelFrame)
  frame:SetFrameStrata("HIGH")
  frame:SetFrameLevel(110)
  frame:EnableMouse(false)
  frame.fill = frame:CreateTexture(nil, "ARTWORK")
  frame.fill:SetAllPoints()
  frame.fill:SetColorTexture(0.2, 0.55, 0.95, 0.25)
  frame.edges = {}
  for i = 1, 4 do
    local edge = frame:CreateTexture(nil, "OVERLAY")
    edge:SetColorTexture(0.35, 0.7, 1, 0.9)
    frame.edges[i] = edge
  end
  frame.edges[1]:SetPoint("TOPLEFT")
  frame.edges[1]:SetPoint("TOPRIGHT")
  frame.edges[2]:SetPoint("BOTTOMLEFT")
  frame.edges[2]:SetPoint("BOTTOMRIGHT")
  frame.edges[3]:SetPoint("TOPLEFT")
  frame.edges[3]:SetPoint("BOTTOMLEFT")
  frame.edges[4]:SetPoint("TOPRIGHT")
  frame.edges[4]:SetPoint("BOTTOMRIGHT")
  frame:SetScript("OnHide", function()
    if boxSelection then MDT:DungeonEnemies_StopBoxSelection(true) end
  end)
  frame:Hide()
  MDT.main_frame.boxSelectionFrame = frame
  return frame
end

local function updateBoxSelectionFrame(frame, minX, maxX, minY, maxY)
  local anchor = MDT.main_frame.mapPanelTile1
  local thickness = 1.5 / MDT.main_frame.mapPanelFrame:GetScale()
  frame:ClearAllPoints()
  frame:SetPoint("TOPLEFT", anchor, "TOPLEFT", minX, maxY)
  frame:SetPoint("BOTTOMRIGHT", anchor, "TOPLEFT", maxX, minY)
  frame.edges[1]:SetHeight(thickness)
  frame.edges[2]:SetHeight(thickness)
  frame.edges[3]:SetWidth(thickness)
  frame.edges[4]:SetWidth(thickness)
end

---Adds every unpulled enemy inside the box (and its group unless ignoreGrouped) to the current pull of pulls
---Returns a key identifying the added clones and whether any were skipped due to constraints
local function applyBoxSelection(pulls, pull, minX, maxX, minY, maxY, ignoreGrouped)
  local pulledClones = {}
  local constrainedCounts = {}
  for _, p in pairs(pulls) do
    for enemyIdx, clones in pairs(p) do
      if tonumber(enemyIdx) then
        for _, cloneIdx in pairs(clones) do
          pulledClones[enemyIdx.."-"..cloneIdx] = true
          local enemy = MDT.dungeonEnemies[db.currentDungeonIdx][enemyIdx]
          local clone = enemy and enemy.clones[cloneIdx]
          if clone and clone.constrained then
            local index = clone.constrained.index
            constrainedCounts[index] = (constrainedCounts[index] or 0) + 1
          end
        end
      end
    end
  end

  local addedKeys = {}
  local skippedConstrained = false
  local function addBlip(blip)
    local key = blip.enemyIdx.."-"..blip.cloneIdx
    if pulledClones[key] or not blip:IsShown() or not blip:IsEnabled() then return end
    local constrained = blip.clone.constrained
    if constrained then
      if (constrainedCounts[constrained.index] or 0) >= constrained.amount then
        skippedConstrained = true
        return
      end
      constrainedCounts[constrained.index] = (constrainedCounts[constrained.index] or 0) + 1
    end
    pulledClones[key] = true
    tinsert(addedKeys, key)
    pulls[pull] = pulls[pull] or {}
    pulls[pull][blip.enemyIdx] = pulls[pull][blip.enemyIdx] or {}
    tinsert(pulls[pull][blip.enemyIdx], blip.cloneIdx)
  end

  for _, blip in ipairs(blips) do
    local _, _, _, blipX, blipY = blip:GetPoint()
    local radius = defaultSizes.texture_Background * blip.normalScale / 2
    if blipX and blipX + radius >= minX and blipX - radius <= maxX and blipY + radius >= minY and blipY - radius <= maxY then
      if not pulledClones[blip.enemyIdx.."-"..blip.cloneIdx] then
        addBlip(blip)
        if not ignoreGrouped and blip.clone.g then
          for _, otherBlip in ipairs(blips) do
            if otherBlip.clone.g == blip.clone.g then addBlip(otherBlip) end
          end
        end
      end
    end
  end
  return table.concat(addedKeys, ","), skippedConstrained
end

local function updateBoxSelection(force)
  local selection = boxSelection
  local x, y = MDT:GetCursorPosition()
  if not selection.active then
    local zoom = MDT.main_frame.mapPanelFrame:GetScale()
    if ((x - selection.startX) ^ 2 + (y - selection.startY) ^ 2) * zoom ^ 2 < BOX_SELECTION_MIN_DRAG ^ 2 then return end
    selection.active = true
    selection.frame:Show()
  end
  local minX, maxX = min(selection.startX, x), max(selection.startX, x)
  local minY, maxY = min(selection.startY, y), max(selection.startY, y)
  updateBoxSelectionFrame(selection.frame, minX, maxX, minY, maxY)

  local ignoreGrouped = IsControlKeyDown()
  if not force and selection.elapsed < BOX_SELECTION_UPDATE_INTERVAL and ignoreGrouped == selection.ignoreGrouped then return end
  selection.elapsed = 0
  selection.ignoreGrouped = ignoreGrouped
  local basePulls = selection.preset.value.pulls
  local tempPulls = CopyTable(basePulls)
  local key, skippedConstrained = applyBoxSelection(tempPulls, selection.preset.value.currentPull, minX, maxX, minY, maxY,
    ignoreGrouped)
  selection.skippedConstrained = skippedConstrained
  --always keep the latest copy so pulls changed mid drag (e.g. by a live session) are not overwritten on commit
  selection.tempPulls = tempPulls
  if key == selection.key and basePulls == selection.basePulls then return end
  selection.key = key
  selection.basePulls = basePulls
  MDT:DungeonEnemies_UpdateSelected(selection.preset.value.currentPull, tempPulls)
  MDT:DrawAllHulls(CopyTable(tempPulls))
end

---Starts a box selection on the map at the cursor position
---Enemies inside the box are previewed in the current pull and only added when the selection is stopped
function MDT:DungeonEnemies_StartBoxSelection()
  if boxSelection then self:DungeonEnemies_StopBoxSelection(true) end
  preset = self:GetCurrentPreset()
  local x, y = self:GetCursorPosition()
  local frame = getBoxSelectionFrame()
  boxSelection = {
    preset = preset,
    sublevel = self:GetCurrentSubLevel(),
    startX = x,
    startY = y,
    elapsed = 0,
    key = "",
    frame = frame,
  }
  local updater = MDT.main_frame.boxSelectionUpdater or CreateFrame("Frame", nil, MDT.main_frame.mapPanelFrame)
  MDT.main_frame.boxSelectionUpdater = updater
  updater:SetScript("OnUpdate", function(_, elapsed)
    if not boxSelection then return end
    --mouse up may not reach the map (e.g. a toolbar tool took over its scripts mid drag)
    if not IsMouseButtonDown("LeftButton") then
      MDT:DungeonEnemies_StopBoxSelection()
      return
    end
    --box coordinates are meaningless on another sublevel
    if MDT:GetCurrentSubLevel() ~= boxSelection.sublevel then
      MDT:DungeonEnemies_StopBoxSelection(true)
      return
    end
    boxSelection.elapsed = boxSelection.elapsed + elapsed
    updateBoxSelection()
  end)
end

function MDT:DungeonEnemies_IsBoxSelecting()
  return boxSelection ~= nil
end

---Stops the box selection and adds the selected enemies to the current pull unless cancelled
function MDT:DungeonEnemies_StopBoxSelection(cancel)
  local selection = boxSelection
  if not selection then return end
  if not cancel and selection.active then updateBoxSelection(true) end
  boxSelection = nil
  MDT.main_frame.boxSelectionUpdater:SetScript("OnUpdate", nil)
  selection.frame:Hide()
  if not selection.basePulls then return end
  MDT:CancelAsync("DrawAllHulls")
  if cancel or selection.key == "" then
    MDT:DungeonEnemies_UpdateSelected(MDT:GetCurrentPull())
    MDT:DrawAllHulls(nil, true)
    return
  end
  if selection.skippedConstrained then
    print(L["MDT: Cannot add enemy - you are trying to add too many enemies of the same kind"])
  end
  selection.preset.value.pulls = selection.tempPulls
  MDT:DungeonEnemies_UpdateSelected(MDT:GetCurrentPull())
  MDT:RefreshSidebar()
  MDT:DrawAllHulls(nil, true)
  if MDT.liveSessionActive and MDT:GetCurrentPreset().uid == MDT.livePresetUID then
    MDT:LiveSession_SendPulls(MDT:GetPulls())
  end
end

---DungeonEnemies_UpdateBlipColors
---Updates the colors of all selected blips of the specified pull
function MDT:DungeonEnemies_UpdateBlipColors(pull, r, g, b, pulls)
  pulls = pulls or preset.value.pulls
  local p = pulls[pull]
  if not p then return end
  for enemyIdx, clones in pairs(p) do
    if tonumber(enemyIdx) then
      for _, cloneIdx in pairs(clones) do
        for _, blip in pairs(blips) do
          if (blip.enemyIdx == enemyIdx) and (blip.cloneIdx == cloneIdx) then
            if not db.devMode then
              tintPortrait(blip, r, g, b)
              blip.texture_SelectedHighlight:SetVertexColor(r, g, b, 0.7)
            end
            break
          end
        end
      end
    end
  end
end

---Updates the selected Enemies on the map and marks them according to their pull color
function MDT:DungeonEnemies_UpdateSelected(pull, pulls, ignoreHulls)
  preset = MDT:GetCurrentPreset()
  pulls = pulls or preset.value.pulls
  --deselect all
  for _, blip in pairs(blips) do
    blip.texture_SelectedHighlight:Hide()
    blip.selected = false
    blip.texture_PullIndicator:Hide()
    if not db.devMode then
      tintPortrait(blip, 1, 1, 1)
    end
  end
  --highlight all pull enemies
  for pullIdx, p in pairs(pulls) do
    local r, g, b = MDT:DungeonEnemies_GetPullColor(pullIdx)
    for enemyIdx, clones in pairs(p) do
      if tonumber(enemyIdx) then
        for _, cloneIdx in pairs(clones) do
          for _, blip in pairs(blips) do
            if (blip.enemyIdx == enemyIdx) and (blip.cloneIdx == cloneIdx) then
              blip.texture_SelectedHighlight:Show()
              blip.selected = true
              if not db.devMode then
                tintPortrait(blip, r, g, b)
                blip.texture_SelectedHighlight:SetVertexColor(r, g, b, 0.7)
              end
              if pullIdx == pull then
                blip.texture_PullIndicator:Show()
              end
              break
            end
          end
        end
      end
    end
  end
  -- if not ignoreHulls then MDT:DrawAllHulls(pulls) end
end

---DungeonEnemies_SetPullColor
---Sets a custom color for a pull
function MDT:DungeonEnemies_SetPullColor(pull, r, g, b)
  preset = MDT:GetCurrentPreset()
  if not preset.value.pulls[pull] then return end
  preset.value.pulls[pull]["color"] = MDT:RGBToHex(r, g, b)
end

---DungeonEnemies_GetPullColor
---Returns the custom color for a pull
function MDT:DungeonEnemies_GetPullColor(pull, pulls)
  pulls = pulls or preset.value.pulls
  local r, g, b = MDT:HexToRGB(pulls[pull]["color"])
  if not r then
    r, g, b = MDT:HexToRGB("228b22")
    MDT:DungeonEnemies_SetPullColor(pull, r, g, b)
  end
  return r, g, b
end

function MDT:IsCloneInPulls(enemyIdx, cloneIdx)
  local pulls = MDT:GetCurrentPreset().value.pulls
  local numClones = 0
  for _, pull in pairs(pulls) do
    if pull[enemyIdx] then
      if cloneIdx then
        for _, pullCloneIndex in pairs(pull[enemyIdx]) do
          if pullCloneIndex == cloneIdx then return true end
        end
      else
        for _, pullCloneIndex in pairs(pull[enemyIdx]) do
          numClones = numClones + 1
        end
      end
    end
  end
  return numClones > 0
end

local function ArrayRemove(t, fnKeep)
  local j, n = 1, #t;

  for i = 1, n do
    if (fnKeep(t, i, j)) then
      -- Move i's kept value to j's position, if it's not already there.
      if (i ~= j) then
        t[j] = t[i];
        t[i] = nil;
      end
      j = j + 1; -- Increment position of where we'll place the next kept value.
    else
      t[i] = nil;
    end
  end

  return t;
end

---removes enemies of the current dungeon without any clones
function MDT:CleanEnemyData(dungeonIdx)
  local enemies = MDT.dungeonEnemies[dungeonIdx]
  ArrayRemove(enemies, function(t, i, j)
    local countClones = 0
    for _, _ in pairs(t[i].clones) do
      countClones = countClones + 1
    end
    return countClones > 0
  end)
end
