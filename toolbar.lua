---
--- DateTime: 07.04.2018 15:26
---
local sizex,sizey = 350,30
local AceGUI = LibStub("AceGUI-3.0")
local db
local toolbarTools = {}
local currentTool
local texturePool = {}

---initToolbar
---sets up the toolbar frame and the widgets in it
function MethodDungeonTools:initToolbar(frame)
    db = MethodDungeonTools:GetDB()

    frame.toolbar = CreateFrame("Frame","MethodDungeonToolsToolbarFrame",frame)
    frame.toolbar:SetFrameStrata("HIGH")
    frame.toolbar:SetFrameLevel(5)
    frame.toolbar.tex = frame.toolbar:CreateTexture(nil,"HIGH",nil,6)
    frame.toolbar.tex:SetAllPoints()
    frame.toolbar.tex:SetColorTexture(0, 0, 0, 0.7)
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
    MethodDungeonTools:CreateToolbarTooltip(frame.toolbar)

    frame.toolbar.toggleButton:SetScript("OnClick", function()
        if frame.toolbar:IsShown() then
            frame.toolbar:Hide()
            frame.toolbar.toggleButton:SetPoint("TOP",frame,"TOP")
            frame.toolbar.toggleButton:GetNormalTexture():SetTexCoord(0,1,0.65,1)
        else
            frame.toolbar:Show()
            frame.toolbar.toggleButton:SetPoint("TOP",frame.toolbar,"BOTTOM")
            frame.toolbar.toggleButton:GetNormalTexture():SetTexCoord(0,1,0,0.35)
        end
    end)

    frame.toolbar.widgetGroup = AceGUI:Create("SimpleGroup")
    frame.toolbar.widgetGroup.frame:SetAllPoints(frame.toolbar)
    --frame.toolbar.widgetGroup:SetWidth(350)
    --frame.toolbar.widgetGroup:SetHeight(15)
    --frame.toolbar.widgetGroup:SetPoint("TOP",frame.toolbar,"TOP",0,0)



    frame.toolbar.widgetGroup:SetLayout("Flow")
    frame.toolbar.widgetGroup.frame:SetFrameStrata("High")
    frame.toolbar.widgetGroup.frame:SetFrameLevel(7)

    --dirty hook to make widgetgroup show/hide
    do
        local originalShow,originalHide = frame.toolbar.Show,frame.toolbar.Hide
        function frame.toolbar:Show(...)
            frame.toolbar.widgetGroup.frame:Show()
            return originalShow(self, ...)
        end
        function frame.toolbar:Hide(...)
            frame.toolbar.widgetGroup.frame:Hide()
            return originalHide(self, ...)
        end
    end
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
    local widgetHeight = 65

    ---back
    local back = AceGUI:Create("Icon")
    back:SetImage("Interface\\AddOns\\MethodDungeonTools\\Textures\\icons",0.5,0.75,0.5,0.75)
    back:SetWidth(widgetWidth)
    back:SetImageSize(20,20)
    back:SetCallback("OnClick",function (widget,callbackName)

    end)
    frame.toolbar.widgetGroup:AddChild(back)

    ---forward
    local forward = AceGUI:Create("Icon")
    forward:SetImage("Interface\\AddOns\\MethodDungeonTools\\Textures\\icons",0.75,1,0.5,0.75)
    forward:SetWidth(widgetWidth)
    forward:SetImageSize(20,20)
    forward:SetCallback("OnClick",function (widget,callbackName)

    end)
    frame.toolbar.widgetGroup:AddChild(forward)

    ---colorPicker
    local colorPicker = AceGUI:Create("ColorPicker")
    colorPicker:SetHasAlpha(true)
    colorPicker:SetColor(db.toolbar.color.r, db.toolbar.color.g, db.toolbar.color.b, db.toolbar.color.a)
    colorPicker:SetCallback("OnValueConfirmed",function(widget,callbackName,r, g, b, a)
        db.toolbar.color.r, db.toolbar.color.g, db.toolbar.color.b, db.toolbar.color.a  = r, g, b, a
        colorPicker:SetColor(r, g, b, a)
    end)
    colorPicker:SetWidth(widgetWidth)
    colorPicker.tooltipText = "colorpicker"
    colorPicker:SetCallback("OnEnter",function(widget,callbackName)
        MethodDungeonTools:ToggleToolbarTooltip(true,widget)
    end)
    colorPicker:SetCallback("OnLeave",function()
        MethodDungeonTools:ToggleToolbarTooltip(false)
    end)
    frame.toolbar.widgetGroup:AddChild(colorPicker)

    local sizeIndicator
    ---minus
    local minus = AceGUI:Create("Icon")
    minus:SetImage("Interface\\AddOns\\MethodDungeonTools\\Textures\\icons",0,0.25,0.5,0.75)
    minus:SetWidth(widgetWidth)
    minus:SetImageSize(20,20)
    minus:SetCallback("OnClick",function (widget,callbackName)
        db.toolbar.brushSize = db.toolbar.brushSize - 1
        if db.toolbar.brushSize < 1 then db.toolbar.brushSize = 1 end
        sizeIndicator:SetText(db.toolbar.brushSize)
    end)
    minus.tooltipText = "decrease brush size"
    minus:SetCallback("OnEnter",function(widget,callbackName)
        MethodDungeonTools:ToggleToolbarTooltip(true,widget)
    end)
    minus:SetCallback("OnLeave",function()
        MethodDungeonTools:ToggleToolbarTooltip(false)
    end)
    frame.toolbar.widgetGroup:AddChild(minus)

    ---sizeIndicator
    sizeIndicator = AceGUI:Create("EditBox")
    sizeIndicator:SetWidth(30)
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
    frame.toolbar.widgetGroup:AddChild(sizeIndicator)

    ---plus
    local plus = AceGUI:Create("Icon")
    plus:SetImage("Interface\\AddOns\\MethodDungeonTools\\Textures\\icons",0.25,0.5,0.5,0.75)
    plus:SetWidth(widgetWidth)
    plus:SetImageSize(20,20)
    plus:SetCallback("OnClick",function (widget,callbackName)
        db.toolbar.brushSize = db.toolbar.brushSize + 1
        sizeIndicator:SetText(db.toolbar.brushSize)
    end)
    frame.toolbar.widgetGroup:AddChild(plus)


    ---pencil
    local pencil = AceGUI:Create("Icon")
    pencil:SetImage("Interface\\AddOns\\MethodDungeonTools\\Textures\\icons",0,0.25,0,0.25)
    pencil:SetWidth(widgetWidth)
    pencil:SetImageSize(20,20)
    toolbarTools["pencil"] = pencil
    pencil:SetCallback("OnClick",function (widget,callbackName)
        if currentTool == "pencil" then MethodDungeonTools:UpdateSelectedToolbarTool() else MethodDungeonTools:UpdateSelectedToolbarTool("pencil") end
    end)
    frame.toolbar.widgetGroup:AddChild(pencil)

    ---line
    local line = AceGUI:Create("Icon")
    line:SetImage("Interface\\AddOns\\MethodDungeonTools\\Textures\\icons",0,0.25,0.75,1)
    line:SetWidth(widgetWidth)
    line:SetImageSize(20,20)
    toolbarTools["line"] = line
    line:SetCallback("OnClick",function (widget,callbackName)
        if currentTool == "line" then MethodDungeonTools:UpdateSelectedToolbarTool() else MethodDungeonTools:UpdateSelectedToolbarTool("line") end
    end)
    frame.toolbar.widgetGroup:AddChild(line)

    ---arrow
    local arrow = AceGUI:Create("Icon")
    arrow:SetImage("Interface\\AddOns\\MethodDungeonTools\\Textures\\icons",0.25,0.5,0,0.25)
    arrow:SetWidth(widgetWidth)
    arrow:SetImageSize(20,20)
    toolbarTools["arrow"] = arrow
    arrow:SetCallback("OnClick",function (widget,callbackName)
        if currentTool == "arrow" then MethodDungeonTools:UpdateSelectedToolbarTool() else MethodDungeonTools:UpdateSelectedToolbarTool("arrow") end
    end)
    frame.toolbar.widgetGroup:AddChild(arrow)

    ---note
    local note = AceGUI:Create("Icon")
    note:SetImage("Interface\\AddOns\\MethodDungeonTools\\Textures\\icons",0.75,1,0,0.25)
    note:SetWidth(widgetWidth)
    note:SetImageSize(20,20)
    toolbarTools["note"] = note
    note:SetCallback("OnClick",function (widget,callbackName)
        if currentTool == "note" then MethodDungeonTools:UpdateSelectedToolbarTool() else MethodDungeonTools:UpdateSelectedToolbarTool("note") end
    end)
    frame.toolbar.widgetGroup:AddChild(note)

    ---mover
    local mover = AceGUI:Create("Icon")
    mover:SetImage("Interface\\AddOns\\MethodDungeonTools\\Textures\\icons",0.5,0.75,0,0.25)
    mover:SetWidth(widgetWidth)
    mover:SetImageSize(20,20)
    toolbarTools["mover"] = mover
    mover:SetCallback("OnClick",function (widget,callbackName)
        if currentTool == "mover" then MethodDungeonTools:UpdateSelectedToolbarTool() else MethodDungeonTools:UpdateSelectedToolbarTool("mover") end
    end)
    frame.toolbar.widgetGroup:AddChild(mover)

    ---cogwheel
    local cogwheel = AceGUI:Create("Icon")
    cogwheel:SetImage("Interface\\AddOns\\MethodDungeonTools\\Textures\\icons",0,0.25,0.25,0.5)
    cogwheel:SetWidth(widgetWidth)
    cogwheel:SetImageSize(20,20)
    cogwheel:SetCallback("OnClick",function (widget,callbackName)

    end)
    frame.toolbar.widgetGroup:AddChild(cogwheel)

    ---eraser
    local eraser = AceGUI:Create("Icon")
    eraser:SetImage("Interface\\AddOns\\MethodDungeonTools\\Textures\\icons",0.25,0.5,0.25,0.5)
    eraser:SetWidth(widgetWidth)
    eraser:SetImageSize(20,20)
    toolbarTools["eraser"] = eraser
    eraser:SetCallback("OnClick",function (widget,callbackName)
        if currentTool == "eraser" then MethodDungeonTools:UpdateSelectedToolbarTool() else MethodDungeonTools:UpdateSelectedToolbarTool("eraser") end
    end)
    frame.toolbar.widgetGroup:AddChild(eraser)

    ---size slider
    local slider = AceGUI:Create("Slider")
    slider:SetSliderValues(1,15,1)
    slider:SetWidth(120)
    slider:SetHeight(20)
    slider.label:SetHeight(0)
    slider:SetValue(db.toolbar.brushSize)
    slider:SetCallback("OnValueChanged",function(widget,callbackName,value)
        local size = tonumber(value)
        db.toolbar.brushSize = size or db.toolbar.brushSize
    end)
    --frame.toolbar.widgetGroup:AddChild(slider)


    frame.toolbar:SetSize(sizex, sizey)
    frame.toolbar:SetPoint("TOP", frame, "TOP", 0, 0)

    MethodDungeonTools:UpdateSelectedToolbarTool()
