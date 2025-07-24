local MDT = MDT
local L = MDT.L

local dungeonIndex = 134
MDT.dungeonList[dungeonIndex] = L["Scholomance"]
MDT.mapInfo[dungeonIndex] = {
  iconId = 135974,
  shortName = L["scholomanceShortName"],
  englishName = "Scholomance",
  mapID = 1007,
};

local zones = { 476, 477, 478, 479 }
for _, zone in ipairs(zones) do
  MDT.zoneIdToDungeonIdx[zone] = dungeonIndex
end

MDT.dungeonMaps[dungeonIndex] = {
  [0] = "Scholomance",
  [1] = "Scholomance1_",
  [2] = "Scholomance2_",
  [3] = "Scholomance3_",
  [4] = "Scholomance4_",
}
MDT.dungeonSubLevels[dungeonIndex] = {
  [1] = L["The Reliquary"],
  [2] = L["Chamber of Summoning"],
  [3] = L["The Upper Study"],
  [4] = L["Headmaster\'s Study"],
}

MDT.dungeonTotalCount[dungeonIndex] = { normal = 35, teeming = 1000, teemingEnabled = true }

MDT.mapPOIs[dungeonIndex] = {};

MDT.dungeonEnemies[dungeonIndex] = {
  [1] = {
    ["name"] = "Risen Guard",
    ["id"] = 58822,
    ["count"] = 1,
    ["health"] = 5059104,
    ["scale"] = 1,
    ["displayId"] = 40707,
    ["creatureType"] = "Undead",
    ["characteristics"] = {
    },
    ["spells"] = {
    },
    ["clones"] = {
      [1] = {
        ["x"] = 348.2,
        ["y"] = -355.7,
        ["g"] = 1,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 348.6,
        ["y"] = -321.7,
        ["g"] = 1,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 481.4,
        ["y"] = -268.3,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 506.5,
        ["y"] = -417.1,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 718.8,
        ["y"] = -188.9,
        ["sublevel"] = 1,
      },
    },
  },
  [2] = {
    ["name"] = "Scholomance Neophyte",
    ["id"] = 58823,
    ["count"] = 1,
    ["health"] = 1630682,
    ["scale"] = 1,
    ["displayId"] = 40307,
    ["creatureType"] = "Humanoid",
    ["characteristics"] = {
    },
    ["spells"] = {
    },
    ["clones"] = {
      [1] = {
        ["x"] = 454.6,
        ["y"] = -221.2,
        ["g"] = 5,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 483.3,
        ["y"] = -230.5,
        ["g"] = 5,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 577.2,
        ["y"] = -254.9,
        ["g"] = 4,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 529.3,
        ["y"] = -230.1,
        ["g"] = 4,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 421.7,
        ["y"] = -471.7,
        ["g"] = 3,
        ["sublevel"] = 1,
      },
      [6] = {
        ["x"] = 449.7,
        ["y"] = -472.6,
        ["g"] = 3,
        ["sublevel"] = 1,
      },
      [7] = {
        ["x"] = 457.6,
        ["y"] = -450.7,
        ["g"] = 3,
        ["sublevel"] = 1,
      },
      [8] = {
        ["x"] = 566.5,
        ["y"] = -439.4,
        ["g"] = 2,
        ["sublevel"] = 1,
      },
      [9] = {
        ["x"] = 501.4,
        ["y"] = -381.2,
        ["sublevel"] = 1,
      },
      [10] = {
        ["x"] = 500.4,
        ["y"] = -297.7,
        ["sublevel"] = 1,
      },
      [11] = {
        ["x"] = 636.9,
        ["y"] = -323.5,
        ["sublevel"] = 1,
      },
      [12] = {
        ["x"] = 616,
        ["y"] = -338.9,
        ["sublevel"] = 1,
      },
      [13] = {
        ["x"] = 629.5,
        ["y"] = -406.8,
        ["sublevel"] = 1,
      },
    },
  },
  [3] = {
    ["name"] = "Scholomance Acolyte",
    ["id"] = 58757,
    ["count"] = 1,
    ["health"] = 2281776,
    ["scale"] = 1,
    ["displayId"] = 40271,
    ["creatureType"] = "Humanoid",
    ["characteristics"] = {
    },
    ["spells"] = {
    },
    ["clones"] = {
      [1] = {
        ["x"] = 439,
        ["y"] = -204.3,
        ["g"] = 5,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 468.8,
        ["y"] = -199.4,
        ["g"] = 5,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 482.1,
        ["y"] = -214.9,
        ["g"] = 5,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 553.3,
        ["y"] = -235.9,
        ["g"] = 4,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 581.4,
        ["y"] = -245.6,
        ["g"] = 4,
        ["sublevel"] = 1,
      },
      [6] = {
        ["x"] = 488.9,
        ["y"] = -454.1,
        ["g"] = 3,
        ["sublevel"] = 1,
      },
      [7] = {
        ["x"] = 497.7,
        ["y"] = -471.5,
        ["g"] = 3,
        ["sublevel"] = 1,
      },
      [8] = {
        ["x"] = 551.3,
        ["y"] = -434.8,
        ["g"] = 2,
        ["sublevel"] = 1,
      },
      [9] = {
        ["x"] = 579.3,
        ["y"] = -439.6,
        ["g"] = 2,
        ["sublevel"] = 1,
      },
      [10] = {
        ["x"] = 463.5,
        ["y"] = -337.5,
        ["sublevel"] = 1,
      },
      [11] = {
        ["x"] = 615.5,
        ["y"] = -362.7,
        ["sublevel"] = 1,
      },
      [12] = {
        ["x"] = 611.8,
        ["y"] = -415.3,
        ["sublevel"] = 1,
      },
    },
  },
  [4] = {
    ["name"] = "Instructor Chillheart",
    ["id"] = 58633,
    ["count"] = 0,
    ["health"] = 21806812,
    ["scale"] = 1.6,
    ["displayId"] = 40301,
    ["creatureType"] = "Undead",
    ["isBoss"] = true,
    ["instanceID"] = 246,
    ["characteristics"] = {
    },
    ["spells"] = {
    },
    ["clones"] = {
      [1] = {
        ["x"] = 551.8,
        ["y"] = -338.8,
        ["sublevel"] = 1,
      },
    },
  },
  [5] = {
    ["name"] = "Candlestick Mage",
    ["id"] = 59467,
    ["count"] = 1,
    ["health"] = 3056490,
    ["scale"] = 1,
    ["displayId"] = 40824,
    ["creatureType"] = "Humanoid",
    ["characteristics"] = {
    },
    ["spells"] = {
    },
    ["clones"] = {
      [1] = {
        ["x"] = 597.6,
        ["y"] = -126.6,
        ["g"] = 15,
        ["sublevel"] = 2,
      },
      [2] = {
        ["x"] = 597.1,
        ["y"] = -102,
        ["g"] = 15,
        ["sublevel"] = 2,
      },
      [3] = {
        ["x"] = 547.3,
        ["y"] = -108.4,
        ["g"] = 16,
        ["sublevel"] = 2,
      },
      [4] = {
        ["x"] = 537.6,
        ["y"] = -120,
        ["g"] = 16,
        ["sublevel"] = 2,
      },
      [5] = {
        ["x"] = 537.6,
        ["y"] = -96.4,
        ["g"] = 16,
        ["sublevel"] = 2,
      },
    },
  },
  [6] = {
    ["name"] = "Jandice Barov",
    ["id"] = 59184,
    ["count"] = 0,
    ["health"] = 17445480,
    ["scale"] = 1.6,
    ["displayId"] = 43460,
    ["creatureType"] = "Undead",
    ["isBoss"] = true,
    ["instanceID"] = 246,
    ["characteristics"] = {
    },
    ["spells"] = {
    },
    ["clones"] = {
      [1] = {
        ["x"] = 493.5,
        ["y"] = -102.9,
        ["sublevel"] = 2,
      },
    },
  },
  [7] = {
    ["name"] = "Boneweaver",
    ["id"] = 59193,
    ["count"] = 1,
    ["health"] = 2529552,
    ["scale"] = 1,
    ["displayId"] = 40635,
    ["creatureType"] = "Humanoid",
    ["characteristics"] = {
    },
    ["spells"] = {
    },
    ["clones"] = {
      [1] = {
        ["x"] = 442,
        ["y"] = -108.9,
        ["sublevel"] = 2,
      },
      [2] = {
        ["x"] = 406.1,
        ["y"] = -109,
        ["sublevel"] = 2,
      },
      [3] = {
        ["x"] = 372.1,
        ["y"] = -109.4,
        ["sublevel"] = 2,
      },
      [4] = {
        ["x"] = 442.8,
        ["y"] = -188.1,
        ["sublevel"] = 2,
      },
      [5] = {
        ["x"] = 405.7,
        ["y"] = -188.4,
        ["sublevel"] = 2,
      },
      [6] = {
        ["x"] = 371.3,
        ["y"] = -188,
        ["sublevel"] = 2,
      },
    },
  },
  [8] = {
    ["name"] = "Rattlegore",
    ["id"] = 59153,
    ["count"] = 0,
    ["health"] = 21896850,
    ["scale"] = 1.6,
    ["displayId"] = 31092,
    ["creatureType"] = "Undead",
    ["isBoss"] = true,
    ["instanceID"] = 246,
    ["characteristics"] = {
    },
    ["spells"] = {
    },
    ["clones"] = {
      [1] = {
        ["x"] = 406.3,
        ["y"] = -148.8,
        ["sublevel"] = 2,
      },
    },
  },
  [9] = {
    ["name"] = "Krastinovian Carver",
    ["id"] = 59368,
    ["count"] = 1,
    ["health"] = 3260256,
    ["scale"] = 1,
    ["displayId"] = 40743,
    ["creatureType"] = "Humanoid",
    ["characteristics"] = {
    },
    ["spells"] = {
    },
    ["clones"] = {
      [1] = {
        ["x"] = 287,
        ["y"] = -151.5,
        ["sublevel"] = 2,
      },
      [2] = {
        ["x"] = 328.5,
        ["y"] = -188,
        ["g"] = 6,
        ["sublevel"] = 2,
      },
      [3] = {
        ["x"] = 329.5,
        ["y"] = -177.5,
        ["g"] = 6,
        ["sublevel"] = 2,
      },
      [4] = {
        ["x"] = 289.2,
        ["y"] = -191.8,
        ["sublevel"] = 2,
      },
      [5] = {
        ["x"] = 317.4,
        ["y"] = -222.2,
        ["sublevel"] = 2,
      },
      [6] = {
        ["x"] = 268.5,
        ["y"] = -234.4,
        ["g"] = 8,
        ["sublevel"] = 2,
      },
      [7] = {
        ["x"] = 272.7,
        ["y"] = -238.9,
        ["g"] = 8,
        ["sublevel"] = 2,
      },
      [8] = {
        ["x"] = 263.7,
        ["y"] = -219.3,
        ["sublevel"] = 2,
      },
      [9] = {
        ["x"] = 296.3,
        ["y"] = -257.8,
        ["sublevel"] = 2,
      },
      [10] = {
        ["x"] = 346.5,
        ["y"] = -239.5,
        ["g"] = 7,
        ["sublevel"] = 2,
      },
      [11] = {
        ["x"] = 351.2,
        ["y"] = -235,
        ["g"] = 7,
        ["sublevel"] = 2,
      },
      [12] = {
        ["x"] = 340.9,
        ["y"] = -209.5,
        ["sublevel"] = 2,
      },
      [13] = {
        ["x"] = 283.1,
        ["y"] = -318.7,
        ["sublevel"] = 2,
      },
      [14] = {
        ["x"] = 333.9,
        ["y"] = -318.1,
        ["sublevel"] = 2,
      },
      [15] = {
        ["x"] = 339.2,
        ["y"] = -319,
        ["sublevel"] = 2,
      },
      [16] = {
        ["x"] = 289.9,
        ["y"] = -304.6,
        ["sublevel"] = 2,
      },
    },
  },
  [10] = {
    ["name"] = "Flesh Horror",
    ["id"] = 59359,
    ["count"] = 1,
    ["health"] = 4304308,
    ["scale"] = 1,
    ["stealthDetect"] = true,
    ["displayId"] = 41167,
    ["creatureType"] = "Undead",
    ["characteristics"] = {
    },
    ["spells"] = {
    },
    ["clones"] = {
      [1] = {
        ["x"] = 338.7,
        ["y"] = -258,
        ["sublevel"] = 2,
      },
      [2] = {
        ["x"] = 266.1,
        ["y"] = -293.8,
        ["sublevel"] = 2,
      },
      [3] = {
        ["x"] = 310.3,
        ["y"] = -205.7,
        ["sublevel"] = 2,
      },
    },
  },
  [11] = {
    ["name"] = "Bored Student",
    ["id"] = 59614,
    ["count"] = 1,
    ["health"] = 2445192,
    ["scale"] = 1,
    ["displayId"] = 43884,
    ["creatureType"] = "Humanoid",
    ["characteristics"] = {
    },
    ["spells"] = {
    },
    ["clones"] = {
      [1] = {
        ["x"] = 458.7,
        ["y"] = -401.4,
        ["g"] = 14,
        ["sublevel"] = 2,
      },
      [2] = {
        ["x"] = 446.8,
        ["y"] = -401.5,
        ["g"] = 14,
        ["sublevel"] = 2,
      },
      [3] = {
        ["x"] = 446.7,
        ["y"] = -406.9,
        ["g"] = 14,
        ["sublevel"] = 2,
      },
      [4] = {
        ["x"] = 460.2,
        ["y"] = -407.2,
        ["g"] = 14,
        ["sublevel"] = 2,
      },
      [5] = {
        ["x"] = 453.5,
        ["y"] = -402.3,
        ["g"] = 14,
        ["sublevel"] = 2,
      },
      [6] = {
        ["x"] = 416.1,
        ["y"] = -422.8,
        ["g"] = 13,
        ["sublevel"] = 2,
      },
      [7] = {
        ["x"] = 429,
        ["y"] = -422.2,
        ["g"] = 13,
        ["sublevel"] = 2,
      },
      [8] = {
        ["x"] = 421.7,
        ["y"] = -416.7,
        ["g"] = 13,
        ["sublevel"] = 2,
      },
      [9] = {
        ["x"] = 427.8,
        ["y"] = -416.7,
        ["g"] = 13,
        ["sublevel"] = 2,
      },
      [10] = {
        ["x"] = 416.1,
        ["y"] = -418.2,
        ["g"] = 13,
        ["sublevel"] = 2,
      },
      [11] = {
        ["x"] = 403.4,
        ["y"] = -435.6,
        ["g"] = 12,
        ["sublevel"] = 2,
      },
      [12] = {
        ["x"] = 396.7,
        ["y"] = -429.5,
        ["g"] = 12,
        ["sublevel"] = 2,
      },
      [13] = {
        ["x"] = 402.4,
        ["y"] = -432.2,
        ["g"] = 12,
        ["sublevel"] = 2,
      },
      [14] = {
        ["x"] = 386.8,
        ["y"] = -434.5,
        ["g"] = 12,
        ["sublevel"] = 2,
      },
      [15] = {
        ["x"] = 391,
        ["y"] = -429.7,
        ["g"] = 12,
        ["sublevel"] = 2,
      },
      [16] = {
        ["x"] = 400.5,
        ["y"] = -408.5,
        ["g"] = 11,
        ["sublevel"] = 2,
      },
      [17] = {
        ["x"] = 401.1,
        ["y"] = -402.1,
        ["g"] = 11,
        ["sublevel"] = 2,
      },
      [18] = {
        ["x"] = 387.6,
        ["y"] = -407.7,
        ["g"] = 11,
        ["sublevel"] = 2,
      },
      [19] = {
        ["x"] = 389.7,
        ["y"] = -400.8,
        ["g"] = 11,
        ["sublevel"] = 2,
      },
      [20] = {
        ["x"] = 396.8,
        ["y"] = -402,
        ["g"] = 11,
        ["sublevel"] = 2,
      },
      [21] = {
        ["x"] = 385.8,
        ["y"] = -355.7,
        ["g"] = 10,
        ["sublevel"] = 2,
      },
      [22] = {
        ["x"] = 396.3,
        ["y"] = -351.7,
        ["g"] = 10,
        ["sublevel"] = 2,
      },
      [23] = {
        ["x"] = 403.6,
        ["y"] = -369.2,
        ["g"] = 10,
        ["sublevel"] = 2,
      },
      [24] = {
        ["x"] = 407.8,
        ["y"] = -354.9,
        ["g"] = 10,
        ["sublevel"] = 2,
      },
      [25] = {
        ["x"] = 413.8,
        ["y"] = -369.3,
        ["g"] = 10,
        ["sublevel"] = 2,
      },
      [26] = {
        ["x"] = 421.5,
        ["y"] = -355.3,
        ["g"] = 10,
        ["sublevel"] = 2,
      },
      [27] = {
        ["x"] = 388.7,
        ["y"] = -369.4,
        ["g"] = 10,
        ["sublevel"] = 2,
      },
      [28] = {
        ["x"] = 371.5,
        ["y"] = -368.7,
        ["g"] = 10,
        ["sublevel"] = 2,
      },
    },
  },
  [12] = {
    ["name"] = "Professor Slate",
    ["id"] = 59613,
    ["count"] = 0,
    ["health"] = 5059104,
    ["scale"] = 1,
    ["displayId"] = 43162,
    ["creatureType"] = "Undead",
    ["characteristics"] = {
    },
    ["spells"] = {
    },
    ["clones"] = {
      [1] = {
        ["x"] = 440.8,
        ["y"] = -447.9,
        ["sublevel"] = 2,
      },
    },
  },
  [13] = {
    ["name"] = "Lilian Voss",
    ["id"] = 58722,
    ["count"] = 0,
    ["health"] = 29439246,
    ["scale"] = 1.6,
    ["displayId"] = 40256,
    ["creatureType"] = "Humanoid",
    ["isBoss"] = true,
    ["instanceID"] = 246,
    ["characteristics"] = {
    },
    ["spells"] = {
    },
    ["clones"] = {
      [1] = {
        ["x"] = 435.7,
        ["y"] = -263.8,
        ["sublevel"] = 2,
      },
    },
  },
  [14] = {
    ["name"] = "Darkmaster Gandling",
    ["id"] = 59080,
    ["count"] = 0,
    ["health"] = 28348904,
    ["scale"] = 1.6,
    ["displayId"] = 40322,
    ["creatureType"] = "Humanoid",
    ["isBoss"] = true,
    ["instanceID"] = 246,
    ["characteristics"] = {
    },
    ["spells"] = {
    },
    ["clones"] = {
      [1] = {
        ["x"] = 420.2,
        ["y"] = -188.3,
        ["sublevel"] = 4,
      },
    },
  },
};
