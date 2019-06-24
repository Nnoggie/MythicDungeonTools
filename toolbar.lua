---
--- DateTime: 07.04.2018 15:26
---
local sizex,sizey = 350,33
local AceGUI = LibStub("AceGUI-3.0")
local db
local toolbarTools = {}
local drawingActive = false
local currentTool
local objectDrawLayer = "ARTWORK"

local twipe,tinsert,tremove,tgetn,CreateFrame,tonumber,pi,max,min,atan2,abs,pairs,ipairs,GetCursorPosition,GameTooltip = table.wipe,table.insert,table.remove,table.getn,CreateFrame,tonumber,math.pi,math.max,math.min,math.atan2,math.abs,pairs,ipairs,GetCursorPosition,GameTooltip
local MethodDungeonTools = MethodDungeonTools

---initToolbar
---sets up the toolbar frame and the widgets in it
function MethodDungeonTools:initToolbar(frame)
    db = MethodDungeonTools:GetDB()

    frame.toolbar = CreateFrame("Frame","MethodDungeonToolsToolbarFrame",frame)
    frame.toolbar:SetFrameStrata("HIGH")
    frame.toolbar:SetFrameLevel(5)
    frame.toolbar.tex = frame.toolbar:CreateTexture(nil,"HIGH",nil,6)
    frame.toolbar.tex:SetAllPoints()
    frame.toolbar.tex:SetColorTexture(unpack(MethodDungeonTools.BackdropColor))--unpack(MethodDungeonTools.BackdropColor)
    frame.toolbar.toggleButton = CreateFrame("Button", nil, frame);
    frame.toolbar.toggleButton:SetFrameStrata("HIGH")
    frame.toolbar.toggleButton:SetFrameLevel(6)

    frame.toolbar.toggleButton:SetPoint("TOP",frame,"TOP")
    frame.toolbar.toggleButton:SetSize(32,11)
    frame.toolbar.toggleButton:SetNormalTexture("Interface\\AddOns\\MethodDungeonTools\\Textures\\arrows")
    frame.toolbar.toggleButton:GetNormalTexture():SetTexCoord(0,1,0.65,1)

    frame.toolbar:Hide()
    frame.toolbar:SetScript("OnHide",function()
        MethodDungeonTools:UpdateSelectedToolbarTool(nil)
    end)

    frame.toolbar.toggleButton:SetScript("OnClick", function()
        if frame.toolbar:IsShown() then
            frame.toolbar:Hide()
            frame.toolbar.toggleButton:ClearAllPoints()
            frame.toolbar.toggleButton:SetPoint("TOP",frame,"TOP")
            frame.toolbar.toggleButton:GetNormalTexture():SetTexCoord(0,1,0.65,1)
        else
            frame.toolbar:Show()
            frame.toolbar.toggleButton:ClearAllPoints()
            frame.toolbar.toggleButton:SetPoint("TOP",frame.toolbar,"BOTTOM")
            frame.toolbar.toggleButton:GetNormalTexture():SetTexCoord(0,1,0,0.35)
        end
    end)

    frame.toolbar.widgetGroup = AceGUI:Create("SimpleGroup")
    frame.toolbar.widgetGroup.frame:SetAllPoints(frame.toolbar)
    frame.toolbar.widgetGroup.frame:SetBackdropColor(0,0,0,0)
    --frame.toolbar.widgetGroup:SetWidth(350)
    --frame.toolbar.widgetGroup:SetHeight(15)
    --frame.toolbar.widgetGroup:SetPoint("TOP",frame.toolbar,"TOP",0,0)



    frame.toolbar.widgetGroup:SetLayout("Flow")
    frame.toolbar.widgetGroup.frame:SetFrameStrata("High")
    frame.toolbar.widgetGroup.frame:SetFrameLevel(7)

    MethodDungeonTools:FixAceGUIShowHide(frame.toolbar.widgetGroup,frame.toolbar)

    do
        --dirty hook to make widgetgroup show/hide
        local originalShow,originalHide = frame.Show,frame.Hide
        function frame:Show(...)
            if frame.toolbar:IsShown() then
                frame.toolbar.widgetGroup.frame:Show()
            end
            return originalShow(self,...)
        end
        function frame:Hide(...)
            frame.toolbar.widgetGroup.frame:Hide()
            return originalHide(self, ...)
        end
    end

    ---TOOLBAR WIDGETS
    local widgetWidth = 24
    local widgets = {}
    MethodDungeonTools.tempWidgets = widgets

    ---back
    local back = AceGUI:Create("Icon")
    back:SetImage("Interface\\AddOns\\MethodDungeonTools\\Textures\\icons",0.5,0.75,0.5,0.75)
    back:SetCallback("OnClick",function (widget,callbackName)
        MethodDungeonTools:PresetObjectStepBack()
    end)
    back.tooltipText = "Undo"
    local t = back.frame:CreateTexture(nil,"ARTWORK")
    back.frame:SetHighlightTexture(t)
    tinsert(widgets,back)

    ---forward
    local forward = AceGUI:Create("Icon")
    forward:SetImage("Interface\\AddOns\\MethodDungeonTools\\Textures\\icons",0.75,1,0.5,0.75)
    forward:SetCallback("OnClick",function (widget,callbackName)
        MethodDungeonTools:PresetObjectStepForward()
    end)
    forward.tooltipText = "Redo"
    tinsert(widgets,forward)

    ---colorPicker
    local colorPicker = AceGUI:Create("ColorPicker")
    --colorPicker:SetHasAlpha(true)
    colorPicker:SetColor(db.toolbar.color.r, db.toolbar.color.g, db.toolbar.color.b, db.toolbar.color.a)
    colorPicker:SetCallback("OnValueConfirmed",function(widget,callbackName,r, g, b, a)
        db.toolbar.color.r, db.toolbar.color.g, db.toolbar.color.b, db.toolbar.color.a  = r, g, b, a
        colorPicker:SetColor(r, g, b, a)
    end)
    colorPicker.tooltipText = "Colorpicker"
    tinsert(widgets,colorPicker)

    local sizeIndicator
    ---minus
    local minus = AceGUI:Create("Icon")
    minus:SetImage("Interface\\AddOns\\MethodDungeonTools\\Textures\\icons",0,0.25,0.5,0.75)
    minus:SetCallback("OnClick",function (widget,callbackName)
        db.toolbar.brushSize = db.toolbar.brushSize - 1
        if db.toolbar.brushSize < 1 then db.toolbar.brushSize = 1 end
        sizeIndicator:SetText(db.toolbar.brushSize)
    end)
    minus.tooltipText = "Decrease Brush Size"
    tinsert(widgets,minus)

    ---sizeIndicator
    sizeIndicator = AceGUI:Create("EditBox")
    sizeIndicator:DisableButton(true)
    sizeIndicator:SetMaxLetters(2)
    sizeIndicator.editbox:SetNumeric(true)
    sizeIndicator:SetText(db.toolbar.brushSize)
    local function updateBrushSize(size)
        db.toolbar.brushSize = size
    end
    sizeIndicator:SetCallback("OnEnterPressed",function (widget,callback,text)
        sizeIndicator:ClearFocus()
        local size = tonumber(text)
        updateBrushSize(size)
    end)
    sizeIndicator:SetCallback("OnTextChanged",function (widget,callback,text)
        local size = tonumber(text)
        updateBrushSize(size)
    end)
    --Enable mousewheel scrolling
    sizeIndicator.editbox:EnableMouseWheel(true)
    sizeIndicator.editbox:SetScript("OnMouseWheel", function(self, delta)
        local newSize = db.toolbar.brushSize+delta
        if newSize<1 then newSize = 1 end
        if newSize>99 then newSize = 99 end
        db.toolbar.brushSize = newSize
        sizeIndicator:SetText(db.toolbar.brushSize)
    end)
    sizeIndicator.tooltipText = "Brush Size"
    tinsert(widgets,sizeIndicator)

    ---plus
    local plus = AceGUI:Create("Icon")
    plus:SetImage("Interface\\AddOns\\MethodDungeonTools\\Textures\\icons",0.25,0.5,0.5,0.75)
    plus:SetCallback("OnClick",function (widget,callbackName)
        db.toolbar.brushSize = db.toolbar.brushSize + 1
        sizeIndicator:SetText(db.toolbar.brushSize)
    end)
    plus.tooltipText = "Increase Brush Size"
    tinsert(widgets,plus)

    ---pencil
    local pencil = AceGUI:Create("Icon")
    pencil:SetImage("Interface\\AddOns\\MethodDungeonTools\\Textures\\icons",0,0.25,0,0.25)
    toolbarTools["pencil"] = pencil
    pencil:SetCallback("OnClick",function (widget,callbackName)
        if currentTool == "pencil" then MethodDungeonTools:UpdateSelectedToolbarTool() else MethodDungeonTools:UpdateSelectedToolbarTool("pencil") end
    end)
    pencil.tooltipText = "Drawing: Freehand"
    tinsert(widgets,pencil)

    ---line
    local line = AceGUI:Create("Icon")
    line:SetImage("Interface\\AddOns\\MethodDungeonTools\\Textures\\icons",0,0.25,0.75,1)
    toolbarTools["line"] = line
    line:SetCallback("OnClick",function (widget,callbackName)
        if currentTool == "line" then MethodDungeonTools:UpdateSelectedToolbarTool() else MethodDungeonTools:UpdateSelectedToolbarTool("line") end
    end)
    line.tooltipText = "Drawing: Line"
    tinsert(widgets,line)

    ---arrow
    local arrow = AceGUI:Create("Icon")
    arrow:SetImage("Interface\\AddOns\\MethodDungeonTools\\Textures\\icons",0.25,0.5,0,0.25)
    toolbarTools["arrow"] = arrow
    arrow:SetCallback("OnClick",function (widget,callbackName)
        if currentTool == "arrow" then MethodDungeonTools:UpdateSelectedToolbarTool() else MethodDungeonTools:UpdateSelectedToolbarTool("arrow") end
    end)
    arrow.tooltipText = "Drawing: Arrow"
    tinsert(widgets,arrow)

    ---note
    local note = AceGUI:Create("Icon")
    note:SetImage("Interface\\AddOns\\MethodDungeonTools\\Textures\\icons",0.75,1,0,0.25)
    toolbarTools["note"] = note
    note:SetCallback("OnClick",function (widget,callbackName)
        if currentTool == "note" then MethodDungeonTools:UpdateSelectedToolbarTool() else MethodDungeonTools:UpdateSelectedToolbarTool("note") end
    end)
    note.tooltipText = "Insert Note"
    tinsert(widgets,note)

    ---mover
    local mover = AceGUI:Create("Icon")
    mover:SetImage("Interface\\AddOns\\MethodDungeonTools\\Textures\\icons",0.5,0.75,0,0.25)
    toolbarTools["mover"] = mover
    mover:SetCallback("OnClick",function (widget,callbackName)
        if currentTool == "mover" then MethodDungeonTools:UpdateSelectedToolbarTool() else MethodDungeonTools:UpdateSelectedToolbarTool("mover") end
    end)
    mover.tooltipText = "Move Object"
    tinsert(widgets,mover)

    ---cogwheel
    local cogwheel = AceGUI:Create("Icon")
    cogwheel:SetImage("Interface\\AddOns\\MethodDungeonTools\\Textures\\icons",0,0.25,0.25,0.5)
    cogwheel:SetCallback("OnClick",function (widget,callbackName)
        InterfaceOptionsFrame_OpenToCategory("MethodDungeonTools")
        InterfaceOptionsFrame_OpenToCategory("MethodDungeonTools")
        MethodDungeonTools:HideInterface()
    end)
    cogwheel.tooltipText = "Settings"
    --tinsert(widgets,cogwheel)

    ---eraser
    local eraser = AceGUI:Create("Icon")
    eraser:SetImage("Interface\\AddOns\\MethodDungeonTools\\Textures\\icons",0.25,0.5,0.25,0.5)
    toolbarTools["eraser"] = eraser
    eraser:SetCallback("OnClick",function (widget,callbackName)
        if currentTool == "eraser" then MethodDungeonTools:UpdateSelectedToolbarTool() else MethodDungeonTools:UpdateSelectedToolbarTool("eraser") end
    end)
    eraser.tooltipText = "Drawing: Eraser"
    tinsert(widgets,eraser)

    ---delete
    local delete = AceGUI:Create("Icon")
    delete:SetImage("Interface\\AddOns\\MethodDungeonTools\\Textures\\icons",0.25,0.5,0.75,1)
    delete:SetCallback("OnClick",function (widget,callbackName)
        MethodDungeonTools:DeletePresetObjects()
    end)
    delete.tooltipText = "Clear all drawings"
    tinsert(widgets,delete)

    for k,widget in ipairs(widgets) do
        widget:SetWidth(widgetWidth)
        if widget.type == "EditBox" then widget:SetWidth(30) end
        if widget.SetImageSize then widget:SetImageSize(20,20) end
        widget:SetCallback("OnEnter",function(widget,callbackName)
            MethodDungeonTools:ToggleToolbarTooltip(true,widget)
        end)
        widget:SetCallback("OnLeave",function()
            MethodDungeonTools:ToggleToolbarTooltip(false)
        end)
        frame.toolbar.widgetGroup:AddChild(widget)

    end

    frame.toolbar:SetSize(sizex, sizey)
    frame.toolbar:ClearAllPoints()
    frame.toolbar:SetPoint("TOP", frame, "TOP", 0, 0)

    MethodDungeonTools:CreateBrushPreview(frame)
    MethodDungeonTools:UpdateSelectedToolbarTool()

