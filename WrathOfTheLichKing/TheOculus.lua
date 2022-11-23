local MDT = MDT
local L = MDT.L
local dungeonIndex = 63
MDT.dungeonList[dungeonIndex] = L["The Oculus"]
MDT.mapInfo[dungeonIndex] = {
  viewportPositionOverrides = {
  }
};

MDT.dungeonMaps[dungeonIndex] = {
  [0] = "nexus80",
  [1] = "nexus80",
  [2] = "nexus801_",
  [3] = "nexus802_",
  [4] = "nexus803_",
  [5] = "nexus804_",
}

MDT.dungeonSubLevels[dungeonIndex] = {
  [1] = L["The Oculus"],
  [2] = L["Band of Variance"],
  [3] = L["Band of Acceleration"],
  [4] = L["Band of Transmutation"],
  [5] = L["Band of Alignment"],
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
      ["y"] = -272.8;
      ["x"] = 414.8;
    };
  };
  [2] = {
    [1] = {
      ["template"] = "MapLinkPinTemplate";
      ["type"] = "mapLink";
      ["target"] = 3;
      ["direction"] = 1;
      ["connectionIndex"] = 1;
      ["y"] = -475.2;
      ["x"] = 411.9;
    };
  };
  [3] = {
    [1] = {
      ["template"] = "MapLinkPinTemplate";
      ["type"] = "mapLink";
      ["target"] = 4;
      ["direction"] = 1;
      ["connectionIndex"] = 1;
      ["y"] = -77.6;
      ["x"] = 386.7;
    };
  };
  [4] = {
    [1] = {
      ["template"] = "MapLinkPinTemplate";
      ["type"] = "mapLink";
      ["target"] = 5;
      ["direction"] = 1;
      ["connectionIndex"] = 1;
      ["y"] = -264.4;
      ["x"] = 345.8;
    };
    [2] = {
      ["template"] = "MapLinkPinTemplate";
      ["type"] = "mapLink";
      ["target"] = 3;
      ["direction"] = -1;
      ["connectionIndex"] = 2;
      ["y"] = -268.2;
      ["x"] = 467.6;
    };
  };
  [5] = {
    [1] = {
      ["template"] = "MapLinkPinTemplate";
      ["type"] = "mapLink";
      ["target"] = 4;
      ["direction"] = -1;
      ["connectionIndex"] = 1;
      ["y"] = -228.9;
      ["x"] = 409.1;
    };
  };
};

