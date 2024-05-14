local addonName, MDT = ...;

function MDT:IsDragonflight()
  local gameVersion = select(4, GetBuildInfo())
  return gameVersion >= 100000 and gameVersion < 110000
end
