if not ((GAME_LOCALE or GetLocale()) == "deDE") then
  return
end
local addonName, MDT = ...
local L = MDT.L
L = L or {}

--@localization(locale="deDE", format="lua_additive_table", namespace="MDT", handle-subnamespaces="none")@
