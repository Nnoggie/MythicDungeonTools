local _, MDT = ...
local L = MDT.L
local UI = MDT.UI
local Theme, Fonts = UI.Theme, UI.Fonts
local db

-- Enemy info lives in two cards. Hovering an enemy shows the compact hover card beside it; it stays while the cursor
-- moves into it, so its spells can be hovered and linked. Pinning (its pin button or the right-click menu) opens the
-- expanded pinned card in the same spot, which stays until closed while the map keeps working.

local DEFAULT_DISPLAY_ID = 39490
local UNKNOWN_SPELL_ICON = 134400
local SPELL_ROW_HEIGHT = 22
local SPELL_ICON_SIZE = 18
local STATUS_ICON_SIZE = 14
local TOOLTIP_ICON_SIZE = 12
local CHARACTERISTIC_ICON_SIZE = 16
---Seconds the hover card waits for the cursor after it leaves the enemy.
local HOVER_GRACE = 0.2
---Gap between an enemy and its card.
local CARD_OFFSET = 30
local MODEL_ROTATION_SPEED = math.pi / 4

local LAYOUT = {
  hover = { width = 250, modelWidth = 72, modelHeight = 84, spells = 4, strata = "TOOLTIP" },
  pinned = { width = 300, modelWidth = 96, modelHeight = 112, spells = 10, strata = "DIALOG" },
}

---Icons shown only for enemies that are stealthed or detect stealth.
local STEALTH_FLAGS = {
  { key = "stealth", label = "Enemy Info NPC Stealth", icon = "Interface\\ICONS\\ability_stealth" },
  { key = "stealthDetect", label = "Enemy Info NPC Stealth Detect", icon = "Interface\\ICONS\\spell_shadow_detectinvisibility" },
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

---@type MDT.EnemyCard?, MDT.EnemyCard?
local hoverCard, pinnedCard
---The enemy the hover card belongs to, and when the cursor was last over it or its card.
local hoverBlip, lastInside = nil, 0
---Where the hover card last showed and for which enemy, so pinning from the right-click menu opens in the same spot.
local lastSpot
local pinnedEscape

---@return MDT.EnemyInfoSpellItem[]
local function spellItems(spells)
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
      spellId = spellId, name = name, statuses = statuses,
      icon = info and C_Spell.GetSpellTexture(spellId) or UNKNOWN_SPELL_ICON,
    }
  end
  return items
end

local function isPinned()
  return pinnedCard ~= nil and pinnedCard:IsShown() and pinnedCard.enemyIdx ~= nil
end

local function pinnedEnemy()
  return isPinned() and MDT.dungeonEnemies[db.currentDungeonIdx][pinnedCard.enemyIdx] or nil
end

function MDT:GetEnemyInfoEnemyIdx()
  return isPinned() and pinnedCard.enemyIdx or nil
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
  if not db.devMode then return end
  local enemy = pinnedEnemy()
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

---One spell: its icon, its name and its status icons on the right.
local SpellRow = {}

function SpellRow:OnCreate()
  self.kitIcon = self:CreateTexture(nil, "ARTWORK")
  self.kitIcon:SetSize(SPELL_ICON_SIZE, SPELL_ICON_SIZE)
  self.kitIcon:SetPoint("LEFT", self, "LEFT", 0, 0)
  self.kitName = self:CreateFontString(nil, "ARTWORK")
  self.kitName:SetFontObject(Fonts.Get("body"))
  self.kitName:SetJustifyH("LEFT")
  self.kitName:SetWordWrap(false)
  self.kitName:SetPoint("LEFT", self.kitIcon, "RIGHT", Theme.Space("sm"), 0)
  Theme.Bind(self.kitName, "text.normal")
  self.kitStatusIcons = {}
  for i, status in ipairs(SPELL_STATUSES) do
    local icon = self:CreateTexture(nil, "OVERLAY")
    icon:SetSize(STATUS_ICON_SIZE, STATUS_ICON_SIZE)
    icon:SetAtlas(status.atlas)
    icon:Hide()
    self.kitStatusIcons[i] = icon
  end
  UI.Script(self, "OnKeyDown", onDevKey)
  self:EnableKeyboard(false)
end

---@param item MDT.EnemyInfoSpellItem
function SpellRow:Bind(item)
  self.spellId = item.spellId
  UI.Icon.SetZoomed(self.kitIcon, item.icon)
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
  self.kitName:SetPoint("RIGHT", previous or self, previous and "LEFT" or "RIGHT", -gap, 0)
end

function SpellRow:OnUnbind()
  self:EnableKeyboard(false)
  self.spellId = nil
end

local SPELL_KINDS = { spell = { height = SPELL_ROW_HEIGHT, mixin = SpellRow } }

local function insertSpellLink(item)
  local editBox = DEFAULT_CHAT_FRAME.editBox
  if editBox and editBox:IsVisible() then
    editBox:SetText(editBox:GetText()..(C_Spell.GetSpellLink(item.spellId) or ""))
  end
end

local function linkSpells()
  local enemy = pinnedEnemy()
  local items = pinnedCard and pinnedCard.spells or {}
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

