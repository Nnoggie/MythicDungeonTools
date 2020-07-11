if not(GetLocale() == "ruRU") then
  return
end
local addonName, MDT = ...
local L = MDT.L
L = L or {}

--@localization(locale="ruRU", format="lua_additive_table", namespace="MDT", handle-subnamespaces="none")@