local MDT = MDT
local L = MDT.L
local dungeonIndex = 51
MDT.dungeonList[dungeonIndex] = L["UldamanLegacyOfTyr"]
MDT.mapInfo[dungeonIndex] = {
  viewportPositionOverrides = {
  }
};

MDT.dungeonMaps[dungeonIndex] = {
  [0] = "Uldaman_Upres",
  [1] = "Uldaman_upres_A",
  [2] = "Uldaman_upres_B",
}
MDT.dungeonSubLevels[dungeonIndex] = {
  [1] = L["HallOfTheKeepers"],
  [2] = L["TheVaultOfTyr"],
}

MDT.dungeonTotalCount[dungeonIndex] = { normal = 300, teeming = 1000, teemingEnabled = true }

MDT.mapPOIs[dungeonIndex] = {};

MDT.dungeonEnemies[dungeonIndex] = {};
