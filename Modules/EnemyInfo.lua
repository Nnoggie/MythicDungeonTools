local _, MDT = ...
local L = MDT.L
local UI = MDT.UI
local Theme, Fonts = UI.Theme, UI.Fonts
local db

local DEFAULT_DISPLAY_ID = 39490
local UNKNOWN_SPELL_ICON = 134400
local SPELL_ROW_HEIGHT = 32
local SPELL_ICON_SIZE = 28
local STATUS_ICON_SIZE = 14
local TOOLTIP_ICON_SIZE = 12
local CHARACTERISTIC_ICON_SIZE = 20
local MIN_MODEL_HEIGHT = 120
local MIN_LIST_HEIGHT = 64

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

---@class MDT.EnemyInfoField
---@field id string
---@field label string
---@field value string

local lastEnemyIdx, lastCloneIdx
---The open window's controls; nil while it is closed.
local view
local model

function MDT:GetEnemyInfoEnemyIdx()
  return lastEnemyIdx
end

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

---@return MDT.EnemyInfoField[]
local function enemyFields(data, cloneIdx)
  local level = db.currentDifficulty
  local healthLabel = string.format(L["Enemy Info NPC Health Level"], level)
  if level >= 10 then
    healthLabel = string.format(L["Enemy Info NPC Health"], level, L["Fortified"].."/"..L["Tyrannical"])
  end
  local health = MDT:CalculateEnemyHealth(data.isBoss or false, data.health, level, data.ignoreFortified)
  return {
    { id = "name", label = L["Enemy Info NPC Name"], value = L[data.name] },
    { id = "npcId", label = L["Enemy Info NPC Id"], value = tostring(data.id) },
    { id = "health", label = healthLabel, value = MDT:FormatEnemyHealth(health) },
    { id = "creatureType", label = L["Enemy Info NPC Creature Type"], value = L[data.creatureType] },
    { id = "level", label = L["Enemy Info NPC Level"], value = tostring(data.level) },
    { id = "forces", label = L["Enemy Info NPC Enemy Forces"], value = tostring(MDT:GetCloneEnemyForces(data, data.clones[cloneIdx])) },
  }
end

local function enemyChoices()
  local names, order = {}, {}
  for enemyIdx, data in ipairs(MDT.dungeonEnemies[db.currentDungeonIdx]) do
    names[enemyIdx] = L[data.name]
    order[enemyIdx] = enemyIdx
  end
  return UI.MenuModel.FromList(names, order)
end

local function currentEnemy()
  return lastEnemyIdx and MDT.dungeonEnemies[db.currentDungeonIdx][lastEnemyIdx]
end

local function showSpellTooltip(row, item)
  GameTooltip:SetOwner(row, "ANCHOR_BOTTOMLEFT", 0, row:GetHeight())
  GameTooltip:ClearLines()
  GameTooltip:SetSpellByID(item.spellId)
  for _, status in ipairs(item.statuses) do
    if CreateAtlasMarkup then
      GameTooltip:AddLine(CreateAtlasMarkup(status.atlas, TOOLTIP_ICON_SIZE, TOOLTIP_ICON_SIZE)..status.label)
    else
      GameTooltip:AddLine(status.label)
    end
  end
  GameTooltip:Show()
end

local function onDevKey(row, key)
  if not db.devMode then return end
  local enemy = currentEnemy()
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

local SpellRow = {}

function SpellRow:OnCreate()
  self.kitIcon = self:CreateTexture(nil, "ARTWORK")
  self.kitIcon:SetSize(SPELL_ICON_SIZE, SPELL_ICON_SIZE)
  self.kitIcon:SetPoint("LEFT", self, "LEFT", Theme.Space("xs"), 0)
  self.kitName = self:CreateFontString(nil, "ARTWORK")
  self.kitName:SetFontObject(Fonts.Get("body"))
  self.kitName:SetJustifyH("LEFT")
  self.kitName:SetWordWrap(false)
  Theme.Bind(self.kitName, "text.normal")
  self.kitStatusIcons = {}
  for i, status in ipairs(SPELL_STATUSES) do
    local icon = self:CreateTexture(nil, "OVERLAY")
    icon:SetSize(STATUS_ICON_SIZE, STATUS_ICON_SIZE)
    icon:SetAtlas(status.atlas)
    icon:Hide()
    self.kitStatusIcons[i] = icon
  end
  self:SetScript("OnKeyDown", onDevKey)
  self:EnableKeyboard(false)
