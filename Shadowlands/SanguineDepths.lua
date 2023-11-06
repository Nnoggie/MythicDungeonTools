local MDT = MDT
local L = MDT.L
local dungeonIndex = 33
MDT.dungeonList[dungeonIndex] = L["Sanguine Depths"]
MDT.mapInfo[dungeonIndex] = {

};


local zones = { 1675, 1676 }
for _, zone in ipairs(zones) do
  MDT.zoneIdToDungeonIdx[zone] = dungeonIndex
end

MDT.dungeonMaps[dungeonIndex] = {
  [0] = "SanguineDepths_A",
  [1] = "SanguineDepths_A",
  [2] = "SanguineDepths_B",
}
MDT.dungeonSubLevels[dungeonIndex] = {
  [1] = L["Sanguine DepthsFloor1"],
  [2] = L["Sanguine DepthsFloor2"],
}

MDT.dungeonTotalCount[dungeonIndex] = { normal = 364, teeming = 1000, teemingEnabled = true }

MDT.mapPOIs[dungeonIndex] = {
  [1] = {
    [1] = {
      ["template"] = "MapLinkPinTemplate",
      ["type"] = "mapLink",
      ["x"] = 387.15527024252,
      ["y"] = -496.41167079063,
      ["target"] = 2,
      ["direction"] = -1,
      ["connectionIndex"] = 1,
    },
  },
  [2] = {
    [1] = {
      ["template"] = "MapLinkPinTemplate",
      ["type"] = "mapLink",
      ["x"] = 433.07520014301,
      ["y"] = -430.69862845572,
      ["target"] = 1,
      ["direction"] = 1,
      ["connectionIndex"] = 1,
    },
  },
};

