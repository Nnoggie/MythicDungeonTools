local MDT = MDT
local L = MDT.L

local dungeonIndex = 51
MDT.dungeonList[dungeonIndex] = L["Uldaman: Legacy of Tyr"]
MDT.mapInfo[dungeonIndex] = {};

local zones = { 2071, 2072 }
for _, zone in ipairs(zones) do
  MDT.zoneIdToDungeonIdx[zone] = dungeonIndex
end

MDT.dungeonMaps[dungeonIndex] = {
  [0] = "",
  [1] = { customTextures = 'Uldaman' },
}

MDT.dungeonSubLevels[dungeonIndex] = {
  [1] = L["Uldaman: Legacy of Tyr"],
}

MDT.dungeonTotalCount[dungeonIndex] = { normal = 575, teeming = 1000, teemingEnabled = true }

MDT.mapPOIs[dungeonIndex] = {
  [1] = {
    [1] = {
      ["template"] = "DeathReleasePinTemplate",
      ["type"] = "graveyard",
      ["x"] = 658.24367640427,
      ["y"] = -228.09070486075,
      ["graveyardDescription"] = "",
    },
  },
};

MDT.dungeonEnemies[dungeonIndex] = {
  [1] = {
    ["name"] = "Scavenging Leaper",
    ["id"] = 184134,
    ["count"] = 1,
    ["health"] = 2349553,
    ["scale"] = 0.8,
    ["displayId"] = 92697,
    ["creatureType"] = "Humanoid",
    ["level"] = 70,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Incapacitate"] = true,
      ["Silence"] = true,
      ["Knock"] = true,
      ["Grip"] = true,
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
      ["Sleep Walk"] = true,
      ["Mind Soothe"] = true,
    },
    ["spells"] = {
      [369696] = {
      },
      [369697] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 93.337635730879,
        ["y"] = -252.74501613769,
        ["g"] = 1,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
      [2] = {
        ["x"] = 103.86486241861,
        ["y"] = -253.20136746347,
        ["g"] = 1,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
      [3] = {
        ["x"] = 92.415403987124,
        ["y"] = -261.21681484022,
        ["g"] = 1,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
      [4] = {
        ["x"] = 102.05899474191,
        ["y"] = -264.19627713977,
        ["g"] = 1,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
      [5] = {
        ["x"] = 76.199311610888,
        ["y"] = -215.36642423909,
        ["g"] = 3,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
      [6] = {
        ["x"] = 81.046127991684,
        ["y"] = -206.38827662599,
        ["g"] = 3,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
      [7] = {
        ["x"] = 97.428458264258,
        ["y"] = -214.33544269251,
        ["g"] = 3,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
      [8] = {
        ["x"] = 91.521358521659,
        ["y"] = -205.93115681548,
        ["g"] = 3,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
      [9] = {
        ["x"] = 196.61463864306,
        ["y"] = -125.91382305127,
        ["g"] = 10,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
      [10] = {
        ["x"] = 204.68088787691,
        ["y"] = -132.85140762349,
        ["g"] = 10,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
      [11] = {
        ["x"] = 204.7969773829,
        ["y"] = -121.6376329905,
        ["g"] = 10,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
      [12] = {
        ["x"] = 196.54655572152,
        ["y"] = -137.80261596027,
        ["g"] = 10,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
      [13] = {
        ["x"] = 120.61829029946,
        ["y"] = -161.27870534298,
        ["g"] = 6,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
      [14] = {
        ["x"] = 124.2009376307,
        ["y"] = -152.27457328445,
        ["g"] = 6,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
      [15] = {
        ["x"] = 135.04619222032,
        ["y"] = -152.67515573761,
        ["g"] = 6,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
      [16] = {
        ["x"] = 141.10422791078,
        ["y"] = -160.75177381367,
        ["g"] = 6,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
    },
  },
  [2] = {
    ["name"] = "Stonevault Geomancer",
    ["id"] = 184022,
    ["count"] = 5,
    ["health"] = 6041710,
    ["scale"] = 1,
    ["displayId"] = 92697,
    ["creatureType"] = "Humanoid",
    ["level"] = 70,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Incapacitate"] = true,
      ["Silence"] = true,
      ["Knock"] = true,
      ["Grip"] = true,
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
      ["Sleep Walk"] = true,
      ["Mind Soothe"] = true,
    },
    ["spells"] = {
      [369674] = {
      },
      [369675] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 87.035875209894,
        ["y"] = -217.22074527286,
        ["g"] = 3,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
      [2] = {
        ["x"] = 128.22052139551,
        ["y"] = -195.25625249753,
        ["g"] = 4,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
      [3] = {
        ["x"] = 115.94369283821,
        ["y"] = -193.98605287198,
        ["g"] = 4,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
      [4] = {
        ["x"] = 166.30329072248,
        ["y"] = -124.72155881192,
        ["g"] = 7,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
      [5] = {
        ["x"] = 177.92582435385,
        ["y"] = -125.01969842251,
        ["g"] = 7,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
      [6] = {
        ["x"] = 210.61038930454,
        ["y"] = -141.76023845888,
        ["g"] = 10,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
      [7] = {
        ["x"] = 215.0362763046,
        ["y"] = -127.66958533029,
        ["g"] = 10,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
      [8] = {
        ["x"] = 243.62134779327,
        ["y"] = -172.90806069106,
        ["g"] = 12,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
    },
  },
  [3] = {
    ["name"] = "Hulking Berserker",
    ["id"] = 184020,
    ["count"] = 15,
    ["health"] = 10069516,
    ["scale"] = 1,
    ["displayId"] = 92699,
    ["creatureType"] = "Humanoid",
    ["level"] = 70,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Mind Soothe"] = true,
    },
    ["spells"] = {
      [369806] = {
      },
      [369811] = {
      },
      [369818] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 112.09385375064,
        ["y"] = -233.9272638943,
        ["g"] = 2,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
        ["patrol"] = {
          [1] = {
            ["x"] = 109.7926690782,
            ["y"] = -230.70555268214,
          },
          [2] = {
            ["x"] = 98.006765723037,
            ["y"] = -231.15603653803,
          },
          [3] = {
            ["x"] = 83.048854669198,
            ["y"] = -230.92591807079,
          },
          [4] = {
            ["x"] = 98.006765723037,
            ["y"] = -231.15603653803,
          },
          [5] = {
            ["x"] = 109.7926690782,
            ["y"] = -230.70555268214,
          },
          [6] = {
            ["x"] = 118.02736206236,
            ["y"] = -230.69578643586,
          },
          [7] = {
            ["x"] = 119.17798073395,
            ["y"] = -223.10175850763,
          },
          [8] = {
            ["x"] = 119.4080992012,
            ["y"] = -205.38239951149,
          },
          [9] = {
            ["x"] = 119.17798073395,
            ["y"] = -223.10175850763,
          },
          [10] = {
            ["x"] = 118.02736206236,
            ["y"] = -230.69578643586,
          },
        },
      },
      [2] = {
        ["x"] = 172.27968055183,
        ["y"] = -114.71875984642,
        ["g"] = 7,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
      [3] = {
        ["x"] = 252.49184528302,
        ["y"] = -167.00147405662,
        ["g"] = 12,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
      [4] = {
        ["x"] = 251.99229877824,
        ["y"] = -179.66592440427,
        ["g"] = 12,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
      [5] = {
        ["x"] = 130.58149877785,
        ["y"] = -162.40427819475,
        ["g"] = 6,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
    },
  },
  [4] = {
    ["name"] = "Vicious Basilisk",
    ["id"] = 184023,
    ["count"] = 3,
    ["health"] = 5370409,
    ["scale"] = 1,
    ["displayId"] = 103338,
    ["creatureType"] = "Beast",
    ["level"] = 70,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Incapacitate"] = true,
      ["Silence"] = true,
      ["Knock"] = true,
      ["Grip"] = true,
      ["Mind Control"] = true,
      ["Polymorph"] = true,
      ["Root"] = true,
      ["Fear"] = true,
      ["Disorient"] = true,
      ["Imprison"] = true,
      ["Sap"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
      ["Sleep Walk"] = true,
      ["Scare Beast"] = true,
      ["Hibernate"] = true,
    },
    ["spells"] = {
      [369823] = {
      },
      [369826] = {
      },
      [369828] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 111.74579670439,
        ["y"] = -222.95422884735,
        ["g"] = 2,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
      [2] = {
        ["x"] = 161.66315510978,
        ["y"] = -170.45145112412,
        ["g"] = 5,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
      [3] = {
        ["x"] = 173.74078487396,
        ["y"] = -171.45519468438,
        ["g"] = 5,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
      [4] = {
        ["x"] = 166.19949012002,
        ["y"] = -181.19632720548,
        ["g"] = 5,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
      [5] = {
        ["x"] = 155.20307747093,
        ["y"] = -89.028061144717,
        ["g"] = 8,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
      [6] = {
        ["x"] = 165.16519736581,
        ["y"] = -87.608439614888,
        ["g"] = 8,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
      [7] = {
        ["x"] = 206.65141980126,
        ["y"] = -163.32782320451,
        ["g"] = 11,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
      [8] = {
        ["x"] = 219.16039654573,
        ["y"] = -166.5224013513,
        ["g"] = 11,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
    },
  },
  [5] = {
    ["name"] = "Baelog",
    ["id"] = 184581,
    ["count"] = 0,
    ["health"] = 20075817,
    ["scale"] = 1.6,
    ["displayId"] = 105887,
    ["creatureType"] = "Humanoid",
    ["level"] = 70,
    ["isBoss"] = true,
    ["encounterID"] = 2475,
    ["instanceID"] = 1197,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Mind Soothe"] = true,
    },
    ["spells"] = {
      [369563] = {
      },
      [369573] = {
      },
      [369603] = {
      },
      [375339] = {
      },
      [375924] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 120.7718170642,
        ["y"] = -47.052075539949,
        ["g"] = 9,
        ["sublevel"] = 1,
      },
    },
  },
  [6] = {
    ["name"] = "Olaf",
    ["id"] = 184580,
    ["count"] = 0,
    ["health"] = 21414205,
    ["scale"] = 1.6,
    ["displayId"] = 105883,
    ["creatureType"] = "Humanoid",
    ["level"] = 70,
    ["isBoss"] = true,
    ["encounterID"] = 2475,
    ["instanceID"] = 1197,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Mind Soothe"] = true,
    },
    ["spells"] = {
      [369602] = {
      },
      [369603] = {
      },
      [369677] = {
      },
      [375339] = {
      },
      [375924] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 145.00921261058,
        ["y"] = -36.393382894009,
        ["g"] = 9,
        ["sublevel"] = 1,
      },
    },
  },
  [7] = {
    ["name"] = "Eric \"The Swift\"",
    ["id"] = 184582,
    ["count"] = 0,
    ["health"] = 20075817,
    ["scale"] = 1.6,
    ["displayId"] = 105884,
    ["creatureType"] = "Humanoid",
    ["level"] = 70,
    ["isBoss"] = true,
    ["encounterID"] = 2475,
    ["instanceID"] = 1197,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Mind Soothe"] = true,
    },
    ["spells"] = {
      [369603] = {
      },
      [369781] = {
      },
      [369791] = {
      },
      [369792] = {
      },
      [375339] = {
      },
      [375924] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 172.0988665777,
        ["y"] = -37.793395777829,
        ["g"] = 9,
        ["sublevel"] = 1,
      },
    },
  },
  [8] = {
    ["name"] = "Burly Rock-Thrower",
    ["id"] = 184019,
    ["count"] = 5,
    ["health"] = 6713011,
    ["scale"] = 1,
    ["displayId"] = 765,
    ["creatureType"] = "Humanoid",
    ["level"] = 70,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Incapacitate"] = true,
      ["Silence"] = true,
      ["Knock"] = true,
      ["Grip"] = true,
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
      ["Sleep Walk"] = true,
      ["Mind Soothe"] = true,
    },
    ["spells"] = {
      [369853] = {
      },
      [369854] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 202.7290967041,
        ["y"] = -183.67049217313,
        ["g"] = 11,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
      [2] = {
        ["x"] = 209.74897283408,
        ["y"] = -175.08365220971,
        ["g"] = 11,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
      [3] = {
        ["x"] = 216.22969395058,
        ["y"] = -184.16808257541,
        ["g"] = 11,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
    },
  },
  [9] = {
    ["name"] = "Bromach",
    ["id"] = 184018,
    ["count"] = 0,
    ["health"] = 40151634,
    ["scale"] = 1.6,
    ["displayId"] = 107143,
    ["creatureType"] = "Humanoid",
    ["level"] = 70,
    ["isBoss"] = true,
    ["encounterID"] = 2487,
    ["instanceID"] = 1197,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Mind Soothe"] = true,
    },
    ["spells"] = {
      [369605] = {
      },
      [369703] = {
      },
      [369754] = {
      },
      [382303] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 282.53031711988,
        ["y"] = -172.01830845468,
        ["sublevel"] = 1,
      },
    },
  },
  [10] = {
    ["name"] = "Earthen Custodian",
    ["id"] = 184130,
    ["count"] = 4,
    ["health"] = 6713011,
    ["scale"] = 1,
    ["displayId"] = 6025,
    ["creatureType"] = "Humanoid",
    ["level"] = 70,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Incapacitate"] = true,
      ["Silence"] = true,
      ["Knock"] = true,
      ["Grip"] = true,
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
      ["Sleep Walk"] = true,
      ["Mind Soothe"] = true,
    },
    ["spells"] = {
      [369409] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 372.06146073634,
        ["y"] = -172.79290572319,
        ["g"] = 13,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
      [2] = {
        ["x"] = 368.8626578905,
        ["y"] = -162.83417456861,
        ["g"] = 13,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
      [3] = {
        ["x"] = 519.25960368674,
        ["y"] = -174.39709536116,
        ["g"] = 16,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
      [4] = {
        ["x"] = 532.65564630859,
        ["y"] = -174.48726015586,
        ["g"] = 16,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
      [5] = {
        ["x"] = 528.84463274653,
        ["y"] = -228.22592085229,
        ["g"] = 17,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
      [6] = {
        ["x"] = 529.64396113004,
        ["y"] = -216.0464045819,
        ["g"] = 17,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
      [7] = {
        ["x"] = 563.25438131269,
        ["y"] = -198.69680739024,
        ["g"] = 18,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
      [8] = {
        ["x"] = 572.13023729551,
        ["y"] = -174.45687210993,
        ["g"] = 20,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
      [9] = {
        ["x"] = 584.90066782439,
        ["y"] = -179.02198406235,
        ["g"] = 20,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
      [10] = {
        ["x"] = 614.226054361,
        ["y"] = -234.89872341522,
        ["g"] = 22,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
      [11] = {
        ["x"] = 611.70766977819,
        ["y"] = -209.75041149262,
        ["g"] = 22,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
      [12] = {
        ["x"] = 327.38109182581,
        ["y"] = -399.89581180094,
        ["g"] = 27,
        ["sublevel"] = 1,
        ["scale"] = 1.7,
      },
      [13] = {
        ["x"] = 268.34260199752,
        ["y"] = -428.24758556723,
        ["g"] = 28,
        ["sublevel"] = 1,
        ["scale"] = 1.7,
      },
      [14] = {
        ["x"] = 276.3647096905,
        ["y"] = -440.80804488594,
        ["g"] = 28,
        ["sublevel"] = 1,
        ["scale"] = 1.7,
      },
      [15] = {
        ["x"] = 260.44689800595,
        ["y"] = -461.07546733649,
        ["g"] = 29,
        ["sublevel"] = 1,
        ["scale"] = 1.7,
        ["patrol"] = {
          [1] = {
            ["x"] = 261.13104966856,
            ["y"] = -462.58058220358,
          },
          [2] = {
            ["x"] = 257.0942089728,
            ["y"] = -447.17702688071,
          },
          [3] = {
            ["x"] = 258.99272248726,
            ["y"] = -437.05166975175,
          },
          [4] = {
            ["x"] = 266.27032745009,
            ["y"] = -436.7352387623,
          },
          [5] = {
            ["x"] = 287.78672945469,
            ["y"] = -426.60986352777,
          },
          [6] = {
            ["x"] = 266.27032745009,
            ["y"] = -436.7352387623,
          },
          [7] = {
            ["x"] = 258.99272248726,
            ["y"] = -437.05166975175,
          },
          [8] = {
            ["x"] = 257.0942089728,
            ["y"] = -447.17702688071,
          },
        },
      },
      [16] = {
        ["x"] = 442.96542029578,
        ["y"] = -154.76639723318,
        ["g"] = 14,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
      [17] = {
        ["x"] = 456.23433029144,
        ["y"] = -155.59989159245,
        ["g"] = 14,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
      [18] = {
        ["x"] = 585.30563374612,
        ["y"] = -267.96842435676,
        ["g"] = 21,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
      [19] = {
        ["x"] = 570.43474809589,
        ["y"] = -269.33863027464,
        ["g"] = 21,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
      [20] = {
        ["x"] = 265.97314232714,
        ["y"] = -500.2255793457,
        ["g"] = 30,
        ["sublevel"] = 1,
        ["scale"] = 1.7,
      },
      [21] = {
        ["x"] = 257.53974069766,
        ["y"] = -510.91781339223,
        ["g"] = 30,
        ["sublevel"] = 1,
        ["scale"] = 1.7,
      },
      [22] = {
        ["x"] = 565.68180091072,
        ["y"] = -240.32066732426,
        ["g"] = 19,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
    },
  },
  [11] = {
    ["name"] = "Refti Custodian",
    ["id"] = 184319,
    ["count"] = 15,
    ["health"] = 12083419,
    ["scale"] = 1,
    ["displayId"] = 106782,
    ["creatureType"] = "Elemental",
    ["level"] = 70,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Incapacitate"] = true,
      ["Silence"] = true,
      ["Knock"] = true,
      ["Grip"] = true,
      ["Mind Control"] = true,
      ["Root"] = true,
      ["Fear"] = true,
      ["Banish"] = true,
      ["Disorient"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
      ["Sleep Walk"] = true,
    },
    ["spells"] = {
      [377723] = {
      },
      [377724] = {
      },
      [377732] = {
      },
      [377738] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 360.73802957761,
        ["y"] = -154.05757096072,
        ["g"] = 13,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
      [2] = {
        ["x"] = 365.80059103622,
        ["y"] = -124.75172834442,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
      [3] = {
        ["x"] = 448.5330555207,
        ["y"] = -129.37652610619,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
    },
  },
  [12] = {
    ["name"] = "Sentinel Talondras",
    ["id"] = 184124,
    ["count"] = 0,
    ["health"] = 46843573,
    ["scale"] = 1.6,
    ["displayId"] = 109735,
    ["creatureType"] = "Giant",
    ["level"] = 70,
    ["isBoss"] = true,
    ["encounterID"] = 2484,
    ["instanceID"] = 1197,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Stun"] = true,
    },
    ["spells"] = {
      [372600] = {
      },
      [372623] = {
      },
      [372701] = {
      },
      [372718] = {
      },
      [372719] = {
      },
      [382071] = {
      },
      [386332] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 528.6723657389,
        ["y"] = -127.98403745533,
        ["sublevel"] = 1,
      },
    },
  },
  [13] = {
    ["name"] = "Earthen Weaver",
    ["id"] = 186420,
    ["count"] = 5,
    ["health"] = 6041710,
    ["scale"] = 1,
    ["displayId"] = 6026,
    ["creatureType"] = "Humanoid",
    ["level"] = 70,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Incapacitate"] = true,
      ["Silence"] = true,
      ["Knock"] = true,
      ["Grip"] = true,
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
      ["Sleep Walk"] = true,
      ["Mind Soothe"] = true,
    },
    ["spells"] = {
      [369399] = {
      },
      [369465] = {
      },
      [369466] = {
      },
      [373662] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 526.81520267133,
        ["y"] = -184.89554076462,
        ["g"] = 16,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
      [2] = {
        ["x"] = 540.10627066304,
        ["y"] = -229.84323648654,
        ["g"] = 17,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
      [3] = {
        ["x"] = 540.90562954014,
        ["y"] = -216.9143096708,
        ["g"] = 17,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
      [4] = {
        ["x"] = 564.26972055169,
        ["y"] = -211.36325769621,
        ["g"] = 18,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
      [5] = {
        ["x"] = 601.9504630954,
        ["y"] = -229.8188562734,
        ["g"] = 22,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
      [6] = {
        ["x"] = 388.05439766303,
        ["y"] = -355.62847808756,
        ["g"] = 26,
        ["sublevel"] = 1,
        ["scale"] = 1.7,
      },
      [7] = {
        ["x"] = 385.47614696793,
        ["y"] = -369.37921077844,
        ["g"] = 26,
        ["sublevel"] = 1,
        ["scale"] = 1.7,
      },
      [8] = {
        ["x"] = 319.29852253269,
        ["y"] = -362.99909339474,
        ["sublevel"] = 1,
        ["scale"] = 1.7,
      },
      [9] = {
        ["x"] = 322.75737185302,
        ["y"] = -386.86789252242,
        ["g"] = 27,
        ["sublevel"] = 1,
        ["scale"] = 1.7,
      },
      [10] = {
        ["x"] = 309.82755860844,
        ["y"] = -393.92619270036,
        ["g"] = 27,
        ["sublevel"] = 1,
        ["scale"] = 1.7,
      },
      [11] = {
        ["x"] = 449.12910089747,
        ["y"] = -166.59044783817,
        ["g"] = 14,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
      [12] = {
        ["x"] = 444.07832747222,
        ["y"] = -94.240498250215,
        ["g"] = 15,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
      [13] = {
        ["x"] = 455.558139208,
        ["y"] = -93.942664797503,
        ["g"] = 15,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
      [14] = {
        ["x"] = 588.63131680649,
        ["y"] = -288.29170086722,
        ["g"] = 21,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
      [15] = {
        ["x"] = 574.38992480055,
        ["y"] = -288.11184711898,
        ["g"] = 21,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
    },
  },
  [14] = {
    ["name"] = "Earthen Warder",
    ["id"] = 184132,
    ["count"] = 5,
    ["health"] = 5706059,
    ["scale"] = 1,
    ["displayId"] = 6009,
    ["creatureType"] = "Humanoid",
    ["level"] = 70,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Incapacitate"] = true,
      ["Silence"] = true,
      ["Knock"] = true,
      ["Grip"] = true,
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
      ["Sleep Walk"] = true,
      ["Mind Soothe"] = true,
    },
    ["spells"] = {
      [369365] = {
      },
      [369366] = {
      },
      [369368] = {
      },
      [369400] = {
      },
      [373662] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 575.60483772616,
        ["y"] = -247.46232235038,
        ["g"] = 19,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
      [2] = {
        ["x"] = 576.27345582417,
        ["y"] = -236.02288726596,
        ["g"] = 19,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
      [3] = {
        ["x"] = 601.70633216724,
        ["y"] = -217.23327159003,
        ["g"] = 22,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
      [4] = {
        ["x"] = 247.20262610834,
        ["y"] = -458.9520130376,
        ["g"] = 29,
        ["sublevel"] = 1,
        ["scale"] = 1.7,
      },
      [5] = {
        ["x"] = 328.70567349304,
        ["y"] = -476.15470822099,
        ["g"] = 32,
        ["sublevel"] = 1,
        ["scale"] = 1.7,
      },
      [6] = {
        ["x"] = 327.82239348957,
        ["y"] = -492.96375252222,
        ["g"] = 32,
        ["sublevel"] = 1,
        ["scale"] = 1.7,
      },
      [7] = {
        ["x"] = 383.71046408617,
        ["y"] = -476.82942931392,
        ["g"] = 33,
        ["sublevel"] = 1,
        ["scale"] = 1.7,
      },
      [8] = {
        ["x"] = 384.90548541041,
        ["y"] = -492.53388109715,
        ["g"] = 33,
        ["sublevel"] = 1,
        ["scale"] = 1.7,
      },
      [9] = {
        ["x"] = 580.08215737078,
        ["y"] = -279.00148695316,
        ["g"] = 21,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
      [10] = {
        ["x"] = 250.08082793241,
        ["y"] = -497.94043417568,
        ["g"] = 30,
        ["sublevel"] = 1,
        ["scale"] = 1.7,
      },
      [11] = {
        ["x"] = 574.33107368715,
        ["y"] = -202.66163297149,
        ["g"] = 18,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
    },
  },
  [15] = {
    ["name"] = "Runic Protector",
    ["id"] = 184107,
    ["count"] = 25,
    ["health"] = 10740817,
    ["scale"] = 1,
    ["stealthDetect"] = true,
    ["displayId"] = 108686,
    ["creatureType"] = "Elemental",
    ["level"] = 70,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [369327] = {
      },
      [369328] = {
      },
      [369335] = {
      },
      [369337] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 583.35106679808,
        ["y"] = -166.36254850566,
        ["g"] = 20,
        ["sublevel"] = 1,
        ["scale"] = 1.8,
      },
      [2] = {
        ["x"] = 615.4222293192,
        ["y"] = -222.27298381361,
        ["g"] = 22,
        ["sublevel"] = 1,
        ["scale"] = 1.8,
      },
    },
  },
  [16] = {
    ["name"] = "Skittering Crawler",
    ["id"] = 184303,
    ["count"] = 4,
    ["health"] = 5370409,
    ["scale"] = 1,
    ["displayId"] = 84003,
    ["creatureType"] = "Beast",
    ["level"] = 70,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Incapacitate"] = true,
      ["Silence"] = true,
      ["Knock"] = true,
      ["Grip"] = true,
      ["Mind Control"] = true,
      ["Polymorph"] = true,
      ["Root"] = true,
      ["Fear"] = true,
      ["Disorient"] = true,
      ["Imprison"] = true,
      ["Sap"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
      ["Sleep Walk"] = true,
      ["Scare Beast"] = true,
      ["Hibernate"] = true,
    },
    ["spells"] = {
      [369417] = {
      },
      [369419] = {
      },
      [369423] = {
      },
      [369424] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 648.14345131443,
        ["y"] = -220.57170750585,
        ["g"] = 23,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
      [2] = {
        ["x"] = 643.89969553841,
        ["y"] = -229.2934130592,
        ["g"] = 23,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
      [3] = {
        ["x"] = 667.93838481261,
        ["y"] = -297.01776724918,
        ["g"] = 25,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
      [4] = {
        ["x"] = 675.66616767265,
        ["y"] = -304.71850202575,
        ["g"] = 25,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
    },
  },
  [17] = {
    ["name"] = "Cavern Seeker",
    ["id"] = 184301,
    ["count"] = 4,
    ["health"] = 5370409,
    ["scale"] = 1,
    ["displayId"] = 57297,
    ["creatureType"] = "Beast",
    ["level"] = 70,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Incapacitate"] = true,
      ["Silence"] = true,
      ["Knock"] = true,
      ["Grip"] = true,
      ["Mind Control"] = true,
      ["Polymorph"] = true,
      ["Root"] = true,
      ["Fear"] = true,
      ["Disorient"] = true,
      ["Imprison"] = true,
      ["Sap"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
      ["Sleep Walk"] = true,
      ["Scare Beast"] = true,
      ["Hibernate"] = true,
    },
    ["spells"] = {
      [369411] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 674.22359892696,
        ["y"] = -265.44543081496,
        ["g"] = 24,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
      [2] = {
        ["x"] = 680.09147238739,
        ["y"] = -275.54007745035,
        ["g"] = 24,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
      [3] = {
        ["x"] = 689.29123422744,
        ["y"] = -267.58352331948,
        ["g"] = 24,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
    },
  },
  [18] = {
    ["name"] = "Emberon",
    ["id"] = 184422,
    ["count"] = 0,
    ["health"] = 30113726,
    ["scale"] = 1.6,
    ["displayId"] = 107816,
    ["creatureType"] = "Giant",
    ["level"] = 70,
    ["isBoss"] = true,
    ["encounterID"] = 2476,
    ["instanceID"] = 1197,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [368990] = {
      },
      [368996] = {
      },
      [369006] = {
      },
      [369022] = {
      },
      [369025] = {
      },
      [369026] = {
      },
      [369029] = {
      },
      [369031] = {
      },
      [369033] = {
      },
      [369061] = {
      },
      [369110] = {
      },
      [369116] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 649.30350045251,
        ["y"] = -325.99511602069,
        ["sublevel"] = 1,
      },
    },
  },
  [19] = {
    ["name"] = "Ebonstone Golem",
    ["id"] = 184300,
    ["count"] = 15,
    ["health"] = 12083419,
    ["scale"] = 1,
    ["displayId"] = 108689,
    ["creatureType"] = "Elemental",
    ["level"] = 70,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [381593] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 373.1442193038,
        ["y"] = -360.05821412017,
        ["g"] = 26,
        ["sublevel"] = 1,
        ["scale"] = 2,
      },
      [2] = {
        ["x"] = 314.31676059288,
        ["y"] = -410.1419273919,
        ["g"] = 27,
        ["sublevel"] = 1,
        ["scale"] = 2,
      },
      [3] = {
        ["x"] = 295.90113745064,
        ["y"] = -492.54359688614,
        ["g"] = 31,
        ["sublevel"] = 1,
        ["scale"] = 2,
      },
      [4] = {
        ["x"] = 295.77484159831,
        ["y"] = -475.98907622498,
        ["g"] = 31,
        ["sublevel"] = 1,
        ["scale"] = 2,
      },
      [5] = {
        ["x"] = 342.27174721106,
        ["y"] = -485.29633123689,
        ["g"] = 32,
        ["sublevel"] = 1,
        ["scale"] = 2,
      },
    },
  },
  [20] = {
    ["name"] = "Earthen Guardian",
    ["id"] = 184131,
    ["count"] = 15,
    ["health"] = 10740817,
    ["scale"] = 1,
    ["displayId"] = 6026,
    ["creatureType"] = "Humanoid",
    ["level"] = 70,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Mind Soothe"] = true,
    },
    ["spells"] = {
      [382573] = {
      },
      [382576] = {
      },
      [382578] = {
      },
      [382696] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 251.15460528568,
        ["y"] = -470.84143048769,
        ["g"] = 29,
        ["sublevel"] = 1,
        ["scale"] = 1.7,
      },
      [2] = {
        ["x"] = 371.22634262236,
        ["y"] = -484.68009124062,
        ["g"] = 33,
        ["sublevel"] = 1,
        ["scale"] = 1.7,
      },
    },
  },
  [21] = {
    ["name"] = "Infinite Agent",
    ["id"] = 184335,
    ["count"] = 5,
    ["health"] = 8055613,
    ["scale"] = 1,
    ["displayId"] = 19058,
    ["creatureType"] = "Dragonkin",
    ["level"] = 70,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Incapacitate"] = true,
      ["Silence"] = true,
      ["Knock"] = true,
      ["Grip"] = true,
      ["Mind Control"] = true,
      ["Root"] = true,
      ["Fear"] = true,
      ["Disorient"] = true,
      ["Repentance"] = true,
      ["Sap"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
      ["Sleep Walk"] = true,
      ["Hibernate"] = true,
      ["Mind Soothe"] = true,
    },
    ["spells"] = {
      [377486] = {
      },
      [377500] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 415.10931266329,
        ["y"] = -474.57686924515,
        ["g"] = 34,
        ["sublevel"] = 1,
        ["scale"] = 1.7,
      },
      [2] = {
        ["x"] = 415.74691932582,
        ["y"] = -488.56935966792,
        ["g"] = 34,
        ["sublevel"] = 1,
        ["scale"] = 1.7,
      },
      [3] = {
        ["x"] = 470.67761941539,
        ["y"] = -431.2745341579,
        ["sublevel"] = 1,
        ["scale"] = 1.7,
      },
    },
  },
  [22] = {
    ["name"] = "Infinite Timereaver",
    ["id"] = 184331,
    ["count"] = 15,
    ["health"] = 10740817,
    ["scale"] = 1,
    ["displayId"] = 106470,
    ["creatureType"] = "Dragonkin",
    ["level"] = 70,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Mind Soothe"] = true,
    },
    ["spells"] = {
      [377510] = {
      },
      [377511] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 415.52983834414,
        ["y"] = -435.41788483713,
        ["sublevel"] = 1,
        ["scale"] = 1.7,
      },
      [2] = {
        ["x"] = 491.93727791837,
        ["y"] = -430.7596330914,
        ["sublevel"] = 1,
        ["scale"] = 1.7,
      },
      [3] = {
        ["x"] = 530.99748116287,
        ["y"] = -421.71109494447,
        ["g"] = 37,
        ["sublevel"] = 1,
        ["scale"] = 1.7,
      },
      [4] = {
        ["x"] = 530.89185741507,
        ["y"] = -435.39478143835,
        ["g"] = 37,
        ["sublevel"] = 1,
        ["scale"] = 1.7,
      },
    },
  },
  [23] = {
    ["name"] = "Infinite Whelp",
    ["id"] = 191311,
    ["count"] = 1,
    ["health"] = 1342602,
    ["scale"] = 0.8,
    ["displayId"] = 101939,
    ["creatureType"] = "Dragonkin",
    ["level"] = 70,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Silence"] = true,
      ["Mind Soothe"] = true,
    },
    ["spells"] = {
    },
    ["clones"] = {
      [1] = {
        ["x"] = 495.2502740911,
        ["y"] = -461.05091857646,
        ["g"] = 36,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
      [2] = {
        ["x"] = 502.63286455817,
        ["y"] = -469.02905854993,
        ["g"] = 36,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
      [3] = {
        ["x"] = 508.08046199448,
        ["y"] = -462.86411422684,
        ["g"] = 36,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
      [4] = {
        ["x"] = 498.2176674901,
        ["y"] = -402.89414466036,
        ["g"] = 35,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
      [5] = {
        ["x"] = 507.12963509362,
        ["y"] = -403.01765669616,
        ["g"] = 35,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
      [6] = {
        ["x"] = 516.15929604391,
        ["y"] = -402.65751097997,
        ["g"] = 35,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
      [7] = {
        ["x"] = 499.14255071555,
        ["y"] = -393.4243047273,
        ["g"] = 35,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
      [8] = {
        ["x"] = 508.07581001779,
        ["y"] = -393.18348011518,
        ["g"] = 35,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
      [9] = {
        ["x"] = 518.33127400651,
        ["y"] = -393.6148147499,
        ["g"] = 35,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
    },
  },
  [24] = {
    ["name"] = "Chrono-Lord Deios",
    ["id"] = 184125,
    ["count"] = 0,
    ["health"] = 66919390,
    ["scale"] = 1.6,
    ["displayId"] = 106056,
    ["creatureType"] = "Dragonkin",
    ["level"] = 70,
    ["isBoss"] = true,
    ["encounterID"] = 2479,
    ["instanceID"] = 1197,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Mind Soothe"] = true,
    },
    ["spells"] = {
      [375727] = {
      },
      [376049] = {
      },
      [376208] = {
      },
      [376209] = {
      },
      [376292] = {
      },
      [376319] = {
      },
      [377395] = {
      },
      [377405] = {
      },
      [377561] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 692.32272819066,
        ["y"] = -433.55416304355,
        ["sublevel"] = 1,
      },
    },
  },
};