MDT.dungeonEnemies[dungeonIndex] = {
  [1] = {
    ["name"] = "Azure Ley-Whelp";
    ["id"] = 27636;
    ["count"] = 0;
    ["health"] = 12345;
    ["scale"] = 1;
    ["displayId"] = 26088;
    ["creatureType"] = "Dragonkin";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["sublevel"] = 2;
        ["y"] = -245.1;
        ["x"] = 539.9;
        ["g"] = 1;
      };
      [2] = {
        ["sublevel"] = 2;
        ["y"] = -237.1;
        ["x"] = 529.8;
        ["g"] = 1;
      };
      [3] = {
        ["sublevel"] = 2;
        ["y"] = -223.4;
        ["x"] = 538.4;
        ["g"] = 1;
      };
      [4] = {
        ["sublevel"] = 2;
        ["y"] = -208.3;
        ["x"] = 547.1;
        ["g"] = 1;
      };
      [5] = {
        ["sublevel"] = 2;
        ["y"] = -198.6;
        ["x"] = 539.9;
        ["g"] = 1;
      };
      [6] = {
        ["sublevel"] = 2;
        ["y"] = -82.9;
        ["x"] = 489.1;
        ["g"] = 2;
      };
      [7] = {
        ["sublevel"] = 2;
        ["y"] = -75.3;
        ["x"] = 481.8;
        ["g"] = 2;
      };
      [8] = {
        ["sublevel"] = 2;
        ["y"] = -69.6;
        ["x"] = 495.9;
        ["g"] = 2;
      };
      [9] = {
        ["sublevel"] = 2;
        ["y"] = -80.4;
        ["x"] = 500.9;
        ["g"] = 2;
      };
      [10] = {
        ["sublevel"] = 2;
        ["y"] = -97.7;
        ["x"] = 304.5;
        ["g"] = 3;
      };
      [11] = {
        ["sublevel"] = 2;
        ["y"] = -82.2;
        ["x"] = 315.3;
        ["g"] = 3;
      };
      [12] = {
        ["sublevel"] = 2;
        ["y"] = -90.1;
        ["x"] = 325.1;
        ["g"] = 3;
      };
      [13] = {
        ["sublevel"] = 2;
        ["y"] = -68.5;
        ["x"] = 334.6;
        ["g"] = 3;
      };
      [14] = {
        ["sublevel"] = 2;
        ["y"] = -76;
        ["x"] = 341.1;
        ["g"] = 3;
      };
      [15] = {
        ["sublevel"] = 2;
        ["y"] = -133.3;
        ["x"] = 276.5;
        ["g"] = 4;
      };
      [16] = {
        ["sublevel"] = 2;
        ["y"] = -134.5;
        ["x"] = 294.8;
        ["g"] = 4;
      };
      [17] = {
        ["sublevel"] = 2;
        ["y"] = -157.3;
        ["x"] = 276.5;
        ["g"] = 4;
      };
      [18] = {
        ["sublevel"] = 2;
        ["y"] = -164.4;
        ["x"] = 296.8;
        ["g"] = 4;
      };
      [19] = {
        ["sublevel"] = 2;
        ["y"] = -175.5;
        ["x"] = 279.4;
        ["g"] = 4;
      };
    };
  };
  [2] = {
    ["name"] = "Azure Spellbinder";
    ["id"] = 27635;
    ["count"] = 0;
    ["health"] = 12345;
    ["scale"] = 1;
    ["displayId"] = 25250;
    ["creatureType"] = "Dragonkin";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["sublevel"] = 2;
        ["y"] = -174.8;
        ["x"] = 533.4;
        ["patrol"] = {
          [1] = {
            ["y"] = -127.6;
            ["x"] = 528.7;
          };
          [2] = {
            ["y"] = -174.1;
            ["x"] = 533.4;
          };
          [3] = {
            ["y"] = -226.7;
            ["x"] = 527.6;
          };
          [4] = {
            ["y"] = -244.7;
            ["x"] = 523.6;
          };
        };
      };
      [2] = {
        ["sublevel"] = 2;
        ["y"] = -75;
        ["x"] = 492.3;
        ["g"] = 2;
      };
      [3] = {
        ["sublevel"] = 2;
        ["y"] = -56.2;
        ["x"] = 410.1;
        ["g"] = 5;
      };
      [4] = {
        ["sublevel"] = 2;
        ["y"] = -272;
        ["x"] = 315.5;
        ["g"] = 6;
      };
    };
  };
  [3] = {
    ["name"] = "Azure Inquisitor";
    ["id"] = 27633;
    ["count"] = 0;
    ["health"] = 12345;
    ["scale"] = 1;
    ["displayId"] = 25195;
    ["creatureType"] = "Dragonkin";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["sublevel"] = 2;
        ["y"] = -65.6;
        ["x"] = 483.6;
        ["g"] = 2;
      };
      [2] = {
        ["sublevel"] = 2;
        ["y"] = -75.7;
        ["x"] = 410.1;
        ["g"] = 5;
      };
      [3] = {
        ["sublevel"] = 2;
        ["y"] = -144.5;
        ["x"] = 286.9;
        ["g"] = 4;
      };
      [4] = {
        ["sublevel"] = 2;
        ["y"] = -161.9;
        ["x"] = 287.7;
        ["g"] = 4;
      };
      [5] = {
        ["sublevel"] = 2;
        ["y"] = -254.2;
        ["x"] = 315.9;
        ["g"] = 6;
      };
      [6] = {
        ["sublevel"] = 2;
        ["y"] = -260.8;
        ["x"] = 300.5;
        ["g"] = 6;
      };
    };
  };
  [4] = {
    ["name"] = "Drakos the Interrogator";
    ["id"] = 27654;
    ["count"] = 0;
    ["health"] = 12345;
    ["scale"] = 1;
    ["displayId"] = 27032;
    ["creatureType"] = "Dragonkin";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["sublevel"] = 2;
        ["y"] = -434.6;
        ["x"] = 410.1;
      };
    };
  };
  [5] = {
    ["name"] = "Centrifuge Construct";
    ["id"] = 27641;
    ["count"] = 0;
    ["health"] = 12345;
    ["scale"] = 1;
    ["displayId"] = 24943;
    ["creatureType"] = "Mechanical";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["sublevel"] = 3;
        ["y"] = -430.4;
        ["x"] = 240.4;
        ["g"] = 7;
      };
      [2] = {
        ["sublevel"] = 3;
        ["y"] = -428.8;
        ["x"] = 205.9;
        ["g"] = 7;
      };
      [3] = {
        ["sublevel"] = 3;
        ["y"] = -471.4;
        ["x"] = 220.1;
        ["g"] = 7;
      };
      [4] = {
        ["sublevel"] = 3;
        ["y"] = -381.8;
        ["x"] = 348.8;
        ["g"] = 8;
      };
      [5] = {
        ["sublevel"] = 3;
        ["y"] = -309.2;
        ["x"] = 336.8;
        ["g"] = 9;
      };
      [6] = {
        ["sublevel"] = 3;
        ["y"] = -305.6;
        ["x"] = 482.9;
        ["g"] = 10;
      };
      [7] = {
        ["sublevel"] = 3;
        ["y"] = -370.4;
        ["x"] = 484;
        ["g"] = 11;
      };
      [8] = {
        ["sublevel"] = 3;
        ["y"] = -400.1;
        ["x"] = 630.6;
        ["g"] = 12;
      };
      [9] = {
        ["sublevel"] = 3;
        ["y"] = -412.7;
        ["x"] = 599;
        ["g"] = 12;
      };
      [10] = {
        ["sublevel"] = 3;
        ["y"] = -438.4;
        ["x"] = 626.8;
        ["g"] = 12;
      };
    };
  };
  [6] = {
    ["name"] = "Ring-Lord Sorceress";
    ["id"] = 27639;
    ["count"] = 0;
    ["health"] = 12345;
    ["scale"] = 1;
    ["displayId"] = 25305;
    ["creatureType"] = "Humanoid";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["sublevel"] = 3;
        ["y"] = -446.8;
        ["x"] = 223.4;
        ["g"] = 7;
      };
      [2] = {
        ["sublevel"] = 3;
        ["y"] = -383.5;
        ["x"] = 369;
        ["g"] = 8;
      };
      [3] = {
        ["sublevel"] = 3;
        ["y"] = -383.5;
        ["x"] = 332.4;
        ["g"] = 8;
      };
      [4] = {
        ["sublevel"] = 3;
        ["y"] = -322;
        ["x"] = 349.9;
        ["g"] = 9;
      };
      [5] = {
        ["sublevel"] = 3;
        ["y"] = -308.4;
        ["x"] = 319.8;
        ["g"] = 9;
      };
      [6] = {
        ["sublevel"] = 3;
        ["y"] = -318.7;
        ["x"] = 476.9;
        ["g"] = 10;
      };
      [7] = {
        ["sublevel"] = 3;
        ["y"] = -353.2;
        ["x"] = 493.3;
        ["g"] = 11;
      };
      [8] = {
        ["sublevel"] = 3;
        ["y"] = -390.3;
        ["x"] = 489.7;
        ["g"] = 11;
      };
      [9] = {
        ["sublevel"] = 3;
        ["y"] = -417.9;
        ["x"] = 617;
        ["g"] = 12;
      };
    };
  };
  [7] = {
    ["name"] = "Ring-Lord Conjurer";
    ["id"] = 27640;
    ["count"] = 0;
    ["health"] = 12345;
    ["scale"] = 1;
    ["displayId"] = 25302;
    ["creatureType"] = "Humanoid";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["sublevel"] = 3;
        ["y"] = -364.6;
        ["x"] = 355.1;
        ["g"] = 8;
      };
      [2] = {
        ["sublevel"] = 3;
        ["y"] = -301;
        ["x"] = 355.6;
        ["g"] = 9;
      };
      [3] = {
        ["sublevel"] = 3;
        ["y"] = -290.1;
        ["x"] = 490.8;
        ["g"] = 10;
      };
      [4] = {
        ["sublevel"] = 3;
        ["y"] = -312.5;
        ["x"] = 502.3;
        ["g"] = 10;
      };
      [5] = {
        ["sublevel"] = 3;
        ["y"] = -373.4;
        ["x"] = 467.9;
        ["g"] = 11;
      };
    };
  };
  [8] = {
    ["name"] = "Varos Cloudstrider";
    ["id"] = 27447;
    ["count"] = 0;
    ["health"] = 12345;
    ["scale"] = 1;
    ["displayId"] = 27033;
    ["creatureType"] = "Dragonkin";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["sublevel"] = 3;
        ["y"] = -108.4;
        ["x"] = 386.1;
      };
    };
  };
  [9] = {
    ["name"] = "Mage-Lord Urom";
    ["id"] = 27655;
    ["count"] = 0;
    ["health"] = 12345;
    ["scale"] = 1;
    ["displayId"] = 25010;
    ["creatureType"] = "Humanoid";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["sublevel"] = 4;
        ["y"] = -246.9;
        ["x"] = 349.6;
      };
    };
  };
  [10] = {
    ["name"] = "Phantasmal Mammoth";
    ["id"] = 27642;
    ["count"] = 0;
    ["health"] = 12345;
    ["scale"] = 1;
    ["displayId"] = 25145;
    ["creatureType"] = "Beast";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["sublevel"] = 4;
        ["y"] = -132.5;
        ["x"] = 604;
        ["g"] = 13;
      };
      [2] = {
        ["sublevel"] = 4;
        ["y"] = -168.9;
        ["x"] = 584.1;
        ["g"] = 13;
      };
    };
  };
  [11] = {
    ["name"] = "Phantasmal Wolf";
    ["id"] = 27644;
    ["count"] = 0;
    ["health"] = 12345;
    ["scale"] = 1;
    ["displayId"] = 25153;
    ["creatureType"] = "Beast";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["sublevel"] = 4;
        ["y"] = -141.2;
        ["x"] = 576.7;
        ["g"] = 13;
      };
    };
  };
  [12] = {
    ["name"] = "Phantasmal Cloudscraper";
    ["id"] = 27645;
    ["count"] = 0;
    ["health"] = 12345;
    ["scale"] = 1;
    ["displayId"] = 25147;
    ["creatureType"] = "Beast";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["sublevel"] = 4;
        ["y"] = -163.1;
        ["x"] = 610.2;
        ["g"] = 13;
      };
    };
  };
  [13] = {
    ["name"] = "Phantasmal Fire";
    ["id"] = 27651;
    ["count"] = 0;
    ["health"] = 12345;
    ["scale"] = 1;
    ["displayId"] = 25148;
    ["creatureType"] = "Elemental";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["sublevel"] = 4;
        ["y"] = -470.3;
        ["x"] = 408.6;
        ["g"] = 14;
      };
      [2] = {
        ["sublevel"] = 4;
        ["y"] = -507.5;
        ["x"] = 437;
        ["g"] = 14;
      };
    };
  };
  [14] = {
    ["name"] = "Phantasmal Water";
    ["id"] = 27653;
    ["count"] = 0;
    ["health"] = 12345;
    ["scale"] = 1;
    ["displayId"] = 5450;
    ["creatureType"] = "Elemental";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["sublevel"] = 4;
        ["y"] = -470.9;
        ["x"] = 438.1;
        ["g"] = 14;
      };
    };
  };
  [15] = {
    ["name"] = "Phantasmal Air";
    ["id"] = 27650;
    ["count"] = 0;
    ["health"] = 12345;
    ["scale"] = 1;
    ["displayId"] = 25146;
    ["creatureType"] = "Elemental";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["sublevel"] = 4;
        ["y"] = -506.9;
        ["x"] = 409.7;
        ["g"] = 14;
      };
    };
  };
  [16] = {
    ["name"] = "Phantasmal Naga";
    ["id"] = 27648;
    ["count"] = 0;
    ["health"] = 12345;
    ["scale"] = 1;
    ["displayId"] = 25150;
    ["creatureType"] = "Humanoid";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["sublevel"] = 4;
        ["y"] = -155.1;
        ["x"] = 198.3;
        ["g"] = 15;
      };
      [2] = {
        ["sublevel"] = 4;
        ["y"] = -187.4;
        ["x"] = 225.6;
        ["g"] = 15;
      };
    };
  };
  [17] = {
    ["name"] = "Phantasmal Ogre";
    ["id"] = 27647;
    ["count"] = 0;
    ["health"] = 12345;
    ["scale"] = 1;
    ["displayId"] = 25151;
    ["creatureType"] = "Humanoid";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["sublevel"] = 4;
        ["y"] = -156.8;
        ["x"] = 228.9;
        ["g"] = 15;
      };
    };
  };
  [18] = {
    ["name"] = "Phantasmal Murloc";
    ["id"] = 27649;
    ["count"] = 0;
    ["health"] = 12345;
    ["scale"] = 1;
    ["displayId"] = 25149;
    ["creatureType"] = "Humanoid";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["sublevel"] = 4;
        ["y"] = -185.7;
        ["x"] = 198.3;
        ["g"] = 15;
      };
    };
  };
  [19] = {
    ["name"] = "Ley-Guardian Eregos";
    ["id"] = 27656;
    ["count"] = 0;
    ["health"] = 12345;
    ["scale"] = 1;
    ["displayId"] = 27034;
    ["creatureType"] = "Dragonkin";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["sublevel"] = 5;
        ["y"] = -117.6;
        ["x"] = 396.6;
      };
    };
  };
};
