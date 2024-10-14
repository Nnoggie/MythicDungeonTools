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

local dungeonButtons = {}
local BUTTON_SIZE = 40

function MDT:UpdateDungeonDropDown()
  local currentList = dungeonSelectionToIndex[db.selectedDungeonList]
  for idx, dungeonIdx in ipairs(currentList) do
    local button = dungeonButtons[idx]
    if not button then
      dungeonButtons[idx] = CreateFrame("Button", "MDTDungeonButton"..idx, MDT.main_frame)
      button = dungeonButtons[idx]
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
    button.texture:SetTexture(mapInfo.iconId or C_Spell.GetSpellTexture(mapInfo.teleportId))
    button.shortText:SetText(mapInfo.shortName)
    button:SetScript("OnClick", function(self, button)
      MDT:UpdateToDungeon(dungeonIdx)
    end)
    button:RegisterForClicks("AnyDown", "AnyUp")
    button:Show()
    button:SetFrameStrata("HIGH")
    button:SetFrameLevel(50)
    button:SetScript("OnEnter", function()
      GameTooltip:SetOwner(dungeonButtons[idx], "ANCHOR_BOTTOMRIGHT", -dungeonButtons[idx]:GetWidth(), 0)
      GameTooltip:AddLine(MDT.dungeonList[dungeonIdx], 1, 1, 1)
      GameTooltip:Show()
    end)
  end
  for idx = #currentList + 1, #dungeonButtons do
    dungeonButtons[idx]:Hide()
  end
end

function MDT:CreateSeasonDropdown(frame)
  if #seasonList == 1 then
    -- no dropdown needed
    return
  end
  db = MDT:GetDB()
  frame.seasonSelectionGroup = AceGUI:Create("SimpleGroup")
  frame.seasonSelectionGroup.frame:SetParent(frame)
  local group = frame.seasonSelectionGroup
  group.frame:Hide()
  if not group.frame.SetBackdrop then
    Mixin(group.frame, BackdropTemplateMixin)
  end
  group.frame:SetBackdropColor(unpack(MDT.BackdropColor))
  group.frame:SetFrameStrata("HIGH")
  group.frame:SetFrameLevel(50)
  group:SetWidth(204) --idk ace added weird margin on left
  group:SetHeight(50)
  group:SetPoint("TOPLEFT", frame.topPanel, "TOPLEFT", 0, 0)
  group:SetLayout("List")
  MDT:FixAceGUIShowHide(group)

  group.seasonDropdown = AceGUI:Create("Dropdown")
  group.seasonDropdown.pullout.frame:SetParent(group.seasonDropdown.frame)
  group.seasonDropdown.text:SetJustifyH("LEFT")
  group.seasonDropdown:SetCallback("OnValueChanged", function(widget, callbackName, key)
    -- make sure we don't go out of bounds
    -- this probably happens if dropdown is being spammed (?)
    local index = math.min(#dungeonSelectionToIndex, key)
    db.selectedDungeonList = index
    MDT:UpdateDungeonDropDown()
    local currentList = dungeonSelectionToIndex[db.selectedDungeonList]
    MDT:UpdateToDungeon(currentList[1])
  end)
  group:AddChild(group.seasonDropdown)

  group.seasonDropdown:SetList(seasonList)
  group.seasonDropdown:SetValue(db.selectedDungeonList)
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
