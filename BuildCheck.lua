local addonName, MDT = ...
local API = {}
_G.MythicDungeonToolsAPI = API

MDT.API = API
MDT.AddonName = addonName
MDT.L = setmetatable({
  ["Click to toggle AddOn Window"] = "Click to toggle AddOn Window",
  ["chatNoninteractiveWarning"] = "Chat frame is currently set to noninteractive, you will not be able to click on MDT routes.",
  ["combatLoggingStarted"] = "Started combat logging.",
  ["combatLoggingStopped"] = "Ended combat logging.",
  ["dungeonResetAnnouncement"] = "<Dungeons have been reset!>",
  ["Enemy Info NPC Enemy Forces"] = "Enemy Forces",
  ["focusMarkerChatAnnouncement"] = "My Focus Marker is {rt%d}",
  ["incompatibleVersionError"] = "This version of World of Warcraft is not compatible with Mythic Dungeon Tools.",
  ["MDT Set Focus Macro"] = "MDT Set Focus Macro",
  ["Middle-click to disable Minimap Button"] = "Middle-click to disable Minimap Button",
  ["Right-click to lock Minimap Button"] = "Right-click to lock Minimap Button",
  ["Toggle MDT"] = "Toggle MDT",
}, {
  __index = function(_, key)
    return key
  end,
})

function MDT:IsRetail()
  local gameVersion = select(4, GetBuildInfo())
  return gameVersion >= 120000
end

function MDT:IsCompatibleVersion()
  return MDT:IsRetail()
end

function MDT:ShowFallbackWindow()
  local gameVersionString = GetBuildInfo()
  local addonVersionString = C_AddOns.GetAddOnMetadata(addonName, "Version")
  StaticPopupDialogs.MDT_INCOMPATIBLE_VERSION = {
    text = MDT.L["incompatibleVersionError"].."\n\nGame: "..gameVersionString.."\nMDT: "..addonVersionString,
    button1 = OKAY,
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
  }
  StaticPopup_Show("MDT_INCOMPATIBLE_VERSION")
end

function MDT:ExportAPI(methodName)
  API[methodName] = function(_, ...)
    return MDT[methodName](MDT, ...)
  end
end

function API:GetAddonName()
  return addonName
end

MDT:ExportAPI("IsRetail")
MDT:ExportAPI("IsCompatibleVersion")
MDT:ExportAPI("ShowFallbackWindow")
