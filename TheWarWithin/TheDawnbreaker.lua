local addonName = ...
local MDT = MDT
local L = MDT.L

local dungeonIndex = 111
MDT.dungeonList[dungeonIndex] = L["The Dawnbreaker"]
MDT.mapInfo[dungeonIndex] = {
  teleportId = 445414,
  shortName = L["dawnBreakerShortName"],
  englishName = "The Dawnbreaker",
  mapID = 505
}

local zones = { 2215, 2215, 2359 } -- TODO remove 2215 WHEN DAWNBREAKER IS GONE FROM ROTATION
for _, zone in ipairs(zones) do
  MDT.zoneIdToDungeonIdx[zone] = dungeonIndex
end

MDT.dungeonMaps[dungeonIndex] = {
  [0] = "",
  [1] = { customTextures = 'Interface\\AddOns\\'..addonName..'\\TheWarWithin\\Textures\\Dawnbreaker' }
}

MDT.dungeonSubLevels[dungeonIndex] = {
  [1] = L["The Dawnbreaker"]
}

MDT.dungeonTotalCount[dungeonIndex] = { normal = 460, teeming = 1000, teemingEnabled = true }

MDT.mapPOIs[dungeonIndex] = {
  [1] = {
    [1] = {
      ["template"] = "MapLinkPinTemplate",
      ["type"] = "dungeonEntrance",
      ["x"] = 594.33722436621,
      ["y"] = -518.43239200431,
    },
  },
};

