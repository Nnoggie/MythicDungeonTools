local MDT = MDT
local L = MDT.L
local dungeonIndex = 40
MDT.dungeonList[dungeonIndex] = L["GrimrailDepot"]
MDT.mapInfo[dungeonIndex] = {
  viewportPositionOverrides = {
    [1] = {
      zoomScale = 1.2999999523163;
      horizontalPan = 108.09110952974;
      verticalPan = 18.640150307329;
    };
  }
};

MDT.dungeonMaps[dungeonIndex] = {
  [0] = "BlackrockTrainDepotDungeon",
  [1] = "BlackrockTrainDepotDungeon1_",
  [2] = "BlackrockTrainDepotDungeon2_",
  [3] = "BlackrockTrainDepotDungeon3_",
  [4] = "BlackrockTrainDepotDungeon4_",
}
MDT.dungeonSubLevels[dungeonIndex] = {
  [1] = L["Train Depot"],
  [2] = L["Rafters"],
  [3] = L["Rear Train Cars"],
  [4] = L["Forward Train Cars"],
}

MDT.mapPOIs[dungeonIndex] = {
  [1] = {
    [1] = {
      y = -146.89221596194,
      x = 608.1555672928,
      template = "MapLinkPinTemplate",
      type = "mapLink",
      target = 2,
      direction = 1,
      connectionIndex = 1,
    },
    [2] = {
      y = -144.28666476245,
      x = 273.83563921658,
      template = "DeathReleasePinTemplate",
      type = "graveyard",
      graveyardDescription = "",
    },
  },
  [2] = {
    [1] = {
      y = -141.61582922212,
      x = 575.32466428391,
      template = "MapLinkPinTemplate",
      type = "mapLink",
      target = 1,
      direction = -1,
      connectionIndex = 1,
    },
    [2] = {
      y = -419.50622414568,
      x = 589.39491710193,
      template = "MapLinkPinTemplate",
      type = "mapLink",
      target = 3,
      direction = 2,
      connectionIndex = 2,
    },
  },
  [3] = {
    [1] = {
      y = -289.68656596226,
      x = 752.81400720267,
      template = "MapLinkPinTemplate",
      type = "mapLink",
      target = 2,
      direction = 1,
      connectionIndex = 2,
    },
    [2] = {
      y = -289.10965170246,
      x = 61.660226201996,
      template = "MapLinkPinTemplate",
      type = "mapLink",
      target = 4,
      direction = -2,
      connectionIndex = 3,
    },
  },
  [4] = {
    [1] = {
      y = -287.37894193484,
      x = 779.35252531897,
      template = "MapLinkPinTemplate",
      type = "mapLink",
      target = 3,
      direction = 2,
      connectionIndex = 3,
    },
  },
}

MDT.dungeonTotalCount[dungeonIndex] = { normal = 1000, teeming = 1000, teemingEnabled = true }
MDT.dungeonEnemies[dungeonIndex] = {}
