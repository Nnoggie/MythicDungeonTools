local MDT = MDT
local L = MDT.L

local dungeonIndex = 133
MDT.dungeonList[dungeonIndex] = L["Scarlet Monastery"]
MDT.mapInfo[dungeonIndex] = {
  iconId = 135955,
  shortName = L["scarletMonasteryShortName"],
  englishName = "Scarlet Monastery",
  mapID = 1004,
};

local zones = { 435, 436 }
for _, zone in ipairs(zones) do
  MDT.zoneIdToDungeonIdx[zone] = dungeonIndex
end

MDT.dungeonMaps[dungeonIndex] = {
  [0] = "ScarletMonestaryDK",
  [1] = "ScarletMonestaryDK1_",
  [2] = "ScarletMonestaryDK2_",
}
MDT.dungeonSubLevels[dungeonIndex] = {
  [1] = L["Forlorn Cloister"],
  [2] = L["Crusaders\' Chapel"],
}

MDT.dungeonTotalCount[dungeonIndex] = { normal = 40, teeming = 1000, teemingEnabled = true }

MDT.mapPOIs[dungeonIndex] = {};

MDT.dungeonEnemies[dungeonIndex] = {
  [1] = {
    ["name"] = "Scarlet Centurion",
    ["id"] = 59746,
    ["count"] = 1,
    ["health"] = 3260256,
    ["scale"] = 1,
    ["displayId"] = 40780,
    ["creatureType"] = "Humanoid",
    ["characteristics"] = {
    },
    ["spells"] = {
    },
    ["clones"] = {
      [1] = {
        ["x"] = 559.2,
        ["y"] = -297.6,
        ["g"] = 2,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 556.4,
        ["y"] = -292.1,
        ["g"] = 2,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 536.3,
        ["y"] = -211.1,
        ["g"] = 1,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 536.9,
        ["y"] = -221.5,
        ["g"] = 1,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 524.4,
        ["y"] = -132,
        ["g"] = 5,
        ["sublevel"] = 1,
      },
      [6] = {
        ["x"] = 543.3,
        ["y"] = -132.9,
        ["g"] = 5,
        ["sublevel"] = 1,
      },
      [7] = {
        ["x"] = 457.1,
        ["y"] = -249.8,
        ["g"] = 4,
        ["sublevel"] = 1,
      },
      [8] = {
        ["x"] = 457.8,
        ["y"] = -256.3,
        ["g"] = 4,
        ["sublevel"] = 1,
      },
      [9] = {
        ["x"] = 455.1,
        ["y"] = -375.5,
        ["g"] = 3,
        ["sublevel"] = 1,
      },
      [10] = {
        ["x"] = 449.5,
        ["y"] = -381.2,
        ["g"] = 3,
        ["sublevel"] = 1,
      },
      [11] = {
        ["x"] = 373.8,
        ["y"] = -226,
        ["g"] = 6,
        ["sublevel"] = 1,
      },
      [12] = {
        ["x"] = 379.1,
        ["y"] = -233.2,
        ["g"] = 6,
        ["sublevel"] = 1,
      },
    },
  },
  [2] = {
    ["name"] = "Pile of Corpses",
    ["id"] = 59722,
    ["count"] = 0,
    ["health"] = 3260256,
    ["scale"] = 0.8,
    ["displayId"] = 45860,
    ["creatureType"] = "Uncategorized",
    ["characteristics"] = {
    },
    ["spells"] = {
    },
    ["clones"] = {
      [1] = {
        ["x"] = 545.9,
        ["y"] = -301.4,
        ["g"] = 2,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 519.8,
        ["y"] = -219.1,
        ["g"] = 1,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 534.6,
        ["y"] = -141.7,
        ["g"] = 5,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 467.8,
        ["y"] = -251.3,
        ["g"] = 4,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 442.5,
        ["y"] = -369.5,
        ["g"] = 3,
        ["sublevel"] = 1,
      },
      [6] = {
        ["x"] = 385.9,
        ["y"] = -225.5,
        ["g"] = 6,
        ["sublevel"] = 1,
      },
    },
  },
  [3] = {
    ["name"] = "Scarlet Flamethrower",
    ["id"] = 59705,
    ["count"] = 1,
    ["health"] = 2445192,
    ["scale"] = 1,
    ["displayId"] = 40725,
    ["creatureType"] = "Humanoid",
    ["characteristics"] = {
    },
    ["spells"] = {
    },
    ["clones"] = {
      [1] = {
        ["x"] = 559.8,
        ["y"] = -304.9,
        ["g"] = 2,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 530.7,
        ["y"] = -204.6,
        ["g"] = 1,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 546.3,
        ["y"] = -142.8,
        ["g"] = 5,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 459.3,
        ["y"] = -243.1,
        ["g"] = 4,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 444.4,
        ["y"] = -382.4,
        ["g"] = 3,
        ["sublevel"] = 1,
      },
      [6] = {
        ["x"] = 374.9,
        ["y"] = -218.9,
        ["g"] = 6,
        ["sublevel"] = 1,
      },
    },
  },
  [4] = {
    ["name"] = "Frenzied Spirit",
    ["id"] = 60033,
    ["count"] = 1,
    ["health"] = 815064,
    ["scale"] = 0.8,
    ["displayId"] = 24653,
    ["creatureType"] = "Undead",
    ["characteristics"] = {
    },
    ["spells"] = {
    },
    ["clones"] = {
      [1] = {
        ["x"] = 225.6,
        ["y"] = -178.5,
        ["g"] = 7,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 253.6,
        ["y"] = -145.1,
        ["g"] = 7,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 236.1,
        ["y"] = -160,
        ["g"] = 7,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 234,
        ["y"] = -145.7,
        ["g"] = 7,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 252.3,
        ["y"] = -182.8,
        ["g"] = 7,
        ["sublevel"] = 1,
      },
      [6] = {
        ["x"] = 270.5,
        ["y"] = -180.6,
        ["g"] = 7,
        ["sublevel"] = 1,
      },
      [7] = {
        ["x"] = 245.3,
        ["y"] = -335.8,
        ["g"] = 8,
        ["sublevel"] = 1,
      },
      [8] = {
        ["x"] = 259.5,
        ["y"] = -333.8,
        ["g"] = 8,
        ["sublevel"] = 1,
      },
      [9] = {
        ["x"] = 251,
        ["y"] = -359.5,
        ["g"] = 8,
        ["sublevel"] = 1,
      },
      [10] = {
        ["x"] = 220.8,
        ["y"] = -308.7,
        ["g"] = 8,
        ["sublevel"] = 1,
      },
      [11] = {
        ["x"] = 257.4,
        ["y"] = -306.6,
        ["g"] = 8,
        ["sublevel"] = 1,
      },
      [12] = {
        ["x"] = 247.5,
        ["y"] = -315.2,
        ["g"] = 8,
        ["sublevel"] = 1,
      },
    },
  },
  [5] = {
    ["name"] = "Thalnos the Soulrender",
    ["id"] = 59789,
    ["count"] = 0,
    ["health"] = 23987536,
    ["scale"] = 1.6,
    ["displayId"] = 27705,
    ["creatureType"] = "Undead",
    ["isBoss"] = true,
    ["instanceID"] = 316,
    ["characteristics"] = {
    },
    ["spells"] = {
    },
    ["clones"] = {
      [1] = {
        ["x"] = 204.2,
        ["y"] = -255.9,
        ["sublevel"] = 1,
      },
    },
  },
  [6] = {
    ["name"] = "Scarlet Judicator",
    ["id"] = 58605,
    ["count"] = 1,
    ["health"] = 2037660,
    ["scale"] = 1,
    ["displayId"] = 41282,
    ["creatureType"] = "Humanoid",
    ["characteristics"] = {
    },
    ["spells"] = {
    },
    ["clones"] = {
      [1] = {
        ["x"] = 295.6,
        ["y"] = -445.6,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 338.1,
        ["y"] = -437.9,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 381.7,
        ["y"] = -84,
        ["g"] = 10,
        ["sublevel"] = 2,
      },
      [4] = {
        ["x"] = 380.3,
        ["y"] = -88.1,
        ["g"] = 10,
        ["sublevel"] = 2,
      },
      [5] = {
        ["x"] = 405.3,
        ["y"] = -105.5,
        ["g"] = 15,
        ["sublevel"] = 2,
      },
      [6] = {
        ["x"] = 400,
        ["y"] = -105.2,
        ["g"] = 15,
        ["sublevel"] = 2,
      },
      [7] = {
        ["x"] = 442.6,
        ["y"] = -155.5,
        ["g"] = 17,
        ["sublevel"] = 2,
      },
      [8] = {
        ["x"] = 382.1,
        ["y"] = -169.2,
        ["g"] = 18,
        ["sublevel"] = 2,
      },
      [9] = {
        ["x"] = 386.8,
        ["y"] = -169.3,
        ["g"] = 18,
        ["sublevel"] = 2,
      },
      [10] = {
        ["x"] = 331.7,
        ["y"] = -200.3,
        ["g"] = 19,
        ["sublevel"] = 2,
      },
      [11] = {
        ["x"] = 489.2,
        ["y"] = -415.2,
        ["g"] = 29,
        ["sublevel"] = 2,
      },
      [12] = {
        ["x"] = 374.8,
        ["y"] = -466.1,
        ["g"] = 9,
        ["sublevel"] = 1,
      },
    },
  },
  [7] = {
    ["name"] = "Scarlet Fanatic",
    ["id"] = 58555,
    ["count"] = 1,
    ["health"] = 2037660,
    ["scale"] = 1,
    ["displayId"] = 41288,
    ["creatureType"] = "Humanoid",
    ["characteristics"] = {
    },
    ["spells"] = {
    },
    ["clones"] = {
      [1] = {
        ["x"] = 363.3,
        ["y"] = -486,
        ["g"] = 9,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 447,
        ["y"] = -93.3,
        ["g"] = 13,
        ["sublevel"] = 2,
      },
      [3] = {
        ["x"] = 462.5,
        ["y"] = -125.9,
        ["g"] = 16,
        ["sublevel"] = 2,
      },
      [4] = {
        ["x"] = 362.5,
        ["y"] = -125.4,
        ["g"] = 12,
        ["sublevel"] = 2,
      },
      [5] = {
        ["x"] = 376.7,
        ["y"] = -238.4,
        ["g"] = 20,
        ["sublevel"] = 2,
      },
      [6] = {
        ["x"] = 378.2,
        ["y"] = -241.3,
        ["g"] = 20,
        ["sublevel"] = 2,
      },
      [7] = {
        ["x"] = 379.3,
        ["y"] = -244.5,
        ["g"] = 20,
        ["sublevel"] = 2,
      },
      [8] = {
        ["x"] = 471.2,
        ["y"] = -223.6,
        ["g"] = 23,
        ["sublevel"] = 2,
      },
      [9] = {
        ["x"] = 471.3,
        ["y"] = -218.5,
        ["g"] = 23,
        ["sublevel"] = 2,
      },
      [10] = {
        ["x"] = 471.1,
        ["y"] = -228.5,
        ["g"] = 23,
        ["sublevel"] = 2,
      },
      [11] = {
        ["x"] = 493.6,
        ["y"] = -204.1,
        ["g"] = 24,
        ["sublevel"] = 2,
      },
      [12] = {
        ["x"] = 487.4,
        ["y"] = -204.2,
        ["g"] = 24,
        ["sublevel"] = 2,
      },
      [13] = {
        ["x"] = 440.2,
        ["y"] = -273.4,
        ["g"] = 22,
        ["sublevel"] = 2,
      },
      [14] = {
        ["x"] = 439.9,
        ["y"] = -278.4,
        ["g"] = 22,
        ["sublevel"] = 2,
      },
      [15] = {
        ["x"] = 439.6,
        ["y"] = -284.1,
        ["g"] = 22,
        ["sublevel"] = 2,
      },
      [16] = {
        ["x"] = 384.5,
        ["y"] = -273,
        ["g"] = 21,
        ["sublevel"] = 2,
      },
      [17] = {
        ["x"] = 384.5,
        ["y"] = -278,
        ["g"] = 21,
        ["sublevel"] = 2,
      },
      [18] = {
        ["x"] = 384.4,
        ["y"] = -283.7,
        ["g"] = 21,
        ["sublevel"] = 2,
      },
      [19] = {
        ["x"] = 397.5,
        ["y"] = -353.9,
        ["g"] = 25,
        ["sublevel"] = 2,
      },
      [20] = {
        ["x"] = 396.8,
        ["y"] = -358.2,
        ["g"] = 25,
        ["sublevel"] = 2,
      },
      [21] = {
        ["x"] = 422.4,
        ["y"] = -380.2,
        ["g"] = 26,
        ["sublevel"] = 2,
      },
      [22] = {
        ["x"] = 426.4,
        ["y"] = -384.2,
        ["g"] = 26,
        ["sublevel"] = 2,
      },
      [23] = {
        ["x"] = 428.5,
        ["y"] = -482.4,
        ["g"] = 30,
        ["sublevel"] = 1,
      },
    },
  },
  [8] = {
    ["name"] = "Scarlet Zealot",
    ["id"] = 58590,
    ["count"] = 1,
    ["health"] = 2445192,
    ["scale"] = 1,
    ["displayId"] = 40671,
    ["creatureType"] = "Humanoid",
    ["characteristics"] = {
    },
    ["spells"] = {
    },
    ["clones"] = {
      [1] = {
        ["x"] = 375.1,
        ["y"] = -486.1,
        ["g"] = 9,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 427.4,
        ["y"] = -94,
        ["sublevel"] = 2,
      },
      [3] = {
        ["x"] = 449.5,
        ["y"] = -88.7,
        ["g"] = 13,
        ["sublevel"] = 2,
      },
      [4] = {
        ["x"] = 467.9,
        ["y"] = -122.5,
        ["g"] = 16,
        ["sublevel"] = 2,
      },
      [5] = {
        ["x"] = 442.5,
        ["y"] = -159.4,
        ["g"] = 17,
        ["sublevel"] = 2,
      },
      [6] = {
        ["x"] = 384.7,
        ["y"] = -171.8,
        ["g"] = 18,
        ["sublevel"] = 2,
      },
      [7] = {
        ["x"] = 356.8,
        ["y"] = -128.4,
        ["g"] = 12,
        ["sublevel"] = 2,
      },
      [8] = {
        ["x"] = 490.4,
        ["y"] = -198.6,
        ["g"] = 24,
        ["sublevel"] = 2,
      },
      [9] = {
        ["x"] = 334.5,
        ["y"] = -238.5,
        ["sublevel"] = 2,
      },
      [10] = {
        ["x"] = 400.3,
        ["y"] = -353.9,
        ["g"] = 25,
        ["sublevel"] = 2,
      },
      [11] = {
        ["x"] = 426.7,
        ["y"] = -380.3,
        ["g"] = 26,
        ["sublevel"] = 2,
      },
      [12] = {
        ["x"] = 488.1,
        ["y"] = -418.5,
        ["g"] = 29,
        ["sublevel"] = 2,
      },
      [13] = {
        ["x"] = 342.3,
        ["y"] = -418.1,
        ["g"] = 27,
        ["sublevel"] = 2,
      },
      [14] = {
        ["x"] = 362.7,
        ["y"] = -476.4,
        ["g"] = 9,
        ["sublevel"] = 1,
      },
      [15] = {
        ["x"] = 424.8,
        ["y"] = -471.5,
        ["g"] = 30,
        ["sublevel"] = 1,
      },
    },
  },
  [9] = {
    ["name"] = "Scarlet Purifier",
    ["id"] = 58569,
    ["count"] = 1,
    ["health"] = 1467112,
    ["scale"] = 1,
    ["displayId"] = 40669,
    ["creatureType"] = "Humanoid",
    ["characteristics"] = {
    },
    ["spells"] = {
    },
    ["clones"] = {
      [1] = {
        ["x"] = 362.7,
        ["y"] = -466.9,
        ["g"] = 9,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 357,
        ["y"] = -69.6,
        ["g"] = 11,
        ["sublevel"] = 2,
      },
      [3] = {
        ["x"] = 360.5,
        ["y"] = -63.7,
        ["g"] = 11,
        ["sublevel"] = 2,
      },
      [4] = {
        ["x"] = 422.6,
        ["y"] = -103.5,
        ["g"] = 14,
        ["sublevel"] = 2,
      },
      [5] = {
        ["x"] = 426.2,
        ["y"] = -104.3,
        ["g"] = 14,
        ["sublevel"] = 2,
      },
      [6] = {
        ["x"] = 452.3,
        ["y"] = -93.1,
        ["g"] = 13,
        ["sublevel"] = 2,
      },
      [7] = {
        ["x"] = 468,
        ["y"] = -129.4,
        ["g"] = 16,
        ["sublevel"] = 2,
      },
      [8] = {
        ["x"] = 467.1,
        ["y"] = -98.8,
        ["sublevel"] = 2,
      },
      [9] = {
        ["x"] = 445.2,
        ["y"] = -155.4,
        ["g"] = 17,
        ["sublevel"] = 2,
      },
      [10] = {
        ["x"] = 445.1,
        ["y"] = -159,
        ["g"] = 17,
        ["sublevel"] = 2,
      },
      [11] = {
        ["x"] = 359.1,
        ["y"] = -93.5,
        ["sublevel"] = 2,
      },
      [12] = {
        ["x"] = 357.1,
        ["y"] = -121.5,
        ["g"] = 12,
        ["sublevel"] = 2,
      },
      [13] = {
        ["x"] = 335.3,
        ["y"] = -197.9,
        ["g"] = 19,
        ["sublevel"] = 2,
      },
      [14] = {
        ["x"] = 400,
        ["y"] = -358.3,
        ["g"] = 25,
        ["sublevel"] = 2,
      },
      [15] = {
        ["x"] = 380.7,
        ["y"] = -346.9,
        ["sublevel"] = 2,
      },
      [16] = {
        ["x"] = 444.6,
        ["y"] = -347,
        ["sublevel"] = 2,
      },
      [17] = {
        ["x"] = 444.3,
        ["y"] = -373.3,
        ["sublevel"] = 2,
      },
      [18] = {
        ["x"] = 422.1,
        ["y"] = -383.8,
        ["g"] = 26,
        ["sublevel"] = 2,
      },
      [19] = {
        ["x"] = 393.8,
        ["y"] = -406.9,
        ["sublevel"] = 2,
      },
      [20] = {
        ["x"] = 380.3,
        ["y"] = -373.1,
        ["sublevel"] = 2,
      },
      [21] = {
        ["x"] = 374.9,
        ["y"] = -476.3,
        ["g"] = 9,
        ["sublevel"] = 1,
      },
      [22] = {
        ["x"] = 437.3,
        ["y"] = -475.8,
        ["g"] = 30,
        ["sublevel"] = 1,
      },
    },
  },
  [10] = {
    ["name"] = "Brother Korloff",
    ["id"] = 59223,
    ["count"] = 0,
    ["health"] = 23987536,
    ["scale"] = 1.6,
    ["displayId"] = 41154,
    ["creatureType"] = "Humanoid",
    ["isBoss"] = true,
    ["instanceID"] = 316,
    ["characteristics"] = {
    },
    ["spells"] = {
    },
    ["clones"] = {
      [1] = {
        ["x"] = 411.8,
        ["y"] = -279.4,
        ["sublevel"] = 2,
      },
    },
  },
  [11] = {
    ["name"] = "Scarlet Initiate",
    ["id"] = 58783,
    ["count"] = 0,
    ["health"] = 611298,
    ["scale"] = 0.8,
    ["displayId"] = 2492,
    ["creatureType"] = "Humanoid",
    ["characteristics"] = {
    },
    ["spells"] = {
    },
    ["clones"] = {
      [1] = {
        ["x"] = 336.5,
        ["y"] = -417.9,
        ["g"] = 27,
        ["sublevel"] = 2,
      },
      [2] = {
        ["x"] = 331.6,
        ["y"] = -417.6,
        ["g"] = 27,
        ["sublevel"] = 2,
      },
      [3] = {
        ["x"] = 331.5,
        ["y"] = -422.3,
        ["g"] = 27,
        ["sublevel"] = 2,
      },
      [4] = {
        ["x"] = 336.5,
        ["y"] = -413.6,
        ["g"] = 27,
        ["sublevel"] = 2,
      },
      [5] = {
        ["x"] = 331.5,
        ["y"] = -413,
        ["g"] = 27,
        ["sublevel"] = 2,
      },
      [6] = {
        ["x"] = 336.1,
        ["y"] = -422.4,
        ["g"] = 27,
        ["sublevel"] = 2,
      },
    },
  },
  [12] = {
    ["name"] = "Commander Durand",
    ["id"] = 60040,
    ["count"] = 0,
    ["health"] = 13084110,
    ["scale"] = 1.6,
    ["displayId"] = 41220,
    ["creatureType"] = "Humanoid",
    ["isBoss"] = true,
    ["instanceID"] = 316,
    ["characteristics"] = {
    },
    ["spells"] = {
    },
    ["clones"] = {
      [1] = {
        ["x"] = 411.9,
        ["y"] = -436.3,
        ["g"] = 28,
        ["sublevel"] = 2,
      },
    },
  },
  [13] = {
    ["name"] = "High Inquisitor Whitemane",
    ["id"] = 3977,
    ["count"] = 0,
    ["health"] = 10690097,
    ["scale"] = 1.6,
    ["displayId"] = 2043,
    ["creatureType"] = "Humanoid",
    ["isBoss"] = true,
    ["instanceID"] = 316,
    ["characteristics"] = {
    },
    ["spells"] = {
    },
    ["clones"] = {
      [1] = {
        ["x"] = 412.1,
        ["y"] = -444.7,
        ["g"] = 28,
        ["sublevel"] = 2,
      },
    },
  },
};
