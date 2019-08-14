local dungeonIndex = 17
MethodDungeonTools.dungeonTotalCount[dungeonIndex] = {normal=246,teeming=286,teemingEnabled=true}

MethodDungeonTools.mapPOIs[dungeonIndex] = {
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
         ["graveyardDescription"] = "Unlocks after defeating The Council of Tribes";
         ["type"] = "graveyard";
      };
      [4] = {
         ["y"] = -198.38138258562;
         ["x"] = 375.6062297457;
         ["template"] = "MapLinkPinTemplate";
         ["text"] = "Week 8: This Brute will stop patrolling, when he reaches Emissary of the Tides 7 (G13).";
         ["type"] = "generalNote";
      };
      [3] = {
         ["y"] = -310.7531169679;
         ["x"] = 563.29696033984;
         ["template"] = "MapLinkPinTemplate";
         ["type"] = "krSpiritGuide";
      };
   };
};


MethodDungeonTools.dungeonEnemies[dungeonIndex] = {
    [27] = {
        ["clones"] = {
            [1] = {
                ["y"] = -443.23180510135;
                ["x"] = 392.4457697218;
                ["g"] = 19;
                ["sublevel"] = 1;
            };
        };
        ["scale"] = 1;
        ["characteristics"] = {
            ["Taunt"] = true;
        };
        ["spells"] = {
            [266206] = {};
            [266231] = {};
        };
        ["isBoss"] = true;
        ["encounterID"] = 2170;
        ["instanceID"] = 1041;
        ["name"] = "Kula the Butcher";
        ["count"] = 0;
        ["displayId"] = 84272;
        ["creatureType"] = "Undead";
        ["level"] = 122;
        ["health"] = 1812852;
        ["id"] = 135475;
    };
    [2] = {
        ["clones"] = {
            [13] = {
                ["y"] = -378.68618649517;
                ["x"] = 658.52601488924;
                ["patrol"] = {
                    [7] = {
                        ["y"] = -364.84001393902;
                        ["x"] = 626.98753090745;
                    };
                    [1] = {
                        ["y"] = -378.68618649517;
                        ["x"] = 658.52601488924;
                    };
                    [2] = {
                        ["y"] = -395.03233446118;
                        ["x"] = 659.29522285606;
                    };
                    [4] = {
                        ["y"] = -407.34002506008;
                        ["x"] = 631.02599652751;
                    };
                    [8] = {
                        ["y"] = -364.0708059722;
                        ["x"] = 641.21830744701;
                    };
                    [9] = {
                        ["y"] = -368.10927159225;
                        ["x"] = 652.37215308389;
                    };
                    [5] = {
                        ["y"] = -393.30156701813;
                        ["x"] = 615.25677104251;
                    };
                    [3] = {
                        ["y"] = -405.41694737239;
                        ["x"] = 652.94908381785;
                    };
                    [6] = {
                        ["y"] = -374.45542713636;
                        ["x"] = 614.8721670591;
                    };
                };
                ["g"] = 4;
                ["sublevel"] = 1;
            };
            [7] = {
                ["y"] = -300.42185536161;
                ["x"] = 585.59031331141;
                ["g"] = 1;
                ["sublevel"] = 1;
            };
            [1] = {
                ["y"] = -293.66510056227;
                ["x"] = 573.15789932701;
                ["g"] = 1;
                ["sublevel"] = 1;
            };
            [2] = {
                ["y"] = -302.85429729627;
                ["x"] = 581.5362743503;
                ["g"] = 1;
                ["sublevel"] = 1;
            };
            [4] = {
                ["y"] = -295.55699468978;
                ["x"] = 585.86058721499;
                ["g"] = 1;
                ["sublevel"] = 1;
            };
            [8] = {
                ["y"] = -304.7461682263;
                ["x"] = 575.86059196775;
                ["g"] = 1;
                ["sublevel"] = 1;
            };
            [9] = {
                ["y"] = -380.41696219116;
                ["x"] = 653.14141056841;
                ["g"] = 4;
                ["sublevel"] = 1;
            };
            [5] = {
                ["sublevel"] = 1;
                ["x"] = 575.86059196775;
                ["y"] = -299.07048584376;
                ["g"] = 1;
                ["infested"] = {
                    [1] = true;
                };
            };
            [10] = {
                ["y"] = -374.84003111977;
                ["x"] = 654.8721862644;
                ["g"] = 4;
                ["sublevel"] = 1;
            };
            [3] = {
                ["y"] = -290.15158621081;
                ["x"] = 581.80652505638;
                ["g"] = 1;
                ["sublevel"] = 1;
            };
            [11] = {
                ["y"] = -373.49389241899;
                ["x"] = 660.44908432399;
                ["g"] = 4;
                ["sublevel"] = 1;
            };
            [6] = {
                ["y"] = -295.28669758873;
                ["x"] = 580.18490483244;
                ["g"] = 1;
                ["sublevel"] = 1;
            };
            [12] = {
                ["y"] = -377.14772104383;
                ["x"] = 664.87217043335;
                ["g"] = 4;
                ["sublevel"] = 1;
            };
            [14] = {
                ["sublevel"] = 1;
                ["x"] = 662.94908449271;
                ["y"] = -382.14772138125;
                ["g"] = 4;
                ["infested"] = {
                    [1] = true;
                };
            };
        };
        ["scale"] = 0.6;
        ["spells"] = {
            [269935] = {};
            [269936] = {};
        };
        ["characteristics"] = {
            ["Taunt"] = true;
            ["Slow"] = true;
        };
        ["count"] = 0;
        ["name"] = "Minion of Zul";
        ["displayId"] = 76055;
        ["creatureType"] = "Aberration";
        ["level"] = 120;
        ["health"] = 24;
        ["id"] = 133943;
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
            [4] = {
                ["y"] = -406.66729442915;
                ["x"] = 649.03882925229;
                ["teeming"] = true;
                ["g"] = 5;
                ["sublevel"] = 1;
            };
            [3] = {
                ["y"] = -404.14303243834;
                ["x"] = 625.19654199879;
                ["g"] = 7;
                ["sublevel"] = 1;
            };
        };
        ["reaping"] = 148894;
        ["scale"] = 1;
        ["spells"] = {
            [269973] = {};
            [269972] = {};
        };
        ["characteristics"] = {
            ["Taunt"] = true;
        };
        ["count"] = 5;
        ["name"] = "Shadow-Borne Witch Doctor";
        ["displayId"] = 83371;
        ["creatureType"] = "Undead";
        ["level"] = 121;
        ["health"] = 755355;
        ["id"] = 134174;
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
        ["characteristics"] = {
            ["Taunt"] = true;
        };
        ["count"] = 6;
        ["name"] = "Shadow-Borne Champion";
        ["displayId"] = 83364;
        ["creatureType"] = "Undead";
        ["level"] = 121;
        ["health"] = 805712;
        ["id"] = 134158;
    };
    [5] = {
        ["clones"] = {
            [6] = {
                ["y"] = -396.59727191278;
                ["x"] = 652.51044131347;
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
            [1] = {
                ["y"] = -404.07080041865;
                ["x"] = 656.98756594381;
                ["g"] = 5;
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
        };
        ["reaping"] = 148716;
        ["scale"] = 1;
        ["spells"] = {
            [269931] = {};
        };
        ["characteristics"] = {
            ["Taunt"] = true;
            ["Disorient"] = true;
            ["Stun"] = true;
            ["Slow"] = true;
            ["Fear"] = true;
        };
        ["count"] = 4;
        ["name"] = "Shadow-Borne Warrior";
        ["displayId"] = 83363;
        ["creatureType"] = "Undead";
        ["level"] = 120;
        ["health"] = 503570;
        ["id"] = 134157;
    };
    [6] = {
        ["clones"] = {
            [1] = {
                ["y"] = -372.2704342334;
                ["x"] = 688.65120787074;
                ["sublevel"] = 1;
            };
        };
        ["characteristics"] = {
            ["Taunt"] = true;
        };
        ["id"] = 135322;
        ["spells"] = {
            [265910] = {};
            [265781] = {};
            [265923] = {};
            [265773] = {};
        };
        ["isBoss"] = true;
        ["encounterID"] = 2165;
        ["instanceID"] = 1041;
        ["scale"] = 1;
        ["name"] = "The Golden Serpent";
        ["displayId"] = 84202;
        ["creatureType"] = "Elemental";
        ["level"] = 122;
        ["health"] = 3524990;
        ["count"] = 0;
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
        ["characteristics"] = {
            ["Taunt"] = true;
        };
        ["health"] = 503570;
        ["count"] = 4;
        ["displayId"] = 33733;
        ["creatureType"] = "Undead";
        ["level"] = 120;
        ["name"] = "Skeletal Hunting Raptor";
        ["scale"] = 0.8;
    };
    [8] = {
        ["clones"] = {
            [1] = {
                ["sublevel"] = 1;
                ["x"] = 521.22807855253;
                ["y"] = -426.40147078639;
                ["g"] = 8;
                ["infested"] = {
                    [3] = true;
                };
            };
        };
        ["reaping"] = 148894;
        ["id"] = 137486;
        ["spells"] = {
            [270505] = {};
            [270930] = {};
        };
        ["characteristics"] = {
            ["Taunt"] = true;
        };
        ["health"] = 805712;
        ["count"] = 4;
        ["displayId"] = 85287;
        ["creatureType"] = "Undead";
        ["level"] = 121;
        ["name"] = "Queen Patlaa";
        ["scale"] = 1;
    };
    [10] = {
        ["clones"] = {
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
            [1] = {
                ["y"] = -460.34119353936;
                ["x"] = 514.43224899307;
                ["g"] = 9;
                ["sublevel"] = 1;
            };
            [4] = {
                ["sublevel"] = 1;
                ["x"] = 528.1635677677;
                ["y"] = -459.59492148032;
                ["g"] = 9;
                ["infested"] = {
                    [2] = true;
                };
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
        ["characteristics"] = {
            ["Taunt"] = true;
            ["Slow"] = true;
            ["Disorient"] = true;
            ["Stun"] = true;
        };
        ["health"] = 503570;
        ["count"] = 4;
        ["displayId"] = 85285;
        ["creatureType"] = "Undead";
        ["level"] = 120;
        ["name"] = "Bloodsworn Agent";
        ["scale"] = 0.7;
    };
    [12] = {
        ["clones"] = {
            [1] = {
                ["sublevel"] = 1;
                ["x"] = 554.1015139403;
                ["y"] = -455.06108904006;
                ["g"] = 10;
                ["infested"] = {
                    [2] = true;
                };
            };
        };
        ["reaping"] = 148716;
        ["id"] = 137473;
        ["spells"] = {
            [270084] = {};
        };
        ["characteristics"] = {
            ["Stun"] = true;
            ["Slow"] = true;
            ["Disorient"] = true;
            ["Taunt"] = true;
        };
        ["health"] = 818301;
        ["count"] = 4;
        ["displayId"] = 85270;
        ["creatureType"] = "Undead";
        ["level"] = 120;
        ["name"] = "Guard Captain Atu";
        ["scale"] = 1;
    };
    [14] = {
        ["clones"] = {
            [1] = {
                ["sublevel"] = 1;
                ["x"] = 544.60908072961;
                ["y"] = -430.9731833347;
                ["g"] = 11;
                ["infested"] = {
                    [3] = true;
                };
            };
        };
        ["reaping"] = 148894;
        ["scale"] = 1;
        ["spells"] = {
            [270927] = {};
            [270928] = {};
        };
        ["characteristics"] = {
            ["Taunt"] = true;
        };
        ["count"] = 6;
        ["name"] = "King Timalji";
        ["displayId"] = 85272;
        ["creatureType"] = "Undead";
        ["level"] = 121;
        ["health"] = 805712;
        ["id"] = 137474;
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
                    [7] = {
                        ["y"] = -127.66456407374;
                        ["x"] = 429.56321964007;
                    };
                    [1] = {
                        ["y"] = -154.52287652609;
                        ["x"] = 435.79581678115;
                    };
                    [2] = {
                        ["y"] = -165.52340305175;
                        ["x"] = 448.56290445001;
                    };
                    [4] = {
                        ["y"] = -165.52340305175;
                        ["x"] = 448.56290445001;
                    };
                    [8] = {
                        ["y"] = -120.54920056281;
                        ["x"] = 440.14015104888;
                    };
                    [9] = {
                        ["y"] = -103.43379511228;
                        ["x"] = 441.29397950501;
                    };
                    [5] = {
                        ["y"] = -154.52287652609;
                        ["x"] = 435.79581678115;
                    };
                    [10] = {
                        ["y"] = -120.54920056281;
                        ["x"] = 440.14015104888;
                    };
                    [3] = {
                        ["y"] = -168.21570521217;
                        ["x"] = 480.1013389141;
                    };
                    [6] = {
                        ["y"] = -140.15923724727;
                        ["x"] = 431.0685438846;
                    };
                    [12] = {
                        ["y"] = -140.15923724727;
                        ["x"] = 431.0685438846;
                    };
                    [11] = {
                        ["y"] = -127.66456407374;
                        ["x"] = 429.56321964007;
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
        ["characteristics"] = {
            ["Taunt"] = true;
        };
        ["name"] = "Purification Construct";
        ["health"] = 1208568;
        ["displayId"] = 83836;
        ["creatureType"] = "Undead";
        ["level"] = 120;
        ["count"] = 10;
        ["scale"] = 1.2;
    };
    [20] = {
        ["clones"] = {
            [6] = {
                ["y"] = -343.91254388122;
                ["x"] = 374.09595637265;
                ["g"] = 18;
                ["sublevel"] = 1;
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
            [1] = {
                ["sublevel"] = 1;
                ["x"] = 364.63621221091;
                ["g"] = 12;
                ["y"] = -115.69673076676;
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
        };
        ["reaping"] = 148894;
        ["scale"] = 1;
        ["spells"] = {
            [270487] = {};
            [270482] = {};
            [270485] = {};
        };
        ["characteristics"] = {
            ["Taunt"] = true;
            ["Incapacitate"] = true;
            ["Shackle Undead"] = true;
            ["Disorient"] = true;
            ["Root"] = true;
            ["Slow"] = true;
            ["Stun"] = true;
            ["Silence"] = true;
        };
        ["count"] = 4;
        ["name"] = "Spectral Berserker";
        ["displayId"] = 84112;
        ["creatureType"] = "Undead";
        ["level"] = 121;
        ["health"] = 604284;
        ["id"] = 135167;
    };
    [24] = {
        ["clones"] = {
            [1] = {
                ["sublevel"] = 1;
                ["x"] = 360.12370439013;
                ["y"] = -171.65071910507;
                ["g"] = 14;
                ["infested"] = {};
            };
            [2] = {
                ["y"] = -171.9096211427;
                ["x"] = 374.48196559793;
                ["g"] = 14;
                ["sublevel"] = 1;
            };
            [4] = {
                ["y"] = -319.65113478992;
                ["x"] = 361.1921892781;
                ["teeming"] = true;
                ["g"] = 27;
                ["sublevel"] = 1;
            };
            [3] = {
                ["y"] = -260.40448798552;
                ["x"] = 364.12400057492;
                ["g"] = 16;
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
        ["characteristics"] = {
            ["Taunt"] = true;
            ["Disorient"] = true;
            ["Stun"] = true;
        };
        ["count"] = 4;
        ["name"] = "Honored Raptor";
        ["displayId"] = 84133;
        ["creatureType"] = "Undead";
        ["level"] = 120;
        ["health"] = 503570;
        ["id"] = 135192;
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
        ["scale"] = 1;
        ["characteristics"] = {
            ["Taunt"] = true;
        };
        ["spells"] = {
            [266237] = {};
            [266951] = {};
            [266940] = {};
            [266939] = {};
        };
        ["isBoss"] = true;
        ["encounterID"] = 2170;
        ["instanceID"] = 1041;
        ["name"] = "Aka'ali the Conqueror";
        ["count"] = 0;
        ["displayId"] = 84269;
        ["creatureType"] = "Undead";
        ["level"] = 122;
        ["health"] = 1812852;
        ["id"] = 135470;
    };
    [32] = {
        ["clones"] = {
            [1] = {
                ["y"] = -263.96196757677;
                ["x"] = 573.58830584234;
                ["sublevel"] = 1;
                ["week"] = {
                    [1] = true;
                    [10] = true;
                    [4] = true;
                    [7] = true;
                };
            };
            [2] = {
                ["y"] = -378.11899619221;
                ["x"] = 620.55387128066;
                ["sublevel"] = 1;
                ["g"] = 6;
                ["week"] = {
                    [1] = true;
                    [10] = true;
                    [7] = true;
                    [4] = true;
                };
            };
            [3] = {
                ["y"] = -162.18514473695;
                ["x"] = 489.26017958649;
                ["sublevel"] = 1;
                ["week"] = {
                    [1] = true;
                    [10] = true;
                    [4] = true;
                    [7] = true;
                };
            };
            [4] = {
                ["y"] = -401.35554852597;
                ["x"] = 631.12951027323;
                ["week"] = {
                    [8] = true;
                    [2] = true;
                    [11] = true;
                    [5] = true;
                };
                ["g"] = 7;
                ["sublevel"] = 1;
            };
            [5] = {
                ["y"] = -153.89003453024;
                ["x"] = 424.88018291585;
                ["week"] = {
                    [8] = true;
                    [2] = true;
                    [11] = true;
                    [5] = true;
                };
                ["g"] = 20;
                ["sublevel"] = 1;
            };
            [6] = {
                ["y"] = -120.78625165462;
                ["x"] = 431.37204617622;
                ["week"] = {
                    [8] = true;
                    [2] = true;
                    [11] = true;
                    [5] = true;
                };
                ["g"] = 24;
                ["sublevel"] = 1;
            };
            [7] = {
                ["y"] = -153.47506553655;
                ["x"] = 368.44350476612;
                ["week"] = {
                    [8] = true;
                    [2] = true;
                    [11] = true;
                    [5] = true;
                };
                ["g"] = 13;
                ["sublevel"] = 1;
            };
            [8] = {
                ["y"] = -309.58912302964;
                ["x"] = 367.09589952478;
                ["week"] = {
                    [8] = true;
                    [2] = true;
                    [11] = true;
                    [5] = true;
                };
                ["g"] = 17;
                ["sublevel"] = 1;
            };
            [9] = {
                ["y"] = -377.49360765391;
                ["x"] = 642.63590145335;
                ["week"] = {
                    [3] = true;
                    [6] = true;
                    [9] = true;
                    [12] = true;
                };
                ["g"] = 3;
                ["sublevel"] = 1;
            };
            [10] = {
                ["y"] = -121.65053897829;
                ["x"] = 370.48688454397;
                ["week"] = {
                    [3] = true;
                    [6] = true;
                    [9] = true;
                    [12] = true;
                };
                ["g"] = 12;
                ["sublevel"] = 1;
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
        ["count"] = 4;
        ["health"] = 402856;
        ["ignoreFortified"] = true;
        ["name"] = "Emissary of the Tides";
        ["displayId"] = 39391;
        ["creatureType"] = "Humanoid";
        ["level"] = 120;
        ["id"] = 155434;
        ["iconTexture"] = 132315;
    };
    [33] = {
        ["clones"] = {
            [1] = {
                ["y"] = -339.95924999324;
                ["x"] = 577.539068238;
                ["sublevel"] = 1;
                ["g"] = 2;
                ["week"] = {
                    [1] = true;
                    [10] = true;
                    [7] = true;
                    [4] = true;
                };
            };
            [2] = {
                ["y"] = -398.33641900168;
                ["x"] = 643.81477117504;
                ["sublevel"] = 1;
                ["g"] = 30;
                ["week"] = {
                    [1] = true;
                    [10] = true;
                    [7] = true;
                    [4] = true;
                };
            };
            [3] = {
                ["y"] = -440.16276125782;
                ["x"] = 555.46722764017;
                ["sublevel"] = 1;
                ["g"] = 31;
                ["week"] = {
                    [1] = true;
                    [10] = true;
                    [4] = true;
                    [7] = true;
                };
            };
            [4] = {
                ["y"] = -291.65149273687;
                ["x"] = 446.75960982379;
                ["sublevel"] = 1;
                ["g"] = 26;
                ["week"] = {
                    [1] = true;
                    [10] = true;
                    [7] = true;
                    [4] = true;
                };
            };
            [5] = {
                ["y"] = -308.96994028012;
                ["x"] = 367.50647674627;
                ["sublevel"] = 1;
                ["g"] = 17;
                ["week"] = {
                    [1] = true;
                    [10] = true;
                    [7] = true;
                    [4] = true;
                };
            };
            [6] = {
                ["y"] = -279.88172112194;
                ["x"] = 579.17054506483;
                ["week"] = {
                    [8] = true;
                    [2] = true;
                    [11] = true;
                    [5] = true;
                };
                ["sublevel"] = 1;
            };
            [7] = {
                ["y"] = -264.31044066847;
                ["x"] = 185.65384202478;
                ["week"] = {
                    [8] = true;
                    [2] = true;
                    [11] = true;
                    [5] = true;
                };
                ["g"] = 33;
                ["sublevel"] = 1;
            };
            [8] = {
                ["y"] = -438.12968280672;
                ["x"] = 473.11521375575;
                ["week"] = {
                    [3] = true;
                    [6] = true;
                    [9] = true;
                    [12] = true;
                };
                ["sublevel"] = 1;
            };
            [9] = {
                ["y"] = -180.5994519166;
                ["x"] = 377.2786561419;
                ["week"] = {
                    [3] = true;
                    [6] = true;
                    [9] = true;
                    [12] = true;
                };
                ["g"] = 14;
                ["sublevel"] = 1;
            };
        };
        ["characteristics"] = {
            ["Taunt"] = true;
        };
        ["scale"] = 1;
        ["spells"] = {
            [302419] = {};
            [302420] = {};
            [302421] = {};
            [302415] = {};
        };
        ["stealthDetect"] = true;
        ["count"] = 4;
        ["health"] = 654641;
        ["ignoreFortified"] = true;
        ["name"] = "Void-Touched Emissary";
        ["displayId"] = 39391;
        ["creatureType"] = "Humanoid";
        ["level"] = 122;
        ["id"] = 155433;
        ["iconTexture"] = 132886;
    };
    [17] = {
        ["clones"] = {
            [1] = {
                ["y"] = -154.42099320188;
                ["x"] = 489.18748663995;
                ["sublevel"] = 1;
                ["infested"] = {
                    [3] = true;
                };
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
        ["characteristics"] = {
            ["Taunt"] = true;
        };
        ["name"] = "Interment Construct";
        ["health"] = 1007140;
        ["displayId"] = 85677;
        ["creatureType"] = "Undead";
        ["level"] = 120;
        ["count"] = 6;
        ["scale"] = 1;
    };
    [21] = {
        ["clones"] = {
            [1] = {
                ["sublevel"] = 1;
                ["x"] = 362.30121150729;
                ["y"] = -148.20237578989;
                ["g"] = 13;
                ["infested"] = {
                    [3] = true;
                };
            };
            [2] = {
                ["sublevel"] = 1;
                ["x"] = 363.06714580268;
                ["y"] = -214.51280619128;
                ["g"] = 15;
                ["infested"] = {
                    [1] = true;
                };
            };
            [4] = {
                ["y"] = -115.89776031762;
                ["x"] = 373.41261882941;
                ["teeming"] = true;
                ["g"] = 12;
                ["sublevel"] = 1;
            };
            [3] = {
                ["sublevel"] = 1;
                ["x"] = 374.79926462779;
                ["y"] = -305.34123741919;
                ["g"] = 28;
                ["infested"] = {
                    [2] = true;
                };
            };
        };
        ["reaping"] = 148893;
        ["scale"] = 1;
        ["spells"] = {
            [270499] = {};
            [270497] = {};
            [205276] = {};
        };
        ["characteristics"] = {
            ["Taunt"] = true;
            ["Disorient"] = true;
            ["Stun"] = true;
            ["Slow"] = true;
            ["Silence"] = true;
        };
        ["count"] = 4;
        ["name"] = "Spectral Witch Doctor";
        ["displayId"] = 84163;
        ["creatureType"] = "Undead";
        ["level"] = 120;
        ["health"] = 503570;
        ["id"] = 135239;
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
        ["characteristics"] = {
            ["Silence"] = true;
            ["Disorient"] = true;
            ["Stun"] = true;
        };
        ["name"] = "Spectral Headhunter";
        ["health"] = 163660;
        ["displayId"] = 84026;
        ["creatureType"] = "Undead";
        ["level"] = 120;
        ["count"] = 1;
        ["id"] = 134994;
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
        ["characteristics"] = {
            ["Taunt"] = true;
        };
        ["count"] = 8;
        ["name"] = "Shadow of Zul";
        ["displayId"] = 85860;
        ["creatureType"] = "Humanoid";
        ["level"] = -1;
        ["health"] = 1712138;
        ["id"] = 138489;
    };
    [34] = {
        ["clones"] = {
            [1] = {
                ["y"] = -108.53521722425;
                ["x"] = 419.06027599762;
                ["sublevel"] = 1;
                ["week"] = {
                    [1] = true;
                    [10] = true;
                    [4] = true;
                    [7] = true;
                };
            };
            [2] = {
                ["y"] = -183.59661534911;
                ["x"] = 368.32929375765;
                ["sublevel"] = 1;
                ["g"] = 32;
                ["week"] = {
                    [1] = true;
                    [10] = true;
                    [7] = true;
                    [4] = true;
                };
            };
            [3] = {
                ["y"] = -287.80466549342;
                ["x"] = 463.04496517688;
                ["week"] = {
                    [8] = true;
                    [2] = true;
                    [11] = true;
                    [5] = true;
                };
                ["g"] = 26;
                ["sublevel"] = 1;
            };
            [4] = {
                ["y"] = -211.58855735877;
                ["x"] = 368.50715768396;
                ["week"] = {
                    [8] = true;
                    [2] = true;
                    [11] = true;
                    [5] = true;
                };
                ["g"] = 15;
                ["sublevel"] = 1;
            };
            [5] = {
                ["y"] = -338.35594465097;
                ["x"] = 576.45345106033;
                ["week"] = {
                    [3] = true;
                    [6] = true;
                    [9] = true;
                    [12] = true;
                };
                ["sublevel"] = 1;
            };
            [6] = {
                ["y"] = -394.78617143382;
                ["x"] = 626.20288603485;
                ["week"] = {
                    [3] = true;
                    [6] = true;
                    [9] = true;
                    [12] = true;
                };
                ["g"] = 7;
                ["sublevel"] = 1;
            };
            [7] = {
                ["y"] = -448.15035264505;
                ["x"] = 520.77091827461;
                ["week"] = {
                    [3] = true;
                    [6] = true;
                    [9] = true;
                    [12] = true;
                };
                ["g"] = 9;
                ["sublevel"] = 1;
            };
            [8] = {
                ["y"] = -163.80731621307;
                ["x"] = 426.08134693695;
                ["week"] = {
                    [3] = true;
                    [6] = true;
                    [9] = true;
                    [12] = true;
                };
                ["g"] = 20;
                ["sublevel"] = 1;
            };
            [9] = {
                ["y"] = -274.39775206653;
                ["x"] = 370.03824958997;
                ["week"] = {
                    [3] = true;
                    [6] = true;
                    [9] = true;
                    [12] = true;
                };
                ["g"] = 16;
                ["sublevel"] = 1;
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
        ["count"] = 0;
        ["health"] = 10071399;
        ["ignoreFortified"] = true;
        ["name"] = "Enchanted Emissary";
        ["displayId"] = 39391;
        ["creatureType"] = "Humanoid";
        ["level"] = 121;
        ["id"] = 155432;
        ["iconTexture"] = 135735;
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
        ["characteristics"] = {
            ["Taunt"] = true;
        };
        ["health"] = 1309282;
        ["count"] = 6;
        ["displayId"] = 85284;
        ["creatureType"] = "Undead";
        ["level"] = 121;
        ["name"] = "King A'akul";
        ["scale"] = 1;
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
        ["characteristics"] = {
            ["Taunt"] = true;
        };
        ["health"] = 503570;
        ["count"] = 4;
        ["displayId"] = 83517;
        ["creatureType"] = "Undead";
        ["level"] = 120;
        ["name"] = "Seneschal M'bara";
        ["scale"] = 1;
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
        ["count"] = 6;
        ["name"] = "King Rahu'ai";
        ["displayId"] = 83544;
        ["creatureType"] = "Undead";
        ["level"] = 121;
        ["id"] = 134331;
        ["health"] = 805712;
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
        ["characteristics"] = {
            ["Taunt"] = true;
        };
        ["count"] = 6;
        ["name"] = "Queen Wasi";
        ["displayId"] = 85274;
        ["creatureType"] = "Undead";
        ["level"] = 121;
        ["health"] = 805712;
        ["id"] = 137478;
    };
    [18] = {
        ["clones"] = {
            [1] = {
                ["y"] = -137.93607693106;
                ["x"] = 458.30808870121;
                ["sublevel"] = 1;
            };
        };
        ["characteristics"] = {
            ["Taunt"] = true;
        };
        ["id"] = 134993;
        ["spells"] = {
            [267639] = {};
            [267618] = {};
            [267702] = {};
            [271290] = {};
        };
        ["isBoss"] = true;
        ["encounterID"] = 2171;
        ["instanceID"] = 1041;
        ["scale"] = 1;
        ["name"] = "Mchimba the Embalmer";
        ["displayId"] = 83529;
        ["creatureType"] = "Mechanical";
        ["level"] = 122;
        ["health"] = 3524990;
        ["count"] = 0;
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
                    [4] = {
                        ["y"] = -154.23062132159;
                        ["x"] = 368.59110920942;
                    };
                    [8] = {
                        ["y"] = -211.87768089417;
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
                    [9] = {
                        ["y"] = -233.34826586652;
                        ["x"] = 368.59110920942;
                    };
                    [18] = {
                        ["y"] = -249.52475076828;
                        ["x"] = 368.59110920942;
                    };
                    [5] = {
                        ["y"] = -168.0541335897;
                        ["x"] = 368.59110920942;
                    };
                    [10] = {
                        ["y"] = -249.52475076828;
                        ["x"] = 368.59110920942;
                    };
                    [20] = {
                        ["y"] = -211.87768089417;
                        ["x"] = 368.59110920942;
                    };
                    [11] = {
                        ["y"] = -265.11729441018;
                        ["x"] = 368.59110920942;
                    };
                    [3] = {
                        ["y"] = -168.0541335897;
                        ["x"] = 368.59110920942;
                    };
                    [6] = {
                        ["y"] = -182.76004846191;
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
                    [7] = {
                        ["y"] = -197.3859907164;
                        ["x"] = 368.59110920942;
                    };
                    [14] = {
                        ["y"] = -308.9882529027;
                        ["x"] = 368.59110920942;
                    };
                    [19] = {
                        ["y"] = -233.34826586652;
                        ["x"] = 368.59110920942;
                    };
                    [15] = {
                        ["y"] = -294.79470872956;
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
        ["characteristics"] = {
            ["Taunt"] = true;
        };
        ["count"] = 8;
        ["name"] = "Spectral Brute";
        ["displayId"] = 85125;
        ["creatureType"] = "Undead";
        ["level"] = 121;
        ["health"] = 1007140;
        ["id"] = 135231;
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
        ["characteristics"] = {
            ["Taunt"] = true;
        };
        ["id"] = 135472;
        ["spells"] = {
            [267308] = {};
            [267273] = {};
            [267060] = {};
        };
        ["isBoss"] = true;
        ["encounterID"] = 2170;
        ["instanceID"] = 1041;
        ["health"] = 1812852;
        ["name"] = "Zanazal the Wise";
        ["displayId"] = 84271;
        ["creatureType"] = "Undead";
        ["level"] = 122;
        ["count"] = 0;
        ["scale"] = 1;
    };
    [30] = {
        ["clones"] = {
            [1] = {
                ["y"] = -264.67742362195;
                ["x"] = 138.54486286561;
                ["sublevel"] = 1;
            };
        };
        ["scale"] = 1;
        ["characteristics"] = {
            ["Taunt"] = true;
        };
        ["spells"] = {
            [268586] = {};
            [268936] = {};
            [268590] = {};
            [268403] = {};
            [268587] = {};
            [268589] = {};
            [268591] = {};
            [268932] = {};
        };
        ["isBoss"] = true;
        ["encounterID"] = 2172;
        ["instanceID"] = 1041;
        ["name"] = "King Dazar";
        ["health"] = 3927846;
        ["displayId"] = 84352;
        ["creatureType"] = "Undead";
        ["level"] = 122;
        ["count"] = 0;
        ["id"] = 136160;
    };
    [1] = {
        ["clones"] = {
            [3] = {
                ["y"] = -333.84661956258;
                ["x"] = 586.42175363663;
                ["g"] = 2;
                ["sublevel"] = 1;
            };
            [2] = {
                ["y"] = -272.04388546541;
                ["x"] = 572.54582578774;
                ["sublevel"] = 1;
                ["infested"] = {
                    [3] = true;
                };
            };
            [4] = {
                ["y"] = -347.00519640023;
                ["x"] = 569.74657333886;
                ["g"] = 2;
                ["sublevel"] = 1;
            };
            [1] = {
                ["y"] = -254.08941352266;
                ["x"] = 572.75039865962;
                ["sublevel"] = 1;
            };
        };
        ["reaping"] = 148716;
        ["scale"] = 1.2;
        ["spells"] = {
            [270003] = {};
            [270016] = {};
        };
        ["characteristics"] = {
            ["Taunt"] = true;
        };
        ["count"] = 8;
        ["name"] = "Animated Guardian";
        ["displayId"] = 83252;
        ["creatureType"] = "Undead";
        ["level"] = 120;
        ["health"] = 856069;
        ["id"] = 133935;
    };
    [19] = {
        ["clones"] = {
            [2] = {
                ["sublevel"] = 1;
                ["x"] = 377.3998325625;
                ["infested"] = {
                    [2] = true;
                };
                ["g"] = 12;
                ["y"] = -108.64218956602;
            };
            [3] = {
                ["y"] = -221.4358842164;
                ["x"] = 363.8363702754;
                ["g"] = 15;
                ["sublevel"] = 1;
            };
            [1] = {
                ["sublevel"] = 1;
                ["x"] = 360.49068890929;
                ["g"] = 12;
                ["y"] = -108.4239891806;
            };
            [4] = {
                ["sublevel"] = 1;
                ["x"] = 372.54227536014;
                ["y"] = -265.35726521035;
                ["g"] = 16;
                ["infested"] = {
                    [2] = true;
                };
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
        ["characteristics"] = {
            ["Taunt"] = true;
            ["Incapacitate"] = true;
            ["Shackle Undead"] = true;
            ["Silence"] = true;
            ["Slow"] = true;
            ["Disorient"] = true;
            ["Stun"] = true;
        };
        ["count"] = 4;
        ["name"] = "Spectral Hex Priest";
        ["displayId"] = 84140;
        ["creatureType"] = "Undead";
        ["level"] = 120;
        ["health"] = 453213;
        ["id"] = 135204;
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
        ["characteristics"] = {
            ["Taunt"] = true;
            ["Disorient"] = true;
            ["Shackle Undead"] = true;
            ["Stun"] = true;
            ["Silence"] = true;
        };
        ["count"] = 4;
        ["name"] = "Spectral Beastmaster";
        ["displayId"] = 84112;
        ["creatureType"] = "Undead";
        ["level"] = 120;
        ["health"] = 478392;
        ["id"] = 135235;
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
            [4] = {
                ["y"] = -163.40800686645;
                ["x"] = 431.83212774174;
                ["g"] = 20;
                ["sublevel"] = 1;
            };
            [8] = {
                ["sublevel"] = 1;
                ["x"] = 420.42490764921;
                ["infested"] = {
                    [1] = true;
                };
                ["g"] = 22;
                ["y"] = -170.1560238531;
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
            [9] = {
                ["y"] = -174.57461782382;
                ["x"] = 423.44816403468;
                ["g"] = 22;
                ["sublevel"] = 1;
            };
            [5] = {
                ["sublevel"] = 1;
                ["x"] = 428.17379966119;
                ["infested"] = {
                    [1] = true;
                };
                ["g"] = 20;
                ["y"] = -157.12851357868;
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
            [3] = {
                ["y"] = -160.71570470603;
                ["x"] = 439.33214475378;
                ["g"] = 20;
                ["sublevel"] = 1;
            };
            [6] = {
                ["y"] = -172.59592291074;
                ["x"] = 454.6196161264;
                ["g"] = 21;
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
            [7] = {
                ["sublevel"] = 1;
                ["x"] = 459.85519814966;
                ["infested"] = {
                    [1] = true;
                };
                ["g"] = 21;
                ["y"] = -173.95538022775;
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
        };
        ["reaping"] = 148716;
        ["scale"] = 0.7;
        ["spells"] = {
            [271565] = {};
            [271563] = {};
        };
        ["characteristics"] = {
            ["Taunt"] = true;
            ["Disorient"] = true;
            ["Stun"] = true;
            ["Slow"] = true;
            ["Silence"] = true;
            ["Root"] = true;
        };
        ["health"] = 302142;
        ["count"] = 1;
        ["displayId"] = 33008;
        ["creatureType"] = "Aberration";
        ["level"] = 120;
        ["name"] = "Embalming Fluid";
        ["id"] = 137989;
    };
};



