local addonName = ...
local MDT = MDT
local L = MDT.L

local dungeonIndex = 136
MDT.dungeonList[dungeonIndex] = L["Siege of Niuzao Temple"]
MDT.mapInfo[dungeonIndex] = {
  iconId = 615986,
  shortName = L["siegeOfNiuzaoTempleShortName"],
  englishName = "Siege of Niuzao Temple",
  mapID = 1011,
};

local zones = { 457, 458, 459 }
for _, zone in ipairs(zones) do
  MDT.zoneIdToDungeonIdx[zone] = dungeonIndex
end

MDT.dungeonMaps[dungeonIndex] = {
  [0] = "",
  [1] = { customTextures = 'Interface\\AddOns\\'..addonName..'\\MistsOfPandaria\\Textures\\SiegeOfNiuzao' },
}
MDT.dungeonSubLevels[dungeonIndex] = {
  [1] = L["Siege of Niuzao Temple"],
}

MDT.dungeonTotalCount[dungeonIndex] = { normal = 65, teeming = 1000, teemingEnabled = true }

MDT.mapPOIs[dungeonIndex] = {};

MDT.dungeonEnemies[dungeonIndex] = {
  [1] = {
    ["name"] = "Sik\'thik Guardian",
    ["id"] = 61928,
    ["count"] = 1,
    ["health"] = 2107960,
    ["scale"] = 1,
    ["displayId"] = 43198,
    ["creatureType"] = "Humanoid",
    ["characteristics"] = {
    },
    ["spells"] = {
    },
    ["clones"] = {
      [1] = {
        ["x"] = 561.2,
        ["y"] = -427.5,
        ["g"] = 1,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 568.4,
        ["y"] = -418.7,
        ["g"] = 1,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 530.7,
        ["y"] = -366.5,
        ["g"] = 3,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 516.6,
        ["y"] = -364.3,
        ["g"] = 3,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 463.1,
        ["y"] = -393.7,
        ["g"] = 5,
        ["sublevel"] = 1,
      },
      [6] = {
        ["x"] = 459.7,
        ["y"] = -402.6,
        ["g"] = 5,
        ["sublevel"] = 1,
      },
      [7] = {
        ["x"] = 497.9,
        ["y"] = -459.7,
        ["g"] = 7,
        ["sublevel"] = 1,
      },
      [8] = {
        ["x"] = 505.5,
        ["y"] = -459.4,
        ["g"] = 7,
        ["sublevel"] = 1,
      },
      [9] = {
        ["x"] = 521.4,
        ["y"] = -344.8,
        ["g"] = 9,
        ["sublevel"] = 1,
      },
      [10] = {
        ["x"] = 505.8,
        ["y"] = -344.8,
        ["g"] = 9,
        ["sublevel"] = 1,
      },
      [11] = {
        ["x"] = 505.9,
        ["y"] = -469,
        ["g"] = 11,
        ["sublevel"] = 1,
      },
      [12] = {
        ["x"] = 521,
        ["y"] = -468.6,
        ["g"] = 11,
        ["sublevel"] = 1,
      },
    },
  },
  [2] = {
    ["name"] = "Sik\'thik Amber-Weaver",
    ["id"] = 61929,
    ["count"] = 1,
    ["health"] = 2107960,
    ["scale"] = 1,
    ["displayId"] = 43196,
    ["creatureType"] = "Humanoid",
    ["characteristics"] = {
    },
    ["spells"] = {
    },
    ["clones"] = {
      [1] = {
        ["x"] = 562.4,
        ["y"] = -420.4,
        ["g"] = 1,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 567.6,
        ["y"] = -430.6,
        ["g"] = 1,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 523.1,
        ["y"] = -366.2,
        ["g"] = 3,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 524.9,
        ["y"] = -361.9,
        ["g"] = 3,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 466.9,
        ["y"] = -397.7,
        ["g"] = 5,
        ["sublevel"] = 1,
      },
      [6] = {
        ["x"] = 457.4,
        ["y"] = -388.6,
        ["g"] = 5,
        ["sublevel"] = 1,
      },
      [7] = {
        ["x"] = 500.9,
        ["y"] = -454.2,
        ["g"] = 7,
        ["sublevel"] = 1,
      },
      [8] = {
        ["x"] = 514.4,
        ["y"] = -339.6,
        ["g"] = 9,
        ["sublevel"] = 1,
      },
      [9] = {
        ["x"] = 529.7,
        ["y"] = -340.3,
        ["g"] = 9,
        ["sublevel"] = 1,
      },
      [10] = {
        ["x"] = 513.1,
        ["y"] = -474,
        ["g"] = 11,
        ["sublevel"] = 1,
      },
    },
  },
  [3] = {
    ["name"] = "Resin Flake",
    ["id"] = 61910,
    ["count"] = 1,
    ["health"] = 1053980,
    ["scale"] = 1,
    ["displayId"] = 33011,
    ["creatureType"] = "Elemental",
    ["characteristics"] = {
    },
    ["spells"] = {
    },
    ["clones"] = {
      [1] = {
        ["x"] = 560.8,
        ["y"] = -387.9,
        ["g"] = 2,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 560.6,
        ["y"] = -379.8,
        ["g"] = 2,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 557.5,
        ["y"] = -390.9,
        ["g"] = 2,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 553.2,
        ["y"] = -380.9,
        ["g"] = 2,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 557.8,
        ["y"] = -383.9,
        ["g"] = 2,
        ["sublevel"] = 1,
      },
      [6] = {
        ["x"] = 552.6,
        ["y"] = -386.8,
        ["g"] = 2,
        ["sublevel"] = 1,
      },
      [7] = {
        ["x"] = 491.1,
        ["y"] = -364.1,
        ["g"] = 4,
        ["sublevel"] = 1,
      },
      [8] = {
        ["x"] = 495.7,
        ["y"] = -366.2,
        ["g"] = 4,
        ["sublevel"] = 1,
      },
      [9] = {
        ["x"] = 490.9,
        ["y"] = -355,
        ["g"] = 4,
        ["sublevel"] = 1,
      },
      [10] = {
        ["x"] = 490.3,
        ["y"] = -369,
        ["g"] = 4,
        ["sublevel"] = 1,
      },
      [11] = {
        ["x"] = 484.3,
        ["y"] = -355.6,
        ["g"] = 4,
        ["sublevel"] = 1,
      },
      [12] = {
        ["x"] = 494,
        ["y"] = -358.8,
        ["g"] = 4,
        ["sublevel"] = 1,
      },
      [13] = {
        ["x"] = 486.1,
        ["y"] = -370.3,
        ["g"] = 4,
        ["sublevel"] = 1,
      },
      [14] = {
        ["x"] = 486.7,
        ["y"] = -360.6,
        ["g"] = 4,
        ["sublevel"] = 1,
      },
      [15] = {
        ["x"] = 482.2,
        ["y"] = -366.6,
        ["g"] = 4,
        ["sublevel"] = 1,
      },
      [16] = {
        ["x"] = 481.2,
        ["y"] = -361.5,
        ["g"] = 4,
        ["sublevel"] = 1,
      },
      [17] = {
        ["x"] = 471.1,
        ["y"] = -422.1,
        ["g"] = 6,
        ["sublevel"] = 1,
      },
      [18] = {
        ["x"] = 473.3,
        ["y"] = -428.6,
        ["g"] = 6,
        ["sublevel"] = 1,
      },
      [19] = {
        ["x"] = 461.2,
        ["y"] = -424.1,
        ["g"] = 6,
        ["sublevel"] = 1,
      },
      [20] = {
        ["x"] = 466.3,
        ["y"] = -420.4,
        ["g"] = 6,
        ["sublevel"] = 1,
      },
      [21] = {
        ["x"] = 467.1,
        ["y"] = -428.6,
        ["g"] = 6,
        ["sublevel"] = 1,
      },
      [22] = {
        ["x"] = 460.8,
        ["y"] = -430.4,
        ["g"] = 6,
        ["sublevel"] = 1,
      },
      [23] = {
        ["x"] = 469.9,
        ["y"] = -432.6,
        ["g"] = 6,
        ["sublevel"] = 1,
      },
      [24] = {
        ["x"] = 464.9,
        ["y"] = -435.4,
        ["g"] = 6,
        ["sublevel"] = 1,
      },
      [25] = {
        ["x"] = 584.3,
        ["y"] = -431,
        ["g"] = 8,
        ["sublevel"] = 1,
      },
      [26] = {
        ["x"] = 578.6,
        ["y"] = -423.7,
        ["g"] = 8,
        ["sublevel"] = 1,
      },
      [27] = {
        ["x"] = 590.5,
        ["y"] = -423.1,
        ["g"] = 8,
        ["sublevel"] = 1,
      },
      [28] = {
        ["x"] = 577.2,
        ["y"] = -438.3,
        ["g"] = 8,
        ["sublevel"] = 1,
      },
      [29] = {
        ["x"] = 590.3,
        ["y"] = -439.7,
        ["g"] = 8,
        ["sublevel"] = 1,
      },
      [30] = {
        ["x"] = 446.3,
        ["y"] = -385.4,
        ["g"] = 10,
        ["sublevel"] = 1,
      },
      [31] = {
        ["x"] = 438.4,
        ["y"] = -391.9,
        ["g"] = 10,
        ["sublevel"] = 1,
      },
      [32] = {
        ["x"] = 434.4,
        ["y"] = -402.3,
        ["g"] = 10,
        ["sublevel"] = 1,
      },
      [33] = {
        ["x"] = 429.5,
        ["y"] = -394.9,
        ["g"] = 10,
        ["sublevel"] = 1,
      },
      [34] = {
        ["x"] = 446.3,
        ["y"] = -401.6,
        ["g"] = 10,
        ["sublevel"] = 1,
      },
      [35] = {
        ["x"] = 447.8,
        ["y"] = -392.9,
        ["g"] = 10,
        ["sublevel"] = 1,
      },
    },
  },
  [4] = {
    ["name"] = "Vizier Jin\'bak",
    ["id"] = 61567,
    ["count"] = 0,
    ["health"] = 19626164,
    ["scale"] = 1.6,
    ["displayId"] = 43197,
    ["creatureType"] = "Humanoid",
    ["isBoss"] = true,
    ["instanceID"] = 324,
    ["characteristics"] = {
    },
    ["spells"] = {
    },
    ["clones"] = {
      [1] = {
        ["x"] = 511.9,
        ["y"] = -408.7,
        ["sublevel"] = 1,
      },
    },
  },
  [5] = {
    ["name"] = "Sik\'thik Warden",
    ["id"] = 62795,
    ["count"] = 1,
    ["health"] = 3260256,
    ["scale"] = 1,
    ["displayId"] = 42193,
    ["creatureType"] = "Humanoid",
    ["characteristics"] = {
    },
    ["spells"] = {
    },
    ["clones"] = {
      [1] = {
        ["x"] = 379.4,
        ["y"] = -414.7,
        ["sublevel"] = 1,
      },
    },
  },
  [6] = {
    ["name"] = "Sik\'thik Swarmer",
    ["id"] = 63106,
    ["count"] = 0,
    ["health"] = 2445192,
    ["scale"] = 1,
    ["displayId"] = 43322,
    ["creatureType"] = "Humanoid",
    ["characteristics"] = {
    },
    ["spells"] = {
    },
    ["clones"] = {
      [1] = {
        ["x"] = 314.4,
        ["y"] = -431.4,
        ["g"] = 12,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 298.1,
        ["y"] = -416,
        ["g"] = 15,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 297.3,
        ["y"] = -436.2,
        ["g"] = 15,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 314.6,
        ["y"] = -407.3,
        ["g"] = 12,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 314.6,
        ["y"] = -411.6,
        ["g"] = 12,
        ["sublevel"] = 1,
      },
      [6] = {
        ["x"] = 314.3,
        ["y"] = -436.6,
        ["g"] = 12,
        ["sublevel"] = 1,
      },
      [7] = {
        ["x"] = 314.5,
        ["y"] = -415.5,
        ["g"] = 12,
        ["sublevel"] = 1,
      },
      [8] = {
        ["x"] = 314.6,
        ["y"] = -440.6,
        ["g"] = 12,
        ["sublevel"] = 1,
      },
      [9] = {
        ["x"] = 297.5,
        ["y"] = -431.1,
        ["g"] = 15,
        ["sublevel"] = 1,
      },
      [10] = {
        ["x"] = 298,
        ["y"] = -406.6,
        ["g"] = 15,
        ["sublevel"] = 1,
      },
      [11] = {
        ["x"] = 305.1,
        ["y"] = -438.9,
        ["g"] = 14,
        ["sublevel"] = 1,
      },
      [12] = {
        ["x"] = 298.1,
        ["y"] = -411.1,
        ["g"] = 15,
        ["sublevel"] = 1,
      },
      [13] = {
        ["x"] = 297.5,
        ["y"] = -441.1,
        ["g"] = 15,
        ["sublevel"] = 1,
      },
    },
  },
  [7] = {
    ["name"] = "Sik\'thik Amberwing",
    ["id"] = 61699,
    ["count"] = 0,
    ["health"] = 5705448,
    ["scale"] = 1,
    ["displayId"] = 43955,
    ["creatureType"] = "Humanoid",
    ["characteristics"] = {
    },
    ["spells"] = {
    },
    ["clones"] = {
      [1] = {
        ["x"] = 349,
        ["y"] = -421.3,
        ["sublevel"] = 1,
      },
    },
  },
  [8] = {
    ["name"] = "Sik\'thik Demolisher",
    ["id"] = 61670,
    ["count"] = 0,
    ["health"] = 1833894,
    ["scale"] = 1,
    ["displayId"] = 42875,
    ["creatureType"] = "Humanoid",
    ["characteristics"] = {
    },
    ["spells"] = {
    },
    ["clones"] = {
      [1] = {
        ["x"] = 305.1,
        ["y"] = -447.8,
        ["g"] = 14,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 305.6,
        ["y"] = -412.9,
        ["g"] = 13,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 305.6,
        ["y"] = -407.8,
        ["g"] = 13,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 305.5,
        ["y"] = -417.1,
        ["g"] = 13,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 305.1,
        ["y"] = -434.3,
        ["g"] = 14,
        ["sublevel"] = 1,
      },
      [6] = {
        ["x"] = 305.1,
        ["y"] = -428.9,
        ["g"] = 14,
        ["sublevel"] = 1,
      },
      [7] = {
        ["x"] = 305.1,
        ["y"] = -443.4,
        ["g"] = 14,
        ["sublevel"] = 1,
      },
      [8] = {
        ["x"] = 305.9,
        ["y"] = -403.3,
        ["g"] = 13,
        ["sublevel"] = 1,
      },
      [9] = {
        ["x"] = 290.2,
        ["y"] = -448.4,
        ["g"] = 16,
        ["sublevel"] = 1,
      },
      [10] = {
        ["x"] = 289.9,
        ["y"] = -443.7,
        ["g"] = 16,
        ["sublevel"] = 1,
      },
      [11] = {
        ["x"] = 290.2,
        ["y"] = -438.9,
        ["g"] = 16,
        ["sublevel"] = 1,
      },
      [12] = {
        ["x"] = 290.4,
        ["y"] = -434.5,
        ["g"] = 16,
        ["sublevel"] = 1,
      },
      [13] = {
        ["x"] = 290.6,
        ["y"] = -429.5,
        ["g"] = 16,
        ["sublevel"] = 1,
      },
      [14] = {
        ["x"] = 290.6,
        ["y"] = -418.6,
        ["g"] = 17,
        ["sublevel"] = 1,
      },
      [15] = {
        ["x"] = 306.1,
        ["y"] = -400.1,
        ["g"] = 13,
        ["sublevel"] = 1,
      },
      [16] = {
        ["x"] = 290.8,
        ["y"] = -413.7,
        ["g"] = 17,
        ["sublevel"] = 1,
      },
      [17] = {
        ["x"] = 291,
        ["y"] = -408.3,
        ["g"] = 17,
        ["sublevel"] = 1,
      },
      [18] = {
        ["x"] = 291.2,
        ["y"] = -403.7,
        ["g"] = 17,
        ["sublevel"] = 1,
      },
      [19] = {
        ["x"] = 291.8,
        ["y"] = -399.7,
        ["g"] = 17,
        ["sublevel"] = 1,
      },
    },
  },
  [9] = {
    ["name"] = "Sik\'thik Warrior",
    ["id"] = 61701,
    ["count"] = 0,
    ["health"] = 10188300,
    ["scale"] = 1,
    ["displayId"] = 42207,
    ["creatureType"] = "Humanoid",
    ["characteristics"] = {
    },
    ["spells"] = {
    },
    ["clones"] = {
      [1] = {
        ["x"] = 285,
        ["y"] = -414.3,
        ["g"] = 17,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 284.8,
        ["y"] = -433.6,
        ["g"] = 16,
        ["sublevel"] = 1,
      },
    },
  },
  [10] = {
    ["name"] = "Commander Vo\'jak",
    ["id"] = 61634,
    ["count"] = 0,
    ["health"] = 19626164,
    ["scale"] = 1.6,
    ["displayId"] = 42169,
    ["creatureType"] = "Humanoid",
    ["isBoss"] = true,
    ["instanceID"] = 324,
    ["characteristics"] = {
    },
    ["spells"] = {
    },
    ["clones"] = {
      [1] = {
        ["x"] = 278.4,
        ["y"] = -423.2,
        ["sublevel"] = 1,
      },
    },
  },
  [11] = {
    ["name"] = "Sik\'thik Vanguard",
    ["id"] = 61434,
    ["count"] = 1,
    ["health"] = 3260256,
    ["scale"] = 1,
    ["displayId"] = 43119,
    ["creatureType"] = "Humanoid",
    ["characteristics"] = {
    },
    ["spells"] = {
    },
    ["clones"] = {
      [1] = {
        ["x"] = 303.5,
        ["y"] = -314.3,
        ["g"] = 29,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 308.9,
        ["y"] = -274.4,
        ["g"] = 18,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 317.1,
        ["y"] = -275,
        ["g"] = 18,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 312.5,
        ["y"] = -206.6,
        ["g"] = 20,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 341.2,
        ["y"] = -205.5,
        ["g"] = 19,
        ["sublevel"] = 1,
      },
      [6] = {
        ["x"] = 357,
        ["y"] = -169.8,
        ["g"] = 22,
        ["sublevel"] = 1,
      },
      [7] = {
        ["x"] = 331.9,
        ["y"] = -143.7,
        ["g"] = 21,
        ["sublevel"] = 1,
      },
      [8] = {
        ["x"] = 409.2,
        ["y"] = -241.8,
        ["g"] = 25,
        ["sublevel"] = 1,
      },
      [9] = {
        ["x"] = 413.3,
        ["y"] = -245,
        ["g"] = 25,
        ["sublevel"] = 1,
      },
      [10] = {
        ["x"] = 419.6,
        ["y"] = -271.6,
        ["g"] = 23,
        ["sublevel"] = 1,
      },
      [11] = {
        ["x"] = 444.8,
        ["y"] = -265.4,
        ["g"] = 24,
        ["sublevel"] = 1,
      },
      [12] = {
        ["x"] = 440,
        ["y"] = -262.3,
        ["g"] = 24,
        ["sublevel"] = 1,
      },
    },
  },
  [12] = {
    ["name"] = "Sik\'thik Battle-Mender",
    ["id"] = 67093,
    ["count"] = 0,
    ["health"] = 2281776,
    ["scale"] = 1,
    ["displayId"] = 45766,
    ["creatureType"] = "Humanoid",
    ["characteristics"] = {
    },
    ["spells"] = {
    },
    ["clones"] = {
      [1] = {
        ["x"] = 306.2,
        ["y"] = -307.7,
        ["g"] = 29,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 312.9,
        ["y"] = -275.7,
        ["g"] = 18,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 342.4,
        ["y"] = -199.5,
        ["g"] = 19,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 407.7,
        ["y"] = -247.5,
        ["g"] = 25,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 438.9,
        ["y"] = -268.7,
        ["g"] = 24,
        ["sublevel"] = 1,
      },
    },
  },
  [13] = {
    ["name"] = "Sik\'thik Bladedancer",
    ["id"] = 61436,
    ["count"] = 1,
    ["health"] = 3260256,
    ["scale"] = 1,
    ["displayId"] = 43118,
    ["creatureType"] = "Humanoid",
    ["characteristics"] = {
    },
    ["spells"] = {
    },
    ["clones"] = {
      [1] = {
        ["x"] = 301.6,
        ["y"] = -309.5,
        ["g"] = 29,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 308.6,
        ["y"] = -312.8,
        ["g"] = 29,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 335.1,
        ["y"] = -207.2,
        ["g"] = 19,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 335.5,
        ["y"] = -201.1,
        ["g"] = 19,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 403,
        ["y"] = -243.7,
        ["g"] = 25,
        ["sublevel"] = 1,
      },
      [6] = {
        ["x"] = 412.4,
        ["y"] = -250.5,
        ["g"] = 25,
        ["sublevel"] = 1,
      },
      [7] = {
        ["x"] = 425.8,
        ["y"] = -272.2,
        ["g"] = 23,
        ["sublevel"] = 1,
      },
      [8] = {
        ["x"] = 420.8,
        ["y"] = -277.8,
        ["g"] = 23,
        ["sublevel"] = 1,
      },
      [9] = {
        ["x"] = 434.3,
        ["y"] = -264.3,
        ["g"] = 24,
        ["sublevel"] = 1,
      },
      [10] = {
        ["x"] = 444.3,
        ["y"] = -271.3,
        ["g"] = 24,
        ["sublevel"] = 1,
      },
    },
  },
  [14] = {
    ["name"] = "Sik\'thik Soldier",
    ["id"] = 62348,
    ["count"] = 0,
    ["health"] = 305600,
    ["scale"] = 0.8,
    ["displayId"] = 43121,
    ["creatureType"] = "Humanoid",
    ["characteristics"] = {
    },
    ["spells"] = {
    },
    ["clones"] = {
      [1] = {
        ["x"] = 302.7,
        ["y"] = -204.6,
        ["g"] = 20,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 306.9,
        ["y"] = -199.5,
        ["g"] = 20,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 303.4,
        ["y"] = -194.5,
        ["g"] = 20,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 297.7,
        ["y"] = -208.4,
        ["g"] = 20,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 361.8,
        ["y"] = -161.9,
        ["g"] = 22,
        ["sublevel"] = 1,
      },
      [6] = {
        ["x"] = 368.5,
        ["y"] = -144,
        ["g"] = 22,
        ["sublevel"] = 1,
      },
      [7] = {
        ["x"] = 365.1,
        ["y"] = -165.6,
        ["g"] = 22,
        ["sublevel"] = 1,
      },
      [8] = {
        ["x"] = 366.5,
        ["y"] = -161,
        ["g"] = 22,
        ["sublevel"] = 1,
      },
      [9] = {
        ["x"] = 370,
        ["y"] = -171.9,
        ["g"] = 22,
        ["sublevel"] = 1,
      },
      [10] = {
        ["x"] = 365.9,
        ["y"] = -148.2,
        ["g"] = 22,
        ["sublevel"] = 1,
      },
      [11] = {
        ["x"] = 369.8,
        ["y"] = -177.5,
        ["g"] = 22,
        ["sublevel"] = 1,
      },
      [12] = {
        ["x"] = 365.7,
        ["y"] = -174.7,
        ["g"] = 22,
        ["sublevel"] = 1,
      },
      [13] = {
        ["x"] = 363.1,
        ["y"] = -144.5,
        ["g"] = 22,
        ["sublevel"] = 1,
      },
      [14] = {
        ["x"] = 342.6,
        ["y"] = -130,
        ["g"] = 21,
        ["sublevel"] = 1,
      },
      [15] = {
        ["x"] = 337.7,
        ["y"] = -131.4,
        ["g"] = 21,
        ["sublevel"] = 1,
      },
      [16] = {
        ["x"] = 329.2,
        ["y"] = -119.6,
        ["g"] = 21,
        ["sublevel"] = 1,
      },
      [17] = {
        ["x"] = 349.8,
        ["y"] = -138.6,
        ["g"] = 21,
        ["sublevel"] = 1,
      },
      [18] = {
        ["x"] = 338.2,
        ["y"] = -127.5,
        ["g"] = 21,
        ["sublevel"] = 1,
      },
      [19] = {
        ["x"] = 349,
        ["y"] = -133.7,
        ["g"] = 21,
        ["sublevel"] = 1,
      },
      [20] = {
        ["x"] = 327.9,
        ["y"] = -123.9,
        ["g"] = 21,
        ["sublevel"] = 1,
      },
      [21] = {
        ["x"] = 353.8,
        ["y"] = -136,
        ["g"] = 21,
        ["sublevel"] = 1,
      },
      [22] = {
        ["x"] = 324,
        ["y"] = -120.3,
        ["g"] = 21,
        ["sublevel"] = 1,
      },
    },
  },
  [15] = {
    ["name"] = "General Pa\'valak",
    ["id"] = 61485,
    ["count"] = 0,
    ["health"] = 37071644,
    ["scale"] = 1.6,
    ["displayId"] = 43120,
    ["creatureType"] = "Humanoid",
    ["isBoss"] = true,
    ["instanceID"] = 324,
    ["characteristics"] = {
    },
    ["spells"] = {
    },
    ["clones"] = {
      [1] = {
        ["x"] = 454.7,
        ["y"] = -252.6,
        ["sublevel"] = 1,
      },
    },
  },
  [16] = {
    ["name"] = "Sik\'thik Engineer",
    ["id"] = 62632,
    ["count"] = 1,
    ["health"] = 3260256,
    ["scale"] = 1,
    ["displayId"] = 43150,
    ["creatureType"] = "Humanoid",
    ["characteristics"] = {
    },
    ["spells"] = {
    },
    ["clones"] = {
      [1] = {
        ["x"] = 420.7,
        ["y"] = -183.5,
        ["g"] = 26,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 445.2,
        ["y"] = -164.4,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 452.3,
        ["y"] = -138.7,
        ["sublevel"] = 1,
      },
    },
  },
  [17] = {
    ["name"] = "Sik\'thik Builder",
    ["id"] = 62633,
    ["count"] = 1,
    ["health"] = 2037660,
    ["scale"] = 1,
    ["displayId"] = 43149,
    ["creatureType"] = "Humanoid",
    ["characteristics"] = {
    },
    ["spells"] = {
    },
    ["clones"] = {
      [1] = {
        ["x"] = 418.7,
        ["y"] = -179.5,
        ["g"] = 26,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 424.5,
        ["y"] = -185.3,
        ["g"] = 26,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 428.9,
        ["y"] = -170.5,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 435.6,
        ["y"] = -156.2,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 452.1,
        ["y"] = -156.2,
        ["g"] = 27,
        ["sublevel"] = 1,
      },
      [6] = {
        ["x"] = 454.2,
        ["y"] = -158.8,
        ["g"] = 27,
        ["sublevel"] = 1,
      },
      [7] = {
        ["x"] = 442.1,
        ["y"] = -151.2,
        ["sublevel"] = 1,
      },
      [8] = {
        ["x"] = 462.8,
        ["y"] = -152.6,
        ["sublevel"] = 1,
      },
      [9] = {
        ["x"] = 463.2,
        ["y"] = -136.4,
        ["sublevel"] = 1,
      },
      [10] = {
        ["x"] = 469.6,
        ["y"] = -140.3,
        ["g"] = 28,
        ["sublevel"] = 1,
      },
      [11] = {
        ["x"] = 470.9,
        ["y"] = -143.1,
        ["g"] = 28,
        ["sublevel"] = 1,
      },
    },
  },
  [18] = {
    ["name"] = "Wing Leader Ner\'onok",
    ["id"] = 62205,
    ["count"] = 0,
    ["health"] = 23987536,
    ["scale"] = 1.6,
    ["displayId"] = 43151,
    ["creatureType"] = "Humanoid",
    ["isBoss"] = true,
    ["instanceID"] = 324,
    ["characteristics"] = {
    },
    ["spells"] = {
    },
    ["clones"] = {
      [1] = {
        ["x"] = 484,
        ["y"] = -115.4,
        ["sublevel"] = 1,
      },
    },
  },
};
