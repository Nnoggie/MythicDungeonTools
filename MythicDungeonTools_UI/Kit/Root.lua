local _, MDT = ...
local UI = MDT.UI

---The parent of every MDT window, popover, menu and tooltip. It covers the screen and cancels the user's UI scale:
---its effective scale is always WoW's pixel-perfect scale (768 / physical screen height), so one MDT unit is one
---screen pixel and MDT looks the same whatever UI scale is set.
local Root = CreateFrame("Frame", "MDTUIRoot", UIParent)
Root:SetAllPoints(UIParent)
UI.Root = Root

---@return number scale the Root needs under the current UIParent
function UI.RootScale()
  local _, height = GetPhysicalScreenSize()
  local parentScale = UIParent:GetEffectiveScale()
  if not height or height <= 0 or not parentScale or parentScale <= 0 then return 1 end
  return (768 / height) / parentScale
end

---Converts a cursor position (GetCursorPosition) to Root units.
---@return number x, number y
function UI.CursorInRoot()
  local x, y = GetCursorPosition()
  local scale = Root:GetEffectiveScale()
  return x / scale, y / scale
end

local function applyScale()
  Root:SetScale(UI.RootScale())
end

applyScale()
Root:RegisterEvent("UI_SCALE_CHANGED")
Root:RegisterEvent("DISPLAY_SIZE_CHANGED")
UI.Script(Root, "OnEvent", applyScale)
