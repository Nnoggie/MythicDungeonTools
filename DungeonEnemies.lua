---
--- DateTime: 04.07.2018 12:26
---
local MethodDungeonTools = MethodDungeonTools
local db
local tonumber,tinsert,slen,pairs,ipairs,tostring,next,type,sformat,twipe,max,tremove,DrawLine = tonumber,table.insert,string.len,pairs,ipairs,tostring,next,type,string.format,table.wipe,math.max,table.remove,DrawLine

local blips = {}
local preset
local selectedGreen = {34/255,139/255,34/255,0.7}
local patrolColor = {0,0.5,1,0.8}
local corruptedColor = {1,0,1,0.8}

function MethodDungeonTools:GetDungeonEnemyBlips()
    return blips
end

MethodDungeonTools.reapingStatic = {
    ["148716"] = {
        ["name"] = "Risen Soul",
        ["iconTexture"] = "Interface\\Icons\\Ability_warlock_soulsiphon",
        ["abilities"] = {},
        ["npcId"] = 148716,
        ["outline"] = { 1.02, 0, 2.04, 1 }
    },
    ["148893"] = {
        ["name"] = "Tormented Soul",
        ["iconTexture"] = "Interface\\Icons\\spell_shadow_soulleech_1",
        ["abilities"] = {},
        ["npcId"] = 148893,
            ["outline"] = { 0, 2.04, 1.02, 1 }
    },
    ["148894"] = {
        ["name"] = "Lost Soul",
        ["iconTexture"] = "Interface\\Icons\\ability_warlock_improvedsoulleech",
        ["abilities"] = {},
        ["npcId"] = 148894,
        ["outline"] = { 2.04, 0, 2.04, 1 }
    },
}

--From http://wow.gamepedia.com/UI_coordinates
function MethodDungeonTools:DoFramesOverlap(frameA, frameB,offset)
    if not frameA or not frameB then return	end
    offset = offset or 0
    --frameA = frameA.texture_Background
    --frameB = frameB.texture_Background

    local sA, sB = frameA:GetEffectiveScale(), frameB:GetEffectiveScale();
    if not sA or not sB then return	end

    local frameALeft = frameA:GetLeft()-offset
    local frameARight = frameA:GetRight()+offset
    local frameABottom = frameA:GetBottom()-offset
    local frameATop = frameA:GetTop()+offset

    local frameBLeft = frameB:GetLeft()
    local frameBRight = frameB:GetRight()
    local frameBBottom = frameB:GetBottom()
    local frameBTop = frameB:GetTop()

    if not frameALeft or not frameARight or not frameABottom or not frameATop then return end
    if not frameBLeft or not frameBRight or not frameBBottom or not frameBTop then return end

    return ((frameALeft*sA) < (frameBRight*sB))
            and ((frameBLeft*sB) < (frameARight*sA))
            and ((frameABottom*sA) < (frameBTop*sB))
            and ((frameBBottom*sB) < (frameATop*sA));
end


MDTDungeonEnemyMixin = {};

local defaultSizes = {
    ["texture_Background"] = 20,
    ["texture_Portrait"] = 15,
    ["texture_MouseHighlight"] = 20,
    ["texture_SelectedHighlight"] = 20,
    ["texture_Reaping"] = 8,
    ["texture_Dragon"] = 26,
    ["texture_Indicator"] = 20,
    ["texture_PullIndicator"] = 23,
    ["texture_DragDown"] = 8,
    ["texture_DragLeft"] = 8,
    ["texture_DragRight"] = 8,
    ["texture_DragUp"] = 8,
}

function MDTDungeonEnemyMixin:updateSizes(scale)
    for tex,size in pairs(defaultSizes) do
        self[tex]:SetSize(size*self.normalScale*scale,size*self.normalScale*scale)
    end
end

function MDTDungeonEnemyMixin:OnEnter()
    self:updateSizes(1.2)
    self:SetFrameLevel(self:GetFrameLevel()+5)
    self:DisplayPatrol(true)
    MethodDungeonTools:DisplayBlipTooltip(self,true)
    if self.data.corrupted then
        self.texture_DragDown:Show()
        self.texture_DragLeft:Show()
        self.texture_DragRight:Show()
        self.texture_DragUp:Show()
        if not self.selected then
            local _,active = MethodDungeonTools.poi_framePools:GetPool("VignettePinTemplate"):EnumerateActive()
            for poiFrame,_ in pairs(active) do
                if poiFrame.spireIndex and poiFrame.npcId == self.data.id then
                    poiFrame.HighlightTexture:Show()
                    self.spireFrame = poiFrame
                    self.animatedLine = MethodDungeonTools:ShowAnimatedLine(MethodDungeonTools.main_frame.mapPanelFrame,self.spireFrame,self,nil,nil,nil,nil,nil,self.selected,self.animatedLine)
                    self.spireFrame.animatedLine = self.animatedLine
                    break
                end
            end
            local connectedDoor = MethodDungeonTools:FindConnectedDoor(self.data.id)
            if connectedDoor then
                self.animatedLine = MethodDungeonTools:ShowAnimatedLine(MethodDungeonTools.main_frame.mapPanelFrame,connectedDoor,self,nil,nil,nil,nil,nil,self.selected,self.animatedLine)
            end
        end
    end
    self.fontstring_Text1:SetText(MethodDungeonTools:IsCurrentPresetTeeming() and self.data.teemingCount or self.data.count)
    if not self.clone.g then
        self.fontstring_Text1:Show()
        return
    end
    for _,blip in pairs(blips) do
        if blip.clone.g == self.clone.g then
            blip.fontstring_Text1:SetText(MethodDungeonTools:IsCurrentPresetTeeming() and blip.data.teemingCount or blip.data.count)
            blip.fontstring_Text1:Show()
        end
    end
end

function MDTDungeonEnemyMixin:OnLeave()
    self:updateSizes(1)
    self:SetFrameLevel(self:GetFrameLevel()-5)
    if db.devMode then
        if not self.devSelected then self:DisplayPatrol(false) end
    else
        self:DisplayPatrol(false)
    end
    MethodDungeonTools:DisplayBlipTooltip(self,false)
    if self.data.corrupted then
        self.texture_DragDown:Hide()
        self.texture_DragLeft:Hide()
        self.texture_DragRight:Hide()
        self.texture_DragUp:Hide()
        local _,active = MethodDungeonTools.poi_framePools:GetPool("VignettePinTemplate"):EnumerateActive()
        for poiFrame,_ in pairs(active) do
            if poiFrame.spireIndex and poiFrame.npcId == self.data.id then
                poiFrame.HighlightTexture:Hide()
                break
            end
        end
        if not self.selected then
            MethodDungeonTools:HideAnimatedLine(self.animatedLine)
        end
    end
    if not self.clone.g then
        self.fontstring_Text1:Hide()
        return
    end
    for _,blip in pairs(blips) do
        if blip.clone.g == self.clone.g then
            blip.fontstring_Text1:Hide()
        end
    end
