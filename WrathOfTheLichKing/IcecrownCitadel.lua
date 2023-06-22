local MDT = MDT
local L = MDT.L

local dungeonIndex = 81
MDT.dungeonList[dungeonIndex] = L["icc"]
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
  [0] = "IcecrownCitadel",
  [1] = "icecrowncitadel1_",
  [2] = "icecrowncitadel2_",
  [3] = "icecrowncitadel3_",
  [4] = "icecrowncitadel4_",
  [5] = "icecrowncitadel5_",
  [6] = "icecrowncitadel6_",
  [7] = "icecrowncitadel7_",
  [8] = "icecrowncitadel8_",
}

MDT.dungeonSubLevels[dungeonIndex] = {
  [1] = L["iccFloor1"],
  [2] = L["iccFloor2"],
  [3] = L["iccFloor3"],
  [4] = L["iccFloor4"],
  [5] = L["iccFloor5"],
  [6] = L["iccFloor6"],
  [7] = L["iccFloor7"],
  [8] = L["iccFloor8"],
}

MDT.dungeonTotalCount[dungeonIndex] = { normal = 300, teeming = 1000, teemingEnabled = true }

MDT.mapPOIs[dungeonIndex] = {

};

MDT.dungeonEnemies[dungeonIndex] = {

};

