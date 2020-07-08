if not(GetLocale() == "frFR") then
  return
end
local addonName, MDT = ...
local L = MDT.L
L = L or {}

--@localization(locale="frFR", format="lua_additive_table", namespace="MDT", handle-subnamespaces="none")@