end

function MDTDungeonEnemyMixin:OnClick(button, down)

    if button == "LeftButton" then
        if IsShiftKeyDown() then
            local newPullIdx = MethodDungeonTools:GetCurrentPull() + 1
            MethodDungeonTools:PresetsAddPull(newPullIdx)
            MethodDungeonTools:GetCurrentPreset().value.selection = {newPullIdx}
            MethodDungeonTools:ReloadPullButtons()
            MethodDungeonTools:SetSelectionToPull(newPullIdx)
        end
        MethodDungeonTools:DungeonEnemies_AddOrRemoveBlipToCurrentPull(self,not self.selected,IsControlKeyDown())
        MethodDungeonTools:DungeonEnemies_UpdateSelected(MethodDungeonTools:GetCurrentPull())
        MethodDungeonTools:UpdateProgressbar()
        MethodDungeonTools:ReloadPullButtons()
        if MethodDungeonTools.liveSessionActive and MethodDungeonTools:GetCurrentPreset().uid == MethodDungeonTools.livePresetUID then
            MethodDungeonTools:LiveSession_SendPulls(MethodDungeonTools:GetPulls())
        end
        if self.data.corrupted then
            local connectedFrame
            local _,active = MethodDungeonTools.poi_framePools:GetPool("VignettePinTemplate"):EnumerateActive()
            for poiFrame,_ in pairs(active) do
                if poiFrame.spireIndex and poiFrame.npcId and poiFrame.npcId == self.data.id then
                    if self.selected then
                        poiFrame.Texture:SetAtlas("poi-rift1")
                        poiFrame.Texture:SetSize(17*poiFrame.poiScale,17*poiFrame.poiScale)
                        poiFrame.HighlightTexture:SetAtlas("poi-rift1")
                        poiFrame.HighlightTexture:SetSize(17*poiFrame.poiScale,17*poiFrame.poiScale)
                        poiFrame.isSpire = false
                        poiFrame.ShowAnim:Play()
                        poiFrame.textString:Show()
                    else
                        poiFrame.Texture:SetSize(16*poiFrame.poiScale,22*poiFrame.poiScale)
                        poiFrame.Texture:SetAtlas("poi-nzothpylon")
                        poiFrame.HighlightTexture:SetSize(16,22*poiFrame.poiScale,22,22*poiFrame.poiScale)
                        poiFrame.HighlightTexture:SetAtlas("poi-nzothpylon")
                        poiFrame.isSpire = true
                        poiFrame.ShowAnim:Play()
                        poiFrame.textString:Hide()
                    end
                    connectedFrame = poiFrame
                    break
                end
            end
            local connectedDoor = MethodDungeonTools:FindConnectedDoor(self.data.id)
            connectedFrame = connectedDoor or connectedFrame
            self.animatedLine = MethodDungeonTools:ShowAnimatedLine(MethodDungeonTools.main_frame.mapPanelFrame,connectedFrame,self,nil,nil,nil,nil,nil,self.selected,self.animatedLine)
            connectedFrame.animatedLine = self.animatedLine
            if MethodDungeonTools.liveSessionActive and MethodDungeonTools:GetCurrentPreset().uid == MethodDungeonTools.livePresetUID then
                MethodDungeonTools:LiveSession_SendCorruptedPositions(preset.value.riftOffsets)
            end
        end
    elseif button == "RightButton" then
        if db.devMode then
            if IsAltKeyDown() then
                tremove(MethodDungeonTools.dungeonEnemies[db.currentDungeonIdx][self.enemyIdx].clones,self.cloneIdx)
                self:Hide()
            else
                self.devSelected = (not self.devSelected) or nil
                self:DisplayPatrol(self.devSelected)
                for blipIdx,blip in pairs(blips) do
                    if blip ~= self then
                        blip.devSelected = nil
                    end
                    if blip.devSelected then
                        blip.texture_Portrait:SetVertexColor(1,0,0,1)
                    else
                        blip.texture_Portrait:SetVertexColor(1,1,1,1)
                    end
                end
            end
            MethodDungeonTools:UpdateMap()
        else
            MethodDungeonTools:ShowEnemyInfoFrame(self)
        end
    end
end

local patrolPoints =  {}
local patrolLines = {}

function MethodDungeonTools:GetPatrolBlips()
    return patrolPoints
end

function MDTDungeonEnemyMixin:DisplayPatrol(shown)
    local scale = MethodDungeonTools:GetScale()

    --Hide all points/line
    for _,point in pairs(patrolPoints) do point:Hide() end
    for _,line in pairs(patrolLines) do line:Hide() end
    if not shown then return end

    if self.clone.patrol then
        local firstWaypointBlip
        local oldWaypointBlip
        for patrolIdx,waypoint in ipairs(self.clone.patrol) do
            patrolPoints[patrolIdx] = patrolPoints[patrolIdx] or MethodDungeonTools.main_frame.mapPanelFrame:CreateTexture("MethodDungeonToolsDungeonPatrolPoint"..patrolIdx,"BACKGROUND")


            patrolPoints[patrolIdx]:SetDrawLayer("OVERLAY", 2)
            patrolPoints[patrolIdx]:SetTexture("Interface\\Worldmap\\X_Mark_64Grey")
            patrolPoints[patrolIdx]:SetSize(4*scale,4*scale)
            patrolPoints[patrolIdx]:SetVertexColor(0,0.2,0.5,0.6)
            patrolPoints[patrolIdx]:ClearAllPoints()
            patrolPoints[patrolIdx]:SetPoint("CENTER",MethodDungeonTools.main_frame.mapPanelTile1,"TOPLEFT",waypoint.x*scale,waypoint.y*scale)
            patrolPoints[patrolIdx].x = waypoint.x
            patrolPoints[patrolIdx].y = waypoint.y
            patrolPoints[patrolIdx]:Show()

            patrolLines[patrolIdx] = patrolLines[patrolIdx] or MethodDungeonTools.main_frame.mapPanelFrame:CreateTexture("MethodDungeonToolsDungeonPatrolLine"..patrolIdx,"BACKGROUND")
            patrolLines[patrolIdx]:SetDrawLayer("OVERLAY", 1)
            patrolLines[patrolIdx]:SetTexture("Interface\\AddOns\\MethodDungeonTools\\Textures\\Square_White")
            patrolLines[patrolIdx]:SetVertexColor(0,0.2,0.5,0.6)
            patrolLines[patrolIdx]:Show()

            --connect 2 waypoints
            if oldWaypointBlip then
                local startPoint, startRelativeTo, startRelativePoint, startX, startY = patrolPoints[patrolIdx]:GetPoint()
                local endPoint, endRelativeTo, endRelativePoint, endX, endY = oldWaypointBlip:GetPoint()
                DrawLine(patrolLines[patrolIdx], MethodDungeonTools.main_frame.mapPanelTile1, startX, startY, endX, endY, 1*scale, 1,"TOPLEFT")
                patrolLines[patrolIdx]:Show()
            else
                firstWaypointBlip = patrolPoints[patrolIdx]
            end
            oldWaypointBlip = patrolPoints[patrolIdx]
        end
        --connect last 2 waypoints
        if firstWaypointBlip and oldWaypointBlip then
            local startPoint, startRelativeTo, startRelativePoint, startX, startY = firstWaypointBlip:GetPoint()
            local endPoint, endRelativeTo, endRelativePoint, endX, endY = oldWaypointBlip:GetPoint()
            DrawLine(patrolLines[1], MethodDungeonTools.main_frame.mapPanelTile1, startX, startY, endX, endY, 1*scale, 1,"TOPLEFT")
            patrolLines[1]:Show()
        end

    else
        --find patrol leader if no patrol
        for _,blip in pairs(blips) do
            if blip:IsShown() and blip.clone.g and self.clone.g then
                if blip.clone.g == self.clone.g and blip.clone.patrol then
                    blip:DisplayPatrol(shown)
                end
            end
        end
    end

