local addonName = ...
local MDT = MDT
local L = MDT.L
local dungeonIndex = 160
MDT.dungeonList[dungeonIndex] = L["MurderRow"]
MDT.mapInfo[dungeonIndex] = {
  teleportId = 1216786, -- FIXME
  shortName = L["MurderRowShortName"],
  englishName = "Murder Row",
  mapID = 12345                    -- FIXME
};
local zones = { 2214, 2387, 2388 } -- FIXME
for _, zone in ipairs(zones) do
  MDT.zoneIdToDungeonIdx[zone] = dungeonIndex
end

MDT.dungeonMaps[dungeonIndex] = {
  [0] = "",
  [1] = { customTextures = 'Interface\\AddOns\\'..addonName..'\\Midnight\\Textures\\MurderRow' }
}

MDT.dungeonSubLevels[dungeonIndex] = {
  [1] = L["MurderRow"],
}

MDT.dungeonTotalCount[dungeonIndex] = { normal = 470 }

MDT.mapPOIs[dungeonIndex] = {};

MDT.dungeonEnemies[dungeonIndex] = {};
