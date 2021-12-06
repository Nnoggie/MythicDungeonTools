local MDT = MDT
local L = MDT.L
local dungeonIndex = 37
MDT.dungeonList[dungeonIndex] = L["TazaveshLower"]
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
   [2] = "Brokerdungeon_b",
   [3] = "Brokerdungeon_c",
   [4] = "Brokerdungeon_d",
}

MDT.dungeonTotalCount[dungeonIndex] = {normal=160,teeming=192,teemingEnabled=true}

MDT.mapPOIs[dungeonIndex] = {
    [1] = {
       [1] = {
          ["y"] = -353.24711814285;
          ["x"] = 366.3568478256;
          ["connectionIndex"] = 1;
          ["target"] = 2;
          ["type"] = "mapLink";
          ["template"] = "MapLinkPinTemplate";
          ["direction"] = 2;
       };
       [2] = {
          ["y"] = -237.96954332336;
          ["x"] = 333.46579433805;
          ["connectionIndex"] = 2;
          ["target"] = 3;
          ["type"] = "mapLink";
          ["template"] = "MapLinkPinTemplate";
          ["direction"] = -2;
       };
       [3] = {
          ["y"] = -154.10258483958;
          ["x"] = 347.49727301494;
          ["connectionIndex"] = 3;
          ["target"] = 4;
          ["type"] = "mapLink";
          ["template"] = "MapLinkPinTemplate";
          ["direction"] = -2;
       };
    };
    [2] = {
       [1] = {
          ["y"] = -107.06677772897;
          ["x"] = 310.27427710206;
          ["connectionIndex"] = 1;
          ["target"] = 1;
          ["type"] = "mapLink";
          ["template"] = "MapLinkPinTemplate";
          ["direction"] = -2;
       };
    };
    [3] = {
       [1] = {
          ["y"] = -359.07397950769;
          ["x"] = 662.06461673007;
          ["connectionIndex"] = 2;
          ["target"] = 1;
          ["type"] = "mapLink";
          ["template"] = "MapLinkPinTemplate";
          ["direction"] = 2;
       };
    };
    [4] = {
       [1] = {
          ["y"] = -487.26258086352;
          ["x"] = 531.69093773083;
          ["connectionIndex"] = 3;
          ["target"] = 1;
          ["type"] = "mapLink";
          ["template"] = "MapLinkPinTemplate";
          ["direction"] = 2;
       };
    };
 };

