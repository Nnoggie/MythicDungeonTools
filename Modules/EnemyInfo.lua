local _, MDT = ...
local L = MDT.L
local AceGUI = LibStub("AceGUI-3.0")
local db
local tinsert = table.insert

AceGUI:RegisterLayout("ThreeColums", function(content, children)
  if children[1] then
    children[1]:SetWidth(content:GetWidth() / 3 - 10)
    children[1].frame:ClearAllPoints()
    children[1].frame:SetPoint("TOPLEFT", content, "TOPLEFT", 0, 0)
    children[1].frame:SetPoint("BOTTOMLEFT", content, "BOTTOMLEFT", 0, 0)
    children[1].frame:Show()
  end
  if children[2] then
    children[2]:SetWidth(content:GetWidth() / 3 - 10)
    children[2].frame:ClearAllPoints()
    children[2].frame:SetPoint("TOPLEFT", children[1].frame, "TOPRIGHT", 0, 0)
    children[2].frame:SetPoint("BOTTOMLEFT", children[1].frame, "BOTTOMRIGHT", 0, 0)
    children[2].frame:Show()
  end
  if children[3] then
    children[3]:SetWidth(content:GetWidth() / 3 - 10)
    children[3].frame:ClearAllPoints()
    children[3].frame:SetPoint("TOPLEFT", children[2].frame, "TOPRIGHT", 0, 0)
    children[3].frame:SetPoint("BOTTOMLEFT", children[2].frame, "BOTTOMRIGHT", 0, 0)
    children[3].frame:Show()
  end
  xpcall(content.obj.LayoutFinished, errorhandler, content.obj, nil, nil)
end)

