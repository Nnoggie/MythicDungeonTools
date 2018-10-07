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