end

local ranOnce
function MethodDungeonTools:DisplayBlipTooltip(blip,shown)
    if not ranOnce then
        --fix elvui skinning
        MethodDungeonTools.tooltip:ClearAllPoints()
        MethodDungeonTools.tooltip:SetPoint("TOPLEFT",UIParent,"BOTTOMRIGHT")
        MethodDungeonTools.tooltip:SetPoint("BOTTOMRIGHT",UIParent,"BOTTOMRIGHT")
        MethodDungeonTools.tooltip:Show()
        MethodDungeonTools.tooltip:Hide()
        ranOnce = true
    end

    local tooltip = MethodDungeonTools.tooltip
    local data = blip.data
    if shown then
        tooltip.Model:SetCreature(data.id)
        tooltip.String:Show()
        tooltip:Show()
    else
        tooltip.String:Hide()
        tooltip:Hide()
        return
    end

    local boss = blip.data.isBoss or false
    local health = MethodDungeonTools:CalculateEnemyHealth(boss,data.health,db.currentDifficulty,data.ignoreFortified)
    local group = blip.clone.g and " (G "..blip.clone.g..")" or ""
    local upstairs = blip.clone.upstairs and CreateTextureMarkup("Interface\\MINIMAP\\MiniMap-PositionArrows", 16, 32, 16, 16, 0, 1, 0, 0.5,0,-50) or ""
    --[[
        function CreateAtlasMarkup(atlasName, height, width, offsetX, offsetY) return ("|A:%s:%d:%d:%d:%d|a"):format( atlasName , height or 0 , width or 0 , offsetX or 0 , offsetY or 0 );end
    ]]
    local occurence = (blip.data.isBoss and "") or blip.cloneIdx

    local text = upstairs..data.name.." "..occurence..group.."\nLevel "..data.level.." "..data.creatureType.."\n"..MethodDungeonTools:FormatEnemyHealth(health).." HP\n"
    local count = MethodDungeonTools:IsCurrentPresetTeeming() and data.teemingCount or data.count
    text = text .."Forces: "..MethodDungeonTools:FormatEnemyForces(count)
    local reapingText
    if blip.data.reaping and db.MDI.enabled and preset.mdi.beguiling == 13 then
        local reapingIcon = CreateTextureMarkup(MethodDungeonTools.reapingStatic[tostring(blip.data.reaping)].iconTexture, 32, 32, 16, 16, 0, 1, 0, 1,0,0) or ""
        reapingText = "Reaping: "..reapingIcon.." "..MethodDungeonTools.reapingStatic[tostring(blip.data.reaping)].name .. "\n"
    end
    if reapingText then text = text .. "\n" .. reapingText end
    text = text .."\n\n[Right click for more info]"
    tooltip.String:SetText(text)

    tooltip:ClearAllPoints()
    if db.tooltipInCorner then
        tooltip:SetPoint("BOTTOMRIGHT",MethodDungeonTools.main_frame,"BOTTOMRIGHT",0,0)
        tooltip:SetPoint("TOPLEFT",MethodDungeonTools.main_frame,"BOTTOMRIGHT",-tooltip.mySizes.x,tooltip.mySizes.y)
    else
        --check for bottom clipping
        tooltip:ClearAllPoints()
        tooltip:SetPoint("TOPLEFT",blip,"BOTTOMRIGHT",30,0)
        tooltip:SetPoint("BOTTOMRIGHT",blip,"BOTTOMRIGHT",30+tooltip.mySizes.x,-tooltip.mySizes.y)
        local bottomOffset = 0
        local rightOffset = 0
        local tooltipBottom = tooltip:GetBottom()
        local mainFrameBottom = MethodDungeonTools.main_frame:GetBottom()
        if tooltipBottom<mainFrameBottom then
            bottomOffset = tooltip.mySizes.y
        end
        --right side clipping
        local tooltipRight = tooltip:GetRight()
        local mainFrameRight = MethodDungeonTools.main_frame:GetRight()
        if tooltipRight>mainFrameRight then
            rightOffset = -(tooltip.mySizes.x+60)
        end

        tooltip:SetPoint("TOPLEFT",blip,"BOTTOMRIGHT",30+rightOffset,bottomOffset)
        tooltip:SetPoint("BOTTOMRIGHT",blip,"BOTTOMRIGHT",30+tooltip.mySizes.x+rightOffset,-tooltip.mySizes.y+bottomOffset)
    end

end



function MethodDungeonTools:GetCurrentDevmodeBlip()
    for blipIdx,blip in pairs(blips) do
        if blip.devSelected then
            return blip
        end
    end
end

