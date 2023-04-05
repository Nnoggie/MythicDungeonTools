local MDT = MDT
local L = MDT.L

local dungeonIndex = 51
MDT.dungeonList[dungeonIndex] = L["Uldaman: Legacy of Tyr"]
MDT.mapInfo[dungeonIndex] = {
  --  viewportPositionOverrides =
  --  {
  --    [1] = {
  --      zoomScale = 1.2999999523163;
  --      horizontalPan = 102.41712541524;
  --      verticalPan = 87.49594729527;
  --    };
  --  }
};

MDT.dungeonMaps[dungeonIndex] = {
  [0] = "uldamanlegacyoftyr",
  [1] = "uldamanlegacyoftyr1_",
  [2] = "uldamanlegacyoftyr2_",
}

MDT.dungeonSubLevels[dungeonIndex] = {
  [1] = L["Hall of the Keepers"],
  [2] = L["The Vault of Tyr"],
}

MDT.dungeonTotalCount[dungeonIndex] = { normal = 575, teeming = 1000, teemingEnabled = true }

MDT.mapPOIs[dungeonIndex] = {
  [1] = {
    [1] = {
      ["template"] = "MapLinkPinTemplate";
      ["type"] = "mapLink";
      ["target"] = 2;
      ["direction"] = 2;
      ["connectionIndex"] = 1;
      ["y"] = -88.3;
      ["x"] = 235.5;
    };
  };
  [2] = {
    [1] = {
      ["template"] = "MapLinkPinTemplate";
      ["type"] = "mapLink";
      ["target"] = 1;
      ["direction"] = -2;
      ["connectionIndex"] = 1;
      ["y"] = -457.7;
      ["x"] = 376;
    };
  };
};

