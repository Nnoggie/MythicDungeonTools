local MDT = MDT
local L = MDT.L
local dungeonIndex = 34
MDT.dungeonList[dungeonIndex] = L["Spires of Ascension"]
MDT.mapInfo[dungeonIndex] = {
    viewportPositionOverrides =
    {
        [1] = {
            zoomScale = 2.1999998092651;
            horizontalPan = 306.3520744598;
            verticalPan = 67.483489557154;
        };
        [3] = {
            zoomScale = 1.8999998569489;
            horizontalPan = 187.55799437121;
            verticalPan = 173.33103552728;
        };
        [4] = {
            zoomScale = 2.7999997138977;
            horizontalPan = 213.62455400331;
            verticalPan = 261.78908025446;
        };
    }
};
MDT.scaleMultiplier[dungeonIndex] = 1.3

MDT.dungeonMaps[dungeonIndex] = {
   [0] = "SpiresOfAscension_A",
   [1] = "SpiresOfAscension_A",
   [2] = "SpiresOfAscension_B",
   [3] = "SpiresOfAscension_C",
   [4] = "SpiresOfAscension_D",
}
MDT.dungeonSubLevels[dungeonIndex] = {
    [1] = L["Honor's Ascent"],
    [2] = L["Gardens of Repose"],
    [3] = L["Font of Fealty"],
    [4] = L["Seat of the Archon"],
}

MDT.dungeonTotalCount[dungeonIndex] = {normal=285,teeming=1000,teemingEnabled=true}
MDT.mapPOIs[dungeonIndex] = {
    [1] = {
        [1] = {
            ["y"] = -95.008076613696;
            ["x"] = 610.4211751383;
            ["connectionIndex"] = 1;
            ["target"] = 2;
            ["type"] = "mapLink";
            ["template"] = "MapLinkPinTemplate";
            ["direction"] = 1;
        };
    };
    [2] = {
        [1] = {
            ["y"] = -345.19250667244;
            ["x"] = 308.77461659958;
            ["connectionIndex"] = 1;
            ["target"] = 1;
            ["type"] = "mapLink";
            ["template"] = "MapLinkPinTemplate";
            ["direction"] = -1;
        };
        [2] = {
            ["y"] = -228.01752388311;
            ["x"] = 589.0447126466;
            ["connectionIndex"] = 2;
            ["target"] = 3;
            ["type"] = "mapLink";
            ["template"] = "MapLinkPinTemplate";
            ["direction"] = 1;
        };
    };
    [3] = {
        [1] = {
            ["y"] = -437.03235988446;
            ["x"] = 322.23401673653;
            ["connectionIndex"] = 2;
            ["target"] = 2;
            ["type"] = "mapLink";
            ["template"] = "MapLinkPinTemplate";
            ["direction"] = -1;
        };
        [2] = {
            ["y"] = -247.81058749468;
            ["x"] = 427.53313417727;
            ["connectionIndex"] = 3;
            ["target"] = 4;
            ["type"] = "mapLink";
            ["template"] = "MapLinkPinTemplate";
            ["direction"] = 1;
        };
    };
    [4] = {
        [1] = {
            ["y"] = -404.57176546128;
            ["x"] = 349.15247723985;
            ["connectionIndex"] = 3;
            ["target"] = 3;
            ["type"] = "mapLink";
            ["template"] = "MapLinkPinTemplate";
            ["direction"] = -1;
        };
    };
};

