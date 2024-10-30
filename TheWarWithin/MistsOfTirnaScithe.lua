local addonName = ...
local MDT = MDT
local L = MDT.L
local dungeonIndex = 31
MDT.dungeonList[dungeonIndex] = L["Mists of Tirna Scithe"]
MDT.mapInfo[dungeonIndex] = {
  teleportId = 354464,
  shortName = L["mistsShortName"],
  englishName = "Mists of Tirna Scithe",
  mapID = 375
}

local zones = { 1565, 1669 }
for _, zone in ipairs(zones) do
  MDT.zoneIdToDungeonIdx[zone] = dungeonIndex
end

MDT.dungeonTotalCount[dungeonIndex] = { normal = 290, teeming = 1000, teemingEnabled = true }

MDT.dungeonMaps[dungeonIndex] = {
  [0] = "",
  [1] = { customTextures = 'Interface\\AddOns\\'..addonName..'\\TheWarWithin\\Textures\\MistsOfTirnaScithe' }
}
MDT.dungeonSubLevels[dungeonIndex] = {
  [1] = L["Mists of Tirna Scithe"]
}

MDT.mapPOIs[dungeonIndex] = {
  [1] = {
    [1] = {
      ["template"] = "MapLinkPinTemplate",
      ["type"] = "mistsItem",
      ["x"] = 795.63831666907,
      ["y"] = -144.50366473795,
      ["itemType"] = 1,
    },
    [2] = {
      ["template"] = "MapLinkPinTemplate",
      ["type"] = "mistsItem",
      ["x"] = 675.92441632622,
      ["y"] = -189.74816527623,
      ["itemType"] = 1,
    },
    [3] = {
      ["template"] = "MapLinkPinTemplate",
      ["type"] = "mistsItem",
      ["x"] = 656.7165286797,
      ["y"] = -209.47278754994,
      ["itemType"] = 2,
    },
    [4] = {
      ["template"] = "MapLinkPinTemplate",
      ["type"] = "mistsItem",
      ["x"] = 639.05923241146,
      ["y"] = -197.84474464121,
      ["itemType"] = 3,
    },
    [5] = {
      ["template"] = "MapLinkPinTemplate",
      ["type"] = "mistsItem",
      ["x"] = 594.9749924947,
      ["y"] = -193.61422660229,
      ["itemType"] = 4,
    },
    [6] = {
      ["template"] = "MapLinkPinTemplate",
      ["type"] = "mistsItem",
      ["x"] = 330.87657489238,
      ["y"] = -319.32567032828,
      ["itemType"] = 5,
    },
    [7] = {
      ["template"] = "MapLinkPinTemplate",
      ["type"] = "dungeonEntrance",
      ["x"] = 822.00553571743,
      ["y"] = -111.94358107728,
    },
  },
};

