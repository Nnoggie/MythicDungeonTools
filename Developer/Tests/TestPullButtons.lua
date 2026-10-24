local _, addon = ...
local MDT = addon

local function setup()
  local preset = MDT:StringToTable(MDT:TableToString(MDT:GetCurrentPreset()))
  assert(MDT:ValidateImportPreset(preset), "the exported current route does not import")
  preset.uid = nil
  preset.text = "Pull Buttons Test"
  MDT:ImportPreset(preset)
end

local function teardown()
  local db = MDT:GetDB()
  MDT:DeletePreset(db.currentPreset[db.currentDungeonIdx])
end

local function testFunc()
  setup()
  C_Timer.After(1.5, function()
    local list = MDT:GetSidebarControl("pulls")
    local numPulls = MDT:GetPullsNum()
    for i = 1, numPulls do
      C_Timer.After(0.2 * i, function()
        list:ScrollTo(i, "nearest")
        local row = list:GetRow(i)
        row:GetScript("OnEnter")(row)
        C_Timer.After(0.2, function()
          row:GetScript("OnLeave")(row)
          C_Timer.After(0.2, function()
            row:Click("LeftButton")
          end)
        end)
      end)
    end
  end)

  C_Timer.After(7, function()
    teardown()
  end)
end

---@type MDTTest
local test = {
  name = "Pull Buttons",
  func = testFunc,
  duration = 8
}

tinsert(addon.test.testList, test)
