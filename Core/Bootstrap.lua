local addonName, MDT = ...
local L = MDT.L
local API = MDT.API

local UI_ADDON_NAME = "MythicDungeonTools_UI"
local UI_DISABLED_POPUP = "MDT_UI_DISABLED"
local coreDefaults = {
  enemyForcesTooltip = 1,
  muteXalatathVoiceLines = false,
  announceDungeonReset = false,
  minimap = {
    hide = false,
    compartmentHide = false,
  },
  focusMarker = {
    announceReadyCheck = false,
    useMacro = false,
    disableTargetMarkerInRaid = false,
    preserveExistingTargetMarkers = true,
    suppressNotifications = false,
    assignments = {},
  },
  combatLogging = {
    enabled = false,
    content = {
      lfr = false,
      normal = false,
      heroic = false,
      mythic = false,
      mythic_dungeon = false,
      mythic_plus = false,
    },
  },
}

local function applyDefaults(target, defaults)
  for key, value in pairs(defaults) do
    if target[key] == nil then
      target[key] = type(value) == "table" and CopyTable(value) or value
    elseif type(target[key]) == "table" and type(value) == "table" then
      applyDefaults(target[key], value)
    end
  end
end

if type(MythicDungeonToolsDB) ~= "table" then MythicDungeonToolsDB = {} end
if type(MythicDungeonToolsDB.global) ~= "table" then MythicDungeonToolsDB.global = {} end
applyDefaults(MythicDungeonToolsDB.global, coreDefaults)

local db = MythicDungeonToolsDB.global
MDT.BackdropColor = { 0.058823399245739, 0.058823399245739, 0.058823399245739, 0.9 }

function MDT:GetDB()
  return db
end

MDT:ExportAPI("GetDB")

function API:GetBackdropColor()
  return unpack(MDT.BackdropColor)
end

function MDT:HardReset()
  MythicDungeonToolsDB = nil
  ReloadUI()
end

function MDT:ResetDataCache()
  db.dungeonEnemies = nil
  db.mapPOIs = nil
  ReloadUI()
end

local uiHandlers
local uiPluginAPI
local uiLoading
local uiLoadingSpinner
local pendingPresetComms = {}
local pendingUIInitializers = {}

local function runUIInitializer(initializer)
  xpcall(function() initializer(uiPluginAPI) end, geterrorhandler())
end