MDT.dungeonEnemies[dungeonIndex] = {
  [1] = {
    ["name"] = "Nightfall Curseblade",
    ["id"] = 213894,
    ["count"] = 0,
    ["health"] = 20885902,
    ["scale"] = 1.3,
    ["displayId"] = 115528,
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
      [431493] = {
        ["magic"] = true,
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 643.7891985943,
        ["y"] = -445.5955983436,
        ["g"] = 1,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 658.52920063357,
        ["y"] = -423.17826997093,
        ["g"] = 1,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 678.61565842672,
        ["y"] = -440.48413192566,
        ["g"] = 1,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 657.22739904375,
        ["y"] = -197.35702659426,
        ["g"] = 3,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 608.42569680819,
        ["y"] = -174.2717976097,
        ["g"] = 4,
        ["sublevel"] = 1,
      },
      [6] = {
        ["x"] = 626.99819357193,
        ["y"] = -156.69881527297,
        ["g"] = 4,
        ["sublevel"] = 1,
      },
      [7] = {
        ["x"] = 716.19439711502,
        ["y"] = -92.787929625161,
        ["g"] = 5,
        ["sublevel"] = 1,
      },
      [8] = {
        ["x"] = 736.83749396656,
        ["y"] = -108.46493257059,
        ["g"] = 5,
        ["sublevel"] = 1,
      },
      [9] = {
        ["x"] = 577.5176527807,
        ["y"] = -268.62884147108,
        ["g"] = 6,
        ["sublevel"] = 1,
      },
      [10] = {
        ["x"] = 16.922242950255,
        ["y"] = -151.75083531668,
        ["g"] = 32,
        ["sublevel"] = 1,
      },
      [11] = {
        ["x"] = 58.146458414675,
        ["y"] = -216.82291738734,
        ["g"] = 17,
        ["sublevel"] = 1,
      },
      [12] = {
        ["x"] = 244.66971736573,
        ["y"] = -359.39473139546,
        ["g"] = 36,
        ["sublevel"] = 1,
      },
      [13] = {
        ["x"] = 277.28006198439,
        ["y"] = -397.01512571507,
        ["g"] = 46,
        ["sublevel"] = 1,
      },
    },
  },
  [2] = {
    ["name"] = "Nightfall Shadowmage",
    ["id"] = 213892,
    ["count"] = 5,
    ["health"] = 17902202,
    ["scale"] = 1.3,
    ["displayId"] = 115523,
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
      [431303] = {
        ["interruptible"] = true,
      },
      [431309] = {
        ["interruptible"] = true,
        ["curse"] = true,
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 660.4955062504,
        ["y"] = -459.19086943476,
        ["g"] = 1,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 667.95423348102,
        ["y"] = -432.41993910021,
        ["g"] = 1,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 637.34953118629,
        ["y"] = -180.81578612314,
        ["g"] = 3,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 718.35881445384,
        ["y"] = -112.11699477461,
        ["g"] = 5,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 208.69376015096,
        ["y"] = -351.67252410374,
        ["g"] = 35,
        ["sublevel"] = 1,
      },
      [6] = {
        ["x"] = 238.75593229031,
        ["y"] = -349.16925030321,
        ["g"] = 36,
        ["sublevel"] = 1,
      },
      [7] = {
        ["x"] = 53.239666437928,
        ["y"] = -206.21951709087,
        ["g"] = 17,
        ["sublevel"] = 1,
      },
      [8] = {
        ["x"] = 246.23270722923,
        ["y"] = -435.82976769389,
        ["g"] = 42,
        ["sublevel"] = 1,
      },
    },
  },
  [3] = {
    ["name"] = "Nightfall Ritualist",
    ["id"] = 214761,
    ["count"] = 12,
    ["health"] = 33815270,
    ["scale"] = 1.4,
    ["stealthDetect"] = true,
    ["displayId"] = 115526,
    ["creatureType"] = "Humanoid",
    ["level"] = 80,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Slow"] = true,
      ["Mind Soothe"] = true,
    },
    ["spells"] = {
      [431364] = {
      },
      [431365] = {
      },
      [432448] = {
        ["magic"] = true,
      },
      [432454] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 658.46383109568,
        ["y"] = -443.57571592443,
        ["g"] = 1,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 618.06191548258,
        ["y"] = -165.79015776653,
        ["g"] = 4,
        ["sublevel"] = 1,
      },
    },
  },
  [4] = {
    ["name"] = "Nightfall Commander",
    ["id"] = 214762,
    ["count"] = 12,
    ["health"] = 33815270,
    ["scale"] = 1.4,
    ["stealthDetect"] = true,
    ["displayId"] = 115535,
    ["creatureType"] = "Humanoid",
    ["level"] = 80,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Slow"] = true,
      ["Mind Soothe"] = true,
    },
    ["spells"] = {
      [431491] = {
        ["bleed"] = true,
      },
      [450756] = {
        ["interruptible"] = true,
        ["magic"] = true,
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 647.76769656922,
        ["y"] = -189.78819243382,
        ["g"] = 3,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 565.39533581353,
        ["y"] = -271.52883944209,
        ["g"] = 6,
        ["sublevel"] = 1,
      },
    },
  },
  [5] = {
    ["name"] = "Sureki Webmage",
    ["id"] = 210966,
    ["count"] = 12,
    ["health"] = 39782670,
    ["scale"] = 1.4,
    ["stealthDetect"] = true,
    ["displayId"] = 117315,
    ["creatureType"] = "Humanoid",
    ["level"] = 80,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Slow"] = true,
      ["Mind Soothe"] = true,
    },
    ["spells"] = {
      [451104] = {
      },
      [451107] = {
      },
      [451113] = {
        ["interruptible"] = true,
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 726.12906551791,
        ["y"] = -100.85671816945,
        ["g"] = 5,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 575.75000838754,
        ["y"] = -282.15576990657,
        ["g"] = 6,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 390.43262700593,
        ["y"] = -121.75342586078,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 430.96167826859,
        ["y"] = -195.30225063195,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 239.40909147817,
        ["y"] = -251.98079421328,
        ["sublevel"] = 1,
      },
    },
  },
  [6] = {
    ["name"] = "Nightfall Darkcaster",
    ["id"] = 213893,
    ["count"] = 5,
    ["health"] = 18896768,
    ["scale"] = 1.3,
    ["displayId"] = 115520,
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
      [431333] = {
        ["interruptible"] = true,
      },
      [432520] = {
        ["interruptible"] = true,
      },
    },
    ["clones"] = {
      [2] = {
        ["x"] = 367.24319296367,
        ["y"] = -173.67920079313,
        ["g"] = 49,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 367.17463222399,
        ["y"] = -185.40193423017,
        ["g"] = 49,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 213.91090391426,
        ["y"] = -198.10571875243,
        ["g"] = 26,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 152.28250478887,
        ["y"] = -321.17410900901,
        ["g"] = 33,
        ["sublevel"] = 1,
      },
      [6] = {
        ["x"] = 143.93923785199,
        ["y"] = -313.08354219332,
        ["g"] = 33,
        ["sublevel"] = 1,
      },
      [7] = {
        ["x"] = 54.686558008175,
        ["y"] = -116.02205488386,
        ["g"] = 15,
        ["sublevel"] = 1,
      },
      [8] = {
        ["x"] = 189.13574726654,
        ["y"] = -159.47210828755,
        ["g"] = 25,
        ["sublevel"] = 1,
      },
      [9] = {
        ["x"] = 159.3474764728,
        ["y"] = -194.77238932089,
        ["g"] = 22,
        ["sublevel"] = 1,
      },
      [10] = {
        ["x"] = 143.50464900102,
        ["y"] = -214.65044965882,
        ["g"] = 20,
        ["sublevel"] = 1,
      },
      [11] = {
        ["x"] = 120.52496916705,
        ["y"] = -193.96320401032,
        ["g"] = 21,
        ["sublevel"] = 1,
      },
      [12] = {
        ["x"] = 125.88263990547,
        ["y"] = -205.54572357393,
        ["g"] = 21,
        ["sublevel"] = 1,
      },
      [13] = {
        ["x"] = 97.305132199031,
        ["y"] = -199.54100187322,
        ["g"] = 18,
        ["sublevel"] = 1,
      },
      [14] = {
        ["x"] = 62.042910505465,
        ["y"] = -157.28870315497,
        ["g"] = 16,
        ["sublevel"] = 1,
      },
      [17] = {
        ["x"] = 17.266500468957,
        ["y"] = -164.67861756171,
        ["g"] = 32,
        ["sublevel"] = 1,
      },
      [18] = {
        ["x"] = 243.57135308113,
        ["y"] = -132.27168506716,
        ["g"] = 11,
        ["sublevel"] = 1,
      },
      [19] = {
        ["x"] = 243.428033632,
        ["y"] = -108.95023625365,
        ["g"] = 11,
        ["sublevel"] = 1,
      },
      [20] = {
        ["x"] = 309.5435516501,
        ["y"] = -94.676435586104,
        ["g"] = 10,
        ["sublevel"] = 1,
      },
      [21] = {
        ["x"] = 297.97773085408,
        ["y"] = -106.85367243299,
        ["g"] = 10,
        ["sublevel"] = 1,
      },
      [22] = {
        ["x"] = 298.17090256489,
        ["y"] = -95.251018746383,
        ["g"] = 10,
        ["sublevel"] = 1,
      },
      [23] = {
        ["x"] = 350.34175101148,
        ["y"] = -111.13559009188,
        ["g"] = 9,
        ["sublevel"] = 1,
      },
      [24] = {
        ["x"] = 278.08770869262,
        ["y"] = -268.70038701998,
        ["g"] = 31,
        ["sublevel"] = 1,
      },
      [25] = {
        ["x"] = 161.02281260675,
        ["y"] = -275.00420874032,
        ["g"] = 30,
        ["sublevel"] = 1,
      },
      [26] = {
        ["x"] = 198.9142279029,
        ["y"] = -328.92661847885,
        ["g"] = 34,
        ["sublevel"] = 1,
      },
      [28] = {
        ["x"] = 219.320092736,
        ["y"] = -348.98324106416,
        ["g"] = 35,
        ["sublevel"] = 1,
      },
      [30] = {
        ["x"] = 250.35305419502,
        ["y"] = -349.4320807441,
        ["g"] = 36,
        ["sublevel"] = 1,
      },
      [31] = {
        ["x"] = 316.78158754648,
        ["y"] = -358.06909235405,
        ["g"] = 38,
        ["sublevel"] = 1,
      },
      [32] = {
        ["x"] = 327.26616378318,
        ["y"] = -357.80275564039,
        ["g"] = 38,
        ["sublevel"] = 1,
      },
      [33] = {
        ["x"] = 322.34700738673,
        ["y"] = -367.65953553043,
        ["g"] = 38,
        ["sublevel"] = 1,
      },
      [34] = {
        ["x"] = 336.16551925009,
        ["y"] = -391.31601934274,
        ["g"] = 39,
        ["sublevel"] = 1,
      },
      [35] = {
        ["x"] = 215.88335206173,
        ["y"] = -420.66090374661,
        ["g"] = 43,
        ["sublevel"] = 1,
      },
      [36] = {
        ["x"] = 141.39041413672,
        ["y"] = -95.250678961263,
        ["g"] = 12,
        ["sublevel"] = 1,
      },
      [37] = {
        ["x"] = 226.4120615999,
        ["y"] = -397.51238519967,
        ["g"] = 44,
        ["sublevel"] = 1,
      },
      [38] = {
        ["x"] = 226.33690257049,
        ["y"] = -385.19401717698,
        ["g"] = 44,
        ["sublevel"] = 1,
      },
      [39] = {
        ["x"] = 249.55298525863,
        ["y"] = -392.82892117391,
        ["g"] = 45,
        ["sublevel"] = 1,
      },
      [40] = {
        ["x"] = 253.21370879825,
        ["y"] = -385.0073368203,
        ["g"] = 45,
        ["sublevel"] = 1,
      },
    },
  },
  [7] = {
    ["name"] = "Nightfall Shadowalker",
    ["id"] = 213895,
    ["count"] = 5,
    ["health"] = 19891335,
    ["scale"] = 1.2,
    ["displayId"] = 115530,
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
      [431637] = {
      },
      [431638] = {
      },
      [431660] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 162.5624087387,
        ["y"] = -138.84479470037,
        ["g"] = 24,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 154.86873007846,
        ["y"] = -130.93873673359,
        ["g"] = 24,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 368.61823658119,
        ["y"] = -140.56201890503,
        ["g"] = 8,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 368.70320961578,
        ["y"] = -151.92821460361,
        ["g"] = 8,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 237.49528097265,
        ["y"] = -439.9238150492,
        ["g"] = 42,
        ["sublevel"] = 1,
      },
      [6] = {
        ["x"] = 243.47605396955,
        ["y"] = -198.89814593348,
        ["g"] = 28,
        ["sublevel"] = 1,
      },
      [7] = {
        ["x"] = 243.72762163574,
        ["y"] = -186.66930930669,
        ["g"] = 28,
        ["sublevel"] = 1,
      },
      [8] = {
        ["x"] = 243.44029264389,
        ["y"] = -211.00109065238,
        ["g"] = 28,
        ["sublevel"] = 1,
      },
      [9] = {
        ["x"] = 203.85498558603,
        ["y"] = -191.282035037,
        ["g"] = 26,
        ["sublevel"] = 1,
      },
      [10] = {
        ["x"] = 203.31627501861,
        ["y"] = -203.76215577431,
        ["g"] = 26,
        ["sublevel"] = 1,
      },
      [11] = {
        ["x"] = 96.271808221599,
        ["y"] = -83.959397770407,
        ["g"] = 14,
        ["sublevel"] = 1,
      },
      [12] = {
        ["x"] = 66.057343294922,
        ["y"] = -115.72765899479,
        ["g"] = 15,
        ["sublevel"] = 1,
      },
      [13] = {
        ["x"] = 151.59165294709,
        ["y"] = -186.46460702786,
        ["g"] = 22,
        ["sublevel"] = 1,
      },
      [14] = {
        ["x"] = 135.33202544579,
        ["y"] = -222.09722033625,
        ["g"] = 20,
        ["sublevel"] = 1,
      },
      [15] = {
        ["x"] = 131.9597313944,
        ["y"] = -196.00934738998,
        ["g"] = 21,
        ["sublevel"] = 1,
        ["patrol"] = {
          [1] = {
            ["x"] = 131.9597313944,
            ["y"] = -196.00934738998,
          },
          [2] = {
            ["x"] = 137.70702594616,
            ["y"] = -188.95019322474,
          },
          [3] = {
            ["x"] = 144.06882718161,
            ["y"] = -182.58835786191,
          },
          [4] = {
            ["x"] = 137.70702594616,
            ["y"] = -188.95019322474,
          },
          [5] = {
            ["x"] = 131.9597313944,
            ["y"] = -196.00934738998,
          },
          [6] = {
            ["x"] = 121.28141954429,
            ["y"] = -198.58880562608,
          },
          [7] = {
            ["x"] = 114.13574978994,
            ["y"] = -201.42604995491,
          },
          [8] = {
            ["x"] = 103.2702243683,
            ["y"] = -209.11839337101,
          },
          [9] = {
            ["x"] = 95.599133652681,
            ["y"] = -215.63356638993,
          },
          [10] = {
            ["x"] = 87.192446375782,
            ["y"] = -222.04365160885,
          },
          [11] = {
            ["x"] = 95.599133652681,
            ["y"] = -215.63356638993,
          },
          [12] = {
            ["x"] = 103.2702243683,
            ["y"] = -209.11839337101,
          },
          [13] = {
            ["x"] = 114.13574978994,
            ["y"] = -201.42604995491,
          },
          [14] = {
            ["x"] = 121.28141954429,
            ["y"] = -198.58880562608,
          },
        },
      },
      [16] = {
        ["x"] = 147.74241365106,
        ["y"] = -152.50498506124,
        ["g"] = 23,
        ["sublevel"] = 1,
      },
      [18] = {
        ["x"] = 106.81968338432,
        ["y"] = -242.35964186646,
        ["g"] = 19,
        ["sublevel"] = 1,
      },
      [20] = {
        ["x"] = 243.70530161306,
        ["y"] = -120.81309061558,
        ["g"] = 11,
        ["sublevel"] = 1,
      },
      [21] = {
        ["x"] = 350.68786655708,
        ["y"] = -99.483849830952,
        ["g"] = 9,
        ["sublevel"] = 1,
      },
      [22] = {
        ["x"] = 361.77014194025,
        ["y"] = -111.50927783318,
        ["g"] = 9,
        ["sublevel"] = 1,
      },
      [23] = {
        ["x"] = 270.41214524034,
        ["y"] = -260.04416887009,
        ["g"] = 31,
        ["sublevel"] = 1,
      },
      [24] = {
        ["x"] = 286.4431624503,
        ["y"] = -276.38742065182,
        ["g"] = 31,
        ["sublevel"] = 1,
      },
      [25] = {
        ["x"] = 206.86342144836,
        ["y"] = -257.66445998427,
        ["g"] = 29,
        ["sublevel"] = 1,
      },
      [28] = {
        ["x"] = 283.34334601533,
        ["y"] = -386.89809925271,
        ["g"] = 46,
        ["sublevel"] = 1,
      },
      [29] = {
        ["x"] = 272.03326527105,
        ["y"] = -386.81843363109,
        ["g"] = 46,
        ["sublevel"] = 1,
      },
      [30] = {
        ["x"] = 291.1208472625,
        ["y"] = -360.56190839668,
        ["g"] = 37,
        ["sublevel"] = 1,
      },
      [31] = {
        ["x"] = 325.76208501603,
        ["y"] = -391.15634444272,
        ["g"] = 39,
        ["sublevel"] = 1,
      },
      [32] = {
        ["x"] = 356.34865971002,
        ["y"] = -404.93441322229,
        ["g"] = 40,
        ["sublevel"] = 1,
      },
      [33] = {
        ["x"] = 368.3841002033,
        ["y"] = -404.78511454712,
        ["g"] = 40,
        ["sublevel"] = 1,
      },
      [34] = {
        ["x"] = 354.51471213982,
        ["y"] = -442.81570113759,
        ["g"] = 41,
        ["sublevel"] = 1,
      },
      [35] = {
        ["x"] = 365.68874637013,
        ["y"] = -442.30871232927,
        ["g"] = 41,
        ["sublevel"] = 1,
      },
      [36] = {
        ["x"] = 209.39607021599,
        ["y"] = -412.64269337308,
        ["g"] = 43,
        ["sublevel"] = 1,
      },
      [37] = {
        ["x"] = 217.18169000221,
        ["y"] = -390.97744782544,
        ["g"] = 44,
        ["sublevel"] = 1,
        ["patrol"] = {
          [1] = {
            ["x"] = 220.34842715928,
            ["y"] = -393.91794324668,
          },
          [2] = {
            ["x"] = 212.87427400311,
            ["y"] = -389.19827383709,
          },
          [3] = {
            ["x"] = 208.12420709618,
            ["y"] = -382.86485129452,
          },
          [4] = {
            ["x"] = 207.67187893921,
            ["y"] = -378.79335428038,
          },
          [5] = {
            ["x"] = 208.12420709618,
            ["y"] = -382.86485129452,
          },
          [6] = {
            ["x"] = 212.87427400311,
            ["y"] = -389.19827383709,
          },
          [7] = {
            ["x"] = 220.34842715928,
            ["y"] = -393.91794324668,
          },
          [8] = {
            ["x"] = 230.51737595947,
            ["y"] = -395.75786045815,
          },
          [9] = {
            ["x"] = 240.01748388755,
            ["y"] = -392.13876925833,
          },
          [10] = {
            ["x"] = 246.57709639439,
            ["y"] = -385.12678976585,
          },
          [11] = {
            ["x"] = 253.8153305656,
            ["y"] = -377.43622743768,
          },
          [12] = {
            ["x"] = 253.8153305656,
            ["y"] = -366.12653508101,
          },
          [13] = {
            ["x"] = 253.8153305656,
            ["y"] = -377.43622743768,
          },
          [14] = {
            ["x"] = 246.57709639439,
            ["y"] = -385.12678976585,
          },
          [15] = {
            ["x"] = 240.01748388755,
            ["y"] = -392.13876925833,
          },
          [16] = {
            ["x"] = 230.51737595947,
            ["y"] = -395.75786045815,
          },
        },
      },
      [38] = {
        ["x"] = 62.042731047953,
        ["y"] = -168.8939491679,
        ["g"] = 16,
        ["sublevel"] = 1,
      },
      [39] = {
        ["x"] = 62.580140820162,
        ["y"] = -145.24748322525,
        ["g"] = 16,
        ["sublevel"] = 1,
      },
      [40] = {
        ["x"] = 147.89592057986,
        ["y"] = -164.13458584646,
        ["g"] = 23,
        ["sublevel"] = 1,
      },
    },
  },
  [8] = {
    ["name"] = "Manifested Shadow",
    ["id"] = 211341,
    ["count"] = 16,
    ["health"] = 27847869,
    ["scale"] = 1.4,
    ["stealthDetect"] = true,
    ["displayId"] = 117518,
    ["creatureType"] = "Elemental",
    ["level"] = 80,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Slow"] = true,
    },
    ["spells"] = {
      [431304] = {
      },
      [431305] = {
      },
      [432565] = {
      },
      [432606] = {
      },
      [453345] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 136.29116043925,
        ["y"] = -151.95319949794,
        ["g"] = 23,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 135.92696614843,
        ["y"] = -166.52967732317,
        ["g"] = 23,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 141.20958590757,
        ["y"] = -324.85620581368,
        ["g"] = 33,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 60.7347807957,
        ["y"] = -104.00019012702,
        ["g"] = 15,
        ["sublevel"] = 1,
      },
      [6] = {
        ["x"] = 179.18244696453,
        ["y"] = -152.70796741797,
        ["g"] = 25,
        ["sublevel"] = 1,
      },
      [8] = {
        ["x"] = 64.878264599688,
        ["y"] = -207.44300159047,
        ["g"] = 17,
        ["sublevel"] = 1,
      },
      [9] = {
        ["x"] = 96.030374868524,
        ["y"] = -239.29500897607,
        ["g"] = 19,
        ["sublevel"] = 1,
      },
      [10] = {
        ["x"] = 72.470023778989,
        ["y"] = -151.35664977619,
        ["g"] = 16,
        ["sublevel"] = 1,
      },
      [11] = {
        ["x"] = 27.518014477023,
        ["y"] = -157.50118118879,
        ["g"] = 32,
        ["sublevel"] = 1,
      },
      [13] = {
        ["x"] = 230.46112913607,
        ["y"] = -220.96442783552,
        ["g"] = 27,
        ["sublevel"] = 1,
      },
      [14] = {
        ["x"] = 195.88990493425,
        ["y"] = -261.55128095247,
        ["g"] = 29,
        ["sublevel"] = 1,
      },
      [15] = {
        ["x"] = 205.43954897323,
        ["y"] = -269.83735632244,
        ["g"] = 29,
        ["sublevel"] = 1,
      },
      [16] = {
        ["x"] = 187.90694666126,
        ["y"] = -328.86290232033,
        ["g"] = 34,
        ["sublevel"] = 1,
      },
      [17] = {
        ["x"] = 360.60378676103,
        ["y"] = -453.70259956795,
        ["g"] = 41,
        ["sublevel"] = 1,
      },
      [18] = {
        ["x"] = 145.28275981031,
        ["y"] = -84.270539182607,
        ["g"] = 12,
        ["sublevel"] = 1,
      },
    },
  },
  [9] = {
    ["name"] = "Sureki Militant",
    ["id"] = 213932,
    ["count"] = 12,
    ["health"] = 35835879,
    ["scale"] = 1.8,
    ["stealthDetect"] = true,
    ["displayId"] = 116834,
    ["creatureType"] = "Humanoid",
    ["level"] = 80,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Mind Soothe"] = true,
    },
    ["spells"] = {
      [451097] = {
        ["magic"] = true,
      },
      [451098] = {
      },
      [451099] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 241.95879565513,
        ["y"] = -538.86080481078,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 383.12322682498,
        ["y"] = -207.04518139819,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 200.9320540315,
        ["y"] = -233.38978976507,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 213.33091298096,
        ["y"] = -306.92780395637,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 131.74278522917,
        ["y"] = -366.91716295949,
        ["sublevel"] = 1,
      },
      [6] = {
        ["x"] = 309.07629592254,
        ["y"] = -342.26754195705,
        ["sublevel"] = 1,
      },
    },
  },
  [10] = {
    ["name"] = "Nightfall Tactician",
    ["id"] = 213934,
    ["count"] = 10,
    ["health"] = 33815270,
    ["scale"] = 1.3,
    ["stealthDetect"] = true,
    ["displayId"] = 115534,
    ["creatureType"] = "Humanoid",
    ["level"] = 80,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Slow"] = true,
      ["Mind Soothe"] = true,
    },
    ["spells"] = {
      [431494] = {
        ["magic"] = true,
      },
      [451112] = {
        ["enrage"] = true,
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 387.02533791475,
        ["y"] = -159.99755566887,
        ["g"] = 7,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 386.98534257558,
        ["y"] = -171.8033405698,
        ["g"] = 7,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 245.68727966898,
        ["y"] = -446.68960809765,
        ["g"] = 42,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 254.08859875022,
        ["y"] = -193.56482040583,
        ["g"] = 28,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 254.95922427507,
        ["y"] = -206.67902417618,
        ["g"] = 28,
        ["sublevel"] = 1,
      },
      [6] = {
        ["x"] = 99.65882713801,
        ["y"] = -73.020876357431,
        ["g"] = 14,
        ["sublevel"] = 1,
      },
      [7] = {
        ["x"] = 107.65488683912,
        ["y"] = -81.771221031528,
        ["g"] = 14,
        ["sublevel"] = 1,
      },
      [9] = {
        ["x"] = 179.30147069928,
        ["y"] = -164.9489324029,
        ["g"] = 25,
        ["sublevel"] = 1,
      },
      [10] = {
        ["x"] = 88.329165237211,
        ["y"] = -207.32595074236,
        ["g"] = 18,
        ["sublevel"] = 1,
      },
      [11] = {
        ["x"] = 98.658175272593,
        ["y"] = -250.82267343867,
        ["g"] = 19,
        ["sublevel"] = 1,
      },
      [13] = {
        ["x"] = 253.53651852142,
        ["y"] = -114.33786617785,
        ["g"] = 11,
        ["sublevel"] = 1,
      },
      [14] = {
        ["x"] = 253.70739254561,
        ["y"] = -126.60035151305,
        ["g"] = 11,
        ["sublevel"] = 1,
      },
      [15] = {
        ["x"] = 309.29875021963,
        ["y"] = -106.55565455617,
        ["g"] = 10,
        ["sublevel"] = 1,
      },
      [16] = {
        ["x"] = 361.7323402959,
        ["y"] = -99.818138471671,
        ["g"] = 9,
        ["sublevel"] = 1,
      },
      [17] = {
        ["x"] = 281.1684129432,
        ["y"] = -257.20252420432,
        ["g"] = 31,
        ["sublevel"] = 1,
      },
      [18] = {
        ["x"] = 289.0057497871,
        ["y"] = -264.7295969054,
        ["g"] = 31,
        ["sublevel"] = 1,
      },
      [19] = {
        ["x"] = 219.0775852629,
        ["y"] = -221.25639623879,
        ["g"] = 27,
        ["sublevel"] = 1,
      },
      [20] = {
        ["x"] = 154.24671687384,
        ["y"] = -264.51419083456,
        ["g"] = 30,
        ["sublevel"] = 1,
      },
      [21] = {
        ["x"] = 166.95914170636,
        ["y"] = -263.92003391816,
        ["g"] = 30,
        ["sublevel"] = 1,
      },
      [22] = {
        ["x"] = 216.39510194361,
        ["y"] = -359.11258288988,
        ["g"] = 35,
        ["sublevel"] = 1,
      },
      [23] = {
        ["x"] = 285.11903867588,
        ["y"] = -350.63587627764,
        ["g"] = 37,
        ["sublevel"] = 1,
      },
      [24] = {
        ["x"] = 331.38739869046,
        ["y"] = -402.63718066907,
        ["g"] = 39,
        ["sublevel"] = 1,
      },
      [25] = {
        ["x"] = 362.63063732963,
        ["y"] = -415.31606689896,
        ["g"] = 40,
        ["sublevel"] = 1,
      },
      [26] = {
        ["x"] = 133.67223749036,
        ["y"] = -86.852809932269,
        ["g"] = 12,
        ["sublevel"] = 1,
      },
      [27] = {
        ["x"] = 117.23020168431,
        ["y"] = -111.85388053665,
        ["g"] = 13,
        ["sublevel"] = 1,
      },
      [28] = {
        ["x"] = 108.68410847245,
        ["y"] = -119.43942230201,
        ["g"] = 13,
        ["sublevel"] = 1,
      },
      [29] = {
        ["x"] = 72.620980073851,
        ["y"] = -163.13462707277,
        ["g"] = 16,
        ["sublevel"] = 1,
      },
    },
  },
  [11] = {
    ["name"] = "Ascendant Viscoxria",
    ["id"] = 211261,
    ["count"] = 25,
    ["health"] = 37826761,
    ["scale"] = 2.5,
    ["stealthDetect"] = true,
    ["displayId"] = 115760,
    ["creatureType"] = "Humanoid",
    ["level"] = 80,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Slow"] = true,
      ["Mind Soothe"] = true,
    },
    ["spells"] = {
      [427192] = {
      },
      [451101] = {
      },
      [451102] = {
      },
      [451119] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 413.74070328419,
        ["y"] = -157.88506895896,
        ["sublevel"] = 1,
      },
    },
  },
  [12] = {
    ["name"] = "Deathscreamer Ikentak",
    ["id"] = 211263,
    ["count"] = 25,
    ["health"] = 53706605,
    ["scale"] = 2.5,
    ["stealthDetect"] = true,
    ["displayId"] = 115759,
    ["creatureType"] = "Humanoid",
    ["level"] = 80,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Slow"] = true,
      ["Mind Soothe"] = true,
    },
    ["spells"] = {
      [427192] = {
      },
      [450854] = {
      },
      [450855] = {
      },
      [450860] = {
      },
      [451119] = {
      },
      [460135] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 247.92811499821,
        ["y"] = -412.75017243115,
        ["sublevel"] = 1,
      },
    },
  },
  [13] = {
    ["name"] = "Ixkreten The Unbreakable",
    ["id"] = 211262,
    ["count"] = 25,
    ["health"] = 65641406,
    ["scale"] = 2.5,
    ["stealthDetect"] = true,
    ["displayId"] = 119262,
    ["creatureType"] = "Humanoid",
    ["level"] = 80,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Slow"] = true,
      ["Mind Soothe"] = true,
    },
    ["spells"] = {
      [427192] = {
      },
      [451115] = {
      },
      [451116] = {
      },
      [451117] = {
      },
      [451119] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 99.027899797701,
        ["y"] = -158.07770182773,
        ["sublevel"] = 1,
      },
    },
  },
  [14] = {
    ["name"] = "Nightfall Dark Architect",
    ["id"] = 213885,
    ["count"] = 30,
    ["health"] = 55695738,
    ["scale"] = 2.5,
    ["stealthDetect"] = true,
    ["displayId"] = 120116,
    ["creatureType"] = "Humanoid",
    ["level"] = 80,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Slow"] = true,
      ["Mind Soothe"] = true,
    },
    ["spells"] = {
      [431303] = {
      },
      [431349] = {
      },
      [431350] = {
      },
      [431352] = {
      },
      [446615] = {
      },
      [452502] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 74.773636430292,
        ["y"] = -470.97676748538,
        ["sublevel"] = 1,
      },
    },
  },
  [15] = {
    ["name"] = "Speaker Shadowcrown",
    ["id"] = 211087,
    ["count"] = 0,
    ["health"] = 139239345,
    ["scale"] = 2,
    ["displayId"] = 114311,
    ["creatureType"] = "Humanoid",
    ["level"] = 80,
    ["isBoss"] = true,
    ["encounterID"] = 2580,
    ["instanceID"] = 0,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Slow"] = true,
      ["Mind Soothe"] = true,
    },
    ["spells"] = {
      [426734] = {
      },
      [426735] = {
        ["magic"] = true,
      },
      [426736] = {
      },
      [428086] = {
      },
      [451026] = {
      },
      [451032] = {
      },
      [453140] = {
      },
      [453141] = {
      },
      [453173] = {
      },
      [453212] = {
      },
      [453214] = {
      },
      [453310] = {
      },
      [453859] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 705.96934482017,
        ["y"] = -232.46114597965,
        ["sublevel"] = 1,
      },
    },
  },
  [16] = {
    ["name"] = "Anubikkaj",
    ["id"] = 211089,
    ["count"] = 0,
    ["health"] = 139349505,
    ["scale"] = 1.7,
    ["displayId"] = 114315,
    ["creatureType"] = "Humanoid",
    ["level"] = 80,
    ["isBoss"] = true,
    ["encounterID"] = 2581,
    ["instanceID"] = 0,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Slow"] = true,
      ["Mind Soothe"] = true,
    },
    ["spells"] = {
      [426787] = {
      },
      [426793] = {
      },
      [426826] = {
      },
      [426860] = {
      },
      [426865] = {
      },
      [427001] = {
      },
      [427002] = {
      },
      [427007] = {
      },
      [427192] = {
      },
      [427378] = {
      },
      [452127] = {
      },
      [452145] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 173.30886633597,
        ["y"] = -369.76812667996,
        ["sublevel"] = 1,
      },
    },
  },
  [17] = {
    ["name"] = "Rashanan",
    ["id"] = 213937,
    ["count"] = 0,
    ["health"] = 3580440300,
    ["scale"] = 2,
    ["displayId"] = 118404,
    ["creatureType"] = "Humanoid",
    ["level"] = 80,
    ["isBoss"] = true,
    ["encounterID"] = 2593,
    ["instanceID"] = 0,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Slow"] = true,
      ["Mind Soothe"] = true,
    },
    ["spells"] = {
      [434089] = {
      },
      [434093] = {
      },
      [434096] = {
      },
      [434119] = {
      },
      [434407] = {
      },
      [434441] = {
      },
      [434576] = {
      },
      [434579] = {
      },
      [434655] = {
      },
      [435793] = {
      },
      [438956] = {
      },
      [438957] = {
      },
      [448213] = {
      },
      [448215] = {
      },
      [448887] = {
      },
      [448888] = {
      },
      [449734] = {
      },
      [463369] = {
      },
      [463428] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 129.77207742483,
        ["y"] = -483.06632046239,
        ["sublevel"] = 1,
      },
    },
  },
};
