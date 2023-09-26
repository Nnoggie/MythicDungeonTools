local addonName = ...
local MDT = MDT
local L = MDT.L
local dungeonIndex = 105
MDT.dungeonList[dungeonIndex] = L["Throne of Tides"]
MDT.mapInfo[dungeonIndex] = {

};

local zones = { 322, 323 }
for _, zone in ipairs(zones) do
  MDT.zoneIdToDungeonIdx[zone] = dungeonIndex
end

MDT.dungeonMaps[dungeonIndex] = {
  [0] = "",
  [1] = { customTextures = 'ThroneOfTides' },
}

MDT.dungeonSubLevels[dungeonIndex] = {
  [1] = L["Throne of Tides"],
}

MDT.dungeonTotalCount[dungeonIndex] = { normal = 100, teeming = 1000, teemingEnabled = true }

MDT.mapPOIs[dungeonIndex] = {};

MDT.dungeonEnemies[dungeonIndex] = {};