end

---@param item MDT.EnemyInfoSpellItem
function SpellRow:Bind(item)
  self.spellId = item.spellId
  UI.Icon.SetZoomed(self.kitIcon, item.icon)
  self.kitName:SetText(item.name)
  self.kitName:ClearAllPoints()
  self.kitName:SetPoint("RIGHT", self, "RIGHT", -Theme.Space("md"), 0)
  local gap = Theme.Space("sm")
  if #item.statuses > 0 then
    self.kitName:SetPoint("TOPLEFT", self.kitIcon, "TOPRIGHT", gap, 0)
  else
    self.kitName:SetPoint("LEFT", self.kitIcon, "RIGHT", gap, 0)
  end
  for _, icon in ipairs(self.kitStatusIcons) do icon:Hide() end
  local previous
  for _, status in ipairs(item.statuses) do
    for i, candidate in ipairs(SPELL_STATUSES) do
      if candidate == status then
        local icon = self.kitStatusIcons[i]
        icon:ClearAllPoints()
        if previous then
          icon:SetPoint("LEFT", previous, "RIGHT", Theme.Space("xs"), 0)
        else
          icon:SetPoint("BOTTOMLEFT", self.kitIcon, "BOTTOMRIGHT", gap, 0)
        end
        icon:Show()
        previous = icon
      end
    end
  end
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
  local items = view and view.spells or {}
  if #items < 1 then return end
  local distribution = (UnitInRaid("player") and "RAID") or (IsInGroup() and "PARTY")
  if not distribution then return end
  C_ChatInfo.SendChatMessage(string.format(L["MDT: Spells for %s:"], L[currentEnemy().name]), distribution)
  for i, item in ipairs(items) do
    C_ChatInfo.SendChatMessage(i..". "..(C_Spell.GetSpellLink(item.spellId) or item.name), distribution)
  end
end

local function attachModel(host)
  model = model or CreateFrame("PlayerModel", nil, host, "ModelWithControlsTemplate")
  model:SetParent(host)
  model:ClearAllPoints()
  model:SetPoint("TOPLEFT", host, "TOPLEFT", 1, -1)
  model:SetPoint("BOTTOMRIGHT", host, "BOTTOMRIGHT", -1, 1)
  model:SetScript("OnEnter", nil)
  model:Show()
end

-- The model is one frame for the addon's lifetime; it leaves the pooled host before the dialog is released.
local function detachModel()
  model:Hide()
  model:ClearAllPoints()
  model:SetParent(UI.Root)
end

local function buildContent(content)
  local columns = UI.Columns(content, { weights = { 1, 1, 1 } })
  for i = 1, 3 do columns[i]:SetAutoHeight(false) end
  local left, middle, right = columns[1], columns[2], columns[3]
  view.columns = columns

  view.enemy = UI.Dropdown(left, { onChange = function(enemyIdx) MDT:UpdateEnemyInfoFrame(enemyIdx) end })
  local modelHost = UI.Stack(left, { height = MIN_MODEL_HEIGHT, grow = 1, background = "bg.sunken", border = "border.normal" })
  attachModel(modelHost)
  UI.Text(left, { text = L["Affected by:"], font = "small", color = "text.muted" })
  view.characteristics = UI.Row(left, { gap = "xs", wrap = true })

  view.fields = {}
  for _, field in ipairs(enemyFields(currentEnemy(), lastCloneIdx)) do
    view.fields[field.id] = UI.EditBox(middle, { label = field.label, readOnly = true, selectAllOnFocus = true })
  end
  local flags = UI.Row(middle, { gap = "lg", wrap = true })
  view.stealth = UI.Checkbox(flags, { label = L["Enemy Info NPC Stealth"], disabled = true })
  view.stealthDetect = UI.Checkbox(flags, { label = L["Enemy Info NPC Stealth Detect"], disabled = true })

  view.devHelp = UI.Text(right, { text = DEV_HELP, font = "small", color = "text.muted" })
  view.list = UI.List(right, {
    kinds = SPELL_KINDS, gap = "xs", height = MIN_LIST_HEIGHT, grow = 1,
    onHover = function(item, _, row)
      showSpellTooltip(row, item)
      if db.devMode then row:EnableKeyboard(true) end
    end,
    onHoverEnd = function(_, _, row)
      if GameTooltip:IsOwned(row) then GameTooltip:Hide() end
      row:EnableKeyboard(false)
    end,
    onActivate = function(item, _, mods)
      if mods.shift then insertSpellLink(item) end
    end,
  })
  local actions = UI.Row(right, { align = "end" })
  UI.Button(actions, { text = L["Link Spells"], onClick = linkSpells })
