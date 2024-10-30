local addonName = ...
local MDT = MDT
local L = MDT.L
local dungeonIndex = 35
MDT.dungeonList[dungeonIndex] = L["The Necrotic Wake"]
MDT.mapInfo[dungeonIndex] = {
  teleportId = 354462,
  shortName = L["necroticWakeShortName"],
  englishName = "The Necrotic Wake",
  mapID = 376
}
local zones = { 1533, 1666, 1667, 1668 }
for _, zone in ipairs(zones) do
  MDT.zoneIdToDungeonIdx[zone] = dungeonIndex
end

MDT.scaleMultiplier[dungeonIndex] = 1.3

MDT.dungeonMaps[dungeonIndex] = {
  [0] = "",
  [1] = { customTextures = 'Interface\\AddOns\\'..addonName..'\\TheWarWithin\\Textures\\NecroticWake' }
}

MDT.dungeonSubLevels[dungeonIndex] = {
  [1] = L["TheNecroticWakeFloor1"]
}

MDT.dungeonTotalCount[dungeonIndex] = { normal = 332, teeming = 1000, teemingEnabled = true }

MDT.mapPOIs[dungeonIndex] = {
  [1] = {
    [1] = {
      ["template"] = "MapLinkPinTemplate",
      ["type"] = "nwItem",
      ["x"] = 643.52016833279,
      ["y"] = -123.80125980435,
      ["itemType"] = 1,
      ["itemIndex"] = 1,
      ["textAnchor"] = "LEFT",
      ["textAnchorTo"] = "RIGHT",
    },
    [2] = {
      ["template"] = "MapLinkPinTemplate",
      ["type"] = "nwItem",
      ["x"] = 209.11406341061,
      ["y"] = -313.46368146663,
      ["itemType"] = 1,
      ["itemIndex"] = 2,
      ["textAnchor"] = "RIGHT",
      ["textAnchorTo"] = "LEFT",
    },
    [3] = {
      ["template"] = "MapLinkPinTemplate",
      ["type"] = "nwItem",
      ["x"] = 155.12477376366,
      ["y"] = -137.88878886536,
      ["itemType"] = 1,
      ["itemIndex"] = 3,
      ["textAnchor"] = "RIGHT",
      ["textAnchorTo"] = "LEFT",
    },
    [4] = {
      ["template"] = "MapLinkPinTemplate",
      ["type"] = "nwItem",
      ["x"] = 509.29314362372,
      ["y"] = -491.23790571238,
      ["itemType"] = 2,
      ["itemIndex"] = 1,
      ["textAnchor"] = "LEFT",
      ["textAnchorTo"] = "RIGHT",
    },
    [5] = {
      ["template"] = "MapLinkPinTemplate",
      ["type"] = "nwItem",
      ["x"] = 426.80112382239,
      ["y"] = -377.33123074021,
      ["itemType"] = 2,
      ["itemIndex"] = 2,
      ["textAnchor"] = "LEFT",
      ["textAnchorTo"] = "RIGHT",
    },
    [6] = {
      ["template"] = "MapLinkPinTemplate",
      ["type"] = "nwItem",
      ["x"] = 364.0589175591,
      ["y"] = -160.2745245048,
      ["itemType"] = 2,
      ["itemIndex"] = 3,
      ["textAnchor"] = "LEFT",
      ["textAnchorTo"] = "RIGHT",
    },
    [7] = {
      ["template"] = "MapLinkPinTemplate",
      ["type"] = "nwItem",
      ["x"] = 657.13478262905,
      ["y"] = -164.58132291432,
      ["itemType"] = 3,
      ["itemIndex"] = 1,
      ["textAnchor"] = "LEFT",
      ["textAnchorTo"] = "RIGHT",
    },
    [8] = {
      ["template"] = "MapLinkPinTemplate",
      ["type"] = "nwItem",
      ["x"] = 616.5338653335,
      ["y"] = -289.26014512225,
      ["itemType"] = 3,
      ["itemIndex"] = 2,
      ["textAnchor"] = "LEFT",
      ["textAnchorTo"] = "RIGHT",
    },
    [9] = {
      ["template"] = "MapLinkPinTemplate",
      ["type"] = "nwItem",
      ["x"] = 373.1011371182,
      ["y"] = -415.30176076932,
      ["itemType"] = 3,
      ["itemIndex"] = 3,
      ["textAnchor"] = "RIGHT",
      ["textAnchorTo"] = "LEFT",
    },
    [10] = {
      ["template"] = "MapLinkPinTemplate",
      ["type"] = "nwItem",
      ["x"] = 340.35631484395,
      ["y"] = -252.01247156781,
      ["itemType"] = 3,
      ["itemIndex"] = 4,
      ["textAnchor"] = "LEFT",
      ["textAnchorTo"] = "RIGHT",
    },
    [11] = {
      ["template"] = "MapLinkPinTemplate",
      ["type"] = "dungeonEntrance",
      ["x"] = 746.15972704527,
      ["y"] = -210.58951356329,
    },
  },
};

