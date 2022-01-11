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
      [1] = {
         zoomScale = 1.5999999046326;
         horizontalPan = 222.75250537761;
         verticalPan = 84.325979333013;
      };
      [2] = {
         zoomScale = 1.2999999523163;
         horizontalPan = 105.79615469643;
         verticalPan = 83.972826369913;
      };
      [3] = {
         zoomScale = 1.5999999046326;
         horizontalPan = 235.80222224981;
         verticalPan = 74.285128151421;
      };
      [4] = {
         zoomScale = 1.5999999046326;
         horizontalPan = 140.1017757213;
         verticalPan = 108.37205473203;
      };
    };
};

MDT.dungeonMaps[dungeonIndex] = {
   [0] = "Brokerdungeonstormheim",
   [1] = "Brokerdungeon_a",
   [2] = "Brokerdungeon_d",
   [3] = "Brokerdungeon_c",
   [4] = "Brokerdungeon_b",
}
MDT.dungeonSubLevels[dungeonIndex] = {
    [1] = L["TazaveshFloor1"],
    [2] = L["TazaveshFloor4"],
    [3] = L["TazaveshFloor3"],
    [4] = L["TazaveshFloor2"],
}

MDT.dungeonTotalCount[dungeonIndex] = {normal=160,teeming=192,teemingEnabled=true}

