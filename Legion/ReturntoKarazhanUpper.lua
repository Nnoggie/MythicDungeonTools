local MDT = MDT
local L = MDT.L
local dungeonIndex = 10
MDT.dungeonList[dungeonIndex] = L["Return to Karazhan Upper"]
MDT.dungeonTotalCount[dungeonIndex] = { normal = 169, teeming = 202, teemingEnabled = true }

MDT.mapInfo[dungeonIndex] = {
  viewportPositionOverrides = {
    [1] = {
      zoomScale = 1.2999999523163;
      horizontalPan = 66.34588382552;
      verticalPan = 29.918396579054;
    };
    [2] = {
      zoomScale = 1.2999999523163;
      horizontalPan = 36.282638150069;
      verticalPan = 1.9241587455765;
    };
    [3] = {
      zoomScale = 1.2999999523163;
      horizontalPan = 146.44632486402;
      verticalPan = 79.083825575376;
    };
    [4] = {
      zoomScale = 1.2999999523163;
      horizontalPan = 0.4810319520738;
      verticalPan = 53.077592090303;
    };
  }
};

MDT.dungeonMaps[dungeonIndex] = {
  [0] = "LegionKarazhanDungeon",
  [1] = "LegionKarazhanDungeon9_",
  [2] = "LegionKarazhanDungeon10_",
  [3] = "LegionKarazhanDungeon11_",
  [4] = "LegionKarazhanDungeon12_",
  [5] = "LegionKarazhanDungeon13_",
  [6] = "LegionKarazhanDungeon14_",
}
MDT.dungeonSubLevels[dungeonIndex] = {
  [1] = L["The Menagerie"],
  [2] = L["Guardian's Library"],
  [3] = L["Library Floor"],
  [4] = L["Upper Library"],
  [5] = L["Gamesman's Hall"],
  [6] = L["Netherspace"],
}

MDT.mapPOIs[dungeonIndex] = {
  [1] = {
    [1] = {
      ["y"] = -163.55893042282;
      ["x"] = 506.07668238822;
      ["template"] = "DeathReleasePinTemplate";
      ["graveyardDescription"] = "";
      ["type"] = "graveyard";
    };
    [2] = {
      ["y"] = -426.79264705758;
      ["x"] = 436.89732993917;
      ["connectionIndex"] = 1;
      ["target"] = 2;
      ["type"] = "mapLink";
      ["template"] = "MapLinkPinTemplate";
      ["direction"] = 2;
    };
  };
  [2] = {
    [1] = {
      ["y"] = -94.965634433628;
      ["x"] = 178.93989940488;
      ["connectionIndex"] = 1;
      ["target"] = 1;
      ["type"] = "mapLink";
      ["template"] = "MapLinkPinTemplate";
      ["direction"] = -2;
    };
    [2] = {
      ["y"] = -327.71354610659;
      ["x"] = 616.29488165028;
      ["connectionIndex"] = 2;
      ["target"] = 3;
      ["type"] = "mapLink";
      ["template"] = "MapLinkPinTemplate";
      ["direction"] = -1;
    };
  };
  [3] = {
    [1] = {
      ["y"] = -303.09038562315;
      ["x"] = 387.6508747865;
      ["connectionIndex"] = 2;
      ["target"] = 2;
      ["type"] = "mapLink";
      ["template"] = "MapLinkPinTemplate";
      ["direction"] = 1;
    };
    [2] = {
      ["y"] = -126.03776422687;
      ["x"] = 536.56262153581;
      ["connectionIndex"] = 3;
      ["target"] = 4;
      ["type"] = "mapLink";
      ["template"] = "MapLinkPinTemplate";
      ["direction"] = 2;
    };
  };
  [4] = {
    [1] = {
      ["y"] = -145.97086280194;
      ["x"] = 80.44712328533;
      ["template"] = "DeathReleasePinTemplate";
      ["graveyardDescription"] = "";
      ["type"] = "graveyard";
    };
    [2] = {
      ["y"] = -143.62583184775;
      ["x"] = 54.065156039803;
      ["connectionIndex"] = 3;
      ["target"] = 3;
      ["type"] = "mapLink";
      ["template"] = "MapLinkPinTemplate";
      ["direction"] = -2;
    };
    [3] = {
      ["y"] = -468.41755033046;
      ["x"] = 474.41836194932;
      ["connectionIndex"] = 4;
      ["target"] = 5;
      ["type"] = "mapLink";
      ["template"] = "MapLinkPinTemplate";
      ["direction"] = -1;
    };
  };
  [5] = {
    [1] = {
      ["y"] = -79.136474214181;
      ["x"] = 415.79171588701;
      ["connectionIndex"] = 4;
      ["target"] = 4;
      ["type"] = "mapLink";
      ["template"] = "MapLinkPinTemplate";
      ["direction"] = 1;
    };
    [2] = {
      ["y"] = -504.17984267142;
      ["x"] = 360.68261625597;
      ["connectionIndex"] = 5;
      ["target"] = 6;
      ["type"] = "mapLink";
      ["template"] = "MapLinkPinTemplate";
      ["direction"] = -2;
    };
  };
  [6] = {
    [1] = {
      ["y"] = -281.39848028599;
      ["x"] = 505.49049174257;
      ["connectionIndex"] = 5;
      ["target"] = 5;
      ["type"] = "mapLink";
      ["template"] = "MapLinkPinTemplate";
      ["direction"] = 2;
    };
  };
};


