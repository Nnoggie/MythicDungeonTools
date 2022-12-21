local MDT = MDT
local L = MDT.L
local dungeonIndex = 44
MDT.dungeonList[dungeonIndex] = L["TheAzureVault"]
MDT.mapInfo[dungeonIndex] = {
  viewportPositionOverrides = {
    [1] = {
      zoomScale = 1.5999999046326;
      horizontalPan = 161.93562594348;
      verticalPan = 86.334611786945;
    };
    [2] = {
      zoomScale = 1.2999999523163;
      horizontalPan = 111.62481573922;
      verticalPan = 43.260061835168;
    };
    [3] = {
      zoomScale = 1.2999999523163;
      horizontalPan = 175.58851375619;
      verticalPan = 72.986299199317;
    };
    [4] = {
      zoomScale = 1.2999999523163;
      horizontalPan = 193.84607431532;
      verticalPan = 107.4168929664;
    };
  }
};
local zones = { 2073, 2074, 2075, 2076, 2077 }
-- add zones to MDT.zoneIdToDungeonIdx
for _, zone in ipairs(zones) do
  MDT.zoneIdToDungeonIdx[zone] = dungeonIndex
end

MDT.dungeonMaps[dungeonIndex] = {
  [0] = "ArcaneNexus",
  [1] = "ArcaneNexus_A",
  [2] = "ArcaneNexus_B",
  [3] = "ArcaneNexus_C",
  [4] = "ArcaneNexus_D",
  [5] = "ArcaneNexus_E",
}
MDT.dungeonSubLevels[dungeonIndex] = {
  [1] = L["TheArcaneConservatory"],
  [2] = L["UpperChamber"],
  [3] = L["MausoleumOfLegends"],
  [4] = L["LowerChamber"],
  [5] = L["CrystalChamber"],
}
MDT.mapPOIs[dungeonIndex] = {
  [1] = {
    [1] = {
      ["template"] = "MapLinkPinTemplate";
      ["type"] = "mapLink";
      ["x"] = 375.91817249733;
      ["y"] = -247.91777180005;
      ["target"] = 2;
      ["direction"] = -1;
      ["connectionIndex"] = 1;
    };
  };
  [2] = {
    [1] = {
      ["template"] = "MapLinkPinTemplate";
      ["type"] = "mapLink";
      ["x"] = 339.6253290197;
      ["y"] = -100.48961257863;
      ["target"] = 1;
      ["direction"] = 1;
      ["connectionIndex"] = 1;
    };
    [2] = {
      ["template"] = "MapLinkPinTemplate";
      ["type"] = "mapLink";
      ["x"] = 415.10499993933;
      ["y"] = -346.92889267752;
      ["target"] = 3;
      ["direction"] = -1;
      ["connectionIndex"] = 2;
    };
  };
  [3] = {
    [1] = {
      ["template"] = "MapLinkPinTemplate";
      ["type"] = "mapLink";
      ["x"] = 208.2600036006;
      ["y"] = -307.14508429513;
      ["target"] = 2;
      ["direction"] = 1;
      ["connectionIndex"] = 2;
    };
    [2] = {
      ["template"] = "MapLinkPinTemplate";
      ["type"] = "mapLink";
      ["x"] = 686.33066424902;
      ["y"] = -175.3764748621;
      ["target"] = 4;
      ["direction"] = -1;
      ["connectionIndex"] = 3;
    };
  };
  [4] = {
    [1] = {
      ["template"] = "MapLinkPinTemplate";
      ["type"] = "mapLink";
      ["x"] = 744.61501701204;
      ["y"] = -147.60710936621;
      ["target"] = 3;
      ["direction"] = 1;
      ["connectionIndex"] = 3;
    };
    [2] = {
      ["template"] = "MapLinkPinTemplate";
      ["type"] = "mapLink";
      ["x"] = 388.10190813456;
      ["y"] = -245.6825716138;
      ["target"] = 5;
      ["direction"] = -1;
      ["connectionIndex"] = 4;
    };
  };
  [5] = {
    [1] = {
      ["template"] = "MapLinkPinTemplate";
      ["type"] = "mapLink";
      ["x"] = 253.80450797624;
      ["y"] = -280.95593947574;
      ["target"] = 4;
      ["direction"] = 1;
      ["connectionIndex"] = 4;
    };
  };
};

MDT.dungeonTotalCount[dungeonIndex] = { normal = 410, teeming = 1000, teemingEnabled = true }

