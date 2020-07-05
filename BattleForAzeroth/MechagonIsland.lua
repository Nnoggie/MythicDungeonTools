local MDT = MDT
local L = MDT.L
local dungeonIndex = 25
MDT.mapInfo[dungeonIndex] = {
    tileFormat= 15,
    viewportPositionOverrides = 
    {
        [1] = {
            zoomScale = 1.8999998569489;
            horizontalPan = 326.95905028569;
            verticalPan = 90.852563929512;
        };
        [2] = {
            zoomScale = 5.8616151809692;
            horizontalPan = 512.38247539203;
            verticalPan = 253.02009657875;
        };
    };
};

MDT.scaleMultiplier[dungeonIndex] = 0.5
MDT.dungeonTotalCount[dungeonIndex] = {normal=332,teeming=398,teemingEnabled=true}
MDT.mapPOIs[dungeonIndex] = {
    [1] = {
        [27] = {
            ["y"] = -148.83642133179;
            ["x"] = 556.5056967313;
            ["template"] = "MapLinkPinTemplate";
            ["botIndex"] = 2;
            ["type"] = "mechagonBot";
        };
        [2] = {
            ["y"] = -333.65168296924;
            ["x"] = 558.46857732898;
            ["connectionIndex"] = 2;
            ["target"] = 2;
            ["scale"] = 0.5;
            ["direction"] = -1;
            ["template"] = "MapLinkPinTemplate";
            ["type"] = "mapLink";
        };
        [38] = {
            ["y"] = -325.89388207122;
            ["x"] = 625.50506837666;
            ["template"] = "MapLinkPinTemplate";
            ["type"] = "mechagonBot";
            ["botIndex"] = 3;
        };
        [3] = {
            ["y"] = -279.52125521908;
            ["x"] = 574.45866688737;
            ["connectionIndex"] = 3;
            ["target"] = 2;
            ["scale"] = 0.5;
            ["direction"] = -1;
            ["template"] = "MapLinkPinTemplate";
            ["type"] = "mapLink";
        };
        [54] = {
            ["npcId"] = 161243;
            ["type"] = "nyalothaSpire";
            ["index"] = 5;
            ["scale"] = 0.7;
            ["y"] = -270.61464902703;
            ["x"] = 577.99812590181;
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
        [4] = {
            ["y"] = -214.76360046713;
            ["x"] = 551.24479413728;
            ["template"] = "MapLinkPinTemplate";
            ["botIndex"] = 1;
            ["type"] = "mechagonBot";
        };
        [5] = {
            ["y"] = -234.65759416891;
            ["x"] = 570.4081232409;
            ["template"] = "MapLinkPinTemplate";
            ["botIndex"] = 2;
            ["type"] = "mechagonBot";
        };
        [6] = {
            ["y"] = -224.89429558233;
            ["x"] = 562.56343670748;
            ["template"] = "MapLinkPinTemplate";
            ["botIndex"] = 3;
            ["type"] = "mechagonBot";
        };
        [7] = {
            ["y"] = -215.3780669261;
            ["x"] = 538.28593360371;
            ["template"] = "MapLinkPinTemplate";
            ["botIndex"] = 3;
            ["type"] = "mechagonBot";
        };
        [8] = {
            ["y"] = -139.58217635844;
            ["x"] = 530.76707758754;
            ["template"] = "MapLinkPinTemplate";
            ["botIndex"] = 3;
            ["type"] = "mechagonBot";
        };
        [10] = {
            ["y"] = -205.06045370905;
            ["x"] = 472.8879086655;
            ["template"] = "MapLinkPinTemplate";
            ["botIndex"] = 3;
            ["type"] = "mechagonBot";
        };
        [12] = {
            ["y"] = -243.80641854948;
            ["x"] = 507.60863715781;
            ["template"] = "MapLinkPinTemplate";
            ["botIndex"] = 3;
            ["type"] = "mechagonBot";
        };
        [14] = {
            ["y"] = -205.13106218576;
            ["x"] = 513.73813124503;
            ["template"] = "MapLinkPinTemplate";
            ["botIndex"] = 1;
            ["type"] = "mechagonBot";
        };
        [16] = {
            ["y"] = -166.33469091189;
            ["x"] = 516.46610694203;
            ["template"] = "MapLinkPinTemplate";
            ["botIndex"] = 1;
            ["type"] = "mechagonBot";
        };
        [20] = {
            ["y"] = -187.71354379879;
            ["x"] = 550.36234064069;
            ["template"] = "MapLinkPinTemplate";
            ["botIndex"] = 2;
            ["type"] = "mechagonBot";
        };
        [24] = {
            ["y"] = -191.36945506668;
            ["x"] = 494.86977577049;
            ["template"] = "MapLinkPinTemplate";
            ["botIndex"] = 2;
            ["type"] = "mechagonBot";
        };
        [28] = {
            ["y"] = -330.50355281294;
            ["x"] = 544.11928649727;
            ["template"] = "MapLinkPinTemplate";
            ["type"] = "mechagonBot";
            ["botIndex"] = 1;
        };
        [32] = {
            ["y"] = -302.39525882203;
            ["x"] = 637.10119258941;
            ["template"] = "MapLinkPinTemplate";
            ["type"] = "mechagonBot";
            ["botIndex"] = 1;
        };
        [40] = {
            ["y"] = -302.42970374813;
            ["x"] = 564.86230519148;
            ["template"] = "MapLinkPinTemplate";
            ["type"] = "mechagonBot";
            ["botIndex"] = 3;
        };
        [48] = {
            ["y"] = -347.57321131611;
            ["x"] = 559.90337311529;
            ["template"] = "MapLinkPinTemplate";
            ["botIndex"] = 3;
            ["type"] = "mechagonBot";
        };
        [56] = {
            ["y"] = -237.97058570656;
            ["x"] = 534.41673960398;
            ["template"] = "MapLinkPinTemplate";
            ["type"] = "mechagonBot";
            ["botIndex"] = 1;
        };
        [33] = {
            ["y"] = -333.51625666066;
            ["x"] = 540.86557616786;
            ["template"] = "MapLinkPinTemplate";
            ["type"] = "mechagonBot";
            ["botIndex"] = 2;
        };
        [41] = {
            ["y"] = -330.98559163455;
            ["x"] = 540.86557616786;
            ["template"] = "MapLinkPinTemplate";
            ["type"] = "mechagonBot";
            ["botIndex"] = 3;
        };
        [49] = {
            ["y"] = -207.97570465004;
            ["x"] = 600.80557421753;
            ["template"] = "DeathReleasePinTemplate";
            ["scale"] = 0.7;
            ["graveyardDescription"] = "";
            ["type"] = "graveyard";
        };
        [57] = {
            ["y"] = -346.19602053885;
            ["x"] = 635.97784011762;
            ["template"] = "MapLinkPinTemplate";
            ["botIndex"] = 2;
            ["type"] = "mechagonBot";
        };
        [17] = {
            ["y"] = -254.04748764752;
            ["x"] = 556.82840548883;
            ["template"] = "MapLinkPinTemplate";
            ["botIndex"] = 1;
            ["type"] = "mechagonBot";
        };
        [21] = {
            ["y"] = -119.824056446;
            ["x"] = 489.5713446785;
            ["template"] = "MapLinkPinTemplate";
            ["botIndex"] = 2;
            ["type"] = "mechagonBot";
        };
        [25] = {
            ["y"] = -228.72613757021;
            ["x"] = 532.02295809942;
            ["template"] = "MapLinkPinTemplate";
            ["botIndex"] = 2;
            ["type"] = "mechagonBot";
        };
        [29] = {
            ["y"] = -352.44074204014;
            ["x"] = 596.77823559925;
            ["template"] = "MapLinkPinTemplate";
            ["type"] = "mechagonBot";
            ["botIndex"] = 1;
        };
        [34] = {
            ["y"] = -275.94831310475;
            ["x"] = 503.74331369707;
            ["template"] = "MapLinkPinTemplate";
            ["type"] = "mechagonBot";
            ["botIndex"] = 2;
        };
        [42] = {
            ["y"] = -291.83494913422;
            ["x"] = 618.73302802505;
            ["template"] = "MapLinkPinTemplate";
            ["type"] = "mechagonBot";
            ["botIndex"] = 3;
        };
        [50] = {
            ["npcId"] = 161124;
            ["type"] = "nyalothaSpire";
            ["index"] = 1;
            ["scale"] = 0.7;
            ["y"] = -172.55633390924;
            ["x"] = 534.93111665765;
            ["tooltipText"] = L["Brutal Spire of Ny'alotha"];
            ["weeks"] = {
                [7] = true;
                [1] = true;
                [2] = true;
                [4] = true;
                [8] = true;
                [9] = true;
                [5] = true;
                [10] = true;
                [3] = true;
                [6] = true;
                [12] = true;
                [11] = true;
            };
            ["template"] = "VignettePinTemplate";
        };
        [55] = {
            ["npcId"] = 161244;
            ["type"] = "nyalothaSpire";
            ["index"] = 6;
            ["scale"] = 0.7;
            ["y"] = -289.7184787073;
            ["x"] = 483.39369558387;
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
        [35] = {
            ["y"] = -292.08747935885;
            ["x"] = 559.07757956957;
            ["template"] = "MapLinkPinTemplate";
            ["type"] = "mechagonBot";
            ["botIndex"] = 2;
        };
        [9] = {
            ["y"] = -177.41878108813;
            ["x"] = 541.59854446463;
            ["template"] = "MapLinkPinTemplate";
            ["botIndex"] = 3;
            ["type"] = "mechagonBot";
        };
        [11] = {
            ["y"] = -187.96951447863;
            ["x"] = 537.42946125485;
            ["template"] = "MapLinkPinTemplate";
            ["botIndex"] = 3;
            ["type"] = "mechagonBot";
        };
        [13] = {
            ["y"] = -203.53954883103;
            ["x"] = 468.19847280834;
            ["template"] = "MapLinkPinTemplate";
            ["botIndex"] = 1;
            ["type"] = "mechagonBot";
        };
        [15] = {
            ["y"] = -230.02592508614;
            ["x"] = 508.38130358793;
            ["template"] = "MapLinkPinTemplate";
            ["botIndex"] = 1;
            ["type"] = "mechagonBot";
        };
        [18] = {
            ["y"] = -265.29687652619;
            ["x"] = 520.24553702452;
            ["template"] = "MapLinkPinTemplate";
            ["botIndex"] = 1;
            ["type"] = "mechagonBot";
        };
        [22] = {
            ["y"] = -187.94743812814;
            ["x"] = 496.64416660789;
            ["template"] = "MapLinkPinTemplate";
            ["botIndex"] = 2;
            ["type"] = "mechagonBot";
        };
        [26] = {
            ["y"] = -315.72810679216;
            ["x"] = 659.3448129009;
            ["template"] = "MapLinkPinTemplate";
            ["botIndex"] = 2;
            ["type"] = "mechagonBot";
        };
        [30] = {
            ["y"] = -304.80099363487;
            ["x"] = 572.45040840555;
            ["template"] = "MapLinkPinTemplate";
            ["type"] = "mechagonBot";
            ["botIndex"] = 1;
        };
        [36] = {
            ["y"] = -329.05471861207;
            ["x"] = 621.42324845841;
            ["template"] = "MapLinkPinTemplate";
            ["type"] = "mechagonBot";
            ["botIndex"] = 2;
        };
        [44] = {
            ["y"] = -282.85863209403;
            ["x"] = 493.78940729768;
            ["template"] = "MapLinkPinTemplate";
            ["botIndex"] = 1;
            ["type"] = "mechagonBot";
        };
        [52] = {
            ["npcId"] = 161244;
            ["type"] = "nyalothaSpire";
            ["index"] = 3;
            ["scale"] = 0.7;
            ["y"] = -268.50623130873;
            ["x"] = 576.43749229974;
            ["tooltipText"] = L["Defiled Spire of Ny'alotha"];
            ["weeks"] = {
                [6] = true;
                [2] = true;
                [10] = true;
                [1] = true;
                [5] = true;
                [9] = true;
            };
            ["template"] = "VignettePinTemplate";
        };
        [51] = {
            ["npcId"] = 161241;
            ["type"] = "nyalothaSpire";
            ["index"] = 2;
            ["scale"] = 0.7;
            ["y"] = -327.16981399342;
            ["x"] = 527.67937674097;
            ["tooltipText"] = L["Cursed Spire of Ny'alotha"];
            ["weeks"] = {
                [7] = true;
                [1] = true;
                [2] = true;
                [4] = true;
                [8] = true;
                [9] = true;
                [5] = true;
                [10] = true;
                [3] = true;
                [6] = true;
                [12] = true;
                [11] = true;
            };
            ["template"] = "VignettePinTemplate";
        };
        [47] = {
            ["y"] = -286.52084611685;
            ["x"] = 504.37857399737;
            ["template"] = "MapLinkPinTemplate";
            ["botIndex"] = 2;
            ["type"] = "mechagonBot";
        };
        [46] = {
            ["y"] = -320.89037337147;
            ["x"] = 516.60097456966;
            ["template"] = "MapLinkPinTemplate";
            ["botIndex"] = 2;
            ["type"] = "mechagonBot";
        };
        [39] = {
            ["y"] = -323.46076098317;
            ["x"] = 582.93940045404;
            ["template"] = "MapLinkPinTemplate";
            ["type"] = "mechagonBot";
            ["botIndex"] = 3;
        };
        [43] = {
            ["y"] = -255.91895040514;
            ["x"] = 594.40817186316;
            ["template"] = "MapLinkPinTemplate";
            ["type"] = "mechagonBot";
            ["botIndex"] = 3;
        };
        [37] = {
            ["y"] = -268.14726196017;
            ["x"] = 508.09388369307;
            ["template"] = "MapLinkPinTemplate";
            ["type"] = "mechagonBot";
            ["botIndex"] = 3;
        };
        [45] = {
            ["y"] = -303.18050874438;
            ["x"] = 495.73882167188;
            ["template"] = "MapLinkPinTemplate";
            ["botIndex"] = 1;
            ["type"] = "mechagonBot";
        };
        [53] = {
            ["npcId"] = 161243;
            ["type"] = "nyalothaSpire";
            ["index"] = 4;
            ["scale"] = 0.7;
            ["y"] = -289.37552297437;
            ["x"] = 483.8464170069;
            ["tooltipText"] = L["Entropic Spire of Ny'alotha"];
            ["weeks"] = {
                [6] = true;
                [2] = true;
                [10] = true;
                [1] = true;
                [5] = true;
                [9] = true;
            };
            ["template"] = "VignettePinTemplate";
        };
        [1] = {
            ["y"] = -297.96115507462;
            ["x"] = 610.60679250533;
            ["connectionIndex"] = 1;
            ["target"] = 2;
            ["scale"] = 0.5;
            ["direction"] = -1;
            ["template"] = "MapLinkPinTemplate";
            ["type"] = "mapLink";
        };
        [19] = {
            ["y"] = -118.11452896228;
            ["x"] = 495.896609574;
            ["template"] = "MapLinkPinTemplate";
            ["botIndex"] = 1;
            ["type"] = "mechagonBot";
        };
        [23] = {
            ["y"] = -208.70723616257;
            ["x"] = 510.95667017527;
            ["template"] = "MapLinkPinTemplate";
            ["botIndex"] = 2;
            ["type"] = "mechagonBot";
        };
        [31] = {
            ["y"] = -301.05546920244;
            ["x"] = 590.09738341794;
            ["template"] = "MapLinkPinTemplate";
            ["type"] = "mechagonBot";
            ["botIndex"] = 1;
        };
    };
    [2] = {
        [6] = {
            ["y"] = -298.91144346753;
            ["x"] = 578.82099588496;
            ["template"] = "MapLinkPinTemplate";
            ["type"] = "mechagonBot";
            ["botIndex"] = 2;
        };
        [2] = {
            ["y"] = -333.65168296924;
            ["x"] = 558.46857732898;
            ["connectionIndex"] = 2;
            ["target"] = 1;
            ["scale"] = 0.5;
            ["direction"] = 1;
            ["template"] = "MapLinkPinTemplate";
            ["type"] = "mapLink";
        };
        [3] = {
            ["y"] = -271.00840459281;
            ["x"] = 584.04916856459;
            ["connectionIndex"] = 3;
            ["target"] = 1;
            ["scale"] = 0.5;
            ["direction"] = 1;
            ["template"] = "MapLinkPinTemplate";
            ["type"] = "mapLink";
        };
        [1] = {
            ["y"] = -297.96115507462;
            ["x"] = 610.60679250533;
            ["connectionIndex"] = 1;
            ["target"] = 1;
            ["scale"] = 0.5;
            ["direction"] = 1;
            ["template"] = "MapLinkPinTemplate";
            ["type"] = "mapLink";
        };
        [4] = {
            ["y"] = -306.08658646836;
            ["x"] = 590.280927351;
            ["template"] = "MapLinkPinTemplate";
            ["type"] = "mechagonBot";
            ["botIndex"] = 1;
        };
        [5] = {
            ["y"] = -306.23474241702;
            ["x"] = 560.20207922938;
            ["template"] = "MapLinkPinTemplate";
            ["type"] = "mechagonBot";
            ["botIndex"] = 1;
        };
        [7] = {
            ["y"] = -297.73168060097;
            ["x"] = 574.9446042823;
            ["template"] = "MapLinkPinTemplate";
            ["type"] = "mechagonBot";
            ["botIndex"] = 3;
        };
    };
};

MDT.dungeonEnemies[dungeonIndex] = {
    [1] = {
        ["clones"] = {
            [1] = {
                ["y"] = -286.38534747172;
                ["x"] = 489.18105212439;
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
                ["y"] = -267.53421166375;
                ["x"] = 571.56585261331;
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
        ["characteristics"] = {
            ["Taunt"] = true;
        };
        ["id"] = 161243;
        ["spells"] = {
            [314478] = {};
            [314531] = {};
            [314477] = {};
            [314397] = {};
            [314483] = {};
        };
        ["stealthDetect"] = true;
        ["count"] = 4;
        ["corrupted"] = true;
        ["teemingCount"] = 6;
        ["health"] = 1409996;
        ["displayId"] = 90742;
        ["creatureType"] = "Aberration";
        ["level"] = 122;
        ["name"] = "Samh'rek, Beckoner of Chaos";
        ["scale"] = 1.4;
    };
    [2] = {
        ["clones"] = {
            [1] = {
                ["y"] = -166.44183844343;
                ["x"] = 539.63981644213;
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
        ["health"] = 1510710;
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
        ["count"] = 4;
        ["level"] = 122;
        ["teemingCount"] = 6;
        ["name"] = "Urg'roth, Breaker of Heroes";
        ["displayId"] = 89415;
        ["creatureType"] = "Aberration";
        ["corrupted"] = true;
        ["scale"] = 1.4;
        ["id"] = 161124;
    };
    [3] = {
        ["clones"] = {
            [1] = {
                ["y"] = -323.26024782574;
                ["x"] = 522.53078887932;
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
        ["characteristics"] = {
            ["Taunt"] = true;
        };
        ["scale"] = 1.4;
        ["spells"] = {
            [314463] = {};
            [314411] = {};
            [314467] = {};
            [314406] = {};
            [314397] = {};
        };
        ["stealthDetect"] = true;
        ["id"] = 161241;
        ["level"] = 122;
        ["teemingCount"] = 6;
        ["count"] = 4;
        ["displayId"] = 91910;
        ["creatureType"] = "Beast";
        ["corrupted"] = true;
        ["name"] = "Voidweaver Mal'thir";
        ["health"] = 1309282;
    };
    [4] = {
        ["clones"] = {
            [1] = {
                ["y"] = -266.39888201734;
                ["x"] = 571.39257884157;
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
                ["y"] = -285.30892438252;
                ["x"] = 489.03442026452;
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
        ["count"] = 4;
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
        ["name"] = "Blood of the Corruptor";
        ["corrupted"] = true;
        ["teemingCount"] = 6;
        ["health"] = 1409996;
        ["displayId"] = 92229;
        ["creatureType"] = "Aberration";
        ["level"] = 122;
        ["scale"] = 1.4;
        ["id"] = 161244;
    };
    [5] = {
        ["clones"] = {
            [1] = {
                ["y"] = -181.87659380495;
                ["x"] = 552.1773231261;
                ["g"] = 2;
                ["sublevel"] = 1;
            };
            [2] = {
                ["y"] = -153.34373468744;
                ["x"] = 529.02014124393;
                ["g"] = 6;
                ["sublevel"] = 1;
            };
            [3] = {
                ["y"] = -184.85501172798;
                ["x"] = 572.73025361053;
                ["g"] = 21;
                ["sublevel"] = 1;
            };
            [4] = {
                ["y"] = -173.19416858446;
                ["x"] = 572.03049749318;
                ["g"] = 24;
                ["sublevel"] = 1;
            };
            [5] = {
                ["y"] = -174.56044637202;
                ["x"] = 565.52439870365;
                ["g"] = 24;
                ["sublevel"] = 1;
            };
            [6] = {
                ["y"] = -173.527358726;
                ["x"] = 582.25894852757;
                ["g"] = 22;
                ["sublevel"] = 1;
            };
            [7] = {
                ["y"] = -170.17013702122;
                ["x"] = 587.11598032721;
                ["g"] = 22;
                ["sublevel"] = 1;
            };
            [8] = {
                ["y"] = -162.45570174702;
                ["x"] = 522.29873161762;
                ["g"] = 7;
                ["sublevel"] = 1;
            };
            [9] = {
                ["y"] = -141.82024476201;
                ["x"] = 513.41049429145;
                ["g"] = 10;
                ["sublevel"] = 1;
            };
            [10] = {
                ["y"] = -143.43946012894;
                ["x"] = 509.01547158011;
                ["g"] = 10;
                ["sublevel"] = 1;
            };
            [11] = {
                ["y"] = -170.903296855;
                ["x"] = 484.3915941286;
                ["g"] = 14;
                ["sublevel"] = 1;
            };
            [12] = {
                ["y"] = -173.63366310071;
                ["x"] = 492.88533347885;
                ["g"] = 15;
                ["sublevel"] = 1;
            };
            [13] = {
                ["y"] = -179.65684829012;
                ["x"] = 491.92916011146;
                ["g"] = 15;
                ["sublevel"] = 1;
            };
            [14] = {
                ["y"] = -184.42247310314;
                ["x"] = 509.27367775042;
                ["g"] = 19;
                ["sublevel"] = 1;
            };
        };
        ["scale"] = 1;
        ["spells"] = {
            [316690] = {};
            [300547] = {};
            [300560] = {};
            [300525] = {};
            [300561] = {};
        };
        ["characteristics"] = {
            ["Taunt"] = true;
            ["Disorient"] = true;
            ["Polymorph"] = true;
            ["Stun"] = true;
        };
        ["name"] = "Scrapbone Trashtosser";
        ["count"] = 4;
        ["displayId"] = 765;
        ["creatureType"] = "Humanoid";
        ["level"] = 120;
        ["health"] = 768495;
        ["id"] = 150142;
    };
    [6] = {
        ["clones"] = {
            [1] = {
                ["y"] = -203.38927725206;
                ["x"] = 560.53755815285;
                ["g"] = 35;
                ["sublevel"] = 1;
            };
            [2] = {
                ["y"] = -240.81896141444;
                ["x"] = 547.77418485574;
                ["g"] = 38;
                ["sublevel"] = 1;
            };
            [3] = {
                ["sublevel"] = 1;
                ["x"] = 592.99529121945;
                ["patrol"] = {};
                ["g"] = 37;
                ["y"] = -226.15432744751;
            };
            [4] = {
                ["sublevel"] = 1;
                ["x"] = 578.25867058948;
                ["patrol"] = {};
                ["g"] = 39;
                ["y"] = -239.378652489;
            };
            [5] = {
                ["sublevel"] = 1;
                ["x"] = 571.04517595398;
                ["patrol"] = {};
                ["g"] = 36;
                ["y"] = -213.60618274431;
            };
            [6] = {
                ["y"] = -216.87449656518;
                ["x"] = 534.94009610089;
                ["g"] = 29;
                ["sublevel"] = 1;
            };
            [7] = {
                ["y"] = -241.86324219594;
                ["x"] = 515.15982938269;
                ["g"] = 32;
                ["sublevel"] = 1;
            };
            [8] = {
                ["y"] = -243.15205008374;
                ["x"] = 524.9329390079;
                ["g"] = 33;
                ["sublevel"] = 1;
            };
            [9] = {
                ["y"] = -227.28774213302;
                ["x"] = 519.9354051045;
                ["g"] = 30;
                ["sublevel"] = 1;
            };
            [10] = {
                ["y"] = -231.61306425221;
                ["x"] = 521.37717472465;
                ["g"] = 30;
                ["sublevel"] = 1;
            };
            [11] = {
                ["y"] = -244.78157605537;
                ["x"] = 512.93814656704;
                ["g"] = 32;
                ["sublevel"] = 1;
            };
        };
        ["id"] = 150250;
        ["spells"] = {
            [299535] = {};
            [299460] = {};
            [299525] = {};
            [299496] = {};
            [299497] = {};
        };
        ["characteristics"] = {
            ["Taunt"] = true;
            ["Disorient"] = true;
            ["Sap"] = true;
            ["Stun"] = true;
        };
        ["health"] = 768495;
        ["name"] = "Pistonhead Blaster";
        ["displayId"] = 92012;
        ["creatureType"] = "Humanoid";
        ["level"] = 120;
        ["count"] = 4;
        ["scale"] = 1;
    };
    [7] = {
        ["clones"] = {
            [1] = {
                ["y"] = -201.65738508659;
                ["x"] = 564.4286325781;
                ["g"] = 35;
                ["sublevel"] = 1;
            };
            [2] = {
                ["y"] = -199.66174389235;
                ["x"] = 558.90684065859;
                ["g"] = 35;
                ["sublevel"] = 1;
            };
            [3] = {
                ["y"] = -212.36211561008;
                ["x"] = 520.47287476696;
                ["g"] = 28;
                ["sublevel"] = 1;
            };
            [4] = {
                ["y"] = -212.45876407282;
                ["x"] = 516.13622264397;
                ["g"] = 28;
                ["sublevel"] = 1;
            };
            [5] = {
                ["y"] = -241.32626446222;
                ["x"] = 510.86392455103;
                ["g"] = 32;
                ["sublevel"] = 1;
            };
            [6] = {
                ["y"] = -245.62217454955;
                ["x"] = 528.26224443178;
                ["g"] = 33;
                ["sublevel"] = 1;
            };
            [7] = {
                ["y"] = -246.69615075747;
                ["x"] = 524.07375680912;
                ["g"] = 33;
                ["sublevel"] = 1;
            };
            [8] = {
                ["y"] = -226.66984907504;
                ["x"] = 523.23088925525;
                ["g"] = 30;
                ["sublevel"] = 1;
            };
            [9] = {
                ["y"] = -230.78918769004;
                ["x"] = 524.36371676599;
                ["g"] = 30;
                ["sublevel"] = 1;
            };
        };
        ["id"] = 150249;
        ["spells"] = {
            [299449] = {};
            [299450] = {};
            [299438] = {};
        };
        ["characteristics"] = {
            ["Stun"] = true;
            ["Incapacitate"] = true;
            ["Disorient"] = true;
        };
        ["health"] = 768495;
        ["name"] = "Pistonhead Scrapper";
        ["displayId"] = 92006;
        ["creatureType"] = "Humanoid";
        ["level"] = 120;
        ["count"] = 4;
        ["scale"] = 1;
    };
    [8] = {
        ["clones"] = {
            [1] = {
                ["y"] = -188.11587792557;
                ["x"] = 557.60039371291;
                ["g"] = 1;
                ["sublevel"] = 1;
            };
            [2] = {
                ["y"] = -179.4615094382;
                ["x"] = 549.9072449786;
                ["g"] = 2;
                ["sublevel"] = 1;
            };
            [3] = {
                ["y"] = -157.82264523035;
                ["x"] = 527.38594408375;
                ["g"] = 6;
                ["sublevel"] = 1;
            };
            [4] = {
                ["y"] = -156.30950904337;
                ["x"] = 530.41223204262;
                ["g"] = 6;
                ["sublevel"] = 1;
            };
            [5] = {
                ["y"] = -185.25962989765;
                ["x"] = 576.0201592688;
                ["g"] = 21;
                ["sublevel"] = 1;
            };
            [6] = {
                ["y"] = -181.48019630113;
                ["x"] = 573.38486064478;
                ["g"] = 21;
                ["sublevel"] = 1;
            };
            [7] = {
                ["y"] = -176.81861824205;
                ["x"] = 587.93104160208;
                ["g"] = 22;
                ["sublevel"] = 1;
            };
            [8] = {
                ["y"] = -160.59944531462;
                ["x"] = 519.23590750838;
                ["g"] = 7;
                ["sublevel"] = 1;
            };
            [9] = {
                ["y"] = -145.17434313163;
                ["x"] = 512.42739259966;
                ["g"] = 10;
                ["sublevel"] = 1;
            };
            [10] = {
                ["y"] = -168.68341517678;
                ["x"] = 480.69663752523;
                ["g"] = 14;
                ["sublevel"] = 1;
            };
            [11] = {
                ["y"] = -183.66660032358;
                ["x"] = 512.98867865429;
                ["g"] = 19;
                ["sublevel"] = 1;
            };
            [12] = {
                ["y"] = -187.46681275429;
                ["x"] = 513.48434396967;
                ["g"] = 19;
                ["sublevel"] = 1;
            };
        };
        ["scale"] = 1;
        ["spells"] = {
            [300296] = {};
            [300414] = {};
        };
        ["characteristics"] = {
            ["Polymorph"] = true;
            ["Incapacitate"] = true;
            ["Stun"] = true;
            ["Root"] = true;
            ["Disorient"] = true;
        };
        ["name"] = "Scrapbone Grinder";
        ["count"] = 4;
        ["displayId"] = 160;
        ["creatureType"] = "Humanoid";
        ["level"] = 120;
        ["health"] = 768495;
        ["id"] = 150143;
    };
    [9] = {
        ["clones"] = {
            [1] = {
                ["y"] = -184.92401073629;
                ["x"] = 550.22368848449;
                ["g"] = 2;
                ["sublevel"] = 1;
            };
            [2] = {
                ["y"] = -190.16901101777;
                ["x"] = 554.37912032828;
                ["g"] = 1;
                ["sublevel"] = 1;
            };
            [3] = {
                ["y"] = -186.17043608333;
                ["x"] = 554.86986861487;
                ["g"] = 1;
                ["sublevel"] = 1;
            };
            [4] = {
                ["y"] = -184.30415222146;
                ["x"] = 557.93627401314;
                ["g"] = 1;
                ["sublevel"] = 1;
            };
            [5] = {
                ["y"] = -182.60796543531;
                ["x"] = 548.49737965296;
                ["g"] = 2;
                ["sublevel"] = 1;
            };
            [6] = {
                ["y"] = -178.042159654;
                ["x"] = 554.26844197122;
                ["g"] = 2;
                ["sublevel"] = 1;
            };
            [7] = {
                ["y"] = -170.13425721685;
                ["x"] = 544.8096957734;
                ["g"] = 3;
                ["sublevel"] = 1;
            };
            [8] = {
                ["y"] = -179.40401409267;
                ["x"] = 544.14405249008;
                ["g"] = 3;
                ["sublevel"] = 1;
            };
            [9] = {
                ["y"] = -177.1813980966;
                ["x"] = 537.6126235222;
                ["g"] = 4;
                ["sublevel"] = 1;
            };
            [10] = {
                ["y"] = -174.89233790813;
                ["x"] = 543.98036310446;
                ["g"] = 3;
                ["sublevel"] = 1;
            };
            [11] = {
                ["y"] = -181.75216345939;
                ["x"] = 533.73607039303;
                ["g"] = 4;
                ["sublevel"] = 1;
            };
            [12] = {
                ["y"] = -177.05657980541;
                ["x"] = 530.82690642618;
                ["g"] = 4;
                ["sublevel"] = 1;
            };
            [13] = {
                ["y"] = -171.44809442408;
                ["x"] = 525.25029585321;
                ["g"] = 5;
                ["sublevel"] = 1;
            };
            [14] = {
                ["y"] = -166.10309897646;
                ["x"] = 528.65713520721;
                ["g"] = 5;
                ["sublevel"] = 1;
            };
            [15] = {
                ["y"] = -162.6932235727;
                ["x"] = 528.06452943909;
                ["g"] = 5;
                ["sublevel"] = 1;
            };
            [16] = {
                ["y"] = -171.04026391482;
                ["x"] = 567.17780136111;
                ["g"] = 24;
                ["sublevel"] = 1;
            };
            [17] = {
                ["y"] = -168.26986985009;
                ["x"] = 571.92272370036;
                ["g"] = 24;
                ["sublevel"] = 1;
            };
            [18] = {
                ["y"] = -176.34740987086;
                ["x"] = 568.85543444851;
                ["g"] = 24;
                ["sublevel"] = 1;
            };
            [19] = {
                ["y"] = -176.73601163092;
                ["x"] = 583.92650470109;
                ["g"] = 22;
                ["sublevel"] = 1;
            };
            [20] = {
                ["y"] = -173.51025297628;
                ["x"] = 589.99241603612;
                ["g"] = 22;
                ["sublevel"] = 1;
            };
            [21] = {
                ["y"] = -170.09713393857;
                ["x"] = 583.3924794287;
                ["g"] = 22;
                ["sublevel"] = 1;
            };
            [22] = {
                ["y"] = -172.1327669747;
                ["x"] = 599.37301712135;
                ["g"] = 23;
                ["sublevel"] = 1;
            };
            [23] = {
                ["y"] = -175.36840717732;
                ["x"] = 604.00757380924;
                ["g"] = 23;
                ["sublevel"] = 1;
            };
            [24] = {
                ["y"] = -170.74452054876;
                ["x"] = 603.3561858591;
                ["g"] = 23;
                ["sublevel"] = 1;
            };
            [25] = {
                ["y"] = -144.01322759164;
                ["x"] = 521.06157421921;
                ["g"] = 8;
                ["sublevel"] = 1;
            };
            [26] = {
                ["y"] = -146.60866502279;
                ["x"] = 522.67254147572;
                ["g"] = 8;
                ["sublevel"] = 1;
            };
            [27] = {
                ["y"] = -146.60866502279;
                ["x"] = 519.45061464436;
                ["g"] = 8;
                ["sublevel"] = 1;
            };
            [28] = {
                ["y"] = -156.4414789185;
                ["x"] = 509.85572886536;
                ["g"] = 9;
                ["sublevel"] = 1;
            };
            [29] = {
                ["y"] = -157.26912720025;
                ["x"] = 511.92485548955;
                ["g"] = 9;
                ["sublevel"] = 1;
            };
            [30] = {
                ["y"] = -165.30805203025;
                ["x"] = 498.94248969666;
                ["g"] = 9;
                ["sublevel"] = 1;
            };
            [31] = {
                ["y"] = -156.13409517976;
                ["x"] = 484.6212484132;
                ["g"] = 13;
                ["sublevel"] = 1;
            };
            [32] = {
                ["y"] = -159.89926406475;
                ["x"] = 485.58391074312;
                ["g"] = 13;
                ["sublevel"] = 1;
            };
            [33] = {
                ["y"] = -159.89455229655;
                ["x"] = 482.64732649812;
                ["g"] = 13;
                ["sublevel"] = 1;
            };
            [34] = {
                ["y"] = -121.03273025087;
                ["x"] = 492.76961137568;
                ["g"] = 12;
                ["sublevel"] = 1;
            };
            [35] = {
                ["y"] = -121.71983053783;
                ["x"] = 496.557491618;
                ["g"] = 12;
                ["sublevel"] = 1;
            };
            [36] = {
                ["y"] = -126.43132404422;
                ["x"] = 493.69485831082;
                ["g"] = 12;
                ["sublevel"] = 1;
            };
            [37] = {
                ["y"] = -185.51227291573;
                ["x"] = 466.68728758136;
                ["g"] = 17;
                ["sublevel"] = 1;
            };
            [38] = {
                ["y"] = -185.26374954804;
                ["x"] = 469.48316813535;
                ["g"] = 17;
                ["sublevel"] = 1;
            };
            [39] = {
                ["y"] = -178.31172848528;
                ["x"] = 481.36863052698;
                ["g"] = 16;
                ["sublevel"] = 1;
            };
            [40] = {
                ["y"] = -176.0257057482;
                ["x"] = 495.96080516276;
                ["g"] = 15;
                ["sublevel"] = 1;
            };
            [41] = {
                ["y"] = -180.12632709445;
                ["x"] = 495.53365832794;
                ["g"] = 15;
                ["sublevel"] = 1;
            };
            [42] = {
                ["y"] = -181.06605893004;
                ["x"] = 498.52369350416;
                ["g"] = 15;
                ["sublevel"] = 1;
            };
            [43] = {
                ["y"] = -177.7319245099;
                ["x"] = 515.50374517723;
                ["g"] = 20;
                ["sublevel"] = 1;
            };
            [44] = {
                ["y"] = -186.41756205201;
                ["x"] = 519.08018416516;
                ["g"] = 20;
                ["sublevel"] = 1;
            };
            [45] = {
                ["y"] = -177.95088971475;
                ["x"] = 521.05088040576;
                ["g"] = 20;
                ["sublevel"] = 1;
            };
        };
        ["scale"] = 0.6;
        ["characteristics"] = {
            ["Polymorph"] = true;
            ["Disorient"] = true;
            ["Sap"] = true;
            ["Stun"] = true;
            ["Root"] = true;
        };
        ["name"] = "Scrapbone Grunter";
        ["count"] = 1;
        ["displayId"] = 92699;
        ["creatureType"] = "Humanoid";
        ["level"] = 120;
        ["health"] = 384248;
        ["id"] = 150547;
    };
    [10] = {
        ["clones"] = {
            [1] = {
                ["y"] = -186.65920121865;
                ["x"] = 560.21127274646;
                ["g"] = 1;
                ["sublevel"] = 1;
            };
            [2] = {
                ["y"] = -154.37267633384;
                ["x"] = 525.20701800016;
                ["g"] = 6;
                ["sublevel"] = 1;
            };
            [3] = {
                ["y"] = -159.58165079998;
                ["x"] = 551.86885889892;
                ["patrol"] = {
                    [1] = {
                        ["y"] = -159.58165079998;
                        ["x"] = 551.86885889892;
                    };
                    [2] = {
                        ["y"] = -154.56733623081;
                        ["x"] = 552.67421607235;
                    };
                    [3] = {
                        ["y"] = -159.58165079998;
                        ["x"] = 551.86885889892;
                    };
                    [4] = {
                        ["y"] = -162.9851688528;
                        ["x"] = 550.98006139361;
                    };
                    [5] = {
                        ["y"] = -164.52049667241;
                        ["x"] = 547.32704136161;
                    };
                    [6] = {
                        ["y"] = -159.17332196167;
                        ["x"] = 542.8269417182;
                    };
                    [7] = {
                        ["y"] = -164.52049667241;
                        ["x"] = 547.32704136161;
                    };
                    [8] = {
                        ["y"] = -162.9851688528;
                        ["x"] = 550.98006139361;
                    };
                };
                ["sublevel"] = 1;
            };
            [4] = {
                ["y"] = -165.42570805579;
                ["x"] = 520.44246323597;
                ["g"] = 7;
                ["sublevel"] = 1;
            };
            [5] = {
                ["y"] = -171.76389915145;
                ["x"] = 481.32134267016;
                ["g"] = 14;
                ["sublevel"] = 1;
            };
            [6] = {
                ["y"] = -188.06852241251;
                ["x"] = 507.31696272;
                ["g"] = 19;
                ["sublevel"] = 1;
            };
            [7] = {
                ["sublevel"] = 1;
                ["x"] = 510.56687002247;
                ["teeming"] = true;
                ["g"] = 10;
                ["y"] = -140.11292433301;
            };
        };
        ["scale"] = 1;
        ["spells"] = {
            [300514] = {};
            [300436] = {};
        };
        ["characteristics"] = {
            ["Stun"] = true;
            ["Incapacitate"] = true;
        };
        ["name"] = "Scrapbone Shaman";
        ["count"] = 4;
        ["displayId"] = 4905;
        ["creatureType"] = "Humanoid";
        ["level"] = 120;
        ["health"] = 614795;
        ["id"] = 150146;
    };
    [11] = {
        ["clones"] = {
            [1] = {
                ["y"] = -182.87140315281;
                ["x"] = 525.64240251319;
                ["sublevel"] = 1;
            };
            [2] = {
                ["y"] = -180.6734605043;
                ["x"] = 580.1560949637;
                ["g"] = 22;
                ["sublevel"] = 1;
            };
            [3] = {
                ["y"] = -151.24187236741;
                ["x"] = 509.61663013617;
                ["sublevel"] = 1;
            };
            [4] = {
                ["y"] = -164.68502059003;
                ["x"] = 492.24689078648;
                ["sublevel"] = 1;
            };
            [5] = {
                ["y"] = -191.35530953707;
                ["x"] = 484.5413219528;
                ["sublevel"] = 1;
            };
            [6] = {
                ["y"] = -197.56708221353;
                ["x"] = 541.69917135016;
                ["sublevel"] = 1;
            };
            [7] = {
                ["y"] = -281.81432841781;
                ["x"] = 606.42067937106;
                ["g"] = 40;
                ["sublevel"] = 1;
            };
            [8] = {
                ["y"] = -257.50785345012;
                ["x"] = 590.03485268592;
                ["sublevel"] = 1;
            };
            [9] = {
                ["sublevel"] = 1;
                ["x"] = 612.24230271709;
                ["teeming"] = true;
                ["g"] = 40;
                ["y"] = -279.00766593838;
            };
        };
        ["scale"] = 1.2;
        ["spells"] = {
            [300102] = {};
            [294884] = {};
            [300129] = {};
            [294890] = {};
            [294894] = {};
        };
        ["count"] = 5;
        ["health"] = 1229592;
        ["name"] = "Malfunctioning Scrapbot";
        ["displayId"] = 91017;
        ["creatureType"] = "Mechanical";
        ["level"] = 121;
        ["id"] = 152009;
        ["characteristics"] = {
            ["Taunt"] = true;
        };
    };
    [12] = {
        ["clones"] = {
            [1] = {
                ["sublevel"] = 1;
                ["x"] = 554.22812127344;
                ["patrol"] = {
                    [1] = {
                        ["y"] = -223.46513333378;
                        ["x"] = 554.22812127344;
                    };
                    [2] = {
                        ["y"] = -212.13497391121;
                        ["x"] = 557.23992424195;
                    };
                    [3] = {
                        ["y"] = -223.46513333378;
                        ["x"] = 554.22812127344;
                    };
                    [4] = {
                        ["y"] = -229.48877194659;
                        ["x"] = 552.07680273988;
                    };
                    [5] = {
                        ["y"] = -233.79136294013;
                        ["x"] = 548.9215734479;
                    };
                    [6] = {
                        ["y"] = -235.22556814452;
                        ["x"] = 555.08862259027;
                    };
                    [7] = {
                        ["y"] = -233.64794734362;
                        ["x"] = 561.11226229104;
                    };
                    [8] = {
                        ["y"] = -231.06638659258;
                        ["x"] = 567.70956437785;
                    };
                    [9] = {
                        ["y"] = -233.64794734362;
                        ["x"] = 561.11226229104;
                    };
                    [10] = {
                        ["y"] = -235.22556814452;
                        ["x"] = 555.08862259027;
                    };
                    [11] = {
                        ["y"] = -233.79136294013;
                        ["x"] = 548.9215734479;
                    };
                    [12] = {
                        ["y"] = -229.48877194659;
                        ["x"] = 552.07680273988;
                    };
                };
                ["y"] = -223.46513333378;
            };
            [2] = {
                ["y"] = -233.95396682962;
                ["x"] = 532.85723999372;
                ["sublevel"] = 1;
            };
            [3] = {
                ["y"] = -235.18284089714;
                ["x"] = 509.19948319518;
                ["g"] = 31;
                ["sublevel"] = 1;
            };
            [4] = {
                ["y"] = -259.7149897343;
                ["x"] = 563.46524618433;
                ["patrol"] = {
                    [1] = {
                        ["y"] = -259.7149897343;
                        ["x"] = 563.46524618433;
                    };
                    [2] = {
                        ["y"] = -259.1177844876;
                        ["x"] = 571.13332741934;
                    };
                    [3] = {
                        ["y"] = -262.92426565765;
                        ["x"] = 578.9366411802;
                    };
                    [4] = {
                        ["y"] = -263.01943320019;
                        ["x"] = 586.07379439503;
                    };
                    [5] = {
                        ["y"] = -258.83230227957;
                        ["x"] = 590.45126448466;
                    };
                    [6] = {
                        ["y"] = -263.01943320019;
                        ["x"] = 586.07379439503;
                    };
                    [7] = {
                        ["y"] = -262.92426565765;
                        ["x"] = 578.9366411802;
                    };
                    [8] = {
                        ["y"] = -259.1177844876;
                        ["x"] = 571.13332741934;
                    };
                    [9] = {
                        ["y"] = -259.7149897343;
                        ["x"] = 563.46524618433;
                    };
                    [10] = {
                        ["y"] = -267.68238141393;
                        ["x"] = 560.38001178387;
                    };
                    [11] = {
                        ["y"] = -273.58243417018;
                        ["x"] = 556.6686859046;
                    };
                    [12] = {
                        ["y"] = -278.05505546667;
                        ["x"] = 555.43156911034;
                    };
                    [13] = {
                        ["y"] = -273.58243417018;
                        ["x"] = 556.6686859046;
                    };
                    [14] = {
                        ["y"] = -267.68238141393;
                        ["x"] = 560.38001178387;
                    };
                };
                ["sublevel"] = 1;
            };
        };
        ["scale"] = 1.4;
        ["spells"] = {
            [300211] = {};
            [300188] = {};
            [300207] = {};
        };
        ["count"] = 6;
        ["health"] = 1536990;
        ["name"] = "Weaponized Crawler";
        ["displayId"] = 90711;
        ["creatureType"] = "Mechanical";
        ["level"] = 121;
        ["id"] = 150253;
        ["characteristics"] = {
            ["Taunt"] = true;
        };
    };
    [13] = {
        ["clones"] = {
            [1] = {
                ["y"] = -236.94661721044;
                ["x"] = 546.33997965134;
                ["g"] = 38;
                ["sublevel"] = 1;
            };
            [2] = {
                ["y"] = -229.27239013254;
                ["x"] = 590.89104111179;
                ["g"] = 37;
                ["sublevel"] = 1;
            };
            [3] = {
                ["y"] = -228.907330927;
                ["x"] = 596.19947893282;
                ["g"] = 37;
                ["sublevel"] = 1;
            };
            [4] = {
                ["y"] = -243.19988210472;
                ["x"] = 575.8492102892;
                ["g"] = 39;
                ["sublevel"] = 1;
            };
            [5] = {
                ["y"] = -242.75691662512;
                ["x"] = 580.57590175804;
                ["g"] = 39;
                ["sublevel"] = 1;
            };
            [6] = {
                ["y"] = -217.30262878107;
                ["x"] = 569.21961588733;
                ["g"] = 36;
                ["sublevel"] = 1;
            };
            [7] = {
                ["y"] = -216.99232489877;
                ["x"] = 573.20671335716;
                ["g"] = 36;
                ["sublevel"] = 1;
            };
            [8] = {
                ["y"] = -214.05305018863;
                ["x"] = 532.21166173061;
                ["g"] = 29;
                ["sublevel"] = 1;
            };
            [9] = {
                ["y"] = -220.51914922482;
                ["x"] = 533.88896581337;
                ["g"] = 29;
                ["sublevel"] = 1;
            };
            [10] = {
                ["sublevel"] = 1;
                ["x"] = 518.34881293709;
                ["teeming"] = true;
                ["g"] = 28;
                ["y"] = -209.00963517273;
            };
            [11] = {
                ["sublevel"] = 1;
                ["x"] = 530.73194166981;
                ["teeming"] = true;
                ["g"] = 29;
                ["y"] = -217.72374344545;
            };
        };
        ["scale"] = 1;
        ["spells"] = {
            [294107] = {};
            [299475] = {};
        };
        ["characteristics"] = {
            ["Stun"] = true;
        };
        ["name"] = "Scraphound";
        ["count"] = 4;
        ["displayId"] = 90510;
        ["creatureType"] = "Mechanical";
        ["level"] = 120;
        ["health"] = 768495;
        ["id"] = 150254;
        ["stealthDetect"] = true;
    };
    [14] = {
        ["clones"] = {
            [1] = {
                ["y"] = -240.10185881224;
                ["x"] = 551.35969171181;
                ["g"] = 38;
                ["sublevel"] = 1;
            };
            [2] = {
                ["y"] = -215.31092507786;
                ["x"] = 518.58018958714;
                ["g"] = 28;
                ["sublevel"] = 1;
            };
            [3] = {
                ["y"] = -232.29926630018;
                ["x"] = 512.9068857389;
                ["g"] = 31;
                ["sublevel"] = 1;
            };
            [4] = {
                ["sublevel"] = 1;
                ["x"] = 526.5263931021;
                ["patrol"] = {
                    [1] = {
                        ["y"] = -228.11162956432;
                        ["x"] = 526.5263931021;
                    };
                    [2] = {
                        ["y"] = -224.50719446499;
                        ["x"] = 529.51292630428;
                    };
                    [3] = {
                        ["y"] = -218.22518153164;
                        ["x"] = 527.76220573556;
                    };
                    [4] = {
                        ["y"] = -215.34164229134;
                        ["x"] = 522.92196684194;
                    };
                    [5] = {
                        ["y"] = -217.81324987993;
                        ["x"] = 517.46382605117;
                    };
                    [6] = {
                        ["y"] = -222.55050365083;
                        ["x"] = 515.81609060517;
                    };
                    [7] = {
                        ["y"] = -228.00863560244;
                        ["x"] = 516.7429390313;
                    };
                    [8] = {
                        ["y"] = -229.2444482359;
                        ["x"] = 521.89212445392;
                    };
                    [9] = {
                        ["y"] = -228.11162956432;
                        ["x"] = 526.5263931021;
                    };
                };
                ["g"] = 30;
                ["y"] = -228.11162956432;
            };
        };
        ["id"] = 150251;
        ["spells"] = {
            [273185] = {};
            [300087] = {};
            [299588] = {};
        };
        ["characteristics"] = {
            ["Stun"] = true;
            ["Disorient"] = true;
            ["Taunt"] = true;
        };
        ["scale"] = 1;
        ["count"] = 4;
        ["displayId"] = 92025;
        ["creatureType"] = "Humanoid";
        ["level"] = 120;
        ["health"] = 922194;
        ["name"] = "Pistonhead Mechanic";
    };
    [15] = {
        ["clones"] = {
            [1] = {
                ["y"] = -160.15834250975;
                ["x"] = 559.56716043185;
                ["g"] = 25;
                ["sublevel"] = 1;
            };
            [2] = {
                ["y"] = -158.63535484929;
                ["x"] = 564.96877990576;
                ["g"] = 25;
                ["sublevel"] = 1;
            };
            [3] = {
                ["y"] = -167.28713456805;
                ["x"] = 555.07228075115;
                ["g"] = 26;
                ["sublevel"] = 1;
            };
            [4] = {
                ["y"] = -165.1231570844;
                ["x"] = 551.38110375742;
                ["g"] = 26;
                ["sublevel"] = 1;
            };
            [5] = {
                ["y"] = -150.86422790574;
                ["x"] = 552.47365105443;
                ["sublevel"] = 1;
            };
            [6] = {
                ["y"] = -156.70407958468;
                ["x"] = 541.43360700849;
                ["sublevel"] = 1;
            };
            [7] = {
                ["y"] = -125.43206920519;
                ["x"] = 497.21560964504;
                ["g"] = 12;
                ["sublevel"] = 1;
            };
            [8] = {
                ["y"] = -124.89139525075;
                ["x"] = 490.18696885505;
                ["g"] = 12;
                ["sublevel"] = 1;
            };
            [9] = {
                ["y"] = -172.93259454576;
                ["x"] = 473.118811226;
                ["sublevel"] = 1;
            };
            [10] = {
                ["y"] = -179.61065884397;
                ["x"] = 476.54886500521;
                ["g"] = 16;
                ["sublevel"] = 1;
            };
            [11] = {
                ["y"] = -187.08528543059;
                ["x"] = 462.78396187026;
                ["g"] = 17;
                ["sublevel"] = 1;
            };
            [12] = {
                ["y"] = -198.04722992198;
                ["x"] = 479.45208502288;
                ["g"] = 18;
                ["sublevel"] = 1;
            };
            [13] = {
                ["y"] = -195.71159898206;
                ["x"] = 468.13887128726;
                ["g"] = 18;
                ["sublevel"] = 1;
            };
            [14] = {
                ["y"] = -198.77711498224;
                ["x"] = 472.29921331168;
                ["g"] = 18;
                ["sublevel"] = 1;
            };
        };
        ["scale"] = 1;
        ["spells"] = {
            [299474] = {};
        };
        ["name"] = "Saurolisk Bonenipper";
        ["health"] = 768495;
        ["displayId"] = 77484;
        ["creatureType"] = "Beast";
        ["level"] = 120;
        ["count"] = 4;
        ["id"] = 150154;
    };
    [16] = {
        ["clones"] = {
            [1] = {
                ["y"] = -173.58251446884;
                ["x"] = 549.36739092281;
                ["g"] = 3;
                ["sublevel"] = 1;
            };
            [2] = {
                ["sublevel"] = 1;
                ["x"] = 517.21382244627;
                ["patrol"] = {
                    [1] = {
                        ["y"] = -152.16648255968;
                        ["x"] = 517.21382244627;
                    };
                    [2] = {
                        ["y"] = -151.66529889187;
                        ["x"] = 521.59921449116;
                    };
                    [3] = {
                        ["y"] = -149.53524679503;
                        ["x"] = 525.67136539937;
                    };
                    [4] = {
                        ["y"] = -143.89688751488;
                        ["x"] = 528.30259847544;
                    };
                    [5] = {
                        ["y"] = -149.53524679503;
                        ["x"] = 525.67136539937;
                    };
                    [6] = {
                        ["y"] = -151.66529889187;
                        ["x"] = 521.59921449116;
                    };
                    [7] = {
                        ["y"] = -152.16648255968;
                        ["x"] = 517.21382244627;
                    };
                    [8] = {
                        ["y"] = -152.16648255968;
                        ["x"] = 511.38751256924;
                    };
                    [9] = {
                        ["y"] = -155.86274302845;
                        ["x"] = 510.13454264539;
                    };
                    [10] = {
                        ["y"] = -159.99754323944;
                        ["x"] = 512.64048249309;
                    };
                    [11] = {
                        ["y"] = -163.19261466324;
                        ["x"] = 515.77290999129;
                    };
                    [12] = {
                        ["y"] = -159.99754323944;
                        ["x"] = 512.64048249309;
                    };
                    [13] = {
                        ["y"] = -155.86274302845;
                        ["x"] = 510.13454264539;
                    };
                    [14] = {
                        ["y"] = -152.16648255968;
                        ["x"] = 511.38751256924;
                    };
                };
                ["y"] = -152.16648255968;
            };
            [3] = {
                ["y"] = -144.9505364921;
                ["x"] = 499.86129787229;
                ["g"] = 11;
                ["sublevel"] = 1;
            };
            [4] = {
                ["y"] = -150.78427151537;
                ["x"] = 498.50333993948;
                ["g"] = 11;
                ["sublevel"] = 1;
            };
            [5] = {
                ["y"] = -183.9939510037;
                ["x"] = 484.35371842449;
                ["g"] = 16;
                ["sublevel"] = 1;
            };
        };
        ["id"] = 150160;
        ["spells"] = {
            [300424] = {};
            [300434] = {};
            [300414] = {};
            [300427] = {};
        };
        ["characteristics"] = {
            ["Taunt"] = true;
        };
        ["instanceID"] = 1178;
        ["scale"] = 1.4;
        ["count"] = 5;
        ["displayId"] = 11611;
        ["creatureType"] = "Humanoid";
        ["level"] = 121;
        ["health"] = 1229592;
        ["name"] = "Scrapbone Bully";
    };
    [17] = {
        ["clones"] = {
            [1] = {
                ["y"] = -204.17296216281;
                ["x"] = 523.05219868618;
                ["g"] = 27;
                ["sublevel"] = 1;
            };
            [2] = {
                ["y"] = -206.21664784914;
                ["x"] = 528.59932765005;
                ["g"] = 27;
                ["sublevel"] = 1;
            };
            [3] = {
                ["y"] = -249.50266213977;
                ["x"] = 533.06023740219;
                ["g"] = 34;
                ["sublevel"] = 1;
            };
            [4] = {
                ["y"] = -254.45109081826;
                ["x"] = 530.01503921381;
                ["g"] = 34;
                ["sublevel"] = 1;
            };
        };
        ["id"] = 150276;
        ["spells"] = {
            [300160] = {};
            [300177] = {};
            [300159] = {};
            [300171] = {};
        };
        ["characteristics"] = {
            ["Taunt"] = true;
        };
        ["scale"] = 1.4;
        ["count"] = 5;
        ["displayId"] = 90773;
        ["creatureType"] = "Mechanical";
        ["level"] = 121;
        ["health"] = 1229592;
        ["name"] = "Heavy Scrapbot";
    };
    [18] = {
        ["clones"] = {
            [1] = {
                ["y"] = -215.30789442789;
                ["x"] = 507.881217617;
                ["g"] = 56;
                ["sublevel"] = 1;
            };
        };
        ["count"] = 0;
        ["characteristics"] = {
            ["Taunt"] = true;
        };
        ["spells"] = {
            [298940] = {};
            [298946] = {};
            [303525] = {};
            [298898] = {};
            [299241] = {};
        };
        ["isBoss"] = true;
        ["encounterID"] = 2360;
        ["instanceID"] = 1178;
        ["health"] = 2074937;
        ["name"] = "Naeno Megacrash";
        ["displayId"] = 92000;
        ["creatureType"] = "Humanoid";
        ["level"] = 122;
        ["id"] = 153755;
        ["scale"] = 1;
    };
    [19] = {
        ["clones"] = {
            [1] = {
                ["y"] = -222.94436554572;
                ["x"] = 506.95981930495;
                ["g"] = 56;
                ["sublevel"] = 1;
            };
        };
        ["scale"] = 1;
        ["id"] = 150712;
        ["spells"] = {
            [298849] = {};
            [298669] = {};
            [302682] = {};
            [298897] = {};
            [302681] = {};
            [299153] = {};
        };
        ["isBoss"] = true;
        ["encounterID"] = 2360;
        ["instanceID"] = 1178;
        ["name"] = "Trixie Tazer";
        ["count"] = 0;
        ["displayId"] = 92001;
        ["creatureType"] = "Humanoid";
        ["level"] = 122;
        ["health"] = 2766582;
        ["characteristics"] = {
            ["Taunt"] = true;
        };
    };
    [20] = {
        ["clones"] = {
            [1] = {
                ["y"] = -146.29014755791;
                ["x"] = 488.59605732131;
                ["sublevel"] = 1;
            };
        };
        ["characteristics"] = {
            ["Taunt"] = true;
        };
        ["id"] = 150159;
        ["spells"] = {
            [297262] = {};
            [297257] = {};
            [297261] = {};
            [297256] = {};
            [297254] = {};
        };
        ["isBoss"] = true;
        ["encounterID"] = 2357;
        ["instanceID"] = 1178;
        ["health"] = 5379465;
        ["count"] = 0;
        ["displayId"] = 90502;
        ["creatureType"] = "Humanoid";
        ["level"] = 122;
        ["name"] = "King Gobbamak";
        ["scale"] = 1.2;
    };
    [21] = {
        ["clones"] = {
            [1] = {
                ["y"] = -290.38306506461;
                ["x"] = 546.55546101291;
                ["g"] = 43;
                ["sublevel"] = 1;
            };
            [2] = {
                ["y"] = -293.31746770731;
                ["x"] = 550.89456360971;
                ["g"] = 43;
                ["sublevel"] = 1;
            };
            [3] = {
                ["y"] = -290.41003253359;
                ["x"] = 556.23357447227;
                ["g"] = 43;
                ["sublevel"] = 1;
            };
            [4] = {
                ["y"] = -327.92081535516;
                ["x"] = 577.74744980212;
                ["sublevel"] = 1;
            };
            [5] = {
                ["y"] = -332.35755927455;
                ["x"] = 601.16358798141;
                ["sublevel"] = 1;
            };
            [6] = {
                ["y"] = -325.15761318913;
                ["x"] = 619.91399155749;
                ["sublevel"] = 1;
            };
            [7] = {
                ["y"] = -326.88302213546;
                ["x"] = 635.31938016092;
                ["sublevel"] = 1;
            };
            [8] = {
                ["y"] = -338.96095039562;
                ["x"] = 649.31186325111;
                ["sublevel"] = 1;
            };
            [9] = {
                ["y"] = -305.14294550427;
                ["x"] = 622.90880875601;
                ["sublevel"] = 1;
            };
            [10] = {
                ["y"] = -317.62686649254;
                ["x"] = 656.4212766229;
                ["sublevel"] = 1;
            };
            [11] = {
                ["y"] = -278.44839782558;
                ["x"] = 645.64559796025;
                ["sublevel"] = 1;
            };
            [12] = {
                ["y"] = -266.75060921408;
                ["x"] = 655.59048477315;
                ["sublevel"] = 1;
            };
            [13] = {
                ["y"] = -261.43312945006;
                ["x"] = 644.22208206685;
                ["sublevel"] = 1;
            };
            [14] = {
                ["y"] = -262.90002367559;
                ["x"] = 632.48695973867;
                ["sublevel"] = 1;
            };
            [15] = {
                ["y"] = -295.34347579884;
                ["x"] = 572.00551149278;
                ["sublevel"] = 2;
            };
            [16] = {
                ["y"] = -301.27098175029;
                ["x"] = 574.3186912054;
                ["sublevel"] = 2;
            };
            [17] = {
                ["y"] = -309.11275049035;
                ["x"] = 584.11849197084;
                ["sublevel"] = 2;
            };
        };
        ["scale"] = 0.6;
        ["spells"] = {
            [300818] = {};
        };
        ["characteristics"] = {
            ["Taunt"] = true;
            ["Incapacitate"] = true;
            ["Stun"] = true;
            ["Disorient"] = true;
        };
        ["health"] = 384248;
        ["count"] = 4;
        ["displayId"] = 91656;
        ["creatureType"] = "Elemental";
        ["level"] = 120;
        ["name"] = "Gnome-Eating Slime";
        ["id"] = 150195;
    };
    [22] = {
        ["clones"] = {
            [1] = {
                ["y"] = -351.30842065191;
                ["x"] = 590.96058950193;
                ["sublevel"] = 1;
            };
            [2] = {
                ["y"] = -336.86631295812;
                ["x"] = 603.42432017277;
                ["sublevel"] = 1;
            };
            [3] = {
                ["y"] = -314.15427359351;
                ["x"] = 606.6650322833;
                ["sublevel"] = 1;
            };
            [4] = {
                ["y"] = -330.45705276065;
                ["x"] = 628.17126746062;
                ["sublevel"] = 1;
            };
            [5] = {
                ["y"] = -343.76728451883;
                ["x"] = 610.91728037201;
                ["sublevel"] = 1;
            };
            [6] = {
                ["y"] = -341.5489222677;
                ["x"] = 636.55181461026;
                ["sublevel"] = 1;
            };
            [7] = {
                ["y"] = -352.18047716393;
                ["x"] = 653.48523878837;
                ["sublevel"] = 1;
            };
            [8] = {
                ["y"] = -314.1786520455;
                ["x"] = 637.22342553545;
                ["sublevel"] = 1;
            };
            [9] = {
                ["y"] = -301.87289074502;
                ["x"] = 655.4526695425;
                ["sublevel"] = 1;
            };
            [10] = {
                ["y"] = -299.74132390101;
                ["x"] = 667.32613721141;
                ["sublevel"] = 1;
            };
            [11] = {
                ["y"] = -259.28393407902;
                ["x"] = 623.18893277608;
                ["sublevel"] = 1;
            };
            [12] = {
                ["y"] = -309.02801359821;
                ["x"] = 563.92990837141;
                ["patrol"] = {
                    [1] = {
                        ["y"] = -309.02801359821;
                        ["x"] = 563.92990837141;
                    };
                    [2] = {
                        ["y"] = -313.83448007207;
                        ["x"] = 562.08126213092;
                    };
                    [3] = {
                        ["y"] = -322.09175532973;
                        ["x"] = 560.72558328481;
                    };
                    [4] = {
                        ["y"] = -327.02146629669;
                        ["x"] = 559.49317008785;
                    };
                    [5] = {
                        ["y"] = -322.09175532973;
                        ["x"] = 560.72558328481;
                    };
                    [6] = {
                        ["y"] = -313.83448007207;
                        ["x"] = 562.08126213092;
                    };
                    [7] = {
                        ["y"] = -309.02801359821;
                        ["x"] = 563.92990837141;
                    };
                    [8] = {
                        ["y"] = -302.98910748234;
                        ["x"] = 569.10609245755;
                    };
                };
                ["sublevel"] = 2;
            };
            [13] = {
                ["y"] = -311.69349314333;
                ["x"] = 588.38229667253;
                ["sublevel"] = 2;
            };
            [14] = {
                ["y"] = -331.03547120531;
                ["x"] = 582.22733988647;
                ["teeming"] = true;
                ["sublevel"] = 1;
            };
        };
        ["scale"] = 1;
        ["spells"] = {
            [300650] = {};
        };
        ["characteristics"] = {
            ["Taunt"] = true;
        };
        ["health"] = 799234;
        ["count"] = 4;
        ["displayId"] = 40976;
        ["creatureType"] = "Elemental";
        ["level"] = 120;
        ["name"] = "Toxic Lurker";
        ["id"] = 150169;
    };
    [23] = {
        ["clones"] = {
            [1] = {
                ["y"] = -301.92031074174;
                ["x"] = 585.52199920556;
                ["g"] = 42;
                ["sublevel"] = 1;
            };
            [2] = {
                ["y"] = -332.8142663832;
                ["x"] = 524.64249833298;
                ["g"] = 48;
                ["sublevel"] = 1;
            };
            [3] = {
                ["y"] = -297.82658959802;
                ["x"] = 499.97631346094;
                ["g"] = 52;
                ["sublevel"] = 1;
            };
            [4] = {
                ["y"] = -292.37861328675;
                ["x"] = 510.45454792417;
                ["g"] = 51;
                ["sublevel"] = 1;
            };
            [5] = {
                ["y"] = -314.380735423;
                ["x"] = 494.50818707207;
                ["g"] = 54;
                ["sublevel"] = 1;
            };
            [6] = {
                ["y"] = -295.30087023571;
                ["x"] = 518.87053366406;
                ["g"] = 50;
                ["sublevel"] = 1;
            };
        };
        ["scale"] = 1;
        ["spells"] = {
            [301629] = {};
            [284219] = {};
        };
        ["characteristics"] = {
            ["Taunt"] = true;
            ["Stun"] = true;
            ["Root"] = true;
        };
        ["health"] = 614795;
        ["count"] = 4;
        ["displayId"] = 92207;
        ["creatureType"] = "Humanoid";
        ["level"] = 120;
        ["name"] = "Mechagon Renormalizer";
        ["id"] = 150297;
    };
    [24] = {
        ["clones"] = {
            [1] = {
                ["y"] = -305.61760057823;
                ["x"] = 588.84954762922;
                ["g"] = 42;
                ["sublevel"] = 1;
            };
            [2] = {
                ["y"] = -305.61759000021;
                ["x"] = 582.68740759826;
                ["g"] = 42;
                ["sublevel"] = 1;
            };
            [3] = {
                ["y"] = -324.13532099222;
                ["x"] = 537.29570750996;
                ["g"] = 47;
                ["sublevel"] = 1;
            };
            [4] = {
                ["y"] = -326.54368957259;
                ["x"] = 534.18980327011;
                ["g"] = 47;
                ["sublevel"] = 1;
            };
            [5] = {
                ["y"] = -333.20531541523;
                ["x"] = 520.37829016138;
                ["g"] = 48;
                ["sublevel"] = 1;
            };
            [6] = {
                ["y"] = -307.39143553806;
                ["x"] = 548.6582570655;
                ["g"] = 45;
                ["sublevel"] = 1;
            };
            [7] = {
                ["y"] = -311.60470771633;
                ["x"] = 548.41040668091;
                ["g"] = 45;
                ["sublevel"] = 1;
            };
            [8] = {
                ["y"] = -293.09738009591;
                ["x"] = 489.1060843352;
                ["g"] = 53;
                ["sublevel"] = 1;
            };
            [9] = {
                ["y"] = -296.24662424319;
                ["x"] = 488.34370129534;
                ["g"] = 53;
                ["sublevel"] = 1;
            };
            [10] = {
                ["y"] = -297.11923046881;
                ["x"] = 491.69987199544;
                ["g"] = 53;
                ["sublevel"] = 1;
            };
            [11] = {
                ["y"] = -300.98601828525;
                ["x"] = 498.71796253282;
                ["g"] = 52;
                ["sublevel"] = 1;
            };
            [12] = {
                ["y"] = -300.11947019;
                ["x"] = 502.77713900687;
                ["g"] = 52;
                ["sublevel"] = 1;
            };
            [13] = {
                ["y"] = -288.67078680543;
                ["x"] = 509.9541165649;
                ["g"] = 51;
                ["sublevel"] = 1;
            };
            [14] = {
                ["y"] = -290.78756657398;
                ["x"] = 507.04553820586;
                ["g"] = 51;
                ["sublevel"] = 1;
            };
            [15] = {
                ["y"] = -317.54164143176;
                ["x"] = 500.40284858852;
                ["g"] = 54;
                ["sublevel"] = 1;
            };
            [16] = {
                ["y"] = -311.04898424542;
                ["x"] = 494.76447957245;
                ["g"] = 54;
                ["sublevel"] = 1;
            };
            [17] = {
                ["y"] = -298.46629065155;
                ["x"] = 521.94546207417;
                ["g"] = 50;
                ["sublevel"] = 1;
            };
        };
        ["scale"] = 1;
        ["spells"] = {
            [299498] = {};
            [299502] = {};
        };
        ["characteristics"] = {
            ["Stun"] = true;
            ["Incapacitate"] = true;
            ["Taunt"] = true;
            ["Disorient"] = true;
        };
        ["health"] = 768495;
        ["count"] = 4;
        ["displayId"] = 90851;
        ["creatureType"] = "Humanoid";
        ["level"] = 120;
        ["name"] = "Mechagon Trooper";
        ["id"] = 155094;
    };
    [25] = {
        ["clones"] = {
            [1] = {
                ["y"] = -286.71718491618;
                ["x"] = 551.68709835703;
                ["g"] = 43;
                ["sublevel"] = 1;
            };
            [2] = {
                ["y"] = -347.39318725239;
                ["x"] = 579.9658576021;
                ["g"] = 41;
                ["sublevel"] = 1;
            };
            [3] = {
                ["y"] = -351.82993646079;
                ["x"] = 582.80041769692;
                ["g"] = 41;
                ["sublevel"] = 1;
            };
            [4] = {
                ["y"] = -338.07743333955;
                ["x"] = 577.5771302148;
                ["sublevel"] = 1;
            };
            [5] = {
                ["y"] = -332.67543794287;
                ["x"] = 616.33997502428;
                ["sublevel"] = 1;
            };
            [6] = {
                ["y"] = -346.6018763477;
                ["x"] = 626.56911008109;
                ["sublevel"] = 1;
            };
            [7] = {
                ["y"] = -321.21384376673;
                ["x"] = 628.41777263185;
                ["sublevel"] = 1;
            };
            [8] = {
                ["y"] = -334.27772203824;
                ["x"] = 643.64263439491;
                ["sublevel"] = 1;
            };
            [9] = {
                ["y"] = -333.04529492169;
                ["x"] = 663.1150571532;
                ["sublevel"] = 1;
            };
            [10] = {
                ["y"] = -341.54905454128;
                ["x"] = 664.34745986849;
                ["sublevel"] = 1;
            };
            [11] = {
                ["y"] = -348.32742321279;
                ["x"] = 674.45344154859;
                ["sublevel"] = 1;
            };
            [12] = {
                ["y"] = -304.58423278214;
                ["x"] = 652.49484378891;
                ["sublevel"] = 1;
            };
            [13] = {
                ["y"] = -283.85753328845;
                ["x"] = 653.71347004132;
                ["sublevel"] = 1;
            };
            [14] = {
                ["y"] = -276.70644951329;
                ["x"] = 665.54026637321;
                ["sublevel"] = 1;
            };
            [15] = {
                ["y"] = -273.31426350215;
                ["x"] = 637.2109532837;
                ["sublevel"] = 1;
            };
            [16] = {
                ["y"] = -323.95376300579;
                ["x"] = 649.21580736153;
                ["teeming"] = true;
                ["sublevel"] = 1;
            };
            [17] = {
                ["y"] = -348.51960278203;
                ["x"] = 600.77962098128;
                ["teeming"] = true;
                ["sublevel"] = 1;
            };
        };
        ["scale"] = 1;
        ["spells"] = {
            [300764] = {};
            [300777] = {};
            [300816] = {};
        };
        ["characteristics"] = {
            ["Stun"] = true;
            ["Disorient"] = true;
            ["Taunt"] = true;
            ["Incapacitate"] = true;
        };
        ["health"] = 1229592;
        ["count"] = 5;
        ["displayId"] = 4907;
        ["creatureType"] = "Elemental";
        ["level"] = 120;
        ["name"] = "Slime Elemental";
        ["id"] = 150165;
    };
    [26] = {
        ["clones"] = {
            [1] = {
                ["y"] = -308.36820839232;
                ["x"] = 568.97050422617;
                ["g"] = 44;
                ["sublevel"] = 1;
            };
            [2] = {
                ["y"] = -307.28011058123;
                ["x"] = 564.42023070567;
                ["g"] = 44;
                ["sublevel"] = 1;
            };
            [3] = {
                ["y"] = -315.91071720024;
                ["x"] = 519.63159935377;
                ["sublevel"] = 1;
            };
            [4] = {
                ["y"] = -285.4701570718;
                ["x"] = 496.88041456899;
                ["sublevel"] = 1;
            };
            [5] = {
                ["y"] = -292.68932141818;
                ["x"] = 497.68905738319;
                ["patrol"] = {
                    [1] = {
                        ["y"] = -292.68932141818;
                        ["x"] = 497.68905738319;
                    };
                    [2] = {
                        ["y"] = -292.59415510556;
                        ["x"] = 502.54234299785;
                    };
                    [3] = {
                        ["y"] = -294.97320685782;
                        ["x"] = 504.92139679207;
                    };
                    [4] = {
                        ["y"] = -297.54259063222;
                        ["x"] = 508.7278942978;
                    };
                    [5] = {
                        ["y"] = -299.54099263391;
                        ["x"] = 510.63113896674;
                    };
                    [6] = {
                        ["y"] = -297.54259063222;
                        ["x"] = 508.7278942978;
                    };
                    [7] = {
                        ["y"] = -294.97320685782;
                        ["x"] = 504.92139679207;
                    };
                    [8] = {
                        ["y"] = -292.59415510556;
                        ["x"] = 502.54234299785;
                    };
                    [9] = {
                        ["y"] = -292.68932141818;
                        ["x"] = 497.68905738319;
                    };
                    [10] = {
                        ["y"] = -291.73769725068;
                        ["x"] = 492.35999177844;
                    };
                    [11] = {
                        ["y"] = -291.73769725068;
                        ["x"] = 492.35999177844;
                    };
                    [12] = {
                        ["y"] = -285.64731349328;
                        ["x"] = 488.7438293578;
                    };
                    [13] = {
                        ["y"] = -291.73769725068;
                        ["x"] = 492.35999177844;
                    };
                };
                ["sublevel"] = 1;
            };
            [6] = {
                ["y"] = -317.37077976484;
                ["x"] = 496.90021374655;
                ["g"] = 54;
                ["sublevel"] = 1;
            };
        };
        ["scale"] = 1;
        ["spells"] = {
            [303941] = {};
            [301692] = {};
            [301689] = {};
        };
        ["health"] = 768495;
        ["name"] = "Anodized Coilbearer";
        ["displayId"] = 91123;
        ["creatureType"] = "Mechanical";
        ["level"] = 120;
        ["count"] = 4;
        ["id"] = 155090;
    };
    [27] = {
        ["clones"] = {
            [1] = {
                ["sublevel"] = 1;
                ["x"] = 544.85803577134;
                ["patrol"] = {
                    [1] = {
                        ["y"] = -308.96108846004;
                        ["x"] = 544.85803577134;
                    };
                    [2] = {
                        ["y"] = -309.24221963565;
                        ["x"] = 534.61639516613;
                    };
                    [3] = {
                        ["y"] = -313.64289050872;
                        ["x"] = 528.38210651116;
                    };
                    [4] = {
                        ["y"] = -319.0520462437;
                        ["x"] = 527.74034914013;
                    };
                    [5] = {
                        ["y"] = -329.9620435209;
                        ["x"] = 525.44832592911;
                    };
                    [6] = {
                        ["y"] = -319.0520462437;
                        ["x"] = 527.74034914013;
                    };
                    [7] = {
                        ["y"] = -313.64289050872;
                        ["x"] = 528.38210651116;
                    };
                    [8] = {
                        ["y"] = -309.24221963565;
                        ["x"] = 534.61639516613;
                    };
                    [9] = {
                        ["y"] = -308.96108846004;
                        ["x"] = 544.85803577134;
                    };
                    [10] = {
                        ["y"] = -311.44255310493;
                        ["x"] = 551.94402517122;
                    };
                    [11] = {
                        ["y"] = -307.6836435374;
                        ["x"] = 555.51957886232;
                    };
                    [12] = {
                        ["y"] = -305.3916321299;
                        ["x"] = 560.65370078266;
                    };
                    [13] = {
                        ["y"] = -307.6836435374;
                        ["x"] = 555.51957886232;
                    };
                    [14] = {
                        ["y"] = -311.44255310493;
                        ["x"] = 551.94402517122;
                    };
                };
                ["g"] = 45;
                ["y"] = -308.96108846004;
            };
            [2] = {
                ["y"] = -313.44101641927;
                ["x"] = 498.86511558368;
                ["g"] = 54;
                ["sublevel"] = 1;
            };
            [3] = {
                ["sublevel"] = 1;
                ["x"] = 522.5145178619;
                ["patrol"] = {
                    [1] = {
                        ["y"] = -294.95171959607;
                        ["x"] = 522.5145178619;
                    };
                    [2] = {
                        ["y"] = -290.01144517114;
                        ["x"] = 526.91779381264;
                    };
                    [3] = {
                        ["y"] = -283.35281342252;
                        ["x"] = 528.63615574531;
                    };
                    [4] = {
                        ["y"] = -276.69417245592;
                        ["x"] = 535.50957582201;
                    };
                    [5] = {
                        ["y"] = -272.72046855237;
                        ["x"] = 542.16821678861;
                    };
                    [6] = {
                        ["y"] = -276.69417245592;
                        ["x"] = 535.50957582201;
                    };
                    [7] = {
                        ["y"] = -283.35281342252;
                        ["x"] = 528.63615574531;
                    };
                    [8] = {
                        ["y"] = -290.01144517114;
                        ["x"] = 526.91779381264;
                    };
                    [9] = {
                        ["y"] = -294.95171959607;
                        ["x"] = 522.5145178619;
                    };
                    [10] = {
                        ["y"] = -298.28103547038;
                        ["x"] = 515.21148425706;
                    };
                    [11] = {
                        ["y"] = -302.57692647507;
                        ["x"] = 509.62682180287;
                    };
                    [12] = {
                        ["y"] = -308.16159353825;
                        ["x"] = 505.22353663414;
                    };
                    [13] = {
                        ["y"] = -302.57692647507;
                        ["x"] = 509.62682180287;
                    };
                    [14] = {
                        ["y"] = -298.28103547038;
                        ["x"] = 515.21148425706;
                    };
                };
                ["g"] = 50;
                ["y"] = -294.95171959607;
            };
            [4] = {
                ["sublevel"] = 1;
                ["x"] = 537.42677013254;
                ["teeming"] = true;
                ["g"] = 47;
                ["y"] = -328.18141080546;
            };
        };
        ["scale"] = 1.2;
        ["spells"] = {
            [301681] = {};
            [301667] = {};
            [301622] = {};
        };
        ["stealthDetect"] = true;
        ["characteristics"] = {
            ["Taunt"] = true;
        };
        ["health"] = 1229592;
        ["count"] = 5;
        ["displayId"] = 90851;
        ["creatureType"] = "Humanoid";
        ["level"] = 121;
        ["name"] = "Mechagon Cavalry";
        ["id"] = 150292;
    };
    [28] = {
        ["clones"] = {
            [1] = {
                ["y"] = -305.47932273064;
                ["x"] = 534.52574164739;
                ["g"] = 46;
                ["sublevel"] = 1;
            };
            [2] = {
                ["y"] = -304.52019751927;
                ["x"] = 530.70298866605;
                ["g"] = 46;
                ["sublevel"] = 1;
            };
            [3] = {
                ["y"] = -322.57468105635;
                ["x"] = 533.98681763346;
                ["g"] = 47;
                ["sublevel"] = 1;
            };
            [4] = {
                ["y"] = -329.93748582462;
                ["x"] = 522.20631669991;
                ["g"] = 48;
                ["sublevel"] = 1;
            };
            [5] = {
                ["sublevel"] = 1;
                ["x"] = 504.79108799869;
                ["patrol"] = {
                    [1] = {
                        ["y"] = -260.28897823736;
                        ["x"] = 504.79108799869;
                    };
                    [2] = {
                        ["y"] = -262.54432005461;
                        ["x"] = 499.63601637883;
                    };
                    [3] = {
                        ["y"] = -264.79966187186;
                        ["x"] = 497.70286164076;
                    };
                    [4] = {
                        ["y"] = -268.77336550473;
                        ["x"] = 499.958212676;
                    };
                    [5] = {
                        ["y"] = -271.56569654161;
                        ["x"] = 499.31382929965;
                    };
                    [6] = {
                        ["y"] = -275.96899062838;
                        ["x"] = 497.81026962448;
                    };
                    [7] = {
                        ["y"] = -279.94268504326;
                        ["x"] = 500.60259144337;
                    };
                    [8] = {
                        ["y"] = -282.52022776668;
                        ["x"] = 505.97246520367;
                    };
                    [9] = {
                        ["y"] = -279.62050257307;
                        ["x"] = 510.80534513535;
                    };
                    [10] = {
                        ["y"] = -276.07638478511;
                        ["x"] = 515.63823428501;
                    };
                    [11] = {
                        ["y"] = -275.75419309693;
                        ["x"] = 519.39712655945;
                    };
                    [12] = {
                        ["y"] = -272.10267654325;
                        ["x"] = 523.37083480131;
                    };
                    [13] = {
                        ["y"] = -266.94760953239;
                        ["x"] = 526.37795415165;
                    };
                    [14] = {
                        ["y"] = -261.47034622435;
                        ["x"] = 523.90781941194;
                    };
                    [15] = {
                        ["y"] = -260.18158408063;
                        ["x"] = 515.20863922212;
                    };
                    [16] = {
                        ["y"] = -260.18158408063;
                        ["x"] = 510.91274390107;
                    };
                };
                ["g"] = 49;
                ["y"] = -260.28897823736;
            };
            [6] = {
                ["y"] = -257.17446473028;
                ["x"] = 507.26124117437;
                ["g"] = 49;
                ["sublevel"] = 1;
            };
            [7] = {
                ["y"] = -260.93335239573;
                ["x"] = 508.01301409847;
                ["g"] = 49;
                ["sublevel"] = 1;
            };
            [8] = {
                ["y"] = -266.99694746284;
                ["x"] = 512.41125791654;
                ["sublevel"] = 1;
            };
        };
        ["id"] = 150293;
        ["spells"] = {
            [301712] = {};
        };
        ["scale"] = 1;
        ["count"] = 4;
        ["name"] = "Mechagon Prowler";
        ["displayId"] = 74812;
        ["creatureType"] = "Mechanical";
        ["stealth"] = true;
        ["level"] = 120;
        ["health"] = 768495;
    };
    [29] = {
        ["clones"] = {
            [1] = {
                ["y"] = -330.50253276388;
                ["x"] = 588.6031112309;
                ["patrol"] = {};
                ["sublevel"] = 1;
            };
            [2] = {
                ["y"] = -329.357107887;
                ["x"] = 609.90142089509;
                ["patrol"] = {
                    [1] = {
                        ["y"] = -329.357107887;
                        ["x"] = 609.90142089509;
                    };
                    [2] = {
                        ["y"] = -336.76011374635;
                        ["x"] = 609.0599456058;
                    };
                    [3] = {
                        ["y"] = -341.23273122889;
                        ["x"] = 613.43739962397;
                    };
                    [4] = {
                        ["y"] = -343.70694863108;
                        ["x"] = 619.24228110413;
                    };
                    [5] = {
                        ["y"] = -342.6601627748;
                        ["x"] = 623.81007021887;
                    };
                    [6] = {
                        ["y"] = -340.37627230135;
                        ["x"] = 629.90045842781;
                    };
                    [7] = {
                        ["y"] = -336.09397766362;
                        ["x"] = 633.13597537709;
                    };
                    [8] = {
                        ["y"] = -328.48100261225;
                        ["x"] = 635.22953075397;
                    };
                    [9] = {
                        ["y"] = -321.87715500974;
                        ["x"] = 629.56444579193;
                    };
                    [10] = {
                        ["y"] = -318.92713253748;
                        ["x"] = 624.0450383692;
                    };
                    [11] = {
                        ["y"] = -319.11745538229;
                        ["x"] = 616.71755779484;
                    };
                    [12] = {
                        ["y"] = -323.68524041312;
                        ["x"] = 612.05460521573;
                    };
                };
                ["sublevel"] = 1;
            };
            [3] = {
                ["y"] = -336.24960174723;
                ["x"] = 654.48804774187;
                ["sublevel"] = 1;
            };
        };
        ["scale"] = 1.4;
        ["spells"] = {
            [300706] = {};
            [300659] = {};
            [300687] = {};
        };
        ["count"] = 6;
        ["name"] = "Toxic Monstrosity";
        ["health"] = 1383291;
        ["displayId"] = 91906;
        ["creatureType"] = "Elemental";
        ["level"] = 121;
        ["id"] = 150168;
        ["characteristics"] = {
            ["Taunt"] = true;
        };
    };
    [30] = {
        ["clones"] = {
            [1] = {
                ["y"] = -341.6736523392;
                ["x"] = 589.22236941781;
                ["sublevel"] = 1;
            };
        };
        ["characteristics"] = {
            ["Taunt"] = true;
        };
        ["id"] = 150222;
        ["spells"] = {
            [298259] = {};
            [297834] = {};
            [297985] = {};
            [297835] = {};
            [298229] = {};
            [298124] = {};
        };
        ["isBoss"] = true;
        ["encounterID"] = 2358;
        ["instanceID"] = 1178;
        ["scale"] = 1.2;
        ["name"] = "Gunker";
        ["displayId"] = 91907;
        ["creatureType"] = "Elemental";
        ["level"] = 122;
        ["health"] = 3228015;
        ["count"] = 0;
    };
    [31] = {
        ["clones"] = {
            [1] = {
                ["y"] = -329.607418624;
                ["x"] = 472.17734170862;
                ["g"] = 55;
                ["sublevel"] = 1;
            };
        };
        ["characteristics"] = {
            ["Taunt"] = true;
        };
        ["id"] = 150295;
        ["spells"] = {
            [302279] = {};
            [302274] = {};
            [295445] = {};
        };
        ["isBoss"] = true;
        ["encounterID"] = 2355;
        ["instanceID"] = 1178;
        ["count"] = 0;
        ["name"] = "Tank Buster MK1";
        ["displayId"] = 90854;
        ["creatureType"] = "Mechanical";
        ["level"] = 122;
        ["health"] = 3073980;
        ["scale"] = 1.2;
    };
    [32] = {
        ["clones"] = {
            [1] = {
                ["y"] = -335.86566559552;
                ["x"] = 460.60612432968;
                ["g"] = 55;
                ["sublevel"] = 1;
            };
        };
        ["id"] = 150190;
        ["isBoss"] = true;
        ["encounterID"] = 2355;
        ["instanceID"] = 1178;
        ["scale"] = 1.2;
        ["count"] = 0;
        ["displayId"] = 92099;
        ["creatureType"] = "Mechanical";
        ["level"] = 122;
        ["name"] = "HK-8 Aerial Oppression Unit";
        ["health"] = 5994261;
    };
};
