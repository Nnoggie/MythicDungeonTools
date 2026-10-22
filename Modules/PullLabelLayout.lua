local _, MDT = ...

---Where each pull's label goes on the map. Pure: no frames, no WoW API; scripts/test_kit.lua loads it with a stub MDT.
---
---A label starts at the area center of its pull's outline and walks outwards along a spiral, the way word clouds place
---words (Wordle, d3-cloud). The spiral is stretched sideways by the label's width, since labels are wider than tall.
---A spot is out when the label would leave the bounds, cover a pin or a label placed before it, or reach far into an
---enemy's portrait. Every other spot gets a cost, and the cheapest wins:
---  - fully inside the pull's own outline is best, the nearer its center the better
---  - partly inside costs more the less of the label is inside
---  - outside costs more again, growing with the gap to the outline
---  - covering the edge of an enemy's portrait adds to that, the deeper the more
---  - on another pull's outline line, or inside another pull while outside its own, adds to that
---So a label sits in its pull, between the enemies when they leave little room, rather than beside it, and beside it
---rather than far away. The search stops once no spot further out could be cheaper than the best one found. A label
---with no spot at all stays on the area center.
---
---Points are {x, y} in any orientation; MDT's map runs from 0 down to negative y.
---@class MDT.PullLabelLayout
local Layout = {}
MDT.PullLabelLayout = Layout

local abs, cos, sin, sqrt, max, min, pi = math.abs, math.cos, math.sin, math.sqrt, math.max, math.min, math.pi

---@class MDT.PullLabelRequest
---@field key any comes back as the placement's key
---@field outline number[][] the pull's outline as drawn, a convex polygon
---@field width number
---@field height number
---@field previous {x: number, y: number, cost: number}? where the label was, to keep it there while that is still about as good

---@class MDT.PullLabelPlacement
---@field x number the label's center
---@field y number
---@field anchorX number the outline's area center, where the search started
---@field anchorY number
---@field cost number what the spot cost; math.huge when no spot was free
---@field leaderX number? where a leader line from the label meets the outline; nil when the label is on or beside it
---@field leaderY number?

---@class MDT.PullLabelOptions
---@field pad number? free space kept around each label
---@field bounds {left: number, right: number, top: number, bottom: number}? labels stay inside; top > bottom
---@field pins number[][]? {x, y, radius} of points of interest and notes, which labels never cover
---@field reach number? how far past its outline a label may go, in label heights (default 6)
---@field leaderGap number? a label further than this from its outline gets a leader line, in label heights (default 0.75)
---@field pause fun()? called now and then during the search, so a caller in a coroutine can yield

---Costs, in label heights where they grow with distance.
local COST = {
  ---Per label height from the center, fully inside the own outline; capped below every spot that is not fully inside.
  insidePerHeight = 0.25, insideMax = 0.9,
  ---Partly inside: this, plus the outside share of the label times partlyOutside.
  partly = 1, partlyOutside = 1.5,
  ---Outside the own outline, plus per label height of gap to it.
  outside = 2, outsidePerHeight = 1.5,
  ---Per enemy, times how deep the label reaches into its portrait, as a share of the portrait's radius.
  coverEnemy = 2,
  ---On another pull's outline line, or on the own line from outside.
  crossesLine = 1,
  ---Inside another pull: a little when inside the own outline too (nested pulls), a lot when outside it, where the label
  ---would pass for the other pull's.
  insideOtherNested = 0.3, insideOther = 3,
}
---A label may reach this far into an enemy's portrait, as a share of its radius; it never covers the enemy's face.
local MAX_COVER = 0.45
---A previous spot stays while it costs at most this much more than it did.
local KEEP_SLACK = 0.25
---How many spots are tested between calls to opts.pause.
local PAUSE_EVERY = 250

---The area-weighted center of a polygon. Unlike the average of its points, a dense group of points does not pull it
---towards itself. Polygons with no area (one or two points) use the average.
---@param poly number[][]
---@return number x, number y
function Layout.AreaCenter(poly)
  local n = #poly
  local area, cx, cy = 0, 0, 0
  for i = 1, n do
    local p, q = poly[i], poly[i % n + 1]
    local f = p[1] * q[2] - q[1] * p[2]
    area = area + f
    cx = cx + (p[1] + q[1]) * f
    cy = cy + (p[2] + q[2]) * f
  end
  if abs(area) > 1e-6 then return cx / (3 * area), cy / (3 * area) end
  local sx, sy = 0, 0
  for i = 1, n do sx, sy = sx + poly[i][1], sy + poly[i][2] end
  return sx / n, sy / n
