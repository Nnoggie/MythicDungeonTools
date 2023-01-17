local MDT = MDT
local L = MDT.L
local dungeonIndex = 67
MDT.dungeonList[dungeonIndex] = L["Utgarde Pinnacle"]
MDT.mapInfo[dungeonIndex] = {
  viewportPositionOverrides = {
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
        ["sublevel"] = 2;
        ["y"] = -129.7;
        ["x"] = 396.1;
      };
      [2] = {
        ["sublevel"] = 2;
        ["y"] = -142.5;
        ["x"] = 388.6;
      };
      [3] = {
        ["sublevel"] = 2;
        ["y"] = -152.6;
        ["x"] = 396.5;
      };
      [4] = {
        ["sublevel"] = 2;
        ["y"] = -155.9;
        ["x"] = 410.5;
      };
      [5] = {
        ["sublevel"] = 2;
        ["y"] = -165;
        ["x"] = 388.2;
      };
      [6] = {
        ["sublevel"] = 2;
        ["y"] = -176.1;
        ["x"] = 396.5;
      };
      [7] = {
        ["sublevel"] = 2;
        ["y"] = -130.8;
        ["x"] = 345.6;
      };
      [8] = {
        ["sublevel"] = 2;
        ["y"] = -152.1;
        ["x"] = 330.5;
      };
      [9] = {
        ["sublevel"] = 2;
        ["y"] = -156.7;
        ["x"] = 352.5;
      };
      [10] = {
        ["sublevel"] = 2;
        ["y"] = -170.1;
        ["x"] = 347.2;
      };
      [11] = {
        ["sublevel"] = 2;
        ["y"] = -145.6;
        ["x"] = 356.9;
      };
      [12] = {
        ["sublevel"] = 2;
        ["y"] = -179.6;
        ["x"] = 343.2;
      };
      [13] = {
        ["sublevel"] = 2;
        ["y"] = -177.3;
        ["x"] = 354.7;
      };
      [14] = {
        ["sublevel"] = 2;
        ["y"] = -202.9;
        ["x"] = 416.5;
      };
      [15] = {
        ["sublevel"] = 2;
        ["y"] = -231.1;
        ["x"] = 400.9;
      };
      [16] = {
        ["sublevel"] = 2;
        ["y"] = -213;
        ["x"] = 392.8;
      };
      [17] = {
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
        ["sublevel"] = 2;
        ["y"] = -192.6;
        ["x"] = 369;
        ["g"] = 1;
      };
      [2] = {
        ["sublevel"] = 2;
        ["y"] = -234.1;
        ["x"] = 287.9;
        ["g"] = 2;
      };
      [3] = {
        ["sublevel"] = 2;
        ["y"] = -242.5;
        ["x"] = 286.2;
        ["g"] = 2;
      };
      [4] = {
        ["sublevel"] = 2;
        ["y"] = -279.4;
        ["x"] = 288.7;
        ["g"] = 3;
      };
      [5] = {
        ["sublevel"] = 2;
        ["y"] = -378.3;
        ["x"] = 286.5;
        ["g"] = 4;
      };
      [6] = {
        ["sublevel"] = 2;
        ["y"] = -379;
        ["x"] = 278.9;
        ["g"] = 4;
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
        ["sublevel"] = 2;
        ["y"] = -199.1;
        ["x"] = 375.3;
        ["g"] = 1;
      };
      [2] = {
        ["sublevel"] = 2;
        ["y"] = -238.4;
        ["x"] = 276.7;
        ["g"] = 2;
      };
      [3] = {
        ["sublevel"] = 2;
        ["y"] = -292.9;
        ["x"] = 286;
        ["g"] = 3;
      };
      [4] = {
        ["sublevel"] = 2;
        ["y"] = -386.1;
        ["x"] = 276;
        ["g"] = 4;
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
        ["sublevel"] = 2;
        ["y"] = -226.1;
        ["x"] = 371.5;
      };
      [2] = {
        ["sublevel"] = 2;
        ["y"] = -267.1;
        ["x"] = 266;
      };
      [3] = {
        ["sublevel"] = 2;
        ["y"] = -330;
        ["x"] = 266.8;
      };
      [4] = {
        ["sublevel"] = 1;
        ["y"] = -391.1;
        ["x"] = 205.9;
      };
      [5] = {
        ["sublevel"] = 1;
        ["y"] = -480.2;
        ["x"] = 302.1;
      };
      [6] = {
        ["sublevel"] = 2;
        ["y"] = -203.8;
        ["x"] = 467;
      };
      [7] = {
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
        ["sublevel"] = 2;
        ["y"] = -212.4;
        ["x"] = 370.4;
        ["patrol"] = {
          [1] = {
            ["y"] = -220.7;
            ["x"] = 371.5;
          };
          [2] = {
            ["y"] = -200.5;
            ["x"] = 370.1;
          };
        };
      };
      [2] = {
        ["sublevel"] = 2;
        ["y"] = -261.7;
        ["x"] = 283;
        ["patrol"] = {
          [1] = {
            ["y"] = -279.1;
            ["x"] = 282.1;
          };
          [2] = {
            ["y"] = -249.1;
            ["x"] = 281.3;
          };
        };
      };
      [3] = {
        ["sublevel"] = 2;
        ["y"] = -286.5;
        ["x"] = 279.4;
        ["g"] = 3;
      };
      [4] = {
        ["sublevel"] = 2;
        ["y"] = -385.9;
        ["x"] = 289.4;
        ["g"] = 4;
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
        ["sublevel"] = 1;
        ["y"] = -481.2;
        ["x"] = 380.7;
      };
      [2] = {
        ["sublevel"] = 2;
        ["y"] = -424;
        ["x"] = 446.8;
        ["g"] = 5;
        ["patrol"] = {
          [1] = {
            ["y"] = -459.7;
            ["x"] = 434.5;
          };
          [2] = {
            ["y"] = -451.9;
            ["x"] = 434.3;
          };
          [3] = {
            ["y"] = -428.9;
            ["x"] = 434.6;
          };
          [4] = {
            ["y"] = -424.5;
            ["x"] = 442.2;
          };
          [5] = {
            ["y"] = -424.2;
            ["x"] = 450.7;
          };
          [6] = {
            ["y"] = -428.5;
            ["x"] = 456.3;
          };
          [7] = {
            ["y"] = -442.2;
            ["x"] = 456.3;
          };
          [8] = {
            ["y"] = -456.3;
            ["x"] = 456.3;
          };
        };
      };
      [3] = {
        ["sublevel"] = 2;
        ["y"] = -484.6;
        ["x"] = 461.6;
        ["g"] = 6;
      };
      [4] = {
        ["sublevel"] = 2;
        ["y"] = -441.1;
        ["x"] = 510.9;
        ["g"] = 7;
        ["patrol"] = {
          [1] = {
            ["y"] = -390.8;
            ["x"] = 512.3;
          };
          [2] = {
            ["y"] = -480.2;
            ["x"] = 512.7;
          };
        };
      };
      [5] = {
        ["sublevel"] = 2;
        ["y"] = -429.3;
        ["x"] = 520.8;
        ["g"] = 7;
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
        ["sublevel"] = 1;
        ["y"] = -481.5;
        ["x"] = 391.6;
      };
      [2] = {
        ["sublevel"] = 1;
        ["y"] = -443.4;
        ["x"] = 361.9;
      };
      [3] = {
        ["sublevel"] = 1;
        ["y"] = -445.6;
        ["x"] = 351.7;
      };
      [4] = {
        ["sublevel"] = 2;
        ["y"] = -475.7;
        ["x"] = 453.7;
        ["g"] = 6;
      };
      [5] = {
        ["sublevel"] = 2;
        ["y"] = -428.9;
        ["x"] = 502.6;
        ["g"] = 7;
      };
      [6] = {
        ["sublevel"] = 2;
        ["y"] = -202.6;
        ["x"] = 527.8;
        ["g"] = 8;
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
        ["sublevel"] = 1;
        ["y"] = -490.5;
        ["x"] = 386.9;
      };
      [2] = {
        ["sublevel"] = 2;
        ["y"] = -422.7;
        ["x"] = 443.4;
        ["g"] = 5;
      };
      [3] = {
        ["sublevel"] = 2;
        ["y"] = -426.7;
        ["x"] = 444.5;
        ["g"] = 5;
      };
      [4] = {
        ["sublevel"] = 2;
        ["y"] = -476.3;
        ["x"] = 463.1;
        ["g"] = 6;
      };
      [5] = {
        ["sublevel"] = 2;
        ["y"] = -484.1;
        ["x"] = 454.3;
        ["g"] = 6;
      };
      [6] = {
        ["sublevel"] = 2;
        ["y"] = -431.8;
        ["x"] = 510.9;
        ["g"] = 7;
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
        ["sublevel"] = 2;
        ["y"] = -354.2;
        ["x"] = 571.3;
        ["g"] = 9;
      };
      [2] = {
        ["sublevel"] = 2;
        ["y"] = -351.4;
        ["x"] = 582.6;
        ["g"] = 9;
      };
      [3] = {
        ["sublevel"] = 2;
        ["y"] = -324.1;
        ["x"] = 570.7;
        ["g"] = 10;
      };
      [4] = {
        ["sublevel"] = 2;
        ["y"] = -322.8;
        ["x"] = 581.7;
        ["g"] = 10;
      };
      [5] = {
        ["sublevel"] = 2;
        ["y"] = -289.6;
        ["x"] = 569.4;
        ["g"] = 11;
      };
      [6] = {
        ["sublevel"] = 2;
        ["y"] = -288;
        ["x"] = 582;
        ["g"] = 11;
      };
      [7] = {
        ["sublevel"] = 2;
        ["y"] = -258.8;
        ["x"] = 571.6;
        ["g"] = 12;
      };
      [8] = {
        ["sublevel"] = 2;
        ["y"] = -257.3;
        ["x"] = 584.2;
        ["g"] = 12;
      };
      [9] = {
        ["sublevel"] = 2;
        ["y"] = -237.8;
        ["x"] = 570.7;
        ["g"] = 13;
      };
      [10] = {
        ["sublevel"] = 2;
        ["y"] = -237.2;
        ["x"] = 582;
        ["g"] = 13;
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
        ["sublevel"] = 2;
        ["y"] = -208;
        ["x"] = 576.7;
        ["g"] = 14;
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
        ["sublevel"] = 2;
        ["y"] = -202.7;
        ["x"] = 583.9;
        ["g"] = 14;
      };
      [2] = {
        ["sublevel"] = 2;
        ["y"] = -201.7;
        ["x"] = 570.7;
        ["g"] = 14;
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
        ["sublevel"] = 2;
        ["y"] = -214;
        ["x"] = 530.9;
        ["g"] = 8;
      };
      [2] = {
        ["sublevel"] = 2;
        ["y"] = -210.7;
        ["x"] = 520;
        ["g"] = 8;
      };
      [3] = {
        ["sublevel"] = 1;
        ["y"] = -207.9;
        ["x"] = 471.8;
        ["g"] = 15;
      };
      [4] = {
        ["sublevel"] = 1;
        ["y"] = -237.5;
        ["x"] = 479;
        ["g"] = 16;
      };
      [5] = {
        ["sublevel"] = 1;
        ["y"] = -259.8;
        ["x"] = 463.5;
        ["g"] = 16;
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
        ["sublevel"] = 1;
        ["y"] = -115.8;
        ["x"] = 470.3;
        ["g"] = 17;
      };
      [2] = {
        ["sublevel"] = 1;
        ["y"] = -122.4;
        ["x"] = 484.5;
        ["g"] = 17;
      };
      [3] = {
        ["sublevel"] = 1;
        ["y"] = -195;
        ["x"] = 478.2;
        ["g"] = 15;
      };
      [4] = {
        ["sublevel"] = 1;
        ["y"] = -236.4;
        ["x"] = 464.9;
        ["g"] = 16;
      };
      [5] = {
        ["sublevel"] = 1;
        ["y"] = -260.6;
        ["x"] = 479.3;
        ["g"] = 16;
      };
      [6] = {
        ["sublevel"] = 2;
        ["y"] = -302.9;
        ["x"] = 362.6;
        ["g"] = 18;
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
        ["sublevel"] = 1;
        ["y"] = -106.5;
        ["x"] = 481.2;
        ["g"] = 17;
      };
      [2] = {
        ["sublevel"] = 1;
        ["y"] = -196.1;
        ["x"] = 463.8;
        ["g"] = 15;
      };
      [3] = {
        ["sublevel"] = 1;
        ["y"] = -243.6;
        ["x"] = 415.9;
        ["g"] = 19;
        ["patrol"] = {
          [1] = {
            ["y"] = -247.6;
            ["x"] = 333.7;
          };
          [2] = {
            ["y"] = -247.9;
            ["x"] = 429.6;
          };
          [3] = {
            ["y"] = -247.9;
            ["x"] = 440.8;
          };
          [4] = {
            ["y"] = -257.3;
            ["x"] = 441.8;
          };
          [5] = {
            ["y"] = -266.7;
            ["x"] = 442.9;
          };
          [6] = {
            ["y"] = -275.3;
            ["x"] = 444;
          };
          [7] = {
            ["y"] = -278.9;
            ["x"] = 451.6;
          };
          [8] = {
            ["y"] = -280.4;
            ["x"] = 465.6;
          };
          [9] = {
            ["y"] = -280;
            ["x"] = 481.5;
          };
          [10] = {
            ["y"] = -277.5;
            ["x"] = 491.2;
          };
          [11] = {
            ["y"] = -269.6;
            ["x"] = 494.8;
          };
          [12] = {
            ["y"] = -258;
            ["x"] = 494.8;
          };
          [13] = {
            ["y"] = -246.1;
            ["x"] = 494.8;
          };
          [14] = {
            ["y"] = -234.6;
            ["x"] = 493.7;
          };
          [15] = {
            ["y"] = -226.7;
            ["x"] = 490.9;
          };
          [16] = {
            ["y"] = -221.6;
            ["x"] = 479;
          };
          [17] = {
            ["y"] = -222.4;
            ["x"] = 461.3;
          };
          [18] = {
            ["y"] = -222.7;
            ["x"] = 446.2;
          };
          [19] = {
            ["y"] = -226;
            ["x"] = 438.6;
          };
          [20] = {
            ["y"] = -241.5;
            ["x"] = 437.9;
          };
          [21] = {
            ["y"] = -240.4;
            ["x"] = 336.2;
          };
        };
      };
      [4] = {
        ["sublevel"] = 1;
        ["y"] = -252.3;
        ["x"] = 415.5;
        ["g"] = 19;
      };
      [5] = {
        ["sublevel"] = 2;
        ["y"] = -297.9;
        ["x"] = 370.4;
        ["g"] = 18;
      };
      [6] = {
        ["sublevel"] = 2;
        ["y"] = -307.7;
        ["x"] = 370.7;
        ["g"] = 18;
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
        ["sublevel"] = 2;
        ["y"] = -300.3;
        ["x"] = 330.5;
      };
    };
  };
};
