local MDT = MDT
local L = MDT.L
local dungeonIndex = 35
MDT.mapInfo[dungeonIndex] = {
    viewportPositionOverrides =
    {
        [1] = {
            zoomScale = 1.2999999523163;
            horizontalPan = 56.598399501064;
            verticalPan = 48.945189206469;
        };
        [2] = {
            zoomScale = 1.5999999046326;
            horizontalPan = 168.58704071777;
            verticalPan = 134.75893682504;
        };
        [3] = {
            zoomScale = 2.1999998092651;
            horizontalPan = 227.14468128678;
            verticalPan = 144.59570926349;
        };
    }
};
MDT.scaleMultiplier[dungeonIndex] = 1.3
MDT.dungeonTotalCount[dungeonIndex] = {normal=283,teeming=1000,teemingEnabled=true}
MDT.mapPOIs[dungeonIndex] = {
    [1] = {
        [1] = {
            ["y"] = -224.85072612286;
            ["x"] = 228.01889531903;
            ["connectionIndex"] = 1;
            ["target"] = 2;
            ["type"] = "mapLink";
            ["template"] = "MapLinkPinTemplate";
            ["direction"] = 1;
        };
    };
};

MDT.dungeonEnemies[dungeonIndex] = {}