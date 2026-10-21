local _, MDT = ...
local UI = MDT.UI

---Spell, item and spec icons are drawn zoomed in by 20% so the border baked into their art is cut off.
local Icon = {}
UI.Icon = Icon

local ZOOM = 0.2
local INSET = (1 - 1 / (1 + ZOOM)) / 2

---@type number[] left, right, top, bottom
Icon.ZOOMED_COORDS = { INSET, 1 - INSET, INSET, 1 - INSET }

---@param texture table
---@param file string|number
function Icon.SetZoomed(texture, file)
  texture:SetTexture(file)
  texture:SetTexCoord(unpack(Icon.ZOOMED_COORDS))
end
