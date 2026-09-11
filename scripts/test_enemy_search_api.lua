local MDT = {
  L = setmetatable({ Guardian = "守卫" }, { __index = function(_, key) return key end }),
  dungeonEnemies = {
    [2] = {
      { id = 20, name = "Guardian", isBoss = true, clones = { {} }, spells = { [100] = {}, [277564] = {} } },
      { id = 21, name = "Caster", clones = { [4] = {} }, spells = { [100] = {} } },
      { id = 22, name = "No clones", clones = {} },
    },
    [9] = { { id = 20, name = "Guardian", clones = { {} } } },
  },
}
function LibStub() return { RegisterLayout = function() end } end
local combat, restricted, ready = false, false, false
function InCombatLockdown() return combat end
local db, jobs, callbacks, opened = {}, {}, {}, {}
local showCalls = 0
function MDT:GetDB() return db end
function MDT:GetDungeonName(index) return "Dungeon "..index end
function MDT:IsInRestrictedEnvironment() return restricted end
function MDT:IsCompatibleVersion() return true end
function MDT:CheckAddonConflicts() return false end
function MDT:AreFramesInitialized() return ready end
function MDT:RunAfterFramesInitialized(callback) callbacks[#callbacks + 1] = callback end
function MDT:ShowInterface(force) assert(force); showCalls = showCalls + 1 end
function MDT:ShowInterfaceInternal(force) assert(force and ready) end
function MDT:SetCurrentSection(section) assert(section == "maps") end
function MDT:SetDungeonList(_, index) self.selectedDungeon = index end
function MDT:UpdateToDungeon(index) self.currentDungeon = index end
function MDT:UpdateDungeonDropDown() assert(self.currentDungeon == self.selectedDungeon) end
function MDT:Async(fn, name, singleton) assert(singleton); jobs[name] = fn end
local function drain()
  local pending = jobs; jobs = {}
  for _, fn in pairs(pending) do fn() end
end
assert(loadfile("Modules/EnemyInfo.lua"))("MythicDungeonTools_UI", MDT)
function MDT:ShowEnemyInfoFrame(blip)
  local enemy = self.dungeonEnemies[self.currentDungeon][blip.enemyIdx]
  assert(enemy.clones[blip.cloneIdx])
  opened[#opened + 1] = { dungeon = self.currentDungeon, npcID = enemy.id }
end
local found = {}
for enemy in MDT:IterateEnemies(2) do found[enemy.npcID] = enemy end
assert(showCalls == 0 and not ready, "reading metadata must not open MDT")
assert(found[20].name == "守卫" and found[20].isBoss and found[21] and not found[22])
assert(#found[20].spellIDs == 1 and found[20].spellIDs[1] == 100, "enemy-info blacklist")
found[20].spellIDs[1] = 999
assert(MDT.dungeonEnemies[2][1].spells[999] == nil and found[20].clones == nil, "copied metadata")
db.devMode = true
for enemy in MDT:IterateEnemies(2) do
  if enemy.npcID == 20 then assert(#enemy.spellIDs == 2) end
end
db.devMode = false
assert(MDT:OpenEnemyInfo(2, 20) and MDT:OpenEnemyInfo(2, 21))
assert(showCalls == 1 and #callbacks == 1, "repeated clicks must not restart initialization")
ready = true; callbacks[1](); drain()
assert(#opened == 1 and opened[1].npcID == 21)
assert(MDT:OpenEnemyInfo(9, 20)); drain()
assert(opened[2].dungeon == 9)
assert(MDT:OpenEnemyInfo(2, 20)); combat = true; drain()
assert(#opened == 2 and not MDT:OpenEnemyInfo(2, 20), "combat must stop navigation")
combat = false; restricted = true
assert(not MDT:OpenEnemyInfo(2, 20))
restricted = false
assert(not MDT:OpenEnemyInfo(2, 999))
assert(MDT:OpenEnemyInfo(2, 20))
MDT.dungeonEnemies[2][1], MDT.dungeonEnemies[2][2] = MDT.dungeonEnemies[2][2], MDT.dungeonEnemies[2][1]
drain(); assert(opened[3].npcID == 20, "resolve NPC identity after data changes")
assert(MDT:OpenEnemyInfo(9, 20)); MDT.dungeonEnemies[9] = nil; drain()
assert(#opened == 3, "removed targets must not navigate")
print("Enemy API passed: metadata, blacklist, first open, repeated clicks, navigation and combat")
