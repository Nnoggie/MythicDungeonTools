-- Harness steps for the pull labels on the map: placement around the enemies, the hover card, clicks, the pull menu and
-- dragging a label onto another pull to merge them. Driven through real frames. Not shipped code.
return function(ctx)
  local W, MDT, step, expect, click, asyncIdle, render = ctx.W, ctx.MDT, ctx.step, ctx.expect, ctx.click, ctx.asyncIdle, ctx.render
  local UI, L = MDT.UI, MDT.L
  local main = MDT.main_frame
  local db = MDT:GetDB()

  local function preset() return MDT:GetCurrentPreset() end
  local function pulls() return preset().value.pulls end
  local function label(index) return MDT:GetPullLabel(index) end

  local function visibleBlips()
    local found = {}
    for _, frame in ipairs(MDT.dungeonEnemies_framePool.active) do
      if frame:IsVisible() and frame.data and not frame.data.isBoss then found[#found + 1] = frame end
    end
    return found
  end

  ---A region's rect in screen pixels, so regions of different scales compare.
  local function screenRect(region)
    local scale = region:GetEffectiveScale()
    return region:GetLeft() * scale, region:GetRight() * scale, region:GetBottom() * scale, region:GetTop() * scale
  end

  local function rectsOverlap(a, b)
    local al, ar, ab, at = screenRect(a)
    local bl, br, bb, bt = screenRect(b)
    return al < br and bl < ar and ab < bt and bb < at
  end

  ---Whether a label covers an enemy's face: more than the outer 45% of its portrait, which is 20 units across at the
  ---enemy's scale. Labels may reach into the edge of a portrait, to sit between the enemies of their pull.
  local function coversFace(region, blip)
    local l, r, b, t = screenRect(region)
    local x, y = blip:GetCenter()
    local scale = blip:GetEffectiveScale()
    x, y = x * scale, y * scale
    local radius = 10 * blip.normalScale * scale
    local dx, dy = math.max(l, math.min(x, r)) - x, math.max(b, math.min(y, t)) - y
    return math.sqrt(dx * dx + dy * dy) < radius * (1 - 0.45) - 0.01
  end

  local function clonesIn(pull)
    local count = 0
    for enemyIdx, clones in pairs(pull) do
      if tonumber(enemyIdx) then count = count + #clones end
    end
    return count
  end

  local saved
  local packSize, neighbourSize = 5, 3

  step("pull labels: a dense pack and the pull beside it each get a label with their number and running total", function()
    saved = { pulls = CopyTable(pulls()), current = preset().value.currentPull, selection = CopyTable(preset().value.selection or {}) }
    local blips = visibleBlips()
    expect(#blips >= packSize + neighbourSize, "setup: only "..#blips.." enemies on the map")
    -- The densest spot on the map: the enemy closest to its four nearest neighbours.
    local function byDistance(seed)
      local sx, sy = seed:GetCenter()
      local sorted = {}
      for _, blip in ipairs(blips) do sorted[#sorted + 1] = blip end
      table.sort(sorted, function(a, b)
        local ax, ay = a:GetCenter()
        local bx, by = b:GetCenter()
        return (ax - sx) ^ 2 + (ay - sy) ^ 2 < (bx - sx) ^ 2 + (by - sy) ^ 2
      end)
      return sorted
    end
    local seed, best
    for _, blip in ipairs(blips) do
      local sorted, sum = byDistance(blip), 0
      local sx, sy = blip:GetCenter()
      for i = 2, packSize do
        local x, y = sorted[i]:GetCenter()
        sum = sum + math.sqrt((x - sx) ^ 2 + (y - sy) ^ 2)
      end
      if not best or sum < best then seed, best = blip, sum end
    end
    local sorted = byDistance(seed)
    preset().value.pulls = { {}, {}, {} }
    MDT:EnsureDBTables()
    for i = 1, packSize + neighbourSize do
      MDT:DungeonEnemies_AddOrRemoveBlipToCurrentPull(sorted[i], true, true, nil, i <= packSize and 1 or 2)
    end
    MDT:SetSelectionToPull(1)
    MDT:UpdateMap()
    W.settle(asyncIdle, 30)
    expect(clonesIn(pulls()[1]) == packSize and clonesIn(pulls()[2]) == neighbourSize, "setup: pulls hold "..clonesIn(pulls()[1]).." and "..clonesIn(pulls()[2]).." enemies")

    local items = MDT.SidebarModel.PullItems(pulls(), MDT:SidebarContext())
    for index = 1, 2 do
      local shown = label(index)
      expect(shown and shown:IsVisible(), "pull "..index.." has no label")
      expect(shown.number:GetText() == tostring(index), "label "..index.." shows number "..tostring(shown.number:GetText()))
      expect(shown.total:GetText() == items[index].cumulativeText, "label "..index.." shows "..tostring(shown.total:GetText()).." not "..items[index].cumulativeText)
      local r, g, b = unpack(W.state[shown.edgeMiddle].color)
      local color = items[index].color
      if index == MDT:GetCurrentPull() then
        expect(math.abs(r - color[1]) < 0.01 and math.abs(g - color[2]) < 0.01 and math.abs(b - color[3]) < 0.01, "label "..index.." is not in its pull's color")
      else
        -- Other pulls' labels fade towards the background instead of turning see-through.
        expect(shown:GetAlpha() == 1, "label "..index.." is see-through")
        expect(r + g + b < color[1] + color[2] + color[3] - 0.05, "label "..index.." is not faded")
      end
      expect(shown.number:GetLeft() >= shown:GetLeft() - 0.5 and shown.total:GetRight() <= shown:GetRight() + 0.5, "label "..index.."'s text runs off it")
    end
    expect(label(3) == nil, "the empty pull 3 has a label")
    expect(label(1).bright and not label(2).bright, "only the current pull's label is fully lit")
    render("pull labels", main)
  end)

  step("pull outlines: opaque with their round joins, the current pull's in full color above the others", function()
    local function textures(index)
      local found = MDT:GetPullOutlineTextures(index)
      expect(#found > 0, "pull "..index.." has no outline")
      return found
    end
    local function state(tex)
      local r, g, b, a = tex:GetVertexColor()
      local _, sublevel = tex:GetDrawLayer()
      return r + g + b, a, sublevel
    end
    local items = MDT.SidebarModel.PullItems(pulls(), MDT:SidebarContext())
    local function fullOf(index) return items[index].color[1] + items[index].color[2] + items[index].color[3] end
    local full = fullOf(2)
    local circles = 0
    for _, tex in ipairs(textures(2)) do
      local sum, alpha, sublevel = state(tex)
      expect(alpha == 1 and tex:IsShown(), "pull 2's outline is see-through or hidden")
      expect(sum < full - 0.05 and sublevel < 7, "pull 2's outline is not faded below the current pull's")
      if tex:GetTexture():find("Circle_White") then circles = circles + 1 end
    end
    expect(circles > 0, "pull 2's outline draws no round joins")
    for _, tex in ipairs(textures(1)) do
      local sum, alpha, sublevel = state(tex)
      expect(alpha == 1 and math.abs(sum - fullOf(1)) < 0.01 and sublevel == 7, "the current pull's outline is not in full color on top")
    end
    W.hover(label(2))
    for _, tex in ipairs(textures(2)) do
      local sum, _, sublevel = state(tex)
      expect(math.abs(sum - full) < 0.01 and sublevel == 7, "hovering pull 2 does not light its outline up on top")
    end
    W.fireScript(label(2), "OnLeave")
    for _, tex in ipairs(textures(2)) do
      local sum, _, sublevel = state(tex)
      expect(sum < full - 0.05 and sublevel < 7, "pull 2's outline stays lit after the hover")
    end
  end)

  step("pull labels: no label covers an enemy's face or another label", function()
    local blips = visibleBlips()
    for index = 1, 2 do
      for _, blip in ipairs(blips) do
        expect(not coversFace(label(index), blip), ("label %d covers %s #%d"):format(index, blip.data.name, blip.cloneIdx))
      end
    end
    expect(not rectsOverlap(label(1), label(2)), "the labels overlap")
  end)

  step("pull labels: labels zoom with the map", function()
    local _, _, _, before = screenRect(label(1))
    local _, _, bottom = screenRect(label(1))
    local height = before - bottom
    local scale = main.mapPanelFrame:GetScale()
    main.mapPanelFrame:SetScale(scale * 3)
    local _, _, zoomedBottom, zoomedTop = screenRect(label(1))
    main.mapPanelFrame:SetScale(scale)
    expect(math.abs((zoomedTop - zoomedBottom) - height * 3) < 0.5, ("label is %.1f high zoomed in, %.1f before"):format(zoomedTop - zoomedBottom, height))
  end)

  step("pull labels: hovering a label shows its pull card and lights it up, leaving hides the card", function()
    local hovered = label(2)
    W.hover(hovered)
    local card = MDT:GetPullLabelCard()
    expect(card and card:IsVisible(), "hovering a label shows no card")
    local item = MDT.SidebarModel.PullItems(pulls(), MDT:SidebarContext())[2]
    local function text(id) return card.content:Find(id).kitLabel:GetText() end
    expect(text("title"):find(string.format(L["Pull %d"], 2), 1, true), "card title is "..text("title"))
    local forces = L["Forces"]..": "..MDT:FormatEnemyForces(item.forces, nil, false).." / "..MDT:FormatEnemyForces(item.cumulative, nil, false)
    expect(text("forces") == forces, "card forces line is "..text("forces"))
    expect(card.content:Find("total") == nil, "the card still has a separate total line")
    local health = string.format(L["%s HP"], MDT:FormatEnemyHealth(item.health)).." · "
      ..L["Efficiency Score"]..": "..MDT:GetEfficiencyScoreString(item.forces, item.baseHealth)
    expect(text("health") == health, "card health is "..text("health").." not "..health)
    expect(card.content:Find("enemies") == nil, "the card lists the pull's enemies")
    expect(card.content:Find("hint") == nil, "the card still has the hint")
    expect(not rectsOverlap(card, hovered), "the card covers its label")
    expect(hovered.bright, "the hovered label is not lit")
    W.fireScript(hovered, "OnLeave")
    expect(not card:IsShown(), "the card stays after leaving the label")
    expect(not hovered.bright, "the label stays lit after leaving it")
  end)

  step("pull labels: the pull card lists the enemies casting spells to interrupt, with portrait, name and spells", function()
    local card
    local function part(id) return card.content:Find(id) end
    W.hover(label(1))
    card = MDT:GetPullLabelCard()
    local expected = MDT.SidebarModel.PullCasters(pulls()[1], MDT.dungeonEnemies[db.currentDungeonIdx])
    expect(#expected > 0, "setup: pull 1 has no enemies casting interruptible spells")
    local heading = part("interruptsTitle") and part("interruptsTitle").kitLabel:GetText()
    expect(heading == CreateAtlasMarkup("icons_16x16_interrupt", 13, 13).." "..L["Interruptible"]..":", "the interruptible heading is "..tostring(heading))
    for i, caster in ipairs(expected) do
      local block = part("caster"..i)
      expect(block, "the card misses caster entry "..i)
      local name = block:Find("name").kitLabel:GetText()
      expect(name:find(L[caster.name], 1, true) and (caster.count == 1 or name:find("x"..caster.count, 1, true)), "caster "..i.." is named "..name)
      -- The portrait is a round texture on the entry's portrait place.
      local place = block:Find("portrait")
      local portrait = card.portraits[i]
      local ring = portrait and portrait.ring
      expect(ring and ring:IsShown() and math.abs(ring:GetLeft() - place:GetLeft()) < 0.5 and math.abs(ring:GetTop() - place:GetTop()) < 0.5
        and ring:GetHeight() == place:GetHeight(), "caster "..i.." has no enemy ring on its place")
      expect(ring:GetTexture():find("UI%-EncounterJournalTextures") and select(1, ring:GetTexCoord()) == 0.85, "caster "..i.."'s ring is not the one enemies wear on the map")
      local px, py = portrait:GetCenter()
      local rx, ry = ring:GetCenter()
      expect(portrait:IsShown() and math.abs(px - rx) < 0.5 and math.abs(py - ry) < 0.5 and math.abs(portrait:GetHeight() - 22.5) < 0.01,
        "caster "..i.."'s portrait does not sit in its ring as on the map")
      expect(place:GetHeight() == 30 and portrait:GetNumMaskTextures() == 1, "caster "..i.."'s portrait is not round")
      local icons, names = 0, {}
      local spells = block:Find("spells")
      for _, chip in ipairs(spells.kitChildren) do
        for _, child in ipairs(chip.kitChildren) do
          if child.kit.name == "Button" then icons = icons + 1 end
        end
        names[#names + 1] = chip:Find("spellName").kitLabel:GetText()
      end
      local wantIcons = #caster.spellIds == 1 and math.min(caster.count, 8) or #caster.spellIds
      expect(icons == wantIcons, ("caster %d shows %d spell icons, not %d"):format(i, icons, wantIcons))
      expect(#names == #caster.spellIds, "caster "..i.." lists "..#names.." spells, not "..#caster.spellIds)
      for _, chip in ipairs(spells.kitChildren) do expect(chip:GetRight() <= card:GetRight() + 0.5, "a spell runs off the card") end
    end
    expect(part("caster"..(#expected + 1)) == nil, "the card lists more casters than the pull has")
    render("pull card interrupts", main)
    W.fireScript(label(1), "OnLeave")
    W.hover(label(2))
    expect(part("interrupts") == nil, "a pull without interruptible spells shows the section")
    for _, portrait in ipairs(card.portraits) do
      expect(not portrait:IsShown() and not portrait.ring:IsShown(), "a caster portrait stays on a card without casters")
    end
    W.fireScript(label(2), "OnLeave")
  end)

  step("pull labels: a hovered label hides the enemy hover card, even while Ctrl holds it", function()
    local blip = visibleBlips()[1]
    local enemyCard = function() return MDT:GetEnemyInfoCard("hover") end
    W.hover(blip)
    expect(enemyCard() and enemyCard():IsShown(), "setup: hovering an enemy shows no card")
    W.modifiers = { ctrl = true }
    W.fireScript(blip, "OnLeave")
    W.hover(label(1))
    W.pump(0.1)
    expect(not enemyCard():IsShown(), "the enemy card stays over a hovered label while Ctrl is held")
    W.hover(blip)
    W.pump(0.1)
    expect(not enemyCard():IsShown(), "an enemy shows its card while a label is hovered")
    W.modifiers = nil
    W.fireScript(blip, "OnLeave")
    W.fireScript(label(1), "OnLeave")
    W.hover(blip)
    expect(enemyCard():IsShown(), "enemies show no card after leaving the label")
    W.fireScript(blip, "OnLeave")
    MDT:HideEnemyHoverCard()
  end)

  step("pull labels: hovering a label shows each caster's spell to interrupt in its portrait, untinted, until the hover ends", function()
    local interrupts = MDT.SidebarModel.PullInterrupts(pulls()[1], MDT.dungeonEnemies[db.currentDungeonIdx])
    local function expectedIcon(blip)
      local clones = pulls()[1][blip.enemyIdx]
      if not (clones and tContains(clones, blip.cloneIdx) and blip.data.spells) then return nil end
      for _, interrupt in ipairs(interrupts) do
        local spell = blip.data.spells[interrupt.spellId]
        if spell and spell.interruptible then return C_Spell.GetSpellTexture(interrupt.spellId) or 134400 end
      end
    end
    -- The portraits as the selection colors them, which the test redraws below.
    MDT:DungeonEnemies_UpdateSelected(MDT:GetCurrentPull())
    local before, casters = {}, 0
    for _, blip in ipairs(visibleBlips()) do
      before[blip] = { blip.texture_Portrait:GetTexture(), { blip.texture_Portrait:GetVertexColor() } }
    end
    W.hover(label(1))
    for blip, was in pairs(before) do
      local icon = expectedIcon(blip)
      local texture = blip.texture_Portrait
      if icon then
        casters = casters + 1
        local r, g, b = texture:GetVertexColor()
        expect(texture:GetTexture() == icon, ("%s #%d shows %s, not its spell icon %s"):format(blip.data.name, blip.cloneIdx, tostring(texture:GetTexture()), tostring(icon)))
        expect(r == 1 and g == 1 and b == 1, "a spell icon is tinted in the pull color")
      else
        expect(texture:GetTexture() == was[1], blip.data.name.." #"..blip.cloneIdx.." changed its portrait without a spell to interrupt")
      end
    end
    expect(casters > 0, "setup: no enemy of pull 1 casts an interruptible spell")
    -- A redraw of the selection keeps the icons untinted.
    MDT:DungeonEnemies_UpdateSelected(MDT:GetCurrentPull())
    for blip in pairs(before) do
      if expectedIcon(blip) then expect(select(2, blip.texture_Portrait:GetVertexColor()) == 1, "the selection redraw tinted a spell icon") end
    end
    W.fireScript(label(1), "OnLeave")
    for blip, was in pairs(before) do
      local texture = blip.texture_Portrait
      local r, g, b = texture:GetVertexColor()
      expect(texture:GetTexture() == was[1], blip.data.name.." #"..blip.cloneIdx.." did not get its portrait back")
      expect(r == was[2][1] and g == was[2][2] and b == was[2][3], blip.data.name.." #"..blip.cloneIdx.." did not get its pull tint back")
    end
  end)

  step("pull labels: the pull card opens where it covers none of its pull's enemies", function()
    local shown = label(1)
    local tile = main.mapPanelTile1
    -- Put the label just above and left of its pull's enemies, so the card's first choice, below and right of the
    -- label, would cover them.
    local blips = {}
    local left, top = math.huge, -math.huge
    for _, blip in ipairs(visibleBlips()) do
      local clones = pulls()[1][blip.enemyIdx]
      if clones and tContains(clones, blip.cloneIdx) then
        blips[#blips + 1] = blip
        local _, _, _, x, y = blip:GetPoint()
        left, top = math.min(left, x), math.max(top, y)
      end
    end
    shown:ClearAllPoints()
    shown:SetPoint("BOTTOMRIGHT", tile, "TOPLEFT", left, top)
    W.hover(shown)
    local card = MDT:GetPullLabelCard()
    for _, blip in ipairs(blips) do
      local x, y = blip:GetCenter()
      local scale = blip:GetEffectiveScale()
      local radius = 10 * blip.normalScale * scale
      local l, r, b, t = screenRect(card)
      local dx = math.max(l, math.min(x * scale, r)) - x * scale
      local dy = math.max(b, math.min(y * scale, t)) - y * scale
      expect(dx * dx + dy * dy >= radius * radius, "the card covers "..blip.data.name.." #"..blip.cloneIdx.." of its pull")
    end
    local l, r, b, t = screenRect(card)
    local ml, mr, mb, mt = screenRect(main)
    expect(l >= ml - 0.5 and r <= mr + 0.5 and b >= mb - 0.5 and t <= mt + 0.5, "the card leaves the window")
    W.fireScript(shown, "OnLeave")
    shown:ClearAllPoints()
    shown:SetPoint("CENTER", tile, "TOPLEFT", shown.placement.x, shown.placement.y)
  end)

  step("pull labels: a caster line too long for the card wraps instead of running off it", function()
    -- Twelve casters of one spell with a long name: eight icons, "+4" and the name cannot share a line.
    local enemies = MDT.dungeonEnemies[db.currentDungeonIdx]
    local caster = MDT.SidebarModel.PullCasters(pulls()[1], enemies)[1]
    expect(caster, "setup: pull 1 has no casters")
    local enemy, clones = enemies[caster.enemyIdx], pulls()[1][caster.enemyIdx]
    local spells, added = enemy.spells, {}
    enemy.spells = { [caster.spellIds[1]] = { interruptible = true } }
    for i = 1, 12 do
      local cloneIdx = 9000 + i
      enemy.clones[cloneIdx] = {}
      clones[#clones + 1] = cloneIdx
      added[#added + 1] = cloneIdx
    end
    local getSpellInfo = C_Spell.GetSpellInfo
    C_Spell.GetSpellInfo = function(spellId)
      local info = getSpellInfo(spellId)
      if info then info.name = "Felfire Burst of the Long Named Inferno Caller" end
      return info
    end
    local ok, err = pcall(function()
      W.hover(label(1))
      local card = MDT:GetPullLabelCard()
      local block = card.content:Find("caster1")
      local chip = block:Find("spells").kitChildren[1]
      local right = card:GetRight()
      local icons = 0
      for _, child in ipairs(chip.kitChildren) do
        expect(child:GetRight() <= right + 0.5, "part of the caster line runs off the card")
        if child.kit.name == "Button" then icons = icons + 1 end
      end
      local count = tonumber(block:Find("name").kitLabel:GetText():match("x(%d+)"))
      expect(count and count > 8 and icons == 8 and chip:Find("more").kitLabel:GetText() == "+"..(count - 8), "the line does not show eight icons and the rest as +N")
      local name = chip:Find("spellName")
      expect(name.kitLabel:GetLeft() >= chip:GetLeft() - 0.5 and name:GetRight() <= right + 0.5, "the spell name runs off the card")
      expect(name:GetTop() < chip.kitChildren[1]:GetBottom() + 0.5, "the spell name did not wrap below the icons")
      render("pull card long caster", main)
    end)
    W.fireScript(label(1), "OnLeave")
    C_Spell.GetSpellInfo = getSpellInfo
    enemy.spells = spells
    for _, cloneIdx in ipairs(added) do
      enemy.clones[cloneIdx] = nil
      for i = #clones, 1, -1 do if clones[i] == cloneIdx then table.remove(clones, i) end end
    end
    expect(ok, tostring(err))
  end)

  step("pull labels: hovering a pull row shows the spells to interrupt in its casters' portraits on the map", function()
    local list = MDT:GetSidebarControl("pulls")
    local row = list:GetRow(1)
    local casters = {}
    for _, blip in ipairs(visibleBlips()) do
      local clones = pulls()[1][blip.enemyIdx]
      if clones and tContains(clones, blip.cloneIdx) and blip.spellPortrait == nil then casters[#casters + 1] = blip end
    end
    W.cursorTo(row, row:GetRight() - 4, select(2, row:GetCenter()))
    W.fireScript(row, "OnEnter")
    W.pump(0.05)
    local swapped = 0
    for _, blip in ipairs(casters) do if blip.spellPortrait then swapped = swapped + 1 end end
    expect(swapped > 0, "hovering pull 1's row swapped no portrait")
    W.fireScript(row, "OnLeave")
    for _, blip in ipairs(casters) do expect(blip.spellPortrait == nil, blip.data.name.." kept its spell icon after the row hover") end
  end)

  step("pull labels: clicking a label selects its pull", function()
    click(label(2))
    expect(MDT:GetCurrentPull() == 2, "current pull is "..MDT:GetCurrentPull())
    expect(label(2).bright and not label(1).bright, "the selected pull's label is not the lit one")
    W.fireScript(label(2), "OnLeave")
  end)

  step("pull labels: right-clicking a label opens the pull menu under the pull's name", function()
    click(label(1), "RightButton")
    local menu = UI.Overlay.Top("menu")
    expect(menu and menu.frame:IsVisible(), "right-clicking a label opened no menu")
    expect(MDT:GetCurrentPull() == 1, "right-clicking did not select the pull")
    local list
    for _, child in ipairs(menu.frame.content.kitChildren) do
      if child.kit.name == "List" then list = child end
    end
    local items = list.kitProps.items
    expect(items[1].kind == "title" and items[1].text == string.format(L["Pull %d"], 1), "the menu does not start with the pull's name")
    local texts = {}
    for _, item in ipairs(items) do texts[item.text or "-"] = true end
    expect(texts[L["Pull Drop Merge down"]] and texts[L["Pull Drop Delete"]], "the menu lacks the pull actions")
    UI.Overlay.PopAll("menu")
    W.fireScript(label(1), "OnLeave")
  end)

  step("pull labels: a label dropped on empty map goes back to its spot", function()
    local dragged = label(2)
    local x, y = dragged:GetCenter()
    W.cursorTo(dragged)
    W.fireScript(dragged, "OnDragStart")
    W.cursorTo(main.mapPanelFrame, main.mapPanelFrame:GetLeft() + 2, main.mapPanelFrame:GetTop() - 2)
    W.pump(0.05)
    expect(not MDTTooltip:IsShown(), "a merge tooltip over empty map")
    W.fireScript(dragged, "OnDragStop")
    W.settle(asyncIdle, 30)
    expect(#pulls() == 3, "dropping on empty map changed the pulls")
    local nx, ny = dragged:GetCenter()
    expect(math.abs(nx - x) < 0.01 and math.abs(ny - y) < 0.01, "the label did not go back to its spot")
  end)

  step("pull labels: redrawing only yields outside MDT's error wrappers, as WoW's Lua 5.1 needs", function()
    -- LuaJIT yields across xpcall; the client's Lua 5.1 raises "attempt to yield across metamethod/C-call boundary".
    local yield, crossed = coroutine.yield, nil
    coroutine.yield = function(...)
      local trace = debug.traceback()
      if trace:find("xpcall", 1, true) then crossed = crossed or trace end
      return yield(...)
    end
    local ok, err = pcall(function()
      MDT:DrawAllHulls(nil, true)
      W.settle(asyncIdle, 30)
    end)
    coroutine.yield = yield
    expect(ok, tostring(err))
    expect(not crossed, "a yield runs inside an xpcall:\n"..tostring(crossed))
  end)

  step("pull labels: a forced redraw keeps the labels up and in their spots", function()
    local x, y = label(1):GetCenter()
    MDT:DrawAllHulls(nil, true)
    expect(label(1) and label(1):IsShown(), "labels go away while the outlines redraw")
    W.settle(asyncIdle, 30)
    local nx, ny = label(1):GetCenter()
    expect(math.abs(nx - x) < 0.01 and math.abs(ny - y) < 0.01, "a redraw with the same pulls moved the label")
  end)

  step("pull labels: with a drawing tool picked, labels let clicks through to the map", function()
    MDT:UpdateSelectedToolbarTool("pencil")
    expect(not label(1):IsMouseEnabled() and not label(2):IsMouseEnabled(), "labels take clicks while drawing")
    MDT:UpdateSelectedToolbarTool()
    expect(label(1):IsMouseEnabled() and label(2):IsMouseEnabled(), "labels stay click-through after the tool is put away")
  end)

  step("pull labels: labels keep clear of points of interest", function()
    local checked = 0
    for _, template in ipairs({ "MapLinkPinTemplate", "DeathReleasePinTemplate", "VignettePinTemplate", "QuestPinTemplate" }) do
      local pool = MDT.GetFramePool(template)
      for _, frame in ipairs(pool and pool.active or {}) do
        if frame:IsVisible() then
          checked = checked + 1
          for index = 1, 2 do expect(not rectsOverlap(label(index), frame), "label "..index.." covers a "..template) end
        end
      end
    end
    expect(checked > 0, "setup: no points of interest on the map")
  end)

  step("pull labels: a drag whose pulls changed meanwhile merges nothing", function()
    local dragged = label(2)
    W.cursorTo(dragged)
    W.fireScript(dragged, "OnDragStart")
    W.cursorTo(label(1))
    W.pump(0.05)
    expect(MDTTooltip:IsShown(), "setup: no merge tooltip over the other label")
    -- A live session replaces the pulls with copies mid-drag.
    preset().value.pulls = CopyTable(pulls())
    W.fireScript(dragged, "OnDragStop")
    W.settle(asyncIdle, 30)
    expect(#pulls() == 3 and clonesIn(pulls()[2]) == neighbourSize, "the drop merged pulls it no longer showed")
    MDT:DrawAllHulls(nil, true)
    W.settle(asyncIdle, 30)
  end)

  step("pull labels: dragging a label onto another pull's label merges the two", function()
    local dragged = label(2)
    W.cursorTo(dragged)
    W.fireScript(dragged, "OnDragStart")
    W.cursorTo(label(1))
    W.pump(0.05)
    expect(MDTTooltip:IsShown() and MDTTooltip:IsOwned(dragged), "dragging over a label shows no merge tooltip")
    expect((W.state[MDTTooltip].lines or {})[1] == string.format(L["Merge into pull %d"], 1), "merge tooltip says "..tostring((W.state[MDTTooltip].lines or {})[1]))
    W.fireScript(dragged, "OnDragStop")
    W.settle(asyncIdle, 30)
    expect(not MDTTooltip:IsShown(), "the merge tooltip stays after the drop")
    expect(#pulls() == 2, "there are "..#pulls().." pulls after the merge")
    expect(clonesIn(pulls()[1]) == packSize + neighbourSize, "pull 1 holds "..clonesIn(pulls()[1]).." enemies after the merge")
    expect(label(1) and label(1):IsVisible() and label(2) == nil, "the labels did not follow the merge")
    expect(MDT:GetCurrentPull() == 1, "the merged pull is not selected")
  end)

  step("pull labels: clicking a label scrolls its pull's row into view in the pull list", function()
    local list = MDT:GetSidebarControl("pulls")
    local before = #pulls()
    for _ = 1, 30 do MDT:AddPull() end
    W.settle(asyncIdle, 30)
    local rows = #list.kitProps.items
    list:ScrollTo(rows, "nearest")
    expect(list:GetRow(1) == nil or not list:GetRow(1):IsVisible(), "setup: pull 1's row is still in view")
    click(label(1))
    local row = list:GetRow(1)
    expect(row and row:IsVisible() and row:GetTop() <= list:GetTop() + 0.5, "pull 1's row did not scroll into view")
    local offset = list.kitOffset
    click(label(1))
    expect(list.kitOffset == offset, "clicking a label whose row is in view scrolled the list")
    W.fireScript(label(1), "OnLeave")
    while #pulls() > before do MDT:DeletePull(#pulls()) end
    W.settle(asyncIdle, 30)
  end)

  step("pull labels: while an enemy is dragged, neither enemy nor pull cards open", function()
    local blips = visibleBlips()
    local dragged, other = blips[1], blips[2]
    local enemyCard = function() return MDT:GetEnemyInfoCard("hover") end
    local pullCard = MDT:GetPullLabelCard()
    W.hover(dragged)
    expect(enemyCard():IsShown(), "setup: hovering an enemy shows no card")
    W.fireScript(dragged, "OnDragStart")
    expect(not enemyCard():IsShown(), "the dragged enemy's card stays open")
    W.hover(other)
    expect(not enemyCard():IsShown(), "an enemy shows its card during the drag")
    W.fireScript(other, "OnLeave")
    W.hover(label(1))
    expect(not pullCard:IsShown() and not label(1).bright, "a pull label shows its card or lights up during the drag")
    W.fireScript(label(1), "OnLeave")
    local row = MDT:GetSidebarControl("pulls"):GetRow(1)
    W.cursorTo(row, row:GetRight() - 4, select(2, row:GetCenter()))
    W.fireScript(row, "OnEnter")
    expect(not pullCard:IsShown(), "a pull row shows the pull card during the drag")
    W.fireScript(row, "OnLeave")
    W.fireScript(dragged, "OnDragStop")
    W.settle(asyncIdle, 30)
    W.hover(label(1))
    expect(pullCard:IsShown(), "pull labels show no card after the drag")
    W.fireScript(label(1), "OnLeave")
    -- A drag that gets no OnDragStop, its enemy hidden or the button let go elsewhere, still ends.
    W.fireScript(dragged, "OnDragStart")
    expect(MDT:IsEnemyDragging(), "setup: the drag did not start")
    W.mouseDown = false
    expect(not MDT:IsEnemyDragging(), "the drag outlives the mouse button")
    dragged:SetScript("OnUpdate", nil)
    MDT.dungeonEnemyDragPreview_framePool:ReleaseAll()
    MDT:DrawAllHulls(nil, true)
    W.settle(asyncIdle, 30)
    -- A pull row only closes the cards it opened: not an enemy's hover card from the map.
    W.hover(other)
    expect(enemyCard():IsShown(), "setup: hovering an enemy shows no card")
    MDT:HidePullListCards(row)
    expect(enemyCard():IsShown(), "a pull row closed a map enemy's card it did not open")
    W.fireScript(other, "OnLeave")
    MDT:HideEnemyHoverCard()
  end)

  step("pull labels: restore the route", function()
    preset().value.pulls = saved.pulls
    preset().value.selection = saved.selection
    MDT:EnsureDBTables()
    MDT:SetSelectionToPull(math.min(saved.current or 1, #saved.pulls))
    MDT:UpdateMap()
    W.settle(asyncIdle, 30)
  end)
end
