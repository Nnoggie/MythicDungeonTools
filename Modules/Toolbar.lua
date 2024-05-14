local MDT = MDT
local L = MDT.L
local sizex, sizey = 350, 33
local AceGUI = LibStub("AceGUI-3.0")
local db
local toolbarTools = {}
local drawingActive = false
local currentTool
local objectDrawLayer = "OVERLAY"

local twipe, tinsert, tremove, tgetn, CreateFrame, tonumber, pi, max, min, atan2, abs, pairs, ipairs, GetCursorPosition, GameTooltip = table
    .wipe, table.insert, table.remove, table.getn, CreateFrame, tonumber, math.pi, math.max, math.min, math.atan2,
    math.abs, pairs, ipairs, GetCursorPosition, GameTooltip

---sets up the toolbar frame and the widgets in it
function MDT:initToolbar(frame)
  db = MDT:GetDB()

  frame.toolbar = CreateFrame("Frame", "MDTToolbarFrame", frame)
  frame.toolbar:SetFrameStrata("HIGH")
  frame.toolbar:SetFrameLevel(5)
  frame.toolbar.tex = frame.toolbar:CreateTexture(nil, "OVERLAY", nil, 6)
  frame.toolbar.tex:SetAllPoints()
  frame.toolbar.tex:SetColorTexture(unpack(MDT.BackdropColor))
  frame.toolbar.toggleButton = CreateFrame("Button", nil, frame);
  frame.toolbar.toggleButton:SetFrameStrata("HIGH")
  frame.toolbar.toggleButton:SetFrameLevel(6)

  frame.toolbar.toggleButton:SetPoint("TOP", frame, "TOP")
  frame.toolbar.toggleButton:SetSize(32, 11)
  frame.toolbar.toggleButton:SetNormalTexture("Interface\\AddOns\\MythicDungeonTools\\Textures\\arrows")
  frame.toolbar.toggleButton:GetNormalTexture():SetTexCoord(0, 1, 0.7, 1)

  frame.toolbar:Hide()
  frame.toolbar:SetScript("OnHide", function()
    MDT:UpdateSelectedToolbarTool(nil)
  end)

  frame.toolbar.toggleButton:SetScript("OnClick", function()
    if frame.toolbar:IsShown() then
      frame.toolbar:Hide()
      frame.toolbar.toggleButton:ClearAllPoints()
      frame.toolbar.toggleButton:SetPoint("TOP", frame, "TOP")
      frame.toolbar.toggleButton:GetNormalTexture():SetTexCoord(0, 1, 0.7, 1)
      db.toolbarExpanded = false
    else
      frame.toolbar:Show()
      frame.toolbar.toggleButton:ClearAllPoints()
      frame.toolbar.toggleButton:SetPoint("TOP", frame.toolbar, "BOTTOM")
      frame.toolbar.toggleButton:GetNormalTexture():SetTexCoord(0, 1, 0.05, 0.35)
      db.toolbarExpanded = true
    end
  end)

  frame.toolbar.widgetGroup = AceGUI:Create("SimpleGroup")
  frame.toolbar.widgetGroup.frame:ClearAllPoints()
  frame.toolbar.widgetGroup.frame:SetAllPoints(frame.toolbar)
  if not frame.toolbar.widgetGroup.frame.SetBackdrop then
    Mixin(frame.toolbar.widgetGroup.frame, BackdropTemplateMixin)
  end
  frame.toolbar.widgetGroup.frame:SetBackdropColor(0, 0, 0, 0)
  --frame.toolbar.widgetGroup:SetWidth(350)
  --frame.toolbar.widgetGroup:SetHeight(15)
  --frame.toolbar.widgetGroup:SetPoint("TOP",frame.toolbar,"TOP",0,0)

  frame.toolbar.widgetGroup:SetLayout("Flow")
  frame.toolbar.widgetGroup.frame:SetFrameStrata("High")
  frame.toolbar.widgetGroup.frame:SetFrameLevel(7)

  MDT:FixAceGUIShowHide(frame.toolbar.widgetGroup, frame.toolbar)

  do
    --dirty hook to make widgetgroup show/hide
    local originalShow, originalHide = frame.Show, frame.Hide
    function frame:Show(...)
      if frame.toolbar:IsShown() then
        frame.toolbar.widgetGroup.frame:Show()
      end
      return originalShow(self, ...)
    end

    function frame:Hide(...)
      frame.toolbar.widgetGroup.frame:Hide()
      return originalHide(self, ...)
    end
  end

  ---TOOLBAR WIDGETS
  local widgetWidth = 24
  local widgets = {}
  MDT.tempWidgets = widgets

  ---back
  local back = AceGUI:Create("Icon")
  back:SetImage("Interface\\AddOns\\MythicDungeonTools\\Textures\\icons", 0.5, 0.75, 0.55, 0.8)
  back:SetCallback("OnClick", function(widget, callbackName)
    self:PresetObjectStepBack()
  end)
  back.tooltipText = L["Undo"]
  local t = back.frame:CreateTexture(nil, "ARTWORK", nil, 0)
  back.frame:SetHighlightTexture(t)
  tinsert(widgets, back)

  ---forward
  local forward = AceGUI:Create("Icon")
  forward:SetImage("Interface\\AddOns\\MythicDungeonTools\\Textures\\icons", 0.75, 1, 0.55, 0.8)
  forward:SetCallback("OnClick", function(widget, callbackName)
    self:PresetObjectStepForward()
  end)
  forward.tooltipText = L["Redo"]
  tinsert(widgets, forward)

  ---colorPicker
  local colorPicker = AceGUI:Create("ColorPicker")
  --colorPicker:SetHasAlpha(true)
  colorPicker:SetColor(db.toolbar.color.r, db.toolbar.color.g, db.toolbar.color.b, db.toolbar.color.a)
  colorPicker:SetCallback("OnValueChanged", function(widget, callbackName, r, g, b, a)
    db.toolbar.color.r, db.toolbar.color.g, db.toolbar.color.b, db.toolbar.color.a = r, g, b, a
    colorPicker:SetColor(r, g, b, a)
  end)
  colorPicker.tooltipText = L["Colorpicker"]
  tinsert(widgets, colorPicker)

  local sizeIndicator
  ---minus
  local minus = AceGUI:Create("Icon")
  minus:SetImage("Interface\\AddOns\\MythicDungeonTools\\Textures\\icons", 0, 0.25, 0.5, 0.75)
  minus:SetCallback("OnClick", function(widget, callbackName)
    db.toolbar.brushSize = db.toolbar.brushSize - 1
    if db.toolbar.brushSize < 1 then db.toolbar.brushSize = 1 end
    sizeIndicator:SetText(db.toolbar.brushSize)
  end)
  minus.tooltipText = L["Decrease Brush Size"]
  tinsert(widgets, minus)

  ---sizeIndicator
  sizeIndicator = AceGUI:Create("EditBox")
  sizeIndicator:DisableButton(true)
  sizeIndicator:SetMaxLetters(2)
  sizeIndicator.editbox:SetNumeric(true)
  sizeIndicator:SetText(db.toolbar.brushSize)
  local function updateBrushSize(size)
    db.toolbar.brushSize = size
  end

  sizeIndicator:SetCallback("OnEnterPressed", function(widget, callback, text)
    sizeIndicator:ClearFocus()
    local size = tonumber(text)
    updateBrushSize(size)
  end)
  sizeIndicator:SetCallback("OnTextChanged", function(widget, callback, text)
    local size = tonumber(text)
    updateBrushSize(size)
  end)
  --Enable mousewheel scrolling
  sizeIndicator.editbox:EnableMouseWheel(true)
  sizeIndicator.editbox:SetScript("OnMouseWheel", function(self, delta)
    local newSize = db.toolbar.brushSize + delta
    if newSize < 1 then newSize = 1 end
    if newSize > 99 then newSize = 99 end
    db.toolbar.brushSize = newSize
    sizeIndicator:SetText(db.toolbar.brushSize)
  end)
  sizeIndicator.tooltipText = L["Brush Size"]
  tinsert(widgets, sizeIndicator)

  ---plus
  local plus = AceGUI:Create("Icon")
  plus:SetImage("Interface\\AddOns\\MythicDungeonTools\\Textures\\icons", 0.25, 0.5, 0.5, 0.75)
  plus:SetCallback("OnClick", function(widget, callbackName)
    db.toolbar.brushSize = db.toolbar.brushSize + 1
    sizeIndicator:SetText(db.toolbar.brushSize)
  end)
  plus.tooltipText = L["Increase Brush Size"]
  tinsert(widgets, plus)

  ---pencil
  local pencil = AceGUI:Create("Icon")
  pencil:SetImage("Interface\\AddOns\\MythicDungeonTools\\Textures\\icons", 0, 0.25, 0, 0.25)
  toolbarTools["pencil"] = pencil
  pencil:SetCallback("OnClick", function(widget, callbackName)
    if currentTool == "pencil" then MDT:UpdateSelectedToolbarTool() else MDT:UpdateSelectedToolbarTool("pencil") end
  end)
  pencil.tooltipText = L["Drawing: Freehand"]
  tinsert(widgets, pencil)

  ---line
  local line = AceGUI:Create("Icon")
  line:SetImage("Interface\\AddOns\\MythicDungeonTools\\Textures\\icons", 0, 0.25, 0.75, 1)
  toolbarTools["line"] = line
  line:SetCallback("OnClick", function(widget, callbackName)
    if currentTool == "line" then MDT:UpdateSelectedToolbarTool() else MDT:UpdateSelectedToolbarTool("line") end
  end)
  line.tooltipText = L["Drawing: Line"]
  tinsert(widgets, line)

  ---arrow
  local arrow = AceGUI:Create("Icon")
  arrow:SetImage("Interface\\AddOns\\MythicDungeonTools\\Textures\\icons", 0.25, 0.5, 0, 0.25)
  toolbarTools["arrow"] = arrow
  arrow:SetCallback("OnClick", function(widget, callbackName)
    if currentTool == "arrow" then MDT:UpdateSelectedToolbarTool() else MDT:UpdateSelectedToolbarTool("arrow") end
  end)
  arrow.tooltipText = L["Drawing: Arrow"]
  tinsert(widgets, arrow)

  ---note
  local note = AceGUI:Create("Icon")
  note:SetImage("Interface\\AddOns\\MythicDungeonTools\\Textures\\icons", 0.75, 1, 0, 0.25)
  toolbarTools["note"] = note
  note:SetCallback("OnClick", function(widget, callbackName)
    if currentTool == "note" then MDT:UpdateSelectedToolbarTool() else MDT:UpdateSelectedToolbarTool("note") end
  end)
  note.tooltipText = L["Insert Note"]
  tinsert(widgets, note)

  ---mover
  local mover = AceGUI:Create("Icon")
  mover:SetImage("Interface\\AddOns\\MythicDungeonTools\\Textures\\icons", 0.5, 0.75, 0, 0.25)
  toolbarTools["mover"] = mover
  mover:SetCallback("OnClick", function(widget, callbackName)
    if currentTool == "mover" then MDT:UpdateSelectedToolbarTool() else MDT:UpdateSelectedToolbarTool("mover") end
  end)
  mover.tooltipText = L["Move Object"]
  tinsert(widgets, mover)

  ---cogwheel
  local cogwheel = AceGUI:Create("Icon")
  cogwheel:SetImage("Interface\\AddOns\\MythicDungeonTools\\Textures\\icons", 0, 0.25, 0.25, 0.5)
  cogwheel:SetCallback("OnClick", function(widget, callbackName)
    InterfaceOptionsFrame_OpenToCategory("MythicDungeonTools")
    InterfaceOptionsFrame_OpenToCategory("MythicDungeonTools")
    MDT:HideInterface()
  end)
  cogwheel.tooltipText = L["Settings"]
  --tinsert(widgets,cogwheel)

  ---eraser
  local eraser = AceGUI:Create("Icon")
  eraser:SetImage("Interface\\AddOns\\MythicDungeonTools\\Textures\\icons", 0.25, 0.5, 0.25, 0.5)
  toolbarTools["eraser"] = eraser
  eraser:SetCallback("OnClick", function(widget, callbackName)
    if currentTool == "eraser" then MDT:UpdateSelectedToolbarTool() else MDT:UpdateSelectedToolbarTool("eraser") end
  end)
  eraser.tooltipText = L["Drawing: Eraser"]
  tinsert(widgets, eraser)

  ---delete
  local delete = AceGUI:Create("Icon")
  delete:SetImage("Interface\\AddOns\\MythicDungeonTools\\Textures\\icons", 0.25, 0.5, 0.75, 1)
  delete:SetCallback("OnClick", function(widget, callbackName)
    local prompt = string.format(L["deleteAllDrawingsPrompt"], "\n", "\n", "\n")
    self:OpenConfirmationFrame(450, 150, L["Delete ALL drawings"], L["Delete"], prompt, function()
      self:DeletePresetObjects()
      if self.liveSessionActive then self:LiveSession_SendCommand("deletePresetObjects") end
    end)
  end)
  delete.tooltipText = L["Delete ALL drawings"]
  tinsert(widgets, delete)

  for k, widget in ipairs(widgets) do
    widget:SetWidth(widgetWidth)
    if widget.type == "EditBox" then widget:SetWidth(30) end
    if widget.SetImageSize then widget:SetImageSize(20, 20) end
    widget:SetCallback("OnEnter", function(widget, callbackName)
      MDT:ToggleToolbarTooltip(true, widget)
    end)
    widget:SetCallback("OnLeave", function()
      MDT:ToggleToolbarTooltip(false)
    end)
    frame.toolbar.widgetGroup:AddChild(widget)
  end

  frame.toolbar:SetSize(sizex, sizey)
  frame.toolbar:ClearAllPoints()
  frame.toolbar:SetPoint("TOP", frame, "TOP", 0, 0)

  MDT:CreateBrushPreview(frame)
  MDT:UpdateSelectedToolbarTool()
  frame.toolbar.widgetGroup.frame:Hide()
