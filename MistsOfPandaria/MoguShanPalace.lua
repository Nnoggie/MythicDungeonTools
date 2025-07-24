local MDT = MDT
local L = MDT.L

local dungeonIndex = 131
MDT.dungeonList[dungeonIndex] = L["Mogu\'shan Palace"]
MDT.mapInfo[dungeonIndex] = {
  iconId = 603795,
  shortName = L["mogushanPalaceShortName"],
  englishName = "Mogu\'shan Palace",
  mapID = 994,
};

local zones = { 453, 454, 455 }
for _, zone in ipairs(zones) do
  MDT.zoneIdToDungeonIdx[zone] = dungeonIndex
end

MDT.dungeonMaps[dungeonIndex] = {
  [0] = "MogushanPalace",
  [1] = "MogushanPalace1_",
  [2] = "MogushanPalace2_",
  [3] = "MogushanPalace3_",
}
MDT.dungeonSubLevels[dungeonIndex] = {
  [1] = L["The Crimson Assembly Hall"],
  [2] = L["Vaults of Kings Past"],
  [3] = L["Throne of Ancient Conquerors"],
}

MDT.dungeonTotalCount[dungeonIndex] = { normal = 20, teeming = 1000, teemingEnabled = true }

MDT.mapPOIs[dungeonIndex] = {};