--make blip movable in devMode and store new position
local function blipDevModeSetup(blip)
    blip:SetMovable(true)
    blip:RegisterForDrag("LeftButton")

    local xOffset,yOffset
    blip:SetScript("OnMouseDown",function()
        local x,y = MethodDungeonTools:GetCursorPosition()
        local scale = MethodDungeonTools:GetScale()
        x = x*(1/scale)
        y = y*(1/scale)
        local nx = MethodDungeonTools.dungeonEnemies[db.currentDungeonIdx][blip.enemyIdx].clones[blip.cloneIdx].x
        local ny = MethodDungeonTools.dungeonEnemies[db.currentDungeonIdx][blip.enemyIdx].clones[blip.cloneIdx].y
        xOffset = x-nx
        yOffset = y-ny
    end)
    blip:SetScript("OnDragStart", function()
        if not db.devModeBlipsMovable then return end
        blip:StartMoving()
    end)
    blip:SetScript("OnDragStop", function()
        if not db.devModeBlipsMovable then return end
        local x,y = MethodDungeonTools:GetCursorPosition()
        local scale = MethodDungeonTools:GetScale()
        x = x*(1/scale)
        y = y*(1/scale)
        x = x-xOffset
        y = y-yOffset
        blip:StopMovingOrSizing()
        blip:ClearAllPoints()
        blip:SetPoint("CENTER",MethodDungeonTools.main_frame.mapPanelTile1,"TOPLEFT",x*scale,y*scale)
        MethodDungeonTools.dungeonEnemies[db.currentDungeonIdx][blip.enemyIdx].clones[blip.cloneIdx].x = x
        MethodDungeonTools.dungeonEnemies[db.currentDungeonIdx][blip.enemyIdx].clones[blip.cloneIdx].y = y
    end)
end

local emissaryIds = {[155432]=true,[155433]=true,[155434]=true}

function MDTDungeonEnemyMixin:SetUp(data,clone)
    local scale = MethodDungeonTools:GetScale()
    self:ClearAllPoints()
    self:SetPoint("CENTER",MethodDungeonTools.main_frame.mapPanelTile1,"TOPLEFT",clone.x*scale,clone.y*scale)
    self.normalScale = data.scale*(data.isBoss and 1.7 or 1)*(MethodDungeonTools.scaleMultiplier[db.currentDungeonIdx] or 1)*scale
    self.normalScale = self.normalScale * 0.6
    self:SetSize(self.normalScale*13,self.normalScale*13)
    self:updateSizes(1)
    self.texture_Portrait:SetDesaturated(false)
    local raise = 4
    if not data.corrupted then
        for k,v in pairs(blips) do
            --only check neighboring blips - saves performance on big maps
            if ((clone.x-v.clone.x)^2+(clone.y-v.clone.y)^2<81) and MethodDungeonTools:DoFramesOverlap(self, v,5) then raise = max(raise,v:GetFrameLevel()+1) end
        end
    end
    self:SetFrameLevel(raise)
    self.fontstring_Text1:SetFontObject("GameFontNormal")
    self.fontstring_Text1:SetFont(self.fontstring_Text1:GetFont(),10*self.normalScale,"OUTLINE")
    self.fontstring_Text1:SetText((clone.isBoss and data.count == 0 and "") or data.count)
    self.texture_MouseHighlight:SetAlpha(0.4)
    self.texture_SelectedHighlight:SetVertexColor(unpack(selectedGreen))
    if data.isBoss then self.texture_Dragon:Show() else self.texture_Dragon:Hide() end
    self.texture_Background:SetVertexColor(1,1,1,1)
    if clone.patrol then self.texture_Background:SetVertexColor(unpack(patrolColor)) end
    self.data = data
    self.clone = clone
    self:Show()
    self:SetScript("OnUpdate",nil)
    --awakened/corrupted adjustments: movable and color and stored position
    if data.corrupted then
        self:SetFrameLevel(15)
        self.texture_Background:SetVertexColor(unpack(corruptedColor))
        self.texture_DragLeft:SetRotation(-1.5708)
        self.texture_DragRight:SetRotation(1.5708)
        self.texture_DragUp:SetRotation(3.14159)
        local riftOffsets = MethodDungeonTools:GetRiftOffsets()
        self.adjustedX = riftOffsets and riftOffsets[self.data.id] and riftOffsets[self.data.id].x or clone.x
        self.adjustedY = riftOffsets and riftOffsets[self.data.id] and riftOffsets[self.data.id].y or clone.y
        self:ClearAllPoints()
        self:SetPoint("CENTER",MethodDungeonTools.main_frame.mapPanelTile1,"TOPLEFT",self.adjustedX*scale,self.adjustedY*scale)
        self:SetMovable(true)
        self:RegisterForDrag("LeftButton")
        local xOffset,yOffset
        local oldX,oldY
        self.animatedLine = nil
        self:SetScript("OnMouseDown",function(self, button)
            if button == "LeftButton" then
                riftOffsets = MethodDungeonTools:GetRiftOffsets()
                local x,y = MethodDungeonTools:GetCursorPosition()
                local scale = MethodDungeonTools:GetScale()
                x = x*(1/scale)
                y = y*(1/scale)
                oldX = riftOffsets and riftOffsets[self.data.id] and riftOffsets[self.data.id].x or clone.x
                oldY = riftOffsets and riftOffsets[self.data.id] and riftOffsets[self.data.id].y or clone.y
                xOffset = x-oldX
                yOffset = y-oldY
            end
        end)
        self:SetScript("OnDragStart", function()
            self:StartMoving()
            MethodDungeonTools.draggedBlip = self
            local _,activeDoors = MethodDungeonTools.poi_framePools:GetPool("MapLinkPinTemplate"):EnumerateActive()
            riftOffsets = MethodDungeonTools:GetRiftOffsets()
            self:SetScript("OnUpdate",function()
                for poiFrame,_ in pairs(activeDoors) do
                    if MethodDungeonTools:DoFramesOverlap(self,poiFrame,-10) then
                        poiFrame.HighlightTexture:Show()
                    else
                        poiFrame.HighlightTexture:Hide()
                    end
                end
                --reposition animated line
                local x,y = MethodDungeonTools:GetCursorPosition()
                local scale = MethodDungeonTools:GetScale()
                x = x*(1/scale)
                y = y*(1/scale)
                x = x-xOffset
                y = y-yOffset
                if x ~= self.adjustedX or y~= self.adjustedY then
                    local sizex,sizey = MethodDungeonTools:GetDefaultMapPanelSize()
                    x = x<=0 and 0 or x>=sizex and sizex or x
                    y = y>=0 and 0 or y<=(-1)*sizey and (-1)*sizey or y
                    self.adjustedX = x
                    self.adjustedY = y
                    local connectedDoor = MethodDungeonTools:FindConnectedDoor(self.data.id)
                    self.animatedLine = MethodDungeonTools:ShowAnimatedLine(MethodDungeonTools.main_frame.mapPanelFrame,connectedDoor or self.spireFrame ,self,nil,nil,nil,nil,nil,self.selected,self.animatedLine)
                    riftOffsets[self.data.id] = riftOffsets[self.data.id] or {}
                    riftOffsets[self.data.id].x = x
                    riftOffsets[self.data.id].y = y
                    self:ClearAllPoints()
                    self:SetPoint("CENTER",MethodDungeonTools.main_frame.mapPanelTile1,"TOPLEFT",x*scale,y*scale)
                end
            end)
        end)
        self:SetScript("OnDragStop", function()
            MethodDungeonTools.draggedBlip = nil
            riftOffsets = MethodDungeonTools:GetRiftOffsets()
            self:StopMovingOrSizing()
            self:SetScript("OnUpdate",nil)
            self:ClearAllPoints()
            self:SetPoint("CENTER",MethodDungeonTools.main_frame.mapPanelTile1,"TOPLEFT",self.adjustedX*scale,self.adjustedY*scale)
            --dragged ontop of door
            --find doors,check overlap,break,swap sublevel,change poi sublevel
            local _,active = MethodDungeonTools.poi_framePools:GetPool("MapLinkPinTemplate"):EnumerateActive()
            for poiFrame,_ in pairs(active) do
                if MethodDungeonTools:DoFramesOverlap(self,poiFrame,-10) then
                    riftOffsets[self.data.id].sublevel = poiFrame.target
                    riftOffsets[self.data.id].homeSublevel = self.clone.sublevel or 1
                    riftOffsets[self.data.id].connections = riftOffsets[self.data.id].connections or {}
                    local c = riftOffsets[self.data.id].connections
                    local shouldAdd = true
                    for idx,value in ipairs(c) do
                        if value.source == poiFrame.poi.target then
                            tremove(c,idx)
                            shouldAdd = false
                            break
                        end
                    end
                    if shouldAdd then tinsert(c,{connectionIndex=poiFrame.poi.connectionIndex,source=MethodDungeonTools:GetCurrentSubLevel()+0,target=poiFrame.poi.target}) end
                    if riftOffsets[self.data.id].sublevel == (self.clone.sublevel or 1)then
                        riftOffsets[self.data.id].sublevel = nil
                        riftOffsets[self.data.id].homeSublevel = nil
                    end
                    --zoom out
                    --move frame
                    poiFrame:Click()
                    break
                end
            end
            if MethodDungeonTools.liveSessionActive and MethodDungeonTools:GetCurrentPreset().uid == MethodDungeonTools.livePresetUID then
                MethodDungeonTools:LiveSession_SendCorruptedPositions(preset.value.riftOffsets)
            end
        end)
        self:Hide()--hide by default, DungeonEnemies_UpdateSeasonalAffix handles showing
    end
    if emissaryIds[self.data.id] then self:Hide() end --hide beguiling emissaries by default
    tinsert(blips,self)
    if db.enemyStyle == 2 then
        self.texture_Portrait:SetTexture("Interface\\Worldmap\\WorldMapPartyIcon")
    else
        if data.iconTexture then
            SetPortraitToTexture(self.texture_Portrait,data.iconTexture);
        else
            SetPortraitTextureFromCreatureDisplayID(self.texture_Portrait,data.displayId or 39490)
        end
    end
    self.texture_Indicator:Hide()
    if db.devMode then blipDevModeSetup(self) end
