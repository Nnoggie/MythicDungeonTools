local _, MDT = ...
local UI = MDT.UI
local Theme, ListMath, Selection = UI.Theme, UI.ListMath, UI.Selection

local OVERSCAN = 1
local WHEEL_STEP = 56
local BAR_WIDTH = 8
local INDICATOR_HEIGHT = 2
local HANDLE_WIDTH = 14
local GRIP_SIZE = 10
local LIFT_LEVELS = 10
local LIFT_SLOP = 4

---Rows are pooled per kind, shared by every list that uses that kind.
---@type table<MDT.UI.ListKind, table>
local rowPools = setmetatable({}, { __mode = "k" })

-- A row back in the pool has no list; hiding it can still fire its OnLeave.
local function rowClick(row, button) if row.kitList then row.kitList:kitRowClick(row, button) end end
local function rowEnter(row) if row.kitList then row.kitList:kitRowHover(row, true) end end
local function rowLeave(row) if row.kitList then row.kitList:kitRowHover(row, false) end end
local function rowDragStart(row) if row.kitList then row.kitList:kitDragStart(row) end end
local function rowDragStop(row)
  local list = row.kitDragList or row.kitList
  if list then list:kitDragFinish(true) end
end
local function rowWheel(row, delta)
  if row.kitList then row.kitList:SetOffset(row.kitList:GetOffset() - delta * WHEEL_STEP) end
end

-- The grip covers part of its row, so hovering it keeps the row hovered.
local function handleDown(handle, button)
  local row = handle.kitRow
  if button == "LeftButton" and row.kitList then row.kitList:kitHandleDragStart(row) end
end
local function handleUp(handle, button)
  local row = handle.kitRow
  local list = row.kitDragList or row.kitList
  if button == "LeftButton" and list then list:kitDragFinish(true) end
end
local function handleEnter(handle)
  local row = handle.kitRow
  handle.kitHovered = true
  if row.kitList then row.kitList:kitRowHover(row, true) end
  local tooltip = row.kitKind.handle.tooltip
  if tooltip and not (row.kitList and row.kitList.kitDrag) then UI.Tooltip.Show(handle, tooltip) end
end
local function handleLeave(handle)
  local row = handle.kitRow
  handle.kitHovered = nil
  UI.Tooltip.Hide(handle)
  if row.kitList then row.kitList:kitRowHover(row, false) end
end
local function handleWheel(handle, delta) rowWheel(handle.kitRow, delta) end
-- A right-click on the grip acts like one on its row: it cancels a drag or opens the row's menu.
local function handleClick(handle, button) rowClick(handle.kitRow, button) end

local function createHandle(row)
  local handle = CreateFrame("Button", nil, row)
  handle:SetPoint("TOPLEFT")
  handle:SetPoint("BOTTOMLEFT")
  handle:SetWidth(HANDLE_WIDTH)
  handle.kitRow = row
  handle.kitGrip = UI.Glyphs.Create(handle, "grip", GRIP_SIZE, "text.muted")
  handle.kitGrip:SetPoint("CENTER")
  UI.Script(handle, "OnMouseDown", handleDown)
  UI.Script(handle, "OnMouseUp", handleUp)
  UI.Script(handle, "OnEnter", handleEnter)
  UI.Script(handle, "OnLeave", handleLeave)
  UI.Script(handle, "OnMouseWheel", handleWheel)
  handle:RegisterForClicks("RightButtonUp")
  UI.Script(handle, "OnClick", handleClick)
  handle:EnableMouseWheel(true)
  row.kitHandle = handle
end

---@param kind MDT.UI.ListKind
local function poolFor(kind)
  local pool = rowPools[kind]
  if pool then return pool end
  pool = CreateObjectPool(function()
    local row = CreateFrame("Button", nil, UI.Holder)
    Mixin(row, kind.mixin)
    row.kitRowBackground = row:CreateTexture(nil, "BACKGROUND")
    row.kitRowBackground:SetAllPoints()
    row.kitRowBorder = UI.Pixel.Border(row, "accent")
    if kind.handle then createHandle(row) end
    row:RegisterForClicks("LeftButtonUp", "RightButtonUp")
    if kind.draggable then row:RegisterForDrag("LeftButton") end
    UI.Script(row, "OnClick", rowClick)
    UI.Script(row, "OnEnter", rowEnter)
    UI.Script(row, "OnLeave", rowLeave)
    UI.Script(row, "OnDragStart", rowDragStart)
    UI.Script(row, "OnDragStop", rowDragStop)
    UI.Script(row, "OnMouseWheel", rowWheel)
    row:EnableMouseWheel(true)
    kind.mixin.OnCreate(row)
    return row
  end, nil)
  rowPools[kind] = pool
  return pool
