local MDT = MDT
local L = MDT.L
local dungeonIndex = 46
MDT.dungeonList[dungeonIndex] = L["ShadowmoonBurialGrounds"]
MDT.mapInfo[dungeonIndex] = {
  viewportPositionOverrides = {
  }
};

MDT.dungeonMaps[dungeonIndex] = {
  [0] = "ShadowmoonDungeon",
  [1] = "ShadowmoonDungeon1_",
  [2] = "ShadowmoonDungeon2_",
  [3] = "ShadowmoonDungeon3_",
}
MDT.dungeonSubLevels[dungeonIndex] = {
  [1] = L["CryptOfTheAncients"],
  [2] = L["AltarOfShadow"],
  [3] = L["EdgeOfReality"],
}

MDT.dungeonTotalCount[dungeonIndex] = { normal = 300, teeming = 1000, teemingEnabled = true }

MDT.mapPOIs[dungeonIndex] = {};

MDT.dungeonEnemies[dungeonIndex] = {};
