local _, MDT = ...
local L = MDT.L

local tremove, tonumber, pairs = table.remove, tonumber, pairs
local defaultSavedVars = MDT:GetDefaultSavedVariables()
local db

local function initializeDB()
  db = db or MDT:GetDB()
end

function MDT:UpdatePresetDropDown()
  initializeDB()
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

---Returns the current preset
function MDT:GetCurrentPreset()
  initializeDB()
  return db.presets[db.currentDungeonIdx][db.currentPreset[db.currentDungeonIdx]]
end

function MDT:GetCurrentLivePreset()
  initializeDB()
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

---Makes sure profiles are valid and have their fields set
function MDT:NormalizeCurrentPreset()
  initializeDB()
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
    pull["color"] = pull["color"] or "228b22"
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

function MDT:EnsureDBTables()
  return self:NormalizeCurrentPreset()
end

function MDT:DeletePreset(index)
  initializeDB()
  if index == 1 then return end
  tremove(db.presets[db.currentDungeonIdx], index)
  db.currentPreset[db.currentDungeonIdx] = index - 1
  MDT:UpdatePresetDropDown()
  MDT:UpdateMap()
end

---Counts the number of presets of the current dungeon
function MDT:CountPresets()
  initializeDB()
  return #db.presets[db.currentDungeonIdx] - 2
end

---Deletes all presets from the current dungeon
function MDT:DeleteAllPresets()
  initializeDB()
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
  initializeDB()
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
      db.presets[db.currentDungeonIdx][countPresets] = CopyTable(db.presets[db.currentDungeonIdx][
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
  initializeDB()
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
  initializeDB()
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

function MDT:RenamePreset(renameText, takeOwnership)
  initializeDB()
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
