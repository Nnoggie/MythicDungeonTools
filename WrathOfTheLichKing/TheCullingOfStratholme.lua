local MDT = MDT
local L = MDT.L

local dungeonIndex = 60
MDT.dungeonList[dungeonIndex] = L["The Culling of Stratholme"]
MDT.mapInfo[dungeonIndex] = {
  viewportPositionOverrides = {
    [2] = {
      zoomScale = 1.2999999523163;
      horizontalPan = 96.255301137603;
      verticalPan = 11.715346580575;
    };
  }
};

MDT.dungeonMaps[dungeonIndex] = {
  [0] = "cotstratholme",
  [1] = "cotstratholme",
  [2] = "cotstratholme1_",
}

MDT.dungeonSubLevels[dungeonIndex] = {
  [1] = L["The Culling of Stratholme"],
  [2] = L["Stratholme City"],
}

MDT.dungeonTotalCount[dungeonIndex] = { normal = 300, teeming = 1000, teemingEnabled = true }

MDT.mapPOIs[dungeonIndex] = {
  [1] = {
    [1] = {
      ["template"] = "MapLinkPinTemplate";
      ["type"] = "mapLink";
      ["x"] = 398;
      ["y"] = -134.8;
      ["target"] = 2;
      ["direction"] = 1;
      ["connectionIndex"] = 1;
    };
  };
  [2] = {
    [1] = {
      ["template"] = "MapLinkPinTemplate";
      ["type"] = "mapLink";
      ["x"] = 425.83267135035;
      ["y"] = -419.62397746892;
      ["target"] = 1;
      ["direction"] = -1;
      ["connectionIndex"] = 1;
    };
  };
};

