local MDT = MDT
local L = MDT.L
local dungeonIndex = 54
MDT.dungeonList[dungeonIndex] = L["Drak'Tharon Keep"]
MDT.mapInfo[dungeonIndex] = {
  viewportPositionOverrides = {
    [2] = {
      zoomScale = 1.2999999523163;
      horizontalPan = 38.290098748912;
      verticalPan = 8.056462321277;
    };
  }
};

MDT.dungeonMaps[dungeonIndex] = {
  [0] = "draktharonkeep",
  [1] = "draktharonkeep1_",
  [2] = "draktharonkeep2_",
}

MDT.dungeonSubLevels[dungeonIndex] = {
  [1] = L["The Vestibules of Drak'Tharon"],
  [2] = L["Drak'Tharon Overlook"],
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
      ["y"] = -401.6;
      ["x"] = 523.1;
    };
    [2] = {
      ["template"] = "MapLinkPinTemplate";
      ["type"] = "mapLink";
      ["target"] = 2;
      ["direction"] = 1;
      ["connectionIndex"] = 2;
      ["y"] = -74.2;
      ["x"] = 381.3;
    };
  };
  [2] = {
    [1] = {
      ["template"] = "MapLinkPinTemplate";
      ["type"] = "mapLink";
      ["target"] = 1;
      ["direction"] = -1;
      ["connectionIndex"] = 1;
      ["y"] = -402.2;
      ["x"] = 348.5;
    };
    [2] = {
      ["template"] = "MapLinkPinTemplate";
      ["type"] = "mapLink";
      ["target"] = 1;
      ["direction"] = -1;
      ["connectionIndex"] = 2;
      ["y"] = -76.4;
      ["x"] = 349.7;
    };
  };
};