function API:RegisterUIInitializer(initializer)
  assert(type(initializer) == "function", "MythicDungeonTools UI initializer must be a function")
  if uiPluginAPI then
    runUIInitializer(initializer)
  else
    pendingUIInitializers[#pendingUIInitializers + 1] = initializer
  end
end

function API:AttachUI(handlers, pluginAPI)
  assert(not uiHandlers, "MythicDungeonTools UI already attached")
  assert(type(handlers) == "table", "MythicDungeonTools UI handlers must be a table")
  for _, methodName in ipairs({ "ShowInterface", "HandleSlashCommand", "HandleChatLink", "OnCommReceived", "GetEnemyForces", "GetDungeonName", "GetDungeonSublevels" }) do
    assert(type(handlers[methodName]) == "function", "Missing MythicDungeonTools UI handler: "..methodName)
  end
  assert(type(pluginAPI) == "table", "MythicDungeonTools UI plugin API must be a table")
  for _, methodName in ipairs({ "RegisterNavigationSection", "GetCurrentSection", "SetCurrentSection", "GetNavigationSectionContentFrame", "HideAllDialogs", "RegisterDungeonData" }) do
    assert(type(pluginAPI[methodName]) == "function", "Missing MythicDungeonTools UI plugin method: "..methodName)
  end
  uiHandlers = handlers
  uiPluginAPI = pluginAPI
  for _, initializer in ipairs(pendingUIInitializers) do runUIInitializer(initializer) end
  wipe(pendingUIInitializers)
end

local function isUILoaded()
  local loadedOrLoading, loaded = C_AddOns.IsAddOnLoaded(UI_ADDON_NAME)
  return loaded == nil and loadedOrLoading or loaded
end

local function showUILoading()
  if not uiLoadingSpinner then
    local spinner = CreateFrame("Button", "MDTUILoadingSpinner", UIParent, "LoadingSpinnerTemplate")
    spinner:SetPoint("CENTER", UIParent, "CENTER")
    spinner:SetFrameStrata("DIALOG")
    spinner:SetSize(60, 60)
    spinner.BackgroundFrame.Background:SetVertexColor(0, 1, 0, 1)
    spinner.AnimFrame.Circle:SetVertexColor(0, 1, 0, 1)
    uiLoadingSpinner = spinner
  end

  uiLoadingSpinner:Show()
  uiLoadingSpinner.Anim:Play()
end

local function hideUILoading()
  if not uiLoadingSpinner then return end
  uiLoadingSpinner:Hide()
  uiLoadingSpinner.Anim:Stop()
end

StaticPopupDialogs[UI_DISABLED_POPUP] = {
  text = "MythicDungeonTools UI is disabled. Enable it and reload the interface?",
  button1 = "Enable and Reload",
  button2 = _G.CANCEL,
  OnAccept = function()
    C_AddOns.EnableAddOn(UI_ADDON_NAME)
    ReloadUI()
  end,
  timeout = 0,
  whileDead = true,
  hideOnEscape = true,
}

function MDT:LoadUI(reason)
  if isUILoaded() then return true end
  if uiLoading then return false end

  uiLoading = true
  local loaded, loadError = C_AddOns.LoadAddOn(UI_ADDON_NAME)
  uiLoading = nil

  if not loaded and not isUILoaded() then
    if loadError == "DISABLED" then
      StaticPopup_Show(UI_DISABLED_POPUP)
    end
    print(("|cffffd100MDT:|r Failed to load UI%s: %s"):format(reason and " ("..reason..")" or "", loadError or "unknown error"))
    return false
  end
  return true
end

local function callUI(methodName, ...)
  if not MDT:LoadUI(methodName) then
    hideUILoading()
    return
  end
  hideUILoading()
  if uiHandlers then
    for _, comm in ipairs(pendingPresetComms) do
      uiHandlers.OnCommReceived(unpack(comm))
    end
    wipe(pendingPresetComms)
  end
  local implementation = uiHandlers and uiHandlers[methodName]
  if type(implementation) ~= "function" then
    print("|cffffd100MDT:|r UI method unavailable: "..methodName)
    return
  end
  return implementation(...)
end

local function callUIWithLoading(methodName, ...)
  if isUILoaded() then return callUI(methodName, ...) end

  local args = { ... }
  showUILoading()
  C_Timer.After(0, function() callUI(methodName, unpack(args)) end)
end

function MDT:ShowInterface(...)
  return callUIWithLoading("ShowInterface", ...)
end

function MDT:GetEnemyForces(...)
  return callUI("GetEnemyForces", ...)
end

function MDT:GetDungeonName(...)
  return callUI("GetDungeonName", ...)
end

function MDT:GetDungeonSublevels(...)
  return callUI("GetDungeonSublevels", ...)
end

MDT:ExportAPI("ShowInterface")
MDT:ExportAPI("GetEnemyForces")
MDT:ExportAPI("GetDungeonName")
MDT:ExportAPI("GetDungeonSublevels")

BINDING_HEADER_MDT = "Mythic Dungeon Tools (MDT)"
BINDING_NAME_MDTTOGGLE = L["Toggle MDT"]
_G["BINDING_NAME_CLICK MDTFocusMarkerButton:LeftButton"] = L["MDT Set Focus Macro"]

SLASH_MYTHICDUNGEONTOOLS1 = "/mplus"
SLASH_MYTHICDUNGEONTOOLS2 = "/mdt"
SLASH_MYTHICDUNGEONTOOLS3 = "/mythicdungeontools"

function SlashCmdList.MYTHICDUNGEONTOOLS(cmd, editbox)
  cmd = cmd:lower()
  local request, argument = strsplit(" ", cmd)
  if request == "minimap" then
    if db.minimap.hide then MDT:ShowMinimapButton() else MDT:HideMinimapButton() end
    return
  elseif request == "hardreset" and argument == "force" then
    MDT:HardReset()
    return
  end

  callUIWithLoading("HandleSlashCommand", cmd, editbox)
end

local minimapIcon = LibStub("LibDBIcon-1.0")
local dataBroker = LibStub("LibDataBroker-1.1"):NewDataObject("MythicDungeonTools", {
  type = "data source",
  text = "Mythic Dungeon Tools",
  icon = "Interface\\AddOns\\MythicDungeonTools\\Textures\\MDTMinimap",
  OnClick = function(_, button)
    if button == "RightButton" then
      if db.minimap.lock then
        minimapIcon:Unlock("MythicDungeonTools")
      else
        minimapIcon:Lock("MythicDungeonTools")
      end
    elseif button == "MiddleButton" then
      if db.minimap.hide then MDT:ShowMinimapButton() else MDT:HideMinimapButton() end
    else
      MDT:ShowInterface()
    end
  end,
  OnTooltipShow = function(tooltip)
    if not tooltip or not tooltip.AddLine then return end
    tooltip:AddLine("|cFFFFFFFFMythic Dungeon Tools|r")
    tooltip:AddLine(L["Click to toggle AddOn Window"])
    tooltip:AddLine(L["Right-click to lock Minimap Button"])
    tooltip:AddLine(L["Middle-click to disable Minimap Button"])
  end,
})

function MDT:HideMinimapButton()
  db.minimap.hide = true
  minimapIcon:Hide("MythicDungeonTools")
  if uiHandlers and uiHandlers.OnMinimapVisibilityChanged then uiHandlers.OnMinimapVisibilityChanged(false) end
  print("MDT: Use /mdt minimap to show the minimap icon again")
end

function MDT:ShowMinimapButton()
  db.minimap.hide = false
  minimapIcon:Refresh("MythicDungeonTools", db.minimap)
  if uiHandlers and uiHandlers.OnMinimapVisibilityChanged then uiHandlers.OnMinimapVisibilityChanged(true) end
end

function MDT:RefreshMinimapButton()
  if not db.minimap.hide then minimapIcon:Refresh("MythicDungeonTools", db.minimap) end
end

function MDT:SetCompartmentButtonShown(shown)
  db.minimap.compartmentHide = not shown
  if shown then
    minimapIcon:AddButtonToCompartment("MythicDungeonTools")
  else
    minimapIcon:RemoveButtonFromCompartment("MythicDungeonTools")
  end
end

MDT:ExportAPI("HideMinimapButton")
MDT:ExportAPI("ShowMinimapButton")
MDT:ExportAPI("SetCompartmentButtonShown")

minimapIcon:Register("MythicDungeonTools", dataBroker, db.minimap)
if not db.minimap.hide then MDT:ShowMinimapButton() end
if not db.minimap.compartmentHide then minimapIcon:AddButtonToCompartment("MythicDungeonTools") end

local function buildFocusMarkerMacro(settings)
  local markerIndex = tonumber(settings.lastMarker) or 0
  local body = "/focus [@mouseover,exists,nodead][]"
  local conditionals = "[@focus]"
  local targetMarkerIndex = markerIndex
  if settings.disableTargetMarkerInRaid then
    body = body.."\n/stopmacro [group:raid]"
    conditionals = "[@focus,harm,exists]"
  end
  if markerIndex > 0 and settings.preserveExistingTargetMarkers then targetMarkerIndex = "~"..markerIndex end
  return body.."\n/tm "..conditionals.." "..targetMarkerIndex
end

local focusMarkerButton = CreateFrame("Button", "MDTFocusMarkerButton", UIParent, "SecureActionButtonTemplate")
focusMarkerButton:SetSize(1, 1)
focusMarkerButton:SetPoint("TOPLEFT", UIParent, "TOPLEFT", -100, -100)
focusMarkerButton:SetAlpha(0)
focusMarkerButton:EnableMouse(false)
focusMarkerButton:RegisterForClicks("AnyUp", "AnyDown")
focusMarkerButton:SetAttribute("type1", "macro")
focusMarkerButton:SetAttribute("macrotext1", buildFocusMarkerMacro(db.focusMarker))

local xalatathSoundFileIds = {
  1391165, 1391166, 2530794, 2530796, 2530797, 2530798, 2530811, 2530835, 5770084, 5770087, 5834632, 5835211,
  5835212, 5835214, 5835215, 5835725, 5835726, 5854705, 5859141, 6178475, 6178476, 6178477, 6178478, 6178479,
  6178480, 6178481, 6178488, 6178489, 6178494, 6178497, 6178498, 6178500, 6178502, 6178504, 6178506, 6178508,
}

function MDT:SetXalatathVoiceLinesMuted(muted)
  local updateSoundFile = muted and MuteSoundFile or UnmuteSoundFile
  for _, soundFileId in ipairs(xalatathSoundFileIds) do updateSoundFile(soundFileId) end
end

function MDT:ApplyXalatathVoiceLinesMute()
  if db.muteXalatathVoiceLines then MDT:SetXalatathVoiceLinesMuted(true) end
end

local dungeonResetAnnounceHooked
function MDT:EnableDungeonResetAnnounceHook()
  if dungeonResetAnnounceHooked then return end
  dungeonResetAnnounceHooked = true
  hooksecurefunc("ResetInstances", function()
    if not MDT:GetDB().announceDungeonReset then return end
    local message = MDT.L["dungeonResetAnnouncement"]
    if IsInRaid() then
      C_ChatInfo.SendChatMessage(message, "RAID")
    elseif IsInGroup() then
      C_ChatInfo.SendChatMessage(message, "PARTY")
    else
      print(message)
    end
  end)
end

local enemyForcesTooltipEnabled
function MDT:EnableEnemyForcesTooltip()
  if enemyForcesTooltipEnabled then return end
  enemyForcesTooltipEnabled = true
  TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Unit, function(tooltip)
    local option = MDT:GetDB().enemyForcesTooltip
    if option == 1 or not IsInInstance() then return end
    local count, percent = C_ScenarioInfo.GetUnitCriteriaProgressValues("mouseover")
    if not count or not percent then return end

    local label = MDT.L["Enemy Info NPC Enemy Forces"]
    local formats = {
      [2] = "%s: %.1f%% (%d)",
      [3] = "%s: %d",
      [4] = "%s: %.1f%%",
      [5] = "%.1f%% (%d)",
      [6] = "%d",
      [7] = "%.1f%%",
    }
    local format = formats[option]
    if not format then return end
    local text
    if option == 2 then text = format:format(label, percent, count)
    elseif option == 3 then text = format:format(label, count)
    elseif option == 4 then text = format:format(label, percent)
    elseif option == 5 then text = format:format(percent, count)
    elseif option == 6 then text = format:format(count)
    else text = format:format(percent) end
    tooltip:AddLine("|TInterface\\AddOns\\MythicDungeonTools\\Textures\\MDTMinimap:0:0|t"..text, 1, 1, 1)
    tooltip:Show()
  end)
