local _, MDT = ...
local UI = MDT.UI
local Theme = UI.Theme

local TRACK_WIDTH = 8
local WHEEL_STEP = 40
local BAR_RESERVE = TRACK_WIDTH + Theme.Space("xs")

---@class MDT.UI.ScrollbarMethods : MDT.UI.Control
local ScrollbarMethods = {}

---@param viewH number
---@param contentH number
function ScrollbarMethods:SetRange(viewH, contentH)
  self.kitViewH, self.kitContentH = math.max(1, viewH), math.max(1, contentH)
  -- Sizes read back through a fractional effective scale carry float noise (219 reads as 218.99999999999991).
  local fits = contentH - viewH < 0.01
  self:SetShown(not fits)
  local trackH = self:GetHeight()
  local thumbH = fits and trackH or math.max(16, trackH * viewH / contentH)
  self.kitThumb:SetHeight(math.min(trackH, thumbH))
  self:SetValue(self.kitValue)
end

---@param value number
---@param fromUser boolean?
function ScrollbarMethods:SetValue(value, fromUser)
  local maxValue = math.max(0, self.kitContentH - self.kitViewH)
  value = math.max(0, math.min(maxValue, value))
  self.kitValue = value
  local travel = self:GetHeight() - self.kitThumb:GetHeight()
  local fraction = maxValue > 0 and value / maxValue or 0
  self.kitThumb:SetPoint("TOPLEFT", self, "TOPLEFT", 0, -travel * fraction)
  if fromUser then self:Emit("onChange", value, self) end
end

function ScrollbarMethods:GetValue() return self.kitValue end

local function thumbDrag(bar)
  if not bar.kitDrag then return end
  local _, cursorY = GetCursorPosition()
  local travel = bar:GetHeight() - bar.kitThumb:GetHeight()
  if travel <= 0 then return end
  local moved = bar.kitDrag.startY - cursorY / bar:GetEffectiveScale()
  bar:SetValue(bar.kitDrag.startValue + moved / travel * (bar.kitContentH - bar.kitViewH), true)
end

---@class MDT.UI.ScrollbarSpec : MDT.UI.CommonSpec
---@field onChange fun(offset: number, self: MDT.UI.Control)?

---Plain track and thumb. Shared by Scroll, multiline EditBox and List.
UI.Define({
  name = "Scrollbar", frameType = "Frame", mixins = { ScrollbarMethods },
  props = { { name = "onChange", default = nil } },
  Create = function(self)
    self:SetWidth(TRACK_WIDTH)
    self:EnableMouse(true)
    self.kitTrack = self:CreateTexture(nil, "BACKGROUND")
    self.kitTrack:SetAllPoints()
    Theme.Bind(self.kitTrack, "bg.sunken")
    self.kitThumb = CreateFrame("Button", nil, self)
    self.kitThumb:SetPoint("TOPLEFT", self, "TOPLEFT", 0, 0)
    self.kitThumb:SetWidth(TRACK_WIDTH)
    self.kitThumbTexture = self.kitThumb:CreateTexture(nil, "ARTWORK")
    self.kitThumbTexture:SetAllPoints()
    Theme.Bind(self.kitThumbTexture, "border.strong")
    self.kitViewH, self.kitContentH, self.kitValue = 1, 1, 0
    UI.Script(self.kitThumb, "OnEnter", function() Theme.Bind(self.kitThumbTexture, "text.muted") end)
    UI.Script(self.kitThumb, "OnLeave", function() Theme.Bind(self.kitThumbTexture, "border.strong") end)
    UI.Script(self.kitThumb, "OnMouseDown", function()
      local _, cursorY = GetCursorPosition()
      self.kitDrag = { startY = cursorY / self:GetEffectiveScale(), startValue = self.kitValue }
      UI.Script(self, "OnUpdate", thumbDrag)
    end)
    UI.Script(self.kitThumb, "OnMouseUp", function()
      self.kitDrag = nil
      UI.Script(self, "OnUpdate", nil)
    end)
    UI.Script(self, "OnMouseDown", function()
      local _, cursorY = GetCursorPosition()
      local aboveThumb = cursorY / self:GetEffectiveScale() > self.kitThumb:GetTop()
      self:SetValue(self.kitValue + (aboveThumb and -1 or 1) * self.kitViewH, true)
    end)
  end,
  OnRelease = function(self)
    self.kitDrag = nil
    UI.Script(self, "OnUpdate", nil)
  end,
  Measure = function(self) return TRACK_WIDTH, self:GetHeight() end,
})

