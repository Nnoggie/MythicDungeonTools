local _, MDT = ...
local L = MDT.L
local UI = MDT.UI
local ICON_ATLAS = "Interface\\AddOns\\MythicDungeonTools\\Textures\\icons"
local CONTROL_SIZE = 26
local ICON_SIZE = 20
local MIN_BRUSH, MAX_BRUSH = 1, 99
local db
local toolButtons = {}
local sizeBox
local activeTextures = MDT.presetObjectActiveTextures
local currentTool
local objectDrawLayer = "OVERLAY"

local tinsert, CreateFrame, tonumber, pi, max, atan2, abs, pairs, ipairs, GetCursorPosition, MDTTooltip =
    table.insert, CreateFrame, tonumber, math.pi, math.max, math.atan2, math.abs, pairs, ipairs, GetCursorPosition,
    MDTTooltip

---The drawing tools in toolbar order. `coords` cut the icon from the icon atlas; `texture` replaces the atlas.
---@type {id: string, coords: number[]?, texture: string?, tooltip: string|fun(tooltip: table)}[]
MDT.ToolbarTools = {
  { id = "pencil", coords = { 0, 0.25, 0, 0.25 }, tooltip = L["Drawing: Freehand"] },
  { id = "line", coords = { 0, 0.25, 0.75, 1 }, tooltip = L["Drawing: Line"] },
  { id = "arrow", coords = { 0.25, 0.5, 0, 0.25 }, tooltip = L["Drawing: Arrow"] },
  { id = "text", texture = "Interface\\AddOns\\MythicDungeonTools\\Textures\\text", tooltip = function(tooltip)
    tooltip:SetText(L["Insert Text"], 1, 1, 1)
    tooltip:AddLine(L["insertTextHint"], 1, 1, 1)
  end },
  { id = "note", coords = { 0.75, 1, 0, 0.25 }, tooltip = L["Insert Note"] },
  { id = "mover", coords = { 0.5, 0.75, 0, 0.25 }, tooltip = L["Move Object"] },
  { id = "eraser", coords = { 0.25, 0.5, 0.25, 0.5 }, tooltip = L["Drawing: Eraser"] },
}

