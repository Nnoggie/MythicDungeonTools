local Type, Version = "MDTSpellButton", 1
local AceGUI = LibStub and LibStub("AceGUI-3.0", true)
local L = MDT.L
local width, height = 248, 32
local tooltipIconSize = 12
local statusIconScale = 0.504
local firstStatusIconOffsetX = 36
local firstStatusIconOffsetY = -1
local statusIconSpacingX = 1
local statusOrder = {
  "interruptible",
  "magic",
  "poison",
  "disease",
  "curse",
  "bleed",
  "enrage",
}
local statusAtlases = {
  interruptible = "icons_16x16_interrupt",
  magic = "icons_16x16_magic",
  poison = "icons_16x16_poison",
  disease = "icons_16x16_disease",
  curse = "icons_16x16_curse",
  bleed = "icons_16x16_bleed",
  enrage = "icons_16x16_enrage",
}
local statusLabels = {
  interruptible = L["Interruptible"],
  magic = L["Magic"],
  poison = L["Poison"],
  disease = L["Disease"],
  curse = L["Curse"],
  bleed = L["Bleed"],
  enrage = L["Enrage"],
}

local function AddTooltipStatusLine(tooltip, statusKey)
  local label = statusLabels[statusKey]
  local atlas = statusAtlases[statusKey]
  if CreateAtlasMarkup and atlas then
    tooltip:AddLine(CreateAtlasMarkup(atlas, tooltipIconSize, tooltipIconSize)..label)
    return
  end

  tooltip:AddLine(label)
end

local function CreateStatusIcon(parent, atlas)
  local texture = parent:CreateTexture(nil, "OVERLAY", nil, 0)
  texture:SetSize(height * statusIconScale, height * statusIconScale)
  texture:SetAtlas(atlas)
  texture:Hide()
  return texture
end

local methods = {
  ["OnAcquire"] = function(self)
    self:SetWidth(width)
    self:SetHeight(height)
  end,

  ["Initialize"] = function(self)
    self.callbacks = {}

    function self.callbacks.OnClickNormal(_, mouseButton)
      if (IsControlKeyDown()) then
      elseif (IsShiftKeyDown()) then
        if DEFAULT_CHAT_FRAME.editBox and DEFAULT_CHAT_FRAME.editBox:IsVisible() then
          local old = DEFAULT_CHAT_FRAME.editBox:GetText()
          local link = C_Spell.GetSpellLink(self.spellId) or ""
          DEFAULT_CHAT_FRAME.editBox:SetText(old..link)
        end
      else
      end
    end

    function self.callbacks.OnEnter()
      GameTooltip:SetOwner(self.frame, "ANCHOR_BOTTOMLEFT", 0, self.frame:GetHeight())
      GameTooltip:ClearLines()
      GameTooltip:SetSpellByID(self.spellId)

      for _, statusKey in ipairs(statusOrder) do
        if self[statusKey] then
          AddTooltipStatusLine(GameTooltip, statusKey)
        end
      end

      GameTooltip:Show()

      if MDT:GetDB().devMode then
        self.frame:EnableKeyboard(true)
      end
    end

    function self.callbacks.OnLeave()
      GameTooltip:Hide()
      if MDT:GetDB().devMode then
        self.frame:EnableKeyboard(false)
      end
    end

    function self.callbacks.OnKeyDown(_, key)
      local db = MDT:GetDB()
      if db.devMode then
        local enemies = MDT.dungeonEnemies[db.currentDungeonIdx]
        local devBlip = MDT:GetCurrentDevmodeBlip()
        local enemyIdx = MDT:GetEnemyInfoEnemyIdx()
        local enemy = enemies[enemyIdx]
        if not enemy or not enemy.spells or not enemy.spells[self.spellId] then return end
        local spell = enemy.spells[self.spellId]

        if key == "I" then
          spell.interruptible = not spell.interruptible
          MDT:UpdateEnemyInfoFrame(enemyIdx)
        end
        if key == "M" then
          spell.magic = not spell.magic
          MDT:UpdateEnemyInfoFrame(enemyIdx)
        end
        if key == "P" then
          spell.poison = not spell.poison
          MDT:UpdateEnemyInfoFrame(enemyIdx)
        end
        if key == "D" then
          spell.disease = not spell.disease
          MDT:UpdateEnemyInfoFrame(enemyIdx)
        end
        if key == "C" then
          spell.curse = not spell.curse
          MDT:UpdateEnemyInfoFrame(enemyIdx)
        end
        if key == "B" then
          spell.bleed = not spell.bleed
          MDT:UpdateEnemyInfoFrame(enemyIdx)
        end
        if key == "E" then
          spell.enrage = not spell.enrage
          MDT:UpdateEnemyInfoFrame(enemyIdx)
        end

        if key == "R" then
          enemy.spells[self.spellId] = nil
          MDT:UpdateEnemyInfoFrame(enemyIdx)
        end
        --print spellId
        if key == "S" then
          print(self.spellId)
        end
      end

      if (key == "ESCAPE") then
      end
    end

    function self.callbacks.OnDragStart() end
    function self.callbacks.OnDragStop() end

    self.frame:SetScript("OnClick", self.callbacks.OnClickNormal)
    self.frame:SetScript("OnKeyDown", self.callbacks.OnKeyDown)
    self.frame:SetScript("OnEnter", self.callbacks.OnEnter)
    self.frame:SetScript("OnLeave", self.callbacks.OnLeave)
    self.frame:EnableKeyboard(false)
    self.frame:SetMovable(true)
    self.frame:RegisterForDrag("LeftButton")
    self.frame:SetScript("OnDragStart", self.callbacks.OnDragStart)
    self.frame:SetScript("OnDragStop", self.callbacks.OnDragStop)
    self:Enable()
  end,

  ["SetSpell"] = function(self, spellId, spellData)
    if not C_Spell.IsSpellDataCached(spellId) then
      C_Spell.RequestLoadSpellData(spellId)
    end

    self.spellId = spellId
    local spellInfo = C_Spell.GetSpellInfo(spellId)
    --spell sometimes only exists on beta / ptr - guard against that here
    if not spellInfo then return end

    self.icon:SetTexture(C_Spell.GetSpellTexture(spellId))
    self.title:SetText(spellInfo.name)

    self.interruptible = spellData.interruptible or false
    self.magic         = spellData.magic         or false
    self.poison        = spellData.poison        or false
    self.disease       = spellData.disease       or false
    self.curse         = spellData.curse         or false
    self.bleed         = spellData.bleed         or false
    self.enrage        = spellData.enrage        or false

    for _, statusKey in ipairs(statusOrder) do
      self[statusKey.."Icon"]:Hide()
    end

    local iconsToShow = {}
    for _, statusKey in ipairs(statusOrder) do
      if self[statusKey] then
        table.insert(iconsToShow, self[statusKey.."Icon"])
      end
    end

    local prevIcon
    for i, iconFrame in ipairs(iconsToShow) do
      iconFrame:ClearAllPoints()
      if i == 1 then
        iconFrame:SetPoint("BOTTOMLEFT", self.frame, "BOTTOMLEFT", firstStatusIconOffsetX, firstStatusIconOffsetY)
      else
        iconFrame:SetPoint("LEFT", prevIcon, "RIGHT", statusIconSpacingX, 0)
      end
      iconFrame:Show()
      prevIcon = iconFrame
    end
  end,

  ["Disable"] = function(self)
    self.background:Hide()
    self.frame:Disable()
  end,

  ["Enable"] = function(self)
    self.background:Show()
    self.frame:Enable()
  end,

  ["Pick"] = function(self)
    self.frame:LockHighlight()
  end,

  ["ClearPick"] = function(self)
    self.frame:UnlockHighlight()
  end,

  ["SetIndex"] = function(self, index)
    self.index = index
  end,

  ["SetTitle"] = function(self, title)
    self.titletext = title
    self.title:SetText(title)
  end,
}

