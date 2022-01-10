local MDT = MDT
local L = MDT.L
local dungeonIndex = 38
MDT.dungeonList[dungeonIndex] = L["TazaveshUpper"]
MDT.mapInfo[dungeonIndex] = {
    tileFormat = {

    },
    viewportPositionOverrides =
    {
        
    };
};

MDT.dungeonMaps[dungeonIndex] = {
   [0] = "Brokerdungeonstormheim",
   [1] = "Brokerdungeonstormheim",
   [2] = "Brokerdungeon_aggramar",
   [3] = "Brokerdungeon_borallus",
   [4] = "Brokerdungeon_e",
}
MDT.dungeonSubLevels[dungeonIndex] = {
    [1] = L["TazaveshFloor5"],
    [2] = L["TazaveshFloor6"],
    [3] = L["TazaveshFloor7"],
    [4] = L["TazaveshFloor8"],
}

MDT.dungeonTotalCount[dungeonIndex] = {normal=160,teeming=192,teemingEnabled=true}
MDT.mapPOIs[dungeonIndex] = {
    [1] = {
       [1] = {
          ["y"] = -297.16465402191;
          ["x"] = 538.2460884279;
          ["connectionIndex"] = 1;
          ["target"] = 3;
          ["type"] = "mapLink";
          ["template"] = "MapLinkPinTemplate";
          ["direction"] = 2;
       };
      [2] = {
         ["y"] = -106.33895309988;
         ["x"] = 191.11163560234;
         ["template"] = "DeathReleasePinTemplate";
         ["graveyardDescription"] = "";
         ["type"] = "graveyard";
      };
    };
    [2] = {
       [1] = {
          ["y"] = -133.28719090954;
          ["x"] = 152.95188346973;
          ["connectionIndex"] = 1;
          ["target"] = 2;
          ["type"] = "mapLink";
          ["template"] = "MapLinkPinTemplate";
          ["direction"] = -2;
       };
       [2] = {
          ["y"] = -320.47170086583;
          ["x"] = 534.60425588888;
          ["connectionIndex"] = 2;
          ["target"] = 4;
          ["type"] = "mapLink";
          ["template"] = "MapLinkPinTemplate";
          ["direction"] = -1;
       };
    };
    [3] = {
       [1] = {
          ["y"] = -200.29488416438;
          ["x"] = 660.60781085846;
          ["connectionIndex"] = 2;
          ["target"] = 3;
          ["type"] = "mapLink";
          ["template"] = "MapLinkPinTemplate";
          ["direction"] = 1;
       };
       [2] = {
          ["y"] = -345.9637472103;
          ["x"] = 364.90002325125;
          ["connectionIndex"] = 3;
          ["target"] = 5;
          ["type"] = "mapLink";
          ["template"] = "MapLinkPinTemplate";
          ["direction"] = -2;
       };
    };
    [4] = {
       [1] = {
          ["y"] = -299.3496847796;
          ["x"] = 698.48184402983;
          ["connectionIndex"] = 3;
          ["target"] = 4;
          ["type"] = "mapLink";
          ["template"] = "MapLinkPinTemplate";
          ["direction"] = 2;
       };
    };
 };

