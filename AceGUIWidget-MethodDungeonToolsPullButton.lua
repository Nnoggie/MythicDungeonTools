local Type, Version = "MethodDungeonToolsPullButton", 1
local AceGUI = LibStub and LibStub("AceGUI-3.0", true)

local width,height = 248,32
local maxPortraitCount = 7
local tinsert,SetPortraitToTexture,SetPortraitTextureFromCreatureDisplayID,GetItemQualityColor,MouseIsOver = table.insert,SetPortraitToTexture,SetPortraitTextureFromCreatureDisplayID,GetItemQualityColor,MouseIsOver
local next = next

local dragdrop_overlap = 2000

local function GetDropTarget()
    local scrollFrame = MethodDungeonTools.main_frame.sidePanel.pullButtonsScrollFrame
    local buttonList = MethodDungeonTools.main_frame.sidePanel.newPullButtons
    local id, button, pos, offset


    if scrollFrame.frame:IsMouseOver(1, -1, -dragdrop_overlap, dragdrop_overlap) then
        -- Find hovered pull
        repeat
            repeat
                id, button = next(buttonList, id)
            until not id or not button.dragging and button:IsShown()

            if id and button then
                offset = (button.frame.height or button.frame:GetHeight() or 16) / 2
                pos = (button.frame:IsMouseOver(1, offset, -dragdrop_overlap, dragdrop_overlap) and "TOP")
                        or (button.frame:IsMouseOver(-offset, -1, -dragdrop_overlap, dragdrop_overlap) and "BOTTOM")
            end
        until not id or pos

        -- Is add new pull hovered?
        if not id then
            local addNewPullButton = MethodDungeonTools.main_frame.sidePanel.newPullButton
            if addNewPullButton.frame:IsMouseOver() then
                local maxPulls = #MethodDungeonTools:GetCurrentPreset().value.pulls
                id = maxPulls
                button = buttonList[id]
                pos = "BOTTOM"

                -- Is the last button dragged?
                if button.dragging and id > 1 then
                    id = id - 1
                    button = buttonList[id]
                    pos = "BOTTOM"
                end
            end
        end
    end

    local scroll_value_min = 25
    local scroll_value_max = 975
    local scroll_value = scrollFrame.localstatus.scrollvalue
    local scroll_frame_height = (scrollFrame.frame.height or scrollFrame.frame:GetHeight())

    -- Top Graceful Area
    if scrollFrame.frame:IsMouseOver(50, scroll_frame_height+1, -dragdrop_overlap, dragdrop_overlap) and scroll_value < scroll_value_min then
        id, button, pos = 1, buttonList[1], "TOP"

        if button.dragging then
            id, button, pos = 2, buttonList[2], "TOP"
        end
    end

    -- Bottom Graceful Area
    if scrollFrame.frame:IsMouseOver(-(scroll_frame_height+1), -50, -dragdrop_overlap, dragdrop_overlap) and scroll_value > scroll_value_max then
        local maxPulls = #MethodDungeonTools:GetCurrentPreset().value.pulls
        id = maxPulls
        button = buttonList[id]
        pos = "BOTTOM"

        -- Is the last button dragged?
        if button.dragging and id > 1 then
            id = id - 1
            button = buttonList[id]
            pos = "BOTTOM"
        end
    end

    -- Seems to be outside of the list
    -- drop it back to it's original position
    if not id then
        repeat
            id, button = next(buttonList, id)
        until button.dragging

        if id > 1 then
            id = id - 1
            button = buttonList[id]
            pos = "BOTTOM"
        elseif id == 1 then
            id = 2
            button = buttonList[id]
            pos = "TOP"
        end
    end

    return id, button, pos
end

