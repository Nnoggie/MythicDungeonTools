local _, MDT = ...
local L = MDT.L

local ACCOUNT_MACRO_SLOT_OFFSET = MAX_ACCOUNT_MACROS or 120
local CHARACTER_MACRO_LIMIT = MAX_CHARACTER_MACROS or 18
local DEFAULT_MACRO_ICON = 134400
local MACRO_TEXT_LIMIT = 255
local MACRO_COLUMNS = 6
local MACRO_BUTTON_WIDTH = 78
local MACRO_BUTTON_HEIGHT = 52
local MACRO_GRID_WIDTH = MACRO_COLUMNS * MACRO_BUTTON_WIDTH
local MACRO_GRID_HEIGHT = MACRO_BUTTON_HEIGHT * 4

local macroManagerFrame
local suppressTextChanged

local function notify(message)
  if message then
    print("|cffffd100MDT:|r "..message)
  end
end

local function getMacroManagerDB()
  local db = MDT:GetDB()
  if not db then return end

  db.macroManager = db.macroManager or {}
  db.macroManager.selectedScope = db.macroManager.selectedScope or "account"
  db.macroManager.selectedMacroIDs = db.macroManager.selectedMacroIDs or {}
  if db.macroManager.selectedScope ~= "account" and db.macroManager.selectedScope ~= "character" then
    db.macroManager.selectedScope = "account"
  end
  return db.macroManager
end

local function getMacroID(scope, name)
  return (scope or "account")..":"..(name or "")
end

local function getCharacterTabName()
  local name = UnitName and UnitName("player") or L["Character"]
  return string.format(L["Character Specific Macros"], name or L["Character"])
end

local function getMacroCounts()
  if not GetNumMacros then return 0, 0 end
  local accountMacros, characterMacros = GetNumMacros()
  return tonumber(accountMacros) or 0, tonumber(characterMacros) or 0
end

local function enumerateMacros(scope)
  local records = {}
  if not GetMacroInfo then return records end

  local accountMacros, characterMacros = getMacroCounts()
  local firstIndex = scope == "character" and (ACCOUNT_MACRO_SLOT_OFFSET + 1) or 1
  local count = scope == "character" and characterMacros or accountMacros

  for slot = 1, count do
    local index = firstIndex + slot - 1
    local name, icon, body = GetMacroInfo(index)
    if name then
      table.insert(records, {
        id = getMacroID(scope, name),
        index = index,
        slot = slot,
        scope = scope,
        name = name,
        icon = icon or DEFAULT_MACRO_ICON,
        body = body or "",
      })
    end
  end

  return records
end

local function findMacroRecordByID(scope, macroID)
  if not macroID then return end
  for _, record in ipairs(enumerateMacros(scope)) do
    if record.id == macroID then
      return record
    end
  end
end

local function findMacroRecordByName(scope, name)
  if not name then return end
  for _, record in ipairs(enumerateMacros(scope)) do
    if record.name == name then
      return record
    end
  end
end

local function macroNameExists(name)
  if GetMacroIndexByName then
    local macroIndex = GetMacroIndexByName(name)
    if macroIndex and macroIndex > 0 then
      return true
    end
  end

  for _, scope in ipairs({ "account", "character" }) do
    if findMacroRecordByName(scope, name) then
      return true
    end
  end
  return false
end

local function getUniqueMacroName()
  local baseName = L["New Macro"]
  if not macroNameExists(baseName) then
    return baseName
  end

  for index = 2, 999 do
    local name = baseName.." "..index
    if not macroNameExists(name) then
      return name
    end
  end

  return baseName
end

local function canCreateMacro(scope)
  local accountMacros, characterMacros = getMacroCounts()
  if scope == "character" then
    return characterMacros < CHARACTER_MACRO_LIMIT
  end
  return accountMacros < ACCOUNT_MACRO_SLOT_OFFSET
end

local function setButtonEnabled(button, enabled)
  if not button then return end
  if enabled then
    button:Enable()
  else
    button:Disable()
  end
end

local function createButton(parent, text, width, height, onClick)
  local button = CreateFrame("Button", nil, parent, "UIPanelButtonTemplate")
  button:SetSize(width, height)
  button:SetText(text)
  button:SetScript("OnClick", onClick)
  return button
