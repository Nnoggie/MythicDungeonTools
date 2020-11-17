local MDT = MDT
local L = MDT.L
local dungeonIndex = 36
MDT.mapInfo[dungeonIndex] = {

};

MDT.dungeonTotalCount[dungeonIndex] = {normal=1000,teeming=1000,teemingEnabled=true}
MDT.mapPOIs[dungeonIndex] = {
    [1] = {
        [1] = {
            ["y"] = -256.51958712891;
            ["x"] = 425.94966734303;
            ["connectionIndex"] = 1;
            ["target"] = 2;
            ["type"] = "mapLink";
            ["template"] = "MapLinkPinTemplate";
            ["direction"] = -1;
        };
    };
    [2] = {
        [1] = {
            ["y"] = -190.01484617386;
            ["x"] = 271.56378333015;
            ["connectionIndex"] = 1;
            ["target"] = 1;
            ["type"] = "mapLink";
            ["template"] = "MapLinkPinTemplate";
            ["direction"] = 1;
        };
        [2] = {
            ["y"] = -98.174992961846;
            ["x"] = 270.7719140048;
            ["connectionIndex"] = 2;
            ["target"] = 3;
            ["type"] = "mapLink";
            ["template"] = "MapLinkPinTemplate";
            ["direction"] = 1;
        };
        [3] = {
            ["y"] = -160.7212020877;
            ["x"] = 179.72326263409;
            ["connectionIndex"] = 3;
            ["target"] = 4;
            ["type"] = "mapLink";
            ["template"] = "MapLinkPinTemplate";
            ["direction"] = -2;
        };
    };
    [3] = {
        [1] = {
            ["y"] = -513.03781749957;
            ["x"] = 601.71178789426;
            ["connectionIndex"] = 2;
            ["target"] = 2;
            ["type"] = "mapLink";
            ["template"] = "MapLinkPinTemplate";
            ["direction"] = -1;
        };
    };
    [4] = {
        [1] = {
            ["y"] = -388.73733430644;
            ["x"] = 689.5927878488;
            ["connectionIndex"] = 3;
            ["target"] = 2;
            ["type"] = "mapLink";
            ["template"] = "MapLinkPinTemplate";
            ["direction"] = 2;
        };
        [2] = {
            ["y"] = -365.77737100344;
            ["x"] = 155.17979851978;
            ["connectionIndex"] = 4;
            ["target"] = 5;
            ["type"] = "mapLink";
            ["template"] = "MapLinkPinTemplate";
            ["direction"] = 1;
        };
        [3] = {
            ["y"] = -140.92807052201;
            ["x"] = 213.76718798327;
            ["connectionIndex"] = 5;
            ["target"] = 5;
            ["type"] = "mapLink";
            ["template"] = "MapLinkPinTemplate";
            ["direction"] = -1;
        };
    };
    [5] = {
        [1] = {
            ["y"] = -123.51013920768;
            ["x"] = 212.18385705726;
            ["connectionIndex"] = 5;
            ["target"] = 4;
            ["type"] = "mapLink";
            ["template"] = "MapLinkPinTemplate";
            ["direction"] = 1;
        };
        [2] = {
            ["y"] = -330.14987688884;
            ["x"] = 144.09573454242;
            ["connectionIndex"] = 4;
            ["target"] = 4;
            ["type"] = "mapLink";
            ["template"] = "MapLinkPinTemplate";
            ["direction"] = -1;
        };
        [3] = {
            ["y"] = -472.65995527842;
            ["x"] = 543.91574181367;
            ["connectionIndex"] = 6;
            ["target"] = 4;
            ["type"] = "mapLink";
            ["template"] = "MapLinkPinTemplate";
            ["direction"] = 1;
        };
    };
};
MDT.dungeonEnemies[dungeonIndex] = {}