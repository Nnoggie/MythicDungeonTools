local MDT = MDT
local AceGUI = LibStub("AceGUI-3.0")
local db
local L = MDT.L

-- The idea here is to redo the dungeon select dropdown to be more user friendly.
-- This was necesarry as the old implementation did not allow for a dungeon to be part of multiple dungeon sets.
-- Additional dungeon lists just need to be added to seasonList and dungeonSelectionToIndex.

-- How to find the dungeon map files:
-- Add launch option "-console" to wow
-- Unsync your Config.wtf from wow servers: SET synchronizeConfig "0"
-- Add the following to the Config.wtf: SET ConsoleKey "F10" (or whatever key you want)
-- Go to character selection screen and press your console key
-- Run ExportInterfaceFiles art
-- Open the folder BlizzardInterfaceArt in VSCode and search for the dungeon name
-- To get names of dungeons: https://wow.tools/maps/ (search for dungeon name and then check the url)

local seasonListActive = false

MDT.seasonList = {}
MDT.dungeonSelectionToIndex = {}

do
  tinsert(MDT.seasonList, L["The War Within Season 1"])
  tinsert(MDT.dungeonSelectionToIndex, { 31, 35, 19, 110, 111, 112, 113, 114 })
end

local seasonList = MDT.seasonList
local dungeonSelectionToIndex = MDT.dungeonSelectionToIndex

function MDT:GetSeasonList()
  return seasonList
end

local indexToDungeonSelection = {}
local dungeonSelectionToNames = {}

local dungeonButtons = {}
local BUTTON_SIZE = 40

