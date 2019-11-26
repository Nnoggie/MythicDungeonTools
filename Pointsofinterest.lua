--- DateTime: 23.06.2018 17:18
local MethodDungeonTools = MethodDungeonTools
local db
local tonumber,tinsert,slen,pairs,ipairs,tostring,next,type,sformat,tremove,twipe = tonumber,table.insert,string.len,pairs,ipairs,tostring,next,type,string.format,table.remove,table.wipe
local UnitName,UnitGUID,UnitCreatureType,UnitHealthMax,UnitLevel = UnitName,UnitGUID,UnitCreatureType,UnitHealthMax,UnitLevel

local points = {}

function MethodDungeonTools:POI_CreateFramePools()
    MethodDungeonTools.poi_framePools = MethodDungeonTools.poi_framePools or CreatePoolCollection()
    MethodDungeonTools.poi_framePools:CreatePool("Button", MethodDungeonTools.main_frame.mapPanelFrame, "MapLinkPinTemplate");
    MethodDungeonTools.poi_framePools:CreatePool("Button", MethodDungeonTools.main_frame.mapPanelFrame, "DeathReleasePinTemplate");
    MethodDungeonTools.poi_framePools:CreatePool("Button", MethodDungeonTools.main_frame.mapPanelFrame, "VignettePinTemplate");
end


--devMode
local function POI_SetDevOptions(frame,poi)
    frame:SetMovable(true)
    frame:EnableMouse(true)
    frame:SetScript("OnMouseDown", function(self, button)
        if button == "LeftButton" and not self.isMoving then
            self:StartMoving();
            self.isMoving = true;
        end
        if button == "RightButton" then
            local pois = MethodDungeonTools.mapPOIs[db.currentDungeonIdx][MethodDungeonTools:GetCurrentSubLevel()]
            tremove(pois,self.poiIdx)
            MethodDungeonTools:UpdateMap()
        end
    end)
    frame:SetScript("OnMouseUp", function(self, button)
        if button == "LeftButton" and self.isMoving then
            self.isMoving = false;
            self:StopMovingOrSizing();
            local newx,newy = MethodDungeonTools:GetCursorPosition()
            local scale = MethodDungeonTools:GetScale()
            newx = newx*(1/scale)
            newy = newy*(1/scale)
            local pois = MethodDungeonTools.mapPOIs[db.currentDungeonIdx][MethodDungeonTools:GetCurrentSubLevel()]
            pois[self.poiIdx].x = newx
            pois[self.poiIdx].y = newy
            self:ClearAllPoints()
            MethodDungeonTools:UpdateMap()
        end
    end)
    frame:SetScript("OnClick",nil)
end

