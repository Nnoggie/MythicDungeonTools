local MDT = MDT
local L = MDT.L
local dungeonIndex = 29
MDT.mapInfo[dungeonIndex] = {
    viewportPositionOverrides =
    {
        [1] = {
            zoomScale = 1.2999999523163;
            horizontalPan = 102.41712541524;
            verticalPan = 87.49594729527;
        };
        [2] = {
            zoomScale = 1.2999999523163;
            horizontalPan = 121.73863775574;
            verticalPan = 90.409493722852;
        };
        [3] = {
            zoomScale = 1.2999999523163;
            horizontalPan = 147.68724111862;
            verticalPan = 54.40608486673;
        };
        [4] = {
            zoomScale = 1.5999999046326;
            horizontalPan = 230.48191107345;
            verticalPan = 84.302357414492;
        };
    }

};
MDT.scaleMultiplier[dungeonIndex] = 1.3
MDT.dungeonTotalCount[dungeonIndex] = {normal=384,teeming=1000,teemingEnabled=true}
MDT.mapPOIs[dungeonIndex] = {
    [1] = {
        [1] = {
            ["y"] = -496.78200170972;
            ["x"] = 425.34581434668;
            ["connectionIndex"] = 1;
            ["target"] = 2;
            ["type"] = "mapLink";
            ["template"] = "MapLinkPinTemplate";
            ["direction"] = -1;
        };
        [2] = {
            ["y"] = -321.44105600137;
            ["x"] = 609.62984287316;
            ["connectionIndex"] = 2;
            ["target"] = 4;
            ["type"] = "mapLink";
            ["template"] = "MapLinkPinTemplate";
            ["direction"] = 2;
        };
        [3] = {
            ["y"] = -323.0244548815;
            ["x"] = 233.5615662991;
            ["connectionIndex"] = 3;
            ["target"] = 3;
            ["type"] = "mapLink";
            ["template"] = "MapLinkPinTemplate";
            ["direction"] = -2;
        };
    };
    [2] = {
        [1] = {
            ["y"] = -129.05231596606;
            ["x"] = 414.86600451766;
            ["connectionIndex"] = 1;
            ["target"] = 1;
            ["type"] = "mapLink";
            ["template"] = "MapLinkPinTemplate";
            ["direction"] = 1;
        };
    };
    [3] = {
        [1] = {
            ["y"] = -269.18739796662;
            ["x"] = 697.51109695369;
            ["connectionIndex"] = 3;
            ["target"] = 1;
            ["type"] = "mapLink";
            ["template"] = "MapLinkPinTemplate";
            ["direction"] = 2;
        };
    };
    [4] = {
        [1] = {
            ["y"] = -327.26341521812;
            ["x"] = 283.13229583992;
            ["connectionIndex"] = 2;
            ["target"] = 1;
            ["type"] = "mapLink";
            ["template"] = "MapLinkPinTemplate";
            ["direction"] = -2;
        };
    };
};
MDT.dungeonEnemies[dungeonIndex] = {}