---The hover card lists its first spells and counts the rest; the pinned card scrolls through all of them.
local function spellList(content, card, layout)
  local items = card.spells
  local rows = math.min(#items, layout.spells)
  if card.kind == "hover" then items = { unpack(items, 1, rows) } end
  local gap = Theme.Space("xs")
  UI.List(content, {
    id = "spells", kinds = SPELL_KINDS, items = items, gap = gap, scrollbar = #items > rows,
    height = rows * SPELL_ROW_HEIGHT + math.max(0, rows - 1) * gap,
    onHover = function(item, _, row)
      showSpellTooltip(row, item)
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

---Fills a card for one enemy clone. Both cards share this; the pinned card adds the NPC id, more spells, dev help and
---Link Spells, and swaps the pin button for a close button.
---@param card MDT.EnemyCard
---@param blip table the enemy's map blip
local function fill(card, blip)
  db = MDT:GetDB()
  local data, clone = blip.data, blip.clone
  local layout = LAYOUT[card.kind]
  local pinned = card.kind == "pinned"
  card.blip, card.enemyIdx, card.cloneIdx = blip, blip.enemyIdx, blip.cloneIdx
  card.spells = spellItems(data.spells)
  local health = MDT:CalculateEnemyHealth(data.isBoss or false, data.health, db.currentDifficulty, data.ignoreFortified)
  local count = MDT:GetCloneEnemyForces(data, clone)
  local content = card.content
  content:ReleaseChildren()
  content:SetWidth(layout.width)
  content:Batch(function()
    local header = UI.Row(content, { id = "header", gap = "sm", valign = "center" })
    UI.Text(header, { id = "name", text = L[data.name], font = "title", wrap = false, grow = 1, width = 40 })
    local occurrence = (data.isBoss and "" or ("#"..blip.cloneIdx))..(clone.g and " "..string.format(L["(G %d)"], clone.g) or "")
    if occurrence ~= "" then UI.Text(header, { id = "occurrence", text = occurrence, font = "small", color = "text.muted", wrap = false }) end
    if pinned then
      UI.CloseButton(header, { tooltip = L["Close"], onClick = function() MDT:CloseEnemyInfo() end })
    else
      UI.Button(header, {
        id = "pin", variant = "plain", icon = MDT:GetIconPath("pin"), iconSize = 14, width = 22, height = 22,
        tooltip = L["Pin"], onClick = function() pin(blip) end,
      })
    end

    local body = UI.Row(content, { gap = "md", valign = "start" })
    card.modelHost = UI.Stack(body, {
      id = "model", width = layout.modelWidth, height = layout.modelHeight, autoHeight = false,
      background = "bg.sunken", border = "border.normal",
    })
    local stats = UI.Stack(body, { gap = "xs", grow = 1, width = 40 })
    UI.Text(stats, { id = "level", text = string.format(L["Level %d %s"], data.level, L[data.creatureType]), font = "small", color = "text.muted" })
    UI.Text(stats, { id = "health", text = string.format(L["%s HP"], MDT:FormatEnemyHealth(health)) })
    UI.Text(stats, { id = "forces", text = L["Forces"]..": "..MDT:FormatEnemyForces(count) })
    UI.Text(stats, { id = "efficiency", text = L["Efficiency Score"]..": "..MDT:GetEfficiencyScoreString(count, data.health), font = "small", color = "text.muted" })
    if pinned then UI.Text(stats, { id = "npcId", text = L["Enemy Info NPC Id"]..": "..data.id, font = "small", color = "text.muted" }) end
    local stealthIcons
    for _, entry in ipairs(STEALTH_FLAGS) do
      if data[entry.key] then
        stealthIcons = stealthIcons or UI.Row(stats, { id = "stealthIcons", gap = "xs" })
        UI.Button(stealthIcons, {
          id = entry.key, variant = "icon", icon = entry.icon, iconCoords = UI.Icon.ZOOMED_COORDS, iconSize = CHARACTERISTIC_ICON_SIZE,
          iconColor = false, width = CHARACTERISTIC_ICON_SIZE + 2, height = CHARACTERISTIC_ICON_SIZE + 2, tooltip = L[entry.label],
        })
      end
    end

    local affected = {}
    for _, characteristic in ipairs(CHARACTERISTICS) do
      if data.characteristics and data.characteristics[characteristic.key] then affected[#affected + 1] = characteristic end
    end
    if #affected > 0 then
      UI.Text(content, { text = L["Affected by:"], font = "small", color = "text.muted" })
      local icons = UI.Row(content, { id = "characteristics", gap = "xs", wrap = true })
      for _, characteristic in ipairs(affected) do
        UI.Button(icons, {
          variant = "icon", icon = characteristic.icon, iconCoords = UI.Icon.ZOOMED_COORDS, iconSize = CHARACTERISTIC_ICON_SIZE,
          iconColor = false, width = CHARACTERISTIC_ICON_SIZE + 2, height = CHARACTERISTIC_ICON_SIZE + 2, tooltip = L[characteristic.key],
        })
      end
    end

    if #card.spells > 0 then
      spellList(content, card, layout)
      if not pinned and #card.spells > layout.spells then
        UI.Text(content, { id = "moreSpells", text = string.format(L["+%d more spells"], #card.spells - layout.spells), font = "small", color = "text.muted" })
      end
    end

    if pinned then
      if db.devMode then UI.Text(content, { id = "devHelp", text = DEV_HELP, font = "small", color = "text.muted" }) end
      local actions = UI.Row(content, { align = "end" })
      UI.Button(actions, { id = "linkSpells", text = L["Link Spells"], onClick = linkSpells })
    elseif db.devMode then
      UI.Text(content, { id = "devHint", text = L["devModeShiftDragHint"].."\n"..L["devModeCtrlDragHint"], font = "small", color = "text.muted" })
    end
  end)
  -- The model is the card's own frame; it sits on the placeholder the layout just placed.
  local model = card.model
  model:ClearAllPoints()
  model:SetPoint("TOPLEFT", card.modelHost, "TOPLEFT", 1, -1)
  model:SetPoint("BOTTOMRIGHT", card.modelHost, "BOTTOMRIGHT", -1, 1)
  model:SetFrameLevel(card.modelHost:GetFrameLevel() + 2)
  setModel(card, data)
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
  hoverBlip = nil
end

---While the hover card shows: it stays as long as the cursor is over the enemy or the card, and goes after a short grace.
local function watchHover(card)
  if (hoverBlip and hoverBlip:IsVisible() and hoverBlip:IsMouseOver()) or card:IsMouseOver() then
    lastInside = GetTime()
  elseif GetTime() - lastInside > HOVER_GRACE then
    hideHover()
  end
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
  card.content = UI.Stack(card, { padding = "md", gap = "sm", onLayout = function(content)
    card:SetSize(content:GetWidth(), content:GetHeight())
  end })
  card.content:SetPoint("TOPLEFT", card, "TOPLEFT", 0, 0)
  if kind == "pinned" then
    card.model = CreateFrame("PlayerModel", nil, card, "ModelWithControlsTemplate")
    UI.Script(card.model, "OnEnter", nil)
    card:SetMovable(true)
    card:RegisterForDrag("LeftButton")
    UI.Script(card, "OnDragStart", card.StartMoving)
    UI.Script(card, "OnDragStop", card.StopMovingOrSizing)
    UI.Script(card, "OnHide", function() MDT:CloseEnemyInfo() end)
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

---Opens the pinned card for an enemy where its hover card was, or beside the enemy.
---@param blip table
pin = function(blip)
  pinnedCard = pinnedCard or createCard("pinned")
  hideHover()
  local spot = lastSpot and lastSpot.blip == blip and lastSpot or nil
  local main = MDT.main_frame
  local left, top = spot and spot.left, spot and spot.top
  anchorAt(pinnedCard, blip)
  fill(pinnedCard, blip)
  if left and top then
    -- Grows down from the hover card's top left, moved up only as far as it must to stay inside the window.
    top = math.max(top, main:GetBottom() + pinnedCard:GetHeight())
    pinnedCard:ClearAllPoints()
    pinnedCard:SetPoint("TOPLEFT", main, "BOTTOMLEFT", left - main:GetLeft(), top - main:GetBottom())
  else
    placeBeside(pinnedCard, blip)
  end
  pinnedCard:Show()
  pinnedEscape = pinnedEscape or { close = function() MDT:CloseEnemyInfo() end }
  UI.Escape.Push(pinnedEscape)
end

---Called by enemy blips on enter and leave. Entering shows the hover card for that enemy right away; leaving lets the
---card's own watch hide it once the cursor is neither on the enemy nor on the card.
---@param blip table
---@param shown boolean
function MDT:DisplayBlipTooltip(blip, shown)
  if not shown then return end
  if isPinned() and pinnedCard.blip == blip then return end
  hoverCard = hoverCard or createCard("hover")
  hoverBlip, lastInside = blip, GetTime()
  anchorAt(hoverCard, blip)
  fill(hoverCard, blip)
  placeBeside(hoverCard, blip)
  hoverCard:Show()
end

---Pins the enemy info card for a blip. The right-click menu and the dev panel open it through here.
---@param blip table
function MDT:ShowEnemyInfoFrame(blip)
  pin(blip)
end

function MDT:CloseEnemyInfo()
  hideHover()
  if pinnedEscape then UI.Escape.Remove(pinnedEscape) end
  if isPinned() then
    pinnedCard.blip, pinnedCard.enemyIdx, pinnedCard.cloneIdx = nil, nil, nil
    pinnedCard:Hide()
  end
end

---Refills the pinned card after dev edits or map changes. No-op while nothing is pinned.
function MDT:UpdateEnemyInfoFrame()
  if not isPinned() then return end
  local blip = pinnedCard.blip
  if not blip.data or blip.enemyIdx ~= pinnedCard.enemyIdx then return MDT:CloseEnemyInfo() end
  fill(pinnedCard, blip)
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
  return kind == "pinned" and pinnedCard or hoverCard
end