local currentTab = "tab1"
local function MakeEnemeyInfoFrame()
  local f = MDT:CreateWidget("Frame")
  f.frame:SetParent(MDT.main_frame)
  f.frame:SetFrameStrata("DIALOG")
  MDT.enemyInfoFrame = f
  f:SetTitle(L["Enemy Info"])
  f:EnableResize(false)
  f.frame:SetMovable(false)
  function f.frame:StartMoving() end

  f:SetLayout("Fill")
  f:SetCallback("OnClose", function(widget)

  end)
  f.frame:ClearAllPoints()
  f.frame:SetAllPoints(MDTScrollFrame)

  local originalHide = MDT.main_frame.Hide
  function MDT.main_frame:Hide(...)
    f.frame:Hide()
    return originalHide(self, ...);
  end

  f.tabGroup = MDT:CreateWidget("TabGroup")
  local tabGroup = f.tabGroup
  tabGroup:SetTabs(
    {
      { text = L["Enemy Info"], value = "tab1" },
      --{text="Damage Calc", value="tab2"},
    }
  )
  tabGroup:SetLayout("ThreeColums")
  f:AddChild(tabGroup)

  --EnemyInfo
  local function DrawGroup1(container)
    ---LEFT
    local leftContainer = MDT:CreateWidget("SimpleGroup")
    f.leftContainer = leftContainer
    if not leftContainer.frame.SetBackdrop then
      Mixin(leftContainer.frame, BackdropTemplateMixin)
    end
    --Temporary Fix: backdrop frame level is set to 10000 normally
    --leftContainer.frame:GetBackdrop():SetFrameLevel(1)
    leftContainer.frame:SetBackdropColor(1, 1, 1, 0)
    leftContainer:SetLayout("List")
    leftContainer:SetWidth(container.frame:GetWidth() / 3)
    leftContainer:SetHeight(container.frame:GetHeight())

    --enemyDropDown
    f.enemyDropDown = MDT:CreateWidget("Dropdown")
    local enemyDropDown = f.enemyDropDown
    enemyDropDown:SetCallback("OnValueChanged", function(widget, callbackName, key)
      MDT:UpdateEnemyInfoFrame(key)
    end)

    --model
    f.model = f.model or CreateFrame("PlayerModel", nil, f.frame, "ModelWithControlsTemplate")
    local model = f.model
    model:SetFrameLevel(1)
    model:SetSize(leftContainer.frame:GetWidth() - 30, 269)
    model:SetScript("OnEnter", nil)
    model:SetFrameLevel(150)
    model:Show()
    f.modelContainer = f.modelContainer or MDT:CreateWidget("InlineGroup")
    local modelContainer = f.modelContainer
    if not modelContainer.frame.SetBackdrop then
      Mixin(modelContainer.frame, BackdropTemplateMixin)
    end
    modelContainer.frame:SetBackdropColor(1, 1, 1, 0)
    modelContainer:SetWidth(leftContainer.frame:GetWidth() - 20)
    modelContainer:SetHeight(249)
    modelContainer:SetLayout("Flow")
    f.modelDummyIcon = f.modelDummyIcon or MDT:CreateWidget("Icon")
    local modelDummyIcon = f.modelDummyIcon
    modelDummyIcon:SetImageSize(leftContainer.frame:GetWidth() - 20, 249)
    modelDummyIcon:SetDisabled(true)
    modelContainer:AddChild(modelDummyIcon)
    model:ClearAllPoints()
    model:SetPoint("BOTTOM", modelContainer.frame, "BOTTOM", 0, 10)
    MDT:FixAceGUIShowHide(model, modelContainer.frame, true)

    f.characteristicsContainer = MDT:CreateWidget("InlineGroup")
    if not f.characteristicsContainer.frame.SetBackdrop then
      Mixin(f.characteristicsContainer.frame, BackdropTemplateMixin)
    end
    f.characteristicsContainer.frame:SetBackdropColor(1, 1, 1, 0)
    f.characteristicsContainer:SetWidth(leftContainer.frame:GetWidth() - 20)
    f.characteristicsContainer:SetHeight(80)
    f.characteristicsContainer:SetLayout("Flow")

    leftContainer:AddChild(enemyDropDown)
    leftContainer:AddChild(modelContainer)
    leftContainer:AddChild(f.characteristicsContainer)

    ---MIDDLE
    f.midContainer = f.midContainer or MDT:CreateWidget("SimpleGroup")
    local midContainer = f.midContainer
    if not midContainer.frame.SetBackdrop then
      Mixin(midContainer.frame, BackdropTemplateMixin)
    end
    --Temporary Fix: backdrop frame level is set to 10000 normally
    --midContainer.frame.backdrop:SetFrameLevel(1)
    midContainer.frame:SetBackdropColor(1, 1, 1, 0)
    midContainer:SetLayout("List")
    midContainer:SetWidth(container.frame:GetWidth() / 3)
    midContainer:SetHeight(container.frame:GetHeight())

    --spacing
    local midDummyIcon = MDT:CreateWidget("Icon")
    midDummyIcon:SetImageSize(20, 20)
    midDummyIcon:SetHeight(enemyDropDown.frame:GetHeight())
    midDummyIcon:SetDisabled(true)
    midContainer:AddChild(midDummyIcon)

    f.enemyDataContainer = MDT:CreateWidget("InlineGroup")
    if not f.enemyDataContainer.frame.SetBackdrop then
      Mixin(f.enemyDataContainer.frame, BackdropTemplateMixin)
    end
    f.enemyDataContainer.frame:SetBackdropColor(1, 1, 1, 0)
    f.enemyDataContainer:SetWidth(leftContainer.frame:GetWidth() - 20)
    f.enemyDataContainer:SetHeight(235)
    f.enemyDataContainer:SetLayout("Flow")

    f.enemyDataContainer.nameEditBox = MDT:CreateWidget("EditBox")
    f.enemyDataContainer.nameEditBox:SetLabel(L["Enemy Info NPC Name"])
    f.enemyDataContainer.nameEditBox:DisableButton(true)
    f.enemyDataContainer.nameEditBox:SetCallback("OnTextChanged", function(self)
      self:SetText(self.defaultText)
    end)
    f.enemyDataContainer:AddChild(f.enemyDataContainer.nameEditBox)

    f.enemyDataContainer.idEditBox = MDT:CreateWidget("EditBox")
    f.enemyDataContainer.idEditBox:SetLabel(L["Enemy Info NPC Id"])
    f.enemyDataContainer.idEditBox:DisableButton(true)
    f.enemyDataContainer.idEditBox:SetCallback("OnTextChanged", function(self)
      self:SetText(self.defaultText)
    end)
    f.enemyDataContainer:AddChild(f.enemyDataContainer.idEditBox)

    f.enemyDataContainer.healthEditBox = MDT:CreateWidget("EditBox")
    f.enemyDataContainer.healthEditBox:SetLabel(" ") --has to be non empty for proper spacing, we set this later
    f.enemyDataContainer.healthEditBox:DisableButton(true)
    f.enemyDataContainer.healthEditBox:SetCallback("OnTextChanged", function(self)
      self:SetText(self.defaultText)
    end)
    f.enemyDataContainer:AddChild(f.enemyDataContainer.healthEditBox)

    f.enemyDataContainer.creatureTypeEditBox = MDT:CreateWidget("EditBox")
    f.enemyDataContainer.creatureTypeEditBox:SetLabel(L["Enemy Info NPC Creature Type"])
    f.enemyDataContainer.creatureTypeEditBox:DisableButton(true)
    f.enemyDataContainer.creatureTypeEditBox:SetCallback("OnTextChanged", function(self)
      self:SetText(self.defaultText)
    end)
    f.enemyDataContainer:AddChild(f.enemyDataContainer.creatureTypeEditBox)

    f.enemyDataContainer.levelEditBox = MDT:CreateWidget("EditBox")
    f.enemyDataContainer.levelEditBox:SetLabel(L["Enemy Info NPC Level"])
    f.enemyDataContainer.levelEditBox:DisableButton(true)
    f.enemyDataContainer.levelEditBox:SetCallback("OnTextChanged", function(self)
      self:SetText(self.defaultText)
    end)
    f.enemyDataContainer:AddChild(f.enemyDataContainer.levelEditBox)

    f.enemyDataContainer.countEditBox = MDT:CreateWidget("EditBox")
    f.enemyDataContainer.countEditBox:SetLabel(L["Enemy Info NPC Enemy Forces"])
    f.enemyDataContainer.countEditBox:DisableButton(true)
    f.enemyDataContainer.countEditBox:SetCallback("OnTextChanged", function(self)
      self:SetText(self.defaultText)
    end)
    f.enemyDataContainer:AddChild(f.enemyDataContainer.countEditBox)

    f.enemyDataContainer.stealthCheckBox = MDT:CreateWidget("CheckBox")
    f.enemyDataContainer.stealthCheckBox:SetLabel(L["Enemy Info NPC Stealth"])
    f.enemyDataContainer.stealthCheckBox:SetWidth((f.enemyDataContainer.frame:GetWidth() / 2) - 40)
    f.enemyDataContainer.stealthCheckBox:SetCallback("OnValueChanged", function(self)
      self:SetValue(self.defaultValue)
    end)
    f.enemyDataContainer:AddChild(f.enemyDataContainer.stealthCheckBox)

    f.enemyDataContainer.stealthDetectCheckBox = MDT:CreateWidget("CheckBox")
    f.enemyDataContainer.stealthDetectCheckBox:SetLabel(L["Enemy Info NPC Stealth Detect"])
    f.enemyDataContainer.stealthDetectCheckBox:SetWidth((f.enemyDataContainer.frame:GetWidth() / 2))
    f.enemyDataContainer.stealthDetectCheckBox:SetCallback("OnValueChanged", function(self)
      self:SetValue(self.defaultValue)
    end)
    f.enemyDataContainer:AddChild(f.enemyDataContainer.stealthDetectCheckBox)


    midContainer:AddChild(f.enemyDataContainer)

    ---RIGHT
    f.rightContainer = f.rightContainer or MDT:CreateWidget("SimpleGroup")
    local rightContainer = f.rightContainer
    if not rightContainer.frame.SetBackdrop then
      Mixin(rightContainer.frame, BackdropTemplateMixin)
    end
    --Temporary Fix: backdrop frame level is set to 10000 normally
    --rightContainer.frame.backdrop:SetFrameLevel(1)
    rightContainer.frame:SetBackdropColor(1, 1, 1, 0)
    rightContainer:SetLayout("List")
    rightContainer:SetWidth(container.frame:GetWidth() / 3)
    rightContainer:SetHeight(container.frame:GetHeight())

    if db.devMode then
      local devModeLabel = MDT:CreateWidget("Label")
      devModeLabel:SetText("R: Delete\nI: Toggle Interruptible\nS: Print SpellId")
      rightContainer:AddChild(devModeLabel)
    end

    --spacing
    local rightDummyIcon = MDT:CreateWidget("Icon")
    rightDummyIcon:SetImageSize(20, 20)
    rightDummyIcon:SetHeight(enemyDropDown.frame:GetHeight())
    rightDummyIcon:SetDisabled(true)

    --spells
    f.spellScrollContainer = f.spellScrollContainer or MDT:CreateWidget("InlineGroup")
    local spellScrollContainer = f.spellScrollContainer
    if not spellScrollContainer.frame.SetBackdrop then
      Mixin(spellScrollContainer.frame, BackdropTemplateMixin)
    end
    spellScrollContainer.frame:SetBackdropColor(1, 1, 1, 0)
    spellScrollContainer:SetWidth(leftContainer.frame:GetWidth() - 20)
    spellScrollContainer:SetHeight(282)
    spellScrollContainer:SetLayout("Fill")

    f.spellScroll = MDT:CreateWidget("ScrollFrame")
    f.spellScroll:SetLayout("List")
    spellScrollContainer:AddChild(f.spellScroll)

    --spellButtons
    f.spellButtonsContainer = f.spellButtonsContainer or MDT:CreateWidget("InlineGroup")
    local spellButtonsContainer = f.spellButtonsContainer
    if not spellButtonsContainer.frame.SetBackdrop then
      Mixin(spellButtonsContainer.frame, BackdropTemplateMixin)
    end
    spellButtonsContainer.frame:SetBackdropColor(1, 1, 1, 0)
    spellButtonsContainer:SetWidth(leftContainer.frame:GetWidth() - 20)
    spellScrollContainer:SetLayout("Flow")

    local buttonWidth = 110
    f.sendSpellsButton = f.sendSpellsButton or MDT:CreateWidget("Button")
    local sendSpellsButton = f.sendSpellsButton
    sendSpellsButton:SetText(L["Link Spells"])
    sendSpellsButton:SetWidth(buttonWidth)
    sendSpellsButton:SetCallback("OnClick", function()
      if #f.spellScroll.children < 1 then return end
      local distribution = (UnitInRaid("player") and "RAID") or (IsInGroup() and "PARTY")
      if not distribution then return end
      local enemyName = f.enemyDropDown.text:GetText()
      C_ChatInfo.SendChatMessage(string.format(L["MDT: Spells for %s:"], enemyName), distribution)
      for i, child in pairs(f.spellScroll.children) do
        local link = C_Spell.GetSpellLink(child.spellId)
        C_ChatInfo.SendChatMessage(i..". "..link, distribution)
      end
    end)
    spellButtonsContainer:AddChild(sendSpellsButton)

    rightContainer:AddChild(rightDummyIcon)
    rightContainer:AddChild(spellScrollContainer)
    rightContainer:AddChild(spellButtonsContainer)


    container:AddChild(leftContainer)
    container:AddChild(midContainer)
    container:AddChild(rightContainer)
  end

  --Damage Calc
  local function DrawGroup2(container)

  end

  -- Callback function for OnGroupSelected
  local function SelectGroup(container, event, group)
    container:ReleaseChildren()
    if group == "tab1" then
      DrawGroup1(container)
    elseif group == "tab2" then
      DrawGroup2(container)
    end
    currentTab = group
  end

  tabGroup:SetCallback("OnGroupSelected", SelectGroup)
  tabGroup:SelectTab(currentTab)

  return f
