local MDT = MDT
local L = MDT.L
local dungeonIndex = 55
MDT.dungeonList[dungeonIndex] = L["Gundrak"]
MDT.mapInfo[dungeonIndex] = {
  viewportPositionOverrides = {
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
        ["sublevel"] = 1;
        ["y"] = -243.3;
        ["x"] = 492.7;
        ["g"] = 1;
      };
      [2] = {
        ["sublevel"] = 1;
        ["y"] = -246.6;
        ["x"] = 495.5;
        ["g"] = 1;
      };
      [3] = {
        ["sublevel"] = 1;
        ["y"] = -261.3;
        ["x"] = 493.7;
        ["g"] = 2;
      };
      [4] = {
        ["sublevel"] = 1;
        ["y"] = -277;
        ["x"] = 494.1;
        ["g"] = 3;
      };
      [5] = {
        ["sublevel"] = 1;
        ["y"] = -282;
        ["x"] = 493.9;
        ["g"] = 3;
      };
      [6] = {
        ["sublevel"] = 1;
        ["y"] = -352.5;
        ["x"] = 490.6;
        ["g"] = 4;
      };
      [7] = {
        ["sublevel"] = 1;
        ["y"] = -380.1;
        ["x"] = 501.7;
        ["g"] = 5;
      };
      [8] = {
        ["sublevel"] = 1;
        ["y"] = -384.8;
        ["x"] = 501.7;
        ["g"] = 5;
      };
      [9] = {
        ["sublevel"] = 1;
        ["y"] = -346.2;
        ["x"] = 459.8;
      };
      [10] = {
        ["sublevel"] = 1;
        ["y"] = -416.8;
        ["x"] = 450.1;
        ["g"] = 6;
      };
      [11] = {
        ["sublevel"] = 1;
        ["y"] = -408.2;
        ["x"] = 433;
        ["g"] = 6;
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
        ["sublevel"] = 1;
        ["y"] = -246;
        ["x"] = 489.1;
        ["g"] = 1;
      };
      [2] = {
        ["sublevel"] = 1;
        ["y"] = -264;
        ["x"] = 490.5;
        ["g"] = 2;
      };
      [3] = {
        ["sublevel"] = 1;
        ["y"] = -266.5;
        ["x"] = 493.9;
        ["g"] = 2;
      };
      [4] = {
        ["sublevel"] = 1;
        ["y"] = -278.9;
        ["x"] = 497.5;
        ["g"] = 3;
      };
      [5] = {
        ["sublevel"] = 1;
        ["y"] = -347.6;
        ["x"] = 494.2;
        ["g"] = 4;
      };
      [6] = {
        ["sublevel"] = 1;
        ["y"] = -352.6;
        ["x"] = 497.6;
        ["g"] = 4;
      };
      [7] = {
        ["sublevel"] = 1;
        ["y"] = -383.9;
        ["x"] = 497.6;
        ["g"] = 5;
      };
      [8] = {
        ["sublevel"] = 1;
        ["y"] = -369.1;
        ["x"] = 462.9;
      };
      [9] = {
        ["sublevel"] = 1;
        ["y"] = -396.7;
        ["x"] = 450.9;
        ["g"] = 6;
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
        ["sublevel"] = 1;
        ["y"] = -210.1;
        ["x"] = 420.8;
      };
      [2] = {
        ["sublevel"] = 1;
        ["y"] = -231.9;
        ["x"] = 436.3;
      };
      [3] = {
        ["sublevel"] = 1;
        ["y"] = -242.8;
        ["x"] = 416.7;
      };
      [4] = {
        ["sublevel"] = 1;
        ["y"] = -310.7;
        ["x"] = 415.6;
      };
      [5] = {
        ["sublevel"] = 1;
        ["y"] = -281.1;
        ["x"] = 416.5;
      };
      [6] = {
        ["sublevel"] = 1;
        ["y"] = -288.8;
        ["x"] = 435.3;
      };
      [7] = {
        ["sublevel"] = 1;
        ["y"] = -264.1;
        ["x"] = 435.5;
      };
      [8] = {
        ["sublevel"] = 1;
        ["y"] = -259.8;
        ["x"] = 422.7;
      };
      [9] = {
        ["sublevel"] = 1;
        ["y"] = -422.2;
        ["x"] = 320.9;
      };
      [10] = {
        ["sublevel"] = 1;
        ["y"] = -402.2;
        ["x"] = 322.4;
      };
      [11] = {
        ["sublevel"] = 1;
        ["y"] = -394.1;
        ["x"] = 341.5;
      };
      [12] = {
        ["sublevel"] = 1;
        ["y"] = -408.9;
        ["x"] = 283.1;
      };
      [13] = {
        ["sublevel"] = 1;
        ["y"] = -362.2;
        ["x"] = 341.1;
      };
      [14] = {
        ["sublevel"] = 1;
        ["y"] = -361.5;
        ["x"] = 315.9;
      };
      [15] = {
        ["sublevel"] = 1;
        ["y"] = -353.2;
        ["x"] = 290.3;
      };
      [16] = {
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
        ["sublevel"] = 1;
        ["y"] = -385.3;
        ["x"] = 485;
        ["g"] = 7;
      };
      [2] = {
        ["sublevel"] = 1;
        ["y"] = -446.3;
        ["x"] = 260.9;
        ["g"] = 8;
      };
      [3] = {
        ["sublevel"] = 1;
        ["y"] = -418.4;
        ["x"] = 251.2;
        ["g"] = 9;
      };
      [4] = {
        ["sublevel"] = 1;
        ["y"] = -375.7;
        ["x"] = 276.8;
        ["g"] = 10;
      };
      [5] = {
        ["sublevel"] = 1;
        ["y"] = -299.8;
        ["x"] = 292.6;
        ["g"] = 11;
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
        ["sublevel"] = 1;
        ["y"] = -383.2;
        ["x"] = 481.1;
        ["g"] = 7;
      };
      [2] = {
        ["sublevel"] = 1;
        ["y"] = -464;
        ["x"] = 288.7;
        ["g"] = 12;
      };
      [3] = {
        ["sublevel"] = 1;
        ["y"] = -457.5;
        ["x"] = 266.9;
        ["g"] = 8;
      };
      [4] = {
        ["sublevel"] = 1;
        ["y"] = -450.5;
        ["x"] = 267.2;
        ["g"] = 8;
      };
      [5] = {
        ["sublevel"] = 1;
        ["y"] = -416.1;
        ["x"] = 256.4;
        ["g"] = 9;
      };
      [6] = {
        ["sublevel"] = 1;
        ["y"] = -373.2;
        ["x"] = 274.3;
        ["g"] = 10;
      };
      [7] = {
        ["sublevel"] = 1;
        ["y"] = -299.6;
        ["x"] = 301.8;
        ["g"] = 11;
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
        ["sublevel"] = 1;
        ["y"] = -455.6;
        ["x"] = 416.5;
      };
      [2] = {
        ["sublevel"] = 1;
        ["y"] = -409.4;
        ["x"] = 394.6;
        ["g"] = 13;
      };
      [3] = {
        ["sublevel"] = 1;
        ["y"] = -409.5;
        ["x"] = 387.6;
        ["g"] = 13;
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
        ["sublevel"] = 1;
        ["y"] = -437.5;
        ["x"] = 407;
      };
      [2] = {
        ["sublevel"] = 1;
        ["y"] = -423.1;
        ["x"] = 390.8;
      };
      [3] = {
        ["sublevel"] = 1;
        ["y"] = -398.3;
        ["x"] = 391;
      };
      [4] = {
        ["sublevel"] = 1;
        ["y"] = -399;
        ["x"] = 401.3;
      };
      [5] = {
        ["sublevel"] = 1;
        ["y"] = -356.4;
        ["x"] = 383.6;
      };
      [6] = {
        ["sublevel"] = 1;
        ["y"] = -356.6;
        ["x"] = 396.8;
      };
      [7] = {
        ["sublevel"] = 1;
        ["y"] = -368.9;
        ["x"] = 401.7;
      };
      [8] = {
        ["sublevel"] = 1;
        ["y"] = -376.8;
        ["x"] = 391;
      };
      [9] = {
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
        ["sublevel"] = 1;
        ["y"] = -457.5;
        ["x"] = 293.4;
        ["g"] = 12;
      };
      [2] = {
        ["sublevel"] = 1;
        ["y"] = -464.7;
        ["x"] = 304.3;
        ["g"] = 12;
      };
      [3] = {
        ["sublevel"] = 1;
        ["y"] = -453.6;
        ["x"] = 260.2;
        ["g"] = 8;
      };
      [4] = {
        ["sublevel"] = 1;
        ["y"] = -372.7;
        ["x"] = 279.8;
        ["g"] = 10;
      };
      [5] = {
        ["sublevel"] = 1;
        ["y"] = -251.3;
        ["x"] = 295.2;
        ["g"] = 14;
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
        ["sublevel"] = 1;
        ["y"] = -457.7;
        ["x"] = 301.5;
        ["g"] = 12;
      };
      [2] = {
        ["sublevel"] = 1;
        ["y"] = -370.1;
        ["x"] = 276.7;
        ["g"] = 10;
      };
      [3] = {
        ["sublevel"] = 1;
        ["y"] = -299.8;
        ["x"] = 285;
        ["g"] = 11;
      };
      [4] = {
        ["sublevel"] = 1;
        ["y"] = -251.6;
        ["x"] = 285;
        ["g"] = 14;
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
        ["sublevel"] = 1;
        ["y"] = -437.2;
        ["x"] = 329.4;
      };
      [2] = {
        ["sublevel"] = 1;
        ["y"] = -354.5;
        ["x"] = 253.8;
      };
      [3] = {
        ["sublevel"] = 1;
        ["y"] = -274.7;
        ["x"] = 286.8;
        ["g"] = 15;
      };
      [4] = {
        ["sublevel"] = 1;
        ["y"] = -274.7;
        ["x"] = 294;
        ["g"] = 15;
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
        ["sublevel"] = 1;
        ["y"] = -269.2;
        ["x"] = 292.1;
        ["g"] = 15;
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
        ["sublevel"] = 1;
        ["y"] = -280.8;
        ["x"] = 199.9;
      };
      [2] = {
        ["sublevel"] = 1;
        ["y"] = -305.5;
        ["x"] = 178.8;
      };
      [3] = {
        ["sublevel"] = 1;
        ["y"] = -312.6;
        ["x"] = 219.8;
      };
      [4] = {
        ["sublevel"] = 1;
        ["y"] = -338.6;
        ["x"] = 192.1;
      };
      [5] = {
        ["sublevel"] = 1;
        ["y"] = -337.4;
        ["x"] = 213.6;
      };
      [6] = {
        ["sublevel"] = 1;
        ["y"] = -334.9;
        ["x"] = 228.5;
      };
      [7] = {
        ["sublevel"] = 1;
        ["y"] = -385;
        ["x"] = 220;
        ["g"] = 16;
      };
      [8] = {
        ["sublevel"] = 1;
        ["y"] = -382.1;
        ["x"] = 211.3;
        ["g"] = 16;
      };
      [9] = {
        ["sublevel"] = 1;
        ["y"] = -389.3;
        ["x"] = 204.1;
        ["g"] = 16;
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
        ["sublevel"] = 1;
        ["y"] = -281.3;
        ["x"] = 390.6;
        ["g"] = 17;
      };
      [2] = {
        ["sublevel"] = 1;
        ["y"] = -276.5;
        ["x"] = 402.6;
        ["g"] = 17;
      };
      [3] = {
        ["sublevel"] = 1;
        ["y"] = -276.1;
        ["x"] = 381.3;
        ["g"] = 17;
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
        ["sublevel"] = 1;
        ["y"] = -266.4;
        ["x"] = 390.8;
        ["g"] = 17;
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
        ["sublevel"] = 1;
        ["y"] = -201.1;
        ["x"] = 390.6;
        ["g"] = 18;
      };
      [2] = {
        ["sublevel"] = 1;
        ["y"] = -179.1;
        ["x"] = 375.9;
        ["g"] = 19;
      };
      [3] = {
        ["sublevel"] = 1;
        ["y"] = -180.1;
        ["x"] = 403.8;
        ["g"] = 20;
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
        ["sublevel"] = 1;
        ["y"] = -197.7;
        ["x"] = 390.9;
        ["g"] = 18;
      };
      [2] = {
        ["sublevel"] = 1;
        ["y"] = -176;
        ["x"] = 375.9;
        ["g"] = 19;
      };
      [3] = {
        ["sublevel"] = 1;
        ["y"] = -176.9;
        ["x"] = 403.5;
        ["g"] = 20;
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
        ["sublevel"] = 1;
        ["y"] = -144.8;
        ["x"] = 389.9;
      };
    };
  };
};