end

---DungeonEnemies_IsAnyBlipMoving
function MethodDungeonTools:DungeonEnemies_IsAnyBlipMoving()
    local isAnyMoving
    for blipIdx,blip in pairs(blips) do
        if blip:IsDragging() then
            isAnyMoving = true
            break
        end
    end
    return isAnyMoving
end

---DungeonEnemies_HideAllBlips
---Used to hide blips during scaling changes to the map
function MethodDungeonTools:DungeonEnemies_HideAllBlips()
    MethodDungeonTools.dungeonEnemies_framePools:ReleaseAll()
end

function MethodDungeonTools:DungeonEnemies_UpdateEnemies()
    MethodDungeonTools.dungeonEnemies_framePools:ReleaseAll()
    twipe(blips)
    if not db then db = MethodDungeonTools:GetDB() end
    local enemies = MethodDungeonTools.dungeonEnemies[db.currentDungeonIdx]
    if not enemies then return end
    preset = MethodDungeonTools:GetCurrentPreset()

    local riftOffsets = MethodDungeonTools:GetRiftOffsets()
    local currentSublevel = MethodDungeonTools:GetCurrentSubLevel()

    for enemyIdx,data in pairs(enemies) do
        for cloneIdx,clone in pairs(data["clones"]) do
            --check sublevel
            if clone.sublevel == currentSublevel or (not clone.sublevel) then
                --skip rifts that were dragged to another sublevel
                if not (data.corrupted and riftOffsets and riftOffsets[data.id] and riftOffsets[data.id].sublevel) then
                    local blip = MethodDungeonTools.dungeonEnemies_framePools:Acquire("MDTDungeonEnemyTemplate")
                    blip:SetUp(data,clone)
                    blip.enemyIdx = enemyIdx
                    blip.cloneIdx = cloneIdx
                end
            end
        end
    end
    --add blips that were dragged to a different sublevel
    if riftOffsets then
        for npcId,offsetData in pairs(riftOffsets) do
            if offsetData.sublevel and offsetData.homeSublevel and offsetData.sublevel ==  currentSublevel then
                for enemyIdx,data in pairs(enemies) do
                    if data.id == npcId then
                        for cloneIdx,clone in pairs(data["clones"]) do
                            local blip = MethodDungeonTools.dungeonEnemies_framePools:Acquire("MDTDungeonEnemyTemplate")
                            blip:SetUp(data,clone)
                            blip.enemyIdx = enemyIdx
                            blip.cloneIdx = cloneIdx
                        end
                    end
                end
            end
        end
    end
end

function MethodDungeonTools:DungeonEnemies_CreateFramePools()
    db = self:GetDB()
    MethodDungeonTools.dungeonEnemies_framePools = MethodDungeonTools.dungeonEnemies_framePools or CreatePoolCollection()
    MethodDungeonTools.dungeonEnemies_framePools:CreatePool("Button", MethodDungeonTools.main_frame.mapPanelFrame, "MDTDungeonEnemyTemplate");
end