end

---TexturePool
local activeTextures = {}
local texturePool = {}
local notePoolCollection
local function getTexture()
    local size = tgetn(texturePool)
    if size == 0 then
        return MethodDungeonTools.main_frame.mapPanelFrame:CreateTexture(nil, "OVERLAY")
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
    tinsert(texturePool,tex)
end

---ReleaseAllActiveTextures
function MethodDungeonTools:ReleaseAllActiveTextures()
    for k,tex in pairs(activeTextures) do
        releaseTexture(tex)
    end
    twipe(activeTextures)
    if notePoolCollection then notePoolCollection:ReleaseAll() end
end

---CreateBrushPreview
function MethodDungeonTools:CreateBrushPreview(frame)
    frame.brushPreview = CreateFrame("Frame","MethodDungeonToolsBrushPreview",UIParent)
    frame.brushPreview:SetFrameStrata("HIGH")
    frame.brushPreview:SetFrameLevel(4)
    frame.brushPreview:SetSize(1, 1)
    frame.brushPreview.tex = frame.brushPreview:CreateTexture(nil, "OVERLAY")
    frame.brushPreview.tex:SetTexture("Interface\\AddOns\\MethodDungeonTools\\Textures\\ring")
    frame.brushPreview.tex:SetAllPoints()
end

