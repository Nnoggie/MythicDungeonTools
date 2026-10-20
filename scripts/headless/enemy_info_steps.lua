-- Harness steps for the enemy info window and, with --developer, the dev panel. Driven through real frames. Not shipped code.
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
  local function window() return UI.Dialogs.Get("enemyInfo") end
  local function find(kitName, predicate, container)
    container = container or window().content
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
  local function spellList() return find("List") end
  local function field(label)
    return find("EditBox", function(box) return box.kitProps.label == label end)
  end
  local function expectCoversMap()
    local dialog, map = window(), main.scrollFrame
    for _, edge in ipairs({ "GetLeft", "GetRight", "GetTop", "GetBottom" }) do
      expect(math.abs(dialog[edge](dialog) - map[edge](map)) < 0.5,
        ("enemy info %s is %.1f, the map's is %.1f"):format(edge, dialog[edge](dialog), map[edge](map)))
    end
  end

  local blip
  step("enemy info: opens from a blip's right-click menu and covers the map", function()
    local best = -1
    for _, frame in ipairs(MDT.dungeonEnemies_framePool.active) do
      if frame:IsVisible() and frame.data and spellCount(frame.data) > best then
        blip, best = frame, spellCount(frame.data)
      end
    end
    expect(blip and best > 0, "no visible enemy blip with spells on the map")
    click(blip, "RightButton")
    click(menuRow(menuList(), L["Open Enemy Info"]))
    local dialog = window()
    expect(dialog and dialog:IsVisible(), "enemy info did not open")
    expect(dialog.kitTitle:GetText() == L[blip.data.name], "title is "..tostring(dialog.kitTitle:GetText()))
    expectCoversMap()
    expect(field(L["Enemy Info NPC Name"]):GetValue() == L[blip.data.name], "name field is "..field(L["Enemy Info NPC Name"]):GetValue())
    expect(field(L["Enemy Info NPC Id"]):GetValue() == tostring(blip.data.id), "npc id field is "..field(L["Enemy Info NPC Id"]):GetValue())
    local forces = tostring(MDT:GetCloneEnemyForces(blip.data, blip.data.clones[blip.cloneIdx]))
    expect(field(L["Enemy Info NPC Enemy Forces"]):GetValue() == forces, "forces field is "..field(L["Enemy Info NPC Enemy Forces"]):GetValue())
    expect(#spellList().kitProps.items == best, ("spell list has %d rows, the enemy has %d spells"):format(#spellList().kitProps.items, best))
    local row = spellList():GetRow(1)
    expect(row and row:IsVisible() and row:GetWidth() > 100, "first spell row is not laid out")
    expect(row.kitName:GetText() ~= nil and row.kitName:GetText() ~= "", "first spell row has no name")
    expect(not row.kitName:GetText():find("^%d+$"), "first spell row shows its id instead of the spell name")
    local columns = find("Columns")
    for i = 1, 3 do
      expect(math.abs(columns[i]:GetBottom() - columns[1]:GetBottom()) < 0.5 and columns[i]:GetWidth() > 100, "column "..i.." is not laid out")
    end
    local listBottom = spellList():GetBottom()
    expect(listBottom > dialog:GetBottom() and listBottom < dialog:GetBottom() + 80, "the spell list does not reach down to the link button")
    W.fireScript(dialog.kitTitleBar, "OnDragStart")
    expect(not W.state[dialog].moving, "dragging the title bar moved the enemy info window")
    render("enemy info", main, { dialog })
  end)

  step("enemy info: characteristics show their icons in full color with a tooltip", function()
    local data = blip.data
    local saved = data.characteristics
    data.characteristics = { Root = true, Stun = true, Fear = true }
    MDT:UpdateEnemyInfoFrame()
    local icons = find("Row", function(row) return row.kitChildren[1] and row.kitChildren[1].kitProps.variant == "icon" end)
    expect(icons and #icons.kitChildren == 3, "expected 3 characteristic icons, got "..(icons and #icons.kitChildren or 0))
    local tooltips = {}
    for i, icon in ipairs(icons.kitChildren) do
      expect(table.concat({ icon.kitIcon:GetVertexColor() }, ",") == "1,1,1,1", "characteristic icon "..i.." is tinted")
      expect(icon:GetLeft() >= icons:GetLeft() and icon:GetWidth() > 0, "characteristic icon "..i.." is not laid out")
      W.hover(icon)
      expect(GameTooltip:IsShown() and GameTooltip:GetOwner() == icon, "characteristic icon "..i.." shows no tooltip")
      tooltips[i] = (W.state[GameTooltip].lines or {})[1]
      W.fireScript(icon, "OnLeave")
    end
    expect(table.concat(tooltips, ",") == table.concat({ L["Stun"], L["Fear"], L["Root"] }, ","), "icons are not in characteristic order: "..table.concat(tooltips, ","))
    render("enemy info characteristics", main, { window() })
    data.characteristics = saved
    MDT:UpdateEnemyInfoFrame()
    expect(saved ~= nil or #icons.kitChildren == 0, "icons stayed after the characteristics were removed")
  end)

  step("enemy info: the enemy dropdown switches to another enemy", function()
    local dropdown = find("Dropdown")
    expect(dropdown:GetValue() == blip.enemyIdx, "dropdown shows enemy "..tostring(dropdown:GetValue()))
    click(dropdown.kitButton)
    local list = menuList()
    local otherIdx = blip.enemyIdx == 1 and 2 or 1
    local other = MDT.dungeonEnemies[db.currentDungeonIdx][otherIdx]
    local row
    for index, item in ipairs(list.kitProps.items) do
      if item.value == otherIdx then
        list:ScrollTo(index, "nearest")
        row = list:GetRow(index)
      end
    end
    expect(row, "enemy "..otherIdx.." is not in the dropdown")
    click(row)
    expect(window().kitTitle:GetText() == L[other.name], "title did not follow the dropdown: "..tostring(window().kitTitle:GetText()))
    expect(field(L["Enemy Info NPC Id"]):GetValue() == tostring(other.id), "fields did not follow the dropdown")
    expect(#spellList().kitProps.items == spellCount(other), "spell list did not follow the dropdown")
    expect(MDT:GetEnemyInfoEnemyIdx() == otherIdx, "enemy index is "..tostring(MDT:GetEnemyInfoEnemyIdx()))
    MDT:ShowEnemyInfoFrame(blip)
    expect(window().kitTitle:GetText() == L[blip.data.name], "opening from the blip again did not switch back")
  end)

  step("enemy info: scrolling the spell list and hovering a spell shows its tooltip", function()
    local list = spellList()
    local row = list:GetRow(1)
    local overflow = list.kitTotal > list:GetHeight()
    W.fireScript(row, "OnMouseWheel", -1)
    if overflow then
      expect(list:GetOffset() > 0, "the mouse wheel did not scroll the spell list")
      W.fireScript(list:GetRow(2) or row, "OnMouseWheel", 1)
    end
    expect(list:GetOffset() == 0, "spell list did not scroll back to the top")
    local index, item
    for i, candidate in ipairs(list.kitProps.items) do
      if #candidate.statuses > 0 and not index then index, item = i, candidate end
    end
    index, item = index or 1, item or list.kitProps.items[1]
    list:ScrollTo(index, "nearest")
    row = list:GetRow(index)
    GameTooltip:Hide()
    W.hover(row)
    expect(GameTooltip:IsShown() and GameTooltip:GetOwner() == row, "hovering a spell shows no tooltip")
    local lines = W.state[GameTooltip].lines or {}
    expect(#lines == #item.statuses, ("tooltip has %d status lines for %d statuses"):format(#lines, #item.statuses))
    for i, status in ipairs(item.statuses) do
      expect(lines[i]:find(status.label, 1, true), "tooltip line "..i.." does not name "..status.label)
      expect(row.kitStatusIcons and next(row.kitStatusIcons), "row has no status icons")
    end
    W.fireScript(row, "OnLeave")
    expect(not GameTooltip:IsShown(), "spell tooltip stayed up after the cursor left")
  end)

  step("enemy info: fields are read-only and shift-click links a spell into chat", function()
    local box = field(L["Enemy Info NPC Name"])
    local before = box:GetValue()
    W.userClick(box.kitEdit)
    expect(box.kitEdit:HasFocus(), "clicking the name field did not focus it")
    W.userType(box.kitEdit, "x")
    expect(box:GetValue() == before and box.kitEdit:GetText() == before, "typing changed a read-only field to "..box.kitEdit:GetText())
    box:ClearFocus()
    local stealth = find("Checkbox")
    local value = stealth:GetValue()
    click(stealth)
    expect(stealth:GetValue() == value and stealth:IsDisabled(), "the stealth checkbox can be toggled")

    local chat = _G.ChatFrame1EditBox
    _G.DEFAULT_CHAT_FRAME.editBox = chat
    chat:Show()
    chat:SetText("look: ")
    W.modifiers = { shift = true }
    local row = spellList():GetRow(1)
    click(row)
    W.modifiers = nil
    expect(chat:GetText() == "look: "..C_Spell.GetSpellLink(row.spellId), "shift-click did not insert the spell link: "..chat:GetText())
    chat:Hide()
    _G.DEFAULT_CHAT_FRAME.editBox = nil
  end)

  step("enemy info: Link Spells posts every spell to the group", function()
    local link = find("Button", function(button) return button:GetText() == L["Link Spells"] end)
    expect(link and link:IsVisible(), "no Link Spells button")
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

  step("enemy info: a key level change refreshes the health field", function()
    local level = MDT:GetSidebarControl("level")
    local box = find("EditBox", function(candidate) return candidate.kitProps.label:find("%+") ~= nil end)
    expect(box, "no health field")
    local before = box.kitProps.label
    click(level.kitUp)
    W.settle(asyncIdle, 30)
    expect(box.kitProps.label ~= before and box.kitProps.label:find("+"..db.currentDifficulty, 1, true), "health label did not follow the level: "..box.kitProps.label)
    local health = MDT:FormatEnemyHealth(MDT:CalculateEnemyHealth(blip.data.isBoss or false, blip.data.health, db.currentDifficulty, blip.data.ignoreFortified))
    expect(box:GetValue() == health, "health is "..box:GetValue().." at +"..db.currentDifficulty..", expected "..health)
    click(level.kitDown)
    W.settle(asyncIdle, 30)
  end)

  step("enemy info: dev mode keys toggle a spell flag on the hovered row", function()
    local devMode = db.devMode
    db.devMode = true
    MDT:UpdateEnemyInfoFrame()
    expect(find("Text", function(text) return text.kitLabel:GetText():find("Toggle", 1, true) ~= nil end):IsShown(), "dev key help is hidden in dev mode")
    local list = spellList()
    local row = list:GetRow(1)
    local spellId = row.spellId
    local spell = blip.data.spells[spellId]
    local before = spell.magic
    W.hover(row)
    expect(W.state[row].keyboard, "hovering a spell in dev mode did not take the keyboard")
    W.fireScript(row, "OnKeyDown", "M")
    expect(spell.magic == not before, "M did not toggle magic")
    local magicShown = false
    for _, status in ipairs(list.kitProps.items[1].statuses) do if status.key == "magic" then magicShown = true end end
    expect(magicShown == (spell.magic == true), "the row's statuses did not follow the toggle")
    W.fireScript(list:GetRow(1), "OnKeyDown", "M")
    spell.magic = before
    W.fireScript(list:GetRow(1), "OnLeave")
    expect(not W.state[row].keyboard, "the row kept the keyboard after the cursor left")
    db.devMode = devMode
    MDT:UpdateEnemyInfoFrame()
    expect(not find("Text", function(text) return text.kitLabel:GetText():find("Toggle", 1, true) ~= nil end):IsShown(), "dev key help is shown outside dev mode")
  end)

  step("enemy info: follows the map through maximize and restore", function()
    click(main.maximizeButton)
    W.settle(asyncIdle, 30)
    expect(window(), "maximize closed enemy info")
    expectCoversMap()
    render("enemy info maximized", main, { window() })
    click(main.maximizeButton)
    W.settle(asyncIdle, 30)
    expectCoversMap()
  end)

  step("enemy info: Escape closes it before the main window and the model leaves with it", function()
    local dialog = window()
    expect(CloseSpecialWindows(), "no special window closed")
    expect(window() == nil and not dialog:IsShown(), "Escape did not close enemy info")
    expect(main:IsShown(), "Escape closed the main window instead of enemy info")
    W.settle(asyncIdle, 5)
    MDT:UpdateEnemyInfoFrame()
    MDT:UpdateEnemyInfoData()
    expect(window() == nil, "an update reopened enemy info")
    MDT:ShowEnemyInfoFrame(blip)
    expect(window() and window():IsVisible(), "enemy info did not reopen")
    MDT:HideInterface()
    expect(window() == nil, "hiding the main window left enemy info open")
    MDT.main_frame:Show()
    W.settle(asyncIdle, 5)
  end)
end
