local addonName, MDT = ...
local API = assert(_G.MythicDungeonToolsAPI, "MythicDungeonTools_UI requires MythicDungeonTools")

MDT.UIAddonName = addonName
MDT.AddonName = API:GetAddonName()
MDT.BackdropColor = { API:GetBackdropColor() }
MDT.L = setmetatable({}, { __index = function(_, key) return key end })
MDT.presetCommPrefix = API:GetPresetCommPrefix()
MDT.versionCheckPrefix = API:GetVersionCheckPrefix()
MDT.liveSessionPrefixes = API:GetLiveSessionPrefixes()
MDT.commsObject = {
  SendCommMessage = function(_, ...)
    return API:SendCommMessage(...)
  end,
}

setmetatable(MDT, { __index = API })

function MDT:AttachCoreAPI()
  API:AttachUI({
    ShowInterface = function(...) return MDT:ShowInterface(...) end,
    HandleSlashCommand = function(...) return MDT:HandleSlashCommand(...) end,
    HandleChatLink = function(...) return MDT:HandleChatLink(...) end,
    OnCommReceived = function(...) return MDT.commsObject:OnCommReceived(...) end,
    GetEnemyForces = function(...) return MDT:GetEnemyForces(...) end,
    GetDungeonName = function(...) return MDT:GetDungeonName(...) end,
    GetDungeonSublevels = function(...) return MDT:GetDungeonSublevels(...) end,
    OnMinimapVisibilityChanged = function(shown)
      local checkbox = MDT.main_frame and MDT.main_frame.minimapCheckbox
      if checkbox then checkbox:SetValue(shown) end
    end,
  })
end
