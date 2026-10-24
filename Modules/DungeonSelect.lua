local _, MDT = ...
local UI = MDT.UI
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
  if MDT:IsRetail() then
    tinsert(MDT.seasonList, L["Midnight Season 2"])
    tinsert(MDT.dungeonSelectionToIndex, { 160, 161, 162, 163, 164, 42, 20, 17 })
    tinsert(MDT.seasonList, L["Midnight Season 1"])
    tinsert(MDT.dungeonSelectionToIndex, { 45, 11, 150, 151, 152, 153, 154, 155 })
  end
end

MDT.knownDungeons = {
  [2] = "Cathedral of Eternal Night",
  [3] = "Court of Stars",
  [4] = "Darkheart Thicket",
  [5] = "Eye of Azshara",
  [6] = "Halls of Valor",
  [7] = "Maw of Souls",
  [8] = "Neltharion's Lair",
  [9] = "Return to Karazhan Lower",
  [10] = "Return to Karazhan Upper",
  [11] = "Seat of the Triumvirate",
  [12] = "The Arcway",
  [13] = "Vault of the Wardens",
  [15] = "Atal'Dazar",
  [16] = "Freehold",
  [17] = "King's Rest",
  [18] = "Shrine of the Storm",
  [19] = "Siege of Boralus",
  [20] = "Temple of Sethraliss",
  [22] = "The Underrot",
  [23] = "Tol Dagor",
  [24] = "Waycrest Manor",
  [25] = "Mechagon - Junkyard",
  [29] = "De Other Side",
  [30] = "Halls of Atonement",
  [31] = "Mists of Tirna Scithe",
  [32] = "Plaguefall",
  [33] = "Sanguine Depths",
  [34] = "Spires of Ascension",
  [35] = "The Necrotic Wake",
  [37] = "Tazavesh: Streets of Wonder",
  [38] = "Tazavesh: So'leah's Gambit",
  [40] = "Grimrail Depot",
  [41] = "Iron Docks",
  [42] = "Ruby Life Pools",
  [43] = "The Nokhud Offensive",
  [44] = "The Azure Vault",
  [45] = "Algethar Academy",
  [46] = "Shadowmoon Burial Grounds",
  [47] = "Temple of the Jade Serpent",
  [48] = "Brackenhide Hollow",
  [49] = "Halls of Infusion",
  [50] = "Neltharus",
  [51] = "Uldaman",
  [77] = "The Vortex Pinnacle",
  [100] = "DOTI: Galakrond's Fall",
  [101] = "DOTI: Murozond's Rise",
  [102] = "Waycrest Manor",
  [103] = "Black Rook Hold",
  [104] = "The Everbloom",
  [105] = "Throne of Tides",
  [110] = "The Stonevault",
  [111] = "The Dawnbreaker",
  [112] = "Grim Batol",
  [113] = "Ara-Kara",
  [114] = "City of Threads",
  [115] = "Priory of the Sacred Flame",
  [116] = "Cinderbrew Meadery",
  [117] = "Darkflame Cleft",
  [118] = "The Rookery",
  [119] = "Operation: Floodgate",
  [120] = "The MOTHERLODE!!",
  [121] = "Theater of Pain",
  [122] = "Mechagon - Workshop",
  [123] = "Eco-Dome Al'dani",
  [130] = "Gate of the Setting Sun",
  [131] = "Mogu'shan Palace",
  [132] = "Scarlet Halls",
  [133] = "Scarlet Monastery",
  [134] = "Scholomance",
  [135] = "Shado-Pan Monastery",
  [136] = "Siege of Niuzao Temple",
  [137] = "Stormstout Brewery",
  [138] = "Temple of the Jade Serpent",
  [160] = "Murder Row",
  [161] = "Den of Nalorakk",
  [162] = "The Blinding Vale",
  [163] = "Voidscar Arena",
  [164] = "Altar of Fangs",
}

local seasonList = MDT.seasonList
local dungeonSelectionToIndex = MDT.dungeonSelectionToIndex

function MDT:GetSeasonList()
  return seasonList
end

