local MDT = MDT
local L = MDT.L
local dungeonIndex = 23
MDT.mapInfo[dungeonIndex] = {
    viewportPositionOverrides =
    {
        [1] = {
            zoomScale = 1.8999998569489;
            horizontalPan = 291.80521169104;
            verticalPan = 126.49567245981;
        };
        [2] = {
            zoomScale = 1.5999999046326;
            horizontalPan = 181.36659738551;
            verticalPan = 67.969520100732;
        };
        [3] = {
            zoomScale = 1.2999999523163;
            horizontalPan = 53.044494315603;
            verticalPan = 109.47271962255;
        };
        [4] = {
            zoomScale = 1.2999999523163;
            horizontalPan = 74.300611780571;
            verticalPan = 72.503083103944;
        };
        [5] = {
            zoomScale = 1.2999999523163;
            horizontalPan = 61.403255426994;
            verticalPan = 55.466726337752;
        };
        [6] = {
            zoomScale = 1.2999999523163;
            horizontalPan = 98.034112946346;
            verticalPan = 64.938350262682;
        };
        [7] = {
            zoomScale = 1.5999999046326;
            horizontalPan = 174.48055721809;
            verticalPan = 86.184873724839;
        };
    };
};
MDT.dungeonTotalCount[dungeonIndex] = {normal=400,teeming=479,teemingEnabled=true}

