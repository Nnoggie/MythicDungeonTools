local MDT = MDT
local L = MDT.L

local dungeonIndex = 80
MDT.dungeonList[dungeonIndex] = L["togc"]
MDT.mapInfo[dungeonIndex] = {
  --  viewportPositionOverrides =
  --  {
  --    [1] = {
  --      zoomScale = 1.2999999523163;
  --      horizontalPan = 102.41712541524;
  --      verticalPan = 87.49594729527;
  --    };
  --  }
};

MDT.dungeonMaps[dungeonIndex] = {
  [0] = "TheArgentColiseum",
  [1] = "theargentcoliseum1_",
  [2] = "theargentcoliseum2_",
}

MDT.dungeonSubLevels[dungeonIndex] = {
  [1] = L["togcFloor1"],
  [2] = L["togcFloor2"],
}

MDT.dungeonTotalCount[dungeonIndex] = { normal = 300, teeming = 1000, teemingEnabled = true }

MDT.mapPOIs[dungeonIndex] = {
  [1] = {
    [1] = {
      ["template"] = "MapLinkPinTemplate";
      ["type"] = "mapLink";
      ["x"] = 648.26949289983;
      ["y"] = -291.02275959045;
      ["target"] = 2;
      ["direction"] = -1;
    };
  };
  [2] = {
    [1] = {
      ["template"] = "MapLinkPinTemplate";
      ["type"] = "mapLink";
      ["x"] = 438.61966300302;
      ["y"] = -502.56144288169;
      ["target"] = 1;
      ["direction"] = 1;
    };
  };
};


MDT.dungeonEnemies[dungeonIndex] = {

};