MDT.dungeonEnemies[dungeonIndex] = {
  [1] = {
    ["name"] = "Grubby Dirtcruncher",
    ["id"] = 162041,
    ["count"] = 2,
    ["health"] = 223514,
    ["scale"] = 1,
    ["displayId"] = 93815,
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
      [316068] = {
      },
      [334470] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 272.62967741936,
        ["y"] = -102.75258064516,
        ["g"] = 4,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 251.91569892473,
        ["y"] = -127.01741935484,
        ["g"] = 4,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 701.71276684742,
        ["y"] = -305.61505737991,
        ["g"] = 16,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 696.08602150538,
        ["y"] = -298.55419354839,
        ["g"] = 16,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 693.62587151986,
        ["y"] = -305.75230614423,
        ["g"] = 16,
        ["sublevel"] = 1,
      },
      [6] = {
        ["x"] = 698.63487687614,
        ["y"] = -311.47445288521,
        ["g"] = 16,
        ["sublevel"] = 1,
      },
      [7] = {
        ["x"] = 555.14924538883,
        ["y"] = -292.0880717791,
        ["g"] = 19,
        ["sublevel"] = 1,
      },
      [8] = {
        ["x"] = 577.53916141163,
        ["y"] = -296.90200954058,
        ["g"] = 19,
        ["sublevel"] = 1,
      },
      [9] = {
        ["x"] = 563.64903225807,
        ["y"] = -281.46258064516,
        ["g"] = 19,
        ["sublevel"] = 1,
      },
      [10] = {
        ["x"] = 573.95351103529,
        ["y"] = -283.20148577361,
        ["g"] = 19,
        ["sublevel"] = 1,
      },
      [11] = {
        ["x"] = 565.46752688172,
        ["y"] = -291.6435483871,
        ["g"] = 19,
        ["sublevel"] = 1,
      },
    },
  },
  [2] = {
    ["name"] = "Famished Tick",
    ["id"] = 162046,
    ["count"] = 1,
    ["health"] = 99239,
    ["scale"] = 1,
    ["displayId"] = 94227,
    ["creatureType"] = "Aberration",
    ["level"] = 60,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Incapacitate"] = true,
      ["Silence"] = true,
      ["Mind Control"] = true,
      ["Polymorph"] = true,
      ["Root"] = true,
      ["Fear"] = true,
      ["Banish"] = true,
      ["Disorient"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
    },
    ["spells"] = {
      [320843] = {
      },
      [320861] = {
        ["interruptible"] = true,
      },
      [320862] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 163.55073121641,
        ["y"] = -278.45203214677,
        ["g"] = 1,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 167.82931163076,
        ["y"] = -270.50093549433,
        ["g"] = 1,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 217.14251552474,
        ["y"] = -233.52516110582,
        ["g"] = 2,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 220.69356977894,
        ["y"] = -241.46675227286,
        ["g"] = 2,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 373.15268817204,
        ["y"] = -75.945483870968,
        ["g"] = 6,
        ["sublevel"] = 1,
      },
      [6] = {
        ["x"] = 359.77432342513,
        ["y"] = -73.938671768612,
        ["g"] = 6,
        ["sublevel"] = 1,
      },
      [7] = {
        ["x"] = 439.78955524304,
        ["y"] = -87.755238005483,
        ["g"] = 7,
        ["sublevel"] = 1,
      },
      [8] = {
        ["x"] = 418.49731333583,
        ["y"] = -90.796388787749,
        ["g"] = 7,
        ["sublevel"] = 1,
      },
      [9] = {
        ["x"] = 418.46863703661,
        ["y"] = -102.55767095464,
        ["g"] = 7,
        ["sublevel"] = 1,
      },
      [10] = {
        ["x"] = 442.26493974282,
        ["y"] = -98.864004168398,
        ["g"] = 7,
        ["sublevel"] = 1,
      },
      [11] = {
        ["x"] = 426.81989202185,
        ["y"] = -85.185115831167,
        ["g"] = 7,
        ["sublevel"] = 1,
      },
    },
  },
  [3] = {
    ["name"] = "Noble Skirmisher",
    ["id"] = 166396,
    ["count"] = 4,
    ["health"] = 165398,
    ["scale"] = 1,
    ["displayId"] = 94441,
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
      [324609] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 159.61223632011,
        ["y"] = -270.37697900853,
        ["g"] = 1,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 211.27387115224,
        ["y"] = -248.94970958704,
        ["g"] = 2,
        ["sublevel"] = 1,
        ["inspiring"] = true,
      },
      [3] = {
        ["x"] = 205.58333342148,
        ["y"] = -242.68380602361,
        ["g"] = 2,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 680.82172833876,
        ["y"] = -279.7160254597,
        ["g"] = 15,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 273.1435426718,
        ["y"] = -121.79699760455,
        ["g"] = 40,
        ["sublevel"] = 2,
      },
      [6] = {
        ["x"] = 278.38377716935,
        ["y"] = -134.97892320956,
        ["g"] = 40,
        ["sublevel"] = 2,
      },
    },
  },
  [4] = {
    ["name"] = "Gluttonous Tick",
    ["id"] = 165076,
    ["count"] = 4,
    ["health"] = 148858,
    ["scale"] = 1,
    ["displayId"] = 94226,
    ["creatureType"] = "Aberration",
    ["level"] = 60,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Incapacitate"] = true,
      ["Silence"] = true,
      ["Mind Control"] = true,
      ["Polymorph"] = true,
      ["Root"] = true,
      ["Fear"] = true,
      ["Banish"] = true,
      ["Disorient"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
    },
    ["spells"] = {
      [320843] = {
      },
      [321401] = {
      },
      [321402] = {
      },
      [334653] = {
        ["interruptible"] = true,
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 276.44731182796,
        ["y"] = -102.81225806452,
        ["g"] = 4,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 287.58709677419,
        ["y"] = -157.88258064516,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 276.95311827957,
        ["y"] = -129.35677419355,
        ["g"] = 4,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 364.25290322581,
        ["y"] = -90.566451612903,
        ["g"] = 5,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 374.27228313295,
        ["y"] = -102.30539265347,
        ["g"] = 5,
        ["sublevel"] = 1,
        ["inspiring"] = true,
      },
      [6] = {
        ["x"] = 361.81981001467,
        ["y"] = -101.70141748276,
        ["g"] = 5,
        ["sublevel"] = 1,
      },
      [7] = {
        ["x"] = 436.76212108869,
        ["y"] = -106.52184713703,
        ["g"] = 7,
        ["sublevel"] = 1,
        ["inspiring"] = true,
      },
      [8] = {
        ["x"] = 425.88413948227,
        ["y"] = -101.02272804199,
        ["g"] = 7,
        ["sublevel"] = 1,
      },
    },
  },
  [5] = {
    ["name"] = "Dreadful Huntmaster",
    ["id"] = 171448,
    ["count"] = 4,
    ["health"] = 148858,
    ["scale"] = 1,
    ["displayId"] = 93035,
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
      [334558] = {
      },
      [334567] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 213.589871274,
        ["y"] = -241.83856927773,
        ["g"] = 2,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 262.14021505376,
        ["y"] = -209.49161290323,
        ["g"] = 3,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 254.99870967742,
        ["y"] = -197.36516129032,
        ["g"] = 3,
        ["sublevel"] = 1,
        ["inspiring"] = true,
      },
      [4] = {
        ["x"] = 564.65227044691,
        ["y"] = -283.52959039497,
        ["g"] = 33,
        ["sublevel"] = 2,
      },
      [5] = {
        ["x"] = 571.2903192274,
        ["y"] = -288.611612428,
        ["g"] = 33,
        ["sublevel"] = 2,
        ["inspiring"] = true,
      },
      [6] = {
        ["x"] = 155.83053101297,
        ["y"] = -140.23714625196,
        ["g"] = 41,
        ["sublevel"] = 2,
      },
      [7] = {
        ["x"] = 168.91512195122,
        ["y"] = -134.40475609756,
        ["g"] = 41,
        ["sublevel"] = 2,
        ["inspiring"] = true,
      },
    },
  },
  [6] = {
    ["name"] = "Regal Mistdancer",
    ["id"] = 162038,
    ["count"] = 7,
    ["health"] = 264636,
    ["scale"] = 1,
    ["displayId"] = 96681,
    ["creatureType"] = "Humanoid",
    ["level"] = 60,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [320991] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 255.42799146215,
        ["y"] = -204.97831990158,
        ["g"] = 3,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 662.04078493163,
        ["y"] = -255.40195278292,
        ["g"] = 14,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 653.58140443079,
        ["y"] = -254.72782568951,
        ["g"] = 14,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 672.17311861742,
        ["y"] = -281.3979077383,
        ["g"] = 15,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 682.91096774194,
        ["y"] = -286.38,
        ["g"] = 15,
        ["sublevel"] = 1,
      },
      [6] = {
        ["x"] = 587.26243902439,
        ["y"] = -252.26780487805,
        ["g"] = 34,
        ["sublevel"] = 2,
      },
    },
  },
  [7] = {
    ["name"] = "Insatiable Brute",
    ["id"] = 162047,
    ["count"] = 7,
    ["health"] = 248097,
    ["scale"] = 1.5,
    ["displayId"] = 93853,
    ["creatureType"] = "Aberration",
    ["level"] = 60,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [321178] = {
      },
      [334246] = {
      },
      [334918] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 301.56399890048,
        ["y"] = -190.30204318703,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 290.24860215054,
        ["y"] = -107.88483870968,
        ["g"] = 4,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 431.63540080717,
        ["y"] = -93.336241996268,
        ["g"] = 7,
        ["sublevel"] = 1,
      },
    },
  },
  [8] = {
    ["name"] = "Kryxis the Voracious",
    ["id"] = 162100,
    ["count"] = 0,
    ["health"] = 1156365,
    ["scale"] = 1,
    ["displayId"] = 98966,
    ["creatureType"] = "Aberration",
    ["level"] = 60,
    ["isBoss"] = true,
    ["encounterID"] = 2388,
    ["instanceID"] = 1189,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [319650] = {
      },
      [319654] = {
        ["interruptible"] = true,
      },
      [319657] = {
      },
      [319685] = {
      },
      [319713] = {
      },
      [330468] = {
      },
      [338471] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 474.41032258065,
        ["y"] = -97.453225806452,
        ["sublevel"] = 1,
      },
    },
  },
  [9] = {
    ["name"] = "Wicked Oppressor",
    ["id"] = 162039,
    ["count"] = 4,
    ["health"] = 138934,
    ["scale"] = 1,
    ["displayId"] = 94573,
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
      [321038] = {
        ["interruptible"] = true,
      },
      [326836] = {
        ["interruptible"] = true,
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 519.61184100506,
        ["y"] = -102.82267354454,
        ["g"] = 8,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 518.50065559975,
        ["y"] = -111.72407414921,
        ["g"] = 8,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 517.6447311828,
        ["y"] = -155.13741935484,
        ["g"] = 10,
        ["sublevel"] = 1,
        ["inspiring"] = true,
      },
      [4] = {
        ["x"] = 559.5423655914,
        ["y"] = -194.14258064516,
        ["g"] = 11,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 562.17978494624,
        ["y"] = -186.38451612903,
        ["g"] = 11,
        ["sublevel"] = 1,
      },
      [6] = {
        ["x"] = 601.98193548387,
        ["y"] = -225.42548387097,
        ["g"] = 12,
        ["sublevel"] = 1,
      },
      [7] = {
        ["x"] = 606.8111827957,
        ["y"] = -217.75096774194,
        ["g"] = 12,
        ["sublevel"] = 1,
      },
      [8] = {
        ["x"] = 620.58122316094,
        ["y"] = -203.67169577664,
        ["g"] = 13,
        ["sublevel"] = 1,
      },
      [9] = {
        ["x"] = 631.31487405791,
        ["y"] = -202.32677353943,
        ["g"] = 13,
        ["sublevel"] = 1,
      },
      [10] = {
        ["x"] = 579.13266041371,
        ["y"] = -260.51580645161,
        ["g"] = 18,
        ["sublevel"] = 1,
      },
      [11] = {
        ["x"] = 590.97143012239,
        ["y"] = -267.15112064169,
        ["g"] = 18,
        ["sublevel"] = 1,
        ["inspiring"] = true,
      },
      [12] = {
        ["x"] = 439.02634146342,
        ["y"] = -366.9362195122,
        ["g"] = 31,
        ["sublevel"] = 2,
      },
      [13] = {
        ["x"] = 497.60569365397,
        ["y"] = -370.3548348701,
        ["sublevel"] = 2,
        ["inspiring"] = true,
        ["patrol"] = {
          [1] = {
            ["x"] = 497.60569365397,
            ["y"] = -370.3548348701,
          },
          [2] = {
            ["x"] = 505.94250666051,
            ["y"] = -378.23589328256,
          },
          [3] = {
            ["x"] = 512.27627282135,
            ["y"] = -390.30966794195,
          },
          [4] = {
            ["x"] = 515.04728914602,
            ["y"] = -398.42481751514,
          },
          [5] = {
            ["x"] = 512.27627282135,
            ["y"] = -390.30966794195,
          },
          [6] = {
            ["x"] = 505.94250666051,
            ["y"] = -378.23589328256,
          },
          [7] = {
            ["x"] = 497.60569365397,
            ["y"] = -370.3548348701,
          },
          [8] = {
            ["x"] = 483.97217353278,
            ["y"] = -359.82832697954,
          },
          [9] = {
            ["x"] = 469.72115719956,
            ["y"] = -357.25524403274,
          },
          [10] = {
            ["x"] = 454.48050795402,
            ["y"] = -357.05729366634,
          },
          [11] = {
            ["x"] = 469.72115719956,
            ["y"] = -357.25524403274,
          },
          [12] = {
            ["x"] = 483.97217353278,
            ["y"] = -359.82832697954,
          },
        },
      },
      [14] = {
        ["x"] = 508.35707317073,
        ["y"] = -412.71695121951,
        ["g"] = 32,
        ["sublevel"] = 2,
      },
      [15] = {
        ["x"] = 507.27804878049,
        ["y"] = -405.1906097561,
        ["g"] = 32,
        ["sublevel"] = 2,
      },
      [16] = {
        ["x"] = 565.48837894734,
        ["y"] = -274.95507368841,
        ["g"] = 33,
        ["sublevel"] = 2,
      },
      [17] = {
        ["x"] = 579.26156636827,
        ["y"] = -283.65520494254,
        ["g"] = 33,
        ["sublevel"] = 2,
      },
    },
  },
  [10] = {
    ["name"] = "Rockbound Sprite",
    ["id"] = 162056,
    ["count"] = 1,
    ["health"] = 49620,
    ["scale"] = 1,
    ["displayId"] = 94498,
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
      ["Imprison"] = true,
      ["Sap"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
    },
    ["spells"] = {
      [316244] = {
      },
      [321264] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 576.20067658913,
        ["y"] = -123.32215191524,
        ["g"] = 9,
        ["sublevel"] = 1,
        ["inspiring"] = true,
      },
      [2] = {
        ["x"] = 568.89916477811,
        ["y"] = -117.85587992448,
        ["g"] = 9,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 571.7805243739,
        ["y"] = -110.37038850841,
        ["g"] = 9,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 579.88764142031,
        ["y"] = -115.07587840232,
        ["g"] = 9,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 568.51950409176,
        ["y"] = -130.34089088451,
        ["g"] = 9,
        ["sublevel"] = 1,
      },
      [6] = {
        ["x"] = 577.87297538243,
        ["y"] = -131.89152515665,
        ["g"] = 9,
        ["sublevel"] = 1,
      },
      [7] = {
        ["x"] = 586.28873783735,
        ["y"] = -129.4516879713,
        ["g"] = 9,
        ["sublevel"] = 1,
      },
      [8] = {
        ["x"] = 589.00735271757,
        ["y"] = -119.7717115465,
        ["g"] = 9,
        ["sublevel"] = 1,
      },
      [9] = {
        ["x"] = 617.88181184219,
        ["y"] = -136.50033740956,
        ["g"] = 35,
        ["sublevel"] = 2,
      },
      [10] = {
        ["x"] = 616.41762348309,
        ["y"] = -144.33584731362,
        ["g"] = 35,
        ["sublevel"] = 2,
      },
      [11] = {
        ["x"] = 507.55104724588,
        ["y"] = -96.77672352668,
        ["g"] = 37,
        ["sublevel"] = 2,
      },
      [12] = {
        ["x"] = 506.16254075555,
        ["y"] = -103.7657827948,
        ["g"] = 37,
        ["sublevel"] = 2,
      },
      [13] = {
        ["x"] = 347.54600763927,
        ["y"] = -109.17356391243,
        ["g"] = 39,
        ["sublevel"] = 2,
      },
      [14] = {
        ["x"] = 344.5684179526,
        ["y"] = -100.74650841568,
        ["g"] = 39,
        ["sublevel"] = 2,
      },
    },
  },
  [11] = {
    ["name"] = "Dark Acolyte",
    ["id"] = 167956,
    ["count"] = 1,
    ["health"] = 57889,
    ["scale"] = 1,
    ["displayId"] = 93650,
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
      [326712] = {
        ["interruptible"] = true,
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 516.45247311828,
        ["y"] = -143.59580645161,
        ["g"] = 10,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 524.96688172043,
        ["y"] = -145.83967741935,
        ["g"] = 10,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 514.89892473118,
        ["y"] = -148.89516129032,
        ["g"] = 10,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 525.08731182796,
        ["y"] = -152.14161290323,
        ["g"] = 10,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 624.15609791072,
        ["y"] = -197.52612979962,
        ["g"] = 13,
        ["sublevel"] = 1,
      },
      [6] = {
        ["x"] = 619.83245121748,
        ["y"] = -190.8177787659,
        ["g"] = 13,
        ["sublevel"] = 1,
      },
      [7] = {
        ["x"] = 628.1309783464,
        ["y"] = -191.12577594643,
        ["g"] = 13,
        ["sublevel"] = 1,
      },
      [8] = {
        ["x"] = 636.16393766402,
        ["y"] = -194.94740732889,
        ["g"] = 13,
        ["sublevel"] = 1,
      },
      [9] = {
        ["x"] = 613.82667373631,
        ["y"] = -195.61485215711,
        ["g"] = 13,
        ["sublevel"] = 1,
      },
      [10] = {
        ["x"] = 702.49588405854,
        ["y"] = -269.43752521497,
        ["g"] = 17,
        ["sublevel"] = 1,
      },
      [11] = {
        ["x"] = 715.26614558015,
        ["y"] = -283.16239770883,
        ["g"] = 17,
        ["sublevel"] = 1,
      },
      [12] = {
        ["x"] = 719.69686683929,
        ["y"] = -278.3076213744,
        ["g"] = 17,
        ["sublevel"] = 1,
      },
      [13] = {
        ["x"] = 716.28155847883,
        ["y"] = -271.17418154043,
        ["g"] = 17,
        ["sublevel"] = 1,
      },
      [14] = {
        ["x"] = 710.74266538225,
        ["y"] = -268.09279183469,
        ["g"] = 17,
        ["sublevel"] = 1,
      },
      [15] = {
        ["x"] = 615.16183029384,
        ["y"] = -129.85130687721,
        ["g"] = 35,
        ["sublevel"] = 2,
      },
      [16] = {
        ["x"] = 610.16677187612,
        ["y"] = -141.57136656568,
        ["g"] = 35,
        ["sublevel"] = 2,
      },
      [17] = {
        ["x"] = 609.14938357943,
        ["y"] = -134.04870131521,
        ["g"] = 35,
        ["sublevel"] = 2,
      },
      [18] = {
        ["x"] = 444.48506831766,
        ["y"] = -94.90079623643,
        ["g"] = 38,
        ["sublevel"] = 2,
      },
      [19] = {
        ["x"] = 448.64195121951,
        ["y"] = -88.366829268293,
        ["g"] = 38,
        ["sublevel"] = 2,
      },
      [20] = {
        ["x"] = 455.27102122241,
        ["y"] = -98.963294617396,
        ["g"] = 38,
        ["sublevel"] = 2,
      },
      [21] = {
        ["x"] = 455.53498633647,
        ["y"] = -90.77524251845,
        ["g"] = 38,
        ["sublevel"] = 2,
      },
      [22] = {
        ["x"] = 448.10939348197,
        ["y"] = -100.68293324428,
        ["g"] = 38,
        ["sublevel"] = 2,
      },
      [23] = {
        ["x"] = 338.6406756692,
        ["y"] = -112.20215274737,
        ["g"] = 39,
        ["sublevel"] = 2,
      },
      [24] = {
        ["x"] = 335.87249506251,
        ["y"] = -103.09404585278,
        ["g"] = 39,
        ["sublevel"] = 2,
      },
    },
  },
  [12] = {
    ["name"] = "Chamber Sentinel",
    ["id"] = 162057,
    ["count"] = 7,
    ["health"] = 281177,
    ["scale"] = 1.4,
    ["displayId"] = 94737,
    ["creatureType"] = "Humanoid",
    ["level"] = 60,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [322429] = {
      },
      [322433] = {
        ["interruptible"] = true,
      },
      [328170] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 511.88850712579,
        ["y"] = -182.69551470959,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 635.39202518564,
        ["y"] = -244.72698778808,
        ["sublevel"] = 1,
        ["patrol"] = {
          [1] = {
            ["x"] = 635.39202518564,
            ["y"] = -244.72698778808,
          },
          [2] = {
            ["x"] = 619.22580631356,
            ["y"] = -235.8457072374,
          },
          [3] = {
            ["x"] = 608.3396070875,
            ["y"] = -224.36574189016,
          },
          [4] = {
            ["x"] = 619.22580631356,
            ["y"] = -235.8457072374,
          },
          [5] = {
            ["x"] = 635.39202518564,
            ["y"] = -244.72698778808,
          },
          [6] = {
            ["x"] = 645.35266237101,
            ["y"] = -250.8884561855,
          },
          [7] = {
            ["x"] = 660.39539433059,
            ["y"] = -265.93119663935,
          },
          [8] = {
            ["x"] = 677.41744296242,
            ["y"] = -284.9325449549,
          },
          [9] = {
            ["x"] = 688.69947494358,
            ["y"] = -298.58976883473,
          },
          [10] = {
            ["x"] = 677.41744296242,
            ["y"] = -284.9325449549,
          },
          [11] = {
            ["x"] = 660.39539433059,
            ["y"] = -265.93119663935,
          },
          [12] = {
            ["x"] = 645.35266237101,
            ["y"] = -250.8884561855,
          },
        },
      },
      [3] = {
        ["x"] = 523.94297578411,
        ["y"] = -469.93737006668,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 399.31380696806,
        ["y"] = -372.88533261401,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 593.55902439024,
        ["y"] = -258.86012195122,
        ["g"] = 34,
        ["sublevel"] = 2,
      },
      [6] = {
        ["x"] = 269.01386199891,
        ["y"] = -130.99565683313,
        ["g"] = 40,
        ["sublevel"] = 2,
      },
    },
  },
  [13] = {
    ["name"] = "Grand Overseer",
    ["id"] = 162040,
    ["count"] = 7,
    ["health"] = 231557,
    ["scale"] = 1,
    ["displayId"] = 96679,
    ["creatureType"] = "Humanoid",
    ["level"] = 60,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [326825] = {
      },
      [326827] = {
      },
      [326837] = {
        ["interruptible"] = true,
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 566.50322580645,
        ["y"] = -194.63193548387,
        ["g"] = 11,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 599.57182718962,
        ["y"] = -219.1653699663,
        ["g"] = 12,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 657.78861144678,
        ["y"] = -248.34569757875,
        ["g"] = 14,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 676.4418554317,
        ["y"] = -289.09235104811,
        ["g"] = 15,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 708.57974443732,
        ["y"] = -277.61437824156,
        ["g"] = 17,
        ["sublevel"] = 1,
      },
      [6] = {
        ["x"] = 582.25608375374,
        ["y"] = -268.83248993962,
        ["g"] = 18,
        ["sublevel"] = 1,
      },
      [7] = {
        ["x"] = 579.87317073171,
        ["y"] = -248.45048780488,
        ["g"] = 34,
        ["sublevel"] = 2,
      },
    },
  },
  [14] = {
    ["name"] = "Ravenous Dreadbat",
    ["id"] = 168591,
    ["count"] = 4,
    ["health"] = 165398,
    ["scale"] = 1,
    ["displayId"] = 92704,
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
      [321105] = {
        ["interruptible"] = true,
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 653.13241913452,
        ["y"] = -294.24451242247,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 550.35699603683,
        ["y"] = -227.32349868976,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 247.16676568177,
        ["y"] = -183.08426815917,
        ["sublevel"] = 2,
      },
      [4] = {
        ["x"] = 321.9087677498,
        ["y"] = -148.28690130936,
        ["sublevel"] = 2,
      },
      [5] = {
        ["x"] = 399.85253855988,
        ["y"] = -130.82753510801,
        ["sublevel"] = 2,
      },
    },
  },
  [15] = {
    ["name"] = "Head Custodian Javlin",
    ["id"] = 171376,
    ["count"] = 10,
    ["health"] = 396955,
    ["scale"] = 1.5,
    ["displayId"] = 97620,
    ["creatureType"] = "Humanoid",
    ["level"] = 60,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [334324] = {
      },
      [334326] = {
      },
      [334329] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 560.09963564731,
        ["y"] = -302.60890770987,
        ["g"] = 19,
        ["sublevel"] = 1,
      },
    },
  },
  [16] = {
    ["name"] = "Research Scribe",
    ["id"] = 171384,
    ["count"] = 4,
    ["health"] = 165398,
    ["scale"] = 1,
    ["displayId"] = 97622,
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
      [334377] = {
      },
      [334534] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 508.62451612903,
        ["y"] = -345.1523078344,
        ["g"] = 20,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 516.23002497136,
        ["y"] = -353.0416647131,
        ["g"] = 20,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 546.13849462366,
        ["y"] = -370.37,
        ["g"] = 21,
        ["sublevel"] = 1,
        ["inspiring"] = true,
      },
      [4] = {
        ["x"] = 551.35088383498,
        ["y"] = -439.80466221155,
        ["g"] = 22,
        ["sublevel"] = 1,
        ["patrol"] = {
        },
      },
      [5] = {
        ["x"] = 539.848709413,
        ["y"] = -488.82433360373,
        ["g"] = 23,
        ["sublevel"] = 1,
        ["inspiring"] = true,
      },
      [6] = {
        ["x"] = 486.13769845489,
        ["y"] = -493.22667726623,
        ["g"] = 24,
        ["sublevel"] = 1,
      },
      [7] = {
        ["x"] = 356.24430107527,
        ["y"] = -452.80838709677,
        ["g"] = 26,
        ["sublevel"] = 1,
      },
      [8] = {
        ["x"] = 366.46008557463,
        ["y"] = -407.84292517806,
        ["g"] = 27,
        ["sublevel"] = 1,
        ["inspiring"] = true,
      },
      [9] = {
        ["x"] = 376.20286689116,
        ["y"] = -381.41787542444,
        ["g"] = 28,
        ["sublevel"] = 1,
        ["patrol"] = {
        },
      },
      [10] = {
        ["x"] = 412.09724579678,
        ["y"] = -357.42221533285,
        ["g"] = 29,
        ["sublevel"] = 1,
      },
      [11] = {
        ["x"] = 416.96554708136,
        ["y"] = -349.91286111212,
        ["g"] = 29,
        ["sublevel"] = 1,
      },
      [12] = {
        ["x"] = 434.4530375788,
        ["y"] = -326.39617358631,
        ["g"] = 30,
        ["sublevel"] = 1,
        ["inspiring"] = true,
      },
    },
  },
  [17] = {
    ["name"] = "Depths Warden",
    ["id"] = 171799,
    ["count"] = 7,
    ["health"] = 264636,
    ["scale"] = 1,
    ["displayId"] = 97780,
    ["creatureType"] = "Humanoid",
    ["level"] = 60,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [335306] = {
      },
      [335308] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 508.06472200854,
        ["y"] = -353.43057432718,
        ["g"] = 20,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 487.89606602723,
        ["y"] = -499.22801010806,
        ["g"] = 24,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 418.89578402424,
        ["y"] = -355.6558710724,
        ["g"] = 29,
        ["sublevel"] = 1,
      },
    },
  },
  [18] = {
    ["name"] = "Infused Quill-feather",
    ["id"] = 168058,
    ["count"] = 1,
    ["health"] = 33079,
    ["scale"] = 1,
    ["displayId"] = 96655,
    ["creatureType"] = "Not specified",
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
      [326952] = {
        ["interruptible"] = true,
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 540.58272096195,
        ["y"] = -364.07405714728,
        ["g"] = 21,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 538.88821561174,
        ["y"] = -481.39042949054,
        ["g"] = 23,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 368.68475245393,
        ["y"] = -419.03252574875,
        ["g"] = 27,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 442.02539579284,
        ["y"] = -326.92589481546,
        ["g"] = 30,
        ["sublevel"] = 1,
      },
    },
  },
  [19] = {
    ["name"] = "Remnant of Fury",
    ["id"] = 172265,
    ["count"] = 4,
    ["health"] = 148858,
    ["scale"] = 1,
    ["displayId"] = 97240,
    ["creatureType"] = "Aberration",
    ["level"] = 60,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Incapacitate"] = true,
      ["Silence"] = true,
      ["Mind Control"] = true,
      ["Polymorph"] = true,
      ["Root"] = true,
      ["Fear"] = true,
      ["Banish"] = true,
      ["Disorient"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
    },
    ["spells"] = {
      [336277] = {
        ["interruptible"] = true,
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 547.41988721027,
        ["y"] = -378.06050350162,
        ["g"] = 21,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 546.11529634427,
        ["y"] = -447.49309262393,
        ["g"] = 22,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 494.48849450265,
        ["y"] = -493.87908536866,
        ["g"] = 24,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 383.64494245576,
        ["y"] = -379.48470739852,
        ["g"] = 28,
        ["sublevel"] = 1,
      },
    },
  },
  [20] = {
    ["name"] = "Vestige of Doubt",
    ["id"] = 162049,
    ["count"] = 4,
    ["health"] = 148858,
    ["scale"] = 1,
    ["displayId"] = 94279,
    ["creatureType"] = "Aberration",
    ["level"] = 60,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Incapacitate"] = true,
      ["Silence"] = true,
      ["Mind Control"] = true,
      ["Polymorph"] = true,
      ["Root"] = true,
      ["Fear"] = true,
      ["Banish"] = true,
      ["Disorient"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
    },
    ["spells"] = {
    },
    ["clones"] = {
      [1] = {
        ["x"] = 574.24688172043,
        ["y"] = -405.19774193548,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 553.80551802087,
        ["y"] = -449.09641678301,
        ["g"] = 22,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 546.54339793312,
        ["y"] = -493.40205353861,
        ["g"] = 23,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 376.70153346541,
        ["y"] = -372.46176834443,
        ["g"] = 28,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 439.72172957295,
        ["y"] = -318.95114215554,
        ["g"] = 30,
        ["sublevel"] = 1,
      },
      [6] = {
        ["x"] = 430.68097560976,
        ["y"] = -364.02585365854,
        ["g"] = 31,
        ["sublevel"] = 2,
      },
    },
  },
  [21] = {
    ["name"] = "Frenzied Ghoul",
    ["id"] = 162051,
    ["count"] = 2,
    ["health"] = 165398,
    ["scale"] = 1,
    ["displayId"] = 93808,
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
      [321220] = {
      },
      [321249] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 461.23234375885,
        ["y"] = -532.52767744027,
        ["g"] = 25,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 469.85225816087,
        ["y"] = -532.05987082507,
        ["g"] = 25,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 465.83152648733,
        ["y"] = -539.83885961076,
        ["g"] = 25,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 355.31739760858,
        ["y"] = -461.86473077081,
        ["g"] = 26,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 356.77421611862,
        ["y"] = -412.47461375711,
        ["g"] = 27,
        ["sublevel"] = 1,
      },
      [6] = {
        ["x"] = 349.39932419205,
        ["y"] = -412.86123845295,
        ["g"] = 27,
        ["sublevel"] = 1,
      },
      [7] = {
        ["x"] = 348.50523837654,
        ["y"] = -420.06007505784,
        ["g"] = 27,
        ["sublevel"] = 1,
      },
      [8] = {
        ["x"] = 357.30410859174,
        ["y"] = -419.38711931286,
        ["g"] = 27,
        ["sublevel"] = 1,
      },
    },
  },
  [22] = {
    ["name"] = "Executor Tarvold",
    ["id"] = 162103,
    ["count"] = 0,
    ["health"] = 925092,
    ["scale"] = 1,
    ["displayId"] = 96156,
    ["creatureType"] = "Humanoid",
    ["level"] = 60,
    ["isBoss"] = true,
    ["encounterID"] = 2415,
    ["instanceID"] = 1189,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [322554] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 412.81032258065,
        ["y"] = -473.76709677419,
        ["sublevel"] = 1,
      },
    },
  },
  [23] = {
    ["name"] = "Grand Proctor Beryllia",
    ["id"] = 162102,
    ["count"] = 0,
    ["health"] = 1156365,
    ["scale"] = 1,
    ["displayId"] = 94781,
    ["creatureType"] = "Humanoid",
    ["level"] = 60,
    ["isBoss"] = true,
    ["encounterID"] = 2421,
    ["instanceID"] = 1189,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [325254] = {
      },
      [325360] = {
      },
      [326039] = {
      },
      [328593] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 466.7784366519,
        ["y"] = -395.96027552815,
        ["sublevel"] = 2,
      },
    },
  },
  [24] = {
    ["name"] = "Stonewall Gargon",
    ["id"] = 171455,
    ["count"] = 1,
    ["health"] = 33079,
    ["scale"] = 1,
    ["displayId"] = 95372,
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
    },
    ["clones"] = {
      [1] = {
        ["x"] = 566.35626354362,
        ["y"] = -296.01818618259,
        ["g"] = 33,
        ["sublevel"] = 2,
      },
      [2] = {
        ["x"] = 559.15609372779,
        ["y"] = -290.91300283248,
        ["g"] = 33,
        ["sublevel"] = 2,
      },
      [3] = {
        ["x"] = 168.93786207825,
        ["y"] = -124.90544764779,
        ["g"] = 41,
        ["sublevel"] = 2,
      },
      [4] = {
        ["x"] = 159.14063172356,
        ["y"] = -128.71759893078,
        ["g"] = 41,
        ["sublevel"] = 2,
      },
      [5] = {
        ["x"] = 177.00538261375,
        ["y"] = -128.11634028207,
        ["g"] = 41,
        ["sublevel"] = 2,
      },
      [6] = {
        ["x"] = 171.01848317371,
        ["y"] = -143.56944821649,
        ["g"] = 41,
        ["sublevel"] = 2,
      },
      [7] = {
        ["x"] = 181.84459718417,
        ["y"] = -140.449997547,
        ["g"] = 41,
        ["sublevel"] = 2,
      },
      [8] = {
        ["x"] = 160.76095608169,
        ["y"] = -148.99096711876,
        ["g"] = 41,
        ["sublevel"] = 2,
      },
    },
  },
  [25] = {
    ["name"] = "General Kaal",
    ["id"] = 162099,
    ["count"] = 0,
    ["health"] = 6607800,
    ["scale"] = 1,
    ["displayId"] = 95721,
    ["creatureType"] = "Humanoid",
    ["level"] = 60,
    ["isBoss"] = true,
    ["encounterID"] = 2407,
    ["instanceID"] = 1189,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [322903] = {
      },
      [323821] = {
      },
      [323845] = {
      },
      [331415] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 132.82708265662,
        ["y"] = -103.24852572312,
        ["sublevel"] = 2,
      },
    },
  },
  [26] = {
    ["name"] = "Sanguine Cadet",
    ["id"] = 167955,
    ["count"] = 1,
    ["health"] = 66159,
    ["scale"] = 1,
    ["displayId"] = 94954,
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
      [326718] = {
      },
      [334753] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 578.86243902439,
        ["y"] = -124.04926829268,
        ["g"] = 36,
        ["sublevel"] = 2,
      },
      [2] = {
        ["x"] = 580.61073170732,
        ["y"] = -116.30634146341,
        ["g"] = 36,
        ["sublevel"] = 2,
      },
      [3] = {
        ["x"] = 567.34829268293,
        ["y"] = -124.53658536585,
        ["g"] = 36,
        ["sublevel"] = 2,
      },
      [4] = {
        ["x"] = 572.31993740536,
        ["y"] = -109.87335859603,
        ["g"] = 36,
        ["sublevel"] = 2,
      },
      [5] = {
        ["x"] = 565.68195121951,
        ["y"] = -119.29792682927,
        ["g"] = 36,
        ["sublevel"] = 2,
      },
      [6] = {
        ["x"] = 567.40292682927,
        ["y"] = -114.12695121951,
        ["g"] = 36,
        ["sublevel"] = 2,
      },
      [7] = {
        ["x"] = 499.48812835712,
        ["y"] = -92.45487804878,
        ["g"] = 37,
        ["sublevel"] = 2,
      },
      [8] = {
        ["x"] = 495.83685936334,
        ["y"] = -97.480575872507,
        ["g"] = 37,
        ["sublevel"] = 2,
      },
      [9] = {
        ["x"] = 498.17703920675,
        ["y"] = -104.5717131816,
        ["g"] = 37,
        ["sublevel"] = 2,
      },
    },
  },
  [27] = {
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
        ["x"] = 261.55314132983,
        ["y"] = -123.52463227332,
        ["sublevel"] = 1,
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
        ["x"] = 565.21027105794,
        ["y"] = -317.85326900582,
        ["sublevel"] = 1,
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
        ["x"] = 472.8031121598,
        ["y"] = -174.23889036438,
        ["sublevel"] = 1,
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
        ["x"] = 461.52975816474,
        ["y"] = -348.58257308629,
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
  [29] = {
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
        ["x"] = 461.52975816474,
        ["y"] = -348.58257308629,
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
        ["x"] = 472.8031121598,
        ["y"] = -174.23889036438,
        ["sublevel"] = 1,
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
  [30] = {
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
        ["x"] = 565.21027105794,
        ["y"] = -317.85326900582,
        ["sublevel"] = 1,
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
        ["x"] = 261.55314132983,
        ["y"] = -123.52463227332,
        ["sublevel"] = 1,
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
  [31] = {
    ["name"] = "Chamber Sentinel",
    ["id"] = 168594,
    ["count"] = 7,
    ["health"] = 264636,
    ["scale"] = 1.4,
    ["displayId"] = 94737,
    ["creatureType"] = "Humanoid",
    ["level"] = 60,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [322429] = {
      },
      [322433] = {
        ["interruptible"] = true,
      },
      [328170] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 276.01386199891,
        ["y"] = -165.99565683313,
        ["sublevel"] = 2,
      },
    },
  },
  [32] = {
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
    },
    ["clones"] = {
      [1] = {
        ["x"] = 245.59048417143,
        ["y"] = -209.6495515548,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 268.75228185486,
        ["y"] = -112.837560446,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 352.65961883566,
        ["y"] = -89.637597539462,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 488.75936454488,
        ["y"] = -100.73519636434,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 544.78913925628,
        ["y"] = -297.63921218006,
        ["sublevel"] = 1,
      },
      [6] = {
        ["x"] = 414.71404746208,
        ["y"] = -453.99238134498,
        ["sublevel"] = 1,
      },
      [7] = {
        ["x"] = 418.74229386808,
        ["y"] = -366.58761224426,
        ["sublevel"] = 1,
      },
      [8] = {
        ["x"] = 480.4087553763,
        ["y"] = -382.03456758363,
        ["sublevel"] = 2,
      },
      [9] = {
        ["x"] = 555.04132809394,
        ["y"] = -112.23110217587,
        ["sublevel"] = 2,
      },
      [10] = {
        ["x"] = 326.59976019189,
        ["y"] = -111.34670280479,
        ["sublevel"] = 2,
      },
      [11] = {
        ["x"] = 120.95298773079,
        ["y"] = -86.461569188401,
        ["sublevel"] = 2,
      },
    },
  },
  [33] = {
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
        ["x"] = 254.4012527363,
        ["y"] = -218.07114123981,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 279.25231575407,
        ["y"] = -113.46254739235,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 349.90966768866,
        ["y"] = -100.88759860816,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 490.00933843758,
        ["y"] = -87.485179131615,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 548.46262249676,
        ["y"] = -310.49633345588,
        ["sublevel"] = 1,
      },
      [6] = {
        ["x"] = 426.74101501991,
        ["y"] = -461.15456973566,
        ["sublevel"] = 1,
      },
      [7] = {
        ["x"] = 430.22878324605,
        ["y"] = -358.88489927876,
        ["sublevel"] = 1,
      },
      [8] = {
        ["x"] = 465.27361913514,
        ["y"] = -377.84103004586,
        ["sublevel"] = 2,
      },
      [9] = {
        ["x"] = 555.52515734929,
        ["y"] = -125.47624998,
        ["sublevel"] = 2,
      },
      [10] = {
        ["x"] = 332.99977682158,
        ["y"] = -122.34672924131,
        ["sublevel"] = 2,
      },
      [11] = {
        ["x"] = 118.30591876226,
        ["y"] = -114.40275317031,
        ["sublevel"] = 2,
      },
    },
  },
  [34] = {
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
    },
    ["clones"] = {
      [1] = {
        ["x"] = 243.73096378247,
        ["y"] = -197.33060690363,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 261.37727924692,
        ["y"] = -105.46253638039,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 348.53463847097,
        ["y"] = -77.762598795584,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 485.63439762662,
        ["y"] = -113.61018709699,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 562.85038514473,
        ["y"] = -317.53716465583,
        ["sublevel"] = 1,
      },
      [6] = {
        ["x"] = 429.1735031928,
        ["y"] = -473.72209666454,
        ["sublevel"] = 1,
      },
      [7] = {
        ["x"] = 428.87743701276,
        ["y"] = -347.80385552624,
        ["sublevel"] = 1,
      },
      [8] = {
        ["x"] = 484.71106871983,
        ["y"] = -396.5694663357,
        ["sublevel"] = 2,
      },
      [9] = {
        ["x"] = 563.20904742854,
        ["y"] = -101.32138651964,
        ["sublevel"] = 2,
      },
      [10] = {
        ["x"] = 324.19976253882,
        ["y"] = -98.9467263747,
        ["sublevel"] = 2,
      },
      [11] = {
        ["x"] = 148.30596642078,
        ["y"] = -89.255698946536,
        ["sublevel"] = 2,
      },
    },
  },
};
