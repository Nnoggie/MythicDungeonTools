local MDT = MDT
local L = MDT.L
local dungeonIndex = 36
MDT.mapInfo[dungeonIndex] = {

};

MDT.dungeonTotalCount[dungeonIndex] = {normal=271,teeming=1000,teemingEnabled=true}
MDT.mapPOIs[dungeonIndex] = {
    [1] = {
        [1] = {
            ["y"] = -256.51958712891;
            ["x"] = 425.94966734303;
            ["connectionIndex"] = 1;
            ["target"] = 2;
            ["type"] = "mapLink";
            ["template"] = "MapLinkPinTemplate";
            ["direction"] = -1;
        };
    };
    [2] = {
        [1] = {
            ["y"] = -190.01484617386;
            ["x"] = 271.56378333015;
            ["connectionIndex"] = 1;
            ["target"] = 1;
            ["type"] = "mapLink";
            ["template"] = "MapLinkPinTemplate";
            ["direction"] = 1;
        };
        [2] = {
            ["y"] = -98.174992961846;
            ["x"] = 270.7719140048;
            ["connectionIndex"] = 2;
            ["target"] = 3;
            ["type"] = "mapLink";
            ["template"] = "MapLinkPinTemplate";
            ["direction"] = 1;
        };
        [3] = {
            ["y"] = -160.7212020877;
            ["x"] = 179.72326263409;
            ["connectionIndex"] = 3;
            ["target"] = 4;
            ["type"] = "mapLink";
            ["template"] = "MapLinkPinTemplate";
            ["direction"] = -2;
        };
    };
    [3] = {
        [1] = {
            ["y"] = -513.03781749957;
            ["x"] = 601.71178789426;
            ["connectionIndex"] = 2;
            ["target"] = 2;
            ["type"] = "mapLink";
            ["template"] = "MapLinkPinTemplate";
            ["direction"] = -1;
        };
    };
    [4] = {
        [1] = {
            ["y"] = -388.73733430644;
            ["x"] = 689.5927878488;
            ["connectionIndex"] = 3;
            ["target"] = 2;
            ["type"] = "mapLink";
            ["template"] = "MapLinkPinTemplate";
            ["direction"] = 2;
        };
        [2] = {
            ["y"] = -365.77737100344;
            ["x"] = 155.17979851978;
            ["connectionIndex"] = 4;
            ["target"] = 5;
            ["type"] = "mapLink";
            ["template"] = "MapLinkPinTemplate";
            ["direction"] = 1;
        };
        [3] = {
            ["y"] = -140.92807052201;
            ["x"] = 213.76718798327;
            ["connectionIndex"] = 5;
            ["target"] = 5;
            ["type"] = "mapLink";
            ["template"] = "MapLinkPinTemplate";
            ["direction"] = -1;
        };
    };
    [5] = {
        [1] = {
            ["y"] = -123.51013920768;
            ["x"] = 212.18385705726;
            ["connectionIndex"] = 5;
            ["target"] = 4;
            ["type"] = "mapLink";
            ["template"] = "MapLinkPinTemplate";
            ["direction"] = 1;
        };
        [2] = {
            ["y"] = -330.14987688884;
            ["x"] = 144.09573454242;
            ["connectionIndex"] = 4;
            ["target"] = 4;
            ["type"] = "mapLink";
            ["template"] = "MapLinkPinTemplate";
            ["direction"] = -1;
        };
        [3] = {
            ["y"] = -472.65995527842;
            ["x"] = 543.91574181367;
            ["connectionIndex"] = 6;
            ["target"] = 4;
            ["type"] = "mapLink";
            ["template"] = "MapLinkPinTemplate";
            ["direction"] = 1;
        };
    };
};
MDT.dungeonEnemies[dungeonIndex] = {
    [1] = {
        ["clones"] = {
            [1] = {
                ["x"] = 425.7099409895599;
                ["y"] = -353.2822978723403;
                ["sublevel"] = 1;
            };
        };
        ["name"] = L["Battlefield Ritualist"];
        ["id"] = 174197;
        ["health"] = 72090;
        ["level"] = 60;
        ["count"] = 4;
        ["displayId"] = 98696;
        ["creatureType"] = L["Humanoid"];
        ["scale"] = 1;
    };
    [2] = {
        ["clones"] = {
            [1] = {
                ["x"] = 432.4207898320474;
                ["y"] = -358.8464680851065;
                ["sublevel"] = 1;
            };
            [2] = {
                ["x"] = 419.65683159328177;
                ["y"] = -358.06238297872363;
                ["sublevel"] = 1;
                ["inspiring"] = true;
            };
        };
        ["name"] = L["Unyielding Contender"];
        ["id"] = 170838;
        ["health"] = 92115;
        ["level"] = 60;
        ["count"] = 4;
        ["displayId"] = 95570;
        ["creatureType"] = L["Humanoid"];
        ["scale"] = 1;
    };
    [3] = {
        ["clones"] = {
            [1] = {
                ["x"] = 426.01497957330906;
                ["y"] = -344.6384680851066;
                ["sublevel"] = 1;
            };
        };
        ["name"] = L["Raging Bloodhorn"];
        ["id"] = 170850;
        ["health"] = 144180;
        ["level"] = 60;
        ["count"] = 7;
        ["displayId"] = 96471;
        ["creatureType"] = L["Beast"];
        ["scale"] = 1;
    };
    [4] = {
        ["clones"] = {
            [1] = {
                ["x"] = 425.0331366318659;
                ["y"] = -285.652595744681;
                ["sublevel"] = 1;
            };
        };
        ["name"] = L["Dessia the Decapitator"];
        ["id"] = 164451;
        ["health"] = 288360;
        ["level"] = 60;
        ["count"] = 0;
        ["displayId"] = 96820;
        ["creatureType"] = L["Humanoid"];
        ["scale"] = 1;
    };
    [5] = {
        ["clones"] = {
            [1] = {
                ["x"] = 422.9741261915568;
                ["y"] = -296.2141276595744;
                ["sublevel"] = 1;
            };
        };
        ["name"] = L["Paceran the Virulent"];
        ["id"] = 164463;
        ["health"] = 256320;
        ["level"] = 60;
        ["count"] = 0;
        ["displayId"] = 98081;
        ["creatureType"] = L["Humanoid"];
        ["scale"] = 1;
    };
    [6] = {
        ["clones"] = {
            [1] = {
                ["x"] = 428.4457557875626;
                ["y"] = -295.9212765957447;
                ["sublevel"] = 1;
            };
        };
        ["name"] = L["Sathel the Accursed"];
        ["id"] = 164461;
        ["health"] = 224280;
        ["level"] = 60;
        ["count"] = 0;
        ["displayId"] = 98082;
        ["creatureType"] = L["Humanoid"];
        ["scale"] = 1;
    };
    [7] = {
        ["clones"] = {
            [1] = {
                ["x"] = 441.08579210167943;
                ["y"] = -288.40161702127654;
                ["sublevel"] = 1;
            };
        };
        ["name"] = L["Xira the Underhanded"];
        ["id"] = 164464;
        ["health"] = 96120;
        ["level"] = 60;
        ["count"] = 0;
        ["displayId"] = 96440;
        ["creatureType"] = L["Humanoid"];
        ["scale"] = 1;
    };
    [8] = {
        ["clones"] = {
            [1] = {
                ["x"] = 358.0541176470586;
                ["y"] = -310.4735294117644;
                ["sublevel"] = 2;
            };
            [2] = {
                ["x"] = 549.2447058823526;
                ["y"] = -346.6954411764704;
                ["sublevel"] = 2;
            };
            [3] = {
                ["x"] = 542.6235294117645;
                ["y"] = -351.54352941176495;
                ["sublevel"] = 2;
            };
        };
        ["name"] = L["Shambling Arbalest"];
        ["id"] = 164510;
        ["health"] = 68085;
        ["level"] = 60;
        ["count"] = 4;
        ["displayId"] = 96212;
        ["creatureType"] = L["Undead"];
        ["scale"] = 1;
    };
    [9] = {
        ["clones"] = {
            [1] = {
                ["x"] = 347.0517647058824;
                ["y"] = -292.7951470588234;
                ["sublevel"] = 2;
            };
            [2] = {
                ["x"] = 342.785882352941;
                ["y"] = -296.6475;
                ["sublevel"] = 2;
                ["inspiring"] = true;
            };
            [3] = {
                ["x"] = 547.0376470588237;
                ["y"] = -336.9176470588237;
                ["sublevel"] = 2;
            };
            [4] = {
                ["x"] = 533.663529411765;
                ["y"] = -346.4342647058824;
                ["sublevel"] = 2;
            };
        };
        ["name"] = L["Ossified Conscript"];
        ["id"] = 167994;
        ["health"] = 80100;
        ["level"] = 60;
        ["count"] = 4;
        ["displayId"] = 96253;
        ["creatureType"] = L["Undead"];
        ["scale"] = 1;
    };
    [10] = {
        ["clones"] = {
            [1] = {
                ["x"] = 391.07764705882363;
                ["y"] = -351.4619117647058;
                ["sublevel"] = 2;
            };
        };
        ["name"] = L["Dokigg the Brutalizer"];
        ["id"] = 167538;
        ["health"] = 256320;
        ["level"] = 60;
        ["count"] = 20;
        ["displayId"] = 97488;
        ["creatureType"] = L["Humanoid"];
        ["scale"] = 1;
    };
    [11] = {
        ["clones"] = {
            [1] = {
                ["x"] = 493.5741176470589;
                ["y"] = -268.7505882352939;
                ["sublevel"] = 2;
            };
        };
        ["name"] = L["Harugia the Bloodthirsty"];
        ["id"] = 167536;
        ["health"] = 256320;
        ["level"] = 60;
        ["count"] = 20;
        ["displayId"] = 95969;
        ["creatureType"] = L["Humanoid"];
        ["scale"] = 1;
    };
    [12] = {
        ["clones"] = {
            [1] = {
                ["x"] = 540.1858823529408;
                ["y"] = -341.2597058823529;
                ["sublevel"] = 2;
                ["inspiring"] = true;
            };
        };
        ["name"] = L["Ancient Captain"];
        ["id"] = 164506;
        ["health"] = 96120;
        ["level"] = 60;
        ["count"] = 5;
        ["displayId"] = 96489;
        ["creatureType"] = L["Undead"];
        ["scale"] = 1;
    };
    [13] = {
        ["clones"] = {
            [1] = {
                ["x"] = 593.8470588235298;
                ["y"] = -414.25852941176504;
                ["sublevel"] = 2;
            };
        };
        ["name"] = L["Advent Nevermore"];
        ["id"] = 167533;
        ["health"] = 256320;
        ["level"] = 60;
        ["count"] = 20;
        ["displayId"] = 95966;
        ["creatureType"] = L["Humanoid"];
        ["scale"] = 1;
    };
    [14] = {
        ["clones"] = {
            [1] = {
                ["x"] = 437.8376470588234;
                ["y"] = -425.14632352941146;
                ["sublevel"] = 2;
            };
        };
        ["isBoss"] = true;
        ["encounterID"] = 2390;
        ["instanceID"] = 1187;
        ["name"] = L["Xav the Unfallen"];
        ["id"] = 162329;
        ["health"] = 560700;
        ["level"] = 60;
        ["count"] = 0;
        ["displayId"] = 95439;
        ["creatureType"] = L["Humanoid"];
        ["scale"] = 1;
    };
    [15] = {
        ["clones"] = {
            [1] = {
                ["x"] = 430.9694117647056;
                ["y"] = -442.43294117647054;
                ["sublevel"] = 2;
            };
            [2] = {
                ["x"] = 451.50823529411787;
                ["y"] = -426.28897058823543;
                ["sublevel"] = 2;
            };
        };
        ["name"] = L["Oppressive Banner"];
        ["id"] = 170234;
        ["health"] = 40050;
        ["level"] = 60;
        ["count"] = 0;
        ["displayId"] = 97254;
        ["creatureType"] = L["Totem"];
        ["scale"] = 1;
    };
    [16] = {
        ["clones"] = {
            [1] = {
                ["x"] = 607.1529267545203;
                ["y"] = -442.9920689655173;
                ["sublevel"] = 3;
            };
            [2] = {
                ["x"] = 590.7545203800181;
                ["y"] = -444.33172413793136;
                ["sublevel"] = 3;
            };
            [3] = {
                ["x"] = 593.6120134845235;
                ["y"] = -438.69241379310364;
                ["sublevel"] = 3;
            };
            [4] = {
                ["x"] = 578.771069567882;
                ["y"] = -447.82758620689657;
                ["sublevel"] = 3;
                ["inspiring"] = true;
            };
            [5] = {
                ["x"] = 554.9328838492183;
                ["y"] = -441.6779310344825;
                ["sublevel"] = 3;
            };
            [6] = {
                ["x"] = 541.4434569414647;
                ["y"] = -437.91413793103453;
                ["sublevel"] = 3;
            };
            [7] = {
                ["x"] = 555.5893349678212;
                ["y"] = -430.4503448275864;
                ["sublevel"] = 3;
            };
            [8] = {
                ["x"] = 543.3870671161509;
                ["y"] = -410.35551724137946;
                ["sublevel"] = 3;
            };
            [9] = {
                ["x"] = 536.5651241189088;
                ["y"] = -414.6168965517239;
                ["sublevel"] = 3;
            };
            [10] = {
                ["x"] = 530.3095311063436;
                ["y"] = -380.53862068965543;
                ["sublevel"] = 3;
            };
            [11] = {
                ["x"] = 536.2175911737663;
                ["y"] = -373.1386206896552;
                ["sublevel"] = 3;
                ["inspiring"] = true;
            };
            [12] = {
                ["x"] = 547.3000306466442;
                ["y"] = -379.61999999999995;
                ["sublevel"] = 3;
            };
            [13] = {
                ["x"] = 226.0380018387987;
                ["y"] = -274.78241379310333;
                ["sublevel"] = 3;
            };
            [14] = {
                ["x"] = 218.86852589641418;
                ["y"] = -283.12655172413776;
                ["sublevel"] = 3;
            };
            [15] = {
                ["x"] = 232.7312289304325;
                ["y"] = -283.4965517241377;
                ["sublevel"] = 3;
            };
            [16] = {
                ["x"] = 358.5510266625808;
                ["y"] = -169.4727586206896;
                ["sublevel"] = 3;
            };
            [17] = {
                ["x"] = 372.336500153233;
                ["y"] = -168.27344827586194;
                ["sublevel"] = 3;
            };
            [18] = {
                ["x"] = 364.7036469506589;
                ["y"] = -160.36310344827592;
                ["sublevel"] = 3;
            };
            [19] = {
                ["x"] = 362.25804474410035;
                ["y"] = -85.89103448275881;
                ["sublevel"] = 3;
            };
            [20] = {
                ["x"] = 348.65277352129965;
                ["y"] = -88.4172413793106;
                ["sublevel"] = 3;
            };
            [21] = {
                ["x"] = 357.0193073858415;
                ["y"] = -95.54931034482743;
                ["sublevel"] = 3;
            };
            [22] = {
                ["x"] = 356.91633466135437;
                ["y"] = -308.52896551724155;
                ["sublevel"] = 3;
            };
            [23] = {
                ["x"] = 353.2994177137602;
                ["y"] = -307.8910344827588;
                ["sublevel"] = 3;
            };
            [24] = {
                ["x"] = 357.65001532332207;
                ["y"] = -298.6920689655174;
                ["sublevel"] = 3;
            };
        };
        ["name"] = L["Shackled Soul"];
        ["id"] = 169875;
        ["health"] = 48060;
        ["level"] = 60;
        ["count"] = 2;
        ["displayId"] = 90428;
        ["creatureType"] = L["Undead"];
        ["scale"] = 1;
    };
    [17] = {
        ["clones"] = {
            [1] = {
                ["x"] = 438.86975176218186;
                ["y"] = -372.11793103448264;
                ["sublevel"] = 3;
            };
            [2] = {
                ["x"] = 227.4152620288081;
                ["y"] = -242.209655172414;
                ["sublevel"] = 3;
            };
        };
        ["name"] = L["Portal Guardian"];
        ["id"] = 167998;
        ["health"] = 120150;
        ["level"] = 60;
        ["count"] = 8;
        ["displayId"] = 96442;
        ["creatureType"] = L["Elemental"];
        ["scale"] = 1;
    };
    [18] = {
        ["clones"] = {
            [1] = {
                ["x"] = 423.20502604964724;
                ["y"] = -247.96379310344818;
                ["sublevel"] = 3;
            };
            [2] = {
                ["x"] = 418.7128409439166;
                ["y"] = -252.65896551724163;
                ["sublevel"] = 3;
            };
            [3] = {
                ["x"] = 222.35672693840013;
                ["y"] = -239.78551724137938;
                ["sublevel"] = 3;
                ["inspiring"] = true;
            };
            [4] = {
                ["x"] = 220.4774747165184;
                ["y"] = -205.97517241379316;
                ["sublevel"] = 3;
            };
            [5] = {
                ["x"] = 227.82715292675442;
                ["y"] = -213.3368965517242;
                ["sublevel"] = 3;
            };
            [6] = {
                ["x"] = 509.13576463377257;
                ["y"] = -189.97586206896565;
                ["sublevel"] = 3;
            };
            [7] = {
                ["x"] = 512.019000919399;
                ["y"] = -173.83620689655172;
                ["sublevel"] = 3;
            };
            [8] = {
                ["x"] = 523.7064051486365;
                ["y"] = -156.88000000000002;
                ["sublevel"] = 3;
            };
            [9] = {
                ["x"] = 516.8973337419554;
                ["y"] = -166.8189655172414;
                ["sublevel"] = 3;
            };
            [10] = {
                ["x"] = 516.742874655225;
                ["y"] = -210.04517241379327;
                ["sublevel"] = 3;
            };
            [11] = {
                ["x"] = 515.1210542445602;
                ["y"] = -205.27344827586194;
                ["sublevel"] = 3;
            };
            [12] = {
                ["x"] = 684.8844621513942;
                ["y"] = -187.25827586206896;
                ["sublevel"] = 3;
            };
        };
        ["name"] = L["Bone Magus"];
        ["id"] = 170882;
        ["health"] = 40050;
        ["level"] = 60;
        ["count"] = 4;
        ["displayId"] = 97410;
        ["creatureType"] = L["Undead"];
        ["scale"] = 1;
    };
    [19] = {
        ["clones"] = {
            [1] = {
                ["x"] = 221.5200735519464;
                ["y"] = -248.69103448275868;
                ["sublevel"] = 3;
            };
            [2] = {
                ["x"] = 225.8577995709472;
                ["y"] = -282.83310344827566;
                ["sublevel"] = 3;
            };
            [3] = {
                ["x"] = 676.1060373889055;
                ["y"] = -187.29655172413814;
                ["sublevel"] = 3;
            };
            [4] = {
                ["x"] = 365.1798958014096;
                ["y"] = -167.52068965517262;
                ["sublevel"] = 3;
            };
            [5] = {
                ["x"] = 355.4361017468589;
                ["y"] = -87.46034482758643;
                ["sublevel"] = 3;
                ["inspiring"] = true;
            };
            [6] = {
                ["x"] = 354.8697517621822;
                ["y"] = -305.8241379310342;
                ["sublevel"] = 3;
            };
        };
        ["name"] = L["Maniacal Soulbinder"];
        ["id"] = 160495;
        ["health"] = 72090;
        ["level"] = 60;
        ["count"] = 4;
        ["displayId"] = 95233;
        ["creatureType"] = L["Humanoid"];
        ["scale"] = 1;
    };
    [20] = {
        ["clones"] = {
            [1] = {
                ["x"] = 516.2537542139138;
                ["y"] = -180.92999999999992;
                ["sublevel"] = 3;
            };
        };
        ["name"] = L["Soulforged Bonereaver"];
        ["id"] = 162763;
        ["health"] = 160200;
        ["level"] = 60;
        ["count"] = 8;
        ["displayId"] = 94812;
        ["creatureType"] = L["Undead"];
        ["scale"] = 1;
    };
    [21] = {
        ["clones"] = {
            [1] = {
                ["x"] = 687.3043211768311;
                ["y"] = -183.80068965517236;
                ["sublevel"] = 3;
            };
            [2] = {
                ["x"] = 354.36775973030984;
                ["y"] = -135.50931034482764;
                ["sublevel"] = 3;
            };
            [3] = {
                ["x"] = 365.5403003371132;
                ["y"] = -121.34724137931047;
                ["sublevel"] = 3;
            };
        };
        ["name"] = L["Nefarious Darkspeaker"];
        ["id"] = 169893;
        ["health"] = 112140;
        ["level"] = 60;
        ["count"] = 6;
        ["displayId"] = 97011;
        ["creatureType"] = L["Undead"];
        ["scale"] = 1;
    };
    [22] = {
        ["clones"] = {
            [1] = {
                ["x"] = 598.2715292675451;
                ["y"] = -382.7968965517244;
                ["sublevel"] = 3;
            };
        };
        ["isBoss"] = true;
        ["encounterID"] = 2389;
        ["instanceID"] = 1187;
        ["name"] = L["Kul'tharok"];
        ["id"] = 162309;
        ["health"] = 672840;
        ["level"] = 60;
        ["count"] = 0;
        ["displayId"] = 96088;
        ["creatureType"] = L["Undead"];
        ["scale"] = 1;
    };
    [23] = {
        ["clones"] = {
            [1] = {
                ["x"] = 592.2413114754098;
                ["y"] = -334.71987211018205;
                ["sublevel"] = 4;
            };
            [2] = {
                ["x"] = 527.8504918032784;
                ["y"] = -344.24741760944363;
                ["sublevel"] = 4;
            };
            [3] = {
                ["x"] = 399.1790163934428;
                ["y"] = -304.3081652729948;
                ["sublevel"] = 4;
                ["inspiring"] = true;
            };
            [4] = {
                ["x"] = 405.4032786885241;
                ["y"] = -286.126660108214;
                ["sublevel"] = 4;
            };
            [5] = {
                ["x"] = 241.20393442622932;
                ["y"] = -258.4449090014756;
                ["sublevel"] = 5;
            };
            [6] = {
                ["x"] = 361.4478688524584;
                ["y"] = -287.9557304476141;
                ["sublevel"] = 5;
            };
        };
        ["name"] = L["Blighted Sludge-Spewer"];
        ["id"] = 174210;
        ["health"] = 64080;
        ["level"] = 60;
        ["count"] = 4;
        ["displayId"] = 95559;
        ["creatureType"] = L["Undead"];
        ["scale"] = 1;
    };
    [24] = {
        ["clones"] = {
            [1] = {
                ["x"] = 595.7940983606555;
                ["y"] = -346.97737333989124;
                ["sublevel"] = 4;
                ["inspiring"] = true;
            };
            [2] = {
                ["x"] = 605.9016393442623;
                ["y"] = -345.85809149040807;
                ["sublevel"] = 4;
            };
            [3] = {
                ["x"] = 607.3337704918033;
                ["y"] = -332.18101328086493;
                ["sublevel"] = 4;
            };
            [4] = {
                ["x"] = 599.126557377049;
                ["y"] = -331.63502213477597;
                ["sublevel"] = 4;
            };
            [5] = {
                ["x"] = 515.7875409836071;
                ["y"] = -336.9584358091482;
                ["sublevel"] = 4;
            };
            [6] = {
                ["x"] = 513.0059016393442;
                ["y"] = -347.5506640432853;
                ["sublevel"] = 4;
            };
            [7] = {
                ["x"] = 526.1154098360662;
                ["y"] = -354.1844564682726;
                ["sublevel"] = 4;
            };
            [8] = {
                ["x"] = 514.7409836065576;
                ["y"] = -357.43310378750533;
                ["sublevel"] = 4;
            };
            [9] = {
                ["x"] = 251.72459016393466;
                ["y"] = -223.77447122479018;
                ["sublevel"] = 5;
            };
            [10] = {
                ["x"] = 242.99409836065578;
                ["y"] = -243.73044761436333;
                ["sublevel"] = 5;
            };
            [11] = {
                ["x"] = 345.94229508196753;
                ["y"] = -268.2181505164779;
                ["sublevel"] = 5;
            };
            [12] = {
                ["x"] = 357.2616393442617;
                ["y"] = -274.85194294146515;
                ["sublevel"] = 5;
            };
            [13] = {
                ["x"] = 350.37639344262243;
                ["y"] = -284.07919331037834;
                ["sublevel"] = 5;
            };
            [14] = {
                ["x"] = 394.3593442622952;
                ["y"] = -291.85956714215376;
                ["sublevel"] = 5;
            };
            [15] = {
                ["x"] = 376.6229508196721;
                ["y"] = -290.30349237579946;
                ["sublevel"] = 5;
            };
        };
        ["name"] = L["Disgusting Refuse"];
        ["id"] = 163089;
        ["health"] = 20025;
        ["level"] = 60;
        ["count"] = 1;
        ["displayId"] = 94761;
        ["creatureType"] = L["Undead"];
        ["scale"] = 1;
    };
    [25] = {
        ["clones"] = {
            [1] = {
                ["x"] = 632.093114754099;
                ["y"] = -369.6087063453018;
                ["sublevel"] = 4;
            };
            [2] = {
                ["x"] = 248.08918032786863;
                ["y"] = -232.128135759961;
                ["sublevel"] = 5;
                ["inspiring"] = true;
            };
            [3] = {
                ["x"] = 468.63737704918;
                ["y"] = -306.4648303000495;
                ["sublevel"] = 5;
            };
        };
        ["name"] = L["Diseased Horror"];
        ["id"] = 170690;
        ["health"] = 80100;
        ["level"] = 60;
        ["count"] = 4;
        ["displayId"] = 97117;
        ["creatureType"] = L["Undead"];
        ["scale"] = 1;
    };
    [26] = {
        ["clones"] = {
            [1] = {
                ["x"] = 561.8636065573777;
                ["y"] = -333.6005902606977;
                ["sublevel"] = 4;
            };
            [2] = {
                ["x"] = 402.4288524590161;
                ["y"] = -295.43580914904;
                ["sublevel"] = 4;
            };
            [3] = {
                ["x"] = 235.86098360655703;
                ["y"] = -255.4419576979835;
                ["sublevel"] = 5;
            };
            [4] = {
                ["x"] = 465.19475409836025;
                ["y"] = -327.5400885391045;
                ["sublevel"] = 5;
            };
        };
        ["name"] = L["Putrid Butcher"];
        ["id"] = 169927;
        ["health"] = 96120;
        ["level"] = 60;
        ["count"] = 5;
        ["displayId"] = 97116;
        ["creatureType"] = L["Undead"];
        ["scale"] = 1;
    };
    [27] = {
        ["clones"] = {
            [1] = {
                ["x"] = 310.9927868852461;
                ["y"] = -355.05804230201625;
                ["sublevel"] = 4;
            };
            [2] = {
                ["x"] = 330.1613114754102;
                ["y"] = -143.18617806197673;
                ["sublevel"] = 4;
            };
            [3] = {
                ["x"] = 402.8144262295088;
                ["y"] = -296.3912936546977;
                ["sublevel"] = 5;
            };
        };
        ["name"] = L["Rancid Gasbag"];
        ["id"] = 163086;
        ["health"] = 152190;
        ["level"] = 60;
        ["count"] = 8;
        ["displayId"] = 97161;
        ["creatureType"] = L["Undead"];
        ["scale"] = 1;
    };
    [28] = {
        ["clones"] = {
            [1] = {
                ["x"] = 592.3790163934431;
                ["y"] = -358.7161829808164;
                ["sublevel"] = 5;
            };
        };
        ["isBoss"] = true;
        ["encounterID"] = 2401;
        ["instanceID"] = 1187;
        ["name"] = L["Gorechop"];
        ["id"] = 162317;
        ["health"] = 560700;
        ["level"] = 60;
        ["count"] = 0;
        ["displayId"] = 95106;
        ["creatureType"] = L["Undead"];
        ["scale"] = 1;
    };
    [29] = {
        ["clones"] = {
            [1] = {
                ["x"] = 574.835409836065;
                ["y"] = -356.88711264141637;
                ["sublevel"] = 5;
            };
            [2] = {
                ["x"] = 571.9711475409831;
                ["y"] = -359.5624692572551;
                ["sublevel"] = 5;
            };
            [3] = {
                ["x"] = 566.1600000000004;
                ["y"] = -362.15592720117985;
                ["sublevel"] = 5;
            };
            [4] = {
                ["x"] = 556.382950819672;
                ["y"] = -368.5986227250365;
                ["sublevel"] = 5;
            };
        };
        ["name"] = L["Oozing Leftovers"];
        ["id"] = 165260;
        ["health"] = 72090;
        ["level"] = 60;
        ["count"] = 0;
        ["displayId"] = 94761;
        ["creatureType"] = L["Undead"];
        ["scale"] = 1;
    };
    [30] = {
        ["clones"] = {
            [1] = {
                ["x"] = 424.6709033136633;
                ["y"] = -275.1571914893617;
                ["sublevel"] = 1;
            };
        };
        ["name"] = L["Mordretha, the Endless Empress"];
        ["id"] = 165946;
        ["health"] = 640800;
        ["level"] = 60;
        ["count"] = 0;
        ["displayId"] = 96078;
        ["creatureType"] = L["Humanoid"];
        ["scale"] = 1;
    };
};