end

---CreateToolbarTooltip
function MethodDungeonTools:CreateToolbarTooltip(frame)
    frame.tooltip = CreateFrame("Frame", "MethodDungeonToolsToolbarTooltip", UIParent, "TooltipBorderedFrameTemplate")
    frame.tooltip:SetClampedToScreen(true)
    frame.tooltip:SetFrameStrata("TOOLTIP")
    frame.tooltip:SetSize(90, 25)
    frame.tooltip:Hide()

    frame.tooltip.text = frame.tooltip:CreateFontString("MethodDungeonToolsToolbarTooltipString")
    frame.tooltip.text:SetFont("Fonts\\FRIZQT__.TTF", 12)
    frame.tooltip.text:SetTextColor(1, 1, 1, 1);
    frame.tooltip.text:SetJustifyH("CENTER")
    frame.tooltip.text:SetJustifyV("TOP")
    frame.tooltip.text:SetHeight(30)
    frame.tooltip.text:SetWidth(90)
    frame.tooltip.text:SetPoint("TOPLEFT", frame.tooltip, "TOPLEFT", 0, -5)
end

---ToggleToolbarTooltip
function MethodDungeonTools:ToggleToolbarTooltip(show,widget)
    local tooltip = MethodDungeonTools.main_frame.toolbar.tooltip
    if not show then
        tooltip:Hide()
    else
        --set text
        tooltip.text:SetText(widget.tooltipText)
        tooltip:SetPoint("TOP",widget.frame,"BOTTOM")
        --tooltip:Show()
    end
