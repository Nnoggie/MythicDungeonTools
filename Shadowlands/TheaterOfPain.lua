local MDT = MDT
local L = MDT.L
local dungeonIndex = 36
MDT.mapInfo[dungeonIndex] = {
    viewportPositionOverrides =
    {
        [1] = {
            zoomScale = 2.1999998092651;
            horizontalPan = 233.72766555588;
            verticalPan = 188.09071841916;
        };
        [2] = {
            zoomScale = 1.2999999523163;
            horizontalPan = 118.01058420157;
            verticalPan = 57.697244781145;
        };
        [3] = {
            zoomScale = 1.2999999523163;
            horizontalPan = 175.74260337036;
            verticalPan = 62.424803754491;
        };
        [4] = {
            zoomScale = 1.2999999523163;
            horizontalPan = 124.21960940533;
            verticalPan = 75.315651737871;
        };
        [5] = {
            zoomScale = 1.2999999523163;
            horizontalPan = 68.068100349919;
            verticalPan = 76.939706850476;
        };
    }

};
MDT.scaleMultiplier[dungeonIndex] = 1.3

MDT.dungeonTotalCount[dungeonIndex] = {normal=271,teeming=1000,teemingEnabled=true}
MDT.mapPOIs[dungeonIndex] = {
    [1] = {
        [1] = {
            ["y"] = -225.03570672361;
            ["x"] = 422.3263894392;
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
        [4] = {
            ["y"] = -333.66498923535;
            ["x"] = 373.77796738459;
            ["template"] = "MapLinkPinTemplate";
            ["text"] = L["theaterOfPain_miniBossNote"];
            ["scale"] = 2;
            ["type"] = "generalNote";
        };
        [5] = {
            ["y"] = -286.77060932602;
            ["x"] = 479.7469803976;
            ["template"] = "MapLinkPinTemplate";
            ["text"] = L["theaterOfPain_miniBossNote"];
            ["scale"] = 2;
            ["type"] = "generalNote";
        };
        [6] = {
            ["y"] = -400.65690452825;
            ["x"] = 580.84404895006;
            ["template"] = "MapLinkPinTemplate";
            ["scale"] = 2;
            ["text"] = L["theaterOfPain_miniBossNote"];
            ["type"] = "generalNote";
        };
    };
    [3] = {
        [1] = {
            ["y"] = -465.53471872035;
            ["x"] = 600.91809113105;
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
