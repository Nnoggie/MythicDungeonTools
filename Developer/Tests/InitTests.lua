local addonName, addon = ...
addon.test = {}
local T = addon.test

--- @type MDTTest[]
T.testList = {}

---@param test MDTTest
function T:RunTest(test, delay)
  C_Timer.After(delay, function()
    print("Running test: "..test.name)
    test.func()
  end)
end

function T:RunAllTests()
  print("Running all tests")
  local delay = 1
  local prevTestName = ""
  for _, test in pairs(T.testList) do
    C_Timer.After(delay, function()
      local errors = CopyTable(MDT:GetErrors())
      if #errors > 0 then
        print("\124cffff0000Errors found in: "..prevTestName.."\124r")
        for _, error in pairs(errors) do
          print(error.message)
        end
        return
      end
      print("Running test: "..test.name)
      test.func()
      prevTestName = test.name
    end)
    delay = delay + test.duration
  end
end
