local addonName, addon = ...
addon.test = {}
local T = addon.test

--- @type MDTTest[]
T.testList = {}

local function snapshotErrors()
  local snapshot = {}
  for _, errorInfo in ipairs(MDT:GetErrors()) do
    snapshot[errorInfo.message] = errorInfo.count or 1
  end
  return snapshot
end

local function getNewErrors(snapshot)
  local newErrors = {}
  for _, errorInfo in ipairs(MDT:GetErrors()) do
    if (errorInfo.count or 1) > (snapshot[errorInfo.message] or 0) then
      newErrors[#newErrors + 1] = errorInfo
    end
  end
  return newErrors
end

function T:RunAllTests()
  print("Running all tests")
  local failedTests = 0

  local function runTest(index)
    local test = T.testList[index]
    if not test then
      if failedTests == 0 then
        print("\124cff00ff00All tests ran successfully\124r")
      else
        print("\124cffff0000"..failedTests.." test(s) failed\124r")
      end
      return
    end

    print("Running test: "..test.name)
    local errorsBefore = snapshotErrors()
    local succeeded, testError = pcall(test.func)
    C_Timer.After(test.duration, function()
      local newErrors = getNewErrors(errorsBefore)
      if not succeeded or #newErrors > 0 then
        failedTests = failedTests + 1
        print("\124cffff0000Test failed: "..test.name.."\124r")
        if not succeeded then print(testError) end
        for _, errorInfo in ipairs(newErrors) do
          print(errorInfo.message)
        end
      end
      runTest(index + 1)
    end)
  end

  C_Timer.After(1, function() runTest(1) end)
end
