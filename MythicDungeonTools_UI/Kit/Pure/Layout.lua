local _, MDT = ...
local UI = MDT.UI or {}
MDT.UI = UI

---@class MDT.UI.LayoutMath
local Layout = {}
UI.Layout = Layout

---@class MDT.UI.LayoutItem
---@field w number? natural width; nil means "stretch" in a Stack
---@field h number natural height
---@field grow number? share of leftover space along the main axis
---@field hidden boolean? takes no space and no gap

---@class MDT.UI.LayoutRect
---@field x number offset from the left edge
---@field y number offset from the top edge, growing downward
---@field w number
---@field h number

local function totalGrow(items)
  local sum = 0
  for _, item in ipairs(items) do
    if not item.hidden and (item.grow or 0) > 0 then sum = sum + item.grow end
  end
  return sum
end

---Vertical stack. Children stretch to the inner width unless they bring a width.
---@param items MDT.UI.LayoutItem[]
---@param o {width: number, height: number?, gap: number?, pad: number?, align: "stretch"|"start"|"center"|"end"?}
---@return (MDT.UI.LayoutRect|false)[] rects, number totalHeight
function Layout.Stack(items, o)
  local gap, pad = o.gap or 0, o.pad or 0
  local innerW = o.width - pad * 2
  local rects, visible, content = {}, 0, 0
  for i, item in ipairs(items) do
    if item.hidden then
      rects[i] = false
    else
      visible = visible + 1
      content = content + item.h
    end
  end
  local gaps = math.max(0, visible - 1) * gap
  local leftover = o.height and (o.height - pad * 2 - content - gaps) or 0
  local grow = totalGrow(items)
  local y = pad
  for i, item in ipairs(items) do
    if not item.hidden then
      local w = item.w or innerW
      local x = pad
      if w < innerW then
        if o.align == "center" then x = pad + (innerW - w) / 2 elseif o.align == "end" then x = pad + innerW - w end
      end
      local h = item.h
      if leftover > 0 and grow > 0 and (item.grow or 0) > 0 then h = h + leftover * item.grow / grow end
      rects[i] = { x = x, y = y, w = w, h = h }
      y = y + h + gap
    end
  end
  local total = visible > 0 and (y - gap + pad) or pad * 2
  if o.height then total = math.max(total, o.height) end
  return rects, total
end

---Horizontal row with optional greedy wrapping. Items keep their natural width; grow shares line slack.
---@param items MDT.UI.LayoutItem[]
---@param o {width: number, gap: number?, pad: number?, wrap: boolean?, align: "start"|"center"|"end"|"spread"?, valign: "center"|"start"|"end"|"stretch"?, lineHeight: number?}
---@return (MDT.UI.LayoutRect|false)[] rects, number totalHeight
function Layout.Row(items, o)
  local gap, pad = o.gap or 0, o.pad or 0
  local innerW = o.width - pad * 2
  local rects = {}
  local lines, line, lineW = {}, {}, 0
  for i, item in ipairs(items) do
    if item.hidden then
      rects[i] = false
    else
      local w = item.w or 0
      local needed = lineW + (#line > 0 and gap or 0) + w
      if o.wrap and #line > 0 and needed > innerW then
        lines[#lines + 1] = line
        line, lineW = {}, 0
        needed = w
      end
      line[#line + 1] = i
      lineW = needed
    end
  end
  if #line > 0 then lines[#lines + 1] = line end
  local y = pad
  for li, indices in ipairs(lines) do
    local used, grow, lineH = 0, 0, o.lineHeight or 0
    for _, i in ipairs(indices) do
      local item = items[i]
      used = used + (item.w or 0)
      grow = grow + (item.grow or 0)
      lineH = math.max(lineH, item.h)
    end
    used = used + math.max(0, #indices - 1) * gap
    local slack = math.max(0, innerW - used)
    local x, spread = pad, 0
    if grow == 0 then
      if o.align == "center" then x = pad + slack / 2
      elseif o.align == "end" then x = pad + slack
      elseif o.align == "spread" and #indices > 1 then spread = slack / (#indices - 1) end
    end
    for _, i in ipairs(indices) do
      local item = items[i]
      local w = (item.w or 0) + (grow > 0 and (item.grow or 0) > 0 and slack * item.grow / grow or 0)
      local h = o.valign == "stretch" and lineH or item.h
      local dy = 0
      if o.valign == "end" then dy = lineH - h elseif o.valign ~= "start" and o.valign ~= "stretch" then dy = (lineH - h) / 2 end
      rects[i] = { x = x, y = y + dy, w = w, h = h }
      x = x + w + gap + spread
    end
    y = y + lineH + (li < #lines and gap or 0)
  end
  local total = #lines > 0 and (y + pad) or pad * 2
  return rects, total
end

---Column bands for a weighted split. The last column absorbs rounding.
---@param width number
---@param weights number[]
---@param gap number?
---@return {x: number, w: number}[]
function Layout.Columns(width, weights, gap)
  gap = gap or 0
  local sum = 0
  for _, weight in ipairs(weights) do sum = sum + weight end
  local free = width - gap * math.max(0, #weights - 1)
  local bands, x = {}, 0
  for i, weight in ipairs(weights) do
    local w = i < #weights and math.floor(free * weight / sum) or (width - x)
    bands[i] = { x = x, w = w }
    x = x + w + gap
  end
  return bands
end
