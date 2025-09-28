local MDT = MDT
local db
local tonumber, tinsert, pairs, ipairs, tostring, twipe, max, tremove, DrawLine = tonumber, table.insert, pairs, ipairs,
    tostring, table.wipe, math.max, table.remove, DrawLine
local L = MDT.L
local blips = {}
local preset
local patrolColor = { 0, 0.5, 1, 0.8 }

function MDT:GetDungeonEnemyBlips()
  return blips
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
}

function MDTDungeonEnemyMixin:updateSizes(scale)
  for tex, size in pairs(defaultSizes) do
    self[tex]:SetSize(size * self.normalScale * scale, size * self.normalScale * scale)
  end
end

function MDT:DisplayBlipModifierLabels(modifier)
  for _, blip in pairs(blips) do
    blip.textLocked = true
    local text = (modifier == "alt" and blip.clone.g and "G"..blip.clone.g) or (modifier == "ctrl" and blip.data.count) or ""
    blip.fontstring_Text1:SetText(text)
    blip.fontstring_Text1:Show()
  end
end

function MDT:HideAllBlipLabels()
  for _, blip in pairs(blips) do
    if not blip.textLocked then return end
    blip.fontstring_Text1:Hide()
    blip.textLocked = nil
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
      local overMDT = MouseIsOver(frame) or MouseIsOver(frame.sidePanel) or MouseIsOver(frame.topPanel) or MouseIsOver(frame.bottomPanel)
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
  self:updateSizes(1.2)
  self:SetFrameLevel(self:GetFrameLevel() + 5)
  self:DisplayPatrol(true)
  MDT:DisplayBlipTooltip(self, true)
  if not db.devMode then
    if self.textLocked then return end
    self.fontstring_Text1:SetText(self.data.count)
    self.fontstring_Text1:Show()
    if self.clone.g then
      for _, blip in pairs(blips) do
        if blip.clone.g == self.clone.g then
          blip.fontstring_Text1:SetText(blip.data.count)
          blip.fontstring_Text1:Show()
        end
      end
    end
  end
end

function MDTDungeonEnemyMixin:OnLeave()
  self:updateSizes(1)
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