end

if db.announceDungeonReset then MDT:EnableDungeonResetAnnounceHook() end
if db.enemyForcesTooltip ~= 1 then MDT:EnableEnemyForcesTooltip() end

MDT:ExportAPI("SetXalatathVoiceLinesMuted")
MDT:ExportAPI("EnableDungeonResetAnnounceHook")
MDT:ExportAPI("EnableEnemyForcesTooltip")

MDT.presetCommPrefix = "MDTPreset"
MDT.versionCheckPrefix = "MDTVersion"
MDT.liveSessionPrefixes = {
  enabled = "MDTLiveEnabled",
  request = "MDTLiveReq",
  ping = "MDTLivePing",
  obj = "MDTLiveObj",
  objOff = "MDTLiveObjOff",
  objChg = "MDTLiveObjChg",
  cmd = "MDTLiveCmd",
  note = "MDTLiveNote",
  preset = "MDTLivePreset",
  pull = "MDTLivePull",
  free = "MDTLiveFree",
  bora = "MDTLiveBora",
  reqPre = "MDTLiveReqPre",
  difficulty = "MDTLiveLvl",
  poiAssignment = "MDTPOIAssignment",
  focusMarkerAssignment = "MDTFocusMark",
}

MDT.commsObject = MDT.commsObject or {}
local commsObject = MDT.commsObject
LibStub("AceComm-3.0"):Embed(commsObject)

