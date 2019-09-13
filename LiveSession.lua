local MethodDungeonTools = MethodDungeonTools
local MDTcommsObject = MDTcommsObject
local db

---LiveSession_Enable
function MethodDungeonTools:LiveSession_Enable(passive)
    local widget = self.main_frame.LiveSessionButton
    widget.text:SetTextColor(0,1,0)
    self.main_frame.LinkToChatButton:SetDisabled(true)
    --check if there are sessions
    if not passive then
        self.main_frame.LiveSessionButton:SetDisabled(true)
        self.main_frame.LinkToChatButton:SetText("...")
        self.main_frame.LiveSessionButton:SetText("...")
        self:SendToGroup(self:IsPlayerInGroup(),true)
    else
        self.main_frame.LiveSessionButton:SetText("*Live*")
    end
    self.liveSessionActive = true
    self:LiveSession_NotifyEnabled()
    self.livePresetUID = self:GetCurrentPreset().uid

    --TODO: check preset size when starting live session
    --[[
    local presetSize = self:GetPresetSize()
    if presetSize>12000 then
        local prompt = "You are trying to share a very large preset ("..presetSize.." characters)\nIt is recommended to use the export function and share large presets through wago.io instead.\nAre you sure you want to share this preset?\n\n\n"
        MethodDungeonTools:OpenConfirmationFrame(450,150,"Sharing large preset","Share",prompt, function() MethodDungeonTools:SendToGroup(self:IsPlayerInGroup(),true)  end)
    else
        MethodDungeonTools:SendToGroup(self:IsPlayerInGroup(),true)
    end
    ]]
end

---LiveSession_Disable
function MethodDungeonTools:LiveSession_Disable()
    local widget = MethodDungeonTools.main_frame.LiveSessionButton
    widget.text:SetTextColor(widget.normalTextColor.r,widget.normalTextColor.g,widget.normalTextColor.b)
    widget.text:SetText("Live")
    MethodDungeonTools.main_frame.LinkToChatButton:SetDisabled(false)

    self.liveSessionActive = false
    self:LiveSession_NotifyDisabled()
end


---LiveSession_NotifyEnabled
---Notify Group/Raid Members that my live session has been started
function MethodDungeonTools:LiveSession_NotifyEnabled()
    local distribution = self:IsPlayerInGroup()
    if (not distribution) or (not self.liveSessionActive) then return end
    db = db or self:GetDB()
    MDTcommsObject:SendCommMessage(self.liveSessionPrefixes.enabled, tostring(db.currentDungeonIdx), distribution, nil, "ALERT")
end

---LiveSession_NotifyDisabled
---Notify Group/Raid Members that my live session has ended
function MethodDungeonTools:LiveSession_NotifyDisabled()
    local distribution = self:IsPlayerInGroup()
    if (not distribution) or (self.liveSessionActive) then return end
    MDTcommsObject:SendCommMessage(self.liveSessionPrefixes.disabled, "0", distribution, nil, "ALERT")
end

---LiveSession_RequestSessions
---Send a request to the group to send notify messages for active sessions
function MethodDungeonTools:LiveSession_RequestSessions()
    local distribution = self:IsPlayerInGroup()
    if (not distribution) or (self.liveSessionActive) then return end
    MDTcommsObject:SendCommMessage(self.liveSessionPrefixes.request, "0", distribution, nil, "ALERT")
end

---LiveSession_SendPing
---Sends a map ping to connected live session clients
function MethodDungeonTools:LiveSession_SendPing(x,y)
    --only send ping if we are in the livesession preset
    if self:GetCurrentPreset().uid == self.livePresetUID then
        local distribution = self:IsPlayerInGroup()
        if distribution then
            local scale = self:GetScale()
            MDTcommsObject:SendCommMessage(self.liveSessionPrefixes.ping, x*(1/scale)..":"..y*(1/scale), distribution, nil, "ALERT")
        end
    end
end
