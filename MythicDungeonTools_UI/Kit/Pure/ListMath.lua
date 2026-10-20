local _, MDT = ...
local UI = MDT.UI or {}
MDT.UI = UI

---@class MDT.UI.ListMath
local ListMath = {}
UI.ListMath = ListMath

---@class MDT.UI.DropRow
---@field top number offset from the content top, growing downward
---@field height number
---@field draggable boolean
---@field dragged boolean? part of the moving set

---Prefix sums. tops[i] is the content offset of item i; total is the content height.
---@param heights number[]
---@param gap number?
---@return number[] tops, number total
function ListMath.Offsets(heights, gap)
  gap = gap or 0
  local tops, y = {}, 0
  for i, h in ipairs(heights) do
    tops[i] = y
    y = y + h + (i < #heights and gap or 0)
  end
  return tops, y
end

---Indices whose rows intersect the viewport, widened by `overscan` rows on each side.
---@param tops number[]
---@param heights number[]
---@param offset number scroll offset
---@param viewH number
---@param overscan integer?
---@return integer first, integer last first > last when nothing is visible
function ListMath.VisibleRange(tops, heights, offset, viewH, overscan)
  local n = #tops
  if n == 0 or viewH <= 0 then return 1, 0 end
  local low, high = 1, n
  while low < high do
    local mid = math.floor((low + high) / 2)
    if tops[mid] + heights[mid] > offset then high = mid else low = mid + 1 end
  end
  local first = low
  if tops[first] + heights[first] <= offset then return 1, 0 end
  local last = first
  local bottom = offset + viewH
  while last < n and tops[last + 1] < bottom do last = last + 1 end
  overscan = overscan or 0
  return math.max(1, first - overscan), math.min(n, last + overscan)
end

---Insert-before slot among draggable rows (1..n+1), the indicator offset, and whether the drop would change nothing.
---Non-draggable rows map to the draggable boundary above them, so a drop past the last draggable row appends.
---@param y number cursor offset from the content top
---@param rows MDT.UI.DropRow[]
---@return integer slot, number indicatorY, boolean noop
function ListMath.DropSlot(y, rows)
  local ordinal, slot, indicatorY = 0, nil, 0
  local firstDragged, lastDragged, draggedCount = nil, nil, 0
  for _, row in ipairs(rows) do
    if row.draggable then
      ordinal = ordinal + 1
      if row.dragged then
        firstDragged = firstDragged or ordinal
        lastDragged = ordinal
        draggedCount = draggedCount + 1
      end
      if not slot and y < row.top + row.height / 2 then
        slot, indicatorY = ordinal, row.top
      end
      if not slot then indicatorY = row.top + row.height end
    end
  end
  slot = slot or ordinal + 1
  local contiguous = draggedCount > 0 and (lastDragged - firstDragged + 1) == draggedCount
  local noop = contiguous and slot >= firstDragged and slot <= lastDragged + 1
  return slot, indicatorY, noop
end

---Scroll speed in content units per second. Negative scrolls up. Ramps inside `edge` of either border and saturates beyond the viewport.
---@param cursorY number cursor offset from the viewport top, growing downward
---@param viewH number
---@param edge number
---@param maxSpeed number
---@return number delta
function ListMath.AutoScroll(cursorY, viewH, edge, maxSpeed)
  if edge <= 0 then return 0 end
  if cursorY < edge then
    return -maxSpeed * math.min(1, (edge - cursorY) / edge)
  end
  if cursorY > viewH - edge then
    return maxSpeed * math.min(1, (cursorY - (viewH - edge)) / edge)
  end
  return 0
end

---Moves `movingKeys` (in their current relative order) so the block starts at `insertIndex` (insert-before, 1..n+1).
---@param order any[] keys in their current order
---@param movingKeys any[]
---@param insertIndex integer
---@return any[] newOrder, boolean changed
function ListMath.Reorder(order, movingKeys, insertIndex)
  local moving = {}
  for _, key in ipairs(movingKeys) do moving[key] = true end
  local kept, block, target = {}, {}, insertIndex
  for index, key in ipairs(order) do
    if moving[key] then
      block[#block + 1] = key
      if index < insertIndex then target = target - 1 end
    else
      kept[#kept + 1] = key
    end
  end
  local newOrder = {}
  for i = 1, target - 1 do newOrder[#newOrder + 1] = kept[i] end
  for _, key in ipairs(block) do newOrder[#newOrder + 1] = key end
  for i = target, #kept do newOrder[#newOrder + 1] = kept[i] end
  local changed = false
  for i = 1, math.max(#order, #newOrder) do
    if order[i] ~= newOrder[i] then changed = true break end
  end
  return newOrder, changed
end

---Scroll offset that brings item `index` into view.
---@param tops number[]
---@param heights number[]
---@param offset number
---@param viewH number
---@param index integer
---@param align "nearest"|"top"|"center"?
---@return number
function ListMath.ScrollTo(tops, heights, offset, viewH, index, align)
  local top, h = tops[index], heights[index]
  if not top then return offset end
  if align == "top" then return top end
  if align == "center" then return top - (viewH - h) / 2 end
  if top < offset then return top end
  if top + h > offset + viewH then return top + h - viewH end
  return offset
end
