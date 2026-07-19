-- Made by Nnoggie, 2017-2025
local AddonName, MDT = ...
local L = MDT.L

local tinsert, tremove, CreateFrame, tonumber, max, min, abs, pairs, ipairs, GetCursorPosition, GameTooltip =
    table.insert, table.remove, CreateFrame, tonumber, math.max, math.min, math.abs, pairs, ipairs, GetCursorPosition,
    GameTooltip

local defaultSavedVars = MDT:GetDefaultSavedVariables()

BINDING_HEADER_MDT = "Mythic Dungeon Tools (MDT)"
BINDING_NAME_MDTTOGGLE = L["Toggle MDT"]
_G["BINDING_NAME_CLICK MDTFocusMarkerButton:LeftButton"] = L["MDT Set Focus Macro"]

local mythicColor = "|cFFFFFFFF"
MDT.BackdropColor = { 0.058823399245739, 0.058823399245739, 0.058823399245739, 0.9 }

local AceGUI = LibStub("AceGUI-3.0")
local db
local minimapIcon = LibStub("LibDBIcon-1.0")

function MDT:HideMinimapButton()
  db.minimap.hide = true
  minimapIcon:Hide("MythicDungeonTools")
  -- update the checkbox in settings
  if MDT.main_frame and MDT.main_frame.minimapCheckbox then MDT.main_frame.minimapCheckbox:SetValue(false) end
  print(L["MDT: Use /mdt minimap to show the minimap icon again"])
end

function MDT:ShowMinimapButton()
  db.minimap.hide = false
  minimapIcon:Refresh("MythicDungeonTools", db.minimap)
  -- update the checkbox in settings
  if MDT.main_frame and MDT.main_frame.minimapCheckbox then MDT.main_frame.minimapCheckbox:SetValue(true) end
end

---@param shouldWarn boolean|nil
function MDT:IsInRestrictedEnvironment(shouldWarn)
  if C_Secrets and C_Secrets.ShouldAurasBeSecret and C_Secrets.ShouldAurasBeSecret() then
    if shouldWarn then
      print('MDT: '..(L["Action blocked: Restricted environment"] or "Action blocked: Restricted environment"))
    end
    return true
  end
  return false
end

function MDT:CreateContextMenu(ownerRegion, generator, ...)
  if self:IsInRestrictedEnvironment(true) then return end
  return MenuUtil.CreateContextMenu(ownerRegion, generator, ...)
end

---@diagnostic disable: missing-fields
local LDB = LibStub("LibDataBroker-1.1"):NewDataObject("MythicDungeonTools", {
  type = "data source",
  text = "Mythic Dungeon Tools",
  icon = "Interface\\AddOns\\"..AddonName.."\\Textures\\MDTMinimap",
  OnClick = function(button, buttonPressed)
    if buttonPressed == "RightButton" then
      if db.minimap.lock then
        minimapIcon:Unlock("MythicDungeonTools")
      else
        minimapIcon:Lock("MythicDungeonTools")
      end
    elseif (buttonPressed == 'MiddleButton') then
      if db.minimap.hide then
        MDT:ShowMinimapButton()
      else
        MDT:HideMinimapButton()
      end
    else
      MDT:Async(function() MDT:ShowInterfaceInternal() end, "showInterface")
    end
  end,
  OnTooltipShow = function(tooltip)
    if not tooltip or not tooltip.AddLine then return end
    tooltip:AddLine(mythicColor.."Mythic Dungeon Tools|r")
    tooltip:AddLine(L["Click to toggle AddOn Window"])
    tooltip:AddLine(L["Right-click to lock Minimap Button"])
    tooltip:AddLine(L["Middle-click to disable Minimap Button"])
  end,
})

SLASH_MYTHICDUNGEONTOOLS1 = "/mplus"
SLASH_MYTHICDUNGEONTOOLS2 = "/mdt"
SLASH_MYTHICDUNGEONTOOLS3 = "/mythicdungeontools"

BINDING_NAME_MDTTOGGLE = L["Toggle Window"]
BINDING_NAME_MDTNPC = L["New NPC at Cursor Position"]
BINDING_NAME_MDTWAYPOINT = L["New Patrol Waypoint at Cursor Position"]
BINDING_NAME_MDTUNDODRAWING = L["undoDrawing"]
BINDING_NAME_MDTREDODRAWING = L["redoDrawing"]

function SlashCmdList.MYTHICDUNGEONTOOLS(cmd, editbox)
  cmd = cmd:lower()
  local rqst, arg = strsplit(' ', cmd)
  if rqst == "devmode" then
    if MDT.ToggleDevMode then MDT:ToggleDevMode() end
  elseif rqst == "reset" then
    MDT:ResetMainFramePos()
  elseif rqst == "hardreset" then
    if arg == "force" then
      MDT:HardReset()
    else
      MDT:Async(function()
        MDT:OpenConfirmationFrame(450, 150, L["hardResetPromptTitle"], L["Delete"], L["hardResetPrompt"], MDT.HardReset)
      end, "hardReset")
    end
  elseif rqst == "minimap" then
    if db.minimap.hide then
      MDT:ShowMinimapButton()
    else
      MDT:HideMinimapButton()
    end
  elseif rqst == "test" then
    if MDT.test and MDT.test.RunAllTests then
      MDT:OpenConfirmationFrame(450, 150, "MDT Test", "Run", "Run all tests?", MDT.test.RunAllTests)
    end
  else
    MDT:Async(function() MDT:ShowInterfaceInternal() end, "showInterface")
  end
end

function MDT:GetLocaleIndex()
  local localeToIndex = {
    ["enUS"] = 1,
    ["deDE"] = 2,
    ["esES"] = 3,
    ["esMX"] = 4,
    ["frFR"] = 5,
    ["itIT"] = 6,
    ["ptBR"] = 7,
    ["ruRU"] = 8,
    ["koKR"] = 9,
    ["zhCN"] = 10,
    ["zhTW"] = 11,
  }
  return localeToIndex[GetLocale()] or 1
end

-- Init db
local eventFrame
do
  eventFrame = CreateFrame("Frame")
  eventFrame:RegisterEvent("ADDON_LOADED")
  eventFrame:RegisterEvent("GROUP_ROSTER_UPDATE")
  eventFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
  eventFrame:SetScript("OnEvent", function(self, event, ...)
    return MDT[event](self, ...)
  end)

  function MDT.ADDON_LOADED(self, addon)
    if addon == "MythicDungeonTools" then
      db = MDT:InitializeSavedVariables()
      if not db then return end
      ---@diagnostic disable-next-line: param-type-mismatch
      minimapIcon:Register("MythicDungeonTools", LDB, db.minimap)
      if not db.minimap.hide then MDT:ShowMinimapButton() end
      --compartment
      if not db.minimap.compartmentHide then
        minimapIcon:AddButtonToCompartment("MythicDungeonTools")
      end
      -- Initialize fade frame for combat transparency
      MDT:InitializeFadeFrame()
      if db.announceDungeonReset then MDT:EnableDungeonResetAnnounceHook() end
      eventFrame:UnregisterEvent("ADDON_LOADED")
    end
  end

  local last = 0
  function MDT.GROUP_ROSTER_UPDATE()
    --check not more than once per second (blizzard event spam)
    local now = GetTime()
    if last < now - 1 then
      if not MDT.main_frame then return end
      local inGroup = UnitInRaid("player") or IsInGroup()
      MDT.main_frame.LinkToChatButton:SetDisabled(not inGroup)
      MDT.main_frame.LiveSessionButton:SetDisabled(not inGroup)
      if inGroup then
        MDT.main_frame.LinkToChatButton.text:SetTextColor(1, 0.8196, 0)
        if MDT.liveSessionActive then
          MDT.main_frame.LiveSessionButton:SetText(L["*Live*"])
          MDT.main_frame.LiveSessionButton.text:SetTextColor(0, 1, 0)
        else
          MDT.main_frame.LiveSessionButton:SetText(L["Live"])
          MDT.main_frame.LiveSessionButton.text:SetTextColor(1, 0.8196, 0)
        end
      else
        MDT.main_frame.LinkToChatButton.text:SetTextColor(0.5, 0.5, 0.5)
        MDT.main_frame.LiveSessionButton.text:SetTextColor(0.5, 0.5, 0.5)
      end
      last = now
    end
  end

  function MDT.PLAYER_ENTERING_WORLD()
    --initialize Blizzard_ChallengesUI
    C_Timer.After(1, function()
      if db and not db.minimap.hide then
        minimapIcon:Refresh("MythicDungeonTools", db.minimap)
      end
      MDT:ApplyXalatathVoiceLinesMute()
      if db.loadOnStartUp and db.devMode then MDT:Async(function() MDT:ShowInterfaceInternal(true) end, "showInterface") end
    end)
    eventFrame:UnregisterEvent("PLAYER_ENTERING_WORLD")
  end
end

MDT.mapInfo = {}
MDT.dungeonTotalCount = {}
MDT.scaleMultiplier = {}
MDT.dungeonMaps = {}
MDT.dungeonEnemies = {}
MDT.mapPOIs = {}
MDT.dungeonSubLevels = {}
MDT.dungeonList = {
  -- these were for the old dropdown menu, need to fix this at some point
  [14] = "-",
  [27] = "-",
  [28] = "-",
  [39] = "-",
}

function MDT:GetDungeonName(idx, forceEnglish)
  if forceEnglish and MDT.mapInfo[idx] and MDT.mapInfo[idx].englishName then
    return MDT.mapInfo[idx].englishName
  end
  return MDT.dungeonList[idx]
end

function MDT:GetDungeonSublevels()
  return MDT.dungeonSubLevels
end

function MDT:UpdatePresetDropDown()
  local dropdown = MDT.main_frame.sidePanel.WidgetGroup.PresetDropDown
  local presetList = {}
  for k, v in pairs(db.presets[db.currentDungeonIdx]) do
    presetList[k] = MDT:GetPresetDropdownText(v)
  end
  dropdown:SetList(presetList)
  dropdown:SetValue(db.currentPreset[db.currentDungeonIdx])
  dropdown:ClearFocus()
end

local raidClassColorKeyByClassIndex = {
  [1] = "WARRIOR",
  [2] = "PALADIN",
  [3] = "HUNTER",
  [4] = "ROGUE",
  [5] = "PRIEST",
  [6] = "DEATHKNIGHT",
  [7] = "SHAMAN",
  [8] = "MAGE",
  [9] = "WARLOCK",
  [10] = "MONK",
  [11] = "DRUID",
  [12] = "DEMONHUNTER",
  [13] = "EVOKER",
}

function MDT:GetCurrentRouteAuthor()
  local name, realm = UnitFullName("player")
  local _, _, classIdx = UnitClass("player")
  if not name or not classIdx then return end
  if not realm or realm == "" then realm = GetRealmName and GetRealmName() or "" end
  return {
    name = name,
    realm = realm,
    classIdx = classIdx,
  }
end

function MDT:EnsurePresetCreatedBy(preset, force)
  if preset.text == L["Default"] then
    preset.createdBy = nil
    return
  end
  if not force and type(preset.createdBy) == "table" then return end
  local author = self:GetCurrentRouteAuthor()
  if author then preset.createdBy = author end
end

function MDT:GetClassFileByIndex(classIdx)
  return raidClassColorKeyByClassIndex[tonumber(classIdx)]
end

function MDT:GetClassColoredRouteAuthorName(createdBy)
  if type(createdBy) ~= "table" or type(createdBy.name) ~= "string" then return end
  local classFile = self:GetClassFileByIndex(createdBy.classIdx)
  if not classFile then return end
  local _, _, _, classHexString = GetClassColor(classFile)
  if not classHexString then return end
  return WrapTextInColorCode(createdBy.name, classHexString)
end

function MDT:GetPresetDropdownText(preset)
  local text = preset.text or ""
  local authorName = self:GetClassColoredRouteAuthorName(preset.createdBy)
  if authorName then
    return authorName.." - "..text
  end
  return text
end

function MDT:UpdatePresetDropdownTextColor(forceReset)
  local preset = self:GetCurrentPreset()
  local livePreset = self:GetCurrentLivePreset()
  if self.liveSessionActive and preset == livePreset and (not forceReset) then
    local dropdown = MDT.main_frame.sidePanel.WidgetGroup.PresetDropDown
    dropdown.text:SetTextColor(0, 1, 0, 1)
  else
    local dropdown = MDT.main_frame.sidePanel.WidgetGroup.PresetDropDown
    dropdown.text:SetTextColor(1, 1, 1, 1)
  end
end

