-- Harness steps for the kit sidebar: route list, level stepper, forces bar, pull rows, drag reorder,
-- context menu, the more menu and its dialogs, live state and hover. Driven through real frames. Not shipped code.
return function(ctx)
  local W, MDT, step, expect, click, asyncIdle = ctx.W, ctx.MDT, ctx.step, ctx.expect, ctx.click, ctx.asyncIdle
  local typeInto, unusedPresetName, presetCount = ctx.typeInto, ctx.unusedPresetName, ctx.presetCount
  local UI = MDT.UI
  local L = MDT.L
  local main = MDT.main_frame
  local db = MDT:GetDB()

  local function control(id)
    local found = MDT:GetSidebarControl(id)
    expect(found, "sidebar control "..id.." is missing")
    return found
  end
  local function preset() return MDT:GetCurrentPreset() end
  local function pulls() return preset().value.pulls end
  local function selection() return table.concat(MDT:GetSelection(), ",") end
  local function tagPulls()
    for i, pull in ipairs(pulls()) do pull.tag = i end
  end
  local function tags()
    local list = {}
    for i, pull in ipairs(pulls()) do list[i] = tostring(pull.tag or "-") end
    return table.concat(list, ",")
  end
  local function listOf(popover)
    for _, child in ipairs(popover.frame.content.kitChildren) do
      if child.kit.name == "List" then return child end
    end
  end
  local function rowByText(list, text)
    for index, item in ipairs(list.kitProps.items) do
      if item.text == text then
        list:ScrollTo(index, "nearest")
        return list:GetRow(index), item
      end
    end
  end
  local function rowOfKind(list, kind)
    for index, item in ipairs(list.kitProps.items) do
      if item.kind == kind then
        list:ScrollTo(index, "nearest")
        return list:GetRow(index), index
      end
    end
  end
  local function routeRow(name)
    local list = control("routes")
    for index, item in ipairs(list.kitProps.items) do
      if item.name == name then
        list:ScrollTo(index, "nearest")
        return list:GetRow(index), item
      end
    end
  end
  local ROUTE_MENU_LABELS = { rename = "Rename", duplicate = "Duplicate", export = "Export", delete = "Delete this route" }
  local function routeMenu(name)
    local row = routeRow(name)
    expect(row, "route "..tostring(name).." is not listed")
    click(row, "RightButton")
    local menu = UI.Overlay.Top("menu")
    expect(menu and menu.frame:IsVisible(), "right-clicking a route did not open its menu")
    return listOf(menu)
  end
  local function routeAction(name, action)
    local menuRow, item = rowByText(routeMenu(name), ROUTE_MENU_LABELS[action])
    expect(menuRow and not item.disabled, action.." is missing or disabled in the route menu")
    click(menuRow)
    W.settle(asyncIdle, 30)
  end
  local function currentRouteRow()
    local list = control("routes")
    for index, item in ipairs(list.kitProps.items) do
      if item.isCurrent then return list:GetRow(index), item end
    end
  end
  local function contextMenu(row)
    click(row, "RightButton")
    local menu = UI.Overlay.Top("menu")
    expect(menu and menu.frame:IsVisible(), "right-click did not open the context menu")
    return listOf(menu)
  end
  local function menuLabels(list)
    local labels = {}
    for _, item in ipairs(list.kitProps.items) do labels[#labels + 1] = item.kind == "separator" and "-" or item.text end
    return table.concat(labels, "|")
  end
  local function drag(fromRow, targetRow, half)
    W.cursorX, W.cursorY = fromRow:GetCenter()
    W.fireScript(fromRow, "OnDragStart")
    expect(control("pulls"):IsDragging(), "drag did not start")
    if half == "top" then W.cursorY = targetRow:GetTop() - 3 else W.cursorY = targetRow:GetBottom() + 3 end
    W.pump(0.05)
    W.fireScript(fromRow, "OnDragStop")
    W.settle(asyncIdle, 30)
  end
  local function ensurePulls(count)
    while #pulls() < count do MDT:AddPull() end
    W.settle(asyncIdle, 30)
  end

  step("sidebar: search on top, the route actions row, the route list, the level and the forces bar", function()
    expect(control("routeSearch"):GetTop() >= control("newRoute"):GetTop(), "search is not above the route actions")
    expect(control("newRoute"):GetHeight() >= 32, "route action buttons are small: "..control("newRoute"):GetHeight())
    local _, current = currentRouteRow()
    expect(current and current.name == preset().text, "current route row is "..tostring(current and current.name))
    expect(control("level"):GetValue() == db.currentDifficulty, "stepper value is "..tostring(control("level"):GetValue()))
    local total = MDT.dungeonTotalCount[db.currentDungeonIdx].normal
    expect(control("forces").kitText:GetText() == MDT.SidebarModel.FormatForcesTotal(MDT:CountForces(), total), "forces text is "..tostring(control("forces").kitText:GetText()))
    expect(control("routes"):GetWidth() > 150 and control("pulls"):GetHeight() > 150, "sidebar layout has no size")
  end)

  step("sidebar: every route action button shows its tooltip, also while disabled, with its icon centered", function()
    expect(control("shareRoute"):IsDisabled(), "setup: share should be disabled outside a group")
    for _, id in ipairs({ "shareRoute", "newRoute", "exportRoute", "importRoute" }) do
      local button = control(id)
      GameTooltip:Hide()
      W.hover(button)
      expect(GameTooltip:IsShown() and GameTooltip:GetOwner() == button, id.." shows no tooltip"..(button:IsDisabled() and " while disabled" or ""))
      if id == "shareRoute" then -- the harness player is never in a group
        local lines = W.state[GameTooltip].lines or {}
        expect(lines[2] == "Join a group first", id.." tooltip does not say why it is disabled: "..table.concat(lines, " / "))
      end
      W.fireScript(button, "OnLeave")
      local ix, iy = button.kitIcon:GetCenter()
      local bx, by = button:GetCenter()
      expect(math.abs(ix - bx) < 0.5 and math.abs(iy - by) < 0.5, ("%s icon is off center by %.1f, %.1f"):format(id, ix - bx, iy - by))
    end
  end)

  step("sidebar: + Add pull appends a pull and selects it", function()
    local before = #pulls()
    local row = rowOfKind(control("pulls"), "newPull")
    expect(row, "no + Add pull row")
    click(row)
    W.settle(asyncIdle, 30)
    expect(#pulls() == before + 1, ("pull count %d, expected %d"):format(#pulls(), before + 1))
    expect(preset().value.currentPull == before + 1, "the new pull is not selected")
  end)

  step("add an enemy to the current pull by clicking its blip", function()
    local blip
    for _, frame in ipairs(MDT.dungeonEnemies_framePool.active) do
      if frame:IsVisible() and frame.data then blip = frame break end
    end
    expect(blip, "no visible enemy blip on the map")
    click(blip, "LeftButton")
    W.settle(asyncIdle, 30)
    local current = pulls()[preset().value.currentPull]
    expect(current and next(current) ~= nil, "current pull has no enemies after clicking a blip")
    local list = control("pulls")
    local row = list:GetRow(preset().value.currentPull)
    expect(row and row.kitPortraits[1]:IsShown(), "the pull row shows no portrait for the enemy")
    expect(row.kitPull:GetText():sub(1, 1) == "+", "the pull row shows no forces: "..tostring(row.kitPull:GetText()))
  end)

  step("enemy blip right-click opens the kit context menu with the target marker submenu", function()
    local blip
    for _, frame in ipairs(MDT.dungeonEnemies_framePool.active) do
      if frame:IsVisible() and frame.data then blip = frame break end
    end
    expect(blip, "no visible enemy blip on the map")
    click(blip, "RightButton")
    local menu = UI.Overlay.Top("menu")
    expect(menu and menu.frame:IsVisible(), "right-click on a blip did not open a kit menu")
    local list = listOf(menu)
    expect(menuLabels(list) == L[blip.data.name].."|Set Target Marker|Open Enemy Info", "enemy menu is "..menuLabels(list))
    click(rowByText(list, "Set Target Marker"))
    local submenu = UI.Overlay.Top("menu")
    expect(submenu and submenu ~= menu and submenu.frame:IsVisible(), "the marker submenu did not open")
    local markers = listOf(submenu)
    expect(#markers.kitProps.items == 10, "marker submenu has "..#markers.kitProps.items.." rows")
    db.hasSeenAssignmentWarning = true
    click(markers:GetRow(2))
    W.settle(asyncIdle, 30)
    local assignments = preset().value.enemyAssignments
    expect(assignments[blip.enemyIdx] and assignments[blip.enemyIdx][blip.cloneIdx] == 2, "picking a marker did not assign it")
    expect(UI.Overlay.Top("menu") == nil, "the menu chain stayed open after a pick")
    click(blip, "RightButton")
    click(rowByText(listOf(UI.Overlay.Top("menu")), "Set Target Marker"))
    markers = listOf(UI.Overlay.Top("menu"))
    expect(markers:GetRow(2).kitCheck:IsShown() and not markers:GetRow(1).kitCheck:IsShown(), "the assigned marker is not checked")
    UI.Menu.Close()
  end)

  step("sidebar: clicking a pull selects it and outlines the row", function()
    local list = control("pulls")
    click(list:GetRow(1), "LeftButton")
    expect(preset().value.currentPull == 1 and selection() == "1", "pull 1 is not selected: "..selection())
    expect(list:GetRow(1).kitRowBorder.textures.top:IsShown(), "selected row is not outlined")
    expect(not list:GetRow(2).kitRowBorder.textures.top:IsShown(), "unselected row is outlined")
  end)

  step("sidebar: shift and ctrl clicks build a multi-selection", function()
    ensurePulls(4)
    local list = control("pulls")
    click(list:GetRow(1))
    W.modifiers = { shift = true }
    click(list:GetRow(3))
    expect(selection() == "1,2,3", "shift-click selection is "..selection())
    W.modifiers = { ctrl = true }
    click(list:GetRow(2))
    expect(selection() == "1,3", "ctrl-click removal gives "..selection())
    click(list:GetRow(4))
    W.modifiers = nil
    expect(selection() == "1,3,4", "ctrl-click addition gives "..selection())
    expect(list:GetRow(3).kitRowBorder.textures.top:IsShown() and not list:GetRow(2).kitRowBorder.textures.top:IsShown(), "multi-selection is not painted")
  end)

  step("sidebar: right-click opens the kit context menu, Shift+right-click deletes, Ctrl+right-click does nothing", function()
    ensurePulls(4)
    local list = control("pulls")
    click(list:GetRow(2))
    local menu = contextMenu(list:GetRow(2))
    expect(menuLabels(menu) == "Move up|Move down|Insert before|Insert after|Merge up|Merge down|-|Clear Pull|Reset Route|Delete", "single menu is "..menuLabels(menu))
    expect(selection() == "2", "right-click changed the selection to "..selection())
    UI.Menu.Close()
    W.modifiers = { shift = true }
    click(list:GetRow(4))
    W.modifiers = nil
    expect(selection() == "2,3,4", "shift-click selection is "..selection())
    menu = contextMenu(list:GetRow(3))
    expect(menuLabels(menu) == "Insert before|Insert after|Merge|-|Clear Pulls|Reset Route|Delete", "multi menu is "..menuLabels(menu))
    expect(selection() == "2,3,4", "right-click inside the selection changed it to "..selection())
    UI.Menu.Close()
    menu = contextMenu(list:GetRow(1))
    expect(selection() == "2,3,4,1", "right-click outside a multi-selection did not add the row: "..selection())
    UI.Menu.Close()
    click(list:GetRow(1))
    local before = #pulls()
    W.modifiers = { ctrl = true }
    click(list:GetRow(2), "RightButton")
    W.modifiers = nil
    expect(UI.Overlay.Top("menu") == nil and #pulls() == before, "Ctrl+right-click opened a menu or changed pulls")
    W.modifiers = { shift = true }
    click(list:GetRow(4), "RightButton")
    W.modifiers = nil
    W.settle(asyncIdle, 30)
    expect(UI.Overlay.Top("menu") == nil, "Shift+right-click opened a menu")
    expect(#pulls() == before - 1, "Shift+right-click did not delete the pull")
  end)

  step("sidebar: context actions insert, move, merge, clear and delete pulls", function()
    ensurePulls(4)
    tagPulls()
    local list = control("pulls")
    click(list:GetRow(2))
    click(rowByText(contextMenu(list:GetRow(2)), "Insert before"))
    W.settle(asyncIdle, 30)
    expect(tags() == "1,-,2,3,4" and selection() == "2", "insert before gave "..tags().." selection "..selection())
    tagPulls()
    click(rowByText(contextMenu(list:GetRow(2)), "Insert after"))
    W.settle(asyncIdle, 30)
    expect(tags() == "1,2,-,3,4,5" and selection() == "3", "insert after gave "..tags().." selection "..selection())
    tagPulls()
    click(rowByText(contextMenu(list:GetRow(3)), "Move up"))
    W.settle(asyncIdle, 30)
    expect(tags() == "1,3,2,4,5,6" and selection() == "2", "move up gave "..tags().." selection "..selection())
    click(rowByText(contextMenu(list:GetRow(2)), "Move down"))
    W.settle(asyncIdle, 30)
    expect(tags() == "1,2,3,4,5,6" and selection() == "3", "move down gave "..tags().." selection "..selection())
    pulls()[3][1] = { 1 }
    pulls()[4][1] = { 2 }
    click(rowByText(contextMenu(list:GetRow(3)), "Merge down"))
    W.settle(asyncIdle, 30)
    expect(#pulls() == 5 and #pulls()[3][1] == 2 and selection() == "3", "merge down gave "..tags().." selection "..selection())
    click(rowByText(contextMenu(list:GetRow(3)), "Clear Pull"))
    W.settle(asyncIdle, 30)
    expect(next(pulls()[3]) == "color" or pulls()[3][1] == nil, "clear pull left enemies behind")
    click(list:GetRow(2))
    W.modifiers = { shift = true }
    click(list:GetRow(3))
    W.modifiers = nil
    local before = #pulls()
    click(rowByText(contextMenu(list:GetRow(3)), "Delete"))
    W.settle(asyncIdle, 30)
    expect(#pulls() == before - 2 and selection() == "1", "multi delete gave "..#pulls().." pulls, selection "..selection())
  end)

  step("sidebar: dragging one row and a block reorders the pulls like the old button", function()
    ensurePulls(5)
    while #pulls() > 5 do MDT:DeletePull(#pulls()) end
    W.settle(asyncIdle, 30)
    tagPulls()
    local list = control("pulls")
    click(list:GetRow(2))
    drag(list:GetRow(2), list:GetRow(5), "top")
    expect(tags() == "1,3,4,2,5" and selection() == "4", "single drag gave "..tags().." selection "..selection())
    tagPulls()
    click(list:GetRow(2))
    W.modifiers = { shift = true }
    click(list:GetRow(3))
    W.modifiers = nil
    drag(list:GetRow(2), list:GetRow(1), "top")
    expect(tags() == "2,3,1,4,5" and selection() == "1,2", "block drag gave "..tags().." selection "..selection())
    tagPulls()
    click(list:GetRow(1))
    local newPullRow = rowOfKind(list, "newPull")
    drag(list:GetRow(1), newPullRow, "bottom")
    expect(tags() == "2,3,4,5,1" and selection() == "5", "drop on + Add pull gave "..tags().." selection "..selection())
    tagPulls()
    click(list:GetRow(3))
    drag(list:GetRow(3), list:GetRow(3), "top")
    expect(tags() == "1,2,3,4,5" and selection() == "3", "a drop onto the row's own slot changed "..tags())
  end)

  step("sidebar: the level stepper steps, wheels and commits once per burst", function()
    local stepper = control("level")
    local start = db.currentDifficulty
    MDT:SetUniqueID(preset())
    MDT.liveSessionActive, MDT.livePresetUID = true, preset().uid
    local sends = 0
    local realSend = MDT.LiveSession_SendDifficulty
    MDT.LiveSession_SendDifficulty = function() sends = sends + 1 end
    click(stepper.kitUp)
    click(stepper.kitUp)
    W.fireScript(stepper, "OnMouseWheel", -1)
    expect(db.currentDifficulty == start + 1 and preset().difficulty == start + 1, "level is "..tostring(db.currentDifficulty))
    expect(stepper:GetValue() == start + 1, "stepper shows "..tostring(stepper:GetValue()))
    expect(sends == 0, "commit work ran before the burst ended")
    W.settle(asyncIdle, 5)
    expect(sends == 1, "commit work ran "..sends.." times")
    MDT.LiveSession_SendDifficulty = realSend
    MDT.liveSessionActive, MDT.livePresetUID = false, nil
    MDT:RefreshSidebar()
  end)

  step("sidebar: clicking the level opens nothing; the arrows and the wheel are the only way", function()
    local stepper = control("level")
    click(stepper.kitValue)
    expect(UI.Overlay.Top("popover") == nil, "clicking the level opened a popover")
  end)

  step("sidebar: the pull context menu draws above the main window, also when reused", function()
    local rank = { BACKGROUND = 1, LOW = 2, MEDIUM = 3, HIGH = 4, DIALOG = 5, FULLSCREEN = 6, FULLSCREEN_DIALOG = 7, TOOLTIP = 8 }
    ensurePulls(2)
    for life = 1, 2 do
      contextMenu(control("pulls"):GetRow(1))
      local entry = UI.Overlay.Top("menu")
      expect(rank[entry.frame:GetFrameStrata()] > rank[main:GetFrameStrata()],
        ("context menu (open %d) strata %s is not above the main window's %s"):format(life, entry.frame:GetFrameStrata(), main:GetFrameStrata()))
      UI.Overlay.Pop(entry, "api")
      W.settle(asyncIdle, 5)
    end
  end)

  step("sidebar: the pull that completes the forces is marked, and row index stays the pull index", function()
    ensurePulls(3)
    local totals = MDT.dungeonTotalCount[db.currentDungeonIdx]
    local realTotal = totals.normal
    for enemyIdx, enemy in pairs(MDT.dungeonEnemies[db.currentDungeonIdx]) do
      if enemy.count > 0 and enemy.clones[1] then
        pulls()[1][enemyIdx] = { 1 }
        break
      end
    end
    MDT:RefreshSidebar()
    local firstForces = MDT:CountForces(1, true)
    expect(firstForces > 0, "pull 1 has no forces")
    totals.normal = firstForces
    MDT:RefreshSidebar()
    local list = control("pulls")
    local items = list.kitProps.items
    for index = 1, #pulls() do expect(items[index].kind == "pull" and items[index].index == index, "row "..index.." is not pull "..index) end
    expect(items[1].completes and list:GetRow(1).kitComplete:IsShown(), "pull 1 completes the forces but has no marker")
    expect(not items[2].completes, "a later pull is marked too")
    click(list:GetRow(#pulls()))
    W.settle(asyncIdle, 30)
    expect(preset().value.currentPull == #pulls(), "clicking the last pull after the completed one did not select it")
    local fill = control("forces").kitProps.segments[1].color
    expect(fill[1] == UI.Theme.Resolve("bar.ok") or fill[1] == UI.Theme.Resolve("bar.warn"), "completed forces do not change the bar color")
    expect(control("forces").kitText:GetTextColor() == UI.Theme.Resolve("text.normal"), "forces bar text is not white")
    totals.normal = 100000
    MDT:RefreshSidebar()
    for _, item in ipairs(control("pulls").kitProps.items) do expect(not item.completes, "a pull is marked below 100%") end
    totals.normal = realTotal
    MDT:RefreshSidebar()
  end)

  local created
  step("sidebar: New creates a route, the list highlights it, search filters, clicking a row switches", function()
    local routeEvents = {}
    _G.MythicDungeonToolsAPI:RegisterRouteChangedCallback(function(dungeonIdx, presetIdx) routeEvents[#routeEvents + 1] = dungeonIdx..":"..presetIdx end)
    click(control("pulls"):GetRow(1))
    expect(#routeEvents == 0, "selecting a pull fired the route changed callback")
    local before = presetCount()
    click(control("newRoute"))
    expect(main.presetCreationFrame.frame:IsVisible(), "new route dialog not shown")
    created = unusedPresetName("Headless Route")
    typeInto(main.PresetCreationEditbox, created)
    click(main.presetCreationCreateButton)
    W.settle(asyncIdle, 30)
    expect(presetCount() == before + 1 and preset().text == created, "route was not created")
    local _, current = currentRouteRow()
    expect(current and current.name == created, "the route list does not highlight the new route")
    expect(routeEvents[#routeEvents] == db.currentDungeonIdx..":"..db.currentPreset[db.currentDungeonIdx], "creating a route did not fire the callback: "..table.concat(routeEvents, ","))
    local items = control("routes").kitProps.items
    expect(#items == presetCount(), ("route list has %d rows for %d routes"):format(#items, presetCount()))
    for _, item in ipairs(items) do expect(item.name ~= "<New Route>", "the <New Preset> entry leaked into the list") end
    expect(items[1].detail == nil, "route rows show details")
    local search = control("routeSearch")
    search.kitEdit:Insert("zzzz")
    expect(#control("routes").kitProps.items == 0, "search did not filter the routes")
    expect(control("routes"):GetHeight() == 7 * MDT.RouteListRowHeight, "the route list shrank when the search left no routes")
    search.kitEdit:SetText("")
    W.fireScript(search.kitEdit, "OnTextChanged", true)
    expect(#control("routes").kitProps.items == presetCount(), "clearing the search did not restore the list")
    local previousIdx = 1
    local target = routeRow(db.presets[db.currentDungeonIdx][previousIdx].text)
    expect(target, "the default route is not listed")
    click(target)
    W.settle(asyncIdle, 30)
    expect(db.currentPreset[db.currentDungeonIdx] == previousIdx, "clicking a route row did not switch")
    expect(routeEvents[#routeEvents] == db.currentDungeonIdx..":"..previousIdx, "switching did not fire the callback: "..table.concat(routeEvents, ","))
    click((routeRow(created)))
    W.settle(asyncIdle, 30)
    expect(preset().text == created, "could not switch back to the created route")
    expect(#routeEvents == 3, "route changed fired "..#routeEvents.." times: "..table.concat(routeEvents, ","))
  end)

  step("sidebar: the copy action preselects that route in the new route dialog", function()
    local before = presetCount()
    local currentIdx = db.currentPreset[db.currentDungeonIdx]
    routeAction(preset().text, "duplicate")
    expect(main.presetCreationFrame.frame:IsVisible(), "copy did not open the new route dialog")
    expect(main.PresetCreationDropDown:GetValue() == currentIdx + 1, "starting point is "..tostring(main.PresetCreationDropDown:GetValue()))
    typeInto(main.PresetCreationEditbox, unusedPresetName("Headless Copy"))
    click(main.presetCreationCreateButton)
    W.settle(asyncIdle, 30)
    expect(presetCount() == before + 1, "copy did not create a route")
    expect(#pulls() == #db.presets[db.currentDungeonIdx][currentIdx].value.pulls, "the copy has a different pull count")
  end)

  step("sidebar: rename on a route row renames it and the list follows", function()
    routeAction(preset().text, "rename")
    local dialog = main.RenameFrame
    expect(dialog.frame:IsVisible(), "rename dialog not shown")
    local name = unusedPresetName("Headless Renamed")
    typeInto(dialog.Editbox, name)
    click(dialog.RenameButton)
    W.settle(asyncIdle, 30)
    expect(preset().text == name, "route name is "..tostring(preset().text))
    local _, current = currentRouteRow()
    expect(current and current.name == name, "the route list did not follow the rename")
    MDT:HideAllDialogs()
  end)

  step("sidebar: a row action on another route switches to it first", function()
    local other = db.presets[db.currentDungeonIdx][1].text
    routeAction(other, "export")
    expect(db.currentPreset[db.currentDungeonIdx] == 1, "the export action did not switch to that route")
    expect(main.ExportFrame.frame:IsVisible(), "export dialog not shown")
    main.ExportFrame:Hide()
    click((routeRow(created)) or routeRow(preset().text))
    W.settle(asyncIdle, 30)
  end)

  local exported
  step("sidebar: export shows the route string and Import brings it back", function()
    routeAction(preset().text, "export")
    expect(main.ExportFrame.frame:IsVisible(), "export dialog not shown")
    exported = main.ExportFrameEditbox:GetText()
    expect(type(exported) == "string" and #exported > 20, "export string is empty")
    main.ExportFrame:Hide()
    local before = presetCount()
    click(control("importRoute"))
    expect(main.presetImportFrame.frame:IsVisible(), "import dialog not shown")
    typeInto(main.presetImportBox, exported)
    click(main.presetImportButton)
    W.settle(asyncIdle, 30)
    local confirmation = main.ConfirmationFrame
    expect(confirmation and confirmation.frame:IsVisible(), "re-importing a known route did not ask overwrite or copy")
    click(confirmation.CancelButton)
    W.settle(asyncIdle, 30)
    expect(presetCount() == before + 1, ("preset count %d, expected %d after import"):format(presetCount(), before + 1))
    MDT:HideAllDialogs()
  end)

  step("sidebar: delete removes a route and the default route has no delete button", function()
    local before = presetCount()
    routeAction(preset().text, "delete")
    expect(main.DeleteConfirmationFrame.frame:IsVisible(), "delete dialog not shown")
    click(main.DeleteConfirmationFrame.OkayButton)
    W.settle(asyncIdle, 30)
    expect(presetCount() == before - 1, "preset was not deleted")
    expect(not main.DeleteConfirmationFrame.frame:IsVisible(), "delete dialog still shown")
    local _, item = rowByText(routeMenu(db.presets[db.currentDungeonIdx][1].text), "Delete this route")
    expect(item and item.disabled, "the default route can be deleted from its menu")
    UI.Menu.Close()
  end)

  step("sidebar: the route menu starts, switches and stops live sessions; the live route is tagged", function()
    local menu = routeMenu(preset().text)
    local _, start = rowByText(menu, "Start live session")
    expect(start and start.disabled and start.tooltip == "Join a group first", "start live session outside a group is wrong: "..menuLabels(menu))
    UI.Menu.Close()
    MDT:SetUniqueID(preset())
    MDT.liveSessionActive, MDT.livePresetUID = true, preset().uid
    MDT:RefreshSidebar()
    local row, current = currentRouteRow()
    expect(current.isLive and row.kitLive:IsShown(), "LIVE tag hidden on the live route")
    expect(control("shareRoute"):IsDisabled(), "share stays enabled during a live session")
    menu = routeMenu(preset().text)
    expect(rowByText(menu, "Stop live session") and rowByText(menu, "Make this route the live route") == nil and rowByText(menu, "Start live session") == nil,
      "live menu on the live route is wrong: "..menuLabels(menu))
    UI.Menu.Close()
    MDT.livePresetUID = "somewhere-else"
    MDT:RefreshSidebar()
    row = currentRouteRow()
    expect(not row.kitLive:IsShown(), "LIVE tag shown on another route")
    menu = routeMenu(preset().text)
    expect(rowByText(menu, "Make this route the live route") and rowByText(menu, "Return to the live route") and rowByText(menu, "Stop live session"),
      "live route entries are missing: "..menuLabels(menu))
    UI.Menu.Close()
    MDT.liveSessionActive, MDT.livePresetUID = false, nil
    MDT:RefreshSidebar()
  end)

  step("sidebar: the scroll position survives an edit and hovering shows the tooltip and the model", function()
    local list = control("pulls")
    while list.kitTotal < list.kitViewport:GetHeight() + 300 do MDT:AddPull() end
    W.settle(asyncIdle, 30)
    expect(list.kitBar:IsShown(), #pulls().." pulls do not scroll")
    list:SetOffset(150)
    local offset = list:GetOffset()
    expect(offset > 100, "list did not scroll: "..offset)
    local target = math.floor(offset / 30) + 2
    pulls()[target][1] = { 1 }
    MDT:RefreshSidebar()
    expect(list:GetOffset() == offset, "offset changed after an edit: "..list:GetOffset())
    local row = list:GetRow(target)
    expect(row and row.kitPortraits[1]:IsShown(), "edited row did not rebind")
    W.cursorX, W.cursorY = row:GetCenter()
    W.fireScript(row, "OnEnter")
    local tooltip = MDT.PullTooltip.Frame()
    expect(tooltip and tooltip:IsShown() and tooltip.botString:GetText():find("Forces", 1, true), "hover did not show the pull tooltip")
    expect(not tooltip.Model:IsShown(), "model shown before a portrait hover")
    expect(not row.kitPortraits[1]:IsMouseEnabled(), "portraits take the mouse and would swallow the row's clicks")
    W.cursorX, W.cursorY = row.kitPortraits[1]:GetCenter()
    W.pump(0.05)
    expect(tooltip.Model:IsShown() and tooltip.topString:IsShown() and tooltip.topString:GetText():find("x1", 1, true), "portrait hover did not show the model")
    W.cursorX, W.cursorY = row:GetRight() - 4, select(2, row:GetCenter())
    W.pump(0.05)
    expect(not tooltip.Model:IsShown() and tooltip:IsShown(), "moving off the portrait hid the whole tooltip")
    W.fireScript(row, "OnLeave")
    expect(not tooltip:IsShown(), "leaving the row left the tooltip open")
    local forces, total = control("forces"), MDT.dungeonTotalCount[db.currentDungeonIdx].normal
    expect(forces.kitText:GetFontObject() == UI.Fonts.Get("body"), "forces bar text is not the body font")
    W.fireScript(row, "OnEnter")
    expect(forces.kitText:GetText() == MDT.SidebarModel.FormatForcesTotal(row.kitItem.cumulative, total), "hovering a pull did not preview its running total: "..forces.kitText:GetText())
    W.fireScript(row, "OnLeave")
    expect(forces.kitText:GetText() == MDT.SidebarModel.FormatForcesTotal(row.kitItem.cumulative, total), "the preview reset before its delay")
    W.pump(0.5)
    expect(forces.kitText:GetText() == MDT.SidebarModel.FormatForcesTotal(MDT:CountForces(), total), "the forces bar did not return to the route total: "..forces.kitText:GetText())
    while #pulls() > 3 do MDT:DeletePull(#pulls()) end
    W.settle(asyncIdle, 30)
  end)
end
