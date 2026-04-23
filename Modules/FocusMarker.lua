local MDT = MDT
local L = MDT.L
local MDTcommsObject = MDTcommsObject
local AceGUI = LibStub("AceGUI-3.0")

local MACRO_NAME = "MDTFocusMarker"
local MACRO_CONDITIONALS = "[@mouseover,exists,nodead][]"
local MACRO_ICON = 1033497
local MDT_LOGO = "Interface\\AddOns\\MythicDungeonTools\\Textures\\MDTFull"
local NO_MACRO_SLOTS_ERROR = "nomacroslots"
local KEYBIND_BUTTON_NAME = "MDTFocusMarkerButton"
local KEYBIND_COMMAND = "CLICK MDTFocusMarkerButton:LeftButton"
local NOTIFICATION_DURATION = 4
local KEYBIND_HINT_NOTIFICATION_DURATION = 8

local markerNames = {
  [0] = "None",
  [1] = "Star",
  [2] = "Circle",
  [3] = "Diamond",
  [4] = "Triangle",
  [5] = "Moon",
  [6] = "Square",
  [7] = "Cross",
  [8] = "Skull",
}

local iconColors = {
  [1] = { 1, .92, 0, 1 },
  [2] = { .98, .57, 0, 1 },
  [3] = { .83, .22, .9, 1 },
  [4] = { .04, .95, 0, 1 },
  [5] = { .7, .82, .875, 1 },
  [6] = { 0, .71, 1, 1 },
  [7] = { 1, .24, .168, 1 },
  [8] = { .98, .98, .98, 1 },
}

local classDefaultMarkers = {
  { class = "ROGUE",       markers = { 1, 7, 8, 2, 6, 4, 5, 3 } },
  { class = "DEATHKNIGHT", markers = { 7, 8, 1, 2, 6, 3, 4, 5 } },
  { class = "WARRIOR",     markers = { 2, 7, 1, 8, 6, 4, 5, 3 } },
  { class = "SHAMAN",      markers = { 6, 5, 7, 1, 2, 4, 3, 8 } },
  { class = "MAGE",        markers = { 5, 6, 1, 7, 2, 4, 3, 8 } },
  { class = "HUNTER",      markers = { 4, 1, 7, 2, 6, 5, 3, 8 } },
  { class = "WARLOCK",     markers = { 3, 8, 7, 6, 5, 2, 4, 1 } },
  { class = "PRIEST",      markers = { 8, 5, 1, 6, 7, 2, 3, 4 } },
  { class = "DEMONHUNTER", markers = { 3, 4, 8, 7, 2, 6, 5, 1 } },
  { class = "DRUID",       markers = { 2, 4, 1, 5, 7, 6, 3, 8 } },
  { class = "MONK",        markers = { 4, 2, 6, 1, 5, 7, 3, 8 } },
  { class = "PALADIN",     markers = { 1, 3, 2, 8, 7, 6, 5, 4 } },
  { class = "EVOKER",      markers = { 4, 6, 5, 3, 1, 2, 7, 8 } },
}

local pendingMacroName
local pendingMacroIcon
local pendingMacroBody
local pendingMacroMarkerIndex
local pendingMacroSender
local pendingMacroUseMacro
local pendingMacroQueued
local pendingStartupMarkerIndex
local pendingStartupSender

local function getFullName(name, realm)
  if not name then return end
  if not realm or realm == "" then
    local _, playerRealm = UnitFullName("player")
    realm = playerRealm
  end
  if realm and realm ~= "" then
    return name.."-"..realm
  end
  return name
end

local function getPlayerFullName()
  return getFullName(UnitFullName("player"))
end

local function getShortName(fullName)
  return fullName and fullName:match("^[^-]+") or fullName
end

local function markerTexture(index, size)
  if index and index >= 1 and index <= 8 then
    size = size or 16
    return ("|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_%d:%d:%d:0:0|t"):format(index, size, size)
  end
  return ""
end

local function markerLabel(index)
  index = tonumber(index)
  if not index or index == 0 then return L["None"] end
  local name = _G["RAID_TARGET_"..index] or markerNames[index] or tostring(index)
  local color = iconColors[index]
  if color then
    name = WrapTextInColor(name, CreateColor(unpack(color)))
  end
  return markerTexture(index).." "..name
end

local function findNextAvailableMarker(usedMarkers, markerPriorities)
  if type(markerPriorities) == "number" then
    markerPriorities = { markerPriorities }
  end

  for _, markerIndex in ipairs(markerPriorities or {}) do
    if markerIndex > 0 and not usedMarkers[markerIndex] then
      return markerIndex
    end
  end

  for markerIndex = 1, 8 do
    if not usedMarkers[markerIndex] then
      return markerIndex
    end
  end
end

local notificationFrame
local notificationSerial = 0
local getMacroSettings
local openKeybindSettings
local openMarkSettings
local refreshAssignmentsFrame
local assignmentsFrame

local function clearPendingMacroUpdate()
  pendingMacroName = nil
  pendingMacroIcon = nil
  pendingMacroBody = nil
  pendingMacroMarkerIndex = nil
  pendingMacroSender = nil
  pendingMacroUseMacro = nil
  pendingMacroQueued = nil
