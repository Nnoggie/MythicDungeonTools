local AddonName, MDT = ...
MDT.U = {}
local U = MDT.U
local tinsert = table.insert

U.count_if = function(t, func)
  local count = 0

  for k, v in pairs(t) do
    if func(v) then
      count = count + 1
    end
  end

  return count
end

U.do_if = function(t, func)
  local updated = 0

  for k, v in pairs(t) do
    if func.condition(v) then
      func.update(t, k)
      updated = updated + 1
    end
  end

  return updated
end

U.iremove_if = function(t, condition)
  local removed = 0

  for old_index = 1, #t do
    local new_index = old_index - removed
    local entry = t[new_index]
    if entry then
      if condition(entry) then
        removed = removed + 1
        table.remove(t, new_index)
      end
    end
  end

  return removed
end

U.contains = function(t, needle)
  for k, v in pairs(t) do
    if type(v) == type(needle) and v == needle then
      return true
    end
  end

  return false
end

U.copy = function(t)
  local new = {}

  for k, v in pairs(t) do
    if type(v) == "table" then
      new[k] = U.copy(v)
    else
      new[k] = v
    end
  end

  return new
end

U.lerp = function(a, b, alpha)
  return (b - a) * alpha + a
end

U.isInRange = function(value, min, max)
  return (value >= min and value <= max)
end

local function getGroupMembers(reversed, forceParty)
  local unit            = (not forceParty and IsInRaid()) and 'raid' or 'party'
  local numGroupMembers = forceParty and GetNumSubgroupMembers() or GetNumGroupMembers()
  local i               = reversed and numGroupMembers or (unit == 'party' and 0 or 1)
  return function()
    local ret
    if i == 0 and unit == 'party' then
      ret = 'player'
    elseif i <= numGroupMembers and i > 0 then
      ret = unit..i
    end
    i = i + (reversed and -1 or 1)
    return ret
  end
end

U.GetGroupMembers = function()
  local groupMembers = {}
  --iterate over all group members and add them to the list
  for unit in getGroupMembers(false, false) do
    local name = UnitName(unit)
    if name then
      local _, class = UnitClass(unit)
      local _, _, _, classHexString = GetClassColor(class)
      local coloredName = "|c"..classHexString..name.."|r"
      tinsert(groupMembers, coloredName)
    end
  end
  return groupMembers
end

U.GetClassColoredClassNames = function()
  local res = {}
  for class, localizedClass in pairs(LOCALIZED_CLASS_NAMES_MALE) do
    if class ~= "Adventurer" then
      local _, _, _, classHexString = GetClassColor(class)
      local coloredName = "|c"..classHexString..localizedClass.."|r"
      tinsert(res, coloredName)
    end
  end
  return res
end

function U.TableToString(tbl)
  local result = "{"
  for k, v in pairs(tbl) do
    -- Check the key type (ignore any numerical keys - assume its an array)
    if type(k) == "string" then
      result = result.."[\""..k.."\"]".."="
    end

    -- Check the value type
    if type(v) == "table" then
      result = result..U.TableToString(v)
    elseif type(v) == "boolean" then
      result = result..tostring(v)
    else
      result = result.."\""..v.."\""
    end
    result = result..","
  end
  -- Remove leading commas from the result
  if result ~= "" then
    result = result:sub(1, result:len() - 1)
  end
  return result.."}"
end