MDT.dungeonEnemies[dungeonIndex] = {
  [1] = {
    ["name"] = "Risen Drakkari Warrior";
    ["id"] = 26635;
    ["count"] = 0;
    ["health"] = 12345;
    ["scale"] = 1;
    ["displayId"] = 27058;
    ["creatureType"] = "Undead";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["sublevel"] = 1;
        ["y"] = -479.6;
        ["x"] = 371.5;
        ["g"] = 1;
      };
      [2] = {
        ["sublevel"] = 1;
        ["y"] = -488.3;
        ["x"] = 371.5;
        ["g"] = 1;
      };
      [3] = {
        ["sublevel"] = 1;
        ["y"] = -414.8;
        ["x"] = 410.7;
        ["g"] = 2;
      };
      [4] = {
        ["sublevel"] = 1;
        ["y"] = -301;
        ["x"] = 405.2;
        ["g"] = 3;
      };
      [5] = {
        ["sublevel"] = 1;
        ["y"] = -242;
        ["x"] = 388.3;
        ["g"] = 4;
      };
      [6] = {
        ["sublevel"] = 1;
        ["y"] = -235.9;
        ["x"] = 387.3;
        ["g"] = 4;
      };
      [7] = {
        ["sublevel"] = 1;
        ["y"] = -246.1;
        ["x"] = 409;
        ["g"] = 4;
      };
      [8] = {
        ["sublevel"] = 2;
        ["y"] = -168.2;
        ["x"] = 317.9;
      };
      [9] = {
        ["sublevel"] = 2;
        ["y"] = -157.6;
        ["x"] = 310;
      };
    };
  };
  [2] = {
    ["name"] = "Risen Drakkari Soulmage";
    ["id"] = 26636;
    ["count"] = 0;
    ["health"] = 12345;
    ["scale"] = 1;
    ["displayId"] = 26857;
    ["creatureType"] = "Undead";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["sublevel"] = 1;
        ["y"] = -388.3;
        ["x"] = 400.7;
        ["g"] = 2;
      };
      [2] = {
        ["sublevel"] = 1;
        ["y"] = -317.2;
        ["x"] = 404.9;
        ["g"] = 3;
      };
      [3] = {
        ["sublevel"] = 1;
        ["y"] = -239.7;
        ["x"] = 407.1;
        ["g"] = 4;
      };
    };
  };
  [3] = {
    ["name"] = "Scourge Reanimator";
    ["id"] = 26626;
    ["count"] = 0;
    ["health"] = 12345;
    ["scale"] = 1;
    ["displayId"] = 24084;
    ["creatureType"] = "Humanoid";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["sublevel"] = 1;
        ["y"] = -409;
        ["x"] = 394.1;
        ["g"] = 2;
      };
      [2] = {
        ["sublevel"] = 1;
        ["y"] = -308.4;
        ["x"] = 397.8;
        ["g"] = 3;
      };
    };
  };
  [4] = {
    ["name"] = "Wretched Belcher";
    ["id"] = 26624;
    ["count"] = 0;
    ["health"] = 12345;
    ["scale"] = 1;
    ["displayId"] = 1693;
    ["creatureType"] = "Undead";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["sublevel"] = 1;
        ["y"] = -198.5;
        ["x"] = 452.2;
        ["patrol"] = {
          [1] = {
            ["y"] = -195.9;
            ["x"] = 450.5;
          };
          [2] = {
            ["y"] = -182.6;
            ["x"] = 447.8;
          };
          [3] = {
            ["y"] = -168.8;
            ["x"] = 454.4;
          };
          [4] = {
            ["y"] = -160.7;
            ["x"] = 462.2;
          };
          [5] = {
            ["y"] = -158.2;
            ["x"] = 471.5;
          };
          [6] = {
            ["y"] = -158;
            ["x"] = 480.8;
          };
          [7] = {
            ["y"] = -160.3;
            ["x"] = 486;
          };
          [8] = {
            ["y"] = -169.9;
            ["x"] = 479.8;
          };
          [9] = {
            ["y"] = -178.3;
            ["x"] = 475.5;
          };
          [10] = {
            ["y"] = -193.8;
            ["x"] = 463.2;
          };
          [11] = {
            ["y"] = -199.4;
            ["x"] = 454.9;
          };
        };
      };
      [2] = {
        ["sublevel"] = 1;
        ["y"] = -169.2;
        ["x"] = 485.3;
        ["patrol"] = {
          [1] = {
            ["y"] = -167.8;
            ["x"] = 486.4;
          };
          [2] = {
            ["y"] = -166.4;
            ["x"] = 497.7;
          };
          [3] = {
            ["y"] = -182.6;
            ["x"] = 500.1;
          };
          [4] = {
            ["y"] = -191.2;
            ["x"] = 492.6;
          };
          [5] = {
            ["y"] = -185.4;
            ["x"] = 486.4;
          };
          [6] = {
            ["y"] = -187.9;
            ["x"] = 481.4;
          };
          [7] = {
            ["y"] = -195.8;
            ["x"] = 478.5;
          };
          [8] = {
            ["y"] = -196;
            ["x"] = 473.6;
          };
          [9] = {
            ["y"] = -183.2;
            ["x"] = 474.8;
          };
          [10] = {
            ["y"] = -175.4;
            ["x"] = 486;
          };
          [11] = {
            ["y"] = -169.7;
            ["x"] = 485.8;
          };
        };
      };
    };
  };
  [5] = {
    ["name"] = "Flesheating Ghoul";
    ["id"] = 27871;
    ["count"] = 0;
    ["health"] = 12345;
    ["scale"] = 1;
    ["displayId"] = 829;
    ["creatureType"] = "Undead";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["sublevel"] = 1;
        ["y"] = -188.8;
        ["x"] = 468.9;
        ["g"] = 5;
      };
      [2] = {
        ["sublevel"] = 1;
        ["y"] = -182.7;
        ["x"] = 471.3;
        ["g"] = 5;
      };
      [3] = {
        ["sublevel"] = 1;
        ["y"] = -191.4;
        ["x"] = 487.2;
        ["g"] = 6;
      };
      [4] = {
        ["sublevel"] = 1;
        ["y"] = -196.2;
        ["x"] = 488.6;
        ["g"] = 6;
      };
      [5] = {
        ["sublevel"] = 1;
        ["y"] = -159.6;
        ["x"] = 491.1;
        ["g"] = 7;
      };
    };
  };
  [6] = {
    ["name"] = "Ghoul Tormentor";
    ["id"] = 26621;
    ["count"] = 0;
    ["health"] = 12345;
    ["scale"] = 1;
    ["displayId"] = 24994;
    ["creatureType"] = "Undead";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["sublevel"] = 1;
        ["y"] = -183.1;
        ["x"] = 465.1;
        ["g"] = 5;
      };
      [2] = {
        ["sublevel"] = 1;
        ["y"] = -192.6;
        ["x"] = 493.3;
        ["g"] = 6;
      };
      [3] = {
        ["sublevel"] = 1;
        ["y"] = -157.1;
        ["x"] = 488.9;
        ["g"] = 7;
      };
      [4] = {
        ["sublevel"] = 1;
        ["y"] = -164.1;
        ["x"] = 488.2;
        ["g"] = 7;
      };
    };
  };
  [7] = {
    ["name"] = "Trollgore";
    ["id"] = 26630;
    ["count"] = 0;
    ["health"] = 12345;
    ["scale"] = 1;
    ["displayId"] = 26352;
    ["creatureType"] = "Undead";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["sublevel"] = 1;
        ["y"] = -99.1;
        ["x"] = 474.3;
      };
    };
  };
  [8] = {
    ["name"] = "Darkweb Recluse";
    ["id"] = 26625;
    ["count"] = 0;
    ["health"] = 12345;
    ["scale"] = 1;
    ["displayId"] = 16462;
    ["creatureType"] = "Beast";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["sublevel"] = 1;
        ["y"] = -91.5;
        ["x"] = 563.3;
        ["g"] = 8;
      };
      [2] = {
        ["sublevel"] = 1;
        ["y"] = -102.7;
        ["x"] = 579.5;
        ["g"] = 8;
      };
      [3] = {
        ["sublevel"] = 1;
        ["y"] = -141.7;
        ["x"] = 564.9;
        ["g"] = 9;
      };
      [4] = {
        ["sublevel"] = 1;
        ["y"] = -145.3;
        ["x"] = 550.4;
        ["g"] = 9;
      };
      [5] = {
        ["sublevel"] = 1;
        ["y"] = -150.2;
        ["x"] = 556.3;
        ["g"] = 9;
      };
    };
  };
  [9] = {
    ["name"] = "Darkweb Hatchling";
    ["id"] = 26674;
    ["count"] = 0;
    ["health"] = 12345;
    ["scale"] = 1;
    ["displayId"] = 17814;
    ["creatureType"] = "Beast";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["sublevel"] = 1;
        ["y"] = -102.4;
        ["x"] = 550;
        ["g"] = 10;
        ["patrol"] = {
          [1] = {
            ["y"] = -93.3;
            ["x"] = 552.3;
          };
          [2] = {
            ["y"] = -96.2;
            ["x"] = 549.5;
          };
          [3] = {
            ["y"] = -112.9;
            ["x"] = 550.6;
          };
          [4] = {
            ["y"] = -115.9;
            ["x"] = 559.7;
          };
          [5] = {
            ["y"] = -116.4;
            ["x"] = 568.7;
          };
          [6] = {
            ["y"] = -115;
            ["x"] = 574.1;
          };
          [7] = {
            ["y"] = -100.4;
            ["x"] = 571.9;
          };
          [8] = {
            ["y"] = -90.5;
            ["x"] = 569.9;
          };
          [9] = {
            ["y"] = -89.1;
            ["x"] = 557.4;
          };
          [10] = {
            ["y"] = -91;
            ["x"] = 554.1;
          };
        };
      };
      [2] = {
        ["sublevel"] = 1;
        ["y"] = -102.1;
        ["x"] = 555.2;
        ["g"] = 10;
      };
      [3] = {
        ["sublevel"] = 1;
        ["y"] = -121.1;
        ["x"] = 559.1;
        ["g"] = 11;
        ["patrol"] = {
          [1] = {
            ["y"] = -122.7;
            ["x"] = 564.1;
          };
          [2] = {
            ["y"] = -122.8;
            ["x"] = 551.9;
          };
          [3] = {
            ["y"] = -124.2;
            ["x"] = 544.5;
          };
          [4] = {
            ["y"] = -134.1;
            ["x"] = 543.9;
          };
          [5] = {
            ["y"] = -140.7;
            ["x"] = 552.8;
          };
          [6] = {
            ["y"] = -144.9;
            ["x"] = 558.6;
          };
          [7] = {
            ["y"] = -146.8;
            ["x"] = 560.2;
          };
          [8] = {
            ["y"] = -149;
            ["x"] = 563.3;
          };
          [9] = {
            ["y"] = -153.6;
            ["x"] = 566.1;
          };
          [10] = {
            ["y"] = -126.9;
            ["x"] = 574;
          };
          [11] = {
            ["y"] = -123.5;
            ["x"] = 571.5;
          };
          [12] = {
            ["y"] = -123.1;
            ["x"] = 566.6;
          };
        };
      };
      [4] = {
        ["sublevel"] = 1;
        ["y"] = -124.3;
        ["x"] = 559.3;
        ["g"] = 11;
      };
    };
  };
  [10] = {
    ["name"] = "Novos the Summoner";
    ["id"] = 26631;
    ["count"] = 0;
    ["health"] = 12345;
    ["scale"] = 1;
    ["displayId"] = 26292;
    ["creatureType"] = "Undead";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["sublevel"] = 1;
        ["y"] = -266.1;
        ["x"] = 584;
      };
    };
  };
  [11] = {
    ["name"] = "Risen Drakkari Bat Rider";
    ["id"] = 26638;
    ["count"] = 0;
    ["health"] = 12345;
    ["scale"] = 1;
    ["displayId"] = 27056;
    ["creatureType"] = "Undead";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["sublevel"] = 1;
        ["y"] = -299.4;
        ["x"] = 491.5;
        ["g"] = 12;
      };
    };
  };
  [12] = {
    ["name"] = "Drakkari Bat";
    ["id"] = 26622;
    ["count"] = 0;
    ["health"] = 12345;
    ["scale"] = 1;
    ["displayId"] = 1955;
    ["creatureType"] = "Beast";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["sublevel"] = 1;
        ["y"] = -282.7;
        ["x"] = 492.9;
        ["g"] = 12;
      };
      [2] = {
        ["sublevel"] = 1;
        ["y"] = -295.3;
        ["x"] = 505.7;
        ["g"] = 12;
      };
      [3] = {
        ["sublevel"] = 1;
        ["y"] = -310.3;
        ["x"] = 506;
        ["g"] = 12;
      };
      [4] = {
        ["sublevel"] = 1;
        ["y"] = -325.3;
        ["x"] = 499.6;
        ["g"] = 12;
      };
      [5] = {
        ["sublevel"] = 1;
        ["y"] = -322.2;
        ["x"] = 484.3;
        ["g"] = 12;
      };
      [6] = {
        ["sublevel"] = 1;
        ["y"] = -306.7;
        ["x"] = 475.5;
        ["g"] = 12;
      };
      [7] = {
        ["sublevel"] = 1;
        ["y"] = -289.1;
        ["x"] = 480.1;
        ["g"] = 12;
      };
    };
  };
  [13] = {
    ["name"] = "Risen Drakkari Handler";
    ["id"] = 26637;
    ["count"] = 0;
    ["health"] = 12345;
    ["scale"] = 1;
    ["displayId"] = 26860;
    ["creatureType"] = "Undead";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["sublevel"] = 1;
        ["y"] = -379.9;
        ["x"] = 467.3;
        ["g"] = 13;
        ["patrol"] = {
          [1] = {
            ["y"] = -419.5;
            ["x"] = 466.4;
          };
          [2] = {
            ["y"] = -371.8;
            ["x"] = 467;
          };
        };
      };
      [2] = {
        ["sublevel"] = 1;
        ["y"] = -433.7;
        ["x"] = 481.9;
        ["g"] = 14;
        ["patrol"] = {
          [1] = {
            ["y"] = -435.8;
            ["x"] = 474.8;
          };
          [2] = {
            ["y"] = -436.9;
            ["x"] = 530.7;
          };
          [3] = {
            ["y"] = -435.3;
            ["x"] = 556.9;
          };
          [4] = {
            ["y"] = -422.9;
            ["x"] = 561.3;
          };
          [5] = {
            ["y"] = -409.7;
            ["x"] = 563.8;
          };
        };
      };
      [3] = {
        ["sublevel"] = 1;
        ["y"] = -439.7;
        ["x"] = 482.4;
        ["g"] = 14;
      };
    };
  };
  [14] = {
    ["name"] = "Drakkari Gutripper";
    ["id"] = 26641;
    ["count"] = 0;
    ["health"] = 12345;
    ["scale"] = 1;
    ["displayId"] = 19734;
    ["creatureType"] = "Beast";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["sublevel"] = 1;
        ["y"] = -381.7;
        ["x"] = 474.2;
        ["g"] = 13;
      };
      [2] = {
        ["sublevel"] = 1;
        ["y"] = -382.3;
        ["x"] = 462.1;
        ["g"] = 13;
      };
      [3] = {
        ["sublevel"] = 1;
        ["y"] = -453.7;
        ["x"] = 561;
      };
      [4] = {
        ["sublevel"] = 1;
        ["y"] = -485.4;
        ["x"] = 515.8;
      };
      [5] = {
        ["sublevel"] = 1;
        ["y"] = -484.4;
        ["x"] = 492.7;
      };
      [6] = {
        ["sublevel"] = 1;
        ["y"] = -459.6;
        ["x"] = 472.3;
      };
    };
  };
  [15] = {
    ["name"] = "Drakkari Scytheclaw";
    ["id"] = 26628;
    ["count"] = 0;
    ["health"] = 12345;
    ["scale"] = 1;
    ["displayId"] = 19732;
    ["creatureType"] = "Beast";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["sublevel"] = 1;
        ["y"] = -482.7;
        ["x"] = 542.9;
      };
      [2] = {
        ["sublevel"] = 1;
        ["y"] = -465.4;
        ["x"] = 514.7;
      };
      [3] = {
        ["sublevel"] = 1;
        ["y"] = -474.8;
        ["x"] = 477;
      };
    };
  };
  [16] = {
    ["name"] = "King Dred";
    ["id"] = 27483;
    ["count"] = 0;
    ["health"] = 12345;
    ["scale"] = 1;
    ["displayId"] = 5240;
    ["creatureType"] = "Beast";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["sublevel"] = 1;
        ["y"] = -460.4;
        ["x"] = 494;
        ["patrol"] = {
          [1] = {
            ["y"] = -470.1;
            ["x"] = 546.4;
          };
          [2] = {
            ["y"] = -483.5;
            ["x"] = 537.9;
          };
          [3] = {
            ["y"] = -489.4;
            ["x"] = 530.5;
          };
          [4] = {
            ["y"] = -490.1;
            ["x"] = 511.2;
          };
          [5] = {
            ["y"] = -489.3;
            ["x"] = 501;
          };
          [6] = {
            ["y"] = -489;
            ["x"] = 490.4;
          };
          [7] = {
            ["y"] = -486.5;
            ["x"] = 480.5;
          };
          [8] = {
            ["y"] = -479.7;
            ["x"] = 474.7;
          };
          [9] = {
            ["y"] = -471.1;
            ["x"] = 472.5;
          };
          [10] = {
            ["y"] = -464.3;
            ["x"] = 476.4;
          };
          [11] = {
            ["y"] = -461.2;
            ["x"] = 485.7;
          };
          [12] = {
            ["y"] = -460.4;
            ["x"] = 495.1;
          };
        };
      };
    };
  };
  [17] = {
    ["name"] = "Scourge Brute";
    ["id"] = 26623;
    ["count"] = 0;
    ["health"] = 12345;
    ["scale"] = 1;
    ["displayId"] = 7847;
    ["creatureType"] = "Undead";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["sublevel"] = 2;
        ["y"] = -363.6;
        ["x"] = 303.1;
      };
      [2] = {
        ["sublevel"] = 2;
        ["y"] = -361.5;
        ["x"] = 316.8;
      };
    };
  };
  [18] = {
    ["name"] = "Drakkari Guardian";
    ["id"] = 26620;
    ["count"] = 0;
    ["health"] = 12345;
    ["scale"] = 1;
    ["displayId"] = 27077;
    ["creatureType"] = "Humanoid";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["sublevel"] = 2;
        ["y"] = -350.7;
        ["x"] = 301.3;
      };
      [2] = {
        ["sublevel"] = 2;
        ["y"] = -349.6;
        ["x"] = 316.1;
      };
      [3] = {
        ["sublevel"] = 2;
        ["y"] = -315.7;
        ["x"] = 289.8;
        ["g"] = 15;
      };
      [4] = {
        ["sublevel"] = 2;
        ["y"] = -327.6;
        ["x"] = 290.1;
        ["g"] = 15;
      };
      [5] = {
        ["sublevel"] = 2;
        ["y"] = -207.9;
        ["x"] = 277.5;
        ["g"] = 16;
      };
      [6] = {
        ["sublevel"] = 2;
        ["y"] = -206.9;
        ["x"] = 290.1;
        ["g"] = 16;
      };
      [7] = {
        ["sublevel"] = 2;
        ["y"] = -175.6;
        ["x"] = 310.5;
      };
      [8] = {
        ["sublevel"] = 2;
        ["y"] = -164.1;
        ["x"] = 302.1;
      };
    };
  };
  [19] = {
    ["name"] = "Drakkari Shaman";
    ["id"] = 26639;
    ["count"] = 0;
    ["health"] = 12345;
    ["scale"] = 1;
    ["displayId"] = 27083;
    ["creatureType"] = "Humanoid";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["sublevel"] = 2;
        ["y"] = -322.5;
        ["x"] = 280;
        ["g"] = 15;
      };
      [2] = {
        ["sublevel"] = 2;
        ["y"] = -227;
        ["x"] = 278.6;
        ["g"] = 16;
      };
      [3] = {
        ["sublevel"] = 2;
        ["y"] = -217.3;
        ["x"] = 289;
        ["g"] = 16;
      };
    };
  };
  [20] = {
    ["name"] = "Risen Drakkari Death Knight";
    ["id"] = 26830;
    ["count"] = 0;
    ["health"] = 12345;
    ["scale"] = 1;
    ["displayId"] = 27062;
    ["creatureType"] = "Undead";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["sublevel"] = 2;
        ["y"] = -310.3;
        ["x"] = 307.4;
        ["patrol"] = {
          [1] = {
            ["y"] = -283.6;
            ["x"] = 306.7;
          };
          [2] = {
            ["y"] = -341.7;
            ["x"] = 307.4;
          };
        };
      };
      [2] = {
        ["sublevel"] = 2;
        ["y"] = -127.7;
        ["x"] = 429.9;
        ["g"] = 17;
      };
      [3] = {
        ["sublevel"] = 2;
        ["y"] = -138.4;
        ["x"] = 429.9;
        ["g"] = 17;
      };
      [4] = {
        ["sublevel"] = 2;
        ["y"] = -131.4;
        ["x"] = 450.5;
        ["patrol"] = {
          [1] = {
            ["y"] = -131.5;
            ["x"] = 479.8;
          };
          [2] = {
            ["y"] = -131.7;
            ["x"] = 439.2;
          };
        };
      };
      [5] = {
        ["sublevel"] = 2;
        ["y"] = -121.7;
        ["x"] = 466.3;
        ["g"] = 18;
      };
      [6] = {
        ["sublevel"] = 2;
        ["y"] = -121.5;
        ["x"] = 481.5;
        ["g"] = 18;
      };
    };
  };
  [21] = {
    ["name"] = "Drakkari Commander";
    ["id"] = 27431;
    ["count"] = 0;
    ["health"] = 12345;
    ["scale"] = 1;
    ["displayId"] = 27075;
    ["creatureType"] = "Humanoid";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["sublevel"] = 2;
        ["y"] = -218;
        ["x"] = 305.3;
        ["patrol"] = {
          [1] = {
            ["y"] = -211.5;
            ["x"] = 305.3;
          };
          [2] = {
            ["y"] = -260.2;
            ["x"] = 305.3;
          };
        };
      };
    };
  };
  [22] = {
    ["name"] = "The Prophet Tharon'ja";
    ["id"] = 26632;
    ["count"] = 0;
    ["health"] = 12345;
    ["scale"] = 1;
    ["displayId"] = 27072;
    ["creatureType"] = "Undead";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["sublevel"] = 2;
        ["y"] = -75.1;
        ["x"] = 398.7;
      };
    };
  };
};
