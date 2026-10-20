local _, addon = ...
local MDT = addon

local function testFunc()
  local frame = MDT.main_frame
  local okayButton = frame.DeleteConfirmationFrame.OkayButton.frame
  MDT:OpenDeletePresetDialog()
  C_Timer.After(0.5, function()
    okayButton:Click()
  end)
end

---@type MDTTest
local test = {
  name = "Delete Route",
  func = testFunc,
  duration = 1
}

tinsert(addon.test.testList, test)
