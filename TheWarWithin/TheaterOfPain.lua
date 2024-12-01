local addonName = ...
local MDT = MDT
local L = MDT.L
local dungeonIndex = 121
MDT.dungeonList[dungeonIndex] = L["Theater of Pain"]
MDT.mapInfo[dungeonIndex] = {
  teleportId = 354467,
  shortName = L["theaterOfPainShortName"],
  englishName = "Theater of Pain",
  mapID = 382
};

local zones = { 1683, 1684, 1685, 1686, 1687 }
for _, zone in ipairs(zones) do
  MDT.zoneIdToDungeonIdx[zone] = dungeonIndex
end

MDT.dungeonMaps[dungeonIndex] = {
  [0] = "",
  [1] = { customTextures = 'Interface\\AddOns\\'..addonName..'\\TheWarWithin\\Textures\\TheaterOfPain' }
}

MDT.dungeonSubLevels[dungeonIndex] = {
  [1] = L["Theater of Pain"],
}

MDT.dungeonTotalCount[dungeonIndex] = { normal = 271, teeming = 1000, teemingEnabled = true }

MDT.mapPOIs[dungeonIndex] = {};

MDT.dungeonEnemies[dungeonIndex] = {};
