local _, MDT = ...
local L = MDT.L
local UI = MDT.UI
local Theme, Fonts, Selection = UI.Theme, UI.Fonts, UI.Selection
local Layout, Model = MDT.PullLabelLayout, MDT.SidebarModel
local max, pairs, ipairs, unpack = math.max, pairs, ipairs, unpack

-- Every pull on the map has a label: its number on a swatch of its color, and the running forces total up to it. The
-- labels place themselves around the enemies (MDT.PullLabelLayout) each time the outlines redraw. Hovering a label
-- shows the pull's card and lights up its outline, a click selects the pull, a right-click opens the pull menu and
-- dragging it onto another pull merges the two.

-- Labels are the same size on every map, as the maps are, and grow with the map's scale and zoom like the enemies.
-- Enemy sizes differ a lot between dungeons, so they make a poor yardstick. Sizes below are fractions of the label's
-- height.
---Label height in map units at map scale 1 and label size 1 (100% on the dev mode size slider).
local HEIGHT = 12
---The pull number leads; the running total beside it is smaller.
local NUMBER_FONT, TOTAL_FONT = 0.72, 0.52
---Room beside the number, and around the total; a little more on the right, where the pill rounds off.
local NUMBER_PAD = 0.15
local TOTAL_PAD_LEFT, TOTAL_PAD_RIGHT = 0.15, 0.2
---A text line is centered with room for descenders, which digits lack, so they sit high; this share of the font size
---moves them down to the middle (measured in game).
local TEXT_DROP = 0.075
---The pull color edge around the total.
local EDGE = 0.07
local LEADER_THICKNESS = 0.09
---Free space the layout keeps around each label.
local LABEL_PAD = 0.12
local CIRCLE = "Interface\\AddOns\\MythicDungeonTools\\Textures\\Circle_White"
---An enemy portrait's radius on the map per unit of the enemy's scale (texture_Background in DungeonEnemies.lua).
local PORTRAIT_RADIUS = 10
local LABEL_LEVEL, RAISED_LEVEL = 100, 105

local CARD_WIDTH = 250
local UNKNOWN_SPELL_ICON = 134400
---Gap between a label and its card.
local CARD_OFFSET = 8
local CARD_PAD_X, CARD_PAD_Y = "md", "sm"

---@class MDT.PullLabel : Button
---@field pullIdx integer
---@field item MDT.SidebarPullItem
---@field pull table the pull's data in the route
---@field placement MDT.PullLabelPlacement?
---@field number FontString
---@field total FontString
---@field edgeLeft Texture the pill in the pull's color: a round end at each side and the middle between them
---@field edgeMiddle Texture
---@field edgeRight Texture
---@field fillMiddle Texture the dark part behind the total, its right end round
---@field fillRight Texture
---@field leader Line
---@field outline number[][]? the outline the label was placed for
---@field outlineKey string? the outline the label was placed for; another outline places it anew
---@field dragPull table? the pull being dragged, found again by identity at the drop
---@field dropPull table? the pull the drag would merge into
---@field dragEndedAt number? GetTime() of the last drag's end, so its mouse up is no click
---@field bright boolean? shown at full color: the current pull, or lit up
---@field placedHeight number? the height the label was placed at; another height places it anew

---Shown labels by pull index, and hidden ones kept for reuse.
---@type table<integer, MDT.PullLabel>, MDT.PullLabel[]
local labels, spareLabels = {}, {}
---Pulls lit up besides the current one: hovered, here or in the sidebar, or part of a drag.
local lit = {}
---The outlines the labels were placed by, from PullOutlines.
local outlines = {}
---@type MDT.PullLabel?
local dragging, hovered
local card

---Frames on the map the labels keep clear of besides the enemies: points of interest and notes.
local OBSTACLE_POOLS = { "MapLinkPinTemplate", "DeathReleasePinTemplate", "VignettePinTemplate", "QuestPinTemplate" }

---Colors a label bright, or faded towards the background.
---@param label MDT.PullLabel
---@param bright boolean
local function tone(label, bright)
  label.bright = bright
  -- Faded like the pull's outline (MDT:PullTone); opaque, so its overlapping parts do not show through each other.
  local color = label.item.color
  local r, g, b = MDT:PullTone(color[1], color[2], color[3], bright)
  for _, part in ipairs({ label.edgeLeft, label.edgeRight }) do part:SetVertexColor(r, g, b, 1) end
  label.edgeMiddle:SetColorTexture(r, g, b, 1)
  label.leader:SetColorTexture(r, g, b, 1)
  label.number:SetTextColor(unpack(Theme.Rgba("text.normal")))
  label.total:SetTextColor(unpack(Theme.Rgba(bright and "text.normal" or "text.muted")))
end

local function refreshTones()
  local current = MDT:GetCurrentPull()
  for index, label in pairs(labels) do tone(label, index == current or lit[index] == true) end