end

local function getClassColoredName(name, class)
  if not name then return L["Unknown"] end
  local _, _, _, classHexString = GetClassColor(class or "PRIEST")
  return WrapTextInColorCode(name, classHexString)
end

local function getNotificationFrame()
  if notificationFrame then return notificationFrame end

  local frame = CreateFrame("Frame", "MDTFocusMarkerNotificationFrame", UIParent)
  frame:SetSize(430, 64)
  frame:SetPoint("CENTER", UIParent, "CENTER", 0, 150)
  frame:SetFrameStrata("DIALOG")
  frame:EnableMouse(true)
  frame:SetScript("OnMouseUp", function(self, button)
    if button == "RightButton" then
      notificationSerial = notificationSerial + 1
      self:Hide()
    end
  end)

  frame.bg = frame:CreateTexture(nil, "BACKGROUND")
  frame.bg:SetAllPoints()
  frame.bg:SetColorTexture(unpack(MDT.BackdropColor))

  frame.closeButton = CreateFrame("Button", nil, frame)
  frame.closeButton:SetSize(18, 18)
  frame.closeButton:SetPoint("TOPRIGHT", -5, -5)
  frame.closeButton.text = frame.closeButton:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
  frame.closeButton.text:SetAllPoints()
  frame.closeButton.text:SetText("X")
  frame.closeButton.text:SetTextColor(0.7, 0.7, 0.7)
  frame.closeButton:SetScript("OnEnter", function(self)
    self.text:SetTextColor(1, 0.8196, 0)
  end)
  frame.closeButton:SetScript("OnLeave", function(self)
    self.text:SetTextColor(0.7, 0.7, 0.7)
  end)
  frame.closeButton:SetScript("OnClick", function()
    notificationSerial = notificationSerial + 1
    frame:Hide()
  end)

  frame.logo = frame:CreateTexture(nil, "OVERLAY")
  frame.logo:SetTexture(MDT_LOGO)
  frame.logo:SetSize(18, 18)
  frame.logo:SetPoint("TOP", frame, "TOP", -18, -8)

  frame.brand = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
  frame.brand:SetText("MDT")
  frame.brand:SetWidth(30)
  frame.brand:SetPoint("LEFT", frame.logo, "RIGHT", 5, 0)
  frame.brand:SetJustifyH("LEFT")
  frame.brand:SetJustifyV("MIDDLE")

  frame.icon = frame:CreateTexture(nil, "OVERLAY")
  frame.icon:SetSize(20, 20)
  frame.icon:SetPoint("LEFT", 18, -6)

  frame.text = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
  frame.text:SetPoint("LEFT", frame.icon, "RIGHT", 8, 0)
  frame.text:SetPoint("RIGHT", -12, 0)
  frame.text:SetHeight(16)
  frame.text:SetJustifyH("LEFT")
  frame.text:SetJustifyV("MIDDLE")

  frame.keybindText = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
  frame.keybindText:SetHeight(14)
  frame.keybindText:SetJustifyH("LEFT")
  frame.keybindText:SetJustifyV("MIDDLE")
  frame.keybindText:SetTextColor(1, 0.8196, 0)
  frame.keybindText:Hide()

  local function createNotificationButton(text)
    local button = CreateFrame("Button", nil, frame)
    button.bg = button:CreateTexture(nil, "BACKGROUND")
    button.bg:SetAllPoints()
    button.bg:SetColorTexture(0.12, 0.09, 0.04, 0.95)
    button.borderTop = button:CreateTexture(nil, "BORDER")
    button.borderTop:SetPoint("TOPLEFT")
    button.borderTop:SetPoint("TOPRIGHT")
    button.borderTop:SetHeight(1)
    button.borderTop:SetColorTexture(1, 0.8196, 0, 0.35)
    button.borderBottom = button:CreateTexture(nil, "BORDER")
    button.borderBottom:SetPoint("BOTTOMLEFT")
    button.borderBottom:SetPoint("BOTTOMRIGHT")
    button.borderBottom:SetHeight(1)
    button.borderBottom:SetColorTexture(1, 0.8196, 0, 0.35)
    button.borderLeft = button:CreateTexture(nil, "BORDER")
    button.borderLeft:SetPoint("TOPLEFT")
    button.borderLeft:SetPoint("BOTTOMLEFT")
    button.borderLeft:SetWidth(1)
    button.borderLeft:SetColorTexture(1, 0.8196, 0, 0.35)
    button.borderRight = button:CreateTexture(nil, "BORDER")
    button.borderRight:SetPoint("TOPRIGHT")
    button.borderRight:SetPoint("BOTTOMRIGHT")
    button.borderRight:SetWidth(1)
    button.borderRight:SetColorTexture(1, 0.8196, 0, 0.35)
    button.label = button:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    button.label:SetAllPoints()
    button.label:SetText(text)
    button.label:SetTextColor(1, 0.8196, 0)
    button:SetScript("OnEnter", function(self)
      self.bg:SetColorTexture(0.2, 0.14, 0.05, 0.95)
    end)
    button:SetScript("OnLeave", function(self)
      self.bg:SetColorTexture(0.12, 0.09, 0.04, 0.95)
    end)
    return button
  end

  frame.markSettingsButton = createNotificationButton(L["Mark Settings"])
  frame.markSettingsButton:SetSize(116, 22)
  frame.markSettingsButton:SetPoint("BOTTOMRIGHT", frame, "BOTTOM", -4, 8)
  frame.markSettingsButton:SetScript("OnClick", function()
    notificationSerial = notificationSerial + 1
    frame:Hide()
    if openMarkSettings then
      openMarkSettings()
    end
  end)
  frame.markSettingsButton:Hide()

  frame.dontShowAgainButton = createNotificationButton(L["Don't show again"])
  frame.dontShowAgainButton:SetSize(116, 22)
  frame.dontShowAgainButton:SetPoint("LEFT", frame.markSettingsButton, "RIGHT", 8, 0)
  frame.dontShowAgainButton:SetScript("OnClick", function()
    local settings = getMacroSettings and getMacroSettings()
    if settings then
      settings.suppressNotifications = true
    end
    notificationSerial = notificationSerial + 1
    frame:Hide()
  end)
  frame.dontShowAgainButton:Hide()

  frame:Hide()
  notificationFrame = frame
  return frame
