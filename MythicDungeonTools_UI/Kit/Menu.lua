local _, MDT = ...
local UI = MDT.UI
local Theme, Fonts, MenuModel, Overlay = UI.Theme, UI.Fonts, UI.MenuModel, UI.Overlay

local MIN_WIDTH = 160
local MAX_WIDTH = 360
local MAX_HEIGHT = 320
local ICON_SIZE = 14
local GLYPH_SIZE = 8
local TITLE_HEIGHT = 18
local SEPARATOR_HEIGHT = 7

---One kit menu for dropdowns, button menus, right-click menus and the route switcher. Rows are list kinds.
---@class MDT.UI.MenuApi
local Menu = {}
UI.Menu = Menu

local ItemRow = {}

function ItemRow:OnCreate()
  local pad = Theme.Space("md")
  self.kitIcon = self:CreateTexture(nil, "ARTWORK")
  self.kitIcon:SetSize(ICON_SIZE, ICON_SIZE)
  self.kitIcon:SetPoint("LEFT", self, "LEFT", pad, 0)
  self.kitCheck = UI.Glyphs.Create(self, "check", GLYPH_SIZE + 2, "accent")
  self.kitCheck:SetPoint("LEFT", self, "LEFT", pad, 0)
  self.kitLabel = self:CreateFontString(nil, "ARTWORK")
  self.kitLabel:SetFontObject(Fonts.Get("body"))
  self.kitLabel:SetJustifyH("LEFT")
  self.kitLabel:SetWordWrap(false)
  self.kitTrailing = self:CreateFontString(nil, "ARTWORK")
  self.kitTrailing:SetFontObject(Fonts.Get("small"))
  self.kitTrailing:SetPoint("RIGHT", self, "RIGHT", -pad, 0)
  self.kitTrailing:SetJustifyH("RIGHT")
  self.kitDetail = self:CreateFontString(nil, "ARTWORK")
  self.kitDetail:SetFontObject(Fonts.Get("small"))
  self.kitDetail:SetPoint("RIGHT", self.kitTrailing, "LEFT", -Theme.Space("sm"), 0)
  self.kitDetail:SetJustifyH("RIGHT")
  self.kitChevron = UI.Glyphs.Create(self, "right", GLYPH_SIZE, "text.muted")
  self.kitChevron:SetPoint("RIGHT", self, "RIGHT", -pad, 0)
end

function ItemRow:Bind(item)
  local pad = Theme.Space("md")
  local left = pad
  local leading = (item.kind == "choice" or item.kind == "toggle") and GLYPH_SIZE + 2 or (item.icon and ICON_SIZE) or 0
  if leading > 0 then left = left + leading + Theme.Space("sm") end
  self.kitIcon:SetShown(item.icon ~= nil and item.kind ~= "choice" and item.kind ~= "toggle")
  if item.icon then self.kitIcon:SetTexture(item.icon) end
  self.kitCheck:SetShown(item.checked == true)
  self.kitChevron:SetShown(item.kind == "submenu")
  self.kitTrailing:SetText(item.trailing or "")
  self.kitDetail:SetText(item.detail or "")
  self.kitLabel:ClearAllPoints()
  self.kitLabel:SetPoint("LEFT", self, "LEFT", left, 0)
  self.kitLabel:SetPoint("RIGHT", self.kitDetail, "LEFT", -Theme.Space("sm"), 0)
  if item.font then
    local _, size = Fonts.Get("body"):GetFont()
    self.kitLabel:SetFont(item.font, size, "")
  else
    self.kitLabel:SetFontObject(Fonts.Get("body"))
  end
  self.kitLabel:SetText(item.text or "")
  local textColor = item.disabled and "text.disabled" or item.textColor or "text.normal"
  Theme.Bind(self.kitLabel, textColor)
  Theme.Bind(self.kitDetail, item.detailColor or "text.muted")
  Theme.Bind(self.kitTrailing, "text.muted")
end

local TitleRow = {}

function TitleRow:OnCreate()
  self.kitLabel = self:CreateFontString(nil, "ARTWORK")
  self.kitLabel:SetFontObject(Fonts.Get("small"))
  self.kitLabel:SetPoint("BOTTOMLEFT", self, "BOTTOMLEFT", Theme.Space("md"), Theme.Space("xs"))
  self.kitLabel:SetPoint("RIGHT", self, "RIGHT", -Theme.Space("md"), 0)
  self.kitLabel:SetJustifyH("LEFT")
  Theme.Bind(self.kitLabel, "text.muted")
end

function TitleRow:Bind(item)
  self.kitLabel:SetText(string.upper(item.text or ""))
end

local SeparatorRow = {}

function SeparatorRow:OnCreate()
  self.kitLine = self:CreateTexture(nil, "ARTWORK")
  self.kitLine:SetPoint("LEFT", self, "LEFT", Theme.Space("sm"), 0)
  self.kitLine:SetPoint("RIGHT", self, "RIGHT", -Theme.Space("sm"), 0)
  self.kitLine:SetHeight(1)
  Theme.Bind(self.kitLine, "border.divider")
end

function SeparatorRow:Bind() end

---@type table<string, MDT.UI.ListKind>
Menu.rowKinds = {
  action = { height = "sm", mixin = ItemRow },
  choice = { height = "sm", mixin = ItemRow },
  toggle = { height = "sm", mixin = ItemRow },
  submenu = { height = "sm", mixin = ItemRow },
  title = { height = TITLE_HEIGHT, mixin = TitleRow, static = true },
  separator = { height = SEPARATOR_HEIGHT, mixin = SeparatorRow, static = true },
}

local measure