---sets up the toolbar frame and the widgets in it
function MDT:initToolbar(frame)
  db = MDT:GetDB()

  frame.toolbar = CreateFrame("Frame", "MDTToolbarFrame", frame)
  frame.toolbar:SetFrameStrata("HIGH")
  -- above enemy blips, which start at level 5 and rise when stacked or hovered
  frame.toolbar:SetFrameLevel(20)
  frame.toolbar.tex = frame.toolbar:CreateTexture(nil, "BACKGROUND")
  frame.toolbar.tex:SetAllPoints()
  UI.Theme.Bind(frame.toolbar.tex, "bg.panel")
  frame.toolbar.toggleButton = CreateFrame("Button", nil, frame);
  frame.toolbar.toggleButton:SetFrameStrata("HIGH")
  frame.toolbar.toggleButton:SetFrameLevel(21)

  frame.toolbar.toggleButton:SetPoint("LEFT", frame, "LEFT")
  frame.toolbar.toggleButton:SetSize(11, 32)
  frame.toolbar.toggleButton:SetNormalTexture("Interface\\AddOns\\MythicDungeonTools\\Textures\\arrows")
  frame.toolbar.toggleButton:GetNormalTexture():SetTexCoord(0.7, 1, 0, 1)

  frame.toolbar:Hide()
  frame.toolbar:SetScript("OnHide", function()
    MDT:UpdateSelectedToolbarTool(nil)
  end)

  frame.toolbar.toggleButton:SetScript("OnClick", function()
    if frame.toolbar:IsShown() then
      frame.toolbar:Hide()
      frame.toolbar.toggleButton:ClearAllPoints()
      frame.toolbar.toggleButton:SetPoint("LEFT", frame, "LEFT")
      frame.toolbar.toggleButton:GetNormalTexture():SetTexCoord(0.7, 1, 0, 1)
      db.toolbarExpanded = false
    else
      frame.toolbar:Show()
      frame.toolbar.toggleButton:ClearAllPoints()
      frame.toolbar.toggleButton:SetPoint("LEFT", frame.toolbar, "RIGHT")
      frame.toolbar.toggleButton:GetNormalTexture():SetTexCoord(0, 0.3, 0, 1)
      db.toolbarExpanded = true
    end
  end)

  local function iconButton(parent, id, coords, tooltip, onClick, texture)
    return UI.Button(parent, {
      id = id, variant = "plain", icon = texture or ICON_ATLAS, iconCoords = coords, iconSize = ICON_SIZE,
      width = CONTROL_SIZE, height = CONTROL_SIZE, tooltip = tooltip, onClick = onClick,
    })
  end
  local function setBrushSize(size)
    db.toolbar.brushSize = math.max(MIN_BRUSH, math.min(MAX_BRUSH, size))
    sizeBox:SetValue(tostring(db.toolbar.brushSize))
  end

  local stack = UI.Stack(frame.toolbar, { gap = "sm", padding = "sm", align = "center" })
  stack:SetPoint("TOPLEFT", frame.toolbar, "TOPLEFT", 0, 0)
  stack:SetWidth(CONTROL_SIZE + UI.Theme.Space("sm") * 2)
  stack:Batch(function()
    iconButton(stack, "undo", { 0.5, 0.75, 0.5, 0.75 }, L["Undo"], function() MDT:PresetObjectStepBack() end)
    iconButton(stack, "redo", { 0.75, 1, 0.5, 0.75 }, L["Redo"], function() MDT:PresetObjectStepForward() end)
    local color = db.toolbar.color
    UI.ColorSwatch(stack, {
      id = "color", color = { color.r, color.g, color.b, color.a }, tooltip = L["Colorpicker"],
      onChange = function(r, g, b, a) color.r, color.g, color.b, color.a = r, g, b, a end,
    })
    iconButton(stack, "brushUp", { 0.25, 0.5, 0.5, 0.75 }, L["Increase Brush Size"], function() setBrushSize(db.toolbar.brushSize + 1) end)
    sizeBox = UI.EditBox(stack, {
      id = "brushSize", width = CONTROL_SIZE, tooltip = L["Brush Size"], numeric = true, maxLetters = 2, justify = "CENTER", selectAllOnFocus = true,
      value = tostring(db.toolbar.brushSize),
      onChange = function(text)
        local size = tonumber(text)
        if size and size >= MIN_BRUSH then db.toolbar.brushSize = size end
      end,
      onCommit = function(text) setBrushSize(tonumber(text) or db.toolbar.brushSize) end,
      onWheel = function(delta) setBrushSize(db.toolbar.brushSize + delta) end,
    })
    iconButton(stack, "brushDown", { 0, 0.25, 0.5, 0.75 }, L["Decrease Brush Size"], function() setBrushSize(db.toolbar.brushSize - 1) end)
    for _, tool in ipairs(MDT.ToolbarTools) do
      toolButtons[tool.id] = iconButton(stack, tool.id, tool.coords, tool.tooltip, function()
        MDT:UpdateSelectedToolbarTool(currentTool ~= tool.id and tool.id or nil)
      end, tool.texture)
    end
    iconButton(stack, "deleteAll", { 0.25, 0.5, 0.75, 1 }, L["Delete ALL drawings"], function()
      UI.Dialogs.Confirm({
        key = "deleteAllDrawings", title = L["Delete ALL drawings"], width = 400,
        text = string.format(L["deleteAllDrawingsPrompt"], "\n", "", ""),
        confirm = { text = L["Delete"], variant = "danger", onClick = function()
          self:DeletePresetObjects()
          if self.liveSessionActive then self:LiveSession_SendCommand("deletePresetObjects") end
        end },
      })
    end)
  end)
  frame.toolbar.controls = stack

  frame.toolbar:SetSize(stack:GetWidth(), stack:GetHeight())
  frame.toolbar:ClearAllPoints()
  frame.toolbar:SetPoint("LEFT", frame, "LEFT", 0, 0)

  MDT:CreateBrushPreview(frame)
  MDT:UpdateSelectedToolbarTool()
end

