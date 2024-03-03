local addonName, MDT = ...;

function MDT:IsVanilla()
  local gameVersion = select(4, GetBuildInfo())
  return gameVersion >= 0 and gameVersion < 30399
end

function MDT:IsWrath()
  local gameVersion = select(4, GetBuildInfo())
  return gameVersion >= 30400 and gameVersion < 40000
end

function MDT:IsDragonflight()
  local gameVersion = select(4, GetBuildInfo())
  return gameVersion >= 100000 and gameVersion < 110000
end
