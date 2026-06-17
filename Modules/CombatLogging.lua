local AddonName, MDT = ...
local L = MDT.L
local AceGUI = LibStub("AceGUI-3.0")

local ContentTypes = {
  LFR = "lfr",
  NORMAL = "normal",
  HEROIC = "heroic",
  MYTHIC = "mythic",
  MYTHIC_DUNGEON = "mythic_dungeon",
  MYTHIC_PLUS = "mythic_plus",
}

local RAID_DIFFICULTY_IDS_BY_CONTENT = {
  [ContentTypes.LFR] = {
    [7] = true,
    [17] = true,
  },
  [ContentTypes.NORMAL] = {
    [3] = true,
    [4] = true,
    [9] = true,
    [14] = true,
  },
  [ContentTypes.HEROIC] = {
    [5] = true,
    [6] = true,
    [15] = true,
  },
  [ContentTypes.MYTHIC] = {
    [16] = true,
    [233] = true, --Mythic - Flexible Raiding
  },
}

local RAID_DIFFICULTY_TO_CONTENT = {}
for contentType, difficultyIDs in pairs(RAID_DIFFICULTY_IDS_BY_CONTENT) do
  for difficultyID in pairs(difficultyIDs) do
    RAID_DIFFICULTY_TO_CONTENT[difficultyID] = contentType
  end
end

local PARTY_DIFFICULTY_IDS_BY_CONTENT = {
  [ContentTypes.MYTHIC_PLUS] = {
    [8] = true,
  },
  [ContentTypes.MYTHIC_DUNGEON] = {
    [23] = true,
  },
}

local PARTY_DIFFICULTY_TO_CONTENT = {}
for contentType, difficultyIDs in pairs(PARTY_DIFFICULTY_IDS_BY_CONTENT) do
  for difficultyID in pairs(difficultyIDs) do
    PARTY_DIFFICULTY_TO_CONTENT[difficultyID] = contentType
  end
end

local ADVANCED_COMBAT_LOGGING_CVAR = "advancedCombatLogging"
local combatLoggingFrame
local eventFrame = CreateFrame("Frame")
local hasSyncedState = false
local lastCombatLoggingState

local function notify(message)
  print("|cffffd100MDT:|r "..message)
end

local function getSettings()
  return MDT:GetDB().combatLogging
end

local function ensureAdvancedCombatLoggingCVar()
  SetCVar(ADVANCED_COMBAT_LOGGING_CVAR, "1")
end

local function registerLoggingEvents()
  eventFrame:RegisterEvent("UPDATE_INSTANCE_INFO")
  eventFrame:RegisterEvent("PLAYER_DIFFICULTY_CHANGED")
  eventFrame:RegisterEvent("ZONE_CHANGED_NEW_AREA")
  eventFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
end

local function unregisterLoggingEvents()
  eventFrame:UnregisterEvent("UPDATE_INSTANCE_INFO")
  eventFrame:UnregisterEvent("PLAYER_DIFFICULTY_CHANGED")
  eventFrame:UnregisterEvent("ZONE_CHANGED_NEW_AREA")
  eventFrame:UnregisterEvent("PLAYER_ENTERING_WORLD")
end

local function delayedEvaluate()
  C_Timer.After(1, function()
    MDT:CombatLogging_EvaluateInstanceLogging()
  end)
  C_Timer.After(15, function()
    MDT:CombatLogging_EvaluateInstanceLogging()
  end)
end

function MDT:CombatLogging_GetCurrentCombatLoggingState()
  return LoggingCombat() and true or false
end

function MDT:CombatLogging_SetCombatLoggingState(shouldLog, forceSync)
  local wasLogging = self:CombatLogging_GetCurrentCombatLoggingState()
  if lastCombatLoggingState == nil then
    lastCombatLoggingState = wasLogging
  end

  local stateChanged = lastCombatLoggingState ~= shouldLog
  if forceSync or wasLogging ~= shouldLog then
    LoggingCombat(shouldLog)
  end

  lastCombatLoggingState = shouldLog
  if stateChanged then
    notify(shouldLog and L["combatLoggingStarted"] or L["combatLoggingStopped"])
  end
