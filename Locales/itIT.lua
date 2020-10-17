if not(GetLocale() == "itIT") then
  return
end
local addonName, MDT = ...
local L = MDT.L
L = L or {}

--@localization(locale="itIT", format="lua_additive_table", namespace="MDT", handle-subnamespaces="none")@