MDT.mapPOIs[dungeonIndex] = {
    [1] = {
        [1] = {
            ["y"] = -262.48238754636;
            ["x"] = 429.14575221168;
            ["template"] = "MapLinkPinTemplate";
            ["target"] = 2;
            ["connectionIndex"] = 1;
            ["type"] = "mapLink";
            ["direction"] = -2;
        };
        [2] = {
            ["y"] = -323.24173620103;
            ["x"] = 647.46008933814;
            ["template"] = "DeathReleasePinTemplate";
            ["graveyardDescription"] = "";
            ["type"] = "graveyard";
        };
        [3] = {
            ["y"] = -281.83580607976;
            ["x"] = 462.50964014617;
            ["template"] = "DeathReleasePinTemplate";
            ["graveyardDescription"] = L["tdGraveyardNote1"];
            ["type"] = "graveyard";
        };
        [4] = {
            ["npcId"] = 161241;
            ["type"] = "nyalothaSpire";
            ["index"] = 1;
            ["y"] = -252.7038536196;
            ["x"] = 459.11832084016;
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
        [5] = {
            ["npcId"] = 161124;
            ["type"] = "nyalothaSpire";
            ["index"] = 5;
            ["y"] = -256.01460431956;
            ["x"] = 454.01295713084;
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
    };
    [2] = {
        [1] = {
            ["y"] = -293.64644125367;
            ["x"] = 592.87359409387;
            ["template"] = "MapLinkPinTemplate";
            ["target"] = 1;
            ["connectionIndex"] = 1;
            ["type"] = "mapLink";
            ["direction"] = 2;
        };
        [2] = {
            ["y"] = -120.99821179174;
            ["x"] = 454.00006758794;
            ["template"] = "MapLinkPinTemplate";
            ["target"] = 3;
            ["type"] = "mapLink";
            ["direction"] = -2;
            ["connectionIndex"] = 2;
        };
        [3] = {
            ["y"] = -226.92509913277;
            ["x"] = 497.30085206047;
            ["template"] = "MapLinkPinTemplate";
            ["doorDescription"] = "";
            ["lockpick"] = true;
            ["doorName"] = L["Sewer Gate"];
            ["type"] = "door";
        };
        [4] = {
            ["y"] = -259.49817884669;
            ["x"] = 327.37631924595;
            ["template"] = "MapLinkPinTemplate";
            ["type"] = "tdprisonkey";
        };
        [5] = {
            ["y"] = -252.32441542972;
            ["x"] = 541.88933589202;
            ["template"] = "MapLinkPinTemplate";
            ["type"] = "tdprisonkey";
        };
        [6] = {
            ["y"] = -198.70891225244;
            ["x"] = 570.90039133419;
            ["template"] = "MapLinkPinTemplate";
            ["type"] = "tdprisonkey";
        };
        [7] = {
            ["y"] = -161.93013251665;
            ["x"] = 438.08534915751;
            ["template"] = "MapLinkPinTemplate";
            ["type"] = "tdprisonkey";
        };
        [8] = {
            ["y"] = -246.92767963576;
            ["x"] = 413.76855097664;
            ["template"] = "MapLinkPinTemplate";
            ["type"] = "tdprisonkey";
        };
        [9] = {
            ["y"] = -145.16687134973;
            ["x"] = 461.34582715726;
            ["template"] = "MapLinkPinTemplate";
            ["type"] = "tdprisonkey";
        };
    };
    [3] = {
        [1] = {
            ["y"] = -187.11512731937;
            ["x"] = 476.41240071571;
            ["template"] = "MapLinkPinTemplate";
            ["target"] = 2;
            ["type"] = "mapLink";
            ["direction"] = -1;
            ["connectionIndex"] = 2;
        };
        [2] = {
            ["y"] = -460.41462426303;
            ["x"] = 311.79902903432;
            ["template"] = "MapLinkPinTemplate";
            ["target"] = 4;
            ["type"] = "mapLink";
            ["direction"] = 1;
            ["connectionIndex"] = 3;
        };
        [3] = {
            ["y"] = -350.76394802461;
            ["x"] = 310.03890671508;
            ["template"] = "MapLinkPinTemplate";
            ["doorDescription"] = "";
            ["lockpick"] = true;
            ["doorName"] = L["Prison Gate"];
            ["type"] = "door";
        };
        [4] = {
            ["y"] = -294.67309052738;
            ["x"] = 478.42943341834;
            ["template"] = "MapLinkPinTemplate";
            ["doorDescription"] = "";
            ["lockpick"] = true;
            ["doorName"] = L["Prison Gate"];
            ["type"] = "door";
        };
        [5] = {
            ["y"] = -326.6835033043;
            ["x"] = 298.43826548799;
            ["template"] = "MapLinkPinTemplate";
            ["doorDescription"] = string.format(L["tdBuffGateNote"],"\n","\n","\n","\n");
            ["lockpick"] = true;
            ["doorName"] = L["Prison Bars"];
            ["type"] = "door";
        };
        [6] = {
            ["y"] = -236.06541579087;
            ["x"] = 358.09242143672;
            ["template"] = "MapLinkPinTemplate";
            ["doorDescription"] = string.format(L["tdBuffGateNote"],"\n","\n","\n","\n");
            ["lockpick"] = true;
            ["doorName"] = L["Prison Bars"];
            ["type"] = "door";
        };
        [7] = {
            ["y"] = -418.6335527449;
            ["x"] = 429.49956431235;
            ["template"] = "MapLinkPinTemplate";
            ["doorDescription"] = string.format(L["tdBuffGateNote"],"\n","\n","\n","\n");
            ["lockpick"] = true;
            ["doorName"] = L["Prison Bars"];
            ["type"] = "door";
        };
        [8] = {
            ["y"] = -303.0449876628;
            ["x"] = 317.04689195555;
            ["template"] = "MapLinkPinTemplate";
            ["doorDescription"] = string.format(L["tdBuffGateNote"],"\n","\n","\n","\n");
            ["lockpick"] = true;
            ["doorName"] = L["Prison Bars"];
            ["type"] = "door";
        };
        [9] = {
            ["y"] = -254.86541064356;
            ["x"] = 347.29237946953;
            ["template"] = "MapLinkPinTemplate";
            ["doorDescription"] = string.format(L["tdBuffGateNote"],"\n","\n","\n","\n");
            ["lockpick"] = true;
            ["doorName"] = L["Prison Bars"];
            ["type"] = "door";
        };
        [10] = {
            ["y"] = -369.72975641613;
            ["x"] = 461.57195383542;
            ["template"] = "MapLinkPinTemplate";
            ["doorDescription"] = string.format(L["tdBuffGateNote"],"\n","\n","\n","\n");
            ["lockpick"] = true;
            ["doorName"] = L["Prison Bars"];
            ["type"] = "door";
        };
        [11] = {
            ["y"] = -392.9440473463;
            ["x"] = 445.50049335717;
            ["template"] = "MapLinkPinTemplate";
            ["doorDescription"] = string.format(L["tdBuffGateNote"],"\n","\n","\n","\n");
            ["lockpick"] = true;
            ["doorName"] = L["Prison Bars"];
            ["type"] = "door";
        };
        [12] = {
            ["y"] = -322.22977757645;
            ["x"] = 491.92910587132;
            ["template"] = "MapLinkPinTemplate";
            ["doorDescription"] = string.format(L["tdBuffGateNote"],"\n","\n","\n","\n");
            ["lockpick"] = true;
            ["doorName"] = L["Prison Bars"];
            ["type"] = "door";
        };
        [13] = {
            ["y"] = -324.41146834197;
            ["x"] = 357.03975190127;
            ["template"] = "MapLinkPinTemplate";
            ["type"] = "tdprisonkey";
        };
        [14] = {
            ["y"] = -323.00387569819;
            ["x"] = 308.69262661692;
            ["template"] = "MapLinkPinTemplate";
            ["type"] = "tdprisonkey";
        };
        [15] = {
            ["y"] = -170.64246587206;
            ["x"] = 414.72803284209;
            ["template"] = "MapLinkPinTemplate";
            ["type"] = "tdprisonkey";
        };
        [16] = {
            ["y"] = -200.28001925019;
            ["x"] = 353.45401378142;
            ["template"] = "MapLinkPinTemplate";
            ["type"] = "tdprisonkey";
        };
        [17] = {
            ["y"] = -395.00750840427;
            ["x"] = 384.18148542908;
            ["template"] = "MapLinkPinTemplate";
            ["type"] = "tdprisonkey";
        };
        [18] = {
            ["y"] = -237.49898650692;
            ["x"] = 414.00297776122;
            ["template"] = "MapLinkPinTemplate";
            ["type"] = "tdprisonkey";
        };
        [19] = {
            ["y"] = -178.47965873006;
            ["x"] = 384.77433124093;
            ["template"] = "MapLinkPinTemplate";
            ["type"] = "tdprisonkey";
        };
        [20] = {
            ["npcId"] = 161244;
            ["type"] = "nyalothaSpire";
            ["index"] = 2;
            ["y"] = -200.24400336915;
            ["x"] = 364.90530121951;
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
    };
    [4] = {
        [1] = {
            ["y"] = -441.99833049439;
            ["x"] = 313.00005758367;
            ["template"] = "MapLinkPinTemplate";
            ["target"] = 3;
            ["type"] = "mapLink";
            ["direction"] = -1;
            ["connectionIndex"] = 3;
        };
        [2] = {
            ["y"] = -371.99834172614;
            ["x"] = 219.00000645407;
            ["template"] = "MapLinkPinTemplate";
            ["target"] = 5;
            ["type"] = "mapLink";
            ["direction"] = 1;
            ["connectionIndex"] = 4;
        };
        [3] = {
            ["y"] = -358.690180572;
            ["x"] = 336.15677336968;
            ["template"] = "DeathReleasePinTemplate";
            ["graveyardDescription"] = L["tdGraveyardNote2"];
            ["type"] = "graveyard";
        };
        [4] = {
            ["y"] = -234.18683041859;
            ["x"] = 322.38299113063;
            ["template"] = "MapLinkPinTemplate";
            ["doorDescription"] = L["tdHowlisNote"];
            ["lockpick"] = true;
            ["doorName"] = L["Prison Bars"];
            ["type"] = "door";
        };
        [5] = {
            ["y"] = -183.15399599877;
            ["x"] = 359.05915201413;
            ["template"] = "MapLinkPinTemplate";
            ["doorDescription"] = L["tdHowlisNote"];
            ["lockpick"] = true;
            ["doorName"] = L["Prison Bars"];
            ["type"] = "door";
        };
        [6] = {
            ["y"] = -208.98680115971;
            ["x"] = 341.18300314946;
            ["template"] = "MapLinkPinTemplate";
            ["doorDescription"] = L["tdHowlisNote"];
            ["lockpick"] = true;
            ["doorName"] = L["Prison Bars"];
            ["type"] = "door";
        };
        [7] = {
            ["y"] = -278.27853729051;
            ["x"] = 491.23264157131;
            ["template"] = "MapLinkPinTemplate";
            ["doorDescription"] = L["tdHowlisNote"];
            ["lockpick"] = true;
            ["doorName"] = L["Prison Bars"];
            ["type"] = "door";
        };
        [8] = {
            ["y"] = -305.64700893053;
            ["x"] = 475.44313696461;
            ["template"] = "MapLinkPinTemplate";
            ["doorDescription"] = L["tdHowlisNote"];
            ["lockpick"] = true;
            ["doorName"] = L["Prison Bars"];
            ["type"] = "door";
        };
        [9] = {
            ["y"] = -330.91014402277;
            ["x"] = 460.17995520134;
            ["template"] = "MapLinkPinTemplate";
            ["doorDescription"] = L["tdHowlisNote"];
            ["lockpick"] = true;
            ["doorName"] = L["Prison Bars"];
            ["type"] = "door";
        };
        [10] = {
            ["y"] = -210.61333863941;
            ["x"] = 359.14450923037;
            ["template"] = "MapLinkPinTemplate";
            ["text"] = L["tdWardenFightingNote"];
            ["type"] = "generalNote";
        };
    };
    [5] = {
        [1] = {
            ["y"] = -384.99838623404;
            ["x"] = 212.99992649071;
            ["template"] = "MapLinkPinTemplate";
            ["target"] = 4;
            ["type"] = "mapLink";
            ["direction"] = -1;
            ["connectionIndex"] = 4;
        };
        [2] = {
            ["y"] = -92.998271234334;
            ["x"] = 487.99998658896;
            ["template"] = "MapLinkPinTemplate";
            ["target"] = 6;
            ["type"] = "mapLink";
            ["direction"] = 1;
            ["connectionIndex"] = 5;
        };
        [3] = {
            ["y"] = -404.49679019861;
            ["x"] = 356.9995854944;
            ["template"] = "MapLinkPinTemplate";
            ["doorDescription"] = "";
            ["lockpick"] = true;
            ["doorName"] = L["Prison Gate"];
            ["type"] = "door";
        };
        [4] = {
            ["y"] = -270.18747899972;
            ["x"] = 484.87937131732;
            ["template"] = "MapLinkPinTemplate";
            ["doorDescription"] = "";
            ["lockpick"] = true;
            ["doorName"] = L["Prison Gate"];
            ["type"] = "door";
        };
        [5] = {
            ["npcId"] = 161243;
            ["type"] = "nyalothaSpire";
            ["index"] = 3;
            ["y"] = -294.76305450035;
            ["x"] = 480.36573269417;
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
    [6] = {
        [1] = {
            ["y"] = -155.99833837338;
            ["x"] = 452.00002179295;
            ["template"] = "MapLinkPinTemplate";
            ["target"] = 5;
            ["type"] = "mapLink";
            ["direction"] = -1;
            ["connectionIndex"] = 5;
        };
        [2] = {
            ["y"] = -199.9983239565;
            ["x"] = 519.99998390675;
            ["template"] = "MapLinkPinTemplate";
            ["target"] = 7;
            ["type"] = "mapLink";
            ["direction"] = 1;
            ["connectionIndex"] = 6;
        };
        [3] = {
            ["y"] = -98.627695689899;
            ["x"] = 387.54905152042;
            ["template"] = "MapLinkPinTemplate";
            ["type"] = "heavyCannon";
        };
        [4] = {
            ["y"] = -238.8518062721;
            ["x"] = 587.3175423851;
            ["template"] = "MapLinkPinTemplate";
            ["type"] = "heavyCannon";
        };
        [5] = {
            ["y"] = -482.48947620288;
            ["x"] = 427.66171594679;
            ["template"] = "DeathReleasePinTemplate";
            ["graveyardDescription"] = L["tdGraveyardNote3"];
            ["type"] = "graveyard";
        };
        [6] = {
            ["npcId"] = 161124;
            ["type"] = "nyalothaSpire";
            ["index"] = 4;
            ["y"] = -373.03081292743;
            ["x"] = 235.56798352785;
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
        [7] = {
            ["npcId"] = 161241;
            ["type"] = "nyalothaSpire";
            ["index"] = 6;
            ["y"] = -367.44586314567;
            ["x"] = 237.88885800912;
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
    [7] = {
        [1] = {
            ["y"] = -159.99830585159;
            ["x"] = 569.99996362254;
            ["template"] = "MapLinkPinTemplate";
            ["target"] = 6;
            ["type"] = "mapLink";
            ["direction"] = -1;
            ["connectionIndex"] = 6;
        };
    };
};

MDT.dungeonEnemies[dungeonIndex] = {
    [1] = {
        ["clones"] = {
            [1] = {
                ["y"] = -217.059546414;
                ["x"] = 602.33294129608;
                ["sublevel"] = 1;
            };
            [2] = {
                ["y"] = -181.21503869038;
                ["x"] = 595.40607303846;
                ["sublevel"] = 1;
            };
            [4] = {
                ["y"] = -154.31585274858;
                ["x"] = 604.34584409908;
                ["sublevel"] = 1;
            };
            [3] = {
                ["y"] = -171.33069454039;
                ["x"] = 612.89238947303;
                ["sublevel"] = 1;
            };
        };
        ["reaping"] = 148894;
        ["scale"] = 1;
        ["spells"] = {
            [258054] = {};
            [209859] = {};
        };
        ["characteristics"] = {
            ["Taunt"] = true;
            ["Root"] = true;
            ["Stun"] = true;
            ["Fear"] = true;
        };
        ["health"] = 922194;
        ["count"] = 6;
        ["displayId"] = 46043;
        ["creatureType"] = "Beast";
        ["level"] = 121;
        ["name"] = "Saltwater Snapper";
        ["id"] = 127477;
    };
    [2] = {
        ["clones"] = {
            [1] = {
                ["y"] = -254.00355751879;
                ["x"] = 502.5164332929;
                ["patrol"] = {
                    [6] = {
                        ["y"] = -275.42694347323;
                        ["x"] = 515.93390707361;
                    };
                    [2] = {
                        ["y"] = -233.21790321807;
                        ["x"] = 567.56572225286;
                    };
                    [8] = {
                        ["y"] = -275.42694347323;
                        ["x"] = 515.93390707361;
                    };
                    [3] = {
                        ["y"] = -191.49995411977;
                        ["x"] = 564.52087537141;
                    };
                    [1] = {
                        ["y"] = -254.00355751879;
                        ["x"] = 502.5164332929;
                    };
                    [4] = {
                        ["y"] = -233.21790321807;
                        ["x"] = 567.56572225286;
                    };
                    [5] = {
                        ["y"] = -254.00355751879;
                        ["x"] = 502.5164332929;
                    };
                    [7] = {
                        ["y"] = -303.3181545467;
                        ["x"] = 486.95216091555;
                    };
                };
                ["infested"] = {
                    [1] = true;
                };
                ["g"] = 1;
                ["sublevel"] = 1;
            };
            [2] = {
                ["y"] = -255.6179242644;
                ["x"] = 514.89708116989;
                ["g"] = 1;
                ["sublevel"] = 1;
            };
            [4] = {
                ["y"] = -248.83218073601;
                ["x"] = 507.75412871092;
                ["g"] = 1;
                ["sublevel"] = 1;
            };
            [8] = {
                ["y"] = -292.50885611236;
                ["x"] = 579.4595346931;
                ["g"] = 7;
                ["sublevel"] = 2;
            };
            [16] = {
                ["y"] = -294.72270389266;
                ["x"] = 510.47543788885;
                ["g"] = 9;
                ["sublevel"] = 2;
            };
            [17] = {
                ["y"] = -301.72269072934;
                ["x"] = 516.22540791749;
                ["g"] = 9;
                ["sublevel"] = 2;
            };
            [9] = {
                ["y"] = -287.16002710451;
                ["x"] = 574.34322701836;
                ["g"] = 7;
                ["sublevel"] = 2;
            };
            [18] = {
                ["y"] = -373.73758083669;
                ["x"] = 447.09309005694;
                ["g"] = 10;
                ["sublevel"] = 2;
            };
            [5] = {
                ["y"] = -249.90362360486;
                ["x"] = 513.82563830105;
                ["g"] = 1;
                ["sublevel"] = 1;
            };
            [10] = {
                ["y"] = -281.81117813603;
                ["x"] = 579.22695347811;
                ["g"] = 7;
                ["sublevel"] = 2;
            };
            [20] = {
                ["y"] = -373.73758083669;
                ["x"] = 453.57954775523;
                ["g"] = 10;
                ["sublevel"] = 2;
            };
            [21] = {
                ["y"] = -365.62946811823;
                ["x"] = 456.55251429954;
                ["g"] = 10;
                ["sublevel"] = 2;
            };
            [11] = {
                ["y"] = -298.72271476306;
                ["x"] = 502.47543760572;
                ["g"] = 9;
                ["sublevel"] = 2;
            };
            [22] = {
                ["y"] = -370.76459109489;
                ["x"] = 458.9849562342;
                ["g"] = 10;
                ["sublevel"] = 2;
            };
            [3] = {
                ["y"] = -255.6179242644;
                ["x"] = 508.8256328874;
                ["g"] = 1;
                ["sublevel"] = 1;
            };
            [6] = {
                ["y"] = -282.50886189912;
                ["x"] = 586.20367134525;
                ["g"] = 7;
                ["sublevel"] = 2;
            };
            [12] = {
                ["y"] = -303.97269952615;
                ["x"] = 504.72542494486;
                ["g"] = 9;
                ["sublevel"] = 2;
            };
            [24] = {
                ["y"] = -378.06189370138;
                ["x"] = 458.71470552812;
                ["g"] = 10;
                ["sublevel"] = 2;
            };
            [13] = {
                ["y"] = -307.72270703494;
                ["x"] = 511.22544797367;
                ["g"] = 9;
                ["sublevel"] = 2;
            };
            [7] = {
                ["sublevel"] = 2;
                ["x"] = 581.08740359176;
                ["y"] = -286.22978208705;
                ["g"] = 7;
                ["infested"] = {
                    [1] = true;
                };
            };
            [14] = {
                ["y"] = -297.47269795501;
                ["x"] = 506.22544511451;
                ["g"] = 9;
                ["sublevel"] = 2;
            };
            [23] = {
                ["y"] = -372.65649682114;
                ["x"] = 463.30929229638;
                ["g"] = 10;
                ["sublevel"] = 2;
            };
            [19] = {
                ["y"] = -381.30513414926;
                ["x"] = 452.22820143486;
                ["g"] = 10;
                ["sublevel"] = 2;
            };
            [15] = {
                ["y"] = -302.22271891024;
                ["x"] = 510.22543452724;
                ["g"] = 9;
                ["sublevel"] = 2;
            };
        };
        ["reaping"] = 148716;
        ["scale"] = 0.6;
        ["spells"] = {
            [277564] = {};
            [258075] = {};
            [277242] = {};
            [209859] = {};
        };
        ["characteristics"] = {
            ["Taunt"] = true;
            ["Incapacitate"] = true;
            ["Disorient"] = true;
            ["Polymorph"] = true;
            ["Root"] = true;
            ["Slow"] = true;
            ["Stun"] = true;
            ["Fear"] = true;
        };
        ["health"] = 230549;
        ["count"] = 1;
        ["displayId"] = 5990;
        ["creatureType"] = "Beast";
        ["level"] = 120;
        ["name"] = "Stinging Parasite";
        ["id"] = 127480;
    };
    [4] = {
        ["clones"] = {
            [13] = {
                ["y"] = -288.54652423042;
                ["x"] = 516.55278121855;
                ["g"] = 6;
                ["sublevel"] = 1;
            };
            [7] = {
                ["y"] = -343.49967840639;
                ["x"] = 465.59999456536;
                ["g"] = 5;
                ["sublevel"] = 1;
            };
            [1] = {
                ["y"] = -362.61953268822;
                ["x"] = 509.71289588607;
                ["g"] = 4;
                ["sublevel"] = 1;
            };
            [2] = {
                ["y"] = -368.33384189747;
                ["x"] = 513.79453030713;
                ["g"] = 4;
                ["sublevel"] = 1;
            };
            [4] = {
                ["y"] = -357.721595906;
                ["x"] = 515.83533875943;
                ["g"] = 4;
                ["sublevel"] = 1;
            };
            [8] = {
                ["y"] = -345.2689025355;
                ["x"] = 456.93789483453;
                ["g"] = 5;
                ["sublevel"] = 1;
            };
            [15] = {
                ["sublevel"] = 1;
                ["x"] = 518.38952283879;
                ["infested"] = {
                    [2] = true;
                };
                ["g"] = 6;
                ["y"] = -272.01591095588;
            };
            [9] = {
                ["y"] = -335.84582434166;
                ["x"] = 457.70713581315;
                ["g"] = 5;
                ["sublevel"] = 1;
            };
            [5] = {
                ["sublevel"] = 1;
                ["x"] = 523.99860760155;
                ["y"] = -359.96648870682;
                ["g"] = 4;
                ["infested"] = {
                    [1] = true;
                };
            };
            [10] = {
                ["sublevel"] = 1;
                ["x"] = 461.36098094389;
                ["infested"] = {
                    [3] = true;
                };
                ["g"] = 5;
                ["y"] = -329.11506481415;
            };
            [14] = {
                ["y"] = -280.179179798;
                ["x"] = 516.34869687003;
                ["g"] = 6;
                ["sublevel"] = 1;
            };
            [3] = {
                ["sublevel"] = 1;
                ["x"] = 519.71288883197;
                ["infested"] = {
                    [3] = true;
                };
                ["g"] = 4;
                ["y"] = -365.6807803996;
            };
            [6] = {
                ["y"] = -334.24968277289;
                ["x"] = 467.85002481984;
                ["g"] = 5;
                ["sublevel"] = 1;
            };
            [12] = {
                ["y"] = -285.68937838403;
                ["x"] = 526.14462298387;
                ["g"] = 6;
                ["sublevel"] = 1;
            };
            [11] = {
                ["y"] = -276.91386525457;
                ["x"] = 524.71605006068;
                ["g"] = 6;
                ["sublevel"] = 1;
            };
        };
        ["reaping"] = 148716;
        ["scale"] = 1;
        ["spells"] = {
            [277564] = {};
            [209859] = {};
            [277242] = {};
            [258058] = {};
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
        ["health"] = 768495;
        ["count"] = 3;
        ["displayId"] = 42978;
        ["creatureType"] = "Beast";
        ["level"] = 120;
        ["name"] = "Silt Crab";
        ["id"] = 127381;
    };
    [8] = {
        ["clones"] = {
            [13] = {
                ["y"] = -299.29694782543;
                ["x"] = 310.19898101028;
                ["sublevel"] = 4;
                ["infested"] = {
                    [2] = true;
                };
            };
            [7] = {
                ["y"] = -297.28269037781;
                ["x"] = 452.92765290393;
                ["g"] = 21;
                ["sublevel"] = 4;
            };
            [1] = {
                ["y"] = -161.21952280377;
                ["x"] = 444.91362080064;
                ["g"] = 11;
                ["sublevel"] = 3;
            };
            [2] = {
                ["y"] = -223.16651558537;
                ["x"] = 339.97985221193;
                ["sublevel"] = 3;
            };
            [4] = {
                ["y"] = -314.8237342011;
                ["x"] = 475.73756645102;
                ["g"] = 16;
                ["sublevel"] = 3;
            };
            [8] = {
                ["y"] = -189.2636595395;
                ["x"] = 576.99310183786;
                ["sublevel"] = 4;
            };
            [15] = {
                ["y"] = -327.80864757903;
                ["x"] = 387.10825865836;
                ["teeming"] = true;
                ["g"] = 15;
                ["sublevel"] = 3;
            };
            [9] = {
                ["y"] = -243.80912399546;
                ["x"] = 592.90225009449;
                ["sublevel"] = 4;
            };
            [5] = {
                ["y"] = -411.51882344584;
                ["x"] = 463.16095012299;
                ["sublevel"] = 3;
            };
            [10] = {
                ["sublevel"] = 4;
                ["x"] = 411.29177304573;
                ["y"] = -168.1755326815;
                ["g"] = 22;
                ["infested"] = {
                    [1] = true;
                };
            };
            [14] = {
                ["y"] = -310.17339654044;
                ["x"] = 451.0749338574;
                ["teeming"] = true;
                ["g"] = 21;
                ["sublevel"] = 4;
            };
            [3] = {
                ["y"] = -306.25231313575;
                ["x"] = 469.30896999818;
                ["g"] = 16;
                ["sublevel"] = 3;
            };
            [6] = {
                ["y"] = -459.48779564915;
                ["x"] = 338.82048561533;
                ["g"] = 43;
                ["sublevel"] = 4;
            };
            [12] = {
                ["y"] = -153.17026228029;
                ["x"] = 399.33868110829;
                ["g"] = 22;
                ["sublevel"] = 4;
            };
            [11] = {
                ["sublevel"] = 4;
                ["x"] = 398.50106374076;
                ["infested"] = {
                    [2] = true;
                };
                ["g"] = 22;
                ["y"] = -166.08252131348;
            };
        };
        ["reaping"] = 148716;
        ["scale"] = 1.2;
        ["spells"] = {
            [277564] = {};
            [209859] = {};
            [277242] = {};
            [265889] = {};
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
        ["health"] = 845345;
        ["count"] = 6;
        ["displayId"] = 84394;
        ["creatureType"] = "Humanoid";
        ["level"] = 120;
        ["name"] = "Blacktooth Arsonist";
        ["id"] = 135366;
    };
    [16] = {
        ["clones"] = {
            [1] = {
                ["y"] = -321.60115034702;
                ["x"] = 263.2873792635;
                ["g"] = 24;
                ["sublevel"] = 4;
            };
        };
        ["reaping"] = 148716;
        ["id"] = 135699;
        ["spells"] = {
            [258313] = {};
            [209859] = {};
            [258317] = {};
        };
        ["stealthDetect"] = true;
        ["characteristics"] = {
            ["Taunt"] = true;
            ["Incapacitate"] = true;
            ["Root"] = true;
            ["Disorient"] = true;
            ["Sap"] = true;
            ["Stun"] = true;
            ["Slow"] = true;
            ["Silence"] = true;
            ["Fear"] = true;
        };
        ["scale"] = 1.2;
        ["count"] = 7;
        ["displayId"] = 81513;
        ["creatureType"] = "Humanoid";
        ["level"] = 120;
        ["health"] = 1229590;
        ["name"] = "Ashvane Jailer";
    };
    [32] = {
        ["clones"] = {
            [1] = {
                ["y"] = -195.92005212622;
                ["x"] = 380.17865844586;
                ["sublevel"] = 3;
                ["week"] = {
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
            };
        };
        ["count"] = 7;
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
        ["teemingCount"] = 10;
        ["health"] = 2151786;
        ["displayId"] = 92229;
        ["creatureType"] = "Aberration";
        ["level"] = 122;
        ["scale"] = 1.4;
        ["id"] = 161244;
    };
    [17] = {
        ["clones"] = {
            [13] = {
                ["y"] = -428.72700391062;
                ["x"] = 337.61022896149;
                ["g"] = 37;
                ["sublevel"] = 6;
            };
            [7] = {
                ["sublevel"] = 5;
                ["x"] = 436.89852951953;
                ["infested"] = {
                    [3] = true;
                };
                ["g"] = 31;
                ["y"] = -116.52643540471;
            };
            [1] = {
                ["y"] = -431.49747604165;
                ["x"] = 273.59065723706;
                ["g"] = 25;
                ["sublevel"] = 5;
            };
            [2] = {
                ["y"] = -358.48696179859;
                ["x"] = 416.21652165327;
                ["g"] = 26;
                ["sublevel"] = 5;
            };
            [4] = {
                ["y"] = -236.49684323045;
                ["x"] = 339.97462175159;
                ["g"] = 40;
                ["sublevel"] = 5;
            };
            [8] = {
                ["sublevel"] = 5;
                ["x"] = 429.47915806449;
                ["infested"] = {
                    [3] = true;
                };
                ["g"] = 31;
                ["y"] = -128.13931468112;
            };
            [9] = {
                ["sublevel"] = 6;
                ["x"] = 407.00029696023;
                ["y"] = -116.73914881196;
                ["g"] = 33;
                ["infested"] = {
                    [2] = true;
                };
            };
            [5] = {
                ["y"] = -184.2656017754;
                ["x"] = 309.71831615463;
                ["g"] = 29;
                ["sublevel"] = 5;
            };
            [10] = {
                ["y"] = -188.70847958861;
                ["x"] = 341.32534143007;
                ["g"] = 34;
                ["sublevel"] = 6;
            };
            [14] = {
                ["y"] = -228.88503493595;
                ["x"] = 349.18896568803;
                ["teeming"] = true;
                ["g"] = 40;
                ["sublevel"] = 5;
            };
            [3] = {
                ["sublevel"] = 5;
                ["x"] = 445.3997130528;
                ["y"] = -399.09683310571;
                ["g"] = 27;
                ["infested"] = {
                    [1] = true;
                };
            };
            [6] = {
                ["y"] = -184.62271877494;
                ["x"] = 324.00409967373;
                ["g"] = 29;
                ["sublevel"] = 5;
            };
            [12] = {
                ["sublevel"] = 6;
                ["x"] = 343.49253473649;
                ["infested"] = {
                    [3] = true;
                };
                ["g"] = 37;
                ["y"] = -419.02110471566;
            };
            [11] = {
                ["sublevel"] = 6;
                ["x"] = 282.00011311733;
                ["infested"] = {
                    [3] = true;
                };
                ["g"] = 35;
                ["y"] = -268.13304911185;
            };
        };
        ["reaping"] = 148716;
        ["id"] = 127486;
        ["spells"] = {
            [258317] = {};
            [277242] = {};
            [209859] = {};
            [132951] = {};
            [258313] = {};
            [277564] = {};
        };
        ["stealthDetect"] = true;
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
        ["count"] = 7;
        ["name"] = "Ashvane Officer";
        ["displayId"] = 84380;
        ["creatureType"] = "Humanoid";
        ["level"] = 120;
        ["health"] = 1229592;
        ["scale"] = 1.2;
    };
    [9] = {
        ["clones"] = {
            [1] = {
                ["y"] = -186.36952183157;
                ["x"] = 399.16415349133;
                ["sublevel"] = 3;
            };
            [2] = {
                ["y"] = -172.85543408806;
                ["x"] = 377.76183798225;
                ["sublevel"] = 3;
            };
            [4] = {
                ["y"] = -213.58579952476;
                ["x"] = 363.25811227846;
                ["infested"] = {
                    [1] = true;
                };
                ["sublevel"] = 3;
            };
            [8] = {
                ["y"] = -270.17822762617;
                ["x"] = 497.95742789606;
                ["sublevel"] = 3;
            };
            [16] = {
                ["y"] = -388.76501474893;
                ["x"] = 485.10320075226;
                ["sublevel"] = 3;
            };
            [17] = {
                ["y"] = -416.71908917301;
                ["x"] = 421.62820196217;
                ["sublevel"] = 4;
            };
            [9] = {
                ["y"] = -300.93909904085;
                ["x"] = 514.59871463497;
                ["sublevel"] = 3;
                ["infested"] = {
                    [1] = true;
                };
            };
            [18] = {
                ["y"] = -440.20744651337;
                ["x"] = 408.13980889411;
                ["sublevel"] = 4;
            };
            [31] = {
                ["y"] = -394.60521477265;
                ["x"] = 321.22994208553;
                ["sublevel"] = 5;
                ["infested"] = {
                    [1] = true;
                };
            };
            [5] = {
                ["y"] = -247.58941250354;
                ["x"] = 435.51552474471;
                ["sublevel"] = 3;
            };
            [10] = {
                ["y"] = -242.32351042292;
                ["x"] = 367.92955528628;
                ["sublevel"] = 3;
            };
            [20] = {
                ["y"] = -215.84435874927;
                ["x"] = 512.72816932252;
                ["sublevel"] = 4;
                ["infested"] = {
                    [1] = true;
                };
            };
            [30] = {
                ["y"] = -382.21391295582;
                ["x"] = 350.36039252306;
                ["sublevel"] = 5;
            };
            [21] = {
                ["y"] = -246.48948875714;
                ["x"] = 511.43785709384;
                ["sublevel"] = 4;
            };
            [11] = {
                ["y"] = -264.81075196189;
                ["x"] = 358.95549013445;
                ["sublevel"] = 3;
            };
            [22] = {
                ["y"] = -170.49694998748;
                ["x"] = 537.99899643287;
                ["sublevel"] = 4;
            };
            [3] = {
                ["y"] = -188.04642190814;
                ["x"] = 356.5394392884;
                ["sublevel"] = 3;
            };
            [6] = {
                ["y"] = -245.97651529586;
                ["x"] = 455.83812923582;
                ["sublevel"] = 3;
                ["infested"] = {
                    [1] = true;
                };
            };
            [12] = {
                ["y"] = -288.63135010439;
                ["x"] = 292.83791167328;
                ["sublevel"] = 3;
            };
            [24] = {
                ["y"] = -227.6260183297;
                ["x"] = 552.22488520648;
                ["sublevel"] = 4;
            };
            [19] = {
                ["y"] = -363.82208697561;
                ["x"] = 398.98219030411;
                ["sublevel"] = 4;
            };
            [25] = {
                ["y"] = -164.27339713864;
                ["x"] = 387.4814552537;
                ["sublevel"] = 4;
            };
            [13] = {
                ["y"] = -309.89522410862;
                ["x"] = 279.96680331062;
                ["sublevel"] = 3;
            };
            [26] = {
                ["y"] = -145.920272082;
                ["x"] = 407.0886780298;
                ["sublevel"] = 4;
                ["infested"] = {
                    [1] = true;
                };
            };
            [27] = {
                ["y"] = -118.29703487586;
                ["x"] = 413.89915895692;
                ["sublevel"] = 4;
            };
            [7] = {
                ["y"] = -259.67823664231;
                ["x"] = 490.45741287849;
                ["sublevel"] = 3;
            };
            [14] = {
                ["y"] = -334.06950346075;
                ["x"] = 509.24879748026;
                ["sublevel"] = 3;
            };
            [28] = {
                ["y"] = -128.29708350953;
                ["x"] = 432.89913548945;
                ["sublevel"] = 4;
            };
            [23] = {
                ["y"] = -275.49689022452;
                ["x"] = 558.99893298186;
                ["sublevel"] = 4;
            };
            [29] = {
                ["y"] = -174.95063873074;
                ["x"] = 333.97210038108;
                ["sublevel"] = 4;
            };
            [15] = {
                ["y"] = -340.10398455655;
                ["x"] = 512.17985588983;
                ["sublevel"] = 3;
            };
        };
        ["reaping"] = 148716;
        ["id"] = 130582;
        ["spells"] = {
            [277564] = {};
            [209859] = {};
            [277242] = {};
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
        ["scale"] = 1;
        ["name"] = "Despondent Scallywag";
        ["count"] = 0;
        ["displayId"] = 82828;
        ["creatureType"] = "Humanoid";
        ["level"] = 120;
        ["health"] = 230549;
        ["neutral"] = true;
    };
    [18] = {
        ["clones"] = {
            [13] = {
                ["sublevel"] = 6;
                ["x"] = 347.90433348963;
                ["y"] = -428.13876071096;
                ["g"] = 37;
                ["infested"] = {
                    [2] = true;
                };
            };
            [7] = {
                ["y"] = -129.89677011403;
                ["x"] = 453.72596677257;
                ["g"] = 31;
                ["sublevel"] = 5;
            };
            [1] = {
                ["y"] = -360.28152301284;
                ["x"] = 428.93550353855;
                ["g"] = 26;
                ["sublevel"] = 5;
            };
            [2] = {
                ["sublevel"] = 5;
                ["x"] = 528.13019744539;
                ["infested"] = {
                    [1] = true;
                };
                ["g"] = 28;
                ["y"] = -338.42129253843;
            };
            [4] = {
                ["y"] = -261.73805103142;
                ["x"] = 256.09263363268;
                ["g"] = 30;
                ["sublevel"] = 5;
            };
            [8] = {
                ["y"] = -139.10706553052;
                ["x"] = 441.41463616357;
                ["g"] = 31;
                ["sublevel"] = 5;
            };
            [15] = {
                ["y"] = -247.24263303412;
                ["x"] = 342.31352904516;
                ["teeming"] = true;
                ["g"] = 40;
                ["sublevel"] = 5;
            };
            [9] = {
                ["y"] = -121.06264448015;
                ["x"] = 395.54529956391;
                ["g"] = 33;
                ["sublevel"] = 6;
            };
            [5] = {
                ["y"] = -272.93801211483;
                ["x"] = 251.67951143731;
                ["g"] = 30;
                ["sublevel"] = 5;
            };
            [10] = {
                ["y"] = -185.76728883463;
                ["x"] = 330.73709005778;
                ["g"] = 34;
                ["sublevel"] = 6;
            };
            [14] = {
                ["y"] = -244.24260710534;
                ["x"] = 357.31353423848;
                ["teeming"] = true;
                ["g"] = 40;
                ["sublevel"] = 5;
            };
            [3] = {
                ["y"] = -348.02078743969;
                ["x"] = 284.23766854546;
                ["infested"] = {
                    [2] = true;
                    [3] = true;
                };
                ["sublevel"] = 5;
            };
            [6] = {
                ["y"] = -280.26914006618;
                ["x"] = 260.76150040665;
                ["g"] = 30;
                ["sublevel"] = 5;
            };
            [12] = {
                ["y"] = -390.9274552797;
                ["x"] = 279.43087112963;
                ["g"] = 36;
                ["sublevel"] = 6;
            };
            [11] = {
                ["sublevel"] = 6;
                ["x"] = 288.23092058391;
                ["y"] = -378.52744333478;
                ["g"] = 36;
                ["infested"] = {
                    [1] = true;
                };
            };
        };
        ["reaping"] = 148716;
        ["scale"] = 1.2;
        ["spells"] = {
            [277564] = {};
            [132951] = {};
            [209859] = {};
            [185857] = {};
            [277242] = {};
            [258864] = {};
        };
        ["characteristics"] = {
            ["Taunt"] = true;
            ["Incapacitate"] = true;
            ["Root"] = true;
            ["Polymorph"] = true;
            ["Disorient"] = true;
            ["Sap"] = true;
            ["Imprison"] = true;
            ["Stun"] = true;
            ["Slow"] = true;
            ["Silence"] = true;
            ["Fear"] = true;
        };
        ["health"] = 1229592;
        ["count"] = 7;
        ["displayId"] = 81513;
        ["creatureType"] = "Humanoid";
        ["level"] = 120;
        ["name"] = "Ashvane Marine";
        ["id"] = 130027;
    };
    [31] = {
        ["clones"] = {
            [1] = {
                ["y"] = -265.78921093021;
                ["x"] = 451.93421773319;
                ["sublevel"] = 1;
                ["week"] = {
                    [1] = true;
                    [2] = true;
                    [10] = true;
                    [6] = true;
                    [5] = true;
                    [9] = true;
                };
            };
            [2] = {
                ["y"] = -349.80502079079;
                ["x"] = 238.70893907852;
                ["sublevel"] = 6;
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
        ["teemingCount"] = 10;
        ["count"] = 7;
        ["displayId"] = 91910;
        ["creatureType"] = "Beast";
        ["corrupted"] = true;
        ["name"] = "Voidweaver Mal'thir";
        ["health"] = 2151786;
    };
    [5] = {
        ["clones"] = {
            [1] = {
                ["y"] = -288.50224547575;
                ["x"] = 438.66653393032;
                ["sublevel"] = 1;
            };
        };
        ["id"] = 127479;
        ["characteristics"] = {
            ["Taunt"] = true;
        };
        ["spells"] = {
            [259975] = {};
            [257092] = {};
            [277564] = {};
            [257617] = {};
            [257608] = {};
            [257495] = {};
            [205276] = {};
            [257580] = {};
        };
        ["isBoss"] = true;
        ["encounterID"] = 2097;
        ["instanceID"] = 1002;
        ["scale"] = 1;
        ["count"] = 0;
        ["displayId"] = 82983;
        ["creatureType"] = "Beast";
        ["level"] = 122;
        ["health"] = 5379465;
        ["name"] = "The Sand Queen";
    };
    [10] = {
        ["clones"] = {
            [13] = {
                ["y"] = -490.89182680386;
                ["x"] = 343.86708263188;
                ["sublevel"] = 3;
            };
            [7] = {
                ["y"] = -524.1061140859;
                ["x"] = 399.31109148195;
                ["sublevel"] = 3;
            };
            [1] = {
                ["y"] = -244.06877195236;
                ["x"] = 325.6419055777;
                ["sublevel"] = 3;
            };
            [2] = {
                ["y"] = -320.47911822193;
                ["x"] = 281.72339595137;
                ["sublevel"] = 3;
            };
            [4] = {
                ["y"] = -336.7045124401;
                ["x"] = 401.70139083722;
                ["g"] = 15;
                ["sublevel"] = 3;
            };
            [8] = {
                ["y"] = -453.1987822089;
                ["x"] = 399.13476424929;
                ["g"] = 18;
                ["sublevel"] = 3;
            };
            [9] = {
                ["y"] = -459.19877691377;
                ["x"] = 392.33470730792;
                ["g"] = 18;
                ["sublevel"] = 3;
            };
            [5] = {
                ["y"] = -381.69079464815;
                ["x"] = 471.94551441813;
                ["sublevel"] = 3;
            };
            [10] = {
                ["y"] = -460.39881018702;
                ["x"] = 385.13474799435;
                ["g"] = 18;
                ["sublevel"] = 3;
            };
            [14] = {
                ["y"] = -420.56458688456;
                ["x"] = 260.31258395163;
                ["g"] = 25;
                ["sublevel"] = 5;
            };
            [3] = {
                ["y"] = -325.88818210011;
                ["x"] = 408.23200240763;
                ["g"] = 15;
                ["sublevel"] = 3;
            };
            [6] = {
                ["y"] = -429.6626044022;
                ["x"] = 446.81472496499;
                ["sublevel"] = 3;
            };
            [12] = {
                ["sublevel"] = 3;
                ["x"] = 388.33809004435;
                ["y"] = -443.81839792574;
                ["g"] = 18;
                ["infested"] = {
                    [1] = true;
                };
            };
            [11] = {
                ["y"] = -452.05373643056;
                ["x"] = 377.45568019118;
                ["g"] = 18;
                ["sublevel"] = 3;
            };
        };
        ["reaping"] = 148716;
        ["scale"] = 1;
        ["spells"] = {
            [258134] = {};
            [277242] = {};
            [209859] = {};
            [258133] = {};
            [277564] = {};
        };
        ["characteristics"] = {
            ["Taunt"] = true;
            ["Incapacitate"] = true;
            ["Root"] = true;
            ["Polymorph"] = true;
            ["Disorient"] = true;
            ["Silence"] = true;
            ["Slow"] = true;
            ["Stun"] = true;
            ["Fear"] = true;
        };
        ["count"] = 3;
        ["name"] = "Bilge Rat Looter";
        ["displayId"] = 79322;
        ["creatureType"] = "Humanoid";
        ["level"] = 120;
        ["health"] = 461097;
        ["id"] = 127485;
    };
    [20] = {
        ["clones"] = {
            [1] = {
                ["y"] = -196.61444212221;
                ["x"] = 465.70560778831;
                ["sublevel"] = 5;
            };
        };
        ["reaping"] = 148716;
        ["scale"] = 1.2;
        ["spells"] = {
            [185857] = {};
            [258864] = {};
            [209859] = {};
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
        ["health"] = 1229592;
        ["count"] = 7;
        ["displayId"] = 81513;
        ["creatureType"] = "Humanoid";
        ["level"] = 120;
        ["name"] = "Ashvane Spotter";
        ["id"] = 136665;
    };
    [30] = {
        ["clones"] = {
            [1] = {
                ["y"] = -350.66524515811;
                ["x"] = 237.0055852033;
                ["sublevel"] = 6;
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
                ["y"] = -270.074231674;
                ["x"] = 449.51917204804;
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
        ["health"] = 2151786;
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
        ["count"] = 7;
        ["level"] = 122;
        ["teemingCount"] = 10;
        ["name"] = "Urg'roth, Breaker of Heroes";
        ["displayId"] = 89415;
        ["creatureType"] = "Aberration";
        ["corrupted"] = true;
        ["scale"] = 1.4;
        ["id"] = 161124;
    };
    [21] = {
        ["clones"] = {
            [1] = {
                ["y"] = -469.85788606973;
                ["x"] = 408.18795143608;
                ["sublevel"] = 6;
            };
        };
        ["scale"] = 1.4;
        ["id"] = 127490;
        ["spells"] = {
            [256976] = {};
            [257028] = {};
            [256970] = {};
            [256955] = {};
        };
        ["isBoss"] = true;
        ["encounterID"] = 2099;
        ["instanceID"] = 1002;
        ["health"] = 5379465;
        ["name"] = "Knight Captain Valyri";
        ["displayId"] = 81498;
        ["creatureType"] = "Humanoid";
        ["level"] = 122;
        ["count"] = 0;
        ["characteristics"] = {
            ["Taunt"] = true;
        };
    };
    [11] = {
        ["clones"] = {
            [6] = {
                ["y"] = -315.53595075063;
                ["x"] = 396.65372420396;
                ["teeming"] = true;
                ["g"] = 15;
                ["sublevel"] = 3;
            };
            [2] = {
                ["sublevel"] = 3;
                ["x"] = 302.13192386986;
                ["infested"] = {
                    [2] = true;
                };
                ["g"] = 14;
                ["y"] = -336.34531991941;
            };
            [3] = {
                ["y"] = -315.18091172191;
                ["x"] = 463.96367588866;
                ["g"] = 16;
                ["sublevel"] = 3;
            };
            [1] = {
                ["y"] = -342.85695519908;
                ["x"] = 303.06214892669;
                ["g"] = 14;
                ["sublevel"] = 3;
            };
            [4] = {
                ["y"] = -446.34556786155;
                ["x"] = 290.27940164397;
                ["g"] = 19;
                ["sublevel"] = 3;
            };
            [5] = {
                ["y"] = -232.54112799194;
                ["x"] = 358.86758599858;
                ["g"] = 23;
                ["sublevel"] = 4;
            };
        };
        ["reaping"] = 148716;
        ["scale"] = 1;
        ["spells"] = {
            [272620] = {};
            [209859] = {};
            [277242] = {};
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
        ["count"] = 6;
        ["name"] = "Cutwater Striker";
        ["displayId"] = 78990;
        ["creatureType"] = "Humanoid";
        ["level"] = 120;
        ["health"] = 768495;
        ["id"] = 131112;
    };
    [22] = {
        ["clones"] = {
            [1] = {
                ["y"] = -349.60682645817;
                ["x"] = 507.95729835021;
                ["sublevel"] = 6;
            };
            [2] = {
                ["y"] = -171.92045801987;
                ["x"] = 466.69231767646;
                ["g"] = 39;
                ["sublevel"] = 7;
            };
            [4] = {
                ["y"] = -400.39920708411;
                ["x"] = 287.81427825998;
                ["teeming"] = true;
                ["g"] = 36;
                ["sublevel"] = 6;
            };
            [3] = {
                ["sublevel"] = 7;
                ["x"] = 484.38466373628;
                ["infested"] = {
                    [3] = true;
                };
                ["g"] = 39;
                ["y"] = -184.22818275919;
            };
        };
        ["reaping"] = 148894;
        ["id"] = 127497;
        ["spells"] = {
            [259188] = {};
            [259711] = {};
        };
        ["stealthDetect"] = true;
        ["characteristics"] = {
            ["Taunt"] = true;
            ["Incapacitate"] = true;
            ["Root"] = true;
            ["Polymorph"] = true;
            ["Disorient"] = true;
            ["Sap"] = true;
            ["Repentance"] = true;
            ["Stun"] = true;
            ["Slow"] = true;
            ["Silence"] = true;
            ["Fear"] = true;
        };
        ["scale"] = 1.2;
        ["count"] = 9;
        ["displayId"] = 81496;
        ["creatureType"] = "Humanoid";
        ["level"] = 121;
        ["health"] = 1383291;
        ["name"] = "Ashvane Warden";
    };
    [3] = {
        ["clones"] = {
            [15] = {
                ["sublevel"] = 1;
                ["x"] = 509.89701444861;
                ["teeming"] = true;
                ["g"] = 6;
                ["y"] = -275.26076764221;
            };
            [13] = {
                ["sublevel"] = 1;
                ["x"] = 450.96845366135;
                ["teeming"] = true;
                ["g"] = 5;
                ["y"] = -329.18935366965;
            };
            [7] = {
                ["y"] = -314.49730942398;
                ["x"] = 338.99908497557;
                ["sublevel"] = 2;
            };
            [1] = {
                ["sublevel"] = 1;
                ["x"] = 554.33223641337;
                ["infested"] = {
                    [3] = true;
                };
                ["g"] = 2;
                ["y"] = -269.54240043972;
            };
            [2] = {
                ["sublevel"] = 1;
                ["x"] = 557.0822519334;
                ["infested"] = {
                    [1] = true;
                };
                ["g"] = 2;
                ["y"] = -261.79239278937;
            };
            [4] = {
                ["y"] = -329.51210718072;
                ["x"] = 513.40430820744;
                ["sublevel"] = 1;
            };
            [8] = {
                ["sublevel"] = 2;
                ["x"] = 363.9931776649;
                ["infested"] = {
                    [3] = true;
                };
                ["g"] = 8;
                ["y"] = -270.08151859923;
            };
            [16] = {
                ["sublevel"] = 1;
                ["x"] = 508.11133764151;
                ["teeming"] = true;
                ["g"] = 6;
                ["y"] = -284.54645256979;
            };
            [9] = {
                ["y"] = -251.71261273687;
                ["x"] = 364.28735204952;
                ["g"] = 8;
                ["sublevel"] = 2;
            };
            [5] = {
                ["sublevel"] = 1;
                ["x"] = 486.76462087793;
                ["infested"] = {
                    [2] = true;
                    [3] = true;
                };
                ["g"] = 3;
                ["y"] = -365.14670956877;
            };
            [10] = {
                ["y"] = -218.66091147994;
                ["x"] = 397.9740854707;
                ["infested"] = {
                    [2] = true;
                };
                ["sublevel"] = 2;
            };
            [14] = {
                ["sublevel"] = 1;
                ["x"] = 450.25418906927;
                ["teeming"] = true;
                ["g"] = 5;
                ["y"] = -339.18933384312;
            };
            [3] = {
                ["y"] = -319.21199513459;
                ["x"] = 552.26730775915;
                ["infested"] = {
                    [2] = true;
                };
                ["sublevel"] = 1;
            };
            [6] = {
                ["sublevel"] = 1;
                ["x"] = 482.64699421327;
                ["y"] = -372.20552698742;
                ["g"] = 3;
                ["infested"] = {
                    [1] = true;
                };
            };
            [12] = {
                ["sublevel"] = 2;
                ["infested"] = {
                    [2] = true;
                };
                ["x"] = 386.99898050725;
                ["g"] = 44;
                ["y"] = -479.49735781828;
            };
            [11] = {
                ["y"] = -280.49732836708;
                ["x"] = 418.99912118539;
                ["sublevel"] = 2;
            };
        };
        ["reaping"] = 148716;
        ["scale"] = 1.2;
        ["spells"] = {
            [277564] = {};
            [209859] = {};
            [277242] = {};
            [258079] = {};
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
        ["health"] = 845345;
        ["count"] = 4;
        ["displayId"] = 84333;
        ["creatureType"] = "Beast";
        ["level"] = 120;
        ["name"] = "Sewer Vicejaw";
        ["id"] = 127482;
    };
    [6] = {
        ["clones"] = {
            [1] = {
                ["y"] = -217.64026135748;
                ["x"] = 480.99935364488;
                ["infested"] = {
                    [3] = true;
                };
                ["sublevel"] = 2;
            };
            [2] = {
                ["y"] = -328.1330661427;
                ["x"] = 397.82382324822;
                ["patrol"] = {
                    [6] = {
                        ["y"] = -312.41877274579;
                        ["x"] = 373.53810107037;
                    };
                    [2] = {
                        ["y"] = -350.75231298973;
                        ["x"] = 430.85352893265;
                    };
                    [3] = {
                        ["y"] = -375.39520986025;
                        ["x"] = 415.13927741539;
                    };
                    [1] = {
                        ["y"] = -328.1330661427;
                        ["x"] = 397.82382324822;
                    };
                    [4] = {
                        ["y"] = -350.75231298973;
                        ["x"] = 430.85352893265;
                    };
                    [5] = {
                        ["y"] = -328.1330661427;
                        ["x"] = 397.82382324822;
                    };
                };
                ["infested"] = {
                    [3] = true;
                };
                ["g"] = 15;
                ["sublevel"] = 3;
            };
            [4] = {
                ["y"] = -207.15826466181;
                ["x"] = 490.42071295242;
                ["teeming"] = true;
                ["sublevel"] = 2;
            };
            [3] = {
                ["sublevel"] = 5;
                ["x"] = 260.60025859838;
                ["y"] = -432.05543520436;
                ["g"] = 25;
                ["infested"] = {
                    [3] = true;
                };
            };
        };
        ["reaping"] = 148894;
        ["id"] = 130025;
        ["spells"] = {
            [277564] = {};
            [209859] = {};
            [258128] = {};
        };
        ["stealthDetect"] = true;
        ["characteristics"] = {
            ["Taunt"] = true;
        };
        ["scale"] = 1.4;
        ["health"] = 1152743;
        ["displayId"] = 81499;
        ["creatureType"] = "Humanoid";
        ["level"] = 121;
        ["count"] = 7;
        ["name"] = "Irontide Thug";
    };
    [12] = {
        ["clones"] = {
            [6] = {
                ["y"] = -240.04115207794;
                ["x"] = 351.01046023995;
                ["g"] = 23;
                ["sublevel"] = 4;
            };
            [2] = {
                ["y"] = -436.58963338193;
                ["x"] = 288.05961152145;
                ["g"] = 19;
                ["sublevel"] = 3;
            };
            [3] = {
                ["sublevel"] = 4;
                ["x"] = 440.07049065209;
                ["y"] = -309.06839434267;
                ["g"] = 21;
                ["infested"] = {
                    [1] = true;
                };
            };
            [1] = {
                ["sublevel"] = 3;
                ["x"] = 280.78690373476;
                ["y"] = -447.49873407591;
                ["g"] = 19;
                ["infested"] = {
                    [2] = true;
                };
            };
            [4] = {
                ["y"] = -280.49696524666;
                ["x"] = 461.14195696974;
                ["g"] = 21;
                ["sublevel"] = 4;
            };
            [5] = {
                ["y"] = -221.11258700735;
                ["x"] = 367.79621602493;
                ["g"] = 23;
                ["sublevel"] = 4;
            };
            [7] = {
                ["y"] = -229.42082777753;
                ["x"] = 343.50529897076;
                ["teeming"] = true;
                ["g"] = 23;
                ["sublevel"] = 4;
            };
        };
        ["reaping"] = 148893;
        ["id"] = 130026;
        ["spells"] = {
            [258150] = {};
            [209859] = {};
            [258153] = {};
            [277564] = {};
            [277242] = {};
        };
        ["characteristics"] = {
            ["Taunt"] = true;
            ["Incapacitate"] = true;
            ["Root"] = true;
            ["Imprison"] = true;
            ["Polymorph"] = true;
            ["Disorient"] = true;
            ["Sap"] = true;
            ["Mind Control"] = true;
            ["Stun"] = true;
            ["Slow"] = true;
            ["Silence"] = true;
            ["Fear"] = true;
        };
        ["name"] = "Bilge Rat Seaspeaker";
        ["health"] = 691646;
        ["displayId"] = 42840;
        ["creatureType"] = "Humanoid";
        ["level"] = 120;
        ["count"] = 6;
        ["scale"] = 1.2;
    };
    [24] = {
        ["clones"] = {
            [1] = {
                ["y"] = -379.05602618369;
                ["x"] = 336.40231150178;
                ["sublevel"] = 7;
            };
        };
        ["id"] = 127503;
        ["characteristics"] = {
            ["Taunt"] = true;
        };
        ["spells"] = {
            [256044] = {};
            [256198] = {};
            [256200] = {};
            [256039] = {};
            [256101] = {};
            [256105] = {};
            [256199] = {};
            [256201] = {};
            [256128] = {};
            [256083] = {};
            [256038] = {};
        };
        ["isBoss"] = true;
        ["encounterID"] = 2096;
        ["instanceID"] = 1002;
        ["scale"] = 1;
        ["count"] = 0;
        ["displayId"] = 81505;
        ["creatureType"] = "Humanoid";
        ["level"] = 122;
        ["health"] = 6609057;
        ["name"] = "Overseer Korgus";
    };
    [19] = {
        ["clones"] = {
            [7] = {
                ["sublevel"] = 5;
                ["x"] = 537.36915862756;
                ["infested"] = {
                    [3] = true;
                };
                ["g"] = 32;
                ["y"] = -274.16641241129;
            };
            [1] = {
                ["y"] = -401.59213388675;
                ["x"] = 484.78556244655;
                ["g"] = 27;
                ["sublevel"] = 5;
            };
            [2] = {
                ["y"] = -329.84984081926;
                ["x"] = 494.2015688759;
                ["g"] = 28;
                ["sublevel"] = 5;
            };
            [4] = {
                ["sublevel"] = 5;
                ["x"] = 410.93685438669;
                ["y"] = -150.94506086973;
                ["infested"] = {
                    [2] = true;
                };
            };
            [8] = {
                ["y"] = -269.95122712534;
                ["x"] = 268.81835147547;
                ["g"] = 35;
                ["sublevel"] = 6;
            };
            [9] = {
                ["sublevel"] = 6;
                ["x"] = 287.0001122935;
                ["y"] = -279.49667967899;
                ["g"] = 35;
                ["infested"] = {
                    [2] = true;
                };
            };
            [5] = {
                ["y"] = -255.32920031569;
                ["x"] = 534.1133210271;
                ["g"] = 32;
                ["sublevel"] = 5;
            };
            [10] = {
                ["y"] = -388.92747130218;
                ["x"] = 290.03091038846;
                ["g"] = 36;
                ["sublevel"] = 6;
            };
            [3] = {
                ["y"] = -315.20698628135;
                ["x"] = 507.4158787811;
                ["g"] = 28;
                ["sublevel"] = 5;
            };
            [6] = {
                ["y"] = -279.98036392787;
                ["x"] = 520.62492795904;
                ["g"] = 32;
                ["sublevel"] = 5;
            };
            [11] = {
                ["y"] = -384.76549551068;
                ["x"] = 299.95970605716;
                ["teeming"] = true;
                ["g"] = 36;
                ["sublevel"] = 6;
            };
        };
        ["reaping"] = 148893;
        ["scale"] = 1.2;
        ["spells"] = {
            [258869] = {};
            [277564] = {};
            [258634] = {};
            [209859] = {};
            [277242] = {};
        };
        ["characteristics"] = {
            ["Taunt"] = true;
            ["Incapacitate"] = true;
            ["Root"] = true;
            ["Polymorph"] = true;
            ["Disorient"] = true;
            ["Silence"] = true;
            ["Slow"] = true;
            ["Stun"] = true;
            ["Fear"] = true;
        };
        ["health"] = 1075893;
        ["count"] = 7;
        ["displayId"] = 81520;
        ["creatureType"] = "Humanoid";
        ["level"] = 120;
        ["name"] = "Ashvane Flamecaster";
        ["id"] = 127488;
    };
    [25] = {
        ["clones"] = {
            [1] = {
                ["y"] = -328.42866822157;
                ["x"] = 257.82684543938;
                ["g"] = 24;
                ["sublevel"] = 4;
            };
        };
        ["reaping"] = 148716;
        ["scale"] = 1;
        ["spells"] = {
            [209859] = {};
        };
        ["characteristics"] = {
            ["Taunt"] = true;
        };
        ["count"] = 3;
        ["name"] = "Bilge Rat Looter";
        ["displayId"] = 79322;
        ["creatureType"] = "Humanoid";
        ["level"] = 120;
        ["health"] = 461096;
        ["id"] = 135706;
    };
    [13] = {
        ["clones"] = {
            [2] = {
                ["y"] = -294.94335528054;
                ["x"] = 519.73551776178;
                ["sublevel"] = 4;
            };
            [3] = {
                ["y"] = -162.51820154885;
                ["x"] = 331.53965844642;
                ["sublevel"] = 4;
            };
            [1] = {
                ["y"] = -323.56841311087;
                ["x"] = 509.64193698534;
                ["sublevel"] = 4;
            };
            [4] = {
                ["y"] = -187.09743281643;
                ["x"] = 315.99131365628;
                ["sublevel"] = 4;
            };
            [5] = {
                ["y"] = -215.21126254028;
                ["x"] = 294.92759545372;
                ["sublevel"] = 4;
            };
        };
        ["reaping"] = 148716;
        ["scale"] = 1;
        ["spells"] = {
            [209859] = {};
        };
        ["characteristics"] = {
            ["Taunt"] = true;
            ["Incapacitate"] = true;
            ["Stun"] = true;
            ["Slow"] = true;
            ["Root"] = true;
        };
        ["count"] = 4;
        ["name"] = "Irontide Raider";
        ["displayId"] = 79064;
        ["creatureType"] = "Humanoid";
        ["level"] = 120;
        ["health"] = 461096;
        ["id"] = 135254;
    };
    [26] = {
        ["clones"] = {
            [1] = {
                ["y"] = -353.31702109471;
                ["x"] = 508.09733273653;
                ["week"] = {
                    [1] = true;
                    [10] = true;
                    [4] = true;
                    [7] = true;
                };
                ["g"] = 4;
                ["sublevel"] = 1;
            };
            [2] = {
                ["y"] = -219.72730116875;
                ["x"] = 552.88147275471;
                ["week"] = {
                    [1] = true;
                    [10] = true;
                    [4] = true;
                    [7] = true;
                };
                ["g"] = 42;
                ["sublevel"] = 4;
            };
            [4] = {
                ["y"] = -279.78880406067;
                ["x"] = 273.93899122825;
                ["week"] = {
                    [1] = true;
                    [10] = true;
                    [4] = true;
                    [7] = true;
                };
                ["g"] = 35;
                ["sublevel"] = 6;
            };
            [8] = {
                ["y"] = -322.12654238511;
                ["x"] = 468.71961467657;
                ["week"] = {
                    [8] = true;
                    [2] = true;
                    [11] = true;
                    [5] = true;
                };
                ["g"] = 16;
                ["sublevel"] = 3;
            };
            [16] = {
                ["y"] = -293.98847036154;
                ["x"] = 442.3845485218;
                ["week"] = {
                    [3] = true;
                    [6] = true;
                    [9] = true;
                    [12] = true;
                };
                ["g"] = 21;
                ["sublevel"] = 4;
            };
            [17] = {
                ["y"] = -269.8593894562;
                ["x"] = 527.1864201539;
                ["week"] = {
                    [3] = true;
                    [6] = true;
                    [9] = true;
                    [12] = true;
                };
                ["g"] = 32;
                ["sublevel"] = 5;
            };
            [9] = {
                ["y"] = -317.05867668388;
                ["x"] = 447.35547188978;
                ["week"] = {
                    [5] = true;
                    [2] = true;
                    [11] = true;
                    [8] = true;
                };
                ["g"] = 21;
                ["sublevel"] = 4;
            };
            [5] = {
                ["y"] = -279.04595330864;
                ["x"] = 501.83029905483;
                ["sublevel"] = 1;
                ["g"] = 6;
                ["week"] = {
                    [8] = true;
                    [2] = true;
                    [11] = true;
                    [5] = true;
                };
            };
            [10] = {
                ["y"] = -230.08562572814;
                ["x"] = 351.65110818434;
                ["week"] = {
                    [5] = true;
                    [2] = true;
                    [11] = true;
                    [8] = true;
                };
                ["g"] = 23;
                ["sublevel"] = 4;
            };
            [11] = {
                ["y"] = -145.25186884534;
                ["x"] = 428.29762213491;
                ["week"] = {
                    [8] = true;
                    [2] = true;
                    [11] = true;
                    [5] = true;
                };
                ["g"] = 31;
                ["sublevel"] = 5;
            };
            [3] = {
                ["y"] = -421.10744168871;
                ["x"] = 271.08437553479;
                ["week"] = {
                    [1] = true;
                    [10] = true;
                    [4] = true;
                    [7] = true;
                };
                ["g"] = 25;
                ["sublevel"] = 5;
            };
            [6] = {
                ["y"] = -330.35843526324;
                ["x"] = 299.17070340396;
                ["week"] = {
                    [1] = true;
                    [10] = true;
                    [7] = true;
                    [4] = true;
                };
                ["sublevel"] = 5;
            };
            [12] = {
                ["y"] = -195.70096194246;
                ["x"] = 331.57435417986;
                ["week"] = {
                    [5] = true;
                    [2] = true;
                    [11] = true;
                    [8] = true;
                };
                ["g"] = 34;
                ["sublevel"] = 6;
            };
            [13] = {
                ["y"] = -396.65674835744;
                ["x"] = 298.29106749059;
                ["week"] = {
                    [5] = true;
                    [2] = true;
                    [11] = true;
                    [8] = true;
                };
                ["g"] = 36;
                ["sublevel"] = 6;
            };
            [7] = {
                ["y"] = -260.88239740381;
                ["x"] = 370.88912003517;
                ["week"] = {
                    [5] = true;
                    [2] = true;
                    [11] = true;
                    [8] = true;
                };
                ["g"] = 8;
                ["sublevel"] = 2;
            };
            [14] = {
                ["y"] = -233.15703702996;
                ["x"] = 390.76573558593;
                ["week"] = {
                    [3] = true;
                    [6] = true;
                    [9] = true;
                    [12] = true;
                };
                ["sublevel"] = 2;
            };
            [15] = {
                ["y"] = -450.3443629163;
                ["x"] = 295.88137889825;
                ["week"] = {
                    [3] = true;
                    [6] = true;
                    [9] = true;
                    [12] = true;
                };
                ["g"] = 19;
                ["sublevel"] = 3;
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
        ["count"] = 7;
        ["iconTexture"] = 132315;
    };
    [27] = {
        ["clones"] = {
            [13] = {
                ["y"] = -380.50324659052;
                ["x"] = 278.62030610609;
                ["week"] = {
                    [3] = true;
                    [6] = true;
                    [9] = true;
                    [12] = true;
                };
                ["g"] = 36;
                ["sublevel"] = 6;
            };
            [7] = {
                ["y"] = -416.10448760055;
                ["x"] = 373.50343349681;
                ["week"] = {
                    [1] = true;
                    [10] = true;
                    [7] = true;
                    [4] = true;
                };
                ["sublevel"] = 3;
            };
            [1] = {
                ["y"] = -281.09119544881;
                ["x"] = 572.36246658919;
                ["week"] = {
                    [1] = true;
                    [10] = true;
                    [4] = true;
                    [7] = true;
                };
                ["g"] = 7;
                ["sublevel"] = 2;
            };
            [2] = {
                ["y"] = -180.26056572707;
                ["x"] = 403.86779196846;
                ["week"] = {
                    [1] = true;
                    [10] = true;
                    [4] = true;
                    [7] = true;
                };
                ["g"] = 22;
                ["sublevel"] = 4;
            };
            [4] = {
                ["y"] = -250.32552514703;
                ["x"] = 555.57592868086;
                ["week"] = {
                    [1] = true;
                    [10] = true;
                    [4] = true;
                    [7] = true;
                };
                ["g"] = 38;
                ["sublevel"] = 6;
            };
            [8] = {
                ["y"] = -184.30899993373;
                ["x"] = 435.56860705071;
                ["week"] = {
                    [5] = true;
                    [2] = true;
                    [11] = true;
                    [8] = true;
                };
                ["g"] = 11;
                ["sublevel"] = 3;
            };
            [9] = {
                ["y"] = -341.14360932176;
                ["x"] = 297.0192226987;
                ["week"] = {
                    [5] = true;
                    [2] = true;
                    [11] = true;
                    [8] = true;
                };
                ["g"] = 14;
                ["sublevel"] = 3;
            };
            [5] = {
                ["y"] = -270.04557280102;
                ["x"] = 565.35969737367;
                ["week"] = {
                    [1] = true;
                    [10] = true;
                    [7] = true;
                    [4] = true;
                };
                ["g"] = 2;
                ["sublevel"] = 1;
            };
            [10] = {
                ["y"] = -370.62157036775;
                ["x"] = 425.35004135891;
                ["week"] = {
                    [5] = true;
                    [2] = true;
                    [11] = true;
                    [8] = true;
                };
                ["g"] = 26;
                ["sublevel"] = 5;
            };
            [14] = {
                ["y"] = -467.03305243309;
                ["x"] = 388.2695061819;
                ["sublevel"] = 2;
                ["g"] = 44;
                ["week"] = {
                    [3] = true;
                    [6] = true;
                    [9] = true;
                    [12] = true;
                };
            };
            [3] = {
                ["y"] = -127.18255454881;
                ["x"] = 403.45427683553;
                ["week"] = {
                    [1] = true;
                    [10] = true;
                    [4] = true;
                    [7] = true;
                };
                ["g"] = 33;
                ["sublevel"] = 6;
            };
            [6] = {
                ["y"] = -267.66639157889;
                ["x"] = 348.75151893825;
                ["week"] = {
                    [1] = true;
                    [10] = true;
                    [7] = true;
                    [4] = true;
                };
                ["sublevel"] = 2;
            };
            [12] = {
                ["y"] = -354.02661195544;
                ["x"] = 399.62497998002;
                ["week"] = {
                    [3] = true;
                    [6] = true;
                    [9] = true;
                    [12] = true;
                };
                ["g"] = 26;
                ["sublevel"] = 5;
            };
            [11] = {
                ["y"] = -309.12126618697;
                ["x"] = 481.80928716879;
                ["week"] = {
                    [3] = true;
                    [6] = true;
                    [9] = true;
                    [12] = true;
                };
                ["g"] = 16;
                ["sublevel"] = 3;
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
        ["id"] = 155433;
        ["name"] = "Void-Touched Emissary";
        ["ignoreFortified"] = true;
        ["health"] = 999042;
        ["displayId"] = 39391;
        ["creatureType"] = "Humanoid";
        ["level"] = 122;
        ["count"] = 7;
        ["iconTexture"] = 132886;
    };
    [7] = {
        ["clones"] = {
            [1] = {
                ["y"] = -171.61955940192;
                ["x"] = 438.91364326191;
                ["g"] = 11;
                ["sublevel"] = 3;
            };
            [2] = {
                ["y"] = -293.07662931057;
                ["x"] = 442.36530621817;
                ["teeming"] = true;
                ["g"] = 21;
                ["sublevel"] = 4;
            };
        };
        ["reaping"] = 148716;
        ["scale"] = 1.2;
        ["spells"] = {
            [272620] = {};
            [209859] = {};
            [277242] = {};
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
        ["health"] = 768494;
        ["count"] = 6;
        ["displayId"] = 78990;
        ["creatureType"] = "Humanoid";
        ["level"] = 120;
        ["name"] = "Cutwater Striker";
        ["id"] = 131112;
    };
    [14] = {
        ["clones"] = {
            [1] = {
                ["sublevel"] = 4;
                ["x"] = 352.79616785293;
                ["y"] = -221.11258700735;
                ["g"] = 23;
                ["infested"] = {};
            };
        };
        ["reaping"] = 148894;
        ["scale"] = 1.2;
        ["spells"] = {
            [259711] = {};
            [259188] = {};
            [277564] = {};
        };
        ["characteristics"] = {
            ["Incapacitate"] = true;
            ["Disorient"] = true;
            ["Silence"] = true;
            ["Stun"] = true;
            ["Slow"] = true;
            ["Root"] = true;
            ["Fear"] = true;
        };
        ["count"] = 9;
        ["name"] = "Block Warden";
        ["displayId"] = 81496;
        ["creatureType"] = "Humanoid";
        ["level"] = 121;
        ["health"] = 1383289;
        ["id"] = 131445;
    };
    [28] = {
        ["clones"] = {
            [13] = {
                ["y"] = -142.88162125857;
                ["x"] = 427.63000133833;
                ["week"] = {
                    [3] = true;
                    [6] = true;
                    [9] = true;
                    [12] = true;
                };
                ["g"] = 31;
                ["sublevel"] = 5;
            };
            [7] = {
                ["y"] = -453.82135033898;
                ["x"] = 329.14047628215;
                ["week"] = {
                    [5] = true;
                    [2] = true;
                    [11] = true;
                    [8] = true;
                };
                ["g"] = 43;
                ["sublevel"] = 4;
            };
            [1] = {
                ["y"] = -284.68482693768;
                ["x"] = 502.79983868474;
                ["week"] = {
                    [1] = true;
                    [10] = true;
                    [4] = true;
                    [7] = true;
                };
                ["g"] = 41;
                ["sublevel"] = 3;
            };
            [2] = {
                ["y"] = -456.27793343565;
                ["x"] = 288.80306211589;
                ["week"] = {
                    [1] = true;
                    [10] = true;
                    [4] = true;
                    [7] = true;
                };
                ["g"] = 19;
                ["sublevel"] = 3;
            };
            [4] = {
                ["y"] = -434.69791266368;
                ["x"] = 344.06027103904;
                ["week"] = {
                    [1] = true;
                    [10] = true;
                    [7] = true;
                    [4] = true;
                };
                ["g"] = 37;
                ["sublevel"] = 6;
            };
            [8] = {
                ["y"] = -178.11832002905;
                ["x"] = 475.71716264192;
                ["week"] = {
                    [5] = true;
                    [2] = true;
                    [11] = true;
                    [8] = true;
                };
                ["g"] = 39;
                ["sublevel"] = 7;
            };
            [15] = {
                ["y"] = -256.0037434388;
                ["x"] = 564.90718886187;
                ["week"] = {
                    [3] = true;
                    [6] = true;
                    [9] = true;
                    [12] = true;
                };
                ["g"] = 38;
                ["sublevel"] = 6;
            };
            [9] = {
                ["y"] = -340.32687214046;
                ["x"] = 475.05293669976;
                ["week"] = {
                    [3] = true;
                    [6] = true;
                    [9] = true;
                    [12] = true;
                };
                ["g"] = 5;
                ["sublevel"] = 1;
            };
            [5] = {
                ["y"] = -371.76041302683;
                ["x"] = 492.3068378409;
                ["sublevel"] = 1;
                ["g"] = 3;
                ["week"] = {
                    [8] = true;
                    [2] = true;
                    [11] = true;
                    [5] = true;
                };
            };
            [10] = {
                ["y"] = -280.32594235835;
                ["x"] = 532.79577776622;
                ["week"] = {
                    [3] = true;
                    [6] = true;
                    [9] = true;
                    [12] = true;
                };
                ["g"] = 6;
                ["sublevel"] = 1;
            };
            [14] = {
                ["y"] = -277.62451311043;
                ["x"] = 275.28099385514;
                ["week"] = {
                    [3] = true;
                    [6] = true;
                    [9] = true;
                    [12] = true;
                };
                ["g"] = 35;
                ["sublevel"] = 6;
            };
            [3] = {
                ["y"] = -324.21846447566;
                ["x"] = 502.73447103133;
                ["week"] = {
                    [1] = true;
                    [10] = true;
                    [4] = true;
                    [7] = true;
                };
                ["g"] = 28;
                ["sublevel"] = 5;
            };
            [6] = {
                ["y"] = -469.36347991343;
                ["x"] = 380.69000409402;
                ["week"] = {
                    [1] = true;
                    [10] = true;
                    [7] = true;
                    [4] = true;
                };
                ["g"] = 2;
                ["sublevel"] = 2;
            };
            [12] = {
                ["y"] = -159.18493088851;
                ["x"] = 407.33569391737;
                ["week"] = {
                    [3] = true;
                    [6] = true;
                    [9] = true;
                    [12] = true;
                };
                ["g"] = 22;
                ["sublevel"] = 4;
            };
            [11] = {
                ["y"] = -452.10828508364;
                ["x"] = 388.01366677125;
                ["week"] = {
                    [3] = true;
                    [6] = true;
                    [9] = true;
                    [12] = true;
                };
                ["g"] = 18;
                ["sublevel"] = 3;
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
    [23] = {
        ["clones"] = {
            [1] = {
                ["sublevel"] = 6;
                ["x"] = 557.92331321717;
                ["y"] = -259.55412635752;
                ["g"] = 38;
                ["infested"] = {
                    [2] = true;
                };
            };
            [2] = {
                ["sublevel"] = 6;
                ["x"] = 565.7804389758;
                ["infested"] = {
                    [3] = true;
                };
                ["g"] = 38;
                ["y"] = -264.55413219691;
            };
            [3] = {
                ["y"] = -169.76710967625;
                ["x"] = 482.64180523204;
                ["teeming"] = true;
                ["g"] = 39;
                ["sublevel"] = 7;
            };
        };
        ["reaping"] = 148893;
        ["scale"] = 1;
        ["spells"] = {
            [277242] = {};
            [258935] = {};
            [209859] = {};
            [258917] = {};
            [258938] = {};
            [277564] = {};
        };
        ["characteristics"] = {
            ["Taunt"] = true;
            ["Incapacitate"] = true;
            ["Root"] = true;
            ["Polymorph"] = true;
            ["Disorient"] = true;
            ["Sap"] = true;
            ["Silence"] = true;
            ["Stun"] = true;
            ["Fear"] = true;
        };
        ["health"] = 1229592;
        ["count"] = 7;
        ["displayId"] = 81550;
        ["creatureType"] = "Humanoid";
        ["level"] = 120;
        ["name"] = "Ashvane Priest";
        ["id"] = 130028;
    };
    [29] = {
        ["clones"] = {
            [1] = {
                ["y"] = -287.4750584273;
                ["x"] = 464.71521744085;
                ["sublevel"] = 5;
                ["week"] = {
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
        ["count"] = 7;
        ["corrupted"] = true;
        ["teemingCount"] = 10;
        ["health"] = 2151786;
        ["displayId"] = 90742;
        ["creatureType"] = "Aberration";
        ["level"] = 122;
        ["name"] = "Samh'rek, Beckoner of Chaos";
        ["id"] = 161243;
    };
    [15] = {
        ["clones"] = {
            [1] = {
                ["y"] = -342.9850555754;
                ["x"] = 318.27236291642;
                ["sublevel"] = 4;
            };
        };
        ["scale"] = 1;
        ["id"] = 127484;
        ["spells"] = {
            [257827] = {};
            [257814] = {};
            [257777] = {};
            [258544] = {};
            [257785] = {};
            [257956] = {};
            [257793] = {};
            [205276] = {};
            [257791] = {};
        };
        ["isBoss"] = true;
        ["encounterID"] = 2098;
        ["instanceID"] = 1002;
        ["health"] = 4610970;
        ["name"] = "Jes Howlis";
        ["displayId"] = 81739;
        ["creatureType"] = "Humanoid";
        ["level"] = 122;
        ["count"] = 0;
        ["characteristics"] = {
            ["Taunt"] = true;
        };
    };
};
