local _, MDT = ...
local L = MDT.L
local UI = MDT.UI
local Theme, Fonts = UI.Theme, UI.Fonts
local db

-- Enemy info lives in two cards. Hovering an enemy shows the compact hover card beside it. It goes the moment the cursor
-- leaves the enemy, unless Ctrl is held, which keeps it open and on its enemy while the cursor passes over others, so
-- its spells can be hovered and linked. Pinning (its pin button or
-- the right-click menu) opens an expanded pinned card in the same spot, which stays until closed while the map keeps
-- working. Any number of enemies can be pinned at once; each card drags by its title, anywhere on the map.

local DEFAULT_DISPLAY_ID = 39490
local UNKNOWN_SPELL_ICON = 134400
local SPELL_ROW_HEIGHT = 22
local SPELL_ICON_SIZE = 18
local STATUS_ICON_SIZE = 14
local TOOLTIP_ICON_SIZE = 12
local CHARACTERISTIC_ICON_SIZE = 16
---Gap between an enemy and its card.
local CARD_OFFSET = 30
local MODEL_ROTATION_SPEED = math.pi / 4
---Pinned card frame levels: the back card's, the gap between cards, which leaves room for a card's own frames, and how
---many front cards stack in order below the dialogs' level 100.
local PINNED_LEVEL_BASE, PINNED_LEVEL_STEP, PINNED_STACKED = 5, 15, 6

---Pin and close buttons in the header; UI.CloseButton is this size.
local HEADER_BUTTON_SIZE = 24
---Card padding: full at the sides, trimmed at top and bottom, where the header button already leaves room.
local PAD_X, PAD_Y = "md", "sm"

local LAYOUT = {
  hover = {
    width = 250, modelWidth = 56, modelHeight = 64, spells = 3, strata = "TOOLTIP",
    font = { title = "titleCompact", body = "bodyCompact", small = "smallCompact" },
  },
  pinned = {
    width = 320, modelWidth = 116, modelHeight = 135, spells = 10, strata = "DIALOG",
    font = { title = "title", body = "body", small = "small" },
  },
}

---Icons shown only for enemies that are stealthed or detect stealth. 166057 is spells/eyeblue.blp, the eye the game
---draws above NPCs with stealth detection.
local STEALTH_FLAGS = {
  { key = "stealth", label = "Enemy Info NPC Stealth", icon = "Interface\\ICONS\\ability_stealth", coords = UI.Icon.ZOOMED_COORDS },
  { key = "stealthDetect", label = "Enemy Info NPC Stealth Detect", icon = 166057 },
}

local CHARACTERISTICS = {
  { key = "Stun", icon = "Interface\\ICONS\\spell_frost_stun" },
  { key = "Sap", icon = "Interface\\ICONS\\ability_sap" },
  { key = "Incapacitate", icon = "Interface\\ICONS\\ability_monk_paralysis" },
  { key = "Repentance", icon = "Interface\\ICONS\\spell_holy_prayerofhealing" },
  { key = "Disorient", icon = "Interface\\ICONS\\spell_shadow_mindsteal" },
  { key = "Banish", icon = "Interface\\ICONS\\spell_shadow_cripple" },
  { key = "Fear", icon = "Interface\\ICONS\\spell_shadow_possession" },
  { key = "Root", icon = "Interface\\ICONS\\spell_frost_frostnova" },
  { key = "Polymorph", icon = "Interface\\ICONS\\spell_nature_polymorph" },
  { key = "Shackle Undead", icon = "Interface\\ICONS\\spell_nature_slow" },
  { key = "Mind Control", icon = "Interface\\ICONS\\spell_shadow_shadowworddominate" },
  { key = "Grip", icon = "Interface\\ICONS\\spell_deathknight_strangulate" },
  { key = "Knock", icon = "Interface\\ICONS\\ability_druid_typhoon" },
  { key = "Silence", icon = "Interface\\ICONS\\ability_priest_silence" },
  { key = "Taunt", icon = "Interface\\ICONS\\spell_nature_reincarnation" },
  { key = "Control Undead", icon = "Interface\\ICONS\\inv_misc_bone_skull_01" },
  { key = "Enslave Demon", icon = "Interface\\ICONS\\spell_shadow_enslavedemon" },
  { key = "Slow", icon = "Interface\\ICONS\\ability_rogue_trip" },
  { key = "Imprison", icon = "Interface\\ICONS\\ability_demonhunter_imprison" },
  { key = "Sleep Walk", icon = "Interface\\ICONS\\ability_xavius_dreamsimulacrum" },
  { key = "Scare Beast", icon = "Interface\\ICONS\\ability_druid_cower" },
  { key = "Hibernate", icon = "Interface\\ICONS\\spell_nature_sleep" },
  { key = "Turn Evil", icon = "Interface\\ICONS\\ability_paladin_turnevil" },
  { key = "Mind Soothe", icon = "Interface\\ICONS\\spell_holy_mindsooth" },
}