end

local function releaseRow(row)
  if row.kitKind.mixin.OnUnbind then row.kitKind.mixin.OnUnbind(row) end
  UI.Tooltip.Hide(row)
  if row.kitHandle then UI.Tooltip.Hide(row.kitHandle) end
  -- Hiding a hovered row fires its OnLeave, which still needs its list and item.
  row:Hide()
  row.kitItem, row.kitIndex, row.kitKey, row.kitSig, row.kitList, row.kitHovered = nil, nil, nil, nil, nil, nil
  row:ClearAllPoints()
  row:SetParent(UI.Holder)
  row:SetAlpha(1)
  poolFor(row.kitKind):Release(row)
end

local Methods = {}

function Methods:GetOffset() return self.kitOffset end

---@param offset number
function Methods:SetOffset(offset)
  local maxOffset = math.max(0, self.kitTotal - self.kitViewport:GetHeight())
  self.kitOffset = math.max(0, math.min(maxOffset, offset))
  self.kitBar:SetValue(self.kitOffset)
  self:kitRefresh()
end

---Replaces the items. A row rebinds only where kind, key or sig changed, so fresh item tables with the same sig keep it; the scroll offset is kept. During a drag the call waits for the drop.
---@param items MDT.UI.ListItem[]
function Methods:SetItems(items)
  if self.kitDrag then
    self.kitPendingItems = items
    return
  end
  self.kitProps.items = items
  self:kitMeasure()
  self:SetOffset(self.kitOffset)
end

---@param selection integer[]
function Methods:SetSelection(selection)
  self.kitProps.selection = selection
  for _, row in pairs(self.kitRows) do self:kitPaintRow(row) end
end

---@param index integer
---@param align "nearest"|"top"|"center"?
function Methods:ScrollTo(index, align)
  self:SetOffset(ListMath.ScrollTo(self.kitTops, self.kitHeights, self.kitOffset, self.kitViewport:GetHeight(), index, align))
end

---@param fn fun(row: table, item: MDT.UI.ListItem, index: integer)
function Methods:ForEachRow(fn)
  for index, row in pairs(self.kitRows) do fn(row, row.kitItem, index) end
end

---@param index integer
---@return table? row currently bound to that index
function Methods:GetRow(index) return self.kitRows[index] end

function Methods:IsDragging() return self.kitDrag ~= nil end

---A pooled list placed at the same size as before gets no OnSizeChanged, so the layout tells it directly.
function Methods:kitPlaced() self:kitRefresh() end

function Methods:kitMeasure()
  local heights = {}
  for i, item in ipairs(self.kitProps.items) do
    local kind = self.kitProps.kinds[item.kind] or error("List: item "..i.." has unknown kind "..tostring(item.kind))
    heights[i] = Theme.Size(kind.height)
  end
  self.kitHeights = heights
  self.kitTops, self.kitTotal = ListMath.Offsets(heights, Theme.Space(self.kitProps.gap))
end

function Methods:kitPaintRow(row)
  local kind = row.kitKind
  local selected = kind.selectable and Selection.Contains(self.kitProps.selection, row.kitIndex)
  local state = "normal"
  if row.kitItem.disabled then state = "disabled"
  elseif selected then state = "selected"
  elseif row.kitHovered and not kind.static and not self.kitDrag then state = "hover" end
  local skin = Theme.Skin("row", state)
  if skin.bg then
    Theme.Bind(row.kitRowBackground, skin.bg)
    row.kitRowBackground:Show()
  else
    row.kitRowBackground:Hide()
  end
  if skin.border then
    row.kitRowBorder:SetToken(skin.border)
    row.kitRowBorder:SetShown(true)
  else
    row.kitRowBorder:SetShown(false)
  end
  local drag = self.kitDrag
  local lifted = drag and drag.lift and drag.row == row
  if lifted then
    Theme.Bind(row.kitRowBackground, "bg.raised2")
    row.kitRowBackground:Show()
    row.kitRowBorder:SetToken("border.strong")
    row.kitRowBorder:SetShown(true)
  end
  local handle = row.kitHandle
  if handle then
    handle:SetShown(row.kitItem.dragGroup ~= nil and self.kitProps.onReorder ~= nil)
    handle.kitGrip:SetColor((lifted or (handle.kitHovered and not drag)) and "text.normal" or "text.muted")
  end
  local ghosted = drag and not drag.lift and drag.keySet[row.kitKey]
  row:SetAlpha(ghosted and Theme.data.alpha.dragSource or 1)