MDT.mapPOIs[dungeonIndex] = {
   [1] = {
      [1] = {
         ["y"] = -149.94858685024;
         ["x"] = 345.06586806854;
         ["connectionIndex"] = 1;
         ["target"] = 2;
         ["direction"] = 2;
         ["template"] = "MapLinkPinTemplate";
         ["type"] = "mapLink";
      };
      [2] = {
         ["y"] = -237.96954332336;
         ["x"] = 333.46579433805;
         ["connectionIndex"] = 2;
         ["target"] = 3;
         ["direction"] = -2;
         ["template"] = "MapLinkPinTemplate";
         ["type"] = "mapLink";
      };
      [3] = {
         ["y"] = -349.54538525121;
         ["x"] = 363.60839738792;
         ["connectionIndex"] = 3;
         ["target"] = 4;
         ["direction"] = -2;
         ["template"] = "MapLinkPinTemplate";
         ["type"] = "mapLink";
      };
   };
   [2] = {
      [1] = {
         ["y"] = -461.77095672117;
         ["x"] = 516.68209832419;
         ["connectionIndex"] = 1;
         ["target"] = 1;
         ["direction"] = -2;
         ["template"] = "MapLinkPinTemplate";
         ["type"] = "mapLink";
      };
   };
   [4] = {
      [1] = {
         ["y"] = -153.68118872569;
         ["x"] = 334.59643934341;
         ["connectionIndex"] = 3;
         ["target"] = 1;
         ["direction"] = 2;
         ["template"] = "MapLinkPinTemplate";
         ["type"] = "mapLink";
      };
   };
   [3] = {
      [1] = {
         ["y"] = -359.07397950769;
         ["x"] = 662.06461673007;
         ["connectionIndex"] = 2;
         ["target"] = 1;
         ["direction"] = 2;
         ["template"] = "MapLinkPinTemplate";
         ["type"] = "mapLink";
      };
   };
};


 MDT.dungeonTotalCount[dungeonIndex] = {normal=330,teeming=1000,teemingEnabled=true}
 MDT.dungeonEnemies[dungeonIndex] = {
   [27] = {
      ["clones"] = {
         [1] = {
            ["y"] = -392.30500370816;
            ["x"] = 484.37659155408;
            ["sublevel"] = 4;
         };
      };
      ["id"] = 176705;
      ["isBoss"] = true;
      ["encounterID"] = 2454;
      ["instanceID"] = 0;
      ["name"] = "Venza Goldfuse";
      ["health"] = 766505;
      ["displayId"] = 100564;
      ["creatureType"] = "Humanoid";
      ["level"] = 62;
      ["count"] = 0;
      ["scale"] = 2;
   };
   [2] = {
      ["clones"] = {
         [1] = {
            ["y"] = -274.37463687151;
            ["x"] = 692.07389749702;
            ["sublevel"] = 1;
         };
      };
      ["id"] = 178392;
      ["name"] = "Gatewarden Zo'mazz";
      ["health"] = 280832;
      ["displayId"] = 101505;
      ["creatureType"] = "Humanoid";
      ["level"] = 61;
      ["count"] = 10;
      ["scale"] = 1;
   };
   [3] = {
      ["clones"] = {
         [1] = {
            ["y"] = -261.46391061453;
            ["x"] = 657.00715137068;
            ["sublevel"] = 1;
         };
         [2] = {
            ["y"] = -251.54212290503;
            ["x"] = 642.40852205006;
            ["sublevel"] = 1;
         };
         [4] = {
            ["y"] = -251.18865921788;
            ["x"] = 621.00178784267;
            ["sublevel"] = 1;
         };
         [3] = {
            ["y"] = -260.58955307263;
            ["x"] = 636.38885578069;
            ["sublevel"] = 1;
         };
      };
      ["id"] = 177817;
      ["name"] = "Support Officer";
      ["health"] = 148676;
      ["displayId"] = 100876;
      ["creatureType"] = "Humanoid";
      ["level"] = 60;
      ["count"] = 4;
      ["scale"] = 1;
   };
   [4] = {
      ["clones"] = {
         [6] = {
            ["y"] = -267.90067039106;
            ["x"] = 605.23301549464;
            ["sublevel"] = 1;
         };
         [2] = {
            ["y"] = -254.01636871508;
            ["x"] = 642.67759237187;
            ["sublevel"] = 1;
         };
         [3] = {
            ["y"] = -252.39167597765;
            ["x"] = 644.05423122765;
            ["sublevel"] = 1;
         };
         [1] = {
            ["y"] = -277.95888268156;
            ["x"] = 648.89749702026;
            ["sublevel"] = 1;
         };
         [4] = {
            ["y"] = -262.54910614525;
            ["x"] = 636.22616209774;
            ["sublevel"] = 1;
         };
         [5] = {
            ["y"] = -253.29083798883;
            ["x"] = 619.8942193087;
            ["sublevel"] = 1;
         };
         [7] = {
            ["y"] = -281.44391061453;
            ["x"] = 615.30125148987;
            ["sublevel"] = 1;
         };
      };
      ["id"] = 177816;
      ["name"] = "Interrogation Specialist";
      ["health"] = 148676;
      ["displayId"] = 100877;
      ["creatureType"] = "Humanoid";
      ["level"] = 60;
      ["count"] = 4;
      ["scale"] = 1;
   };
   [5] = {
      ["clones"] = {
         [1] = {
            ["y"] = -261.74916201117;
            ["x"] = 635.45649582837;
            ["sublevel"] = 1;
         };
         [2] = {
            ["y"] = -276.64424581006;
            ["x"] = 585.72228843862;
            ["sublevel"] = 1;
         };
         [3] = {
            ["y"] = -269.3269273743;
            ["x"] = 585.37187127533;
            ["sublevel"] = 1;
         };
      };
      ["id"] = 177808;
      ["name"] = "Armored Overseer";
      ["health"] = 264312;
      ["displayId"] = 100874;
      ["creatureType"] = "Humanoid";
      ["level"] = 61;
      ["count"] = 8;
      ["scale"] = 1;
   };
   [6] = {
      ["clones"] = {
         [1] = {
            ["y"] = -237.26508144719;
            ["x"] = 633.05495041215;
            ["sublevel"] = 1;
         };
      };
      ["id"] = 179334;
      ["name"] = "Portalmancer Zo'honn";
      ["health"] = 330390;
      ["displayId"] = 100877;
      ["creatureType"] = "Humanoid";
      ["level"] = 61;
      ["count"] = 16;
      ["scale"] = 1;
   };
   [7] = {
      ["clones"] = {
         [1] = {
            ["y"] = -220.16183182191;
            ["x"] = 633.27826737562;
            ["sublevel"] = 1;
         };
      };
      ["id"] = 175616;
      ["isBoss"] = true;
      ["encounterID"] = 2437;
      ["instanceID"] = 0;
      ["name"] = "Zo'phex";
      ["health"] = 1156365;
      ["displayId"] = 100049;
      ["creatureType"] = "Humanoid";
      ["level"] = 62;
      ["count"] = 0;
      ["scale"] = 1;
   };
   [8] = {
      ["clones"] = {
         [1] = {
            ["y"] = -301.43631284916;
            ["x"] = 510.62038140644;
            ["sublevel"] = 1;
         };
      };
      ["id"] = 179837;
      ["name"] = "Tracker Zo'korss";
      ["health"] = 495585;
      ["displayId"] = 101474;
      ["creatureType"] = "Humanoid";
      ["level"] = 61;
      ["count"] = 20;
      ["scale"] = 1;
   };
   [10] = {
      ["clones"] = {
         [1] = {
            ["y"] = -346.74787709497;
            ["x"] = 463.53307508939;
            ["sublevel"] = 1;
         };
      };
      ["id"] = 180495;
      ["name"] = "Enraged Direhorn";
      ["health"] = 330390;
      ["displayId"] = 47441;
      ["creatureType"] = "Beast";
      ["level"] = 60;
      ["count"] = 10;
      ["scale"] = 1;
   };
   [12] = {
      ["clones"] = {
         [13] = {
            ["y"] = -267.13793296089;
            ["x"] = 334.92371871275;
            ["sublevel"] = 1;
         };
         [7] = {
            ["y"] = -282.02061452514;
            ["x"] = 375.84117997616;
            ["sublevel"] = 1;
         };
         [1] = {
            ["y"] = -309.6217877095;
            ["x"] = 380.69070321812;
            ["sublevel"] = 1;
         };
         [2] = {
            ["y"] = -311.93480446927;
            ["x"] = 378.80721096544;
            ["sublevel"] = 1;
         };
         [4] = {
            ["y"] = -298.34195530726;
            ["x"] = 369.82151370679;
            ["sublevel"] = 1;
         };
         [8] = {
            ["y"] = -331.38150837989;
            ["x"] = 353.39570917759;
            ["sublevel"] = 1;
         };
         [9] = {
            ["y"] = -327.95849162011;
            ["x"] = 330.00536352801;
            ["sublevel"] = 1;
         };
         [5] = {
            ["y"] = -311.79837988827;
            ["x"] = 358.20768772348;
            ["sublevel"] = 1;
         };
         [10] = {
            ["y"] = -331.70396648045;
            ["x"] = 334.8173420739;
            ["sublevel"] = 1;
         };
         [3] = {
            ["y"] = -301.36189944134;
            ["x"] = 370.02175208582;
            ["sublevel"] = 1;
         };
         [6] = {
            ["y"] = -282.54150837989;
            ["x"] = 370.82896305125;
            ["sublevel"] = 1;
         };
         [12] = {
            ["y"] = -269.0912849162;
            ["x"] = 355.03516090584;
            ["sublevel"] = 1;
         };
         [11] = {
            ["y"] = -267.52860335196;
            ["x"] = 355.30423122765;
            ["sublevel"] = 1;
         };
      };
      ["id"] = 179840;
      ["name"] = "Market Peacekeeper";
      ["health"] = 198234;
      ["displayId"] = 101475;
      ["creatureType"] = "Humanoid";
      ["level"] = 60;
      ["count"] = 4;
      ["scale"] = 1;
   };
   [14] = {
      ["clones"] = {
         [2] = {
            ["y"] = -309.88223463687;
            ["x"] = 357.61323003576;
            ["sublevel"] = 1;
         };
         [3] = {
            ["y"] = -284.89793296089;
            ["x"] = 355.5357568534;
            ["sublevel"] = 1;
         };
         [1] = {
            ["y"] = -298.2551396648;
            ["x"] = 365.39749702026;
            ["sublevel"] = 1;
         };
         [4] = {
            ["y"] = -313.37346368715;
            ["x"] = 328.07806912992;
            ["sublevel"] = 1;
         };
         [5] = {
            ["y"] = -283.80033519553;
            ["x"] = 328.90405244339;
            ["sublevel"] = 1;
         };
      };
      ["id"] = 179842;
      ["name"] = "Commerce Enforcer";
      ["health"] = 313871;
      ["displayId"] = 101477;
      ["creatureType"] = "Humanoid";
      ["level"] = 61;
      ["count"] = 8;
      ["scale"] = 1;
   };
   [16] = {
      ["clones"] = {
         [6] = {
            ["y"] = -226.2725698324;
            ["x"] = 467.72556615018;
            ["sublevel"] = 1;
         };
         [2] = {
            ["y"] = -255.35581005587;
            ["x"] = 393.90643623361;
            ["sublevel"] = 1;
         };
         [8] = {
            ["y"] = -194.7894972067;
            ["x"] = 470.87306317044;
            ["sublevel"] = 1;
         };
         [3] = {
            ["y"] = -259.92603351955;
            ["x"] = 429.68027413588;
            ["sublevel"] = 1;
         };
         [1] = {
            ["y"] = -255.95111731844;
            ["x"] = 378.42550655542;
            ["sublevel"] = 1;
         };
         [4] = {
            ["y"] = -260.05005586592;
            ["x"] = 420.20023837902;
            ["sublevel"] = 1;
         };
         [5] = {
            ["y"] = -247.37497206704;
            ["x"] = 436.20679380215;
            ["sublevel"] = 1;
         };
         [7] = {
            ["y"] = -233.21782122905;
            ["x"] = 456.28069129917;
            ["sublevel"] = 1;
         };
      };
      ["id"] = 180348;
      ["name"] = "Cartel Muscle";
      ["health"] = 264312;
      ["displayId"] = 101598;
      ["creatureType"] = "Humanoid";
      ["level"] = 61;
      ["count"] = 8;
      ["scale"] = 1;
   };
   [20] = {
      ["clones"] = {
         [1] = {
            ["y"] = -206.81235129344;
            ["x"] = 326.59945448332;
            ["sublevel"] = 2;
         };
         [2] = {
            ["y"] = -187.6985459049;
            ["x"] = 321.19374406189;
            ["sublevel"] = 2;
         };
      };
      ["id"] = 179269;
      ["name"] = "Oasis Security";
      ["health"] = 396468;
      ["displayId"] = 101270;
      ["creatureType"] = "Humanoid";
      ["level"] = 61;
      ["count"] = 0;
      ["scale"] = 2;
   };
   [24] = {
      ["clones"] = {
         [1] = {
            ["y"] = -194.10115626843;
            ["x"] = 365.13963547503;
            ["sublevel"] = 2;
         };
      };
      ["id"] = 176563;
      ["isBoss"] = true;
      ["encounterID"] = 2452;
      ["instanceID"] = 0;
      ["name"] = "Zo'gron";
      ["health"] = 825975;
      ["displayId"] = 101481;
      ["creatureType"] = "Humanoid";
      ["level"] = 62;
      ["count"] = 0;
      ["scale"] = 2;
   };
   [28] = {
      ["clones"] = {
         [6] = {
            ["y"] = -357.22178559276;
            ["x"] = 480.37467280298;
            ["sublevel"] = 3;
         };
         [2] = {
            ["y"] = -227.13545403835;
            ["x"] = 629.31881056811;
            ["sublevel"] = 3;
         };
         [8] = {
            ["y"] = -197.802;
            ["x"] = 349.08858057631;
            ["sublevel"] = 3;
         };
         [3] = {
            ["y"] = -188.6112;
            ["x"] = 609.06723585913;
            ["sublevel"] = 3;
         };
         [1] = {
            ["y"] = -223.40982532429;
            ["x"] = 604.91510882879;
            ["sublevel"] = 3;
         };
         [4] = {
            ["y"] = -350.4048;
            ["x"] = 446.4909284952;
            ["sublevel"] = 3;
         };
         [5] = {
            ["y"] = -351.02869373838;
            ["x"] = 461.20412539668;
            ["sublevel"] = 3;
         };
         [7] = {
            ["y"] = -221.4672;
            ["x"] = 333.04162219851;
            ["sublevel"] = 3;
         };
      };
      ["id"] = 176396;
      ["name"] = "Defective Sorter";
      ["health"] = 66078;
      ["displayId"] = 100408;
      ["creatureType"] = "Mechanical";
      ["level"] = 60;
      ["count"] = 2;
      ["scale"] = 2;
   };
   [32] = {
      ["clones"] = {
         [1] = {
            ["y"] = -185.5671843628;
            ["x"] = 492.38312530843;
            ["sublevel"] = 3;
         };
      };
      ["id"] = 175646;
      ["isBoss"] = true;
      ["encounterID"] = 2436;
      ["instanceID"] = 0;
      ["name"] = "P.O.S.T. Master";
      ["health"] = 1156365;
      ["displayId"] = 100722;
      ["creatureType"] = "Humanoid";
      ["level"] = 62;
      ["count"] = 0;
      ["scale"] = 2;
   };
   [33] = {
      ["clones"] = {
         [1] = {
            ["y"] = -299.84262569832;
            ["x"] = 287.40464839094;
            ["sublevel"] = 1;
         };
      };
      ["id"] = 175806;
      ["isBoss"] = true;
      ["encounterID"] = 2451;
      ["instanceID"] = 1194;
      ["name"] = "So'azmi";
      ["health"] = 1040729;
      ["displayId"] = 99094;
      ["creatureType"] = "Humanoid";
      ["level"] = 62;
      ["count"] = 0;
      ["scale"] = 1;
   };
   [17] = {
      ["clones"] = {
         [7] = {
            ["y"] = -227.30195530726;
            ["x"] = 457.64481525626;
            ["sublevel"] = 1;
         };
         [1] = {
            ["y"] = -260.05005586592;
            ["x"] = 377.97497020262;
            ["sublevel"] = 1;
         };
         [2] = {
            ["y"] = -261.66854748603;
            ["x"] = 378.03754469607;
            ["sublevel"] = 1;
         };
         [4] = {
            ["y"] = -258.05329608939;
            ["x"] = 427.43384982122;
            ["sublevel"] = 1;
         };
         [8] = {
            ["y"] = -225.74547486034;
            ["x"] = 457.88885578069;
            ["sublevel"] = 1;
         };
         [9] = {
            ["y"] = -196.47620111732;
            ["x"] = 470.61025029797;
            ["sublevel"] = 1;
         };
         [5] = {
            ["y"] = -241.48391061453;
            ["x"] = 440.96871275328;
            ["sublevel"] = 1;
         };
         [10] = {
            ["y"] = -196.18474860335;
            ["x"] = 470.04707985697;
            ["sublevel"] = 1;
         };
         [3] = {
            ["y"] = -251.93279329609;
            ["x"] = 392.26698450536;
            ["sublevel"] = 1;
         };
         [6] = {
            ["y"] = -229.5343575419;
            ["x"] = 464.29022646007;
            ["sublevel"] = 1;
         };
         [12] = {
            ["y"] = -202.7269273743;
            ["x"] = 494.98927294398;
            ["sublevel"] = 1;
         };
         [11] = {
            ["y"] = -204.38262569832;
            ["x"] = 497.4547079857;
            ["sublevel"] = 1;
         };
      };
      ["id"] = 180335;
      ["name"] = "Cartel Smuggler";
      ["health"] = 165195;
      ["displayId"] = 101595;
      ["creatureType"] = "Humanoid";
      ["level"] = 60;
      ["count"] = 4;
      ["scale"] = 1;
   };
   [21] = {
      ["clones"] = {
         [1] = {
            ["y"] = -212.93878858852;
            ["x"] = 308.6504595394;
            ["sublevel"] = 2;
         };
         [2] = {
            ["y"] = -194.47190935587;
            ["x"] = 300.24951642452;
            ["sublevel"] = 2;
         };
      };
      ["id"] = 176565;
      ["name"] = "Disruptive Patron";
      ["health"] = 297351;
      ["displayId"] = 101271;
      ["creatureType"] = "Humanoid";
      ["level"] = 60;
      ["count"] = 0;
      ["scale"] = 2;
   };
   [25] = {
      ["clones"] = {
         [1] = {
            ["y"] = -347.33688323261;
            ["x"] = 484.83110657653;
            ["sublevel"] = 4;
         };
      };
      ["id"] = 176556;
      ["isBoss"] = true;
      ["encounterID"] = 2454;
      ["instanceID"] = 0;
      ["name"] = "Alcruux";
      ["health"] = 660780;
      ["displayId"] = 101039;
      ["creatureType"] = "Aberration";
      ["level"] = 62;
      ["count"] = 0;
      ["scale"] = 2;
   };
   [29] = {
      ["clones"] = {
         [2] = {
            ["y"] = -187.05286481886;
            ["x"] = 632.09777553097;
            ["sublevel"] = 3;
         };
         [3] = {
            ["y"] = -331.8456;
            ["x"] = 458.36926360726;
            ["sublevel"] = 3;
         };
         [1] = {
            ["y"] = -239.91348706138;
            ["x"] = 611.11222560089;
            ["sublevel"] = 3;
         };
         [4] = {
            ["y"] = -216.5832;
            ["x"] = 364.64247598719;
            ["sublevel"] = 3;
         };
         [5] = {
            ["y"] = -196.70415245058;
            ["x"] = 370.18165951889;
            ["sublevel"] = 3;
         };
      };
      ["id"] = 176394;
      ["name"] = "P.O.S.T. Worker";
      ["health"] = 165195;
      ["displayId"] = 100406;
      ["creatureType"] = "Mechanical";
      ["level"] = 60;
      ["count"] = 4;
      ["scale"] = 2;
   };
   [9] = {
      ["clones"] = {
         [1] = {
            ["y"] = -327.18955307263;
            ["x"] = 491.61025029797;
            ["sublevel"] = 1;
         };
         [2] = {
            ["y"] = -332.38608938547;
            ["x"] = 480.20292014303;
            ["sublevel"] = 1;
         };
      };
      ["id"] = 180091;
      ["name"] = "Ancient Core Hound";
      ["health"] = 396468;
      ["displayId"] = 101639;
      ["creatureType"] = "Beast";
      ["level"] = 61;
      ["count"] = 12;
      ["scale"] = 1;
   };
   [11] = {
      ["clones"] = {
         [1] = {
            ["y"] = -331.88379888268;
            ["x"] = 430.21215733015;
            ["sublevel"] = 1;
         };
         [2] = {
            ["y"] = -329.96765363128;
            ["x"] = 432.57747318236;
            ["sublevel"] = 1;
         };
         [4] = {
            ["y"] = -321.37290502793;
            ["x"] = 418.37932061979;
            ["sublevel"] = 1;
         };
         [3] = {
            ["y"] = -328.1569273743;
            ["x"] = 419.26162097735;
            ["sublevel"] = 1;
         };
      };
      ["id"] = 180567;
      ["name"] = "Frenzied Nightclaw";
      ["health"] = 132156;
      ["displayId"] = 101951;
      ["creatureType"] = "Beast";
      ["level"] = 60;
      ["count"] = 4;
      ["scale"] = 1;
   };
   [13] = {
      ["clones"] = {
         [7] = {
            ["y"] = -314.75631284916;
            ["x"] = 330.12425506555;
            ["sublevel"] = 1;
         };
         [1] = {
            ["y"] = -302.77575418994;
            ["x"] = 367.1620977354;
            ["sublevel"] = 1;
         };
         [2] = {
            ["y"] = -294.11899441341;
            ["x"] = 367.18712753278;
            ["sublevel"] = 1;
         };
         [4] = {
            ["y"] = -283.93675977654;
            ["x"] = 353.28933253874;
            ["sublevel"] = 1;
         };
         [8] = {
            ["y"] = -316.61044692737;
            ["x"] = 326.24463647199;
            ["sublevel"] = 1;
         };
         [9] = {
            ["y"] = -267.30536312849;
            ["x"] = 350.88647199046;
            ["sublevel"] = 1;
         };
         [5] = {
            ["y"] = -281.86558659218;
            ["x"] = 357.11889153754;
            ["sublevel"] = 1;
         };
         [10] = {
            ["y"] = -283.84994413408;
            ["x"] = 325.32479141836;
            ["sublevel"] = 1;
         };
         [3] = {
            ["y"] = -311.24648044693;
            ["x"] = 353.90882002384;
            ["sublevel"] = 1;
         };
         [6] = {
            ["y"] = -328.80804469274;
            ["x"] = 353.62097735399;
            ["sublevel"] = 1;
         };
      };
      ["id"] = 179841;
      ["name"] = "Veteran Sparkcaster";
      ["health"] = 148676;
      ["displayId"] = 101476;
      ["creatureType"] = "Humanoid";
      ["level"] = 60;
      ["count"] = 4;
      ["scale"] = 1;
   };
   [15] = {
      ["clones"] = {
         [1] = {
            ["y"] = -298.8938547486;
            ["x"] = 334.0852205006;
            ["sublevel"] = 1;
         };
      };
      ["id"] = 179821;
      ["name"] = "Commander Zo'far";
      ["health"] = 528624;
      ["displayId"] = 101473;
      ["creatureType"] = "Humanoid";
      ["level"] = 61;
      ["count"] = 20;
      ["scale"] = 1;
   };
   [18] = {
      ["clones"] = {
         [7] = {
            ["y"] = -229.82581005587;
            ["x"] = 457.01907032181;
            ["sublevel"] = 1;
         };
         [1] = {
            ["y"] = -262.98318435754;
            ["x"] = 377.96245530393;
            ["sublevel"] = 1;
         };
         [2] = {
            ["y"] = -258.42536312849;
            ["x"] = 377.71215733015;
            ["sublevel"] = 1;
         };
         [4] = {
            ["y"] = -259.14469273743;
            ["x"] = 422.11501787843;
            ["sublevel"] = 1;
         };
         [8] = {
            ["y"] = -223.45726256983;
            ["x"] = 458.36442193087;
            ["sublevel"] = 1;
         };
         [9] = {
            ["y"] = -194.11357541899;
            ["x"] = 472.41239570918;
            ["sublevel"] = 1;
         };
         [5] = {
            ["y"] = -239.54916201117;
            ["x"] = 439.88617401669;
            ["sublevel"] = 1;
         };
         [10] = {
            ["y"] = -204.84770949721;
            ["x"] = 495.78396901073;
            ["sublevel"] = 1;
         };
         [3] = {
            ["y"] = -252.86296089385;
            ["x"] = 396.14660309893;
            ["sublevel"] = 1;
         };
         [6] = {
            ["y"] = -229.70798882682;
            ["x"] = 462.77592371871;
            ["sublevel"] = 1;
         };
      };
      ["id"] = 180336;
      ["name"] = "Cartel Wiseguy";
      ["health"] = 132156;
      ["displayId"] = 101596;
      ["creatureType"] = "Humanoid";
      ["level"] = 60;
      ["count"] = 4;
      ["scale"] = 1;
   };
   [22] = {
      ["clones"] = {
         [1] = {
            ["y"] = -138.87397615742;
            ["x"] = 396.80307026701;
            ["sublevel"] = 2;
         };
         [2] = {
            ["y"] = -167.84868228483;
            ["x"] = 399.20093252026;
            ["sublevel"] = 2;
         };
      };
      ["id"] = 180159;
      ["name"] = "Brawling Patron";
      ["health"] = 198234;
      ["displayId"] = 101546;
      ["creatureType"] = "Humanoid";
      ["level"] = 60;
      ["count"] = 0;
      ["scale"] = 2;
   };
   [26] = {
      ["clones"] = {
         [1] = {
            ["y"] = -375.09788987423;
            ["x"] = 447.60703448319;
            ["sublevel"] = 4;
         };
      };
      ["id"] = 176555;
      ["isBoss"] = true;
      ["encounterID"] = 2454;
      ["instanceID"] = 0;
      ["name"] = "Achillite";
      ["health"] = 613204;
      ["displayId"] = 101044;
      ["creatureType"] = "Mechanical";
      ["level"] = 62;
      ["count"] = 0;
      ["scale"] = 2;
   };
   [30] = {
      ["clones"] = {
         [1] = {
            ["y"] = -205.74868836536;
            ["x"] = 615.364572266;
            ["sublevel"] = 3;
         };
         [2] = {
            ["y"] = -335.81916720741;
            ["x"] = 478.97345117114;
            ["sublevel"] = 3;
         };
         [4] = {
            ["y"] = -209.568;
            ["x"] = 387.99573105656;
            ["sublevel"] = 3;
         };
         [3] = {
            ["y"] = -233.70195095062;
            ["x"] = 353.09781197884;
            ["sublevel"] = 3;
         };
      };
      ["id"] = 176395;
      ["name"] = "Overloaded Mailemental";
      ["health"] = 165195;
      ["displayId"] = 68547;
      ["creatureType"] = "Elemental";
      ["level"] = 60;
      ["count"] = 4;
      ["scale"] = 2;
   };
   [1] = {
      ["clones"] = {
         [6] = {
            ["y"] = -266.47441340782;
            ["x"] = 607.57955899881;
            ["sublevel"] = 1;
         };
         [2] = {
            ["y"] = -280.45653983615;
            ["x"] = 700.13073376325;
            ["sublevel"] = 1;
         };
         [3] = {
            ["y"] = -263.45446927374;
            ["x"] = 659.42878426698;
            ["sublevel"] = 1;
         };
         [1] = {
            ["y"] = -269.51296089385;
            ["x"] = 698.11859356377;
            ["sublevel"] = 1;
         };
         [4] = {
            ["y"] = -279.6517877095;
            ["x"] = 650.78724672229;
            ["sublevel"] = 1;
         };
         [5] = {
            ["y"] = -253.59469273743;
            ["x"] = 622.30333730632;
            ["sublevel"] = 1;
         };
         [7] = {
            ["y"] = -275.74508379888;
            ["x"] = 615.85190703218;
            ["sublevel"] = 1;
         };
      };
      ["id"] = 177807;
      ["name"] = "Customs Security";
      ["health"] = 181715;
      ["displayId"] = 100873;
      ["creatureType"] = "Humanoid";
      ["level"] = 60;
      ["count"] = 4;
      ["scale"] = 1;
   };
   [19] = {
      ["clones"] = {
         [6] = {
            ["y"] = -205.49262569832;
            ["x"] = 524.41805721097;
            ["sublevel"] = 1;
         };
         [2] = {
            ["y"] = -255.02715083799;
            ["x"] = 423.30393325387;
            ["sublevel"] = 1;
         };
         [3] = {
            ["y"] = -241.11804469274;
            ["x"] = 448.08969010727;
            ["sublevel"] = 1;
         };
         [1] = {
            ["y"] = -259.09508379888;
            ["x"] = 394.0315852205;
            ["sublevel"] = 1;
         };
         [4] = {
            ["y"] = -196.41418994413;
            ["x"] = 497.29827175209;
            ["sublevel"] = 1;
         };
         [5] = {
            ["y"] = -195.9305027933;
            ["x"] = 502.12276519666;
            ["sublevel"] = 1;
         };
      };
      ["id"] = 179893;
      ["name"] = "Cartel Skulker";
      ["health"] = 165195;
      ["displayId"] = 101734;
      ["creatureType"] = "Humanoid";
      ["level"] = 60;
      ["count"] = 4;
      ["scale"] = 1;
   };
   [23] = {
      ["clones"] = {
         [1] = {
            ["y"] = -153.17973420905;
            ["x"] = 410.9392168028;
            ["sublevel"] = 2;
         };
         [2] = {
            ["y"] = -155.2239182384;
            ["x"] = 385.05905783892;
            ["sublevel"] = 2;
         };
      };
      ["id"] = 176562;
      ["name"] = "Brawling Patron";
      ["health"] = 198234;
      ["displayId"] = 101544;
      ["creatureType"] = "Humanoid";
      ["level"] = 60;
      ["count"] = 0;
      ["scale"] = 2;
   };
   [31] = {
      ["clones"] = {
         [1] = {
            ["y"] = -189.66695593959;
            ["x"] = 386.86221186275;
            ["sublevel"] = 3;
         };
      };
      ["id"] = 175677;
      ["name"] = "Smuggled Creature";
      ["health"] = 132156;
      ["displayId"] = 93756;
      ["creatureType"] = "Beast";
      ["level"] = 60;
      ["count"] = 0;
      ["scale"] = 2;
   };
};
