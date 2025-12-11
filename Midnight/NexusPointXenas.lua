local addonName = ...
local MDT = MDT
local L = MDT.L
local dungeonIndex = 155
MDT.dungeonList[dungeonIndex] = L["NexusPointXenas"]
MDT.mapInfo[dungeonIndex] = {
  teleportId = 1254563,
  shortName = L["NexusPointXenasShortName"],
  englishName = "Nexus Point Xenas",
  mapID = 559
};
local zones = { 2556 }
for _, zone in ipairs(zones) do
  MDT.zoneIdToDungeonIdx[zone] = dungeonIndex
end

MDT.dungeonMaps[dungeonIndex] = {
  [0] = "",
  [1] = { customTextures = 'Interface\\AddOns\\'..addonName..'\\Midnight\\Textures\\NexusPointXenas' }
}

MDT.dungeonSubLevels[dungeonIndex] = {
  [1] = L["NexusPointXenas"],
}

MDT.dungeonTotalCount[dungeonIndex] = { normal = 470 }

MDT.mapPOIs[dungeonIndex] = {};

MDT.dungeonEnemies[dungeonIndex] = {};