---FormatEnemyForces
function MDT:FormatEnemyForces(forces, forcesmax, progressbar)
  if not forcesmax then
    forcesmax = MDT.dungeonTotalCount[db.currentDungeonIdx].normal
  end
  local percent = forcesmax > 0 and (forces / forcesmax) * 100 or 0
  if db.enemyForcesFormat == 1 then
    if progressbar then return forces.."/"..forcesmax end
    return forces
  elseif db.enemyForcesFormat == 2 then
    if progressbar then return string.format((forces.."/"..forcesmax.." (%.2f%%)"), percent) end
    return string.format(forces.." (%.2f%%)", percent)
  end
end

---Progressbar_SetValue
---Sets the value/progress/color of the count progressbar to the apropriate data
function MDT:Progressbar_SetValue(self, totalCurrent, totalMax)
  local percent = totalMax > 0 and (totalCurrent / totalMax) * 100 or 0
  if percent >= 102 then
    if totalCurrent - totalMax > 8 then
      self.Bar:SetStatusBarColor(1, 0, 0, 1)
    else
      self.Bar:SetStatusBarColor(0, 1, 0, 1)
    end
  elseif percent >= 100 then
    self.Bar:SetStatusBarColor(0, 1, 0, 1)
  else
    self.Bar:SetStatusBarColor(0.26, 0.42, 1)
  end
  self.Bar:SetValue(percent)
  self.Bar.Label:SetText(MDT:FormatEnemyForces(totalCurrent, totalMax, true))
  self.AnimValue = percent
end

---UpdateProgressbar
---Update the progressbar on the sidepanel with the correct values
function MDT:UpdateProgressbar()
  MDT:EnsureDBTables()
  local grandTotal = MDT:CountForces()
  MDT:Progressbar_SetValue(MDT.main_frame.sidePanel.ProgressBar, grandTotal, MDT.dungeonTotalCount[db.currentDungeonIdx].normal)
end

---ActivatePullTooltip
---
function MDT:ActivatePullTooltip(pull)
  local pullTooltip = MDT.pullTooltip
  pullTooltip.currentPull = pull
  pullTooltip:Show()
end

---UpdatePullTooltip
---Updates the tooltip which is being displayed when a pull is mouseovered
function MDT:UpdatePullTooltip(tooltip)
  local frame = MDT.main_frame
  if not frame.sidePanel.pullButtonsScrollFrame.frame:IsMouseOver() then
    tooltip:Hide()
  elseif frame.sidePanel.newPullButton and frame.sidePanel.newPullButton.frame:IsMouseOver() then
    tooltip:Hide()
  else
    if frame.sidePanel.newPullButtons and tooltip.currentPull and frame.sidePanel.newPullButtons[tooltip.currentPull] then
      local showData

      --enemy portraits
      for k, v in pairs(frame.sidePanel.newPullButtons[tooltip.currentPull].enemyPortraits) do
        if v:IsMouseOver() and v:IsShown() then
          --model
          if v.enemyData.displayId and (not tooltip.modelNpcId or (tooltip.modelNpcId ~= v.enemyData.displayId)) then
            tooltip.Model:SetDisplayInfo(v.enemyData.displayId)
            tooltip.modelNpcId = v.enemyData.displayId
          end
          --topString
          local newLine = "\n"
          local text = newLine..newLine..newLine..L[v.enemyData.name].." x"..v.enemyData.quantity..newLine
          text = text..string.format(L["Level %d %s"], v.enemyData.level, L[v.enemyData.creatureType])..newLine
          local boss = v.enemyData.isBoss or false
          local health = MDT:CalculateEnemyHealth(boss, v.enemyData.baseHealth, db.currentDifficulty, v.enemyData.ignoreFortified)
          text = text..string.format(L["%s HP"], MDT:FormatEnemyHealth(health))..newLine

          local totalForcesMax = MDT.dungeonTotalCount[db.currentDungeonIdx].normal
          local count = v.enemyData.count
          text = text..L["Forces"]..": "..MDT:FormatEnemyForces(count, totalForcesMax, false)

          tooltip.topString:SetText(text)
          showData = true
          break
        end
      end
      if showData then
        tooltip.topString:Show()
        tooltip.Model:Show()
      else
        tooltip.topString:Hide()
        tooltip.Model:Hide()
      end

      local countEnemies = 0
      for k, v in pairs(frame.sidePanel.newPullButtons[tooltip.currentPull].enemyPortraits) do
        if v:IsShown() then countEnemies = countEnemies + 1 end
      end
      if countEnemies == 0 then
        tooltip:Hide()
        return
      end
      local pullForces = MDT:CountForces(tooltip.currentPull, true)
      local totalForces = MDT:CountForces(tooltip.currentPull, false)
      local totalForcesMax = MDT.dungeonTotalCount[db.currentDungeonIdx].normal

      local text = L["Forces"]..": "..MDT:FormatEnemyForces(pullForces, totalForcesMax, false)
      text = text.."\n"..L["Total"]..": "..MDT:FormatEnemyForces(totalForces, totalForcesMax, true)
      -- local pullHealth = MDT:SumCurrentPullHealth(tooltip.currentPull)
      -- text = text .. "\n" .. L["Efficiency Score"] .. ": " .. MDT:GetEfficiencyScoreString(pullForces, pullHealth)

      tooltip.botString:SetText(text)
      tooltip.botString:Show()
    end
  end
end

---CountForces
---Counts total selected enemy forces in the current preset up to pull
function MDT:CountForces(currentPull, currentOnly)
  --count up to and including the currently selected pull
  currentPull = currentPull or 1000
  local preset = self:GetCurrentPreset()
  local pullCurrent = 0
  for pullIdx, pull in pairs(preset.value.pulls) do
    if not currentOnly or (currentOnly and pullIdx == currentPull) then
      if pullIdx <= currentPull then
        for enemyIdx, clones in pairs(pull) do
          if tonumber(enemyIdx) then
            for k, v in pairs(clones) do
              if MDT:IsCloneIncluded(enemyIdx, v) then
                local count = self.dungeonEnemies[db.currentDungeonIdx][enemyIdx].count
                pullCurrent = pullCurrent + count
              end
            end
          end
        end
      else
        break
      end
    end
  end
  return pullCurrent
end

---Adds up health of all enemies in the current pull
function MDT:SumCurrentPullHealth(currentPull)
  currentPull = currentPull or 1000
  local preset = self:GetCurrentPreset()
  local pull = preset.value.pulls[currentPull]
  if not pull then return 0 end

  local totalHealth = 0
  for enemyIdx, clones in pairs(pull) do
    if tonumber(enemyIdx) then
      for k, v in pairs(clones) do
        if MDT:IsCloneIncluded(enemyIdx, v) then
          local data = self.dungeonEnemies[db.currentDungeonIdx][enemyIdx]
          local health = self:CalculateEnemyHealth(data.isBoss or false, data.health, db.currentDifficulty, data.ignoreFortified)
          totalHealth = totalHealth + health
        end
      end
    end
  end
  return totalHealth
end

---Checks if the specified clone is part of the current map configuration
function MDT:IsCloneIncluded(enemyIdx, cloneIdx)
  local enemy = MDT.dungeonEnemies[db.currentDungeonIdx][enemyIdx]
  local clone = enemy and enemy["clones"][cloneIdx]
  if not clone then return false end
  return true
end

