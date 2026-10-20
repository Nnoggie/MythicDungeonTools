local _, MDT = ...
local UI = MDT.UI
local Theme, Layout = UI.Theme, UI.Layout

---Frames that own kit children. A child registers itself by being constructed with the container as parent.
---@class MDT.UI.Container : MDT.UI.Control
local Container = {}
UI.Mixins.Container = Container

function Container:kitAdopt(child)
  child.kitParent = self
  self.kitChildren[#self.kitChildren + 1] = child
  Layout.Invalidate(self)
end

function Container:kitDisown(child)
  for i, existing in ipairs(self.kitChildren) do
    if existing == child then
      table.remove(self.kitChildren, i)
      break
    end
  end
  child.kitParent = nil
  Layout.Invalidate(self)
end

function Container:ReleaseChildren()
  local children = self.kitChildren
  self.kitChildren = {}
  for i = #children, 1, -1 do
    children[i].kitParent = nil
    children[i]:Release()
  end
  Layout.Invalidate(self)
end

---@param id string
---@return MDT.UI.Control?
function Container:Find(id)
  for _, child in ipairs(self.kitChildren) do
    if child.kitProps.id == id then return child end
    if child.kitChildren then
      local found = child:Find(id)
      if found then return found end
    end
  end
  return nil
end

---@param fn fun()
function Container:Batch(fn)
  Layout.Batch(self, fn)
end

---Layout items for the children. Stacks stretch children without a width; rows use their natural width.
---@param innerW number
---@param naturalWidth boolean
---@return MDT.UI.LayoutItem[]
function Container:kitItems(innerW, naturalWidth)
  local items = {}
  for i, child in ipairs(self.kitChildren) do
    local props = child.kitProps
    if props.hidden then
      items[i] = { hidden = true, h = 0 }
    else
      local measuredW, measuredH = child:kitMeasure(props.width or innerW)
      local w = props.width
      if naturalWidth and not w then w = measuredW end
      items[i] = { w = w, h = props.height and Theme.Size(props.height) or measuredH, grow = props.grow }
    end
  end
  return items
end

---@param rects (MDT.UI.LayoutRect|false)[]
function Container:kitPlace(rects)
  for i, child in ipairs(self.kitChildren) do
    local rect = rects[i]
    if rect then
      child:ClearAllPoints()
      child:SetPoint("TOPLEFT", self, "TOPLEFT", rect.x, -rect.y)
      child:SetSize(math.max(0, rect.w), math.max(0, rect.h))
      if child.kitPlaced then child:kitPlaced() end
    end
  end
end

function Container:kitAutoHeight()
  return self.kitProps.autoHeight and not self.kitProps.height
end

---@param total number
function Container:kitApplyHeight(total)
  if self:kitAutoHeight() and math.abs(total - self:GetHeight()) > 0.01 then
    self:SetHeight(total)
    self:InvalidateLayout()
  end
end

local function surface(self)
  local props = self.kitProps
  if props.background then
    Theme.Bind(self.kitBackground, props.background)
    self.kitBackground:Show()
  else
    self.kitBackground:Hide()
  end
  if props.border then
    self.kitBorder:SetToken(props.border)
    self.kitBorder:SetShown(true)
  else
    self.kitBorder:SetShown(false)
  end
end

---A fixed-height container also relays out when its height changes, and its parent re-measures it.
local function sizeChanged(self, width, height)
  if width ~= self.kitLaidOutWidth then Layout.Invalidate(self) end
  if height ~= self.kitSizedHeight then
    self.kitSizedHeight = height
    if not self:kitAutoHeight() then
      Layout.Invalidate(self)
      self:InvalidateLayout()
    end
  end
end

local function createContainer(self)
  self.kitChildren = {}
  self.kitBackground = self:CreateTexture(nil, "BACKGROUND")
  self.kitBackground:SetAllPoints()
  self.kitBorder = UI.Pixel.Border(self, "border.normal")
  UI.Script(self, "OnSizeChanged", sizeChanged)
end

local function containerProps(extra)
  local props = {
    { name = "gap", default = "sm", relayout = true },
    { name = "padding", default = nil, relayout = true },
    { name = "autoHeight", default = true, relayout = true },
    { name = "background", default = nil, set = surface },
    { name = "border", default = nil, set = surface },
    { name = "onLayout", default = nil },
  }
  for _, prop in ipairs(extra) do props[#props + 1] = prop end
  return props
end

local function measureContainer(self, availW)
  return self.kitProps.width or availW, self:GetHeight()
end

local function stackLayout(self)
  local width = self:GetWidth()
  self.kitLaidOutWidth = width
  local pad = Theme.Space(self.kitProps.padding)
  local items = self:kitItems(width - pad * 2, false)
  local rects, total = Layout.Stack(items, {
    width = width, height = (not self:kitAutoHeight()) and self:GetHeight() or nil,
    gap = Theme.Space(self.kitProps.gap), pad = pad, align = self.kitProps.align,
  })
  self:kitPlace(rects)
  self:kitApplyHeight(total)
end

---@class MDT.UI.StackSpec : MDT.UI.CommonSpec
---@field gap MDT.UI.Space|number? default "sm"
---@field padding MDT.UI.Space|number?
---@field autoHeight boolean? default true; false keeps the frame's own height and lets `grow` children share it
---@field align "stretch"|"start"|"center"|"end"?
---@field onLayout fun(self: MDT.UI.Control)? after every layout of this stack, with its new size
---@field background MDT.UI.ColorToken?
---@field border MDT.UI.ColorToken?
UI.Define({
  name = "Stack", frameType = "Frame", mixins = { Container },
  props = containerProps({ { name = "align", default = "stretch", relayout = true } }),
  Create = function(self)
    createContainer(self)
    self.kitLayout = stackLayout
  end,
  Measure = measureContainer,
})

---@class MDT.UI.RowSpec : MDT.UI.CommonSpec
---@field gap MDT.UI.Space|number?
---@field padding MDT.UI.Space|number?
---@field wrap boolean?
---@field align "start"|"center"|"end"|"spread"?
---@field valign "center"|"start"|"end"|"stretch"?
---@field autoHeight boolean?
---@field background MDT.UI.ColorToken?
---@field border MDT.UI.ColorToken?
UI.Define({
  name = "Row", frameType = "Frame", mixins = { Container },
  props = containerProps({
    { name = "wrap", default = false, relayout = true },
    { name = "align", default = "start", relayout = true },
    { name = "valign", default = "center", relayout = true },
  }),
  Create = function(self)
    createContainer(self)
    self.kitLayout = function(row)
      local width = row:GetWidth()
      row.kitLaidOutWidth = width
      local pad = Theme.Space(row.kitProps.padding)
      local items = row:kitItems(width - pad * 2, true)
      local fixed = not row:kitAutoHeight()
      local rects, total = Layout.Row(items, {
        width = width, gap = Theme.Space(row.kitProps.gap), pad = pad, wrap = row.kitProps.wrap,
        align = row.kitProps.align, valign = row.kitProps.valign,
        lineHeight = fixed and not row.kitProps.wrap and (row:GetHeight() - pad * 2) or nil,
      })
      row:kitPlace(rects)
      row:kitApplyHeight(total)
    end
  end,
  Measure = measureContainer,
})

local function ensureColumns(self, weights)
  if self.kitReleased then return end
  for i = 1, #weights do
    if not self[i] then self[i] = UI.Stack(self, { gap = self.kitProps.gap }) end
  end
  for i = #weights + 1, #self do
    self[i]:Release()
    self[i] = nil
  end
end

---@class MDT.UI.ColumnsSpec : MDT.UI.CommonSpec
---@field weights number[]? default {1, 1}; columns[i] is the i-th column Stack
---@field gap MDT.UI.Space|number? gap between columns and inside each column
UI.Define({
  name = "Columns", frameType = "Frame", mixins = { Container },
  props = {
    { name = "gap", default = "lg", relayout = true },
    { name = "weights", default = { 1, 1 }, relayout = true, set = ensureColumns },
  },
  Create = function(self)
    createContainer(self)
    self.kitBackground:Hide()
    self.kitBorder:SetShown(false)
    self.kitLayout = function(columns)
      local width = columns:GetWidth()
      columns.kitLaidOutWidth = width
      local bands = Layout.Columns(width, columns.kitProps.weights, Theme.Space(columns.kitProps.gap))
      local tallest = 0
      for i, band in ipairs(bands) do
        local column = columns[i]
        column:ClearAllPoints()
        column:SetPoint("TOPLEFT", columns, "TOPLEFT", band.x, 0)
        column:SetWidth(band.w)
        tallest = math.max(tallest, column:GetHeight())
      end
      if math.abs(tallest - columns:GetHeight()) > 0.01 then
        columns:SetHeight(tallest)
        columns:InvalidateLayout()
      end
    end
  end,
  OnRelease = function(self)
    for i = 1, #self do self[i] = nil end
  end,
  Measure = measureContainer,
})

---@class MDT.UI.TabSpec
---@field key string
---@field text string
---@field build fun(content: MDT.UI.Control)

local function selectTab(self, key)
  if self.kitReleased then return end
  local tab
  for _, candidate in ipairs(self.kitProps.tabs) do
    if candidate.key == key then tab = candidate end
  end
  for _, button in ipairs(self.kitTabButtons) do button:SetSelected(button.kitTabKey == key) end
  self.content:ReleaseChildren()
  if tab and tab.build then self.content:Batch(function() tab.build(self.content) end) end
end

local function buildTabs(self, tabs)
  if self.kitReleased then return end
  self.bar:ReleaseChildren()
  self.kitTabButtons = {}
  for _, tab in ipairs(tabs) do
    local button = UI.Button(self.bar, {
      text = tab.text, variant = "ghost",
      onClick = function() self:SetSelected(tab.key) end,
    })
    button.kitTabKey = tab.key
    self.kitTabButtons[#self.kitTabButtons + 1] = button
  end
end

---@class MDT.UI.TabsSpec : MDT.UI.CommonSpec
---@field tabs MDT.UI.TabSpec[]
---@field selected string? defaults to the first tab
---@field onSelect fun(key: string)?
---@field gap MDT.UI.Space|number?
UI.Define({
  name = "Tabs", frameType = "Frame", mixins = { Container },
  props = {
    { name = "gap", default = "sm", relayout = true },
    { name = "autoHeight", default = true, relayout = true },
    { name = "tabs", default = {}, set = buildTabs },
    { name = "onSelect", default = nil },
    { name = "selected", default = nil, set = function(self, key)
      if self.kitReleased then return end
      key = key or (self.kitProps.tabs[1] and self.kitProps.tabs[1].key)
      self.kitProps.selected = key
      selectTab(self, key)
      self:Emit("onSelect", key)
    end },
  },
  Create = function(self)
    createContainer(self)
    self.kitBackground:Hide()
    self.kitBorder:SetShown(false)
    self.bar = UI.Row(self, { gap = "xs" })
    self.content = UI.Stack(self, { gap = "sm" })
    self.bar.kitPersistent, self.content.kitPersistent = true, true
    self.kitTabButtons = {}
    self.kitLayout = stackLayout
  end,
  OnRelease = function(self)
    self.bar:ReleaseChildren()
    self.content:ReleaseChildren()
    self.kitTabButtons = {}
  end,
  Measure = measureContainer,
})
