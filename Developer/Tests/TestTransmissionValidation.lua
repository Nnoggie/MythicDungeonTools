local _, addon = ...

local function testFunc()
  local preset = addon:GetCurrentPreset()
  local message = addon:TableToString(preset)
  assert(message:sub(1, 7) == "!~MDT2~", "Unexpected export encoding")
  local decoded = addon:StringToTable(message, false)
  assert(type(decoded) == "table", "Blizzard encoding round-trip failed")
  assert(decoded.text == preset.text, "Blizzard encoding changed the preset name")
  assert(decoded.value.currentDungeonIdx == preset.value.currentDungeonIdx, "Blizzard encoding changed the dungeon")

  local name, realm = UnitFullName("player")
  MDTcommsObject:OnCommReceived("MDTPreset", message, "PARTY", name)
  local displayName = addon:GetDungeonName(preset.value.currentDungeonIdx, true)..": "..preset.text
  assert(addon.transmissionCache[name.."-"..realm][displayName], "Blizzard transmission was not cached")

  local invalidMessage = addon:TableToString({ test = true })
  MDTcommsObject:OnCommReceived("MDTPreset", invalidMessage, "PARTY", UnitName("player"))

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
