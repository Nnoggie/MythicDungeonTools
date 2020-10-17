if not(GetLocale() == "zhTW") then
  return
end
local addonName, MDT = ...
local L = MDT.L
L = L or {}

--@localization(locale="zhTW", format="lua_additive_table", namespace="MDT", handle-subnamespaces="none")@