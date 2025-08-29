local addonName = ...
local MDT = MDT
local L = MDT.L
local dungeonIndex = 37
MDT.dungeonList[dungeonIndex] = L["TazaveshLower"]
MDT.mapInfo[dungeonIndex] = {
  teleportId = 367416,
  -- iconId = 4181531, --TODO: this is a texture, not an icon, looks weird ingame
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
  [1] = { customTextures = 'Interface\\AddOns\\' .. addonName .. '\\TheWarWithin\\Textures\\TazaveshLower' }
}

MDT.dungeonSubLevels[dungeonIndex] = {
  [1] = L["TazaveshLower"],
}

MDT.dungeonTotalCount[dungeonIndex] = { normal = 360, teeming = 1000, teemingEnabled = true }

MDT.mapPOIs[dungeonIndex] = {
  [1] = {
    [1] = {
      ["template"] = "MapLinkPinTemplate",
      ["type"] = "dungeonEntrance",
      ["x"] = 830.70299300076,
      ["y"] = -361.59677832084,
    },
    [2] = {
      ["template"] = "MapLinkPinTemplate",
      ["type"] = "textFrame",
      ["x"] = 468.95208748999,
      ["y"] = -307.09992379279,
      ["text"] = "",
    },
    [3] = {
      ["template"] = "MapLinkPinTemplate",
      ["type"] = "generalNote",
      ["x"] = 229.94807557468,
      ["y"] = -198.37060367333,
      ["text"] = "streetBazaarEventNote1",
    },
    [4] = {
      ["template"] = "MapLinkPinTemplate",
      ["type"] = "generalNote",
      ["x"] = 302.60123254559,
      ["y"] = -177.32621741281,
      ["text"] = "streetBazaarEventNote2",
    },
    [5] = {
      ["template"] = "MapLinkPinTemplate",
      ["type"] = "generalNote",
      ["x"] = 349.19950878541,
      ["y"] = -242.46363267786,
      ["text"] = "streetBazaarEventNote3",
    },
  },
};

