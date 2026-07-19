local addonName, addon = ...

local function testFunc()
  local message = addon:TableToString({}, false, 1)
  MDTcommsObject:OnCommReceived("MDTPreset", message, "PARTY", UnitName("player"))

  local legacyDungeonIdx
  for dungeonIdx in pairs(addon.knownDungeons) do
    if not addon.dungeonList[dungeonIdx] then
      legacyDungeonIdx = dungeonIdx
      break
    end
  end
  assert(legacyDungeonIdx, "No historical dungeon available for validation test")

  local legacyPreset = {
    text = "Legacy validation test",
    value = {
      currentDungeonIdx = legacyDungeonIdx,
      currentPull = 1,
      currentSublevel = 1,
      pulls = { {} },
    },
  }
  assert(not addon:ValidateImportPreset(legacyPreset), "Normal import accepted unavailable dungeon")
  assert(addon:ValidateImportPreset(legacyPreset, true), "Shared legacy preset was rejected")
end

---@type MDTTest
local test = {
  name = "Transmission Validation",
  func = testFunc,
  duration = 0,
}

tinsert(addon.test.testList, test)
