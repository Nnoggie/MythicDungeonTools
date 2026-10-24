local _, MDT = ...
local UI = MDT.UI
local Theme, Fonts = UI.Theme, UI.Fonts

local NATURAL_WIDTH = 76
local ARROW = 18

local Methods = {}
function Methods:GetValue() return self.kitProps.value end
-- Hovering keeps the stepper's frame as it is; the arrow under the cursor lights up instead.
function Methods:kitState() return self.kitProps.disabled and "disabled" or "normal" end

---@param button MDT.UI.Control an arrow
local function paintArrow(button)
  local state = button:IsEnabled() and (button.kitHovered and "accent" or "text.muted") or "text.disabled"
  button.kitGlyph:SetColor(state)
end

local function formatValue(self, value)
  local format = self.kitProps.format
  if format then return format(value) end
  return tostring(value)
end

local function repaint(self)
  local props = self.kitProps
  local disabled = props.disabled
  self.kitValueText:SetText(formatValue(self, props.value))
  Theme.Bind(self.kitValueText, disabled and "text.disabled" or "accent")
  self.kitDown:SetDisabled(disabled or props.value <= props.min)
  self.kitUp:SetDisabled(disabled or props.value >= props.max)
  paintArrow(self.kitDown)
  paintArrow(self.kitUp)
end

local function clamp(self, value)
  return math.max(self.kitProps.min, math.min(self.kitProps.max, value))
end

local function setValue(self, value)
  self.kitProps.value = clamp(self, value or self.kitProps.min)
  repaint(self)
end

local function scheduleCommit(self)
  if self.kitCommitTimer then self.kitCommitTimer:Cancel() end
  self.kitCommitTimer = C_Timer.NewTimer(Theme.data.motion.commitDelay, function()
    self.kitCommitTimer = nil
    if not self.kitReleased then self:Emit("onCommit", self.kitProps.value, self) end
  end)
end

local function stepBy(self, direction)
  if self.kitProps.disabled then return end
  local value = clamp(self, self.kitProps.value + direction * (self.kitProps.step or 1))
  if value == self.kitProps.value then return end
  self.kitProps.value = value
  repaint(self)
  self:Emit("onChange", value, self)
  scheduleCommit(self)
end

---@class MDT.UI.StepperSpec : MDT.UI.CommonSpec
---@field value number
---@field min number
---@field max number
---@field step number? default 1
---@field format fun(value: number): string?
---@field wheel boolean? default true
---@field variant MDT.UI.Variant? default "default"
---@field disabled boolean?
---@field onChange fun(value: number, self: MDT.UI.Control)? every step
---@field onCommit fun(value: number, self: MDT.UI.Control)? after the last step of a burst
---@field onPick fun(self: MDT.UI.Control)? click on the value
UI.Define({
  name = "Stepper", frameType = "Frame", mixins = { UI.Mixins.Skinned, Methods },
  props = {
    { name = "min", default = 0, set = repaint },
    { name = "max", default = 100, set = repaint },
    { name = "step", default = 1 },
    { name = "format", default = nil, set = repaint },
    { name = "wheel", default = true },
    { name = "variant", default = "default", set = function(self, v) self:kitSkinInit(v) end },
    { name = "disabled", default = false, set = repaint },
    { name = "value", default = 0, set = setValue },
    { name = "onChange", default = nil },
    { name = "onCommit", default = nil },
    { name = "onPick", default = nil },
  },
  Create = function(self)
    self:kitSkinInit("default")
    self.kitDown = UI.Button(self, { variant = "bare", onClick = function() stepBy(self, -1) end })
    self.kitDown:SetPoint("TOPLEFT", self, "TOPLEFT", 0, 0)
    self.kitDown:SetPoint("BOTTOMLEFT", self, "BOTTOMLEFT", 0, 0)
    self.kitDown:SetWidth(ARROW)
    self.kitDown.kitGlyph = UI.Glyphs.Create(self.kitDown, "left", 7, "text.muted")
    self.kitDown.kitGlyph:SetPoint("CENTER", self.kitDown, "CENTER", 0, 0)
    self.kitUp = UI.Button(self, { variant = "bare", onClick = function() stepBy(self, 1) end })
    self.kitUp:SetPoint("TOPRIGHT", self, "TOPRIGHT", 0, 0)
    self.kitUp:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT", 0, 0)
    self.kitUp:SetWidth(ARROW)
    self.kitUp.kitGlyph = UI.Glyphs.Create(self.kitUp, "right", 7, "text.muted")
    self.kitUp.kitGlyph:SetPoint("CENTER", self.kitUp, "CENTER", 0, 0)
    for _, arrow in ipairs({ self.kitDown, self.kitUp }) do
      UI.HookScript(arrow, "OnEnter", paintArrow)
      UI.HookScript(arrow, "OnLeave", paintArrow)
    end
    self.kitValue = CreateFrame("Button", nil, self)
    self.kitValue:SetPoint("TOPLEFT", self.kitDown, "TOPRIGHT", 0, 0)
    self.kitValue:SetPoint("BOTTOMRIGHT", self.kitUp, "BOTTOMLEFT", 0, 0)
    UI.Script(self.kitValue, "OnClick", function() if not self.kitProps.disabled then self:Emit("onPick", self) end end)
    self.kitValueText = self.kitValue:CreateFontString(nil, "ARTWORK")
    self.kitValueText:SetFontObject(Fonts.Get("title"))
    self.kitValueText:SetAllPoints()
    self.kitValueText:SetJustifyH("CENTER")
    self:EnableMouseWheel(true)
    UI.Script(self, "OnMouseWheel", function(_, delta) if self.kitProps.wheel then stepBy(self, delta > 0 and 1 or -1) end end)
    self.kitValue:EnableMouseWheel(true)
    self:kitForwardHover(self.kitDown, self.kitUp, self.kitValue)
    UI.Script(self.kitValue, "OnMouseWheel", function(_, delta) if self.kitProps.wheel then stepBy(self, delta > 0 and 1 or -1) end end)
  end,
  OnRelease = function(self)
    if self.kitCommitTimer then
      self.kitCommitTimer:Cancel()
      self.kitCommitTimer = nil
    end
  end,
  Measure = function(self) return self.kitProps.width or NATURAL_WIDTH, Theme.Size("sm") end,
})
