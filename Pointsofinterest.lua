--- DateTime: 23.06.2018 17:18
local MethodDungeonTools = MethodDungeonTools
local db
local tonumber,tinsert,slen,pairs,ipairs,tostring,next,type,sformat,tremove,twipe = tonumber,table.insert,string.len,pairs,ipairs,tostring,next,type,string.format,table.remove,table.wipe
local UnitName,UnitGUID,UnitCreatureType,UnitHealthMax,UnitLevel = UnitName,UnitGUID,UnitCreatureType,UnitHealthMax,UnitLevel

local points = {}

function MethodDungeonTools:POI_CreateFramePools()
    MethodDungeonTools.poi_framePools = MethodDungeonTools.poi_framePools or CreatePoolCollection()
    MethodDungeonTools.poi_framePools:CreatePool("Button", MethodDungeonTools.main_frame.mapPanelFrame, "MapLinkPinTemplate")
    MethodDungeonTools.poi_framePools:CreatePool("Button", MethodDungeonTools.main_frame.mapPanelFrame, "DeathReleasePinTemplate")
    MethodDungeonTools.poi_framePools:CreatePool("Button", MethodDungeonTools.main_frame.mapPanelFrame, "VignettePinTemplate")
    MethodDungeonTools.poi_framePools:CreatePool("Frame", MethodDungeonTools.main_frame.mapPanelFrame, "MDTAnimatedLineTemplate")
end

