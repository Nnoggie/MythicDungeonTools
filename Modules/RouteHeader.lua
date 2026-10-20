local _, MDT = ...
local L = MDT.L
local UI = MDT.UI
local Theme, Fonts, Model = UI.Theme, UI.Fonts, MDT.SidebarModel

local CHEVRON = 8
local PILL_HEIGHT = 16
local POPOVER_WIDTH = 243
local LEVEL_COLUMNS = 7
local MIN_LEVEL, MAX_LEVEL = 1, 35

local function arrange(self)
  local props = self.kitProps
  local pad = Theme.Space("md")
  local hasAuthor = props.author ~= nil and props.author ~= ""
  self.kitAuthor:SetShown(hasAuthor)
  self.kitSlash:SetShown(hasAuthor)
  if hasAuthor then
    Fonts.SetUserText(self.kitAuthor, props.author, "body")
    Theme.Bind(self.kitAuthor, props.authorColor or "text.secondary")
  end
  Fonts.SetUserText(self.kitRoute, props.route or "", "body")
  self.kitRoute:ClearAllPoints()
  if hasAuthor then
    self.kitRoute:SetPoint("LEFT", self.kitSlash, "RIGHT", Theme.Space("xs"), 0)
  else
    self.kitRoute:SetPoint("LEFT", self, "LEFT", pad, 0)
  end
  self.kitPill:SetShown(props.live == true)
  local rightEdge = props.live and self.kitPill or self.kitChevron
  self.kitRoute:SetPoint("RIGHT", rightEdge, "LEFT", -Theme.Space("sm"), 0)
end

---@class MDT.RouteSwitcherSpec : MDT.UI.CommonSpec
---@field author string?
---@field authorColor MDT.UI.RGBA?
---@field route string?
---@field live boolean?
---@field onClick fun(self: MDT.UI.Control)?

---The route title button: class-colored author, " / ", route name, a LIVE pill and a chevron.
UI.Define({
  name = "RouteSwitcher", frameType = "Button", mixins = { UI.Mixins.Skinned },
  props = {
    { name = "author", default = nil, set = arrange },
    { name = "authorColor", default = nil, set = arrange },
    { name = "route", default = "", set = arrange },
    { name = "live", default = false, set = arrange },
    { name = "onClick", default = nil },
  },
  Create = function(self)
    local pad = Theme.Space("md")
    self:kitSkinInit("icon")
    self.kitAuthor = self:CreateFontString(nil, "ARTWORK")
    self.kitAuthor:SetFontObject(Fonts.Get("body"))
    self.kitAuthor:SetPoint("LEFT", self, "LEFT", pad, 0)
    self.kitAuthor:SetWordWrap(false)
    self.kitSlash = self:CreateFontString(nil, "ARTWORK")
    self.kitSlash:SetFontObject(Fonts.Get("body"))
    self.kitSlash:SetPoint("LEFT", self.kitAuthor, "RIGHT", Theme.Space("xs"), 0)
    self.kitSlash:SetText("/")
    Theme.Bind(self.kitSlash, "text.muted")
    self.kitRoute = self:CreateFontString(nil, "ARTWORK")
    self.kitRoute:SetFontObject(Fonts.Get("body"))
    self.kitRoute:SetJustifyH("LEFT")
    self.kitRoute:SetWordWrap(false)
    Theme.Bind(self.kitRoute, "text.normal")
    self.kitChevron = UI.Glyphs.Create(self, "down", CHEVRON, "text.muted")
    self.kitChevron:SetPoint("RIGHT", self, "RIGHT", -pad, 0)
    self.kitPill = CreateFrame("Frame", nil, self)
    self.kitPill:SetHeight(PILL_HEIGHT)
    self.kitPill:SetPoint("RIGHT", self.kitChevron, "LEFT", -Theme.Space("sm"), 0)
    self.kitPillBackground = self.kitPill:CreateTexture(nil, "BACKGROUND")
    self.kitPillBackground:SetAllPoints()
    Theme.Bind(self.kitPillBackground, "live.bg")
    self.kitPillDot = self.kitPill:CreateTexture(nil, "ARTWORK")
    self.kitPillDot:SetSize(6, 6)
    self.kitPillDot:SetPoint("LEFT", self.kitPill, "LEFT", Theme.Space("sm"), 0)
    Theme.Bind(self.kitPillDot, "live")
    self.kitPillText = self.kitPill:CreateFontString(nil, "ARTWORK")
    self.kitPillText:SetFontObject(Fonts.Get("small"))
    self.kitPillText:SetPoint("LEFT", self.kitPillDot, "RIGHT", Theme.Space("xs"), 0)
    self.kitPillText:SetText(string.upper(L["Live"]))
    Theme.Bind(self.kitPillText, "live")
    self.kitPill:SetWidth(Theme.Space("sm") * 2 + 6 + Theme.Space("xs") + self.kitPillText:GetStringWidth())
    self:SetScript("OnClick", function(button) button:Emit("onClick", button) end)
    self.kitOnRepaint = function(button, row) button.kitChevron:SetColor(row.text) end
  end,
  Measure = function(self, availW) return self.kitProps.width or availW, Theme.Size("sm") end,
})

