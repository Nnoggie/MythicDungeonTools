local Type, Version = "MDTPullButton", 1
local AceGUI = LibStub and LibStub("AceGUI-3.0", true)
local MDT = MDT
local L = MDT.L


local width,height = 248,32
local maxPortraitCount = 7
local tinsert,SetPortraitToTexture,SetPortraitTextureFromCreatureDisplayID,GetItemQualityColor,MouseIsOver = table.insert,SetPortraitToTexture,SetPortraitTextureFromCreatureDisplayID,GetItemQualityColor,MouseIsOver
local next = next

local dragdrop_overlap = 2000

local function GetDropTarget()
    local scrollFrame = MDT.main_frame.sidePanel.pullButtonsScrollFrame
    local buttonList = MDT.main_frame.sidePanel.newPullButtons
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
            local addNewPullButton = MDT.main_frame.sidePanel.newPullButton
            if addNewPullButton.frame:IsMouseOver(2) then
                local maxPulls = #MDT:GetCurrentPreset().value.pulls
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
                local maxPulls = #MDT:GetCurrentPreset().value.pulls
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
        local maxPulls = #MDT:GetCurrentPreset().value.pulls
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
            if not MouseIsOver(MDT.main_frame.sidePanel.pullButtonsScrollFrame.frame) then return end

            if(IsControlKeyDown())then
                if (mouseButton == "LeftButton") then
                    --print("CTRL+MouseButton:Left")

                    if not MDT.U.contains(MDT:GetSelection(), self.index) then
                        tinsert(MDT:GetSelection(), self.index)
                        MDT:SetMapSublevel(self.index)
                        MDT:SetSelectionToPull(MDT:GetSelection())
                    else
                        MDT.U.iremove_if(MDT:GetSelection(), function(entry)
                            return entry == self.index
                        end)
                        self:ClearPick()
                    end
                end
            elseif(IsShiftKeyDown()) then
                if (mouseButton == "LeftButton") then
                    --print("SHIFT+MouseButton:Left")
                    local selection = MDT:GetSelection()
                    local lastPull = selection[#selection]
                    local step = 1


                    if self.index <= lastPull then
                        step = -1
                    end

                    for i=lastPull, self.index, step do
                        if not MDT.U.contains(selection, i) then
                            tinsert(selection, i)
                        end
                    end

                    MDT:SetMapSublevel(self.index)
                    MDT:SetSelectionToPull(selection)
                    --print(#selection)
                elseif (mouseButton == "RightButton") then
                    local maxPulls = #MDT:GetCurrentPreset().value.pulls
                    if maxPulls>1 then
                        MDT:DeletePull(self.index)
                    end
                end
            else
                MDT:EnsureDBTables()
                if(mouseButton == "RightButton") then
                    -- Add current pull to selection, if not already selected
                    if not MDT.U.contains(MDT:GetSelection(), self.index) then
                        if #MDT:GetSelection() == 1 then
                            MDT:SetSelectionToPull(self.index)
                        else
                            tinsert(MDT:GetSelection(), self.index)
                            self:Pick()
                        end
                    end

                    -- Backup color for every selected pull
                    for _, pullIdx in ipairs(MDT:GetSelection()) do
                        local button = MDT:GetPullButton(pullIdx)
                        if button then
                            button:BackupColor()
                        end
                    end

                    if #MDT:GetSelection() > 1 then
                        L_EasyMenu(self.multiselectMenu, MDT.main_frame.sidePanel.optionsDropDown, "cursor", 0 , -15, "MENU")
                    else
                        MDT:SetMapSublevel(self.index)
                        MDT:SetSelectionToPull(self.index)

                        L_EasyMenu(self.menu, MDT.main_frame.sidePanel.optionsDropDown, "cursor", 0 , -15, "MENU")
                    end

                else
                    --normal click
                    MDT:GetCurrentPreset().value.selection = { self.index }
                    MDT:SetMapSublevel(self.index)
                    MDT:SetSelectionToPull(self.index)
                end
            end
        end

        function self.callbacks.OnEnter()
            MDT.pullTooltip:SetPoint("TOPRIGHT",self.frame,"TOPLEFT",0,0)
            MDT.pullTooltip:SetPoint("BOTTOMRIGHT",self.frame,"TOPLEFT",-250,-(4+ MDT.pullTooltip.myHeight))
            local tooltipBottom = MDT.pullTooltip:GetBottom()
            local mainFrameBottom = MDT.main_frame:GetBottom()
            if tooltipBottom<mainFrameBottom then
                MDT.pullTooltip:SetPoint("TOPRIGHT",self.frame,"BOTTOMLEFT",0,(4+ MDT.pullTooltip.myHeight))
                MDT.pullTooltip:SetPoint("BOTTOMRIGHT",self.frame,"BOTTOMLEFT",-250,-4)
            end
            self.entered = true
            MDT:ActivatePullTooltip(self.index)
            self.frame:SetScript("OnUpdate", self:CreateUpdateFunction())
            --progressbar
            if MDT.ProgressBarResetTimer then MDT.ProgressBarResetTimer:Cancel() end
            local currentForces = MDT:CountForces(self.index)
            local db = MDT:GetDB()
            local teeming = MDT:IsCurrentPresetTeeming()
            MDT:Progressbar_SetValue(MDT.main_frame.sidePanel.ProgressBar,currentForces,teeming and MDT.dungeonTotalCount[db.currentDungeonIdx].teeming or MDT.dungeonTotalCount[db.currentDungeonIdx].normal)
        end

        function self.callbacks.OnLeave()
            MDT.pullTooltip.Model:Hide()
            MDT.pullTooltip.topString:Hide()
            self.entered = false
            self.frame:SetScript("OnUpdate", nil)
            MDT:UpdatePullTooltip(MDT.pullTooltip)
            MDT.pullTooltip:Hide()
            MDT.ProgressBarResetTimer = C_Timer.NewTimer(0.35, function()
                MDT:UpdateProgressbar()
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
                text = L["Pull Drop Move up"],
                notCheckable = 1,
                func = function()
                    MDT:MovePullUp(self.index)
                    if MDT.liveSessionActive and MDT:GetCurrentPreset().uid == MDT.livePresetUID then
                        MDT:LiveSession_SendPulls(MDT:GetPulls())
                    end
                end
            })
        end
        if self.index<self.maxPulls then
            tinsert(self.menu, {
                text = L["Pull Drop Move down"],
                notCheckable = 1,
                func = function()
                    MDT:MovePullDown(self.index)
                    if MDT.liveSessionActive and MDT:GetCurrentPreset().uid == MDT.livePresetUID then
                        MDT:LiveSession_SendPulls(MDT:GetPulls())
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
            text = L["Pull Drop Insert before"],
            notCheckable = 1,
            func = function()
                MDT:PresetsAddPull(self.index)
                MDT:ReloadPullButtons()
                MDT:SetSelectionToPull(self.index)
                MDT:ColorAllPulls(_, self.index)
                if MDT.liveSessionActive and MDT:GetCurrentPreset().uid == MDT.livePresetUID then
                    MDT:LiveSession_SendPulls(MDT:GetPulls())
                end
                MDT:DrawAllHulls()
            end
        })

        tinsert(self.menu, {
            text = L["Pull Drop Insert after"],
            notCheckable = 1,
			func = function()
                MDT:PresetsAddPull(self.index + 1)
                MDT:ReloadPullButtons()
				MDT:SetSelectionToPull(self.index + 1)
                MDT:ColorAllPulls(_, self.index+1)
                if MDT.liveSessionActive and MDT:GetCurrentPreset().uid == MDT.livePresetUID then
                    MDT:LiveSession_SendPulls(MDT:GetPulls())
                end
                MDT:DrawAllHulls()
            end
        })
        if self.index ~= 1 then
            tinsert(self.menu, {
                text = L["Pull Drop Merge up"],
                notCheckable = 1,
                func = function()
                    local newIndex = MDT:PresetsMergePulls(self.index, self.index - 1)
                    MDT:ReloadPullButtons()
                    MDT:SetSelectionToPull(newIndex)
                    MDT:ColorAllPulls(_, newIndex)
                    if MDT.liveSessionActive and MDT:GetCurrentPreset().uid == MDT.livePresetUID then
                        MDT:LiveSession_SendPulls(MDT:GetPulls())
                    end
                    MDT:DrawAllHulls()
                end
            })
        end
        if self.index < self.maxPulls then
            tinsert(self.menu, {
                text = L["Pull Drop Merge down"],
                notCheckable = 1,
                func = function()
                    local newIndex = MDT:PresetsMergePulls(self.index, self.index + 1)
                    MDT:ReloadPullButtons()
                    MDT:SetSelectionToPull(newIndex)
                    MDT:ColorAllPulls(_, newIndex)
                    if MDT.liveSessionActive and MDT:GetCurrentPreset().uid == MDT.livePresetUID then
                        MDT:LiveSession_SendPulls(MDT:GetPulls())
                    end
                    MDT:DrawAllHulls()
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
            text = L["Pull Drop Color Settings"],
            notCheckable = 1,
            func = function()
                MDT:OpenAutomaticColorsDialog()
            end
        })
        tinsert(self.menu, {
            text = L["Pull Drop Colorize Preset"],
            notCheckable = 1,
            func = function()
                local db = MDT:GetDB()
                if not db.colorPaletteInfo.autoColoring then
                    db.colorPaletteInfo.autoColoring = true
                    MDT.main_frame.AutomaticColorsCheck:SetValue(db.colorPaletteInfo.autoColoring)
                    MDT.main_frame.AutomaticColorsCheckSidePanel:SetValue(db.colorPaletteInfo.autoColoring)
                    MDT.main_frame.toggleForceColorBlindMode:SetDisabled(false)
                end
                MDT:SetPresetColorPaletteInfo()
                MDT:ColorAllPulls()
                MDT:DrawAllHulls()
            end
        })
        local function swatchFunc()
            local r,g,b = ColorPickerFrame:GetColorRGB()
            local colorHex = MDT:RGBToHex(r,g,b)
            if colorHex == "228b22" then
                r,g,b = 2*r,2*g,2*b
                ColorPickerFrame:SetColorRGB(r,g,b)
            end

            MDT:DungeonEnemies_SetPullColor(self.index,r,g,b)
            MDT:UpdatePullButtonColor(self.index, r, g, b)
            MDT:DungeonEnemies_UpdateBlipColors(self.index,r,g,b)
            MDT:DrawAllHulls()
            L_CloseDropDownMenus()
            if MDT.liveSessionActive and MDT:GetCurrentPreset().uid == MDT.livePresetUID then
                MDT:LiveSession_QueueColorUpdate()
            end
        end
        local function cancelFunc()
            self:RevertColor()
            MDT:DungeonEnemies_SetPullColor(self.index, self.color.r, self.color.g, self.color.b)
            MDT:UpdatePullButtonColor(self.index, self.color.r, self.color.g, self.color.b)
            MDT:DungeonEnemies_UpdateBlipColors(self.index, self.color.r, self.color.g, self.color.b)
            MDT:DrawAllHulls()
            if MDT.liveSessionActive and MDT:GetCurrentPreset().uid == MDT.livePresetUID then
                MDT:LiveSession_QueueColorUpdate()
            end
        end
        tinsert(self.menu, {
            text = L["Pull Drop Color"]..": ",
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
            text = L["Pull Drop Reset Color"],
            notCheckable = 1,
            func = function()
                local r,g,b = 34/255,139/255,34/255
                MDT:DungeonEnemies_SetPullColor(self.index,r,g,b)
                MDT:UpdatePullButtonColor(self.index, r, g, b)
                MDT:DungeonEnemies_UpdateBlipColors(self.index,r,g,b)
                MDT:DrawAllHulls()
                if MDT.liveSessionActive and MDT:GetCurrentPreset().uid == MDT.livePresetUID then
                    MDT:LiveSession_SendPulls(MDT:GetPulls())
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
            text = L["Pull Drop Clear Pull"],
            notCheckable = 1,
            func = function()
				MDT:ClearPull(self.index)
                if MDT.liveSessionActive and MDT:GetCurrentPreset().uid == MDT.livePresetUID then
                    MDT:LiveSession_SendPulls(MDT:GetPulls())
                end
            end
        })
        tinsert(self.menu, {
            text = L["Pull Drop Reset Preset"],
            notCheckable = 1,
            func = function() MDT:OpenClearPresetDialog() end
        })
        if self.maxPulls > 1 then
            tinsert(self.menu, {
                text = L["Pull Drop Delete"],
                notCheckable = 1,
                func = function()
                    MDT:DeletePull(self.index)
                    MDT:ColorAllPulls(_, self.index)
                    if MDT.liveSessionActive and MDT:GetCurrentPreset().uid == MDT.livePresetUID then
                        MDT:LiveSession_SendPulls(MDT:GetPulls())
                    end
                    MDT:DrawAllHulls()
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
            text = L["Pull Drop Close"],
            notCheckable = 1,
            --func = MDT.main_frame.sidePanel.optionsDropDown:Hide()
            func = nil
        })


        -- Multiselect drop down menu
        self.multiselectMenu = {}
        tinsert(self.multiselectMenu, {
            text = L["Pull Drop Insert before"],
            notCheckable = 1,
            func = function()
                MDT.U.do_if(MDT:GetSelection(), {
                    condition = function(entry)
                        return entry >= self.index
                    end,
                    update = function(t, key)
                        t[key] = t[key] + 1
                    end
                })
                MDT:PresetsAddPull(self.index)
                MDT:ReloadPullButtons()
                MDT:SetSelectionToPull(self.index)
                --MDT:UpdateAutomaticColors(self.index)
                MDT:ColorAllPulls(_, self.index)
                if MDT.liveSessionActive and MDT:GetCurrentPreset().uid == MDT.livePresetUID then
                    MDT:LiveSession_SendPulls(MDT:GetPulls())
                end
                MDT:DrawAllHulls()
            end
        })

        tinsert(self.multiselectMenu, {
            text = L["Pull Drop Insert after"],
            notCheckable = 1,
            func = function()
                MDT.U.do_if(MDT:GetSelection(), {
                    condition = function(entry)
                        return entry > self.index
                    end,
                    update = function(t, key)
                        t[key] = t[key] + 1
                    end
                })
                MDT:PresetsAddPull(self.index + 1)
                MDT:ReloadPullButtons()
				MDT:SetSelectionToPull(self.index + 1)
                --MDT:UpdateAutomaticColors(self.index + 1)
                MDT:ColorAllPulls(_, self.index+1)
                if MDT.liveSessionActive and MDT:GetCurrentPreset().uid == MDT.livePresetUID then
                    MDT:LiveSession_SendPulls(MDT:GetPulls())
                end
                MDT:DrawAllHulls()
            end
        })
        tinsert(self.multiselectMenu, {
            text = L["Pull Drop Merge"],
            notCheckable = 1,
            func = function()
                local selected_pulls = MDT.U.copy(MDT:GetSelection())
                -- Assure, that the destination is always the last selected_pull, to copy it's options at last
                MDT.U.iremove_if(selected_pulls, function(pullIdx)
                    return pullIdx == self.index
                end)

                if not MDT.U.contains(selected_pulls, self.index) then
                    tinsert(selected_pulls, self.index)
                end

                local newIndex = MDT:PresetsMergePulls(selected_pulls, self.index)
                MDT:ReloadPullButtons()
                MDT:GetCurrentPreset().value.selection = { newIndex }
                MDT:SetSelectionToPull(newIndex)
                MDT:ColorAllPulls(_, newIndex)
                if MDT.liveSessionActive and MDT:GetCurrentPreset().uid == MDT.livePresetUID then
                    MDT:LiveSession_SendPulls(MDT:GetPulls())
                end
                MDT:DrawAllHulls()
            end
        })
        tinsert(self.multiselectMenu, {
            text = " ",
            notClickable = 1,
            notCheckable = 1,
            func = nil
        })
        tinsert(self.multiselectMenu, {
            text = L["Pull Drop Color Settings"],
            notCheckable = 1,
            func = function()
                MDT:OpenAutomaticColorsDialog()
            end
        })
        tinsert(self.multiselectMenu, {
            text = L["Pull Drop Colorize Preset"],
            notCheckable = 1,
            func = function()
                local db = MDT:GetDB()
                if not db.colorPaletteInfo.autoColoring then
                    db.colorPaletteInfo.autoColoring = true
                    MDT.main_frame.AutomaticColorsCheck:SetValue(db.colorPaletteInfo.autoColoring)
                    MDT.main_frame.AutomaticColorsCheckSidePanel:SetValue(db.colorPaletteInfo.autoColoring)
                    MDT.main_frame.toggleForceColorBlindMode:SetDisabled(false)
                end
                MDT:SetPresetColorPaletteInfo()
                MDT:ColorAllPulls()
                MDT:DrawAllHulls()
            end
        })
        local function swatchMultiFunc()
            local r,g,b = ColorPickerFrame:GetColorRGB()
            local colorHex = MDT:RGBToHex(r,g,b)
            if colorHex == "228b22" then
                r,g,b = 2*r,2*g,2*b
                ColorPickerFrame:SetColorRGB(r,g,b)
            end

            if not MDT.U.contains(MDT:GetSelection(), self.index) then
                tinsert(MDT:GetSelection(), self.index)
                self:Pick()
            end

            for _, pullIdx in ipairs(MDT:GetSelection()) do
                MDT:DungeonEnemies_SetPullColor(pullIdx,r,g,b)
                MDT:UpdatePullButtonColor(pullIdx, r, g, b)
                MDT:DungeonEnemies_UpdateBlipColors(pullIdx,r,g,b)
            end
            MDT:DrawAllHulls()

            L_CloseDropDownMenus()
            if MDT.liveSessionActive and MDT:GetCurrentPreset().uid == MDT.livePresetUID then
                MDT:LiveSession_QueueColorUpdate()
            end
        end
        local function cancelMultiFunc()
            if not MDT.U.contains(MDT:GetSelection(), self.index) then
                tinsert(MDT:GetSelection(), self.index)
                self:Pick()
            end

            for _, pullIdx in ipairs(MDT:GetSelection()) do
                local button = MDT:GetPullButton(pullIdx)
                if button then
                    button:RevertColor()
                    local color = {
                        r = button.color.r,
                        g = button.color.g,
                        b = button.color.b
                    }
                    MDT:DungeonEnemies_SetPullColor(pullIdx, color.r, color.g, color.b)
                    MDT:UpdatePullButtonColor(pullIdx, color.r, color.g, color.b)
                    MDT:DungeonEnemies_UpdateBlipColors(pullIdx, color.r, color.g, color.b)
                end
            end

            self:RevertColor()
            MDT:DungeonEnemies_SetPullColor(self.index, self.color.r, self.color.g, self.color.b)
            MDT:UpdatePullButtonColor(self.index, self.color.r, self.color.g, self.color.b)
            MDT:DungeonEnemies_UpdateBlipColors(self.index, self.color.r, self.color.g, self.color.b)
            MDT:DrawAllHulls()
            if MDT.liveSessionActive and MDT:GetCurrentPreset().uid == MDT.livePresetUID then
                MDT:LiveSession_QueueColorUpdate()
            end
        end
        tinsert(self.multiselectMenu, {
            text = L["Pull Drop Color"]..": ",
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
            text = L["Pull Drop Reset Color"],
            notCheckable = 1,
            func = function()
                local r,g,b = 34/255,139/255,34/255

                if not MDT.U.contains(MDT:GetSelection(), self.index) then
                    tinsert(MDT:GetSelection(), self.index)
                    self:Pick()
                end

                for _, pullIdx in ipairs(MDT:GetSelection()) do
                    MDT:DungeonEnemies_SetPullColor(pullIdx,r,g,b)
                    MDT:UpdatePullButtonColor(pullIdx, r, g, b)
                    MDT:DungeonEnemies_UpdateBlipColors(pullIdx,r,g,b)
                    L_CloseDropDownMenus()
                end
                MDT:DrawAllHulls()
                if MDT.liveSessionActive and MDT:GetCurrentPreset().uid == MDT.livePresetUID then
                    MDT:LiveSession_SendPulls(MDT:GetPulls())
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
            text = L["Pull Drop Clear"],
            notCheckable = 1,
            func = function()
                if not MDT.U.contains(MDT:GetSelection(), self.index) then
                    tinsert(MDT:GetSelection(), self.index)
                    self:Pick()
                end

                for _, pullIdx in ipairs(MDT:GetSelection()) do
                    MDT:ClearPull(pullIdx)
                end
                if MDT.liveSessionActive and MDT:GetCurrentPreset().uid == MDT.livePresetUID then
                    MDT:LiveSession_SendPulls(MDT:GetPulls())
                end
            end
        })
        tinsert(self.multiselectMenu, {
            text = L["Pull Drop Reset Preset"],
            notCheckable = 1,
            func = function() MDT:OpenClearPresetDialog() end
        })
        if self.maxPulls > 1 then
            tinsert(self.multiselectMenu, {
                text = L["Pull Drop Delete"],
                notCheckable = 1,
                func = function()
                    local addPull = false
                    local button = MDT:GetFirstNotSelectedPullButton(self.index, "UP")
                    if not button then
                        button = MDT:GetFirstNotSelectedPullButton(self.index, "DOWN")
                        if not button then
                            addPull = true
                            button = 1
                        end
                    end

                    local removed_pulls = {}
                    for _, pullIdx in pairs(MDT.GetSelection()) do
                        local offset = MDT.U.count_if(removed_pulls, function(entry)
                            return entry < pullIdx
                        end)

                        MDT:DeletePull(pullIdx - offset)
                        tinsert(removed_pulls, pullIdx)
                    end

                    MDT.GetCurrentPreset().value.selection = {}

                    if not addPull then
                        local offset = MDT.U.count_if(removed_pulls, function(entry)
                            return entry < button
                        end)
                        MDT:SetSelectionToPull(button - offset)
                    else
                        --MDT:AddPull(1) --we handle not deleting all pulls in MDT:DeletePull() instead
                        MDT:SetSelectionToPull(1)
                    end
                    MDT:DrawAllHulls()
                    if MDT.liveSessionActive and MDT:GetCurrentPreset().uid == MDT.livePresetUID then
                        MDT:LiveSession_SendPulls(MDT:GetPulls())
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
            text = L["Pull Drop Close"],
            notCheckable = 1,
            func = MDT.main_frame.sidePanel.optionsDropDown:Hide()
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
        local scrollFrame = MDT.main_frame.sidePanel.pullButtonsScrollFrame
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
                    MDT:UpdatePullTooltip(MDT.pullTooltip)
                end

                if self.dragging then
                    if MDT.pullTooltip:IsShown() then
                        MDT.pullTooltip:Hide()
                    end

                    local scroll_hover = self.scroll_hover
                    local scrollFrame = MDT.main_frame.sidePanel.pullButtonsScrollFrame
                    local height = (scrollFrame.frame.height or scrollFrame.frame:GetHeight())


                    if scrollFrame.frame:IsMouseOver(scroll_hover.height, height - scroll_hover.offset, -dragdrop_overlap, dragdrop_overlap) then
                        self.top_hover = (self.top_hover or 0) + elapsed
                        self.bottom_hover = 0

                        if self.top_hover > scroll_hover.timeout then
                            local scroll_speed = self:GetScrollSpeed(scrollFrame.frame, scroll_hover.top)
                            local scroll_pulls = MDT.U.lerp(scroll_hover.pulls_per_second.min, scroll_hover.pulls_per_second.max, scroll_speed)
                            local scroll_pixel = scroll_pulls * self.frame:GetHeight()
                            local scroll_amount = MDT:GetScrollingAmount(scrollFrame, scroll_pixel) * scroll_hover.timeout

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
                            local scroll_pulls = MDT.U.lerp(scroll_hover.pulls_per_second.min, scroll_hover.pulls_per_second.max, scroll_speed)
                            local scroll_pixel = scroll_pulls * self.frame:GetHeight()
                            local scroll_amount = MDT:GetScrollingAmount(scrollFrame, scroll_pixel) * scroll_hover.timeout

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
                        MDT:Show_DropIndicator(button, pos)
                        self.elapsed = 0
                    end
                end
            end
        end

        return self.updateFunction
    end,
    ["Drag"] = function(self)
        local sidePanel = MDT.main_frame.sidePanel
        local uiscale, scale = UIParent:GetScale(), self.frame:GetEffectiveScale()
        local x, w = self.frame:GetLeft(), self.frame:GetWidth()
        local _, y = GetCursorPosition()

        MDT.pullTooltip:Hide()

        if #MDT:GetSelection() > 1 then
            if not MDT.U.contains(MDT:GetSelection(), self.index) then
                for _, pullIdx in pairs(MDT:GetSelection()) do
                    sidePanel.newPullButtons[pullIdx]:ClearPick()
                end

                MDT:GetCurrentPreset().value.currentPull = self.index
                MDT:GetCurrentPreset().value.selection = { self.index }
                self:Pick()
            end

            local selected_pulls = MDT.U.copy(MDT:GetSelection())
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

        if #MDT:GetSelection() > 1 then
            local sidePanel = MDT.main_frame.sidePanel
            local selected_pulls = MDT.U.copy(MDT:GetSelection())
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

                local progressed_above = MDT.U.count_if(progressed_pulls, function(entry)
                    return entry < pos
                end)
                --print("progressed above", progressed_above)

                pos = pos - progressed_above
                --print("pos", pos)

                local correctPullIndex = pullIdx
                --print("correctPullIndex", correctPullIndex)
                if pos > correctPullIndex then
                    correctPullIndex = correctPullIndex - MDT.U.count_if(progressed_pulls, function(entry)
                        return entry < correctPullIndex
                    end)
                    --print("correctPullIndex", correctPullIndex)
                end

                if pos <= correctPullIndex then
                    correctPullIndex = correctPullIndex + 1
                end
                --print("correctPullIndex", correctPullIndex)

                MDT:PresetsAddPull(pos)
                MDT:CopyPullOptions(correctPullIndex, pos)
                local newID =  MDT:PresetsMergePulls(correctPullIndex, pos)
                --print("newID", newID)

                tinsert(progressed_pulls, pullIdx)
                tinsert(new_pulls, newID)
            end

            MDT:GetCurrentPreset().value.selection = new_pulls
            MDT:ReloadPullButtons()
            MDT:SetSelectionToPull(1)
        else
            local index = self.index
            if index > insertID then
                index = index + 1
            end

            MDT:PresetsAddPull(insertID)
            MDT:CopyPullOptions(index, insertID)
            local newIndex = MDT:PresetsMergePulls(index, insertID)
            MDT:ReloadPullButtons()
            MDT:SetSelectionToPull(newIndex)
		end
		
		MDT:Hide_DropIndicator()
		--MDT:UpdateAutomaticColors(math.min(self.index, insertID))
        MDT:ColorAllPulls(_, math.min(self.index, insertID))
        MDT:DrawAllHulls()
        MDT.pullTooltip:Show()
        if MDT.liveSessionActive and MDT:GetCurrentPreset().uid == MDT.livePresetUID then
            MDT:LiveSession_SendPulls(MDT:GetPulls())
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
        self.color.r,self.color.g,self.color.b = MDT:DungeonEnemies_GetPullColor(self.index)
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
        local pullForces = MDT:CountForces(self.index,true)
        if pullForces>0 then
            self.percentageFontString:SetText(perc)
            self.percentageFontString:Show()
        else
            self.percentageFontString:Hide()
        end
    end,
    ["ShowPridefulIcon"] = function(self,show,currentPercent,oldPercent)
        --set percentage here
        self.percentageFontString:Show()
        local perc = string.format("%.1f%%",currentPercent*100)
        if show  then
            self.pridefulIcon:Show()
            perc = "|cFFFFFFFF"..perc

            local currentPrides = math.floor(currentPercent/0.2)
            local oldPrides = math.floor(oldPercent/0.2)
            local pridefuls = math.min(5,currentPrides-oldPrides)

            if pridefuls>1 then
                self.multiPridefulFontString:SetText(pridefuls.."x")
                self.multiPridefulFontString:Show()
            else
                self.multiPridefulFontString:Hide()
            end
        else
            self.pridefulIcon:Hide()
            self.multiPridefulFontString:Hide()
            perc = "|cFFFFFFFF"..perc
        end
        local pullForces = MDT:CountForces(self.index,true)
        if pullForces>0 then
            self.percentageFontString:SetText(perc)
            self.percentageFontString:Show()
        else
            self.percentageFontString:Hide()
        end
    end,
    ["ShowCountPerHealth"] = function(self,show,count,health)
        if show then
            local text = "1.2"
            self.countPerHealthFontString:SetText(text)
            --self.countPerHealthFontString:Show()
        else
            --self.countPerHealthFontString:Hide()
        end
    end,
    ["UpdateColor"] = function(self)
        local colorHex = MDT:RGBToHex(self.color.r,self.color.g,self.color.b)
        local db = MDT:GetDB()
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
    local name = "MDTPullButton"..AceGUI:GetNextWidgetNum(Type);
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
    pickedGlow:SetTexture("Interface\\AddOns\\MythicDungeonTools\\Textures\\HeartOfAzerothSelection")
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
        enemyPortraits[i].overlay:SetTexture("Interface\\Addons\\MythicDungeonTools\\Textures\\Circle_White")
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
    reapingIcon.overlay:SetTexture("Interface\\Addons\\MythicDungeonTools\\Textures\\Circle_White")
    reapingIcon.overlay:SetVertexColor(0.7,0.7,0.7)
    reapingIcon.overlay:SetPoint("CENTER",reapingIcon,"CENTER")
    reapingIcon.overlay:SetSize(height+1,height+1)
    reapingIcon.overlay:Hide()

    --pull percentage
    local percentageFontString = button:CreateFontString(nil,"BACKGROUND",nil)
    percentageFontString:SetFont("Fonts\\FRIZQT__.TTF", 10,"OUTLINE")
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

    --prideful icon
    local pridefulIcon = button:CreateTexture(nil, "BACKGROUND", nil, 2)
    pridefulIcon:SetSize(height-5,height-5)
    pridefulIcon:SetPoint("RIGHT", button, "RIGHT",-10,0)
    pridefulIcon:SetAlpha(1)
    SetPortraitToTexture(pridefulIcon,"Interface\\Icons\\spell_animarevendreth_buff")
    pridefulIcon:Hide()

    --multiple prideful wave indicator
    local multiPridefulFontString = button:CreateFontString(nil,"BACKGROUND",nil)
    multiPridefulFontString:SetFont("Fonts\\FRIZQT__.TTF", 10,"OUTLINE")
    multiPridefulFontString:SetTextColor(1, 1, 1, 1);
    multiPridefulFontString:SetWidth(50)
    multiPridefulFontString:SetHeight(10)
    multiPridefulFontString:SetPoint("RIGHT", button, "RIGHT",1,-12)
    multiPridefulFontString:Hide()

    --count per health indicator
    local countPerHealthFontString = button:CreateFontString(nil,"BACKGROUND",nil)
    countPerHealthFontString:SetFont("Fonts\\FRIZQT__.TTF", 10,"OUTLINE")
    countPerHealthFontString:SetTextColor(1, 1, 1, 1);
    countPerHealthFontString:SetWidth(50)
    countPerHealthFontString:SetHeight(10)
    countPerHealthFontString:SetPoint("RIGHT", button, "RIGHT",-28,0)
    countPerHealthFontString:Hide()


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
        pridefulIcon = pridefulIcon,
        multiPridefulFontString = multiPridefulFontString,
        color = color,
        type = Type,
        countPerHealthFontString = countPerHealthFontString,
    }
    for method, func in pairs(methods) do
        widget[method] = func
    end

    return AceGUI:RegisterAsWidget(widget);
end

AceGUI:RegisterWidgetType(Type, Constructor, Version)
