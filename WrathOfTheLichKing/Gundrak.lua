local MDT = MDT
local L = MDT.L
local dungeonIndex = 55
MDT.dungeonList[dungeonIndex] = L["Gundrak"]
MDT.mapInfo[dungeonIndex] = {
  viewportPositionOverrides =
  {
    [1] = {
      zoomScale = 1.2999999523163;
      horizontalPan = 30.804016438391;
      verticalPan = 73.589899673731;
    };
  }
};

MDT.dungeonMaps[dungeonIndex] = {
  [0] = "gundrak",
  [1] = "gundrak1_",
}

MDT.dungeonSubLevels[dungeonIndex] = {
  [1] = L["Gundrak"],
}

MDT.dungeonTotalCount[dungeonIndex] = { normal = 300, teeming = 1000, teemingEnabled = true }

MDT.mapPOIs[dungeonIndex] = {
};

MDT.dungeonEnemies[dungeonIndex] = {
  [1] = {
    ["name"] = "Spitting Cobra";
    ["id"] = 29774;
    ["count"] = 0;
    ["health"] = 12345;
    ["scale"] = 1;
    ["displayId"] = 14557;
    ["creatureType"] = "Beast";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["g"] = 1;
        ["sublevel"] = 1;
        ["y"] = -243.3;
        ["x"] = 492.7;
      };
      [2] = {
        ["g"] = 1;
        ["sublevel"] = 1;
        ["y"] = -246.6;
        ["x"] = 495.5;
      };
      [3] = {
        ["g"] = 2;
        ["sublevel"] = 1;
        ["y"] = -261.3;
        ["x"] = 493.7;
      };
      [4] = {
        ["g"] = 3;
        ["sublevel"] = 1;
        ["y"] = -277;
        ["x"] = 494.1;
      };
      [5] = {
        ["g"] = 3;
        ["sublevel"] = 1;
        ["y"] = -282;
        ["x"] = 493.9;
      };
      [6] = {
        ["g"] = 4;
        ["sublevel"] = 1;
        ["y"] = -352.5;
        ["x"] = 490.6;
      };
      [7] = {
        ["g"] = 5;
        ["sublevel"] = 1;
        ["y"] = -380.1;
        ["x"] = 501.7;
      };
      [8] = {
        ["g"] = 5;
        ["sublevel"] = 1;
        ["y"] = -384.8;
        ["x"] = 501.7;
      };
      [9] = {
        ["g"] = 6;
        ["sublevel"] = 1;
        ["y"] = -346.2;
        ["x"] = 459.8;
      };
      [10] = {
        ["g"] = 7;
        ["sublevel"] = 1;
        ["y"] = -416.8;
        ["x"] = 450.1;
      };
      [11] = {
        ["g"] = 7;
        ["sublevel"] = 1;
        ["y"] = -408.2;
        ["x"] = 433;
      };
    };
  };
  [2] = {
    ["name"] = "Unyielding Constrictor";
    ["id"] = 29768;
    ["count"] = 0;
    ["health"] = 12345;
    ["scale"] = 1;
    ["displayId"] = 4305;
    ["creatureType"] = "Beast";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["g"] = 1;
        ["sublevel"] = 1;
        ["y"] = -246;
        ["x"] = 489.1;
      };
      [2] = {
        ["g"] = 2;
        ["sublevel"] = 1;
        ["y"] = -264;
        ["x"] = 490.5;
      };
      [3] = {
        ["g"] = 2;
        ["sublevel"] = 1;
        ["y"] = -266.5;
        ["x"] = 493.9;
      };
      [4] = {
        ["g"] = 3;
        ["sublevel"] = 1;
        ["y"] = -278.9;
        ["x"] = 497.5;
      };
      [5] = {
        ["g"] = 4;
        ["sublevel"] = 1;
        ["y"] = -347.6;
        ["x"] = 494.2;
      };
      [6] = {
        ["g"] = 4;
        ["sublevel"] = 1;
        ["y"] = -352.6;
        ["x"] = 497.6;
      };
      [7] = {
        ["g"] = 5;
        ["sublevel"] = 1;
        ["y"] = -383.9;
        ["x"] = 497.6;
      };
      [8] = {
        ["g"] = 8;
        ["sublevel"] = 1;
        ["y"] = -369.1;
        ["x"] = 462.9;
      };
      [9] = {
        ["g"] = 7;
        ["sublevel"] = 1;
        ["y"] = -396.7;
        ["x"] = 450.9;
      };
    };
  };
  [3] = {
    ["name"] = "Slad'ran";
    ["id"] = 29304;
    ["count"] = 0;
    ["health"] = 12345;
    ["scale"] = 1;
    ["displayId"] = 27422;
    ["creatureType"] = "Humanoid";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["g"] = 9;
        ["sublevel"] = 1;
        ["y"] = -272.1;
        ["x"] = 452.8;
      };
    };
  };
  [4] = {
    ["name"] = "Drakkari Frenzy";
    ["id"] = 29834;
    ["count"] = 0;
    ["health"] = 12345;
    ["scale"] = 1;
    ["displayId"] = 17170;
    ["creatureType"] = "Beast";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["g"] = 10;
        ["sublevel"] = 1;
        ["y"] = -210.1;
        ["x"] = 420.8;
      };
      [2] = {
        ["g"] = 11;
        ["sublevel"] = 1;
        ["y"] = -231.9;
        ["x"] = 436.3;
      };
      [3] = {
        ["g"] = 12;
        ["sublevel"] = 1;
        ["y"] = -242.8;
        ["x"] = 416.7;
      };
      [4] = {
        ["g"] = 13;
        ["sublevel"] = 1;
        ["y"] = -310.7;
        ["x"] = 415.6;
      };
      [5] = {
        ["g"] = 14;
        ["sublevel"] = 1;
        ["y"] = -281.1;
        ["x"] = 416.5;
      };
      [6] = {
        ["g"] = 15;
        ["sublevel"] = 1;
        ["y"] = -288.8;
        ["x"] = 435.3;
      };
      [7] = {
        ["g"] = 16;
        ["sublevel"] = 1;
        ["y"] = -264.1;
        ["x"] = 435.5;
      };
      [8] = {
        ["g"] = 17;
        ["sublevel"] = 1;
        ["y"] = -259.8;
        ["x"] = 422.7;
      };
      [9] = {
        ["g"] = 18;
        ["sublevel"] = 1;
        ["y"] = -422.2;
        ["x"] = 320.9;
      };
      [10] = {
        ["g"] = 19;
        ["sublevel"] = 1;
        ["y"] = -402.2;
        ["x"] = 322.4;
      };
      [11] = {
        ["g"] = 20;
        ["sublevel"] = 1;
        ["y"] = -394.1;
        ["x"] = 341.5;
      };
      [12] = {
        ["g"] = 21;
        ["sublevel"] = 1;
        ["y"] = -408.9;
        ["x"] = 283.1;
      };
      [13] = {
        ["g"] = 22;
        ["sublevel"] = 1;
        ["y"] = -362.2;
        ["x"] = 341.1;
      };
      [14] = {
        ["g"] = 23;
        ["sublevel"] = 1;
        ["y"] = -361.5;
        ["x"] = 315.9;
      };
      [15] = {
        ["g"] = 24;
        ["sublevel"] = 1;
        ["y"] = -353.2;
        ["x"] = 290.3;
      };
      [16] = {
        ["g"] = 25;
        ["sublevel"] = 1;
        ["y"] = -373.5;
        ["x"] = 294.1;
      };
    };
  };
  [5] = {
    ["name"] = "Drakkari Fire Weaver";
    ["id"] = 29822;
    ["count"] = 0;
    ["health"] = 12345;
    ["scale"] = 1;
    ["displayId"] = 27047;
    ["creatureType"] = "Humanoid";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["g"] = 26;
        ["sublevel"] = 1;
        ["y"] = -385.3;
        ["x"] = 485;
      };
      [2] = {
        ["g"] = 27;
        ["sublevel"] = 1;
        ["y"] = -446.3;
        ["x"] = 260.9;
      };
      [3] = {
        ["g"] = 28;
        ["sublevel"] = 1;
        ["y"] = -418.4;
        ["x"] = 251.2;
      };
      [4] = {
        ["g"] = 29;
        ["sublevel"] = 1;
        ["y"] = -375.7;
        ["x"] = 276.8;
      };
      [5] = {
        ["g"] = 30;
        ["sublevel"] = 1;
        ["y"] = -299.8;
        ["x"] = 292.6;
      };
    };
  };
  [6] = {
    ["name"] = "Drakkari Lancer";
    ["id"] = 29819;
    ["count"] = 0;
    ["health"] = 12345;
    ["scale"] = 1;
    ["displayId"] = 27050;
    ["creatureType"] = "Humanoid";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["g"] = 26;
        ["sublevel"] = 1;
        ["y"] = -383.2;
        ["x"] = 481.1;
      };
      [2] = {
        ["g"] = 31;
        ["sublevel"] = 1;
        ["y"] = -464;
        ["x"] = 288.7;
      };
      [3] = {
        ["g"] = 27;
        ["sublevel"] = 1;
        ["y"] = -457.5;
        ["x"] = 266.9;
      };
      [4] = {
        ["g"] = 27;
        ["sublevel"] = 1;
        ["y"] = -450.5;
        ["x"] = 267.2;
      };
      [5] = {
        ["g"] = 28;
        ["sublevel"] = 1;
        ["y"] = -416.1;
        ["x"] = 256.4;
      };
      [6] = {
        ["g"] = 29;
        ["sublevel"] = 1;
        ["y"] = -373.2;
        ["x"] = 274.3;
      };
      [7] = {
        ["g"] = 30;
        ["sublevel"] = 1;
        ["y"] = -299.6;
        ["x"] = 301.8;
      };
    };
  };
  [7] = {
    ["name"] = "Drakkari Golem";
    ["id"] = 29832;
    ["count"] = 0;
    ["health"] = 12345;
    ["scale"] = 1;
    ["displayId"] = 26592;
    ["creatureType"] = "Mechanical";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["g"] = 32;
        ["sublevel"] = 1;
        ["y"] = -455.6;
        ["x"] = 416.5;
      };
      [2] = {
        ["g"] = 33;
        ["sublevel"] = 1;
        ["y"] = -409.4;
        ["x"] = 394.6;
      };
      [3] = {
        ["g"] = 33;
        ["sublevel"] = 1;
        ["y"] = -409.5;
        ["x"] = 387.6;
      };
    };
  };
  [8] = {
    ["name"] = "Living Mojo";
    ["id"] = 29830;
    ["count"] = 0;
    ["health"] = 12345;
    ["scale"] = 1;
    ["displayId"] = 33846;
    ["creatureType"] = "Elemental";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["g"] = 34;
        ["sublevel"] = 1;
        ["y"] = -437.5;
        ["x"] = 407;
      };
      [2] = {
        ["g"] = 35;
        ["sublevel"] = 1;
        ["y"] = -423.1;
        ["x"] = 390.8;
      };
      [3] = {
        ["g"] = 36;
        ["sublevel"] = 1;
        ["y"] = -398.3;
        ["x"] = 391;
      };
      [4] = {
        ["g"] = 37;
        ["sublevel"] = 1;
        ["y"] = -399;
        ["x"] = 401.3;
      };
      [5] = {
        ["g"] = 38;
        ["sublevel"] = 1;
        ["y"] = -356.4;
        ["x"] = 383.6;
      };
      [6] = {
        ["g"] = 39;
        ["sublevel"] = 1;
        ["y"] = -356.6;
        ["x"] = 396.8;
      };
      [7] = {
        ["g"] = 40;
        ["sublevel"] = 1;
        ["y"] = -368.9;
        ["x"] = 401.7;
      };
      [8] = {
        ["g"] = 41;
        ["sublevel"] = 1;
        ["y"] = -376.8;
        ["x"] = 391;
      };
      [9] = {
        ["g"] = 42;
        ["sublevel"] = 1;
        ["y"] = -372.1;
        ["x"] = 379.9;
      };
    };
  };
  [9] = {
    ["name"] = "Drakkari Colossus";
    ["id"] = 29307;
    ["count"] = 0;
    ["health"] = 12345;
    ["scale"] = 1;
    ["displayId"] = 26589;
    ["creatureType"] = "Mechanical";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["g"] = 43;
        ["sublevel"] = 1;
        ["y"] = -366.3;
        ["x"] = 390.8;
      };
    };
  };
  [10] = {
    ["name"] = "Drakkari God Hunter";
    ["id"] = 29820;
    ["count"] = 0;
    ["health"] = 12345;
    ["scale"] = 1;
    ["displayId"] = 27048;
    ["creatureType"] = "Humanoid";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["g"] = 31;
        ["sublevel"] = 1;
        ["y"] = -457.5;
        ["x"] = 293.4;
      };
      [2] = {
        ["g"] = 31;
        ["sublevel"] = 1;
        ["y"] = -464.7;
        ["x"] = 304.3;
      };
      [3] = {
        ["g"] = 27;
        ["sublevel"] = 1;
        ["y"] = -453.6;
        ["x"] = 260.2;
      };
      [4] = {
        ["g"] = 29;
        ["sublevel"] = 1;
        ["y"] = -372.7;
        ["x"] = 279.8;
      };
      [5] = {
        ["g"] = 44;
        ["sublevel"] = 1;
        ["y"] = -251.3;
        ["x"] = 295.2;
      };
    };
  };
  [11] = {
    ["name"] = "Drakkari Medicine Man";
    ["id"] = 29826;
    ["count"] = 0;
    ["health"] = 12345;
    ["scale"] = 1;
    ["displayId"] = 27051;
    ["creatureType"] = "Humanoid";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["g"] = 31;
        ["sublevel"] = 1;
        ["y"] = -457.7;
        ["x"] = 301.5;
      };
      [2] = {
        ["g"] = 29;
        ["sublevel"] = 1;
        ["y"] = -370.1;
        ["x"] = 276.7;
      };
      [3] = {
        ["g"] = 30;
        ["sublevel"] = 1;
        ["y"] = -299.8;
        ["x"] = 285;
      };
      [4] = {
        ["g"] = 44;
        ["sublevel"] = 1;
        ["y"] = -251.6;
        ["x"] = 285;
      };
    };
  };
  [12] = {
    ["name"] = "Drakkari Earthshaker";
    ["id"] = 29829;
    ["count"] = 0;
    ["health"] = 12345;
    ["scale"] = 1;
    ["displayId"] = 12249;
    ["creatureType"] = "Humanoid";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["g"] = 45;
        ["sublevel"] = 1;
        ["y"] = -437.2;
        ["x"] = 329.4;
      };
      [2] = {
        ["g"] = 46;
        ["sublevel"] = 1;
        ["y"] = -354.5;
        ["x"] = 253.8;
      };
      [3] = {
        ["g"] = 47;
        ["sublevel"] = 1;
        ["y"] = -274.7;
        ["x"] = 286.8;
      };
      [4] = {
        ["g"] = 47;
        ["sublevel"] = 1;
        ["y"] = -274.7;
        ["x"] = 294;
      };
    };
  };
  [13] = {
    ["name"] = "Drakkari Inciter";
    ["id"] = 29874;
    ["count"] = 0;
    ["health"] = 12345;
    ["scale"] = 1;
    ["displayId"] = 27049;
    ["creatureType"] = "Humanoid";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["g"] = 47;
        ["sublevel"] = 1;
        ["y"] = -269.2;
        ["x"] = 292.1;
      };
    };
  };
  [14] = {
    ["name"] = "Moorabi";
    ["id"] = 29305;
    ["count"] = 0;
    ["health"] = 12345;
    ["scale"] = 1;
    ["displayId"] = 27059;
    ["creatureType"] = "Humanoid";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["g"] = 48;
        ["sublevel"] = 1;
        ["y"] = -274.2;
        ["x"] = 331.6;
      };
    };
  };
  [15] = {
    ["name"] = "Ruins Dweller";
    ["id"] = 29920;
    ["count"] = 0;
    ["health"] = 12345;
    ["scale"] = 1;
    ["displayId"] = 23320;
    ["creatureType"] = "Humanoid";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["g"] = 49;
        ["sublevel"] = 1;
        ["y"] = -280.8;
        ["x"] = 199.9;
      };
      [2] = {
        ["g"] = 50;
        ["sublevel"] = 1;
        ["y"] = -305.5;
        ["x"] = 178.8;
      };
      [3] = {
        ["g"] = 51;
        ["sublevel"] = 1;
        ["y"] = -312.6;
        ["x"] = 219.8;
      };
      [4] = {
        ["g"] = 52;
        ["sublevel"] = 1;
        ["y"] = -338.6;
        ["x"] = 192.1;
      };
      [5] = {
        ["g"] = 53;
        ["sublevel"] = 1;
        ["y"] = -337.4;
        ["x"] = 213.6;
      };
      [6] = {
        ["g"] = 54;
        ["sublevel"] = 1;
        ["y"] = -334.9;
        ["x"] = 228.5;
      };
      [7] = {
        ["g"] = 55;
        ["sublevel"] = 1;
        ["y"] = -385;
        ["x"] = 220;
      };
      [8] = {
        ["g"] = 55;
        ["sublevel"] = 1;
        ["y"] = -382.1;
        ["x"] = 211.3;
      };
      [9] = {
        ["g"] = 55;
        ["sublevel"] = 1;
        ["y"] = -389.3;
        ["x"] = 204.1;
      };
    };
  };
  [16] = {
    ["name"] = "Eck the Ferocious";
    ["id"] = 29932;
    ["count"] = 0;
    ["health"] = 12345;
    ["scale"] = 1;
    ["displayId"] = 26644;
    ["creatureType"] = "Humanoid";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["g"] = 56;
        ["sublevel"] = 1;
        ["y"] = -393.2;
        ["x"] = 214.3;
      };
    };
  };
  [17] = {
    ["name"] = "Drakkari Raider";
    ["id"] = 29982;
    ["count"] = 0;
    ["health"] = 12345;
    ["scale"] = 1;
    ["displayId"] = 27049;
    ["creatureType"] = "Humanoid";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["g"] = 57;
        ["sublevel"] = 1;
        ["y"] = -281.3;
        ["x"] = 390.6;
      };
      [2] = {
        ["g"] = 57;
        ["sublevel"] = 1;
        ["y"] = -276.5;
        ["x"] = 402.6;
      };
      [3] = {
        ["g"] = 57;
        ["sublevel"] = 1;
        ["y"] = -276.1;
        ["x"] = 381.3;
      };
    };
  };
  [18] = {
    ["name"] = "Drakkari Rhino";
    ["id"] = 29931;
    ["count"] = 0;
    ["health"] = 12345;
    ["scale"] = 1;
    ["displayId"] = 26265;
    ["creatureType"] = "Beast";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["g"] = 57;
        ["sublevel"] = 1;
        ["y"] = -266.4;
        ["x"] = 390.8;
      };
    };
  };
  [19] = {
    ["name"] = "Drakkari Rhino";
    ["id"] = 29838;
    ["count"] = 0;
    ["health"] = 12345;
    ["scale"] = 1;
    ["displayId"] = 26265;
    ["creatureType"] = "Beast";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["g"] = 58;
        ["sublevel"] = 1;
        ["y"] = -201.1;
        ["x"] = 390.6;
      };
      [2] = {
        ["g"] = 59;
        ["sublevel"] = 1;
        ["y"] = -179.1;
        ["x"] = 375.9;
      };
      [3] = {
        ["g"] = 60;
        ["sublevel"] = 1;
        ["y"] = -180.1;
        ["x"] = 403.8;
      };
    };
  };
  [20] = {
    ["name"] = "Drakkari Battle Rider";
    ["id"] = 29836;
    ["count"] = 0;
    ["health"] = 12345;
    ["scale"] = 1;
    ["displayId"] = 27046;
    ["creatureType"] = "Humanoid";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["g"] = 58;
        ["sublevel"] = 1;
        ["y"] = -197.7;
        ["x"] = 390.9;
      };
      [2] = {
        ["g"] = 59;
        ["sublevel"] = 1;
        ["y"] = -176;
        ["x"] = 375.9;
      };
      [3] = {
        ["g"] = 60;
        ["sublevel"] = 1;
        ["y"] = -176.9;
        ["x"] = 403.5;
      };
    };
  };
  [21] = {
    ["name"] = "Gal'darah";
    ["id"] = 29306;
    ["count"] = 0;
    ["health"] = 12345;
    ["scale"] = 1;
    ["displayId"] = 27061;
    ["creatureType"] = "Humanoid";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["g"] = 61;
        ["sublevel"] = 1;
        ["y"] = -144.8;
        ["x"] = 389.9;
      };
    };
  };
};