---EnableBrushPreview
function MethodDungeonTools:EnableBrushPreview(tool)
    local frame = MethodDungeonTools.main_frame
    if tool == "mover" then return end
    frame.brushPreview:Show()
    frame.brushPreview:SetScript("OnUpdate", function(self, tick)
        if MouseIsOver(MethodDungeonToolsScrollFrame) and not MouseIsOver(MethodDungeonToolsToolbarFrame) then
            local x,y = GetCursorPosition()
            x = x/UIParent:GetScale()
            y = y/UIParent:GetScale()
            self:ClearAllPoints()
            self:SetPoint("CENTER",UIParent,"BOTTOMLEFT",x,y)
            if tool == "eraser" then
                frame.brushPreview.tex:SetVertexColor(1,1,1,1)
            else
                frame.brushPreview.tex:SetVertexColor(db.toolbar.color.r,db.toolbar.color.g,db.toolbar.color.b,db.toolbar.color.a)
            end
            local mapScale = MethodDungeonTools.main_frame.mapPanelFrame:GetScale()
            frame.brushPreview:SetSize(max(2,0.475*db.toolbar.brushSize*mapScale), max(2,0.475*db.toolbar.brushSize*mapScale))
            frame.brushPreview.tex:SetAllPoints()
            frame.brushPreview.tex:Show()
        else
            frame.brushPreview.tex:Hide()
        end
    end)
end
---DisableBrushPreview
function MethodDungeonTools:DisableBrushPreview()
    local frame = MethodDungeonTools.main_frame
    frame.brushPreview:Hide()
    frame.brushPreview.tex:Hide()
    frame.brushPreview:SetScript("OnUpdate", nil)
end

---ToggleToolbarTooltip
function MethodDungeonTools:ToggleToolbarTooltip(show,widget)
    if not show then
        GameTooltip:Hide()
    else
        local yOffset = -1
        if widget.type == "EditBox" then yOffset = yOffset-1 end
        if widget.type == "ColorPicker" then yOffset = yOffset-3 end
        GameTooltip:SetOwner(widget.frame, "ANCHOR_BOTTOM",0,yOffset)
        GameTooltip:SetText(widget.tooltipText,1,1,1,1)
        GameTooltip:Show()
    end
end

---UpdateSelectedToolbarTool
---Called when a tool is selected/deselected
function MethodDungeonTools:UpdateSelectedToolbarTool(widgetName)
    local toolbar = MethodDungeonTools.main_frame.toolbar
    if not widgetName or (not toolbarTools[widgetName]) then
        if toolbar.highlight then toolbar.highlight:Hide() end
        MethodDungeonTools:RestoreScrollframeScripts()
        MethodDungeonTools:DisableBrushPreview()
        if drawingActive then
            if currentTool == "pencil" then MethodDungeonTools:StopPencilDrawing() end
            if currentTool == "arrow" then MethodDungeonTools:StopArrowDrawing() end
            if currentTool == "line" then MethodDungeonTools:StopLineDrawing() end
            if currentTool == "mover" then MethodDungeonTools:StopMovingDrawing() end
            if currentTool == "eraser" then MethodDungeonTools:StopEraserDrawing() end
        end
        currentTool = nil
        toolbar:SetScript("OnUpdate",nil)
        return
    end
    local widget = toolbarTools[widgetName]
    currentTool = widgetName
    toolbar.highlight = toolbar.highlight or toolbar:CreateTexture(nil,"HIGH",nil,7)
    toolbar.highlight:SetTexture("Interface\\AddOns\\MethodDungeonTools\\Textures\\icons")
    toolbar.highlight:SetTexCoord(0.5,0.75,0.25,0.5)
    toolbar.highlight:SetSize(widget.frame:GetWidth(),widget.frame:GetWidth())
    toolbar.highlight:ClearAllPoints()
    toolbar.highlight:SetPoint("CENTER",widget.frame,"CENTER")
    MethodDungeonTools:OverrideScrollframeScripts()
    MethodDungeonTools:EnableBrushPreview(currentTool)
    toolbar.highlight:Show()