---Returns the current pull of the currently active preset
function MDT:GetCurrentPull()
  local selection = MDT:GetSelection()
  return selection[#selection]
end

---Returns the current preset
function MDT:GetCurrentPreset()
  return db.presets[db.currentDungeonIdx][db.currentPreset[db.currentDungeonIdx]]
end

function MDT:GetCurrentLivePreset()
  if not self.livePresetUID then return end
  if self.liveUpdateFrameOpen then
    for fullName, cachedPreset in pairs(self.transmissionCache) do
      if cachedPreset.uid == self.livePresetUID then
        return cachedPreset
      end
    end
  end
  for dungeonIdx, presets in pairs(db.presets) do
    for presetIdx, preset in pairs(presets) do
      if preset.uid and preset.uid == self.livePresetUID then
        return preset, presetIdx
      end
    end
  end
end

function MDT:ReturnToLivePreset()
  local preset, presetIdx = self:GetCurrentLivePreset()
  ---@diagnostic disable-next-line: need-check-nil
  self:UpdateToDungeon(preset.value.currentDungeonIdx, true)
  db.currentPreset[db.currentDungeonIdx] = presetIdx
  self:UpdatePresetDropDown()
  self:UpdateMap()
end

function MDT:SetLivePreset()
  local preset = self:GetCurrentPreset()
  local callback = function()
    self:SetUniqueID(preset)
    self.livePresetUID = preset.uid
    self:LiveSession_SendPreset(preset)
    self:UpdatePresetDropdownTextColor()
    self.main_frame.setLivePresetButton:Hide()
    self.main_frame.liveReturnButton:Hide()
  end
  MDT:CheckPresetSize(callback)
end

function MDT:CheckPresetSize(callback, cancelCallback, fireCancelOnClose)
  local presetSize = self:GetPresetSize(false, 5)
  if presetSize > 3500 then
    local timeToSend = 1 + math.max(presetSize - 2550, 0) / 255
    local prompt = string.format(L["LargePresetWarning"], timeToSend, "\n", "\n", "\n")
    MDT:OpenConfirmationFrame(450, 150, L["Sharing large preset"], "Share", prompt, callback, nil, cancelCallback, fireCancelOnClose)
  else
    callback()
  end
end

local function round(number, decimals)
  return tonumber((("%%.%df"):format(decimals)):format(number))
end

do
  local fortMult = 1.2
  local tyrMult = 1.25
  local scalingNormal = 1.07
  local scalingExtra = 1.1 -- Xalatath's Guile
  local extraScalingLevel = 11

  local getFortTyrMult = function(level, boss, fortified, tyrannical, ignoreFortified)
    local mult = 1
    if level >= 10 then
      if not boss and (fortified and not ignoreFortified) then mult = mult * fortMult end
      if boss and tyrannical then mult = mult * tyrMult end
    end
    return mult
  end

  local function getScaling(mult, level)
    local scaling = mult * (scalingNormal ^ math.min(level - 1, extraScalingLevel - 2)) * (scalingExtra ^ math.max(0, level - extraScalingLevel + 1))
    return round(scaling, 2) --not sure if this additional rounding is needed, but it was in the original code
  end

  function MDT:CalculateEnemyHealth(boss, baseHealth, level, ignoreFortified)
    local fortified = true --fort and tyr are always present in 10 and above, we don't really care for lower levels
    local tyrannical = true
    local mult = 1

    mult = getFortTyrMult(level, boss, fortified, tyrannical, ignoreFortified)
    mult = getScaling(mult, level)

    return round(mult * baseHealth, 0)
  end

end

function MDT:FormatEnemyHealth(amount)
  amount = tonumber(amount)
  if not amount then return "" end

  if self:GetLocaleIndex() == 9 then
    -- KR
    if amount >= 1e16 then
      return string.format("%.3f경", amount / 1e16)
    elseif amount >= 1e12 then
      return string.format("%.3f조", amount / 1e12)
    elseif amount >= 1e8 then
      return string.format("%.2f억", amount / 1e8)
    elseif amount >= 1e4 then
      return string.format("%.1f만", amount / 1e4)
    else
      return amount
    end
  elseif self:GetLocaleIndex() == 10 or self:GetLocaleIndex() == 11 then
    if amount >= 1e8 then
      return string.format("%.2f亿", amount / 1e8)
    elseif amount >= 1e4 then
      return string.format("%d万", math.floor(amount / 1e4))
    else
      return amount
    end
  else
    if amount >= 1e12 then
      return string.format("%.3ft", amount / 1e12)
    elseif amount >= 1e9 then
      return string.format("%.3fb", amount / 1e9)
    elseif amount >= 1e6 then
      return string.format("%.2fm", amount / 1e6)
    elseif amount >= 1e3 then
      return string.format("%.1fk", amount / 1e3)
    else
      return amount
    end
  end
end

function MDT:HideAllDialogs()
  if MDT.main_frame then
    MDT.main_frame.presetCreationFrame:Hide()
    MDT.main_frame.presetImportFrame:Hide()
    MDT.main_frame.ExportFrame:Hide()
    MDT.main_frame.RenameFrame:Hide()
    MDT.main_frame.ClearConfirmationFrame:Hide()
    MDT.main_frame.DeleteConfirmationFrame:Hide()
    if MDT.main_frame.ConfirmationFrame then MDT.main_frame.ConfirmationFrame:Hide() end
    if MDT.versionCheckFrame then MDT.versionCheckFrame:Hide() end
    if MDT.externalLinkCopyFrame then MDT.externalLinkCopyFrame:Hide() end
  end
  if MDT.copyHelper then MDT.copyHelper:SmartHide() end
  if MDT.tempConfirmationFrame then MDT.tempConfirmationFrame:Hide() end
end

function MDT:OpenImportPresetDialog()
  MDT:HideAllDialogs()
  MDT.main_frame.presetImportFrame:ClearAllPoints()
  MDT.main_frame.presetImportFrame:SetPoint("CENTER", MDT.main_frame, "CENTER", 0, 50)
  MDT.main_frame.presetImportFrame:Show()
  MDT.main_frame.presetImportBox:SetText("")
  MDT.main_frame.presetImportBox:SetFocus()
  MDT.main_frame.presetImportLabel:SetText(nil)
end

function MDT:OpenNewPresetDialog()
  MDT:HideAllDialogs()
  local presetList = {}
  local highestIndex = 1
  local countPresets = 0
  for k, v in pairs(db.presets[db.currentDungeonIdx]) do
    if v.text ~= L["<New Preset>"] then
      table.insert(presetList, k, MDT:GetPresetDropdownText(v))
      local indexNumber = tonumber(v.text:match("^"..L["defaultPresetName"].."%s*(%d+)$"))
      if indexNumber and indexNumber > highestIndex then
        highestIndex = indexNumber
      end
      countPresets = countPresets + 1
    end
  end
  local newIndex = math.max(highestIndex, countPresets - 1)
  table.insert(presetList, 1, L["Empty"])
  MDT.main_frame.PresetCreationDropDown:SetList(presetList)
  MDT.main_frame.PresetCreationDropDown:SetValue(1)
  MDT.main_frame.PresetCreationEditbox:SetText(L["defaultPresetName"].." "..newIndex + 1)
  MDT.main_frame.presetCreationFrame:ClearAllPoints()
  MDT.main_frame.presetCreationFrame:SetPoint("CENTER", MDT.main_frame, "CENTER", 0, 50)
  MDT.main_frame.presetCreationFrame:SetStatusText("")
  MDT.main_frame.presetCreationFrame:Show()
  MDT.main_frame.presetCreationCreateButton:SetDisabled(false)
  MDT.main_frame.presetCreationCreateButton.text:SetTextColor(1, 0.8196, 0)
  MDT.main_frame.PresetCreationEditbox:SetFocus()
  MDT.main_frame.PresetCreationEditbox:HighlightText(0, 50)
  MDT.main_frame.presetImportBox:SetText("")
end

function MDT:OpenClearPresetDialog()
  MDT:HideAllDialogs()
  MDT.main_frame.ClearConfirmationFrame:ClearAllPoints()
  MDT.main_frame.ClearConfirmationFrame:SetPoint("CENTER", MDT.main_frame, "CENTER", 0, 50)
  local currentPresetName = db.presets[db.currentDungeonIdx][db.currentPreset[db.currentDungeonIdx]].text
  MDT.main_frame.ClearConfirmationFrame.label:SetText(string.format(L["Reset %s?"], currentPresetName))
  MDT.main_frame.ClearConfirmationFrame:Show()
end

---Makes sure profiles are valid and have their fields set
function MDT:EnsureDBTables()
  --dungeonIdx doesnt exist
  local seasonList = MDT:GetSeasonList()
  if db.alwaysOverwriteRoutesByUID == nil then db.alwaysOverwriteRoutesByUID = false end
  db.selectedDungeonList = db.selectedDungeonList or defaultSavedVars.global.selectedDungeonList
  if not MDT.dungeonList[db.currentDungeonIdx] or string.find(MDT.dungeonList[db.currentDungeonIdx], ">") or
      not db.selectedDungeonList or not seasonList[db.selectedDungeonList] then
    db.currentDungeonIdx = defaultSavedVars.global.currentDungeonIdx
    db.selectedDungeonList = defaultSavedVars.global.selectedDungeonList
  end
  local preset = MDT:GetCurrentPreset()
  if preset.value == 0 then --<New Preset> as selected preset
    db.presets[db.currentDungeonIdx] = {
      [1] = {
        text = L["Default"],
        value = {},
        objects = {},
        colorPaletteInfo = { autoColoring = true, colorPaletteIdx = 4 }
      },
      [2] = { text = L["<New Preset>"], value = 0 },
    }
    db.currentPreset[db.currentDungeonIdx] = 1
    preset = MDT:GetCurrentPreset()
  end
  if preset.objects then
    local isValid = true
    for _, obj in pairs(preset.objects) do
      if type(obj) ~= "table" then
        isValid = false
      end
    end
    if not isValid then
      preset.objects = nil
    end
  end
  preset.week = nil
  db.currentPreset[db.currentDungeonIdx] = db.currentPreset[db.currentDungeonIdx] or 1
  db.presets[db.currentDungeonIdx][db.currentPreset[db.currentDungeonIdx]].value.currentDungeonIdx = db.currentDungeonIdx
  db.presets[db.currentDungeonIdx][db.currentPreset[db.currentDungeonIdx]].value.currentSublevel = db.presets[
  db.currentDungeonIdx][db.currentPreset[db.currentDungeonIdx]].value.currentSublevel or 1
  db.presets[db.currentDungeonIdx][db.currentPreset[db.currentDungeonIdx]].value.currentPull = db.presets[
  db.currentDungeonIdx][db.currentPreset[db.currentDungeonIdx]].value.currentPull or 1
  db.presets[db.currentDungeonIdx][db.currentPreset[db.currentDungeonIdx]].value.pulls = db.presets[db.currentDungeonIdx][db.currentPreset[db.currentDungeonIdx]].value.pulls or {}
  -- make sure, that at least 1 pull exists
  if #db.presets[db.currentDungeonIdx][db.currentPreset[db.currentDungeonIdx]].value.pulls == 0 then
    db.presets[db.currentDungeonIdx][db.currentPreset[db.currentDungeonIdx]].value.pulls[1] = {}
  end
  --ensure that there exists a map for the current sublevel
  local sublevel = MDT:GetCurrentSubLevel()
  if not MDT.dungeonMaps[db.currentDungeonIdx][sublevel] then
    db.presets[db.currentDungeonIdx][db.currentPreset[db.currentDungeonIdx]].value.currentSublevel = 1
  end

  --ensure the pulls table is not fully corrupted
  if not preset.value.pulls or (type(preset.value.pulls) ~= "table") then
    preset.value.pulls = {}
  else
    for pullIdx, pull in pairs(preset.value.pulls) do
      --detect gaps in pull list and delete invalid pulls
      if pullIdx == 0 or pullIdx > #preset.value.pulls then
        preset.value.pulls[pullIdx] = nil
      end
      --fix wrong indexes of clones within pulls
      for enemyIdx, clones in pairs(pull) do
        local assignmentIdx = 1
        if type(clones) == "table" then
          for actualIndex, cloneIdx in pairs(clones) do
            if actualIndex ~= assignmentIdx then
              clones[assignmentIdx] = cloneIdx
              clones[actualIndex] = nil
            end
            assignmentIdx = assignmentIdx + 1
          end
        end
      end
    end
  end

  -- Set current pull to last pull, if the actual current pull does not exists anymore
  if not
      db.presets[db.currentDungeonIdx][db.currentPreset[db.currentDungeonIdx]].value.pulls[
      db.presets[db.currentDungeonIdx][db.currentPreset[db.currentDungeonIdx]].value.currentPull] then
    db.presets[db.currentDungeonIdx][db.currentPreset[db.currentDungeonIdx]].value.currentPull = #
        db.presets[db.currentDungeonIdx][db.currentPreset[db.currentDungeonIdx]].value.pulls
  end

  for k, v in pairs(db.presets[db.currentDungeonIdx][db.currentPreset[db.currentDungeonIdx]].value.pulls) do
    if k == 0 then
      db.presets[db.currentDungeonIdx][db.currentPreset[db.currentDungeonIdx]].value.pulls[0] = nil
      break
    end
  end

  --removed clones: remove data from presets
  for pullIdx, pull in pairs(preset.value.pulls) do
    for enemyIdx, clones in pairs(pull) do
      if tonumber(enemyIdx) then
        --enemy does not exist at all anymore
        if not MDT.dungeonEnemies[db.currentDungeonIdx][enemyIdx] then
          pull[enemyIdx] = nil
        else
          --only clones
          for k, v in pairs(clones) do
            if not MDT.dungeonEnemies[db.currentDungeonIdx][enemyIdx]["clones"][v] then
              clones[k] = nil
            end
          end
        end
      end
    end
    pull["color"] = pull["color"] or db.defaultColor
  end

  preset.difficulty = preset.difficulty or db.currentDifficulty

  --make sure sublevel actually exists for the dungeon
  --this might have been caused by bugged dropdowns in the past
  local maxSublevel = -1
  for _, _ in pairs(MDT.dungeonMaps[db.currentDungeonIdx]) do
    maxSublevel = maxSublevel + 1
  end
  if preset.value.currentSublevel > maxSublevel then preset.value.currentSublevel = maxSublevel end
end

function MDT:DeletePreset(index)
  if index == 1 then return end
  tremove(db.presets[db.currentDungeonIdx], index)
  db.currentPreset[db.currentDungeonIdx] = index - 1
  MDT:UpdatePresetDropDown()
  MDT:UpdateMap()
end

---Counts the number of presets of the current dungeon
function MDT:CountPresets()
  return #db.presets[db.currentDungeonIdx] - 2
end

---Deletes all presets from the current dungeon
function MDT:DeleteAllPresets()
  local countPresets = #db.presets[db.currentDungeonIdx] - 1
  for i = countPresets, 2, -1 do
    tremove(db.presets[db.currentDungeonIdx], i)
    db.currentPreset[db.currentDungeonIdx] = i - 1
  end
  MDT:UpdatePresetDropDown()
  MDT:UpdateMap()
end

function MDT:ClearPreset(preset, silent)
  if preset == self:GetCurrentPreset() then silent = false end
  table.wipe(preset.value.pulls)
  preset.value.currentPull = 1
  --MDT:DeleteAllPresetObjects()
  self:EnsureDBTables()
  if not silent then
    self:UpdateMap()
    self:ReloadPullButtons()
  end
  MDT:ColorPull()
end

function MDT:CreateNewPreset(name)
  if name == "<New Preset>" then
    MDT.main_frame.presetCreationLabel:SetText(string.format(L["Cannot create preset '%s'"], name))
    MDT.main_frame.presetCreationCreateButton:SetDisabled(true)
    MDT.main_frame.presetCreationCreateButton.text:SetTextColor(0.5, 0.5, 0.5)
    MDT.main_frame.presetCreationFrame:DoLayout()
    return
  end
  local duplicate = false
  local countPresets = 0
  for k, v in pairs(db.presets[db.currentDungeonIdx]) do
    countPresets = countPresets + 1
    if v.text == name then duplicate = true end
  end
  if duplicate == false then
    db.presets[db.currentDungeonIdx][countPresets + 1] = db.presets[db.currentDungeonIdx][countPresets] --put <New Preset> at the end of the list

    local startingPointPresetIdx = MDT.main_frame.PresetCreationDropDown:GetValue() - 1
    if startingPointPresetIdx > 0 then
      db.presets[db.currentDungeonIdx][countPresets] = MDT:CopyObject(db.presets[db.currentDungeonIdx][
      startingPointPresetIdx])
      db.presets[db.currentDungeonIdx][countPresets].text = name
      db.presets[db.currentDungeonIdx][countPresets].uid = nil
    else
      db.presets[db.currentDungeonIdx][countPresets] = { text = name, value = {} }
    end

    db.currentPreset[db.currentDungeonIdx] = countPresets
    MDT:EnsurePresetCreatedBy(db.presets[db.currentDungeonIdx][countPresets], true)
    MDT.main_frame.presetCreationFrame:Hide()
    MDT:UpdatePresetDropDown()
    MDT:UpdateMap()
    MDT:SetPresetColorPaletteInfo()
    MDT:ColorAllPulls()
  else
    MDT.main_frame.presetCreationLabel:SetText(string.format(L["Preset '%s' already exists"], name))
    MDT.main_frame.presetCreationCreateButton:SetDisabled(true)
    MDT.main_frame.presetCreationCreateButton.text:SetTextColor(0.5, 0.5, 0.5)
    MDT.main_frame.presetCreationFrame:DoLayout()
  end
end

function MDT:SanitizePresetName(text)
  --check if name is valid, block button if so, unblock if valid
  if text == "<New Preset>" then
    return false
  else
    local duplicate = false
    local countPresets = 0
    for k, v in pairs(db.presets[db.currentDungeonIdx]) do
      countPresets = countPresets + 1
      if v.text == text then duplicate = true end
    end
    return not duplicate and text or false
  end
end

function MDT:MakePresetImportFrame(frame)
  frame.presetImportFrame = AceGUI:Create("Frame")
  frame.presetImportFrame.frame:SetParent(frame)
  frame.presetImportFrame.frame:SetFrameStrata("DIALOG")
  frame.presetImportFrame:SetTitle(L["Import Preset"])
  frame.presetImportFrame:SetWidth(400)
  frame.presetImportFrame:SetHeight(200)
  frame.presetImportFrame:EnableResize(false)
  frame.presetImportFrame:SetLayout("Flow")
  frame.presetImportFrame:SetCallback("OnClose", function(widget)
    MDT:UpdatePresetDropDown()
    if db.currentPreset[db.currentDungeonIdx] ~= 1 then
      MDT.main_frame.sidePanelDeleteButton:SetDisabled(false)
      MDT.main_frame.sidePanelDeleteButton.text:SetTextColor(1, 0.8196, 0)
    end
  end)
  frame.presetImportFrame.statustext:GetParent():Hide()

  frame.presetImportLabel = AceGUI:Create("Label")
  frame.presetImportLabel:SetText(nil)
  frame.presetImportLabel:SetWidth(390)
  frame.presetImportLabel:SetColor(1, 0, 0)

  local importString = ""
  frame.presetImportBox = AceGUI:Create("EditBox")
  local editbox = frame.presetImportBox
  editbox:SetLabel(L["Import Preset"]..":")
  editbox:SetWidth(255)
  editbox.OnTextChanged = function(widget, event, text) importString = text end
  editbox:SetCallback("OnTextChanged", editbox.OnTextChanged)
  editbox:DisableButton(true)
  local IMPORT_EXPORT_EDIT_MAX_BYTES = 0 --1024000*4 -- 0 appears to be "no limit"

  local pasteBuffer, pasteCharCount, isPasting = {}, 0, false

  local function clearBuffer(self)
    self:SetScript('OnUpdate', nil)
    editbox.editbox:SetMaxBytes(IMPORT_EXPORT_EDIT_MAX_BYTES)
    isPasting = false
    if InCombatLockdown() then
      print('MDT: '..L["Cannot import while in combat"])
      MDT:HideAllDialogs()
      return
    end
    if pasteCharCount > 10 then
      local pasteString = strtrim(table.concat(pasteBuffer))
      editbox:SetText(string.sub(pasteString, 1, 2000));
      local newPreset = MDT:StringToTable(pasteString, true)
      if MDT:ValidateImportPreset(newPreset) then
        MDT.main_frame.presetImportFrame:Hide()
        MDT:ImportPreset(newPreset)
        if db.colorPaletteInfo.forceColorBlindMode then
          MDT:ColorAllPulls()
        end
      else
        frame.presetImportLabel:SetText(L["Invalid import string"])
      end
    end
  end
  editbox.editbox:SetScript('OnChar', function(self, c)
    if not isPasting then
      if editbox.editbox:GetMaxBytes() ~= 1 then -- ensure this for performance!
        editbox.editbox:SetMaxBytes(1)
      end
      pasteBuffer, pasteCharCount, isPasting = {}, 0, true
      self:SetScript('OnUpdate', clearBuffer) -- clearBuffer on next frame
    end
    pasteCharCount = pasteCharCount + 1
    pasteBuffer[pasteCharCount] = c
  end)
  editbox.editbox:SetScript('OnKeyDown', function(_, key)
    -- have to use OnKeyDown here as OnKeyUp does not fire, AceGUI issue
    if key == "ESCAPE" then
      frame.presetImportFrame:Hide()
    end
  end);
  frame.presetImportFrame:AddChild(frame.presetImportBox)

  local importButton = AceGUI:Create("Button")
  importButton:SetText(L["Import"])
  importButton:SetWidth(100)
  importButton:SetCallback("OnClick", function()
    if InCombatLockdown() then
      print('MDT: '..L["Cannot import while in combat"])
      MDT:HideAllDialogs()
      return
    end
    local newPreset = MDT:StringToTable(importString, true)
    if MDT:ValidateImportPreset(newPreset) then
      MDT:HideAllDialogs()
      MDT:ImportPreset(newPreset)
      if db.colorPaletteInfo.forceColorBlindMode then
        MDT:ColorAllPulls()
      end
    else
      frame.presetImportLabel:SetText(L["Invalid import string"])
    end
  end)
  frame.presetImportButton = importButton
  frame.presetImportFrame:AddChild(importButton)
  frame.presetImportFrame:AddChild(frame.presetImportLabel)
  if db.devMode then
    local inspectButton = AceGUI:Create("Button")
    inspectButton:SetText("Inspect")
    inspectButton:SetWidth(100)
    inspectButton:SetCallback("OnClick", function()
      local newPreset = MDT:StringToTable(importString, true)
      if not DevTool and not DevTool.AddData then
        print("MDT: Install Dev Tool to inspect route")
      else
        DevTool:AddData(newPreset)
      end
    end)
    frame.presetImportFrame:AddChild(inspectButton)
  end
  frame.presetImportFrame:Hide()
end

function MDT:MakePresetCreationFrame(frame)
  frame.presetCreationFrame = AceGUI:Create("Frame")
  frame.presetCreationFrame.frame:SetParent(frame)
  frame.presetCreationFrame.frame:SetFrameStrata("DIALOG")
  frame.presetCreationFrame:SetTitle(L["New Preset"])
  frame.presetCreationFrame:SetWidth(400)
  frame.presetCreationFrame:SetHeight(200)
  frame.presetCreationFrame:EnableResize(false)
  --frame.presetCreationFrame:SetCallback("OnClose", function(widget) AceGUI:Release(widget) end)
  frame.presetCreationFrame:SetLayout("Flow")
  frame.presetCreationFrame:SetCallback("OnClose", function(widget)
    MDT:UpdatePresetDropDown()
    if db.currentPreset[db.currentDungeonIdx] ~= 1 then
      MDT.main_frame.sidePanelDeleteButton:SetDisabled(false)
      MDT.main_frame.sidePanelDeleteButton.text:SetTextColor(1, 0.8196, 0)
    end
  end)
  frame.presetCreationFrame.statustext:GetParent():Hide()

  frame.PresetCreationEditbox = AceGUI:Create("EditBox")
  frame.PresetCreationEditbox:SetLabel(L["Preset Name"]..":")
  frame.PresetCreationEditbox:SetWidth(255)
  frame.PresetCreationEditbox:SetCallback("OnTextChanged", function(widget, event, text)
    --check if name is valid, block button if so, unblock if valid
    if MDT:SanitizePresetName(text) then
      frame.presetCreationLabel:SetText(nil)
      frame.presetCreationCreateButton:SetDisabled(false)
      frame.presetCreationCreateButton.text:SetTextColor(1, 0.8196, 0)
    else
      frame.presetCreationLabel:SetText(string.format(L["Cannot create preset '%s'"], text))
      frame.presetCreationCreateButton:SetDisabled(true)
      frame.presetCreationCreateButton.text:SetTextColor(0.5, 0.5, 0.5)
    end
    frame.presetCreationFrame:DoLayout()
  end)
  frame.PresetCreationEditbox:SetCallback("OnEnterPressed", function(widget, event, text)
    local name = frame.PresetCreationEditbox:GetText()
    if MDT:SanitizePresetName(name) then
      MDT:CreateNewPreset(name)
    end
  end)
  frame.presetCreationFrame:AddChild(frame.PresetCreationEditbox)

  frame.presetCreationCreateButton = AceGUI:Create("Button")
  frame.presetCreationCreateButton:SetText(L["Create"])
  frame.presetCreationCreateButton:SetWidth(100)
  frame.presetCreationCreateButton:SetCallback("OnClick", function()
    local name = frame.PresetCreationEditbox:GetText()
    MDT:CreateNewPreset(name)
  end)
  frame.presetCreationFrame:AddChild(frame.presetCreationCreateButton)

  frame.presetCreationLabel = AceGUI:Create("Label")
  frame.presetCreationLabel:SetText(nil)
  frame.presetCreationLabel:SetWidth(390)
  frame.presetCreationLabel:SetColor(1, 0, 0)
  frame.presetCreationFrame:AddChild(frame.presetCreationLabel)


  frame.PresetCreationDropDown = AceGUI:Create("Dropdown")
  frame.PresetCreationDropDown:SetLabel(L["Use as a starting point:"])
  frame.PresetCreationDropDown.text:SetJustifyH("LEFT")
  frame.presetCreationFrame:AddChild(frame.PresetCreationDropDown)

  frame.presetCreationFrame:Hide()
end

function MDT:ValidateImportPreset(preset, allowKnownDungeon)
  if type(preset) ~= "table" then return false end
  if not preset.text then return false end
  if not preset.value then return false end
  if type(preset.text) ~= "string" then return false end
  if type(preset.value) ~= "table" then return false end
  if not preset.value.currentDungeonIdx then return false end
  if not preset.value.currentPull then return false end
  if not preset.value.currentSublevel then return false end
  if not preset.value.pulls then return false end
  if type(preset.value.pulls) ~= "table" then return false end
  if not MDT.dungeonList[preset.value.currentDungeonIdx] and
      not (allowKnownDungeon and MDT.knownDungeons and MDT.knownDungeons[preset.value.currentDungeonIdx]) then
    return false
  end
  return true
end

function MDT:ImportPreset(preset, fromLiveSession)
  if not MDT:AreFramesInitialized() then
    MDT:RunAfterFramesInitialized(function()
      MDT:ImportPreset(preset, fromLiveSession)
    end)
    return
  end

  --change dungeon to dungeon of the new preset
  MDT:SetDungeonList(nil, preset.value.currentDungeonIdx)
  MDT:UpdateDungeonDropDown()
  MDT:UpdateToDungeon(preset.value.currentDungeonIdx, true)
  --search for uid
  local updateIndex
  local duplicatePreset
  for k, v in pairs(db.presets[db.currentDungeonIdx]) do
    if preset.uid and v.uid and v.uid == preset.uid then
      updateIndex = k
      duplicatePreset = v
      break
    end
  end

  local finishImport = function()
    self:UpdatePresetDropDown()
    self:UpdateMap()
    self.liveUpdateFrameOpen = nil
    if fromLiveSession then
      self.main_frame.SendingStatusBar:Hide()
      if self.main_frame.LoadingSpinner then
        self.main_frame.LoadingSpinner:Hide()
        self.main_frame.LoadingSpinner.Anim:Stop()
      end
    end
  end

  local clearConfirmationCloseCallback = function()
    if self.main_frame.ConfirmationFrame then
      self.main_frame.ConfirmationFrame:SetCallback("OnClose", function()
      end)
    end
  end

  local updateCallback = function()
    clearConfirmationCloseCallback()
    db.presets[db.currentDungeonIdx][updateIndex] = preset
    db.currentPreset[db.currentDungeonIdx] = updateIndex
    finishImport()
  end

  local copyCallback = function(preserveUid)
    clearConfirmationCloseCallback()
    local name = preset.text
    local num = 2
    for k, v in pairs(db.presets[db.currentDungeonIdx]) do
      if name == v.text then
        name = preset.text.." "..num
        num = num + 1
      end
    end
    preset.text = name
    if fromLiveSession then
      if not preserveUid and duplicatePreset then duplicatePreset.uid = nil end
      MDT:SetUniqueID(preset)
    else
      if not preserveUid then preset.uid = nil end
      MDT:SetUniqueID(preset)
    end
    local countPresets = 0
    for k, v in pairs(db.presets[db.currentDungeonIdx]) do
      countPresets = countPresets + 1
    end
    db.presets[db.currentDungeonIdx][countPresets + 1] = db.presets[db.currentDungeonIdx][countPresets] --put <New Preset> at the end of the list
    db.presets[db.currentDungeonIdx][countPresets] = preset
    db.currentPreset[db.currentDungeonIdx] = countPresets
    finishImport()
  end
  local closeCallback = function()
    self.liveUpdateFrameOpen = nil
    self:LiveSession_Disable()
    self.main_frame.ConfirmationFrame:SetCallback("OnClose", function()
    end)
    if fromLiveSession then
      self.main_frame.SendingStatusBar:Hide()
      if self.main_frame.LoadingSpinner then
        self.main_frame.LoadingSpinner:Hide()
        self.main_frame.LoadingSpinner.Anim:Stop()
      end
    end
  end

  --open dialog to ask for replacing
  if updateIndex then
    if db.alwaysOverwriteRoutesByUID then
      updateCallback()
      return
    end
    local prompt = string.format(L["Earlier Version"], duplicatePreset.text, "\n", "\n", "\n", "\n")
    local checkboxCallback = function(value)
      db.alwaysOverwriteRoutesByUID = value
      if self.main_frame and self.main_frame.alwaysOverwriteRoutesByUIDCheckbox then
        self.main_frame.alwaysOverwriteRoutesByUIDCheckbox:SetValue(value)
      end
    end
    self:OpenConfirmationFrame(450, 180, L["Import Preset"], L["Overwrite"], prompt, updateCallback, L["Make copy"],
      function() copyCallback(false) end, nil, L["Always overwrite matching routes on import"], db.alwaysOverwriteRoutesByUID,
      checkboxCallback)
    if fromLiveSession then
      self.liveUpdateFrameOpen = true
      self.main_frame.ConfirmationFrame:SetCallback("OnClose", function() closeCallback() end)
    end
  else
    copyCallback(true)
  end
end

---Stores r g b values for coloring pulls with MDT:ColorPull()
local colorPaletteValues = {
  [1] = { --Rainbow values
    [1] = { [1] = 0.2446, [2] = 1, [3] = 0.2446 },
    [2] = { [1] = 0.2446, [2] = 1, [3] = 0.6223 },
    [3] = { [1] = 0.2446, [2] = 1, [3] = 1 },
    [4] = { [1] = 0.2446, [2] = 0.6223, [3] = 1 },
    [5] = { [1] = 0.2446, [2] = 0.2446, [3] = 1 },
    [6] = { [1] = 0.6223, [2] = 0.6223, [3] = 1 },
    [7] = { [1] = 1, [2] = 0.2446, [3] = 1 },
    [8] = { [1] = 1, [2] = 0.2446, [3] = 0.6223 },
    [9] = { [1] = 1, [2] = 0.2446, [3] = 0.2446 },
    [10] = { [1] = 1, [2] = 0.60971, [3] = 0.2446 },
    [11] = { [1] = 1, [2] = 0.98741, [3] = 0.2446 },
    [12] = { [1] = 0.63489, [2] = 1, [3] = 0.2446 },
    --[13] = {[1]=1, [2]=0.2446, [3]=0.54676},
    --[14] = {[1]=1, [2]=0.2446, [3]=0.32014},
    --[15] = {[1]=1, [2]=0.38309, [3]=0.2446},
    --[16] = {[1]=1, [2]=0.60971, [3]=0.2446},
    --[17] = {[1]=1, [2]=0.83633, [3]=0.2446},
    --[18] = {[1]=0.93705, [2]=1, [3]=0.2446},
    --[19] = {[1]=0.71043, [2]=1, [3]=0.2446},
    --[20] = {[1]=0.48381, [2]=1, [3]=0.2446},
  },
  [2] = { --Black and Yellow values
    [1] = { [1] = 0.4, [2] = 0.4, [3] = 0.4 },
    [2] = { [1] = 1, [2] = 1, [3] = 0.0 },
  },
  [3] = { --Red, Green and Blue values
    [1] = { [1] = 0.85882, [2] = 0.058824, [3] = 0.15294 },
    [2] = { [1] = 0.49804, [2] = 1.0, [3] = 0.0 },
    [3] = { [1] = 0.0, [2] = 0.50196, [3] = 1.0 },
  },
  [4] = { --High Contrast values
    [1] = { [1] = 1, [2] = 0.2446, [3] = 1 },
    [2] = { [1] = 0.2446, [2] = 1, [3] = 0.6223 },
    [3] = { [1] = 1, [2] = 0.2446, [3] = 0.2446 },
    [4] = { [1] = 0.2446, [2] = 0.6223, [3] = 1 },
    [5] = { [1] = 1, [2] = 0.98741, [3] = 0.2446 },
    [6] = { [1] = 0.2446, [2] = 1, [3] = 0.2446 },
    [7] = { [1] = 1, [2] = 0.2446, [3] = 0.6223 },
    [8] = { [1] = 0.2446, [2] = 1, [3] = 1 },
    [9] = { [1] = 1, [2] = 0.60971, [3] = 0.2446 },
    [10] = { [1] = 0.2446, [2] = 0.2446, [3] = 1 },
    [11] = { [1] = 0.63489, [2] = 1, [3] = 0.2446 },
  },
  [5] = { --Color Blind Friendly values (Based on IBM's color library "Color blind safe"
    [1] = { [1] = 0.39215686274509803, [2] = 0.5607843137254902, [3] = 1.0 },
    --[2] = {[1]=0.47058823529411764, [2]=0.3686274509803922, [3]=0.9411764705882353},
    [2] = { [1] = 0.8627450980392157, [2] = 0.14901960784313725, [3] = 0.4980392156862745 },
    [3] = { [1] = 0.996078431372549, [2] = 0.3803921568627451, [3] = 0.0 },
    [4] = { [1] = 1.0, [2] = 0.6901960784313725, [3] = 0.0 },
  },
}

---Saves currently selected automatic coloring settings to the current
---This can be achieved easier, but it will increase the export text length significantly for non custom palettes.
function MDT:SetPresetColorPaletteInfo()
  local preset = MDT:GetCurrentPreset()
  preset.colorPaletteInfo = {}
  preset.colorPaletteInfo.autoColoring = db.colorPaletteInfo.autoColoring
  if preset.colorPaletteInfo.autoColoring then
    preset.colorPaletteInfo.colorPaletteIdx = db.colorPaletteInfo.colorPaletteIdx
    if preset.colorPaletteInfo.colorPaletteIdx == 6 then
      preset.colorPaletteInfo.customPaletteValues = db.colorPaletteInfo.customPaletteValues
      preset.colorPaletteInfo.numberCustomColors = db.colorPaletteInfo.numberCustomColors
    end
  end
  --Code below works, but in most cases it saves more data to the preset and thereby significantly increases the export string length
  --MDT:GetCurrentPreset().colorPaletteInfo = db.colorPaletteInfo
end

function MDT:GetPresetColorPaletteInfo(preset)
  preset = preset or MDT:GetCurrentPreset()
  if not preset.colorPaletteInfo then
    MDT:SetPresetColorPaletteInfo()
  end
  return preset.colorPaletteInfo
end

---Function executes full coloring of a pull and it's blips
function MDT:ColorPull(colorValues, pullIdx, preset, bypass, exportColorBlind) -- bypass can be passed as true to color even when automatic coloring is toggled off
  local colorPaletteInfo = MDT:GetPresetColorPaletteInfo(preset)
  local pullIdx = pullIdx or MDT:GetCurrentPull()
  if (pullIdx) then
    local colorValues
    local numberColors
    local r, g, b
    if colorPaletteInfo.autoColoring or bypass == true then
      --Force color blind mode locally, will not alter the color values saved to a preset
      if db.colorPaletteInfo.forceColorBlindMode == true and not exportColorBlind then
        --Local color blind mode, will not alter the colorPaletteInfo saved to a preset
        colorValues = colorValues or colorPaletteValues[colorValues] or colorPaletteValues[5]
        numberColors = #colorValues
      else
        --Regular coloring
        colorValues = colorValues or colorPaletteValues[colorValues] or colorPaletteInfo.colorPaletteIdx == 6 and colorPaletteInfo.customPaletteValues or colorPaletteValues[colorPaletteInfo.colorPaletteIdx]
        numberColors = colorPaletteInfo.colorPaletteIdx == 6 and colorPaletteInfo.numberCustomColors or #colorValues -- tables must start from 1 and have no blank rows
      end
      local colorIdx = (pullIdx - 1) % numberColors + 1
      r, g, b = colorValues[colorIdx][1], colorValues[colorIdx][2], colorValues[colorIdx][3]

      MDT:DungeonEnemies_SetPullColor(pullIdx, r, g, b)
      MDT:UpdatePullButtonColor(pullIdx, r, g, b)
      MDT:DungeonEnemies_UpdateBlipColors(pullIdx, r, g, b)
    end
  end
end

---Loops over all pulls in a preset and colors them
function MDT:ColorAllPulls(colorValues, startFrom, bypass, exportColorBlind)
  local preset = self:GetCurrentPreset()
  local startFrom = startFrom or 0
  for pullIdx, _ in pairs(preset.value.pulls) do
    if pullIdx >= startFrom then
      MDT:ColorPull(colorValues, pullIdx, preset, bypass, exportColorBlind)
    end
  end
end

function MDT:MakePullSelectionButtons(frame)
  frame.PullButtonScrollGroup = AceGUI:Create("SimpleGroup")
  frame.PullButtonScrollGroup:SetWidth(248)
  frame.PullButtonScrollGroup:SetHeight(410)
  frame.PullButtonScrollGroup:SetPoint("TOPLEFT", frame.WidgetGroup.frame, "BOTTOMLEFT", -4, -32)
  frame.PullButtonScrollGroup:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", 0, 30)
  frame.PullButtonScrollGroup:SetLayout("Fill")
  frame.PullButtonScrollGroup.frame:SetParent(frame)
  if not frame.PullButtonScrollGroup.frame.SetBackdrop then
    Mixin(frame.PullButtonScrollGroup.frame, BackdropTemplateMixin)
  end
  frame.PullButtonScrollGroup.frame:SetBackdropColor(1, 1, 1, 0)
  frame.PullButtonScrollGroup.frame:Hide()

  self:FixAceGUIShowHide(frame.PullButtonScrollGroup)

  frame.pullButtonsScrollFrame = AceGUI:Create("ScrollFrame")
  frame.pullButtonsScrollFrame:SetLayout("Flow")

  frame.PullButtonScrollGroup:AddChild(frame.pullButtonsScrollFrame)

  frame.newPullButtons = {}
  --rightclick context menu
  frame.optionsDropDown = CreateFrame("frame", "MDTPullButtonsOptionsDropDown", nil, "UIDropDownMenuTemplate")
end

function MDT:PresetsAddPull(index, data, preset)
  preset = preset or self:GetCurrentPreset()
  if not data then data = {} end
  if index then
    tinsert(preset.value.pulls, index, data)
  else
    tinsert(preset.value.pulls, data)
  end
  self:EnsureDBTables()
end

---Merges a list of pulls and inserts them at a specified destination.
---
---@param pulls table List of all pull indices, that shall be merged (and deleted). If pulls
---                   is a number, then the pull list is automatically generated from pulls
---                   and destination.
---@param destination number The pull index, where the merged pull shall be inserted.
---
---@author Dradux
function MDT:PresetsMergePulls(pulls, destination)
  if type(pulls) == "number" then
    pulls = { pulls, destination }
  end

  if not destination then
    destination = pulls[#pulls]
  end

  local count_if = self.U.count_if

  local newPull = {}
  local removed_pulls = {}

  for _, pullIdx in ipairs(pulls) do
    local offset = count_if(removed_pulls, function(entry)
      return entry < pullIdx
    end)

    local index = pullIdx - offset
    local pull = self:GetCurrentPreset().value.pulls[index]

    for enemyIdx, clones in pairs(pull) do
      if string.match(enemyIdx, "^%d+$") then
        -- it's really an enemy index
        if tonumber(enemyIdx) then
          if not newPull[enemyIdx] then
            newPull[enemyIdx] = clones
          else
            for k, v in pairs(clones) do
              if newPull[enemyIdx][k] ~= nil then
                local newIndex = #newPull[enemyIdx] + 1
                newPull[enemyIdx][newIndex] = v
              else
                newPull[enemyIdx][k] = v
              end
            end
          end
        end
      else
        -- it's another pull option like color
        local optionName = enemyIdx
        local optionValue = clones
        newPull[optionName] = optionValue
      end
    end

    self:PresetsDeletePull(index)
    tinsert(removed_pulls, pullIdx)
  end

  local offset = count_if(removed_pulls, function(entry)
    return entry < destination
  end)

  local index = destination - offset
  self:PresetsAddPull(index, newPull)
  return index
end

function MDT:PresetsDeletePull(p, preset)
  preset = preset or self:GetCurrentPreset()
  if p == preset.value.currentPull then
    preset.value.currentPull = math.max(p - 1, 1)
  end
  tremove(preset.value.pulls, p)
end

function MDT:GetPulls(preset)
  preset = preset or self:GetCurrentPreset()
  return preset.value.pulls
end

function MDT:GetPullsNum(preset)
  preset = preset or self:GetCurrentPreset()
  return #preset.value.pulls
end

function MDT:CopyObject(obj, seen)
  if type(obj) ~= 'table' then return obj end
  if seen and seen[obj] then return seen[obj] end
  local s = seen or {}
  local res = setmetatable({}, getmetatable(obj))
  s[obj] = res
  for k, v in pairs(obj) do res[self:CopyObject(k, s)] = self:CopyObject(v, s) end
  return res
end

function MDT:PresetsSwapPulls(p1, p2)
  local p1copy = self:CopyObject(self:GetCurrentPreset().value.pulls[p1])
  local p2copy = self:CopyObject(self:GetCurrentPreset().value.pulls[p2])
  self:GetCurrentPreset().value.pulls[p1] = p2copy
  self:GetCurrentPreset().value.pulls[p2] = p1copy
end

function MDT:SetSelectionToPull(pull, ignoreHulls)
  --if pull is not specified set pull to last pull in preset (for adding new pulls)
  if not pull then
    local count = 0
    for k, v in pairs(MDT:GetCurrentPreset().value.pulls) do
      count = count + 1
    end
    pull = count
  end

  --SaveCurrentPresetPull
  if type(pull) == "number" and pull > 0 then
    MDT:GetCurrentPreset().value.currentPull = pull
    MDT:GetCurrentPreset().value.selection = { pull }
    MDT:PickPullButton(pull)

    MDT:DungeonEnemies_UpdateSelected(pull, nil, ignoreHulls)
  elseif type(pull) == "table" then
    MDT:GetCurrentPreset().value.currentPull = pull[#pull]
    MDT:GetCurrentPreset().value.selection = pull

    MDT:ClearPullButtonPicks()
    for _, pullIdx in ipairs(MDT:GetSelection()) do
      MDT:PickPullButton(pullIdx, true)
      MDT:DungeonEnemies_UpdateSelected(pullIdx, nil, ignoreHulls)
    end
  end
  MDT:PullClickAreaOnLeave()
end

---Updates the portraits display of a button to show which and how many npcs are selected
function MDT:UpdatePullButtonNPCData(idx)
  if db.devMode then return end
  local preset = MDT:GetCurrentPreset()
  local frame = MDT.main_frame.sidePanel
  local enemyTable = {}
  if preset.value.pulls[idx] then
    local enemyTableIdx = 0
    for enemyIdx, clones in pairs(preset.value.pulls[idx]) do
      if tonumber(enemyIdx) then
        --check if enemy exists, remove if not
        if MDT.dungeonEnemies[db.currentDungeonIdx][enemyIdx] then
          local incremented = false
          local npcId = MDT.dungeonEnemies[db.currentDungeonIdx][enemyIdx]["id"]
          local name = MDT.dungeonEnemies[db.currentDungeonIdx][enemyIdx]["name"]
          local creatureType = MDT.dungeonEnemies[db.currentDungeonIdx][enemyIdx]["creatureType"]
          local level = MDT.dungeonEnemies[db.currentDungeonIdx][enemyIdx]["level"]
          local baseHealth = MDT.dungeonEnemies[db.currentDungeonIdx][enemyIdx]["health"]
          for k, cloneIdx in pairs(clones) do
            --check if clone exists, remove if not
            if MDT.dungeonEnemies[db.currentDungeonIdx][enemyIdx]["clones"][cloneIdx] then
              if self:IsCloneIncluded(enemyIdx, cloneIdx) then
                if not incremented then
                  enemyTableIdx = enemyTableIdx + 1
                  incremented = true
                end
                if not enemyTable[enemyTableIdx] then enemyTable[enemyTableIdx] = {} end
                enemyTable[enemyTableIdx].quantity = enemyTable[enemyTableIdx].quantity or 0
                enemyTable[enemyTableIdx].npcId = npcId
                enemyTable[enemyTableIdx].count = MDT.dungeonEnemies[db.currentDungeonIdx][enemyIdx]["count"]
                enemyTable[enemyTableIdx].displayId = MDT.dungeonEnemies[db.currentDungeonIdx][enemyIdx]["displayId"]
                enemyTable[enemyTableIdx].quantity = enemyTable[enemyTableIdx].quantity + 1
                enemyTable[enemyTableIdx].name = name
                enemyTable[enemyTableIdx].level = level
                enemyTable[enemyTableIdx].creatureType = creatureType
                enemyTable[enemyTableIdx].baseHealth = baseHealth
                enemyTable[enemyTableIdx].ignoreFortified = MDT.dungeonEnemies[db.currentDungeonIdx][enemyIdx]["ignoreFortified"]
                enemyTable[enemyTableIdx].isBoss = MDT.dungeonEnemies[db.currentDungeonIdx][enemyIdx]["isBoss"]
              end
            end
          end
        end
      end
    end
  end
  frame.newPullButtons[idx]:SetNPCData(enemyTable)

  local pullForces = MDT:CountForces(idx, false)
  local totalForcesMax = MDT.dungeonTotalCount[db.currentDungeonIdx].normal

  --count per health
  if pullForces > 0 then
    frame.newPullButtons[idx]:ShowCountPerHealth(true, pullForces, totalForcesMax)
  else
    frame.newPullButtons[idx]:ShowCountPerHealth(true, pullForces, totalForcesMax)
  end
end

---Reloads all pull buttons in the scroll frame
function MDT:ReloadPullButtons(force)
  MDT:Async(function()
    local frame = MDT.main_frame.sidePanel
    if not frame.pullButtonsScrollFrame then return end
    local preset = db.presets[db.currentDungeonIdx][db.currentPreset[db.currentDungeonIdx]]
    --store scroll value
    local oldScrollValue = frame.pullButtonsScrollFrame.localstatus.scrollvalue
    --first release all children of the scroll frame
    frame.pullButtonsScrollFrame:ReleaseChildren()
    coroutine.yield()
    local maxPulls = 0
    for k, v in pairs(preset.value.pulls) do
      maxPulls = maxPulls + 1
    end
    --add new children to the scrollFrame, the frames are from the widget pool so no memory is wasted
    local idx = 0
    for k, pull in ipairs(preset.value.pulls) do
      idx = idx + 1
      ---@diagnostic disable-next-line: param-type-mismatch
      frame.newPullButtons[idx] = AceGUI:Create("MDTPullButton")
      frame.newPullButtons[idx]:SetMaxPulls(maxPulls)
      frame.newPullButtons[idx]:SetIndex(idx)
      MDT:UpdatePullButtonNPCData(idx)
      frame.newPullButtons[idx]:Initialize()
      frame.newPullButtons[idx]:Enable()
      frame.pullButtonsScrollFrame:AddChild(frame.newPullButtons[idx])
      coroutine.yield()
    end
    --add the "new pull" button
    ---@diagnostic disable-next-line: param-type-mismatch
    frame.newPullButton = AceGUI:Create("MDTNewPullButton")
    frame.newPullButton:Initialize()
    frame.newPullButton:Enable()
    frame.pullButtonsScrollFrame:AddChild(frame.newPullButton)
    --set the scroll value back to the old value
    frame.pullButtonsScrollFrame.scrollframe.obj:SetScroll(oldScrollValue)
    frame.pullButtonsScrollFrame.scrollframe.obj:FixScroll()
    if self:GetCurrentPreset().value.currentPull then
      self:PickPullButton(self:GetCurrentPreset().value.currentPull)
    end
    MDT:ColorAllPulls(nil, 0)
    MDT:DrawAllHulls(preset.value.pulls, force)
  end, "ReloadPullButtons", true)
end

---Deselects all pull buttons
function MDT:ClearPullButtonPicks()
  local frame = MDT.main_frame.sidePanel
  for k, v in pairs(frame.newPullButtons) do
    v:ClearPick()
  end
end

---Selects the current pull button and deselects all other buttons
function MDT:PickPullButton(idx, keepPicked)
  if db.devMode then return end

  if not keepPicked then
    MDT:ClearPullButtonPicks()
  end
  local frame = MDT.main_frame.sidePanel
  if frame.newPullButtons[idx] then
    frame.newPullButtons[idx]:Pick()
  end
end

---Creates a new pull in the current preset and calls ReloadPullButtons to reflect the change in the scrollframe
function MDT:AddPull(index)
  MDT:PresetsAddPull(index)
  MDT:ReloadPullButtons()
  MDT:SetSelectionToPull(index)
end

function MDT:SetAutomaticColor(index)
  --if not db.colorPaletteInfo.autoColoring then return end

  local H = (index - 1) * 360 / 12 + 120 --db.automaticColorsNum
  --if db.alternatingColors and index % 2 == 0 then
  --	H = H + 180
  --end

  local V = 1 --0.5451
  --if db.brightColors then V = 1 end

  local r, g, b = self:HSVtoRGB(H, 0.7554, V)

  --self:DungeonEnemies_SetPullColor(index, r, g, b)
  --self:UpdatePullButtonColor(index, r, g, b)
  --self:DungeonEnemies_UpdateBlipColors(index, r, g, b)
  --if self.liveSessionActive and self:GetCurrentPreset().uid == self.livePresetUID then
  --	self:LiveSession_QueueColorUpdate()
  --end
end

function MDT:UpdateAutomaticColors(index)
  if not db.colorPaletteInfo.autoColoring then return end
  for i = index or 1, self:GetPullsNum() do
    self:SetAutomaticColor(i)
  end
end

---Clears all the npcs out of a pull
function MDT:ClearPull(index)
  table.wipe(db.presets[db.currentDungeonIdx][db.currentPreset[db.currentDungeonIdx]].value.pulls[index])
  MDT:EnsureDBTables()
  MDT:ReloadPullButtons()
  MDT:SetSelectionToPull(index)
  --MDT:SetAutomaticColor(index)
end

---Moves the selected pull up
function MDT:MovePullUp(index)
  MDT:PresetsSwapPulls(index, index - 1)
  MDT:ReloadPullButtons()
  MDT:SetSelectionToPull(index - 1)
  --MDT:UpdateAutomaticColors(index - 1)
end

---Moves the selected pull down
function MDT:MovePullDown(index)
  MDT:PresetsSwapPulls(index, index + 1)
  MDT:ReloadPullButtons()
  MDT:SetSelectionToPull(index + 1)
  --MDT:UpdateAutomaticColors(index)
end

---Deletes the selected pull and makes sure that a pull will be selected afterwards
function MDT:DeletePull(index)
  local pulls = self:GetPulls()
  if #pulls == 1 then return end
  self:PresetsDeletePull(index)
  self:ReloadPullButtons()
  self:UpdateProgressbar()
  local pullCount = 0
  for k, v in pairs(pulls) do
    pullCount = pullCount + 1
  end
  if index > pullCount then index = pullCount end
  self:SetSelectionToPull(index)
  --self:UpdateAutomaticColors(index)
end

function MDT:RenamePreset(renameText, takeOwnership)
  local preset = db.presets[db.currentDungeonIdx][db.currentPreset[db.currentDungeonIdx]]
  preset.text = renameText
  if takeOwnership then
    MDT:EnsurePresetCreatedBy(preset, true)
    preset.uid = nil
    MDT:SetUniqueID(preset)
  end
  MDT.main_frame.RenameFrame:Hide()
  MDT:UpdatePresetDropDown()
end

function MDT:GetFirstNotSelectedPullButton(start, direction)
  if not direction then
    direction = -1
  elseif direction == "UP" then
    direction = -1
  elseif direction == "DOWN" then
    direction = 1
  end

  local pullIdx = start
  while MDT.U.contains(MDT:GetCurrentPreset().value.selection, pullIdx)
    and MDT.U.isInRange(pullIdx, 1, #MDT:GetCurrentPreset().value.pulls) do
    pullIdx = pullIdx + direction
  end

  if not MDT.U.isInRange(pullIdx, 1, #MDT:GetCurrentPreset().value.pulls) then
    return
  end

  return pullIdx
end

function MDT:MakeRenameFrame(frame)
  frame.RenameFrame = AceGUI:Create("Frame")
  frame.RenameFrame.frame:SetParent(frame)
  frame.RenameFrame.frame:SetFrameStrata("DIALOG")
  frame.RenameFrame:SetTitle(L["Rename Preset"])
  frame.RenameFrame:SetWidth(350)
  frame.RenameFrame:SetHeight(180)
  frame.RenameFrame:EnableResize(false)
  frame.RenameFrame:SetLayout("Flow")
  frame.RenameFrame:SetCallback("OnClose", function(widget)

  end)
  frame.RenameFrame.statustext:GetParent():Hide()
  frame.RenameFrame:Hide()

  local renameText
  frame.RenameFrame.Editbox = AceGUI:Create("EditBox")
  frame.RenameFrame.Editbox:SetLabel(L["Preset Name"]..":")
  frame.RenameFrame.Editbox:SetWidth(200)
  frame.RenameFrame.Editbox:SetCallback("OnTextChanged", function(widget, event, text)
    --check if name is valid, block button if so, unblock if valid
    if MDT:SanitizePresetName(text) then
      frame.RenameFrame.PresetRenameLabel:SetText(nil)
      frame.RenameFrame.RenameButton:SetDisabled(false)
      frame.RenameFrame.RenameButton.text:SetTextColor(1, 0.8196, 0)
      renameText = text
    else
      frame.RenameFrame.PresetRenameLabel:SetText(string.format(L["Cannot rename preset to '%s'"], text))
      frame.RenameFrame.RenameButton:SetDisabled(true)
      frame.RenameFrame.RenameButton.text:SetTextColor(0.5, 0.5, 0.5)
      renameText = nil
    end
    frame.RenameFrame:DoLayout()
  end)
  frame.RenameFrame.Editbox:SetCallback("OnEnterPressed", function(widget, event, text)
    if MDT:SanitizePresetName(renameText) then
      MDT:RenamePreset(renameText, frame.RenameFrame.TakeOwnershipCheckbox:GetValue())
    end
  end)
  frame.RenameFrame.Editbox:DisableButton(true)

  frame.RenameFrame:AddChild(frame.RenameFrame.Editbox)

  frame.RenameFrame.TakeOwnershipCheckbox = AceGUI:Create("CheckBox")
  frame.RenameFrame.TakeOwnershipCheckbox:SetLabel(L["Mark as my route"])
  frame.RenameFrame.TakeOwnershipCheckbox:SetWidth(200)
  frame.RenameFrame:AddChild(frame.RenameFrame.TakeOwnershipCheckbox)

  frame.RenameFrame.RenameButton = AceGUI:Create("Button")
  frame.RenameFrame.RenameButton:SetText(L["Rename"])
  frame.RenameFrame.RenameButton:SetWidth(100)
  frame.RenameFrame.RenameButton:SetCallback("OnClick", function()
    MDT:RenamePreset(renameText, frame.RenameFrame.TakeOwnershipCheckbox:GetValue())
  end)
  frame.RenameFrame:AddChild(frame.RenameFrame.RenameButton)

  frame.RenameFrame.PresetRenameLabel = AceGUI:Create("Label")
  frame.RenameFrame.PresetRenameLabel:SetText(nil)
  frame.RenameFrame.PresetRenameLabel:SetWidth(390)
  frame.RenameFrame.PresetRenameLabel:SetColor(1, 0, 0)
  frame.RenameFrame:AddChild(frame.RenameFrame.PresetRenameLabel)
end

---Creates the frame used to export presets to a string which can be uploaded to text sharing websites like pastebin
function MDT:MakeExportFrame(frame)
  frame.ExportFrame = AceGUI:Create("Frame")
  frame.ExportFrame.frame:SetParent(frame)
  frame.ExportFrame.frame:SetFrameStrata("DIALOG")
  frame.ExportFrame:SetTitle(L["Export"])
  frame.ExportFrame:SetWidth(600)
  frame.ExportFrame:SetHeight(400)
  frame.ExportFrame:EnableResize(false)
  frame.ExportFrame:SetLayout("Flow")
  frame.ExportFrame:SetCallback("OnClose", function(widget)
    frame.ExportFrame.statustext:GetParent():Hide()
  end)
  frame.ExportFrameEditbox = AceGUI:Create("MultiLineEditBox")
  frame.ExportFrameEditbox:SetWidth(600)
  frame.ExportFrameEditbox:DisableButton(true)
  frame.ExportFrameEditbox:SetNumLines(20)

  function frame.ExportFrameEditbox:SelectAll()
    local text = frame.ExportFrameEditbox:GetText()
    frame.ExportFrameEditbox:HighlightText(0, string.len(text))
    frame.ExportFrameEditbox:SetFocus()
  end

  local selectAllButton
  frame.ExportFrameEditbox.editBox:HookScript('OnEditFocusLost', function()
    MDT.copyHelper:Hide()
  end);

  frame.ExportFrameEditbox.editBox:SetScript('OnKeyUp', function(_, key)
    if (MDT.copyHelper:WasControlKeyDown() and key == 'A') then
      return
    end
    if (MDT.copyHelper:WasControlKeyDown() and key == 'C') then
      frame.ExportFrameEditbox:ClearFocus();
      frame.ExportFrame:Hide()
      MDT.copyHelper:SmartFadeOut()
      return
    end
  end);

  frame.ExportFrameSelectAllButton = AceGUI:Create("Button")
  selectAllButton = frame.ExportFrameSelectAllButton
  selectAllButton:SetText(L["Select all"])
  selectAllButton:SetHeight(40)
  selectAllButton:SetCallback("OnClick", function(widget, callbackName, value)
    frame.ExportFrameEditbox:SelectAll()
    MDT.copyHelper:SmartShow(frame, 0, 50)
  end)

  frame.ExportFrame:AddChild(frame.ExportFrameEditbox)
  frame.ExportFrame:AddChild(selectAllButton)
  frame.ExportFrame:Hide()
end

---MakeDeleteConfirmationFrame
---Creates the delete confirmation dialog that pops up when a user wants to delete a preset
function MDT:MakeDeleteConfirmationFrame(frame)
  frame.DeleteConfirmationFrame = AceGUI:Create("Frame")
  frame.DeleteConfirmationFrame.frame:SetParent(frame)
  frame.DeleteConfirmationFrame.frame:SetFrameStrata("DIALOG")
  frame.DeleteConfirmationFrame:SetTitle(L["Delete Preset"])
  frame.DeleteConfirmationFrame:SetWidth(250)
  frame.DeleteConfirmationFrame:SetHeight(120)
  frame.DeleteConfirmationFrame:EnableResize(false)
  frame.DeleteConfirmationFrame:SetLayout("Flow")
  frame.DeleteConfirmationFrame:SetCallback("OnClose", function(widget)

  end)
  frame.DeleteConfirmationFrame.statustext:GetParent():Hide()

  frame.DeleteConfirmationFrame.label = AceGUI:Create("Label")
  frame.DeleteConfirmationFrame.label:SetWidth(390)
  frame.DeleteConfirmationFrame.label:SetHeight(10)
  --frame.DeleteConfirmationFrame.label:SetColor(1,0,0)
  frame.DeleteConfirmationFrame:AddChild(frame.DeleteConfirmationFrame.label)

  frame.DeleteConfirmationFrame.OkayButton = AceGUI:Create("Button")
  frame.DeleteConfirmationFrame.OkayButton:SetText(L["Delete"])
  frame.DeleteConfirmationFrame.OkayButton:SetWidth(100)
  frame.DeleteConfirmationFrame.OkayButton:SetCallback("OnClick", function()
    MDT:DeletePreset(db.currentPreset[db.currentDungeonIdx])
    frame.DeleteConfirmationFrame:Hide()
  end)
  frame.DeleteConfirmationFrame.CancelButton = AceGUI:Create("Button")
  frame.DeleteConfirmationFrame.CancelButton:SetText(L["Cancel"])
  frame.DeleteConfirmationFrame.CancelButton:SetWidth(100)
  frame.DeleteConfirmationFrame.CancelButton:SetCallback("OnClick", function()
    frame.DeleteConfirmationFrame:Hide()
  end)

  frame.DeleteConfirmationFrame:AddChild(frame.DeleteConfirmationFrame.OkayButton)
  frame.DeleteConfirmationFrame:AddChild(frame.DeleteConfirmationFrame.CancelButton)
  frame.DeleteConfirmationFrame:Hide()
end

---Creates the clear confirmation dialog that pops up when a user wants to clear a preset
function MDT:MakeClearConfirmationFrame(frame)
  frame.ClearConfirmationFrame = AceGUI:Create("Frame")
  frame.ClearConfirmationFrame.frame:SetParent(frame)
  frame.ClearConfirmationFrame.frame:SetFrameStrata("DIALOG")
  frame.ClearConfirmationFrame:SetTitle(L["Reset Preset"])
  frame.ClearConfirmationFrame:SetWidth(250)
  frame.ClearConfirmationFrame:SetHeight(120)
  frame.ClearConfirmationFrame:EnableResize(false)
  frame.ClearConfirmationFrame:SetLayout("Flow")
  frame.ClearConfirmationFrame:SetCallback("OnClose", function(widget)

  end)
  frame.ClearConfirmationFrame.statustext:GetParent():Hide()

  frame.ClearConfirmationFrame.label = AceGUI:Create("Label")
  frame.ClearConfirmationFrame.label:SetWidth(390)
  frame.ClearConfirmationFrame.label:SetHeight(10)
  --frame.DeleteConfirmationFrame.label:SetColor(1,0,0)
  frame.ClearConfirmationFrame:AddChild(frame.ClearConfirmationFrame.label)

  frame.ClearConfirmationFrame.OkayButton = AceGUI:Create("Button")
  frame.ClearConfirmationFrame.OkayButton:SetText(L["Reset"])
  frame.ClearConfirmationFrame.OkayButton:SetWidth(100)
  frame.ClearConfirmationFrame.OkayButton:SetCallback("OnClick", function()
    self:ClearPreset(self:GetCurrentPreset())
    if self.liveSessionActive and self:GetCurrentPreset().uid == self.livePresetUID then
      MDT:LiveSession_SendCommand(
        "clear")
    end
    frame.ClearConfirmationFrame:Hide()
  end)
  frame.ClearConfirmationFrame.CancelButton = AceGUI:Create("Button")
  frame.ClearConfirmationFrame.CancelButton:SetText(L["Cancel"])
  frame.ClearConfirmationFrame.CancelButton:SetWidth(100)
  frame.ClearConfirmationFrame.CancelButton:SetCallback("OnClick", function()
    frame.ClearConfirmationFrame:Hide()
  end)

  frame.ClearConfirmationFrame:AddChild(frame.ClearConfirmationFrame.OkayButton)
  frame.ClearConfirmationFrame:AddChild(frame.ClearConfirmationFrame.CancelButton)
  frame.ClearConfirmationFrame:Hide()
end

-- AceGUI flow layout force-shows every child during DoLayout, so optional widgets
-- must be removed from the child list when inactive.
local function addConfirmationCheckbox(f)
  for _, child in ipairs(f.children) do
    if child == f.CheckBox then return end
  end
  f:AddChild(f.CheckBox, f.OkayButton)
end

local function removeConfirmationCheckbox(f)
  for index, child in ipairs(f.children) do
    if child == f.CheckBox then
      tremove(f.children, index)
      f.CheckBox.parent = nil
      break
    end
  end
  f.CheckBox.frame:Hide()
end

---Creates a generic dialog that pops up when a user wants needs confirmation for an action
function MDT:OpenConfirmationFrame(width, height, title, buttonText, prompt, callback, buttonText2, callback2,
                                   fireCancelOnClose, checkboxText, checkboxValue, checkboxCallback)
  local f
  if MDT.main_frame then
    f = MDT.main_frame.ConfirmationFrame
  else
    f = MDT.tempConfirmationFrame
  end
  if not f then
    if MDT.main_frame then
      MDT.main_frame.ConfirmationFrame = AceGUI:Create("Frame")
      MDT.main_frame.ConfirmationFrame.frame:SetParent(MDT.main_frame)
      MDT.main_frame.ConfirmationFrame.frame:SetFrameStrata("DIALOG")
      f = MDT.main_frame.ConfirmationFrame
    else
      MDT.tempConfirmationFrame = AceGUI:Create("Frame")
      f = MDT.tempConfirmationFrame
    end
    f:EnableResize(false)
    f:SetLayout("Flow")
    f:SetCallback("OnClose", function(widget)
    end)
    f.statustext:GetParent():Hide()

    f.label = AceGUI:Create("Label")
    f.label:SetWidth(390)
    f.label:SetHeight(height - 20)
    f:AddChild(f.label)

    f.CheckBox = AceGUI:Create("CheckBox")
    f.CheckBox:SetWidth(390)
    f.CheckBox.frame:Hide()

    f.OkayButton = AceGUI:Create("Button")
    f.OkayButton:SetWidth(100)
    f:AddChild(f.OkayButton)

    f.CancelButton = AceGUI:Create("Button")
    f.CancelButton:SetText(L["Cancel"])
    f.CancelButton:SetWidth(100)
    f.CancelButton:SetCallback("OnClick", function()
      if MDT.main_frame then MDT:HideAllDialogs() else f:Hide() end
    end)
    f:AddChild(f.CancelButton)
  end
  f:SetWidth(width or 250)
  f:SetHeight(height or 120)
  f:SetTitle(title)
  f.label:SetHeight(math.max((height or 120) - (checkboxText and 80 or 20), 20))
  f.OkayButton:SetText(buttonText)
  f.OkayButton:SetCallback("OnClick", function()
    if callback then callback() end
    MDT:HideAllDialogs()
  end)
  if checkboxText then
    addConfirmationCheckbox(f)
    f.CheckBox:SetLabel(checkboxText)
    f.CheckBox:SetValue(checkboxValue)
    f.CheckBox:SetCallback("OnValueChanged", function(widget, callbackName, value)
      if checkboxCallback then checkboxCallback(value) end
    end)
    f.CheckBox.frame:Show()
  else
    f.CheckBox:SetCallback("OnValueChanged", function()
    end)
    f.CheckBox:SetLabel("")
    f.CheckBox:SetValue(false)
    removeConfirmationCheckbox(f)
  end
  if buttonText2 then
    f.CancelButton:SetText(buttonText2)
  else
    f.CancelButton:SetText(L["Cancel"])
  end
  if callback2 then
    f.CancelButton:SetCallback("OnClick", function()
      callback2()
      MDT:HideAllDialogs()
    end)
  else
    f.CancelButton:SetCallback("OnClick", function()
      if MDT.main_frame then MDT:HideAllDialogs() else f:Hide() end
    end)
  end
  if fireCancelOnClose and callback2 then
    f:SetCallback("OnClose", function(widget)
      callback2()
    end)
  else
    f:SetCallback("OnClose", function(widget)
    end)
  end
  if MDT.main_frame then MDT:HideAllDialogs() end
  f:ClearAllPoints()
  f:SetPoint("CENTER", MDT.main_frame or UIParent, "CENTER", 0, 50)
  f.label:SetText(prompt)
  f:Show()
  f:DoLayout()
end

function MDT:Round(number, decimals)
  return (("%%.%df"):format(decimals)):format(number)
end

function MDT:RGBToHex(r, g, b)
  r = r * 255
  g = g * 255
  b = b * 255
  return ("%.2x%.2x%.2x"):format(r, g, b)
end

function MDT:HexToRGB(rgb)
  if string.len(rgb) == 6 then
    local r, g, b
    r, g, b = tonumber('0x'..strsub(rgb, 0, 2)), tonumber('0x'..strsub(rgb, 3, 4)), tonumber('0x'..
      strsub(rgb, 5, 6))
    if not r then r = 0 else r = r / 255 end
    if not g then g = 0 else g = g / 255 end
    if not b then b = 0 else b = b / 255 end
    return r, g, b
  else
    return
  end
end

---https://en.wikipedia.org/wiki/HSL_and_HSV#HSV_to_RGB_alternative
function MDT:HSVtoRGB(H, S, V)
  H = H % 361

  local function f(n)
    local k = (n + H / 60) % 6
    return V - V * S * math.max(math.min(k, 4 - k, 1), 0)
  end

  return f(5), f(3), f(1)
end

function MDT:DeepCopy(orig)
  local orig_type = type(orig)
  local copy
  if orig_type == 'table' then
    copy = {}
    for orig_key, orig_value in next, orig, nil do
      copy[MDT:DeepCopy(orig_key)] = MDT:DeepCopy(orig_value)
    end
    setmetatable(copy, MDT:DeepCopy(getmetatable(orig)))
  else -- number, string, boolean, etc
    copy = orig
  end
  return copy
end

---scale if preset comes from live session
function MDT:StorePresetObject(obj, ignoreScale, preset)
  --adjust scale
  if not ignoreScale then
    local scale = self:GetScale()
    if obj.n then
      obj.d[1] = obj.d[1] * (1 / scale)
      obj.d[2] = obj.d[2] * (1 / scale)
    else
      for idx, coord in pairs(obj.l) do
        obj.l[idx] = self:Round(obj.l[idx] * (1 / scale), 1)
      end
    end
  end
  preset = preset or self:GetCurrentPreset()
  preset.objects = preset.objects or {}
  --we insert the object infront of the first hidden oject
  local pos = 1
  for k, v in ipairs(preset.objects) do
    pos = pos + 1
    if v.d[4] == false then
      pos = pos - 1
    end
  end
  if pos > 1 then
    tinsert(preset.objects, pos, self:DeepCopy(obj))
  else
    tinsert(preset.objects, self:DeepCopy(obj))
  end
end

---excluding notes, these are handled in OverrideScrollFrameScripts
function MDT:UpdatePresetObjectOffsets(idx, x, y, preset, silent)
  --adjust coords to scale
  local scale = self:GetScale()
  x = self:Round(x * (1 / scale), 1)
  y = self:Round(y * (1 / scale), 1)
  preset = preset or self:GetCurrentPreset()
  for objectIndex, obj in pairs(preset.objects) do
    if objectIndex == idx then
      for coordIdx, coord in pairs(obj.l) do
        if coordIdx % 2 == 1 then
          obj.l[coordIdx] = coord - x
        else
          obj.l[coordIdx] = coord - y
        end
      end
    end
  end
  --redraw everything
  if not silent then self:DrawAllPresetObjects() end
end

---Draws all Preset objects on the map canvas/sublevel
function MDT:DrawAllPresetObjects()
  MDT:Async(function()
    self:ReleaseAllActiveTextures()
    coroutine.yield()
    local scale = self:GetScale()
    local currentPreset = self:GetCurrentPreset()
    local currentSublevel = self:GetCurrentSubLevel()
    currentPreset.objects = currentPreset.objects or {}
    for objectIndex, obj in pairs(currentPreset.objects) do
      self:DrawPresetObject(obj, objectIndex, scale, currentPreset, currentSublevel)
      coroutine.yield()
    end
  end, "DrawAllPresetObjects")
end

---Draws specific preset object
function MDT:DrawPresetObject(obj, objectIndex, scale, currentPreset, currentSublevel)
  if not objectIndex then
    for oIndex, o in pairs(currentPreset.objects) do
      if o == obj then
        objectIndex = oIndex
        break
      end
    end
  end
  --d: size,lineFactor,sublevel,shown,colorstring,drawLayer,[smooth]
  --l: x1,y1,x2,y2,...
  local color = {}
  if obj.d[3] == currentSublevel and obj.d[4] then
    if obj.n then
      local x = obj.d[1] * scale
      local y = obj.d[2] * scale
      local text = obj.d[5]
      self:DrawNote(x, y, text, objectIndex)
    else
      obj.d[1] = obj.d[1] or 5
      color.r, color.g, color.b = self:HexToRGB(obj.d[5])
      --check if color is valid
      if not color.r or not color.g or not color.b then
        color.r, color.g, color.b = 1, 1, 1
        obj.d[5] = "ffffff"
      end
      --lines
      local x1, y1, x2, y2
      local lastx, lasty
      for _, coord in pairs(obj.l) do
        if not x1 then
          x1 = coord
        elseif not y1 then
          y1 = coord
        elseif not x2 then
          x2 = coord
          lastx = coord
        elseif not y2 then
          y2 = coord
          lasty = coord
        end
        if x1 and y1 and x2 and y2 then
          x1 = x1 * scale
          x2 = x2 * scale
          y1 = y1 * scale
          y2 = y2 * scale
          self:DrawLine(x1, y1, x2, y2, obj.d[1] * 0.3 * scale, color, obj.d[7], nil, obj.d[6], obj.d[2], nil,
            objectIndex)
          --circles if smooth
          if obj.d[7] then
            self:DrawCircle(x1, y1, obj.d[1] * 0.3 * scale, color, nil, obj.d[6], nil, objectIndex)
            self:DrawCircle(x2, y2, obj.d[1] * 0.3 * scale, color, nil, obj.d[6], nil, objectIndex)
          end
          x1, y1, x2, y2 = nil, nil, nil, nil
        end
      end
      --triangle
      if obj.t and lastx and lasty then
        lastx = lastx * scale
        lasty = lasty * scale
        self:DrawTriangle(lastx, lasty, obj.t[1], obj.d[1] * scale, color, nil, obj.d[6], nil, objectIndex)
      end
      --remove empty objects leftover from erasing
      if obj.l then
        local lineCount = 0
        for _, _ in pairs(obj.l) do
          lineCount = lineCount + 1
        end
        if lineCount == 0 then
          currentPreset.objects[objectIndex] = nil
        end
      end
    end
  end
end

---Deletes objects from the current preset in the current sublevel
function MDT:DeletePresetObjects(preset, silent)
  preset = preset or self:GetCurrentPreset()
  if preset == self:GetCurrentPreset() then silent = false end
  local currentSublevel = self:GetCurrentSubLevel()
  for objectIndex, obj in pairs(preset.objects) do
    if obj.d[3] == currentSublevel then
      preset.objects[objectIndex] = nil
    end
  end
  if not silent then self:DrawAllPresetObjects() end
end

---Undo the latest drawing
function MDT:PresetObjectStepBack(preset, silent, ignoreLiveSession)
  --keybind can be pressed before the frames are initialized
  if not MDT:AreFramesInitialized() then return end
  preset = preset or self:GetCurrentPreset()
  if preset == self:GetCurrentPreset() then silent = false end
  preset.objects = preset.objects or {}
  local length = 0
  for k, v in pairs(preset.objects) do
    length = length + 1
  end
  if length > 0 then
    for i = length, 1, -1 do
      if preset.objects[i] and preset.objects[i].d[4] then
        preset.objects[i].d[4] = false
        if not silent then self:DrawAllPresetObjects() end
        break
      end
    end
  end
  if self.liveSessionActive and not ignoreLiveSession then self:LiveSession_SendCommand("undo") end
end

---Redo the latest drawing
function MDT:PresetObjectStepForward(preset, silent, ignoreLiveSession)
  if not MDT:AreFramesInitialized() then return end
  preset = preset or MDT:GetCurrentPreset()
  if preset == self:GetCurrentPreset() then silent = false end
  preset.objects = preset.objects or {}
  local length = 0
  for k, v in ipairs(preset.objects) do
    length = length + 1
  end
  if length > 0 then
    for i = 1, length do
      if preset.objects[i] and not preset.objects[i].d[4] then
        preset.objects[i].d[4] = true
        if not silent then self:DrawAllPresetObjects() end
        break
      end
    end
  end
  if self.liveSessionActive and not ignoreLiveSession then self:LiveSession_SendCommand("redo") end
end

---Checks if the players is in a group/raid and returns the type
function MDT:IsPlayerInGroup()
  local inGroup = (UnitInRaid("player") and "RAID") or (IsInGroup() and "PARTY")
  return inGroup
end

function MDT:DropIndicator()
  local indicator = MDT.main_frame.drop_indicator
  if not indicator then
    indicator = CreateFrame("Frame", "MDT_DropIndicator")
    indicator:SetHeight(4)
    indicator:SetFrameStrata("FULLSCREEN")

    local texture = indicator:CreateTexture(nil, "OVERLAY", nil, 0)
    texture:SetBlendMode("ADD")
    texture:SetAllPoints(indicator)
    texture:SetTexture("Interface\\PaperDollInfoFrame\\UI-Character-Tab-Highlight")

    local icon = indicator:CreateTexture(nil, "OVERLAY", nil, 0)
    icon:ClearAllPoints()
    icon:SetSize(16, 16)
    icon:SetPoint("CENTER", indicator)

    indicator.icon = icon
    indicator.texture = texture
    MDT.main_frame.drop_indicator = indicator

    indicator:Hide()
  end

  return indicator
end

function MDT:IsShown_DropIndicator()
  local indicator = MDT:DropIndicator()
  return indicator:IsShown()
end

function MDT:Show_DropIndicator(target, pos)
  local indicator = MDT:DropIndicator()
  indicator:ClearAllPoints()
  if pos == "TOP" then
    indicator:SetPoint("BOTTOMLEFT", target.frame, "TOPLEFT", 0, -1)
    indicator:SetPoint("BOTTOMRIGHT", target.frame, "TOPRIGHT", 0, -1)
    indicator:Show()
  elseif pos == "BOTTOM" then
    indicator:SetPoint("TOPLEFT", target.frame, "BOTTOMLEFT", 0, 1)
    indicator:SetPoint("TOPRIGHT", target.frame, "BOTTOMRIGHT", 0, 1)
    indicator:Show()
  end
end

function MDT:Hide_DropIndicator()
  local indicator = MDT:DropIndicator()
  indicator:Hide()
end

function MDT:GetSelection()
  if not MDT:GetCurrentPreset().value.selection or #MDT:GetCurrentPreset().value.selection == 0 then
    MDT:GetCurrentPreset().value.selection = { MDT:GetCurrentPreset().value.currentPull }
  end

  return MDT:GetCurrentPreset().value.selection
end

function MDT:GetScrollingAmount(scrollFrame, pixelPerSecond)
  local viewheight = scrollFrame.frame.obj.content:GetHeight()
  return (pixelPerSecond / viewheight) * 1000
end

function MDT:CopyPullOptions(sourceIdx, destinationIdx)
  local preset = MDT:GetCurrentPreset()
  local pulls = preset.value.pulls
  local source = pulls[sourceIdx]
  local destination = pulls[destinationIdx]

  if source and destination then
    for optionName, optionValue in pairs(source) do
      -- Assure, that it is an option and not an enemy index
      if not string.match(optionName, "^%d+$") then
        destination[optionName] = optionValue
      end
    end
  end
end

function MDT:GetPullButton(pullIdx)
  local frame = MDT.main_frame.sidePanel
  return frame.newPullButtons[pullIdx]
end

function MDT:UpdatePullButtonColor(pullIdx, r, g, b)
  local button = MDT:GetPullButton(pullIdx)
  if not button then return end
  button.color.r, button.color.g, button.color.b = r, g, b
  button:UpdateColor()
end

MDT.modules = {}
function MDT:RegisterModule(modulename, module)
  MDT.modules[modulename] = module
end

local asyncConfig = {
  type = "everyFrame",
  maxTime = 40,
  maxTimeCombat = 8,
  errorHandler = function(msg, stackTrace, name)
    MDT:OnError(msg, stackTrace, name)
  end,
}
MDT.asyncHandler = LibStub("LibAsync"):GetHandler(asyncConfig)

function MDT:Async(func, name, singleton)
  MDT.asyncHandler:Async(func, name, singleton)
end

function MDT:CancelAsync(name)
  MDT.asyncHandler:CancelAsync(name)
end
