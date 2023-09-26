local MDT = MDT
local L = MDT.L
local dungeonIndex = 34
MDT.dungeonList[dungeonIndex] = L["Spires of Ascension"]
MDT.mapInfo[dungeonIndex] = {
  viewportPositionOverrides =
  {
    [1] = {
      zoomScale = 2.1999998092651,
      horizontalPan = 306.3520744598,
      verticalPan = 67.483489557154,
    },
    [3] = {
      zoomScale = 1.8999998569489,
      horizontalPan = 187.55799437121,
      verticalPan = 173.33103552728,
    },
    [4] = {
      zoomScale = 2.7999997138977,
      horizontalPan = 213.62455400331,
      verticalPan = 261.78908025446,
    },
  }
};

local zones = { 1692, 1693, 1694, 1695 }
for _, zone in ipairs(zones) do
  MDT.zoneIdToDungeonIdx[zone] = dungeonIndex
end

MDT.scaleMultiplier[dungeonIndex] = 1.3

MDT.dungeonMaps[dungeonIndex] = {
  [0] = "SpiresOfAscension_A",
  [1] = "SpiresOfAscension_A",
  [2] = "SpiresOfAscension_B",
  [3] = "SpiresOfAscension_C",
  [4] = "SpiresOfAscension_D",
}
MDT.dungeonSubLevels[dungeonIndex] = {
  [1] = L["Honor's Ascent"],
  [2] = L["Gardens of Repose"],
  [3] = L["Font of Fealty"],
  [4] = L["Seat of the Archon"],
}

MDT.dungeonTotalCount[dungeonIndex] = { normal = 285, teeming = 1000, teemingEnabled = true }

MDT.mapPOIs[dungeonIndex] = {
  [1] = {
    [1] = {
      ["template"] = "MapLinkPinTemplate",
      ["type"] = "mapLink",
      ["x"] = 610.4211751383,
      ["y"] = -95.008076613696,
      ["target"] = 2,
      ["direction"] = 1,
      ["connectionIndex"] = 1,
    },
  },
  [2] = {
    [1] = {
      ["template"] = "MapLinkPinTemplate",
      ["type"] = "mapLink",
      ["x"] = 308.77461659958,
      ["y"] = -345.19250667244,
      ["target"] = 1,
      ["direction"] = -1,
      ["connectionIndex"] = 1,
    },
    [2] = {
      ["template"] = "MapLinkPinTemplate",
      ["type"] = "mapLink",
      ["x"] = 589.0447126466,
      ["y"] = -228.01752388311,
      ["target"] = 3,
      ["direction"] = 1,
      ["connectionIndex"] = 2,
    },
  },
  [3] = {
    [1] = {
      ["template"] = "MapLinkPinTemplate",
      ["type"] = "mapLink",
      ["x"] = 322.23401673653,
      ["y"] = -437.03235988446,
      ["target"] = 2,
      ["direction"] = -1,
      ["connectionIndex"] = 2,
    },
    [2] = {
      ["template"] = "MapLinkPinTemplate",
      ["type"] = "mapLink",
      ["x"] = 427.53313417727,
      ["y"] = -247.81058749468,
      ["target"] = 4,
      ["direction"] = 1,
      ["connectionIndex"] = 3,
    },
  },
  [4] = {
    [1] = {
      ["template"] = "MapLinkPinTemplate",
      ["type"] = "mapLink",
      ["x"] = 349.15247723985,
      ["y"] = -404.57176546128,
      ["target"] = 3,
      ["direction"] = -1,
      ["connectionIndex"] = 3,
    },
  },
};