MDT.dungeonEnemies[dungeonIndex] = {
  [1] = {
    ["name"] = "Patchwerk Soldier",
    ["id"] = 162729,
    ["count"] = 1,
    ["health"] = 15913068,
    ["scale"] = 1.2,
    ["displayId"] = 95222,
    ["creatureType"] = "Undead",
    ["level"] = 60,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Incapacitate"] = true,
      ["Control Undead"] = true,
      ["Silence"] = true,
      ["Knock"] = true,
      ["Grip"] = true,
      ["Shackle Undead"] = true,
      ["Root"] = true,
      ["Fear"] = true,
      ["Banish"] = true,
      ["Disorient"] = true,
      ["Repentance"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
      ["Sleep Walk"] = true,
      ["Turn Evil"] = true,
    },
    ["spells"] = {
      [338022] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 670.75054532288,
        ["y"] = -216.06579921398,
        ["g"] = 1,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 671.2296819672,
        ["y"] = -201.37621545837,
        ["g"] = 1,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 656.24795353054,
        ["y"] = -216.20201687807,
        ["g"] = 1,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 656.45382533976,
        ["y"] = -201.24914620776,
        ["g"] = 1,
        ["sublevel"] = 1,
        ["inspiring"] = true,
      },
      [5] = {
        ["x"] = 611.65323888146,
        ["y"] = -215.90178572635,
        ["g"] = 3,
        ["sublevel"] = 1,
      },
      [7] = {
        ["x"] = 550.09266882514,
        ["y"] = -210.2635766912,
        ["g"] = 7,
        ["sublevel"] = 1,
      },
      [8] = {
        ["x"] = 564.33215880318,
        ["y"] = -272.61764859404,
        ["g"] = 9,
        ["sublevel"] = 1,
      },
      [9] = {
        ["x"] = 547.11311113628,
        ["y"] = -148.49178411439,
        ["g"] = 6,
        ["sublevel"] = 1,
      },
      [10] = {
        ["x"] = 538.67436541947,
        ["y"] = -161.22750022387,
        ["g"] = 6,
        ["sublevel"] = 1,
        ["patrol"] = {
          [1] = {
            ["x"] = 538.67436541947,
            ["y"] = -161.22750022387,
          },
          [2] = {
            ["x"] = 503.4428562643,
            ["y"] = -167.92566696083,
          },
          [3] = {
            ["x"] = 528.83712683158,
            ["y"] = -162.335733617,
          },
          [4] = {
            ["x"] = 530.27453290541,
            ["y"] = -161.85660110013,
          },
          [5] = {
            ["x"] = 555.82852851701,
            ["y"] = -164.73143029421,
          },
          [6] = {
            ["x"] = 578.9868189282,
            ["y"] = -169.84221407474,
          },
        },
      },
      [11] = {
        ["x"] = 532.98095922097,
        ["y"] = -147.61153487725,
        ["g"] = 6,
        ["sublevel"] = 1,
      },
      [12] = {
        ["x"] = 518.76801243009,
        ["y"] = -225.73042426273,
        ["g"] = 8,
        ["sublevel"] = 1,
        ["patrol"] = {
        },
      },
      [13] = {
        ["x"] = 519.20833448158,
        ["y"] = -240.61167259113,
        ["g"] = 8,
        ["sublevel"] = 1,
        ["patrol"] = {
          [1] = {
            ["x"] = 519.20833448158,
            ["y"] = -240.61167259113,
          },
          [2] = {
            ["x"] = 534.61923689986,
            ["y"] = -234.49040596789,
          },
          [3] = {
            ["x"] = 564.32574876492,
            ["y"] = -237.58479781935,
          },
          [4] = {
            ["x"] = 578.56015274912,
            ["y"] = -241.91702567729,
          },
          [5] = {
            ["x"] = 593.10395793689,
            ["y"] = -243.77369711837,
          },
          [6] = {
            ["x"] = 564.32574876492,
            ["y"] = -237.58479781935,
          },
          [7] = {
            ["x"] = 534.61923689986,
            ["y"] = -234.49040596789,
          },
        },
      },
      [14] = {
        ["x"] = 458.15858678879,
        ["y"] = -230.12620520028,
        ["g"] = 12,
        ["sublevel"] = 1,
      },
      [15] = {
        ["x"] = 444.44376170317,
        ["y"] = -230.39786282401,
        ["g"] = 12,
        ["sublevel"] = 1,
      },
      [16] = {
        ["x"] = 430.50830093899,
        ["y"] = -230.5689635035,
        ["g"] = 12,
        ["sublevel"] = 1,
      },
      [17] = {
        ["x"] = 603.72689879866,
        ["y"] = -133.62873652561,
        ["g"] = 5,
        ["sublevel"] = 1,
      },
      [18] = {
        ["x"] = 589.63326830094,
        ["y"] = -134.18799346841,
        ["g"] = 5,
        ["sublevel"] = 1,
      },
      [19] = {
        ["x"] = 640.77477876768,
        ["y"] = -493.62013631568,
        ["g"] = 26,
        ["sublevel"] = 1,
      },
      [20] = {
        ["x"] = 651.74942120405,
        ["y"] = -510.78226153213,
        ["g"] = 26,
        ["sublevel"] = 1,
      },
      [21] = {
        ["x"] = 702.98596334491,
        ["y"] = -407.19676272093,
        ["g"] = 28,
        ["sublevel"] = 1,
      },
      [22] = {
        ["x"] = 792.66616568197,
        ["y"] = -411.50912035561,
        ["g"] = 30,
        ["sublevel"] = 1,
      },
      [23] = {
        ["x"] = 773.06040152984,
        ["y"] = -387.28125027264,
        ["g"] = 30,
        ["sublevel"] = 1,
      },
      [24] = {
        ["x"] = 635.00491555351,
        ["y"] = -409.72569442382,
        ["g"] = 31,
        ["sublevel"] = 1,
      },
      [25] = {
        ["x"] = 658.62641626898,
        ["y"] = -383.66499459998,
        ["g"] = 31,
        ["sublevel"] = 1,
        ["inspiring"] = true,
      },
    },
  },
  [2] = {
    ["name"] = "Blight Bag",
    ["id"] = 165138,
    ["count"] = 1,
    ["health"] = 7956534,
    ["scale"] = 0.7,
    ["displayId"] = 94761,
    ["creatureType"] = "Undead",
    ["level"] = 60,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Incapacitate"] = true,
      ["Control Undead"] = true,
      ["Silence"] = true,
      ["Knock"] = true,
      ["Grip"] = true,
      ["Shackle Undead"] = true,
      ["Root"] = true,
      ["Fear"] = true,
      ["Banish"] = true,
      ["Disorient"] = true,
      ["Repentance"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
      ["Sleep Walk"] = true,
      ["Turn Evil"] = true,
    },
    ["spells"] = {
      [321821] = {
      },
      [335164] = {
      },
      [338022] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 675.73971994423,
        ["y"] = -270.50531624393,
        ["g"] = 2,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 680.14909809678,
        ["y"] = -262.82380330122,
        ["g"] = 2,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 683.90028407637,
        ["y"] = -271.1294382886,
        ["g"] = 2,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 628.8391234579,
        ["y"] = -144.51931993171,
        ["g"] = 4,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 637.23471067871,
        ["y"] = -144.56914670984,
        ["g"] = 4,
        ["sublevel"] = 1,
      },
      [6] = {
        ["x"] = 628.46593660095,
        ["y"] = -153.07526898134,
        ["g"] = 4,
        ["sublevel"] = 1,
      },
      [7] = {
        ["x"] = 637.15091421908,
        ["y"] = -153.33928346619,
        ["g"] = 4,
        ["sublevel"] = 1,
      },
      [8] = {
        ["x"] = 488.54533062372,
        ["y"] = -258.50166629656,
        ["g"] = 10,
        ["sublevel"] = 1,
        ["inspiring"] = true,
        ["patrol"] = {
          [1] = {
            ["x"] = 488.54533062372,
            ["y"] = -258.50166629656,
          },
          [2] = {
            ["x"] = 521.62263589468,
            ["y"] = -261.41191067133,
          },
          [3] = {
            ["x"] = 550.40087809411,
            ["y"] = -261.10249295403,
          },
          [4] = {
            ["x"] = 565.56355174394,
            ["y"] = -250.89086608301,
          },
          [5] = {
            ["x"] = 585.98673943106,
            ["y"] = -208.80663818856,
          },
          [6] = {
            ["x"] = 585.36787096901,
            ["y"] = -182.50400194717,
          },
          [7] = {
            ["x"] = 589.08114779625,
            ["y"] = -151.86918738903,
          },
          [8] = {
            ["x"] = 566.18238717854,
            ["y"] = -155.58249724373,
          },
          [9] = {
            ["x"] = 537.40424406148,
            ["y"] = -190.24008891506,
          },
          [10] = {
            ["x"] = 503.98442234172,
            ["y"] = -217.78049510801,
          },
          [11] = {
            ["x"] = 492.53499249168,
            ["y"] = -240.98868995675,
          },
        },
      },
      [9] = {
        ["x"] = 480.9886513636,
        ["y"] = -253.94433431149,
        ["g"] = 10,
        ["sublevel"] = 1,
      },
      [10] = {
        ["x"] = 488.53811014398,
        ["y"] = -249.75447724808,
        ["g"] = 10,
        ["sublevel"] = 1,
      },
      [11] = {
        ["x"] = 481.03432661323,
        ["y"] = -263.15294331416,
        ["g"] = 10,
        ["sublevel"] = 1,
      },
      [12] = {
        ["x"] = 480.98451314437,
        ["y"] = -245.51087823842,
        ["g"] = 10,
        ["sublevel"] = 1,
      },
      [13] = {
        ["x"] = 482.67699057155,
        ["y"] = -213.64933993986,
        ["g"] = 11,
        ["sublevel"] = 1,
      },
      [14] = {
        ["x"] = 482.99932054526,
        ["y"] = -221.48748266558,
        ["g"] = 11,
        ["sublevel"] = 1,
      },
      [15] = {
        ["x"] = 466.19312891581,
        ["y"] = -437.67378877603,
        ["g"] = 15,
        ["sublevel"] = 1,
      },
      [16] = {
        ["x"] = 470.02376784449,
        ["y"] = -445.33515565906,
        ["g"] = 15,
        ["sublevel"] = 1,
      },
      [17] = {
        ["x"] = 474.33138731502,
        ["y"] = -437.65566318251,
        ["g"] = 15,
        ["sublevel"] = 1,
      },
    },
  },
  [3] = {
    ["name"] = "Corpse Harvester",
    ["id"] = 166302,
    ["count"] = 4,
    ["health"] = 19891335,
    ["scale"] = 1.2,
    ["displayId"] = 98170,
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
      [334747] = {
      },
      [334748] = {
        ["interruptible"] = true,
      },
      [334749] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 667.93980785048,
        ["y"] = -144.46835294232,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 624.20941198492,
        ["y"] = -208.09410945254,
        ["g"] = 3,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 563.60449980698,
        ["y"] = -203.14888806781,
        ["g"] = 7,
        ["sublevel"] = 1,
        ["inspiring"] = true,
      },
      [4] = {
        ["x"] = 553.01145209288,
        ["y"] = -281.71541707995,
        ["g"] = 9,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 603.69209073241,
        ["y"] = -118.65563210468,
        ["g"] = 5,
        ["sublevel"] = 1,
      },
      [6] = {
        ["x"] = 589.67422083335,
        ["y"] = -119.30019639635,
        ["g"] = 5,
        ["sublevel"] = 1,
      },
      [7] = {
        ["x"] = 437.32285639441,
        ["y"] = -244.06551026581,
        ["g"] = 12,
        ["sublevel"] = 1,
      },
      [8] = {
        ["x"] = 450.90408963345,
        ["y"] = -243.9862566741,
        ["g"] = 12,
        ["sublevel"] = 1,
      },
    },
  },
  [4] = {
    ["name"] = "Stitched Vanguard",
    ["id"] = 163121,
    ["count"] = 5,
    ["health"] = 23869602,
    ["scale"] = 1.2,
    ["displayId"] = 95227,
    ["creatureType"] = "Undead",
    ["level"] = 60,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Incapacitate"] = true,
      ["Control Undead"] = true,
      ["Silence"] = true,
      ["Knock"] = true,
      ["Grip"] = true,
      ["Shackle Undead"] = true,
      ["Root"] = true,
      ["Fear"] = true,
      ["Banish"] = true,
      ["Disorient"] = true,
      ["Repentance"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
      ["Sleep Walk"] = true,
      ["Turn Evil"] = true,
    },
    ["spells"] = {
      [320696] = {
      },
      [320703] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 611.90190622133,
        ["y"] = -201.01196667453,
        ["g"] = 3,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 549.96710431975,
        ["y"] = -196.25254912141,
        ["g"] = 7,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 549.97572266345,
        ["y"] = -225.5099037197,
        ["g"] = 7,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 615.61735940086,
        ["y"] = -125.5832033063,
        ["g"] = 5,
        ["sublevel"] = 1,
      },
    },
  },
  [5] = {
    ["name"] = "Zolramus Gatekeeper",
    ["id"] = 165137,
    ["count"] = 18,
    ["health"] = 29837003,
    ["scale"] = 1.6,
    ["displayId"] = 95231,
    ["creatureType"] = "Humanoid",
    ["level"] = 60,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Mind Soothe"] = true,
    },
    ["spells"] = {
      [320462] = {
        ["interruptible"] = true,
      },
      [322756] = {
      },
      [322757] = {
      },
      [323347] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 603.64809614166,
        ["y"] = -250.25747948657,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 590.67443499617,
        ["y"] = -164.93673790632,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 512.27388411262,
        ["y"] = -275.43361249789,
        ["sublevel"] = 1,
      },
    },
  },
  [6] = {
    ["name"] = "Flesh Crafter",
    ["id"] = 165872,
    ["count"] = 4,
    ["health"] = 21880469,
    ["scale"] = 1.2,
    ["displayId"] = 96480,
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
      [323471] = {
      },
      [323489] = {
      },
      [323496] = {
      },
      [327127] = {
        ["interruptible"] = true,
      },
      [327130] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 574.42136837983,
        ["y"] = -262.9024644608,
        ["g"] = 9,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 791.08101572834,
        ["y"] = -489.3513585601,
        ["g"] = 27,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 663.45932910128,
        ["y"] = -400.50332487673,
        ["g"] = 31,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 563.3837364502,
        ["y"] = -218.07310100571,
        ["g"] = 7,
        ["sublevel"] = 1,
      },
    },
  },
  [7] = {
    ["name"] = "Blightbone",
    ["id"] = 162691,
    ["count"] = 0,
    ["health"] = 139239345,
    ["scale"] = 1.5,
    ["displayId"] = 95467,
    ["creatureType"] = "Undead",
    ["level"] = 60,
    ["isBoss"] = true,
    ["encounterID"] = 2395,
    ["instanceID"] = 0,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [320596] = {
      },
      [320637] = {
      },
      [320655] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 515.31459414337,
        ["y"] = -193.8256330087,
        ["sublevel"] = 1,
      },
    },
  },
  [8] = {
    ["name"] = "Zolramus Sorcerer",
    ["id"] = 163128,
    ["count"] = 4,
    ["health"] = 17902202,
    ["scale"] = 1.2,
    ["displayId"] = 94992,
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
      [320462] = {
        ["interruptible"] = true,
      },
      [320464] = {
      },
      [320571] = {
      },
      [320573] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 556.72407409091,
        ["y"] = -422.21801886506,
        ["g"] = 13,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 459.46143350018,
        ["y"] = -489.49246176202,
        ["g"] = 16,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 401.51801452975,
        ["y"] = -410.23941793798,
        ["g"] = 17,
        ["sublevel"] = 1,
        ["inspiring"] = true,
      },
      [4] = {
        ["x"] = 418.03664986124,
        ["y"] = -420.44061465772,
        ["g"] = 17,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 318.99427570237,
        ["y"] = -212.87654094549,
        ["g"] = 21,
        ["sublevel"] = 1,
      },
      [6] = {
        ["x"] = 367.66319676457,
        ["y"] = -235.30559678095,
        ["g"] = 20,
        ["sublevel"] = 1,
      },
      [7] = {
        ["x"] = 270.81901179835,
        ["y"] = -134.7594498139,
        ["g"] = 24,
        ["sublevel"] = 1,
      },
    },
  },
  [9] = {
    ["name"] = "Zolramus Bonecarver",
    ["id"] = 163619,
    ["count"] = 4,
    ["health"] = 19891335,
    ["scale"] = 1.2,
    ["displayId"] = 93933,
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
      [321807] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 556.21660501447,
        ["y"] = -406.71871113969,
        ["g"] = 13,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 419.66282689641,
        ["y"] = -400.75860998193,
        ["g"] = 17,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 332.55396498066,
        ["y"] = -203.89656380043,
        ["g"] = 21,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 353.47907339621,
        ["y"] = -235.06319651473,
        ["g"] = 20,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 324.51839247969,
        ["y"] = -141.55494559372,
        ["g"] = 23,
        ["sublevel"] = 1,
      },
      [6] = {
        ["x"] = 308.87511514611,
        ["y"] = -141.41578904232,
        ["g"] = 23,
        ["sublevel"] = 1,
      },
      [7] = {
        ["x"] = 246.51072067845,
        ["y"] = -155.40695791924,
        ["g"] = 24,
        ["sublevel"] = 1,
      },
    },
  },
  [10] = {
    ["name"] = "Zolramus Necromancer",
    ["id"] = 163618,
    ["count"] = 8,
    ["health"] = 27847869,
    ["scale"] = 1.4,
    ["displayId"] = 95233,
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
      [320462] = {
        ["interruptible"] = true,
      },
      [321575] = {
      },
      [321780] = {
      },
      [323957] = {
      },
      [324026] = {
      },
      [324027] = {
      },
      [327393] = {
      },
      [327396] = {
      },
      [327397] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 513.87383493737,
        ["y"] = -426.10817403343,
        ["g"] = 14,
        ["sublevel"] = 1,
        ["inspiring"] = true,
      },
      [2] = {
        ["x"] = 239.05809523587,
        ["y"] = -295.1255092448,
        ["g"] = 19,
        ["sublevel"] = 1,
        ["inspiring"] = true,
      },
      [3] = {
        ["x"] = 294.7399686657,
        ["y"] = -248.83898678706,
        ["g"] = 25,
        ["sublevel"] = 1,
      },
    },
  },
  [11] = {
    ["name"] = "Brittlebone Mage",
    ["id"] = 163126,
    ["count"] = 0,
    ["health"] = 5967401,
    ["scale"] = 0.9,
    ["displayId"] = 96112,
    ["creatureType"] = "Undead",
    ["level"] = 60,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Incapacitate"] = true,
      ["Control Undead"] = true,
      ["Silence"] = true,
      ["Knock"] = true,
      ["Grip"] = true,
      ["Shackle Undead"] = true,
      ["Root"] = true,
      ["Fear"] = true,
      ["Banish"] = true,
      ["Disorient"] = true,
      ["Repentance"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
      ["Sleep Walk"] = true,
      ["Turn Evil"] = true,
    },
    ["spells"] = {
      [320336] = {
      },
      [321576] = {
      },
      [322493] = {
      },
      [328664] = {
      },
      [328667] = {
        ["interruptible"] = true,
      },
      [333602] = {
        ["interruptible"] = true,
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 499.51595876095,
        ["y"] = -426.68244396112,
        ["g"] = 14,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 225.60082292323,
        ["y"] = -294.57419425645,
        ["g"] = 19,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 305.36338523824,
        ["y"] = -258.53486044461,
        ["g"] = 25,
        ["sublevel"] = 1,
        ["inspiring"] = true,
      },
      [4] = {
        ["x"] = 276.2452369159,
        ["y"] = -246.60748544235,
        ["g"] = 25,
        ["sublevel"] = 1,
      },
    },
  },
  [12] = {
    ["name"] = "Brittlebone Warrior",
    ["id"] = 163122,
    ["count"] = 0,
    ["health"] = 9945668,
    ["scale"] = 0.8,
    ["displayId"] = 96107,
    ["creatureType"] = "Undead",
    ["level"] = 60,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Incapacitate"] = true,
      ["Control Undead"] = true,
      ["Silence"] = true,
      ["Knock"] = true,
      ["Grip"] = true,
      ["Shackle Undead"] = true,
      ["Root"] = true,
      ["Fear"] = true,
      ["Banish"] = true,
      ["Disorient"] = true,
      ["Repentance"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
      ["Sleep Walk"] = true,
      ["Turn Evil"] = true,
    },
    ["spells"] = {
      [321576] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 504.60158766981,
        ["y"] = -437.8147632403,
        ["g"] = 14,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 503.65640718345,
        ["y"] = -414.90354425278,
        ["g"] = 14,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 252.65876845346,
        ["y"] = -294.57943965121,
        ["g"] = 19,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 238.61913603718,
        ["y"] = -310.10117266263,
        ["g"] = 19,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 240.32155450997,
        ["y"] = -280.44434435014,
        ["g"] = 19,
        ["sublevel"] = 1,
      },
      [6] = {
        ["x"] = 284.74287092791,
        ["y"] = -239.51210433365,
        ["g"] = 25,
        ["sublevel"] = 1,
      },
      [7] = {
        ["x"] = 312.87117996992,
        ["y"] = -249.26115659086,
        ["g"] = 25,
        ["sublevel"] = 1,
      },
    },
  },
  [13] = {
    ["name"] = "Skeletal Marauder",
    ["id"] = 165919,
    ["count"] = 10,
    ["health"] = 39782670,
    ["scale"] = 1.4,
    ["stealthDetect"] = true,
    ["displayId"] = 96115,
    ["creatureType"] = "Undead",
    ["level"] = 60,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [324293] = {
        ["interruptible"] = true,
      },
      [324323] = {
      },
      [343470] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 445.67782965589,
        ["y"] = -480.20852450689,
        ["g"] = 16,
        ["sublevel"] = 1,
        ["patrol"] = {
          [1] = {
            ["x"] = 445.67782965589,
            ["y"] = -480.20852450689,
          },
          [2] = {
            ["x"] = 420.98210803191,
            ["y"] = -461.58631529675,
          },
          [3] = {
            ["x"] = 419.00157053959,
            ["y"] = -449.20860330787,
          },
          [4] = {
            ["x"] = 431.37936179436,
            ["y"] = -428.90916410113,
          },
          [5] = {
            ["x"] = 453.16405879954,
            ["y"] = -434.35536477439,
          },
          [6] = {
            ["x"] = 461.58093360146,
            ["y"] = -449.20860330787,
          },
          [7] = {
            ["x"] = 465.54179721038,
            ["y"] = -467.03251597,
          },
        },
      },
      [2] = {
        ["x"] = 303.04264028389,
        ["y"] = -307.7030712744,
        ["g"] = 18,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 315.4733820958,
        ["y"] = -296.38208194206,
        ["g"] = 18,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 318.41118004449,
        ["y"] = -197.63454547813,
        ["g"] = 21,
        ["sublevel"] = 1,
        ["patrol"] = {
          [1] = {
            ["x"] = 317.73605079486,
            ["y"] = -196.73431309538,
          },
          [2] = {
            ["x"] = 332.7556977156,
            ["y"] = -187.16858575785,
          },
          [3] = {
            ["x"] = 361.56200502521,
            ["y"] = -197.74591091824,
          },
          [4] = {
            ["x"] = 359.76163633958,
            ["y"] = -209.44848752462,
          },
          [5] = {
            ["x"] = 346.70875319401,
            ["y"] = -228.80270910985,
          },
          [6] = {
            ["x"] = 319.47779550679,
            ["y"] = -230.15300363905,
          },
          [7] = {
            ["x"] = 311.60107141479,
            ["y"] = -215.29976381783,
          },
          [8] = {
            ["x"] = 307.10008965079,
            ["y"] = -201.57175142264,
          },
        },
      },
      [5] = {
        ["x"] = 258.82348046104,
        ["y"] = -145.64918973328,
        ["g"] = 24,
        ["sublevel"] = 1,
      },
    },
  },
  [14] = {
    ["name"] = "Zolramus Bonemender",
    ["id"] = 165222,
    ["count"] = 4,
    ["health"] = 19891335,
    ["scale"] = 1.2,
    ["displayId"] = 97668,
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
      [320822] = {
      },
      [335143] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 460.71346299636,
        ["y"] = -473.3192374195,
        ["g"] = 16,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 249.66074345272,
        ["y"] = -132.49818082276,
        ["g"] = 24,
        ["sublevel"] = 1,
      },
    },
  },
  [15] = {
    ["name"] = "Nar'zudah",
    ["id"] = 165824,
    ["count"] = 20,
    ["health"] = 43636564,
    ["scale"] = 1.6,
    ["stealthDetect"] = true,
    ["displayId"] = 94780,
    ["creatureType"] = "Humanoid",
    ["level"] = 60,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Mind Soothe"] = true,
    },
    ["spells"] = {
      [320462] = {
        ["interruptible"] = true,
      },
      [327393] = {
      },
      [327396] = {
      },
      [327397] = {
      },
      [335141] = {
      },
      [335142] = {
      },
      [345623] = {
      },
      [345625] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 398.17522637989,
        ["y"] = -430.95738392384,
        ["g"] = 17,
        ["sublevel"] = 1,
      },
    },
  },
  [16] = {
    ["name"] = "Skeletal Monstrosity",
    ["id"] = 165197,
    ["count"] = 24,
    ["health"] = 47739204,
    ["scale"] = 1.6,
    ["stealthDetect"] = true,
    ["displayId"] = 94814,
    ["creatureType"] = "Undead",
    ["level"] = 60,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [324372] = {
      },
      [324381] = {
      },
      [324387] = {
      },
      [324391] = {
      },
      [324394] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 193.93076912819,
        ["y"] = -118.75998426805,
        ["sublevel"] = 1,
      },
    },
  },
  [17] = {
    ["name"] = "Brittlebone Crossbowman",
    ["id"] = 166079,
    ["count"] = 0,
    ["health"] = 9945668,
    ["scale"] = 0.9,
    ["displayId"] = 96114,
    ["creatureType"] = "Undead",
    ["level"] = 60,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Incapacitate"] = true,
      ["Control Undead"] = true,
      ["Silence"] = true,
      ["Knock"] = true,
      ["Grip"] = true,
      ["Shackle Undead"] = true,
      ["Root"] = true,
      ["Fear"] = true,
      ["Banish"] = true,
      ["Disorient"] = true,
      ["Repentance"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
      ["Sleep Walk"] = true,
      ["Turn Evil"] = true,
    },
    ["spells"] = {
      [321576] = {
      },
      [328687] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 293.5098518137,
        ["y"] = -232.48105823096,
        ["g"] = 25,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 295.8889950049,
        ["y"] = -266.79329037824,
        ["g"] = 25,
        ["sublevel"] = 1,
      },
    },
  },
  [18] = {
    ["name"] = "Shuffling Corpse",
    ["id"] = 171500,
    ["count"] = 1,
    ["health"] = 7167175,
    ["scale"] = 0.7,
    ["displayId"] = 96132,
    ["creatureType"] = "Undead",
    ["level"] = 60,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Incapacitate"] = true,
      ["Control Undead"] = true,
      ["Silence"] = true,
      ["Knock"] = true,
      ["Grip"] = true,
      ["Shackle Undead"] = true,
      ["Root"] = true,
      ["Fear"] = true,
      ["Banish"] = true,
      ["Disorient"] = true,
      ["Repentance"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
      ["Sleep Walk"] = true,
      ["Turn Evil"] = true,
    },
    ["spells"] = {
    },
    ["clones"] = {
      [1] = {
        ["x"] = 329.41441088241,
        ["y"] = -164.78528822842,
        ["g"] = 22,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 320.94421543099,
        ["y"] = -164.67619269445,
        ["g"] = 22,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 346.59362754525,
        ["y"] = -165.49115374726,
        ["g"] = 22,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 346.76606039691,
        ["y"] = -174.61261293294,
        ["g"] = 22,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 337.98830703052,
        ["y"] = -165.02629923111,
        ["g"] = 22,
        ["sublevel"] = 1,
      },
      [6] = {
        ["x"] = 320.39716727821,
        ["y"] = -173.41220314537,
        ["g"] = 22,
        ["sublevel"] = 1,
      },
      [7] = {
        ["x"] = 328.90626454502,
        ["y"] = -174.03282129473,
        ["g"] = 22,
        ["sublevel"] = 1,
      },
      [8] = {
        ["x"] = 337.49527918606,
        ["y"] = -174.26470484674,
        ["g"] = 22,
        ["sublevel"] = 1,
      },
    },
  },
  [19] = {
    ["name"] = "Amarth",
    ["id"] = 163157,
    ["count"] = 0,
    ["health"] = 119348010,
    ["scale"] = 1.5,
    ["displayId"] = 94926,
    ["creatureType"] = "Beast",
    ["level"] = 60,
    ["isBoss"] = true,
    ["encounterID"] = 2391,
    ["instanceID"] = 0,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [319902] = {
      },
      [320012] = {
      },
      [320171] = {
        ["interruptible"] = true,
      },
      [320580] = {
      },
      [321226] = {
      },
      [321247] = {
      },
      [333488] = {
      },
      [333489] = {
      },
      [333492] = {
      },
      [333627] = {
      },
      [333634] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 194.27628398935,
        ["y"] = -210.28483573908,
        ["sublevel"] = 1,
      },
    },
  },
  [20] = {
    ["name"] = "Corpse Collector",
    ["id"] = 173016,
    ["count"] = 4,
    ["health"] = 19891335,
    ["scale"] = 1.2,
    ["displayId"] = 98170,
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
      [334747] = {
      },
      [334748] = {
        ["interruptible"] = true,
      },
      [334749] = {
      },
      [338353] = {
        ["interruptible"] = true,
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 658.37872531128,
        ["y"] = -493.69455514821,
        ["g"] = 26,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 729.43240288444,
        ["y"] = -406.40650135994,
        ["g"] = 28,
        ["sublevel"] = 1,
        ["patrol"] = {
          [1] = {
            ["x"] = 729.43240288444,
            ["y"] = -406.40650135994,
          },
          [2] = {
            ["x"] = 680.88945800855,
            ["y"] = -407.04621539737,
          },
          [3] = {
            ["x"] = 668.28668504936,
            ["y"] = -414.69789640616,
          },
          [4] = {
            ["x"] = 658.83461133496,
            ["y"] = -426.85057118894,
          },
          [5] = {
            ["x"] = 655.90897919335,
            ["y"] = -444.40440006857,
          },
          [6] = {
            ["x"] = 654.78373975734,
            ["y"] = -461.50814878677,
          },
          [7] = {
            ["x"] = 653.65847630137,
            ["y"] = -477.71169514717,
          },
          [8] = {
            ["x"] = 649.15751855733,
            ["y"] = -490.53949917958,
          },
          [9] = {
            ["x"] = 653.65847630137,
            ["y"] = -477.71169514717,
          },
          [10] = {
            ["x"] = 654.78373975734,
            ["y"] = -461.50814878677,
          },
          [11] = {
            ["x"] = 655.90897919335,
            ["y"] = -444.40440006857,
          },
          [12] = {
            ["x"] = 658.83461133496,
            ["y"] = -426.85057118894,
          },
          [13] = {
            ["x"] = 668.28668504936,
            ["y"] = -414.69789640616,
          },
          [14] = {
            ["x"] = 680.88945800855,
            ["y"] = -407.04621539737,
          },
          [15] = {
            ["x"] = 747.47190976952,
            ["y"] = -407.01406737033,
          },
          [16] = {
            ["x"] = 758.35539035305,
            ["y"] = -416.13819254842,
          },
          [17] = {
            ["x"] = 768.43438882811,
            ["y"] = -426.04036201895,
          },
          [18] = {
            ["x"] = 775.86099941729,
            ["y"] = -439.83267522501,
          },
          [19] = {
            ["x"] = 781.16577518907,
            ["y"] = -452.91768184937,
          },
          [20] = {
            ["x"] = 780.45842142528,
            ["y"] = -468.6550669232,
          },
          [21] = {
            ["x"] = 778.15974816695,
            ["y"] = -492.88000830414,
          },
          [22] = {
            ["x"] = 780.45842142528,
            ["y"] = -468.6550669232,
          },
          [23] = {
            ["x"] = 781.16577518907,
            ["y"] = -452.91768184937,
          },
          [24] = {
            ["x"] = 775.86099941729,
            ["y"] = -439.83267522501,
          },
          [25] = {
            ["x"] = 768.43438882811,
            ["y"] = -426.04036201895,
          },
          [26] = {
            ["x"] = 754.46528436318,
            ["y"] = -415.78454397577,
          },
          [27] = {
            ["x"] = 747.47190976952,
            ["y"] = -407.01406737033,
          },
        },
      },
      [3] = {
        ["x"] = 782.58867671449,
        ["y"] = -400.11387963808,
        ["g"] = 30,
        ["sublevel"] = 1,
        ["inspiring"] = true,
      },
      [4] = {
        ["x"] = 651.06681583353,
        ["y"] = -414.19608485353,
        ["g"] = 31,
        ["sublevel"] = 1,
      },
    },
  },
  [21] = {
    ["name"] = "Kyrian Stitchwerk",
    ["id"] = 172981,
    ["count"] = 5,
    ["health"] = 35804403,
    ["scale"] = 1.6,
    ["displayId"] = 98190,
    ["creatureType"] = "Undead",
    ["level"] = 60,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [338357] = {
      },
      [338456] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 716.00631596131,
        ["y"] = -421.50513954669,
        ["g"] = 28,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 769.11896303482,
        ["y"] = -411.21007717298,
        ["g"] = 30,
        ["sublevel"] = 1,
      },
    },
  },
  [22] = {
    ["name"] = "Spare Parts",
    ["id"] = 166264,
    ["count"] = 0,
    ["health"] = 1989134,
    ["scale"] = 0.7,
    ["displayId"] = 95577,
    ["creatureType"] = "Undead",
    ["level"] = 60,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Incapacitate"] = true,
      ["Control Undead"] = true,
      ["Silence"] = true,
      ["Knock"] = true,
      ["Grip"] = true,
      ["Shackle Undead"] = true,
      ["Root"] = true,
      ["Fear"] = true,
      ["Banish"] = true,
      ["Disorient"] = true,
      ["Repentance"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
      ["Sleep Walk"] = true,
      ["Turn Evil"] = true,
    },
    ["spells"] = {
    },
    ["clones"] = {
      [1] = {
        ["x"] = 710.75389710572,
        ["y"] = -395.08417398839,
        ["g"] = 28,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 715.62131926888,
        ["y"] = -403.81481121207,
        ["g"] = 28,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 720.50965011858,
        ["y"] = -395.18637378636,
        ["g"] = 28,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 630.46792041052,
        ["y"] = -463.58378203236,
        ["g"] = 29,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 630.34182423804,
        ["y"] = -453.03597980752,
        ["g"] = 29,
        ["sublevel"] = 1,
      },
      [6] = {
        ["x"] = 650.14799057501,
        ["y"] = -463.60984103839,
        ["g"] = 29,
        ["sublevel"] = 1,
      },
      [7] = {
        ["x"] = 640.18692633004,
        ["y"] = -452.86905270009,
        ["g"] = 29,
        ["sublevel"] = 1,
      },
      [8] = {
        ["x"] = 649.885739472,
        ["y"] = -452.91880455338,
        ["g"] = 29,
        ["sublevel"] = 1,
      },
      [9] = {
        ["x"] = 639.80514762531,
        ["y"] = -463.65383067672,
        ["g"] = 29,
        ["sublevel"] = 1,
      },
    },
  },
  [23] = {
    ["name"] = "Loyal Creation",
    ["id"] = 165911,
    ["count"] = 4,
    ["health"] = 25858736,
    ["scale"] = 1.2,
    ["displayId"] = 95226,
    ["creatureType"] = "Undead",
    ["level"] = 60,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Incapacitate"] = true,
      ["Control Undead"] = true,
      ["Silence"] = true,
      ["Knock"] = true,
      ["Grip"] = true,
      ["Shackle Undead"] = true,
      ["Root"] = true,
      ["Fear"] = true,
      ["Banish"] = true,
      ["Disorient"] = true,
      ["Repentance"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
      ["Sleep Walk"] = true,
      ["Turn Evil"] = true,
    },
    ["spells"] = {
      [320696] = {
      },
      [327155] = {
      },
      [327240] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 779.30366791343,
        ["y"] = -508.37686270123,
        ["g"] = 27,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 646.68848781275,
        ["y"] = -397.0427011852,
        ["g"] = 31,
        ["sublevel"] = 1,
      },
    },
  },
  [24] = {
    ["name"] = "Separation Assistant",
    ["id"] = 167731,
    ["count"] = 8,
    ["health"] = 39782670,
    ["scale"] = 2,
    ["displayId"] = 98227,
    ["creatureType"] = "Humanoid",
    ["level"] = 60,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Mind Soothe"] = true,
    },
    ["spells"] = {
      [323471] = {
      },
      [323489] = {
      },
      [323496] = {
      },
      [338606] = {
      },
      [338610] = {
      },
      [338636] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 731.06803408399,
        ["y"] = -461.12448984748,
        ["g"] = 32,
        ["sublevel"] = 1,
      },
    },
  },
  [25] = {
    ["name"] = "Stitching Assistant",
    ["id"] = 173044,
    ["count"] = 8,
    ["health"] = 39782670,
    ["scale"] = 2,
    ["displayId"] = 98226,
    ["creatureType"] = "Humanoid",
    ["level"] = 60,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Mind Soothe"] = true,
    },
    ["spells"] = {
      [323471] = {
      },
      [323489] = {
      },
      [323496] = {
      },
      [334748] = {
        ["interruptible"] = true,
      },
      [334749] = {
      },
      [338653] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 699.85391766764,
        ["y"] = -461.3860180844,
        ["g"] = 32,
        ["sublevel"] = 1,
      },
    },
  },
  [26] = {
    ["name"] = "Goregrind",
    ["id"] = 163621,
    ["count"] = 6,
    ["health"] = 55695738,
    ["scale"] = 1.6,
    ["displayId"] = 99122,
    ["creatureType"] = "Undead",
    ["level"] = 60,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [333477] = {
      },
      [338357] = {
      },
      [338456] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 624.5428240074,
        ["y"] = -371.75659116123,
        ["g"] = 33,
        ["sublevel"] = 1,
      },
    },
  },
  [27] = {
    ["name"] = "Goregrind Bits",
    ["id"] = 163622,
    ["count"] = 0,
    ["health"] = 19891335,
    ["scale"] = 1,
    ["displayId"] = 97800,
    ["creatureType"] = "Undead",
    ["level"] = 60,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Incapacitate"] = true,
      ["Control Undead"] = true,
      ["Silence"] = true,
      ["Knock"] = true,
      ["Grip"] = true,
      ["Shackle Undead"] = true,
      ["Root"] = true,
      ["Fear"] = true,
      ["Banish"] = true,
      ["Disorient"] = true,
      ["Repentance"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
      ["Sleep Walk"] = true,
      ["Turn Evil"] = true,
    },
    ["spells"] = {
      [338022] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 625.44512290459,
        ["y"] = -355.67367126932,
        ["g"] = 33,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 611.18932733901,
        ["y"] = -359.02789659322,
        ["g"] = 33,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 608.8711997525,
        ["y"] = -373.77563651268,
        ["g"] = 33,
        ["sublevel"] = 1,
      },
    },
  },
  [28] = {
    ["name"] = "Rotspew Leftovers",
    ["id"] = 163623,
    ["count"] = 0,
    ["health"] = 15913068,
    ["scale"] = 1,
    ["displayId"] = 97801,
    ["creatureType"] = "Undead",
    ["level"] = 60,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Incapacitate"] = true,
      ["Control Undead"] = true,
      ["Silence"] = true,
      ["Knock"] = true,
      ["Grip"] = true,
      ["Shackle Undead"] = true,
      ["Root"] = true,
      ["Fear"] = true,
      ["Banish"] = true,
      ["Disorient"] = true,
      ["Repentance"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
      ["Sleep Walk"] = true,
      ["Turn Evil"] = true,
    },
    ["spells"] = {
      [338022] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 798.61072077499,
        ["y"] = -359.3762774212,
        ["g"] = 34,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 814.3411981266,
        ["y"] = -360.66913935701,
        ["g"] = 34,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 818.95497168038,
        ["y"] = -375.99961454529,
        ["g"] = 34,
        ["sublevel"] = 1,
      },
    },
  },
  [29] = {
    ["name"] = "Rotspew",
    ["id"] = 163620,
    ["count"] = 6,
    ["health"] = 47739204,
    ["scale"] = 1.6,
    ["displayId"] = 99121,
    ["creatureType"] = "Undead",
    ["level"] = 60,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [333479] = {
      },
      [333482] = {
      },
      [333485] = {
      },
      [338456] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 802.52941754597,
        ["y"] = -374.45374126092,
        ["g"] = 34,
        ["sublevel"] = 1,
      },
    },
  },
  [30] = {
    ["name"] = "Stitchflesh's Creation",
    ["id"] = 164578,
    ["count"] = 0,
    ["health"] = 39817642,
    ["scale"] = 1.5,
    ["displayId"] = 96218,
    ["creatureType"] = "Undead",
    ["level"] = 60,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [320208] = {
      },
      [320376] = {
      },
      [322548] = {
      },
      [322681] = {
      },
      [327952] = {
      },
      [334322] = {
      },
      [348170] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 689.96627988429,
        ["y"] = -363.42445813183,
        ["g"] = 35,
        ["sublevel"] = 1,
      },
    },
  },
  [31] = {
    ["name"] = "Surgeon Stitchflesh",
    ["id"] = 162689,
    ["count"] = 0,
    ["health"] = 68798844,
    ["scale"] = 1.5,
    ["displayId"] = 96477,
    ["creatureType"] = "Humanoid",
    ["level"] = 60,
    ["isBoss"] = true,
    ["encounterID"] = 2392,
    ["instanceID"] = 0,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Mind Soothe"] = true,
    },
    ["spells"] = {
      [320200] = {
      },
      [320358] = {
      },
      [320359] = {
      },
      [320365] = {
      },
      [320366] = {
      },
      [326574] = {
      },
      [326629] = {
      },
      [327664] = {
      },
      [334321] = {
      },
      [334476] = {
      },
      [334488] = {
      },
      [343556] = {
      },
      [343558] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 718.33322226961,
        ["y"] = -364.27027304817,
        ["g"] = 35,
        ["sublevel"] = 1,
      },
    },
  },
  [32] = {
    ["name"] = "Nalthor the Rimebinder",
    ["id"] = 162693,
    ["count"] = 0,
    ["health"] = 127304544,
    ["scale"] = 1.5,
    ["displayId"] = 96085,
    ["creatureType"] = "Undead",
    ["level"] = 60,
    ["isBoss"] = true,
    ["encounterID"] = 2396,
    ["instanceID"] = 0,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [320771] = {
      },
      [320772] = {
      },
      [320784] = {
      },
      [320788] = {
      },
      [321754] = {
      },
      [321755] = {
      },
      [321894] = {
      },
      [321956] = {
      },
      [323730] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 83.974933839333,
        ["y"] = -205.5015336316,
        ["sublevel"] = 1,
      },
    },
  },
};
