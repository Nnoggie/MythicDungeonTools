local _, MDT = ...
local UI = MDT.UI
local Theme, Fonts, MenuModel = UI.Theme, UI.Fonts, UI.MenuModel

local LABEL_HEIGHT = 14
local NATURAL_WIDTH = 160
local SEARCH_THRESHOLD = 12

local Methods = {}
function Methods:GetValue() return self.kitProps.value end

local function refreshText(self)
  local props = self.kitProps
  local label = MenuModel.LabelFor(props.items, props.value)
  self.kitButton:SetText(label or props.placeholder or "")
  self.kitButton:SetTextColor(not label and "text.disabled" or nil)
end

local function arrange(self)
  local label = self.kitProps.label
  self.kitLabel:SetText(label or "")
  self.kitLabel:SetShown(label ~= nil)
  self.kitButton:SetPoint("TOPLEFT", self, "TOPLEFT", 0, label and -(LABEL_HEIGHT + Theme.Space("xs")) or 0)
  self:InvalidateLayout()
end

local function openMenu(self)
  local props = self.kitProps
  local search = props.search
  if search == nil then search = #props.items > SEARCH_THRESHOLD end
  UI.Menu.Open({
    anchor = self.kitButton, items = props.items, value = props.value, search = search,
    onSelect = function(item)
      if item.kind ~= "choice" or item.value == props.value then return end
      props.value = item.value
      refreshText(self)
      self:Emit("onChange", item.value, item, self)
    end,
  })
end

---@class MDT.UI.DropdownSpec : MDT.UI.CommonSpec
---@field label string?
---@field items MDT.UI.MenuItem[] choice items; UI.MenuModel.FromList builds them from a map
---@field value any?
---@field placeholder string?
---@field search boolean? default: true when more than 12 items
---@field disabled boolean?
---@field onChange fun(value: any, item: MDT.UI.MenuItem, self: MDT.UI.Control)?
UI.Define({
  name = "Dropdown", frameType = "Frame", mixins = { Methods },
  props = {
    { name = "label", default = nil, set = arrange, relayout = true },
    { name = "items", default = {}, set = refreshText },
    { name = "placeholder", default = nil, set = refreshText },
    { name = "value", default = nil, set = refreshText },
    { name = "search", default = nil },
    { name = "disabled", default = false, set = function(self, v) self.kitButton:SetDisabled(v) Theme.Bind(self.kitLabel, v and "text.disabled" or "text.muted") end },
    { name = "onChange", default = nil },
  },
  Create = function(self)
    self.kitLabel = self:CreateFontString(nil, "ARTWORK")
    self.kitLabel:SetFontObject(Fonts.Get("small"))
    self.kitLabel:SetPoint("TOPLEFT", self, "TOPLEFT", 0, 0)
    self.kitLabel:SetHeight(LABEL_HEIGHT)
    self.kitLabel:SetJustifyH("LEFT")
    Theme.Bind(self.kitLabel, "text.muted")
    self.kitButton = UI.Button(self, { variant = "field", chevron = true, justify = "LEFT", onClick = function() openMenu(self) end })
    self.kitButton:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT", 0, 0)
    self.kitButton.kitPersistent = true
    self:kitForwardHover(self.kitButton)
  end,
  OnRelease = function(self)
    self.kitButton:SetText("")
  end,
  Measure = function(self, availW)
    local height = Theme.Size("md")
    if self.kitProps.label then height = height + LABEL_HEIGHT + Theme.Space("xs") end
    return self.kitProps.width or math.min(availW, NATURAL_WIDTH), height
  end,
})
