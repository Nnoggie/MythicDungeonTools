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
    [3] = {
      zoomScale = 1.2999999523163;
      horizontalPan = 1.6514100445647e-07;
      verticalPan = 67.74931221652;
    };
  }
};

MDT.dungeonMaps[dungeonIndex] = {
  [0] = "BlackrockTrainDepotDungeon",
  [1] = "BlackrockTrainDepotDungeon1_",
  [2] = "BlackrockTrainDepotDungeon3_",
  [3] = "BlackrockTrainDepotDungeon4_",
}
MDT.dungeonSubLevels[dungeonIndex] = {
   [1] = L["Train Depot"],
   [2] = L["Rear Train Cars"],
   [3] = L["Forward Train Cars"],
}

MDT.mapPOIs[dungeonIndex] = {
   [1] = {
      [1] = {
         ["y"] = -146.55704410401;
         ["x"] = 272.74253550408;
         ["template"] = "DeathReleasePinTemplate";
         ["graveyardDescription"] = "";
         ["type"] = "graveyard";
      };
      [2] = {
         ["y"] = -148.9020750582;
         ["x"] = 613.94970549122;
         ["connectionIndex"] = 1;
         ["target"] = 2;
         ["type"] = "mapLink";
         ["template"] = "MapLinkPinTemplate";
         ["direction"] = 1;
      };
   };
   [2] = {
      [1] = {
         ["y"] = -289.01985508997;
         ["x"] = 66.962949454542;
         ["connectionIndex"] = 1;
         ["target"] = 1;
         ["type"] = "mapLink";
         ["template"] = "MapLinkPinTemplate";
         ["direction"] = -2;
      };
      [2] = {
         ["y"] = -289.60611282852;
         ["x"] = 759.34390580926;
         ["connectionIndex"] = 2;
         ["target"] = 3;
         ["type"] = "mapLink";
         ["template"] = "MapLinkPinTemplate";
         ["direction"] = 2;
      };
   };
   [3] = {
      [1] = {
         ["y"] = -288.43359735142;
         ["x"] = 25.338012635218;
         ["connectionIndex"] = 2;
         ["target"] = 2;
         ["type"] = "mapLink";
         ["template"] = "MapLinkPinTemplate";
         ["direction"] = -2;
      };
   };
};




 MDT.dungeonTotalCount[dungeonIndex] = {normal=1000,teeming=1000,teemingEnabled=true}
 MDT.dungeonEnemies[dungeonIndex] = {}