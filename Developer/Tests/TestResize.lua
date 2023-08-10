local addonName, addon = ...

local function testFunc()
  local resizer = addon.main_frame.resizer
  local onMouseDown = resizer:GetScript("OnMouseDown")
  local onMouseUp = resizer:GetScript("OnMouseUp")
  C_Timer.After(0, function()
    onMouseDown()
  end)
  C_Timer.After(0.5, function()
    onMouseUp()
  end)
  C_Timer.After(1, function()
    onMouseDown()
  end)
  C_Timer.After(1.2, function()
    onMouseUp()
  end)
  C_Timer.After(1.3, function()
    onMouseDown()
  end)
  C_Timer.After(1.35, function()
    onMouseUp()
  end)
end

---@type MDTTest
local test = {
  name = "Resize",
  func = testFunc,
  duration = 2
}

tinsert(addon.test.testList, test)
