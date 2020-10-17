if not(GetLocale() == "ptBR") then
  return
end
local addonName, MDT = ...
local L = MDT.L
L = L or {}

--@localization(locale="ptBR", format="lua_additive_table", namespace="MDT", handle-subnamespaces="none")@