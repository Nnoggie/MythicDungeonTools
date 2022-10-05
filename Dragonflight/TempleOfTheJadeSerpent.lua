local MDT = MDT
local L = MDT.L
local dungeonIndex = 47
MDT.dungeonList[dungeonIndex] = L["TempleOfTheJadeSerpent"]
MDT.mapInfo[dungeonIndex] = {
  viewportPositionOverrides = {
  }
};

MDT.dungeonMaps[dungeonIndex] = {
  [0] = "BlackrockTrainDepotDungeon",
  [1] = "BlackrockTrainDepotDungeon1_",
}
MDT.dungeonSubLevels[dungeonIndex] = {
  [1] = L["TempleOfTheJadeSerpent"],
  [2] = L["TheScrollkeepersSanctum"],
}

MDT.dungeonTotalCount[dungeonIndex] = { normal = 300, teeming = 1000, teemingEnabled = true }

MDT.mapPOIs[dungeonIndex] = {};

MDT.dungeonEnemies[dungeonIndex] = {};
