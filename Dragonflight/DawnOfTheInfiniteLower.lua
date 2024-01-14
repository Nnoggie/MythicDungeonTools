local addonName = ...
local MDT = MDT
local L = MDT.L
local dungeonIndex = 100
MDT.dungeonList[dungeonIndex] = L["DawnOfTheInfiniteLower"]
MDT.mapInfo[dungeonIndex] = {

};

local zones = { 2190, 2192, 2193, 2198 }
for _, zone in ipairs(zones) do
  MDT.zoneIdToDungeonIdx[zone] = dungeonIndex
end

MDT.dungeonMaps[dungeonIndex] = {
  [0] = "",
  [1] = { customTextures = 'DawnOfTheInfiniteLower' },
}

MDT.dungeonSubLevels[dungeonIndex] = {
  [1] = L["dotiLowerSublevel1"],
}

MDT.dungeonTotalCount[dungeonIndex] = { normal = 300, teeming = 1000, teemingEnabled = true }

MDT.mapPOIs[dungeonIndex] = {};

MDT.dungeonEnemies[dungeonIndex] = {
  [1] = {
    ["name"] = "Infinite Timeslicer",
    ["id"] = 205408,
    ["count"] = 4,
    ["health"] = 1481125,
    ["scale"] = 1,
    ["displayId"] = 112579,
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
      [412012] = {
      },
      [412044] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 145.59723585048,
        ["y"] = -120.5668359044,
        ["g"] = 1,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
      [2] = {
        ["x"] = 146.42046310097,
        ["y"] = -139.14215221619,
        ["g"] = 1,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
      [3] = {
        ["x"] = 166.30794941765,
        ["y"] = -103.54206765828,
        ["g"] = 2,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
      [4] = {
        ["x"] = 186.80376396299,
        ["y"] = -114.30564762008,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
        ["patrol"] = {
          [1] = {
            ["x"] = 186.80376396299,
            ["y"] = -114.30564762008,
          },
          [2] = {
            ["x"] = 177.92444996571,
            ["y"] = -103.11394702437,
          },
          [3] = {
            ["x"] = 186.80376396299,
            ["y"] = -114.30564762008,
          },
          [4] = {
            ["x"] = 191.48375125739,
            ["y"] = -125.64626702333,
          },
          [5] = {
            ["x"] = 193.67713072866,
            ["y"] = -139.20554549535,
          },
          [6] = {
            ["x"] = 192.48071910649,
            ["y"] = -151.36901421145,
          },
          [7] = {
            ["x"] = 187.09692385588,
            ["y"] = -157.74985717995,
          },
          [8] = {
            ["x"] = 192.48071910649,
            ["y"] = -151.36901421145,
          },
          [9] = {
            ["x"] = 193.67713072866,
            ["y"] = -139.20554549535,
          },
          [10] = {
            ["x"] = 191.48375125739,
            ["y"] = -125.64626702333,
          },
        },
      },
      [5] = {
        ["x"] = 181.91388461367,
        ["y"] = -152.28496785245,
        ["g"] = 3,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
      [6] = {
        ["x"] = 172.22524209985,
        ["y"] = -159.8391917146,
        ["g"] = 3,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
      [7] = {
        ["x"] = 277.79262327493,
        ["y"] = -123.98778862776,
        ["g"] = 5,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
      [8] = {
        ["x"] = 279.25586884843,
        ["y"] = -135.20069030303,
        ["g"] = 5,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
      [9] = {
        ["x"] = 451.43090425465,
        ["y"] = -446.39349590663,
        ["g"] = 23,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
      [10] = {
        ["x"] = 470.71173399493,
        ["y"] = -478.04415062254,
        ["g"] = 24,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
      [11] = {
        ["x"] = 469.51920432289,
        ["y"] = -514.44100491521,
        ["g"] = 25,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
      [12] = {
        ["x"] = 462.46627321687,
        ["y"] = -526.02823723138,
        ["g"] = 25,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
    },
  },
  [2] = {
    ["name"] = "Infinite Chronoweaver",
    ["id"] = 205384,
    ["count"] = 5,
    ["health"] = 1481125,
    ["scale"] = 1,
    ["displayId"] = 112575,
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
      [411994] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 152.60221924465,
        ["y"] = -131.20086518421,
        ["g"] = 1,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
      [2] = {
        ["x"] = 165.26426519953,
        ["y"] = -88.462254497473,
        ["g"] = 2,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
      [3] = {
        ["x"] = 180.64281002855,
        ["y"] = -89.393509648215,
        ["g"] = 2,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
      [4] = {
        ["x"] = 176.98211476041,
        ["y"] = -173.47353112675,
        ["g"] = 3,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
      [5] = {
        ["x"] = 188.65867455904,
        ["y"] = -165.05327944709,
        ["g"] = 3,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
      [6] = {
        ["x"] = 265.98454647193,
        ["y"] = -129.84518724741,
        ["g"] = 5,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
      [7] = {
        ["x"] = 473.61933427345,
        ["y"] = -525.15681251098,
        ["g"] = 25,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
      [8] = {
        ["x"] = 514.96104281387,
        ["y"] = -543.32803520623,
        ["g"] = 26,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
    },
  },
  [3] = {
    ["name"] = "Epoch Ripper",
    ["id"] = 205435,
    ["count"] = 12,
    ["health"] = 2073575,
    ["scale"] = 1,
    ["displayId"] = 112577,
    ["creatureType"] = "Dragonkin",
    ["level"] = 71,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Mind Soothe"] = true,
    },
    ["spells"] = {
      [412063] = {
      },
      [412065] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 214.03741382287,
        ["y"] = -139.60191896506,
        ["g"] = 4,
        ["sublevel"] = 1,
        ["scale"] = 1.9,
      },
      [2] = {
        ["x"] = 214.27631756974,
        ["y"] = -122.59249991301,
        ["g"] = 4,
        ["sublevel"] = 1,
        ["scale"] = 1.9,
      },
      [3] = {
        ["x"] = 271.0629744153,
        ["y"] = -146.74027596622,
        ["g"] = 5,
        ["sublevel"] = 1,
        ["scale"] = 1.9,
      },
      [4] = {
        ["x"] = 269.63411869148,
        ["y"] = -110.76516585143,
        ["g"] = 5,
        ["sublevel"] = 1,
        ["scale"] = 1.9,
      },
      [5] = {
        ["x"] = 459.87237774811,
        ["y"] = -456.03777422054,
        ["g"] = 23,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
      [6] = {
        ["x"] = 526.69317292225,
        ["y"] = -527.26154841078,
        ["g"] = 26,
        ["sublevel"] = 1,
        ["scale"] = 1.9,
      },
      [7] = {
        ["x"] = 530.32208477997,
        ["y"] = -542.58209218715,
        ["g"] = 26,
        ["sublevel"] = 1,
        ["scale"] = 1.9,
      },
    },
  },
  [4] = {
    ["name"] = "Chronikar",
    ["id"] = 198995,
    ["count"] = 0,
    ["health"] = 8893457,
    ["scale"] = 1,
    ["displayId"] = 111556,
    ["creatureType"] = "Dragonkin",
    ["level"] = 72,
    ["isBoss"] = true,
    ["encounterID"] = 2521,
    ["instanceID"] = 1209,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Mind Soothe"] = true,
    },
    ["spells"] = {
      [401420] = {
      },
      [401421] = {
      },
      [401794] = {
      },
      [405970] = {
      },
      [413013] = {
      },
      [413041] = {
      },
      [413105] = {
      },
      [413107] = {
      },
      [413142] = {
      },
      [416716] = {
      },
      [418420] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 320.55935696136,
        ["y"] = -130.05432255642,
        ["g"] = 6,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
    },
  },
  [5] = {
    ["name"] = "Timestream Anomaly",
    ["id"] = 199749,
    ["count"] = 12,
    ["health"] = 1777350,
    ["scale"] = 1,
    ["displayId"] = 93213,
    ["creatureType"] = "Aberration",
    ["level"] = 71,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [413529] = {
      },
      [413532] = {
      },
      [413536] = {
      },
      [413544] = {
      },
      [413547] = {
      },
      [418085] = {
      },
      [418086] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 677.96958963011,
        ["y"] = -112.32324345384,
        ["g"] = 7,
        ["sublevel"] = 1,
        ["scale"] = 1.9,
      },
      [2] = {
        ["x"] = 716.06879551031,
        ["y"] = -184.80168363487,
        ["g"] = 11,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
    },
  },
  [6] = {
    ["name"] = "Temporal Fusion",
    ["id"] = 206068,
    ["count"] = 2,
    ["health"] = 933109,
    ["scale"] = 1,
    ["displayId"] = 41677,
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
      [413487] = {
      },
      [413489] = {
      },
      [418085] = {
      },
      [418086] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 640.86017734816,
        ["y"] = -199.87664781385,
        ["g"] = 9,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
      [2] = {
        ["x"] = 625.80129645319,
        ["y"] = -188.99228201712,
        ["g"] = 9,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
      [3] = {
        ["x"] = 705.51954482344,
        ["y"] = -88.948214258716,
        ["g"] = 14,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
      [4] = {
        ["x"] = 640.56586750068,
        ["y"] = -99.141659598692,
        ["g"] = 16,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
    },
  },
  [7] = {
    ["name"] = "Temporal Deviation",
    ["id"] = 206063,
    ["count"] = 0,
    ["health"] = 325848,
    ["scale"] = 1,
    ["displayId"] = 88582,
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
      [413473] = {
      },
      [413474] = {
      },
      [418085] = {
      },
      [418086] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 649.51128382446,
        ["y"] = -187.80251265549,
        ["g"] = 9,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [2] = {
        ["x"] = 637.25592557741,
        ["y"] = -175.71380058948,
        ["g"] = 9,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [3] = {
        ["x"] = 635.86220390436,
        ["y"] = -108.32970138969,
        ["g"] = 16,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [4] = {
        ["x"] = 650.75339911256,
        ["y"] = -99.707791428158,
        ["g"] = 16,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
    },
  },
  [8] = {
    ["name"] = "Coalesced Moment",
    ["id"] = 206064,
    ["count"] = 2,
    ["health"] = 1007165,
    ["scale"] = 1,
    ["displayId"] = 113072,
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
      [415435] = {
      },
      [415436] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 638.35100089692,
        ["y"] = -186.62667258825,
        ["g"] = 9,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
      [2] = {
        ["x"] = 710.29636974958,
        ["y"] = -197.04871144701,
        ["g"] = 11,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
      [3] = {
        ["x"] = 723.18426411096,
        ["y"] = -192.77849435211,
        ["g"] = 11,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
      [4] = {
        ["x"] = 627.26076486725,
        ["y"] = -98.824334996438,
        ["g"] = 16,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
      [5] = {
        ["x"] = 646.62002380143,
        ["y"] = -88.527432648489,
        ["g"] = 16,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
    },
  },
  [9] = {
    ["name"] = "Timestream Leech",
    ["id"] = 206066,
    ["count"] = 3,
    ["health"] = 1184900,
    ["scale"] = 1,
    ["displayId"] = 78855,
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
      [415437] = {
      },
      [415438] = {
      },
      [415439] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 680.6538847977,
        ["y"] = -201.96976996049,
        ["g"] = 10,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
      [2] = {
        ["x"] = 673.1076088835,
        ["y"] = -211.8096431531,
        ["g"] = 10,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
      [3] = {
        ["x"] = 726.96156887773,
        ["y"] = -213.54637965322,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
        ["patrol"] = {
          [1] = {
            ["x"] = 726.96156887773,
            ["y"] = -213.54637965322,
          },
          [2] = {
            ["x"] = 709.49124986563,
            ["y"] = -216.96301537844,
          },
          [3] = {
            ["x"] = 695.36411479021,
            ["y"] = -214.74305020717,
          },
          [4] = {
            ["x"] = 684.86968148963,
            ["y"] = -210.90854706441,
          },
          [5] = {
            ["x"] = 695.36411479021,
            ["y"] = -214.74305020717,
          },
          [6] = {
            ["x"] = 709.49124986563,
            ["y"] = -216.96301537844,
          },
          [7] = {
            ["x"] = 726.96156887773,
            ["y"] = -213.54637965322,
          },
          [8] = {
            ["x"] = 733.91095913368,
            ["y"] = -207.67947112146,
          },
          [9] = {
            ["x"] = 739.96543899571,
            ["y"] = -196.781423537,
          },
          [10] = {
            ["x"] = 741.17633958732,
            ["y"] = -180.83796067019,
          },
          [11] = {
            ["x"] = 739.96543899571,
            ["y"] = -196.781423537,
          },
          [12] = {
            ["x"] = 733.91095913368,
            ["y"] = -207.67947112146,
          },
        },
      },
      [4] = {
        ["x"] = 736.32714460568,
        ["y"] = -162.72922057591,
        ["g"] = 12,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
      [5] = {
        ["x"] = 742.23286758815,
        ["y"] = -172.98357247816,
        ["g"] = 12,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
      [6] = {
        ["x"] = 736.47281710918,
        ["y"] = -126.64038027402,
        ["g"] = 13,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
      [7] = {
        ["x"] = 716.97440559513,
        ["y"] = -100.05396088412,
        ["g"] = 14,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
      [8] = {
        ["x"] = 687.21399828053,
        ["y"] = -73.235986312067,
        ["g"] = 15,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
      [9] = {
        ["x"] = 674.39357006534,
        ["y"] = -72.652294255383,
        ["g"] = 15,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
      [10] = {
        ["x"] = 639.97862365526,
        ["y"] = -68.216095560713,
        ["g"] = 17,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
      [11] = {
        ["x"] = 627.53720503027,
        ["y"] = -70.947139706125,
        ["g"] = 17,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
    },
  },
  [10] = {
    ["name"] = "Coalesced Time",
    ["id"] = 206140,
    ["count"] = 12,
    ["health"] = 2221688,
    ["scale"] = 1,
    ["displayId"] = 113073,
    ["creatureType"] = "Elemental",
    ["level"] = 71,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [413219] = {
      },
      [415554] = {
      },
      [415769] = {
      },
      [415770] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 678.3150696462,
        ["y"] = -180.13188199112,
        ["g"] = 8,
        ["sublevel"] = 1,
        ["scale"] = 1.9,
      },
      [2] = {
        ["x"] = 704.47982652532,
        ["y"] = -103.1533254905,
        ["g"] = 14,
        ["sublevel"] = 1,
        ["scale"] = 1.9,
      },
    },
  },
  [11] = {
    ["name"] = "Manifested Timeways",
    ["id"] = 198996,
    ["count"] = 0,
    ["health"] = 10375700,
    ["scale"] = 1,
    ["displayId"] = 113190,
    ["creatureType"] = "Aberration",
    ["level"] = 72,
    ["isBoss"] = true,
    ["encounterID"] = 2528,
    ["instanceID"] = 1209,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [403910] = {
      },
      [403912] = {
      },
      [404141] = {
      },
      [404650] = {
      },
      [405431] = {
      },
      [405448] = {
      },
      [405478] = {
      },
      [405671] = {
      },
      [405672] = {
      },
      [405696] = {
      },
      [413329] = {
      },
      [413332] = {
      },
      [414032] = {
      },
      [415359] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 678.41841935863,
        ["y"] = -145.71637116967,
        ["g"] = 18,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
    },
  },
  [12] = {
    ["name"] = "Infinite Infiltrator",
    ["id"] = 206214,
    ["count"] = 20,
    ["health"] = 3776869,
    ["scale"] = 1,
    ["stealthDetect"] = true,
    ["displayId"] = 113582,
    ["creatureType"] = "Dragonkin",
    ["level"] = 71,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Mind Soothe"] = true,
    },
    ["spells"] = {
      [413618] = {
      },
      [413621] = {
      },
      [413622] = {
      },
      [413623] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 162.86725936616,
        ["y"] = -392.40020091883,
        ["g"] = 19,
        ["sublevel"] = 1,
        ["scale"] = 2.3,
      },
    },
  },
  [13] = {
    ["name"] = "Blight Chunk",
    ["id"] = 204536,
    ["count"] = 1,
    ["health"] = 444338,
    ["scale"] = 1,
    ["displayId"] = 95785,
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
      [412695] = {
      },
      [412699] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 482.4527735089,
        ["y"] = -261.72355818448,
        ["g"] = 20,
        ["sublevel"] = 1,
        ["scale"] = 0.8,
      },
      [2] = {
        ["x"] = 489.59236395365,
        ["y"] = -258.88423939054,
        ["g"] = 20,
        ["sublevel"] = 1,
        ["scale"] = 0.8,
      },
      [3] = {
        ["x"] = 496.89544258313,
        ["y"] = -259.14532566102,
        ["g"] = 20,
        ["sublevel"] = 1,
        ["scale"] = 0.8,
      },
      [4] = {
        ["x"] = 495.32111187206,
        ["y"] = -277.24226886813,
        ["g"] = 20,
        ["sublevel"] = 1,
        ["scale"] = 0.8,
      },
      [5] = {
        ["x"] = 476.36798986824,
        ["y"] = -264.35090941308,
        ["g"] = 20,
        ["sublevel"] = 1,
        ["scale"] = 0.8,
      },
      [6] = {
        ["x"] = 483.09973849175,
        ["y"] = -286.10307074032,
        ["g"] = 20,
        ["sublevel"] = 1,
        ["scale"] = 0.8,
      },
      [7] = {
        ["x"] = 500.86282647717,
        ["y"] = -283.4921544078,
        ["g"] = 20,
        ["sublevel"] = 1,
        ["scale"] = 0.8,
      },
      [8] = {
        ["x"] = 487.55569107305,
        ["y"] = -275.33290376677,
        ["g"] = 20,
        ["sublevel"] = 1,
        ["scale"] = 0.8,
      },
      [9] = {
        ["x"] = 484.30053874175,
        ["y"] = -267.74499686155,
        ["g"] = 20,
        ["sublevel"] = 1,
        ["scale"] = 0.8,
      },
      [10] = {
        ["x"] = 493.88806906743,
        ["y"] = -271.71039061265,
        ["g"] = 20,
        ["sublevel"] = 1,
        ["scale"] = 0.8,
      },
      [11] = {
        ["x"] = 491.62845482967,
        ["y"] = -265.81946971984,
        ["g"] = 20,
        ["sublevel"] = 1,
        ["scale"] = 0.8,
      },
      [12] = {
        ["x"] = 498.9802838105,
        ["y"] = -265.59094672647,
        ["g"] = 20,
        ["sublevel"] = 1,
        ["scale"] = 0.8,
      },
      [13] = {
        ["x"] = 488.62690533687,
        ["y"] = -282.48042291395,
        ["g"] = 20,
        ["sublevel"] = 1,
        ["scale"] = 0.8,
      },
      [14] = {
        ["x"] = 495.26065616476,
        ["y"] = -282.88831416104,
        ["g"] = 20,
        ["sublevel"] = 1,
        ["scale"] = 0.8,
      },
      [15] = {
        ["x"] = 490.12235406861,
        ["y"] = -328.48509821134,
        ["g"] = 21,
        ["sublevel"] = 1,
        ["scale"] = 0.8,
      },
      [16] = {
        ["x"] = 487.27540961494,
        ["y"] = -321.23979673439,
        ["g"] = 21,
        ["sublevel"] = 1,
        ["scale"] = 0.8,
      },
      [17] = {
        ["x"] = 504.62761962949,
        ["y"] = -339.90542665484,
        ["g"] = 21,
        ["sublevel"] = 1,
        ["scale"] = 0.8,
      },
      [18] = {
        ["x"] = 499.82501692799,
        ["y"] = -347.34899096242,
        ["g"] = 21,
        ["sublevel"] = 1,
        ["scale"] = 0.8,
      },
      [19] = {
        ["x"] = 485.79982679413,
        ["y"] = -335.1266522609,
        ["g"] = 21,
        ["sublevel"] = 1,
        ["scale"] = 0.8,
      },
      [20] = {
        ["x"] = 504.98255154408,
        ["y"] = -332.46675977779,
        ["g"] = 21,
        ["sublevel"] = 1,
        ["scale"] = 0.8,
      },
      [21] = {
        ["x"] = 485.65398511953,
        ["y"] = -346.94096679189,
        ["g"] = 21,
        ["sublevel"] = 1,
        ["scale"] = 0.8,
      },
      [22] = {
        ["x"] = 500.03912108918,
        ["y"] = -335.19188203401,
        ["g"] = 21,
        ["sublevel"] = 1,
        ["scale"] = 0.8,
      },
      [23] = {
        ["x"] = 496.70263831825,
        ["y"] = -341.47440944041,
        ["g"] = 21,
        ["sublevel"] = 1,
        ["scale"] = 0.8,
      },
      [24] = {
        ["x"] = 482.17152214229,
        ["y"] = -328.4360655443,
        ["g"] = 21,
        ["sublevel"] = 1,
        ["scale"] = 0.8,
      },
      [25] = {
        ["x"] = 497.19303511378,
        ["y"] = -328.15875944872,
        ["g"] = 21,
        ["sublevel"] = 1,
        ["scale"] = 0.8,
      },
      [26] = {
        ["x"] = 493.72582532153,
        ["y"] = -334.84919691897,
        ["g"] = 21,
        ["sublevel"] = 1,
        ["scale"] = 0.8,
      },
      [27] = {
        ["x"] = 489.50811057085,
        ["y"] = -341.09903518426,
        ["g"] = 21,
        ["sublevel"] = 1,
        ["scale"] = 0.8,
      },
      [28] = {
        ["x"] = 502.88123149768,
        ["y"] = -325.85784780504,
        ["g"] = 21,
        ["sublevel"] = 1,
        ["scale"] = 0.8,
      },
      [29] = {
        ["x"] = 492.22733652926,
        ["y"] = -346.96089685444,
        ["g"] = 21,
        ["sublevel"] = 1,
        ["scale"] = 0.8,
      },
    },
  },
  [14] = {
    ["name"] = "Risen Dragon",
    ["id"] = 205804,
    ["count"] = 15,
    ["health"] = 2962250,
    ["scale"] = 1,
    ["displayId"] = 112683,
    ["creatureType"] = "Undead",
    ["level"] = 70,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [412695] = {
      },
      [412806] = {
      },
      [412810] = {
      },
      [416267] = {
      },
      [417404] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 475.42648509659,
        ["y"] = -276.40995891916,
        ["g"] = 20,
        ["sublevel"] = 1,
        ["scale"] = 1.9,
      },
      [2] = {
        ["x"] = 507.07616321294,
        ["y"] = -275.59413899569,
        ["g"] = 20,
        ["sublevel"] = 1,
        ["scale"] = 1.9,
      },
      [3] = {
        ["x"] = 497.92924256954,
        ["y"] = -315.2345987009,
        ["g"] = 21,
        ["sublevel"] = 1,
        ["scale"] = 1.9,
      },
      [4] = {
        ["x"] = 476.02994843342,
        ["y"] = -339.90818007823,
        ["g"] = 21,
        ["sublevel"] = 1,
        ["scale"] = 1.9,
      },
    },
  },
  [15] = {
    ["name"] = "Blight of Galakrond",
    ["id"] = 198997,
    ["count"] = 0,
    ["health"] = 14822428,
    ["scale"] = 1,
    ["displayId"] = 112066,
    ["creatureType"] = "Aberration",
    ["level"] = 72,
    ["isBoss"] = true,
    ["encounterID"] = 2535,
    ["instanceID"] = 1209,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [406886] = {
      },
      [407057] = {
      },
      [407147] = {
      },
      [407159] = {
      },
      [407406] = {
      },
      [407413] = {
      },
      [407714] = {
      },
      [415097] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 533.59702426232,
        ["y"] = -331.79283534694,
        ["g"] = 22,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
    },
  },
  [16] = {
    ["name"] = "Ahnzon",
    ["id"] = 201792,
    ["count"] = 0,
    ["health"] = 14822428,
    ["scale"] = 1,
    ["displayId"] = 112232,
    ["creatureType"] = "Undead",
    ["level"] = 72,
    ["isBoss"] = true,
    ["encounterID"] = 2535,
    ["instanceID"] = 0,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [406886] = {
      },
      [407057] = {
      },
      [407147] = {
      },
      [407159] = {
      },
      [407406] = {
      },
      [407413] = {
      },
      [407714] = {
      },
      [407978] = {
      },
      [408008] = {
      },
      [415114] = {
      },
      [415254] = {
      },
      [418348] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 543.84940259799,
        ["y"] = -348.1989995823,
        ["g"] = 22,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
    },
  },
  [17] = {
    ["name"] = "Dazhak",
    ["id"] = 201788,
    ["count"] = 0,
    ["health"] = 14822428,
    ["scale"] = 1,
    ["displayId"] = 113421,
    ["creatureType"] = "Undead",
    ["level"] = 72,
    ["isBoss"] = true,
    ["encounterID"] = 2535,
    ["instanceID"] = 0,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [408141] = {
      },
      [408177] = {
      },
      [413590] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 543.78561585166,
        ["y"] = -315.5168279902,
        ["g"] = 22,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
    },
  },
  [18] = {
    ["name"] = "Loszkeleth",
    ["id"] = 201790,
    ["count"] = 0,
    ["health"] = 14822428,
    ["scale"] = 1,
    ["displayId"] = 113420,
    ["creatureType"] = "Undead",
    ["level"] = 72,
    ["isBoss"] = true,
    ["encounterID"] = 2535,
    ["instanceID"] = 0,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [5760] = {
      },
      [45524] = {
      },
      [406886] = {
      },
      [407057] = {
      },
      [407147] = {
      },
      [407159] = {
      },
      [407406] = {
      },
      [407413] = {
      },
      [407714] = {
      },
      [408029] = {
      },
      [418348] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 553.04029934269,
        ["y"] = -332.00131846281,
        ["g"] = 22,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
    },
  },
  [19] = {
    ["name"] = "Iridikron's Creation",
    ["id"] = 205691,
    ["count"] = 5,
    ["health"] = 1481125,
    ["scale"] = 1,
    ["displayId"] = 73034,
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
      [411958] = {
      },
      [412285] = {
      },
      [416254] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 465.3728373522,
        ["y"] = -446.30708378629,
        ["g"] = 23,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
      [2] = {
        ["x"] = 458.33356208204,
        ["y"] = -482.2198938866,
        ["g"] = 24,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
      [3] = {
        ["x"] = 486.19086527399,
        ["y"] = -525.76287907211,
        ["g"] = 25,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
      [4] = {
        ["x"] = 477.63478594259,
        ["y"] = -537.54508421747,
        ["g"] = 25,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
      [5] = {
        ["x"] = 512.12201797425,
        ["y"] = -529.98432405112,
        ["g"] = 26,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
    },
  },
  [20] = {
    ["name"] = "Iridikron",
    ["id"] = 198933,
    ["count"] = 0,
    ["health"] = 118579424,
    ["scale"] = 1,
    ["displayId"] = 113502,
    ["creatureType"] = "Dragonkin",
    ["level"] = 72,
    ["isBoss"] = true,
    ["encounterID"] = 2537,
    ["instanceID"] = 1209,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Mind Soothe"] = true,
    },
    ["spells"] = {
      [409261] = {
      },
      [409266] = {
      },
      [409268] = {
      },
      [409287] = {
      },
      [409456] = {
      },
      [409558] = {
      },
      [409584] = {
      },
      [409635] = {
      },
      [409879] = {
      },
      [409884] = {
      },
      [414177] = {
      },
      [414184] = {
      },
      [414300] = {
      },
      [414376] = {
      },
      [414483] = {
      },
      [414535] = {
      },
      [414583] = {
      },
      [414604] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 572.57847521301,
        ["y"] = -536.4708933621,
        ["g"] = 27,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
    },
  },
  [21] = {
    ["name"] = "Chromie",
    ["id"] = 204449,
    ["count"] = 0,
    ["health"] = 19254625,
    ["scale"] = 1,
    ["displayId"] = 112234,
    ["creatureType"] = "Dragonkin",
    ["level"] = 72,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Mind Soothe"] = true,
    },
    ["spells"] = {
      [414178] = {
      },
      [414293] = {
      },
      [414330] = {
      },
      [414333] = {
      },
      [414353] = {
      },
      [414496] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 552.23186920639,
        ["y"] = -513.39812252993,
        ["g"] = 27,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
    },
  },
  [22] = {
    ["name"] = "Iridikron's Creation",
    ["id"] = 204918,
    ["count"] = 0,
    ["health"] = 123427,
    ["scale"] = 1,
    ["displayId"] = 73034,
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
      [416256] = {
      },
      [416257] = {
      },
      [416258] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 569.96750481706,
        ["y"] = -511.38047275803,
        ["g"] = 27,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
      [2] = {
        ["x"] = 585.49470670982,
        ["y"] = -521.04088095738,
        ["g"] = 27,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
    },
  },
};
