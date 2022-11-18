local MDT = MDT
local L = MDT.L
local dungeonIndex = 67
MDT.dungeonList[dungeonIndex] = L["Utgarde Pinnacle"]
MDT.mapInfo[dungeonIndex] = {
  viewportPositionOverrides =
  {
    [2] = {
      zoomScale = 1.2999999523163;
      horizontalPan = 128.65844034308;
      verticalPan = 76.137281154922;
    };
  }
};

MDT.dungeonMaps[dungeonIndex] = {
  [0] = "utgardepinnacle",
  [1] = "utgardepinnacle1_",
  [2] = "utgardepinnacle2_",
}

MDT.dungeonSubLevels[dungeonIndex] = {
  [1] = L["Lower Pinnacle"],
  [2] = L["Upper Pinnacle"],
}

MDT.dungeonTotalCount[dungeonIndex] = { normal = 300, teeming = 1000, teemingEnabled = true }

MDT.mapPOIs[dungeonIndex] = {
  [1] = {
    [1] = {
      ["template"] = "MapLinkPinTemplate";
      ["type"] = "mapLink";
      ["target"] = 2;
      ["direction"] = 1;
      ["connectionIndex"] = 1;
      ["y"] = -420.1;
      ["x"] = 242.5;
    };
    [2] = {
      ["template"] = "MapLinkPinTemplate";
      ["type"] = "mapLink";
      ["target"] = 2;
      ["direction"] = 1;
      ["connectionIndex"] = 2;
      ["y"] = -458.9;
      ["x"] = 388;
    };
    [3] = {
      ["template"] = "MapLinkPinTemplate";
      ["type"] = "mapLink";
      ["target"] = 2;
      ["direction"] = 1;
      ["connectionIndex"] = 3;
      ["y"] = -93.4;
      ["x"] = 434.8;
    };
    [4] = {
      ["template"] = "MapLinkPinTemplate";
      ["type"] = "mapLink";
      ["target"] = 2;
      ["direction"] = 1;
      ["connectionIndex"] = 4;
      ["y"] = -247.6;
      ["x"] = 366.2;
    };
  };
  [2] = {
    [1] = {
      ["template"] = "MapLinkPinTemplate";
      ["type"] = "mapLink";
      ["target"] = 1;
      ["direction"] = -1;
      ["connectionIndex"] = 1;
      ["y"] = -432.5;
      ["x"] = 344.5;
    };
    [2] = {
      ["template"] = "MapLinkPinTemplate";
      ["type"] = "mapLink";
      ["target"] = 1;
      ["direction"] = -1;
      ["connectionIndex"] = 2;
      ["y"] = -455.2;
      ["x"] = 453.4;
    };
    [3] = {
      ["template"] = "MapLinkPinTemplate";
      ["type"] = "mapLink";
      ["target"] = 1;
      ["direction"] = -1;
      ["connectionIndex"] = 3;
      ["y"] = -212.3;
      ["x"] = 488.9;
    };
    [4] = {
      ["template"] = "MapLinkPinTemplate";
      ["type"] = "mapLink";
      ["target"] = 1;
      ["direction"] = -1;
      ["connectionIndex"] = 4;
      ["y"] = -186.6;
      ["x"] = 488.6;
    };
    [5] = {
      ["template"] = "MapLinkPinTemplate";
      ["type"] = "mapLink";
      ["target"] = 1;
      ["direction"] = -1;
      ["connectionIndex"] = 5;
      ["y"] = -301;
      ["x"] = 417.9;
    };
  };
};