function MDT:UpdateDungeonDropDown()
  local dungeonDropdown = MDT.main_frame.DungeonSelectionGroup.DungeonDropdown
  local sublevelDropdown = MDT.main_frame.DungeonSelectionGroup.SublevelDropdown
  local currentDungeonIdx = db.currentDungeonIdx
  local index = math.min(#dungeonSelectionToIndex, db.selectedDungeonList)
  db.selectedDungeonList = index
  dungeonDropdown:SetList(dungeonSelectionToNames[db.selectedDungeonList])
  dungeonDropdown:SetValue(indexToDungeonSelection[db.selectedDungeonList][currentDungeonIdx])
  dungeonDropdown:ClearFocus()
  local sublevels = MDT.dungeonSubLevels[currentDungeonIdx]
  sublevelDropdown:SetList(sublevels)
  sublevelDropdown:SetValue(db.presets[currentDungeonIdx][db.currentPreset[currentDungeonIdx]].value.currentSublevel)
  sublevelDropdown:ClearFocus()
  local group = MDT.main_frame.DungeonSelectionGroup
  --dirty hack
  if #sublevels == 1 then
    group.children[2] = nil
    group:SetHeight(25)
    sublevelDropdown.frame:Hide()
  else
    group.children[2] = sublevelDropdown
    group:SetHeight(50)
    sublevelDropdown.frame:Show()
  end


  -- TODO: don't think we can do any of this during combat, need to find a solution for that
  -- if InCombatLockdown() then q up creation and return

  local currentList = dungeonSelectionToIndex[db.selectedDungeonList]
  for idx, dungeonIdx in ipairs(currentList) do
    local button = dungeonButtons[dungeonIdx]
    if not button then
      dungeonButtons[dungeonIdx] = CreateFrame("Button", "MDTDungeonButton"..idx, MDT.main_frame, "SecureActionButtonTemplate")
      button = dungeonButtons[dungeonIdx]
      button:SetSize(BUTTON_SIZE, BUTTON_SIZE)
      button:ClearAllPoints()
      button:SetPoint("TOPLEFT", MDT.main_frame, "TOPLEFT", (idx - 1) * (BUTTON_SIZE - 1), 0)
      button.texture = button:CreateTexture()
      button.texture:SetAllPoints(button)
      button.texture:Show()
      button.highlightTexture = button:CreateTexture()
      button:SetHighlightTexture(button.highlightTexture)
      button.highlightTexture:SetAtlas("bags-innerglow")
      button.shortText = button:CreateFontString(nil, "OVERLAY", "GameFontNormal")
      button.shortText:SetPoint("BOTTOM", button, "BOTTOM", 0, 2)
      button.shortText:SetFont(button.shortText:GetFont(), 11, "OUTLINE")
      button.shortText:SetTextColor(1, 1, 1)
      button:SetScript("OnLeave", function()
        GameTooltip:Hide()
      end)
    end
    local mapInfo = MDT.mapInfo[dungeonIdx]
    button.texture:SetTexture(C_Spell.GetSpellTexture(mapInfo.teleportId))
    button.shortText:SetText(mapInfo.shortName)
    button:SetAttribute("type1", "macro")
    button:SetAttribute("macrotext1", "/run MDT:UpdateToDungeon("..dungeonIdx..")")
    button:SetAttribute("type2", db.enableDungeonTeleport and "spell" or nil)
    button:SetAttribute("spell2", mapInfo.teleportId)
    button:SetAttribute("unit", "player")
    button:RegisterForClicks("LeftButtonUp", "LeftButtonDown", "RightButtonUp", "RightButtonDown")
    button:Show()
    button:SetFrameStrata("HIGH")
    button:SetFrameLevel(50)
    button:SetScript("OnEnter", function()
      GameTooltip:SetOwner(dungeonButtons[currentList[1]], "ANCHOR_BOTTOMRIGHT", -dungeonButtons[currentList[1]]:GetWidth(), 0) -- dungeonButtons[1]:GetWidth() + 3
      GameTooltip:AddLine(MDT.dungeonList[dungeonIdx], 1, 1, 1)
      GameTooltip:Show()
    end)
  end

  -- for idx, dungeonIdx in pairs(dungeonButtons) do
  --   if not tContains(currentList, idx) then
  --     dungeonIdx:Hide()
  --   end
  -- end
end

---CreateDungeonSelectDropdown
---Creates both dungeon and sublevel dropdowns
function MDT:CreateDungeonSelectDropdown(frame)
  db = MDT:GetDB()
  --Simple Group to hold both dropdowns
  frame.DungeonSelectionGroup = AceGUI:Create("SimpleGroup")
  frame.DungeonSelectionGroup.frame:SetParent(frame)
  local group = frame.DungeonSelectionGroup
  group.frame:Hide()
  if not group.frame.SetBackdrop then
    Mixin(group.frame, BackdropTemplateMixin)
  end
  group.frame:SetBackdropColor(unpack(MDT.BackdropColor))
  group.frame:SetFrameStrata("HIGH")
  group.frame:SetFrameLevel(50)
  group:SetWidth(204) --idk ace added weird margin on left
  group:SetHeight(50)
  group:SetPoint("TOPRIGHT", frame.topPanel, "BOTTOMRIGHT", 0, 2)
  group:SetLayout("List")
  MDT:FixAceGUIShowHide(group)

  group.DungeonDropdown = AceGUI:Create("Dropdown")
  group.DungeonDropdown.pullout.frame:SetParent(group.DungeonDropdown.frame)
  group.DungeonDropdown.text:SetJustifyH("LEFT")
  group.DungeonDropdown:SetCallback("OnValueChanged", function(widget, callbackName, key)
    if (seasonListActive) then
      -- make sure we don't go out of bounds
      -- this probably happens if dropdown is being spammed (?)
      local index = math.min(#dungeonSelectionToIndex, key)
      db.selectedDungeonList = index
      MDT:UpdateDungeonDropDown()
      seasonListActive = false
      local currentList = dungeonSelectionToIndex[db.selectedDungeonList]
      MDT:UpdateToDungeon(currentList[1])
      C_Timer.After(0.1, function()
        group.DungeonDropdown.button:Click()
      end)
    else
      local currentList = dungeonSelectionToIndex[db.selectedDungeonList]
      -- "> More Dungeons" is only added to the name list, so checking here works
      if #currentList + 1 == key then
        -- value has to be set to nil here, otherwise the dropdown will inherit the selected index
        -- from the previous list and could highlight the season at the given index, making it unselectable
        group.DungeonDropdown.value = nil
        group.DungeonDropdown:SetList(seasonList)
        seasonListActive = true
        --need to delay opening the dropdown until the list is populated
        C_Timer.After(0.05, function()
          group.DungeonDropdown.button:Click()
        end)
      else
        MDT:UpdateToDungeon(currentList[key])
      end
    end
  end)
  group:AddChild(group.DungeonDropdown)

  --sublevel select
  group.SublevelDropdown = AceGUI:Create("Dropdown")
  group.SublevelDropdown.pullout.frame:SetParent(group.SublevelDropdown.frame)
  group.SublevelDropdown.text:SetJustifyH("LEFT")
  group.SublevelDropdown:SetCallback("OnValueChanged", function(widget, callbackName, key)
    db.presets[db.currentDungeonIdx][db.currentPreset[db.currentDungeonIdx]].value.currentSublevel = key
    MDT:UpdateMap()
  end)
  group:AddChild(group.SublevelDropdown)

  --create lists
  for i = 1, #dungeonSelectionToIndex do
    dungeonSelectionToNames[i] = {}
    indexToDungeonSelection[i] = {}
    for j = 1, #dungeonSelectionToIndex[i] do
      dungeonSelectionToNames[i][j] = MDT.dungeonList[dungeonSelectionToIndex[i][j]]
      indexToDungeonSelection[i][dungeonSelectionToIndex[i][j]] = j
    end
    if #MDT.seasonList > 1 then
      dungeonSelectionToNames[i][#dungeonSelectionToIndex[i] + 1] = L["> More Dungeons"]
    end
  end

  MDT:UpdateDungeonDropDown()
end

function MDT:FixDungeonDropDownList()
  local valueToSet = indexToDungeonSelection[db.selectedDungeonList][db.currentDungeonIdx]
  if not valueToSet then
    -- dungeon not in selected list, find latest list that contains dungeon
    for i = #dungeonSelectionToIndex, 1, -1 do
      local list = dungeonSelectionToIndex[i]
      for _, dungeonIndex in pairs(list) do
        if dungeonIndex == db.currentDungeonIdx then
          db.selectedDungeonList = i
          MDT:UpdateDungeonDropDown()
          break
        end
      end
    end
  end
end

function MDT:CheckSeenDungeonLists()
  db = MDT:GetDB()
  local defaultSavedVars = MDT:GetDefaultSavedVariables().global
  local latestSeason = defaultSavedVars.selectedDungeonList
  local latestDungeon = defaultSavedVars.currentDungeonIdx
  if latestSeason > db.latestSeenDungeonList then
    db.latestSeenDungeonList = latestSeason
    db.selectedDungeonList = latestSeason
    db.currentDungeonIdx = latestDungeon
  end
end
