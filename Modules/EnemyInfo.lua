local MDT = MDT
local L = MDT.L
local AceGUI = LibStub("AceGUI-3.0")
local db
local tconcat, tinsert = table.concat, table.insert
--test
local function CreateDispatcher(argCount)
  local code = [[
        local xpcall, eh = ...
        local method, ARGS
        local function call() return method(ARGS) end

        local function dispatch(func, ...)
            method = func
            if not method then return end
            ARGS = ...
            return xpcall(call, eh)
        end

        return dispatch
    ]]

  local ARGS = {}
  for i = 1, argCount do ARGS[i] = "arg"..i end
  code = code:gsub("ARGS", tconcat(ARGS, ", "))
  return assert(loadstring(code, "safecall Dispatcher["..argCount.."]"))(xpcall, errorhandler)
end

local Dispatchers = setmetatable({}, {
  __index = function(self, argCount)
    local dispatcher = CreateDispatcher(argCount)
    rawset(self, argCount, dispatcher)
    return dispatcher
  end
})
Dispatchers[0] = function(func)
  return xpcall(func, errorhandler)
end

local function safecall(func, ...)
  return Dispatchers[select("#", ...)](func, ...)
end

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
  safecall(content.obj.LayoutFinished, content.obj, nil, nil)
end)

-- Very simple Layout, Children are stacked on top of each other down the left side
AceGUI:RegisterLayout("ListWithHidden", function(content, children)
  local filteredChildren = {}
  for i = 1, #children do
    local child = children[i]
    if not child.hidden then
      tinsert(filteredChildren, child)
    else
      local frame = child.frame
      frame:ClearAllPoints()
      frame:Hide()
    end
  end
  AceGUI:GetLayout("List")(content, filteredChildren)
end)

