local MDT = MDT
local L = MDT.L
local dungeonIndex = 17
MDT.dungeonTotalCount[dungeonIndex] = {normal=246,teeming=286,teemingEnabled=true}

MDT.mapPOIs[dungeonIndex] = {
    [1] = {
        [1] = {
            ["y"] = -264.6777671764;
            ["x"] = 727.18161266836;
            ["template"] = "DeathReleasePinTemplate";
            ["graveyardDescription"] = "";
            ["type"] = "graveyard";
        };
        [2] = {
            ["y"] = -422.22745110791;
            ["x"] = 369.133435873;
            ["template"] = "DeathReleasePinTemplate";
            ["graveyardDescription"] = L["krGraveyardNote1"];
            ["type"] = "graveyard";
        };
        [3] = {
            ["y"] = -306.78957025286;
            ["x"] = 552.83936308858;
            ["template"] = "MapLinkPinTemplate";
            ["type"] = "krSpiritGuide";
        };
        [4] = {
            ["y"] = -198.38138258562;
            ["x"] = 375.6062297457;
            ["template"] = "MapLinkPinTemplate";
            ["weeks"] = {
                [5] = true;
                [2] = true;
                [11] = true;
                [8] = true;
            };
            ["difficulty"] = 10;
            ["text"] = L["krBrutePatrolNote"];
            ["season"] = 3;
            ["type"] = "generalNote";
        };
        [5] = {
            ["npcId"] = 161124;
            ["type"] = "nyalothaSpire";
            ["index"] = 1;
            ["y"] = -310.64989276843;
            ["x"] = 568.0731143443;
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
        [6] = {
            ["npcId"] = 161243;
            ["type"] = "nyalothaSpire";
            ["index"] = 2;
            ["y"] = -438.75572988328;
            ["x"] = 459.35764362381;
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
        [7] = {
            ["npcId"] = 161241;
            ["type"] = "nyalothaSpire";
            ["index"] = 3;
            ["y"] = -162.06623623627;
            ["x"] = 390.89525129512;
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
        [8] = {
            ["npcId"] = 161244;
            ["type"] = "nyalothaSpire";
            ["index"] = 4;
            ["y"] = -162.93317733121;
            ["x"] = 345.69345482139;
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
        [9] = {
            ["npcId"] = 161124;
            ["type"] = "nyalothaSpire";
            ["index"] = 5;
            ["y"] = -161.83545560425;
            ["x"] = 390.98859151237;
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
        [10] = {
            ["npcId"] = 161241;
            ["type"] = "nyalothaSpire";
            ["index"] = 6;
            ["y"] = -312.75780857123;
            ["x"] = 565.64698565175;
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
};

MDT.dungeonEnemies[dungeonIndex] = {
    [1] = {
        ["clones"] = {
            [1] = {
                ["y"] = -254.08941352266;
                ["x"] = 572.75039865962;
                ["sublevel"] = 1;
            };
            [2] = {
                ["y"] = -272.04388546541;
                ["x"] = 572.54582578774;
                ["infested"] = {
                    [3] = true;
                };
                ["sublevel"] = 1;
            };
            [3] = {
                ["y"] = -333.84661956258;
                ["x"] = 586.42175363663;
                ["g"] = 2;
                ["sublevel"] = 1;
            };
            [4] = {
                ["y"] = -347.00519640023;
                ["x"] = 569.74657333886;
                ["g"] = 2;
                ["sublevel"] = 1;
            };
        };
        ["reaping"] = 148716;
        ["scale"] = 1.2;
        ["spells"] = {
            [270003] = {};
            [270016] = {};
        };
        ["id"] = 133935;
        ["name"] = "Animated Guardian";
        ["health"] = 1306442;
        ["displayId"] = 83252;
        ["creatureType"] = "Undead";
        ["level"] = 120;
        ["count"] = 8;
        ["characteristics"] = {
            ["Taunt"] = true;
        };
    };
    [2] = {
        ["clones"] = {
            [1] = {
                ["y"] = -295.96232708431;
                ["x"] = 579.55736334838;
                ["g"] = 1;
                ["sublevel"] = 1;
            };
            [2] = {
                ["y"] = -302.19794887338;
                ["x"] = 587.77164774499;
                ["g"] = 1;
                ["sublevel"] = 1;
            };
            [3] = {
                ["y"] = -286.37755813248;
                ["x"] = 583.44740315553;
                ["g"] = 1;
                ["sublevel"] = 1;
            };
            [4] = {
                ["y"] = -290.30617913899;
                ["x"] = 587.33737468746;
                ["g"] = 1;
                ["sublevel"] = 1;
            };
            [5] = {
                ["sublevel"] = 1;
                ["x"] = 579.96281538326;
                ["infested"] = {
                    [1] = true;
                };
                ["g"] = 1;
                ["y"] = -290.70197655371;
            };
            [6] = {
                ["y"] = -294.95855858684;
                ["x"] = 584.45123295845;
                ["g"] = 1;
                ["sublevel"] = 1;
            };
            [7] = {
                ["y"] = -296.15555540325;
                ["x"] = 590.34887106599;
                ["g"] = 1;
                ["sublevel"] = 1;
            };
            [8] = {
                ["y"] = -300.47986122602;
                ["x"] = 581.93184656812;
                ["g"] = 1;
                ["sublevel"] = 1;
            };
            [9] = {
                ["y"] = -380.41696219116;
                ["x"] = 653.14141056841;
                ["g"] = 4;
                ["sublevel"] = 1;
            };
            [10] = {
                ["y"] = -374.84003111977;
                ["x"] = 654.8721862644;
                ["g"] = 4;
                ["sublevel"] = 1;
            };
            [11] = {
                ["y"] = -373.49389241899;
                ["x"] = 660.44908432399;
                ["g"] = 4;
                ["sublevel"] = 1;
            };
            [12] = {
                ["y"] = -377.14772104383;
                ["x"] = 664.87217043335;
                ["g"] = 4;
                ["sublevel"] = 1;
            };
            [13] = {
                ["y"] = -378.68618649517;
                ["x"] = 658.52601488924;
                ["patrol"] = {
                    [1] = {
                        ["y"] = -378.68618649517;
                        ["x"] = 658.52601488924;
                    };
                    [2] = {
                        ["y"] = -395.03233446118;
                        ["x"] = 659.29522285606;
                    };
                    [3] = {
                        ["y"] = -405.41694737239;
                        ["x"] = 652.94908381785;
                    };
                    [4] = {
                        ["y"] = -407.34002506008;
                        ["x"] = 631.02599652751;
                    };
                    [5] = {
                        ["y"] = -393.30156701813;
                        ["x"] = 615.25677104251;
                    };
                    [6] = {
                        ["y"] = -374.45542713636;
                        ["x"] = 614.8721670591;
                    };
                    [7] = {
                        ["y"] = -364.84001393902;
                        ["x"] = 626.98753090745;
                    };
                    [8] = {
                        ["y"] = -364.0708059722;
                        ["x"] = 641.21830744701;
                    };
                    [9] = {
                        ["y"] = -368.10927159225;
                        ["x"] = 652.37215308389;
                    };
                };
                ["g"] = 4;
                ["sublevel"] = 1;
            };
            [14] = {
                ["sublevel"] = 1;
                ["x"] = 662.94908449271;
                ["infested"] = {
                    [1] = true;
                };
                ["g"] = 4;
                ["y"] = -382.14772138125;
            };
        };
        ["scale"] = 0.6;
        ["spells"] = {
            [269935] = {};
            [269936] = {};
        };
        ["id"] = 133943;
        ["name"] = "Minion of Zul";
        ["health"] = 36;
        ["displayId"] = 76055;
        ["creatureType"] = "Aberration";
        ["level"] = 120;
        ["count"] = 0;
        ["characteristics"] = {
            ["Taunt"] = true;
            ["Slow"] = true;
        };
    };
    [3] = {
        ["clones"] = {
            [1] = {
                ["y"] = -369.15880658614;
                ["x"] = 644.48115161493;
                ["g"] = 3;
                ["sublevel"] = 1;
            };
            [2] = {
                ["y"] = -371.99492624218;
                ["x"] = 613.48433294179;
                ["g"] = 6;
                ["sublevel"] = 1;
            };
            [3] = {
                ["y"] = -404.14303243834;
                ["x"] = 625.19654199879;
                ["g"] = 7;
                ["sublevel"] = 1;
            };
            [4] = {
                ["y"] = -406.66729442915;
                ["x"] = 649.03882925229;
                ["teeming"] = true;
                ["g"] = 5;
                ["sublevel"] = 1;
            };
        };
        ["reaping"] = 148894;
        ["scale"] = 1;
        ["spells"] = {
            [269973] = {};
            [269972] = {};
        };
        ["id"] = 134174;
        ["name"] = "Shadow-Borne Witch Doctor";
        ["health"] = 1152741;
        ["displayId"] = 83371;
        ["creatureType"] = "Undead";
        ["level"] = 121;
        ["count"] = 5;
        ["characteristics"] = {
            ["Taunt"] = true;
        };
    };
    [4] = {
        ["clones"] = {
            [1] = {
                ["y"] = -360.95316686591;
                ["x"] = 649.17497479225;
                ["g"] = 3;
                ["sublevel"] = 1;
            };
            [2] = {
                ["y"] = -399.99837265627;
                ["x"] = 618.80601065983;
                ["g"] = 7;
                ["sublevel"] = 1;
            };
        };
        ["reaping"] = 148894;
        ["scale"] = 1.2;
        ["spells"] = {
            [269928] = {};
            [269976] = {};
        };
        ["id"] = 134158;
        ["name"] = "Shadow-Borne Champion";
        ["health"] = 1229590;
        ["displayId"] = 83364;
        ["creatureType"] = "Undead";
        ["level"] = 121;
        ["count"] = 6;
        ["characteristics"] = {
            ["Taunt"] = true;
        };
    };
    [5] = {
        ["clones"] = {
            [1] = {
                ["y"] = -404.07080041865;
                ["x"] = 656.98756594381;
                ["g"] = 5;
                ["sublevel"] = 1;
            };
            [2] = {
                ["y"] = -363.91468550014;
                ["x"] = 617.28195299766;
                ["g"] = 6;
                ["sublevel"] = 1;
            };
            [3] = {
                ["y"] = -379.70414562625;
                ["x"] = 610.96617120592;
                ["g"] = 6;
                ["sublevel"] = 1;
            };
            [4] = {
                ["y"] = -407.83867796512;
                ["x"] = 631.06612958635;
                ["g"] = 7;
                ["sublevel"] = 1;
            };
            [5] = {
                ["y"] = -397.57817954204;
                ["x"] = 611.11041646257;
                ["g"] = 7;
                ["sublevel"] = 1;
            };
            [6] = {
                ["y"] = -396.59727191278;
                ["x"] = 652.51044131347;
                ["g"] = 5;
                ["sublevel"] = 1;
            };
        };
        ["reaping"] = 148716;
        ["scale"] = 1;
        ["spells"] = {
            [269931] = {};
        };
        ["id"] = 134157;
        ["name"] = "Shadow-Borne Warrior";
        ["health"] = 768494;
        ["displayId"] = 83363;
        ["creatureType"] = "Undead";
        ["level"] = 120;
        ["count"] = 4;
        ["characteristics"] = {
            ["Taunt"] = true;
            ["Disorient"] = true;
            ["Stun"] = true;
            ["Slow"] = true;
            ["Fear"] = true;
        };
    };
    [6] = {
        ["clones"] = {
            [1] = {
                ["y"] = -372.2704342334;
                ["x"] = 688.65120787074;
                ["sublevel"] = 1;
            };
        };
        ["name"] = "The Golden Serpent";
        ["characteristics"] = {
            ["Taunt"] = true;
        };
        ["spells"] = {
            [265773] = {};
            [265910] = {};
            [265923] = {};
            [265781] = {};
        };
        ["isBoss"] = true;
        ["encounterID"] = 2165;
        ["instanceID"] = 1041;
        ["count"] = 0;
        ["health"] = 5379459;
        ["displayId"] = 84202;
        ["creatureType"] = "Elemental";
        ["level"] = 122;
        ["scale"] = 1;
        ["id"] = 135322;
    };
    [7] = {
        ["clones"] = {
            [1] = {
                ["y"] = -431.61883843803;
                ["x"] = 525.57585072102;
                ["g"] = 8;
                ["sublevel"] = 1;
            };
        };
        ["reaping"] = 148716;
        ["id"] = 137487;
        ["spells"] = {
            [270502] = {};
            [270500] = {};
            [270503] = {};
        };
        ["scale"] = 0.8;
        ["count"] = 4;
        ["name"] = "Skeletal Hunting Raptor";
        ["displayId"] = 33733;
        ["creatureType"] = "Undead";
        ["level"] = 120;
        ["health"] = 768494;
        ["characteristics"] = {
            ["Taunt"] = true;
        };
    };
    [8] = {
        ["clones"] = {
            [1] = {
                ["sublevel"] = 1;
                ["x"] = 521.22807855253;
                ["infested"] = {
                    [3] = true;
                };
                ["g"] = 8;
                ["y"] = -426.40147078639;
            };
        };
        ["reaping"] = 148894;
        ["id"] = 137486;
        ["spells"] = {
            [270505] = {};
            [270930] = {};
        };
        ["scale"] = 1;
        ["count"] = 4;
        ["name"] = "Queen Patlaa";
        ["displayId"] = 85287;
        ["creatureType"] = "Undead";
        ["level"] = 121;
        ["health"] = 1229590;
        ["characteristics"] = {
            ["Taunt"] = true;
        };
    };
    [9] = {
        ["clones"] = {
            [1] = {
                ["y"] = -457.6983857759;
                ["x"] = 521.56865290318;
                ["g"] = 9;
                ["sublevel"] = 1;
            };
        };
        ["reaping"] = 148894;
        ["id"] = 137484;
        ["spells"] = {
            [270865] = {};
        };
        ["scale"] = 1;
        ["count"] = 6;
        ["name"] = "King A'akul";
        ["displayId"] = 85284;
        ["creatureType"] = "Undead";
        ["level"] = 121;
        ["health"] = 1998085;
        ["characteristics"] = {
            ["Taunt"] = true;
        };
    };
    [10] = {
        ["clones"] = {
            [1] = {
                ["y"] = -460.34119353936;
                ["x"] = 514.43224899307;
                ["g"] = 9;
                ["sublevel"] = 1;
            };
            [2] = {
                ["y"] = -452.87850497532;
                ["x"] = 514.88000326111;
                ["g"] = 9;
                ["sublevel"] = 1;
            };
            [3] = {
                ["y"] = -452.52344758657;
                ["x"] = 527.69851004025;
                ["g"] = 9;
                ["sublevel"] = 1;
            };
            [4] = {
                ["sublevel"] = 1;
                ["x"] = 528.1635677677;
                ["infested"] = {
                    [2] = true;
                };
                ["g"] = 9;
                ["y"] = -459.59492148032;
            };
            [5] = {
                ["y"] = -448.86805921663;
                ["x"] = 521.59986789148;
                ["teeming"] = true;
                ["g"] = 9;
                ["sublevel"] = 1;
            };
        };
        ["reaping"] = 148716;
        ["id"] = 137485;
        ["spells"] = {
            [270872] = {};
        };
        ["scale"] = 0.7;
        ["count"] = 4;
        ["name"] = "Bloodsworn Agent";
        ["displayId"] = 85285;
        ["creatureType"] = "Undead";
        ["level"] = 120;
        ["health"] = 768494;
        ["characteristics"] = {
            ["Taunt"] = true;
            ["Slow"] = true;
            ["Stun"] = true;
            ["Disorient"] = true;
        };
    };
    [11] = {
        ["clones"] = {
            [1] = {
                ["y"] = -455.83555927438;
                ["x"] = 540.62439938763;
                ["g"] = 10;
                ["sublevel"] = 1;
            };
        };
        ["reaping"] = 148893;
        ["id"] = 134251;
        ["spells"] = {
            [270901] = {};
        };
        ["scale"] = 1;
        ["count"] = 4;
        ["name"] = "Seneschal M'bara";
        ["displayId"] = 83517;
        ["creatureType"] = "Undead";
        ["level"] = 120;
        ["health"] = 768494;
        ["characteristics"] = {
            ["Taunt"] = true;
        };
    };
    [12] = {
        ["clones"] = {
            [1] = {
                ["sublevel"] = 1;
                ["x"] = 554.1015139403;
                ["infested"] = {
                    [2] = true;
                };
                ["g"] = 10;
                ["y"] = -455.06108904006;
            };
        };
        ["reaping"] = 148716;
        ["id"] = 137473;
        ["spells"] = {
            [270084] = {};
        };
        ["scale"] = 1;
        ["count"] = 4;
        ["name"] = "Guard Captain Atu";
        ["displayId"] = 85270;
        ["creatureType"] = "Undead";
        ["level"] = 120;
        ["health"] = 1248802;
        ["characteristics"] = {
            ["Stun"] = true;
            ["Slow"] = true;
            ["Taunt"] = true;
            ["Disorient"] = true;
        };
    };
    [13] = {
        ["clones"] = {
            [1] = {
                ["y"] = -459.67649699281;
                ["x"] = 548.0568362321;
                ["g"] = 10;
                ["sublevel"] = 1;
            };
        };
        ["reaping"] = 148894;
        ["scale"] = 1;
        ["spells"] = {
            [270889] = {};
            [270891] = {};
        };
        ["name"] = "King Rahu'ai";
        ["health"] = 1229590;
        ["displayId"] = 83544;
        ["creatureType"] = "Undead";
        ["level"] = 121;
        ["id"] = 134331;
        ["count"] = 6;
    };
    [14] = {
        ["clones"] = {
            [1] = {
                ["sublevel"] = 1;
                ["x"] = 544.60908072961;
                ["infested"] = {
                    [3] = true;
                };
                ["g"] = 11;
                ["y"] = -430.9731833347;
            };
        };
        ["reaping"] = 148894;
        ["scale"] = 1;
        ["spells"] = {
            [270927] = {};
            [270928] = {};
        };
        ["id"] = 137474;
        ["name"] = "King Timalji";
        ["health"] = 1229590;
        ["displayId"] = 85272;
        ["creatureType"] = "Undead";
        ["level"] = 121;
        ["count"] = 6;
        ["characteristics"] = {
            ["Taunt"] = true;
        };
    };
    [15] = {
        ["clones"] = {
            [1] = {
                ["y"] = -425.39626051626;
                ["x"] = 548.07059910979;
                ["g"] = 11;
                ["sublevel"] = 1;
            };
        };
        ["reaping"] = 148894;
        ["scale"] = 1;
        ["spells"] = {
            [280404] = {};
            [5116] = {};
            [270923] = {};
            [212792] = {};
            [270920] = {};
            [186439] = {};
            [589] = {};
        };
        ["id"] = 137478;
        ["name"] = "Queen Wasi";
        ["health"] = 1229590;
        ["displayId"] = 85274;
        ["creatureType"] = "Undead";
        ["level"] = 121;
        ["count"] = 6;
        ["characteristics"] = {
            ["Taunt"] = true;
        };
    };
    [16] = {
        ["clones"] = {
            [1] = {
                ["y"] = -291.32358838882;
                ["x"] = 454.58731500022;
                ["g"] = 26;
                ["sublevel"] = 1;
            };
            [2] = {
                ["y"] = -154.52287652609;
                ["x"] = 435.79581678115;
                ["patrol"] = {
                    [1] = {
                        ["y"] = -154.52287652609;
                        ["x"] = 435.79581678115;
                    };
                    [2] = {
                        ["y"] = -165.52340305175;
                        ["x"] = 448.56290445001;
                    };
                    [3] = {
                        ["y"] = -168.21570521217;
                        ["x"] = 480.1013389141;
                    };
                    [4] = {
                        ["y"] = -165.52340305175;
                        ["x"] = 448.56290445001;
                    };
                    [5] = {
                        ["y"] = -154.52287652609;
                        ["x"] = 435.79581678115;
                    };
                    [6] = {
                        ["y"] = -140.15923724727;
                        ["x"] = 431.0685438846;
                    };
                    [7] = {
                        ["y"] = -127.66456407374;
                        ["x"] = 429.56321964007;
                    };
                    [8] = {
                        ["y"] = -120.54920056281;
                        ["x"] = 440.14015104888;
                    };
                    [9] = {
                        ["y"] = -103.43379511228;
                        ["x"] = 441.29397950501;
                    };
                    [10] = {
                        ["y"] = -120.54920056281;
                        ["x"] = 440.14015104888;
                    };
                    [11] = {
                        ["y"] = -127.66456407374;
                        ["x"] = 429.56321964007;
                    };
                    [12] = {
                        ["y"] = -140.15923724727;
                        ["x"] = 431.0685438846;
                    };
                };
                ["teeming"] = true;
                ["sublevel"] = 1;
            };
        };
        ["reaping"] = 148894;
        ["id"] = 134739;
        ["spells"] = {
            [270293] = {};
            [270284] = {};
        };
        ["scale"] = 1.2;
        ["health"] = 1844388;
        ["count"] = 10;
        ["displayId"] = 83836;
        ["creatureType"] = "Undead";
        ["level"] = 120;
        ["name"] = "Purification Construct";
        ["characteristics"] = {
            ["Taunt"] = true;
        };
    };
    [17] = {
        ["clones"] = {
            [1] = {
                ["y"] = -154.42099320188;
                ["x"] = 489.18748663995;
                ["infested"] = {
                    [3] = true;
                };
                ["sublevel"] = 1;
            };
            [2] = {
                ["y"] = -108.54318222106;
                ["x"] = 427.55797998268;
                ["sublevel"] = 1;
            };
        };
        ["reaping"] = 148894;
        ["id"] = 137969;
        ["spells"] = {
            [271561] = {};
            [271562] = {};
            [271555] = {};
        };
        ["scale"] = 1;
        ["health"] = 1536988;
        ["count"] = 6;
        ["displayId"] = 85677;
        ["creatureType"] = "Undead";
        ["level"] = 120;
        ["name"] = "Interment Construct";
        ["characteristics"] = {
            ["Taunt"] = true;
        };
    };
    [18] = {
        ["clones"] = {
            [1] = {
                ["y"] = -137.93607693106;
                ["x"] = 458.30808870121;
                ["sublevel"] = 1;
            };
        };
        ["name"] = "Mchimba the Embalmer";
        ["characteristics"] = {
            ["Taunt"] = true;
        };
        ["spells"] = {
            [271290] = {};
            [267702] = {};
            [267639] = {};
            [267618] = {};
        };
        ["isBoss"] = true;
        ["encounterID"] = 2171;
        ["instanceID"] = 1041;
        ["count"] = 0;
        ["health"] = 5379459;
        ["displayId"] = 83529;
        ["creatureType"] = "Mechanical";
        ["level"] = 122;
        ["scale"] = 1;
        ["id"] = 134993;
    };
    [19] = {
        ["clones"] = {
            [1] = {
                ["sublevel"] = 1;
                ["x"] = 360.49068890929;
                ["g"] = 12;
                ["y"] = -108.4239891806;
            };
            [2] = {
                ["sublevel"] = 1;
                ["x"] = 377.3998325625;
                ["y"] = -108.64218956602;
                ["g"] = 12;
                ["infested"] = {
                    [2] = true;
                };
            };
            [3] = {
                ["y"] = -221.4358842164;
                ["x"] = 363.8363702754;
                ["g"] = 15;
                ["sublevel"] = 1;
            };
            [4] = {
                ["sublevel"] = 1;
                ["x"] = 372.54227536014;
                ["infested"] = {
                    [2] = true;
                };
                ["g"] = 16;
                ["y"] = -265.35726521035;
            };
            [5] = {
                ["y"] = -304.8006780133;
                ["x"] = 361.2857550291;
                ["g"] = 17;
                ["sublevel"] = 1;
            };
        };
        ["reaping"] = 148893;
        ["scale"] = 1;
        ["spells"] = {
            [270493] = {};
            [270492] = {};
        };
        ["id"] = 135204;
        ["name"] = "Spectral Hex Priest";
        ["health"] = 691644;
        ["displayId"] = 84140;
        ["creatureType"] = "Undead";
        ["level"] = 120;
        ["count"] = 4;
        ["characteristics"] = {
            ["Taunt"] = true;
            ["Incapacitate"] = true;
            ["Shackle Undead"] = true;
            ["Silence"] = true;
            ["Slow"] = true;
            ["Stun"] = true;
            ["Disorient"] = true;
        };
    };
    [20] = {
        ["clones"] = {
            [1] = {
                ["sublevel"] = 1;
                ["x"] = 364.63621221091;
                ["g"] = 12;
                ["y"] = -115.69673076676;
            };
            [2] = {
                ["y"] = -148.52496076889;
                ["x"] = 375.20441685604;
                ["g"] = 13;
                ["sublevel"] = 1;
            };
            [3] = {
                ["y"] = -218.35896156667;
                ["x"] = 373.25945672219;
                ["g"] = 15;
                ["sublevel"] = 1;
            };
            [4] = {
                ["y"] = -323.47662382868;
                ["x"] = 367.75409053435;
                ["g"] = 27;
                ["sublevel"] = 1;
            };
            [5] = {
                ["y"] = -343.70848580739;
                ["x"] = 362.25927403815;
                ["g"] = 29;
                ["sublevel"] = 1;
            };
            [6] = {
                ["y"] = -343.91254388122;
                ["x"] = 374.09595637265;
                ["g"] = 18;
                ["sublevel"] = 1;
            };
        };
        ["reaping"] = 148894;
        ["scale"] = 1;
        ["spells"] = {
            [270487] = {};
            [270482] = {};
            [270485] = {};
        };
        ["id"] = 135167;
        ["name"] = "Spectral Berserker";
        ["health"] = 922193;
        ["displayId"] = 84112;
        ["creatureType"] = "Undead";
        ["level"] = 121;
        ["count"] = 4;
        ["characteristics"] = {
            ["Taunt"] = true;
            ["Incapacitate"] = true;
            ["Shackle Undead"] = true;
            ["Silence"] = true;
            ["Root"] = true;
            ["Slow"] = true;
            ["Stun"] = true;
            ["Disorient"] = true;
        };
    };
    [21] = {
        ["clones"] = {
            [1] = {
                ["sublevel"] = 1;
                ["x"] = 362.30121150729;
                ["infested"] = {
                    [3] = true;
                };
                ["g"] = 13;
                ["y"] = -148.20237578989;
            };
            [2] = {
                ["sublevel"] = 1;
                ["x"] = 363.06714580268;
                ["infested"] = {
                    [1] = true;
                };
                ["g"] = 15;
                ["y"] = -214.51280619128;
            };
            [3] = {
                ["sublevel"] = 1;
                ["x"] = 374.79926462779;
                ["infested"] = {
                    [2] = true;
                };
                ["g"] = 28;
                ["y"] = -305.34123741919;
            };
            [4] = {
                ["y"] = -115.89776031762;
                ["x"] = 373.41261882941;
                ["teeming"] = true;
                ["g"] = 12;
                ["sublevel"] = 1;
            };
        };
        ["reaping"] = 148893;
        ["scale"] = 1;
        ["spells"] = {
            [270499] = {};
            [270497] = {};
            [205276] = {};
        };
        ["id"] = 135239;
        ["name"] = "Spectral Witch Doctor";
        ["health"] = 768494;
        ["displayId"] = 84163;
        ["creatureType"] = "Undead";
        ["level"] = 120;
        ["count"] = 4;
        ["characteristics"] = {
            ["Taunt"] = true;
            ["Disorient"] = true;
            ["Stun"] = true;
            ["Slow"] = true;
            ["Silence"] = true;
        };
    };
    [22] = {
        ["clones"] = {
            [1] = {
                ["y"] = -197.3859907164;
                ["x"] = 368.59110920942;
                ["patrol"] = {
                    [1] = {
                        ["y"] = -197.3859907164;
                        ["x"] = 368.59110920942;
                    };
                    [2] = {
                        ["y"] = -182.76004846191;
                        ["x"] = 368.59110920942;
                    };
                    [3] = {
                        ["y"] = -168.0541335897;
                        ["x"] = 368.59110920942;
                    };
                    [4] = {
                        ["y"] = -154.23062132159;
                        ["x"] = 368.59110920942;
                    };
                    [5] = {
                        ["y"] = -168.0541335897;
                        ["x"] = 368.59110920942;
                    };
                    [6] = {
                        ["y"] = -182.76004846191;
                        ["x"] = 368.59110920942;
                    };
                    [7] = {
                        ["y"] = -197.3859907164;
                        ["x"] = 368.59110920942;
                    };
                    [8] = {
                        ["y"] = -211.87768089417;
                        ["x"] = 368.59110920942;
                    };
                    [9] = {
                        ["y"] = -233.34826586652;
                        ["x"] = 368.59110920942;
                    };
                    [10] = {
                        ["y"] = -249.52475076828;
                        ["x"] = 368.59110920942;
                    };
                    [11] = {
                        ["y"] = -265.11729441018;
                        ["x"] = 368.59110920942;
                    };
                    [12] = {
                        ["y"] = -279.95599464804;
                        ["x"] = 368.59110920942;
                    };
                    [13] = {
                        ["y"] = -294.79470872956;
                        ["x"] = 368.59110920942;
                    };
                    [14] = {
                        ["y"] = -308.9882529027;
                        ["x"] = 368.59110920942;
                    };
                    [15] = {
                        ["y"] = -294.79470872956;
                        ["x"] = 368.59110920942;
                    };
                    [16] = {
                        ["y"] = -279.95599464804;
                        ["x"] = 368.59110920942;
                    };
                    [17] = {
                        ["y"] = -265.11729441018;
                        ["x"] = 368.59110920942;
                    };
                    [18] = {
                        ["y"] = -249.52475076828;
                        ["x"] = 368.59110920942;
                    };
                    [19] = {
                        ["y"] = -233.34826586652;
                        ["x"] = 368.59110920942;
                    };
                    [20] = {
                        ["y"] = -211.87768089417;
                        ["x"] = 368.59110920942;
                    };
                };
                ["sublevel"] = 1;
            };
            [2] = {
                ["sublevel"] = 1;
                ["x"] = 369.03194027949;
                ["patrol"] = {};
                ["teeming"] = true;
                ["y"] = -128.69513926384;
            };
        };
        ["reaping"] = 148894;
        ["scale"] = 1;
        ["spells"] = {
            [270514] = {};
        };
        ["id"] = 135231;
        ["name"] = "Spectral Brute";
        ["health"] = 1536988;
        ["displayId"] = 85125;
        ["creatureType"] = "Undead";
        ["level"] = 121;
        ["count"] = 8;
        ["characteristics"] = {
            ["Taunt"] = true;
        };
    };
    [23] = {
        ["clones"] = {
            [1] = {
                ["y"] = -175.70361086042;
                ["x"] = 367.80611402575;
                ["g"] = 14;
                ["sublevel"] = 1;
            };
            [2] = {
                ["y"] = -269.58804107506;
                ["x"] = 364.46537713183;
                ["g"] = 16;
                ["sublevel"] = 1;
            };
        };
        ["reaping"] = 148716;
        ["scale"] = 1;
        ["spells"] = {
            [270505] = {};
            [270506] = {};
            [270507] = {};
        };
        ["id"] = 135235;
        ["name"] = "Spectral Beastmaster";
        ["health"] = 730070;
        ["displayId"] = 84112;
        ["creatureType"] = "Undead";
        ["level"] = 120;
        ["count"] = 4;
        ["characteristics"] = {
            ["Taunt"] = true;
            ["Disorient"] = true;
            ["Shackle Undead"] = true;
            ["Stun"] = true;
            ["Silence"] = true;
        };
    };
    [24] = {
        ["clones"] = {
            [1] = {
                ["sublevel"] = 1;
                ["x"] = 360.12370439013;
                ["infested"] = {};
                ["g"] = 14;
                ["y"] = -171.65071910507;
            };
            [2] = {
                ["y"] = -171.9096211427;
                ["x"] = 374.48196559793;
                ["g"] = 14;
                ["sublevel"] = 1;
            };
            [3] = {
                ["y"] = -260.40448798552;
                ["x"] = 364.12400057492;
                ["g"] = 16;
                ["sublevel"] = 1;
            };
            [4] = {
                ["y"] = -319.65113478992;
                ["x"] = 361.1921892781;
                ["teeming"] = true;
                ["g"] = 27;
                ["sublevel"] = 1;
            };
        };
        ["reaping"] = 148716;
        ["scale"] = 1;
        ["spells"] = {
            [270502] = {};
            [270500] = {};
            [270503] = {};
        };
        ["id"] = 135192;
        ["name"] = "Honored Raptor";
        ["health"] = 768494;
        ["displayId"] = 84133;
        ["creatureType"] = "Undead";
        ["level"] = 120;
        ["count"] = 4;
        ["characteristics"] = {
            ["Taunt"] = true;
            ["Disorient"] = true;
            ["Stun"] = true;
        };
    };
    [25] = {
        ["clones"] = {
            [1] = {
                ["y"] = -313.17907623408;
                ["x"] = 374.52899072422;
                ["g"] = 28;
                ["sublevel"] = 1;
            };
            [2] = {
                ["y"] = -312.90879073176;
                ["x"] = 360.74523041944;
                ["g"] = 17;
                ["sublevel"] = 1;
            };
        };
        ["reaping"] = 148716;
        ["scale"] = 1;
        ["id"] = 134994;
        ["health"] = 249760;
        ["count"] = 1;
        ["displayId"] = 84026;
        ["creatureType"] = "Undead";
        ["level"] = 120;
        ["name"] = "Spectral Headhunter";
        ["characteristics"] = {
            ["Silence"] = true;
            ["Disorient"] = true;
            ["Stun"] = true;
        };
    };
    [26] = {
        ["clones"] = {
            [1] = {
                ["y"] = -452.64135913698;
                ["x"] = 368.54412153426;
                ["g"] = 19;
                ["sublevel"] = 1;
            };
        };
        ["id"] = 135472;
        ["scale"] = 1;
        ["spells"] = {
            [267308] = {};
            [267273] = {};
            [267060] = {};
        };
        ["isBoss"] = true;
        ["encounterID"] = 2170;
        ["instanceID"] = 1041;
        ["name"] = "Zanazal the Wise";
        ["count"] = 0;
        ["displayId"] = 84271;
        ["creatureType"] = "Undead";
        ["level"] = 122;
        ["health"] = 2766579;
        ["characteristics"] = {
            ["Taunt"] = true;
        };
    };
    [27] = {
        ["clones"] = {
            [1] = {
                ["y"] = -443.23180510135;
                ["x"] = 392.4457697218;
                ["g"] = 19;
                ["sublevel"] = 1;
            };
        };
        ["characteristics"] = {
            ["Taunt"] = true;
        };
        ["id"] = 135475;
        ["spells"] = {
            [266206] = {};
            [266231] = {};
        };
        ["isBoss"] = true;
        ["encounterID"] = 2170;
        ["instanceID"] = 1041;
        ["count"] = 0;
        ["health"] = 2766579;
        ["displayId"] = 84272;
        ["creatureType"] = "Undead";
        ["level"] = 122;
        ["name"] = "Kula the Butcher";
        ["scale"] = 1;
    };
    [28] = {
        ["clones"] = {
            [1] = {
                ["y"] = -443.04952612989;
                ["x"] = 344.87061736905;
                ["g"] = 19;
                ["sublevel"] = 1;
            };
        };
        ["characteristics"] = {
            ["Taunt"] = true;
        };
        ["id"] = 135470;
        ["spells"] = {
            [266951] = {};
            [266939] = {};
            [266940] = {};
            [266237] = {};
        };
        ["isBoss"] = true;
        ["encounterID"] = 2170;
        ["instanceID"] = 1041;
        ["count"] = 0;
        ["health"] = 2766579;
        ["displayId"] = 84269;
        ["creatureType"] = "Undead";
        ["level"] = 122;
        ["name"] = "Aka'ali the Conqueror";
        ["scale"] = 1;
    };
    [29] = {
        ["clones"] = {
            [1] = {
                ["y"] = -265.0199630942;
                ["x"] = 248.16149326946;
                ["sublevel"] = 1;
            };
        };
        ["scale"] = 1.2;
        ["spells"] = {
            [272388] = {};
            [271640] = {};
        };
        ["id"] = 138489;
        ["name"] = "Shadow of Zul";
        ["health"] = 2612880;
        ["displayId"] = 85860;
        ["creatureType"] = "Humanoid";
        ["level"] = -1;
        ["count"] = 8;
        ["characteristics"] = {
            ["Taunt"] = true;
        };
    };
    [30] = {
        ["clones"] = {
            [1] = {
                ["y"] = -264.67742362195;
                ["x"] = 138.54486286561;
                ["sublevel"] = 1;
            };
        };
        ["characteristics"] = {
            ["Taunt"] = true;
        };
        ["id"] = 136160;
        ["spells"] = {
            [268586] = {};
            [268932] = {};
            [268590] = {};
            [268403] = {};
            [268587] = {};
            [268589] = {};
            [268591] = {};
            [268936] = {};
        };
        ["isBoss"] = true;
        ["encounterID"] = 2172;
        ["instanceID"] = 1041;
        ["health"] = 5994255;
        ["count"] = 0;
        ["displayId"] = 84352;
        ["creatureType"] = "Undead";
        ["level"] = 122;
        ["name"] = "King Dazar";
        ["scale"] = 1;
    };
    [31] = {
        ["clones"] = {
            [1] = {
                ["y"] = -150.52339378653;
                ["x"] = 430.10136855165;
                ["g"] = 20;
                ["sublevel"] = 1;
            };
            [2] = {
                ["y"] = -151.4849450098;
                ["x"] = 441.25521418853;
                ["g"] = 20;
                ["sublevel"] = 1;
            };
            [3] = {
                ["y"] = -160.71570470603;
                ["x"] = 439.33214475378;
                ["g"] = 20;
                ["sublevel"] = 1;
            };
            [4] = {
                ["y"] = -163.40800686645;
                ["x"] = 431.83212774174;
                ["g"] = 20;
                ["sublevel"] = 1;
            };
            [5] = {
                ["sublevel"] = 1;
                ["x"] = 428.17379966119;
                ["y"] = -157.12851357868;
                ["g"] = 20;
                ["infested"] = {
                    [1] = true;
                };
            };
            [6] = {
                ["y"] = -172.59592291074;
                ["x"] = 454.6196161264;
                ["g"] = 21;
                ["sublevel"] = 1;
            };
            [7] = {
                ["sublevel"] = 1;
                ["x"] = 459.85519814966;
                ["y"] = -173.95538022775;
                ["g"] = 21;
                ["infested"] = {
                    [1] = true;
                };
            };
            [8] = {
                ["sublevel"] = 1;
                ["x"] = 420.42490764921;
                ["y"] = -170.1560238531;
                ["g"] = 22;
                ["infested"] = {
                    [1] = true;
                };
            };
            [9] = {
                ["y"] = -174.57461782382;
                ["x"] = 423.44816403468;
                ["g"] = 22;
                ["sublevel"] = 1;
            };
            [10] = {
                ["y"] = -138.10193453494;
                ["x"] = 416.82675422692;
                ["g"] = 23;
                ["sublevel"] = 1;
            };
            [11] = {
                ["y"] = -138.10193453494;
                ["x"] = 421.6093707841;
                ["g"] = 23;
                ["sublevel"] = 1;
            };
            [12] = {
                ["y"] = -143.31932084543;
                ["x"] = 418.78328342278;
                ["g"] = 23;
                ["sublevel"] = 1;
            };
            [13] = {
                ["y"] = -118.6855326393;
                ["x"] = 424.85164060479;
                ["g"] = 24;
                ["sublevel"] = 1;
            };
            [14] = {
                ["y"] = -123.42238592338;
                ["x"] = 425.90427466792;
                ["g"] = 24;
                ["sublevel"] = 1;
            };
            [15] = {
                ["y"] = -114.8697553358;
                ["x"] = 440.64111767117;
                ["g"] = 25;
                ["sublevel"] = 1;
            };
            [16] = {
                ["y"] = -112.23817582473;
                ["x"] = 445.24638463891;
                ["g"] = 25;
                ["sublevel"] = 1;
            };
            [17] = {
                ["y"] = -118.42239388716;
                ["x"] = 445.37796530849;
                ["g"] = 25;
                ["sublevel"] = 1;
            };
        };
        ["reaping"] = 148716;
        ["scale"] = 0.7;
        ["spells"] = {
            [271565] = {};
            [271563] = {};
        };
        ["id"] = 137989;
        ["count"] = 1;
        ["name"] = "Embalming Fluid";
        ["displayId"] = 33008;
        ["creatureType"] = "Aberration";
        ["level"] = 120;
        ["health"] = 461096;
        ["characteristics"] = {
            ["Taunt"] = true;
            ["Disorient"] = true;
            ["Stun"] = true;
            ["Slow"] = true;
            ["Root"] = true;
            ["Silence"] = true;
        };
    };
    [32] = {
        ["clones"] = {
            [1] = {
                ["y"] = -263.96196757677;
                ["x"] = 573.58830584234;
                ["week"] = {
                    [1] = true;
                    [10] = true;
                    [4] = true;
                    [7] = true;
                };
                ["sublevel"] = 1;
            };
            [2] = {
                ["y"] = -378.11899619221;
                ["x"] = 620.55387128066;
                ["week"] = {
                    [1] = true;
                    [10] = true;
                    [7] = true;
                    [4] = true;
                };
                ["g"] = 6;
                ["sublevel"] = 1;
            };
            [3] = {
                ["y"] = -162.18514473695;
                ["x"] = 489.26017958649;
                ["week"] = {
                    [1] = true;
                    [10] = true;
                    [4] = true;
                    [7] = true;
                };
                ["sublevel"] = 1;
            };
            [4] = {
                ["y"] = -401.35554852597;
                ["x"] = 631.12951027323;
                ["sublevel"] = 1;
                ["g"] = 7;
                ["week"] = {
                    [8] = true;
                    [2] = true;
                    [5] = true;
                    [11] = true;
                };
            };
            [5] = {
                ["y"] = -153.89003453024;
                ["x"] = 424.88018291585;
                ["sublevel"] = 1;
                ["g"] = 20;
                ["week"] = {
                    [8] = true;
                    [2] = true;
                    [5] = true;
                    [11] = true;
                };
            };
            [6] = {
                ["y"] = -120.78625165462;
                ["x"] = 431.37204617622;
                ["sublevel"] = 1;
                ["g"] = 24;
                ["week"] = {
                    [8] = true;
                    [2] = true;
                    [5] = true;
                    [11] = true;
                };
            };
            [7] = {
                ["y"] = -153.47506553655;
                ["x"] = 368.44350476612;
                ["sublevel"] = 1;
                ["g"] = 13;
                ["week"] = {
                    [8] = true;
                    [2] = true;
                    [5] = true;
                    [11] = true;
                };
            };
            [8] = {
                ["y"] = -309.58912302964;
                ["x"] = 367.09589952478;
                ["sublevel"] = 1;
                ["g"] = 17;
                ["week"] = {
                    [8] = true;
                    [2] = true;
                    [5] = true;
                    [11] = true;
                };
            };
            [9] = {
                ["y"] = -377.49360765391;
                ["x"] = 642.63590145335;
                ["sublevel"] = 1;
                ["g"] = 3;
                ["week"] = {
                    [3] = true;
                    [6] = true;
                    [9] = true;
                    [12] = true;
                };
            };
            [10] = {
                ["y"] = -121.65053897829;
                ["x"] = 370.48688454397;
                ["sublevel"] = 1;
                ["g"] = 12;
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
        ["count"] = 4;
        ["displayId"] = 39391;
        ["creatureType"] = "Humanoid";
        ["level"] = 120;
        ["health"] = 614795;
        ["iconTexture"] = 132315;
    };
    [33] = {
        ["clones"] = {
            [1] = {
                ["y"] = -339.95924999324;
                ["x"] = 577.539068238;
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
                ["y"] = -398.33641900168;
                ["x"] = 643.81477117504;
                ["week"] = {
                    [1] = true;
                    [10] = true;
                    [7] = true;
                    [4] = true;
                };
                ["g"] = 30;
                ["sublevel"] = 1;
            };
            [3] = {
                ["y"] = -440.16276125782;
                ["x"] = 555.46722764017;
                ["week"] = {
                    [1] = true;
                    [10] = true;
                    [4] = true;
                    [7] = true;
                };
                ["g"] = 31;
                ["sublevel"] = 1;
            };
            [4] = {
                ["y"] = -291.65149273687;
                ["x"] = 446.75960982379;
                ["week"] = {
                    [1] = true;
                    [10] = true;
                    [7] = true;
                    [4] = true;
                };
                ["g"] = 26;
                ["sublevel"] = 1;
            };
            [5] = {
                ["y"] = -308.96994028012;
                ["x"] = 367.50647674627;
                ["week"] = {
                    [1] = true;
                    [10] = true;
                    [7] = true;
                    [4] = true;
                };
                ["g"] = 17;
                ["sublevel"] = 1;
            };
            [6] = {
                ["y"] = -279.88172112194;
                ["x"] = 579.17054506483;
                ["sublevel"] = 1;
                ["week"] = {
                    [8] = true;
                    [2] = true;
                    [5] = true;
                    [11] = true;
                };
            };
            [7] = {
                ["y"] = -264.31044066847;
                ["x"] = 185.65384202478;
                ["sublevel"] = 1;
                ["g"] = 33;
                ["week"] = {
                    [8] = true;
                    [2] = true;
                    [5] = true;
                    [11] = true;
                };
            };
            [8] = {
                ["y"] = -438.12968280672;
                ["x"] = 473.11521375575;
                ["sublevel"] = 1;
                ["week"] = {
                    [3] = true;
                    [6] = true;
                    [9] = true;
                    [12] = true;
                };
            };
            [9] = {
                ["y"] = -180.5994519166;
                ["x"] = 377.2786561419;
                ["sublevel"] = 1;
                ["g"] = 14;
                ["week"] = {
                    [3] = true;
                    [6] = true;
                    [9] = true;
                    [12] = true;
                };
            };
        };
        ["scale"] = 1;
        ["characteristics"] = {
            ["Taunt"] = true;
        };
        ["spells"] = {
            [302419] = {};
            [302420] = {};
            [302421] = {};
            [302415] = {};
        };
        ["stealthDetect"] = true;
        ["id"] = 155433;
        ["name"] = "Void-Touched Emissary";
        ["ignoreFortified"] = true;
        ["count"] = 4;
        ["displayId"] = 39391;
        ["creatureType"] = "Humanoid";
        ["level"] = 122;
        ["health"] = 999042;
        ["iconTexture"] = 132886;
    };
    [34] = {
        ["clones"] = {
            [1] = {
                ["y"] = -108.53521722425;
                ["x"] = 419.06027599762;
                ["week"] = {
                    [1] = true;
                    [10] = true;
                    [4] = true;
                    [7] = true;
                };
                ["sublevel"] = 1;
            };
            [2] = {
                ["y"] = -183.59661534911;
                ["x"] = 368.32929375765;
                ["week"] = {
                    [1] = true;
                    [10] = true;
                    [7] = true;
                    [4] = true;
                };
                ["g"] = 32;
                ["sublevel"] = 1;
            };
            [3] = {
                ["y"] = -287.80466549342;
                ["x"] = 463.04496517688;
                ["sublevel"] = 1;
                ["g"] = 26;
                ["week"] = {
                    [8] = true;
                    [2] = true;
                    [5] = true;
                    [11] = true;
                };
            };
            [4] = {
                ["y"] = -211.58855735877;
                ["x"] = 368.50715768396;
                ["sublevel"] = 1;
                ["g"] = 15;
                ["week"] = {
                    [8] = true;
                    [2] = true;
                    [5] = true;
                    [11] = true;
                };
            };
            [5] = {
                ["y"] = -338.35594465097;
                ["x"] = 576.45345106033;
                ["sublevel"] = 1;
                ["week"] = {
                    [3] = true;
                    [6] = true;
                    [9] = true;
                    [12] = true;
                };
            };
            [6] = {
                ["y"] = -394.78617143382;
                ["x"] = 626.20288603485;
                ["sublevel"] = 1;
                ["g"] = 7;
                ["week"] = {
                    [3] = true;
                    [6] = true;
                    [9] = true;
                    [12] = true;
                };
            };
            [7] = {
                ["y"] = -448.15035264505;
                ["x"] = 520.77091827461;
                ["sublevel"] = 1;
                ["g"] = 9;
                ["week"] = {
                    [3] = true;
                    [6] = true;
                    [9] = true;
                    [12] = true;
                };
            };
            [8] = {
                ["y"] = -163.80731621307;
                ["x"] = 426.08134693695;
                ["sublevel"] = 1;
                ["g"] = 20;
                ["week"] = {
                    [3] = true;
                    [6] = true;
                    [9] = true;
                    [12] = true;
                };
            };
            [9] = {
                ["y"] = -274.39775206653;
                ["x"] = 370.03824958997;
                ["sublevel"] = 1;
                ["g"] = 16;
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
        ["count"] = 0;
        ["displayId"] = 39391;
        ["creatureType"] = "Humanoid";
        ["level"] = 121;
        ["health"] = 15369884;
        ["iconTexture"] = 135735;
    };
    [35] = {
        ["clones"] = {
            [1] = {
                ["y"] = -422.79453664477;
                ["x"] = 459.84349270362;
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
    [36] = {
        ["clones"] = {
            [1] = {
                ["y"] = -311.25817129415;
                ["x"] = 580.50022875902;
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
                ["y"] = -160.81941967987;
                ["x"] = 378.81365320707;
                ["sublevel"] = 1;
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
    [37] = {
        ["clones"] = {
            [1] = {
                ["y"] = -161.25455404597;
                ["x"] = 378.65097786114;
                ["week"] = {
                    [1] = true;
                    [2] = true;
                    [5] = true;
                    [10] = true;
                    [9] = true;
                    [6] = true;
                };
                ["sublevel"] = 1;
            };
            [2] = {
                ["y"] = -311.71985765696;
                ["x"] = 580.84056838261;
                ["sublevel"] = 1;
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
    [38] = {
        ["clones"] = {
            [1] = {
                ["y"] = -161.54845031692;
                ["x"] = 357.42347908216;
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
};