local dungeonButtons = {}
local BUTTON_SIZE = 40
-- Zoom dungeon icons by 20%: show the centered 1/1.2 of the texture.
local ICON_CROP = (1 - 1 / 1.2) / 2
local DROPDOWN_WIDTH = 180
local seasonDropdown, sublevelDropdown

---Choice items for a list of names, valued by their index.
---@param names string[]
---@return MDT.UI.MenuItem[]
local function indexChoices(names)
  local items = {}
  for index, name in ipairs(names) do items[index] = { kind = "choice", value = index, text = name } end
  return items
end

---@param parent table
---@param onChange fun(value: integer)
local function makeDropdown(parent, onChange)
  local dropdown = UI.Dropdown(parent, { width = DROPDOWN_WIDTH, height = "md", hidden = true, search = false, onChange = onChange })
  dropdown:SetFrameStrata("HIGH")
  dropdown:SetFrameLevel(50)
  return dropdown
end

function MDT:UpdateDungeonSelectVisibility(showMapControls)
  if showMapControls == nil then showMapControls = MDT:IsMapSectionActive() end
  local frame = MDT.main_frame
  if not frame then return end

  local currentList = db and dungeonSelectionToIndex[db.selectedDungeonList]
  local visibleDungeonButtons = currentList and #currentList or 0
  for idx, button in ipairs(dungeonButtons) do
    if showMapControls and idx <= visibleDungeonButtons then
      button:Show()
    else
      button:Hide()
    end
  end

  if seasonDropdown then seasonDropdown:SetHidden(not showMapControls) end
  if sublevelDropdown then
    local sublevels = db and MDT.dungeonSubLevels[db.currentDungeonIdx]
    sublevelDropdown:SetHidden(not (showMapControls and sublevels and #sublevels > 1))
  end
end

function MDT:UpdateDungeonSelectHighlight()
  for _, button in ipairs(dungeonButtons) do
    if button.dungeonIdx == db.currentDungeonIdx then
      button.selectedTexture:Show()
    else
      button.selectedTexture:Hide()
    end
  end
end

local formatTime = function(time)
  if time then
    local timeMin = math.floor(time / 60)
    local timeSec = math.floor(time - (timeMin * 60))
    if timeMin < 10 then
      ---@diagnostic disable-next-line: cast-local-type
      timeMin = ("0%d"):format(timeMin)
    end
    if timeSec < 10 then
      ---@diagnostic disable-next-line: cast-local-type
      timeSec = ("0%d"):format(timeSec)
    end
    return ("%s:%s"):format(timeMin, timeSec)
  end
end

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
      button.selectedTexture = button:CreateTexture()
      button.selectedTexture:SetAllPoints(button)
      button.selectedTexture:SetAtlas("bags-glow-artifact")
      button.selectedTexture:SetDrawLayer("OVERLAY")
      button.shortText = button:CreateFontString(nil, "OVERLAY")
      button.shortText:SetPoint("BOTTOM", button, "BOTTOM", 0, 2)
      button.shortText:SetFontObject(UI.Fonts.Get("small", true))
      button.shortText:SetTextColor(1, 1, 1)
      button:SetScript("OnLeave", function()
        MDTTooltip:Hide()
      end)
    end
    local mapInfo = MDT.mapInfo[dungeonIdx]
    button.dungeonIdx = dungeonIdx
    button.texture:SetTexture(MDT:GetDungeonIcon(dungeonIdx))
    button.texture:SetTexCoord(ICON_CROP, 1 - ICON_CROP, ICON_CROP, 1 - ICON_CROP)
    button.shortText:SetText(mapInfo.shortName)
    button:SetScript("OnClick", function(self, button)
      MDT:UpdateToDungeon(dungeonIdx)
      MDT:UpdateDungeonSelectHighlight()
    end)
    button:RegisterForClicks("AnyDown", "AnyUp")
    button:Show()
    button:SetFrameStrata("HIGH")
    button:SetFrameLevel(50)
    button:SetScript("OnEnter", function()
      local timer
      if mapInfo.mapID then
        timer = select(3, C_ChallengeMode.GetMapUIInfo(mapInfo.mapID))
      end
      MDTTooltip:SetOwner(dungeonButtons[idx], "ANCHOR_BOTTOMRIGHT", -dungeonButtons[idx]:GetWidth(), 0)
      MDTTooltip:AddLine(MDT.dungeonList[dungeonIdx], 1, 1, 1)
      if timer then
        MDTTooltip:AddLine(L["Timer"]..": "..formatTime(timer), 1, 1, 1)
      end
      MDTTooltip:Show()
    end)
  end
  MDT:UpdateDungeonSelectHighlight()
  for idx = #currentList + 1, #dungeonButtons do
    dungeonButtons[idx]:Hide()
  end

  local currentDungeonIdx = db.currentDungeonIdx
  sublevelDropdown:SetItems(indexChoices(MDT.dungeonSubLevels[currentDungeonIdx]))
  sublevelDropdown:SetValue(db.presets[currentDungeonIdx][db.currentPreset[currentDungeonIdx]].value.currentSublevel)
  MDT:UpdateDungeonSelectVisibility()
end

---Floor picker for dungeons with more than one map, under the dungeon buttons.
function MDT:CreateSublevelDropdown(frame)
  db = MDT:GetDB()
  sublevelDropdown = makeDropdown(frame, function(sublevel)
    db.presets[db.currentDungeonIdx][db.currentPreset[db.currentDungeonIdx]].value.currentSublevel = sublevel
    MDT:UpdateMap()
  end)
  sublevelDropdown:SetPoint("TOPLEFT", frame, "TOPLEFT", 4, -(BUTTON_SIZE + 4))
end

---The dungeon's icon: its own, else its teleport spell's, else a question mark.
---@param dungeonIdx integer
---@return number|string
function MDT:GetDungeonIcon(dungeonIdx)
  local mapInfo = MDT.mapInfo[dungeonIdx] or {}
  return mapInfo.iconId or (mapInfo.teleportId and C_Spell.GetSpellTexture(mapInfo.teleportId)) or 134400
end

function MDT:SetDungeonList(key, dungeonIdx)
  db = MDT:GetDB()
  if dungeonIdx then
    -- find an index, first one should be the correct one
    for listIdx, list in ipairs(MDT.dungeonSelectionToIndex) do
      for _, dIdx in ipairs(list) do
        if dungeonIdx == dIdx and key == nil then
          key = listIdx
          break
        end
      end
    end
  end
  if not key then return end
  -- make sure we don't go out of bounds
  -- this probably happens if dropdown is being spammed (?)
  local index = math.min(#dungeonSelectionToIndex, key)
  db.selectedDungeonList = index
  if seasonDropdown then seasonDropdown:SetValue(index) end
end

---Season picker in the top left of the title bar; absent when there is only one season.
function MDT:CreateSeasonDropdown(frame)
  if #seasonList == 1 then return end
  db = MDT:GetDB()
  seasonDropdown = makeDropdown(frame, function(list)
    MDT:SetDungeonList(list)
    MDT:UpdateDungeonDropDown()
    MDT:UpdateToDungeon(dungeonSelectionToIndex[db.selectedDungeonList][1])
  end)
  seasonDropdown:SetItems(indexChoices(seasonList))
  seasonDropdown:SetValue(db.selectedDungeonList)
  seasonDropdown:SetPoint("LEFT", frame.topPanel, "LEFT", 4, 0)
end

---Test access to the season ("season") and floor ("sublevel") dropdowns.
---@param id "season"|"sublevel"
---@return MDT.UI.Control?
function MDT:GetDungeonSelectControl(id)
  if id == "season" then return seasonDropdown end
  if id == "sublevel" then return sublevelDropdown end
end

function MDT:CheckSeenDungeonLists()
  db = MDT:GetDB()
  local defaultSavedVars = MDT:GetDefaultSavedVariables().global
  local latestDungeon = defaultSavedVars.currentDungeonIdx
  local latestSeen = db.latestDungeonSeen
  if latestSeen ~= latestDungeon then
    -- find list
    for listIndex, list in pairs(MDT.dungeonSelectionToIndex) do
      for _, dngIdx in pairs(list) do
        if dngIdx == latestDungeon then
          db.latestDungeonSeen = latestDungeon
          db.currentDungeonIdx = latestDungeon
          db.selectedDungeonList = listIndex
          return
        end
      end
    end
  end
end