--Methods
local methods = {
    ["OnAcquire"] = function(self)
        self:SetWidth(width);
        self:SetHeight(height);
    end,
    ["Initialize"] = function(self)
        self.callbacks = {}

        function self.callbacks.OnClickNormal(_, mouseButton)
            if not MouseIsOver(MethodDungeonTools.main_frame.sidePanel.pullButtonsScrollFrame.frame) then return end
            if(IsControlKeyDown())then

            elseif(IsShiftKeyDown()) then

            else
                MethodDungeonTools:EnsureDBTables()
                if(mouseButton == "RightButton") then
                    MethodDungeonTools:SetMapSublevel(self.index)
                    MethodDungeonTools:SetSelectionToPull(self.index)
                    L_EasyMenu(self.menu,MethodDungeonTools.main_frame.sidePanel.optionsDropDown, "cursor", 0 , -15, "MENU")
                else
                    --normal click
                    MethodDungeonTools:SetMapSublevel(self.index)
                    MethodDungeonTools:SetSelectionToPull(self.index)
                end
            end
        end

        function self.callbacks.OnEnter()
            MethodDungeonTools.pullTooltip:SetPoint("TOPRIGHT",self.frame,"TOPLEFT",0,0)
            MethodDungeonTools.pullTooltip:SetPoint("BOTTOMRIGHT",self.frame,"TOPLEFT",-250,-(4+MethodDungeonTools.pullTooltip.myHeight))
            local tooltipBottom = MethodDungeonTools.pullTooltip:GetBottom()
            local mainFrameBottom = MethodDungeonTools.main_frame:GetBottom()
            if tooltipBottom<mainFrameBottom then
                MethodDungeonTools.pullTooltip:SetPoint("TOPRIGHT",self.frame,"BOTTOMLEFT",0,(4+MethodDungeonTools.pullTooltip.myHeight))
                MethodDungeonTools.pullTooltip:SetPoint("BOTTOMRIGHT",self.frame,"BOTTOMLEFT",-250,-4)
            end
            self.entered = true
            MethodDungeonTools:ActivatePullTooltip(self.index)
            self.frame:SetScript("OnUpdate", self:CreateUpdateFunction())
            --progressbar
            if MethodDungeonTools.ProgressBarResetTimer then MethodDungeonTools.ProgressBarResetTimer:Cancel() end
            local currentForces = MethodDungeonTools:CountForces(self.index)
            local db = MethodDungeonTools:GetDB()
            local teeming = MethodDungeonTools:IsCurrentPresetTeeming()
            MethodDungeonTools:Progressbar_SetValue(MethodDungeonTools.main_frame.sidePanel.ProgressBar,currentForces,teeming and MethodDungeonTools.dungeonTotalCount[db.currentDungeonIdx].teeming or MethodDungeonTools.dungeonTotalCount[db.currentDungeonIdx].normal)
        end

        function self.callbacks.OnLeave()
            MethodDungeonTools.pullTooltip.Model:Hide()
            MethodDungeonTools.pullTooltip.topString:Hide()
            self.entered = false
            self.frame:SetScript("OnUpdate", nil)
            MethodDungeonTools:UpdatePullTooltip(MethodDungeonTools.pullTooltip)
            MethodDungeonTools.pullTooltip:Hide()
            MethodDungeonTools.ProgressBarResetTimer = C_Timer.NewTimer(0.35, function()
                MethodDungeonTools:UpdateProgressbar()
            end)
        end

        function self.callbacks.OnDragStart()
            self:Drag()
        end

        function self.callbacks.OnDragStop()
            self:Drop()
        end

        function self.callbacks.OnKeyDown(self, key)
            if (key == "ESCAPE") then
                --
            end
        end


        self.menu = {}
        if self.index ~= 1 then
            tinsert(self.menu, {
                text = "Move up",
                notCheckable = 1,
                func = function() MethodDungeonTools:MovePullUp(self.index) end
            })
        end
        if self.index<self.maxPulls then
            tinsert(self.menu, {
                text = "Move down",
                notCheckable = 1,
                func = function() MethodDungeonTools:MovePullDown(self.index) end
            })
        end
        if self.index ~= 1 or self.index < self.maxPulls then
            tinsert(self.menu, {
                text = " ",
                notClickable = 1,
                notCheckable = 1,
                func = nil
            })
        end
        tinsert(self.menu, {
            text = "Insert before",
            notCheckable = 1,
            func = function()
                MethodDungeonTools:PresetsAddPull(self.index)
                MethodDungeonTools:ReloadPullButtons()
                MethodDungeonTools:SetSelectionToPull(self.index)
            end
        })

        tinsert(self.menu, {
            text = "Insert after",
            notCheckable = 1,
            func = function()
                MethodDungeonTools:PresetsAddPull(self.index + 1)
                MethodDungeonTools:ReloadPullButtons()
                MethodDungeonTools:SetSelectionToPull(self.index + 1)
            end
        })
        tinsert(self.menu, {
            text = " ",
            notClickable = 1,
            notCheckable = 1,
            func = nil
        })
        if self.index ~= 1 then
            tinsert(self.menu, {
                text = "Merge up",
                notCheckable = 1,
                func = function()
                    local newIndex = MethodDungeonTools:PresetsMergePulls(self.index, self.index - 1)
                    MethodDungeonTools:ReloadPullButtons()
                    MethodDungeonTools:SetSelectionToPull(newIndex)
                end
            })
        end
        if self.index < self.maxPulls then
            tinsert(self.menu, {
                text = "Merge down",
                notCheckable = 1,
                func = function()
                    local newIndex = MethodDungeonTools:PresetsMergePulls(self.index, self.index + 1)
                    MethodDungeonTools:ReloadPullButtons()
                    MethodDungeonTools:SetSelectionToPull(newIndex)
                end
            })
        end
        if self.index ~= 1 or self.index < self.maxPulls then
            tinsert(self.menu, {
                text = " ",
                notClickable = 1,
                notCheckable = 1,
                func = nil
            })
        end
        tinsert(self.menu, {
            text = "Clear",
            notCheckable = 1,
            func = function() MethodDungeonTools:ClearPull(self.index) end
        })
        tinsert(self.menu, {
            text = "Clear Preset",
            notCheckable = 1,
            func = function() MethodDungeonTools:OpenClearPresetDialog() end
        })
        tinsert(self.menu, {
            text = " ",
            notClickable = 1,
            notCheckable = 1,
            func = nil
        })
        if self.maxPulls > 1 then
            tinsert(self.menu, {
                text = "Delete",
                notCheckable = 1,
                func = function() MethodDungeonTools:DeletePull(self.index) end
            })
            tinsert(self.menu, {
                text = " ",
                notClickable = 1,
                notCheckable = 1,
                func = nil
            })
        end

        tinsert(self.menu, {
            text = "Close",
            notCheckable = 1,
            func = MethodDungeonTools.main_frame.sidePanel.optionsDropDown:Hide()
        })


        --Set pullNumber
        self.pullNumber:SetText(self.index)
        self.pullNumber:Show()


        self.frame:SetScript("OnClick", self.callbacks.OnClickNormal);
        self.frame:SetScript("OnKeyDown", self.callbacks.OnKeyDown);
        self.frame:SetScript("OnEnter", self.callbacks.OnEnter);
        self.frame:SetScript("OnLeave", self.callbacks.OnLeave);
        self.frame:EnableKeyboard(false);
        self.frame:SetMovable(true);
        self.frame:RegisterForDrag("LeftButton");
        self.frame:SetScript("OnDragStart", self.callbacks.OnDragStart);
        self.frame:SetScript("OnDragStop", self.callbacks.OnDragStop);
        self:Enable();
        --self:SetRenameAction(self.callbacks.OnRenameAction);
    end,
    ["CreateUpdateFunction"] = function(self)
        if not self.updateFunction then
            self.updateFunction = function(frame, elapsed)
                if self.entered and not self.dragging then
                    MethodDungeonTools:UpdatePullTooltip(MethodDungeonTools.pullTooltip)
                end

                if self.dragging then
                    if MethodDungeonTools.pullTooltip:IsShown() then
                        MethodDungeonTools.pullTooltip:Hide()
                    end

                    local scrollFrame = MethodDungeonTools.main_frame.sidePanel.pullButtonsScrollFrame
                    local height = (scrollFrame.frame.height or scrollFrame.frame:GetHeight())
                    local scroll_hover_offset = 20
                    local scroll_hover_timeout = 0.05
                    local scroll_hover_amount = 20

                    if scrollFrame.frame:IsMouseOver(1, height - scroll_hover_offset, -dragdrop_overlap, dragdrop_overlap) then
                        self.top_hover = (self.top_hover or 0) + elapsed
                        self.bottom_hover = 0

                        if self.top_hover > scroll_hover_timeout then
                            local oldvalue = scrollFrame.localstatus.scrollvalue
                            local newvalue = oldvalue - scroll_hover_amount
                            if newvalue < 0 then
                                newvalue = 0
                            end
                            scrollFrame.scrollframe.obj:SetScroll(newvalue)
                            scrollFrame.scrollframe.obj:FixScroll()
                            self.top_hover = 0
                        end
                    elseif scrollFrame.frame:IsMouseOver(scroll_hover_offset - height , -1, -dragdrop_overlap, dragdrop_overlap) then
                        self.bottom_hover = (self.bottom_hover or 0) + elapsed
                        self.top_hover = 0

                        if self.bottom_hover > scroll_hover_timeout then
                            local oldvalue = scrollFrame.localstatus.scrollvalue
                            scrollFrame.scrollframe.obj:SetScroll(oldvalue + scroll_hover_amount)
                            scrollFrame.scrollframe.obj:FixScroll()

                            self.bottom_hover = 0
                        end
                    else
                        self.top_hover = 0
                        self.bottom_hover = 0
                    end

                    self.elapsed = (self.elapsed or 0) + elapsed
                    if self.elapsed > 0.1 then
                        local button, pos = select(2, GetDropTarget())
                        MethodDungeonTools:Show_DropIndicator(button, pos)
                        self.elapsed = 0
                    end
                end
            end
        end

        return self.updateFunction
    end,
    ["Drag"] = function(self)
        local uiscale, scale = UIParent:GetScale(), self.frame:GetEffectiveScale()
        local x, w = self.frame:GetLeft(), self.frame:GetWidth()
        local _, y = GetCursorPosition()

        MethodDungeonTools.pullTooltip:Hide()

        self.dragging = true

        self.frame:StartMoving()
        self.frame:ClearAllPoints()
        self.frame.temp = {
            parent = self.frame:GetParent(),
            strata = self.frame:GetFrameStrata()
        }
        self.frame:SetParent(UIParent)
        self.frame:SetFrameStrata("FULLSCREEN_DIALOG")
        self.frame:SetPoint("Center", UIParent, "BOTTOMLEFT", (x+w/2)*scale/uiscale, y/uiscale)

        self.frame:SetScript("OnUpdate", self:CreateUpdateFunction())
    end,
    ["Drop"] = function(self)
        local insertID, button, pos = GetDropTarget()

        if not insertID then
            insertID = self.maxPulls
            pos = "TOP"
        end

        self.frame:StopMovingOrSizing()
        self.dragging = false
        self.frame:SetScript("OnUpdate", nil)

        if self.dragging then
            self.frame:SetParent(self.frame.temp.parent)
            self.frame:SetFrameStrata(self.frame.temp.strata)
            self.frame.temp = nil
        end

        if pos == "BOTTOM" then
            insertID = insertID + 1
        end

        local index = self.index
        if index > insertID then
            index = index + 1
        end

        MethodDungeonTools:PresetsAddPull(insertID)
        local newIndex = MethodDungeonTools:PresetsMergePulls(index, insertID)
        MethodDungeonTools:ReloadPullButtons()
        MethodDungeonTools:SetSelectionToPull(newIndex)

        MethodDungeonTools:Hide_DropIndicator()
        MethodDungeonTools.pullTooltip:Show()
    end,
    ["SetTitle"] = function(self, title)
        self.titletext = title;
        self.title:SetText(title);
    end,
    ["Disable"] = function(self)
        self.background:Hide();
        self.frame:Disable();
    end,
    ["Enable"] = function(self)
        self.background:Show();
        self.frame:Enable();
    end,
    ["Pick"] = function(self)
        self.frame:LockHighlight();
    end,
    ["ClearPick"] = function(self)
        self.frame:UnlockHighlight();
    end,
    ["SetIndex"] = function(self, index)
        self.index = index
    end,
    ["SetMaxPulls"] = function(self, maxPulls)
        self.maxPulls = maxPulls
    end,
    ["SetNPCData"] = function(self,enemyTable)
        local idx = 0
        --hide all textures first
        for k,v in pairs(self.enemyPortraits) do
            v:Hide()
            v.overlay:Hide()
            v.fontString:Hide()
        end

        table.sort(enemyTable,function(a,b)
            return a.count>b.count
        end)

        for npcId,data in ipairs(enemyTable) do
            idx = idx + 1
            if not self.enemyPortraits[idx] then break end
            self.enemyPortraits[idx].enemyData = data
            if data.displayId then
                SetPortraitTextureFromCreatureDisplayID(self.enemyPortraits[idx],data.displayId)
            else
                SetPortraitToTexture(self.enemyPortraits[idx],"Interface\\Icons\\achievement_boss_hellfire_mannorothreanimated")
            end
            self.enemyPortraits[idx]:Show()
            self.enemyPortraits[idx].overlay:Show()
            local quality = 0
            if data.count>0 then quality = 1 end
            if data.count>2 then quality = 2 end
            if data.count>3 then quality = 3 end
            if data.count>6 then quality = 4 end
            if data.count>9 then quality = 5 end
            local r, g, b, hex = GetItemQualityColor(quality)
            if quality == 0 then r,g,b = 0,0,0 end
            self.enemyPortraits[idx].overlay:SetVertexColor(r,g,b)
            self.enemyPortraits[idx].fontString:SetText("x"..data.quantity)
            self.enemyPortraits[idx].fontString:Show()
        end
    end,
}

