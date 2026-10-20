local _, MDT = ...
local L = MDT.L
local MDTcommsObject = MDT.commsObject
local UI = MDT.UI

local versionCheckPrefix = MDT.versionCheckPrefix
local versionCheckRequest = "R"
local versionCheckResponsePrefix = "V"
local changeLogRequestPrefix = "C"
local changeLogHeaderPrefix = "H"
local changeLogNotePrefix = "N"
local versionCheckCooldown = 300
local currentVersion = C_AddOns.GetAddOnMetadata(MDT.AddonName, "Version")
local latestVersion = currentVersion
local lastVersionRequestAt = -versionCheckCooldown

local downloadLinks = {
  { name = "CurseForge", url = "https://www.curseforge.com/wow/addons/mythic-dungeon-tools" },
  { name = "Wago",       url = "https://addons.wago.io/addons/mythic-dungeon-tools" },
}

local versionTokens = {
  current = "text.normal",
  patch = "warn",
  majorMinor = "live",
}

local changeLog = MDT.changeLog or {}
local incomingChangeLogs = {}
local reportedVersions = {}
local remoteChangeLog
local buildChangeLogText
local buildPlayerVersionsText
local activeTab = "changelog"
---Controls of the open version check dialog; nil while it is closed.
local view

local function getFullName(unit)
  local name, realm = UnitFullName(unit)
  if not name then return nil end
  if not realm or string.len(realm) < 3 then
    local _, playerRealm = UnitFullName("player")
    realm = playerRealm
  end
  if realm and string.len(realm) > 0 then
    return name.."-"..realm
  end
  return name
end

local function forEachPartyMember(callback)
  for i = 1, GetNumSubgroupMembers() do
    callback(getFullName("party"..i))
  end
end

local function sendVersionCheckComm(message)
  MDTcommsObject:SendCommMessage(versionCheckPrefix, message, "PARTY", nil, "ALERT")
end

