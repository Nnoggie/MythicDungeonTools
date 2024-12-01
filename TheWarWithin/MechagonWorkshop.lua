local addonName = ...
local MDT = MDT
local L = MDT.L
local dungeonIndex = 122
MDT.dungeonList[dungeonIndex] = L["Mechagon - Workshop"]
MDT.mapInfo[dungeonIndex] = {
  teleportId = 373274,
  shortName = L["mechagonWorkshopShortName"],
  englishName = "Mechagon - Workshop",
  mapID = 370
};

local zones = { 1491, 1493, 1494, 1497 }
for _, zone in ipairs(zones) do
  MDT.zoneIdToDungeonIdx[zone] = dungeonIndex
end

MDT.dungeonMaps[dungeonIndex] = {
  [0] = "",
  [1] = { customTextures = 'Interface\\AddOns\\'..addonName..'\\TheWarWithin\\Textures\\MechagonWorkshop' }
}

MDT.dungeonSubLevels[dungeonIndex] = {
  [1] = L["Mechagon - Workshop"],
}

MDT.dungeonTotalCount[dungeonIndex] = { normal = 160, teeming = 192, teemingEnabled = true }

MDT.mapPOIs[dungeonIndex] = {};

MDT.dungeonEnemies[dungeonIndex] = {};
