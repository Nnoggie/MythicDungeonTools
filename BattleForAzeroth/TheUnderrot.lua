local MDT = MDT
local L = MDT.L
local dungeonIndex = 22
MDT.mapInfo[dungeonIndex] = {
   viewportPositionOverrides =
   {
      [1] = {
         zoomScale = 1.2999999523163;
         horizontalPan = 140.28178402377;
         verticalPan = 46.130299439931;
      };
   };
};
MDT.dungeonTotalCount[dungeonIndex] = {normal=252,teeming=286,teemingEnabled=true}
MDT.mapPOIs[dungeonIndex] = {
   [1] = {
      [7] = {
         ["npcId"] = 161243;
         ["type"] = "nyalothaSpire";
         ["index"] = 3;
         ["y"] = -224.08700914697;
         ["x"] = 388.05381306055;
         ["tooltipText"] = L["Entropic Spire of Ny'alotha"];
         ["weeks"] = {
            [1] = true;
            [2] = true;
            [5] = true;
            [6] = true;
            [9] = true;
            [10] = true;
         };
         ["template"] = "VignettePinTemplate";
      };
      [1] = {
         ["y"] = -106.99817181006;
         ["x"] = 313.99999540486;
         ["template"] = "MapLinkPinTemplate";
         ["target"] = 2;
         ["connectionIndex"] = 1;
         ["direction"] = -2;
         ["type"] = "mapLink";
      };
      [2] = {
         ["y"] = -289.02272233371;
         ["x"] = 467.89305691257;
         ["template"] = "MapLinkPinTemplate";
         ["type"] = "tuSkip";
      };
      [4] = {
         ["y"] = -394.39160333787;
         ["x"] = 356.40366885942;
         ["template"] = "MapLinkPinTemplate";
         ["weeks"] = {
            [1] = true;
            [10] = true;
            [4] = true;
            [7] = true;
         };
         ["difficulty"] = 10;
         ["text"] = string.format(L["underrotVoidNote"],"\n");
         ["season"] = 3;
         ["type"] = "generalNote";
      };
      [8] = {
         ["npcId"] = 161124;
         ["type"] = "nyalothaSpire";
         ["index"] = 3;
         ["y"] = -259.17035648262;
         ["x"] = 633.47460185582;
         ["tooltipText"] = L["Brutal Spire of Ny'alotha"];
         ["weeks"] = {
            [1] = true;
            [2] = true;
            [3] = true;
            [4] = true;
            [5] = true;
            [6] = true;
            [7] = true;
            [8] = true;
            [9] = true;
            [10] = true;
            [11] = true;
            [12] = true;
         };
         ["template"] = "VignettePinTemplate";
      };
      [9] = {
         ["npcId"] = 161241;
         ["type"] = "nyalothaSpire";
         ["index"] = 4;
         ["y"] = -86.857596613134;
         ["x"] = 476.43070789296;
         ["tooltipText"] = L["Cursed Spire of Ny'alotha"];
         ["weeks"] = {
            [1] = true;
            [2] = true;
            [3] = true;
            [4] = true;
            [5] = true;
            [6] = true;
            [7] = true;
            [8] = true;
            [9] = true;
            [10] = true;
            [11] = true;
            [12] = true;
         };
         ["template"] = "VignettePinTemplate";
      };
      [5] = {
         ["y"] = -403.4998312742;
         ["x"] = 397.59771146364;
         ["template"] = "MapLinkPinTemplate";
         ["weeks"] = {
            [1] = true;
            [10] = true;
            [4] = true;
            [7] = true;
         };
         ["difficulty"] = 10;
         ["text"] = string.format(L["underrotVoidNote"],"\n");
         ["season"] = 3;
         ["type"] = "generalNote";
      };
      [10] = {
         ["npcId"] = 161243;
         ["type"] = "nyalothaSpire";
         ["index"] = 5;
         ["y"] = -424.66002059941;
         ["x"] = 420.66398356862;
         ["tooltipText"] = L["Entropic Spire of Ny'alotha"];
         ["weeks"] = {
            [11] = true;
            [7] = true;
            [8] = true;
            [3] = true;
            [12] = true;
            [4] = true;
         };
         ["template"] = "VignettePinTemplate";
      };
      [11] = {
         ["npcId"] = 161244;
         ["type"] = "nyalothaSpire";
         ["index"] = 6;
         ["y"] = -224.46022867992;
         ["x"] = 387.98452582283;
         ["tooltipText"] = L["Defiled Spire of Ny'alotha"];
         ["weeks"] = {
            [11] = true;
            [7] = true;
            [8] = true;
            [3] = true;
            [12] = true;
            [4] = true;
         };
         ["template"] = "VignettePinTemplate";
      };
      [6] = {
         ["npcId"] = 161244;
         ["type"] = "nyalothaSpire";
         ["index"] = 1;
         ["y"] = -424.36083618939;
         ["x"] = 420.96318081863;
         ["tooltipText"] = L["Defiled Spire of Ny'alotha"];
         ["weeks"] = {
            [1] = true;
            [2] = true;
            [5] = true;
            [6] = true;
            [9] = true;
            [10] = true;
         };
         ["template"] = "VignettePinTemplate";
      };
      [3] = {
         ["y"] = -345.39869283311;
         ["x"] = 392.23609464769;
         ["template"] = "MapLinkPinTemplate";
         ["scale"] = 2;
         ["text"] = L["underrotMatronNote"];
         ["type"] = "generalNote";
      };
   };
   [2] = {
      [1] = {
         ["y"] = -436.99827826023;
         ["x"] = 612.99994620309;
         ["template"] = "MapLinkPinTemplate";
         ["target"] = 1;
         ["connectionIndex"] = 1;
         ["direction"] = 2;
         ["type"] = "mapLink";
      };
   };
};

