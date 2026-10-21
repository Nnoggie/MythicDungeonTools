local _, MDT = ...
local UI = MDT.UI

-- At 100% MDT scale one MDT unit is one physical pixel on a 1440p screen.
local REFERENCE_HEIGHT = 1440

---The parent of every MDT window, popover, menu and tooltip. It covers the screen and cancels the user's UI scale:
---it is always REFERENCE_HEIGHT / user scale units tall, so MDT covers the same share of the screen at every
---resolution and UI scale.
local Root = CreateFrame("Frame", "MDTUIRoot", UIParent)
Root:SetAllPoints(UIParent)
UI.Root = Root

local userScale = 1
---@type fun()[]
local listeners = {}

---Converts a cursor position (GetCursorPosition) to Root units.
---@return number x, number y
function UI.CursorInRoot()
  local x, y = GetCursorPosition()
  local scale = Root:GetEffectiveScale()
  return x / scale, y / scale
end

local function applyScale()
  local parentScale = UIParent:GetEffectiveScale()
  if not parentScale or parentScale <= 0 then return end
  Root:SetScale(768 / REFERENCE_HEIGHT * userScale / parentScale)
  UI.Pixel.Refresh()
  for _, listener in ipairs(listeners) do listener() end
end

---@param scale number MDT's own scale on top of its screen-relative size, 1 = 100%
function UI.SetUserScale(scale)
  userScale = scale
  applyScale()
end

---Calls listener after every rescale. Root's size in its own units changes with the user scale and the screen's
---aspect ratio, so windows sized in Root units refit here.
---@param listener fun()
function UI.OnRootRescale(listener)
  listeners[#listeners + 1] = listener
end

applyScale()
Root:RegisterEvent("UI_SCALE_CHANGED")
Root:RegisterEvent("DISPLAY_SIZE_CHANGED")
UI.Script(Root, "OnEvent", applyScale)
