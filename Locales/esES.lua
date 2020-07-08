if not(GetLocale() == "esES") then
  return
end
local addonName, MDT = ...
local L = MDT.L
L = L or {}

--@localization(locale="esES", format="lua_additive_table", namespace="MDT", handle-subnamespaces="none")@