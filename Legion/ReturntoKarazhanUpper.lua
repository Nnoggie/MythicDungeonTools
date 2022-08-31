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
      ["template"] = "DeathReleasePinTemplate";
      ["type"] = "graveyard";
      ["x"] = 506.07668238822;
      ["y"] = -163.55893042282;
      ["graveyardDescription"] = "";
    };
    [2] = {
      ["template"] = "MapLinkPinTemplate";
      ["type"] = "mapLink";
      ["x"] = 436.89732993917;
      ["y"] = -426.79264705758;
      ["target"] = 2;
      ["direction"] = 2;
      ["connectionIndex"] = 1;
    };
  };
  [2] = {
    [1] = {
      ["template"] = "MapLinkPinTemplate";
      ["type"] = "mapLink";
      ["x"] = 178.93989940488;
      ["y"] = -94.965634433628;
      ["target"] = 1;
      ["direction"] = -2;
      ["connectionIndex"] = 1;
    };
    [2] = {
      ["template"] = "MapLinkPinTemplate";
      ["type"] = "mapLink";
      ["x"] = 616.29488165028;
      ["y"] = -327.71354610659;
      ["target"] = 3;
      ["direction"] = -1;
      ["connectionIndex"] = 2;
    };
  };
  [3] = {
    [1] = {
      ["template"] = "MapLinkPinTemplate";
      ["type"] = "mapLink";
      ["x"] = 387.6508747865;
      ["y"] = -303.09038562315;
      ["target"] = 2;
      ["direction"] = 1;
      ["connectionIndex"] = 2;
    };
    [2] = {
      ["template"] = "MapLinkPinTemplate";
      ["type"] = "mapLink";
      ["x"] = 536.56262153581;
      ["y"] = -126.03776422687;
      ["target"] = 4;
      ["direction"] = 2;
      ["connectionIndex"] = 3;
    };
  };
  [4] = {
    [1] = {
      ["template"] = "DeathReleasePinTemplate";
      ["type"] = "graveyard";
      ["x"] = 80.44712328533;
      ["y"] = -145.97086280194;
      ["graveyardDescription"] = "";
    };
    [2] = {
      ["template"] = "MapLinkPinTemplate";
      ["type"] = "mapLink";
      ["x"] = 54.065156039803;
      ["y"] = -143.62583184775;
      ["target"] = 3;
      ["direction"] = -2;
      ["connectionIndex"] = 3;
    };
    [3] = {
      ["template"] = "MapLinkPinTemplate";
      ["type"] = "mapLink";
      ["x"] = 474.41836194932;
      ["y"] = -468.41755033046;
      ["target"] = 5;
      ["direction"] = -1;
      ["connectionIndex"] = 4;
    };
    [4] = {
      ["template"] = "MapLinkPinTemplate";
      ["type"] = "generalNote";
      ["x"] = 97.230636733041;
      ["y"] = -133.25821564774;
      ["text"] = "manaDevourerNote";
    };
  };
  [5] = {
    [1] = {
      ["template"] = "MapLinkPinTemplate";
      ["type"] = "mapLink";
      ["x"] = 415.79171588701;
      ["y"] = -79.136474214181;
      ["target"] = 4;
      ["direction"] = 1;
      ["connectionIndex"] = 4;
    };
    [2] = {
      ["template"] = "MapLinkPinTemplate";
      ["type"] = "mapLink";
      ["x"] = 360.68261625597;
      ["y"] = -504.17984267142;
      ["target"] = 6;
      ["direction"] = -2;
      ["connectionIndex"] = 5;
    };
  };
  [6] = {
    [1] = {
      ["template"] = "MapLinkPinTemplate";
      ["type"] = "mapLink";
      ["x"] = 505.49049174257;
      ["y"] = -281.39848028599;
      ["target"] = 5;
      ["direction"] = 2;
      ["connectionIndex"] = 5;
    };
  };
};

