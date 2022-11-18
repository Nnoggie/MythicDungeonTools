local MDT = MDT
local L = MDT.L
local dungeonIndex = 56
MDT.dungeonList[dungeonIndex] = L["Halls of Lightning"]
MDT.mapInfo[dungeonIndex] = {
  viewportPositionOverrides =
  {
    [1] = {
      zoomScale = 1.2999999523163;
      horizontalPan = 136.15217241255;
      verticalPan = 58.454463815002;
    };
  }
};

MDT.dungeonMaps[dungeonIndex] = {
  [0] = "hallsoflightning",
  [1] = "hallsoflightning1_",
  [2] = "hallsoflightning2_",
}

MDT.dungeonSubLevels[dungeonIndex] = {
  [1] = L["Unyielding Garrison"],
  [2] = L["Walk of the Makers"],
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
      ["y"] = -299.3;
      ["x"] = 748.9;
    };
  };
  [2] = {
    [1] = {
      ["template"] = "MapLinkPinTemplate";
      ["type"] = "mapLink";
      ["target"] = 1;
      ["direction"] = -1;
      ["connectionIndex"] = 1;
      ["y"] = -114.7;
      ["x"] = 485.6;
    };
  };
};

MDT.dungeonEnemies[dungeonIndex] = {
  [1] = {
    ["name"] = "Hardened Steel Reaver";
    ["id"] = 28578;
    ["count"] = 0;
    ["health"] = 12345;
    ["scale"] = 1;
    ["displayId"] = 25984;
    ["creatureType"] = "Humanoid";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["g"] = 1;
        ["sublevel"] = 1;
        ["y"] = -290.6;
        ["x"] = 174.8;
      };
      [2] = {
        ["g"] = 1;
        ["sublevel"] = 1;
        ["y"] = -305.9;
        ["x"] = 175.3;
      };
      [3] = {
        ["g"] = 2;
        ["sublevel"] = 1;
        ["y"] = -403.3;
        ["x"] = 258.8;
      };
      [4] = {
        ["g"] = 3;
        ["sublevel"] = 1;
        ["y"] = -391.2;
        ["x"] = 469.5;
      };
      [5] = {
        ["g"] = 3;
        ["sublevel"] = 1;
        ["y"] = -417.9;
        ["x"] = 461.4;
      };
      [6] = {
        ["g"] = 4;
        ["sublevel"] = 1;
        ["y"] = -192.5;
        ["x"] = 360.2;
      };
      [7] = {
        ["g"] = 5;
        ["sublevel"] = 1;
        ["y"] = -131.6;
        ["x"] = 353.9;
      };
      [8] = {
        ["g"] = 5;
        ["sublevel"] = 1;
        ["y"] = -131.9;
        ["x"] = 374.9;
      };
    };
  };
  [2] = {
    ["name"] = "Hardened Steel Skycaller";
    ["id"] = 28580;
    ["count"] = 0;
    ["health"] = 12345;
    ["scale"] = 1;
    ["displayId"] = 25985;
    ["creatureType"] = "Humanoid";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["g"] = 6;
        ["sublevel"] = 1;
        ["y"] = -291.9;
        ["x"] = 271.4;
      };
      [2] = {
        ["g"] = 2;
        ["sublevel"] = 1;
        ["y"] = -414.8;
        ["x"] = 271.7;
      };
      [3] = {
        ["g"] = 3;
        ["sublevel"] = 1;
        ["y"] = -405.2;
        ["x"] = 475.6;
      };
      [4] = {
        ["g"] = 7;
        ["sublevel"] = 1;
        ["y"] = -289.9;
        ["x"] = 458.7;
      };
      [5] = {
        ["g"] = 7;
        ["sublevel"] = 1;
        ["y"] = -309.8;
        ["x"] = 469.5;
      };
      [6] = {
        ["g"] = 5;
        ["sublevel"] = 1;
        ["y"] = -138.4;
        ["x"] = 353.7;
      };
    };
  };
  [3] = {
    ["name"] = "Hardened Steel Berserker";
    ["id"] = 28579;
    ["count"] = 0;
    ["health"] = 12345;
    ["scale"] = 1;
    ["displayId"] = 25982;
    ["creatureType"] = "Humanoid";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["g"] = 6;
        ["sublevel"] = 1;
        ["y"] = -305.6;
        ["x"] = 270.7;
      };
      [2] = {
        ["g"] = 2;
        ["sublevel"] = 1;
        ["y"] = -392.8;
        ["x"] = 271.7;
      };
      [3] = {
        ["g"] = 7;
        ["sublevel"] = 1;
        ["y"] = -294.6;
        ["x"] = 471.1;
      };
      [4] = {
        ["g"] = 4;
        ["sublevel"] = 1;
        ["y"] = -208.2;
        ["x"] = 350.8;
      };
      [5] = {
        ["g"] = 4;
        ["sublevel"] = 1;
        ["y"] = -191.7;
        ["x"] = 378.1;
      };
      [6] = {
        ["g"] = 5;
        ["sublevel"] = 1;
        ["y"] = -139.5;
        ["x"] = 374.9;
      };
    };
  };
  [4] = {
    ["name"] = "Stormforged Mender";
    ["id"] = 28582;
    ["count"] = 0;
    ["health"] = 12345;
    ["scale"] = 1;
    ["displayId"] = 25754;
    ["creatureType"] = "Humanoid";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["g"] = 6;
        ["sublevel"] = 1;
        ["y"] = -299.1;
        ["x"] = 276.1;
      };
      [2] = {
        ["g"] = 8;
        ["sublevel"] = 1;
        ["y"] = -254.1;
        ["x"] = 303.4;
      };
      [3] = {
        ["g"] = 9;
        ["sublevel"] = 1;
        ["y"] = -254.4;
        ["x"] = 334.4;
      };
      [4] = {
        ["g"] = 2;
        ["sublevel"] = 1;
        ["y"] = -397.5;
        ["x"] = 264.2;
      };
      [5] = {
        ["g"] = 10;
        ["sublevel"] = 1;
        ["y"] = -365.2;
        ["x"] = 470;
      };
      [6] = {
        ["g"] = 3;
        ["sublevel"] = 1;
        ["y"] = -397.2;
        ["x"] = 475.2;
      };
      [7] = {
        ["g"] = 7;
        ["sublevel"] = 1;
        ["y"] = -303.7;
        ["x"] = 471.2;
      };
      [8] = {
        ["g"] = 11;
        ["sublevel"] = 1;
        ["y"] = -244.9;
        ["x"] = 423.2;
      };
      [9] = {
        ["g"] = 4;
        ["sublevel"] = 1;
        ["y"] = -201.6;
        ["x"] = 353;
      };
      [10] = {
        ["g"] = 12;
        ["sublevel"] = 1;
        ["y"] = -167.1;
        ["x"] = 376;
      };
    };
  };
  [5] = {
    ["name"] = "Stormforged Tactician";
    ["id"] = 28581;
    ["count"] = 0;
    ["health"] = 12345;
    ["scale"] = 1;
    ["displayId"] = 25759;
    ["creatureType"] = "Humanoid";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["g"] = 13;
        ["sublevel"] = 1;
        ["y"] = -356.1;
        ["x"] = 282.2;
      };
      [2] = {
        ["g"] = 14;
        ["sublevel"] = 1;
        ["y"] = -393.5;
        ["x"] = 331.6;
      };
      [3] = {
        ["g"] = 15;
        ["sublevel"] = 1;
        ["y"] = -416.3;
        ["x"] = 359.7;
      };
      [4] = {
        ["g"] = 16;
        ["sublevel"] = 1;
        ["y"] = -393.5;
        ["x"] = 389.6;
      };
      [5] = {
        ["g"] = 17;
        ["sublevel"] = 1;
        ["y"] = -262.8;
        ["x"] = 404.4;
      };
      [6] = {
        ["g"] = 18;
        ["sublevel"] = 2;
        ["y"] = -405.2;
        ["x"] = 403.9;
      };
      [7] = {
        ["g"] = 19;
        ["sublevel"] = 2;
        ["y"] = -378;
        ["x"] = 378.8;
      };
    };
  };
  [6] = {
    ["name"] = "General Bjarngrim";
    ["id"] = 28586;
    ["count"] = 0;
    ["health"] = 12345;
    ["scale"] = 1;
    ["displayId"] = 27301;
    ["creatureType"] = "Humanoid";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["g"] = 20;
        ["sublevel"] = 1;
        ["y"] = -350.9;
        ["x"] = 459.8;
      };
    };
  };
  [7] = {
    ["name"] = "Stormforged Lieutenant";
    ["id"] = 29240;
    ["count"] = 0;
    ["health"] = 12345;
    ["scale"] = 1;
    ["displayId"] = 26065;
    ["creatureType"] = "Humanoid";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["g"] = 20;
        ["sublevel"] = 1;
        ["y"] = -345.5;
        ["x"] = 457;
      };
      [2] = {
        ["g"] = 20;
        ["sublevel"] = 1;
        ["y"] = -345.5;
        ["x"] = 462.9;
      };
    };
  };
  [8] = {
    ["name"] = "Slag";
    ["id"] = 28585;
    ["count"] = 0;
    ["health"] = 12345;
    ["scale"] = 1;
    ["displayId"] = 2170;
    ["creatureType"] = "Elemental";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["g"] = 21;
        ["sublevel"] = 1;
        ["y"] = -301.5;
        ["x"] = 604.4;
      };
      [2] = {
        ["g"] = 22;
        ["sublevel"] = 1;
        ["y"] = -311.5;
        ["x"] = 610.8;
      };
      [3] = {
        ["g"] = 23;
        ["sublevel"] = 1;
        ["y"] = -318.1;
        ["x"] = 629.9;
      };
      [4] = {
        ["g"] = 24;
        ["sublevel"] = 1;
        ["y"] = -304.1;
        ["x"] = 633.9;
      };
      [5] = {
        ["g"] = 25;
        ["sublevel"] = 1;
        ["y"] = -286.7;
        ["x"] = 626.8;
      };
      [6] = {
        ["g"] = 26;
        ["sublevel"] = 1;
        ["y"] = -297.4;
        ["x"] = 649.3;
      };
      [7] = {
        ["g"] = 27;
        ["sublevel"] = 1;
        ["y"] = -268.9;
        ["x"] = 661.7;
      };
      [8] = {
        ["g"] = 28;
        ["sublevel"] = 1;
        ["y"] = -287;
        ["x"] = 677.6;
      };
      [9] = {
        ["g"] = 29;
        ["sublevel"] = 1;
        ["y"] = -299.1;
        ["x"] = 696.7;
      };
      [10] = {
        ["g"] = 30;
        ["sublevel"] = 1;
        ["y"] = -286;
        ["x"] = 708.1;
      };
      [11] = {
        ["g"] = 31;
        ["sublevel"] = 1;
        ["y"] = -316.9;
        ["x"] = 707.8;
      };
      [12] = {
        ["g"] = 32;
        ["sublevel"] = 1;
        ["y"] = -336.2;
        ["x"] = 663.4;
      };
      [13] = {
        ["g"] = 33;
        ["sublevel"] = 1;
        ["y"] = -320;
        ["x"] = 679.5;
      };
      [14] = {
        ["g"] = 34;
        ["sublevel"] = 1;
        ["y"] = -322.2;
        ["x"] = 657;
      };
    };
  };
  [9] = {
    ["name"] = "Unbound Firestorm";
    ["id"] = 28584;
    ["count"] = 0;
    ["health"] = 12345;
    ["scale"] = 1;
    ["displayId"] = 24905;
    ["creatureType"] = "Elemental";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["g"] = 35;
        ["sublevel"] = 1;
        ["y"] = -343.6;
        ["x"] = 737.2;
      };
      [2] = {
        ["g"] = 36;
        ["sublevel"] = 1;
        ["y"] = -259.3;
        ["x"] = 739;
      };
      [3] = {
        ["g"] = 37;
        ["sublevel"] = 2;
        ["y"] = -73.5;
        ["x"] = 480.8;
      };
      [4] = {
        ["g"] = 38;
        ["sublevel"] = 2;
        ["y"] = -151;
        ["x"] = 483.6;
      };
      [5] = {
        ["g"] = 39;
        ["sublevel"] = 2;
        ["y"] = -165.1;
        ["x"] = 421.7;
      };
      [6] = {
        ["g"] = 40;
        ["sublevel"] = 2;
        ["y"] = -70.6;
        ["x"] = 421.3;
      };
      [7] = {
        ["g"] = 41;
        ["sublevel"] = 2;
        ["y"] = -69.9;
        ["x"] = 353.5;
      };
      [8] = {
        ["g"] = 41;
        ["sublevel"] = 2;
        ["y"] = -84;
        ["x"] = 360;
      };
      [9] = {
        ["g"] = 42;
        ["sublevel"] = 2;
        ["y"] = -167.6;
        ["x"] = 363.3;
      };
    };
  };
  [10] = {
    ["name"] = "Blistering Steamrager";
    ["id"] = 28583;
    ["count"] = 0;
    ["health"] = 12345;
    ["scale"] = 1;
    ["displayId"] = 25654;
    ["creatureType"] = "Elemental";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["g"] = 37;
        ["sublevel"] = 2;
        ["y"] = -84.7;
        ["x"] = 477.9;
      };
      [2] = {
        ["g"] = 37;
        ["sublevel"] = 2;
        ["y"] = -83.6;
        ["x"] = 489.1;
      };
      [3] = {
        ["g"] = 38;
        ["sublevel"] = 2;
        ["y"] = -158.6;
        ["x"] = 479;
      };
      [4] = {
        ["g"] = 38;
        ["sublevel"] = 2;
        ["y"] = -159.3;
        ["x"] = 488.3;
      };
      [5] = {
        ["g"] = 39;
        ["sublevel"] = 2;
        ["y"] = -153.2;
        ["x"] = 424.2;
      };
      [6] = {
        ["g"] = 39;
        ["sublevel"] = 2;
        ["y"] = -160;
        ["x"] = 431.7;
      };
      [7] = {
        ["g"] = 40;
        ["sublevel"] = 2;
        ["y"] = -73.5;
        ["x"] = 431.4;
      };
      [8] = {
        ["g"] = 40;
        ["sublevel"] = 2;
        ["y"] = -80.7;
        ["x"] = 424.5;
      };
      [9] = {
        ["g"] = 43;
        ["sublevel"] = 2;
        ["y"] = -125.1;
        ["x"] = 427.4;
      };
      [10] = {
        ["g"] = 43;
        ["sublevel"] = 2;
        ["y"] = -115.3;
        ["x"] = 426.3;
      };
      [11] = {
        ["g"] = 41;
        ["sublevel"] = 2;
        ["y"] = -74.2;
        ["x"] = 369;
      };
      [12] = {
        ["g"] = 42;
        ["sublevel"] = 2;
        ["y"] = -162.5;
        ["x"] = 371.9;
      };
      [13] = {
        ["g"] = 42;
        ["sublevel"] = 2;
        ["y"] = -156.8;
        ["x"] = 364;
      };
    };
  };
  [11] = {
    ["name"] = "Volkhan";
    ["id"] = 28587;
    ["count"] = 0;
    ["health"] = 12345;
    ["scale"] = 1;
    ["displayId"] = 27071;
    ["creatureType"] = "Giant";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["g"] = 44;
        ["sublevel"] = 2;
        ["y"] = -119.6;
        ["x"] = 317.1;
      };
    };
  };
  [12] = {
    ["name"] = "Titanium Siegebreaker";
    ["id"] = 28961;
    ["count"] = 0;
    ["health"] = 12345;
    ["scale"] = 1;
    ["displayId"] = 25984;
    ["creatureType"] = "Humanoid";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["g"] = 45;
        ["sublevel"] = 2;
        ["y"] = -216.9;
        ["x"] = 369.4;
      };
      [2] = {
        ["g"] = 45;
        ["sublevel"] = 2;
        ["y"] = -250.7;
        ["x"] = 417;
      };
      [3] = {
        ["g"] = 46;
        ["sublevel"] = 2;
        ["y"] = -259.8;
        ["x"] = 369.6;
      };
      [4] = {
        ["g"] = 46;
        ["sublevel"] = 2;
        ["y"] = -319.9;
        ["x"] = 388.7;
      };
      [5] = {
        ["g"] = 47;
        ["sublevel"] = 2;
        ["y"] = -280.6;
        ["x"] = 454.6;
      };
      [6] = {
        ["g"] = 47;
        ["sublevel"] = 2;
        ["y"] = -309.8;
        ["x"] = 371;
      };
    };
  };
  [13] = {
    ["name"] = "Titanium Thunderer";
    ["id"] = 28965;
    ["count"] = 0;
    ["health"] = 12345;
    ["scale"] = 1;
    ["displayId"] = 25985;
    ["creatureType"] = "Humanoid";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["g"] = 45;
        ["sublevel"] = 2;
        ["y"] = -209.7;
        ["x"] = 419.3;
      };
      [2] = {
        ["g"] = 46;
        ["sublevel"] = 2;
        ["y"] = -291.6;
        ["x"] = 371.3;
      };
      [3] = {
        ["g"] = 47;
        ["sublevel"] = 2;
        ["y"] = -320.6;
        ["x"] = 400;
      };
      [4] = {
        ["g"] = 47;
        ["sublevel"] = 2;
        ["y"] = -325.5;
        ["x"] = 454.1;
      };
    };
  };
  [14] = {
    ["name"] = "Cyclone";
    ["id"] = 28825;
    ["count"] = 0;
    ["health"] = 12345;
    ["scale"] = 1;
    ["displayId"] = 5494;
    ["creatureType"] = "Elemental";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["g"] = 48;
        ["sublevel"] = 2;
        ["y"] = -304.6;
        ["x"] = 501.9;
      };
      [2] = {
        ["g"] = 48;
        ["sublevel"] = 2;
        ["y"] = -297.4;
        ["x"] = 510.7;
      };
      [3] = {
        ["g"] = 48;
        ["sublevel"] = 2;
        ["y"] = -303.4;
        ["x"] = 520.7;
      };
      [4] = {
        ["g"] = 48;
        ["sublevel"] = 2;
        ["y"] = -314.6;
        ["x"] = 520.2;
      };
      [5] = {
        ["g"] = 48;
        ["sublevel"] = 2;
        ["y"] = -316.5;
        ["x"] = 507.6;
      };
      [6] = {
        ["g"] = 49;
        ["sublevel"] = 2;
        ["y"] = -300.9;
        ["x"] = 578.4;
      };
      [7] = {
        ["g"] = 49;
        ["sublevel"] = 2;
        ["y"] = -307.9;
        ["x"] = 582.5;
      };
      [8] = {
        ["g"] = 49;
        ["sublevel"] = 2;
        ["y"] = -308.4;
        ["x"] = 590.6;
      };
      [9] = {
        ["g"] = 49;
        ["sublevel"] = 2;
        ["y"] = -302.4;
        ["x"] = 595.3;
      };
      [10] = {
        ["g"] = 49;
        ["sublevel"] = 2;
        ["y"] = -295.4;
        ["x"] = 593;
      };
      [11] = {
        ["g"] = 49;
        ["sublevel"] = 2;
        ["y"] = -294.9;
        ["x"] = 584.2;
      };
      [12] = {
        ["g"] = 50;
        ["sublevel"] = 2;
        ["y"] = -353.9;
        ["x"] = 581.8;
      };
      [13] = {
        ["g"] = 50;
        ["sublevel"] = 2;
        ["y"] = -354.3;
        ["x"] = 592.2;
      };
      [14] = {
        ["g"] = 50;
        ["sublevel"] = 2;
        ["y"] = -360.2;
        ["x"] = 595.3;
      };
      [15] = {
        ["g"] = 50;
        ["sublevel"] = 2;
        ["y"] = -368.2;
        ["x"] = 594.1;
      };
      [16] = {
        ["g"] = 50;
        ["sublevel"] = 2;
        ["y"] = -368.8;
        ["x"] = 586.1;
      };
      [17] = {
        ["g"] = 50;
        ["sublevel"] = 2;
        ["y"] = -363.7;
        ["x"] = 579.6;
      };
    };
  };
  [15] = {
    ["name"] = "Storming Vortex";
    ["id"] = 28547;
    ["count"] = 0;
    ["health"] = 12345;
    ["scale"] = 1;
    ["displayId"] = 8715;
    ["creatureType"] = "Elemental";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["g"] = 48;
        ["sublevel"] = 2;
        ["y"] = -308.6;
        ["x"] = 513.3;
      };
      [2] = {
        ["g"] = 51;
        ["sublevel"] = 2;
        ["y"] = -371.9;
        ["x"] = 510.5;
      };
    };
  };
  [16] = {
    ["name"] = "Stormfury Revenant";
    ["id"] = 28826;
    ["count"] = 0;
    ["health"] = 12345;
    ["scale"] = 1;
    ["displayId"] = 26381;
    ["creatureType"] = "Elemental";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["g"] = 52;
        ["sublevel"] = 2;
        ["y"] = -303.9;
        ["x"] = 558;
      };
      [2] = {
        ["g"] = 49;
        ["sublevel"] = 2;
        ["y"] = -301.8;
        ["x"] = 587;
      };
      [3] = {
        ["g"] = 51;
        ["sublevel"] = 2;
        ["y"] = -380.7;
        ["x"] = 506;
      };
      [4] = {
        ["g"] = 51;
        ["sublevel"] = 2;
        ["y"] = -380.2;
        ["x"] = 516.4;
      };
      [5] = {
        ["g"] = 50;
        ["sublevel"] = 2;
        ["y"] = -361.1;
        ["x"] = 587.2;
      };
    };
  };
  [17] = {
    ["name"] = "Ionar";
    ["id"] = 28546;
    ["count"] = 0;
    ["health"] = 12345;
    ["scale"] = 1;
    ["displayId"] = 27484;
    ["creatureType"] = "Elemental";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["g"] = 53;
        ["sublevel"] = 2;
        ["y"] = -433.5;
        ["x"] = 512.3;
      };
    };
  };
  [18] = {
    ["name"] = "Stormforged Construct";
    ["id"] = 28835;
    ["count"] = 0;
    ["health"] = 12345;
    ["scale"] = 1;
    ["displayId"] = 26143;
    ["creatureType"] = "Mechanical";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["g"] = 54;
        ["sublevel"] = 2;
        ["y"] = -417;
        ["x"] = 449.3;
      };
      [2] = {
        ["g"] = 54;
        ["sublevel"] = 2;
        ["y"] = -429.9;
        ["x"] = 449;
      };
      [3] = {
        ["g"] = 55;
        ["sublevel"] = 2;
        ["y"] = -415.5;
        ["x"] = 246.9;
      };
      [4] = {
        ["g"] = 55;
        ["sublevel"] = 2;
        ["y"] = -431.4;
        ["x"] = 246.6;
      };
      [5] = {
        ["g"] = 56;
        ["sublevel"] = 2;
        ["y"] = -452.1;
        ["x"] = 208.2;
      };
      [6] = {
        ["g"] = 57;
        ["sublevel"] = 2;
        ["y"] = -428.7;
        ["x"] = 86.7;
      };
      [7] = {
        ["g"] = 57;
        ["sublevel"] = 2;
        ["y"] = -418.4;
        ["x"] = 86.9;
      };
    };
  };
  [19] = {
    ["name"] = "Stormforged Runeshaper";
    ["id"] = 28836;
    ["count"] = 0;
    ["health"] = 12345;
    ["scale"] = 1;
    ["displayId"] = 25756;
    ["creatureType"] = "Humanoid";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["g"] = 18;
        ["sublevel"] = 2;
        ["y"] = -409.3;
        ["x"] = 409.6;
      };
      [2] = {
        ["g"] = 58;
        ["sublevel"] = 2;
        ["y"] = -439.3;
        ["x"] = 402;
      };
      [3] = {
        ["g"] = 58;
        ["sublevel"] = 2;
        ["y"] = -442.8;
        ["x"] = 400.5;
      };
      [4] = {
        ["g"] = 59;
        ["sublevel"] = 2;
        ["y"] = -473.3;
        ["x"] = 375.8;
      };
      [5] = {
        ["g"] = 60;
        ["sublevel"] = 2;
        ["y"] = -483.2;
        ["x"] = 341.4;
      };
      [6] = {
        ["g"] = 19;
        ["sublevel"] = 2;
        ["y"] = -395.2;
        ["x"] = 351;
      };
      [7] = {
        ["g"] = 61;
        ["sublevel"] = 2;
        ["y"] = -383.2;
        ["x"] = 340;
      };
      [8] = {
        ["g"] = 61;
        ["sublevel"] = 2;
        ["y"] = -368.4;
        ["x"] = 342.8;
      };
      [9] = {
        ["g"] = 62;
        ["sublevel"] = 2;
        ["y"] = -429.1;
        ["x"] = 329.3;
      };
      [10] = {
        ["g"] = 62;
        ["sublevel"] = 2;
        ["y"] = -429;
        ["x"] = 324.7;
      };
    };
  };
  [20] = {
    ["name"] = "Stormforged Sentinel";
    ["id"] = 28837;
    ["count"] = 0;
    ["health"] = 12345;
    ["scale"] = 1;
    ["displayId"] = 25757;
    ["creatureType"] = "Humanoid";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["g"] = 18;
        ["sublevel"] = 2;
        ["y"] = -404.6;
        ["x"] = 411;
      };
      [2] = {
        ["g"] = 58;
        ["sublevel"] = 2;
        ["y"] = -442.9;
        ["x"] = 404.4;
      };
      [3] = {
        ["g"] = 59;
        ["sublevel"] = 2;
        ["y"] = -454.5;
        ["x"] = 367.9;
      };
      [4] = {
        ["g"] = 60;
        ["sublevel"] = 2;
        ["y"] = -458;
        ["x"] = 343;
      };
      [5] = {
        ["g"] = 19;
        ["sublevel"] = 2;
        ["y"] = -391.7;
        ["x"] = 371.7;
      };
      [6] = {
        ["g"] = 62;
        ["sublevel"] = 2;
        ["y"] = -425.1;
        ["x"] = 326.7;
      };
    };
  };
  [21] = {
    ["name"] = "Titanium Vanguard";
    ["id"] = 28838;
    ["count"] = 0;
    ["health"] = 12345;
    ["scale"] = 1;
    ["displayId"] = 26053;
    ["creatureType"] = "Humanoid";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["g"] = 63;
        ["sublevel"] = 2;
        ["y"] = -423.7;
        ["x"] = 379.7;
      };
      [2] = {
        ["g"] = 63;
        ["sublevel"] = 2;
        ["y"] = -423.5;
        ["x"] = 386;
      };
      [3] = {
        ["g"] = 59;
        ["sublevel"] = 2;
        ["y"] = -464;
        ["x"] = 380.7;
      };
      [4] = {
        ["g"] = 60;
        ["sublevel"] = 2;
        ["y"] = -469;
        ["x"] = 335.9;
      };
      [5] = {
        ["g"] = 61;
        ["sublevel"] = 2;
        ["y"] = -373.1;
        ["x"] = 333.5;
      };
      [6] = {
        ["g"] = 64;
        ["sublevel"] = 2;
        ["y"] = -424;
        ["x"] = 286.5;
      };
      [7] = {
        ["g"] = 64;
        ["sublevel"] = 2;
        ["y"] = -424.2;
        ["x"] = 279.3;
      };
    };
  };
  [22] = {
    ["name"] = "Stormforged Giant";
    ["id"] = 28920;
    ["count"] = 0;
    ["health"] = 12345;
    ["scale"] = 1;
    ["displayId"] = 27092;
    ["creatureType"] = "Giant";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["g"] = 65;
        ["sublevel"] = 2;
        ["y"] = -384.2;
        ["x"] = 173;
      };
      [2] = {
        ["g"] = 66;
        ["sublevel"] = 2;
        ["y"] = -437.9;
        ["x"] = 143.1;
      };
    };
  };
  [23] = {
    ["name"] = "Loken";
    ["id"] = 28923;
    ["count"] = 0;
    ["health"] = 12345;
    ["scale"] = 1;
    ["displayId"] = 27485;
    ["creatureType"] = "Giant";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["g"] = 67;
        ["sublevel"] = 2;
        ["y"] = -290.8;
        ["x"] = 160.7;
      };
    };
  };
};