---CreateBrushPreview
function MDT:CreateBrushPreview(frame)
  frame.brushPreview = CreateFrame("Frame", "MythicDungeonToolsBrushPreview", UIParent)
  frame.brushPreview:SetFrameStrata("HIGH")
  frame.brushPreview:SetFrameLevel(4)
  frame.brushPreview:SetSize(1, 1)
  frame.brushPreview.tex = frame.brushPreview:CreateTexture(nil, "OVERLAY", nil, 0)
  frame.brushPreview.tex:SetTexture("Interface\\AddOns\\MythicDungeonTools\\Textures\\ring")
  frame.brushPreview.tex:SetAllPoints()
  frame.brushPreview.text = frame.brushPreview:CreateFontString(nil, "OVERLAY")
  --new texts start at the cursor
  frame.brushPreview.text:SetPoint("LEFT")
  frame.brushPreview.text:SetShadowOffset(1, -1)
  frame.brushPreview.text:SetShadowColor(0, 0, 0, 1)
  frame.brushPreview.text:SetAlpha(0.7)
  frame.brushPreview.text:Hide()
end

---Shows a sample of the text that would be placed at the cursor
local function updateTextPreview(preview)
  preview.tex:Hide()
  if not MDTScrollFrame:IsMouseOver() or MDTToolbarFrame:IsMouseOver() or MDT:IsEditingPresetText()
      or MDT:IsMouseOverPresetText() then
    preview.text:Hide()
    return
  end
  local x, y = GetCursorPosition()
  local scale = preview:GetEffectiveScale()
  --brush tools resize the preview frame, the text has to start exactly at the cursor
  preview:SetSize(1, 1)
  preview:ClearAllPoints()
  preview:SetPoint("CENTER", UIParent, "BOTTOMLEFT", x / scale, y / scale)
  local mapScale = MDT.main_frame.mapPanelFrame:GetEffectiveScale() / preview:GetEffectiveScale()
  local r, g, b, size = MDT:GetPresetTextDefaultStyle()
  local fontSize = max(1, size * MDT:GetScale() * mapScale)
  --runs every frame, only update the font when zooming changed its size
  if preview.textFontSize ~= fontSize then
    preview.textFontSize = fontSize
    UI.Fonts.Apply(preview.text, fontSize, "OUTLINE")
    preview.text:SetTextColor(r, g, b)
    preview.text:SetText("Aa")
  end
  preview.text:Show()
end

---EnableBrushPreview
function MDT:EnableBrushPreview(tool)
  local frame = MDT.main_frame
  --the mover has no preview, also clears the preview of the previous tool
  if tool == "mover" then
    MDT:DisableBrushPreview()
    return
  end
  frame.brushPreview:Show()
  frame.brushPreview.text:Hide()
  if tool == "text" then
    frame.brushPreview:SetScript("OnUpdate", updateTextPreview)
    return
  end
  frame.brushPreview:SetScript("OnUpdate", function(self, tick)
    if MDTScrollFrame:IsMouseOver() and not MDTToolbarFrame:IsMouseOver() then
      local x, y = GetCursorPosition()
      x = x / self:GetEffectiveScale()
      y = y / self:GetEffectiveScale()
      self:ClearAllPoints()
      self:SetPoint("CENTER", UIParent, "BOTTOMLEFT", x, y)
      if tool == "eraser" then
        frame.brushPreview.tex:SetVertexColor(1, 1, 1, 1)
      else
        frame.brushPreview.tex:SetVertexColor(db.toolbar.color.r, db.toolbar.color.g, db.toolbar.color.b,
          db.toolbar.color.a)
      end
      frame.brushPreview:SetSize(30, 30)
      frame.brushPreview.tex:ClearAllPoints()
      frame.brushPreview.tex:SetAllPoints()
      frame.brushPreview.tex:Show()
    else
      frame.brushPreview.tex:Hide()
    end
  end)
end

---DisableBrushPreview
function MDT:DisableBrushPreview()
  local frame = MDT.main_frame
  frame.brushPreview:Hide()
  frame.brushPreview.tex:Hide()
  frame.brushPreview.text:Hide()
  frame.brushPreview:SetScript("OnUpdate", nil)
end

---ToggleToolbarTooltip
function MDT:ToggleToolbarTooltip(show, widget, anchor)
  if not show then
    MDTTooltip:Hide()
  else
    MDTTooltip:SetOwner(widget.frame, anchor or "ANCHOR_BOTTOM", 0, -1)
    MDTTooltip:SetText(widget.tooltipText, 1, 1, 1, 1)
    MDTTooltip:Show()
  end
end