MDT.dungeonEnemies[dungeonIndex] = {
  [1] = {
    ["name"] = "Enraging Ghoul";
    ["id"] = 27729;
    ["count"] = 0;
    ["health"] = 12345;
    ["scale"] = 1;
    ["displayId"] = 519;
    ["creatureType"] = "Undead";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["sublevel"] = 2;
        ["y"] = -354.9;
        ["x"] = 442.9;
        ["g"] = 1;
      };
      [2] = {
        ["sublevel"] = 2;
        ["y"] = -234.1;
        ["x"] = 507.9;
        ["g"] = 2;
        ["patrol"] = {
          [1] = {
            ["y"] = -217.1;
            ["x"] = 481.3;
          };
          [2] = {
            ["y"] = -218.1;
            ["x"] = 498;
          };
          [3] = {
            ["y"] = -225.7;
            ["x"] = 504.5;
          };
          [4] = {
            ["y"] = -229.6;
            ["x"] = 505.4;
          };
          [5] = {
            ["y"] = -240.8;
            ["x"] = 505;
          };
        };
      };
      [3] = {
        ["sublevel"] = 2;
        ["y"] = -348.6;
        ["x"] = 456.9;
        ["g"] = 3;
        ["patrol"] = {
          [1] = {
            ["y"] = -345.7;
            ["x"] = 457.9;
          };
          [2] = {
            ["y"] = -349.9;
            ["x"] = 447.7;
          };
          [3] = {
            ["y"] = -351.2;
            ["x"] = 444.4;
          };
          [4] = {
            ["y"] = -352.8;
            ["x"] = 433.9;
          };
          [5] = {
            ["y"] = -351.9;
            ["x"] = 428.4;
          };
        };
      };
      [4] = {
        ["sublevel"] = 2;
        ["y"] = -230;
        ["x"] = 488.8;
        ["g"] = 4;
      };
      [5] = {
        ["sublevel"] = 2;
        ["y"] = -222;
        ["x"] = 486.9;
        ["g"] = 4;
      };
      [6] = {
        ["sublevel"] = 2;
        ["y"] = -224.5;
        ["x"] = 494.8;
        ["g"] = 4;
      };
      [7] = {
        ["sublevel"] = 2;
        ["y"] = -338.7;
        ["x"] = 453.9;
        ["g"] = 5;
      };
      [8] = {
        ["sublevel"] = 2;
        ["y"] = -339.4;
        ["x"] = 445.1;
        ["g"] = 5;
      };
    };
  };
  [2] = {
    ["name"] = "Devouring Ghoul";
    ["id"] = 28249;
    ["count"] = 0;
    ["health"] = 12345;
    ["scale"] = 1;
    ["displayId"] = 569;
    ["creatureType"] = "Undead";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["sublevel"] = 2;
        ["y"] = -359;
        ["x"] = 443.1;
        ["g"] = 1;
      };
      [2] = {
        ["sublevel"] = 2;
        ["y"] = -355;
        ["x"] = 447.5;
        ["g"] = 1;
      };
      [3] = {
        ["sublevel"] = 2;
        ["y"] = -237.8;
        ["x"] = 512;
        ["g"] = 2;
      };
      [4] = {
        ["sublevel"] = 2;
        ["y"] = -353.2;
        ["x"] = 456.3;
        ["g"] = 3;
      };
      [5] = {
        ["sublevel"] = 2;
        ["y"] = -377;
        ["x"] = 374.8;
        ["g"] = 6;
        ["patrol"] = {
          [1] = {
            ["y"] = -380;
            ["x"] = 374.2;
          };
          [2] = {
            ["y"] = -363.8;
            ["x"] = 378.2;
          };
          [3] = {
            ["y"] = -351.9;
            ["x"] = 385;
          };
          [4] = {
            ["y"] = -349;
            ["x"] = 390.6;
          };
          [5] = {
            ["y"] = -349;
            ["x"] = 396.6;
          };
        };
      };
      [6] = {
        ["sublevel"] = 2;
        ["y"] = -215.1;
        ["x"] = 476.8;
        ["g"] = 7;
      };
      [7] = {
        ["sublevel"] = 2;
        ["y"] = -57.1;
        ["x"] = 535.9;
      };
      [8] = {
        ["sublevel"] = 2;
        ["y"] = -63.5;
        ["x"] = 503.8;
        ["g"] = 8;
      };
      [9] = {
        ["sublevel"] = 2;
        ["y"] = -66.4;
        ["x"] = 484.9;
      };
      [10] = {
        ["sublevel"] = 2;
        ["y"] = -80;
        ["x"] = 458.8;
      };
      [11] = {
        ["sublevel"] = 2;
        ["y"] = -91.8;
        ["x"] = 421;
      };
      [12] = {
        ["sublevel"] = 2;
        ["y"] = -109.5;
        ["x"] = 388.4;
      };
      [13] = {
        ["sublevel"] = 2;
        ["y"] = -101.6;
        ["x"] = 364.2;
      };
      [14] = {
        ["sublevel"] = 2;
        ["y"] = -128.2;
        ["x"] = 347.5;
      };
      [15] = {
        ["sublevel"] = 2;
        ["y"] = -136.6;
        ["x"] = 318;
      };
    };
  };
  [3] = {
    ["name"] = "Dark Necromancer";
    ["id"] = 28200;
    ["count"] = 0;
    ["health"] = 12345;
    ["scale"] = 1;
    ["displayId"] = 25200;
    ["creatureType"] = "Humanoid";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["sublevel"] = 2;
        ["y"] = -230.7;
        ["x"] = 512.2;
        ["g"] = 2;
      };
      [2] = {
        ["sublevel"] = 2;
        ["y"] = -352.9;
        ["x"] = 462.1;
        ["g"] = 3;
      };
      [3] = {
        ["sublevel"] = 2;
        ["y"] = -377.6;
        ["x"] = 382.6;
        ["g"] = 6;
      };
      [4] = {
        ["sublevel"] = 2;
        ["y"] = -335.7;
        ["x"] = 449;
        ["g"] = 5;
      };
    };
  };
  [4] = {
    ["name"] = "Crypt Fiend";
    ["id"] = 27734;
    ["count"] = 0;
    ["health"] = 12345;
    ["scale"] = 1;
    ["displayId"] = 9793;
    ["creatureType"] = "Undead";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["sublevel"] = 2;
        ["y"] = -347.8;
        ["x"] = 461.3;
        ["g"] = 3;
      };
      [2] = {
        ["sublevel"] = 2;
        ["y"] = -217.8;
        ["x"] = 507.9;
        ["g"] = 9;
      };
      [3] = {
        ["sublevel"] = 2;
        ["y"] = -381.1;
        ["x"] = 378.6;
        ["g"] = 6;
      };
      [4] = {
        ["sublevel"] = 2;
        ["y"] = -210.9;
        ["x"] = 471.2;
        ["g"] = 7;
      };
      [5] = {
        ["sublevel"] = 2;
        ["y"] = -62.9;
        ["x"] = 512.2;
        ["g"] = 8;
      };
    };
  };
  [5] = {
    ["name"] = "Acolyte";
    ["id"] = 27731;
    ["count"] = 0;
    ["health"] = 12345;
    ["scale"] = 1;
    ["displayId"] = 24766;
    ["creatureType"] = "Humanoid";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["sublevel"] = 2;
        ["y"] = -210;
        ["x"] = 509.6;
        ["g"] = 9;
      };
      [2] = {
        ["sublevel"] = 2;
        ["y"] = -212.5;
        ["x"] = 504;
        ["g"] = 9;
      };
      [3] = {
        ["sublevel"] = 2;
        ["y"] = -211.9;
        ["x"] = 515.2;
        ["g"] = 9;
      };
      [4] = {
        ["sublevel"] = 2;
        ["y"] = -59.3;
        ["x"] = 511.2;
        ["g"] = 8;
      };
      [5] = {
        ["sublevel"] = 2;
        ["y"] = -65.4;
        ["x"] = 508.4;
        ["g"] = 8;
      };
      [6] = {
        ["sublevel"] = 2;
        ["y"] = -59.5;
        ["x"] = 506.1;
        ["g"] = 8;
      };
      [7] = {
        ["sublevel"] = 2;
        ["y"] = -120.2;
        ["x"] = 376.9;
        ["g"] = 10;
      };
    };
  };
  [6] = {
    ["name"] = "Master Necromancer";
    ["id"] = 27732;
    ["count"] = 0;
    ["health"] = 12345;
    ["scale"] = 1;
    ["displayId"] = 24767;
    ["creatureType"] = "Humanoid";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["sublevel"] = 2;
        ["y"] = -217.5;
        ["x"] = 514.2;
        ["g"] = 9;
      };
      [2] = {
        ["sublevel"] = 2;
        ["y"] = -221.2;
        ["x"] = 474.8;
        ["g"] = 7;
      };
    };
  };
  [7] = {
    ["name"] = "Meathook";
    ["id"] = 26529;
    ["count"] = 0;
    ["health"] = 12345;
    ["scale"] = 1;
    ["displayId"] = 26579;
    ["creatureType"] = "Undead";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["sublevel"] = 2;
        ["y"] = -320.2;
        ["x"] = 387.6;
        ["patrol"] = {
          [1] = {
            ["y"] = -309.5;
            ["x"] = 391.5;
          };
          [2] = {
            ["y"] = -333.2;
            ["x"] = 392.5;
          };
        };
      };
    };
  };
  [8] = {
    ["name"] = "Tomb Stalker";
    ["id"] = 28199;
    ["count"] = 0;
    ["health"] = 12345;
    ["scale"] = 1;
    ["displayId"] = 25199;
    ["creatureType"] = "Undead";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["sublevel"] = 2;
        ["y"] = -373.4;
        ["x"] = 379.4;
        ["g"] = 6;
      };
      [2] = {
        ["sublevel"] = 2;
        ["y"] = -124.8;
        ["x"] = 373.6;
        ["g"] = 10;
      };
    };
  };
  [9] = {
    ["name"] = "Bile Golem";
    ["id"] = 28201;
    ["count"] = 0;
    ["health"] = 12345;
    ["scale"] = 1;
    ["displayId"] = 25281;
    ["creatureType"] = "Undead";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["sublevel"] = 2;
        ["y"] = -231.8;
        ["x"] = 496.2;
        ["g"] = 4;
      };
      [2] = {
        ["sublevel"] = 2;
        ["y"] = -66.9;
        ["x"] = 470.9;
        ["patrol"] = {
          [1] = {
            ["y"] = -77;
            ["x"] = 448.7;
          };
          [2] = {
            ["y"] = -58.4;
            ["x"] = 482.3;
          };
          [3] = {
            ["y"] = -57.6;
            ["x"] = 515.9;
          };
        };
      };
      [3] = {
        ["sublevel"] = 2;
        ["y"] = -113.7;
        ["x"] = 357.7;
        ["patrol"] = {
          [1] = {
            ["y"] = -120.5;
            ["x"] = 340.9;
          };
          [2] = {
            ["y"] = -106;
            ["x"] = 377.1;
          };
          [3] = {
            ["y"] = -102.9;
            ["x"] = 385.9;
          };
        };
      };
    };
  };
  [10] = {
    ["name"] = "Patchwork Construct";
    ["id"] = 27736;
    ["count"] = 0;
    ["health"] = 12345;
    ["scale"] = 1;
    ["displayId"] = 25282;
    ["creatureType"] = "Undead";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["sublevel"] = 2;
        ["y"] = -342.4;
        ["x"] = 449.7;
        ["g"] = 5;
      };
      [2] = {
        ["sublevel"] = 2;
        ["y"] = -217.2;
        ["x"] = 469;
        ["g"] = 7;
      };
    };
  };
  [11] = {
    ["name"] = "Salramm the Fleshcrafter";
    ["id"] = 26530;
    ["count"] = 0;
    ["health"] = 12345;
    ["scale"] = 1;
    ["displayId"] = 26581;
    ["creatureType"] = "Humanoid";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["sublevel"] = 2;
        ["y"] = -320.5;
        ["x"] = 397.2;
      };
    };
  };
  [12] = {
    ["name"] = "Infinite Hunter";
    ["id"] = 27743;
    ["count"] = 0;
    ["health"] = 12345;
    ["scale"] = 1;
    ["displayId"] = 19058;
    ["creatureType"] = "Dragonkin";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["sublevel"] = 2;
        ["y"] = -183.5;
        ["x"] = 486;
        ["g"] = 11;
      };
      [2] = {
        ["sublevel"] = 2;
        ["y"] = -158.3;
        ["x"] = 495;
        ["g"] = 12;
      };
      [3] = {
        ["sublevel"] = 2;
        ["y"] = -168.9;
        ["x"] = 536.6;
        ["g"] = 13;
      };
      [4] = {
        ["sublevel"] = 2;
        ["y"] = -175.4;
        ["x"] = 530.2;
        ["g"] = 13;
      };
      [5] = {
        ["sublevel"] = 2;
        ["y"] = -155.7;
        ["x"] = 551;
        ["g"] = 14;
      };
    };
  };
  [13] = {
    ["name"] = "Infinite Agent";
    ["id"] = 27744;
    ["count"] = 0;
    ["health"] = 12345;
    ["scale"] = 1;
    ["displayId"] = 19061;
    ["creatureType"] = "Dragonkin";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["sublevel"] = 2;
        ["y"] = -175.9;
        ["x"] = 481.2;
        ["g"] = 11;
      };
      [2] = {
        ["sublevel"] = 2;
        ["y"] = -154.7;
        ["x"] = 499.4;
        ["g"] = 12;
      };
      [3] = {
        ["sublevel"] = 2;
        ["y"] = -154.6;
        ["x"] = 491.9;
        ["g"] = 12;
      };
      [4] = {
        ["sublevel"] = 2;
        ["y"] = -174.3;
        ["x"] = 514.8;
        ["g"] = 13;
      };
      [5] = {
        ["sublevel"] = 2;
        ["y"] = -149.6;
        ["x"] = 558.6;
        ["g"] = 14;
      };
    };
  };
  [14] = {
    ["name"] = "Infinite Adversary";
    ["id"] = 27742;
    ["count"] = 0;
    ["health"] = 12345;
    ["scale"] = 1;
    ["displayId"] = 19059;
    ["creatureType"] = "Dragonkin";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["sublevel"] = 2;
        ["y"] = -182.4;
        ["x"] = 478.7;
        ["g"] = 11;
      };
      [2] = {
        ["sublevel"] = 2;
        ["y"] = -151.3;
        ["x"] = 495.9;
        ["g"] = 12;
      };
      [3] = {
        ["sublevel"] = 2;
        ["y"] = -167.4;
        ["x"] = 529.4;
        ["g"] = 13;
      };
      [4] = {
        ["sublevel"] = 2;
        ["y"] = -154.8;
        ["x"] = 564.6;
        ["g"] = 14;
      };
      [5] = {
        ["sublevel"] = 2;
        ["y"] = -159.7;
        ["x"] = 558.8;
        ["g"] = 14;
      };
    };
  };
  [15] = {
    ["name"] = "Chrono-Lord Epoch";
    ["id"] = 26532;
    ["count"] = 0;
    ["health"] = 12345;
    ["scale"] = 1;
    ["displayId"] = 26580;
    ["creatureType"] = "Dragonkin";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["sublevel"] = 2;
        ["y"] = -133.3;
        ["x"] = 553;
      };
    };
  };
  [16] = {
    ["name"] = "Mal'Ganis";
    ["id"] = 26533;
    ["count"] = 0;
    ["health"] = 12345;
    ["scale"] = 1;
    ["displayId"] = 26582;
    ["creatureType"] = "Demon";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["sublevel"] = 2;
        ["y"] = -258.7;
        ["x"] = 267.8;
      };
    };
  };
};
