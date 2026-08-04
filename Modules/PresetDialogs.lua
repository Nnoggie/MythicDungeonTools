local _, MDT = ...
local L = MDT.L

local tremove, tonumber, pairs, ipairs = table.remove, tonumber, pairs, ipairs
local AceGUI = LibStub("AceGUI-3.0")
local db

local function initializeDB()
  db = db or MDT:GetDB()
end

function MDT:CheckPresetSize(callback, cancelCallback, fireCancelOnClose)
  local presetSize = #self:TableToString(self:GetCurrentPreset())
  if presetSize > 3500 then
    local timeToSend = 1 + math.max(presetSize - 2550, 0) / 255
    local prompt = string.format(L["LargePresetWarning"], timeToSend, "\n", "\n", "\n")
    MDT:OpenConfirmationFrame(450, 150, L["Sharing large preset"], "Share", prompt, callback, nil, cancelCallback, fireCancelOnClose)
  else
    callback()
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
  initializeDB()
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
  initializeDB()
  MDT:HideAllDialogs()
  MDT.main_frame.ClearConfirmationFrame:ClearAllPoints()
  MDT.main_frame.ClearConfirmationFrame:SetPoint("CENTER", MDT.main_frame, "CENTER", 0, 50)
  local currentPresetName = db.presets[db.currentDungeonIdx][db.currentPreset[db.currentDungeonIdx]].text
  MDT.main_frame.ClearConfirmationFrame.label:SetText(string.format(L["Reset %s?"], currentPresetName))
  MDT.main_frame.ClearConfirmationFrame:Show()
end

function MDT:MakePresetImportFrame(frame)
  initializeDB()
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
  initializeDB()
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
  initializeDB()
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