MDT.dungeonEnemies[dungeonIndex] = {
  [1] = {
    ["name"] = "Mindless Servant";
    ["id"] = 26536;
    ["count"] = 0;
    ["health"] = 12345;
    ["scale"] = 1;
    ["displayId"] = 7869;
    ["creatureType"] = "Undead";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["g"] = 1;
        ["sublevel"] = 2;
        ["y"] = -129.7;
        ["x"] = 396.1;
      };
      [2] = {
        ["g"] = 2;
        ["sublevel"] = 2;
        ["y"] = -142.5;
        ["x"] = 388.6;
      };
      [3] = {
        ["g"] = 3;
        ["sublevel"] = 2;
        ["y"] = -152.6;
        ["x"] = 396.5;
      };
      [4] = {
        ["g"] = 4;
        ["sublevel"] = 2;
        ["y"] = -155.9;
        ["x"] = 410.5;
      };
      [5] = {
        ["g"] = 5;
        ["sublevel"] = 2;
        ["y"] = -165;
        ["x"] = 388.2;
      };
      [6] = {
        ["g"] = 6;
        ["sublevel"] = 2;
        ["y"] = -176.1;
        ["x"] = 396.5;
      };
      [7] = {
        ["g"] = 7;
        ["sublevel"] = 2;
        ["y"] = -130.8;
        ["x"] = 345.6;
      };
      [8] = {
        ["g"] = 8;
        ["sublevel"] = 2;
        ["y"] = -152.1;
        ["x"] = 330.5;
      };
      [9] = {
        ["g"] = 9;
        ["sublevel"] = 2;
        ["y"] = -156.7;
        ["x"] = 352.5;
      };
      [10] = {
        ["g"] = 10;
        ["sublevel"] = 2;
        ["y"] = -170.1;
        ["x"] = 347.2;
      };
      [11] = {
        ["g"] = 11;
        ["sublevel"] = 2;
        ["y"] = -145.6;
        ["x"] = 356.9;
      };
      [12] = {
        ["g"] = 12;
        ["sublevel"] = 2;
        ["y"] = -179.6;
        ["x"] = 343.2;
      };
      [13] = {
        ["g"] = 13;
        ["sublevel"] = 2;
        ["y"] = -177.3;
        ["x"] = 354.7;
      };
      [14] = {
        ["g"] = 14;
        ["sublevel"] = 2;
        ["y"] = -202.9;
        ["x"] = 416.5;
      };
      [15] = {
        ["g"] = 15;
        ["sublevel"] = 2;
        ["y"] = -231.1;
        ["x"] = 400.9;
      };
      [16] = {
        ["g"] = 16;
        ["sublevel"] = 2;
        ["y"] = -213;
        ["x"] = 392.8;
      };
      [17] = {
        ["g"] = 17;
        ["sublevel"] = 2;
        ["y"] = -230.5;
        ["x"] = 344.1;
      };
    };
  };
  [2] = {
    ["name"] = "Dragonflayer Seer";
    ["id"] = 26554;
    ["count"] = 0;
    ["health"] = 12345;
    ["scale"] = 1;
    ["displayId"] = 25657;
    ["creatureType"] = "Humanoid";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["g"] = 18;
        ["sublevel"] = 2;
        ["y"] = -192.6;
        ["x"] = 369;
      };
      [2] = {
        ["g"] = 19;
        ["sublevel"] = 2;
        ["y"] = -234.1;
        ["x"] = 287.9;
      };
      [3] = {
        ["g"] = 19;
        ["sublevel"] = 2;
        ["y"] = -242.5;
        ["x"] = 286.2;
      };
      [4] = {
        ["g"] = 20;
        ["sublevel"] = 2;
        ["y"] = -279.4;
        ["x"] = 288.7;
      };
      [5] = {
        ["g"] = 21;
        ["sublevel"] = 2;
        ["y"] = -378.3;
        ["x"] = 286.5;
      };
      [6] = {
        ["g"] = 21;
        ["sublevel"] = 2;
        ["y"] = -379;
        ["x"] = 278.9;
      };
    };
  };
  [3] = {
    ["name"] = "Dragonflayer Deathseeker";
    ["id"] = 26550;
    ["count"] = 0;
    ["health"] = 12345;
    ["scale"] = 1;
    ["displayId"] = 28054;
    ["creatureType"] = "Humanoid";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["g"] = 18;
        ["sublevel"] = 2;
        ["y"] = -199.1;
        ["x"] = 375.3;
      };
      [2] = {
        ["g"] = 19;
        ["sublevel"] = 2;
        ["y"] = -238.4;
        ["x"] = 276.7;
      };
      [3] = {
        ["g"] = 20;
        ["sublevel"] = 2;
        ["y"] = -292.9;
        ["x"] = 286;
      };
      [4] = {
        ["g"] = 21;
        ["sublevel"] = 2;
        ["y"] = -386.1;
        ["x"] = 276;
      };
    };
  };
  [4] = {
    ["name"] = "Scourge Hulk";
    ["id"] = 26555;
    ["count"] = 0;
    ["health"] = 12345;
    ["scale"] = 1;
    ["displayId"] = 12818;
    ["creatureType"] = "Undead";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["g"] = 22;
        ["sublevel"] = 2;
        ["y"] = -226.1;
        ["x"] = 371.5;
      };
      [2] = {
        ["g"] = 23;
        ["sublevel"] = 2;
        ["y"] = -267.1;
        ["x"] = 266;
      };
      [3] = {
        ["g"] = 24;
        ["sublevel"] = 2;
        ["y"] = -330;
        ["x"] = 266.8;
      };
      [4] = {
        ["g"] = 25;
        ["sublevel"] = 1;
        ["y"] = -391.1;
        ["x"] = 205.9;
      };
      [5] = {
        ["g"] = 26;
        ["sublevel"] = 1;
        ["y"] = -480.2;
        ["x"] = 302.1;
      };
      [6] = {
        ["g"] = 27;
        ["sublevel"] = 2;
        ["y"] = -203.8;
        ["x"] = 467;
      };
      [7] = {
        ["g"] = 28;
        ["sublevel"] = 1;
        ["y"] = -306.7;
        ["x"] = 472.1;
      };
    };
  };
  [5] = {
    ["name"] = "Dragonflayer Fanatic";
    ["id"] = 26553;
    ["count"] = 0;
    ["health"] = 12345;
    ["scale"] = 1;
    ["displayId"] = 28056;
    ["creatureType"] = "Humanoid";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["g"] = 29;
        ["sublevel"] = 2;
        ["y"] = -212.4;
        ["x"] = 370.4;
      };
      [2] = {
        ["g"] = 30;
        ["sublevel"] = 2;
        ["y"] = -261.7;
        ["x"] = 283;
      };
      [3] = {
        ["g"] = 20;
        ["sublevel"] = 2;
        ["y"] = -286.5;
        ["x"] = 279.4;
      };
      [4] = {
        ["g"] = 21;
        ["sublevel"] = 2;
        ["y"] = -385.9;
        ["x"] = 289.4;
      };
    };
  };
  [6] = {
    ["name"] = "Svala Sorrowgrave";
    ["id"] = 26668;
    ["count"] = 0;
    ["health"] = 12345;
    ["scale"] = 1;
    ["displayId"] = 26096;
    ["creatureType"] = "Undead";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["g"] = 31;
        ["sublevel"] = 1;
        ["y"] = -391.1;
        ["x"] = 303.2;
      };
    };
  };
  [7] = {
    ["name"] = "Ymirjar Flesh Hunter";
    ["id"] = 26670;
    ["count"] = 0;
    ["health"] = 12345;
    ["scale"] = 1;
    ["displayId"] = 25240;
    ["creatureType"] = "Undead";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["g"] = 32;
        ["sublevel"] = 1;
        ["y"] = -481.2;
        ["x"] = 380.7;
      };
      [2] = {
        ["g"] = 33;
        ["sublevel"] = 2;
        ["y"] = -424;
        ["x"] = 446.8;
      };
      [3] = {
        ["g"] = 34;
        ["sublevel"] = 2;
        ["y"] = -484.6;
        ["x"] = 461.6;
      };
      [4] = {
        ["g"] = 35;
        ["sublevel"] = 2;
        ["y"] = -441.1;
        ["x"] = 510.9;
      };
      [5] = {
        ["g"] = 35;
        ["sublevel"] = 2;
        ["y"] = -429.3;
        ["x"] = 520.8;
      };
    };
  };
  [8] = {
    ["name"] = "Ymirjar Savage";
    ["id"] = 26669;
    ["count"] = 0;
    ["health"] = 12345;
    ["scale"] = 1;
    ["displayId"] = 25241;
    ["creatureType"] = "Undead";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["g"] = 36;
        ["sublevel"] = 1;
        ["y"] = -481.5;
        ["x"] = 391.6;
      };
      [2] = {
        ["g"] = 37;
        ["sublevel"] = 1;
        ["y"] = -443.4;
        ["x"] = 361.9;
      };
      [3] = {
        ["g"] = 38;
        ["sublevel"] = 1;
        ["y"] = -445.6;
        ["x"] = 351.7;
      };
      [4] = {
        ["g"] = 34;
        ["sublevel"] = 2;
        ["y"] = -475.7;
        ["x"] = 453.7;
      };
      [5] = {
        ["g"] = 35;
        ["sublevel"] = 2;
        ["y"] = -428.9;
        ["x"] = 502.6;
      };
      [6] = {
        ["g"] = 39;
        ["sublevel"] = 2;
        ["y"] = -202.6;
        ["x"] = 527.8;
      };
    };
  };
  [9] = {
    ["name"] = "Bloodthirsty Tundra Wolf";
    ["id"] = 26672;
    ["count"] = 0;
    ["health"] = 12345;
    ["scale"] = 1;
    ["displayId"] = 22089;
    ["creatureType"] = "Beast";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["g"] = 40;
        ["sublevel"] = 1;
        ["y"] = -490.5;
        ["x"] = 386.9;
      };
      [2] = {
        ["g"] = 33;
        ["sublevel"] = 2;
        ["y"] = -422.7;
        ["x"] = 443.4;
      };
      [3] = {
        ["g"] = 33;
        ["sublevel"] = 2;
        ["y"] = -426.7;
        ["x"] = 444.5;
      };
      [4] = {
        ["g"] = 34;
        ["sublevel"] = 2;
        ["y"] = -476.3;
        ["x"] = 463.1;
      };
      [5] = {
        ["g"] = 34;
        ["sublevel"] = 2;
        ["y"] = -484.1;
        ["x"] = 454.3;
      };
      [6] = {
        ["g"] = 35;
        ["sublevel"] = 2;
        ["y"] = -431.8;
        ["x"] = 510.9;
      };
    };
  };
  [10] = {
    ["name"] = "Gortok Palehoof";
    ["id"] = 26687;
    ["count"] = 0;
    ["health"] = 12345;
    ["scale"] = 1;
    ["displayId"] = 27419;
    ["creatureType"] = "Humanoid";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["g"] = 41;
        ["sublevel"] = 2;
        ["y"] = -385;
        ["x"] = 512.7;
      };
    };
  };
  [11] = {
    ["name"] = "Ymirjar Warrior";
    ["id"] = 26690;
    ["count"] = 0;
    ["health"] = 12345;
    ["scale"] = 1;
    ["displayId"] = 25240;
    ["creatureType"] = "Undead";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["g"] = 42;
        ["sublevel"] = 2;
        ["y"] = -354.2;
        ["x"] = 571.3;
      };
      [2] = {
        ["g"] = 42;
        ["sublevel"] = 2;
        ["y"] = -351.4;
        ["x"] = 582.6;
      };
      [3] = {
        ["g"] = 43;
        ["sublevel"] = 2;
        ["y"] = -324.1;
        ["x"] = 570.7;
      };
      [4] = {
        ["g"] = 43;
        ["sublevel"] = 2;
        ["y"] = -322.8;
        ["x"] = 581.7;
      };
      [5] = {
        ["g"] = 44;
        ["sublevel"] = 2;
        ["y"] = -289.6;
        ["x"] = 569.4;
      };
      [6] = {
        ["g"] = 44;
        ["sublevel"] = 2;
        ["y"] = -288;
        ["x"] = 582;
      };
      [7] = {
        ["g"] = 45;
        ["sublevel"] = 2;
        ["y"] = -258.8;
        ["x"] = 571.6;
      };
      [8] = {
        ["g"] = 45;
        ["sublevel"] = 2;
        ["y"] = -257.3;
        ["x"] = 584.2;
      };
      [9] = {
        ["g"] = 46;
        ["sublevel"] = 2;
        ["y"] = -237.8;
        ["x"] = 570.7;
      };
      [10] = {
        ["g"] = 46;
        ["sublevel"] = 2;
        ["y"] = -237.2;
        ["x"] = 582;
      };
    };
  };
  [12] = {
    ["name"] = "Ymirjar Witch Doctor";
    ["id"] = 26691;
    ["count"] = 0;
    ["health"] = 12345;
    ["scale"] = 1;
    ["displayId"] = 25243;
    ["creatureType"] = "Undead";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["g"] = 47;
        ["sublevel"] = 2;
        ["y"] = -208;
        ["x"] = 576.7;
      };
    };
  };
  [13] = {
    ["name"] = "Ymirjar Harpooner";
    ["id"] = 26692;
    ["count"] = 0;
    ["health"] = 12345;
    ["scale"] = 1;
    ["displayId"] = 25241;
    ["creatureType"] = "Undead";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["g"] = 47;
        ["sublevel"] = 2;
        ["y"] = -202.7;
        ["x"] = 583.9;
      };
      [2] = {
        ["g"] = 47;
        ["sublevel"] = 2;
        ["y"] = -201.7;
        ["x"] = 570.7;
      };
    };
  };
  [14] = {
    ["name"] = "Skadi the Ruthless";
    ["id"] = 26693;
    ["count"] = 0;
    ["health"] = 12345;
    ["scale"] = 1;
    ["displayId"] = 27418;
    ["creatureType"] = "Undead";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["g"] = 48;
        ["sublevel"] = 2;
        ["y"] = -195.7;
        ["x"] = 576.7;
      };
    };
  };
  [15] = {
    ["name"] = "Ymirjar Necromancer";
    ["id"] = 28368;
    ["count"] = 0;
    ["health"] = 12345;
    ["scale"] = 1;
    ["displayId"] = 27255;
    ["creatureType"] = "Humanoid";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["g"] = 39;
        ["sublevel"] = 2;
        ["y"] = -214;
        ["x"] = 530.9;
      };
      [2] = {
        ["g"] = 39;
        ["sublevel"] = 2;
        ["y"] = -210.7;
        ["x"] = 520;
      };
      [3] = {
        ["g"] = 49;
        ["sublevel"] = 1;
        ["y"] = -207.9;
        ["x"] = 471.8;
      };
      [4] = {
        ["g"] = 50;
        ["sublevel"] = 1;
        ["y"] = -237.5;
        ["x"] = 479;
      };
      [5] = {
        ["g"] = 50;
        ["sublevel"] = 1;
        ["y"] = -259.8;
        ["x"] = 463.5;
      };
    };
  };
  [16] = {
    ["name"] = "Ymirjar Dusk Shaman";
    ["id"] = 26694;
    ["count"] = 0;
    ["health"] = 12345;
    ["scale"] = 1;
    ["displayId"] = 25244;
    ["creatureType"] = "Undead";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["g"] = 51;
        ["sublevel"] = 1;
        ["y"] = -115.8;
        ["x"] = 470.3;
      };
      [2] = {
        ["g"] = 51;
        ["sublevel"] = 1;
        ["y"] = -122.4;
        ["x"] = 484.5;
      };
      [3] = {
        ["g"] = 49;
        ["sublevel"] = 1;
        ["y"] = -195;
        ["x"] = 478.2;
      };
      [4] = {
        ["g"] = 50;
        ["sublevel"] = 1;
        ["y"] = -236.4;
        ["x"] = 464.9;
      };
      [5] = {
        ["g"] = 50;
        ["sublevel"] = 1;
        ["y"] = -260.6;
        ["x"] = 479.3;
      };
      [6] = {
        ["g"] = 52;
        ["sublevel"] = 2;
        ["y"] = -302.9;
        ["x"] = 362.6;
      };
    };
  };
  [17] = {
    ["name"] = "Ymirjar Berserker";
    ["id"] = 26696;
    ["count"] = 0;
    ["health"] = 12345;
    ["scale"] = 1;
    ["displayId"] = 25242;
    ["creatureType"] = "Undead";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["g"] = 51;
        ["sublevel"] = 1;
        ["y"] = -106.5;
        ["x"] = 481.2;
      };
      [2] = {
        ["g"] = 49;
        ["sublevel"] = 1;
        ["y"] = -196.1;
        ["x"] = 463.8;
      };
      [3] = {
        ["g"] = 53;
        ["sublevel"] = 1;
        ["y"] = -243.6;
        ["x"] = 415.9;
      };
      [4] = {
        ["g"] = 53;
        ["sublevel"] = 1;
        ["y"] = -252.3;
        ["x"] = 415.5;
      };
      [5] = {
        ["g"] = 52;
        ["sublevel"] = 2;
        ["y"] = -297.9;
        ["x"] = 370.4;
      };
      [6] = {
        ["g"] = 52;
        ["sublevel"] = 2;
        ["y"] = -307.7;
        ["x"] = 370.7;
      };
    };
  };
  [18] = {
    ["name"] = "King Ymiron";
    ["id"] = 26861;
    ["count"] = 0;
    ["health"] = 12345;
    ["scale"] = 1;
    ["displayId"] = 28019;
    ["creatureType"] = "Undead";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["g"] = 54;
        ["sublevel"] = 2;
        ["y"] = -300.3;
        ["x"] = 330.5;
      };
    };
  };
};