end

local function createLine(parent, point, relativeTo, relativePoint, x, y, width, height)
  local line = parent:CreateTexture(nil, "BORDER")
  line:SetColorTexture(1, 0.8196, 0, 0.25)
  line:SetSize(width, height)
  line:SetPoint(point, relativeTo, relativePoint, x, y)
  return line
end

local function createEditor(parent)
  local holder = CreateFrame("Frame", nil, parent)
  holder:SetSize(472, 106)
  holder.bg = holder:CreateTexture(nil, "BACKGROUND")
  holder.bg:SetAllPoints()
  holder.bg:SetColorTexture(0.02, 0.02, 0.02, 0.92)
  createLine(holder, "TOPLEFT", holder, "TOPLEFT", 0, 0, 472, 1)
  createLine(holder, "BOTTOMLEFT", holder, "BOTTOMLEFT", 0, 0, 472, 1)
  createLine(holder, "TOPLEFT", holder, "TOPLEFT", 0, 0, 1, 106)
  createLine(holder, "TOPRIGHT", holder, "TOPRIGHT", 0, 0, 1, 106)

  local scroll = CreateFrame("ScrollFrame", nil, holder, "UIPanelScrollFrameTemplate")
  scroll:SetPoint("TOPLEFT", holder, "TOPLEFT", 8, -8)
  scroll:SetPoint("BOTTOMRIGHT", holder, "BOTTOMRIGHT", -26, 8)

  local editBox = CreateFrame("EditBox", nil, scroll)
  editBox:SetMultiLine(true)
  editBox:SetAutoFocus(false)
  editBox:SetMaxLetters(MACRO_TEXT_LIMIT)
  editBox:SetFontObject(ChatFontNormal)
  editBox:SetWidth(430)
  editBox:SetHeight(90)
  editBox:SetJustifyH("LEFT")
  editBox:SetJustifyV("TOP")
  editBox:SetScript("OnEscapePressed", function(self)
    self:ClearFocus()
  end)

  scroll:SetScrollChild(editBox)
  holder:SetScript("OnMouseDown", function()
    editBox:SetFocus()
  end)

  holder.scroll = scroll
  holder.editBox = editBox
  return holder
end

local function setTabActive(button, active)
  if not button then return end
  if active then
    button:SetButtonState("PUSHED", true)
  else
    button:SetButtonState("NORMAL", false)
  end
end

local function getSelectedRecord(frame)
  local settings = getMacroManagerDB()
  if not settings then return end

  local scope = settings.selectedScope
  local selectedID = settings.selectedMacroIDs[scope]
  local selected = findMacroRecordByID(scope, selectedID)
  if selected then return selected end

  local records = enumerateMacros(scope)
  selected = records[1]
  settings.selectedMacroIDs[scope] = selected and selected.id or nil
  return selected
end

local function updateButtonStates(frame)
  local settings = getMacroManagerDB()
  if not frame or not settings then return end

  local selected = getSelectedRecord(frame)
  local dirty = frame.dirty == true
  setButtonEnabled(frame.saveButton, selected and dirty)
  setButtonEnabled(frame.cancelButton, selected and dirty)
  setButtonEnabled(frame.deleteButton, selected ~= nil)
  setButtonEnabled(frame.newButton, canCreateMacro(settings.selectedScope))
  setButtonEnabled(frame.changeNameIconButton, false)
end