--Constructor
local function Constructor()
    local name = "MethodDungeonToolsPullButton"..AceGUI:GetNextWidgetNum(Type);
    local button = CreateFrame("BUTTON", name, UIParent, "OptionsListButtonTemplate");
    button:SetHeight(height);
    button:SetWidth(width);
    button.dgroup = nil;
    button.data = {};

    local background = button:CreateTexture(nil, "BACKGROUND");
    button.background = background;
    background:SetTexture("Interface\\BUTTONS\\UI-Listbox-Highlight2.blp");
    background:SetBlendMode("ADD");
    background:SetVertexColor(0.5, 0.5, 0.5, 0.25);
    background:SetPoint("TOP", button, "TOP");
    background:SetPoint("BOTTOM", button, "BOTTOM");
    background:SetPoint("LEFT", button, "LEFT");
    background:SetPoint("RIGHT", button, "RIGHT");

    local icon = button:CreateTexture(nil, "OVERLAY");
    button.icon = icon;
    icon:SetWidth(height);
    icon:SetHeight(height);
    icon:SetPoint("LEFT", button, "LEFT");


    local pullNumber = button:CreateFontString(nil,"OVERLAY", "GameFontNormal")
    pullNumber:SetHeight(14)
    pullNumber:SetJustifyH("CENTER");
    pullNumber:SetPoint("LEFT", button, "LEFT",5,0);

    local title = button:CreateFontString(nil, "OVERLAY", "GameFontNormal");
    button.title = title;
    title:SetHeight(14);
    title:SetJustifyH("LEFT");
    title:SetPoint("TOP", button, "TOP", 0, -2);
    title:SetPoint("LEFT", icon, "RIGHT", 2, 0);
    title:SetPoint("RIGHT", button, "RIGHT");

    button.description = {};

    button:SetScript("OnEnter", function()

    end);
    button:SetScript("OnLeave", function()

    end);






    local renamebox = CreateFrame("EDITBOX", nil, button, "InputBoxTemplate");
    renamebox:SetHeight(height/2);
    renamebox:SetPoint("TOP", button, "TOP");
    renamebox:SetPoint("LEFT", icon, "RIGHT", 6, 0);
    renamebox:SetPoint("RIGHT", button, "RIGHT", -4, 0);
    renamebox:SetFont("Fonts\\FRIZQT__.TTF", 10);
    renamebox:Hide();

    renamebox.func = function() --[[By default, do nothing!]] end;
    renamebox:SetScript("OnEnterPressed", function()
        local oldid = button.title:GetText();
        local newid = renamebox:GetText();
        if(newid == "" or (newid ~= oldid --[[and WeakAuras.GetData(newid)]] )) then
            --if name exists
            renamebox:SetText(button.title:GetText());
        else
            renamebox.func();
            title:SetText(renamebox:GetText());
            title:Show();
            renamebox:Hide();
        end
    end);

    renamebox:SetScript("OnEscapePressed", function()
        title:Show();
        renamebox:Hide();
    end);

    --enemy portraits
    local enemyPortraits = {}

    for i=1,maxPortraitCount do
        enemyPortraits[i] = button:CreateTexture(nil, "BACKGROUND", nil, 2)
        enemyPortraits[i]:SetSize(height-2,height-2)
        if i == 1 then
            enemyPortraits[i]:SetPoint("LEFT",icon,"RIGHT",-5,0)
        else
            enemyPortraits[i]:SetPoint("LEFT",enemyPortraits[i-1],"RIGHT",-2,0)
        end
        enemyPortraits[i]:Hide()
        enemyPortraits[i].overlay = button:CreateTexture(nil, "BACKGROUND", nil, 1)
        enemyPortraits[i].overlay:SetTexture("Interface\\Addons\\MethodDungeonTools\\Textures\\Circle_White")
        enemyPortraits[i].overlay:SetPoint("CENTER",enemyPortraits[i],"CENTER")
        enemyPortraits[i].overlay:SetSize(height+2,height+2)
        enemyPortraits[i].overlay:Hide()

        enemyPortraits[i].fontString = button:CreateFontString(nil,"BACKGROUND",nil)
        enemyPortraits[i].fontString:SetFont("Fonts\\FRIZQT__.TTF", 10,"OUTLINE")
        enemyPortraits[i].fontString:SetTextColor(1, 1, 1, 1);
        enemyPortraits[i].fontString:SetWidth(25)
        enemyPortraits[i].fontString:SetHeight(10)
        enemyPortraits[i].fontString:SetPoint("BOTTOM", enemyPortraits[i], "BOTTOM", 0, 0);
        enemyPortraits[i].fontString:Hide();


    end



    local widget = {
        frame = button,
        title = title,
        icon = icon,
        pullNumber = pullNumber,
        renamebox = renamebox,
        background = background,
        enemyPortraits = enemyPortraits,
        type = Type
    }
    for method, func in pairs(methods) do
        widget[method] = func
    end

    return AceGUI:RegisterAsWidget(widget);
end

AceGUI:RegisterWidgetType(Type, Constructor, Version)