---@class MDT.UI.ScrollMethods : MDT.UI.Control
local ScrollMethods = {}

function ScrollMethods:GetOffset() return self.kitViewport:GetVerticalScroll() end

---@param offset number
function ScrollMethods:SetOffset(offset)
  local maxOffset = math.max(0, self.content:GetHeight() - self.kitViewport:GetHeight())
  offset = math.max(0, math.min(maxOffset, offset))
  self.kitViewport:SetVerticalScroll(offset)
  self.kitBar:SetValue(offset)
end

---@param child table
function ScrollMethods:ScrollToChild(child)
  local contentTop, childTop = self.content:GetTop(), child:GetTop()
  if not contentTop or not childTop then return end
  local top = contentTop - childTop
  local offset, viewH = self:GetOffset(), self.kitViewport:GetHeight()
  if top < offset then
    self:SetOffset(top)
  elseif top + child:GetHeight() > offset + viewH then
    self:SetOffset(top + child:GetHeight() - viewH)
  end
end

function ScrollMethods:kitPlaced() self:kitUpdateRange() end

-- The view size comes from the scroll's own size: the client can still report the viewport's old size while the
-- scroll's OnSizeChanged runs, and a content width of 0 collapses every child for good.
function ScrollMethods:kitUpdateRange()
  local viewW = self:GetWidth() - BAR_RESERVE
  if viewW > 0 and math.abs(self.content:GetWidth() - viewW) > 0.01 then
    self.content:SetWidth(viewW)
    UI.Layout.Invalidate(self.content)
  end
  self.kitBar:SetRange(self:GetHeight(), self.content:GetHeight())
  self:SetOffset(self:GetOffset())
end

---@class MDT.UI.ScrollSpec : MDT.UI.CommonSpec
---@field gap MDT.UI.Space|number? gap of the content Stack
---@field padding MDT.UI.Space|number? padding of the content Stack

---A viewport around a content Stack. Add children to `scroll.content`.
UI.Define({
  name = "Scroll", frameType = "Frame", mixins = { ScrollMethods },
  props = {
    { name = "gap", default = "sm", set = function(self, v) self.content:SetGap(v) end },
    { name = "padding", default = nil, set = function(self, v) self.content:SetPadding(v) end },
  },
  Create = function(self)
    self.kitViewport = CreateFrame("ScrollFrame", nil, self)
    self.kitViewport:SetPoint("TOPLEFT", self, "TOPLEFT", 0, 0)
    self.kitViewport:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT", -BAR_RESERVE, 0)
    self.kitViewport:SetClipsChildren(true)
    self.content = UI.Stack(self.kitViewport, {})
    self.content:SetPoint("TOPLEFT", self.kitViewport, "TOPLEFT", 0, 0)
    self.kitViewport:SetScrollChild(self.content)
    self.kitBar = UI.Scrollbar(self, { onChange = function(offset) self:SetOffset(offset) end })
    self.kitBar:SetPoint("TOPRIGHT", self, "TOPRIGHT", 0, 0)
    self.kitBar:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT", 0, 0)
    self.kitViewport:EnableMouseWheel(true)
    UI.Script(self.kitViewport, "OnMouseWheel", function(_, delta) self:SetOffset(self:GetOffset() - delta * WHEEL_STEP) end)
    UI.Script(self, "OnSizeChanged", function() self:kitUpdateRange() end)
    -- A scroll built inside a hidden section gets its size when the section first shows.
    UI.Script(self, "OnShow", function() self:kitUpdateRange() end)
    UI.HookScript(self.content, "OnSizeChanged", function() self:kitUpdateRange() end)
  end,
  OnRelease = function(self)
    self.content:ReleaseChildren()
    self:SetOffset(0)
  end,
  Measure = function(self, availW) return self.kitProps.width or availW, self:GetHeight() end,
})