MDT.dungeonEnemies[dungeonIndex] = {
   [1] = {
      ["clones"] = {
         [1] = {
            ["y"] = -286.73511030461;
            ["x"] = 436.44557640296;
            ["g"] = 1;
            ["sublevel"] = 1;
         };
         [2] = {
            ["sublevel"] = 1;
            ["inspiring"] = true;
            ["x"] = 584.29408095585;
            ["g"] = 3;
            ["y"] = -118.24636426947;
         };
         [3] = {
            ["sublevel"] = 2;
            ["inspiring"] = true;
            ["x"] = 340.76680878558;
            ["g"] = 4;
            ["y"] = -335.34629822493;
         };
      };
      ["id"] = 163459;
      ["spells"] = {
         [317936] = {
            ["interruptible"] = true;
         };
         [327332] = {};
      };
      ["characteristics"] = {
         ["Taunt"] = true;
         ["Incapacitate"] = true;
         ["Root"] = true;
         ["Repentance"] = true;
         ["Mind Control"] = true;
         ["Polymorph"] = true;
         ["Disorient"] = true;
         ["Sap"] = true;
         ["Stun"] = true;
         ["Silence"] = true;
         ["Slow"] = true;
         ["Fear"] = true;
         ["Imprison"] = true;
      };
      ["count"] = 4;
      ["name"] = "Forsworn Mender";
      ["displayId"] = 94304;
      ["creatureType"] = "Humanoid";
      ["level"] = 60;
      ["health"] = "132156";
      ["scale"] = 1;
   };
   [2] = {
      ["clones"] = {
         [6] = {
            ["y"] = -339.18716669452;
            ["x"] = 353.19505734505;
            ["g"] = 4;
            ["sublevel"] = 2;
         };
         [2] = {
            ["y"] = -269.13781521478;
            ["x"] = 421.5177455961;
            ["g"] = 1;
            ["sublevel"] = 1;
         };
         [3] = {
            ["y"] = -222.28779026348;
            ["x"] = 485.61606268064;
            ["g"] = 2;
            ["sublevel"] = 1;
         };
         [1] = {
            ["sublevel"] = 1;
            ["inspiring"] = true;
            ["y"] = -284.54584323099;
            ["g"] = 1;
            ["x"] = 420.98967344245;
         };
         [4] = {
            ["y"] = -119.93768263112;
            ["x"] = 598.78040928345;
            ["g"] = 3;
            ["sublevel"] = 1;
         };
         [5] = {
            ["y"] = -328.88668465738;
            ["x"] = 350.92810338517;
            ["g"] = 4;
            ["sublevel"] = 2;
         };
      };
      ["id"] = 163457;
      ["spells"] = {
         [317943] = {};
      };
      ["characteristics"] = {
         ["Taunt"] = true;
         ["Incapacitate"] = true;
         ["Root"] = true;
         ["Repentance"] = true;
         ["Imprison"] = true;
         ["Polymorph"] = true;
         ["Disorient"] = true;
         ["Sap"] = true;
         ["Stun"] = true;
         ["Silence"] = true;
         ["Slow"] = true;
         ["Mind Control"] = true;
         ["Fear"] = true;
      };
      ["count"] = 4;
      ["name"] = "Forsworn Vanguard";
      ["displayId"] = 93491;
      ["creatureType"] = "Humanoid";
      ["level"] = 60;
      ["health"] = "165195";
      ["scale"] = 1;
   };
   [4] = {
      ["clones"] = {
         [1] = {
            ["y"] = -222.78149411528;
            ["x"] = 498.09187919822;
            ["g"] = 2;
            ["sublevel"] = 1;
         };
         [2] = {
            ["y"] = -209.2778343411;
            ["x"] = 484.4837359017;
            ["g"] = 2;
            ["sublevel"] = 1;
         };
         [4] = {
            ["y"] = -319.29724137931;
            ["x"] = 352.7291954023;
            ["g"] = 4;
            ["sublevel"] = 2;
         };
         [3] = {
            ["y"] = -103.24849790581;
            ["x"] = 582.83666014353;
            ["g"] = 3;
            ["sublevel"] = 1;
         };
      };
      ["id"] = 163458;
      ["spells"] = {
         [317959] = {
            ["interruptible"] = true;
         };
         [317963] = {
            ["interruptible"] = true;
         };
      };
      ["characteristics"] = {
         ["Taunt"] = true;
         ["Incapacitate"] = true;
         ["Root"] = true;
         ["Repentance"] = true;
         ["Mind Control"] = true;
         ["Polymorph"] = true;
         ["Disorient"] = true;
         ["Sap"] = true;
         ["Stun"] = true;
         ["Silence"] = true;
         ["Slow"] = true;
         ["Fear"] = true;
         ["Imprison"] = true;
      };
      ["count"] = 4;
      ["name"] = "Forsworn Castigator";
      ["displayId"] = 93483;
      ["creatureType"] = "Humanoid";
      ["level"] = 60;
      ["health"] = "165195";
      ["scale"] = 1;
   };
   [8] = {
      ["clones"] = {
         [6] = {
            ["y"] = -438.40391678238;
            ["x"] = 574.7495926619;
            ["g"] = 14;
            ["sublevel"] = 2;
         };
         [2] = {
            ["y"] = -263.09224336107;
            ["x"] = 383.65426618325;
            ["g"] = 9;
            ["sublevel"] = 2;
         };
         [3] = {
            ["y"] = -268.86059055047;
            ["x"] = 392.85574580526;
            ["g"] = 9;
            ["sublevel"] = 2;
         };
         [1] = {
            ["y"] = -259.09405730651;
            ["x"] = 359.77763652591;
            ["g"] = 8;
            ["sublevel"] = 2;
         };
         [4] = {
            ["y"] = -274.37699329145;
            ["x"] = 383.19152994103;
            ["g"] = 9;
            ["sublevel"] = 2;
         };
         [5] = {
            ["sublevel"] = 2;
            ["x"] = 377.1743414741;
            ["g"] = 10;
            ["y"] = -229.59704911519;
         };
         [7] = {
            ["sublevel"] = 2;
            ["x"] = 283.69792862068;
            ["g"] = 24;
            ["y"] = -126.81483178582;
         };
      };
      ["id"] = 163501;
      ["spells"] = {
         [323682] = {};
      };
      ["characteristics"] = {
         ["Taunt"] = true;
         ["Incapacitate"] = true;
         ["Root"] = true;
         ["Repentance"] = true;
         ["Disorient"] = true;
         ["Polymorph"] = true;
         ["Mind Control"] = true;
         ["Sap"] = true;
         ["Silence"] = true;
         ["Stun"] = true;
         ["Slow"] = true;
         ["Fear"] = true;
         ["Imprison"] = true;
      };
      ["count"] = 4;
      ["name"] = "Forsworn Skirmisher";
      ["displayId"] = 93491;
      ["creatureType"] = "Humanoid";
      ["level"] = 60;
      ["health"] = "165195";
      ["scale"] = 1;
   };
   [16] = {
      ["clones"] = {
         [6] = {
            ["y"] = -318.69552870833;
            ["x"] = 448.15131786828;
            ["g"] = 31;
            ["sublevel"] = 3;
         };
         [2] = {
            ["sublevel"] = 3;
            ["inspiring"] = true;
            ["x"] = 394.63622002074;
            ["g"] = 27;
            ["y"] = -322.82719227387;
         };
         [3] = {
            ["y"] = -275.28384020815;
            ["x"] = 367.39232289095;
            ["g"] = 28;
            ["sublevel"] = 3;
         };
         [1] = {
            ["y"] = -359.83836367609;
            ["x"] = 353.1550990105;
            ["g"] = 26;
            ["sublevel"] = 3;
         };
         [4] = {
            ["y"] = -273.83294887121;
            ["x"] = 357.06266300075;
            ["g"] = 28;
            ["sublevel"] = 3;
         };
         [5] = {
            ["y"] = -291.51464151859;
            ["x"] = 410.28371168754;
            ["g"] = 30;
            ["sublevel"] = 3;
         };
         [7] = {
            ["y"] = -313.34848083895;
            ["x"] = 432.05892787324;
            ["g"] = 31;
            ["sublevel"] = 3;
         };
      };
      ["id"] = 168718;
      ["spells"] = {
         [328295] = {
            ["interruptible"] = true;
         };
         [328288] = {};
      };
      ["characteristics"] = {
         ["Taunt"] = true;
         ["Incapacitate"] = true;
         ["Root"] = true;
         ["Repentance"] = true;
         ["Mind Control"] = true;
         ["Polymorph"] = true;
         ["Disorient"] = true;
         ["Sap"] = true;
         ["Stun"] = true;
         ["Silence"] = true;
         ["Slow"] = true;
         ["Fear"] = true;
         ["Imprison"] = true;
      };
      ["count"] = 4;
      ["name"] = "Forsworn Warden";
      ["displayId"] = 94313;
      ["creatureType"] = "Humanoid";
      ["level"] = 60;
      ["health"] = "148676";
      ["scale"] = 1;
   };
   [17] = {
      ["clones"] = {
         [2] = {
            ["y"] = -271.49560363498;
            ["x"] = 346.48414994473;
            ["g"] = 28;
            ["sublevel"] = 3;
         };
         [3] = {
            ["y"] = -292.33211852251;
            ["x"] = 400.23842865035;
            ["g"] = 30;
            ["sublevel"] = 3;
         };
         [1] = {
            ["y"] = -324.8002049666;
            ["x"] = 382.64163031182;
            ["g"] = 27;
            ["sublevel"] = 3;
         };
         [4] = {
            ["y"] = -306.90829249305;
            ["x"] = 441.68271768729;
            ["g"] = 31;
            ["sublevel"] = 3;
         };
         [5] = {
            ["y"] = -301.45105524111;
            ["x"] = 427.61292017851;
            ["g"] = 31;
            ["sublevel"] = 3;
         };
      };
      ["id"] = 168717;
      ["spells"] = {
         [328331] = {
            ["interruptible"] = true;
         };
         [317959] = {
            ["interruptible"] = true;
         };
         [328332] = {};
      };
      ["characteristics"] = {
         ["Taunt"] = true;
         ["Incapacitate"] = true;
         ["Root"] = true;
         ["Repentance"] = true;
         ["Mind Control"] = true;
         ["Polymorph"] = true;
         ["Disorient"] = true;
         ["Sap"] = true;
         ["Stun"] = true;
         ["Silence"] = true;
         ["Slow"] = true;
         ["Fear"] = true;
         ["Imprison"] = true;
      };
      ["count"] = 4;
      ["name"] = "Forsworn Justicar";
      ["displayId"] = 95754;
      ["creatureType"] = "Humanoid";
      ["level"] = 60;
      ["health"] = "165195";
      ["scale"] = 1;
   };
   [9] = {
      ["clones"] = {
         [2] = {
            ["y"] = -447.46529853318;
            ["x"] = 565.97159377571;
            ["g"] = 14;
            ["sublevel"] = 2;
         };
         [3] = {
            ["sublevel"] = 2;
            ["x"] = 556.14868737631;
            ["g"] = 18;
            ["y"] = -284.16875495241;
         };
         [1] = {
            ["sublevel"] = 2;
            ["x"] = 367.38957586906;
            ["g"] = 10;
            ["y"] = -233.74924820048;
         };
         [4] = {
            ["sublevel"] = 2;
            ["x"] = 524.88628114361;
            ["g"] = 19;
            ["y"] = -196.46131556745;
         };
         [5] = {
            ["sublevel"] = 2;
            ["x"] = 499.60136639113;
            ["g"] = 20;
            ["y"] = -94.057400017449;
         };
      };
      ["id"] = 168420;
      ["spells"] = {
         [327655] = {};
         [317936] = {
            ["interruptible"] = true;
         };
      };
      ["characteristics"] = {
         ["Taunt"] = true;
         ["Incapacitate"] = true;
         ["Root"] = true;
         ["Repentance"] = true;
         ["Mind Control"] = true;
         ["Polymorph"] = true;
         ["Disorient"] = true;
         ["Sap"] = true;
         ["Stun"] = true;
         ["Silence"] = true;
         ["Slow"] = true;
         ["Fear"] = true;
         ["Imprison"] = true;
      };
      ["count"] = 4;
      ["name"] = "Forsworn Champion";
      ["displayId"] = 94313;
      ["creatureType"] = "Humanoid";
      ["level"] = 60;
      ["health"] = "132156";
      ["scale"] = 1;
   };
   [18] = {
      ["clones"] = {
         [7] = {
            ["y"] = -291.29136773036;
            ["x"] = 453.8282659323;
            ["g"] = 32;
            ["sublevel"] = 3;
         };
         [1] = {
            ["y"] = -248.23295043776;
            ["x"] = 365.45533430462;
            ["g"] = 29;
            ["sublevel"] = 3;
         };
         [2] = {
            ["y"] = -260.73121260329;
            ["x"] = 385.14618349678;
            ["g"] = 29;
            ["sublevel"] = 3;
         };
         [4] = {
            ["y"] = -256.6830277592;
            ["x"] = 378.65651152436;
            ["g"] = 29;
            ["sublevel"] = 3;
         };
         [8] = {
            ["y"] = -281.7495088174;
            ["x"] = 436.62648144946;
            ["g"] = 32;
            ["sublevel"] = 3;
         };
         [9] = {
            ["y"] = -298.32494563434;
            ["x"] = 465.52252885931;
            ["g"] = 32;
            ["sublevel"] = 3;
         };
         [5] = {
            ["y"] = -243.28508753878;
            ["x"] = 359.22359992626;
            ["g"] = 29;
            ["sublevel"] = 3;
         };
         [10] = {
            ["y"] = -294.59801344187;
            ["x"] = 459.36141451738;
            ["g"] = 32;
            ["sublevel"] = 3;
         };
         [3] = {
            ["y"] = -238.56288371259;
            ["x"] = 354.96789174054;
            ["g"] = 29;
            ["sublevel"] = 3;
         };
         [6] = {
            ["y"] = -252.71581576641;
            ["x"] = 372.67182291891;
            ["g"] = 29;
            ["sublevel"] = 3;
         };
         [12] = {
            ["y"] = -287.68985324643;
            ["x"] = 446.92513828714;
            ["g"] = 32;
            ["sublevel"] = 3;
         };
         [11] = {
            ["y"] = -284.98420335433;
            ["x"] = 441.70281736634;
            ["g"] = 32;
            ["sublevel"] = 3;
         };
      };
      ["id"] = 166411;
      ["spells"] = {
         [323682] = {};
      };
      ["characteristics"] = {
         ["Taunt"] = true;
         ["Incapacitate"] = true;
         ["Root"] = true;
         ["Repentance"] = true;
         ["Mind Control"] = true;
         ["Polymorph"] = true;
         ["Disorient"] = true;
         ["Sap"] = true;
         ["Stun"] = true;
         ["Silence"] = true;
         ["Slow"] = true;
         ["Imprison"] = true;
         ["Fear"] = true;
      };
      ["count"] = 1;
      ["name"] = "Forsworn Usurper";
      ["displayId"] = 93482;
      ["creatureType"] = "Humanoid";
      ["level"] = 60;
      ["health"] = "33039";
      ["scale"] = 0.7;
   };
   [5] = {
      ["clones"] = {
         [1] = {
            ["y"] = -311.93486091078;
            ["x"] = 402.91236819007;
            ["g"] = 5;
            ["sublevel"] = 2;
         };
      };
      ["id"] = 163077;
      ["spells"] = {
         [331249] = {};
         [324368] = {};
         [345561] = {};
      };
      ["characteristics"] = {
         ["Taunt"] = true;
      };
      ["count"] = 0;
      ["name"] = "Azules";
      ["displayId"] = 93471;
      ["creatureType"] = "Beast";
      ["level"] = 60;
      ["health"] = "1718028";
      ["scale"] = 1;
   };
   [10] = {
      ["clones"] = {
         [6] = {
            ["sublevel"] = 2;
            ["x"] = 284.57516093744;
            ["g"] = 24;
            ["y"] = -141.83769668237;
         };
         [2] = {
            ["sublevel"] = 2;
            ["x"] = 622.38196728369;
            ["g"] = 17;
            ["y"] = -390.09417725635;
         };
         [3] = {
            ["sublevel"] = 2;
            ["x"] = 555.78218026632;
            ["g"] = 18;
            ["y"] = -296.11155006192;
         };
         [1] = {
            ["sublevel"] = 2;
            ["x"] = 375.99936462736;
            ["g"] = 10;
            ["y"] = -240.23717527145;
         };
         [4] = {
            ["sublevel"] = 2;
            ["x"] = 516.13039751157;
            ["g"] = 19;
            ["y"] = -199.77269114267;
         };
         [5] = {
            ["sublevel"] = 2;
            ["x"] = 492.46936339433;
            ["g"] = 20;
            ["y"] = -101.54692574708;
         };
      };
      ["id"] = 163520;
      ["spells"] = {
         [323740] = {};
         [317985] = {};
         [323739] = {};
         [327808] = {};
      };
      ["characteristics"] = {
         ["Taunt"] = true;
      };
      ["count"] = 6;
      ["name"] = "Forsworn Squad-Leader";
      ["displayId"] = 94919;
      ["creatureType"] = "Humanoid";
      ["level"] = 60;
      ["health"] = "264312";
      ["scale"] = 1;
   };
   [20] = {
      ["clones"] = {
         [1] = {
            ["y"] = -331.88433312061;
            ["x"] = 335.64255319149;
            ["sublevel"] = 4;
         };
      };
      ["id"] = 168843;
      ["spells"] = {
         [328435] = {};
         [328462] = {};
         [336420] = {};
         [328452] = {};
         [336496] = {};
         [336444] = {};
         [328453] = {};
         [324662] = {};
         [323739] = {};
         [328434] = {};
      };
      ["characteristics"] = {
         ["Taunt"] = true;
      };
      ["count"] = 12;
      ["name"] = "Klotos";
      ["displayId"] = 95759;
      ["creatureType"] = "Humanoid";
      ["level"] = 60;
      ["health"] = "495585";
      ["scale"] = 1.5;
   };
   [30] = {
      ["clones"] = {
         [13] = {
            ["y"] = -267.36603655549;
            ["x"] = 331.5937729827;
            ["sublevel"] = 3;
         };
         [7] = {
            ["y"] = -464.38413704298;
            ["x"] = 421.27857832034;
            ["sublevel"] = 2;
         };
         [1] = {
            ["y"] = -215.74311326156;
            ["x"] = 469.56185989175;
            ["sublevel"] = 1;
         };
         [2] = {
            ["y"] = -348.58171079099;
            ["x"] = 335.12384018808;
            ["sublevel"] = 2;
         };
         [4] = {
            ["y"] = -79.399961817783;
            ["x"] = 504.52429594575;
            ["sublevel"] = 2;
         };
         [8] = {
            ["y"] = -451.07143970225;
            ["x"] = 552.91006079279;
            ["sublevel"] = 2;
         };
         [9] = {
            ["y"] = -227.37831204375;
            ["x"] = 461.40843212192;
            ["sublevel"] = 3;
         };
         [5] = {
            ["y"] = -270.60126240761;
            ["x"] = 526.80960775841;
            ["sublevel"] = 2;
         };
         [10] = {
            ["y"] = -315.3846389106;
            ["x"] = 426.35098804769;
            ["sublevel"] = 4;
         };
         [3] = {
            ["y"] = -121.54185368334;
            ["x"] = 299.30062549082;
            ["sublevel"] = 2;
         };
         [6] = {
            ["y"] = -327.00233925898;
            ["x"] = 409.83033272749;
            ["sublevel"] = 2;
         };
         [12] = {
            ["y"] = -320.44902812433;
            ["x"] = 462.94355406238;
            ["sublevel"] = 3;
         };
         [11] = {
            ["y"] = -397.48238205672;
            ["x"] = 359.75425987445;
            ["sublevel"] = 3;
         };
      };
      ["include"] = {
         ["affix"] = 130;
         ["level"] = 10;
      };
      ["count"] = 0;
      ["modelPosition"] = {
         [1] = 0;
         [2] = 0;
         [3] = 0.75;
      };
      ["scale"] = 1;
      ["spells"] = {
         [366406] = {};
         [368103] = {};
         [366409] = {};
      };
      ["ignoreFortified"] = true;
      ["bonusSpell"] = 368240;
      ["name"] = "Vy Relic";
      ["badCreatureModel"] = true;
      ["health"] = "33039";
      ["displayId"] = 103111;
      ["creatureType"] = "Mechanical";
      ["level"] = 62;
      ["id"] = 185680;
      ["iconTexture"] = 4335643;
   };
   [21] = {
      ["clones"] = {
         [1] = {
            ["y"] = -368.80250147291;
            ["x"] = 371.26771977629;
            ["sublevel"] = 4;
         };
      };
      ["id"] = 168844;
      ["spells"] = {
         [328434] = {};
         [328435] = {};
         [336496] = {};
         [324662] = {};
         [328453] = {};
         [336444] = {};
         [328454] = {};
         [328462] = {};
      };
      ["characteristics"] = {
         ["Taunt"] = true;
      };
      ["count"] = 12;
      ["name"] = "Lakesis";
      ["displayId"] = 95759;
      ["creatureType"] = "Humanoid";
      ["level"] = 60;
      ["health"] = "495585";
      ["scale"] = 1.5;
   };
   [11] = {
      ["clones"] = {
         [15] = {
            ["y"] = -127.1079731309;
            ["x"] = 343.51626569244;
            ["g"] = 23;
            ["sublevel"] = 2;
         };
         [13] = {
            ["y"] = -130.73363227095;
            ["x"] = 336.3259858405;
            ["g"] = 23;
            ["sublevel"] = 2;
         };
         [7] = {
            ["y"] = -463.76014457109;
            ["x"] = 444.41532974414;
            ["g"] = 11;
            ["sublevel"] = 2;
         };
         [1] = {
            ["y"] = -373.15859654204;
            ["x"] = 392.05571377419;
            ["g"] = 6;
            ["sublevel"] = 2;
         };
         [2] = {
            ["y"] = -376.46998546837;
            ["x"] = 399.61947397278;
            ["g"] = 6;
            ["sublevel"] = 2;
         };
         [4] = {
            ["y"] = -366.96195503578;
            ["x"] = 422.33016215423;
            ["g"] = 7;
            ["sublevel"] = 2;
         };
         [8] = {
            ["sublevel"] = 2;
            ["x"] = 518.59758087323;
            ["g"] = 19;
            ["y"] = -187.78179272496;
         };
         [16] = {
            ["sublevel"] = 2;
            ["x"] = 292.84781609195;
            ["g"] = 24;
            ["y"] = -134.9925862069;
         };
         [9] = {
            ["y"] = -83.632152327349;
            ["x"] = 448.67426350644;
            ["g"] = 22;
            ["sublevel"] = 2;
         };
         [5] = {
            ["y"] = -360.66422287174;
            ["x"] = 419.0047278377;
            ["g"] = 7;
            ["sublevel"] = 2;
         };
         [10] = {
            ["y"] = -96.048001137773;
            ["x"] = 465.62453639749;
            ["g"] = 22;
            ["sublevel"] = 2;
         };
         [14] = {
            ["y"] = -122.57540129151;
            ["x"] = 336.68083155384;
            ["g"] = 23;
            ["sublevel"] = 2;
         };
         [3] = {
            ["y"] = -368.49052882267;
            ["x"] = 398.14086245535;
            ["g"] = 6;
            ["sublevel"] = 2;
         };
         [6] = {
            ["y"] = -360.63438164235;
            ["x"] = 426.75564615176;
            ["g"] = 7;
            ["sublevel"] = 2;
         };
         [12] = {
            ["y"] = -84.357001107378;
            ["x"] = 465.62978646916;
            ["g"] = 22;
            ["sublevel"] = 2;
         };
         [11] = {
            ["y"] = -79.79052306995;
            ["x"] = 457.51051730946;
            ["g"] = 22;
            ["sublevel"] = 2;
         };
      };
      ["id"] = 163506;
      ["spells"] = {
         [30831] = {};
         [323744] = {};
         [27638] = {};
      };
      ["characteristics"] = {
         ["Taunt"] = true;
         ["Incapacitate"] = true;
         ["Root"] = true;
         ["Imprison"] = true;
         ["Polymorph"] = true;
         ["Mind Control"] = true;
         ["Sap"] = true;
         ["Disorient"] = true;
         ["Stun"] = true;
         ["Slow"] = true;
         ["Silence"] = true;
         ["Fear"] = true;
      };
      ["health"] = "165195";
      ["stealth"] = true;
      ["name"] = "Forsworn Stealthclaw";
      ["displayId"] = 93462;
      ["creatureType"] = "Beast";
      ["level"] = 60;
      ["count"] = 4;
      ["scale"] = 0.7;
   };
   [22] = {
      ["clones"] = {
         [1] = {
            ["y"] = -383.44048886898;
            ["x"] = 422.58863079951;
            ["sublevel"] = 4;
         };
      };
      ["id"] = 168845;
      ["spells"] = {
         [328466] = {};
         [336496] = {};
         [328434] = {};
         [328453] = {};
         [333887] = {};
         [336444] = {};
         [324662] = {};
      };
      ["characteristics"] = {
         ["Taunt"] = true;
      };
      ["count"] = 12;
      ["name"] = "Astronos";
      ["displayId"] = 95759;
      ["creatureType"] = "Humanoid";
      ["level"] = 60;
      ["health"] = "495585";
      ["scale"] = 1.5;
   };
   [3] = {
      ["clones"] = {
         [6] = {
            ["sublevel"] = 2;
            ["x"] = 493.1330710124;
            ["g"] = 21;
            ["y"] = -56.066082968468;
         };
         [2] = {
            ["y"] = -321.53989886265;
            ["x"] = 339.69233208438;
            ["g"] = 4;
            ["sublevel"] = 2;
         };
         [8] = {
            ["y"] = -310.13797089349;
            ["x"] = 379.02532322416;
            ["g"] = 27;
            ["sublevel"] = 3;
         };
         [3] = {
            ["y"] = -496.33600161548;
            ["x"] = 449.11123915465;
            ["g"] = 12;
            ["sublevel"] = 2;
         };
         [1] = {
            ["sublevel"] = 1;
            ["x"] = 532.69180187707;
            ["patrol"] = {
               [15] = {
                  ["y"] = -210.8637538535;
                  ["x"] = 495.87261913565;
               };
               [13] = {
                  ["y"] = -252.24927416127;
                  ["x"] = 452.68768137588;
               };
               [7] = {
                  ["y"] = -174.12328302357;
                  ["x"] = 532.69180187707;
               };
               [1] = {
                  ["y"] = -174.12328302357;
                  ["x"] = 532.69180187707;
               };
               [2] = {
                  ["y"] = -151.4845146272;
                  ["x"] = 552.01294864746;
               };
               [4] = {
                  ["y"] = -124.13412302974;
                  ["x"] = 578.64364430707;
               };
               [8] = {
                  ["y"] = -193.94967922852;
                  ["x"] = 512.06695149042;
               };
               [16] = {
                  ["y"] = -193.94967922852;
                  ["x"] = 512.06695149042;
               };
               [9] = {
                  ["y"] = -210.8637538535;
                  ["x"] = 495.87261913565;
               };
               [5] = {
                  ["y"] = -132.05133433443;
                  ["x"] = 570.36652325698;
               };
               [10] = {
                  ["y"] = -230.29694959039;
                  ["x"] = 473.92028684272;
               };
               [14] = {
                  ["y"] = -230.29694959039;
                  ["x"] = 473.92028684272;
               };
               [3] = {
                  ["y"] = -132.05133433443;
                  ["x"] = 570.36652325698;
               };
               [6] = {
                  ["y"] = -151.4845146272;
                  ["x"] = 552.01294864746;
               };
               [12] = {
                  ["y"] = -259.80663749702;
                  ["x"] = 445.13034892837;
               };
               [11] = {
                  ["y"] = -252.24927416127;
                  ["x"] = 452.68768137588;
               };
            };
            ["y"] = -174.12328302357;
         };
         [4] = {
            ["y"] = -489.06296375264;
            ["x"] = 434.3612567137;
            ["g"] = 12;
            ["sublevel"] = 2;
         };
         [5] = {
            ["sublevel"] = 2;
            ["x"] = 638.3643389787;
            ["patrol"] = {};
            ["g"] = 16;
            ["y"] = -426.36915937991;
         };
         [7] = {
            ["y"] = -360.18714634998;
            ["x"] = 365.61475173587;
            ["g"] = 26;
            ["sublevel"] = 3;
         };
      };
      ["id"] = 168318;
      ["spells"] = {
         [327413] = {
            ["interruptible"] = true;
         };
         [327416] = {};
      };
      ["characteristics"] = {
         ["Taunt"] = true;
      };
      ["count"] = 8;
      ["name"] = "Forsworn Goliath";
      ["displayId"] = 92664;
      ["creatureType"] = "Mechanical";
      ["level"] = 60;
      ["health"] = "264312";
      ["scale"] = 1.5;
   };
   [6] = {
      ["clones"] = {
         [1] = {
            ["y"] = -312.88775031273;
            ["x"] = 385.56093065893;
            ["g"] = 5;
            ["sublevel"] = 2;
         };
      };
      ["scale"] = 1;
      ["characteristics"] = {
         ["Taunt"] = true;
      };
      ["spells"] = {
         [320966] = {};
         [327481] = {};
         [321009] = {};
         [345561] = {};
      };
      ["isBoss"] = true;
      ["encounterID"] = 2399;
      ["instanceID"] = 1186;
      ["count"] = 0;
      ["name"] = "Kin-Tara";
      ["displayId"] = 95068;
      ["creatureType"] = "Humanoid";
      ["level"] = 60;
      ["health"] = "1321934";
      ["id"] = 162059;
   };
   [12] = {
      ["clones"] = {
         [7] = {
            ["sublevel"] = 2;
            ["x"] = 546.53647178034;
            ["g"] = 18;
            ["y"] = -286.64564851729;
         };
         [1] = {
            ["y"] = -374.85556229507;
            ["x"] = 433.47795356133;
            ["sublevel"] = 2;
         };
         [2] = {
            ["y"] = -458.33202221227;
            ["x"] = 434.18024819274;
            ["g"] = 11;
            ["sublevel"] = 2;
         };
         [4] = {
            ["sublevel"] = 2;
            ["x"] = 473.38893692436;
            ["patrol"] = {};
            ["g"] = 13;
            ["y"] = -496.30718718673;
         };
         [8] = {
            ["sublevel"] = 2;
            ["x"] = 506.46842243128;
            ["g"] = 19;
            ["y"] = -191.18801265382;
         };
         [9] = {
            ["sublevel"] = 2;
            ["inspiring"] = true;
            ["x"] = 455.76063752292;
            ["g"] = 22;
            ["y"] = -91.29181617176;
         };
         [5] = {
            ["y"] = -436.98084457573;
            ["x"] = 631.32988329623;
            ["g"] = 16;
            ["sublevel"] = 2;
         };
         [3] = {
            ["y"] = -504.51767052835;
            ["x"] = 437.17673586115;
            ["g"] = 12;
            ["sublevel"] = 2;
         };
         [6] = {
            ["sublevel"] = 2;
            ["patrol"] = {};
            ["x"] = 630.23712110311;
            ["g"] = 17;
            ["y"] = -388.71385437505;
         };
      };
      ["id"] = 163524;
      ["spells"] = {
         [323804] = {};
         [323786] = {};
      };
      ["characteristics"] = {
         ["Taunt"] = true;
         ["Incapacitate"] = true;
         ["Root"] = true;
         ["Polymorph"] = true;
         ["Disorient"] = true;
         ["Stun"] = true;
         ["Slow"] = true;
         ["Silence"] = true;
         ["Fear"] = true;
      };
      ["count"] = 5;
      ["name"] = "Kyrian Dark-Praetor";
      ["displayId"] = 92193;
      ["creatureType"] = "Mechanical";
      ["level"] = 60;
      ["health"] = "148676";
      ["scale"] = 1;
   };
   [24] = {
      ["clones"] = {
         [1] = {
            ["y"] = -328.11501272076;
            ["x"] = 320.10638742555;
            ["sublevel"] = 2;
            ["week"] = {
               [6] = true;
               [2] = true;
               [10] = true;
               [1] = true;
               [5] = true;
               [9] = true;
            };
         };
         [2] = {
            ["y"] = -380.37685438298;
            ["x"] = 354.12614370227;
            ["sublevel"] = 3;
            ["week"] = {
               [11] = true;
               [7] = true;
               [8] = true;
               [3] = true;
               [12] = true;
               [4] = true;
            };
         };
      };
      ["powers"] = {
         [357864] = {
            ["dps"] = true;
         };
         [357889] = {
            ["healer"] = true;
         };
         [357575] = {
            ["tank"] = true;
            ["dps"] = true;
            ["healer"] = true;
         };
         [357900] = {
            ["healer"] = true;
         };
         [357839] = {
            ["tank"] = true;
         };
         [357848] = {
            ["dps"] = true;
         };
         [357897] = {
            ["tank"] = true;
         };
      };
      ["id"] = 179446;
      ["spells"] = {
         [355732] = {};
         [358967] = {
            ["interruptible"] = true;
         };
         [355707] = {};
         [355737] = {};
      };
      ["include"] = {
         ["affix"] = 128;
         ["level"] = 10;
      };
      ["name"] = "Incinerator Arkolath";
      ["health"] = 336131;
      ["ignoreFortified"] = true;
      ["count"] = 0;
      ["displayId"] = 100718;
      ["creatureType"] = "Humanoid";
      ["level"] = 61;
      ["scale"] = 1.5;
      ["iconTexture"] = 236297;
   };
   [19] = {
      ["clones"] = {
         [1] = {
            ["y"] = -226.95582352941;
            ["x"] = 439.38917647059;
            ["sublevel"] = 3;
         };
      };
      ["scale"] = 1;
      ["characteristics"] = {
         ["Taunt"] = true;
      };
      ["spells"] = {
         [338729] = {};
         [334053] = {};
         [324427] = {};
         [324608] = {};
         [331997] = {};
         [324046] = {};
         [323878] = {};
         [324392] = {};
      };
      ["isBoss"] = true;
      ["encounterID"] = 2414;
      ["instanceID"] = 1186;
      ["count"] = 0;
      ["name"] = "Oryphrion";
      ["displayId"] = 97621;
      ["creatureType"] = "Mechanical";
      ["level"] = 60;
      ["health"] = "1817659";
      ["id"] = 162060;
   };
   [25] = {
      ["clones"] = {
         [1] = {
            ["y"] = -263.6576606658;
            ["x"] = 506.47761372507;
            ["sublevel"] = 2;
            ["week"] = {
               [6] = true;
               [2] = true;
               [10] = true;
               [1] = true;
               [5] = true;
               [9] = true;
            };
         };
         [2] = {
            ["y"] = -305.11363642753;
            ["x"] = 395.44178521678;
            ["sublevel"] = 3;
            ["week"] = {
               [11] = true;
               [7] = true;
               [8] = true;
               [3] = true;
               [12] = true;
               [4] = true;
            };
         };
      };
      ["powers"] = {
         [357815] = {
            ["healer"] = true;
            ["dps"] = true;
         };
         [357817] = {
            ["tank"] = true;
         };
         [357842] = {
            ["healer"] = true;
         };
         [357829] = {
            ["healer"] = true;
         };
         [357825] = {
            ["dps"] = true;
         };
         [357834] = {
            ["tank"] = true;
            ["dps"] = true;
         };
         [357820] = {
            ["tank"] = true;
         };
      };
      ["id"] = 179892;
      ["spells"] = {
         [358894] = {};
         [356666] = {};
         [355710] = {};
         [356414] = {};
      };
      ["include"] = {
         ["affix"] = 128;
         ["level"] = 10;
      };
      ["name"] = "Oros Coldheart";
      ["health"] = 336131;
      ["ignoreFortified"] = true;
      ["count"] = 0;
      ["displayId"] = 97237;
      ["creatureType"] = "Humanoid";
      ["level"] = 61;
      ["scale"] = 1.5;
      ["iconTexture"] = 136213;
   };
   [13] = {
      ["clones"] = {
         [1] = {
            ["y"] = -416.63968816925;
            ["x"] = 629.80547796504;
            ["g"] = 16;
            ["sublevel"] = 2;
         };
         [2] = {
            ["sublevel"] = 2;
            ["x"] = 544.18337685741;
            ["g"] = 18;
            ["y"] = -298.63622250596;
         };
         [4] = {
            ["sublevel"] = 2;
            ["x"] = 277.0064198426;
            ["g"] = 24;
            ["y"] = -134.41949006722;
         };
         [3] = {
            ["sublevel"] = 2;
            ["x"] = 504.23346953768;
            ["g"] = 20;
            ["y"] = -102.97397124752;
         };
      };
      ["id"] = 168418;
      ["spells"] = {
         [327648] = {
            ["interruptible"] = true;
         };
         [317959] = {
            ["interruptible"] = true;
         };
      };
      ["characteristics"] = {
         ["Taunt"] = true;
         ["Incapacitate"] = true;
         ["Root"] = true;
         ["Repentance"] = true;
         ["Imprison"] = true;
         ["Polymorph"] = true;
         ["Mind Control"] = true;
         ["Sap"] = true;
         ["Stun"] = true;
         ["Silence"] = true;
         ["Slow"] = true;
         ["Disorient"] = true;
         ["Fear"] = true;
      };
      ["count"] = 4;
      ["name"] = "Forsworn Inquisitor";
      ["displayId"] = 94316;
      ["creatureType"] = "Humanoid";
      ["level"] = 60;
      ["health"] = "165195";
      ["scale"] = 1;
   };
   [26] = {
      ["clones"] = {
         [1] = {
            ["y"] = -305.11363642753;
            ["x"] = 395.44178521678;
            ["sublevel"] = 3;
            ["week"] = {
               [6] = true;
               [2] = true;
               [10] = true;
               [1] = true;
               [5] = true;
               [9] = true;
            };
         };
         [2] = {
            ["y"] = -263.6576606658;
            ["x"] = 506.47761372507;
            ["sublevel"] = 2;
            ["week"] = {
               [11] = true;
               [7] = true;
               [8] = true;
               [3] = true;
               [12] = true;
               [4] = true;
            };
         };
      };
      ["powers"] = {
         [356828] = {
            ["dps"] = true;
            ["tank"] = true;
         };
         [356827] = {
            ["healer"] = true;
            ["dps"] = true;
         };
         [357524] = {
            ["tank"] = true;
            ["dps"] = true;
            ["healer"] = true;
         };
         [357778] = {
            ["tank"] = true;
         };
         [357556] = {
            ["healer"] = true;
         };
      };
      ["id"] = 179891;
      ["spells"] = {
         [358970] = {};
         [355719] = {};
         [358784] = {};
         [358968] = {};
         [355806] = {};
      };
      ["include"] = {
         ["affix"] = 128;
         ["level"] = 10;
      };
      ["name"] = "Soggodon the Breaker";
      ["health"] = 358540;
      ["ignoreFortified"] = true;
      ["count"] = 0;
      ["displayId"] = 98535;
      ["creatureType"] = "Humanoid";
      ["level"] = 62;
      ["scale"] = 1.5;
      ["iconTexture"] = 2103898;
   };
   [27] = {
      ["clones"] = {
         [1] = {
            ["y"] = -380.37685438298;
            ["x"] = 354.12614370227;
            ["sublevel"] = 3;
            ["week"] = {
               [6] = true;
               [2] = true;
               [10] = true;
               [1] = true;
               [5] = true;
               [9] = true;
            };
         };
         [2] = {
            ["y"] = -328.11501272076;
            ["x"] = 320.10638742555;
            ["sublevel"] = 2;
            ["week"] = {
               [11] = true;
               [7] = true;
               [8] = true;
               [3] = true;
               [12] = true;
               [4] = true;
            };
         };
      };
      ["powers"] = {
         [357747] = {
            ["healer"] = true;
         };
         [357609] = {
            ["dps"] = true;
         };
         [357863] = {
            ["tank"] = true;
         };
         [357847] = {
            ["healer"] = true;
         };
         [357706] = {
            ["dps"] = true;
         };
         [357575] = {
            ["tank"] = true;
            ["dps"] = true;
            ["healer"] = true;
         };
         [357604] = {
            ["tank"] = true;
         };
      };
      ["id"] = 179890;
      ["spells"] = {
         [355714] = {};
         [358971] = {};
         [356925] = {};
         [356923] = {};
      };
      ["include"] = {
         ["affix"] = 128;
         ["level"] = 10;
      };
      ["name"] = "Executioner Varruth";
      ["health"] = 336131;
      ["ignoreFortified"] = true;
      ["count"] = 0;
      ["displayId"] = 92418;
      ["creatureType"] = "Humanoid";
      ["level"] = 61;
      ["scale"] = 1.5;
      ["iconTexture"] = 237552;
   };
   [7] = {
      ["clones"] = {
         [1] = {
            ["y"] = -254.72772612126;
            ["x"] = 350.77573249558;
            ["g"] = 8;
            ["sublevel"] = 2;
         };
         [2] = {
            ["y"] = -263.81786157471;
            ["x"] = 346.0069151461;
            ["g"] = 8;
            ["sublevel"] = 2;
         };
         [4] = {
            ["y"] = -452.82818109806;
            ["x"] = 444.35429705769;
            ["g"] = 11;
            ["sublevel"] = 2;
         };
         [8] = {
            ["y"] = -428.77058401298;
            ["x"] = 569.16598936679;
            ["g"] = 14;
            ["sublevel"] = 2;
         };
         [16] = {
            ["sublevel"] = 2;
            ["x"] = 565.7949436188;
            ["g"] = 18;
            ["y"] = -289.88595888437;
         };
         [17] = {
            ["sublevel"] = 2;
            ["x"] = 507.59507820221;
            ["g"] = 19;
            ["y"] = -203.22151537539;
         };
         [9] = {
            ["y"] = -436.15977442959;
            ["x"] = 561.2850389336;
            ["g"] = 14;
            ["sublevel"] = 2;
         };
         [18] = {
            ["sublevel"] = 2;
            ["x"] = 481.05849194255;
            ["g"] = 21;
            ["y"] = -61.006022506303;
         };
         [5] = {
            ["y"] = -498.00407560024;
            ["x"] = 483.07246204882;
            ["g"] = 13;
            ["sublevel"] = 2;
         };
         [10] = {
            ["sublevel"] = 2;
            ["inspiring"] = true;
            ["patrol"] = {};
            ["x"] = 603.10570647994;
            ["g"] = 15;
            ["y"] = -417.54610965942;
         };
         [20] = {
            ["sublevel"] = 2;
            ["x"] = 489.39374765089;
            ["g"] = 21;
            ["y"] = -68.944086791456;
         };
         [21] = {
            ["sublevel"] = 2;
            ["inspiring"] = true;
            ["x"] = 316.80444694554;
            ["g"] = 25;
            ["y"] = -169.51047144141;
         };
         [11] = {
            ["y"] = -414.74942061427;
            ["x"] = 592.04197106779;
            ["g"] = 15;
            ["sublevel"] = 2;
         };
         [22] = {
            ["y"] = -163.66667829221;
            ["x"] = 320.13975973851;
            ["g"] = 25;
            ["sublevel"] = 2;
         };
         [3] = {
            ["y"] = -267.47245608712;
            ["x"] = 353.57208601032;
            ["g"] = 8;
            ["sublevel"] = 2;
         };
         [6] = {
            ["y"] = -487.61156497203;
            ["x"] = 479.24441264402;
            ["g"] = 13;
            ["sublevel"] = 2;
         };
         [12] = {
            ["y"] = -405.94581307112;
            ["x"] = 600.23770917442;
            ["g"] = 15;
            ["sublevel"] = 2;
         };
         [24] = {
            ["y"] = -164.83838697666;
            ["x"] = 325.8358043974;
            ["g"] = 25;
            ["sublevel"] = 2;
         };
         [25] = {
            ["y"] = -170.81616353788;
            ["x"] = 325.19351985972;
            ["g"] = 25;
            ["sublevel"] = 2;
         };
         [13] = {
            ["y"] = -426.3737338136;
            ["x"] = 594.37259605047;
            ["g"] = 15;
            ["sublevel"] = 2;
         };
         [7] = {
            ["sublevel"] = 2;
            ["inspiring"] = true;
            ["x"] = 478.2392160174;
            ["g"] = 13;
            ["y"] = -506.98998031172;
         };
         [14] = {
            ["y"] = -429.38512764061;
            ["x"] = 604.32732738648;
            ["g"] = 15;
            ["sublevel"] = 2;
         };
         [23] = {
            ["y"] = -176.36117027845;
            ["x"] = 320.03487469485;
            ["g"] = 25;
            ["sublevel"] = 2;
         };
         [19] = {
            ["sublevel"] = 2;
            ["x"] = 499.7107092531;
            ["g"] = 21;
            ["y"] = -68.428381301385;
         };
         [15] = {
            ["y"] = -427.29309563544;
            ["x"] = 624.8378507853;
            ["g"] = 16;
            ["sublevel"] = 2;
         };
      };
      ["id"] = 163503;
      ["spells"] = {
         [317661] = {
            ["interruptible"] = true;
         };
      };
      ["characteristics"] = {
         ["Taunt"] = true;
         ["Incapacitate"] = true;
         ["Root"] = true;
         ["Imprison"] = true;
         ["Polymorph"] = true;
         ["Mind Control"] = true;
         ["Sap"] = true;
         ["Disorient"] = true;
         ["Stun"] = true;
         ["Slow"] = true;
         ["Silence"] = true;
         ["Fear"] = true;
      };
      ["count"] = 2;
      ["name"] = "Etherdiver";
      ["displayId"] = 93471;
      ["creatureType"] = "Beast";
      ["level"] = 60;
      ["health"] = "99117";
      ["scale"] = 0.7;
   };
   [14] = {
      ["clones"] = {
         [1] = {
            ["y"] = -250.4758022129;
            ["x"] = 537.15945092138;
            ["sublevel"] = 2;
         };
      };
      ["scale"] = 1;
      ["characteristics"] = {
         ["Taunt"] = true;
      };
      ["spells"] = {
         [324205] = {};
         [324146] = {};
         [338070] = {};
         [334485] = {};
         [324154] = {};
      };
      ["isBoss"] = true;
      ["encounterID"] = 2416;
      ["instanceID"] = 1186;
      ["count"] = 0;
      ["name"] = "Ventunax";
      ["displayId"] = 92193;
      ["creatureType"] = "Mechanical";
      ["level"] = 60;
      ["health"] = "991450";
      ["id"] = 162058;
   };
   [28] = {
      ["clones"] = {
         [13] = {
            ["y"] = -282.24107563867;
            ["x"] = 335.4688143588;
            ["sublevel"] = 3;
         };
         [7] = {
            ["y"] = -443.03281182688;
            ["x"] = 435.33263572618;
            ["sublevel"] = 2;
         };
         [1] = {
            ["y"] = -237.78855141147;
            ["x"] = 489.33455978971;
            ["sublevel"] = 1;
         };
         [2] = {
            ["y"] = -334.98167415589;
            ["x"] = 325.32389747418;
            ["sublevel"] = 2;
         };
         [4] = {
            ["y"] = -67.799994943216;
            ["x"] = 513.12442854621;
            ["sublevel"] = 2;
         };
         [8] = {
            ["y"] = -424.10714439254;
            ["x"] = 557.19577132547;
            ["sublevel"] = 2;
         };
         [9] = {
            ["y"] = -208.09256866599;
            ["x"] = 422.30130052091;
            ["sublevel"] = 3;
         };
         [5] = {
            ["y"] = -244.47626517108;
            ["x"] = 514.80961806257;
            ["sublevel"] = 2;
         };
         [10] = {
            ["y"] = -284.84895902875;
            ["x"] = 382.06529210751;
            ["sublevel"] = 4;
         };
         [3] = {
            ["y"] = -111.54187161461;
            ["x"] = 285.75222249675;
            ["sublevel"] = 2;
         };
         [6] = {
            ["y"] = -295.09060638623;
            ["x"] = 407.47738517317;
            ["sublevel"] = 2;
         };
         [12] = {
            ["y"] = -328.57403008825;
            ["x"] = 435.94362016208;
            ["sublevel"] = 3;
         };
         [11] = {
            ["y"] = -379.23916033672;
            ["x"] = 353.67320143278;
            ["sublevel"] = 3;
         };
      };
      ["include"] = {
         ["affix"] = 130;
         ["level"] = 10;
      };
      ["name"] = "Wo Relic";
      ["modelPosition"] = {
         [1] = 0;
         [2] = 0;
         [3] = 0.6;
      };
      ["id"] = 185683;
      ["spells"] = {
         [368078] = {};
         [366566] = {};
      };
      ["ignoreFortified"] = true;
      ["bonusSpell"] = 368241;
      ["health"] = "33039";
      ["badCreatureModel"] = true;
      ["count"] = 0;
      ["displayId"] = 101046;
      ["creatureType"] = "Mechanical";
      ["level"] = 62;
      ["scale"] = 1;
      ["iconTexture"] = 4335644;
   };
   [23] = {
      ["clones"] = {
         [1] = {
            ["y"] = -314.17061075793;
            ["x"] = 399.37160069492;
            ["sublevel"] = 4;
         };
      };
      ["scale"] = 1.5;
      ["characteristics"] = {
         ["Taunt"] = true;
      };
      ["spells"] = {
         [323943] = {};
         [322999] = {};
         [335817] = {};
         [334625] = {};
         [322818] = {};
         [322817] = {};
         [322908] = {};
      };
      ["isBoss"] = true;
      ["encounterID"] = 2412;
      ["instanceID"] = 0;
      ["count"] = 0;
      ["name"] = "Devos";
      ["displayId"] = 95665;
      ["creatureType"] = "Humanoid";
      ["level"] = 60;
      ["health"] = "1982901";
      ["id"] = 162061;
   };
   [29] = {
      ["clones"] = {
         [13] = {
            ["y"] = -287.86609763069;
            ["x"] = 350.71880484022;
            ["sublevel"] = 3;
         };
         [7] = {
            ["y"] = -449.11387026856;
            ["x"] = 421.81910293;
            ["sublevel"] = 2;
         };
         [1] = {
            ["y"] = -231.65220299726;
            ["x"] = 474.78914421634;
            ["sublevel"] = 1;
         };
         [2] = {
            ["y"] = -319.98167881064;
            ["x"] = 323.32390496127;
            ["sublevel"] = 2;
         };
         [4] = {
            ["y"] = -54.399986741839;
            ["x"] = 509.72429707869;
            ["sublevel"] = 2;
         };
         [8] = {
            ["y"] = -436.96429131747;
            ["x"] = 548.44576110653;
            ["sublevel"] = 2;
         };
         [9] = {
            ["y"] = -204.16399045976;
            ["x"] = 449.08703733085;
            ["sublevel"] = 3;
         };
         [5] = {
            ["y"] = -259.10126870614;
            ["x"] = 515.30962478579;
            ["sublevel"] = 2;
         };
         [10] = {
            ["y"] = -286.09899114242;
            ["x"] = 415.27959471647;
            ["sublevel"] = 4;
         };
         [3] = {
            ["y"] = -118.96120153866;
            ["x"] = 269.78441831651;
            ["sublevel"] = 2;
         };
         [6] = {
            ["y"] = -312.14939411103;
            ["x"] = 418.06563654546;
            ["sublevel"] = 2;
         };
         [12] = {
            ["y"] = -333.199027905;
            ["x"] = 450.19366157008;
            ["sublevel"] = 3;
         };
         [11] = {
            ["y"] = -382.61752613765;
            ["x"] = 333.2678116817;
            ["sublevel"] = 3;
         };
      };
      ["include"] = {
         ["affix"] = 130;
         ["level"] = 10;
      };
      ["health"] = "33039";
      ["modelPosition"] = {
         [1] = 0;
         [2] = 0;
         [3] = 0.75;
      };
      ["id"] = 185685;
      ["spells"] = {
         [368243] = {};
         [366297] = {};
         [366288] = {};
      };
      ["ignoreFortified"] = true;
      ["bonusSpell"] = 368239;
      ["name"] = "Urh Relic";
      ["badCreatureModel"] = true;
      ["count"] = 0;
      ["displayId"] = 105134;
      ["creatureType"] = "Mechanical";
      ["level"] = 62;
      ["scale"] = 1;
      ["iconTexture"] = 4335642;
   };
   [15] = {
      ["clones"] = {
         [1] = {
            ["y"] = -390.46642746448;
            ["x"] = 346.44451570742;
            ["sublevel"] = 3;
         };
         [2] = {
            ["y"] = -372.10952460834;
            ["x"] = 370.54276753915;
            ["g"] = 26;
            ["sublevel"] = 3;
         };
         [4] = {
            ["y"] = -281.84858823529;
            ["x"] = 399.19225798495;
            ["g"] = 30;
            ["sublevel"] = 3;
         };
         [3] = {
            ["y"] = -276.10243965022;
            ["x"] = 375.11288052143;
            ["g"] = 28;
            ["sublevel"] = 3;
         };
      };
      ["id"] = 168681;
      ["spells"] = {
         [323740] = {};
         [328203] = {};
         [328217] = {};
         [323739] = {};
      };
      ["characteristics"] = {
         ["Taunt"] = true;
      };
      ["count"] = 6;
      ["name"] = "Forsworn Helion";
      ["displayId"] = 94919;
      ["creatureType"] = "Humanoid";
      ["level"] = 60;
      ["health"] = "264312";
      ["scale"] = 1;
   };
};