---UpdateSelectedToolbarTool
---Called when a tool is selected/deselected
---@param toolId string? nil deselects
function MDT:UpdateSelectedToolbarTool(toolId)
  MDT:ClearPresetTextSelection()
  if not toolButtons[toolId] then toolId = nil end
  for id, button in pairs(toolButtons) do button:SetSelected(id == toolId) end
  if not toolId then
    MDT:RestoreScrollframeScripts()
    MDT:DisableBrushPreview()
    if MDT.drawingActive then
      if currentTool == "pencil" then MDT:StopPencilDrawing() end
      if currentTool == "arrow" then MDT:StopArrowDrawing() end
      if currentTool == "line" then MDT:StopLineDrawing() end
      if currentTool == "mover" then MDT:StopMovingDrawing() end
      if currentTool == "eraser" then MDT:StopEraserDrawing() end
    end
    currentTool = nil
    MDT.main_frame.toolbar:SetScript("OnUpdate", nil)
    MDT:UpdatePresetTextInteractivity()
    MDT:UpdatePullLabelInteractivity()
    return
  end
  currentTool = toolId
  MDT:OverrideScrollframeScripts()
  MDT:EnableBrushPreview(currentTool)
  MDT:UpdatePresetTextInteractivity()
  MDT:UpdatePullLabelInteractivity()
end

---Returns the name of the selected toolbar tool, nil if no tool is selected
function MDT:GetCurrentToolbarTool()
  return currentTool
end

---OverrideScrollframeScripts
---Take control of the map scrollframe mouse event scripts
---Called when the user starts drawing on the map
local textSelectionCleared
function MDT:OverrideScrollframeScripts()
  local frame = MDT.main_frame
  frame.scrollFrame:SetScript("OnMouseDown", function(self, button)
    if button == "LeftButton" then
      --clicking the map while a text is selected or edited only deselects it
      textSelectionCleared = MDT:ClearPresetTextSelection()
      if currentTool == "pencil" then MDT:StartPencilDrawing() end
      if currentTool == "arrow" then MDT:StartArrowDrawing() end
      if currentTool == "line" then MDT:StartLineDrawing() end
      if currentTool == "mover" then MDT:StartMovingObject() end
      if currentTool == "eraser" then MDT:StartEraserDrawing() end
    end
    if button == "RightButton" then
      local scrollFrame = MDT.main_frame.scrollFrame
      if scrollFrame.zoomedIn then
        scrollFrame.panning = true;
        scrollFrame.cursorX, scrollFrame.cursorY = GetCursorPosition()
      end
      scrollFrame.oldX = scrollFrame.cursorX
      scrollFrame.oldY = scrollFrame.cursorY
    end
  end)
  frame.scrollFrame:SetScript("OnMouseUp", function(self, button)
    if button == "LeftButton" then
      if currentTool == "pencil" then MDT:StopPencilDrawing() end
      if currentTool == "arrow" then MDT:StopArrowDrawing() end
      if currentTool == "line" then MDT:StopLineDrawing() end
      if currentTool == "mover" then MDT:StopMovingObject() end
      if currentTool == "eraser" then MDT:StopEraserDrawing() end
      if currentTool == "note" then MDT:StartNoteDrawing() end
      if currentTool == "text" and not textSelectionCleared then MDT:OnTextToolMapClick() end
    end
    if button == "RightButton" then
      local scrollFrame = MDT.main_frame.scrollFrame
      if scrollFrame.panning then scrollFrame.panning = false end
      --only ping if we didnt pan
      if scrollFrame.oldX == scrollFrame.cursorX or scrollFrame.oldY == scrollFrame.cursorY then
        local x, y = MDT:GetCursorPosition()
        MDT:PingMap(x, y)
        local sublevel = MDT:GetCurrentSubLevel()
        if MDT.liveSessionActive then MDT:LiveSession_SendPing(x, y, sublevel) end
      end
    end
  end)
  MDT:SetPresetNotesMovable(currentTool == "mover")
end

---RestoreScrollframeScripts
---Restore original functionality to the map scrollframe: Clicking on enemies, rightclick context menu
---Called when the user is done drawing on the map
function MDT:RestoreScrollframeScripts()
  local frame = MDT.main_frame
  frame.scrollFrame:SetScript("OnMouseDown", MDT.OnMouseDown)
  frame.scrollFrame:SetScript("OnMouseUp", MDT.OnMouseUp)
  MDT:SetPresetNotesMovable(false)
end

