local _, MDT = ...
local L = MDT.L
local AceGUI = LibStub("AceGUI-3.0")

local ACCOUNT_MACRO_SLOT_OFFSET = MAX_ACCOUNT_MACROS or 120
local CHARACTER_MACRO_LIMIT = MAX_CHARACTER_MACROS or 30
local DEFAULT_MACRO_ICON = 134400
local MACRO_TEXT_LIMIT = 255
local FRAME_WIDTH = 420
local FRAME_HEIGHT = 580
local MACRO_COLUMNS = 6
local MACRO_BUTTON_WIDTH = 50
local MACRO_BUTTON_HEIGHT = 48
local MACRO_ICON_SIZE = 34
local MACRO_GRID_WIDTH = MACRO_COLUMNS * MACRO_BUTTON_WIDTH
local MACRO_GRID_SCROLL_WIDTH = MACRO_GRID_WIDTH + 24
local MACRO_GRID_HEIGHT = MACRO_BUTTON_HEIGHT * 4
local SEARCH_LABEL_WIDTH = 48
local SEARCH_TOP_OFFSET = -78
local GRID_TOP_OFFSET = -112
local ACTION_BUTTON_WIDTH = 100
local EDITOR_NUM_LINES = 6

local macroManagerFrame
local suppressTextChanged
local suppressSearchChanged

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
  db.macroManager.searchText = db.macroManager.searchText or ""
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

local function getMacroSlotLimit(scope)
  return scope == "character" and CHARACTER_MACRO_LIMIT or ACCOUNT_MACRO_SLOT_OFFSET
end

local function getEmptyMacroID(scope, slot)
  return (scope or "account")..":empty:"..tostring(slot or 0)
end

local function enumerateMacros(scope, includeEmptySlots)
  local records = {}
  if not GetMacroInfo then return records end

  local accountMacros, characterMacros = getMacroCounts()
  local firstIndex = scope == "character" and (ACCOUNT_MACRO_SLOT_OFFSET + 1) or 1
  local count = scope == "character" and characterMacros or accountMacros
  local slotCount = includeEmptySlots and getMacroSlotLimit(scope) or count

  for slot = 1, slotCount do
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
    elseif includeEmptySlots then
      table.insert(records, {
        id = getEmptyMacroID(scope, slot),
        index = index,
        slot = slot,
        scope = scope,
        name = "",
        icon = nil,
        body = "",
        empty = true,
      })
    end
  end

  return records
end

local function normalizeSearchText(text)
  return string.lower((text or ""):match("^%s*(.-)%s*$") or "")
end

local function macroMatchesSearch(record, searchText)
  if searchText == "" then return true end
  local haystack = string.lower((record.name or "").."\n"..(record.body or ""))
  return haystack:find(searchText, 1, true) ~= nil
end

local function filterMacroRecords(records, searchText)
  searchText = normalizeSearchText(searchText)
  if searchText == "" then return records end

  local filtered = {}
  for _, record in ipairs(records) do
    if macroMatchesSearch(record, searchText) then
      table.insert(filtered, record)
    end
  end
  return filtered
end

local function findMacroRecordInRecords(records, macroID)
  if not macroID then return end
  for _, record in ipairs(records) do
    if not record.empty and record.id == macroID then
      return record
    end
  end
end

local function findFirstMacroRecord(records)
  for _, record in ipairs(records) do
    if not record.empty then
      return record
    end
  end
end

local function getVisibleMacroRecords(scope)
  local settings = getMacroManagerDB()
  local searchText = normalizeSearchText(settings and settings.searchText)
  local records = enumerateMacros(scope, searchText == "")
  return filterMacroRecords(records, searchText)
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
    return characterMacros < getMacroSlotLimit(scope)
  end
  return accountMacros < getMacroSlotLimit(scope)
end

local function setButtonEnabled(button, enabled)
  if not button then return end
  if button.SetDisabled then
    button:SetDisabled(not enabled)
  elseif enabled then
    button:Enable()
  else
    button:Disable()
  end
end