end

local function keybindSetupNeeded()
  if not GetBindingKey then return false end

  local settings = getMacroSettings and getMacroSettings()
  if not settings or settings.useMacro then return false end

  return not GetBindingKey(KEYBIND_COMMAND)
end

local function updateNotificationKeybindHint(frame)
  local showHint = keybindSetupNeeded()
  frame:EnableMouse(true)

  frame.logo:ClearAllPoints()
  frame.brand:ClearAllPoints()
  frame.icon:ClearAllPoints()
  frame.text:ClearAllPoints()
  frame.keybindText:ClearAllPoints()
  if showHint then
    frame:SetSize(430, 96)
    frame.logo:SetPoint("TOP", frame, "TOP", -18, -8)
    frame.brand:SetPoint("LEFT", frame.logo, "RIGHT", 5, 0)
    frame.icon:SetPoint("TOPLEFT", 20, -30)
    frame.text:SetPoint("LEFT", frame.icon, "RIGHT", 8, 0)
    frame.text:SetPoint("RIGHT", -12, 0)
    frame.keybindText:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", 48, 34)
    frame.keybindText:SetPoint("RIGHT", -12, 0)
    frame.keybindText:SetText(L["focusMarkerKeybindMissingToast"])
    frame.keybindText:Show()
    frame.markSettingsButton:Show()
    frame.dontShowAgainButton:Show()
  else
    frame:SetSize(430, 64)
    frame.logo:SetPoint("TOP", frame, "TOP", -18, -8)
    frame.brand:SetPoint("LEFT", frame.logo, "RIGHT", 5, 0)
    frame.icon:SetPoint("TOPLEFT", 20, -34)
    frame.text:SetPoint("LEFT", frame.icon, "RIGHT", 8, 0)
    frame.text:SetPoint("RIGHT", -12, 0)
    frame.keybindText:Hide()
    frame.markSettingsButton:Hide()
    frame.dontShowAgainButton:Hide()
  end
  return showHint
end

local function showAssignmentNotification(markerIndex, sender, queued)
  if not sender then return end
  local settings = getMacroSettings and getMacroSettings()
  if settings and settings.suppressNotifications then return end

  local frame = getNotificationFrame()
  local showKeybindHint = updateNotificationKeybindHint(frame)
  markerIndex = tonumber(markerIndex) or 0
  if markerIndex >= 1 and markerIndex <= 8 then
    frame.icon:SetTexture("Interface\\TargetingFrame\\UI-RaidTargetingIcon_"..markerIndex)
    frame.icon:SetTexCoord(0, 1, 0, 1)
  else
    frame.icon:SetTexture("Interface\\Buttons\\UI-GroupLoot-Pass-Up")
    frame.icon:SetTexCoord(0, 1, 0, 1)
  end

  local markerName = _G["RAID_TARGET_"..markerIndex] or markerNames[markerIndex] or tostring(markerIndex)
  local senderName = sender.name or getShortName(sender.fullName)
  local coloredSender = getClassColoredName(senderName, sender.class)
  local text = queued and L["focusMarkerAssignmentQueuedToast"] or L["focusMarkerAssignmentToast"]
  frame.text:SetText(string.format(text, markerName, coloredSender))

  notificationSerial = notificationSerial + 1
  local serial = notificationSerial
  local duration = showKeybindHint and KEYBIND_HINT_NOTIFICATION_DURATION or NOTIFICATION_DURATION
  frame:SetAlpha(1)
  frame:Show()
  C_Timer.After(duration, function()
    if notificationSerial == serial then
      frame:Hide()
    end
  end)
end

