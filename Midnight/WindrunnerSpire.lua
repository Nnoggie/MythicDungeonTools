local addonName = ...
local MDT = MDT
local L = MDT.L
local dungeonIndex = 152
MDT.dungeonList[dungeonIndex] = L["WindrunnerSpire"]
MDT.mapInfo[dungeonIndex] = {
  teleportId = 1254400,
  shortName = L["WindrunnerSpireShortName"],
  englishName = "Windrunner Spire",
  mapID = 557
};
local zones = { 2492, 2493, 2494, 2496, 2497, 2498, 2499 }
for _, zone in ipairs(zones) do
  MDT.zoneIdToDungeonIdx[zone] = dungeonIndex
end

MDT.dungeonMaps[dungeonIndex] = {
  [0] = "",
  [1] = { customTextures = 'Interface\\AddOns\\'..addonName..'\\Midnight\\Textures\\WindrunnerSpire' }
}

MDT.dungeonSubLevels[dungeonIndex] = {
  [1] = L["WindrunnerSpire"],
}

MDT.dungeonTotalCount[dungeonIndex] = { normal = 470 }

MDT.mapPOIs[dungeonIndex] = {};

MDT.dungeonEnemies[dungeonIndex] = {};
