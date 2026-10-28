local _, MDT = ...
local UI = MDT.UI
local Theme, Fonts = UI.Theme, UI.Fonts

-- MethodInternal's checkbox: a square box whose border lights up on hover or when checked, filled with a solid square.
local BOX = 18
local FILL = 10
local DISABLED_ALPHA = 0.5

local function repaint(self)
  local checked = self.kitProps.value == true
  self.kitBoxBorder:SetToken((checked or self.kitHovered) and "accent.active" or "border.strong")
  self.kitFill:SetShown(checked)
  self:SetAlpha(self.kitProps.disabled and DISABLED_ALPHA or 1)
end

local function applyLabel(self)
  local props = self.kitProps
  if props.userText then
    Fonts.SetUserText(self.kitLabel, props.label or "", "body")
  else
    self.kitLabel:SetFontObject(Fonts.Get("body"))
    self.kitLabel:SetText(props.label or "")
  end
end

---@class MDT.UI.CheckboxSpec : MDT.UI.CommonSpec
---@field label string?
---@field userText boolean? a route name or other user-authored label: swaps to a fallback font when the client font lacks the glyphs
---@field value boolean?
---@field disabled boolean?
---@field onChange fun(value: boolean, self: MDT.UI.Control)?
---@class MDT.UI.CheckboxMethods : MDT.UI.Control
local Methods = {}
function Methods:GetValue() return self.kitProps.value end

UI.Define({
  name = "Checkbox", frameType = "Button", mixins = { Methods },
  props = {
    { name = "userText", default = false, set = applyLabel, relayout = true },
    { name = "label", default = "", set = applyLabel, relayout = true },
    { name = "value", default = false, set = repaint },
    { name = "disabled", default = false, set = function(self, v) self:SetEnabled(not v) repaint(self) end },
    { name = "onChange", default = nil },
  },
  Create = function(self)
    self.kitBox = CreateFrame("Frame", nil, self)
    self.kitBox:SetSize(BOX, BOX)
    self.kitBox:SetPoint("LEFT", self, "LEFT", 0, 0)
    self.kitBoxBackground = self.kitBox:CreateTexture(nil, "BACKGROUND")
    self.kitBoxBackground:SetAllPoints()
    Theme.Bind(self.kitBoxBackground, "bg.sunken")
    self.kitBoxBorder = UI.Pixel.Border(self.kitBox, "border.strong")
    self.kitFill = self.kitBox:CreateTexture(nil, "ARTWORK")
    self.kitFill:SetSize(FILL, FILL)
    self.kitFill:SetPoint("CENTER", self.kitBox, "CENTER", 0, 0)
    Theme.Bind(self.kitFill, "accent")
    self.kitLabel = self:CreateFontString(nil, "ARTWORK")
    self.kitLabel:SetFontObject(Fonts.Get("body"))
    Theme.Bind(self.kitLabel, "text.normal")
    self.kitLabel:SetPoint("LEFT", self.kitBox, "RIGHT", Theme.Space("sm"), 0)
    self.kitLabel:SetJustifyH("LEFT")
    self.kitLabel:SetWordWrap(true)
    self.kitRepaint = repaint
    UI.Script(self, "OnClick", function(button)
      if button.kitProps.disabled then return end
      local value = not button.kitProps.value
      button.kitProps.value = value
      repaint(button)
      button:Emit("onChange", value, button)
    end)
  end,
  Measure = function(self, availW)
    local labelLeft = BOX + Theme.Space("sm")
    local labelWidth = math.max(1, math.min(math.ceil(self.kitLabel:GetUnboundedStringWidth()), availW - labelLeft))
    self.kitLabel:SetWidth(labelWidth)
    return labelLeft + labelWidth, math.max(Theme.Size("sm"), math.ceil(self.kitLabel:GetStringHeight()))
  end,
})