local function showNoMacroSlotsNotification()
  local frame = getNotificationFrame()
  frame:EnableMouse(true)
  frame:SetSize(430, 86)
  frame.logo:ClearAllPoints()
  frame.brand:ClearAllPoints()
  frame.icon:ClearAllPoints()
  frame.text:ClearAllPoints()
  frame.keybindText:ClearAllPoints()

  frame.logo:SetPoint("TOP", frame, "TOP", -18, -8)
  frame.brand:SetPoint("LEFT", frame.logo, "RIGHT", 5, 0)
  frame.icon:SetPoint("TOPLEFT", 20, -34)
  frame.icon:SetTexture("Interface\\Buttons\\UI-GroupLoot-Pass-Up")
  frame.icon:SetTexCoord(0, 1, 0, 1)
  frame.text:SetPoint("LEFT", frame.icon, "RIGHT", 8, 0)
  frame.text:SetPoint("RIGHT", -12, 0)
  frame.text:SetText(L["focusMarkerNoMacroSlotsTitle"])
  frame.keybindText:SetPoint("TOPLEFT", frame.text, "BOTTOMLEFT", 0, -6)
  frame.keybindText:SetPoint("RIGHT", -12, 0)
  frame.keybindText:SetText(L["focusMarkerNoMacroSlotsText"])
  frame.keybindText:Show()
  frame.markSettingsButton:Hide()
  frame.dontShowAgainButton:Hide()

  notificationSerial = notificationSerial + 1
  local serial = notificationSerial
  frame:SetAlpha(1)
  frame:Show()
  C_Timer.After(KEYBIND_HINT_NOTIFICATION_DURATION, function()
    if notificationSerial == serial then
      frame:Hide()
    end
  end)
end

local function notify(message)
  print("|cffffd100MDT:|r "..message)
end

local function notifyMacroUpdateFailed(err)
  if err == NO_MACRO_SLOTS_ERROR then
    showNoMacroSlotsNotification()
    notify(L["focusMarkerNoMacroSlotsText"])
  else
    notify(string.format(L["focusMarkerMacroUpdateFailed"], tostring(err)))
  end
end

getMacroSettings = function()
  local db = MDT:GetDB()
  if not db then return end
  db.focusMarker = db.focusMarker or {}
  if db.focusMarker.announceReadyCheck == nil then
    db.focusMarker.announceReadyCheck = false
  end
  if db.focusMarker.useMacro == nil then
    db.focusMarker.useMacro = false
  end
  if db.focusMarker.suppressNotifications == nil then
    db.focusMarker.suppressNotifications = false
  end
  return db.focusMarker
end

local function buildMacroBody(markerIndex)
  markerIndex = tonumber(markerIndex) or 0
  return "/focus "..MACRO_CONDITIONALS.."\n/tm [@focus] "..markerIndex
end

local function hasAccountMacroSlot()
  local numAccountMacros = GetNumMacros()
  return numAccountMacros < MAX_ACCOUNT_MACROS
end

local function createKeybindButton()
  if _G[KEYBIND_BUTTON_NAME] then return _G[KEYBIND_BUTTON_NAME] end

  local button = CreateFrame("Button", KEYBIND_BUTTON_NAME, UIParent, "SecureActionButtonTemplate")
  button:SetSize(1, 1)
  button:SetPoint("TOPLEFT", UIParent, "TOPLEFT", -100, -100)
  button:SetAlpha(0)
  button:EnableMouse(false)
  button:RegisterForClicks("AnyUp", "AnyDown")
  button:SetAttribute("type1", "macro")
  button:SetAttribute("macrotext1", buildMacroBody(0))
  return button
end

local function applyKeybindNow(body)
  if InCombatLockdown() then
    return false, "incombat"
  end

  local button = createKeybindButton()
  button:SetAttribute("type1", "macro")
  button:SetAttribute("macrotext1", body)
  return true
end

local function announceFocusMarker()
  local settings = getMacroSettings()
  if not settings then return end
  if not settings.announceReadyCheck then return end

  local markerIndex = tonumber(settings.lastMarker)
  if not markerIndex or markerIndex == 0 then return end

  local markerName = markerNames[markerIndex]
  if not markerName then return end

  C_ChatInfo.SendChatMessage(("My Focus Marker is {%s}"):format(markerName), "PARTY")
end

local eventFrame = CreateFrame("Frame")
eventFrame:RegisterEvent("READY_CHECK")
eventFrame:SetScript("OnEvent", function(_, event)
  if event == "READY_CHECK" then
    if IsInRaid() then return end
    announceFocusMarker()
  end
end)

local getGroupRoster
local pruneAssignmentsToRoster

local function applyMacroNow(name, icon, body)
  if InCombatLockdown() then
    return false, "incombat"
  end

  local ok, result = pcall(function()
    local macroIndex = GetMacroIndexByName(name)
    if macroIndex and macroIndex > 0 then
      EditMacro(macroIndex, name, icon, body)
    else
      if not hasAccountMacroSlot() then
        return NO_MACRO_SLOTS_ERROR
      end
      local createdMacroIndex = CreateMacro(name, icon, body, nil)
      if not createdMacroIndex or createdMacroIndex == 0 then
        return NO_MACRO_SLOTS_ERROR
      end
    end
  end)

  if not ok then
    return false, result
  end
  if result == NO_MACRO_SLOTS_ERROR then
    return false, result
  end
  return true
end