end

---OverrideScrollframeScripts
---Take control of the map scrollframe mouse event scripts
---Called when the user starts drawing on the map
function MethodDungeonTools:OverrideScrollframeScripts()
    local frame = MethodDungeonTools.main_frame
    frame.scrollFrame:SetScript("OnMouseDown", function(self,button)
        if button == "LeftButton" then
            if currentTool == "pencil" then MethodDungeonTools:StartPencilDrawing() end
            if currentTool == "arrow" then MethodDungeonTools:StartArrowDrawing() end
            if currentTool == "line" then MethodDungeonTools:StartLineDrawing() end
            if currentTool == "mover" then MethodDungeonTools:StartMovingObject() end
            if currentTool == "eraser" then MethodDungeonTools:StartEraserDrawing() end
        end
        if button == "RightButton" then
            local scrollFrame = MethodDungeonTools.main_frame.scrollFrame
            if scrollFrame.zoomedIn then
                scrollFrame.panning = true;
                scrollFrame.cursorX,scrollFrame.cursorY = GetCursorPosition()
            end
        end
    end)
    frame.scrollFrame:SetScript("OnMouseUp", function(self,button)
        if button == "LeftButton" then
            if currentTool == "pencil" then MethodDungeonTools:StopPencilDrawing() end
            if currentTool == "arrow" then MethodDungeonTools:StopArrowDrawing() end
            if currentTool == "line" then MethodDungeonTools:StopLineDrawing() end
            if currentTool == "mover" then MethodDungeonTools:StopMovingObject() end
            if currentTool == "eraser" then MethodDungeonTools:StopEraserDrawing() end
            if currentTool == "note" then MethodDungeonTools:StartNoteDrawing() end
        end
        if button == "RightButton" then
            local scrollFrame = MethodDungeonTools.main_frame.scrollFrame
            if scrollFrame.panning then scrollFrame.panning = false end
        end
    end)
    --make notes draggable
    if notePoolCollection then
        if currentTool == "mover" then
            for note,_ in pairs(notePoolCollection.pools.QuestPinTemplate.activeObjects) do
                note:SetMovable(true)
                note:RegisterForDrag("LeftButton")
                local xOffset,yOffset

                note:SetScript("OnMouseDown",function()
                    local currentPreset = MethodDungeonTools:GetCurrentPreset()
                    local x,y = MethodDungeonTools:GetCursorPosition()
                    local nx = currentPreset.objects[note.objectIndex].d[1]
                    local ny = currentPreset.objects[note.objectIndex].d[2]
                    xOffset = x-nx
                    yOffset = y-ny
                end)
                note:SetScript("OnDragStart", function()
                    note:StartMoving()
                end)
                note:SetScript("OnDragStop", function()
                    note:StopMovingOrSizing()
                    local x,y = MethodDungeonTools:GetCursorPosition()
                    local currentPreset = MethodDungeonTools:GetCurrentPreset()
                    currentPreset.objects[note.objectIndex].d[1]=x-xOffset
                    currentPreset.objects[note.objectIndex].d[2]=y-yOffset
                    MethodDungeonTools:DrawAllPresetObjects()
                end)
            end
        else
            for note,_ in pairs(notePoolCollection.pools.QuestPinTemplate.activeObjects) do
                note:SetMovable(false)
                note:RegisterForDrag()
            end
        end
    end
end

---RestoreScrollframeScripts
---Restore original functionality to the map scrollframe: Clicking on enemies, rightclick context menu
---Called when the user is done drawing on the map
function MethodDungeonTools:RestoreScrollframeScripts()
    local frame = MethodDungeonTools.main_frame
    frame.scrollFrame:SetScript("OnMouseDown", MethodDungeonTools.OnMouseDown)
    frame.scrollFrame:SetScript("OnMouseUp", MethodDungeonTools.OnMouseUp)
    --make notes not draggable
    if notePoolCollection then
        for note,_ in pairs(notePoolCollection.pools.QuestPinTemplate.activeObjects) do
            note:SetMovable(false)
            note:RegisterForDrag()
        end
    end
end

---returns cursor position relative to the map frame
function MethodDungeonTools:GetCursorPosition()
    local frame = MethodDungeonTools.main_frame
    local scrollFrame = frame.scrollFrame
    local relativeFrame = UIParent      --UIParent
    local mapPanelFrame = MethodDungeonTools.main_frame.mapPanelFrame
    local cursorX, cursorY = GetCursorPosition()
    local mapScale = mapPanelFrame:GetScale()
    local scrollH = scrollFrame:GetHorizontalScroll()
    local scrollV = scrollFrame:GetVerticalScroll()
    local frameX = (cursorX / relativeFrame:GetScale()) - scrollFrame:GetLeft()
    local frameY = scrollFrame:GetTop() - (cursorY / relativeFrame:GetScale())
    frameX=(frameX/mapScale)+scrollH
    frameY=(frameY/mapScale)+scrollV
    return frameX-1,-frameY
end

---GetHighestFrameLevelAtCursor
function MethodDungeonTools:GetHighestFrameLevelAtCursor()
    local currentSublevel = -8
    for k,v in pairs(activeTextures) do
        if MouseIsOver(v) and v:IsShown() and (not v.isOwn) then
            local _, sublevel = v:GetDrawLayer()
            currentSublevel = max(currentSublevel,sublevel+1)
        end
    end
    if currentSublevel > 7 then currentSublevel = 7 end
    return currentSublevel
end