end

---UpdateSelectedToolbarTool
---Called when a tool is selected/deselected
function MethodDungeonTools:UpdateSelectedToolbarTool(widgetName)
    local toolbar = MethodDungeonTools.main_frame.toolbar
    if not widgetName then
        currentTool = nil
        if toolbar.highlight then toolbar.highlight:Hide() end
        MethodDungeonTools:RestoreScrollframeScripts()
        return
    end
    local widget = toolbarTools[widgetName]
    if not widget then
        currentTool = nil
        if toolbar.highlight then toolbar.highlight:Hide() end
        MethodDungeonTools:RestoreScrollframeScripts()
        return
    end
    currentTool = widgetName
    toolbar.highlight = toolbar.highlight or toolbar:CreateTexture(nil,"HIGH",nil,7)
    toolbar.highlight:SetTexture("Interface\\AddOns\\MethodDungeonTools\\Textures\\icons")
    toolbar.highlight:SetTexCoord(0.5,0.75,0.25,0.5)
    toolbar.highlight:SetSize(widget.frame:GetWidth(),widget.frame:GetWidth())
    toolbar.highlight:SetPoint("CENTER",widget.frame,"CENTER")
    MethodDungeonTools:OverrideScrollframeScripts()
    toolbar.highlight:Show()
end

