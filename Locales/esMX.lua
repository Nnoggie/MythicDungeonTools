if not(GetLocale() == "esMX") then
  return
end
local addonName, MDT = ...
local L = MDT.L
L = L or {}

--@localization(locale="esMX", format="lua_additive_table", namespace="MDT", handle-subnamespaces="none")@