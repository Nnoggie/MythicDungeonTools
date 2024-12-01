local addonName = ...
local MDT = MDT
local L = MDT.L

local dungeonIndex = 118
MDT.dungeonList[dungeonIndex] = L["The Rookery"]
MDT.mapInfo[dungeonIndex] = {
  teleportId = 0,                    --TODO
  shortName = L["rookeryShortname"], --TODO
  englishName = "The Rookery",
  mapID = 500
}

local zones = { 2315, 2316, 2317, 2318, 2319, 2320 }
for _, zone in ipairs(zones) do
  MDT.zoneIdToDungeonIdx[zone] = dungeonIndex
end

MDT.dungeonMaps[dungeonIndex] = {
  [0] = "",
  [1] = { customTextures = 'Interface\\AddOns\\'..addonName..'\\TheWarWithin\\Textures\\TheRookery' }
}

MDT.dungeonSubLevels[dungeonIndex] = {
  [1] = L["The Rookery"]
}

MDT.dungeonTotalCount[dungeonIndex] = { normal = 100, teeming = 1000, teemingEnabled = true }

MDT.mapPOIs[dungeonIndex] = {

};

MDT.dungeonEnemies[dungeonIndex] = {}