function API:GetVersionCheckPrefix()
  return MDT.versionCheckPrefix
end

function API:GetPresetCommPrefix()
  return MDT.presetCommPrefix
end

function API:GetLiveSessionPrefixes()
  return CopyTable(MDT.liveSessionPrefixes)
end

function API:SendCommMessage(...)
  return commsObject:SendCommMessage(...)
end

local function onCommReceived(self, prefix, message, distribution, sender)
  if prefix == MDT.versionCheckPrefix then
    if message == "R" and distribution == "PARTY" then
      local version = C_AddOns.GetAddOnMetadata(addonName, "Version")
      self:SendCommMessage(prefix, "V"..version, "PARTY", nil, "ALERT")
      return
    end
  end

  if isUILoaded() and uiHandlers then
    return uiHandlers.OnCommReceived(prefix, message, distribution, sender)
  end
  -- Preset links need their payload later; live links request fresh session state when clicked.
  if prefix == MDT.presetCommPrefix then
    pendingPresetComms[#pendingPresetComms + 1] = { prefix, message, distribution, sender }
  end
end

commsObject.OnCommReceived = onCommReceived
commsObject:RegisterComm(MDT.presetCommPrefix)
commsObject:RegisterComm(MDT.versionCheckPrefix)
for _, prefix in pairs(MDT.liveSessionPrefixes) do commsObject:RegisterComm(prefix) end

local lastChatWarningAt = 0
local function checkChatframeInteractive(chatFrame)
  if chatFrame and chatFrame.isUninteractable and GetTime() - lastChatWarningAt >= 5 * 60 then
    lastChatWarningAt = GetTime()
    C_Timer.After(0.2, function()
      print("MDT: |cFFFF0000Warning!|r "..L["chatNoninteractiveWarning"])
    end)
  end
end

local function filterRouteLinks(chatFrame, event, msg, player, l, cs, t, flag, channelId, ...)
  if flag == "GM" or flag == "DEV" or (event == "CHAT_MSG_CHANNEL" and type(channelId) == "number" and channelId > 0) then
    return
  end

  local newMsg = ""
  local remaining = msg
  repeat
    local start, finish, characterName, displayName = remaining:find("%[MDT_v2: ([^%s]+) %- ([^%]]+)%]")
    local startLive, finishLive, characterNameLive, displayNameLive = remaining:find("%[MDTLive: ([^%s]+) %- ([^%]]+)%]")
    if characterName and displayName then
      characterName = characterName:gsub("|c[Ff][Ff]......", ""):gsub("|r", "")
      displayName = displayName:gsub("|c[Ff][Ff]......", ""):gsub("|r", "")
      newMsg = newMsg..remaining:sub(1, start - 1).."|cffe6cc80|Hgarrmission:mdt-"..characterName.."|h["..displayName.."]|h|r"
      remaining = remaining:sub(finish + 1)
      checkChatframeInteractive(chatFrame)
    elseif characterNameLive and displayNameLive then
      characterNameLive = characterNameLive:gsub("|c[Ff][Ff]......", ""):gsub("|r", "")
      displayNameLive = displayNameLive:gsub("|c[Ff][Ff]......", ""):gsub("|r", "")
      newMsg = newMsg..remaining:sub(1, startLive - 1).."|Hgarrmission:mdtlive-"..characterNameLive..
          "|h[|cFF00FF00Live Session: |cffe6cc80"..displayNameLive.."]|h|r"
      remaining = remaining:sub(finishLive + 1)
      checkChatframeInteractive(chatFrame)
    else
      if newMsg ~= "" then
        return false, newMsg..remaining, player, l, cs, t, flag, channelId, ...
      end
      return
    end
  until false
end

local addMessageEventFilter = ChatFrame_AddMessageEventFilter or ChatFrameUtil.AddMessageEventFilter
addMessageEventFilter("CHAT_MSG_PARTY", filterRouteLinks)
addMessageEventFilter("CHAT_MSG_PARTY_LEADER", filterRouteLinks)
addMessageEventFilter("CHAT_MSG_RAID", filterRouteLinks)
addMessageEventFilter("CHAT_MSG_RAID_LEADER", filterRouteLinks)

hooksecurefunc("SetItemRef", function(link, text)
  if link and (link:sub(1, 19) == "garrmission:mdtlive" or link:sub(1, 15) == "garrmission:mdt") then
    callUIWithLoading("HandleChatLink", link, text)
  end
end)

local eventFrame = CreateFrame("Frame")
eventFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
eventFrame:RegisterEvent("READY_CHECK")
eventFrame:SetScript("OnEvent", function(self, event)
  if event == "READY_CHECK" then
    if isUILoaded() then return end
    local settings = MDT:GetDB().focusMarker
    local markerIndex = tonumber(settings.lastMarker)
    if settings.announceReadyCheck and markerIndex and markerIndex >= 1 and markerIndex <= 8 and not IsInRaid() then
      C_ChatInfo.SendChatMessage(MDT.L["focusMarkerChatAnnouncement"]:format(markerIndex), "PARTY")
    end
    return
  end

  MDT:RefreshMinimapButton()
  MDT:ApplyXalatathVoiceLinesMute()
  if C_AddOns.IsAddOnLoaded("DungeonTools") then
    SLASH_DUNGEONTOOLS1 = "/mplus"
    SLASH_DUNGEONTOOLS2 = "/mdt"
    SLASH_DUNGEONTOOLS3 = "/dungeontools"
    SlashCmdList.DUNGEONTOOLS = function() MDT:ShowInterface() end
    local dungeonToolsButton = minimapIcon.objects and minimapIcon.objects.DungeonTools
    if dungeonToolsButton then dungeonToolsButton:SetScript("OnClick", function() MDT:ShowInterface() end) end
  end
  if db.loadOnStartUp and db.devMode then MDT:ShowInterface(true) end
  self:UnregisterEvent("PLAYER_ENTERING_WORLD")
end)
