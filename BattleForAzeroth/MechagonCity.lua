local dungeonIndex = 26
MethodDungeonTools.dungeonTotalCount[dungeonIndex] = {normal=1,teeming=1,teemingEnabled=true}
MethodDungeonTools.mapPOIs[dungeonIndex] = {
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
        };
        [2] = {
            ["y"] = -398.72092416879;
            ["x"] = 397.81485177819;
            ["index"] = 1;
            ["weeks"] = {
                [1] = true;
            };
            ["type"] = "nyalothaRift";
            ["template"] = "VignettePinTemplate";
        };
    };
};

MethodDungeonTools.dungeonEnemies[dungeonIndex] = {
    [1] = {
        ["clones"] = {};
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
        ["clones"] = {};
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
                ["y"] = -387.50323117231;
                ["x"] = 416.78179277533;
                ["week"] = {
                    [1] = true;
                };
                ["sublevel"] = 3;
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
        ["clones"] = {};
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
