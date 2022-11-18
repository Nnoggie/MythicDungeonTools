local MDT = MDT
local L = MDT.L
local dungeonIndex = 64
MDT.dungeonList[dungeonIndex] = L["The Violet Hold"]
MDT.mapInfo[dungeonIndex] = {
  viewportPositionOverrides =
  {
  }
};

MDT.dungeonMaps[dungeonIndex] = {
  [0] = "violethold",
  [1] = "violethold1_",
}

MDT.dungeonSubLevels[dungeonIndex] = {
  [1] = L["The Violet Hold"],
}

MDT.dungeonTotalCount[dungeonIndex] = { normal = 300, teeming = 1000, teemingEnabled = true }

MDT.mapPOIs[dungeonIndex] = {
};

MDT.dungeonEnemies[dungeonIndex] = {
  [1] = {
    ["name"] = "Portal Keeper";
    ["id"] = 30893;
    ["count"] = 0;
    ["health"] = 12345;
    ["scale"] = 1;
    ["displayId"] = 27473;
    ["creatureType"] = "Dragonkin";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["g"] = 1;
        ["sublevel"] = 1;
        ["y"] = -154.6;
        ["x"] = 447.2;
      };
      [2] = {
        ["g"] = 2;
        ["sublevel"] = 1;
        ["y"] = -135.1;
        ["x"] = 443.6;
      };
      [3] = {
        ["g"] = 3;
        ["sublevel"] = 1;
        ["y"] = -307.5;
        ["x"] = 333.2;
      };
    };
  };
  [2] = {
    ["name"] = "Azure Captain";
    ["id"] = 30666;
    ["count"] = 0;
    ["health"] = 12345;
    ["scale"] = 1;
    ["displayId"] = 14356;
    ["creatureType"] = "Dragonkin";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["g"] = 4;
        ["sublevel"] = 1;
        ["y"] = -171;
        ["x"] = 499.3;
      };
      [2] = {
        ["g"] = 5;
        ["sublevel"] = 1;
        ["y"] = -239.3;
        ["x"] = 385.6;
      };
      [3] = {
        ["g"] = 6;
        ["sublevel"] = 1;
        ["y"] = -198.3;
        ["x"] = 534;
      };
      [4] = {
        ["g"] = 7;
        ["sublevel"] = 1;
        ["y"] = -252.1;
        ["x"] = 458.3;
      };
    };
  };
  [3] = {
    ["name"] = "Azure Raider";
    ["id"] = 30668;
    ["count"] = 0;
    ["health"] = 12345;
    ["scale"] = 1;
    ["displayId"] = 27219;
    ["creatureType"] = "Dragonkin";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["g"] = 4;
        ["sublevel"] = 1;
        ["y"] = -165.5;
        ["x"] = 506.9;
      };
      [2] = {
        ["g"] = 5;
        ["sublevel"] = 1;
        ["y"] = -237.9;
        ["x"] = 377.7;
      };
      [3] = {
        ["g"] = 7;
        ["sublevel"] = 1;
        ["y"] = -248;
        ["x"] = 452.5;
      };
      [4] = {
        ["g"] = 8;
        ["sublevel"] = 1;
        ["y"] = -278;
        ["x"] = 300.6;
      };
      [5] = {
        ["g"] = 9;
        ["sublevel"] = 1;
        ["y"] = -148.2;
        ["x"] = 476.5;
      };
      [6] = {
        ["g"] = 10;
        ["sublevel"] = 1;
        ["y"] = -231.4;
        ["x"] = 432.6;
      };
      [7] = {
        ["g"] = 11;
        ["sublevel"] = 1;
        ["y"] = -186.3;
        ["x"] = 327.5;
      };
    };
  };
  [4] = {
    ["name"] = "Azure Sorcerer";
    ["id"] = 30667;
    ["count"] = 0;
    ["health"] = 12345;
    ["scale"] = 1;
    ["displayId"] = 25250;
    ["creatureType"] = "Dragonkin";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["g"] = 4;
        ["sublevel"] = 1;
        ["y"] = -163.3;
        ["x"] = 495.4;
      };
      [2] = {
        ["g"] = 6;
        ["sublevel"] = 1;
        ["y"] = -195;
        ["x"] = 543.6;
      };
      [3] = {
        ["g"] = 8;
        ["sublevel"] = 1;
        ["y"] = -267.9;
        ["x"] = 300.6;
      };
      [4] = {
        ["g"] = 8;
        ["sublevel"] = 1;
        ["y"] = -265.8;
        ["x"] = 294.4;
      };
      [5] = {
        ["g"] = 9;
        ["sublevel"] = 1;
        ["y"] = -140.3;
        ["x"] = 476.5;
      };
      [6] = {
        ["g"] = 9;
        ["sublevel"] = 1;
        ["y"] = -140.3;
        ["x"] = 487.3;
      };
      [7] = {
        ["g"] = 10;
        ["sublevel"] = 1;
        ["y"] = -222.7;
        ["x"] = 420.6;
      };
      [8] = {
        ["g"] = 10;
        ["sublevel"] = 1;
        ["y"] = -222.3;
        ["x"] = 433.9;
      };
      [9] = {
        ["g"] = 11;
        ["sublevel"] = 1;
        ["y"] = -182.6;
        ["x"] = 334.9;
      };
      [10] = {
        ["g"] = 11;
        ["sublevel"] = 1;
        ["y"] = -175.1;
        ["x"] = 331.6;
      };
    };
  };
  [5] = {
    ["name"] = "Portal Keeper";
    ["id"] = 30695;
    ["count"] = 0;
    ["health"] = 12345;
    ["scale"] = 1;
    ["displayId"] = 27473;
    ["creatureType"] = "Dragonkin";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["g"] = 12;
        ["sublevel"] = 1;
        ["y"] = -345.8;
        ["x"] = 512.4;
      };
    };
  };
  [6] = {
    ["name"] = "Azure Invader";
    ["id"] = 30661;
    ["count"] = 0;
    ["health"] = 12345;
    ["scale"] = 1;
    ["displayId"] = 25226;
    ["creatureType"] = "Dragonkin";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["g"] = 12;
        ["sublevel"] = 1;
        ["y"] = -349.1;
        ["x"] = 506.9;
      };
    };
  };
  [7] = {
    ["name"] = "Portal Guardian";
    ["id"] = 30660;
    ["count"] = 0;
    ["health"] = 12345;
    ["scale"] = 1;
    ["displayId"] = 27474;
    ["creatureType"] = "Dragonkin";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["g"] = 13;
        ["sublevel"] = 1;
        ["y"] = -150.3;
        ["x"] = 418.8;
      };
      [2] = {
        ["g"] = 14;
        ["sublevel"] = 1;
        ["y"] = -330.8;
        ["x"] = 493.5;
      };
    };
  };
  [8] = {
    ["name"] = "Erekem";
    ["id"] = 29315;
    ["count"] = 0;
    ["health"] = 12345;
    ["scale"] = 1;
    ["displayId"] = 27488;
    ["creatureType"] = "Humanoid";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["g"] = 15;
        ["sublevel"] = 1;
        ["y"] = -315.7;
        ["x"] = 257.8;
      };
    };
  };
  [9] = {
    ["name"] = "Azure Stalker";
    ["id"] = 32191;
    ["count"] = 0;
    ["health"] = 12345;
    ["scale"] = 1;
    ["displayId"] = 27220;
    ["creatureType"] = "Dragonkin";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["g"] = 5;
        ["sublevel"] = 1;
        ["y"] = -233.9;
        ["x"] = 386.5;
      };
      [2] = {
        ["g"] = 6;
        ["sublevel"] = 1;
        ["y"] = -193.7;
        ["x"] = 528.7;
      };
      [3] = {
        ["g"] = 7;
        ["sublevel"] = 1;
        ["y"] = -245.5;
        ["x"] = 464.5;
      };
      [4] = {
        ["g"] = 8;
        ["sublevel"] = 1;
        ["y"] = -284.9;
        ["x"] = 296.2;
      };
      [5] = {
        ["g"] = 9;
        ["sublevel"] = 1;
        ["y"] = -149;
        ["x"] = 488.1;
      };
      [6] = {
        ["g"] = 10;
        ["sublevel"] = 1;
        ["y"] = -232.2;
        ["x"] = 421.8;
      };
      [7] = {
        ["g"] = 11;
        ["sublevel"] = 1;
        ["y"] = -183.8;
        ["x"] = 320.4;
      };
    };
  };
  [10] = {
    ["name"] = "Portal Guardian";
    ["id"] = 30892;
    ["count"] = 0;
    ["health"] = 12345;
    ["scale"] = 1;
    ["displayId"] = 27474;
    ["creatureType"] = "Dragonkin";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["g"] = 16;
        ["sublevel"] = 1;
        ["y"] = -324.6;
        ["x"] = 524.5;
      };
    };
  };
  [11] = {
    ["name"] = "Xevozz";
    ["id"] = 29266;
    ["count"] = 0;
    ["health"] = 12345;
    ["scale"] = 1;
    ["displayId"] = 27486;
    ["creatureType"] = "Humanoid";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["g"] = 17;
        ["sublevel"] = 1;
        ["y"] = -198.3;
        ["x"] = 352;
      };
    };
  };
  [12] = {
    ["name"] = "Ichoron";
    ["id"] = 29313;
    ["count"] = 0;
    ["health"] = 12345;
    ["scale"] = 1;
    ["displayId"] = 27487;
    ["creatureType"] = "Elemental";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["g"] = 18;
        ["sublevel"] = 1;
        ["y"] = -200.8;
        ["x"] = 502.6;
      };
    };
  };
  [13] = {
    ["name"] = "Moragg";
    ["id"] = 29316;
    ["count"] = 0;
    ["health"] = 12345;
    ["scale"] = 1;
    ["displayId"] = 20590;
    ["creatureType"] = "Demon";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["g"] = 19;
        ["sublevel"] = 1;
        ["y"] = -257.9;
        ["x"] = 602.4;
      };
    };
  };
  [14] = {
    ["name"] = "Cyanigosa";
    ["id"] = 31134;
    ["count"] = 0;
    ["health"] = 12345;
    ["scale"] = 1;
    ["displayId"] = 27508;
    ["creatureType"] = "Dragonkin";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["g"] = 20;
        ["sublevel"] = 1;
        ["y"] = -277;
        ["x"] = 427.8;
      };
    };
  };
  [15] = {
    ["name"] = "Zuramat the Obliterator";
    ["id"] = 29314;
    ["count"] = 0;
    ["health"] = 12345;
    ["scale"] = 1;
    ["displayId"] = 27855;
    ["creatureType"] = "Demon";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["g"] = 21;
        ["sublevel"] = 1;
        ["y"] = -166.1;
        ["x"] = 290.9;
      };
    };
  };
  [16] = {
    ["name"] = "Lavanthor";
    ["id"] = 29312;
    ["count"] = 0;
    ["health"] = 12345;
    ["scale"] = 1;
    ["displayId"] = 10193;
    ["creatureType"] = "Beast";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["g"] = 22;
        ["sublevel"] = 1;
        ["y"] = -373.8;
        ["x"] = 555.1;
      };
    };
  };
};