local function pickupFocusMarkerMacro()
  local settings = getMacroSettings()
  if not settings or not settings.useMacro then return end

  local name = settings.macroName or MACRO_NAME
  local icon = settings.macroIcon or MACRO_ICON
  local body = buildMacroBody(settings.lastMarker or 0)
  local macroIndex = GetMacroIndexByName(name)

  if not macroIndex or macroIndex == 0 or not InCombatLockdown() then
    local ok, err = applyMacroNow(name, icon, body)
    if not ok then
      notifyMacroUpdateFailed(err)
      return
    end
    macroIndex = GetMacroIndexByName(name)
  end

  if macroIndex and macroIndex > 0 then
    PickupMacro(macroIndex)
  end
end

createKeybindButton()

local queuedFrame = CreateFrame("Frame", "MDTFocusMarkerQueuedFrame")
queuedFrame:SetScript("OnEvent", function()
  if not pendingMacroQueued or InCombatLockdown() then return end

  local ok, err
  if pendingMacroUseMacro then
    ok, err = applyMacroNow(pendingMacroName, pendingMacroIcon, pendingMacroBody)
  else
    ok, err = applyKeybindNow(pendingMacroBody)
  end
  queuedFrame:UnregisterEvent("PLAYER_REGEN_ENABLED")

  if ok then
    if pendingMacroSender then
      showAssignmentNotification(pendingMacroMarkerIndex, pendingMacroSender)
    else
      notify(L["focusMarkerMacroUpdated"])
    end
  else
    notifyMacroUpdateFailed(err)
  end
  clearPendingMacroUpdate()
end)

local function queueMacroUpdate(name, icon, body, markerIndex, sender, useMacro)
  pendingMacroName = name
  pendingMacroIcon = icon
  pendingMacroBody = body
  pendingMacroMarkerIndex = markerIndex
  pendingMacroSender = sender
  pendingMacroUseMacro = useMacro
  pendingMacroQueued = true
  queuedFrame:RegisterEvent("PLAYER_REGEN_ENABLED")
  if sender then
    showAssignmentNotification(markerIndex, sender, true)
  else
    notify(L["focusMarkerMacroQueued"])
  end
end

function MDT:FocusMarker_GetAssignments()
  local settings = getMacroSettings()
  if not settings then return {} end
  if type(settings.assignments) ~= "table" then
    settings.assignments = {}
  end
  return settings.assignments
end

function MDT:FocusMarker_SetAssignment(fullName, markerIndex)
  if not fullName then return end
  local assignments = self:FocusMarker_GetAssignments()
  local roster = getGroupRoster()
  pruneAssignmentsToRoster(assignments, roster)
  local playerFullName = getPlayerFullName()
  local previousOwnMarker = assignments[playerFullName]
  local playerInGroup = false
  for _, player in ipairs(roster) do
    if player.fullName == fullName then
      playerInGroup = true
      break
    end
  end
  if not playerInGroup then return end

  markerIndex = tonumber(markerIndex)
  if markerIndex and markerIndex >= 1 and markerIndex <= 8 then
    for assignedPlayer, assignedMarker in pairs(assignments) do
      if assignedPlayer ~= fullName and assignedMarker == markerIndex then
        assignments[assignedPlayer] = nil
      end
    end
    assignments[fullName] = markerIndex
  else
    assignments[fullName] = nil
  end

  local currentOwnMarker = assignments[playerFullName]
  if previousOwnMarker ~= currentOwnMarker then
    self:FocusMarker_ApplyMarker(currentOwnMarker or 0)
  end
end

function MDT:FocusMarker_ApplyMarker(markerIndex, sender)
  markerIndex = tonumber(markerIndex)
  if not markerIndex or markerIndex < 0 or markerIndex > 8 then return end

  local settings = getMacroSettings()
  if not settings then
    pendingStartupMarkerIndex = markerIndex
    pendingStartupSender = sender
    return
  end
  settings.lastMarker = markerIndex

  local name = settings.macroName or MACRO_NAME
  local icon = settings.macroIcon or MACRO_ICON
  local body = buildMacroBody(markerIndex)
  local ok, err
  if settings.useMacro then
    ok, err = applyMacroNow(name, icon, body)
  else
    ok, err = applyKeybindNow(body)
  end
  if ok then
    if sender then
      showAssignmentNotification(markerIndex, sender)
    else
      notify(L["focusMarkerMacroUpdated"])
    end
  elseif err == "incombat" then
    queueMacroUpdate(name, icon, body, markerIndex, sender, settings.useMacro)
  else
    notifyMacroUpdateFailed(err)
  end
end

function MDT:FocusMarker_RefreshAction()
  local settings = getMacroSettings()
  if not settings then return end
  local markerIndex = tonumber(settings.lastMarker) or 0
  local body = buildMacroBody(markerIndex)
  if settings.useMacro then
    self:FocusMarker_ApplyMarker(markerIndex)
  else
    local ok, err = applyKeybindNow(body)
    if not ok and err == "incombat" then
      queueMacroUpdate(settings.macroName or MACRO_NAME, settings.macroIcon or MACRO_ICON, body, markerIndex, nil, false)
    end
  end
end

