local _, MDT = ...
local L = MDT.L
local UI = MDT.UI

local db

local function initializeDB()
  db = db or MDT:GetDB()
end

local function currentPresetName()
  return db.presets[db.currentDungeonIdx][db.currentPreset[db.currentDungeonIdx]].text
end

---@param cancelCallback fun()? runs when the share warning is dismissed without sharing
function MDT:CheckPresetSize(callback, cancelCallback)
  local presetSize = #self:TableToString(self:GetCurrentPreset())
  if presetSize > 3500 then
    local timeToSend = 1 + math.max(presetSize - 2550, 0) / 255
    UI.Dialogs.Confirm({
      key = "largePreset", width = 450, title = L["Sharing large preset"],
      text = string.format(L["LargePresetWarning"], timeToSend, "\n", "\n", ""),
      confirm = { text = L["Share"], onClick = callback },
      cancel = cancelCallback and { onClick = cancelCallback },
    })
  else
    callback()
  end
end

function MDT:HideAllDialogs()
  UI.Dialogs.CloseAll("api")
  if MDT.main_frame then
    if MDT.versionCheckFrame then MDT.versionCheckFrame:Hide() end
  end
  if MDT.copyHelper then MDT.copyHelper:SmartHide() end
end

function MDT:OpenImportPresetDialog()
  initializeDB()
  if InCombatLockdown() then
    print('MDT: '..L["Cannot import while in combat"])
    return
  end
  MDT:HideAllDialogs()
  local input, problem, pasted
  local function import(dialog)
    if InCombatLockdown() then
      print('MDT: '..L["Cannot import while in combat"])
      MDT:HideAllDialogs()
      return
    end
    local newPreset = MDT:StringToTable(pasted or input:GetValue())
    if MDT:ValidateImportPreset(newPreset) then
      dialog:Close("confirm")
      MDT:ImportPreset(newPreset)
      if db.colorPaletteInfo.forceColorBlindMode then MDT:ColorAllPulls() end
    else
      problem:SetText(type(newPreset) == "string" and newPreset or L["Invalid import string"])
      problem:SetHidden(false)
    end
  end
  UI.Dialogs.Open({
    key = "importPreset", title = L["Import Preset"], width = 400,
    build = function(content, dialog)
      input = UI.EditBox(content, {
        id = "input", label = L["Import Preset"]..":", multiline = true, lines = 6, autoFocus = true,
        onChange = function() pasted = nil end,
        onPaste = function(text, box)
          if #text <= 10 then return end
          pasted = strtrim(text)
          box:SetValue(pasted:sub(1, 2000))
          import(dialog)
        end,
        onEscape = function() dialog:Close("escape") end,
      })
      problem = UI.Text(content, { id = "problem", text = "", color = "warn", hidden = true })
      local row = UI.Row(content, { gap = "sm", align = "end" })
      UI.Button(row, { id = "import", text = L["Import"], variant = "primary", onClick = function() import(dialog) end })
      if db.devMode then
        UI.Button(row, { text = "Inspect", onClick = function()
          if not DevTool or not DevTool.AddData then
            print("MDT: Install Dev Tool to inspect route")
          else
            DevTool:AddData(MDT:StringToTable(pasted or input:GetValue()))
          end
        end })
      end
    end,
  })
end

