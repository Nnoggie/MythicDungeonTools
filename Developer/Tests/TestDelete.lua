local _, addon = ...
local MDT = addon

local function testFunc()
  MDT:OpenDeletePresetDialog()
  C_Timer.After(0.5, function()
    MDT.UI.Dialogs.Get("deletePreset").content:Find("confirm"):Click()
  end)
end

---@type MDTTest
local test = {
  name = "Delete Route",
  func = testFunc,
  duration = 1
}

tinsert(addon.test.testList, test)
