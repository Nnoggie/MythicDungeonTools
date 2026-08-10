local _, MDT = ...
local addonName = MDT.AddonName
local L = MDT.L
local dungeonIndex = 17
MDT.dungeonList[dungeonIndex] = L["Kings' Rest"]
MDT.mapInfo[dungeonIndex] = {
  teleportId = 1286831,
  iconId = 2011123,
  shortName = L["kingsRestShortName"],
  englishName = "King's Rest",
  mapID = 249
};

local zones = { 1004 }
for _, zone in ipairs(zones) do
  MDT.zoneIdToDungeonIdx[zone] = dungeonIndex
end

MDT.dungeonTotalCount[dungeonIndex] = { normal = 608 }

MDT.dungeonMaps[dungeonIndex] = {
  [0] = "",
  [1] = { customTextures = 'Interface\\AddOns\\'..addonName..'\\Midnight\\Textures\\KingsRest' },
}
MDT.dungeonSubLevels[dungeonIndex] = {
  [1] = L["Kings' Rest Sublevel"],
}

MDT.mapPOIs[dungeonIndex] = {};

MDT.dungeonEnemies[dungeonIndex] = {
  [1] = {
    ["name"] = "Animated Guardian",
    ["id"] = 133935,
    ["count"] = 22,
    ["health"] = 5513534,
    ["scale"] = 2,
    ["displayId"] = 83252,
    ["creatureType"] = "Undead",
    ["level"] = 91,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [270003] = {
      },
      [270016] = {
      },
      [1310755] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 589.10950032871,
        ["y"] = -277.61103164926,
        ["g"] = 1,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 588.65454340543,
        ["y"] = -296.85278885383,
        ["g"] = 1,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 609.32407170606,
        ["y"] = -373.19639963831,
        ["g"] = 3,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 596.75132242842,
        ["y"] = -381.23629362436,
        ["g"] = 3,
        ["sublevel"] = 1,
      },
    },
  },
  [2] = {
    ["name"] = "Minion of Zul",
    ["id"] = 133943,
    ["count"] = 0,
    ["health"] = 340110,
    ["scale"] = 1,
    ["displayId"] = 76055,
    ["creatureType"] = "Aberration",
    ["level"] = 90,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Slow"] = true,
    },
    ["spells"] = {
      [269935] = {
        ["magic"] = true,
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 595.70808467647,
        ["y"] = -342.98453884968,
        ["g"] = 2,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 609.44997887334,
        ["y"] = -350.2251866518,
        ["g"] = 2,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 604.4976079979,
        ["y"] = -334.90729893597,
        ["g"] = 2,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 596.20175390833,
        ["y"] = -334.94148573131,
        ["g"] = 2,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 612.82195942867,
        ["y"] = -335.21164324937,
        ["g"] = 2,
        ["sublevel"] = 1,
      },
      [6] = {
        ["x"] = 605.37579124986,
        ["y"] = -342.734539862,
        ["g"] = 2,
        ["sublevel"] = 1,
      },
      [7] = {
        ["x"] = 614.03725422044,
        ["y"] = -343.42902367189,
        ["g"] = 2,
        ["sublevel"] = 1,
      },
      [8] = {
        ["x"] = 600.09263323091,
        ["y"] = -350.51713439479,
        ["g"] = 2,
        ["sublevel"] = 1,
      },
      [9] = {
        ["x"] = 642.58654246564,
        ["y"] = -408.21448693991,
        ["g"] = 4,
        ["sublevel"] = 1,
      },
      [10] = {
        ["x"] = 637.03091814483,
        ["y"] = -427.86978430949,
        ["g"] = 4,
        ["sublevel"] = 1,
      },
      [11] = {
        ["x"] = 639.56980937105,
        ["y"] = -417.67651302371,
        ["g"] = 4,
        ["sublevel"] = 1,
      },
      [12] = {
        ["x"] = 649.56676785415,
        ["y"] = -415.26959478378,
        ["g"] = 4,
        ["sublevel"] = 1,
      },
      [14] = {
        ["x"] = 646.99199918186,
        ["y"] = -424.00273705628,
        ["g"] = 4,
        ["sublevel"] = 1,
      },
    },
  },
  [3] = {
    ["name"] = "Risen Hexer",
    ["id"] = 134174,
    ["count"] = 20,
    ["health"] = 4864883,
    ["scale"] = 2,
    ["displayId"] = 83371,
    ["creatureType"] = "Undead",
    ["level"] = 91,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [269972] = {
        ["interruptible"] = true,
        ["curse"] = true,
      },
      [1294815] = {
        ["interruptible"] = true,
        ["magic"] = true,
      },
    },
    ["clones"] = {
      [4] = {
        ["x"] = 706.68840154228,
        ["y"] = -440.94080527918,
        ["g"] = 6,
        ["sublevel"] = 1,
      },
    },
  },
  [4] = {
    ["name"] = "Shadow-Borne Champion",
    ["id"] = 134158,
    ["count"] = 25,
    ["health"] = 5189208,
    ["scale"] = 2,
    ["displayId"] = 83364,
    ["creatureType"] = "Undead",
    ["level"] = 91,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [269928] = {
      },
      [269976] = {
        ["enrage"] = true,
      },
      [1305945] = {
      },
      [1310758] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 698.7855023622,
        ["y"] = -401.2673053993,
        ["g"] = 5,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 665.64061901546,
        ["y"] = -451.79059701407,
        ["g"] = 7,
        ["sublevel"] = 1,
      },
    },
  },
  [5] = {
    ["name"] = "Umbral Warrior",
    ["id"] = 134157,
    ["count"] = 5,
    ["health"] = 3243255,
    ["scale"] = 1.5,
    ["displayId"] = 83363,
    ["creatureType"] = "Undead",
    ["level"] = 90,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Fear"] = true,
      ["Disorient"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
    },
    ["spells"] = {
      [1311942] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 697.87871180206,
        ["y"] = -453.17197189357,
        ["g"] = 6,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 653.6523744298,
        ["y"] = -462.92640591232,
        ["g"] = 7,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 651.2956551298,
        ["y"] = -446.46344786787,
        ["g"] = 7,
        ["sublevel"] = 1,
      },
      [6] = {
        ["x"] = 693.04134767912,
        ["y"] = -439.47510599308,
        ["g"] = 6,
        ["sublevel"] = 1,
      },
      [7] = {
        ["x"] = 688.96705100589,
        ["y"] = -411.44877102508,
        ["g"] = 5,
        ["sublevel"] = 1,
      },
      [8] = {
        ["x"] = 684.23994801087,
        ["y"] = -398.28546706837,
        ["g"] = 5,
        ["sublevel"] = 1,
      },
    },
  },
  [6] = {
    ["name"] = "The Golden Serpent",
    ["id"] = 135322,
    ["count"] = 0,
    ["health"] = 21283860,
    ["scale"] = 2,
    ["displayId"] = 84202,
    ["creatureType"] = "Beast",
    ["level"] = 92,
    ["isBoss"] = true,
    ["encounterID"] = 2165,
    ["instanceID"] = 1041,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [265773] = {
      },
      [265781] = {
      },
      [265910] = {
      },
      [265923] = {
      },
      [265991] = {
      },
      [1306736] = {
      },
      [1311987] = {
      },
      [1311988] = {
      },
      [1312104] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 748.99864421287,
        ["y"] = -412.64366982418,
        ["sublevel"] = 1,
      },
    },
  },
  [7] = {
    ["name"] = "Skeletal Hunting Raptor",
    ["id"] = 137487,
    ["count"] = 10,
    ["health"] = 3243255,
    ["scale"] = 2,
    ["displayId"] = 33733,
    ["creatureType"] = "Undead",
    ["level"] = 91,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [270500] = {
      },
      [270502] = {
      },
      [270503] = {
      },
      [1297763] = {
        ["enrage"] = true,
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 516.41434948421,
        ["y"] = -500.69344876352,
        ["g"] = 11,
        ["sublevel"] = 1,
      },
    },
  },
  [8] = {
    ["name"] = "Queen Patlaa",
    ["id"] = 137486,
    ["count"] = 25,
    ["health"] = 5189208,
    ["scale"] = 2,
    ["displayId"] = 85287,
    ["creatureType"] = "Undead",
    ["level"] = 91,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [270931] = {
      },
      [1294883] = {
      },
      [1297763] = {
        ["enrage"] = true,
      },
      [1305982] = {
      },
      [1306761] = {
      },
      [1306763] = {
        ["poison"] = true,
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 515.55280644364,
        ["y"] = -481.89662823177,
        ["g"] = 11,
        ["sublevel"] = 1,
      },
    },
  },
  [9] = {
    ["name"] = "King A'akul",
    ["id"] = 137484,
    ["count"] = 25,
    ["health"] = 8432462,
    ["scale"] = 2,
    ["displayId"] = 85284,
    ["creatureType"] = "Undead",
    ["level"] = 91,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [1297918] = {
        ["bleed"] = true,
      },
      [1297970] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 563.40266714402,
        ["y"] = -494.30301822262,
        ["g"] = 9,
        ["sublevel"] = 1,
      },
    },
  },
  [10] = {
    ["name"] = "Bloodsworn Assassin",
    ["id"] = 137485,
    ["count"] = 7,
    ["health"] = 3243255,
    ["scale"] = 1.5,
    ["displayId"] = 85285,
    ["creatureType"] = "Undead",
    ["level"] = 90,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Disorient"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
    },
    ["spells"] = {
      [1297781] = {
        ["bleed"] = true,
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 563.81943714144,
        ["y"] = -523.3824768165,
        ["g"] = 9,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 563.68629162038,
        ["y"] = -508.65694560382,
        ["g"] = 9,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 564.70910746082,
        ["y"] = -465.29509799409,
        ["g"] = 9,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 563.84968325557,
        ["y"] = -479.02496556106,
        ["g"] = 9,
        ["sublevel"] = 1,
      },
    },
  },
  [11] = {
    ["name"] = "Seneschal M'bara",
    ["id"] = 134251,
    ["count"] = 10,
    ["health"] = 3243255,
    ["scale"] = 1.5,
    ["displayId"] = 83517,
    ["creatureType"] = "Undead",
    ["level"] = 90,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [270901] = {
        ["interruptible"] = true,
        ["magic"] = true,
      },
      [1296671] = {
        ["magic"] = true,
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 540.33390179206,
        ["y"] = -475.88096198539,
        ["g"] = 10,
        ["sublevel"] = 1,
      },
    },
  },
  [12] = {
    ["name"] = "Guard Captain Atu",
    ["id"] = 137473,
    ["count"] = 10,
    ["health"] = 5270289,
    ["scale"] = 1.5,
    ["displayId"] = 85270,
    ["creatureType"] = "Undead",
    ["level"] = 90,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Disorient"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
    },
    ["spells"] = {
      [1296671] = {
        ["magic"] = true,
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 539.57584861982,
        ["y"] = -508.51546938936,
        ["g"] = 10,
        ["sublevel"] = 1,
      },
    },
  },
  [13] = {
    ["name"] = "King Rahu'ai",
    ["id"] = 134331,
    ["count"] = 25,
    ["health"] = 5189208,
    ["scale"] = 2,
    ["displayId"] = 83544,
    ["creatureType"] = "Undead",
    ["level"] = 91,
    ["spells"] = {
      [270889] = {
      },
      [270891] = {
      },
      [1296671] = {
        ["magic"] = true,
      },
      [1296719] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 539.92245312894,
        ["y"] = -492.21388437602,
        ["g"] = 10,
        ["sublevel"] = 1,
      },
    },
  },
  [14] = {
    ["name"] = "King Timalji",
    ["id"] = 137474,
    ["count"] = 25,
    ["health"] = 7783811,
    ["scale"] = 2,
    ["displayId"] = 85272,
    ["creatureType"] = "Undead",
    ["level"] = 91,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [270927] = {
      },
      [270928] = {
      },
      [1297326] = {
      },
      [1306049] = {
      },
      [1306056] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 589.31275389984,
        ["y"] = -503.33229032397,
        ["g"] = 8,
        ["sublevel"] = 1,
      },
    },
  },
  [15] = {
    ["name"] = "Queen Wasi",
    ["id"] = 137478,
    ["count"] = 25,
    ["health"] = 7783811,
    ["scale"] = 2,
    ["displayId"] = 85274,
    ["creatureType"] = "Undead",
    ["level"] = 91,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [270920] = {
        ["interruptible"] = true,
        ["magic"] = true,
      },
      [1294972] = {
        ["interruptible"] = true,
        ["magic"] = true,
      },
      [1297326] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 589.74137091726,
        ["y"] = -484.2521035899,
        ["g"] = 8,
        ["sublevel"] = 1,
      },
    },
  },
  [16] = {
    ["name"] = "Purification Construct",
    ["id"] = 134739,
    ["count"] = 25,
    ["health"] = 7783811,
    ["scale"] = 2,
    ["displayId"] = 83836,
    ["creatureType"] = "Undead",
    ["level"] = 91,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [270292] = {
      },
      [270293] = {
      },
      [1310755] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 461.85011601852,
        ["y"] = -329.96179259849,
        ["g"] = 12,
        ["sublevel"] = 1,
      },
    },
  },
  [17] = {
    ["name"] = "Interment Construct",
    ["id"] = 137969,
    ["count"] = 15,
    ["health"] = 5837859,
    ["scale"] = 1.9,
    ["displayId"] = 85677,
    ["creatureType"] = "Undead",
    ["level"] = 91,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [271555] = {
      },
      [271561] = {
      },
      [271562] = {
      },
      [1310755] = {
      },
      [1312569] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 493.80648828438,
        ["y"] = -175.90274761188,
        ["g"] = 13,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 430.46342921221,
        ["y"] = -107.94370543541,
        ["g"] = 20,
        ["sublevel"] = 1,
      },
    },
  },
  [18] = {
    ["name"] = "Mchimba the Embalmer",
    ["id"] = 134993,
    ["count"] = 0,
    ["health"] = 21283860,
    ["scale"] = 1.7,
    ["displayId"] = 83529,
    ["creatureType"] = "Mechanical",
    ["level"] = 92,
    ["isBoss"] = true,
    ["encounterID"] = 2171,
    ["instanceID"] = 1041,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [267618] = {
      },
      [267639] = {
      },
      [267702] = {
      },
      [267874] = {
      },
      [271290] = {
      },
      [1312146] = {
      },
      [1312848] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 484.27581583624,
        ["y"] = -123.27039177586,
        ["g"] = 21,
        ["sublevel"] = 1,
      },
    },
  },
  [19] = {
    ["name"] = "Phantom Hex Priest",
    ["id"] = 135204,
    ["count"] = 7,
    ["health"] = 2918930,
    ["scale"] = 1.5,
    ["displayId"] = 84140,
    ["creatureType"] = "Undead",
    ["level"] = 90,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Incapacitate"] = true,
      ["Silence"] = true,
      ["Shackle Undead"] = true,
      ["Disorient"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
    },
    ["spells"] = {
      [270492] = {
        ["interruptible"] = true,
        ["curse"] = true,
      },
      [1295125] = {
        ["interruptible"] = true,
        ["magic"] = true,
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 351.95595931186,
        ["y"] = -142.96329299119,
        ["g"] = 22,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 365.98434133546,
        ["y"] = -143.16195594473,
        ["g"] = 22,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 357.71089064167,
        ["y"] = -223.36671859339,
        ["g"] = 24,
        ["sublevel"] = 1,
      },
    },
  },
  [20] = {
    ["name"] = "Royal Berserker",
    ["id"] = 135167,
    ["count"] = 22,
    ["health"] = 3891906,
    ["scale"] = 1.5,
    ["displayId"] = 84112,
    ["creatureType"] = "Undead",
    ["level"] = 91,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Incapacitate"] = true,
      ["Silence"] = true,
      ["Shackle Undead"] = true,
      ["Root"] = true,
      ["Disorient"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
    },
    ["spells"] = {
      [270482] = {
      },
      [270485] = {
      },
      [1301851] = {
        ["bleed"] = true,
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 358.5056830791,
        ["y"] = -354.22609506413,
        ["g"] = 26,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 369.39058760817,
        ["y"] = -166.36909063245,
        ["g"] = 30,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 349.41057683712,
        ["y"] = -166.36909063245,
        ["g"] = 30,
        ["sublevel"] = 1,
      },
    },
  },
  [21] = {
    ["name"] = "Spectral Shaman",
    ["id"] = 135239,
    ["count"] = 7,
    ["health"] = 3243255,
    ["scale"] = 1.5,
    ["displayId"] = 84163,
    ["creatureType"] = "Undead",
    ["level"] = 90,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Silence"] = true,
      ["Disorient"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
    },
    ["spells"] = {
      [270497] = {
      },
      [270499] = {
        ["magic"] = true,
      },
    },
    ["clones"] = {
      [2] = {
        ["x"] = 343.78062554018,
        ["y"] = -223.46746249449,
        ["g"] = 24,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 352.85698300084,
        ["y"] = -129.48110299573,
        ["g"] = 22,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 366.44712804009,
        ["y"] = -129.35583591113,
        ["g"] = 22,
        ["sublevel"] = 1,
      },
      [6] = {
        ["x"] = 373.0482089474,
        ["y"] = -223.61876388895,
        ["g"] = 24,
        ["sublevel"] = 1,
      },
    },
  },
  [22] = {
    ["name"] = "Ghostly Brute",
    ["id"] = 135231,
    ["count"] = 25,
    ["health"] = 6486509,
    ["scale"] = 2,
    ["displayId"] = 85125,
    ["creatureType"] = "Undead",
    ["level"] = 91,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [270514] = {
      },
      [1302028] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 357.94221117131,
        ["y"] = -288.40684786312,
        ["g"] = 25,
        ["sublevel"] = 1,
      },
    },
  },
  [23] = {
    ["name"] = "Honored Raptor",
    ["id"] = 135192,
    ["count"] = 5,
    ["health"] = 3243255,
    ["scale"] = 1.5,
    ["displayId"] = 84133,
    ["creatureType"] = "Undead",
    ["level"] = 90,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Disorient"] = true,
      ["Stun"] = true,
    },
    ["spells"] = {
      [270500] = {
      },
      [270502] = {
      },
      [270503] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 367.60331413059,
        ["y"] = -368.2836492894,
        ["g"] = 26,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 350.0894812563,
        ["y"] = -367.92622667404,
        ["g"] = 26,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 348.81156707137,
        ["y"] = -234.81174514761,
        ["g"] = 24,
        ["sublevel"] = 1,
      },
      [6] = {
        ["x"] = 368.28178611568,
        ["y"] = -234.75054331848,
        ["g"] = 24,
        ["sublevel"] = 1,
      },
    },
  },
  [24] = {
    ["name"] = "Shadow of Zul",
    ["id"] = 138489,
    ["count"] = 30,
    ["health"] = 8432462,
    ["scale"] = 2.5,
    ["displayId"] = 85860,
    ["creatureType"] = "Humanoid",
    ["level"] = -1,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["clones"] = {
      [1] = {
        ["x"] = 207.89294769914,
        ["y"] = -289.2271839278,
        ["g"] = 28,
        ["sublevel"] = 1,
      },
    },
  },
  [25] = {
    ["name"] = "King Dazar",
    ["id"] = 136160,
    ["count"] = 0,
    ["health"] = 30405514,
    ["scale"] = 2,
    ["displayId"] = 84352,
    ["creatureType"] = "Undead",
    ["level"] = 92,
    ["isBoss"] = true,
    ["encounterID"] = 2172,
    ["instanceID"] = 1041,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [268586] = {
      },
      [268587] = {
      },
      [268589] = {
      },
      [268590] = {
      },
      [268591] = {
      },
      [269503] = {
      },
      [1302945] = {
      },
      [1303105] = {
      },
      [1303111] = {
      },
      [1303115] = {
      },
      [1303267] = {
      },
      [1303372] = {
      },
      [1303374] = {
      },
      [1303396] = {
      },
      [1303399] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 64.775005175943,
        ["y"] = -292.05149108059,
        ["g"] = 29,
        ["sublevel"] = 1,
      },
    },
  },
  [26] = {
    ["name"] = "Embalming Fluid",
    ["id"] = 137989,
    ["count"] = 1,
    ["health"] = 1945953,
    ["scale"] = 0.7,
    ["displayId"] = 33008,
    ["creatureType"] = "Aberration",
    ["level"] = 90,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Silence"] = true,
      ["Root"] = true,
      ["Disorient"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
    },
    ["spells"] = {
      [271563] = {
      },
      [1298104] = {
        ["poison"] = true,
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 441.81483950518,
        ["y"] = -156.28715082636,
        ["g"] = 16,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 446.83307344471,
        ["y"] = -159.66576717184,
        ["g"] = 16,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 451.60342723868,
        ["y"] = -164.4342709779,
        ["g"] = 16,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 446.1486009946,
        ["y"] = -165.63915450827,
        ["g"] = 16,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 441.00283458726,
        ["y"] = -162.14858100022,
        ["g"] = 16,
        ["sublevel"] = 1,
      },
      [6] = {
        ["x"] = 460.56931034336,
        ["y"] = -175.57077986759,
        ["g"] = 16,
        ["sublevel"] = 1,
      },
      [7] = {
        ["x"] = 467.29233069341,
        ["y"] = -176.37245519833,
        ["g"] = 16,
        ["sublevel"] = 1,
      },
      [8] = {
        ["x"] = 425.44497507075,
        ["y"] = -174.43237211124,
        ["g"] = 16,
        ["sublevel"] = 1,
      },
      [9] = {
        ["x"] = 430.51340252744,
        ["y"] = -179.59466554863,
        ["g"] = 16,
        ["sublevel"] = 1,
      },
      [10] = {
        ["x"] = 426.30909723536,
        ["y"] = -140.89085431466,
        ["g"] = 18,
        ["sublevel"] = 1,
      },
      [11] = {
        ["x"] = 432.76503020625,
        ["y"] = -141.07679149179,
        ["g"] = 18,
        ["sublevel"] = 1,
      },
      [12] = {
        ["x"] = 428.82339856913,
        ["y"] = -146.10824062515,
        ["g"] = 18,
        ["sublevel"] = 1,
      },
      [13] = {
        ["x"] = 421.40296434111,
        ["y"] = -121.38449390923,
        ["g"] = 18,
        ["sublevel"] = 1,
      },
      [14] = {
        ["x"] = 421.55594994242,
        ["y"] = -128.07059346949,
        ["g"] = 18,
        ["sublevel"] = 1,
      },
      [15] = {
        ["x"] = 440.79105113924,
        ["y"] = -121.46720915808,
        ["g"] = 18,
        ["sublevel"] = 1,
      },
      [16] = {
        ["x"] = 445.54626745952,
        ["y"] = -118.83559787808,
        ["g"] = 18,
        ["sublevel"] = 1,
      },
      [17] = {
        ["x"] = 445.6778481291,
        ["y"] = -125.46966399812,
        ["g"] = 18,
        ["sublevel"] = 1,
      },
    },
  },
  [27] = {
    ["name"] = "Disruption Totem",
    ["id"] = 135761,
    ["count"] = 0,
    ["health"] = 324326,
    ["scale"] = 1.5,
    ["displayId"] = 84680,
    ["creatureType"] = "Totem",
    ["level"] = 90,
    ["spells"] = {
      [267257] = {
      },
      [1309499] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 359.98181736554,
        ["y"] = -495.94195341319,
        ["g"] = 27,
        ["sublevel"] = 1,
      },
    },
  },
  [28] = {
    ["name"] = "Explosive Totem",
    ["id"] = 135764,
    ["count"] = 0,
    ["health"] = 374121,
    ["scale"] = 1.5,
    ["displayId"] = 84933,
    ["creatureType"] = "Totem",
    ["level"] = 90,
    ["spells"] = {
      [267077] = {
      },
      [1309499] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 343.73035572661,
        ["y"] = -473.16275367192,
        ["g"] = 27,
        ["sublevel"] = 1,
      },
    },
  },
  [29] = {
    ["name"] = "Torrent Totem",
    ["id"] = 135765,
    ["count"] = 0,
    ["health"] = 324326,
    ["scale"] = 1.5,
    ["displayId"] = 84934,
    ["creatureType"] = "Totem",
    ["level"] = 90,
    ["spells"] = {
      [267105] = {
      },
      [1309499] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 373.03132125613,
        ["y"] = -471.76522087359,
        ["g"] = 27,
        ["sublevel"] = 1,
      },
    },
  },
  [30] = {
    ["name"] = "Coffin",
    ["id"] = 136256,
    ["count"] = 0,
    ["health"] = 540543,
    ["scale"] = 1,
    ["displayId"] = 76137,
    ["creatureType"] = "Not specified",
    ["level"] = 334,
    ["clones"] = {
      [1] = {
        ["x"] = 503.95752963402,
        ["y"] = -121.68250642386,
        ["g"] = 21,
        ["sublevel"] = 1,
      },
    },
  },
  [31] = {
    ["name"] = "T'zala",
    ["id"] = 136976,
    ["count"] = 0,
    ["health"] = 27027123,
    ["scale"] = 2,
    ["displayId"] = 84274,
    ["creatureType"] = "Undead",
    ["level"] = 91,
    ["spells"] = {
      [1303324] = {
      },
      [1303326] = {
      },
      [1303327] = {
      },
      [1303396] = {
      },
      [1303399] = {
      },
      [1303488] = {
      },
      [1303490] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 87.293451679553,
        ["y"] = -280.80789532326,
        ["g"] = 29,
        ["sublevel"] = 1,
      },
    },
  },
  [32] = {
    ["name"] = "Reban",
    ["id"] = 136984,
    ["count"] = 0,
    ["health"] = 3783797,
    ["scale"] = 2,
    ["displayId"] = 84273,
    ["creatureType"] = "Undead",
    ["level"] = 91,
    ["spells"] = {
      [269230] = {
      },
      [269231] = {
      },
      [269232] = {
      },
      [269369] = {
        ["interruptible"] = true,
      },
      [1303039] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 86.849867196651,
        ["y"] = -306.83189482054,
        ["g"] = 29,
        ["sublevel"] = 1,
      },
    },
  },
  [33] = {
    ["name"] = "Minion of Zul",
    ["id"] = 138493,
    ["count"] = 0,
    ["health"] = 243242,
    ["scale"] = 1,
    ["displayId"] = 76055,
    ["creatureType"] = "Aberration",
    ["level"] = 90,
    ["spells"] = {
      [269935] = {
        ["magic"] = true,
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 192.78363284503,
        ["y"] = -290.56593131003,
        ["g"] = 28,
        ["sublevel"] = 1,
      },
    },
  },
  [34] = {
    ["name"] = "Aka'ali the Conqueror",
    ["id"] = 269808,
    ["count"] = 0,
    ["health"] = 8108137,
    ["scale"] = 1.5,
    ["displayId"] = 84269,
    ["creatureType"] = "Undead",
    ["level"] = 92,
    ["isBoss"] = true,
    ["encounterID"] = 2170,
    ["instanceID"] = 0,
    ["spells"] = {
      [266237] = {
      },
      [266951] = {
      },
      [267494] = {
      },
      [1310761] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 324.77239853842,
        ["y"] = -502.9189182066,
        ["g"] = 27,
        ["sublevel"] = 1,
      },
    },
  },
  [35] = {
    ["name"] = "Zanazal the Wise",
    ["id"] = 269810,
    ["count"] = 0,
    ["health"] = 10135171,
    ["scale"] = 1.5,
    ["displayId"] = 84271,
    ["creatureType"] = "Undead",
    ["level"] = 92,
    ["isBoss"] = true,
    ["encounterID"] = 2170,
    ["instanceID"] = 0,
    ["spells"] = {
      [267060] = {
      },
      [267273] = {
        ["interruptible"] = true,
        ["poison"] = true,
      },
      [1305810] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 360.57824810358,
        ["y"] = -532.66758932985,
        ["g"] = 27,
        ["sublevel"] = 1,
      },
    },
  },
  [36] = {
    ["name"] = "Kula the Butcher",
    ["id"] = 269811,
    ["count"] = 0,
    ["health"] = 5405425,
    ["scale"] = 1.5,
    ["displayId"] = 84272,
    ["creatureType"] = "Undead",
    ["level"] = 92,
    ["isBoss"] = true,
    ["encounterID"] = 2170,
    ["instanceID"] = 0,
    ["spells"] = {
      [266191] = {
        ["bleed"] = true,
      },
      [266206] = {
      },
      [266231] = {
        ["bleed"] = true,
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 396.39185979621,
        ["y"] = -502.45792927534,
        ["g"] = 27,
        ["sublevel"] = 1,
      },
    },
  },
  [37] = {
    ["name"] = "Half-Finished Mummy",
    ["id"] = 270502,
    ["count"] = 7,
    ["health"] = 3243255,
    ["scale"] = 1.5,
    ["displayId"] = 84688,
    ["creatureType"] = "Undead",
    ["level"] = 91,
    ["spells"] = {
      [267763] = {
        ["interruptible"] = true,
        ["disease"] = true,
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 502.07656926476,
        ["y"] = -160.63537555131,
        ["g"] = 13,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 502.93346633318,
        ["y"] = -187.49779961782,
        ["g"] = 13,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 446.63430153577,
        ["y"] = -104.92115036483,
        ["g"] = 20,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 415.00986115068,
        ["y"] = -104.80179999463,
        ["g"] = 20,
        ["sublevel"] = 1,
      },
    },
  },
  [38] = {
    ["name"] = "Animated Gold",
    ["id"] = 135406,
    ["count"] = 0,
    ["health"] = 224807,
    ["scale"] = 1,
    ["displayId"] = 88651,
    ["creatureType"] = "Aberration",
    ["level"] = 90,
    ["spells"] = {
      [265991] = {
      },
      [1289063] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 757.26294388337,
        ["y"] = -390.60000702019,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 760.60500249107,
        ["y"] = -429.60016619375,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 766.72099462762,
        ["y"] = -422.01624886412,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 769.41203531439,
        ["y"] = -410.27340452977,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 765.9870838646,
        ["y"] = -399.7538052729,
        ["sublevel"] = 1,
      },
    },
  },
  [39] = {
    ["name"] = "Healing Tide Totem",
    ["id"] = 137591,
    ["count"] = 0,
    ["health"] = 374121,
    ["scale"] = 1,
    ["displayId"] = 84934,
    ["creatureType"] = "Totem",
    ["level"] = 90,
    ["clones"] = {
      [1] = {
        ["x"] = 359.49630283569,
        ["y"] = -119.51110562644,
        ["g"] = 22,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 359.13750420205,
        ["y"] = -233.630640161,
        ["g"] = 24,
        ["sublevel"] = 1,
      },
    },
  },
};
