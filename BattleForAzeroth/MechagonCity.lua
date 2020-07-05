local MDT = MDT
local L = MDT.L
local dungeonIndex = 26
MDT.mapInfo[dungeonIndex] = {
    viewportPositionOverrides =
    {
        [3] = {
            zoomScale = 1.5999999046326;
            horizontalPan = 202.69757113491;
            verticalPan = 126.55720322784;
        };
        [4] = {
            zoomScale = 1.2999999523163;
            horizontalPan = 105.50581163535;
            verticalPan = 109.22701167556;
        };
    };
};

MDT.dungeonTotalCount[dungeonIndex] = {normal=160,teeming=192,teemingEnabled=true}
MDT.mapPOIs[dungeonIndex] = {
    [1] = {
        [1] = {
            ["y"] = -344.0717104272;
            ["x"] = 309.61613296983;
            ["connectionIndex"] = 1;
            ["target"] = 3;
            ["type"] = "mapLink";
            ["template"] = "MapLinkPinTemplate";
            ["direction"] = -1;
        };
    };
    [4] = {
        [1] = {
            ["y"] = -434.64189702298;
            ["x"] = 518.05941971039;
            ["connectionIndex"] = 2;
            ["target"] = 3;
            ["type"] = "mapLink";
            ["template"] = "MapLinkPinTemplate";
            ["direction"] = 2;
        };
        [2] = {
            ["npcId"] = 161244;
            ["type"] = "nyalothaSpire";
            ["index"] = 2;
            ["y"] = -196.78696311057;
            ["x"] = 583.95261802562;
            ["tooltipText"] = L["Defiled Spire of Ny'alotha"];
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
        [3] = {
            ["npcId"] = 161241;
            ["type"] = "nyalothaSpire";
            ["index"] = 3;
            ["y"] = -316.04973510387;
            ["x"] = 518.79281541031;
            ["tooltipText"] = L["Cursed Spire of Ny'alotha"];
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
        [4] = {
            ["npcId"] = 161124;
            ["type"] = "nyalothaSpire";
            ["index"] = 4;
            ["y"] = -482.69635226266;
            ["x"] = 261.46012993765;
            ["tooltipText"] = L["Brutal Spire of Ny'alotha"];
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
        [5] = {
            ["npcId"] = 161124;
            ["type"] = "nyalothaSpire";
            ["index"] = 5;
            ["y"] = -314.41684201658;
            ["x"] = 521.12234499945;
            ["tooltipText"] = L["Brutal Spire of Ny'alotha"];
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
            ["npcId"] = 161241;
            ["type"] = "nyalothaSpire";
            ["index"] = 6;
            ["y"] = -482.76939866107;
            ["x"] = 263.04799966455;
            ["tooltipText"] = L["Cursed Spire of Ny'alotha"];
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
    };
    [3] = {
        [1] = {
            ["y"] = -444.44517818302;
            ["x"] = 466.94234514817;
            ["connectionIndex"] = 1;
            ["target"] = 1;
            ["type"] = "mapLink";
            ["template"] = "MapLinkPinTemplate";
            ["direction"] = 1;
        };
        [2] = {
            ["y"] = -153.56451426492;
            ["x"] = 400.22732136754;
            ["connectionIndex"] = 2;
            ["target"] = 4;
            ["type"] = "mapLink";
            ["template"] = "MapLinkPinTemplate";
            ["direction"] = -2;
        };
        [3] = {
            ["npcId"] = 161243;
            ["type"] = "nyalothaSpire";
            ["index"] = 1;
            ["y"] = -387.01163878014;
            ["x"] = 427.29831246484;
            ["tooltipText"] = L["Entropic Spire of Ny'alotha"];
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
    };
};

MDT.dungeonEnemies[dungeonIndex] = {
    [1] = {
        ["clones"] = {
            [1] = {
                ["y"] = -387.72142697985;
                ["x"] = 415.49306032303;
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
                ["sublevel"] = 3;
            };
        };
        ["id"] = 161243;
        ["scale"] = 1.4;
        ["spells"] = {
            [314478] = {};
            [314531] = {};
            [314477] = {};
            [314397] = {};
            [314483] = {};
        };
        ["stealthDetect"] = true;
        ["name"] = "Samh'rek, Beckoner of Chaos";
        ["level"] = 122;
        ["teemingCount"] = 6;
        ["count"] = 4;
        ["displayId"] = 90742;
        ["creatureType"] = "Aberration";
        ["corrupted"] = true;
        ["health"] = 2151786;
        ["characteristics"] = {
            ["Taunt"] = true;
        };
    };
    [2] = {
        ["clones"] = {
            [1] = {
                ["y"] = -474.23647104838;
                ["x"] = 270.77807786568;
                ["week"] = {
                    [1] = true;
                    [2] = true;
                    [5] = true;
                    [6] = true;
                    [9] = true;
                    [10] = true;
                };
                ["sublevel"] = 4;
            };
            [2] = {
                ["y"] = -327.57515030846;
                ["x"] = 513.87414677701;
                ["week"] = {
                    [11] = true;
                    [7] = true;
                    [8] = true;
                    [3] = true;
                    [12] = true;
                    [4] = true;
                };
                ["sublevel"] = 4;
            };
        };
        ["characteristics"] = {
            ["Taunt"] = true;
        };
        ["id"] = 161124;
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
        ["health"] = 2305485;
        ["displayId"] = 89415;
        ["creatureType"] = "Aberration";
        ["level"] = 122;
        ["name"] = "Urg'roth, Breaker of Heroes";
        ["count"] = 4;
    };
    [4] = {
        ["clones"] = {
            [1] = {
                ["y"] = -180.41171990004;
                ["x"] = 592.22743961573;
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
                ["sublevel"] = 4;
            };
        };
        ["characteristics"] = {
            ["Taunt"] = true;
        };
        ["id"] = 161244;
        ["spells"] = {
            [314566] = {};
            [314592] = {};
            [314397] = {};
            [314565] = {};
        };
        ["stealthDetect"] = true;
        ["scale"] = 1.4;
        ["level"] = 122;
        ["teemingCount"] = 6;
        ["count"] = 4;
        ["displayId"] = 92229;
        ["creatureType"] = "Aberration";
        ["corrupted"] = true;
        ["health"] = 2151786;
        ["name"] = "Blood of the Corruptor";
    };
    [8] = {
        ["clones"] = {
            [6] = {
                ["sublevel"] = 4;
                ["x"] = 606.89150891813;
                ["teeming"] = true;
                ["g"] = 12;
                ["y"] = -185.02700485576;
            };
            [2] = {
                ["y"] = -408.05752691365;
                ["x"] = 460.05502978644;
                ["g"] = 9;
                ["sublevel"] = 4;
            };
            [3] = {
                ["y"] = -203.897120688;
                ["x"] = 596.16623437765;
                ["g"] = 12;
                ["sublevel"] = 4;
            };
            [1] = {
                ["y"] = -417.70447330755;
                ["x"] = 452.54473391855;
                ["g"] = 9;
                ["sublevel"] = 4;
            };
            [4] = {
                ["y"] = -446.50406505997;
                ["x"] = 283.88727151756;
                ["g"] = 13;
                ["sublevel"] = 4;
            };
            [5] = {
                ["y"] = -299.74609894492;
                ["x"] = 307.06091955626;
                ["g"] = 14;
                ["sublevel"] = 4;
            };
        };
        ["scale"] = 1;
        ["spells"] = {
            [293827] = {};
            [293854] = {};
        };
        ["id"] = 144294;
        ["health"] = 768495;
        ["count"] = 4;
        ["displayId"] = 91170;
        ["creatureType"] = "Humanoid";
        ["level"] = 120;
        ["name"] = "Mechagon Tinkerer";
        ["characteristics"] = {
            ["Stun"] = true;
            ["Polymorph"] = true;
        };
    };
    [16] = {
        ["clones"] = {
            [1] = {
                ["y"] = -386.30433113779;
                ["x"] = 362.18281730758;
                ["sublevel"] = 3;
            };
            [2] = {
                ["y"] = -381.92194523713;
                ["x"] = 457.90817655344;
                ["sublevel"] = 3;
            };
            [4] = {
                ["sublevel"] = 3;
                ["x"] = 564.88785899073;
                ["teeming"] = true;
                ["g"] = 5;
                ["y"] = -330.35849621681;
            };
            [3] = {
                ["y"] = -327.43196399115;
                ["x"] = 545.88667894292;
                ["g"] = 5;
                ["sublevel"] = 3;
            };
        };
        ["id"] = 144293;
        ["spells"] = {
            [294290] = {};
            [294291] = {};
            [294324] = {};
        };
        ["scale"] = 1;
        ["count"] = 6;
        ["name"] = "Waste Processing Unit";
        ["displayId"] = 92177;
        ["creatureType"] = "Mechanical";
        ["level"] = 121;
        ["health"] = 1229592;
        ["characteristics"] = {
            ["Taunt"] = true;
            ["Stun"] = true;
        };
    };
    [17] = {
        ["clones"] = {
            [13] = {
                ["y"] = -304.98565488565;
                ["x"] = 544.44718769335;
                ["g"] = 6;
                ["sublevel"] = 3;
            };
            [7] = {
                ["y"] = -366.8408980967;
                ["x"] = 523.00546261047;
                ["g"] = 4;
                ["sublevel"] = 3;
            };
            [1] = {
                ["y"] = -373.14504241806;
                ["x"] = 476.58863517454;
                ["g"] = 3;
                ["sublevel"] = 3;
            };
            [2] = {
                ["y"] = -379.9856887912;
                ["x"] = 480.97216346021;
                ["g"] = 3;
                ["sublevel"] = 3;
            };
            [4] = {
                ["y"] = -374.01261308778;
                ["x"] = 486.18292792546;
                ["g"] = 3;
                ["sublevel"] = 3;
            };
            [8] = {
                ["y"] = -356.11194358718;
                ["x"] = 530.64769619118;
                ["g"] = 4;
                ["sublevel"] = 3;
            };
            [9] = {
                ["y"] = -364.20479692043;
                ["x"] = 531.25302333858;
                ["g"] = 4;
                ["sublevel"] = 3;
            };
            [5] = {
                ["y"] = -379.5492887157;
                ["x"] = 489.23554166131;
                ["g"] = 3;
                ["sublevel"] = 3;
            };
            [10] = {
                ["y"] = -316.68566636406;
                ["x"] = 540.59579527792;
                ["g"] = 6;
                ["sublevel"] = 3;
            };
            [14] = {
                ["y"] = -306.48814632018;
                ["x"] = 553.0311229253;
                ["g"] = 6;
                ["sublevel"] = 3;
            };
            [3] = {
                ["y"] = -366.64991773679;
                ["x"] = 483.44108508101;
                ["g"] = 3;
                ["sublevel"] = 3;
            };
            [6] = {
                ["y"] = -360.81253713167;
                ["x"] = 517.90296147965;
                ["g"] = 4;
                ["sublevel"] = 3;
            };
            [12] = {
                ["y"] = -309.0844802683;
                ["x"] = 537.65021591515;
                ["g"] = 6;
                ["sublevel"] = 3;
            };
            [11] = {
                ["y"] = -314.14084231796;
                ["x"] = 548.88831485568;
                ["g"] = 6;
                ["sublevel"] = 3;
            };
        };
        ["id"] = 144301;
        ["spells"] = {
            [294349] = {};
        };
        ["scale"] = 1;
        ["count"] = 1;
        ["displayId"] = 92217;
        ["creatureType"] = "Elemental";
        ["level"] = 120;
        ["name"] = "Living Waste";
        ["health"] = 76850;
    };
    [9] = {
        ["clones"] = {
            [2] = {
                ["y"] = -450.49903723392;
                ["x"] = 275.4461942786;
                ["g"] = 13;
                ["sublevel"] = 4;
            };
            [3] = {
                ["y"] = -455.61225024665;
                ["x"] = 287.37702464163;
                ["g"] = 13;
                ["sublevel"] = 4;
            };
            [1] = {
                ["y"] = -196.75146056589;
                ["x"] = 596.35310107265;
                ["g"] = 12;
                ["sublevel"] = 4;
            };
            [4] = {
                ["y"] = -305.46689987613;
                ["x"] = 300.7164362048;
                ["g"] = 14;
                ["sublevel"] = 4;
            };
            [5] = {
                ["sublevel"] = 4;
                ["x"] = 280.62386541069;
                ["teeming"] = true;
                ["g"] = 13;
                ["y"] = -455.35139934526;
            };
        };
        ["scale"] = 1;
        ["spells"] = {
            [293670] = {};
        };
        ["id"] = 144299;
        ["health"] = 768495;
        ["count"] = 4;
        ["displayId"] = 91183;
        ["creatureType"] = "Humanoid";
        ["level"] = 120;
        ["name"] = "Workshop Defender";
        ["characteristics"] = {
            ["Stun"] = true;
            ["Polymorph"] = true;
        };
    };
    [18] = {
        ["clones"] = {
            [1] = {
                ["y"] = -383.11225682513;
                ["x"] = 151.30590992095;
                ["g"] = 15;
                ["sublevel"] = 4;
            };
        };
        ["id"] = 144249;
        ["scale"] = 1;
        ["spells"] = {
            [292264] = {};
            [292267] = {};
            [292290] = {};
            [283551] = {};
        };
        ["isBoss"] = true;
        ["encounterID"] = 2331;
        ["instanceID"] = 1178;
        ["count"] = 0;
        ["name"] = "Omega Buster";
        ["displayId"] = 90998;
        ["creatureType"] = "Mechanical";
        ["level"] = 122;
        ["health"] = 4610970;
        ["characteristics"] = {
            ["Taunt"] = true;
        };
    };
    [5] = {
        ["clones"] = {
            [1] = {
                ["y"] = -406.34323129692;
                ["x"] = 435.06247431919;
                ["sublevel"] = 4;
            };
        };
        ["scale"] = 1.4;
        ["spells"] = {
            [296348] = {};
            [295169] = {};
            [293986] = {};
            [294015] = {};
            [295170] = {};
            [295183] = {};
        };
        ["id"] = 151476;
        ["health"] = 1921238;
        ["name"] = "Blastatron X-80";
        ["displayId"] = 90712;
        ["creatureType"] = "Mechanical";
        ["level"] = 121;
        ["count"] = 8;
        ["characteristics"] = {
            ["Taunt"] = true;
        };
    };
    [10] = {
        ["clones"] = {
            [1] = {
                ["y"] = -190.10916220199;
                ["x"] = 601.18387765416;
                ["g"] = 12;
                ["sublevel"] = 4;
            };
            [2] = {
                ["y"] = -295.46130024962;
                ["x"] = 291.76409208577;
                ["g"] = 14;
                ["sublevel"] = 4;
            };
            [3] = {
                ["y"] = -305.11581470697;
                ["x"] = 293.16840262958;
                ["g"] = 14;
                ["sublevel"] = 4;
            };
        };
        ["scale"] = 1;
        ["spells"] = {
            [293930] = {};
            [293729] = {};
        };
        ["id"] = 144295;
        ["health"] = 768495;
        ["count"] = 4;
        ["displayId"] = 91171;
        ["creatureType"] = "Humanoid";
        ["level"] = 120;
        ["name"] = "Mechagon Mechanic";
        ["characteristics"] = {
            ["Stun"] = true;
            ["Polymorph"] = true;
        };
    };
    [20] = {
        ["clones"] = {
            [1] = {
                ["y"] = -367.61262040707;
                ["x"] = 230.69550162853;
                ["g"] = 1;
                ["sublevel"] = 1;
            };
            [2] = {
                ["y"] = -389.70524704043;
                ["x"] = 239.63705516806;
                ["g"] = 1;
                ["sublevel"] = 1;
            };
        };
        ["id"] = 151659;
        ["spells"] = {
            [294103] = {};
            [294128] = {};
        };
        ["scale"] = 1.5;
        ["count"] = 4;
        ["displayId"] = 91228;
        ["creatureType"] = "Mechanical";
        ["level"] = 120;
        ["name"] = "Rocket Tonk";
        ["health"] = 503570;
    };
    [21] = {
        ["clones"] = {
            [1] = {
                ["y"] = -345.90929412611;
                ["x"] = 237.23806882906;
                ["g"] = 1;
                ["sublevel"] = 1;
            };
            [2] = {
                ["y"] = -396.32696201739;
                ["x"] = 261.35754205452;
                ["g"] = 1;
                ["sublevel"] = 1;
            };
        };
        ["id"] = 151658;
        ["spells"] = {
            [294061] = {};
            [294064] = {};
            [294073] = {};
        };
        ["scale"] = 1.5;
        ["count"] = 4;
        ["displayId"] = 91229;
        ["creatureType"] = "Mechanical";
        ["level"] = 120;
        ["name"] = "Strider Tonk";
        ["health"] = 503570;
    };
    [11] = {
        ["clones"] = {
            [1] = {
                ["y"] = -270.03016453617;
                ["x"] = 549.93643742759;
                ["sublevel"] = 4;
            };
        };
        ["id"] = 144248;
        ["spells"] = {
            [285454] = {};
            [285440] = {};
        };
        ["isBoss"] = true;
        ["encounterID"] = 2348;
        ["instanceID"] = 1178;
        ["scale"] = 1;
        ["count"] = 0;
        ["displayId"] = 23397;
        ["creatureType"] = "Mechanical";
        ["level"] = 122;
        ["name"] = "Head Machinist Sparkflux";
        ["health"] = 5379465;
    };
    [22] = {
        ["clones"] = {
            [1] = {
                ["y"] = -417.41680355738;
                ["x"] = 213.62890398115;
                ["g"] = 2;
                ["sublevel"] = 1;
            };
        };
        ["id"] = 144244;
        ["spells"] = {
            [285344] = {};
            [305393] = {};
            [282801] = {};
            [285020] = {};
            [285377] = {};
        };
        ["isBoss"] = true;
        ["encounterID"] = 2336;
        ["instanceID"] = 1178;
        ["scale"] = 1.5;
        ["count"] = 0;
        ["displayId"] = 91216;
        ["creatureType"] = "Mechanical";
        ["level"] = 122;
        ["name"] = "The Platinum Pummeler";
        ["health"] = 2014280;
    };
    [3] = {
        ["clones"] = {
            [1] = {
                ["y"] = -330.0865069582;
                ["x"] = 509.35379102691;
                ["week"] = {
                    [1] = true;
                    [2] = true;
                    [5] = true;
                    [6] = true;
                    [9] = true;
                    [10] = true;
                };
                ["sublevel"] = 4;
            };
            [2] = {
                ["y"] = -470.97178097464;
                ["x"] = 272.2534435685;
                ["week"] = {
                    [11] = true;
                    [7] = true;
                    [8] = true;
                    [3] = true;
                    [12] = true;
                    [4] = true;
                };
                ["sublevel"] = 4;
            };
        };
        ["health"] = 1998087;
        ["scale"] = 1.4;
        ["spells"] = {
            [314463] = {};
            [314397] = {};
            [314411] = {};
            [314406] = {};
            [314467] = {};
        };
        ["stealthDetect"] = true;
        ["name"] = "Voidweaver Mal'thir";
        ["corrupted"] = true;
        ["teemingCount"] = 6;
        ["count"] = 4;
        ["displayId"] = 91910;
        ["creatureType"] = "Beast";
        ["level"] = 122;
        ["id"] = 161241;
        ["characteristics"] = {
            ["Taunt"] = true;
        };
    };
    [6] = {
        ["clones"] = {
            [1] = {
                ["y"] = -421.66419640937;
                ["x"] = 499.70337825139;
                ["g"] = 8;
                ["sublevel"] = 4;
            };
            [2] = {
                ["y"] = -430.63364694467;
                ["x"] = 496.86060747485;
                ["g"] = 8;
                ["sublevel"] = 4;
            };
            [4] = {
                ["y"] = -435.51047744238;
                ["x"] = 484.6561799684;
                ["g"] = 8;
                ["sublevel"] = 4;
            };
            [8] = {
                ["y"] = -427.34976261929;
                ["x"] = 490.17023050112;
                ["g"] = 8;
                ["sublevel"] = 4;
            };
            [16] = {
                ["y"] = -350.51236104974;
                ["x"] = 508.90528020342;
                ["g"] = 11;
                ["sublevel"] = 4;
            };
            [17] = {
                ["y"] = -356.92822420273;
                ["x"] = 514.00022987796;
                ["g"] = 11;
                ["sublevel"] = 4;
            };
            [9] = {
                ["y"] = -440.55886808142;
                ["x"] = 478.16193916255;
                ["g"] = 8;
                ["sublevel"] = 4;
            };
            [5] = {
                ["y"] = -443.69571816028;
                ["x"] = 487.30300371032;
                ["g"] = 8;
                ["sublevel"] = 4;
            };
            [10] = {
                ["y"] = -420.92899835806;
                ["x"] = 487.54800405373;
                ["g"] = 8;
                ["sublevel"] = 4;
            };
            [11] = {
                ["y"] = -413.68897609184;
                ["x"] = 486.03961528088;
                ["g"] = 8;
                ["sublevel"] = 4;
            };
            [3] = {
                ["y"] = -436.90737631667;
                ["x"] = 492.84152392959;
                ["g"] = 8;
                ["sublevel"] = 4;
            };
            [6] = {
                ["y"] = -428.52550114086;
                ["x"] = 484.67447267549;
                ["g"] = 8;
                ["sublevel"] = 4;
            };
            [12] = {
                ["y"] = -432.47763924175;
                ["x"] = 477.97117706412;
                ["g"] = 8;
                ["sublevel"] = 4;
            };
            [13] = {
                ["y"] = -345.60610751627;
                ["x"] = 500.60243944338;
                ["g"] = 11;
                ["sublevel"] = 4;
            };
            [7] = {
                ["y"] = -419.85584273725;
                ["x"] = 493.51113606412;
                ["g"] = 8;
                ["sublevel"] = 4;
            };
            [14] = {
                ["y"] = -344.09650599496;
                ["x"] = 510.79229020326;
                ["g"] = 11;
                ["sublevel"] = 4;
            };
            [15] = {
                ["y"] = -352.96549186558;
                ["x"] = 499.84760628993;
                ["g"] = 11;
                ["sublevel"] = 4;
            };
        };
        ["id"] = 144300;
        ["scale"] = 0.7;
        ["count"] = 0;
        ["name"] = "Mechagon Citizen";
        ["displayId"] = 91167;
        ["creatureType"] = "Mechanical";
        ["level"] = 120;
        ["health"] = 192124;
        ["characteristics"] = {
            ["Stun"] = true;
        };
    };
    [12] = {
        ["clones"] = {
            [1] = {
                ["y"] = -236.41429530968;
                ["x"] = 501.59536419878;
                ["sublevel"] = 4;
            };
            [2] = {
                ["y"] = -187.966455098;
                ["x"] = 440.44634915076;
                ["sublevel"] = 4;
            };
            [3] = {
                ["y"] = -214.30605838935;
                ["x"] = 471.93328013387;
                ["sublevel"] = 4;
                ["teeming"] = true;
            };
        };
        ["id"] = 144296;
        ["spells"] = {
            [293986] = {};
            [296348] = {};
            [294015] = {};
        };
        ["scale"] = 1;
        ["count"] = 5;
        ["displayId"] = 90710;
        ["creatureType"] = "Mechanical";
        ["level"] = 121;
        ["name"] = "Spider Tank";
        ["health"] = 1229592;
    };
    [24] = {
        ["clones"] = {
            [1] = {
                ["y"] = -238.70347446204;
                ["x"] = 420.53647095542;
                ["sublevel"] = 3;
            };
        };
        ["id"] = 144246;
        ["spells"] = {
            [291973] = {};
            [294929] = {};
            [291949] = {};
            [291972] = {};
            [291946] = {};
            [291922] = {};
            [292035] = {};
        };
        ["isBoss"] = true;
        ["encounterID"] = 2339;
        ["instanceID"] = 1178;
        ["scale"] = 1;
        ["count"] = 0;
        ["displayId"] = 90775;
        ["creatureType"] = "Mechanical";
        ["level"] = 122;
        ["name"] = "K.U.-J.0.";
        ["health"] = 4918368;
    };
    [25] = {
        ["clones"] = {
            [1] = {
                ["y"] = -421.83846267556;
                ["x"] = 477.5225723606;
                ["g"] = 8;
                ["sublevel"] = 4;
            };
        };
        ["scale"] = 1;
        ["id"] = 151325;
        ["name"] = "Alarm-o-Bot";
        ["displayId"] = 90874;
        ["creatureType"] = "Mechanical";
        ["level"] = 120;
        ["health"] = 38425;
        ["count"] = 0;
    };
    [13] = {
        ["clones"] = {
            [2] = {
                ["y"] = -406.72989326751;
                ["x"] = 297.90466440177;
                ["patrol"] = {
                    [6] = {
                        ["y"] = -327.18854897621;
                        ["x"] = 297.50283730687;
                    };
                    [2] = {
                        ["y"] = -431.93310938028;
                        ["x"] = 286.26100243489;
                    };
                    [8] = {
                        ["y"] = -378.90164926768;
                        ["x"] = 300.04098072629;
                    };
                    [3] = {
                        ["y"] = -406.72989326751;
                        ["x"] = 297.90466440177;
                    };
                    [1] = {
                        ["y"] = -406.72989326751;
                        ["x"] = 297.90466440177;
                    };
                    [4] = {
                        ["y"] = -378.90164926768;
                        ["x"] = 300.04098072629;
                    };
                    [5] = {
                        ["y"] = -357.04902805453;
                        ["x"] = 300.90360986371;
                    };
                    [7] = {
                        ["y"] = -357.04902805453;
                        ["x"] = 300.90360986371;
                    };
                };
                ["sublevel"] = 4;
            };
            [3] = {
                ["y"] = -364.25047627049;
                ["x"] = 313.27374351498;
                ["patrol"] = {
                    [6] = {
                        ["y"] = -394.79246970652;
                        ["x"] = 310.17584582341;
                    };
                    [2] = {
                        ["y"] = -347.28133549391;
                        ["x"] = 313.40512735786;
                    };
                    [8] = {
                        ["y"] = -394.79246970652;
                        ["x"] = 310.17584582341;
                    };
                    [3] = {
                        ["y"] = -325.60759964757;
                        ["x"] = 311.03286477058;
                    };
                    [1] = {
                        ["y"] = -364.25047627049;
                        ["x"] = 313.27374351498;
                    };
                    [4] = {
                        ["y"] = -347.28133549391;
                        ["x"] = 313.40512735786;
                    };
                    [5] = {
                        ["y"] = -364.25047627049;
                        ["x"] = 313.27374351498;
                    };
                    [7] = {
                        ["y"] = -440.70032748029;
                        ["x"] = 296.44056787358;
                    };
                };
                ["sublevel"] = 4;
            };
            [1] = {
                ["y"] = -441.33086427245;
                ["x"] = 429.94298772705;
                ["g"] = 10;
                ["sublevel"] = 4;
            };
            [4] = {
                ["y"] = -291.74184239816;
                ["x"] = 281.84583501642;
                ["g"] = 14;
                ["sublevel"] = 4;
            };
            [5] = {
                ["y"] = -288.03820044584;
                ["x"] = 302.07848946789;
                ["g"] = 14;
                ["sublevel"] = 4;
            };
        };
        ["scale"] = 1;
        ["spells"] = {
            [297133] = {};
            [297128] = {};
            [294195] = {};
            [297127] = {};
        };
        ["stealthDetect"] = true;
        ["id"] = 144298;
        ["name"] = "Defense Bot Mk III";
        ["displayId"] = 90855;
        ["creatureType"] = "Mechanical";
        ["level"] = 121;
        ["health"] = 1229592;
        ["count"] = 6;
    };
    [26] = {
        ["clones"] = {
            [1] = {
                ["y"] = -410.07293451348;
                ["x"] = 466.40975979746;
                ["g"] = 9;
                ["sublevel"] = 4;
            };
            [2] = {
                ["y"] = -424.54963316643;
                ["x"] = 459.82529834771;
                ["g"] = 9;
                ["sublevel"] = 4;
            };
        };
        ["id"] = 144303;
        ["spells"] = {
            [294107] = {};
        };
        ["scale"] = 1;
        ["count"] = 4;
        ["name"] = "G.U.A.R.D.";
        ["displayId"] = 68856;
        ["creatureType"] = "Mechanical";
        ["level"] = 120;
        ["health"] = 768495;
        ["characteristics"] = {
            ["Stun"] = true;
        };
    };
    [7] = {
        ["clones"] = {
            [1] = {
                ["y"] = -447.10383393789;
                ["x"] = 438.24199819465;
                ["g"] = 10;
                ["sublevel"] = 4;
            };
            [2] = {
                ["y"] = -431.77408026805;
                ["x"] = 432.89392785131;
                ["g"] = 10;
                ["sublevel"] = 4;
            };
            [4] = {
                ["y"] = -193.33828230687;
                ["x"] = 611.47784039704;
                ["g"] = 12;
                ["sublevel"] = 4;
            };
            [3] = {
                ["y"] = -209.62623239455;
                ["x"] = 604.72424938609;
                ["g"] = 12;
                ["sublevel"] = 4;
            };
        };
        ["scale"] = 1;
        ["spells"] = {
            [294195] = {};
        };
        ["id"] = 151649;
        ["health"] = 806920;
        ["count"] = 4;
        ["displayId"] = 91349;
        ["creatureType"] = "Mechanical";
        ["level"] = 120;
        ["name"] = "Defense Bot Mk I";
        ["characteristics"] = {
            ["Stun"] = true;
        };
    };
    [14] = {
        ["clones"] = {
            [1] = {
                ["y"] = -362.16512816792;
                ["x"] = 179.1418279613;
                ["g"] = 15;
                ["sublevel"] = 4;
            };
        };
        ["id"] = 150396;
        ["scale"] = 1;
        ["spells"] = {
            [291928] = {};
            [291613] = {};
            [291878] = {};
            [291865] = {};
            [291626] = {};
        };
        ["isBoss"] = true;
        ["encounterID"] = 2331;
        ["instanceID"] = 1178;
        ["count"] = 0;
        ["name"] = "Aerial Unit R-21/X";
        ["displayId"] = 90547;
        ["creatureType"] = "Mechanical";
        ["level"] = 122;
        ["health"] = 3688776;
        ["characteristics"] = {
            ["Taunt"] = true;
        };
    };
    [23] = {
        ["clones"] = {
            [1] = {
                ["y"] = -368.75253591347;
                ["x"] = 195.09111527009;
                ["g"] = 2;
                ["sublevel"] = 1;
            };
        };
        ["id"] = 145185;
        ["spells"] = {
            [283421] = {};
            [283640] = {};
            [283565] = {};
            [285152] = {};
            [283422] = {};
            [285468] = {};
            [285388] = {};
        };
        ["isBoss"] = true;
        ["encounterID"] = 2336;
        ["instanceID"] = 1178;
        ["scale"] = 1.5;
        ["count"] = 0;
        ["displayId"] = 91879;
        ["creatureType"] = "Mechanical";
        ["level"] = 122;
        ["name"] = "Gnomercy 4.U.";
        ["health"] = 2014280;
    };
    [19] = {
        ["clones"] = {
            [1] = {
                ["y"] = -374.2151489309;
                ["x"] = 269.53200910371;
                ["g"] = 1;
                ["sublevel"] = 1;
            };
            [2] = {
                ["y"] = -354.32391026756;
                ["x"] = 259.27553305712;
                ["g"] = 1;
                ["sublevel"] = 1;
            };
        };
        ["id"] = 151657;
        ["spells"] = {
            [301088] = {};
        };
        ["scale"] = 1.5;
        ["count"] = 4;
        ["displayId"] = 21209;
        ["creatureType"] = "Mechanical";
        ["level"] = 120;
        ["name"] = "Bomb Tonk";
        ["health"] = 302142;
    };
    [15] = {
        ["clones"] = {
            [1] = {
                ["y"] = -353.06278997051;
                ["x"] = 522.29246790592;
                ["g"] = 4;
                ["sublevel"] = 3;
            };
            [2] = {
                ["y"] = -282.52821719069;
                ["x"] = 538.95927907908;
                ["g"] = 7;
                ["sublevel"] = 3;
            };
            [3] = {
                ["sublevel"] = 3;
                ["x"] = 527.58760397305;
                ["teeming"] = true;
                ["g"] = 7;
                ["y"] = -289.16189808614;
            };
        };
        ["id"] = 151773;
        ["spells"] = {
            [294107] = {};
            [294180] = {};
        };
        ["scale"] = 1;
        ["count"] = 4;
        ["name"] = "Junkyard D.0.G.";
        ["displayId"] = 90511;
        ["creatureType"] = "Mechanical";
        ["level"] = 120;
        ["health"] = 768495;
        ["characteristics"] = {
            ["Taunt"] = true;
        };
    };
};