end

local function ensureCard()
  if card then return card end
  card = CreateFrame("Frame", nil, MDT.main_frame)
  card:SetClampedToScreen(true)
  UI.Overlay.SetStrata(card, "TOOLTIP")
  local background = card:CreateTexture(nil, "BACKGROUND")
  background:SetAllPoints()
  Theme.Bind(background, "bg.panel")
  UI.Pixel.Border(card, "border.strong")
  card.content = UI.Stack(card, { gap = "xs", onLayout = function(content)
    card:SetSize(content:GetWidth() + Theme.Space(CARD_PAD_X) * 2, content:GetHeight() + Theme.Space(CARD_PAD_Y) * 2)
  end })
  card.content:SetPoint("TOPLEFT", card, "TOPLEFT", Theme.Space(CARD_PAD_X), -Theme.Space(CARD_PAD_Y))
  card:Hide()
  return card
end

---Spell icons in the card are this tall, and a spell shows at most this many of them, one per enemy casting it.
local SPELL_ICON_SIZE = 20
local MAX_CASTER_ICONS = 8
---Caster portraits in the card are this big; enemies without a creature display show this one, as on the map.
local CASTER_PORTRAIT_SIZE = 30
local DEFAULT_DISPLAY_ID = 39490
local PORTRAIT_MASK = "Interface\\CharacterFrame\\TempPortraitAlphaMask"

---A spell name beside its icons needs at least this much room; with less it goes on the line below them.
local MIN_SPELL_NAME_WIDTH = 70
---Room the name leaves at the end of its line. The line's width is rounded to whole screen pixels, depending on where
---the card opens; a name filling the line exactly would then not fit beside its icons and drop below them.
local SPELL_NAME_SLACK = 2

---Width of text in the card's heading font.
---@param text string
---@return number
local function headingWidth(text)
  if not card.measure then
    card.measure = card:CreateFontString(nil, "ARTWORK")
    card.measure:Hide()
  end
  card.measure:SetFontObject(Fonts.Get("heading"))
  card.measure:SetText(text)
  return card.measure:GetUnboundedStringWidth()
end

---A spell to interrupt on a line of its own: its icon once per enemy casting it, then its name. Icons that do not fit
---the line wrap onto the next. The name wraps in the room left beside the icons, or goes below them when that is short.
---@param parent MDT.UI.Control
---@param spellId integer
---@param count integer
---@param width number the line's width
local function spellChip(parent, spellId, count, width)
  if not C_Spell.IsSpellDataCached(spellId) then C_Spell.RequestLoadSpellData(spellId) end
  -- Spells that only exist on beta or PTR have no info on live.
  local info = C_Spell.GetSpellInfo(spellId)
  local icon = info and C_Spell.GetSpellTexture(spellId) or UNKNOWN_SPELL_ICON
  local chip = UI.Row(parent, { gap = "xs", valign = "center", wrap = true })
  local shown = math.min(count, MAX_CASTER_ICONS)
  for _ = 1, shown do
    UI.Button(chip, {
      variant = "icon", icon = icon, iconCoords = UI.Icon.ZOOMED_COORDS, iconSize = SPELL_ICON_SIZE, iconColor = false,
      width = SPELL_ICON_SIZE, height = SPELL_ICON_SIZE,
    })
  end
  local gap = Theme.Space("xs")
  local used = shown * (SPELL_ICON_SIZE + gap)
  if count > shown then
    local more = "+"..(count - shown)
    UI.Text(chip, { id = "more", text = more, font = "heading", color = "text.secondary", wrap = false })
    used = used + headingWidth(more) + gap
  end
  -- Icons fill the line from the left; the name gets what is left of the line they end on.
  local left = width - used % (width + gap)
  UI.Text(chip, { id = "spellName", text = info and info.name or tostring(spellId), font = "heading",
    width = (left >= MIN_SPELL_NAME_WIDTH and left or width) - SPELL_NAME_SLACK })
end

