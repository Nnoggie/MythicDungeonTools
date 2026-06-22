local addonName = ...
local MDT = MDT
local L = MDT.L
local dungeonIndex = 161
MDT.dungeonList[dungeonIndex] = L["DenOfNalorakk"]
MDT.mapInfo[dungeonIndex] = {
  teleportId = 1289773,
  shortName = L["DenOfNalorakkShortName"],
  englishName = "Den of Nalorakk",
  mapID = 586
};

local zones = { 2513, 2514, 2564 }
for _, zone in ipairs(zones) do
  MDT.zoneIdToDungeonIdx[zone] = dungeonIndex
end

MDT.dungeonMaps[dungeonIndex] = {
  [0] = "",
  [1] = { customTextures = 'Interface\\AddOns\\'..addonName..'\\Midnight\\Textures\\DenOfNalorakk' },
}

MDT.dungeonSubLevels[dungeonIndex] = {
  [1] = L["DenOfNalorakk"],
}

MDT.dungeonTotalCount[dungeonIndex] = { normal = 0 }

MDT.mapPOIs[dungeonIndex] = {};

MDT.dungeonEnemies[dungeonIndex] = {};
