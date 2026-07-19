local AddonName, MDT = ...
local L = MDT.L

local defaultSavedVars = {
  global = {
    toolbarExpanded = true,
    currentSeason = 11, -- not really used for anything anymore
    scale = 1,
    nonFullscreenScale = 1.4,
    enemyForcesFormat = 2,
    useForcesCount = false, -- replaces percent in pull buttons with count
    showPullButtonHealth = false,
    autoPanToPull = true,
    enemyForcesTooltip = 1,
    muteXalatathVoiceLines = false,
    announceDungeonReset = false,
    enemyStyle = 1,
    currentDifficulty = 10,
    xoffset = -80,
    yoffset = -100,
    defaultColor = "228b22",
    anchorFrom = "TOP",
    anchorTo = "TOP",
    tooltipInCorner = false,
    minimap = {
      hide = false,
      compartmentHide = false,
    },
    toolbar = {
      color = { r = 1, g = 1, b = 1, a = 1 },
      brushSize = 3,
    },
    presets = {},
    currentPreset = {},
    alwaysOverwriteRoutesByUID = false,
    fadeOutDuringCombat = false,
    fadeOutAlpha = 0.5,
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
    colorPaletteInfo = {
      autoColoring = true,
      forceColorBlindMode = false,
      colorPaletteIdx = 4,
      customPaletteValues = {},
      numberCustomColors = 12,
    },
    currentDungeonIdx = MDT:IsMop() and 130 or 160, -- set this one every new season
    currentSection = "maps",
    latestDungeonSeen = 0,
    selectedDungeonList = 1,
    prePatchWarningSeenFor = 0,
  },
}

for i = 1, 200 do
  defaultSavedVars.global.presets[i] = {
    [1] = {
      text = L["Default"],
      value = {},
      objects = {},
      colorPaletteInfo = { autoColoring = true, colorPaletteIdx = 4 }
    },
    [2] = { text = L["<New Preset>"], value = 0 },
  }
  defaultSavedVars.global.currentPreset[i] = 1
end

local db

function MDT:GetDefaultSavedVariables()
  return defaultSavedVars
end

function MDT:InitializeSavedVariables()
  db = LibStub("AceDB-3.0"):New("MythicDungeonToolsDB", defaultSavedVars).global
  if not db then return end

  for dungeonIdx, presetIdx in pairs(db.currentPreset) do
    if presetIdx <= 0 then db.currentPreset[dungeonIdx] = 1 end
  end

  return db
end

function MDT:GetDB()
  return db
end

--/run MDT:ResetDataCache();
function MDT:ResetDataCache()
  db.dungeonEnemies = nil
  db.mapPOIs = nil
  ReloadUI()
end

function MDT:HardReset()
  MythicDungeonToolsDB = nil
  ReloadUI()
end
