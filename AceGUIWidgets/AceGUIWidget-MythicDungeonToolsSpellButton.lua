local Type, Version = "MDTSpellButton", 1
local AceGUI = LibStub and LibStub("AceGUI-3.0", true)
local L = MDT.L
local width, height = 248, 32

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

      if self.interruptible then
        local interruptible = CreateTextureMarkup(
          "Interface\\EncounterJournal\\UI-EJ-Icons", 256, 64,
          24, 24,
          0.75, 0.875, 0, 0.5, 0, 0
        )..L["Interruptible"]
        GameTooltip:AddLine(interruptible)
      end
      if self.magic then
        local magic = CreateTextureMarkup(
          "Interface\\EncounterJournal\\UI-EJ-Icons", 256, 64,
          24, 24,
          0.875, 1.0, 0, 0.5, 0, 0
        )..L["Magic"]
        GameTooltip:AddLine(magic)
      end
      if self.poison then
        local poison = CreateTextureMarkup(
          "Interface\\EncounterJournal\\UI-EJ-Icons", 256, 64,
          24, 24,
          0.125, 0.25, 0.5, 1.0, 0, 0
        )..L["Poison"]
        GameTooltip:AddLine(poison)
      end
      if self.disease then
        local disease = CreateTextureMarkup(
          "Interface\\EncounterJournal\\UI-EJ-Icons", 256, 64,
          24, 24, 
          0.25, 0.375, 0.5, 1.0, 0, 0
        )..L["Disease"]
        GameTooltip:AddLine(disease)
      end
      if self.curse then
        local curse = CreateTextureMarkup(
          "Interface\\EncounterJournal\\UI-EJ-Icons", 256, 64,
          24, 24, 
          0, 0.125, 0.5, 1.0, 0, 0
        )..L["Curse"]
        GameTooltip:AddLine(curse)
      end
      if self.bleed then
        local bleed = CreateTextureMarkup(
          "Interface\\EncounterJournal\\UI-EJ-Icons", 256, 64,
          24, 24,
          0.625, 0.75, 0.5, 1.0, 0, 0
        )..L["Bleed"]
        GameTooltip:AddLine(bleed)
      end
      if self.enrage then
        local enrage = CreateTextureMarkup(
          "Interface\\EncounterJournal\\UI-EJ-Icons", 256, 64,
          24, 24,   
          0.375, 0.5, 0.5, 1.0, 0, 0
        )..L["Enrage"]
        GameTooltip:AddLine(enrage)
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

    self.interruptibleIcon:Hide()
    self.magicIcon:Hide()
    self.poisonIcon:Hide()
    self.diseaseIcon:Hide()
    self.curseIcon:Hide()
    self.bleedIcon:Hide()
    self.enrageIcon:Hide()

    local iconsToShow = {}
    if self.interruptible then
      table.insert(iconsToShow, self.interruptibleIcon)
    end
    if self.magic then
      table.insert(iconsToShow, self.magicIcon)
    end
    if self.poison then
      table.insert(iconsToShow, self.poisonIcon)
    end
    if self.disease then
      table.insert(iconsToShow, self.diseaseIcon)
    end
    if self.curse then
      table.insert(iconsToShow, self.curseIcon)
    end
    if self.bleed then
      table.insert(iconsToShow, self.bleedIcon)
    end
    if self.enrage then
      table.insert(iconsToShow, self.enrageIcon)
    end

    local prevIcon
    for i, iconFrame in ipairs(iconsToShow) do
      iconFrame:ClearAllPoints()
      if i == 1 then
        iconFrame:SetPoint("BOTTOMLEFT", self.frame, "BOTTOMLEFT", 33, -3)
      else
        iconFrame:SetPoint("LEFT", prevIcon, "RIGHT", -7, 0)
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

  local interruptibleIcon = button:CreateTexture(nil, "OVERLAY", nil, 0)
  button.interruptibleIcon = interruptibleIcon
  interruptibleIcon:SetSize(height * 0.7, height * 0.7)
  interruptibleIcon:SetTexture("Interface\\EncounterJournal\\UI-EJ-Icons")
  interruptibleIcon:SetTexCoord(0.75, 0, 0.75, 0.5, 0.875, 0, 0.875, 0.5)
  interruptibleIcon:Hide()

  local magicIcon = button:CreateTexture(nil, "OVERLAY", nil, 0)
  button.magicIcon = magicIcon
  magicIcon:SetSize(height * 0.7, height * 0.7)
  magicIcon:SetTexture("Interface\\EncounterJournal\\UI-EJ-Icons")
  magicIcon:SetTexCoord(0.875, 1.0, 0, 0.5)
  magicIcon:Hide()

  local poisonIcon = button:CreateTexture(nil, "OVERLAY", nil, 0)
  button.poisonIcon = poisonIcon
  poisonIcon:SetSize(height * 0.7, height * 0.7)
  poisonIcon:SetTexture("Interface\\EncounterJournal\\UI-EJ-Icons")
  poisonIcon:SetTexCoord(0.125, 0.25, 0.5, 1.0)
  poisonIcon:Hide()

  local diseaseIcon = button:CreateTexture(nil, "OVERLAY", nil, 0)
  button.diseaseIcon = diseaseIcon
  diseaseIcon:SetSize(height * 0.7, height * 0.7)
  diseaseIcon:SetTexture("Interface\\EncounterJournal\\UI-EJ-Icons")
  diseaseIcon:SetTexCoord(0.25, 0.375, 0.5, 1.0)
  diseaseIcon:Hide()

  local curseIcon = button:CreateTexture(nil, "OVERLAY", nil, 0)
  button.curseIcon = curseIcon
  curseIcon:SetSize(height * 0.7, height * 0.7)
  curseIcon:SetTexture("Interface\\EncounterJournal\\UI-EJ-Icons")
  curseIcon:SetTexCoord(0, 0.125, 0.5, 1.0)
  curseIcon:Hide()

  local bleedIcon = button:CreateTexture(nil, "OVERLAY", nil, 0)
  button.bleedIcon = bleedIcon
  bleedIcon:SetSize(height * 0.7, height * 0.7)
  bleedIcon:SetTexture("Interface\\EncounterJournal\\UI-EJ-Icons")
  bleedIcon:SetTexCoord(0.625, 0.75, 0.5, 1.0)
  bleedIcon:Hide()

  local enrageIcon = button:CreateTexture(nil, "OVERLAY", nil, 0)
  button.enrageIcon = enrageIcon
  enrageIcon:SetSize(height * 0.7, height * 0.7)
  enrageIcon:SetTexture("Interface\\EncounterJournal\\UI-EJ-Icons")
  enrageIcon:SetTexCoord(0.375, 0.5, 0.5, 1.0)
  enrageIcon:Hide()

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