MDT.dungeonEnemies[dungeonIndex] = {
  [1] = {
    ["name"] = "Customs Security",
    ["id"] = 177807,
    ["count"] = 4,
    ["health"] = 102034571,
    ["scale"] = 1.3,
    ["displayId"] = 100873,
    ["creatureType"] = "Humanoid",
    ["level"] = 80,
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
      [355888] = {
        ["magic"] = true,
      },
      [355889] = {
      },
      [355891] = {
      },
      [355900] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 806.49651566762,
        ["y"] = -367.26350529722,
        ["g"] = 1,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 795.14071689942,
        ["y"] = -373.67262804227,
        ["g"] = 1,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 734.19226032493,
        ["y"] = -375.67029579629,
        ["g"] = 3,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 676.81632541198,
        ["y"] = -330.93683796714,
        ["g"] = 6,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 660.95877571101,
        ["y"] = -343.70338830544,
        ["g"] = 7,
        ["sublevel"] = 1,
        ["inspiring"] = true,
      },
      [6] = {
        ["x"] = 728.8060554646,
        ["y"] = -315.65705658121,
        ["g"] = 5,
        ["sublevel"] = 1,
      },
      [7] = {
        ["x"] = 710.25344642709,
        ["y"] = -353.38055993989,
        ["g"] = 4,
        ["sublevel"] = 1,
      },
      [8] = {
        ["x"] = 807.08365608444,
        ["y"] = -351.15435902929,
        ["g"] = 1,
        ["sublevel"] = 1,
      },
      [9] = {
        ["x"] = 795.1856515909,
        ["y"] = -345.13735356408,
        ["g"] = 1,
        ["sublevel"] = 1,
      },
    },
  },
  [2] = {
    ["name"] = "Gatewarden Zo'mazz",
    ["id"] = 178392,
    ["count"] = 18,
    ["health"] = 148413922,
    ["scale"] = 1.8,
    ["displayId"] = 101505,
    ["creatureType"] = "Humanoid",
    ["level"] = 81,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Mind Soothe"] = true,
    },
    ["spells"] = {
      [352796] = {
      },
      [356548] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 795.29449972623,
        ["y"] = -359.10020674994,
        ["g"] = 1,
        ["sublevel"] = 1,
      },
    },
  },
  [3] = {
    ["name"] = "Support Officer",
    ["id"] = 177817,
    ["count"] = 4,
    ["health"] = 83482831,
    ["scale"] = 1.2,
    ["displayId"] = 100876,
    ["creatureType"] = "Humanoid",
    ["level"] = 80,
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
      [354297] = {
        ["interruptible"] = true,
      },
      [355934] = {
        ["interruptible"] = true,
        ["magic"] = true,
      },
      [355980] = {
        ["magic"] = true,
      },
      [356549] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 720.61011606003,
        ["y"] = -320.98645682929,
        ["g"] = 5,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 698.10786260652,
        ["y"] = -353.60227396425,
        ["g"] = 4,
        ["sublevel"] = 1,
        ["disguised"] = true,
      },
      [3] = {
        ["x"] = 685.34961115295,
        ["y"] = -324.66607871281,
        ["g"] = 6,
        ["sublevel"] = 1,
      },
    },
  },
  [4] = {
    ["name"] = "Interrogation Specialist",
    ["id"] = 177816,
    ["count"] = 4,
    ["health"] = 83482831,
    ["scale"] = 1.3,
    ["displayId"] = 100877,
    ["creatureType"] = "Humanoid",
    ["level"] = 80,
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
      [355915] = {
        ["magic"] = true,
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 728.38249184089,
        ["y"] = -364.48221112002,
        ["g"] = 3,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 728.45919346052,
        ["y"] = -327.28290413951,
        ["g"] = 5,
        ["sublevel"] = 1,
        ["inspiring"] = true,
      },
      [3] = {
        ["x"] = 676.5579355197,
        ["y"] = -319.03875058647,
        ["g"] = 6,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 651.92529843617,
        ["y"] = -350.3671097149,
        ["g"] = 7,
        ["sublevel"] = 1,
      },
    },
  },
  [5] = {
    ["name"] = "Armored Overseer",
    ["id"] = 177808,
    ["count"] = 8,
    ["health"] = 129862181,
    ["scale"] = 1.6,
    ["displayId"] = 100874,
    ["creatureType"] = "Humanoid",
    ["level"] = 81,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Mind Soothe"] = true,
    },
    ["spells"] = {
      [352796] = {
      },
      [356001] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 703.83666808408,
        ["y"] = -342.47277805886,
        ["g"] = 4,
        ["sublevel"] = 1,
        ["patrol"] = {
          [1] = {
            ["x"] = 703.83666808408,
            ["y"] = -342.47277805886,
          },
          [2] = {
            ["x"] = 718.95069470889,
            ["y"] = -341.45547028851,
          },
          [3] = {
            ["x"] = 715.99652789575,
            ["y"] = -326.68458771433,
          },
          [4] = {
            ["x"] = 690.99961984191,
            ["y"] = -324.41215916706,
          },
          [5] = {
            ["x"] = 685.3185242195,
            ["y"] = -340.77374414976,
          },
        },
      },
      [2] = {
        ["x"] = 620.6842366676,
        ["y"] = -370.06677559681,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 620.39336224905,
        ["y"] = -350.1935945753,
        ["sublevel"] = 1,
        ["disguised"] = true,
      },
    },
  },
  [6] = {
    ["name"] = "Portalmancer Zo'honn",
    ["id"] = 179334,
    ["count"] = 24,
    ["health"] = 185517402,
    ["scale"] = 2.2,
    ["displayId"] = 100877,
    ["creatureType"] = "Humanoid",
    ["level"] = 81,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Mind Soothe"] = true,
    },
    ["spells"] = {
      [352390] = {
      },
      [352393] = {
      },
      [356324] = {
      },
      [356537] = {
        ["interruptible"] = true,
      },
      [356548] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 702.51607523715,
        ["y"] = -293.9963829565,
        ["sublevel"] = 1,
      },
    },
  },
  [7] = {
    ["name"] = "Zo'phex",
    ["id"] = 175616,
    ["count"] = 0,
    ["health"] = 556827200,
    ["scale"] = 2,
    ["displayId"] = 100049,
    ["creatureType"] = "Humanoid",
    ["level"] = 82,
    ["isBoss"] = true,
    ["encounterID"] = 2437,
    ["instanceID"] = 0,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Mind Soothe"] = true,
    },
    ["spells"] = {
      [345770] = {
      },
      [345989] = {
      },
      [345990] = {
      },
      [346006] = {
      },
      [346028] = {
      },
      [346204] = {
      },
      [347949] = {
      },
      [348128] = {
      },
      [348350] = {
      },
      [353411] = {
      },
      [353414] = {
      },
      [1236348] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 701.99494602285,
        ["y"] = -257.56283676452,
        ["sublevel"] = 1,
      },
    },
  },
  [8] = {
    ["name"] = "Tracker Zo'korss",
    ["id"] = 179837,
    ["count"] = 18,
    ["health"] = 185517402,
    ["scale"] = 2,
    ["stealthDetect"] = true,
    ["displayId"] = 101474,
    ["creatureType"] = "Humanoid",
    ["level"] = 81,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Mind Soothe"] = true,
    },
    ["spells"] = {
      [356001] = {
      },
      [356929] = {
      },
      [356930] = {
      },
      [356942] = {
      },
      [356943] = {
        ["magic"] = true,
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
    ["health"] = 120586312,
    ["scale"] = 2,
    ["displayId"] = 101639,
    ["creatureType"] = "Beast",
    ["level"] = 81,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [356404] = {
      },
      [356407] = {
        ["interruptible"] = true,
        ["curse"] = true,
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 452.3883636263,
        ["y"] = -455.15001765978,
        ["g"] = 29,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 435.8283012067,
        ["y"] = -463.85593598508,
        ["g"] = 29,
        ["sublevel"] = 1,
      },
    },
  },
  [10] = {
    ["name"] = "Enraged Direhorn",
    ["id"] = 180495,
    ["count"] = 10,
    ["health"] = 148413922,
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
      [357509] = {
      },
      [357512] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 404.35109181963,
        ["y"] = -495.11871975721,
        ["sublevel"] = 1,
      },
    },
  },
  [11] = {
    ["name"] = "Frenzied Nightclaw",
    ["id"] = 180567,
    ["count"] = 4,
    ["health"] = 74206961,
    ["scale"] = 1.3,
    ["displayId"] = 101951,
    ["creatureType"] = "Beast",
    ["level"] = 80,
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
    ["health"] = 111310441,
    ["scale"] = 1.3,
    ["displayId"] = 101475,
    ["creatureType"] = "Humanoid",
    ["level"] = 80,
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
      [355637] = {
      },
      [355638] = {
      },
      [355640] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 256.39569806504,
        ["y"] = -433.31392338702,
        ["g"] = 22,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 246.25422329255,
        ["y"] = -441.39454649165,
        ["g"] = 22,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 235.83740822427,
        ["y"] = -410.44686476882,
        ["g"] = 21,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 236.44821616399,
        ["y"] = -399.36805043568,
        ["g"] = 21,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 198.84360007281,
        ["y"] = -433.74105267688,
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
        ["x"] = 202.81838093026,
        ["y"] = -466.65577770554,
        ["g"] = 24,
        ["sublevel"] = 1,
      },
      [9] = {
        ["x"] = 164.77120583548,
        ["y"] = -471.21371142123,
        ["g"] = 25,
        ["sublevel"] = 1,
        ["disguised"] = true,
      },
      [10] = {
        ["x"] = 176.86888906463,
        ["y"] = -471.88129043093,
        ["g"] = 25,
        ["sublevel"] = 1,
      },
      [11] = {
        ["x"] = 205.3323945708,
        ["y"] = -344.32977573308,
        ["g"] = 18,
        ["sublevel"] = 1,
      },
      [12] = {
        ["x"] = 214.61742635975,
        ["y"] = -352.61621750911,
        ["g"] = 18,
        ["sublevel"] = 1,
      },
      [13] = {
        ["x"] = 178.55048440402,
        ["y"] = -340.71342106639,
        ["sublevel"] = 1,
      },
    },
  },
  [13] = {
    ["name"] = "Veteran Sparkcaster",
    ["id"] = 179841,
    ["count"] = 4,
    ["health"] = 83482831,
    ["scale"] = 1.3,
    ["displayId"] = 101476,
    ["creatureType"] = "Humanoid",
    ["level"] = 80,
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
      [355641] = {
        ["interruptible"] = true,
        ["magic"] = true,
      },
      [355642] = {
        ["interruptible"] = true,
      },
      [355644] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 226.01415123343,
        ["y"] = -415.78901830629,
        ["g"] = 21,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 227.53188124077,
        ["y"] = -393.31556950223,
        ["g"] = 21,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 203.13282349726,
        ["y"] = -421.29613965601,
        ["g"] = 23,
        ["sublevel"] = 1,
        ["disguised"] = true,
      },
      [4] = {
        ["x"] = 194.68544179238,
        ["y"] = -373.30587204992,
        ["g"] = 19,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 196.10038203746,
        ["y"] = -385.54637064953,
        ["g"] = 19,
        ["sublevel"] = 1,
        ["disguised"] = true,
      },
      [6] = {
        ["x"] = 213.33451930542,
        ["y"] = -460.64380693332,
        ["g"] = 24,
        ["sublevel"] = 1,
      },
      [7] = {
        ["x"] = 203.44158832475,
        ["y"] = -356.08963118854,
        ["g"] = 18,
        ["sublevel"] = 1,
      },
    },
  },
  [14] = {
    ["name"] = "Commerce Enforcer",
    ["id"] = 179842,
    ["count"] = 8,
    ["health"] = 140993223,
    ["scale"] = 1.6,
    ["displayId"] = 101477,
    ["creatureType"] = "Humanoid",
    ["level"] = 81,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Mind Soothe"] = true,
    },
    ["spells"] = {
      [355477] = {
      },
      [1244443] = {
      },
      [1244446] = {
        ["enrage"] = true,
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 226.5558481997,
        ["y"] = -405.59087811411,
        ["g"] = 21,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 210.60860808271,
        ["y"] = -431.34210626824,
        ["g"] = 23,
        ["sublevel"] = 1,
        ["patrol"] = {
          [1] = {
            ["x"] = 210.60860808271,
            ["y"] = -431.34210626824,
          },
          [2] = {
            ["x"] = 217.60917087854,
            ["y"] = -423.32743893655,
          },
          [3] = {
            ["x"] = 210.60860808271,
            ["y"] = -431.34210626824,
          },
          [4] = {
            ["x"] = 198.89181429839,
            ["y"] = -446.97803093873,
          },
          [5] = {
            ["x"] = 186.41359227221,
            ["y"] = -458.87587601971,
          },
          [6] = {
            ["x"] = 178.43334257657,
            ["y"] = -461.77779213354,
          },
          [7] = {
            ["x"] = 186.41359227221,
            ["y"] = -458.87587601971,
          },
          [8] = {
            ["x"] = 198.89181429839,
            ["y"] = -446.97803093873,
          },
        },
      },
      [3] = {
        ["x"] = 205.99866201644,
        ["y"] = -378.23167609295,
        ["g"] = 19,
        ["sublevel"] = 1,
        ["patrol"] = {
          [1] = {
            ["x"] = 205.99866201644,
            ["y"] = -378.23167609295,
          },
          [2] = {
            ["x"] = 221.74447562371,
            ["y"] = -384.41325533984,
          },
          [3] = {
            ["x"] = 205.99866201644,
            ["y"] = -378.23167609295,
          },
          [4] = {
            ["x"] = 190.113610385,
            ["y"] = -363.80966191735,
          },
          [5] = {
            ["x"] = 172.70212939591,
            ["y"] = -352.63729978831,
          },
          [6] = {
            ["x"] = 190.113610385,
            ["y"] = -363.80966191735,
          },
        },
      },
    },
  },
  [15] = {
    ["name"] = "Commander Zo'far",
    ["id"] = 179821,
    ["count"] = 30,
    ["health"] = 185517402,
    ["scale"] = 2,
    ["displayId"] = 101473,
    ["creatureType"] = "Humanoid",
    ["level"] = 81,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Mind Soothe"] = true,
    },
    ["spells"] = {
      [355473] = {
      },
      [355476] = {
      },
      [355477] = {
      },
      [355479] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 167.68830870964,
        ["y"] = -406.49839634857,
        ["sublevel"] = 1,
      },
    },
  },
  [16] = {
    ["name"] = "Cartel Muscle",
    ["id"] = 180348,
    ["count"] = 8,
    ["health"] = 139482458,
    ["scale"] = 1.7,
    ["displayId"] = 101598,
    ["creatureType"] = "Humanoid",
    ["level"] = 81,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Mind Soothe"] = true,
    },
    ["spells"] = {
      [356967] = {
      },
      [357229] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 281.91917692694,
        ["y"] = -316.50386390063,
        ["g"] = 16,
        ["sublevel"] = 1,
        ["disguised"] = true,
      },
      [2] = {
        ["x"] = 351.39318832028,
        ["y"] = -344.48917015931,
        ["g"] = 15,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 358.10331838439,
        ["y"] = -294.531033683,
        ["g"] = 14,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 418.54745831316,
        ["y"] = -306.92796159389,
        ["g"] = 13,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 400.56401762681,
        ["y"] = -254.96782124994,
        ["g"] = 12,
        ["sublevel"] = 1,
        ["patrol"] = {
          [1] = {
            ["x"] = 400.56401762681,
            ["y"] = -254.96782124994,
          },
          [2] = {
            ["x"] = 400.73684638242,
            ["y"] = -284.37896791495,
          },
          [3] = {
            ["x"] = 402.1878122863,
            ["y"] = -309.33543550819,
          },
          [4] = {
            ["x"] = 391.01541876941,
            ["y"] = -317.75097968318,
          },
          [5] = {
            ["x"] = 402.1878122863,
            ["y"] = -309.33543550819,
          },
          [6] = {
            ["x"] = 400.73684638242,
            ["y"] = -284.37896791495,
          },
          [7] = {
            ["x"] = 400.15646943722,
            ["y"] = -246.50899166315,
          },
          [8] = {
            ["x"] = 404.25545358744,
            ["y"] = -240.45858028158,
          },
          [9] = {
            ["x"] = 419.92577235309,
            ["y"] = -232.18812641942,
          },
          [10] = {
            ["x"] = 436.3215897646,
            ["y"] = -219.1294960602,
          },
          [11] = {
            ["x"] = 437.77253997456,
            ["y"] = -200.26708055507,
          },
          [12] = {
            ["x"] = 436.3215897646,
            ["y"] = -219.1294960602,
          },
          [13] = {
            ["x"] = 419.92577235309,
            ["y"] = -232.18812641942,
          },
          [14] = {
            ["x"] = 404.25545358744,
            ["y"] = -240.45858028158,
          },
          [15] = {
            ["x"] = 400.15646943722,
            ["y"] = -246.50899166315,
          },
          [16] = {
            ["x"] = 400.56401762681,
            ["y"] = -254.96782124994,
          },
        },
      },
      [6] = {
        ["x"] = 339.54879531601,
        ["y"] = -350.04025036946,
        ["g"] = 15,
        ["sublevel"] = 1,
      },
    },
  },
  [17] = {
    ["name"] = "Cartel Smuggler",
    ["id"] = 180335,
    ["count"] = 5,
    ["health"] = 83482831,
    ["scale"] = 1.3,
    ["displayId"] = 101595,
    ["creatureType"] = "Humanoid",
    ["level"] = 80,
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
      [357029] = {
        ["magic"] = true,
      },
      [357042] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 288.7183973812,
        ["y"] = -326.9933833136,
        ["g"] = 16,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 345.57094758597,
        ["y"] = -333.8780339309,
        ["g"] = 15,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 368.62499415345,
        ["y"] = -301.07707143717,
        ["g"] = 14,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 414.13721535331,
        ["y"] = -294.99126158236,
        ["g"] = 13,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 392.34823527599,
        ["y"] = -263.80009800083,
        ["g"] = 12,
        ["sublevel"] = 1,
      },
      [6] = {
        ["x"] = 400.47679679254,
        ["y"] = -270.46065704506,
        ["g"] = 12,
        ["sublevel"] = 1,
        ["inspiring"] = true,
      },
      [7] = {
        ["x"] = 410.67820084526,
        ["y"] = -213.24354887894,
        ["g"] = 11,
        ["sublevel"] = 1,
        ["disguised"] = true,
      },
      [8] = {
        ["x"] = 422.37907583214,
        ["y"] = -213.42796409075,
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
    ["health"] = 74206961,
    ["scale"] = 1.3,
    ["displayId"] = 101596,
    ["creatureType"] = "Humanoid",
    ["level"] = 80,
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
      [357019] = {
      },
      [357196] = {
        ["interruptible"] = true,
      },
      [357197] = {
      },
      [357201] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 277.02133392184,
        ["y"] = -327.4738898899,
        ["g"] = 16,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 334.43699489026,
        ["y"] = -340.04504552634,
        ["g"] = 15,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 358.26798657278,
        ["y"] = -306.14952117246,
        ["g"] = 14,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 406.90147414182,
        ["y"] = -304.9429234257,
        ["g"] = 13,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 408.80515566259,
        ["y"] = -264.255300504,
        ["g"] = 12,
        ["sublevel"] = 1,
        ["disguised"] = true,
      },
      [6] = {
        ["x"] = 415.98788015518,
        ["y"] = -223.6553839144,
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
    ["health"] = 92988305,
    ["scale"] = 1.3,
    ["displayId"] = 101734,
    ["creatureType"] = "Humanoid",
    ["level"] = 80,
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
      [30831] = {
      },
      [355830] = {
      },
      [355832] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 333.70148627197,
        ["y"] = -319.35374341242,
        ["sublevel"] = 1,
        ["patrol"] = {
          [1] = {
            ["x"] = 341.53666134872,
            ["y"] = -309.77742965312,
          },
          [2] = {
            ["x"] = 334.21123386743,
            ["y"] = -320.64630528132,
          },
          [3] = {
            ["x"] = 321.4428155217,
            ["y"] = -334.43040289855,
          },
          [4] = {
            ["x"] = 316.94484319116,
            ["y"] = -353.87321888976,
          },
          [5] = {
            ["x"] = 321.4428155217,
            ["y"] = -334.43040289855,
          },
          [6] = {
            ["x"] = 334.21123386743,
            ["y"] = -320.64630528132,
          },
        },
      },
      [2] = {
        ["x"] = 419.45472715604,
        ["y"] = -243.26636214754,
        ["sublevel"] = 1,
        ["patrol"] = {
          [1] = {
            ["x"] = 382.1651356964,
            ["y"] = -294.0498862927,
          },
          [2] = {
            ["x"] = 388.49775805735,
            ["y"] = -286.64911253299,
          },
          [3] = {
            ["x"] = 390.38398499076,
            ["y"] = -272.71992893115,
          },
          [4] = {
            ["x"] = 388.78791308014,
            ["y"] = -246.74778991338,
          },
          [5] = {
            ["x"] = 401.41122541913,
            ["y"] = -241.08906369245,
          },
          [6] = {
            ["x"] = 431.01077341161,
            ["y"] = -246.31251072321,
          },
          [7] = {
            ["x"] = 401.41122541913,
            ["y"] = -241.08906369245,
          },
          [8] = {
            ["x"] = 388.78791308014,
            ["y"] = -246.74778991338,
          },
          [9] = {
            ["x"] = 390.38398499076,
            ["y"] = -272.71992893115,
          },
          [10] = {
            ["x"] = 388.49775805735,
            ["y"] = -286.64911253299,
          },
          [11] = {
            ["x"] = 382.1651356964,
            ["y"] = -294.0498862927,
          },
        },
      },
      [3] = {
        ["x"] = 445.13970078174,
        ["y"] = -231.39256769216,
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
        ["x"] = 302.66515392585,
        ["y"] = -338.75229264277,
        ["sublevel"] = 1,
        ["patrol"] = {
          [1] = {
            ["x"] = 302.66515392585,
            ["y"] = -338.75229264277,
          },
          [2] = {
            ["x"] = 305.6273907493,
            ["y"] = -321.51688639304,
          },
          [3] = {
            ["x"] = 302.66515392585,
            ["y"] = -338.75229264277,
          },
          [4] = {
            ["x"] = 288.50610607977,
            ["y"] = -349.81054103857,
          },
        },
      },
    },
  },
  [20] = {
    ["name"] = "Oasis Security",
    ["id"] = 179269,
    ["count"] = 0,
    ["health"] = 118731144,
    ["scale"] = 2,
    ["displayId"] = 101270,
    ["creatureType"] = "Humanoid",
    ["level"] = 81,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Mind Soothe"] = true,
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
      [2] = {
        ["x"] = 163.63133917638,
        ["y"] = -101.19255177683,
        ["g"] = 33,
        ["sublevel"] = 1,
      },
    },
  },
  [21] = {
    ["name"] = "Disruptive Patron",
    ["id"] = 176565,
    ["count"] = 0,
    ["health"] = 88893763,
    ["scale"] = 2,
    ["displayId"] = 101271,
    ["creatureType"] = "Humanoid",
    ["level"] = 80,
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
      [353706] = {
        ["enrage"] = true,
      },
      [353783] = {
      },
      [353836] = {
        ["interruptible"] = true,
      },
    },
    ["clones"] = {
      [2] = {
        ["x"] = 172.09897011962,
        ["y"] = -118.58078652539,
        ["g"] = 33,
        ["sublevel"] = 1,
      },
    },
  },
  [22] = {
    ["name"] = "Brawling Patron",
    ["id"] = 180159,
    ["count"] = 0,
    ["health"] = 59520170,
    ["scale"] = 2,
    ["displayId"] = 101546,
    ["creatureType"] = "Humanoid",
    ["level"] = 80,
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
      [348566] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 188.54231538554,
        ["y"] = -108.5676330032,
        ["g"] = 33,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 179.44499470083,
        ["y"] = -91.754852270677,
        ["g"] = 33,
        ["sublevel"] = 1,
      },
    },
  },
  [23] = {
    ["name"] = "Zo'gron",
    ["id"] = 176563,
    ["count"] = 0,
    ["health"] = 371218134,
    ["scale"] = 2,
    ["displayId"] = 101481,
    ["creatureType"] = "Humanoid",
    ["level"] = 82,
    ["isBoss"] = true,
    ["encounterID"] = 2452,
    ["instanceID"] = 0,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Mind Soothe"] = true,
    },
    ["spells"] = {
      [181089] = {
      },
      [350919] = {
      },
      [350922] = {
        ["interruptible"] = true,
      },
      [355438] = {
      },
      [355439] = {
      },
      [359028] = {
      },
      [1241023] = {
      },
      [1241032] = {
        ["interruptible"] = true,
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 147.19159251453,
        ["y"] = -59.690221914933,
        ["g"] = 33,
        ["sublevel"] = 1,
      },
    },
  },
  [24] = {
    ["name"] = "Alcruux",
    ["id"] = 176556,
    ["count"] = 0,
    ["health"] = 232011334,
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
      [181089] = {
      },
      [349498] = {
      },
      [349663] = {
      },
      [349797] = {
      },
      [349801] = {
      },
      [355938] = {
      },
      [355981] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 270.97796915891,
        ["y"] = -490.2016379875,
        ["g"] = 34,
        ["sublevel"] = 1,
      },
    },
  },
  [25] = {
    ["name"] = "Achillite",
    ["id"] = 176555,
    ["count"] = 0,
    ["health"] = 232011334,
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
      [181089] = {
      },
      [349934] = {
      },
      [349939] = {
      },
      [349954] = {
        ["magic"] = true,
      },
      [349987] = {
      },
      [349999] = {
      },
      [350037] = {
      },
      [350045] = {
      },
      [350468] = {
      },
      [351070] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 255.82890814644,
        ["y"] = -518.63896121704,
        ["g"] = 34,
        ["sublevel"] = 1,
      },
    },
  },
  [26] = {
    ["name"] = "Venza Goldfuse",
    ["id"] = 176705,
    ["count"] = 0,
    ["health"] = 278413600,
    ["scale"] = 1.6,
    ["displayId"] = 100564,
    ["creatureType"] = "Humanoid",
    ["level"] = 82,
    ["isBoss"] = true,
    ["encounterID"] = 2454,
    ["instanceID"] = 0,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Mind Soothe"] = true,
    },
    ["spells"] = {
      [181089] = {
      },
      [349087] = {
      },
      [349405] = {
      },
      [350086] = {
      },
      [350090] = {
      },
      [350101] = {
      },
      [355675] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 293.96000002009,
        ["y"] = -516.83703223496,
        ["g"] = 34,
        ["sublevel"] = 1,
      },
    },
  },
  [27] = {
    ["name"] = "Defective Sorter",
    ["id"] = 176396,
    ["count"] = 3,
    ["health"] = 37103480,
    ["scale"] = 1.3,
    ["displayId"] = 100408,
    ["creatureType"] = "Mechanical",
    ["level"] = 80,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Incapacitate"] = true,
      ["Silence"] = true,
      ["Knock"] = true,
      ["Grip"] = true,
      ["Root"] = true,
      ["Fear"] = true,
      ["Disorient"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
      ["Sleep Walk"] = true,
    },
    ["spells"] = {
      [347721] = {
      },
      [347814] = {
      },
      [347822] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 161.58922550818,
        ["y"] = -262.12573147146,
        ["g"] = 30,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 166.80560131246,
        ["y"] = -251.75529394288,
        ["g"] = 30,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 171.33936269383,
        ["y"] = -241.11233640074,
        ["g"] = 30,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 102.15919671933,
        ["y"] = -298.66540689778,
        ["g"] = 31,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 113.88561170015,
        ["y"] = -298.47929055623,
        ["g"] = 31,
        ["sublevel"] = 1,
      },
      [6] = {
        ["x"] = 125.6358977232,
        ["y"] = -298.23308745817,
        ["g"] = 31,
        ["sublevel"] = 1,
      },
      [7] = {
        ["x"] = 78.667341917044,
        ["y"] = -243.41466340575,
        ["g"] = 32,
        ["sublevel"] = 1,
      },
    },
  },
  [28] = {
    ["name"] = "P.O.S.T. Worker",
    ["id"] = 176394,
    ["count"] = 5,
    ["health"] = 92758701,
    ["scale"] = 1.3,
    ["displayId"] = 100406,
    ["creatureType"] = "Mechanical",
    ["level"] = 80,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Incapacitate"] = true,
      ["Silence"] = true,
      ["Knock"] = true,
      ["Grip"] = true,
      ["Root"] = true,
      ["Fear"] = true,
      ["Disorient"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
      ["Sleep Walk"] = true,
    },
    ["spells"] = {
      [347716] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 172.21689546893,
        ["y"] = -267.44744298077,
        ["g"] = 30,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 182.3219429244,
        ["y"] = -244.97881219303,
        ["g"] = 30,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 107.6081544523,
        ["y"] = -287.6142228861,
        ["g"] = 31,
        ["sublevel"] = 1,
        ["disguised"] = true,
      },
      [4] = {
        ["x"] = 67.889594958912,
        ["y"] = -246.17914816767,
        ["g"] = 32,
        ["sublevel"] = 1,
      },
    },
  },
  [29] = {
    ["name"] = "Overloaded Mailemental",
    ["id"] = 176395,
    ["count"] = 5,
    ["health"] = 69569026,
    ["scale"] = 1.3,
    ["displayId"] = 68547,
    ["creatureType"] = "Elemental",
    ["level"] = 80,
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
      [347775] = {
        ["interruptible"] = true,
        ["magic"] = true,
      },
      [347903] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 177.42538606273,
        ["y"] = -256.24129887117,
        ["g"] = 30,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 119.4581662775,
        ["y"] = -287.45258654916,
        ["g"] = 31,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 75.496918083428,
        ["y"] = -255.36191987295,
        ["g"] = 32,
        ["sublevel"] = 1,
      },
    },
  },
  [30] = {
    ["name"] = "P.O.S.T. Master",
    ["id"] = 175646,
    ["count"] = 0,
    ["health"] = 584668560,
    ["scale"] = 2,
    ["displayId"] = 100722,
    ["creatureType"] = "Mechanical",
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
      [346741] = {
      },
      [346742] = {
      },
      [346947] = {
      },
      [346962] = {
      },
      [346967] = {
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
  [31] = {
    ["name"] = "So'azmi",
    ["id"] = 175806,
    ["count"] = 0,
    ["health"] = 584668560,
    ["scale"] = 2,
    ["displayId"] = 99094,
    ["creatureType"] = "Humanoid",
    ["level"] = 82,
    ["isBoss"] = true,
    ["encounterID"] = 2451,
    ["instanceID"] = 1194,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Mind Soothe"] = true,
    },
    ["spells"] = {
      [347481] = {
      },
      [347632] = {
      },
      [347633] = {
      },
      [347635] = {
      },
      [347636] = {
      },
      [1245579] = {
      },
      [1245634] = {
      },
      [1245669] = {
        ["interruptible"] = true,
      },
      [1245677] = {
      },
      [1248209] = {
      },
      [1248211] = {
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
  [32] = {
    ["name"] = "Smuggled Creature",
    ["id"] = 175677,
    ["count"] = 0,
    ["health"] = 74206961,
    ["scale"] = 1,
    ["displayId"] = 93756,
    ["creatureType"] = "Beast",
    ["level"] = 80,
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
      [347841] = {
      },
      [347842] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 64.335530278178,
        ["y"] = -258.21244138415,
        ["g"] = 32,
        ["sublevel"] = 1,
      },
    },
  },
  [33] = {
    ["name"] = "Unruly Patron",
    ["id"] = 176561,
    ["count"] = 0,
    ["health"] = 18551740,
    ["scale"] = 1.2,
    ["displayId"] = 101542,
    ["creatureType"] = "Humanoid",
    ["level"] = 80,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Mind Soothe"] = true,
    },
    ["spells"] = {
      [356482] = {
      },
      [359222] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 114.00005346802,
        ["y"] = -129.63192099957,
        ["sublevel"] = 1,
      },
    },
  },
  [34] = {
    ["name"] = "Bazaar Strongarm",
    ["id"] = 178388,
    ["count"] = 3,
    ["health"] = 64931091,
    ["scale"] = 1.3,
    ["displayId"] = 102057,
    ["creatureType"] = "Humanoid",
    ["level"] = 80,
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
      [351956] = {
      },
      [351960] = {
        ["magic"] = true,
      },
      [351961] = {
      },
      [358919] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 288.20819480246,
        ["y"] = -167.33661706392,
        ["g"] = 37,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 317.37026985806,
        ["y"] = -223.65000896144,
        ["g"] = 36,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 322.22305164629,
        ["y"] = -245.200510092,
        ["g"] = 36,
        ["sublevel"] = 1,
      },
    },
  },
  [35] = {
    ["name"] = "Cartel Lackey",
    ["id"] = 178394,
    ["count"] = 1,
    ["health"] = 18551740,
    ["scale"] = 1,
    ["displayId"] = 100869,
    ["creatureType"] = "Humanoid",
    ["level"] = 80,
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
      [1242960] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 341.57546056179,
        ["y"] = -229.49527468847,
        ["g"] = 36,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 293.34610920522,
        ["y"] = -159.06632527353,
        ["g"] = 37,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 298.31211001981,
        ["y"] = -167.35793744986,
        ["g"] = 37,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 293.70386055906,
        ["y"] = -175.84511970631,
        ["g"] = 37,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 209.47184550694,
        ["y"] = -189.31144783459,
        ["g"] = 38,
        ["sublevel"] = 1,
      },
      [6] = {
        ["x"] = 212.58755320301,
        ["y"] = -196.84113795544,
        ["g"] = 38,
        ["sublevel"] = 1,
      },
      [7] = {
        ["x"] = 221.41546188487,
        ["y"] = -197.10080132635,
        ["g"] = 38,
        ["sublevel"] = 1,
      },
      [8] = {
        ["x"] = 225.31015969364,
        ["y"] = -188.27289264449,
        ["g"] = 38,
        ["sublevel"] = 1,
      },
      [9] = {
        ["x"] = 217.00159179552,
        ["y"] = -182.04129470726,
        ["g"] = 38,
        ["sublevel"] = 1,
      },
      [10] = {
        ["x"] = 336.01558788894,
        ["y"] = -221.18236631283,
        ["g"] = 36,
        ["sublevel"] = 1,
      },
      [11] = {
        ["x"] = 340.02491508869,
        ["y"] = -239.24433502226,
        ["g"] = 36,
        ["sublevel"] = 1,
      },
      [12] = {
        ["x"] = 332.543464982,
        ["y"] = -245.13505658633,
        ["g"] = 36,
        ["sublevel"] = 1,
      },
      [13] = {
        ["x"] = 327.36626046656,
        ["y"] = -219.17063922866,
        ["g"] = 36,
        ["sublevel"] = 1,
      },
    },
  },
  [36] = {
    ["name"] = "Unruly Patron",
    ["id"] = 180158,
    ["count"] = 0,
    ["health"] = 18597661,
    ["scale"] = 1.2,
    ["displayId"] = 101543,
    ["creatureType"] = "Humanoid",
    ["level"] = 80,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Mind Soothe"] = true,
    },
    ["spells"] = {
      [356482] = {
      },
      [359222] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 109.13239697343,
        ["y"] = -116.90076159137,
        ["sublevel"] = 1,
      },
    },
  },
  [37] = {
    ["name"] = "Bazaar Overseer",
    ["id"] = 246285,
    ["count"] = 12,
    ["health"] = 157689792,
    ["scale"] = 1.8,
    ["displayId"] = 129965,
    ["creatureType"] = "Humanoid",
    ["level"] = 80,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Mind Soothe"] = true,
    },
    ["spells"] = {
      [1240811] = {
      },
      [1240821] = {
      },
      [1240912] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 256.45767472176,
        ["y"] = -245.26346413378,
        ["g"] = 39,
        ["sublevel"] = 1,
        ["patrol"] = {
          [1] = {
            ["x"] = 256.45767472176,
            ["y"] = -245.26346413378,
          },
          [2] = {
            ["x"] = 236.46175573796,
            ["y"] = -240.96044698516,
          },
          [3] = {
            ["x"] = 229.94807557468,
            ["y"] = -219.91611408397,
          },
          [4] = {
            ["x"] = 224.436376915,
            ["y"] = -202.37908996065,
          },
          [5] = {
            ["x"] = 218.9248383333,
            ["y"] = -187.34741979127,
          },
          [6] = {
            ["x"] = 247.9860904498,
            ["y"] = -170.8124838902,
          },
          [7] = {
            ["x"] = 270.03256493257,
            ["y"] = -163.7977596158,
          },
          [8] = {
            ["x"] = 308.11287784595,
            ["y"] = -158.28616767477,
          },
          [9] = {
            ["x"] = 332.16358213255,
            ["y"] = -163.7977596158,
          },
          [10] = {
            ["x"] = 337.67517407357,
            ["y"] = -189.85269370622,
          },
          [11] = {
            ["x"] = 341.1825895701,
            ["y"] = -215.40658368552,
          },
          [12] = {
            ["x"] = 348.19742056316,
            ["y"] = -233.44457188097,
          },
          [13] = {
            ["x"] = 310.11710764978,
            ["y"] = -245.97102149472,
          },
          [14] = {
            ["x"] = 282.55898786665,
            ["y"] = -245.4699773836,
          },
        },
      },
      [2] = {
        ["x"] = 329.16812199889,
        ["y"] = -232.41249222149,
        ["g"] = 36,
        ["sublevel"] = 1,
      },
    },
  },
};
