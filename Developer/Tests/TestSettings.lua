local addonName, addon = ...

local function testFunc()
  C_Timer.After(0.2, function()
    local settingsCogwheel = addon.main_frame.settingsCogwheel.frame
    settingsCogwheel:Click()
    C_Timer.After(0.2, function()
      addon.main_frame.settingsFrame:Hide()
    end)
  end)
end

---@type MDTTest
local test = {
  name = "Settings",
  func = testFunc,
  duration = 1
}

tinsert(addon.test.testList, test)