local nobj
---StartArrowDrawing
function MethodDungeonTools:StartArrowDrawing()
    drawingActive = true
    local frame = MethodDungeonTools.main_frame
    local startx,starty = MethodDungeonTools:GetCursorPosition()
    local line = getTexture()
    line:SetTexture("Interface\\AddOns\\MethodDungeonTools\\Textures\\Square_White")
    line:SetVertexColor(db.toolbar.color.r,db.toolbar.color.g,db.toolbar.color.b,db.toolbar.color.a)
    line:Show()
    local arrow = getTexture()
    arrow:SetTexture("Interface\\AddOns\\MethodDungeonTools\\Textures\\triangle")
    arrow:SetVertexColor(db.toolbar.color.r,db.toolbar.color.g,db.toolbar.color.b,db.toolbar.color.a)
    line.isOwn = true
    arrow.isOwn = true
    tinsert(activeTextures,line)
    tinsert(activeTextures,arrow)
    local drawLayer = -8

    ---new object for storage
    ---d: size,lineFactor,sublevel,shown,colorstring,drawLayer,[smooth]
    ---l: x1,y1,x2,y2,...
    ---t: triangleroation
    nobj = {d={db.toolbar.brushSize,1,MethodDungeonTools:GetCurrentSubLevel(),true,MethodDungeonTools:RGBToHex(db.toolbar.color.r,db.toolbar.color.g,db.toolbar.color.b)},l={}}
    nobj.l = {MethodDungeonTools:Round(startx,1),MethodDungeonTools:Round(starty,1)}
    nobj.t = {}

    frame.toolbar:SetScript("OnUpdate", function(self, tick)
        if not MouseIsOver(MethodDungeonToolsScrollFrame) then return end
        local x,y = MethodDungeonTools:GetCursorPosition()local currentDrawLayer = MethodDungeonTools:GetHighestFrameLevelAtCursor()
        drawLayer = max(drawLayer,currentDrawLayer)
        if x~= startx and y~=starty then
            DrawLine(line, MethodDungeonTools.main_frame.mapPanelTile1, startx, starty, x, y, (db.toolbar.brushSize*0.3), 1,"TOPLEFT")
            nobj.l[3] = MethodDungeonTools:Round(x,1)
            nobj.l[4] = MethodDungeonTools:Round(y,1)
        end
        --position arrow head
        arrow:Show()
        arrow:SetWidth(1*db.toolbar.brushSize)
        arrow:SetHeight(1*db.toolbar.brushSize)
        --calculate rotation
        local rotation = atan2(starty-y,startx-x)
        arrow:SetRotation(rotation+pi)
        arrow:ClearAllPoints()
        arrow:SetPoint("CENTER",MethodDungeonTools.main_frame.mapPanelTile1,"TOPLEFT",x,y)
        arrow:SetDrawLayer(objectDrawLayer, drawLayer)
        line:SetDrawLayer(objectDrawLayer, drawLayer)

        nobj.d[6] = drawLayer
        nobj.t[1] = rotation
    end)
end

---StopArrowDrawing
function MethodDungeonTools:StopArrowDrawing()
    local frame = MethodDungeonTools.main_frame
    --ViragDevTool_AddData(nobj)
    MethodDungeonTools:StorePresetObject(nobj)
    frame.toolbar:SetScript("OnUpdate",nil)
    for k,v in pairs(activeTextures) do
        v.isOwn = nil
    end
    drawingActive = false
end

local startx,starty,endx,endy
---StartLineDrawing
function MethodDungeonTools:StartLineDrawing()
    drawingActive = true
    local frame = MethodDungeonTools.main_frame
    startx,starty = MethodDungeonTools:GetCursorPosition()
    local line = getTexture()
    line:SetTexture("Interface\\AddOns\\MethodDungeonTools\\Textures\\Square_White")
    line:SetVertexColor(db.toolbar.color.r,db.toolbar.color.g,db.toolbar.color.b,db.toolbar.color.a)
    line.isOwn = true
    tinsert(activeTextures,line)

    local circle1 = getTexture()
    tinsert(activeTextures,circle1)
    local circle2 = getTexture()
    tinsert(activeTextures,circle2)

    local drawLayer = -8
    ---new object
    ---d: size,lineFactor,sublevel,shown,colorstring,drawLayer,[smooth]
    ---l: x1,y1,x2,y2,...
    nobj = {d={db.toolbar.brushSize,1.1,MethodDungeonTools:GetCurrentSubLevel(),true,MethodDungeonTools:RGBToHex(db.toolbar.color.r,db.toolbar.color.g,db.toolbar.color.b),nil,true},l={}}
    nobj.l = {}

    frame.toolbar:SetScript("OnUpdate", function(self, tick)
        if not MouseIsOver(MethodDungeonToolsScrollFrame) then return end
        local currentDrawLayer = MethodDungeonTools:GetHighestFrameLevelAtCursor()
        drawLayer = max(drawLayer,currentDrawLayer)
        endx,endy = MethodDungeonTools:GetCursorPosition()
        if endx~= startx and endy~=starty then
            DrawLine(line, MethodDungeonTools.main_frame.mapPanelTile1, startx, starty, endx, endy, (db.toolbar.brushSize*0.3)*1.1, 1.00,"TOPLEFT")
            line:SetDrawLayer(objectDrawLayer,drawLayer)
            line:Show()
            MethodDungeonTools:DrawCircle(startx,starty,(db.toolbar.brushSize*0.3),db.toolbar.color,objectDrawLayer,drawLayer,true,nil,circle1,true)
            MethodDungeonTools:DrawCircle(endx,endy,(db.toolbar.brushSize*0.3),db.toolbar.color,objectDrawLayer,drawLayer,true,nil,circle2,true)


            nobj.d[6] = drawLayer
        end
    end)
end