---OverrideScrollframeScripts
---Take control of the map scrollframe mouse event scripts
---Called when the user starts drawing on the map
function MethodDungeonTools:OverrideScrollframeScripts()
    local frame = MethodDungeonTools.main_frame
    frame.scrollFrame:SetScript("OnMouseDown", function(self,button)
        if ( button == "LeftButton") then
            if currentTool == "pencil" then MethodDungeonTools:StartPencilDrawing() end
            if currentTool == "arrow" then MethodDungeonTools:StartArrowDrawing() end
            if currentTool == "line" then MethodDungeonTools:StartLineDrawing() end
        end
    end)
    frame.scrollFrame:SetScript("OnMouseUp", function(self,button)
        if ( button == "LeftButton") then
            if currentTool == "pencil" then MethodDungeonTools:StopPencilDrawing() end
            if currentTool == "arrow" then MethodDungeonTools:StopArrowDrawing() end
            if currentTool == "line" then MethodDungeonTools:StopLineDrawing() end
        end
    end)
end

---RestoreScrollframeScripts
---Restore original functionality to the map scrollframe: Clicking on enemies, rightclick context menu
---Called when the user is done drawing on the map
function MethodDungeonTools:RestoreScrollframeScripts()
    local frame = MethodDungeonTools.main_frame
    frame.scrollFrame:SetScript("OnMouseDown", MethodDungeonTools.OnMouseDown)
    frame.scrollFrame:SetScript("OnMouseUp", MethodDungeonTools.OnMouseUp)
