local MethodDungeonTools = MethodDungeonTools
local MDTcommsObject = MDTcommsObject

local timer
---LiveSession_Enable
function MethodDungeonTools:LiveSession_Enable()
    local widget = self.main_frame.LiveSessionButton
    widget.text:SetTextColor(0,1,0)
    self.main_frame.LinkToChatButton:SetDisabled(true)
    self.main_frame.LiveSessionButton:SetText("*Live*")
    self.liveSessionActive = true
    --check if there is a session
    self:LiveSession_RequestSession()
    --set id here incase there is no other sessions
    self:SetUniqueID(self:GetCurrentPreset())
    self.livePresetUID = self:GetCurrentPreset().uid

    --send chat link (this one just opens MDT and calls this function
    --cancel timer when we receive other sessions
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
end


---LiveSession_NotifyEnabled
---Notify specific group member that my live session is active
function MethodDungeonTools:LiveSession_NotifyEnabled(fullName)
    local distribution = "WHISPER"
    local uid = self.livePresetUID
    if not uid then return end
    MDTcommsObject:SendCommMessage(self.liveSessionPrefixes.enabled, uid, distribution, fullName, "ALERT")
    self:SendToGroup(self:IsPlayerInGroup(),true)
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
    if timer then timer:Cancel() end
end



---LiveSession_SendPing
---Sends a map ping to connected live session clients
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