---StopLineDrawing
function MethodDungeonTools:StopLineDrawing()
    local frame = MethodDungeonTools.main_frame
    frame.toolbar:SetScript("OnUpdate",nil)
    for k,v in pairs(activeTextures) do
        v.isOwn = nil
    end
    --split the line into multiple parts
    local d = math.sqrt((endx-startx)^2+(endy-starty)^2)
    local numSegments = d*2/(math.max(db.toolbar.brushSize,5))
    numSegments = math.max(numSegments,1)
    local x,y = startx,starty
    for i=1,numSegments do
        local t =  i/numSegments
        local newx = startx+(endx-startx)*t
        local newy = starty+(endy-starty)*t
        nobj.l[4*i-3] = MethodDungeonTools:Round(x,1)
        nobj.l[4*i-2] = MethodDungeonTools:Round(y,1)
        nobj.l[4*i-1] = MethodDungeonTools:Round(newx,1)
        nobj.l[4*i] = MethodDungeonTools:Round(newy,1)
        x,y = newx,newy
    end
    tinsert(nobj.l,MethodDungeonTools:Round(x,1))
    tinsert(nobj.l,MethodDungeonTools:Round(y,1))
    tinsert(nobj.l,MethodDungeonTools:Round(endx,1))
    tinsert(nobj.l,MethodDungeonTools:Round(endy,1))

    MethodDungeonTools:StorePresetObject(nobj)
    drawingActive = false
    MethodDungeonTools:DrawAllPresetObjects()
end

local oldx,oldy
---StartPencilDrawing
---Starts the pencil drawing script, fired on mouse down with pencil tool selected
function MethodDungeonTools:StartPencilDrawing()
    drawingActive = true
    local frame = MethodDungeonTools.main_frame
    oldx = nil
    oldy = nil
    local layerSublevel = -8
    local thresholdDefault = 10

    ---new object
    ---d: size,lineFactor,sublevel,shown,colorstring,drawLayer,[smooth]
    ---l: x1,y1,x2,y2,...
    nobj = {d={db.toolbar.brushSize,1.1,MethodDungeonTools:GetCurrentSubLevel(),true,MethodDungeonTools:RGBToHex(db.toolbar.color.r,db.toolbar.color.g,db.toolbar.color.b),0,true},l={}}
    nobj.l = {}

    local lineIdx = 1
    frame.toolbar:SetScript("OnUpdate", function(self, tick)
        if not MouseIsOver(MethodDungeonToolsScrollFrame) then return end
        local currentDrawLayer = MethodDungeonTools:GetHighestFrameLevelAtCursor()
        layerSublevel = max(layerSublevel,currentDrawLayer)
        local x,y = MethodDungeonTools:GetCursorPosition()
        local scale = MethodDungeonTools.main_frame.mapPanelFrame:GetScale()
        local threshold = thresholdDefault * 1/scale
        if not oldx or not oldy then
            oldx,oldy = x,y
            return
        end
        if (oldx and abs(x-oldx)>threshold) or (oldy and abs(y-oldy)>threshold)  then
            MethodDungeonTools:DrawLine(oldx,oldy,x,y,(db.toolbar.brushSize*0.3),db.toolbar.color,true,objectDrawLayer,layerSublevel,nil,true)
            nobj.d[6] = layerSublevel
            nobj.l[lineIdx] = MethodDungeonTools:Round(oldx,1)
            nobj.l[lineIdx+1] = MethodDungeonTools:Round(oldy,1)
            nobj.l[lineIdx+2] = MethodDungeonTools:Round(x,1)
            nobj.l[lineIdx+3] = MethodDungeonTools:Round(y,1)
            lineIdx = lineIdx + 4
            oldx,oldy = x,y
        end
    end)
end

---StopPencilDrawing
---End the pencil drawing script, fired on mouse up with the pencil tool selected
function MethodDungeonTools:StopPencilDrawing()
    local frame = MethodDungeonTools.main_frame
    local x,y = MethodDungeonTools:GetCursorPosition()
    local layerSublevel = MethodDungeonTools:GetHighestFrameLevelAtCursor()
    --finish line
    if x~=oldx or y~=oldy then
        MethodDungeonTools:DrawLine(oldx,oldy,x,y,(db.toolbar.brushSize*0.3),db.toolbar.color,true,objectDrawLayer,layerSublevel)
        --store it
        local size = 0
        for k,v in ipairs(nobj.l) do
            size = size+1
        end
        nobj.l[size+1] = MethodDungeonTools:Round(oldx,1)
        nobj.l[size+2] = MethodDungeonTools:Round(oldy,1)
        nobj.l[size+3] = MethodDungeonTools:Round(x,1)
        nobj.l[size+4] = MethodDungeonTools:Round(y,1)
    end
    --draw end circle, dont need to store it as we draw it when we restore the line from db
    MethodDungeonTools:DrawCircle(x,y,db.toolbar.brushSize*0.3,db.toolbar.color,objectDrawLayer,layerSublevel)
    frame.toolbar:SetScript("OnUpdate",nil)
    --clear own flags
    for k,v in pairs(activeTextures) do
        v.isOwn = nil
    end
    MethodDungeonTools:StorePresetObject(nobj)
    drawingActive = false
end

---StartMovingObject
local objectIndex
local originalX,originalY
function MethodDungeonTools:StartMovingObject()
    --we have to redraw all objects first, as the objectIndex needs to be set on every texture
    MethodDungeonTools:DrawAllPresetObjects()
    drawingActive = true
    local frame = MethodDungeonTools.main_frame
    objectIndex = MethodDungeonTools:GetHighestPresetObjectIndexAtCursor()
    local startx,starty = MethodDungeonTools:GetCursorPosition()
    originalX,originalY = MethodDungeonTools:GetCursorPosition()
    frame.toolbar:SetScript("OnUpdate", function(self, tick)
        if not MouseIsOver(MethodDungeonToolsScrollFrame) then return end
        local x,y = MethodDungeonTools:GetCursorPosition()
        if x~=startx or y ~=starty then
            for j,tex in pairs(activeTextures) do
                if tex.objectIndex == objectIndex then
                    for i=1,tex:GetNumPoints() do
                        local point,relativeTo,relativePoint,xOffset,yOffset = tex:GetPoint(i)
                        tex:ClearAllPoints()
                        tex:SetPoint(point,relativeTo,relativePoint,xOffset+(x-startx),yOffset+(y-starty))
                    end
                end
            end
            startx,starty = MethodDungeonTools:GetCursorPosition()
        end
    end)
end