local startupFrame = CreateFrame("Frame")
startupFrame:RegisterEvent("ADDON_LOADED")
startupFrame:RegisterEvent("PLAYER_LOGIN")
startupFrame:SetScript("OnEvent", function(self, event, addonName)
  if event == "ADDON_LOADED" and addonName ~= "MythicDungeonTools" then return end
  if not MDT:GetDB() then return end

  C_Timer.After(0, function()
    if not MDT:GetDB() then return end

    if pendingStartupMarkerIndex ~= nil then
      local markerIndex = pendingStartupMarkerIndex
      local sender = pendingStartupSender
      pendingStartupMarkerIndex = nil
      pendingStartupSender = nil
      MDT:FocusMarker_ApplyMarker(markerIndex, sender)
    else
      MDT:FocusMarker_RefreshAction()
    end
  end)

  self:UnregisterEvent("ADDON_LOADED")
  self:UnregisterEvent("PLAYER_LOGIN")
end)

function MDT:FocusMarker_ApplySyncedAssignments(payload, senderFullName)
  if type(payload) ~= "table" or type(payload.assignments) ~= "table" then return end

  local assignments = self:FocusMarker_GetAssignments()
  local roster = getGroupRoster()
  local rosterLookup = {}
  local syncedAssignments = {}
  for _, player in ipairs(roster) do
    rosterLookup[player.fullName] = true
  end
  for fullName, markerIndex in pairs(payload.assignments) do
    markerIndex = tonumber(markerIndex)
    if type(fullName) == "string" and rosterLookup[fullName] and markerIndex and markerIndex >= 1 and markerIndex <= 8 then
      syncedAssignments[fullName] = markerIndex
    end
  end
  for fullName in pairs(assignments) do
    assignments[fullName] = nil
  end
  for fullName, markerIndex in pairs(syncedAssignments) do
    assignments[fullName] = markerIndex
  end

  self:FocusMarker_ApplyMarker(assignments[getPlayerFullName()] or 0, {
    fullName = payload.senderFullName or senderFullName,
    name = payload.senderName or getShortName(senderFullName),
    class = payload.senderClass,
  })

  if refreshAssignmentsFrame then
    refreshAssignmentsFrame()
  end
end

function MDT:FocusMarker_SendAssignments()
  local assignments = self:FocusMarker_GetAssignments()
  pruneAssignmentsToRoster(assignments, getGroupRoster())

  local senderName, senderRealm = UnitFullName("player")
  local payload = {
    senderFullName = getFullName(senderName, senderRealm),
    senderName = senderName,
    senderClass = select(2, UnitClass("player")),
    assignments = assignments,
  }

  local distribution = self:IsPlayerInGroup()
  if distribution then
    local export = self:TableToString(payload, false, 5)
    MDTcommsObject:SendCommMessage(self.liveSessionPrefixes.focusMarkerAssignment, export, distribution, nil, "ALERT")
  end

  self:FocusMarker_ApplySyncedAssignments(payload, payload.senderFullName)
end

function MDT:FocusMarker_OnCommReceived(message, senderFullName)
  if senderFullName == getPlayerFullName() then return end

  self:FocusMarker_ApplySyncedAssignments(self:StringToTable(message, false), senderFullName)
end

getGroupRoster = function()
  local roster = {}
  local seen = {}

  local function addUnit(unit)
    if not UnitExists(unit) then return end
    local name, realm = UnitFullName(unit)
    local fullName = getFullName(name, realm)
    if not fullName or seen[fullName] then return end

    local _, class = UnitClass(unit)
    table.insert(roster, {
      fullName = fullName,
      displayName = getClassColoredName(name, class),
      class = class,
    })
    seen[fullName] = true
  end

  if IsInRaid() then
    for i = 1, GetNumGroupMembers() do
      addUnit("raid"..i)
    end
  else
    addUnit("player")
    for i = 1, GetNumSubgroupMembers() do
      addUnit("party"..i)
    end
  end

  local playerFullName = getPlayerFullName()
  table.sort(roster, function(a, b)
    if a.fullName == playerFullName then return true end
    if b.fullName == playerFullName then return false end
    return a.fullName < b.fullName
  end)

  return roster
end

pruneAssignmentsToRoster = function(assignments, roster)
  local inGroup = {}
  for _, player in ipairs(roster) do
    inGroup[player.fullName] = true
  end
  for fullName in pairs(assignments) do
    if not inGroup[fullName] then
      assignments[fullName] = nil
    end
  end
end

local function setButtonMarker(button, markerIndex)
  button.markerIndex = markerIndex
  button:SetText(markerLabel(markerIndex))
end

refreshAssignmentsFrame = function()
  if not assignmentsFrame or not assignmentsFrame.frame or not assignmentsFrame.frame:IsShown() then return end
  C_Timer.After(0, function()
    MDT:FocusMarker_OpenAssignments()
  end)
end

local function addCheckbox(frame, label, value, onChanged)
  local checkbox = AceGUI:Create("CheckBox")
  checkbox:SetLabel(label)
  checkbox:SetFullWidth(true)
  checkbox:SetValue(value)
  checkbox:SetCallback("OnValueChanged", function(_, _, newValue)
    onChanged(newValue)
  end)
  frame:AddChild(checkbox)
end

local function addButton(frame, text, width, onClick)
  local button = AceGUI:Create("Button")
  button:SetWidth(width)
  button:SetText(text)
  button:SetCallback("OnClick", onClick)
  frame:AddChild(button)
end