end

local characteristics = {
  ["Stun"] = "Interface\\ICONS\\spell_frost_stun",
  ["Sap"] = "Interface\\ICONS\\ability_sap",
  ["Incapacitate"] = "Interface\\ICONS\\ability_monk_paralysis",
  ["Repentance"] = "Interface\\ICONS\\spell_holy_prayerofhealing",
  ["Disorient"] = "Interface\\ICONS\\spell_shadow_mindsteal",
  ["Banish"] = "Interface\\ICONS\\spell_shadow_cripple",
  ["Fear"] = "Interface\\ICONS\\spell_shadow_possession",
  ["Root"] = "Interface\\ICONS\\spell_frost_frostnova",
  ["Polymorph"] = "Interface\\ICONS\\spell_nature_polymorph",
  ["Shackle Undead"] = "Interface\\ICONS\\spell_nature_slow",
  ["Mind Control"] = "Interface\\ICONS\\spell_shadow_shadowworddominate",
  ["Grip"] = "Interface\\ICONS\\spell_deathknight_strangulate",
  ["Knock"] = "Interface\\ICONS\\ability_druid_typhoon",
  ["Silence"] = "Interface\\ICONS\\ability_priest_silence",
  ["Taunt"] = "Interface\\ICONS\\spell_nature_reincarnation",
  ["Control Undead"] = "Interface\\ICONS\\inv_misc_bone_skull_01",
  ["Enslave Demon"] = "Interface\\ICONS\\spell_shadow_enslavedemon",
  ["Slow"] = "Interface\\ICONS\\ability_rogue_trip",
  ["Imprison"] = "Interface\\ICONS\\ability_demonhunter_imprison",
  ["Sleep Walk"] = "Interface\\ICONS\\ability_xavius_dreamsimulacrum",
  ["Scare Beast"] = "Interface\\ICONS\\ability_druid_cower",
  ["Hibernate"] = "Interface\\ICONS\\spell_nature_sleep",
  ["Turn Evil"] = "Interface\\ICONS\\ability_paladin_turnevil",
  ["Mind Soothe"] = "Interface\\ICONS\\spell_holy_mindsooth",
}
local lastEnemyIdx, lastCloneIdx
function MDT:GetEnemyInfoEnemyIdx()
  return lastEnemyIdx
