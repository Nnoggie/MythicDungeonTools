local addonName = ...
local MDT = MDT
local L = MDT.L
local dungeonIndex = 151
MDT.dungeonList[dungeonIndex] = L["Skyreach"]
MDT.mapInfo[dungeonIndex] = {
  teleportId = 1254557,
  shortName = L["SkyreachShortName"],
  englishName = "Skyreach",
  mapID = 161
};
local zones = { 601, 602 }
for _, zone in ipairs(zones) do
  MDT.zoneIdToDungeonIdx[zone] = dungeonIndex
end

MDT.dungeonMaps[dungeonIndex] = {
  [0] = "",
  [1] = { customTextures = 'Interface\\AddOns\\'..addonName..'\\Midnight\\Textures\\Skyreach' }
}

MDT.dungeonSubLevels[dungeonIndex] = {
  [1] = L["Skyreach"],
}

MDT.dungeonTotalCount[dungeonIndex] = { normal = 470 }

MDT.mapPOIs[dungeonIndex] = {};

MDT.dungeonEnemies[dungeonIndex] = {};
