if not(GetLocale() == "zhCN") then
  return
end
local addonName, MDT = ...
local L = MDT.L
L = L or {}

--@localization(locale="zhCN", format="lua_additive_table", namespace="MDT", handle-subnamespaces="none")@