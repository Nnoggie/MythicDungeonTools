local dungeonIndex = 25
MethodDungeonTools.mapInfo[dungeonIndex] = {
    tileFormat= 15,
}
MethodDungeonTools.scaleMultiplier[dungeonIndex] = 0.5
MethodDungeonTools.dungeonTotalCount[dungeonIndex] = {normal=1,teeming=1,teemingEnabled=true}
MethodDungeonTools.mapPOIs[dungeonIndex] = {
    [1] = {
        [1] = {
            ["y"] = -171.08871963681;
            ["x"] = 534.16284039491;
            ["index"] = 1;
            ["weeks"] = {
                [1] = true;
            };
            ["scale"] = 0.7;
            ["type"] = "nyalothaSpire";
            ["template"] = "VignettePinTemplate";
            ["tooltipText"] = "Brutal Spire of Ny'alotha";
            ["npcId"] = 161124;
        };
        [2] = {
            ["y"] = -179.39160039295;
            ["x"] = 535.1063453386;
            ["index"] = 1;
            ["weeks"] = {
                [1] = true;
            };
            ["scale"] = 0.7;
            ["type"] = "nyalothaRift";
            ["template"] = "VignettePinTemplate";
            ["npcId"] = 161124;
        };
        [3] = {
            ["y"] = -268.62227619884;
            ["x"] = 576.11449654476;
            ["index"] = 2;
            ["weeks"] = {
                [1] = true;
            };
            ["scale"] = 0.7;
            ["type"] = "nyalothaSpire";
            ["template"] = "VignettePinTemplate";
            ["tooltipText"] = "Defiled Spire of Ny'alotha";
            ["npcId"] = 161244;
        };
        [4] = {
            ["y"] = -277.24864873942;
            ["x"] = 577.03873563519;
            ["index"] = 2;
            ["weeks"] = {
                [1] = true;
            };
            ["scale"] = 0.7;
            ["type"] = "nyalothaRift";
            ["template"] = "VignettePinTemplate";
            ["npcId"] = 161244;
        };
        [5] = {
            ["y"] = -331.72106675023;
            ["x"] = 511.63147296771;
            ["index"] = 3;
            ["weeks"] = {
                [1] = true;
            };
            ["scale"] = 0.7;
            ["type"] = "nyalothaSpire";
            ["template"] = "VignettePinTemplate";
            ["tooltipText"] = "Cursed Spire of Ny'alotha";
            ["npcId"] = 161241;
        };
        [6] = {
            ["y"] = -341.62791724812;
            ["x"] = 511.63147296771;
            ["index"] = 3;
            ["weeks"] = {
                [1] = true;
            };
            ["scale"] = 0.7;
            ["type"] = "nyalothaRift";
            ["template"] = "VignettePinTemplate";
            ["npcId"] = 161241;
        };
        [7] = {
            ["y"] = -319.9773227567;
            ["x"] = 460.36406709732;
            ["index"] = 4;
            ["weeks"] = {
                [1] = true;
            };
            ["scale"] = 0.7;
            ["type"] = "nyalothaSpire";
            ["template"] = "VignettePinTemplate";
            ["tooltipText"] = "Entropic Spire of Ny'alotha";
            ["npcId"] = 161243;
        };
        [8] = {
            ["y"] = -312.02126661313;
            ["x"] = 457.91602961897;
            ["index"] = 4;
            ["weeks"] = {
                [1] = true;
            };
            ["scale"] = 0.7;
            ["type"] = "nyalothaRift";
            ["template"] = "VignettePinTemplate";
            ["npcId"] = 161243;
        };
    };
};