MDT.dungeonEnemies[dungeonIndex] = {
  [1] = {
    ["name"] = "Forlorn Spirit";
    ["id"] = 114626;
    ["count"] = 4;
    ["health"] = 340880;
    ["scale"] = 1;
    ["displayId"] = 26404;
    ["creatureType"] = "Undead";
    ["level"] = 111;
    ["characteristics"] = {
      ["Taunt"] = true;
    };
    ["spells"] = {
      [228252] = {
      };
      [228254] = {
      };
      [228255] = {
      };
    };
    ["clones"] = {
      [1] = {
        ["x"] = 590.75941310579;
        ["y"] = -155.57717427968;
        ["sublevel"] = 1;
        ["scale"] = 2;
        ["disguised"] = true;
      };
      [2] = {
        ["x"] = 589.45739867598;
        ["y"] = -180.86195969186;
        ["sublevel"] = 1;
        ["scale"] = 2;
      };
    };
  };
  [2] = {
    ["name"] = "Shrieking Terror";
    ["id"] = 114627;
    ["count"] = 4;
    ["health"] = 382886;
    ["scale"] = 1;
    ["displayId"] = 10698;
    ["creatureType"] = "Undead";
    ["level"] = 110;
    ["characteristics"] = {
      ["Taunt"] = true;
    };
    ["spells"] = {
      [228239] = {
      };
      [228241] = {
      };
    };
    ["clones"] = {
      [1] = {
        ["x"] = 565.48515026323;
        ["y"] = -165.2445073506;
        ["sublevel"] = 1;
        ["scale"] = 2;
        ["disguised"] = true;
      };
    };
  };
  [3] = {
    ["name"] = "Damaged Golem";
    ["id"] = 114334;
    ["count"] = 6;
    ["health"] = 306309;
    ["scale"] = 1.2;
    ["displayId"] = 61850;
    ["creatureType"] = "Mechanical";
    ["level"] = 111;
    ["characteristics"] = {
      ["Taunt"] = true;
    };
    ["spells"] = {
      [227529] = {
      };
      [242894] = {
      };
    };
    ["clones"] = {
      [1] = {
        ["x"] = 443.80706074019;
        ["y"] = -117.26072255073;
        ["sublevel"] = 1;
        ["scale"] = 2;
      };
      [2] = {
        ["x"] = 443.05142354815;
        ["y"] = -185.49787051691;
        ["sublevel"] = 1;
        ["scale"] = 2;
      };
      [3] = {
        ["x"] = 256.36316305923;
        ["y"] = -227.08774103385;
        ["g"] = 1;
        ["sublevel"] = 1;
        ["scale"] = 2;
        ["teeming"] = true;
      };
      [4] = {
        ["x"] = 372.45886686736;
        ["y"] = -319.78934580451;
        ["g"] = 4;
        ["sublevel"] = 1;
        ["scale"] = 2;
        ["teeming"] = true;
      };
    };
  };
  [4] = {
    ["name"] = "Abstract Nullifier";
    ["id"] = 115765;
    ["count"] = 18;
    ["health"] = 340343;
    ["scale"] = 1.2;
    ["displayId"] = 74335;
    ["creatureType"] = "Mechanical";
    ["level"] = 111;
    ["characteristics"] = {
      ["Taunt"] = true;
    };
    ["spells"] = {
      [230050] = {
      };
      [230083] = {
      };
      [230094] = {
      };
      [230161] = {
      };
      [230162] = {
      };
    };
    ["clones"] = {
      [1] = {
        ["x"] = 336.99656507;
        ["y"] = -166.49866242334;
        ["sublevel"] = 1;
        ["scale"] = 3.2;
      };
    };
  };
  [5] = {
    ["name"] = "Mana Confluence";
    ["id"] = 114338;
    ["count"] = 9;
    ["health"] = 306309;
    ["scale"] = 1.4;
    ["displayId"] = 55144;
    ["creatureType"] = "Elemental";
    ["level"] = 111;
    ["characteristics"] = {
      ["Taunt"] = true;
    };
    ["spells"] = {
      [228700] = {
      };
    };
    ["clones"] = {
      [1] = {
        ["x"] = 262.35528889546;
        ["y"] = -224.28866472999;
        ["g"] = 1;
        ["sublevel"] = 1;
        ["scale"] = 2;
      };
      [2] = {
        ["x"] = 333.00593954768;
        ["y"] = -257.96603773851;
        ["g"] = 2;
        ["sublevel"] = 1;
        ["scale"] = 2;
      };
      [3] = {
        ["x"] = 321.96787310256;
        ["y"] = -308.96000666707;
        ["g"] = 3;
        ["sublevel"] = 1;
        ["scale"] = 2;
      };
      [4] = {
        ["x"] = 379.70272550865;
        ["y"] = -313.84200532114;
        ["g"] = 4;
        ["sublevel"] = 1;
        ["scale"] = 2;
      };
    };
  };
  [6] = {
    ["name"] = "Mana-Gorged Wyrm";
    ["id"] = 114364;
    ["count"] = 1;
    ["health"] = 102103;
    ["scale"] = 1;
    ["displayId"] = 62387;
    ["creatureType"] = "Beast";
    ["level"] = 110;
    ["characteristics"] = {
      ["Taunt"] = true;
    };
    ["spells"] = {
      [228362] = {
      };
      [232271] = {
      };
    };
    ["clones"] = {
      [1] = {
        ["x"] = 247.03571617836;
        ["y"] = -209.73083766634;
        ["g"] = 1;
        ["sublevel"] = 1;
        ["scale"] = 2;
      };
      [2] = {
        ["x"] = 242.19165898113;
        ["y"] = -226.61543012071;
        ["g"] = 1;
        ["sublevel"] = 1;
        ["scale"] = 2;
        ["inspiring"] = true;
      };
      [3] = {
        ["x"] = 251.92956938108;
        ["y"] = -239.65208985499;
        ["g"] = 1;
        ["sublevel"] = 1;
        ["scale"] = 2;
      };
      [4] = {
        ["x"] = 354.53902170909;
        ["y"] = -261.78767269641;
        ["g"] = 2;
        ["sublevel"] = 1;
        ["scale"] = 2;
      };
      [5] = {
        ["x"] = 350.7056608343;
        ["y"] = -245.04909140713;
        ["g"] = 2;
        ["sublevel"] = 1;
        ["scale"] = 2;
        ["disguised"] = true;
      };
      [6] = {
        ["x"] = 335.51092203845;
        ["y"] = -236.597293427;
        ["g"] = 2;
        ["sublevel"] = 1;
        ["scale"] = 2;
      };
      [7] = {
        ["x"] = 304.98610866343;
        ["y"] = -301.33382975522;
        ["g"] = 3;
        ["sublevel"] = 1;
        ["scale"] = 2;
      };
      [8] = {
        ["x"] = 318.57401958035;
        ["y"] = -329.09224481191;
        ["g"] = 3;
        ["sublevel"] = 1;
        ["scale"] = 2;
      };
      [9] = {
        ["x"] = 303.94957044958;
        ["y"] = -319.28660332268;
        ["g"] = 3;
        ["sublevel"] = 1;
        ["scale"] = 2;
      };
      [10] = {
        ["x"] = 393.41709534562;
        ["y"] = -298.6961502994;
        ["g"] = 4;
        ["sublevel"] = 1;
        ["scale"] = 2;
        ["inspiring"] = true;
      };
      [11] = {
        ["x"] = 399.40254652721;
        ["y"] = -314.63531456449;
        ["g"] = 4;
        ["sublevel"] = 1;
        ["scale"] = 2;
      };
      [12] = {
        ["x"] = 377.86325923375;
        ["y"] = -291.87695818172;
        ["g"] = 4;
        ["sublevel"] = 1;
        ["scale"] = 2;
      };
    };
  };
  [7] = {
    ["name"] = "Infused Pyromancer";
    ["id"] = 115488;
    ["count"] = 8;
    ["health"] = 467972;
    ["scale"] = 1.2;
    ["displayId"] = 63419;
    ["creatureType"] = "Demon";
    ["level"] = 111;
    ["characteristics"] = {
      ["Taunt"] = true;
    };
    ["spells"] = {
      [229677] = {
      };
      [229678] = {
      };
      [374743] = {
      };
    };
    ["clones"] = {
      [1] = {
        ["x"] = 192.7267165289;
        ["y"] = -224.86141950088;
        ["sublevel"] = 2;
        ["scale"] = 2.5;
        ["patrolFacing"] = 1.9634954084936;
        ["patrolFacing2"] = 4.5160394395353;
        ["patrol"] = {
          [1] = {
            ["x"] = 192.7267165289;
            ["y"] = -224.86141950088;
          };
          [2] = {
            ["x"] = 214.09032503591;
            ["y"] = -232.85386527592;
          };
          [3] = {
            ["x"] = 192.7267165289;
            ["y"] = -224.86141950088;
          };
          [4] = {
            ["x"] = 176.36301849385;
            ["y"] = -235.59778998003;
          };
          [5] = {
            ["x"] = 156.81757698299;
            ["y"] = -238.40918823135;
          };
          [6] = {
            ["x"] = 176.36301849385;
            ["y"] = -235.59778998003;
          };
        };
      };
      [2] = {
        ["x"] = 101.81658901231;
        ["y"] = -197.14074829487;
        ["sublevel"] = 2;
        ["scale"] = 2.5;
        ["disguised"] = true;
      };
      [3] = {
        ["x"] = 485.03591289818;
        ["y"] = -348.53785438363;
        ["sublevel"] = 4;
        ["scale"] = 2;
      };
      [4] = {
        ["x"] = 192.7267165289;
        ["y"] = -228.86141950088;
        ["g"] = 12;
        ["sublevel"] = 2;
        ["scale"] = 2.5;
        ["teeming"] = true;
      };
      [5] = {
        ["x"] = 497.17010486843;
        ["y"] = -240.86553566596;
        ["g"] = 13;
        ["sublevel"] = 4;
        ["scale"] = 2.5;
        ["teeming"] = true;
      };
      [6] = {
        ["x"] = 479.77912390227;
        ["y"] = -353.40131807648;
        ["g"] = 14;
        ["sublevel"] = 4;
        ["scale"] = 2;
        ["teeming"] = true;
      };
    };
  };
  [8] = {
    ["name"] = "Fel Bat";
    ["id"] = 115484;
    ["count"] = 4;
    ["health"] = 212714;
    ["scale"] = 0.8;
    ["displayId"] = 73837;
    ["creatureType"] = "Demon";
    ["level"] = 110;
    ["characteristics"] = {
      ["Taunt"] = true;
      ["Sap"] = true;
    };
    ["spells"] = {
      [229597] = {
      };
      [229622] = {
      };
      [229623] = {
      };
    };
    ["clones"] = {
      [1] = {
        ["x"] = 188.63467754792;
        ["y"] = -221.68617830559;
        ["sublevel"] = 2;
        ["scale"] = 2.5;
        ["disguised"] = true;
      };
      [2] = {
        ["x"] = 224.99634234794;
        ["y"] = -210.49869462475;
        ["sublevel"] = 2;
        ["scale"] = 3;
      };
      [3] = {
        ["x"] = 228.63476638022;
        ["y"] = -253.17700153437;
        ["sublevel"] = 2;
        ["scale"] = 3;
        ["disguised"] = true;
      };
      [4] = {
        ["x"] = 212.72561812359;
        ["y"] = -285.44971305058;
        ["sublevel"] = 2;
        ["scale"] = 3;
      };
      [5] = {
        ["x"] = 166.81651753839;
        ["y"] = -273.96741412704;
        ["sublevel"] = 2;
        ["scale"] = 3;
      };
      [6] = {
        ["x"] = 532.46149506956;
        ["y"] = -153.89952441422;
        ["sublevel"] = 4;
        ["scale"] = 2.5;
      };
      [7] = {
        ["x"] = 544.26536360351;
        ["y"] = -128.56425974077;
        ["sublevel"] = 4;
        ["scale"] = 2.5;
      };
      [8] = {
        ["x"] = 551.16631569971;
        ["y"] = -190.89288538273;
        ["sublevel"] = 4;
        ["scale"] = 2.4;
      };
      [9] = {
        ["x"] = 465.04553373313;
        ["y"] = -212.23328283569;
        ["sublevel"] = 4;
        ["scale"] = 2.5;
      };
      [10] = {
        ["x"] = 549.76347260237;
        ["y"] = -232.99953070271;
        ["sublevel"] = 4;
        ["scale"] = 2.5;
      };
      [11] = {
        ["x"] = 450.48219976211;
        ["y"] = -252.97808456626;
        ["sublevel"] = 4;
        ["scale"] = 2.5;
      };
      [12] = {
        ["x"] = 523.35818790605;
        ["y"] = -401.20429770968;
        ["sublevel"] = 4;
        ["scale"] = 2.5;
      };
      [13] = {
        ["x"] = 479.86831954016;
        ["y"] = -434.88581986622;
        ["sublevel"] = 4;
        ["scale"] = 2.5;
      };
      [14] = {
        ["x"] = 487.04143040706;
        ["y"] = -311.03628342242;
        ["sublevel"] = 4;
        ["scale"] = 2.5;
        ["disguised"] = true;
      };
    };
  };
  [9] = {
    ["name"] = "Wrathguard Flamebringer";
    ["id"] = 115757;
    ["count"] = 12;
    ["health"] = 638144;
    ["scale"] = 1.2;
    ["displayId"] = 73944;
    ["creatureType"] = "Demon";
    ["level"] = 111;
    ["characteristics"] = {
      ["Taunt"] = true;
    };
    ["spells"] = {
      [191540] = {
      };
      [230043] = {
      };
      [230044] = {
      };
    };
    ["clones"] = {
      [1] = {
        ["x"] = 345.77449405004;
        ["y"] = -260.86076295513;
        ["sublevel"] = 2;
        ["scale"] = 2.5;
      };
    };
  };
  [10] = {
    ["name"] = "Rat";
    ["id"] = 115417;
    ["count"] = 7;
    ["health"] = 382886;
    ["scale"] = 1.2;
    ["displayId"] = 73857;
    ["creatureType"] = "Beast";
    ["level"] = 111;
    ["characteristics"] = {
      ["Taunt"] = true;
    };
    ["spells"] = {
      [229692] = {
      };
      [229693] = {
      };
      [229696] = {
      };
      [229698] = {
      };
    };
    ["clones"] = {
      [1] = {
        ["x"] = 474.68903952577;
        ["y"] = -374.34635524231;
        ["sublevel"] = 3;
        ["scale"] = 2;
        ["disguised"] = true;
      };
      [2] = {
        ["x"] = 473.66804823727;
        ["y"] = -461.31433296275;
        ["sublevel"] = 3;
        ["scale"] = 2;
      };
      [3] = {
        ["x"] = 480.9967549108;
        ["y"] = -259.4985842891;
        ["sublevel"] = 3;
        ["scale"] = 2;
      };
    };
  };
  [11] = {
    ["name"] = "Ancient Tome";
    ["id"] = 115419;
    ["count"] = 7;
    ["health"] = 298270;
    ["scale"] = 1.4;
    ["displayId"] = 73859;
    ["creatureType"] = "Beast";
    ["level"] = 111;
    ["clones"] = {
      [1] = {
        ["x"] = 435.08172399338;
        ["y"] = -447.78504968121;
        ["sublevel"] = 3;
        ["scale"] = 2;
      };
      [2] = {
        ["x"] = 427.7365100196;
        ["y"] = -246.19244215973;
        ["sublevel"] = 3;
        ["scale"] = 2;
      };
    };
  };
  [12] = {
    ["name"] = "Spider";
    ["id"] = 115418;
    ["count"] = 7;
    ["health"] = 319072;
    ["scale"] = 0.8;
    ["displayId"] = 73858;
    ["creatureType"] = "Beast";
    ["level"] = 111;
    ["characteristics"] = {
      ["Taunt"] = true;
    };
    ["spells"] = {
      [229704] = {
      };
      [229705] = {
      };
      [229706] = {
      };
    };
    ["clones"] = {
      [1] = {
        ["x"] = 428.6455740107;
        ["y"] = -329.82874820557;
        ["sublevel"] = 3;
        ["scale"] = 3;
      };
      [2] = {
        ["x"] = 449.54575180258;
        ["y"] = -203.65505816842;
        ["sublevel"] = 3;
        ["scale"] = 3;
        ["disguised"] = true;
      };
      [3] = {
        ["x"] = 464.98593800353;
        ["y"] = -449.68591588586;
        ["sublevel"] = 3;
        ["scale"] = 2;
        ["teeming"] = true;
      };
    };
  };
  [13] = {
    ["name"] = "Mana Devourer";
    ["id"] = 115831;
    ["count"] = 3;
    ["health"] = 212714;
    ["scale"] = 1;
    ["displayId"] = 62384;
    ["creatureType"] = "Elemental";
    ["level"] = 112;
    ["characteristics"] = {
      ["Taunt"] = true;
      ["Root"] = true;
      ["Disorient"] = true;
      ["Stun"] = true;
      ["Slow"] = true;
    };
    ["spells"] = {
      [230218] = {
      };
    };
    ["clones"] = {
      [1] = {
        ["x"] = 80.016429216955;
        ["y"] = -127.96457676718;
        ["sublevel"] = 4;
        ["scale"] = 2;
      };
      [2] = {
        ["x"] = 104.59029100448;
        ["y"] = -107.40651911143;
        ["g"] = 5;
        ["sublevel"] = 4;
        ["scale"] = 2;
      };
      [3] = {
        ["x"] = 107.7793321077;
        ["y"] = -92.463677266838;
        ["g"] = 5;
        ["sublevel"] = 4;
        ["scale"] = 2;
      };
      [4] = {
        ["x"] = 119.9877491705;
        ["y"] = -103.79872743966;
        ["g"] = 5;
        ["sublevel"] = 4;
        ["scale"] = 2;
      };
      [5] = {
        ["x"] = 164.1540839584;
        ["y"] = -96.185227457418;
        ["g"] = 6;
        ["sublevel"] = 4;
        ["scale"] = 2;
      };
      [6] = {
        ["x"] = 154.26578081199;
        ["y"] = -109.09870281373;
        ["g"] = 6;
        ["sublevel"] = 4;
        ["scale"] = 2;
      };
      [7] = {
        ["x"] = 168.71249145571;
        ["y"] = -114.15678937976;
        ["g"] = 6;
        ["sublevel"] = 4;
        ["scale"] = 2;
        ["inspiring"] = true;
      };
      [8] = {
        ["x"] = 193.16237132049;
        ["y"] = -151.18846039437;
        ["g"] = 7;
        ["sublevel"] = 4;
        ["scale"] = 2;
        ["disguised"] = true;
      };
      [9] = {
        ["x"] = 180.5786709392;
        ["y"] = -134.71297722697;
        ["g"] = 7;
        ["sublevel"] = 4;
        ["scale"] = 2;
      };
      [10] = {
        ["x"] = 177.14345866881;
        ["y"] = -161.22470928233;
        ["g"] = 7;
        ["sublevel"] = 4;
        ["scale"] = 2;
      };
      [11] = {
        ["x"] = 154.46886453638;
        ["y"] = -187.61835679954;
        ["g"] = 8;
        ["sublevel"] = 4;
        ["scale"] = 2;
      };
      [12] = {
        ["x"] = 140.41720572287;
        ["y"] = -194.85177579116;
        ["g"] = 8;
        ["sublevel"] = 4;
        ["scale"] = 2;
      };
      [13] = {
        ["x"] = 153.99648368376;
        ["y"] = -203.46317267354;
        ["g"] = 8;
        ["sublevel"] = 4;
        ["scale"] = 2;
        ["inspiring"] = true;
      };
      [14] = {
        ["x"] = 112.26403565029;
        ["y"] = -182.23614006368;
        ["g"] = 9;
        ["sublevel"] = 4;
        ["scale"] = 2;
      };
      [15] = {
        ["x"] = 97.353320121018;
        ["y"] = -191.76377522473;
        ["g"] = 9;
        ["sublevel"] = 4;
        ["scale"] = 2;
      };
      [16] = {
        ["x"] = 113.645480494;
        ["y"] = -197.16480766987;
        ["g"] = 9;
        ["sublevel"] = 4;
        ["scale"] = 2;
      };
      [17] = {
        ["x"] = 187.72653133202;
        ["y"] = -150.22723855889;
        ["g"] = 7;
        ["sublevel"] = 4;
        ["scale"] = 2;
        ["teeming"] = true;
      };
      [18] = {
        ["x"] = 176.81745132725;
        ["y"] = -141.59085754582;
        ["g"] = 7;
        ["sublevel"] = 4;
        ["scale"] = 2;
        ["teeming"] = true;
      };
      [19] = {
        ["x"] = 188.63563433707;
        ["y"] = -134.77266303587;
        ["g"] = 7;
        ["sublevel"] = 4;
        ["scale"] = 2;
        ["teeming"] = true;
      };
      [20] = {
        ["x"] = 194.9992773445;
        ["y"] = -149.31813555385;
        ["g"] = 7;
        ["sublevel"] = 4;
        ["scale"] = 2;
        ["teeming"] = true;
      };
      [21] = {
        ["x"] = 175.90838733616;
        ["y"] = -133.8635795378;
        ["g"] = 7;
        ["sublevel"] = 4;
        ["scale"] = 2;
        ["teeming"] = true;
      };
    };
  };
  [14] = {
    ["name"] = "Erudite Slayer";
    ["id"] = 115486;
    ["count"] = 9;
    ["health"] = 340343;
    ["scale"] = 1;
    ["displayId"] = 73838;
    ["creatureType"] = "Demon";
    ["level"] = 111;
    ["characteristics"] = {
      ["Taunt"] = true;
    };
    ["spells"] = {
      [229608] = {
      };
      [229611] = {
      };
    };
    ["clones"] = {
      [1] = {
        ["x"] = 513.993903931;
        ["y"] = -252.14324101615;
        ["g"] = 15;
        ["sublevel"] = 4;
        ["scale"] = 2.5;
      };
    };
  };
  [15] = {
    ["name"] = "King";
    ["id"] = 115388;
    ["count"] = 18;
    ["health"] = 638144;
    ["scale"] = 1.4;
    ["displayId"] = 16293;
    ["creatureType"] = "Humanoid";
    ["level"] = 111;
    ["characteristics"] = {
      ["Taunt"] = true;
    };
    ["spells"] = {
      [229427] = {
      };
      [229429] = {
      };
      [229468] = {
      };
      [229489] = {
      };
    };
    ["clones"] = {
      [1] = {
        ["x"] = 417.50949641267;
        ["y"] = -166.13568557028;
        ["sublevel"] = 5;
      };
    };
  };
  [16] = {
    ["name"] = "The Curator";
    ["id"] = 114247;
    ["count"] = 0;
    ["health"] = 2091168;
    ["scale"] = 1;
    ["displayId"] = 16958;
    ["creatureType"] = "Mechanical";
    ["level"] = 112;
    ["isBoss"] = true;
    ["encounterID"] = 1557;
    ["characteristics"] = {
      ["Taunt"] = true;
    };
    ["spells"] = {
      [227254] = {
      };
      [227257] = {
      };
      [227267] = {
      };
      [227285] = {
      };
      [227465] = {
      };
    };
    ["clones"] = {
      [1] = {
        ["x"] = 399.34973289673;
        ["y"] = -381.79316353425;
        ["sublevel"] = 1;
        ["scale"] = 2;
      };
    };
  };
  [17] = {
    ["name"] = "Viz'aduum the Watcher";
    ["id"] = 114790;
    ["count"] = 0;
    ["health"] = 1704400;
    ["scale"] = 1;
    ["displayId"] = 73709;
    ["creatureType"] = "Humanoid";
    ["level"] = 112;
    ["isBoss"] = true;
    ["encounterID"] = 1838;
    ["characteristics"] = {
      ["Taunt"] = true;
    };
    ["spells"] = {
      [229083] = {
      };
      [229151] = {
      };
      [229159] = {
      };
      [229161] = {
      };
      [229598] = {
      };
      [229610] = {
      };
      [230084] = {
      };
    };
    ["clones"] = {
      [1] = {
        ["x"] = 449.63635738203;
        ["y"] = -294.33741984929;
        ["sublevel"] = 6;
      };
    };
  };
  [18] = {
    ["name"] = "Shade of Medivh";
    ["id"] = 114350;
    ["count"] = 0;
    ["health"] = 1491350;
    ["scale"] = 1;
    ["displayId"] = 73834;
    ["creatureType"] = "Humanoid";
    ["level"] = 112;
    ["isBoss"] = true;
    ["encounterID"] = 1817;
    ["characteristics"] = {
      ["Taunt"] = true;
    };
    ["spells"] = {
      [227592] = {
      };
      [227615] = {
      };
      [227628] = {
      };
      [227641] = {
      };
      [227644] = {
      };
      [227779] = {
      };
      [228249] = {
      };
      [228261] = {
      };
      [228262] = {
      };
      [228269] = {
      };
      [228334] = {
      };
      [228958] = {
      };
    };
    ["clones"] = {
      [1] = {
        ["x"] = 610.77666040138;
        ["y"] = -257.12732056623;
        ["sublevel"] = 2;
        ["scale"] = 2.5;
      };
    };
  };
  [19] = {
    ["name"] = "Mana Devourer";
    ["id"] = 114252;
    ["count"] = 0;
    ["health"] = 1917450;
    ["scale"] = 1;
    ["displayId"] = 73157;
    ["creatureType"] = "Dragonkin";
    ["level"] = 112;
    ["isBoss"] = true;
    ["encounterID"] = 1818;
    ["characteristics"] = {
      ["Taunt"] = true;
    };
    ["spells"] = {
      [227297] = {
      };
      [227457] = {
      };
      [227523] = {
      };
      [227618] = {
      };
      [227620] = {
      };
    };
    ["clones"] = {
      [1] = {
        ["x"] = 487.87926479881;
        ["y"] = -170.2433924311;
        ["sublevel"] = 3;
        ["scale"] = 2;
      };
    };
  };
  [20] = {
    ["name"] = "Nathrezim Infiltrator";
    ["id"] = 189878;
    ["count"] = 6;
    ["health"] = 239096;
    ["scale"] = 1.2;
    ["displayId"] = 101016;
    ["creatureType"] = "Demon";
    ["level"] = 61;
    ["characteristics"] = {
      ["Taunt"] = true;
    };
    ["spells"] = {
      [373364] = {
      };
      [373370] = {
      };
      [373391] = {
      };
      [373429] = {
      };
    };
    ["clones"] = {
      [1] = {
        ["x"] = 590.75941310579;
        ["y"] = -155.57717427968;
        ["sublevel"] = 1;
        ["scale"] = 2;
        ["shrouded"] = true;
      };
      [2] = {
        ["x"] = 350.7056608343;
        ["y"] = -245.04909140713;
        ["g"] = 2;
        ["sublevel"] = 1;
        ["scale"] = 2;
        ["shrouded"] = true;
      };
      [3] = {
        ["x"] = 101.81658901231;
        ["y"] = -197.14074829487;
        ["sublevel"] = 2;
        ["scale"] = 2.5;
        ["shrouded"] = true;
      };
      [4] = {
        ["x"] = 228.63476638022;
        ["y"] = -253.17700153437;
        ["sublevel"] = 2;
        ["scale"] = 2.5;
        ["shrouded"] = true;
      };
      [5] = {
        ["x"] = 474.68903952577;
        ["y"] = -374.34635524231;
        ["sublevel"] = 3;
        ["scale"] = 2.5;
        ["shrouded"] = true;
      };
      [6] = {
        ["x"] = 449.54575180258;
        ["y"] = -203.65505816842;
        ["sublevel"] = 3;
        ["scale"] = 2.5;
        ["shrouded"] = true;
      };
      [7] = {
        ["x"] = 193.16237132049;
        ["y"] = -151.18846039437;
        ["g"] = 7;
        ["sublevel"] = 4;
        ["scale"] = 2;
        ["shrouded"] = true;
      };
      [8] = {
        ["x"] = 489.46533752061;
        ["y"] = -250.7343364559;
        ["g"] = 15;
        ["sublevel"] = 4;
        ["scale"] = 2.5;
        ["shrouded"] = true;
      };
      [9] = {
        ["x"] = 487.04143040706;
        ["y"] = -311.03628342242;
        ["sublevel"] = 4;
        ["scale"] = 2.5;
        ["shrouded"] = true;
      };
    };
  };
  [21] = {
    ["name"] = "Zul'gamux";
    ["id"] = 190128;
    ["count"] = 18;
    ["health"] = 639150;
    ["scale"] = 1.8;
    ["displayId"] = 101106;
    ["creatureType"] = "Demon";
    ["level"] = 61;
    ["characteristics"] = {
      ["Taunt"] = true;
    };
    ["spells"] = {
      [373509] = {
      };
      [373513] = {
      };
      [373552] = {
      };
      [373570] = {
      };
      [373607] = {
      };
      [373724] = {
      };
      [373729] = {
      };
      [373744] = {
      };
      [373747] = {
      };
      [374273] = {
      };
    };
    ["clones"] = {
      [1] = {
        ["x"] = 565.48515026323;
        ["y"] = -165.2445073506;
        ["sublevel"] = 1;
        ["scale"] = 2;
        ["shrouded"] = true;
      };
    };
  };
};
