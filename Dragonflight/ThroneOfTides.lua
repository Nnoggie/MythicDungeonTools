local addonName = ...
local MDT = MDT
local L = MDT.L
local dungeonIndex = 105
MDT.dungeonList[dungeonIndex] = L["Throne of Tides"]
MDT.mapInfo[dungeonIndex] = {

};

local zones = { 322, 323 }
for _, zone in ipairs(zones) do
  MDT.zoneIdToDungeonIdx[zone] = dungeonIndex
end

MDT.dungeonMaps[dungeonIndex] = {
  [0] = "",
  [1] = { customTextures = 'ThroneOfTides' },
}

MDT.dungeonSubLevels[dungeonIndex] = {
  [1] = L["Throne of Tides"],
}

MDT.dungeonTotalCount[dungeonIndex] = { normal = 430, teeming = 1000, teemingEnabled = true }

MDT.mapPOIs[dungeonIndex] = {};

MDT.dungeonEnemies[dungeonIndex] = {
  [1] = {
    ["name"] = "Naz'jar Invader",
    ["id"] = 39616,
    ["count"] = 4,
    ["health"] = 1184900,
    ["scale"] = 1,
    ["displayId"] = 37370,
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
      [76807] = {
      },
      [426618] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 175.09900342309,
        ["y"] = -424.9170161796,
        ["g"] = 1,
        ["sublevel"] = 1,
        ["scale"] = 1.2,
      },
      [2] = {
        ["x"] = 180.57176495369,
        ["y"] = -435.37501591753,
        ["g"] = 1,
        ["sublevel"] = 1,
        ["scale"] = 1.2,
      },
      [3] = {
        ["x"] = 208.90605415453,
        ["y"] = -413.93508645284,
        ["g"] = 2,
        ["sublevel"] = 1,
        ["scale"] = 1.2,
        ["patrol"] = {
          [1] = {
            ["x"] = 208.44874944845,
            ["y"] = -415.07834821805,
          },
          [2] = {
            ["x"] = 198.485959362,
            ["y"] = -420.21173789224,
          },
          [3] = {
            ["x"] = 185.90989677162,
            ["y"] = -426.3854691785,
          },
          [4] = {
            ["x"] = 198.485959362,
            ["y"] = -420.21173789224,
          },
          [5] = {
            ["x"] = 208.44874944845,
            ["y"] = -415.07834821805,
          },
          [6] = {
            ["x"] = 224.32406776946,
            ["y"] = -405.57777795691,
          },
          [7] = {
            ["x"] = 230.04045509825,
            ["y"] = -401.4619701832,
          },
          [8] = {
            ["x"] = 224.32406776946,
            ["y"] = -405.57777795691,
          },
        },
      },
      [4] = {
        ["x"] = 242.29920868424,
        ["y"] = -383.88411746317,
        ["g"] = 3,
        ["sublevel"] = 1,
        ["scale"] = 1.2,
      },
      [5] = {
        ["x"] = 250.52780870211,
        ["y"] = -393.71632564947,
        ["g"] = 3,
        ["sublevel"] = 1,
        ["scale"] = 1.2,
      },
      [6] = {
        ["x"] = 416.86351539045,
        ["y"] = -279.10311601508,
        ["g"] = 6,
        ["sublevel"] = 1,
        ["scale"] = 1.2,
      },
      [7] = {
        ["x"] = 422.66842350228,
        ["y"] = -288.57862027309,
        ["g"] = 6,
        ["sublevel"] = 1,
        ["scale"] = 1.2,
      },
      [8] = {
        ["x"] = 527.57237035928,
        ["y"] = -216.18867610245,
        ["g"] = 11,
        ["sublevel"] = 1,
        ["scale"] = 1.2,
      },
      [9] = {
        ["x"] = 562.2294615296,
        ["y"] = -196.7297462473,
        ["g"] = 12,
        ["sublevel"] = 1,
        ["scale"] = 1.2,
      },
      [10] = {
        ["x"] = 608.38817927785,
        ["y"] = -159.84289476676,
        ["g"] = 17,
        ["sublevel"] = 1,
        ["scale"] = 1.2,
      },
      [11] = {
        ["x"] = 618.45953451039,
        ["y"] = -176.41371969511,
        ["g"] = 17,
        ["sublevel"] = 1,
        ["scale"] = 1.2,
      },
    },
  },
  [2] = {
    ["name"] = "Vicious Snap Dragon",
    ["id"] = 212681,
    ["count"] = 4,
    ["health"] = 740563,
    ["scale"] = 1,
    ["displayId"] = 103357,
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
      [426659] = {
      },
      [426660] = {
      },
      [426662] = {
      },
      [426663] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 212.20716894839,
        ["y"] = -404.48524359736,
        ["g"] = 2,
        ["sublevel"] = 1,
        ["scale"] = 0.7,
      },
      [2] = {
        ["x"] = 218.71608768726,
        ["y"] = -408.93731696112,
        ["g"] = 2,
        ["sublevel"] = 1,
        ["scale"] = 0.7,
      },
      [3] = {
        ["x"] = 217.58330519049,
        ["y"] = -416.3253642777,
        ["g"] = 2,
        ["sublevel"] = 1,
        ["scale"] = 0.7,
      },
      [4] = {
        ["x"] = 311.58972879088,
        ["y"] = -338.22447203046,
        ["g"] = 5,
        ["sublevel"] = 1,
        ["scale"] = 0.7,
      },
      [5] = {
        ["x"] = 316.87782371277,
        ["y"] = -347.87524178549,
        ["g"] = 5,
        ["sublevel"] = 1,
        ["scale"] = 0.7,
      },
      [6] = {
        ["x"] = 553.06634815882,
        ["y"] = -199.03134537722,
        ["g"] = 12,
        ["sublevel"] = 1,
        ["scale"] = 0.7,
      },
      [7] = {
        ["x"] = 556.97035093767,
        ["y"] = -206.3312729328,
        ["g"] = 12,
        ["sublevel"] = 1,
        ["scale"] = 0.7,
      },
      [8] = {
        ["x"] = 594.8953710538,
        ["y"] = -188.89177227372,
        ["g"] = 16,
        ["sublevel"] = 1,
        ["scale"] = 0.7,
      },
      [9] = {
        ["x"] = 586.48601775152,
        ["y"] = -191.75677652733,
        ["g"] = 16,
        ["sublevel"] = 1,
        ["scale"] = 0.7,
      },
      [10] = {
        ["x"] = 589.03860076826,
        ["y"] = -186.13457234874,
        ["g"] = 16,
        ["sublevel"] = 1,
        ["scale"] = 0.7,
      },
      [11] = {
        ["x"] = 583.49411555836,
        ["y"] = -185.05849733932,
        ["g"] = 16,
        ["sublevel"] = 1,
        ["scale"] = 0.7,
      },
      [12] = {
        ["x"] = 592.62399569397,
        ["y"] = -181.89768084996,
        ["g"] = 16,
        ["sublevel"] = 1,
        ["scale"] = 0.7,
      },
      [13] = {
        ["x"] = 585.23673218036,
        ["y"] = -179.23449411416,
        ["g"] = 16,
        ["sublevel"] = 1,
        ["scale"] = 0.7,
        ["patrol"] = {
          [1] = {
            ["x"] = 592.04260398329,
            ["y"] = -194.17783532092,
          },
          [2] = {
            ["x"] = 591.86871290918,
            ["y"] = -186.26487302837,
          },
          [3] = {
            ["x"] = 587.10450025179,
            ["y"] = -179.13339028149,
          },
          [4] = {
            ["x"] = 579.8844530249,
            ["y"] = -173.83675009912,
          },
          [5] = {
            ["x"] = 570.41541988411,
            ["y"] = -171.32153182161,
          },
          [6] = {
            ["x"] = 562.24825439329,
            ["y"] = -169.07251717146,
          },
          [7] = {
            ["x"] = 551.62527126493,
            ["y"] = -165.84724068761,
          },
          [8] = {
            ["x"] = 562.24825439329,
            ["y"] = -169.07251717146,
          },
          [9] = {
            ["x"] = 570.41541988411,
            ["y"] = -171.32153182161,
          },
          [10] = {
            ["x"] = 579.85475407945,
            ["y"] = -173.59516511273,
          },
          [11] = {
            ["x"] = 587.10450025179,
            ["y"] = -179.13339028149,
          },
          [12] = {
            ["x"] = 591.86871290918,
            ["y"] = -186.26487302837,
          },
          [13] = {
            ["x"] = 592.04260398329,
            ["y"] = -194.17783532092,
          },
          [14] = {
            ["x"] = 590.09327766126,
            ["y"] = -209.19769824869,
          },
          [15] = {
            ["x"] = 589.20555157132,
            ["y"] = -218.22288527648,
          },
          [16] = {
            ["x"] = 589.79734074467,
            ["y"] = -221.18195813297,
          },
          [17] = {
            ["x"] = 589.79734074467,
            ["y"] = -221.18195813297,
          },
          [18] = {
            ["x"] = 589.20555157132,
            ["y"] = -218.22288527648,
          },
          [19] = {
            ["x"] = 590.09327766126,
            ["y"] = -209.19769824869,
          },
        },
      },
    },
  },
  [3] = {
    ["name"] = "Naz'jar Oracle",
    ["id"] = 41096,
    ["count"] = 5,
    ["health"] = 1333013,
    ["scale"] = 1,
    ["displayId"] = 37387,
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
      [76813] = {
      },
      [76820] = {
      },
      [426731] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 241.14994202753,
        ["y"] = -393.94491258355,
        ["g"] = 3,
        ["sublevel"] = 1,
        ["scale"] = 1.2,
      },
      [2] = {
        ["x"] = 283.64009800739,
        ["y"] = -355.43941152533,
        ["g"] = 4,
        ["sublevel"] = 1,
        ["scale"] = 1.2,
      },
      [3] = {
        ["x"] = 290.49688857736,
        ["y"] = -368.01553953467,
        ["g"] = 4,
        ["sublevel"] = 1,
        ["scale"] = 1.2,
      },
      [4] = {
        ["x"] = 450.63800325466,
        ["y"] = -272.92285550542,
        ["g"] = 7,
        ["sublevel"] = 1,
        ["scale"] = 1.2,
      },
      [5] = {
        ["x"] = 554.75534424885,
        ["y"] = -190.43843047342,
        ["g"] = 12,
        ["sublevel"] = 1,
        ["scale"] = 1.2,
      },
      [6] = {
        ["x"] = 548.20055198318,
        ["y"] = -161.02901265288,
        ["g"] = 14,
        ["sublevel"] = 1,
        ["scale"] = 1.2,
      },
      [7] = {
        ["x"] = 538.88996942319,
        ["y"] = -154.07521472157,
        ["g"] = 14,
        ["sublevel"] = 1,
        ["scale"] = 1.2,
      },
      [8] = {
        ["x"] = 626.01566299944,
        ["y"] = -183.07162303974,
        ["g"] = 17,
        ["sublevel"] = 1,
        ["scale"] = 1.2,
      },
      [9] = {
        ["x"] = 599.61157678343,
        ["y"] = -223.04030840885,
        ["g"] = 15,
        ["sublevel"] = 1,
        ["scale"] = 1.2,
      },
      [10] = {
        ["x"] = 599.47419203943,
        ["y"] = -235.46841017315,
        ["g"] = 15,
        ["sublevel"] = 1,
        ["scale"] = 1.2,
      },
    },
  },
  [4] = {
    ["name"] = "Naz'jar Sentinel",
    ["id"] = 40577,
    ["count"] = 10,
    ["health"] = 2369800,
    ["scale"] = 1,
    ["displayId"] = 32568,
    ["creatureType"] = "Humanoid",
    ["level"] = 71,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Mind Soothe"] = true,
    },
    ["spells"] = {
      [426741] = {
      },
      [428542] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 278.37519366627,
        ["y"] = -367.55823482859,
        ["g"] = 4,
        ["sublevel"] = 1,
        ["scale"] = 1.6,
      },
      [2] = {
        ["x"] = 609.30731787136,
        ["y"] = -170.64353397443,
        ["g"] = 17,
        ["sublevel"] = 1,
        ["scale"] = 1.6,
      },
      [3] = {
        ["x"] = 475.03628263067,
        ["y"] = -241.21240027509,
        ["g"] = 8,
        ["sublevel"] = 1,
        ["scale"] = 1.6,
      },
      [4] = {
        ["x"] = 482.79264921544,
        ["y"] = -253.89195101098,
        ["g"] = 8,
        ["sublevel"] = 1,
        ["scale"] = 1.6,
      },
    },
  },
  [5] = {
    ["name"] = "Naz'jar Ravager",
    ["id"] = 212673,
    ["count"] = 25,
    ["health"] = 4147150,
    ["scale"] = 1,
    ["displayId"] = 91794,
    ["creatureType"] = "Humanoid",
    ["level"] = 71,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Mind Soothe"] = true,
    },
    ["spells"] = {
      [426645] = {
      },
      [426684] = {
      },
      [426685] = {
      },
      [426688] = {
      },
      [426727] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 321.46203802422,
        ["y"] = -338.18447793435,
        ["g"] = 5,
        ["sublevel"] = 1,
        ["scale"] = 1.6,
      },
      [2] = {
        ["x"] = 556.88557015998,
        ["y"] = -175.3163678164,
        ["g"] = 13,
        ["sublevel"] = 1,
        ["scale"] = 1.6,
        ["patrol"] = {
          [1] = {
            ["x"] = 556.88557015998,
            ["y"] = -175.3163678164,
          },
          [2] = {
            ["x"] = 550.67825302891,
            ["y"] = -184.05846958468,
          },
          [3] = {
            ["x"] = 548.46485217733,
            ["y"] = -193.51564612585,
          },
          [4] = {
            ["x"] = 551.28189524617,
            ["y"] = -207.19841029775,
          },
          [5] = {
            ["x"] = 560.73914086975,
            ["y"] = -213.43616168017,
          },
          [6] = {
            ["x"] = 576.43402273839,
            ["y"] = -213.63735272512,
          },
          [7] = {
            ["x"] = 585.48879416218,
            ["y"] = -207.3996358839,
          },
          [8] = {
            ["x"] = 589.5131677205,
            ["y"] = -194.924179174,
          },
          [9] = {
            ["x"] = 590.51923808261,
            ["y"] = -184.05846958468,
          },
          [10] = {
            ["x"] = 579.85475407945,
            ["y"] = -173.59516511273,
          },
          [11] = {
            ["x"] = 566.17198990755,
            ["y"] = -170.97932460257,
          },
        },
      },
    },
  },
  [6] = {
    ["name"] = "Deep Murloc Drudge",
    ["id"] = 39960,
    ["count"] = 1,
    ["health"] = 444338,
    ["scale"] = 1,
    ["displayId"] = 32311,
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
      [427292] = {
      },
      [427293] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 495.42839036714,
        ["y"] = -220.08134274631,
        ["g"] = 9,
        ["sublevel"] = 1,
        ["scale"] = 0.7,
      },
      [2] = {
        ["x"] = 501.97452104199,
        ["y"] = -218.62737165458,
        ["g"] = 9,
        ["sublevel"] = 1,
        ["scale"] = 0.7,
      },
      [3] = {
        ["x"] = 492.25445225062,
        ["y"] = -225.39086572611,
        ["g"] = 9,
        ["sublevel"] = 1,
        ["scale"] = 0.7,
      },
      [4] = {
        ["x"] = 497.9955973848,
        ["y"] = -228.13653013759,
        ["g"] = 9,
        ["sublevel"] = 1,
        ["scale"] = 0.7,
      },
      [5] = {
        ["x"] = 502.96438615492,
        ["y"] = -224.35233127954,
        ["g"] = 9,
        ["sublevel"] = 1,
        ["scale"] = 0.7,
      },
      [6] = {
        ["x"] = 503.05923268907,
        ["y"] = -236.5834733803,
        ["g"] = 10,
        ["sublevel"] = 1,
        ["scale"] = 0.7,
      },
      [7] = {
        ["x"] = 508.14489257182,
        ["y"] = -232.88362361032,
        ["g"] = 10,
        ["sublevel"] = 1,
        ["scale"] = 0.7,
      },
      [8] = {
        ["x"] = 503.12411409455,
        ["y"] = -242.68492864544,
        ["g"] = 10,
        ["sublevel"] = 1,
        ["scale"] = 0.7,
      },
      [9] = {
        ["x"] = 510.59836119165,
        ["y"] = -239.85485757721,
        ["g"] = 10,
        ["sublevel"] = 1,
        ["scale"] = 0.7,
      },
      [10] = {
        ["x"] = 514.40531508455,
        ["y"] = -235.55143727227,
        ["g"] = 10,
        ["sublevel"] = 1,
        ["scale"] = 0.7,
      },
    },
  },
  [7] = {
    ["name"] = "Naz'jar Tempest Witch",
    ["id"] = 40634,
    ["count"] = 5,
    ["health"] = 1333013,
    ["scale"] = 1,
    ["displayId"] = 91648,
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
      [75992] = {
      },
      [426768] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 443.7796417691,
        ["y"] = -261.3937905309,
        ["g"] = 7,
        ["sublevel"] = 1,
        ["scale"] = 1.2,
      },
      [2] = {
        ["x"] = 530.12488539094,
        ["y"] = -205.76730750067,
        ["g"] = 11,
        ["sublevel"] = 1,
        ["scale"] = 1.2,
      },
      [3] = {
        ["x"] = 538.33366851804,
        ["y"] = -217.66207900578,
        ["g"] = 11,
        ["sublevel"] = 1,
        ["scale"] = 1.2,
      },
      [4] = {
        ["x"] = 564.94765648399,
        ["y"] = -207.14318147729,
        ["g"] = 12,
        ["sublevel"] = 1,
        ["scale"] = 1.2,
      },
      [5] = {
        ["x"] = 549.84899994977,
        ["y"] = -150.67225342215,
        ["g"] = 14,
        ["sublevel"] = 1,
        ["scale"] = 1.2,
      },
      [6] = {
        ["x"] = 606.35882026319,
        ["y"] = -150.07794164135,
        ["g"] = 17,
        ["sublevel"] = 1,
        ["scale"] = 1.2,
      },
      [7] = {
        ["x"] = 591.34718782614,
        ["y"] = -228.95844142287,
        ["g"] = 15,
        ["sublevel"] = 1,
        ["scale"] = 1.2,
      },
    },
  },
  [8] = {
    ["name"] = "Lady Naz'jar",
    ["id"] = 40586,
    ["count"] = 0,
    ["health"] = 8152336,
    ["scale"] = 1,
    ["displayId"] = 34342,
    ["creatureType"] = "Humanoid",
    ["level"] = 72,
    ["isBoss"] = true,
    ["encounterID"] = 101,
    ["instanceID"] = 65,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Mind Soothe"] = true,
    },
    ["spells"] = {
      [75683] = {
      },
      [427769] = {
      },
      [427771] = {
      },
      [428054] = {
      },
      [428263] = {
      },
      [428374] = {
      },
      [428376] = {
      },
      [429263] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 655.67252487776,
        ["y"] = -142.08800704578,
        ["g"] = 18,
        ["sublevel"] = 1,
        ["scale"] = 1.2,
      },
    },
  },
  [9] = {
    ["name"] = "Deep Sea Murloc",
    ["id"] = 213607,
    ["count"] = 0,
    ["health"] = 177735,
    ["scale"] = 1,
    ["displayId"] = 31539,
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
      [428096] = {
      },
      [428097] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 670.68912297758,
        ["y"] = -128.70430024018,
        ["g"] = 18,
        ["sublevel"] = 1,
        ["scale"] = 0.7,
      },
      [2] = {
        ["x"] = 667.0397965418,
        ["y"] = -122.87959157333,
        ["g"] = 18,
        ["sublevel"] = 1,
        ["scale"] = 0.7,
      },
      [3] = {
        ["x"] = 684.5710195539,
        ["y"] = -136.91177678592,
        ["g"] = 18,
        ["sublevel"] = 1,
        ["scale"] = 0.7,
      },
      [4] = {
        ["x"] = 676.9502719232,
        ["y"] = -132.67563053718,
        ["g"] = 18,
        ["sublevel"] = 1,
        ["scale"] = 0.7,
      },
      [5] = {
        ["x"] = 677.00745983266,
        ["y"] = -124.73290934457,
        ["g"] = 18,
        ["sublevel"] = 1,
        ["scale"] = 0.7,
      },
      [6] = {
        ["x"] = 682.8894170076,
        ["y"] = -130.55757256246,
        ["g"] = 18,
        ["sublevel"] = 1,
        ["scale"] = 0.7,
      },
      [7] = {
        ["x"] = 673.15056595321,
        ["y"] = -118.90818552806,
        ["g"] = 18,
        ["sublevel"] = 1,
        ["scale"] = 0.7,
      },
      [8] = {
        ["x"] = 676.91429850724,
        ["y"] = -137.70610344394,
        ["g"] = 18,
        ["sublevel"] = 1,
        ["scale"] = 0.7,
      },
    },
  },
  [10] = {
    ["name"] = "Naz'jar Frost Witch",
    ["id"] = 44404,
    ["count"] = 0,
    ["health"] = 740563,
    ["scale"] = 1,
    ["displayId"] = 37388,
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
      [428103] = {
      },
      [428329] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 651.28994446902,
        ["y"] = -110.9654491858,
        ["g"] = 18,
        ["sublevel"] = 1,
        ["scale"] = 1.2,
      },
      [2] = {
        ["x"] = 683.11828984269,
        ["y"] = -157.82779812548,
        ["g"] = 18,
        ["sublevel"] = 1,
        ["scale"] = 1.2,
      },
    },
  },
  [11] = {
    ["name"] = "Naz'jar Honor Guard",
    ["id"] = 40633,
    ["count"] = 0,
    ["health"] = 888675,
    ["scale"] = 1,
    ["displayId"] = 32348,
    ["creatureType"] = "Humanoid",
    ["level"] = 71,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Mind Soothe"] = true,
    },
    ["spells"] = {
      [428291] = {
      },
      [428293] = {
      },
      [428294] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 693.76596457126,
        ["y"] = -118.37868997145,
        ["g"] = 18,
        ["sublevel"] = 1,
        ["scale"] = 1.6,
      },
    },
  },
  [12] = {
    ["name"] = "Commander Ulthok",
    ["id"] = 40765,
    ["count"] = 0,
    ["health"] = 10375700,
    ["scale"] = 1,
    ["displayId"] = 33792,
    ["creatureType"] = "Aberration",
    ["level"] = 72,
    ["isBoss"] = true,
    ["encounterID"] = 102,
    ["instanceID"] = 65,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [427456] = {
      },
      [427554] = {
      },
      [427565] = {
      },
      [427668] = {
      },
      [427670] = {
      },
      [427672] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 504.29397154325,
        ["y"] = -172.33824401465,
        ["g"] = 19,
        ["sublevel"] = 1,
        ["scale"] = 1.2,
      },
    },
  },
  [13] = {
    ["name"] = "Bubbling Ooze",
    ["id"] = 213219,
    ["count"] = 0,
    ["health"] = 14811250,
    ["scale"] = 1,
    ["displayId"] = 33012,
    ["creatureType"] = "Aberration",
    ["level"] = 71,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [427451] = {
      },
      [427559] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 516.58067453383,
        ["y"] = -163.07887003691,
        ["g"] = 19,
        ["sublevel"] = 1,
        ["scale"] = 1.2,
      },
      [2] = {
        ["x"] = 517.97821553526,
        ["y"] = -175.34058600934,
        ["g"] = 19,
        ["sublevel"] = 1,
        ["scale"] = 1.2,
      },
      [3] = {
        ["x"] = 508.37198482807,
        ["y"] = -156.16199262309,
        ["g"] = 19,
        ["sublevel"] = 1,
        ["scale"] = 1.2,
      },
    },
  },
  [14] = {
    ["name"] = "Faceless Watcher",
    ["id"] = 40936,
    ["count"] = 8,
    ["health"] = 2369800,
    ["scale"] = 1,
    ["stealthDetect"] = true,
    ["displayId"] = 31674,
    ["creatureType"] = "Aberration",
    ["level"] = 71,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [76590] = {
      },
      [428926] = {
      },
      [429021] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 334.65324667062,
        ["y"] = -369.77078475891,
        ["g"] = 20,
        ["sublevel"] = 1,
        ["scale"] = 1.6,
      },
      [2] = {
        ["x"] = 374.14214514388,
        ["y"] = -430.75941072961,
        ["g"] = 22,
        ["sublevel"] = 1,
        ["scale"] = 1.6,
        ["patrol"] = {
          [1] = {
            ["x"] = 374.14214514388,
            ["y"] = -430.75941072961,
          },
          [2] = {
            ["x"] = 364.19123048171,
            ["y"] = -419.98461911035,
          },
          [3] = {
            ["x"] = 358.24616463229,
            ["y"] = -410.83838106698,
          },
          [4] = {
            ["x"] = 364.19123048171,
            ["y"] = -419.98461911035,
          },
          [5] = {
            ["x"] = 374.14214514388,
            ["y"] = -430.75941072961,
          },
          [6] = {
            ["x"] = 384.99888245192,
            ["y"] = -438.50573446636,
          },
          [7] = {
            ["x"] = 393.687828873,
            ["y"] = -440.79227108056,
          },
          [8] = {
            ["x"] = 399.17559001634,
            ["y"] = -441.24958887044,
          },
          [9] = {
            ["x"] = 393.687828873,
            ["y"] = -440.79227108056,
          },
          [10] = {
            ["x"] = 384.99888245192,
            ["y"] = -438.50573446636,
          },
        },
      },
      [3] = {
        ["x"] = 454.88191315659,
        ["y"] = -421.55455892507,
        ["g"] = 25,
        ["sublevel"] = 1,
        ["scale"] = 1.6,
      },
      [4] = {
        ["x"] = 463.91756313014,
        ["y"] = -432.32827632876,
        ["g"] = 25,
        ["sublevel"] = 1,
        ["scale"] = 1.6,
      },
    },
  },
  [15] = {
    ["name"] = "Minion of Ghur'sha",
    ["id"] = 212778,
    ["count"] = 3,
    ["health"] = 888675,
    ["scale"] = 1,
    ["displayId"] = 31994,
    ["creatureType"] = "Aberration",
    ["level"] = 70,
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
      [426905] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 358.36487503332,
        ["y"] = -394.54016856171,
        ["g"] = 21,
        ["sublevel"] = 1,
        ["scale"] = 0.7,
      },
      [2] = {
        ["x"] = 358.1332594859,
        ["y"] = -400.94251294963,
        ["g"] = 21,
        ["sublevel"] = 1,
        ["scale"] = 0.7,
      },
      [3] = {
        ["x"] = 352.87126600398,
        ["y"] = -403.91512437709,
        ["g"] = 21,
        ["sublevel"] = 1,
        ["scale"] = 0.7,
      },
      [4] = {
        ["x"] = 345.55127050677,
        ["y"] = -404.37241599938,
        ["g"] = 21,
        ["sublevel"] = 1,
        ["scale"] = 0.7,
      },
      [5] = {
        ["x"] = 413.8690479742,
        ["y"] = -447.55373146142,
        ["g"] = 23,
        ["sublevel"] = 1,
        ["scale"] = 0.7,
      },
      [6] = {
        ["x"] = 411.22980823933,
        ["y"] = -436.22855910333,
        ["g"] = 23,
        ["sublevel"] = 1,
        ["scale"] = 0.7,
      },
      [7] = {
        ["x"] = 414.5356391641,
        ["y"] = -441.85079233563,
        ["g"] = 23,
        ["sublevel"] = 1,
        ["scale"] = 0.7,
      },
      [8] = {
        ["x"] = 479.74233074356,
        ["y"] = -405.85850918557,
        ["g"] = 26,
        ["sublevel"] = 1,
        ["scale"] = 0.9,
      },
      [9] = {
        ["x"] = 486.70668699123,
        ["y"] = -403.04742171933,
        ["g"] = 26,
        ["sublevel"] = 1,
        ["scale"] = 0.9,
      },
      [10] = {
        ["x"] = 480.9469579951,
        ["y"] = -414.43985856633,
        ["g"] = 26,
        ["sublevel"] = 1,
        ["scale"] = 0.9,
      },
      [11] = {
        ["x"] = 487.61541119011,
        ["y"] = -408.66965591368,
        ["g"] = 26,
        ["sublevel"] = 1,
        ["scale"] = 0.9,
      },
      [12] = {
        ["x"] = 487.47794178628,
        ["y"] = -418.13867212251,
        ["g"] = 26,
        ["sublevel"] = 1,
        ["scale"] = 0.9,
      },
      [13] = {
        ["x"] = 493.99847731889,
        ["y"] = -413.55210707844,
        ["g"] = 26,
        ["sublevel"] = 1,
        ["scale"] = 0.9,
      },
      [14] = {
        ["x"] = 524.48404640675,
        ["y"] = -366.06279767607,
        ["g"] = 28,
        ["sublevel"] = 1,
        ["scale"] = 0.9,
      },
      [15] = {
        ["x"] = 531.41659353763,
        ["y"] = -360.40886986515,
        ["g"] = 28,
        ["sublevel"] = 1,
        ["scale"] = 0.9,
      },
      [16] = {
        ["x"] = 532.00836457899,
        ["y"] = -367.74317205499,
        ["g"] = 28,
        ["sublevel"] = 1,
        ["scale"] = 0.9,
      },
      [17] = {
        ["x"] = 543.52757345764,
        ["y"] = -379.42091419016,
        ["g"] = 29,
        ["sublevel"] = 1,
        ["scale"] = 0.9,
      },
      [18] = {
        ["x"] = 542.85121639743,
        ["y"] = -387.55842957738,
        ["g"] = 29,
        ["sublevel"] = 1,
        ["scale"] = 0.9,
      },
      [19] = {
        ["x"] = 550.44961311207,
        ["y"] = -385.22280017926,
        ["g"] = 29,
        ["sublevel"] = 1,
        ["scale"] = 0.9,
      },
    },
  },
  [16] = {
    ["name"] = "Faceless Seer",
    ["id"] = 212775,
    ["count"] = 5,
    ["health"] = 1481125,
    ["scale"] = 1,
    ["displayId"] = 90742,
    ["creatureType"] = "Aberration",
    ["level"] = 70,
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
      [426783] = {
      },
      [426796] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 349.37831632323,
        ["y"] = -395.25473364772,
        ["g"] = 21,
        ["sublevel"] = 1,
        ["scale"] = 1.2,
      },
      [2] = {
        ["x"] = 404.61985469509,
        ["y"] = -442.98060711642,
        ["g"] = 23,
        ["sublevel"] = 1,
        ["scale"] = 1.2,
      },
      [3] = {
        ["x"] = 434.21666769578,
        ["y"] = -434.92406271528,
        ["g"] = 24,
        ["sublevel"] = 1,
        ["scale"] = 1.2,
      },
      [4] = {
        ["x"] = 439.64766359709,
        ["y"] = -444.51417226961,
        ["g"] = 24,
        ["sublevel"] = 1,
        ["scale"] = 1.2,
      },
    },
  },
  [17] = {
    ["name"] = "Erunak Stonespeaker",
    ["id"] = 40825,
    ["count"] = 0,
    ["health"] = 9338130,
    ["scale"] = 1,
    ["displayId"] = 30408,
    ["creatureType"] = "Humanoid",
    ["level"] = 72,
    ["isBoss"] = true,
    ["encounterID"] = 103,
    ["instanceID"] = 557,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Mind Soothe"] = true,
    },
    ["spells"] = {
      [181089] = {
      },
      [419956] = {
      },
      [429037] = {
      },
      [429038] = {
      },
      [429048] = {
      },
      [429051] = {
      },
      [429057] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 514.63853128232,
        ["y"] = -395.99058807561,
        ["g"] = 27,
        ["sublevel"] = 1,
        ["scale"] = 1.2,
      },
    },
  },
  [18] = {
    ["name"] = "Mindbender Ghur'sha",
    ["id"] = 40788,
    ["count"] = 0,
    ["health"] = 9338130,
    ["scale"] = 1,
    ["displayId"] = 32259,
    ["creatureType"] = "Aberration",
    ["level"] = 72,
    ["isBoss"] = true,
    ["encounterID"] = 103,
    ["instanceID"] = 65,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [429172] = {
      },
      [429173] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 502.70587363816,
        ["y"] = -379.1952218749,
        ["g"] = 27,
        ["sublevel"] = 1,
        ["scale"] = 0.8,
      },
    },
  },
  [19] = {
    ["name"] = "Stormflurry Totem",
    ["id"] = 214117,
    ["count"] = 0,
    ["health"] = 217813,
    ["scale"] = 1,
    ["displayId"] = 19071,
    ["creatureType"] = "Uncategorized",
    ["level"] = 70,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["clones"] = {
      [1] = {
        ["x"] = 525.79259747614,
        ["y"] = -412.53389752033,
        ["g"] = 27,
        ["sublevel"] = 1,
        ["scale"] = 1.3,
      },
    },
  },
  [20] = {
    ["name"] = "Gilgoblin Aquamage",
    ["id"] = 40943,
    ["count"] = 3,
    ["health"] = 592450,
    ["scale"] = 1,
    ["displayId"] = 32121,
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
      [429176] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 292.71265187208,
        ["y"] = -312.94068032569,
        ["g"] = 30,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [2] = {
        ["x"] = 301.07198327838,
        ["y"] = -308.62890905252,
        ["g"] = 30,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [3] = {
        ["x"] = 259.25770192548,
        ["y"] = -250.02799321205,
        ["g"] = 32,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [4] = {
        ["x"] = 267.97629277722,
        ["y"] = -246.89821206388,
        ["g"] = 32,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [5] = {
        ["x"] = 274.18150391209,
        ["y"] = -189.11454367408,
        ["g"] = 34,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [6] = {
        ["x"] = 276.17633539182,
        ["y"] = -197.74324792125,
        ["g"] = 34,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [7] = {
        ["x"] = 283.73095543277,
        ["y"] = -198.66990700772,
        ["g"] = 34,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [8] = {
        ["x"] = 282.68111323441,
        ["y"] = -179.48687546582,
        ["g"] = 34,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [9] = {
        ["x"] = 284.89242717119,
        ["y"] = -187.80269263101,
        ["g"] = 34,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [10] = {
        ["x"] = 292.33881264029,
        ["y"] = -190.43830660995,
        ["g"] = 34,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
    },
  },
  [21] = {
    ["name"] = "Gilgoblin Hunter",
    ["id"] = 40935,
    ["count"] = 3,
    ["health"] = 1036788,
    ["scale"] = 1,
    ["displayId"] = 31982,
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
      [76516] = {
      },
      [427376] = {
      },
      [427384] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 290.92655938982,
        ["y"] = -323.7201496291,
        ["g"] = 30,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [2] = {
        ["x"] = 297.66893030814,
        ["y"] = -320.30663491083,
        ["g"] = 30,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [3] = {
        ["x"] = 304.7706120725,
        ["y"] = -316.53386074711,
        ["g"] = 30,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [4] = {
        ["x"] = 312.05199038039,
        ["y"] = -313.12035630896,
        ["g"] = 30,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [5] = {
        ["x"] = 262.88011238097,
        ["y"] = -258.30178327638,
        ["g"] = 32,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [6] = {
        ["x"] = 271.40028980377,
        ["y"] = -254.98277806101,
        ["g"] = 32,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
    },
  },
  [22] = {
    ["name"] = "Unstable Corruption",
    ["id"] = 40923,
    ["count"] = 0,
    ["health"] = 296225,
    ["scale"] = 1,
    ["displayId"] = 33845,
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
      [76363] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 247.58399708432,
        ["y"] = -271.9365927565,
        ["sublevel"] = 1,
        ["scale"] = 0.7,
      },
      [2] = {
        ["x"] = 240.80466801045,
        ["y"] = -258.81948105226,
        ["sublevel"] = 1,
        ["scale"] = 0.7,
      },
      [3] = {
        ["x"] = 241.59893406985,
        ["y"] = -247.9643449276,
        ["sublevel"] = 1,
        ["scale"] = 0.7,
      },
      [4] = {
        ["x"] = 237.09803246797,
        ["y"] = -236.84445344982,
        ["sublevel"] = 1,
        ["scale"] = 0.7,
      },
      [5] = {
        ["x"] = 240.53988235801,
        ["y"] = -224.40075490706,
        ["sublevel"] = 1,
        ["scale"] = 0.7,
      },
      [6] = {
        ["x"] = 241.59893406985,
        ["y"] = -209.83899838958,
        ["sublevel"] = 1,
        ["scale"] = 0.7,
      },
      [7] = {
        ["x"] = 247.68842838914,
        ["y"] = -204.01428972273,
        ["sublevel"] = 1,
        ["scale"] = 0.7,
      },
      [8] = {
        ["x"] = 254.57215846853,
        ["y"] = -191.57060632962,
        ["sublevel"] = 1,
        ["scale"] = 0.7,
      },
      [9] = {
        ["x"] = 259.07306007041,
        ["y"] = -180.18595949871,
        ["sublevel"] = 1,
        ["scale"] = 0.7,
      },
      [10] = {
        ["x"] = 267.01581156232,
        ["y"] = -174.62597588568,
        ["sublevel"] = 1,
        ["scale"] = 0.7,
      },
      [11] = {
        ["x"] = 279.989035961,
        ["y"] = -166.41845389097,
        ["sublevel"] = 1,
        ["scale"] = 0.7,
      },
      [12] = {
        ["x"] = 292.69750500655,
        ["y"] = -163.77083976103,
        ["sublevel"] = 1,
        ["scale"] = 0.7,
      },
    },
  },
  [23] = {
    ["name"] = "Tainted Sentry",
    ["id"] = 40925,
    ["count"] = 7,
    ["health"] = 2369800,
    ["scale"] = 1,
    ["displayId"] = 33846,
    ["creatureType"] = "Elemental",
    ["level"] = 71,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [76634] = {
      },
      [76636] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 274.26308425908,
        ["y"] = -270.11546578052,
        ["g"] = 31,
        ["sublevel"] = 1,
        ["scale"] = 1.6,
        ["patrol"] = {
          [1] = {
            ["x"] = 274.26308425908,
            ["y"] = -270.11546578052,
          },
          [2] = {
            ["x"] = 279.86294250422,
            ["y"] = -281.61391505649,
          },
          [3] = {
            ["x"] = 274.26308425908,
            ["y"] = -270.11546578052,
          },
          [4] = {
            ["x"] = 268.20147624222,
            ["y"] = -259.66292281832,
          },
          [5] = {
            ["x"] = 262.48508891343,
            ["y"] = -241.14180746232,
          },
          [6] = {
            ["x"] = 261.57047950126,
            ["y"] = -229.25171501486,
          },
          [7] = {
            ["x"] = 262.48508891343,
            ["y"] = -220.79143403061,
          },
          [8] = {
            ["x"] = 261.57047950126,
            ["y"] = -229.25171501486,
          },
          [9] = {
            ["x"] = 262.48508891343,
            ["y"] = -241.14180746232,
          },
          [10] = {
            ["x"] = 265.22894331751,
            ["y"] = -252.34595593445,
          },
          [11] = {
            ["x"] = 268.20147624222,
            ["y"] = -259.66292281832,
          },
        },
      },
      [2] = {
        ["x"] = 261.7247936157,
        ["y"] = -221.39174241542,
        ["g"] = 33,
        ["sublevel"] = 1,
        ["scale"] = 1.6,
        ["patrol"] = {
          [1] = {
            ["x"] = 261.7247936157,
            ["y"] = -221.39174241542,
          },
          [2] = {
            ["x"] = 265.42727944353,
            ["y"] = -212.22181171743,
          },
          [3] = {
            ["x"] = 270.19296669785,
            ["y"] = -201.36667559278,
          },
          [4] = {
            ["x"] = 265.42727944353,
            ["y"] = -212.22181171743,
          },
          [5] = {
            ["x"] = 261.7247936157,
            ["y"] = -221.39174241542,
          },
          [6] = {
            ["x"] = 260.66162248851,
            ["y"] = -232.87306255421,
          },
          [7] = {
            ["x"] = 262.48508891343,
            ["y"] = -241.14180746232,
          },
          [8] = {
            ["x"] = 260.66162248851,
            ["y"] = -232.87306255421,
          },
        },
      },
      [3] = {
        ["x"] = 314.57406714718,
        ["y"] = -161.23800338252,
        ["g"] = 35,
        ["sublevel"] = 1,
        ["scale"] = 1.6,
      },
      [4] = {
        ["x"] = 321.58062262724,
        ["y"] = -173.49804204947,
        ["g"] = 35,
        ["sublevel"] = 1,
        ["scale"] = 1.6,
      },
    },
  },
  [24] = {
    ["name"] = "Ink of Ozumat",
    ["id"] = 213770,
    ["count"] = 0,
    ["health"] = 10375700,
    ["scale"] = 1,
    ["displayId"] = 91695,
    ["creatureType"] = "Elemental",
    ["level"] = 72,
    ["isBoss"] = true,
    ["encounterID"] = 104,
    ["instanceID"] = 557,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [428399] = {
      },
      [428401] = {
      },
      [428405] = {
      },
      [428407] = {
      },
      [428530] = {
      },
      [428868] = {
      },
      [428889] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 358.97911262139,
        ["y"] = -144.75815900139,
        ["g"] = 36,
        ["sublevel"] = 1,
        ["scale"] = 1.2,
      },
    },
  },
  [25] = {
    ["name"] = "Sludge",
    ["id"] = 213942,
    ["count"] = 0,
    ["health"] = 296225,
    ["scale"] = 1,
    ["displayId"] = 91837,
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
      [428403] = {
      },
      [428531] = {
      },
      [428621] = {
      },
      [428809] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 349.03481381474,
        ["y"] = -125.06909313096,
        ["g"] = 36,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
    },
  },
  [26] = {
    ["name"] = "Splotch",
    ["id"] = 213806,
    ["count"] = 0,
    ["health"] = 207357,
    ["scale"] = 1,
    ["displayId"] = 102373,
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
      [428526] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 364.46067587086,
        ["y"] = -123.8878466557,
        ["g"] = 36,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
    },
  },
  [27] = {
    ["name"] = "Ozumat",
    ["id"] = 44566,
    ["count"] = 0,
    ["health"] = 59289712,
    ["scale"] = 1,
    ["displayId"] = 34135,
    ["creatureType"] = "Aberration",
    ["level"] = 71,
    ["isBoss"] = true,
    ["encounterID"] = 104,
    ["instanceID"] = 65,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [428594] = {
      },
      [428616] = {
      },
      [429046] = {
      },
      [429049] = {
      },
      [429089] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 395.00107416735,
        ["y"] = -160.55815145669,
        ["g"] = 36,
        ["sublevel"] = 1,
        ["scale"] = 1.2,
      },
    },
  },
};
