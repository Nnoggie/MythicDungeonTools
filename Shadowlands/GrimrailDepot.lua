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
MDT.dungeonTotalCount[dungeonIndex] = { normal = 1000, teeming = 1000, teemingEnabled = true }

MDT.mapPOIs[dungeonIndex] = {
  [1] = {
    [1] = {
      ["template"] = "MapLinkPinTemplate";
      ["type"] = "mapLink";
      ["x"] = 608.1555672928;
      ["y"] = -146.89221596194;
      ["target"] = 2;
      ["direction"] = 1;
      ["connectionIndex"] = 1;
    };
    [2] = {
      ["template"] = "DeathReleasePinTemplate";
      ["type"] = "graveyard";
      ["x"] = 273.83563921658;
      ["y"] = -144.28666476245;
      ["graveyardDescription"] = "";
    };
  };
  [2] = {
    [1] = {
      ["template"] = "MapLinkPinTemplate";
      ["type"] = "mapLink";
      ["x"] = 575.32466428391;
      ["y"] = -141.61582922212;
      ["target"] = 1;
      ["direction"] = -1;
      ["connectionIndex"] = 1;
    };
    [2] = {
      ["template"] = "MapLinkPinTemplate";
      ["type"] = "mapLink";
      ["x"] = 589.39491710193;
      ["y"] = -419.50622414568;
      ["target"] = 3;
      ["direction"] = 2;
      ["connectionIndex"] = 2;
    };
  };
  [3] = {
    [1] = {
      ["template"] = "MapLinkPinTemplate";
      ["type"] = "mapLink";
      ["x"] = 752.81400720267;
      ["y"] = -289.68656596226;
      ["target"] = 2;
      ["direction"] = 1;
      ["connectionIndex"] = 2;
    };
    [2] = {
      ["template"] = "MapLinkPinTemplate";
      ["type"] = "mapLink";
      ["x"] = 61.660226201996;
      ["y"] = -289.10965170246;
      ["target"] = 4;
      ["direction"] = -2;
      ["connectionIndex"] = 3;
    };
  };
  [4] = {
    [1] = {
      ["template"] = "MapLinkPinTemplate";
      ["type"] = "mapLink";
      ["x"] = 779.35252531897;
      ["y"] = -287.37894193484;
      ["target"] = 3;
      ["direction"] = 2;
      ["connectionIndex"] = 3;
    };
  };
};

MDT.dungeonEnemies[dungeonIndex] = {
};