local function createAceButton(parent, text, width, onClick)
  local button = AceGUI:Create("Button")
  button.frame:SetParent(parent)
  button:SetWidth(width)
  button:SetHeight(24)
  button:SetText(text)
  button:SetCallback("OnClick", function()
    if onClick then
      onClick()
    end
  end)
  button.frame:Show()
  return button
end

local function setAcePoint(widget, ...)
  widget.frame:ClearAllPoints()
  widget.frame:SetPoint(...)
  widget.frame:Show()
end

local function getScrollBar(scrollFrame)
  if scrollFrame.ScrollBar then return scrollFrame.ScrollBar end
  if scrollFrame.scrollBar then return scrollFrame.scrollBar end
  local name = scrollFrame:GetName()
  return name and _G[name.."ScrollBar"]
end

local function alignScrollBarInside(scrollFrame)
  local scrollBar = getScrollBar(scrollFrame)
  if not scrollBar then return end

  scrollBar:ClearAllPoints()
  scrollBar:SetPoint("TOPRIGHT", scrollFrame, "TOPRIGHT", 0, -16)
  scrollBar:SetPoint("BOTTOMRIGHT", scrollFrame, "BOTTOMRIGHT", 0, 16)
end

local function createAceEditor(parent)
  local editor = AceGUI:Create("MultiLineEditBox")
  editor.frame:SetParent(parent)
  editor:SetWidth(MACRO_GRID_SCROLL_WIDTH)
  editor:SetLabel(L["Enter Macro Commands:"])
  editor:SetNumLines(EDITOR_NUM_LINES)
  editor:SetMaxLetters(MACRO_TEXT_LIMIT)
  editor:DisableButton(true)
  editor.frame:Show()
  return editor
end

local function createAceSearchBox(parent)
  local searchBox = AceGUI:Create("EditBox")
  searchBox.frame:SetParent(parent)
  searchBox:SetLabel("")
  searchBox:SetWidth(MACRO_GRID_SCROLL_WIDTH - SEARCH_LABEL_WIDTH - 8)
  searchBox:SetHeight(24)
  searchBox:DisableButton(true)
  if searchBox.editbox then
    searchBox.editbox:SetAutoFocus(false)
    if searchBox.editbox.SetTextInsets then
      searchBox.editbox:SetTextInsets(0, 16, 0, 0)
    end
  end
  searchBox.frame:Show()
  return searchBox
end

local function createSearchClearButton(parent)
  local button = CreateFrame("Button", nil, parent)
  button:SetSize(14, 14)

  button.text = button:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
  button.text:SetPoint("CENTER", button, "CENTER", 0, 1)
  button.text:SetText("x")
  button.text:SetTextColor(1, 0.8196, 0)

  button:SetScript("OnEnter", function(self)
    self.text:SetTextColor(1, 1, 1)
  end)
  button:SetScript("OnLeave", function(self)
    self.text:SetTextColor(1, 0.8196, 0)
  end)
  button:Hide()
  return button
end

local function setTabsActive(frame)
  local settings = getMacroManagerDB()
  if not settings then return end

  if PanelTemplates_SetTab then
    PanelTemplates_SetTab(frame, settings.selectedScope == "character" and 2 or 1)
    if PanelTemplates_TabResize then
      PanelTemplates_TabResize(frame.accountTab, 0)
      PanelTemplates_TabResize(frame.characterTab, 0)
    end
    return
  end

  frame.accountTab:SetButtonState(settings.selectedScope == "account" and "PUSHED" or "NORMAL", settings.selectedScope == "account")
  frame.characterTab:SetButtonState(settings.selectedScope == "character" and "PUSHED" or "NORMAL", settings.selectedScope == "character")
end

local function createMacroTab(name, parent)
  local ok, button = pcall(CreateFrame, "Button", name, parent, "PanelTopTabButtonTemplate")
  if ok and button then
    return button
  end
  return CreateFrame("Button", name, parent, "PanelTabButtonTemplate")
end

