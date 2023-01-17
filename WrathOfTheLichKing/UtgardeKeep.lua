local MDT = MDT
local L = MDT.L
local dungeonIndex = 66
MDT.dungeonList[dungeonIndex] = L["Utgarde Keep"]
MDT.mapInfo[dungeonIndex] = {
  viewportPositionOverrides = {
    [2] = {
      zoomScale = 1.2999999523163;
      horizontalPan = 119.65419227667;
      verticalPan = 70.865069636615;
    };
    [3] = {
      zoomScale = 1.5999999046326;
      horizontalPan = 185.59290528023;
      verticalPan = 30.602843054018;
    };
  }
};

MDT.dungeonMaps[dungeonIndex] = {
  [0] = "utgardekeep",
  [1] = "utgardekeep1_",
  [2] = "utgardekeep2_",
  [3] = "utgardekeep3_",
}

MDT.dungeonSubLevels[dungeonIndex] = {
  [1] = L["Njorndir Preparation"],
  [2] = L["Dragonflayer Ascent"],
  [3] = L["Tyr's Terrace"],
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
      ["y"] = -476.5;
      ["x"] = 416.6;
    };
  };
  [2] = {
    [1] = {
      ["template"] = "MapLinkPinTemplate";
      ["type"] = "mapLink";
      ["target"] = 1;
      ["direction"] = -1;
      ["connectionIndex"] = 1;
      ["y"] = -359.4;
      ["x"] = 293.9;
    };
    [2] = {
      ["template"] = "MapLinkPinTemplate";
      ["type"] = "mapLink";
      ["target"] = 3;
      ["direction"] = 1;
      ["connectionIndex"] = 2;
      ["y"] = -164.7;
      ["x"] = 459.1;
    };
  };
  [3] = {
    [1] = {
      ["template"] = "MapLinkPinTemplate";
      ["type"] = "mapLink";
      ["target"] = 2;
      ["direction"] = -1;
      ["connectionIndex"] = 1;
      ["y"] = -253;
      ["x"] = 283.7;
    };
  };
};