MDT.dungeonEnemies[dungeonIndex] = {
   [1] = {
      ["clones"] = {
         [1] = {
            ["y"] = -449.90069273655;
            ["x"] = 370.64280576381;
            ["g"] = 1;
            ["sublevel"] = 1;
         };
         [2] = {
            ["sublevel"] = 1;
            ["x"] = 363.99194057567;
            ["infested"] = {
               [1] = true;
            };
            ["g"] = 1;
            ["y"] = -458.07261013898;
         };
         [4] = {
            ["y"] = -453.07261664973;
            ["x"] = 363.33979769859;
            ["g"] = 1;
            ["sublevel"] = 1;
         };
         [8] = {
            ["y"] = -422.92203845995;
            ["x"] = 405.78683361279;
            ["g"] = 2;
            ["sublevel"] = 1;
         };
         [16] = {
            ["y"] = -312.6188397265;
            ["x"] = 496.53070684994;
            ["g"] = 8;
            ["sublevel"] = 1;
         };
         [17] = {
            ["y"] = -316.64577680595;
            ["x"] = 482.99645667638;
            ["g"] = 8;
            ["sublevel"] = 1;
         };
         [9] = {
            ["y"] = -429.13094412709;
            ["x"] = 402.26619386722;
            ["g"] = 2;
            ["sublevel"] = 1;
         };
         [5] = {
            ["y"] = -448.94217338137;
            ["x"] = 365.2963082356;
            ["g"] = 1;
            ["sublevel"] = 1;
         };
         [10] = {
            ["y"] = -422.66751586103;
            ["x"] = 410.65425613175;
            ["g"] = 2;
            ["sublevel"] = 1;
         };
         [11] = {
            ["y"] = -323.73576351699;
            ["x"] = 481.5307066772;
            ["g"] = 8;
            ["sublevel"] = 1;
         };
         [3] = {
            ["y"] = -451.55089658395;
            ["x"] = 373.55718096043;
            ["g"] = 1;
            ["sublevel"] = 1;
         };
         [6] = {
            ["sublevel"] = 1;
            ["x"] = 415.5430014203;
            ["infested"] = {
               [1] = true;
            };
            ["g"] = 2;
            ["y"] = -431.87750649299;
         };
         [12] = {
            ["sublevel"] = 1;
            ["x"] = 486.96222094883;
            ["infested"] = {
               [1] = true;
            };
            ["g"] = 8;
            ["y"] = -327.51787082578;
         };
         [13] = {
            ["y"] = -325.40344036954;
            ["x"] = 492.51297681006;
            ["g"] = 8;
            ["sublevel"] = 1;
         };
         [7] = {
            ["y"] = -426.44800923224;
            ["x"] = 414.09017727963;
            ["g"] = 2;
            ["sublevel"] = 1;
         };
         [14] = {
            ["y"] = -321.10414012251;
            ["x"] = 496.48786867348;
            ["g"] = 8;
            ["sublevel"] = 1;
         };
         [15] = {
            ["y"] = -312.76268519053;
            ["x"] = 487.28345715297;
            ["g"] = 8;
            ["sublevel"] = 1;
         };
      };
      ["reaping"] = 148716;
      ["scale"] = 0.6;
      ["spells"] = {
         [277242] = {};
         [265533] = {};
         [209859] = {};
         [278637] = {};
         [277564] = {};
      };
      ["characteristics"] = {
         ["Taunt"] = true;
         ["Incapacitate"] = true;
         ["Sap"] = true;
         ["Root"] = true;
         ["Stun"] = true;
         ["Slow"] = true;
         ["Polymorph"] = true;
         ["Silence"] = true;
      };
      ["name"] = "Underrot Tick";
      ["health"] = 153699;
      ["displayId"] = 81808;
      ["creatureType"] = "Beast";
      ["level"] = 120;
      ["count"] = 1;
      ["id"] = 131402;
   };
   [2] = {
      ["clones"] = {
         [2] = {
            ["sublevel"] = 1;
            ["x"] = 350.86879470425;
            ["patrol"] = {
               [6] = {
                  ["y"] = -363.05104010579;
                  ["x"] = 354.81866684247;
               };
               [2] = {
                  ["y"] = -387.3988553273;
                  ["x"] = 351.55779106899;
               };
               [8] = {
                  ["y"] = -363.05104010579;
                  ["x"] = 354.81866684247;
               };
               [3] = {
                  ["y"] = -403.70322486526;
                  ["x"] = 358.07954261595;
               };
               [1] = {
                  ["y"] = -376.29160819228;
                  ["x"] = 350.86879470425;
               };
               [4] = {
                  ["y"] = -387.3988553273;
                  ["x"] = 351.55779106899;
               };
               [5] = {
                  ["y"] = -376.29160819228;
                  ["x"] = 350.86879470425;
               };
               [7] = {
                  ["y"] = -346.9641020916;
                  ["x"] = 358.5143310281;
               };
            };
            ["infested"] = {
               [3] = true;
            };
            ["g"] = 4;
            ["y"] = -376.29160819228;
            ["patrolFacing"] = 3.3125;
            ["patrolFacing2"] = 6;
         };
         [3] = {
            ["y"] = -392.0358962018;
            ["x"] = 415.53700733062;
            ["patrol"] = {
               [6] = {
                  ["y"] = -381.1268013008;
                  ["x"] = 423.35516782103;
               };
               [2] = {
                  ["y"] = -399.30861833301;
                  ["x"] = 405.90062534277;
               };
               [8] = {
                  ["y"] = -381.1268013008;
                  ["x"] = 423.35516782103;
               };
               [3] = {
                  ["y"] = -409.49043087727;
                  ["x"] = 398.62791101435;
               };
               [1] = {
                  ["y"] = -392.0358962018;
                  ["x"] = 415.53700733062;
               };
               [4] = {
                  ["y"] = -399.30861833301;
                  ["x"] = 405.90062534277;
               };
               [5] = {
                  ["y"] = -392.0358962018;
                  ["x"] = 415.53700733062;
               };
               [7] = {
                  ["y"] = -368.2177111299;
                  ["x"] = 423.53698841021;
               };
            };
            ["sublevel"] = 1;
            ["patrolFacing"] = 2.3125;
            ["g"] = 5;
            ["patrolFacing2"] = 5.5625;
         };
         [1] = {
            ["sublevel"] = 1;
            ["x"] = 382.3194447352;
            ["patrol"] = {
               [1] = {
                  ["y"] = -447.66315233654;
                  ["x"] = 382.31104519999;
               };
               [2] = {
                  ["y"] = -428.27879686026;
                  ["x"] = 382.25436229783;
               };
               [3] = {
                  ["y"] = -467.66315074333;
                  ["x"] = 382.07850390625;
               };
            };
            ["infested"] = {
               [3] = true;
            };
            ["y"] = -441.01615485221;
            ["patrolFacing"] = 3.2;
            ["patrolFacing2"] = 0;
         };
         [4] = {
            ["sublevel"] = 1;
            ["x"] = 366.02145727825;
            ["infested"] = {
               [3] = true;
            };
            ["g"] = 7;
            ["y"] = -339.68472871904;
         };
         [5] = {
            ["y"] = -340.10300405995;
            ["x"] = 347.2542533054;
            ["g"] = 7;
            ["sublevel"] = 1;
         };
      };
      ["reaping"] = 148894;
      ["scale"] = 1.2;
      ["spells"] = {
         [265016] = {};
         [265081] = {};
         [277564] = {};
         [209859] = {};
         [265019] = {};
      };
      ["stealthDetect"] = true;
      ["characteristics"] = {
         ["Taunt"] = true;
      };
      ["name"] = "Chosen Blood Matron";
      ["health"] = 1229592;
      ["displayId"] = 85816;
      ["creatureType"] = "Humanoid";
      ["level"] = 121;
      ["count"] = 6;
      ["id"] = 131436;
   };
   [4] = {
      ["clones"] = {
         [7] = {
            ["y"] = -328.4180805232;
            ["x"] = 348.56327830144;
            ["g"] = 7;
            ["sublevel"] = 1;
         };
         [1] = {
            ["y"] = -409.14315428266;
            ["x"] = 381.32974943995;
            ["g"] = 3;
            ["sublevel"] = 1;
         };
         [2] = {
            ["sublevel"] = 1;
            ["x"] = 390.34547561205;
            ["y"] = -414.31101266192;
            ["g"] = 3;
            ["infested"] = {
               [2] = true;
            };
         };
         [4] = {
            ["y"] = -368.75518710096;
            ["x"] = 358.58705412942;
            ["g"] = 4;
            ["sublevel"] = 1;
         };
         [8] = {
            ["sublevel"] = 1;
            ["x"] = 355.94031219454;
            ["infested"] = {
               [2] = true;
            };
            ["g"] = 7;
            ["y"] = -342.35250054614;
         };
         [9] = {
            ["y"] = -388.93505246018;
            ["x"] = 424.92267872801;
            ["g"] = 5;
            ["sublevel"] = 1;
         };
         [5] = {
            ["sublevel"] = 1;
            ["x"] = 416.9093024448;
            ["y"] = -348.4769331326;
            ["g"] = 6;
            ["infested"] = {
               [2] = true;
            };
         };
         [3] = {
            ["y"] = -416.74374786039;
            ["x"] = 374.20057382443;
            ["g"] = 3;
            ["sublevel"] = 1;
         };
         [6] = {
            ["y"] = -361.59168428637;
            ["x"] = 425.43387838297;
            ["g"] = 6;
            ["sublevel"] = 1;
         };
      };
      ["reaping"] = 148716;
      ["id"] = 133663;
      ["spells"] = {
         [265377] = {};
         [209859] = {};
         [265376] = {};
         [277242] = {};
         [277564] = {};
      };
      ["characteristics"] = {
         ["Taunt"] = true;
         ["Incapacitate"] = true;
         ["Root"] = true;
         ["Disorient"] = true;
         ["Sap"] = true;
         ["Fear"] = true;
         ["Silence"] = true;
         ["Slow"] = true;
         ["Stun"] = true;
         ["Imprison"] = true;
      };
      ["count"] = 4;
      ["name"] = "Fanatical Headhunter";
      ["displayId"] = 79499;
      ["creatureType"] = "Humanoid";
      ["level"] = 120;
      ["health"] = 768495;
      ["scale"] = 1;
   };
   [8] = {
      ["clones"] = {
         [13] = {
            ["y"] = -347.39662148569;
            ["x"] = 566.37900188337;
            ["sublevel"] = 1;
            ["teeming"] = true;
         };
         [7] = {
            ["y"] = -284.22075766383;
            ["x"] = 596.39462167156;
            ["infested"] = {
               [1] = true;
            };
            ["sublevel"] = 1;
         };
         [1] = {
            ["sublevel"] = 1;
            ["x"] = 523.18578069845;
            ["infested"] = {
               [2] = true;
               [3] = true;
            };
            ["g"] = 10;
            ["y"] = -333.57327365272;
         };
         [2] = {
            ["y"] = -323.08386530497;
            ["x"] = 527.02474119105;
            ["g"] = 10;
            ["sublevel"] = 1;
         };
         [4] = {
            ["y"] = -336.70489781735;
            ["x"] = 573.13056107295;
            ["sublevel"] = 1;
            ["infested"] = {};
         };
         [8] = {
            ["y"] = -281.78831572917;
            ["x"] = 608.82703565597;
            ["sublevel"] = 1;
         };
         [14] = {
            ["y"] = -321.64660783389;
            ["x"] = 574.37900216649;
            ["sublevel"] = 1;
            ["teeming"] = true;
         };
         [9] = {
            ["y"] = -310.7423212606;
            ["x"] = 571.93991984745;
            ["sublevel"] = 1;
            ["infested"] = {
               [2] = true;
            };
         };
         [5] = {
            ["y"] = -322.62505808645;
            ["x"] = 612.07546210247;
            ["infested"] = {
               [3] = true;
            };
            ["sublevel"] = 1;
         };
         [10] = {
            ["y"] = -320.37755587264;
            ["x"] = 622.40834039034;
            ["sublevel"] = 1;
         };
         [11] = {
            ["y"] = -346.06057702553;
            ["x"] = 486.57967697221;
            ["teeming"] = true;
            ["g"] = 9;
            ["sublevel"] = 1;
         };
         [3] = {
            ["y"] = -337.33934595123;
            ["x"] = 533.72728795839;
            ["g"] = 10;
            ["sublevel"] = 1;
         };
         [6] = {
            ["y"] = -301.45102110472;
            ["x"] = 628.8910983104;
            ["sublevel"] = 1;
         };
         [12] = {
            ["y"] = -362.10709399003;
            ["x"] = 498.90526376846;
            ["teeming"] = true;
            ["g"] = 9;
            ["sublevel"] = 1;
         };
         [15] = {
            ["y"] = -284.50740989854;
            ["x"] = 630.47673737216;
            ["sublevel"] = 1;
            ["teeming"] = true;
         };
      };
      ["reaping"] = 148716;
      ["id"] = 133852;
      ["spells"] = {
         [277242] = {};
         [265668] = {};
         [277564] = {};
         [265665] = {};
         [209859] = {};
      };
      ["characteristics"] = {
         ["Taunt"] = true;
         ["Incapacitate"] = true;
         ["Root"] = true;
         ["Banish"] = true;
         ["Disorient"] = true;
         ["Silence"] = true;
         ["Slow"] = true;
         ["Stun"] = true;
         ["Fear"] = true;
      };
      ["health"] = 768495;
      ["count"] = 4;
      ["displayId"] = 83311;
      ["creatureType"] = "Aberration";
      ["level"] = 120;
      ["name"] = "Living Rot";
      ["scale"] = 1;
   };
   [16] = {
      ["clones"] = {
         [1] = {
            ["y"] = -299.99401008897;
            ["x"] = 606.00182475336;
            ["sublevel"] = 1;
         };
      };
      ["characteristics"] = {
         ["Taunt"] = true;
      };
      ["id"] = 131817;
      ["spells"] = {
         [260333] = {};
         [260334] = {};
         [260312] = {};
         [260793] = {};
         [260292] = {};
      };
      ["isBoss"] = true;
      ["encounterID"] = 2131;
      ["instanceID"] = 1022;
      ["count"] = 0;
      ["name"] = "Cragmaw the Infested";
      ["displayId"] = 78855;
      ["creatureType"] = "Beast";
      ["level"] = 122;
      ["health"] = 5379465;
      ["scale"] = 1;
   };
   [17] = {
      ["clones"] = {
         [1] = {
            ["y"] = -159.22605219978;
            ["x"] = 539.77082858281;
            ["sublevel"] = 1;
         };
      };
      ["id"] = 131383;
      ["characteristics"] = {
         ["Taunt"] = true;
      };
      ["spells"] = {
         [272457] = {};
         [259718] = {};
         [274213] = {};
         [259720] = {};
         [277732] = {};
         [259732] = {};
         [259830] = {};
      };
      ["isBoss"] = true;
      ["encounterID"] = 2130;
      ["instanceID"] = 1022;
      ["name"] = "Sporecaller Zancha";
      ["health"] = 5379465;
      ["displayId"] = 81977;
      ["creatureType"] = "Undead";
      ["level"] = 122;
      ["count"] = 0;
      ["scale"] = 1;
   };
   [9] = {
      ["clones"] = {
         [7] = {
            ["y"] = -309.25696482741;
            ["x"] = 623.31856852381;
            ["infested"] = {
               [1] = true;
            };
            ["sublevel"] = 1;
         };
         [1] = {
            ["y"] = -373.3954653827;
            ["x"] = 517.66271587277;
            ["g"] = 11;
            ["sublevel"] = 1;
         };
         [2] = {
            ["y"] = -370.39547868757;
            ["x"] = 521.16272001995;
            ["patrol"] = {
               [1] = {
                  ["y"] = -370.39547868757;
                  ["x"] = 521.16272001995;
               };
               [2] = {
                  ["y"] = -343.23138023097;
                  ["x"] = 516.07104697207;
               };
               [4] = {
                  ["y"] = -375.39548781221;
                  ["x"] = 545.4127434539;
               };
               [3] = {
                  ["y"] = -370.39547868757;
                  ["x"] = 521.16272001995;
               };
            };
            ["sublevel"] = 1;
            ["g"] = 11;
            ["patrolFacing"] = 0.1875;
            ["patrolFacing2"] = 4.5625;
         };
         [4] = {
            ["sublevel"] = 1;
            ["x"] = 568.2742218428;
            ["infested"] = {
               [1] = true;
            };
            ["g"] = 12;
            ["y"] = -368.37545947995;
         };
         [8] = {
            ["y"] = -293.16659646406;
            ["x"] = 586.84431622599;
            ["sublevel"] = 1;
            ["infested"] = {
               [2] = true;
            };
         };
         [9] = {
            ["y"] = -320.77884926726;
            ["x"] = 565.38702120497;
            ["infested"] = {
               [3] = true;
            };
            ["sublevel"] = 1;
         };
         [5] = {
            ["y"] = -361.17546583411;
            ["x"] = 566.27422932988;
            ["g"] = 12;
            ["sublevel"] = 1;
         };
         [3] = {
            ["y"] = -369.63059158545;
            ["x"] = 560.61943742653;
            ["g"] = 12;
            ["sublevel"] = 1;
         };
         [6] = {
            ["y"] = -337.62596334812;
            ["x"] = 587.40121346449;
            ["sublevel"] = 1;
         };
      };
      ["reaping"] = 148716;
      ["id"] = 133870;
      ["spells"] = {
         [277247] = {};
         [277242] = {};
         [278961] = {};
         [277564] = {};
         [205276] = {};
         [209859] = {};
      };
      ["characteristics"] = {
         ["Taunt"] = true;
         ["Incapacitate"] = true;
         ["Root"] = true;
         ["Banish"] = true;
         ["Disorient"] = true;
         ["Stun"] = true;
         ["Slow"] = true;
         ["Silence"] = true;
         ["Fear"] = true;
      };
      ["health"] = 768495;
      ["count"] = 4;
      ["displayId"] = 80467;
      ["creatureType"] = "Elemental";
      ["level"] = 120;
      ["name"] = "Diseased Lasher";
      ["scale"] = 1;
   };
   [18] = {
      ["clones"] = {
         [1] = {
            ["y"] = -232.39348563361;
            ["x"] = 295.11071231186;
            ["sublevel"] = 2;
         };
      };
      ["id"] = 133007;
      ["characteristics"] = {
         ["Taunt"] = true;
      };
      ["spells"] = {
         [269185] = {};
         [269843] = {};
         [269301] = {};
      };
      ["isBoss"] = true;
      ["encounterID"] = 2158;
      ["instanceID"] = 1022;
      ["scale"] = 1;
      ["name"] = "Unbound Abomination";
      ["displayId"] = 86632;
      ["creatureType"] = "Humanoid";
      ["level"] = 120;
      ["count"] = 0;
      ["health"] = 5994261;
   };
   [5] = {
      ["clones"] = {
         [2] = {
            ["y"] = -365.80486760229;
            ["x"] = 349.26402126041;
            ["g"] = 4;
            ["sublevel"] = 1;
         };
         [3] = {
            ["y"] = -382.20467315985;
            ["x"] = 417.16040095489;
            ["g"] = 5;
            ["sublevel"] = 1;
         };
         [1] = {
            ["y"] = -423.7813456387;
            ["x"] = 383.11229920208;
            ["g"] = 3;
            ["sublevel"] = 1;
         };
         [4] = {
            ["y"] = -324.71077539224;
            ["x"] = 361.80338691413;
            ["g"] = 7;
            ["sublevel"] = 1;
         };
         [5] = {
            ["y"] = -347.13430448265;
            ["x"] = 431.43196300627;
            ["g"] = 6;
            ["sublevel"] = 1;
         };
      };
      ["reaping"] = 148893;
      ["id"] = 131492;
      ["spells"] = {
         [277564] = {};
         [209859] = {};
         [265089] = {};
         [265091] = {};
         [265084] = {};
      };
      ["characteristics"] = {
         ["Taunt"] = true;
         ["Incapacitate"] = true;
         ["Root"] = true;
         ["Polymorph"] = true;
         ["Disorient"] = true;
         ["Sap"] = true;
         ["Silence"] = true;
         ["Slow"] = true;
         ["Stun"] = true;
         ["Fear"] = true;
      };
      ["count"] = 4;
      ["name"] = "Devout Blood Priest";
      ["displayId"] = 75861;
      ["creatureType"] = "Humanoid";
      ["level"] = 120;
      ["health"] = 768495;
      ["scale"] = 1;
   };
   [10] = {
      ["clones"] = {
         [7] = {
            ["y"] = -156.11297274834;
            ["x"] = 611.64626646635;
            ["g"] = 17;
            ["sublevel"] = 1;
         };
         [1] = {
            ["sublevel"] = 1;
            ["x"] = 645.60207084501;
            ["y"] = -241.30133038968;
            ["g"] = 13;
            ["infested"] = {
               [2] = true;
            };
         };
         [2] = {
            ["y"] = -234.8148494939;
            ["x"] = 649.11565478892;
            ["g"] = 13;
            ["sublevel"] = 1;
         };
         [4] = {
            ["y"] = -145.8955756746;
            ["x"] = 624.03758694203;
            ["g"] = 17;
            ["sublevel"] = 1;
         };
         [8] = {
            ["y"] = -131.76877726949;
            ["x"] = 442.7522220752;
            ["g"] = 19;
            ["sublevel"] = 1;
         };
         [9] = {
            ["y"] = -131.19430329866;
            ["x"] = 422.98743948227;
            ["g"] = 19;
            ["sublevel"] = 1;
         };
         [5] = {
            ["y"] = -157.16170520379;
            ["x"] = 622.84125691368;
            ["g"] = 17;
            ["sublevel"] = 1;
         };
         [10] = {
            ["y"] = -118.08521132448;
            ["x"] = 424.28629580384;
            ["g"] = 19;
            ["sublevel"] = 1;
         };
         [3] = {
            ["y"] = -230.49051343173;
            ["x"] = 643.71022311246;
            ["g"] = 13;
            ["sublevel"] = 1;
         };
         [6] = {
            ["y"] = -145.24341171521;
            ["x"] = 613.1680259089;
            ["g"] = 17;
            ["sublevel"] = 1;
         };
         [11] = {
            ["y"] = -118.64775945871;
            ["x"] = 441.9060624463;
            ["g"] = 19;
            ["sublevel"] = 1;
         };
      };
      ["reaping"] = 148716;
      ["scale"] = 1;
      ["spells"] = {
         [266201] = {};
         [277564] = {};
         [209859] = {};
         [205276] = {};
         [277242] = {};
      };
      ["characteristics"] = {
         ["Taunt"] = true;
         ["Incapacitate"] = true;
         ["Shackle Undead"] = true;
         ["Root"] = true;
         ["Control Undead"] = true;
         ["Disorient"] = true;
         ["Silence"] = true;
         ["Slow"] = true;
         ["Stun"] = true;
      };
      ["name"] = "Reanimated Guardian";
      ["health"] = 768495;
      ["displayId"] = 88121;
      ["creatureType"] = "Undead";
      ["level"] = 120;
      ["count"] = 4;
      ["id"] = 133836;
   };
   [20] = {
      ["clones"] = {
         [1] = {
            ["y"] = -427.39894490777;
            ["x"] = 408.74613887614;
            ["week"] = {
               [1] = true;
               [10] = true;
               [7] = true;
               [4] = true;
            };
            ["g"] = 2;
            ["sublevel"] = 1;
         };
         [2] = {
            ["y"] = -361.9020905497;
            ["x"] = 557.98486377111;
            ["week"] = {
               [6] = true;
               [7] = true;
               [12] = true;
               [3] = true;
               [1] = true;
               [4] = true;
               [9] = true;
               [10] = true;
            };
            ["g"] = 12;
            ["sublevel"] = 1;
         };
         [4] = {
            ["y"] = -200.72134442214;
            ["x"] = 435.11300300949;
            ["sublevel"] = 1;
            ["g"] = 26;
            ["week"] = {
               [1] = true;
               [10] = true;
               [7] = true;
               [4] = true;
            };
         };
         [8] = {
            ["y"] = -177.45573126957;
            ["x"] = 386.04063302972;
            ["sublevel"] = 1;
            ["week"] = {
               [8] = true;
               [2] = true;
               [5] = true;
               [11] = true;
            };
         };
         [16] = {
            ["y"] = -113.4147842878;
            ["x"] = 333.2098817959;
            ["sublevel"] = 1;
            ["g"] = 20;
            ["week"] = {
               [3] = true;
               [6] = true;
               [9] = true;
               [12] = true;
            };
         };
         [17] = {
            ["y"] = -133.57848650543;
            ["x"] = 433.48281104223;
            ["sublevel"] = 1;
            ["g"] = 19;
            ["week"] = {
               [3] = true;
               [6] = true;
               [9] = true;
               [12] = true;
            };
         };
         [9] = {
            ["y"] = -452.49901076276;
            ["x"] = 357.52712013347;
            ["week"] = {
               [3] = true;
               [6] = true;
               [9] = true;
               [12] = true;
            };
            ["g"] = 1;
            ["sublevel"] = 1;
         };
         [5] = {
            ["y"] = -455.61709236722;
            ["x"] = 368.69309040668;
            ["sublevel"] = 1;
            ["g"] = 1;
            ["week"] = {
               [8] = true;
               [2] = true;
               [5] = true;
               [11] = true;
            };
         };
         [10] = {
            ["y"] = -415.87741784047;
            ["x"] = 382.1891891004;
            ["week"] = {
               [3] = true;
               [6] = true;
               [9] = true;
               [12] = true;
            };
            ["g"] = 3;
            ["sublevel"] = 1;
         };
         [11] = {
            ["y"] = -321.31099968234;
            ["x"] = 486.90885597211;
            ["week"] = {
               [3] = true;
               [6] = true;
               [9] = true;
               [12] = true;
            };
            ["g"] = 8;
            ["sublevel"] = 1;
         };
         [3] = {
            ["y"] = -158.53555003455;
            ["x"] = 491.92748146995;
            ["sublevel"] = 1;
            ["g"] = 25;
            ["week"] = {
               [1] = true;
               [10] = true;
               [7] = true;
               [4] = true;
            };
         };
         [6] = {
            ["y"] = -312.66768296841;
            ["x"] = 633.62748311901;
            ["sublevel"] = 1;
            ["g"] = 30;
            ["week"] = {
               [8] = true;
               [2] = true;
               [5] = true;
               [11] = true;
            };
         };
         [12] = {
            ["y"] = -275.57834436816;
            ["x"] = 601.26786742116;
            ["sublevel"] = 1;
            ["week"] = {
               [3] = true;
               [6] = true;
               [9] = true;
               [12] = true;
            };
         };
         [13] = {
            ["y"] = -149.83630659762;
            ["x"] = 608.21387584272;
            ["sublevel"] = 1;
            ["g"] = 17;
            ["week"] = {
               [3] = true;
               [6] = true;
               [9] = true;
               [12] = true;
            };
         };
         [7] = {
            ["y"] = -192.91018238043;
            ["x"] = 648.99715702053;
            ["sublevel"] = 1;
            ["week"] = {
               [8] = true;
               [2] = true;
               [5] = true;
               [11] = true;
            };
         };
         [14] = {
            ["y"] = -161.33285010457;
            ["x"] = 561.02036702406;
            ["sublevel"] = 1;
            ["g"] = 16;
            ["week"] = {
               [3] = true;
               [6] = true;
               [9] = true;
               [12] = true;
            };
         };
         [15] = {
            ["y"] = -211.66005632297;
            ["x"] = 393.3870767396;
            ["sublevel"] = 1;
            ["g"] = 32;
            ["week"] = {
               [3] = true;
               [6] = true;
               [9] = true;
               [12] = true;
            };
         };
      };
      ["scale"] = 1;
      ["spells"] = {
         [303632] = {};
         [302415] = {};
         [290027] = {};
      };
      ["characteristics"] = {
         ["Taunt"] = true;
      };
      ["id"] = 155432;
      ["name"] = "Enchanted Emissary";
      ["ignoreFortified"] = true;
      ["health"] = 15369884;
      ["displayId"] = 39391;
      ["creatureType"] = "Humanoid";
      ["level"] = 121;
      ["count"] = 0;
      ["iconTexture"] = 135735;
   };
   [21] = {
      ["clones"] = {
         [1] = {
            ["y"] = -233.31928491657;
            ["x"] = 395.47829882504;
            ["week"] = {
               [1] = true;
               [2] = true;
               [5] = true;
               [6] = true;
               [9] = true;
               [10] = true;
            };
            ["sublevel"] = 1;
         };
         [2] = {
            ["y"] = -436.0634908767;
            ["x"] = 425.016822353;
            ["week"] = {
               [11] = true;
               [7] = true;
               [8] = true;
               [3] = true;
               [12] = true;
               [4] = true;
            };
            ["sublevel"] = 1;
         };
      };
      ["scale"] = 1.4;
      ["characteristics"] = {
         ["Taunt"] = true;
      };
      ["spells"] = {
         [314483] = {};
         [314477] = {};
         [314397] = {};
         [314531] = {};
      };
      ["stealthDetect"] = true;
      ["count"] = 4;
      ["level"] = 122;
      ["teemingCount"] = 6;
      ["health"] = 2151786;
      ["displayId"] = 90742;
      ["creatureType"] = "Aberration";
      ["corrupted"] = true;
      ["name"] = "Samh'rek, Beckoner of Chaos";
      ["id"] = 161243;
   };
   [11] = {
      ["clones"] = {
         [2] = {
            ["y"] = -183.63313096802;
            ["x"] = 607.72376013483;
            ["g"] = 15;
            ["sublevel"] = 1;
         };
         [3] = {
            ["y"] = -151.27922117783;
            ["x"] = 617.92152885212;
            ["patrol"] = {
               [6] = {
                  ["y"] = -166.20148715598;
                  ["x"] = 633.41512178511;
               };
               [2] = {
                  ["y"] = -149.44734706819;
                  ["x"] = 606.97108790477;
               };
               [8] = {
                  ["y"] = -152.85064584786;
                  ["x"] = 627.49293588982;
               };
               [3] = {
                  ["y"] = -151.27922117783;
                  ["x"] = 617.92152885212;
               };
               [1] = {
                  ["y"] = -151.27922117783;
                  ["x"] = 617.92152885212;
               };
               [4] = {
                  ["y"] = -152.85064584786;
                  ["x"] = 627.49293588982;
               };
               [5] = {
                  ["y"] = -157.72047226583;
                  ["x"] = 632.5290233868;
               };
               [7] = {
                  ["y"] = -157.72047226583;
                  ["x"] = 632.5290233868;
               };
            };
            ["infested"] = {
               [2] = true;
            };
            ["g"] = 17;
            ["sublevel"] = 1;
            ["patrolFacing"] = 1.4375;
            ["patrolFacing2"] = 4.625;
         };
         [1] = {
            ["y"] = -224.54455714561;
            ["x"] = 645.87236794606;
            ["g"] = 13;
            ["sublevel"] = 1;
         };
         [4] = {
            ["sublevel"] = 1;
            ["x"] = 432.80784049237;
            ["y"] = -125.07190043712;
            ["g"] = 19;
            ["infested"] = {
               [2] = true;
            };
         };
         [5] = {
            ["y"] = -146.82030229432;
            ["x"] = 568.11367614036;
            ["teeming"] = true;
            ["g"] = 16;
            ["sublevel"] = 1;
         };
      };
      ["reaping"] = 148893;
      ["scale"] = 1;
      ["spells"] = {
         [277564] = {};
         [272183] = {};
         [209859] = {};
         [266265] = {};
         [277242] = {};
         [266209] = {};
      };
      ["characteristics"] = {
         ["Taunt"] = true;
         ["Incapacitate"] = true;
         ["Shackle Undead"] = true;
         ["Root"] = true;
         ["Control Undead"] = true;
         ["Disorient"] = true;
         ["Silence"] = true;
         ["Slow"] = true;
         ["Stun"] = true;
      };
      ["name"] = "Fallen Deathspeaker";
      ["health"] = 768495;
      ["displayId"] = 85815;
      ["creatureType"] = "Undead";
      ["level"] = 120;
      ["count"] = 4;
      ["id"] = 134284;
   };
   [22] = {
      ["clones"] = {
         [1] = {
            ["y"] = -265.95856149814;
            ["x"] = 623.61309211511;
            ["week"] = {
               [1] = true;
               [2] = true;
               [3] = true;
               [4] = true;
               [5] = true;
               [6] = true;
               [7] = true;
               [8] = true;
               [9] = true;
               [10] = true;
               [11] = true;
               [12] = true;
            };
            ["sublevel"] = 1;
         };
      };
      ["id"] = 161124;
      ["characteristics"] = {
         ["Taunt"] = true;
      };
      ["spells"] = {
         [314308] = {};
         [314387] = {};
         [314397] = {};
         [314309] = {};
      };
      ["stealthDetect"] = true;
      ["scale"] = 1.4;
      ["corrupted"] = true;
      ["teemingCount"] = 6;
      ["count"] = 4;
      ["displayId"] = 89415;
      ["creatureType"] = "Aberration";
      ["level"] = 122;
      ["health"] = 2151786;
      ["name"] = "Urg'roth, Breaker of Heroes";
   };
   [3] = {
      ["clones"] = {
         [7] = {
            ["y"] = -334.26792864844;
            ["x"] = 634.45600597075;
            ["infested"] = {
               [3] = true;
            };
            ["sublevel"] = 1;
         };
         [1] = {
            ["y"] = -451.41245724274;
            ["x"] = 396.85465893303;
            ["sublevel"] = 1;
            ["infested"] = {
               [1] = true;
               [2] = true;
            };
         };
         [2] = {
            ["sublevel"] = 1;
            ["x"] = 492.17016334504;
            ["y"] = -316.96348077972;
            ["g"] = 8;
            ["infested"] = {
               [2] = true;
            };
         };
         [4] = {
            ["sublevel"] = 1;
            ["x"] = 494.48665981743;
            ["teeming"] = true;
            ["g"] = 9;
            ["y"] = -367.92105548692;
         };
         [8] = {
            ["y"] = -269.66133435329;
            ["x"] = 592.16820330856;
            ["infested"] = {
               [3] = true;
            };
            ["sublevel"] = 1;
         };
         [9] = {
            ["y"] = -318.47927697899;
            ["x"] = 478.52875805802;
            ["teeming"] = true;
            ["g"] = 8;
            ["sublevel"] = 1;
         };
         [5] = {
            ["sublevel"] = 1;
            ["x"] = 491.92850598006;
            ["teeming"] = true;
            ["g"] = 9;
            ["y"] = -353.73500859671;
         };
         [10] = {
            ["y"] = -310.80805526718;
            ["x"] = 484.00821137602;
            ["teeming"] = true;
            ["g"] = 8;
            ["sublevel"] = 1;
         };
         [3] = {
            ["sublevel"] = 1;
            ["x"] = 485.09431311832;
            ["infested"] = {
               [2] = true;
            };
            ["g"] = 9;
            ["y"] = -354.12310400385;
         };
         [6] = {
            ["y"] = -347.9042801322;
            ["x"] = 613.09227810667;
            ["infested"] = {
               [1] = true;
            };
            ["sublevel"] = 1;
         };
         [11] = {
            ["y"] = -310.6710730494;
            ["x"] = 492.50137930382;
            ["teeming"] = true;
            ["g"] = 8;
            ["sublevel"] = 1;
         };
      };
      ["reaping"] = 148716;
      ["scale"] = 1;
      ["spells"] = {
         [277242] = {};
         [265540] = {};
         [265542] = {};
         [277564] = {};
         [205276] = {};
         [209859] = {};
      };
      ["characteristics"] = {
         ["Taunt"] = true;
         ["Incapacitate"] = true;
         ["Root"] = true;
         ["Polymorph"] = true;
         ["Disorient"] = true;
         ["Sap"] = true;
         ["Fear"] = true;
         ["Silence"] = true;
         ["Slow"] = true;
         ["Stun"] = true;
         ["Imprison"] = true;
      };
      ["name"] = "Fetid Maggot";
      ["health"] = 768495;
      ["displayId"] = 88361;
      ["creatureType"] = "Beast";
      ["level"] = 120;
      ["count"] = 4;
      ["id"] = 130909;
   };
   [6] = {
      ["clones"] = {
         [1] = {
            ["y"] = -354.46074733958;
            ["x"] = 425.0233065434;
            ["g"] = 6;
            ["sublevel"] = 1;
         };
         [2] = {
            ["y"] = -334.13438008638;
            ["x"] = 355.81234173013;
            ["g"] = 7;
            ["sublevel"] = 1;
         };
      };
      ["reaping"] = 148894;
      ["scale"] = 1.4;
      ["spells"] = {
         [265625] = {};
         [277564] = {};
         [265568] = {};
         [209859] = {};
         [278755] = {};
      };
      ["characteristics"] = {
         ["Taunt"] = true;
         ["Stun"] = true;
         ["Slow"] = true;
         ["Silence"] = true;
         ["Fear"] = true;
      };
      ["name"] = "Befouled Spirit";
      ["health"] = 768495;
      ["displayId"] = 80852;
      ["creatureType"] = "Aberration";
      ["level"] = 120;
      ["count"] = 4;
      ["id"] = 133685;
   };
   [12] = {
      ["clones"] = {
         [6] = {
            ["sublevel"] = 1;
            ["x"] = 414.25685854495;
            ["patrol"] = {
               [2] = {
                  ["y"] = -219.25953413344;
                  ["x"] = 413.51571266978;
               };
               [3] = {
                  ["y"] = -219.42300735329;
                  ["x"] = 434.93085047497;
               };
               [1] = {
                  ["y"] = -208.73861920352;
                  ["x"] = 414.25685854495;
               };
               [4] = {
                  ["y"] = -192.63730119717;
                  ["x"] = 434.57370282161;
               };
               [5] = {
                  ["y"] = -197.63730703656;
                  ["x"] = 414.21653181068;
               };
            };
            ["y"] = -208.73861920352;
            ["infested"] = {
               [3] = true;
            };
         };
         [2] = {
            ["y"] = -163.42323614063;
            ["x"] = 567.50215465511;
            ["g"] = 16;
            ["sublevel"] = 1;
         };
         [3] = {
            ["sublevel"] = 1;
            ["x"] = 568.03168801446;
            ["infested"] = {
               [3] = true;
            };
            ["g"] = 16;
            ["y"] = -156.42816945495;
         };
         [1] = {
            ["y"] = -177.95130669239;
            ["x"] = 608.74648128686;
            ["patrol"] = {
               [1] = {
                  ["y"] = -177.95130669239;
                  ["x"] = 608.74648128686;
               };
               [2] = {
                  ["y"] = -179.75904973674;
                  ["x"] = 618.87727382804;
               };
               [4] = {
                  ["y"] = -172.17911671921;
                  ["x"] = 594.9274363084;
               };
               [3] = {
                  ["y"] = -177.95130669239;
                  ["x"] = 608.74648128686;
               };
            };
            ["infested"] = {
               [3] = true;
            };
            ["g"] = 15;
            ["sublevel"] = 1;
         };
         [4] = {
            ["y"] = -115.0180391337;
            ["x"] = 468.44508504921;
            ["infested"] = {
               [3] = true;
            };
            ["sublevel"] = 1;
         };
         [5] = {
            ["y"] = -207.0323690645;
            ["x"] = 386.36409846283;
            ["g"] = 32;
            ["sublevel"] = 1;
         };
      };
      ["reaping"] = 148894;
      ["scale"] = 1;
      ["spells"] = {
         [265487] = {};
         [265433] = {};
         [265468] = {};
         [209859] = {};
         [265523] = {};
         [205276] = {};
         [277564] = {};
      };
      ["characteristics"] = {
         ["Taunt"] = true;
      };
      ["name"] = "Bloodsworn Defiler";
      ["health"] = 768495;
      ["displayId"] = 79182;
      ["creatureType"] = "Undead";
      ["level"] = 120;
      ["count"] = 6;
      ["id"] = 133912;
   };
   [24] = {
      ["clones"] = {
         [1] = {
            ["y"] = -435.58449182215;
            ["x"] = 425.38122034355;
            ["week"] = {
               [1] = true;
               [2] = true;
               [5] = true;
               [6] = true;
               [9] = true;
               [10] = true;
            };
            ["sublevel"] = 1;
         };
         [2] = {
            ["y"] = -233.8088783709;
            ["x"] = 396.59348164217;
            ["week"] = {
               [11] = true;
               [7] = true;
               [8] = true;
               [3] = true;
               [12] = true;
               [4] = true;
            };
            ["sublevel"] = 1;
         };
      };
      ["id"] = 161244;
      ["characteristics"] = {
         ["Taunt"] = true;
      };
      ["spells"] = {
         [314566] = {};
         [314397] = {};
         [314565] = {};
         [314592] = {};
      };
      ["stealthDetect"] = true;
      ["scale"] = 1.4;
      ["level"] = 122;
      ["teemingCount"] = 6;
      ["name"] = "Blood of the Corruptor";
      ["displayId"] = 92229;
      ["creatureType"] = "Aberration";
      ["corrupted"] = true;
      ["count"] = 4;
      ["health"] = 2151786;
   };
   [13] = {
      ["clones"] = {
         [14] = {
            ["y"] = -143.45397434199;
            ["x"] = 433.94467067722;
            ["sublevel"] = 1;
            ["teeming"] = true;
         };
         [13] = {
            ["y"] = -230.06791722474;
            ["x"] = 412.20395918938;
            ["sublevel"] = 1;
            ["teeming"] = true;
         };
         [7] = {
            ["y"] = -136.87189004833;
            ["x"] = 392.69766631869;
            ["sublevel"] = 1;
         };
         [1] = {
            ["y"] = -174.53984242698;
            ["x"] = 587.06078000163;
            ["infested"] = {
               [1] = true;
            };
            ["sublevel"] = 1;
         };
         [2] = {
            ["y"] = -218.81297584915;
            ["x"] = 441.9240190781;
            ["g"] = 31;
            ["sublevel"] = 1;
         };
         [4] = {
            ["y"] = -215.11212197615;
            ["x"] = 400.70815960366;
            ["g"] = 32;
            ["sublevel"] = 1;
         };
         [8] = {
            ["y"] = -123.16756387727;
            ["x"] = 369.14310543743;
            ["sublevel"] = 1;
         };
         [16] = {
            ["y"] = -92.991568138069;
            ["x"] = 455.67854135627;
            ["sublevel"] = 1;
         };
         [9] = {
            ["y"] = -121.90763402295;
            ["x"] = 347.31640246703;
            ["sublevel"] = 1;
            ["infested"] = {
               [1] = true;
            };
         };
         [5] = {
            ["y"] = -177.85162217553;
            ["x"] = 393.07373940232;
            ["sublevel"] = 1;
         };
         [10] = {
            ["y"] = -101.11832338886;
            ["x"] = 479.9823215311;
            ["sublevel"] = 1;
         };
         [3] = {
            ["y"] = -193.34578110629;
            ["x"] = 420.58768832364;
            ["sublevel"] = 1;
         };
         [11] = {
            ["y"] = -127.42772698044;
            ["x"] = 479.71425216822;
            ["infested"] = {
               [1] = true;
            };
            ["sublevel"] = 1;
         };
         [6] = {
            ["y"] = -163.69658088263;
            ["x"] = 380.32819211063;
            ["sublevel"] = 1;
         };
         [12] = {
            ["y"] = -199.75077189193;
            ["x"] = 643.60731270763;
            ["infested"] = {
               [1] = true;
            };
            ["sublevel"] = 1;
         };
         [15] = {
            ["y"] = -90.806915772928;
            ["x"] = 414.90311918307;
            ["sublevel"] = 1;
         };
      };
      ["reaping"] = 148716;
      ["id"] = 138187;
      ["spells"] = {
         [272180] = {};
         [277242] = {};
         [209859] = {};
      };
      ["characteristics"] = {
         ["Taunt"] = true;
         ["Incapacitate"] = true;
         ["Root"] = true;
         ["Banish"] = true;
         ["Disorient"] = true;
         ["Silence"] = true;
         ["Slow"] = true;
         ["Stun"] = true;
         ["Fear"] = true;
      };
      ["health"] = 768495;
      ["count"] = 4;
      ["displayId"] = 84808;
      ["creatureType"] = "Aberration";
      ["level"] = 120;
      ["name"] = "Grotesque Horror";
      ["scale"] = 1;
   };
   [7] = {
      ["clones"] = {
         [1] = {
            ["y"] = -329.22598792743;
            ["x"] = 583.00118873735;
            ["sublevel"] = 1;
         };
         [2] = {
            ["y"] = -300.87543462593;
            ["x"] = 572.71040254226;
            ["infested"] = {
               [1] = true;
            };
            ["sublevel"] = 1;
         };
         [4] = {
            ["y"] = -291.84974624689;
            ["x"] = 625.89822982769;
            ["infested"] = {
               [3] = true;
            };
            ["sublevel"] = 1;
         };
         [8] = {
            ["y"] = -125.93215377974;
            ["x"] = 603.80056459396;
            ["infested"] = {
               [1] = true;
            };
            ["sublevel"] = 1;
         };
         [16] = {
            ["sublevel"] = 1;
            ["x"] = 499.13782502282;
            ["infested"] = {
               [3] = true;
            };
            ["g"] = 9;
            ["y"] = -354.8977949079;
         };
         [17] = {
            ["y"] = -362.10709399003;
            ["x"] = 490.06805586641;
            ["g"] = 9;
            ["sublevel"] = 1;
         };
         [9] = {
            ["y"] = -125.2114437859;
            ["x"] = 585.7284073527;
            ["sublevel"] = 1;
         };
         [5] = {
            ["y"] = -332.42597938132;
            ["x"] = 598.20111810256;
            ["sublevel"] = 1;
            ["infested"] = {
               [2] = true;
            };
         };
         [10] = {
            ["y"] = -120.11234688418;
            ["x"] = 564.57530028673;
            ["sublevel"] = 1;
         };
         [11] = {
            ["y"] = -98.995185352471;
            ["x"] = 567.3500126347;
            ["sublevel"] = 1;
         };
         [3] = {
            ["y"] = -284.64116574299;
            ["x"] = 619.34488294085;
            ["sublevel"] = 1;
         };
         [6] = {
            ["y"] = -100.6168287739;
            ["x"] = 587.8905741338;
            ["sublevel"] = 1;
         };
         [12] = {
            ["y"] = -114.13035292438;
            ["x"] = 580.32299887372;
            ["sublevel"] = 1;
         };
         [13] = {
            ["y"] = -110.07631396327;
            ["x"] = 595.45815189384;
            ["sublevel"] = 1;
         };
         [7] = {
            ["y"] = -115.48168469297;
            ["x"] = 613.02572240115;
            ["sublevel"] = 1;
         };
         [14] = {
            ["y"] = -100.34655487033;
            ["x"] = 610.59328046649;
            ["sublevel"] = 1;
         };
         [15] = {
            ["y"] = -122.5086901984;
            ["x"] = 630.32302025488;
            ["sublevel"] = 1;
         };
      };
      ["reaping"] = 148716;
      ["id"] = 133835;
      ["spells"] = {
         [277564] = {};
         [277242] = {};
         [266107] = {};
         [209859] = {};
         [266106] = {};
         [205276] = {};
         [266109] = {};
      };
      ["characteristics"] = {
         ["Taunt"] = true;
         ["Incapacitate"] = true;
         ["Root"] = true;
         ["Polymorph"] = true;
         ["Disorient"] = true;
         ["Sap"] = true;
         ["Silence"] = true;
         ["Slow"] = true;
         ["Stun"] = true;
         ["Fear"] = true;
      };
      ["health"] = 768495;
      ["count"] = 4;
      ["displayId"] = 76653;
      ["creatureType"] = "Beast";
      ["level"] = 120;
      ["name"] = "Feral Bloodswarmer";
      ["scale"] = 1;
   };
   [14] = {
      ["clones"] = {
         [6] = {
            ["sublevel"] = 1;
            ["x"] = 439.82355491305;
            ["patrol"] = {
               [1] = {
                  ["y"] = -91.656651667296;
                  ["x"] = 439.82355491305;
               };
               [2] = {
                  ["y"] = -92.406618836775;
                  ["x"] = 465.07359402813;
               };
               [4] = {
                  ["y"] = -91.156644944077;
                  ["x"] = 422.32355563482;
               };
               [3] = {
                  ["y"] = -91.656651667296;
                  ["x"] = 439.82355491305;
               };
            };
            ["infested"] = {
               [3] = true;
            };
            ["y"] = -91.656651667296;
         };
         [2] = {
            ["y"] = -201.82209382308;
            ["x"] = 393.92138565104;
            ["patrol"] = {
               [1] = {
                  ["y"] = -201.82209382308;
                  ["x"] = 393.92138565104;
               };
               [2] = {
                  ["y"] = -218.34382957886;
                  ["x"] = 393.26925900934;
               };
               [4] = {
                  ["y"] = -172.23998269283;
                  ["x"] = 385.79778440769;
               };
               [3] = {
                  ["y"] = -201.82209382308;
                  ["x"] = 393.92138565104;
               };
            };
            ["sublevel"] = 1;
            ["patrolFacing"] = 3.1875;
            ["patrolFacing2"] = 0.3125;
         };
         [3] = {
            ["y"] = -129.05343777445;
            ["x"] = 387.03501927343;
            ["patrol"] = {
               [1] = {
                  ["y"] = -129.05343777445;
                  ["x"] = 387.03501927343;
               };
               [2] = {
                  ["y"] = -141.63737182349;
                  ["x"] = 386.46650679788;
               };
               [4] = {
                  ["y"] = -104.50668163;
                  ["x"] = 398.35508578509;
               };
               [3] = {
                  ["y"] = -129.05343777445;
                  ["x"] = 387.03501927343;
               };
            };
            ["infested"] = {
               [3] = true;
            };
            ["sublevel"] = 1;
            ["patrolFacing"] = 3.1875;
            ["patrolFacing2"] = 5.875;
         };
         [1] = {
            ["y"] = -158.30820011498;
            ["x"] = 474.90710474325;
            ["infested"] = {
               [3] = true;
            };
            ["sublevel"] = 1;
         };
         [4] = {
            ["y"] = -102.93122586641;
            ["x"] = 332.21098676126;
            ["g"] = 20;
            ["sublevel"] = 1;
         };
         [5] = {
            ["y"] = -120.12379292823;
            ["x"] = 325.17843833773;
            ["g"] = 20;
            ["sublevel"] = 1;
         };
      };
      ["reaping"] = 148894;
      ["id"] = 138281;
      ["spells"] = {
         [277564] = {};
         [272609] = {};
         [272592] = {};
         [209859] = {};
      };
      ["characteristics"] = {
         ["Taunt"] = true;
      };
      ["count"] = 6;
      ["name"] = "Faceless Corruptor";
      ["displayId"] = 84376;
      ["creatureType"] = "Humanoid";
      ["level"] = 120;
      ["health"] = 1229592;
      ["scale"] = 1.4;
   };
   [23] = {
      ["clones"] = {
         [1] = {
            ["y"] = -96.232938384989;
            ["x"] = 468.84031302968;
            ["week"] = {
               [1] = true;
               [2] = true;
               [3] = true;
               [4] = true;
               [5] = true;
               [6] = true;
               [7] = true;
               [8] = true;
               [9] = true;
               [10] = true;
               [11] = true;
               [12] = true;
            };
            ["sublevel"] = 1;
         };
      };
      ["name"] = "Voidweaver Mal'thir";
      ["characteristics"] = {
         ["Taunt"] = true;
      };
      ["spells"] = {
         [314463] = {};
         [314411] = {};
         [314467] = {};
         [314406] = {};
         [314397] = {};
      };
      ["stealthDetect"] = true;
      ["count"] = 4;
      ["corrupted"] = true;
      ["teemingCount"] = 6;
      ["health"] = 2151786;
      ["displayId"] = 91910;
      ["creatureType"] = "Beast";
      ["level"] = 122;
      ["id"] = 161241;
      ["scale"] = 1.4;
   };
   [19] = {
      ["clones"] = {
         [13] = {
            ["y"] = -339.98291422866;
            ["x"] = 595.86827900944;
            ["sublevel"] = 1;
            ["week"] = {
               [3] = true;
               [6] = true;
               [9] = true;
               [12] = true;
            };
         };
         [7] = {
            ["y"] = -360.21906041035;
            ["x"] = 557.59062384936;
            ["sublevel"] = 1;
            ["g"] = 12;
            ["week"] = {
               [8] = true;
               [2] = true;
               [5] = true;
               [11] = true;
            };
         };
         [1] = {
            ["y"] = -321.48629642329;
            ["x"] = 486.91797993285;
            ["week"] = {
               [1] = true;
               [10] = true;
               [4] = true;
               [7] = true;
            };
            ["g"] = 8;
            ["sublevel"] = 1;
         };
         [2] = {
            ["y"] = -292.49921089787;
            ["x"] = 575.06959166829;
            ["week"] = {
               [1] = true;
               [10] = true;
               [4] = true;
               [7] = true;
            };
            ["g"] = 23;
            ["sublevel"] = 1;
         };
         [4] = {
            ["y"] = -329.65339077573;
            ["x"] = 530.24765235722;
            ["sublevel"] = 1;
            ["g"] = 10;
            ["week"] = {
               [11] = true;
               [2] = true;
               [8] = true;
               [3] = true;
               [12] = true;
               [5] = true;
               [9] = true;
               [6] = true;
            };
         };
         [8] = {
            ["y"] = -149.7466292647;
            ["x"] = 610.00322374616;
            ["sublevel"] = 1;
            ["g"] = 17;
            ["week"] = {
               [8] = true;
               [2] = true;
               [5] = true;
               [11] = true;
            };
         };
         [14] = {
            ["y"] = -227.11857706207;
            ["x"] = 652.85582790314;
            ["sublevel"] = 1;
            ["g"] = 13;
            ["week"] = {
               [3] = true;
               [6] = true;
               [9] = true;
               [12] = true;
            };
         };
         [9] = {
            ["y"] = -159.83150395084;
            ["x"] = 562.0277558974;
            ["sublevel"] = 1;
            ["g"] = 16;
            ["week"] = {
               [11] = true;
               [2] = true;
               [8] = true;
               [10] = true;
               [1] = true;
               [4] = true;
               [5] = true;
               [7] = true;
            };
         };
         [5] = {
            ["y"] = -362.18242032406;
            ["x"] = 482.0021884796;
            ["sublevel"] = 1;
            ["g"] = 9;
            ["week"] = {
               [11] = true;
               [2] = true;
               [8] = true;
               [5] = true;
            };
         };
         [10] = {
            ["y"] = -133.19132012212;
            ["x"] = 433.33157110862;
            ["sublevel"] = 1;
            ["g"] = 19;
            ["week"] = {
               [8] = true;
               [2] = true;
               [5] = true;
               [11] = true;
            };
         };
         [11] = {
            ["y"] = -112.93565637741;
            ["x"] = 332.46690985395;
            ["sublevel"] = 1;
            ["g"] = 20;
            ["week"] = {
               [8] = true;
               [2] = true;
               [5] = true;
               [11] = true;
            };
         };
         [3] = {
            ["y"] = -415.67067881036;
            ["x"] = 382.51609270262;
            ["sublevel"] = 1;
            ["g"] = 3;
            ["week"] = {
               [8] = true;
               [2] = true;
               [5] = true;
               [11] = true;
            };
         };
         [6] = {
            ["y"] = -282.44924731702;
            ["x"] = 585.74826644712;
            ["sublevel"] = 1;
            ["g"] = 29;
            ["week"] = {
               [8] = true;
               [2] = true;
               [5] = true;
               [11] = true;
            };
         };
         [12] = {
            ["y"] = -430.07555176735;
            ["x"] = 408.78893405719;
            ["week"] = {
               [3] = true;
               [6] = true;
               [9] = true;
               [12] = true;
            };
            ["g"] = 2;
            ["sublevel"] = 1;
         };
         [15] = {
            ["y"] = -208.70126280334;
            ["x"] = 439.11219606077;
            ["sublevel"] = 1;
            ["g"] = 31;
            ["week"] = {
               [3] = true;
               [6] = true;
               [9] = true;
               [12] = true;
            };
         };
      };
      ["scale"] = 1;
      ["spells"] = {
         [302417] = {};
         [302418] = {};
         [302415] = {};
      };
      ["characteristics"] = {
         ["Taunt"] = true;
      };
      ["id"] = 155434;
      ["name"] = "Emissary of the Tides";
      ["ignoreFortified"] = true;
      ["health"] = 614795;
      ["displayId"] = 39391;
      ["creatureType"] = "Humanoid";
      ["level"] = 120;
      ["count"] = 4;
      ["iconTexture"] = 132315;
   };
   [15] = {
      ["clones"] = {
         [1] = {
            ["y"] = -293.36277790688;
            ["x"] = 400.98001091909;
            ["sublevel"] = 1;
         };
      };
      ["id"] = 131318;
      ["characteristics"] = {
         ["Taunt"] = true;
      };
      ["spells"] = {
         [264603] = {};
         [260879] = {};
         [260894] = {};
         [260685] = {};
         [264757] = {};
      };
      ["isBoss"] = true;
      ["encounterID"] = 2157;
      ["instanceID"] = 1022;
      ["name"] = "Elder Leaxa";
      ["health"] = 3688770;
      ["displayId"] = 82394;
      ["creatureType"] = "Humanoid";
      ["level"] = 122;
      ["count"] = 0;
      ["scale"] = 1;
   };
};
