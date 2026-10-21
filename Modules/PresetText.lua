local _, MDT = ...
local L = MDT.L

local tinsert, tremove, pairs, ipairs, min, max, abs, tonumber, type, unpack, CreateFrame, MDTTooltip, GetTime =
    table.insert, table.remove, pairs, ipairs, math.min, math.max, math.abs, tonumber, type, unpack, CreateFrame,
    MDTTooltip, GetTime
local cos, sin, rad, deg, atan2, floor = math.cos, math.sin, math.rad, math.deg, math.atan2, math.floor
local GetCursorPosition, IsShiftKeyDown, IsMouseButtonDown = GetCursorPosition, IsShiftKeyDown, IsMouseButtonDown

local TEXT_SIZES = { 6, 7, 8, 9, 10, 11, 12, 14, 16, 18, 20, 24, 28, 32, 40, 48 }
local MIN_FONT_SIZE, MAX_FONT_SIZE = TEXT_SIZES[1], TEXT_SIZES[#TEXT_SIZES]
local DEFAULT_FONT_SIZE = 12
--inline icons are scaled with the font by the game, a fixed markup size keeps them
--in the proportions they have at text size 12 for every text size and map scale
local ICON_MARKUP_SIZE = 12
local DEFAULT_COLOR = "ffffff"
local DEFAULT_ALIGN = "LEFT"
--keeps presets and live session messages small, icon tags and color codes take up a lot of letters
local MAX_TEXT_LENGTH = 2000
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
local RESIZE_HANDLE_SIZE = 16
local ROTATE_HANDLE_SIZE = 5
--the knob takes clicks a bit around itself, it is small to grab
local ROTATE_HANDLE_HIT_SIZE = 10
--from the top edge of the text to the center of the knob
local ROTATE_HANDLE_DISTANCE = 10
local ROTATION_SNAP = 15

---text objects are stored as notes so older versions still show them as note pins
---d: x,y,sublevel,shown,text,colorstring,fontSize,justifyH,background,rotation
---x,y is the top of the upright text on its aligned side (top left corner for left aligned text)
---rotation is in whole degrees counter clockwise around the center of the text, nil when upright
---n = true, tx = true
local FIELD_COLOR, FIELD_SIZE, FIELD_ALIGN, FIELD_BACKGROUND, FIELD_ROTATION = 6, 7, 8, 9, 10
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

---in radians
local function getRotation(obj)
  local degrees = tonumber(obj.d[FIELD_ROTATION])
  --imported and received texts can hold anything, nan fails every comparison
  if not degrees or not (abs(degrees) <= 360) then return 0 end
  return rad(degrees % 360)
end

---rotates a point around the origin, y points up
local function rotatePoint(x, y, rotation)
  local c, s = cos(rotation), sin(rotation)
  return x * c - y * s, x * s + y * c
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
    elseif char == "{" and text:find("^{[^{}|]+}", i) then
      --icon tags stay in one piece so colors never end up inside of them
      local _, tagEnd = text:find("^{[^{}|]+}", i)
      unitEnd = tagEnd
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
  MDT.UI.Fonts.Apply(fontInstance, getFontSize(obj) * MDT:GetScale(), "OUTLINE", obj.d and obj.d[5])
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

--changes are sent for the live preset even if it is no longer displayed,
--e.g. an edit that is finished by switching presets
local function canSendToLiveSession(preset)
  return MDT.liveSessionActive and preset and preset.uid ~= nil and preset.uid == MDT.livePresetUID
end

local function sendUpdatedObject(preset, objectIndex, obj)
  if canSendToLiveSession(preset) then MDT:LiveSession_SendUpdatedObjects({ [objectIndex] = obj }, preset) end
end

---style changes like scrolling through font sizes are sent once they settle
local SEND_DELAY = 0.3
local pendingUpdates = {}
local updateTimer
local function flushPendingUpdates()
  if updateTimer then updateTimer:Cancel() end
  updateTimer = nil
  for obj, preset in pairs(pendingUpdates) do
    pendingUpdates[obj] = nil
    --look up the index now, objects may have moved in the meantime
    local objectIndex = findObjectIndex(preset, obj)
    if objectIndex then sendUpdatedObject(preset, objectIndex, obj) end
  end
end

local function queueUpdatedObject(preset, obj)
  if not canSendToLiveSession(preset) then return end
  pendingUpdates[obj] = preset
  if not updateTimer then updateTimer = C_Timer.NewTimer(SEND_DELAY, flushPendingUpdates) end
end

---returns the stored copy
local function storeTextObject(preset, obj)
  local storedObj = MDT:StorePresetObject(obj, true, preset)
  if canSendToLiveSession(preset) then MDT:LiveSession_SendObject(obj, preset) end
  return storedObj
end

local function deleteTextObject(preset, objectIndex, noRedraw)
  --pending updates refer to indices that are about to shift
  flushPendingUpdates()
  MDT:RemovePresetObject(preset, objectIndex)
  if canSendToLiveSession(preset) then MDT:LiveSession_SendNoteCommand("delete", objectIndex, "0", nil, preset) end
  if not noRedraw then MDT:DrawAllPresetObjects() end
end

---Texts can be selected and moved without a tool and with the tools that work on them
---Texts draw above enemies but below the toolbar, which sits on top of the map's left edge
---returns the levels of the text display and of the text editor
local function getTextFrameLevels()
  local toolbar = MDT.main_frame.toolbar
  local toolbarLevel = toolbar and toolbar:GetFrameLevel() or 20
  return toolbarLevel - 2, toolbarLevel - 1
end

local function isInteractiveTool(tool)
  return tool == nil or tool == "text" or tool == "mover" or tool == "eraser"
end

---TextFramePool
local activeTextFrames = {}
local inactiveTextFrames = {}
local createTextFrame
local layoutTextFrame

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

---Presses on a text frame per mouse button: the text frame that handles them, or MAP for presses that went to the map
local MAP = {}
local pressOwner = {}

function MDT:ReleasePresetTexts()
  for i = #activeTextFrames, 1, -1 do
    local frame = tremove(activeTextFrames, i)
    frame:SetScript("OnUpdate", nil)
    frame.display:SetScript("OnUpdate", nil)
    frame.dragging = nil
    frame.obj = nil
    frame:Hide()
    tinsert(inactiveTextFrames, frame)
  end
  --hidden frames lose their mouse ups, presses on the map are still finished
  for button, owner in pairs(pressOwner) do
    if owner ~= MAP then pressOwner[button] = nil end
  end
end

---the frame covers rotated texts with an upright box, only the turned text itself counts
local function isCursorOverText(frame)
  if not frame:IsMouseOver() then return false end
  local centerX, centerY = frame:GetCenter()
  if not centerX then return false end
  local cursorX, cursorY = GetCursorPosition()
  local scale = frame:GetEffectiveScale()
  --turn the cursor back into the axes of the upright text
  local x, y = rotatePoint(cursorX / scale - centerX, cursorY / scale - centerY, -frame.textRotation)
  return abs(x) <= frame.display:GetWidth() / 2 and abs(y) <= frame.display:GetHeight() / 2
end

---the text under the cursor, the frame that got the mouse event first, otherwise the last drawn one
---the frame of a rotated text can cover other texts with its empty corners
local function getTextUnderCursor(frame)
  if isCursorOverText(frame) then return frame end
  for i = #activeTextFrames, 1, -1 do
    local other = activeTextFrames[i]
    if other ~= frame and other:IsShown() and other:IsMouseEnabled() and isCursorOverText(other) then return other end
  end
end

function MDT:IsMouseOverPresetText()
  for _, frame in ipairs(activeTextFrames) do
    if frame:IsShown() and frame:IsMouseEnabled() and isCursorOverText(frame) then return true end
  end
  return false
end

function MDT:UpdatePresetTextInteractivity()
  local interactive = isInteractiveTool(MDT:GetCurrentToolbarTool())
  for _, frame in ipairs(activeTextFrames) do
    frame:EnableMouse(interactive)
    frame:EnableMouseWheel(interactive)
    if not interactive then
      frame.display:SetScript("OnUpdate", nil)
      frame.highlight:Hide()
    end
  end
end

local function forwardMouseWheel(delta)
  local scrollFrame = MDT.main_frame.scrollFrame
  local onMouseWheel = scrollFrame:GetScript("OnMouseWheel")
  if onMouseWheel then onMouseWheel(scrollFrame, delta) end
end

local function forwardMouseClick(script, button)
  local scrollFrame = MDT.main_frame.scrollFrame
  local onClick = scrollFrame:GetScript(script)
  if onClick then onClick(scrollFrame, button) end
end

--the map press can outlive the text frame it started on, e.g. the eraser redraws all texts when it starts
local mapPressFrame = CreateFrame("Frame")
mapPressFrame:RegisterEvent("GLOBAL_MOUSE_UP")
mapPressFrame:SetScript("OnEvent", function(_, _, button)
  if pressOwner[button] ~= MAP then return end
  pressOwner[button] = nil
  forwardMouseClick("OnMouseUp", button)
end)

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
  editor.measure:SetText(editor:GetText())
  local fontHeight = getFontSize(editing.obj) * MDT:GetScale()
  local width = max(editor.measure:GetStringWidth(), fontHeight * 3) + fontHeight
  --multi-line edit boxes fit their height to the text themselves,
  --a measured height can come out a fraction lower and hides the cursor and highlight of a single line
  editor:SetWidth(width + EDITOR_PADDING * 2)
end

---hidden font string in the style of the text, measures in scaled map units
local textMeasure
local function getTextMeasure(obj)
  if not textMeasure then
    textMeasure = MDT.main_frame.mapPanelFrame:CreateFontString(nil, "BACKGROUND")
    textMeasure:Hide()
  end
  applyFontStyle(textMeasure, obj)
  return textMeasure
end

---width and height of the text in its current style in unscaled map units
local function measureText(obj)
  --measure the text as the map shows it, with icon tags drawn as icons
  local isEdited = editing and editing.obj == obj
  local text = isEdited and textEditor:GetText() or obj.d[5] or ""
  local measure = getTextMeasure(obj)
  measure:SetText(MDT:RenderPresetTextTags(text, ICON_MARKUP_SIZE))
  local scale = MDT:GetScale()
  return measure:GetStringWidth() / scale, measure:GetStringHeight() / scale
end

---Runs change and moves the text so the point u, v of its box stays on the same spot of the map
---u is 0 on the left and 1 on the right edge, v is 0 on the top and 1 on the bottom edge of the upright text
local function keepPointInPlace(obj, u, v, change)
  local width, height = measureText(obj)
  local factor = ANCHOR_WIDTH_FACTOR[getAlign(obj)]
  change()
  local newWidth, newHeight = measureText(obj)
  local newFactor = ANCHOR_WIDTH_FACTOR[getAlign(obj)]
  --the stored point belongs to the upright text, only the way from the center to the kept point turns
  local dx, dy = rotatePoint((u - 0.5) * (width - newWidth), (0.5 - v) * (height - newHeight), getRotation(obj))
  obj.d[1] = obj.d[1] + ((0.5 - factor) * width - (0.5 - newFactor) * newWidth + dx)
  obj.d[2] = obj.d[2] + ((newHeight - height) / 2 + dy)
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
---keepSelected leaves the text selected afterwards, noRedraw leaves redrawing to the caller
function MDT:CommitPresetTextEdit(keepSelected, noRedraw)
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
        deleteTextObject(state.preset, objectIndex, noRedraw)
        --tells callers that finishing the edit deleted the text
        return true
      elseif text ~= state.obj.d[5] or state.styleChanged then
        local obj = state.obj
        --the editor shows the text upright, a rotated text grows from its aligned side along its own axes
        keepPointInPlace(obj, ANCHOR_WIDTH_FACTOR[getAlign(obj)], 0, function() obj.d[5] = text end)
        sendUpdatedObject(state.preset, objectIndex, obj)
      end
      resultObj = state.obj
    end
  end
  if keepSelected and resultObj then
    selectText(state.preset, resultObj)
  else
    selectText(nil, nil)
  end
  if not noRedraw then MDT:DrawAllPresetObjects() end
end

---Finishes editing and clears the selection, returns true if a text was selected or edited
---discardNew drops a text that was never stored instead of storing it
---also returns whether an unsaved new text was dropped and whether an emptied text was deleted
function MDT:ClearPresetTextSelection(discardNew)
  local hadSelection = editing ~= nil or selectedObj ~= nil
  local discardedNew = false
  if discardNew and editing and editing.isNew then
    closeEditor()
    discardedNew = true
  end
  local deletedText = MDT:CommitPresetTextEdit() == true
  --also hides the style bar left over from a dropped text
  selectText(nil, nil)
  return hadSelection, discardedNew, deletedText
end

---Drops selection and editing when their preset, sublevel or object are gone
function MDT:ValidatePresetTextSelection()
  --an undo can hide the text that is being edited
  if editing and (editing.preset ~= MDT:GetCurrentPreset() or editing.obj.d[3] ~= MDT:GetCurrentSubLevel()
        or (not editing.isNew and not editing.obj.d[4])) then
    MDT:CommitPresetTextEdit()
  end
  if selectedObj and (selectedPreset ~= MDT:GetCurrentPreset() or selectedObj.d[3] ~= MDT:GetCurrentSubLevel()
        or not selectedObj.d[4] or not findObjectIndex(selectedPreset, selectedObj)) then
    selectText(nil, nil)
  end
end

---Hides texts while the window is resized like other drawings, the map is redrawn once resizing ends
function MDT:HidePresetTexts()
  MDT:CommitPresetTextEdit(false, true)
  if selectedObj then selectText(nil, nil) end
  for _, frame in ipairs(activeTextFrames) do
    frame:Hide()
  end
end

function MDT:IsEditingPresetText()
  return editing ~= nil
end

---true while a placed text has not been stored yet
function MDT:IsEditingNewPresetText()
  return editing ~= nil and editing.isNew == true
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

---Applies a text object changed by another live session member onto the existing object,
---selection and editor refer to the object table and would otherwise lose it
---returns false if the objects are not both texts
function MDT:ApplyPresetTextUpdate(existing, incoming)
  if type(existing) ~= "table" or type(incoming) ~= "table" or not existing.tx or not incoming.tx then
    return false
  end
  for key in pairs(existing) do existing[key] = nil end
  for key, value in pairs(incoming) do existing[key] = value end
  if editing and editing.obj == existing then
    --keep what is being typed, take over position and style
    refreshEditorStyle()
  elseif selectedObj == existing then
    updateStyleBar()
  end
  return true
end

---Changes a style property of the selected or edited text
---sizePivot is the point on the top edge that stays in place when the size changes, 0 is left and 1 is right
local function setStyle(field, value, sizePivot)
  local preset, obj = getTarget()
  if not obj then return end
  local function change() obj.d[field] = value end
  if field == FIELD_ALIGN then
    if getAlign(obj) == value then return end
    --keep the text where it is, only the side it is anchored on changes
    keepPointInPlace(obj, 0, 0, change)
  elseif field == FIELD_SIZE then
    --resize around the top center of the text by default
    keepPointInPlace(obj, sizePivot or 0.5, 0, change)
  else
    change()
  end
  if editing then
    editing.styleChanged = true
    refreshEditorStyle()
    return
  end
  if not findObjectIndex(preset, obj) then
    selectText(nil, nil)
    return
  end
  queueUpdatedObject(preset, obj)
  updateStyleBar()
  --only the changed text needs to be laid out again
  local frame = getFrameForObject(obj)
  if frame then
    layoutTextFrame(frame, obj)
  else
    MDT:DrawAllPresetObjects()
  end
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

---the letter limit is for typing, color codes added by the style bar must not cut the text
local function setEditorText(text)
  textEditor:SetMaxLetters(0)
  textEditor:SetText(text)
  textEditor:SetMaxLetters(MAX_TEXT_LENGTH)
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
  editor:SetMaxLetters(MAX_TEXT_LENGTH)
  setEditorText(text)
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
    setEditorText(text)
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
    setEditorText(stripInlineColors(textEditor:GetText()))
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
  --a tag cut by the letter limit would show up as broken text
  local length = strlenutf8 and strlenutf8(editor:GetText()) or #editor:GetText()
  if length + #tag > MAX_TEXT_LENGTH then return end
  editor:Insert(tag)
end

---Style bar
local function showButtonTooltip(button)
  if not button.tooltipText then return end
  MDTTooltip:SetOwner(button, "ANCHOR_TOP")
  MDTTooltip:SetText(button.tooltipText, 1, 1, 1, 1, true)
  MDTTooltip:Show()
end

local function hideTooltip()
  MDTTooltip:Hide()
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
    if MDTTooltip:IsOwned(self) then showButtonTooltip(self) end
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
  letter:SetFontObject(MDT.UI.Fonts.Get("small", true))
  letter:SetPoint("CENTER", 0, 0)
  letter:SetText("A")
  return button
end

local function createTextButton(bar, text, tooltipText, onClick)
  local button = createBarButton(bar, tooltipText, onClick)
  local label = button:CreateFontString(nil, "OVERLAY")
  MDT.UI.Fonts.Apply(label, 14, "OUTLINE")
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
  local label = confirm:CreateFontString(nil, "OVERLAY")
  label:SetFontObject(MDT.UI.Fonts.Get("small"))
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

---the frame showing the selected or edited text
local function getTargetFrame()
  if editing then return textEditor end
  if selectedObj then return getFrameForObject(selectedObj) end
end

---the upright box of the selected or edited text and its rotation, the editor shows texts upright
local function getTargetBox()
  local target = getTargetFrame()
  if not target then return end
  if target == textEditor then return target, 0 end
  return target.display, target.textRotation
end

local function getNearestFontSize(size)
  local nearest = TEXT_SIZES[1]
  for _, s in ipairs(TEXT_SIZES) do
    if abs(math.log(s / size)) < abs(math.log(nearest / size)) then nearest = s end
  end
  return nearest
end

---Handles on the selected or edited text: resize on the bottom right corner, rotate above the top edge
local function stopHandleDrag(handle)
  handle:SetScript("OnUpdate", nil)
  handle.obj = nil
  handle.marker:SetVertexColor(unpack(SELECTION_COLOR))
end

local function hideHandle(handle)
  if not handle or not handle:IsShown() then return end
  stopHandleDrag(handle)
  handle:Hide()
end

local function updateResize(handle)
  --a redraw can take the mouse up away from the handle
  if not IsMouseButtonDown("LeftButton") then return stopHandleDrag(handle) end
  local _, obj = getTarget()
  if obj ~= handle.obj then return stopHandleDrag(handle) end
  local x, y = MDT:GetCursorPosition()
  --dragging right or down along the text grows it, the top left corner stays in place
  local right, up = rotatePoint(x - handle.startX, y - handle.startY, -handle.startRotation)
  local extent = max(handle.startExtent + right - up, 1)
  local size = getNearestFontSize(handle.startSize * extent / handle.startExtent)
  if size ~= getFontSize(obj) then setStyle(FIELD_SIZE, size, 0) end
end

local function updateRotate(handle)
  if not IsMouseButtonDown("LeftButton") then return stopHandleDrag(handle) end
  local preset, obj = getTarget()
  local frame = obj == handle.obj and not editing and getFrameForObject(obj)
  if not frame then return stopHandleDrag(handle) end
  local centerX, centerY = frame:GetCenter()
  if not centerX then return end
  local cursorX, cursorY = GetCursorPosition()
  local scale = frame:GetEffectiveScale()
  --the text is upright while the cursor is straight above its center
  local degrees = deg(atan2(centerX - cursorX / scale, cursorY / scale - centerY))
  local step = IsShiftKeyDown() and ROTATION_SNAP or 1
  degrees = floor(degrees / step + 0.5) * step % 360
  local rotation = degrees ~= 0 and degrees or nil
  if rotation == obj.d[FIELD_ROTATION] then return end
  obj.d[FIELD_ROTATION] = rotation
  queueUpdatedObject(preset, obj)
  layoutTextFrame(frame, obj)
end

---texture is drawn in the handle, a round knob without one, startDrag is optional
local function createHandle(texture, startDrag, updateDrag)
  local handle = CreateFrame("Frame", nil, MDT.main_frame.mapPanelFrame)
  handle:EnableMouse(true)
  handle.marker = handle:CreateTexture(nil, "OVERLAY")
  handle.marker:SetAllPoints()
  if texture then
    handle.marker:SetTexture(texture)
  else
    handle.marker:SetColorTexture(1, 1, 1, 1)
    local mask = handle:CreateMaskTexture()
    mask:SetAllPoints(handle.marker)
    mask:SetTexture("Interface\\CHARACTERFRAME\\TempPortraitAlphaMask", "CLAMPTOBLACKADDITIVE", "CLAMPTOBLACKADDITIVE")
    handle.marker:AddMaskTexture(mask)
  end
  handle.marker:SetVertexColor(unpack(SELECTION_COLOR))
  handle:SetScript("OnEnter", function(self) self.marker:SetVertexColor(1, 1, 1, 1) end)
  handle:SetScript("OnLeave", function(self)
    if not self.obj then self.marker:SetVertexColor(unpack(SELECTION_COLOR)) end
  end)
  handle:SetScript("OnMouseDown", function(self, button)
    local _, obj = getTarget()
    local box, rotation = getTargetBox()
    if button ~= "LeftButton" or not obj or not box then return end
    self.obj = obj
    if startDrag then startDrag(self, obj, box, rotation) end
    self:SetScript("OnUpdate", updateDrag)
  end)
  handle:SetScript("OnMouseUp", function(self, button)
    if button ~= "LeftButton" or not self.obj then return end
    stopHandleDrag(self)
    if self:IsMouseOver() then self.marker:SetVertexColor(1, 1, 1, 1) end
    restoreEditorFocus()
  end)
  handle:Hide()
  return handle
end

local function startResize(handle, obj, box, rotation)
  handle.startX, handle.startY = MDT:GetCursorPosition()
  handle.startSize = getFontSize(obj)
  handle.startExtent = box:GetWidth() + box:GetHeight()
  handle.startRotation = rotation
end

local resizeHandle, rotateHandle
local function getResizeHandle()
  if resizeHandle then return resizeHandle end
  resizeHandle = createHandle("Interface\\AddOns\\MythicDungeonTools\\Textures\\Resize", startResize, updateResize)
  return resizeHandle
end

local function getRotateHandle()
  if rotateHandle then return rotateHandle end
  rotateHandle = createHandle(nil, nil, updateRotate)
  rotateHandle.line = rotateHandle:CreateLine(nil, "OVERLAY")
  rotateHandle.line:SetColorTexture(unpack(SELECTION_COLOR))
  rotateHandle.line:SetThickness(1)
  rotateHandle.tooltipText = L["rotateTextHint"]
  rotateHandle:HookScript("OnEnter", function(self)
    if not self.obj then showButtonTooltip(self) end
  end)
  rotateHandle:HookScript("OnLeave", hideTooltip)
  rotateHandle:HookScript("OnMouseDown", hideTooltip)
  return rotateHandle
end

---places a handle at x, y from the center of the upright box, returns true if it moved
---hitSize is the size of its mouse area, the handle size if nil
local function placeHandle(handle, box, rotation, size, x, y, hitSize)
  --text frames are pooled and redrawn, follow the box that currently shows the text
  if handle:GetParent() ~= box then
    handle:SetParent(box)
    handle:SetFrameLevel(box:GetFrameLevel() + 2)
    handle.offsetX = nil
  end
  --zooms with the map like the selection border
  if handle:GetWidth() ~= size then
    handle:SetSize(size, size)
    local inset = (size - (hitSize or size)) / 2
    handle:SetHitRectInsets(inset, inset, inset, inset)
  end
  x, y = rotatePoint(x, y, rotation)
  handle:Show()
  --runs every frame, only move the handle when its position changed
  if x == handle.offsetX and y == handle.offsetY then return false end
  handle.offsetX, handle.offsetY = x, y
  handle:ClearAllPoints()
  handle:SetPoint("CENTER", box, "CENTER", x, y)
  return true
end

local function updateHandles()
  local box, rotation = getTargetBox()
  if not box or not isInteractiveTool(MDT:GetCurrentToolbarTool()) then
    hideHandle(resizeHandle)
    hideHandle(rotateHandle)
    return
  end
  local scale = MDT:GetScale()
  local right, top = box:GetWidth() / 2, box:GetHeight() / 2
  local resizeSize = RESIZE_HANDLE_SIZE * scale
  local resize = getResizeHandle()
  if placeHandle(resize, box, rotation, resizeSize, right - resizeSize / 2, resizeSize / 2 - top) then
    resize.marker:SetRotation(rotation)
  end
  if editing then
    hideHandle(rotateHandle)
    return
  end
  local knob = getRotateHandle()
  local knobSize = ROTATE_HANDLE_SIZE * scale
  local distance = ROTATE_HANDLE_DISTANCE * scale
  if placeHandle(knob, box, rotation, knobSize, 0, top + distance, ROTATE_HANDLE_HIT_SIZE * scale) then
    knob.line:SetStartPoint("CENTER", box, rotatePoint(0, top, rotation))
    knob.line:SetEndPoint("CENTER", box, rotatePoint(0, top + distance - knobSize / 2, rotation))
  end
end

local function positionStyleBar(bar)
  updateHandles()
  --the knob swings around the text while it is dragged, the bar would hop above and below it
  if rotateHandle and rotateHandle.obj then return end
  local target = getTargetFrame()
  if not target then return end
  local parent = MDT.main_frame
  local map = parent.scrollFrame
  local left, bottom, width, height = target:GetRect()
  local parentLeft, parentBottom = parent:GetRect()
  local mapLeft, mapBottom, mapWidth, mapHeight = map:GetRect()
  if not left or not parentLeft or not mapLeft then return end
  local scale = target:GetEffectiveScale() / parent:GetEffectiveScale()
  local mapScale = map:GetEffectiveScale() / parent:GetEffectiveScale()
  --the visible part of the map, the text can be scrolled out of it when zoomed in
  local minX, minY = mapLeft * mapScale - parentLeft, mapBottom * mapScale - parentBottom
  local maxX, maxY = minX + mapWidth * mapScale, minY + mapHeight * mapScale
  local targetTop = bottom + height
  --the bar must not cover the rotate handle, which can stick out above or below the text
  if rotateHandle and rotateHandle:IsShown() then
    local _, knobBottom, _, knobHeight = rotateHandle:GetRect()
    if knobBottom then
      bottom, targetTop = min(bottom, knobBottom), max(targetTop, knobBottom + knobHeight)
    end
  end
  local top = targetTop * scale - parentBottom
  local barWidth, barHeight = bar:GetSize()
  local x = (left + width / 2) * scale - parentLeft
  x = min(max(x, minX + barWidth / 2), maxX - barWidth / 2)
  local y = top + 6
  if y + barHeight > maxY then
    y = bottom * scale - parentBottom - 6 - barHeight
  end
  --stays at the edge of the map while the text is out of view
  y = min(max(y, minY), maxY - barHeight)
  --popups open away from the text
  local isBelowTarget = y < top
  --runs every frame, only move the bar when its position changed
  if x ~= bar.lastX or y ~= bar.lastY then
    bar.lastX, bar.lastY = x, y
    bar:ClearAllPoints()
    bar:SetPoint("BOTTOM", parent, "BOTTOMLEFT", x, y)
  end
  if bar.popupsBelow ~= isBelowTarget then anchorStylePopups(bar, isBelowTarget) end
end

function getStyleBar()
  if styleBar then return styleBar end
  --switching to another sidebar section hides the map, the bar must not stay on top of it
  MDT.main_frame.mapPanelFrame:HookScript("OnHide", function()
    MDT:ClearPresetTextSelection()
  end)
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
  bar.size.text = bar.size:CreateFontString(nil, "OVERLAY")
  bar.size.text:SetFontObject(MDT.UI.Fonts.Get("small"))
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
    hideHandle(resizeHandle)
    hideHandle(rotateHandle)
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
  local _, editorLevel = getTextFrameLevels()
  editor:SetFrameLevel(editorLevel)
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
    --ctrl+shift+wheel switches sublevels
    if IsControlKeyDown() and not IsShiftKeyDown() then
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
  --texts colored with the style bar can be longer than the letter limit
  setEditorText(obj.d[5] or "")
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
  MDT:CreateContextMenu(MDT.main_frame, {
    { text = L["Edit"], onSelect = function()
      if findObjectIndex(preset, obj) then openEditor(preset, obj) end
    end },
    { text = L["Duplicate"], onSelect = function()
      if not findObjectIndex(preset, obj) then return end
      duplicateText(preset, obj, obj.d[1] + DUPLICATE_OFFSET, obj.d[2] - DUPLICATE_OFFSET)
    end },
    { text = L["Delete"], onSelect = function()
      if not findObjectIndex(preset, obj) then return end
      selectText(preset, obj)
      confirmDelete()
    end },
  })
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
  frame:SetPoint("CENTER", MDT.main_frame.mapPanelTile1, "TOPLEFT", frame.anchorX + dx, frame.anchorY + dy)
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

---places a selection edge between two points given from the center of the upright text box
local function placeEdge(edge, display, rotation, x1, y1, x2, y2)
  edge:SetStartPoint("CENTER", display, rotatePoint(x1, y1, rotation))
  edge:SetEndPoint("CENTER", display, rotatePoint(x2, y2, rotation))
end

local function updateHover(display)
  local owner = getTextUnderCursor(display:GetParent())
  for _, frame in ipairs(activeTextFrames) do
    frame.highlight:SetShown(frame == owner)
  end
end

local function onTextMouseDown(frame, button)
  if button == "RightButton" then
    --right drag pans the map like everywhere else on it, a right click without moving opens the menu
    frame.rightDownX, frame.rightDownY = GetCursorPosition()
    forwardMouseClick("OnMouseDown", button)
    return
  end
  if button ~= "LeftButton" or not frame.obj then return end
  if MDT:GetCurrentToolbarTool() == "eraser" then
    local preset = MDT:GetCurrentPreset()
    local objectIndex = findObjectIndex(preset, frame.obj)
    if objectIndex then
      if selectedObj == frame.obj then selectText(nil, nil) end
      deleteTextObject(preset, objectIndex)
    end
    return
  end
  frame.dragStartX, frame.dragStartY = MDT:GetCursorPosition()
  frame.dragging = nil
  frame.duplicateOnDrag = IsAltKeyDown()
  frame:SetScript("OnUpdate", updateDrag)
end

local function onTextMouseUp(frame, button)
  --end a map pan that was started on this text
  if button == "RightButton" then MDT.main_frame.scrollFrame.panning = false end
  if not frame.obj then return end
  local obj = frame.obj
  local preset = MDT:GetCurrentPreset()
  if button == "LeftButton" then
    if MDT:GetCurrentToolbarTool() == "eraser" then return end
    --finish editing another text first
    if editing and editing.obj ~= obj then MDT:CommitPresetTextEdit() end
    if stopDrag(frame) then return end
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
    local x, y = GetCursorPosition()
    local moved = not frame.rightDownX or abs(x - frame.rightDownX) > DRAG_THRESHOLD
        or abs(y - frame.rightDownY) > DRAG_THRESHOLD
    frame.rightDownX, frame.rightDownY = nil, nil
    if moved or not findObjectIndex(preset, obj) then return end
    MDT:CommitPresetTextEdit()
    selectText(preset, obj)
    openContextMenu(preset, obj)
  end
end

---Texts are drawn above enemies but take mouse input below them:
---the frame itself is an invisible click area under the enemies, its display child draws everything above them
---rotated texts draw their display turned inside of the frame, which covers the whole turned text
function createTextFrame()
  local mapPanelFrame = MDT.main_frame.mapPanelFrame
  local frame = CreateFrame("Frame", nil, mapPanelFrame)
  --enemies start at frame level 4, keep the click area below them
  frame:SetFrameLevel(mapPanelFrame:GetFrameLevel())
  local display = CreateFrame("Frame", nil, frame)
  display:SetPoint("CENTER")
  --below the text editor and the toolbar, above enemies and pull outlines
  display:SetFrameLevel((getTextFrameLevels()))
  frame.display = display
  frame.background = display:CreateTexture(nil, "BACKGROUND")
  frame.background:SetAllPoints()
  frame.background:SetColorTexture(0, 0, 0, 0.6)
  frame.highlight = display:CreateTexture(nil, "BORDER")
  frame.highlight:SetAllPoints()
  frame.highlight:Hide()
  frame.selection = CreateFrame("Frame", nil, display)
  frame.selection:SetAllPoints()
  frame.selection.edges = {}
  for i = 1, 4 do
    local edge = frame.selection:CreateLine(nil, "OVERLAY")
    edge:SetColorTexture(unpack(SELECTION_COLOR))
    edge:SetThickness(1)
    frame.selection.edges[i] = edge
  end
  frame.selection:Hide()
  frame.fontString = display:CreateFontString(nil, "OVERLAY")
  frame.fontString:SetShadowOffset(1, -1)
  frame.fontString:SetShadowColor(0, 0, 0, 1)
  frame.iconTextures = {}

  --the frame can be larger than a rotated text, the highlight follows the text under the cursor
  frame:SetScript("OnEnter", function(self)
    local isEraser = MDT:GetCurrentToolbarTool() == "eraser"
    for _, other in ipairs(activeTextFrames) do
      if isEraser then
        other.highlight:SetColorTexture(1, 0.2, 0.2, 0.35)
      else
        other.highlight:SetColorTexture(1, 1, 1, 0.12)
      end
    end
    updateHover(self.display)
    self.display:SetScript("OnUpdate", updateHover)
  end)
  frame:SetScript("OnLeave", function(self)
    self.display:SetScript("OnUpdate", nil)
    for _, other in ipairs(activeTextFrames) do
      other.highlight:Hide()
    end
  end)
  frame:SetScript("OnMouseWheel", function(self, delta)
    local owner = getTextUnderCursor(self)
    if IsControlKeyDown() and not IsShiftKeyDown() and owner and owner.obj == selectedObj then
      stepFontSize(delta)
    else
      forwardMouseWheel(delta)
    end
  end)
  frame:SetScript("OnMouseDown", function(self, button)
    local owner = getTextUnderCursor(self)
    --shift+drag selects enemies with a box like everywhere else on the map
    if button == "LeftButton" and IsShiftKeyDown() and MDT:GetCurrentToolbarTool() == nil then owner = nil end
    --replaces a press whose mouse up got lost
    pressOwner[button] = owner or MAP
    if owner then
      onTextMouseDown(owner, button)
    else
      forwardMouseClick("OnMouseDown", button)
    end
  end)
  frame:SetScript("OnMouseUp", function(_, button)
    local owner = pressOwner[button]
    --presses that went to the map are finished by the global mouse up
    if not owner or owner == MAP then return end
    pressOwner[button] = nil
    onTextMouseUp(owner, button)
  end)
  return frame
end

---The game draws the inline icons of a rotated font string upright where they would be on the upright text,
---rotated texts leave blanks in their place and draw every icon turned at its turned position
local function placeIcons(frame, obj, text, icons, rotation, textWidth, textHeight)
  local iconTextures = frame.iconTextures
  for i = #icons + 1, #iconTextures do iconTextures[i]:Hide() end
  if #icons == 0 then return end
  local measure = getTextMeasure(obj)
  local function width(s)
    measure:SetText(s)
    return measure:GetStringWidth()
  end
  local function height(s)
    measure:SetText(s)
    return measure:GetStringHeight()
  end
  local factor = ANCHOR_WIDTH_FACTOR[getAlign(obj)]
  local searchFrom = 1
  for i, icon in ipairs(icons) do
    local blankStart, blankEnd = text:find(icons.blank, searchFrom, true)
    searchFrom = blankEnd + 1
    local lineStart = 1
    for newline in text:gmatch("()\n") do
      if newline > blankStart then break end
      lineStart = newline + 1
    end
    local lineEnd = (text:find("\n", blankEnd, true) or #text + 1) - 1
    local prefix = text:sub(lineStart, blankStart - 1)
    --position in the upright text, from its top left corner
    local prefixWidth = width(prefix)
    local size = width(prefix..icons.blank) - prefixWidth
    local x = factor * (textWidth - width(text:sub(lineStart, lineEnd))) + prefixWidth + size / 2
    local top = lineStart > 1 and height(text:sub(1, lineStart - 2)) or 0
    local y = (top + height(text:sub(1, lineEnd))) / 2
    local texture = iconTextures[i]
    if not texture then
      texture = frame.display:CreateTexture(nil, "OVERLAY")
      iconTextures[i] = texture
    end
    if icon.atlas then
      texture:SetAtlas(icon.atlas)
    else
      texture:SetTexture(icon.texture)
      texture:SetTexCoord(unpack(icon.coords))
    end
    texture:SetSize(size, size)
    texture:SetRotation(rotation)
    texture:ClearAllPoints()
    texture:SetPoint("CENTER", frame.display, "CENTER", rotatePoint(x - textWidth / 2, textHeight / 2 - y, rotation))
    texture:Show()
  end
end

---Applies text, style and position of an object to its frame
function layoutTextFrame(frame, obj)
  local padding = hasBackground(obj) and BACKGROUND_PADDING or FRAME_PADDING
  local scale = MDT:GetScale()
  local rotation = getRotation(obj)
  local fontString = frame.fontString
  applyFontStyle(fontString, obj)
  local icons = {}
  local text = MDT:RenderPresetTextTags(obj.d[5] or "", ICON_MARKUP_SIZE, rotation ~= 0 and icons or nil)
  fontString:SetText(text)
  fontString:SetRotation(rotation)
  local textWidth, textHeight = fontString:GetStringWidth(), fontString:GetStringHeight()
  local width, height = textWidth + padding * 2, textHeight + padding * 2
  frame.display:SetSize(width, height)
  --rotated font strings turn their letters around the top of their aligned side, not around their center
  local align = getAlign(obj)
  local pivotX, pivotY = rotatePoint((ANCHOR_WIDTH_FACTOR[align] - 0.5) * textWidth, textHeight / 2, rotation)
  fontString:ClearAllPoints()
  fontString:SetPoint(ANCHOR_POINTS[align], frame.display, "CENTER", pivotX, pivotY)
  placeIcons(frame, obj, text, icons, rotation, textWidth, textHeight)
  frame.background:SetRotation(rotation)
  frame.highlight:SetRotation(rotation)
  local right, top = width / 2, height / 2
  --edges lie inside the box like a border
  local innerRight, innerTop = right - 0.5, top - 0.5
  local edges = frame.selection.edges
  placeEdge(edges[1], frame.display, rotation, -right, innerTop, right, innerTop)
  placeEdge(edges[2], frame.display, rotation, -right, -innerTop, right, -innerTop)
  placeEdge(edges[3], frame.display, rotation, -innerRight, top, -innerRight, -top)
  placeEdge(edges[4], frame.display, rotation, innerRight, top, innerRight, -top)
  frame.textRotation = rotation
  --the click area covers the rotated box, the box turns around its center
  local c, s = abs(cos(rotation)), abs(sin(rotation))
  frame:SetSize(width * c + height * s, width * s + height * c)
  local centerX = obj.d[1] * scale + (0.5 - ANCHOR_WIDTH_FACTOR[getAlign(obj)]) * textWidth
  local centerY = obj.d[2] * scale - textHeight / 2
  frame:ClearAllPoints()
  frame:SetPoint("CENTER", MDT.main_frame.mapPanelTile1, "TOPLEFT", centerX, centerY)
  frame.anchorX, frame.anchorY = centerX, centerY
  frame.background:SetShown(hasBackground(obj))
  frame.selection:SetShown(obj == selectedObj)
end

---DrawText
function MDT:DrawText(obj, objectIndex)
  local frame = acquireTextFrame()
  frame.obj = obj
  frame.objectIndex = objectIndex
  layoutTextFrame(frame, obj)
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