function MethodDungeonTools:FindPullOfBlip(blip)
    local preset = MethodDungeonTools:GetCurrentPreset()
    local pulls = preset.value.pulls or {}

    for pullIdx, pull in ipairs(pulls) do
        if pull[blip.enemyIdx] then
            for storageIdx, cloneIdx in ipairs(pull[blip.enemyIdx]) do
                if cloneIdx == blip.cloneIdx then
                    return pullIdx
                end
            end
        end
    end
end


function MethodDungeonTools:GetBlip(enemyIdx,cloneIdx,preset)
    for blipIdx,blip in pairs(blips) do
        if blip.enemyIdx == enemyIdx and blip.cloneIdx == cloneIdx then
            return blip
        end
    end
end

---DungeonEnemies_AddOrRemoveBlipToCurrentPull
---Adds or removes an enemy clone and all it's linked npcs to the currently selected pull
function MethodDungeonTools:DungeonEnemies_AddOrRemoveBlipToCurrentPull(blip,add,ignoreGrouped)
    local preset = self:GetCurrentPreset()
    local enemyIdx = blip.enemyIdx
    local cloneIdx = blip.cloneIdx
    local pull = preset.value.currentPull
    local pulls = preset.value.pulls or {}
    pulls[pull] = pulls[pull] or {}
    pulls[pull][enemyIdx] = pulls[pull][enemyIdx] or {}
    --remove clone from all other pulls first
    for pullIdx,p in pairs(pulls) do
        if pullIdx ~= pull and p[enemyIdx] then
            for k,v in pairs(p[enemyIdx]) do
                if v == cloneIdx then
                    tremove(preset.value.pulls[pullIdx][enemyIdx],k)
                end
            end
        end
        self:UpdatePullButtonNPCData(pullIdx)
    end
    if add then
        if blip then blip.selected = true end
        local found = false
        for _,v in pairs(pulls[pull][enemyIdx]) do
            if v == cloneIdx then found = true end
        end
        if found==false and blip:IsEnabled() then
            tinsert(pulls[pull][enemyIdx],cloneIdx)
        end
    else
        blip.selected = false
        for k,v in pairs(preset.value.pulls[pull][enemyIdx]) do
            if v == cloneIdx then
                tremove(preset.value.pulls[pull][enemyIdx],k)
            end
        end
    end
    --linked npcs
    if not ignoreGrouped then
        for idx,otherBlip in pairs(blips) do
            if blip.clone.g and otherBlip.clone.g == blip.clone.g and blip~=otherBlip then
                self:DungeonEnemies_AddOrRemoveBlipToCurrentPull(otherBlip,add,true,nil)
            end
        end
    end
    self:UpdatePullButtonNPCData(pull)
end

---DungeonEnemies_UpdateBlipColors
---Updates the colors of all selected blips of the specified pull
function MethodDungeonTools:DungeonEnemies_UpdateBlipColors(pull,r,g,b)
    local p = preset.value.pulls[pull]
    for enemyIdx,clones in pairs(p) do
        if tonumber(enemyIdx) then
            for _,cloneIdx in pairs(clones) do
                for _,blip in pairs(blips) do
                    if (blip.enemyIdx == enemyIdx) and (blip.cloneIdx == cloneIdx) then
                        if not db.devMode then
                            if db.enemyStyle == 2 then
                                blip.texture_Portrait:SetVertexColor(r,g,b,1)
                            elseif not blip.data.corrupted then
                                blip.texture_Portrait:SetVertexColor(r,g,b,1)
                                blip.texture_SelectedHighlight:SetVertexColor(r,g,b,0.7)
                            end
                        end
                        break
                    end
                end
            end
        end
    end
end

---DungeonEnemies_UpdateSelected
---Updates the selected Enemies on the map and marks them green
function MethodDungeonTools:DungeonEnemies_UpdateSelected(pull)
    preset = MethodDungeonTools:GetCurrentPreset()
    --deselect all
    for _,blip in pairs(blips) do
        blip.texture_SelectedHighlight:Hide()
        blip.selected = false
        blip.texture_PullIndicator:Hide()
        if not db.devMode then
            if db.enemyStyle == 2 then
                blip.texture_Portrait:SetVertexColor(1,1,1,1)
            else
                if blip.data.corrupted then
                    blip.texture_Background:SetVertexColor(unpack(corruptedColor))
                    blip.texture_Portrait:SetVertexColor(1,1,1,1)
                    SetPortraitTextureFromCreatureDisplayID(blip.texture_Portrait,blip.data.displayId or 39490)
                else
                    blip.texture_Portrait:SetVertexColor(1,1,1,1)
                end
            end
        end
    end
    --highlight all pull enemies
    for pullIdx,p in pairs(preset.value.pulls) do
        local r,g,b = MethodDungeonTools:DungeonEnemies_GetPullColor(pullIdx)
        for enemyIdx,clones in pairs(p) do
            if tonumber(enemyIdx) then
                for _,cloneIdx in pairs(clones) do
                    for _,blip in pairs(blips) do
                        if (blip.enemyIdx == enemyIdx) and (blip.cloneIdx == cloneIdx) then
                            blip.texture_SelectedHighlight:Show()
                            blip.selected = true
                            if not db.devMode then
                                if db.enemyStyle == 2 then
                                    blip.texture_Portrait:SetVertexColor(0,1,0,1)
                                else
                                    if blip.data.corrupted then
                                        blip.texture_Portrait:SetAtlas("poi-rift1")
                                        blip.texture_Background:SetVertexColor(0.5,1,0.1,1)
                                        blip.texture_SelectedHighlight:Hide()
                                    else
                                        blip.texture_Portrait:SetVertexColor(r,g,b,1)
                                        blip.texture_SelectedHighlight:SetVertexColor(r,g,b,0.7)
                                    end
                                end
                            end
                            if pullIdx == pull then
                                blip.texture_PullIndicator:Show()
                            end
                            break
                        end
                    end
                end
            end
        end
    end
end

---DungeonEnemies_SetPullColor
---Sets a custom color for a pull
function MethodDungeonTools:DungeonEnemies_SetPullColor(pull,r,g,b)
    preset = MethodDungeonTools:GetCurrentPreset()
    preset.value.pulls[pull]["color"] = MethodDungeonTools:RGBToHex(r,g,b)
end

---DungeonEnemies_GetPullColor
---Returns the custom color for a pull (if specified)
function MethodDungeonTools:DungeonEnemies_GetPullColor(pull)
    local r,g,b = MethodDungeonTools:HexToRGB(preset.value.pulls[pull]["color"])
    if not r then
        r,g,b = MethodDungeonTools:HexToRGB(db.defaultColor)
        MethodDungeonTools:DungeonEnemies_SetPullColor(pull,r,g,b)
    end
    return r,g,b
