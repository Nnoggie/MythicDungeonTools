local MDT = MDT
local L = MDT.L
local dungeonIndex = 34
MDT.mapInfo[dungeonIndex] = {
    viewportPositionOverrides =
    {
        [1] = {
            zoomScale = 2.1999998092651;
            horizontalPan = 306.3520744598;
            verticalPan = 67.483489557154;
        };
        [3] = {
            zoomScale = 1.8999998569489;
            horizontalPan = 187.55799437121;
            verticalPan = 173.33103552728;
        };
        [4] = {
            zoomScale = 2.7999997138977;
            horizontalPan = 213.62455400331;
            verticalPan = 261.78908025446;
        };
    }
};
MDT.scaleMultiplier[dungeonIndex] = 1.3
MDT.dungeonTotalCount[dungeonIndex] = {normal=285,teeming=1000,teemingEnabled=true}
MDT.mapPOIs[dungeonIndex] = {
    [1] = {
        [1] = {
            ["y"] = -95.008076613696;
            ["x"] = 610.4211751383;
            ["connectionIndex"] = 1;
            ["target"] = 2;
            ["type"] = "mapLink";
            ["template"] = "MapLinkPinTemplate";
            ["direction"] = 1;
        };
    };
    [2] = {
        [1] = {
            ["y"] = -345.19250667244;
            ["x"] = 308.77461659958;
            ["connectionIndex"] = 1;
            ["target"] = 1;
            ["type"] = "mapLink";
            ["template"] = "MapLinkPinTemplate";
            ["direction"] = -1;
        };
        [2] = {
            ["y"] = -228.01752388311;
            ["x"] = 589.0447126466;
            ["connectionIndex"] = 2;
            ["target"] = 3;
            ["type"] = "mapLink";
            ["template"] = "MapLinkPinTemplate";
            ["direction"] = 1;
        };
    };
    [3] = {
        [1] = {
            ["y"] = -437.03235988446;
            ["x"] = 322.23401673653;
            ["connectionIndex"] = 2;
            ["target"] = 2;
            ["type"] = "mapLink";
            ["template"] = "MapLinkPinTemplate";
            ["direction"] = -1;
        };
        [2] = {
            ["y"] = -247.81058749468;
            ["x"] = 427.53313417727;
            ["connectionIndex"] = 3;
            ["target"] = 4;
            ["type"] = "mapLink";
            ["template"] = "MapLinkPinTemplate";
            ["direction"] = 1;
        };
    };
    [4] = {
        [1] = {
            ["y"] = -404.57176546128;
            ["x"] = 349.15247723985;
            ["connectionIndex"] = 3;
            ["target"] = 3;
            ["type"] = "mapLink";
            ["template"] = "MapLinkPinTemplate";
            ["direction"] = -1;
        };
    };
};

MDT.dungeonEnemies[dungeonIndex] = {}