end

---TexturePool
local activeTextures = {}
local texturePool = {}
local notePoolCollection
local function getTexture()
  local size = tgetn(texturePool)
  if size == 0 then
    return MDT.main_frame.mapPanelFrame:CreateTexture(nil, "OVERLAY", nil, 0)
  else
    local tex = texturePool[size]
    tremove(texturePool, size)
    tex:SetRotation(0)
    tex:SetTexCoord(0, 1, 0, 1)
    tex:ClearAllPoints()
    tex.coords = nil
    tex.points = nil
    return tex
  end
end

local function releaseTexture(tex)
  tex:Hide()
  tinsert(texturePool, tex)
end

---ReleaseAllActiveTextures
function MDT:ReleaseAllActiveTextures()
  for k, tex in pairs(activeTextures) do
    releaseTexture(tex)
  end
  twipe(activeTextures)
  if notePoolCollection then notePoolCollection:ReleaseAll() end
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
end

---EnableBrushPreview
function MDT:EnableBrushPreview(tool)
  local frame = MDT.main_frame
  if tool == "mover" then return end
  frame.brushPreview:Show()
  frame.brushPreview:SetScript("OnUpdate", function(self, tick)
    if MouseIsOver(MDTScrollFrame) and not MouseIsOver(MDTToolbarFrame) then
      local x, y = GetCursorPosition()
      x = x / UIParent:GetScale()
      y = y / UIParent:GetScale()
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
  frame.brushPreview:SetScript("OnUpdate", nil)
end

---ToggleToolbarTooltip
function MDT:ToggleToolbarTooltip(show, widget, anchor)
  if not show then
    GameTooltip:Hide()
  else
    anchor = anchor or "ANCHOR_BOTTOM"
    local yOffset = -1
    if widget.type == "EditBox" then yOffset = yOffset - 1 end
    if widget.type == "ColorPicker" then yOffset = yOffset - 3 end
    GameTooltip:SetOwner(widget.frame, anchor, 0, yOffset)
    GameTooltip:SetText(widget.tooltipText, 1, 1, 1, 1)
    GameTooltip:Show()
  end
end

---UpdateSelectedToolbarTool
---Called when a tool is selected/deselected
function MDT:UpdateSelectedToolbarTool(widgetName)
  local toolbar = MDT.main_frame.toolbar
  if not widgetName or (not toolbarTools[widgetName]) then
    if toolbar.highlight then toolbar.highlight:Hide() end
    MDT:RestoreScrollframeScripts()
    MDT:DisableBrushPreview()
    if drawingActive then
      if currentTool == "pencil" then MDT:StopPencilDrawing() end
      if currentTool == "arrow" then MDT:StopArrowDrawing() end
      if currentTool == "line" then MDT:StopLineDrawing() end
      if currentTool == "mover" then MDT:StopMovingDrawing() end
      if currentTool == "eraser" then MDT:StopEraserDrawing() end
    end
    currentTool = nil
    toolbar:SetScript("OnUpdate", nil)
    return
  end
  local widget = toolbarTools[widgetName]
  currentTool = widgetName
  toolbar.highlight = toolbar.highlight or toolbar:CreateTexture(nil, "OVERLAY", nil, 7)
  toolbar.highlight:SetTexture("Interface\\AddOns\\MythicDungeonTools\\Textures\\icons")
  toolbar.highlight:SetTexCoord(0.5, 0.75, 0.25, 0.5)
  toolbar.highlight:SetSize(widget.frame:GetWidth(), widget.frame:GetWidth())
  toolbar.highlight:ClearAllPoints()
  toolbar.highlight:SetPoint("CENTER", widget.frame, "CENTER")
  MDT:OverrideScrollframeScripts()
  MDT:EnableBrushPreview(currentTool)
  toolbar.highlight:Show()
end

---OverrideScrollframeScripts
---Take control of the map scrollframe mouse event scripts
---Called when the user starts drawing on the map
function MDT:OverrideScrollframeScripts()
  local frame = MDT.main_frame
  frame.scrollFrame:SetScript("OnMouseDown", function(self, button)
    if button == "LeftButton" then
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
  --make notes draggable
  if notePoolCollection then
    if currentTool == "mover" then
      for note, _ in pairs(notePoolCollection.pools.QuestPinTemplatenil.activeObjects) do
        note:SetMovable(true)
        note:RegisterForDrag("LeftButton")
        local xOffset, yOffset

        note:SetScript("OnMouseDown", function()
          local currentPreset = MDT:GetCurrentPreset()
          local x, y = MDT:GetCursorPosition()
          local scale = MDT:GetScale()
          x = x * (1 / scale)
          y = y * (1 / scale)
          local nx = currentPreset.objects[note.objectIndex].d[1]
          local ny = currentPreset.objects[note.objectIndex].d[2]
          xOffset = x - nx
          yOffset = y - ny
        end)
        note:SetScript("OnDragStart", function()
          note:StartMoving()
        end)
        note:SetScript("OnDragStop", function()
          note:StopMovingOrSizing()
          local x, y = MDT:GetCursorPosition()
          local scale = MDT:GetScale()
          x = x * (1 / scale)
          y = y * (1 / scale)
          local currentPreset = MDT:GetCurrentPreset()
          currentPreset.objects[note.objectIndex].d[1] = x - xOffset
          currentPreset.objects[note.objectIndex].d[2] = y - yOffset
          if MDT.liveSessionActive then
            MDT:LiveSession_SendNoteCommand("move", note.objectIndex, x - xOffset, y -
              yOffset)
          end
          MDT:DrawAllPresetObjects()
        end)
      end
    else
      for note, _ in pairs(notePoolCollection.pools.QuestPinTemplatenil.activeObjects) do
        note:SetMovable(false)
        note:RegisterForDrag()
      end
    end
  end
end

---RestoreScrollframeScripts
---Restore original functionality to the map scrollframe: Clicking on enemies, rightclick context menu
---Called when the user is done drawing on the map
function MDT:RestoreScrollframeScripts()
  local frame = MDT.main_frame
  frame.scrollFrame:SetScript("OnMouseDown", MDT.OnMouseDown)
  frame.scrollFrame:SetScript("OnMouseUp", MDT.OnMouseUp)
  --make notes not draggable
  if notePoolCollection then
    for note, _ in pairs(notePoolCollection.pools.QuestPinTemplatenil.activeObjects) do
      note:SetMovable(false)
      note:RegisterForDrag()
    end
  end
end

---returns cursor position relative to the map frame
function MDT:GetCursorPosition()
  local frame = MDT.main_frame
  local scrollFrame = frame.scrollFrame
  local relativeFrame = UIParent --UIParent
  local mapPanelFrame = MDT.main_frame.mapPanelFrame
  local cursorX, cursorY = GetCursorPosition()
  local mapScale = mapPanelFrame:GetScale()
  local scrollH = scrollFrame:GetHorizontalScroll()
  local scrollV = scrollFrame:GetVerticalScroll()
  local frameX = (cursorX / relativeFrame:GetScale()) - scrollFrame:GetLeft()
  local frameY = scrollFrame:GetTop() - (cursorY / relativeFrame:GetScale())
  frameX = (frameX / mapScale) + scrollH
  frameY = (frameY / mapScale) + scrollV
  return frameX - 1, -frameY
end

---GetHighestFrameLevelAtCursor
function MDT:GetHighestFrameLevelAtCursor()
  local currentSublevel = -8
  for k, v in pairs(activeTextures) do
    if MouseIsOver(v) and v:IsShown() and (not v.isOwn) then
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
  drawingActive = true
  local frame = MDT.main_frame
  local startx, starty = MDT:GetCursorPosition()
  local line = getTexture()
  line:SetTexture("Interface\\AddOns\\MythicDungeonTools\\Textures\\Square_White")
  line:SetVertexColor(db.toolbar.color.r, db.toolbar.color.g, db.toolbar.color.b, db.toolbar.color.a)
  line:Show()
  local arrow = getTexture()
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
    if not MouseIsOver(MDTScrollFrame) then return end
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
  drawingActive = false
end

local startx, starty, endx, endy
---StartLineDrawing
function MDT:StartLineDrawing()
  drawingActive = true
  local frame = MDT.main_frame
  startx, starty = MDT:GetCursorPosition()
  local line = getTexture()
  line:SetTexture("Interface\\AddOns\\MythicDungeonTools\\Textures\\Square_White")
  line:SetVertexColor(db.toolbar.color.r, db.toolbar.color.g, db.toolbar.color.b, db.toolbar.color.a)
  line.isOwn = true
  tinsert(activeTextures, line)

  local circle1 = getTexture()
  tinsert(activeTextures, circle1)
  local circle2 = getTexture()
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
    if not MouseIsOver(MDTScrollFrame) then return end
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
  drawingActive = false
  MDT:DrawAllPresetObjects()
end

local oldx, oldy
---StartPencilDrawing
---Starts the pencil drawing script, fired on mouse down with pencil tool selected
function MDT:StartPencilDrawing()
  drawingActive = true
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
    if not MouseIsOver(MDTScrollFrame) then return end
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

  drawingActive = false
end

---StartMovingObject
local objectIndex
local originalX, originalY
function MDT:StartMovingObject()
  --we have to redraw all objects first, as the objectIndex needs to be set on every texture
  MDT:DrawAllPresetObjects()
  drawingActive = true
  local frame = MDT.main_frame
  objectIndex = MDT:GetHighestPresetObjectIndexAtCursor()
  local startx, starty = MDT:GetCursorPosition()
  originalX, originalY = MDT:GetCursorPosition()
  frame.toolbar:SetScript("OnUpdate", function(self, tick)
    if not MouseIsOver(MDTScrollFrame) then return end
    local x, y = MDT:GetCursorPosition()
    if x ~= startx or y ~= starty then
      for j, tex in pairs(activeTextures) do
        if tex.objectIndex == objectIndex then
          for i = 1, tex:GetNumPoints() do
            local point, relativeTo, relativePoint, xOffset, yOffset = tex:GetPoint(i)
            tex:SetPoint(point, relativeTo, relativePoint, xOffset + (x - startx), yOffset + (y - starty))
          end
        end
      end
      startx, starty = MDT:GetCursorPosition()
    end
  end)
end

---HideAllPresetObjects
---Hide textures during rescaling
function MDT:HideAllPresetObjects()
  --drawings
  for _, tex in pairs(activeTextures) do
    tex:Hide()
  end
  --notes
  if notePoolCollection then
    local notes = notePoolCollection.pools.QuestPinTemplatenil.activeObjects
    for note, _ in pairs(notes) do
      note:Hide()
    end
  end
end

---StopMovingDrawing
function MDT:StopMovingObject()
  local frame = MDT.main_frame
  frame.toolbar:SetScript("OnUpdate", nil)
  if objectIndex then
    local newX, newY = MDT:GetCursorPosition()
    MDT:UpdatePresetObjectOffsets(objectIndex, originalX - newX, originalY - newY)
    if self.liveSessionActive then self:LiveSession_SendObjectOffsets(objectIndex, originalX - newX, originalY - newY) end
  end
  objectIndex = nil
  drawingActive = false
end

---GetHighestPresetObjectIndexAtCursor
function MDT:GetHighestPresetObjectIndexAtCursor()
  local currentSublevel = -8
  local highestTexture
  for k, v in pairs(activeTextures) do
    if MouseIsOver(v) and v:IsShown() then
      local _, sublevel = v:GetDrawLayer()
      if sublevel >= currentSublevel then
        highestTexture = v
      end
      currentSublevel = max(currentSublevel, sublevel + 1)
    end
  end
  if highestTexture then
    return highestTexture.objectIndex
  end
end

---StartEraserDrawing
local changedObjects = {}
function MDT:StartEraserDrawing()
  MDT:DrawAllPresetObjects()
  drawingActive = true
  local frame = MDT.main_frame
  local startx, starty
  local scale = MDT:GetScale()
  twipe(changedObjects)
  frame.toolbar:SetScript("OnUpdate", function(self, tick)
    if not MouseIsOver(MDTScrollFrame) then return end
    local x, y = MDT:GetCursorPosition()
    if x ~= startx or y ~= starty then
      local highestObjectIdx = MDT:GetHighestPresetObjectIndexAtCursor()
      for j, tex in pairs(activeTextures) do
        if MouseIsOver(tex) and tex:IsShown() and tex.objectIndex == highestObjectIdx then --tex.coords means this is a line
          tex:Hide()
          if tex.coords then
            local x1, y1, x2, y2 = unpack(tex.coords)
            --hide circle textures of lines
            for k, v in pairs(activeTextures) do
              if v.points then
                if (v.points[1] == x1 and v.points[2] == y1) or (v.points[1] == x2 and v.points[2] == y2) then
                  v:Hide()
                end
              end
            end
            --delete saved lines
            local currentPreset = MDT:GetCurrentPreset()
            for objectIndex, obj in pairs(currentPreset.objects) do
              if objectIndex == highestObjectIdx then
                for coordIdx, coord in pairs(obj.l) do
                  if coord * scale == x1 and obj.l[coordIdx + 1] * scale == y1 and obj.l[coordIdx + 2] * scale == x2 and
                      obj.l[coordIdx + 3] * scale == y2 then
                    for i = 1, 4 do tremove(obj.l, coordIdx) end
                    changedObjects[objectIndex] = obj
                    break
                  end
                end
              end
            end
          end
          break
        end
      end
      startx, starty = x, y
    end
  end)
end

---StopEraserDrawing
function MDT:StopEraserDrawing()
  local frame = MDT.main_frame
  frame.toolbar:SetScript("OnUpdate", nil)
  if self.liveSessionActive then self:LiveSession_SendUpdatedObjects(changedObjects) end
  MDT:DrawAllPresetObjects()
  drawingActive = false
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

---DrawCircle
function MDT:DrawCircle(x, y, size, color, layer, layerSublevel, isOwn, objectIndex, tex, noinsert, extrax, extray)
  local circle = tex or getTexture()
  if not layer then layer = objectDrawLayer end
  circle:SetDrawLayer(layer, layerSublevel)
  circle:SetTexture("Interface\\AddOns\\MythicDungeonTools\\Textures\\Circle_White")
  circle:SetVertexColor(color.r, color.g, color.b, color.a)
  circle:SetWidth(1.1 * size)
  circle:SetHeight(1.1 * size)
  circle:ClearAllPoints()
  circle:SetPoint("CENTER", MDT.main_frame.mapPanelTile1, "TOPLEFT", x, y)
  circle:Show()
  circle.isOwn = isOwn
  circle.objectIndex = objectIndex
  circle.points = { x, y, extrax, extray }
  if not noinsert then
    tinsert(activeTextures, circle)
  end
end

---DrawLine
function MDT:DrawLine(x, y, a, b, size, color, smooth, layer, layerSublevel, lineFactor, isOwn, objectIndex)
  local line = getTexture()
  if not layer then layer = objectDrawLayer end
  line:SetTexture("Interface\\AddOns\\MythicDungeonTools\\Textures\\Square_White")
  line:SetVertexColor(color.r, color.g, color.b, color.a)
  DrawLine(line, MDT.main_frame.mapPanelTile1, x, y, a, b, size, lineFactor and lineFactor or 1.1, "TOPLEFT")
  line:SetDrawLayer(layer, layerSublevel)
  line:Show()
  line.isOwn = isOwn
  line.objectIndex = objectIndex
  line.coords = { x, y, a, b }
  tinsert(activeTextures, line)
  if smooth == true then
    MDT:DrawCircle(x, y, size, color, layer, layerSublevel, isOwn, objectIndex)
  end
end

---DrawTriangle
function MDT:DrawTriangle(x, y, rotation, size, color, layer, layerSublevel, isOwn, objectIndex)
  local triangle = getTexture()
  if not layer then layer = objectDrawLayer end
  triangle:SetTexture("Interface\\AddOns\\MythicDungeonTools\\Textures\\triangle")
  triangle:SetVertexColor(color.r, color.g, color.b, color.a)
  triangle:Show()
  triangle:SetWidth(size)
  triangle:SetHeight(size)
  triangle:SetRotation(rotation + pi)
  triangle:ClearAllPoints()
  triangle:SetPoint("CENTER", MDT.main_frame.mapPanelTile1, "TOPLEFT", x, y)
  triangle:SetDrawLayer(layer, layerSublevel)
  triangle.isOwn = isOwn
  triangle.objectIndex = objectIndex
  tinsert(activeTextures, triangle)
end

local noteEditbox

--store text in nobj
local function updateNoteObjText(text, note)
  local currentPreset = MDT:GetCurrentPreset()
  currentPreset.objects[note.objectIndex].d[5] = text
  if MDT.liveSessionActive then MDT:LiveSession_SendNoteCommand("text", note.objectIndex, text) end
end

local function deleteNoteObj(note)
  local currentPreset = MDT:GetCurrentPreset()
  tremove(currentPreset.objects, note.objectIndex)
  if MDT.liveSessionActive then MDT:LiveSession_SendNoteCommand("delete", note.objectIndex, "0") end
  MDT:DrawAllPresetObjects()
end

local function makeNoteEditbox()
  local editbox = AceGUI:Create("SimpleGroup")
  editbox:SetWidth(240)
  editbox:SetHeight(120)
  editbox.frame:SetFrameStrata("HIGH")
  editbox.frame:SetFrameLevel(50)
  if not editbox.frame.SetBackdrop then
    Mixin(editbox.frame, BackdropTemplateMixin)
  end
  editbox.frame:SetBackdropColor(unpack(MDT.BackdropColor))
  editbox:SetLayout("Flow")
  editbox.multiBox = AceGUI:Create("MultiLineEditBox")
  editbox.multiBox:SetLabel(L["Note Text:"])

  editbox.multiBox:SetCallback("OnEnterPressed", function(widget, callbackName, text)
    for note, _ in pairs(notePoolCollection.pools.QuestPinTemplatenil.activeObjects) do
      if note.noteIdx == editbox.noteIdx then
        note.tooltipText = text
        updateNoteObjText(text, note)
        break
      end
    end
    editbox.frame:Hide()
  end)

  editbox.multiBox:SetWidth(240)
  editbox.multiBox:SetHeight(120)
  editbox.multiBox.label:Hide()
  --[[ hiding the scrollbar messes up the whole editbox
    editbox.multiBox.scrollBar:Hide()
    editbox.multiBox.scrollBar:ClearAllPoints()
    editbox.multiBox.scrollBar:SetPoint("BOTTOM", editbox.multiBox.button, "TOP", 0, 16)
    editbox.multiBox.scrollBar.ScrollUpButton:SetPoint("BOTTOM", editbox.multiBox.scrollBar, "TOP",0,3)
    ]]
  editbox.frame:Hide()
  editbox:AddChild(editbox.multiBox)
  MDT:FixAceGUIShowHide(editbox, nil, nil, true)
  editbox.frame:SetScript("OnShow", function()
    hooksecurefunc(MDT, "MouseDownHook", function() editbox.frame:Hide() end)
    hooksecurefunc(MDT, "ZoomMap", function() editbox.frame:Hide() end)
  end)

  return editbox
end

local noteDropDown = CreateFrame("frame", "MDTNoteDropDown", nil, "UIDropDownMenuTemplate")
local currentNote
local noteMenu = {}
do
  tinsert(noteMenu, {
    text = L["Edit"],
    notCheckable = 1,
    func = function()
      currentNote:OpenEditBox()
    end
  })
  tinsert(noteMenu, {
    text = " ",
    notClickable = 1,
    notCheckable = 1,
    func = nil
  })
  tinsert(noteMenu, {
    text = L["Delete"],
    notCheckable = 1,
    func = function()
      deleteNoteObj(currentNote)
    end
  })
  tinsert(noteMenu, {
    text = " ",
    notClickable = 1,
    notCheckable = 1,
    func = nil
  })
  tinsert(noteMenu, {
    text = L["Close"],
    notCheckable = 1,
    func = function()
      noteDropDown:Hide()
    end
  })
end

local function POIButton_CalculateNumericTexCoords(index, color)
  if index then
    color = color or 0.5;
    local iconIndex = index - 1;
    local yOffset = color + floor(iconIndex / 8) * 0.125;
    local xOffset = mod(iconIndex, 8) * 0.125;
    return xOffset, xOffset + 0.125, yOffset, yOffset + 0.125;
  end
end

---DrawNote
function MDT:DrawNote(x, y, text, objectIndex)
  if not notePoolCollection then
    notePoolCollection = CreateFramePoolCollection()
    notePoolCollection:CreatePool("Button", MDT.main_frame.mapPanelFrame, "QuestPinTemplate")
  end
  local scale = MDT:GetScale()
  --setup
  local note = notePoolCollection:Acquire("QuestPinTemplate")
  -- FramePoolCollection_GetPoolKey is concatenating the sixth argument of CreatePool ("specialization").
  -- This naive approach is just using toString on any value, even nil, which results in "nil" as a string.
  -- Because of this our pool key is "QuestPinTemplatenil" instead of "QuestPinTemplate".
  note.noteIdx = notePoolCollection.pools.QuestPinTemplatenil.numActiveObjects
  note.objectIndex = objectIndex
  note:ClearAllPoints()
  note:SetPoint("CENTER", MDT.main_frame.mapPanelTile1, "TOPLEFT", x, y)
  note:SetSize(12 * scale, 12 * scale)
  local idx = note.noteIdx % 25
  if idx == 0 then idx = 1 end
  note.NormalTexture:SetSize(15 * scale, 15 * scale)
  note.NormalTexture:SetTexture("Interface/WorldMap/UI-QuestPoi-NumberIcons")
  note.NormalTexture:SetTexCoord(0.500, 0.625, 0.375, 0.5)
  note.HighlightTexture:SetSize(15 * scale, 15 * scale)
  note.HighlightTexture:SetTexture("Interface/WorldMap/UI-QuestPoi-NumberIcons")
  note.HighlightTexture:SetTexCoord(0.625, 0.750, 0.375, 0.5)
  note.Display.Icon:SetSize(16 * scale, 16 * scale)
  note.Display.Icon:SetTexture("Interface/WorldMap/UI-QuestPoi-NumberIcons")
  note.Display.Icon:SetTexCoord(POIButton_CalculateNumericTexCoords(idx, 0))
  note.Display.Icon:Show()
  note.PushedTexture:SetSize(15 * scale, 15 * scale)
  note.PushedTexture:SetTexture("Interface/WorldMap/UI-QuestPoi-NumberIcons")
  note.PushedTexture:SetTexCoord(0.375, 0.500, 0.375, 0.5)
  note.tooltipText = text or ""

  note:RegisterForClicks("AnyUp")
  --click
  function note:OpenEditBox()
    if not noteEditbox then noteEditbox = makeNoteEditbox() end
    if noteEditbox.frame:IsShown() and noteEditbox.noteIdx == note.noteIdx then
      noteEditbox.frame:Hide()
    else
      noteEditbox.noteIdx = note.noteIdx
      noteEditbox:ClearAllPoints()
      noteEditbox.frame:SetPoint("TOPLEFT", note, "TOPRIGHT")
      noteEditbox.frame:Show()
      noteEditbox.multiBox:SetText(note.tooltipText)
      noteEditbox.multiBox.button:Enable()
    end
  end

  note:SetScript("OnClick", function(self, button, down)
    if button == "LeftButton" then
      CloseDropDownMenus()
      self:OpenEditBox()
    elseif button == "RightButton" then
      currentNote = note
      EasyMenu(noteMenu, noteDropDown, "cursor", 0, -15, "MENU")
      if noteEditbox and noteEditbox.frame:IsShown() then
        noteEditbox.frame:Hide()
      end
    end
  end)
  note:SetScript("OnEnter", function()
    GameTooltip:SetOwner(UIParent, "ANCHOR_CURSOR")
    GameTooltip:AddLine(note.tooltipText, 1, 1, 1, 1)
    GameTooltip:Show()
  end)
  note:SetScript("OnLeave", function()
    GameTooltip:Hide()
  end)

  -- Interface\AddOns\Blizzard_MapCanvas\MapCanvas_DataProviderBase.lua calls this function when a pin is clicked
  -- to avoid lua error we create it here
  note.GetMap = function()
    return {
      ProcessGlobalPinMouseActionHandlers = function(...) end,
    }
  end

  note:Show()
end
