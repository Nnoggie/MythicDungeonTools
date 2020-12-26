local MDT = MDT
local L = MDT.L
local dungeonIndex = 30
MDT.mapInfo[dungeonIndex] = {
    viewportPositionOverrides =
    {
        [1] = {
            zoomScale = 1.2999999523163;
            horizontalPan = 143.9521928205;
            verticalPan = 49.148278395532;
        };
        [2] = {
            zoomScale = 1.2999999523163;
            horizontalPan = 105.03585365414;
            verticalPan = 75.538909709348;
        };
        [3] = {
            zoomScale = 1.2999999523163;
            horizontalPan = 6.4961917586812;
            verticalPan = 65.035909051372;
        };
    }
};
MDT.scaleMultiplier[dungeonIndex] = 1.3

MDT.dungeonTotalCount[dungeonIndex] = {normal=273,teeming=1000,teemingEnabled=true}
MDT.mapPOIs[dungeonIndex] = {
    [1] = {
        [1] = {
            ["y"] = -301.64783454689;
            ["x"] = 184.47462663272;
            ["connectionIndex"] = 1;
            ["target"] = 2;
            ["type"] = "mapLink";
            ["template"] = "MapLinkPinTemplate";
            ["direction"] = -2;
        };
    };
    [2] = {
        [1] = {
            ["y"] = -277.89614857732;
            ["x"] = 695.13567177537;
            ["connectionIndex"] = 1;
            ["target"] = 1;
            ["type"] = "mapLink";
            ["template"] = "MapLinkPinTemplate";
            ["direction"] = 2;
        };
        [2] = {
            ["y"] = -208.22449127413;
            ["x"] = 161.51434790935;
            ["connectionIndex"] = 2;
            ["target"] = 3;
            ["type"] = "mapLink";
            ["template"] = "MapLinkPinTemplate";
            ["direction"] = 1;
        };
    };
    [3] = {
        [1] = {
            ["y"] = -273.93754944583;
            ["x"] = 600.12888489486;
            ["connectionIndex"] = 2;
            ["target"] = 2;
            ["type"] = "mapLink";
            ["template"] = "MapLinkPinTemplate";
            ["direction"] = -1;
        };
    };
};

MDT.dungeonEnemies[dungeonIndex] = {}

