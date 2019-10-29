local dungeonIndex = 25
MethodDungeonTools.mapInfo[dungeonIndex] = {
    tileFormat= 15,
}
MethodDungeonTools.scaleMultiplier[dungeonIndex] = 0.7
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
                ["week"] = {
                    [1] = true;
                };
                ["sublevel"] = 1;
            };
        };
        ["scale"] = 1.4;
        ["spells"] = {
            [314477] = {};
            [314531] = {};
            [314397] = {};
            [314483] = {};
        };
        ["id"] = 161243;
        ["health"] = 1409996;
        ["level"] = 122;
        ["name"] = "Samh'rek, Beckoner of Chaos";
        ["stealthDetect"] = true;
        ["displayId"] = 90742;
        ["creatureType"] = "Aberration";
        ["corrupted"] = true;
        ["count"] = 4;
        ["characteristics"] = {
            ["Taunt"] = true;
        };
    };
    [2] = {
        ["clones"] = {
            [1] = {
                ["y"] = -171.17902897276;
                ["x"] = 545.00804819759;
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
        ["name"] = "Urg'roth, Breaker of Heroes";
        ["displayId"] = 89415;
        ["creatureType"] = "Aberration";
        ["level"] = 122;
        ["count"] = 4;
        ["health"] = 1510710;
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
            [314565] = {};
            [314592] = {};
            [314397] = {};
        };
        ["stealthDetect"] = true;
        ["characteristics"] = {
            ["Taunt"] = true;
        };
        ["scale"] = 1.4;
        ["level"] = 122;
        ["health"] = 1409996;
        ["displayId"] = 92229;
        ["creatureType"] = "Aberration";
        ["corrupted"] = true;
        ["name"] = "Blood of the Corruptor";
        ["count"] = 4;
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
            [314467] = {};
            [314397] = {};
            [314406] = {};
            [314411] = {};
        };
        ["count"] = 4;
        ["health"] = 1309282;
        ["corrupted"] = true;
        ["name"] = "Voidweaver Mal'thir";
        ["stealthDetect"] = true;
        ["displayId"] = 91910;
        ["creatureType"] = "Beast";
        ["level"] = 122;
        ["id"] = 161241;
        ["characteristics"] = {
            ["Taunt"] = true;
        };
    };
};
