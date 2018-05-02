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
        x,y = floor(x),floor(y)
        local scale = MethodDungeonTools.main_frame.mapPanelFrame:GetScale()
        threshold = threshold * 1/scale
        if not oldx or not oldy then
            oldx,oldy = x,y
            return
        end
        if (oldx and math.abs(x-oldx)>threshold) or (oldy and math.abs(y-oldy)>threshold)  then
            MethodDungeonTools:DrawLine(x,y,oldx,oldy,1,db.toolbar.color)
            oldx,oldy = x,y
        end
    end)
end



local prevBlip
function MethodDungeonTools:StopPencilDrawing()
    local frame = MethodDungeonTools.main_frame
    frame.toolbar:SetScript("OnUpdate",nil)
    prevBlip = nil
    --ViragDevTool_AddData(MethodDungeonTools.pencilBlips)
end

---Projection
function MethodDungeonTools.GetCoordsForTransform(A, B, C, D, E, F)
    -- http://www.wowwiki.com/SetTexCoord_Transformations
    local det = A*E - B*D;
    local ULx, ULy, LLx, LLy, URx, URy, LRx, LRy;

    ULx, ULy = ( B*F - C*E ) / det, ( -(A*F) + C*D ) / det;
    LLx, LLy = ( -B + B*F - C*E ) / det, ( A - A*F + C*D ) / det;
    URx, URy = ( E + B*F - C*E ) / det, ( -D - A*F + C*D ) / det;
    LRx, LRy = ( E - B + B*F - C*E ) / det, ( -D + A -(A*F) + C*D ) / det;

    return ULx, ULy, LLx, LLy, URx, URy, LRx, LRy;
end;

---DrawLine
function MethodDungeonTools:DrawLine(x,y,a,b,size,color)
    --print("Drawing Line from: "..x,y.." to "..oldx,oldy)

    local ix = math.floor(x);
    local iy = math.floor(y);
    local ia = math.floor(a);
    local ib = math.floor(b);

    local cx, cy = (ix + ia)/2, (iy + ib)/2;
    local dx, dy = ix-ia, iy-ib;
    local dmax = math.max(math.abs(dx),math.abs(dy));
    local dr = math.sqrt(dx*dx + dy*dy);
    local scale = 1/dmax*32;
    local sinA, cosA = dy/dr*scale, dx/dr*scale;
    if dr == 0 then
        return nil;
    end

    local pix;
    --if #(self.junkLines) > 0 then
    --  pix = table.remove(self.junkLines); -- Recycling ftw!
    --else
    pix = MethodDungeonTools.main_frame.mapPanelFrame:CreateTexture(nil, "OVERLAY");
    pix:SetTexture("Interface\\AddOns\\MethodDungeonTools\\Textures\\line.tga");
    --end;
    pix:ClearAllPoints();
    pix:SetPoint("CENTER", MethodDungeonTools.main_frame.mapPanelTile1, "TOPLEFT", cx, cy)
    pix:SetWidth(dmax); pix:SetHeight(dmax)
    pix:SetTexCoord(MethodDungeonTools.GetCoordsForTransform(
            cosA, sinA, -(cosA+sinA)/2+0.5,
            -sinA, cosA, -(-sinA+cosA)/2+0.5))
    pix:Show()
    pix["lax"] = ix
    pix["lay"] = iy
    pix["lbx"] = ia
    pix["lby"] = ib
    pix["r"] = color.r
    pix["g"] = color.g
    pix["b"] = color.b
    pix["a"] = color.a

    if index then
        --self.mainLines[index] = pix
    else
        --table.insert(self.mainLines, pix)
    end

    --return pix, #self.mainLines

end


---DrawPencilPoint
---Draw a point on the map
local delta = 0
function MethodDungeonTools:DrawPencilPoint(frameX, frameY)
    --print("Drawing Point at:",frameX,frameY)
    local currentBlip
    local idx = 0
    for _,blip in pairs(MethodDungeonTools.pencilBlips) do
        idx = idx + 1
        if (blip.frameX <= frameX+delta and blip.frameX >= frameX-delta) and (blip.frameY <= frameY+delta and blip.frameY >= frameY-delta) then
            currentBlip = blip
            currentBlip.frameX,currentBlip.frameY = frameX,frameY
            print("from storage")
        end
    end
    if not currentBlip then
        currentBlip = MethodDungeonTools.main_frame.mapPanelFrame:CreateTexture("MethodDungeonToolsPencilBlip"..idx,"BACKGROUND")
        currentBlip.frameX,currentBlip.frameY = frameX,frameY
        table.insert(MethodDungeonTools.pencilBlips,currentBlip)
    end

    local  r, g, b, a = db.toolbar.color.r, db.toolbar.color.g, db.toolbar.color.b, db.toolbar.color.a
    currentBlip:SetDrawLayer("ARTWORK", 4)
    --blip:SetTexture("Interface\\Artifacts\\_Artifacts-DependencyBar-Fill")
    currentBlip:SetTexture("Interface\\AddOns\\MethodDungeonTools\\Textures\\Circle_White")
    currentBlip:SetVertexColor(r,g,b,a)
    currentBlip:SetWidth(3)
    currentBlip:SetHeight(3)
    currentBlip:SetPoint("CENTER",MethodDungeonTools.main_frame.mapPanelTile1,"TOPLEFT",frameX,frameY)
    currentBlip:Show()


    --Timosh
    if prevBlip and false then
        local currLine
        currentBlip.line = currentBlip.line or CreateFrame("Frame",nil,MethodDungeonTools.main_frame.mapPanelFrame)
        currLine = currentBlip.line
        currLine:SetPoint("TOPLEFT")
        currLine:SetSize(1,1)

        currLine.Fill1 = currLine:CreateLine(nil, "BACKGROUND", nil, -5)
        currLine.Fill1:SetTexture("Interface\\AddOns\\MethodDungeonTools\\Textures\\Circle_White")

        currLine.Fill1:SetVertexColor(r,g,b,a)
        currLine.Fill1:SetAlpha(1)
        currLine.Fill1:SetThickness(floor(3))

        currLine.Point1 = currLine.Point1 or currLine:CreateTexture()
        currLine.Point1:SetSize(1,1)
        currLine.Point2 = currLine.Point2 or currLine:CreateTexture()
        currLine.Point2:SetSize(1,1)

        currLine.Fill1:SetStartPoint("CENTER",currentBlip, 0, 0)
        currLine.Point1:SetPoint("CENTER",currentBlip, 0, 0)

        currLine.Fill1:SetEndPoint("CENTER",prevBlip, 0, 0)
        currLine.Point2:SetPoint("CENTER",prevBlip, 0, 0)
    end

    --artpad



    prevBlip = currentBlip
end