end

---DungeonEnemies_UpdateTeeming
---Updates visibility state of teeming blips
function MethodDungeonTools:DungeonEnemies_UpdateTeeming()
    preset = MethodDungeonTools:GetCurrentPreset()
    local teeming = MethodDungeonTools:IsPresetTeeming(preset)
    for _,blip in pairs(blips) do
        if teeming then
            if blip.clone.negativeTeeming then
                blip:Hide()
            else
                blip:Show()
            end
        else
            if blip.clone.teeming then
                blip:Hide()
            else
                blip:Show()
            end
        end
    end
    MethodDungeonTools:DungeonEnemies_UpdateBlacktoothEvent()
end

---DungeonEnemies_UpdateSeasonalAffix
---Updates visibility state and appearance of enemies related to the current seasonal affix
function MethodDungeonTools:DungeonEnemies_UpdateSeasonalAffix()
    --hide all beguiling and corrupted blips first
    for _,blip in pairs(blips) do
        if blip.data.corrupted then blip:Hide() end
        if emissaryIds[blip.data.id] then blip:Hide() end
    end
    local week = self:GetEffectivePresetWeek()
    for _,blip in pairs(blips) do
        if (db.currentSeason == 4 and blip.data.corrupted) or(db.currentSeason == 3 and emissaryIds[blip.data.id]) then
            local weekData =  blip.clone.week
            if weekData and (not weekData[week] or db.currentDifficulty < 10) then
                blip:Hide()
            elseif weekData and weekData[week] then
                blip:Show()
            elseif not weekData and blip.data.corrupted then
                blip:Show()
            end
        end
    end
end


---DungeonEnemies_UpdateBlacktoothEvent
---Updates visibility state of blacktooth event blips
function MethodDungeonTools:DungeonEnemies_UpdateBlacktoothEvent()
    local week
    if db.MDI.enabled then
        week = preset.mdi.freehold or 1
    else
        week = preset.week%3
    end
    if week == 0 then week = 3 end
    local isBlacktoothWeek = week == 2
    for _,blip in pairs(blips) do
        if blip.clone.blacktoothEvent then
            if isBlacktoothWeek then
                blip:Enable()
                blip:Show()
            else
                blip:Disable()
                blip:Hide()
            end
        end
    end
end

function MethodDungeonTools:DungeonEnemies_UpdateBoralusFaction(faction)
    preset = MethodDungeonTools:GetCurrentPreset()
    local teeming = MethodDungeonTools:IsPresetTeeming(preset)
    for _,blip in pairs(blips) do
        if blip.clone.faction then
            --handle beguiling npcs here
            if emissaryIds[blip.data.id] then
                local week
                if db.MDI.enabled then
                    week = preset.mdi.beguiling or 1
                else
                    week = preset.week
                end
                local weekData =  blip.clone.week
                if weekData and not weekData[week] then
                    blip:Hide()
                elseif weekData and weekData[week] then
                    if blip.clone.faction == faction then
                        blip:Show()
                    else
                        blip:Hide()
                    end
                end
            else
                if blip.clone.faction == faction and ((teeming and blip.clone.teeming) or (not blip.clone.teeming)) then
                    blip:Show()
                else
                    blip:Hide()
                end
            end
        end
    end
end

function MethodDungeonTools:DungeonEnemies_UpdateReaping()
    for _,blip in pairs(blips) do
        if blip.data.reaping then
            blip.texture_Reaping:Show()
        else
            blip.texture_Reaping:Hide()
        end

        if db.currentDifficulty < 10 then
            blip.texture_Reaping:Hide()
        end
    end
end

---DungeonEnemies_UpdateInfested
---Updates which blips should display infested state based on preset.week
function MethodDungeonTools:DungeonEnemies_UpdateInfested(week)
    week = preset.week%3
    if week == 0 then week = 3 end
    for _,blip in pairs(blips) do
        if blip.clone.infested and blip.clone.infested[week] then
            blip.texture_Indicator:Show()
        else
            blip.texture_Indicator:Hide()
        end
    end
end

---Frehold Crews
MethodDungeonTools.freeholdCrews = {
    [2] = {--blacktooth
        [129548] = true,
        [129529] = true,
        [129547] = true,
        [126847] = true,
    },
    [1] = {--cutwater
        [129559] = true,
        [129599] = true,
        [126845] = true,
        [129601] = true,
    },
    [3] = {--bilge rat
        [129550] = true,
        [129527] = true,
        [129600] = true,
        [129526] = true,
        [126848] = true,
    },
}
---DungeonEnemies_UpdateFreeholdCrew
---Updates the enemies in Freehold to reflect the weekly event of "joining" a crew i.e. disabling npcs of the crew
function MethodDungeonTools:DungeonEnemies_UpdateFreeholdCrew(crewIdx)
    --override crew with mdi data
    if db.MDI.enabled then
        crewIdx = (preset.mdi.freeholdJoined and preset.mdi.freehold) or nil
    end
    --if we are not in freehold map we need to tidy up our mess a bit
    if not crewIdx then
        for _,blip in pairs(blips) do
            blip:Enable()
            blip:SetAlpha(1)
            blip.texture_Portrait:SetDesaturated(false)
        end
        return
    end

    local crew = MethodDungeonTools.freeholdCrews[crewIdx]
    for _,blip in pairs(blips) do
        if crew[blip.data.id] and not blip.clone.blacktoothEvent then
            blip:Disable()
            blip:SetAlpha(0.3)
            blip.texture_Portrait:SetDesaturated(true)
        else
            blip:Enable()
            blip:SetAlpha(1)
            blip.texture_Portrait:SetDesaturated(false)
        end
    end
end

function MethodDungeonTools:IsNPCInPulls(poi)
    local week = self:GetEffectivePresetWeek()
    local data = self.dungeonEnemies[db.currentDungeonIdx]
    for enemyIdx,enemy in pairs(data) do
        if enemy.id == poi.npcId then
            local included = false
            for cloneIdx,clone in pairs(enemy.clones) do
                if clone.week[week] then
                    return MethodDungeonTools:IsCloneInPulls(enemyIdx,cloneIdx)
                end
            end
        end
    end
end

