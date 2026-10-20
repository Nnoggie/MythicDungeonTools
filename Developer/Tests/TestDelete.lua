local _, addon = ...
local MDT = addon

local function testFunc()
  local db = MDT:GetDB()
  local presets, index = db.presets[db.currentDungeonIdx], db.currentPreset[db.currentDungeonIdx]
  local before = #presets
  MDT:DeletePreset(index)
  assert(index == 1 or #presets == before - 1, "DeletePreset did not remove the route")
end

---@type MDTTest
local test = {
  name = "Delete Route",
  func = testFunc,
  duration = 1
}

tinsert(addon.test.testList, test)
