local addonName = ...
local MDT = MDT
local L = MDT.L
local dungeonIndex = 153
MDT.dungeonList[dungeonIndex] = L["MagistersTerrace"]
MDT.mapInfo[dungeonIndex] = {
  teleportId = 1254572,
  shortName = L["MagistersTerraceShortName"],
  englishName = "Magisters Terrace",
  mapID = 558
};
local zones = { 2511, 2515, 2516, 2517, 2518, 2519, 2520 }
for _, zone in ipairs(zones) do
  MDT.zoneIdToDungeonIdx[zone] = dungeonIndex
end

MDT.dungeonMaps[dungeonIndex] = {
  [0] = "",
  [1] = { customTextures = 'Interface\\AddOns\\'..addonName..'\\Midnight\\Textures\\MagistersTerrace' }
}

MDT.dungeonSubLevels[dungeonIndex] = {
  [1] = L["MagistersTerrace"],
}

MDT.dungeonTotalCount[dungeonIndex] = { normal = 470 }

MDT.mapPOIs[dungeonIndex] = {};

MDT.dungeonEnemies[dungeonIndex] = {};
