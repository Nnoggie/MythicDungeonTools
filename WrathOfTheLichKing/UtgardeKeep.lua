local MDT = MDT
local L = MDT.L
local dungeonIndex = 66
MDT.dungeonList[dungeonIndex] = L["Utgarde Keep"]
MDT.mapInfo[dungeonIndex] = {
  viewportPositionOverrides =
  {
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
        ["g"] = 1;
        ["sublevel"] = 1;
        ["y"] = -347.8;
        ["x"] = 554.6;
      };
      [2] = {
        ["g"] = 1;
        ["sublevel"] = 1;
        ["y"] = -344.2;
        ["x"] = 565.5;
      };
      [3] = {
        ["g"] = 2;
        ["sublevel"] = 1;
        ["y"] = -337.6;
        ["x"] = 254.6;
      };
      [4] = {
        ["g"] = 3;
        ["sublevel"] = 1;
        ["y"] = -431.7;
        ["x"] = 393.9;
      };
      [5] = {
        ["g"] = 4;
        ["sublevel"] = 2;
        ["y"] = -370.5;
        ["x"] = 321.5;
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
        ["g"] = 5;
        ["sublevel"] = 1;
        ["y"] = -291.9;
        ["x"] = 522.6;
      };
      [2] = {
        ["g"] = 5;
        ["sublevel"] = 1;
        ["y"] = -304.5;
        ["x"] = 522.9;
      };
      [3] = {
        ["g"] = 6;
        ["sublevel"] = 1;
        ["y"] = -276.8;
        ["x"] = 562.9;
      };
      [4] = {
        ["g"] = 7;
        ["sublevel"] = 1;
        ["y"] = -254.4;
        ["x"] = 524;
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
        ["g"] = 5;
        ["sublevel"] = 1;
        ["y"] = -295.9;
        ["x"] = 531.6;
      };
      [2] = {
        ["g"] = 5;
        ["sublevel"] = 1;
        ["y"] = -301.3;
        ["x"] = 516.1;
      };
      [3] = {
        ["g"] = 6;
        ["sublevel"] = 1;
        ["y"] = -283.3;
        ["x"] = 555.4;
      };
      [4] = {
        ["g"] = 6;
        ["sublevel"] = 1;
        ["y"] = -282.2;
        ["x"] = 570.1;
      };
      [5] = {
        ["g"] = 8;
        ["sublevel"] = 1;
        ["y"] = -171.9;
        ["x"] = 550.7;
      };
      [6] = {
        ["g"] = 8;
        ["sublevel"] = 1;
        ["y"] = -182;
        ["x"] = 566.2;
      };
      [7] = {
        ["g"] = 9;
        ["sublevel"] = 1;
        ["y"] = -137;
        ["x"] = 504.6;
      };
      [8] = {
        ["g"] = 9;
        ["sublevel"] = 1;
        ["y"] = -141.6;
        ["x"] = 534;
      };
      [9] = {
        ["g"] = 10;
        ["sublevel"] = 1;
        ["y"] = -198.3;
        ["x"] = 478.6;
      };
      [10] = {
        ["g"] = 10;
        ["sublevel"] = 1;
        ["y"] = -191.7;
        ["x"] = 462.4;
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
        ["g"] = 8;
        ["sublevel"] = 1;
        ["y"] = -188.5;
        ["x"] = 534.1;
      };
      [2] = {
        ["g"] = 9;
        ["sublevel"] = 1;
        ["y"] = -153.2;
        ["x"] = 517.1;
      };
      [3] = {
        ["g"] = 10;
        ["sublevel"] = 1;
        ["y"] = -184.6;
        ["x"] = 474;
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
        ["g"] = 11;
        ["sublevel"] = 1;
        ["y"] = -132.4;
        ["x"] = 308.1;
      };
      [2] = {
        ["g"] = 12;
        ["sublevel"] = 1;
        ["y"] = -197.7;
        ["x"] = 317.5;
      };
      [3] = {
        ["g"] = 13;
        ["sublevel"] = 1;
        ["y"] = -144.9;
        ["x"] = 266.1;
      };
      [4] = {
        ["g"] = 14;
        ["sublevel"] = 1;
        ["y"] = -207.1;
        ["x"] = 246;
      };
      [5] = {
        ["g"] = 14;
        ["sublevel"] = 1;
        ["y"] = -217.1;
        ["x"] = 239.1;
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
        ["g"] = 11;
        ["sublevel"] = 1;
        ["y"] = -126.8;
        ["x"] = 292.4;
      };
      [2] = {
        ["g"] = 15;
        ["sublevel"] = 1;
        ["y"] = -202.7;
        ["x"] = 372.1;
      };
      [3] = {
        ["g"] = 12;
        ["sublevel"] = 1;
        ["y"] = -190.8;
        ["x"] = 321.3;
      };
      [4] = {
        ["g"] = 13;
        ["sublevel"] = 1;
        ["y"] = -153.1;
        ["x"] = 261;
      };
      [5] = {
        ["g"] = 16;
        ["sublevel"] = 1;
        ["y"] = -231.5;
        ["x"] = 293;
      };
      [6] = {
        ["g"] = 14;
        ["sublevel"] = 1;
        ["y"] = -206.4;
        ["x"] = 234;
      };
      [7] = {
        ["g"] = 17;
        ["sublevel"] = 3;
        ["y"] = -202.2;
        ["x"] = 436.8;
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
        ["g"] = 18;
        ["sublevel"] = 1;
        ["y"] = -218.5;
        ["x"] = 191.7;
      };
      [2] = {
        ["g"] = 2;
        ["sublevel"] = 1;
        ["y"] = -365.4;
        ["x"] = 222.3;
      };
      [3] = {
        ["g"] = 3;
        ["sublevel"] = 1;
        ["y"] = -439;
        ["x"] = 391;
      };
      [4] = {
        ["g"] = 19;
        ["sublevel"] = 1;
        ["y"] = -476.3;
        ["x"] = 435.5;
      };
      [5] = {
        ["g"] = 19;
        ["sublevel"] = 1;
        ["y"] = -467.2;
        ["x"] = 433;
      };
      [6] = {
        ["g"] = 20;
        ["sublevel"] = 2;
        ["y"] = -374.2;
        ["x"] = 274.8;
      };
      [7] = {
        ["g"] = 4;
        ["sublevel"] = 2;
        ["y"] = -360;
        ["x"] = 318.9;
      };
      [8] = {
        ["g"] = 4;
        ["sublevel"] = 2;
        ["y"] = -368.3;
        ["x"] = 342.4;
      };
      [9] = {
        ["g"] = 21;
        ["sublevel"] = 3;
        ["y"] = -210.1;
        ["x"] = 285.8;
      };
      [10] = {
        ["g"] = 22;
        ["sublevel"] = 3;
        ["y"] = -174.4;
        ["x"] = 377.7;
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
        ["g"] = 18;
        ["sublevel"] = 1;
        ["y"] = -215.2;
        ["x"] = 204.8;
      };
      [2] = {
        ["g"] = 18;
        ["sublevel"] = 1;
        ["y"] = -228.3;
        ["x"] = 201.6;
      };
      [3] = {
        ["g"] = 2;
        ["sublevel"] = 1;
        ["y"] = -346.3;
        ["x"] = 216.3;
      };
      [4] = {
        ["g"] = 2;
        ["sublevel"] = 1;
        ["y"] = -352.3;
        ["x"] = 259.5;
      };
      [5] = {
        ["g"] = 3;
        ["sublevel"] = 1;
        ["y"] = -437.2;
        ["x"] = 399;
      };
      [6] = {
        ["g"] = 19;
        ["sublevel"] = 1;
        ["y"] = -472.5;
        ["x"] = 447.1;
      };
      [7] = {
        ["g"] = 4;
        ["sublevel"] = 2;
        ["y"] = -359.7;
        ["x"] = 340.6;
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
        ["g"] = 23;
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
        ["g"] = 24;
        ["sublevel"] = 1;
        ["y"] = -413.5;
        ["x"] = 171;
      };
      [2] = {
        ["g"] = 24;
        ["sublevel"] = 1;
        ["y"] = -421.2;
        ["x"] = 162.8;
      };
      [3] = {
        ["g"] = 24;
        ["sublevel"] = 1;
        ["y"] = -438.6;
        ["x"] = 159.5;
      };
      [4] = {
        ["g"] = 24;
        ["sublevel"] = 1;
        ["y"] = -444.1;
        ["x"] = 166.6;
      };
      [5] = {
        ["g"] = 25;
        ["sublevel"] = 1;
        ["y"] = -441.7;
        ["x"] = 203.1;
      };
      [6] = {
        ["g"] = 26;
        ["sublevel"] = 1;
        ["y"] = -451.9;
        ["x"] = 213.7;
      };
      [7] = {
        ["g"] = 27;
        ["sublevel"] = 1;
        ["y"] = -507.8;
        ["x"] = 202.9;
      };
      [8] = {
        ["g"] = 27;
        ["sublevel"] = 1;
        ["y"] = -503.5;
        ["x"] = 196.2;
      };
      [9] = {
        ["g"] = 27;
        ["sublevel"] = 1;
        ["y"] = -496.8;
        ["x"] = 191.4;
      };
      [10] = {
        ["g"] = 27;
        ["sublevel"] = 1;
        ["y"] = -488.7;
        ["x"] = 187.4;
      };
      [11] = {
        ["g"] = 28;
        ["sublevel"] = 1;
        ["y"] = -510.7;
        ["x"] = 240;
      };
      [12] = {
        ["g"] = 29;
        ["sublevel"] = 1;
        ["y"] = -514.5;
        ["x"] = 274.8;
      };
      [13] = {
        ["g"] = 30;
        ["sublevel"] = 1;
        ["y"] = -472.3;
        ["x"] = 275.7;
      };
      [14] = {
        ["g"] = 30;
        ["sublevel"] = 1;
        ["y"] = -470.7;
        ["x"] = 268.9;
      };
      [15] = {
        ["g"] = 30;
        ["sublevel"] = 1;
        ["y"] = -469.6;
        ["x"] = 258.6;
      };
      [16] = {
        ["g"] = 30;
        ["sublevel"] = 1;
        ["y"] = -469.8;
        ["x"] = 251;
      };
      [17] = {
        ["g"] = 31;
        ["sublevel"] = 2;
        ["y"] = -485.1;
        ["x"] = 424.5;
      };
      [18] = {
        ["g"] = 32;
        ["sublevel"] = 2;
        ["y"] = -442.9;
        ["x"] = 425.3;
      };
      [19] = {
        ["g"] = 33;
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
        ["g"] = 24;
        ["sublevel"] = 1;
        ["y"] = -432.6;
        ["x"] = 166.1;
      };
      [2] = {
        ["g"] = 27;
        ["sublevel"] = 1;
        ["y"] = -496.3;
        ["x"] = 197.9;
      };
      [3] = {
        ["g"] = 30;
        ["sublevel"] = 1;
        ["y"] = -474.5;
        ["x"] = 262;
      };
      [4] = {
        ["g"] = 34;
        ["sublevel"] = 1;
        ["y"] = -482.7;
        ["x"] = 336.4;
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
        ["g"] = 35;
        ["sublevel"] = 1;
        ["y"] = -489.4;
        ["x"] = 264;
      };
      [2] = {
        ["g"] = 35;
        ["sublevel"] = 1;
        ["y"] = -499.3;
        ["x"] = 263.8;
      };
      [3] = {
        ["g"] = 35;
        ["sublevel"] = 1;
        ["y"] = -494.1;
        ["x"] = 257.3;
      };
      [4] = {
        ["g"] = 36;
        ["sublevel"] = 1;
        ["y"] = -480.2;
        ["x"] = 219.6;
      };
      [5] = {
        ["g"] = 36;
        ["sublevel"] = 1;
        ["y"] = -481;
        ["x"] = 211.7;
      };
      [6] = {
        ["g"] = 36;
        ["sublevel"] = 1;
        ["y"] = -488.3;
        ["x"] = 213.9;
      };
      [7] = {
        ["g"] = 37;
        ["sublevel"] = 2;
        ["y"] = -432.8;
        ["x"] = 343.8;
      };
      [8] = {
        ["g"] = 37;
        ["sublevel"] = 2;
        ["y"] = -425.3;
        ["x"] = 370.8;
      };
      [9] = {
        ["g"] = 37;
        ["sublevel"] = 2;
        ["y"] = -453.7;
        ["x"] = 352.8;
      };
      [10] = {
        ["g"] = 38;
        ["sublevel"] = 2;
        ["y"] = -452.7;
        ["x"] = 439.3;
      };
      [11] = {
        ["g"] = 38;
        ["sublevel"] = 2;
        ["y"] = -455.5;
        ["x"] = 449.8;
      };
      [12] = {
        ["g"] = 38;
        ["sublevel"] = 2;
        ["y"] = -461.3;
        ["x"] = 439.3;
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
        ["g"] = 19;
        ["sublevel"] = 1;
        ["y"] = -463.7;
        ["x"] = 444.6;
      };
      [2] = {
        ["g"] = 20;
        ["sublevel"] = 2;
        ["y"] = -366;
        ["x"] = 272;
      };
      [3] = {
        ["g"] = 21;
        ["sublevel"] = 3;
        ["y"] = -185.6;
        ["x"] = 278.2;
      };
      [4] = {
        ["g"] = 22;
        ["sublevel"] = 3;
        ["y"] = -169.7;
        ["x"] = 359.7;
      };
      [5] = {
        ["g"] = 22;
        ["sublevel"] = 3;
        ["y"] = -165.8;
        ["x"] = 374.4;
      };
      [6] = {
        ["g"] = 39;
        ["sublevel"] = 3;
        ["y"] = -291.2;
        ["x"] = 463.1;
      };
      [7] = {
        ["g"] = 39;
        ["sublevel"] = 3;
        ["y"] = -295.9;
        ["x"] = 451.9;
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
        ["g"] = 40;
        ["sublevel"] = 2;
        ["y"] = -350.3;
        ["x"] = 477.5;
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
        ["g"] = 40;
        ["sublevel"] = 2;
        ["y"] = -345.6;
        ["x"] = 498.8;
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
        ["g"] = 41;
        ["sublevel"] = 2;
        ["y"] = -100.5;
        ["x"] = 403.6;
      };
      [2] = {
        ["g"] = 22;
        ["sublevel"] = 3;
        ["y"] = -180.9;
        ["x"] = 363.3;
      };
      [3] = {
        ["g"] = 39;
        ["sublevel"] = 3;
        ["y"] = -296.2;
        ["x"] = 458.8;
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
        ["g"] = 41;
        ["sublevel"] = 2;
        ["y"] = -109.2;
        ["x"] = 385.6;
      };
      [2] = {
        ["g"] = 21;
        ["sublevel"] = 3;
        ["y"] = -192.1;
        ["x"] = 260.6;
      };
      [3] = {
        ["g"] = 39;
        ["sublevel"] = 3;
        ["y"] = -286.2;
        ["x"] = 454.5;
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
        ["g"] = 41;
        ["sublevel"] = 2;
        ["y"] = -117.1;
        ["x"] = 398.6;
      };
      [2] = {
        ["g"] = 21;
        ["sublevel"] = 3;
        ["y"] = -215.2;
        ["x"] = 271.4;
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
        ["g"] = 17;
        ["sublevel"] = 3;
        ["y"] = -205.4;
        ["x"] = 436.8;
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
        ["g"] = 42;
        ["sublevel"] = 3;
        ["y"] = -200;
        ["x"] = 628.5;
      };
    };
  };
};