end

function MDT:UpdateEnemyInfoFrame(enemyIdx, cloneIdx)
  if not enemyIdx then enemyIdx, cloneIdx = lastEnemyIdx, lastCloneIdx end
  lastEnemyIdx, lastCloneIdx = enemyIdx, cloneIdx
  if not enemyIdx then return end
  local data = MDT.dungeonEnemies[db.currentDungeonIdx][enemyIdx]
  if not data then return end
  local f = MDT.EnemyInfoFrame
  f:SetTitle(L[data.name])
  f.model:SetDisplayInfo(data.displayId or 39490)
  if f.model.ResetModel then f.model:ResetModel() end
  f.model:SetPosition(0, 0, 0)

  local container = f.tabGroup
  ---rescaling
  ---LEFT
  f.leftContainer:SetWidth(container.frame:GetWidth() / 3)
  f.leftContainer:SetHeight(container.frame:GetHeight())
  f.model:SetSize(f.leftContainer.frame:GetWidth() - 30, 1.127 * (f.leftContainer.frame:GetWidth() - 30))
  f.modelContainer:SetWidth(f.leftContainer.frame:GetWidth() - 20)
  f.modelDummyIcon:SetImageSize(f.leftContainer.frame:GetWidth() - 20, f.leftContainer.frame:GetWidth() - 20)
  f.characteristicsContainer:SetWidth(f.leftContainer.frame:GetWidth() - 20)
  ---MIDDLE
  f.midContainer:SetWidth(container.frame:GetWidth() / 3)
  f.midContainer:SetHeight(container.frame:GetHeight())
  f.enemyDataContainer:SetWidth(math.min(f.leftContainer.frame:GetWidth() - 20, 248))
  ---RIGHT
  f.rightContainer:SetWidth(container.frame:GetWidth() / 3)
  f.rightContainer:SetHeight(container.frame:GetHeight())
  f.spellScrollContainer:SetWidth(math.min(f.leftContainer.frame:GetWidth() - 20, 248))
  f.spellButtonsContainer:SetWidth(math.min(f.leftContainer.frame:GetWidth() - 20, 248))

  local enemies = {}
  for mobIdx, edata in ipairs(MDT.dungeonEnemies[db.currentDungeonIdx]) do
    tinsert(enemies, mobIdx, L[edata.name])
  end
  f.enemyDropDown:SetList(enemies)
  f.enemyDropDown:SetValue(enemyIdx)

  --characteristics
  f.characteristicsContainer:ReleaseChildren()
  local characteristicsText = MDT:CreateWidget("Label")
  characteristicsText:SetWidth(f.characteristicsContainer.frame:GetWidth())
  characteristicsText:SetText(L["Affected by:"])
  f.characteristicsContainer:AddChild(characteristicsText)
  for text, iconPath in pairs(characteristics) do
    if data.characteristics and data.characteristics[text] then
      local icon = MDT:CreateWidget("Icon")
      icon:SetImage(iconPath)
      icon:SetImageSize(25, 25)
      icon:SetWidth(25)
      icon:SetHeight(27)
      icon:SetCallback("OnEnter", function()
        GameTooltip:SetOwner(icon.frame, "ANCHOR_BOTTOM", 0, -5)
        GameTooltip:SetText(L[text], 1, 1, 1, 1)
        GameTooltip:Show()
      end)
      icon:SetCallback("OnLeave", function()
        GameTooltip:Hide()
      end)
      f.characteristicsContainer:AddChild(icon)
    end
  end

  MDT:UpdateEnemyInfoData(enemyIdx, cloneIdx)

  --ace is finicky
  f.rightContainer:PauseLayout()
  f.spellScrollContainer:SetHeight(322)
  f.spellScrollContainer:SetLayout("Fill")

  -- Spells
  f.spellScroll:ReleaseChildren()
  if data.spells then
    -- Create a table to store spell IDs
    local spellIds = {}
    -- Insert all spell IDs into the table
    for spellId in pairs(data.spells) do
      table.insert(spellIds, spellId)
    end
    -- Sort the spell IDs
    table.sort(spellIds) -- Sort in numerical order

    -- Create spell buttons in sorted order
    for _, spellId in ipairs(spellIds) do
      local spellData = data.spells[spellId]
      local spellButton = MDT:CreateWidget("MDTSpellButton")
      spellButton:SetSpell(spellId, spellData)
      spellButton:Initialize()
      spellButton:Enable()
      f.spellScroll:AddChild(spellButton)
    end
  end

  f.rightContainer:SetHeight(container.frame:GetHeight())
  f.rightContainer:ResumeLayout()
  f.rightContainer:DoLayout()
