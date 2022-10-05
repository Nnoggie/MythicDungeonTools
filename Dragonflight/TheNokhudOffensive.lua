local MDT = MDT
local L = MDT.L
local dungeonIndex = 43
MDT.dungeonList[dungeonIndex] = L["TheNokhudOffensive"]
MDT.mapInfo[dungeonIndex] = {
  tileFormat = {
    [1] = 15,
    [2] = 15
  },
  viewportPositionOverrides = {
  }
};

MDT.dungeonMaps[dungeonIndex] = {
  [0] = "CentaurPlanes",
  [1] = "CentaurPlanes",
}
MDT.dungeonSubLevels[dungeonIndex] = {
  [1] = L["TheNokhudOffensive"],
}

MDT.dungeonTotalCount[dungeonIndex] = { normal = 300, teeming = 1000, teemingEnabled = true }

MDT.mapPOIs[dungeonIndex] = {};

MDT.dungeonEnemies[dungeonIndex] = {};
