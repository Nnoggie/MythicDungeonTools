local _, MDT = ...
local UI = MDT.UI
local Theme, Fonts = UI.Theme, UI.Fonts

local INSET = 4

local Methods = {}
---@return MDT.UI.RGBA
function Methods:GetColor() return self.kitProps.color end

local function paintSwatch(self)
  Theme.Bind(self.kitSwatch, self.kitProps.color)
  self.kitSwatch:SetAlpha(self.kitProps.disabled and Theme.data.alpha.disabled or 1)
end

local function arrange(self)
  local label = self.kitProps.label
  self.kitLabel:SetText(label or "")
  self.kitLabel:SetShown(label ~= nil)
  self:InvalidateLayout()
end

---The token of the swatch that opened the shared picker last. Callbacks from an older open, or after release, are ignored.
local pickerToken

local function openPicker(self)
  if self.kitProps.disabled then return end
  local color = self.kitProps.color
  local previous = { color[1], color[2], color[3], color[4] or 1 }
  local hasAlpha = self.kitProps.hasAlpha
  local token = {}
  self.kitPickerToken, pickerToken = token, token
  local function apply(r, g, b, a)
    if self.kitPickerToken ~= token then return end
    self:SetColor({ r, g, b, a })
    self:Emit("onChange", r, g, b, a, self)
  end
  ColorPickerFrame:SetupColorPickerAndShow({
    r = color[1], g = color[2], b = color[3], opacity = color[4] or 1, hasOpacity = hasAlpha,
    swatchFunc = function()
      local r, g, b = ColorPickerFrame:GetColorRGB()
      apply(r, g, b, hasAlpha and ColorPickerFrame:GetColorAlpha() or 1)
    end,
    opacityFunc = function()
      local r, g, b = ColorPickerFrame:GetColorRGB()
      apply(r, g, b, ColorPickerFrame:GetColorAlpha())
    end,
    cancelFunc = function() apply(previous[1], previous[2], previous[3], previous[4]) end,
  })
end

---@class MDT.UI.ColorSwatchSpec : MDT.UI.CommonSpec
---@field color MDT.UI.RGBA
---@field hasAlpha boolean?
---@field label string?
---@field disabled boolean?
---@field onChange fun(r: number, g: number, b: number, a: number, self: MDT.UI.Control)?
UI.Define({
  name = "ColorSwatch", frameType = "Button", mixins = { UI.Mixins.Skinned, Methods },
  props = {
    { name = "color", default = { 1, 1, 1, 1 }, set = paintSwatch },
    { name = "hasAlpha", default = false },
    { name = "label", default = nil, set = arrange, relayout = true },
    { name = "disabled", default = false, set = function(self, v) self:SetEnabled(not v) self:kitRepaint() paintSwatch(self) end },
    { name = "onChange", default = nil },
  },
  Create = function(self)
    self.kitWell = CreateFrame("Frame", nil, self)
    self.kitWell:SetPoint("TOPLEFT", self, "TOPLEFT", 0, 0)
    self.kitWell:SetSize(Theme.Size("md"), Theme.Size("md"))
    self.kitWellBackground = self.kitWell:CreateTexture(nil, "BACKGROUND")
    self.kitWellBackground:SetAllPoints()
    Theme.Bind(self.kitWellBackground, "bg.sunken")
    self.kitWellBorder = UI.Pixel.Border(self.kitWell, "border.strong")
    self.kitSwatch = self.kitWell:CreateTexture(nil, "ARTWORK")
    self.kitSwatch:SetPoint("TOPLEFT", self.kitWell, "TOPLEFT", INSET, -INSET)
    self.kitSwatch:SetPoint("BOTTOMRIGHT", self.kitWell, "BOTTOMRIGHT", -INSET, INSET)
    self.kitLabel = self:CreateFontString(nil, "ARTWORK")
    self.kitLabel:SetFontObject(Fonts.Get("body"))
    self.kitLabel:SetPoint("LEFT", self.kitWell, "RIGHT", Theme.Space("sm"), 0)
    self.kitLabel:SetPoint("RIGHT", self, "RIGHT", 0, 0)
    self.kitLabel:SetJustifyH("LEFT")
    self.kitLabel:SetWordWrap(false)
    self:kitSkinInit("ghost")
    self.kitOnRepaint = function(swatch, row) swatch.kitWellBorder:SetToken(row.border or (swatch.kitHovered and "accent" or "border.strong")) end
    UI.Script(self, "OnClick", openPicker)
  end,
  OnRelease = function(self)
    local owned = self.kitPickerToken ~= nil and self.kitPickerToken == pickerToken
    self.kitPickerToken = nil
    if owned and ColorPickerFrame:IsShown() then ColorPickerFrame:Hide() end
  end,
  Measure = function(self)
    local size = Theme.Size("md")
    if self.kitProps.label then return size + Theme.Space("sm") + math.ceil(self.kitLabel:GetUnboundedStringWidth()), size end
    return size, size
  end,
})
