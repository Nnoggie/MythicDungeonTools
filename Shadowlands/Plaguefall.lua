local MDT = MDT
local L = MDT.L
local dungeonIndex = 32
MDT.mapInfo[dungeonIndex] = {
    viewportPositionOverrides =
    {
        [1] = {
            zoomScale = 1.2999999523163;
            horizontalPan = 115.34848613406;
            verticalPan = 37.921958997821;
        };
    }
};
MDT.scaleMultiplier[dungeonIndex] = 0.6
MDT.dungeonTotalCount[dungeonIndex] = {normal=600,teeming=1000,teemingEnabled=true}
MDT.mapPOIs[dungeonIndex] = {
    [1] = {
        [1] = {
            ["y"] = -454.01866110977;
            ["x"] = 465.69301622737;
            ["connectionIndex"] = 1;
            ["target"] = 2;
            ["direction"] = -1;
            ["template"] = "MapLinkPinTemplate";
            ["type"] = "mapLink";
        };
    };
    [2] = {
        [1] = {
            ["y"] = -243.85217912137;
            ["x"] = 465.53583053408;
            ["connectionIndex"] = 1;
            ["target"] = 1;
            ["direction"] = 1;
            ["template"] = "MapLinkPinTemplate";
            ["type"] = "mapLink";
        };
        [2] = {
            ["y"] = -270.11632931514;
            ["x"] = 441.15319581097;
            ["template"] = "MapLinkPinTemplate";
            ["text"] = L["plaguefallDevotedNote"];
            ["type"] = "generalNote";
        };
    };
};


MDT.dungeonEnemies[dungeonIndex] = {}