---Spell flags in display order. devKey toggles the flag on the hovered spell row in dev mode.
local SPELL_STATUSES = {
  { key = "interruptible", atlas = "icons_16x16_interrupt", label = L["Interruptible"], devKey = "I" },
  { key = "magic", atlas = "icons_16x16_magic", label = L["Magic"], devKey = "M" },
  { key = "poison", atlas = "icons_16x16_poison", label = L["Poison"], devKey = "P" },
  { key = "disease", atlas = "icons_16x16_disease", label = L["Disease"], devKey = "D" },
  { key = "curse", atlas = "icons_16x16_curse", label = L["Curse"], devKey = "C" },
  { key = "bleed", atlas = "icons_16x16_bleed", label = L["Bleed"], devKey = "B" },
  { key = "enrage", atlas = "icons_16x16_enrage", label = L["Enrage"], devKey = "E" },
}
local STATUS_BY_DEV_KEY = {}
for _, status in ipairs(SPELL_STATUSES) do STATUS_BY_DEV_KEY[status.devKey] = status end

local DEV_DELETE_KEY, DEV_PRINT_KEY = "R", "S"
local DEV_HELP
do
  local lines = { DEV_DELETE_KEY..": Delete", DEV_PRINT_KEY..": Print SpellId" }
  for _, status in ipairs(SPELL_STATUSES) do lines[#lines + 1] = status.devKey..": Toggle "..status.label end
  DEV_HELP = table.concat(lines, "\n")
end

---@class MDT.EnemyInfoSpellItem : MDT.UI.ListItem
---@field spellId number
---@field name string
---@field icon string|number
---@field statuses table[] entries of SPELL_STATUSES set on the spell
---@field font MDT.UI.FontRole the spell name's font
---@field more integer? on the hover card's last row: how many spells it leaves out
---@field moreFont MDT.UI.FontRole?

---@class MDT.EnemyCard : Frame
---@field kind "hover"|"pinned"
---@field content MDT.UI.Control
---@field model table
---@field modelHost MDT.UI.Control
---@field modelData table? the enemy data the model shows
---@field blip table? the enemy blip the card shows
---@field enemyIdx integer?
---@field cloneIdx integer?
---@field spells MDT.EnemyInfoSpellItem[]?
---@field dragHandle table? the pinned card's title, which drags it
---@field dragOffsetX number? where the cursor holds the card while it drags, from its top left
---@field dragOffsetY number?
---@field escape table? closes the pinned card on Escape

---@type MDT.EnemyCard?
local hoverCard
---Open pinned cards, the front one last, and closed ones kept for reuse.
---@type MDT.EnemyCard[], MDT.EnemyCard[]
local pinnedCards, sparePinnedCards = {}, {}
---The enemy the hover card belongs to, and the last enemy the cursor entered while Ctrl kept the card on another one.
local hoverBlip, heldOverBlip
---Where the hover card last showed and for which enemy, so pinning from the right-click menu opens in the same spot.
local lastSpot

---@param spells table? the enemy's spells by spell id
---@param font MDT.UI.FontRole
---@return MDT.EnemyInfoSpellItem[]
local function spellItems(spells, font)
  local spellIds = {}
  for spellId in pairs(spells or {}) do spellIds[#spellIds + 1] = spellId end
  table.sort(spellIds)
  local items = {}
  for _, spellId in ipairs(spellIds) do
    if not C_Spell.IsSpellDataCached(spellId) then C_Spell.RequestLoadSpellData(spellId) end
    -- Spells that only exist on beta or PTR have no info on live.
    local info = C_Spell.GetSpellInfo(spellId)
    local statuses, flags = {}, {}
    for _, status in ipairs(SPELL_STATUSES) do
      if spells[spellId][status.key] then
        statuses[#statuses + 1] = status
        flags[#flags + 1] = status.devKey
      end
    end
    local name = info and info.name or tostring(spellId)
    items[#items + 1] = {
      kind = "spell", key = spellId, sig = name.."|"..table.concat(flags),
      spellId = spellId, name = name, statuses = statuses, font = font,
      icon = info and C_Spell.GetSpellTexture(spellId) or UNKNOWN_SPELL_ICON,
    }
  end
  return items
end

---The map reuses its enemy frames whenever it redraws, so a pinned card knows its enemy by enemy and clone index.
---@param blip table
---@return MDT.EnemyCard?
local function pinnedCardFor(blip)
  for _, card in ipairs(pinnedCards) do
    if card.enemyIdx == blip.enemyIdx and card.cloneIdx == blip.cloneIdx then return card end
  end
end

---What a pinned card's enemy clone fills from: its frame on the map, or the same fields from the dungeon data while
---the clone is on another floor. nil once the clone is gone.
---@param card MDT.EnemyCard
---@return table?
local function pinnedEnemyBlip(card)
  local data = MDT.dungeonEnemies[db.currentDungeonIdx][card.enemyIdx]
  local clone = data and data.clones[card.cloneIdx]
  if not clone then return nil end
  local blip = MDT:GetBlip(card.enemyIdx, card.cloneIdx)
  if blip and blip.data == data then return blip end
  return { data = data, clone = clone, enemyIdx = card.enemyIdx, cloneIdx = card.cloneIdx }
end

---@param card MDT.EnemyCard
local function cardEnemy(card)
  return card.enemyIdx and MDT.dungeonEnemies[db.currentDungeonIdx][card.enemyIdx] or nil
end

---The enemy of the front pinned card.
function MDT:GetEnemyInfoEnemyIdx()
  local front = pinnedCards[#pinnedCards]
  return front and front.enemyIdx or nil
end

local function showSpellTooltip(row, item)
  MDTTooltip:SetOwner(row, "ANCHOR_BOTTOMLEFT", 0, row:GetHeight())
  MDTTooltip:ClearLines()
  MDTTooltip:SetSpellByID(item.spellId)
  for _, status in ipairs(item.statuses) do
    if CreateAtlasMarkup then
      MDTTooltip:AddLine(CreateAtlasMarkup(status.atlas, TOOLTIP_ICON_SIZE, TOOLTIP_ICON_SIZE)..status.label)
    else
      MDTTooltip:AddLine(status.label)
    end
  end
  MDTTooltip:Show()
end

local function onDevKey(row, key)
  if not db.devMode or not row.card then return end
  local enemy = cardEnemy(row.card)
  local spell = enemy and enemy.spells and enemy.spells[row.spellId]
  if not spell then return end
  if key == DEV_PRINT_KEY then
    print(row.spellId)
    return
  end
  if key == DEV_DELETE_KEY then
    enemy.spells[row.spellId] = nil
  elseif STATUS_BY_DEV_KEY[key] then
    local flag = STATUS_BY_DEV_KEY[key].key
    spell[flag] = not spell[flag]
  else
    return
  end
  MDT:UpdateEnemyInfoFrame()
end

---One spell: its icon, its name and its status icons on the right. The hover card's last row also counts the spells
---it leaves out, right after the name.
local SpellRow = {}

function SpellRow:OnCreate()
  self.kitIcon = self:CreateTexture(nil, "ARTWORK")
  self.kitIcon:SetSize(SPELL_ICON_SIZE, SPELL_ICON_SIZE)
  self.kitIcon:SetPoint("LEFT", self, "LEFT", 0, 0)
  self.kitName = self:CreateFontString(nil, "ARTWORK")
  self.kitName:SetJustifyH("LEFT")
  self.kitName:SetWordWrap(false)
  self.kitName:SetPoint("LEFT", self.kitIcon, "RIGHT", Theme.Space("sm"), 0)
  Theme.Bind(self.kitName, "text.normal")
  self.kitMore = self:CreateFontString(nil, "ARTWORK")
  self.kitMore:SetWordWrap(false)
  self.kitMore:Hide()
  Theme.Bind(self.kitMore, "text.muted")
  self.kitStatusIcons = {}
  for i, status in ipairs(SPELL_STATUSES) do
    local icon = self:CreateTexture(nil, "OVERLAY")
    icon:SetSize(STATUS_ICON_SIZE, STATUS_ICON_SIZE)
    icon:SetAtlas(status.atlas)
    icon:Hide()
    self.kitStatusIcons[i] = icon
  end
  UI.Script(self, "OnKeyDown", onDevKey)
  UI.HookScript(self, "OnSizeChanged", function(row) row:kitLayoutName() end)
  self:EnableKeyboard(false)
end

---The name runs up to the status icons. With a "+N more", the name gives up only the room the count needs, and the
---count follows it.
function SpellRow:kitLayoutName()
  local name, more, gap = self.kitName, self.kitMore, Theme.Space("xs")
  name:ClearAllPoints()
  name:SetPoint("LEFT", self.kitIcon, "RIGHT", Theme.Space("sm"), 0)
  if not more:IsShown() then
    local nameEnd = self.kitNameEnd
    name:SetPoint("RIGHT", nameEnd or self, nameEnd and "LEFT" or "RIGHT", -gap, 0)
    return
  end
  local moreWidth = math.ceil(more:GetUnboundedStringWidth())
  more:SetWidth(moreWidth)
  local room = self:GetWidth() - SPELL_ICON_SIZE - Theme.Space("sm") - self.kitStatusWidth - moreWidth - Theme.Space("sm")
  local nameWidth = math.ceil(name:GetUnboundedStringWidth())
  -- Rows are bound before the list places them; OnSizeChanged lays the name out again once the row has a width.
  -- At least 1: a width of 0 lets the client size the name to its text.
  if self:GetWidth() > 0 then nameWidth = math.max(1, math.min(nameWidth, room)) end
  name:SetWidth(nameWidth)
  more:ClearAllPoints()
  more:SetPoint("LEFT", name, "RIGHT", Theme.Space("sm"), 0)
end

---@param item MDT.EnemyInfoSpellItem
function SpellRow:Bind(item)
  self.spellId = item.spellId
  UI.Icon.SetZoomed(self.kitIcon, item.icon)
  self.kitName:SetFontObject(Fonts.Get(item.font))
  self.kitName:SetText(item.name)
  for _, icon in ipairs(self.kitStatusIcons) do icon:Hide() end
  local gap = Theme.Space("xs")
  local previous
  for i = #SPELL_STATUSES, 1, -1 do
    for _, status in ipairs(item.statuses) do
      if status == SPELL_STATUSES[i] then
        local icon = self.kitStatusIcons[i]
        icon:ClearAllPoints()
        if previous then
          icon:SetPoint("RIGHT", previous, "LEFT", -gap, 0)
        else
          icon:SetPoint("RIGHT", self, "RIGHT", -gap, 0)
        end
        icon:Show()
        previous = icon
      end
    end
  end
  self.kitNameEnd = previous
  self.kitStatusWidth = gap + #item.statuses * (STATUS_ICON_SIZE + gap)
  self.kitMore:SetShown(item.more ~= nil)
  if item.more then
    self.kitMore:SetFontObject(Fonts.Get(item.moreFont))
    self.kitMore:SetText(string.format(L["+%d more"], item.more))
  end
  self:kitLayoutName()
end

function SpellRow:OnUnbind()
  self:EnableKeyboard(false)
  self.spellId, self.card = nil, nil
end

local SPELL_KINDS = { spell = { height = SPELL_ROW_HEIGHT, mixin = SpellRow } }

local function insertSpellLink(item)
  local editBox = DEFAULT_CHAT_FRAME.editBox
  if editBox and editBox:IsVisible() then
    editBox:SetText(editBox:GetText()..(C_Spell.GetSpellLink(item.spellId) or ""))
  end
end

---@param card MDT.EnemyCard
local function linkSpells(card)
  local enemy = cardEnemy(card)
  local items = card.spells or {}
  if not enemy or #items < 1 then return end
  local distribution = (UnitInRaid("player") and "RAID") or (IsInGroup() and "PARTY")
  if not distribution then return end
  C_ChatInfo.SendChatMessage(string.format(L["MDT: Spells for %s:"], L[enemy.name]), distribution)
  for i, item in ipairs(items) do
    C_ChatInfo.SendChatMessage(i..". "..(C_Spell.GetSpellLink(item.spellId) or item.name), distribution)
  end
end

local function setModel(card, data)
  card.modelData = data
  local model = card.model
  if data.displayId then model:SetDisplayInfo(data.displayId) else model:SetCreature(data.id or DEFAULT_DISPLAY_ID) end
  -- ResetModel comes from the template's mixin, which not every client version has.
  local resetModel = rawget(model, "ResetModel")
  if resetModel then resetModel(model) end
  model:SetPosition(0, 0, 0)
end

---The hover card lists its first spells and counts the rest on the last row; the pinned card scrolls through all of
---them.
local function spellList(content, card, layout)
  local items = card.spells
  local rows = math.min(#items, layout.spells)
  if card.kind == "hover" then
    items = { unpack(items, 1, rows) }
    if #card.spells > rows then
      local last = {}
      for key, value in pairs(items[rows]) do last[key] = value end
      last.more, last.moreFont = #card.spells - rows, layout.font.small
      last.sig = last.sig.."|+"..last.more
      items[rows] = last
    end
  end
  local gap = Theme.Space("xs")
  UI.List(content, {
    id = "spells", kinds = SPELL_KINDS, items = items, gap = gap, scrollbar = #items > rows,
    height = rows * SPELL_ROW_HEIGHT + math.max(0, rows - 1) * gap,
    onHover = function(item, _, row)
      showSpellTooltip(row, item)
      -- The dev keys edit the enemy of the card the row is in.
      row.card = card
      if card.kind == "pinned" and db.devMode then row:EnableKeyboard(true) end
    end,
    onHoverEnd = function(_, _, row)
      if MDTTooltip:IsOwned(row) then MDTTooltip:Hide() end
      row:EnableKeyboard(false)
    end,
    onActivate = function(item, _, mods)
      if mods.shift then insertSpellLink(item) end
    end,
  })
end

local pin

---Fills a card for one enemy clone. Both cards put the portrait on the left and the spells on the right. The hover card
---puts health, forces and efficiency above its spells. The pinned card lists health and forces, efficiency, level and
---NPC id under the portrait, lists every spell, shows what the enemy is affected by, dev help and Link Spells, and
---swaps the pin button for a close button.
---@param card MDT.EnemyCard
---@param blip table the enemy's map blip
local function fill(card, blip)
  db = MDT:GetDB()
  local data, clone = blip.data, blip.clone
  local layout = LAYOUT[card.kind]
  local pinned = card.kind == "pinned"
  card.blip, card.enemyIdx, card.cloneIdx = blip, blip.enemyIdx, blip.cloneIdx
  card.spells = spellItems(data.spells, layout.font.body)
  local health = MDT:CalculateEnemyHealth(data.isBoss or false, data.health, db.currentDifficulty, data.ignoreFortified)
  local count = MDT:GetCloneEnemyForces(data, clone)
  local content = card.content
  content:ReleaseChildren()
  local contentWidth = layout.width - Theme.Space(PAD_X) * 2
  content:SetWidth(contentWidth)
  content:Batch(function()
    -- G45: Unleashed Imp #2. A long name wraps rather than running under the button.
    local title = L[data.name]
    if clone.g then title = string.format(L["G%d:"], clone.g).." "..title end
    if not data.isBoss then title = title.." #"..blip.cloneIdx end
    local header = UI.Row(content, { id = "header", gap = "sm", valign = "center" })
    UI.Text(header, { id = "name", text = title, font = layout.font.title, width = contentWidth - Theme.Space("sm") - HEADER_BUTTON_SIZE })
    if pinned then
      UI.CloseButton(header, { tooltip = L["Close"], onClick = function() card:Hide() end })
    else
      UI.Button(header, {
        id = "pin", variant = "plain", icon = MDT:GetIconPath("pin"), iconSize = 16,
        width = HEADER_BUTTON_SIZE, height = HEADER_BUTTON_SIZE, tooltip = L["Pin"], onClick = function() pin(blip) end,
      })
    end

    local forcesText = MDT:FormatEnemyForces(count)
    local stealthFlags = {}
    for _, entry in ipairs(STEALTH_FLAGS) do
      if data[entry.key] then stealthFlags[#stealthFlags + 1] = entry end
    end
    local function stealthIcons(row)
      if #stealthFlags == 0 then return end
      local iconWidth = CHARACTERISTIC_ICON_SIZE + 2
      local icons = UI.Row(row, {
        id = "stealthIcons", gap = "xs", width = #stealthFlags * iconWidth + (#stealthFlags - 1) * Theme.Space("xs"),
      })
      for _, entry in ipairs(stealthFlags) do
        UI.Button(icons, {
          id = entry.key, variant = "icon", icon = entry.icon, iconCoords = entry.coords, iconSize = CHARACTERISTIC_ICON_SIZE,
          iconColor = false, width = iconWidth, height = iconWidth, tooltip = L[entry.label],
        })
      end
    end

    local body = UI.Row(content, { gap = "md", valign = "start" })
    local portrait = UI.Stack(body, { width = layout.modelWidth, gap = pinned and "sm" or "xs" })
    card.modelHost = UI.Stack(portrait, {
      id = "model", width = layout.modelWidth, height = layout.modelHeight, autoHeight = false,
      background = "bg.sunken", border = "border.normal",
    })
    local column = UI.Stack(body, { gap = "xs", grow = 1, width = 40 })

    if pinned then
      local small = layout.font.small
      local function detail(id, text) UI.Text(portrait, { id = id, text = text, font = small, color = "text.muted" }) end
      local stats = UI.Stack(portrait, { id = "stats", gap = 0 })
      UI.Text(stats, { id = "health", text = L["Health"]..": "..MDT:FormatEnemyHealth(health), font = small, color = "text.muted" })
      UI.Text(stats, { id = "forces", text = L["Enemy Info NPC Enemy Forces"]..": "..forcesText, font = small, color = "text.muted" })
      -- Stealth icons get a line of their own, as the labelled lines fill the column.
      if #stealthFlags > 0 then stealthIcons(UI.Row(stats, { gap = "xs" })) end
      detail("efficiency", L["Efficiency Score"]..": "..MDT:GetEfficiencyScoreString(count, data.health))
      detail("level", string.format(L["Level %d %s"], data.level, L[data.creatureType]))
      detail("npcId", L["Enemy Info NPC Id"]..": "..data.id)
    else
      local stats = UI.Row(column, { id = "stats", gap = "xs", valign = "center" })
      UI.Text(stats, { id = "health", text = string.format(L["%s HP"], MDT:FormatEnemyHealth(health)), font = layout.font.body, color = "text.muted", wrap = false })
      UI.Text(stats, { text = "·", font = layout.font.body, color = "text.muted", wrap = false })
      UI.Text(stats, { id = "forces", text = forcesText, font = layout.font.body, color = "text.muted", wrap = false })
      local score, colorHex = MDT:GetEfficiencyScore(count, data.health)
      UI.Text(stats, { text = "·", font = layout.font.body, color = "text.muted", wrap = false })
      UI.Text(stats, {
        id = "score", text = ("|cFF%s%s|r"):format(colorHex, string.format(L["enemyInfoEfficiencyShort"], score)),
        font = layout.font.body, wrap = false, grow = 1,
      })
      stealthIcons(stats)
    end

    if #card.spells > 0 then spellList(column, card, layout) end

    if not pinned then
      UI.Text(content, { id = "ctrlHint", text = L["enemyInfoHoldCtrlTip"], font = layout.font.small, color = "text.muted", justify = "CENTER" })
      if db.devMode then
        UI.Text(content, { id = "devHint", text = L["devModeShiftDragHint"].."\n"..L["devModeCtrlDragHint"], font = layout.font.small, color = "text.muted" })
      end
      return
    end

    local affected = {}
    for _, characteristic in ipairs(CHARACTERISTICS) do
      if data.characteristics and data.characteristics[characteristic.key] then affected[#affected + 1] = characteristic end
    end
    if #affected > 0 then
      local icons = UI.Row(content, { id = "characteristics", gap = "xs", wrap = true })
      UI.Text(icons, { text = L["Affected by:"], font = layout.font.small, color = "text.muted", wrap = false })
      for _, characteristic in ipairs(affected) do
        UI.Button(icons, {
          variant = "icon", icon = characteristic.icon, iconCoords = UI.Icon.ZOOMED_COORDS, iconSize = CHARACTERISTIC_ICON_SIZE,
          iconColor = false, width = CHARACTERISTIC_ICON_SIZE + 2, height = CHARACTERISTIC_ICON_SIZE + 2, tooltip = L[characteristic.key],
        })
      end
    end

    if db.devMode then UI.Text(content, { id = "devHelp", text = DEV_HELP, font = layout.font.small, color = "text.muted" }) end
    local actions = UI.Row(content, { align = "end" })
    UI.Button(actions, { id = "linkSpells", text = L["Link Spells"], onClick = function() linkSpells(card) end })
  end)
  -- The model is the card's own frame; it sits on the placeholder the layout just placed.
  local model = card.model
  model:ClearAllPoints()
  model:SetPoint("TOPLEFT", card.modelHost, "TOPLEFT", 1, -1)
  model:SetPoint("BOTTOMRIGHT", card.modelHost, "BOTTOMRIGHT", -1, 1)
  model:SetFrameLevel(card.modelHost:GetFrameLevel() + 2)
  setModel(card, data)
  if pinned then
    -- The kit frames in the card take the mouse, so the card itself never sees a drag that starts on them. A handle
    -- over the title, above them, drags it instead, like a dialog's title bar.
    local header, name = content:Find("header"), content:Find("name")
    local handle = card.dragHandle
    handle:ClearAllPoints()
    handle:SetPoint("TOPLEFT", card, "TOPLEFT")
    handle:SetPoint("RIGHT", name, "RIGHT")
    handle:SetPoint("BOTTOM", header, "BOTTOM")
    handle:SetFrameLevel(name:GetFrameLevel() + 1)
  end
end

---Gives a card a position before it is filled, so its spell list measures a real view.
local function anchorAt(card, blip)
  card:ClearAllPoints()
  card:SetPoint("TOPLEFT", blip, "BOTTOMRIGHT", CARD_OFFSET, 0)
end

---Beside the enemy like the old tooltip: below and right of it, flipped up or left at the window's edges.
local function placeBeside(card, blip)
  local main = MDT.main_frame
  card:ClearAllPoints()
  card:SetPoint("TOPLEFT", blip, "BOTTOMRIGHT", CARD_OFFSET, 0)
  local dx, dy = CARD_OFFSET, 0
  if card:GetBottom() < main:GetBottom() then dy = card:GetHeight() end
  if card:GetRight() > main:GetRight() then dx = -(card:GetWidth() + CARD_OFFSET * 2) end
  card:ClearAllPoints()
  card:SetPoint("TOPLEFT", blip, "BOTTOMRIGHT", dx, dy)
end

local function hideHover()
  if hoverCard and hoverCard:IsShown() then
    lastSpot = { blip = hoverBlip, left = hoverCard:GetLeft(), top = hoverCard:GetTop() }
    hoverCard:Hide()
  end
  hoverBlip, heldOverBlip = nil, nil
end

local showHover

---While the hover card shows: it stays while Ctrl is held or the cursor is on its enemy or the card. Releasing Ctrl
---over another enemy moves the card to that enemy.
local function watchHover(card)
  if IsControlKeyDown() then return end
  local waiting = heldOverBlip
  heldOverBlip = nil
  if waiting and waiting ~= hoverBlip and waiting:IsVisible() and waiting:IsMouseOver() then return showHover(waiting) end
  if (hoverBlip and hoverBlip:IsVisible() and hoverBlip:IsMouseOver()) or card:IsMouseOver() then return end
  hideHover()
end

---Puts a card's top left at left, top (in its own units), moved only as far as it must to stay on the map. It is
---anchored to the map's frame, so panning or zooming the map leaves it in place.
local function placeOnMap(card, left, top)
  local canvas = MDT.main_frame.scrollFrame
  local ratio = canvas:GetEffectiveScale() / card:GetEffectiveScale()
  local canvasLeft, canvasTop = canvas:GetLeft() * ratio, canvas:GetTop() * ratio
  left = math.max(canvasLeft, math.min(left, canvas:GetRight() * ratio - card:GetWidth()))
  top = math.min(canvasTop, math.max(top, canvas:GetBottom() * ratio + card:GetHeight()))
  card:ClearAllPoints()
  card:SetPoint("TOPLEFT", canvas, "TOPLEFT", left - canvasLeft, top - canvasTop)
end

local function keepOnMap(card)
  placeOnMap(card, card:GetLeft(), card:GetTop())
end

local function stopDrag(card)
  card:SetScript("OnUpdate", nil)
end

local function followCursor(card)
  if not IsMouseButtonDown("LeftButton") then return stopDrag(card) end
  local x, y = GetCursorPosition()
  local scale = card:GetEffectiveScale()
  placeOnMap(card, x / scale - card.dragOffsetX, y / scale - card.dragOffsetY)
end

---Stacks the pinned cards in their order, the front one on top. They share the DIALOG strata with MDT's dialogs, which
---start at level 100, so only the front few get levels of their own and the rest share the lowest.
local function stackPinned()
  local count = #pinnedCards
  for i, card in ipairs(pinnedCards) do
    card:SetFrameLevel(PINNED_LEVEL_BASE + math.max(0, i - 1 - math.max(0, count - PINNED_STACKED)) * PINNED_LEVEL_STEP)
  end
end

---Puts a pinned card in front of the others, and first in line for Escape.
---@param card MDT.EnemyCard
local function bringToFront(card)
  for i = #pinnedCards, 1, -1 do
    if pinnedCards[i] == card then table.remove(pinnedCards, i) end
  end
  pinnedCards[#pinnedCards + 1] = card
  stackPinned()
  UI.Escape.Push(card.escape)
end

---Whether the frame the cursor is on belongs to a card, so a click that lands on a dialog above it does not count.
local function holdsMouseFocus(card)
  for _, focus in ipairs(GetMouseFoci()) do
    local frame = focus
    while frame do
      if frame == card then return true end
      frame = frame:GetParent()
    end
  end
  return false
end

---Kit controls that only lay out or show text. Every kit control takes the mouse, so a press on them never reaches the
---card; the card drags from them instead. Anything else, buttons, the spell list or the model, keeps its own handling.
local DRAG_THROUGH = { Stack = true, Row = true, Text = true, Heading = true }
---How far the cursor moves with the button down before a press on a card's text becomes a drag, in screen pixels.
local DRAG_THRESHOLD = 4

---The pinned card a press at the cursor drags from its content: the cursor is on the card's layout or text only. A press
---on the card itself or its title drags through their own scripts.
---@return MDT.EnemyCard?
local function cardUnderContentPress()
  ---@type table? kit controls carry their class in .kit
  local frame = GetMouseFoci()[1]
  if not (frame and frame.kit and DRAG_THROUGH[frame.kit.name]) then return nil end
  while frame do
    for _, card in ipairs(pinnedCards) do
      if frame == card then return card end
    end
    if not (frame.kit and DRAG_THROUGH[frame.kit.name]) then return nil end
    frame = frame:GetParent()
  end
end

local startDrag

---Drags the card once the cursor moves far enough with the button still down; a press released before that is a click.
local function watchPress(card)
  local x, y = GetCursorPosition()
  UI.Script(card, "OnUpdate", function()
    if not IsMouseButtonDown("LeftButton") then return stopDrag(card) end
    local cx, cy = GetCursorPosition()
    if math.abs(cx - x) + math.abs(cy - y) >= DRAG_THRESHOLD then startDrag(card, x, y) end
  end)
end

---A click on a pinned card behind another brings it to the front, and a press on its layout or text can drag it. The
---kit frames in a card take its clicks, so the card watches every click instead of its own.
local frontWatcher = CreateFrame("Frame")
UI.Script(frontWatcher, "OnEvent", function(_, _, button)
  local pressed = button == "LeftButton" and cardUnderContentPress()
  if pressed then
    bringToFront(pressed)
    return watchPress(pressed)
  end
  for i = 1, #pinnedCards - 1 do
    local card = pinnedCards[i]
    if holdsMouseFocus(card) then return bringToFront(card) end
  end
end)

---Drags a card with the cursor until the button is released, in front of the others. StartMoving can only keep a frame
---on the screen, not on the map.
---@param card MDT.EnemyCard
---@param x number? where the press began, in screen pixels; the card keeps its place under it. The cursor by default.
---@param y number?
startDrag = function(card, x, y)
  bringToFront(card)
  if not x then x, y = GetCursorPosition() end
  local scale = card:GetEffectiveScale()
  card.dragOffsetX, card.dragOffsetY = x / scale - card:GetLeft(), y / scale - card:GetTop()
  UI.Script(card, "OnUpdate", followCursor)
end

---@param kind "hover"|"pinned"
---@return MDT.EnemyCard
local function createCard(kind)
  local card = CreateFrame("Frame", nil, MDT.main_frame) --[[@as MDT.EnemyCard]]
  card.kind = kind
  card:SetClampedToScreen(true)
  card:EnableMouse(true)
  UI.Overlay.SetStrata(card, LAYOUT[kind].strata)
  local background = card:CreateTexture(nil, "BACKGROUND")
  background:SetAllPoints()
  Theme.Bind(background, "bg.panel")
  UI.Pixel.Border(card, "border.strong")
  card.content = UI.Stack(card, { gap = "sm", onLayout = function(content)
    card:SetSize(content:GetWidth() + Theme.Space(PAD_X) * 2, content:GetHeight() + Theme.Space(PAD_Y) * 2)
  end })
  card.content:SetPoint("TOPLEFT", card, "TOPLEFT", Theme.Space(PAD_X), -Theme.Space(PAD_Y))
  if kind == "pinned" then
    card.model = CreateFrame("PlayerModel", nil, card, "ModelWithControlsTemplate")
    UI.Script(card.model, "OnEnter", nil)
    card.dragHandle = CreateFrame("Frame", nil, card)
    card.dragHandle:EnableMouse(true)
    -- The card's own padding drags it too.
    for _, frame in ipairs({ card, card.dragHandle }) do
      frame:RegisterForDrag("LeftButton")
      UI.Script(frame, "OnDragStart", function() startDrag(card) end)
      UI.Script(frame, "OnDragStop", function() stopDrag(card) end)
    end
    card.escape = { close = function() card:Hide() end }
    -- Every way a pinned card goes, its close button, Escape or the window closing, ends here. Hiding it again keeps it
    -- closed when it went with the window.
    UI.Script(card, "OnHide", function()
      card:Hide()
      stopDrag(card)
      UI.Escape.Remove(card.escape)
      for i = #pinnedCards, 1, -1 do
        if pinnedCards[i] == card then
          table.remove(pinnedCards, i)
          sparePinnedCards[#sparePinnedCards + 1] = card
        end
      end
      card.blip, card.enemyIdx, card.cloneIdx = nil, nil, nil
      stackPinned()
      if #pinnedCards == 0 then frontWatcher:UnregisterEvent("GLOBAL_MOUSE_DOWN") end
    end)
  else
    card.model = CreateFrame("PlayerModel", nil, card)
    card.model.facing = 0
    UI.Script(card.model, "OnUpdate", function(model, elapsed)
      model.facing = (model.facing + elapsed * MODEL_ROTATION_SPEED) % (math.pi * 2)
      model:SetFacing(model.facing)
    end)
    UI.Script(card, "OnUpdate", watchHover)
  end
  -- A model set while its frame has never been drawn can stay blank, so it is set again once the card shows.
  UI.HookScript(card.model, "OnShow", function() if card.modelData then setModel(card, card.modelData) end end)
  card:Hide()
  return card
end

local watchingMapSize = false

---Opens a pinned card for an enemy where its hover card was, or beside the enemy. An enemy that is already pinned
---brings its card to the front instead.
---@param blip table
pin = function(blip)
  hideHover()
  local card = pinnedCardFor(blip)
  if card then return bringToFront(card) end
  if not watchingMapSize then
    watchingMapSize = true
    -- Keeps the pinned cards on the map when the window changes size.
    UI.HookScript(MDT.main_frame.scrollFrame, "OnSizeChanged", function()
      for _, pinned in ipairs(pinnedCards) do keepOnMap(pinned) end
    end)
  end
  card = table.remove(sparePinnedCards) or createCard("pinned")
  local spot = lastSpot and lastSpot.blip == blip and lastSpot or nil
  anchorAt(card, blip)
  fill(card, blip)
  if spot then
    -- Grows down from the hover card's top left.
    placeOnMap(card, spot.left, spot.top)
  else
    placeBeside(card, blip)
    keepOnMap(card)
  end
  card:Show()
  bringToFront(card)
  frontWatcher:RegisterEvent("GLOBAL_MOUSE_DOWN")
end

---@param blip table
---@param place fun(card: MDT.EnemyCard, blip: table)? where the card goes; beside the enemy by default
showHover = function(blip, place)
  hoverCard = hoverCard or createCard("hover")
  hoverBlip, heldOverBlip = blip, nil
  anchorAt(hoverCard, blip)
  fill(hoverCard, blip)
  local placeCard = place or placeBeside
  placeCard(hoverCard, blip)
  hoverCard:Show()
end

---Shows the hover card for an enemy portrait in a pull row, beside the row like the pull's card. The portrait stands in
---for the enemy on the map: the card stays while the cursor is on it.
---@param portraitFrame table the portrait in the row
---@param portrait MDT.SidebarPortrait
---@param row table
function MDT:ShowEnemyCardBesideRow(portraitFrame, portrait, row)
  db = MDT:GetDB()
  local data = MDT.dungeonEnemies[db.currentDungeonIdx][portrait.enemyIdx]
  local clone = data and data.clones[portrait.cloneIdx]
  if not clone then return end
  portraitFrame.data, portraitFrame.clone = data, clone
  portraitFrame.enemyIdx, portraitFrame.cloneIdx = portrait.enemyIdx, portrait.cloneIdx
  showHover(portraitFrame, function(card) MDT:PlaceBesidePullRow(card, row) end)
end

---Called by enemy blips on enter and leave. Entering shows the hover card for that enemy right away, unless Ctrl holds
---the card on another enemy; leaving lets the card's own watch hide it once the cursor is off the enemy.
---@param blip table
---@param shown boolean
function MDT:DisplayBlipTooltip(blip, shown)
  if not shown or MDT:IsPullLabelHovered() or MDT:IsEnemyDragging() then return end
  if pinnedCardFor(blip) then return end
  if IsControlKeyDown() and hoverCard and hoverCard:IsShown() then
    heldOverBlip = blip
    return
  end
  showHover(blip)
end

---Pins the enemy info card for a blip. The right-click menu and the dev panel open it through here.
---@param blip table
function MDT:ShowEnemyInfoFrame(blip)
  pin(blip)
end

---Hides the enemy hover card; pinned cards stay.
function MDT:HideEnemyHoverCard()
  hideHover()
end

---Whether the enemy hover card is open.
---@return boolean
function MDT:IsEnemyHoverCardShown()
  return hoverCard ~= nil and hoverCard:IsShown()
end

---What the open enemy hover card belongs to: an enemy on the map or a portrait in a pull row.
---@return table?
function MDT:GetEnemyHoverCardOwner()
  return MDT:IsEnemyHoverCardShown() and hoverBlip or nil
end

---Closes the hover card and every pinned card.
function MDT:CloseEnemyInfo()
  hideHover()
  for i = #pinnedCards, 1, -1 do pinnedCards[i]:Hide() end
end

---Refills the pinned cards after dev edits or map changes, and closes those whose enemy clone is gone.
function MDT:UpdateEnemyInfoFrame()
  for i = #pinnedCards, 1, -1 do
    local card = pinnedCards[i]
    local blip = pinnedEnemyBlip(card)
    if not blip then
      card:Hide()
    else
      fill(card, blip)
      keepOnMap(card)
    end
  end
end

---Refreshes health and forces after the key level changed.
function MDT:UpdateEnemyInfoData()
  MDT:UpdateEnemyInfoFrame()
  if hoverCard and hoverCard:IsShown() and hoverBlip then fill(hoverCard, hoverBlip) end
end

---Test and dev access to the cards.
---@param kind "hover"|"pinned"
---@return MDT.EnemyCard?
function MDT:GetEnemyInfoCard(kind)
  if kind == "pinned" then return pinnedCards[#pinnedCards] end
  return hoverCard
end

---Test access to the open pinned cards, the front one last.
---@return MDT.EnemyCard[]
function MDT:GetEnemyInfoPinnedCards()
  return { unpack(pinnedCards) }
end