local currentTab = "tab1"
local function MakeEnemeyInfoFrame()
  --frame
  local f = AceGUI:Create("Frame")
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

  --tabGroup
  f.tabGroup = AceGUI:Create("TabGroup")
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
    local leftContainer = AceGUI:Create("SimpleGroup")
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
    f.enemyDropDown = AceGUI:Create("Dropdown")
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
    f.modelContainer = f.modelContainer or AceGUI:Create("InlineGroup")
    local modelContainer = f.modelContainer
    if not modelContainer.frame.SetBackdrop then
      Mixin(modelContainer.frame, BackdropTemplateMixin)
    end
    modelContainer.frame:SetBackdropColor(1, 1, 1, 0)
    modelContainer:SetWidth(leftContainer.frame:GetWidth() - 20)
    modelContainer:SetHeight(249)
    modelContainer:SetLayout("Flow")
    f.modelDummyIcon = f.modelDummyIcon or AceGUI:Create("Icon")
    local modelDummyIcon = f.modelDummyIcon
    modelDummyIcon:SetImageSize(leftContainer.frame:GetWidth() - 20, 249)
    modelDummyIcon:SetDisabled(true)
    modelContainer:AddChild(modelDummyIcon)
    model:ClearAllPoints()
    model:SetPoint("BOTTOM", modelContainer.frame, "BOTTOM", 0, 10)
    MDT:FixAceGUIShowHide(model, modelContainer.frame, true)

    f.characteristicsContainer = AceGUI:Create("InlineGroup")
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
    f.midContainer = f.midContainer or AceGUI:Create("SimpleGroup")
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
    local midDummyIcon = AceGUI:Create("Icon")
    midDummyIcon:SetImageSize(20, 20)
    midDummyIcon:SetHeight(enemyDropDown.frame:GetHeight())
    midDummyIcon:SetDisabled(true)
    midContainer:AddChild(midDummyIcon)

    f.enemyDataContainer = AceGUI:Create("InlineGroup")
    if not f.enemyDataContainer.frame.SetBackdrop then
      Mixin(f.enemyDataContainer.frame, BackdropTemplateMixin)
    end
    f.enemyDataContainer.frame:SetBackdropColor(1, 1, 1, 0)
    f.enemyDataContainer:SetWidth(leftContainer.frame:GetWidth() - 20)
    f.enemyDataContainer:SetHeight(235)
    f.enemyDataContainer:SetLayout("Flow")

    f.enemyDataContainer.nameEditBox = AceGUI:Create("EditBox")
    f.enemyDataContainer.nameEditBox:SetLabel(L["Enemy Info NPC Name"])
    f.enemyDataContainer.nameEditBox:DisableButton(true)
    f.enemyDataContainer.nameEditBox:SetCallback("OnTextChanged", function(self)
      self:SetText(self.defaultText)
    end)
    f.enemyDataContainer:AddChild(f.enemyDataContainer.nameEditBox)

    f.enemyDataContainer.idEditBox = AceGUI:Create("EditBox")
    f.enemyDataContainer.idEditBox:SetLabel(L["Enemy Info NPC Id"])
    f.enemyDataContainer.idEditBox:DisableButton(true)
    f.enemyDataContainer.idEditBox:SetCallback("OnTextChanged", function(self)
      self:SetText(self.defaultText)
    end)
    f.enemyDataContainer:AddChild(f.enemyDataContainer.idEditBox)

    f.enemyDataContainer.healthEditBox = AceGUI:Create("EditBox")
    f.enemyDataContainer.healthEditBox:SetLabel(" ") --has to be non empty for proper spacing, we set this later
    f.enemyDataContainer.healthEditBox:DisableButton(true)
    f.enemyDataContainer.healthEditBox:SetCallback("OnTextChanged", function(self)
      self:SetText(self.defaultText)
    end)
    f.enemyDataContainer:AddChild(f.enemyDataContainer.healthEditBox)

    f.enemyDataContainer.creatureTypeEditBox = AceGUI:Create("EditBox")
    f.enemyDataContainer.creatureTypeEditBox:SetLabel(L["Enemy Info NPC Creature Type"])
    f.enemyDataContainer.creatureTypeEditBox:DisableButton(true)
    f.enemyDataContainer.creatureTypeEditBox:SetCallback("OnTextChanged", function(self)
      self:SetText(self.defaultText)
    end)
    f.enemyDataContainer:AddChild(f.enemyDataContainer.creatureTypeEditBox)

    f.enemyDataContainer.levelEditBox = AceGUI:Create("EditBox")
    f.enemyDataContainer.levelEditBox:SetLabel(L["Enemy Info NPC Level"])
    f.enemyDataContainer.levelEditBox:DisableButton(true)
    f.enemyDataContainer.levelEditBox:SetCallback("OnTextChanged", function(self)
      self:SetText(self.defaultText)
    end)
    f.enemyDataContainer:AddChild(f.enemyDataContainer.levelEditBox)

    f.enemyDataContainer.countEditBox = AceGUI:Create("EditBox")
    f.enemyDataContainer.countEditBox:SetLabel(L["Enemy Info NPC Enemy Forces"])
    f.enemyDataContainer.countEditBox:DisableButton(true)
    f.enemyDataContainer.countEditBox:SetCallback("OnTextChanged", function(self)
      self:SetText(self.defaultText)
    end)
    f.enemyDataContainer:AddChild(f.enemyDataContainer.countEditBox)

    f.enemyDataContainer.teemingCountEditBox = AceGUI:Create("EditBox")
    f.enemyDataContainer.teemingCountEditBox:SetLabel(L["Enemy Info NPC Enemy Forces (Teeming)"])
    f.enemyDataContainer.teemingCountEditBox:DisableButton(true)
    f.enemyDataContainer.teemingCountEditBox:SetCallback("OnTextChanged", function(self)
      self:SetText(self.defaultText)
    end)
    f.enemyDataContainer:AddChild(f.enemyDataContainer.teemingCountEditBox)

    f.enemyDataContainer.stealthCheckBox = AceGUI:Create("CheckBox")
    f.enemyDataContainer.stealthCheckBox:SetLabel(L["Enemy Info NPC Stealth"])
    f.enemyDataContainer.stealthCheckBox:SetWidth((f.enemyDataContainer.frame:GetWidth() / 2) - 40)
    f.enemyDataContainer.stealthCheckBox:SetCallback("OnValueChanged", function(self)
      self:SetValue(self.defaultValue)
    end)
    f.enemyDataContainer:AddChild(f.enemyDataContainer.stealthCheckBox)

    f.enemyDataContainer.stealthDetectCheckBox = AceGUI:Create("CheckBox")
    f.enemyDataContainer.stealthDetectCheckBox:SetLabel(L["Enemy Info NPC Stealth Detect"])
    f.enemyDataContainer.stealthDetectCheckBox:SetWidth((f.enemyDataContainer.frame:GetWidth() / 2))
    f.enemyDataContainer.stealthDetectCheckBox:SetCallback("OnValueChanged", function(self)
      self:SetValue(self.defaultValue)
    end)
    f.enemyDataContainer:AddChild(f.enemyDataContainer.stealthDetectCheckBox)


    midContainer:AddChild(f.enemyDataContainer)

    ---RIGHT
    f.rightContainer = f.rightContainer or AceGUI:Create("SimpleGroup")
    local rightContainer = f.rightContainer
    if not rightContainer.frame.SetBackdrop then
      Mixin(rightContainer.frame, BackdropTemplateMixin)
    end
    --Temporary Fix: backdrop frame level is set to 10000 normally
    --rightContainer.frame.backdrop:SetFrameLevel(1)
    rightContainer.frame:SetBackdropColor(1, 1, 1, 0)
    rightContainer:SetLayout("ListWithHidden")
    rightContainer:SetWidth(container.frame:GetWidth() / 3)
    rightContainer:SetHeight(container.frame:GetHeight())

    if db.devMode then
      local devModeLabel = AceGUI:Create("Label")
      devModeLabel:SetText("R: Delete\nI: Toggle Interruptible\nS: Print SpellId")
      rightContainer:AddChild(devModeLabel)
    end

    --spacing
    local rightDummyIcon = AceGUI:Create("Icon")
    rightDummyIcon:SetImageSize(20, 20)
    rightDummyIcon:SetHeight(enemyDropDown.frame:GetHeight())
    rightDummyIcon:SetDisabled(true)

    --spells
    f.spellScrollContainer = f.spellScrollContainer or AceGUI:Create("InlineGroup")
    local spellScrollContainer = f.spellScrollContainer
    if not spellScrollContainer.frame.SetBackdrop then
      Mixin(spellScrollContainer.frame, BackdropTemplateMixin)
    end
    spellScrollContainer.frame:SetBackdropColor(1, 1, 1, 0)
    spellScrollContainer:SetWidth(leftContainer.frame:GetWidth() - 20)
    spellScrollContainer:SetHeight(282)
    spellScrollContainer:SetLayout("Fill")

    f.spellScroll = AceGUI:Create("ScrollFrame")
    f.spellScroll:SetLayout("List")
    spellScrollContainer:AddChild(f.spellScroll)

    --powers
    f.powerScrollContainer = f.powerScrollContainer or AceGUI:Create("InlineGroup")
    local powerScrollContainer = f.powerScrollContainer
    if not powerScrollContainer.frame.SetBackdrop then
      Mixin(powerScrollContainer.frame, BackdropTemplateMixin)
    end
    powerScrollContainer.frame:SetBackdropColor(1, 1, 1, 0)
    powerScrollContainer:SetWidth(leftContainer.frame:GetWidth() - 20)
    powerScrollContainer:SetHeight(141)
    powerScrollContainer:SetLayout("Fill")

    f.powerScroll = AceGUI:Create("ScrollFrame")
    f.powerScroll:SetLayout("List")
    powerScrollContainer:AddChild(f.powerScroll)
    powerScrollContainer.hidden = true

    --spellButtons
    f.spellButtonsContainer = f.spellButtonsContainer or AceGUI:Create("InlineGroup")
    local spellButtonsContainer = f.spellButtonsContainer
    if not spellButtonsContainer.frame.SetBackdrop then
      Mixin(spellButtonsContainer.frame, BackdropTemplateMixin)
    end
    spellButtonsContainer.frame:SetBackdropColor(1, 1, 1, 0)
    spellButtonsContainer:SetWidth(leftContainer.frame:GetWidth() - 20)
    spellScrollContainer:SetLayout("Flow")

    local buttonWidth = 110
    f.sendSpellsButton = f.sendSpellsButton or AceGUI:Create("Button")
    local sendSpellsButton = f.sendSpellsButton
    sendSpellsButton:SetText(L["Link Spells"])
    sendSpellsButton:SetWidth(buttonWidth)
    sendSpellsButton:SetCallback("OnClick", function()
      if #f.spellScroll.children < 1 then return end
      local distribution = (UnitInRaid("player") and "RAID") or (IsInGroup() and "PARTY")
      if not distribution then return end
      local enemyName = f.enemyDropDown.text:GetText()
      SendChatMessage(string.format(L["MDT: Spells for %s:"], enemyName), distribution)
      for i, child in pairs(f.spellScroll.children) do
        local link = GetSpellLink(child.spellId)
        SendChatMessage(i..". "..link, distribution)
      end
    end)
    spellButtonsContainer:AddChild(sendSpellsButton)

    rightContainer:AddChild(rightDummyIcon)
    rightContainer:AddChild(spellScrollContainer)
    rightContainer:AddChild(powerScrollContainer)
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
local spellBlacklist = {
  [277564] = true, --Regenerative Blood
  [277247] = true, --Regenerative Blood
  [277242] = true, --Infested
  [209859] = true, --Bolster
  [233490] = true, --UA
  [91021]  = true, --Find Weakness
  [2094]   = true, --Blind
  [273836] = true, --Filthy Transfusion
  [205708] = true, --Chilled
  [212792] = true, --Cone of Cold
  [48181]  = true, --Haunt
  [191380] = true, --Mark of the Distant Army
  [236299] = true, --Chrono Shift
  [1490]   = true, --Chaos Brand
  [205276] = true, --Phantom Singularity
  [132951] = true, --Flare
  [255228] = true, --Polymorphed
  [122]    = true, --Frost Nova
  [12654]  = true, --Ignite
  [2818]   = true, --Deadly Poison
  [55095]  = true, --Frost Fever
  [408]    = true, --Kidney Shot
  [34914]  = true, --Vampiric Touch
  [205369] = true, --Mind Bomb
  [154953] = true, --Internal Bleeding
  [51490]  = true, --Thunderstorm
  [3409]   = true, --Crippling Poison
  [272970] = true, --Packed Ice
  [262115] = true, --Deep Wounds
  [226943] = true, --Mind Bomb
  [198813] = true, --Vengeful Retreat
  [121308] = true, --Disguise
  [224729] = true, --Bursting Shot
  [186439] = true, --Shadow Mend
  [113746] = true, --Mystic Touch
  [280404] = true, --Tidal Surge
  [589]    = true, --Shadow Word: Pain
  [5116]   = true, --Concussive Shot
  [288865] = true, --Meerahs Jukebox
  [317898] = true, --Blinding Sleet
  [334882] = true, --
  [201657] = true, --
  [320297] = true, --
  [325748] = true, --
  [326868] = true, --
  [132466] = true, --
  [344991] = true, --
  [320785] = true, --
  [335072] = true, --
  [1604]   = true, --
  [35079]  = true, --
  [50707]  = true, --
  [240443] = true, --
  [328506] = true, --
  [343502] = true, -- inspiring presence
  [344663] = true, -- shattered psyche
  [176039] = true, -- flametongue
  [176033] = true, -- flametongue
  [176031] = true, -- flametongue
  [213405] = true, -- dh stuff
  [391191] = true, -- dh stuff
  [390181] = true, -- dh stuff
  [228318] = true, -- enrage
  [374557] = true, -- brittle
  [387096] = true, -- pyrogenics
  --[X]  = true,
}
local lastEnemyIdx
function MDT:GetEnemyInfoEnemyIdx()
  return lastEnemyIdx
