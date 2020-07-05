local MDT = MDT
local L = MDT.L
local dungeonIndex = 15
MDT.dungeonTotalCount[dungeonIndex] = {normal=198,teeming=237,teemingEnabled=true}
MDT.mapPOIs[dungeonIndex] = {
    [1] = {
        [1] = {
            ["y"] = -210.32103688142;
            ["x"] = 517.98001617239;
            ["template"] = "MapLinkPinTemplate";
            ["target"] = 2;
            ["connectionIndex"] = 1;
            ["direction"] = -1;
            ["type"] = "mapLink";
        };
        [2] = {
            ["y"] = -329.12649940624;
            ["x"] = 517.42667589569;
            ["template"] = "MapLinkPinTemplate";
            ["target"] = 2;
            ["connectionIndex"] = 2;
            ["direction"] = -1;
            ["type"] = "mapLink";
        };
        [3] = {
            ["y"] = -365.02988947658;
            ["x"] = 600.63207260699;
            ["template"] = "MapLinkPinTemplate";
            ["weeks"] = {
                [1] = true;
                [8] = true;
            };
            ["text"] = string.format(L["atalTeemingNote"],"\n","\n","\n","\n");
            ["type"] = "generalNote";
            ["scale"] = 2;
        };
        [4] = {
            ["y"] = -150.19501620336;
            ["x"] = 600.63207260699;
            ["template"] = "MapLinkPinTemplate";
            ["weeks"] = {
                [1] = true;
                [8] = true;
            };
            ["text"] = string.format(L["atalTeemingNote"],"\n","\n","\n","\n");
            ["type"] = "generalNote";
            ["scale"] = 2;
        };
        [5] = {
            ["npcId"] = 161243;
            ["type"] = "nyalothaSpire";
            ["index"] = 1;
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
            ["y"] = -207.84478938144;
            ["x"] = 587.56733659681;
            ["tooltipText"] = L["Entropic Spire of Ny'alotha"];
            ["template"] = "VignettePinTemplate";
        };
        [6] = {
            ["npcId"] = 161124;
            ["type"] = "nyalothaSpire";
            ["index"] = 3;
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
            ["y"] = -257.18926210658;
            ["x"] = 462.89828402862;
            ["tooltipText"] = L["Brutal Spire of Ny'alotha"];
            ["template"] = "VignettePinTemplate";
        };
        [7] = {
            ["npcId"] = 161241;
            ["type"] = "nyalothaSpire";
            ["index"] = 2;
            ["weeks"] = {
                [1] = true;
                [2] = true;
                [5] = true;
                [6] = true;
                [9] = true;
                [10] = true;
            };
            ["y"] = -349.89286786923;
            ["x"] = 581.14504888138;
            ["tooltipText"] = L["Cursed Spire of Ny'alotha"];
            ["template"] = "VignettePinTemplate";
        };
        [8] = {
            ["npcId"] = 161244;
            ["type"] = "nyalothaSpire";
            ["index"] = 4;
            ["weeks"] = {
                [1] = true;
                [2] = true;
                [5] = true;
                [6] = true;
                [9] = true;
                [10] = true;
            };
            ["y"] = -139.59233583327;
            ["x"] = 417.6415060524;
            ["tooltipText"] = L["Defiled Spire of Ny'alotha"];
            ["template"] = "VignettePinTemplate";
        };
        [9] = {
            ["npcId"] = 161241;
            ["type"] = "nyalothaSpire";
            ["index"] = 5;
            ["weeks"] = {
                [11] = true;
                [7] = true;
                [8] = true;
                [3] = true;
                [12] = true;
                [4] = true;
            };
            ["y"] = -137.50463674291;
            ["x"] = 418.19472278238;
            ["tooltipText"] = L["Cursed Spire of Ny'alotha"];
            ["template"] = "VignettePinTemplate";
        };
        [10] = {
            ["npcId"] = 161244;
            ["type"] = "nyalothaSpire";
            ["index"] = 6;
            ["weeks"] = {
                [11] = true;
                [7] = true;
                [8] = true;
                [3] = true;
                [12] = true;
                [4] = true;
            };
            ["y"] = -349.61787819522;
            ["x"] = 580.99671668925;
            ["tooltipText"] = L["Defiled Spire of Ny'alotha"];
            ["template"] = "VignettePinTemplate";
        };
    };
    [2] = {
        [1] = {
            ["y"] = -154.91903909324;
            ["x"] = 587.10715642853;
            ["template"] = "MapLinkPinTemplate";
            ["target"] = 1;
            ["connectionIndex"] = 1;
            ["direction"] = 1;
            ["type"] = "mapLink";
        };
        [2] = {
            ["y"] = -508.99905320816;
            ["x"] = 587.10715642853;
            ["template"] = "MapLinkPinTemplate";
            ["target"] = 1;
            ["connectionIndex"] = 2;
            ["direction"] = 1;
            ["type"] = "mapLink";
        };
    };
};

