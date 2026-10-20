local _, MDT = ...
local UI = MDT.UI
local Theme, Fonts = UI.Theme, UI.Fonts

local function applyText(self)
  local props = self.kitProps
  if props.userText then
    Fonts.SetUserText(self.kitLabel, props.text or "", props.font)
  else
    self.kitLabel:SetFontObject(Fonts.Get(props.font))
    self.kitLabel:SetText(props.text or "")
  end
  self:InvalidateLayout()
end

local function measureText(self, availW)
  local label = self.kitLabel
  if self.kitProps.wrap then
    label:SetWidth(availW)
    return math.min(availW, math.ceil(label:GetWrappedWidth())), label:GetStringHeight()
  end
  label:SetWidth(0)
  return label:GetStringWidth(), label:GetStringHeight()
end

local TextMethods = {}

---Wraps at the placed width, which a stack stretches past the measured one, so justify uses the whole frame.
function TextMethods:kitPlaced()
  if self.kitProps.wrap then self.kitLabel:SetWidth(self:GetWidth()) end
end

---@class MDT.UI.TextSpec : MDT.UI.CommonSpec
---@field text string?
---@field font MDT.UI.FontRole? default "body"
---@field color MDT.UI.Color? default "text.normal"
---@field wrap boolean? default true
---@field justify "LEFT"|"CENTER"|"RIGHT"?
---@field userText boolean? route names and other user-authored strings: swaps to a fallback font when the client font lacks the glyphs
UI.Define({
  name = "Text", frameType = "Frame", mixins = { TextMethods },
  props = {
    { name = "font", default = "body", set = applyText, relayout = true },
    { name = "userText", default = false, set = applyText, relayout = true },
    { name = "text", default = "", set = applyText, relayout = true },
    { name = "color", default = "text.normal", set = function(self, v) Theme.Bind(self.kitLabel, v) end },
    { name = "wrap", default = true, set = function(self, v) self.kitLabel:SetWordWrap(v) end, relayout = true },
    { name = "justify", default = "LEFT", set = function(self, v) self.kitLabel:SetJustifyH(v) end },
  },
  Create = function(self)
    self.kitLabel = self:CreateFontString(nil, "ARTWORK")
    self.kitLabel:SetFontObject(Fonts.Get("body"))
    self.kitLabel:SetPoint("TOPLEFT", self, "TOPLEFT", 0, 0)
    self.kitLabel:SetJustifyV("TOP")
  end,
  Measure = measureText,
})

---@class MDT.UI.HeadingSpec : MDT.UI.CommonSpec
---@field text string?
---@field font MDT.UI.FontRole? default "heading"
---@field color MDT.UI.Color? default "text.normal"
UI.Define({
  name = "Heading", frameType = "Frame",
  props = {
    { name = "font", default = "heading", set = applyText, relayout = true },
    { name = "text", default = "", set = applyText, relayout = true },
    { name = "color", default = "text.normal", set = function(self, v) Theme.Bind(self.kitLabel, v) end },
  },
  Create = function(self)
    self.kitLabel = self:CreateFontString(nil, "ARTWORK")
    self.kitLabel:SetFontObject(Fonts.Get("heading"))
    self.kitLabel:SetPoint("TOPLEFT", self, "TOPLEFT", 0, 0)
    self.kitLabel:SetJustifyH("LEFT")
    self.kitLabel:SetJustifyV("TOP")
    self.kitLabel:SetWordWrap(false)
    self.kitRule = UI.Pixel.Border(self, "border.divider", { "bottom" })
  end,
  Measure = function(self, availW)
    self.kitLabel:SetWidth(availW)
    return availW, self.kitLabel:GetStringHeight() + Theme.Space("sm")
  end,
})
