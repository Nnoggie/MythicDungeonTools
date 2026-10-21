-- Made by Nnoggie, 2017-2025
local _, MDT = ...
local L = MDT.L

local CreateFrame, tonumber, pairs, ipairs = CreateFrame, tonumber, pairs, ipairs

_G["BINDING_NAME_CLICK MDTFocusMarkerButton:LeftButton"] = L["MDT Set Focus Macro"]

local db

---@param shouldWarn boolean|nil
function MDT:IsInRestrictedEnvironment(shouldWarn)
  if C_Secrets and C_Secrets.ShouldAurasBeSecret and C_Secrets.ShouldAurasBeSecret() then
    if shouldWarn then
      print('MDT: '..(L["Action blocked: Restricted environment"] or "Action blocked: Restricted environment"))
    end
    return true
  end
  return false
end

-- close.tga is MethodInternal's CloseCross, copied as is; the other icons are drawn to match it.
local ICON_FILES = { close = "close.tga" }

---@param name string icon name under Textures\Icons
---@return string
function MDT:GetIconPath(name)
  return "Interface\\AddOns\\MythicDungeonTools\\Textures\\Icons\\"..(ICON_FILES[name] or name..".png")
end

---Opens a kit context menu at the cursor. Every right-click menu in MDT goes through here so the restricted check runs once.
---@param owner table?
---@param items MDT.UI.MenuItem[]|fun(): MDT.UI.MenuItem[]
---@return MDT.UI.Control?
function MDT:CreateContextMenu(owner, items)
  if self:IsInRestrictedEnvironment(true) then return end
  return MDT.UI.Menu.OpenContext(items, owner)
end

function MDT:InitializeRuntime()
  db = MDT:InitializeSavedVariables()
  if not db then return end
  db.uiScale = MDT.UI.SetUserScale(db.uiScale)
  -- Release packages omit Developer/. Keep its saved edits, but use normal UI/data.
  if not MDT.CreateDevPanel then db.devMode = false end
  MDT:InitializeFadeFrame()
  return db
end

BINDING_NAME_MDTTOGGLE = L["Toggle Window"]
BINDING_NAME_MDTNPC = L["New NPC at Cursor Position"]
BINDING_NAME_MDTWAYPOINT = L["New Patrol Waypoint at Cursor Position"]
BINDING_NAME_MDTUNDODRAWING = L["undoDrawing"]
BINDING_NAME_MDTREDODRAWING = L["redoDrawing"]

function MDT:GetLocaleIndex()
  local localeToIndex = {
    ["enUS"] = 1,
    ["deDE"] = 2,
    ["esES"] = 3,
    ["esMX"] = 4,
    ["frFR"] = 5,
    ["itIT"] = 6,
    ["ptBR"] = 7,
    ["ruRU"] = 8,
    ["koKR"] = 9,
    ["zhCN"] = 10,
    ["zhTW"] = 11,
  }
  return localeToIndex[GetLocale()] or 1
end

MDT.mapInfo = {}
MDT.dungeonTotalCount = {}
MDT.scaleMultiplier = {}
MDT.dungeonMaps = {}
MDT.dungeonEnemies = {}
MDT.mapPOIs = {}
MDT.dungeonSubLevels = {}
MDT.dungeonList = {
  -- these were for the old dropdown menu, need to fix this at some point
  [14] = "-",
  [27] = "-",
  [28] = "-",
  [39] = "-",
}

function MDT:GetDungeonName(idx, forceEnglish)
  if forceEnglish and MDT.mapInfo[idx] and MDT.mapInfo[idx].englishName then
    return MDT.mapInfo[idx].englishName
  end
  return MDT.dungeonList[idx]
end

function MDT:GetDungeonSublevels()
  return MDT.dungeonSubLevels
end

