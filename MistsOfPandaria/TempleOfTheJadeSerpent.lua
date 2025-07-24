local MDT = MDT
local L = MDT.L

local dungeonIndex = 138
MDT.dungeonList[dungeonIndex] = L["Temple of the Jade Serpent"]
MDT.mapInfo[dungeonIndex] = {
  iconId = 603529,
  shortName = L["templeOfTheJadeSerpentShortName"],
  englishName = "Temple of the Jade Serpent",
  mapID = 960,
};

local zones = { 429 }
for _, zone in ipairs(zones) do
  MDT.zoneIdToDungeonIdx[zone] = dungeonIndex
end

MDT.dungeonMaps[dungeonIndex] = {
  [0] = "EastTemple",
  [1] = "EastTemple1_",
}
MDT.dungeonSubLevels[dungeonIndex] = {
  [1] = L["Temple of the Jade Serpent"],
}

MDT.dungeonTotalCount[dungeonIndex] = { normal = 45, teeming = 1000, teemingEnabled = true }

MDT.mapPOIs[dungeonIndex] = {};

MDT.dungeonEnemies[dungeonIndex] = {
  [1] = {
    ["name"] = "Wise Mari",
    ["id"] = 56448,
    ["count"] = 0,
    ["health"] = 20248056,
    ["scale"] = 1,
    ["displayId"] = 41125,
    ["creatureType"] = "Humanoid",
    ["level"] = 72,
    ["isBoss"] = true,
    ["encounterID"] = 672,
    ["instanceID"] = 313,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [106055] = {
      },
      [106062] = {
      },
      [121483] = {
      },
      [397785] = {
      },
      [397793] = {
      },
      [397797] = {
      },
      [397801] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 373.6,
        ["y"] = -107.1,
        ["sublevel"] = 1,
      },
    },
  },
  [2] = {
    ["name"] = "Haunting Sha",
    ["id"] = 59555,
    ["count"] = 1,
    ["health"] = 3056311,
    ["scale"] = 1,
    ["displayId"] = 40907,
    ["creatureType"] = "Aberration",
    ["level"] = 70,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Silence"] = true,
      ["Root"] = true,
      ["Fear"] = true,
      ["Disorient"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
    },
    ["spells"] = {
      [114646] = {
      },
      [228318] = {
      },
      [395859] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 176.5,
        ["y"] = -395.7,
        ["g"] = 4,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 177.7,
        ["y"] = -442.7,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 270.9,
        ["y"] = -474.1,
        ["sublevel"] = 1,
      },
    },
  },
  [3] = {
    ["name"] = "Xiang",
    ["id"] = 65317,
    ["count"] = 0,
    ["health"] = 2037660,
    ["scale"] = 1,
    ["displayId"] = 42431,
    ["creatureType"] = "Humanoid",
    ["level"] = 71,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [114803] = {
      },
      [114805] = {
      },
      [228318] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 183.7,
        ["y"] = -398.5,
        ["g"] = 4,
        ["sublevel"] = 1,
      },
    },
  },
  [4] = {
    ["name"] = "Jiang",
    ["id"] = 59547,
    ["count"] = 1,
    ["health"] = 2037660,
    ["scale"] = 1,
    ["displayId"] = 42431,
    ["creatureType"] = "Humanoid",
    ["level"] = 71,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [114803] = {
      },
      [114805] = {
      },
      [228318] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 190.8,
        ["y"] = -400.9,
        ["g"] = 4,
        ["sublevel"] = 1,
      },
    },
  },
  [5] = {
    ["name"] = "Lesser Sha",
    ["id"] = 59598,
    ["count"] = 1,
    ["health"] = 1222596,
    ["scale"] = 1,
    ["displayId"] = 40884,
    ["creatureType"] = "Aberration",
    ["level"] = 70,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Silence"] = true,
      ["Fear"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
    },
    ["spells"] = {
      [228318] = {
      },
      [395869] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 220.7,
        ["y"] = -443.6,
        ["g"] = 5,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 214.1,
        ["y"] = -447.9,
        ["g"] = 5,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 227.2,
        ["y"] = -445.7,
        ["g"] = 5,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 214.1,
        ["y"] = -456.7,
        ["g"] = 5,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 220.7,
        ["y"] = -463.2,
        ["g"] = 5,
        ["sublevel"] = 1,
      },
      [6] = {
        ["x"] = 284.1,
        ["y"] = -452.3,
        ["g"] = 6,
        ["sublevel"] = 1,
      },
      [7] = {
        ["x"] = 290.6,
        ["y"] = -447.9,
        ["g"] = 6,
        ["sublevel"] = 1,
      },
      [8] = {
        ["x"] = 275.3,
        ["y"] = -450.1,
        ["g"] = 6,
        ["sublevel"] = 1,
      },
      [9] = {
        ["x"] = 273.1,
        ["y"] = -441.4,
        ["g"] = 6,
        ["sublevel"] = 1,
      },
      [10] = {
        ["x"] = 278.4,
        ["y"] = -457.8,
        ["g"] = 6,
        ["sublevel"] = 1,
      },
    },
  },
  [6] = {
    ["name"] = "The Talking Fish",
    ["id"] = 59546,
    ["count"] = 1,
    ["health"] = 4890384,
    ["scale"] = 1,
    ["displayId"] = 40855,
    ["creatureType"] = "Beast",
    ["level"] = 70,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [228318] = {
      },
      [395872] = {
      },
      [395878] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 225.1,
        ["y"] = -452.3,
        ["g"] = 5,
        ["sublevel"] = 1,
      },
    },
  },
  [7] = {
    ["name"] = "The Songbird Queen",
    ["id"] = 59553,
    ["count"] = 1,
    ["health"] = 2853892,
    ["scale"] = 1,
    ["displayId"] = 40856,
    ["creatureType"] = "Beast",
    ["level"] = 71,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [228318] = {
      },
      [396001] = {
      },
      [396007] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 281.9,
        ["y"] = -441.4,
        ["g"] = 6,
        ["sublevel"] = 1,
      },
    },
  },
  [8] = {
    ["name"] = "The Crybaby Hozen",
    ["id"] = 59552,
    ["count"] = 1,
    ["health"] = 2037660,
    ["scale"] = 1,
    ["displayId"] = 39483,
    ["creatureType"] = "Humanoid",
    ["level"] = 71,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [228318] = {
      },
      [396010] = {
      },
      [396018] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 279.7,
        ["y"] = -399.9,
        ["g"] = 7,
        ["sublevel"] = 1,
      },
    },
  },
  [9] = {
    ["name"] = "The Golden Beetle",
    ["id"] = 59545,
    ["count"] = 1,
    ["health"] = 3260256,
    ["scale"] = 1,
    ["displayId"] = 31460,
    ["creatureType"] = "Beast",
    ["level"] = 70,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Silence"] = true,
      ["Disorient"] = true,
      ["Imprison"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
    },
    ["spells"] = {
      [228318] = {
      },
      [396019] = {
      },
      [396020] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 266.6,
        ["y"] = -404.2,
        ["g"] = 7,
        ["sublevel"] = 1,
      },
    },
  },
  [10] = {
    ["name"] = "The Nodding Tiger",
    ["id"] = 59544,
    ["count"] = 1,
    ["health"] = 2037660,
    ["scale"] = 1,
    ["displayId"] = 40723,
    ["creatureType"] = "Beast",
    ["level"] = 70,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Silence"] = true,
      ["Imprison"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
    },
    ["spells"] = {
      [228318] = {
      },
      [396073] = {
      },
      [396093] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 270.9,
        ["y"] = -391.1,
        ["g"] = 7,
        ["sublevel"] = 1,
      },
    },
  },
  [11] = {
    ["name"] = "Corrupted Scroll",
    ["id"] = 57080,
    ["count"] = 0,
    ["health"] = 393921,
    ["scale"] = 1,
    ["displayId"] = 42914,
    ["creatureType"] = "Not specified",
    ["level"] = 70,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Slow"] = true,
    },
    ["spells"] = {
    },
    ["clones"] = {
      [1] = {
        ["x"] = 209.8,
        ["y"] = -413,
        ["sublevel"] = 1,
      },
    },
  },
  [12] = {
    ["name"] = "Strife",
    ["id"] = 59051,
    ["count"] = 0,
    ["health"] = 12211815,
    ["scale"] = 1,
    ["displayId"] = 40594,
    ["creatureType"] = "Elemental",
    ["level"] = 72,
    ["isBoss"] = true,
    ["encounterID"] = 664,
    ["instanceID"] = 313,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [113309] = {
      },
      [113315] = {
      },
      [113379] = {
      },
      [114571] = {
      },
      [396150] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 231.6,
        ["y"] = -413,
        ["g"] = 8,
        ["sublevel"] = 1,
      },
    },
  },
  [13] = {
    ["name"] = "Peril",
    ["id"] = 59726,
    ["count"] = 0,
    ["health"] = 12211815,
    ["scale"] = 1,
    ["displayId"] = 40594,
    ["creatureType"] = "Elemental",
    ["level"] = 72,
    ["isBoss"] = true,
    ["encounterID"] = 664,
    ["instanceID"] = 313,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [113309] = {
      },
      [113315] = {
      },
      [113379] = {
      },
      [114571] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 225.1,
        ["y"] = -428.3,
        ["g"] = 8,
        ["sublevel"] = 1,
      },
    },
  },
  [14] = {
    ["name"] = "Liu Flameheart",
    ["id"] = 56732,
    ["count"] = 0,
    ["health"] = 17445480,
    ["scale"] = 1,
    ["displayId"] = 39487,
    ["creatureType"] = "Humanoid",
    ["level"] = 70,
    ["isBoss"] = true,
    ["encounterID"] = 658,
    ["instanceID"] = 313,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [106797] = {
      },
      [106823] = {
      },
      [106841] = {
      },
      [106856] = {
      },
      [106864] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 375.5,
        ["y"] = -285.5,
        ["sublevel"] = 1,
      },
    },
  },
  [15] = {
    ["name"] = "Sha of Doubt",
    ["id"] = 56439,
    ["count"] = 0,
    ["health"] = 19626164,
    ["scale"] = 1,
    ["displayId"] = 45980,
    ["creatureType"] = "Elemental",
    ["level"] = 72,
    ["isBoss"] = true,
    ["encounterID"] = 335,
    ["instanceID"] = 313,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [106113] = {
      },
      [106228] = {
      },
      [106736] = {
      },
      [117665] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 512.4,
        ["y"] = -329.5,
        ["sublevel"] = 1,
      },
    },
  },
  [16] = {
    ["name"] = "Corrupt Living Water",
    ["id"] = 59873,
    ["count"] = 1,
    ["health"] = 3260256,
    ["scale"] = 1,
    ["displayId"] = 43999,
    ["creatureType"] = "Elemental",
    ["level"] = 71,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [228318] = {
      },
      [397878] = {
      },
      [397881] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 300.1,
        ["y"] = -164.6,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 317.7,
        ["y"] = -169.3,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 260.5,
        ["y"] = -147.3,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 278,
        ["y"] = -87.5,
        ["sublevel"] = 1,
      },
    },
  },
  [17] = {
    ["name"] = "Corrupt Droplet",
    ["id"] = 62358,
    ["count"] = 1,
    ["health"] = 611298,
    ["scale"] = 1,
    ["displayId"] = 39442,
    ["creatureType"] = "Elemental",
    ["level"] = 70,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Silence"] = true,
      ["Fear"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
    },
    ["spells"] = {
      [228318] = {
      },
      [395829] = {
      },
      [397886] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 287.5,
        ["y"] = -163.4,
        ["g"] = 1,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 285.9,
        ["y"] = -155.8,
        ["g"] = 1,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 277.3,
        ["y"] = -159.3,
        ["g"] = 1,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 280.1,
        ["y"] = -65.8,
        ["g"] = 3,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 283.3,
        ["y"] = -58.2,
        ["g"] = 3,
        ["sublevel"] = 1,
      },
      [6] = {
        ["x"] = 293.3,
        ["y"] = -60.8,
        ["g"] = 3,
        ["sublevel"] = 1,
      },
      [7] = {
        ["x"] = 290.6,
        ["y"] = -68.9,
        ["g"] = 3,
        ["sublevel"] = 1,
      },
      [8] = {
        ["x"] = 266.4,
        ["y"] = -117.2,
        ["g"] = 2,
        ["sublevel"] = 1,
      },
      [9] = {
        ["x"] = 271.6,
        ["y"] = -113.3,
        ["g"] = 2,
        ["sublevel"] = 1,
      },
      [10] = {
        ["x"] = 273.5,
        ["y"] = -119.4,
        ["g"] = 2,
        ["sublevel"] = 1,
      },
    },
  },
  [18] = {
    ["name"] = "Minion of Doubt",
    ["id"] = 57109,
    ["count"] = 1,
    ["health"] = 4890384,
    ["scale"] = 1,
    ["displayId"] = 41677,
    ["creatureType"] = "Elemental",
    ["level"] = 70,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Silence"] = true,
      ["Root"] = true,
      ["Fear"] = true,
      ["Disorient"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
    },
    ["spells"] = {
      [110125] = {
      },
      [228318] = {
      },
      [397931] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 445.4,
        ["y"] = -310.7,
        ["g"] = 12,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 454,
        ["y"] = -307.5,
        ["g"] = 12,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 450.5,
        ["y"] = -319.3,
        ["g"] = 12,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 404.3,
        ["y"] = -298.3,
        ["g"] = 9,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 384.6,
        ["y"] = -294.5,
        ["sublevel"] = 1,
      },
      [6] = {
        ["x"] = 362.9,
        ["y"] = -274.9,
        ["sublevel"] = 1,
      },
      [7] = {
        ["x"] = 330.7,
        ["y"] = -305.8,
        ["g"] = 10,
        ["sublevel"] = 1,
      },
      [8] = {
        ["x"] = 352.5,
        ["y"] = -247.6,
        ["g"] = 11,
        ["sublevel"] = 1,
      },
    },
  },
  [19] = {
    ["name"] = "Lesser Sha",
    ["id"] = 58319,
    ["count"] = 1,
    ["health"] = 916947,
    ["scale"] = 1,
    ["displayId"] = 40884,
    ["creatureType"] = "Elemental",
    ["level"] = 70,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Silence"] = true,
      ["Fear"] = true,
      ["Disorient"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
    },
    ["spells"] = {
      [228318] = {
      },
      [395869] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 396.7,
        ["y"] = -297.2,
        ["g"] = 9,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 394.5,
        ["y"] = -303.8,
        ["g"] = 9,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 398.1,
        ["y"] = -309.9,
        ["g"] = 9,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 404.2,
        ["y"] = -308.9,
        ["g"] = 9,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 401,
        ["y"] = -303.3,
        ["g"] = 9,
        ["sublevel"] = 1,
      },
      [6] = {
        ["x"] = 335.4,
        ["y"] = -299.6,
        ["g"] = 10,
        ["sublevel"] = 1,
      },
      [7] = {
        ["x"] = 336.8,
        ["y"] = -304.8,
        ["g"] = 10,
        ["sublevel"] = 1,
      },
      [8] = {
        ["x"] = 338,
        ["y"] = -310.5,
        ["g"] = 10,
        ["sublevel"] = 1,
      },
      [9] = {
        ["x"] = 342.1,
        ["y"] = -306.4,
        ["g"] = 10,
        ["sublevel"] = 1,
      },
      [10] = {
        ["x"] = 341.4,
        ["y"] = -300.2,
        ["g"] = 10,
        ["sublevel"] = 1,
      },
      [11] = {
        ["x"] = 348.9,
        ["y"] = -253.7,
        ["g"] = 11,
        ["sublevel"] = 1,
      },
      [12] = {
        ["x"] = 354.7,
        ["y"] = -253.8,
        ["g"] = 11,
        ["sublevel"] = 1,
      },
      [13] = {
        ["x"] = 360.1,
        ["y"] = -251.3,
        ["g"] = 11,
        ["sublevel"] = 1,
      },
      [14] = {
        ["x"] = 359,
        ["y"] = -256.3,
        ["g"] = 11,
        ["sublevel"] = 1,
      },
      [15] = {
        ["x"] = 352,
        ["y"] = -258,
        ["g"] = 11,
        ["sublevel"] = 1,
      },
    },
  },
};
