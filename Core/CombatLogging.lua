local _, MDT = ...
local L = MDT.L

local contentTypes = {
  LFR = "lfr",
  NORMAL = "normal",
  HEROIC = "heroic",
  MYTHIC = "mythic",
  MYTHIC_DUNGEON = "mythic_dungeon",
  MYTHIC_PLUS = "mythic_plus",
}

local raidDifficultyToContent = {
  [3] = contentTypes.NORMAL,
  [4] = contentTypes.NORMAL,
  [5] = contentTypes.HEROIC,
  [6] = contentTypes.HEROIC,
  [7] = contentTypes.LFR,
  [9] = contentTypes.NORMAL,
  [14] = contentTypes.NORMAL,
  [15] = contentTypes.HEROIC,
  [16] = contentTypes.MYTHIC,
  [17] = contentTypes.LFR,
  [233] = contentTypes.MYTHIC,
}

local partyDifficultyToContent = {
  [8] = contentTypes.MYTHIC_PLUS,
  [23] = contentTypes.MYTHIC_DUNGEON,
}

local eventFrame = CreateFrame("Frame")
local hasSyncedState
local lastCombatLoggingState

local function getSettings()
  return MDT:GetDB().combatLogging
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
  C_Timer.After(1, function() MDT:CombatLogging_EvaluateInstanceLogging() end)
  C_Timer.After(15, function() MDT:CombatLogging_EvaluateInstanceLogging() end)
end

function MDT:CombatLogging_GetCurrentCombatLoggingState()
  return LoggingCombat() and true or false
end

function MDT:CombatLogging_SetCombatLoggingState(shouldLog, forceSync)
  local wasLogging = self:CombatLogging_GetCurrentCombatLoggingState()
  if lastCombatLoggingState == nil then lastCombatLoggingState = wasLogging end

  local stateChanged = lastCombatLoggingState ~= shouldLog
  if forceSync or wasLogging ~= shouldLog then LoggingCombat(shouldLog) end

  lastCombatLoggingState = shouldLog
  if stateChanged then
    print("|cffffd100MDT:|r "..(shouldLog and L["combatLoggingStarted"] or L["combatLoggingStopped"]))
  end
end

function MDT:CombatLogging_GetCurrentInstanceContentType()
  local _, instanceType, difficultyID = GetInstanceInfo()
  if instanceType == "raid" then return raidDifficultyToContent[difficultyID] end
  if instanceType == "party" then return partyDifficultyToContent[difficultyID] end
end

function MDT:CombatLogging_IsContentEnabled(contentType)
  return getSettings().content[contentType]
end

function MDT:CombatLogging_SetContentEnabled(contentType, enabled)
  local settings = getSettings()
  settings.content[contentType] = enabled
  if settings.enabled then self:CombatLogging_EvaluateInstanceLogging() end
end

function MDT:CombatLogging_ShouldLogInstance()
  local contentType = self:CombatLogging_GetCurrentInstanceContentType()
  return contentType and self:CombatLogging_IsContentEnabled(contentType) or false
end

function MDT:CombatLogging_EvaluateInstanceLogging(forceDisable)
  local settings = getSettings()
  local shouldLog = not forceDisable and settings.enabled and self:CombatLogging_ShouldLogInstance() or false

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
    SetCVar("advancedCombatLogging", "1")
    registerLoggingEvents()
    self:CombatLogging_EvaluateInstanceLogging()
    delayedEvaluate()
  else
    local wasEnabled = settings.enabled
    settings.enabled = false
    unregisterLoggingEvents()
    if wasEnabled then self:CombatLogging_EvaluateInstanceLogging(true) end
  end
end

eventFrame:SetScript("OnEvent", function()
  MDT:CombatLogging_EvaluateInstanceLogging()
end)

if getSettings().enabled then MDT:CombatLogging_SetEnabled(true) end

MDT:ExportAPI("CombatLogging_SetEnabled")
MDT:ExportAPI("CombatLogging_SetContentEnabled")
