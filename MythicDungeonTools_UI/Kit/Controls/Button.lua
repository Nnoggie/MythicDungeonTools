local _, MDT = ...
local UI = MDT.UI
local Theme, Fonts = UI.Theme, UI.Fonts

local ICON_SIZE = 14
local GLYPH_SIZE = 8

local function arrange(self)
  local props = self.kitProps
  local pad = props.variant == "icon" and 0 or Theme.Space("md")
  local left = pad
  self.kitIcon:ClearAllPoints()
  if props.icon then
    local size = props.iconSize or ICON_SIZE
    self.kitIcon:SetSize(size, size)
    local iconOnly = props.variant == "icon" or (props.text == nil or props.text == "") and not props.chevron
    if iconOnly then
      self.kitIcon:SetPoint("CENTER", self, "CENTER", 0, 0)
    else
      self.kitIcon:SetPoint("LEFT", self, "LEFT", left, 0)
      left = left + size + Theme.Space("sm")
    end
    self.kitIcon:Show()
  else
    self.kitIcon:Hide()
  end
  local right = pad
  if props.chevron then
    self.kitChevron:SetPoint("RIGHT", self, "RIGHT", -pad, 0)
    self.kitChevron:Show()
    right = right + GLYPH_SIZE + Theme.Space("sm")
  else
    self.kitChevron:Hide()
  end
  self.kitLabel:ClearAllPoints()
  self.kitLabel:SetPoint("LEFT", self, "LEFT", left, 0)
  self.kitLabel:SetPoint("RIGHT", self, "RIGHT", -right, 0)
  self.kitLabel:SetJustifyH(props.chevron and "LEFT" or props.justify)
  self.kitLabel:SetShown(props.variant ~= "icon" or props.text ~= "")
end

local function onClick(self, button)
  if self.kitProps.disabled then return end
  if button == "RightButton" then
    self:Emit("onRightClick", self)
    return
  end
  local menu = self.kitProps.menu
  if menu then UI.Menu.Open({ anchor = self, items = menu, onClose = self.kitProps.onMenuClose }) end
  self:Emit("onClick", self, button)
end

local Methods = {}
function Methods:GetText() return self.kitProps.text end

---@class MDT.UI.ButtonSpec : MDT.UI.CommonSpec
---@field text string?
---@field icon (string|number)?
---@field iconSize number?
---@field iconColor (MDT.UI.Color|false)? tints the icon; defaults to the skin's text color; false keeps the texture's own colors (spell and ability icons)
---@field iconCoords number[]?
---@field variant MDT.UI.Variant? default "default"
---@field font MDT.UI.FontRole?
---@field justify "LEFT"|"CENTER"|"RIGHT"? default "CENTER"
---@field chevron boolean?
---@field selected boolean?
---@field disabled boolean?
---@field textColor MDT.UI.Color? overrides the skin's text color (pull colors, class colors)
---@field menu (MDT.UI.MenuItem[]|fun(): MDT.UI.MenuItem[])? opens a kit menu below the button on click
---@field onMenuClose fun()?
---@field onClick fun(self: MDT.UI.Control, mouseButton: string)?
---@field onRightClick fun(self: MDT.UI.Control)?
---@field onDragStart fun(self: MDT.UI.Control)? left-button drag; macro and spell icons pick themselves up here
UI.Define({
  name = "Button", frameType = "Button", mixins = { UI.Mixins.Skinned, Methods },
  props = {
    { name = "variant", default = "default", set = function(self, v) self:kitSkinInit(v) arrange(self) end, relayout = true },
    { name = "font", default = "body", set = function(self, v) self.kitLabel:SetFontObject(Fonts.Get(v)) end, relayout = true },
    { name = "text", default = "", set = function(self, v) self.kitLabel:SetText(v) arrange(self) end, relayout = true },
    { name = "justify", default = "CENTER", set = arrange },
    { name = "icon", default = nil, set = function(self, v) if v then self.kitIcon:SetTexture(v) end arrange(self) end, relayout = true },
    { name = "iconSize", default = nil, set = arrange, relayout = true },
    { name = "iconColor", default = nil, set = function(self) self:kitRepaint() end },
    { name = "iconCoords", default = nil, set = function(self, v)
      if v then self.kitIcon:SetTexCoord(unpack(v)) else self.kitIcon:SetTexCoord(0, 1, 0, 1) end
    end },
    { name = "chevron", default = false, set = arrange, relayout = true },
    { name = "selected", default = false, set = function(self) self:kitRepaint() end },
    { name = "disabled", default = false, set = function(self, v) self:SetEnabled(not v) self:kitRepaint() end },
    { name = "textColor", default = nil, set = function(self) self:kitRepaint() end },
    { name = "menu", default = nil },
    { name = "onMenuClose", default = nil },
    { name = "onClick", default = nil },
    { name = "onRightClick", default = nil },
    { name = "onDragStart", default = nil, set = function(self, v) if v then self:RegisterForDrag("LeftButton") else self:RegisterForDrag() end end },
  },
  Create = function(self)
    self:RegisterForClicks("LeftButtonUp", "RightButtonUp")
    self.kitLabel = self:CreateFontString(nil, "ARTWORK")
    self.kitLabel:SetFontObject(Fonts.Get("body"))
    self.kitLabel:SetWordWrap(false)
    self.kitIcon = self:CreateTexture(nil, "ARTWORK")
    self.kitChevron = UI.Glyphs.Create(self, "down", GLYPH_SIZE, "text.muted")
    UI.Script(self, "OnClick", onClick)
    UI.Script(self, "OnDragStart", function(button) button:Emit("onDragStart", button) end)
    self.kitOnRepaint = function(button, row)
      button.kitChevron:SetColor(row.text)
      local iconColor = button.kitProps.iconColor
      if iconColor == false then
        button.kitIcon:SetVertexColor(1, 1, 1, 1)
      else
        button.kitIcon:SetVertexColor(Theme.Resolve(iconColor or row.text))
      end
    end
  end,
  Measure = function(self)
    local props = self.kitProps
    local height = Theme.Size("md")
    if props.variant == "icon" then return height, height end
    local width = Theme.Space("md") * 2 + self.kitLabel:GetUnboundedStringWidth()
    if props.icon then width = width + (props.iconSize or ICON_SIZE) + Theme.Space("sm") end
    if props.chevron then width = width + GLYPH_SIZE + Theme.Space("sm") end
    return math.ceil(width), height
  end,
})

local CLOSE_SIZE, CLOSE_ICON_SIZE = 24, 17

---The one close button: MethodInternal's cross in a square window button, as on the main window.
---@param parent table
---@param spec {onClick: fun(), tooltip: string?}
---@return MDT.UI.Control
function UI.CloseButton(parent, spec)
  return UI.Button(parent, {
    variant = "window", icon = MDT:GetIconPath("close"), iconSize = CLOSE_ICON_SIZE,
    width = CLOSE_SIZE, height = CLOSE_SIZE, tooltip = spec.tooltip, onClick = spec.onClick,
  })
end
