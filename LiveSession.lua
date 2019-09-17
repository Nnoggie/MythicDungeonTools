local MethodDungeonTools = MethodDungeonTools
local MDTcommsObject = MDTcommsObject
local twipe,tinsert = table.wipe,table.insert

local timer
---LiveSession_Enable
function MethodDungeonTools:LiveSession_Enable()
    self.main_frame.LiveSessionButton:SetText("*Live*")
    self.main_frame.LiveSessionButton.text:SetTextColor(0,1,0)
    self.main_frame.LinkToChatButton:SetDisabled(true)
    self.main_frame.LinkToChatButton.text:SetTextColor(0.5,0.5,0.5)
    self.main_frame.sidePanelDeleteButton:SetDisabled(true)
    self.main_frame.sidePanelDeleteButton.text:SetTextColor(0.5,0.5,0.5)
    self.liveSessionActive = true
    --check if there is a session
    self:LiveSession_RequestSession()
    --set id here incase there is no other sessions
    self:SetUniqueID(self:GetCurrentPreset())
    self.livePresetUID = self:GetCurrentPreset().uid
    self:UpdatePresetDropdownTextColor()
    timer = C_Timer.NewTimer(2, function()
        local distribution = self:IsPlayerInGroup()
        local preset = self:GetCurrentPreset()
        local prefix = "[MDTLive: "
        local dungeon = self:GetDungeonName(preset.value.currentDungeonIdx)
        local presetName = preset.text
        local name, realm = UnitFullName("player")
        local fullName = name.."+"..realm
        SendChatMessage(prefix..fullName.." - "..dungeon..": "..presetName.."]",distribution)
    end)
end

---LiveSession_Disable
function MethodDungeonTools:LiveSession_Disable()
    local widget = MethodDungeonTools.main_frame.LiveSessionButton
    widget.text:SetTextColor(widget.normalTextColor.r,widget.normalTextColor.g,widget.normalTextColor.b)
    widget.text:SetText("Live")
    MethodDungeonTools.main_frame.LinkToChatButton:SetDisabled(false)
    self.main_frame.LinkToChatButton.text:SetTextColor(1,0.8196,0)
    self.main_frame.sidePanelDeleteButton:SetDisabled(false)
    self.main_frame.sidePanelDeleteButton.text:SetTextColor(1,0.8196,0)
    self.liveSessionActive = false
    self:UpdatePresetDropdownTextColor()
    self.main_frame.liveReturnButton:Hide()
    self.main_frame.setLivePresetButton:Hide()
end


---LiveSession_NotifyEnabled
---Notify specific group member that my live session is active
function MethodDungeonTools:LiveSession_NotifyEnabled(fullName)
    local distribution = "WHISPER"
    local uid = self.livePresetUID
    if not uid then return end
    MDTcommsObject:SendCommMessage(self.liveSessionPrefixes.enabled, uid, distribution, fullName, "ALERT")
    self:SendToGroup(self:IsPlayerInGroup(),true,self:GetCurrentLivePreset())
end

---LiveSession_RequestSessions
---Send a request to the group to send notify messages for active sessions
function MethodDungeonTools:LiveSession_RequestSession()
    local distribution = self:IsPlayerInGroup()
    if (not distribution) or (not self.liveSessionActive) then return end
    self.liveSessionRequested = true
    MDTcommsObject:SendCommMessage(self.liveSessionPrefixes.request, "0", distribution, nil, "ALERT")
end

function MethodDungeonTools:LiveSession_SessionFound(uid)
    self.livePresetUID = uid
    self.liveSessionAcceptingPreset = true
    self.main_frame.SendingStatusBar:Show()
    self.main_frame.SendingStatusBar:SetValue(0/1)
    self.main_frame.SendingStatusBar.value:SetText("Receiving: ...")
    if not self.main_frame.LoadingSpinner then
        self.main_frame.LoadingSpinner = CreateFrame("Button", "MDTLoadingSpinner", self.main_frame, "LoadingSpinnerTemplate")
        self.main_frame.LoadingSpinner:SetPoint("CENTER",self.main_frame,"CENTER")
        self.main_frame.LoadingSpinner:SetSize(60,60)
    end
    self.main_frame.LoadingSpinner:Show()
    self.main_frame.LoadingSpinner.Anim:Play()
    if timer then timer:Cancel() end
    self:UpdatePresetDropdownTextColor(true)
end



---LiveSession_SendPing
---Sends a map ping
function MethodDungeonTools:LiveSession_SendPing(x,y,sublevel)
    --only send ping if we are in the livesession preset
    if self:GetCurrentPreset().uid == self.livePresetUID then
        local distribution = self:IsPlayerInGroup()
        if distribution then
            local scale = self:GetScale()
            MDTcommsObject:SendCommMessage(self.liveSessionPrefixes.ping, x*(1/scale)..":"..y*(1/scale)..":"..sublevel, distribution, nil, "ALERT")
        end
    end
end

---LiveSession_SendObject
---Sends a preset object
function MethodDungeonTools:LiveSession_SendObject(obj)
    if self:GetCurrentPreset().uid == self.livePresetUID then
        local distribution = self:IsPlayerInGroup()
        if distribution then
            local export = MethodDungeonTools:TableToString(obj,true)
            MDTcommsObject:SendCommMessage(self.liveSessionPrefixes.obj, export, distribution, nil, "ALERT")
        end
    end
end