end

---Whether a convex polygon, wound either way, holds a point. Points on the edge count as inside.
---@param poly number[][]
---@param x number
---@param y number
---@return boolean
function Layout.Contains(poly, x, y)
  local n = #poly
  if n < 3 then return false end
  local sign = 0
  for i = 1, n do
    local p, q = poly[i], poly[i % n + 1]
    local c = (q[1] - p[1]) * (y - p[2]) - (q[2] - p[2]) * (x - p[1])
    if c ~= 0 then
      local side = c > 0 and 1 or -1
      if sign == 0 then
        sign = side
      elseif side ~= sign then
        return false
      end
    end
  end
  return true
end

---The point on a polygon's outline closest to x, y.
---@param poly number[][]
---@param x number
---@param y number
---@return number x, number y
function Layout.NearestOnOutline(poly, x, y)
  local n = #poly
  local bestX, bestY, best = poly[1][1], poly[1][2], math.huge
  for i = 1, n do
    local p, q = poly[i], poly[i % n + 1]
    local dx, dy = q[1] - p[1], q[2] - p[2]
    local length = dx * dx + dy * dy
    local t = length > 0 and max(0, min(1, ((x - p[1]) * dx + (y - p[2]) * dy) / length)) or 0
    local px, py = p[1] + t * dx, p[2] + t * dy
    local distance = (px - x) ^ 2 + (py - y) ^ 2
    if distance < best then best, bestX, bestY = distance, px, py end
  end
  return bestX, bestY
end

local function boxOf(poly)
  local left, right, bottom, top = math.huge, -math.huge, math.huge, -math.huge
  for _, p in ipairs(poly) do
    left, right = min(left, p[1]), max(right, p[1])
    bottom, top = min(bottom, p[2]), max(top, p[2])
  end
  return { left = left, right = right, bottom = bottom, top = top }
end

local function boxesTouch(a, left, right, bottom, top)
  return a.left <= right and a.right >= left and a.bottom <= top and a.top >= bottom
end

---Whether the segment from x1, y1 to x2, y2 touches a box (Liang-Barsky clipping).
local function segmentTouchesBox(x1, y1, x2, y2, left, right, bottom, top)
  local dx, dy = x2 - x1, y2 - y1
  local t0, t1 = 0, 1
  for side = 1, 4 do
    local p, q
    if side == 1 then
      p, q = -dx, x1 - left
    elseif side == 2 then
      p, q = dx, right - x1
    elseif side == 3 then
      p, q = -dy, y1 - bottom
    else
      p, q = dy, top - y1
    end
    if p == 0 then
      if q < 0 then return false end
    else
      local u = q / p
      if p < 0 then
        if u > t1 then return false end
        if u > t0 then t0 = u end
      else
        if u < t0 then return false end
        if u < t1 then t1 = u end
      end
    end
  end
  return true
end

