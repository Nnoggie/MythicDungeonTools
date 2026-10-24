local _, addon = ...

local function testFunc()
  C_Timer.After(0, function()
    addon:Maximize()
  end)
  C_Timer.After(0.5, function()
    addon:Minimize()
  end)
  C_Timer.After(1, function()
    addon:Maximize()
  end)
  C_Timer.After(1.2, function()
    addon:Minimize()
  end)
  C_Timer.After(1.3, function()
    addon:Maximize()
  end)
  C_Timer.After(1.35, function()
    addon:Minimize()
  end)
  C_Timer.After(1.4, function()
    addon:Maximize()
  end)
  C_Timer.After(1.425, function()
    addon:Minimize()
  end)
end

---@type MDTTest
local test = {
  name = "Maximize",
  func = testFunc,
  duration = 2
}

tinsert(addon.test.testList, test)