---LiveSession_SendObjectOffsets
---Sends updated object offsets (move object)
function MethodDungeonTools:LiveSession_SendObjectOffsets(objIdx,x,y)
    if self:GetCurrentPreset().uid == self.livePresetUID then
        local distribution = self:IsPlayerInGroup()
        if distribution then
            MDTcommsObject:SendCommMessage(self.liveSessionPrefixes.objOff, objIdx..":"..x..":"..y, distribution, nil, "ALERT")
        end
    end
end

---LiveSession_SendUpdatedObjects
---Sends updated objects - instead of sending an update every time we erase a part of an object we send one message after mouse up
function MethodDungeonTools:LiveSession_SendUpdatedObjects(changedObjects)
    if self:GetCurrentPreset().uid == self.livePresetUID then
        local distribution = self:IsPlayerInGroup()
        if distribution then
            local export = MethodDungeonTools:TableToString(changedObjects,true)
            MDTcommsObject:SendCommMessage(self.liveSessionPrefixes.objChg, export, distribution, nil, "ALERT")
        end
    end
end

---LiveSession_SendDeletePresetObjects
---Sends various commands: delete all drawings, clear preset, undo, redo
function MethodDungeonTools:LiveSession_SendCommand(cmd)
    if self:GetCurrentPreset().uid == self.livePresetUID then
        local distribution = self:IsPlayerInGroup()
        if distribution then
            MDTcommsObject:SendCommMessage(self.liveSessionPrefixes.cmd, cmd, distribution, nil, "ALERT")
        end
    end
end

---LiveSession_SendNoteText
---Sends a note text update
function MethodDungeonTools:LiveSession_SendNoteCommand(cmd,noteIdx,text,y)
    if self:GetCurrentPreset().uid == self.livePresetUID then
        local distribution = self:IsPlayerInGroup()
        if distribution then
            text = text..":"..(y or "0")
            MDTcommsObject:SendCommMessage(self.liveSessionPrefixes.note, cmd..":"..noteIdx..":"..text, distribution, nil, "ALERT")
        end
    end
end

---LiveSession_SendPreset
---Sends a new preset to be used as the new live session preset
function MethodDungeonTools:LiveSession_SendPreset(preset)
    local distribution = self:IsPlayerInGroup()
    if distribution then
        preset.mdiEnabled = self:GetDB().MDI.enabled
        local export = MethodDungeonTools:TableToString(preset,true)
        MDTcommsObject:SendCommMessage(self.liveSessionPrefixes.preset, export, distribution, nil, "ALERT")
    end
end

---LiveSession_SendCloneActions
---Sends a set of actions of adding or removing clones from pulls
function MethodDungeonTools:LiveSession_SendCloneActions(cloneActions)
    local distribution = self:IsPlayerInGroup()
    if distribution then
        local msg = MethodDungeonTools:TableToString(cloneActions,true)
        MDTcommsObject:SendCommMessage(self.liveSessionPrefixes.clone, msg, distribution, nil, "ALERT")
    end
end

---LiveSession_SendPulls
---Sends all pulls
function MethodDungeonTools:LiveSession_SendPulls(pulls)
    local distribution = self:IsPlayerInGroup()
    if distribution then
        local msg = MethodDungeonTools:TableToString(pulls,true)
        MDTcommsObject:SendCommMessage(self.liveSessionPrefixes.pull, msg, distribution, nil, "ALERT")
    end
end

---LiveSession_SendAffixWeek
---Sends all pulls
function MethodDungeonTools:LiveSession_SendAffixWeek(week)
    local distribution = self:IsPlayerInGroup()
    if distribution then
        MDTcommsObject:SendCommMessage(self.liveSessionPrefixes.week, week.."", distribution, nil, "ALERT")
    end
end

---MethodDungeonTools:LiveSession_SendFreeholdSelector(value)
---Sends freehold selector updates
function MethodDungeonTools:LiveSession_SendFreeholdSelector(value,week)
    local distribution = self:IsPlayerInGroup()
    if distribution then
        value = value and "T:" or "F:"
        local msg = value..week
        MDTcommsObject:SendCommMessage(self.liveSessionPrefixes.free, msg, distribution, nil, "ALERT")
    end
end

---LiveSession_SendBoralusSelector
---sends boralus selector updates
function MethodDungeonTools:LiveSession_SendBoralusSelector(faction)
    local distribution = self:IsPlayerInGroup()
    if distribution then
        local msg = faction..""
        MDTcommsObject:SendCommMessage(self.liveSessionPrefixes.bora, msg, distribution, nil, "ALERT")
    end
end

---LiveSession_SendMDI
---Sends MDI selector updates
function MethodDungeonTools:LiveSession_SendMDI(action,data)
    local distribution = self:IsPlayerInGroup()
    if distribution then
        local msg = action..":"..data
        MDTcommsObject:SendCommMessage(self.liveSessionPrefixes.mdi, msg, distribution, nil, "ALERT")
    end
end

do
    local timer
    ---LiveSession_QueueColorUpdate
    ---Disgusting workaround for shitty colorpicker
    ---Only send an update once a color of a pull has not changed for 0.2 seconds
    function MethodDungeonTools:LiveSession_QueueColorUpdate()
        if timer then timer:Cancel() end
        timer = C_Timer.NewTimer(0.2, function()
            self:LiveSession_SendPulls(self:GetPulls())
        end)
    end
end