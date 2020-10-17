if not(GetLocale() == "koKR") then
  return
end
local addonName, MDT = ...
local L = MDT.L
L = L or {}

--@localization(locale="koKR", format="lua_additive_table", namespace="MDT", handle-subnamespaces="none")@