MDT.dungeonEnemies[dungeonIndex] = {
  [1] = {
    ["name"] = "Gurthan Iron Maw",
    ["id"] = 61945,
    ["count"] = 1,
    ["health"] = 2040000,
    ["scale"] = 1,
    ["stealthDetect"] = true,
    ["displayId"] = 42065,
    ["creatureType"] = "Beast",
    ["characteristics"] = {
    },
    ["spells"] = {
    },
    ["clones"] = {
      [1] = {
        ["x"] = 298.8,
        ["y"] = -92.4,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 341.5,
        ["y"] = -63.3,
        ["g"] = 3,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 333.5,
        ["y"] = -63.4,
        ["g"] = 3,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 347.4,
        ["y"] = -116.2,
        ["g"] = 1,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 363.9,
        ["y"] = -137.9,
        ["sublevel"] = 1,
      },
      [6] = {
        ["x"] = 399.1,
        ["y"] = -93.3,
        ["sublevel"] = 1,
      },
      [7] = {
        ["x"] = 410.3,
        ["y"] = -117.7,
        ["g"] = 5,
        ["sublevel"] = 1,
      },
      [8] = {
        ["x"] = 441.8,
        ["y"] = -110.2,
        ["sublevel"] = 1,
      },
      [9] = {
        ["x"] = 442,
        ["y"] = -116.4,
        ["sublevel"] = 1,
      },
      [10] = {
        ["x"] = 335.7,
        ["y"] = -214.3,
        ["sublevel"] = 1,
      },
      [11] = {
        ["x"] = 343.3,
        ["y"] = -303,
        ["g"] = 7,
        ["sublevel"] = 1,
      },
      [12] = {
        ["x"] = 332.9,
        ["y"] = -302.9,
        ["g"] = 7,
        ["sublevel"] = 1,
      },
    },
  },
  [2] = {
    ["name"] = "Harthak Stormcaller",
    ["id"] = 61946,
    ["count"] = 1,
    ["health"] = 2040000,
    ["scale"] = 1,
    ["displayId"] = 42062,
    ["creatureType"] = "Humanoid",
    ["characteristics"] = {
    },
    ["spells"] = {
    },
    ["clones"] = {
      [1] = {
        ["x"] = 315.9,
        ["y"] = -86,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 342,
        ["y"] = -75.3,
        ["g"] = 3,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 376.6,
        ["y"] = -87.2,
        ["g"] = 4,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 376.7,
        ["y"] = -132.6,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 412.2,
        ["y"] = -121.6,
        ["g"] = 5,
        ["sublevel"] = 1,
      },
      [6] = {
        ["x"] = 416.2,
        ["y"] = -104.1,
        ["g"] = 5,
        ["sublevel"] = 1,
      },
      [7] = {
        ["x"] = 332.2,
        ["y"] = -145,
        ["g"] = 2,
        ["sublevel"] = 1,
      },
      [8] = {
        ["x"] = 338.7,
        ["y"] = -235.1,
        ["g"] = 6,
        ["sublevel"] = 1,
      },
      [9] = {
        ["x"] = 338.1,
        ["y"] = -314.9,
        ["g"] = 7,
        ["sublevel"] = 1,
      },
    },
  },
  [3] = {
    ["name"] = "Kargesh Ribcrusher",
    ["id"] = 61947,
    ["count"] = 1,
    ["health"] = 2040000,
    ["scale"] = 1,
    ["displayId"] = 42063,
    ["creatureType"] = "Humanoid",
    ["characteristics"] = {
    },
    ["spells"] = {
    },
    ["clones"] = {
      [1] = {
        ["x"] = 333.2,
        ["y"] = -75.2,
        ["g"] = 3,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 367.1,
        ["y"] = -95.6,
        ["g"] = 4,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 355.5,
        ["y"] = -90.1,
        ["g"] = 4,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 370.4,
        ["y"] = -100.3,
        ["g"] = 4,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 347.3,
        ["y"] = -108.3,
        ["g"] = 1,
        ["sublevel"] = 1,
      },
      [6] = {
        ["x"] = 419.8,
        ["y"] = -121.6,
        ["g"] = 5,
        ["sublevel"] = 1,
      },
      [7] = {
        ["x"] = 409.3,
        ["y"] = -105.8,
        ["g"] = 5,
        ["sublevel"] = 1,
      },
      [8] = {
        ["x"] = 343.8,
        ["y"] = -144.3,
        ["g"] = 2,
        ["sublevel"] = 1,
      },
      [9] = {
        ["x"] = 327.8,
        ["y"] = -232.2,
        ["g"] = 6,
        ["sublevel"] = 1,
      },
      [10] = {
        ["x"] = 346.7,
        ["y"] = -314.1,
        ["g"] = 7,
        ["sublevel"] = 1,
      },
      [11] = {
        ["x"] = 329.8,
        ["y"] = -313.5,
        ["g"] = 7,
        ["sublevel"] = 1,
      },
      [12] = {
        ["x"] = 349.5,
        ["y"] = -232.6,
        ["g"] = 6,
        ["sublevel"] = 1,
      },
    },
  },
  [4] = {
    ["name"] = "Mu\'Shiba",
    ["id"] = 61453,
    ["count"] = 0,
    ["health"] = 1003521,
    ["scale"] = 1,
    ["displayId"] = 42064,
    ["creatureType"] = "Beast",
    ["characteristics"] = {
    },
    ["spells"] = {
    },
    ["clones"] = {
      [1] = {
        ["x"] = 314.6,
        ["y"] = -386.4,
        ["g"] = 8,
        ["sublevel"] = 1,
      },
    },
  },
  [5] = {
    ["name"] = "Glintrok Scout",
    ["id"] = 61399,
    ["count"] = 0,
    ["health"] = 12345,
    ["scale"] = 0.8,
    ["displayId"] = 41923,
    ["creatureType"] = "Humanoid",
    ["characteristics"] = {
    },
    ["spells"] = {
    },
    ["clones"] = {
      [1] = {
        ["x"] = 237.2,
        ["y"] = -231,
        ["sublevel"] = 2,
      },
    },
  },
  [6] = {
    ["name"] = "Glintrok Ironhide",
    ["id"] = 61242,
    ["count"] = 1,
    ["health"] = 5904613,
    ["scale"] = 1,
    ["displayId"] = 41922,
    ["creatureType"] = "Humanoid",
    ["characteristics"] = {
    },
    ["spells"] = {
    },
    ["clones"] = {
      [1] = {
        ["x"] = 240.2,
        ["y"] = -275.8,
        ["g"] = 9,
        ["sublevel"] = 2,
      },
    },
  },
  [7] = {
    ["name"] = "Glintrok Greenhorn",
    ["id"] = 61247,
    ["count"] = 0,
    ["health"] = 12345,
    ["scale"] = 0.8,
    ["displayId"] = 41923,
    ["creatureType"] = "Humanoid",
    ["characteristics"] = {
    },
    ["spells"] = {
    },
    ["clones"] = {
      [1] = {
        ["x"] = 230.9,
        ["y"] = -275.7,
        ["g"] = 9,
        ["sublevel"] = 2,
      },
      [2] = {
        ["x"] = 248.7,
        ["y"] = -275.7,
        ["g"] = 9,
        ["sublevel"] = 2,
      },
    },
  },
  [8] = {
    ["name"] = "Glintrok Skulker",
    ["id"] = 61240,
    ["count"] = 1,
    ["health"] = 5063830,
    ["scale"] = 1,
    ["displayId"] = 41921,
    ["creatureType"] = "Humanoid",
    ["characteristics"] = {
    },
    ["spells"] = {
    },
    ["clones"] = {
      [1] = {
        ["x"] = 230.6,
        ["y"] = -331.6,
        ["g"] = 10,
        ["sublevel"] = 2,
      },
      [2] = {
        ["x"] = 249.9,
        ["y"] = -331.7,
        ["g"] = 10,
        ["sublevel"] = 2,
      },
    },
  },
  [9] = {
    ["name"] = "Glintrok Hexxer",
    ["id"] = 61216,
    ["count"] = 1,
    ["health"] = 3792723,
    ["scale"] = 1,
    ["displayId"] = 41917,
    ["creatureType"] = "Humanoid",
    ["characteristics"] = {
    },
    ["spells"] = {
    },
    ["clones"] = {
      [1] = {
        ["x"] = 306.5,
        ["y"] = -429.4,
        ["g"] = 12,
        ["sublevel"] = 2,
      },
      [2] = {
        ["x"] = 306.5,
        ["y"] = -419.5,
        ["g"] = 12,
        ["sublevel"] = 2,
      },
    },
  },
  [10] = {
    ["name"] = "Gekkan",
    ["id"] = 61243,
    ["count"] = 0,
    ["health"] = 13087248,
    ["scale"] = 1.6,
    ["displayId"] = 41920,
    ["creatureType"] = "Humanoid",
    ["isBoss"] = true,
    ["instanceID"] = 321,
    ["characteristics"] = {
    },
    ["spells"] = {
    },
    ["clones"] = {
      [1] = {
        ["x"] = 336,
        ["y"] = -424,
        ["g"] = 11,
        ["sublevel"] = 2,
      },
    },
  },
  [11] = {
    ["name"] = "Glintrok Ironhide",
    ["id"] = 61337,
    ["count"] = 0,
    ["health"] = 5904613,
    ["scale"] = 1,
    ["displayId"] = 41922,
    ["creatureType"] = "Humanoid",
    ["characteristics"] = {
    },
    ["spells"] = {
    },
    ["clones"] = {
      [1] = {
        ["x"] = 358.8,
        ["y"] = -425,
        ["g"] = 11,
        ["sublevel"] = 2,
      },
    },
  },
  [12] = {
    ["name"] = "Glintrok Hexxer",
    ["id"] = 61340,
    ["count"] = 0,
    ["health"] = 3792723,
    ["scale"] = 1,
    ["displayId"] = 41917,
    ["creatureType"] = "Humanoid",
    ["characteristics"] = {
    },
    ["spells"] = {
    },
    ["clones"] = {
      [1] = {
        ["x"] = 357.9,
        ["y"] = -460.5,
        ["g"] = 11,
        ["sublevel"] = 2,
      },
    },
  },
  [13] = {
    ["name"] = "Glintrok Oracle",
    ["id"] = 61339,
    ["count"] = 0,
    ["health"] = 3794328,
    ["scale"] = 1,
    ["displayId"] = 41919,
    ["creatureType"] = "Humanoid",
    ["characteristics"] = {
    },
    ["spells"] = {
    },
    ["clones"] = {
      [1] = {
        ["x"] = 360.2,
        ["y"] = -387.8,
        ["g"] = 11,
        ["sublevel"] = 2,
      },
    },
  },
  [14] = {
    ["name"] = "Glintrok Skulker",
    ["id"] = 61338,
    ["count"] = 0,
    ["health"] = 5063830,
    ["scale"] = 1,
    ["displayId"] = 41921,
    ["creatureType"] = "Humanoid",
    ["characteristics"] = {
    },
    ["spells"] = {
    },
    ["clones"] = {
      [1] = {
        ["x"] = 340,
        ["y"] = -410,
        ["g"] = 11,
        ["sublevel"] = 2,
      },
    },
  },
  [15] = {
    ["name"] = "Glintrok Oracle",
    ["id"] = 61239,
    ["count"] = 1,
    ["health"] = 3794328,
    ["scale"] = 1,
    ["displayId"] = 41919,
    ["creatureType"] = "Humanoid",
    ["characteristics"] = {
    },
    ["spells"] = {
    },
    ["clones"] = {
      [1] = {
        ["x"] = 471.2,
        ["y"] = -416.2,
        ["g"] = 13,
        ["sublevel"] = 2,
      },
      [2] = {
        ["x"] = 471.5,
        ["y"] = -431.5,
        ["g"] = 13,
        ["sublevel"] = 2,
      },
    },
  },
  [16] = {
    ["name"] = "Harthak Flameseeker",
    ["id"] = 61392,
    ["count"] = 1,
    ["health"] = 2450000,
    ["scale"] = 1,
    ["displayId"] = 41984,
    ["creatureType"] = "Humanoid",
    ["characteristics"] = {
    },
    ["spells"] = {
    },
    ["clones"] = {
      [1] = {
        ["x"] = 372.1,
        ["y"] = -166.8,
        ["g"] = 14,
        ["sublevel"] = 3,
      },
      [2] = {
        ["x"] = 381.3,
        ["y"] = -174.2,
        ["g"] = 14,
        ["sublevel"] = 3,
      },
      [3] = {
        ["x"] = 329.9,
        ["y"] = -102.5,
        ["g"] = 15,
        ["sublevel"] = 3,
      },
      [4] = {
        ["x"] = 329.8,
        ["y"] = -91.6,
        ["g"] = 15,
        ["sublevel"] = 3,
      },
      [5] = {
        ["x"] = 421.8,
        ["y"] = -253.3,
        ["g"] = 20,
        ["sublevel"] = 3,
      },
      [6] = {
        ["x"] = 422.2,
        ["y"] = -265.5,
        ["g"] = 20,
        ["sublevel"] = 3,
      },
      [7] = {
        ["x"] = 259.7,
        ["y"] = -252.7,
        ["g"] = 16,
        ["sublevel"] = 3,
      },
      [8] = {
        ["x"] = 259,
        ["y"] = -267.4,
        ["g"] = 16,
        ["sublevel"] = 3,
      },
      [9] = {
        ["x"] = 348.4,
        ["y"] = -368.5,
        ["g"] = 18,
        ["sublevel"] = 3,
      },
    },
  },
  [17] = {
    ["name"] = "Gurthan Swiftblade",
    ["id"] = 65402,
    ["count"] = 1,
    ["health"] = 2450000,
    ["scale"] = 1,
    ["displayId"] = 42061,
    ["creatureType"] = "Humanoid",
    ["characteristics"] = {
    },
    ["spells"] = {
    },
    ["clones"] = {
      [1] = {
        ["x"] = 372.4,
        ["y"] = -174.2,
        ["g"] = 14,
        ["sublevel"] = 3,
      },
      [2] = {
        ["x"] = 381.4,
        ["y"] = -166.5,
        ["g"] = 14,
        ["sublevel"] = 3,
      },
      [3] = {
        ["x"] = 431.3,
        ["y"] = -259.4,
        ["g"] = 20,
        ["sublevel"] = 3,
      },
      [4] = {
        ["x"] = 252.5,
        ["y"] = -260.2,
        ["g"] = 16,
        ["sublevel"] = 3,
      },
      [5] = {
        ["x"] = 349,
        ["y"] = -377.7,
        ["g"] = 18,
        ["sublevel"] = 3,
      },
      [6] = {
        ["x"] = 331,
        ["y"] = -377.5,
        ["g"] = 18,
        ["sublevel"] = 3,
      },
    },
  },
  [18] = {
    ["name"] = "Kargesh Highguard",
    ["id"] = 61389,
    ["count"] = 1,
    ["health"] = 3260000,
    ["scale"] = 1,
    ["displayId"] = 41982,
    ["creatureType"] = "Humanoid",
    ["characteristics"] = {
    },
    ["spells"] = {
    },
    ["clones"] = {
      [1] = {
        ["x"] = 335.2,
        ["y"] = -97.4,
        ["g"] = 15,
        ["sublevel"] = 3,
      },
      [2] = {
        ["x"] = 349.4,
        ["y"] = -277.3,
        ["g"] = 17,
        ["sublevel"] = 3,
      },
      [3] = {
        ["x"] = 329.7,
        ["y"] = -276.9,
        ["g"] = 17,
        ["sublevel"] = 3,
      },
      [4] = {
        ["x"] = 436.2,
        ["y"] = -246.5,
        ["g"] = 20,
        ["sublevel"] = 3,
      },
      [5] = {
        ["x"] = 254.7,
        ["y"] = -249,
        ["g"] = 16,
        ["sublevel"] = 3,
      },
      [6] = {
        ["x"] = 340,
        ["y"] = -377.6,
        ["g"] = 18,
        ["sublevel"] = 3,
      },
    },
  },
  [19] = {
    ["name"] = "Quilen Guardian",
    ["id"] = 61387,
    ["count"] = 1,
    ["health"] = 3250000,
    ["scale"] = 1,
    ["displayId"] = 41233,
    ["creatureType"] = "Beast",
    ["characteristics"] = {
    },
    ["spells"] = {
    },
    ["clones"] = {
      [1] = {
        ["x"] = 330.7,
        ["y"] = -447.2,
        ["g"] = 19,
        ["sublevel"] = 3,
      },
      [2] = {
        ["x"] = 348.2,
        ["y"] = -447.2,
        ["g"] = 19,
        ["sublevel"] = 3,
      },
      [3] = {
        ["x"] = 326.6,
        ["y"] = -457.9,
        ["g"] = 19,
        ["sublevel"] = 3,
      },
      [4] = {
        ["x"] = 351.6,
        ["y"] = -458,
        ["g"] = 19,
        ["sublevel"] = 3,
      },
    },
  },
  [20] = {
    ["name"] = "Xin the Weaponmaster",
    ["id"] = 61398,
    ["count"] = 0,
    ["health"] = 21818182,
    ["scale"] = 1.6,
    ["displayId"] = 41987,
    ["creatureType"] = "Humanoid",
    ["isBoss"] = true,
    ["instanceID"] = 321,
    ["characteristics"] = {
    },
    ["spells"] = {
    },
    ["clones"] = {
      [1] = {
        ["x"] = 339.4,
        ["y"] = -478.6,
        ["sublevel"] = 3,
      },
    },
  },
  [21] = {
    ["name"] = "Haiyan the Unstoppable",
    ["id"] = 61445,
    ["count"] = 0,
    ["health"] = 10035211,
    ["scale"] = 1.6,
    ["displayId"] = 42060,
    ["creatureType"] = "Humanoid",
    ["isBoss"] = true,
    ["instanceID"] = 321,
    ["characteristics"] = {
    },
    ["spells"] = {
    },
    ["clones"] = {
      [1] = {
        ["x"] = 359.5,
        ["y"] = -393,
        ["g"] = 8,
        ["sublevel"] = 1,
      },
    },
    ["healthPercentage"] = 98,
  },
  [22] = {
    ["name"] = "Ming the Cunning",
    ["id"] = 61444,
    ["count"] = 0,
    ["health"] = 10035211,
    ["scale"] = 1.6,
    ["displayId"] = 42059,
    ["creatureType"] = "Humanoid",
    ["isBoss"] = true,
    ["instanceID"] = 321,
    ["characteristics"] = {
    },
    ["spells"] = {
    },
    ["clones"] = {
      [1] = {
        ["x"] = 339.7,
        ["y"] = -427.4,
        ["g"] = 8,
        ["sublevel"] = 1,
      },
    },
    ["healthPercentage"] = 92,
  },
  [23] = {
    ["name"] = "Kuai the Brute",
    ["id"] = 61442,
    ["count"] = 0,
    ["health"] = 10035211,
    ["scale"] = 1.6,
    ["displayId"] = 42058,
    ["creatureType"] = "Humanoid",
    ["isBoss"] = true,
    ["instanceID"] = 321,
    ["characteristics"] = {
    },
    ["spells"] = {
    },
    ["clones"] = {
      [1] = {
        ["x"] = 315,
        ["y"] = -397.8,
        ["g"] = 8,
        ["sublevel"] = 1,
      },
    },
    ["healthPercentage"] = 92,
  },
};
