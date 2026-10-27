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
  local function title(enemy)
    local name = L[enemy.data.name]
    if enemy.clone.g then name = string.format(L["G%d:"], enemy.clone.g).." "..name end
    return enemy.data.isBoss and name or name.." #"..enemy.cloneIdx
  end
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
    expect(text("hover", "name") == title(blip), "card name is "..tostring(text("hover", "name")))
    local health = MDT:FormatEnemyHealth(MDT:CalculateEnemyHealth(blip.data.isBoss or false, blip.data.health, db.currentDifficulty, blip.data.ignoreFortified))
    expect(text("hover", "health"):find(health, 1, true), "health line is "..text("hover", "health"))
    local count = MDT:GetCloneEnemyForces(blip.data, blip.clone)
    expect(text("hover", "forces"):find(MDT:FormatEnemyForces(count), 1, true), "forces line is "..text("hover", "forces"))
    -- E: 3.4 after the count, colored as a whole in the efficiency color.
    local score, colorHex = MDT:GetEfficiencyScore(count, blip.data.health)
    local expected = ("|cFF%s%s|r"):format(colorHex, string.format(L["enemyInfoEfficiencyShort"], score))
    expect(text("hover", "score") == expected, "efficiency is "..tostring(text("hover", "score")).." expected "..expected)
    local forces, scoreText = part("hover", "forces"), part("hover", "score")
    expect(scoreText:GetLeft() > forces:GetRight() and math.abs(scoreText:GetTop() - forces:GetTop()) < 0.5, "the efficiency is not after the count")
    expect(scoreText.kitLabel:GetLeft() + scoreText.kitLabel:GetStringWidth() <= card("hover"):GetRight(), "the efficiency runs off the card")
    expect(hover:GetLeft() >= blip:GetRight() or hover:GetRight() <= blip:GetLeft(), "the card covers its enemy")
    expect(hover:GetBottom() >= main:GetBottom() - 0.5 and hover:GetRight() <= main:GetRight() + 0.5, "the card leaves the window")
    local spells = spellCount(blip.data)
    local list = part("hover", "spells")
    expect(#list.kitProps.items == math.min(spells, 3) and list:GetHeight() > 0, "the hover card lists "..#list.kitProps.items.." of "..spells.." spells")
    expect(not list.kitBar:IsShown(), "the hover card's spell list scrolls")
    local row = list:GetRow(1)
    expect(row and row:IsVisible() and row.kitName:GetText() ~= "" and row:GetWidth() > 150, ("the first spell row is not laid out: row=%s vis=%s name=%s w=%s list=%sx%s"):format(tostring(row), tostring(row and row:IsVisible()), tostring(row and row.kitName:GetText()), tostring(row and row:GetWidth()), tostring(list:GetWidth()), tostring(list:GetHeight())))
    local lastRow = list:GetRow(math.min(spells, 3))
    if spells > 3 then
      expect(list:GetHeight() < 4 * 22, "the hover card shows more than 3 spell rows")
      -- "+N more" follows the last spell's name on its own line.
      local more = lastRow.kitMore
      expect(more:IsShown() and more:GetText() == string.format(L["+%d more"], spells - 3), "the last spell row does not count the "..(spells - 3).." left out")
      local nameRight = lastRow.kitName:GetLeft() + lastRow.kitName:GetWidth()
      expect(more:GetLeft() >= nameRight and more:GetLeft() - nameRight < 10, ("+more is not right after the name: %.1f after %.1f"):format(more:GetLeft(), nameRight))
      expect(select(2, more:GetCenter()) == select(2, lastRow.kitName:GetCenter()), "+more is not on the last spell's line")
      expect(more:GetLeft() + more:GetWidth() <= lastRow:GetRight() + 0.5, "+more runs off the row")
      for i = 1, 2 do expect(not list:GetRow(i).kitMore:IsShown(), "spell row "..i.." counts left out spells") end
      expect(part("hover", "moreSpellsRow") == nil, "the hover card still has a +more line of its own")
    elseif lastRow then
      expect(not lastRow.kitMore:IsShown(), "a +more for "..spells.." spells")
    end
    expect(part("hover", "pin") and part("hover", "devHint") == nil, "the hover card has no pin button or shows dev hints outside dev mode")
    expect(text("hover", "ctrlHint") == L["enemyInfoHoldCtrlTip"], "the hover card does not say Ctrl keeps it open")
    local hint = part("hover", "ctrlHint")
    expect(hint.kitLabel:GetJustifyH() == "CENTER" and math.abs(hint:GetWidth() - part("hover", "header"):GetWidth()) < 0.5,
      "the Ctrl hint is not centered across the card")
    for _, id in ipairs({ "level", "efficiency", "npcId", "characteristics" }) do
      expect(part("hover", id) == nil, "the hover card shows "..id)
    end
    expect(math.abs(hover:GetWidth() - 250) < 1 and hover:GetHeight() > 60, ("hover card is %.0fx%.0f"):format(hover:GetWidth(), hover:GetHeight()))
    render("enemy hover card", main, { hover })
  end)

  step("enemy card: the hover card goes as soon as the cursor leaves its enemy unless Ctrl is held", function()
    local hover = card("hover")
    rest(0.5)
    expect(shown("hover"), "the card left while the cursor is on its enemy")
    -- Even on the way to the card, leaving the enemy hides it.
    local function centerOf(region)
      local left, bottom, width, height = region:GetScaledRect()
      return left + width / 2, bottom + height / 2
    end
    W.fireScript(blip, "OnLeave")
    local x1, y1 = centerOf(blip)
    local x2, y2 = centerOf(hover)
    W.cursorX, W.cursorY = x1 + (x2 - x1) * 0.3, y1 + (y2 - y1) * 0.3
    expect(not blip:IsMouseOver() and not hover:IsMouseOver(), "setup: the cursor is not between the enemy and the card")
    W.pump(1 / 60)
    expect(not shown("hover"), "the card stayed after the cursor left its enemy towards it")

    -- Ctrl held before the cursor reaches an enemy locks the card on that first enemy.
    W.modifiers = { ctrl = true }
    W.hover(blip)
    expect(shown("hover") and text("hover", "name") == title(blip), "entering an enemy with Ctrl held showed no card")
    W.fireScript(blip, "OnLeave")
    W.hover(other)
    rest(0.5)
    expect(shown("hover") and text("hover", "name") == title(blip), "with Ctrl held from the start, another enemy took the card")
    W.fireScript(other, "OnLeave")
    moveAway()
    W.modifiers = nil
    W.pump(1 / 60)
    expect(not shown("hover"), "the card stayed after Ctrl was released away from any enemy")

    W.hover(blip)
    W.fireScript(blip, "OnLeave")
    W.modifiers = { ctrl = true }
    moveAway()
    rest(0.5)
    expect(shown("hover"), "the card left while Ctrl was held")
    W.modifiers = nil
    W.pump(1 / 60)
    expect(not shown("hover"), "the card stayed after Ctrl was released")

    W.hover(blip)
    W.modifiers = { ctrl = true }
    W.fireScript(blip, "OnLeave")
    W.hover(other)
    rest(0.5)
    expect(shown("hover") and text("hover", "name") == title(blip), "hovering another enemy with Ctrl held switched the card")
    W.modifiers = nil
    W.pump(1 / 60)
    expect(shown("hover") and text("hover", "name") == title(other), "releasing Ctrl over another enemy did not switch the card to it")
    W.fireScript(other, "OnLeave")
    moveAway()
    W.pump(1 / 60)
    expect(not shown("hover"), "the card stayed after the cursor left the enemy it switched to")

    W.hover(blip)
    W.fireScript(blip, "OnLeave")
    W.hover(other)
    expect(shown("hover") and text("hover", "name") == title(other), "hovering another enemy did not switch the card")
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
    expect(text("pinned", "name") == title(blip) and text("pinned", "npcId"):find(tostring(blip.data.id), 1, true), "the pinned card shows the wrong enemy")
    local list = part("pinned", "spells")
    expect(#list.kitProps.items == spellCount(blip.data), "the pinned card lists the wrong spells")
    expect(part("pinned", "linkSpells") and part("pinned", "pin") == nil and part("pinned", "score") == nil and part("pinned", "ctrlHint") == nil, "the pinned card has hover-card parts")
    -- Under the portrait, top to bottom: health and count, efficiency, level and type, NPC id. The spells start right
    -- under the header.
    local model = part("pinned", "model")
    local previous = model
    for _, id in ipairs({ "health", "forces", "efficiency", "level", "npcId" }) do
      local detail = part("pinned", id)
      expect(detail and detail:IsVisible(), "the pinned card has no "..id)
      expect(detail:GetTop() <= previous:GetBottom() + 0.5 and math.abs(detail:GetLeft() - model:GetLeft()) < 0.5,
        ("%s is not under the portrait in order"):format(id))
      previous = detail
    end
    local health = MDT:FormatEnemyHealth(MDT:CalculateEnemyHealth(blip.data.isBoss or false, blip.data.health, db.currentDifficulty, blip.data.ignoreFortified))
    expect(text("pinned", "health") == L["Health"]..": "..health, "the pinned card's health is "..text("pinned", "health"))
    local forces = MDT:FormatEnemyForces(MDT:GetCloneEnemyForces(blip.data, blip.clone))
    expect(text("pinned", "forces") == L["Enemy Info NPC Enemy Forces"]..": "..forces, "the pinned card's forces are "..text("pinned", "forces"))
    expect(math.abs(list:GetTop() - model:GetTop()) < 0.5, "the spells do not start beside the portrait's top")
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
    expect(shown("pinned") and text("pinned", "name") == title(other), "the pin button did not pin the hovered enemy")
    expect(not shown("hover"), "the hover card stayed after pinning")
    moveAway()
    rest(0.3)
    W.hover(blip)
    expect(shown("hover") and text("hover", "name") == title(blip) and shown("pinned"), "hovering another enemy while one is pinned failed")
    W.fireScript(blip, "OnLeave")
    moveAway()
    rest(0.5)
    W.hover(card("pinned").blip)
    expect(not shown("hover"), "hovering the pinned enemy shows a second card")
    W.fireScript(card("pinned").blip, "OnLeave")
    moveAway()

    local first = card("pinned")
    MDT:ShowEnemyInfoFrame(blip)
    local second = card("pinned")
    local cards = MDT:GetEnemyInfoPinnedCards()
    expect(#cards == 2 and second ~= first and first:IsVisible() and second:IsVisible(), "pinning another enemy did not open a second card")
    expect(text("pinned", "name") == title(blip) and first.blip == other, "the second card shows the wrong enemy")
    expect(second:GetFrameLevel() > first:GetFrameLevel(), "the new card is not in front")
    W.hover(blip)
    expect(not shown("hover"), "hovering the second pinned enemy shows a hover card")
    W.fireScript(blip, "OnLeave")
    moveAway()

    MDT:ShowEnemyInfoFrame(other)
    expect(#MDT:GetEnemyInfoPinnedCards() == 2 and card("pinned") == first, "pinning an enemy again did not bring its card to the front")
    expect(first:GetFrameLevel() > second:GetFrameLevel(), "the card brought to the front is behind")
    W.fireScript(second.dragHandle, "OnDragStart")
    W.fireScript(second.dragHandle, "OnDragStop")
    expect(card("pinned") == second and second:GetFrameLevel() > first:GetFrameLevel(), "dragging a card did not bring it to the front")
    -- A click is for the card the frame under the cursor belongs to; one on a frame above the cards, like a dialog, is not.
    W.mouseFocus = main
    W.FireEvent("GLOBAL_MOUSE_DOWN", "LeftButton")
    expect(card("pinned") == second, "a click outside the cards changed their order")
    W.mouseFocus = first.content:Find("name")
    W.FireEvent("GLOBAL_MOUSE_DOWN", "LeftButton")
    expect(card("pinned") == first and first:GetFrameLevel() > second:GetFrameLevel(), "clicking the back card did not bring it to the front")
    W.mouseFocus = first.content
    W.FireEvent("GLOBAL_MOUSE_DOWN", "LeftButton")
    expect(card("pinned") == first, "clicking the front card changed the order")
    W.mouseFocus = nil
    W.cursorTo(second.dragHandle)
    W.fireScript(second.dragHandle, "OnDragStart")
    W.fireScript(second.dragHandle, "OnDragStop")
    moveAway()

    -- The front card closes first on Escape, and a card's close button closes only that card.
    MDT:ShowEnemyInfoFrame(other)
    expect(CloseSpecialWindows(), "Escape closed nothing")
    expect(not first:IsVisible() and second:IsVisible() and main:IsShown(), "Escape did not close only the front card")
    MDT:ShowEnemyInfoFrame(other)
    local reused = card("pinned")
    expect(reused == first and #MDT:GetEnemyInfoPinnedCards() == 2, "a closed card was not reused")
    click(find("Button", function(button) return button.kitProps.variant == "window" end, reused.content))
    expect(not reused:IsVisible() and second:IsVisible() and card("pinned") == second, "the close button did not close only its card")
    expect(text("pinned", "name") == title(blip), "the remaining card shows the wrong enemy")

    -- The map reuses its enemy frames when it redraws, e.g. on another floor: the frame that showed this card's enemy
    -- now shows another one. That enemy still gets its own hover card and pinned card, and this card keeps its enemy.
    local frame, pinnedTitle = blip, title(blip)
    local saved = { frame.enemyIdx, frame.cloneIdx, frame.data, frame.clone }
    frame.enemyIdx, frame.cloneIdx, frame.data, frame.clone = other.enemyIdx, other.cloneIdx, other.data, other.clone
    MDT:DisplayBlipTooltip(frame, true)
    expect(shown("hover") and text("hover", "name") == title(other), "a reused enemy frame shows no hover card for its new enemy")
    moveAway()
    W.pump(1 / 60)
    MDT:ShowEnemyInfoFrame(frame)
    expect(#MDT:GetEnemyInfoPinnedCards() == 2 and text("pinned", "name") == title(other), "pinning the new enemy of a reused frame brought up the old card")
    card("pinned"):Hide()
    MDT:UpdateEnemyInfoFrame()
    expect(shown("pinned") and text("pinned", "name") == pinnedTitle, "refreshing a card whose enemy frame was reused changed its enemy")
    frame.enemyIdx, frame.cloneIdx, frame.data, frame.clone = saved[1], saved[2], saved[3], saved[4]
    MDT:UpdateEnemyInfoFrame()
  end)

  step("enemy card: characteristics show their icons in full color with a tooltip", function()
    local data = blip.data
    local saved = data.characteristics
    data.characteristics = { Root = true, Stun = true, Fear = true }
    MDT:UpdateEnemyInfoFrame()
    local row = part("pinned", "characteristics")
    local icons = {}
    for _, child in ipairs(row and row.kitChildren or {}) do
      if child.kit.name == "Button" then icons[#icons + 1] = child end
    end
    expect(#icons == 3, "expected 3 characteristic icons, got "..#icons)
    local tooltips = {}
    for i, icon in ipairs(icons) do
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

  step("enemy card: a stealth detection icon shows only for enemies that detect stealth", function()
    local data = blip.data
    local stealth, stealthDetect = data.stealth, data.stealthDetect
    data.stealth, data.stealthDetect = nil, nil
    MDT:UpdateEnemyInfoFrame()
    expect(part("pinned", "stealthIcons") == nil, "an enemy without stealth flags shows stealth icons")
    data.stealthDetect = true
    MDT:UpdateEnemyInfoFrame()
    local icons = part("pinned", "stealthIcons")
    expect(icons and #icons.kitChildren == 1, "expected 1 stealth icon, got "..(icons and #icons.kitChildren or 0))
    local icon = icons.kitChildren[1]
    expect(icon.kitIcon:GetTexture() == 166057, "stealth detection does not use the eye shown above NPCs")
    W.hover(icon)
    expect(MDTTooltip:IsShown() and (W.state[MDTTooltip].lines or {})[1] == L["Enemy Info NPC Stealth Detect"], "stealth detection icon has no tooltip")
    W.fireScript(icon, "OnLeave")
    render("enemy pinned card stealth detection", main, { card("pinned") })
    -- Both stealth icons share the hover card's stats line with the efficiency, which must still fit.
    data.stealth = true
    local hovered = visibleBlips()[2]
    local hoveredData = hovered.data
    local hoveredStealth, hoveredDetect = hoveredData.stealth, hoveredData.stealthDetect
    hoveredData.stealth, hoveredData.stealthDetect = true, true
    W.hover(hovered)
    local score, stealthIcons = part("hover", "score"), part("hover", "stealthIcons")
    expect(stealthIcons and #stealthIcons.kitChildren == 2, "setup: the hover card does not show both stealth icons")
    expect(score.kitLabel:GetStringWidth() <= score:GetWidth() + 0.5 and score:GetRight() <= stealthIcons:GetLeft() + 0.5,
      ("the efficiency does not fit beside the stealth icons: text %.1f in %.1f"):format(score.kitLabel:GetStringWidth(), score:GetWidth()))
    W.fireScript(hovered, "OnLeave")
    moveAway()
    W.pump(1 / 60)
    hoveredData.stealth, hoveredData.stealthDetect = hoveredStealth, hoveredDetect
    data.stealth, data.stealthDetect = stealth, stealthDetect
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
    local canvas = main.scrollFrame
    local function near(a, b) return math.abs(a - b) < 0.5 end
    -- The kit frames under the title take the mouse in game, so the handle must sit above them.
    local handle, name = pinned.dragHandle, part("pinned", "name")
    W.cursorTo(name)
    expect(handle:IsMouseOver() and handle:GetFrameLevel() > name:GetFrameLevel(), "the title is not a drag handle above the card's content")
    expect(handle:GetRight() <= name:GetRight() + 0.5, "the drag handle covers the close button")

    local scale = pinned:GetEffectiveScale()
    local function moveCursor(dx, dy)
      W.cursorX, W.cursorY = W.cursorX + dx * scale, W.cursorY + dy * scale
      W.pump(1 / 60)
    end
    local left, top = pinned:GetLeft(), pinned:GetTop()
    local dx = pinned:GetCenter() < canvas:GetCenter() and 40 or -40
    local dy = select(2, pinned:GetCenter()) < select(2, canvas:GetCenter()) and 30 or -30
    W.fireScript(handle, "OnDragStart")
    moveCursor(dx, dy)
    expect(near(pinned:GetLeft(), left + dx) and near(pinned:GetTop(), top + dy),
      ("dragging the title did not move the card with the cursor: %.1f,%.1f from %.1f,%.1f"):format(pinned:GetLeft(), pinned:GetTop(), left, top))
    moveCursor(100000, -100000)
    expect(near(pinned:GetRight(), canvas:GetRight()) and near(pinned:GetBottom(), canvas:GetBottom()), "the card left the map at its bottom right")
    moveCursor(-200000, 200000)
    expect(near(pinned:GetLeft(), canvas:GetLeft()) and near(pinned:GetTop(), canvas:GetTop()), "the card left the map at its top left")
    W.fireScript(handle, "OnDragStop")
    left, top = pinned:GetLeft(), pinned:GetTop()
    moveCursor(50, -50)
    expect(near(pinned:GetLeft(), left) and near(pinned:GetTop(), top), "the card kept following the cursor after the drag")
    expect(select(2, pinned:GetPoint()) == canvas, "the dragged card is not anchored to the map")
    expect(CloseSpecialWindows(), "no special window closed")
    expect(not shown("pinned") and main:IsShown(), "Escape did not close the pinned card first")
    W.settle(asyncIdle, 5)
    MDT:UpdateEnemyInfoFrame()
    MDT:UpdateEnemyInfoData()
    expect(not shown("pinned"), "an update reopened the pinned card")
    -- Two pinned cards, so every one has to go, not just the front one.
    local function pinBoth()
      MDT:ShowEnemyInfoFrame(blip)
      MDT:ShowEnemyInfoFrame(other)
      local cards = MDT:GetEnemyInfoPinnedCards()
      expect(#cards == 2, "setup: pinned "..#cards.." cards, expected 2")
      return cards
    end
    local function noneShown(cards)
      for _, pinnedCard in ipairs(cards) do
        if pinnedCard:IsVisible() then return false end
      end
      return #MDT:GetEnemyInfoPinnedCards() == 0
    end
    local cards = pinBoth()
    MDT:HideInterface()
    expect(noneShown(cards), "hiding the main window left a pinned card")
    MDT.main_frame:Show()
    W.settle(asyncIdle, 5)
    expect(noneShown(cards), "showing the window again brought back a pinned card")
    cards = pinBoth()
    local before = db.currentDungeonIdx
    MDT:UpdateToDungeon(before == 45 and 46 or 45)
    W.settle(asyncIdle, 30)
    expect(noneShown(cards), "switching dungeon left a pinned card open")
    MDT:UpdateToDungeon(before)
    W.settle(asyncIdle, 30)
    blip = visibleBlips()[1]
  end)

  step("efficiency colors rate a score against the dungeon's typical enemy: half red, typical yellow, double green", function()
    local scores = {}
    local total = MDT.dungeonTotalCount[db.currentDungeonIdx].normal
    local function score(count, health) return 2.5 * (count / total) * 13000 / (health / 20000) end
    for _, enemy in pairs(MDT.dungeonEnemies[db.currentDungeonIdx]) do
      if not enemy.isBoss and (enemy.count or 0) > 0 and (enemy.health or 0) > 0 then scores[#scores + 1] = score(enemy.count, enemy.health) end
    end
    expect(#scores > 2, "setup: the dungeon has too few enemies")
    table.sort(scores)
    local middle = (#scores + 1) / 2
    local typical = (scores[math.floor(middle)] + scores[math.ceil(middle)]) / 2
    -- The health that gives 10 forces a score of typical * factor.
    local function colorAt(factor) return select(2, MDT:GetEfficiencyScore(10, score(10, 1) / (typical * factor))) end
    ---Whether a hex color is within rounding of red, green, blue in 0-255.
    local function near(hex, r, g, b)
      local cr, cg, cb = tonumber(hex:sub(1, 2), 16), tonumber(hex:sub(3, 4), 16), tonumber(hex:sub(5, 6), 16)
      return math.abs(cr - r) <= 2 and math.abs(cg - g) <= 2 and math.abs(cb - b) <= 2
    end
    expect(near(colorAt(1), 255, 255, 0), "the typical score is "..colorAt(1).." not yellow")
    expect(near(colorAt(2), 0, 255, 0) and near(colorAt(4), 0, 255, 0), "twice the typical score is "..colorAt(2).." not green")
    expect(near(colorAt(0.5), 255, 0, 0) and near(colorAt(0.1), 255, 0, 0), "half the typical score is "..colorAt(0.5).." not red")
    expect(near(colorAt(1.41), 128, 255, 0), "1.41 times the typical score is "..colorAt(1.41).." not halfway to green")
  end)

  step("pinned enemy card: drags from anywhere on its layout and text, while its buttons, spells and model keep working", function()
    local blip
    for _, frame in ipairs(MDT.dungeonEnemies_framePool.active) do
      if frame:IsVisible() and frame.data and frame.data.spells and next(frame.data.spells) then blip = frame break end
    end
    expect(blip, "setup: no visible enemy with spells")
    MDT:CloseEnemyInfo()
    MDT:ShowEnemyInfoFrame(blip)
    local pinned = MDT:GetEnemyInfoCard("pinned")
    expect(#MDT:GetEnemyInfoPinnedCards() == 1, "setup: other pinned cards are open")
    expect(pinned and pinned:IsShown(), "setup: pinning opened no card")
    ---Presses on a frame of the card, moves the cursor 40 pixels right with the button down and lets go; returns how far
    ---the card moved.
    local function dragFrom(frame)
      local left = pinned:GetLeft()
      local x, y = frame:GetCenter()
      W.cursorTo(frame, x, y)
      W.mouseFocus, W.mouseDown = frame, true
      W.FireEvent("GLOBAL_MOUSE_DOWN", "LeftButton")
      W.pump(0.02)
      W.cursorTo(frame, x + 40, y)
      W.pump(0.05)
      W.cursorTo(frame, x + 40, y)
      W.pump(0.05)
      W.mouseDown = false
      W.pump(0.05)
      W.mouseFocus = nil
      return pinned:GetLeft() - left
    end
    local health = pinned.content:Find("health")
    expect(math.abs(dragFrom(health) - 40) < 1, "dragging from the card's health text did not move it with the cursor")
    expect(math.abs(dragFrom(pinned.content:Find("stats")) - 40) < 1, "dragging from the card's layout did not move it")
    local spells = pinned.content:Find("spells")
    expect(spells and spells:GetRow(1), "setup: the pinned card lists no spells")
    expect(dragFrom(spells:GetRow(1)) == 0, "a press on a spell row dragged the card")
    expect(dragFrom(pinned.model) == 0, "a press on the model dragged the card")
    expect(dragFrom(pinned.content:Find("linkSpells")) == 0, "a press on a button dragged the card")
    pinned:Hide()
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
    expect(shown("pinned") and text("pinned", "name") == title(blip), "Open Enemy Info did not pin the selected blip")
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
