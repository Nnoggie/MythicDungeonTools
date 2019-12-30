local dungeonIndex = 26
MethodDungeonTools.mapInfo[dungeonIndex] = {
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

MethodDungeonTools.dungeonTotalCount[dungeonIndex] = {normal=160,teeming=192,teemingEnabled=true}
MethodDungeonTools.mapPOIs[dungeonIndex] = {
    [1] = {
        [1] = {
            ["y"] = -343.87594051662;
            ["x"] = 309.70877539996;
            ["connectionIndex"] = 1;
            ["target"] = 3;
            ["type"] = "mapLink";
            ["template"] = "MapLinkPinTemplate";
            ["direction"] = -1;
        };
    };
    [4] = {
        [1] = {
            ["y"] = -318.61727794098;
            ["x"] = 515.84029246469;
            ["index"] = 2;
            ["weeks"] = {
                [1] = true;
            };
            ["tooltipText"] = "Entropic Spire of Ny'alotha";
            ["template"] = "VignettePinTemplate";
            ["type"] = "nyalothaSpire";
            ["npcId"] = 161243;
        };
        [2] = {
            ["y"] = -197.65723365378;
            ["x"] = 582.26737834875;
            ["index"] = 3;
            ["weeks"] = {
                [1] = true;
            };
            ["type"] = "nyalothaSpire";
            ["template"] = "VignettePinTemplate";
            ["tooltipText"] = "Cursed Spire of Ny'alotha";
            ["npcId"] = 161241;
        };
        [3] = {
            ["y"] = -485.10332866813;
            ["x"] = 251.29468785124;
            ["index"] = 4;
            ["weeks"] = {
                [1] = true;
            };
            ["tooltipText"] = "Brutal Spire of Ny'alotha";
            ["template"] = "VignettePinTemplate";
            ["type"] = "nyalothaSpire";
            ["npcId"] = 161124;
        };
        [4] = {
            ["y"] = -434.64189702298;
            ["x"] = 518.05941971039;
            ["connectionIndex"] = 2;
            ["target"] = 3;
            ["type"] = "mapLink";
            ["template"] = "MapLinkPinTemplate";
            ["direction"] = 2;
        };
    };
    [3] = {
        [1] = {
            ["y"] = -383.04415723324;
            ["x"] = 405.94354943625;
            ["index"] = 1;
            ["weeks"] = {
                [1] = true;
            };
            ["type"] = "nyalothaSpire";
            ["template"] = "VignettePinTemplate";
            ["tooltipText"] = "Defiled Spire of Ny'alotha";
            ["npcId"] = 161244;
        };
        [2] = {
            ["y"] = -444.44517818302;
            ["x"] = 466.94234514817;
            ["connectionIndex"] = 1;
            ["target"] = 1;
            ["type"] = "mapLink";
            ["template"] = "MapLinkPinTemplate";
            ["direction"] = 1;
        };
        [3] = {
            ["y"] = -153.56451426492;
            ["x"] = 400.22732136754;
            ["connectionIndex"] = 2;
            ["target"] = 4;
            ["type"] = "mapLink";
            ["template"] = "MapLinkPinTemplate";
            ["direction"] = -2;
        };
    };
};

MethodDungeonTools.dungeonEnemies[dungeonIndex] = {
    [1] = {
        ["clones"] = {
            [1] = {
                ["y"] = -333.22926098296;
                ["x"] = 511.95865277707;
                ["week"] = {
                    [1] = true;
                };
                ["sublevel"] = 4;
            };
        };
        ["corrupted"] = true;
        ["scale"] = 1.4;
        ["spells"] = {
            [314478] = {};
            [314531] = {};
            [314477] = {};
            [314397] = {};
            [314483] = {};
        };
        ["stealthDetect"] = true;
        ["characteristics"] = {
            ["Taunt"] = true;
        };
        ["count"] = 4;
        ["teemingCount"] = 6;
        ["health"] = 1409996;
        ["displayId"] = 90742;
        ["creatureType"] = "Aberration";
        ["level"] = 122;
        ["name"] = "Samh'rek, Beckoner of Chaos";
        ["id"] = 161243;
    };
    [2] = {
        ["clones"] = {
            [1] = {
                ["y"] = -481.039736978;
                ["x"] = 264.39534204253;
                ["week"] = {
                    [1] = true;
                };
                ["sublevel"] = 4;
            };
        };
        ["level"] = 122;
        ["id"] = 161124;
        ["spells"] = {
            [314308] = {};
            [314387] = {};
            [314397] = {};
            [314309] = {};
        };
        ["stealthDetect"] = true;
        ["health"] = 1510710;
        ["count"] = 4;
        ["teemingCount"] = 6;
        ["name"] = "Urg'roth, Breaker of Heroes";
        ["displayId"] = 89415;
        ["creatureType"] = "Aberration";
        ["corrupted"] = true;
        ["scale"] = 1.4;
        ["characteristics"] = {
            ["Taunt"] = true;
        };
    };
    [4] = {
        ["clones"] = {
            [1] = {
                ["y"] = -387.50323117231;
                ["x"] = 416.78179277533;
                ["sublevel"] = 3;
                ["week"] = {
                    [1] = true;
                };
            };
        };
        ["corrupted"] = true;
        ["id"] = 161244;
        ["spells"] = {
            [314566] = {};
            [314397] = {};
            [314565] = {};
            [314592] = {};
        };
        ["stealthDetect"] = true;
        ["count"] = 4;
        ["name"] = "Blood of the Corruptor";
        ["teemingCount"] = 6;
        ["health"] = 1409996;
        ["displayId"] = 92229;
        ["creatureType"] = "Aberration";
        ["level"] = 122;
        ["scale"] = 1.4;
        ["characteristics"] = {
            ["Taunt"] = true;
        };
    };
    [8] = {
        ["clones"] = {
            [2] = {
                ["y"] = -410.11162282143;
                ["x"] = 453.89275969348;
                ["sublevel"] = 4;
            };
            [3] = {
                ["y"] = -203.897120688;
                ["x"] = 596.16623437765;
                ["sublevel"] = 4;
            };
            [1] = {
                ["y"] = -420.58018818504;
                ["x"] = 447.61493194847;
                ["sublevel"] = 4;
            };
            [4] = {
                ["y"] = -446.50406505997;
                ["x"] = 283.88727151756;
                ["sublevel"] = 4;
            };
            [5] = {
                ["y"] = -299.74609894492;
                ["x"] = 307.06091955626;
                ["sublevel"] = 4;
            };
        };
        ["scale"] = 1;
        ["spells"] = {
            [293827] = {};
            [293854] = {};
        };
        ["health"] = 503570;
        ["name"] = "Mechagon Tinkerer";
        ["displayId"] = 91170;
        ["creatureType"] = "Humanoid";
        ["level"] = 120;
        ["count"] = 4;
        ["id"] = 144294;
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
            [3] = {
                ["y"] = -327.43196399115;
                ["x"] = 545.88667894292;
                ["sublevel"] = 3;
            };
        };
        ["id"] = 144293;
        ["spells"] = {
            [294290] = {};
        };
        ["count"] = 6;
        ["health"] = 805712;
        ["displayId"] = 92177;
        ["creatureType"] = "Mechanical";
        ["level"] = 121;
        ["name"] = "Waste Processing Unit";
        ["scale"] = 1;
    };
    [17] = {
        ["clones"] = {
            [13] = {
                ["y"] = -316.10186802244;
                ["x"] = 546.13870688723;
                ["sublevel"] = 3;
            };
            [7] = {
                ["y"] = -361.2827811575;
                ["x"] = 519.38059787532;
                ["sublevel"] = 3;
            };
            [1] = {
                ["y"] = -371.21180058481;
                ["x"] = 484.32164399074;
                ["sublevel"] = 3;
            };
            [2] = {
                ["y"] = -374.427571852;
                ["x"] = 477.58895913962;
                ["sublevel"] = 3;
            };
            [4] = {
                ["y"] = -379.08739882706;
                ["x"] = 489.32447183149;
                ["sublevel"] = 3;
            };
            [8] = {
                ["y"] = -367.95316908005;
                ["x"] = 523.63964787704;
                ["sublevel"] = 3;
            };
            [9] = {
                ["y"] = -310.31526080114;
                ["x"] = 542.36931944179;
                ["sublevel"] = 3;
            };
            [5] = {
                ["y"] = -366.74147341861;
                ["x"] = 532.0088750146;
                ["sublevel"] = 3;
            };
            [10] = {
                ["y"] = -312.33582038524;
                ["x"] = 552.43698965839;
                ["sublevel"] = 3;
            };
            [3] = {
                ["y"] = -379.69940381924;
                ["x"] = 481.99116407687;
                ["sublevel"] = 3;
            };
            [6] = {
                ["y"] = -359.12091941517;
                ["x"] = 531.67741843497;
                ["sublevel"] = 3;
            };
            [12] = {
                ["y"] = -302.80140282703;
                ["x"] = 541.51672032325;
                ["sublevel"] = 3;
            };
            [11] = {
                ["y"] = -302.78294802501;
                ["x"] = 550.57989627437;
                ["sublevel"] = 3;
            };
        };
        ["id"] = 144301;
        ["spells"] = {
            [294349] = {};
        };
        ["count"] = 1;
        ["health"] = 50357;
        ["displayId"] = 92217;
        ["creatureType"] = "Elemental";
        ["level"] = 120;
        ["name"] = "Living Waste";
        ["scale"] = 1;
    };
    [9] = {
        ["clones"] = {
            [1] = {
                ["y"] = -196.75146056589;
                ["x"] = 596.35310107265;
                ["sublevel"] = 4;
            };
            [2] = {
                ["y"] = -450.49903723392;
                ["x"] = 275.4461942786;
                ["sublevel"] = 4;
            };
            [4] = {
                ["y"] = -305.46689987613;
                ["x"] = 300.7164362048;
                ["sublevel"] = 4;
            };
            [3] = {
                ["y"] = -455.61225024665;
                ["x"] = 287.37702464163;
                ["sublevel"] = 4;
            };
        };
        ["scale"] = 1;
        ["spells"] = {
            [293670] = {};
        };
        ["health"] = 503570;
        ["name"] = "Workshop Defender";
        ["displayId"] = 91183;
        ["creatureType"] = "Humanoid";
        ["level"] = 120;
        ["count"] = 4;
        ["id"] = 144299;
    };
    [18] = {
        ["clones"] = {
            [1] = {
                ["y"] = -383.11225682513;
                ["x"] = 151.30590992095;
                ["sublevel"] = 4;
            };
        };
        ["id"] = 144249;
        ["spells"] = {
            [292264] = {};
            [292290] = {};
            [283551] = {};
            [292267] = {};
        };
        ["isBoss"] = true;
        ["encounterID"] = 2331;
        ["instanceID"] = 1178;
        ["count"] = 0;
        ["health"] = 3021420;
        ["displayId"] = 90998;
        ["creatureType"] = "Mechanical";
        ["level"] = 122;
        ["name"] = "Omega Buster";
        ["scale"] = 1;
    };
    [5] = {
        ["clones"] = {
            [1] = {
                ["y"] = -407.98650449707;
                ["x"] = 435.26786804264;
                ["sublevel"] = 4;
            };
        };
        ["scale"] = 1.4;
        ["spells"] = {
            [296348] = {};
            [295169] = {};
            [295183] = {};
            [295170] = {};
            [294015] = {};
            [293986] = {};
        };
        ["name"] = "Blastatron X-80";
        ["count"] = 8;
        ["displayId"] = 90712;
        ["creatureType"] = "Mechanical";
        ["level"] = 121;
        ["id"] = 151476;
        ["health"] = 1258925;
    };
    [10] = {
        ["clones"] = {
            [1] = {
                ["y"] = -190.10916220199;
                ["x"] = 601.18387765416;
                ["sublevel"] = 4;
            };
            [2] = {
                ["y"] = -295.46130024962;
                ["x"] = 291.76409208577;
                ["sublevel"] = 4;
            };
            [3] = {
                ["y"] = -305.11581470697;
                ["x"] = 293.16840262958;
                ["sublevel"] = 4;
            };
        };
        ["scale"] = 1;
        ["spells"] = {
            [293930] = {};
            [293729] = {};
        };
        ["health"] = 503570;
        ["name"] = "Mechagon Mechanic";
        ["displayId"] = 91171;
        ["creatureType"] = "Humanoid";
        ["level"] = 120;
        ["count"] = 4;
        ["id"] = 144295;
    };
    [20] = {
        ["clones"] = {
            [1] = {
                ["y"] = -367.61262040707;
                ["x"] = 230.69550162853;
                ["sublevel"] = 1;
            };
            [2] = {
                ["y"] = -389.70524704043;
                ["x"] = 239.63705516806;
                ["sublevel"] = 1;
            };
        };
        ["id"] = 151659;
        ["spells"] = {
            [294103] = {};
            [294128] = {};
        };
        ["count"] = 4;
        ["health"] = 503570;
        ["displayId"] = 91228;
        ["creatureType"] = "Mechanical";
        ["level"] = 120;
        ["name"] = "Rocket Tonk";
        ["scale"] = 1.5;
    };
    [21] = {
        ["clones"] = {
            [1] = {
                ["y"] = -345.90929412611;
                ["x"] = 237.23806882906;
                ["sublevel"] = 1;
            };
            [2] = {
                ["y"] = -396.32696201739;
                ["x"] = 261.35754205452;
                ["sublevel"] = 1;
            };
        };
        ["id"] = 151658;
        ["spells"] = {
            [294061] = {};
            [294073] = {};
            [294064] = {};
        };
        ["count"] = 4;
        ["health"] = 503570;
        ["displayId"] = 91229;
        ["creatureType"] = "Mechanical";
        ["level"] = 120;
        ["name"] = "Strider Tonk";
        ["scale"] = 1.5;
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
        ["count"] = 0;
        ["health"] = 3524990;
        ["displayId"] = 23397;
        ["creatureType"] = "Mechanical";
        ["level"] = 122;
        ["name"] = "Head Machinist Sparkflux";
        ["scale"] = 1;
    };
    [22] = {
        ["clones"] = {
            [1] = {
                ["y"] = -417.41680355738;
                ["x"] = 213.62890398115;
                ["sublevel"] = 1;
            };
        };
        ["id"] = 144244;
        ["spells"] = {
            [285344] = {};
            [305393] = {};
            [285020] = {};
            [285377] = {};
            [282801] = {};
        };
        ["isBoss"] = true;
        ["encounterID"] = 2336;
        ["instanceID"] = 1178;
        ["count"] = 0;
        ["health"] = 2014280;
        ["displayId"] = 91216;
        ["creatureType"] = "Mechanical";
        ["level"] = 122;
        ["name"] = "The Platinum Pummeler";
        ["scale"] = 1.5;
    };
    [3] = {
        ["clones"] = {
            [1] = {
                ["y"] = -184.37266990175;
                ["x"] = 590.01275028241;
                ["sublevel"] = 4;
                ["week"] = {
                    [1] = true;
                };
            };
        };
        ["level"] = 122;
        ["scale"] = 1.4;
        ["spells"] = {
            [314463] = {};
            [314411] = {};
            [314467] = {};
            [314406] = {};
            [314397] = {};
        };
        ["stealthDetect"] = true;
        ["characteristics"] = {
            ["Taunt"] = true;
        };
        ["id"] = 161241;
        ["teemingCount"] = 6;
        ["count"] = 4;
        ["displayId"] = 91910;
        ["creatureType"] = "Beast";
        ["corrupted"] = true;
        ["name"] = "Voidweaver Mal'thir";
        ["health"] = 1309282;
    };
    [6] = {
        ["clones"] = {
            [1] = {
                ["y"] = -421.66419640937;
                ["x"] = 499.70337825139;
                ["sublevel"] = 4;
            };
            [2] = {
                ["y"] = -430.63364694467;
                ["x"] = 496.86060747485;
                ["sublevel"] = 4;
            };
            [4] = {
                ["y"] = -435.51047744238;
                ["x"] = 484.6561799684;
                ["sublevel"] = 4;
            };
            [8] = {
                ["y"] = -427.34976261929;
                ["x"] = 490.17023050112;
                ["sublevel"] = 4;
            };
            [16] = {
                ["y"] = -350.51236104974;
                ["x"] = 508.90528020342;
                ["sublevel"] = 4;
            };
            [17] = {
                ["y"] = -356.92822420273;
                ["x"] = 514.00022987796;
                ["sublevel"] = 4;
            };
            [9] = {
                ["y"] = -440.55886808142;
                ["x"] = 478.16193916255;
                ["sublevel"] = 4;
            };
            [5] = {
                ["y"] = -443.69571816028;
                ["x"] = 487.30300371032;
                ["sublevel"] = 4;
            };
            [10] = {
                ["y"] = -420.92899835806;
                ["x"] = 487.54800405373;
                ["sublevel"] = 4;
            };
            [11] = {
                ["y"] = -413.68897609184;
                ["x"] = 486.03961528088;
                ["sublevel"] = 4;
            };
            [3] = {
                ["y"] = -436.90737631667;
                ["x"] = 492.84152392959;
                ["sublevel"] = 4;
            };
            [6] = {
                ["y"] = -428.52550114086;
                ["x"] = 484.67447267549;
                ["sublevel"] = 4;
            };
            [12] = {
                ["y"] = -432.47763924175;
                ["x"] = 477.97117706412;
                ["sublevel"] = 4;
            };
            [13] = {
                ["y"] = -345.60610751627;
                ["x"] = 500.60243944338;
                ["sublevel"] = 4;
            };
            [7] = {
                ["y"] = -419.85584273725;
                ["x"] = 493.51113606412;
                ["sublevel"] = 4;
            };
            [14] = {
                ["y"] = -344.09650599496;
                ["x"] = 510.79229020326;
                ["sublevel"] = 4;
            };
            [15] = {
                ["y"] = -352.96549186558;
                ["x"] = 499.84760628993;
                ["sublevel"] = 4;
            };
        };
        ["id"] = 144300;
        ["count"] = 0;
        ["health"] = 125893;
        ["displayId"] = 91167;
        ["creatureType"] = "Mechanical";
        ["level"] = 120;
        ["name"] = "Mechagon Citizen";
        ["scale"] = 0.7;
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
        };
        ["id"] = 144296;
        ["spells"] = {
            [293986] = {};
            [296348] = {};
            [294015] = {};
        };
        ["count"] = 5;
        ["health"] = 805712;
        ["displayId"] = 90710;
        ["creatureType"] = "Mechanical";
        ["level"] = 121;
        ["name"] = "Spider Tank";
        ["scale"] = 1;
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
            [291949] = {};
            [291972] = {};
            [291946] = {};
            [291922] = {};
            [292035] = {};
        };
        ["isBoss"] = true;
        ["encounterID"] = 2339;
        ["instanceID"] = 1178;
        ["count"] = 0;
        ["health"] = 3524990;
        ["displayId"] = 90775;
        ["creatureType"] = "Mechanical";
        ["level"] = 122;
        ["name"] = "K.U.-J.0.";
        ["scale"] = 1;
    };
    [25] = {
        ["clones"] = {
            [1] = {
                ["y"] = -421.83846267556;
                ["x"] = 477.5225723606;
                ["sublevel"] = 4;
            };
        };
        ["scale"] = 1;
        ["name"] = "Alarm-o-Bot";
        ["count"] = 0;
        ["displayId"] = 90874;
        ["creatureType"] = "Mechanical";
        ["level"] = 120;
        ["health"] = 25179;
        ["id"] = 151325;
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
                ["y"] = -439.07137023363;
                ["x"] = 427.88892708;
                ["sublevel"] = 4;
            };
            [4] = {
                ["y"] = -291.74184239816;
                ["x"] = 281.84583501642;
                ["sublevel"] = 4;
            };
            [5] = {
                ["y"] = -288.03820044584;
                ["x"] = 302.07848946789;
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
        ["name"] = "Defense Bot Mk III";
        ["count"] = 6;
        ["displayId"] = 90855;
        ["creatureType"] = "Mechanical";
        ["level"] = 121;
        ["health"] = 805712;
        ["id"] = 144298;
    };
    [26] = {
        ["clones"] = {
            [1] = {
                ["y"] = -411.30541145154;
                ["x"] = 468.87464315214;
                ["sublevel"] = 4;
            };
            [2] = {
                ["y"] = -430.71189444421;
                ["x"] = 459.00360004137;
                ["sublevel"] = 4;
            };
        };
        ["id"] = 144303;
        ["spells"] = {
            [294107] = {};
        };
        ["count"] = 4;
        ["health"] = 503570;
        ["displayId"] = 68856;
        ["creatureType"] = "Mechanical";
        ["level"] = 120;
        ["name"] = "G.U.A.R.D.";
        ["scale"] = 1;
    };
    [7] = {
        ["clones"] = {
            [1] = {
                ["y"] = -443.40648686792;
                ["x"] = 438.44742717883;
                ["sublevel"] = 4;
            };
            [2] = {
                ["y"] = -428.89835657538;
                ["x"] = 434.33180732801;
                ["sublevel"] = 4;
            };
            [4] = {
                ["y"] = -193.33828230687;
                ["x"] = 611.47784039704;
                ["sublevel"] = 4;
            };
            [3] = {
                ["y"] = -209.62623239455;
                ["x"] = 604.72424938609;
                ["sublevel"] = 4;
            };
        };
        ["scale"] = 1;
        ["spells"] = {
            [294195] = {};
        };
        ["health"] = 528749;
        ["name"] = "Defense Bot Mk I";
        ["displayId"] = 91349;
        ["creatureType"] = "Mechanical";
        ["level"] = 120;
        ["count"] = 4;
        ["id"] = 151649;
    };
    [14] = {
        ["clones"] = {
            [1] = {
                ["y"] = -362.16512816792;
                ["x"] = 179.1418279613;
                ["sublevel"] = 4;
            };
        };
        ["id"] = 150396;
        ["spells"] = {
            [291928] = {};
            [291878] = {};
            [291626] = {};
            [291865] = {};
            [291613] = {};
        };
        ["isBoss"] = true;
        ["encounterID"] = 2331;
        ["instanceID"] = 1178;
        ["count"] = 0;
        ["health"] = 2417136;
        ["displayId"] = 90547;
        ["creatureType"] = "Mechanical";
        ["level"] = 122;
        ["name"] = "Aerial Unit R-21/X";
        ["scale"] = 1;
    };
    [15] = {
        ["clones"] = {
            [1] = {
                ["y"] = -353.06278997051;
                ["x"] = 522.29246790592;
                ["sublevel"] = 3;
            };
            [2] = {
                ["y"] = -283.96607903702;
                ["x"] = 532.79700898612;
                ["sublevel"] = 3;
            };
        };
        ["id"] = 151773;
        ["spells"] = {
            [294107] = {};
            [294180] = {};
        };
        ["count"] = 4;
        ["health"] = 503570;
        ["displayId"] = 90511;
        ["creatureType"] = "Mechanical";
        ["level"] = 120;
        ["name"] = "Junkyard D.0.G.";
        ["scale"] = 1;
    };
    [19] = {
        ["clones"] = {
            [1] = {
                ["y"] = -374.2151489309;
                ["x"] = 269.53200910371;
                ["sublevel"] = 1;
            };
            [2] = {
                ["y"] = -354.32391026756;
                ["x"] = 259.27553305712;
                ["sublevel"] = 1;
            };
        };
        ["id"] = 151657;
        ["spells"] = {
            [301088] = {};
        };
        ["count"] = 4;
        ["health"] = 302142;
        ["displayId"] = 21209;
        ["creatureType"] = "Mechanical";
        ["level"] = 120;
        ["name"] = "Bomb Tonk";
        ["scale"] = 1.5;
    };
    [23] = {
        ["clones"] = {
            [1] = {
                ["y"] = -368.75253591347;
                ["x"] = 195.09111527009;
                ["sublevel"] = 1;
            };
        };
        ["id"] = 145185;
        ["spells"] = {
            [283421] = {};
            [283640] = {};
            [283565] = {};
            [285388] = {};
            [283422] = {};
            [285468] = {};
            [285152] = {};
        };
        ["isBoss"] = true;
        ["encounterID"] = 2336;
        ["instanceID"] = 1178;
        ["count"] = 0;
        ["health"] = 2014280;
        ["displayId"] = 91879;
        ["creatureType"] = "Mechanical";
        ["level"] = 122;
        ["name"] = "Gnomercy 4.U.";
        ["scale"] = 1.5;
    };
};
