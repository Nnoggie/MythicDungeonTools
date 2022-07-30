local AddonName, MDT = ...
MDT.U = {}
local U = MDT.U
local twipe,tinsert = table.wipe,table.insert


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

    for old_index=1, #t do
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

    for k,v in pairs(t) do
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

--[[
Performance measurement
Usage:
MDT.U:TMStart("DungeonEnemies_UpdateEnemies")
MDT.U:TMStep("ReleaseAll")
MDT.U:TMStep("AddBlips")
MDT.U:TMEnd()
]]

local debugTimes
U.TMStart = function(self,segmentName)
    debugTimes = {}
    tinsert(debugTimes,{name=segmentName,time=debugprofilestop()})
end

U.TMStep = function(self,segmentName)
    tinsert(debugTimes,{name=segmentName,time=debugprofilestop()})
end


U.TMEnd = function()
    local stepTimes = {}
    for segmentIdx,data in ipairs(debugTimes) do
        if segmentIdx>1 then
            local time = data.time-debugTimes[segmentIdx-1].time
            stepTimes[data.name] = time
        end
    end
    ViragDevTool_AddData(stepTimes)
end

local function getGroupMembers(reversed, forceParty)
    local unit  = (not forceParty and IsInRaid()) and 'raid' or 'party'
    local numGroupMembers = forceParty and GetNumSubgroupMembers()  or GetNumGroupMembers()
    local i = reversed and numGroupMembers or (unit == 'party' and 0 or 1)
    return function()
        local ret
        if i == 0 and unit == 'party' then 
            ret = 'player'
        elseif i <= numGroupMembers and i > 0 then
            ret = unit .. i
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
            local _,class = UnitClass(unit)
            local _,_,_,classHexString = GetClassColor(class)
            local coloredName = "|c"..classHexString..name.."|r"
            tinsert(groupMembers, coloredName)
        end
    end
    return groupMembers
end

U.GetColoredNameFromFullName = function (fullName)
    local _,myRealm = UnitFullName("player")
    local name,realm = strsplit("-",fullName)
    for unit in getGroupMembers(false, false) do
        local isRealUnit = UnitName(unit) -- getGroupMembers function is fricked 
        if isRealUnit then
            local unitName,unitRealm = UnitFullName(unit)
            if unitName == name and unitRealm == realm or (not unitRealm and myRealm == realm) then
                local _,class = UnitClass(unit)
                local _,_,_,classHexString = GetClassColor(class)
                local coloredName = "|c"..classHexString..name.."|r"
                return coloredName
            end
        end
    end
end