MDT.dungeonEnemies[dungeonIndex] = {
  [1] = {
    ["name"] = "Scavenging Leaper";
    ["id"] = 184134;
    ["count"] = 1;
    ["health"] = 286202;
    ["scale"] = 1;
    ["displayId"] = 92697;
    ["creatureType"] = "Humanoid";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["sublevel"] = 1;
        ["y"] = -258.2;
        ["x"] = 696.2;
        ["g"] = 1;
      };
      [2] = {
        ["sublevel"] = 1;
        ["y"] = -258;
        ["x"] = 703.7;
        ["g"] = 1;
      };
      [3] = {
        ["sublevel"] = 1;
        ["y"] = -265.7;
        ["x"] = 695.9;
        ["g"] = 1;
      };
      [4] = {
        ["sublevel"] = 1;
        ["y"] = -265.9;
        ["x"] = 703.2;
        ["g"] = 1;
      };
      [5] = {
        ["sublevel"] = 1;
        ["y"] = -310.3;
        ["x"] = 704.1;
        ["g"] = 2;
      };
      [6] = {
        ["sublevel"] = 1;
        ["y"] = -315.9;
        ["x"] = 707;
        ["g"] = 2;
      };
      [7] = {
        ["sublevel"] = 1;
        ["y"] = -317;
        ["x"] = 713.1;
        ["g"] = 2;
      };
      [8] = {
        ["sublevel"] = 1;
        ["y"] = -311.6;
        ["x"] = 717.3;
        ["g"] = 2;
      };
      [9] = {
        ["sublevel"] = 1;
        ["y"] = -393.7;
        ["x"] = 583.7;
        ["g"] = 3;
      };
      [10] = {
        ["sublevel"] = 1;
        ["y"] = -394.1;
        ["x"] = 587.7;
        ["g"] = 3;
      };
      [11] = {
        ["sublevel"] = 1;
        ["y"] = -394.1;
        ["x"] = 591;
        ["g"] = 3;
      };
      [12] = {
        ["sublevel"] = 1;
        ["y"] = -393.8;
        ["x"] = 594.4;
        ["g"] = 3;
      };
    };
  };
  [2] = {
    ["name"] = "Stonevault Geomancer";
    ["id"] = 184022;
    ["count"] = 5;
    ["health"] = 644224;
    ["scale"] = 1;
    ["displayId"] = 92697;
    ["creatureType"] = "Humanoid";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["sublevel"] = 1;
        ["y"] = -310.6;
        ["x"] = 710.8;
        ["g"] = 2;
      };
      [2] = {
        ["sublevel"] = 1;
        ["y"] = -328.4;
        ["x"] = 678.6;
        ["g"] = 4;
      };
      [3] = {
        ["sublevel"] = 1;
        ["y"] = -328.2;
        ["x"] = 674.1;
        ["g"] = 4;
      };
      [4] = {
        ["sublevel"] = 1;
        ["y"] = -395.1;
        ["x"] = 620.2;
        ["g"] = 5;
      };
      [5] = {
        ["sublevel"] = 1;
        ["y"] = -395;
        ["x"] = 627.1;
        ["g"] = 5;
      };
      [6] = {
        ["sublevel"] = 1;
        ["y"] = -398.4;
        ["x"] = 593;
        ["g"] = 3;
      };
      [7] = {
        ["sublevel"] = 1;
        ["y"] = -398.6;
        ["x"] = 587.9;
        ["g"] = 3;
      };
      [8] = {
        ["sublevel"] = 1;
        ["y"] = -349.4;
        ["x"] = 540.4;
        ["g"] = 6;
      };
    };
  };
  [3] = {
    ["name"] = "Hulking Berserker";
    ["id"] = 184020;
    ["count"] = 15;
    ["health"] = 1073011;
    ["scale"] = 1;
    ["displayId"] = 92699;
    ["creatureType"] = "Humanoid";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["sublevel"] = 1;
        ["y"] = -288.5;
        ["x"] = 695;
        ["g"] = 7;
        ["patrol"] = {
          [1] = {
            ["y"] = -304;
            ["x"] = 709.5;
          };
          [2] = {
            ["y"] = -304;
            ["x"] = 712;
          };
          [3] = {
            ["y"] = -288.3;
            ["x"] = 712.3;
          };
          [4] = {
            ["y"] = -288.3;
            ["x"] = 674.7;
          };
          [5] = {
            ["y"] = -305.5;
            ["x"] = 674.3;
          };
          [6] = {
            ["y"] = -305.2;
            ["x"] = 677.8;
          };
          [7] = {
            ["y"] = -291;
            ["x"] = 677.9;
          };
          [8] = {
            ["y"] = -290.7;
            ["x"] = 709.6;
          };
          [9] = {
            ["y"] = -304.5;
            ["x"] = 709.4;
          };
        };
      };
      [2] = {
        ["sublevel"] = 1;
        ["y"] = -398.1;
        ["x"] = 623.5;
        ["g"] = 5;
      };
      [3] = {
        ["sublevel"] = 1;
        ["y"] = -346.5;
        ["x"] = 536.1;
        ["g"] = 6;
      };
      [4] = {
        ["sublevel"] = 1;
        ["y"] = -352.4;
        ["x"] = 536.1;
        ["g"] = 6;
      };
    };
  };
  [4] = {
    ["name"] = "Vicious Basilisk";
    ["id"] = 184023;
    ["count"] = 3;
    ["health"] = 572543;
    ["scale"] = 1;
    ["displayId"] = 103338;
    ["creatureType"] = "Beast";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["sublevel"] = 1;
        ["y"] = -291.4;
        ["x"] = 695.2;
        ["g"] = 7;
      };
      [2] = {
        ["sublevel"] = 1;
        ["y"] = -349;
        ["x"] = 626.3;
        ["g"] = 8;
      };
      [3] = {
        ["sublevel"] = 1;
        ["y"] = -350.8;
        ["x"] = 633.6;
        ["g"] = 8;
      };
      [4] = {
        ["sublevel"] = 1;
        ["y"] = -344.9;
        ["x"] = 630.4;
        ["g"] = 8;
      };
      [5] = {
        ["sublevel"] = 1;
        ["y"] = -432.2;
        ["x"] = 620.3;
        ["g"] = 9;
      };
      [6] = {
        ["sublevel"] = 1;
        ["y"] = -433.7;
        ["x"] = 625.7;
        ["g"] = 9;
      };
      [7] = {
        ["sublevel"] = 1;
        ["y"] = -351.4;
        ["x"] = 586.1;
        ["g"] = 10;
      };
      [8] = {
        ["sublevel"] = 1;
        ["y"] = -353.6;
        ["x"] = 591.6;
        ["g"] = 10;
      };
    };
  };
  [5] = {
    ["name"] = "Baelog";
    ["id"] = 184581;
    ["count"] = 0;
    ["health"] = 1787435;
    ["scale"] = 1;
    ["displayId"] = 105887;
    ["creatureType"] = "Humanoid";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["sublevel"] = 1;
        ["y"] = -474;
        ["x"] = 642.8;
        ["g"] = 11;
      };
    };
  };
  [6] = {
    ["name"] = "Olaf";
    ["id"] = 184580;
    ["count"] = 0;
    ["health"] = 1907986;
    ["scale"] = 1;
    ["displayId"] = 105883;
    ["creatureType"] = "Humanoid";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["sublevel"] = 1;
        ["y"] = -475.5;
        ["x"] = 649.7;
        ["g"] = 11;
      };
    };
  };
  [7] = {
    ["name"] = "Eric \"The Swift\"";
    ["id"] = 184582;
    ["count"] = 0;
    ["health"] = 1787435;
    ["scale"] = 1;
    ["displayId"] = 105884;
    ["creatureType"] = "Humanoid";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["sublevel"] = 1;
        ["y"] = -476.9;
        ["x"] = 656.3;
        ["g"] = 11;
      };
    };
  };
  [8] = {
    ["name"] = "Burly Rock-Thrower";
    ["id"] = 184019;
    ["count"] = 5;
    ["health"] = 715048;
    ["scale"] = 1;
    ["displayId"] = 765;
    ["creatureType"] = "Humanoid";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["sublevel"] = 1;
        ["y"] = -340.2;
        ["x"] = 586.7;
        ["g"] = 10;
      };
      [2] = {
        ["sublevel"] = 1;
        ["y"] = -343.5;
        ["x"] = 593.3;
        ["g"] = 10;
      };
      [3] = {
        ["sublevel"] = 1;
        ["y"] = -347.5;
        ["x"] = 599;
        ["g"] = 10;
      };
    };
  };
  [9] = {
    ["name"] = "Bromach";
    ["id"] = 184018;
    ["count"] = 0;
    ["health"] = 3572917;
    ["scale"] = 1;
    ["displayId"] = 107143;
    ["creatureType"] = "Humanoid";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["sublevel"] = 1;
        ["y"] = -356.3;
        ["x"] = 482;
      };
    };
  };
  [10] = {
    ["name"] = "Earthen Custodian";
    ["id"] = 184130;
    ["count"] = 4;
    ["health"] = 715048;
    ["scale"] = 1;
    ["displayId"] = 6025;
    ["creatureType"] = "Humanoid";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["sublevel"] = 1;
        ["y"] = -353.2;
        ["x"] = 418.1;
        ["g"] = 12;
        ["patrol"] = {
          [1] = {
            ["y"] = -340.7;
            ["x"] = 428.7;
          };
          [2] = {
            ["y"] = -368.6;
            ["x"] = 427.9;
          };
          [3] = {
            ["y"] = -368.4;
            ["x"] = 430.2;
          };
          [4] = {
            ["y"] = -340.5;
            ["x"] = 431;
          };
          [5] = {
            ["y"] = -340.7;
            ["x"] = 428.4;
          };
        };
      };
      [2] = {
        ["sublevel"] = 1;
        ["y"] = -359.5;
        ["x"] = 419.1;
        ["g"] = 12;
      };
      [3] = {
        ["sublevel"] = 1;
        ["y"] = -351;
        ["x"] = 253.3;
        ["g"] = 13;
      };
      [4] = {
        ["sublevel"] = 1;
        ["y"] = -350.5;
        ["x"] = 259.2;
        ["g"] = 13;
      };
      [5] = {
        ["sublevel"] = 1;
        ["y"] = -319.4;
        ["x"] = 251.2;
        ["g"] = 14;
      };
      [6] = {
        ["sublevel"] = 1;
        ["y"] = -314.4;
        ["x"] = 250.8;
        ["g"] = 14;
      };
      [7] = {
        ["sublevel"] = 1;
        ["y"] = -318.5;
        ["x"] = 212.2;
        ["g"] = 15;
      };
      [8] = {
        ["sublevel"] = 1;
        ["y"] = -338;
        ["x"] = 201.5;
        ["g"] = 16;
      };
      [9] = {
        ["sublevel"] = 1;
        ["y"] = -338.3;
        ["x"] = 206.6;
        ["g"] = 16;
      };
      [10] = {
        ["sublevel"] = 1;
        ["y"] = -300.5;
        ["x"] = 161.8;
        ["g"] = 17;
      };
      [11] = {
        ["sublevel"] = 1;
        ["y"] = -294.6;
        ["x"] = 161.6;
        ["g"] = 17;
      };
      [12] = {
        ["sublevel"] = 2;
        ["y"] = -465.6;
        ["x"] = 444;
        ["g"] = 18;
      };
      [13] = {
        ["sublevel"] = 2;
        ["y"] = -500.5;
        ["x"] = 498.7;
        ["g"] = 19;
      };
      [14] = {
        ["sublevel"] = 2;
        ["y"] = -494.3;
        ["x"] = 495.2;
        ["g"] = 19;
      };
      [15] = {
        ["sublevel"] = 2;
        ["y"] = -499.9;
        ["x"] = 525.2;
        ["g"] = 20;
        ["patrol"] = {
          [1] = {
            ["y"] = -495.4;
            ["x"] = 531.8;
          };
          [2] = {
            ["y"] = -503.8;
            ["x"] = 516.8;
          };
          [3] = {
            ["y"] = -503.6;
            ["x"] = 503.5;
          };
          [4] = {
            ["y"] = -487.4;
            ["x"] = 493.5;
          };
          [5] = {
            ["y"] = -485.3;
            ["x"] = 482.5;
          };
          [6] = {
            ["y"] = -487.1;
            ["x"] = 481.9;
          };
          [7] = {
            ["y"] = -489;
            ["x"] = 492.6;
          };
          [8] = {
            ["y"] = -505.6;
            ["x"] = 502.1;
          };
          [9] = {
            ["y"] = -505.5;
            ["x"] = 517.5;
          };
          [10] = {
            ["y"] = -497.1;
            ["x"] = 533.4;
          };
          [11] = {
            ["y"] = -495.4;
            ["x"] = 531.8;
          };
        };
      };
      [16] = {
        ["sublevel"] = 1;
        ["y"] = -369.9;
        ["x"] = 332.4;
        ["g"] = 21;
      };
      [17] = {
        ["sublevel"] = 1;
        ["y"] = -369.6;
        ["x"] = 340.9;
        ["g"] = 21;
      };
      [18] = {
        ["sublevel"] = 1;
        ["y"] = -252.4;
        ["x"] = 200.8;
        ["g"] = 22;
      };
      [19] = {
        ["sublevel"] = 1;
        ["y"] = -252.3;
        ["x"] = 207.2;
        ["g"] = 22;
      };
    };
  };
  [11] = {
    ["name"] = "Refti Custodian";
    ["id"] = 184319;
    ["count"] = 15;
    ["health"] = 1286806;
    ["scale"] = 1;
    ["displayId"] = 106782;
    ["creatureType"] = "Elemental";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["sublevel"] = 1;
        ["y"] = -366.5;
        ["x"] = 428.5;
        ["g"] = 12;
      };
      [2] = {
        ["sublevel"] = 1;
        ["y"] = -395.8;
        ["x"] = 428.5;
      };
      [3] = {
        ["sublevel"] = 1;
        ["y"] = -396.1;
        ["x"] = 337.4;
      };
    };
  };
  [12] = {
    ["name"] = "Sentinel Talondras";
    ["id"] = 184124;
    ["count"] = 0;
    ["health"] = 4492735;
    ["scale"] = 1;
    ["displayId"] = 109735;
    ["creatureType"] = "Giant";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["sublevel"] = 1;
        ["y"] = -395.8;
        ["x"] = 256.3;
      };
    };
  };
  [13] = {
    ["name"] = "Earthen Weaver";
    ["id"] = 186420;
    ["count"] = 5;
    ["health"] = 644224;
    ["scale"] = 1;
    ["displayId"] = 6026;
    ["creatureType"] = "Humanoid";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["sublevel"] = 1;
        ["y"] = -345.6;
        ["x"] = 255.8;
        ["g"] = 13;
      };
      [2] = {
        ["sublevel"] = 1;
        ["y"] = -318.5;
        ["x"] = 245.6;
        ["g"] = 14;
      };
      [3] = {
        ["sublevel"] = 1;
        ["y"] = -313.8;
        ["x"] = 245.2;
        ["g"] = 14;
      };
      [4] = {
        ["sublevel"] = 1;
        ["y"] = -314.5;
        ["x"] = 218.3;
        ["g"] = 15;
      };
      [5] = {
        ["sublevel"] = 1;
        ["y"] = -319.7;
        ["x"] = 218.3;
        ["g"] = 15;
      };
      [6] = {
        ["sublevel"] = 1;
        ["y"] = -293.3;
        ["x"] = 172.7;
        ["g"] = 17;
      };
      [7] = {
        ["sublevel"] = 2;
        ["y"] = -435.6;
        ["x"] = 391.1;
        ["g"] = 23;
      };
      [8] = {
        ["sublevel"] = 2;
        ["y"] = -430.9;
        ["x"] = 395.7;
        ["g"] = 23;
      };
      [9] = {
        ["sublevel"] = 2;
        ["y"] = -483.6;
        ["x"] = 420.5;
      };
      [10] = {
        ["sublevel"] = 2;
        ["y"] = -472;
        ["x"] = 437.5;
        ["g"] = 18;
      };
      [11] = {
        ["sublevel"] = 2;
        ["y"] = -474.1;
        ["x"] = 445.8;
        ["g"] = 18;
      };
      [12] = {
        ["sublevel"] = 1;
        ["y"] = -365.1;
        ["x"] = 336.4;
        ["g"] = 21;
      };
      [13] = {
        ["sublevel"] = 1;
        ["y"] = -422.1;
        ["x"] = 334.5;
        ["g"] = 24;
      };
      [14] = {
        ["sublevel"] = 1;
        ["y"] = -421.6;
        ["x"] = 341;
        ["g"] = 24;
      };
      [15] = {
        ["sublevel"] = 1;
        ["y"] = -240.2;
        ["x"] = 200.3;
        ["g"] = 22;
      };
      [16] = {
        ["sublevel"] = 1;
        ["y"] = -241;
        ["x"] = 207.4;
        ["g"] = 22;
      };
    };
  };
  [14] = {
    ["name"] = "Earthen Warder";
    ["id"] = 184132;
    ["count"] = 5;
    ["health"] = 644224;
    ["scale"] = 1;
    ["displayId"] = 6009;
    ["creatureType"] = "Humanoid";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["sublevel"] = 1;
        ["y"] = -284.5;
        ["x"] = 221.9;
        ["g"] = 25;
      };
      [2] = {
        ["sublevel"] = 1;
        ["y"] = -277.3;
        ["x"] = 222.2;
        ["g"] = 25;
      };
      [3] = {
        ["sublevel"] = 1;
        ["y"] = -301.6;
        ["x"] = 172.6;
        ["g"] = 17;
      };
      [4] = {
        ["sublevel"] = 2;
        ["y"] = -505.1;
        ["x"] = 526.9;
        ["g"] = 20;
      };
      [5] = {
        ["sublevel"] = 2;
        ["y"] = -427.2;
        ["x"] = 514.9;
        ["g"] = 26;
      };
      [6] = {
        ["sublevel"] = 2;
        ["y"] = -423.3;
        ["x"] = 523.4;
        ["g"] = 26;
      };
      [7] = {
        ["sublevel"] = 2;
        ["y"] = -395.2;
        ["x"] = 499.6;
        ["g"] = 27;
      };
      [8] = {
        ["sublevel"] = 2;
        ["y"] = -392.3;
        ["x"] = 505.7;
        ["g"] = 27;
      };
      [9] = {
        ["sublevel"] = 1;
        ["y"] = -246.3;
        ["x"] = 204.1;
        ["g"] = 22;
      };
    };
  };
  [15] = {
    ["name"] = "Runic Protector";
    ["id"] = 184107;
    ["count"] = 25;
    ["health"] = 1147152;
    ["scale"] = 1;
    ["displayId"] = 108686;
    ["creatureType"] = "Elemental";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["sublevel"] = 1;
        ["y"] = -344;
        ["x"] = 203.5;
        ["g"] = 16;
      };
      [2] = {
        ["sublevel"] = 1;
        ["y"] = -297.5;
        ["x"] = 167.1;
        ["g"] = 17;
      };
    };
  };
  [16] = {
    ["name"] = "Skittering Crawler";
    ["id"] = 184303;
    ["count"] = 4;
    ["health"] = 572543;
    ["scale"] = 1;
    ["displayId"] = 84003;
    ["creatureType"] = "Beast";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["sublevel"] = 1;
        ["y"] = -295.6;
        ["x"] = 139.3;
        ["g"] = 28;
      };
      [2] = {
        ["sublevel"] = 1;
        ["y"] = -301.4;
        ["x"] = 137.5;
        ["g"] = 28;
      };
      [3] = {
        ["sublevel"] = 1;
        ["y"] = -216.3;
        ["x"] = 103.4;
        ["g"] = 29;
      };
      [4] = {
        ["sublevel"] = 1;
        ["y"] = -219.7;
        ["x"] = 107.3;
        ["g"] = 29;
      };
    };
  };
  [17] = {
    ["name"] = "Cavern Seeker";
    ["id"] = 184301;
    ["count"] = 4;
    ["health"] = 572649;
    ["scale"] = 1;
    ["displayId"] = 57297;
    ["creatureType"] = "Beast";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["sublevel"] = 1;
        ["y"] = -255.4;
        ["x"] = 94.2;
        ["g"] = 30;
      };
      [2] = {
        ["sublevel"] = 1;
        ["y"] = -257.7;
        ["x"] = 116.3;
        ["g"] = 30;
      };
      [3] = {
        ["sublevel"] = 1;
        ["y"] = -246.1;
        ["x"] = 106.8;
        ["g"] = 30;
      };
    };
  };
  [18] = {
    ["name"] = "Emberon";
    ["id"] = 184422;
    ["count"] = 0;
    ["health"] = 2981424;
    ["scale"] = 1;
    ["displayId"] = 107816;
    ["creatureType"] = "Giant";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["sublevel"] = 1;
        ["y"] = -116.4;
        ["x"] = 187.8;
      };
    };
  };
  [19] = {
    ["name"] = "Ebonstone Golem";
    ["id"] = 184300;
    ["count"] = 15;
    ["health"] = 1288534;
    ["scale"] = 1;
    ["displayId"] = 108689;
    ["creatureType"] = "Elemental";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["sublevel"] = 2;
        ["y"] = -435.9;
        ["x"] = 397.8;
        ["g"] = 23;
      };
      [2] = {
        ["sublevel"] = 2;
        ["y"] = -469.6;
        ["x"] = 450.8;
        ["g"] = 18;
      };
      [3] = {
        ["sublevel"] = 2;
        ["y"] = -471.1;
        ["x"] = 535.7;
        ["g"] = 31;
      };
      [4] = {
        ["sublevel"] = 2;
        ["y"] = -467.9;
        ["x"] = 542;
        ["g"] = 31;
      };
      [5] = {
        ["sublevel"] = 2;
        ["y"] = -422;
        ["x"] = 517.6;
        ["g"] = 26;
      };
      [6] = {
        ["sublevel"] = 2;
        ["y"] = -396.2;
        ["x"] = 504;
        ["g"] = 27;
      };
    };
  };
  [20] = {
    ["name"] = "Earthen Guardian";
    ["id"] = 184131;
    ["count"] = 15;
    ["health"] = 1145315;
    ["scale"] = 1;
    ["displayId"] = 6026;
    ["creatureType"] = "Humanoid";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["sublevel"] = 2;
        ["y"] = -501.2;
        ["x"] = 530.8;
        ["g"] = 20;
      };
    };
  };
  [21] = {
    ["name"] = "Infinite Agent";
    ["id"] = 184335;
    ["count"] = 5;
    ["health"] = 858652;
    ["scale"] = 1;
    ["displayId"] = 19058;
    ["creatureType"] = "Dragonkin";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["sublevel"] = 2;
        ["y"] = -361.1;
        ["x"] = 479.6;
        ["g"] = 32;
      };
      [2] = {
        ["sublevel"] = 2;
        ["y"] = -357.9;
        ["x"] = 487.5;
        ["g"] = 32;
      };
      [3] = {
        ["sublevel"] = 2;
        ["y"] = -335.4;
        ["x"] = 421;
      };
    };
  };
  [22] = {
    ["name"] = "Infinite Timereaver";
    ["id"] = 184331;
    ["count"] = 15;
    ["health"] = 1145172;
    ["scale"] = 1;
    ["displayId"] = 106470;
    ["creatureType"] = "Dragonkin";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["sublevel"] = 2;
        ["y"] = -373.4;
        ["x"] = 453.5;
      };
      [2] = {
        ["sublevel"] = 2;
        ["y"] = -315.9;
        ["x"] = 412.2;
      };
      [3] = {
        ["sublevel"] = 2;
        ["y"] = -285.9;
        ["x"] = 394.4;
        ["g"] = 33;
      };
      [4] = {
        ["sublevel"] = 2;
        ["y"] = -282.6;
        ["x"] = 399.8;
        ["g"] = 33;
      };
    };
  };
  [23] = {
    ["name"] = "Infinite Whelp";
    ["id"] = 191311;
    ["count"] = 1;
    ["health"] = 142809;
    ["scale"] = 1;
    ["displayId"] = 101939;
    ["creatureType"] = "Dragonkin";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["sublevel"] = 2;
        ["y"] = -299.2;
        ["x"] = 424.8;
        ["g"] = 34;
      };
      [2] = {
        ["sublevel"] = 2;
        ["y"] = -294.8;
        ["x"] = 422.5;
        ["g"] = 34;
      };
      [3] = {
        ["sublevel"] = 2;
        ["y"] = -290.1;
        ["x"] = 419.8;
        ["g"] = 34;
      };
      [4] = {
        ["sublevel"] = 2;
        ["y"] = -316.3;
        ["x"] = 388;
        ["g"] = 35;
      };
      [5] = {
        ["sublevel"] = 2;
        ["y"] = -314.4;
        ["x"] = 392.8;
        ["g"] = 35;
      };
      [6] = {
        ["sublevel"] = 2;
        ["y"] = -308.8;
        ["x"] = 390.6;
        ["g"] = 35;
      };
      [7] = {
        ["sublevel"] = 2;
        ["y"] = -310.7;
        ["x"] = 385.4;
        ["g"] = 35;
      };
      [8] = {
        ["sublevel"] = 2;
        ["y"] = -305.8;
        ["x"] = 383.2;
        ["g"] = 35;
      };
      [9] = {
        ["sublevel"] = 2;
        ["y"] = -303.2;
        ["x"] = 388.6;
        ["g"] = 35;
      };
    };
  };
  [24] = {
    ["name"] = "Chrono-Lord Deios";
    ["id"] = 184125;
    ["count"] = 0;
    ["health"] = 6559028;
    ["scale"] = 1;
    ["displayId"] = 106056;
    ["creatureType"] = "Dragonkin";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["sublevel"] = 2;
        ["y"] = -167.7;
        ["x"] = 344.2;
      };
    };
  };
};