---StopMovingDrawing
function MethodDungeonTools:StopMovingObject()
    local frame = MethodDungeonTools.main_frame
    frame.toolbar:SetScript("OnUpdate",nil)
    if objectIndex then
        local newX,newY = MethodDungeonTools:GetCursorPosition()
        MethodDungeonTools:UpdatePresetObjectOffsets(objectIndex,originalX-newX,originalY-newY)
    end
    objectIndex = nil
    drawingActive = false
end

---GetHighestPresetObjectIndexAtCursor
function MethodDungeonTools:GetHighestPresetObjectIndexAtCursor()
    local currentSublevel = -8
    local highestTexture
    for k,v in pairs(activeTextures) do
        if MouseIsOver(v) and v:IsShown() then
            local _, sublevel = v:GetDrawLayer()
            if sublevel>=currentSublevel then
                highestTexture = v
            end
            currentSublevel = max(currentSublevel,sublevel+1)
        end
    end
    if highestTexture then
        return highestTexture.objectIndex
    end
end

---StartEraserDrawing
function MethodDungeonTools:StartEraserDrawing()
    MethodDungeonTools:DrawAllPresetObjects()
    drawingActive = true
    local frame = MethodDungeonTools.main_frame
    local startx,starty
    frame.toolbar:SetScript("OnUpdate", function(self, tick)
        if not MouseIsOver(MethodDungeonToolsScrollFrame) then return end
        local x,y = MethodDungeonTools:GetCursorPosition()
        if x~=startx or y ~=starty then
            local highestObjectIdx = MethodDungeonTools:GetHighestPresetObjectIndexAtCursor()
            for j,tex in pairs(activeTextures) do
                if MouseIsOver(tex) and tex:IsShown() and tex.objectIndex == highestObjectIdx  then --tex.coords means this is a line
                    tex:Hide()
                    if tex.coords then
                        local x1,y1,x2,y2 = unpack(tex.coords)
                        --hide circle textures of lines
                        for k,v in pairs(activeTextures) do
                            if v.points then
                                if (v.points[1] == x1 and v.points[2] == y1) or (v.points[1] == x2 and v.points[2] == y2) then
                                    v:Hide()
                                end
                            end
                        end
                        --delete saved lines
                        local currentPreset = MethodDungeonTools:GetCurrentPreset()
                        for objectIndex,obj in pairs(currentPreset.objects) do
                            if objectIndex == highestObjectIdx then
                                for coordIdx,coord in pairs(obj.l) do
                                    if coord == x1 and obj.l[coordIdx+1] == y1 and obj.l[coordIdx+2] == x2 and obj.l[coordIdx+3] == y2 then
                                        for i=1,4 do tremove(obj.l,coordIdx) end
                                        break
                                    end
                                end
                            end
                        end
                    end
                    break
                end
            end
            startx,starty = x,y
        end
    end)
end

---StopEraserDrawing
function MethodDungeonTools:StopEraserDrawing()
    local frame = MethodDungeonTools.main_frame
    frame.toolbar:SetScript("OnUpdate",nil)
    MethodDungeonTools:DrawAllPresetObjects()
    drawingActive = false
end
---StartNoteDrawing
function MethodDungeonTools:StartNoteDrawing()
    --check if we have less than 25 notes
    if notePoolCollection and notePoolCollection.pools.QuestPinTemplate.numActiveObjects>24 then
        MethodDungeonTools:UpdateSelectedToolbarTool()
        return
    end
    ---new object for storage
    ---x,y,sublevel,shown,text,n=true
    local x,y = MethodDungeonTools:GetCursorPosition()
    nobj = {d={x,y,MethodDungeonTools:GetCurrentSubLevel(),true,""}}
    nobj.n = true
    MethodDungeonTools:StorePresetObject(nobj)
    MethodDungeonTools:DrawAllPresetObjects()

    if not IsShiftKeyDown() then
        MethodDungeonTools:UpdateSelectedToolbarTool()
    end
end

---DrawCircle
function MethodDungeonTools:DrawCircle(x,y,size,color,layer,layerSublevel,isOwn,objectIndex,tex,noinsert,extrax,extray)
    local circle = tex or getTexture()
    if not layer then layer = objectDrawLayer end
    circle:SetDrawLayer(layer, layerSublevel)
    circle:SetTexture("Interface\\AddOns\\MethodDungeonTools\\Textures\\Circle_White")
    circle:SetVertexColor(color.r,color.g,color.b,color.a)
    circle:SetWidth(1.1*size)
    circle:SetHeight(1.1*size)
    circle:ClearAllPoints()
    circle:SetPoint("CENTER",MethodDungeonTools.main_frame.mapPanelTile1,"TOPLEFT",x,y)
    circle:Show()
    circle.isOwn = isOwn
    circle.objectIndex = objectIndex
    circle.points = {x,y,extrax,extray}
    if not noinsert then
        tinsert(activeTextures,circle)
    end
end

---DrawLine
function MethodDungeonTools:DrawLine(x,y,a,b,size,color,smooth,layer,layerSublevel,lineFactor,isOwn,objectIndex)
    local line = getTexture()
    if not layer then layer = objectDrawLayer end
    line:SetTexture("Interface\\AddOns\\MethodDungeonTools\\Textures\\Square_White")
    line:SetVertexColor(color.r,color.g,color.b,color.a)
    DrawLine(line, MethodDungeonTools.main_frame.mapPanelTile1, x, y, a, b, size, lineFactor and lineFactor or 1.1,"TOPLEFT")
    line:SetDrawLayer(layer, layerSublevel)
    line:Show()
    line.isOwn = isOwn
    line.objectIndex = objectIndex
    line.coords = {x,y,a,b}
    tinsert(activeTextures,line)
    if smooth == true  then
        MethodDungeonTools:DrawCircle(x,y,size,color,layer,layerSublevel,isOwn,objectIndex)
    end
end

