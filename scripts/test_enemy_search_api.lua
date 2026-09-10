local root = arg[1] or "."
local function read(path)
  local file = assert(io.open(root.."/"..path, "rb"))
  local text = file:read("*a"); file:close(); return text
end
local function load(path, addon, namespace)
  return assert(loadfile(root.."/"..path))(addon, namespace)
end
function CopyTable(source)
  local result = {}
  for key, value in pairs(source) do result[key] = type(value) == "table" and CopyTable(value) or value end
  return result
end
function wipe(target) for key in pairs(target) do target[key] = nil end end
local secret, combat, restricted = {}, false, false
function issecretvalue(value) return rawequal(value, secret) end
function InCombatLockdown() return combat end
function GetBuildInfo() return "12.1.0", "", "", 120100 end
function geterrorhandler() return function(err) error(err) end end
function LibStub() return { RegisterLayout = function() end } end
function CreateFrame() error("Search must not create UI") end
StaticPopupDialogs, MythicDungeonToolsDB = {}, {}
local loaded, loadCalls, failLoad = false, 0, false
local core, ui = {}, {}
local jobs, initializers, opened = {}, {}, {}
local ready, showCalls, conflicts, mapComplete = false, 0, false, true
local function async(_, fn, key, singleton)
  if singleton then jobs[key] = nil end
  assert(not jobs[key], "unexpected duplicate job")
  jobs[key] = coroutine.create(fn)
end
local function drain()
  local iterations = 0
  while next(jobs) do
    iterations = iterations + 1; assert(iterations < 100, "unbounded work")
    for key, job in pairs(jobs) do
      local ok, err = coroutine.resume(job); assert(ok, err)
      if coroutine.status(job) == "dead" then jobs[key] = nil end
    end
  end
end
local function initialize()
  ready = true
  local callbacks = initializers; initializers = {}
  for _, callback in ipairs(callbacks) do callback() end
