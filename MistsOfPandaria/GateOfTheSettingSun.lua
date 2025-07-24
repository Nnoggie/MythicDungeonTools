local MDT = MDT
local L = MDT.L

local dungeonIndex = 130
MDT.dungeonList[dungeonIndex] = L["Gate of the Setting Sun"]
MDT.mapInfo[dungeonIndex] = {
  iconId = 603962,
  shortName = L["gateOfTheSettingSunShortName"],
  englishName = "Gate of the Setting Sun",
  mapID = 962,
};

local zones = { 437, 438 }
for _, zone in ipairs(zones) do
  MDT.zoneIdToDungeonIdx[zone] = dungeonIndex
end

MDT.dungeonMaps[dungeonIndex] = {
  [0] = "TheGreatWall",
  [1] = "TheGreatWall1_",
  [2] = "TheGreatWall2_",
}
MDT.dungeonSubLevels[dungeonIndex] = {
  [1] = L["Gate of the Setting Sun"],
  [2] = L["Gate Watch Tower"],
}

MDT.dungeonTotalCount[dungeonIndex] = { normal = 25, teeming = 1000, teemingEnabled = true }

MDT.mapPOIs[dungeonIndex] = {};

MDT.dungeonEnemies[dungeonIndex] = {
  [1] = {
    ["name"] = "Krik\'thik Infiltrator",
    ["id"] = 56890,
    ["count"] = 1,
    ["health"] = 2445000,
    ["scale"] = 1,
    ["displayId"] = 43117,
    ["creatureType"] = "Humanoid",
    ["characteristics"] = {
    },
    ["spells"] = {
    },
    ["clones"] = {
      [1] = {
        ["x"] = 493.8,
        ["y"] = -491.2,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 458.3,
        ["y"] = -492.4,
        ["g"] = 2,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 459.4,
        ["y"] = -487.7,
        ["g"] = 2,
        ["sublevel"] = 1,
      },
    },
  },
  [2] = {
    ["name"] = "Krik\'thik Demolisher",
    ["id"] = 56875,
    ["count"] = 1,
    ["health"] = 3260000,
    ["scale"] = 1,
    ["displayId"] = 43113,
    ["creatureType"] = "Humanoid",
    ["characteristics"] = {
    },
    ["spells"] = {
    },
    ["clones"] = {
      [1] = {
        ["x"] = 477.4,
        ["y"] = -487.9,
        ["g"] = 1,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 475.4,
        ["y"] = -495.7,
        ["g"] = 1,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 427.6,
        ["y"] = -492.5,
        ["g"] = 3,
        ["sublevel"] = 1,
      },
    },
  },
  [3] = {
    ["name"] = "Krik\'thik Sapper",
    ["id"] = 56876,
    ["count"] = 1,
    ["health"] = 2445000,
    ["scale"] = 1,
    ["displayId"] = 43114,
    ["creatureType"] = "Humanoid",
    ["characteristics"] = {
    },
    ["spells"] = {
    },
    ["clones"] = {
      [1] = {
        ["x"] = 478,
        ["y"] = -491.4,
        ["g"] = 1,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 426.1,
        ["y"] = -489.5,
        ["g"] = 3,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 425.7,
        ["y"] = -495.6,
        ["g"] = 3,
        ["sublevel"] = 1,
      },
    },
  },
  [4] = {
    ["name"] = "Saboteur Kip\'tilak",
    ["id"] = 56906,
    ["count"] = 0,
    ["health"] = 15264000,
    ["scale"] = 1.6,
    ["displayId"] = 43122,
    ["creatureType"] = "Humanoid",
    ["isBoss"] = true,
    ["instanceID"] = 303,
    ["characteristics"] = {
    },
    ["spells"] = {
    },
    ["clones"] = {
      [1] = {
        ["x"] = 387.6,
        ["y"] = -492,
        ["sublevel"] = 1,
      },
    },
  },
  [5] = {
    ["name"] = "Krik\'thik Infiltrator",
    ["id"] = 58108,
    ["count"] = 1,
    ["health"] = 2445000,
    ["scale"] = 1,
    ["displayId"] = 43130,
    ["creatureType"] = "Humanoid",
    ["characteristics"] = {
    },
    ["spells"] = {
    },
    ["clones"] = {
      [1] = {
        ["x"] = 373.2,
        ["y"] = -415.8,
        ["g"] = 4,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 373.2,
        ["y"] = -421.2,
        ["g"] = 4,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 373.2,
        ["y"] = -426.6,
        ["g"] = 4,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 350.2,
        ["y"] = -293.1,
        ["g"] = 5,
        ["sublevel"] = 1,
      },
    },
  },
  [6] = {
    ["name"] = "Krik\'thik Wind Shaper",
    ["id"] = 59801,
    ["count"] = 1,
    ["health"] = 2037000,
    ["scale"] = 1,
    ["displayId"] = 43914,
    ["creatureType"] = "Humanoid",
    ["characteristics"] = {
    },
    ["spells"] = {
    },
    ["clones"] = {
      [1] = {
        ["x"] = 378.6,
        ["y"] = -421.6,
        ["g"] = 4,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 343.7,
        ["y"] = -298.5,
        ["g"] = 5,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 391.4,
        ["y"] = -230.8,
        ["g"] = 6,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 395.4,
        ["y"] = -102.5,
        ["g"] = 8,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 394.1,
        ["y"] = -121.9,
        ["g"] = 7,
        ["sublevel"] = 1,
      },
      [6] = {
        ["x"] = 347.2,
        ["y"] = -298.9,
        ["g"] = 5,
        ["sublevel"] = 1,
      },
    },
  },
  [7] = {
    ["name"] = "Krik\'thik Rager",
    ["id"] = 59800,
    ["count"] = 1,
    ["health"] = 2445000,
    ["scale"] = 1,
    ["displayId"] = 43129,
    ["creatureType"] = "Humanoid",
    ["characteristics"] = {
    },
    ["spells"] = {
    },
    ["clones"] = {
      [1] = {
        ["x"] = 341.4,
        ["y"] = -289.5,
        ["g"] = 5,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 387.1,
        ["y"] = -234.9,
        ["g"] = 6,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 382,
        ["y"] = -230.7,
        ["g"] = 6,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 389.5,
        ["y"] = -99,
        ["g"] = 8,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 382.6,
        ["y"] = -101.2,
        ["g"] = 8,
        ["sublevel"] = 1,
      },
      [6] = {
        ["x"] = 388.4,
        ["y"] = -118.5,
        ["g"] = 7,
        ["sublevel"] = 1,
      },
      [7] = {
        ["x"] = 381.8,
        ["y"] = -120.7,
        ["g"] = 7,
        ["sublevel"] = 1,
      },
      [8] = {
        ["x"] = 347.3,
        ["y"] = -289.4,
        ["g"] = 5,
        ["sublevel"] = 1,
      },
    },
  },
  [8] = {
    ["name"] = "Striker Ga\'dok",
    ["id"] = 56589,
    ["count"] = 0,
    ["health"] = 12211000,
    ["scale"] = 1.6,
    ["displayId"] = 43275,
    ["creatureType"] = "Humanoid",
    ["isBoss"] = true,
    ["instanceID"] = 303,
    ["characteristics"] = {
    },
    ["spells"] = {
    },
    ["clones"] = {
      [1] = {
        ["x"] = 387.6,
        ["y"] = -182.7,
        ["sublevel"] = 1,
      },
    },
  },
  [9] = {
    ["name"] = "Raigonn",
    ["id"] = 56877,
    ["count"] = 0,
    ["health"] = 15591500,
    ["scale"] = 1.6,
    ["displayId"] = 39519,
    ["creatureType"] = "Beast",
    ["isBoss"] = true,
    ["instanceID"] = 303,
    ["characteristics"] = {
    },
    ["spells"] = {
    },
    ["clones"] = {
      [1] = {
        ["x"] = 371,
        ["y"] = -338.9,
        ["sublevel"] = 1,
      },
    },
  },
  [10] = {
    ["name"] = "Commander Ri\'mok",
    ["id"] = 56636,
    ["count"] = 0,
    ["health"] = 12211000,
    ["scale"] = 1.6,
    ["displayId"] = 43286,
    ["creatureType"] = "Humanoid",
    ["isBoss"] = true,
    ["instanceID"] = 303,
    ["characteristics"] = {
    },
    ["spells"] = {
    },
    ["clones"] = {
      [1] = {
        ["x"] = 387.7,
        ["y"] = -141.2,
        ["sublevel"] = 1,
      },
    },
  },
};