---DrawTriangle
function MethodDungeonTools:DrawTriangle(x,y,rotation,size,color,layer,layerSublevel,isOwn,objectIndex)
    local triangle = getTexture()
    if not layer then layer = objectDrawLayer end
    triangle:SetTexture("Interface\\AddOns\\MethodDungeonTools\\Textures\\triangle")
    triangle:SetVertexColor(color.r,color.g,color.b,color.a)
    triangle:Show()
    triangle:SetWidth(size)
    triangle:SetHeight(size)
    triangle:SetRotation(rotation+pi)
    triangle:ClearAllPoints()
    triangle:SetPoint("CENTER",MethodDungeonTools.main_frame.mapPanelTile1,"TOPLEFT",x,y)
    triangle:SetDrawLayer(layer, layerSublevel)
    triangle.isOwn = isOwn
    triangle.objectIndex = objectIndex
    tinsert(activeTextures,triangle)
end

local noteEditbox

--store text in nobj
local function updateNoteObjText(text,note)
    local currentPreset = MethodDungeonTools:GetCurrentPreset()
    currentPreset.objects[note.objectIndex].d[5]=text
end
local function deleteNoteObj(note)
    local currentPreset = MethodDungeonTools:GetCurrentPreset()
    tremove(currentPreset.objects,note.objectIndex)
    MethodDungeonTools:DrawAllPresetObjects()
end

local function makeNoteEditbox()
    local editbox = AceGUI:Create("SimpleGroup")
    editbox:SetWidth(240)
    editbox:SetHeight(120)
    editbox.frame:SetFrameStrata("HIGH")
    editbox.frame:SetFrameLevel(50)
    editbox.frame:SetBackdropColor(1,1,1,0)
    editbox:SetLayout("Flow")
    editbox.multiBox = AceGUI:Create("MultiLineEditBox")
    editbox.multiBox:SetLabel("Note Text:")
    editbox.multiBox:SetCallback("OnEnterPressed",function(widget,callbackName,text)
        for note,_ in pairs(notePoolCollection.pools.QuestPinTemplate.activeObjects) do
            if note.noteIdx == editbox.noteIdx then
                note.tooltipText = text
                updateNoteObjText(text,note)
                break
            end
        end

        editbox.frame:Hide()
    end)
    editbox.multiBox:SetWidth(240)
    editbox.multiBox:SetHeight(120)
    editbox.multiBox.label:Hide()
    editbox.multiBox.scrollBar:Hide()
    editbox.multiBox.scrollBar:ClearAllPoints()
    editbox.multiBox.scrollBar:SetPoint("BOTTOM", editbox.multiBox.button, "TOP", 0, 16)
    editbox.multiBox.scrollBar.ScrollUpButton:SetPoint("BOTTOM", editbox.multiBox.scrollBar, "TOP",0,3)
    editbox.frame:Hide()
    editbox:AddChild(editbox.multiBox)
    MethodDungeonTools:FixAceGUIShowHide(editbox,nil,nil,true)
    editbox.frame:SetScript("OnShow",function()
        hooksecurefunc(MethodDungeonTools, "OnPan", function() editbox.frame:Hide() end)
        hooksecurefunc(MethodDungeonTools, "ZoomMap", function() editbox.frame:Hide() end)
    end)

    return editbox
end

local noteDropDown = L_Create_UIDropDownMenu("noteDropDown", nil)
local currentNote
local noteMenu = {}
do
    tinsert(noteMenu, {
        text = "Edit",
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
        text = "Delete",
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
        text = "Close",
        notCheckable = 1,
        func = function()
            noteDropDown:Hide()
        end
    })
end

---DrawNote
function MethodDungeonTools:DrawNote(x,y,text,objectIndex)
    if not notePoolCollection then
        notePoolCollection = CreatePoolCollection()
        notePoolCollection:CreatePool("Button", MethodDungeonTools.main_frame.mapPanelFrame, "QuestPinTemplate")
    end
    --setup
    local note = notePoolCollection:Acquire("QuestPinTemplate")
    note.noteIdx = notePoolCollection.pools.QuestPinTemplate.numActiveObjects
    note.objectIndex = objectIndex
    note:ClearAllPoints()
    note:SetPoint("CENTER",MethodDungeonTools.main_frame.mapPanelTile1,"TOPLEFT",x,y)
    note:SetSize(12,12)
    note.Texture:SetSize(15, 15);
    note.PushedTexture:SetSize(15, 15);
    note.Highlight:SetSize(15, 15);
    note.Number:SetSize(16, 16);
    note.Texture:SetTexture("Interface/WorldMap/UI-QuestPoi-NumberIcons");
    note.PushedTexture:SetTexture("Interface/WorldMap/UI-QuestPoi-NumberIcons");
    note.Highlight:SetTexture("Interface/WorldMap/UI-QuestPoi-NumberIcons");
    note.Number:SetTexture("Interface/WorldMap/UI-QuestPoi-NumberIcons");
    note.Texture:SetTexCoord(0.500, 0.625, 0.375, 0.5);
    note.PushedTexture:SetTexCoord(0.375, 0.500, 0.375, 0.5);
    note.Highlight:SetTexCoord(0.625, 0.750, 0.375, 0.5);
    note.Number:SetTexCoord(QuestPOI_CalculateNumericTexCoords(note.noteIdx, QUEST_POI_COLOR_BLACK ))
    note.Number:Show();
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
            noteEditbox.frame:SetPoint("TOPLEFT",note,"TOPRIGHT")
            noteEditbox.frame:Show()
            noteEditbox.multiBox:SetText(note.tooltipText)
            noteEditbox.multiBox.button:Enable()
        end
    end
    note:SetScript("OnClick",function(self,button,down)
        if button == "LeftButton" then
            L_CloseDropDownMenus()
            self:OpenEditBox()
        elseif button == "RightButton" then
            currentNote = note
            L_EasyMenu(noteMenu,noteDropDown, "cursor", 0 , -15, "MENU")
            if noteEditbox and noteEditbox.frame:IsShown() then
                noteEditbox.frame:Hide()
            end
        end
    end)
    note:SetScript("OnEnter",function()
        GameTooltip:SetOwner(UIParent, "ANCHOR_CURSOR")
        GameTooltip:AddLine(note.tooltipText , 1, 1, 1, 1)
        GameTooltip:Show()
    end)
    note:SetScript("OnLeave",function()
        GameTooltip:Hide()
    end)

    note:Show()
end