end

function Methods:kitBind(row, item, index)
  row.kitList, row.kitItem, row.kitIndex, row.kitKey, row.kitSig = self, item, index, item.key, item.sig
  row.kitKind.mixin.Bind(row, item, index, self)
  self:kitPaintRow(row)
end

---The row that started a drag stays bound and placed until the drop, even when it scrolls out of the viewport.
function Methods:kitIsDragOrigin(row)
  return self.kitDrag ~= nil and self.kitDrag.row == row
end

---Anchors a row at its content offset, or where a handle drag has slid it.
function Methods:kitPlaceRow(row, index)
  local drag = self.kitDrag
  local top = drag and drag.lift and drag.shown[index] or self.kitTops[index]
  row:ClearAllPoints()
  row:SetPoint("TOPLEFT", self.kitViewport, "TOPLEFT", 0, -(top - self.kitOffset))
end

---Virtualization pass: releases rows outside the visible range, binds rows for new indices, repositions the rest.
function Methods:kitRefresh()
  local items, kinds = self.kitProps.items, self.kitProps.kinds
  local viewport = self.kitViewport
  local viewH = viewport:GetHeight()
  self.kitBar:SetRange(viewH, self.kitTotal)
  if not self.kitProps.scrollbar then self.kitBar:Hide() end
  local inset = self.kitBar:IsShown() and (BAR_WIDTH + Theme.Space("xs")) or 0
  viewport:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT", -inset, 0)
  local first, last = ListMath.VisibleRange(self.kitTops, self.kitHeights, self.kitOffset, viewH, OVERSCAN)
  for index, row in pairs(self.kitRows) do
    local item = items[index]
    local outside = index < first or index > last
    if (outside and not self:kitIsDragOrigin(row)) or not item or item.kind ~= row.kitItem.kind then
      self.kitRows[index] = nil
      releaseRow(row)
    end
  end
  local width = viewport:GetWidth()
  local function place(row, index)
    self:kitPlaceRow(row, index)
    row:SetSize(width, self.kitHeights[index])
    row:Show()
  end
  for index = first, last do
    local item = items[index]
    local kind = kinds[item.kind]
    local row = self.kitRows[index]
    if not row then
      row = poolFor(kind):Acquire()
      row.kitKind = kind
      row:SetParent(viewport)
      UI.Pixel.RefreshFrame(row)
      self.kitRows[index] = row
      self:kitBind(row, item, index)
    elseif row.kitKey ~= item.key or row.kitSig ~= item.sig then
      self:kitBind(row, item, index)
    else
      row.kitItem = item
    end
    place(row, index)
  end
  for index, row in pairs(self.kitRows) do
    if (index < first or index > last) and self:kitIsDragOrigin(row) then place(row, index) end
  end
end

function Methods:kitRowHover(row, entering)
  row.kitHovered = entering or nil
  if not row.kitItem then return end
  self:kitPaintRow(row)
  if self.kitDrag or row.kitKind.static then return end
  self:Emit(entering and "onHover" or "onHoverEnd", row.kitItem, row.kitIndex, row)
end

function Methods:kitRowClick(row, button)
  if self.kitDrag then
    if button == "RightButton" then self:kitDragFinish(false) end
    return
  end
  local item, index, kind = row.kitItem, row.kitIndex, row.kitKind
  if not item or kind.static or item.disabled then return end
  local mods = { shift = IsShiftKeyDown(), ctrl = IsControlKeyDown(), button = button }
  if kind.selectable and self.kitProps.onSelect then
    self:Emit("onSelect", Selection.Click(self.kitProps.selection, index, mods), index, mods)
  end
  if button == "RightButton" then
    local menuItems = self:Emit("onContext", item, index, mods)
    if menuItems then UI.Menu.OpenContext(menuItems, row) end
  else
    self:Emit("onActivate", item, index, mods)
  end
