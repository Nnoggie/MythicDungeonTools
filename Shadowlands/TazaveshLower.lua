local MDT = MDT
local L = MDT.L
local dungeonIndex = 37
MDT.dungeonList[dungeonIndex] = L["TazaveshLower"]
MDT.mapInfo[dungeonIndex] = {
  tileFormat = {
    [1] = 15,
  },
  viewportPositionOverrides =
  {
    [1] = {
      zoomScale = 1.5999999046326,
      horizontalPan = 211.38175492652,
      verticalPan = 55.476971331488,
    },
  },
};

local zones = { 1989, 1990, 1991, 1992 }
for _, zone in ipairs(zones) do
  MDT.zoneIdToDungeonIdx[zone] = dungeonIndex
end

MDT.dungeonMaps[dungeonIndex] = {
  [0] = "Brokerdungeonstormheim",
  [1] = "Brokerdungeon_a",
  [2] = "Brokerdungeon_d",
  [3] = "Brokerdungeon_c",
  [4] = "Brokerdungeon_b",
}
MDT.dungeonSubLevels[dungeonIndex] = {
  [1] = L["TazaveshFloor1"],
  [2] = L["TazaveshFloor4"],
  [3] = L["TazaveshFloor3"],
  [4] = L["TazaveshFloor2"],
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
    ["scale"] = 0.8,
    ["displayId"] = 100873,
    ["creatureType"] = "Humanoid",
    ["level"] = 60,
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
      [355891] = {
      },
      [355900] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 698.11859356377,
        ["y"] = -269.51296089385,
        ["g"] = 1,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 698.52869058807,
        ["y"] = -280.13055692149,
        ["g"] = 1,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 664.99849565238,
        ["y"] = -263.45446927374,
        ["g"] = 2,
        ["sublevel"] = 1,
        ["disguised"] = true,
      },
      [4] = {
        ["x"] = 658.49915762309,
        ["y"] = -280.93710925739,
        ["g"] = 3,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 620.37535958112,
        ["y"] = -253.38046175396,
        ["g"] = 6,
        ["sublevel"] = 1,
      },
      [6] = {
        ["x"] = 607.79378078901,
        ["y"] = -263.68958529496,
        ["g"] = 7,
        ["sublevel"] = 1,
        ["inspiring"] = true,
      },
      [7] = {
        ["x"] = 616.49457240277,
        ["y"] = -275.53085281541,
        ["g"] = 8,
        ["sublevel"] = 1,
      },
      [8] = {
        ["x"] = 651.30434548228,
        ["y"] = -249.7936835447,
        ["g"] = 5,
        ["sublevel"] = 1,
      },
      [9] = {
        ["x"] = 634.16590860288,
        ["y"] = -268.27103925741,
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
    ["scale"] = 0.8,
    ["displayId"] = 101505,
    ["creatureType"] = "Humanoid",
    ["level"] = 61,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [352796] = {
      },
      [356548] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 692.07389749702,
        ["y"] = -274.37463687151,
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
    ["scale"] = 0.8,
    ["displayId"] = 100876,
    ["creatureType"] = "Humanoid",
    ["level"] = 60,
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
    },
    ["clones"] = {
      [1] = {
        ["x"] = 657.00715137068,
        ["y"] = -261.46391061453,
        ["g"] = 2,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 644.76496174221,
        ["y"] = -245.97243909947,
        ["g"] = 5,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 632.31866015354,
        ["y"] = -261.66064363705,
        ["g"] = 4,
        ["sublevel"] = 1,
        ["disguised"] = true,
      },
      [4] = {
        ["x"] = 619.28805029422,
        ["y"] = -243.90522867059,
        ["g"] = 6,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 613.14194896298,
        ["y"] = -283.24611790319,
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
    ["scale"] = 0.8,
    ["displayId"] = 100877,
    ["creatureType"] = "Humanoid",
    ["level"] = 60,
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
        ["x"] = 650.18282776143,
        ["y"] = -277.74466089136,
        ["g"] = 3,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 645.76793200298,
        ["y"] = -253.24857233171,
        ["g"] = 5,
        ["sublevel"] = 1,
        ["inspiring"] = true,
      },
      [3] = {
        ["x"] = 612.82502893816,
        ["y"] = -250.29177889249,
        ["g"] = 6,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 600.73443144677,
        ["y"] = -266.18690526278,
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
    ["scale"] = 0.8,
    ["displayId"] = 100874,
    ["creatureType"] = "Humanoid",
    ["level"] = 61,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [352796] = {
      },
      [356001] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 628.17304689452,
        ["y"] = -267.74730778368,
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
        ["x"] = 582.50901674537,
        ["y"] = -282.64237319601,
        ["g"] = 9,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 582.15858119552,
        ["y"] = -272.111783067,
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
    ["scale"] = 1,
    ["displayId"] = 100877,
    ["creatureType"] = "Humanoid",
    ["level"] = 61,
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
        ["x"] = 633.05495041215,
        ["y"] = -235.55133470547,
        ["sublevel"] = 1,
      },
    },
  },
  [7] = {
    ["name"] = "Zo'phex",
    ["id"] = 175616,
    ["count"] = 0,
    ["health"] = 1278300,
    ["scale"] = 1,
    ["displayId"] = 100049,
    ["creatureType"] = "Humanoid",
    ["level"] = 62,
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
        ["x"] = 632.63565716471,
        ["y"] = -212.66416109787,
        ["sublevel"] = 1,
      },
    },
  },
  [8] = {
    ["name"] = "Tracker Zo'korss",
    ["id"] = 179837,
    ["count"] = 18,
    ["health"] = 426623,
    ["scale"] = 1,
    ["stealthDetect"] = true,
    ["displayId"] = 101474,
    ["creatureType"] = "Humanoid",
    ["level"] = 61,
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
        ["x"] = 510.62038140644,
        ["y"] = -301.43631284916,
        ["sublevel"] = 1,
      },
    },
  },
  [9] = {
    ["name"] = "Ancient Core Hound",
    ["id"] = 180091,
    ["count"] = 12,
    ["health"] = 307168,
    ["scale"] = 1,
    ["displayId"] = 101639,
    ["creatureType"] = "Beast",
    ["level"] = 61,
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
        ["x"] = 491.61025029797,
        ["y"] = -327.18955307263,
        ["g"] = 29,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 480.20292014303,
        ["y"] = -332.38608938547,
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
    ["scale"] = 1,
    ["displayId"] = 47441,
    ["creatureType"] = "Beast",
    ["level"] = 60,
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
        ["x"] = 463.53307508939,
        ["y"] = -346.74787709497,
        ["sublevel"] = 1,
      },
    },
  },
  [11] = {
    ["name"] = "Frenzied Nightclaw",
    ["id"] = 180567,
    ["count"] = 4,
    ["health"] = 170649,
    ["scale"] = 0.8,
    ["displayId"] = 101951,
    ["creatureType"] = "Beast",
    ["level"] = 60,
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
        ["x"] = 425.95290447058,
        ["y"] = -332.34764757108,
        ["g"] = 28,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 432.36325139216,
        ["y"] = -330.61030980859,
        ["g"] = 28,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 419.26162097735,
        ["y"] = -328.1569273743,
        ["g"] = 28,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 418.37932061979,
        ["y"] = -321.37290502793,
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
    ["scale"] = 0.8,
    ["displayId"] = 101475,
    ["creatureType"] = "Humanoid",
    ["level"] = 60,
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
        ["x"] = 383.05782261814,
        ["y"] = -312.17098780732,
        ["g"] = 22,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 380.99225748194,
        ["y"] = -318.85408197152,
        ["g"] = 22,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 375.42493236622,
        ["y"] = -300.81372500691,
        ["g"] = 21,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 375.09480778279,
        ["y"] = -295.08599506389,
        ["g"] = 21,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 360.85606965606,
        ["y"] = -312.55737447599,
        ["g"] = 23,
        ["sublevel"] = 1,
      },
      [6] = {
        ["x"] = 370.54052239286,
        ["y"] = -276.91651114672,
        ["g"] = 20,
        ["sublevel"] = 1,
      },
      [7] = {
        ["x"] = 376.12963714045,
        ["y"] = -278.99178128829,
        ["g"] = 20,
        ["sublevel"] = 1,
      },
      [8] = {
        ["x"] = 351.93901670945,
        ["y"] = -334.65907034035,
        ["g"] = 24,
        ["sublevel"] = 1,
      },
      [9] = {
        ["x"] = 330.00536352801,
        ["y"] = -327.95849162011,
        ["g"] = 25,
        ["sublevel"] = 1,
        ["disguised"] = true,
      },
      [10] = {
        ["x"] = 336.54810156554,
        ["y"] = -331.84821982145,
        ["g"] = 25,
        ["sublevel"] = 1,
      },
      [11] = {
        ["x"] = 356.27339179769,
        ["y"] = -265.43167065262,
        ["g"] = 18,
        ["sublevel"] = 1,
      },
      [12] = {
        ["x"] = 358.31855631004,
        ["y"] = -270.37176592475,
        ["g"] = 18,
        ["sublevel"] = 1,
      },
      [13] = {
        ["x"] = 334.92371871275,
        ["y"] = -267.13793296089,
        ["sublevel"] = 1,
      },
    },
  },
  [13] = {
    ["name"] = "Veteran Sparkcaster",
    ["id"] = 179841,
    ["count"] = 4,
    ["health"] = 191980,
    ["scale"] = 0.8,
    ["displayId"] = 101476,
    ["creatureType"] = "Humanoid",
    ["level"] = 60,
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
        ["x"] = 371.48900471746,
        ["y"] = -303.78537077086,
        ["g"] = 21,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 371.54999467691,
        ["y"] = -290.9315415763,
        ["g"] = 21,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 353.90882002384,
        ["y"] = -311.24648044693,
        ["g"] = 23,
        ["sublevel"] = 1,
        ["disguised"] = true,
      },
      [4] = {
        ["x"] = 343.39798499539,
        ["y"] = -282.89710386967,
        ["g"] = 19,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 352.39052924384,
        ["y"] = -278.14165218297,
        ["g"] = 19,
        ["sublevel"] = 1,
        ["disguised"] = true,
      },
      [6] = {
        ["x"] = 356.1701852661,
        ["y"] = -330.08264083451,
        ["g"] = 24,
        ["sublevel"] = 1,
      },
      [7] = {
        ["x"] = 350.88647199046,
        ["y"] = -265.660722993,
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
    ["scale"] = 0.8,
    ["displayId"] = 101477,
    ["creatureType"] = "Humanoid",
    ["level"] = 61,
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
        ["x"] = 367.21836651258,
        ["y"] = -297.34471273293,
        ["g"] = 21,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
      [2] = {
        ["x"] = 358.21364628797,
        ["y"] = -304.32766371573,
        ["g"] = 23,
        ["sublevel"] = 1,
        ["scale"] = 1.3,
        ["patrol"] = {
          [1] = {
            ["x"] = 356.33864170828,
            ["y"] = -312.05841495442,
          },
          [2] = {
            ["x"] = 350.34916876573,
            ["y"] = -321.530611163,
          },
          [3] = {
            ["x"] = 340.03064749404,
            ["y"] = -331.00280737105,
          },
          [4] = {
            ["x"] = 350.34916876573,
            ["y"] = -321.530611163,
          },
        },
      },
      [3] = {
        ["x"] = 350.62141476452,
        ["y"] = -284.45223652222,
        ["g"] = 19,
        ["sublevel"] = 1,
        ["scale"] = 1.3,
        ["patrol"] = {
          [1] = {
            ["x"] = 356.33864170828,
            ["y"] = -290.36218997,
          },
          [2] = {
            ["x"] = 350.34916876573,
            ["y"] = -280.889993761,
          },
          [3] = {
            ["x"] = 340.03064749404,
            ["y"] = -271.41779755295,
          },
          [4] = {
            ["x"] = 350.34916876573,
            ["y"] = -280.889993761,
          },
        },
      },
    },
  },
  [15] = {
    ["name"] = "Commander Zo'far",
    ["id"] = 179821,
    ["count"] = 24,
    ["health"] = 511947,
    ["scale"] = 1,
    ["displayId"] = 101473,
    ["creatureType"] = "Humanoid",
    ["level"] = 61,
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
        ["x"] = 334.0852205006,
        ["y"] = -298.8938547486,
        ["sublevel"] = 1,
      },
    },
  },
  [16] = {
    ["name"] = "Cartel Muscle",
    ["id"] = 180348,
    ["count"] = 8,
    ["health"] = 319575,
    ["scale"] = 0.8,
    ["displayId"] = 101598,
    ["creatureType"] = "Humanoid",
    ["level"] = 61,
    ["spells"] = {
      [356967] = {
      },
      [357229] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 399.09111978456,
        ["y"] = -254.47514759507,
        ["g"] = 16,
        ["sublevel"] = 1,
        ["disguised"] = true,
      },
      [2] = {
        ["x"] = 428.84111080049,
        ["y"] = -265.00069002676,
        ["g"] = 15,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 442.22349545841,
        ["y"] = -246.8999789608,
        ["g"] = 14,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 474.4944192806,
        ["y"] = -238.34566875084,
        ["g"] = 13,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 467.0224395179,
        ["y"] = -207.97514650233,
        ["g"] = 12,
        ["sublevel"] = 1,
        ["patrol"] = {
          [1] = {
            ["x"] = 467.0224395179,
            ["y"] = -207.97514650233,
          },
          [2] = {
            ["x"] = 484.47950068755,
            ["y"] = -196.74015937995,
          },
          [3] = {
            ["x"] = 484.47950068755,
            ["y"] = -184.72582917661,
          },
          [4] = {
            ["x"] = 484.47950068755,
            ["y"] = -196.74015937995,
          },
          [5] = {
            ["x"] = 467.0224395179,
            ["y"] = -207.97514650233,
          },
          [6] = {
            ["x"] = 459.47285920012,
            ["y"] = -227.68776249375,
          },
          [7] = {
            ["x"] = 459.47285920012,
            ["y"] = -250.01062560029,
          },
          [8] = {
            ["x"] = 459.47285920012,
            ["y"] = -227.68776249375,
          },
        },
      },
      [6] = {
        ["x"] = 422.51383891521,
        ["y"] = -266.69618635421,
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
    ["scale"] = 0.8,
    ["displayId"] = 101595,
    ["creatureType"] = "Humanoid",
    ["level"] = 60,
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
        ["x"] = 395.76864679573,
        ["y"] = -248.62723067862,
        ["g"] = 16,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 429.3576544682,
        ["y"] = -258.85043298312,
        ["g"] = 15,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 444.452131433,
        ["y"] = -237.84218807953,
        ["g"] = 14,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 470.74240950719,
        ["y"] = -232.17856200843,
        ["g"] = 13,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 455.53843574756,
        ["y"] = -217.34375387668,
        ["g"] = 12,
        ["sublevel"] = 1,
      },
      [6] = {
        ["x"] = 465.81242774948,
        ["y"] = -221.18027611812,
        ["g"] = 12,
        ["sublevel"] = 1,
        ["inspiring"] = true,
      },
      [7] = {
        ["x"] = 471.65173086681,
        ["y"] = -196.19953805678,
        ["g"] = 11,
        ["sublevel"] = 1,
        ["disguised"] = true,
      },
      [8] = {
        ["x"] = 466.40790042967,
        ["y"] = -190.8481712051,
        ["g"] = 11,
        ["sublevel"] = 1,
      },
      [9] = {
        ["x"] = 500.80686126582,
        ["y"] = -202.09919593218,
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
    ["scale"] = 0.8,
    ["displayId"] = 101596,
    ["creatureType"] = "Humanoid",
    ["level"] = 60,
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
        ["x"] = 391.78306665011,
        ["y"] = -254.56303131574,
        ["g"] = 16,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 422.26973046474,
        ["y"] = -259.42602695824,
        ["g"] = 15,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 439.09451204459,
        ["y"] = -242.55754001943,
        ["g"] = 14,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 467.55764267587,
        ["y"] = -239.42981131574,
        ["g"] = 13,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 462.69098074878,
        ["y"] = -214.56012860493,
        ["g"] = 12,
        ["sublevel"] = 1,
        ["disguised"] = true,
      },
      [6] = {
        ["x"] = 475.1225357883,
        ["y"] = -187.50761715389,
        ["g"] = 11,
        ["sublevel"] = 1,
      },
      [7] = {
        ["x"] = 494.59749497883,
        ["y"] = -202.17456419996,
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
    ["scale"] = 0.8,
    ["displayId"] = 101734,
    ["creatureType"] = "Humanoid",
    ["level"] = 60,
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
        ["x"] = 397.25835569669,
        ["y"] = -268.45419357553,
        ["sublevel"] = 1,
        ["patrol"] = {
          [1] = {
            ["x"] = 397.25835569669,
            ["y"] = -268.45419357553,
          },
          [2] = {
            ["x"] = 403.09126882,
            ["y"] = -261.691445109,
          },
          [3] = {
            ["x"] = 408.92418194262,
            ["y"] = -254.92869664287,
          },
        },
      },
      [2] = {
        ["x"] = 427.68430440106,
        ["y"] = -250.87885648057,
        ["sublevel"] = 1,
        ["patrol"] = {
          [1] = {
            ["x"] = 427.68430440106,
            ["y"] = -250.87885648057,
          },
          [2] = {
            ["x"] = 422.29464720923,
            ["y"] = -258.12597991712,
          },
          [3] = {
            ["x"] = 408.05220863596,
            ["y"] = -268.8804816052,
          },
          [4] = {
            ["x"] = 422.29464720923,
            ["y"] = -258.12597991712,
          },
        },
      },
      [3] = {
        ["x"] = 455.84904613314,
        ["y"] = -229.99408453314,
        ["sublevel"] = 1,
        ["patrol"] = {
          [1] = {
            ["x"] = 455.84904613314,
            ["y"] = -229.99408453314,
          },
          [2] = {
            ["x"] = 455.30096211225,
            ["y"] = -235.98387929438,
          },
          [3] = {
            ["x"] = 449.48772773335,
            ["y"] = -237.14653115971,
          },
          [4] = {
            ["x"] = 455.30096211225,
            ["y"] = -235.98387929438,
          },
          [5] = {
            ["x"] = 462.05020809223,
            ["y"] = -232.78659602013,
          },
          [6] = {
            ["x"] = 462.05020809223,
            ["y"] = -226.24670266616,
          },
          [7] = {
            ["x"] = 473.17667685004,
            ["y"] = -208.80696834477,
          },
          [8] = {
            ["x"] = 477.24596461562,
            ["y"] = -208.80696834477,
          },
          [9] = {
            ["x"] = 473.17667685004,
            ["y"] = -208.80696834477,
          },
          [10] = {
            ["x"] = 463.87549934901,
            ["y"] = -208.95229515024,
          },
          [11] = {
            ["x"] = 458.64358466584,
            ["y"] = -211.56825872876,
          },
          [12] = {
            ["x"] = 455.84904613314,
            ["y"] = -215.49220097808,
          },
        },
      },
      [4] = {
        ["x"] = 488.83791543002,
        ["y"] = -193.97487316114,
        ["sublevel"] = 1,
        ["patrol"] = {
          [1] = {
            ["x"] = 488.83791543002,
            ["y"] = -193.97487316114,
          },
          [2] = {
            ["x"] = 489.411526336,
            ["y"] = -200.733571173,
          },
          [3] = {
            ["x"] = 489.98513724104,
            ["y"] = -207.49226918413,
          },
        },
      },
      [5] = {
        ["x"] = 493.51948521735,
        ["y"] = -210.11582463089,
        ["sublevel"] = 1,
        ["patrol"] = {
          [1] = {
            ["x"] = 493.51948521735,
            ["y"] = -210.11582463089,
          },
          [2] = {
            ["x"] = 504.11557149944,
            ["y"] = -210.23816983497,
          },
          [3] = {
            ["x"] = 504.11557149944,
            ["y"] = -196.022935075,
          },
          [4] = {
            ["x"] = 504.11557149944,
            ["y"] = -210.23816983497,
          },
        },
      },
      [6] = {
        ["x"] = 523.90377976758,
        ["y"] = -198.00157511432,
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
    ["level"] = 61,
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
        ["x"] = 314.29562316528,
        ["y"] = -139.62165669745,
        ["g"] = 33,
        ["sublevel"] = 1,
        ["scale"] = 0.5,
      },
      [2] = {
        ["x"] = 307.80965802857,
        ["y"] = -130.89968650243,
        ["g"] = 33,
        ["sublevel"] = 1,
        ["scale"] = 0.5,
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
    ["level"] = 60,
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
        ["x"] = 306.58071097922,
        ["y"] = -142.89746510156,
        ["g"] = 33,
        ["sublevel"] = 1,
        ["scale"] = 0.5,
      },
      [2] = {
        ["x"] = 302.63858095037,
        ["y"] = -135.53999369128,
        ["g"] = 33,
        ["sublevel"] = 1,
        ["scale"] = 0.5,
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
    ["level"] = 60,
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
        ["x"] = 342.42364550068,
        ["y"] = -110.30594785795,
        ["g"] = 33,
        ["sublevel"] = 1,
        ["scale"] = 0.5,
      },
      [2] = {
        ["x"] = 340.75158003617,
        ["y"] = -121.6372930372,
        ["g"] = 33,
        ["sublevel"] = 1,
        ["scale"] = 0.5,
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
    ["level"] = 60,
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
        ["x"] = 347.75174489326,
        ["y"] = -117.60911821193,
        ["g"] = 33,
        ["sublevel"] = 1,
        ["scale"] = 0.5,
      },
      [2] = {
        ["x"] = 336.12139309349,
        ["y"] = -113.72196418478,
        ["g"] = 33,
        ["sublevel"] = 1,
        ["scale"] = 0.5,
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
    ["level"] = 62,
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
        ["x"] = 324.80569603483,
        ["y"] = -126.80038903595,
        ["g"] = 33,
        ["sublevel"] = 1,
        ["scale"] = 0.5,
      },
    },
  },
  [25] = {
    ["name"] = "Alcruux",
    ["id"] = 176556,
    ["count"] = 0,
    ["health"] = 511320,
    ["scale"] = 2,
    ["displayId"] = 101039,
    ["creatureType"] = "Aberration",
    ["level"] = 62,
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
        ["x"] = 391.23990571436,
        ["y"] = -372.12788172412,
        ["g"] = 34,
        ["sublevel"] = 1,
        ["scale"] = 0.5,
      },
    },
  },
  [26] = {
    ["name"] = "Achillite",
    ["id"] = 176555,
    ["count"] = 0,
    ["health"] = 639150,
    ["scale"] = 2,
    ["displayId"] = 101044,
    ["creatureType"] = "Mechanical",
    ["level"] = 62,
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
        ["x"] = 370.30981482273,
        ["y"] = -382.40475709526,
        ["g"] = 34,
        ["sublevel"] = 1,
        ["scale"] = 0.5,
      },
    },
  },
  [27] = {
    ["name"] = "Venza Goldfuse",
    ["id"] = 176705,
    ["count"] = 0,
    ["health"] = 766980,
    ["scale"] = 2,
    ["displayId"] = 100564,
    ["creatureType"] = "Humanoid",
    ["level"] = 62,
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
        ["x"] = 388.72121916885,
        ["y"] = -387.40618941051,
        ["g"] = 34,
        ["sublevel"] = 1,
        ["scale"] = 0.5,
      },
    },
  },
  [28] = {
    ["name"] = "Defective Sorter",
    ["id"] = 176396,
    ["count"] = 3,
    ["health"] = 85325,
    ["scale"] = 2,
    ["displayId"] = 100408,
    ["creatureType"] = "Mechanical",
    ["level"] = 60,
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
        ["x"] = 300.40817101869,
        ["y"] = -217.04882051267,
        ["g"] = 30,
        ["sublevel"] = 1,
        ["scale"] = 0.5,
      },
      [2] = {
        ["x"] = 313.93932960761,
        ["y"] = -215.04236630559,
        ["g"] = 30,
        ["sublevel"] = 1,
        ["scale"] = 0.5,
      },
      [3] = {
        ["x"] = 308.79735049973,
        ["y"] = -202.20325176861,
        ["g"] = 30,
        ["sublevel"] = 1,
        ["scale"] = 0.5,
      },
      [4] = {
        ["x"] = 264.33782554449,
        ["y"] = -234.66107530328,
        ["g"] = 31,
        ["sublevel"] = 1,
        ["scale"] = 0.5,
      },
      [5] = {
        ["x"] = 271.5761686572,
        ["y"] = -237.74730115456,
        ["g"] = 31,
        ["sublevel"] = 1,
        ["scale"] = 0.5,
      },
      [6] = {
        ["x"] = 280.67751566121,
        ["y"] = -238.86917348118,
        ["g"] = 31,
        ["sublevel"] = 1,
        ["scale"] = 0.5,
      },
      [7] = {
        ["x"] = 255.33831052958,
        ["y"] = -202.15865078762,
        ["g"] = 32,
        ["sublevel"] = 1,
        ["scale"] = 0.5,
      },
    },
  },
  [29] = {
    ["name"] = "P.O.S.T. Worker",
    ["id"] = 176394,
    ["count"] = 5,
    ["health"] = 213311,
    ["scale"] = 2,
    ["displayId"] = 100406,
    ["creatureType"] = "Mechanical",
    ["level"] = 60,
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
        ["x"] = 309.14087365283,
        ["y"] = -219.68720469521,
        ["g"] = 30,
        ["sublevel"] = 1,
        ["scale"] = 0.5,
      },
      [2] = {
        ["x"] = 315.17668581357,
        ["y"] = -207.74808465037,
        ["g"] = 30,
        ["sublevel"] = 1,
        ["scale"] = 0.5,
      },
      [3] = {
        ["x"] = 271.77521769953,
        ["y"] = -228.2229719583,
        ["g"] = 31,
        ["sublevel"] = 1,
        ["scale"] = 0.5,
        ["disguised"] = true,
      },
      [4] = {
        ["x"] = 249.22125757572,
        ["y"] = -207.42279649003,
        ["g"] = 32,
        ["sublevel"] = 1,
        ["scale"] = 0.5,
      },
    },
  },
  [30] = {
    ["name"] = "Overloaded Mailemental",
    ["id"] = 176395,
    ["count"] = 5,
    ["health"] = 159984,
    ["scale"] = 2,
    ["displayId"] = 68547,
    ["creatureType"] = "Elemental",
    ["level"] = 60,
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
        ["x"] = 306.47531135528,
        ["y"] = -210.87850678299,
        ["g"] = 30,
        ["sublevel"] = 1,
        ["scale"] = 0.5,
      },
      [2] = {
        ["x"] = 278.90990388747,
        ["y"] = -229.92474244781,
        ["g"] = 31,
        ["sublevel"] = 1,
        ["scale"] = 0.5,
      },
      [3] = {
        ["x"] = 251.0873778022,
        ["y"] = -214.26716433203,
        ["g"] = 32,
        ["sublevel"] = 1,
        ["scale"] = 0.5,
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
    ["level"] = 62,
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
        ["x"] = 278.76228314667,
        ["y"] = -203.88794944968,
        ["sublevel"] = 1,
        ["scale"] = 0.5,
      },
    },
  },
  [32] = {
    ["name"] = "So'azmi",
    ["id"] = 175806,
    ["count"] = 0,
    ["health"] = 1342215,
    ["scale"] = 1,
    ["displayId"] = 99094,
    ["creatureType"] = "Humanoid",
    ["level"] = 62,
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
        ["x"] = 287.40464839094,
        ["y"] = -299.84262569832,
        ["sublevel"] = 1,
      },
    },
  },
  [33] = {
    ["name"] = "Wo Relic",
    ["id"] = 185683,
    ["count"] = 0,
    ["health"] = 27566,
    ["ignoreFortified"] = true,
    ["scale"] = 1,
    ["displayId"] = 101046,
    ["iconTexture"] = 4335644,
    ["creatureType"] = "Mechanical",
    ["level"] = 62,
    ["bonusSpell"] = 368241,
    ["badCreatureModel"] = true,
    ["modelPosition"] = {
      [1] = 0,
      [2] = 0,
      [3] = 0.6,
    },
    ["include"] = {
      ["level"] = 10,
      ["affix"] = 130,
    },
    ["spells"] = {
      [366566] = {
      },
      [368078] = {
      },
      [368079] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 641.60858562211,
        ["y"] = -278.78004993085,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 613.36411701856,
        ["y"] = -236.01289530378,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 631.86578805616,
        ["y"] = -195.45175198784,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 616.19718411091,
        ["y"] = -291.91735140597,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 456.4494265173,
        ["y"] = -192.04056372484,
        ["sublevel"] = 1,
      },
      [6] = {
        ["x"] = 339.59395973842,
        ["y"] = -172.76671858891,
        ["sublevel"] = 2,
      },
      [7] = {
        ["x"] = 442.96753502932,
        ["y"] = -317.44036260706,
        ["sublevel"] = 1,
      },
      [8] = {
        ["x"] = 474.65064390694,
        ["y"] = -210.62633543511,
        ["sublevel"] = 1,
      },
      [9] = {
        ["x"] = 363.04721474973,
        ["y"] = -282.19039641437,
        ["sublevel"] = 1,
      },
      [10] = {
        ["x"] = 319.48896380118,
        ["y"] = -328.15039916453,
        ["sublevel"] = 1,
      },
      [11] = {
        ["x"] = 467.60761057646,
        ["y"] = -418.05998047924,
        ["sublevel"] = 4,
      },
      [12] = {
        ["x"] = 268.43935788406,
        ["y"] = -297.87726630841,
        ["sublevel"] = 1,
      },
      [13] = {
        ["x"] = 417.83132003211,
        ["y"] = -338.86358445476,
        ["sublevel"] = 1,
      },
    },
  },
  [34] = {
    ["name"] = "Urh Relic",
    ["id"] = 185685,
    ["count"] = 0,
    ["health"] = 27566,
    ["ignoreFortified"] = true,
    ["scale"] = 1,
    ["displayId"] = 105134,
    ["iconTexture"] = 4335642,
    ["creatureType"] = "Mechanical",
    ["level"] = 62,
    ["bonusSpell"] = 368239,
    ["badCreatureModel"] = true,
    ["modelPosition"] = {
      [1] = 0,
      [2] = 0,
      [3] = 0.75,
    },
    ["include"] = {
      ["level"] = 10,
      ["affix"] = 130,
    },
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [366288] = {
      },
      [366297] = {
      },
      [368077] = {
      },
      [368243] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 648.23651150928,
        ["y"] = -287.61726781321,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 605.92227664269,
        ["y"] = -242.64080123032,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 614.03970572277,
        ["y"] = -212.0822035055,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 623.24233144173,
        ["y"] = -282.63161864697,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 463.75849368963,
        ["y"] = -185.22661202823,
        ["sublevel"] = 1,
      },
      [6] = {
        ["x"] = 350.79306072001,
        ["y"] = -164.19753072183,
        ["sublevel"] = 2,
      },
      [7] = {
        ["x"] = 461.3148462486,
        ["y"] = -313.02212476499,
        ["sublevel"] = 1,
      },
      [8] = {
        ["x"] = 489.91382567022,
        ["y"] = -214.57375676083,
        ["sublevel"] = 1,
      },
      [9] = {
        ["x"] = 368.92224010336,
        ["y"] = -274.19036394474,
        ["sublevel"] = 1,
      },
      [10] = {
        ["x"] = 325.23893382982,
        ["y"] = -337.27540384606,
        ["sublevel"] = 1,
      },
      [11] = {
        ["x"] = 495.53264304076,
        ["y"] = -419.39749839843,
        ["sublevel"] = 4,
      },
      [12] = {
        ["x"] = 274.89100208942,
        ["y"] = -310.94180567765,
        ["sublevel"] = 1,
      },
      [13] = {
        ["x"] = 411.20669284215,
        ["y"] = -332.41327748378,
        ["sublevel"] = 1,
      },
    },
  },
  [35] = {
    ["name"] = "Vy Relic",
    ["id"] = 185680,
    ["count"] = 0,
    ["health"] = 27566,
    ["ignoreFortified"] = true,
    ["scale"] = 1,
    ["displayId"] = 103111,
    ["iconTexture"] = 4335643,
    ["creatureType"] = "Mechanical",
    ["level"] = 62,
    ["bonusSpell"] = 368240,
    ["badCreatureModel"] = true,
    ["modelPosition"] = {
      [1] = 0,
      [2] = 0,
      [3] = 0.75,
    },
    ["include"] = {
      ["level"] = 10,
      ["affix"] = 130,
    },
    ["spells"] = {
      [366406] = {
      },
      [366409] = {
      },
      [368103] = {
      },
      [368104] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 657.88765386066,
        ["y"] = -289.82658974935,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 603.94553592155,
        ["y"] = -252.40824416951,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 647.30059009924,
        ["y"] = -212.51698258823,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 604.97270259034,
        ["y"] = -285.08060455454,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 469.61271810707,
        ["y"] = -179.28546710681,
        ["sublevel"] = 1,
      },
      [6] = {
        ["x"] = 364.57871076337,
        ["y"] = -163.61402932255,
        ["sublevel"] = 2,
      },
      [7] = {
        ["x"] = 479.05688165699,
        ["y"] = -316.57051800301,
        ["sublevel"] = 1,
      },
      [8] = {
        ["x"] = 506.49279195504,
        ["y"] = -211.67902629602,
        ["sublevel"] = 1,
      },
      [9] = {
        ["x"] = 378.54720859276,
        ["y"] = -274.44039949286,
        ["sublevel"] = 1,
      },
      [10] = {
        ["x"] = 334.7389542826,
        ["y"] = -340.90040967404,
        ["sublevel"] = 1,
      },
      [11] = {
        ["x"] = 514.64508684717,
        ["y"] = -396.02260083028,
        ["sublevel"] = 4,
      },
      [12] = {
        ["x"] = 274.89097440209,
        ["y"] = -284.32889100166,
        ["sublevel"] = 1,
      },
      [13] = {
        ["x"] = 409.46337094747,
        ["y"] = -323.34797769537,
        ["sublevel"] = 1,
      },
    },
  },
  [36] = {
    ["name"] = "Nathrezim Infiltrator",
    ["id"] = 189878,
    ["count"] = 3,
    ["health"] = 261167,
    ["scale"] = 1.2,
    ["displayId"] = 101016,
    ["creatureType"] = "Demon",
    ["level"] = 61,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [373364] = {
      },
      [373370] = {
      },
      [373391] = {
      },
      [373429] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 632.31866015354,
        ["y"] = -261.66064363705,
        ["g"] = 4,
        ["sublevel"] = 1,
        ["scale"] = 0.8,
        ["shrouded"] = true,
      },
      [2] = {
        ["x"] = 426.10033900562,
        ["y"] = -324.79442694978,
        ["g"] = 28,
        ["sublevel"] = 1,
        ["scale"] = 0.8,
        ["shrouded"] = true,
      },
      [3] = {
        ["x"] = 376.99295745706,
        ["y"] = -358.16337155465,
        ["sublevel"] = 1,
        ["scale"] = 0.8,
        ["shrouded"] = true,
      },
      [4] = {
        ["x"] = 330.00536352801,
        ["y"] = -327.95849162011,
        ["g"] = 25,
        ["sublevel"] = 1,
        ["scale"] = 0.8,
        ["shrouded"] = true,
      },
      [5] = {
        ["x"] = 353.90882002384,
        ["y"] = -311.24648044693,
        ["g"] = 23,
        ["sublevel"] = 1,
        ["scale"] = 0.7,
        ["shrouded"] = true,
      },
      [6] = {
        ["x"] = 349.0732058309,
        ["y"] = -277.70891691883,
        ["g"] = 19,
        ["sublevel"] = 1,
        ["scale"] = 0.7,
        ["shrouded"] = true,
      },
      [7] = {
        ["x"] = 271.77521769953,
        ["y"] = -228.2229719583,
        ["g"] = 31,
        ["sublevel"] = 1,
        ["scale"] = 0.8,
        ["shrouded"] = true,
      },
      [8] = {
        ["x"] = 363.33146150204,
        ["y"] = -172.88177293298,
        ["sublevel"] = 1,
        ["scale"] = 0.8,
        ["shrouded"] = true,
      },
      [9] = {
        ["x"] = 334.85501178455,
        ["y"] = -150.4005367927,
        ["sublevel"] = 1,
        ["scale"] = 0.8,
        ["shrouded"] = true,
      },
      [10] = {
        ["x"] = 471.65173086681,
        ["y"] = -196.19953805678,
        ["g"] = 11,
        ["sublevel"] = 1,
        ["scale"] = 0.8,
        ["shrouded"] = true,
      },
      [11] = {
        ["x"] = 446.75995518067,
        ["y"] = -315.23678576772,
        ["sublevel"] = 1,
        ["scale"] = 0.8,
        ["shrouded"] = true,
      },
      [12] = {
        ["x"] = 478.0580361773,
        ["y"] = -304.56370562997,
        ["sublevel"] = 1,
        ["scale"] = 0.8,
        ["shrouded"] = true,
      },
      [13] = {
        ["x"] = 232.48843058711,
        ["y"] = -178.94424691233,
        ["sublevel"] = 1,
        ["scale"] = 0.8,
        ["shrouded"] = true,
      },
      [14] = {
        ["x"] = 422.04037868945,
        ["y"] = -131.60883050281,
        ["sublevel"] = 1,
        ["scale"] = 0.8,
        ["shrouded"] = true,
      },
      [15] = {
        ["x"] = 399.09111978456,
        ["y"] = -254.47514759507,
        ["g"] = 16,
        ["sublevel"] = 1,
        ["scale"] = 0.7,
        ["shrouded"] = true,
      },
      [16] = {
        ["x"] = 664.99849565238,
        ["y"] = -263.45446927374,
        ["g"] = 2,
        ["sublevel"] = 1,
        ["scale"] = 0.8,
        ["shrouded"] = true,
      },
      [17] = {
        ["x"] = 462.69098074878,
        ["y"] = -214.56012860493,
        ["g"] = 12,
        ["sublevel"] = 1,
        ["scale"] = 0.8,
        ["shrouded"] = true,
      },
    },
  },
  [37] = {
    ["name"] = "Zul'gamux",
    ["id"] = 190128,
    ["count"] = 9,
    ["health"] = 639150,
    ["scale"] = 1.8,
    ["displayId"] = 101106,
    ["creatureType"] = "Demon",
    ["level"] = 61,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [373509] = {
      },
      [373513] = {
      },
      [373552] = {
      },
      [373570] = {
      },
      [373607] = {
      },
      [373724] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 582.15858119552,
        ["y"] = -272.111783067,
        ["g"] = 9,
        ["sublevel"] = 1,
        ["scale"] = 0.6,
        ["shrouded"] = true,
      },
    },
  },
};
