local MDT = MDT
local L = MDT.L
local dungeonIndex = 42
MDT.dungeonList[dungeonIndex] = L["RubyLifePools"]
MDT.mapInfo[dungeonIndex] = {
  viewportPositionOverrides = {
  }
};

MDT.dungeonMaps[dungeonIndex] = {
  [0] = "RubyLifePools",
  [1] = "RubyLifePools_A",
  [2] = "RubyLifePools_B",
}
MDT.dungeonSubLevels[dungeonIndex] = {
  [1] = L["Infusion Chambers"],
  [2] = L["Ruby Overlook"],
}

MDT.dungeonTotalCount[dungeonIndex] = { normal = 300, teeming = 1000, teemingEnabled = true }

MDT.mapPOIs[dungeonIndex] = {};

MDT.dungeonEnemies[dungeonIndex] = {};