---returns cursor position relative to the map frame
function MDT:GetCursorPosition()
  local frame = MDT.main_frame
  local scrollFrame = frame.scrollFrame
  local mapPanelFrame = MDT.main_frame.mapPanelFrame
  local cursorX, cursorY = GetCursorPosition()
  local frameScale = scrollFrame:GetEffectiveScale()
  local mapScale = mapPanelFrame:GetScale()
  local scrollH = scrollFrame:GetHorizontalScroll()
  local scrollV = scrollFrame:GetVerticalScroll()
  local frameX = (cursorX / frameScale) - scrollFrame:GetLeft()
  local frameY = scrollFrame:GetTop() - (cursorY / frameScale)
  frameX = (frameX / mapScale) + scrollH
  frameY = (frameY / mapScale) + scrollV
  return frameX - 1, -frameY
end

---GetHighestFrameLevelAtCursor
function MDT:GetHighestFrameLevelAtCursor()
  local currentSublevel = -8
  for k, v in pairs(activeTextures) do
    if v:IsMouseOver() and v:IsShown() and (not v.isOwn) then
      local _, sublevel = v:GetDrawLayer()
      currentSublevel = max(currentSublevel, sublevel + 1)
    end
  end
  if currentSublevel > 7 then currentSublevel = 7 end
  return currentSublevel
end

local nobj
---StartArrowDrawing
function MDT:StartArrowDrawing()
  MDT.drawingActive = true
  local frame = MDT.main_frame
  local startx, starty = MDT:GetCursorPosition()
  local line = MDT:AcquirePresetObjectTexture()
  line:SetTexture("Interface\\AddOns\\MythicDungeonTools\\Textures\\Square_White")
  line:SetVertexColor(db.toolbar.color.r, db.toolbar.color.g, db.toolbar.color.b, db.toolbar.color.a)
  line:Show()
  local arrow = MDT:AcquirePresetObjectTexture()
  arrow:SetTexture("Interface\\AddOns\\MythicDungeonTools\\Textures\\triangle")
  arrow:SetVertexColor(db.toolbar.color.r, db.toolbar.color.g, db.toolbar.color.b, db.toolbar.color.a)
  line.isOwn = true
  arrow.isOwn = true
  tinsert(activeTextures, line)
  tinsert(activeTextures, arrow)
  local drawLayer = -8

  ---new object for storage
  ---d: size,lineFactor,sublevel,shown,colorstring,drawLayer,[smooth]
  ---l: x1,y1,x2,y2,...
  ---t: triangleroation
  local arrowBrushSize = db.toolbar.brushSize + 8 --we want arrows to be thicker by default compared to lines
  nobj = {
    d = { arrowBrushSize, 1, MDT:GetCurrentSubLevel(), true,
      MDT:RGBToHex(db.toolbar.color.r, db.toolbar.color.g, db.toolbar.color.b) },
    l = {}
  }
  nobj.l = { MDT:Round(startx, 1), MDT:Round(starty, 1) }
  nobj.t = {}
  local scale = MDT:GetScale()
  frame.toolbar:SetScript("OnUpdate", function(self, tick)
    if not MDTScrollFrame:IsMouseOver() then return end
    local x, y = MDT:GetCursorPosition()
    local currentDrawLayer = MDT:GetHighestFrameLevelAtCursor()
    drawLayer = max(drawLayer, currentDrawLayer)
    if x ~= startx and y ~= starty then
      DrawLine(line, MDT.main_frame.mapPanelTile1, startx, starty, x, y, (arrowBrushSize * 0.3) * scale, 1, "TOPLEFT")
      nobj.l[3] = MDT:Round(x, 1)
      nobj.l[4] = MDT:Round(y, 1)
    end
    --position arrow head
    arrow:Show()
    arrow:SetWidth(1 * arrowBrushSize * scale)
    arrow:SetHeight(1 * arrowBrushSize * scale)
    --calculate rotation
    local rotation = atan2(starty - y, startx - x)
    arrow:SetRotation(rotation + pi)
    arrow:ClearAllPoints()
    arrow:SetPoint("CENTER", MDT.main_frame.mapPanelTile1, "TOPLEFT", x, y)
    arrow:SetDrawLayer(objectDrawLayer, drawLayer)
    line:SetDrawLayer(objectDrawLayer, drawLayer)

    nobj.d[6] = drawLayer
    nobj.t[1] = rotation
  end)
end