MDT.dungeonEnemies[dungeonIndex] = {
  [1] = {
    ["name"] = "Forsworn Mender",
    ["id"] = 163459,
    ["count"] = 4,
    ["health"] = 132156,
    ["scale"] = 1,
    ["displayId"] = 94304,
    ["creatureType"] = "Humanoid",
    ["level"] = 60,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Incapacitate"] = true,
      ["Silence"] = true,
      ["Mind Control"] = true,
      ["Polymorph"] = true,
      ["Root"] = true,
      ["Fear"] = true,
      ["Disorient"] = true,
      ["Repentance"] = true,
      ["Imprison"] = true,
      ["Sap"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
    },
    ["spells"] = {
      [317936] = {
        ["interruptible"] = true,
      },
      [327332] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 436.44557640296,
        ["y"] = -286.73511030461,
        ["g"] = 1,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 584.29408095585,
        ["y"] = -118.24636426947,
        ["g"] = 3,
        ["sublevel"] = 1,
        ["inspiring"] = true,
      },
      [3] = {
        ["x"] = 340.76680878558,
        ["y"] = -335.34629822493,
        ["g"] = 4,
        ["sublevel"] = 2,
        ["inspiring"] = true,
      },
    },
  },
  [2] = {
    ["name"] = "Forsworn Vanguard",
    ["id"] = 163457,
    ["count"] = 4,
    ["health"] = 165195,
    ["scale"] = 1,
    ["displayId"] = 93491,
    ["creatureType"] = "Humanoid",
    ["level"] = 60,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Incapacitate"] = true,
      ["Silence"] = true,
      ["Mind Control"] = true,
      ["Polymorph"] = true,
      ["Root"] = true,
      ["Fear"] = true,
      ["Disorient"] = true,
      ["Repentance"] = true,
      ["Imprison"] = true,
      ["Sap"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
    },
    ["spells"] = {
      [317943] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 420.98967344245,
        ["y"] = -284.54584323099,
        ["g"] = 1,
        ["sublevel"] = 1,
        ["inspiring"] = true,
      },
      [2] = {
        ["x"] = 421.5177455961,
        ["y"] = -269.13781521478,
        ["g"] = 1,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 485.61606268064,
        ["y"] = -222.28779026348,
        ["g"] = 2,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 598.78040928345,
        ["y"] = -119.93768263112,
        ["g"] = 3,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 350.92810338517,
        ["y"] = -328.88668465738,
        ["g"] = 4,
        ["sublevel"] = 2,
      },
      [6] = {
        ["x"] = 353.19505734505,
        ["y"] = -339.18716669452,
        ["g"] = 4,
        ["sublevel"] = 2,
      },
    },
  },
  [3] = {
    ["name"] = "Forsworn Goliath",
    ["id"] = 168318,
    ["count"] = 8,
    ["health"] = 264312,
    ["scale"] = 1.5,
    ["displayId"] = 92664,
    ["creatureType"] = "Mechanical",
    ["level"] = 60,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [327413] = {
        ["interruptible"] = true,
      },
      [327416] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 532.69180187707,
        ["y"] = -174.12328302357,
        ["sublevel"] = 1,
        ["patrol"] = {
          [1] = {
            ["x"] = 532.69180187707,
            ["y"] = -174.12328302357,
          },
          [2] = {
            ["x"] = 552.01294864746,
            ["y"] = -151.4845146272,
          },
          [3] = {
            ["x"] = 570.36652325698,
            ["y"] = -132.05133433443,
          },
          [4] = {
            ["x"] = 578.64364430707,
            ["y"] = -124.13412302974,
          },
          [5] = {
            ["x"] = 570.36652325698,
            ["y"] = -132.05133433443,
          },
          [6] = {
            ["x"] = 552.01294864746,
            ["y"] = -151.4845146272,
          },
          [7] = {
            ["x"] = 532.69180187707,
            ["y"] = -174.12328302357,
          },
          [8] = {
            ["x"] = 512.06695149042,
            ["y"] = -193.94967922852,
          },
          [9] = {
            ["x"] = 495.87261913565,
            ["y"] = -210.8637538535,
          },
          [10] = {
            ["x"] = 473.92028684272,
            ["y"] = -230.29694959039,
          },
          [11] = {
            ["x"] = 452.68768137588,
            ["y"] = -252.24927416127,
          },
          [12] = {
            ["x"] = 445.13034892837,
            ["y"] = -259.80663749702,
          },
          [13] = {
            ["x"] = 452.68768137588,
            ["y"] = -252.24927416127,
          },
          [14] = {
            ["x"] = 473.92028684272,
            ["y"] = -230.29694959039,
          },
          [15] = {
            ["x"] = 495.87261913565,
            ["y"] = -210.8637538535,
          },
          [16] = {
            ["x"] = 512.06695149042,
            ["y"] = -193.94967922852,
          },
        },
      },
      [2] = {
        ["x"] = 339.69233208438,
        ["y"] = -321.53989886265,
        ["g"] = 4,
        ["sublevel"] = 2,
      },
      [3] = {
        ["x"] = 449.11123915465,
        ["y"] = -496.33600161548,
        ["g"] = 12,
        ["sublevel"] = 2,
      },
      [4] = {
        ["x"] = 434.3612567137,
        ["y"] = -489.06296375264,
        ["g"] = 12,
        ["sublevel"] = 2,
      },
      [5] = {
        ["x"] = 638.3643389787,
        ["y"] = -426.36915937991,
        ["g"] = 16,
        ["sublevel"] = 2,
        ["patrol"] = {
        },
      },
      [6] = {
        ["x"] = 493.1330710124,
        ["y"] = -56.066082968468,
        ["g"] = 21,
        ["sublevel"] = 2,
      },
      [7] = {
        ["x"] = 365.61475173587,
        ["y"] = -360.18714634998,
        ["g"] = 26,
        ["sublevel"] = 3,
      },
      [8] = {
        ["x"] = 379.02532322416,
        ["y"] = -310.13797089349,
        ["g"] = 27,
        ["sublevel"] = 3,
      },
    },
  },
  [4] = {
    ["name"] = "Forsworn Castigator",
    ["id"] = 163458,
    ["count"] = 4,
    ["health"] = 165195,
    ["scale"] = 1,
    ["displayId"] = 93483,
    ["creatureType"] = "Humanoid",
    ["level"] = 60,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Incapacitate"] = true,
      ["Silence"] = true,
      ["Mind Control"] = true,
      ["Polymorph"] = true,
      ["Root"] = true,
      ["Fear"] = true,
      ["Disorient"] = true,
      ["Repentance"] = true,
      ["Imprison"] = true,
      ["Sap"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
    },
    ["spells"] = {
      [317959] = {
        ["interruptible"] = true,
      },
      [317963] = {
        ["interruptible"] = true,
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 498.09187919822,
        ["y"] = -222.78149411528,
        ["g"] = 2,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 484.4837359017,
        ["y"] = -209.2778343411,
        ["g"] = 2,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 582.83666014353,
        ["y"] = -103.24849790581,
        ["g"] = 3,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 352.7291954023,
        ["y"] = -319.29724137931,
        ["g"] = 4,
        ["sublevel"] = 2,
      },
    },
  },
  [5] = {
    ["name"] = "Azules",
    ["id"] = 163077,
    ["count"] = 0,
    ["health"] = 1718028,
    ["scale"] = 1,
    ["displayId"] = 93471,
    ["creatureType"] = "Beast",
    ["level"] = 60,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [324368] = {
      },
      [331249] = {
      },
      [345561] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 402.91236819007,
        ["y"] = -311.93486091078,
        ["g"] = 5,
        ["sublevel"] = 2,
      },
    },
  },
  [6] = {
    ["name"] = "Kin-Tara",
    ["id"] = 162059,
    ["count"] = 0,
    ["health"] = 1321934,
    ["scale"] = 1,
    ["displayId"] = 95068,
    ["creatureType"] = "Humanoid",
    ["level"] = 60,
    ["isBoss"] = true,
    ["encounterID"] = 2399,
    ["instanceID"] = 1186,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [320966] = {
      },
      [321009] = {
      },
      [327481] = {
      },
      [345561] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 385.56093065893,
        ["y"] = -312.88775031273,
        ["g"] = 5,
        ["sublevel"] = 2,
      },
    },
  },
  [7] = {
    ["name"] = "Etherdiver",
    ["id"] = 163503,
    ["count"] = 2,
    ["health"] = 99117,
    ["scale"] = 0.7,
    ["displayId"] = 93471,
    ["creatureType"] = "Beast",
    ["level"] = 60,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Incapacitate"] = true,
      ["Silence"] = true,
      ["Mind Control"] = true,
      ["Polymorph"] = true,
      ["Root"] = true,
      ["Fear"] = true,
      ["Disorient"] = true,
      ["Imprison"] = true,
      ["Sap"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
    },
    ["spells"] = {
      [317661] = {
        ["interruptible"] = true,
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 350.77573249558,
        ["y"] = -254.72772612126,
        ["g"] = 8,
        ["sublevel"] = 2,
      },
      [2] = {
        ["x"] = 346.0069151461,
        ["y"] = -263.81786157471,
        ["g"] = 8,
        ["sublevel"] = 2,
      },
      [3] = {
        ["x"] = 353.57208601032,
        ["y"] = -267.47245608712,
        ["g"] = 8,
        ["sublevel"] = 2,
      },
      [4] = {
        ["x"] = 444.35429705769,
        ["y"] = -452.82818109806,
        ["g"] = 11,
        ["sublevel"] = 2,
      },
      [5] = {
        ["x"] = 483.07246204882,
        ["y"] = -498.00407560024,
        ["g"] = 13,
        ["sublevel"] = 2,
      },
      [6] = {
        ["x"] = 479.24441264402,
        ["y"] = -487.61156497203,
        ["g"] = 13,
        ["sublevel"] = 2,
      },
      [7] = {
        ["x"] = 478.2392160174,
        ["y"] = -506.98998031172,
        ["g"] = 13,
        ["sublevel"] = 2,
        ["inspiring"] = true,
      },
      [8] = {
        ["x"] = 569.16598936679,
        ["y"] = -428.77058401298,
        ["g"] = 14,
        ["sublevel"] = 2,
      },
      [9] = {
        ["x"] = 561.2850389336,
        ["y"] = -436.15977442959,
        ["g"] = 14,
        ["sublevel"] = 2,
      },
      [10] = {
        ["x"] = 603.10570647994,
        ["y"] = -417.54610965942,
        ["g"] = 15,
        ["sublevel"] = 2,
        ["inspiring"] = true,
        ["patrol"] = {
        },
      },
      [11] = {
        ["x"] = 592.04197106779,
        ["y"] = -414.74942061427,
        ["g"] = 15,
        ["sublevel"] = 2,
      },
      [12] = {
        ["x"] = 600.23770917442,
        ["y"] = -405.94581307112,
        ["g"] = 15,
        ["sublevel"] = 2,
      },
      [13] = {
        ["x"] = 594.37259605047,
        ["y"] = -426.3737338136,
        ["g"] = 15,
        ["sublevel"] = 2,
      },
      [14] = {
        ["x"] = 604.32732738648,
        ["y"] = -429.38512764061,
        ["g"] = 15,
        ["sublevel"] = 2,
      },
      [15] = {
        ["x"] = 624.8378507853,
        ["y"] = -427.29309563544,
        ["g"] = 16,
        ["sublevel"] = 2,
      },
      [16] = {
        ["x"] = 565.7949436188,
        ["y"] = -289.88595888437,
        ["g"] = 18,
        ["sublevel"] = 2,
      },
      [17] = {
        ["x"] = 507.59507820221,
        ["y"] = -203.22151537539,
        ["g"] = 19,
        ["sublevel"] = 2,
      },
      [18] = {
        ["x"] = 481.05849194255,
        ["y"] = -61.006022506303,
        ["g"] = 21,
        ["sublevel"] = 2,
      },
      [19] = {
        ["x"] = 499.7107092531,
        ["y"] = -68.428381301385,
        ["g"] = 21,
        ["sublevel"] = 2,
      },
      [20] = {
        ["x"] = 489.39374765089,
        ["y"] = -68.944086791456,
        ["g"] = 21,
        ["sublevel"] = 2,
      },
      [21] = {
        ["x"] = 316.80444694554,
        ["y"] = -169.51047144141,
        ["g"] = 25,
        ["sublevel"] = 2,
        ["inspiring"] = true,
      },
      [22] = {
        ["x"] = 320.13975973851,
        ["y"] = -163.66667829221,
        ["g"] = 25,
        ["sublevel"] = 2,
      },
      [23] = {
        ["x"] = 320.03487469485,
        ["y"] = -176.36117027845,
        ["g"] = 25,
        ["sublevel"] = 2,
      },
      [24] = {
        ["x"] = 325.8358043974,
        ["y"] = -164.83838697666,
        ["g"] = 25,
        ["sublevel"] = 2,
      },
      [25] = {
        ["x"] = 325.19351985972,
        ["y"] = -170.81616353788,
        ["g"] = 25,
        ["sublevel"] = 2,
      },
    },
  },
  [8] = {
    ["name"] = "Forsworn Skirmisher",
    ["id"] = 163501,
    ["count"] = 4,
    ["health"] = 165195,
    ["scale"] = 1,
    ["displayId"] = 93491,
    ["creatureType"] = "Humanoid",
    ["level"] = 60,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Incapacitate"] = true,
      ["Silence"] = true,
      ["Mind Control"] = true,
      ["Polymorph"] = true,
      ["Root"] = true,
      ["Fear"] = true,
      ["Disorient"] = true,
      ["Repentance"] = true,
      ["Imprison"] = true,
      ["Sap"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
    },
    ["spells"] = {
      [323682] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 359.77763652591,
        ["y"] = -259.09405730651,
        ["g"] = 8,
        ["sublevel"] = 2,
      },
      [2] = {
        ["x"] = 383.65426618325,
        ["y"] = -263.09224336107,
        ["g"] = 9,
        ["sublevel"] = 2,
      },
      [3] = {
        ["x"] = 392.85574580526,
        ["y"] = -268.86059055047,
        ["g"] = 9,
        ["sublevel"] = 2,
      },
      [4] = {
        ["x"] = 383.19152994103,
        ["y"] = -274.37699329145,
        ["g"] = 9,
        ["sublevel"] = 2,
      },
      [5] = {
        ["x"] = 377.1743414741,
        ["y"] = -229.59704911519,
        ["g"] = 10,
        ["sublevel"] = 2,
      },
      [6] = {
        ["x"] = 574.7495926619,
        ["y"] = -438.40391678238,
        ["g"] = 14,
        ["sublevel"] = 2,
      },
      [7] = {
        ["x"] = 283.69792862068,
        ["y"] = -126.81483178582,
        ["g"] = 24,
        ["sublevel"] = 2,
      },
    },
  },
  [9] = {
    ["name"] = "Forsworn Champion",
    ["id"] = 168420,
    ["count"] = 4,
    ["health"] = 132156,
    ["scale"] = 1,
    ["displayId"] = 94313,
    ["creatureType"] = "Humanoid",
    ["level"] = 60,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Incapacitate"] = true,
      ["Silence"] = true,
      ["Mind Control"] = true,
      ["Polymorph"] = true,
      ["Root"] = true,
      ["Fear"] = true,
      ["Disorient"] = true,
      ["Repentance"] = true,
      ["Imprison"] = true,
      ["Sap"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
    },
    ["spells"] = {
      [317936] = {
        ["interruptible"] = true,
      },
      [327655] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 367.38957586906,
        ["y"] = -233.74924820048,
        ["g"] = 10,
        ["sublevel"] = 2,
      },
      [2] = {
        ["x"] = 565.97159377571,
        ["y"] = -447.46529853318,
        ["g"] = 14,
        ["sublevel"] = 2,
      },
      [3] = {
        ["x"] = 556.14868737631,
        ["y"] = -284.16875495241,
        ["g"] = 18,
        ["sublevel"] = 2,
      },
      [4] = {
        ["x"] = 524.88628114361,
        ["y"] = -196.46131556745,
        ["g"] = 19,
        ["sublevel"] = 2,
      },
      [5] = {
        ["x"] = 499.60136639113,
        ["y"] = -94.057400017449,
        ["g"] = 20,
        ["sublevel"] = 2,
      },
    },
  },
  [10] = {
    ["name"] = "Forsworn Squad-Leader",
    ["id"] = 163520,
    ["count"] = 6,
    ["health"] = 264312,
    ["scale"] = 1,
    ["displayId"] = 94919,
    ["creatureType"] = "Humanoid",
    ["level"] = 60,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [317985] = {
      },
      [323739] = {
      },
      [323740] = {
      },
      [327808] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 375.99936462736,
        ["y"] = -240.23717527145,
        ["g"] = 10,
        ["sublevel"] = 2,
      },
      [2] = {
        ["x"] = 622.38196728369,
        ["y"] = -390.09417725635,
        ["g"] = 17,
        ["sublevel"] = 2,
      },
      [3] = {
        ["x"] = 555.78218026632,
        ["y"] = -296.11155006192,
        ["g"] = 18,
        ["sublevel"] = 2,
      },
      [4] = {
        ["x"] = 516.13039751157,
        ["y"] = -199.77269114267,
        ["g"] = 19,
        ["sublevel"] = 2,
      },
      [5] = {
        ["x"] = 492.46936339433,
        ["y"] = -101.54692574708,
        ["g"] = 20,
        ["sublevel"] = 2,
      },
      [6] = {
        ["x"] = 284.57516093744,
        ["y"] = -141.83769668237,
        ["g"] = 24,
        ["sublevel"] = 2,
      },
    },
  },
  [11] = {
    ["name"] = "Forsworn Stealthclaw",
    ["id"] = 163506,
    ["count"] = 4,
    ["health"] = 165195,
    ["scale"] = 0.7,
    ["stealth"] = true,
    ["displayId"] = 93462,
    ["creatureType"] = "Beast",
    ["level"] = 60,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Incapacitate"] = true,
      ["Silence"] = true,
      ["Mind Control"] = true,
      ["Polymorph"] = true,
      ["Root"] = true,
      ["Fear"] = true,
      ["Disorient"] = true,
      ["Imprison"] = true,
      ["Sap"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
    },
    ["spells"] = {
      [27638] = {
      },
      [30831] = {
      },
      [323744] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 392.05571377419,
        ["y"] = -373.15859654204,
        ["g"] = 6,
        ["sublevel"] = 2,
      },
      [2] = {
        ["x"] = 399.61947397278,
        ["y"] = -376.46998546837,
        ["g"] = 6,
        ["sublevel"] = 2,
      },
      [3] = {
        ["x"] = 398.14086245535,
        ["y"] = -368.49052882267,
        ["g"] = 6,
        ["sublevel"] = 2,
      },
      [4] = {
        ["x"] = 422.33016215423,
        ["y"] = -366.96195503578,
        ["g"] = 7,
        ["sublevel"] = 2,
      },
      [5] = {
        ["x"] = 419.0047278377,
        ["y"] = -360.66422287174,
        ["g"] = 7,
        ["sublevel"] = 2,
      },
      [6] = {
        ["x"] = 426.75564615176,
        ["y"] = -360.63438164235,
        ["g"] = 7,
        ["sublevel"] = 2,
      },
      [7] = {
        ["x"] = 444.41532974414,
        ["y"] = -463.76014457109,
        ["g"] = 11,
        ["sublevel"] = 2,
      },
      [8] = {
        ["x"] = 518.59758087323,
        ["y"] = -187.78179272496,
        ["g"] = 19,
        ["sublevel"] = 2,
      },
      [9] = {
        ["x"] = 448.67426350644,
        ["y"] = -83.632152327349,
        ["g"] = 22,
        ["sublevel"] = 2,
      },
      [10] = {
        ["x"] = 465.62453639749,
        ["y"] = -96.048001137773,
        ["g"] = 22,
        ["sublevel"] = 2,
      },
      [11] = {
        ["x"] = 457.51051730946,
        ["y"] = -79.79052306995,
        ["g"] = 22,
        ["sublevel"] = 2,
      },
      [12] = {
        ["x"] = 465.62978646916,
        ["y"] = -84.357001107378,
        ["g"] = 22,
        ["sublevel"] = 2,
      },
      [13] = {
        ["x"] = 336.3259858405,
        ["y"] = -130.73363227095,
        ["g"] = 23,
        ["sublevel"] = 2,
      },
      [14] = {
        ["x"] = 336.68083155384,
        ["y"] = -122.57540129151,
        ["g"] = 23,
        ["sublevel"] = 2,
      },
      [15] = {
        ["x"] = 343.51626569244,
        ["y"] = -127.1079731309,
        ["g"] = 23,
        ["sublevel"] = 2,
      },
      [16] = {
        ["x"] = 292.84781609195,
        ["y"] = -134.9925862069,
        ["g"] = 24,
        ["sublevel"] = 2,
      },
    },
  },
  [12] = {
    ["name"] = "Kyrian Dark-Praetor",
    ["id"] = 163524,
    ["count"] = 5,
    ["health"] = 148676,
    ["scale"] = 1,
    ["displayId"] = 92193,
    ["creatureType"] = "Mechanical",
    ["level"] = 60,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Incapacitate"] = true,
      ["Silence"] = true,
      ["Polymorph"] = true,
      ["Root"] = true,
      ["Fear"] = true,
      ["Disorient"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
    },
    ["spells"] = {
      [323786] = {
      },
      [323804] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 433.47795356133,
        ["y"] = -374.85556229507,
        ["sublevel"] = 2,
      },
      [2] = {
        ["x"] = 434.18024819274,
        ["y"] = -458.33202221227,
        ["g"] = 11,
        ["sublevel"] = 2,
      },
      [3] = {
        ["x"] = 437.17673586115,
        ["y"] = -504.51767052835,
        ["g"] = 12,
        ["sublevel"] = 2,
      },
      [4] = {
        ["x"] = 473.38893692436,
        ["y"] = -496.30718718673,
        ["g"] = 13,
        ["sublevel"] = 2,
        ["patrol"] = {
        },
      },
      [5] = {
        ["x"] = 631.32988329623,
        ["y"] = -436.98084457573,
        ["g"] = 16,
        ["sublevel"] = 2,
      },
      [6] = {
        ["x"] = 630.23712110311,
        ["y"] = -388.71385437505,
        ["g"] = 17,
        ["sublevel"] = 2,
        ["patrol"] = {
        },
      },
      [7] = {
        ["x"] = 546.53647178034,
        ["y"] = -286.64564851729,
        ["g"] = 18,
        ["sublevel"] = 2,
      },
      [8] = {
        ["x"] = 506.46842243128,
        ["y"] = -191.18801265382,
        ["g"] = 19,
        ["sublevel"] = 2,
      },
      [9] = {
        ["x"] = 455.76063752292,
        ["y"] = -91.29181617176,
        ["g"] = 22,
        ["sublevel"] = 2,
        ["inspiring"] = true,
      },
    },
  },
  [13] = {
    ["name"] = "Forsworn Inquisitor",
    ["id"] = 168418,
    ["count"] = 4,
    ["health"] = 165195,
    ["scale"] = 1,
    ["displayId"] = 94316,
    ["creatureType"] = "Humanoid",
    ["level"] = 60,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Incapacitate"] = true,
      ["Silence"] = true,
      ["Mind Control"] = true,
      ["Polymorph"] = true,
      ["Root"] = true,
      ["Fear"] = true,
      ["Disorient"] = true,
      ["Repentance"] = true,
      ["Imprison"] = true,
      ["Sap"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
    },
    ["spells"] = {
      [317959] = {
        ["interruptible"] = true,
      },
      [327648] = {
        ["interruptible"] = true,
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 629.80547796504,
        ["y"] = -416.63968816925,
        ["g"] = 16,
        ["sublevel"] = 2,
      },
      [2] = {
        ["x"] = 544.18337685741,
        ["y"] = -298.63622250596,
        ["g"] = 18,
        ["sublevel"] = 2,
      },
      [3] = {
        ["x"] = 504.23346953768,
        ["y"] = -102.97397124752,
        ["g"] = 20,
        ["sublevel"] = 2,
      },
      [4] = {
        ["x"] = 277.0064198426,
        ["y"] = -134.41949006722,
        ["g"] = 24,
        ["sublevel"] = 2,
      },
    },
  },
  [14] = {
    ["name"] = "Ventunax",
    ["id"] = 162058,
    ["count"] = 0,
    ["health"] = 991450,
    ["scale"] = 1,
    ["displayId"] = 92193,
    ["creatureType"] = "Mechanical",
    ["level"] = 60,
    ["isBoss"] = true,
    ["encounterID"] = 2416,
    ["instanceID"] = 1186,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [324146] = {
      },
      [324154] = {
      },
      [324205] = {
      },
      [334485] = {
      },
      [338070] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 537.15945092138,
        ["y"] = -250.4758022129,
        ["sublevel"] = 2,
      },
    },
  },
  [15] = {
    ["name"] = "Forsworn Helion",
    ["id"] = 168681,
    ["count"] = 6,
    ["health"] = 264312,
    ["scale"] = 1,
    ["displayId"] = 94919,
    ["creatureType"] = "Humanoid",
    ["level"] = 60,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [323739] = {
      },
      [323740] = {
      },
      [328203] = {
      },
      [328217] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 346.44451570742,
        ["y"] = -390.46642746448,
        ["sublevel"] = 3,
      },
      [2] = {
        ["x"] = 370.54276753915,
        ["y"] = -372.10952460834,
        ["g"] = 26,
        ["sublevel"] = 3,
      },
      [3] = {
        ["x"] = 375.11288052143,
        ["y"] = -276.10243965022,
        ["g"] = 28,
        ["sublevel"] = 3,
      },
      [4] = {
        ["x"] = 399.19225798495,
        ["y"] = -281.84858823529,
        ["g"] = 30,
        ["sublevel"] = 3,
      },
    },
  },
  [16] = {
    ["name"] = "Forsworn Warden",
    ["id"] = 168718,
    ["count"] = 4,
    ["health"] = 148676,
    ["scale"] = 1,
    ["displayId"] = 94313,
    ["creatureType"] = "Humanoid",
    ["level"] = 60,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Incapacitate"] = true,
      ["Silence"] = true,
      ["Mind Control"] = true,
      ["Polymorph"] = true,
      ["Root"] = true,
      ["Fear"] = true,
      ["Disorient"] = true,
      ["Repentance"] = true,
      ["Imprison"] = true,
      ["Sap"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
    },
    ["spells"] = {
      [328288] = {
      },
      [328295] = {
        ["interruptible"] = true,
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 353.1550990105,
        ["y"] = -359.83836367609,
        ["g"] = 26,
        ["sublevel"] = 3,
      },
      [2] = {
        ["x"] = 394.63622002074,
        ["y"] = -322.82719227387,
        ["g"] = 27,
        ["sublevel"] = 3,
        ["inspiring"] = true,
      },
      [3] = {
        ["x"] = 367.39232289095,
        ["y"] = -275.28384020815,
        ["g"] = 28,
        ["sublevel"] = 3,
      },
      [4] = {
        ["x"] = 357.06266300075,
        ["y"] = -273.83294887121,
        ["g"] = 28,
        ["sublevel"] = 3,
      },
      [5] = {
        ["x"] = 410.28371168754,
        ["y"] = -291.51464151859,
        ["g"] = 30,
        ["sublevel"] = 3,
      },
      [6] = {
        ["x"] = 448.15131786828,
        ["y"] = -318.69552870833,
        ["g"] = 31,
        ["sublevel"] = 3,
      },
      [7] = {
        ["x"] = 432.05892787324,
        ["y"] = -313.34848083895,
        ["g"] = 31,
        ["sublevel"] = 3,
      },
    },
  },
  [17] = {
    ["name"] = "Forsworn Justicar",
    ["id"] = 168717,
    ["count"] = 4,
    ["health"] = 165195,
    ["scale"] = 1,
    ["displayId"] = 95754,
    ["creatureType"] = "Humanoid",
    ["level"] = 60,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Incapacitate"] = true,
      ["Silence"] = true,
      ["Mind Control"] = true,
      ["Polymorph"] = true,
      ["Root"] = true,
      ["Fear"] = true,
      ["Disorient"] = true,
      ["Repentance"] = true,
      ["Imprison"] = true,
      ["Sap"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
    },
    ["spells"] = {
      [317959] = {
        ["interruptible"] = true,
      },
      [328331] = {
        ["interruptible"] = true,
      },
      [328332] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 382.64163031182,
        ["y"] = -324.8002049666,
        ["g"] = 27,
        ["sublevel"] = 3,
      },
      [2] = {
        ["x"] = 346.48414994473,
        ["y"] = -271.49560363498,
        ["g"] = 28,
        ["sublevel"] = 3,
      },
      [3] = {
        ["x"] = 400.23842865035,
        ["y"] = -292.33211852251,
        ["g"] = 30,
        ["sublevel"] = 3,
      },
      [4] = {
        ["x"] = 441.68271768729,
        ["y"] = -306.90829249305,
        ["g"] = 31,
        ["sublevel"] = 3,
      },
      [5] = {
        ["x"] = 427.61292017851,
        ["y"] = -301.45105524111,
        ["g"] = 31,
        ["sublevel"] = 3,
      },
    },
  },
  [18] = {
    ["name"] = "Forsworn Usurper",
    ["id"] = 166411,
    ["count"] = 1,
    ["health"] = 33039,
    ["scale"] = 0.7,
    ["displayId"] = 93482,
    ["creatureType"] = "Humanoid",
    ["level"] = 60,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Incapacitate"] = true,
      ["Silence"] = true,
      ["Mind Control"] = true,
      ["Polymorph"] = true,
      ["Root"] = true,
      ["Fear"] = true,
      ["Disorient"] = true,
      ["Repentance"] = true,
      ["Imprison"] = true,
      ["Sap"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
    },
    ["spells"] = {
      [323682] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 365.45533430462,
        ["y"] = -248.23295043776,
        ["g"] = 29,
        ["sublevel"] = 3,
      },
      [2] = {
        ["x"] = 385.14618349678,
        ["y"] = -260.73121260329,
        ["g"] = 29,
        ["sublevel"] = 3,
      },
      [3] = {
        ["x"] = 354.96789174054,
        ["y"] = -238.56288371259,
        ["g"] = 29,
        ["sublevel"] = 3,
      },
      [4] = {
        ["x"] = 378.65651152436,
        ["y"] = -256.6830277592,
        ["g"] = 29,
        ["sublevel"] = 3,
      },
      [5] = {
        ["x"] = 359.22359992626,
        ["y"] = -243.28508753878,
        ["g"] = 29,
        ["sublevel"] = 3,
      },
      [6] = {
        ["x"] = 372.67182291891,
        ["y"] = -252.71581576641,
        ["g"] = 29,
        ["sublevel"] = 3,
      },
      [7] = {
        ["x"] = 453.8282659323,
        ["y"] = -291.29136773036,
        ["g"] = 32,
        ["sublevel"] = 3,
      },
      [8] = {
        ["x"] = 436.62648144946,
        ["y"] = -281.7495088174,
        ["g"] = 32,
        ["sublevel"] = 3,
      },
      [9] = {
        ["x"] = 465.52252885931,
        ["y"] = -298.32494563434,
        ["g"] = 32,
        ["sublevel"] = 3,
      },
      [10] = {
        ["x"] = 459.36141451738,
        ["y"] = -294.59801344187,
        ["g"] = 32,
        ["sublevel"] = 3,
      },
      [11] = {
        ["x"] = 441.70281736634,
        ["y"] = -284.98420335433,
        ["g"] = 32,
        ["sublevel"] = 3,
      },
      [12] = {
        ["x"] = 446.92513828714,
        ["y"] = -287.68985324643,
        ["g"] = 32,
        ["sublevel"] = 3,
      },
    },
  },
  [19] = {
    ["name"] = "Oryphrion",
    ["id"] = 162060,
    ["count"] = 0,
    ["health"] = 1817659,
    ["scale"] = 1,
    ["displayId"] = 97621,
    ["creatureType"] = "Mechanical",
    ["level"] = 60,
    ["isBoss"] = true,
    ["encounterID"] = 2414,
    ["instanceID"] = 1186,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [323878] = {
      },
      [324046] = {
      },
      [324392] = {
      },
      [324427] = {
      },
      [324608] = {
      },
      [331997] = {
      },
      [334053] = {
      },
      [338729] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 439.38917647059,
        ["y"] = -226.95582352941,
        ["sublevel"] = 3,
      },
    },
  },
  [20] = {
    ["name"] = "Klotos",
    ["id"] = 168843,
    ["count"] = 12,
    ["health"] = 495585,
    ["scale"] = 1.5,
    ["displayId"] = 95759,
    ["creatureType"] = "Humanoid",
    ["level"] = 60,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [323739] = {
      },
      [324662] = {
      },
      [328434] = {
      },
      [328435] = {
      },
      [328452] = {
      },
      [328453] = {
      },
      [328462] = {
      },
      [336420] = {
      },
      [336444] = {
      },
      [336496] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 335.64255319149,
        ["y"] = -331.88433312061,
        ["sublevel"] = 4,
      },
    },
  },
  [21] = {
    ["name"] = "Lakesis",
    ["id"] = 168844,
    ["count"] = 12,
    ["health"] = 495585,
    ["scale"] = 1.5,
    ["displayId"] = 95759,
    ["creatureType"] = "Humanoid",
    ["level"] = 60,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [324662] = {
      },
      [328434] = {
      },
      [328435] = {
      },
      [328453] = {
      },
      [328454] = {
      },
      [328462] = {
      },
      [336444] = {
      },
      [336496] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 371.26771977629,
        ["y"] = -368.80250147291,
        ["sublevel"] = 4,
      },
    },
  },
  [22] = {
    ["name"] = "Astronos",
    ["id"] = 168845,
    ["count"] = 12,
    ["health"] = 495585,
    ["scale"] = 1.5,
    ["displayId"] = 95759,
    ["creatureType"] = "Humanoid",
    ["level"] = 60,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [324662] = {
      },
      [328434] = {
      },
      [328453] = {
      },
      [328466] = {
      },
      [333887] = {
      },
      [336444] = {
      },
      [336496] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 422.58863079951,
        ["y"] = -383.44048886898,
        ["sublevel"] = 4,
      },
    },
  },
  [23] = {
    ["name"] = "Devos",
    ["id"] = 162061,
    ["count"] = 0,
    ["health"] = 1982901,
    ["scale"] = 1.5,
    ["displayId"] = 95665,
    ["creatureType"] = "Humanoid",
    ["level"] = 60,
    ["isBoss"] = true,
    ["encounterID"] = 2412,
    ["instanceID"] = 0,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [322817] = {
      },
      [322818] = {
      },
      [322908] = {
      },
      [322999] = {
      },
      [323943] = {
      },
      [334625] = {
      },
      [335817] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 399.37160069492,
        ["y"] = -314.17061075793,
        ["sublevel"] = 4,
      },
    },
  },
  [24] = {
    ["name"] = "Incinerator Arkolath",
    ["id"] = 179446,
    ["count"] = 0,
    ["health"] = 336131,
    ["ignoreFortified"] = true,
    ["scale"] = 1.5,
    ["displayId"] = 100718,
    ["iconTexture"] = 236297,
    ["creatureType"] = "Humanoid",
    ["level"] = 61,
    ["include"] = {
      ["level"] = 10,
      ["affix"] = 128,
    },
    ["powers"] = {
      [357575] = {
        ["dps"] = true,
        ["healer"] = true,
        ["tank"] = true,
      },
      [357839] = {
        ["tank"] = true,
      },
      [357848] = {
        ["dps"] = true,
      },
      [357864] = {
        ["dps"] = true,
      },
      [357889] = {
        ["healer"] = true,
      },
      [357897] = {
        ["tank"] = true,
      },
      [357900] = {
        ["healer"] = true,
      },
    },
    ["spells"] = {
      [355707] = {
      },
      [355732] = {
      },
      [355737] = {
      },
      [358967] = {
        ["interruptible"] = true,
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 320.10638742555,
        ["y"] = -328.11501272076,
        ["sublevel"] = 2,
        ["week"] = {
          [1] = true,
          [2] = true,
          [5] = true,
          [6] = true,
          [9] = true,
          [10] = true,
        },
      },
      [2] = {
        ["x"] = 354.12614370227,
        ["y"] = -380.37685438298,
        ["sublevel"] = 3,
        ["week"] = {
          [3] = true,
          [4] = true,
          [7] = true,
          [8] = true,
          [11] = true,
          [12] = true,
        },
      },
    },
  },
  [25] = {
    ["name"] = "Oros Coldheart",
    ["id"] = 179892,
    ["count"] = 0,
    ["health"] = 336131,
    ["ignoreFortified"] = true,
    ["scale"] = 1.5,
    ["displayId"] = 97237,
    ["iconTexture"] = 136213,
    ["creatureType"] = "Humanoid",
    ["level"] = 61,
    ["include"] = {
      ["level"] = 10,
      ["affix"] = 128,
    },
    ["powers"] = {
      [357815] = {
        ["dps"] = true,
        ["healer"] = true,
      },
      [357817] = {
        ["tank"] = true,
      },
      [357820] = {
        ["tank"] = true,
      },
      [357825] = {
        ["dps"] = true,
      },
      [357829] = {
        ["healer"] = true,
      },
      [357834] = {
        ["dps"] = true,
        ["tank"] = true,
      },
      [357842] = {
        ["healer"] = true,
      },
    },
    ["spells"] = {
      [355710] = {
      },
      [356414] = {
      },
      [356666] = {
      },
      [358894] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 506.47761372507,
        ["y"] = -263.6576606658,
        ["sublevel"] = 2,
        ["week"] = {
          [1] = true,
          [2] = true,
          [5] = true,
          [6] = true,
          [9] = true,
          [10] = true,
        },
      },
      [2] = {
        ["x"] = 395.44178521678,
        ["y"] = -305.11363642753,
        ["sublevel"] = 3,
        ["week"] = {
          [3] = true,
          [4] = true,
          [7] = true,
          [8] = true,
          [11] = true,
          [12] = true,
        },
      },
    },
  },
  [26] = {
    ["name"] = "Soggodon the Breaker",
    ["id"] = 179891,
    ["count"] = 0,
    ["health"] = 358540,
    ["ignoreFortified"] = true,
    ["scale"] = 1.5,
    ["displayId"] = 98535,
    ["iconTexture"] = 2103898,
    ["creatureType"] = "Humanoid",
    ["level"] = 62,
    ["include"] = {
      ["level"] = 10,
      ["affix"] = 128,
    },
    ["powers"] = {
      [356827] = {
        ["dps"] = true,
        ["healer"] = true,
      },
      [356828] = {
        ["dps"] = true,
        ["tank"] = true,
      },
      [357524] = {
        ["dps"] = true,
        ["healer"] = true,
        ["tank"] = true,
      },
      [357556] = {
        ["healer"] = true,
      },
      [357778] = {
        ["tank"] = true,
      },
    },
    ["spells"] = {
      [355719] = {
      },
      [355806] = {
      },
      [358784] = {
      },
      [358968] = {
      },
      [358970] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 395.44178521678,
        ["y"] = -305.11363642753,
        ["sublevel"] = 3,
        ["week"] = {
          [1] = true,
          [2] = true,
          [5] = true,
          [6] = true,
          [9] = true,
          [10] = true,
        },
      },
      [2] = {
        ["x"] = 506.47761372507,
        ["y"] = -263.6576606658,
        ["sublevel"] = 2,
        ["week"] = {
          [3] = true,
          [4] = true,
          [7] = true,
          [8] = true,
          [11] = true,
          [12] = true,
        },
      },
    },
  },
  [27] = {
    ["name"] = "Executioner Varruth",
    ["id"] = 179890,
    ["count"] = 0,
    ["health"] = 336131,
    ["ignoreFortified"] = true,
    ["scale"] = 1.5,
    ["displayId"] = 92418,
    ["iconTexture"] = 237552,
    ["creatureType"] = "Humanoid",
    ["level"] = 61,
    ["include"] = {
      ["level"] = 10,
      ["affix"] = 128,
    },
    ["powers"] = {
      [357575] = {
        ["dps"] = true,
        ["healer"] = true,
        ["tank"] = true,
      },
      [357604] = {
        ["tank"] = true,
      },
      [357609] = {
        ["dps"] = true,
      },
      [357706] = {
        ["dps"] = true,
      },
      [357747] = {
        ["healer"] = true,
      },
      [357847] = {
        ["healer"] = true,
      },
      [357863] = {
        ["tank"] = true,
      },
    },
    ["spells"] = {
      [355714] = {
      },
      [356923] = {
      },
      [356925] = {
      },
      [358971] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 354.12614370227,
        ["y"] = -380.37685438298,
        ["sublevel"] = 3,
        ["week"] = {
          [1] = true,
          [2] = true,
          [5] = true,
          [6] = true,
          [9] = true,
          [10] = true,
        },
      },
      [2] = {
        ["x"] = 320.10638742555,
        ["y"] = -328.11501272076,
        ["sublevel"] = 2,
        ["week"] = {
          [3] = true,
          [4] = true,
          [7] = true,
          [8] = true,
          [11] = true,
          [12] = true,
        },
      },
    },
  },
  [28] = {
    ["name"] = "Wo Relic",
    ["id"] = 185683,
    ["count"] = 0,
    ["health"] = 33039,
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
    },
    ["clones"] = {
      [1] = {
        ["x"] = 489.33455978971,
        ["y"] = -237.78855141147,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 325.32389747418,
        ["y"] = -334.98167415589,
        ["sublevel"] = 2,
      },
      [3] = {
        ["x"] = 285.75222249675,
        ["y"] = -111.54187161461,
        ["sublevel"] = 2,
      },
      [4] = {
        ["x"] = 513.12442854621,
        ["y"] = -67.799994943216,
        ["sublevel"] = 2,
      },
      [5] = {
        ["x"] = 514.80961806257,
        ["y"] = -244.47626517108,
        ["sublevel"] = 2,
      },
      [6] = {
        ["x"] = 407.47738517317,
        ["y"] = -295.09060638623,
        ["sublevel"] = 2,
      },
      [7] = {
        ["x"] = 435.33263572618,
        ["y"] = -443.03281182688,
        ["sublevel"] = 2,
      },
      [8] = {
        ["x"] = 557.19577132547,
        ["y"] = -424.10714439254,
        ["sublevel"] = 2,
      },
      [9] = {
        ["x"] = 422.30130052091,
        ["y"] = -208.09256866599,
        ["sublevel"] = 3,
      },
      [10] = {
        ["x"] = 382.06529210751,
        ["y"] = -284.84895902875,
        ["sublevel"] = 4,
      },
      [11] = {
        ["x"] = 353.67320143278,
        ["y"] = -379.23916033672,
        ["sublevel"] = 3,
      },
      [12] = {
        ["x"] = 435.94362016208,
        ["y"] = -328.57403008825,
        ["sublevel"] = 3,
      },
      [13] = {
        ["x"] = 335.4688143588,
        ["y"] = -282.24107563867,
        ["sublevel"] = 3,
      },
    },
  },
  [29] = {
    ["name"] = "Urh Relic",
    ["id"] = 185685,
    ["count"] = 0,
    ["health"] = 33039,
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
    ["spells"] = {
      [366288] = {
      },
      [366297] = {
      },
      [368243] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 474.78914421634,
        ["y"] = -231.65220299726,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 323.32390496127,
        ["y"] = -319.98167881064,
        ["sublevel"] = 2,
      },
      [3] = {
        ["x"] = 269.78441831651,
        ["y"] = -118.96120153866,
        ["sublevel"] = 2,
      },
      [4] = {
        ["x"] = 509.72429707869,
        ["y"] = -54.399986741839,
        ["sublevel"] = 2,
      },
      [5] = {
        ["x"] = 515.30962478579,
        ["y"] = -259.10126870614,
        ["sublevel"] = 2,
      },
      [6] = {
        ["x"] = 418.06563654546,
        ["y"] = -312.14939411103,
        ["sublevel"] = 2,
      },
      [7] = {
        ["x"] = 421.81910293,
        ["y"] = -449.11387026856,
        ["sublevel"] = 2,
      },
      [8] = {
        ["x"] = 548.44576110653,
        ["y"] = -436.96429131747,
        ["sublevel"] = 2,
      },
      [9] = {
        ["x"] = 449.08703733085,
        ["y"] = -204.16399045976,
        ["sublevel"] = 3,
      },
      [10] = {
        ["x"] = 415.27959471647,
        ["y"] = -286.09899114242,
        ["sublevel"] = 4,
      },
      [11] = {
        ["x"] = 333.2678116817,
        ["y"] = -382.61752613765,
        ["sublevel"] = 3,
      },
      [12] = {
        ["x"] = 450.19366157008,
        ["y"] = -333.199027905,
        ["sublevel"] = 3,
      },
      [13] = {
        ["x"] = 350.71880484022,
        ["y"] = -287.86609763069,
        ["sublevel"] = 3,
      },
    },
  },
  [30] = {
    ["name"] = "Vy Relic",
    ["id"] = 185680,
    ["count"] = 0,
    ["health"] = 33039,
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
    },
    ["clones"] = {
      [1] = {
        ["x"] = 469.56185989175,
        ["y"] = -215.74311326156,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 335.12384018808,
        ["y"] = -348.58171079099,
        ["sublevel"] = 2,
      },
      [3] = {
        ["x"] = 299.30062549082,
        ["y"] = -121.54185368334,
        ["sublevel"] = 2,
      },
      [4] = {
        ["x"] = 504.52429594575,
        ["y"] = -79.399961817783,
        ["sublevel"] = 2,
      },
      [5] = {
        ["x"] = 526.80960775841,
        ["y"] = -270.60126240761,
        ["sublevel"] = 2,
      },
      [6] = {
        ["x"] = 409.83033272749,
        ["y"] = -327.00233925898,
        ["sublevel"] = 2,
      },
      [7] = {
        ["x"] = 421.27857832034,
        ["y"] = -464.38413704298,
        ["sublevel"] = 2,
      },
      [8] = {
        ["x"] = 552.91006079279,
        ["y"] = -451.07143970225,
        ["sublevel"] = 2,
      },
      [9] = {
        ["x"] = 461.40843212192,
        ["y"] = -227.37831204375,
        ["sublevel"] = 3,
      },
      [10] = {
        ["x"] = 426.35098804769,
        ["y"] = -315.3846389106,
        ["sublevel"] = 4,
      },
      [11] = {
        ["x"] = 359.75425987445,
        ["y"] = -397.48238205672,
        ["sublevel"] = 3,
      },
      [12] = {
        ["x"] = 462.94355406238,
        ["y"] = -320.44902812433,
        ["sublevel"] = 3,
      },
      [13] = {
        ["x"] = 331.5937729827,
        ["y"] = -267.36603655549,
        ["sublevel"] = 3,
      },
    },
  },
};
