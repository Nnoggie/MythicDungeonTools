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
        };
    };
};

MethodDungeonTools.dungeonEnemies[dungeonIndex] = {
    [1] = {
        ["clones"] = {
            [1] = {
                ["y"] = -318.98442314658;
                ["x"] = 468.51035407717;
                ["sublevel"] = 1;
                ["week"] = {
                    [1] = true;
                };
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
        ["characteristics"] = {
            ["Taunt"] = true;
        };
        ["count"] = 4;
        ["corrupted"] = true;
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
                ["y"] = -171.17902897276;
                ["x"] = 545.00804819759;
                ["sublevel"] = 1;
                ["week"] = {
                    [1] = true;
                };
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
        ["health"] = 1510710;
        ["count"] = 4;
        ["level"] = 122;
        ["name"] = "Urg'roth, Breaker of Heroes";
        ["displayId"] = 89415;
        ["creatureType"] = "Aberration";
        ["corrupted"] = true;
        ["scale"] = 1.4;
        ["characteristics"] = {
            ["Taunt"] = true;
        };
    };
    [3] = {
        ["clones"] = {
            [1] = {
                ["y"] = -332.24452839227;
                ["x"] = 498.70264705052;
                ["sublevel"] = 1;
                ["week"] = {
                    [1] = true;
                };
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
        ["characteristics"] = {
            ["Taunt"] = true;
        };
        ["id"] = 161241;
        ["level"] = 122;
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
                ["y"] = -269.70057276641;
                ["x"] = 568.72046482734;
                ["sublevel"] = 1;
                ["week"] = {
                    [1] = true;
                };
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
        ["count"] = 4;
        ["name"] = "Blood of the Corruptor";
        ["corrupted"] = true;
        ["health"] = 1409996;
        ["displayId"] = 92229;
        ["creatureType"] = "Aberration";
        ["level"] = 122;
        ["scale"] = 1.4;
        ["characteristics"] = {
            ["Taunt"] = true;
        };
    };
    [5] = {
        ["clones"] = {};
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
            [1] = {
                ["y"] = -205.79982217975;
                ["x"] = 560.03006584011;
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
        ["count"] = 0;
        ["creatureType"] = "Humanoid";
        ["level"] = 120;
        ["name"] = "Pistonhead Blaster";
        ["scale"] = 1;
    };
    [7] = {
        ["clones"] = {
            [1] = {
                ["y"] = -201.91110946404;
                ["x"] = 565.31673323594;
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
            [299438] = {};
            [299450] = {};
        };
        ["health"] = 963270;
        ["count"] = 0;
        ["creatureType"] = "Humanoid";
        ["level"] = 120;
        ["name"] = "Pistonhead Scrapper";
        ["scale"] = 1;
    };
    [8] = {
        ["clones"] = {};
        ["count"] = 0;
        ["name"] = "Scrapbone Grinder";
        ["scale"] = 1;
        ["creatureType"] = "Humanoid";
        ["level"] = 120;
        ["id"] = 150143;
        ["health"] = 963270;
    };
    [9] = {
        ["clones"] = {};
        ["count"] = 0;
        ["name"] = "Scrapbone Grunter";
        ["scale"] = 1;
        ["creatureType"] = "Humanoid";
        ["level"] = 120;
        ["id"] = 150547;
        ["health"] = 481635;
    };
    [10] = {
        ["clones"] = {};
        ["count"] = 0;
        ["name"] = "Scrapbone Shaman";
        ["scale"] = 1;
        ["creatureType"] = "Humanoid";
        ["level"] = 120;
        ["id"] = 150146;
        ["health"] = 770615;
    };
    [11] = {
        ["clones"] = {};
        ["count"] = 0;
        ["name"] = "Malfunctioning Scrapbot";
        ["scale"] = 1;
        ["creatureType"] = "Mechanical";
        ["level"] = 121;
        ["id"] = 152009;
        ["health"] = 1541232;
    };
    [12] = {
        ["clones"] = {};
        ["count"] = 0;
        ["name"] = "Weaponized Crawler";
        ["scale"] = 1;
        ["creatureType"] = "Mechanical";
        ["level"] = 121;
        ["id"] = 150253;
        ["health"] = 1926540;
    };
    [13] = {
        ["clones"] = {};
        ["count"] = 0;
        ["name"] = "Scraphound";
        ["scale"] = 1;
        ["creatureType"] = "Mechanical";
        ["level"] = 120;
        ["id"] = 150254;
        ["health"] = 963270;
    };
    [14] = {
        ["clones"] = {};
        ["count"] = 0;
        ["name"] = "Pistonhead Mechanic";
        ["scale"] = 1;
        ["creatureType"] = "Humanoid";
        ["level"] = 120;
        ["id"] = 150251;
        ["health"] = 1155924;
    };
};

