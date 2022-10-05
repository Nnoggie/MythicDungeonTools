local MDT = MDT
local L = MDT.L
local dungeonIndex = 49
MDT.dungeonList[dungeonIndex] = L["HallsOfInfusion"]
MDT.mapInfo[dungeonIndex] = {
  viewportPositionOverrides = {
  }
};

MDT.dungeonMaps[dungeonIndex] = {
  [0] = "BlackrockTrainDepotDungeon",
  [1] = "BlackrockTrainDepotDungeon1_",
}
MDT.dungeonSubLevels[dungeonIndex] = {
  [1] = L["InfusersRotunda"],
  [2] = L["InfusionChamber"],
}

MDT.dungeonTotalCount[dungeonIndex] = { normal = 300, teeming = 1000, teemingEnabled = true }

MDT.mapPOIs[dungeonIndex] = {};

MDT.dungeonEnemies[dungeonIndex] = {};