end

function MDT:CombatLogging_GetCurrentInstanceContentType()
  local _, instanceType, difficultyID = GetInstanceInfo()

  if instanceType == "raid" then
    return RAID_DIFFICULTY_TO_CONTENT[difficultyID]
  end

  if instanceType == "party" then
    return PARTY_DIFFICULTY_TO_CONTENT[difficultyID]
  end
end

function MDT:CombatLogging_IsContentEnabled(contentType)
  return getSettings().content[contentType]
end

function MDT:CombatLogging_SetContentEnabled(contentType, enabled)
  local settings = getSettings()
  settings.content[contentType] = enabled
  if settings.enabled then
    self:CombatLogging_EvaluateInstanceLogging()
  end
end

function MDT:CombatLogging_ShouldLogInstance()
  local contentType = self:CombatLogging_GetCurrentInstanceContentType()
  if not contentType then return false end
  return self:CombatLogging_IsContentEnabled(contentType)
end

function MDT:CombatLogging_EvaluateInstanceLogging(forceDisable)
  local settings = getSettings()

  local shouldLog = false
  if not forceDisable and settings.enabled then
    shouldLog = self:CombatLogging_ShouldLogInstance()
  end

  if not hasSyncedState then
    self:CombatLogging_SetCombatLoggingState(shouldLog, true)
    hasSyncedState = true
    return
  end

  self:CombatLogging_SetCombatLoggingState(shouldLog)
end

function MDT:CombatLogging_SetEnabled(enabled)
  local settings = getSettings()

  if enabled then
    settings.enabled = true
    hasSyncedState = false
    ensureAdvancedCombatLoggingCVar()
    registerLoggingEvents()
    self:CombatLogging_EvaluateInstanceLogging()
    delayedEvaluate()
  else
    local wasEnabled = settings.enabled
    settings.enabled = false
    unregisterLoggingEvents()
    if wasEnabled then
      self:CombatLogging_EvaluateInstanceLogging(true)
    end
  end
end

local function initializeCombatLogging()
  local settings = getSettings()
  if settings.enabled then
    MDT:CombatLogging_SetEnabled(true)
  end
end

local function setDifficultyCheckboxesDisabled(checkboxes, disabled)
  for _, checkbox in ipairs(checkboxes) do
    checkbox:SetDisabled(disabled)
  end
end

local function addCheckbox(parent, label, value, relativeWidth, onChanged)
  local checkbox = AceGUI:Create("CheckBox")
  checkbox:SetLabel(label)
  checkbox:SetRelativeWidth(relativeWidth)
  checkbox:SetValue(value)
  checkbox:SetCallback("OnValueChanged", function(_, _, newValue)
    onChanged(newValue)
  end)
  parent:AddChild(checkbox)
  return checkbox
end

local function createCombatLoggingFrame()
  local mainFrame = MDT.main_frame
  local contentParent = mainFrame.sectionContentFrames.combatLogging

  local frame = AceGUI:Create("SimpleGroup")
  frame.frame:SetParent(contentParent)
  frame.frame:SetFrameStrata("HIGH")
  frame.frame:SetFrameLevel(3)
  frame:SetWidth(555)
  frame:SetHeight(320)
  frame:SetLayout("Flow")
  frame.frame:ClearAllPoints()
  frame.frame:SetPoint("TOP", contentParent, "TOP", 0, -20)
  MDT:RegisterMainFrameDragHandle(frame.frame, mainFrame)

  frame.frame:Hide()
  MDT.main_frame.CombatLoggingFrame = frame
  return frame
end

