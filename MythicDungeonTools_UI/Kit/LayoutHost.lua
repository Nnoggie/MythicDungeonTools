local _, MDT = ...
local UI = MDT.UI
local Layout = UI.Layout

---Batched relayout: setters mark a container dirty, one flush runs on the next frame, parents first.
local dirty, queue, paused = {}, {}, 0

local ticker = CreateFrame("Frame", nil, UIParent)
ticker:Hide()

---@param container MDT.UI.Control
function Layout.Invalidate(container)
  if container.kitReleased or dirty[container] or not container.kitLayout then return end
  dirty[container] = true
  queue[#queue + 1] = container
  if paused == 0 then ticker:Show() end
end

local function depth(container)
  local d = 0
  while container.kitParent do
    d = d + 1
    container = container.kitParent
  end
  return d
end

local MAX_PASSES = 32

---Lays out every dirty container until none is left. A child whose height changed re-dirties its parent, so a deep tree takes one pass per level.
function Layout.FlushAll()
  for _ = 1, MAX_PASSES do
    if #queue == 0 then break end
    local batch = queue
    queue, dirty = {}, {}
    local depths = {}
    for i, container in ipairs(batch) do depths[container] = depth(container) * 100000 + i end
    table.sort(batch, function(a, b) return depths[a] < depths[b] end)
    for _, container in ipairs(batch) do
      if not container.kitReleased then
        container:kitLayout()
        if container.kitProps.onLayout then container:Emit("onLayout", container) end
      end
    end
  end
  if #queue > 0 then
    queue, dirty = {}, {}
    UI.ReportError("MDT UI: layout did not settle after "..MAX_PASSES.." passes")
  end
  ticker:Hide()
end

UI.Script(ticker, "OnUpdate", Layout.FlushAll)

---Runs `fn` with layout paused, then flushes once synchronously so sizes are known when it returns.
---@param container MDT.UI.Control
---@param fn fun()
function Layout.Batch(container, fn)
  paused = paused + 1
  local ok, err = pcall(fn)
  paused = paused - 1
  Layout.Invalidate(container)
  if paused == 0 then Layout.FlushAll() end
  if not ok then error(err, 0) end
end

---@return boolean
function Layout.IsDirty()
  return #queue > 0
end
