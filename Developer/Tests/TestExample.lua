local addonName, addon = ...

local function testFunc()

end

---@type MDTTest
local test = {
  name = "Example",
  func = testFunc,
  duration = 4
}

tinsert(addon.test.testList, test)
