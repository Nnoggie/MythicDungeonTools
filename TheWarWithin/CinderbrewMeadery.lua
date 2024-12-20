local addonName = ...
local MDT = MDT
local L = MDT.L

local dungeonIndex = 116
MDT.dungeonList[dungeonIndex] = L["Cinderbrew Meadery"]
MDT.mapInfo[dungeonIndex] = {
  teleportId = 467546,
  shortName = L["cinderbrewShortName"],
  englishName = "Cinderbrew Meadery",
  mapID = 506
}

local zones = { 2248, 2335 }
for _, zone in ipairs(zones) do
  MDT.zoneIdToDungeonIdx[zone] = dungeonIndex
end

MDT.dungeonMaps[dungeonIndex] = {
  [0] = "CinderbrewMeadery",
  [1] = "Cinderbrew_Meadery",
}

MDT.dungeonSubLevels[dungeonIndex] = {
  [1] = L["Cinderbrew Meadery"]
}

MDT.dungeonTotalCount[dungeonIndex] = { normal = 100, teeming = 1000, teemingEnabled = true }

MDT.mapPOIs[dungeonIndex] = {

};

MDT.dungeonEnemies[dungeonIndex] = {}