end

function MDT:GetEnemyInfoSpellBlacklist()
  return spellBlacklist
end

function MDT:UpdateEnemyInfoFrame(enemyIdx)
  if not enemyIdx then enemyIdx = lastEnemyIdx end
  lastEnemyIdx = enemyIdx
  if not enemyIdx then return end
  local data = MDT.dungeonEnemies[db.currentDungeonIdx][enemyIdx]
  if not data then return end
  local f = MDT.EnemyInfoFrame
  f:SetTitle(L[data.name])
  f.model:SetDisplayInfo(data.displayId or 39490)
  if MDT:IsDragonflight() then
    f.model:ResetModel()
  end
  if data.modelPosition then
    f.model:SetPosition(unpack(data.modelPosition))
  else
    f.model:SetPosition(0, 0, 0)
  end

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
  f.powerScrollContainer:SetWidth(math.min(f.leftContainer.frame:GetWidth() - 20, 248))

  local enemies = {}
  for mobIdx, edata in ipairs(MDT.dungeonEnemies[db.currentDungeonIdx]) do
    tinsert(enemies, mobIdx, L[edata.name])
  end
  f.enemyDropDown:SetList(enemies)
  f.enemyDropDown:SetValue(enemyIdx)

  --characteristics
  f.characteristicsContainer:ReleaseChildren()
  local characteristicsText = AceGUI:Create("Label")
  characteristicsText:SetWidth(f.characteristicsContainer.frame:GetWidth())
  characteristicsText:SetText(L["Affected by:"])
  f.characteristicsContainer:AddChild(characteristicsText)
  for text, iconPath in pairs(characteristics) do
    if data.characteristics and data.characteristics[text] then
      local icon = AceGUI:Create("Icon")
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
      if IsAddOnLoaded("AddOnSkins") then
        if AddOnSkins then
          local AS = unpack(AddOnSkins)
          AS:SkinTexture(icon.image)
        end
      end
    end
  end

  MDT:UpdateEnemyInfoData(enemyIdx)

  --ace is finicky
  f.rightContainer:PauseLayout()
  if data.powers then
    f.spellScrollContainer:SetHeight(181)
    f.powerScrollContainer.hidden = false
  else
    f.spellScrollContainer:SetHeight(322)
    f.powerScrollContainer.hidden = true
  end
  f.spellScrollContainer:SetLayout("Fill")

  --spells
  f.spellScroll:ReleaseChildren()
  if data.spells then
    for spellId, spellData in pairs(data.spells) do
      if MDT:GetDB().devMode or not spellBlacklist[spellId] then
        ---@diagnostic disable-next-line: param-type-mismatch
        local spellButton = AceGUI:Create("MDTSpellButton")
        spellButton:SetSpell(spellId, spellData)
        spellButton:Initialize()
        spellButton:Enable()
        f.spellScroll:AddChild(spellButton)
      end
    end
  end

  --powers
  f.powerScroll:ReleaseChildren()
  if data.powers then
    for powerSpellId, powerData in pairs(data.powers) do
      ---@diagnostic disable-next-line: param-type-mismatch
      local powerButton = AceGUI:Create("MDTPowerButton")
      powerButton:SetSpell(powerSpellId, powerData)
      powerButton:Initialize()
      powerButton:Enable()
      f.powerScroll:AddChild(powerButton)
    end
  end

  f.rightContainer:SetHeight(container.frame:GetHeight())
  f.rightContainer:ResumeLayout()
  f.rightContainer:DoLayout()
