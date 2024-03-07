local addonName = ...
local MDT = MDT
local L = MDT.L
local dungeonIndex = 102
MDT.dungeonList[dungeonIndex] = L["Waycrest Manor"]
MDT.mapInfo[dungeonIndex] = {

};

local zones = { 1015, 1016, 1017, 1018, 1029 }
for _, zone in ipairs(zones) do
  MDT.zoneIdToDungeonIdx[zone] = dungeonIndex
end

MDT.dungeonMaps[dungeonIndex] = {
  [0] = "",
  [1] = { customTextures = 'WaycrestManor' },
}

MDT.dungeonSubLevels[dungeonIndex] = {
  [1] = L["Waycrest Manor"],
}

MDT.dungeonTotalCount[dungeonIndex] = { normal = 305, teeming = 1000, teemingEnabled = true }

MDT.mapPOIs[dungeonIndex] = {};

MDT.dungeonEnemies[dungeonIndex] = {
  [1] = {
    ["name"] = "Soul Essence",
    ["id"] = 135240,
    ["count"] = 1,
    ["health"] = 888675,
    ["scale"] = 1,
    ["displayId"] = 84408,
    ["creatureType"] = "Elemental",
    ["level"] = 70,
    ["reaping"] = 148893,
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
      [264027] = {
      },
      [267824] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 554.31997395167,
        ["y"] = -314.69594888374,
        ["g"] = 1,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
        ["infested"] = {
          [1] = true,
        },
      },
      [2] = {
        ["x"] = 567.762281227,
        ["y"] = -308.78573696476,
        ["g"] = 1,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
      [3] = {
        ["x"] = 574.35000809374,
        ["y"] = -296.97391041118,
        ["g"] = 1,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
      [4] = {
        ["x"] = 611.82329164458,
        ["y"] = -302.08816045239,
        ["g"] = 2,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
      [5] = {
        ["x"] = 625.17952856059,
        ["y"] = -310.36497455376,
        ["g"] = 2,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
      [6] = {
        ["x"] = 644.27009047182,
        ["y"] = -342.03086786041,
        ["g"] = 3,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
      [7] = {
        ["x"] = 634.22169744284,
        ["y"] = -350.81777562778,
        ["g"] = 3,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
        ["infested"] = {
          [1] = true,
        },
      },
      [8] = {
        ["x"] = 138.80869323712,
        ["y"] = -437.45433697169,
        ["g"] = 53,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
        ["infested"] = {
          [1] = true,
        },
      },
      [9] = {
        ["x"] = 467.0428069491,
        ["y"] = -517.10004483415,
        ["g"] = 55,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
      [10] = {
        ["x"] = 468.03567001636,
        ["y"] = -530.03164466876,
        ["g"] = 55,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
      [11] = {
        ["x"] = 492.18292445576,
        ["y"] = -488.16193441391,
        ["g"] = 57,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
        ["infested"] = {
          [1] = true,
        },
      },
      [12] = {
        ["x"] = 476.66998361115,
        ["y"] = -489.04225964384,
        ["g"] = 57,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
    },
  },
  [2] = {
    ["name"] = "Maddened Survivalist",
    ["id"] = 131850,
    ["count"] = 4,
    ["health"] = 1481125,
    ["scale"] = 1,
    ["displayId"] = 82094,
    ["creatureType"] = "Humanoid",
    ["level"] = 70,
    ["reaping"] = 148716,
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
      [264520] = {
      },
      [264525] = {
      },
      [264531] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 748.50158296346,
        ["y"] = -347.11270380118,
        ["g"] = 6,
        ["sublevel"] = 1,
        ["scale"] = 1.6,
        ["infested"] = {
          [2] = true,
        },
      },
      [2] = {
        ["x"] = 730.01578740339,
        ["y"] = -304.71895413677,
        ["g"] = 4,
        ["sublevel"] = 1,
        ["scale"] = 1.6,
        ["infested"] = {
          [3] = true,
        },
      },
      [3] = {
        ["x"] = 308.46937652898,
        ["y"] = -199.23044207711,
        ["g"] = 49,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
        ["infested"] = {
          [3] = true,
        },
      },
    },
  },
  [3] = {
    ["name"] = "Diseased Mastiff",
    ["id"] = 135234,
    ["count"] = 3,
    ["teemingCount"] = 2,
    ["health"] = 740563,
    ["scale"] = 1,
    ["displayId"] = 30221,
    ["creatureType"] = "Beast",
    ["level"] = 70,
    ["reaping"] = 148716,
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
      [265642] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 783.60948931696,
        ["y"] = -325.70990086739,
        ["g"] = 5,
        ["sublevel"] = 1,
        ["scale"] = 1.6,
        ["infested"] = {
          [3] = true,
        },
      },
      [2] = {
        ["x"] = 745.89116426398,
        ["y"] = -299.97832454461,
        ["g"] = 4,
        ["sublevel"] = 1,
        ["scale"] = 1.6,
      },
      [3] = {
        ["x"] = 318.1409371428,
        ["y"] = -202.7738508441,
        ["g"] = 49,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
      [4] = {
        ["x"] = 304.07169723164,
        ["y"] = -211.74712017777,
        ["g"] = 49,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
    },
  },
  [4] = {
    ["name"] = "Crazed Marksman",
    ["id"] = 131849,
    ["count"] = 4,
    ["health"] = 1184900,
    ["scale"] = 1,
    ["displayId"] = 82092,
    ["creatureType"] = "Humanoid",
    ["level"] = 70,
    ["reaping"] = 148716,
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
      [264510] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 758.56578925254,
        ["y"] = -339.61595217192,
        ["g"] = 6,
        ["sublevel"] = 1,
        ["scale"] = 1.6,
      },
      [2] = {
        ["x"] = 787.32686729709,
        ["y"] = -313.09298608467,
        ["g"] = 5,
        ["sublevel"] = 1,
        ["scale"] = 1.6,
        ["infested"] = {
          [2] = true,
        },
      },
      [3] = {
        ["x"] = 733.41767726667,
        ["y"] = -290.07557778092,
        ["g"] = 4,
        ["sublevel"] = 1,
        ["scale"] = 1.6,
      },
    },
  },
  [5] = {
    ["name"] = "Devouring Maggot",
    ["id"] = 134024,
    ["count"] = 1,
    ["health"] = 444338,
    ["scale"] = 0.7,
    ["displayId"] = 7572,
    ["creatureType"] = "Beast",
    ["level"] = 70,
    ["reaping"] = 148716,
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
      [264153] = {
      },
      [278431] = {
      },
      [278444] = {
      },
      [278456] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 786.83207870772,
        ["y"] = -236.87829584173,
        ["g"] = 33,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [2] = {
        ["x"] = 793.00893463459,
        ["y"] = -248.3989623743,
        ["g"] = 33,
        ["sublevel"] = 1,
        ["scale"] = 1,
        ["infested"] = {
          [1] = true,
        },
      },
      [3] = {
        ["x"] = 788.87607692059,
        ["y"] = -242.40571117818,
        ["g"] = 33,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [4] = {
        ["x"] = 722.14050597524,
        ["y"] = -241.00860890891,
        ["g"] = 31,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [5] = {
        ["x"] = 717.73085783595,
        ["y"] = -245.53641091743,
        ["g"] = 31,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [6] = {
        ["x"] = 722.61001973364,
        ["y"] = -249.73031669965,
        ["g"] = 31,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [7] = {
        ["x"] = 675.45804634704,
        ["y"] = -242.6283966239,
        ["g"] = 29,
        ["sublevel"] = 1,
        ["scale"] = 1,
        ["infested"] = {
          [1] = true,
        },
      },
      [8] = {
        ["x"] = 677.89294606072,
        ["y"] = -249.52661527345,
        ["g"] = 29,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [9] = {
        ["x"] = 675.24781558017,
        ["y"] = -255.78199774374,
        ["g"] = 29,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [10] = {
        ["x"] = 667.09582166732,
        ["y"] = -206.62481902116,
        ["g"] = 27,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [11] = {
        ["x"] = 668.70785748565,
        ["y"] = -212.30074931496,
        ["g"] = 27,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [12] = {
        ["x"] = 662.53623983367,
        ["y"] = -211.14522856473,
        ["g"] = 27,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [13] = {
        ["x"] = 663.54669703883,
        ["y"] = -169.54514173146,
        ["g"] = 25,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [14] = {
        ["x"] = 665.59323950997,
        ["y"] = -176.45654660176,
        ["g"] = 25,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [15] = {
        ["x"] = 670.07317958774,
        ["y"] = -171.40485121657,
        ["g"] = 25,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [16] = {
        ["x"] = 658.87150960067,
        ["y"] = -127.28838744827,
        ["g"] = 23,
        ["sublevel"] = 1,
        ["scale"] = 1,
        ["infested"] = {
          [1] = true,
        },
      },
      [17] = {
        ["x"] = 677.07002636501,
        ["y"] = -121.39387161053,
        ["g"] = 23,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [18] = {
        ["x"] = 674.62661583539,
        ["y"] = -116.25152985515,
        ["g"] = 23,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [19] = {
        ["x"] = 707.59937200052,
        ["y"] = -86.585614857662,
        ["g"] = 41,
        ["sublevel"] = 1,
        ["scale"] = 1.6,
        ["infested"] = {
          [1] = true,
        },
      },
      [20] = {
        ["x"] = 714.79467339365,
        ["y"] = -95.540273328734,
        ["g"] = 41,
        ["sublevel"] = 1,
        ["scale"] = 1.6,
      },
      [21] = {
        ["x"] = 719.3280581363,
        ["y"] = -83.102701120224,
        ["g"] = 41,
        ["sublevel"] = 1,
        ["scale"] = 1.6,
      },
      [22] = {
        ["x"] = 696.53050431062,
        ["y"] = -83.264571139882,
        ["g"] = 41,
        ["sublevel"] = 1,
        ["scale"] = 1.6,
        ["infested"] = {
          [1] = true,
        },
      },
      [23] = {
        ["x"] = 705.04429787405,
        ["y"] = -97.886199333875,
        ["g"] = 41,
        ["sublevel"] = 1,
        ["scale"] = 1.6,
      },
      [24] = {
        ["x"] = 696.90750855826,
        ["y"] = -95.28548351266,
        ["g"] = 41,
        ["sublevel"] = 1,
        ["scale"] = 1.6,
      },
      [25] = {
        ["x"] = 696.56874320919,
        ["y"] = -76.414833526241,
        ["g"] = 41,
        ["sublevel"] = 1,
        ["scale"] = 1.6,
      },
      [26] = {
        ["x"] = 701.72995459921,
        ["y"] = -68.589918700608,
        ["g"] = 41,
        ["sublevel"] = 1,
        ["scale"] = 1.6,
      },
      [27] = {
        ["x"] = 710.43624057546,
        ["y"] = -75.574477067718,
        ["g"] = 41,
        ["sublevel"] = 1,
        ["scale"] = 1.6,
      },
      [28] = {
        ["x"] = 657.21238348582,
        ["y"] = -121.40806472541,
        ["g"] = 23,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [29] = {
        ["x"] = 660.74816880962,
        ["y"] = -114.82158118987,
        ["g"] = 23,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [30] = {
        ["x"] = 667.75876215244,
        ["y"] = -113.25203958348,
        ["g"] = 23,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [31] = {
        ["x"] = 782.6635157179,
        ["y"] = -229.74286568354,
        ["g"] = 10,
        ["sublevel"] = 1,
        ["scale"] = 1.6,
        ["teeming"] = true,
      },
      [32] = {
        ["x"] = 785.16349938071,
        ["y"] = -224.16595111806,
        ["g"] = 10,
        ["sublevel"] = 1,
        ["scale"] = 1.6,
        ["teeming"] = true,
      },
      [33] = {
        ["x"] = 786.70194832615,
        ["y"] = -228.01208998755,
        ["g"] = 10,
        ["sublevel"] = 1,
        ["scale"] = 1.6,
        ["teeming"] = true,
      },
      [34] = {
        ["x"] = 790.54810370154,
        ["y"] = -223.9736408734,
        ["g"] = 10,
        ["sublevel"] = 1,
        ["scale"] = 1.6,
        ["teeming"] = true,
      },
      [35] = {
        ["x"] = 792.8558101315,
        ["y"] = -228.01208998755,
        ["g"] = 10,
        ["sublevel"] = 1,
        ["scale"] = 1.6,
        ["teeming"] = true,
      },
      [36] = {
        ["x"] = 796.50965526224,
        ["y"] = -225.12748583543,
        ["g"] = 10,
        ["sublevel"] = 1,
        ["scale"] = 1.6,
        ["teeming"] = true,
      },
      [37] = {
        ["x"] = 800.13090625968,
        ["y"] = -227.99999905411,
        ["g"] = 33,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [38] = {
        ["x"] = 805.43194700006,
        ["y"] = -233.15850227783,
        ["g"] = 33,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [39] = {
        ["x"] = 807.85879102374,
        ["y"] = -239.32392039818,
        ["g"] = 33,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [40] = {
        ["x"] = 681.10144781189,
        ["y"] = -114.86636939093,
        ["g"] = 15,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
        ["teeming"] = true,
      },
      [41] = {
        ["x"] = 685.13991343194,
        ["y"] = -115.82790410831,
        ["g"] = 15,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
        ["teeming"] = true,
      },
      [42] = {
        ["x"] = 682.44761952448,
        ["y"] = -119.2894555003,
        ["g"] = 15,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
        ["teeming"] = true,
      },
      [43] = {
        ["x"] = 685.71684416591,
        ["y"] = -120.63559420108,
        ["g"] = 15,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
        ["teeming"] = true,
      },
      [44] = {
        ["x"] = 682.25530927982,
        ["y"] = -123.71253335671,
        ["g"] = 15,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
        ["teeming"] = true,
      },
      [45] = {
        ["x"] = 685.90917091646,
        ["y"] = -125.4432925468,
        ["g"] = 15,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
        ["teeming"] = true,
      },
      [46] = {
        ["x"] = 661.17971555471,
        ["y"] = -255.65967172017,
        ["g"] = 29,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [47] = {
        ["x"] = 657.12588134861,
        ["y"] = -251.02278900206,
        ["g"] = 29,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [48] = {
        ["x"] = 657.39523120389,
        ["y"] = -243.54012828462,
        ["g"] = 29,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
    },
  },
  [6] = {
    ["name"] = "Gorestained Piglet",
    ["id"] = 135048,
    ["count"] = 4,
    ["health"] = 740563,
    ["scale"] = 1,
    ["displayId"] = 84115,
    ["creatureType"] = "Beast",
    ["level"] = 70,
    ["reaping"] = 148716,
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
      [265337] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 774.05133897352,
        ["y"] = -246.32641682613,
        ["g"] = 32,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
        ["patrol"] = {
        },
      },
      [2] = {
        ["x"] = 699.36943339661,
        ["y"] = -247.860290998,
        ["g"] = 30,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
        ["patrol"] = {
        },
      },
      [3] = {
        ["x"] = 667.66869674403,
        ["y"] = -191.18133986504,
        ["g"] = 26,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
        ["patrol"] = {
        },
      },
      [4] = {
        ["x"] = 668.5106484823,
        ["y"] = -149.60728968496,
        ["g"] = 24,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
        ["patrol"] = {
        },
        ["infested"] = {
          [3] = true,
        },
      },
      [5] = {
        ["x"] = 708.74830187589,
        ["y"] = -210.24127309353,
        ["g"] = 38,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
      [6] = {
        ["x"] = 744.45843199928,
        ["y"] = -192.37027986389,
        ["g"] = 39,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
      [7] = {
        ["x"] = 733.78700277998,
        ["y"] = -130.57165236806,
        ["g"] = 35,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
        ["infested"] = {
          [2] = true,
        },
      },
      [8] = {
        ["x"] = 745.90198441608,
        ["y"] = -136.11791693286,
        ["g"] = 35,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
    },
  },
  [7] = {
    ["name"] = "Infected Peasant",
    ["id"] = 134041,
    ["count"] = 3,
    ["health"] = 1184900,
    ["scale"] = 1,
    ["displayId"] = 83298,
    ["creatureType"] = "Humanoid",
    ["level"] = 70,
    ["reaping"] = 148716,
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
      [264655] = {
      },
      [266008] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 797.87578279014,
        ["y"] = -238.44288973598,
        ["g"] = 33,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
      [2] = {
        ["x"] = 667.10918824021,
        ["y"] = -248.3354378112,
        ["g"] = 29,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
      [3] = {
        ["x"] = 667.81590871848,
        ["y"] = -123.98716125569,
        ["g"] = 23,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
        ["infested"] = {
          [3] = true,
        },
      },
      [4] = {
        ["x"] = 795.16348354966,
        ["y"] = -247.43517710919,
        ["g"] = 10,
        ["sublevel"] = 1,
        ["scale"] = 1.6,
        ["teeming"] = true,
      },
      [5] = {
        ["x"] = 786.70194832615,
        ["y"] = -242.0505645354,
        ["g"] = 10,
        ["sublevel"] = 1,
        ["scale"] = 1.6,
        ["teeming"] = true,
      },
      [6] = {
        ["x"] = 667.4476185122,
        ["y"] = -135.63559521335,
        ["g"] = 15,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
        ["teeming"] = true,
      },
      [7] = {
        ["x"] = 675.13991275709,
        ["y"] = -135.05868098529,
        ["g"] = 15,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
        ["teeming"] = true,
      },
    },
  },
  [8] = {
    ["name"] = "Pallid Gorger",
    ["id"] = 137830,
    ["count"] = 4,
    ["health"] = 1333013,
    ["scale"] = 1,
    ["displayId"] = 85446,
    ["creatureType"] = "Aberration",
    ["level"] = 70,
    ["reaping"] = 148716,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Incapacitate"] = true,
      ["Silence"] = true,
      ["Knock"] = true,
      ["Grip"] = true,
      ["Root"] = true,
      ["Fear"] = true,
      ["Banish"] = true,
      ["Disorient"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
      ["Sleep Walk"] = true,
    },
    ["spells"] = {
      [271174] = {
      },
      [271175] = {
      },
      [271178] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 665.31946928849,
        ["y"] = -225.68773886996,
        ["g"] = 28,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
        ["patrol"] = {
          [1] = {
            ["x"] = 665.31946928849,
            ["y"] = -225.68773886996,
          },
          [2] = {
            ["x"] = 665.59477348934,
            ["y"] = -180.74110143874,
          },
          [3] = {
            ["x"] = 665.93834969634,
            ["y"] = -161.50272098029,
          },
          [4] = {
            ["x"] = 665.93834969634,
            ["y"] = -136.08059784035,
          },
          [5] = {
            ["x"] = 665.93834969634,
            ["y"] = -161.50272098029,
          },
          [6] = {
            ["x"] = 665.59477348934,
            ["y"] = -180.74110143874,
          },
          [7] = {
            ["x"] = 665.31946928849,
            ["y"] = -225.68773886996,
          },
          [8] = {
            ["x"] = 666.14094662243,
            ["y"] = -246.68523594749,
          },
          [9] = {
            ["x"] = 686.93726228131,
            ["y"] = -246.98881803851,
          },
          [10] = {
            ["x"] = 736.94071272462,
            ["y"] = -246.41214862903,
          },
          [11] = {
            ["x"] = 783.23903582896,
            ["y"] = -246.56394401751,
          },
          [12] = {
            ["x"] = 736.94071272462,
            ["y"] = -246.41214862903,
          },
          [13] = {
            ["x"] = 686.93726228131,
            ["y"] = -246.98881803851,
          },
          [14] = {
            ["x"] = 665.89939386097,
            ["y"] = -248.84091827435,
          },
        },
      },
      [2] = {
        ["x"] = 678.9948678669,
        ["y"] = -226.67304846957,
        ["g"] = 28,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
        ["infested"] = {
          [2] = true,
        },
      },
      [3] = {
        ["x"] = 753.17735076352,
        ["y"] = -213.96412914952,
        ["g"] = 39,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
      [4] = {
        ["x"] = 708.195681483,
        ["y"] = -180.52658516133,
        ["g"] = 37,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
        ["infested"] = {
          [2] = true,
        },
      },
      [5] = {
        ["x"] = 750.467285486,
        ["y"] = -124.62230263073,
        ["g"] = 35,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
    },
  },
  [9] = {
    ["name"] = "Waycrest Reveler",
    ["id"] = 131847,
    ["count"] = 4,
    ["health"] = 888675,
    ["scale"] = 1,
    ["displayId"] = 25983,
    ["creatureType"] = "Humanoid",
    ["level"] = 70,
    ["reaping"] = 148893,
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
      [265410] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 745.16685581854,
        ["y"] = -203.62938238637,
        ["g"] = 39,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
      [2] = {
        ["x"] = 706.86770037275,
        ["y"] = -167.55956263963,
        ["g"] = 37,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
      [3] = {
        ["x"] = 710.228676401,
        ["y"] = -120.3414691135,
        ["g"] = 34,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
      [4] = {
        ["x"] = 710.46354126306,
        ["y"] = -132.99062521746,
        ["g"] = 34,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
      [5] = {
        ["x"] = 697.84990667939,
        ["y"] = -128.46297033142,
        ["g"] = 34,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
    },
  },
  [10] = {
    ["name"] = "Banquet Steward",
    ["id"] = 131586,
    ["count"] = 4,
    ["health"] = 2073575,
    ["scale"] = 1,
    ["displayId"] = 81344,
    ["creatureType"] = "Humanoid",
    ["level"] = 70,
    ["reaping"] = 148716,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Mind Soothe"] = true,
    },
    ["spells"] = {
      [265391] = {
      },
      [265392] = {
      },
      [265393] = {
      },
      [265407] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 756.78501355869,
        ["y"] = -196.74369584515,
        ["g"] = 39,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
        ["infested"] = {
          [3] = true,
        },
      },
      [2] = {
        ["x"] = 714.57468264001,
        ["y"] = -150.8203043925,
        ["g"] = 36,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
        ["patrol"] = {
        },
        ["infested"] = {
          [3] = true,
        },
      },
      [3] = {
        ["x"] = 739.85779052192,
        ["y"] = -120.00591386291,
        ["g"] = 35,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
        ["infested"] = {
        },
      },
    },
  },
  [11] = {
    ["name"] = "Raal the Gluttonous",
    ["id"] = 131863,
    ["count"] = 0,
    ["health"] = 9338130,
    ["scale"] = 1,
    ["displayId"] = 83656,
    ["creatureType"] = "Humanoid",
    ["level"] = 70,
    ["isBoss"] = true,
    ["encounterID"] = 2127,
    ["instanceID"] = 1021,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Mind Soothe"] = true,
    },
    ["spells"] = {
      [264693] = {
      },
      [264694] = {
      },
      [264698] = {
      },
      [264734] = {
      },
      [264923] = {
      },
      [264931] = {
      },
      [265002] = {
      },
      [426590] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 765.68478311739,
        ["y"] = -170.20079915302,
        ["g"] = 40,
        ["sublevel"] = 1,
        ["scale"] = 1.6,
      },
    },
  },
  [12] = {
    ["name"] = "Runic Disciple",
    ["id"] = 131685,
    ["count"] = 4,
    ["health"] = 1333013,
    ["scale"] = 1,
    ["displayId"] = 78911,
    ["creatureType"] = "Humanoid",
    ["level"] = 70,
    ["reaping"] = 148893,
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
      [264390] = {
      },
      [426541] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 99.615382502078,
        ["y"] = -228.31651013932,
        ["g"] = 43,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
        ["patrol"] = {
          [1] = {
            ["x"] = 99.615382502078,
            ["y"] = -228.31651013932,
          },
          [2] = {
            ["x"] = 97.646607224381,
            ["y"] = -246.97784517491,
          },
          [3] = {
            ["x"] = 117.91559835799,
            ["y"] = -249.38262307458,
          },
          [4] = {
            ["x"] = 135.09271815085,
            ["y"] = -249.38262307458,
          },
          [5] = {
            ["x"] = 150.89565106156,
            ["y"] = -249.03906652523,
          },
          [6] = {
            ["x"] = 135.09271815085,
            ["y"] = -249.38262307458,
          },
          [7] = {
            ["x"] = 117.91559835799,
            ["y"] = -249.38262307458,
          },
          [8] = {
            ["x"] = 97.646607224381,
            ["y"] = -246.97784517491,
          },
          [9] = {
            ["x"] = 99.615382502078,
            ["y"] = -228.31651013932,
          },
          [10] = {
            ["x"] = 97.303070332663,
            ["y"] = -204.37860224212,
          },
          [11] = {
            ["x"] = 119.63332213185,
            ["y"] = -205.40925223255,
          },
          [12] = {
            ["x"] = 148.49085350425,
            ["y"] = -205.40925223255,
          },
          [13] = {
            ["x"] = 119.63332213185,
            ["y"] = -205.40925223255,
          },
          [14] = {
            ["x"] = 97.303070332663,
            ["y"] = -204.37860224212,
          },
        },
      },
      [2] = {
        ["x"] = 467.18255212301,
        ["y"] = -158.94841878927,
        ["g"] = 15,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
        ["infested"] = {
          [2] = true,
        },
      },
      [3] = {
        ["x"] = 36.367579243702,
        ["y"] = -184.7642258828,
        ["g"] = 45,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
      [4] = {
        ["x"] = 41.675158883082,
        ["y"] = -279.79626401554,
        ["g"] = 44,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
        ["infested"] = {
          [1] = true,
          [2] = true,
        },
      },
      [5] = {
        ["x"] = 295.01316295299,
        ["y"] = -177.37655323193,
        ["g"] = 48,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
    },
  },
  [13] = {
    ["name"] = "Enthralled Guard",
    ["id"] = 131585,
    ["count"] = 4,
    ["health"] = 1481125,
    ["scale"] = 1,
    ["displayId"] = 76992,
    ["creatureType"] = "Humanoid",
    ["level"] = 70,
    ["reaping"] = 148716,
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
      [264027] = {
      },
      [265371] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 113.66112841895,
        ["y"] = -229.01212029545,
        ["g"] = 43,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
      [2] = {
        ["x"] = 493.10620129584,
        ["y"] = -264.23442037919,
        ["g"] = 11,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
        ["infested"] = {
          [3] = true,
        },
      },
      [3] = {
        ["x"] = 463.72985274662,
        ["y"] = -225.45974818431,
        ["g"] = 12,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
      [4] = {
        ["x"] = 455.6405057788,
        ["y"] = -150.80105470238,
        ["g"] = 15,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
      [5] = {
        ["x"] = 470.77637941923,
        ["y"] = -144.52029469723,
        ["g"] = 15,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
      [6] = {
        ["x"] = 508.61042523694,
        ["y"] = -193.36824644236,
        ["g"] = 13,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
      [7] = {
        ["x"] = 103.00477545252,
        ["y"] = -403.8147748459,
        ["g"] = 54,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
    },
  },
  [14] = {
    ["name"] = "Heartsbane Runeweaver",
    ["id"] = 131677,
    ["count"] = 6,
    ["health"] = 2369800,
    ["scale"] = 1.2,
    ["displayId"] = 81999,
    ["creatureType"] = "Humanoid",
    ["level"] = 70,
    ["reaping"] = 148894,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Mind Soothe"] = true,
    },
    ["spells"] = {
      [263943] = {
      },
      [264105] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 131.91405607295,
        ["y"] = -205.22767608626,
        ["sublevel"] = 1,
        ["scale"] = 1.6,
      },
      [3] = {
        ["x"] = 254.85838773102,
        ["y"] = -478.21353005382,
        ["g"] = 51,
        ["sublevel"] = 1,
        ["scale"] = 1.6,
        ["infested"] = {
        },
      },
      [4] = {
        ["x"] = 292.74184025398,
        ["y"] = -199.76807638527,
        ["g"] = 49,
        ["sublevel"] = 1,
        ["scale"] = 1.6,
      },
      [5] = {
        ["x"] = 476.045827959,
        ["y"] = -207.8996504784,
        ["g"] = 26,
        ["sublevel"] = 1,
        ["scale"] = 1,
        ["teeming"] = true,
      },
      [6] = {
        ["x"] = 735.61604589195,
        ["y"] = -86.188333616023,
        ["g"] = 41,
        ["sublevel"] = 1,
        ["scale"] = 1.6,
      },
    },
  },
  [15] = {
    ["name"] = "Thistle Acolyte",
    ["id"] = 135474,
    ["count"] = 4,
    ["health"] = 1333013,
    ["scale"] = 1,
    ["displayId"] = 84270,
    ["creatureType"] = "Humanoid",
    ["level"] = 70,
    ["reaping"] = 148893,
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
      [264050] = {
      },
      [266036] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 419.52121407765,
        ["y"] = -386.5696120085,
        ["g"] = 8,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
        ["infested"] = {
          [2] = true,
        },
      },
      [2] = {
        ["x"] = 404.70340317615,
        ["y"] = -246.194555617,
        ["g"] = 10,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
        ["infested"] = {
          [2] = true,
        },
      },
      [3] = {
        ["x"] = 37.831861805946,
        ["y"] = -170.68620589601,
        ["g"] = 45,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
    },
  },
  [16] = {
    ["name"] = "Blight Toad",
    ["id"] = 135052,
    ["count"] = 1,
    ["health"] = 296225,
    ["scale"] = 0.7,
    ["displayId"] = 76785,
    ["creatureType"] = "Beast",
    ["level"] = 70,
    ["reaping"] = 148716,
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
      [265352] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 408.52954324444,
        ["y"] = -390.50931006641,
        ["g"] = 8,
        ["sublevel"] = 1,
        ["scale"] = 1.6,
      },
      [2] = {
        ["x"] = 411.17318562523,
        ["y"] = -376.60418988456,
        ["g"] = 8,
        ["sublevel"] = 1,
        ["scale"] = 1.6,
      },
      [3] = {
        ["x"] = 423.2907909842,
        ["y"] = -376.55578939502,
        ["g"] = 8,
        ["sublevel"] = 1,
        ["scale"] = 1.6,
        ["infested"] = {
          [1] = true,
        },
      },
      [4] = {
        ["x"] = 419.18672909276,
        ["y"] = -246.79650322111,
        ["g"] = 10,
        ["sublevel"] = 1,
        ["scale"] = 1.6,
      },
      [5] = {
        ["x"] = 413.3748157249,
        ["y"] = -255.67835866829,
        ["g"] = 10,
        ["sublevel"] = 1,
        ["scale"] = 1.6,
      },
      [6] = {
        ["x"] = 402.8992838575,
        ["y"] = -258.58724712152,
        ["g"] = 10,
        ["sublevel"] = 1,
        ["scale"] = 1.6,
      },
      [7] = {
        ["x"] = 394.75327376618,
        ["y"] = -252.82123944238,
        ["g"] = 10,
        ["sublevel"] = 1,
        ["scale"] = 1.6,
        ["infested"] = {
          [1] = true,
        },
      },
      [8] = {
        ["x"] = 426.91878429804,
        ["y"] = -389.06851767254,
        ["g"] = 22,
        ["sublevel"] = 1,
        ["scale"] = 1,
        ["teeming"] = true,
      },
      [9] = {
        ["x"] = 420.04380779414,
        ["y"] = -378.75601603632,
        ["g"] = 22,
        ["sublevel"] = 1,
        ["scale"] = 1,
        ["teeming"] = true,
      },
      [10] = {
        ["x"] = 411.67030511789,
        ["y"] = -383.47683686577,
        ["g"] = 22,
        ["sublevel"] = 1,
        ["scale"] = 1,
        ["teeming"] = true,
      },
      [11] = {
        ["x"] = 424.63905148602,
        ["y"] = -376.75809900759,
        ["g"] = 22,
        ["sublevel"] = 1,
        ["scale"] = 1,
        ["teeming"] = true,
      },
    },
  },
  [17] = {
    ["name"] = "Sister Solena",
    ["id"] = 131824,
    ["count"] = 0,
    ["health"] = 2816262,
    ["scale"] = 1,
    ["displayId"] = 82071,
    ["creatureType"] = "Humanoid",
    ["level"] = 70,
    ["isBoss"] = true,
    ["encounterID"] = 2125,
    ["instanceID"] = 1021,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Mind Soothe"] = true,
    },
    ["spells"] = {
      [260698] = {
      },
      [260699] = {
      },
      [260805] = {
      },
      [260852] = {
      },
      [260900] = {
      },
      [260907] = {
      },
      [260923] = {
      },
      [260926] = {
      },
      [261264] = {
      },
      [268077] = {
      },
      [269576] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 371.79702662873,
        ["y"] = -319.81738639085,
        ["g"] = 9,
        ["sublevel"] = 1,
        ["scale"] = 1.6,
      },
    },
  },
  [18] = {
    ["name"] = "Sister Malady",
    ["id"] = 131823,
    ["count"] = 0,
    ["health"] = 2816262,
    ["scale"] = 1,
    ["displayId"] = 81999,
    ["creatureType"] = "Humanoid",
    ["level"] = 70,
    ["isBoss"] = true,
    ["encounterID"] = 2125,
    ["instanceID"] = 1021,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Mind Soothe"] = true,
    },
    ["spells"] = {
      [260696] = {
      },
      [260700] = {
      },
      [260703] = {
      },
      [260805] = {
      },
      [260852] = {
      },
      [261266] = {
      },
      [268088] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 394.22916051545,
        ["y"] = -305.38621515607,
        ["g"] = 9,
        ["sublevel"] = 1,
        ["scale"] = 1.6,
      },
    },
  },
  [19] = {
    ["name"] = "Sister Briar",
    ["id"] = 131825,
    ["count"] = 0,
    ["health"] = 2816262,
    ["scale"] = 1,
    ["displayId"] = 81996,
    ["creatureType"] = "Humanoid",
    ["level"] = 70,
    ["isBoss"] = true,
    ["encounterID"] = 2125,
    ["instanceID"] = 1021,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Mind Soothe"] = true,
    },
    ["spells"] = {
      [260697] = {
      },
      [260701] = {
      },
      [260741] = {
      },
      [260805] = {
      },
      [260852] = {
      },
      [261265] = {
      },
      [268122] = {
      },
      [268126] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 393.44678167774,
        ["y"] = -333.30281706515,
        ["g"] = 9,
        ["sublevel"] = 1,
        ["scale"] = 1.6,
      },
    },
  },
  [20] = {
    ["name"] = "Heartsbane Vinetwister",
    ["id"] = 131670,
    ["count"] = 6,
    ["health"] = 2369800,
    ["scale"] = 1.2,
    ["displayId"] = 81996,
    ["creatureType"] = "Humanoid",
    ["level"] = 70,
    ["reaping"] = 148894,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Mind Soothe"] = true,
    },
    ["spells"] = {
    },
    ["clones"] = {
      [1] = {
        ["x"] = 66.425776874058,
        ["y"] = -121.31033447229,
        ["sublevel"] = 1,
        ["scale"] = 1.6,
      },
    },
  },
  [21] = {
    ["name"] = "Bewitched Captain",
    ["id"] = 131587,
    ["count"] = 6,
    ["health"] = 2606780,
    ["scale"] = 1,
    ["displayId"] = 84078,
    ["creatureType"] = "Humanoid",
    ["level"] = 70,
    ["reaping"] = 148716,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Mind Soothe"] = true,
    },
    ["spells"] = {
      [264027] = {
      },
      [265368] = {
      },
      [265372] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 478.05197500957,
        ["y"] = -264.23854290127,
        ["g"] = 11,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
        ["patrol"] = {
          [1] = {
            ["x"] = 478.05197500957,
            ["y"] = -264.23854290127,
          },
          [2] = {
            ["x"] = 478.04539320246,
            ["y"] = -289.82518653743,
          },
          [3] = {
            ["x"] = 478.8286873092,
            ["y"] = -336.03847810908,
          },
          [4] = {
            ["x"] = 478.04539320246,
            ["y"] = -289.82518653743,
          },
          [5] = {
            ["x"] = 478.05197500957,
            ["y"] = -264.23854290127,
          },
          [6] = {
            ["x"] = 475.95665871716,
            ["y"] = -243.61186508615,
          },
          [7] = {
            ["x"] = 476.47883486858,
            ["y"] = -225.07431291458,
          },
          [8] = {
            ["x"] = 475.95665871716,
            ["y"] = -243.61186508615,
          },
        },
        ["infested"] = {
          [2] = true,
        },
      },
      [2] = {
        ["x"] = 461.84118561738,
        ["y"] = -211.7713947647,
        ["g"] = 12,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
      [3] = {
        ["x"] = 497.08815771616,
        ["y"] = -192.37948191119,
        ["g"] = 13,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
        ["patrol"] = {
          [1] = {
            ["x"] = 497.08815771616,
            ["y"] = -192.37948191119,
          },
          [2] = {
            ["x"] = 495.19614696731,
            ["y"] = -211.46698358937,
          },
          [3] = {
            ["x"] = 477.01298718101,
            ["y"] = -212.16633999318,
          },
          [4] = {
            ["x"] = 475.14804566357,
            ["y"] = -180.22921984192,
          },
          [5] = {
            ["x"] = 477.01298718101,
            ["y"] = -212.16633999318,
          },
          [6] = {
            ["x"] = 495.19614696731,
            ["y"] = -211.46698358937,
          },
          [7] = {
            ["x"] = 497.08815771616,
            ["y"] = -192.37948191119,
          },
          [8] = {
            ["x"] = 495.19614696731,
            ["y"] = -168.34014763794,
          },
        },
        ["infested"] = {
          [1] = true,
        },
      },
      [4] = {
        ["x"] = 269.91623437477,
        ["y"] = -483.45736892563,
        ["g"] = 51,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
      [5] = {
        ["x"] = 88.467609415439,
        ["y"] = -407.12960210318,
        ["g"] = 54,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
    },
  },
  [22] = {
    ["name"] = "Dreadwing Raven",
    ["id"] = 135049,
    ["count"] = 2,
    ["health"] = 888675,
    ["scale"] = 0.8,
    ["displayId"] = 47534,
    ["creatureType"] = "Beast",
    ["level"] = 70,
    ["reaping"] = 148716,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [264027] = {
      },
      [265346] = {
      },
      [265347] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 55.614529229678,
        ["y"] = -103.71309387104,
        ["g"] = 47,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
      [2] = {
        ["x"] = 56.282917606833,
        ["y"] = -144.23010605358,
        ["g"] = 46,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
        ["infested"] = {
          [2] = true,
        },
      },
      [3] = {
        ["x"] = 49.782305667597,
        ["y"] = -177.82642151378,
        ["g"] = 45,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
      [4] = {
        ["x"] = 37.656673351023,
        ["y"] = -268.22848216169,
        ["g"] = 44,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
    },
  },
  [23] = {
    ["name"] = "Marked Sister",
    ["id"] = 131818,
    ["count"] = 4,
    ["health"] = 768495,
    ["scale"] = 1,
    ["displayId"] = 81995,
    ["creatureType"] = "Humanoid",
    ["level"] = 70,
    ["reaping"] = 148716,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Mind Soothe"] = true,
    },
    ["spells"] = {
    },
    ["clones"] = {
      [3] = {
        ["x"] = 435.82505765648,
        ["y"] = -389.2247697293,
        ["g"] = 22,
        ["sublevel"] = 1,
        ["scale"] = 1,
        ["teeming"] = true,
      },
      [4] = {
        ["x"] = 40.72320698027,
        ["y"] = -213.46745318973,
        ["g"] = 29,
        ["sublevel"] = 1,
        ["scale"] = 1,
        ["teeming"] = true,
      },
    },
  },
  [24] = {
    ["name"] = "Soulbound Goliath",
    ["id"] = 131667,
    ["count"] = 0,
    ["health"] = 10375700,
    ["scale"] = 1,
    ["displayId"] = 79398,
    ["creatureType"] = "Giant",
    ["level"] = 70,
    ["isBoss"] = true,
    ["encounterID"] = 2126,
    ["instanceID"] = 1021,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [260508] = {
      },
      [260512] = {
      },
      [260541] = {
      },
      [260547] = {
      },
      [260551] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 594.44872526825,
        ["y"] = -30.294432450038,
        ["g"] = 22,
        ["sublevel"] = 1,
        ["scale"] = 1.6,
      },
    },
  },
  [25] = {
    ["name"] = "Matron Bryndle",
    ["id"] = 135329,
    ["count"] = 10,
    ["health"] = 3554700,
    ["scale"] = 1.2,
    ["displayId"] = 84208,
    ["creatureType"] = "Undead",
    ["level"] = 70,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [265741] = {
      },
      [265757] = {
      },
      [265759] = {
      },
      [265760] = {
      },
      [265761] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 592.95124862405,
        ["y"] = -58.24953612183,
        ["g"] = 21,
        ["sublevel"] = 1,
        ["scale"] = 1.8,
        ["infested"] = {
          [3] = true,
        },
      },
    },
  },
  [26] = {
    ["name"] = "Jagged Hound",
    ["id"] = 131669,
    ["count"] = 1,
    ["health"] = 296225,
    ["scale"] = 0.7,
    ["displayId"] = 79871,
    ["creatureType"] = "Aberration",
    ["level"] = 70,
    ["reaping"] = 148716,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Incapacitate"] = true,
      ["Silence"] = true,
      ["Knock"] = true,
      ["Grip"] = true,
      ["Root"] = true,
      ["Fear"] = true,
      ["Banish"] = true,
      ["Disorient"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
      ["Sleep Walk"] = true,
    },
    ["spells"] = {
      [264140] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 605.49177293573,
        ["y"] = -69.134468859665,
        ["g"] = 21,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
      [2] = {
        ["x"] = 593.45729552893,
        ["y"] = -73.049166307039,
        ["g"] = 21,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
      [3] = {
        ["x"] = 582.67452619108,
        ["y"] = -68.743116268335,
        ["g"] = 21,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
      [4] = {
        ["x"] = 600.1933223786,
        ["y"] = -192.95373103367,
        ["g"] = 18,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
      [5] = {
        ["x"] = 584.52196921723,
        ["y"] = -192.4870071289,
        ["g"] = 18,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
      [6] = {
        ["x"] = 600.13884654258,
        ["y"] = -178.74691293215,
        ["g"] = 18,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
      [7] = {
        ["x"] = 564.38881355702,
        ["y"] = -205.66009425711,
        ["g"] = 16,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
        ["patrol"] = {
          [1] = {
            ["x"] = 564.58079007305,
            ["y"] = -209.88363253545,
          },
          [2] = {
            ["x"] = 564.57061692112,
            ["y"] = -185.62326328445,
          },
          [3] = {
            ["x"] = 565.53049956856,
            ["y"] = -148.76322036505,
          },
          [4] = {
            ["x"] = 570.33000068699,
            ["y"] = -120.92618418312,
          },
          [5] = {
            ["x"] = 597.97503836912,
            ["y"] = -114.2068957995,
          },
          [6] = {
            ["x"] = 613.14142587206,
            ["y"] = -120.54223112415,
          },
          [7] = {
            ["x"] = 617.9409269905,
            ["y"] = -145.88350651181,
          },
          [8] = {
            ["x"] = 617.74888455009,
            ["y"] = -181.39971372479,
          },
          [9] = {
            ["x"] = 616.98102237275,
            ["y"] = -214.8041351728,
          },
          [10] = {
            ["x"] = 603.35046907602,
            ["y"] = -231.31436936731,
          },
          [11] = {
            ["x"] = 583.00064936597,
            ["y"] = -234.1940722354,
          },
          [12] = {
            ["x"] = 567.83426186303,
            ["y"] = -229.20259458748,
          },
        },
        ["infested"] = {
          [1] = true,
        },
      },
      [8] = {
        ["x"] = 560.64100917202,
        ["y"] = -212.56319150057,
        ["g"] = 16,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
      [9] = {
        ["x"] = 570.33814047556,
        ["y"] = -210.57082336558,
        ["g"] = 16,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
      [10] = {
        ["x"] = 280.82330495334,
        ["y"] = -332.62233280663,
        ["g"] = 50,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
      [11] = {
        ["x"] = 290.53255152068,
        ["y"] = -332.94940648978,
        ["g"] = 50,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
      [12] = {
        ["x"] = 274.47764717562,
        ["y"] = -340.18268538053,
        ["g"] = 50,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
      [13] = {
        ["x"] = 298.12598316064,
        ["y"] = -339.91947407261,
        ["g"] = 50,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
        ["infested"] = {
          [1] = true,
        },
      },
      [14] = {
        ["x"] = 584.40421366427,
        ["y"] = -178.48583584159,
        ["g"] = 18,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
        ["infested"] = {
          [1] = true,
        },
      },
      [15] = {
        ["x"] = 559.87111405353,
        ["y"] = -222.09361488276,
        ["g"] = 16,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
      [16] = {
        ["x"] = 567.28248483814,
        ["y"] = -218.51300959305,
        ["g"] = 16,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
      [17] = {
        ["x"] = 569.56964133236,
        ["y"] = -227.41194209912,
        ["g"] = 16,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
      [18] = {
        ["x"] = 575.34119735766,
        ["y"] = -217.65579042133,
        ["g"] = 16,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
    },
  },
  [27] = {
    ["name"] = "Coven Thornshaper",
    ["id"] = 131666,
    ["count"] = 4,
    ["health"] = 1333013,
    ["scale"] = 1,
    ["displayId"] = 80939,
    ["creatureType"] = "Humanoid",
    ["level"] = 70,
    ["reaping"] = 148893,
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
      [264038] = {
      },
      [264050] = {
      },
      [278849] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 604.03280522996,
        ["y"] = -95.453673913623,
        ["g"] = 20,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
      [2] = {
        ["x"] = 586.23797984919,
        ["y"] = -94.129327930811,
        ["g"] = 20,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
        ["infested"] = {
          [2] = true,
        },
      },
      [3] = {
        ["x"] = 592.32127516911,
        ["y"] = -147.86488162005,
        ["g"] = 19,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
      [4] = {
        ["x"] = 592.33323259634,
        ["y"] = -185.65894767234,
        ["g"] = 18,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
      [5] = {
        ["x"] = 621.66578060889,
        ["y"] = -226.58920414159,
        ["g"] = 17,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
        ["infested"] = {
          [2] = true,
        },
      },
      [6] = {
        ["x"] = 612.84455088437,
        ["y"] = -237.60618351646,
        ["g"] = 17,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
        ["infested"] = {
          [3] = true,
        },
      },
      [7] = {
        ["x"] = 286.40490610524,
        ["y"] = -344.77550564326,
        ["g"] = 50,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
        ["infested"] = {
          [2] = true,
        },
      },
    },
  },
  [28] = {
    ["name"] = "Thornguard",
    ["id"] = 131858,
    ["count"] = 4,
    ["health"] = 1629238,
    ["scale"] = 1,
    ["displayId"] = 80957,
    ["creatureType"] = "Aberration",
    ["level"] = 70,
    ["reaping"] = 148716,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Incapacitate"] = true,
      ["Silence"] = true,
      ["Knock"] = true,
      ["Grip"] = true,
      ["Root"] = true,
      ["Fear"] = true,
      ["Banish"] = true,
      ["Disorient"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
      ["Sleep Walk"] = true,
    },
    ["spells"] = {
      [257260] = {
      },
      [264150] = {
      },
      [264556] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 592.19059577716,
        ["y"] = -132.94658561462,
        ["g"] = 19,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
        ["infested"] = {
          [3] = true,
        },
      },
      [2] = {
        ["x"] = 625.46984141829,
        ["y"] = -240.55608777395,
        ["g"] = 17,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
        ["infested"] = {
          [1] = true,
        },
      },
      [3] = {
        ["x"] = 599.06722120169,
        ["y"] = -80.32447008033,
        ["g"] = 55,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
        ["teeming"] = true,
      },
    },
  },
  [29] = {
    ["name"] = "Faceless Maiden",
    ["id"] = 131821,
    ["count"] = 0,
    ["health"] = 1184900,
    ["scale"] = 1,
    ["displayId"] = 82075,
    ["creatureType"] = "Humanoid",
    ["level"] = 70,
    ["reaping"] = 148893,
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
      [256921] = {
      },
      [256922] = {
      },
      [264407] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 321.32783261892,
        ["y"] = -162.91913940655,
        ["g"] = 48,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
        ["infested"] = {
          [1] = true,
        },
      },
      [2] = {
        ["x"] = 291.76190413048,
        ["y"] = -163.65410052882,
        ["g"] = 48,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
      [3] = {
        ["x"] = 94.62071699063,
        ["y"] = -392.34122916265,
        ["g"] = 54,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
    },
  },
  [30] = {
    ["name"] = "Heartsbane Soulcharmer",
    ["id"] = 131812,
    ["count"] = 6,
    ["health"] = 2369800,
    ["scale"] = 1.2,
    ["displayId"] = 82071,
    ["creatureType"] = "Humanoid",
    ["level"] = 71,
    ["reaping"] = 148894,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Mind Soothe"] = true,
    },
    ["spells"] = {
      [263959] = {
      },
      [263961] = {
      },
      [264024] = {
      },
      [264027] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 473.2160538848,
        ["y"] = -190.89048477441,
        ["g"] = 14,
        ["sublevel"] = 1,
        ["scale"] = 1.6,
      },
      [2] = {
        ["x"] = 478.9887009694,
        ["y"] = -220.73693157834,
        ["g"] = 26,
        ["sublevel"] = 1,
        ["scale"] = 1,
        ["teeming"] = true,
      },
      [3] = {
        ["x"] = 484.62304421594,
        ["y"] = -501.2321444896,
        ["g"] = 57,
        ["sublevel"] = 1,
        ["scale"] = 1.6,
        ["infested"] = {
          [2] = true,
        },
      },
      [4] = {
        ["x"] = 512.628506462,
        ["y"] = -521.89463558192,
        ["g"] = 56,
        ["sublevel"] = 1,
        ["scale"] = 1.6,
      },
      [5] = {
        ["x"] = 307.06531961334,
        ["y"] = -170.74881085075,
        ["g"] = 48,
        ["sublevel"] = 1,
        ["scale"] = 1.6,
      },
    },
  },
  [31] = {
    ["name"] = "Matron Alma",
    ["id"] = 135365,
    ["count"] = 16,
    ["health"] = 3554700,
    ["scale"] = 1.5,
    ["displayId"] = 84236,
    ["creatureType"] = "Undead",
    ["level"] = 71,
    ["reaping"] = 148894,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [265876] = {
      },
      [265880] = {
      },
      [265881] = {
      },
      [265882] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 202.42265792426,
        ["y"] = -418.72293402746,
        ["g"] = 52,
        ["sublevel"] = 1,
        ["scale"] = 1.8,
        ["patrol"] = {
          [1] = {
            ["x"] = 202.42265792426,
            ["y"] = -418.72293402746,
          },
          [2] = {
            ["x"] = 240.32325667693,
            ["y"] = -418.65448676166,
          },
          [3] = {
            ["x"] = 288.76274471477,
            ["y"] = -418.65448676166,
          },
          [4] = {
            ["x"] = 240.32325667693,
            ["y"] = -418.65448676166,
          },
          [5] = {
            ["x"] = 202.42265792426,
            ["y"] = -418.72293402746,
          },
          [6] = {
            ["x"] = 154.43773634318,
            ["y"] = -417.96739332058,
          },
          [7] = {
            ["x"] = 104.28062281966,
            ["y"] = -417.96739332058,
          },
          [8] = {
            ["x"] = 102.56289904579,
            ["y"] = -458.84889282187,
          },
          [9] = {
            ["x"] = 104.28062281966,
            ["y"] = -417.96739332058,
          },
          [10] = {
            ["x"] = 154.43773634318,
            ["y"] = -417.96739332058,
          },
        },
        ["infested"] = {
          [3] = true,
        },
      },
    },
  },
  [32] = {
    ["name"] = "Coven Diviner",
    ["id"] = 131819,
    ["count"] = 4,
    ["health"] = 1333013,
    ["scale"] = 1,
    ["displayId"] = 82073,
    ["creatureType"] = "Humanoid",
    ["level"] = 70,
    ["reaping"] = 148893,
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
      [264027] = {
      },
      [264378] = {
      },
      [426596] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 127.94555014752,
        ["y"] = -447.61681022713,
        ["g"] = 53,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
      [2] = {
        ["x"] = 479.47994479535,
        ["y"] = -523.22753641533,
        ["g"] = 55,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
        ["patrol"] = {
          [1] = {
            ["x"] = 479.47994479535,
            ["y"] = -523.22753641533,
          },
          [2] = {
            ["x"] = 495.8719961665,
            ["y"] = -520.68760247741,
          },
          [3] = {
            ["x"] = 512.19020271312,
            ["y"] = -507.03958062029,
          },
          [4] = {
            ["x"] = 517.53077581673,
            ["y"] = -493.68830065472,
          },
          [5] = {
            ["x"] = 512.19020271312,
            ["y"] = -507.03958062029,
          },
          [6] = {
            ["x"] = 495.8719961665,
            ["y"] = -520.68760247741,
          },
          [7] = {
            ["x"] = 479.47994479535,
            ["y"] = -523.22753641533,
          },
          [8] = {
            ["x"] = 455.81810533863,
            ["y"] = -519.79749564211,
          },
          [9] = {
            ["x"] = 442.17011743561,
            ["y"] = -506.44618172244,
          },
          [10] = {
            ["x"] = 455.81810533863,
            ["y"] = -519.79749564211,
          },
        },
      },
      [3] = {
        ["x"] = 83.14752990826,
        ["y"] = -390.98475377211,
        ["g"] = 39,
        ["sublevel"] = 1,
        ["scale"] = 1.6,
        ["teeming"] = true,
      },
      [4] = {
        ["x"] = 384.00733937464,
        ["y"] = -291.6686996682,
        ["g"] = 39,
        ["sublevel"] = 1,
        ["scale"] = 1.6,
        ["teeming"] = true,
      },
    },
  },
  [33] = {
    ["name"] = "Lord Waycrest",
    ["id"] = 131527,
    ["count"] = 0,
    ["health"] = 2964486,
    ["scale"] = 1,
    ["displayId"] = 83349,
    ["creatureType"] = "Undead",
    ["level"] = 72,
    ["isBoss"] = true,
    ["encounterID"] = 2128,
    ["instanceID"] = 1021,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [261438] = {
      },
      [261439] = {
      },
      [261440] = {
      },
      [261447] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 490.65779185336,
        ["y"] = -427.29391832084,
        ["g"] = 58,
        ["sublevel"] = 1,
        ["scale"] = 1.6,
      },
    },
  },
  [34] = {
    ["name"] = "Lady Waycrest",
    ["id"] = 131545,
    ["count"] = 0,
    ["health"] = 29644856,
    ["scale"] = 1,
    ["displayId"] = 87188,
    ["creatureType"] = "Undead",
    ["level"] = 72,
    ["isBoss"] = true,
    ["encounterID"] = 2128,
    ["instanceID"] = 1021,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [261446] = {
      },
      [268271] = {
      },
      [268278] = {
      },
      [268306] = {
      },
      [268308] = {
      },
      [271590] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 467.16214835543,
        ["y"] = -427.74283762727,
        ["g"] = 58,
        ["sublevel"] = 1,
        ["scale"] = 1.6,
      },
    },
  },
  [35] = {
    ["name"] = "Gloom Horror",
    ["id"] = 139269,
    ["count"] = 2,
    ["health"] = 1184900,
    ["scale"] = 1,
    ["displayId"] = 86207,
    ["creatureType"] = "Aberration",
    ["level"] = 70,
    ["reaping"] = 148716,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Incapacitate"] = true,
      ["Silence"] = true,
      ["Knock"] = true,
      ["Grip"] = true,
      ["Root"] = true,
      ["Fear"] = true,
      ["Banish"] = true,
      ["Disorient"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
      ["Sleep Walk"] = true,
    },
    ["spells"] = {
      [273657] = {
      },
      [273658] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 454.91509492167,
        ["y"] = -465.62082148552,
        ["g"] = 59,
        ["sublevel"] = 1,
        ["scale"] = 1.2,
      },
      [2] = {
        ["x"] = 445.3324771529,
        ["y"] = -457.68725392421,
        ["g"] = 59,
        ["sublevel"] = 1,
        ["scale"] = 1.2,
      },
      [3] = {
        ["x"] = 467.10056251285,
        ["y"] = -467.07017335861,
        ["g"] = 59,
        ["sublevel"] = 1,
        ["scale"] = 1.2,
      },
      [4] = {
        ["x"] = 480.23297067731,
        ["y"] = -466.84978543473,
        ["g"] = 59,
        ["sublevel"] = 1,
        ["scale"] = 1.2,
      },
      [5] = {
        ["x"] = 492.49859742937,
        ["y"] = -465.15222068282,
        ["g"] = 59,
        ["sublevel"] = 1,
        ["scale"] = 1.2,
      },
      [6] = {
        ["x"] = 506.33560633386,
        ["y"] = -460.10679623979,
        ["g"] = 59,
        ["sublevel"] = 1,
        ["scale"] = 1.2,
      },
      [7] = {
        ["x"] = 516.81991181089,
        ["y"] = -452.30775016391,
        ["g"] = 59,
        ["sublevel"] = 1,
        ["scale"] = 1.2,
      },
    },
  },
  [36] = {
    ["name"] = "Gorak Tul",
    ["id"] = 131864,
    ["count"] = 0,
    ["health"] = 9338130,
    ["scale"] = 1,
    ["displayId"] = 85983,
    ["creatureType"] = "Humanoid",
    ["level"] = 72,
    ["isBoss"] = true,
    ["encounterID"] = 2129,
    ["instanceID"] = 1021,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Mind Soothe"] = true,
    },
    ["spells"] = {
      [266181] = {
      },
      [266225] = {
      },
      [266266] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 725.92813040581,
        ["y"] = -409.90423250282,
        ["g"] = 60,
        ["sublevel"] = 1,
        ["scale"] = 1.6,
      },
    },
  },
};