local function updateCharacterCount(frame)
  local text = frame.editor.editBox:GetText() or ""
  frame.characterCount:SetText(string.format(L["Macro Characters Used"], #text, MACRO_TEXT_LIMIT))
end

local function updateSelectedMacroDisplay(frame, selected)
  if selected then
    frame.selectedIcon:SetTexture(selected.icon or DEFAULT_MACRO_ICON)
    frame.selectedIcon:SetDesaturated(false)
    frame.selectedName:SetText(selected.name)
    frame.editor.editBox:Enable()
  else
    frame.selectedIcon:SetTexture(DEFAULT_MACRO_ICON)
    frame.selectedIcon:SetDesaturated(true)
    frame.selectedName:SetText(L["No macro selected."])
    frame.editor.editBox:Disable()
  end
end

local function loadSelectedMacro(frame, selected)
  suppressTextChanged = true
  frame.editor.editBox:SetText(selected and selected.body or "")
  frame.editor.editBox:SetCursorPosition(0)
  suppressTextChanged = false
  frame.dirty = false
  updateSelectedMacroDisplay(frame, selected)
  updateCharacterCount(frame)
  updateButtonStates(frame)
end

local function setSelectedRecord(frame, record)
  local settings = getMacroManagerDB()
  if not settings then return end

  settings.selectedScope = record and record.scope or settings.selectedScope
  settings.selectedMacroIDs[settings.selectedScope] = record and record.id or nil
  frame.dirty = false
  frame:Refresh()
end

local function renderMacroGrid(frame)
  local settings = getMacroManagerDB()
  if not settings then return end

  local scope = settings.selectedScope
  local records = enumerateMacros(scope)
  local selected = getSelectedRecord(frame)
  local rows = math.max(4, math.ceil(#records / MACRO_COLUMNS))
  frame.gridChild:SetSize(MACRO_GRID_WIDTH, rows * MACRO_BUTTON_HEIGHT)

  for index, record in ipairs(records) do
    local button = frame.macroButtons[index]
    if not button then
      button = CreateFrame("Button", nil, frame.gridChild)
      button:SetSize(MACRO_BUTTON_WIDTH - 6, MACRO_BUTTON_HEIGHT - 4)
      button.selected = button:CreateTexture(nil, "BACKGROUND")
      button.selected:SetAllPoints()
      button.selected:SetColorTexture(1, 0.8196, 0, 0.2)
      button.selected:Hide()
      button.highlight = button:CreateTexture(nil, "HIGHLIGHT")
      button.highlight:SetAllPoints()
      button.highlight:SetColorTexture(1, 1, 1, 0.08)
      button:SetHighlightTexture(button.highlight)
      button.icon = button:CreateTexture(nil, "ARTWORK")
      button.icon:SetSize(32, 32)
      button.icon:SetPoint("TOP", button, "TOP", 0, -2)
      button.icon:SetTexCoord(0.08, 0.92, 0.08, 0.92)
      button.text = button:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
      button.text:SetPoint("TOPLEFT", button.icon, "BOTTOMLEFT", -15, -2)
      button.text:SetPoint("TOPRIGHT", button.icon, "BOTTOMRIGHT", 15, -2)
      button.text:SetHeight(14)
      button.text:SetJustifyH("CENTER")
      frame.macroButtons[index] = button
    end

    local column = (index - 1) % MACRO_COLUMNS
    local row = math.floor((index - 1) / MACRO_COLUMNS)
    button:ClearAllPoints()
    button:SetPoint("TOPLEFT", frame.gridChild, "TOPLEFT", column * MACRO_BUTTON_WIDTH, -(row * MACRO_BUTTON_HEIGHT))
    button.record = record
    button.icon:SetTexture(record.icon or DEFAULT_MACRO_ICON)
    button.text:SetText(record.name)
    button.selected:SetShown(selected and selected.id == record.id)
    button:SetScript("OnClick", function(self)
      setSelectedRecord(frame, self.record)
    end)
    button:SetScript("OnEnter", function(self)
      GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
      GameTooltip:SetText(self.record.name, 1, 1, 1)
      GameTooltip:AddLine(self.record.scope == "character" and getCharacterTabName() or L["General Macros"], 0.8, 0.8, 0.8)
      GameTooltip:Show()
    end)
    button:SetScript("OnLeave", function()
      GameTooltip:Hide()
    end)
    button:Show()
  end

  for index = #records + 1, #frame.macroButtons do
    frame.macroButtons[index]:Hide()
  end

  frame.emptyText:SetShown(#records == 0)
end

local function saveSelectedMacro(frame)
  if InCombatLockdown and InCombatLockdown() then
    notify(L["Cannot edit macros in combat."])
    return
  end

  local selected = getSelectedRecord(frame)
  if not selected then
    notify(L["No macro selected."])
    return
  end

  local body = frame.editor.editBox:GetText() or ""
  local ok, err = pcall(function()
    EditMacro(selected.index, selected.name, selected.icon or DEFAULT_MACRO_ICON, body)
  end)

  if ok then
    notify(L["Macro saved."])
    frame.dirty = false
    frame:Refresh()
  else
    notify(string.format(L["Macro update failed: %s"], tostring(err)))
  end
end

local function cancelSelectedMacro(frame)
  loadSelectedMacro(frame, getSelectedRecord(frame))
end

local function createNewMacro(frame)
  local settings = getMacroManagerDB()
  if not settings then return end

  if InCombatLockdown and InCombatLockdown() then
    notify(L["Cannot edit macros in combat."])
    return
  end

  local scope = settings.selectedScope
  if not canCreateMacro(scope) then
    notify(L["No macro slots available."])
    return
  end

  local name = getUniqueMacroName()
  local index = CreateMacro and CreateMacro(name, DEFAULT_MACRO_ICON, "", scope == "character")
  if not index or index == 0 then
    notify(L["Unable to create macro."])
    return
  end

  local record = findMacroRecordByName(scope, name)
  settings.selectedMacroIDs[scope] = record and record.id or getMacroID(scope, name)
  frame.dirty = false
  frame:Refresh()
end

local function deleteSelectedMacro(frame)
  if InCombatLockdown and InCombatLockdown() then
    notify(L["Cannot edit macros in combat."])
    return
  end

  local selected = getSelectedRecord(frame)
  if not selected then
    notify(L["No macro selected."])
    return
  end

  local function doDelete()
    local settings = getMacroManagerDB()
    local ok, err = pcall(function()
      DeleteMacro(selected.index)
    end)

    if ok then
      if settings then
        settings.selectedMacroIDs[selected.scope] = nil
      end
      notify(L["Macro deleted."])
      frame.dirty = false
      frame:Refresh()
    else
      notify(string.format(L["Macro delete failed: %s"], tostring(err)))
    end
  end

  if MDT.OpenConfirmationFrame then
    MDT:OpenConfirmationFrame(420, 150, L["Delete Macro"], L["Delete"], string.format(L["Delete %s?"], selected.name), doDelete)
  else
    doDelete()
  end
end

local function setScope(frame, scope)
  local settings = getMacroManagerDB()
  if not settings then return end

  settings.selectedScope = scope
  frame.dirty = false
  frame:Refresh()
end

local function createMacroManagerFrame()
  local mainFrame = MDT.main_frame
  local contentParent = mainFrame.sectionContentFrames and mainFrame.sectionContentFrames.macros or mainFrame

  local frame = CreateFrame("Frame", "MDTMacroManagerFrame", contentParent)
  frame:SetFrameStrata("HIGH")
  frame:SetFrameLevel(3)
  frame:SetSize(560, 500)
  frame:SetPoint("TOP", contentParent, "TOP", 0, -20)
  frame.content = { frame = frame }
  frame.macroButtons = {}
  MDT:RegisterMainFrameDragHandle(frame, mainFrame)

  frame.title = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
  frame.title:SetPoint("TOP", frame, "TOP", 0, 0)
  frame.title:SetText(L["Macro Manager"])

  frame.accountTab = createButton(frame, L["General Macros"], 132, 24, function()
    setScope(frame, "account")
  end)
  frame.accountTab:SetPoint("TOPLEFT", frame, "TOPLEFT", 20, -34)

  frame.characterTab = createButton(frame, getCharacterTabName(), 190, 24, function()
    setScope(frame, "character")
  end)
  frame.characterTab:SetPoint("LEFT", frame.accountTab, "RIGHT", 4, 0)

  frame.gridScroll = CreateFrame("ScrollFrame", nil, frame, "UIPanelScrollFrameTemplate")
  frame.gridScroll:SetSize(MACRO_GRID_WIDTH + 24, MACRO_GRID_HEIGHT)
  frame.gridScroll:SetPoint("TOPLEFT", frame, "TOPLEFT", 20, -66)
  frame.gridChild = CreateFrame("Frame", nil, frame.gridScroll)
  frame.gridScroll:SetScrollChild(frame.gridChild)

  frame.emptyText = frame:CreateFontString(nil, "OVERLAY", "GameFontDisable")
  frame.emptyText:SetPoint("CENTER", frame.gridScroll, "CENTER", -12, 0)
  frame.emptyText:SetText(L["No macros found."])

  frame.selectedIcon = frame:CreateTexture(nil, "ARTWORK")
  frame.selectedIcon:SetSize(38, 38)
  frame.selectedIcon:SetPoint("TOPLEFT", frame.gridScroll, "BOTTOMLEFT", 0, -16)
  frame.selectedIcon:SetTexCoord(0.08, 0.92, 0.08, 0.92)

  frame.selectedName = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
  frame.selectedName:SetPoint("LEFT", frame.selectedIcon, "RIGHT", 10, 0)
  frame.selectedName:SetWidth(300)
  frame.selectedName:SetJustifyH("LEFT")

  frame.changeNameIconButton = createButton(frame, L["Change Name/Icon"], 170, 24, nil)
  frame.changeNameIconButton:SetPoint("TOPLEFT", frame.selectedIcon, "BOTTOMRIGHT", 0, -4)

  frame.saveButton = createButton(frame, L["Save"], 100, 24, function()
    saveSelectedMacro(frame)
  end)
  frame.saveButton:SetPoint("TOPRIGHT", frame.gridScroll, "BOTTOMRIGHT", -24, -16)

  frame.cancelButton = createButton(frame, L["Cancel"], 100, 24, function()
    cancelSelectedMacro(frame)
  end)
  frame.cancelButton:SetPoint("TOP", frame.saveButton, "BOTTOM", 0, -10)

  frame.editorLabel = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
  frame.editorLabel:SetPoint("TOPLEFT", frame.selectedIcon, "BOTTOMLEFT", 0, -42)
  frame.editorLabel:SetText(L["Enter Macro Commands:"])

  frame.editor = createEditor(frame)
  frame.editor:SetPoint("TOPLEFT", frame.editorLabel, "BOTTOMLEFT", 0, -2)
  frame.editor.editBox:SetScript("OnTextChanged", function()
    updateCharacterCount(frame)
    if not suppressTextChanged then
      frame.dirty = true
      updateButtonStates(frame)
    end
  end)

  frame.characterCount = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
  frame.characterCount:SetPoint("TOP", frame.editor, "BOTTOM", 0, 0)

  frame.deleteButton = createButton(frame, L["Delete"], 82, 24, function()
    deleteSelectedMacro(frame)
  end)
  frame.deleteButton:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", 20, 10)

  frame.newButton = createButton(frame, L["New"], 100, 24, function()
    createNewMacro(frame)
  end)
  frame.newButton:SetPoint("LEFT", frame.deleteButton, "RIGHT", 210, 0)

  frame.exitButton = createButton(frame, L["Exit"], 82, 24, function()
    MDT:SetCurrentSection("maps")
  end)
  frame.exitButton:SetPoint("LEFT", frame.newButton, "RIGHT", 4, 0)

  function frame:Refresh()
    local settings = getMacroManagerDB()
    if not settings then return end

    self.characterTab:SetText(getCharacterTabName())
    setTabActive(self.accountTab, settings.selectedScope == "account")
    setTabActive(self.characterTab, settings.selectedScope == "character")
    renderMacroGrid(self)
    loadSelectedMacro(self, getSelectedRecord(self))
  end

  frame:Hide()
  return frame
end

local eventFrame = CreateFrame("Frame")
eventFrame:RegisterEvent("PLAYER_REGEN_ENABLED")
eventFrame:RegisterEvent("PLAYER_REGEN_DISABLED")
eventFrame:SetScript("OnEvent", function()
  if macroManagerFrame and macroManagerFrame:IsShown() then
    updateButtonStates(macroManagerFrame)
  end
end)

function MDT:MacroManager_Open()
  if self.GetCurrentSection and self.SetCurrentSection and self:GetCurrentSection() ~= "macros" then
    self:SetCurrentSection("macros")
    return
  end

  macroManagerFrame = macroManagerFrame or createMacroManagerFrame()
  MDT:HideAllDialogs()
  macroManagerFrame:Show()
  macroManagerFrame:Refresh()
end