---One caster: a place for its portrait, and beside it its name and the spells to interrupt it on.
---@param parent MDT.UI.Control
---@param id string
---@param caster MDT.PullCaster
---@param width number
---@return MDT.UI.Control portrait the place the caster's portrait goes
local function casterBlock(parent, id, caster, width)
  local row = UI.Row(parent, { id = id, gap = "sm", valign = "start" })
  local portrait = UI.Stack(row, { id = "portrait", width = CASTER_PORTRAIT_SIZE, height = CASTER_PORTRAIT_SIZE, autoHeight = false })
  local columnWidth = width - CASTER_PORTRAIT_SIZE - Theme.Space("sm")
  local column = UI.Stack(row, { id = "column", gap = "xs", width = columnWidth })
  -- Numbered like the enemy info card: High Evolutionist #3.
  local name = L[caster.name]
  if caster.cloneIdx then name = name.." #"..caster.cloneIdx end
  if caster.count > 1 then name = name.." "..UI.Color.Escape(Theme.Rgba("text.muted"), "x"..caster.count) end
  UI.Text(column, { id = "name", text = name, font = "heading", width = columnWidth })
  local spells = UI.Stack(column, { id = "spells", gap = "xs" })
  -- A shared entry has one spell, shown once per enemy; an enemy with several shows each once.
  for _, spellId in ipairs(caster.spellIds) do spellChip(spells, spellId, #caster.spellIds == 1 and caster.count or 1, columnWidth) end
  return portrait
end

---Puts the casters' portraits on their places in the card, in the ring they wear on the map.
---@param places MDT.UI.Control[]
---@param casters MDT.PullCaster[]
local function showCasterPortraits(places, casters)
  card.portraits = card.portraits or {}
  for i, place in ipairs(places) do
    local portrait = card.portraits[i]
    if not portrait then
      portrait = card:CreateTexture(nil, "ARTWORK")
      portrait.mask = card:CreateMaskTexture()
      portrait.mask:SetTexture(PORTRAIT_MASK, "CLAMPTOBLACKADDITIVE", "CLAMPTOBLACKADDITIVE")
      portrait.mask:SetAllPoints(portrait)
      portrait:AddMaskTexture(portrait.mask)
      portrait.ring = card:CreateTexture(nil, "OVERLAY")
      portrait.ring:SetTexture(MDT.EnemyRing.texture)
      portrait.ring:SetTexCoord(unpack(MDT.EnemyRing.coords))
      card.portraits[i] = portrait
    end
    local caster = casters[i]
    if caster.iconTexture then
      portrait:SetTexture(caster.iconTexture)
    else
      SetPortraitTextureFromCreatureDisplayID(portrait, caster.displayId or DEFAULT_DISPLAY_ID)
    end
    portrait:ClearAllPoints()
    portrait:SetPoint("CENTER", place, "CENTER", 0, 0)
    portrait:SetSize(CASTER_PORTRAIT_SIZE * MDT.EnemyRing.face, CASTER_PORTRAIT_SIZE * MDT.EnemyRing.face)
    portrait:Show()
    portrait.ring:ClearAllPoints()
    portrait.ring:SetAllPoints(place)
    portrait.ring:Show()
  end
  for i = #places + 1, #card.portraits do
    card.portraits[i]:Hide()
    card.portraits[i].ring:Hide()
  end
end

---Heads the spells to interrupt, as on the enemy card.
local INTERRUPT_ATLAS, INTERRUPT_ICON_SIZE = "icons_16x16_interrupt", 13

---The pull's card: its forces, running total and health, and its enemies that cast spells to interrupt.
---@param item MDT.SidebarPullItem
---@param pull table
local function fillCard(item, pull)
  local casters = Model.PullCasters(pull, MDT.dungeonEnemies[MDT:GetDB().currentDungeonIdx] or {})
  local places = {}
  local content = card.content
  content:ReleaseChildren()
  local contentWidth = CARD_WIDTH - Theme.Space(CARD_PAD_X) * 2
  content:SetWidth(contentWidth)
  content:Batch(function()
    UI.Text(content, { id = "title", text = UI.Color.Escape(item.color, string.format(L["Pull %d"], item.index)), font = "title" })
    local stats = UI.Stack(content, { id = "stats", gap = 0 })
    -- The pull's forces, then the running total: "Forces: 70 (9.48%) / 596 (80.76%)".
    local forces = MDT:FormatEnemyForces(item.forces, nil, false).." / "..MDT:FormatEnemyForces(item.cumulative, nil, false)
    UI.Text(stats, { id = "forces", text = L["Forces"]..": "..forces, font = "heading", color = "text.secondary" })
    -- The pull's efficiency score follows, colored like an enemy's on its card: forces against health, as one enemy.
    local health = string.format(L["%s HP"], MDT:FormatEnemyHealth(item.health))
    if item.baseHealth > 0 then
      health = health.." · "..L["Efficiency Score"]..": "..MDT:GetEfficiencyScoreString(item.forces, item.baseHealth)
    end
    UI.Text(stats, { id = "health", text = health, font = "heading", color = "text.secondary" })
    if #casters > 0 then
      local spells = UI.Stack(content, { id = "interrupts", gap = "sm" })
      local icon = CreateAtlasMarkup(INTERRUPT_ATLAS, INTERRUPT_ICON_SIZE, INTERRUPT_ICON_SIZE)
      UI.Text(spells, { id = "interruptsTitle", text = icon.." "..L["Interruptible"]..":", font = "heading", color = "text.secondary" })
      for i, caster in ipairs(casters) do places[i] = casterBlock(spells, "caster"..i, caster, contentWidth) end
    end
  end)
  -- The portraits are the card's own textures; they sit on the places the layout just made.
  showCasterPortraits(places, casters)
end

---Where the card may open around its label, in order of preference: card point, label point, and offset directions.
local CARD_SPOTS = {
  { "TOPLEFT", "BOTTOMRIGHT", 1, 0 }, { "BOTTOMLEFT", "TOPRIGHT", 1, 0 },
  { "TOPRIGHT", "BOTTOMLEFT", -1, 0 }, { "BOTTOMRIGHT", "TOPLEFT", -1, 0 },
  { "LEFT", "RIGHT", 1, 0 }, { "RIGHT", "LEFT", -1, 0 },
  { "TOP", "BOTTOM", 0, -1 }, { "BOTTOM", "TOP", 0, 1 },
}
---What covering things costs a spot, per square pixel: leaving the window, the pull's enemies, the pull's outline.
local COVER_WINDOW, COVER_ENEMY, COVER_OUTLINE = 10, 3, 0.3
---Points across the card, per side, sampled to see how much of the pull's outline it covers.
local OUTLINE_SAMPLES = 5

---The pull's enemies on the map as screen circles {x, y, radius}.
---@param pull table
---@return number[][]
local function pullEnemyCircles(pull)
  local circles = {}
  for _, blip in pairs(MDT:GetDungeonEnemyBlips()) do
    local clones = pull and blip:IsShown() and pull[blip.enemyIdx]
    if clones and tContains(clones, blip.cloneIdx) then
      local x, y = blip:GetCenter()
      local scale = blip:GetEffectiveScale()
      circles[#circles + 1] = { x * scale, y * scale, PORTRAIT_RADIUS * blip.normalScale * scale }
    end
  end
  return circles
end

local function overlap(l1, r1, b1, t1, l2, r2, b2, t2)
  return max(0, math.min(r1, r2) - max(l1, l2)) * max(0, math.min(t1, t2) - max(b1, b2))
end

---What a card at a screen rect costs: the window it leaves, the pull's enemies and outline it covers.
local function cardSpotCost(l, r, b, t, label, circles)
  local main = MDT.main_frame
  local scale = main:GetEffectiveScale()
  local ml, mr, mb, mt = main:GetLeft() * scale, main:GetRight() * scale, main:GetBottom() * scale, main:GetTop() * scale
  local area = (r - l) * (t - b)
  local value = COVER_WINDOW * (area - overlap(l, r, b, t, ml, mr, mb, mt))
  for _, circle in ipairs(circles) do
    local x, y, radius = circle[1], circle[2], circle[3]
    value = value + COVER_ENEMY * overlap(l, r, b, t, x - radius, x + radius, y - radius, y + radius)
  end
  local outline = label.outline
  if outline then
    local tile = MDT.main_frame.mapPanelTile1
    local tileScale = tile:GetEffectiveScale()
    local left, top = tile:GetLeft(), tile:GetTop()
    local inside = 0
    for i = 0, OUTLINE_SAMPLES - 1 do
      for j = 0, OUTLINE_SAMPLES - 1 do
        local x = l + (r - l) * (i + 0.5) / OUTLINE_SAMPLES
        local y = b + (t - b) * (j + 0.5) / OUTLINE_SAMPLES
        if Layout.Contains(outline, x / tileScale - left, y / tileScale - top) then inside = inside + 1 end
      end
    end
    value = value + COVER_OUTLINE * area * inside / OUTLINE_SAMPLES ^ 2
  end
  return value
end

---Beside the label, where it covers the least of its pull's enemies and outline while staying in the window.
local function placeCard(label)
  local circles = pullEnemyCircles(label.pull)
  local scale = card:GetEffectiveScale()
  local best, bestCost
  for _, spot in ipairs(CARD_SPOTS) do
    card:ClearAllPoints()
    card:SetPoint(spot[1], label, spot[2], spot[3] * CARD_OFFSET, spot[4] * CARD_OFFSET)
    local value = cardSpotCost(card:GetLeft() * scale, card:GetRight() * scale, card:GetBottom() * scale, card:GetTop() * scale,
      label, circles)
    if not bestCost or value < bestCost then best, bestCost = spot, value end
  end
  card:ClearAllPoints()
  card:SetPoint(best[1], label, best[2], best[3] * CARD_OFFSET, best[4] * CARD_OFFSET)
end

local function hideCard()
  if card then card:Hide() end
end

---@param label MDT.PullLabel
local function showCard(label)
  ensureCard()
  fillCard(label.item, label.pull)
  placeCard(label)
  card:Show()
end

---Enemies whose portraits show a spell icon, while their pull's label or pull row is hovered.
local spellPortraits = {}

---Shows the spell to interrupt in the portrait of every enemy of a pull that casts one; an enemy with several shows the
---one most cast in the pull. Nil puts the portraits back.
---@param pull table?
local function showSpellPortraits(pull)
  for blip in pairs(spellPortraits) do MDT:DungeonEnemies_SetSpellPortrait(blip, nil) end
  wipe(spellPortraits)
  if not pull then return end
  local interrupts = Model.PullInterrupts(pull, MDT.dungeonEnemies[MDT:GetDB().currentDungeonIdx] or {})
  if #interrupts == 0 then return end
  for _, blip in pairs(MDT:GetDungeonEnemyBlips()) do
    local clones = blip:IsShown() and pull[blip.enemyIdx]
    local spells = blip.data and blip.data.spells
    if clones and spells and tContains(clones, blip.cloneIdx) then
      for _, interrupt in ipairs(interrupts) do
        local spell = spells[interrupt.spellId]
        if spell and spell.interruptible then
          MDT:DungeonEnemies_SetSpellPortrait(blip, C_Spell.GetSpellTexture(interrupt.spellId) or UNKNOWN_SPELL_ICON)
          spellPortraits[blip] = true
          break
        end
      end
    end
  end
end

---@param label MDT.PullLabel
local function onEnter(label)
  -- Dragging this label, or an enemy across it, shows nothing.
  if dragging or MDT:IsEnemyDragging() then return end
  hovered = label
  MDT:HideEnemyHoverCard()
  showSpellPortraits(label.pull)
  label:SetFrameLevel(RAISED_LEVEL)
  MDT:PullClickAreaOnEnter(label.pullIdx)
  MDT:PreviewSidebarForces(label.item.cumulative)
  showCard(label)
end

---@param label MDT.PullLabel
local function onLeave(label)
  if dragging or hovered ~= label then return end
  hovered = nil
  showSpellPortraits(nil)
  label:SetFrameLevel(LABEL_LEVEL)
  hideCard()
  MDT:PreviewSidebarForces(nil)
  MDT:PullClickAreaOnLeave()
end

---@param label MDT.PullLabel
local function onClick(label, button)
  if label.dragEndedAt == GetTime() then return end
  local index = label.pullIdx
  hideCard()
  if button == "RightButton" then
    if not Selection.Contains(MDT:GetSelection(), index) then MDT:SetSelectionToPull(index) end
    MDT:ScrollSidebarToPull(index)
    MDT:PullClickAreaOnEnter(index)
    MDT:OpenPullMenu(label, index, string.format(L["Pull %d"], index))
    return
  end
  MDT:SetSelectionToPull(index)
  MDT:ScrollSidebarToPull(index)
  MDT:PullClickAreaOnEnter(index)
end

---The pull a label dropped at x, y merges into: the label under the cursor, else the smallest outline holding it.
---@param label MDT.PullLabel
---@return integer?
local function dropTargetAt(label, x, y)
  for index, other in pairs(labels) do
    local placement = other.placement
    if other ~= label and placement and math.abs(x - placement.x) <= other:GetWidth() / 2
        and math.abs(y - placement.y) <= other:GetHeight() / 2 then
      return index
    end
  end
  local best, bestArea
  for index, outline in pairs(outlines) do
    if index ~= label.pullIdx and labels[index] and Layout.Contains(outline, x, y) then
      local left, right, bottom, top = math.huge, -math.huge, math.huge, -math.huge
      for _, p in ipairs(outline) do
        left, right, bottom, top = math.min(left, p[1]), max(right, p[1]), math.min(bottom, p[2]), max(top, p[2])
      end
      local area = (right - left) * (top - bottom)
      if not bestArea or area < bestArea then best, bestArea = index, area end
    end
  end
  return best
end

---@param label MDT.PullLabel
local function followCursor(label)
  local x, y = MDT:GetCursorPosition()
  label:ClearAllPoints()
  label:SetPoint("CENTER", MDT.main_frame.mapPanelTile1, "TOPLEFT", x, y)
  local target = dropTargetAt(label, x, y)
  local targetPull = target and MDT:GetPulls()[target]
  if targetPull == label.dropPull then return end
  label.dropPull = targetPull
  MDT:PullClickAreaOnLeave()
  MDT:PullClickAreaOnEnter(label.pullIdx)
  if target then
    MDT:PullClickAreaOnEnter(target)
    UI.Tooltip.Show(label, string.format(L["Merge into pull %d"], target))
  else
    UI.Tooltip.Hide(label)
  end
end

---Puts a label where the layout placed it, with its leader line when it has one.
---@param label MDT.PullLabel
local function settle(label)
  local placement = label.placement
  if not placement then return end
  local tile = MDT.main_frame.mapPanelTile1
  -- Offsets count in the label's own scale, which the size slider changes while it moves.
  local scale = label:GetScale()
  label:ClearAllPoints()
  label:SetPoint("CENTER", tile, "TOPLEFT", placement.x / scale, placement.y / scale)
  local leader = label.leader
  if placement.leaderX then
    leader:SetStartPoint("TOPLEFT", tile, placement.x / scale, placement.y / scale)
    leader:SetEndPoint("TOPLEFT", tile, placement.leaderX / scale, placement.leaderY / scale)
    leader:Show()
  else
    leader:Hide()
  end
end

---@param label MDT.PullLabel
local function onDragStart(label)
  hovered = nil
  showSpellPortraits(nil)
  dragging = label
  MDT:HideEnemyHoverCard()
  hideCard()
  MDT:PreviewSidebarForces(nil)
  label.leader:Hide()
  label:SetFrameLevel(RAISED_LEVEL)
  label.dragPull, label.dropPull = MDT:GetPulls()[label.pullIdx], nil
  UI.Script(label, "OnUpdate", followCursor)
end

---Ends a label's drag without merging and returns the pulls it was for; nothing when the label was not dragging.
---@param label MDT.PullLabel
---@return table? dragPull, table? dropPull
local function endDrag(label)
  label:SetScript("OnUpdate", nil)
  local dragPull, dropPull = label.dragPull, label.dropPull
  label.dragPull, label.dropPull = nil, nil
  if dragging ~= label then return end
  dragging = nil
  UI.Tooltip.Hide(label)
  label:SetFrameLevel(LABEL_LEVEL)
  MDT:PullClickAreaOnLeave()
  return dragPull, dropPull
end

---@param pull table?
---@return integer?
local function indexOfPull(pull)
  for index, candidate in ipairs(MDT:GetPulls()) do
    if candidate == pull then return index end
  end
end

---@param label MDT.PullLabel
local function onDragStop(label)
  label.dragEndedAt = GetTime()
  local dragPull, dropPull = endDrag(label)
  -- The pulls may change during a drag, from a live session for one; the drop merges what it showed or nothing.
  local from, into = indexOfPull(dragPull), indexOfPull(dropPull)
  if from and into and from ~= into then
    MDT:RunPullAction("merge", { from }, into)
  else
    settle(label)
  end
end

---@return MDT.PullLabel
local function createLabel()
  local label = CreateFrame("Button", nil, MDT.main_frame.mapPanelFrame) --[[@as MDT.PullLabel]]
  label:SetFrameStrata("HIGH")
  label:SetFrameLevel(LABEL_LEVEL)
  label:RegisterForClicks("LeftButtonUp", "RightButtonUp")
  label:RegisterForDrag("LeftButton")
  -- A pill in the pull's color, with a dark pill over all but the number's swatch and a thin edge.
  label.edgeLeft = label:CreateTexture(nil, "BACKGROUND", nil, 1)
  label.edgeMiddle = label:CreateTexture(nil, "BACKGROUND", nil, 1)
  label.edgeRight = label:CreateTexture(nil, "BACKGROUND", nil, 1)
  label.fillMiddle = label:CreateTexture(nil, "BORDER")
  label.fillRight = label:CreateTexture(nil, "BORDER")
  for _, round in ipairs({ label.edgeLeft, label.edgeRight, label.fillRight }) do round:SetTexture(CIRCLE) end
  label.number = label:CreateFontString(nil, "OVERLAY")
  label.total = label:CreateFontString(nil, "OVERLAY")
  -- Under the label's own textures, so it seems to leave from the label's edge.
  label.leader = label:CreateLine(nil, "BACKGROUND", nil, -8)
  UI.Script(label, "OnEnter", onEnter)
  UI.Script(label, "OnLeave", onLeave)
  UI.Script(label, "OnClick", onClick)
  UI.Script(label, "OnDragStart", onDragStart)
  UI.Script(label, "OnDragStop", onDragStop)
  -- The window can close mid-drag or mid-hover, and then no OnDragStop or OnLeave comes; a hidden label ends both, so it
  -- does not hold back the enemy cards.
  UI.Script(label, "OnHide", function()
    endDrag(label)
    if hovered == label then onLeave(label) end
  end)
  return label
end

---Sizes and colors a label for its pull.
---@param label MDT.PullLabel
---@param item MDT.SidebarPullItem
---@param height number the label's height in map units
local function paint(label, item, height)
  label.pullIdx, label.item = item.index, item
  -- Back from the size slider's preview: at its new size, on its spot until the layout places it again.
  if label:GetScale() ~= 1 then
    label:SetScale(1)
    if label ~= dragging then settle(label) end
  end
  -- Outlined, so it reads on light and dark pull colors alike.
  Fonts.Apply(label.number, NUMBER_FONT * height, "OUTLINE")
  Fonts.Apply(label.total, TOTAL_FONT * height)
  label.number:SetText(tostring(item.index))
  -- The running total as the pull rows show it: "45.7%", or the count with Use forces count on.
  label.total:SetText(item.cumulativeText)
  local swatch = max(height, label.number:GetUnboundedStringWidth() + NUMBER_PAD * 2 * height)
  local totalText = label.total:GetUnboundedStringWidth()
  local width = swatch + totalText + (TOTAL_PAD_LEFT + TOTAL_PAD_RIGHT) * height
  local edge = EDGE * height
  label:SetSize(width, height)

  label.edgeLeft:SetSize(height, height)
  label.edgeLeft:SetPoint("LEFT", label, "LEFT", 0, 0)
  label.edgeRight:SetSize(height, height)
  label.edgeRight:SetPoint("RIGHT", label, "RIGHT", 0, 0)
  label.edgeMiddle:ClearAllPoints()
  label.edgeMiddle:SetPoint("TOPLEFT", label, "TOPLEFT", height / 2, 0)
  label.edgeMiddle:SetPoint("BOTTOMRIGHT", label, "BOTTOMRIGHT", -height / 2, 0)

  local fill = Theme.Rgba("bg.panel")
  label.fillRight:SetSize(height - edge * 2, height - edge * 2)
  label.fillRight:SetPoint("CENTER", label, "RIGHT", -height / 2, 0)
  label.fillRight:SetVertexColor(fill[1], fill[2], fill[3], 1)
  label.fillMiddle:ClearAllPoints()
  label.fillMiddle:SetPoint("TOPLEFT", label, "TOPLEFT", swatch, -edge)
  label.fillMiddle:SetPoint("BOTTOMRIGHT", label, "BOTTOMRIGHT", -height / 2, edge)
  label.fillMiddle:SetColorTexture(fill[1], fill[2], fill[3], 1)

  label.number:ClearAllPoints()
  label.number:SetPoint("CENTER", label, "LEFT", swatch / 2, -TEXT_DROP * NUMBER_FONT * height)
  label.total:ClearAllPoints()
  label.total:SetPoint("CENTER", label, "LEFT", swatch + TOTAL_PAD_LEFT * height + totalText / 2, -TEXT_DROP * TOTAL_FONT * height)
  label.leader:SetThickness(LEADER_THICKNESS * height)
  tone(label, item.index == MDT:GetCurrentPull() or lit[item.index] == true)
end

---@param index integer
local function releaseLabel(index)
  local label = labels[index]
  labels[index] = nil
  if hovered == label then onLeave(label) end
  label:Hide()
  endDrag(label)
  label:SetFrameLevel(LABEL_LEVEL)
  label.placement, label.outline, label.outlineKey, label.placedHeight = nil, nil, nil, nil
  spareLabels[#spareLabels + 1] = label
end

---A label for an outline it was not placed for searches anew instead of keeping its spot.
---@param outline number[][]
---@return string
local function outlineKey(outline)
  local x, y = Layout.AreaCenter(outline)
  return ("%d:%.1f:%.1f"):format(#outline, x, y)
end

---Points of interest and notes as {x, y, radius}; they sit on the map tile like the enemies.
---@return number[][]
local function mapPins()
  local into = {}
  local tile = MDT.main_frame.mapPanelTile1
  for _, template in ipairs(OBSTACLE_POOLS) do
    local pool = MDT.GetFramePool(template)
    for _, frame in ipairs(pool and pool.active or {}) do
      local _, relativeTo, _, x, y = frame:GetPoint()
      if frame:IsShown() and relativeTo == tile and x then
        into[#into + 1] = { x, y, max(frame:GetWidth(), frame:GetHeight()) / 2 }
      end
    end
  end
  return into
end

---With a drawing tool picked the map takes every click, so strokes can start on a label.
---@param label MDT.PullLabel
local function setInteractive(label)
  label:EnableMouse(MDT:GetCurrentToolbarTool() == nil)
end

---Label height in map units for a label size; by default the size slider's in dev mode, else 1. 0 hides the labels.
---@param size number?
---@return number
local function labelHeight(size)
  local db = MDT:GetDB()
  return HEIGHT * MDT:GetScale() * (size or db.devMode and db.devPullLabelSize or 1)
end

---Labels every pull that has an outline and places the labels around the enemies, in pull order.
---@param pulls table[] the pulls the outlines were drawn for
---@param pullOutlines table<integer, number[][]> outlines by pull index
function MDT:PlacePullLabels(pulls, pullOutlines)
  local main = MDT.main_frame
  if not main then return end
  outlines = pullOutlines
  local height = labelHeight()
  local items = Model.PullItems(pulls, MDT:SidebarContext())
  for index in pairs(labels) do
    if height <= 0 or not (items[index] and outlines[index]) then releaseLabel(index) end
  end
  if height <= 0 then
    hideCard()
    return
  end
  local enemies = {}
  for _, blip in pairs(MDT:GetDungeonEnemyBlips()) do
    if blip:IsShown() then
      local _, _, _, x, y = blip:GetPoint()
      enemies[#enemies + 1] = { x, y, PORTRAIT_RADIUS * blip.normalScale }
    end
  end
  local requests = {}
  for index, item in ipairs(items) do
    local outline = outlines[index]
    if outline then
      local label = labels[index] or table.remove(spareLabels) or createLabel()
      labels[index] = label
      label.pull = pulls[index]
      paint(label, item, height)
      setInteractive(label)
      local key = outlineKey(outline)
      local placement = label.placement
      requests[#requests + 1] = {
        key = index, outline = outline, outlineKey = key, width = label:GetWidth(), height = label:GetHeight(),
        previous = placement and label.outlineKey == key and label.placedHeight == height and placement.cost < math.huge
          and { x = placement.x, y = placement.y, cost = placement.cost } or nil,
      }
    end
  end
  local map = main.mapPanelFrame
  local placements = Layout.Place(requests, enemies, {
    pins = mapPins(),
    pad = LABEL_PAD * height,
    bounds = { left = 0, right = map:GetWidth(), top = 0, bottom = -map:GetHeight() },
    -- Inside DrawAllHulls' task, crowded maps spread the search over frames.
    pause = coroutine.running() and coroutine.yield or nil,
  })
  local placed = {}
  for _, request in ipairs(requests) do placed[request.key] = request end
  for index, placement in pairs(placements) do
    -- The map may have cleared its labels while the search yielded. A search cancelled midway leaves the label with the
    -- spot and outline it had, so the next one does not keep an old spot for a new outline.
    local label = labels[index]
    if label then
      label.placement, label.outline, label.outlineKey = placement, placed[index].outline, placed[index].outlineKey
      label.placedHeight = height
      if label ~= dragging then settle(label) end
      label:Show()
    end
  end
  refreshTones()
  -- A redraw can change the hovered pull's forces and health.
  if hovered and card and card:IsShown() then showCard(hovered) end
end

---Shows the labels at another size while the size slider moves, each grown or shrunk around its center; the next
---placement lays them out at the saved size.
---@param size number
function MDT:PreviewPullLabelSize(size)
  local height = labelHeight(size)
  for _, label in pairs(labels) do
    if label.placement and label.placedHeight then
      local scale = height / label.placedHeight
      if scale > 0 then
        label:SetScale(scale)
        settle(label)
        label:Show()
      else
        label:Hide()
      end
    end
  end
end

---Hides every label, as the map clears its outlines.
function MDT:HidePullLabels()
  for index in pairs(labels) do releaseLabel(index) end
  outlines = {}
  hideCard()
end

---The pull row the pull card shows beside, while it does.
local cardRow

---Shows the pull card beside a hovered pull row, with the spells to interrupt in its casters' portraits on the map.
---@param row table
---@param item MDT.SidebarPullItem
function MDT:ShowPullCardBesideRow(row, item)
  local pull = MDT:GetPulls()[item.index]
  if not pull then return end
  ensureCard()
  fillCard(item, pull)
  MDT:PlaceBesidePullRow(card, row)
  card:Show()
  cardRow = row
  showSpellPortraits(pull)
end

---Hides the pull card a pull row showed, and puts the portraits back.
---@param row table? only when it shows beside this row; any row by default
function MDT:HidePullCardBesideRow(row)
  if hovered or dragging or not cardRow or (row and row ~= cardRow) then return end
  cardRow = nil
  hideCard()
  showSpellPortraits(nil)
end

---Hides the cards the pull list shows: the pull's, and the enemy's of a portrait in it.
---@param row table? only the cards this row opened; every card by default
function MDT:HidePullListCards(row)
  MDT:HidePullCardBesideRow(row)
  local owner = MDT:GetEnemyHoverCardOwner()
  if owner and (not row or tContains(row.kitPortraits, owner)) then MDT:HideEnemyHoverCard() end
end

---Whether the cursor is on a pull label, or drags one; the enemy hover card stays hidden meanwhile.
---@return boolean
function MDT:IsPullLabelHovered()
  return hovered ~= nil or dragging ~= nil
end

---Labels let clicks through to the map while a drawing tool is picked.
function MDT:UpdatePullLabelInteractivity()
  for _, label in pairs(labels) do setInteractive(label) end
end

---Lights a pull's label up, as its outline lights up; nil lights all but the current pull's down again.
---@param pullIdx integer?
function MDT:HighlightPullLabel(pullIdx)
  if pullIdx then lit[pullIdx] = true else wipe(lit) end
  refreshTones()
end

---Test access to the label of a pull and the pull card.
---@param pullIdx integer
---@return MDT.PullLabel?
function MDT:GetPullLabel(pullIdx)
  return labels[pullIdx]
end

---@return table?
function MDT:GetPullLabelCard()
  return card
end