function MDT:CombatLogging_Open()
  if self:GetCurrentSection() ~= "combatLogging" then
    self:SetCurrentSection("combatLogging")
    return
  end

  combatLoggingFrame = combatLoggingFrame or createCombatLoggingFrame()
  local frame = combatLoggingFrame
  local settings = getSettings()

  MDT:HideAllDialogs()
  frame:ReleaseChildren()

  local difficultyCheckboxes = {}

  local heading = AceGUI:Create("Heading")
  heading:SetText(L["Combat Logging"])
  heading:SetFullWidth(true)
  frame:AddChild(heading)

  local overview = AceGUI:Create("Label")
  overview:SetText(L["combatLoggingOverview"])
  overview:SetFullWidth(true)
  overview:SetColor(0.82, 0.82, 0.82)
  frame:AddChild(overview)

  local enabledCheckbox = addCheckbox(frame, L["combatLoggingEnable"], settings.enabled, 1, function(value)
    self:CombatLogging_SetEnabled(value)
    setDifficultyCheckboxesDisabled(difficultyCheckboxes, not value)
  end)
  enabledCheckbox:SetFullWidth(true)

  local raidRow = AceGUI:Create("SimpleGroup")
  raidRow:SetLayout("Flow")
  raidRow:SetFullWidth(true)
  raidRow:SetHeight(28)
  frame:AddChild(raidRow)

  table.insert(difficultyCheckboxes, addCheckbox(raidRow, L["combatLoggingLFR"], settings.content.lfr, 0.25, function(value)
    self:CombatLogging_SetContentEnabled(ContentTypes.LFR, value)
  end))
  table.insert(difficultyCheckboxes, addCheckbox(raidRow, L["combatLoggingNormal"], settings.content.normal, 0.25, function(value)
    self:CombatLogging_SetContentEnabled(ContentTypes.NORMAL, value)
  end))
  table.insert(difficultyCheckboxes, addCheckbox(raidRow, L["combatLoggingHeroic"], settings.content.heroic, 0.25, function(value)
    self:CombatLogging_SetContentEnabled(ContentTypes.HEROIC, value)
  end))
  table.insert(difficultyCheckboxes, addCheckbox(raidRow, L["combatLoggingMythic"], settings.content.mythic, 0.25, function(value)
    self:CombatLogging_SetContentEnabled(ContentTypes.MYTHIC, value)
  end))

  local dungeonRow = AceGUI:Create("SimpleGroup")
  dungeonRow:SetLayout("Flow")
  dungeonRow:SetFullWidth(true)
  dungeonRow:SetHeight(28)
  frame:AddChild(dungeonRow)

  table.insert(difficultyCheckboxes, addCheckbox(dungeonRow, L["combatLoggingMythicDungeon"], settings.content.mythic_dungeon, 0.5, function(value)
    self:CombatLogging_SetContentEnabled(ContentTypes.MYTHIC_DUNGEON, value)
  end))
  table.insert(difficultyCheckboxes, addCheckbox(dungeonRow, L["combatLoggingMythicPlus"], settings.content.mythic_plus, 0.5, function(value)
    self:CombatLogging_SetContentEnabled(ContentTypes.MYTHIC_PLUS, value)
  end))

  local advancedNote = AceGUI:Create("Label")
  advancedNote:SetText(L["combatLoggingAdvancedNote"])
  advancedNote:SetFullWidth(true)
  advancedNote:SetColor(0.82, 0.82, 0.82)
  frame:AddChild(advancedNote)

  setDifficultyCheckboxesDisabled(difficultyCheckboxes, settings.enabled ~= true)
  frame.frame:Show()
  frame:DoLayout()
end

MDT:RegisterNavigationSection({
  key = "combatLogging",
  name = L["Combat Logging"],
  tooltip = L["Combat Logging"],
  texCoords = { 0.75, 1, 0, 0.25 },
  onShow = function()
    MDT:CombatLogging_Open()
  end,
})

eventFrame:RegisterEvent("ADDON_LOADED")
eventFrame:SetScript("OnEvent", function(_, event, ...)
  if event == "ADDON_LOADED" then
    local loadedAddonName = ...
    if loadedAddonName == AddonName then
      eventFrame:UnregisterEvent("ADDON_LOADED")
      initializeCombatLogging()
    end
    return
  end
  MDT:CombatLogging_EvaluateInstanceLogging()
end)