MDT.dungeonEnemies[dungeonIndex] = {
    [1] = {
        ["clones"] = {
            [1] = {
                ["y"] = -340.4715395664;
                ["x"] = 578.61472163258;
                ["g"] = 1;
                ["sublevel"] = 1;
            };
            [2] = {
                ["sublevel"] = 1;
                ["x"] = 586.43339847879;
                ["infested"] = {
                    [2] = true;
                };
                ["g"] = 1;
                ["y"] = -340.83590023072;
            };
            [3] = {
                ["y"] = -475.53583066501;
                ["x"] = 449.43285967335;
                ["g"] = 7;
                ["sublevel"] = 1;
            };
            [4] = {
                ["y"] = -477.6043721857;
                ["x"] = 471.16892743739;
                ["g"] = 7;
                ["sublevel"] = 1;
            };
            [5] = {
                ["y"] = -466.01230157081;
                ["x"] = 451.81090399163;
                ["g"] = 7;
                ["sublevel"] = 1;
            };
            [6] = {
                ["sublevel"] = 1;
                ["x"] = 467.22361490784;
                ["infested"] = {
                    [3] = true;
                };
                ["g"] = 8;
                ["y"] = -361.32331300461;
            };
            [7] = {
                ["y"] = -361.09075175024;
                ["x"] = 453.27009933105;
                ["g"] = 8;
                ["sublevel"] = 1;
            };
        };
        ["reaping"] = 148716;
        ["scale"] = 1;
        ["spells"] = {
            [277564] = {};
            [209859] = {};
            [277242] = {};
            [256138] = {};
        };
        ["id"] = 127799;
        ["count"] = 4;
        ["name"] = "Dazar'ai Honor Guard";
        ["displayId"] = 81326;
        ["creatureType"] = "Humanoid";
        ["level"] = 120;
        ["health"] = 768495;
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
            ["Silence"] = true;
            ["Fear"] = true;
        };
    };
    [2] = {
        ["clones"] = {
            [1] = {
                ["y"] = -334.55451402168;
                ["x"] = 571.37693269554;
                ["g"] = 1;
                ["sublevel"] = 1;
            };
            [2] = {
                ["y"] = -360.35580706243;
                ["x"] = 569.1457495061;
                ["g"] = 2;
                ["sublevel"] = 1;
            };
            [3] = {
                ["sublevel"] = 1;
                ["x"] = 580.757036442;
                ["infested"] = {
                    [3] = true;
                };
                ["g"] = 3;
                ["y"] = -389.01293552463;
            };
            [4] = {
                ["sublevel"] = 1;
                ["x"] = 521.41919375683;
                ["patrol"] = {
                    [1] = {
                        ["y"] = -387.41420880268;
                        ["x"] = 521.41919375683;
                    };
                    [2] = {
                        ["y"] = -387.41420880268;
                        ["x"] = 510.41917459207;
                    };
                    [3] = {
                        ["y"] = -387.41420880268;
                        ["x"] = 521.41919375683;
                    };
                    [4] = {
                        ["y"] = -387.41420880268;
                        ["x"] = 531.41915655981;
                    };
                };
                ["infested"] = {
                    [2] = true;
                    [3] = true;
                };
                ["y"] = -387.41420880268;
            };
            [5] = {
                ["y"] = -394.96740325824;
                ["x"] = 555.83889576925;
                ["g"] = 4;
                ["sublevel"] = 1;
            };
            [6] = {
                ["y"] = -423.52378569339;
                ["x"] = 549.58314368694;
                ["g"] = 5;
                ["sublevel"] = 1;
            };
            [7] = {
                ["y"] = -423.02378969901;
                ["x"] = 573.3331411747;
                ["g"] = 5;
                ["sublevel"] = 1;
            };
            [8] = {
                ["y"] = -438.62955369067;
                ["x"] = 511.096923774;
                ["g"] = 6;
                ["sublevel"] = 1;
            };
            [9] = {
                ["sublevel"] = 1;
                ["x"] = 458.09438185492;
                ["infested"] = {
                    [1] = true;
                };
                ["g"] = 7;
                ["y"] = -474.82268196192;
            };
            [10] = {
                ["y"] = -364.09809808532;
                ["x"] = 583.10517722733;
                ["teeming"] = true;
                ["g"] = 2;
                ["sublevel"] = 1;
            };
        };
        ["reaping"] = 148716;
        ["scale"] = 1;
        ["spells"] = {
            [255824] = {};
            [277242] = {};
            [277564] = {};
            [253279] = {};
            [209859] = {};
            [253239] = {};
            [253666] = {};
            [253654] = {};
        };
        ["id"] = 122971;
        ["count"] = 4;
        ["name"] = "Dazar'ai Juggernaut";
        ["displayId"] = 81325;
        ["creatureType"] = "Humanoid";
        ["level"] = 120;
        ["health"] = 883769;
        ["characteristics"] = {
            ["Taunt"] = true;
            ["Incapacitate"] = true;
            ["Root"] = true;
            ["Imprison"] = true;
            ["Polymorph"] = true;
            ["Disorient"] = true;
            ["Sap"] = true;
            ["Mind Control"] = true;
            ["Silence"] = true;
            ["Slow"] = true;
            ["Stun"] = true;
            ["Fear"] = true;
        };
    };
    [3] = {
        ["clones"] = {
            [1] = {
                ["y"] = -364.68933932213;
                ["x"] = 574.5294362209;
                ["g"] = 2;
                ["sublevel"] = 1;
            };
            [2] = {
                ["sublevel"] = 1;
                ["x"] = 544.00217871958;
                ["infested"] = {
                    [1] = true;
                };
                ["g"] = 4;
                ["y"] = -388.02864926549;
            };
            [3] = {
                ["sublevel"] = 1;
                ["x"] = 563.79809777932;
                ["patrol"] = {
                    [1] = {
                        ["y"] = -388.23273361401;
                        ["x"] = 563.79809777932;
                    };
                    [2] = {
                        ["y"] = -388.84496914311;
                        ["x"] = 572.36953531849;
                    };
                    [3] = {
                        ["y"] = -388.23273361401;
                        ["x"] = 563.79809777932;
                    };
                    [4] = {
                        ["y"] = -387.82455615873;
                        ["x"] = 555.6348289372;
                    };
                };
                ["y"] = -388.23273361401;
                ["infested"] = {
                    [2] = true;
                };
            };
            [4] = {
                ["y"] = -428.77377045649;
                ["x"] = 555.58313853486;
                ["g"] = 5;
                ["sublevel"] = 1;
            };
            [5] = {
                ["y"] = -476.78090823003;
                ["x"] = 464.89972142104;
                ["teeming"] = true;
                ["g"] = 7;
                ["sublevel"] = 1;
            };
            [6] = {
                ["y"] = -358.12858599382;
                ["x"] = 557.18566363487;
                ["teeming"] = true;
                ["g"] = 2;
                ["sublevel"] = 1;
            };
            [7] = {
                ["y"] = -370.23021977251;
                ["x"] = 560.95466375897;
                ["teeming"] = true;
                ["g"] = 29;
                ["sublevel"] = 1;
            };
        };
        ["reaping"] = 148893;
        ["scale"] = 1;
        ["spells"] = {
            [277242] = {};
            [253544] = {};
            [253517] = {};
            [209859] = {};
            [253526] = {};
            [253548] = {};
            [277564] = {};
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
            ["Silence"] = true;
            ["Fear"] = true;
        };
        ["count"] = 4;
        ["name"] = "Dazar'ai Confessor";
        ["displayId"] = 81330;
        ["creatureType"] = "Humanoid";
        ["level"] = 120;
        ["health"] = 768495;
        ["id"] = 122973;
    };
    [4] = {
        ["clones"] = {
            [1] = {
                ["sublevel"] = 1;
                ["x"] = 562.52943339035;
                ["infested"] = {
                    [3] = true;
                };
                ["g"] = 2;
                ["y"] = -362.32570287386;
            };
            [2] = {
                ["y"] = -395.01293037255;
                ["x"] = 576.50708658301;
                ["g"] = 3;
                ["sublevel"] = 1;
            };
            [3] = {
                ["y"] = -382.72252626975;
                ["x"] = 542.36952144787;
                ["g"] = 4;
                ["sublevel"] = 1;
            };
            [4] = {
                ["y"] = -428.52378855255;
                ["x"] = 569.08312694269;
                ["g"] = 5;
                ["sublevel"] = 1;
            };
            [5] = {
                ["y"] = -460.21709589194;
                ["x"] = 466.23559419455;
                ["g"] = 7;
                ["sublevel"] = 1;
            };
            [6] = {
                ["y"] = -367.88206153212;
                ["x"] = 463.46747125231;
                ["g"] = 8;
                ["sublevel"] = 1;
            };
            [7] = {
                ["sublevel"] = 1;
                ["x"] = 456.57091720042;
                ["y"] = -367.88206153212;
                ["g"] = 8;
                ["infested"] = {
                    [2] = true;
                };
            };
            [8] = {
                ["sublevel"] = 1;
                ["x"] = 510.78413920208;
                ["infested"] = {
                    [3] = true;
                };
                ["g"] = 6;
                ["y"] = -428.97026817766;
            };
        };
        ["reaping"] = 148893;
        ["scale"] = 1;
        ["spells"] = {
            [277242] = {};
            [209859] = {};
            [277564] = {};
            [253583] = {};
            [253562] = {};
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
            ["Silence"] = true;
            ["Slow"] = true;
            ["Stun"] = true;
            ["Fear"] = true;
        };
        ["count"] = 4;
        ["name"] = "Dazar'ai Augur";
        ["displayId"] = 81336;
        ["creatureType"] = "Humanoid";
        ["level"] = 120;
        ["health"] = 768495;
        ["id"] = 122972;
    };
    [5] = {
        ["clones"] = {
            [1] = {
                ["sublevel"] = 1;
                ["x"] = 548.90013301827;
                ["infested"] = {
                    [3] = true;
                };
                ["g"] = 4;
                ["y"] = -393.74294095827;
            };
            [2] = {
                ["sublevel"] = 1;
                ["x"] = 561.58313338278;
                ["infested"] = {
                    [3] = true;
                };
                ["g"] = 5;
                ["y"] = -429.52379127015;
            };
            [3] = {
                ["y"] = -373.5787829515;
                ["x"] = 555.11356787669;
                ["teeming"] = true;
                ["g"] = 29;
                ["sublevel"] = 1;
            };
            [4] = {
                ["y"] = -376.72945455301;
                ["x"] = 564.97660608983;
                ["teeming"] = true;
                ["g"] = 29;
                ["sublevel"] = 1;
            };
        };
        ["reaping"] = 148894;
        ["scale"] = 1.2;
        ["spells"] = {
            [254958] = {};
            [254959] = {};
            [209859] = {};
            [277564] = {};
            [254974] = {};
        };
        ["stealthDetect"] = true;
        ["characteristics"] = {
            ["Taunt"] = true;
        };
        ["count"] = 6;
        ["name"] = "Dazar'ai Colossus";
        ["displayId"] = 80338;
        ["creatureType"] = "Mechanical";
        ["level"] = 121;
        ["health"] = 1306442;
        ["id"] = 122984;
    };
    [6] = {
        ["clones"] = {
            [1] = {
                ["y"] = -471.92897904227;
                ["x"] = 496.19525601954;
                ["sublevel"] = 1;
                ["infested"] = {
                    [1] = true;
                    [2] = true;
                };
            };
            [2] = {
                ["y"] = -471.42806939135;
                ["x"] = 424.18247109914;
                ["infested"] = {
                    [1] = true;
                };
                ["sublevel"] = 1;
            };
            [3] = {
                ["sublevel"] = 1;
                ["x"] = 469.34369791727;
                ["y"] = -467.39473588482;
                ["g"] = 7;
                ["infested"] = {
                    [2] = true;
                };
            };
            [4] = {
                ["y"] = -458.80398753301;
                ["x"] = 455.51742466636;
                ["teeming"] = true;
                ["g"] = 7;
                ["sublevel"] = 1;
            };
        };
        ["reaping"] = 148893;
        ["id"] = 132126;
        ["spells"] = {
            [260668] = {};
            [277242] = {};
            [209859] = {};
            [260666] = {};
            [260667] = {};
            [277564] = {};
        };
        ["characteristics"] = {
            ["Taunt"] = true;
            ["Incapacitate"] = true;
            ["Root"] = true;
            ["Polymorph"] = true;
            ["Mind Control"] = true;
            ["Imprison"] = true;
            ["Stun"] = true;
            ["Slow"] = true;
            ["Silence"] = true;
            ["Fear"] = true;
        };
        ["name"] = "Gilded Priestess";
        ["health"] = 768495;
        ["displayId"] = 82238;
        ["creatureType"] = "Humanoid";
        ["level"] = 120;
        ["count"] = 4;
        ["scale"] = 1;
    };
    [7] = {
        ["clones"] = {
            [1] = {
                ["y"] = -490.32190350751;
                ["x"] = 459.78564177319;
                ["sublevel"] = 1;
            };
        };
        ["scale"] = 1;
        ["characteristics"] = {
            ["Taunt"] = true;
        };
        ["spells"] = {
            [255577] = {};
            [255579] = {};
            [255836] = {};
            [277564] = {};
            [255591] = {};
            [255835] = {};
            [205276] = {};
            [255575] = {};
            [255581] = {};
        };
        ["isBoss"] = true;
        ["encounterID"] = 2082;
        ["instanceID"] = 968;
        ["id"] = 122967;
        ["health"] = 6916455;
        ["displayId"] = 80293;
        ["creatureType"] = "Humanoid";
        ["level"] = 122;
        ["name"] = "Priestess Alun'za";
        ["count"] = 0;
    };
    [8] = {
        ["clones"] = {
            [1] = {
                ["sublevel"] = 1;
                ["x"] = 578.02832482897;
                ["patrol"] = {
                    [1] = {
                        ["y"] = -231.02350114891;
                        ["x"] = 578.02832482897;
                    };
                    [2] = {
                        ["y"] = -248.42728194054;
                        ["x"] = 578.14683954797;
                    };
                    [3] = {
                        ["y"] = -231.02350114891;
                        ["x"] = 578.02832482897;
                    };
                    [4] = {
                        ["y"] = -216.52349929465;
                        ["x"] = 578.02832482897;
                    };
                };
                ["infested"] = {
                    [2] = true;
                };
                ["y"] = -231.02350114891;
            };
            [2] = {
                ["sublevel"] = 1;
                ["x"] = 527.50945337536;
                ["patrol"] = {
                    [1] = {
                        ["y"] = -154.04509708006;
                        ["x"] = 527.50945337536;
                    };
                    [2] = {
                        ["y"] = -136.0450921515;
                        ["x"] = 528.75949156657;
                    };
                    [3] = {
                        ["y"] = -154.04509708006;
                        ["x"] = 527.50945337536;
                    };
                    [4] = {
                        ["y"] = -156.79511243617;
                        ["x"] = 509.0095061264;
                    };
                };
                ["infested"] = {
                    [1] = true;
                };
                ["y"] = -154.04509708006;
            };
            [3] = {
                ["y"] = -158.03327728621;
                ["x"] = 463.70050232019;
                ["g"] = 15;
                ["sublevel"] = 1;
            };
            [4] = {
                ["sublevel"] = 1;
                ["x"] = 454.4505066867;
                ["patrol"] = {
                    [1] = {
                        ["y"] = -157.53327056299;
                        ["x"] = 454.4505066867;
                    };
                    [2] = {
                        ["y"] = -132.78329181531;
                        ["x"] = 454.4505066867;
                    };
                    [3] = {
                        ["y"] = -157.53327056299;
                        ["x"] = 454.4505066867;
                    };
                    [4] = {
                        ["y"] = -175.39756174872;
                        ["x"] = 454.55408558202;
                    };
                };
                ["infested"] = {
                    [2] = true;
                };
                ["g"] = 15;
                ["y"] = -157.53327056299;
            };
            [5] = {
                ["y"] = -181.07969931314;
                ["x"] = 465.01085034371;
                ["teeming"] = true;
                ["g"] = 16;
                ["sublevel"] = 1;
            };
            [6] = {
                ["sublevel"] = 1;
                ["x"] = 602.77173726801;
                ["infested"] = {
                    [3] = true;
                };
                ["g"] = 28;
                ["y"] = -192.94624716813;
            };
            [7] = {
                ["y"] = -201.62274042695;
                ["x"] = 604.03172802899;
                ["g"] = 28;
                ["sublevel"] = 1;
            };
            [8] = {
                ["y"] = -181.06734860891;
                ["x"] = 456.80837603918;
                ["teeming"] = true;
                ["g"] = 16;
                ["sublevel"] = 1;
            };
        };
        ["reaping"] = 148716;
        ["id"] = 122970;
        ["spells"] = {
            [209859] = {};
            [252661] = {};
            [277564] = {};
            [252666] = {};
            [252692] = {};
            [132951] = {};
            [252687] = {};
            [277242] = {};
        };
        ["name"] = "Shadowblade Stalker";
        ["health"] = 768495;
        ["level"] = 120;
        ["count"] = 4;
        ["displayId"] = 84712;
        ["creatureType"] = "Humanoid";
        ["stealth"] = true;
        ["scale"] = 1;
        ["characteristics"] = {
            ["Taunt"] = true;
            ["Incapacitate"] = true;
            ["Root"] = true;
            ["Repentance"] = true;
            ["Grip"] = true;
            ["Polymorph"] = true;
            ["Disorient"] = true;
            ["Sap"] = true;
            ["Knock"] = true;
            ["Stun"] = true;
            ["Slow"] = true;
            ["Silence"] = true;
            ["Fear"] = true;
        };
    };
    [9] = {
        ["clones"] = {
            [1] = {
                ["y"] = -215.73948344478;
                ["x"] = 578.56400086726;
                ["g"] = 9;
                ["sublevel"] = 1;
            };
            [2] = {
                ["y"] = -184.24948923845;
                ["x"] = 574.23850127346;
                ["g"] = 10;
                ["sublevel"] = 1;
            };
            [3] = {
                ["sublevel"] = 1;
                ["x"] = 545.2773143908;
                ["infested"] = {
                    [3] = true;
                };
                ["g"] = 12;
                ["y"] = -140.01385757439;
            };
            [4] = {
                ["y"] = -140.76844685786;
                ["x"] = 501.09882974782;
                ["g"] = 13;
                ["sublevel"] = 1;
            };
            [5] = {
                ["sublevel"] = 1;
                ["x"] = 455.19844206237;
                ["infested"] = {
                    [3] = true;
                };
                ["g"] = 14;
                ["y"] = -113.87125810772;
            };
            [6] = {
                ["y"] = -122.65144800835;
                ["x"] = 467.51403219866;
                ["g"] = 14;
                ["sublevel"] = 1;
            };
            [7] = {
                ["y"] = -156.41043473743;
                ["x"] = 400.64217991315;
                ["g"] = 17;
                ["sublevel"] = 1;
            };
            [8] = {
                ["sublevel"] = 1;
                ["x"] = 407.37687583208;
                ["infested"] = {
                    [3] = true;
                };
                ["g"] = 17;
                ["y"] = -150.08390751555;
            };
            [9] = {
                ["y"] = -171.88884800156;
                ["x"] = 561.68356577468;
                ["teeming"] = true;
                ["g"] = 27;
                ["sublevel"] = 1;
            };
            [10] = {
                ["y"] = -159.70134850622;
                ["x"] = 566.83980318175;
                ["teeming"] = true;
                ["g"] = 27;
                ["sublevel"] = 1;
            };
        };
        ["reaping"] = 148894;
        ["scale"] = 1.2;
        ["spells"] = {
            [256959] = {};
            [277564] = {};
            [256960] = {};
            [209859] = {};
            [132951] = {};
            [255620] = {};
            [255814] = {};
        };
        ["id"] = 127757;
        ["name"] = "Reanimated Honor Guard";
        ["health"] = 845345;
        ["displayId"] = 80376;
        ["creatureType"] = "Undead";
        ["level"] = 120;
        ["count"] = 4;
        ["characteristics"] = {
            ["Taunt"] = true;
            ["Incapacitate"] = true;
            ["Shackle Undead"] = true;
            ["Root"] = true;
            ["Control Undead"] = true;
            ["Disorient"] = true;
            ["Stun"] = true;
            ["Slow"] = true;
            ["Silence"] = true;
        };
    };
    [10] = {
        ["clones"] = {
            [1] = {
                ["sublevel"] = 1;
                ["x"] = 576.88320070773;
                ["infested"] = {
                    [1] = true;
                };
                ["g"] = 9;
                ["y"] = -208.29627174188;
            };
            [2] = {
                ["y"] = -179.23259408681;
                ["x"] = 579.96481501769;
                ["g"] = 10;
                ["sublevel"] = 1;
            };
            [3] = {
                ["sublevel"] = 1;
                ["x"] = 546.99606019315;
                ["infested"] = {
                    [1] = true;
                };
                ["g"] = 12;
                ["y"] = -146.57636349237;
            };
            [4] = {
                ["y"] = -144.6814772613;
                ["x"] = 497.18579001496;
                ["g"] = 13;
                ["sublevel"] = 1;
            };
            [5] = {
                ["sublevel"] = 1;
                ["x"] = 463.11079099857;
                ["infested"] = {
                    [1] = true;
                };
                ["g"] = 14;
                ["y"] = -116.53577227204;
            };
            [6] = {
                ["sublevel"] = 1;
                ["x"] = 400.17098249987;
                ["y"] = -148.9670464846;
                ["g"] = 17;
                ["infested"] = {
                    [1] = true;
                };
            };
            [7] = {
                ["y"] = -165.01383797006;
                ["x"] = 562.30854717967;
                ["teeming"] = true;
                ["g"] = 27;
                ["sublevel"] = 1;
            };
        };
        ["scale"] = 0.6;
        ["spells"] = {
            [277564] = {};
            [277242] = {};
        };
        ["id"] = 127315;
        ["name"] = "Reanimation Totem";
        ["health"] = 153699;
        ["displayId"] = 82388;
        ["creatureType"] = "Not specified";
        ["level"] = 120;
        ["count"] = 0;
        ["characteristics"] = {
            ["Taunt"] = true;
            ["Slow"] = true;
        };
    };
    [11] = {
        ["clones"] = {
            [1] = {
                ["y"] = -171.21740510255;
                ["x"] = 580.84316416692;
                ["g"] = 10;
                ["sublevel"] = 1;
            };
            [2] = {
                ["sublevel"] = 1;
                ["x"] = 544.18354999343;
                ["infested"] = {
                    [2] = true;
                };
                ["g"] = 12;
                ["y"] = -152.51384777223;
            };
            [3] = {
                ["sublevel"] = 1;
                ["x"] = 496.53360739672;
                ["infested"] = {
                    [3] = true;
                };
                ["g"] = 13;
                ["y"] = -151.63799856157;
            };
            [4] = {
                ["y"] = -122.75224664602;
                ["x"] = 458.10152921449;
                ["g"] = 14;
                ["sublevel"] = 1;
            };
            [5] = {
                ["y"] = -116.31924253356;
                ["x"] = 471.12035622466;
                ["g"] = 14;
                ["sublevel"] = 1;
            };
            [6] = {
                ["y"] = -189.21020838642;
                ["x"] = 456.66551702163;
                ["g"] = 16;
                ["sublevel"] = 1;
            };
            [7] = {
                ["sublevel"] = 1;
                ["x"] = 465.59418684662;
                ["infested"] = {
                    [1] = true;
                };
                ["g"] = 16;
                ["y"] = -189.38612741357;
            };
            [8] = {
                ["y"] = -151.99984829127;
                ["x"] = 391.88059332997;
                ["g"] = 17;
                ["sublevel"] = 1;
            };
            [9] = {
                ["y"] = -160.7951129036;
                ["x"] = 557.62105253186;
                ["teeming"] = true;
                ["g"] = 27;
                ["sublevel"] = 1;
            };
        };
        ["reaping"] = 148893;
        ["scale"] = 1;
        ["spells"] = {
            [252781] = {};
            [252923] = {
                ["interruptible"] = true;
            };
            [277564] = {};
            [277242] = {};
            [209859] = {};
        };
        ["id"] = 122969;
        ["name"] = "Zanchuli Witch-Doctor";
        ["health"] = 768495;
        ["displayId"] = 80622;
        ["creatureType"] = "Humanoid";
        ["level"] = 120;
        ["count"] = 4;
        ["characteristics"] = {
            ["Taunt"] = true;
            ["Incapacitate"] = true;
            ["Root"] = true;
            ["Imprison"] = true;
            ["Polymorph"] = true;
            ["Mind Control"] = true;
            ["Sap"] = true;
            ["Disorient"] = true;
            ["Silence"] = true;
            ["Slow"] = true;
            ["Stun"] = true;
            ["Fear"] = true;
        };
    };
    [12] = {
        ["clones"] = {
            [1] = {
                ["y"] = -180.17009972189;
                ["x"] = 586.21481682213;
                ["g"] = 10;
                ["sublevel"] = 1;
            };
            [2] = {
                ["sublevel"] = 1;
                ["x"] = 546.52731743389;
                ["infested"] = {
                    [2] = true;
                };
                ["g"] = 11;
                ["y"] = -178.138849806;
            };
            [3] = {
                ["y"] = -174.07634997422;
                ["x"] = 551.2148120817;
                ["patrol"] = {
                    [1] = {
                        ["y"] = -174.07634997422;
                        ["x"] = 551.2148120817;
                    };
                    [2] = {
                        ["y"] = -182.67009910256;
                        ["x"] = 559.80855450452;
                    };
                    [3] = {
                        ["y"] = -191.10760287966;
                        ["x"] = 565.43354808189;
                    };
                    [4] = {
                        ["y"] = -182.67009910256;
                        ["x"] = 559.80855450452;
                    };
                    [5] = {
                        ["y"] = -174.07634997422;
                        ["x"] = 551.2148120817;
                    };
                    [6] = {
                        ["y"] = -165.32635549463;
                        ["x"] = 542.3085521343;
                    };
                    [7] = {
                        ["y"] = -160.63887425787;
                        ["x"] = 535.90231168414;
                    };
                    [8] = {
                        ["y"] = -165.32635549463;
                        ["x"] = 542.3085521343;
                    };
                };
                ["g"] = 11;
                ["sublevel"] = 1;
            };
            [4] = {
                ["y"] = -146.26384596779;
                ["x"] = 552.62105377052;
                ["g"] = 12;
                ["sublevel"] = 1;
            };
            [5] = {
                ["y"] = -148.96478547959;
                ["x"] = 509.17478672867;
                ["g"] = 13;
                ["sublevel"] = 1;
            };
            [6] = {
                ["y"] = -139.72297834971;
                ["x"] = 511.22537774386;
                ["g"] = 13;
                ["sublevel"] = 1;
            };
            [7] = {
                ["y"] = -181.2102014957;
                ["x"] = 449.66549873072;
                ["g"] = 16;
                ["sublevel"] = 1;
            };
            [8] = {
                ["sublevel"] = 1;
                ["x"] = 473.23693008871;
                ["infested"] = {
                    [3] = true;
                };
                ["g"] = 16;
                ["y"] = -181.06734860891;
            };
        };
        ["reaping"] = 148716;
        ["id"] = 127879;
        ["spells"] = {
            [273185] = {};
            [258653] = {};
            [277242] = {};
            [253721] = {};
            [277564] = {};
            [209859] = {};
        };
        ["stealthDetect"] = true;
        ["scale"] = 1;
        ["name"] = "Shieldbearer of Zul";
        ["health"] = 760810;
        ["displayId"] = 80904;
        ["creatureType"] = "Undead";
        ["level"] = 120;
        ["count"] = 4;
        ["characteristics"] = {
            ["Taunt"] = true;
            ["Incapacitate"] = true;
            ["Shackle Undead"] = true;
            ["Root"] = true;
            ["Control Undead"] = true;
            ["Disorient"] = true;
            ["Stun"] = true;
            ["Slow"] = true;
            ["Silence"] = true;
            ["Repentance"] = true;
        };
    };
    [13] = {
        ["clones"] = {
            [1] = {
                ["y"] = -88.199940336495;
                ["x"] = 459.77354478613;
                ["sublevel"] = 1;
            };
        };
        ["scale"] = 1;
        ["characteristics"] = {
            ["Taunt"] = true;
        };
        ["spells"] = {
            [250259] = {};
            [250372] = {};
            [259572] = {};
            [250368] = {};
            [259574] = {};
            [250258] = {};
            [250241] = {};
        };
        ["isBoss"] = true;
        ["encounterID"] = 2036;
        ["instanceID"] = 968;
        ["id"] = 122965;
        ["name"] = "Vol'kaal";
        ["displayId"] = 79453;
        ["creatureType"] = "Undead";
        ["level"] = 122;
        ["count"] = 0;
        ["health"] = 4918368;
    };
    [14] = {
        ["clones"] = {
            [1] = {
                ["sublevel"] = 1;
                ["x"] = 545.93839826733;
                ["y"] = -278.27607671767;
                ["g"] = 18;
                ["infested"] = {
                    [1] = true;
                };
            };
            [2] = {
                ["y"] = -269.07605622663;
                ["x"] = 541.93834457695;
                ["g"] = 18;
                ["sublevel"] = 1;
            };
            [3] = {
                ["y"] = -273.07605841859;
                ["x"] = 545.13838752925;
                ["g"] = 18;
                ["sublevel"] = 1;
            };
            [4] = {
                ["y"] = -280.48232467856;
                ["x"] = 540.8758256645;
                ["g"] = 18;
                ["sublevel"] = 1;
            };
            [5] = {
                ["y"] = -269.25733951273;
                ["x"] = 536.93215532409;
                ["g"] = 18;
                ["sublevel"] = 1;
            };
            [6] = {
                ["sublevel"] = 1;
                ["x"] = 538.62927512276;
                ["y"] = -225.8201414651;
                ["g"] = 19;
                ["infested"] = {
                    [1] = true;
                };
            };
            [7] = {
                ["y"] = -230.75165415435;
                ["x"] = 540.9580492496;
                ["g"] = 19;
                ["sublevel"] = 1;
            };
            [8] = {
                ["y"] = -231.2995947831;
                ["x"] = 546.02652652019;
                ["g"] = 19;
                ["sublevel"] = 1;
            };
            [9] = {
                ["y"] = -225.5461593931;
                ["x"] = 543.83476400519;
                ["g"] = 19;
                ["sublevel"] = 1;
            };
            [10] = {
                ["y"] = -219.65575354295;
                ["x"] = 540.68407305641;
                ["g"] = 19;
                ["sublevel"] = 1;
            };
            [11] = {
                ["y"] = -263.78347540154;
                ["x"] = 493.79757358014;
                ["g"] = 20;
                ["sublevel"] = 1;
            };
            [12] = {
                ["y"] = -268.18348296254;
                ["x"] = 487.79756170913;
                ["g"] = 20;
                ["sublevel"] = 1;
            };
            [13] = {
                ["y"] = -272.18346798836;
                ["x"] = 490.19755959108;
                ["g"] = 20;
                ["sublevel"] = 1;
            };
            [14] = {
                ["y"] = -270.18345830931;
                ["x"] = 493.79757358014;
                ["g"] = 20;
                ["sublevel"] = 1;
            };
            [15] = {
                ["y"] = -267.13793528873;
                ["x"] = 496.53590280593;
                ["g"] = 20;
                ["sublevel"] = 1;
            };
            [16] = {
                ["sublevel"] = 1;
                ["x"] = 453.16995680192;
                ["infested"] = {
                    [1] = true;
                };
                ["g"] = 21;
                ["y"] = -242.06262037639;
            };
            [17] = {
                ["y"] = -239.28989084622;
                ["x"] = 459.7608258794;
                ["g"] = 21;
                ["sublevel"] = 1;
            };
            [18] = {
                ["y"] = -233.78989199268;
                ["x"] = 460.26085406029;
                ["g"] = 21;
                ["sublevel"] = 1;
            };
            [19] = {
                ["y"] = -237.03988204942;
                ["x"] = 454.2608377547;
                ["g"] = 21;
                ["sublevel"] = 1;
            };
            [20] = {
                ["y"] = -232.78987854625;
                ["x"] = 455.26085120113;
                ["g"] = 21;
                ["sublevel"] = 1;
            };
            [21] = {
                ["y"] = -211.68516075284;
                ["x"] = 457.60716602951;
                ["g"] = 22;
                ["sublevel"] = 1;
            };
            [22] = {
                ["y"] = -200.77891187358;
                ["x"] = 456.91964751086;
                ["g"] = 22;
                ["sublevel"] = 1;
            };
            [23] = {
                ["sublevel"] = 1;
                ["x"] = 461.78897604719;
                ["infested"] = {
                    [1] = true;
                };
                ["g"] = 22;
                ["y"] = -211.82150261936;
            };
            [24] = {
                ["y"] = -202.87266463715;
                ["x"] = 462.82592244389;
                ["g"] = 22;
                ["sublevel"] = 1;
            };
            [25] = {
                ["y"] = -207.52890800999;
                ["x"] = 465.76339716057;
                ["g"] = 22;
                ["sublevel"] = 1;
            };
            [26] = {
                ["y"] = -294.97299967774;
                ["x"] = 454.63721809655;
                ["g"] = 23;
                ["sublevel"] = 1;
            };
            [27] = {
                ["y"] = -297.03551529626;
                ["x"] = 460.32472606329;
                ["g"] = 23;
                ["sublevel"] = 1;
            };
            [28] = {
                ["y"] = -299.03552292058;
                ["x"] = 465.34744074348;
                ["g"] = 23;
                ["sublevel"] = 1;
            };
            [29] = {
                ["y"] = -298.50427136136;
                ["x"] = 456.23097591113;
                ["g"] = 23;
                ["sublevel"] = 1;
            };
            [30] = {
                ["sublevel"] = 1;
                ["x"] = 461.8247033176;
                ["infested"] = {
                    [1] = true;
                };
                ["g"] = 23;
                ["y"] = -303.0355123333;
            };
            [31] = {
                ["y"] = -331.82209612897;
                ["x"] = 463.19878438472;
                ["g"] = 24;
                ["sublevel"] = 1;
            };
            [32] = {
                ["y"] = -332.18012174767;
                ["x"] = 457.80149069551;
                ["g"] = 24;
                ["sublevel"] = 1;
            };
            [33] = {
                ["y"] = -337.8095472715;
                ["x"] = 459.0013416387;
                ["g"] = 24;
                ["sublevel"] = 1;
            };
            [34] = {
                ["y"] = -336.73951909064;
                ["x"] = 463.13585749845;
                ["g"] = 24;
                ["sublevel"] = 1;
            };
            [35] = {
                ["y"] = -265.14032267036;
                ["x"] = 439.22572279091;
                ["g"] = 25;
                ["sublevel"] = 1;
            };
            [36] = {
                ["sublevel"] = 1;
                ["x"] = 436.74857368902;
                ["infested"] = {
                    [1] = true;
                };
                ["g"] = 25;
                ["y"] = -273.40281520645;
            };
            [37] = {
                ["y"] = -268.76841214407;
                ["x"] = 437.61455679274;
                ["g"] = 25;
                ["sublevel"] = 1;
            };
            [38] = {
                ["y"] = -276.707728719;
                ["x"] = 439.45100459994;
                ["g"] = 25;
                ["sublevel"] = 1;
            };
        };
        ["reaping"] = 148716;
        ["id"] = 128435;
        ["spells"] = {
            [255895] = {};
            [277564] = {};
            [209859] = {};
            [251188] = {};
            [277242] = {};
            [251187] = {};
        };
        ["scale"] = 0.6;
        ["count"] = 1;
        ["name"] = "Toxic Saurid";
        ["displayId"] = 81323;
        ["creatureType"] = "Beast";
        ["level"] = 120;
        ["health"] = 153699;
        ["characteristics"] = {
            ["Taunt"] = true;
            ["Incapacitate"] = true;
            ["Root"] = true;
            ["Disorient"] = true;
            ["Sap"] = true;
            ["Silence"] = true;
            ["Slow"] = true;
            ["Stun"] = true;
            ["Fear"] = true;
        };
    };
    [15] = {
        ["clones"] = {
            [1] = {
                ["sublevel"] = 1;
                ["x"] = 489.90350388003;
                ["y"] = -279.9216087774;
                ["g"] = 26;
                ["infested"] = {
                    [2] = true;
                };
            };
            [2] = {
                ["y"] = -334.47899998112;
                ["x"] = 527.88395942802;
                ["infested"] = {
                    [2] = true;
                };
                ["sublevel"] = 1;
            };
            [3] = {
                ["y"] = -347.25195468306;
                ["x"] = 542.30592320306;
                ["infested"] = {
                    [2] = true;
                    [3] = true;
                };
                ["sublevel"] = 1;
            };
            [4] = {
                ["y"] = -295.22113404063;
                ["x"] = 475.87887856681;
                ["sublevel"] = 1;
            };
            [5] = {
                ["y"] = -295.00076697932;
                ["x"] = 439.04239027483;
                ["sublevel"] = 1;
            };
            [6] = {
                ["y"] = -231.97955843208;
                ["x"] = 467.7141645445;
                ["infested"] = {
                    [3] = true;
                };
                ["sublevel"] = 1;
            };
            [7] = {
                ["y"] = -206.57366384027;
                ["x"] = 452.18757422234;
                ["sublevel"] = 1;
                ["infested"] = {
                    [2] = true;
                };
            };
            [8] = {
                ["y"] = -335.85455836855;
                ["x"] = 451.3609693652;
                ["infested"] = {
                    [2] = true;
                    [3] = true;
                };
                ["sublevel"] = 1;
            };
            [9] = {
                ["y"] = -279.87601828523;
                ["x"] = 497.31402487112;
                ["teeming"] = true;
                ["g"] = 26;
                ["sublevel"] = 1;
            };
            [10] = {
                ["y"] = -283.80681570174;
                ["x"] = 482.96621251728;
                ["teeming"] = true;
                ["g"] = 26;
                ["sublevel"] = 1;
            };
        };
        ["reaping"] = 148716;
        ["scale"] = 1;
        ["spells"] = {
            [277564] = {};
            [209859] = {};
            [277242] = {};
            [255041] = {};
        };
        ["id"] = 128434;
        ["name"] = "Feasting Skyscreamer";
        ["health"] = 753125;
        ["displayId"] = 76913;
        ["creatureType"] = "Beast";
        ["level"] = 120;
        ["count"] = 4;
        ["characteristics"] = {
            ["Taunt"] = true;
            ["Incapacitate"] = true;
            ["Root"] = true;
            ["Imprison"] = true;
            ["Polymorph"] = true;
            ["Mind Control"] = true;
            ["Sap"] = true;
            ["Disorient"] = true;
            ["Silence"] = true;
            ["Slow"] = true;
            ["Stun"] = true;
            ["Fear"] = true;
        };
    };
    [16] = {
        ["clones"] = {
            [1] = {
                ["y"] = -334.61510501455;
                ["x"] = 489.43807463015;
                ["patrol"] = {
                    [1] = {
                        ["y"] = -334.61510501455;
                        ["x"] = 489.43807463015;
                    };
                    [2] = {
                        ["y"] = -376.08020579747;
                        ["x"] = 482.37036673354;
                    };
                    [3] = {
                        ["y"] = -395.45516723723;
                        ["x"] = 412.37045932562;
                    };
                    [4] = {
                        ["y"] = -364.83021780455;
                        ["x"] = 363.62040406793;
                    };
                    [5] = {
                        ["y"] = -299.8301888311;
                        ["x"] = 362.99544943846;
                    };
                    [6] = {
                        ["y"] = -271.08023739724;
                        ["x"] = 411.74539740781;
                    };
                    [7] = {
                        ["y"] = -273.58021684761;
                        ["x"] = 466.12031255152;
                    };
                    [8] = {
                        ["y"] = -334.61510501455;
                        ["x"] = 489.43807463015;
                    };
                };
                ["sublevel"] = 2;
            };
        };
        ["characteristics"] = {
            ["Taunt"] = true;
        };
        ["scale"] = 1;
        ["spells"] = {
            [255372] = {};
            [257407] = {};
            [255434] = {};
            [255421] = {};
            [255373] = {};
            [205276] = {};
            [255445] = {};
            [255371] = {};
        };
        ["isBoss"] = true;
        ["encounterID"] = 2083;
        ["instanceID"] = 968;
        ["health"] = 5379465;
        ["count"] = 0;
        ["displayId"] = 78188;
        ["creatureType"] = "Undead";
        ["level"] = 122;
        ["name"] = "Rezan";
        ["id"] = 122963;
    };
    [17] = {
        ["clones"] = {
            [1] = {
                ["y"] = -270.38129120084;
                ["x"] = 444.52062418018;
                ["patrol"] = {};
                ["infested"] = {
                    [3] = true;
                };
                ["g"] = 25;
                ["sublevel"] = 1;
            };
        };
        ["reaping"] = 148894;
        ["scale"] = 1.2;
        ["spells"] = {
            [256846] = {};
            [277564] = {};
            [256849] = {};
            [256864] = {};
        };
        ["health"] = 1844388;
        ["count"] = 10;
        ["displayId"] = 80709;
        ["creatureType"] = "Humanoid";
        ["level"] = 121;
        ["id"] = 129553;
        ["name"] = "Dinomancer Kish'o";
    };
    [18] = {
        ["clones"] = {
            [1] = {
                ["y"] = -278.67848624537;
                ["x"] = 444.43212544974;
                ["g"] = 25;
                ["sublevel"] = 1;
            };
        };
        ["reaping"] = 148894;
        ["scale"] = 1;
        ["spells"] = {
            [277564] = {};
            [255567] = {};
        };
        ["characteristics"] = {
            ["Taunt"] = true;
        };
        ["health"] = 1536990;
        ["count"] = 6;
        ["displayId"] = 47659;
        ["creatureType"] = "Beast";
        ["level"] = 121;
        ["name"] = "T'lonja";
        ["id"] = 128455;
    };
    [19] = {
        ["clones"] = {
            [1] = {
                ["y"] = -260.604081403;
                ["x"] = 444.29744091219;
                ["g"] = 25;
                ["sublevel"] = 1;
            };
        };
        ["reaping"] = 148894;
        ["scale"] = 1;
        ["spells"] = {
            [256882] = {};
            [256884] = {};
            [277564] = {};
        };
        ["health"] = 1567730;
        ["count"] = 6;
        ["displayId"] = 76483;
        ["creatureType"] = "Beast";
        ["level"] = 121;
        ["id"] = 129552;
        ["name"] = "Monzumi";
    };
    [20] = {
        ["clones"] = {
            [1] = {
                ["y"] = -270.74025109053;
                ["x"] = 292.26608457354;
                ["sublevel"] = 1;
            };
        };
        ["scale"] = 1;
        ["characteristics"] = {
            ["Taunt"] = true;
        };
        ["spells"] = {
            [257066] = {};
            [250050] = {};
            [250022] = {};
            [249919] = {};
            [259191] = {};
            [250028] = {};
            [250096] = {};
            [259187] = {};
            [256577] = {};
        };
        ["isBoss"] = true;
        ["encounterID"] = 2030;
        ["instanceID"] = 968;
        ["id"] = 122968;
        ["count"] = 0;
        ["displayId"] = 79568;
        ["creatureType"] = "Humanoid";
        ["level"] = 122;
        ["name"] = "Yazma";
        ["health"] = 5994261;
    };
    [21] = {
        ["clones"] = {
            [1] = {
                ["y"] = -205.44525788581;
                ["x"] = 458.90792567836;
                ["sublevel"] = 1;
                ["week"] = {
                    [1] = true;
                    [10] = true;
                    [4] = true;
                    [7] = true;
                };
            };
            [2] = {
                ["y"] = -434.56037348003;
                ["x"] = 503.54399678749;
                ["sublevel"] = 1;
                ["g"] = 6;
                ["week"] = {
                    [1] = true;
                    [10] = true;
                    [4] = true;
                    [7] = true;
                };
            };
            [3] = {
                ["y"] = -347.06444907112;
                ["x"] = 573.53256517655;
                ["week"] = {
                    [1] = true;
                    [10] = true;
                    [4] = true;
                    [7] = true;
                };
                ["g"] = 1;
                ["sublevel"] = 1;
            };
            [4] = {
                ["y"] = -339.63691782877;
                ["x"] = 537.81386947478;
                ["week"] = {
                    [1] = true;
                    [10] = true;
                    [4] = true;
                    [7] = true;
                };
                ["sublevel"] = 1;
            };
            [5] = {
                ["y"] = -271.06802626929;
                ["x"] = 454.85084422261;
                ["week"] = {
                    [5] = true;
                    [2] = true;
                    [11] = true;
                    [8] = true;
                };
                ["g"] = 25;
                ["sublevel"] = 1;
            };
            [6] = {
                ["y"] = -195.23767109489;
                ["x"] = 461.47139765412;
                ["week"] = {
                    [5] = true;
                    [2] = true;
                    [11] = true;
                    [8] = true;
                };
                ["g"] = 16;
                ["sublevel"] = 1;
            };
            [7] = {
                ["y"] = -157.00850644419;
                ["x"] = 503.2806749384;
                ["week"] = {
                    [5] = true;
                    [2] = true;
                    [11] = true;
                    [8] = true;
                };
                ["g"] = 13;
                ["sublevel"] = 1;
            };
            [8] = {
                ["y"] = -368.74243091578;
                ["x"] = 567.57207937263;
                ["week"] = {
                    [5] = true;
                    [2] = true;
                    [11] = true;
                    [8] = true;
                };
                ["g"] = 2;
                ["sublevel"] = 1;
            };
            [9] = {
                ["y"] = -456.69885985073;
                ["x"] = 460.67986335652;
                ["week"] = {
                    [5] = true;
                    [2] = true;
                    [11] = true;
                    [8] = true;
                };
                ["g"] = 7;
                ["sublevel"] = 1;
            };
            [10] = {
                ["y"] = -385.98321486016;
                ["x"] = 550.81424412841;
                ["sublevel"] = 1;
                ["g"] = 4;
                ["week"] = {
                    [3] = true;
                    [6] = true;
                    [9] = true;
                    [12] = true;
                };
            };
            [11] = {
                ["y"] = -359.79386429516;
                ["x"] = 459.84183309614;
                ["sublevel"] = 1;
                ["g"] = 8;
                ["week"] = {
                    [3] = true;
                    [6] = true;
                    [9] = true;
                    [12] = true;
                };
            };
            [12] = {
                ["y"] = -340.65941771733;
                ["x"] = 534.54570477745;
                ["sublevel"] = 1;
                ["week"] = {
                    [3] = true;
                    [6] = true;
                    [9] = true;
                    [12] = true;
                };
            };
            [13] = {
                ["y"] = -218.49919597229;
                ["x"] = 459.14186309195;
                ["sublevel"] = 1;
                ["g"] = 22;
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
        ["health"] = 614795;
        ["count"] = 4;
        ["ignoreFortified"] = true;
        ["name"] = "Emissary of the Tides";
        ["displayId"] = 39391;
        ["creatureType"] = "Humanoid";
        ["level"] = 120;
        ["id"] = 155434;
        ["iconTexture"] = 132315;
    };
    [22] = {
        ["clones"] = {
            [1] = {
                ["y"] = -157.46598080656;
                ["x"] = 538.51147276124;
                ["sublevel"] = 1;
                ["g"] = 12;
                ["week"] = {
                    [1] = true;
                    [10] = true;
                    [4] = true;
                    [7] = true;
                };
            };
            [2] = {
                ["y"] = -110.37230924874;
                ["x"] = 462.91832652344;
                ["sublevel"] = 1;
                ["week"] = {
                    [1] = true;
                    [10] = true;
                    [4] = true;
                    [7] = true;
                };
            };
            [3] = {
                ["y"] = -271.44664490066;
                ["x"] = 480.83074314172;
                ["sublevel"] = 1;
                ["g"] = 30;
                ["week"] = {
                    [1] = true;
                    [10] = true;
                    [4] = true;
                    [7] = true;
                };
            };
            [4] = {
                ["y"] = -361.26843981078;
                ["x"] = 459.74169977376;
                ["sublevel"] = 1;
                ["g"] = 8;
                ["week"] = {
                    [1] = true;
                    [10] = true;
                    [4] = true;
                    [7] = true;
                };
            };
            [5] = {
                ["y"] = -420.14996461394;
                ["x"] = 561.58856814642;
                ["week"] = {
                    [1] = true;
                    [10] = true;
                    [4] = true;
                    [7] = true;
                };
                ["g"] = 5;
                ["sublevel"] = 1;
            };
            [6] = {
                ["y"] = -212.71729615347;
                ["x"] = 569.02530990563;
                ["week"] = {
                    [5] = true;
                    [2] = true;
                    [11] = true;
                    [8] = true;
                };
                ["g"] = 9;
                ["sublevel"] = 1;
            };
            [7] = {
                ["y"] = -386.14922070626;
                ["x"] = 551.26909937012;
                ["week"] = {
                    [5] = true;
                    [2] = true;
                    [11] = true;
                    [8] = true;
                };
                ["g"] = 4;
                ["sublevel"] = 1;
            };
            [8] = {
                ["y"] = -443.60628265724;
                ["x"] = 460.43620984736;
                ["week"] = {
                    [5] = true;
                    [2] = true;
                    [11] = true;
                    [8] = true;
                };
                ["sublevel"] = 1;
            };
            [9] = {
                ["y"] = -211.63272463732;
                ["x"] = 541.33898704496;
                ["sublevel"] = 1;
                ["g"] = 19;
                ["week"] = {
                    [3] = true;
                    [6] = true;
                    [9] = true;
                    [12] = true;
                };
            };
            [10] = {
                ["y"] = -291.796548553;
                ["x"] = 461.12212089003;
                ["sublevel"] = 1;
                ["g"] = 23;
                ["week"] = {
                    [3] = true;
                    [6] = true;
                    [9] = true;
                    [12] = true;
                };
            };
            [11] = {
                ["y"] = -193.4544799806;
                ["x"] = 584.69361339341;
                ["sublevel"] = 1;
                ["g"] = 10;
                ["week"] = {
                    [3] = true;
                    [6] = true;
                    [9] = true;
                    [12] = true;
                };
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
        ["health"] = 999042;
        ["count"] = 4;
        ["ignoreFortified"] = true;
        ["name"] = "Void-Touched Emissary";
        ["displayId"] = 39391;
        ["creatureType"] = "Humanoid";
        ["level"] = 122;
        ["id"] = 155433;
        ["iconTexture"] = 132886;
    };
    [23] = {
        ["clones"] = {
            [1] = {
                ["y"] = -305.24756034958;
                ["x"] = 456.08534584781;
                ["sublevel"] = 1;
                ["g"] = 23;
                ["week"] = {
                    [1] = true;
                    [10] = true;
                    [4] = true;
                    [7] = true;
                };
            };
            [2] = {
                ["y"] = -275.28612484369;
                ["x"] = 538.35169590867;
                ["week"] = {
                    [1] = true;
                    [10] = true;
                    [7] = true;
                    [4] = true;
                };
                ["g"] = 18;
                ["sublevel"] = 1;
            };
            [3] = {
                ["y"] = -386.03223385248;
                ["x"] = 552.76500707673;
                ["week"] = {
                    [1] = true;
                    [10] = true;
                    [7] = true;
                    [4] = true;
                };
                ["g"] = 4;
                ["sublevel"] = 1;
            };
            [4] = {
                ["y"] = -340.37485465888;
                ["x"] = 535.04104978441;
                ["week"] = {
                    [5] = true;
                    [2] = true;
                    [11] = true;
                    [8] = true;
                };
                ["sublevel"] = 1;
            };
            [5] = {
                ["y"] = -213.635826986;
                ["x"] = 540.77603555886;
                ["week"] = {
                    [5] = true;
                    [2] = true;
                    [11] = true;
                    [8] = true;
                };
                ["g"] = 19;
                ["sublevel"] = 1;
            };
            [6] = {
                ["y"] = -344.11734752331;
                ["x"] = 459.95071338437;
                ["week"] = {
                    [5] = true;
                    [2] = true;
                    [11] = true;
                    [8] = true;
                };
                ["sublevel"] = 1;
            };
            [7] = {
                ["y"] = -434.58659862591;
                ["x"] = 504.84566318056;
                ["week"] = {
                    [5] = true;
                    [2] = true;
                    [11] = true;
                    [8] = true;
                };
                ["g"] = 6;
                ["sublevel"] = 1;
            };
            [8] = {
                ["y"] = -420.26946718352;
                ["x"] = 561.5286884;
                ["sublevel"] = 1;
                ["g"] = 5;
                ["week"] = {
                    [3] = true;
                    [6] = true;
                    [9] = true;
                    [12] = true;
                };
            };
            [9] = {
                ["y"] = -465.79408375889;
                ["x"] = 460.41706287576;
                ["sublevel"] = 1;
                ["g"] = 7;
                ["week"] = {
                    [3] = true;
                    [6] = true;
                    [9] = true;
                    [12] = true;
                };
            };
            [10] = {
                ["y"] = -271.27285233121;
                ["x"] = 453.74159424622;
                ["sublevel"] = 1;
                ["g"] = 25;
                ["week"] = {
                    [3] = true;
                    [6] = true;
                    [9] = true;
                    [12] = true;
                };
            };
            [11] = {
                ["y"] = -195.14841136753;
                ["x"] = 461.32282222639;
                ["sublevel"] = 1;
                ["g"] = 16;
                ["week"] = {
                    [3] = true;
                    [6] = true;
                    [9] = true;
                    [12] = true;
                };
            };
            [12] = {
                ["y"] = -154.69813183134;
                ["x"] = 503.28840889817;
                ["sublevel"] = 1;
                ["g"] = 13;
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
        ["health"] = 15369884;
        ["count"] = 0;
        ["ignoreFortified"] = true;
        ["name"] = "Enchanted Emissary";
        ["displayId"] = 39391;
        ["creatureType"] = "Humanoid";
        ["level"] = 121;
        ["id"] = 155432;
        ["iconTexture"] = 135735;
    };
    [24] = {
        ["clones"] = {
            [1] = {
                ["y"] = -152.06108303925;
                ["x"] = 424.03765671461;
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
                ["y"] = -327.64783608562;
                ["x"] = 586.3970767357;
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
    [25] = {
        ["clones"] = {
            [1] = {
                ["y"] = -194.90011987361;
                ["x"] = 585.53402608042;
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
    [26] = {
        ["clones"] = {
            [1] = {
                ["y"] = -270.37840410776;
                ["x"] = 463.47681237374;
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
    [27] = {
        ["clones"] = {
            [1] = {
                ["y"] = -330.30652587834;
                ["x"] = 586.14232316491;
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
                ["y"] = -151.07859031432;
                ["x"] = 424.33261162333;
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
        ["name"] = "Voidweaver Mal'thir";
        ["scale"] = 1.4;
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
        ["characteristics"] = {
            ["Taunt"] = true;
        };
    };
};
