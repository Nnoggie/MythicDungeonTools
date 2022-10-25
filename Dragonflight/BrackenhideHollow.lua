local MDT = MDT
local L = MDT.L
local dungeonIndex = 48
MDT.dungeonList[dungeonIndex] = L["BrackenhideHollow"]
MDT.mapInfo[dungeonIndex] = {
  viewportPositionOverrides = {
  }
};

MDT.dungeonMaps[dungeonIndex] = {
  [0] = "BrackenHideHollow",
  [1] = "BrackenHideHollow",
  [2] = "BrackenHideHollow_A",
}
MDT.dungeonSubLevels[dungeonIndex] = {
  [1] = L["BrackenhideHollow"],
  [2] = L["DenOfDecay"],
}

MDT.dungeonTotalCount[dungeonIndex] = { normal = 300, teeming = 1000, teemingEnabled = true }

MDT.mapPOIs[dungeonIndex] = {};

MDT.dungeonEnemies[dungeonIndex] = {};