local function getSelectedRecord(frame, records)
  local settings = getMacroManagerDB()
  if not settings then return end

  local scope = settings.selectedScope
  local selectedID = settings.selectedMacroIDs[scope]
  records = records or getVisibleMacroRecords(scope)

  local selected = findMacroRecordInRecords(records, selectedID)
  if selected then return selected end

  selected = findFirstMacroRecord(records)
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
  local text = frame.editor:GetText() or ""
  frame.characterCount:SetText(string.format(L["Macro Characters Used"], #text, MACRO_TEXT_LIMIT))
end

local function updateSelectedMacroDisplay(frame, selected)
  if selected then
    frame.selectedIcon:SetTexture(selected.icon or DEFAULT_MACRO_ICON)
    frame.selectedIcon:SetDesaturated(false)
    frame.selectedName:SetText(selected.name)
    frame.editor:SetDisabled(false)
  else
    frame.selectedIcon:SetTexture(DEFAULT_MACRO_ICON)
    frame.selectedIcon:SetDesaturated(true)
    frame.selectedName:SetText(L["No macro selected."])
    frame.editor:SetDisabled(true)
  end
end

local function loadSelectedMacro(frame, selected)
  suppressTextChanged = true
  frame.editor:SetText(selected and selected.body or "")
  frame.editor:SetCursorPosition(0)
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
  local records = getVisibleMacroRecords(scope)
  local selected = getSelectedRecord(frame, records)
  local rows = math.max(4, math.ceil(#records / MACRO_COLUMNS))
  frame.gridChild:SetSize(MACRO_GRID_WIDTH, rows * MACRO_BUTTON_HEIGHT)

  for index, record in ipairs(records) do
    local button = frame.macroButtons[index]
    if not button then
      button = CreateFrame("Button", nil, frame.gridChild)
      button:SetSize(MACRO_BUTTON_WIDTH, MACRO_BUTTON_HEIGHT - 2)
      button.selected = button:CreateTexture(nil, "BACKGROUND")
      button.selected:SetAllPoints()
      button.selected:SetColorTexture(1, 0.8196, 0, 0.2)
      button.selected:Hide()
      button.highlight = button:CreateTexture(nil, "HIGHLIGHT")
      button.highlight:SetAllPoints()
      button.highlight:SetColorTexture(1, 1, 1, 0.08)
      button:SetHighlightTexture(button.highlight)
      button.icon = button:CreateTexture(nil, "ARTWORK")
      button.icon:SetSize(MACRO_ICON_SIZE, MACRO_ICON_SIZE)
      button.icon:SetPoint("TOP", button, "TOP", 0, -2)
      button.icon:SetTexCoord(0.08, 0.92, 0.08, 0.92)
      button.text = button:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
      button.text:SetPoint("TOPLEFT", button.icon, "BOTTOMLEFT", -8, -2)
      button.text:SetPoint("TOPRIGHT", button.icon, "BOTTOMRIGHT", 8, -2)
      button.text:SetHeight(14)
      button.text:SetJustifyH("CENTER")
      button:RegisterForDrag("LeftButton")
      button:SetScript("OnDragStart", function(self)
        if self.record and not self.record.empty and PickupMacro then
          PickupMacro(self.record.index)
        end
      end)
      frame.macroButtons[index] = button
    end

    local column = (index - 1) % MACRO_COLUMNS
    local row = math.floor((index - 1) / MACRO_COLUMNS)
    button:ClearAllPoints()
    button:SetPoint("TOPLEFT", frame.gridChild, "TOPLEFT", column * MACRO_BUTTON_WIDTH, -(row * MACRO_BUTTON_HEIGHT))
    button.record = record
    if record.empty then
      button.icon:SetColorTexture(0.12, 0.12, 0.12, 0.75)
      button.icon:SetTexCoord(0, 1, 0, 1)
      button.text:SetText("")
      button.selected:Hide()
      button:SetScript("OnClick", nil)
      button:SetScript("OnEnter", nil)
      button:SetScript("OnLeave", nil)
    else
      button.icon:SetTexture(record.icon or DEFAULT_MACRO_ICON)
      button.icon:SetTexCoord(0.08, 0.92, 0.08, 0.92)
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
    end
    button:Show()
  end

  for index = #records + 1, #frame.macroButtons do
    frame.macroButtons[index]:Hide()
  end

  frame.emptyText:SetShown(#records == 0)
end

local function updateSearchClearButton(frame)
  if not frame.searchClearButton then return end
  local searchText = frame.searchBox and frame.searchBox:GetText() or ""
  frame.searchClearButton:SetShown(searchText ~= "")
end

local function applySearchText(frame, text)
  local settings = getMacroManagerDB()
  if not settings then return end

  local previous = getSelectedRecord(frame)
  settings.searchText = text or ""
  updateSearchClearButton(frame)
  renderMacroGrid(frame)

  local selected = getSelectedRecord(frame)
  if (previous and previous.id) ~= (selected and selected.id) then
    loadSelectedMacro(frame, selected)
  else
    updateButtonStates(frame)
  end
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

  local body = frame.editor:GetText() or ""
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

  MDT:OpenConfirmationFrame(420, 150, L["Delete Macro"], L["Delete"], string.format(L["Delete %s?"], selected.name), doDelete)
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
  frame:SetSize(FRAME_WIDTH, FRAME_HEIGHT)
  frame:SetPoint("TOP", contentParent, "TOP", 0, -20)
  frame.content = { frame = frame }
  frame.macroButtons = {}
  MDT:RegisterMainFrameDragHandle(frame, mainFrame)
  frame:EnableMouse(true)

  frame.bg = frame:CreateTexture(nil, "BACKGROUND")
  frame.bg:SetAllPoints()
  frame.bg:SetColorTexture(unpack(MDT.BackdropColor))

  frame.title = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
  frame.title:SetPoint("TOP", frame, "TOP", 0, -12)
  frame.title:SetText(L["Macro Manager"])

  frame.accountTab = createMacroTab("MDTMacroManagerFrameTab1", frame)
  frame.accountTab:SetID(1)
  frame.accountTab:SetText(L["General Macros"])
  frame.accountTab:SetScript("OnClick", function()
    setScope(frame, "account")
  end)
  frame.accountTab:SetPoint("TOPLEFT", frame, "TOPLEFT", 20, -42)

  frame.characterTab = createMacroTab("MDTMacroManagerFrameTab2", frame)
  frame.characterTab:SetID(2)
  frame.characterTab:SetText(getCharacterTabName())
  frame.characterTab:SetScript("OnClick", function()
    setScope(frame, "character")
  end)
  frame.characterTab:SetPoint("LEFT", frame.accountTab, "RIGHT", -16, 0)
  if PanelTemplates_SetNumTabs then
    PanelTemplates_SetNumTabs(frame, 2)
  end

  frame.searchLabel = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
  frame.searchLabel:SetPoint("TOPLEFT", frame, "TOPLEFT", 20, SEARCH_TOP_OFFSET - 5)
  frame.searchLabel:SetWidth(SEARCH_LABEL_WIDTH)
  frame.searchLabel:SetJustifyH("LEFT")
  frame.searchLabel:SetText(L["Search"])

  frame.searchBox = createAceSearchBox(frame)
  setAcePoint(frame.searchBox, "TOPLEFT", frame, "TOPLEFT", 20 + SEARCH_LABEL_WIDTH + 8, SEARCH_TOP_OFFSET)
  frame.searchBox:SetCallback("OnTextChanged", function(_, _, text)
    if suppressSearchChanged then return end
    applySearchText(frame, text)
  end)

  frame.searchClearButton = createSearchClearButton(frame)
  frame.searchClearButton:SetFrameLevel(frame.searchBox.frame:GetFrameLevel() + 5)
  frame.searchClearButton:SetPoint("RIGHT", frame.searchBox.editbox or frame.searchBox.frame, "RIGHT", -4, 0)
  frame.searchClearButton:SetScript("OnClick", function()
    suppressSearchChanged = true
    frame.searchBox:SetText("")
    suppressSearchChanged = false
    applySearchText(frame, "")
  end)

  frame.gridScroll = CreateFrame("ScrollFrame", "MDTMacroManagerMacroGridScrollFrame", frame, "UIPanelScrollFrameTemplate")
  frame.gridScroll:SetSize(MACRO_GRID_SCROLL_WIDTH, MACRO_GRID_HEIGHT)
  frame.gridScroll:SetPoint("TOPLEFT", frame, "TOPLEFT", 20, GRID_TOP_OFFSET)
  frame.gridChild = CreateFrame("Frame", nil, frame.gridScroll)
  frame.gridScroll:SetScrollChild(frame.gridChild)
  alignScrollBarInside(frame.gridScroll)

  frame.emptyText = frame:CreateFontString(nil, "OVERLAY", "GameFontDisable")
  frame.emptyText:SetPoint("CENTER", frame.gridScroll, "CENTER", -12, 0)
  frame.emptyText:SetText(L["No macros found."])

  frame.selectedIcon = frame:CreateTexture(nil, "ARTWORK")
  frame.selectedIcon:SetSize(38, 38)
  frame.selectedIcon:SetPoint("TOPLEFT", frame.gridScroll, "BOTTOMLEFT", 0, -12)
  frame.selectedIcon:SetTexCoord(0.08, 0.92, 0.08, 0.92)

  frame.selectedName = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
  frame.selectedName:SetPoint("TOPLEFT", frame.selectedIcon, "TOPRIGHT", 10, -2)
  frame.selectedName:SetWidth(178)
  frame.selectedName:SetJustifyH("LEFT")

  frame.changeNameIconButton = createAceButton(frame, L["Change Name/Icon"], 170)
  setAcePoint(frame.changeNameIconButton, "TOPLEFT", frame.selectedName, "BOTTOMLEFT", 0, -7)

  frame.saveButton = createAceButton(frame, L["Save"], ACTION_BUTTON_WIDTH, function()
    saveSelectedMacro(frame)
  end)
  setAcePoint(frame.saveButton, "TOPRIGHT", frame.gridScroll, "BOTTOMRIGHT", 0, -16)

  frame.cancelButton = createAceButton(frame, L["Cancel"], ACTION_BUTTON_WIDTH, function()
    cancelSelectedMacro(frame)
  end)
  setAcePoint(frame.cancelButton, "TOP", frame.saveButton.frame, "BOTTOM", 0, -10)

  frame.editor = createAceEditor(frame)
  setAcePoint(frame.editor, "TOPLEFT", frame.gridScroll, "BOTTOMLEFT", 0, -86)
  frame.editor:SetCallback("OnTextChanged", function()
    updateCharacterCount(frame)
    if not suppressTextChanged then
      frame.dirty = true
      updateButtonStates(frame)
    end
  end)

  frame.characterCount = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
  frame.characterCount:SetPoint("TOP", frame.editor.frame, "BOTTOM", 0, -1)

  frame.deleteButton = createAceButton(frame, L["Delete"], 82, function()
    deleteSelectedMacro(frame)
  end)
  setAcePoint(frame.deleteButton, "TOPLEFT", frame.editor.frame, "BOTTOMLEFT", 0, -20)

  frame.newButton = createAceButton(frame, L["New"], ACTION_BUTTON_WIDTH, function()
    createNewMacro(frame)
  end)
  setAcePoint(frame.newButton, "TOPRIGHT", frame.editor.frame, "BOTTOMRIGHT", 0, -20)

  function frame:Refresh()
    local settings = getMacroManagerDB()
    if not settings then return end

    self.characterTab:SetText(getCharacterTabName())
    local searchText = settings.searchText or ""
    if self.searchBox:GetText() ~= searchText then
      suppressSearchChanged = true
      self.searchBox:SetText(searchText)
      suppressSearchChanged = false
    end
    updateSearchClearButton(self)
    setTabsActive(self)
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
  if self:GetCurrentSection() ~= "macros" then
    self:SetCurrentSection("macros")
    return
  end

  macroManagerFrame = macroManagerFrame or createMacroManagerFrame()
  MDT:HideAllDialogs()
  macroManagerFrame:Show()
  macroManagerFrame:Refresh()
end
