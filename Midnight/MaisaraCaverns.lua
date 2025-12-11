local addonName = ...
local MDT = MDT
local L = MDT.L
local dungeonIndex = 154
MDT.dungeonList[dungeonIndex] = L["MaisaraCaverns"]
MDT.mapInfo[dungeonIndex] = {
  teleportId = 1254559,
  shortName = L["MaisaraCavernsShortName"],
  englishName = "Maisara Caverns",
  mapID = 560
};
local zones = { 2501 }
for _, zone in ipairs(zones) do
  MDT.zoneIdToDungeonIdx[zone] = dungeonIndex
end

MDT.dungeonMaps[dungeonIndex] = {
  [0] = "",
  [1] = { customTextures = 'Interface\\AddOns\\'..addonName..'\\Midnight\\Textures\\MaisaraCaverns' }
}

MDT.dungeonSubLevels[dungeonIndex] = {
  [1] = L["MaisaraCaverns"],
}

MDT.dungeonTotalCount[dungeonIndex] = { normal = 470 }

MDT.mapPOIs[dungeonIndex] = {};

MDT.dungeonEnemies[dungeonIndex] = {};
