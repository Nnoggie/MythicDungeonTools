local AddonName, MethodDungeonTools = ...
MethodDungeonTools.U = {}
local U = MethodDungeonTools.U


U.count_if = function(t, func)
    local count = 0

    for k, v in pairs(t) do
        if func(v) then
            count = count + 1
        end
    end

    return count
end

U.do_if = function(t, condition, update)
    local updated = 0

    for k, v in pairs(t) do
        if condition(v) then
            update(v)
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