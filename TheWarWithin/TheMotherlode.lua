local addonName = ...
local MDT = MDT
local L = MDT.L
local dungeonIndex = 120
MDT.dungeonList[dungeonIndex] = L["The MOTHERLODE!!"]
MDT.mapInfo[dungeonIndex] = {
  teleportId = 467555, -- TODO there is also https://www.wowhead.com/ptr-2/spell=467553/path-of-the-azerite-refinery
  shortName = L["motherlodeShortName"],
  englishName = "The MOTHERLODE!!",
  mapID = 247
};

local zones = { 1010 }
for _, zone in ipairs(zones) do
  MDT.zoneIdToDungeonIdx[zone] = dungeonIndex
end

MDT.dungeonMaps[dungeonIndex] = {
  [0] = "KezanDungeon",
  [1] = "KezanDungeon",
}

MDT.dungeonSubLevels[dungeonIndex] = {
  [1] = L["The MOTHERLODE!!"],
}

MDT.dungeonTotalCount[dungeonIndex] = { normal = 384, teeming = 460, teemingEnabled = true }

MDT.mapPOIs[dungeonIndex] = {};

MDT.dungeonEnemies[dungeonIndex] = {};
