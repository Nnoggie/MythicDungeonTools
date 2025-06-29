local addonName = ...
local MDT = MDT
local L = MDT.L
local dungeonIndex = 37
MDT.dungeonList[dungeonIndex] = L["TazaveshLower"]
MDT.mapInfo[dungeonIndex] = {
  teleportId = 367416,
  shortName = L["tazaveshLowerShortName"],
  englishName = "Tazavesh: Streets of Wonder",
  mapID = 391
};

local zones = { 1989, 1990, 1991, 1992 }
for _, zone in ipairs(zones) do
  MDT.zoneIdToDungeonIdx[zone] = dungeonIndex
end

MDT.dungeonMaps[dungeonIndex] = {
  [0] = "",
  [1] = { customTextures = 'Interface\\AddOns\\'..addonName..'\\TheWarWithin\\Textures\\TazaveshLower' }
}

MDT.dungeonSubLevels[dungeonIndex] = {
  [1] = L["TazaveshLower"],
}

MDT.dungeonTotalCount[dungeonIndex] = { normal = 290, teeming = 1000, teemingEnabled = true }

MDT.mapPOIs[dungeonIndex] = {
  [1] = {
    [1] = {
      ["template"] = "DeathReleasePinTemplate",
      ["type"] = "graveyard",
      ["x"] = 714.72250671485,
      ["y"] = -271.3633800292,
      ["graveyardDescription"] = "",
    },
  },
};