local function Constructor()
  local name = "MDTSpellButton"..AceGUI:GetNextWidgetNum(Type)
  local button = CreateFrame("BUTTON", name, UIParent, "OptionsListButtonTemplate")
  button:SetHeight(height)
  button:SetWidth(width)
  button.dgroup = nil
  button.data = {}

  local background = button:CreateTexture(nil, "BACKGROUND", nil, 0)
  button.background = background
  background:SetTexture("Interface\\BUTTONS\\UI-Listbox-Highlight2.blp")
  background:SetBlendMode("ADD")
  background:SetVertexColor(0.5, 0.5, 0.5, 0.25)
  background:SetPoint("TOP", button, "TOP")
  background:SetPoint("BOTTOM", button, "BOTTOM")
  background:SetPoint("LEFT", button, "LEFT")
  background:SetPoint("RIGHT", button, "RIGHT")

  local icon = button:CreateTexture(nil, "OVERLAY", nil, 0)
  button.icon = icon
  icon:SetWidth(height)
  icon:SetHeight(height)
  icon:SetPoint("LEFT", button, "LEFT", 3, 0)

  local title = button:CreateFontString(nil, "OVERLAY", "GameFontNormal")
  button.title = title
  title:SetHeight(14)
  title:SetJustifyH("LEFT")
  title:SetPoint("TOP", button, "TOP", 0, -2)
  title:SetPoint("LEFT", icon, "RIGHT", 2, 0)
  title:SetPoint("RIGHT", button, "RIGHT", -2, 0)

  local interruptibleIcon = CreateStatusIcon(button, statusAtlases.interruptible)
  button.interruptibleIcon = interruptibleIcon

  local magicIcon = CreateStatusIcon(button, statusAtlases.magic)
  button.magicIcon = magicIcon

  local poisonIcon = CreateStatusIcon(button, statusAtlases.poison)
  button.poisonIcon = poisonIcon

  local diseaseIcon = CreateStatusIcon(button, statusAtlases.disease)
  button.diseaseIcon = diseaseIcon

  local curseIcon = CreateStatusIcon(button, statusAtlases.curse)
  button.curseIcon = curseIcon

  local bleedIcon = CreateStatusIcon(button, statusAtlases.bleed)
  button.bleedIcon = bleedIcon

  local enrageIcon = CreateStatusIcon(button, statusAtlases.enrage)
  button.enrageIcon = enrageIcon

  button.description = {}

  button:SetScript("OnEnter", function() end)
  button:SetScript("OnLeave", function() end)

  local widget = {
    frame = button,
    title = title,
    icon = icon,
    interruptibleIcon = interruptibleIcon,
    magicIcon = magicIcon,
    poisonIcon = poisonIcon,
    diseaseIcon = diseaseIcon,
    curseIcon = curseIcon,
    bleedIcon = bleedIcon,
    enrageIcon = enrageIcon,
    background = background,
    type = Type
  }
  for method, func in pairs(methods) do
    ---@diagnostic disable-next-line: assign-type-mismatch
    widget[method] = func
  end

  return AceGUI:RegisterAsWidget(widget)
end

AceGUI:RegisterWidgetType(Type, Constructor, Version)
