--- DateTime: 23.06.2018 17:18
local MethodDungeonTools = MethodDungeonTools
local db
local tonumber,tinsert,slen,pairs,ipairs,tostring,next,type,sformat,tremove = tonumber,table.insert,string.len,pairs,ipairs,tostring,next,type,string.format,table.remove
local UnitName,UnitGUID,UnitCreatureType,UnitHealthMax,UnitLevel = UnitName,UnitGUID,UnitCreatureType,UnitHealthMax,UnitLevel


function MethodDungeonTools:POI_CreateFramePools()
    MethodDungeonTools.POI_framePools = CreatePoolCollection()
    MethodDungeonTools.POI_framePools:CreatePool("Button", MethodDungeonTools.main_frame.mapPanelFrame, "MapLinkPinTemplate");
    MethodDungeonTools.POI_framePools:CreatePool("Button", MethodDungeonTools.main_frame.mapPanelFrame, "DeathReleasePinTemplate");
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
    if db.devMode then POI_SetDevOptions(frame,poi) end
end



---UpdateMapLinks
---Draws all map links on the current sublevel
function MethodDungeonTools:POI_UpdateAll()
    local framePools = MethodDungeonTools.POI_framePools
    db = MethodDungeonTools:GetDB()
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