end

---Sizes the window to cover the map; the columns share the height below the title bar.
local function fitToMap()
  local map = MDT.main_frame.scrollFrame
  local dialog = view.dialog
  local columnHeight = map:GetHeight() - (dialog:GetHeight() - view.columns:GetHeight())
  dialog.content:SetWidth(map:GetWidth())
  for i = 1, 3 do view.columns[i]:SetHeight(columnHeight) end
  dialog:ClearAllPoints()
  dialog:SetPoint("TOPLEFT", map, "TOPLEFT", 0, 0)
end

local function applyFields(data, cloneIdx)
  for _, field in ipairs(enemyFields(data, cloneIdx)) do
    local box = view.fields[field.id]
    box:SetLabel(field.label)
    box:SetValue(field.value)
  end
  view.stealth:SetValue(data.stealth == true)
  view.stealthDetect:SetValue(data.stealthDetect == true)
end

local function applyCharacteristics(data)
  local row = view.characteristics
  row:ReleaseChildren()
  for _, characteristic in ipairs(CHARACTERISTICS) do
    if data.characteristics and data.characteristics[characteristic.key] then
      UI.Button(row, {
        variant = "icon", icon = characteristic.icon, iconCoords = UI.Icon.ZOOMED_COORDS, iconSize = CHARACTERISTIC_ICON_SIZE, iconColor = false,
        tooltip = L[characteristic.key],
      })
    end
  end
end

local function openWindow()
  view = {}
  view.dialog = UI.Dialogs.Open({
    key = "enemyInfo",
    title = L["Enemy Info"],
    parent = MDT.main_frame,
    width = MDT.main_frame.scrollFrame:GetWidth(),
    pinned = true,
    build = buildContent,
    onClose = function()
      detachModel()
      view = nil
    end,
  })
end

function MDT:UpdateEnemyInfoFrame(enemyIdx, cloneIdx)
  if not enemyIdx then enemyIdx, cloneIdx = lastEnemyIdx, lastCloneIdx end
  lastEnemyIdx, lastCloneIdx = enemyIdx, cloneIdx
  if not view or not enemyIdx then return end
  db = MDT:GetDB()
  local data = MDT.dungeonEnemies[db.currentDungeonIdx][enemyIdx]
  if not data then return end
  view.dialog:SetTitle(L[data.name])
  view.spells = spellItems(data.spells)
  view.dialog.content:Batch(function()
    fitToMap()
    view.enemy:SetItems(enemyChoices())
    view.enemy:SetValue(enemyIdx)
    applyCharacteristics(data)
    applyFields(data, cloneIdx)
    view.devHelp:SetHidden(not db.devMode)
    view.list:SetItems(view.spells)
  end)
  model:SetDisplayInfo(data.displayId or DEFAULT_DISPLAY_ID)
  -- ResetModel comes from the template's mixin, which not every client version has.
  local resetModel = rawget(model, "ResetModel")
  if resetModel then resetModel(model) end
  model:SetPosition(0, 0, 0)
end

---Refreshes the health, forces and other fields after the key level changed. No-op while the window is closed.
function MDT:UpdateEnemyInfoData(enemyIdx, cloneIdx)
  if not view then return end
  if not enemyIdx then enemyIdx, cloneIdx = lastEnemyIdx, lastCloneIdx end
  local data = enemyIdx and MDT.dungeonEnemies[db.currentDungeonIdx][enemyIdx]
  if not data then return end
  view.dialog.content:Batch(function() applyFields(data, cloneIdx) end)
end

function MDT:ShowEnemyInfoFrame(blip)
  db = MDT:GetDB()
  lastEnemyIdx, lastCloneIdx = blip.enemyIdx, blip.cloneIdx
  if not view then openWindow() end
  MDT:UpdateEnemyInfoFrame(blip.enemyIdx, blip.cloneIdx)
end
