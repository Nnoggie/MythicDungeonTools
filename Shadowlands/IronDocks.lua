local MDT = MDT
local L = MDT.L
local dungeonIndex = 41
MDT.dungeonList[dungeonIndex] = L["IronDocks"]
MDT.dungeonMaps[dungeonIndex] = {
  [0] = "IronDocks",
  [1] = "IronDocks1_",
}
MDT.dungeonSubLevels[dungeonIndex] = {
  [1] = L["IronDocks"],
}
MDT.mapInfo[dungeonIndex] = {
  viewportPositionOverrides = {
    [1] = {
      zoomScale = 1.2999999523163;
      horizontalPan = 193.84615203593;
      verticalPan = 39.418697423882;
    };
  }
};

MDT.dungeonTotalCount[dungeonIndex] = { normal = 1000, teeming = 1000, teemingEnabled = true }

MDT.mapPOIs[dungeonIndex] = {
  [1] = {
    [1] = {
      ["template"] = "DeathReleasePinTemplate";
      ["type"] = "graveyard";
      ["x"] = 248.70555745877;
      ["y"] = -246.22239132748;
      ["graveyardDescription"] = "";
    };
  };
};

MDT.dungeonEnemies[dungeonIndex] = {
};
