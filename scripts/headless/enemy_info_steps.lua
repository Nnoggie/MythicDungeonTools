-- Harness steps for the enemy hover and pinned cards and, with --developer, the dev panel. Driven through real frames. Not shipped code.
return function(ctx)
  local W, MDT, step, expect, click, asyncIdle, render = ctx.W, ctx.MDT, ctx.step, ctx.expect, ctx.click, ctx.asyncIdle, ctx.render
  local UI = MDT.UI
  local L = MDT.L
  local main = MDT.main_frame
  local db = MDT:GetDB()

  local function menuList()
    local menu = UI.Overlay.Top("menu")
    expect(menu and menu.frame:IsVisible(), "no kit menu is open")
    for _, child in ipairs(menu.frame.content.kitChildren) do
      if child.kit.name == "List" then return child end
    end
  end
  local function menuRow(list, text)
    for index, item in ipairs(list.kitProps.items) do
      if item.text == text then
        list:ScrollTo(index, "nearest")
        return list:GetRow(index)
      end
    end
  end
  local function spellCount(data)
    local count = 0
    for _ in pairs(data.spells or {}) do count = count + 1 end
    return count
  end
  local function find(kitName, predicate, container)
    for _, child in ipairs(container.kitChildren or {}) do
      if child.kit.name == kitName and (not predicate or predicate(child)) then return child end
      local found = find(kitName, predicate, child)
      if found then return found end
    end
    for i = 1, #container do
      local found = find(kitName, predicate, container[i])
      if found then return found end
    end
  end
  local function card(kind) return MDT:GetEnemyInfoCard(kind) end
  local function part(kind, id) return card(kind).content:Find(id) end
  local function text(kind, id)
    local control = part(kind, id)
    return control and control.kitLabel:GetText()
  end
  local function shown(kind) return card(kind) ~= nil and card(kind):IsVisible() end
  local function moveAway() W.cursorX, W.cursorY = 1, 1 end
  local function rest(seconds)
    W.pump(seconds or 0.5)
    W.settle(asyncIdle, 5)
  end
  local function visibleBlips()
    local found = {}
    for _, frame in ipairs(MDT.dungeonEnemies_framePool.active) do
      if frame:IsVisible() and frame.data then found[#found + 1] = frame end
    end
    table.sort(found, function(a, b) return spellCount(a.data) > spellCount(b.data) end)
    return found
  end

  local blip, other
  step("enemy card: hovering an enemy shows the hover card beside it", function()
    local blips = visibleBlips()
    blip = blips[1]
    for _, candidate in ipairs(blips) do
      if candidate.enemyIdx ~= blip.enemyIdx then other = candidate break end
    end
    expect(blip and spellCount(blip.data) > 0 and other, "no two visible enemies with spells on the map")
    W.hover(blip)
    expect(shown("hover"), "hovering an enemy shows no card")
    local hover = card("hover")
    expect(text("hover", "name") == L[blip.data.name], "card name is "..tostring(text("hover", "name")))
    local health = MDT:FormatEnemyHealth(MDT:CalculateEnemyHealth(blip.data.isBoss or false, blip.data.health, db.currentDifficulty, blip.data.ignoreFortified))
    expect(text("hover", "health"):find(health, 1, true), "health line is "..text("hover", "health"))
    expect(text("hover", "forces"):find(MDT:FormatEnemyForces(MDT:GetCloneEnemyForces(blip.data, blip.clone)), 1, true), "forces line is "..text("hover", "forces"))
    for id, key in pairs({ stealth = "Enemy Info NPC Stealth", stealthDetect = "Enemy Info NPC Stealth Detect" }) do
      local expected = L[key]..": "..(blip.data[id] and YES or NO)
      expect(text("hover", id) == expected, id.." line is "..tostring(text("hover", id)))
    end
    expect(hover:GetLeft() >= blip:GetRight() or hover:GetRight() <= blip:GetLeft(), "the card covers its enemy")
    expect(hover:GetBottom() >= main:GetBottom() - 0.5 and hover:GetRight() <= main:GetRight() + 0.5, "the card leaves the window")
    local spells = spellCount(blip.data)
    local list = part("hover", "spells")
    expect(#list.kitProps.items == math.min(spells, 4) and list:GetHeight() > 0, "the hover card lists "..#list.kitProps.items.." of "..spells.." spells")
    expect(not list.kitBar:IsShown(), "the hover card's spell list scrolls")
    local row = list:GetRow(1)
    expect(row and row:IsVisible() and row.kitName:GetText() ~= "" and row:GetWidth() > 150, ("the first spell row is not laid out: row=%s vis=%s name=%s w=%s list=%sx%s"):format(tostring(row), tostring(row and row:IsVisible()), tostring(row and row.kitName:GetText()), tostring(row and row:GetWidth()), tostring(list:GetWidth()), tostring(list:GetHeight())))
    local more = part("hover", "moreSpells")
    if spells > 4 then
      expect(more and more.kitLabel:GetText() == string.format(L["+%d more spells"], spells - 4), "no +more line for "..spells.." spells")
      expect(list:GetHeight() < 5 * 22, "the hover card shows more than 4 spell rows")
    else
      expect(more == nil, "a +more line for "..spells.." spells")
    end
    expect(part("hover", "pin") and part("hover", "devHint") == nil, "the hover card has no pin button or shows dev hints outside dev mode")
    expect(math.abs(hover:GetWidth() - 250) < 1 and hover:GetHeight() > 100, ("hover card is %.0fx%.0f"):format(hover:GetWidth(), hover:GetHeight()))
    render("enemy hover card", main, { hover })
  end)

  step("enemy card: the hover card waits for the cursor and switches to the next enemy at once", function()
    local hover = card("hover")
    rest(0.5)
    expect(shown("hover"), "the card left while the cursor is on its enemy")
    W.fireScript(blip, "OnLeave")
    W.cursorTo(hover)
    rest(0.5)
    expect(shown("hover"), "the card left while the cursor is on it")
    moveAway()
    W.pump(0.1)
    expect(shown("hover"), "the card left before its grace period")
    rest(0.3)
    expect(not shown("hover"), "the card stayed after the cursor left")
    W.hover(blip)
    W.fireScript(blip, "OnLeave")
    W.hover(other)
    expect(shown("hover") and text("hover", "name") == L[other.data.name], "hovering another enemy did not switch the card")
    W.fireScript(other, "OnLeave")
    moveAway()
    rest(0.5)
  end)

  step("enemy card: right-click Open Enemy Info pins the card where the hover card was", function()
    W.hover(blip)
    local hover = card("hover")
    local left, top = hover:GetLeft(), hover:GetTop()
    local depth = UI.Escape.Depth()
    click(blip, "RightButton")
    click(menuRow(menuList(), L["Open Enemy Info"]))
    expect(shown("pinned"), "Open Enemy Info pinned nothing")
    local pinned = card("pinned")
    expect(not shown("hover"), "the hover card stayed after pinning")
    -- It opens at the hover card's top left, moved up only as far as it needs to stay inside the window.
    local moved = math.abs(pinned:GetBottom() - main:GetBottom()) < 0.5
    expect(math.abs(pinned:GetLeft() - left) < 0.5 and (math.abs(pinned:GetTop() - top) < 0.5 or (moved and pinned:GetTop() > top)),
      ("the pinned card did not open where the hover card was: %s,%s vs %s,%s"):format(pinned:GetLeft(), pinned:GetTop(), left, top))
    expect(pinned:GetBottom() >= main:GetBottom() - 0.5, "the pinned card hangs below the window")
    expect(text("pinned", "name") == L[blip.data.name] and text("pinned", "npcId"):find(tostring(blip.data.id), 1, true), "the pinned card shows the wrong enemy")
    local list = part("pinned", "spells")
    expect(#list.kitProps.items == spellCount(blip.data), "the pinned card lists the wrong spells")
    expect(part("pinned", "linkSpells") and part("pinned", "pin") == nil and part("pinned", "moreSpells") == nil, "the pinned card has hover-card parts")
    expect(UI.Escape.Depth() == depth + 1, "the pinned card is not on the Escape stack")
    moveAway()
    rest(0.5)
    expect(shown("pinned"), "the pinned card left with the cursor")
    render("enemy pinned card", main, { pinned })
  end)

  step("enemy card: the pin button pins, and other enemies still show hover cards while one is pinned", function()
    MDT:CloseEnemyInfo()
    W.hover(other)
    click(part("hover", "pin"))
    expect(shown("pinned") and text("pinned", "name") == L[other.data.name], "the pin button did not pin the hovered enemy")
    expect(not shown("hover"), "the hover card stayed after pinning")
    moveAway()
    rest(0.3)
    W.hover(blip)
    expect(shown("hover") and text("hover", "name") == L[blip.data.name] and shown("pinned"), "hovering another enemy while one is pinned failed")
    W.fireScript(blip, "OnLeave")
    moveAway()
    rest(0.5)
    W.hover(card("pinned").blip)
    expect(not shown("hover"), "hovering the pinned enemy shows a second card")
    W.fireScript(card("pinned").blip, "OnLeave")
    moveAway()
    MDT:ShowEnemyInfoFrame(blip)
    expect(text("pinned", "name") == L[blip.data.name], "pinning another enemy did not replace the pinned card")
  end)

  step("enemy card: characteristics show their icons in full color with a tooltip", function()
    local data = blip.data
    local saved = data.characteristics
    data.characteristics = { Root = true, Stun = true, Fear = true }
    MDT:UpdateEnemyInfoFrame()
    local icons = part("pinned", "characteristics")
    expect(icons and #icons.kitChildren == 3, "expected 3 characteristic icons, got "..(icons and #icons.kitChildren or 0))
    local tooltips = {}
    for i, icon in ipairs(icons.kitChildren) do
      expect(table.concat({ icon.kitIcon:GetVertexColor() }, ",") == "1,1,1,1", "characteristic icon "..i.." is tinted")
      W.hover(icon)
      expect(MDTTooltip:IsShown() and MDTTooltip:GetOwner() == icon, "characteristic icon "..i.." shows no tooltip")
      tooltips[i] = (W.state[MDTTooltip].lines or {})[1]
      W.fireScript(icon, "OnLeave")
    end
    expect(table.concat(tooltips, ",") == table.concat({ L["Stun"], L["Fear"], L["Root"] }, ","), "icons are not in characteristic order: "..table.concat(tooltips, ","))
    render("enemy pinned card characteristics", main, { card("pinned") })
    data.characteristics = saved
    MDT:UpdateEnemyInfoFrame()
  end)

  step("enemy card: hovering a spell shows its tooltip and shift-click links it into chat", function()
    local list = part("pinned", "spells")
    local index, item
    for i, candidate in ipairs(list.kitProps.items) do
      if #candidate.statuses > 0 and not index then index, item = i, candidate end
    end
    index, item = index or 1, item or list.kitProps.items[1]
    list:ScrollTo(index, "nearest")
    local row = list:GetRow(index)
    MDTTooltip:Hide()
    W.hover(row)
    expect(MDTTooltip:IsShown() and MDTTooltip:GetOwner() == row, "hovering a spell shows no tooltip")
    local lines = W.state[MDTTooltip].lines or {}
    expect(#lines == #item.statuses, ("tooltip has %d status lines for %d statuses"):format(#lines, #item.statuses))
    W.fireScript(row, "OnLeave")
    expect(not MDTTooltip:IsShown(), "spell tooltip stayed up after the cursor left")

    local chat = _G.ChatFrame1EditBox
    _G.DEFAULT_CHAT_FRAME.editBox = chat
    chat:Show()
    chat:SetText("look: ")
    W.modifiers = { shift = true }
    row = list:GetRow(1)
    click(row)
    W.modifiers = nil
    expect(chat:GetText() == "look: "..C_Spell.GetSpellLink(row.spellId), "shift-click did not insert the spell link: "..chat:GetText())
    chat:Hide()
    _G.DEFAULT_CHAT_FRAME.editBox = nil
  end)

  step("enemy card: scrolling away from a hovered spell recycles its row cleanly", function()
    local list = part("pinned", "spells")
    expect(#list.kitProps.items > 10, "setup: the pinned enemy needs more spells than fit")
    local row = list:GetRow(1)
    W.hover(row)
    expect(MDTTooltip:IsShown() and MDTTooltip:IsOwned(row), "setup: hovering the first spell shows no tooltip")
    for _ = 1, 4 do W.fireScript(list:GetRow(list:GetOffset() == 0 and 1 or 3) or row, "OnMouseWheel", -1) end
    expect(list:GetOffset() > 0 and list:GetRow(1) == nil, "the list did not scroll the hovered row away")
    expect(not MDTTooltip:IsOwned(row), "the recycled row kept its spell tooltip")
    list:SetOffset(0)
  end)

  step("enemy card: Link Spells posts every spell to the group", function()
    local link = part("pinned", "linkSpells")
    W.chatMessages = {}
    click(link)
    expect(#W.chatMessages == 0, "Link Spells posted outside a group")
    local realInGroup = _G.IsInGroup
    _G.IsInGroup = function() return true end
    click(link)
    _G.IsInGroup = realInGroup
    expect(#W.chatMessages == spellCount(blip.data) + 1, ("posted %d messages for %d spells"):format(#W.chatMessages, spellCount(blip.data)))
    expect(W.chatMessages[1].chatType == "PARTY" and W.chatMessages[1].message:find(L[blip.data.name], 1, true), "header message is "..W.chatMessages[1].message)
  end)

  step("enemy card: a key level change refreshes the health", function()
    local level = MDT:GetSidebarControl("level")
    local before = text("pinned", "health")
    click(level.kitUp)
    W.settle(asyncIdle, 30)
    local health = MDT:FormatEnemyHealth(MDT:CalculateEnemyHealth(blip.data.isBoss or false, blip.data.health, db.currentDifficulty, blip.data.ignoreFortified))
    expect(text("pinned", "health") ~= before and text("pinned", "health"):find(health, 1, true), "health did not follow the level: "..text("pinned", "health"))
    click(level.kitDown)
    W.settle(asyncIdle, 30)
  end)

  step("enemy card: dev mode keys toggle a spell flag on the hovered row", function()
    local devMode = db.devMode
    db.devMode = true
    MDT:UpdateEnemyInfoFrame()
    expect(part("pinned", "devHelp"), "dev key help is missing in dev mode")
    local list = part("pinned", "spells")
    local row = list:GetRow(1)
    local spell = blip.data.spells[row.spellId]
    local before = spell.magic
    W.hover(row)
    expect(W.state[row].keyboard, "hovering a spell in dev mode did not take the keyboard")
    W.fireScript(row, "OnKeyDown", "M")
    expect(spell.magic == not before, "M did not toggle magic")
    list = part("pinned", "spells")
    local magicShown = false
    for _, status in ipairs(list.kitProps.items[1].statuses) do if status.key == "magic" then magicShown = true end end
    expect(magicShown == (spell.magic == true), "the row's statuses did not follow the toggle")
    spell.magic = before
    W.fireScript(list:GetRow(1), "OnLeave")
    db.devMode = devMode
    MDT:UpdateEnemyInfoFrame()
    expect(part("pinned", "devHelp") == nil, "dev key help is shown outside dev mode")
  end)

  step("enemy card: the pinned card drags, and Escape, hiding the window or switching dungeon close it", function()
    local pinned = card("pinned")
    W.fireScript(pinned, "OnDragStart")
    expect(W.state[pinned].moving, "dragging did not move the pinned card")
    W.fireScript(pinned, "OnDragStop")
    expect(CloseSpecialWindows(), "no special window closed")
    expect(not shown("pinned") and main:IsShown(), "Escape did not close the pinned card first")
    W.settle(asyncIdle, 5)
    MDT:UpdateEnemyInfoFrame()
    MDT:UpdateEnemyInfoData()
    expect(not shown("pinned"), "an update reopened the pinned card")
    MDT:ShowEnemyInfoFrame(blip)
    MDT:HideInterface()
    expect(not shown("pinned"), "hiding the main window left the pinned card")
    MDT.main_frame:Show()
    W.settle(asyncIdle, 5)
    expect(not shown("pinned"), "showing the window again brought back the pinned card")
    MDT:ShowEnemyInfoFrame(blip)
    local before = db.currentDungeonIdx
    MDT:UpdateToDungeon(before == 45 and 46 or 45)
    W.settle(asyncIdle, 30)
    expect(not shown("pinned"), "switching dungeon left the pinned card open")
    MDT:UpdateToDungeon(before)
    W.settle(asyncIdle, 30)
    blip = visibleBlips()[1]
  end)

  if not ctx.developer then return end

  local function panel() return main.devPanel end
  local function inPanel(kitName, predicate) return find(kitName, predicate, panel()) end
  local function panelButton(label)
    local button = inPanel("Button", function(candidate) return candidate:GetText() == label and candidate:IsVisible() end)
    expect(button, "dev panel has no visible "..label.." button")
    return button
  end
  local function panelBox(label)
    local box = inPanel("EditBox", function(candidate) return candidate.kitProps.label == label end)
    expect(box, "dev panel has no "..label.." field")
    return box
  end
  local function typeAndEnter(box, value)
    W.userClick(box.kitEdit)
    box.kitEdit:SetText("")
    expect(W.userType(box.kitEdit, value), "could not type into "..tostring(box.kitProps.label))
    W.fireScript(box.kitEdit, "OnEnterPressed")
    W.settle(asyncIdle, 30)
  end

  step("dev panel: enabling dev mode shows the kit panel beside the navigation bar", function()
    expect(not db.devMode and main.devPanel == nil, "setup: dev mode is already on")
    MDT:ToggleDevMode()
    W.settle(asyncIdle, 30)
    expect(db.devMode and panel() and panel():IsVisible(), "dev panel is not shown in dev mode")
    expect(math.abs(panel():GetRight() - main.navigationSidebar:GetLeft()) < 0.5 and math.abs(panel():GetTop() - main.navigationSidebar:GetTop()) < 0.5,
      "dev panel is not docked to the navigation bar")
    expect(math.abs(panel():GetWidth() - 250) < 0.01 and panel():GetHeight() > 200, ("dev panel is %.0fx%.0f"):format(panel():GetWidth(), panel():GetHeight()))
    for _, label in ipairs({ "POI/Zoom", "Enemy", "Manage DB" }) do panelButton(label) end
    expect(inPanel("Dropdown"):GetValue() ~= nil, "the enemy tab is not the first tab shown")
    render("dev panel", main, { panel() })
  end)

  step("dev panel: tabs switch between POI, enemy and database tools", function()
    click(panelButton("POI/Zoom"))
    panelButton("MapLink")
    expect(inPanel("Dropdown") == nil, "the enemy tab stayed after switching to POI/Zoom")
    render("dev panel poi", main, { panel() })
    click(panelButton("Manage DB"))
    panelButton("Toggle DevMode")
    local startup = inPanel("Checkbox", function(box) return box.kitProps.label == "Load MDT on Startup" end)
    local before = db.loadOnStartUp
    click(startup)
    expect((db.loadOnStartUp == true) == not before, "Load MDT on Startup did not toggle the setting")
    click(startup)
    expect(db.loadOnStartUp == before, "Load MDT on Startup did not toggle back")
    click(panelButton("Enemy"))
    expect(inPanel("Dropdown"), "switching back did not rebuild the enemy tab")
  end)

  step("dev panel: the POI tab adds a door with the typed name", function()
    click(panelButton("POI/Zoom"))
    local box = panelBox("Door Name / Connected Index")
    W.userClick(box.kitEdit)
    W.userType(box.kitEdit, "Headless Door")
    click(panelButton("Door"))
    local pois = MDT.mapPOIs[db.currentDungeonIdx][MDT:GetCurrentSubLevel()]
    local door = pois[#pois]
    expect(door.type == "door" and door.doorName == "Headless Door" and door.template == "MapLinkPinTemplate", "the door POI is "..tostring(door.type).." "..tostring(door.doorName))
    table.remove(pois)
    MDT:POI_UpdateAll()
    click(panelButton("Enemy"))
  end)

  step("dev panel: the enemy tab edits the picked enemy and its toggles", function()
    local dropdown = inPanel("Dropdown")
    click(dropdown.kitButton)
    click(menuRow(menuList(), MDT.dungeonEnemies[db.currentDungeonIdx][2].name))
    W.settle(asyncIdle, 30)
    local data = MDT.dungeonEnemies[db.currentDungeonIdx][2]
    expect(inPanel("Dropdown"):GetValue() == 2, "picking enemy 2 did not stick")
    expect(panelBox("health"):GetValue() == tostring(data.health), "health field is "..panelBox("health"):GetValue())
    local health = data.health
    typeAndEnter(panelBox("health"), "12345")
    expect(data.health == 12345, "Enter in the health field did not write the enemy: "..tostring(data.health))
    expect(panelBox("health"):GetValue() == "12345", "the rebuilt tab does not show the new health")
    data.health = health
    local forces = panelBox(MDT.L["Clone forces override (blank = default)"])
    expect(forces:IsVisible() and forces.kitProps.disabled, "clone forces is editable without a selected blip")
    local movable = db.devModeBlipsMovable
    click(inPanel("Checkbox", function(box) return box.kitProps.label == "Blips Movable" end))
    expect((db.devModeBlipsMovable == true) == not movable, "Blips Movable did not toggle the setting")
    db.devModeBlipsMovable = movable
    render("dev panel enemy", main, { panel() })
  end)

  step("dev panel: Open Enemy Info shows the selected blip in dev mode", function()
    blip.devSelected = true
    MDT:UpdateMap()
    W.settle(asyncIdle, 30)
    local forces = panelBox(MDT.L["Clone forces override (blank = default)"])
    expect(not forces.kitProps.disabled and forces:GetValue() == (blip.clone.count and tostring(blip.clone.count) or ""), "clone forces does not show the selected blip")
    click(panelButton("Open Enemy Info"))
    expect(shown("pinned") and text("pinned", "name") == L[blip.data.name], "Open Enemy Info did not pin the selected blip")
    expect(part("pinned", "devHelp"), "dev key help is hidden in dev mode")
    MDT:CloseEnemyInfo()
    blip.devSelected = nil
    MDT:UpdateMap()
  end)

  step("dev panel: maximize moves the panel to the window's top left and restore docks it back", function()
    click(main.maximizeButton)
    W.settle(asyncIdle, 30)
    expect(math.abs(panel():GetLeft() - main:GetLeft()) < 0.5 and math.abs(panel():GetTop() - (main:GetTop() - 45)) < 0.5, "maximized dev panel is not at the top left")
    click(main.maximizeButton)
    W.settle(asyncIdle, 30)
    expect(math.abs(panel():GetRight() - main.navigationSidebar:GetLeft()) < 0.5, "restored dev panel is not docked to the navigation bar")
  end)

  step("dev tests: the in-game test suite passes", function()
    W.printed = {}
    MDT.test:RunAllTests()
    W.settle(asyncIdle, 60, 30)
    local output = table.concat(W.printed, " | ")
    expect(output:find("All tests ran successfully", 1, true), "in-game tests failed: "..output)
  end)

  step("dev panel: disabling dev mode hides the panel", function()
    MDT:ToggleDevMode()
    W.settle(asyncIdle, 30)
    expect(not db.devMode and not panel():IsShown(), "dev panel stayed up after dev mode was turned off")
  end)
end
