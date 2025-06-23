local addonName = ...
local MDT = MDT
local L = MDT.L

local dungeonIndex = 123
MDT.dungeonList[dungeonIndex] = L["Eco-Dome Al'dani"]
MDT.mapInfo[dungeonIndex] = {
  teleportId = 1237215,
  shortName = L["ecoDomeAldaniShortName"],
  englishName = "Eco-Dome Al'dani",
  mapID = 542
}

local zones = {} -- TODO
for _, zone in ipairs(zones) do
  MDT.zoneIdToDungeonIdx[zone] = dungeonIndex
end

MDT.dungeonMaps[dungeonIndex] = {
  [0] = "",
  [1] = { customTextures = 'Interface\\AddOns\\'..addonName..'\\TheWarWithin\\Textures\\EcoDomeAldani' }
}

MDT.dungeonSubLevels[dungeonIndex] = {
  [1] = L["Eco-Dome Al'dani"]
}

MDT.dungeonTotalCount[dungeonIndex] = { normal = 485, teeming = 1000, teemingEnabled = true }

MDT.mapPOIs[dungeonIndex] = {

};

MDT.dungeonEnemies[dungeonIndex] = {};
