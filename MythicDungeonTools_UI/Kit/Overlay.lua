local _, MDT = ...
local UI = MDT.UI

---One hidden catcher frame sits in UISpecialFrames. Each Escape press hides it once, which pops exactly the top entry.
---@class MDT.UI.EscapeApi
local Escape = {}
UI.Escape = Escape

---@class MDT.UI.EscapeEntry
---@field close fun() must remove the entry, directly or through the owner's close path

---@type MDT.UI.EscapeEntry[]
local stack = {}
local suppress = false
local catcher = CreateFrame("Frame", "MDTEscapeCatcher", UIParent)
catcher:Hide()
tinsert(UISpecialFrames, "MDTEscapeCatcher")

UI.Script(catcher, "OnHide", function()
  if suppress then return end
  local top = stack[#stack]
  if top then top.close() end
  if #stack > 0 then
    C_Timer.After(0, function()
      if #stack > 0 and not catcher:IsShown() then catcher:Show() end
    end)
  end
end)

---Idempotent: an entry already on the stack moves to the top.
---@param entry MDT.UI.EscapeEntry
function Escape.Push(entry)
  for i = #stack, 1, -1 do
    if stack[i] == entry then table.remove(stack, i) end
  end
  stack[#stack + 1] = entry
  catcher:Show()
end

---Idempotent: removing an absent entry is a no-op.
---@param entry MDT.UI.EscapeEntry
function Escape.Remove(entry)
  for i = #stack, 1, -1 do
    if stack[i] == entry then table.remove(stack, i) end
  end
  if #stack == 0 then
    suppress = true
    catcher:Hide()
    suppress = false
  end
end

---@return MDT.UI.EscapeEntry?
function Escape.Top() return stack[#stack] end

---@return integer
function Escape.Depth() return #stack end

---Popovers, menus and dialogs share one host: a stack of entries, one click-outside catcher, placement helpers.
---@class MDT.UI.OverlayApi
local Overlay = {}
UI.Overlay = Overlay

---@class MDT.UI.OverlayEntry
---@field frame table
---@field kind "popover"|"menu"|"dialog"
---@field onDismiss fun(reason: string)?
---@field submenu boolean? menus stack under their parent menu instead of replacing it
---@field escape MDT.UI.EscapeEntry?

---@type MDT.UI.OverlayEntry[]
local entries = {}

local clickCatcher = CreateFrame("Button", nil, UIParent)
clickCatcher:SetAllPoints(UIParent)
clickCatcher:SetFrameStrata("FULLSCREEN_DIALOG")
clickCatcher:SetFrameLevel(50)
clickCatcher:EnableMouse(true)
clickCatcher:RegisterForClicks("LeftButtonDown", "RightButtonDown", "MiddleButtonDown")
clickCatcher:Hide()

local function floatingCount()
  local count = 0
  for _, entry in ipairs(entries) do
    if entry.kind ~= "dialog" then count = count + 1 end
  end
  return count
end

local function updateCatcher()
  clickCatcher:SetShown(floatingCount() > 0)
end

UI.Script(clickCatcher, "OnClick", function()
  for i = #entries, 1, -1 do
    if entries[i].kind ~= "dialog" then
      while i > 1 and entries[i].submenu and entries[i - 1].kind == "menu" do i = i - 1 end
      Overlay.Pop(entries[i], "outside")
      return
    end
  end
end)

---Pins a frame to a strata so reparenting cannot move it. The client ignores SetFrameStrata while the strata is fixed.
---@param frame table
---@param strata string
function Overlay.SetStrata(frame, strata)
  frame:SetFixedFrameStrata(false)
  frame:SetFrameStrata(strata)
  frame:SetFixedFrameStrata(true)
end

---@param entry MDT.UI.OverlayEntry
function Overlay.Push(entry)
  if entry.kind == "popover" then
    Overlay.PopAll("popover", "replaced")
    Overlay.PopAll("menu", "replaced")
  elseif entry.kind == "menu" and not entry.submenu then
    Overlay.PopAll("menu", "replaced")
  end
  entries[#entries + 1] = entry
  if entry.kind ~= "dialog" then
    Overlay.SetStrata(entry.frame, "FULLSCREEN_DIALOG")
    entry.frame:SetFrameLevel(clickCatcher:GetFrameLevel() + 10 * floatingCount())
  end
  entry.escape = { close = function() Overlay.Pop(entry, "escape") end }
  Escape.Push(entry.escape)
  updateCatcher()
end

---Idempotent. Pops everything above the entry first, so a submenu closes with its parent. onDismiss runs once.
---@param entry MDT.UI.OverlayEntry
---@param reason string
function Overlay.Pop(entry, reason)
  local index
  for i, existing in ipairs(entries) do
    if existing == entry then index = i end
  end
  if not index then return end
  for i = #entries, index + 1, -1 do Overlay.Pop(entries[i], reason) end
  table.remove(entries, index)
  Escape.Remove(entry.escape)
  updateCatcher()
  if entry.onDismiss then entry.onDismiss(reason) end
end

---Pops every entry stacked above `entry`, leaving `entry` open.
---@param entry MDT.UI.OverlayEntry
---@param reason string
function Overlay.PopAbove(entry, reason)
  for i = #entries, 1, -1 do
    if entries[i] == entry then return end
    Overlay.Pop(entries[i], reason)
  end
end

---@param kind ("popover"|"menu"|"dialog")? nil pops every entry
---@param reason string?
function Overlay.PopAll(kind, reason)
  for i = #entries, 1, -1 do
    local entry = entries[i]
    if entry and (not kind or entry.kind == kind) then Overlay.Pop(entry, reason or "api") end
  end
end

---@param kind ("popover"|"menu"|"dialog")?
---@return MDT.UI.OverlayEntry?
function Overlay.Top(kind)
  for i = #entries, 1, -1 do
    if not kind or entries[i].kind == kind then return entries[i] end
  end
  return nil
end

---@return boolean
function Overlay.IsOpen(frame)
  for _, entry in ipairs(entries) do
    if entry.frame == frame then return true end
  end
  return false
end

local function toRoot(region, value)
  return value * region:GetEffectiveScale() / UI.Root:GetEffectiveScale()
end

---Puts `frame` at a fixed spot.
---@param frame table
---@param place MDT.UI.Place
function Overlay.SetPlace(frame, place)
  frame:ClearAllPoints()
  frame:SetPoint(place.point, place.relativeTo, place.relativePoint or place.point, place.x or 0, place.y or 0)
end

---Anchor-relative placement in Root coordinates with flipping and clamping to the screen.
---@param frame table
---@param anchor table
---@param prefer "below"|"above"|"right"|"left"?
---@param gap number?
function Overlay.Place(frame, anchor, prefer, gap)
  gap = gap or 0
  local screenW, screenH = UI.Root:GetWidth(), UI.Root:GetHeight()
  local left, right = toRoot(anchor, anchor:GetLeft() or 0), toRoot(anchor, anchor:GetRight() or 0)
  local top, bottom = toRoot(anchor, anchor:GetTop() or 0), toRoot(anchor, anchor:GetBottom() or 0)
  local w, h = frame:GetWidth(), frame:GetHeight()
  local x, y
  prefer = prefer or "below"
  if prefer == "below" or prefer == "above" then
    x = left
    local below = bottom - gap - h
    local above = top + gap
    if prefer == "below" then
      y = below >= 0 and below or above
    else
      y = above + h <= screenH and above or below
    end
  else
    y = top - h
    local toRight = right + gap
    local toLeft = left - gap - w
    if prefer == "right" then
      x = toRight + w <= screenW and toRight or toLeft
    else
      x = toLeft >= 0 and toLeft or toRight
    end
  end
  x = math.max(0, math.min(screenW - w, x))
  y = math.max(0, math.min(screenH - h, y))
  frame:ClearAllPoints()
  frame:SetPoint("BOTTOMLEFT", UI.Root, "BOTTOMLEFT", x, y)
end

---Places the frame's top-left corner at the cursor, clamped to the screen.
---@param frame table
function Overlay.PlaceAtCursor(frame)
  local x, y = UI.CursorInRoot()
  local screenW, screenH = UI.Root:GetWidth(), UI.Root:GetHeight()
  x = math.max(0, math.min(screenW - frame:GetWidth(), x))
  y = math.max(frame:GetHeight(), math.min(screenH, y))
  frame:ClearAllPoints()
  frame:SetPoint("TOPLEFT", UI.Root, "BOTTOMLEFT", x, y)
end
