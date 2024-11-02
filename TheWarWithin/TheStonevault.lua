local addonName = ...
local MDT = MDT
local L = MDT.L

local dungeonIndex = 110
MDT.dungeonList[dungeonIndex] = L["The Stonevault"]
MDT.mapInfo[dungeonIndex] = {
  teleportId = 445269,
  shortName = L["stoneVaultShortName"],
  englishName = "The Stonevault",
  mapID = 501
}

local zones = { 2214, 2341 }
for _, zone in ipairs(zones) do
  MDT.zoneIdToDungeonIdx[zone] = dungeonIndex
end

MDT.dungeonMaps[dungeonIndex] = {
  [0] = "",
  [1] = { customTextures = 'Interface\\AddOns\\'..addonName..'\\TheWarWithin\\Textures\\Stonevault' }
}

MDT.dungeonSubLevels[dungeonIndex] = {
  [1] = L["The Stonevault"]
}

MDT.dungeonTotalCount[dungeonIndex] = { normal = 489, teeming = 1000, teemingEnabled = true }

MDT.mapPOIs[dungeonIndex] = {
  [1] = {
    [1] = {
      ["template"] = "MapLinkPinTemplate",
      ["type"] = "stonevaultItem",
      ["x"] = 247.47244222345,
      ["y"] = -307.41345271418,
    },
    [2] = {
      ["template"] = "MapLinkPinTemplate",
      ["type"] = "dungeonEntrance",
      ["x"] = 420.12609193429,
      ["y"] = -67.862389219205,
    },
  },
};