end

function MDT:UpdateEnemyInfoData(enemyIdx)
  local f = MDT.EnemyInfoFrame
  if not enemyIdx then enemyIdx = lastEnemyIdx end
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
  f.enemyDataContainer.countEditBox:SetText(data.count)
  f.enemyDataContainer.countEditBox.defaultText = data.count
  if not data.teemingCount then
    f.enemyDataContainer.teemingCountEditBox.frame:Hide()
  else
    f.enemyDataContainer.teemingCountEditBox.frame:Show()
    f.enemyDataContainer.teemingCountEditBox:SetText(data.teemingCount)
    f.enemyDataContainer.teemingCountEditBox.defaultText = data.teemingCount
  end
  f.enemyDataContainer.stealthCheckBox:SetValue(data.stealth)
  f.enemyDataContainer.stealthCheckBox.defaultValue = data.stealth
  f.enemyDataContainer.stealthDetectCheckBox:SetValue(data.stealthDetect)
  f.enemyDataContainer.stealthDetectCheckBox.defaultValue = data.stealthDetect

  local level = db.currentDifficulty
  local fortifiedTyrannical = MDT:IsCurrentPresetFortified() and L["Fortified"] or L["Tyrannical"]
  f.enemyDataContainer.healthEditBox:SetLabel(string.format(L["Enemy Info NPC Health"], level, fortifiedTyrannical))
end

function MDT:ShowEnemyInfoFrame(blip)
  db = MDT:GetDB()
  MDT.EnemyInfoFrame = MDT.EnemyInfoFrame or MakeEnemeyInfoFrame()
  MDT:UpdateEnemyInfoFrame(blip.enemyIdx)
  MDT.EnemyInfoFrame:Show()
end
