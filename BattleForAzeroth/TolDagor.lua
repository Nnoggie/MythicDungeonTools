local dungeonIndex = 23
local nerfMultiplier = 1
local pi = math.pi
MethodDungeonTools.dungeonTotalCount[dungeonIndex] = {normal=160,teeming=192,teemingEnabled=true}

MethodDungeonTools.mapPOIs[dungeonIndex] = {
    [6] = {
        [1] = {
            ["y"] = -155.99833837338;
            ["x"] = 452.00002179295;
            ["template"] = "MapLinkPinTemplate";
            ["target"] = 5;
            ["direction"] = -1;
            ["type"] = "mapLink";
        };
        [2] = {
            ["y"] = -199.9983239565;
            ["x"] = 519.99998390675;
            ["template"] = "MapLinkPinTemplate";
            ["target"] = 7;
            ["direction"] = 1;
            ["type"] = "mapLink";
        };
    };
    [2] = {
        [6] = {
            ["y"] = -198.70891225244;
            ["x"] = 570.90039133419;
            ["template"] = "MapLinkPinTemplate";
            ["type"] = "tdprisonkey";
        };
        [2] = {
            ["y"] = -120.99821179174;
            ["x"] = 454.00006758794;
            ["template"] = "MapLinkPinTemplate";
            ["target"] = 3;
            ["direction"] = -2;
            ["type"] = "mapLink";
        };
        [3] = {
            ["y"] = -226.92509913277;
            ["x"] = 497.30085206047;
            ["template"] = "MapLinkPinTemplate";
            ["doorDescription"] = "";
            ["lockpick"] = true;
            ["doorName"] = "Sewer Gate";
            ["type"] = "door";
        };
        [1] = {
            ["y"] = -293.64644125367;
            ["x"] = 592.87359409387;
            ["template"] = "MapLinkPinTemplate";
            ["target"] = 1;
            ["direction"] = 2;
            ["type"] = "mapLink";
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
    };
    [3] = {
        [1] = {
            ["y"] = -187.11512731937;
            ["x"] = 476.41240071571;
            ["template"] = "MapLinkPinTemplate";
            ["target"] = 2;
            ["direction"] = -1;
            ["type"] = "mapLink";
        };
        [2] = {
            ["y"] = -460.41462426303;
            ["x"] = 311.79902903432;
            ["template"] = "MapLinkPinTemplate";
            ["target"] = 4;
            ["direction"] = 1;
            ["type"] = "mapLink";
        };
        [3] = {
            ["y"] = -350.76394802461;
            ["x"] = 310.03890671508;
            ["template"] = "MapLinkPinTemplate";
            ["doorDescription"] = "";
            ["lockpick"] = true;
            ["doorName"] = "Prison Gate";
            ["type"] = "door";
        };
        [4] = {
            ["y"] = -294.67309052738;
            ["x"] = 478.42943341834;
            ["template"] = "MapLinkPinTemplate";
            ["doorDescription"] = "";
            ["lockpick"] = true;
            ["doorName"] = "Prison Gate";
            ["type"] = "door";
        };
        [5] = {
            ["y"] = -326.6835033043;
            ["x"] = 298.43826548799;
            ["template"] = "MapLinkPinTemplate";
            ["doorDescription"] = "Chance to contain an ally which can give you a buff dependant on their race:\nOrc: 10% Str/Agi\nUndead: 10% Stamina\nTauren: 1% HP+Mana per 10s\nBlood Elf: 10% Intellect";
            ["lockpick"] = true;
            ["doorName"] = "Prison Bars";
            ["type"] = "door";
        };
        [6] = {
            ["y"] = -236.06541579087;
            ["x"] = 358.09242143672;
            ["template"] = "MapLinkPinTemplate";
            ["doorDescription"] = "Chance to contain an ally which can give you a buff dependant on their race:\nOrc: 10% Str/Agi\nUndead: 10% Stamina\nTauren: 1% HP+Mana per 10s\nBlood Elf: 10% Intellect";
            ["lockpick"] = true;
            ["doorName"] = "Prison Bars";
            ["type"] = "door";
        };
        [7] = {
            ["y"] = -418.6335527449;
            ["x"] = 429.49956431235;
            ["template"] = "MapLinkPinTemplate";
            ["doorDescription"] = "Chance to contain an ally which can give you a buff dependant on their race:\nOrc: 10% Str/Agi\nUndead: 10% Stamina\nTauren: 1% HP+Mana per 10s\nBlood Elf: 10% Intellect";
            ["lockpick"] = true;
            ["doorName"] = "Prison Bars";
            ["type"] = "door";
        };
        [8] = {
            ["y"] = -303.0449876628;
            ["x"] = 317.04689195555;
            ["template"] = "MapLinkPinTemplate";
            ["doorDescription"] = "Chance to contain an ally which can give you a buff dependant on their race:\nOrc: 10% Str/Agi\nUndead: 10% Stamina\nTauren: 1% HP+Mana per 10s\nBlood Elf: 10% Intellect";
            ["lockpick"] = true;
            ["doorName"] = "Prison Bars";
            ["type"] = "door";
        };
        [9] = {
            ["y"] = -254.86541064356;
            ["x"] = 347.29237946953;
            ["template"] = "MapLinkPinTemplate";
            ["doorDescription"] = "Chance to contain an ally which can give you a buff dependant on their race:\nOrc: 10% Str/Agi\nUndead: 10% Stamina\nTauren: 1% HP+Mana per 10s\nBlood Elf: 10% Intellect";
            ["lockpick"] = true;
            ["doorName"] = "Prison Bars";
            ["type"] = "door";
        };
        [10] = {
            ["y"] = -369.72975641613;
            ["x"] = 461.57195383542;
            ["template"] = "MapLinkPinTemplate";
            ["doorDescription"] = "Chance to contain an ally which can give you a buff dependant on their race:\nOrc: 10% Str/Agi\nUndead: 10% Stamina\nTauren: 1% HP+Mana per 10s\nBlood Elf: 10% Intellect";
            ["lockpick"] = true;
            ["doorName"] = "Prison Bars";
            ["type"] = "door";
        };
        [11] = {
            ["y"] = -392.9440473463;
            ["x"] = 445.50049335717;
            ["template"] = "MapLinkPinTemplate";
            ["doorDescription"] = "Chance to contain an ally which can give you a buff dependant on their race:\nOrc: 10% Str/Agi\nUndead: 10% Stamina\nTauren: 1% HP+Mana per 10s\nBlood Elf: 10% Intellect";
            ["lockpick"] = true;
            ["doorName"] = "Prison Bars";
            ["type"] = "door";
        };
        [12] = {
            ["y"] = -322.22977757645;
            ["x"] = 491.92910587132;
            ["template"] = "MapLinkPinTemplate";
            ["doorDescription"] = "Chance to contain an ally which can give you a buff dependant on their race:\nOrc: 10% Str/Agi\nUndead: 10% Stamina\nTauren: 1% HP+Mana per 10s\nBlood Elf: 10% Intellect";
            ["lockpick"] = true;
            ["doorName"] = "Prison Bars";
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
    };
    [1] = {
        [1] = {
            ["y"] = -262.48238754636;
            ["x"] = 429.14575221168;
            ["template"] = "MapLinkPinTemplate";
            ["target"] = 2;
            ["direction"] = -2;
            ["type"] = "mapLink";
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
            ["graveyardDescription"] = "Unlocks after killing The Sand Queen";
            ["type"] = "graveyard";
        };
    };
    [4] = {
        [1] = {
            ["y"] = -441.99833049439;
            ["x"] = 313.00005758367;
            ["template"] = "MapLinkPinTemplate";
            ["target"] = 3;
            ["direction"] = -1;
            ["type"] = "mapLink";
        };
        [2] = {
            ["y"] = -371.99834172614;
            ["x"] = 219.00000645407;
            ["template"] = "MapLinkPinTemplate";
            ["target"] = 5;
            ["direction"] = 1;
            ["type"] = "mapLink";
        };
    };
    [5] = {
        [1] = {
            ["y"] = -384.99838623404;
            ["x"] = 212.99992649071;
            ["template"] = "MapLinkPinTemplate";
            ["target"] = 4;
            ["direction"] = -1;
            ["type"] = "mapLink";
        };
        [2] = {
            ["y"] = -92.998271234334;
            ["x"] = 487.99998658896;
            ["template"] = "MapLinkPinTemplate";
            ["target"] = 6;
            ["direction"] = 1;
            ["type"] = "mapLink";
        };
    };
    [7] = {
        [1] = {
            ["y"] = -159.99830585159;
            ["x"] = 569.99996362254;
            ["template"] = "MapLinkPinTemplate";
            ["target"] = 6;
            ["direction"] = -1;
            ["type"] = "mapLink";
        };
    };
};




MethodDungeonTools.dungeonEnemies[dungeonIndex] = {
    [7] = {
        ["clones"] = {
            [1] = {
                ["y"] = -171.61955940192;
                ["x"] = 438.91364326191;
                ["g"] = 11;
                ["sublevel"] = 3;
            };
        };
        ["scale"] = 1.2;
        ["count"] = 0;
        ["name"] = "Cutwater Striker";
        ["creatureType"] = "Humanoid";
        ["level"] = 120;
        ["id"] = 131112;
        ["displayId"] = 78990;
        ["displayId"] = 78990;
        ["health"] = 294320;
    };
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
        ["scale"] = 1;
        ["count"] = 0;
        ["name"] = "Saltwater Snapper";
        ["creatureType"] = "Beast";
        ["level"] = 121;
        ["id"] = 127477;
        ["displayId"] = 46043;
        ["health"] = 353184;
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
                ["g"] = 1;
                ["sublevel"] = 1;
            };
            [2] = {
                ["y"] = -256.30448932749;
                ["x"] = 542.14826745233;
                ["g"] = 1;
                ["sublevel"] = 1;
            };
            [4] = {
                ["y"] = -251.59017853285;
                ["x"] = 538.29112302453;
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
                ["y"] = -247.30448157543;
                ["x"] = 542.00542069631;
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
                ["y"] = -251.73304981193;
                ["x"] = 544.00542241899;
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
                ["y"] = -286.22978208705;
                ["x"] = 581.08740359176;
                ["g"] = 7;
                ["sublevel"] = 2;
            };
            [14] = {
                ["y"] = -297.47269795501;
                ["x"] = 506.22544511451;
                ["g"] = 9;
                ["sublevel"] = 2;
            };
            [15] = {
                ["y"] = -302.22271891024;
                ["x"] = 510.22543452724;
                ["g"] = 9;
                ["sublevel"] = 2;
            };
            [19] = {
                ["y"] = -381.30513414926;
                ["x"] = 452.22820143486;
                ["g"] = 10;
                ["sublevel"] = 2;
            };
            [23] = {
                ["y"] = -372.65649682114;
                ["x"] = 463.30929229638;
                ["g"] = 10;
                ["sublevel"] = 2;
            };
        };
        ["scale"] = 0.6;
        ["count"] = 0;
        ["name"] = "Stinging Parasite";
        ["creatureType"] = "Beast";
        ["level"] = 120;
        ["id"] = 127480;
        ["displayId"] = 5990;
        ["health"] = 88296;
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
            [14] = {
                ["y"] = -280.179179798;
                ["x"] = 516.34869687003;
                ["g"] = 6;
                ["sublevel"] = 1;
            };
            [9] = {
                ["y"] = -335.84582434166;
                ["x"] = 457.70713581315;
                ["g"] = 5;
                ["sublevel"] = 1;
            };
            [5] = {
                ["y"] = -359.96648870682;
                ["x"] = 523.99860760155;
                ["g"] = 4;
                ["sublevel"] = 1;
            };
            [10] = {
                ["y"] = -329.11506481415;
                ["x"] = 461.36098094389;
                ["g"] = 5;
                ["sublevel"] = 1;
            };
            [11] = {
                ["y"] = -276.91386525457;
                ["x"] = 524.71605006068;
                ["g"] = 6;
                ["sublevel"] = 1;
            };
            [3] = {
                ["y"] = -365.6807803996;
                ["x"] = 519.71288883197;
                ["g"] = 4;
                ["sublevel"] = 1;
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
            [15] = {
                ["y"] = -272.01591095588;
                ["x"] = 518.38952283879;
                ["sublevel"] = 1;
            };
        };
        ["scale"] = 1;
        ["count"] = 0;
        ["name"] = "Silt Crab";
        ["creatureType"] = "Beast";
        ["level"] = 120;
        ["id"] = 127381;
        ["displayId"] = 42978;
        ["health"] = 294320;
    };
    [8] = {
        ["clones"] = {
            [6] = {
                ["y"] = -459.48779564915;
                ["x"] = 338.82048561533;
                ["sublevel"] = 4;
            };
            [2] = {
                ["y"] = -223.16651558537;
                ["x"] = 339.97985221193;
                ["sublevel"] = 3;
            };
            [3] = {
                ["y"] = -306.25231313575;
                ["x"] = 469.30896999818;
                ["g"] = 16;
                ["sublevel"] = 3;
            };
            [1] = {
                ["y"] = -161.21952280377;
                ["x"] = 444.91362080064;
                ["g"] = 11;
                ["sublevel"] = 3;
            };
            [4] = {
                ["y"] = -314.8237342011;
                ["x"] = 475.73756645102;
                ["g"] = 16;
                ["sublevel"] = 3;
            };
            [5] = {
                ["y"] = -411.51882344584;
                ["x"] = 463.16095012299;
                ["sublevel"] = 3;
            };
        };
        ["scale"] = 1.2;
        ["count"] = 0;
        ["name"] = "Blacktooth Arsonist";
        ["creatureType"] = "Humanoid";
        ["level"] = 120;
        ["id"] = 135366;
        ["displayId"] = 84394;
        ["health"] = 323752;
    };
    [9] = {
        ["clones"] = {
            [11] = {
                ["y"] = -264.81075196189;
                ["x"] = 358.95549013445;
                ["sublevel"] = 3;
            };
            [13] = {
                ["y"] = -309.89522410862;
                ["x"] = 279.96680331062;
                ["sublevel"] = 3;
            };
            [7] = {
                ["y"] = -259.67823664231;
                ["x"] = 490.45741287849;
                ["g"] = 13;
                ["sublevel"] = 3;
            };
            [1] = {
                ["y"] = -195.50662589192;
                ["x"] = 390.42427034967;
                ["g"] = 12;
                ["sublevel"] = 3;
            };
            [2] = {
                ["y"] = -180.80077309929;
                ["x"] = 378.95365417789;
                ["g"] = 12;
                ["sublevel"] = 3;
            };
            [15] = {
                ["y"] = -340.10398455655;
                ["x"] = 512.17985588983;
                ["g"] = 17;
                ["sublevel"] = 3;
            };
            [8] = {
                ["y"] = -270.17822762617;
                ["x"] = 497.95742789606;
                ["g"] = 13;
                ["sublevel"] = 3;
            };
            [16] = {
                ["y"] = -388.76501474893;
                ["x"] = 485.10320075226;
                ["sublevel"] = 3;
            };
            [9] = {
                ["y"] = -292.67824049239;
                ["x"] = 517.20740779021;
                ["sublevel"] = 3;
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
            [14] = {
                ["y"] = -334.06950346075;
                ["x"] = 509.24879748026;
                ["g"] = 17;
                ["sublevel"] = 3;
            };
            [3] = {
                ["y"] = -196.38901593574;
                ["x"] = 361.3066358756;
                ["g"] = 12;
                ["sublevel"] = 3;
            };
            [6] = {
                ["y"] = -245.97651529586;
                ["x"] = 455.83812923582;
                ["sublevel"] = 3;
            };
            [12] = {
                ["y"] = -288.63135010439;
                ["x"] = 292.83791167328;
                ["sublevel"] = 3;
            };
            [4] = {
                ["y"] = -202.85959015472;
                ["x"] = 371.60074040374;
                ["g"] = 12;
                ["sublevel"] = 3;
            };
        };
        ["id"] = 130582;
        ["displayId"] = 82828;
        ["neutral"] = true;
        ["count"] = 0;
        ["name"] = "Despondent Scallywag";
        ["creatureType"] = "Humanoid";
        ["level"] = 120;
        ["health"] = 88296;
        ["scale"] = 1;
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
        ["displayId"] = 82983;
        ["isBoss"] = true;
        ["encounterID"] = 2097;
        ["instanceID"] = 1002;
        ["count"] = 0;
        ["health"] = 2060240;
        ["creatureType"] = "Beast";
        ["level"] = 122;
        ["name"] = "The Sand Queen";
        ["scale"] = 1;
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
                ["y"] = -447.64196292174;
                ["x"] = 385.98510560898;
                ["g"] = 18;
                ["sublevel"] = 3;
            };
            [11] = {
                ["y"] = -452.05373643056;
                ["x"] = 377.45568019118;
                ["g"] = 18;
                ["sublevel"] = 3;
            };
        };
        ["scale"] = 1;
        ["name"] = "Bilge Rat Looter";
        ["health"] = 176592;
        ["creatureType"] = "Humanoid";
        ["level"] = 120;
        ["id"] = 127485;
        ["displayId"] = 79322;
        ["count"] = 0;
    };
    [3] = {
        ["clones"] = {
            [7] = {
                ["y"] = -314.49730942398;
                ["x"] = 338.99908497557;
                ["sublevel"] = 2;
            };
            [1] = {
                ["y"] = -269.54240043972;
                ["x"] = 554.33223641337;
                ["g"] = 2;
                ["sublevel"] = 1;
            };
            [2] = {
                ["y"] = -261.79239278937;
                ["x"] = 557.0822519334;
                ["g"] = 2;
                ["sublevel"] = 1;
            };
            [4] = {
                ["y"] = -329.51210718072;
                ["x"] = 513.40430820744;
                ["sublevel"] = 1;
            };
            [8] = {
                ["y"] = -267.80876423075;
                ["x"] = 357.17495357402;
                ["g"] = 8;
                ["sublevel"] = 2;
            };
            [9] = {
                ["y"] = -248.98522166265;
                ["x"] = 357.46904992952;
                ["g"] = 8;
                ["sublevel"] = 2;
            };
            [5] = {
                ["y"] = -365.14670956877;
                ["x"] = 486.76462087793;
                ["g"] = 3;
                ["sublevel"] = 1;
            };
            [10] = {
                ["y"] = -218.66091147994;
                ["x"] = 397.9740854707;
                ["sublevel"] = 2;
            };
            [3] = {
                ["y"] = -319.21199513459;
                ["x"] = 552.26730775915;
                ["sublevel"] = 1;
            };
            [6] = {
                ["y"] = -372.20552698742;
                ["x"] = 482.64699421327;
                ["g"] = 3;
                ["sublevel"] = 1;
            };
            [12] = {
                ["y"] = -474.49730991199;
                ["x"] = 386.99898050725;
                ["sublevel"] = 2;
            };
            [11] = {
                ["y"] = -280.49732836708;
                ["x"] = 418.99912118539;
                ["sublevel"] = 2;
            };
        };
        ["scale"] = 1.2;
        ["count"] = 0;
        ["name"] = "Sewer Vicejaw";
        ["creatureType"] = "Beast";
        ["level"] = 120;
        ["id"] = 127482;
        ["displayId"] = 84333;
        ["health"] = 323752;
    };
    [6] = {
        ["clones"] = {
            [1] = {
                ["y"] = -217.64026135748;
                ["x"] = 480.99935364488;
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
                ["g"] = 15;
                ["sublevel"] = 3;
            };
        };
        ["id"] = 130025;
        ["displayId"] = 81499;
        ["stealthDetect"] = true;
        ["health"] = 441480;
        ["count"] = 0;
        ["creatureType"] = "Humanoid";
        ["level"] = 121;
        ["name"] = "Irontide Thug";
        ["scale"] = 1.4;
    };
    [12] = {
        ["clones"] = {
            [1] = {
                ["y"] = -447.49873407591;
                ["x"] = 280.78690373476;
                ["g"] = 19;
                ["sublevel"] = 3;
            };
            [2] = {
                ["y"] = -436.58963338193;
                ["x"] = 288.05961152145;
                ["g"] = 19;
                ["sublevel"] = 3;
            };
        };
        ["health"] = 264888;
        ["count"] = 0;
        ["id"] = 130026;
        ["displayId"] = 42840;
        ["scale"] = 1.2;
        ["level"] = 120;
        ["creatureType"] = "Humanoid";
        ["name"] = "Bilge Rat Seaspeaker";
    };
    [11] = {
        ["clones"] = {
            [1] = {
                ["y"] = -342.85695519908;
                ["x"] = 303.06214892669;
                ["g"] = 14;
                ["sublevel"] = 3;
            };
            [2] = {
                ["y"] = -336.34531991941;
                ["x"] = 302.13192386986;
                ["g"] = 14;
                ["sublevel"] = 3;
            };
            [4] = {
                ["y"] = -446.34556786155;
                ["x"] = 290.27940164397;
                ["g"] = 19;
                ["sublevel"] = 3;
            };
            [3] = {
                ["y"] = -316.18093011396;
                ["x"] = 467.21370615805;
                ["g"] = 16;
                ["sublevel"] = 3;
            };
        };
        ["scale"] = 1;
        ["name"] = "Cutwater Striker";
        ["health"] = 294320;
        ["creatureType"] = "Humanoid";
        ["level"] = 120;
        ["id"] = 131112;
        ["displayId"] = 78990;
        ["displayId"] = 78990;
        ["count"] = 0;
    };
};