local function POI_SetOptions(frame,type,poi,homeSublevel)
    frame.teeming = nil
    frame.isSpire = nil
    frame.riftIndex = nil
    frame.spireIndex = nil
    frame.defaultHidden = nil
    frame:SetMovable(false)
    frame:SetScript("OnMouseDown",nil)
    frame:SetScript("OnMouseUp",nil)
    frame.weeks = poi.weeks
    frame:SetFrameLevel(4)
    frame.defaultSublevel = nil
    if frame.HighlightTexture then frame.HighlightTexture:SetDrawLayer("HIGHLIGHT") end
    if frame.textString then frame.textString:Hide() end
    if type == "mapLink" then
        frame:SetSize(22,22)
        frame.Texture:SetSize(22,22)
        frame.HighlightTexture:SetSize(22,22)
        frame.HighlightTexture:SetDrawLayer("ARTWORK")
        frame.HighlightTexture:Hide()
        frame.target = poi.target
        local directionToAtlas = {
            [-1] = "poi-door-down",
            [1] = "poi-door-up",
            [-2] = "poi-door-left",
            [2] = "poi-door-right",
        }
        frame.HighlightTexture:SetAtlas(directionToAtlas[poi.direction])
        frame.Texture:SetAtlas(directionToAtlas[poi.direction])
        frame:SetScript("OnClick",function()
            MethodDungeonTools:SetCurrentSubLevel(poi.target)
            MethodDungeonTools:UpdateMap()
        end)
        frame:SetScript("OnEnter",function()
            GameTooltip:SetOwner(UIParent, "ANCHOR_CURSOR")
            GameTooltip:AddLine(MethodDungeonTools:GetDungeonSublevels()[db.currentDungeonIdx][poi.target], 1, 1, 1, 1)
            GameTooltip:Show()
            frame.HighlightTexture:Show()
        end)
        frame:SetScript("OnLeave",function()
            GameTooltip:Hide()
            frame.HighlightTexture:Hide()
        end)
    end
    if type == "nyalothaSpire" then
        local poiScale = poi.scale or 1
        frame:SetSize(10*poiScale,10*poiScale)
        frame.Texture:SetSize(16*poiScale,22*poiScale)
        frame.Texture:SetAtlas("poi-nzothpylon")
        frame.HighlightTexture:SetSize(16*poiScale,22*poiScale)
        frame.HighlightTexture:SetAtlas("poi-nzothpylon")
        frame.HighlightTexture:SetDrawLayer("ARTWORK")
        frame.HighlightTexture:Hide()
        frame.isSpire = true
        frame.spireIndex = poi.index
        if not frame.textString then
            frame.textString = frame:CreateFontString()
            frame.textString:SetPoint("BOTTOM",frame,"BOTTOM", 0, 2)
            frame.textString:SetFontObject("GameFontNormal")
            frame.textString:SetFont(frame.textString:GetFont(),7*poiScale,"OUTLINE")
            frame.textString:SetTextColor(0.5, 1, 0, 1)
        end
        frame.textString:SetText((frame.spireIndex*2)-1)
        frame:SetScript("OnClick",nil)
        local riftFrame
        local blipFrame
        frame:SetScript("OnMouseUp",function()
            if frame.isSpire then
                frame.Texture:SetSize(16*poiScale,16*poiScale)
                frame.Texture:SetAtlas("poi-rift1")
                frame.HighlightTexture:SetSize(16*poiScale,16*poiScale)
                frame.HighlightTexture:SetAtlas("poi-rift1")
                frame.isSpire = false
                frame.textString:Show()
                --show brother rift
                local _,active = MethodDungeonTools.poi_framePools:GetPool("VignettePinTemplate"):EnumerateActive()
                for poiFrame,_ in pairs(active) do
                    if poiFrame.riftIndex and poiFrame.riftIndex == frame.spireIndex then
                        riftFrame = poiFrame
                        riftFrame:Show()
                        riftFrame.ShowAnim:Play()
                        break
                    end
                end
                frame.ShowAnim:Play()
                --store expanded status
                MethodDungeonTools:GetCurrentPreset().value.riftOffsets = MethodDungeonTools:GetCurrentPreset().value.riftOffsets or {}
                local riftOffsets = MethodDungeonTools:GetCurrentPreset().value.riftOffsets
                riftOffsets[frame.spireIndex] = riftOffsets[frame.spireIndex] or {}
                riftOffsets[frame.spireIndex].expanded = true
            else
                frame.Texture:SetSize(16*poiScale,22*poiScale)
                frame.Texture:SetAtlas("poi-nzothpylon")
                frame.HighlightTexture:SetSize(16*poiScale,22*poiScale)
                frame.HighlightTexture:SetAtlas("poi-nzothpylon")
                frame.isSpire = true
                frame.textString:Hide()
                --hide brother rift
                local _,active = MethodDungeonTools.poi_framePools:GetPool("VignettePinTemplate"):EnumerateActive()
                for poiFrame,_ in pairs(active) do
                    if poiFrame.riftIndex and poiFrame.riftIndex == frame.spireIndex then
                        poiFrame:Hide()
                        break
                    end
                end
                frame.ShowAnim:Play()
                --store collapsed status
                MethodDungeonTools:GetCurrentPreset().value.riftOffsets[frame.spireIndex].expanded = nil
            end
        end)
        frame:SetScript("OnEnter",function()
            GameTooltip:SetOwner(UIParent, "ANCHOR_CURSOR")
            GameTooltip:AddLine(poi.tooltipText.."\n[Click to show rift]")
            GameTooltip:Show()
            frame.HighlightTexture:Show()
            --highlight brother rift
            local _,active = MethodDungeonTools.poi_framePools:GetPool("VignettePinTemplate"):EnumerateActive()
            for poiFrame,_ in pairs(active) do
                if poiFrame.riftIndex and poiFrame.riftIndex == frame.spireIndex then
                    riftFrame = poiFrame
                    riftFrame.HighlightTexture:Show()
                    break
                end
            end
            --highlight associated npc
            local blips = MethodDungeonTools:GetDungeonEnemyBlips()
            for _,blip in pairs(blips) do
                if blip.data.id == poi.npcId then
                    local isBlipSameWeek
                    for weekIdx,_ in pairs(poi.weeks) do
                        isBlipSameWeek = isBlipSameWeek or blip.clone.week[weekIdx]
                    end
                    if isBlipSameWeek then
                        blipFrame = blip
                        blipFrame.fontstring_Text1:Show()
                        break
                    end
                end
            end
        end)
        frame:SetScript("OnLeave",function()
            GameTooltip:Hide()
            frame.HighlightTexture:Hide()
            if riftFrame then riftFrame.HighlightTexture:Hide() end
            if blipFrame then blipFrame.fontstring_Text1:Hide() end
        end)
        --check expanded status
        local riftOffsets = MethodDungeonTools:GetCurrentPreset().value.riftOffsets
        if riftOffsets and riftOffsets[frame.spireIndex] and riftOffsets[frame.spireIndex].expanded then
            frame.Texture:SetSize(16*poiScale,16*poiScale)
            frame.Texture:SetAtlas("poi-rift1")
            frame.HighlightTexture:SetSize(16*poiScale,16*poiScale)
            frame.HighlightTexture:SetAtlas("poi-rift1")
            frame.isSpire = false
            frame.textString:Show()
            local _,active = MethodDungeonTools.poi_framePools:GetPool("VignettePinTemplate"):EnumerateActive()
            for poiFrame,_ in pairs(active) do
                if poiFrame.riftIndex and poiFrame.riftIndex == frame.spireIndex then
                    poiFrame:Show()
                    break
                end
            end
        end
    end
    if type == "nyalothaRift" then
        frame:SetFrameLevel(100)
        local poiScale = poi.scale or 1
        frame.riftIndex = poi.index
        frame:SetSize(12*poiScale,12*poiScale)
        frame.Texture:SetSize(12*poiScale,12*poiScale)
        frame.Texture:SetAtlas("poi-rift1")
        frame.HighlightTexture:SetSize(12*poiScale,12*poiScale)
        frame.HighlightTexture:SetAtlas("poi-rift1")
        frame.HighlightTexture:SetDrawLayer("ARTWORK")
        frame.HighlightTexture:Hide()
        frame.defaultSublevel = homeSublevel or MethodDungeonTools:GetCurrentSubLevel()
        if not frame.textString then
            frame.textString = frame:CreateFontString()
            frame.textString:SetPoint("BOTTOM",frame,"BOTTOM", 0, 2)
            frame.textString:SetFontObject("GameFontNormal")
            frame.textString:SetFont(frame.textString:GetFont(),7*poiScale,"OUTLINE")
            frame.textString:SetTextColor(0.5, 1, 0, 1)
        end
        frame.textString:SetText(frame.riftIndex*2)
        frame.textString:Show()
        frame:SetScript("OnClick",nil)
        local spireFrame
        local blipFrame
        frame:SetScript("OnEnter",function()
            GameTooltip:SetOwner(UIParent, "ANCHOR_CURSOR")
            GameTooltip:AddLine("Ny'alothan Rift")
            GameTooltip:AddLine("[Drag to move]")
            GameTooltip:Show()
            frame.HighlightTexture:Show()
            local _,active = MethodDungeonTools.poi_framePools:GetPool("VignettePinTemplate"):EnumerateActive()
            for poiFrame,_ in pairs(active) do
                if poiFrame.spireIndex and poiFrame.spireIndex == frame.riftIndex then
                    spireFrame = poiFrame
                    spireFrame.HighlightTexture:Show()
                    break
                end
            end
            --highlight associated npc
            local blips = MethodDungeonTools:GetDungeonEnemyBlips()
            for _,blip in pairs(blips) do
                if blip.data.id == poi.npcId then
                    local isBlipSameWeek
                    for weekIdx,_ in pairs(poi.weeks) do
                        isBlipSameWeek = isBlipSameWeek or blip.clone.week[weekIdx]
                    end
                    if isBlipSameWeek then
                        blipFrame = blip
                        blipFrame.fontstring_Text1:Show()
                        break
                    end
                end
            end
        end)
        frame:SetScript("OnLeave",function()
            GameTooltip:Hide()
            frame.HighlightTexture:Hide()
            if spireFrame then spireFrame.HighlightTexture:Hide() end
            if blipFrame then blipFrame.fontstring_Text1:Hide() end
        end)
        frame.defaultHidden = true
        frame:SetMovable(true)
        frame:EnableMouse(true)
        local xOffset,yOffset
        frame:SetScript("OnMouseDown", function(self, button)
            if button == "LeftButton" and not self.isMoving then
                self:StartMoving()
                self.isMoving = true
                local x,y = MethodDungeonTools:GetCursorPosition()
                local scale = MethodDungeonTools:GetScale()
                x = x*(1/scale)
                y = y*(1/scale)
                local riftOffsets = MethodDungeonTools:GetCurrentPreset().value.riftOffsets
                local nx = riftOffsets and riftOffsets[frame.riftIndex] and riftOffsets[frame.riftIndex].x or poi.x
                local ny = riftOffsets and riftOffsets[frame.riftIndex] and riftOffsets[frame.riftIndex].y or poi.y
                xOffset = x-nx
                yOffset = y-ny
                local _,activeDoors = MethodDungeonTools.poi_framePools:GetPool("MapLinkPinTemplate"):EnumerateActive()
                frame:SetScript("OnUpdate",function()
                    for poiFrame,_ in pairs(activeDoors) do
                        if MethodDungeonTools:DoFramesOverlap(frame,poiFrame,-10) then
                            poiFrame.HighlightTexture:Show()
                        else
                            poiFrame.HighlightTexture:Hide()
                        end
                    end
                end)
            end
        end)
        frame:SetScript("OnMouseUp", function(self, button)
            if button == "LeftButton" and self.isMoving then
                self.isMoving = false
                local x,y = MethodDungeonTools:GetCursorPosition()
                local scale = MethodDungeonTools:GetScale()
                x = x*(1/scale)
                y = y*(1/scale)
                x = x-xOffset
                y = y-yOffset
                frame:StopMovingOrSizing()
                frame:ClearAllPoints()
                frame:SetPoint("CENTER",MethodDungeonTools.main_frame.mapPanelTile1,"TOPLEFT",x*scale,y*scale)
                MethodDungeonTools:GetCurrentPreset().value.riftOffsets = MethodDungeonTools:GetCurrentPreset().value.riftOffsets or {}
                local riftOffsets = MethodDungeonTools:GetCurrentPreset().value.riftOffsets
                riftOffsets[frame.riftIndex] = riftOffsets[frame.riftIndex] or {}
                riftOffsets[frame.riftIndex].x = x
                riftOffsets[frame.riftIndex].y = y
                --dragged ontop of door
                --find doors,check overlap,break,swap sublevel,change poi sublevel???
                local _,active = MethodDungeonTools.poi_framePools:GetPool("MapLinkPinTemplate"):EnumerateActive()
                for poiFrame,_ in pairs(active) do
                    if MethodDungeonTools:DoFramesOverlap(frame,poiFrame,-10) then
                        riftOffsets[frame.riftIndex].sublevel = poiFrame.target
                        riftOffsets[frame.riftIndex].homeSublevel = frame.defaultSublevel
                        if riftOffsets[frame.riftIndex].sublevel == frame.defaultSublevel then
                            riftOffsets[frame.riftIndex].sublevel = nil
                            riftOffsets[frame.riftIndex].homeSublevel = nil
                        end
                        --zoom out
                        --move frame
                        poiFrame:Click()
                        break
                    end
                end
                frame:SetScript("OnUpdate",nil)
            elseif button == "RightButton" then
                local _,active = MethodDungeonTools.poi_framePools:GetPool("VignettePinTemplate"):EnumerateActive()
                for poiFrame,_ in pairs(active) do
                    if poiFrame.spireIndex and poiFrame.spireIndex == frame.riftIndex then
                        poiFrame.Texture:SetSize(16*poiScale,22*poiScale)
                        poiFrame.Texture:SetAtlas("poi-nzothpylon")
                        poiFrame.HighlightTexture:SetSize(16,22*poiScale,22,22*poiScale)
                        poiFrame.HighlightTexture:SetAtlas("poi-nzothpylon")
                        poiFrame.isSpire = true
                        poiFrame.ShowAnim:Play()
                        poiFrame.textString:Hide()
                        break
                    end
                end
                frame:Hide()
            end
        end)
        --check for expanded status
        local riftOffsets = MethodDungeonTools:GetCurrentPreset().value.riftOffsets
        if riftOffsets and riftOffsets[frame.riftIndex] and riftOffsets[frame.riftIndex].expanded then
            local _,active = MethodDungeonTools.poi_framePools:GetPool("VignettePinTemplate"):EnumerateActive()
            for poiFrame,_ in pairs(active) do
                if poiFrame.spireIndex and poiFrame.spireIndex == frame.riftIndex then
                    frame:Show()
                    break
                end
            end
        end
    end
    if type == "door" then
        frame:SetSize(22,22)
        frame.Texture:SetSize(22,22)
        frame.HighlightTexture:SetSize(22,22)
        frame.HighlightTexture:SetAtlas("map-icon-SuramarDoor.tga")
        frame.Texture:SetAtlas("map-icon-SuramarDoor.tga")
        frame:SetScript("OnClick",nil)
        frame:SetScript("OnEnter",function()
            GameTooltip:SetOwner(UIParent, "ANCHOR_CURSOR")
            GameTooltip:AddLine(poi.doorName..(slen(poi.doorDescription)>0 and "\n"..poi.doorDescription or "")..(poi.lockpick and "\n".."|cFF32CD32Locked" or ""), 1, 1, 1, 1)
            GameTooltip:Show()
        end)
        frame:SetScript("OnLeave",function()
            GameTooltip:Hide()
        end)
    end
    if type == "graveyard" then
        frame:SetSize(12,12)
        frame:SetScript("OnClick",nil)
        frame:SetScript("OnEnter",function()
            GameTooltip:SetOwner(UIParent, "ANCHOR_CURSOR")
            GameTooltip:AddLine("Graveyard"..(slen(poi.graveyardDescription)>0 and "\n"..poi.graveyardDescription or ""), 1, 1, 1, 1)
            GameTooltip:Show()
        end)
        frame:SetScript("OnLeave",function()
            GameTooltip:Hide()
        end)
    end
    if type =="tdprisonkey" then
        frame:SetSize(10,10)
        frame.Texture:SetSize(10,10)
        frame.HighlightTexture:SetSize(10,10)
        frame.HighlightTexture:SetAtlas("QuestNormal")
        frame.Texture:SetAtlas("QuestNormal")
        frame:SetScript("OnClick",function()

        end)
        frame:SetScript("OnEnter",function()
            GameTooltip:SetOwner(UIParent, "ANCHOR_CURSOR")
            GameTooltip:AddLine("Discarded Cell Key\nPossible Spawn Location\nOpens 1x Prison Bars", 1, 1, 1, 1)
            GameTooltip:Show()
        end)
        frame:SetScript("OnLeave",function()
            GameTooltip:Hide()
        end)
    end
    if type =="wmMaggotNote" then
        frame:SetSize(10,10)
        frame.Texture:SetSize(10,10)
        frame.HighlightTexture:SetSize(10,10)
        frame.HighlightTexture:SetAtlas("QuestNormal")
        frame.Texture:SetAtlas("QuestNormal")
        frame:SetScript("OnClick",function()

        end)
        frame:SetScript("OnEnter",function()
            GameTooltip:SetOwner(UIParent, "ANCHOR_CURSOR")
            GameTooltip:AddLine("Note on Devouring Maggots:\n\nDevouring Maggots with the buff 'Parasitic' will try to 'Infest' Players\nUpon successfull cast of 'Infest' the Devouring Maggot will disappear and spawn 2x Devouring Maggots after a debuff on the infested player runs out.\nYou can only gain 1 count for killing the initial Infested Maggot - the 2 newly spawned Infested Maggots do not give count.\n\nInfected Peasants spawn 3x Devouring Maggots which do give 1 count each.\nThese Devouring Maggots are mapped next to the Infected Peasants.", 1, 1, 1, 1)
            GameTooltip:Show()
        end)
        frame:SetScript("OnLeave",function()
            GameTooltip:Hide()
        end)
    end
    if type == "heavyCannon" then
        frame:SetSize(20,20)
        frame.Texture:SetSize(20,20)
        frame.HighlightTexture:SetSize(20,20)
        frame.HighlightTexture:SetAtlas("TaxiNode_Continent_Horde")
        frame.Texture:SetAtlas("TaxiNode_Continent_Horde")
        frame:SetScript("OnClick",function()

        end)
        frame:SetScript("OnEnter",function()
            GameTooltip:SetOwner(UIParent, "ANCHOR_CURSOR")
            GameTooltip:AddLine("Heavy Cannon\nUsable by players\nDamages both enemies and allies", 1, 1, 1, 1)
            GameTooltip:Show()
        end)
        frame:SetScript("OnLeave",function()
            GameTooltip:Hide()
        end)
    end
    if type == "mlFrackingTotem" then
        frame:SetSize(12,12)
        frame.Texture:SetSize(12,12)
        frame.HighlightTexture:SetSize(12,12)
        frame.HighlightTexture:SetAtlas("TaxiNode_Continent_Horde")
        frame.Texture:SetAtlas("TaxiNode_Continent_Horde")
        frame:SetScript("OnClick",function()

        end)
        frame:SetScript("OnEnter",function()
            GameTooltip:SetOwner(UIParent, "ANCHOR_CURSOR")
            GameTooltip:AddLine("Fracking Totem\nUsable by players\nIncapacitates Earthrager for 1min - Breaks on Damage", 1, 1, 1, 1)
            GameTooltip:Show()
        end)
        frame:SetScript("OnLeave",function()
            GameTooltip:Hide()
        end)
    end
    if type == "mlMineCart" then
        frame:SetSize(12,12)
        frame.Texture:SetSize(12,12)
        frame.HighlightTexture:SetSize(12,12)
        frame.HighlightTexture:SetAtlas("TaxiNode_Continent_Horde")
        frame.Texture:SetAtlas("TaxiNode_Continent_Horde")
        frame:SetScript("OnClick",function()

        end)
        frame:SetScript("OnEnter",function()
            GameTooltip:SetOwner(UIParent, "ANCHOR_CURSOR")
            GameTooltip:AddLine("Mine Cart\nUsable by players", 1, 1, 1, 1)
            GameTooltip:Show()
        end)
        frame:SetScript("OnLeave",function()
            GameTooltip:Hide()
        end)
    end
    if type == "tuSkip" then
        frame:SetSize(12,12)
        frame.Texture:SetSize(12,12)
        frame.HighlightTexture:SetSize(12,12)
        frame.HighlightTexture:SetAtlas("TaxiNode_Continent_Horde")
        frame.Texture:SetAtlas("TaxiNode_Continent_Horde")
        frame:SetScript("OnClick",function()

        end)
        frame:SetScript("OnEnter",function()
            GameTooltip:SetOwner(UIParent, "ANCHOR_CURSOR")
            GameTooltip:AddLine("Shortcut\nUnlocks after killing Sporecaller Zancha", 1, 1, 1, 1)
            GameTooltip:Show()
        end)
        frame:SetScript("OnLeave",function()
            GameTooltip:Hide()
        end)
    end
    if type == "tuMatronNote" then
        frame:SetSize(10,10)
        frame.Texture:SetSize(10,10)
        frame.HighlightTexture:SetSize(10,10)
        frame.HighlightTexture:SetAtlas("QuestNormal")
        frame.Texture:SetAtlas("QuestNormal")
        frame:SetScript("OnClick",function()

        end)
        frame:SetScript("OnEnter",function()
            GameTooltip:SetOwner(UIParent, "ANCHOR_CURSOR")
            GameTooltip:AddLine("Matron 4+5 can spawn on either left or right platform.", 1, 1, 1, 1)
            GameTooltip:Show()
        end)
        frame:SetScript("OnLeave",function()
            GameTooltip:Hide()
        end)
    end
    if type == "shrineSkip" then
        frame:SetSize(12,12)
        frame.Texture:SetSize(12,12)
        frame.HighlightTexture:SetSize(12,12)
        frame.HighlightTexture:SetAtlas("TaxiNode_Continent_Horde")
        frame.Texture:SetAtlas("TaxiNode_Continent_Horde")
        frame:SetScript("OnClick",function()

        end)
        frame:SetScript("OnEnter",function()
            GameTooltip:SetOwner(UIParent, "ANCHOR_CURSOR")
            GameTooltip:AddLine("Shortcut", 1, 1, 1, 1)
            GameTooltip:Show()
        end)
        frame:SetScript("OnLeave",function()
            GameTooltip:Hide()
        end)
    end
    if type == "templeEye" then
        frame:SetSize(20,20)
        frame.Texture:SetSize(20,20)
        frame.HighlightTexture:SetSize(20,20)
        frame.HighlightTexture:SetAtlas("TaxiNode_Continent_Horde")
        frame.Texture:SetAtlas("TaxiNode_Continent_Horde")
        frame:SetScript("OnClick",function()

        end)
        frame:SetScript("OnEnter",function()
            GameTooltip:SetOwner(UIParent, "ANCHOR_CURSOR")
            GameTooltip:AddLine("Eye of Sethraliss\nBring both Eyes to the Skull of Sethraliss\nEach Eye you bring to the Skull awards 12 Enemy Forces", 1, 1, 1, 1)
            GameTooltip:Show()
        end)
        frame:SetScript("OnLeave",function()
            GameTooltip:Hide()
        end)
    end
    if type == "krSpiritGuide" then
        frame:SetSize(20,20)
        frame.Texture:SetSize(20,20)
        frame.HighlightTexture:SetSize(20,20)
        frame.HighlightTexture:SetAtlas("TaxiNode_Continent_Horde")
        frame.Texture:SetAtlas("TaxiNode_Continent_Horde")
        frame:SetScript("OnClick",function()

        end)
        frame:SetScript("OnEnter",function()
            GameTooltip:SetOwner(UIParent, "ANCHOR_CURSOR")
            GameTooltip:AddLine("Untainted Spirit Guide\nUnlocks after defeating Purification Construct 1", 1, 1, 1, 1)
            GameTooltip:Show()
        end)
        frame:SetScript("OnLeave",function()
            GameTooltip:Hide()
        end)
    end
    if type =="adTeemingNote" then
        frame:SetSize(10,10)
        frame.Texture:SetSize(10,10)
        frame.HighlightTexture:SetSize(10,10)
        frame.HighlightTexture:SetAtlas("QuestNormal")
        frame.Texture:SetAtlas("QuestNormal")
        frame:SetScript("OnClick",function()

        end)
        frame:SetScript("OnEnter",function()
            GameTooltip:SetOwner(UIParent, "ANCHOR_CURSOR")
            GameTooltip:AddLine("Note on Teeming:\n\nG29 is not always present.\nTeeming enemies of G2 are not always present.\nG27 is not always present.", 1, 1, 1, 1)
            GameTooltip:Show()
        end)
        frame:SetScript("OnLeave",function()
            GameTooltip:Hide()
        end)
        frame.teeming = true
    end
    if type =="sobGutters" then
        frame:SetSize(10,10)
        frame.Texture:SetSize(10,10)
        frame.HighlightTexture:SetSize(10,10)
        frame.HighlightTexture:SetAtlas("QuestNormal")
        frame.Texture:SetAtlas("QuestNormal")
        frame:SetScript("OnClick",function()

        end)
        frame:SetScript("OnEnter",function()
            GameTooltip:SetOwner(UIParent, "ANCHOR_CURSOR")
            GameTooltip:AddLine("Note on Gutters:\nFootmen will insta-kill Gutters when a player comes near them. If they die without taking damage from the group they will not give any enemy forces.", 1, 1, 1, 1)
            GameTooltip:Show()
        end)
        frame:SetScript("OnLeave",function()
            GameTooltip:Hide()
        end)
    end
    if type =="generalNote" then
        frame:SetSize(10,10)
        frame.Texture:SetSize(10,10)
        frame.HighlightTexture:SetSize(10,10)
        frame.HighlightTexture:SetAtlas("QuestNormal")
        frame.Texture:SetAtlas("QuestNormal")
        frame:SetScript("OnClick",function()

        end)
        frame:SetScript("OnEnter",function()
            GameTooltip:SetOwner(UIParent, "ANCHOR_CURSOR")
            GameTooltip:AddLine(poi.text, 1, 1, 1, 1)
            GameTooltip:Show()
        end)
        frame:SetScript("OnLeave",function()
            GameTooltip:Hide()
        end)
    end
    --fullscreen sizes
    local scale = MethodDungeonTools:GetScale()
    frame:SetSize(frame:GetWidth()*scale,frame:GetHeight()*scale)
    if frame.Texture then frame.Texture:SetSize(frame.Texture:GetWidth()*scale,frame.Texture:GetHeight()*scale) end
    if frame.HighlightTexture then frame.HighlightTexture:SetSize(frame.HighlightTexture:GetWidth()*scale,frame.HighlightTexture:GetHeight()*scale) end

    if db.devMode then POI_SetDevOptions(frame,poi) end
