local addonName = ...
local MDT = MDT
local L = MDT.L
local dungeonIndex = 150
MDT.dungeonList[dungeonIndex] = L["PitOfSaron"]
MDT.mapInfo[dungeonIndex] = {
  teleportId = 1254555,
  shortName = L["PitOfSaronShortName"],
  englishName = "Pit of Saron",
  mapID = 556
};
local zones = { 184 }
for _, zone in ipairs(zones) do
  MDT.zoneIdToDungeonIdx[zone] = dungeonIndex
end

MDT.dungeonMaps[dungeonIndex] = {
  [0] = "",
  [1] = { customTextures = 'Interface\\AddOns\\'..addonName..'\\Midnight\\Textures\\PitOfSaron' }
}

MDT.dungeonSubLevels[dungeonIndex] = {
  [1] = L["PitOfSaron"],
}

MDT.dungeonTotalCount[dungeonIndex] = { normal = 470 }

MDT.mapPOIs[dungeonIndex] = {};

MDT.dungeonEnemies[dungeonIndex] = {};
