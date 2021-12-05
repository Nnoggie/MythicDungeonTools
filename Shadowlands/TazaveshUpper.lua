local MDT = MDT
local L = MDT.L
local dungeonIndex = 38
MDT.mapInfo[dungeonIndex] = {
    tileFormat = {
        [1] = 15,
    },
    viewportPositionOverrides =
    {
        
    };
};

MDT.dungeonMaps[dungeonIndex] = {
   [0] = "Brokerdungeonstormheim",
   [1] = "Brokerdungeon_a",
   [2] = "Brokerdungeonstormheim",
   [3] = "Brokerdungeon_aggramar",
   [4] = "Brokerdungeon_borallus",
   [5] = "Brokerdungeon_e",
}

MDT.dungeonTotalCount[dungeonIndex] = {normal=160,teeming=192,teemingEnabled=true}
MDT.mapPOIs[dungeonIndex] = {
    [1] = {
       [1] = {
          ["y"] = -300.66597086773;
          ["x"] = 259.58803612169;
          ["connectionIndex"] = 1;
          ["target"] = 2;
          ["type"] = "mapLink";
          ["template"] = "MapLinkPinTemplate";
          ["direction"] = -1;
       };
    };
    [2] = {
       [1] = {
          ["y"] = -482.16413322051;
          ["x"] = 176.25896157079;
          ["connectionIndex"] = 1;
          ["target"] = 1;
          ["type"] = "mapLink";
          ["template"] = "MapLinkPinTemplate";
          ["direction"] = 1;
       };
       [2] = {
          ["y"] = -297.16465402191;
          ["x"] = 538.2460884279;
          ["connectionIndex"] = 2;
          ["target"] = 3;
          ["type"] = "mapLink";
          ["template"] = "MapLinkPinTemplate";
          ["direction"] = 2;
       };
    };
    [3] = {
       [1] = {
          ["y"] = -133.28719090954;
          ["x"] = 152.95188346973;
          ["connectionIndex"] = 2;
          ["target"] = 2;
          ["type"] = "mapLink";
          ["template"] = "MapLinkPinTemplate";
          ["direction"] = -2;
       };
       [2] = {
          ["y"] = -320.47170086583;
          ["x"] = 534.60425588888;
          ["connectionIndex"] = 3;
          ["target"] = 4;
          ["type"] = "mapLink";
          ["template"] = "MapLinkPinTemplate";
          ["direction"] = -1;
       };
    };
    [4] = {
       [1] = {
          ["y"] = -200.29488416438;
          ["x"] = 660.60781085846;
          ["connectionIndex"] = 3;
          ["target"] = 3;
          ["type"] = "mapLink";
          ["template"] = "MapLinkPinTemplate";
          ["direction"] = 1;
       };
       [2] = {
          ["y"] = -345.9637472103;
          ["x"] = 364.90002325125;
          ["connectionIndex"] = 4;
          ["target"] = 5;
          ["type"] = "mapLink";
          ["template"] = "MapLinkPinTemplate";
          ["direction"] = -2;
       };
    };
    [5] = {
       [1] = {
          ["y"] = -299.3496847796;
          ["x"] = 698.48184402983;
          ["connectionIndex"] = 4;
          ["target"] = 4;
          ["type"] = "mapLink";
          ["template"] = "MapLinkPinTemplate";
          ["direction"] = 2;
       };
    };
 };
 
