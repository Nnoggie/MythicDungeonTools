local addonName = ...
local MDT = MDT
local L = MDT.L
local dungeonIndex = 150
MDT.dungeonList[dungeonIndex] = L["PitOfSaron"]
MDT.mapInfo[dungeonIndex] = {
  teleportId = 1254555,
  shortName = L["PitOfSaronShortName"],
  englishName = "Pit of Saron",
  mapID = 556
};
local zones = { 184 }
for _, zone in ipairs(zones) do
  MDT.zoneIdToDungeonIdx[zone] = dungeonIndex
end

MDT.dungeonMaps[dungeonIndex] = {
  [0] = "",
  [1] = { customTextures = 'Interface\\AddOns\\'..addonName..'\\Midnight\\Textures\\PitOfSaron' }
}

MDT.dungeonSubLevels[dungeonIndex] = {
  [1] = L["PitOfSaron"],
}

MDT.dungeonTotalCount[dungeonIndex] = { normal = 470 }

MDT.mapPOIs[dungeonIndex] = {
  [1] = {
    [1] = {
      ["type"] = "dungeonEntrance",
      ["x"] = 413.92896843808,
      ["y"] = -300.59529830036,
      ["sizeMult"] = 1.5,
    },
    [2] = {
      ["type"] = "genericItem",
      ["x"] = 475.23844366361,
      ["y"] = -236.90473667213,
      ["info"] = {
        ["name"] = "exampleItemNameNoSpellId",
        ["description"] = "exampleItemDescriptionNoSpellId",
        ["texture"] = 134413,
        ["size"] = 50,
      },
    },
    [3] = {
      ["type"] = "genericItem",
      ["x"] = 338.33372411185,
      ["y"] = -222.61906975082,
      ["info"] = {
        ["description"] = "exampleItemDescriptionWithSpellId",
        ["texture"] = 6891020,
        ["spellId"] = 1239141,
        ["size"] = 50,
      },
    },
  },
};

MDT.dungeonEnemies[dungeonIndex] = {};