MDT.dungeonEnemies[dungeonIndex] = {
  [1] = {
    ["name"] = "Dragonflayer Ironhelm";
    ["id"] = 23961;
    ["count"] = 0;
    ["health"] = 12345;
    ["scale"] = 1;
    ["displayId"] = 22281;
    ["creatureType"] = "Humanoid";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["sublevel"] = 1;
        ["y"] = -347.8;
        ["x"] = 554.6;
        ["g"] = 1;
      };
      [2] = {
        ["sublevel"] = 1;
        ["y"] = -344.2;
        ["x"] = 565.5;
        ["g"] = 1;
      };
      [3] = {
        ["sublevel"] = 1;
        ["y"] = -337.6;
        ["x"] = 254.6;
        ["g"] = 2;
      };
      [4] = {
        ["sublevel"] = 1;
        ["y"] = -431.7;
        ["x"] = 393.9;
        ["g"] = 3;
      };
      [5] = {
        ["sublevel"] = 2;
        ["y"] = -370.5;
        ["x"] = 321.5;
        ["g"] = 4;
      };
    };
  };
  [2] = {
    ["name"] = "Dragonflayer Weaponsmith";
    ["id"] = 24080;
    ["count"] = 0;
    ["health"] = 12345;
    ["scale"] = 1;
    ["displayId"] = 22279;
    ["creatureType"] = "Humanoid";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["sublevel"] = 1;
        ["y"] = -291.9;
        ["x"] = 522.6;
        ["g"] = 5;
      };
      [2] = {
        ["sublevel"] = 1;
        ["y"] = -304.5;
        ["x"] = 522.9;
        ["g"] = 5;
      };
      [3] = {
        ["sublevel"] = 1;
        ["y"] = -276.8;
        ["x"] = 562.9;
        ["g"] = 6;
      };
      [4] = {
        ["sublevel"] = 1;
        ["y"] = -254.4;
        ["x"] = 524;
        ["patrol"] = {
          [1] = {
            ["y"] = -262;
            ["x"] = 526.2;
          };
          [2] = {
            ["y"] = -244;
            ["x"] = 520.8;
          };
          [3] = {
            ["y"] = -222.4;
            ["x"] = 529.4;
          };
          [4] = {
            ["y"] = -210.5;
            ["x"] = 544.9;
          };
          [5] = {
            ["y"] = -191;
            ["x"] = 555.4;
          };
        };
      };
    };
  };
  [3] = {
    ["name"] = "Dragonflayer Metalworker";
    ["id"] = 24078;
    ["count"] = 0;
    ["health"] = 12345;
    ["scale"] = 1;
    ["displayId"] = 22285;
    ["creatureType"] = "Humanoid";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["sublevel"] = 1;
        ["y"] = -295.9;
        ["x"] = 531.6;
        ["g"] = 5;
      };
      [2] = {
        ["sublevel"] = 1;
        ["y"] = -301.3;
        ["x"] = 516.1;
        ["g"] = 5;
      };
      [3] = {
        ["sublevel"] = 1;
        ["y"] = -283.3;
        ["x"] = 555.4;
        ["g"] = 6;
      };
      [4] = {
        ["sublevel"] = 1;
        ["y"] = -282.2;
        ["x"] = 570.1;
        ["g"] = 6;
      };
      [5] = {
        ["sublevel"] = 1;
        ["y"] = -171.9;
        ["x"] = 550.7;
        ["g"] = 7;
      };
      [6] = {
        ["sublevel"] = 1;
        ["y"] = -182;
        ["x"] = 566.2;
        ["g"] = 7;
      };
      [7] = {
        ["sublevel"] = 1;
        ["y"] = -137;
        ["x"] = 504.6;
        ["g"] = 8;
      };
      [8] = {
        ["sublevel"] = 1;
        ["y"] = -141.6;
        ["x"] = 534;
        ["g"] = 8;
      };
      [9] = {
        ["sublevel"] = 1;
        ["y"] = -198.3;
        ["x"] = 478.6;
        ["g"] = 9;
      };
      [10] = {
        ["sublevel"] = 1;
        ["y"] = -191.7;
        ["x"] = 462.4;
        ["g"] = 9;
      };
    };
  };
  [4] = {
    ["name"] = "Dragonflayer Forge Master";
    ["id"] = 24079;
    ["count"] = 0;
    ["health"] = 12345;
    ["scale"] = 1;
    ["displayId"] = 22283;
    ["creatureType"] = "Humanoid";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["sublevel"] = 1;
        ["y"] = -188.5;
        ["x"] = 534.1;
        ["g"] = 7;
      };
      [2] = {
        ["sublevel"] = 1;
        ["y"] = -153.2;
        ["x"] = 517.1;
        ["g"] = 8;
      };
      [3] = {
        ["sublevel"] = 1;
        ["y"] = -184.6;
        ["x"] = 474;
        ["g"] = 9;
      };
    };
  };
  [5] = {
    ["name"] = "Proto-Drake Handler";
    ["id"] = 24082;
    ["count"] = 0;
    ["health"] = 12345;
    ["scale"] = 1;
    ["displayId"] = 22287;
    ["creatureType"] = "Humanoid";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["sublevel"] = 1;
        ["y"] = -132.4;
        ["x"] = 308.1;
        ["g"] = 10;
      };
      [2] = {
        ["sublevel"] = 1;
        ["y"] = -197.7;
        ["x"] = 317.5;
        ["g"] = 11;
      };
      [3] = {
        ["sublevel"] = 1;
        ["y"] = -144.9;
        ["x"] = 266.1;
        ["g"] = 12;
      };
      [4] = {
        ["sublevel"] = 1;
        ["y"] = -207.1;
        ["x"] = 246;
        ["g"] = 13;
      };
      [5] = {
        ["sublevel"] = 1;
        ["y"] = -217.1;
        ["x"] = 239.1;
        ["g"] = 13;
      };
    };
  };
  [6] = {
    ["name"] = "Enslaved Proto-Drake";
    ["id"] = 24083;
    ["count"] = 0;
    ["health"] = 12345;
    ["scale"] = 1;
    ["displayId"] = 24874;
    ["creatureType"] = "Dragonkin";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["sublevel"] = 1;
        ["y"] = -126.8;
        ["x"] = 292.4;
        ["g"] = 10;
      };
      [2] = {
        ["sublevel"] = 1;
        ["y"] = -202.7;
        ["x"] = 372.1;
      };
      [3] = {
        ["sublevel"] = 1;
        ["y"] = -190.8;
        ["x"] = 321.3;
        ["g"] = 11;
      };
      [4] = {
        ["sublevel"] = 1;
        ["y"] = -153.1;
        ["x"] = 261;
        ["g"] = 12;
      };
      [5] = {
        ["sublevel"] = 1;
        ["y"] = -231.5;
        ["x"] = 293;
      };
      [6] = {
        ["sublevel"] = 1;
        ["y"] = -206.4;
        ["x"] = 234;
        ["g"] = 13;
      };
      [7] = {
        ["sublevel"] = 3;
        ["y"] = -202.2;
        ["x"] = 436.8;
        ["g"] = 14;
      };
    };
  };
  [7] = {
    ["name"] = "Dragonflayer Runecaster";
    ["id"] = 23960;
    ["count"] = 0;
    ["health"] = 12345;
    ["scale"] = 1;
    ["displayId"] = 22289;
    ["creatureType"] = "Humanoid";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["sublevel"] = 1;
        ["y"] = -218.5;
        ["x"] = 191.7;
        ["g"] = 15;
      };
      [2] = {
        ["sublevel"] = 1;
        ["y"] = -365.4;
        ["x"] = 222.3;
        ["g"] = 2;
      };
      [3] = {
        ["sublevel"] = 1;
        ["y"] = -439;
        ["x"] = 391;
        ["g"] = 3;
      };
      [4] = {
        ["sublevel"] = 1;
        ["y"] = -476.3;
        ["x"] = 435.5;
        ["g"] = 16;
      };
      [5] = {
        ["sublevel"] = 1;
        ["y"] = -467.2;
        ["x"] = 433;
        ["g"] = 16;
      };
      [6] = {
        ["sublevel"] = 2;
        ["y"] = -374.2;
        ["x"] = 274.8;
        ["g"] = 17;
        ["patrol"] = {
          [1] = {
            ["y"] = -311.4;
            ["x"] = 293.9;
          };
          [2] = {
            ["y"] = -339.8;
            ["x"] = 213.6;
          };
          [3] = {
            ["y"] = -381.8;
            ["x"] = 227.8;
          };
          [4] = {
            ["y"] = -360.5;
            ["x"] = 297.2;
          };
        };
      };
      [7] = {
        ["sublevel"] = 2;
        ["y"] = -360;
        ["x"] = 318.9;
        ["g"] = 4;
      };
      [8] = {
        ["sublevel"] = 2;
        ["y"] = -368.3;
        ["x"] = 342.4;
        ["g"] = 4;
      };
      [9] = {
        ["sublevel"] = 3;
        ["y"] = -210.1;
        ["x"] = 285.8;
        ["g"] = 18;
      };
      [10] = {
        ["sublevel"] = 3;
        ["y"] = -174.4;
        ["x"] = 377.7;
        ["g"] = 19;
      };
    };
  };
  [8] = {
    ["name"] = "Dragonflayer Strategist";
    ["id"] = 23956;
    ["count"] = 0;
    ["health"] = 12345;
    ["scale"] = 1;
    ["displayId"] = 22293;
    ["creatureType"] = "Humanoid";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["sublevel"] = 1;
        ["y"] = -215.2;
        ["x"] = 204.8;
        ["g"] = 15;
      };
      [2] = {
        ["sublevel"] = 1;
        ["y"] = -228.3;
        ["x"] = 201.6;
        ["g"] = 15;
      };
      [3] = {
        ["sublevel"] = 1;
        ["y"] = -346.3;
        ["x"] = 216.3;
        ["g"] = 2;
      };
      [4] = {
        ["sublevel"] = 1;
        ["y"] = -352.3;
        ["x"] = 259.5;
        ["g"] = 2;
      };
      [5] = {
        ["sublevel"] = 1;
        ["y"] = -437.2;
        ["x"] = 399;
        ["g"] = 3;
      };
      [6] = {
        ["sublevel"] = 1;
        ["y"] = -472.5;
        ["x"] = 447.1;
        ["g"] = 16;
      };
      [7] = {
        ["sublevel"] = 2;
        ["y"] = -359.7;
        ["x"] = 340.6;
        ["g"] = 4;
      };
    };
  };
  [9] = {
    ["name"] = "Prince Keleseth";
    ["id"] = 23953;
    ["count"] = 0;
    ["health"] = 12345;
    ["scale"] = 1;
    ["displayId"] = 25338;
    ["creatureType"] = "Undead";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["sublevel"] = 1;
        ["y"] = -373.6;
        ["x"] = 246.9;
      };
    };
  };
  [10] = {
    ["name"] = "Tunneling Ghoul";
    ["id"] = 24084;
    ["count"] = 0;
    ["health"] = 12345;
    ["scale"] = 1;
    ["displayId"] = 25399;
    ["creatureType"] = "Undead";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["sublevel"] = 1;
        ["y"] = -413.5;
        ["x"] = 171;
        ["g"] = 20;
      };
      [2] = {
        ["sublevel"] = 1;
        ["y"] = -421.2;
        ["x"] = 162.8;
        ["g"] = 20;
      };
      [3] = {
        ["sublevel"] = 1;
        ["y"] = -438.6;
        ["x"] = 159.5;
        ["g"] = 20;
      };
      [4] = {
        ["sublevel"] = 1;
        ["y"] = -444.1;
        ["x"] = 166.6;
        ["g"] = 20;
      };
      [5] = {
        ["sublevel"] = 1;
        ["y"] = -441.7;
        ["x"] = 203.1;
      };
      [6] = {
        ["sublevel"] = 1;
        ["y"] = -451.9;
        ["x"] = 213.7;
      };
      [7] = {
        ["sublevel"] = 1;
        ["y"] = -507.8;
        ["x"] = 202.9;
        ["g"] = 21;
      };
      [8] = {
        ["sublevel"] = 1;
        ["y"] = -503.5;
        ["x"] = 196.2;
        ["g"] = 21;
      };
      [9] = {
        ["sublevel"] = 1;
        ["y"] = -496.8;
        ["x"] = 191.4;
        ["g"] = 21;
      };
      [10] = {
        ["sublevel"] = 1;
        ["y"] = -488.7;
        ["x"] = 187.4;
        ["g"] = 21;
      };
      [11] = {
        ["sublevel"] = 1;
        ["y"] = -510.7;
        ["x"] = 240;
      };
      [12] = {
        ["sublevel"] = 1;
        ["y"] = -514.5;
        ["x"] = 274.8;
      };
      [13] = {
        ["sublevel"] = 1;
        ["y"] = -472.3;
        ["x"] = 275.7;
        ["g"] = 22;
      };
      [14] = {
        ["sublevel"] = 1;
        ["y"] = -470.7;
        ["x"] = 268.9;
        ["g"] = 22;
      };
      [15] = {
        ["sublevel"] = 1;
        ["y"] = -469.6;
        ["x"] = 258.6;
        ["g"] = 22;
      };
      [16] = {
        ["sublevel"] = 1;
        ["y"] = -469.8;
        ["x"] = 251;
        ["g"] = 22;
      };
      [17] = {
        ["sublevel"] = 2;
        ["y"] = -485.1;
        ["x"] = 424.5;
      };
      [18] = {
        ["sublevel"] = 2;
        ["y"] = -442.9;
        ["x"] = 425.3;
      };
      [19] = {
        ["sublevel"] = 2;
        ["y"] = -464.5;
        ["x"] = 474.6;
      };
    };
  };
  [11] = {
    ["name"] = "Dragonflayer Overseer";
    ["id"] = 24085;
    ["count"] = 0;
    ["health"] = 12345;
    ["scale"] = 1;
    ["displayId"] = 22291;
    ["creatureType"] = "Humanoid";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["sublevel"] = 1;
        ["y"] = -432.6;
        ["x"] = 166.1;
        ["g"] = 20;
      };
      [2] = {
        ["sublevel"] = 1;
        ["y"] = -496.3;
        ["x"] = 197.9;
        ["g"] = 21;
      };
      [3] = {
        ["sublevel"] = 1;
        ["y"] = -474.5;
        ["x"] = 262;
        ["g"] = 22;
      };
      [4] = {
        ["sublevel"] = 1;
        ["y"] = -479.7;
        ["x"] = 335.1;
        ["patrol"] = {
          [1] = {
            ["y"] = -409.1;
            ["x"] = 407.2;
          };
          [2] = {
            ["y"] = -450.2;
            ["x"] = 420.1;
          };
          [3] = {
            ["y"] = -497.3;
            ["x"] = 286.8;
          };
        };
      };
    };
  };
  [12] = {
    ["name"] = "Frenzied Geist";
    ["id"] = 28419;
    ["count"] = 0;
    ["health"] = 12345;
    ["scale"] = 1;
    ["displayId"] = 25402;
    ["creatureType"] = "Undead";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["sublevel"] = 1;
        ["y"] = -489.4;
        ["x"] = 264;
        ["g"] = 23;
      };
      [2] = {
        ["sublevel"] = 1;
        ["y"] = -499.3;
        ["x"] = 263.8;
        ["g"] = 23;
      };
      [3] = {
        ["sublevel"] = 1;
        ["y"] = -494.1;
        ["x"] = 257.3;
        ["g"] = 23;
      };
      [4] = {
        ["sublevel"] = 1;
        ["y"] = -480.2;
        ["x"] = 219.6;
        ["g"] = 24;
        ["patrol"] = {
          [1] = {
            ["y"] = -484.8;
            ["x"] = 214.1;
          };
          [2] = {
            ["y"] = -502;
            ["x"] = 249.6;
          };
          [3] = {
            ["y"] = -501.5;
            ["x"] = 295.2;
          };
          [4] = {
            ["y"] = -471.4;
            ["x"] = 376.9;
          };
          [5] = {
            ["y"] = -460.8;
            ["x"] = 411.1;
          };
          [6] = {
            ["y"] = -480.6;
            ["x"] = 421.4;
          };
          [7] = {
            ["y"] = -499.7;
            ["x"] = 361;
          };
        };
      };
      [5] = {
        ["sublevel"] = 1;
        ["y"] = -481;
        ["x"] = 211.7;
        ["g"] = 24;
      };
      [6] = {
        ["sublevel"] = 1;
        ["y"] = -488.3;
        ["x"] = 213.9;
        ["g"] = 24;
      };
      [7] = {
        ["sublevel"] = 2;
        ["y"] = -432.8;
        ["x"] = 343.8;
        ["g"] = 25;
      };
      [8] = {
        ["sublevel"] = 2;
        ["y"] = -425.3;
        ["x"] = 370.8;
        ["g"] = 25;
      };
      [9] = {
        ["sublevel"] = 2;
        ["y"] = -453.7;
        ["x"] = 352.8;
        ["g"] = 25;
      };
      [10] = {
        ["sublevel"] = 2;
        ["y"] = -452.7;
        ["x"] = 439.3;
        ["g"] = 26;
      };
      [11] = {
        ["sublevel"] = 2;
        ["y"] = -455.5;
        ["x"] = 449.8;
        ["g"] = 26;
      };
      [12] = {
        ["sublevel"] = 2;
        ["y"] = -461.3;
        ["x"] = 439.3;
        ["g"] = 26;
      };
    };
  };
  [13] = {
    ["name"] = "Savage Worg";
    ["id"] = 29735;
    ["count"] = 0;
    ["health"] = 12345;
    ["scale"] = 1;
    ["displayId"] = 22088;
    ["creatureType"] = "Beast";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["sublevel"] = 1;
        ["y"] = -463.7;
        ["x"] = 444.6;
        ["g"] = 16;
      };
      [2] = {
        ["sublevel"] = 2;
        ["y"] = -366;
        ["x"] = 272;
        ["g"] = 17;
      };
      [3] = {
        ["sublevel"] = 3;
        ["y"] = -185.6;
        ["x"] = 278.2;
        ["g"] = 18;
      };
      [4] = {
        ["sublevel"] = 3;
        ["y"] = -169.7;
        ["x"] = 359.7;
        ["g"] = 19;
      };
      [5] = {
        ["sublevel"] = 3;
        ["y"] = -165.8;
        ["x"] = 374.4;
        ["g"] = 19;
      };
      [6] = {
        ["sublevel"] = 3;
        ["y"] = -291.2;
        ["x"] = 463.1;
        ["g"] = 27;
      };
      [7] = {
        ["sublevel"] = 3;
        ["y"] = -295.9;
        ["x"] = 451.9;
        ["g"] = 27;
      };
    };
  };
  [14] = {
    ["name"] = "Skarvald the Constructor";
    ["id"] = 24200;
    ["count"] = 0;
    ["health"] = 12345;
    ["scale"] = 1;
    ["displayId"] = 22194;
    ["creatureType"] = "Humanoid";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["sublevel"] = 2;
        ["y"] = -350.3;
        ["x"] = 477.5;
        ["g"] = 28;
      };
    };
  };
  [15] = {
    ["name"] = "Dalronn the Controller";
    ["id"] = 24201;
    ["count"] = 0;
    ["health"] = 12345;
    ["scale"] = 1;
    ["displayId"] = 26349;
    ["creatureType"] = "Humanoid";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["sublevel"] = 2;
        ["y"] = -345.6;
        ["x"] = 498.8;
        ["g"] = 28;
      };
    };
  };
  [16] = {
    ["name"] = "Dragonflayer Heartsplitter";
    ["id"] = 24071;
    ["count"] = 0;
    ["health"] = 12345;
    ["scale"] = 1;
    ["displayId"] = 22299;
    ["creatureType"] = "Humanoid";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["sublevel"] = 2;
        ["y"] = -100.5;
        ["x"] = 403.6;
        ["g"] = 29;
      };
      [2] = {
        ["sublevel"] = 3;
        ["y"] = -180.9;
        ["x"] = 363.3;
        ["g"] = 19;
      };
      [3] = {
        ["sublevel"] = 3;
        ["y"] = -296.2;
        ["x"] = 458.8;
        ["g"] = 27;
      };
    };
  };
  [17] = {
    ["name"] = "Dragonflayer Bonecrusher";
    ["id"] = 24069;
    ["count"] = 0;
    ["health"] = 12345;
    ["scale"] = 1;
    ["displayId"] = 22297;
    ["creatureType"] = "Humanoid";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["sublevel"] = 2;
        ["y"] = -109.2;
        ["x"] = 385.6;
        ["g"] = 29;
      };
      [2] = {
        ["sublevel"] = 3;
        ["y"] = -192.1;
        ["x"] = 260.6;
        ["g"] = 18;
      };
      [3] = {
        ["sublevel"] = 3;
        ["y"] = -286.2;
        ["x"] = 454.5;
        ["g"] = 27;
      };
    };
  };
  [18] = {
    ["name"] = "Dragonflayer Spiritualist";
    ["id"] = 28410;
    ["count"] = 0;
    ["health"] = 12345;
    ["scale"] = 1;
    ["displayId"] = 25393;
    ["creatureType"] = "Humanoid";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["sublevel"] = 2;
        ["y"] = -117.1;
        ["x"] = 398.6;
        ["g"] = 29;
      };
      [2] = {
        ["sublevel"] = 3;
        ["y"] = -215.2;
        ["x"] = 271.4;
        ["g"] = 18;
      };
    };
  };
  [19] = {
    ["name"] = "Proto-Drake Rider";
    ["id"] = 24849;
    ["count"] = 0;
    ["health"] = 12345;
    ["scale"] = 1;
    ["displayId"] = 22287;
    ["creatureType"] = "Humanoid";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["sublevel"] = 3;
        ["y"] = -205.4;
        ["x"] = 436.8;
        ["g"] = 14;
      };
    };
  };
  [20] = {
    ["name"] = "Ingvar the Plunderer";
    ["id"] = 23954;
    ["count"] = 0;
    ["health"] = 12345;
    ["scale"] = 1;
    ["displayId"] = 21953;
    ["creatureType"] = "Humanoid";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["sublevel"] = 3;
        ["y"] = -200;
        ["x"] = 628.5;
      };
    };
  };
};