end

function MDT:UpdateEnemyInfoData(enemyIdx, cloneIdx)
  local f = MDT.EnemyInfoFrame
  if not enemyIdx then enemyIdx, cloneIdx = lastEnemyIdx, lastCloneIdx end
  if not enemyIdx then return end
  local data = MDT.dungeonEnemies[db.currentDungeonIdx][enemyIdx]
  --data
  f.enemyDataContainer.nameEditBox:SetText(L[data.name])
  f.enemyDataContainer.nameEditBox.defaultText = data.name
  f.enemyDataContainer.idEditBox:SetText(data.id)
  f.enemyDataContainer.idEditBox.defaultText = data.id

  local boss = data.isBoss or false
  local health = MDT:CalculateEnemyHealth(boss, data.health, db.currentDifficulty, data.ignoreFortified)
  local healthText = MDT:FormatEnemyHealth(health)

  f.enemyDataContainer.healthEditBox:SetText(healthText)
  f.enemyDataContainer.healthEditBox.defaultText = healthText

  f.enemyDataContainer.creatureTypeEditBox:SetText(L[data.creatureType])
  f.enemyDataContainer.creatureTypeEditBox.defaultText = data.creatureType
  f.enemyDataContainer.levelEditBox:SetText(data.level)
  f.enemyDataContainer.levelEditBox.defaultText = data.level
  local count = MDT:GetCloneEnemyForces(data, data.clones[cloneIdx])
  f.enemyDataContainer.countEditBox:SetText(count)
  f.enemyDataContainer.countEditBox.defaultText = count
  f.enemyDataContainer.stealthCheckBox:SetValue(data.stealth)
  f.enemyDataContainer.stealthCheckBox.defaultValue = data.stealth
  f.enemyDataContainer.stealthDetectCheckBox:SetValue(data.stealthDetect)
  f.enemyDataContainer.stealthDetectCheckBox.defaultValue = data.stealthDetect

  local level = db.currentDifficulty
  local healthLabel = string.format(L["Enemy Info NPC Health Level"], level)
  if level >= 10 then
    healthLabel = string.format(L["Enemy Info NPC Health"], level, L["Fortified"].."/"..L["Tyrannical"])
  end
  f.enemyDataContainer.healthEditBox:SetLabel(healthLabel)
end

function MDT:ShowEnemyInfoFrame(blip)
  db = MDT:GetDB()
  MDT.EnemyInfoFrame = MDT.EnemyInfoFrame or MakeEnemeyInfoFrame()
  MDT:UpdateEnemyInfoFrame(blip.enemyIdx, blip.cloneIdx)
  MDT.EnemyInfoFrame:Show()
end
