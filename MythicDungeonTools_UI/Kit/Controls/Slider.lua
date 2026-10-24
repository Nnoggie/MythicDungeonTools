local _, MDT = ...
local UI = MDT.UI
local Theme, Fonts = UI.Theme, UI.Fonts

local LABEL_HEIGHT = 14
-- MethodInternal's slider: a bordered track with a tall, thin thumb and no fill.
local TRACK_HEIGHT = 10
local THUMB_WIDTH, THUMB_HEIGHT = 6, 14
local NATURAL_WIDTH = 160

local Methods = {}
function Methods:GetValue() return self.kitProps.value end

local function formatValue(self, value)
  local format = self.kitProps.format
  if type(format) == "function" then return format(value) end
  if type(format) == "string" then return string.format(format, value) end
  if value == math.floor(value) then return tostring(value) end
  return string.format("%.2f", value)
end

local function repaint(self)
  local disabled = self.kitProps.disabled
  Theme.Bind(self.kitLabel, disabled and "text.disabled" or "text.muted")
  Theme.Bind(self.kitValueText, disabled and "text.disabled" or "text.normal")
  Theme.Bind(self.kitThumbTexture, disabled and "text.disabled" or "accent")
  self.kitTrackBorder:SetToken(not disabled and self.kitHovered and "accent.active" or "border.strong")
  self.kitValueText:SetText(formatValue(self, self.kitProps.value or 0))
end

-- The client stores slider values as single floats (a 0.1 step reads back as 1.2000000476837), so values snap to the
-- step and round to its decimals before anyone sees them.
local function snap(self, value)
  local step, min = self.kitProps.step, self.kitProps.min
  if not step or step <= 0 then return value end
  value = math.min(self.kitProps.max, min + math.floor((value - min) / step + 0.5) * step)
  local decimals = 0
  while step * 10 ^ decimals ~= math.floor(step * 10 ^ decimals) and decimals < 6 do decimals = decimals + 1 end
  return tonumber(string.format("%."..decimals.."f", value))
end

local function applyRange(self)
  local props = self.kitProps
  self.kitSlider:SetMinMaxValues(props.min, props.max)
  self.kitSlider:SetValueStep(props.step or 0)
end

local function setValue(self, value)
  value = math.max(self.kitProps.min, math.min(self.kitProps.max, value or self.kitProps.min))
  self.kitProps.value = value
  self.kitSettingValue = true
  self.kitSlider:SetValue(value)
  self.kitSettingValue = nil
  repaint(self)
end

local function arrange(self)
  local label = self.kitProps.label
  self.kitLabel:SetText(label or "")
  self.kitLabel:SetShown(label ~= nil)
  self:InvalidateLayout()
end

---@class MDT.UI.SliderSpec : MDT.UI.CommonSpec
---@field label string?
---@field min number
---@field max number
---@field step number?
---@field value number?
---@field format (string|fun(value: number): string)?
---@field disabled boolean?
---@field onChange fun(value: number, self: MDT.UI.Control)? while dragging
---@field onCommit fun(value: number, self: MDT.UI.Control)? on mouse up
UI.Define({
  name = "Slider", frameType = "Frame", mixins = { Methods },
  props = {
    { name = "label", default = nil, set = arrange, relayout = true },
    { name = "min", default = 0, set = applyRange },
    { name = "max", default = 1, set = applyRange },
    { name = "step", default = nil, set = applyRange },
    { name = "format", default = nil, set = repaint },
    { name = "value", default = 0, set = setValue },
    { name = "disabled", default = false, set = function(self, v) self.kitSlider:SetEnabled(not v) repaint(self) end },
    { name = "onChange", default = nil },
    { name = "onCommit", default = nil },
  },
  Create = function(self)
    self.kitLabel = self:CreateFontString(nil, "ARTWORK")
    self.kitLabel:SetFontObject(Fonts.Get("small"))
    self.kitLabel:SetPoint("TOPLEFT", self, "TOPLEFT", 0, 0)
    self.kitLabel:SetHeight(LABEL_HEIGHT)
    self.kitLabel:SetJustifyH("LEFT")
    self.kitValueText = self:CreateFontString(nil, "ARTWORK")
    self.kitValueText:SetFontObject(Fonts.Get("number"))
    self.kitValueText:SetPoint("TOPRIGHT", self, "TOPRIGHT", 0, 0)
    self.kitValueText:SetHeight(LABEL_HEIGHT)
    self.kitValueText:SetJustifyH("RIGHT")

    -- The slider frame is the track: the thumb is one of its textures, so a separate track frame would cover it.
    self.kitSlider = CreateFrame("Slider", nil, self)
    self.kitSlider:SetOrientation("HORIZONTAL")
    self.kitSlider:SetPoint("BOTTOMLEFT", self, "BOTTOMLEFT", 0, (THUMB_HEIGHT - TRACK_HEIGHT) / 2)
    self.kitSlider:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT", 0, (THUMB_HEIGHT - TRACK_HEIGHT) / 2)
    self.kitSlider:SetHeight(TRACK_HEIGHT)
    self:kitForwardHover(self.kitSlider)
    self.kitSlider:SetObeyStepOnDrag(true)
    local trackBackground = self.kitSlider:CreateTexture(nil, "BACKGROUND")
    trackBackground:SetAllPoints()
    Theme.Bind(trackBackground, "bg.sunken")
    self.kitTrackBorder = UI.Pixel.Border(self.kitSlider, "border.strong")
    self.kitTrack = self.kitSlider
    local thumb = self.kitSlider:CreateTexture(nil, "OVERLAY")
    thumb:SetSize(THUMB_WIDTH, THUMB_HEIGHT)
    self.kitSlider:SetThumbTexture(thumb)
    self.kitThumbTexture = thumb

    UI.Script(self.kitSlider, "OnValueChanged", function(slider, value, userInput)
      if self.kitSettingValue then return end
      value = snap(self, value)
      if value == self.kitProps.value then return end
      self.kitProps.value = value
      repaint(self)
      if userInput then self:Emit("onChange", value, self) end
    end)
    UI.Script(self.kitSlider, "OnMouseUp", function()
      if self.kitProps.disabled then return end
      self:Emit("onCommit", self.kitProps.value, self)
    end)
    self.kitRepaint = repaint
  end,
  Measure = function(self, availW)
    local height = THUMB_HEIGHT
    if self.kitProps.label then height = height + LABEL_HEIGHT + Theme.Space("xs") end
    return self.kitProps.width or math.min(availW, NATURAL_WIDTH), height
  end,
})