end
C_AddOns = {
  IsAddOnLoaded = function() return loaded, loaded end,
  LoadAddOn = function()
    loadCalls = loadCalls + 1
    if failLoad then return false, "MISSING" end
    load("MythicDungeonTools_UI/Bootstrap.lua", "MythicDungeonTools_UI", ui)
    ui.dungeonEnemies = {
      [2] = {
        [1] = { id = 20, name = "Guardian", isBoss = true, clones = { {} }, spells = { [100] = {}, [277564] = {}, [50] = {} } },
        [3] = { id = 21, name = "Caster", clones = { [4] = {} }, spells = { [100] = {} } },
        [4] = { id = 22, name = "No clones", clones = {} },
      },
      [4] = {},
      [9] = { { id = 20, name = "Guardian", clones = { {} } } },
    }
    ui.dungeonList = { [2] = "Dungeon A", [9] = "Dungeon B" }
    ui.L.Guardian = "守卫"
    function ui:GetDungeonName(index) return self.dungeonList[index] end
    function ui:IsInRestrictedEnvironment() return restricted end
    function ui:CheckAddonConflicts() return conflicts end
    function ui:AreFramesInitialized() return ready end
    function ui:RunAfterFramesInitialized(callback) initializers[#initializers + 1] = callback end
    function ui:ShowInterface(force) assert(force == true); showCalls = showCalls + 1 end
    function ui:ShowInterfaceInternal(force) assert(ready and force == true); self.shown = true end
    function ui:SetCurrentSection(section) assert(section == "maps") end
    function ui:SetDungeonList(_, dungeon) self.selectedDungeon = dungeon end
    function ui:UpdateToDungeon(dungeon) self.currentDungeon = dungeon; mapComplete = true end
    function ui:UpdateDungeonDropDown() assert(mapComplete) end
    ui.Async = async
    function ui:CancelAsync(name) jobs[name] = nil end
    load("Modules/EnemyInfo.lua", "MythicDungeonTools_UI", ui)
    function ui:ShowEnemyInfoFrame(blip)
      local enemy = self.dungeonEnemies[self.currentDungeon][blip.enemyIdx]
      assert(enemy and enemy.clones[blip.cloneIdx])
      opened[#opened + 1] = { dungeon = self.currentDungeon, npcID = enemy.id }
      self.EnemyInfoFrame = { frame = { IsShown = function() return true end } }
    end
    load("Modules/EnemySearchAPI.lua", "MythicDungeonTools_UI", ui)
    ui:AttachCoreAPI()
    loaded = true
    return true
  end,
}
load("BuildCheck.lua", "MythicDungeonTools", core)
-- Load the actual loader/API definitions, excluding unrelated minimap/comms setup.
local source = read("Core/Bootstrap.lua")
local prefix = assert(source:match("^([%s%S]-)\nMDT:ExportAPI%(\"ShowInterface\"%)"))
assert(loadstring(prefix, "@Core/Bootstrap.lua"))("MythicDungeonTools", core)
local API = MythicDungeonToolsAPI
function API:GetPresetCommPrefix() return "MDTPreset" end
function API:GetVersionCheckPrefix() return "MDTVersion" end
function API:GetLiveSessionPrefixes() return {} end
assert(_G.MDT == nil and loadCalls == 0)
for _, value in ipairs({ secret, "2", 0, -1, 1.5, math.huge, 0/0 }) do
  local result, reason = API:IterateEnemies(value)
  assert(not result and reason == "INVALID_ARGUMENT")
end
combat = true
local iterator, reason = API:IterateEnemies()
assert(not iterator and reason == "COMBAT" and loadCalls == 0)
combat = false
iterator = assert(API:IterateEnemies())
assert(loadCalls == 1 and showCalls == 0 and not ready)
local a, b, c = iterator(), iterator(), iterator()
assert(a.dungeonIndex == 2 and a.npcID == 20 and a.name == "守卫" and a.englishName == "Guardian" and a.isBoss)
assert(#a.spellIDs == 2 and a.spellIDs[1] == 50 and a.spellIDs[2] == 100)
assert(b.npcID == 21 and c.dungeonIndex == 9 and iterator() == nil)
a.name = "changed"; a.spellIDs[1] = 999
assert(ui.dungeonEnemies[2][1].name == "Guardian" and ui.dungeonEnemies[2][1].spells[50])
assert(a.clones == nil and a.spells == nil)
local only = assert(API:IterateEnemies(9)); assert(only().dungeonIndex == 9 and not only())
local empty = assert(API:IterateEnemies(999)); assert(not empty())
ui:GetDB().devMode = true
assert(#assert(API:IterateEnemies(2))().spellIDs == 3)
ui:GetDB().devMode = false
ui.dungeonEnemies[10] = { { id = 30, name = "New", clones = { {} } } }
assert(assert(API:IterateEnemies(10))().npcID == 30)
local results = {}
local function result(label) return function(ok, why) results[#results + 1] = { label, ok, why } end end
assert(API:OpenEnemyInfo(2, 20, result("first")))
assert(API:OpenEnemyInfo(2, 21, result("second")))
assert(showCalls == 1 and #initializers == 1 and #results == 1 and results[1][3] == "SUPERSEDED")
initialize(); drain()
assert(#opened == 1 and opened[1].npcID == 21 and results[2][2])
-- Re-resolve by NPC ID, not the old array position.
assert(API:OpenEnemyInfo(2, 20, result("reordered")))
ui.dungeonEnemies[2][1], ui.dungeonEnemies[2][3] = ui.dungeonEnemies[2][3], ui.dungeonEnemies[2][1]
drain(); assert(opened[2].npcID == 20)
assert(API:OpenEnemyInfo(9, 20, result("removed")))
ui.dungeonEnemies[9] = nil
drain(); assert(results[#results][3] == "NOT_FOUND")
assert(API:OpenEnemyInfo(2, 20, result("combat")))
combat = true; drain(); assert(results[#results][3] == "COMBAT")
local ok; ok, reason = API:OpenEnemyInfo(2, 20); assert(not ok and reason == "COMBAT")
combat = false; restricted = true
ok, reason = API:OpenEnemyInfo(2, 20); assert(not ok and reason == "RESTRICTED")
restricted = false; conflicts = true
ok, reason = API:OpenEnemyInfo(2, 20); assert(not ok and reason == "UI_UNAVAILABLE")
conflicts = false
-- Completion callbacks may reenter and supersede the request currently being submitted.
assert(API:OpenEnemyInfo(2, 20, function(_, why)
  if why == "SUPERSEDED" then assert(API:OpenEnemyInfo(10, 30, result("reentrant"))) end
end))
assert(API:OpenEnemyInfo(2, 21, result("superseded")))
drain(); assert(opened[#opened].npcID == 30 and results[#results][1] == "reentrant")
assert(API:OpenEnemyInfo(2, 20, function(ok)
  assert(ok)
  assert(API:OpenEnemyInfo(10, 30, result("success reentry")))
end))
drain(); assert(opened[#opened].npcID == 30 and results[#results][1] == "success reentry")
for _, args in ipairs({ {secret, 20}, {2, secret}, {2, 0}, {2, 20, true} }) do
  ok, reason = API:OpenEnemyInfo(unpack(args)); assert(not ok and reason == "INVALID_ARGUMENT")
end
-- UI loader failures do not become successful requests.
loaded, failLoad = false, true
local oldPrint = print; print = function() end
iterator, reason = API:IterateEnemies(); assert(not iterator and reason == "UI_UNAVAILABLE")
ok, reason = API:OpenEnemyInfo(2, 20); assert(not ok and reason == "UI_UNAVAILABLE")
print = oldPrint
print("enemy search API passed: lazy loading, copied metadata, blacklist, sparse data, navigation, stale targets, combat, reentrancy")

-- Use the shipped data too: the API must not assume a fixed season or dungeon list.
for _, field in ipairs({ "dungeonEnemies", "dungeonList", "mapInfo", "zoneIdToDungeonIdx", "dungeonMaps",
    "dungeonSubLevels", "dungeonTotalCount", "mapPOIs", "scaleMultiplier" }) do ui[field] = {} end
for file in read("Midnight/load_midnight.xml"):gmatch("<Script file='([^']+)'/>") do
  load("Midnight/"..file, "MythicDungeonTools_UI", ui)
end
local expected, actual, spells = 0, 0, 0
for _, enemies in pairs(ui.dungeonEnemies) do
  for _, enemy in pairs(enemies) do
    if enemy.id and enemy.name and type(enemy.clones) == "table" and next(enemy.clones) then expected = expected + 1 end
  end
end
for enemy in assert(ui:IterateEnemies()) do
  actual = actual + 1; spells = spells + #enemy.spellIDs
  assert(type(enemy.name) == "string" and type(enemy.dungeonName) == "string")
end
assert(actual == expected and actual > 0)
local coldStart = os.clock()
for _ in assert(ui:IterateEnemies()) do end
local elapsed = (os.clock() - coldStart) * 1000
collectgarbage("collect")
local baseline = collectgarbage("count")
collectgarbage("stop")
for _ in assert(ui:IterateEnemies()) do end
local allocation = collectgarbage("count") - baseline
collectgarbage("restart"); collectgarbage("collect")
local growth = collectgarbage("count") - baseline
assert(allocation < 2048 and growth < 64, "metadata iteration budget")
print(string.format("shipped data: enemies=%d spell_links=%d full_scan_ms=%.2f allocated_KiB=%.1f retained_KiB=%.1f",
  actual, spells, elapsed, allocation, growth))
