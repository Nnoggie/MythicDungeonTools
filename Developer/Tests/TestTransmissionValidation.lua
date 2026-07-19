local addonName, addon = ...

local function testFunc()
  local message = addon:TableToString({}, false, 1)
  MDTcommsObject:OnCommReceived("MDTPreset", message, "PARTY", UnitName("player"))
end

---@type MDTTest
local test = {
  name = "Transmission Validation",
  func = testFunc,
  duration = 0,
}

tinsert(addon.test.testList, test)
