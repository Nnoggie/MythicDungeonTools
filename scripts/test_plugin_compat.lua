local root = arg[1] or "."

local function read(path)
  local file = assert(io.open(root.."/"..path, "rb"))
  local contents = file:read("*a")
  file:close()
  return contents
end

function CopyTable(source)
  local copy = {}
  for key, value in pairs(source) do copy[key] = type(value) == "table" and CopyTable(value) or value end
  return copy
end

function wipe(target)
  for key in pairs(target) do target[key] = nil end
end

local errors = {}
function geterrorhandler()
  return function(message) errors[#errors + 1] = message end
end

MythicDungeonToolsDB = {}
local loadCalls = 0
C_AddOns = {
  GetAddOnMetadata = function() return "6.2.0" end,
  LoadAddOn = function()
    loadCalls = loadCalls + 1
    return true
  end,
}
function GetBuildInfo() return "12.1.0", "", "", 120100 end
function UnitFactionGroup() return "Alliance", "Alliance" end

assert(loadfile(root.."/BuildCheck.lua"))("MythicDungeonTools", {})
local coreSource = read("Core/Bootstrap.lua")
local corePrefix = assert(coreSource:match("^([%s%S]-)\nlocal function isUILoaded%(%).*"))
assert(loadstring(corePrefix, "@Core/Bootstrap.lua"))("MythicDungeonTools", _G.MDT)

local API = assert(_G.MythicDungeonToolsAPI)
assert(type(API.GetDB) == "function")
assert(type(API.RegisterUIInitializer) == "function")

local function loadLegacy(legacyRoot)
  local addon = {}
  for _, fileName in ipairs({ "locale.lua", "versionCheck.lua", "buildCheck.lua", "core.lua" }) do
    assert(loadfile(legacyRoot.."/"..fileName))("MDT_Legacy", addon)
  end
  for _, directory in ipairs({ "Legion", "BattleForAzeroth", "Shadowlands", "Dragonflight", "TheWarWithin", "MistsOfPandaria" }) do
    local xml = assert(io.open(legacyRoot.."/"..directory.."/load_"..({
      Legion = "legion",
      BattleForAzeroth = "bfa",
      Shadowlands = "shadowlands",
      Dragonflight = "dragonflight",
      TheWarWithin = "thewarwithin",
      MistsOfPandaria = "mop",
    })[directory]..".xml", "rb"))
    local contents = xml:read("*a")
    xml:close()
    for fileName in contents:gmatch("<Script file='([^']+)'/>") do
      assert(loadfile(legacyRoot.."/"..directory.."/"..fileName))("MDT_Legacy", addon)
    end
  end
  assert(loadfile(legacyRoot.."/register.lua"))("MDT_Legacy", addon)
  return addon
end

local interruptInitialized = false
local legacyInitialized = false
local db = API:GetDB()
db.interruptTracker = { enabled = true }

local legacyData = {}
for _, fieldName in ipairs({
  "dungeonEnemies",
  "dungeonList",
  "dungeonMaps",
  "dungeonSubLevels",
  "dungeonTotalCount",
  "mapInfo",
  "mapPOIs",
  "scaleMultiplier",
  "zoneIdToDungeonIdx",
}) do legacyData[fieldName] = {} end
legacyData.dungeonList[900] = "Legacy Dungeon"
legacyData.mapInfo[900] = { shortName = "legacyShort" }
legacyData.dungeonSubLevels[900] = { "Legacy Floor" }
legacyData.dungeonEnemies[900] = {}
legacyData.dungeonMaps[900] = {}
legacyData.dungeonTotalCount[900] = { normal = 1 }
legacyData.mapPOIs[900] = {}
legacyData.scaleMultiplier[900] = 1
legacyData.zoneIdToDungeonIdx[999] = 900

API:RegisterUIInitializer(function(UI)
  interruptInitialized = true
  UI:RegisterNavigationSection({ key = "interrupts" })
end)
API:RegisterUIInitializer(function(UI)
  legacyInitialized = true
  UI:RegisterDungeonData(legacyData, { { name = "Legacy Season", dungeons = { 900 } } })
end)

local actualLegacy = arg[2] and loadLegacy(arg[2])

assert(db.interruptTracker.enabled)
assert(not interruptInitialized and not legacyInitialized)
if actualLegacy then assert(actualLegacy.Data.dungeonList[2] == "Cathedral of Eternal Night") end
assert(loadCalls == 0, "plugin registration loaded the UI")

local ui = {
  L = setmetatable({
    ["Legacy Dungeon"] = "Localized Dungeon",
    legacyShort = "Localized Short",
    ["Legacy Floor"] = "Localized Floor",
    ["Legacy Season"] = "Localized Season",
  }, { __index = function(_, key) return key end }),
  dungeonEnemies = {},
  dungeonList = {},
  dungeonMaps = {},
  dungeonSubLevels = {},
  dungeonTotalCount = {},
  mapInfo = {},
  mapPOIs = {},
  scaleMultiplier = {},
  zoneIdToDungeonIdx = {},
  seasonList = {},
  dungeonSelectionToIndex = {},
  main_frame = { sectionContentFrames = { interrupts = {} } },
  navigationSections = {},
}
function ui:RegisterNavigationSection(section) self.navigationSections[section.key] = section end
function ui:GetCurrentSection() return "interrupts" end
function ui:SetCurrentSection() end
function ui:HideAllDialogs() end
function ui:ToggleToolbarTooltip() end

local uiSource = read("MythicDungeonTools_UI/Bootstrap.lua")
local pluginBody = assert(uiSource:match("local pluginAPI = %{%}([%s%S]-)\nfunction MDT:AttachCoreAPI"))
local pluginChunk = assert(loadstring("local pluginAPI = {}"..pluginBody.."\nreturn pluginAPI", "@MythicDungeonTools_UI/Bootstrap.lua"))
setfenv(pluginChunk, setmetatable({ MDT = ui }, { __index = _G }))
local pluginAPI = pluginChunk()

local function noop() end
API:AttachUI({
  ShowInterface = noop,
  HandleSlashCommand = noop,
  HandleChatLink = noop,
  OnCommReceived = noop,
  GetEnemyForces = noop,
  GetDungeonName = noop,
  GetDungeonSublevels = noop,
}, pluginAPI)

assert(interruptInitialized and legacyInitialized)
assert(ui.navigationSections.interrupts)
assert(ui.dungeonList[900] == "Localized Dungeon")
assert(ui.mapInfo[900].shortName == "Localized Short")
assert(ui.dungeonSubLevels[900][1] == "Localized Floor")
assert(ui.seasonList[1] == "Localized Season")
assert(ui.dungeonSelectionToIndex[1][1] == 900)
if actualLegacy then
  assert(ui.dungeonList[2] == "Cathedral of Eternal Night")
  assert(ui.seasonList[2] == "The War Within Season 3")
  assert(ui.seasonList[#ui.seasonList] == "Mists of Pandaria")
end
assert(pluginAPI:GetNavigationSectionContentFrame("interrupts") == ui.main_frame.sectionContentFrames.interrupts)
assert(loadCalls == 0, "UI attach path called LoadAddOn")
assert(#errors == 0, errors[1])

print("plugin compatibility mock passed")