--devMode
local function POI_SetDevOptions(frame,poi)
    frame:SetMovable(true)
    frame:EnableMouse(true)
    frame:SetScript("OnMouseDown", function(self, button)
        if button == "LeftButton" and not self.isMoving then
            self:StartMoving()
            self.isMoving = true
        end
        if button == "RightButton" then
            local pois = MethodDungeonTools.mapPOIs[db.currentDungeonIdx][MethodDungeonTools:GetCurrentSubLevel()]
            tremove(pois,self.poiIdx)
            MethodDungeonTools:UpdateMap()
        end
    end)
    frame:SetScript("OnMouseUp", function(self, button)
        if button == "LeftButton" and self.isMoving then
            self.isMoving = false
            self:StopMovingOrSizing()
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
    frame.poi = nil
    frame.spireIndex = nil
    frame.defaultHidden = nil
    frame:SetMovable(false)
    frame:SetScript("OnMouseDown",nil)
    frame:SetScript("OnMouseUp",nil)
    frame.weeks = poi.weeks
    frame:SetFrameLevel(4)
    frame.defaultSublevel = nil
    frame.animatedLine = nil
    frame.npcId = nil
    if frame.HighlightTexture then
        frame.HighlightTexture:SetDrawLayer("HIGHLIGHT")
        frame.HighlightTexture:Show()
        frame.Texture:SetVertexColor(1,1,1,1)
        frame.HighlightTexture:SetVertexColor(1,1,1,1)
    end
    if frame.textString then frame.textString:Hide() end
    if type == "mapLink" then
        local poiScale = poi.scale or 1
        frame:SetSize(22*poiScale,22*poiScale)
        frame.Texture:SetSize(22*poiScale,22*poiScale)
        frame.HighlightTexture:SetSize(22*poiScale,22*poiScale)
        frame.HighlightTexture:SetDrawLayer("ARTWORK")
        frame.HighlightTexture:Hide()
        frame.target = poi.target
        frame.poi = poi
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
            MethodDungeonTools:ZoomMapToDefault()
        end)
        frame:SetScript("OnEnter",function()
            GameTooltip:SetOwner(UIParent, "ANCHOR_CURSOR")
            GameTooltip:AddLine(MethodDungeonTools:GetDungeonSublevels()[db.currentDungeonIdx][poi.target], 1, 1, 1, 1)
            if db.devMode then GameTooltip:AddLine(frame.poi.connectionIndex, 1, 1, 1, 1) end
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
        frame.poiScale = poiScale
        frame:SetSize(12*poiScale,12*poiScale)
        frame.Texture:SetSize(12*poiScale,12*poiScale)
        frame.Texture:SetAtlas("poi-rift1")
        frame.HighlightTexture:SetSize(12*poiScale,12*poiScale)
        frame.HighlightTexture:SetAtlas("poi-rift1")
        frame.HighlightTexture:SetDrawLayer("ARTWORK")
        frame.HighlightTexture:Hide()
        frame.isSpire = true
        frame.spireIndex = poi.index
        frame.npcId = poi.npcId
        if not frame.textString then
            frame.textString = frame:CreateFontString()
            frame.textString:SetPoint("BOTTOM",frame,"BOTTOM", 0, 4)
            frame.textString:SetJustifyH("CENTER")
            frame.textString:SetTextColor(0.5, 1, 0, 1)
        end
        local scale = MethodDungeonTools:GetScale()
        frame.textString:SetFontObject("GameFontNormal")
        frame.textString:SetFont(frame.textString:GetFont(),5*poiScale*scale,"OUTLINE")
        frame.textString:SetPoint("BOTTOM",frame,"BOTTOM", 0, 4*scale)
        frame.textString:SetText("")
        frame:SetScript("OnMouseUp",function(self,button)
            if button == "RightButton" then
                --reset npc location
                MethodDungeonTools:GetRiftOffsets()[self.npcId]=nil
                MethodDungeonTools:UpdateMap()
                if MethodDungeonTools.liveSessionActive then MethodDungeonTools:LiveSession_SendCorruptedPositions(MethodDungeonTools:GetCurrentPreset().value.riftOffsets) end
            end
            if button == "LeftButton" then
                local _, connections = MethodDungeonTools:FindConnectedDoor(frame.npcId,1)
                if connections then
                    MethodDungeonTools:SetCurrentSubLevel(connections[#connections].target)
                    MethodDungeonTools:UpdateMap()
                end
            end
        end)
        local blipFrame
        frame:SetScript("OnEnter",function()
            GameTooltip:SetOwner(UIParent, "ANCHOR_CURSOR")
            GameTooltip:AddLine(poi.tooltipText,1,1,1)
            GameTooltip:AddLine("Right-Click to reset NPC position",1,1,1)
            frame.HighlightTexture:Show()
            --highlight associated npc
            local blips = MethodDungeonTools:GetDungeonEnemyBlips()
            if frame.isSpire then
                for _,blip in pairs(blips) do
                    if blip.data.id == poi.npcId then
                        local isBlipSameWeek
                        for weekIdx,_ in pairs(poi.weeks) do
                            isBlipSameWeek = isBlipSameWeek or blip.clone.week[weekIdx]
                        end
                        if isBlipSameWeek then
                            blipFrame = blip
                            blipFrame.fontstring_Text1:Show()
                            --display animated line between poi and npc frame
                            frame.animatedLine = MethodDungeonTools:ShowAnimatedLine(MethodDungeonTools.main_frame.mapPanelFrame,frame,blipFrame,nil,nil,nil,nil,nil,not frame.isSpire,frame.animatedLine)
                            blipFrame.animatedLine = frame.animatedLine
                            break
                        end
                    end
                end
            end

            local connectedDoor, connections = MethodDungeonTools:FindConnectedDoor(frame.npcId,1)
            if connectedDoor then
                if frame.isSpire then
                    frame.animatedLine = MethodDungeonTools:ShowAnimatedLine(MethodDungeonTools.main_frame.mapPanelFrame,frame,connectedDoor,nil,nil,nil,nil,nil,not frame.isSpire,frame.animatedLine)
                end
                local sublevelName = MethodDungeonTools:GetSublevelName(nil,connections[#connections].target)
                local npcName = MethodDungeonTools:GetNPCNameById(frame.npcId)
                GameTooltip:AddLine("\n"..npcName.." is in sublevel: "..sublevelName,1,1,1)
                GameTooltip:AddLine("Click to go to "..sublevelName,1,1,1)
            end
            GameTooltip:Show()
        end)
        frame:SetScript("OnLeave",function()
            GameTooltip:Hide()
            frame.HighlightTexture:Hide()
            if blipFrame then
                blipFrame.fontstring_Text1:Hide()
            end
            if frame.isSpire then
                MethodDungeonTools:HideAnimatedLine(frame.animatedLine)
            end
        end)
        --check expanded status
        if MethodDungeonTools:IsNPCInPulls(poi) then
            frame.Texture:SetSize(10*poiScale,10*poiScale)
            frame.Texture:SetAtlas("poi-rift1")
            frame.HighlightTexture:SetSize(10*poiScale,10*poiScale)
            frame.HighlightTexture:SetAtlas("poi-rift1")
            frame.isSpire = false
            frame.textString:Show()
        else
            frame.Texture:SetSize(12*poiScale,16*poiScale)
            frame.Texture:SetAtlas("poi-nzothpylon")
            frame.HighlightTexture:SetSize(12*poiScale,16*poiScale)
            frame.HighlightTexture:SetAtlas("poi-nzothpylon")
            frame.isSpire = true
            frame.textString:Hide()
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
        local scale = poi.scale or 1
        frame:SetSize(12*scale,12*scale)
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
            GameTooltip:AddLine("Note on Devouring Maggots:\n\nDevouring Maggots with the buff 'Parasitic' will try to 'Infest' Players\nUpon successfull cast of 'Infest' the Devouring Maggot will disappear and spawn 2x Devouring Maggots after a debuff on the infested player runs out.\nYou can only gain 1 count for killing the initial Infested Maggot - the 2 newly spawned Infested Maggots do not give count.\n\nInfected Peasants spawn 3x Devouring Maggots which do give 1 count each.\nThese Devouring Maggots are mapped next to the Infected Peasants", 1, 1, 1, 1)
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
            GameTooltip:AddLine("Note on Teeming:\n\nG29 is not always present.\nTeeming enemies of G2 are not always present.\nG27 is not always present", 1, 1, 1, 1)
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
            GameTooltip:AddLine("Note on Gutters:\nFootmen will insta-kill Gutters when a player comes near them. If they die without taking damage from the group they will not give any enemy forces", 1, 1, 1, 1)
            GameTooltip:Show()
        end)
        frame:SetScript("OnLeave",function()
            GameTooltip:Hide()
        end)
    end
    if type =="generalNote" then
        frame:SetSize(10*(poi.scale or 1),10*(poi.scale or 1))
        frame.Texture:SetSize(10*(poi.scale or 1),10*(poi.scale or 1))
        frame.HighlightTexture:SetSize(10*(poi.scale or 1),10*(poi.scale or 1))
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
    if type =="mechagonBot" then
        frame:SetSize(3,3)
        frame.Texture:SetSize(6,6)
        frame.HighlightTexture:SetSize(6,6)
        frame.HighlightTexture:SetAtlas("Warfronts-BaseMapIcons-Empty-Workshop-Minimap-small")
        frame.Texture:SetAtlas("Warfronts-BaseMapIcons-Empty-Workshop-Minimap-small")
        local botOptions = {
            [1] = {text="Welding Bot",color={r=0, g=1, b=0, a=0.8}, spellId=303952, textureId=134952}, --green
            [2] = {text="Grease Bot",color={r=1, g=0, b=0, a=0.8}, spellId=303924, textureId=252178}, --red
            [3] = {text="Shock Bot",color={r=0, g=.8, b=1, a=0.8}, spellId=304063, textureId=136099}, --blue
        }
        frame.Texture:SetVertexColor(botOptions[poi.botIndex].color.r,botOptions[poi.botIndex].color.g,botOptions[poi.botIndex].color.b,botOptions[poi.botIndex].color.a)
        frame.HighlightTexture:SetVertexColor(botOptions[poi.botIndex].color.r,botOptions[poi.botIndex].color.g,botOptions[poi.botIndex].color.b,botOptions[poi.botIndex].color.a)
        frame:SetScript("OnClick",function()

        end)
        frame:SetScript("OnEnter",function()
            GameTooltip:SetOwner(UIParent, "ANCHOR_CURSOR")
            GameTooltip_SetTitle(GameTooltip, botOptions[poi.botIndex].text)
            GameTooltip:AddTexture(botOptions[poi.botIndex].textureId)
            GameTooltip:AddSpellByID(botOptions[poi.botIndex].spellId)
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

---POI_HideAllPoints
---Used to hide all POIs during scaling changes to the map
function MethodDungeonTools:POI_HideAllPoints()
    for _,poiFrame in pairs(points) do
        poiFrame:Hide()
    end
end

---POI_UpdateAll
function MethodDungeonTools:POI_UpdateAll()
    twipe(points)
    db = MethodDungeonTools:GetDB()
    local framePools = MethodDungeonTools.poi_framePools
    framePools:GetPool("MapLinkPinTemplate"):ReleaseAll()
    framePools:GetPool("DeathReleasePinTemplate"):ReleaseAll()
    framePools:GetPool("VignettePinTemplate"):ReleaseAll()
    if not MethodDungeonTools.mapPOIs[db.currentDungeonIdx] then return end
    local currentSublevel = MethodDungeonTools:GetCurrentSubLevel()
    local pois = MethodDungeonTools.mapPOIs[db.currentDungeonIdx][currentSublevel]
    if not pois then return end
    local preset = MethodDungeonTools:GetCurrentPreset()
    local teeming = MethodDungeonTools:IsPresetTeeming(preset)
    local scale = MethodDungeonTools:GetScale()
    local week = MethodDungeonTools:GetEffectivePresetWeek(preset)
    for poiIdx,poi in pairs(pois) do
        if (not (poi.type == "nyalothaSpire" and (db.currentSeason ~= 4 or db.currentDifficulty<10)))
            and ((not poi.weeks) or poi.weeks[week])
            and (not poi.season or poi.season == db.currentSeason)
            and (not poi.difficulty or poi.difficulty<=db.currentDifficulty)
        then
            local poiFrame = framePools:Acquire(poi.template)
            poiFrame.poiIdx = poiIdx
            POI_SetOptions(poiFrame,poi.type,poi)
            poiFrame.x = poi.x
            poiFrame.y = poi.y
            poiFrame:ClearAllPoints()
            poiFrame:SetPoint("CENTER",MethodDungeonTools.main_frame.mapPanelTile1,"TOPLEFT",poi.x*scale,poi.y*scale)
            if not poiFrame.defaultHidden or db.devMode then poiFrame:Show() end
            if not teeming and poiFrame.teeming then
                poiFrame:Hide()
            end
            tinsert(points,poiFrame)
        end
    end
end

---Animated Lines
---Credit to Grimonja for this part
local texturePool

local function getPointAlongALine(parent,p1x,p1y,p2x,p2y,d)
    local tX = (((1 - d) * p1x) + (d*p2x)) - ((parent:GetWidth() / 2 ))
    local tY = (((1 - d) * p1y) + (d*p2y)) - ((parent:GetHeight() / 2))
    return tX,tY
end

local function createLineSegment(parent)
    local tex = texturePool:Acquire()
    tex:SetParent(parent)
    tex:SetTexture([[Interface\BUTTONS\WHITE8X8]])
    tex:SetTexCoord(0,1,0,1)
    tex:SetDrawLayer("OVERLAY",7)
    tex:Show()
    return tex
end

local function animateLine(self, elapsed)

    local totalDistance = math.sqrt(math.pow(self.frameTwoX - self.frameOneX,2) + math.pow(self.frameTwoY - self.frameOneY,2))
    local rotation = math.atan2(self.frameTwoY - self.frameOneY,self.frameTwoX - self.frameOneX)
    local numLines = math.max(1,math.floor(totalDistance / (self.sizeX + self.gap)))
    local lineLength = (totalDistance / (numLines * 2))
    local tX,tY,t,tex
    for i=1,numLines + 1 do
        tex = self.frames[i]
        if(not tex)then
            tex = createLineSegment(self:GetParent())
            table.insert(self.frames,tex)
        end
        t = self.phase + (((lineLength * 2) * (i - 1)) / totalDistance)
        if(t > 1)then
            t = t - 1
        end
        tX, tY = getPointAlongALine(self:GetParent(),self.frameOneX,self.frameOneY,self.frameTwoX,self.frameTwoY,t)
        tex:SetPoint("TOPLEFT",MethodDungeonTools.main_frame.mapPanelTile1,"TOPLEFT",tX - (self.sizeX / 2),tY - (self.sizeY / 2))
        tex:SetPoint("BOTTOMRIGHT",MethodDungeonTools.main_frame.mapPanelTile1,"TOPLEFT",tX + (self.sizeX / 2),tY + (self.sizeY / 2))
        tex:SetPoint("CENTER",tX, tY)
        tex:SetRotation(rotation)
        tex:SetVertexColor(self.color[1],self.color[2],self.color[3],self.color[4])
        tex:Show()
    end

    if(#self.frames > numLines + 1)then
        for i=numLines + 1,#self.frames do
            self.frames[i]:Hide()
        end
    end

    self.phase = self.phase + (self.speed * elapsed)
    if(self.phase > 1)then
        self.phase = self.phase - 1
    end
end

local function createAnimatedLine(parent)
    --MethodDungeonTools:DungeonEnemies_UpdateSeasonalAffix() --why do i need this?
    local animatedLine = MethodDungeonTools.poi_framePools:Acquire("MDTAnimatedLineTemplate")
    animatedLine:Show()
    animatedLine.phase = 0
    animatedLine.frames = {}
    return animatedLine
end

function MethodDungeonTools:ShowAnimatedLine(parent, frame1, frame2, sizeX, sizeY, gap, color, speed,selected,animatedLine)
    if not (frame1 and frame2 and (not frame1:IsForbidden()) and (not frame1:IsForbidden())) then
        return nil
    end
    texturePool = texturePool or CreateTexturePool(MethodDungeonTools.main_frame.mapPanelFrame ,"OVERLAY",7,nil)
    animatedLine = animatedLine or createAnimatedLine(parent)
    animatedLine.frame1 = frame1
    animatedLine.frame2 = frame2
    animatedLine.speed = speed and speed or 15
    animatedLine.sizeX = sizeX and sizeX or 7
    animatedLine.sizeY = sizeY and sizeY or 2
    animatedLine.gap = gap and gap or 5
    animatedLine.color = color and color or {1,0,1,0.8,0.2} --corrupted color
    if selected then animatedLine.color = {0.5,1,0.1,1} end

    local scale = MethodDungeonTools:GetScale()
    local mapSizex,mapSizey = MethodDungeonTools:GetDefaultMapPanelSize()
    animatedLine.frameOneX = ((mapSizex/2)+frame1.x)*scale
    animatedLine.frameOneY = ((mapSizey/2)+frame1.y)*scale
    animatedLine.frameTwoX = ((mapSizex/2)+(frame2.adjustedX or frame2.x))*scale
    animatedLine.frameTwoY = ((mapSizey/2)+(frame2.adjustedY or frame2.y))*scale

    local totalDistance = math.sqrt(math.pow(animatedLine.frameTwoX - animatedLine.frameOneX,2) + math.pow(animatedLine.frameTwoY - animatedLine.frameOneY,2))
    animatedLine.speed = animatedLine.speed / totalDistance
    animatedLine:SetScript("onUpdate", animateLine)
    animatedLine:Show()
    return animatedLine
end

function MethodDungeonTools:KillAllAnimatedLines()
    local linePool = self.poi_framePools:GetPool("MDTAnimatedLineTemplate")
    local _,activeLines = linePool:EnumerateActive()
    for animatedLine,_ in pairs(activeLines) do
        animatedLine:SetScript("onUpdate",nil)
        for i=1,#animatedLine.frames do
            animatedLine.frames[i]:ClearAllPoints()
            animatedLine.frames[i]:Hide()
        end
        table.wipe(animatedLine.frames)
        if animatedLine.frame1 then animatedLine.frame1.animatedLine = nil end
        if animatedLine.frame2 then
            animatedLine.frame1.animatedLine = nil
            animatedLine.frame1.spireFrame = nil
        end
        animatedLine:Hide()
    end
    if texturePool then texturePool:ReleaseAll() end
    linePool:ReleaseAll()
end

---draws all lines from active npcs to spires/doors
function MethodDungeonTools:DrawAllAnimatedLines()
    local week = self:GetEffectivePresetWeek()
    for _,blip in pairs(MethodDungeonTools:GetDungeonEnemyBlips()) do
        if not blip:IsShown() and blip.data.corrupted then
            MethodDungeonTools:HideAnimatedLine(blip.animatedLine)
        elseif blip.data.corrupted and blip.selected then
            local connectedFrame
            local _,active = MethodDungeonTools.poi_framePools:GetPool("VignettePinTemplate"):EnumerateActive()
            for poiFrame,_ in pairs(active) do
                if poiFrame.spireIndex and poiFrame.npcId and poiFrame.npcId == blip.data.id then
                    connectedFrame = poiFrame
                    break
                end
            end
            local connectedDoor = MethodDungeonTools:FindConnectedDoor(blip.data.id)
            connectedFrame = connectedDoor or connectedFrame
            blip.animatedLine = MethodDungeonTools:ShowAnimatedLine(MethodDungeonTools.main_frame.mapPanelFrame,connectedFrame,blip,nil,nil,nil,nil,nil,blip.selected)
            blip.spireFrame = connectedFrame
            connectedFrame.animatedLine = blip.animatedLine
        end
    end
    --draw lines from active spires to doors when their associated npc is dragged into other sublevel
    local _,activeSpires = MethodDungeonTools.poi_framePools:GetPool("VignettePinTemplate"):EnumerateActive()
    for poiFrame,_ in pairs(activeSpires) do
        if poiFrame.spireIndex and poiFrame.npcId and not poiFrame.isSpire and not poiFrame.animatedLine then
            local connectedDoor = MethodDungeonTools:FindConnectedDoor(poiFrame.npcId,1)
            if connectedDoor then
                poiFrame.animatedLine = MethodDungeonTools:ShowAnimatedLine(MethodDungeonTools.main_frame.mapPanelFrame,poiFrame,connectedDoor,nil,nil,nil,nil,nil,not poiFrame.isSpire)
            end
        end
    end
end

function MethodDungeonTools:HideAnimatedLine(animatedLine)
    if not animatedLine then return end
    for i=1,#animatedLine.frames do
        animatedLine.frames[i]:ClearAllPoints()
        animatedLine.frames[i]:Hide()
    end
    animatedLine:Hide()
end

function MethodDungeonTools:FindConnectedDoor(npcId,numConnection)
    local riftOffsets = self:GetRiftOffsets()
    local connection = riftOffsets and riftOffsets[npcId] and riftOffsets[npcId].connections and riftOffsets[npcId].connections[numConnection or #riftOffsets[npcId].connections] or nil
    if connection then
        local _,activeDoors = MethodDungeonTools.poi_framePools:GetPool("MapLinkPinTemplate"):EnumerateActive()
        for poiFrame,_ in pairs(activeDoors) do
            if poiFrame.poi and poiFrame.poi.connectionIndex == connection.connectionIndex then
                return poiFrame,riftOffsets[npcId].connections
            end
        end
    end
end