MethodDungeonTools.dungeonEnemies[dungeonIndex] = {
    [1] = {
        ["clones"] = {
            [1] = {
                ["y"] = -318.98442314658;
                ["x"] = 468.51035407717;
                ["week"] = {
                    [1] = true;
                };
                ["sublevel"] = 1;
            };
        };
        ["scale"] = 1.4;
        ["spells"] = {
            [314483] = {};
            [314477] = {};
            [314397] = {};
            [314531] = {};
        };
        ["stealthDetect"] = true;
        ["id"] = 161243;
        ["count"] = 4;
        ["level"] = 122;
        ["health"] = 1409996;
        ["displayId"] = 90742;
        ["creatureType"] = "Aberration";
        ["corrupted"] = true;
        ["name"] = "Samh'rek, Beckoner of Chaos";
        ["characteristics"] = {
            ["Taunt"] = true;
        };
    };
    [2] = {
        ["clones"] = {
            [1] = {
                ["y"] = -166.12796615062;
                ["x"] = 540.19127327952;
                ["week"] = {
                    [1] = true;
                };
                ["sublevel"] = 1;
            };
        };
        ["id"] = 161124;
        ["spells"] = {
            [314308] = {};
            [314387] = {};
            [314397] = {};
            [314309] = {};
        };
        ["stealthDetect"] = true;
        ["characteristics"] = {
            ["Taunt"] = true;
        };
        ["scale"] = 1.4;
        ["corrupted"] = true;
        ["count"] = 4;
        ["displayId"] = 89415;
        ["creatureType"] = "Aberration";
        ["level"] = 122;
        ["health"] = 1510710;
        ["name"] = "Urg'roth, Breaker of Heroes";
    };
    [3] = {
        ["clones"] = {
            [1] = {
                ["y"] = -332.24452839227;
                ["x"] = 498.70264705052;
                ["week"] = {
                    [1] = true;
                };
                ["sublevel"] = 1;
            };
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
        ["name"] = "Voidweaver Mal'thir";
        ["count"] = 4;
        ["corrupted"] = true;
        ["health"] = 1309282;
        ["displayId"] = 91910;
        ["creatureType"] = "Beast";
        ["level"] = 122;
        ["id"] = 161241;
        ["characteristics"] = {
            ["Taunt"] = true;
        };
    };
    [4] = {
        ["clones"] = {
            [1] = {
                ["y"] = -269.70057276641;
                ["x"] = 568.72046482734;
                ["week"] = {
                    [1] = true;
                };
                ["sublevel"] = 1;
            };
        };
        ["id"] = 161244;
        ["spells"] = {
            [314566] = {};
            [314397] = {};
            [314565] = {};
            [314592] = {};
        };
        ["stealthDetect"] = true;
        ["characteristics"] = {
            ["Taunt"] = true;
        };
        ["scale"] = 1.4;
        ["level"] = 122;
        ["name"] = "Blood of the Corruptor";
        ["displayId"] = 92229;
        ["creatureType"] = "Aberration";
        ["corrupted"] = true;
        ["count"] = 4;
        ["health"] = 1409996;
    };
    [5] = {
        ["clones"] = {
            [1] = {
                ["y"] = -181.87659380495;
                ["x"] = 552.1773231261;
                ["sublevel"] = 1;
            };
            [2] = {
                ["y"] = -153.34373468744;
                ["x"] = 529.02014124393;
                ["sublevel"] = 1;
            };
        };
        ["count"] = 0;
        ["name"] = "Scrapbone Trashtosser";
        ["scale"] = 1;
        ["creatureType"] = "Humanoid";
        ["level"] = 120;
        ["id"] = 150142;
        ["health"] = 963270;
    };
    [6] = {
        ["clones"] = {
            [2] = {
                ["y"] = -240.81896141444;
                ["x"] = 547.77418485574;
                ["sublevel"] = 1;
            };
            [3] = {
                ["y"] = -226.15432744751;
                ["x"] = 592.99529121945;
                ["patrol"] = {};
                ["sublevel"] = 1;
            };
            [1] = {
                ["y"] = -203.38927725206;
                ["x"] = 560.53755815285;
                ["sublevel"] = 1;
            };
            [4] = {
                ["y"] = -242.72956387454;
                ["x"] = 565.78107003679;
                ["patrol"] = {};
                ["sublevel"] = 1;
            };
            [5] = {
                ["y"] = -217.28167920159;
                ["x"] = 571.15019155487;
                ["patrol"] = {};
                ["sublevel"] = 1;
            };
        };
        ["id"] = 150250;
        ["spells"] = {
            [299497] = {};
            [299525] = {};
            [299496] = {};
            [299460] = {};
        };
        ["health"] = 963270;
        ["scale"] = 1;
        ["creatureType"] = "Humanoid";
        ["level"] = 120;
        ["name"] = "Pistonhead Blaster";
        ["count"] = 0;
    };
    [7] = {
        ["clones"] = {
            [1] = {
                ["y"] = -201.65738508659;
                ["x"] = 564.4286325781;
                ["sublevel"] = 1;
            };
            [2] = {
                ["y"] = -200.26427177988;
                ["x"] = 557.21972533765;
                ["sublevel"] = 1;
            };
        };
        ["id"] = 150249;
        ["spells"] = {
            [299449] = {};
            [299450] = {};
            [299438] = {};
        };
        ["health"] = 963270;
        ["scale"] = 1;
        ["creatureType"] = "Humanoid";
        ["level"] = 120;
        ["name"] = "Pistonhead Scrapper";
        ["count"] = 0;
    };
    [8] = {
        ["clones"] = {
            [1] = {
                ["y"] = -188.11587792557;
                ["x"] = 557.60039371291;
                ["sublevel"] = 1;
            };
            [2] = {
                ["y"] = -179.4615094382;
                ["x"] = 549.9072449786;
                ["sublevel"] = 1;
            };
            [3] = {
                ["y"] = -157.82264523035;
                ["x"] = 527.38594408375;
                ["sublevel"] = 1;
            };
            [4] = {
                ["y"] = -156.30950904337;
                ["x"] = 530.41223204262;
                ["sublevel"] = 1;
            };
        };
        ["count"] = 0;
        ["name"] = "Scrapbone Grinder";
        ["scale"] = 1;
        ["creatureType"] = "Humanoid";
        ["level"] = 120;
        ["id"] = 150143;
        ["health"] = 963270;
    };
    [9] = {
        ["clones"] = {
            [1] = {
                ["y"] = -187.19187034679;
                ["x"] = 551.70952719246;
                ["sublevel"] = 1;
            };
            [2] = {
                ["y"] = -190.16901101777;
                ["x"] = 554.37912032828;
                ["sublevel"] = 1;
            };
            [3] = {
                ["y"] = -185.23200898666;
                ["x"] = 554.55706293872;
                ["sublevel"] = 1;
            };
            [4] = {
                ["y"] = -182.66190060721;
                ["x"] = 556.76324098132;
                ["sublevel"] = 1;
            };
            [5] = {
                ["y"] = -183.46818607884;
                ["x"] = 547.63715900943;
                ["sublevel"] = 1;
            };
            [6] = {
                ["y"] = -178.042159654;
                ["x"] = 554.26844197122;
                ["sublevel"] = 1;
            };
            [7] = {
                ["y"] = -170.13425721685;
                ["x"] = 544.8096957734;
                ["sublevel"] = 1;
            };
            [8] = {
                ["y"] = -178.23098106085;
                ["x"] = 542.1107921026;
                ["sublevel"] = 1;
            };
            [9] = {
                ["y"] = -177.1813980966;
                ["x"] = 537.6126235222;
                ["sublevel"] = 1;
            };
            [10] = {
                ["y"] = -174.89234462027;
                ["x"] = 540.22666814206;
                ["sublevel"] = 1;
            };
            [11] = {
                ["y"] = -182.61237739078;
                ["x"] = 533.50146781395;
                ["sublevel"] = 1;
            };
            [12] = {
                ["y"] = -176.9783699962;
                ["x"] = 529.81027958851;
                ["sublevel"] = 1;
            };
            [13] = {
                ["y"] = -173.71595739064;
                ["x"] = 524.15546591846;
                ["sublevel"] = 1;
            };
            [14] = {
                ["y"] = -165.45341420397;
                ["x"] = 527.91463263425;
                ["sublevel"] = 1;
            };
            [15] = {
                ["y"] = -162.22915846883;
                ["x"] = 526.76515192795;
                ["sublevel"] = 1;
            };
        };
        ["count"] = 0;
        ["name"] = "Scrapbone Grunter";
        ["scale"] = 0.6;
        ["creatureType"] = "Humanoid";
        ["level"] = 120;
        ["id"] = 150547;
        ["health"] = 481635;
    };
    [10] = {
        ["clones"] = {
            [1] = {
                ["y"] = -186.65920121865;
                ["x"] = 560.21127274646;
                ["sublevel"] = 1;
            };
            [2] = {
                ["y"] = -154.37267633384;
                ["x"] = 525.20701800016;
                ["sublevel"] = 1;
            };
        };
        ["count"] = 0;
        ["name"] = "Scrapbone Shaman";
        ["scale"] = 1;
        ["creatureType"] = "Humanoid";
        ["level"] = 120;
        ["id"] = 150146;
        ["health"] = 770615;
    };
    [11] = {
        ["clones"] = {
            [1] = {
                ["y"] = -182.87140315281;
                ["x"] = 525.64240251319;
                ["sublevel"] = 1;
            };
        };
        ["count"] = 0;
        ["name"] = "Malfunctioning Scrapbot";
        ["scale"] = 1.2;
        ["creatureType"] = "Mechanical";
        ["level"] = 121;
        ["id"] = 152009;
        ["health"] = 1541232;
    };
    [12] = {
        ["clones"] = {
            [1] = {
                ["y"] = -223.46513333378;
                ["x"] = 554.22812127344;
                ["patrol"] = {
                    [7] = {
                        ["y"] = -233.64794734362;
                        ["x"] = 561.11226229104;
                    };
                    [1] = {
                        ["y"] = -223.46513333378;
                        ["x"] = 554.22812127344;
                    };
                    [2] = {
                        ["y"] = -212.13497391121;
                        ["x"] = 557.23992424195;
                    };
                    [4] = {
                        ["y"] = -229.48877194659;
                        ["x"] = 552.07680273988;
                    };
                    [8] = {
                        ["y"] = -231.06638659258;
                        ["x"] = 567.70956437785;
                    };
                    [9] = {
                        ["y"] = -233.64794734362;
                        ["x"] = 561.11226229104;
                    };
                    [5] = {
                        ["y"] = -233.79136294013;
                        ["x"] = 548.9215734479;
                    };
                    [10] = {
                        ["y"] = -235.22556814452;
                        ["x"] = 555.08862259027;
                    };
                    [3] = {
                        ["y"] = -223.46513333378;
                        ["x"] = 554.22812127344;
                    };
                    [6] = {
                        ["y"] = -235.22556814452;
                        ["x"] = 555.08862259027;
                    };
                    [12] = {
                        ["y"] = -229.48877194659;
                        ["x"] = 552.07680273988;
                    };
                    [11] = {
                        ["y"] = -233.79136294013;
                        ["x"] = 548.9215734479;
                    };
                };
                ["sublevel"] = 1;
            };
        };
        ["count"] = 0;
        ["name"] = "Weaponized Crawler";
        ["scale"] = 1.4;
        ["creatureType"] = "Mechanical";
        ["level"] = 121;
        ["id"] = 150253;
        ["health"] = 1926540;
    };
    [13] = {
        ["clones"] = {
            [6] = {
                ["y"] = -220.76810305001;
                ["x"] = 568.58953129542;
                ["sublevel"] = 1;
            };
            [2] = {
                ["y"] = -229.27239013254;
                ["x"] = 590.89104111179;
                ["sublevel"] = 1;
            };
            [3] = {
                ["y"] = -228.907330927;
                ["x"] = 596.19947893282;
                ["sublevel"] = 1;
            };
            [1] = {
                ["y"] = -236.94661721044;
                ["x"] = 546.33997965134;
                ["sublevel"] = 1;
            };
            [4] = {
                ["y"] = -245.51974655664;
                ["x"] = 563.34296181174;
                ["sublevel"] = 1;
            };
            [5] = {
                ["y"] = -244.99563496274;
                ["x"] = 568.45392403551;
                ["sublevel"] = 1;
            };
            [7] = {
                ["y"] = -220.45779466099;
                ["x"] = 573.73179136162;
                ["sublevel"] = 1;
            };
        };
        ["count"] = 0;
        ["name"] = "Scraphound";
        ["scale"] = 1;
        ["creatureType"] = "Mechanical";
        ["level"] = 120;
        ["id"] = 150254;
        ["health"] = 963270;
    };
    [14] = {
        ["clones"] = {
            [1] = {
                ["y"] = -240.10185881224;
                ["x"] = 551.35969171181;
                ["sublevel"] = 1;
            };
        };
        ["id"] = 150251;
        ["spells"] = {
            [299588] = {};
        };
        ["health"] = 1155924;
        ["count"] = 0;
        ["creatureType"] = "Humanoid";
        ["level"] = 120;
        ["name"] = "Pistonhead Mechanic";
        ["scale"] = 1;
    };
    [15] = {
        ["clones"] = {};
        ["count"] = 0;
        ["name"] = "Saurolisk Bonenipper";
        ["scale"] = 1;
        ["creatureType"] = "Beast";
        ["level"] = 120;
        ["id"] = 150154;
        ["health"] = 1498565;
    };
    [16] = {
        ["clones"] = {
            [1] = {
                ["y"] = -173.58251446884;
                ["x"] = 549.36739092281;
                ["sublevel"] = 1;
            };
        };
        ["id"] = 150160;
        ["spells"] = {
            [300434] = {};
        };
        ["health"] = 2397704;
        ["count"] = 0;
        ["creatureType"] = "Humanoid";
        ["level"] = 121;
        ["name"] = "Scrapbone Bully";
        ["scale"] = 1.4;
    };
    [17] = {
        ["clones"] = {};
        ["id"] = 150276;
        ["spells"] = {
            [300159] = {};
        };
        ["health"] = 2176378;
        ["count"] = 0;
        ["creatureType"] = "Mechanical";
        ["level"] = 121;
        ["name"] = "Heavy Scrapbot";
        ["scale"] = 1;
    };
    [18] = {
        ["clones"] = {};
        ["count"] = 0;
        ["name"] = "Naeno Megacrash";
        ["scale"] = 1;
        ["creatureType"] = "Humanoid";
        ["level"] = 122;
        ["id"] = 153755;
        ["health"] = 4080708;
    };
    [19] = {
        ["clones"] = {};
        ["count"] = 0;
        ["name"] = "Trixie Tazer";
        ["scale"] = 1;
        ["creatureType"] = "Humanoid";
        ["level"] = 122;
        ["id"] = 150712;
        ["health"] = 4896850;
    };
    [20] = {
        ["clones"] = {};
        ["count"] = 0;
        ["name"] = "Walkie Shockie X1";
        ["scale"] = 1;
        ["creatureType"] = "Mechanical";
        ["level"] = 120;
        ["id"] = 152703;
        ["health"] = 68012;
    };
};




