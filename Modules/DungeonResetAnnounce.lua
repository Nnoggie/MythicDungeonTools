local _, MDT = ...
local L = MDT.L

local dungeonResetAnnounceHooked

function MDT:EnableDungeonResetAnnounceHook()
  if dungeonResetAnnounceHooked then return end
  dungeonResetAnnounceHooked = true

  hooksecurefunc("ResetInstances", function()
    local db = MDT:GetDB()
    if not db or not db.announceDungeonReset then return end

    local message = L["dungeonResetAnnouncement"]
    if IsInRaid() then
      C_ChatInfo.SendChatMessage(message, "RAID")
    elseif IsInGroup() then
      C_ChatInfo.SendChatMessage(message, "PARTY")
    else
      print(message)
    end
  end)
end
