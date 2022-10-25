local MDT = MDT
local L = MDT.L
local dungeonIndex = 50
MDT.dungeonList[dungeonIndex] = L["Neltharus"]
MDT.mapInfo[dungeonIndex] = {
  viewportPositionOverrides = {
  }
};

MDT.dungeonMaps[dungeonIndex] = {
  [0] = "Neltharus",
  [1] = "Neltharus_A",
  [2] = "Neltharus_B",
}
MDT.dungeonSubLevels[dungeonIndex] = {
  [1] = L["TheBurningCauldron"],
  [2] = L["ChamberOfFlames"],
}

MDT.dungeonTotalCount[dungeonIndex] = { normal = 300, teeming = 1000, teemingEnabled = true }

MDT.mapPOIs[dungeonIndex] = {};

MDT.dungeonEnemies[dungeonIndex] = {};