---The edges of the given outlines that reach into a box, as {x1, y1, x2, y2, left, right, bottom, top}.
local function edgesNear(polys, left, right, bottom, top)
  local edges = {}
  for _, poly in ipairs(polys) do
    local n = #poly
    for i = 1, n do
      local p, q = poly[i], poly[i % n + 1]
      local l, r, b, t = min(p[1], q[1]), max(p[1], q[1]), min(p[2], q[2]), max(p[2], q[2])
      if l <= right and r >= left and b <= top and t >= bottom then
        edges[#edges + 1] = { p[1], p[2], q[1], q[2], l, r, b, t }
      end
    end
  end
  return edges
end

local function crossesLine(edges, l, r, b, t)
  for _, e in ipairs(edges) do
    if e[5] <= r and e[6] >= l and e[7] <= t and e[8] >= b and segmentTouchesBox(e[1], e[2], e[3], e[4], l, r, b, t) then
      return true
    end
  end
  return false
end

---Places labels in the order given; earlier labels get the better spots.
---@param requests MDT.PullLabelRequest[]
---@param enemies number[][] {x, y, radius} of every enemy's portrait
---@param opts MDT.PullLabelOptions?
---@return table<any, MDT.PullLabelPlacement> placements by request key
function Layout.Place(requests, enemies, opts)
  opts = opts or {}
  local pad, bounds = opts.pad or 0, opts.bounds
  local boxes = {}
  for i, request in ipairs(requests) do boxes[i] = boxOf(request.outline) end
  local placed, placements = {}, {}
  local tested = 0

  for i, request in ipairs(requests) do
    local own = request.outline
    local width, height = request.width, request.height
    local halfW, halfH = width / 2, height / 2
    local anchorX, anchorY = Layout.AreaCenter(own)
    local ownRadius = 0
    for _, p in ipairs(own) do ownRadius = max(ownRadius, sqrt((p[1] - anchorX) ^ 2 + (p[2] - anchorY) ^ 2)) end
    local reach = ownRadius + height * (opts.reach or 6)
    local stretch = sqrt(max(1, min(3, width / height)))
    local ownBox, halfDiagonal = boxes[i], sqrt(halfW * halfW + halfH * halfH)

    -- Only what the search can reach is tested.
    local near = reach * stretch + halfW + halfH + pad
    local nearLeft, nearRight, nearBottom, nearTop = anchorX - near, anchorX + near, anchorY - near, anchorY + near
    local nearEnemies, nearPins, others, otherPolys = {}, {}, {}, {}
    local function addNear(into, list)
      for _, item in ipairs(list) do
        local r = item[3]
        if item[1] + r >= nearLeft and item[1] - r <= nearRight and item[2] + r >= nearBottom and item[2] - r <= nearTop then
          into[#into + 1] = item
        end
      end
    end
    addNear(nearEnemies, enemies)
    addNear(nearPins, opts.pins or {})
    for j, box in ipairs(boxes) do
      if j ~= i and boxesTouch(box, nearLeft, nearRight, nearBottom, nearTop) then
        others[#others + 1] = { poly = requests[j].outline, box = box }
        otherPolys[#otherPolys + 1] = requests[j].outline
      end
    end
    local otherEdges = edgesNear(otherPolys, nearLeft, nearRight, nearBottom, nearTop)
    local ownEdges = edgesNear({ own }, nearLeft, nearRight, nearBottom, nearTop)

    ---What a spot costs; nil when the label cannot go there. r is the spot's distance along the spiral. A spot that
    ---cannot beat limit comes back as soon as that is clear, without the costs it would add on top.
    local function cost(x, y, r, limit)
      tested = tested + 1
      if opts.pause and tested % PAUSE_EVERY == 0 then opts.pause() end
      local left, right, bottom, top = x - halfW - pad, x + halfW + pad, y - halfH - pad, y + halfH + pad
      if bounds and (left < bounds.left or right > bounds.right or bottom < bounds.bottom or top > bounds.top) then return end
      local l, rr, b, t = x - halfW, x + halfW, y - halfH, y + halfH
      local value, insideOwn
      local touchesOwn = boxesTouch(ownBox, l, rr, b, t)
      local corners = 0
      if touchesOwn then
        for _, corner in ipairs({ { l, b }, { rr, b }, { l, t }, { rr, t } }) do
          if Layout.Contains(own, corner[1], corner[2]) then corners = corners + 1 end
        end
      end
      if corners == 4 then
        insideOwn = true
        value = min(COST.insidePerHeight * r / height, COST.insideMax)
      elseif touchesOwn and (corners > 0 or Layout.Contains(own, x, y) or crossesLine(ownEdges, l, rr, b, t)) then
        -- Partly inside: the share of a grid of points over the label that the outline holds.
        insideOwn = Layout.Contains(own, x, y)
        local held, samples = 0, 0
        for column = 0, 4 do
          for row = 0, 2 do
            samples = samples + 1
            if Layout.Contains(own, l + (rr - l) * column / 4, b + (t - b) * row / 2) then held = held + 1 end
          end
        end
        value = COST.partly + COST.partlyOutside * (1 - held / samples)
      else
        -- No point of the outline is further than ownRadius from the center, which bounds the gap from below.
        local nearest = max(0, sqrt((x - anchorX) ^ 2 + (y - anchorY) ^ 2) - ownRadius - halfDiagonal)
        if limit and COST.outside + COST.outsidePerHeight * nearest / height >= limit then return limit end
        local lx, ly = Layout.NearestOnOutline(own, x, y)
        local gx, gy = max(0, abs(lx - x) - halfW), max(0, abs(ly - y) - halfH)
        value = COST.outside + COST.outsidePerHeight * sqrt(gx * gx + gy * gy) / height
      end
      if limit and value >= limit then return value end
      for _, pin in ipairs(nearPins) do
        local px, py, pr = pin[1], pin[2], pin[3]
        local dx, dy = max(left, min(px, right)) - px, max(bottom, min(py, top)) - py
        if dx * dx + dy * dy < pr * pr then return end
      end
      for _, other in ipairs(placed) do
        if left < other.right and right > other.left and bottom < other.top and top > other.bottom then return end
      end
      for _, enemy in ipairs(nearEnemies) do
        local ex, ey, er = enemy[1], enemy[2], enemy[3]
        local dx, dy = max(l, min(ex, rr)) - ex, max(b, min(ey, t)) - ey
        local distance = dx * dx + dy * dy
        if distance < er * er then
          local depth = 1 - sqrt(distance) / er
          if depth > MAX_COVER then return end
          value = value + COST.coverEnemy * depth
        end
      end
      if limit and value >= limit then return value end
      local insideOther = false
      for _, other in ipairs(others) do
        if boxesTouch(other.box, x, x, y, y) and Layout.Contains(other.poly, x, y) then
          insideOther = true
          break
        end
      end
      if insideOther then value = value + (insideOwn and COST.insideOtherNested or COST.insideOther) end
      if crossesLine(otherEdges, l, rr, b, t) or (not insideOwn and crossesLine(ownEdges, l, rr, b, t)) then
        value = value + COST.crossesLine
      end
      return value
    end

    ---The least a spot at spiral distance r or further out can cost.
    local function cheapestFrom(r)
      local outsideGap = max(0, r - ownRadius - halfDiagonal)
      local outside = COST.outside + COST.outsidePerHeight * outsideGap / height
      -- A spiral point is at least r from the center, so past the outline's radius none is fully inside it, and past
      -- that plus the label's reach none is partly inside.
      if r > ownRadius + halfDiagonal then return outside end
      if r > ownRadius then return min(COST.partly, outside) end
      return min(COST.insidePerHeight * r / height, outside)
    end

    local x, y, best
    local previous = request.previous
    if previous then
      local value = cost(previous.x, previous.y, sqrt(((previous.x - anchorX) / stretch) ^ 2 + (previous.y - anchorY) ^ 2))
      -- The kept spot stays measured against its cost when it was found, so small rises cannot add up over redraws.
      if value and value <= previous.cost + KEEP_SLACK then x, y, best = previous.x, previous.y, min(value, previous.cost) end
    end
    if not x then
      -- An Archimedean spiral, its turns and its points about step apart.
      local step = height / 2
      local theta, r = 0, 0
      while r <= reach and (not best or cheapestFrom(r) < best) do
        local px, py = anchorX + stretch * r * cos(theta), anchorY + r * sin(theta)
        local value = cost(px, py, r, best)
        if value and (not best or value < best) then x, y, best = px, py, value end
        theta = theta + (r < step and 0.8 or step / r)
        r = step * theta / (2 * pi)
      end
    end
    x, y = x or anchorX, y or anchorY

    local placement = { x = x, y = y, anchorX = anchorX, anchorY = anchorY, cost = best or math.huge }
    if not Layout.Contains(own, x, y) then
      local lx, ly = Layout.NearestOnOutline(own, x, y)
      local dx, dy = max(0, abs(lx - x) - halfW), max(0, abs(ly - y) - halfH)
      if sqrt(dx * dx + dy * dy) > height * (opts.leaderGap or 0.75) then
        placement.leaderX, placement.leaderY = lx, ly
      end
    end
    placements[request.key] = placement
    placed[#placed + 1] = { left = x - halfW, right = x + halfW, bottom = y - halfH, top = y + halfH }
    if opts.pause then opts.pause() end
  end
  return placements
end
