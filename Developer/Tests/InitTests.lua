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
  local previousDuration = 1
  for _, test in pairs(T.testList) do
    self:RunTest(test, previousDuration)
    previousDuration = previousDuration + test.duration
  end
end
