local addonName = ...
local MDT = MDT
local L = MDT.L
local dungeonIndex = 162
MDT.dungeonList[dungeonIndex] = L["TheBlindingVale"]
MDT.mapInfo[dungeonIndex] = {
  teleportId = 1289776,
  shortName = L["TheBlindingValeShortName"],
  englishName = "The Blinding Vale",
  mapID = 584
};

local zones = { 2500 }
for _, zone in ipairs(zones) do
  MDT.zoneIdToDungeonIdx[zone] = dungeonIndex
end

MDT.dungeonMaps[dungeonIndex] = {
  [0] = "",
  [1] = { customTextures = 'Interface\\AddOns\\'..addonName..'\\Midnight\\Textures\\TheBlindingVale' },
}

MDT.dungeonSubLevels[dungeonIndex] = {
  [1] = L["TheBlindingVale"],
}

MDT.dungeonTotalCount[dungeonIndex] = { normal = 0 }

MDT.mapPOIs[dungeonIndex] = {};

MDT.dungeonEnemies[dungeonIndex] = {};
