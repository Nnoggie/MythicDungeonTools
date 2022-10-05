local MDT = MDT
local L = MDT.L
local dungeonIndex = 44
MDT.dungeonList[dungeonIndex] = L["TheAzureVault"]
MDT.mapInfo[dungeonIndex] = {
  viewportPositionOverrides = {
  }
};

MDT.dungeonMaps[dungeonIndex] = {
  [0] = "ArcaneNexus",
  [1] = "ArcaneNexus_A",
  [2] = "ArcaneNexus_B",
  [3] = "ArcaneNexus_C",
  [4] = "ArcaneNexus_D",
  [5] = "ArcaneNexus_E",
}
MDT.dungeonSubLevels[dungeonIndex] = {
  [1] = L["TheArcaneConservatory"],
  [2] = L["UpperChamber"],
  [3] = L["MausoleumOfLegends"],
  [4] = L["LowerChamber"],
  [5] = L["CrystalChamber"],
}

MDT.dungeonTotalCount[dungeonIndex] = { normal = 300, teeming = 1000, teemingEnabled = true }

MDT.mapPOIs[dungeonIndex] = {};

MDT.dungeonEnemies[dungeonIndex] = {};
