local MDT = MDT
local L = MDT.L

local dungeonIndex = 137
MDT.dungeonList[dungeonIndex] = L["Stormstout Brewery"]
MDT.mapInfo[dungeonIndex] = {
  iconId = 603795,
  shortName = L["stormstoutBreweryShortName"],
  englishName = "Stormstout Brewery",
  mapID = 961,
};

local zones = { 439, 440, 441, 442 }
for _, zone in ipairs(zones) do
  MDT.zoneIdToDungeonIdx[zone] = dungeonIndex
end

MDT.dungeonMaps[dungeonIndex] = {
  [0] = "StormstoutBrewery",
  [1] = "StormstoutBrewery1_",
  [2] = "StormstoutBrewery2_",
  [3] = "StormstoutBrewery3_",
  [4] = "StormstoutBrewery4_",
}
MDT.dungeonSubLevels[dungeonIndex] = {
  [1] = L["Grain Cellar"],
  [2] = L["Stormstout Brewhall"],
  [3] = L["The Great Wheel"],
  [4] = L["The Tasting Room"],
}

MDT.dungeonTotalCount[dungeonIndex] = { normal = 25, teeming = 1000, teemingEnabled = true }

MDT.mapPOIs[dungeonIndex] = {};

MDT.dungeonEnemies[dungeonIndex] = {
  [1] = {
    ["name"] = "Sodden Hozen Brawler",
    ["id"] = 59605,
    ["count"] = 1,
    ["health"] = 4637512,
    ["scale"] = 1,
    ["displayId"] = 41257,
    ["creatureType"] = "Humanoid",
    ["characteristics"] = {
    },
    ["spells"] = {
    },
    ["clones"] = {
      [1] = {
        ["x"] = 558.6,
        ["y"] = -260,
        ["g"] = 1,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 553.4,
        ["y"] = -244.9,
        ["g"] = 1,
        ["sublevel"] = 1,
      },
    },
  },
  [2] = {
    ["name"] = "Inflamed Hozen Brawler",
    ["id"] = 56924,
    ["count"] = 1,
    ["health"] = 4215920,
    ["scale"] = 1,
    ["displayId"] = 42957,
    ["creatureType"] = "Humanoid",
    ["characteristics"] = {
    },
    ["spells"] = {
    },
    ["clones"] = {
      [1] = {
        ["x"] = 398.9,
        ["y"] = -296,
        ["g"] = 3,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 384.1,
        ["y"] = -282.4,
        ["g"] = 3,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 391.6,
        ["y"] = -312.7,
        ["g"] = 3,
        ["sublevel"] = 1,
      },
    },
  },
  [3] = {
    ["name"] = "Sleepy Hozen Brawler",
    ["id"] = 56863,
    ["count"] = 0,
    ["health"] = 123456,
    ["scale"] = 1,
    ["displayId"] = 41259,
    ["creatureType"] = "Humanoid",
    ["characteristics"] = {
    },
    ["spells"] = {
    },
    ["clones"] = {
      [1] = {
        ["x"] = 251.1,
        ["y"] = -389.1,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 227,
        ["y"] = -441.5,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 299.1,
        ["y"] = -448.8,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 291.2,
        ["y"] = -474.6,
        ["sublevel"] = 1,
      },
    },
  },
  [4] = {
    ["name"] = "Drunken Hozen Brawler",
    ["id"] = 56862,
    ["count"] = 1,
    ["health"] = 5902288,
    ["scale"] = 1,
    ["displayId"] = 41260,
    ["creatureType"] = "Humanoid",
    ["characteristics"] = {
    },
    ["spells"] = {
    },
    ["clones"] = {
      [1] = {
        ["x"] = 151.6,
        ["y"] = -364.8,
        ["g"] = 2,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 172,
        ["y"] = -358.8,
        ["g"] = 2,
        ["sublevel"] = 1,
      },
    },
  },
  [5] = {
    ["name"] = "Hozen Party Animal",
    ["id"] = 56927,
    ["count"] = 0,
    ["health"] = 1222596,
    ["scale"] = 0.8,
    ["displayId"] = 42377,
    ["creatureType"] = "Humanoid",
    ["characteristics"] = {
    },
    ["spells"] = {
    },
    ["clones"] = {
      [1] = {
        ["x"] = 124.6,
        ["y"] = -356,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 133.1,
        ["y"] = -381.6,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 162.6,
        ["y"] = -323.2,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 181.7,
        ["y"] = -331.7,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 144.6,
        ["y"] = -329.5,
        ["sublevel"] = 1,
      },
      [6] = {
        ["x"] = 206.1,
        ["y"] = -363.2,
        ["sublevel"] = 1,
      },
      [7] = {
        ["x"] = 327.9,
        ["y"] = -377.3,
        ["g"] = 8,
        ["sublevel"] = 2,
      },
      [8] = {
        ["x"] = 315.4,
        ["y"] = -383.4,
        ["g"] = 8,
        ["sublevel"] = 2,
      },
      [9] = {
        ["x"] = 337.2,
        ["y"] = -398.2,
        ["g"] = 8,
        ["sublevel"] = 2,
      },
      [10] = {
        ["x"] = 323.2,
        ["y"] = -397,
        ["g"] = 8,
        ["sublevel"] = 2,
      },
      [11] = {
        ["x"] = 289.4,
        ["y"] = -242,
        ["g"] = 5,
        ["sublevel"] = 2,
      },
      [12] = {
        ["x"] = 277.2,
        ["y"] = -232.5,
        ["g"] = 5,
        ["sublevel"] = 2,
      },
      [13] = {
        ["x"] = 275.5,
        ["y"] = -247.5,
        ["g"] = 5,
        ["sublevel"] = 2,
      },
      [14] = {
        ["x"] = 279.3,
        ["y"] = -268.1,
        ["g"] = 4,
        ["sublevel"] = 2,
      },
      [15] = {
        ["x"] = 354.4,
        ["y"] = -210,
        ["g"] = 6,
        ["sublevel"] = 2,
      },
      [16] = {
        ["x"] = 264.3,
        ["y"] = -289.7,
        ["g"] = 4,
        ["sublevel"] = 2,
      },
      [17] = {
        ["x"] = 270,
        ["y"] = -277.9,
        ["g"] = 4,
        ["sublevel"] = 2,
      },
      [18] = {
        ["x"] = 407.3,
        ["y"] = -404.1,
        ["g"] = 9,
        ["sublevel"] = 2,
      },
      [19] = {
        ["x"] = 415.3,
        ["y"] = -393.2,
        ["g"] = 9,
        ["sublevel"] = 2,
      },
      [20] = {
        ["x"] = 262,
        ["y"] = -305,
        ["g"] = 4,
        ["sublevel"] = 2,
      },
      [21] = {
        ["x"] = 436,
        ["y"] = -238.5,
        ["g"] = 13,
        ["sublevel"] = 2,
      },
      [22] = {
        ["x"] = 433.3,
        ["y"] = -225.7,
        ["g"] = 13,
        ["sublevel"] = 2,
      },
      [23] = {
        ["x"] = 463,
        ["y"] = -218.2,
        ["g"] = 13,
        ["sublevel"] = 2,
      },
      [24] = {
        ["x"] = 450,
        ["y"] = -228,
        ["g"] = 13,
        ["sublevel"] = 2,
      },
      [25] = {
        ["x"] = 491.6,
        ["y"] = -306.7,
        ["g"] = 12,
        ["sublevel"] = 2,
      },
      [26] = {
        ["x"] = 465.9,
        ["y"] = -234.1,
        ["g"] = 13,
        ["sublevel"] = 2,
      },
      [27] = {
        ["x"] = 371.7,
        ["y"] = -270.8,
        ["g"] = 7,
        ["sublevel"] = 2,
      },
      [28] = {
        ["x"] = 396,
        ["y"] = -305.6,
        ["g"] = 7,
        ["sublevel"] = 2,
      },
      [29] = {
        ["x"] = 434.3,
        ["y"] = -356.3,
        ["g"] = 10,
        ["sublevel"] = 2,
      },
      [30] = {
        ["x"] = 380.7,
        ["y"] = -199.7,
        ["sublevel"] = 2,
      },
      [31] = {
        ["x"] = 373.5,
        ["y"] = -312.4,
        ["g"] = 7,
        ["sublevel"] = 2,
      },
      [32] = {
        ["x"] = 463.6,
        ["y"] = -328.7,
        ["g"] = 12,
        ["sublevel"] = 2,
      },
      [33] = {
        ["x"] = 461.9,
        ["y"] = -310.7,
        ["g"] = 12,
        ["sublevel"] = 2,
      },
      [34] = {
        ["x"] = 345.5,
        ["y"] = -204.9,
        ["g"] = 6,
        ["sublevel"] = 2,
      },
      [35] = {
        ["x"] = 293.4,
        ["y"] = -320.9,
        ["g"] = 11,
        ["sublevel"] = 2,
      },
      [36] = {
        ["x"] = 282.7,
        ["y"] = -326.8,
        ["g"] = 11,
        ["sublevel"] = 2,
      },
      [37] = {
        ["x"] = 238.8,
        ["y"] = -331.7,
        ["sublevel"] = 2,
      },
      [38] = {
        ["x"] = 479.3,
        ["y"] = -318.6,
        ["g"] = 12,
        ["sublevel"] = 2,
      },
      [39] = {
        ["x"] = 286.9,
        ["y"] = -340.2,
        ["g"] = 11,
        ["sublevel"] = 2,
      },
      [40] = {
        ["x"] = 433.9,
        ["y"] = -367.7,
        ["g"] = 10,
        ["sublevel"] = 2,
      },
      [41] = {
        ["x"] = 496.6,
        ["y"] = -321.8,
        ["g"] = 12,
        ["sublevel"] = 2,
      },
      [42] = {
        ["x"] = 316.7,
        ["y"] = -416.6,
        ["sublevel"] = 2,
      },
      [43] = {
        ["x"] = 389.4,
        ["y"] = -324.3,
        ["g"] = 7,
        ["sublevel"] = 2,
      },
      [44] = {
        ["x"] = 364.9,
        ["y"] = -287.2,
        ["g"] = 7,
        ["sublevel"] = 2,
      },
      [45] = {
        ["x"] = 401,
        ["y"] = -390.8,
        ["g"] = 9,
        ["sublevel"] = 2,
      },
      [46] = {
        ["x"] = 290.1,
        ["y"] = -330.5,
        ["g"] = 11,
        ["sublevel"] = 2,
      },
      [47] = {
        ["x"] = 361.8,
        ["y"] = -217.4,
        ["g"] = 6,
        ["sublevel"] = 2,
      },
      [48] = {
        ["x"] = 299.3,
        ["y"] = -334.6,
        ["g"] = 11,
        ["sublevel"] = 2,
      },
      [49] = {
        ["x"] = 387.9,
        ["y"] = -279.6,
        ["g"] = 7,
        ["sublevel"] = 2,
      },
      [50] = {
        ["x"] = 309,
        ["y"] = -206.5,
        ["sublevel"] = 2,
      },
    },
  },
  [6] = {
    ["name"] = "Ook-Ook",
    ["id"] = 56637,
    ["count"] = 0,
    ["health"] = 26168220,
    ["scale"] = 1.6,
    ["displayId"] = 39498,
    ["creatureType"] = "Humanoid",
    ["isBoss"] = true,
    ["instanceID"] = 302,
    ["characteristics"] = {
    },
    ["spells"] = {
    },
    ["clones"] = {
      [1] = {
        ["x"] = 466.2,
        ["y"] = -269.3,
        ["sublevel"] = 2,
      },
    },
  },
  [7] = {
    ["name"] = "Hoptallus",
    ["id"] = 56717,
    ["count"] = 0,
    ["health"] = 19626164,
    ["scale"] = 1.6,
    ["displayId"] = 40339,
    ["creatureType"] = "Humanoid",
    ["isBoss"] = true,
    ["instanceID"] = 302,
    ["characteristics"] = {
    },
    ["spells"] = {
    },
    ["clones"] = {
      [1] = {
        ["x"] = 323.9,
        ["y"] = -278.5,
        ["sublevel"] = 3,
      },
    },
  },
  [8] = {
    ["name"] = "Stout Brew Alemental",
    ["id"] = 59519,
    ["count"] = 1,
    ["health"] = 4890384,
    ["scale"] = 1,
    ["displayId"] = 42967,
    ["creatureType"] = "Elemental",
    ["characteristics"] = {
    },
    ["spells"] = {
    },
    ["clones"] = {
      [1] = {
        ["x"] = 491.8,
        ["y"] = -149.8,
        ["sublevel"] = 3,
      },
    },
  },
  [9] = {
    ["name"] = "Yeasty Brew Alemental",
    ["id"] = 66413,
    ["count"] = 1,
    ["health"] = 1833894,
    ["scale"] = 1,
    ["displayId"] = 42968,
    ["creatureType"] = "Elemental",
    ["characteristics"] = {
    },
    ["spells"] = {
    },
    ["clones"] = {
      [1] = {
        ["x"] = 539.7,
        ["y"] = -261.4,
        ["g"] = 14,
        ["sublevel"] = 3,
      },
      [2] = {
        ["x"] = 563.1,
        ["y"] = -255.5,
        ["g"] = 14,
        ["sublevel"] = 3,
      },
      [3] = {
        ["x"] = 568.5,
        ["y"] = -279.8,
        ["g"] = 14,
        ["sublevel"] = 3,
      },
      [4] = {
        ["x"] = 545,
        ["y"] = -285.9,
        ["g"] = 14,
        ["sublevel"] = 3,
      },
      [5] = {
        ["x"] = 386.5,
        ["y"] = -280.1,
        ["g"] = 17,
        ["sublevel"] = 4,
      },
      [6] = {
        ["x"] = 404.8,
        ["y"] = -276.1,
        ["g"] = 17,
        ["sublevel"] = 4,
      },
      [7] = {
        ["x"] = 424.8,
        ["y"] = -271.7,
        ["g"] = 17,
        ["sublevel"] = 4,
      },
      [8] = {
        ["x"] = 389.9,
        ["y"] = -299.4,
        ["g"] = 17,
        ["sublevel"] = 4,
      },
      [9] = {
        ["x"] = 409.9,
        ["y"] = -294.4,
        ["g"] = 17,
        ["sublevel"] = 4,
      },
      [10] = {
        ["x"] = 429.2,
        ["y"] = -288.5,
        ["g"] = 17,
        ["sublevel"] = 4,
      },
      [11] = {
        ["x"] = 435.1,
        ["y"] = -308.1,
        ["g"] = 17,
        ["sublevel"] = 4,
      },
      [12] = {
        ["x"] = 415.1,
        ["y"] = -313.1,
        ["g"] = 17,
        ["sublevel"] = 4,
      },
      [13] = {
        ["x"] = 396.5,
        ["y"] = -321.2,
        ["g"] = 17,
        ["sublevel"] = 4,
      },
    },
  },
  [10] = {
    ["name"] = "Sudsy Brew Alemental",
    ["id"] = 59522,
    ["count"] = 1,
    ["health"] = 4215920,
    ["scale"] = 1,
    ["displayId"] = 42966,
    ["creatureType"] = "Elemental",
    ["characteristics"] = {
    },
    ["spells"] = {
    },
    ["clones"] = {
      [1] = {
        ["x"] = 638.3,
        ["y"] = -173.6,
        ["g"] = 15,
        ["sublevel"] = 3,
      },
      [2] = {
        ["x"] = 645.1,
        ["y"] = -196.7,
        ["g"] = 15,
        ["sublevel"] = 3,
      },
      [3] = {
        ["x"] = 389.6,
        ["y"] = -346.4,
        ["g"] = 18,
        ["sublevel"] = 4,
      },
      [4] = {
        ["x"] = 407,
        ["y"] = -342.1,
        ["g"] = 18,
        ["sublevel"] = 4,
      },
      [5] = {
        ["x"] = 431.6,
        ["y"] = -335.2,
        ["g"] = 18,
        ["sublevel"] = 4,
      },
      [6] = {
        ["x"] = 450.3,
        ["y"] = -329,
        ["g"] = 18,
        ["sublevel"] = 4,
      },
    },
  },
  [11] = {
    ["name"] = "Bloated Brew Alemental",
    ["id"] = 59518,
    ["count"] = 1,
    ["health"] = 4890384,
    ["scale"] = 1,
    ["displayId"] = 42967,
    ["creatureType"] = "Elemental",
    ["characteristics"] = {
    },
    ["spells"] = {
    },
    ["clones"] = {
      [1] = {
        ["x"] = 409.1,
        ["y"] = -244.5,
        ["g"] = 16,
        ["sublevel"] = 4,
      },
      [2] = {
        ["x"] = 376,
        ["y"] = -251.5,
        ["g"] = 16,
        ["sublevel"] = 4,
      },
    },
  },
  [12] = {
    ["name"] = "Yan-Zhu the Uncasked",
    ["id"] = 59479,
    ["count"] = 0,
    ["health"] = 21806850,
    ["scale"] = 1.6,
    ["displayId"] = 42969,
    ["creatureType"] = "Elemental",
    ["isBoss"] = true,
    ["instanceID"] = 302,
    ["characteristics"] = {
    },
    ["spells"] = {
    },
    ["clones"] = {
      [1] = {
        ["x"] = 433.2,
        ["y"] = -366.6,
        ["sublevel"] = 4,
      },
    },
  },
};
