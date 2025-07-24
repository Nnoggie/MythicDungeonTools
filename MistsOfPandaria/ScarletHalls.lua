local MDT = MDT
local L = MDT.L

local dungeonIndex = 132
MDT.dungeonList[dungeonIndex] = L["Scarlet Halls"]
MDT.mapInfo[dungeonIndex] = {
  iconId = 133154,
  shortName = L["scarletHallsShortName"],
  englishName = "Scarlet Halls",
  mapID = 1001,
};

local zones = { 431, 432 }
for _, zone in ipairs(zones) do
  MDT.zoneIdToDungeonIdx[zone] = dungeonIndex
end

MDT.dungeonMaps[dungeonIndex] = {
  [0] = "ScarletHalls",
  [1] = "ScarletHalls1_",
  [2] = "ScarletHalls2_",
}
MDT.dungeonSubLevels[dungeonIndex] = {
  [1] = L["Training Grounds"],
  [2] = L["Athenaeum"],
}

MDT.dungeonTotalCount[dungeonIndex] = { normal = 50, teeming = 1000, teemingEnabled = true }

MDT.mapPOIs[dungeonIndex] = {};

MDT.dungeonEnemies[dungeonIndex] = {
  [1] = {
    ["name"] = "Angry Hound",
    ["id"] = 58674,
    ["count"] = 0,
    ["health"] = 2447712,
    ["scale"] = 1,
    ["displayId"] = 40300,
    ["creatureType"] = "Beast",
    ["characteristics"] = {
    },
    ["spells"] = {
    },
    ["clones"] = {
      [1] = {
        ["x"] = 319.2,
        ["y"] = -468.6,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 382.2,
        ["y"] = -478,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 370.4,
        ["y"] = -422.9,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 452.8,
        ["y"] = -271.1,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 370.4,
        ["y"] = -269.3,
        ["sublevel"] = 1,
      },
      [6] = {
        ["x"] = 416.9,
        ["y"] = -122.9,
        ["sublevel"] = 1,
      },
      [7] = {
        ["x"] = 502.5,
        ["y"] = -205.7,
        ["sublevel"] = 1,
      },
      [8] = {
        ["x"] = 496.8,
        ["y"] = -121.3,
        ["sublevel"] = 1,
      },
    },
  },
  [2] = {
    ["name"] = "Vigilant Watchman",
    ["id"] = 58898,
    ["count"] = 1,
    ["health"] = 3200000,
    ["scale"] = 1,
    ["displayId"] = 43801,
    ["creatureType"] = "Humanoid",
    ["characteristics"] = {
    },
    ["spells"] = {
    },
    ["clones"] = {
      [1] = {
        ["x"] = 348.5,
        ["y"] = -474.1,
        ["g"] = 1,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 388.2,
        ["y"] = -449.1,
        ["g"] = 14,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 370.1,
        ["y"] = -361.7,
        ["g"] = 4,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 451.5,
        ["y"] = -298.2,
        ["g"] = 3,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 453,
        ["y"] = -204.4,
        ["g"] = 5,
        ["sublevel"] = 1,
      },
    },
  },
  [3] = {
    ["name"] = "Starving Hound",
    ["id"] = 58876,
    ["count"] = 0,
    ["health"] = 1030753,
    ["scale"] = 1,
    ["displayId"] = 30212,
    ["creatureType"] = "Beast",
    ["characteristics"] = {
    },
    ["spells"] = {
    },
    ["clones"] = {
      [1] = {
        ["x"] = 351.1,
        ["y"] = -471.6,
        ["g"] = 1,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 351.1,
        ["y"] = -476.7,
        ["g"] = 1,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 353.6,
        ["y"] = -469,
        ["g"] = 1,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 353.6,
        ["y"] = -479.2,
        ["g"] = 1,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 391.4,
        ["y"] = -445.2,
        ["g"] = 14,
        ["sublevel"] = 1,
      },
      [6] = {
        ["x"] = 389.5,
        ["y"] = -447.1,
        ["g"] = 14,
        ["sublevel"] = 1,
      },
      [7] = {
        ["x"] = 391.4,
        ["y"] = -452.9,
        ["g"] = 14,
        ["sublevel"] = 1,
      },
      [8] = {
        ["x"] = 389.4,
        ["y"] = -451,
        ["g"] = 14,
        ["sublevel"] = 1,
      },
      [9] = {
        ["x"] = 372,
        ["y"] = -364.5,
        ["g"] = 4,
        ["sublevel"] = 1,
      },
      [10] = {
        ["x"] = 368.2,
        ["y"] = -364.4,
        ["g"] = 4,
        ["sublevel"] = 1,
      },
      [11] = {
        ["x"] = 373.9,
        ["y"] = -366.4,
        ["g"] = 4,
        ["sublevel"] = 1,
      },
      [12] = {
        ["x"] = 366.3,
        ["y"] = -366.4,
        ["g"] = 4,
        ["sublevel"] = 1,
      },
      [13] = {
        ["x"] = 455.4,
        ["y"] = -303.9,
        ["g"] = 3,
        ["sublevel"] = 1,
      },
      [14] = {
        ["x"] = 453.4,
        ["y"] = -300.1,
        ["g"] = 3,
        ["sublevel"] = 1,
      },
      [15] = {
        ["x"] = 449.6,
        ["y"] = -300.1,
        ["g"] = 3,
        ["sublevel"] = 1,
      },
      [16] = {
        ["x"] = 447.7,
        ["y"] = -302,
        ["g"] = 3,
        ["sublevel"] = 1,
      },
      [17] = {
        ["x"] = 454.6,
        ["y"] = -206.3,
        ["g"] = 5,
        ["sublevel"] = 1,
      },
      [18] = {
        ["x"] = 454.6,
        ["y"] = -202.5,
        ["g"] = 5,
        ["sublevel"] = 1,
      },
      [19] = {
        ["x"] = 456.6,
        ["y"] = -208.2,
        ["g"] = 5,
        ["sublevel"] = 1,
      },
      [20] = {
        ["x"] = 456.4,
        ["y"] = -200.6,
        ["g"] = 5,
        ["sublevel"] = 1,
      },
    },
  },
  [4] = {
    ["name"] = "Commander Lindon",
    ["id"] = 59191,
    ["count"] = 1,
    ["health"] = 4500000,
    ["scale"] = 1,
    ["displayId"] = 40631,
    ["creatureType"] = "Humanoid",
    ["characteristics"] = {
    },
    ["spells"] = {
    },
    ["clones"] = {
      [1] = {
        ["x"] = 410.1,
        ["y"] = -288.6,
        ["g"] = 2,
        ["sublevel"] = 1,
      },
    },
  },
  [5] = {
    ["name"] = "Master Archer",
    ["id"] = 59175,
    ["count"] = 1,
    ["health"] = 818060,
    ["scale"] = 0.8,
    ["displayId"] = 40629,
    ["creatureType"] = "Humanoid",
    ["characteristics"] = {
    },
    ["spells"] = {
    },
    ["clones"] = {
      [1] = {
        ["x"] = 421.6,
        ["y"] = -294.4,
        ["g"] = 2,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 418.6,
        ["y"] = -297.3,
        ["g"] = 2,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 415.3,
        ["y"] = -298,
        ["g"] = 2,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 412.6,
        ["y"] = -300,
        ["g"] = 2,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 407.3,
        ["y"] = -299.7,
        ["g"] = 2,
        ["sublevel"] = 1,
      },
      [6] = {
        ["x"] = 404.8,
        ["y"] = -297.3,
        ["g"] = 2,
        ["sublevel"] = 1,
      },
      [7] = {
        ["x"] = 401.4,
        ["y"] = -296.4,
        ["g"] = 2,
        ["sublevel"] = 1,
      },
      [8] = {
        ["x"] = 399,
        ["y"] = -293.8,
        ["g"] = 2,
        ["sublevel"] = 1,
      },
    },
  },
  [6] = {
    ["name"] = "Houndmaster Braun",
    ["id"] = 59303,
    ["count"] = 0,
    ["health"] = 19500000,
    ["scale"] = 1.6,
    ["displayId"] = 42264,
    ["creatureType"] = "Humanoid",
    ["isBoss"] = true,
    ["instanceID"] = 311,
    ["characteristics"] = {
    },
    ["spells"] = {
    },
    ["clones"] = {
      [1] = {
        ["x"] = 458,
        ["y"] = -163.2,
        ["sublevel"] = 1,
      },
    },
  },
  [7] = {
    ["name"] = "Scarlet Scourge Hewer",
    ["id"] = 58684,
    ["count"] = 1,
    ["health"] = 2447712,
    ["scale"] = 1,
    ["displayId"] = 40756,
    ["creatureType"] = "Humanoid",
    ["characteristics"] = {
    },
    ["spells"] = {
    },
    ["clones"] = {
      [1] = {
        ["x"] = 436.6,
        ["y"] = -489.1,
        ["g"] = 9,
        ["sublevel"] = 2,
      },
      [2] = {
        ["x"] = 472.5,
        ["y"] = -442.8,
        ["g"] = 6,
        ["sublevel"] = 2,
      },
      [3] = {
        ["x"] = 480.4,
        ["y"] = -424.5,
        ["g"] = 7,
        ["sublevel"] = 2,
      },
      [4] = {
        ["x"] = 443.3,
        ["y"] = -318.6,
        ["g"] = 11,
        ["sublevel"] = 2,
      },
    },
  },
  [8] = {
    ["name"] = "Scarlet Myrmidon",
    ["id"] = 58683,
    ["count"] = 1,
    ["health"] = 2447712,
    ["scale"] = 1,
    ["displayId"] = 40724,
    ["creatureType"] = "Humanoid",
    ["characteristics"] = {
    },
    ["spells"] = {
    },
    ["clones"] = {
      [1] = {
        ["x"] = 443.9,
        ["y"] = -498.7,
        ["g"] = 9,
        ["sublevel"] = 2,
      },
      [2] = {
        ["x"] = 466.7,
        ["y"] = -448.9,
        ["g"] = 6,
        ["sublevel"] = 2,
      },
      [3] = {
        ["x"] = 438.5,
        ["y"] = -323,
        ["g"] = 11,
        ["sublevel"] = 2,
      },
    },
  },
  [9] = {
    ["name"] = "Scarlet Evangelist",
    ["id"] = 58685,
    ["count"] = 1,
    ["health"] = 2609240,
    ["scale"] = 1,
    ["displayId"] = 40764,
    ["creatureType"] = "Humanoid",
    ["characteristics"] = {
    },
    ["spells"] = {
    },
    ["clones"] = {
      [1] = {
        ["x"] = 447.7,
        ["y"] = -485.9,
        ["g"] = 9,
        ["sublevel"] = 2,
      },
      [2] = {
        ["x"] = 461.4,
        ["y"] = -443.2,
        ["g"] = 6,
        ["sublevel"] = 2,
      },
      [3] = {
        ["x"] = 484.8,
        ["y"] = -424.2,
        ["g"] = 7,
        ["sublevel"] = 2,
      },
      [4] = {
        ["x"] = 443.2,
        ["y"] = -323,
        ["g"] = 11,
        ["sublevel"] = 2,
      },
      [5] = {
        ["x"] = 443.5,
        ["y"] = -328.2,
        ["g"] = 11,
        ["sublevel"] = 2,
      },
      [6] = {
        ["x"] = 473,
        ["y"] = -448.8,
        ["g"] = 6,
        ["sublevel"] = 2,
      },
    },
  },
  [10] = {
    ["name"] = "Scarlet Cannoneer",
    ["id"] = 59293,
    ["count"] = 0,
    ["health"] = 611744,
    ["scale"] = 0.8,
    ["displayId"] = 40711,
    ["creatureType"] = "Humanoid",
    ["characteristics"] = {
    },
    ["spells"] = {
    },
    ["clones"] = {
      [1] = {
        ["x"] = 490.9,
        ["y"] = -488.7,
        ["g"] = 10,
        ["sublevel"] = 2,
      },
      [2] = {
        ["x"] = 491,
        ["y"] = -480.4,
        ["g"] = 10,
        ["sublevel"] = 2,
      },
      [3] = {
        ["x"] = 491.2,
        ["y"] = -497.2,
        ["g"] = 10,
        ["sublevel"] = 2,
      },
      [4] = {
        ["x"] = 469.2,
        ["y"] = -390,
        ["g"] = 8,
        ["sublevel"] = 2,
      },
      [5] = {
        ["x"] = 485.2,
        ["y"] = -390.1,
        ["g"] = 8,
        ["sublevel"] = 2,
      },
      [6] = {
        ["x"] = 477.6,
        ["y"] = -389.9,
        ["g"] = 8,
        ["sublevel"] = 2,
      },
      [7] = {
        ["x"] = 450.1,
        ["y"] = -504.4,
        ["g"] = 17,
        ["sublevel"] = 2,
      },
      [8] = {
        ["x"] = 442.9,
        ["y"] = -504.3,
        ["g"] = 17,
        ["sublevel"] = 2,
      },
      [9] = {
        ["x"] = 434.9,
        ["y"] = -504.9,
        ["g"] = 17,
        ["sublevel"] = 2,
      },
    },
  },
  [11] = {
    ["name"] = "Scarlet Defender",
    ["id"] = 58676,
    ["count"] = 1,
    ["health"] = 4895424,
    ["scale"] = 1,
    ["displayId"] = 40779,
    ["creatureType"] = "Humanoid",
    ["characteristics"] = {
    },
    ["spells"] = {
    },
    ["clones"] = {
      [1] = {
        ["x"] = 466.6,
        ["y"] = -443.3,
        ["g"] = 6,
        ["sublevel"] = 2,
      },
      [2] = {
        ["x"] = 432.7,
        ["y"] = -323.2,
        ["g"] = 11,
        ["sublevel"] = 2,
      },
      [3] = {
        ["x"] = 439.8,
        ["y"] = -483.5,
        ["g"] = 9,
        ["sublevel"] = 2,
      },
    },
  },
  [12] = {
    ["name"] = "Scarlet Evoker",
    ["id"] = 58756,
    ["count"] = 1,
    ["health"] = 2609240,
    ["scale"] = 1,
    ["displayId"] = 40790,
    ["creatureType"] = "Humanoid",
    ["characteristics"] = {
    },
    ["spells"] = {
    },
    ["clones"] = {
      [1] = {
        ["x"] = 475.9,
        ["y"] = -424.5,
        ["g"] = 7,
        ["sublevel"] = 2,
      },
      [2] = {
        ["x"] = 438.4,
        ["y"] = -328.2,
        ["g"] = 11,
        ["sublevel"] = 2,
      },
      [3] = {
        ["x"] = 438.6,
        ["y"] = -318.4,
        ["g"] = 11,
        ["sublevel"] = 2,
      },
      [4] = {
        ["x"] = 448.2,
        ["y"] = -491.6,
        ["g"] = 9,
        ["sublevel"] = 2,
      },
      [5] = {
        ["x"] = 460.7,
        ["y"] = -449.3,
        ["g"] = 6,
        ["sublevel"] = 2,
      },
    },
  },
  [13] = {
    ["name"] = "Armsmaster Harlan",
    ["id"] = 58632,
    ["count"] = 0,
    ["health"] = 19626164,
    ["scale"] = 1.6,
    ["displayId"] = 40293,
    ["creatureType"] = "Humanoid",
    ["isBoss"] = true,
    ["instanceID"] = 311,
    ["characteristics"] = {
    },
    ["spells"] = {
    },
    ["clones"] = {
      [1] = {
        ["x"] = 518.2,
        ["y"] = -252.9,
        ["sublevel"] = 2,
      },
    },
  },
  [14] = {
    ["name"] = "Scarlet Hall Guardian",
    ["id"] = 59240,
    ["count"] = 1,
    ["health"] = 2037660,
    ["scale"] = 1,
    ["displayId"] = 26170,
    ["creatureType"] = "Humanoid",
    ["characteristics"] = {
    },
    ["spells"] = {
    },
    ["clones"] = {
      [1] = {
        ["x"] = 388.1,
        ["y"] = -279.8,
        ["g"] = 15,
        ["sublevel"] = 2,
      },
      [2] = {
        ["x"] = 387.9,
        ["y"] = -286.1,
        ["g"] = 15,
        ["sublevel"] = 2,
      },
      [3] = {
        ["x"] = 348.1,
        ["y"] = -285.8,
        ["g"] = 16,
        ["sublevel"] = 2,
      },
      [4] = {
        ["x"] = 348.3,
        ["y"] = -279.5,
        ["g"] = 16,
        ["sublevel"] = 2,
      },
      [5] = {
        ["x"] = 365.6,
        ["y"] = -284.8,
        ["sublevel"] = 2,
      },
      [6] = {
        ["x"] = 329.4,
        ["y"] = -193.4,
        ["sublevel"] = 2,
      },
    },
  },
  [15] = {
    ["name"] = "Scarlet Treasurer",
    ["id"] = 59241,
    ["count"] = 1,
    ["health"] = 3260256,
    ["scale"] = 1,
    ["displayId"] = 40650,
    ["creatureType"] = "Humanoid",
    ["characteristics"] = {
    },
    ["spells"] = {
    },
    ["clones"] = {
      [1] = {
        ["x"] = 416.1,
        ["y"] = -262,
        ["sublevel"] = 2,
      },
      [2] = {
        ["x"] = 427.6,
        ["y"] = -281.9,
        ["sublevel"] = 2,
      },
      [3] = {
        ["x"] = 309.4,
        ["y"] = -292.3,
        ["sublevel"] = 2,
      },
      [4] = {
        ["x"] = 319.6,
        ["y"] = -266.3,
        ["sublevel"] = 2,
      },
      [5] = {
        ["x"] = 358.5,
        ["y"] = -263.5,
        ["sublevel"] = 2,
      },
    },
  },
  [16] = {
    ["name"] = "Scarlet Scholar",
    ["id"] = 59372,
    ["count"] = 1,
    ["health"] = 2852724,
    ["scale"] = 1,
    ["displayId"] = 40946,
    ["creatureType"] = "Humanoid",
    ["characteristics"] = {
    },
    ["spells"] = {
    },
    ["clones"] = {
      [1] = {
        ["x"] = 328.6,
        ["y"] = -215.5,
        ["g"] = 12,
        ["sublevel"] = 2,
      },
      [2] = {
        ["x"] = 329.5,
        ["y"] = -177,
        ["g"] = 13,
        ["sublevel"] = 2,
      },
    },
  },
  [17] = {
    ["name"] = "Scarlet Pupil",
    ["id"] = 59373,
    ["count"] = 1,
    ["health"] = 1222596,
    ["scale"] = 0.8,
    ["displayId"] = 2467,
    ["creatureType"] = "Humanoid",
    ["characteristics"] = {
    },
    ["spells"] = {
    },
    ["clones"] = {
      [1] = {
        ["x"] = 337.7,
        ["y"] = -208.9,
        ["g"] = 12,
        ["sublevel"] = 2,
      },
      [2] = {
        ["x"] = 322.5,
        ["y"] = -211.8,
        ["g"] = 12,
        ["sublevel"] = 2,
      },
      [3] = {
        ["x"] = 334.4,
        ["y"] = -212.1,
        ["g"] = 12,
        ["sublevel"] = 2,
      },
      [4] = {
        ["x"] = 319.8,
        ["y"] = -208.1,
        ["g"] = 12,
        ["sublevel"] = 2,
      },
      [5] = {
        ["x"] = 336.8,
        ["y"] = -214.8,
        ["g"] = 12,
        ["sublevel"] = 2,
      },
      [6] = {
        ["x"] = 320.1,
        ["y"] = -214.4,
        ["g"] = 12,
        ["sublevel"] = 2,
      },
      [7] = {
        ["x"] = 335.1,
        ["y"] = -173.1,
        ["g"] = 13,
        ["sublevel"] = 2,
      },
      [8] = {
        ["x"] = 323.3,
        ["y"] = -172.8,
        ["g"] = 13,
        ["sublevel"] = 2,
      },
      [9] = {
        ["x"] = 338.4,
        ["y"] = -169.9,
        ["g"] = 13,
        ["sublevel"] = 2,
      },
      [10] = {
        ["x"] = 320.5,
        ["y"] = -169.1,
        ["g"] = 13,
        ["sublevel"] = 2,
      },
      [11] = {
        ["x"] = 337.5,
        ["y"] = -175.8,
        ["g"] = 13,
        ["sublevel"] = 2,
      },
      [12] = {
        ["x"] = 320.9,
        ["y"] = -175.4,
        ["g"] = 13,
        ["sublevel"] = 2,
      },
    },
  },
  [18] = {
    ["name"] = "Flameweaver Koegler",
    ["id"] = 59150,
    ["count"] = 0,
    ["health"] = 21806850,
    ["scale"] = 1.6,
    ["displayId"] = 40597,
    ["creatureType"] = "Humanoid",
    ["isBoss"] = true,
    ["instanceID"] = 311,
    ["characteristics"] = {
    },
    ["spells"] = {
    },
    ["clones"] = {
      [1] = {
        ["x"] = 329.8,
        ["y"] = -70.8,
        ["sublevel"] = 2,
      },
    },
  },
};
