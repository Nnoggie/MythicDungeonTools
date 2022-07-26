local MDT = MDT
local AceGUI = LibStub("AceGUI-3.0")
local db

-- The idea here is to redo the dungeon select dropdown to be more user friendly.
-- This was necesarry as the old implementation did not allow for a dungeon to be part of multiple dungeon sets.
-- Additional dungeon lists just need to be added to seasonList and dungeonSelectionToIndex.

local seasonListActive = false
local seasonList = {
  [1] = "Legion",
  [2] = "BFA",
  [3] = "Shadowlands",
  [4] = "Shadowlands Season 4",
  -- [5]= "Dragonflight Season 1",
}

local dungeonSelectionToIndex = {
  [1] = {
    [1] = 1,
    [2] = 2,
    [3] = 3,
    [4] = 4,
    [5] = 5,
    [6] = 6,
    [7] = 7,
    [8] = 8,
    [9] = 9,
    [10] = 10,
    [11] = 11,
    [12] = 12,
    [13] = 13,
  },
  [2] = {
    [1] = 15,
    [2] = 16,
    [3] = 17,
    [4] = 18,
    [5] = 19,
    [6] = 20,
    [7] = 21,
    [8] = 22,
    [9] = 23,
    [10] = 24,
    [11] = 25,
    [12] = 26,
  },
  [3] = {
    [1] = 29,
    [2] = 30,
    [3] = 31,
    [4] = 32,
    [5] = 33,
    [6] = 34,
    [7] = 35,
    [8] = 36,
    [9] = 37,
    [10] = 38,
  },
  [4] = {
    [1] = 37,
    [2] = 38,
    [3] = 25,
    [4] = 26,
    [5] = 9,
    [6] = 10,
  },
  -- [5] = {
  --   [1] = 40,
  -- }
}

local indexToDungeonSelection = {}
local dungeonSelectionToNames = {}

function MDT:UpdateDungeonDropDown()
  local dungeonDropdown = MDT.main_frame.DungeonSelectionGroup.DungeonDropdown
  local sublevelDropdown = MDT.main_frame.DungeonSelectionGroup.SublevelDropdown
  local currentDungeonIdx = db.currentDungeonIdx
  dungeonDropdown:SetList(dungeonSelectionToNames[db.selectedDungeonList])
  dungeonDropdown:ClearFocus()
	dungeonDropdown:SetValue(indexToDungeonSelection[currentDungeonIdx])
	sublevelDropdown:SetList(MDT.dungeonSubLevels[currentDungeonIdx])
	sublevelDropdown:SetValue(db.presets[currentDungeonIdx][db.currentPreset[currentDungeonIdx]].value.currentSublevel)
  sublevelDropdown:ClearFocus()
end

---CreateDungeonSelectDropdown
---Creates both dungeon and sublevel dropdowns
function MDT:CreateDungeonSelectDropdown(frame)
  db = MDT:GetDB()
	--Simple Group to hold both dropdowns
	frame.DungeonSelectionGroup = AceGUI:Create("SimpleGroup")
	local group = frame.DungeonSelectionGroup
  if not group.frame.SetBackdrop then
      Mixin(group.frame, BackdropTemplateMixin)
  end
  group.frame:SetBackdropColor(unpack(MDT.BackdropColor))
  group.frame:SetFrameStrata("HIGH")
  group.frame:SetFrameLevel(50)
	group:SetWidth(204) --idk ace added weird margin on left
	group:SetHeight(50)
	group:SetPoint("TOPLEFT",frame.topPanel,"BOTTOMLEFT",0,2)
  group:SetLayout("List")
  MDT:FixAceGUIShowHide(group)

	group.DungeonDropdown = AceGUI:Create("Dropdown")
	group.DungeonDropdown.text:SetJustifyH("LEFT")
	group.DungeonDropdown:SetCallback("OnValueChanged",function(widget,callbackName,key)
    if (seasonListActive) then
      db.selectedDungeonList = key
      MDT:UpdateDungeonDropDown()
      seasonListActive = false
      local currentList = dungeonSelectionToIndex[db.selectedDungeonList]
      MDT:UpdateToDungeon(currentList[1])
      C_Timer.After(0.1, function()
        group.DungeonDropdown.button:Click()
      end)
    else
      local currentList = dungeonSelectionToIndex[db.selectedDungeonList]
      -- "> More Dungeons" is only added to the name list, so checking here like this works
      if #currentList+1 == key then
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
	group.SublevelDropdown.text:SetJustifyH("LEFT")
	group.SublevelDropdown:SetCallback("OnValueChanged",function(widget,callbackName,key)
		db.presets[db.currentDungeonIdx][db.currentPreset[db.currentDungeonIdx]].value.currentSublevel = key
		MDT:UpdateMap()
        MDT:ZoomMapToDefault()
	end)
	group:AddChild(group.SublevelDropdown)

  --create lists
  for i=1,#dungeonSelectionToIndex do
    dungeonSelectionToNames[i] = {}
    for j=1,#dungeonSelectionToIndex[i] do
      dungeonSelectionToNames[i][j] = MDT.dungeonList[dungeonSelectionToIndex[i][j]]
      indexToDungeonSelection[dungeonSelectionToIndex[i][j]] = j
    end
    dungeonSelectionToNames[i][#dungeonSelectionToIndex[i]+1] = "> More Dungeons"
  end

	MDT:UpdateDungeonDropDown()
end

function MDT:ScrollToNextDungeon(delta)
  local dungeonDropdown = MDT.main_frame.DungeonSelectionGroup.DungeonDropdown
  local currentValue = dungeonDropdown:GetValue()
  local target = currentValue+delta
  if dungeonSelectionToIndex[db.selectedDungeonList][target] then
    dungeonDropdown:Fire("OnValueChanged", target)
  end
end