MDT.dungeonEnemies[dungeonIndex] = {
  [1] = {
    ["name"] = "Conjured Lasher";
    ["id"] = 196102;
    ["count"] = 5;
    ["health"] = 645211;
    ["scale"] = 1;
    ["displayId"] = 76261;
    ["creatureType"] = "Elemental";
    ["level"] = 70;
    ["characteristics"] = {
      ["Taunt"] = true;
      ["Incapacitate"] = true;
      ["Silence"] = true;
      ["Root"] = true;
      ["Fear"] = true;
      ["Disorient"] = true;
      ["Stun"] = true;
      ["Slow"] = true;
    };
    ["spells"] = {
      [387564] = {
      };
    };
    ["clones"] = {
      [1] = {
        ["x"] = 557.59505436998;
        ["y"] = -213.08148049352;
        ["g"] = 3;
        ["sublevel"] = 1;
        ["scale"] = 1.5;
      };
      [2] = {
        ["x"] = 543.78304001176;
        ["y"] = -218.93403652406;
        ["g"] = 3;
        ["sublevel"] = 1;
        ["scale"] = 1.5;
      };
      [3] = {
        ["x"] = 544.9896941715;
        ["y"] = -206.2320654089;
        ["g"] = 3;
        ["sublevel"] = 1;
        ["scale"] = 1.5;
      };
      [4] = {
        ["x"] = 558.21808543684;
        ["y"] = -289.07772903777;
        ["g"] = 4;
        ["sublevel"] = 1;
        ["scale"] = 1.5;
      };
      [5] = {
        ["x"] = 545.12808552221;
        ["y"] = -290.64019925318;
        ["g"] = 4;
        ["sublevel"] = 1;
        ["scale"] = 1.5;
      };
      [6] = {
        ["x"] = 545.51366820381;
        ["y"] = -279.55051755088;
        ["g"] = 4;
        ["sublevel"] = 1;
        ["scale"] = 1.5;
      };
      [7] = {
        ["x"] = 490.89519844337;
        ["y"] = -264.11578041377;
        ["g"] = 5;
        ["sublevel"] = 1;
        ["scale"] = 1.5;
      };
      [8] = {
        ["x"] = 491.53897533573;
        ["y"] = -242.87570949742;
        ["g"] = 5;
        ["sublevel"] = 1;
        ["scale"] = 1.5;
      };
      [9] = {
        ["x"] = 501.85640255755;
        ["y"] = -253.88878267221;
        ["g"] = 5;
        ["sublevel"] = 1;
        ["scale"] = 1.5;
      };
      [10] = {
        ["x"] = 384.97118600673;
        ["y"] = -200.69979306271;
        ["g"] = 8;
        ["sublevel"] = 1;
        ["scale"] = 1.5;
      };
      [11] = {
        ["x"] = 435.98322885686;
        ["y"] = -239.07989650737;
        ["g"] = 6;
        ["sublevel"] = 1;
        ["scale"] = 1.5;
      };
      [12] = {
        ["x"] = 403.39329252188;
        ["y"] = -189.83926409067;
        ["g"] = 8;
        ["sublevel"] = 1;
        ["scale"] = 1.5;
      };
      [13] = {
        ["x"] = 397.90023792793;
        ["y"] = -201.20240911445;
        ["g"] = 8;
        ["sublevel"] = 1;
        ["scale"] = 1.5;
      };
      [14] = {
        ["x"] = 447.62409606022;
        ["y"] = -232.10896735746;
        ["g"] = 6;
        ["sublevel"] = 1;
        ["scale"] = 1.5;
      };
      [15] = {
        ["x"] = 401.87560042846;
        ["y"] = -240.16370021673;
        ["g"] = 7;
        ["sublevel"] = 1;
        ["scale"] = 1.5;
      };
      [16] = {
        ["x"] = 391.98555382758;
        ["y"] = -229.74912748081;
        ["g"] = 7;
        ["sublevel"] = 1;
        ["scale"] = 1.5;
      };
    };
  };
  [2] = {
    ["name"] = "Shrieking Whelp";
    ["id"] = 187159;
    ["count"] = 1;
    ["health"] = 286760;
    ["scale"] = 1;
    ["displayId"] = 102138;
    ["creatureType"] = "Dragonkin";
    ["level"] = 70;
    ["characteristics"] = {
      ["Taunt"] = true;
      ["Incapacitate"] = true;
      ["Root"] = true;
      ["Disorient"] = true;
      ["Stun"] = true;
      ["Slow"] = true;
    };
    ["spells"] = {
      [370223] = {
      };
      [370225] = {
      };
      [397726] = {
      };
    };
    ["clones"] = {
      [1] = {
        ["x"] = 597.68067392625;
        ["y"] = -275.37264528598;
        ["sublevel"] = 1;
        ["scale"] = 1;
      };
      [2] = {
        ["x"] = 434.66093768755;
        ["y"] = -217.51393057887;
        ["sublevel"] = 1;
        ["scale"] = 1;
      };
      [3] = {
        ["x"] = 391.21617651925;
        ["y"] = -190.65477171121;
        ["g"] = 8;
        ["sublevel"] = 1;
        ["scale"] = 1;
      };
    };
  };
  [3] = {
    ["name"] = "Arcane Tender";
    ["id"] = 196115;
    ["count"] = 8;
    ["health"] = 1147041;
    ["scale"] = 1;
    ["displayId"] = 107894;
    ["creatureType"] = "Elemental";
    ["level"] = 71;
    ["characteristics"] = {
      ["Taunt"] = true;
    };
    ["spells"] = {
      [375596] = {
      };
      [375602] = {
      };
      [375649] = {
      };
      [375652] = {
      };
    };
    ["clones"] = {
      [1] = {
        ["x"] = 477.13163227026;
        ["y"] = -250.56962815119;
        ["g"] = 5;
        ["sublevel"] = 1;
        ["scale"] = 2;
      };
      [2] = {
        ["x"] = 380.3534485533;
        ["y"] = -172.39254668122;
        ["sublevel"] = 1;
        ["scale"] = 2;
      };
    };
  };
  [4] = {
    ["name"] = "Crystal Fury";
    ["id"] = 187160;
    ["count"] = 5;
    ["health"] = 674465;
    ["scale"] = 1;
    ["displayId"] = 64607;
    ["creatureType"] = "Elemental";
    ["level"] = 70;
    ["characteristics"] = {
      ["Taunt"] = true;
      ["Silence"] = true;
      ["Root"] = true;
      ["Disorient"] = true;
      ["Stun"] = true;
    };
    ["spells"] = {
      [370764] = {
      };
      [389686] = {
      };
    };
    ["clones"] = {
      [1] = {
        ["x"] = 446.97785397098;
        ["y"] = -203.65305505585;
        ["g"] = 35;
        ["sublevel"] = 1;
        ["scale"] = 2;
      };
      [2] = {
        ["x"] = 433.22814301299;
        ["y"] = -195.30713481628;
        ["g"] = 35;
        ["sublevel"] = 1;
        ["scale"] = 2;
      };
      [3] = {
        ["x"] = 281.88507738389;
        ["y"] = -245.06257425102;
        ["g"] = 36;
        ["sublevel"] = 2;
        ["scale"] = 2;
      };
      [4] = {
        ["x"] = 307.2049921633;
        ["y"] = -257.2591050251;
        ["g"] = 36;
        ["sublevel"] = 2;
        ["scale"] = 2;
      };
      [5] = {
        ["x"] = 298.6741771445;
        ["y"] = -276.56776624997;
        ["g"] = 36;
        ["sublevel"] = 2;
        ["scale"] = 2;
      };
      [6] = {
        ["x"] = 268.19074299208;
        ["y"] = -265.84185392543;
        ["g"] = 36;
        ["sublevel"] = 2;
        ["scale"] = 2;
      };
      [7] = {
        ["x"] = 562.46795653896;
        ["y"] = -258.43763543552;
        ["g"] = 2;
        ["sublevel"] = 1;
        ["scale"] = 2;
      };
      [8] = {
        ["x"] = 568.0659963514;
        ["y"] = -240.71414705212;
        ["g"] = 2;
        ["sublevel"] = 1;
        ["scale"] = 2;
      };
      [9] = {
        ["x"] = 581.60699325244;
        ["y"] = -255.77601617933;
        ["g"] = 2;
        ["sublevel"] = 1;
        ["scale"] = 2;
      };
    };
  };
  [5] = {
    ["name"] = "Crystal Thrasher";
    ["id"] = 187139;
    ["count"] = 8;
    ["health"] = 981040;
    ["scale"] = 1;
    ["displayId"] = 106012;
    ["creatureType"] = "Elemental";
    ["level"] = 71;
    ["characteristics"] = {
      ["Taunt"] = true;
    };
    ["spells"] = {
      [370766] = {
      };
      [371005] = {
      };
      [371007] = {
      };
    };
    ["clones"] = {
      [1] = {
        ["x"] = 419.80169344232;
        ["y"] = -215.06739295655;
        ["g"] = 35;
        ["sublevel"] = 1;
        ["scale"] = 2;
      };
      [2] = {
        ["x"] = 288.22426407286;
        ["y"] = -259.68355018952;
        ["g"] = 36;
        ["sublevel"] = 2;
        ["scale"] = 2;
      };
    };
  };
  [6] = {
    ["name"] = "Volatile Sapling";
    ["id"] = 191313;
    ["count"] = 1;
    ["health"] = 71691;
    ["scale"] = 1;
    ["displayId"] = 107890;
    ["creatureType"] = "Aberration";
    ["level"] = 70;
    ["characteristics"] = {
      ["Taunt"] = true;
    };
    ["spells"] = {
      [375591] = {
      };
    };
    ["clones"] = {
      [1] = {
        ["x"] = 244.0968287288;
        ["y"] = -244.88164407981;
        ["g"] = 9;
        ["sublevel"] = 1;
        ["scale"] = 1;
      };
      [2] = {
        ["x"] = 252.90294467264;
        ["y"] = -236.99653043564;
        ["g"] = 9;
        ["sublevel"] = 1;
        ["scale"] = 1;
      };
      [3] = {
        ["x"] = 252.28069974784;
        ["y"] = -245.89924087349;
        ["g"] = 9;
        ["sublevel"] = 1;
        ["scale"] = 1;
      };
      [4] = {
        ["x"] = 243.91871007576;
        ["y"] = -235.94091569399;
        ["g"] = 9;
        ["sublevel"] = 1;
        ["scale"] = 1;
      };
      [5] = {
        ["x"] = 357.93607572908;
        ["y"] = -276.88583937861;
        ["g"] = 10;
        ["sublevel"] = 1;
        ["scale"] = 1;
      };
      [6] = {
        ["x"] = 366.57770286902;
        ["y"] = -281.98629554494;
        ["g"] = 10;
        ["sublevel"] = 1;
        ["scale"] = 1;
      };
      [7] = {
        ["x"] = 360.13098341912;
        ["y"] = -268.63101052417;
        ["g"] = 10;
        ["sublevel"] = 1;
        ["scale"] = 1;
      };
      [8] = {
        ["x"] = 366.9896250635;
        ["y"] = -272.14928448025;
        ["g"] = 10;
        ["sublevel"] = 1;
        ["scale"] = 1;
      };
      [9] = {
        ["x"] = 322.3725031067;
        ["y"] = -353.93876159657;
        ["g"] = 11;
        ["sublevel"] = 1;
        ["scale"] = 1;
      };
      [10] = {
        ["x"] = 312.39737704918;
        ["y"] = -351.94589276931;
        ["g"] = 11;
        ["sublevel"] = 1;
        ["scale"] = 1;
      };
      [11] = {
        ["x"] = 303.83561415251;
        ["y"] = -356.36611766265;
        ["g"] = 11;
        ["sublevel"] = 1;
        ["scale"] = 1;
      };
      [12] = {
        ["x"] = 314.36518071572;
        ["y"] = -360.95810963603;
        ["g"] = 11;
        ["sublevel"] = 1;
        ["scale"] = 1;
      };
    };
  };
  [7] = {
    ["name"] = "Arcane Tender";
    ["id"] = 191164;
    ["count"] = 8;
    ["health"] = 1147041;
    ["scale"] = 1;
    ["displayId"] = 107894;
    ["creatureType"] = "Elemental";
    ["level"] = 71;
    ["characteristics"] = {
      ["Taunt"] = true;
      ["Stun"] = true;
    };
    ["spells"] = {
      [375596] = {
      };
      [375602] = {
      };
      [375649] = {
      };
      [375652] = {
      };
      [375732] = {
      };
    };
    ["clones"] = {
      [1] = {
        ["x"] = 311.68131147541;
        ["y"] = -245.16367437285;
        ["sublevel"] = 1;
        ["scale"] = 2;
      };
      [2] = {
        ["x"] = 359.43737704918;
        ["y"] = -326.35255779636;
        ["sublevel"] = 1;
        ["scale"] = 2;
      };
      [3] = {
        ["x"] = 268.37565362233;
        ["y"] = -339.86131484283;
        ["sublevel"] = 1;
        ["scale"] = 2;
      };
    };
  };
  [8] = {
    ["name"] = "Leymor";
    ["id"] = 186644;
    ["count"] = 0;
    ["health"] = 5022728;
    ["scale"] = 1;
    ["displayId"] = 107127;
    ["creatureType"] = "Elemental";
    ["level"] = 72;
    ["isBoss"] = true;
    ["encounterID"] = 2492;
    ["instanceID"] = 1203;
    ["characteristics"] = {
      ["Taunt"] = true;
    };
    ["spells"] = {
      [374364] = {
      };
      [374567] = {
      };
      [374570] = {
      };
      [374582] = {
      };
      [374720] = {
      };
      [374729] = {
      };
      [374731] = {
      };
      [374789] = {
      };
      [375729] = {
      };
      [386660] = {
      };
    };
    ["clones"] = {
      [1] = {
        ["x"] = 312.17704918033;
        ["y"] = -300.56812592228;
        ["sublevel"] = 1;
        ["scale"] = 2;
      };
    };
  };
  [9] = {
    ["name"] = "Shrieking Whelp";
    ["id"] = 188100;
    ["count"] = 1;
    ["health"] = 286760;
    ["scale"] = 1;
    ["displayId"] = 102138;
    ["creatureType"] = "Dragonkin";
    ["level"] = 70;
    ["characteristics"] = {
      ["Taunt"] = true;
      ["Incapacitate"] = true;
      ["Disorient"] = true;
    };
    ["spells"] = {
      [370225] = {
      };
      [371042] = {
      };
      [397726] = {
      };
    };
    ["clones"] = {
      [1] = {
        ["x"] = 326.01230769231;
        ["y"] = -231.42383778437;
        ["g"] = 12;
        ["sublevel"] = 2;
        ["scale"] = 1;
      };
      [2] = {
        ["x"] = 318.32307692308;
        ["y"] = -214.26879327399;
        ["g"] = 12;
        ["sublevel"] = 2;
        ["scale"] = 1;
      };
      [3] = {
        ["x"] = 309.62104903453;
        ["y"] = -227.8596097981;
        ["g"] = 12;
        ["sublevel"] = 2;
        ["scale"] = 1;
      };
    };
  };
  [10] = {
    ["name"] = "Arcane Elemental";
    ["id"] = 186741;
    ["count"] = 5;
    ["health"] = 716900;
    ["scale"] = 1;
    ["displayId"] = 107911;
    ["creatureType"] = "Elemental";
    ["level"] = 70;
    ["characteristics"] = {
      ["Taunt"] = true;
      ["Silence"] = true;
      ["Root"] = true;
      ["Fear"] = true;
      ["Banish"] = true;
      ["Disorient"] = true;
      ["Stun"] = true;
    };
    ["spells"] = {
      [371306] = {
      };
      [386546] = {
      };
      [386549] = {
      };
    };
    ["clones"] = {
      [1] = {
        ["x"] = 280.62075453735;
        ["y"] = -303.22104564935;
        ["g"] = 13;
        ["sublevel"] = 2;
        ["scale"] = 1.5;
      };
      [2] = {
        ["x"] = 277.4389124837;
        ["y"] = -319.80127698458;
        ["g"] = 13;
        ["sublevel"] = 2;
        ["scale"] = 1.5;
      };
      [3] = {
        ["x"] = 420.97005158431;
        ["y"] = -295.42857295334;
        ["g"] = 14;
        ["sublevel"] = 2;
        ["scale"] = 1.5;
      };
      [4] = {
        ["x"] = 437.66743855854;
        ["y"] = -293.23893181947;
        ["g"] = 14;
        ["sublevel"] = 2;
        ["scale"] = 1.5;
      };
      [5] = {
        ["x"] = 491.36324666725;
        ["y"] = -318.21406843966;
        ["g"] = 15;
        ["sublevel"] = 2;
        ["scale"] = 1.5;
      };
      [6] = {
        ["x"] = 481.79738188093;
        ["y"] = -326.06013925088;
        ["g"] = 15;
        ["sublevel"] = 2;
        ["scale"] = 1.5;
      };
      [7] = {
        ["x"] = 506.78715502558;
        ["y"] = -366.59754214845;
        ["g"] = 16;
        ["sublevel"] = 2;
        ["scale"] = 1.5;
      };
      [8] = {
        ["x"] = 343.64680013919;
        ["y"] = -227.37444853046;
        ["g"] = 20;
        ["sublevel"] = 3;
        ["scale"] = 1.5;
      };
      [9] = {
        ["x"] = 363.33324076978;
        ["y"] = -239.34990489323;
        ["g"] = 20;
        ["sublevel"] = 3;
        ["scale"] = 1.5;
      };
      [10] = {
        ["x"] = 378.20649678193;
        ["y"] = -291.64760912921;
        ["g"] = 21;
        ["sublevel"] = 3;
        ["scale"] = 1.5;
      };
    };
  };
  [11] = {
    ["name"] = "Unstable Curator";
    ["id"] = 187154;
    ["count"] = 8;
    ["health"] = 1147041;
    ["scale"] = 1;
    ["displayId"] = 68973;
    ["creatureType"] = "Elemental";
    ["level"] = 71;
    ["characteristics"] = {
      ["Taunt"] = true;
    };
    ["spells"] = {
      [371352] = {
      };
      [371358] = {
      };
      [389804] = {
      };
    };
    ["clones"] = {
      [1] = {
        ["x"] = 425.7771795895;
        ["y"] = -279.4892664933;
        ["g"] = 14;
        ["sublevel"] = 2;
        ["scale"] = 2;
      };
      [2] = {
        ["x"] = 395.33234300299;
        ["y"] = -410.81150891906;
        ["g"] = 18;
        ["sublevel"] = 2;
        ["scale"] = 2;
      };
      [3] = {
        ["x"] = 520.83128440542;
        ["y"] = -377.82694391063;
        ["g"] = 16;
        ["sublevel"] = 2;
        ["scale"] = 2;
      };
    };
  };
  [12] = {
    ["name"] = "Rune Seal Keeper";
    ["id"] = 187155;
    ["count"] = 5;
    ["health"] = 716900;
    ["scale"] = 1;
    ["displayId"] = 105096;
    ["creatureType"] = "Dragonkin";
    ["level"] = 70;
    ["characteristics"] = {
      ["Taunt"] = true;
      ["Incapacitate"] = true;
      ["Silence"] = true;
      ["Root"] = true;
      ["Fear"] = true;
      ["Disorient"] = true;
      ["Stun"] = true;
    };
    ["spells"] = {
      [377488] = {
      };
      [377503] = {
      };
      [378065] = {
      };
    };
    ["clones"] = {
      [1] = {
        ["x"] = 476.51487755064;
        ["y"] = -312.03489880227;
        ["g"] = 15;
        ["sublevel"] = 2;
        ["scale"] = 2;
      };
      [2] = {
        ["x"] = 363.44319298862;
        ["y"] = -283.35575992123;
        ["g"] = 21;
        ["sublevel"] = 3;
        ["scale"] = 2;
      };
      [3] = {
        ["x"] = 586.67944867489;
        ["y"] = -274.16586834085;
        ["g"] = 25;
        ["sublevel"] = 3;
        ["scale"] = 2;
      };
      [4] = {
        ["x"] = 633.12676459897;
        ["y"] = -233.16183145324;
        ["g"] = 26;
        ["sublevel"] = 3;
        ["scale"] = 2;
      };
      [5] = {
        ["x"] = 637.47282066249;
        ["y"] = -366.97608509603;
        ["g"] = 27;
        ["sublevel"] = 3;
        ["scale"] = 2;
      };
    };
  };
  [13] = {
    ["name"] = "Crystal Fury";
    ["id"] = 196116;
    ["count"] = 5;
    ["health"] = 788591;
    ["scale"] = 1;
    ["displayId"] = 64607;
    ["creatureType"] = "Elemental";
    ["level"] = 70;
    ["characteristics"] = {
      ["Taunt"] = true;
      ["Incapacitate"] = true;
      ["Silence"] = true;
      ["Root"] = true;
      ["Fear"] = true;
      ["Disorient"] = true;
      ["Stun"] = true;
    };
    ["spells"] = {
      [370764] = {
      };
      [389686] = {
      };
    };
    ["clones"] = {
      [1] = {
        ["x"] = 402.73974348742;
        ["y"] = -393.9043189132;
        ["g"] = 18;
        ["sublevel"] = 2;
        ["scale"] = 2;
      };
      [2] = {
        ["x"] = 415.27066882559;
        ["y"] = -407.55526615446;
        ["g"] = 18;
        ["sublevel"] = 2;
        ["scale"] = 2;
      };
      [3] = {
        ["x"] = 462.47357367461;
        ["y"] = -392.73314796319;
        ["g"] = 17;
        ["sublevel"] = 2;
        ["scale"] = 2;
      };
      [4] = {
        ["x"] = 504.06794052997;
        ["y"] = -384.61381223151;
        ["g"] = 16;
        ["sublevel"] = 2;
        ["scale"] = 2;
      };
      [5] = {
        ["x"] = 345.63766713761;
        ["y"] = -400.55931635375;
        ["g"] = 22;
        ["sublevel"] = 3;
        ["scale"] = 2;
      };
      [6] = {
        ["x"] = 363.81141804321;
        ["y"] = -391.68784757286;
        ["g"] = 22;
        ["sublevel"] = 3;
        ["scale"] = 2;
      };
    };
  };
  [14] = {
    ["name"] = "Crystal Thrasher";
    ["id"] = 196117;
    ["count"] = 8;
    ["health"] = 1147041;
    ["scale"] = 1;
    ["displayId"] = 106012;
    ["creatureType"] = "Elemental";
    ["level"] = 71;
    ["characteristics"] = {
      ["Taunt"] = true;
    };
    ["spells"] = {
      [370766] = {
      };
      [371005] = {
      };
      [371007] = {
      };
    };
    ["clones"] = {
      [1] = {
        ["x"] = 470.33365473576;
        ["y"] = -408.81593769563;
        ["g"] = 17;
        ["sublevel"] = 2;
        ["scale"] = 2;
      };
      [2] = {
        ["x"] = 349.81599706186;
        ["y"] = -382.2463494725;
        ["g"] = 22;
        ["sublevel"] = 3;
        ["scale"] = 2;
      };
    };
  };
  [15] = {
    ["name"] = "Arcane Construct";
    ["id"] = 186740;
    ["count"] = 5;
    ["health"] = 1147041;
    ["scale"] = 1;
    ["displayId"] = 104019;
    ["creatureType"] = "Elemental";
    ["level"] = 71;
    ["characteristics"] = {
      ["Taunt"] = true;
    };
    ["spells"] = {
      [387067] = {
      };
      [387122] = {
      };
    };
    ["clones"] = {
      [1] = {
        ["x"] = 261.09119481773;
        ["y"] = -265.0316598485;
        ["g"] = 19;
        ["sublevel"] = 3;
        ["scale"] = 2;
      };
      [2] = {
        ["x"] = 248.13597221432;
        ["y"] = -249.77097975664;
        ["g"] = 19;
        ["sublevel"] = 3;
        ["scale"] = 2;
      };
      [3] = {
        ["x"] = 346.96066240115;
        ["y"] = -241.52849408571;
        ["g"] = 20;
        ["sublevel"] = 3;
        ["scale"] = 2;
      };
      [4] = {
        ["x"] = 253.92308154075;
        ["y"] = -369.21202302649;
        ["g"] = 23;
        ["sublevel"] = 3;
        ["scale"] = 2;
      };
      [5] = {
        ["x"] = 263.25064860525;
        ["y"] = -354.83835340259;
        ["g"] = 23;
        ["sublevel"] = 3;
        ["scale"] = 2;
      };
    };
  };
  [16] = {
    ["name"] = "Astral Attendant";
    ["id"] = 189555;
    ["count"] = 3;
    ["health"] = 430140;
    ["scale"] = 1;
    ["displayId"] = 107525;
    ["creatureType"] = "Elemental";
    ["level"] = 70;
    ["characteristics"] = {
      ["Taunt"] = true;
      ["Silence"] = true;
      ["Root"] = true;
      ["Fear"] = true;
      ["Disorient"] = true;
      ["Stun"] = true;
    };
    ["spells"] = {
      [374868] = {
      };
      [374885] = {
      };
      [378065] = {
      };
    };
    ["clones"] = {
      [1] = {
        ["x"] = 359.4132589729;
        ["y"] = -298.79180805584;
        ["g"] = 21;
        ["sublevel"] = 3;
        ["scale"] = 1.5;
      };
      [2] = {
        ["x"] = 586.77220590974;
        ["y"] = -258.35052187904;
        ["g"] = 25;
        ["sublevel"] = 3;
        ["scale"] = 1.6;
      };
      [3] = {
        ["x"] = 627.54878465173;
        ["y"] = -246.85587509224;
        ["g"] = 26;
        ["sublevel"] = 3;
        ["scale"] = 1.5;
      };
      [4] = {
        ["x"] = 642.43869236412;
        ["y"] = -245.2857034253;
        ["g"] = 26;
        ["sublevel"] = 3;
        ["scale"] = 1.5;
      };
      [5] = {
        ["x"] = 646.64630302236;
        ["y"] = -378.84393280667;
        ["g"] = 27;
        ["sublevel"] = 3;
        ["scale"] = 1.6;
      };
      [6] = {
        ["x"] = 649.20472346593;
        ["y"] = -360.17009331108;
        ["g"] = 27;
        ["sublevel"] = 3;
        ["scale"] = 1.5;
      };
    };
  };
  [17] = {
    ["name"] = "Vault Guard";
    ["id"] = 190510;
    ["count"] = 5;
    ["health"] = 788591;
    ["scale"] = 1;
    ["displayId"] = 104202;
    ["creatureType"] = "Dragonkin";
    ["level"] = 70;
    ["characteristics"] = {
      ["Taunt"] = true;
      ["Silence"] = true;
      ["Root"] = true;
      ["Disorient"] = true;
      ["Stun"] = true;
    };
    ["spells"] = {
      [374778] = {
      };
      [377105] = {
      };
      [378065] = {
      };
    };
    ["clones"] = {
      [1] = {
        ["x"] = 528.77391304348;
        ["y"] = -315.58989130435;
        ["g"] = 24;
        ["sublevel"] = 3;
        ["scale"] = 2;
      };
      [2] = {
        ["x"] = 528.62782608696;
        ["y"] = -297.79369565217;
        ["g"] = 24;
        ["sublevel"] = 3;
        ["scale"] = 2;
      };
      [3] = {
        ["x"] = 603.58156690771;
        ["y"] = -271.11826525938;
        ["g"] = 25;
        ["sublevel"] = 3;
        ["scale"] = 2;
      };
      [4] = {
        ["x"] = 694.55439396818;
        ["y"] = -284.25485482455;
        ["sublevel"] = 3;
        ["scale"] = 2;
      };
      [5] = {
        ["x"] = 709.57973368144;
        ["y"] = -354.79402823366;
        ["sublevel"] = 3;
        ["scale"] = 2;
      };
      [6] = {
        ["x"] = 693.92947146189;
        ["y"] = -376.67706940701;
        ["sublevel"] = 3;
        ["scale"] = 2;
      };
    };
  };
  [18] = {
    ["name"] = "Scalebane Lieutenant";
    ["id"] = 191739;
    ["count"] = 8;
    ["health"] = 1147041;
    ["scale"] = 1;
    ["displayId"] = 104234;
    ["creatureType"] = "Dragonkin";
    ["level"] = 71;
    ["characteristics"] = {
      ["Taunt"] = true;
    };
    ["spells"] = {
      [374778] = {
      };
      [377105] = {
      };
      [378065] = {
      };
      [391118] = {
      };
      [391120] = {
      };
    };
    ["clones"] = {
      [1] = {
        ["x"] = 587.2891271195;
        ["y"] = -341.93150011409;
        ["sublevel"] = 3;
        ["scale"] = 2.5;
      };
    };
  };
  [19] = {
    ["name"] = "Azureblade";
    ["id"] = 186739;
    ["count"] = 0;
    ["health"] = 3587663;
    ["scale"] = 1;
    ["displayId"] = 106829;
    ["creatureType"] = "Dragonkin";
    ["level"] = 72;
    ["isBoss"] = true;
    ["encounterID"] = 2505;
    ["instanceID"] = 1203;
    ["characteristics"] = {
      ["Taunt"] = true;
    };
    ["spells"] = {
      [372222] = {
      };
      [378734] = {
      };
      [384132] = {
      };
      [384223] = {
      };
      [384625] = {
      };
      [385578] = {
      };
      [385579] = {
      };
      [390462] = {
      };
    };
    ["clones"] = {
      [1] = {
        ["x"] = 640.00065324397;
        ["y"] = -311.74293824818;
        ["sublevel"] = 3;
        ["scale"] = 2;
      };
    };
  };
  [20] = {
    ["name"] = "Drakonid Breaker";
    ["id"] = 187240;
    ["count"] = 8;
    ["health"] = 1147041;
    ["scale"] = 1;
    ["displayId"] = 109739;
    ["creatureType"] = "Dragonkin";
    ["level"] = 71;
    ["characteristics"] = {
      ["Taunt"] = true;
    };
    ["spells"] = {
      [391136] = {
      };
      [391143] = {
      };
      [396991] = {
      };
    };
    ["clones"] = {
      [1] = {
        ["x"] = 722.42299266729;
        ["y"] = -164.73047165095;
        ["sublevel"] = 4;
        ["scale"] = 2;
      };
      [2] = {
        ["x"] = 567.0413007139;
        ["y"] = -201.55969255001;
        ["g"] = 29;
        ["sublevel"] = 4;
        ["scale"] = 2;
      };
      [3] = {
        ["x"] = 597.57598976117;
        ["y"] = -445.10716084592;
        ["g"] = 32;
        ["sublevel"] = 4;
        ["scale"] = 2;
      };
      [4] = {
        ["x"] = 451.5423255814;
        ["y"] = -354.65790697674;
        ["g"] = 34;
        ["sublevel"] = 4;
        ["scale"] = 2;
      };
      [5] = {
        ["x"] = 440.27720930233;
        ["y"] = -365.48686046512;
        ["g"] = 34;
        ["sublevel"] = 4;
        ["scale"] = 2;
      };
    };
  };
  [21] = {
    ["name"] = "Tarasek Delver";
    ["id"] = 187242;
    ["count"] = 3;
    ["health"] = 430140;
    ["scale"] = 1;
    ["displayId"] = 106882;
    ["creatureType"] = "Dragonkin";
    ["level"] = 70;
    ["characteristics"] = {
      ["Taunt"] = true;
      ["Root"] = true;
      ["Stun"] = true;
    };
    ["spells"] = {
      [386640] = {
      };
    };
    ["clones"] = {
      [1] = {
        ["x"] = 674.64530071397;
        ["y"] = -185.43693842902;
        ["sublevel"] = 4;
        ["scale"] = 1.5;
      };
      [2] = {
        ["x"] = 647.67674689304;
        ["y"] = -154.76545584911;
        ["sublevel"] = 4;
        ["scale"] = 1.5;
      };
      [3] = {
        ["x"] = 646.41901600327;
        ["y"] = -179.59674539479;
        ["g"] = 28;
        ["sublevel"] = 4;
        ["scale"] = 1.5;
      };
      [4] = {
        ["x"] = 631.73518754468;
        ["y"] = -186.56094312597;
        ["g"] = 28;
        ["sublevel"] = 4;
        ["scale"] = 1.5;
      };
      [5] = {
        ["x"] = 580.26294444823;
        ["y"] = -217.02191595449;
        ["g"] = 29;
        ["sublevel"] = 4;
        ["scale"] = 1.5;
      };
      [6] = {
        ["x"] = 558.93306412658;
        ["y"] = -217.35303142772;
        ["g"] = 29;
        ["sublevel"] = 4;
        ["scale"] = 1.5;
      };
      [7] = {
        ["x"] = 569.24324467035;
        ["y"] = -378.18828358193;
        ["g"] = 30;
        ["sublevel"] = 4;
        ["scale"] = 1.5;
      };
      [8] = {
        ["x"] = 580.99081582787;
        ["y"] = -403.82509326825;
        ["g"] = 30;
        ["sublevel"] = 4;
        ["scale"] = 1.5;
      };
      [9] = {
        ["x"] = 638.31300680536;
        ["y"] = -413.80538466409;
        ["g"] = 31;
        ["sublevel"] = 4;
        ["scale"] = 1.5;
      };
      [10] = {
        ["x"] = 617.49131512974;
        ["y"] = -416.88487259012;
        ["g"] = 31;
        ["sublevel"] = 4;
        ["scale"] = 1.5;
      };
      [11] = {
        ["x"] = 589.06826470873;
        ["y"] = -455.77826685401;
        ["g"] = 32;
        ["sublevel"] = 4;
        ["scale"] = 1.5;
      };
      [12] = {
        ["x"] = 584.03956178592;
        ["y"] = -445.32574598983;
        ["g"] = 32;
        ["sublevel"] = 4;
        ["scale"] = 1.5;
      };
      [13] = {
        ["x"] = 596.39379854454;
        ["y"] = -489.6675636462;
        ["sublevel"] = 4;
        ["scale"] = 1.5;
      };
      [14] = {
        ["x"] = 551.81296340258;
        ["y"] = -470.70999142315;
        ["sublevel"] = 4;
        ["scale"] = 1.5;
      };
    };
  };
  [22] = {
    ["name"] = "Nullmagic Hornswog";
    ["id"] = 187246;
    ["count"] = 5;
    ["health"] = 716900;
    ["scale"] = 1;
    ["displayId"] = 102558;
    ["creatureType"] = "Beast";
    ["level"] = 70;
    ["characteristics"] = {
      ["Taunt"] = true;
      ["Root"] = true;
      ["Stun"] = true;
    };
    ["spells"] = {
      [386526] = {
      };
      [386536] = {
      };
    };
    ["clones"] = {
      [1] = {
        ["x"] = 642.89384699293;
        ["y"] = -134.01748324769;
        ["sublevel"] = 4;
        ["scale"] = 2;
      };
      [2] = {
        ["x"] = 644.89860465116;
        ["y"] = -216.51453488372;
        ["sublevel"] = 4;
        ["scale"] = 2;
      };
      [3] = {
        ["x"] = 677.05420941584;
        ["y"] = -148.30543881301;
        ["sublevel"] = 4;
        ["scale"] = 2;
      };
      [4] = {
        ["x"] = 629.55535637918;
        ["y"] = -170.55608514074;
        ["g"] = 28;
        ["sublevel"] = 4;
        ["scale"] = 2;
      };
      [5] = {
        ["x"] = 593.60011667191;
        ["y"] = -246.73663238656;
        ["sublevel"] = 4;
        ["scale"] = 2;
      };
      [6] = {
        ["x"] = 559.94477861007;
        ["y"] = -315.4710092671;
        ["sublevel"] = 4;
        ["scale"] = 2;
      };
      [7] = {
        ["x"] = 581.86965639846;
        ["y"] = -387.89209355312;
        ["g"] = 30;
        ["sublevel"] = 4;
        ["scale"] = 2;
      };
      [8] = {
        ["x"] = 558.3164187015;
        ["y"] = -428.61995546627;
        ["sublevel"] = 4;
        ["scale"] = 2;
      };
      [9] = {
        ["x"] = 549.74829535774;
        ["y"] = -512.11583514067;
        ["sublevel"] = 4;
        ["scale"] = 2;
      };
      [10] = {
        ["x"] = 517.85674418605;
        ["y"] = -484.28663247039;
        ["sublevel"] = 4;
        ["scale"] = 2;
      };
    };
  };
  [23] = {
    ["name"] = "Telash Greywing";
    ["id"] = 186737;
    ["count"] = 0;
    ["health"] = 5022728;
    ["scale"] = 1;
    ["displayId"] = 109087;
    ["creatureType"] = "Dragonkin";
    ["level"] = 72;
    ["isBoss"] = true;
    ["encounterID"] = 2483;
    ["instanceID"] = 1203;
    ["characteristics"] = {
      ["Taunt"] = true;
    };
    ["spells"] = {
      [386781] = {
      };
      [386881] = {
      };
      [386910] = {
      };
      [387150] = {
      };
      [387151] = {
      };
      [387152] = {
      };
      [387928] = {
      };
      [388008] = {
      };
      [388084] = {
      };
      [396722] = {
      };
    };
    ["clones"] = {
      [1] = {
        ["x"] = 307.49209302326;
        ["y"] = -294.95023255814;
        ["sublevel"] = 4;
        ["scale"] = 2;
      };
    };
  };
  [24] = {
    ["name"] = "Umbrelskul";
    ["id"] = 186738;
    ["count"] = 0;
    ["health"] = 6027274;
    ["scale"] = 1;
    ["displayId"] = 108968;
    ["creatureType"] = "Elemental";
    ["level"] = 72;
    ["isBoss"] = true;
    ["encounterID"] = 2508;
    ["instanceID"] = 1203;
    ["characteristics"] = {
      ["Taunt"] = true;
    };
    ["spells"] = {
      [374881] = {
      };
      [374916] = {
      };
      [374917] = {
      };
      [374918] = {
      };
      [384696] = {
      };
      [384699] = {
      };
      [384978] = {
      };
      [385075] = {
      };
      [388773] = {
      };
      [388777] = {
      };
      [388804] = {
      };
    };
    ["clones"] = {
      [1] = {
        ["x"] = 436.39149817252;
        ["y"] = -293.93034242099;
        ["sublevel"] = 5;
        ["scale"] = 3;
      };
    };
  };
};
