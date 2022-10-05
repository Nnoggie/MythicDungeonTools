local MDT = MDT
local L = MDT.L
local dungeonIndex = 45
MDT.dungeonList[dungeonIndex] = L["AlgetharAcademy"]
MDT.mapInfo[dungeonIndex] = {
  viewportPositionOverrides = {
  }
};

MDT.dungeonMaps[dungeonIndex] = {
  [0] = "DragonAcademy",
  [1] = "DragonAcademy_A",
  [2] = "DragonAcademy_B",
  [3] = "DragonAcademy_C",

}
MDT.dungeonSubLevels[dungeonIndex] = {
  [1] = L["AlgetharAcademy"],
  [2] = L["ThePitch"],
  [3] = L["TheHeadteachersEnclave"],
}

MDT.dungeonTotalCount[dungeonIndex] = { normal = 300, teeming = 1000, teemingEnabled = true }

MDT.mapPOIs[dungeonIndex] = {};

MDT.dungeonEnemies[dungeonIndex] = {};
