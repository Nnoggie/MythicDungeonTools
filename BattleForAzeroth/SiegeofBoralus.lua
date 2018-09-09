local dungeonIndex = 19
local nerfMultiplier = 1
MethodDungeonTools.dungeonTotalCount[dungeonIndex] = {normal=319,teeming=304,teemingEnabled=true}

MethodDungeonTools.mapPOIs[dungeonIndex] = {
    [1] = {
        [1] = {
            ["y"] = -112.09388221952;
            ["x"] = 526.6887930726;
            ["template"] = "DeathReleasePinTemplate";
            ["graveyardDescription"] = "Unlocks after killing Seargeant Bainbridge";
            ["type"] = "graveyard";
        };
        [2] = {
            ["y"] = -96.177558505241;
            ["x"] = 634.18715497149;
            ["template"] = "DeathReleasePinTemplate";
            ["graveyardDescription"] = "";
            ["type"] = "graveyard";
        };
        [3] = {
            ["y"] = -334.61016080079;
            ["x"] = 432.0393310099;
            ["template"] = "DeathReleasePinTemplate";
            ["graveyardDescription"] = "Unlocks after killing Dread Captain Lockwood";
            ["type"] = "graveyard";
        };
    };
};



MethodDungeonTools.dungeonEnemies[dungeonIndex] = {
    [27] = {
        ["clones"] = {
            [1] = {
                ["y"] = -399.18450962432;
                ["x"] = 466.48506423415;
                ["g"] = 40;
                ["sublevel"] = 1;
            };
            [2] = {
                ["sublevel"] = 1;
                ["x"] = 460.11408997895;
                ["y"] = -408.78128372814;
                ["g"] = 40;
                ["infested"] = {
                    [1] = true;
                };
            };
        };
        ["scale"] = 0.7;
        ["spells"] = {
            [277564] = {};
            [209859] = {};
            [277242] = {};
            [272588] = {};
        };
        ["characteristics"] = {
            ["Taunt"] = true;
            ["Incapacitate"] = true;
            ["Root"] = true;
            ["Polymorph"] = true;
            ["Disorient"] = true;
            ["Sap"] = true;
            ["Stun"] = true;
            ["Slow"] = true;
            ["Silence"] = true;
            ["Fear"] = true;
        };
        ["count"] = 4;
        ["name"] = "Bilge Rat Cutthroat";
        ["displayId"] = 80319;
        ["creatureType"] = "Humanoid";
        ["level"] = 120;
        ["health"] = 235456;
        ["id"] = 137511;
    };
    [2] = {
        ["clones"] = {
            [6] = {
                ["y"] = -108.49841657382;
                ["x"] = 580.21555981137;
                ["g"] = 2;
                ["sublevel"] = 1;
            };
            [2] = {
                ["sublevel"] = 1;
                ["x"] = 617.86235023493;
                ["y"] = -95.255434327295;
                ["g"] = 1;
                ["infested"] = {
                    [1] = true;
                };
            };
            [8] = {
                ["sublevel"] = 1;
                ["x"] = 512.22634355934;
                ["y"] = -117.92706622296;
                ["g"] = 10;
                ["infested"] = {
                    [1] = true;
                };
            };
            [3] = {
                ["y"] = -99.938963809923;
                ["x"] = 618.11550723705;
                ["g"] = 1;
                ["sublevel"] = 1;
            };
            [1] = {
                ["y"] = -90.192147612201;
                ["x"] = 618.62184297058;
                ["g"] = 1;
                ["sublevel"] = 1;
            };
            [4] = {
                ["y"] = -100.01741254831;
                ["x"] = 582.74720588507;
                ["g"] = 2;
                ["sublevel"] = 1;
            };
            [5] = {
                ["sublevel"] = 1;
                ["x"] = 581.48139914518;
                ["y"] = -103.94146015993;
                ["g"] = 2;
                ["infested"] = {
                    [1] = true;
                };
            };
            [7] = {
                ["y"] = -115.04246180632;
                ["x"] = 510.11098019186;
                ["g"] = 10;
                ["sublevel"] = 1;
            };
        };
        ["scale"] = 0.5;
        ["spells"] = {
            [277242] = {};
            [209859] = {};
            [273930] = {};
            [277564] = {};
        };
        ["characteristics"] = {
            ["Taunt"] = true;
            ["Incapacitate"] = true;
            ["Root"] = true;
            ["Polymorph"] = true;
            ["Disorient"] = true;
            ["Sap"] = true;
            ["Stun"] = true;
            ["Slow"] = true;
            ["Silence"] = true;
            ["Fear"] = true;
        };
        ["health"] = 95654;
        ["count"] = 1;
        ["displayId"] = 86025;
        ["creatureType"] = "Humanoid";
        ["level"] = 120;
        ["name"] = "Kul Tiran Footman";
        ["id"] = 141495;
    };
    [38] = {
        ["clones"] = {
            [1] = {
                ["y"] = -217.97632278322;
                ["x"] = 479.33270274982;
                ["g"] = 21;
                ["sublevel"] = 1;
            };
        };
        ["scale"] = 0.7;
        ["spells"] = {
            [277564] = {};
            [209859] = {};
            [257063] = {};
            [256957] = {};
            [257069] = {};
        };
        ["characteristics"] = {
            ["Taunt"] = true;
            ["Incapacitate"] = true;
            ["Sap"] = true;
            ["Silence"] = true;
            ["Root"] = true;
            ["Slow"] = true;
            ["Stun"] = true;
            ["Fear"] = true;
        };
        ["health"] = 235470;
        ["count"] = 4;
        ["displayId"] = 79077;
        ["creatureType"] = "Humanoid";
        ["level"] = 120;
        ["name"] = "Irontide Waveshaper";
        ["id"] = 144071;
    };
    [3] = {
        ["clones"] = {
            [1] = {
                ["sublevel"] = 1;
                ["x"] = 576.53112335304;
                ["infested"] = {
                    [2] = true;
                };
                ["g"] = 2;
                ["y"] = -103.47383528397;
            };
            [2] = {
                ["sublevel"] = 1;
                ["x"] = 507.6109962998;
                ["infested"] = {
                    [2] = true;
                };
                ["g"] = 10;
                ["y"] = -120.61937688321;
            };
            [3] = {
                ["sublevel"] = 1;
                ["x"] = 508.42957993605;
                ["infested"] = {
                    [3] = true;
                };
                ["g"] = 14;
                ["y"] = -156.40629336908;
            };
        };
        ["scale"] = 0.7;
        ["spells"] = {
            [257063] = {};
            [277242] = {};
            [209859] = {};
            [256957] = {};
            [277564] = {};
            [257069] = {};
        };
        ["characteristics"] = {
            ["Taunt"] = true;
            ["Disorient"] = true;
            ["Sap"] = true;
            ["Stun"] = true;
            ["Root"] = true;
            ["Slow"] = true;
            ["Incapacitate"] = true;
            ["Polymorph"] = true;
        };
        ["health"] = 235455;
        ["count"] = 4;
        ["displayId"] = 81778;
        ["creatureType"] = "Humanoid";
        ["level"] = 120;
        ["name"] = "Kul Tiran Wavetender";
        ["id"] = 141284;
    };
    [4] = {
        ["clones"] = {
            [2] = {
                ["sublevel"] = 1;
                ["x"] = 555.09917820964;
                ["infested"] = {
                    [2] = true;
                    [3] = true;
                };
                ["g"] = 3;
                ["y"] = -88.794516245139;
            };
            [3] = {
                ["y"] = -125.25348446226;
                ["x"] = 511.06478359356;
                ["g"] = 10;
                ["sublevel"] = 1;
            };
            [1] = {
                ["y"] = -94.715578615164;
                ["x"] = 553.78339410086;
                ["g"] = 3;
                ["sublevel"] = 1;
            };
            [4] = {
                ["y"] = -136.00427567529;
                ["x"] = 494.73669097353;
                ["g"] = 13;
                ["sublevel"] = 1;
            };
            [5] = {
                ["y"] = -153.8062895029;
                ["x"] = 504.22957666175;
                ["g"] = 14;
                ["sublevel"] = 1;
            };
        };
        ["scale"] = 0.7;
        ["spells"] = {
            [277242] = {};
            [257641] = {};
            [277564] = {};
            [209859] = {};
        };
        ["characteristics"] = {
            ["Taunt"] = true;
            ["Incapacitate"] = true;
            ["Root"] = true;
            ["Disorient"] = true;
            ["Sap"] = true;
            ["Imprison"] = true;
            ["Silence"] = true;
            ["Slow"] = true;
            ["Stun"] = true;
            ["Fear"] = true;
        };
        ["health"] = 264888;
        ["count"] = 4;
        ["displayId"] = 88463;
        ["creatureType"] = "Humanoid";
        ["level"] = 120;
        ["name"] = "Kul Tiran Marksman";
        ["id"] = 141285;
    };
    [5] = {
        ["clones"] = {
            [1] = {
                ["y"] = -87.741893475521;
                ["x"] = 542.86233404787;
                ["g"] = 4;
                ["sublevel"] = 1;
            };
            [2] = {
                ["y"] = -102.18177787393;
                ["x"] = 539.55853986784;
                ["g"] = 5;
                ["sublevel"] = 1;
            };
            [4] = {
                ["y"] = -110.28037172644;
                ["x"] = 537.6726369039;
                ["g"] = 6;
                ["sublevel"] = 1;
            };
            [8] = {
                ["y"] = -123.65452338748;
                ["x"] = 527.00164322093;
                ["g"] = 9;
                ["sublevel"] = 1;
            };
            [16] = {
                ["y"] = -259.17136574654;
                ["x"] = 544.83592322006;
                ["g"] = 25;
                ["sublevel"] = 1;
            };
            [17] = {
                ["y"] = -254.09674905248;
                ["x"] = 549.31354276376;
                ["g"] = 25;
                ["sublevel"] = 1;
            };
            [9] = {
                ["y"] = -124.4655326113;
                ["x"] = 501.07249689966;
                ["g"] = 11;
                ["sublevel"] = 1;
            };
            [18] = {
                ["y"] = -281.78978442034;
                ["x"] = 513.48725074411;
                ["g"] = 26;
                ["sublevel"] = 1;
            };
            [5] = {
                ["y"] = -103.87973231655;
                ["x"] = 521.62802118769;
                ["g"] = 7;
                ["sublevel"] = 1;
            };
            [10] = {
                ["y"] = -128.38270722552;
                ["x"] = 493.74373233938;
                ["g"] = 12;
                ["sublevel"] = 1;
            };
            [20] = {
                ["y"] = -291.49049888556;
                ["x"] = 558.94605246634;
                ["g"] = 28;
                ["sublevel"] = 1;
            };
            [21] = {
                ["y"] = -299.02474425839;
                ["x"] = 548.67209807094;
                ["g"] = 29;
                ["sublevel"] = 1;
            };
            [11] = {
                ["y"] = -249.61912950879;
                ["x"] = 531.70160159579;
                ["g"] = 25;
                ["sublevel"] = 1;
            };
            [22] = {
                ["y"] = -303.96667733386;
                ["x"] = 533.6977027601;
                ["g"] = 30;
                ["sublevel"] = 1;
            };
            [3] = {
                ["y"] = -107.14604701323;
                ["x"] = 535.88156858955;
                ["g"] = 6;
                ["sublevel"] = 1;
            };
            [6] = {
                ["y"] = -116.38860063055;
                ["x"] = 518.95715322177;
                ["g"] = 8;
                ["sublevel"] = 1;
            };
            [12] = {
                ["y"] = -247.52958183507;
                ["x"] = 543.04486771625;
                ["g"] = 25;
                ["sublevel"] = 1;
            };
            [24] = {
                ["y"] = -310.38854239272;
                ["x"] = 532.60962121856;
                ["g"] = 31;
                ["sublevel"] = 1;
            };
            [25] = {
                ["y"] = -308.01730887886;
                ["x"] = 517.74833358221;
                ["g"] = 32;
                ["sublevel"] = 1;
            };
            [13] = {
                ["y"] = -256.25419647414;
                ["x"] = 533.81647645127;
                ["g"] = 25;
                ["sublevel"] = 1;
            };
            [7] = {
                ["y"] = -126.67777977295;
                ["x"] = 523.97836687484;
                ["g"] = 9;
                ["sublevel"] = 1;
            };
            [14] = {
                ["y"] = -252.60419852913;
                ["x"] = 540.80607075495;
                ["g"] = 25;
                ["sublevel"] = 1;
            };
            [23] = {
                ["y"] = -303.33376853159;
                ["x"] = 525.34327180333;
                ["g"] = 31;
                ["sublevel"] = 1;
            };
            [19] = {
                ["y"] = -284.49819137727;
                ["x"] = 520.24441555424;
                ["g"] = 27;
                ["sublevel"] = 1;
            };
            [15] = {
                ["y"] = -262.2035707229;
                ["x"] = 534.32282304943;
                ["g"] = 25;
                ["sublevel"] = 1;
            };
        };
        ["scale"] = 0.5;
        ["spells"] = {
            [277564] = {};
            [256616] = {};
        };
        ["characteristics"] = {
            ["Taunt"] = true;
            ["Slow"] = true;
            ["Root"] = true;
        };
        ["health"] = 58864;
        ["count"] = 1;
        ["displayId"] = 83892;
        ["creatureType"] = "Humanoid";
        ["level"] = 120;
        ["name"] = "Scrimshaw Gutter";
        ["id"] = 141566;
    };
    [6] = {
        ["clones"] = {
            [1] = {
                ["y"] = -155.97452951895;
                ["x"] = 488.41561252114;
                ["g"] = 16;
                ["sublevel"] = 1;
            };
        };
        ["id"] = 128649;
        ["characteristics"] = {
            ["Taunt"] = true;
        };
        ["spells"] = {
            [256867] = {};
            [260924] = {};
            [273716] = {};
            [261428] = {};
            [257650] = {};
            [260954] = {};
            [273681] = {};
        };
        ["isBoss"] = true;
        ["encounterID"] = 2133;
        ["instanceID"] = 1023;
        ["scale"] = 0.8;
        ["health"] = 1648192;
        ["displayId"] = 84382;
        ["creatureType"] = "Humanoid";
        ["level"] = 122;
        ["count"] = 0;
        ["name"] = "Sergeant Bainbridge";
    };
    [7] = {
        ["clones"] = {
            [1] = {
                ["y"] = -150.64514896904;
                ["x"] = 480.38450693339;
                ["g"] = 16;
                ["sublevel"] = 1;
            };
        };
        ["scale"] = 1;
        ["spells"] = {
            [257292] = {};
        };
        ["characteristics"] = {
            ["Taunt"] = true;
            ["Incapacitate"] = true;
            ["Stun"] = true;
            ["Slow"] = true;
            ["Disorient"] = true;
        };
        ["count"] = 0;
        ["name"] = "Kul Tiran Vanguard";
        ["displayId"] = 84074;
        ["creatureType"] = "Humanoid";
        ["level"] = 121;
        ["health"] = 294320;
        ["id"] = 132530;
    };
    [8] = {
        ["clones"] = {
            [1] = {
                ["y"] = -165.32599550048;
                ["x"] = 491.66111302538;
                ["g"] = 16;
                ["sublevel"] = 1;
            };
        };
        ["scale"] = 1;
        ["spells"] = {
            [257641] = {};
        };
        ["characteristics"] = {
            ["Taunt"] = true;
            ["Incapacitate"] = true;
            ["Sap"] = true;
            ["Fear"] = true;
            ["Stun"] = true;
            ["Slow"] = true;
            ["Silence"] = true;
            ["Imprison"] = true;
        };
        ["count"] = 0;
        ["name"] = "Kul Tiran Marksman";
        ["displayId"] = 88463;
        ["creatureType"] = "Humanoid";
        ["level"] = 120;
        ["health"] = 294320;
        ["id"] = 132532;
    };
    [10] = {
        ["clones"] = {
            [1] = {
                ["y"] = -158.68471201329;
                ["x"] = 474.3417293891;
                ["g"] = 17;
                ["sublevel"] = 1;
            };
        };
        ["id"] = 129640;
        ["spells"] = {
            [277564] = {};
            [256969] = {};
            [257145] = {};
            [256971] = {};
            [256897] = {};
        };
        ["characteristics"] = {
            ["Taunt"] = true;
            ["Disorient"] = true;
            ["Root"] = true;
            ["Fear"] = true;
        };
        ["name"] = "Snarling Dockhound";
        ["health"] = 294320;
        ["displayId"] = 30222;
        ["creatureType"] = "Humanoid";
        ["level"] = 120;
        ["scale"] = 0.7;
        ["count"] = 4;
    };
    [12] = {
        ["clones"] = {
            [1] = {
                ["y"] = -159.13247909188;
                ["x"] = 469.11783138109;
                ["g"] = 17;
                ["sublevel"] = 1;
            };
        };
        ["id"] = 129372;
        ["spells"] = {
            [277564] = {};
            [256660] = {};
            [256640] = {};
            [256639] = {};
            [256673] = {};
        };
        ["characteristics"] = {
            ["Taunt"] = true;
            ["Disorient"] = true;
            ["Stun"] = true;
            ["Incapacitate"] = true;
            ["Silence"] = true;
            ["Fear"] = true;
        };
        ["name"] = "Blacktar Bomber";
        ["health"] = 294320;
        ["displayId"] = 84136;
        ["creatureType"] = "Humanoid";
        ["level"] = 120;
        ["scale"] = 0.7;
        ["count"] = 4;
    };
    [14] = {
        ["clones"] = {
            [13] = {
                ["y"] = -313.2846105706;
                ["x"] = 515.44946891385;
                ["g"] = 33;
                ["sublevel"] = 1;
            };
            [7] = {
                ["sublevel"] = 1;
                ["x"] = 483.53047972331;
                ["y"] = -180.78612370641;
                ["g"] = 20;
                ["infested"] = {
                    [1] = true;
                };
            };
            [1] = {
                ["y"] = -167.89184884854;
                ["x"] = 462.86486974263;
                ["g"] = 18;
                ["sublevel"] = 1;
            };
            [2] = {
                ["y"] = -163.16658307654;
                ["x"] = 459.45828838408;
                ["g"] = 18;
                ["sublevel"] = 1;
            };
            [4] = {
                ["y"] = -170.96877914661;
                ["x"] = 454.07366861541;
                ["g"] = 18;
                ["sublevel"] = 1;
            };
            [8] = {
                ["y"] = -182.40350109144;
                ["x"] = 487.30441540797;
                ["g"] = 20;
                ["sublevel"] = 1;
            };
            [9] = {
                ["y"] = -185.58175782923;
                ["x"] = 479.1174607118;
                ["g"] = 20;
                ["sublevel"] = 1;
            };
            [5] = {
                ["y"] = -192.00199282486;
                ["x"] = 473.5233553089;
                ["g"] = 19;
                ["sublevel"] = 1;
            };
            [10] = {
                ["y"] = -262.75904475622;
                ["x"] = 515.78610180136;
                ["g"] = 24;
                ["sublevel"] = 1;
            };
            [11] = {
                ["y"] = -267.11198743104;
                ["x"] = 514.37433879281;
                ["g"] = 24;
                ["sublevel"] = 1;
            };
            [6] = {
                ["y"] = -181.97309174938;
                ["x"] = 480.22183192311;
                ["g"] = 20;
                ["sublevel"] = 1;
            };
            [12] = {
                ["y"] = -322.28836371105;
                ["x"] = 519.1309083453;
                ["g"] = 33;
                ["sublevel"] = 1;
            };
            [3] = {
                ["y"] = -166.02372556507;
                ["x"] = 452.75497948599;
                ["g"] = 18;
                ["sublevel"] = 1;
            };
        };
        ["id"] = 135258;
        ["spells"] = {
            [257168] = {};
            [277564] = {};
            [209859] = {};
            [277242] = {};
        };
        ["characteristics"] = {
            ["Taunt"] = true;
            ["Disorient"] = true;
            ["Sap"] = true;
            ["Root"] = true;
            ["Slow"] = true;
            ["Stun"] = true;
            ["Silence"] = true;
        };
        ["name"] = "Irontide Marauder";
        ["health"] = 58864;
        ["displayId"] = 79068;
        ["creatureType"] = "Humanoid";
        ["level"] = 120;
        ["count"] = 1;
        ["scale"] = 0.5;
    };
    [16] = {
        ["clones"] = {
            [1] = {
                ["y"] = -206.5357810425;
                ["x"] = 484.90910033886;
                ["patrol"] = {
                    [6] = {
                        ["y"] = -195.80850673069;
                        ["x"] = 487.63639357109;
                    };
                    [2] = {
                        ["y"] = -216.35396801396;
                        ["x"] = 482.1818383178;
                    };
                    [3] = {
                        ["y"] = -206.5357810425;
                        ["x"] = 484.90910033886;
                    };
                    [1] = {
                        ["y"] = -206.5357810425;
                        ["x"] = 484.90910033886;
                    };
                    [4] = {
                        ["y"] = -195.80850673069;
                        ["x"] = 487.63639357109;
                    };
                    [5] = {
                        ["y"] = -184.53579405968;
                        ["x"] = 483.27274624734;
                    };
                };
                ["infested"] = {
                    [3] = true;
                };
                ["g"] = 22;
                ["sublevel"] = 1;
            };
            [2] = {
                ["y"] = -320.12672068742;
                ["x"] = 510.97576002868;
                ["g"] = 33;
                ["sublevel"] = 1;
            };
            [4] = {
                ["y"] = -440.25697538332;
                ["x"] = 415.03165322869;
                ["g"] = 44;
                ["sublevel"] = 1;
            };
            [3] = {
                ["sublevel"] = 1;
                ["x"] = 393.59753324218;
                ["y"] = -420.82814705587;
                ["g"] = 43;
                ["infested"] = {
                    [3] = true;
                };
            };
        };
        ["id"] = 128969;
        ["spells"] = {
            [275826] = {};
            [272874] = {};
            [209859] = {};
            [277564] = {};
        };
        ["characteristics"] = {
            ["Taunt"] = true;
        };
        ["name"] = "Ashvane Commander";
        ["health"] = 470912;
        ["displayId"] = 84067;
        ["creatureType"] = "Humanoid";
        ["level"] = 121;
        ["count"] = 8;
        ["scale"] = 0.8;
    };
    [20] = {
        ["clones"] = {
            [1] = {
                ["y"] = -334.97398415096;
                ["x"] = 464.39940921938;
                ["g"] = 34;
                ["sublevel"] = 1;
            };
            [2] = {
                ["y"] = -330.49121809787;
                ["x"] = 462.67524850882;
                ["g"] = 34;
                ["sublevel"] = 1;
            };
            [3] = {
                ["y"] = -343.12820931692;
                ["x"] = 464.78679119468;
                ["g"] = 34;
                ["sublevel"] = 1;
            };
        };
        ["scale"] = 0.7;
        ["spells"] = {
            [268230] = {};
            [209859] = {};
        };
        ["characteristics"] = {
            ["Disorient"] = true;
            ["Root"] = true;
            ["Slow"] = true;
            ["Stun"] = true;
            ["Fear"] = true;
        };
        ["health"] = 294320;
        ["count"] = 4;
        ["displayId"] = 84385;
        ["creatureType"] = "Humanoid";
        ["level"] = 120;
        ["name"] = "Ashvane Deckhand";
        ["id"] = 138464;
    };
    [24] = {
        ["clones"] = {
            [1] = {
                ["sublevel"] = 1;
                ["x"] = 450.55299996036;
                ["patrol"] = {
                    [6] = {
                        ["y"] = -383.88226492827;
                        ["x"] = 455.96283700982;
                    };
                    [2] = {
                        ["y"] = -393.88227015803;
                        ["x"] = 444.97924039355;
                    };
                    [3] = {
                        ["y"] = -392.5707985603;
                        ["x"] = 437.76610087659;
                    };
                    [1] = {
                        ["y"] = -389.12817242508;
                        ["x"] = 450.55299996036;
                    };
                    [4] = {
                        ["y"] = -393.88227015803;
                        ["x"] = 444.97924039355;
                    };
                    [5] = {
                        ["y"] = -389.12817242508;
                        ["x"] = 450.55299996036;
                    };
                };
                ["y"] = -389.12817242508;
                ["infested"] = {
                    [3] = true;
                };
            };
            [2] = {
                ["sublevel"] = 1;
                ["x"] = 464.90977790599;
                ["patrol"] = {
                    [1] = {
                        ["y"] = -365.76373721469;
                        ["x"] = 464.90977790599;
                    };
                    [2] = {
                        ["y"] = -376.70124037245;
                        ["x"] = 459.90977914465;
                    };
                    [4] = {
                        ["y"] = -373.8887234672;
                        ["x"] = 481.78474522705;
                    };
                    [3] = {
                        ["y"] = -386.07622296254;
                        ["x"] = 477.25351604706;
                    };
                };
                ["y"] = -365.76373721469;
                ["infested"] = {
                    [3] = true;
                };
            };
            [3] = {
                ["y"] = -407.28829763634;
                ["x"] = 470.43535125076;
                ["patrol"] = {
                    [6] = {
                        ["y"] = -412.60799802554;
                        ["x"] = 460.92992483847;
                    };
                    [2] = {
                        ["y"] = -402.07699177342;
                        ["x"] = 474.4286536529;
                    };
                    [8] = {
                        ["y"] = -412.60799802554;
                        ["x"] = 460.92992483847;
                    };
                    [3] = {
                        ["y"] = -392.29438311184;
                        ["x"] = 477.90690497361;
                    };
                    [1] = {
                        ["y"] = -407.28829763634;
                        ["x"] = 470.43535125076;
                    };
                    [4] = {
                        ["y"] = -402.07699177342;
                        ["x"] = 474.4286536529;
                    };
                    [5] = {
                        ["y"] = -407.28829763634;
                        ["x"] = 470.43535125076;
                    };
                    [7] = {
                        ["y"] = -416.61778152477;
                        ["x"] = 457.70648170604;
                    };
                };
                ["sublevel"] = 1;
            };
        };
        ["scale"] = 1;
        ["spells"] = {
            [277564] = {};
            [257169] = {};
            [272713] = {};
            [209859] = {};
        };
        ["characteristics"] = {
            ["Taunt"] = true;
        };
        ["name"] = "Bilge Rat Demolisher";
        ["health"] = 588640;
        ["displayId"] = 68059;
        ["creatureType"] = "Humanoid";
        ["level"] = 121;
        ["count"] = 8;
        ["id"] = 135245;
    };
    [28] = {
        ["clones"] = {
            [6] = {
                ["y"] = -444.21880571055;
                ["x"] = 378.76849021377;
                ["g"] = 42;
                ["sublevel"] = 1;
            };
            [2] = {
                ["y"] = -416.4666287268;
                ["x"] = 437.76893352561;
                ["g"] = 41;
                ["sublevel"] = 1;
            };
            [3] = {
                ["y"] = -421.78772407717;
                ["x"] = 437.86066996429;
                ["g"] = 41;
                ["sublevel"] = 1;
            };
            [1] = {
                ["y"] = -413.16388070323;
                ["x"] = 432.44783423805;
                ["g"] = 41;
                ["sublevel"] = 1;
            };
            [4] = {
                ["y"] = -425.27396466403;
                ["x"] = 433.27352518113;
                ["g"] = 41;
                ["sublevel"] = 1;
            };
            [5] = {
                ["sublevel"] = 1;
                ["x"] = 376.52361492942;
                ["y"] = -440.74941557682;
                ["g"] = 42;
                ["infested"] = {
                    [1] = true;
                };
            };
            [7] = {
                ["y"] = -436.83537207088;
                ["x"] = 422.88587760339;
                ["g"] = 44;
                ["sublevel"] = 1;
            };
        };
        ["scale"] = 0.7;
        ["spells"] = {
            [277564] = {};
            [272542] = {};
            [277242] = {};
            [272528] = {};
            [209859] = {};
        };
        ["characteristics"] = {
            ["Taunt"] = true;
            ["Incapacitate"] = true;
            ["Root"] = true;
            ["Polymorph"] = true;
            ["Disorient"] = true;
            ["Sap"] = true;
            ["Stun"] = true;
            ["Slow"] = true;
            ["Silence"] = true;
            ["Fear"] = true;
        };
        ["count"] = 4;
        ["name"] = "Ashvane Sniper";
        ["displayId"] = 82843;
        ["creatureType"] = "Humanoid";
        ["level"] = 120;
        ["health"] = 294320;
        ["id"] = 128967;
    };
    [32] = {
        ["clones"] = {
            [1] = {
                ["y"] = -522.25717126126;
                ["x"] = 433.79490519834;
                ["sublevel"] = 1;
            };
        };
        ["id"] = 128652;
        ["characteristics"] = {
            ["Taunt"] = true;
        };
        ["spells"] = {
            [274991] = {};
            [269456] = {};
            [269484] = {};
            [277535] = {};
            [270484] = {};
            [270185] = {};
            [270187] = {};
            [275014] = {};
        };
        ["isBoss"] = true;
        ["encounterID"] = 2140;
        ["instanceID"] = 1023;
        ["scale"] = 1;
        ["count"] = 0;
        ["displayId"] = 87990;
        ["creatureType"] = "Aberration";
        ["level"] = 122;
        ["health"] = 2943200;
        ["name"] = "Viq'Goth";
    };
    [33] = {
        ["clones"] = {
            [1] = {
                ["sublevel"] = 1;
                ["x"] = 489.87954568438;
                ["infested"] = {
                    [2] = true;
                };
                ["g"] = 13;
                ["y"] = -134.28998585695;
            };
        };
        ["id"] = 138019;
        ["spells"] = {
            [257292] = {};
            [277242] = {};
            [209859] = {};
        };
        ["characteristics"] = {
            ["Polymorph"] = true;
            ["Incapacitate"] = true;
            ["Sap"] = true;
            ["Taunt"] = true;
            ["Root"] = true;
            ["Slow"] = true;
            ["Stun"] = true;
            ["Fear"] = true;
        };
        ["count"] = 4;
        ["name"] = "Kul Tiran Vanguard";
        ["displayId"] = 84074;
        ["creatureType"] = "Humanoid";
        ["level"] = 121;
        ["health"] = 294335;
        ["scale"] = 0.7;
    };
    [17] = {
        ["clones"] = {
            [2] = {
                ["sublevel"] = 1;
                ["x"] = 489.4545682518;
                ["infested"] = {
                    [2] = true;
                };
                ["g"] = 22;
                ["y"] = -207.44487618564;
            };
            [3] = {
                ["y"] = -205.26305252377;
                ["x"] = 479.27275570754;
                ["g"] = 22;
                ["sublevel"] = 1;
            };
            [1] = {
                ["sublevel"] = 1;
                ["x"] = 484.17234770389;
                ["infested"] = {
                    [2] = true;
                };
                ["g"] = 21;
                ["y"] = -220.47957084003;
            };
            [4] = {
                ["y"] = -267.8728221379;
                ["x"] = 518.62532202863;
                ["g"] = 24;
                ["sublevel"] = 1;
            };
            [5] = {
                ["sublevel"] = 1;
                ["x"] = 514.65999618989;
                ["infested"] = {
                    [2] = true;
                };
                ["g"] = 33;
                ["y"] = -322.49513885932;
            };
        };
        ["id"] = 137521;
        ["spells"] = {
            [277242] = {};
            [257641] = {};
            [277564] = {};
            [209859] = {};
        };
        ["characteristics"] = {
            ["Taunt"] = true;
            ["Incapacitate"] = true;
            ["Root"] = true;
            ["Polymorph"] = true;
            ["Disorient"] = true;
            ["Silence"] = true;
            ["Stun"] = true;
            ["Slow"] = true;
            ["Fear"] = true;
            ["Imprison"] = true;
        };
        ["name"] = "Irontide Powdershot";
        ["health"] = 58864;
        ["displayId"] = 85144;
        ["creatureType"] = "Humanoid";
        ["level"] = 120;
        ["count"] = 4;
        ["scale"] = 0.7;
    };
    [21] = {
        ["clones"] = {
            [1] = {
                ["sublevel"] = 1;
                ["x"] = 458.88216893754;
                ["y"] = -336.35329052182;
                ["g"] = 34;
                ["infested"] = {
                    [3] = true;
                };
            };
        };
        ["scale"] = 0.7;
        ["spells"] = {
            [209859] = {};
            [281388] = {};
            [268260] = {};
        };
        ["characteristics"] = {
            ["Taunt"] = true;
        };
        ["health"] = 294320;
        ["count"] = 4;
        ["displayId"] = 88542;
        ["creatureType"] = "Humanoid";
        ["level"] = 120;
        ["name"] = "Ashvane Cannoneer";
        ["id"] = 138465;
    };
    [25] = {
        ["clones"] = {
            [1] = {
                ["sublevel"] = 1;
                ["x"] = 445.79217228065;
                ["infested"] = {
                    [2] = true;
                };
                ["g"] = 35;
                ["y"] = -397.16114192187;
            };
            [2] = {
                ["sublevel"] = 1;
                ["x"] = 473.99733947372;
                ["infested"] = {
                    [2] = true;
                };
                ["g"] = 37;
                ["y"] = -385.69901189549;
            };
            [4] = {
                ["sublevel"] = 1;
                ["x"] = 456.37530835401;
                ["infested"] = {
                    [2] = true;
                };
                ["g"] = 39;
                ["y"] = -421.65313166251;
            };
            [3] = {
                ["sublevel"] = 1;
                ["x"] = 484.99568346729;
                ["infested"] = {
                    [1] = true;
                    [2] = true;
                    [3] = true;
                };
                ["g"] = 45;
                ["y"] = -369.78897033877;
            };
        };
        ["scale"] = 0.7;
        ["spells"] = {
            [277242] = {};
            [272834] = {};
            [209859] = {};
            [277564] = {};
            [272827] = {};
        };
        ["characteristics"] = {
            ["Taunt"] = true;
            ["Incapacitate"] = true;
            ["Root"] = true;
            ["Polymorph"] = true;
            ["Mind Control"] = true;
            ["Sap"] = true;
            ["Imprison"] = true;
            ["Stun"] = true;
            ["Slow"] = true;
            ["Disorient"] = true;
            ["Fear"] = true;
        };
        ["name"] = "Bilge Rat Pillager";
        ["health"] = 294320;
        ["displayId"] = 52277;
        ["creatureType"] = "Humanoid";
        ["level"] = 120;
        ["count"] = 4;
        ["id"] = 135241;
    };
    [29] = {
        ["clones"] = {
            [2] = {
                ["y"] = -422.40827992271;
                ["x"] = 398.22865812385;
                ["g"] = 43;
                ["sublevel"] = 1;
            };
            [3] = {
                ["y"] = -425.408255889;
                ["x"] = 393.22867672236;
                ["g"] = 43;
                ["sublevel"] = 1;
            };
            [1] = {
                ["y"] = -438.70859836629;
                ["x"] = 380.80929866607;
                ["g"] = 42;
                ["sublevel"] = 1;
            };
            [4] = {
                ["y"] = -438.13970931908;
                ["x"] = 428.97285939704;
                ["g"] = 44;
                ["sublevel"] = 1;
            };
            [5] = {
                ["y"] = -443.79188404172;
                ["x"] = 426.58154178903;
                ["g"] = 44;
                ["sublevel"] = 1;
            };
        };
        ["scale"] = 0.7;
        ["spells"] = {
            [275836] = {};
            [209859] = {};
            [275835] = {};
            [277564] = {};
        };
        ["characteristics"] = {
            ["Taunt"] = true;
            ["Incapacitate"] = true;
            ["Silence"] = true;
            ["Disorient"] = true;
            ["Root"] = true;
            ["Slow"] = true;
            ["Stun"] = true;
            ["Fear"] = true;
        };
        ["count"] = 4;
        ["name"] = "Ashvane Invader";
        ["displayId"] = 79889;
        ["creatureType"] = "Humanoid";
        ["level"] = 120;
        ["health"] = 294320;
        ["id"] = 137516;
    };
    [34] = {
        ["clones"] = {
            [7] = {
                ["y"] = -136.11134043785;
                ["x"] = 484.53809461745;
                ["g"] = 13;
                ["sublevel"] = 1;
            };
            [1] = {
                ["y"] = -95.768201384782;
                ["x"] = 558.38864977509;
                ["g"] = 3;
                ["sublevel"] = 1;
            };
            [2] = {
                ["y"] = -90.505042362655;
                ["x"] = 559.17813379257;
                ["g"] = 3;
                ["sublevel"] = 1;
            };
            [4] = {
                ["y"] = -141.07537171561;
                ["x"] = 497.27189948463;
                ["g"] = 13;
                ["sublevel"] = 1;
            };
            [8] = {
                ["y"] = -158.8062774609;
                ["x"] = 504.72957459924;
                ["g"] = 14;
                ["sublevel"] = 1;
            };
            [9] = {
                ["sublevel"] = 1;
                ["x"] = 499.7295694751;
                ["y"] = -156.0062838611;
                ["g"] = 14;
                ["infested"] = {
                    [1] = true;
                };
            };
            [5] = {
                ["y"] = -140.28399456647;
                ["x"] = 492.45176731099;
                ["g"] = 13;
                ["sublevel"] = 1;
            };
            [10] = {
                ["y"] = -149.20628530368;
                ["x"] = 500.82957523727;
                ["g"] = 14;
                ["sublevel"] = 1;
            };
            [3] = {
                ["y"] = -121.54310148864;
                ["x"] = 514.66541432983;
                ["g"] = 10;
                ["sublevel"] = 1;
            };
            [6] = {
                ["y"] = -139.20486860802;
                ["x"] = 488.42298758703;
                ["g"] = 13;
                ["sublevel"] = 1;
            };
            [11] = {
                ["y"] = -151.00629161156;
                ["x"] = 508.32957863194;
                ["g"] = 14;
                ["sublevel"] = 1;
            };
        };
        ["id"] = 141282;
        ["spells"] = {
            [277564] = {};
            [209859] = {};
            [273930] = {};
            [277242] = {};
        };
        ["characteristics"] = {
            ["Taunt"] = true;
            ["Incapacitate"] = true;
            ["Root"] = true;
            ["Sap"] = true;
            ["Fear"] = true;
            ["Stun"] = true;
            ["Slow"] = true;
            ["Silence"] = true;
            ["Imprison"] = true;
        };
        ["name"] = "Kul Tiran Footman";
        ["health"] = 58867;
        ["displayId"] = 86025;
        ["creatureType"] = "Humanoid";
        ["level"] = 120;
        ["count"] = 1;
        ["scale"] = 0.5;
    };
    [9] = {
        ["clones"] = {
            [1] = {
                ["y"] = -164.35636428934;
                ["x"] = 473.7446938071;
                ["g"] = 17;
                ["sublevel"] = 1;
            };
        };
        ["id"] = 129373;
        ["spells"] = {
            [277564] = {};
            [256986] = {};
            [257036] = {};
        };
        ["characteristics"] = {
            ["Taunt"] = true;
            ["Disorient"] = true;
            ["Root"] = true;
            ["Fear"] = true;
        };
        ["name"] = "Dockhound Packmaster";
        ["health"] = 294320;
        ["displayId"] = 84143;
        ["creatureType"] = "Humanoid";
        ["level"] = 120;
        ["scale"] = 0.7;
        ["count"] = 4;
    };
    [11] = {
        ["clones"] = {
            [1] = {
                ["sublevel"] = 1;
                ["x"] = 473.14769665675;
                ["infested"] = {
                    [2] = true;
                };
                ["g"] = 17;
                ["y"] = -169.28172529054;
            };
        };
        ["id"] = 129371;
        ["spells"] = {
            [257270] = {};
            [256866] = {};
            [256709] = {};
            [277242] = {};
        };
        ["characteristics"] = {
            ["Disorient"] = true;
            ["Root"] = true;
            ["Silence"] = true;
            ["Stun"] = true;
            ["Fear"] = true;
        };
        ["name"] = "Riptide Shredder";
        ["health"] = 294320;
        ["displayId"] = 86085;
        ["creatureType"] = "Humanoid";
        ["level"] = 120;
        ["scale"] = 0.7;
        ["count"] = 4;
    };
    [13] = {
        ["clones"] = {
            [1] = {
                ["y"] = -164.50560717166;
                ["x"] = 468.22232284501;
                ["g"] = 17;
                ["sublevel"] = 1;
            };
            [2] = {
                ["y"] = -170.28785747658;
                ["x"] = 458.70672577275;
                ["g"] = 18;
                ["sublevel"] = 1;
            };
            [3] = {
                ["y"] = -199.99033346525;
                ["x"] = 491.4545635217;
                ["infested"] = {
                    [3] = true;
                };
                ["sublevel"] = 1;
            };
        };
        ["id"] = 129369;
        ["spells"] = {
            [275775] = {};
            [272662] = {};
            [257170] = {};
            [209859] = {};
            [277564] = {};
        };
        ["characteristics"] = {
            ["Taunt"] = true;
        };
        ["name"] = "Irontide Raider";
        ["health"] = 470912;
        ["displayId"] = 84134;
        ["creatureType"] = "Humanoid";
        ["level"] = 121;
        ["count"] = 8;
        ["scale"] = 0.7;
    };
    [15] = {
        ["clones"] = {
            [1] = {
                ["y"] = -188.50199940652;
                ["x"] = 471.52332841602;
                ["g"] = 19;
                ["sublevel"] = 1;
            };
            [2] = {
                ["sublevel"] = 1;
                ["x"] = 519.95185520218;
                ["infested"] = {
                    [2] = true;
                };
                ["g"] = 24;
                ["y"] = -263.30361658651;
            };
            [3] = {
                ["y"] = -315.91619008166;
                ["x"] = 511.89682471573;
                ["g"] = 33;
                ["sublevel"] = 1;
            };
        };
        ["id"] = 129370;
        ["spells"] = {
            [257063] = {};
            [277242] = {};
            [209859] = {};
            [256957] = {};
            [277564] = {};
            [257069] = {};
        };
        ["characteristics"] = {
            ["Taunt"] = true;
            ["Incapacitate"] = true;
            ["Disorient"] = true;
            ["Root"] = true;
            ["Slow"] = true;
            ["Stun"] = true;
            ["Silence"] = true;
        };
        ["name"] = "Irontide Waveshaper";
        ["health"] = 235455;
        ["displayId"] = 79077;
        ["creatureType"] = "Humanoid";
        ["level"] = 120;
        ["count"] = 4;
        ["scale"] = 0.7;
    };
    [18] = {
        ["clones"] = {
            [1] = {
                ["sublevel"] = 1;
                ["x"] = 498.83584773743;
                ["y"] = -259.64788169597;
                ["g"] = 23;
                ["infested"] = {
                    [3] = true;
                };
            };
            [2] = {
                ["y"] = -341.18087391862;
                ["x"] = 458.88216893754;
                ["g"] = 34;
                ["sublevel"] = 1;
            };
            [3] = {
                ["y"] = -419.76937675037;
                ["x"] = 432.90654005456;
                ["g"] = 41;
                ["sublevel"] = 1;
            };
        };
        ["id"] = 138255;
        ["spells"] = {
            [272471] = {};
            [272421] = {};
            [209859] = {};
            [272418] = {};
            [272422] = {};
        };
        ["characteristics"] = {
            ["Root"] = true;
            ["Slow"] = true;
            ["Taunt"] = true;
        };
        ["count"] = 4;
        ["name"] = "Ashvane Spotter";
        ["displayId"] = 86436;
        ["creatureType"] = "Humanoid";
        ["level"] = 121;
        ["health"] = 294320;
        ["scale"] = 0.7;
    };
    [22] = {
        ["clones"] = {
            [1] = {
                ["y"] = -332.71826679518;
                ["x"] = 445.55283973782;
                ["sublevel"] = 1;
            };
        };
        ["id"] = 129208;
        ["scale"] = 0.8;
        ["spells"] = {
            [269029] = {};
            [272471] = {};
            [280389] = {};
            [273470] = {};
        };
        ["isBoss"] = true;
        ["encounterID"] = 2173;
        ["instanceID"] = 1023;
        ["health"] = 1442168;
        ["name"] = "Dread Captain Lockwood";
        ["displayId"] = 88579;
        ["creatureType"] = "Humanoid";
        ["level"] = 122;
        ["count"] = 0;
        ["characteristics"] = {
            ["Root"] = true;
            ["Slow"] = true;
            ["Taunt"] = true;
        };
    };
    [26] = {
        ["clones"] = {
            [1] = {
                ["y"] = -378.96425171327;
                ["x"] = 458.09399858262;
                ["g"] = 36;
                ["sublevel"] = 1;
            };
            [2] = {
                ["y"] = -397.34140436105;
                ["x"] = 487.90605918564;
                ["g"] = 38;
                ["sublevel"] = 1;
            };
            [3] = {
                ["y"] = -404.26515494169;
                ["x"] = 456.72700463708;
                ["g"] = 40;
                ["sublevel"] = 1;
            };
        };
        ["scale"] = 0.7;
        ["spells"] = {
            [272571] = {};
            [277564] = {};
            [209859] = {};
            [277242] = {};
            [272581] = {};
            [274569] = {};
        };
        ["characteristics"] = {
            ["Taunt"] = true;
            ["Incapacitate"] = true;
            ["Disorient"] = true;
            ["Stun"] = true;
            ["Root"] = true;
            ["Slow"] = true;
            ["Silence"] = true;
            ["Fear"] = true;
        };
        ["name"] = "Bilge Rat Tempest";
        ["health"] = 235455;
        ["displayId"] = 80475;
        ["creatureType"] = "Humanoid";
        ["level"] = 120;
        ["count"] = 4;
        ["id"] = 129367;
    };
    [30] = {
        ["clones"] = {
            [1] = {
                ["y"] = -426.15826597382;
                ["x"] = 396.97868423115;
                ["g"] = 43;
                ["sublevel"] = 1;
            };
            [2] = {
                ["sublevel"] = 1;
                ["x"] = 417.45111574567;
                ["infested"] = {
                    [2] = true;
                };
                ["g"] = 44;
                ["y"] = -437.27014182419;
            };
        };
        ["scale"] = 0.7;
        ["spells"] = {
            [277564] = {};
            [272888] = {};
            [277242] = {};
            [209859] = {};
        };
        ["characteristics"] = {
            ["Taunt"] = true;
            ["Incapacitate"] = true;
            ["Root"] = true;
            ["Polymorph"] = true;
            ["Disorient"] = true;
            ["Sap"] = true;
            ["Stun"] = true;
            ["Slow"] = true;
            ["Silence"] = true;
            ["Fear"] = true;
        };
        ["count"] = 4;
        ["name"] = "Ashvane Destroyer";
        ["displayId"] = 82852;
        ["creatureType"] = "Humanoid";
        ["level"] = 120;
        ["health"] = 294320;
        ["id"] = 137517;
    };
    [36] = {
        ["clones"] = {
            [6] = {
                ["y"] = -319.32516444756;
                ["x"] = 461.85593713013;
                ["sublevel"] = 1;
            };
            [2] = {
                ["y"] = -225.27273638926;
                ["x"] = 482.82224298751;
                ["g"] = 21;
                ["sublevel"] = 1;
            };
            [8] = {
                ["y"] = -354.51747202835;
                ["x"] = 469.93285260498;
                ["sublevel"] = 1;
            };
            [3] = {
                ["y"] = -222.50958185537;
                ["x"] = 478.48013735893;
                ["g"] = 21;
                ["sublevel"] = 1;
            };
            [1] = {
                ["y"] = -225.40431705884;
                ["x"] = 488.08539071613;
                ["g"] = 21;
                ["sublevel"] = 1;
            };
            [4] = {
                ["y"] = -327.40210468126;
                ["x"] = 466.27899063328;
                ["sublevel"] = 1;
            };
            [5] = {
                ["y"] = -321.05594030226;
                ["x"] = 469.16361155582;
                ["sublevel"] = 1;
            };
            [7] = {
                ["y"] = -351.24823883418;
                ["x"] = 463.77899023532;
                ["sublevel"] = 1;
            };
        };
        ["scale"] = 0.5;
        ["spells"] = {
            [277564] = {};
            [209859] = {};
            [257168] = {};
        };
        ["characteristics"] = {
            ["Taunt"] = true;
            ["Disorient"] = true;
            ["Silence"] = true;
            ["Root"] = true;
            ["Slow"] = true;
            ["Stun"] = true;
            ["Fear"] = true;
        };
        ["health"] = 58867;
        ["count"] = 1;
        ["displayId"] = 79068;
        ["creatureType"] = "Humanoid";
        ["level"] = 120;
        ["name"] = "Irontide Marauder";
        ["id"] = 138247;
    };
    [37] = {
        ["clones"] = {
            [1] = {
                ["y"] = -257.38301854863;
                ["x"] = 504.63481746092;
                ["g"] = 23;
                ["sublevel"] = 1;
            };
            [2] = {
                ["y"] = -261.73597132117;
                ["x"] = 493.81129769619;
                ["g"] = 23;
                ["sublevel"] = 1;
            };
            [4] = {
                ["y"] = -252.5594915702;
                ["x"] = 499.22306262742;
                ["g"] = 23;
                ["sublevel"] = 1;
            };
            [3] = {
                ["y"] = -255.03007683515;
                ["x"] = 494.39953060013;
                ["g"] = 23;
                ["sublevel"] = 1;
            };
        };
        ["scale"] = 0.7;
        ["spells"] = {
            [257641] = {};
            [209859] = {};
        };
        ["characteristics"] = {
            ["Stun"] = true;
            ["Slow"] = true;
            ["Disorient"] = true;
        };
        ["health"] = 58867;
        ["count"] = 1;
        ["displayId"] = 85144;
        ["creatureType"] = "Humanoid";
        ["level"] = 120;
        ["name"] = "Irontide Powdershot";
        ["id"] = 138254;
    };
    [35] = {
        ["clones"] = {
            [7] = {
                ["y"] = -129.3192177209;
                ["x"] = 526.30126212487;
                ["g"] = 9;
                ["sublevel"] = 1;
            };
            [1] = {
                ["y"] = -91.426095756203;
                ["x"] = 541.54654993909;
                ["g"] = 4;
                ["sublevel"] = 1;
            };
            [2] = {
                ["y"] = -103.51399918979;
                ["x"] = 542.63404265353;
                ["g"] = 5;
                ["sublevel"] = 1;
            };
            [4] = {
                ["y"] = -108.11307298499;
                ["x"] = 531.86911310946;
                ["g"] = 6;
                ["sublevel"] = 1;
            };
            [8] = {
                ["y"] = -126.48903267501;
                ["x"] = 530.35786204019;
                ["g"] = 9;
                ["sublevel"] = 1;
            };
            [9] = {
                ["y"] = -127.67949622155;
                ["x"] = 500.29587275309;
                ["g"] = 11;
                ["sublevel"] = 1;
            };
            [5] = {
                ["y"] = -100.10166381043;
                ["x"] = 520.36252691696;
                ["g"] = 7;
                ["sublevel"] = 1;
            };
            [10] = {
                ["y"] = -127.74441934984;
                ["x"] = 490.16460146767;
                ["g"] = 12;
                ["sublevel"] = 1;
            };
            [3] = {
                ["y"] = -111.29988539789;
                ["x"] = 534.06690631731;
                ["g"] = 6;
                ["sublevel"] = 1;
            };
            [6] = {
                ["y"] = -112.73097762966;
                ["x"] = 516.73635955827;
                ["g"] = 8;
                ["sublevel"] = 1;
            };
        };
        ["id"] = 141565;
        ["spells"] = {
            [277564] = {};
            [209859] = {};
            [273930] = {};
        };
        ["characteristics"] = {
            ["Taunt"] = true;
            ["Stun"] = true;
            ["Silence"] = true;
            ["Slow"] = true;
            ["Root"] = true;
            ["Fear"] = true;
        };
        ["name"] = "Kul Tiran Footman";
        ["health"] = 58867;
        ["displayId"] = 86025;
        ["creatureType"] = "Humanoid";
        ["level"] = 120;
        ["count"] = 1;
        ["scale"] = 0.5;
    };
    [1] = {
        ["clones"] = {
            [2] = {
                ["sublevel"] = 1;
                ["x"] = 603.77923440022;
                ["patrol"] = {
                    [6] = {
                        ["y"] = -111.12685825223;
                        ["x"] = 599.19296247123;
                    };
                    [2] = {
                        ["y"] = -108.10053673243;
                        ["x"] = 605.50874426297;
                    };
                    [8] = {
                        ["y"] = -111.12685825223;
                        ["x"] = 599.19296247123;
                    };
                    [3] = {
                        ["y"] = -102.70581962774;
                        ["x"] = 606.16664761087;
                    };
                    [1] = {
                        ["y"] = -110.15644771174;
                        ["x"] = 603.77923440022;
                    };
                    [4] = {
                        ["y"] = -108.10053673243;
                        ["x"] = 605.50874426297;
                    };
                    [5] = {
                        ["y"] = -108.10053673243;
                        ["x"] = 605.50874426297;
                    };
                    [7] = {
                        ["y"] = -107.73892927049;
                        ["x"] = 583.88643955623;
                    };
                };
                ["infested"] = {
                    [3] = true;
                };
                ["y"] = -110.15644771174;
            };
            [3] = {
                ["sublevel"] = 1;
                ["x"] = 504.88057117788;
                ["infested"] = {
                    [3] = true;
                };
                ["g"] = 10;
                ["y"] = -115.38505847239;
            };
            [1] = {
                ["sublevel"] = 1;
                ["x"] = 611.53324048298;
                ["infested"] = {
                    [2] = true;
                };
                ["g"] = 1;
                ["y"] = -94.74910945841;
            };
            [4] = {
                ["y"] = -86.689259412394;
                ["x"] = 551.02023392022;
                ["teeming"] = true;
                ["g"] = 3;
                ["sublevel"] = 1;
            };
            [5] = {
                ["y"] = -93.926094597687;
                ["x"] = 549.70442722442;
                ["teeming"] = true;
                ["g"] = 3;
                ["sublevel"] = 1;
            };
        };
        ["scale"] = 0.7;
        ["spells"] = {
            [277564] = {};
            [209859] = {};
            [277242] = {};
            [256627] = {};
        };
        ["characteristics"] = {
            ["Taunt"] = true;
            ["Incapacitate"] = true;
            ["Root"] = true;
            ["Polymorph"] = true;
            ["Disorient"] = true;
            ["Sap"] = true;
            ["Stun"] = true;
            ["Slow"] = true;
            ["Silence"] = true;
            ["Fear"] = true;
        };
        ["health"] = 294320;
        ["count"] = 4;
        ["displayId"] = 84074;
        ["creatureType"] = "Humanoid";
        ["level"] = 120;
        ["name"] = "Kul Tiran Halberd";
        ["id"] = 141283;
    };
    [19] = {
        ["clones"] = {
            [13] = {
                ["y"] = -303.16501314177;
                ["x"] = 527.67608951888;
                ["g"] = 31;
                ["sublevel"] = 1;
            };
            [7] = {
                ["y"] = -253.72255583275;
                ["x"] = 538.37345459444;
                ["g"] = 25;
                ["sublevel"] = 1;
            };
            [1] = {
                ["y"] = -250.43142788804;
                ["x"] = 529.5126770395;
                ["g"] = 25;
                ["sublevel"] = 1;
            };
            [2] = {
                ["y"] = -247.39345151313;
                ["x"] = 540.52533800336;
                ["g"] = 25;
                ["sublevel"] = 1;
            };
            [4] = {
                ["y"] = -259.41876221475;
                ["x"] = 541.91775040591;
                ["g"] = 25;
                ["sublevel"] = 1;
            };
            [8] = {
                ["y"] = -279.45366833983;
                ["x"] = 514.64882686269;
                ["g"] = 26;
                ["sublevel"] = 1;
            };
            [14] = {
                ["y"] = -312.70085465845;
                ["x"] = 531.79896548866;
                ["g"] = 31;
                ["sublevel"] = 1;
            };
            [9] = {
                ["y"] = -287.10623356988;
                ["x"] = 520.19610143157;
                ["g"] = 27;
                ["sublevel"] = 1;
            };
            [5] = {
                ["y"] = -262.3175236157;
                ["x"] = 532.03960504283;
                ["g"] = 25;
                ["sublevel"] = 1;
            };
            [10] = {
                ["y"] = -292.19452906667;
                ["x"] = 555.72299209389;
                ["g"] = 28;
                ["sublevel"] = 1;
            };
            [11] = {
                ["y"] = -300.295797589;
                ["x"] = 546.10276526187;
                ["g"] = 29;
                ["sublevel"] = 1;
            };
            [3] = {
                ["y"] = -253.59597733169;
                ["x"] = 546.72788555121;
                ["g"] = 25;
                ["sublevel"] = 1;
            };
            [6] = {
                ["y"] = -254.67045037523;
                ["x"] = 532.33370139834;
                ["g"] = 25;
                ["sublevel"] = 1;
            };
            [12] = {
                ["y"] = -304.20748815733;
                ["x"] = 536.34527281636;
                ["g"] = 30;
                ["sublevel"] = 1;
            };
            [15] = {
                ["y"] = -306.04776973855;
                ["x"] = 519.92315521201;
                ["g"] = 32;
                ["sublevel"] = 1;
            };
        };
        ["scale"] = 0.5;
        ["spells"] = {
            [277564] = {};
            [209859] = {};
            [273930] = {};
        };
        ["characteristics"] = {
            ["Taunt"] = true;
            ["Stun"] = true;
            ["Silence"] = true;
            ["Slow"] = true;
            ["Root"] = true;
            ["Fear"] = true;
        };
        ["name"] = "Kul Tiran Footman";
        ["health"] = 58864;
        ["displayId"] = 86025;
        ["creatureType"] = "Humanoid";
        ["level"] = 120;
        ["count"] = 1;
        ["id"] = 141565;
    };
    [23] = {
        ["clones"] = {
            [13] = {
                ["sublevel"] = 1;
                ["x"] = 452.93573232766;
                ["y"] = -426.27390498037;
                ["g"] = 39;
                ["infested"] = {
                    [1] = true;
                };
            };
            [7] = {
                ["sublevel"] = 1;
                ["x"] = 486.81382693685;
                ["y"] = -365.97079258537;
                ["g"] = 45;
                ["infested"] = {};
            };
            [1] = {
                ["y"] = -399.30399653134;
                ["x"] = 450.9350356049;
                ["g"] = 35;
                ["sublevel"] = 1;
            };
            [2] = {
                ["y"] = -392.01832356905;
                ["x"] = 455.50646053809;
                ["sublevel"] = 1;
            };
            [15] = {
                ["y"] = -405.54915579598;
                ["x"] = 464.00056711768;
                ["g"] = 40;
                ["sublevel"] = 1;
            };
            [8] = {
                ["y"] = -387.07342135317;
                ["x"] = 485.68495957621;
                ["sublevel"] = 1;
                ["infested"] = {
                    [1] = true;
                };
            };
            [4] = {
                ["y"] = -380.93145559221;
                ["x"] = 453.50383040232;
                ["g"] = 36;
                ["sublevel"] = 1;
            };
            [9] = {
                ["y"] = -388.56596547125;
                ["x"] = 492.55064458462;
                ["sublevel"] = 1;
            };
            [5] = {
                ["y"] = -389.28109728202;
                ["x"] = 471.45999269505;
                ["g"] = 37;
                ["sublevel"] = 1;
            };
            [10] = {
                ["y"] = -394.55660128523;
                ["x"] = 489.29848245284;
                ["g"] = 38;
                ["sublevel"] = 1;
            };
            [3] = {
                ["sublevel"] = 1;
                ["x"] = 459.40546314504;
                ["y"] = -383.06259605911;
                ["g"] = 36;
                ["infested"] = {
                    [1] = true;
                };
            };
            [11] = {
                ["y"] = -402.07594876398;
                ["x"] = 476.854409421;
                ["infested"] = {
                    [2] = true;
                };
                ["sublevel"] = 1;
            };
            [6] = {
                ["y"] = -384.20647418269;
                ["x"] = 469.81820569465;
                ["g"] = 37;
                ["sublevel"] = 1;
            };
            [12] = {
                ["y"] = -425.89415861255;
                ["x"] = 457.74586747296;
                ["g"] = 39;
                ["sublevel"] = 1;
            };
            [14] = {
                ["sublevel"] = 1;
                ["x"] = 461.40441545586;
                ["y"] = -402.4909626023;
                ["g"] = 40;
                ["infested"] = {};
            };
        };
        ["scale"] = 0.7;
        ["spells"] = {
            [277242] = {};
            [274941] = {};
            [209859] = {};
            [272546] = {};
            [277564] = {};
        };
        ["characteristics"] = {
            ["Taunt"] = true;
            ["Incapacitate"] = true;
            ["Root"] = true;
            ["Polymorph"] = true;
            ["Disorient"] = true;
            ["Sap"] = true;
            ["Imprison"] = true;
            ["Silence"] = true;
            ["Slow"] = true;
            ["Stun"] = true;
            ["Fear"] = true;
        };
        ["name"] = "Bilge Rat Buccaneer";
        ["health"] = 294320;
        ["displayId"] = 81424;
        ["creatureType"] = "Humanoid";
        ["level"] = 120;
        ["count"] = 4;
        ["id"] = 129366;
    };
    [31] = {
        ["clones"] = {
            [1] = {
                ["y"] = -451.73365719748;
                ["x"] = 394.14927643255;
                ["patrol"] = {
                    [1] = {
                        ["y"] = -451.73365719748;
                        ["x"] = 394.14927643255;
                    };
                    [2] = {
                        ["y"] = -431.90056670682;
                        ["x"] = 384.31621286457;
                    };
                    [4] = {
                        ["y"] = -440.15053816504;
                        ["x"] = 420.06622150584;
                    };
                    [3] = {
                        ["y"] = -419.90056628214;
                        ["x"] = 409.31622716037;
                    };
                };
                ["sublevel"] = 1;
            };
        };
        ["id"] = 128651;
        ["scale"] = 1;
        ["spells"] = {
            [257882] = {};
            [261565] = {};
            [277564] = {};
            [276068] = {};
            [257883] = {};
        };
        ["isBoss"] = true;
        ["encounterID"] = 2134;
        ["instanceID"] = 1023;
        ["health"] = 2060240;
        ["name"] = "Hadal Darkfathom";
        ["displayId"] = 67541;
        ["creatureType"] = "Giant";
        ["level"] = 122;
        ["count"] = 0;
        ["characteristics"] = {
            ["Taunt"] = true;
        };
    };
};





























