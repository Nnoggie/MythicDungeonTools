local MDT = MDT
local L = MDT.L
local dungeonIndex = 100
MDT.dungeonList[dungeonIndex] = L["DawnOfTheInfiniteLower"]
MDT.mapInfo[dungeonIndex] = {

};

MDT.dungeonMaps[dungeonIndex] = {
  [0] = "HallsOfInfusion",
  [1] = "HallsOfInfusion_A",
}

MDT.dungeonSubLevels[dungeonIndex] = {
  [1] = L["Infuser's Rotunda"],
}

MDT.dungeonTotalCount[dungeonIndex] = { normal = 100, teeming = 1000, teemingEnabled = true }

MDT.mapPOIs[dungeonIndex] = {};

MDT.dungeonEnemies[dungeonIndex] = {};
