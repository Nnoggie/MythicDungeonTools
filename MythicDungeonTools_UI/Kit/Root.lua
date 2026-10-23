local _, MDT = ...
local UI = MDT.UI

-- At 100% MDT scale one MDT unit is one physical pixel on a 1440p screen.
local REFERENCE_HEIGHT = 1440

---The parent of every MDT window, popover, menu and tooltip. It covers the screen and cancels the user's UI scale:
---it is always REFERENCE_HEIGHT / user scale units tall, so MDT covers the same share of the screen at every
---resolution and UI scale. Its size in its own units changes with the MDT scale and the screen's aspect ratio, so
---windows sized in Root units refit from UI.OnRootResized.
local Root = CreateFrame("Frame", "MDTUIRoot", UIParent)
Root:SetAllPoints(UIParent)
UI.Root = Root

local userScale = 1
local resizeListeners = {}

---Calls fn each time the Root settles at a new size in its own units.
---@param fn fun()
---@return fun() unsubscribe
function UI.OnRootResized(fn)
  resizeListeners[#resizeListeners + 1] = fn
  return function()
    for index, listener in ipairs(resizeListeners) do
      if listener == fn then table.remove(resizeListeners, index) return end
    end
  end
end

---Converts a cursor position (GetCursorPosition) to Root units.
---@return number x, number y
function UI.CursorInRoot()
  local x, y = GetCursorPosition()
  local scale = Root:GetEffectiveScale()
  return x / scale, y / scale
end

---Rescales the Root if its effective scale is off target. Once it is on target this does nothing, so the size change
---it causes ends the loop.
---@return boolean rescaled
local function applyScale()
  local target = 768 / REFERENCE_HEIGHT * userScale
  local parentScale = UIParent:GetEffectiveScale()
  if not parentScale or parentScale <= 0 or math.abs(Root:GetEffectiveScale() / target - 1) < 1e-4 then return false end
  Root:SetScale(target / parentScale)
  UI.Pixel.Refresh()
  return true
end

---@param scale any MDT's own scale on top of its screen-relative size, 1 = 100%; anything but a number means 1
---@return number scale the scale SetUserScale applies for it, clamped to 0.5 - 3
function UI.ClampUserScale(scale)
  return type(scale) == "number" and scale == scale and math.min(3, math.max(0.5, scale)) or 1
end

---@param scale any MDT's own scale on top of its screen-relative size, 1 = 100%; anything but a number means 1
---@return number scale the scale applied, clamped to 0.5 - 3
---@return boolean rescaled whether the Root rescaled, so its size change will refit what is sized in Root units
function UI.SetUserScale(scale)
  userScale = UI.ClampUserScale(scale)
  return userScale, applyScale()
end

applyScale()
Root:RegisterEvent("UI_SCALE_CHANGED")
Root:RegisterEvent("DISPLAY_SIZE_CHANGED")
UI.Script(Root, "OnEvent", function()
  -- A new resolution can leave the Root's scale as it is but still changes how big a pixel is.
  if not applyScale() then UI.Pixel.Refresh() end
end)
-- Addons such as ElvUI rescale UIParent without UI_SCALE_CHANGED; the Root's size changes with it. Re-applying the
-- scale changes the size again, so listeners wait for that next, settled size.
UI.Script(Root, "OnSizeChanged", function()
  if applyScale() then return end
  for _, fn in ipairs({ unpack(resizeListeners) }) do UI.Call(fn) end
end)