local function applyClassDefaults(roster, assignments)
  pruneAssignmentsToRoster(assignments, roster)
  for fullName in pairs(assignments) do
    assignments[fullName] = nil
  end

  local usedMarkers = {}
  local assignedPlayers = {}
  for _, classDefaults in ipairs(classDefaultMarkers) do
    for _, player in ipairs(roster) do
      if player.class == classDefaults.class and not assignedPlayers[player.fullName] then
        local markerIndex = findNextAvailableMarker(usedMarkers, classDefaults.markers)
        if markerIndex and markerIndex > 0 then
          assignments[player.fullName] = markerIndex
          usedMarkers[markerIndex] = true
        end
        assignedPlayers[player.fullName] = true
      end
    end
  end

  for _, player in ipairs(roster) do
    if not assignedPlayers[player.fullName] then
      local markerIndex = findNextAvailableMarker(usedMarkers)
      if markerIndex and markerIndex > 0 then
        assignments[player.fullName] = markerIndex
        usedMarkers[markerIndex] = true
      end
    end
  end
end

openKeybindSettings = function()
  local keybindCategory = BINDING_HEADER_MDT or "Mythic Dungeon Tools (MDT)"

  if Settings and Settings.KEYBINDINGS_CATEGORY_ID and Settings.OpenToCategory then
    Settings.OpenToCategory(Settings.KEYBINDINGS_CATEGORY_ID, keybindCategory)

    if SettingsPanel and SettingsPanel.Container and SettingsPanel.Container.SettingsList and
        SettingsPanel.Container.SettingsList.ScrollBox then
      C_Timer.After(0, function()
        local _, frames = SettingsPanel.Container.SettingsList.ScrollBox:EnumerateFrames()
        for _, frame in pairs(frames) do
          if frame.Button and frame.Button.Text and frame.Button.Text:GetText() == keybindCategory then
            if frame.Controls and frame.Controls[1] and frame.Controls[1].IsShown and not frame.Controls[1]:IsShown() then
              frame.Button:Click()
              C_Timer.After(0, function()
                SettingsPanel.Container.SettingsList.ScrollBox:ScrollIncrease(3)
              end)
            end
            break
          end
        end
      end)
    end
    return
  end

  if KeyBindingFrame_LoadUI then
    KeyBindingFrame_LoadUI()
  end
  if KeyBindingFrame then
    KeyBindingFrame:Show()
  end
end

openMarkSettings = function()
  if MDT.ShowInterface then
    MDT:ShowInterface(true)
  end

  local attempts = 0
  local function openWhenReady()
    attempts = attempts + 1
    if MDT.main_frame and MDT.FocusMarker_OpenAssignments then
      MDT:FocusMarker_OpenAssignments()
    elseif attempts < 10 then
      C_Timer.After(0.1, openWhenReady)
    end
  end
  C_Timer.After(0.1, openWhenReady)
end

local function openMarkerMenu(widget, fullName)
  MenuUtil.CreateContextMenu(widget.frame, function(ownerRegion, rootDescription)
    rootDescription:CreateTitle(L["Focus Marker"])

    for i = 1, 8 do
      rootDescription:CreateRadio(markerLabel(i), function(index)
        return widget.markerIndex == index
      end, function(index)
        MDT:FocusMarker_SetAssignment(fullName, index)
        setButtonMarker(widget, index)
        refreshAssignmentsFrame()
      end, i)
    end

    rootDescription:CreateRadio(L["None"], function()
      return widget.markerIndex == nil
    end, function()
      MDT:FocusMarker_SetAssignment(fullName, nil)
      setButtonMarker(widget, nil)
      refreshAssignmentsFrame()
    end)
  end)
end

local function hideAceGUIBuiltInCloseButton(frame)
  for _, child in ipairs({ frame.frame:GetChildren() }) do
    if child.GetText and child:GetText() == CLOSE then
      child:Hide()
      child:Disable()
      child:SetScript("OnClick", nil)
      break
    end
  end
end

local function createAssignmentsFrame()
  local frame = AceGUI:Create("Frame")
  frame.frame:SetParent(MDT.main_frame)
  frame.frame:SetFrameStrata("DIALOG")
  frame:SetTitle(L["Focus Marker Assignments"])
  frame:SetWidth(500)
  frame:SetHeight(260)
  frame:EnableResize(false)
  frame:SetLayout("Flow")
  frame:SetCallback("OnClose", function() end)
  frame.statustext:GetParent():Hide()
  hideAceGUIBuiltInCloseButton(frame)
  frame:Hide()
  MDT:FixAceGUIShowHide(frame, nil, nil, true)
  MDT.main_frame.FocusMarkerAssignmentsFrame = frame
  return frame
end