end

---returns cursor position relative to the map frame
function MethodDungeonTools:GetCursorPosition()
    local frame = MethodDungeonTools.main_frame
    local scrollFrame = frame.scrollFrame
    local relativeFrame = UIParent      --UIParent
    local mapPanelFrame = MethodDungeonTools.main_frame.mapPanelFrame
    local cursorX, cursorY = GetCursorPosition()
    local mapScale = mapPanelFrame:GetScale()
    local scrollH = scrollFrame:GetHorizontalScroll();
    local scrollV = scrollFrame:GetVerticalScroll();
    local frameX = (cursorX / relativeFrame:GetScale()) - scrollFrame:GetLeft();
    local frameY = scrollFrame:GetTop() - (cursorY / relativeFrame:GetScale());
    frameX=(frameX/mapScale)+scrollH
    frameY=(frameY/mapScale)+scrollV
    return frameX,-frameY
end

---StartArrowDrawing
function MethodDungeonTools:StartArrowDrawing()
    local frame = MethodDungeonTools.main_frame
    local startx,starty = MethodDungeonTools:GetCursorPosition()
    local line = MethodDungeonTools.main_frame.mapPanelFrame:CreateTexture(nil, "OVERLAY")
    line:SetDrawLayer("ARTWORK", 3)
    line:SetTexture("Interface\\AddOns\\MethodDungeonTools\\Textures\\Square_White")
    line:SetVertexColor(db.toolbar.color.r,db.toolbar.color.g,db.toolbar.color.b,db.toolbar.color.a)

    local arrow = MethodDungeonTools.main_frame.mapPanelFrame:CreateTexture(nil, "OVERLAY")
    arrow:SetDrawLayer("ARTWORK", 3)
    arrow:SetTexture("Interface\\AddOns\\MethodDungeonTools\\Textures\\triangle")
    arrow:SetVertexColor(db.toolbar.color.r,db.toolbar.color.g,db.toolbar.color.b,db.toolbar.color.a)

    frame.toolbar:SetScript("OnUpdate", function(self, tick)
        if not MouseIsOver(MethodDungeonToolsScrollFrame) then return end
        local x,y = MethodDungeonTools:GetCursorPosition()
        if x~= startx and y~=starty then
            DrawLine(line, MethodDungeonTools.main_frame.mapPanelTile1, startx, starty, x, y, (db.toolbar.brushSize*0.3), 1,"TOPLEFT")
        end
        --position arrow head
        arrow:Show()
        arrow:SetWidth(1*db.toolbar.brushSize)
        arrow:SetHeight(1*db.toolbar.brushSize)
        --calculate rotation
        local rotation = math.atan2(starty-y,startx-x)
        arrow:SetRotation(rotation+math.pi)
        arrow:SetPoint("CENTER",MethodDungeonTools.main_frame.mapPanelTile1,"TOPLEFT",x,y)
    end)
end

---StopArrowDrawing
function MethodDungeonTools:StopArrowDrawing()
    local frame = MethodDungeonTools.main_frame
    frame.toolbar:SetScript("OnUpdate",nil)
end

---StartLineDrawing
function MethodDungeonTools:StartLineDrawing()
    local frame = MethodDungeonTools.main_frame
    local startx,starty = MethodDungeonTools:GetCursorPosition()
    local line = MethodDungeonTools.main_frame.mapPanelFrame:CreateTexture(nil, "OVERLAY")
    --line:SetDrawLayer("ARTWORK", 3)
    line:SetTexture("Interface\\AddOns\\MethodDungeonTools\\Textures\\Square_White")
    line:SetVertexColor(db.toolbar.color.r,db.toolbar.color.g,db.toolbar.color.b,db.toolbar.color.a)

    frame.toolbar:SetScript("OnUpdate", function(self, tick)
        if not MouseIsOver(MethodDungeonToolsScrollFrame) then return end
        local x,y = MethodDungeonTools:GetCursorPosition()
        if x~= startx and y~=starty then
            DrawLine(line, MethodDungeonTools.main_frame.mapPanelTile1, startx, starty, x, y, (db.toolbar.brushSize*0.3), 1,"TOPLEFT")
        end
    end)