---StopArrowDrawing
function MDT:StopArrowDrawing()
  local frame = MDT.main_frame
  MDT:StorePresetObject(nobj)
  if self.liveSessionActive then self:LiveSession_SendObject(nobj) end
  frame.toolbar:SetScript("OnUpdate", nil)
  for k, v in pairs(activeTextures) do
    v.isOwn = nil
  end
  MDT.drawingActive = false
end

local startx, starty, endx, endy
---StartLineDrawing
function MDT:StartLineDrawing()
  MDT.drawingActive = true
  local frame = MDT.main_frame
  startx, starty = MDT:GetCursorPosition()
  local line = MDT:AcquirePresetObjectTexture()
  line:SetTexture("Interface\\AddOns\\MythicDungeonTools\\Textures\\Square_White")
  line:SetVertexColor(db.toolbar.color.r, db.toolbar.color.g, db.toolbar.color.b, db.toolbar.color.a)
  line.isOwn = true
  tinsert(activeTextures, line)

  local circle1 = MDT:AcquirePresetObjectTexture()
  tinsert(activeTextures, circle1)
  local circle2 = MDT:AcquirePresetObjectTexture()
  tinsert(activeTextures, circle2)

  local drawLayer = -8
  ---new object
  ---d: size,lineFactor,sublevel,shown,colorstring,drawLayer,[smooth]
  ---l: x1,y1,x2,y2,...
  nobj = {
    d = { db.toolbar.brushSize, 1.1, MDT:GetCurrentSubLevel(), true,
      MDT:RGBToHex(db.toolbar.color.r, db.toolbar.color.g, db.toolbar.color.b), nil, true },
    l = {}
  }
  nobj.l = {}

  local scale = MDT:GetScale()
  frame.toolbar:SetScript("OnUpdate", function(self, tick)
    if not MDTScrollFrame:IsMouseOver() then return end
    local currentDrawLayer = MDT:GetHighestFrameLevelAtCursor()
    drawLayer = max(drawLayer, currentDrawLayer)
    endx, endy = MDT:GetCursorPosition()
    if endx ~= startx and endy ~= starty then
      DrawLine(line, MDT.main_frame.mapPanelTile1, startx, starty, endx, endy, (db.toolbar.brushSize * 0.3) * 1.1 * scale
      , 1.00, "TOPLEFT")
      line:SetDrawLayer(objectDrawLayer, drawLayer)
      line:Show()
      MDT:DrawCircle(startx, starty, (db.toolbar.brushSize * 0.3) * scale, db.toolbar.color, objectDrawLayer, drawLayer,
        true, nil, circle1, true)
      MDT:DrawCircle(endx, endy, (db.toolbar.brushSize * 0.3) * scale, db.toolbar.color, objectDrawLayer, drawLayer, true
      , nil, circle2, true)
      nobj.d[6] = drawLayer
    end
  end)
end

---StopLineDrawing
function MDT:StopLineDrawing()
  local frame = MDT.main_frame
  frame.toolbar:SetScript("OnUpdate", nil)
  for k, v in pairs(activeTextures) do
    v.isOwn = nil
  end
  --split the line into multiple parts
  local d = math.sqrt((endx - startx) ^ 2 + (endy - starty) ^ 2)
  local numSegments = d * 2 / (math.max(db.toolbar.brushSize, 5))
  numSegments = math.max(numSegments, 1)
  local x, y = startx, starty
  for i = 1, numSegments do
    local t = i / numSegments
    local newx = startx + (endx - startx) * t
    local newy = starty + (endy - starty) * t
    nobj.l[4 * i - 3] = MDT:Round(x, 1)
    nobj.l[4 * i - 2] = MDT:Round(y, 1)
    nobj.l[4 * i - 1] = MDT:Round(newx, 1)
    nobj.l[4 * i] = MDT:Round(newy, 1)
    x, y = newx, newy
  end
  tinsert(nobj.l, MDT:Round(x, 1))
  tinsert(nobj.l, MDT:Round(y, 1))
  tinsert(nobj.l, MDT:Round(endx, 1))
  tinsert(nobj.l, MDT:Round(endy, 1))

  MDT:StorePresetObject(nobj)
  if self.liveSessionActive then self:LiveSession_SendObject(nobj) end
  MDT.drawingActive = false
  MDT:DrawAllPresetObjects()
end