---Rows of the route switcher: name, author or level, forces percent. Menu rows cannot show user text, so the switcher has its own kind.
local RouteRow = {}

function RouteRow:OnCreate()
  local pad = Theme.Space("md")
  self.kitCurrent = self:CreateTexture(nil, "BACKGROUND", nil, -1)
  self.kitCurrent:SetAllPoints()
  Theme.Bind(self.kitCurrent, "bg.selected")
  self.kitTrailing = self:CreateFontString(nil, "ARTWORK")
  self.kitTrailing:SetFontObject(Fonts.Get("number"))
  self.kitTrailing:SetPoint("RIGHT", self, "RIGHT", -pad, 0)
  self.kitTrailing:SetJustifyH("RIGHT")
  self.kitTrailing:SetWidth(46)
  self.kitDetail = self:CreateFontString(nil, "ARTWORK")
  self.kitDetail:SetFontObject(Fonts.Get("small"))
  self.kitDetail:SetPoint("RIGHT", self.kitTrailing, "LEFT", -Theme.Space("sm"), 0)
  self.kitDetail:SetJustifyH("RIGHT")
  self.kitDetail:SetWordWrap(false)
  self.kitLabel = self:CreateFontString(nil, "ARTWORK")
  self.kitLabel:SetFontObject(Fonts.Get("body"))
  self.kitLabel:SetPoint("LEFT", self, "LEFT", pad, 0)
  self.kitLabel:SetPoint("RIGHT", self.kitDetail, "LEFT", -Theme.Space("sm"), 0)
  self.kitLabel:SetJustifyH("LEFT")
  self.kitLabel:SetWordWrap(false)
  Theme.Bind(self.kitLabel, "text.normal")
end

function RouteRow:Bind(item)
  Fonts.SetUserText(self.kitLabel, item.text or "", "body")
  Fonts.SetUserText(self.kitDetail, item.detail or "", "small")
  Theme.Bind(self.kitDetail, item.detailColor or "text.muted")
  self.kitTrailing:SetText(item.trailing or "")
  Theme.Bind(self.kitTrailing, item.trailingColor or "text.muted")
  self.kitCurrent:SetShown(item.checked == true)
end

local switcherKinds = {
  title = UI.Menu.rowKinds.title,
  choice = { height = "lg", mixin = RouteRow },
}

