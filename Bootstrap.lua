local addonName, MDT = ...

_G.MDT = MDT

local loading
local eventFrame

local function stopLoadEvents()
  if eventFrame then eventFrame:UnregisterAllEvents() end
end

local function isFullyLoaded()
  local loadedOrLoading, loaded = C_AddOns.IsAddOnLoaded(addonName)
  return loaded == nil and loadedOrLoading or loaded
end

function MythicDungeonTools_Load()
  if isFullyLoaded() then
    stopLoadEvents()
    return true
  end
  if loading then return false end

  loading = true
  local loaded, reason = C_AddOns.LoadAddOn(addonName)
  loading = nil

  if not loaded and not isFullyLoaded() then
    print("|cffffd100MDT:|r Failed to load: "..(reason or "unknown error"))
    return false
  end
  stopLoadEvents()
  return true
end

local function loadAndCall(methodName, loader, ...)
  if not MythicDungeonTools_Load() then return end
  local fullMDT = _G.MDT
  local method = fullMDT[methodName]
  if type(method) == "function" and method ~= loader then return method(fullMDT, ...) end
end

local showInterface
showInterface = function(_, ...)
  return loadAndCall("ShowInterface", showInterface, ...)
end
MDT.ShowInterface = showInterface

local getEnemyForces
getEnemyForces = function(_, ...)
  return loadAndCall("GetEnemyForces", getEnemyForces, ...)
end
MDT.GetEnemyForces = getEnemyForces

function MythicDungeonTools_Toggle()
  return _G.MDT:ShowInterface()
end

BINDING_HEADER_MDT = "Mythic Dungeon Tools (MDT)"
BINDING_NAME_MDTTOGGLE = "Toggle Window"
_G["BINDING_NAME_CLICK MDTFocusMarkerButton:LeftButton"] = "MDT Set Focus Macro"

SLASH_MYTHICDUNGEONTOOLS1 = "/mplus"
SLASH_MYTHICDUNGEONTOOLS2 = "/mdt"
SLASH_MYTHICDUNGEONTOOLS3 = "/mythicdungeontools"

function SlashCmdList.MYTHICDUNGEONTOOLS(cmd, editbox)
  if MythicDungeonTools_Load() then
    local fullMDT = _G.MDT
    if fullMDT.HandleSlashCommand then return fullMDT:HandleSlashCommand(cmd, editbox) end
  end
end

local compartmentData = {
  text = "MythicDungeonTools",
  icon = "Interface\\AddOns\\MythicDungeonTools\\Textures\\MDTMinimap",
  notCheckable = true,
  func = MythicDungeonTools_Toggle,
}
local compartmentRegistered

function MythicDungeonTools_SetAddonCompartmentShown(shown)
  if not AddonCompartmentFrame or shown == compartmentRegistered then return end

  if shown then
    AddonCompartmentFrame:RegisterAddon(compartmentData)
    compartmentRegistered = true
    return
  end

  for index, data in ipairs(AddonCompartmentFrame.registeredAddons) do
    if data == compartmentData then
      table.remove(AddonCompartmentFrame.registeredAddons, index)
      AddonCompartmentFrame:UpdateDisplay()
      break
    end
  end
  compartmentRegistered = false
end

MythicDungeonTools_SetAddonCompartmentShown(true)

eventFrame = CreateFrame("Frame")
eventFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
eventFrame:RegisterEvent("GROUP_JOINED")
eventFrame:RegisterEvent("READY_CHECK")
eventFrame:RegisterEvent("CHALLENGE_MODE_START")
eventFrame:SetScript("OnEvent", function(_, event)
  if isFullyLoaded() then
    stopLoadEvents()
    return
  end
  MythicDungeonTools_SetAddonCompartmentShown(true)
  if event == "PLAYER_ENTERING_WORLD" and not IsInGroup() and not IsInInstance() then return end
  if not MythicDungeonTools_Load() then return end

  local fullMDT = _G.MDT
  if event == "PLAYER_ENTERING_WORLD" and fullMDT.PLAYER_ENTERING_WORLD then
    fullMDT.PLAYER_ENTERING_WORLD()
  elseif event == "READY_CHECK" and fullMDT.FocusMarker_OnReadyCheck then
    fullMDT:FocusMarker_OnReadyCheck()
  end
end)

hooksecurefunc("ResetInstances", function()
  if MythicDungeonTools_Load() then
    local fullMDT = _G.MDT
    if fullMDT.AnnounceDungeonReset then fullMDT:AnnounceDungeonReset() end
  end
end)