local oldx, oldy
---StartPencilDrawing
---Starts the pencil drawing script, fired on mouse down with pencil tool selected
function MDT:StartPencilDrawing()
  MDT.drawingActive = true
  local frame = MDT.main_frame
  oldx = nil
  oldy = nil
  local layerSublevel = -8
  local thresholdDefault = 10

  ---new object
  ---d: size,lineFactor,sublevel,shown,colorstring,drawLayer,[smooth]
  ---l: x1,y1,x2,y2,...
  nobj = {
    d = { db.toolbar.brushSize, 1.1, MDT:GetCurrentSubLevel(), true,
      MDT:RGBToHex(db.toolbar.color.r, db.toolbar.color.g, db.toolbar.color.b), 0, true },
    l = {}
  }
  nobj.l = {}

  local lineIdx = 1
  local scale = MDT:GetScale()
  frame.toolbar:SetScript("OnUpdate", function(self, tick)
    if not MDTScrollFrame:IsMouseOver() then return end
    local currentDrawLayer = MDT:GetHighestFrameLevelAtCursor()
    layerSublevel = max(layerSublevel, currentDrawLayer)
    local x, y = MDT:GetCursorPosition()
    local mapScale = MDT.main_frame.mapPanelFrame:GetScale()
    local threshold = thresholdDefault * 1 / mapScale
    if not oldx or not oldy then
      oldx, oldy = x, y
      return
    end
    if (oldx and abs(x - oldx) > threshold) or (oldy and abs(y - oldy) > threshold) then
      MDT:DrawLine(oldx, oldy, x, y, (db.toolbar.brushSize * 0.3) * scale, db.toolbar.color, true, objectDrawLayer,
        layerSublevel, nil, true)
      nobj.d[6] = layerSublevel
      nobj.l[lineIdx] = MDT:Round(oldx, 1)
      nobj.l[lineIdx + 1] = MDT:Round(oldy, 1)
      nobj.l[lineIdx + 2] = MDT:Round(x, 1)
      nobj.l[lineIdx + 3] = MDT:Round(y, 1)
      lineIdx = lineIdx + 4
      oldx, oldy = x, y
    end
  end)
end

---StopPencilDrawing
---End the pencil drawing script, fired on mouse up with the pencil tool selected
function MDT:StopPencilDrawing()
  local frame = MDT.main_frame
  local x, y = MDT:GetCursorPosition()
  local layerSublevel = MDT:GetHighestFrameLevelAtCursor()
  local scale = MDT:GetScale()
  --finish line
  if x ~= oldx or y ~= oldy then
    MDT:DrawLine(oldx, oldy, x, y, (db.toolbar.brushSize * 0.3) * scale, db.toolbar.color, true, objectDrawLayer,
      layerSublevel)
    --store it
    local size = 0
    for k, v in ipairs(nobj.l) do
      size = size + 1
    end
    nobj.l[size + 1] = MDT:Round(oldx, 1)
    nobj.l[size + 2] = MDT:Round(oldy, 1)
    nobj.l[size + 3] = MDT:Round(x, 1)
    nobj.l[size + 4] = MDT:Round(y, 1)
  end
  frame.toolbar:SetScript("OnUpdate", nil)
  --clear own flags
  for k, v in pairs(activeTextures) do
    v.isOwn = nil
  end

  local lineCount = 0
  for _, _ in pairs(nobj.l) do
    lineCount = lineCount + 1
  end
  if lineCount > 0 then
    --draw end circle, dont need to store it as we draw it when we restore the line from db
    MDT:DrawCircle(x, y, db.toolbar.brushSize * 0.3 * scale, db.toolbar.color, objectDrawLayer, layerSublevel)
    MDT:StorePresetObject(nobj)
    --nobj will be scaled after StorePresetObject so no need to rescale again
    if self.liveSessionActive then self:LiveSession_SendObject(nobj) end
  end

  MDT.drawingActive = false
end

---StartNoteDrawing
function MDT:StartNoteDrawing()
  ---new object for storage
  ---x,y,sublevel,shown,text,n=true
  local x, y = MDT:GetCursorPosition()
  nobj = { d = { x, y, MDT:GetCurrentSubLevel(), true, "" } }
  nobj.n = true
  MDT:StorePresetObject(nobj)
  if self.liveSessionActive then self:LiveSession_SendObject(nobj) end
  MDT:DrawAllPresetObjects()

  if not IsShiftKeyDown() then
    MDT:UpdateSelectedToolbarTool()
  end
end
