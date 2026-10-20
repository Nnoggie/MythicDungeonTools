-- Harness steps for the main window chrome on the kit: the season and floor dropdowns, the drawing toolbar
-- and the map note editor. Driven through real frames. Not shipped code.
return function(ctx)
  local W, MDT, step, expect, click, asyncIdle = ctx.W, ctx.MDT, ctx.step, ctx.expect, ctx.click, ctx.asyncIdle
  local UI = MDT.UI
  local render = ctx.render
  local main = MDT.main_frame
  local db = MDT:GetDB()

  local function openMenuRows(button)
    click(button)
    local menu = UI.Overlay.Top("menu")
    expect(menu and menu.frame:IsVisible(), "clicking did not open a menu")
    for _, child in ipairs(menu.frame.content.kitChildren) do
      if child.kit.name == "List" then return child, menu end
    end
    error("the menu has no list")
  end
  local function pick(dropdown, text)
    local list = openMenuRows(dropdown.kitButton)
    for index, item in ipairs(list.kitProps.items) do
      if item.text == text then
        list:ScrollTo(index, "nearest")
        click(list:GetRow(index))
        W.settle(asyncIdle, 30)
        return
      end
    end
    error("no menu row "..tostring(text))
  end
  local function redrawMap()
    MDT:UpdateMap()
    W.settle(asyncIdle, 30)
  end

  step("season dropdown: picking a season from its menu switches the dungeon list, and back", function()
    local dropdown = MDT:GetDungeonSelectControl("season")
    expect(dropdown and dropdown:IsVisible(), "season dropdown is not visible")
    local seasons = MDT:GetSeasonList()
    expect(dropdown.kitButton:GetText() == seasons[db.selectedDungeonList], "season dropdown shows "..tostring(dropdown.kitButton:GetText()))
    local before = db.selectedDungeonList
    local other = before == 1 and 2 or 1
    pick(dropdown, seasons[other])
    expect(db.selectedDungeonList == other and dropdown:GetValue() == other, "season list did not change")
    expect(db.currentDungeonIdx == MDT.dungeonSelectionToIndex[other][1], "picking a season did not open its first dungeon")
    expect(_G.MDTDungeonButton1.dungeonIdx == db.currentDungeonIdx, "dungeon buttons still show the old season")
    pick(dropdown, seasons[before])
    expect(db.selectedDungeonList == before, "season list did not switch back")
  end)

  step("floor dropdown: hidden for one floor, picks floors from its menu otherwise", function()
    local dropdown = MDT:GetDungeonSelectControl("sublevel")
    local dungeonIdx = db.currentDungeonIdx
    local floors, maps = MDT.dungeonSubLevels[dungeonIdx], MDT.dungeonMaps[dungeonIdx]
    expect(#floors == 1, "setup: the current dungeon already has several floors")
    expect(not dropdown:IsShown(), "floor dropdown shown for a single-floor dungeon")
    -- Every shipped dungeon has one floor today, so lend this one a second floor with a Blizzard-style map name.
    floors[2], maps[2] = "Second floor", "HarnessSecondFloor"
    redrawMap()
    expect(dropdown:IsVisible(), "floor dropdown hidden for a multi-floor dungeon")
    expect(dropdown.kitButton:GetText() == floors[MDT:GetCurrentSubLevel()], "floor dropdown shows "..tostring(dropdown.kitButton:GetText()))
    local _, menu = openMenuRows(dropdown.kitButton)
    render("floor menu", main, { menu.frame })
    UI.Menu.Close()
    pick(dropdown, floors[2])
    expect(MDT:GetCurrentSubLevel() == 2 and dropdown:GetValue() == 2, "floor did not change")
    pick(dropdown, floors[1])
    expect(MDT:GetCurrentSubLevel() == 1, "floor did not change back")
    floors[2], maps[2] = nil, nil
    redrawMap()
    expect(not dropdown:IsShown(), "floor dropdown still shown after the dungeon went back to one floor")
  end)

  local function tool(id)
    local found = main.toolbar.controls:Find(id)
    expect(found, "toolbar control "..id.." is missing")
    return found
  end
  local function openToolbar()
    if not main.toolbar:IsShown() then click(main.toolbar.toggleButton) end
    expect(main.toolbar:IsVisible(), "toolbar did not open")
  end

  step("toolbar: kit controls stacked top to bottom inside the toolbar, each with its tooltip", function()
    openToolbar()
    local order = { "undo", "redo", "color", "brushUp", "brushSize", "brushDown" }
    for _, entry in ipairs(MDT.ToolbarTools) do order[#order + 1] = entry.id end
    order[#order + 1] = "deleteAll"
    local above
    for _, id in ipairs(order) do
      local control = tool(id)
      expect(control:IsVisible(), id.." is hidden")
      expect(control:GetLeft() >= main.toolbar:GetLeft() and control:GetRight() <= main.toolbar:GetRight(), id.." sticks out of the toolbar")
      if above then expect(control:GetTop() <= above:GetBottom(), id.." overlaps "..tostring(above.kitProps.id)) end
      above = control
    end
    expect(above:GetBottom() >= main.toolbar:GetBottom(), "the last control hangs below the toolbar")
    for _, id in ipairs({ "undo", "color", "brushUp", "text", "deleteAll" }) do
      GameTooltip:Hide()
      W.hover(tool(id))
      expect(GameTooltip:IsShown() and GameTooltip:IsOwned(tool(id)), id.." shows no tooltip")
      W.fireScript(tool(id), "OnLeave")
    end
    render("toolbar", main)
  end)

  step("toolbar: brush size by typing, by the buttons and by the wheel, clamped to 1..99", function()
    openToolbar()
    local box = tool("brushSize")
    local start = db.toolbar.brushSize
    box:Focus()
    box:SelectAll()
    box.kitEdit:SetText("")
    W.userType(box.kitEdit, "12")
    expect(db.toolbar.brushSize == 12, "typing 12 set the size to "..tostring(db.toolbar.brushSize))
    W.fireScript(box.kitEdit, "OnEnterPressed")
    expect(not box.kitEdit:HasFocus() and box:GetValue() == "12", "Enter did not keep 12")
    click(tool("brushUp"))
    expect(db.toolbar.brushSize == 13 and box:GetValue() == "13", "+ did not grow the size to 13")
    click(tool("brushDown"))
    click(tool("brushDown"))
    expect(db.toolbar.brushSize == 11 and box:GetValue() == "11", "- did not shrink the size to 11")
    W.fireScript(box.kitScroll, "OnMouseWheel", 1)
    expect(db.toolbar.brushSize == 12 and box:GetValue() == "12", "the wheel did not grow the size")
    box:Focus()
    box.kitEdit:SetText("")
    W.fireScript(box.kitEdit, "OnEnterPressed")
    expect(db.toolbar.brushSize == 12 and box:GetValue() == "12", "an empty box did not restore the size: "..box:GetValue())
    box:Focus()
    box.kitEdit:SetText("")
    W.userType(box.kitEdit, "0")
    box:ClearFocus()
    expect(db.toolbar.brushSize == 1 and box:GetValue() == "1", "0 was not clamped to 1")
    click(tool("brushDown"))
    expect(db.toolbar.brushSize == 1, "- went below 1")
    box:SetValue("99")
    db.toolbar.brushSize = 99
    click(tool("brushUp"))
    expect(db.toolbar.brushSize == 99 and box:GetValue() == "99", "+ went above 99")
    db.toolbar.brushSize = start
    box:SetValue(tostring(start))
  end)

  step("toolbar: the color swatch opens the picker and stores the picked color", function()
    openToolbar()
    local swatch = tool("color")
    local start = CopyTable(db.toolbar.color)
    click(swatch)
    expect(ColorPickerFrame:IsShown(), "the swatch did not open the color picker")
    local realRGB = ColorPickerFrame.GetColorRGB
    ColorPickerFrame.GetColorRGB = function() return 0.25, 0.5, 0.75 end
    ColorPickerFrame.info.swatchFunc()
    ColorPickerFrame.GetColorRGB = realRGB
    local color = db.toolbar.color
    expect(color.r == 0.25 and color.g == 0.5 and color.b == 0.75, "picked color not stored: "..color.r..","..color.g..","..color.b)
    expect(swatch:GetColor()[3] == 0.75, "the swatch does not show the picked color")
    ColorPickerFrame.info.cancelFunc()
    expect(color.r == start.r and color.b == start.b, "cancel did not restore the color")
    ColorPickerFrame:Hide()
  end)

  step("toolbar: a tool click selects it, a second click or closing the toolbar deselects it", function()
    openToolbar()
    click(tool("pencil"))
    expect(MDT:GetCurrentToolbarTool() == "pencil" and tool("pencil").kitProps.selected, "pencil not selected")
    click(tool("line"))
    expect(MDT:GetCurrentToolbarTool() == "line" and not tool("pencil").kitProps.selected and tool("line").kitProps.selected, "switching to line kept pencil selected")
    render("toolbar tool selected", main)
    click(tool("line"))
    expect(MDT:GetCurrentToolbarTool() == nil and not tool("line").kitProps.selected, "a second click did not deselect line")
    click(tool("eraser"))
    click(main.toolbar.toggleButton)
    expect(MDT:GetCurrentToolbarTool() == nil and not tool("eraser").kitProps.selected, "closing the toolbar kept the eraser")
    openToolbar()
  end)

  step("toolbar: delete all drawings asks first, and confirming deletes them", function()
    openToolbar()
    MDT:StorePresetObject({ d = { 3, 1, 1, true, "ffffff" }, l = { 1, -1, 5, -5 } })
    local objects = MDT:GetCurrentPreset().objects
    expect(#objects > 0, "setup: no drawing stored")
    click(tool("deleteAll"))
    local dialog = UI.Dialogs.Get("deleteAllDrawings")
    expect(dialog and dialog:IsVisible(), "delete-all dialog not shown")
    render("delete all drawings", main, { dialog })
    expect(CloseSpecialWindows(), "Escape closed nothing")
    expect(UI.Dialogs.Get("deleteAllDrawings") == nil and #MDT:GetCurrentPreset().objects > 0, "Escape deleted the drawings")
    W.settle(asyncIdle, 5)
    click(tool("deleteAll"))
    dialog = UI.Dialogs.Get("deleteAllDrawings")
    local confirm
    for _, row in ipairs(dialog.content.kitChildren) do
      if row.kit.name == "Row" then confirm = row.kitChildren[1] end
    end
    click(confirm)
    W.settle(asyncIdle, 30)
    expect(#MDT:GetCurrentPreset().objects == 0, "confirming kept "..#MDT:GetCurrentPreset().objects.." drawings")
  end)

  step("kit dropdown: a picked value reads in the normal text color, only the placeholder is muted", function()
    local host = CreateFrame("Frame", nil, UIParent)
    host:SetSize(200, 60)
    host:SetPoint("CENTER")
    local items = UI.MenuModel.FromList({ a = "Alpha" }, { "a" })
    local dropdown = UI.Dropdown(host, { items = items, placeholder = "Pick one" })
    expect(dropdown.kitButton.kitProps.textColor == "text.disabled", "the placeholder is not muted")
    dropdown:SetValue("a")
    expect(dropdown.kitButton:GetText() == "Alpha" and dropdown.kitButton.kitProps.textColor == nil, "a picked value is drawn as "..tostring(dropdown.kitButton.kitProps.textColor))
    dropdown:Release()
    host:Hide()
  end)

  step("kit edit box: justify aligns the text and onWheel takes the wheel instead of scrolling", function()
    local host = CreateFrame("Frame", nil, UIParent)
    host:SetSize(120, 60)
    host:SetPoint("CENTER")
    local wheel = {}
    local edit = UI.EditBox(host, { width = 40, value = "3", justify = "CENTER", onWheel = function(delta) wheel[#wheel + 1] = delta end })
    edit:SetPoint("TOPLEFT")
    expect(edit.kitEdit:GetJustifyH() == "CENTER", "justify did not reach the edit box: "..edit.kitEdit:GetJustifyH())
    W.fireScript(edit.kitScroll, "OnMouseWheel", 1)
    W.fireScript(edit.kitScroll, "OnMouseWheel", -1)
    expect(table.concat(wheel, ",") == "1,-1", "onWheel got "..table.concat(wheel, ","))
    expect(edit.kitScroll:GetVerticalScroll() == 0, "the wheel scrolled the text although onWheel took it")
    edit:Release()
    local fresh = UI.EditBox(host, {})
    expect(fresh.kitEdit:GetJustifyH() == "LEFT" and fresh.kitProps.onWheel == nil, "a pooled edit box kept justify or onWheel")
    fresh:Release()
    host:Hide()
  end)
end
