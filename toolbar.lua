---
--- DateTime: 07.04.2018 15:26
---
local sizex,sizey = 350,30
local AceGUI = LibStub("AceGUI-3.0")
local db
local toolbarTools = {}
local currentTool

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

    ---colorPicker
    local colorPicker = AceGUI:Create("ColorPicker")
    colorPicker:SetHasAlpha(true)
    colorPicker:SetColor(db.toolbar.color.r, db.toolbar.color.g, db.toolbar.color.b, db.toolbar.color.a)
    colorPicker:SetCallback("OnValueConfirmed",function(widget,callbackName,r, g, b, a)
        db.toolbar.color.r, db.toolbar.color.g, db.toolbar.color.b, db.toolbar.color.a  = r, g, b, a
        colorPicker:SetColor(r, g, b, a)
    end)
    colorPicker:SetWidth(widgetWidth)
    frame.toolbar.widgetGroup:AddChild(colorPicker)


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
    frame.toolbar.widgetGroup:AddChild(slider)


    frame.toolbar:SetSize(sizex, sizey)
    frame.toolbar:SetPoint("TOP", frame, "TOP", 0, 0)

    MethodDungeonTools:UpdateSelectedToolbarTool()
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
        end
    end)
    frame.scrollFrame:SetScript("OnMouseUp", function(self,button)
        if ( button == "LeftButton") then
            if currentTool == "pencil" then MethodDungeonTools:StopPencilDrawing() end
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


local threshold = 10
function MethodDungeonTools:StartPencilDrawing()
    local frame = MethodDungeonTools.main_frame
    local oldx,oldy
    frame.toolbar:SetScript("OnUpdate", function(self, tick)
        if not MouseIsOver(MethodDungeonToolsScrollFrame) then return end
        local x,y = MethodDungeonTools:GetCursorPosition()
        --x,y = floor(x),floor(y)
        local scale = MethodDungeonTools.main_frame.mapPanelFrame:GetScale()
        threshold = threshold * 1/scale
        if not oldx or not oldy then
            oldx,oldy = x,y
            return
        end
        if (oldx and math.abs(x-oldx)>threshold) or (oldy and math.abs(y-oldy)>threshold)  then
            MethodDungeonTools:DrawLine(oldx,oldy,x,y,(db.toolbar.brushSize*0.3),db.toolbar.color,true)
            oldx,oldy = x,y
        end
    end)
end


function MethodDungeonTools:StopPencilDrawing()
    local frame = MethodDungeonTools.main_frame
    frame.toolbar:SetScript("OnUpdate",nil)
end

---DrawLine
function MethodDungeonTools:DrawLine(x,y,a,b,size,color,smooth)
    --print("Drawing Line from: "..x,y.." to "..oldx,oldy)
    local line = MethodDungeonTools.main_frame.mapPanelFrame:CreateTexture(nil, "OVERLAY")
    line:SetDrawLayer("ARTWORK", 3)
    line:SetTexture("Interface\\AddOns\\MethodDungeonTools\\Textures\\Square_White")
    line:SetVertexColor(color.r,color.g,color.b,color.a)
    DrawLine(line, MethodDungeonTools.main_frame.mapPanelTile1, x, y, a, b, size, 40/30,"TOPLEFT")

    if smooth == true then
        local circle = MethodDungeonTools.main_frame.mapPanelFrame:CreateTexture(nil, "OVERLAY")
        circle:SetDrawLayer("ARTWORK", 4)
        circle:SetTexture("Interface\\AddOns\\MethodDungeonTools\\Textures\\Circle_White")
        circle:SetVertexColor(color.r,color.g,color.b,color.a)
        circle:SetWidth(1.4*size)
        circle:SetHeight(1.4*size)
        circle:SetPoint("CENTER",MethodDungeonTools.main_frame.mapPanelTile1,"TOPLEFT",x,y)
        circle:Show()
    end
end