end

---POI_PositionAllPoints
---Used to position during scaling changes to the map
function MethodDungeonTools:POI_PositionAllPoints(scale)
    for _,poiFrame in pairs(points) do
        poiFrame:ClearAllPoints()
        poiFrame:SetPoint("CENTER",self.main_frame.mapPanelTile1,"TOPLEFT",poiFrame.x*scale,poiFrame.y*scale)
    end
end


---POI_UpdateAll
function MethodDungeonTools:POI_UpdateAll()
    twipe(points)
    db = MethodDungeonTools:GetDB()
    local framePools = MethodDungeonTools.poi_framePools
    framePools:ReleaseAll()
    if not MethodDungeonTools.mapPOIs[db.currentDungeonIdx] then return end
    local currentSublevel = MethodDungeonTools:GetCurrentSubLevel()
    local pois = MethodDungeonTools.mapPOIs[db.currentDungeonIdx][currentSublevel]
    if not pois then return end
    local preset = MethodDungeonTools:GetCurrentPreset()
    local teeming = MethodDungeonTools:IsPresetTeeming(preset)
    local scale = MethodDungeonTools:GetScale()
    local riftOffsets = MethodDungeonTools:GetCurrentPreset().value.riftOffsets
    for poiIdx,poi in pairs(pois) do
        local week = MethodDungeonTools:GetEffectivePresetWeek(preset)
        if (not poi.weeks) or poi.weeks[week] then
            --skip rifts that were dragged to another sublevel
            if not (poi.type == "nyalothaRift" and riftOffsets and riftOffsets[poi.index] and riftOffsets[poi.index].sublevel) then
                local poiFrame = framePools:Acquire(poi.template)
                poiFrame.poiIdx = poiIdx
                POI_SetOptions(poiFrame,poi.type,poi)
                poiFrame.x = poi.x
                poiFrame.y = poi.y
                local x = db.devMode and poi.x or riftOffsets and riftOffsets[poiFrame.riftIndex] and riftOffsets[poiFrame.riftIndex].x or poi.x
                local y = db.devMode and poi.y or riftOffsets and riftOffsets[poiFrame.riftIndex] and riftOffsets[poiFrame.riftIndex].y or poi.y
                poiFrame:ClearAllPoints()
                poiFrame:SetPoint("CENTER",MethodDungeonTools.main_frame.mapPanelTile1,"TOPLEFT",x*scale,y*scale)
                if not poiFrame.defaultHidden or db.devMode then poiFrame:Show() end
                if not teeming and poiFrame.teeming then
                    poiFrame:Hide()
                end
                tinsert(points,poiFrame)
            end
        end
    end
    --add rifts that were dragged to another sublevel
    if riftOffsets then
        for riftIndex,data in pairs(riftOffsets) do
            if data.sublevel and data.homeSublevel and data.sublevel ==  currentSublevel then
                pois = MethodDungeonTools.mapPOIs[db.currentDungeonIdx][data.homeSublevel]
                for poiIdx,poi in pairs(pois) do
                    if poi.type == "nyalothaRift" and poi.index == riftIndex then
                        local poiFrame = framePools:Acquire(poi.template)
                        poiFrame.poiIdx = poiIdx
                        POI_SetOptions(poiFrame,poi.type,poi,data.homeSublevel)
                        poiFrame.x = poi.x
                        poiFrame.y = poi.y
                        local x = db.devMode and poi.x or riftOffsets and riftOffsets[poiFrame.riftIndex] and riftOffsets[poiFrame.riftIndex].x or poi.x
                        local y = db.devMode and poi.y or riftOffsets and riftOffsets[poiFrame.riftIndex] and riftOffsets[poiFrame.riftIndex].y or poi.y
                        poiFrame:ClearAllPoints()
                        poiFrame:SetPoint("CENTER",MethodDungeonTools.main_frame.mapPanelTile1,"TOPLEFT",x*scale,y*scale)
                        if data.expanded then
                            poiFrame:Show()
                        end
                        tinsert(points,poiFrame)
                        break
                    end
                end
            end
        end
    end

end