---FormatEnemyForces
function MDT:FormatEnemyForces(forces, forcesmax, progressbar)
  if not forcesmax then
    forcesmax = MDT.dungeonTotalCount[db.currentDungeonIdx].normal
  end
  local percent = forcesmax > 0 and (forces / forcesmax) * 100 or 0
  if progressbar then return string.format((forces.."/"..forcesmax.." (%.2f%%)"), percent) end
  return string.format(forces.." (%.2f%%)", percent)
end

local function round(number, decimals)
  return tonumber((("%%.%df"):format(decimals)):format(number))
end

do
  local fortMult = 1.2
  local tyrMult = 1.25
  local scalingNormal = 1.07
  local scalingExtra = 1.1 -- Xalatath's Guile
  local extraScalingLevel = 11

  local getFortTyrMult = function(level, boss, fortified, tyrannical, ignoreFortified)
    local mult = 1
    if level >= 10 then
      if not boss and (fortified and not ignoreFortified) then mult = mult * fortMult end
      if boss and tyrannical then mult = mult * tyrMult end
    end
    return mult
  end

  local function getScaling(mult, level)
    local scaling = mult * (scalingNormal ^ math.min(level - 1, extraScalingLevel - 2)) * (scalingExtra ^ math.max(0, level - extraScalingLevel + 1))
    return round(scaling, 2) --not sure if this additional rounding is needed, but it was in the original code
  end

  function MDT:CalculateEnemyHealth(boss, baseHealth, level, ignoreFortified)
    local fortified = true --fort and tyr are always present in 10 and above, we don't really care for lower levels
    local tyrannical = true
    local mult = 1

    mult = getFortTyrMult(level, boss, fortified, tyrannical, ignoreFortified)
    mult = getScaling(mult, level)

    return round(mult * baseHealth, 0)
  end

end

function MDT:FormatEnemyHealth(amount)
  amount = tonumber(amount)
  if not amount then return "" end

  if self:GetLocaleIndex() == 9 then
    -- KR
    if amount >= 1e16 then
      return string.format("%.3f경", amount / 1e16)
    elseif amount >= 1e12 then
      return string.format("%.3f조", amount / 1e12)
    elseif amount >= 1e8 then
      return string.format("%.2f억", amount / 1e8)
    elseif amount >= 1e4 then
      return string.format("%.1f만", amount / 1e4)
    else
      return amount
    end
  elseif self:GetLocaleIndex() == 10 or self:GetLocaleIndex() == 11 then
    if amount >= 1e8 then
      return string.format("%.2f亿", amount / 1e8)
    elseif amount >= 1e4 then
      return string.format("%d万", math.floor(amount / 1e4))
    else
      return amount
    end
  else
    if amount >= 1e12 then
      return string.format("%.3ft", amount / 1e12)
    elseif amount >= 1e9 then
      return string.format("%.3fb", amount / 1e9)
    elseif amount >= 1e6 then
      return string.format("%.2fm", amount / 1e6)
    elseif amount >= 1e3 then
      return string.format("%.1fk", amount / 1e3)
    else
      return amount
    end
  end
end

function MDT:Round(number, decimals)
  return (("%%.%df"):format(decimals)):format(number)
end

function MDT:RGBToHex(r, g, b)
  r = r * 255
  g = g * 255
  b = b * 255
  return ("%.2x%.2x%.2x"):format(r, g, b)
end

function MDT:HexToRGB(rgb)
  if string.len(rgb) == 6 then
    local r, g, b
    r, g, b = tonumber('0x'..strsub(rgb, 0, 2)), tonumber('0x'..strsub(rgb, 3, 4)), tonumber('0x'..
      strsub(rgb, 5, 6))
    if not r then r = 0 else r = r / 255 end
    if not g then g = 0 else g = g / 255 end
    if not b then b = 0 else b = b / 255 end
    return r, g, b
  else
    return
  end
end

---Checks if the players is in a group/raid and returns the type
function MDT:IsPlayerInGroup()
  local inGroup = (UnitInRaid("player") and "RAID") or (IsInGroup() and "PARTY")
  return inGroup
end
