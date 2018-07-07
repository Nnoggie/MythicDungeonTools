--- DateTime: 23.06.2018 17:18
local MethodDungeonTools = MethodDungeonTools
local AceGUI = LibStub("AceGUI-3.0")
local db
local tonumber,tinsert,slen,pairs,ipairs,tostring,next,type,sformat,tremove = tonumber,table.insert,string.len,pairs,ipairs,tostring,next,type,string.format,table.remove
local UnitName,UnitGUID,UnitCreatureType,UnitHealthMax,UnitLevel = UnitName,UnitGUID,UnitCreatureType,UnitHealthMax,UnitLevel


function MethodDungeonTools:POI_CreateFramePools()
    MethodDungeonTools.poi_framePools = MethodDungeonTools.poi_framePools or CreatePoolCollection()
    MethodDungeonTools.poi_framePools:CreatePool("Button", MethodDungeonTools.main_frame.mapPanelFrame, "MapLinkPinTemplate");
    MethodDungeonTools.poi_framePools:CreatePool("Button", MethodDungeonTools.main_frame.mapPanelFrame, "DeathReleasePinTemplate");
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
            local pois = MethodDungeonTools.mapPOIs[db.currentDungeonIdx][MethodDungeonTools:GetCurrentSubLevel()]
            pois[self.poiIdx].x = newx
            pois[self.poiIdx].y = newy
            self:ClearAllPoints()
            MethodDungeonTools:UpdateMap()
        end
    end)
    frame:SetScript("OnClick",nil)
end

local function POI_SetOptions(frame,type,poi)
    if type == "mapLink" then
        frame:SetSize(22,22)
        frame.Texture:SetSize(22,22)
        frame.HighlightTexture:SetSize(22,22)
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
            GameTooltip:SetText(MethodDungeonTools:GetDungeonSublevels()[db.currentDungeonIdx][poi.target])
            GameTooltip:Show()
        end)
        frame:SetScript("OnLeave",function()
            GameTooltip:Hide()
        end)
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
            GameTooltip:SetText(poi.doorName..(slen(poi.doorDescription)>0 and "\n"..poi.doorDescription or "")..(poi.lockpick and "\n".."|cFF32CD32Locked" or ""))
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
            GameTooltip:SetText("Graveyard"..(slen(poi.graveyardDescription)>0 and "\n"..poi.graveyardDescription or ""))
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
            GameTooltip:SetText("Discarded Cell Key\nPossible Spawn Location\nOpens 1x Prison Bars")
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
            GameTooltip:SetText("Heavy Cannon\nUsable by players\nDamages both enemies and allies")
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
            GameTooltip:SetText("Fracking Totem\nUsable by players\nIncapacitates Earthrager for 1min - Breaks on Damage")
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
            GameTooltip:SetText("Mine Cart\nUsable by players")
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
            GameTooltip:SetText("Shortcut\nUnlocks after killing Sporecaller Zancha")
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
            GameTooltip:SetText("Eye of Sethraliss\nBring both Eyes to the Skull of Sethraliss")
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
            GameTooltip:SetText("Untainted Spirit Guide\nUnlocks after defeating Purification Construct 1")
            GameTooltip:Show()
        end)
        frame:SetScript("OnLeave",function()
            GameTooltip:Hide()
        end)
    end
    if db.devMode then POI_SetDevOptions(frame,poi) end
end


local selectorGroup
local function toggleFreeholdSelector(show)

    if not selectorGroup then
        selectorGroup = AceGUI:Create("SimpleGroup")
        selectorGroup.frame:SetFrameStrata("HIGH")
        selectorGroup.frame:SetFrameLevel(50)
        MethodDungeonTools:FixAceGUIShowHide(selectorGroup)
        selectorGroup:SetLayout("Flow")
        local label = AceGUI:Create("Label")
        label:SetText("  Join Crew:")
        selectorGroup:AddChild(label)
        local checkBoxes = {}
        for i = 1,3 do
            local check = AceGUI:Create("CheckBox")
            check:SetLabel((i==1 and "Bilge Rats") or (i==2 and "Blacktooth") or (i==3 and "Cutwater"))
            selectorGroup:AddChild(check)
            tinsert(checkBoxes,check)
            check:SetCallback("OnValueChanged",function(widget,callbackName,value)
                for idx,box in ipairs(checkBoxes) do
                    box:SetValue(idx==i and value)
                end
                MethodDungeonTools:GetCurrentPreset().freeholdCrew = (value and i) or nil

            end)
        end
        selectorGroup.frame:ClearAllPoints()
        selectorGroup:ClearAllPoints()
        selectorGroup:SetWidth(120)
        selectorGroup:SetHeight(90)
        selectorGroup.frame:SetPoint("TOPRIGHT",MethodDungeonTools.main_frame,"TOPRIGHT",0,0)

        local function updateCheckboxStates()
            for idx,box in ipairs(checkBoxes) do
                local crew = MethodDungeonTools:GetCurrentPreset().freeholdCrew
                box:SetValue(crew and idx==crew)
            end
        end
        --hook UpdateMap
        local originalFunc = MethodDungeonTools.UpdateMap
        function MethodDungeonTools:UpdateMap(...)
            originalFunc(...)
            updateCheckboxStates()
        end
        updateCheckboxStates()

    end

    if show then
        selectorGroup.frame:Show()
    else
        selectorGroup.frame:Hide()
    end

end


---UpdateMapLinks
---Draws all map links on the current sublevel
function MethodDungeonTools:POI_UpdateAll()
    db = MethodDungeonTools:GetDB()
    toggleFreeholdSelector(db.currentDungeonIdx == 16)
    local framePools = MethodDungeonTools.poi_framePools
    framePools:ReleaseAll()
    if not MethodDungeonTools.mapPOIs[db.currentDungeonIdx] then return end
    local pois = MethodDungeonTools.mapPOIs[db.currentDungeonIdx][MethodDungeonTools:GetCurrentSubLevel()]
    if not pois then return end
    for poiIdx,poi in pairs(pois) do
        local poiFrame = framePools:Acquire(poi.template)
        poiFrame.poiIdx = poiIdx
        POI_SetOptions(poiFrame,poi.type,poi)
        poiFrame:SetPoint("CENTER",MethodDungeonTools.main_frame.mapPanelTile1,"TOPLEFT",poi.x,poi.y)
        poiFrame:Show()
    end

end