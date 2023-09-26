local addonName = ...
local MDT = MDT
local L = MDT.L
local dungeonIndex = 104
MDT.dungeonList[dungeonIndex] = L["The Everbloom"]
MDT.mapInfo[dungeonIndex] = {
  viewportPositionOverrides = {
    [1] = {
      zoomScale = 1.5999999046326,
      horizontalPan = 228.4558682649,
      verticalPan = 33.964536915655,
    },
  }
};

local zones = { 620, 621 }
for _, zone in ipairs(zones) do
  MDT.zoneIdToDungeonIdx[zone] = dungeonIndex
end

MDT.dungeonMaps[dungeonIndex] = {
  [0] = "",
  [1] = { customTextures = 'Everbloom' },
}

MDT.dungeonSubLevels[dungeonIndex] = {
  [1] = L["The Everbloom"],
}

MDT.dungeonTotalCount[dungeonIndex] = { normal = 100, teeming = 1000, teemingEnabled = true }

MDT.mapPOIs[dungeonIndex] = {};

MDT.dungeonEnemies[dungeonIndex] = {};