function MethodDungeonTools:IsCloneInPulls(enemyIdx,cloneIdx)
    local pulls = MethodDungeonTools:GetCurrentPreset().value.pulls
    local numClones = 0
    for _,pull in pairs(pulls) do
        if pull[enemyIdx] then
            if cloneIdx then
                for _,pullCloneIndex in pairs(pull[enemyIdx]) do
                    if pullCloneIndex == cloneIdx then return true end
                end
            else
                for _,pullCloneIndex in pairs(pull[enemyIdx]) do
                    numClones = numClones+1
                end
            end
        end
    end
    return numClones>0
end

---returns count, maxCountNormal, maxCountTeeming
function MethodDungeonTools:GetEnemyForces(npcId)
    for i = 1,MethodDungeonTools:GetNumDungeons() do
        local data = MethodDungeonTools.dungeonEnemies[i]
        if data then
            for enemyIdx,enemy in pairs(data) do
                if enemy.id == npcId then
                    return enemy.count,MethodDungeonTools.dungeonTotalCount[i].normal,MethodDungeonTools.dungeonTotalCount[i].teeming
                end
            end
        end
    end
end

---tries to retrieve npc name by npcId
---only looks for npcs in the current dungeon
function MethodDungeonTools:GetNPCNameById(npcId)
    local data = MethodDungeonTools.dungeonEnemies[db.currentDungeonIdx]
    if data then
        for _,enemy in pairs(data) do
            if enemy.id == npcId then
                return enemy.name
            end
        end
    end
end

---updates the enemie tables with new count and teemingCount or displayId values
---data is retrieved with the the get_count.py or get_displayids python script
---data needs to afterwards be exported manually for every dungeon
function MethodDungeonTools:UpdateDungeonData(dungeonData)

    local function printDungeonName(shouldPrint,dungeonIdx)
        if shouldPrint then
            print("-----",MethodDungeonTools:GetDungeonName(dungeonIdx))
        end
        return false
    end

    for dungeonIdx,newData in pairs(dungeonData) do

        --dungeon total count changes
        local totalCount = MethodDungeonTools.dungeonTotalCount[dungeonIdx]
        if newData[0] and (newData[0].count~=totalCount.normal or newData[0].teeming_count~=totalCount.teeming) then
            print("TOTAL ",totalCount.normal,totalCount.teeming,">>>",newData[0].count,newData[0].teeming_count)
            totalCount.normal = newData[0].count
            totalCount.teeming = newData[0].teeming_count
        end

        --enemy changes
        local shouldPrintDungeonName = true
        local enemyData = MethodDungeonTools.dungeonEnemies[dungeonIdx]
        if enemyData then
            for _,enemy in pairs(enemyData) do
                --ignore enchanted emissary (gives count but can almost never pull it off, keep 0 to keep it simple)
                --ignore spark channeler, always gives 11 count but data says 6
                if newData[enemy.id] and (enemy.id ~= 155432 and enemy.id ~= 139110) then

                    if newData[enemy.id].count then
                        --normal count changes
                        if newData[enemy.id].count~=enemy.count then
                            shouldPrintDungeonName= printDungeonName(shouldPrintDungeonName,dungeonIdx)
                            print(enemy.name,enemy.id, enemy.count, ">>>", newData[enemy.id].count)
                            enemy.count = newData[enemy.id].count
                        end

                        --teeming count changes
                        if newData[enemy.id].count~= newData[enemy.id].teeming_count
                                and (newData[enemy.id].count~=enemy.count or newData[enemy.id].teeming_count~=enemy.teemingCount)
                        then
                            shouldPrintDungeonName= printDungeonName(shouldPrintDungeonName,dungeonIdx)
                            print("TEEMING ",enemy.name,enemy.id, newData[enemy.id].count,"||", newData[enemy.id].teeming_count)
                            enemy.count = newData[enemy.id].count
                            enemy.teemingCount = newData[enemy.id].teeming_count
                        end
                    end

                    --displayId changes
                    if newData[enemy.id].displayId and newData[enemy.id].displayId~=enemy.displayId then
                        shouldPrintDungeonName= printDungeonName(shouldPrintDungeonName,dungeonIdx)
                        print("DISPLAYID ",enemy.name,enemy.id,enemy.displayId, ">>>",newData[enemy.id].displayId)
                        enemy.displayId = newData[enemy.id].displayId
                    end

                end
            end

        end

    end

end

---exports all ids of npcs that do not have a displayId associated to them
--dungeons = [
--Dungeon(name='AtalDazar', idx=15, npcIds=[134739, 161241, 136347]),
--    Dungeon(name='RandomDungeon', idx=14, npcIds=[161241, 134739, 136347]),
--]
function MethodDungeonTools:ExportNPCIdsWithoutDisplayIds()
    local output = "dungeons = [\n"
    for idx = 15,MethodDungeonTools:GetNumDungeons() do
        local shouldAddDungeonText = true
        local enemyData = MethodDungeonTools.dungeonEnemies[idx]
        for _,enemy in pairs(enemyData) do
            if not enemy.displayId then
                if shouldAddDungeonText then
                    output = output.."Dungeon(name='"..MethodDungeonTools:GetDungeonName(idx).."', idx=".. idx..", npcIds=["
                    shouldAddDungeonText = false
                end
                output = output..enemy.id..", "
            end
        end
        if not shouldAddDungeonText then output = output.."]),\n" end
    end
    output = output.."]"
    MethodDungeonTools:HideAllDialogs()
    MethodDungeonTools.main_frame.ExportFrame:Show()
    MethodDungeonTools.main_frame.ExportFrame:ClearAllPoints()
    MethodDungeonTools.main_frame.ExportFrame:SetPoint("CENTER",MethodDungeonTools.main_frame,"CENTER",0,50)
    MethodDungeonTools.main_frame.ExportFrameEditbox:SetText(output)
    MethodDungeonTools.main_frame.ExportFrameEditbox:HighlightText(0, string.len(output))
    MethodDungeonTools.main_frame.ExportFrameEditbox:SetFocus()
    MethodDungeonTools.main_frame.ExportFrameEditbox:SetLabel("NPC ids without displayId")
end


local function ArrayRemove(t, fnKeep)
    local j, n = 1, #t;

    for i=1,n do
        if (fnKeep(t, i, j)) then
            -- Move i's kept value to j's position, if it's not already there.
            if (i ~= j) then
                t[j] = t[i];
                t[i] = nil;
            end
            j = j + 1; -- Increment position of where we'll place the next kept value.
        else
            t[i] = nil;
        end
    end

    return t;
end

---removes enemies of the current dungeon without any clones
function MethodDungeonTools:CleanEnemyData(dungeonIdx)
    local enemies = MethodDungeonTools.dungeonEnemies[dungeonIdx]
    ArrayRemove(enemies,function (t, i , j)
        return #t[i].clones>0
    end)

end