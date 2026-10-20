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
