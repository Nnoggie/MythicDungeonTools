-- Harness steps for UI.List behaviors the sidebar relies on: a drag origin that scrolls out of view, a missed
-- OnDragStop, scrollbar = false, and reconcile by signature. Not shipped code.
return function(ctx)
  local W, MDT, step, expect, click = ctx.W, ctx.MDT, ctx.step, ctx.expect, ctx.click
  local UI = MDT.UI
  local root = CreateFrame("Frame", "MDTKitListSteps", UIParent)
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
    W.cursorX, W.cursorY = origin:GetCenter()
    W.fireScript(origin, "OnDragStart")
    expect(list:IsDragging(), "drag did not start")
    W.cursorY = list.kitViewport:GetBottom() + 4
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
    W.cursorY = target:GetTop() - 3
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
    W.cursorX, W.cursorY = origin:GetCenter()
    W.fireScript(origin, "OnDragStart")
    local target = list:GetRow(4)
    W.cursorY = target:GetTop() - 3
    W.pump(0.05)
    expect(list:IsDragging() and list.kitIndicator:IsShown(), "drag is not in progress over a slot")
    W.mouseDown = false
    W.pump(0.05)
    expect(not list:IsDragging() and not list.kitGhost:IsShown(), "releasing the button did not end the drag")
    expect(log[#log] == "reorder:1>4", "the release did not drop at the hovered slot: "..tostring(log[#log]))
    expect(UI.Escape.Top() == nil or UI.Escape.Top() ~= list.kitDrag, "the drag left its Escape entry")
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
