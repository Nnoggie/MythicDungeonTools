local addonName = ...
local MDT = MDT
local L = MDT.L

local dungeonIndex = 117
MDT.dungeonList[dungeonIndex] = L["Darkflame Cleft"]
MDT.mapInfo[dungeonIndex] = {
  teleportId = 0,                      --TODO
  shortName = L["darkflameShortName"], --TODO
  englishName = "Darkflame Cleft",
  mapID = 506
}

local zones = { 2214, 2303 }
for _, zone in ipairs(zones) do
  MDT.zoneIdToDungeonIdx[zone] = dungeonIndex
end

MDT.dungeonMaps[dungeonIndex] = {
  [0] = "",
  [1] = { customTextures = 'Interface\\AddOns\\'..addonName..'\\TheWarWithin\\Textures\\DarkflameCleft' }
}

MDT.dungeonSubLevels[dungeonIndex] = {
  [1] = L["Darkflame Cleft"]
}

MDT.dungeonTotalCount[dungeonIndex] = { normal = 100, teeming = 1000, teemingEnabled = true }

MDT.mapPOIs[dungeonIndex] = {

};

MDT.dungeonEnemies[dungeonIndex] = {}
