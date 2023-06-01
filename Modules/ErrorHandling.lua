local MDT = MDT

local function errorHandler(s)
  MDT.initSpinner:Hide()
  MDT.initSpinner.Anim:Stop()
  print("Error: "..s)
  return false
end

function MDT:RegisterProtectedFunction(func,name)
  MDT[name] = function(...)
    return xpcall(func, errorHandler , ...)
  end
end

MDT:RegisterProtectedFunction(MDT.EnsureDBTables,"EnsureDBTables")

