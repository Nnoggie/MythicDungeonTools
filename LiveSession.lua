local MethodDungeonTools = MethodDungeonTools
local MDTcommsObject = MDTcommsObject
local db

---LiveSession_Enable
function MethodDungeonTools:LiveSession_Enable()
    local widget = MethodDungeonTools.main_frame.LiveSessionButton
    widget.text:SetTextColor(0,1,0)
    widget.text:SetText("*Live*")
    MethodDungeonTools.main_frame.LinkToChatButton:SetDisabled(true)

    self.liveSessionActive = true
    self:LiveSession_NotifyEnabled()
    --output chat link
    local distribution = self:IsPlayerInGroup()
    local preset = MethodDungeonTools:GetCurrentPreset()
    local dungeon = MethodDungeonTools:GetDungeonName(preset.value.currentDungeonIdx)
    local presetName = preset.text
    local name, realm = UnitFullName("player")
    local fullName = name..realm
    SendChatMessage("[MDTLive: "..fullName.." - "..dungeon..": "..presetName.."]",distribution)
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