MDT.dungeonEnemies[dungeonIndex] = {
  [1] = {
    ["name"] = "Customs Security",
    ["id"] = 177807,
    ["count"] = 4,
    ["health"] = 234643,
    ["scale"] = 1.3,
    ["displayId"] = 100873,
    ["creatureType"] = "Humanoid",
    ["level"] = 80,
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
      [355888] = {
      },
      [355889] = {
      },
      [355891] = {
      },
      [355900] = {
      },
      [355903] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 815.36363951089,
        ["y"] = -355.16674352979,
        ["g"] = 1,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 816.19480930973,
        ["y"] = -368.09982248246,
        ["g"] = 1,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 751.71858706696,
        ["y"] = -342.0686358811,
        ["g"] = 2,
        ["sublevel"] = 1,
        ["disguised"] = true,
      },
      [4] = {
        ["x"] = 734.01606017565,
        ["y"] = -371.79415930885,
        ["g"] = 3,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 679.81149926684,
        ["y"] = -328.47021691785,
        ["g"] = 6,
        ["sublevel"] = 1,
      },
      [6] = {
        ["x"] = 665.18723626938,
        ["y"] = -342.47009207348,
        ["g"] = 7,
        ["sublevel"] = 1,
        ["inspiring"] = true,
      },
      [7] = {
        ["x"] = 683.90163308751,
        ["y"] = -366.07461375322,
        ["g"] = 8,
        ["sublevel"] = 1,
      },
      [8] = {
        ["x"] = 723.69657510293,
        ["y"] = -313.89515990141,
        ["g"] = 5,
        ["sublevel"] = 1,
      },
      [9] = {
        ["x"] = 710.42909386094,
        ["y"] = -347.52058838765,
        ["g"] = 4,
        ["sublevel"] = 1,
      },
    },
  },
  [2] = {
    ["name"] = "Gatewarden Zo'mazz",
    ["id"] = 178392,
    ["count"] = 18,
    ["health"] = 341298,
    ["scale"] = 1.3,
    ["displayId"] = 101505,
    ["creatureType"] = "Humanoid",
    ["level"] = 81,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [351047] = {
      },
      [352796] = {
      },
      [356548] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 805.34590361427,
        ["y"] = -360.76512788923,
        ["g"] = 1,
        ["sublevel"] = 1,
      },
    },
  },
  [3] = {
    ["name"] = "Support Officer",
    ["id"] = 177817,
    ["count"] = 4,
    ["health"] = 191980,
    ["scale"] = 1.2,
    ["displayId"] = 100876,
    ["creatureType"] = "Humanoid",
    ["level"] = 80,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Incapacitate"] = true,
      ["Silence"] = true,
      ["Root"] = true,
      ["Fear"] = true,
      ["Disorient"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
    },
    ["spells"] = {
      [354297] = {
        ["interruptible"] = true,
      },
      [355934] = {
        ["interruptible"] = true,
      },
      [355980] = {
      },
      [356549] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 740.41752035722,
        ["y"] = -342.295849666,
        ["g"] = 2,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 713.91504398082,
        ["y"] = -319.75314154042,
        ["g"] = 5,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 704.40170981466,
        ["y"] = -337.12912950193,
        ["g"] = 4,
        ["sublevel"] = 1,
        ["disguised"] = true,
      },
      [4] = {
        ["x"] = 689.57812888204,
        ["y"] = -322.19944813507,
        ["g"] = 6,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 678.19618677505,
        ["y"] = -376.67191731256,
        ["g"] = 8,
        ["sublevel"] = 1,
      },
    },
  },
  [4] = {
    ["name"] = "Interrogation Specialist",
    ["id"] = 177816,
    ["count"] = 4,
    ["health"] = 191980,
    ["scale"] = 1.3,
    ["displayId"] = 100877,
    ["creatureType"] = "Humanoid",
    ["level"] = 80,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Incapacitate"] = true,
      ["Silence"] = true,
      ["Root"] = true,
      ["Fear"] = true,
      ["Disorient"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
    },
    ["spells"] = {
      [355915] = {
      },
      [355930] = {
        ["interruptible"] = true,
      },
      [356031] = {
        ["interruptible"] = true,
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 726.62056657573,
        ["y"] = -361.83939944991,
        ["g"] = 3,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 723.52593230504,
        ["y"] = -325.87339822981,
        ["g"] = 5,
        ["sublevel"] = 1,
        ["inspiring"] = true,
      },
      [3] = {
        ["x"] = 680.38047558775,
        ["y"] = -316.09696200051,
        ["g"] = 6,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 653.68718558752,
        ["y"] = -342.61484626848,
        ["g"] = 7,
        ["sublevel"] = 1,
      },
    },
  },
  [5] = {
    ["name"] = "Armored Overseer",
    ["id"] = 177808,
    ["count"] = 8,
    ["health"] = 277305,
    ["scale"] = 1.3,
    ["displayId"] = 100874,
    ["creatureType"] = "Humanoid",
    ["level"] = 81,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [351047] = {
      },
      [352796] = {
      },
      [356001] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 698.37609022376,
        ["y"] = -347.54300203702,
        ["g"] = 4,
        ["sublevel"] = 1,
        ["patrol"] = {
          [1] = {
            ["x"] = 628.17304689452,
            ["y"] = -267.74730778368,
          },
          [2] = {
            ["x"] = 624.47282782525,
            ["y"] = -267.57677417457,
          },
          [3] = {
            ["x"] = 624.47282782525,
            ["y"] = -254.64230179823,
          },
          [4] = {
            ["x"] = 640.52323883238,
            ["y"] = -254.64230179823,
          },
          [5] = {
            ["x"] = 640.52323883238,
            ["y"] = -266.99545447884,
          },
        },
      },
      [2] = {
        ["x"] = 620.50805557523,
        ["y"] = -366.19065816628,
        ["g"] = 9,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 620.7457434907,
        ["y"] = -352.48403453222,
        ["g"] = 9,
        ["sublevel"] = 1,
        ["disguised"] = true,
      },
    },
  },
  [6] = {
    ["name"] = "Portalmancer Zo'honn",
    ["id"] = 179334,
    ["count"] = 24,
    ["health"] = 426623,
    ["scale"] = 2.2,
    ["displayId"] = 100877,
    ["creatureType"] = "Humanoid",
    ["level"] = 81,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [352390] = {
      },
      [354297] = {
        ["interruptible"] = true,
      },
      [356537] = {
        ["interruptible"] = true,
      },
      [356548] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 702.33989414478,
        ["y"] = -263.12832631468,
        ["sublevel"] = 1,
      },
    },
  },
  [7] = {
    ["name"] = "Zo'phex",
    ["id"] = 175616,
    ["count"] = 0,
    ["health"] = 1278300,
    ["scale"] = 2,
    ["displayId"] = 100049,
    ["creatureType"] = "Humanoid",
    ["level"] = 82,
    ["isBoss"] = true,
    ["encounterID"] = 2437,
    ["instanceID"] = 0,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [345770] = {
      },
      [345990] = {
      },
      [346204] = {
      },
      [347949] = {
      },
      [347992] = {
      },
      [348128] = {
      },
      [348350] = {
      },
      [353411] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 709.39481794305,
        ["y"] = -218.09678204433,
        ["sublevel"] = 1,
      },
    },
  },
  [8] = {
    ["name"] = "Tracker Zo'korss",
    ["id"] = 179837,
    ["count"] = 18,
    ["health"] = 426623,
    ["scale"] = 2,
    ["stealthDetect"] = true,
    ["displayId"] = 101474,
    ["creatureType"] = "Humanoid",
    ["level"] = 81,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [356001] = {
      },
      [356929] = {
      },
      [356942] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 492.92549596478,
        ["y"] = -407.40854401594,
        ["sublevel"] = 1,
      },
    },
  },
  [9] = {
    ["name"] = "Ancient Core Hound",
    ["id"] = 180091,
    ["count"] = 12,
    ["health"] = 307168,
    ["scale"] = 2,
    ["displayId"] = 101639,
    ["creatureType"] = "Beast",
    ["level"] = 81,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [356404] = {
        ["interruptible"] = true,
      },
      [356407] = {
        ["interruptible"] = true,
      },
      [356408] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 456.28306143508,
        ["y"] = -453.0728651538,
        ["g"] = 29,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 437.64580438371,
        ["y"] = -460.99983549219,
        ["g"] = 29,
        ["sublevel"] = 1,
      },
    },
  },
  [10] = {
    ["name"] = "Enraged Direhorn",
    ["id"] = 180495,
    ["count"] = 10,
    ["health"] = 341298,
    ["scale"] = 2,
    ["displayId"] = 47441,
    ["creatureType"] = "Beast",
    ["level"] = 80,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [357508] = {
      },
      [357512] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 399.91116866751,
        ["y"] = -495.11871975721,
        ["sublevel"] = 1,
      },
    },
  },
  [11] = {
    ["name"] = "Frenzied Nightclaw",
    ["id"] = 180567,
    ["count"] = 4,
    ["health"] = 170649,
    ["scale"] = 1.3,
    ["displayId"] = 101951,
    ["creatureType"] = "Beast",
    ["level"] = 80,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Root"] = true,
      ["Disorient"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
    },
    ["spells"] = {
      [357827] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 336.28023937584,
        ["y"] = -458.67557325632,
        ["g"] = 28,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 342.368072143,
        ["y"] = -447.90710763082,
        ["g"] = 28,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 325.39596204677,
        ["y"] = -453.67848161005,
        ["g"] = 28,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 331.12570962912,
        ["y"] = -442.37890824169,
        ["g"] = 28,
        ["sublevel"] = 1,
      },
    },
  },
  [12] = {
    ["name"] = "Market Peacekeeper",
    ["id"] = 179840,
    ["count"] = 4,
    ["health"] = 255974,
    ["scale"] = 1.3,
    ["displayId"] = 101475,
    ["creatureType"] = "Humanoid",
    ["level"] = 80,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Incapacitate"] = true,
      ["Root"] = true,
      ["Fear"] = true,
      ["Disorient"] = true,
      ["Imprison"] = true,
      ["Sap"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
    },
    ["spells"] = {
      [355637] = {
      },
      [355640] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 267.17628239166,
        ["y"] = -429.09148210731,
        ["g"] = 22,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 261.32108198857,
        ["y"] = -439.58465844985,
        ["g"] = 22,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 242.0121661127,
        ["y"] = -413.76609704142,
        ["g"] = 21,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 242.50425037572,
        ["y"] = -401.76259595358,
        ["g"] = 21,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 202.26418615462,
        ["y"] = -437.16166684255,
        ["g"] = 23,
        ["sublevel"] = 1,
      },
      [6] = {
        ["x"] = 242.79298534928,
        ["y"] = -367.64060089195,
        ["g"] = 20,
        ["sublevel"] = 1,
      },
      [7] = {
        ["x"] = 252.48874891458,
        ["y"] = -373.6439661741,
        ["g"] = 20,
        ["sublevel"] = 1,
      },
      [8] = {
        ["x"] = 205.53305345829,
        ["y"] = -469.94107221553,
        ["g"] = 24,
        ["sublevel"] = 1,
      },
      [9] = {
        ["x"] = 166.16050688793,
        ["y"] = -467.2322335408,
        ["g"] = 25,
        ["sublevel"] = 1,
        ["disguised"] = true,
      },
      [10] = {
        ["x"] = 175.91711582911,
        ["y"] = -473.97874911268,
        ["g"] = 25,
        ["sublevel"] = 1,
      },
      [11] = {
        ["x"] = 213.48923941449,
        ["y"] = -339.3303992855,
        ["g"] = 18,
        ["sublevel"] = 1,
      },
      [12] = {
        ["x"] = 222.77427120344,
        ["y"] = -347.61684106153,
        ["g"] = 18,
        ["sublevel"] = 1,
      },
      [13] = {
        ["x"] = 180.65548205733,
        ["y"] = -349.39654340727,
        ["sublevel"] = 1,
      },
    },
  },
  [13] = {
    ["name"] = "Veteran Sparkcaster",
    ["id"] = 179841,
    ["count"] = 4,
    ["health"] = 191980,
    ["scale"] = 1.3,
    ["displayId"] = 101476,
    ["creatureType"] = "Humanoid",
    ["level"] = 80,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Incapacitate"] = true,
      ["Disorient"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
    },
    ["spells"] = {
      [355641] = {
        ["interruptible"] = true,
      },
      [355642] = {
        ["interruptible"] = true,
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 232.40480053022,
        ["y"] = -421.04241832126,
        ["g"] = 21,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 232.52175991357,
        ["y"] = -396.12660087359,
        ["g"] = 21,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 208.13214377712,
        ["y"] = -426.29551610359,
        ["g"] = 23,
        ["sublevel"] = 1,
        ["disguised"] = true,
      },
      [4] = {
        ["x"] = 201.5267122495,
        ["y"] = -374.62148856228,
        ["g"] = 19,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 207.41479357077,
        ["y"] = -386.33575179049,
        ["g"] = 19,
        ["sublevel"] = 1,
        ["disguised"] = true,
      },
      [6] = {
        ["x"] = 214.40650327865,
        ["y"] = -461.61510124623,
        ["g"] = 24,
        ["sublevel"] = 1,
      },
      [7] = {
        ["x"] = 211.59843316844,
        ["y"] = -351.09025474096,
        ["g"] = 18,
        ["sublevel"] = 1,
      },
    },
  },
  [14] = {
    ["name"] = "Commerce Enforcer",
    ["id"] = 179842,
    ["count"] = 8,
    ["health"] = 324233,
    ["scale"] = 1.5,
    ["displayId"] = 101477,
    ["creatureType"] = "Humanoid",
    ["level"] = 81,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [355477] = {
      },
      [355782] = {
      },
      [355783] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 232.34459174631,
        ["y"] = -408.22213922268,
        ["g"] = 21,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 213.80775292728,
        ["y"] = -437.40440065459,
        ["g"] = 23,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 213.37661504094,
        ["y"] = -376.09890350196,
        ["g"] = 19,
        ["sublevel"] = 1,
      },
    },
  },
  [15] = {
    ["name"] = "Commander Zo'far",
    ["id"] = 179821,
    ["count"] = 24,
    ["health"] = 511947,
    ["scale"] = 2,
    ["displayId"] = 101473,
    ["creatureType"] = "Humanoid",
    ["level"] = 81,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [355473] = {
      },
      [355477] = {
      },
      [355479] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 179.11271068121,
        ["y"] = -408.05627828047,
        ["sublevel"] = 1,
      },
    },
  },
  [16] = {
    ["name"] = "Cartel Muscle",
    ["id"] = 180348,
    ["count"] = 8,
    ["health"] = 319575,
    ["scale"] = 1.3,
    ["displayId"] = 101598,
    ["creatureType"] = "Humanoid",
    ["level"] = 81,
    ["spells"] = {
      [356967] = {
      },
      [357229] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 292.51116211078,
        ["y"] = -327.67620248879,
        ["g"] = 16,
        ["sublevel"] = 1,
        ["disguised"] = true,
      },
      [2] = {
        ["x"] = 338.91498198802,
        ["y"] = -347.10088995359,
        ["g"] = 15,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 363.90713491814,
        ["y"] = -310.05627782975,
        ["g"] = 14,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 429.71980474828,
        ["y"] = -307.21815006649,
        ["g"] = 13,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 399.54835404923,
        ["y"] = -256.27368899404,
        ["g"] = 12,
        ["sublevel"] = 1,
      },
      [6] = {
        ["x"] = 326.92545158917,
        ["y"] = -347.28342456844,
        ["g"] = 15,
        ["sublevel"] = 1,
      },
    },
  },
  [17] = {
    ["name"] = "Cartel Smuggler",
    ["id"] = 180335,
    ["count"] = 5,
    ["health"] = 191745,
    ["scale"] = 1.3,
    ["displayId"] = 101595,
    ["creatureType"] = "Humanoid",
    ["level"] = 80,
    ["characteristics"] = {
      ["Fear"] = true,
      ["Imprison"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
    },
    ["spells"] = {
      [357029] = {
        ["interruptible"] = true,
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 286.54195637234,
        ["y"] = -317.4170695543,
        ["g"] = 16,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 339.91222136504,
        ["y"] = -334.89370535544,
        ["g"] = 15,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 364.70739876811,
        ["y"] = -298.32025348311,
        ["g"] = 14,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 424.00373327914,
        ["y"] = -296.58732564602,
        ["g"] = 13,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 390.46199843365,
        ["y"] = -263.50991737519,
        ["g"] = 12,
        ["sublevel"] = 1,
      },
      [6] = {
        ["x"] = 399.75132953452,
        ["y"] = -271.62143447634,
        ["g"] = 12,
        ["sublevel"] = 1,
        ["inspiring"] = true,
      },
      [7] = {
        ["x"] = 404.14890135957,
        ["y"] = -223.690435903,
        ["g"] = 11,
        ["sublevel"] = 1,
        ["disguised"] = true,
      },
      [8] = {
        ["x"] = 399.01865660864,
        ["y"] = -213.28286593097,
        ["g"] = 11,
        ["sublevel"] = 1,
      },
      [9] = {
        ["x"] = 471.21957132615,
        ["y"] = -233.98729688962,
        ["g"] = 10,
        ["sublevel"] = 1,
      },
    },
  },
  [18] = {
    ["name"] = "Cartel Wiseguy",
    ["id"] = 180336,
    ["count"] = 5,
    ["health"] = 170440,
    ["scale"] = 1.3,
    ["displayId"] = 101596,
    ["creatureType"] = "Humanoid",
    ["level"] = 80,
    ["characteristics"] = {
      ["Silence"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
    },
    ["spells"] = {
      [357196] = {
        ["interruptible"] = true,
      },
      [357197] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 280.93892930718,
        ["y"] = -327.76408620946,
        ["g"] = 16,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 327.61748339109,
        ["y"] = -334.82160593779,
        ["g"] = 15,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 354.35039118744,
        ["y"] = -303.3927032184,
        ["g"] = 14,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 417.7836399513,
        ["y"] = -307.40955290716,
        ["g"] = 13,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 406.62870680677,
        ["y"] = -263.67490001792,
        ["g"] = 12,
        ["sublevel"] = 1,
        ["disguised"] = true,
      },
      [6] = {
        ["x"] = 410.61933455989,
        ["y"] = -213.49867751598,
        ["g"] = 11,
        ["sublevel"] = 1,
      },
      [7] = {
        ["x"] = 459.1359560599,
        ["y"] = -234.31261361506,
        ["g"] = 10,
        ["sublevel"] = 1,
      },
    },
  },
  [19] = {
    ["name"] = "Cartel Skulker",
    ["id"] = 179893,
    ["count"] = 4,
    ["health"] = 213050,
    ["scale"] = 1.3,
    ["displayId"] = 101734,
    ["creatureType"] = "Humanoid",
    ["level"] = 80,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
    },
    ["spells"] = {
      [30831] = {
      },
      [355830] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 331.52503741615,
        ["y"] = -310.6480186118,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 390.05827437414,
        ["y"] = -294.57224775587,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 429.84659657377,
        ["y"] = -222.48366314961,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 496.33687050612,
        ["y"] = -226.09583748342,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 458.45561544668,
        ["y"] = -249.60523328893,
        ["sublevel"] = 1,
      },
      [6] = {
        ["x"] = 287.28499224495,
        ["y"] = -353.84222661626,
        ["sublevel"] = 1,
        ["patrol"] = {
          [1] = {
            ["x"] = 523.90377976758,
            ["y"] = -198.00157511432,
          },
          [2] = {
            ["x"] = 519.55135903103,
            ["y"] = -200.32310312508,
          },
          [3] = {
            ["x"] = 519.55135903103,
            ["y"] = -210.39888637358,
          },
          [4] = {
            ["x"] = 519.55135903103,
            ["y"] = -200.32310312508,
          },
        },
      },
    },
  },
  [20] = {
    ["name"] = "Oasis Security",
    ["id"] = 179269,
    ["count"] = 0,
    ["health"] = 341298,
    ["scale"] = 2,
    ["displayId"] = 101270,
    ["creatureType"] = "Humanoid",
    ["level"] = 81,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [350916] = {
      },
      [350922] = {
        ["interruptible"] = true,
      },
      [353706] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 135.32943075272,
        ["y"] = -107.95517331595,
        ["g"] = 33,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 128.1617637315,
        ["y"] = -90.370714808631,
        ["g"] = 33,
        ["sublevel"] = 1,
      },
    },
  },
  [21] = {
    ["name"] = "Disruptive Patron",
    ["id"] = 176565,
    ["count"] = 0,
    ["health"] = 255974,
    ["scale"] = 2,
    ["displayId"] = 101271,
    ["creatureType"] = "Humanoid",
    ["level"] = 80,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Incapacitate"] = true,
      ["Silence"] = true,
      ["Fear"] = true,
      ["Disorient"] = true,
      ["Imprison"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
    },
    ["spells"] = {
      [353706] = {
      },
      [353783] = {
      },
      [353836] = {
        ["interruptible"] = true,
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 118.29750573812,
        ["y"] = -115.54862506496,
        ["g"] = 33,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 111.62845902713,
        ["y"] = -98.192438941621,
        ["g"] = 33,
        ["sublevel"] = 1,
      },
    },
  },
  [22] = {
    ["name"] = "Brawling Patron",
    ["id"] = 180159,
    ["count"] = 0,
    ["health"] = 170649,
    ["scale"] = 2,
    ["displayId"] = 101546,
    ["creatureType"] = "Humanoid",
    ["level"] = 80,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Incapacitate"] = true,
      ["Silence"] = true,
      ["Disorient"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
    },
    ["spells"] = {
      [348566] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 186.40914634434,
        ["y"] = -56.824021875235,
        ["g"] = 33,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 196.46285765166,
        ["y"] = -71.609535046391,
        ["g"] = 33,
        ["sublevel"] = 1,
      },
    },
  },
  [23] = {
    ["name"] = "Brawling Patron",
    ["id"] = 176562,
    ["count"] = 0,
    ["health"] = 170649,
    ["scale"] = 2,
    ["displayId"] = 101544,
    ["creatureType"] = "Humanoid",
    ["level"] = 80,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Incapacitate"] = true,
      ["Silence"] = true,
      ["Root"] = true,
      ["Disorient"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
    },
    ["spells"] = {
      [348566] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 212.41648619163,
        ["y"] = -63.899954225337,
        ["g"] = 33,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 202.14956241512,
        ["y"] = -47.741584175143,
        ["g"] = 33,
        ["sublevel"] = 1,
      },
    },
  },
  [24] = {
    ["name"] = "Zo'gron",
    ["id"] = 176563,
    ["count"] = 0,
    ["health"] = 958725,
    ["scale"] = 2,
    ["displayId"] = 101481,
    ["creatureType"] = "Humanoid",
    ["level"] = 82,
    ["isBoss"] = true,
    ["encounterID"] = 2452,
    ["instanceID"] = 0,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [350919] = {
      },
      [350922] = {
        ["interruptible"] = true,
      },
      [355438] = {
      },
      [359028] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 165.15522587959,
        ["y"] = -84.907911055161,
        ["g"] = 33,
        ["sublevel"] = 1,
      },
    },
  },
  [25] = {
    ["name"] = "Alcruux",
    ["id"] = 176556,
    ["count"] = 0,
    ["health"] = 511320,
    ["scale"] = 1.6,
    ["displayId"] = 101039,
    ["creatureType"] = "Aberration",
    ["level"] = 82,
    ["isBoss"] = true,
    ["encounterID"] = 2454,
    ["instanceID"] = 0,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [349498] = {
      },
      [349663] = {
      },
      [349797] = {
      },
      [355938] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 259.63156113382,
        ["y"] = -534.10758918015,
        ["g"] = 34,
        ["sublevel"] = 1,
      },
    },
  },
  [26] = {
    ["name"] = "Achillite",
    ["id"] = 176555,
    ["count"] = 0,
    ["health"] = 639150,
    ["scale"] = 1.6,
    ["displayId"] = 101044,
    ["creatureType"] = "Mechanical",
    ["level"] = 82,
    ["isBoss"] = true,
    ["encounterID"] = 2454,
    ["instanceID"] = 0,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [349933] = {
        ["interruptible"] = true,
      },
      [349934] = {
      },
      [349954] = {
      },
      [349987] = {
      },
      [349999] = {
      },
      [350037] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 228.20275521724,
        ["y"] = -537.38533454116,
        ["g"] = 34,
        ["sublevel"] = 1,
      },
    },
  },
  [27] = {
    ["name"] = "Venza Goldfuse",
    ["id"] = 176705,
    ["count"] = 0,
    ["health"] = 766980,
    ["scale"] = 1.6,
    ["displayId"] = 100564,
    ["creatureType"] = "Humanoid",
    ["level"] = 82,
    ["isBoss"] = true,
    ["encounterID"] = 2454,
    ["instanceID"] = 0,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [350086] = {
      },
      [350101] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 245.61420571432,
        ["y"] = -512.89041609107,
        ["g"] = 34,
        ["sublevel"] = 1,
      },
    },
  },
  [28] = {
    ["name"] = "Defective Sorter",
    ["id"] = 176396,
    ["count"] = 3,
    ["health"] = 85325,
    ["scale"] = 1.3,
    ["displayId"] = 100408,
    ["creatureType"] = "Mechanical",
    ["level"] = 80,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Incapacitate"] = true,
      ["Silence"] = true,
      ["Root"] = true,
      ["Fear"] = true,
      ["Disorient"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
    },
    ["spells"] = {
      [347721] = {
      },
      [347814] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 153.42654542288,
        ["y"] = -287.14792427456,
        ["g"] = 30,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 170.49624043731,
        ["y"] = -286.68351248087,
        ["g"] = 30,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 170.90551185571,
        ["y"] = -268.66647470573,
        ["g"] = 30,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 78.150926812607,
        ["y"] = -297.53391543605,
        ["g"] = 31,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 89.252437262447,
        ["y"] = -298.3476763587,
        ["g"] = 31,
        ["sublevel"] = 1,
      },
      [6] = {
        ["x"] = 101.25267175805,
        ["y"] = -298.72639446641,
        ["g"] = 31,
        ["sublevel"] = 1,
      },
      [7] = {
        ["x"] = 62.775772964618,
        ["y"] = -244.02038619616,
        ["g"] = 32,
        ["sublevel"] = 1,
      },
    },
  },
  [29] = {
    ["name"] = "P.O.S.T. Worker",
    ["id"] = 176394,
    ["count"] = 5,
    ["health"] = 213311,
    ["scale"] = 1.3,
    ["displayId"] = 100406,
    ["creatureType"] = "Mechanical",
    ["level"] = 80,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Incapacitate"] = true,
      ["Silence"] = true,
      ["Root"] = true,
      ["Fear"] = true,
      ["Disorient"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
    },
    ["spells"] = {
      [347716] = {
      },
      [348008] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 162.15924805702,
        ["y"] = -296.3764046035,
        ["g"] = 30,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 179.63836907558,
        ["y"] = -277.78229529643,
        ["g"] = 30,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 84.224842435887,
        ["y"] = -287.23265688105,
        ["g"] = 31,
        ["sublevel"] = 1,
        ["disguised"] = true,
      },
      [4] = {
        ["x"] = 51.498089041868,
        ["y"] = -249.28454911126,
        ["g"] = 32,
        ["sublevel"] = 1,
      },
    },
  },
  [30] = {
    ["name"] = "Overloaded Mailemental",
    ["id"] = 176395,
    ["count"] = 5,
    ["health"] = 159984,
    ["scale"] = 1.3,
    ["displayId"] = 68547,
    ["creatureType"] = "Elemental",
    ["level"] = 80,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Silence"] = true,
      ["Root"] = true,
      ["Fear"] = true,
      ["Banish"] = true,
      ["Disorient"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
    },
    ["spells"] = {
      [347775] = {
        ["interruptible"] = true,
      },
      [347903] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 161.99341294622,
        ["y"] = -277.79619360074,
        ["g"] = 30,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 95.449909710607,
        ["y"] = -287.57095083881,
        ["g"] = 31,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 61.105160024858,
        ["y"] = -255.96764266336,
        ["g"] = 32,
        ["sublevel"] = 1,
      },
    },
  },
  [31] = {
    ["name"] = "P.O.S.T. Master",
    ["id"] = 175646,
    ["count"] = 0,
    ["health"] = 1342215,
    ["scale"] = 2,
    ["displayId"] = 100722,
    ["creatureType"] = "Humanoid",
    ["level"] = 82,
    ["isBoss"] = true,
    ["encounterID"] = 2436,
    ["instanceID"] = 0,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [346286] = {
      },
      [346742] = {
      },
      [346947] = {
      },
      [346962] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 117.71989038996,
        ["y"] = -248.94478243596,
        ["sublevel"] = 1,
      },
    },
  },
  [32] = {
    ["name"] = "So'azmi",
    ["id"] = 175806,
    ["count"] = 0,
    ["health"] = 1342215,
    ["scale"] = 2,
    ["displayId"] = 99094,
    ["creatureType"] = "Humanoid",
    ["level"] = 82,
    ["isBoss"] = true,
    ["encounterID"] = 2451,
    ["instanceID"] = 1194,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [347249] = {
      },
      [347610] = {
      },
      [347623] = {
      },
      [347632] = {
      },
      [347636] = {
      },
      [354264] = {
      },
      [357188] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 101.9278832102,
        ["y"] = -407.82902386259,
        ["sublevel"] = 1,
      },
    },
  },
};