MDT.dungeonEnemies[dungeonIndex] = {
  [1] = {
    ["name"] = "Drust Spiteclaw",
    ["id"] = 165111,
    ["count"] = 2,
    ["health"] = 11934801,
    ["scale"] = 1,
    ["displayId"] = 86207,
    ["creatureType"] = "Aberration",
    ["level"] = 60,
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
      [322967] = {
      },
      [322968] = {
      },
      [323020] = {
      },
      [323043] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 785.14993715255,
        ["y"] = -124.62126243179,
        ["g"] = 1,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 794.10623418996,
        ["y"] = -127.36451327536,
        ["g"] = 1,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 792.26245618726,
        ["y"] = -118.43303964205,
        ["g"] = 1,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 761.01114950414,
        ["y"] = -174.83121927917,
        ["g"] = 4,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 768.86639439701,
        ["y"] = -169.00128044685,
        ["g"] = 4,
        ["sublevel"] = 1,
      },
      [6] = {
        ["x"] = 792.02378480585,
        ["y"] = -169.99140305975,
        ["g"] = 5,
        ["sublevel"] = 1,
      },
      [7] = {
        ["x"] = 790.13629292606,
        ["y"] = -160.51556751786,
        ["g"] = 5,
        ["sublevel"] = 1,
      },
      [8] = {
        ["x"] = 783.00898879737,
        ["y"] = -166.92534028001,
        ["g"] = 5,
        ["sublevel"] = 1,
      },
      [9] = {
        ["x"] = 760.78894301712,
        ["y"] = -241.72739227211,
        ["g"] = 8,
        ["sublevel"] = 1,
      },
      [10] = {
        ["x"] = 751.05859400682,
        ["y"] = -241.30174410667,
        ["g"] = 8,
        ["sublevel"] = 1,
      },
      [11] = {
        ["x"] = 761.08327604366,
        ["y"] = -251.81717624169,
        ["g"] = 8,
        ["sublevel"] = 1,
        ["inspiring"] = true,
      },
      [12] = {
        ["x"] = 751.73083234725,
        ["y"] = -252.15717277407,
        ["g"] = 8,
        ["sublevel"] = 1,
      },
    },
  },
  [2] = {
    ["name"] = "Tirnenn Villager",
    ["id"] = 164929,
    ["count"] = 7,
    ["health"] = 47739204,
    ["scale"] = 1.2,
    ["stealthDetect"] = true,
    ["displayId"] = 95618,
    ["creatureType"] = "Elemental",
    ["level"] = 60,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [300155] = {
      },
      [321952] = {
      },
      [321968] = {
      },
      [322486] = {
      },
      [322487] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 787.83673770693,
        ["y"] = -98.532876173032,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 762.75604307297,
        ["y"] = -147.97958439048,
        ["g"] = 3,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 817.4105860946,
        ["y"] = -178.34808812292,
        ["g"] = 6,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 770.57604655528,
        ["y"] = -204.69430256,
        ["g"] = 7,
        ["sublevel"] = 1,
      },
    },
  },
  [3] = {
    ["name"] = "Drust Soulcleaver",
    ["id"] = 164920,
    ["count"] = 4,
    ["health"] = 21880469,
    ["scale"] = 1,
    ["displayId"] = 95612,
    ["creatureType"] = "Humanoid",
    ["level"] = 60,
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
      [322557] = {
      },
      [322569] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 759.01975687592,
        ["y"] = -137.97748597498,
        ["g"] = 3,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 769.61784375313,
        ["y"] = -139.45867254579,
        ["g"] = 3,
        ["sublevel"] = 1,
        ["inspiring"] = true,
      },
      [3] = {
        ["x"] = 764.75260314079,
        ["y"] = -118.63394850636,
        ["g"] = 2,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 782.0950683768,
        ["y"] = -205.85400847257,
        ["g"] = 7,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 769.78465075312,
        ["y"] = -193.41988033247,
        ["g"] = 7,
        ["sublevel"] = 1,
      },
      [7] = {
        ["x"] = 718.97811083627,
        ["y"] = -216.80127992852,
        ["g"] = 9,
        ["sublevel"] = 1,
      },
      [9] = {
        ["x"] = 690.44917964303,
        ["y"] = -181.86539351436,
        ["g"] = 10,
        ["sublevel"] = 1,
        ["inspiring"] = true,
      },
      [10] = {
        ["x"] = 708.35317991263,
        ["y"] = -183.75918285814,
        ["g"] = 10,
        ["sublevel"] = 1,
      },
    },
  },
  [4] = {
    ["name"] = "Drust Harvester",
    ["id"] = 164921,
    ["count"] = 4,
    ["health"] = 17902202,
    ["scale"] = 1,
    ["displayId"] = 95613,
    ["creatureType"] = "Humanoid",
    ["level"] = 60,
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
      [322767] = {
        ["interruptible"] = true,
      },
      [322938] = {
        ["interruptible"] = true,
      },
      [322939] = {
      },
      [326319] = {
        ["interruptible"] = true,
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 758.28468316339,
        ["y"] = -112.0647978345,
        ["g"] = 2,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 806.78479722492,
        ["y"] = -177.75664168548,
        ["g"] = 6,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 811.50976610591,
        ["y"] = -187.89249767823,
        ["g"] = 6,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 779.16758145047,
        ["y"] = -195.62761666821,
        ["g"] = 7,
        ["sublevel"] = 1,
        ["inspiring"] = true,
      },
      [5] = {
        ["x"] = 731.41378899011,
        ["y"] = -214.89191701073,
        ["g"] = 9,
        ["sublevel"] = 1,
      },
      [6] = {
        ["x"] = 726.31181871476,
        ["y"] = -223.30523561112,
        ["g"] = 9,
        ["sublevel"] = 1,
      },
      [7] = {
        ["x"] = 698.56486076588,
        ["y"] = -190.83800819879,
        ["g"] = 10,
        ["sublevel"] = 1,
      },
      [8] = {
        ["x"] = 700.88993415571,
        ["y"] = -174.50693685718,
        ["g"] = 10,
        ["sublevel"] = 1,
      },
    },
  },
  [5] = {
    ["name"] = "Drust Boughbreaker",
    ["id"] = 164926,
    ["count"] = 6,
    ["health"] = 43760937,
    ["scale"] = 1.2,
    ["displayId"] = 95615,
    ["creatureType"] = "Aberration",
    ["level"] = 60,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [324909] = {
      },
      [324922] = {
      },
      [324923] = {
      },
      [325027] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 772.06716049606,
        ["y"] = -245.2626584227,
        ["g"] = 8,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 720.08021345304,
        ["y"] = -232.22165822934,
        ["g"] = 9,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 682.88518577488,
        ["y"] = -135.84080938827,
        ["g"] = 11,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 672.00792101047,
        ["y"] = -141.2044094441,
        ["g"] = 11,
        ["sublevel"] = 1,
      },
    },
  },
  [6] = {
    ["name"] = "Ingra Maloch",
    ["id"] = 164567,
    ["count"] = 0,
    ["health"] = 214826418,
    ["scale"] = 1.2,
    ["displayId"] = 95497,
    ["creatureType"] = "Humanoid",
    ["level"] = 60,
    ["isBoss"] = true,
    ["encounterID"] = 2400,
    ["instanceID"] = 0,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Mind Soothe"] = true,
    },
    ["spells"] = {
      [321005] = {
      },
      [321006] = {
      },
      [321010] = {
      },
      [323057] = {
        ["interruptible"] = true,
      },
      [323138] = {
      },
      [323146] = {
      },
      [323149] = {
      },
      [328756] = {
      },
      [331440] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 662.18446334695,
        ["y"] = -104.83590078153,
        ["g"] = 44,
        ["sublevel"] = 1,
      },
    },
  },
  [7] = {
    ["name"] = "Droman Oulfarran",
    ["id"] = 164804,
    ["count"] = 0,
    ["health"] = 51717471,
    ["scale"] = 1.2,
    ["displayId"] = 95564,
    ["creatureType"] = "Elemental",
    ["level"] = 60,
    ["isBoss"] = true,
    ["encounterID"] = 2400,
    ["instanceID"] = 0,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [321772] = {
      },
      [323059] = {
      },
      [323137] = {
      },
      [323177] = {
      },
      [323250] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 640.56609963746,
        ["y"] = -118.18202953751,
        ["g"] = 44,
        ["sublevel"] = 1,
      },
    },
  },
  [8] = {
    ["name"] = "Mistveil Defender",
    ["id"] = 163058,
    ["count"] = 4,
    ["health"] = 30632655,
    ["scale"] = 1,
    ["stealthDetect"] = true,
    ["displayId"] = 95256,
    ["creatureType"] = "Humanoid",
    ["level"] = 60,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Mind Soothe"] = true,
    },
    ["spells"] = {
      [463236] = {
      },
      [463247] = {
      },
      [463248] = {
      },
      [463256] = {
      },
      [463257] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 570.14448110751,
        ["y"] = -254.34067230106,
        ["g"] = 13,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 573.07463167375,
        ["y"] = -264.13222843803,
        ["g"] = 13,
        ["sublevel"] = 1,
        ["inspiring"] = true,
      },
      [3] = {
        ["x"] = 573.49219747343,
        ["y"] = -317.46242635549,
        ["g"] = 14,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 437.02745592698,
        ["y"] = -373.86630455781,
        ["g"] = 16,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 481.80473930777,
        ["y"] = -344.32011580698,
        ["g"] = 18,
        ["sublevel"] = 1,
      },
      [6] = {
        ["x"] = 523.03473964909,
        ["y"] = -269.00890274016,
        ["g"] = 20,
        ["sublevel"] = 1,
      },
      [7] = {
        ["x"] = 525.67822499366,
        ["y"] = -276.21835103386,
        ["g"] = 20,
        ["sublevel"] = 1,
      },
      [8] = {
        ["x"] = 492.23353130071,
        ["y"] = -231.18656084083,
        ["g"] = 21,
        ["sublevel"] = 1,
      },
      [9] = {
        ["x"] = 494.12893912101,
        ["y"] = -241.27173972167,
        ["g"] = 21,
        ["sublevel"] = 1,
        ["inspiring"] = true,
      },
      [10] = {
        ["x"] = 437.09752800658,
        ["y"] = -208.5262719241,
        ["g"] = 22,
        ["sublevel"] = 1,
      },
      [11] = {
        ["x"] = 441.21113156579,
        ["y"] = -276.20745167636,
        ["g"] = 24,
        ["sublevel"] = 1,
      },
      [12] = {
        ["x"] = 423.1576621482,
        ["y"] = -278.62312029634,
        ["g"] = 24,
        ["sublevel"] = 1,
      },
      [13] = {
        ["x"] = 540.25260535498,
        ["y"] = -150.15937242042,
        ["g"] = 25,
        ["sublevel"] = 1,
      },
      [14] = {
        ["x"] = 487.25370892822,
        ["y"] = -173.49871925469,
        ["g"] = 26,
        ["sublevel"] = 1,
      },
      [15] = {
        ["x"] = 486.67349400484,
        ["y"] = -183.57205354419,
        ["g"] = 26,
        ["sublevel"] = 1,
      },
      [16] = {
        ["x"] = 504.02497618806,
        ["y"] = -100.95353342691,
        ["g"] = 27,
        ["sublevel"] = 1,
      },
      [17] = {
        ["x"] = 499.80020354796,
        ["y"] = -110.19881306192,
        ["g"] = 27,
        ["sublevel"] = 1,
      },
      [18] = {
        ["x"] = 395.67954925923,
        ["y"] = -183.63337246163,
        ["g"] = 28,
        ["sublevel"] = 1,
      },
      [19] = {
        ["x"] = 560.9495874686,
        ["y"] = -177.93501887116,
        ["g"] = 12,
        ["sublevel"] = 1,
      },
      [20] = {
        ["x"] = 561.81042822235,
        ["y"] = -188.04936370738,
        ["g"] = 12,
        ["sublevel"] = 1,
      },
    },
  },
  [9] = {
    ["name"] = "Mistveil Stalker",
    ["id"] = 166301,
    ["count"] = 4,
    ["health"] = 17902202,
    ["scale"] = 1,
    ["displayId"] = 93762,
    ["creatureType"] = "Beast",
    ["level"] = 60,
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
      [324986] = {
      },
      [324987] = {
      },
      [325021] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 582.28543544794,
        ["y"] = -260.63342807851,
        ["g"] = 13,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 564.23737142938,
        ["y"] = -266.80266487528,
        ["g"] = 13,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 584.82412965607,
        ["y"] = -310.0069073577,
        ["g"] = 14,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 450.82511110545,
        ["y"] = -331.29761890093,
        ["g"] = 19,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 559.83394687896,
        ["y"] = -347.98541145571,
        ["g"] = 15,
        ["sublevel"] = 1,
      },
      [6] = {
        ["x"] = 535.05053149588,
        ["y"] = -276.69900910958,
        ["g"] = 20,
        ["sublevel"] = 1,
      },
      [7] = {
        ["x"] = 403.32449625359,
        ["y"] = -243.23732702117,
        ["g"] = 23,
        ["sublevel"] = 1,
      },
      [8] = {
        ["x"] = 544.09764306986,
        ["y"] = -158.0898078277,
        ["g"] = 25,
        ["sublevel"] = 1,
      },
      [9] = {
        ["x"] = 496.93977181894,
        ["y"] = -173.58878212502,
        ["g"] = 26,
        ["sublevel"] = 1,
      },
      [10] = {
        ["x"] = 391.27674828509,
        ["y"] = -170.13659827132,
        ["g"] = 28,
        ["sublevel"] = 1,
      },
    },
  },
  [10] = {
    ["name"] = "Mistveil Stinger",
    ["id"] = 166304,
    ["count"] = 4,
    ["health"] = 15913068,
    ["scale"] = 1,
    ["displayId"] = 95198,
    ["creatureType"] = "Beast",
    ["level"] = 60,
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
      [325223] = {
      },
      [325224] = {
      },
      [325226] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 575.54164838334,
        ["y"] = -307.37429097241,
        ["g"] = 14,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 534.52540043598,
        ["y"] = -326.68667107616,
        ["g"] = 17,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 458.43096783376,
        ["y"] = -319.43204965143,
        ["g"] = 19,
        ["sublevel"] = 1,
        ["inspiring"] = true,
      },
      [4] = {
        ["x"] = 496.43953552909,
        ["y"] = -183.69644148018,
        ["g"] = 26,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 508.55867556297,
        ["y"] = -115.4184801644,
        ["g"] = 27,
        ["sublevel"] = 1,
      },
    },
  },
  [11] = {
    ["name"] = "Mistveil Guardian",
    ["id"] = 166276,
    ["count"] = 4,
    ["health"] = 35804403,
    ["scale"] = 1,
    ["stealthDetect"] = true,
    ["displayId"] = 95261,
    ["creatureType"] = "Humanoid",
    ["level"] = 60,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Mind Soothe"] = true,
    },
    ["spells"] = {
      [463208] = {
      },
      [463210] = {
      },
      [463217] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 582.71692589076,
        ["y"] = -319.80066005722,
        ["g"] = 14,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 528.12775909442,
        ["y"] = -313.66316579773,
        ["g"] = 17,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 445.84934138632,
        ["y"] = -312.55754612123,
        ["g"] = 19,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 440.35086582153,
        ["y"] = -324.03383343878,
        ["g"] = 19,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 567.95288027282,
        ["y"] = -366.50564440181,
        ["g"] = 15,
        ["sublevel"] = 1,
      },
      [6] = {
        ["x"] = 441.91800421371,
        ["y"] = -363.90411979919,
        ["g"] = 16,
        ["sublevel"] = 1,
      },
      [7] = {
        ["x"] = 481.91654744794,
        ["y"] = -333.84694008499,
        ["g"] = 18,
        ["sublevel"] = 1,
      },
      [8] = {
        ["x"] = 441.80110584411,
        ["y"] = -217.36438702375,
        ["g"] = 22,
        ["sublevel"] = 1,
      },
      [9] = {
        ["x"] = 387.91236286403,
        ["y"] = -235.06865853502,
        ["g"] = 23,
        ["sublevel"] = 1,
        ["inspiring"] = true,
      },
      [10] = {
        ["x"] = 393.95520909301,
        ["y"] = -243.42314302166,
        ["g"] = 23,
        ["sublevel"] = 1,
      },
      [11] = {
        ["x"] = 432.1626608104,
        ["y"] = -276.9015718542,
        ["g"] = 24,
        ["sublevel"] = 1,
      },
      [12] = {
        ["x"] = 531.36091567559,
        ["y"] = -153.52381393891,
        ["g"] = 25,
        ["sublevel"] = 1,
        ["inspiring"] = true,
      },
      [13] = {
        ["x"] = 386.82645245395,
        ["y"] = -179.20387975288,
        ["g"] = 28,
        ["sublevel"] = 1,
      },
    },
  },
  [12] = {
    ["name"] = "Mistveil Tender",
    ["id"] = 166299,
    ["count"] = 4,
    ["health"] = 18896768,
    ["scale"] = 1,
    ["displayId"] = 95908,
    ["creatureType"] = "Humanoid",
    ["level"] = 60,
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
      [324914] = {
        ["interruptible"] = true,
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 525.55267922222,
        ["y"] = -322.88551845354,
        ["g"] = 17,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 571.68979051329,
        ["y"] = -352.98964752781,
        ["g"] = 15,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 446.32049161845,
        ["y"] = -372.34907794319,
        ["g"] = 16,
        ["sublevel"] = 1,
        ["inspiring"] = true,
      },
      [4] = {
        ["x"] = 491.39483543348,
        ["y"] = -344.20273686098,
        ["g"] = 18,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 530.84790625419,
        ["y"] = -268.03581687212,
        ["g"] = 20,
        ["sublevel"] = 1,
      },
      [6] = {
        ["x"] = 501.17378786475,
        ["y"] = -229.23414841099,
        ["g"] = 21,
        ["sublevel"] = 1,
      },
      [7] = {
        ["x"] = 503.8863144281,
        ["y"] = -239.28603635917,
        ["g"] = 21,
        ["sublevel"] = 1,
      },
      [8] = {
        ["x"] = 445.33091585122,
        ["y"] = -203.8411560197,
        ["g"] = 22,
        ["sublevel"] = 1,
      },
      [9] = {
        ["x"] = 392.54299331317,
        ["y"] = -226.33689733184,
        ["g"] = 23,
        ["sublevel"] = 1,
      },
      [10] = {
        ["x"] = 426.07388500102,
        ["y"] = -269.11762395768,
        ["g"] = 24,
        ["sublevel"] = 1,
        ["inspiring"] = true,
      },
      [11] = {
        ["x"] = 512.07622819233,
        ["y"] = -106.78535841792,
        ["g"] = 27,
        ["sublevel"] = 1,
      },
    },
  },
  [13] = {
    ["name"] = "Mistveil Shaper",
    ["id"] = 166275,
    ["count"] = 4,
    ["health"] = 20885902,
    ["scale"] = 1,
    ["displayId"] = 95051,
    ["creatureType"] = "Humanoid",
    ["level"] = 60,
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
      [324776] = {
        ["interruptible"] = true,
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 537.2829250192,
        ["y"] = -316.91343340336,
        ["g"] = 17,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 449.49427427796,
        ["y"] = -321.7434675271,
        ["g"] = 19,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 563.65864067617,
        ["y"] = -357.10854917199,
        ["g"] = 15,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 454.98481431722,
        ["y"] = -369.12113580708,
        ["g"] = 16,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 491.57923278598,
        ["y"] = -334.37791710732,
        ["g"] = 18,
        ["sublevel"] = 1,
      },
      [6] = {
        ["x"] = 449.82732383944,
        ["y"] = -212.40349617879,
        ["g"] = 22,
        ["sublevel"] = 1,
      },
      [7] = {
        ["x"] = 397.94504388137,
        ["y"] = -234.85826258746,
        ["g"] = 23,
        ["sublevel"] = 1,
      },
      [8] = {
        ["x"] = 435.86952386608,
        ["y"] = -267.72960833479,
        ["g"] = 24,
        ["sublevel"] = 1,
      },
      [9] = {
        ["x"] = 535.39952228077,
        ["y"] = -161.43539081528,
        ["g"] = 25,
        ["sublevel"] = 1,
      },
    },
  },
  [14] = {
    ["name"] = "Mistveil Nightblossom",
    ["id"] = 173714,
    ["count"] = 16,
    ["health"] = 59674005,
    ["scale"] = 1.4,
    ["displayId"] = 55772,
    ["creatureType"] = "Elemental",
    ["level"] = 60,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [340279] = {
      },
      [340283] = {
      },
      [340288] = {
      },
      [340289] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 484.82813850049,
        ["y"] = -288.0998624873,
        ["sublevel"] = 1,
      },
    },
  },
  [15] = {
    ["name"] = "Mistcaller",
    ["id"] = 164501,
    ["count"] = 0,
    ["health"] = 139239345,
    ["scale"] = 1.3,
    ["displayId"] = 96451,
    ["creatureType"] = "Humanoid",
    ["level"] = 60,
    ["isBoss"] = true,
    ["encounterID"] = 2402,
    ["instanceID"] = 0,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Mind Soothe"] = true,
    },
    ["spells"] = {
      [321471] = {
      },
      [321828] = {
        ["interruptible"] = true,
      },
      [321834] = {
      },
      [321873] = {
      },
      [336499] = {
      },
      [336752] = {
      },
      [336759] = {
      },
      [341709] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 387.53957125573,
        ["y"] = -310.46262670308,
        ["sublevel"] = 1,
      },
    },
  },
  [16] = {
    ["name"] = "Spinemaw Staghorn",
    ["id"] = 167111,
    ["count"] = 7,
    ["health"] = 31826136,
    ["scale"] = 1,
    ["displayId"] = 94190,
    ["creatureType"] = "Beast",
    ["level"] = 60,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [326046] = {
        ["interruptible"] = true,
      },
      [340544] = {
        ["interruptible"] = true,
      },
      [460092] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 281.60607427807,
        ["y"] = -378.82975011852,
        ["g"] = 29,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 242.1948913768,
        ["y"] = -440.79746097183,
        ["g"] = 30,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 232.17915385257,
        ["y"] = -478.17335635725,
        ["g"] = 32,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 153.76154739287,
        ["y"] = -357.02010571733,
        ["g"] = 39,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 208.19209985783,
        ["y"] = -336.88028792508,
        ["g"] = 38,
        ["sublevel"] = 1,
      },
      [6] = {
        ["x"] = 92.639923256124,
        ["y"] = -349.44604138909,
        ["g"] = 43,
        ["sublevel"] = 1,
      },
      [7] = {
        ["x"] = 99.300987008283,
        ["y"] = -404.37071589756,
        ["g"] = 40,
        ["sublevel"] = 1,
      },
    },
  },
  [17] = {
    ["name"] = "Spinemaw Acidgullet",
    ["id"] = 167113,
    ["count"] = 4,
    ["health"] = 19891335,
    ["scale"] = 1,
    ["displayId"] = 94205,
    ["creatureType"] = "Beast",
    ["level"] = 60,
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
      [325413] = {
      },
      [325418] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 272.29009316657,
        ["y"] = -379.02176088966,
        ["g"] = 29,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 278.49874683785,
        ["y"] = -388.82801254203,
        ["g"] = 29,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 224.63591125327,
        ["y"] = -488.86035238575,
        ["g"] = 32,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 222.8952015689,
        ["y"] = -479.35514477299,
        ["g"] = 32,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 189.50383779978,
        ["y"] = -505.59038983984,
        ["g"] = 33,
        ["sublevel"] = 1,
      },
      [6] = {
        ["x"] = 172.56896376811,
        ["y"] = -506.36162363673,
        ["g"] = 34,
        ["sublevel"] = 1,
      },
      [7] = {
        ["x"] = 166.52539683715,
        ["y"] = -513.82179769057,
        ["g"] = 34,
        ["sublevel"] = 1,
      },
      [8] = {
        ["x"] = 202.16956279676,
        ["y"] = -399.98176602696,
        ["g"] = 36,
        ["sublevel"] = 1,
        ["inspiring"] = true,
      },
      [9] = {
        ["x"] = 193.83843915733,
        ["y"] = -388.75425126147,
        ["g"] = 36,
        ["sublevel"] = 1,
      },
      [10] = {
        ["x"] = 145.9346670921,
        ["y"] = -362.54678881942,
        ["g"] = 39,
        ["sublevel"] = 1,
      },
      [11] = {
        ["x"] = 147.85118059162,
        ["y"] = -348.68155909511,
        ["g"] = 39,
        ["sublevel"] = 1,
      },
      [12] = {
        ["x"] = 102.36441722034,
        ["y"] = -349.6865882064,
        ["g"] = 43,
        ["sublevel"] = 1,
      },
      [13] = {
        ["x"] = 102.73815094574,
        ["y"] = -339.79878356673,
        ["g"] = 43,
        ["sublevel"] = 1,
      },
    },
  },
  [18] = {
    ["name"] = "Spinemaw Gorger",
    ["id"] = 172312,
    ["count"] = 4,
    ["health"] = 19891335,
    ["scale"] = 1,
    ["displayId"] = 94197,
    ["creatureType"] = "Beast",
    ["level"] = 60,
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
      [326021] = {
      },
      [326022] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 243.309537981,
        ["y"] = -450.11906309101,
        ["g"] = 30,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 234.1631990949,
        ["y"] = -487.70848372737,
        ["g"] = 32,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 194.70909994671,
        ["y"] = -497.12763276059,
        ["g"] = 33,
        ["sublevel"] = 1,
        ["inspiring"] = true,
      },
      [4] = {
        ["x"] = 166.28888221608,
        ["y"] = -498.58004127006,
        ["g"] = 34,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 159.60058921982,
        ["y"] = -506.1642236032,
        ["g"] = 34,
        ["sublevel"] = 1,
      },
      [6] = {
        ["x"] = 203.47104043518,
        ["y"] = -389.99639460737,
        ["g"] = 36,
        ["sublevel"] = 1,
      },
      [7] = {
        ["x"] = 192.7384839341,
        ["y"] = -398.89487656121,
        ["g"] = 36,
        ["sublevel"] = 1,
      },
      [8] = {
        ["x"] = 139.89158426248,
        ["y"] = -354.43541594461,
        ["g"] = 39,
        ["sublevel"] = 1,
      },
      [9] = {
        ["x"] = 199.22892207124,
        ["y"] = -334.44586782142,
        ["g"] = 38,
        ["sublevel"] = 1,
      },
      [10] = {
        ["x"] = 93.168027493527,
        ["y"] = -339.1669256357,
        ["g"] = 43,
        ["sublevel"] = 1,
      },
      [11] = {
        ["x"] = 105.07290691702,
        ["y"] = -411.51696463042,
        ["g"] = 40,
        ["sublevel"] = 1,
      },
    },
  },
  [19] = {
    ["name"] = "Spinemaw Larva",
    ["id"] = 167117,
    ["count"] = 1,
    ["health"] = 3978267,
    ["scale"] = 0.6,
    ["displayId"] = 94208,
    ["creatureType"] = "Beast",
    ["level"] = 60,
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
      [326018] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 251.31494297697,
        ["y"] = -450.96589424749,
        ["g"] = 30,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 249.2464376152,
        ["y"] = -438.78498808419,
        ["g"] = 30,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 257.1452625991,
        ["y"] = -449.92613493903,
        ["g"] = 30,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 250.01144246031,
        ["y"] = -444.8513899104,
        ["g"] = 30,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 255.13126925666,
        ["y"] = -437.91631740037,
        ["g"] = 30,
        ["sublevel"] = 1,
      },
      [6] = {
        ["x"] = 256.33892705569,
        ["y"] = -443.73050986986,
        ["g"] = 30,
        ["sublevel"] = 1,
        ["inspiring"] = true,
      },
      [7] = {
        ["x"] = 203.15350740571,
        ["y"] = -509.48314818852,
        ["g"] = 33,
        ["sublevel"] = 1,
      },
      [8] = {
        ["x"] = 201.21654230383,
        ["y"] = -501.26038098855,
        ["g"] = 33,
        ["sublevel"] = 1,
      },
      [9] = {
        ["x"] = 206.02963281358,
        ["y"] = -504.04680332857,
        ["g"] = 33,
        ["sublevel"] = 1,
      },
      [10] = {
        ["x"] = 199.9890660409,
        ["y"] = -514.3248892349,
        ["g"] = 33,
        ["sublevel"] = 1,
      },
      [11] = {
        ["x"] = 195.14781177517,
        ["y"] = -511.04657552476,
        ["g"] = 33,
        ["sublevel"] = 1,
      },
      [12] = {
        ["x"] = 198.35483315189,
        ["y"] = -506.24364628598,
        ["g"] = 33,
        ["sublevel"] = 1,
      },
      [13] = {
        ["x"] = 200.77412890974,
        ["y"] = -342.89228282208,
        ["g"] = 38,
        ["sublevel"] = 1,
        ["inspiring"] = true,
      },
      [14] = {
        ["x"] = 206.31841096224,
        ["y"] = -344.91663759527,
        ["g"] = 38,
        ["sublevel"] = 1,
      },
      [15] = {
        ["x"] = 195.10165773114,
        ["y"] = -341.26771897013,
        ["g"] = 38,
        ["sublevel"] = 1,
      },
      [16] = {
        ["x"] = 193.04170681628,
        ["y"] = -346.94932637928,
        ["g"] = 38,
        ["sublevel"] = 1,
      },
      [17] = {
        ["x"] = 198.85599323722,
        ["y"] = -348.47173315255,
        ["g"] = 38,
        ["sublevel"] = 1,
      },
      [18] = {
        ["x"] = 204.20237275488,
        ["y"] = -350.42487736375,
        ["g"] = 38,
        ["sublevel"] = 1,
      },
      [19] = {
        ["x"] = 113.13587102381,
        ["y"] = -401.00386576705,
        ["g"] = 40,
        ["sublevel"] = 1,
      },
      [20] = {
        ["x"] = 110.21495639583,
        ["y"] = -395.91449410081,
        ["g"] = 40,
        ["sublevel"] = 1,
      },
      [21] = {
        ["x"] = 108.18072227752,
        ["y"] = -403.47715688503,
        ["g"] = 40,
        ["sublevel"] = 1,
        ["inspiring"] = true,
      },
      [22] = {
        ["x"] = 104.85496512439,
        ["y"] = -398.34864865449,
        ["g"] = 40,
        ["sublevel"] = 1,
      },
      [23] = {
        ["x"] = 116.7702482081,
        ["y"] = -405.53315991691,
        ["g"] = 40,
        ["sublevel"] = 1,
      },
      [24] = {
        ["x"] = 112.31825054166,
        ["y"] = -408.59680361885,
        ["g"] = 40,
        ["sublevel"] = 1,
      },
    },
  },
  [20] = {
    ["name"] = "Spinemaw Reaver",
    ["id"] = 167116,
    ["count"] = 4,
    ["health"] = 15913068,
    ["scale"] = 1,
    ["displayId"] = 95692,
    ["creatureType"] = "Beast",
    ["level"] = 60,
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
      [326090] = {
      },
      [326092] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 221.26657720707,
        ["y"] = -445.21119368282,
        ["g"] = 31,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 225.00350404721,
        ["y"] = -437.40652062315,
        ["g"] = 31,
        ["sublevel"] = 1,
        ["inspiring"] = true,
        ["patrol"] = {
        },
      },
      [3] = {
        ["x"] = 189.64696693247,
        ["y"] = -365.27169951328,
        ["g"] = 37,
        ["sublevel"] = 1,
        ["inspiring"] = true,
        ["patrol"] = {
        },
      },
      [4] = {
        ["x"] = 181.8311298692,
        ["y"] = -371.242395086,
        ["g"] = 37,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 126.29412661728,
        ["y"] = -392.79939785773,
        ["g"] = 41,
        ["sublevel"] = 1,
      },
      [6] = {
        ["x"] = 128.35925771088,
        ["y"] = -383.78395126914,
        ["g"] = 41,
        ["sublevel"] = 1,
      },
      [7] = {
        ["x"] = 133.81135218606,
        ["y"] = -375.80607062928,
        ["g"] = 41,
        ["sublevel"] = 1,
      },
      [8] = {
        ["x"] = 108.05074302089,
        ["y"] = -369.17196769889,
        ["g"] = 42,
        ["sublevel"] = 1,
      },
      [9] = {
        ["x"] = 116.99912076763,
        ["y"] = -371.20505318555,
        ["g"] = 42,
        ["sublevel"] = 1,
      },
      [10] = {
        ["x"] = 124.02007124398,
        ["y"] = -364.24762619059,
        ["g"] = 42,
        ["sublevel"] = 1,
        ["patrol"] = {
        },
      },
      [11] = {
        ["x"] = 143.38152325131,
        ["y"] = -528.96088408536,
        ["g"] = 35,
        ["sublevel"] = 1,
      },
      [12] = {
        ["x"] = 158.38899560887,
        ["y"] = -535.05335848292,
        ["g"] = 35,
        ["sublevel"] = 1,
      },
      [13] = {
        ["x"] = 153.73991486457,
        ["y"] = -525.61599144377,
        ["g"] = 35,
        ["sublevel"] = 1,
      },
    },
  },
  [21] = {
    ["name"] = "Tred'ova",
    ["id"] = 164517,
    ["count"] = 0,
    ["health"] = 159130680,
    ["scale"] = 1.4,
    ["displayId"] = 95809,
    ["creatureType"] = "Beast",
    ["level"] = 60,
    ["isBoss"] = true,
    ["encounterID"] = 2405,
    ["instanceID"] = 0,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [322450] = {
      },
      [322465] = {
      },
      [322527] = {
      },
      [322550] = {
      },
      [322551] = {
      },
      [322563] = {
      },
      [322614] = {
      },
      [322654] = {
      },
      [322655] = {
      },
      [322709] = {
      },
      [326263] = {
      },
      [326281] = {
      },
      [463602] = {
      },
      [463603] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 73.419600676175,
        ["y"] = -476.20502789411,
        ["sublevel"] = 1,
      },
    },
  },
  [22] = {
    ["name"] = "Mistveil Gorgegullet",
    ["id"] = 173720,
    ["count"] = 16,
    ["health"] = 59726464,
    ["scale"] = 1.4,
    ["displayId"] = 98502,
    ["creatureType"] = "Beast",
    ["level"] = 60,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [340300] = {
      },
      [340304] = {
      },
      [340305] = {
      },
      [340311] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 494.99898013798,
        ["y"] = -395.3498034217,
        ["sublevel"] = 1,
      },
    },
  },
  [23] = {
    ["name"] = "Mistveil Stinger",
    ["id"] = 166304,
    ["count"] = 4,
    ["health"] = 15913068,
    ["scale"] = 1,
    ["displayId"] = 95198,
    ["creatureType"] = "Beast",
    ["level"] = 60,
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
      [325223] = {
      },
      [325224] = {
      },
      [325226] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 447.01011646451,
        ["y"] = -382.08726450381,
        ["g"] = 16,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 555.49008857421,
        ["y"] = -362.78186101403,
        ["g"] = 15,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 399.90967555859,
        ["y"] = -174.56487561205,
        ["g"] = 28,
        ["sublevel"] = 1,
      },
    },
  },
  [24] = {
    ["name"] = "Mistveil Matriarch",
    ["id"] = 173655,
    ["count"] = 16,
    ["health"] = 59674005,
    ["scale"] = 1.4,
    ["displayId"] = 98569,
    ["creatureType"] = "Dragonkin",
    ["level"] = 60,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Mind Soothe"] = true,
    },
    ["spells"] = {
      [340160] = {
      },
      [340189] = {
      },
      [340208] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 449.84161604018,
        ["y"] = -142.04204238577,
        ["sublevel"] = 1,
      },
    },
  },
};