function MDT:FocusMarker_OpenAssignments()
  assignmentsFrame = assignmentsFrame or createAssignmentsFrame()
  local frame = assignmentsFrame
  local assignments = self:FocusMarker_GetAssignments()
  local settings = getMacroSettings()
  local roster = getGroupRoster()
  pruneAssignmentsToRoster(assignments, roster)

  MDT:HideAllDialogs()
  if frame.macroIcon then
    frame.macroIcon:Hide()
    frame.macroIcon:ClearAllPoints()
    frame.macroIcon:SetParent(frame.frame)
  end
  frame:ReleaseChildren()

  local rowCount = math.max(#roster, 5)
  local rosterRowIndent = 85
  local rosterNameWidth = 150
  local markerButtonWidth = 150

  for index = 1, rowCount do
    local player = roster[index]
    local row = AceGUI:Create("SimpleGroup")
    row:SetLayout("Flow")
    row:SetFullWidth(true)
    row:SetHeight(28)

    local spacer = AceGUI:Create("Label")
    spacer:SetWidth(rosterRowIndent)
    spacer:SetText("")
    row:AddChild(spacer)

    local name = AceGUI:Create("Label")
    name:SetWidth(rosterNameWidth)
    name:SetText(player and player.displayName or L["No player"])
    row:AddChild(name)

    local marker = AceGUI:Create("Button")
    marker:SetWidth(markerButtonWidth)
    if player then
      setButtonMarker(marker, assignments[player.fullName])
      marker:SetCallback("OnClick", function(widget)
        openMarkerMenu(widget, player.fullName)
      end)
    else
      marker:SetText(L["None"])
      marker:SetDisabled(true)
    end
    row:AddChild(marker)

    frame:AddChild(row)
  end

  addCheckbox(frame, L["Announce focus marker on ready check"], settings.announceReadyCheck, function(value)
    settings.announceReadyCheck = value
  end)

  local macroCheckbox = AceGUI:Create("CheckBox")
  macroCheckbox:SetLabel(L["Use macro instead of keybind"])
  macroCheckbox:SetFullWidth(true)
  macroCheckbox:SetValue(settings.useMacro)
  macroCheckbox:SetCallback("OnValueChanged", function(_, _, value)
    settings.useMacro = value
    if frame.macroIcon then
      frame.macroIcon:SetShown(value)
    end
    MDT:FocusMarker_RefreshAction()
  end)
  frame:AddChild(macroCheckbox)

  local function positionMacroIcon()
    frame.macroIcon:ClearAllPoints()
    frame.macroIcon:SetPoint("LEFT", macroCheckbox.text, "LEFT", math.ceil(macroCheckbox.text:GetStringWidth()) + 8, 0)
  end

  if not frame.macroIcon then
    frame.macroIcon = CreateFrame("Button", nil, frame.frame)
    frame.macroIcon:SetSize(36, 36)
    frame.macroIcon.texture = frame.macroIcon:CreateTexture(nil, "ARTWORK")
    frame.macroIcon.texture:SetAllPoints()
    frame.macroIcon:RegisterForClicks("LeftButtonUp")
    frame.macroIcon:RegisterForDrag("LeftButton")
    frame.macroIcon:SetScript("OnClick", function()
      pickupFocusMarkerMacro()
    end)
    frame.macroIcon:SetScript("OnDragStart", pickupFocusMarkerMacro)
    frame.macroIcon:SetScript("OnEnter", function(self)
      local currentSettings = getMacroSettings() or {}
      GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
      GameTooltip:AddLine(currentSettings.macroName or MACRO_NAME, 1, 1, 1)
      GameTooltip:AddLine(L["focusMarkerMacroDragTooltip"], 1, 0.8196, 0, true)
      GameTooltip:Show()
    end)
    frame.macroIcon:SetScript("OnLeave", function()
      GameTooltip:Hide()
    end)
  end
  frame.macroIcon:SetParent(macroCheckbox.frame)
  positionMacroIcon()
  frame.macroIcon.texture:SetTexture(settings.macroIcon or MACRO_ICON)
  frame.macroIcon:SetShown(settings.useMacro)

  addCheckbox(frame, L["Never show MDT focus marker notification."], settings.suppressNotifications, function(value)
    settings.suppressNotifications = value
  end)

  local buttons = AceGUI:Create("SimpleGroup")
  buttons:SetLayout("Flow")
  buttons:SetFullWidth(true)
  buttons:SetHeight(40)
  local footerButtonWidth = 108

  addButton(buttons, L["Auto Assign"], footerButtonWidth, function()
    roster = getGroupRoster()
    pruneAssignmentsToRoster(assignments, roster)
    local playerFullName = getPlayerFullName()
    local previousOwnMarker = assignments[playerFullName]
    applyClassDefaults(roster, assignments)
    local currentOwnMarker = assignments[playerFullName]
    if previousOwnMarker ~= currentOwnMarker then
      MDT:FocusMarker_ApplyMarker(currentOwnMarker or 0)
    end
    MDT:FocusMarker_OpenAssignments()
  end)

  addButton(buttons, L["Sync Marks"], footerButtonWidth, function()
    MDT:FocusMarker_SendAssignments()
  end)

  addButton(buttons, L["Set Keybind"], footerButtonWidth, function()
    openKeybindSettings()
  end)

  addButton(buttons, L["Close"], footerButtonWidth, function()
    frame:Hide()
  end)
  frame:AddChild(buttons)

  frame:SetHeight(190 + (rowCount * 28))
  frame:ClearAllPoints()
  frame:SetPoint("CENTER", MDT.main_frame, "CENTER", 0, 50)
  frame:Show()
  frame:DoLayout()
  positionMacroIcon()
  frame.macroIcon:SetShown(settings.useMacro)
end
