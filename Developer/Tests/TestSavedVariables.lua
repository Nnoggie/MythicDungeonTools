local addonName, addon = ...

local function testFunc()
  local defaults = addon:GetDefaultSavedVariables()
  local expectedDungeon = addon:IsMop() and 130 or 160

  assert(type(defaults) == "table", "SavedVariables defaults missing")
  assert(type(defaults.global) == "table", "SavedVariables global defaults missing")
  assert(defaults.global.currentDungeonIdx == expectedDungeon, "Unexpected default dungeon")
  assert(defaults.global.focusMarker.disableTargetMarkerInRaid == false, "Focus Marker default missing")
  assert(defaults.global.presets[1] ~= defaults.global.presets[2], "Dungeon preset lists share a table")
  assert(defaults.global.presets[1][1] ~= defaults.global.presets[2][1], "Default presets share a table")
  assert(defaults.global.presets[1][1].value ~= defaults.global.presets[2][1].value,
    "Default preset values share a table")
  assert(addon:GetDB() == MythicDungeonToolsDB.global, "GetDB returned unexpected table")
end

---@type MDTTest
local test = {
  name = "SavedVariables",
  func = testFunc,
  duration = 0,
}

tinsert(addon.test.testList, test)
