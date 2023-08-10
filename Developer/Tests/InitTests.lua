local addonName, addon = ...
addon.test = {}
local T = addon.test

--- @type MDTTest[]
T.testList = {}

function T:RunAllTests()
  print("Running all tests")
  local delay = 1
  local prevTestName = ""
  local numTestsRan = 0
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
      C_Timer.After(test.duration, function()
        numTestsRan = numTestsRan + 1
        if numTestsRan == #T.testList then
          print("\124cff00ff00All tests ran successfully\124r")
        end
      end)
      prevTestName = test.name
    end)
    delay = delay + test.duration
  end
end