---The width a row needs to show its whole label, detail and trailing text, using the same insets as ItemRow:Bind.
---@param item MDT.UI.MenuItem
---@return number
local function itemWidth(item)
  if item.kind == "separator" then return 0 end
  if not measure then
    local holder = CreateFrame("Frame", nil, UIParent)
    holder:Hide()
    measure = holder:CreateFontString(nil, "ARTWORK")
  end
  local function textWidth(text, role)
    if not text or text == "" then return 0 end
    measure:SetFontObject(Fonts.Get(role))
    measure:SetText(text)
    return measure:GetUnboundedStringWidth()
  end
  local pad, gap = Theme.Space("md"), Theme.Space("sm")
  local leading = (item.kind == "choice" or item.kind == "toggle") and GLYPH_SIZE + 2 or (item.icon and ICON_SIZE) or 0
  local width = pad * 2 + textWidth(item.text, item.kind == "title" and "small" or "body")
  if leading > 0 then width = width + leading + gap end
  -- ItemRow keeps a gap before the detail and another before the trailing text even when they are empty.
  width = width + gap * 2 + textWidth(item.detail, "small") + textWidth(item.trailing, "small")
  if item.kind == "submenu" then width = width + gap + GLYPH_SIZE end
  return width
end

---@class MDT.UI.MenuSpec
---@field items MDT.UI.MenuItem[]|fun(): MDT.UI.MenuItem[]
---@field anchor table|"cursor"
---@field prefer "below"|"above"|"right"|"left"?
---@field width number? default: wide enough for the longest item, at least the anchor and 160, at most 360
---@field value any? marks the matching choice item
---@field search boolean?
---@field onSelect fun(item: MDT.UI.MenuItem)? fires after the item's own onSelect
---@field onClose fun(reason: string)?
---@field submenu boolean? internal: stacks under the parent menu

---@param spec MDT.UI.MenuSpec
---@return MDT.UI.Control? popover, nil when the item list is empty
function Menu.Open(spec)
  local items = MenuModel.Normalize(spec.items, spec.value)
  if #items == 0 then return nil end
  local anchor = spec.anchor
  local width = spec.width
  if not width then
    local natural = 0
    for _, item in ipairs(items) do natural = math.max(natural, itemWidth(item)) end
    width = math.min(MAX_WIDTH, math.max(MIN_WIDTH, anchor ~= "cursor" and anchor:GetWidth() or 0, math.ceil(natural) + Theme.Space("xs") * 2))
  end
  local popover = UI.PopoverFrame(UI.Root, { onClose = spec.onClose, padding = "xs", gap = "xs" })
  local openToken = {}
  popover.kitMenuToken = openToken
  popover:SetPoint("TOPLEFT", UI.Root, "TOPLEFT", 0, 0)
  local content = popover.content
  content:SetWidth(width)
  local list

  local function refresh(query)
    local normalized = query and MenuModel.Filter(spec.items, query, spec.value) or MenuModel.Normalize(spec.items, spec.value)
    list:SetItems(normalized)
  end

  local function activate(item, index)
    if item.disabled or item.kind == "title" or item.kind == "separator" then return end
    if item.kind == "submenu" then
      Overlay.PopAbove(popover.kitEntry, "replaced")
      Menu.Open({ items = item.items, anchor = list:GetRow(index) or popover, prefer = "right", submenu = true, onSelect = spec.onSelect })
      return
    end
    if item.kind == "toggle" then
      item.checked = not item.checked
      if item.onSelect then item.onSelect(item) end
      if spec.onSelect then spec.onSelect(item) end
      if item.keepOpen == false then
        Menu.Close()
      elseif not popover.kitReleased then
        refresh()
      end
      return
    end
    Overlay.PopAll("menu", "select")
    if item.onSelect then item.onSelect(item) end
    if spec.onSelect then spec.onSelect(item) end
  end

  content:Batch(function()
    if spec.search then
      UI.EditBox(content, { autoFocus = true, onChange = function(query) refresh(query) end, onEscape = Menu.Close })
    end
    local total = 0
    for _, item in ipairs(items) do total = total + Theme.Size(Menu.rowKinds[item.kind].height) end
    list = UI.List(content, {
      kinds = Menu.rowKinds, items = items, height = math.min(total, MAX_HEIGHT), onActivate = activate,
      onHover = function(item, index)
        if item.kind ~= "submenu" or item.disabled then return end
        C_Timer.After(Theme.data.motion.submenuDelay, function()
          local row = list:GetRow(index)
          if row and row.kitHovered and popover.kitMenuToken == openToken then activate(item, index) end
        end)
      end,
    })
  end)
  popover:SetSize(content:GetWidth(), content:GetHeight())
  popover.kitEntry = {
    frame = popover, kind = "menu", submenu = spec.submenu,
    onDismiss = function(reason)
      popover.kitMenuToken = nil
      popover:Emit("onClose", reason)
      popover:Release()
    end,
  }
  Overlay.Push(popover.kitEntry)
  if anchor == "cursor" then
    Overlay.PlaceAtCursor(popover)
  else
    Overlay.Place(popover, anchor, spec.prefer or "below", Theme.Space("xs"))
  end
  popover:Show()
  return popover
end

---Right-click menu at the cursor.
---@param items MDT.UI.MenuItem[]|fun(): MDT.UI.MenuItem[]
---@param owner table?
---@return MDT.UI.Control?
function Menu.OpenContext(items, owner)
  return Menu.Open({ items = items, anchor = "cursor", owner = owner })
end

function Menu.Close()
  Overlay.PopAll("menu", "api")
end

---@return boolean
function Menu.IsOpen()
  return Overlay.Top("menu") ~= nil
end
