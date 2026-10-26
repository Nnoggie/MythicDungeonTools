local _, MDT = ...
local L = MDT.L

local defaultSavedVars = {
  global = {
    toolbarExpanded = true,
    scale = 1,
    nonFullscreenScale = 1.4,
    uiScale = 1,
    useForcesCount = false, -- replaces percent in pull buttons with count
    showPullButtonHealth = false,
    autoPanToPull = true,
    devPullLabelSize = 1, -- the pull labels' size on the map in dev mode, from the slider in its top right
    enemyForcesTooltip = 1,
    muteXalatathVoiceLines = false,
    announceDungeonReset = false,
    currentDifficulty = 10,
    xoffset = -80,
    yoffset = -100,
    anchorFrom = "TOP",
    anchorTo = "TOP",
    windowPartlyOffScreen = false, -- the user dropped the window partly off screen, so refits leave it there
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
      disableMouseoverFocus = false,
      onlyFocusEnemies = true,
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
    currentDungeonIdx = 160, -- set this one every new season
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

local anchorPoints = {
  TOPLEFT = true, TOP = true, TOPRIGHT = true, LEFT = true, CENTER = true, RIGHT = true,
  BOTTOMLEFT = true, BOTTOM = true, BOTTOMRIGHT = true,
}

local minNonFullscreenScale = 0.9

local function isFiniteNumber(value)
  return type(value) == "number" and value == value and value ~= math.huge and value ~= -math.huge
end

---Puts back the default for any saved MDT scale or window geometry the window could not be shown with.
local function validateWindowSettings()
  local defaults = defaultSavedVars.global
  if not (isFiniteNumber(db.uiScale) and db.uiScale > 0) then db.uiScale = defaults.uiScale end
  if not isFiniteNumber(db.nonFullscreenScale) then
    db.nonFullscreenScale = defaults.nonFullscreenScale
  elseif db.nonFullscreenScale < minNonFullscreenScale then
    db.nonFullscreenScale = minNonFullscreenScale
  end
  -- Offsets only mean something together with the anchors they were saved with.
  if not (anchorPoints[db.anchorFrom] and anchorPoints[db.anchorTo]) then
    db.anchorFrom, db.anchorTo = defaults.anchorFrom, defaults.anchorTo
    db.xoffset, db.yoffset = defaults.xoffset, defaults.yoffset
  end
  for _, key in ipairs({ "xoffset", "yoffset" }) do
    if not isFiniteNumber(db[key]) then db[key] = defaults[key] end
  end
end

---The smallest scale the normal window can be resized to.
function MDT:GetMinNonFullscreenScale()
  return minNonFullscreenScale
end

function MDT:GetDefaultSavedVariables()
  return defaultSavedVars
end

function MDT:InitializeSavedVariables()
  if db then return db end
  db = LibStub("AceDB-3.0"):New("MythicDungeonToolsDB", defaultSavedVars).global
  if not db then return end

  for dungeonIdx, presetIdx in pairs(db.currentPreset) do
    if presetIdx <= 0 then db.currentPreset[dungeonIdx] = 1 end
  end
  validateWindowSettings()

  return db
end

function MDT:GetDB()
  return db
end

--/run MDT:ResetDataCache();
function MDT:ResetDataCache()
  db.devModeCache = nil
  db.dungeonEnemies = nil
  db.mapPOIs = nil
  db.devModeCacheBaseline = nil
  ReloadUI()
end

function MDT:HardReset()
  MythicDungeonToolsDB = nil
  ReloadUI()
end

MDT:InitializeSavedVariables()
