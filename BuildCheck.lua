local addonName, MDT = ...;

function MDT:IsCompatibleVersion()
  local gameVersion = select(4, GetBuildInfo())
  return gameVersion >= 110000
end