end

---StopLineDrawing
function MethodDungeonTools:StopLineDrawing()
    local frame = MethodDungeonTools.main_frame
    frame.toolbar:SetScript("OnUpdate",nil)
end

---GetHighestFrameLevelAtCursor
function MethodDungeonTools:GetHighestFrameLevelAtCursor()
    local currentSublevel = -8
    for k,v in pairs(texturePool) do
        if MouseIsOver(v) and v:IsShown() then
            local _, sublevel = v:GetDrawLayer()
            currentSublevel = math.max(currentSublevel,sublevel+2)
        end
    end
    if currentSublevel > 7 then currentSublevel = 7 end
    return currentSublevel
end

local thresholdDefault = 10
---StartPencilDrawing
---Starts the pencil drawing script, fired on mouse down with pencil tool selected
function MethodDungeonTools:StartPencilDrawing()
    local frame = MethodDungeonTools.main_frame
    local oldx,oldy
    local drawLayer = -8
    frame.toolbar:SetScript("OnUpdate", function(self, tick)
        if not MouseIsOver(MethodDungeonToolsScrollFrame) then return end
        local currentDrawLayer = MethodDungeonTools:GetHighestFrameLevelAtCursor()
        drawLayer = math.max(drawLayer,currentDrawLayer)
        local x,y = MethodDungeonTools:GetCursorPosition()
        --x,y = floor(x),floor(y)
        local scale = MethodDungeonTools.main_frame.mapPanelFrame:GetScale()
        local threshold = thresholdDefault * 1/scale
        if not oldx or not oldy then
            oldx,oldy = x,y
            return
        end
        if (oldx and math.abs(x-oldx)>threshold) or (oldy and math.abs(y-oldy)>threshold)  then
            MethodDungeonTools:DrawLine(oldx,oldy,x,y,(db.toolbar.brushSize*0.3),db.toolbar.color,true,drawLayer)
            oldx,oldy = x,y
        end
    end)
end

---StopPencilDrawing
---End the pencil drawing script, fired on mouse up with the pencil tool selected
function MethodDungeonTools:StopPencilDrawing()
    local frame = MethodDungeonTools.main_frame
    frame.toolbar:SetScript("OnUpdate",nil)
end

---DrawLine
function MethodDungeonTools:DrawLine(x,y,a,b,size,color,smooth,drawLayer)
    --print("Drawing Line from: "..x,y.." to "..oldx,oldy)
    local line = MethodDungeonTools.main_frame.mapPanelFrame:CreateTexture(nil, "OVERLAY")
    line:SetTexture("Interface\\AddOns\\MethodDungeonTools\\Textures\\Square_White")
    line:SetVertexColor(color.r,color.g,color.b,color.a)
    line:SetDrawLayer("OVERLAY", drawLayer)
    DrawLine(line, MethodDungeonTools.main_frame.mapPanelTile1, x, y, a, b, size, 1.1,"TOPLEFT")
    table.insert(texturePool,line)
    if smooth == true  then
        local circle = MethodDungeonTools.main_frame.mapPanelFrame:CreateTexture(nil, "OVERLAY")
        circle:SetDrawLayer("OVERLAY", drawLayer)

        circle:SetTexture("Interface\\AddOns\\MethodDungeonTools\\Textures\\Circle_White")
        circle:SetVertexColor(color.r,color.g,color.b,color.a)
        circle:SetWidth(1*size)
        circle:SetHeight(1*size)
        circle:SetPoint("CENTER",MethodDungeonTools.main_frame.mapPanelTile1,"TOPLEFT",x,y)
        table.insert(texturePool,circle)
        --circle:Hide()
    end
end