---@param startingPointIdx integer? preselects "use as a starting point" with that preset, for Duplicate
function MDT:OpenNewPresetDialog(startingPointIdx)
  initializeDB()
  MDT:HideAllDialogs()
  local startingPoints = { { kind = "choice", text = L["Empty"], value = 0 } }
  local highestIndex = 1
  local countPresets = 0
  for index, preset in ipairs(db.presets[db.currentDungeonIdx]) do
    if preset.text ~= L["<New Preset>"] then
      startingPoints[#startingPoints + 1] = { kind = "choice", text = MDT:GetPresetDropdownText(preset), value = index }
      local indexNumber = tonumber(preset.text:match("^"..L["defaultPresetName"].."%s*(%d+)$"))
      if indexNumber and indexNumber > highestIndex then highestIndex = indexNumber end
      countPresets = countPresets + 1
    end
  end
  local newIndex = math.max(highestIndex, countPresets - 1)
  local startingPoint = startingPointIdx or 0
  UI.Dialogs.Prompt({
    key = "newPreset", title = L["New Preset"], width = 400,
    label = L["Preset Name"]..":", value = L["defaultPresetName"].." "..(newIndex + 1),
    validate = function(text)
      if MDT:SanitizePresetName(text) then return true end
      return false, string.format(L["Cannot create preset '%s'"], text)
    end,
    build = function(content)
      UI.Dropdown(content, {
        id = "startingPoint", label = L["Use as a starting point:"], items = startingPoints, value = startingPoint,
        onChange = function(value) startingPoint = value end,
      })
    end,
    confirm = { text = L["Create"], onClick = function(text) MDT:CreateNewPreset(text, startingPoint) end },
  })
end

function MDT:OpenRenamePresetDialog()
  initializeDB()
  MDT:HideAllDialogs()
  local currentName = currentPresetName()
  UI.Dialogs.Prompt({
    key = "renamePreset", title = L["Rename Preset"], width = 350,
    label = L["Preset Name"]..":", value = currentName,
    validate = function(text)
      if text == currentName then return false end
      if MDT:SanitizePresetName(text) then return true end
      return false, string.format(L["Cannot rename preset to '%s'"], text)
    end,
    confirm = { text = L["Rename"], onClick = function(text) MDT:RenamePreset(text) end },
  })
end

---Shows a read-only string with Select all and the copy hint; Ctrl+C closes it.
---@param label string
---@param text string
function MDT:OpenExportStringDialog(label, text)
  MDT:HideAllDialogs()
  local dialog = UI.Dialogs.Open({
    key = "export", title = L["Export"], width = 600,
    onClose = function() MDT.copyHelper:SmartHide() end,
    build = function(content, dialog)
      local box
      box = UI.EditBox(content, {
        id = "text", label = label, value = text, multiline = true, lines = 20,
        readOnly = true, selectAllOnFocus = true, autoFocus = true,
        onFocusLost = function() MDT.copyHelper:SmartHide() end,
        onCopy = function()
          MDT.copyHelper:SmartFadeOut()
          dialog:Close("confirm")
        end,
        onEscape = function() dialog:Close("escape") end,
      })
      local row = UI.Row(content, { align = "end" })
      UI.Button(row, { id = "selectAll", text = L["Select all"], onClick = function()
        box:Focus()
        box:SelectAll()
        MDT.copyHelper:SmartShow(dialog, 0, 0)
      end })
    end,
  })
  MDT.copyHelper:SmartShow(dialog, 0, 0)
end

function MDT:OpenExportDialog()
  initializeDB()
  if InCombatLockdown() then
    print('MDT: '..L["Cannot export while in combat"])
    return
  end
  if db.colorPaletteInfo.forceColorBlindMode then MDT:ColorAllPulls(nil, nil, nil, true) end
  local preset = MDT:GetCurrentPreset()
  MDT:SetUniqueID(preset)
  MDT:EnsurePresetCreatedBy(preset)
  preset.difficulty = db.currentDifficulty
  preset.addonVersion = db.version
  local export = MDT:TableToString(preset)
  MDT:OpenExportStringDialog(preset.text.." "..string.len(export), export)
  if db.colorPaletteInfo.forceColorBlindMode then MDT:ColorAllPulls() end
end

function MDT:OpenDeletePresetDialog()
  initializeDB()
  MDT:HideAllDialogs()
  UI.Dialogs.Confirm({
    key = "deletePreset", title = L["Delete Preset"], text = string.format(L["Delete %s?"], currentPresetName()),
    confirm = { text = L["Delete"], variant = "danger", onClick = function()
      MDT:DeletePreset(db.currentPreset[db.currentDungeonIdx])
    end },
  })
end

function MDT:OpenDeleteAllPresetsDialog()
  UI.Dialogs.Confirm({
    key = "deleteAllPresets", width = 450, title = L["Delete ALL presets"],
    text = string.format(L["deleteAllWarning"], "\n", "\n", self:CountPresets(), "\n"),
    confirm = { text = L["Delete"], variant = "danger", onClick = function() MDT:DeleteAllPresets() end },
  })
end

function MDT:OpenClearPresetDialog()
  initializeDB()
  MDT:HideAllDialogs()
  UI.Dialogs.Confirm({
    key = "clearPreset", title = L["Reset Preset"], text = string.format(L["Reset %s?"], currentPresetName()),
    confirm = { text = L["Reset"], variant = "danger", onClick = function()
      MDT:ClearPreset(MDT:GetCurrentPreset())
      if MDT.liveSessionActive and MDT:GetCurrentPreset().uid == MDT.livePresetUID then
        MDT:LiveSession_SendCommand("clear")
      end
    end },
  })
end