local function setUpMouseHandlers(self)
  self:SetScript("OnMouseDown", function(self, button)

  end)
  local tempPulls
  local targetPull
  self:SetScript("OnDragStart", function()
    local x, y, scale
    preset = MDT:GetCurrentPreset()
    tempPulls = MDT:DeepCopy(preset.value.pulls)
    targetPull = nil
    local _, _, _, blipX, blipY = self:GetPoint()
    self:SetScript("OnUpdate", function()
      local nx, ny = MDT:GetCursorPosition()
      if x ~= nx or y ~= ny then
        x, y = nx, ny
        --find closest pull and measure distance
        local pullIdx, centerX, centerY = MDT:FindClosestPull(x, y)
        if not centerX then return end
        local distBlip = (centerX - blipX) ^ 2 + (centerY - blipY) ^ 2
        local distCursor = (centerX - x) ^ 2 + (centerY - y) ^ 2
        local isClose = distCursor < 1 / 3 * distBlip or distBlip < 150
        if not isClose then
          targetPull = nil
          MDT:DungeonEnemies_AddOrRemoveBlipToCurrentPull(self, false, IsControlKeyDown(), tempPulls, nil, true)
          MDT:DungeonEnemies_UpdateSelected(MDT:GetCurrentPull(), tempPulls)
        elseif pullIdx ~= targetPull then
          targetPull = pullIdx
          MDT:DungeonEnemies_AddOrRemoveBlipToCurrentPull(self, true, IsControlKeyDown(), tempPulls, pullIdx, true)
          MDT:DungeonEnemies_UpdateSelected(MDT:GetCurrentPull(), tempPulls)
        end
      end
    end)
  end)
  self:SetScript("OnDragStop", function()
    self:SetScript("OnUpdate", nil)
    preset.value.pulls = tempPulls
    MDT:DungeonEnemies_UpdateSelected(MDT:GetCurrentPull(), tempPulls)
    MDT:SetSelectionToPull(targetPull)
    MDT:ReloadPullButtons()
    MDT:UpdateProgressbar()
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
  MenuUtil.CreateContextMenu(MDT.main_frame, function(ownerRegion, rootDescription)
    rootDescription:CreateTitle(L[frame.data.name])

    local function IsSelected(data)
      local assignment = assignments[data.enemyIdx] and assignments[data.enemyIdx][data.cloneIdx]
      return assignment and assignment == data.index or false
    end
    local function SetSelected(data)
      assignments[data.enemyIdx] = assignments[data.enemyIdx] or {}
      assignments[data.enemyIdx][data.cloneIdx] = data.index ~= 0 and data.index or nil
      frame:SetUp(frame.data, frame.clone)
      if not db.hasSeenAssignmentWarning then
        MDT:OpenConfirmationFrame(450, 150, L["Warning"], L["Okay"], L["assignmentWarning"])
        db.hasSeenAssignmentWarning = true
      end
    end
    local submenu = rootDescription:CreateButton(L["Set Target Marker"], function() end);
    for i = 1, 8 do
      local iconPath = ICON_LIST[i].."16:16:|t"
      local color = CreateColor(unpack(iconColors[i]))
      local iconName = WrapTextInColor(_G["RAID_TARGET_"..i], color)
      submenu:CreateRadio(iconPath.." "..iconName, IsSelected, SetSelected, { enemyIdx = frame.enemyIdx, cloneIdx = frame.cloneIdx, index = i })
    end
    submenu:CreateRadio(L["None"], IsSelected, SetSelected, { enemyIdx = frame.enemyIdx, cloneIdx = frame.cloneIdx, index = 0 })
    submenu:CreateButton(L["Clear all Markers"], function()
      twipe(assignments)
      MDT:Async(function()
        MDT:DungeonEnemies_UpdateEnemiesAsync()
      end, "ClearAllMarkers")
    end)
    rootDescription:CreateButton(L["Open Enemy Info"], function()
      MDT:ShowEnemyInfoFrame(frame)
    end)
  end)
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
    MDT:UpdateProgressbar()
    MDT:ReloadPullButtons()
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

local ranOnce
function MDT:DisplayBlipTooltip(blip, shown)
  if not ranOnce then
    MDT.tooltip:ClearAllPoints()
    MDT.tooltip:SetPoint("TOPLEFT", UIParent, "BOTTOMRIGHT")
    MDT.tooltip:SetPoint("BOTTOMRIGHT", UIParent, "BOTTOMRIGHT")
    MDT.tooltip:Show()
    MDT.tooltip:Hide()
    ranOnce = true
  end

  local tooltip = MDT.tooltip
  local data = blip.data
  if shown then
    tooltip.Model:SetCreature(data.id)
    tooltip.Model:SetPosition(0, 0, 0)
    tooltip.String:Show()
    tooltip:Show()
  else
    tooltip.String:Hide()
    tooltip:Hide()
    return
  end

  local boss = blip.data.isBoss or false
  local health = MDT:CalculateEnemyHealth(boss, data.health, db.currentDifficulty, data.ignoreFortified)
  local group = blip.clone.g and " "..string.format(L["(G %d)"], blip.clone.g) or ""
  local occurence = (blip.data.isBoss and "") or blip.cloneIdx

  if not L[data.name] then print("MDT: Could not find localization for "..data.name) end
  local text = L[data.name]..
      " "..
      occurence..
      group..
      "\n"..
      string.format(L["Level %d %s"], data.level, L[data.creatureType]).." "..data.id..
      "\n"..string.format(L["%s HP"], MDT:FormatEnemyHealth(health)).."\n"

  if db.devMode then
    text = L["devModeShiftDragHint"].."\n"..L["devModeCtrlDragHint"].."\n\n"..text
  end

  local count = data.count
  text = text..L["Forces"]..": "..MDT:FormatEnemyForces(count)
  text = text.."\n"..L["Efficiency Score"]..": "..MDT:GetEfficiencyScoreString(count, data.health)
  text = text.."\n\n["..L["Right click for more info"].."]"
  tooltip.String:SetText(text)

  tooltip:ClearAllPoints()
  if db.tooltipInCorner then
    tooltip:SetPoint("BOTTOMRIGHT", MDT.main_frame, "BOTTOMRIGHT", 0, 0)
    tooltip:SetPoint("TOPLEFT", MDT.main_frame, "BOTTOMRIGHT", -tooltip.mySizes.x, tooltip.mySizes.y)
  else
    --check for bottom clipping
    tooltip:ClearAllPoints()
    tooltip:SetPoint("TOPLEFT", blip, "BOTTOMRIGHT", 30, 0)
    tooltip:SetPoint("BOTTOMRIGHT", blip, "BOTTOMRIGHT", 30 + tooltip.mySizes.x, -tooltip.mySizes.y)
    local bottomOffset = 0
    local rightOffset = 0
    local tooltipBottom = tooltip:GetBottom()
    local mainFrameBottom = MDT.main_frame:GetBottom()
    if tooltipBottom < mainFrameBottom then
      bottomOffset = tooltip.mySizes.y
    end
    --right side clipping
    local tooltipRight = tooltip:GetRight()
    local mainFrameRight = MDT.main_frame:GetRight()
    if tooltipRight > mainFrameRight then
      rightOffset = -(tooltip.mySizes.x + 60)
    end

    tooltip:SetPoint("TOPLEFT", blip, "BOTTOMRIGHT", 30 + rightOffset, bottomOffset)
    tooltip:SetPoint("BOTTOMRIGHT", blip, "BOTTOMRIGHT", 30 + tooltip.mySizes.x + rightOffset,
      -tooltip.mySizes.y + bottomOffset)
  end
end

function MDT:GetEfficiencyScoreString(count, health)
  local totalCount = MDT.dungeonTotalCount[db.currentDungeonIdx].normal
  local score = 2.5 * (count / totalCount) * 13000 / (health / 1000000)
  local formattedScore = MDT:Round(score, 1)
  local value = score / 10
  --https://stackoverflow.com/a/7947812/17380548
  local colorHex = MDT:RGBToHex(math.max(0, math.min(1, 2 * (1 - value))), math.min(1, 2 * value), 0)
  return ("|cFF%s%s|r"):format(colorHex, formattedScore)
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

function MDTDungeonEnemyMixin:SetUp(data, clone)
  local scale = MDT:GetScale()
  self:ClearAllPoints()
  self:SetPoint("CENTER", MDT.main_frame.mapPanelTile1, "TOPLEFT", clone.x * scale, clone.y * scale)
  local cloneScale = clone.scale or 1
  self.normalScale = cloneScale * data.scale * (data.isBoss and 1.7 or 1) *
      (MDT.scaleMultiplier[db.currentDungeonIdx] or 1) * scale
  self.normalScale = self.normalScale * 0.6
  self:SetSize(self.normalScale * 13, self.normalScale * 13)
  self:updateSizes(1)
  self.texture_Portrait:SetDesaturated(false)
  local raise = 4
  for k, v in pairs(blips) do
    --only check neighboring blips - saves performance on big maps
    if ((clone.x - v.clone.x) ^ 2 + (clone.y - v.clone.y) ^ 2 < 81) and MDT:DoFramesOverlap(self, v, 5) then
      raise = max(raise
      , v:GetFrameLevel() + 1)
    end
  end
  self:SetFrameLevel(raise)
  self.fontstring_Text1:SetFontObject("GameFontNormal")
  local textScale = math.max(0.2, self.normalScale * 10)
  self.fontstring_Text1:SetFont(self.fontstring_Text1:GetFont(), textScale, "OUTLINE", "")
  self.fontstring_Text1:SetText((clone.isBoss and data.count == 0 and "") or data.count)
  self.texture_MouseHighlight:SetAlpha(0.4)
  if data.isBoss then self.texture_Dragon:Show() else self.texture_Dragon:Hide() end
  self.texture_Background:SetVertexColor(1, 1, 1, 1)
  if clone.patrol then self.texture_Background:SetVertexColor(unpack(patrolColor)) end
  self.data = data
  self.clone = clone
  self:Show()
  self:SetScript("OnUpdate", nil)
  self:SetMovable(false)
  setUpMouseHandlers(self)
  tinsert(blips, self)
  if db.enemyStyle == 2 then
    self.texture_Portrait:SetTexture("Interface\\Worldmap\\WorldMapPartyIcon")
  else
    if data.iconTexture then
      SetPortraitToTexture(self.texture_Portrait, data.iconTexture);
    else
      SetPortraitTextureFromCreatureDisplayID(self.texture_Portrait, data.displayId or 39490)
    end
  end
  self.texture_Indicator:Hide()
  local assignments = MDT:GetCurrentPreset().value.enemyAssignments
  local assignment = assignments and assignments[self.enemyIdx] and assignments[self.enemyIdx][self.cloneIdx]
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
  if db.devMode then blipDevModeSetup(self) end
end

---DungeonEnemies_IsAnyBlipMoving
function MDT:DungeonEnemies_IsAnyBlipMoving()
  local isAnyMoving
  for blipIdx, blip in pairs(blips) do
    if blip:IsDragging() then
      isAnyMoving = true
      break
    end
  end
  return isAnyMoving
end

---DungeonEnemies_HideAllBlips
---Used to hide blips during scaling changes to the map
function MDT:DungeonEnemies_HideAllBlips()
  MDT.dungeonEnemies_framePool:ReleaseAll()
end

function MDT:DungeonEnemies_UpdateEnemiesAsync()
  MDT.dungeonEnemies_framePool:ReleaseAll()
  coroutine.yield()
  twipe(blips)
  if not db then db = MDT:GetDB() end
  local enemies = MDT.dungeonEnemies[db.currentDungeonIdx]
  if not enemies then return end
  preset = MDT:GetCurrentPreset()

  local currentSublevel = MDT:GetCurrentSubLevel()

  for enemyIdx, data in pairs(enemies) do
    for cloneIdx, clone in pairs(data["clones"]) do
      --check sublevel
      if clone.sublevel == currentSublevel or (not clone.sublevel) then
        local blip = MDT.dungeonEnemies_framePool:Acquire()
        blip.enemyIdx = enemyIdx
        blip.cloneIdx = cloneIdx
        blip:SetUp(data, clone)
        coroutine.yield()
      end
    end
  end
end

function MDT:DungeonEnemies_CreateFramePools()
  db = self:GetDB()
  MDT.dungeonEnemies_framePool = MDT.CreateFramePool("Button", MDT.main_frame.mapPanelFrame, "MDTDungeonEnemyTemplate")
end

function MDT:FindPullOfBlip(blip)
  local preset = MDT:GetCurrentPreset()
  local pulls = preset.value.pulls or {}

  for pullIdx, pull in ipairs(pulls) do
    if pull[blip.enemyIdx] then
      for storageIdx, cloneIdx in ipairs(pull[blip.enemyIdx]) do
        if cloneIdx == blip.cloneIdx then
          return pullIdx
        end
      end
    end
  end
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
    -- if not ignoreUpdates then self:UpdatePullButtonNPCData(pullIdx) end
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
  -- if not ignoreUpdates then self:UpdatePullButtonNPCData(pull) end
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
              if db.enemyStyle == 2 then
                blip.texture_Portrait:SetVertexColor(r, g, b, 1)
              else
                blip.texture_Portrait:SetVertexColor(r, g, b, 1)
                blip.texture_SelectedHighlight:SetVertexColor(r, g, b, 0.7)
              end
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
      if db.enemyStyle == 2 then
        blip.texture_Portrait:SetVertexColor(1, 1, 1, 1)
      else
        blip.texture_Portrait:SetVertexColor(1, 1, 1, 1)
      end
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
                if db.enemyStyle == 2 then
                  blip.texture_Portrait:SetVertexColor(0, 1, 0, 1)
                else
                  blip.texture_Portrait:SetVertexColor(r, g, b, 1)
                  blip.texture_SelectedHighlight:SetVertexColor(r, g, b, 0.7)
                end
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
    r, g, b = MDT:HexToRGB(db.defaultColor)
    MDT:DungeonEnemies_SetPullColor(pull, r, g, b)
  end
  return r, g, b
end

function MDT:IsNPCInPulls(poi)
  local week = self:GetEffectivePresetWeek()
  local data = self.dungeonEnemies[db.currentDungeonIdx]
  for enemyIdx, enemy in pairs(data) do
    if enemy.id == poi.npcId then
      for cloneIdx, clone in pairs(enemy.clones) do
        if clone.week[week] then
          return MDT:IsCloneInPulls(enemyIdx, cloneIdx)
        end
      end
    end
  end
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

---tries to retrieve npc name by npcId
---only looks for npcs in the current dungeon
function MDT:GetNPCNameById(npcId)
  local data = MDT.dungeonEnemies[db.currentDungeonIdx]
  if data then
    for _, enemy in pairs(data) do
      if enemy.id == npcId then
        return enemy.name
      end
    end
  end
end

---exports all ids of npcs that do not have a displayId associated to them
--dungeons = [
--Dungeon(name='AtalDazar', idx=15, npcIds=[134739, 161241, 136347]),
--    Dungeon(name='RandomDungeon', idx=14, npcIds=[161241, 134739, 136347]),
--]
function MDT:ExportNPCIdsWithoutDisplayIds()
  local output = "dungeons = [\n"
  for idx = 15, MDT:GetNumDungeons() do
    local shouldAddDungeonText = true
    local enemyData = MDT.dungeonEnemies[idx]
    if enemyData then
      for _, enemy in pairs(enemyData) do
        if not enemy.displayId then
          if shouldAddDungeonText then
            output = output.."Dungeon(name='"..MDT:GetDungeonName(idx).."', idx="..idx..", npcIds=["
            shouldAddDungeonText = false
          end
          output = output..enemy.id..", "
        end
      end
      if not shouldAddDungeonText then output = output.."]),\n" end
    end
  end
  output = output.."]"
  MDT:HideAllDialogs()
  MDT.main_frame.ExportFrame:Show()
  MDT.main_frame.ExportFrame:ClearAllPoints()
  MDT.main_frame.ExportFrame:SetPoint("CENTER", MDT.main_frame, "CENTER", 0, 50)
  MDT.main_frame.ExportFrameEditbox:SetText(output)
  MDT.main_frame.ExportFrameEditbox:HighlightText(0, string.len(output))
  MDT.main_frame.ExportFrameEditbox:SetFocus()
  MDT.main_frame.ExportFrameEditbox:SetLabel("NPC ids without displayId")
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