local function parseVersion(version)
  local parts = {}
  for part in version:gmatch("%d+") do
    parts[#parts + 1] = tonumber(part)
  end
  return parts
end

local function compareVersions(a, b)
  a = parseVersion(a)
  b = parseVersion(b)
  for i = 1, 4 do
    if (a[i] or 0) ~= (b[i] or 0) then
      return (a[i] or 0) > (b[i] or 0)
    end
  end
  return false
end

local function getOutdatedType()
  if not compareVersions(latestVersion, currentVersion) then return nil end

  local currentParts = parseVersion(currentVersion)
  local latestParts = parseVersion(latestVersion)
  if (latestParts[1] or 0) > (currentParts[1] or 0) or (latestParts[2] or 0) > (currentParts[2] or 0) then
    return "majorMinor"
  end

  return "patch"
end

local function recordVersion(version, sender)
  if not version or version == "" then return end
  if sender then
    reportedVersions[sender] = version
  end
  if compareVersions(version, latestVersion) then
    latestVersion = version
  end
  MDT:UpdateVersionCheckDisplay()
  MDT:UpdatePlayerVersionsDisplay()
end

function MDT:RequestVersionCheck(force)
  local now = GetTime()
  if not force and now - lastVersionRequestAt < versionCheckCooldown then
    MDT:UpdateVersionCheckDisplay()
    MDT:UpdatePlayerVersionsDisplay()
    return false
  end

  lastVersionRequestAt = now
  sendVersionCheckComm(versionCheckRequest)
  return true
end

function MDT:UpdateVersionCheckDisplay()
  local outdatedType = getOutdatedType()
  local bottomText = " v"..currentVersion
  if outdatedType then bottomText = bottomText.." "..L["update available"] end

  local versionText = MDT.main_frame and MDT.main_frame.bottomLeftPanelString
  if versionText then
    versionText:SetText(bottomText)
    UI.Theme.Bind(versionText, versionTokens[outdatedType or "current"])
    if versionText.clickArea then
      versionText.clickArea:SetWidth(versionText:GetStringWidth() + 3)
    end
  end

  if view then view.downloads:SetHidden(not (outdatedType and activeTab == "changelog")) end
end

function MDT:UpdateChangeLogDisplay()
  if view and activeTab == "changelog" then view.text:SetText(buildChangeLogText()) end
end

function MDT:UpdatePlayerVersionsDisplay()
  if view and activeTab == "versions" then view.text:SetText(buildPlayerVersionsText()) end
end

function MDT:VersionCheck_OnCommReceived(message, distribution, sender)
  if distribution ~= "PARTY" then return end

  if message == versionCheckRequest then
    lastVersionRequestAt = GetTime()
    sendVersionCheckComm(versionCheckResponsePrefix..currentVersion)
    return
  end

  if message:sub(1, 1) == changeLogRequestPrefix then
    local requestedVersion = message:sub(2)
    local entry = changeLog[1]
    if entry.tag == requestedVersion then
      sendVersionCheckComm(changeLogHeaderPrefix..entry.tag.."\t"..entry.date.."\t"..#entry.notes)
      for i, note in ipairs(entry.notes) do
        sendVersionCheckComm(changeLogNotePrefix..entry.tag.."\t"..i.."\t"..note)
      end
    end
    return
  end

  if message:sub(1, 1) == changeLogHeaderPrefix then
    local version, date, noteCount = message:match("^"..changeLogHeaderPrefix.."([^\t]+)\t([^\t]+)\t(%d+)$")
    incomingChangeLogs[version] = {
      tag = version,
      date = date,
      noteCount = tonumber(noteCount),
      notes = {},
    }
    return
  end

  if message:sub(1, 1) == changeLogNotePrefix then
    local version, noteIndex, note = message:match("^"..changeLogNotePrefix.."([^\t]+)\t(%d+)\t(.+)$")
    local entry = incomingChangeLogs[version]
    entry.notes[tonumber(noteIndex)] = note

    local noteCount = 0
    for _ in pairs(entry.notes) do
      noteCount = noteCount + 1
    end
    if noteCount == entry.noteCount then
      remoteChangeLog = entry
      MDT:UpdateChangeLogDisplay()
    end
    return
  end

  if message:sub(1, 1) == versionCheckResponsePrefix then
    recordVersion(message:sub(2), sender)
  end
end

buildChangeLogText = function()
  local displayChangeLog = {}
  if remoteChangeLog then
    displayChangeLog[#displayChangeLog + 1] = remoteChangeLog
  end
  for _, entry in ipairs(changeLog) do
    if not remoteChangeLog or entry.tag ~= remoteChangeLog.tag then
      displayChangeLog[#displayChangeLog + 1] = entry
    end
  end

  if #displayChangeLog == 0 then
    return L["No changelog entries available."]
  end

  local text = ""
  for _, entry in ipairs(displayChangeLog) do
    text = text.."v"..entry.tag.." ("..entry.date..")\n"
    for _, note in ipairs(entry.notes) do
      text = text.."  - "..note.."\n"
    end
    text = text.."\n"
  end

  return text
end

local function hasMissingPlayerVersionData()
  local missing = false
  forEachPartyMember(function(memberName)
    if memberName and not reportedVersions[memberName] then missing = true end
  end)

  return missing
end

local function requestMissingPlayerVersions()
  if hasMissingPlayerVersionData() then
    MDT:RequestVersionCheck(true)
  end
end

local function reportPlayerVersionsToParty()
  C_ChatInfo.SendChatMessage("MDT Version Check:", "PARTY")
  C_ChatInfo.SendChatMessage(getFullName("player")..": v"..currentVersion, "PARTY")
  forEachPartyMember(function(memberName)
    local version = reportedVersions[memberName]
    if version then
      C_ChatInfo.SendChatMessage(memberName..": v"..version, "PARTY")
    end
  end)
end

buildPlayerVersionsText = function()
  local lines = {
    getFullName("player")..": v"..currentVersion,
  }
  forEachPartyMember(function(memberName)
    local version = reportedVersions[memberName]
    if version then
      lines[#lines + 1] = memberName..": v"..version
    end
  end)

  return table.concat(lines, "\n")
end

local function showTab(tab)
  activeTab = tab
  view.tabs.changelog:SetSelected(tab == "changelog")
  view.tabs.versions:SetSelected(tab == "versions")
  view.report:SetHidden(tab ~= "versions")
  if tab == "versions" then
    requestMissingPlayerVersions()
    MDT:UpdatePlayerVersionsDisplay()
  else
    MDT:UpdateChangeLogDisplay()
  end
  MDT:UpdateVersionCheckDisplay()
end

local function buildVersionCheck(content)
  view = {}
  local tabs = UI.Row(content, { gap = "xs" })
  view.tabs = {
    changelog = UI.Button(tabs, { id = "changelogTab", text = L["Change Log"], variant = "ghost", onClick = function() showTab("changelog") end }),
    versions = UI.Button(tabs, { id = "versionsTab", text = L["Party Versions"], variant = "ghost", onClick = function() showTab("versions") end }),
  }
  local box = UI.Stack(content, { background = "bg.sunken", border = "border.normal", padding = "sm" })
  local scroll = UI.Scroll(box, { height = 180 })
  view.text = UI.Text(scroll.content, { id = "versionText", text = "" })
  view.downloads = UI.Row(content, { gap = "sm", hidden = true })
  local linkWidth = (content:GetWidth() - UI.Theme.Space("lg") * 2 - UI.Theme.Space("sm")) / 2
  for _, link in ipairs(downloadLinks) do
    MDT:AddCopyableLinkRow(view.downloads, { label = link.name, url = link.url, anchor = MDT.main_frame, width = linkWidth })
  end
  view.report = UI.Row(content, { hidden = true })
  UI.Button(view.report, { id = "reportVersions", text = L["Send versions to party chat"], onClick = reportPlayerVersionsToParty })
end

function MDT:ToggleVersionCheckFrame()
  local open = UI.Dialogs.Get("versionCheck")
  if open then
    open:Close("api")
    return
  end
  MDT:HideAllDialogs()
  if getOutdatedType() and (not remoteChangeLog or remoteChangeLog.tag ~= latestVersion) then
    sendVersionCheckComm(changeLogRequestPrefix..latestVersion)
  end
  UI.Dialogs.Open({
    key = "versionCheck", title = L["Version Check / Change Log"], width = 500,
    place = { point = "BOTTOMLEFT", relativeTo = MDT.main_frame },
    onClose = function()
      view = nil
      MDT.copyHelper:SmartHide()
    end,
    build = buildVersionCheck,
  })
  showTab(activeTab)
end
