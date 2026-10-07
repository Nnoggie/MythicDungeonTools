local _, MDT = ...
local L = MDT.L

local tinsert, tremove, pairs, ipairs, min, max, abs, tonumber, type, unpack, CreateFrame, GameTooltip, GetTime =
    table.insert, table.remove, pairs, ipairs, math.min, math.max, math.abs, tonumber, type, unpack, CreateFrame,
    GameTooltip, GetTime

local TEXT_SIZES = { 6, 7, 8, 9, 10, 11, 12, 14, 16, 18, 20, 24, 28, 32, 40, 48 }
local MIN_FONT_SIZE, MAX_FONT_SIZE = TEXT_SIZES[1], TEXT_SIZES[#TEXT_SIZES]
local DEFAULT_FONT_SIZE = 8
local DEFAULT_COLOR = "ffffff"
local DEFAULT_ALIGN = "LEFT"
--icon tags like {spell:12345} take up a lot of letters
local MAX_TEXT_LENGTH = 500
local FRAME_PADDING = 2
local BACKGROUND_PADDING = 3
local EDITOR_PADDING = 3
local DRAG_THRESHOLD = 3
local DOUBLE_CLICK_TIME = 0.4
local DUPLICATE_OFFSET = 12
local BASIC_COLORS = { "ffffff", "9d9d9d", "ffd100", "ff8000", "ff3030", "1eff00", "0070dd", "a335ee" }
local CLASS_TOKENS = { "DEATHKNIGHT", "DEMONHUNTER", "DRUID", "EVOKER", "HUNTER", "MAGE", "MONK", "PALADIN", "PRIEST",
  "ROGUE", "SHAMAN", "WARLOCK", "WARRIOR" }
local PALETTE_COLUMNS = 8
--inserted over the highlighted text to find out which part of the text is highlighted
local SELECTION_MARKER = "~MDT~SELECTION~"
local SELECTION_COLOR = { 1, 0.82, 0, 1 }
local BAR_BUTTON_SIZE = 18
local BAR_SPACING = 2
local BAR_GROUP_SPACING = 9
local BAR_PADDING = 4

---text objects are stored as notes so older versions still show them as note pins
---d: x,y,sublevel,shown,text,colorstring,fontSize,justifyH,background
---x,y is the top of the text on its aligned side (top left corner for left aligned text)
---n = true, tx = true
local FIELD_COLOR, FIELD_SIZE, FIELD_ALIGN, FIELD_BACKGROUND = 6, 7, 8, 9
local ANCHOR_POINTS = { LEFT = "TOPLEFT", CENTER = "TOP", RIGHT = "TOPRIGHT" }
local ANCHOR_PADDING_SIGN = { LEFT = -1, CENTER = 0, RIGHT = 1 }
local ANCHOR_WIDTH_FACTOR = { LEFT = 0, CENTER = 0.5, RIGHT = 1 }

local function getFontSize(obj)
  return min(MAX_FONT_SIZE, max(MIN_FONT_SIZE, tonumber(obj.d[FIELD_SIZE]) or DEFAULT_FONT_SIZE))
end

local function getColorHex(obj)
  local hex = obj.d[FIELD_COLOR]
  if type(hex) == "string" and MDT:HexToRGB(hex) then return hex:lower() end
  return DEFAULT_COLOR
end

local function getAlign(obj)
  local align = obj.d[FIELD_ALIGN]
  if align == "CENTER" or align == "RIGHT" then return align end
  return "LEFT"
end

local function hasBackground(obj)
  return obj.d[FIELD_BACKGROUND] == true
end

---Rich text: parts of a text can be colored with |cffRRGGBB ... |r codes
---splits text into visible characters with the inline color they are drawn in (nil = text color)
local function parseRichText(text)
  local units = {}
  local color
  local i, length = 1, #text
  while i <= length do
    local char = text:sub(i, i)
    local unitEnd
    if char == "|" then
      local nextChar = text:sub(i + 1, i + 1)
      if nextChar == "c" and text:sub(i + 2, i + 9):match("^%x%x%x%x%x%x%x%x$") then
        color = text:sub(i + 4, i + 9):lower()
        i = i + 10
      elseif nextChar == "r" then
        color = nil
        i = i + 2
      else
        --escaped pipe or another escape sequence, keep the pipe together with the next character
        unitEnd = min(i + 1, length)
      end
    else
      local byte = char:byte()
      local size = byte >= 240 and 4 or byte >= 224 and 3 or byte >= 192 and 2 or 1
      unitEnd = min(i + size - 1, length)
    end
    if unitEnd then
      tinsert(units, { text = text:sub(i, unitEnd), color = color, startPos = i, endPos = unitEnd })
      i = unitEnd + 1
    end
  end
  return units
end

---returns the text and the 0 based start and end offsets of the selected units in it
local function serializeRichText(units)
  local parts, length, current = {}, 0, nil
  local selectionStart, selectionStop
  local function append(part)
    tinsert(parts, part)
    length = length + #part
  end
  for _, unit in ipairs(units) do
    if unit.color ~= current then
      if current then append("|r") end
      if unit.color then append("|cff"..unit.color) end
      current = unit.color
    end
    if unit.selected and not selectionStart then selectionStart = length end
    append(unit.text)
    if unit.selected then selectionStop = length end
  end
  if current then append("|r") end
  return table.concat(parts), selectionStart, selectionStop
end

local function stripInlineColors(text)
  local units = parseRichText(text)
  for _, unit in ipairs(units) do unit.color = nil end
  return (serializeRichText(units))
end

---colors the characters between the 0 based offsets selectionStart and selectionStop
local function colorTextRange(text, selectionStart, selectionStop, hex, baseHex)
  local units = parseRichText(text)
  for _, unit in ipairs(units) do
    if unit.startPos - 1 >= selectionStart and unit.endPos <= selectionStop then
      unit.color = hex ~= baseHex and hex or nil
      unit.selected = true
    end
  end
  return serializeRichText(units)
end

local function hasVisibleText(text)
  for _, unit in ipairs(parseRichText(text)) do
    if unit.text:match("%S") then return true end
  end
  return false
end

local function applyFontStyle(fontInstance, obj)
  fontInstance:SetFont(STANDARD_TEXT_FONT, getFontSize(obj) * MDT:GetScale(), "OUTLINE")
  fontInstance:SetTextColor(MDT:HexToRGB(getColorHex(obj)))
  fontInstance:SetJustifyH(getAlign(obj))
end

---places a region so the text inside of it starts at the stored position
local function anchorToText(region, obj, padding)
  local scale = MDT:GetScale()
  local align = getAlign(obj)
  region:ClearAllPoints()
  region:SetPoint(ANCHOR_POINTS[align], MDT.main_frame.mapPanelTile1, "TOPLEFT",
    obj.d[1] * scale + ANCHOR_PADDING_SIGN[align] * padding, obj.d[2] * scale + padding)
end

---Returns color and size of newly placed texts
function MDT:GetPresetTextDefaultStyle()
  local r, g, b = MDT:HexToRGB(DEFAULT_COLOR)
  return r, g, b, DEFAULT_FONT_SIZE
end

local function findObjectIndex(preset, obj)
  if not preset or not preset.objects then return end
  for objectIndex, o in pairs(preset.objects) do
    if o == obj then return objectIndex end
  end
end

--live session messages always refer to the displayed preset
local function canSendToLiveSession(preset)
  return MDT.liveSessionActive and preset == MDT:GetCurrentPreset()
end

local function sendUpdatedObject(preset, objectIndex, obj)
  if canSendToLiveSession(preset) then MDT:LiveSession_SendUpdatedObjects({ [objectIndex] = obj }) end
end

---returns the stored copy
local function storeTextObject(preset, obj)
  local storedObj = MDT:StorePresetObject(obj, true, preset)
  if canSendToLiveSession(preset) then MDT:LiveSession_SendObject(obj) end
  return storedObj
end

local function deleteTextObject(preset, objectIndex)
  MDT:RemovePresetObject(preset, objectIndex)
  if canSendToLiveSession(preset) then MDT:LiveSession_SendNoteCommand("delete", objectIndex, "0") end
  MDT:DrawAllPresetObjects()
end

---Texts can be selected and moved without a tool and with the tools that work on them
local function isInteractiveTool(tool)
  return tool == nil or tool == "text" or tool == "mover" or tool == "eraser"
end

---TextFramePool
local activeTextFrames = {}
local inactiveTextFrames = {}
local createTextFrame

local function acquireTextFrame()
  local frame = tremove(inactiveTextFrames) or createTextFrame()
  tinsert(activeTextFrames, frame)
  return frame
end

local function getFrameForObject(obj)
  for _, frame in ipairs(activeTextFrames) do
    if frame.obj == obj and frame:IsShown() then return frame end
  end
end

function MDT:ReleasePresetTexts()
  for i = #activeTextFrames, 1, -1 do
    local frame = tremove(activeTextFrames, i)
    frame:SetScript("OnUpdate", nil)
    frame.dragging = nil
    frame.obj = nil
    frame:Hide()
    tinsert(inactiveTextFrames, frame)
  end
end

function MDT:IsMouseOverPresetText()
  for _, frame in ipairs(activeTextFrames) do
    if frame:IsShown() and frame:IsMouseEnabled() and frame:IsMouseOver() then return true end
  end
  return false
end

function MDT:UpdatePresetTextInteractivity()
  local interactive = isInteractiveTool(MDT:GetCurrentToolbarTool())
  for _, frame in ipairs(activeTextFrames) do
    frame:EnableMouse(interactive)
    frame:EnableMouseWheel(interactive)
    if not interactive then frame.highlight:Hide() end
  end
end

local function forwardMouseWheel(delta)
  local scrollFrame = MDT.main_frame.scrollFrame
  local onMouseWheel = scrollFrame:GetScript("OnMouseWheel")
  if onMouseWheel then onMouseWheel(scrollFrame, delta) end
end

---Selection and editing state
local selectedPreset, selectedObj
local editing
local textEditor
local styleBar
local updateStyleBar

local function getTarget()
  if editing then return editing.preset, editing.obj end
  return selectedPreset, selectedObj
end

local function updateSelectionVisuals()
  for _, frame in ipairs(activeTextFrames) do
    frame.selection:SetShown(frame.obj ~= nil and frame.obj == selectedObj)
  end
end

local function updateStyleBarVisibility()
  if not styleBar then return end
  if editing or selectedObj then
    styleBar:Show()
    updateStyleBar()
  else
    styleBar:Hide()
  end
end

local getStyleBar

local function selectText(preset, obj)
  --a pending delete confirmation belongs to the previous text
  if styleBar and obj ~= selectedObj then styleBar.deleteConfirm:Hide() end
  selectedPreset, selectedObj = preset, obj
  if obj then getStyleBar() end
  updateSelectionVisuals()
  updateStyleBarVisibility()
end

local function measureEditor()
  local editor = textEditor
  local text = editor:GetText()
  --empty trailing lines are not measured, pad them so the cursor stays inside the box
  if text == "" or text:sub(-1) == "\n" then text = text.." " end
  editor.measure:SetText(text)
  local fontHeight = getFontSize(editing.obj) * MDT:GetScale()
  local width = max(editor.measure:GetStringWidth(), fontHeight * 3) + fontHeight
  local height = max(editor.measure:GetStringHeight(), fontHeight)
  editor:SetSize(width + EDITOR_PADDING * 2, height + EDITOR_PADDING * 2)
end

local colorSelection
local editorCursorPosition

local function closeEditor()
  editing = nil
  colorSelection = nil
  if textEditor then
    textEditor:ClearFocus()
    textEditor:Hide()
  end
end

---Stores the text currently being edited, empty texts are removed
---keepSelected leaves the text selected afterwards
function MDT:CommitPresetTextEdit(keepSelected)
  if not editing then return end
  local state = editing
  local text = textEditor:GetText():gsub("^%s+", ""):gsub("%s+$", "")
  --texts with only color codes and whitespace count as empty
  local isEmpty = not hasVisibleText(text)
  closeEditor()

  local resultObj
  if state.isNew then
    if not isEmpty then
      state.obj.d[5] = text
      resultObj = storeTextObject(state.preset, state.obj)
    end
  else
    local objectIndex = findObjectIndex(state.preset, state.obj)
    if objectIndex then
      if isEmpty then
        selectText(nil, nil)
        deleteTextObject(state.preset, objectIndex)
        return
      elseif text ~= state.obj.d[5] or state.styleChanged then
        state.obj.d[5] = text
        sendUpdatedObject(state.preset, objectIndex, state.obj)
      end
      resultObj = state.obj
    end
  end
  if keepSelected and resultObj then
    selectText(state.preset, resultObj)
  else
    selectText(nil, nil)
  end
  MDT:DrawAllPresetObjects()
end

---Finishes editing and clears the selection, returns true if a text was selected or edited
function MDT:ClearPresetTextSelection()
  local hadSelection = editing ~= nil or selectedObj ~= nil
  MDT:CommitPresetTextEdit()
  if selectedObj then selectText(nil, nil) end
  return hadSelection
end

---Drops selection and editing when their preset, sublevel or object are gone
function MDT:ValidatePresetTextSelection()
  if editing and (editing.preset ~= MDT:GetCurrentPreset() or editing.obj.d[3] ~= MDT:GetCurrentSubLevel()) then
    MDT:CommitPresetTextEdit()
  end
  if selectedObj and (selectedPreset ~= MDT:GetCurrentPreset() or selectedObj.d[3] ~= MDT:GetCurrentSubLevel()
        or not selectedObj.d[4] or not findObjectIndex(selectedPreset, selectedObj)) then
    selectText(nil, nil)
  end
end

function MDT:HidePresetTexts()
  MDT:ClearPresetTextSelection()
  for _, frame in ipairs(activeTextFrames) do
    frame:Hide()
  end
end

function MDT:IsEditingPresetText()
  return editing ~= nil
end

local function deleteTarget()
  local preset, obj = getTarget()
  if not obj then return end
  local isNew = editing and editing.isNew
  closeEditor()
  selectText(nil, nil)
  local objectIndex = not isNew and findObjectIndex(preset, obj)
  if objectIndex then
    deleteTextObject(preset, objectIndex)
  else
    MDT:DrawAllPresetObjects()
  end
end

local function duplicateText(preset, obj, x, y)
  local copy = CopyTable(obj)
  copy.d[1], copy.d[2], copy.d[4] = x, y, true
  local storedObj = storeTextObject(preset, copy)
  selectText(preset, storedObj)
  MDT:DrawAllPresetObjects()
end

---width of the text in its current style in unscaled map units
local widthMeasure
local function getTextWidth(obj)
  if not widthMeasure then
    widthMeasure = MDT.main_frame.mapPanelFrame:CreateFontString(nil, "BACKGROUND")
    widthMeasure:Hide()
  end
  --the editor shows icon tags as text, the map shows them as icons
  local isEdited = editing and editing.obj == obj
  local text = isEdited and textEditor:GetText() or obj.d[5] or ""
  if not isEdited then text = MDT:RenderPresetTextTags(text, getFontSize(obj) * MDT:GetScale()) end
  applyFontStyle(widthMeasure, obj)
  widthMeasure:SetText(text)
  return widthMeasure:GetStringWidth() / MDT:GetScale()
end

local function refreshEditorStyle()
  local editor = textEditor
  local obj = editing.obj
  applyFontStyle(editor, obj)
  applyFontStyle(editor.measure, obj)
  anchorToText(editor, obj, EDITOR_PADDING)
  editor:SetBackdropColor(0, 0, 0, hasBackground(obj) and 0.6 or 0.3)
  measureEditor()
  updateStyleBar()
end

---Changes a style property of the selected or edited text
local function setStyle(field, value)
  local preset, obj = getTarget()
  if not obj then return end
  local align = getAlign(obj)
  if field == FIELD_ALIGN then
    if align == value then return end
    --keep the text where it is, only the side it is anchored on changes
    obj.d[1] = obj.d[1] + (ANCHOR_WIDTH_FACTOR[value] - ANCHOR_WIDTH_FACTOR[align]) * getTextWidth(obj)
    obj.d[field] = value
  elseif field == FIELD_SIZE then
    --resize around the top center of the text
    local oldWidth = getTextWidth(obj)
    obj.d[field] = value
    local newWidth = getTextWidth(obj)
    obj.d[1] = obj.d[1] + (0.5 - ANCHOR_WIDTH_FACTOR[align]) * (oldWidth - newWidth)
  else
    obj.d[field] = value
  end
  if editing then
    editing.styleChanged = true
    refreshEditorStyle()
    return
  end
  local objectIndex = findObjectIndex(preset, obj)
  if not objectIndex then
    selectText(nil, nil)
    return
  end
  sendUpdatedObject(preset, objectIndex, obj)
  updateStyleBar()
  MDT:DrawAllPresetObjects()
end

local function stepFontSize(delta)
  local _, obj = getTarget()
  if not obj then return end
  local size = getFontSize(obj)
  local newSize = size
  if delta > 0 then
    for _, s in ipairs(TEXT_SIZES) do
      if s > size then
        newSize = s
        break
      end
    end
  else
    for i = #TEXT_SIZES, 1, -1 do
      if TEXT_SIZES[i] < size then
        newSize = TEXT_SIZES[i]
        break
      end
    end
  end
  if newSize ~= size then setStyle(FIELD_SIZE, newSize) end
end

local function cycleAlign()
  local _, obj = getTarget()
  if not obj then return end
  local align = getAlign(obj)
  setStyle(FIELD_ALIGN, align == "LEFT" and "CENTER" or align == "CENTER" and "RIGHT" or "LEFT")
end

---colorSelection is the highlighted part of the edited text, 0 based offsets
---edit boxes cannot report their highlight and clicking a button clears it,
---so it is captured while the mouse moves over the color controls
local function captureColorSelection()
  if not editing or not textEditor:HasFocus() then return end
  local editor = textEditor
  local text = editor:GetText()
  local cursor = editor:GetCursorPosition()
  --inserting replaces the highlighted text, the marker shows where the highlight was
  editor:SetMaxLetters(0)
  editor:Insert(SELECTION_MARKER)
  local marked = editor:GetText()
  editor:SetText(text)
  editor:SetMaxLetters(MAX_TEXT_LENGTH)
  local markerStart = marked:find(SELECTION_MARKER, 1, true)
  local selectionStart = markerStart and markerStart - 1
  local selectionStop = markerStart and #text - (#marked - (selectionStart + #SELECTION_MARKER))
  if selectionStart and selectionStop > selectionStart then
    colorSelection = { text = text, start = selectionStart, stop = selectionStop }
    editor:HighlightText(selectionStart, selectionStop)
  else
    colorSelection = nil
    editor:SetCursorPosition(cursor)
  end
end

local function getValidColorSelection()
  if editing and colorSelection and colorSelection.text == textEditor:GetText() then return colorSelection end
end

---Gives the keyboard focus back to the editor after a click on the style bar, keeping the highlight
local function restoreEditorFocus()
  if not editing or not textEditor then return end
  textEditor:SetFocus()
  local selection = getValidColorSelection()
  if selection then textEditor:HighlightText(selection.start, selection.stop) end
end

---Colors the highlighted part of the edited text, or the whole text if nothing is highlighted
local function applyColor(hex)
  local _, obj = getTarget()
  if not obj then return end
  local selection = getValidColorSelection()
  if selection then
    local text, start, stop = colorTextRange(selection.text, selection.start, selection.stop, hex, getColorHex(obj))
    editing.styleChanged = true
    textEditor:SetText(text)
    if start then
      colorSelection = { text = text, start = start, stop = stop }
    else
      colorSelection = nil
    end
    updateStyleBar()
    return
  end
  colorSelection = nil
  --coloring the whole text replaces colors of single words
  if editing then
    textEditor:SetText(stripInlineColors(textEditor:GetText()))
  else
    obj.d[5] = stripInlineColors(obj.d[5] or "")
  end
  setStyle(FIELD_COLOR, hex)
end

local openEditor

---Inserts an icon tag at the cursor of the edited text, starts editing the selected text if needed
local function insertTag(tag)
  if not editing then
    if not selectedObj then return end
    openEditor(selectedPreset, selectedObj)
  end
  local editor = textEditor
  colorSelection = nil
  editor:SetFocus()
  editor:SetCursorPosition(min(editorCursorPosition or #editor:GetText(), #editor:GetText()))
  editor:Insert(tag)
end

---Style bar
local function showButtonTooltip(button)
  if not button.tooltipText then return end
  GameTooltip:SetOwner(button, "ANCHOR_TOP")
  GameTooltip:SetText(button.tooltipText, 1, 1, 1, 1, true)
  GameTooltip:Show()
end

local function hideTooltip()
  GameTooltip:Hide()
end

local function createBarButton(bar, tooltipText, onClick)
  local button = CreateFrame("Button", nil, bar)
  button:SetSize(BAR_BUTTON_SIZE, BAR_BUTTON_SIZE)
  button.selected = button:CreateTexture(nil, "BACKGROUND")
  button.selected:SetAllPoints()
  button.selected:SetColorTexture(1, 1, 1, 0.25)
  button.selected:Hide()
  local highlight = button:CreateTexture(nil, "HIGHLIGHT")
  highlight:SetAllPoints()
  highlight:SetColorTexture(1, 1, 1, 0.15)
  button.tooltipText = tooltipText
  button:SetScript("OnEnter", showButtonTooltip)
  button:SetScript("OnLeave", hideTooltip)
  button:SetScript("OnClick", function()
    onClick()
    --clicking the bar takes the keyboard focus away from the editor, give it back
    restoreEditorFocus()
  end)
  return button
end

local function createIconButton(bar, tooltipText, left, right, top, bottom, onClick)
  local button = createBarButton(bar, tooltipText, onClick)
  local icon = button:CreateTexture(nil, "ARTWORK")
  icon:SetPoint("TOPLEFT", 1, -1)
  icon:SetPoint("BOTTOMRIGHT", -1, 1)
  icon:SetTexture("Interface\\AddOns\\MythicDungeonTools\\Textures\\icons")
  icon:SetTexCoord(left, right, top, bottom)
  return button
end

local function createSwatchButton(parent, hex, tooltipText, onClick)
  local button = createBarButton(parent, tooltipText, onClick)
  button.selected:SetColorTexture(1, 1, 1, 1)
  local base = button:CreateTexture(nil, "BACKGROUND", nil, -1)
  base:SetAllPoints()
  base:SetColorTexture(0, 0, 0, 1)
  button.swatch = button:CreateTexture(nil, "ARTWORK")
  button.swatch:SetPoint("TOPLEFT", 2, -2)
  button.swatch:SetPoint("BOTTOMRIGHT", -2, 2)
  button.swatch:SetColorTexture(MDT:HexToRGB(hex))
  button.hex = hex
  button:HookScript("OnEnter", captureColorSelection)
  return button
end

---Palette with basic colors and all class colors
local function createColorPalette(bar)
  local palette = CreateFrame("Frame", nil, bar, "BackdropTemplate")
  palette:SetFrameLevel(bar:GetFrameLevel() + 10)
  palette:SetClampedToScreen(true)
  palette:EnableMouse(true)
  palette:SetBackdrop({
    bgFile = "Interface\\Buttons\\WHITE8X8",
    edgeFile = "Interface\\Buttons\\WHITE8X8",
    edgeSize = 1,
  })
  palette:SetBackdropColor(unpack(MDT.BackdropColor))
  palette:SetBackdropBorderColor(1, 1, 1, 0.2)
  palette.swatches = {}

  local colors = {}
  for _, hex in ipairs(BASIC_COLORS) do tinsert(colors, { hex = hex }) end
  local firstClassColor = #colors + 1
  local classColors = RAID_CLASS_COLORS or {}
  local classNames = LOCALIZED_CLASS_NAMES_MALE or {}
  for _, token in ipairs(CLASS_TOKENS) do
    local color = classColors[token]
    if color then
      local hex = type(color.colorStr) == "string" and color.colorStr:sub(3):lower()
          or MDT:RGBToHex(color.r, color.g, color.b)
      tinsert(colors, { hex = hex, name = classNames[token] or token })
    end
  end

  local step = BAR_BUTTON_SIZE + BAR_SPACING
  local row, column, y = 0, 0, -BAR_PADDING
  for i, color in ipairs(colors) do
    --class colors start in a new row
    if i == firstClassColor and column > 0 then
      row, column = row + 1, 0
      y = y - step - BAR_GROUP_SPACING + BAR_SPACING
    elseif column == PALETTE_COLUMNS then
      row, column = row + 1, 0
      y = y - step
    end
    local swatch = createSwatchButton(palette, color.hex, color.name, function()
      applyColor(color.hex)
      palette:Hide()
    end)
    swatch:SetPoint("TOPLEFT", palette, "TOPLEFT", BAR_PADDING + column * step, y)
    tinsert(palette.swatches, swatch)
    column = column + 1
  end
  palette:SetSize(BAR_PADDING * 2 + PALETTE_COLUMNS * step - BAR_SPACING, -y + step - BAR_SPACING + BAR_PADDING)
  palette:Hide()
  return palette
end

local ALIGN_LABELS = { LEFT = L["Align Left"], CENTER = L["Align Center"], RIGHT = L["Align Right"] }

local function updateAlignButton(button, align)
  for _, line in ipairs(button.lines) do
    line:ClearAllPoints()
    if align == "LEFT" then
      line:SetPoint("LEFT", button, "LEFT", 3, line.y)
    elseif align == "RIGHT" then
      line:SetPoint("RIGHT", button, "RIGHT", -3, line.y)
    else
      line:SetPoint("CENTER", button, "CENTER", 0, line.y)
    end
  end
  button.tooltipText = L["Text Alignment"].."\n|cffaaaaaa"..ALIGN_LABELS[align].."|r"
end

---one button that cycles through left, center and right alignment
local function createAlignButton(bar)
  local button = createBarButton(bar, nil, cycleAlign)
  button.lines = {}
  for i, width in ipairs({ 12, 8, 12, 6 }) do
    local line = button:CreateTexture(nil, "ARTWORK")
    line:SetColorTexture(1, 1, 1, 1)
    line:SetSize(width, 1.5)
    line.y = 4.5 - (i - 1) * 3
    tinsert(button.lines, line)
  end
  --refresh the tooltip after a click changed the alignment
  button:HookScript("OnClick", function(self)
    if GameTooltip:IsOwned(self) then showButtonTooltip(self) end
  end)
  updateAlignButton(button, DEFAULT_ALIGN)
  return button
end

local function createBackgroundButton(bar)
  local button = createBarButton(bar, L["Text Background"], function()
    local _, obj = getTarget()
    if obj then setStyle(FIELD_BACKGROUND, not hasBackground(obj) or nil) end
  end)
  local box = button:CreateTexture(nil, "ARTWORK")
  box:SetPoint("TOPLEFT", 3, -3)
  box:SetPoint("BOTTOMRIGHT", -3, 3)
  box:SetColorTexture(0, 0, 0, 0.8)
  local letter = button:CreateFontString(nil, "OVERLAY")
  letter:SetFont(STANDARD_TEXT_FONT, 10, "OUTLINE")
  letter:SetPoint("CENTER", 0, 0)
  letter:SetText("A")
  return button
end

local function createTextButton(bar, text, tooltipText, onClick)
  local button = createBarButton(bar, tooltipText, onClick)
  local label = button:CreateFontString(nil, "OVERLAY")
  label:SetFont(STANDARD_TEXT_FONT, 14, "OUTLINE")
  label:SetPoint("CENTER", 0, 1)
  label:SetText(text)
  return button
end

---Keeps the style bar next to the edited or selected text, above it if there is room inside the main frame
---Palette and icon picker open away from the text so they never cover it
local function anchorStylePopups(bar, below)
  if not bar.palette or not bar.iconPicker or not bar.deleteConfirm then return end
  bar.popupsBelow = below
  bar.palette:ClearAllPoints()
  bar.iconPicker:ClearAllPoints()
  bar.deleteConfirm:ClearAllPoints()
  if below then
    bar.palette:SetPoint("TOPLEFT", bar.color, "BOTTOMLEFT", -BAR_PADDING, -BAR_PADDING - 2)
    bar.iconPicker:SetPoint("TOP", bar, "BOTTOM", 0, -2)
    bar.deleteConfirm:SetPoint("TOPRIGHT", bar, "BOTTOMRIGHT", 0, -2)
  else
    bar.palette:SetPoint("BOTTOMLEFT", bar.color, "TOPLEFT", -BAR_PADDING, BAR_PADDING + 2)
    bar.iconPicker:SetPoint("BOTTOM", bar, "TOP", 0, 2)
    bar.deleteConfirm:SetPoint("BOTTOMRIGHT", bar, "TOPRIGHT", 0, 2)
  end
end

---Small confirmation next to the delete button
local function createDeleteConfirm(bar)
  local confirm = CreateFrame("Frame", nil, bar, "BackdropTemplate")
  confirm:SetFrameLevel(bar:GetFrameLevel() + 10)
  confirm:SetClampedToScreen(true)
  confirm:EnableMouse(true)
  confirm:SetBackdrop({
    bgFile = "Interface\\Buttons\\WHITE8X8",
    edgeFile = "Interface\\Buttons\\WHITE8X8",
    edgeSize = 1,
  })
  confirm:SetBackdropColor(unpack(MDT.BackdropColor))
  confirm:SetBackdropBorderColor(1, 1, 1, 0.2)
  local label = confirm:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
  label:SetPoint("LEFT", BAR_PADDING + 2, 0)
  label:SetText(L["Delete text?"])

  local cancel = createBarButton(confirm, CANCEL, function() confirm:Hide() end)
  cancel:SetPoint("RIGHT", -BAR_PADDING, 0)
  local cancelIcon = cancel:CreateTexture(nil, "ARTWORK")
  cancelIcon:SetPoint("TOPLEFT", 3, -3)
  cancelIcon:SetPoint("BOTTOMRIGHT", -3, 3)
  cancelIcon:SetTexture("Interface\\RaidFrame\\ReadyCheck-NotReady")

  local delete = createBarButton(confirm, L["Delete"], function()
    confirm:Hide()
    deleteTarget()
  end)
  delete:SetPoint("RIGHT", cancel, "LEFT", -BAR_SPACING, 0)
  delete.selected:SetColorTexture(0.8, 0.1, 0.1, 0.5)
  delete.selected:Show()
  local deleteIcon = delete:CreateTexture(nil, "ARTWORK")
  deleteIcon:SetPoint("TOPLEFT", 3, -3)
  deleteIcon:SetPoint("BOTTOMRIGHT", -3, 3)
  deleteIcon:SetTexture("Interface\\RaidFrame\\ReadyCheck-Ready")

  confirm:SetSize(BAR_PADDING + 2 + label:GetStringWidth() + 8 + BAR_BUTTON_SIZE * 2 + BAR_SPACING + BAR_PADDING,
    BAR_BUTTON_SIZE + BAR_PADDING * 2)
  --only one popup at a time
  confirm:SetScript("OnShow", function()
    bar.palette:Hide()
    bar.iconPicker:Hide()
  end)
  confirm:Hide()
  return confirm
end

---Asks for confirmation before deleting the selected or edited text
local function confirmDelete()
  if styleBar and getTarget() then styleBar.deleteConfirm:Show() end
end

local function positionStyleBar(bar)
  local target
  if editing then
    target = textEditor
  elseif selectedObj then
    target = getFrameForObject(selectedObj)
  end
  if not target then return end
  local parent = MDT.main_frame
  local left, bottom, width, height = target:GetRect()
  local parentLeft, parentBottom, parentWidth, parentHeight = parent:GetRect()
  if not left or not parentLeft then return end
  local scale = target:GetEffectiveScale() / parent:GetEffectiveScale()
  local barWidth, barHeight = bar:GetSize()
  local x = (left + width / 2) * scale - parentLeft
  x = min(max(x, barWidth / 2), parentWidth - barWidth / 2)
  local y = (bottom + height) * scale - parentBottom + 6
  local isBelowTarget = y + barHeight > parentHeight
  if isBelowTarget then
    y = bottom * scale - parentBottom - 6 - barHeight
  end
  bar:ClearAllPoints()
  bar:SetPoint("BOTTOM", parent, "BOTTOMLEFT", x, y)
  if bar.popupsBelow ~= isBelowTarget then anchorStylePopups(bar, isBelowTarget) end
end

function getStyleBar()
  if styleBar then return styleBar end
  local bar = CreateFrame("Frame", "MDTPresetTextStyleBar", MDT.main_frame, "BackdropTemplate")
  bar:SetFrameStrata("DIALOG")
  bar:SetClampedToScreen(true)
  bar:EnableMouse(true)
  bar:SetBackdrop({
    bgFile = "Interface\\Buttons\\WHITE8X8",
    edgeFile = "Interface\\Buttons\\WHITE8X8",
    edgeSize = 1,
  })
  bar:SetBackdropColor(unpack(MDT.BackdropColor))
  bar:SetBackdropBorderColor(1, 1, 1, 0.2)

  local x = BAR_PADDING
  local function place(widget, width, isGroupStart)
    if isGroupStart and x > BAR_PADDING then
      local separator = bar:CreateTexture(nil, "ARTWORK")
      separator:SetColorTexture(1, 1, 1, 0.2)
      separator:SetSize(1, BAR_BUTTON_SIZE - 4)
      separator:SetPoint("LEFT", bar, "LEFT", x + (BAR_GROUP_SPACING - BAR_SPACING) / 2 - 1, 0)
      x = x + BAR_GROUP_SPACING - BAR_SPACING
    end
    widget:SetPoint("LEFT", bar, "LEFT", x, 0)
    x = x + (width or BAR_BUTTON_SIZE) + BAR_SPACING
  end

  bar.edit = createIconButton(bar, L["Edit"], 0.75, 1, 0, 0.25, function()
    if editing then
      MDT:CommitPresetTextEdit(true)
    elseif selectedObj then
      openEditor(selectedPreset, selectedObj)
    end
  end)
  place(bar.edit)

  place(createTextButton(bar, "-", L["Decrease Text Size"], function() stepFontSize(-1) end), nil, true)
  bar.size = CreateFrame("Frame", nil, bar)
  bar.size:SetSize(22, BAR_BUTTON_SIZE)
  bar.size.text = bar.size:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
  bar.size.text:SetPoint("CENTER")
  bar.size.tooltipText = L["textSizeHint"]
  bar.size:EnableMouse(true)
  bar.size:EnableMouseWheel(true)
  bar.size:SetScript("OnMouseWheel", function(_, delta) stepFontSize(delta) end)
  bar.size:SetScript("OnEnter", showButtonTooltip)
  bar.size:SetScript("OnLeave", hideTooltip)
  place(bar.size, 22)
  place(createTextButton(bar, "+", L["Increase Text Size"], function() stepFontSize(1) end))

  bar.align = createAlignButton(bar)
  place(bar.align, nil, true)
  bar.background = createBackgroundButton(bar)
  place(bar.background)

  --colors are tucked away in a palette, the button shows the text color
  bar.color = createSwatchButton(bar, DEFAULT_COLOR, L["Text Color"], function()
    bar.palette:SetShown(not bar.palette:IsShown())
  end)
  bar.color.selected:Hide()
  place(bar.color)
  bar.palette = createColorPalette(bar)

  bar.icons = createBarButton(bar, L["Insert Icon"], function()
    bar.palette:Hide()
    bar.iconPicker:SetShown(not bar.iconPicker:IsShown())
  end)
  local iconsTexture = bar.icons:CreateTexture(nil, "ARTWORK")
  iconsTexture:SetPoint("TOPLEFT", 2, -2)
  iconsTexture:SetPoint("BOTTOMRIGHT", -2, 2)
  iconsTexture:SetTexture("Interface\\TargetingFrame\\UI-RaidTargetingIcon_1")
  place(bar.icons)
  bar.iconPicker = MDT:CreatePresetTextIconPicker(bar, insertTag)
  bar.color:HookScript("OnClick", function()
    bar.iconPicker:Hide()
    bar.deleteConfirm:Hide()
  end)
  bar.icons:HookScript("OnClick", function() bar.deleteConfirm:Hide() end)

  place(createIconButton(bar, L["Delete"], 0.25, 0.5, 0.75, 1, function()
    bar.deleteConfirm:SetShown(not bar.deleteConfirm:IsShown())
  end), nil, true)
  bar.deleteConfirm = createDeleteConfirm(bar)
  anchorStylePopups(bar, false)

  bar:SetSize(x - BAR_SPACING + BAR_PADDING, BAR_BUTTON_SIZE + BAR_PADDING * 2)
  bar:SetScript("OnUpdate", positionStyleBar)
  bar:SetScript("OnShow", positionStyleBar)
  --child popups would otherwise show again with the bar
  bar:SetScript("OnHide", function()
    bar.palette:Hide()
    bar.iconPicker:Hide()
    bar.deleteConfirm:Hide()
  end)
  bar:Hide()
  styleBar = bar
  return bar
end

function updateStyleBar()
  local _, obj = getTarget()
  if not styleBar or not obj then return end
  local hex = getColorHex(obj)
  styleBar.color.swatch:SetColorTexture(MDT:HexToRGB(hex))
  for _, swatch in ipairs(styleBar.palette.swatches) do
    swatch.selected:SetShown(swatch.hex == hex)
  end
  styleBar.edit.selected:SetShown(editing ~= nil)
  styleBar.size.text:SetText(getFontSize(obj))
  updateAlignButton(styleBar.align, getAlign(obj))
  styleBar.background.selected:SetShown(hasBackground(obj))
end

---Editor
local function getTextEditor()
  if textEditor then return textEditor end
  local mapPanelFrame = MDT.main_frame.mapPanelFrame
  local editor = CreateFrame("EditBox", "MDTPresetTextEditBox", mapPanelFrame, "BackdropTemplate")
  editor:SetFrameLevel(mapPanelFrame:GetFrameLevel() + 50)
  editor:SetMultiLine(true)
  editor:SetAutoFocus(false)
  editor:SetMaxLetters(MAX_TEXT_LENGTH)
  editor:SetTextInsets(EDITOR_PADDING, EDITOR_PADDING, EDITOR_PADDING, EDITOR_PADDING)
  editor:SetBackdrop({
    bgFile = "Interface\\Buttons\\WHITE8X8",
    edgeFile = "Interface\\Buttons\\WHITE8X8",
    edgeSize = 1,
  })
  editor:SetBackdropBorderColor(unpack(SELECTION_COLOR))
  editor.measure = editor:CreateFontString(nil, "BACKGROUND")
  editor.measure:Hide()

  --enter and escape finish editing and keep the text selected, shift+enter starts a new line
  editor:SetScript("OnEnterPressed", function(self)
    if IsShiftKeyDown() then
      self:Insert("\n")
      return
    end
    MDT:CommitPresetTextEdit(true)
  end)
  editor:SetScript("OnEscapePressed", function()
    MDT:CommitPresetTextEdit(true)
  end)
  editor:SetScript("OnHide", function()
    MDT:CommitPresetTextEdit()
  end)
  editor:SetScript("OnTextChanged", function()
    if editing then measureEditor() end
  end)
  --the icon picker search box takes the focus, remember where icons go
  editor:SetScript("OnCursorChanged", function(self)
    if self:HasFocus() then editorCursorPosition = self:GetCursorPosition() end
  end)
  editor:EnableMouseWheel(true)
  editor:SetScript("OnMouseWheel", function(_, delta)
    if IsControlKeyDown() then
      stepFontSize(delta)
    else
      forwardMouseWheel(delta)
    end
  end)
  editor:Hide()
  textEditor = editor
  return editor
end

function openEditor(preset, obj, isNew)
  if editing and editing.obj == obj then return end
  MDT:CommitPresetTextEdit()
  local editor = getTextEditor()
  getStyleBar()
  --set before clearing the selection so the style bar stays open
  editing = { preset = preset, obj = obj, isNew = isNew }
  selectText(nil, nil)
  --the font has to be set before any text
  refreshEditorStyle()
  editor:SetText(obj.d[5] or "")
  editorCursorPosition = #editor:GetText()
  editor:Show()
  editor:SetFocus()
  updateStyleBarVisibility()
  --hide the text that is being edited
  for _, frame in ipairs(activeTextFrames) do
    if frame.obj == obj then frame:Hide() end
  end
end

---Left click on the map with the text tool selected
function MDT:OnTextToolMapClick()
  local x, y = MDT:GetCursorPosition()
  local scale = MDT:GetScale()
  --center the first line on the cursor
  y = y + DEFAULT_FONT_SIZE * scale / 2
  local obj = {
    d = { x * (1 / scale), y * (1 / scale), MDT:GetCurrentSubLevel(), true, "",
      DEFAULT_COLOR, DEFAULT_FONT_SIZE, DEFAULT_ALIGN },
    n = true,
    tx = true,
  }
  --one text per tool use like notes, shift keeps the tool selected
  --deselect before opening the editor, deselecting finishes any edit
  if not IsShiftKeyDown() then MDT:UpdateSelectedToolbarTool() end
  openEditor(MDT:GetCurrentPreset(), obj, true)
end

---Context menu
local function openContextMenu(preset, obj)
  MDT:CreateContextMenu(MDT.main_frame, function(_, rootDescription)
    rootDescription:CreateButton(L["Edit"], function()
      if findObjectIndex(preset, obj) then openEditor(preset, obj) end
    end)
    rootDescription:CreateButton(L["Duplicate"], function()
      if not findObjectIndex(preset, obj) then return end
      duplicateText(preset, obj, obj.d[1] + DUPLICATE_OFFSET, obj.d[2] - DUPLICATE_OFFSET)
    end)
    rootDescription:CreateButton(L["Delete"], function()
      if not findObjectIndex(preset, obj) then return end
      selectText(preset, obj)
      confirmDelete()
    end)
    rootDescription:CreateButton(L["Close"], function() end)
  end)
end

---Dragging
local function updateDrag(frame)
  local x, y = MDT:GetCursorPosition()
  local dx, dy = x - frame.dragStartX, y - frame.dragStartY
  if not frame.dragging then
    local zoom = MDT.main_frame.mapPanelFrame:GetScale()
    if abs(dx) * zoom < DRAG_THRESHOLD and abs(dy) * zoom < DRAG_THRESHOLD then return end
    frame.dragging = true
  end
  frame:ClearAllPoints()
  frame:SetPoint(frame.anchorPoint, MDT.main_frame.mapPanelTile1, "TOPLEFT", frame.anchorX + dx, frame.anchorY + dy)
end

---returns true if the text was dragged, alt+drag places a copy and leaves the original where it was
local function stopDrag(frame)
  frame:SetScript("OnUpdate", nil)
  local wasDragging = frame.dragging
  frame.dragging = nil
  if not wasDragging then return false end
  local obj = frame.obj
  local preset = MDT:GetCurrentPreset()
  local objectIndex = findObjectIndex(preset, obj)
  if objectIndex then
    local x, y = MDT:GetCursorPosition()
    local scale = MDT:GetScale()
    local newX = obj.d[1] + (x - frame.dragStartX) * (1 / scale)
    local newY = obj.d[2] + (y - frame.dragStartY) * (1 / scale)
    if frame.duplicateOnDrag then
      duplicateText(preset, obj, newX, newY)
      return true
    end
    obj.d[1], obj.d[2] = newX, newY
    sendUpdatedObject(preset, objectIndex, obj)
    selectText(preset, obj)
  end
  MDT:DrawAllPresetObjects()
  return true
end

local lastClickObj, lastClickTime

local function createEdge(frame, point1, point2, horizontal)
  local edge = frame.selection:CreateTexture(nil, "OVERLAY")
  edge:SetColorTexture(unpack(SELECTION_COLOR))
  edge:SetPoint(point1)
  edge:SetPoint(point2)
  if horizontal then edge:SetHeight(1) else edge:SetWidth(1) end
end

---Texts are drawn above enemies but take mouse input below them:
---the frame itself is an invisible click area under the enemies, its display child draws everything above them
function createTextFrame()
  local mapPanelFrame = MDT.main_frame.mapPanelFrame
  local frame = CreateFrame("Frame", nil, mapPanelFrame)
  --enemies start at frame level 4, keep the click area below them
  frame:SetFrameLevel(mapPanelFrame:GetFrameLevel())
  local display = CreateFrame("Frame", nil, frame)
  display:SetAllPoints()
  --below the text editor, above enemies and pull outlines
  display:SetFrameLevel(mapPanelFrame:GetFrameLevel() + 45)
  frame.display = display
  frame.background = display:CreateTexture(nil, "BACKGROUND")
  frame.background:SetAllPoints()
  frame.background:SetColorTexture(0, 0, 0, 0.6)
  frame.highlight = display:CreateTexture(nil, "BORDER")
  frame.highlight:SetAllPoints()
  frame.highlight:Hide()
  frame.selection = CreateFrame("Frame", nil, display)
  frame.selection:SetAllPoints()
  createEdge(frame, "TOPLEFT", "TOPRIGHT", true)
  createEdge(frame, "BOTTOMLEFT", "BOTTOMRIGHT", true)
  createEdge(frame, "TOPLEFT", "BOTTOMLEFT", false)
  createEdge(frame, "TOPRIGHT", "BOTTOMRIGHT", false)
  frame.selection:Hide()
  frame.fontString = display:CreateFontString(nil, "OVERLAY")
  frame.fontString:SetPoint("TOPLEFT", FRAME_PADDING, -FRAME_PADDING)
  frame.fontString:SetShadowOffset(1, -1)
  frame.fontString:SetShadowColor(0, 0, 0, 1)

  frame:SetScript("OnEnter", function(self)
    if MDT:GetCurrentToolbarTool() == "eraser" then
      self.highlight:SetColorTexture(1, 0.2, 0.2, 0.35)
    else
      self.highlight:SetColorTexture(1, 1, 1, 0.12)
    end
    self.highlight:Show()
  end)
  frame:SetScript("OnLeave", function(self)
    self.highlight:Hide()
  end)
  frame:SetScript("OnMouseWheel", function(self, delta)
    if IsControlKeyDown() and self.obj and self.obj == selectedObj then
      stepFontSize(delta)
    else
      forwardMouseWheel(delta)
    end
  end)
  frame:SetScript("OnMouseDown", function(self, button)
    if button ~= "LeftButton" or not self.obj then return end
    if MDT:GetCurrentToolbarTool() == "eraser" then
      local preset = MDT:GetCurrentPreset()
      local objectIndex = findObjectIndex(preset, self.obj)
      if objectIndex then
        if selectedObj == self.obj then selectText(nil, nil) end
        deleteTextObject(preset, objectIndex)
      end
      return
    end
    self.dragStartX, self.dragStartY = MDT:GetCursorPosition()
    self.dragging = nil
    self.duplicateOnDrag = IsAltKeyDown()
    self:SetScript("OnUpdate", updateDrag)
  end)
  frame:SetScript("OnMouseUp", function(self, button)
    if not self.obj then return end
    local obj = self.obj
    local preset = MDT:GetCurrentPreset()
    if button == "LeftButton" then
      if MDT:GetCurrentToolbarTool() == "eraser" then return end
      --finish editing another text first
      if editing and editing.obj ~= obj then MDT:CommitPresetTextEdit() end
      if stopDrag(self) then return end
      if not findObjectIndex(preset, obj) then return end
      --click selects, double click edits
      local now = GetTime()
      if lastClickObj == obj and lastClickTime and now - lastClickTime < DOUBLE_CLICK_TIME then
        lastClickObj, lastClickTime = nil, nil
        openEditor(preset, obj)
      else
        lastClickObj, lastClickTime = obj, now
        selectText(preset, obj)
      end
    elseif button == "RightButton" then
      if not findObjectIndex(preset, obj) then return end
      MDT:CommitPresetTextEdit()
      selectText(preset, obj)
      openContextMenu(preset, obj)
    end
  end)
  return frame
end

---DrawText
function MDT:DrawText(obj, objectIndex)
  local frame = acquireTextFrame()
  local padding = hasBackground(obj) and BACKGROUND_PADDING or FRAME_PADDING
  frame.obj = obj
  frame.objectIndex = objectIndex
  applyFontStyle(frame.fontString, obj)
  frame.fontString:SetText(MDT:RenderPresetTextTags(obj.d[5] or "", getFontSize(obj) * MDT:GetScale()))
  frame.fontString:ClearAllPoints()
  frame.fontString:SetPoint("TOPLEFT", padding, -padding)
  frame:SetSize(frame.fontString:GetStringWidth() + padding * 2, frame.fontString:GetStringHeight() + padding * 2)
  anchorToText(frame, obj, padding)
  local anchorPoint, _, _, anchorX, anchorY = frame:GetPoint(1)
  frame.anchorPoint, frame.anchorX, frame.anchorY = anchorPoint, anchorX, anchorY
  frame.background:SetShown(hasBackground(obj))
  frame.selection:SetShown(obj == selectedObj)
  local interactive = isInteractiveTool(MDT:GetCurrentToolbarTool())
  frame:EnableMouse(interactive)
  frame:EnableMouseWheel(interactive)
  frame.highlight:Hide()
  if editing and editing.obj == obj then
    frame:Hide()
  else
    frame:Show()
  end
end