MDT.dungeonEnemies[dungeonIndex] = {
  [1] = {
    ["clones"] = {
      [1] = {
        ["y"] = -155.57717427968;
        ["x"] = 590.75941310579;
        ["scale"] = 2;
        ["sublevel"] = 1;
      };
      [2] = {
        ["y"] = -180.86195969186;
        ["x"] = 589.45739867598;
        ["scale"] = 2;
        ["sublevel"] = 1;
      };
    };
    ["id"] = 114626;
    ["color"] = {
      ["a"] = 0.8;
      ["b"] = 1;
      ["g"] = 1;
      ["r"] = 1;
    };
    ["scale"] = 1;
    ["health"] = 16110718.34;
    ["displayId"] = 26404;
    ["creatureType"] = "Undead";
    ["level"] = 111;
    ["name"] = "Forlorn Spirit";
    ["count"] = 4;
  };
  [2] = {
    ["clones"] = {
      [1] = {
        ["y"] = -165.2445073506;
        ["x"] = 565.48515026323;
        ["scale"] = 2;
        ["sublevel"] = 1;
      };
    };
    ["id"] = 114627;
    ["color"] = {
      ["a"] = 0.8;
      ["b"] = 1;
      ["g"] = 1;
      ["r"] = 1;
    };
    ["scale"] = 1;
    ["health"] = 15573416.18;
    ["displayId"] = 10698;
    ["creatureType"] = "Undead";
    ["level"] = 110;
    ["name"] = "Shrieking Terror";
    ["count"] = 4;
  };
  [4] = {
    ["clones"] = {
      [1] = {
        ["y"] = -166.49866242334;
        ["x"] = 336.99656507;
        ["scale"] = 2;
        ["sublevel"] = 1;
      };
    };
    ["id"] = 115765;
    ["color"] = {
      ["a"] = 0.8;
      ["b"] = 1;
      ["g"] = 1;
      ["r"] = 1;
    };
    ["scale"] = 1.2;
    ["health"] = 32221436.68;
    ["displayId"] = 74335;
    ["creatureType"] = "Mechanical";
    ["level"] = 111;
    ["name"] = "Abstract Nullifier";
    ["count"] = 12;
  };
  [8] = {
    ["clones"] = {
      [13] = {
        ["y"] = -434.88581986622;
        ["x"] = 479.86831954016;
        ["scale"] = 2.5;
        ["sublevel"] = 4;
      };
      [7] = {
        ["y"] = -128.56425974077;
        ["x"] = 544.26536360351;
        ["scale"] = 2.5;
        ["sublevel"] = 4;
      };
      [1] = {
        ["y"] = -221.68617830559;
        ["x"] = 188.63467754792;
        ["scale"] = 2.5;
        ["sublevel"] = 2;
      };
      [2] = {
        ["y"] = -210.49869462475;
        ["x"] = 224.99634234794;
        ["scale"] = 2.5;
        ["sublevel"] = 2;
      };
      [4] = {
        ["y"] = -285.44971305058;
        ["x"] = 212.72561812359;
        ["scale"] = 2.5;
        ["sublevel"] = 2;
      };
      [8] = {
        ["y"] = -190.89288538273;
        ["x"] = 551.16631569971;
        ["scale"] = 2.4;
        ["sublevel"] = 4;
      };
      [9] = {
        ["y"] = -212.23328283569;
        ["x"] = 465.04553373313;
        ["scale"] = 2.5;
        ["sublevel"] = 4;
      };
      [5] = {
        ["y"] = -273.96741412704;
        ["x"] = 166.81651753839;
        ["scale"] = 2.5;
        ["sublevel"] = 2;
      };
      [10] = {
        ["y"] = -232.99953070271;
        ["x"] = 549.76347260237;
        ["scale"] = 2.5;
        ["sublevel"] = 4;
      };
      [3] = {
        ["y"] = -253.17700153437;
        ["x"] = 228.63476638022;
        ["scale"] = 2.5;
        ["sublevel"] = 2;
      };
      [6] = {
        ["y"] = -153.89952441422;
        ["x"] = 532.46149506956;
        ["scale"] = 2.5;
        ["sublevel"] = 4;
      };
      [12] = {
        ["y"] = -401.20429770968;
        ["x"] = 523.35818790605;
        ["scale"] = 2.5;
        ["sublevel"] = 4;
      };
      [11] = {
        ["y"] = -252.97808456626;
        ["x"] = 450.48219976211;
        ["scale"] = 2.5;
        ["sublevel"] = 4;
      };
    };
    ["id"] = 115484;
    ["color"] = {
      ["a"] = 0.8;
      ["b"] = 1;
      ["g"] = 1;
      ["r"] = 1;
    };
    ["scale"] = 0.8;
    ["health"] = 8305822.16;
    ["displayId"] = 73837;
    ["creatureType"] = "Demon";
    ["level"] = 110;
    ["name"] = "Fel Bat";
    ["count"] = 4;
  };
  [16] = {
    ["clones"] = {
      [1] = {
        ["y"] = -381.79316353425;
        ["x"] = 399.34973289673;
        ["scale"] = 2;
        ["sublevel"] = 1;
      };
    };
    ["id"] = 114247;
    ["isBoss"] = true;
    ["encounterID"] = 1557;
    ["scale"] = 1;
    ["health"] = 129540841;
    ["displayId"] = 16958;
    ["creatureType"] = "Mechanical";
    ["level"] = 112;
    ["count"] = 0;
    ["name"] = "The Curator";
  };
  [17] = {
    ["clones"] = {
      [1] = {
        ["y"] = -303.40479297808;
        ["x"] = 441.34070658681;
        ["sublevel"] = 8;
      };
    };
    ["id"] = 114790;
    ["isBoss"] = true;
    ["encounterID"] = 1838;
    ["scale"] = 1;
    ["health"] = 112311272;
    ["displayId"] = 73709;
    ["creatureType"] = "Humanoid";
    ["level"] = 112;
    ["count"] = 0;
    ["name"] = "Viz'aduum the Watcher";
  };
  [9] = {
    ["clones"] = {
      [1] = {
        ["y"] = -260.86076295513;
        ["x"] = 345.77449405004;
        ["scale"] = 2.5;
        ["sublevel"] = 2;
      };
    };
    ["id"] = 115757;
    ["color"] = {
      ["a"] = 0.8;
      ["b"] = 1;
      ["g"] = 1;
      ["r"] = 1;
    };
    ["scale"] = 1.2;
    ["health"] = 18258814.76;
    ["displayId"] = 73944;
    ["creatureType"] = "Demon";
    ["level"] = 111;
    ["name"] = "Wrathguard Flamebringer";
    ["count"] = 8;
  };
  [18] = {
    ["clones"] = {
      [1] = {
        ["y"] = -257.12732056623;
        ["x"] = 610.77666040138;
        ["scale"] = 2.5;
        ["sublevel"] = 2;
      };
    };
    ["id"] = 114350;
    ["isBoss"] = true;
    ["encounterID"] = 1817;
    ["scale"] = 1;
    ["health"] = 93092225;
    ["displayId"] = 73834;
    ["creatureType"] = "Humanoid";
    ["level"] = 112;
    ["count"] = 0;
    ["name"] = "Shade of Medivh";
  };
  [5] = {
    ["clones"] = {
      [1] = {
        ["sublevel"] = 1;
        ["x"] = 262.35528889546;
        ["scale"] = 2;
        ["g"] = 1;
        ["y"] = -224.28866472999;
      };
      [2] = {
        ["sublevel"] = 1;
        ["x"] = 333.00593954768;
        ["scale"] = 2;
        ["g"] = 2;
        ["y"] = -257.96603773851;
      };
      [4] = {
        ["sublevel"] = 1;
        ["x"] = 379.70272550865;
        ["scale"] = 2;
        ["g"] = 4;
        ["y"] = -313.84200532114;
      };
      [3] = {
        ["sublevel"] = 1;
        ["x"] = 321.96787310256;
        ["scale"] = 2;
        ["g"] = 3;
        ["y"] = -308.96000666707;
      };
    };
    ["id"] = 114338;
    ["color"] = {
      ["a"] = 0.8;
      ["b"] = 1;
      ["g"] = 1;
      ["r"] = 1;
    };
    ["scale"] = 1.4;
    ["health"] = 6873911.06;
    ["displayId"] = 55144;
    ["creatureType"] = "Elemental";
    ["level"] = 111;
    ["name"] = "Mana Confluence";
    ["count"] = 10;
  };
  [10] = {
    ["clones"] = {
      [1] = {
        ["y"] = -374.34635524231;
        ["x"] = 474.68903952577;
        ["scale"] = 2;
        ["sublevel"] = 3;
      };
      [2] = {
        ["y"] = -461.31433296275;
        ["x"] = 473.66804823727;
        ["scale"] = 2;
        ["sublevel"] = 3;
      };
      [3] = {
        ["y"] = -259.4985842891;
        ["x"] = 480.9967549108;
        ["scale"] = 2;
        ["sublevel"] = 3;
      };
    };
    ["id"] = 115417;
    ["color"] = {
      ["a"] = 0.8;
      ["b"] = 1;
      ["g"] = 1;
      ["r"] = 1;
    };
    ["scale"] = 1.2;
    ["health"] = 17184766.18;
    ["displayId"] = 73857;
    ["creatureType"] = "Beast";
    ["level"] = 111;
    ["name"] = "Rat";
    ["count"] = 8;
  };
  [11] = {
    ["clones"] = {
      [1] = {
        ["y"] = -447.78504968121;
        ["x"] = 435.08172399338;
        ["scale"] = 2;
        ["sublevel"] = 3;
      };
      [2] = {
        ["y"] = -246.19244215973;
        ["x"] = 427.7365100196;
        ["scale"] = 2;
        ["sublevel"] = 3;
      };
    };
    ["id"] = 115419;
    ["color"] = {
      ["a"] = 0.8;
      ["b"] = 1;
      ["g"] = 1;
      ["r"] = 1;
    };
    ["scale"] = 1.4;
    ["health"] = 16110718.34;
    ["displayId"] = 73859;
    ["creatureType"] = "Beast";
    ["level"] = 111;
    ["name"] = "Ancient Tome";
    ["count"] = 8;
  };
  [3] = {
    ["clones"] = {
      [1] = {
        ["y"] = -117.26072255073;
        ["x"] = 443.80706074019;
        ["scale"] = 2;
        ["sublevel"] = 1;
      };
      [2] = {
        ["y"] = -185.49787051691;
        ["x"] = 443.05142354815;
        ["scale"] = 2;
        ["sublevel"] = 1;
      };
      [4] = {
        ["y"] = -319.78934580451;
        ["x"] = 372.45886686736;
        ["scale"] = 2;
        ["teeming"] = true;
        ["g"] = 4;
        ["sublevel"] = 1;
      };
      [3] = {
        ["y"] = -227.08774103385;
        ["x"] = 256.36316305923;
        ["scale"] = 2;
        ["teeming"] = true;
        ["g"] = 1;
        ["sublevel"] = 1;
      };
    };
    ["id"] = 114334;
    ["color"] = {
      ["a"] = 0.8;
      ["b"] = 1;
      ["g"] = 1;
      ["r"] = 1;
    };
    ["scale"] = 1.2;
    ["health"] = 12888583.7;
    ["displayId"] = 61850;
    ["creatureType"] = "Mechanical";
    ["level"] = 111;
    ["name"] = "Damaged Golem";
    ["count"] = 4;
  };
  [6] = {
    ["clones"] = {
      [7] = {
        ["sublevel"] = 1;
        ["x"] = 304.98610866343;
        ["scale"] = 2;
        ["g"] = 3;
        ["y"] = -301.33382975522;
      };
      [1] = {
        ["sublevel"] = 1;
        ["x"] = 247.03571617836;
        ["scale"] = 2;
        ["g"] = 1;
        ["y"] = -209.73083766634;
      };
      [2] = {
        ["sublevel"] = 1;
        ["x"] = 242.19165898113;
        ["scale"] = 2;
        ["g"] = 1;
        ["y"] = -226.61543012071;
      };
      [4] = {
        ["sublevel"] = 1;
        ["x"] = 354.53902170909;
        ["scale"] = 2;
        ["g"] = 2;
        ["y"] = -261.78767269641;
      };
      [8] = {
        ["sublevel"] = 1;
        ["x"] = 318.57401958035;
        ["scale"] = 2;
        ["g"] = 3;
        ["y"] = -329.09224481191;
      };
      [9] = {
        ["sublevel"] = 1;
        ["x"] = 303.94957044958;
        ["scale"] = 2;
        ["g"] = 3;
        ["y"] = -319.28660332268;
      };
      [5] = {
        ["sublevel"] = 1;
        ["x"] = 350.7056608343;
        ["scale"] = 2;
        ["g"] = 2;
        ["y"] = -245.04909140713;
      };
      [10] = {
        ["sublevel"] = 1;
        ["x"] = 393.41709534562;
        ["scale"] = 2;
        ["g"] = 4;
        ["y"] = -298.6961502994;
      };
      [3] = {
        ["sublevel"] = 1;
        ["x"] = 251.92956938108;
        ["scale"] = 2;
        ["g"] = 1;
        ["y"] = -239.65208985499;
      };
      [6] = {
        ["sublevel"] = 1;
        ["x"] = 335.51092203845;
        ["scale"] = 2;
        ["g"] = 2;
        ["y"] = -236.597293427;
      };
      [12] = {
        ["sublevel"] = 1;
        ["x"] = 377.86325923375;
        ["scale"] = 2;
        ["g"] = 4;
        ["y"] = -291.87695818172;
      };
      [11] = {
        ["sublevel"] = 1;
        ["x"] = 399.40254652721;
        ["scale"] = 2;
        ["g"] = 4;
        ["y"] = -314.63531456449;
      };
    };
    ["id"] = 114364;
    ["color"] = {
      ["a"] = 0.8;
      ["b"] = 1;
      ["g"] = 1;
      ["r"] = 1;
    };
    ["scale"] = 1;
    ["health"] = 2491747.98;
    ["displayId"] = 62387;
    ["creatureType"] = "Beast";
    ["level"] = 110;
    ["name"] = "Mana-Gorged Wyrm";
    ["count"] = 1;
  };
  [12] = {
    ["clones"] = {
      [1] = {
        ["y"] = -329.82874820557;
        ["x"] = 428.6455740107;
        ["scale"] = 3;
        ["sublevel"] = 3;
      };
      [2] = {
        ["y"] = -203.65505816842;
        ["x"] = 449.54575180258;
        ["scale"] = 3;
        ["sublevel"] = 3;
      };
      [3] = {
        ["sublevel"] = 3;
        ["x"] = 464.98593800353;
        ["scale"] = 2;
        ["teeming"] = true;
        ["y"] = -449.68591588586;
      };
    };
    ["id"] = 115418;
    ["color"] = {
      ["a"] = 0.8;
      ["b"] = 1;
      ["g"] = 1;
      ["r"] = 1;
    };
    ["scale"] = 0.8;
    ["health"] = 18151408.2;
    ["displayId"] = 73858;
    ["creatureType"] = "Beast";
    ["level"] = 111;
    ["name"] = "Spider";
    ["count"] = 8;
  };
  [13] = {
    ["clones"] = {
      [1] = {
        ["y"] = -127.96457676718;
        ["x"] = 80.016429216955;
        ["scale"] = 2;
        ["sublevel"] = 4;
      };
      [2] = {
        ["sublevel"] = 4;
        ["x"] = 104.59029100448;
        ["scale"] = 2;
        ["g"] = 5;
        ["y"] = -107.40651911143;
      };
      [4] = {
        ["sublevel"] = 4;
        ["x"] = 119.9877491705;
        ["scale"] = 2;
        ["g"] = 5;
        ["y"] = -103.79872743966;
      };
      [8] = {
        ["sublevel"] = 4;
        ["x"] = 193.16237132049;
        ["scale"] = 2;
        ["g"] = 7;
        ["y"] = -151.18846039437;
      };
      [16] = {
        ["sublevel"] = 4;
        ["x"] = 113.645480494;
        ["scale"] = 2;
        ["g"] = 9;
        ["y"] = -197.16480766987;
      };
      [17] = {
        ["y"] = -150.22723855889;
        ["x"] = 187.72653133202;
        ["scale"] = 2;
        ["teeming"] = true;
        ["g"] = 7;
        ["sublevel"] = 4;
      };
      [9] = {
        ["sublevel"] = 4;
        ["x"] = 184.52604882834;
        ["scale"] = 2;
        ["g"] = 7;
        ["y"] = -139.87494629325;
      };
      [18] = {
        ["y"] = -141.59085754582;
        ["x"] = 176.81745132725;
        ["scale"] = 2;
        ["teeming"] = true;
        ["g"] = 7;
        ["sublevel"] = 4;
      };
      [5] = {
        ["sublevel"] = 4;
        ["x"] = 164.1540839584;
        ["scale"] = 2;
        ["g"] = 6;
        ["y"] = -96.185227457418;
      };
      [10] = {
        ["sublevel"] = 4;
        ["x"] = 177.75077163202;
        ["scale"] = 2;
        ["g"] = 7;
        ["y"] = -153.93726646726;
      };
      [20] = {
        ["y"] = -149.31813555385;
        ["x"] = 194.9992773445;
        ["scale"] = 2;
        ["teeming"] = true;
        ["g"] = 7;
        ["sublevel"] = 4;
      };
      [21] = {
        ["y"] = -133.8635795378;
        ["x"] = 175.90838733616;
        ["scale"] = 2;
        ["teeming"] = true;
        ["g"] = 7;
        ["sublevel"] = 4;
      };
      [11] = {
        ["sublevel"] = 4;
        ["x"] = 154.46886453638;
        ["scale"] = 2;
        ["g"] = 8;
        ["y"] = -187.61835679954;
      };
      [3] = {
        ["sublevel"] = 4;
        ["x"] = 107.7793321077;
        ["scale"] = 2;
        ["g"] = 5;
        ["y"] = -92.463677266838;
      };
      [6] = {
        ["sublevel"] = 4;
        ["x"] = 154.26578081199;
        ["scale"] = 2;
        ["g"] = 6;
        ["y"] = -109.09870281373;
      };
      [12] = {
        ["sublevel"] = 4;
        ["x"] = 140.41720572287;
        ["scale"] = 2;
        ["g"] = 8;
        ["y"] = -194.85177579116;
      };
      [13] = {
        ["sublevel"] = 4;
        ["x"] = 153.99648368376;
        ["scale"] = 2;
        ["g"] = 8;
        ["y"] = -203.46317267354;
      };
      [7] = {
        ["sublevel"] = 4;
        ["x"] = 168.71249145571;
        ["scale"] = 2;
        ["g"] = 6;
        ["y"] = -114.15678937976;
      };
      [14] = {
        ["sublevel"] = 4;
        ["x"] = 112.26403565029;
        ["scale"] = 2;
        ["g"] = 9;
        ["y"] = -182.23614006368;
      };
      [19] = {
        ["y"] = -134.77266303587;
        ["x"] = 188.63563433707;
        ["scale"] = 2;
        ["teeming"] = true;
        ["g"] = 7;
        ["sublevel"] = 4;
      };
      [15] = {
        ["sublevel"] = 4;
        ["x"] = 97.353320121018;
        ["scale"] = 2;
        ["g"] = 9;
        ["y"] = -191.76377522473;
      };
    };
    ["id"] = 115831;
    ["color"] = {
      ["a"] = 0.8;
      ["b"] = 1;
      ["g"] = 1;
      ["r"] = 1;
    };
    ["scale"] = 1;
    ["health"] = 8999917;
    ["displayId"] = 62384;
    ["creatureType"] = "Elemental";
    ["level"] = 112;
    ["name"] = "Mana Devourer";
    ["count"] = 4;
  };
  [7] = {
    ["clones"] = {
      [6] = {
        ["y"] = -353.40131807648;
        ["x"] = 479.77912390227;
        ["scale"] = 2;
        ["teeming"] = true;
        ["g"] = 14;
        ["sublevel"] = 4;
      };
      [2] = {
        ["y"] = -197.14074829487;
        ["x"] = 101.81658901231;
        ["scale"] = 2.5;
        ["sublevel"] = 2;
      };
      [3] = {
        ["sublevel"] = 4;
        ["x"] = 485.03591289818;
        ["scale"] = 2;
        ["y"] = -348.53785438363;
      };
      [1] = {
        ["y"] = -224.86141950088;
        ["x"] = 192.7267165289;
        ["patrol"] = {
          [6] = {
            ["y"] = -235.59778998003;
            ["x"] = 176.36301849385;
          };
          [2] = {
            ["y"] = -232.85386527592;
            ["x"] = 214.09032503591;
          };
          [3] = {
            ["y"] = -224.86141950088;
            ["x"] = 192.7267165289;
          };
          [1] = {
            ["y"] = -224.86141950088;
            ["x"] = 192.7267165289;
          };
          [4] = {
            ["y"] = -235.59778998003;
            ["x"] = 176.36301849385;
          };
          [5] = {
            ["y"] = -238.40918823135;
            ["x"] = 156.81757698299;
          };
        };
        ["sublevel"] = 2;
        ["scale"] = 2.5;
        ["patrolFacing"] = 1.9634954084936;
        ["patrolFacing2"] = 4.5160394395353;
      };
      [4] = {
        ["y"] = -228.86141950088;
        ["x"] = 192.7267165289;
        ["scale"] = 2.5;
        ["teeming"] = true;
        ["g"] = 12;
        ["sublevel"] = 2;
      };
      [5] = {
        ["y"] = -240.86553566596;
        ["x"] = 497.17010486843;
        ["scale"] = 2.5;
        ["teeming"] = true;
        ["g"] = 13;
        ["sublevel"] = 4;
      };
    };
    ["id"] = 115488;
    ["color"] = {
      ["a"] = 0.8;
      ["b"] = 1;
      ["g"] = 1;
      ["r"] = 1;
    };
    ["scale"] = 1.2;
    ["health"] = 12888574.82;
    ["displayId"] = 63419;
    ["creatureType"] = "Demon";
    ["level"] = 111;
    ["name"] = "Infused Pyromancer";
    ["count"] = 4;
  };
  [14] = {
    ["clones"] = {
      [1] = {
        ["sublevel"] = 4;
        ["x"] = 502.30082732607;
        ["scale"] = 2.5;
        ["y"] = -245.85890748732;
      };
    };
    ["id"] = 115486;
    ["color"] = {
      ["a"] = 0.8;
      ["b"] = 1;
      ["g"] = 1;
      ["r"] = 1;
    };
    ["scale"] = 1;
    ["health"] = 17453278.14;
    ["displayId"] = 73838;
    ["creatureType"] = "Demon";
    ["level"] = 111;
    ["name"] = "Erudite Slayer";
    ["count"] = 8;
  };
  [15] = {
    ["clones"] = {
      [1] = {
        ["y"] = -166.13568557028;
        ["x"] = 417.50949641267;
        ["sublevel"] = 5;
      };
    };
    ["id"] = 115388;
    ["color"] = {
      ["a"] = 0.8;
      ["b"] = 1;
      ["g"] = 1;
      ["r"] = 1;
    };
    ["scale"] = 1.4;
    ["health"] = 45110011.5;
    ["displayId"] = 16293;
    ["creatureType"] = "Humanoid";
    ["level"] = 111;
    ["name"] = "King";
    ["count"] = 12;
  };
  [19] = {
    ["clones"] = {
      [1] = {
        ["y"] = -170.2433924311;
        ["x"] = 487.87926479881;
        ["scale"] = 2;
        ["sublevel"] = 3;
      };
    };
    ["id"] = 114252;
    ["isBoss"] = true;
    ["encounterID"] = 1818;
    ["scale"] = 1;
    ["health"] = 93092225;
    ["displayId"] = 73157;
    ["creatureType"] = "Dragonkin";
    ["level"] = 112;
    ["count"] = 0;
    ["name"] = "Mana Devourer";
  };
};
