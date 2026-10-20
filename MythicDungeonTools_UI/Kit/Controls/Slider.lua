local _, MDT = ...
local UI = MDT.UI
local Theme, Fonts = UI.Theme, UI.Fonts

local LABEL_HEIGHT = 14
local TRACK_HEIGHT = 6
local THUMB = 10
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
  Theme.Bind(self.kitFill, disabled and "border.strong" or "accent.border")
  self.kitValueText:SetText(formatValue(self, self.kitProps.value or 0))
end

local function updateFill(self)
  local min, max = self.kitSlider:GetMinMaxValues()
  local span = max - min
  local fraction = span > 0 and (self.kitSlider:GetValue() - min) / span or 0
  self.kitFill:SetWidth(math.max(0.01, self.kitSlider:GetWidth() * fraction))
end

local function applyRange(self)
  local props = self.kitProps
  self.kitSlider:SetMinMaxValues(props.min, props.max)
  self.kitSlider:SetValueStep(props.step or 0)
  updateFill(self)
end

local function setValue(self, value)
  value = math.max(self.kitProps.min, math.min(self.kitProps.max, value or self.kitProps.min))
  self.kitProps.value = value
  self.kitSettingValue = true
  self.kitSlider:SetValue(value)
  self.kitSettingValue = nil
  updateFill(self)
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

    self.kitSlider = CreateFrame("Slider", nil, self)
    self.kitSlider:SetOrientation("HORIZONTAL")
    self.kitSlider:SetPoint("BOTTOMLEFT", self, "BOTTOMLEFT", THUMB / 2, 0)
    self.kitSlider:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT", -THUMB / 2, 0)
    self.kitSlider:SetHeight(THUMB + 4)
    self.kitSlider:SetObeyStepOnDrag(true)
    local track = CreateFrame("Frame", nil, self.kitSlider)
    track:SetPoint("LEFT", self.kitSlider, "LEFT", 0, 0)
    track:SetPoint("RIGHT", self.kitSlider, "RIGHT", 0, 0)
    track:SetHeight(TRACK_HEIGHT)
    local trackBackground = track:CreateTexture(nil, "BACKGROUND")
    trackBackground:SetAllPoints()
    Theme.Bind(trackBackground, "bg.sunken")
    UI.Pixel.Border(track, "border.strong")
    self.kitFill = track:CreateTexture(nil, "ARTWORK")
    self.kitFill:SetPoint("TOPLEFT", track, "TOPLEFT", 0, 0)
    self.kitFill:SetPoint("BOTTOMLEFT", track, "BOTTOMLEFT", 0, 0)
    local thumb = self.kitSlider:CreateTexture(nil, "OVERLAY")
    thumb:SetSize(THUMB, THUMB)
    self.kitSlider:SetThumbTexture(thumb)
    self.kitThumbTexture = thumb

    self.kitSlider:SetScript("OnValueChanged", function(slider, value, userInput)
      if self.kitSettingValue then return end
      self.kitProps.value = value
      updateFill(self)
      repaint(self)
      if userInput then self:Emit("onChange", value, self) end
    end)
    self.kitSlider:SetScript("OnMouseUp", function()
      if self.kitProps.disabled then return end
      self:Emit("onCommit", self.kitProps.value, self)
    end)
    self.kitSlider:SetScript("OnSizeChanged", function() updateFill(self) end)
    self.kitRepaint = repaint
  end,
  Measure = function(self, availW)
    local height = THUMB + 4
    if self.kitProps.label then height = height + LABEL_HEIGHT + Theme.Space("xs") end
    return self.kitProps.width or math.min(availW, NATURAL_WIDTH), height
  end,
})
