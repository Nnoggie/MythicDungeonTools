local addonName = ...
local MDT = MDT
local L = MDT.L
local dungeonIndex = 164
MDT.dungeonList[dungeonIndex] = L["AltarOfFangs"]
MDT.mapInfo[dungeonIndex] = {
  teleportId = 1289772,
  shortName = L["AltarOfFangsShortName"],
  englishName = "Altar of Fangs",
  mapID = 588
};

local zones = { 2588, 2589, 2590 }
for _, zone in ipairs(zones) do
  MDT.zoneIdToDungeonIdx[zone] = dungeonIndex
end

MDT.dungeonMaps[dungeonIndex] = {
  [0] = "",
  [1] = { customTextures = 'Interface\\AddOns\\'..addonName..'\\Midnight\\Textures\\AltarOfFangs' },
}

MDT.dungeonSubLevels[dungeonIndex] = {
  [1] = L["AltarOfFangs"],
}

MDT.dungeonTotalCount[dungeonIndex] = { normal = 0 }

MDT.mapPOIs[dungeonIndex] = {};

MDT.dungeonEnemies[dungeonIndex] = {};