---@param anchor table
---@param ctx MDT.SidebarContext
---@param actions {pick: fun(idx: integer), new: fun(), import: fun()}
---@return MDT.UI.Control popover
function MDT:OpenRouteSwitcher(anchor, ctx, actions)
  local items = Model.SwitcherItems(Model.RouteGroups(ctx), ctx.totalForces, L, actions.pick)
  local popover
  local function normalized(query)
    if query == nil or query == "" then return UI.MenuModel.Normalize(items, ctx.presetIdx) end
    local filtered = UI.MenuModel.Filter(items, query)
    for _, item in ipairs(filtered) do item.checked = item.value == ctx.presetIdx end
    return filtered
  end
  popover = UI.Popover({
    anchor = anchor, width = POPOVER_WIDTH, padding = "sm", gap = "sm",
    build = function(content)
      local list
      UI.EditBox(content, { id = "search", placeholder = L["Search routes"], autoFocus = true, onChange = function(query)
        list:SetItems(normalized(query))
      end })
      local rows = normalized()
      local total = 0
      for _, item in ipairs(rows) do total = total + Theme.Size(switcherKinds[item.kind].height) end
      list = UI.List(content, {
        id = "routes", kinds = switcherKinds, items = rows, height = math.min(total, 320),
        onActivate = function(item)
          if item.kind ~= "choice" then return end
          popover:Close("select")
          item.onSelect(item)
        end,
      })
      local footer = UI.Row(content, { gap = "sm" })
      UI.Button(footer, { id = "newRoute", text = L["New Preset"], variant = "primary", onClick = function()
        popover:Close("api")
        actions.new()
      end })
      UI.Button(footer, { id = "importRoute", text = L["Import"], onClick = function()
        popover:Close("api")
        actions.import()
      end })
    end,
  })
  return popover
end

local function clampLevel(level)
  return math.max(MIN_LEVEL, math.min(MAX_LEVEL, level))
end

---@param level integer
---@return string
local function multiplierText(level)
  local trash = MDT:CalculateEnemyHealth(false, 100, level, false) / 100
  local boss = MDT:CalculateEnemyHealth(true, 100, level, false) / 100
  return string.format(L["levelHealthMultipliers"], string.format("%.2f", trash), string.format("%.2f", boss))
end

---The level grid under the stepper. `onPick` runs the same change and commit path as the stepper.
---@param anchor table
---@param level integer
---@param onPick fun(level: integer)
---@return MDT.UI.Control popover
function MDT:OpenLevelPicker(anchor, level, onPick)
  local popover
  local cells = {}
  ---@type MDT.UI.Control
  local multipliers
  local current = level
  local function paint()
    for value, cell in pairs(cells) do cell:SetSelected(value == current) end
    multipliers:SetText(multiplierText(current))
  end
  local function choose(value)
    current = clampLevel(value)
    popover:Close("select")
    onPick(current)
  end
  popover = UI.Popover({
    anchor = anchor, width = POPOVER_WIDTH, padding = "md", gap = "sm",
    build = function(content)
      local head = UI.Row(content, { gap = "sm", valign = "center" })
      UI.Text(head, { text = L["Dungeon Level"], font = "small", color = "text.muted", wrap = false, grow = 1 })
      UI.EditBox(head, { id = "levelInput", width = 44, numeric = true, maxLetters = 2, value = tostring(level), selectAllOnFocus = true, autoFocus = true,
        onCommit = function(text)
          local value = tonumber(text)
          if value then choose(value) end
        end })
      local grid = UI.Row(content, { id = "levels", gap = "xs", wrap = true })
      local innerW = POPOVER_WIDTH - Theme.Space("md") * 2
      local cellW = math.floor((innerW - Theme.Space("xs") * (LEVEL_COLUMNS - 1)) / LEVEL_COLUMNS)
      for value = MIN_LEVEL, MAX_LEVEL do
        cells[value] = UI.Button(grid, { text = tostring(value), width = cellW, height = "sm", font = "number", variant = "primary", onClick = function() choose(value) end })
      end
      multipliers = UI.Text(content, { id = "multipliers", text = "", font = "small", color = "text.muted" })
      UI.Text(content, { text = L["Scroll to adjust, type to set any level."], font = "small", color = "text.muted" })
      paint()
    end,
  })
  popover:EnableMouseWheel(true)
  popover:SetScript("OnMouseWheel", function(_, delta)
    current = clampLevel(current + (delta > 0 and 1 or -1))
    paint()
    onPick(current)
  end)
  return popover
end
