-- Harness steps for UI.List behaviors the sidebar relies on: a drag origin that scrolls out of view, a missed
-- OnDragStop, scrollbar = false, and reconcile by signature. Not shipped code.
return function(ctx)
  local W, MDT, step, expect, click = ctx.W, ctx.MDT, ctx.step, ctx.expect, ctx.click
  local UI = MDT.UI
  local root = CreateFrame("Frame", "MDTKitListSteps", UI.Root)
  root:SetSize(300, 200)
  root:SetPoint("CENTER")

  local binds = 0
  local Row = {}
  function Row:OnCreate()
    self.kitLabel = self:CreateFontString(nil, "ARTWORK")
    self.kitLabel:SetFontObject(UI.Fonts.Get("body"))
    self.kitLabel:SetPoint("LEFT", self, "LEFT", 8, 0)
  end
  function Row:Bind(item)
    binds = binds + 1
    self.kitLabel:SetText(item.text)
  end
  local kinds = { row = { height = 28, mixin = Row, draggable = true, selectable = true } }

  local order, sigs, list, log, selection
  local function buildItems()
    local items = {}
    for i, key in ipairs(order) do items[i] = { kind = "row", key = key, sig = sigs[key] or "r"..key, text = "Item "..key } end
    return items
  end
  local function newList(spec)
    order, sigs, log, selection = {}, {}, {}, {}
    for i = 1, 60 do order[i] = i end
    spec.kinds, spec.items, spec.selection = kinds, buildItems(), selection
    spec.onSelect = function(newSelection) selection = newSelection list:SetSelection(newSelection) end
    spec.onReorder = function(keys, slot)
      order = UI.ListMath.Reorder(order, keys, slot)
      log[#log + 1] = "reorder:"..table.concat(keys, ",")..">"..slot
      list:SetItems(buildItems())
    end
    list = UI.List(root, spec)
    list:SetPoint("TOPLEFT", root, "TOPLEFT", 0, 0)
    list:SetPoint("BOTTOMRIGHT", root, "BOTTOMRIGHT", 0, 0)
    UI.Layout.FlushAll()
    list:kitPlaced()
    return list
  end

  step("kit list: the drag origin row survives edge auto-scroll and its drop still lands", function()
    newList({ height = 200 })
    local origin = list:GetRow(2)
    click(origin)
    W.cursorTo(origin)
    W.fireScript(origin, "OnDragStart")
    expect(list:IsDragging(), "drag did not start")
    W.cursorToY(list.kitViewport, list.kitViewport:GetBottom() + 4)
    W.pump(1.5)
    expect(list:GetOffset() > 400, "bottom edge did not scroll far: "..list:GetOffset())
    expect(list:GetRow(2) == origin and origin.kitItem and origin.kitItem.key == 2, "the drag origin row was recycled while scrolled out")
    expect(origin:GetTop() > list.kitViewport:GetTop(), "the origin row is not parked above the viewport")
    local visible = 0
    list:ForEachRow(function() visible = visible + 1 end)
    expect(visible < 14, "rows outside the viewport other than the origin stayed bound: "..visible)
    local targetIndex = math.floor(list:GetOffset() / 28) + 3
    local target = list:GetRow(targetIndex)
    expect(target, "row "..targetIndex.." is not visible after scrolling")
    W.cursorToY(target, target:GetTop() - 3)
    W.pump(0.05)
    expect(list.kitIndicator:IsShown(), "no drop indicator over row "..targetIndex)
    W.fireScript(origin, "OnDragStop")
    expect(not list:IsDragging(), "OnDragStop on the parked origin did not end the drag")
    expect(log[#log] == "reorder:2>"..targetIndex, "drop reported "..tostring(log[#log]))
    expect(order[targetIndex - 1] == 2 and order[targetIndex] == targetIndex, "item 2 did not land before item "..targetIndex..": "..table.concat(order, ",", targetIndex - 3, targetIndex))
    expect(list:GetRow(2) == nil or list:GetRow(2) ~= origin, "the parked origin row was not released after the drop")
    list:Release()
  end)

  step("kit list: a drag whose OnDragStop never arrives ends when the mouse button is released", function()
    newList({ height = 200 })
    local origin = list:GetRow(1)
    click(origin)
    W.cursorTo(origin)
    W.fireScript(origin, "OnDragStart")
    local target = list:GetRow(4)
    W.cursorToY(target, target:GetTop() - 3)
    W.pump(0.05)
    expect(list:IsDragging() and list.kitIndicator:IsShown(), "drag is not in progress over a slot")
    W.mouseDown = false
    W.pump(0.05)
    expect(not list:IsDragging() and not list.kitGhost:IsShown(), "releasing the button did not end the drag")
    expect(log[#log] == "reorder:1>4", "the release did not drop at the hovered slot: "..tostring(log[#log]))
    expect(UI.Escape.Top() == nil or UI.Escape.Top() ~= list.kitDrag, "the drag left its Escape entry")
    list:Release()
  end)

  step("kit list: a grip lifts its row, the rows it passes slide aside, and it stays in its group", function()
    -- Item 1 has no group, 2-6 are group a, 7-10 group b.
    local function groupOf(key)
      if key == 1 then return nil end
      return key <= 6 and "a" or "b"
    end
    local handleKinds = { row = { height = 28, mixin = Row, handle = { tooltip = "Drag to reorder" } } }
    local handleOrder, handleLog = {}, {}
    for i = 1, 10 do handleOrder[i] = i end
    local function handleItems()
      local items = {}
      for i, key in ipairs(handleOrder) do items[i] = { kind = "row", key = key, sig = "h"..key, text = "Item "..key, dragGroup = groupOf(key) } end
      return items
    end
    list = UI.List(root, { height = 200, kinds = handleKinds, items = handleItems(), onReorder = function(keys, slot)
      handleLog[#handleLog + 1] = table.concat(keys, ",")..">"..slot
      local members = {}
      for _, key in ipairs(handleOrder) do
        if groupOf(key) == groupOf(keys[1]) then members[#members + 1] = key end
      end
      local moved, at = UI.ListMath.Reorder(members, keys, slot), 0
      for i, key in ipairs(handleOrder) do
        if groupOf(key) == groupOf(keys[1]) then
          at = at + 1
          handleOrder[i] = moved[at]
        end
      end
      list:SetItems(handleItems())
    end })
    list:SetPoint("TOPLEFT", root, "TOPLEFT", 0, 0)
    list:SetPoint("BOTTOMRIGHT", root, "BOTTOMRIGHT", 0, 0)
    UI.Layout.FlushAll()
    list:kitPlaced()
    local tops = {}
    for i = 1, 7 do tops[i] = list:GetRow(i):GetTop() end
    expect(not list:GetRow(1).kitHandle:IsShown(), "an item without a drag group shows a grip")
    expect(list:GetRow(2).kitHandle:IsShown() and list:GetRow(7).kitHandle:IsShown(), "grouped items show no grip")

    local held = list:GetRow(2)
    local function grab(row)
      W.cursorTo(row.kitHandle)
      W.mouseDown = true
      W.fireScript(row.kitHandle, "OnMouseDown", "LeftButton")
      expect(list:IsDragging(), "pressing the grip did not pick the row up")
    end
    local function release(row)
      W.mouseDown = false
      W.fireScript(row.kitHandle, "OnMouseUp", "LeftButton")
      expect(not list:IsDragging(), "letting go of the grip did not drop the row")
    end
    local function near(a, b) return math.abs(a - b) < 0.5 end

    grab(held)
    W.cursorToY(held, tops[1] + 10)
    W.pump(0.1)
    expect(near(held:GetTop(), tops[2]), "the held row left its group upward: "..held:GetTop().." vs "..tops[2])
    local row4 = list:GetRow(4)
    W.cursorToY(row4, tops[4] - 28 + 4)
    W.pump(0.02)
    expect(near(held:GetTop(), tops[4] - 28 / 2 + 4), "the held row does not follow the cursor: "..held:GetTop())
    expect(row4:GetTop() > tops[4] and row4:GetTop() < tops[3], "row 4 jumped instead of sliding: "..row4:GetTop())
    W.pump(0.5)
    expect(near(list:GetRow(3):GetTop(), tops[2]) and near(row4:GetTop(), tops[3]), "rows 3 and 4 did not slide up into the gap")
    expect(near(list:GetRow(5):GetTop(), tops[5]), "row 5 moved although the held row is above it")
    release(held)
    expect(handleLog[#handleLog] == "2>4", "the drop reported "..tostring(handleLog[#handleLog]))
    expect(table.concat(handleOrder, ",", 1, 6) == "1,3,4,2,5,6", "item 2 did not land after item 4: "..table.concat(handleOrder, ","))
    for i = 1, 7 do expect(near(list:GetRow(i):GetTop(), tops[i]), "row "..i.." is not back in its slot after the drop") end

    local count = #handleLog
    held = list:GetRow(3)
    grab(held)
    W.cursorToY(held, tops[6])
    W.pump(0.5)
    click(held.kitHandle, "RightButton")
    expect(not list:IsDragging() and #handleLog == count, "a right-click on the grip did not cancel the drag")
    for i = 1, 7 do expect(near(list:GetRow(i):GetTop(), tops[i]), "row "..i.." stayed displaced after a cancel") end

    held = list:GetRow(3)
    grab(held)
    W.cursorToY(held, tops[6])
    W.pump(0.2)
    local changed = handleItems()
    changed[5].sig = "renamed"
    list:SetItems(changed)
    release(held)
    expect(#handleLog == count, "a drop after its group changed was reported: "..tostring(handleLog[#handleLog]))

    held = list:GetRow(7)
    grab(held)
    W.pump(0.3)
    expect(list:GetOffset() == 0, "holding a grip at the bottom edge scrolled before the cursor moved: "..list:GetOffset())
    W.cursorToY(held, tops[3])
    W.pump(0.1)
    expect(near(held:GetTop(), tops[7]), "a group b row moved into group a")
    release(held)
    expect(#handleLog == count, "a drop back on its own slot reported a reorder")

    held = list:GetRow(1)
    W.cursorTo(held.kitHandle)
    W.fireScript(held.kitHandle, "OnMouseDown", "LeftButton")
    expect(not list:IsDragging(), "an item without a drag group was picked up")
    list:Release()
  end)

  step("kit list: scrollbar = false hides the bar and the viewport spans the full width", function()
    newList({ height = 200, scrollbar = false })
    expect(not list.kitBar:IsShown(), "scrollbar shown with scrollbar = false")
    expect(list.kitViewport:GetWidth() == list:GetWidth(), "viewport is inset for a hidden scrollbar")
    list:SetOffset(300)
    expect(list:GetOffset() == 300 and not list.kitBar:IsShown(), "scrolling showed the hidden bar")
    list:Release()
    newList({ height = 200 })
    expect(list.kitBar:IsShown() and list.kitViewport:GetWidth() < list:GetWidth(), "the default scrollbar is missing")
    list:Release()
  end)

  step("kit list: SetItems with fresh tables rebinds only the visible rows whose sig changed", function()
    newList({ height = 200 })
    binds = 0
    list:SetItems(buildItems())
    expect(binds == 0, "same sigs rebound "..binds.." rows")
    expect(list:GetRow(1).kitItem == list.kitProps.items[1], "rows do not point at the newest item tables")
    sigs[3] = "changed"
    list:SetItems(buildItems())
    expect(binds == 1 and list:GetRow(3).kitItem.sig == "changed", "one changed sig rebound "..binds.." rows")
    sigs[50] = "changed"
    binds = 0
    list:SetItems(buildItems())
    expect(binds == 0, "a change outside the viewport rebound "..binds.." rows")
    list:ScrollTo(50, "nearest")
    expect(list:GetRow(50) and list:GetRow(50).kitItem.sig == "changed", "scrolling in did not bind the changed row")
    list:Release()
  end)
end
