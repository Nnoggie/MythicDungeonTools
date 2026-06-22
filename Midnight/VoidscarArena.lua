local addonName = ...
local MDT = MDT
local L = MDT.L
local dungeonIndex = 163
MDT.dungeonList[dungeonIndex] = L["VoidscarArena"]
MDT.mapInfo[dungeonIndex] = {
  teleportId = 1289777,
  shortName = L["VoidscarArenaShortName"],
  englishName = "Voidscar Arena",
  mapID = 585
};

local zones = { 2572, 2573, 2574 }
for _, zone in ipairs(zones) do
  MDT.zoneIdToDungeonIdx[zone] = dungeonIndex
end

MDT.dungeonMaps[dungeonIndex] = {
  [0] = "",
  [1] = { customTextures = 'Interface\\AddOns\\'..addonName..'\\Midnight\\Textures\\VoidscarArena' },
}

MDT.dungeonSubLevels[dungeonIndex] = {
  [1] = L["VoidscarArena"],
}

MDT.dungeonTotalCount[dungeonIndex] = { normal = 0 }

MDT.mapPOIs[dungeonIndex] = {};

MDT.dungeonEnemies[dungeonIndex] = {};
