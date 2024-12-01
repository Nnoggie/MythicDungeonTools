local addonName = ...
local MDT = MDT
local L = MDT.L
local dungeonIndex = 119
MDT.dungeonList[dungeonIndex] = L["Operation: Floodgate"]
MDT.mapInfo[dungeonIndex] = {
  teleportId = 0, --TODO
  shortName = L["operationFloodgateShortName"],
  englishName = "Operation: Floodgate",
  mapID = 1 -- TODO
};

local zones = {}  --TODO
for _, zone in ipairs(zones) do
  MDT.zoneIdToDungeonIdx[zone] = dungeonIndex
end

MDT.dungeonMaps[dungeonIndex] = {
  [0] = "",
  [1] = { customTextures = 'Interface\\AddOns\\'..addonName..'\\TheWarWithin\\Textures\\OperationFloodgate' }
}

MDT.dungeonSubLevels[dungeonIndex] = {
  [1] = L["Operation: Floodgate"],
}

MDT.dungeonTotalCount[dungeonIndex] = { normal = 160, teeming = 192, teemingEnabled = true }

MDT.mapPOIs[dungeonIndex] = {};

MDT.dungeonEnemies[dungeonIndex] = {};
