local addonName = ...
local MDT = MDT
local L = MDT.L

local dungeonIndex = 115
MDT.dungeonList[dungeonIndex] = L["Priory of the Sacred Flame"]
MDT.mapInfo[dungeonIndex] = {
  teleportId = 0, --TODO
  shortName = L["prioryShortName"],
  englishName = "Priory of the Sacred Flame",
  mapID = 499
}

local zones = { 2215, 2308, 2309 }
for _, zone in ipairs(zones) do
  MDT.zoneIdToDungeonIdx[zone] = dungeonIndex
end

MDT.dungeonMaps[dungeonIndex] = {
  [0] = "",
  [1] = { customTextures = 'Interface\\AddOns\\'..addonName..'\\TheWarWithin\\Textures\\PrioryOfTheSacredFlame' }
}

MDT.dungeonSubLevels[dungeonIndex] = {
  [1] = L["Priory of the Sacred Flame"]
}

MDT.dungeonTotalCount[dungeonIndex] = { normal = 100, teeming = 1000, teemingEnabled = true }

MDT.mapPOIs[dungeonIndex] = {

};

MDT.dungeonEnemies[dungeonIndex] = {}