end

local function ghostFor(list)
  if list.kitGhost then return list.kitGhost end
  local ghost = CreateFrame("Frame", nil, UI.Root)
  ghost:SetFrameStrata("TOOLTIP")
  ghost:SetAlpha(0.6)
  ghost:Hide()
  ghost.kitBadge = ghost:CreateFontString(nil, "OVERLAY")
  ghost.kitBadge:SetFontObject(UI.Fonts.Get("number"))
  ghost.kitBadge:SetPoint("RIGHT", ghost, "RIGHT", -Theme.Space("sm"), 0)
  Theme.Bind(ghost.kitBadge, "accent")
  list.kitGhost = ghost
  return ghost
end

---A handle drag: the held row follows the cursor within its group, and the others ease toward the spots they take
---if it is dropped now.
local function liftUpdate(self, drag, elapsed, cursorY)
  local tops, heights, members, held = self.kitTops, self.kitHeights, drag.members, drag.index
  local first, last = members[1], members[#members]
  local height = heights[held]
  local y = math.max(tops[first], math.min(tops[last] + heights[last] - height, cursorY + self.kitOffset - drag.grab))
  -- A row swaps places once the held row's leading edge crosses its middle.
  local position, order = 1, {}
  for _, index in ipairs(members) do
    if index ~= held then
      order[#order + 1] = index
      local middle = tops[index] + heights[index] / 2
      local staysAbove
      if index < held then staysAbove = y >= middle else staysAbove = y + height > middle end
      if staysAbove then position = position + 1 end
    end
  end
  table.insert(order, position, held)
  drag.noop = position == drag.from
  drag.slot = position > drag.from and position + 1 or position
  local gap, top = Theme.Space(self.kitProps.gap), tops[first]
  local ease = math.min(1, elapsed * Theme.data.motion.dragSlide)
  for _, index in ipairs(order) do
    if index ~= held then drag.shown[index] = drag.shown[index] + (top - drag.shown[index]) * ease end
    top = top + heights[index] + gap
  end
  drag.shown[held] = y
  for index, row in pairs(self.kitRows) do
    if drag.shown[index] then self:kitPlaceRow(row, index) end
  end
end

local function dragUpdate(self, elapsed)
  local drag = self.kitDrag
  if not drag then return end
  if not IsMouseButtonDown("LeftButton") then
    self:kitDragFinish(true)
    return
  end
  local viewport = self.kitViewport
  local _, cursorY = GetCursorPosition()
  local localY = viewport:GetTop() - cursorY / viewport:GetEffectiveScale()
  local viewH = viewport:GetHeight()
  -- A row picked up by its grip near an edge waits for the cursor to move before the list scrolls under it.
  if drag.lift and not drag.moved then drag.moved = math.abs(localY - drag.startY) > LIFT_SLOP end
  local speed = (drag.lift and not drag.moved) and 0
    or ListMath.AutoScroll(localY, viewH, Theme.data.motion.dragEdge, Theme.data.motion.dragScrollMax)
  if speed ~= 0 then self:SetOffset(self.kitOffset + speed * elapsed) end
  if drag.lift then
    liftUpdate(self, drag, elapsed, localY)
    return
  end
  drag.ghost:ClearAllPoints()
  drag.ghost:SetPoint("LEFT", viewport, "TOPLEFT", 0, -localY)
  local rows = {}
  for i, item in ipairs(self.kitProps.items) do
    rows[i] = { top = self.kitTops[i], height = self.kitHeights[i], draggable = self.kitProps.kinds[item.kind].draggable == true, dragged = drag.keySet[item.key] }
  end
  local slot, indicatorY, noop = ListMath.DropSlot(localY + self.kitOffset, rows)
  drag.slot, drag.noop = slot, noop
  if noop then
    self.kitIndicator:Hide()
  else
    self.kitIndicator:ClearAllPoints()
    self.kitIndicator:SetPoint("TOPLEFT", viewport, "TOPLEFT", 0, -(indicatorY - self.kitOffset) + INDICATOR_HEIGHT / 2)
    self.kitIndicator:SetPoint("TOPRIGHT", viewport, "TOPRIGHT", 0, -(indicatorY - self.kitOffset) + INDICATOR_HEIGHT / 2)
    self.kitIndicator:Show()
  end
end

function Methods:kitDragStart(row)
  local item, index, kind = row.kitItem, row.kitIndex, row.kitKind
  if self.kitDrag or not item or not kind.draggable or not self.kitProps.onReorder then return end
  local indices = { index }
  if kind.selectable and Selection.Contains(self.kitProps.selection, index) then
    indices = {}
    for _, selected in ipairs(self.kitProps.selection) do
      if self.kitProps.items[selected] then indices[#indices + 1] = selected end
    end
    table.sort(indices)
  end
  local keys, keySet = {}, {}
  for _, i in ipairs(indices) do
    local key = self.kitProps.items[i].key
    keys[#keys + 1] = key
    keySet[key] = true
  end
  local ghost = ghostFor(self)
  local ghostRow = poolFor(kind):Acquire()
  ghostRow.kitKind = kind
  ghostRow:SetParent(ghost)
  ghostRow:SetAllPoints(ghost)
  ghostRow:EnableMouse(false)
  ghostRow:Show()
  ghost:SetSize(row:GetWidth(), row:GetHeight())
  ghost.kitBadge:SetText(#keys > 1 and ("x"..#keys) or "")
  ghost:Show()
  self.kitDrag = { keys = keys, keySet = keySet, ghost = ghost, ghostRow = ghostRow, noop = true, row = row }
  row.kitDragList = self
  self:kitBind(ghostRow, item, index)
  ghostRow.kitRowBackground:Show()
  Theme.Bind(ghostRow.kitRowBackground, "bg.raised2")
  ghostRow:SetAlpha(1)
  self.kitDrag.escape = { close = function() self:kitDragFinish(false) end }
  UI.Escape.Push(self.kitDrag.escape)
  UI.Tooltip.Hide(row)
  for _, visible in pairs(self.kitRows) do self:kitPaintRow(visible) end
  UI.Script(self, "OnUpdate", dragUpdate)
  dragUpdate(self, 0)
end

---The keys and sigs of a drag group's items, to tell whether items set during a drag changed it.
---@param items MDT.UI.ListItem[]
---@param dragGroup any
---@return string
local function groupSignature(items, dragGroup)
  local parts = {}
  for _, item in ipairs(items) do
    if item.dragGroup == dragGroup then parts[#parts + 1] = tostring(item.key).."\0"..tostring(item.sig) end
  end
  return table.concat(parts, "\1")
end

---Picks up a row by its grip. It moves among the adjacent items that share its dragGroup.
function Methods:kitHandleDragStart(row)
  local item, index = row.kitItem, row.kitIndex
  if self.kitDrag or not item or item.dragGroup == nil or not self.kitProps.onReorder then return end
  local members, from = {}, nil
  for i, other in ipairs(self.kitProps.items) do
    if other.dragGroup == item.dragGroup then
      members[#members + 1] = i
      if i == index then from = #members end
    end
  end
  if #members < 2 then return end
  local shown = {}
  for _, i in ipairs(members) do shown[i] = self.kitTops[i] end
  local viewport = self.kitViewport
  local _, cursorY = GetCursorPosition()
  local startY = viewport:GetTop() - cursorY / viewport:GetEffectiveScale()
  self.kitDrag = {
    lift = true, keys = { item.key }, keySet = { [item.key] = true }, row = row, index = index,
    members = members, from = from, shown = shown, grab = startY + self.kitOffset - self.kitTops[index], startY = startY,
    dragGroup = item.dragGroup, group = groupSignature(self.kitProps.items, item.dragGroup), noop = true, frameLevel = row:GetFrameLevel(),
  }
  row.kitDragList = self
  row:SetFrameLevel(row:GetFrameLevel() + LIFT_LEVELS)
  self.kitDrag.escape = { close = function() self:kitDragFinish(false) end }
  UI.Escape.Push(self.kitDrag.escape)
  UI.Tooltip.Hide(row)
  UI.Tooltip.Hide(row.kitHandle)
  for _, visible in pairs(self.kitRows) do self:kitPaintRow(visible) end
  UI.Script(self, "OnUpdate", dragUpdate)
  dragUpdate(self, 0)
end

---@param commit boolean
function Methods:kitDragFinish(commit)
  local drag = self.kitDrag
  if not drag then return end
  UI.Script(self, "OnUpdate", nil)
  self.kitIndicator:Hide()
  if drag.lift then
    drag.row:SetFrameLevel(drag.frameLevel)
  else
    drag.ghostRow:EnableMouse(true)
    releaseRow(drag.ghostRow)
    drag.ghost:Hide()
  end
  UI.Escape.Remove(drag.escape)
  drag.row.kitDragList = nil
  self.kitDrag = nil
  local pending = self.kitPendingItems
  if pending then
    -- A grip drop is a slot within the group as it was; if the group changed meanwhile, the drop is dropped.
    if drag.lift and groupSignature(pending, drag.dragGroup) ~= drag.group then commit = false end
    self.kitPendingItems = nil
    self:SetItems(pending)
  else
    if drag.lift then self:kitRefresh() end
    for _, row in pairs(self.kitRows) do self:kitPaintRow(row) end
  end
  if commit and drag.slot and not drag.noop then self:Emit("onReorder", drag.keys, drag.slot) end
end

---@class MDT.UI.ListSpec : MDT.UI.CommonSpec
---@field kinds table<string, MDT.UI.ListKind>
---@field items MDT.UI.ListItem[]?
---@field selection integer[]? controlled by the caller; the list only paints it
---@field gap MDT.UI.Space|number?
---@field scrollbar boolean? default true
---@field onSelect fun(selection: integer[], clicked: integer, mods: MDT.UI.ClickMods)? proposed selection from the pure click semantics
---@field onActivate fun(item: MDT.UI.ListItem, index: integer, mods: MDT.UI.ClickMods)?
---@field onContext fun(item: MDT.UI.ListItem, index: integer, mods: MDT.UI.ClickMods): MDT.UI.MenuItem[]? returned items open at the cursor
---@field onReorder fun(keys: (string|number)[], slot: integer)? slot is the insert-before position, 1..n+1, among the draggable rows, or for a handle drag among the rows of the dragged item's dragGroup
---@field onHover fun(item: MDT.UI.ListItem, index: integer, row: table)?
---@field onHoverEnd fun(item: MDT.UI.ListItem, index: integer, row: table)?
UI.Define({
  name = "List", frameType = "Frame", mixins = { Methods },
  props = {
    { name = "kinds", default = {} },
    { name = "gap", default = 0 },
    { name = "scrollbar", default = true },
    { name = "selection", default = {} },
    { name = "items", default = {}, set = function(self, items)
      if self.kitReleased then return end
      self.kitPendingItems = nil
      self:kitDragFinish(false)
      self.kitProps.items = items
      self:kitMeasure()
      self:SetOffset(0)
    end },
    { name = "onSelect", default = nil },
    { name = "onActivate", default = nil },
    { name = "onContext", default = nil },
    { name = "onReorder", default = nil },
    { name = "onHover", default = nil },
    { name = "onHoverEnd", default = nil },
  },
  Create = function(self)
    self.kitRows, self.kitOffset, self.kitTops, self.kitHeights, self.kitTotal = {}, 0, {}, {}, 0
    self.kitViewport = CreateFrame("Frame", nil, self)
    self.kitViewport:SetPoint("TOPLEFT", self, "TOPLEFT", 0, 0)
    self.kitViewport:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT", 0, 0)
    self.kitViewport:SetClipsChildren(true)
    self.kitViewport:EnableMouseWheel(true)
    UI.Script(self.kitViewport, "OnMouseWheel", function(_, delta) self:SetOffset(self.kitOffset - delta * WHEEL_STEP) end)
    self.kitBar = UI.Scrollbar(self, { onChange = function(offset) self:SetOffset(offset) end })
    self.kitBar:SetPoint("TOPRIGHT", self, "TOPRIGHT", 0, 0)
    self.kitBar:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT", 0, 0)
    self.kitIndicator = self.kitViewport:CreateTexture(nil, "OVERLAY")
    self.kitIndicator:SetHeight(INDICATOR_HEIGHT)
    Theme.Bind(self.kitIndicator, "accent")
    self.kitIndicator:Hide()
    UI.Script(self, "OnSizeChanged", function() self:kitRefresh() end)
    UI.HookScript(self, "OnHide", function() self:kitDragFinish(false) end)
  end,
  OnRelease = function(self)
    self:kitDragFinish(false)
    for index, row in pairs(self.kitRows) do
      self.kitRows[index] = nil
      releaseRow(row)
    end
    self.kitOffset = 0
  end,
  Measure = function(self, availW) return self.kitProps.width or availW, self:GetHeight() end,
})