MDT.dungeonEnemies[dungeonIndex] = {
  [1] = {
    ["name"] = "Cursedheart Invader",
    ["id"] = 212389,
    ["count"] = 5,
    ["health"] = 19891335,
    ["scale"] = 1,
    ["displayId"] = 118702,
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
      [426283] = {
        ["interruptible"] = true,
      },
      [426308] = {
      },
      [427300] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 415.05239185006,
        ["y"] = -94.198992021449,
        ["g"] = 1,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 427.45262303034,
        ["y"] = -94.716655095613,
        ["g"] = 1,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 415.6532780465,
        ["y"] = -128.02632096441,
        ["g"] = 2,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 411.49866877964,
        ["y"] = -147.0445621092,
        ["g"] = 3,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 420.96337945051,
        ["y"] = -146.66554152342,
        ["g"] = 3,
        ["sublevel"] = 1,
      },
      [6] = {
        ["x"] = 430.4338691766,
        ["y"] = -146.61980295303,
        ["g"] = 3,
        ["sublevel"] = 1,
      },
      [7] = {
        ["x"] = 434.85585402472,
        ["y"] = -191.43246286624,
        ["g"] = -3,
        ["sublevel"] = 1,
      },
      [8] = {
        ["x"] = 541.41819072336,
        ["y"] = -275.90940192248,
        ["g"] = 9,
        ["sublevel"] = 1,
      },
      [9] = {
        ["x"] = 545.456449712,
        ["y"] = -267.06483897231,
        ["g"] = 9,
        ["sublevel"] = 1,
      },
      [10] = {
        ["x"] = 653.28368366095,
        ["y"] = -251.96917212884,
        ["g"] = 13,
        ["sublevel"] = 1,
      },
      [11] = {
        ["x"] = 616.46209599519,
        ["y"] = -189.7678472089,
        ["g"] = 11,
        ["sublevel"] = 1,
      },
      [12] = {
        ["x"] = 625.38422898095,
        ["y"] = -186.40398686193,
        ["g"] = 11,
        ["sublevel"] = 1,
      },
    },
  },
  [2] = {
    ["name"] = "Earth Infused Golem",
    ["id"] = 210109,
    ["count"] = 10,
    ["health"] = 31826136,
    ["scale"] = 1,
    ["stealthDetect"] = true,
    ["displayId"] = 117402,
    ["creatureType"] = "Mechanical",
    ["level"] = 80,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Slow"] = true,
    },
    ["spells"] = {
      [425027] = {
      },
      [425974] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 420.80873245562,
        ["y"] = -102.13526519548,
        ["g"] = 1,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 445.02883479314,
        ["y"] = -180.93999335466,
        ["g"] = -3,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 414.39878977222,
        ["y"] = -202.90018466993,
        ["g"] = 5,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 424.34278465276,
        ["y"] = -203.22255431934,
        ["g"] = 5,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 395.74669115686,
        ["y"] = -181.44420259993,
        ["g"] = 4,
        ["sublevel"] = 1,
      },
    },
  },
  [3] = {
    ["name"] = "Ghastly Voidsoul",
    ["id"] = 212453,
    ["count"] = 7,
    ["health"] = 17902202,
    ["scale"] = 1,
    ["displayId"] = 118731,
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
      [449455] = {
        ["interruptible"] = true,
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 424.96737377244,
        ["y"] = -128.11893480161,
        ["g"] = 2,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 444.59349393278,
        ["y"] = -191.18584992769,
        ["g"] = -3,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 395.45627225676,
        ["y"] = -190.81945106677,
        ["g"] = 4,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 404.99042310407,
        ["y"] = -191.34290327923,
        ["g"] = 4,
        ["sublevel"] = 1,
      },
    },
  },
  [4] = {
    ["name"] = "Repurposed Loaderbot",
    ["id"] = 222923,
    ["count"] = 3,
    ["health"] = 20885902,
    ["scale"] = 1,
    ["displayId"] = 118231,
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
      [447141] = {
      },
      [447145] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 424.56917190377,
        ["y"] = -118.32380749889,
        ["g"] = 2,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 415.17878578751,
        ["y"] = -118.64931353623,
        ["g"] = 2,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 416.48887476036,
        ["y"] = -155.83674643439,
        ["g"] = 3,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 425.71122335836,
        ["y"] = -155.68239671654,
        ["g"] = 3,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 435.23317781404,
        ["y"] = -181.24406664732,
        ["g"] = -3,
        ["sublevel"] = 1,
      },
      [6] = {
        ["x"] = 404.84517200795,
        ["y"] = -180.99481099543,
        ["g"] = 4,
        ["sublevel"] = 1,
      },
      [7] = {
        ["x"] = 328.74208604436,
        ["y"] = -271.02979271156,
        ["g"] = 15,
        ["sublevel"] = 1,
      },
      [8] = {
        ["x"] = 278.26198310427,
        ["y"] = -333.5141102033,
        ["g"] = 19,
        ["sublevel"] = 1,
      },
    },
  },
  [5] = {
    ["name"] = "Void Bound Despoiler",
    ["id"] = 212765,
    ["count"] = 10,
    ["health"] = 31826136,
    ["scale"] = 1.3,
    ["stealthDetect"] = true,
    ["displayId"] = 117973,
    ["creatureType"] = "Humanoid",
    ["level"] = 80,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Slow"] = true,
      ["Mind Soothe"] = true,
    },
    ["spells"] = {
      [426771] = {
      },
      [426786] = {
      },
      [459210] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 459.21881711661,
        ["y"] = -246.71390660521,
        ["g"] = 6,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 608.41603119243,
        ["y"] = -235.8234212995,
        ["g"] = 10,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 642.6734867849,
        ["y"] = -221.51879344958,
        ["g"] = 12,
        ["sublevel"] = 1,
        ["patrol"] = {
          [1] = {
            ["x"] = 642.6734867849,
            ["y"] = -221.51879344958,
          },
          [2] = {
            ["x"] = 650.17453372314,
            ["y"] = -235.14194776859,
          },
          [3] = {
            ["x"] = 642.6734867849,
            ["y"] = -221.51879344958,
          },
          [4] = {
            ["x"] = 627.44455779994,
            ["y"] = -202.50979995458,
          },
        },
      },
    },
  },
  [6] = {
    ["name"] = "Engine Speaker",
    ["id"] = 212764,
    ["count"] = 3,
    ["health"] = 21880469,
    ["scale"] = 1,
    ["displayId"] = 117641,
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
      [427382] = {
      },
      [452811] = {
      },
      [464876] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 240.73441758083,
        ["y"] = -360.30832593399,
        ["g"] = 24,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 458.50806402676,
        ["y"] = -234.79964678186,
        ["g"] = 6,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 449.65955976644,
        ["y"] = -239.36432825423,
        ["g"] = 6,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 448.32088337242,
        ["y"] = -249.86995259284,
        ["g"] = 6,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 381.20973052222,
        ["y"] = -247.60838347845,
        ["g"] = 14,
        ["sublevel"] = 1,
      },
      [6] = {
        ["x"] = 339.41647735631,
        ["y"] = -271.94571127669,
        ["g"] = 15,
        ["sublevel"] = 1,
      },
      [7] = {
        ["x"] = 310.20904311323,
        ["y"] = -303.89548801872,
        ["g"] = 16,
        ["sublevel"] = 1,
      },
      [8] = {
        ["x"] = 298.87024654447,
        ["y"] = -281.51463703299,
        ["g"] = 16,
        ["sublevel"] = 1,
      },
      [9] = {
        ["x"] = 283.67949081071,
        ["y"] = -341.34389164358,
        ["g"] = 19,
        ["sublevel"] = 1,
      },
      [10] = {
        ["x"] = 217.06648128275,
        ["y"] = -421.85295590124,
        ["g"] = 20,
        ["sublevel"] = 1,
      },
      [11] = {
        ["x"] = 206.94675347082,
        ["y"] = -404.22295831917,
        ["g"] = 20,
        ["sublevel"] = 1,
      },
      [12] = {
        ["x"] = 212.0637539105,
        ["y"] = -413.06643462732,
        ["g"] = 20,
        ["sublevel"] = 1,
      },
      [13] = {
        ["x"] = 260.97852806199,
        ["y"] = -293.6096129216,
        ["g"] = 28,
        ["sublevel"] = 1,
      },
      [14] = {
        ["x"] = 236.41483882766,
        ["y"] = -352.51400298434,
        ["g"] = 24,
        ["sublevel"] = 1,
      },
      [15] = {
        ["x"] = 305.05898053776,
        ["y"] = -409.18629178679,
        ["g"] = 21,
        ["sublevel"] = 1,
      },
      [18] = {
        ["x"] = 257.24662410654,
        ["y"] = -430.12864672023,
        ["g"] = 70,
        ["sublevel"] = 1,
      },
      [19] = {
        ["x"] = 261.27006780881,
        ["y"] = -438.6065968405,
        ["g"] = 70,
        ["sublevel"] = 1,
      },
      [20] = {
        ["x"] = 252.79208271829,
        ["y"] = -422.08175931569,
        ["g"] = 70,
        ["sublevel"] = 1,
      },
    },
  },
  [7] = {
    ["name"] = "Void Bound Howler",
    ["id"] = 221979,
    ["count"] = 7,
    ["health"] = 18896768,
    ["scale"] = 1,
    ["displayId"] = 118365,
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
      [445207] = {
        ["interruptible"] = true,
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 515.35489335741,
        ["y"] = -253.24896376245,
        ["g"] = 7,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 514.42365697602,
        ["y"] = -273.24172662358,
        ["g"] = 7,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 562.32378385676,
        ["y"] = -257.61497075732,
        ["g"] = 8,
        ["sublevel"] = 1,
        ["patrol"] = {
          [1] = {
            ["x"] = 575.61358717616,
            ["y"] = -252.4033355342,
          },
          [2] = {
            ["x"] = 565.35878008473,
            ["y"] = -260.80709044628,
          },
          [3] = {
            ["x"] = 544.51210012929,
            ["y"] = -270.44868792179,
          },
          [4] = {
            ["x"] = 526.79241799527,
            ["y"] = -266.53993369186,
          },
          [5] = {
            ["x"] = 544.51210012929,
            ["y"] = -270.44868792179,
          },
          [6] = {
            ["x"] = 565.35878008473,
            ["y"] = -260.80709044628,
          },
        },
      },
      [4] = {
        ["x"] = 614.33407431418,
        ["y"] = -225.67970846078,
        ["g"] = 10,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 619.22406795767,
        ["y"] = -234.29062896944,
        ["g"] = 10,
        ["sublevel"] = 1,
      },
    },
  },
  [8] = {
    ["name"] = "Turned Speaker",
    ["id"] = 214350,
    ["count"] = 3,
    ["health"] = 20885902,
    ["scale"] = 1,
    ["displayId"] = 118692,
    ["creatureType"] = "Aberration",
    ["level"] = 80,
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
      [427300] = {
      },
      [429545] = {
        ["interruptible"] = true,
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 514.59129018078,
        ["y"] = -262.95970784297,
        ["g"] = 7,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 565.41081273886,
        ["y"] = -266.94653853661,
        ["g"] = 8,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 550.23515856458,
        ["y"] = -275.80104602444,
        ["g"] = 9,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 662.01490048881,
        ["y"] = -249.23991289068,
        ["g"] = 13,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 650.36844949856,
        ["y"] = -243.32631663726,
        ["g"] = 13,
        ["sublevel"] = 1,
      },
    },
  },
  [9] = {
    ["name"] = "Void Touched Elemental",
    ["id"] = 212400,
    ["count"] = 4,
    ["health"] = 21880469,
    ["scale"] = 1,
    ["displayId"] = 109870,
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
      [426345] = {
      },
      [449070] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 571.55870743328,
        ["y"] = -260.06271281025,
        ["g"] = 8,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 659.07002010883,
        ["y"] = -240.61572600906,
        ["g"] = 13,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 620.75653890734,
        ["y"] = -198.79880134387,
        ["g"] = 11,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 629.91312413563,
        ["y"] = -195.21483773814,
        ["g"] = 11,
        ["sublevel"] = 1,
      },
    },
  },
  [10] = {
    ["name"] = "Aspiring Forgehand",
    ["id"] = 212405,
    ["count"] = 1,
    ["health"] = 11934801,
    ["scale"] = 1,
    ["displayId"] = 114686,
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
      [423766] = {
      },
      [427361] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 391.74024075366,
        ["y"] = -247.34926793079,
        ["g"] = 14,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 385.31538858364,
        ["y"] = -237.09793199727,
        ["g"] = 14,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 274.33271264499,
        ["y"] = -312.84242052047,
        ["g"] = 18,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 276.87829327294,
        ["y"] = -303.84783625691,
        ["g"] = 18,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 285.45836295484,
        ["y"] = -301.23262892146,
        ["g"] = 18,
        ["sublevel"] = 1,
      },
      [6] = {
        ["x"] = 283.25750712005,
        ["y"] = -310.50461924012,
        ["g"] = 18,
        ["sublevel"] = 1,
        ["patrol"] = {
          [1] = {
            ["x"] = 283.25750712005,
            ["y"] = -310.50461924012,
          },
          [2] = {
            ["x"] = 287.0862114247,
            ["y"] = -326.79844848055,
          },
          [3] = {
            ["x"] = 295.75060108566,
            ["y"] = -346.60278421935,
          },
          [4] = {
            ["x"] = 308.43773483236,
            ["y"] = -365.16935000658,
          },
          [5] = {
            ["x"] = 295.75060108566,
            ["y"] = -346.60278421935,
          },
          [6] = {
            ["x"] = 286.15790873161,
            ["y"] = -323.39458937061,
          },
        },
      },
      [7] = {
        ["x"] = 292.35909128884,
        ["y"] = -307.8621314166,
        ["g"] = 18,
        ["sublevel"] = 1,
      },
      [8] = {
        ["x"] = 302.1062353589,
        ["y"] = -328.11647844033,
        ["g"] = 17,
        ["sublevel"] = 1,
      },
      [9] = {
        ["x"] = 289.02941433687,
        ["y"] = -350.61679044475,
        ["g"] = 19,
        ["sublevel"] = 1,
      },
      [10] = {
        ["x"] = 251.0629135165,
        ["y"] = -290.00961919538,
        ["g"] = 28,
        ["sublevel"] = 1,
      },
      [11] = {
        ["x"] = 269.68728421841,
        ["y"] = -287.9659522796,
        ["g"] = 28,
        ["sublevel"] = 1,
      },
      [12] = {
        ["x"] = 258.89346485046,
        ["y"] = -283.1740878509,
        ["g"] = 28,
        ["sublevel"] = 1,
      },
      [13] = {
        ["x"] = 248.397281122,
        ["y"] = -280.27069553806,
        ["g"] = 28,
        ["sublevel"] = 1,
      },
      [14] = {
        ["x"] = 240.31031744848,
        ["y"] = -344.46010920134,
        ["g"] = 24,
        ["sublevel"] = 1,
      },
      [15] = {
        ["x"] = 245.41552066013,
        ["y"] = -351.56414986493,
        ["g"] = 24,
        ["sublevel"] = 1,
        ["patrol"] = {
          [1] = {
            ["x"] = 245.41552066013,
            ["y"] = -351.56414986493,
          },
          [2] = {
            ["x"] = 258.02939988181,
            ["y"] = -348.32084398577,
          },
          [3] = {
            ["x"] = 239.74844959781,
            ["y"] = -354.79536330165,
          },
          [4] = {
            ["x"] = 230.6079947804,
            ["y"] = -364.69756333635,
          },
        },
      },
      [16] = {
        ["x"] = 249.56769863543,
        ["y"] = -359.98011290793,
        ["g"] = 24,
        ["sublevel"] = 1,
      },
      [17] = {
        ["x"] = 219.96593043999,
        ["y"] = -360.10425443678,
        ["g"] = 26,
        ["sublevel"] = 1,
      },
      [18] = {
        ["x"] = 308.70117761502,
        ["y"] = -399.81548435251,
        ["g"] = 21,
        ["sublevel"] = 1,
      },
      [19] = {
        ["x"] = 306.81807489029,
        ["y"] = -417.98619251745,
        ["g"] = 21,
        ["sublevel"] = 1,
      },
      [20] = {
        ["x"] = 248.19101866049,
        ["y"] = -429.86589040172,
        ["g"] = 70,
        ["sublevel"] = 1,
      },
      [21] = {
        ["x"] = 252.33191536758,
        ["y"] = -438.38063557124,
        ["g"] = 70,
        ["sublevel"] = 1,
      },
    },
  },
  [11] = {
    ["name"] = "Forgebound Mender",
    ["id"] = 213338,
    ["count"] = 5,
    ["health"] = 17902202,
    ["scale"] = 1,
    ["displayId"] = 115974,
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
      [429109] = {
        ["interruptible"] = true,
      },
      [429110] = {
        ["interruptible"] = true,
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 334.13407954108,
        ["y"] = -281.64796267182,
        ["g"] = 15,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 303.39415112553,
        ["y"] = -337.42720063435,
        ["g"] = 17,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 304.28236616189,
        ["y"] = -318.78624338705,
        ["g"] = 17,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 207.7035184535,
        ["y"] = -422.50110502646,
        ["g"] = 20,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 202.16158088064,
        ["y"] = -412.90663696716,
        ["g"] = 20,
        ["sublevel"] = 1,
      },
      [6] = {
        ["x"] = 260.33059292905,
        ["y"] = -336.14628006748,
        ["g"] = 23,
        ["sublevel"] = 1,
      },
      [7] = {
        ["x"] = 271.01809927434,
        ["y"] = -353.46361860953,
        ["g"] = 23,
        ["sublevel"] = 1,
      },
      [8] = {
        ["x"] = 266.57766153713,
        ["y"] = -344.20222130182,
        ["g"] = 23,
        ["sublevel"] = 1,
      },
      [9] = {
        ["x"] = 223.42413795614,
        ["y"] = -369.76078103565,
        ["g"] = 26,
        ["sublevel"] = 1,
      },
      [10] = {
        ["x"] = 216.41942366839,
        ["y"] = -351.53909429685,
        ["g"] = 26,
        ["sublevel"] = 1,
      },
      [11] = {
        ["x"] = 314.57058323812,
        ["y"] = -405.78567159115,
        ["g"] = 21,
        ["sublevel"] = 1,
      },
      [12] = {
        ["x"] = 314.75572354955,
        ["y"] = -414.30128908876,
        ["g"] = 21,
        ["sublevel"] = 1,
      },
    },
  },
  [12] = {
    ["name"] = "Forge Loader",
    ["id"] = 213343,
    ["count"] = 10,
    ["health"] = 35804403,
    ["scale"] = 1.4,
    ["stealthDetect"] = true,
    ["displayId"] = 116911,
    ["creatureType"] = "Mechanical",
    ["level"] = 80,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Slow"] = true,
    },
    ["spells"] = {
      [429114] = {
      },
      [449129] = {
      },
      [449130] = {
      },
      [449153] = {
      },
      [449154] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 308.17897913403,
        ["y"] = -290.69501718037,
        ["g"] = 16,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 287.2308964578,
        ["y"] = -424.85824121372,
        ["sublevel"] = 1,
        ["patrol"] = {
          [1] = {
            ["x"] = 287.2308964578,
            ["y"] = -424.85824121372,
          },
          [2] = {
            ["x"] = 272.62832193092,
            ["y"] = -435.55288125528,
          },
          [3] = {
            ["x"] = 269.68011409884,
            ["y"] = -449.03039951939,
          },
          [4] = {
            ["x"] = 278.01931283672,
            ["y"] = -465.87729848841,
          },
          [5] = {
            ["x"] = 269.68011409884,
            ["y"] = -449.03039951939,
          },
          [6] = {
            ["x"] = 272.62832193092,
            ["y"] = -435.55288125528,
          },
          [7] = {
            ["x"] = 287.2308964578,
            ["y"] = -424.85824121372,
          },
          [8] = {
            ["x"] = 290.64197236944,
            ["y"] = -410.47655287856,
          },
          [9] = {
            ["x"] = 292.24241425302,
            ["y"] = -396.91479867323,
          },
          [10] = {
            ["x"] = 290.64197236944,
            ["y"] = -410.47655287856,
          },
        },
      },
      [3] = {
        ["x"] = 260.99021644864,
        ["y"] = -378.07554474687,
        ["g"] = 22,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 268.98459991995,
        ["y"] = -390.71400650952,
        ["g"] = 22,
        ["sublevel"] = 1,
      },
    },
  },
  [13] = {
    ["name"] = "Cursedforge Honor Guard",
    ["id"] = 214264,
    ["count"] = 8,
    ["health"] = 31826136,
    ["scale"] = 1,
    ["stealthDetect"] = true,
    ["displayId"] = 115944,
    ["creatureType"] = "Humanoid",
    ["level"] = 80,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Mind Soothe"] = true,
    },
    ["spells"] = {
      [428894] = {
      },
      [448640] = {
      },
      [448975] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 430.65698938408,
        ["y"] = -349.37854892153,
        ["g"] = 64,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 415.55641845617,
        ["y"] = -273.88474809578,
        ["g"] = 29,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 425.36761479738,
        ["y"] = -274.03056807671,
        ["g"] = 29,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 413.46900792946,
        ["y"] = -349.82411358837,
        ["g"] = 40,
        ["sublevel"] = 1,
      },
    },
  },
  [14] = {
    ["name"] = "Cursedforge Stoneshaper",
    ["id"] = 214066,
    ["count"] = 5,
    ["health"] = 18896768,
    ["scale"] = 1,
    ["displayId"] = 115945,
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
      [429422] = {
        ["interruptible"] = true,
      },
      [429427] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 399.49766528451,
        ["y"] = -428.12289753161,
        ["g"] = 34,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 430.72520114304,
        ["y"] = -382.57080980236,
        ["g"] = 32,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 410.57918144779,
        ["y"] = -381.99459456747,
        ["g"] = 32,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 442.70059164176,
        ["y"] = -426.12594664234,
        ["g"] = 35,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 430.76789393052,
        ["y"] = -426.43997610159,
        ["g"] = 35,
        ["sublevel"] = 1,
      },
      [6] = {
        ["x"] = 413.1652567913,
        ["y"] = -427.43313167262,
        ["g"] = 34,
        ["sublevel"] = 1,
      },
    },
  },
  [15] = {
    ["name"] = "Rock Smasher",
    ["id"] = 213954,
    ["count"] = 12,
    ["health"] = 39782670,
    ["scale"] = 1.5,
    ["stealthDetect"] = true,
    ["displayId"] = 117855,
    ["creatureType"] = "Elemental",
    ["level"] = 80,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [428703] = {
      },
      [428706] = {
      },
      [428709] = {
      },
      [428879] = {
      },
      [428887] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 421.24294061487,
        ["y"] = -321.03385512463,
        ["g"] = 30,
        ["sublevel"] = 1,
        ["patrol"] = {
          [1] = {
            ["x"] = 421.24294061487,
            ["y"] = -321.03385512463,
          },
          [2] = {
            ["x"] = 420.0755257332,
            ["y"] = -333.46133560933,
          },
          [3] = {
            ["x"] = 419.70436667038,
            ["y"] = -343.46116660108,
          },
          [4] = {
            ["x"] = 420.79211588973,
            ["y"] = -353.04846125516,
          },
          [5] = {
            ["x"] = 421.03097927524,
            ["y"] = -360.21445849705,
          },
          [6] = {
            ["x"] = 421.03097927524,
            ["y"] = -367.85819617804,
          },
          [7] = {
            ["x"] = 421.03097927524,
            ["y"] = -360.21445849705,
          },
          [8] = {
            ["x"] = 420.79211588973,
            ["y"] = -353.04846125516,
          },
          [9] = {
            ["x"] = 419.70436667038,
            ["y"] = -343.46116660108,
          },
          [10] = {
            ["x"] = 420.0755257332,
            ["y"] = -333.46133560933,
          },
          [11] = {
            ["x"] = 421.24294061487,
            ["y"] = -321.03385512463,
          },
          [12] = {
            ["x"] = 420.0755257332,
            ["y"] = -305.0361963592,
          },
          [13] = {
            ["x"] = 420.31436178255,
            ["y"] = -295.24263353629,
          },
          [14] = {
            ["x"] = 420.0755257332,
            ["y"] = -305.0361963592,
          },
        },
      },
      [2] = {
        ["x"] = 436.05732460517,
        ["y"] = -436.90538678864,
        ["g"] = 35,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 407.02319342322,
        ["y"] = -437.18559373416,
        ["g"] = 34,
        ["sublevel"] = 1,
      },
    },
  },
  [16] = {
    ["name"] = "Cursedforge Mender",
    ["id"] = 224962,
    ["count"] = 5,
    ["health"] = 17902202,
    ["scale"] = 1,
    ["displayId"] = 120170,
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
      [429109] = {
        ["interruptible"] = true,
      },
      [429110] = {
        ["interruptible"] = true,
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 403.68768487046,
        ["y"] = -349.44196248868,
        ["g"] = 40,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 440.83551457003,
        ["y"] = -349.50536200237,
        ["g"] = 64,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 420.8890509039,
        ["y"] = -382.28282637036,
        ["g"] = 32,
        ["sublevel"] = 1,
      },
    },
  },
  [17] = {
    ["name"] = "E.D.N.A",
    ["id"] = 210108,
    ["count"] = 0,
    ["health"] = 159130680,
    ["scale"] = 1.5,
    ["displayId"] = 120054,
    ["creatureType"] = "Mechanical",
    ["level"] = 80,
    ["isBoss"] = true,
    ["encounterID"] = 2572,
    ["instanceID"] = 0,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Slow"] = true,
    },
    ["spells"] = {
      [424795] = {
      },
      [424805] = {
      },
      [424879] = {
      },
      [424888] = {
      },
      [424889] = {
      },
      [424893] = {
      },
      [424903] = {
      },
      [424913] = {
      },
      [451728] = {
      },
      [464888] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 419.76147201772,
        ["y"] = -238.92128087437,
        ["sublevel"] = 1,
      },
    },
  },
  [18] = {
    ["name"] = "Skarmorak",
    ["id"] = 210156,
    ["count"] = 0,
    ["health"] = 125533481,
    ["scale"] = 2,
    ["displayId"] = 118714,
    ["creatureType"] = "Elemental",
    ["level"] = 80,
    ["isBoss"] = true,
    ["encounterID"] = 2579,
    ["instanceID"] = 0,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Slow"] = true,
    },
    ["spells"] = {
      [422233] = {
      },
      [422261] = {
      },
      [423200] = {
      },
      [423228] = {
      },
      [423246] = {
      },
      [423324] = {
      },
      [423327] = {
      },
      [423538] = {
      },
      [423572] = {
      },
      [435813] = {
      },
      [439749] = {
      },
      [443405] = {
      },
      [445409] = {
      },
      [464980] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 699.74817113159,
        ["y"] = -173.1586521009,
        ["g"] = 25,
        ["sublevel"] = 1,
      },
    },
  },
  [19] = {
    ["name"] = "Speaker Brokk",
    ["id"] = 213217,
    ["count"] = 0,
    ["health"] = 89511008,
    ["scale"] = 2,
    ["displayId"] = 115818,
    ["creatureType"] = "Humanoid",
    ["level"] = 80,
    ["isBoss"] = true,
    ["encounterID"] = 2590,
    ["instanceID"] = 0,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Slow"] = true,
      ["Mind Soothe"] = true,
    },
    ["spells"] = {
      [428161] = {
      },
      [428202] = {
      },
      [428204] = {
      },
      [428212] = {
      },
      [428819] = {
      },
      [428820] = {
      },
      [429999] = {
      },
      [430097] = {
      },
      [430098] = {
      },
      [439577] = {
      },
      [443954] = {
      },
      [445541] = {
      },
      [457144] = {
      },
      [462372] = {
      },
      [462373] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 80.546507183685,
        ["y"] = -466.14107485364,
        ["g"] = 27,
        ["sublevel"] = 1,
      },
    },
  },
  [20] = {
    ["name"] = "Speaker Dorlita",
    ["id"] = 213216,
    ["count"] = 0,
    ["health"] = 107413209,
    ["scale"] = 2,
    ["displayId"] = 116916,
    ["creatureType"] = "Humanoid",
    ["level"] = 80,
    ["isBoss"] = true,
    ["encounterID"] = 2590,
    ["instanceID"] = 0,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Slow"] = true,
      ["Mind Soothe"] = true,
    },
    ["spells"] = {
      [428120] = {
      },
      [428508] = {
      },
      [428519] = {
      },
      [428711] = {
      },
      [439577] = {
      },
      [449167] = {
      },
      [449169] = {
      },
      [457144] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 102.30037882388,
        ["y"] = -506.10925249048,
        ["g"] = 27,
        ["sublevel"] = 1,
      },
    },
  },
  [21] = {
    ["name"] = "Void Speaker Eirich",
    ["id"] = 213119,
    ["count"] = 0,
    ["health"] = 143466834,
    ["scale"] = 2,
    ["displayId"] = 119856,
    ["creatureType"] = "Humanoid",
    ["level"] = 80,
    ["isBoss"] = true,
    ["encounterID"] = 2582,
    ["instanceID"] = 0,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Mind Soothe"] = true,
    },
    ["spells"] = {
      [427329] = {
      },
      [427461] = {
      },
      [427852] = {
      },
      [427854] = {
      },
      [427865] = {
      },
      [427869] = {
      },
      [428532] = {
      },
      [457465] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 424.05772414571,
        ["y"] = -500.89762465512,
        ["sublevel"] = 1,
      },
    },
  },
  [22] = {
    ["name"] = "Cursedheart Invader",
    ["id"] = 212403,
    ["count"] = 5,
    ["health"] = 19891335,
    ["scale"] = 1,
    ["displayId"] = 118702,
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
      [426283] = {
        ["interruptible"] = true,
      },
      [426308] = {
      },
      [452811] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 375.06181728957,
        ["y"] = -238.69731441309,
        ["g"] = 14,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 386.56521576495,
        ["y"] = -256.75399969814,
        ["g"] = 14,
        ["sublevel"] = 1,
      },
    },
  },
  [23] = {
    ["name"] = "Vent Stalker",
    ["id"] = 214049,
    ["count"] = 0,
    ["health"] = 90983109,
    ["scale"] = 1,
    ["displayId"] = 100728,
    ["creatureType"] = "Uncategorized",
    ["level"] = 80,
    ["isBoss"] = true,
    ["encounterID"] = 2590,
    ["instanceID"] = 0,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [428819] = {
      },
      [428820] = {
      },
      [429999] = {
      },
      [443954] = {
      },
      [462372] = {
      },
      [462373] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 104.46412410745,
        ["y"] = -411.8073661178,
        ["sublevel"] = 1,
      },
    },
  },
  [24] = {
    ["name"] = "Scrap Block",
    ["id"] = 213694,
    ["count"] = 0,
    ["health"] = 90983109,
    ["scale"] = 1,
    ["displayId"] = 91401,
    ["creatureType"] = "Uncategorized",
    ["level"] = 80,
    ["isBoss"] = true,
    ["encounterID"] = 2590,
    ["instanceID"] = 0,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [428242] = {
      },
      [428520] = {
      },
      [428535] = {
      },
      [428547] = {
      },
      [463145] = {
      },
      [464392] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 161.71776349198,
        ["y"] = -506.6053245252,
        ["sublevel"] = 1,
      },
    },
  },
  [25] = {
    ["name"] = "Crystal Shard",
    ["id"] = 214443,
    ["count"] = 0,
    ["health"] = 1275261,
    ["scale"] = 1,
    ["displayId"] = 37518,
    ["creatureType"] = "Uncategorized",
    ["level"] = 80,
    ["isBoss"] = true,
    ["encounterID"] = 2579,
    ["instanceID"] = 0,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Slow"] = true,
    },
    ["spells"] = {
      [439600] = {
      },
      [443494] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 714.45914191942,
        ["y"] = -206.13900400225,
        ["g"] = 25,
        ["sublevel"] = 1,
      },
    },
  },
};
