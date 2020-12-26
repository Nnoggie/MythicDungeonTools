local MDT = MDT
local L = MDT.L
local dungeonIndex = 33
MDT.mapInfo[dungeonIndex] = {

};

MDT.dungeonTotalCount[dungeonIndex] = {normal=364,teeming=1000,teemingEnabled=true}
MDT.mapPOIs[dungeonIndex] = {
    [1] = {
        [1] = {
            ["y"] = -496.41167079063;
            ["x"] = 387.15527024252;
            ["connectionIndex"] = 1;
            ["target"] = 2;
            ["type"] = "mapLink";
            ["template"] = "MapLinkPinTemplate";
            ["direction"] = -1;
        };
    };
    [2] = {
        [1] = {
            ["y"] = -430.69862845572;
            ["x"] = 433.07520014301;
            ["connectionIndex"] = 1;
            ["target"] = 1;
            ["type"] = "mapLink";
            ["template"] = "MapLinkPinTemplate";
            ["direction"] = 1;
        };
    };
};

MDT.dungeonEnemies[dungeonIndex] = {}


