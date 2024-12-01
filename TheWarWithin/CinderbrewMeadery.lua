local addonName = ...
local MDT = MDT
local L = MDT.L

local dungeonIndex = 116
MDT.dungeonList[dungeonIndex] = L["Cinderbrew Meadery"]
MDT.mapInfo[dungeonIndex] = {
  teleportId = 0,                       --TODO
  shortName = L["cinderbrewShortName"], --TODO
  englishName = "Cinderbrew Meadery",
  mapID = 506
}

local zones = { 2248, 2335 }
for _, zone in ipairs(zones) do
  MDT.zoneIdToDungeonIdx[zone] = dungeonIndex
end

MDT.dungeonMaps[dungeonIndex] = {
  [0] = "",
  [1] = { customTextures = 'Interface\\AddOns\\'..addonName..'\\TheWarWithin\\Textures\\CinderbrewMeadery' }
}

MDT.dungeonSubLevels[dungeonIndex] = {
  [1] = L["Cinderbrew Meadery"]
}

MDT.dungeonTotalCount[dungeonIndex] = { normal = 100, teeming = 1000, teemingEnabled = true }

MDT.mapPOIs[dungeonIndex] = {

};

MDT.dungeonEnemies[dungeonIndex] = {}
