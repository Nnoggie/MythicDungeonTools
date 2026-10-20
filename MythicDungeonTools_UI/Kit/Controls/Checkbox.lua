local _, MDT = ...
local UI = MDT.UI
local Theme, Fonts = UI.Theme, UI.Fonts

local BOX = 14

local function repaint(self)
  local state = self:kitState()
  local row = Theme.Skin("field", state)
  Theme.Bind(self.kitBoxBackground, row.bg or "bg.sunken")
  self.kitBoxBorder:SetToken(self.kitProps.value and "accent" or row.border or "border.strong")
  Theme.Bind(self.kitLabel, row.text)
  self.kitCheck:SetColor(state == "disabled" and "text.disabled" or "accent")
  self.kitCheck:SetShown(self.kitProps.value == true)
end

---@class MDT.UI.CheckboxSpec : MDT.UI.CommonSpec
---@field label string?
---@field value boolean?
---@field disabled boolean?
---@field onChange fun(value: boolean, self: MDT.UI.Control)?
---@class MDT.UI.CheckboxMethods : MDT.UI.Control
local Methods = {}
function Methods:GetValue() return self.kitProps.value end

UI.Define({
  name = "Checkbox", frameType = "Button", mixins = { Methods },
  props = {
    { name = "label", default = "", set = function(self, v) self.kitLabel:SetText(v) end, relayout = true },
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
    self.kitBoxBorder = UI.Pixel.Border(self.kitBox, "border.strong")
    self.kitCheck = UI.Glyphs.Create(self.kitBox, "check", BOX - 4, "accent")
    self.kitCheck:SetPoint("CENTER", self.kitBox, "CENTER", 0, 0)
    self.kitLabel = self:CreateFontString(nil, "ARTWORK")
    self.kitLabel:SetFontObject(Fonts.Get("body"))
    self.kitLabel:SetPoint("LEFT", self.kitBox, "RIGHT", Theme.Space("sm"), 0)
    self.kitLabel:SetPoint("RIGHT", self, "RIGHT", 0, 0)
    self.kitLabel:SetJustifyH("LEFT")
    self.kitLabel:SetWordWrap(false)
    self.kitRepaint = repaint
    self:SetScript("OnClick", function(button)
      if button.kitProps.disabled then return end
      local value = not button.kitProps.value
      button.kitProps.value = value
      repaint(button)
      button:Emit("onChange", value, button)
    end)
  end,
  Measure = function(self)
    return BOX + Theme.Space("sm") + math.ceil(self.kitLabel:GetUnboundedStringWidth()), Theme.Size("sm")
  end,
})
