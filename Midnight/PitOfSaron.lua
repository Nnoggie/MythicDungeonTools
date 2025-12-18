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
      ["x"] = 822.00553571743,
      ["y"] = -111.94358107728,
      ["sizeMult"] = 1.5,
    },
    [2] = {
      ["type"] = "genericItem",
      ["x"] = 795.63831666907,
      ["y"] = -144.50366473795,
      ["info"] = {
        name = "Item without spellId", -- all of these strings should obviously localized: L["..."]
        description = "This item does xyz...".."\n\n".."More description text.",
        texture = 134413,
        size = 50,
      },
    },
    [3] = {
      ["type"] = "genericItem",
      ["x"] = 735.63831666907,
      ["y"] = -144.50366473795,
      ["info"] = {
        description = "Item with spellId...".."\n\n".."More description text.",
        spellId = 1239141,
        texture = 6891020,
        size = 50,
      },
    },
  },
};

MDT.dungeonEnemies[dungeonIndex] = {};
