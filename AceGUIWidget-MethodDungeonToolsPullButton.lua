local Type, Version = "MethodDungeonToolsPullButton", 1
local AceGUI = LibStub and LibStub("AceGUI-3.0", true)

local width,height = 248,32
local maxPortraitCount = 8
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
                offset = (button.frame.height or button.frame:GetHeight() or 32) / 2
                pos = (button.frame:IsMouseOver(2, offset, -dragdrop_overlap, dragdrop_overlap) and "TOP")
                        or (button.frame:IsMouseOver(-offset, -1, -dragdrop_overlap, dragdrop_overlap) and "BOTTOM")
            end
        until not id or pos

        -- Is add new pull hovered?
        if not id then
            local addNewPullButton = MethodDungeonTools.main_frame.sidePanel.newPullButton
            if addNewPullButton.frame:IsMouseOver(2) then
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

        -- Is pull over space between add pull button and
        -- bottom border of the scroll frame?
        local viewheight = scrollFrame.frame.obj.content:GetHeight()
        if not id and viewheight < scrollFrame.frame:GetHeight() then
            if scrollFrame.frame:IsMouseOver(-viewheight, -1, -dragdrop_overlap, dragdrop_overlap) then
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
    if scrollFrame.frame:IsMouseOver(100, scroll_frame_height+1, -dragdrop_overlap, dragdrop_overlap) and scroll_value < scroll_value_min then
        id, button, pos = 1, buttonList[1], "TOP"

        if button.dragging then
            id, button, pos = 2, buttonList[2], "TOP"
        end
    end

    -- Bottom Graceful Area
    if scrollFrame.frame:IsMouseOver(-(scroll_frame_height+1), -100, -dragdrop_overlap, dragdrop_overlap) and scroll_value > scroll_value_max then
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
                if (mouseButton == "LeftButton") then
                    --print("CTRL+MouseButton:Left")

                    if not MethodDungeonTools.U.contains(MethodDungeonTools:GetSelection(), self.index) then
                        tinsert(MethodDungeonTools:GetSelection(), self.index)
                        MethodDungeonTools:SetMapSublevel(self.index)
                        MethodDungeonTools:SetSelectionToPull(MethodDungeonTools:GetSelection())
                        --print(#MethodDungeonTools:GetSelection())
                    else
                        MethodDungeonTools.U.iremove_if(MethodDungeonTools:GetSelection(), function(entry)
                            return entry == self.index
                        end)
                        self:ClearPick()
                        --print(#MethodDungeonTools:GetSelection())
                    end
                end
            elseif(IsShiftKeyDown()) then
                if (mouseButton == "LeftButton") then
                    --print("SHIFT+MouseButton:Left")
                    local selection = MethodDungeonTools:GetSelection()
                    local lastPull = selection[#selection]
                    local step = 1


                    if self.index <= lastPull then
                        step = -1
                    end

                    for i=lastPull, self.index, step do
                        if not MethodDungeonTools.U.contains(selection, i) then
                            tinsert(selection, i)
                        end
                    end

                    MethodDungeonTools:SetMapSublevel(self.index)
                    MethodDungeonTools:SetSelectionToPull(selection)
                    --print(#selection)
                elseif (mouseButton == "RightButton") then
                    local maxPulls = #MethodDungeonTools:GetCurrentPreset().value.pulls
                    if maxPulls>1 then
                        MethodDungeonTools:DeletePull(self.index)
                    end
                end
            else
                MethodDungeonTools:EnsureDBTables()
                if(mouseButton == "RightButton") then
                    -- Add current pull to selection, if not already selected
                    if not MethodDungeonTools.U.contains(MethodDungeonTools:GetSelection(), self.index) then
                        if #MethodDungeonTools:GetSelection() == 1 then
                            MethodDungeonTools:SetSelectionToPull(self.index)
                        else
                            tinsert(MethodDungeonTools:GetSelection(), self.index)
                            self:Pick()
                        end
                    end

                    -- Backup color for every selected pull
                    for _, pullIdx in ipairs(MethodDungeonTools:GetSelection()) do
                        local button = MethodDungeonTools:GetPullButton(pullIdx)
                        if button then
                            button:BackupColor()
                        end
                    end

                    if #MethodDungeonTools:GetSelection() > 1 then
                        L_EasyMenu(self.multiselectMenu,MethodDungeonTools.main_frame.sidePanel.optionsDropDown, "cursor", 0 , -15, "MENU")
                    else
                        MethodDungeonTools:SetMapSublevel(self.index)
                        MethodDungeonTools:SetSelectionToPull(self.index)

                        L_EasyMenu(self.menu,MethodDungeonTools.main_frame.sidePanel.optionsDropDown, "cursor", 0 , -15, "MENU")
                    end

                else
                    --normal click
                    MethodDungeonTools:GetCurrentPreset().value.selection = { self.index }
                    --print(#MethodDungeonTools:GetCurrentPreset().value.selection)
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


        -- Normal Dropdown menu
        self.menu = {}
        if self.index ~= 1 then
            tinsert(self.menu, {
                text = "Move up",
                notCheckable = 1,
                func = function()
                    MethodDungeonTools:MovePullUp(self.index)
                    if MethodDungeonTools.liveSessionActive and MethodDungeonTools:GetCurrentPreset().uid == MethodDungeonTools.livePresetUID then
                        MethodDungeonTools:LiveSession_SendPulls(MethodDungeonTools:GetPulls())
                    end
                end
            })
        end
        if self.index<self.maxPulls then
            tinsert(self.menu, {
                text = "Move down",
                notCheckable = 1,
                func = function()
                    MethodDungeonTools:MovePullDown(self.index)
                    if MethodDungeonTools.liveSessionActive and MethodDungeonTools:GetCurrentPreset().uid == MethodDungeonTools.livePresetUID then
                        MethodDungeonTools:LiveSession_SendPulls(MethodDungeonTools:GetPulls())
                    end
                end
            })
        end
        --[[
        if self.index ~= 1 or self.index < self.maxPulls then
            tinsert(self.menu, {
                text = " ",
                notClickable = 1,
                notCheckable = 1,
                func = nil
            })
        end
        ]]--
        tinsert(self.menu, {
            text = "Insert before",
            notCheckable = 1,
            func = function()
                MethodDungeonTools:PresetsAddPull(self.index)
                MethodDungeonTools:ReloadPullButtons()
                MethodDungeonTools:SetSelectionToPull(self.index)
                --MethodDungeonTools:UpdateAutomaticColors(self.index)
                MethodDungeonTools:ColorAllPulls(_, self.index)
                if MethodDungeonTools.liveSessionActive and MethodDungeonTools:GetCurrentPreset().uid == MethodDungeonTools.livePresetUID then
                    MethodDungeonTools:LiveSession_SendPulls(MethodDungeonTools:GetPulls())
                end
            end
        })

        tinsert(self.menu, {
            text = "Insert after",
            notCheckable = 1,
			func = function()
                MethodDungeonTools:PresetsAddPull(self.index + 1)
                MethodDungeonTools:ReloadPullButtons()
				MethodDungeonTools:SetSelectionToPull(self.index + 1)
                --MethodDungeonTools:UpdateAutomaticColors(self.index + 1)
                MethodDungeonTools:ColorAllPulls(_, self.index+1)
                if MethodDungeonTools.liveSessionActive and MethodDungeonTools:GetCurrentPreset().uid == MethodDungeonTools.livePresetUID then
                    MethodDungeonTools:LiveSession_SendPulls(MethodDungeonTools:GetPulls())
                end
            end
        })
        if self.index ~= 1 then
            tinsert(self.menu, {
                text = "Merge up",
                notCheckable = 1,
                func = function()
                    local newIndex = MethodDungeonTools:PresetsMergePulls(self.index, self.index - 1)
                    MethodDungeonTools:ReloadPullButtons()
                    MethodDungeonTools:SetSelectionToPull(newIndex)
                    --MethodDungeonTools:UpdateAutomaticColors(newIndex)
                    MethodDungeonTools:ColorAllPulls(_, newIndex)
                    if MethodDungeonTools.liveSessionActive and MethodDungeonTools:GetCurrentPreset().uid == MethodDungeonTools.livePresetUID then
                        MethodDungeonTools:LiveSession_SendPulls(MethodDungeonTools:GetPulls())
                    end
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
                    --MethodDungeonTools:UpdateAutomaticColors(newIndex)
                    MethodDungeonTools:ColorAllPulls(_, newIndex)
                    if MethodDungeonTools.liveSessionActive and MethodDungeonTools:GetCurrentPreset().uid == MethodDungeonTools.livePresetUID then
                        MethodDungeonTools:LiveSession_SendPulls(MethodDungeonTools:GetPulls())
                    end
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
            text = "Color Settings",
            notCheckable = 1,
            func = function()
                MethodDungeonTools:OpenAutomaticColorsDialog()
            end
        })
        tinsert(self.menu, {
            text = "Colorize Preset",
            notCheckable = 1,
            func = function()
                local db = MethodDungeonTools:GetDB()
                if not db.colorPaletteInfo.autoColoring then
                    db.colorPaletteInfo.autoColoring = true
                    MethodDungeonTools.main_frame.AutomaticColorsCheck:SetValue(db.colorPaletteInfo.autoColoring)
                    MethodDungeonTools.main_frame.AutomaticColorsCheckSidePanel:SetValue(db.colorPaletteInfo.autoColoring)
                    MethodDungeonTools.main_frame.toggleForceColorBlindMode:SetDisabled(false)
                end
                MethodDungeonTools:SetPresetColorPaletteInfo()
                MethodDungeonTools:ColorAllPulls()
            end
        })
        local function swatchFunc()
            local r,g,b = ColorPickerFrame:GetColorRGB()
            local colorHex = MethodDungeonTools:RGBToHex(r,g,b)
            if colorHex == "228b22" then
                r,g,b = 2*r,2*g,2*b
                ColorPickerFrame:SetColorRGB(r,g,b)
            end

            MethodDungeonTools:DungeonEnemies_SetPullColor(self.index,r,g,b)
            MethodDungeonTools:UpdatePullButtonColor(self.index, r, g, b)
            MethodDungeonTools:DungeonEnemies_UpdateBlipColors(self.index,r,g,b)
            L_CloseDropDownMenus()
            if MethodDungeonTools.liveSessionActive and MethodDungeonTools:GetCurrentPreset().uid == MethodDungeonTools.livePresetUID then
                MethodDungeonTools:LiveSession_QueueColorUpdate()
            end
        end
        local function cancelFunc()
            self:RevertColor()
            MethodDungeonTools:DungeonEnemies_SetPullColor(self.index, self.color.r, self.color.g, self.color.b)
            MethodDungeonTools:UpdatePullButtonColor(self.index, self.color.r, self.color.g, self.color.b)
            MethodDungeonTools:DungeonEnemies_UpdateBlipColors(self.index, self.color.r, self.color.g, self.color.b)
            if MethodDungeonTools.liveSessionActive and MethodDungeonTools:GetCurrentPreset().uid == MethodDungeonTools.livePresetUID then
                MethodDungeonTools:LiveSession_QueueColorUpdate()
            end
        end
        tinsert(self.menu, {
            text = "Color: ",
            notCheckable = 1,
            hasColorSwatch = true,
            r = self.color.r,
            g = self.color.g,
            b = self.color.b,
            func = function()
                ColorPickerFrame.func = swatchFunc
                ColorPickerFrame.opacityFunc = nil
                ColorPickerFrame.cancelFunc = cancelFunc
                ColorPickerFrame:SetColorRGB(self.color.r, self.color.g, self.color.b)
                ColorPickerFrame.hasOpacity = false
                ColorPickerFrame.previousValues = {self.color.r, self.color.g, self.color.b}
                ColorPickerFrame:Hide() -- Need to run the OnShow
                ColorPickerFrame:Show()
                L_CloseDropDownMenus()
            end,
            swatchFunc = swatchFunc,
            cancelFunc = cancelFunc,
        })
        tinsert(self.menu, {
            text = "Reset Color",
            notCheckable = 1,
            func = function()
                local r,g,b = 34/255,139/255,34/255
                MethodDungeonTools:DungeonEnemies_SetPullColor(self.index,r,g,b)
                MethodDungeonTools:UpdatePullButtonColor(self.index, r, g, b)
                MethodDungeonTools:DungeonEnemies_UpdateBlipColors(self.index,r,g,b)
                if MethodDungeonTools.liveSessionActive and MethodDungeonTools:GetCurrentPreset().uid == MethodDungeonTools.livePresetUID then
                    MethodDungeonTools:LiveSession_SendPulls(MethodDungeonTools:GetPulls())
                end
            end
        })
        tinsert(self.menu, {
            text = " ",
            notClickable = 1,
            notCheckable = 1,
            func = nil
        })
        tinsert(self.menu, {
            text = "Clear",
            notCheckable = 1,
            func = function()
				MethodDungeonTools:ClearPull(self.index)
                if MethodDungeonTools.liveSessionActive and MethodDungeonTools:GetCurrentPreset().uid == MethodDungeonTools.livePresetUID then
                    MethodDungeonTools:LiveSession_SendPulls(MethodDungeonTools:GetPulls())
                end
            end
        })
        tinsert(self.menu, {
            text = "Reset Preset",
            notCheckable = 1,
            func = function() MethodDungeonTools:OpenClearPresetDialog() end
        })
        if self.maxPulls > 1 then
            tinsert(self.menu, {
                text = "Delete",
                notCheckable = 1,
                func = function()
                    MethodDungeonTools:DeletePull(self.index)
                    --MethodDungeonTools:UpdateAutomaticColors(self.index)
                    MethodDungeonTools:ColorAllPulls(_, self.index)
                    if MethodDungeonTools.liveSessionActive and MethodDungeonTools:GetCurrentPreset().uid == MethodDungeonTools.livePresetUID then
                        MethodDungeonTools:LiveSession_SendPulls(MethodDungeonTools:GetPulls())
                    end
                end
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
            --func = MethodDungeonTools.main_frame.sidePanel.optionsDropDown:Hide()
            func = nil
        })


        -- Multiselect drop down menu
        self.multiselectMenu = {}
        tinsert(self.multiselectMenu, {
            text = "Insert before",
            notCheckable = 1,
            func = function()
                MethodDungeonTools.U.do_if(MethodDungeonTools:GetSelection(), {
                    condition = function(entry)
                        return entry >= self.index
                    end,
                    update = function(t, key)
                        t[key] = t[key] + 1
                    end
                })
                MethodDungeonTools:PresetsAddPull(self.index)
                MethodDungeonTools:ReloadPullButtons()
                MethodDungeonTools:SetSelectionToPull(self.index)
                --MethodDungeonTools:UpdateAutomaticColors(self.index)
                MethodDungeonTools:ColorAllPulls(_, self.index)
                if MethodDungeonTools.liveSessionActive and MethodDungeonTools:GetCurrentPreset().uid == MethodDungeonTools.livePresetUID then
                    MethodDungeonTools:LiveSession_SendPulls(MethodDungeonTools:GetPulls())
                end
            end
        })

        tinsert(self.multiselectMenu, {
            text = "Insert after",
            notCheckable = 1,
            func = function()
                MethodDungeonTools.U.do_if(MethodDungeonTools:GetSelection(), {
                    condition = function(entry)
                        return entry > self.index
                    end,
                    update = function(t, key)
                        t[key] = t[key] + 1
                    end
                })
                MethodDungeonTools:PresetsAddPull(self.index + 1)
                MethodDungeonTools:ReloadPullButtons()
				MethodDungeonTools:SetSelectionToPull(self.index + 1)
                --MethodDungeonTools:UpdateAutomaticColors(self.index + 1)
                MethodDungeonTools:ColorAllPulls(_, self.index+1)
                if MethodDungeonTools.liveSessionActive and MethodDungeonTools:GetCurrentPreset().uid == MethodDungeonTools.livePresetUID then
                    MethodDungeonTools:LiveSession_SendPulls(MethodDungeonTools:GetPulls())
                end
            end
        })
        tinsert(self.multiselectMenu, {
            text = "Merge",
            notCheckable = 1,
            func = function()
                local selected_pulls = MethodDungeonTools.U.copy(MethodDungeonTools:GetSelection())
                -- Assure, that the destination is always the last selected_pull, to copy it's options at last
                MethodDungeonTools.U.iremove_if(selected_pulls, function(pullIdx)
                    return pullIdx == self.index
                end)

                if not MethodDungeonTools.U.contains(selected_pulls, self.index) then
                    tinsert(selected_pulls, self.index)
                end

                local newIndex = MethodDungeonTools:PresetsMergePulls(selected_pulls, self.index)
                MethodDungeonTools:ReloadPullButtons()
                MethodDungeonTools:GetCurrentPreset().value.selection = { newIndex }
                MethodDungeonTools:SetSelectionToPull(newIndex)
                MethodDungeonTools:ColorAllPulls(_, newIndex)
                if MethodDungeonTools.liveSessionActive and MethodDungeonTools:GetCurrentPreset().uid == MethodDungeonTools.livePresetUID then
                    MethodDungeonTools:LiveSession_SendPulls(MethodDungeonTools:GetPulls())
                end
            end
        })
        tinsert(self.multiselectMenu, {
            text = " ",
            notClickable = 1,
            notCheckable = 1,
            func = nil
        })
        tinsert(self.multiselectMenu, {
            text = "Color Settings",
            notCheckable = 1,
            func = function()
                MethodDungeonTools:OpenAutomaticColorsDialog()
            end
        })
        tinsert(self.multiselectMenu, {
            text = "Colorize Preset",
            notCheckable = 1,
            func = function()
                local db = MethodDungeonTools:GetDB()
                if not db.colorPaletteInfo.autoColoring then
                    db.colorPaletteInfo.autoColoring = true
                    MethodDungeonTools.main_frame.AutomaticColorsCheck:SetValue(db.colorPaletteInfo.autoColoring)
                    MethodDungeonTools.main_frame.AutomaticColorsCheckSidePanel:SetValue(db.colorPaletteInfo.autoColoring)
                    MethodDungeonTools.main_frame.toggleForceColorBlindMode:SetDisabled(false)
                end
                MethodDungeonTools:SetPresetColorPaletteInfo()
                MethodDungeonTools:ColorAllPulls()
            end
        })
        local function swatchMultiFunc()
            local r,g,b = ColorPickerFrame:GetColorRGB()
            local colorHex = MethodDungeonTools:RGBToHex(r,g,b)
            if colorHex == "228b22" then
                r,g,b = 2*r,2*g,2*b
                ColorPickerFrame:SetColorRGB(r,g,b)
            end

            if not MethodDungeonTools.U.contains(MethodDungeonTools:GetSelection(), self.index) then
                tinsert(MethodDungeonTools:GetSelection(), self.index)
                self:Pick()
            end

            for _, pullIdx in ipairs(MethodDungeonTools:GetSelection()) do
                MethodDungeonTools:DungeonEnemies_SetPullColor(pullIdx,r,g,b)
                MethodDungeonTools:UpdatePullButtonColor(pullIdx, r, g, b)
                MethodDungeonTools:DungeonEnemies_UpdateBlipColors(pullIdx,r,g,b)
            end

            L_CloseDropDownMenus()
            if MethodDungeonTools.liveSessionActive and MethodDungeonTools:GetCurrentPreset().uid == MethodDungeonTools.livePresetUID then
                MethodDungeonTools:LiveSession_QueueColorUpdate()
            end
        end
        local function cancelMultiFunc()
            if not MethodDungeonTools.U.contains(MethodDungeonTools:GetSelection(), self.index) then
                tinsert(MethodDungeonTools:GetSelection(), self.index)
                self:Pick()
            end

            for _, pullIdx in ipairs(MethodDungeonTools:GetSelection()) do
                local button = MethodDungeonTools:GetPullButton(pullIdx)
                if button then
                    button:RevertColor()
                    local color = {
                        r = button.color.r,
                        g = button.color.g,
                        b = button.color.b
                    }
                    MethodDungeonTools:DungeonEnemies_SetPullColor(pullIdx, color.r, color.g, color.b)
                    MethodDungeonTools:UpdatePullButtonColor(pullIdx, color.r, color.g, color.b)
                    MethodDungeonTools:DungeonEnemies_UpdateBlipColors(pullIdx, color.r, color.g, color.b)
                end
            end

            self:RevertColor()
            MethodDungeonTools:DungeonEnemies_SetPullColor(self.index, self.color.r, self.color.g, self.color.b)
            MethodDungeonTools:UpdatePullButtonColor(self.index, self.color.r, self.color.g, self.color.b)
            MethodDungeonTools:DungeonEnemies_UpdateBlipColors(self.index, self.color.r, self.color.g, self.color.b)
            if MethodDungeonTools.liveSessionActive and MethodDungeonTools:GetCurrentPreset().uid == MethodDungeonTools.livePresetUID then
                MethodDungeonTools:LiveSession_QueueColorUpdate()
            end
        end
        tinsert(self.multiselectMenu, {
            text = "Color: ",
            notCheckable = 1,
            hasColorSwatch = true,
            r = self.color.r,
            g = self.color.g,
            b = self.color.b,
            func = function()
                ColorPickerFrame.func = swatchMultiFunc
                ColorPickerFrame.opacityFunc = nil
                ColorPickerFrame.cancelFunc = cancelMultiFunc
                ColorPickerFrame:SetColorRGB(self.color.r, self.color.g, self.color.b)
                ColorPickerFrame.hasOpacity = false
                ColorPickerFrame.previousValues = {self.color.r, self.color.g, self.color.b}
                ColorPickerFrame:Hide() -- Need to run the OnShow
                ColorPickerFrame:Show()
                L_CloseDropDownMenus()
            end,
            swatchFunc = swatchMultiFunc,
            cancelFunc = cancelMultiFunc
        })
        tinsert(self.multiselectMenu, {
            text = "Reset Color",
            notCheckable = 1,
            func = function()
                local r,g,b = 34/255,139/255,34/255

                if not MethodDungeonTools.U.contains(MethodDungeonTools:GetSelection(), self.index) then
                    tinsert(MethodDungeonTools:GetSelection(), self.index)
                    self:Pick()
                end

                for _, pullIdx in ipairs(MethodDungeonTools:GetSelection()) do
                    MethodDungeonTools:DungeonEnemies_SetPullColor(pullIdx,r,g,b)
                    MethodDungeonTools:UpdatePullButtonColor(pullIdx, r, g, b)
                    MethodDungeonTools:DungeonEnemies_UpdateBlipColors(pullIdx,r,g,b)
                    L_CloseDropDownMenus()
                end
                if MethodDungeonTools.liveSessionActive and MethodDungeonTools:GetCurrentPreset().uid == MethodDungeonTools.livePresetUID then
                    MethodDungeonTools:LiveSession_SendPulls(MethodDungeonTools:GetPulls())
                end
            end
        })
        if self.index ~= 1 or self.index < self.maxPulls then
            tinsert(self.multiselectMenu, {
                text = " ",
                notClickable = 1,
                notCheckable = 1,
                func = nil
            })
        end
        tinsert(self.multiselectMenu, {
            text = "Clear",
            notCheckable = 1,
            func = function()
                if not MethodDungeonTools.U.contains(MethodDungeonTools:GetSelection(), self.index) then
                    tinsert(MethodDungeonTools:GetSelection(), self.index)
                    self:Pick()
                end

                for _, pullIdx in ipairs(MethodDungeonTools:GetSelection()) do
                    MethodDungeonTools:ClearPull(pullIdx)
                end
                if MethodDungeonTools.liveSessionActive and MethodDungeonTools:GetCurrentPreset().uid == MethodDungeonTools.livePresetUID then
                    MethodDungeonTools:LiveSession_SendPulls(MethodDungeonTools:GetPulls())
                end
            end
        })
        tinsert(self.multiselectMenu, {
            text = "Reset Preset",
            notCheckable = 1,
            func = function() MethodDungeonTools:OpenClearPresetDialog() end
        })
        if self.maxPulls > 1 then
            tinsert(self.multiselectMenu, {
                text = "Delete",
                notCheckable = 1,
                func = function()
                    local addPull = false
                    local button = MethodDungeonTools:GetFirstNotSelectedPullButton(self.index, "UP")
                    if not button then
                        button = MethodDungeonTools:GetFirstNotSelectedPullButton(self.index, "DOWN")
                        if not button then
                            addPull = true
                            button = 1
                        end
                    end

                    local removed_pulls = {}
                    for _, pullIdx in pairs(MethodDungeonTools.GetSelection()) do
                        local offset = MethodDungeonTools.U.count_if(removed_pulls, function(entry)
                            return entry < pullIdx
                        end)

                        MethodDungeonTools:DeletePull(pullIdx - offset)
                        tinsert(removed_pulls, pullIdx)
                    end

                    MethodDungeonTools.GetCurrentPreset().value.selection = {}

                    if not addPull then
                        local offset = MethodDungeonTools.U.count_if(removed_pulls, function(entry)
                            return entry < button
                        end)
                        MethodDungeonTools:SetSelectionToPull(button - offset)
                    else
                        --MethodDungeonTools:AddPull(1) --we handle not deleting all pulls in MethodDungeonTools:DeletePull() instead
                        MethodDungeonTools:SetSelectionToPull(1)
                    end
                    if MethodDungeonTools.liveSessionActive and MethodDungeonTools:GetCurrentPreset().uid == MethodDungeonTools.livePresetUID then
                        MethodDungeonTools:LiveSession_SendPulls(MethodDungeonTools:GetPulls())
                    end
                end
            })
        end
        tinsert(self.multiselectMenu, {
            text = " ",
            notClickable = 1,
            notCheckable = 1,
            func = nil
        })

        tinsert(self.multiselectMenu, {
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

        self:InitializeScrollHover()
    end,
    ["InitializeScrollHover"] = function(self)
        local scrollFrame = MethodDungeonTools.main_frame.sidePanel.pullButtonsScrollFrame
        local height = (scrollFrame.frame.height or scrollFrame.frame:GetHeight())

        self.scroll_hover = {
            height = 100,
            offset = 20,
            timeout = 0.05,
            pulls_per_second = {
                min = 2.5,
                max = 15
            },
            top = {},
            bottom = {}
        }

        -- Top
        tinsert(self.scroll_hover.top, {
            speed = 0.20,
            mouseover = {
                top = ((self.scroll_hover.height + self.scroll_hover.offset) / 5) - self.scroll_hover.offset,
                bottom = height - self.scroll_hover.offset,
                left = -dragdrop_overlap,
                right = dragdrop_overlap
            }
        })
        tinsert(self.scroll_hover.top, {
            speed = 0.4,
            mouseover = {
                top = 2 * ((self.scroll_hover.height + self.scroll_hover.offset) / 5) - self.scroll_hover.offset,
                bottom = height - self.scroll_hover.offset,
                left = -dragdrop_overlap,
                right = dragdrop_overlap
            }
        })
        tinsert(self.scroll_hover.top, {
            speed = 0.6,
            mouseover = {
                top = 3 * ((self.scroll_hover.height + self.scroll_hover.offset) / 5) - self.scroll_hover.offset,
                bottom = height - self.scroll_hover.offset,
                left = -dragdrop_overlap,
                right = dragdrop_overlap
            }
        })
        tinsert(self.scroll_hover.top, {
            speed = 0.8,
            mouseover = {
                top = 4 * ((self.scroll_hover.height + self.scroll_hover.offset) / 5) - self.scroll_hover.offset,
                bottom = height - self.scroll_hover.offset,
                left = -dragdrop_overlap,
                right = dragdrop_overlap
            }
        })

        -- Bottom
        tinsert(self.scroll_hover.bottom, {
            speed = 0.2,
            mouseover = {
                top  = self.scroll_hover.offset - height,
                bottom = (-(self.scroll_hover.height + self.scroll_hover.offset) / 5) + self.scroll_hover.offset,
                left = -dragdrop_overlap,
                right = dragdrop_overlap
            }
        })
        tinsert(self.scroll_hover.bottom, {
            speed = 0.4,
            mouseover = {
                top  = self.scroll_hover.offset - height,
                bottom = 2 * (-(self.scroll_hover.height + self.scroll_hover.offset) / 5) + self.scroll_hover.offset,
                left = -dragdrop_overlap,
                right = dragdrop_overlap
            }
        })
        tinsert(self.scroll_hover.bottom, {
            speed = 0.6,
            mouseover = {
                top  = self.scroll_hover.offset - height,
                bottom = 3 * (-(self.scroll_hover.height + self.scroll_hover.offset) / 5) + self.scroll_hover.offset,
                left = -dragdrop_overlap,
                right = dragdrop_overlap
            }
        })
        tinsert(self.scroll_hover.bottom, {
            speed = 0.8,
            mouseover = {
                top  = self.scroll_hover.offset - height,
                bottom = 4 * (-(self.scroll_hover.height + self.scroll_hover.offset) / 5) + self.scroll_hover.offset,
                left = -dragdrop_overlap,
                right = dragdrop_overlap
            }
        })
    end,
    ["GetScrollSpeed"] = function(self, frame, speedList)
        for index, entry in ipairs(speedList) do
            local m = entry.mouseover
            if frame:IsMouseOver(m.top, m.bottom, m.left, m.right) then
                return entry.speed
            end
        end

        return 1
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

                    local scroll_hover = self.scroll_hover
                    local scrollFrame = MethodDungeonTools.main_frame.sidePanel.pullButtonsScrollFrame
                    local height = (scrollFrame.frame.height or scrollFrame.frame:GetHeight())


                    if scrollFrame.frame:IsMouseOver(scroll_hover.height, height - scroll_hover.offset, -dragdrop_overlap, dragdrop_overlap) then
                        self.top_hover = (self.top_hover or 0) + elapsed
                        self.bottom_hover = 0

                        if self.top_hover > scroll_hover.timeout then
                            local scroll_speed = self:GetScrollSpeed(scrollFrame.frame, scroll_hover.top)
                            local scroll_pulls = MethodDungeonTools.U.lerp(scroll_hover.pulls_per_second.min, scroll_hover.pulls_per_second.max, scroll_speed)
                            local scroll_pixel = scroll_pulls * self.frame:GetHeight()
                            local scroll_amount = MethodDungeonTools:GetScrollingAmount(scrollFrame, scroll_pixel) * scroll_hover.timeout

                            local oldvalue = scrollFrame.localstatus.scrollvalue
                            local newvalue = oldvalue - scroll_amount
                            if newvalue < 0 then
                                newvalue = 0
                            end
                            scrollFrame.scrollframe.obj:SetScroll(newvalue)
                            scrollFrame.scrollframe.obj:FixScroll()
                            self.top_hover = 0
                        end
                    elseif scrollFrame.frame:IsMouseOver(scroll_hover.offset - height , -scroll_hover.height, -dragdrop_overlap, dragdrop_overlap) then
                        self.bottom_hover = (self.bottom_hover or 0) + elapsed
                        self.top_hover = 0

                        if self.bottom_hover > scroll_hover.timeout then
                            local scroll_speed = self:GetScrollSpeed(scrollFrame.frame, scroll_hover.bottom)
                            local scroll_pulls = MethodDungeonTools.U.lerp(scroll_hover.pulls_per_second.min, scroll_hover.pulls_per_second.max, scroll_speed)
                            local scroll_pixel = scroll_pulls * self.frame:GetHeight()
                            local scroll_amount = MethodDungeonTools:GetScrollingAmount(scrollFrame, scroll_pixel) * scroll_hover.timeout

                            local oldvalue = scrollFrame.localstatus.scrollvalue
                            local newvalue = oldvalue + scroll_amount
                            if newvalue > 1000 then
                                newvalue = 1000
                            end
                            scrollFrame.scrollframe.obj:SetScroll(newvalue)
                            scrollFrame.scrollframe.obj:FixScroll()

                            -- if FixScroll() messed up
                            if scrollFrame.localstatus.scrollvalue == oldvalue and newvalue >= 0 and newvalue <= 1000 and oldvalue < 985 then
                                scrollFrame.scrollframe.obj.scrollbar:SetValue(newvalue)
                                scrollFrame.scrollframe.obj:SetScroll(newvalue)
                            end

                            self.bottom_hover = 0
                        end
                    else
                        self.top_hover = 0
                        self.bottom_hover = 0
                    end

                    self.elapsed = (self.elapsed or 0) + elapsed
                    if self.elapsed > 0.1 then
                        local button, pos = select(2, GetDropTarget())
                        --print("Updating", self.index)
                        MethodDungeonTools:Show_DropIndicator(button, pos)
                        self.elapsed = 0
                    end
                end
            end
        end

        return self.updateFunction
    end,
    ["Drag"] = function(self)
        local sidePanel = MethodDungeonTools.main_frame.sidePanel
        local uiscale, scale = UIParent:GetScale(), self.frame:GetEffectiveScale()
        local x, w = self.frame:GetLeft(), self.frame:GetWidth()
        local _, y = GetCursorPosition()

        MethodDungeonTools.pullTooltip:Hide()

        if #MethodDungeonTools:GetSelection() > 1 then
            if not MethodDungeonTools.U.contains(MethodDungeonTools:GetSelection(), self.index) then
                for _, pullIdx in pairs(MethodDungeonTools:GetSelection()) do
                    sidePanel.newPullButtons[pullIdx]:ClearPick()
                end

                MethodDungeonTools:GetCurrentPreset().value.currentPull = self.index
                MethodDungeonTools:GetCurrentPreset().value.selection = { self.index }
                self:Pick()
            end

            local selected_pulls = MethodDungeonTools.U.copy(MethodDungeonTools:GetSelection())
            table.sort(selected_pulls)

            for _, pullIdx in ipairs(selected_pulls) do
                if pullIdx ~= self.index then
                    sidePanel.newPullButtons[pullIdx]:Disable()
                    sidePanel.newPullButtons[pullIdx].dragging = true
                end
            end

        end

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

        if #MethodDungeonTools:GetSelection() > 1 then
            local sidePanel = MethodDungeonTools.main_frame.sidePanel
            local selected_pulls = MethodDungeonTools.U.copy(MethodDungeonTools:GetSelection())
            local new_pulls = {}
            local progressed_pulls = {}
            table.sort(selected_pulls)

            for _, pullIdx in ipairs(selected_pulls) do
                sidePanel.newPullButtons[pullIdx].dragging = false
                self.dragging = false
            end

            --print("insert id", insertID)
            for offset, pullIdx in ipairs(selected_pulls) do
                --print("offset", offset, "pull", pullIdx)

                local pos = insertID + (offset - 1)
                --print("pos", pos)

                local progressed_above = MethodDungeonTools.U.count_if(progressed_pulls, function(entry)
                    return entry < pos
                end)
                --print("progressed above", progressed_above)

                pos = pos - progressed_above
                --print("pos", pos)

                local correctPullIndex = pullIdx
                --print("correctPullIndex", correctPullIndex)
                if pos > correctPullIndex then
                    correctPullIndex = correctPullIndex - MethodDungeonTools.U.count_if(progressed_pulls, function(entry)
                        return entry < correctPullIndex
                    end)
                    --print("correctPullIndex", correctPullIndex)
                end

                if pos <= correctPullIndex then
                    correctPullIndex = correctPullIndex + 1
                end
                --print("correctPullIndex", correctPullIndex)

                MethodDungeonTools:PresetsAddPull(pos)
                MethodDungeonTools:CopyPullOptions(correctPullIndex, pos)
                local newID =  MethodDungeonTools:PresetsMergePulls(correctPullIndex, pos)
                --print("newID", newID)

                tinsert(progressed_pulls, pullIdx)
                tinsert(new_pulls, newID)
            end

            MethodDungeonTools:GetCurrentPreset().value.selection = new_pulls
            MethodDungeonTools:ReloadPullButtons()
            MethodDungeonTools:SetSelectionToPull(1)
        else
            local index = self.index
            if index > insertID then
                index = index + 1
            end

            MethodDungeonTools:PresetsAddPull(insertID)
            MethodDungeonTools:CopyPullOptions(index, insertID)
            local newIndex = MethodDungeonTools:PresetsMergePulls(index, insertID)
            MethodDungeonTools:ReloadPullButtons()
            MethodDungeonTools:SetSelectionToPull(newIndex)
		end
		
		MethodDungeonTools:Hide_DropIndicator()
		--MethodDungeonTools:UpdateAutomaticColors(math.min(self.index, insertID))
        MethodDungeonTools:ColorAllPulls(_, math.min(self.index, insertID))
        MethodDungeonTools.pullTooltip:Show()
        if MethodDungeonTools.liveSessionActive and MethodDungeonTools:GetCurrentPreset().uid == MethodDungeonTools.livePresetUID then
            MethodDungeonTools:LiveSession_SendPulls(MethodDungeonTools:GetPulls())
        end
    end,
    ["Disable"] = function(self)
        self.background:Hide();
        self.frame:Disable();

        for k,v in pairs(self.enemyPortraits) do
            v:Hide()
            v.overlay:Hide()
            v.fontString:Hide()
        end
    end,
    ["Enable"] = function(self)
        self.background:Show();
        self.frame:Enable();
    end,
    ["Pick"] = function(self)
        self.frame:LockHighlight();
        self.frame.pickedGlow:Show()
    end,
    ["ClearPick"] = function(self)
        self.frame:UnlockHighlight();
        self.frame.pickedGlow:Hide()
    end,
    ["SetIndex"] = function(self, index)
        self.index = index
        --set custom pull color
        self.color.r,self.color.g,self.color.b = MethodDungeonTools:DungeonEnemies_GetPullColor(self.index)
        self:UpdateColor()
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
            self.enemyPortraits[idx].fontString:SetText("x"..data.quantity)
            self.enemyPortraits[idx].fontString:Show()
        end
    end,
    ["ShowReapingIcon"] = function(self,show,currentPercent,oldPercent)
        --set percentage here
        self.percentageFontString:Show()
        local perc = string.format("%.1f%%",currentPercent*100)
        if show  then
            self.reapingIcon:Show()
            self.reapingIcon.overlay:Show()
            perc = "|cFF00FF00"..perc

            local currentReaps = math.floor(currentPercent/0.2)
            local oldReaps = math.floor(oldPercent/0.2)
            local reapings = math.min(5,currentReaps-oldReaps)

            if reapings>1 then
                self.multiReapingFontString:SetText(reapings.."x")
                self.multiReapingFontString:Show()
            else
                self.multiReapingFontString:Hide()
            end
        else
            self.reapingIcon:Hide()
            self.reapingIcon.overlay:Hide()
            self.multiReapingFontString:Hide()
            perc = "|cFFFFFFFF"..perc
        end
        local pullForces = MethodDungeonTools:CountForces(self.index,true)
        if pullForces>0 then
            self.percentageFontString:SetText(perc)
            self.percentageFontString:Show()
        else
            self.percentageFontString:Hide()
        end
    end,
    ["UpdateColor"] = function(self)
        local colorHex = MethodDungeonTools:RGBToHex(self.color.r,self.color.g,self.color.b)
        local db = MethodDungeonTools:GetDB()
        if colorHex == db.defaultColor then
            self.background:SetVertexColor(0.5,0.5,0.5,0.25)
            self.frame.pickedGlow:SetVertexColor(1,0.85,0,1)
        else
            self.background:SetVertexColor(self.color.r,self.color.g,self.color.b, 0.75)
            self.frame.pickedGlow:SetVertexColor(self.color.r,self.color.g,self.color.b, 0.75)
        end
    end,
    ["BackupColor"] = function(self)
        -- Explicitly copy values, to avoid storing a reference
        self.colorBackup = {
            r = self.color.r,
            g = self.color.g,
            b = self.color.b
        }
    end,
    ["RevertColor"] = function(self)
        -- Explicitly copy values, to avoid storing a reference
        self.color = {
            r = self.colorBackup.r,
            g = self.colorBackup.g,
            b = self.colorBackup.b
        }
    end
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

    local pickedGlow = button:CreateTexture(nil, "OVERLAY")
    button.pickedGlow = pickedGlow
    --["heartofazeroth-list-item-selected"] = {356, 82, 0.779297, 0.953125, 0.653809, 0.693848, false, false},
    pickedGlow:SetTexture("Interface\\AddOns\\MethodDungeonTools\\Textures\\HeartOfAzerothSelection")
    pickedGlow:SetTexCoord(0, 0.697265625, 0, 0.625)
    pickedGlow:SetAllPoints(button)
    pickedGlow:Hide()

    button.highlight:SetVertexColor(1,1,1,0.5)

    local pullNumber = button:CreateFontString(nil,"OVERLAY", "GameFontNormal")
    pullNumber:SetHeight(14)
    pullNumber:SetJustifyH("CENTER");
    pullNumber:SetPoint("LEFT", button, "LEFT",5,0);

    button:SetScript("OnEnter", function()

    end);
    button:SetScript("OnLeave", function()

    end);

    --enemy portraits
    local enemyPortraits = {}
    local portraitSize = height-9
    for i=1,maxPortraitCount do
        enemyPortraits[i] = button:CreateTexture(nil, "BACKGROUND", nil, 2)
        enemyPortraits[i]:SetSize(portraitSize,portraitSize)
        if i == 1 then
            enemyPortraits[i]:SetPoint("LEFT", button, "LEFT",portraitSize,0)
        else
            enemyPortraits[i]:SetPoint("LEFT",enemyPortraits[i-1],"RIGHT",-2,0)
        end
        enemyPortraits[i]:Hide()
        enemyPortraits[i].overlay = button:CreateTexture(nil, "BACKGROUND", nil, 1)
        enemyPortraits[i].overlay:SetTexture("Interface\\Addons\\MethodDungeonTools\\Textures\\Circle_White")
        enemyPortraits[i].overlay:SetVertexColor(0.7,0.7,0.7)
        enemyPortraits[i].overlay:SetPoint("CENTER",enemyPortraits[i],"CENTER")
        enemyPortraits[i].overlay:SetSize(portraitSize+3,portraitSize+3)
        enemyPortraits[i].overlay:Hide()

        enemyPortraits[i].fontString = button:CreateFontString(nil,"BACKGROUND",nil)
        enemyPortraits[i].fontString:SetFont("Fonts\\FRIZQT__.TTF", 10,"OUTLINE")
        enemyPortraits[i].fontString:SetTextColor(1, 1, 1, 1);
        enemyPortraits[i].fontString:SetWidth(25)
        enemyPortraits[i].fontString:SetHeight(10)
        enemyPortraits[i].fontString:SetPoint("BOTTOM", enemyPortraits[i], "BOTTOM", 0, 0)
        enemyPortraits[i].fontString:Hide()

    end

    --reaping icon
    local reapingIcon = button:CreateTexture(nil, "BACKGROUND", nil, 2)
    reapingIcon:SetSize(height-2,height-2)
    reapingIcon:SetPoint("RIGHT", button, "RIGHT",-10,0)
    reapingIcon:SetAlpha(1)
    SetPortraitToTexture(reapingIcon,"Interface\\Icons\\ability_racial_embraceoftheloa_bwonsomdi")
    reapingIcon:Hide()
    reapingIcon.overlay = button:CreateTexture(nil, "BACKGROUND", nil, 1)
    reapingIcon.overlay:SetTexture("Interface\\Addons\\MethodDungeonTools\\Textures\\Circle_White")
    reapingIcon.overlay:SetVertexColor(0.7,0.7,0.7)
    reapingIcon.overlay:SetPoint("CENTER",reapingIcon,"CENTER")
    reapingIcon.overlay:SetSize(height+1,height+1)
    reapingIcon.overlay:Hide()

    --pull percentage
    local percentageFontString = button:CreateFontString(nil,"BACKGROUND",nil)
    percentageFontString:SetFont(MethodDungeonTools.tooltip.String:GetFont(),12)
    percentageFontString:SetTextColor(1, 1, 1, 1);
    percentageFontString:SetWidth(50)
    percentageFontString:SetHeight(10)
    percentageFontString:SetPoint("RIGHT", button, "RIGHT",2,0)
    percentageFontString:Hide()

    --multiple reaping wave indicator
    local multiReapingFontString = button:CreateFontString(nil,"BACKGROUND",nil)
    multiReapingFontString:SetFont("Fonts\\FRIZQT__.TTF", 10,"OUTLINE")
    multiReapingFontString:SetTextColor(1, 1, 1, 1);
    multiReapingFontString:SetWidth(50)
    multiReapingFontString:SetHeight(10)
    multiReapingFontString:SetPoint("RIGHT", button, "RIGHT",1,-12)
    multiReapingFontString:Hide()

    --custom colors
    local color = {}

    local widget = {
        frame = button,
        pullNumber = pullNumber,
        background = background,
        enemyPortraits = enemyPortraits,
        reapingIcon = reapingIcon,
        percentageFontString = percentageFontString,
        multiReapingFontString = multiReapingFontString,
        color = color,
        type = Type
    }
    for method, func in pairs(methods) do
        widget[method] = func
    end

    return AceGUI:RegisterAsWidget(widget);
end

AceGUI:RegisterWidgetType(Type, Constructor, Version)
