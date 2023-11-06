local MDT = MDT
local L = MDT.L
local dungeonIndex = 25
MDT.dungeonList[dungeonIndex] = L["Mechagon - Junkyard"]
MDT.mapInfo[dungeonIndex] = {
  tileFormat = {
    [1] = 15,
    [2] = 15
  },
  viewportPositionOverrides =
  {
    [1] = {
      zoomScale = 1.8999998569489,
      horizontalPan = 326.95905028569,
      verticalPan = 90.852563929512,
    },
    [2] = {
      zoomScale = 5.8616151809692,
      horizontalPan = 512.38247539203,
      verticalPan = 253.02009657875,
    },
  },
};

local zones = { 1490 }
for _, zone in ipairs(zones) do
  MDT.zoneIdToDungeonIdx[zone] = dungeonIndex
end

MDT.dungeonMaps[dungeonIndex] = {
  [0] = "MechagonDungeon",
  [1] = "MechagonDungeonExterior",
  [2] = "MechagonDungeonExterior",
}
MDT.dungeonSubLevels[dungeonIndex] = {
  [1] = L["Mechagon Island"],
  [2] = L["Mechagon Island (Tunnels)"],
}

MDT.scaleMultiplier[dungeonIndex] = 0.5
MDT.dungeonTotalCount[dungeonIndex] = { normal = 332, teeming = 398, teemingEnabled = true }
MDT.mapPOIs[dungeonIndex] = {
  [1] = {
    [1] = {
      ["template"] = "MapLinkPinTemplate",
      ["type"] = "mapLink",
      ["x"] = 610.60679250533,
      ["y"] = -297.96115507462,
      ["scale"] = 0.5,
      ["target"] = 2,
      ["direction"] = -1,
      ["connectionIndex"] = 1,
    },
    [2] = {
      ["template"] = "MapLinkPinTemplate",
      ["type"] = "mapLink",
      ["x"] = 558.46857732898,
      ["y"] = -333.65168296924,
      ["scale"] = 0.5,
      ["target"] = 2,
      ["direction"] = -1,
      ["connectionIndex"] = 2,
    },
    [3] = {
      ["template"] = "MapLinkPinTemplate",
      ["type"] = "mapLink",
      ["x"] = 574.45866688737,
      ["y"] = -279.52125521908,
      ["scale"] = 0.5,
      ["target"] = 2,
      ["direction"] = -1,
      ["connectionIndex"] = 3,
    },
    [4] = {
      ["template"] = "MapLinkPinTemplate",
      ["type"] = "mechagonBot",
      ["x"] = 551.06437148011,
      ["y"] = -212.8444832396,
      ["botType"] = 1,
      ["botTypeIndex"] = 6,
    },
    [5] = {
      ["template"] = "MapLinkPinTemplate",
      ["type"] = "mechagonBot",
      ["x"] = 570.4081232409,
      ["y"] = -234.65759416891,
      ["botType"] = 2,
      ["botTypeIndex"] = 1,
    },
    [6] = {
      ["template"] = "MapLinkPinTemplate",
      ["type"] = "mechagonBot",
      ["x"] = 562.56343670748,
      ["y"] = -224.89429558233,
      ["botType"] = 3,
      ["botTypeIndex"] = 1,
    },
    [7] = {
      ["template"] = "MapLinkPinTemplate",
      ["type"] = "mechagonBot",
      ["x"] = 538.28593360371,
      ["y"] = -215.3780669261,
      ["botType"] = 3,
      ["botTypeIndex"] = 8,
    },
    [8] = {
      ["template"] = "MapLinkPinTemplate",
      ["type"] = "mechagonBot",
      ["x"] = 530.76707758754,
      ["y"] = -139.58217635844,
      ["botType"] = 3,
      ["botTypeIndex"] = 11,
    },
    [9] = {
      ["template"] = "MapLinkPinTemplate",
      ["type"] = "mechagonBot",
      ["x"] = 540.92635472145,
      ["y"] = -175.04651198904,
      ["botType"] = 3,
      ["botTypeIndex"] = 10,
      ["textAnchor"] = "RIGHT",
      ["textAnchorTo"] = "LEFT",
    },
    [10] = {
      ["template"] = "MapLinkPinTemplate",
      ["type"] = "mechagonBot",
      ["x"] = 473.22877422011,
      ["y"] = -206.38100056202,
      ["botType"] = 3,
      ["botTypeIndex"] = 12,
    },
    [11] = {
      ["template"] = "MapLinkPinTemplate",
      ["type"] = "mechagonBot",
      ["x"] = 536.25128071194,
      ["y"] = -189.66852472879,
      ["botType"] = 3,
      ["botTypeIndex"] = 9,
    },
    [12] = {
      ["template"] = "MapLinkPinTemplate",
      ["type"] = "mechagonBot",
      ["x"] = 507.60863715781,
      ["y"] = -243.80641854948,
      ["botType"] = 3,
      ["botTypeIndex"] = 13,
      ["textAnchor"] = "RIGHT",
      ["textAnchorTo"] = "LEFT",
    },
    [13] = {
      ["template"] = "MapLinkPinTemplate",
      ["type"] = "mechagonBot",
      ["x"] = 468.19847280834,
      ["y"] = -203.53954883103,
      ["botType"] = 1,
      ["botTypeIndex"] = 16,
    },
    [14] = {
      ["template"] = "MapLinkPinTemplate",
      ["type"] = "mechagonBot",
      ["x"] = 513.73813124503,
      ["y"] = -205.13106218576,
      ["botType"] = 1,
      ["botTypeIndex"] = 9,
      ["textAnchor"] = "RIGHT",
      ["textAnchorTo"] = "LEFT",
    },
    [15] = {
      ["template"] = "MapLinkPinTemplate",
      ["type"] = "mechagonBot",
      ["x"] = 508.38130358793,
      ["y"] = -230.02592508614,
      ["botType"] = 1,
      ["botTypeIndex"] = 10,
      ["textAnchor"] = "RIGHT",
      ["textAnchorTo"] = "LEFT",
    },
    [16] = {
      ["template"] = "MapLinkPinTemplate",
      ["type"] = "mechagonBot",
      ["x"] = 516.46610694203,
      ["y"] = -166.33469091189,
      ["botType"] = 1,
      ["botTypeIndex"] = 7,
      ["textAnchor"] = "RIGHT",
      ["textAnchorTo"] = "LEFT",
    },
    [17] = {
      ["template"] = "MapLinkPinTemplate",
      ["type"] = "mechagonBot",
      ["x"] = 556.82840548883,
      ["y"] = -254.04748764752,
      ["botType"] = 1,
      ["botTypeIndex"] = 1,
    },
    [18] = {
      ["template"] = "MapLinkPinTemplate",
      ["type"] = "mechagonBot",
      ["x"] = 520.24553702452,
      ["y"] = -265.29687652619,
      ["botType"] = 1,
      ["botTypeIndex"] = 12,
    },
    [19] = {
      ["template"] = "MapLinkPinTemplate",
      ["type"] = "mechagonBot",
      ["x"] = 496.41813267883,
      ["y"] = -116.93772826178,
      ["botType"] = 1,
      ["botTypeIndex"] = 8,
    },
    [20] = {
      ["template"] = "MapLinkPinTemplate",
      ["type"] = "mechagonBot",
      ["x"] = 550.57489525023,
      ["y"] = -187.08231781308,
      ["botType"] = 2,
      ["botTypeIndex"] = 6,
      ["textAnchor"] = "RIGHT",
      ["textAnchorTo"] = "LEFT",
    },
    [21] = {
      ["template"] = "MapLinkPinTemplate",
      ["type"] = "mechagonBot",
      ["x"] = 489.2563140263,
      ["y"] = -118.92712169951,
      ["botType"] = 2,
      ["botTypeIndex"] = 8,
    },
    [22] = {
      ["template"] = "MapLinkPinTemplate",
      ["type"] = "mechagonBot",
      ["x"] = 497.79772569009,
      ["y"] = -187.87968029456,
      ["botType"] = 2,
      ["botTypeIndex"] = 9,
      ["textAnchor"] = "RIGHT",
      ["textAnchorTo"] = "LEFT",
    },
    [23] = {
      ["template"] = "MapLinkPinTemplate",
      ["type"] = "mechagonBot",
      ["x"] = 511.4190611012,
      ["y"] = -208.37735018763,
      ["botType"] = 2,
      ["botTypeIndex"] = 11,
    },
    [24] = {
      ["template"] = "MapLinkPinTemplate",
      ["type"] = "mechagonBot",
      ["x"] = 494.86977577049,
      ["y"] = -191.36945506668,
      ["botType"] = 2,
      ["botTypeIndex"] = 10,
    },
    [25] = {
      ["template"] = "MapLinkPinTemplate",
      ["type"] = "mechagonBot",
      ["x"] = 532.02295809942,
      ["y"] = -228.72613757021,
      ["botType"] = 2,
      ["botTypeIndex"] = 12,
    },
    [26] = {
      ["template"] = "MapLinkPinTemplate",
      ["type"] = "mechagonBot",
      ["x"] = 659.3448129009,
      ["y"] = -315.72810679216,
      ["botType"] = 2,
      ["botTypeIndex"] = 5,
    },
    [27] = {
      ["template"] = "MapLinkPinTemplate",
      ["type"] = "mechagonBot",
      ["x"] = 556.5056967313,
      ["y"] = -148.83642133179,
      ["botType"] = 2,
      ["botTypeIndex"] = 7,
    },
    [28] = {
      ["template"] = "MapLinkPinTemplate",
      ["type"] = "mechagonBot",
      ["x"] = 544.42214188352,
      ["y"] = -329.98960490412,
      ["botType"] = 1,
      ["botTypeIndex"] = 15,
    },
    [29] = {
      ["template"] = "MapLinkPinTemplate",
      ["type"] = "mechagonBot",
      ["x"] = 596.77823559925,
      ["y"] = -352.44074204014,
      ["botType"] = 1,
      ["botTypeIndex"] = 3,
    },
    [30] = {
      ["template"] = "MapLinkPinTemplate",
      ["type"] = "mechagonBot",
      ["x"] = 567.08288779037,
      ["y"] = -304.59653072578,
      ["botType"] = 1,
      ["botTypeIndex"] = 5,
    },
    [31] = {
      ["template"] = "MapLinkPinTemplate",
      ["type"] = "mechagonBot",
      ["x"] = 590.09738341794,
      ["y"] = -301.05546920244,
      ["botType"] = 1,
      ["botTypeIndex"] = 2,
    },
    [32] = {
      ["template"] = "MapLinkPinTemplate",
      ["type"] = "mechagonBot",
      ["x"] = 637.10119258941,
      ["y"] = -302.39525882203,
      ["botType"] = 1,
      ["botTypeIndex"] = 4,
    },
    [33] = {
      ["template"] = "MapLinkPinTemplate",
      ["type"] = "mechagonBot",
      ["x"] = 540.5428343558,
      ["y"] = -333.27209326218,
      ["botType"] = 2,
      ["botTypeIndex"] = 16,
    },
    [34] = {
      ["template"] = "MapLinkPinTemplate",
      ["type"] = "mechagonBot",
      ["x"] = 503.74331369707,
      ["y"] = -275.94831310475,
      ["botType"] = 2,
      ["botTypeIndex"] = 13,
    },
    [35] = {
      ["template"] = "MapLinkPinTemplate",
      ["type"] = "mechagonBot",
      ["x"] = 559.07757956957,
      ["y"] = -292.08747935885,
      ["botType"] = 2,
      ["botTypeIndex"] = 2,
    },
    [36] = {
      ["template"] = "MapLinkPinTemplate",
      ["type"] = "mechagonBot",
      ["x"] = 621.16750899703,
      ["y"] = -329.26453635893,
      ["botType"] = 2,
      ["botTypeIndex"] = 3,
      ["textAnchor"] = "RIGHT",
      ["textAnchorTo"] = "LEFT",
    },
    [37] = {
      ["template"] = "MapLinkPinTemplate",
      ["type"] = "mechagonBot",
      ["x"] = 508.09388369307,
      ["y"] = -268.14726196017,
      ["botType"] = 3,
      ["botTypeIndex"] = 14,
      ["textAnchor"] = "RIGHT",
      ["textAnchorTo"] = "LEFT",
    },
    [38] = {
      ["template"] = "MapLinkPinTemplate",
      ["type"] = "mechagonBot",
      ["x"] = 625.50506837666,
      ["y"] = -325.89388207122,
      ["botType"] = 3,
      ["botTypeIndex"] = 5,
    },
    [39] = {
      ["template"] = "MapLinkPinTemplate",
      ["type"] = "mechagonBot",
      ["x"] = 582.93940045404,
      ["y"] = -323.46076098317,
      ["botType"] = 3,
      ["botTypeIndex"] = 4,
    },
    [40] = {
      ["template"] = "MapLinkPinTemplate",
      ["type"] = "mechagonBot",
      ["x"] = 564.09880332545,
      ["y"] = -301.81138788132,
      ["botType"] = 3,
      ["botTypeIndex"] = 7,
    },
    [41] = {
      ["template"] = "MapLinkPinTemplate",
      ["type"] = "mechagonBot",
      ["x"] = 541.40178345696,
      ["y"] = -329.82991272512,
      ["botType"] = 3,
      ["botTypeIndex"] = 15,
      ["textAnchor"] = "RIGHT",
      ["textAnchorTo"] = "LEFT",
    },
    [42] = {
      ["template"] = "MapLinkPinTemplate",
      ["type"] = "mechagonBot",
      ["x"] = 618.73302802505,
      ["y"] = -291.83494913422,
      ["botType"] = 3,
      ["botTypeIndex"] = 3,
    },
    [43] = {
      ["template"] = "MapLinkPinTemplate",
      ["type"] = "mechagonBot",
      ["x"] = 594.40817186316,
      ["y"] = -255.91895040514,
      ["botType"] = 3,
      ["botTypeIndex"] = 2,
    },
    [44] = {
      ["template"] = "MapLinkPinTemplate",
      ["type"] = "mechagonBot",
      ["x"] = 492.40373351868,
      ["y"] = -281.59674117243,
      ["botType"] = 1,
      ["botTypeIndex"] = 13,
    },
    [45] = {
      ["template"] = "MapLinkPinTemplate",
      ["type"] = "mechagonBot",
      ["x"] = 495.48728594798,
      ["y"] = -303.87790100323,
      ["botType"] = 1,
      ["botTypeIndex"] = 14,
    },
    [46] = {
      ["template"] = "MapLinkPinTemplate",
      ["type"] = "mechagonBot",
      ["x"] = 517.29742984149,
      ["y"] = -319.75288185165,
      ["botType"] = 2,
      ["botTypeIndex"] = 15,
    },
    [47] = {
      ["template"] = "MapLinkPinTemplate",
      ["type"] = "mechagonBot",
      ["x"] = 504.37857399737,
      ["y"] = -286.52084611685,
      ["botType"] = 2,
      ["botTypeIndex"] = 14,
    },
    [48] = {
      ["template"] = "MapLinkPinTemplate",
      ["type"] = "mechagonBot",
      ["x"] = 559.90337311529,
      ["y"] = -347.57321131611,
      ["botType"] = 3,
      ["botTypeIndex"] = 6,
    },
    [49] = {
      ["template"] = "DeathReleasePinTemplate",
      ["type"] = "graveyard",
      ["x"] = 600.80557421753,
      ["y"] = -207.97570465004,
      ["scale"] = 0.7,
      ["graveyardDescription"] = "",
    },
    [50] = {
      ["template"] = "VignettePinTemplate",
      ["type"] = "nyalothaSpire",
      ["x"] = 534.93111665765,
      ["y"] = -172.55633390924,
      ["scale"] = 0.7,
      ["index"] = 1,
      ["npcId"] = 161124,
      ["tooltipText"] = "Brutal Spire of Ny'alotha",
      ["weeks"] = {
        [1] = true,
        [2] = true,
        [3] = true,
        [4] = true,
        [5] = true,
        [6] = true,
        [7] = true,
        [8] = true,
        [9] = true,
        [10] = true,
        [11] = true,
        [12] = true,
      },
    },
    [51] = {
      ["template"] = "VignettePinTemplate",
      ["type"] = "nyalothaSpire",
      ["x"] = 527.67937674097,
      ["y"] = -327.16981399342,
      ["scale"] = 0.7,
      ["index"] = 2,
      ["npcId"] = 161241,
      ["tooltipText"] = "Cursed Spire of Ny'alotha",
      ["weeks"] = {
        [1] = true,
        [2] = true,
        [3] = true,
        [4] = true,
        [5] = true,
        [6] = true,
        [7] = true,
        [8] = true,
        [9] = true,
        [10] = true,
        [11] = true,
        [12] = true,
      },
    },
    [52] = {
      ["template"] = "VignettePinTemplate",
      ["type"] = "nyalothaSpire",
      ["x"] = 576.43749229974,
      ["y"] = -268.50623130873,
      ["scale"] = 0.7,
      ["index"] = 3,
      ["npcId"] = 161244,
      ["tooltipText"] = "Defiled Spire of Ny'alotha",
      ["weeks"] = {
        [1] = true,
        [2] = true,
        [5] = true,
        [6] = true,
        [9] = true,
        [10] = true,
      },
    },
    [53] = {
      ["template"] = "VignettePinTemplate",
      ["type"] = "nyalothaSpire",
      ["x"] = 483.8464170069,
      ["y"] = -289.37552297437,
      ["scale"] = 0.7,
      ["index"] = 4,
      ["npcId"] = 161243,
      ["tooltipText"] = "Entropic Spire of Ny'alotha",
      ["weeks"] = {
        [1] = true,
        [2] = true,
        [5] = true,
        [6] = true,
        [9] = true,
        [10] = true,
      },
    },
    [54] = {
      ["template"] = "VignettePinTemplate",
      ["type"] = "nyalothaSpire",
      ["x"] = 577.99812590181,
      ["y"] = -270.61464902703,
      ["scale"] = 0.7,
      ["index"] = 5,
      ["npcId"] = 161243,
      ["tooltipText"] = "Entropic Spire of Ny'alotha",
      ["weeks"] = {
        [3] = true,
        [4] = true,
        [7] = true,
        [8] = true,
        [11] = true,
        [12] = true,
      },
    },
    [55] = {
      ["template"] = "VignettePinTemplate",
      ["type"] = "nyalothaSpire",
      ["x"] = 483.39369558387,
      ["y"] = -289.7184787073,
      ["scale"] = 0.7,
      ["index"] = 6,
      ["npcId"] = 161244,
      ["tooltipText"] = "Defiled Spire of Ny'alotha",
      ["weeks"] = {
        [3] = true,
        [4] = true,
        [7] = true,
        [8] = true,
        [11] = true,
        [12] = true,
      },
    },
    [56] = {
      ["template"] = "MapLinkPinTemplate",
      ["type"] = "mechagonBot",
      ["x"] = 534.95029943284,
      ["y"] = -238.80601466935,
      ["botType"] = 1,
      ["botTypeIndex"] = 11,
      ["textAnchor"] = "RIGHT",
      ["textAnchorTo"] = "LEFT",
    },
    [57] = {
      ["template"] = "MapLinkPinTemplate",
      ["type"] = "mechagonBot",
      ["x"] = 635.97784011762,
      ["y"] = -346.19602053885,
      ["botType"] = 2,
      ["botTypeIndex"] = 4,
    },
  },
  [2] = {
    [1] = {
      ["template"] = "MapLinkPinTemplate",
      ["type"] = "mapLink",
      ["x"] = 610.60679250533,
      ["y"] = -297.96115507462,
      ["scale"] = 0.5,
      ["target"] = 1,
      ["direction"] = 1,
      ["connectionIndex"] = 1,
    },
    [2] = {
      ["template"] = "MapLinkPinTemplate",
      ["type"] = "mapLink",
      ["x"] = 558.46857732898,
      ["y"] = -333.65168296924,
      ["scale"] = 0.5,
      ["target"] = 1,
      ["direction"] = 1,
      ["connectionIndex"] = 2,
    },
    [3] = {
      ["template"] = "MapLinkPinTemplate",
      ["type"] = "mapLink",
      ["x"] = 584.04916856459,
      ["y"] = -271.00840459281,
      ["scale"] = 0.5,
      ["target"] = 1,
      ["direction"] = 1,
      ["connectionIndex"] = 3,
    },
    [4] = {
      ["template"] = "MapLinkPinTemplate",
      ["type"] = "mechagonBot",
      ["x"] = 590.280927351,
      ["y"] = -306.08658646836,
      ["botType"] = 1,
      ["botTypeIndex"] = 17,
    },
    [5] = {
      ["template"] = "MapLinkPinTemplate",
      ["type"] = "mechagonBot",
      ["x"] = 560.10336429371,
      ["y"] = -305.25034924344,
      ["botType"] = 1,
      ["botTypeIndex"] = 18,
    },
    [6] = {
      ["template"] = "MapLinkPinTemplate",
      ["type"] = "mechagonBot",
      ["x"] = 578.82099588496,
      ["y"] = -298.91144346753,
      ["botType"] = 2,
      ["botTypeIndex"] = 17,
    },
    [7] = {
      ["template"] = "MapLinkPinTemplate",
      ["type"] = "mechagonBot",
      ["x"] = 575.16221744207,
      ["y"] = -295.90008002847,
      ["botType"] = 3,
      ["botTypeIndex"] = 16,
    },
  },
};

MDT.dungeonEnemies[dungeonIndex] = {
  [1] = {
    ["name"] = "Samh'rek, Beckoner of Chaos",
    ["id"] = 161243,
    ["count"] = 4,
    ["teemingCount"] = 6,
    ["health"] = 1409996,
    ["scale"] = 1.4,
    ["stealthDetect"] = true,
    ["displayId"] = 90742,
    ["creatureType"] = "Aberration",
    ["level"] = 122,
    ["corrupted"] = true,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [314397] = {
      },
      [314477] = {
      },
      [314478] = {
      },
      [314483] = {
      },
      [314531] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 489.18105212439,
        ["y"] = -286.38534747172,
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
        ["x"] = 571.56585261331,
        ["y"] = -267.53421166375,
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
  [2] = {
    ["name"] = "Urg'roth, Breaker of Heroes",
    ["id"] = 161124,
    ["count"] = 4,
    ["teemingCount"] = 6,
    ["health"] = 1510710,
    ["scale"] = 1.4,
    ["stealthDetect"] = true,
    ["displayId"] = 89415,
    ["creatureType"] = "Aberration",
    ["level"] = 122,
    ["corrupted"] = true,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [314308] = {
      },
      [314309] = {
      },
      [314387] = {
      },
      [314397] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 539.63981644213,
        ["y"] = -166.44183844343,
        ["sublevel"] = 1,
        ["week"] = {
          [1] = true,
          [2] = true,
          [3] = true,
          [4] = true,
          [5] = true,
          [6] = true,
          [7] = true,
          [8] = true,
          [9] = true,
          [10] = true,
          [11] = true,
          [12] = true,
        },
      },
    },
  },
  [3] = {
    ["name"] = "Voidweaver Mal'thir",
    ["id"] = 161241,
    ["count"] = 4,
    ["teemingCount"] = 6,
    ["health"] = 1309282,
    ["scale"] = 1.4,
    ["stealthDetect"] = true,
    ["displayId"] = 91910,
    ["creatureType"] = "Beast",
    ["level"] = 122,
    ["corrupted"] = true,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [314397] = {
      },
      [314406] = {
      },
      [314411] = {
      },
      [314463] = {
      },
      [314467] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 522.53078887932,
        ["y"] = -323.26024782574,
        ["sublevel"] = 1,
        ["week"] = {
          [1] = true,
          [2] = true,
          [3] = true,
          [4] = true,
          [5] = true,
          [6] = true,
          [7] = true,
          [8] = true,
          [9] = true,
          [10] = true,
          [11] = true,
          [12] = true,
        },
      },
    },
  },
  [4] = {
    ["name"] = "Blood of the Corruptor",
    ["id"] = 161244,
    ["count"] = 4,
    ["teemingCount"] = 6,
    ["health"] = 1409996,
    ["scale"] = 1.4,
    ["stealthDetect"] = true,
    ["displayId"] = 92229,
    ["creatureType"] = "Aberration",
    ["level"] = 122,
    ["corrupted"] = true,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [314397] = {
      },
      [314565] = {
      },
      [314566] = {
      },
      [314592] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 571.39257884157,
        ["y"] = -266.39888201734,
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
        ["x"] = 489.03442026452,
        ["y"] = -285.30892438252,
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
  [5] = {
    ["name"] = "Scrapbone Trashtosser",
    ["id"] = 150142,
    ["count"] = 3,
    ["health"] = 212714,
    ["scale"] = 1,
    ["displayId"] = 765,
    ["creatureType"] = "Humanoid",
    ["level"] = 120,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Silence"] = true,
      ["Polymorph"] = true,
      ["Root"] = true,
      ["Disorient"] = true,
      ["Stun"] = true,
    },
    ["spells"] = {
      [300525] = {
      },
      [300547] = {
      },
      [300560] = {
      },
      [300561] = {
      },
      [316690] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 552.1773231261,
        ["y"] = -181.87659380495,
        ["g"] = 2,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 529.02014124393,
        ["y"] = -153.34373468744,
        ["g"] = 6,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 572.73025361053,
        ["y"] = -184.85501172798,
        ["g"] = 21,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 572.03049749318,
        ["y"] = -173.19416858446,
        ["g"] = 24,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 565.52439870365,
        ["y"] = -174.56044637202,
        ["g"] = 24,
        ["sublevel"] = 1,
      },
      [6] = {
        ["x"] = 582.25894852757,
        ["y"] = -173.527358726,
        ["g"] = 22,
        ["sublevel"] = 1,
      },
      [7] = {
        ["x"] = 587.11598032721,
        ["y"] = -170.17013702122,
        ["g"] = 22,
        ["sublevel"] = 1,
      },
      [8] = {
        ["x"] = 522.29873161762,
        ["y"] = -162.45570174702,
        ["g"] = 7,
        ["sublevel"] = 1,
        ["inspiring"] = true,
      },
      [9] = {
        ["x"] = 513.41049429145,
        ["y"] = -141.82024476201,
        ["g"] = 10,
        ["sublevel"] = 1,
      },
      [10] = {
        ["x"] = 509.01547158011,
        ["y"] = -143.43946012894,
        ["g"] = 10,
        ["sublevel"] = 1,
      },
      [11] = {
        ["x"] = 484.3915941286,
        ["y"] = -170.903296855,
        ["g"] = 14,
        ["sublevel"] = 1,
      },
      [12] = {
        ["x"] = 492.88533347885,
        ["y"] = -173.63366310071,
        ["g"] = 15,
        ["sublevel"] = 1,
      },
      [13] = {
        ["x"] = 491.92916011146,
        ["y"] = -179.65684829012,
        ["g"] = 15,
        ["sublevel"] = 1,
      },
      [14] = {
        ["x"] = 509.27367775042,
        ["y"] = -184.42247310314,
        ["g"] = 19,
        ["sublevel"] = 1,
        ["disguised"] = true,
      },
    },
  },
  [6] = {
    ["name"] = "Pistonhead Blaster",
    ["id"] = 150250,
    ["count"] = 3,
    ["health"] = 212714,
    ["scale"] = 1,
    ["displayId"] = 92012,
    ["creatureType"] = "Humanoid",
    ["level"] = 120,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Incapacitate"] = true,
      ["Silence"] = true,
      ["Root"] = true,
      ["Fear"] = true,
      ["Disorient"] = true,
      ["Sap"] = true,
      ["Stun"] = true,
    },
    ["spells"] = {
      [299460] = {
      },
      [299496] = {
      },
      [299497] = {
      },
      [299525] = {
      },
      [299535] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 560.53755815285,
        ["y"] = -203.38927725206,
        ["g"] = 35,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 547.77418485574,
        ["y"] = -240.81896141444,
        ["g"] = 38,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 592.99529121945,
        ["y"] = -226.15432744751,
        ["g"] = 37,
        ["sublevel"] = 1,
        ["patrol"] = {
        },
      },
      [4] = {
        ["x"] = 578.25867058948,
        ["y"] = -239.378652489,
        ["g"] = 39,
        ["sublevel"] = 1,
        ["patrol"] = {
        },
      },
      [5] = {
        ["x"] = 571.04517595398,
        ["y"] = -213.60618274431,
        ["g"] = 36,
        ["sublevel"] = 1,
        ["patrol"] = {
        },
      },
      [6] = {
        ["x"] = 534.94009610089,
        ["y"] = -216.87449656518,
        ["g"] = 29,
        ["sublevel"] = 1,
        ["inspiring"] = true,
      },
      [7] = {
        ["x"] = 515.15982938269,
        ["y"] = -241.86324219594,
        ["g"] = 32,
        ["sublevel"] = 1,
      },
      [8] = {
        ["x"] = 524.9329390079,
        ["y"] = -243.15205008374,
        ["g"] = 33,
        ["sublevel"] = 1,
        ["inspiring"] = true,
      },
      [9] = {
        ["x"] = 519.9354051045,
        ["y"] = -227.28774213302,
        ["g"] = 30,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [10] = {
        ["x"] = 521.37717472465,
        ["y"] = -231.61306425221,
        ["g"] = 30,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [11] = {
        ["x"] = 512.93814656704,
        ["y"] = -244.78157605537,
        ["g"] = 32,
        ["sublevel"] = 1,
      },
    },
  },
  [7] = {
    ["name"] = "Pistonhead Scrapper",
    ["id"] = 150249,
    ["count"] = 3,
    ["health"] = 212714,
    ["scale"] = 1,
    ["displayId"] = 92006,
    ["creatureType"] = "Humanoid",
    ["level"] = 120,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Incapacitate"] = true,
      ["Root"] = true,
      ["Fear"] = true,
      ["Disorient"] = true,
      ["Stun"] = true,
    },
    ["spells"] = {
      [299438] = {
      },
      [299449] = {
      },
      [299450] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 564.4286325781,
        ["y"] = -201.65738508659,
        ["g"] = 35,
        ["sublevel"] = 1,
        ["disguised"] = true,
      },
      [2] = {
        ["x"] = 558.90684065859,
        ["y"] = -199.66174389235,
        ["g"] = 35,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 520.47287476696,
        ["y"] = -212.36211561008,
        ["g"] = 28,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 516.13622264397,
        ["y"] = -212.45876407282,
        ["g"] = 28,
        ["sublevel"] = 1,
        ["disguised"] = true,
      },
      [5] = {
        ["x"] = 510.86392455103,
        ["y"] = -241.32626446222,
        ["g"] = 32,
        ["sublevel"] = 1,
        ["disguised"] = true,
      },
      [6] = {
        ["x"] = 528.26224443178,
        ["y"] = -245.62217454955,
        ["g"] = 33,
        ["sublevel"] = 1,
      },
      [7] = {
        ["x"] = 524.07375680912,
        ["y"] = -246.69615075747,
        ["g"] = 33,
        ["sublevel"] = 1,
      },
      [8] = {
        ["x"] = 523.23088925525,
        ["y"] = -226.66984907504,
        ["g"] = 30,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [9] = {
        ["x"] = 524.36371676599,
        ["y"] = -230.78918769004,
        ["g"] = 30,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
    },
  },
  [8] = {
    ["name"] = "Scrapbone Grinder",
    ["id"] = 150143,
    ["count"] = 3,
    ["health"] = 212714,
    ["scale"] = 1,
    ["displayId"] = 160,
    ["creatureType"] = "Humanoid",
    ["level"] = 120,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Incapacitate"] = true,
      ["Silence"] = true,
      ["Polymorph"] = true,
      ["Root"] = true,
      ["Fear"] = true,
      ["Disorient"] = true,
      ["Stun"] = true,
    },
    ["spells"] = {
      [300296] = {
      },
      [300414] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 557.60039371291,
        ["y"] = -188.11587792557,
        ["g"] = 1,
        ["sublevel"] = 1,
        ["disguised"] = true,
      },
      [2] = {
        ["x"] = 549.9072449786,
        ["y"] = -179.4615094382,
        ["g"] = 2,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 527.38594408375,
        ["y"] = -157.82264523035,
        ["g"] = 6,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 530.41223204262,
        ["y"] = -156.30950904337,
        ["g"] = 6,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 576.0201592688,
        ["y"] = -185.25962989765,
        ["g"] = 21,
        ["sublevel"] = 1,
      },
      [6] = {
        ["x"] = 573.38486064478,
        ["y"] = -181.48019630113,
        ["g"] = 23,
        ["sublevel"] = 1,
      },
      [7] = {
        ["x"] = 587.93104160208,
        ["y"] = -176.81861824205,
        ["g"] = 22,
        ["sublevel"] = 1,
      },
      [8] = {
        ["x"] = 519.23590750838,
        ["y"] = -160.59944531462,
        ["g"] = 7,
        ["sublevel"] = 1,
      },
      [9] = {
        ["x"] = 512.42739259966,
        ["y"] = -145.17434313163,
        ["g"] = 10,
        ["sublevel"] = 1,
      },
      [10] = {
        ["x"] = 480.69663752523,
        ["y"] = -168.68341517678,
        ["g"] = 14,
        ["sublevel"] = 1,
      },
      [11] = {
        ["x"] = 512.98867865429,
        ["y"] = -183.66660032358,
        ["g"] = 19,
        ["sublevel"] = 1,
      },
      [12] = {
        ["x"] = 513.48434396967,
        ["y"] = -187.46681275429,
        ["g"] = 19,
        ["sublevel"] = 1,
      },
    },
  },
  [9] = {
    ["name"] = "Scrapbone Grunter",
    ["id"] = 150547,
    ["count"] = 1,
    ["health"] = 106357,
    ["scale"] = 0.6,
    ["displayId"] = 92699,
    ["creatureType"] = "Humanoid",
    ["level"] = 120,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Silence"] = true,
      ["Polymorph"] = true,
      ["Root"] = true,
      ["Fear"] = true,
      ["Disorient"] = true,
      ["Sap"] = true,
      ["Stun"] = true,
    },
    ["spells"] = {
    },
    ["clones"] = {
      [1] = {
        ["x"] = 550.42262441325,
        ["y"] = -184.02878767349,
        ["g"] = 2,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 554.37912032828,
        ["y"] = -190.16901101777,
        ["g"] = 1,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 554.86986861487,
        ["y"] = -186.17043608333,
        ["g"] = 1,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 557.93627401314,
        ["y"] = -184.30415222146,
        ["g"] = 1,
        ["sublevel"] = 1,
        ["inspiring"] = true,
      },
      [5] = {
        ["x"] = 547.60215659016,
        ["y"] = -181.81221033689,
        ["g"] = 2,
        ["sublevel"] = 1,
      },
      [6] = {
        ["x"] = 554.26844197122,
        ["y"] = -178.042159654,
        ["g"] = 2,
        ["sublevel"] = 1,
      },
      [7] = {
        ["x"] = 544.8096957734,
        ["y"] = -170.13425721685,
        ["g"] = 3,
        ["sublevel"] = 1,
      },
      [8] = {
        ["x"] = 544.14405249008,
        ["y"] = -179.40401409267,
        ["g"] = 3,
        ["sublevel"] = 1,
      },
      [9] = {
        ["x"] = 535.22535822694,
        ["y"] = -178.87236487444,
        ["g"] = 4,
        ["sublevel"] = 1,
      },
      [10] = {
        ["x"] = 543.98036310446,
        ["y"] = -174.89233790813,
        ["g"] = 3,
        ["sublevel"] = 1,
      },
      [11] = {
        ["x"] = 533.73607039303,
        ["y"] = -181.75216345939,
        ["g"] = 4,
        ["sublevel"] = 1,
      },
      [12] = {
        ["x"] = 531.42371421246,
        ["y"] = -178.44915407349,
        ["g"] = 4,
        ["sublevel"] = 1,
      },
      [13] = {
        ["x"] = 525.25029585321,
        ["y"] = -171.44809442408,
        ["g"] = 5,
        ["sublevel"] = 1,
      },
      [14] = {
        ["x"] = 528.65713520721,
        ["y"] = -166.10309897646,
        ["g"] = 5,
        ["sublevel"] = 1,
      },
      [15] = {
        ["x"] = 528.06452943909,
        ["y"] = -162.6932235727,
        ["g"] = 5,
        ["sublevel"] = 1,
      },
      [16] = {
        ["x"] = 567.17780136111,
        ["y"] = -171.04026391482,
        ["g"] = 24,
        ["sublevel"] = 1,
      },
      [17] = {
        ["x"] = 571.92272370036,
        ["y"] = -168.26986985009,
        ["g"] = 24,
        ["sublevel"] = 1,
      },
      [18] = {
        ["x"] = 568.85543444851,
        ["y"] = -176.34740987086,
        ["g"] = 24,
        ["sublevel"] = 1,
      },
      [19] = {
        ["x"] = 583.92650470109,
        ["y"] = -176.73601163092,
        ["g"] = 22,
        ["sublevel"] = 1,
      },
      [20] = {
        ["x"] = 589.99241603612,
        ["y"] = -173.51025297628,
        ["g"] = 22,
        ["sublevel"] = 1,
      },
      [21] = {
        ["x"] = 583.3924794287,
        ["y"] = -170.09713393857,
        ["g"] = 22,
        ["sublevel"] = 1,
      },
      [22] = {
        ["x"] = 599.37301712135,
        ["y"] = -172.1327669747,
        ["g"] = 23,
        ["sublevel"] = 1,
      },
      [23] = {
        ["x"] = 604.00757380924,
        ["y"] = -175.36840717732,
        ["g"] = 23,
        ["sublevel"] = 1,
      },
      [24] = {
        ["x"] = 603.3561858591,
        ["y"] = -170.74452054876,
        ["g"] = 23,
        ["sublevel"] = 1,
      },
      [25] = {
        ["x"] = 521.06157421921,
        ["y"] = -144.01322759164,
        ["g"] = 8,
        ["sublevel"] = 1,
      },
      [26] = {
        ["x"] = 522.67254147572,
        ["y"] = -146.60866502279,
        ["g"] = 8,
        ["sublevel"] = 1,
      },
      [27] = {
        ["x"] = 519.45061464436,
        ["y"] = -146.60866502279,
        ["g"] = 8,
        ["sublevel"] = 1,
      },
      [28] = {
        ["x"] = 509.85572886536,
        ["y"] = -156.4414789185,
        ["g"] = 9,
        ["sublevel"] = 1,
      },
      [29] = {
        ["x"] = 511.92485548955,
        ["y"] = -157.26912720025,
        ["g"] = 9,
        ["sublevel"] = 1,
      },
      [30] = {
        ["x"] = 500.61525261272,
        ["y"] = -165.98138383818,
        ["g"] = 9,
        ["sublevel"] = 1,
      },
      [31] = {
        ["x"] = 484.6212484132,
        ["y"] = -156.13409517976,
        ["g"] = 13,
        ["sublevel"] = 1,
      },
      [32] = {
        ["x"] = 485.58391074312,
        ["y"] = -159.89926406475,
        ["g"] = 13,
        ["sublevel"] = 1,
        ["inspiring"] = true,
      },
      [33] = {
        ["x"] = 482.64732649812,
        ["y"] = -159.89455229655,
        ["g"] = 13,
        ["sublevel"] = 1,
      },
      [34] = {
        ["x"] = 492.76961137568,
        ["y"] = -121.03273025087,
        ["g"] = 12,
        ["sublevel"] = 1,
        ["disguised"] = true,
      },
      [35] = {
        ["x"] = 496.557491618,
        ["y"] = -121.71983053783,
        ["g"] = 12,
        ["sublevel"] = 1,
      },
      [36] = {
        ["x"] = 493.69485831082,
        ["y"] = -126.43132404422,
        ["g"] = 12,
        ["sublevel"] = 1,
      },
      [37] = {
        ["x"] = 466.68728758136,
        ["y"] = -185.51227291573,
        ["g"] = 17,
        ["sublevel"] = 1,
      },
      [38] = {
        ["x"] = 469.48316813535,
        ["y"] = -185.26374954804,
        ["g"] = 17,
        ["sublevel"] = 1,
      },
      [39] = {
        ["x"] = 481.36863052698,
        ["y"] = -178.31172848528,
        ["g"] = 16,
        ["sublevel"] = 1,
      },
      [40] = {
        ["x"] = 495.96080516276,
        ["y"] = -176.0257057482,
        ["g"] = 15,
        ["sublevel"] = 1,
      },
      [41] = {
        ["x"] = 495.53365832794,
        ["y"] = -180.12632709445,
        ["g"] = 15,
        ["sublevel"] = 1,
      },
      [42] = {
        ["x"] = 498.52369350416,
        ["y"] = -181.06605893004,
        ["g"] = 15,
        ["sublevel"] = 1,
      },
      [43] = {
        ["x"] = 515.50374517723,
        ["y"] = -177.7319245099,
        ["g"] = 20,
        ["sublevel"] = 1,
      },
      [44] = {
        ["x"] = 519.08018416516,
        ["y"] = -186.41756205201,
        ["g"] = 20,
        ["sublevel"] = 1,
        ["inspiring"] = true,
      },
      [45] = {
        ["x"] = 521.05088040576,
        ["y"] = -177.95088971475,
        ["g"] = 20,
        ["sublevel"] = 1,
      },
    },
  },
  [10] = {
    ["name"] = "Scrapbone Shaman",
    ["id"] = 150146,
    ["count"] = 3,
    ["health"] = 170172,
    ["scale"] = 1,
    ["displayId"] = 4905,
    ["creatureType"] = "Humanoid",
    ["level"] = 120,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Incapacitate"] = true,
      ["Silence"] = true,
      ["Root"] = true,
      ["Fear"] = true,
      ["Disorient"] = true,
      ["Stun"] = true,
    },
    ["spells"] = {
      [300436] = {
      },
      [300514] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 560.21127274646,
        ["y"] = -186.65920121865,
        ["g"] = 1,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 525.20701800016,
        ["y"] = -154.37267633384,
        ["g"] = 6,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 551.86885889892,
        ["y"] = -159.58165079998,
        ["sublevel"] = 1,
        ["disguised"] = true,
        ["patrol"] = {
          [1] = {
            ["x"] = 551.86885889892,
            ["y"] = -159.58165079998,
          },
          [2] = {
            ["x"] = 552.67421607235,
            ["y"] = -154.56733623081,
          },
          [3] = {
            ["x"] = 551.86885889892,
            ["y"] = -159.58165079998,
          },
          [4] = {
            ["x"] = 550.98006139361,
            ["y"] = -162.9851688528,
          },
          [5] = {
            ["x"] = 547.32704136161,
            ["y"] = -164.52049667241,
          },
          [6] = {
            ["x"] = 542.8269417182,
            ["y"] = -159.17332196167,
          },
          [7] = {
            ["x"] = 547.32704136161,
            ["y"] = -164.52049667241,
          },
          [8] = {
            ["x"] = 550.98006139361,
            ["y"] = -162.9851688528,
          },
        },
      },
      [4] = {
        ["x"] = 520.44246323597,
        ["y"] = -165.42570805579,
        ["g"] = 7,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 481.32134267016,
        ["y"] = -171.76389915145,
        ["g"] = 14,
        ["sublevel"] = 1,
      },
      [6] = {
        ["x"] = 507.31696272,
        ["y"] = -188.06852241251,
        ["g"] = 19,
        ["sublevel"] = 1,
      },
      [7] = {
        ["x"] = 510.56687002247,
        ["y"] = -140.11292433301,
        ["g"] = 10,
        ["sublevel"] = 1,
        ["teeming"] = true,
      },
    },
  },
  [11] = {
    ["name"] = "Malfunctioning Scrapbot",
    ["id"] = 152009,
    ["count"] = 5,
    ["health"] = 340343,
    ["scale"] = 1.2,
    ["displayId"] = 91017,
    ["creatureType"] = "Mechanical",
    ["level"] = 121,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [294884] = {
      },
      [294890] = {
      },
      [294894] = {
      },
      [300102] = {
      },
      [300129] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 525.64240251319,
        ["y"] = -182.87140315281,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 580.1560949637,
        ["y"] = -180.6734605043,
        ["g"] = 22,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 509.61663013617,
        ["y"] = -151.24187236741,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 492.24689078648,
        ["y"] = -164.68502059003,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 483.04926833696,
        ["y"] = -192.4494856037,
        ["sublevel"] = 1,
      },
      [6] = {
        ["x"] = 541.69917135016,
        ["y"] = -197.56708221353,
        ["sublevel"] = 1,
      },
      [7] = {
        ["x"] = 606.42067937106,
        ["y"] = -281.81432841781,
        ["g"] = 40,
        ["sublevel"] = 1,
      },
      [8] = {
        ["x"] = 590.03485268592,
        ["y"] = -257.50785345012,
        ["sublevel"] = 1,
      },
      [9] = {
        ["x"] = 612.24230271709,
        ["y"] = -279.00766593838,
        ["g"] = 40,
        ["sublevel"] = 1,
        ["teeming"] = true,
      },
    },
  },
  [12] = {
    ["name"] = "Weaponized Crawler",
    ["id"] = 150253,
    ["count"] = 10,
    ["health"] = 425429,
    ["scale"] = 1.4,
    ["displayId"] = 90711,
    ["creatureType"] = "Mechanical",
    ["level"] = 121,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [300188] = {
      },
      [300207] = {
      },
      [300211] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 554.22812127344,
        ["y"] = -223.46513333378,
        ["sublevel"] = 1,
        ["patrol"] = {
          [1] = {
            ["x"] = 554.22812127344,
            ["y"] = -223.46513333378,
          },
          [2] = {
            ["x"] = 557.23992424195,
            ["y"] = -212.13497391121,
          },
          [3] = {
            ["x"] = 554.22812127344,
            ["y"] = -223.46513333378,
          },
          [4] = {
            ["x"] = 552.07680273988,
            ["y"] = -229.48877194659,
          },
          [5] = {
            ["x"] = 548.9215734479,
            ["y"] = -233.79136294013,
          },
          [6] = {
            ["x"] = 555.08862259027,
            ["y"] = -235.22556814452,
          },
          [7] = {
            ["x"] = 561.11226229104,
            ["y"] = -233.64794734362,
          },
          [8] = {
            ["x"] = 567.70956437785,
            ["y"] = -231.06638659258,
          },
          [9] = {
            ["x"] = 561.11226229104,
            ["y"] = -233.64794734362,
          },
          [10] = {
            ["x"] = 555.08862259027,
            ["y"] = -235.22556814452,
          },
          [11] = {
            ["x"] = 548.9215734479,
            ["y"] = -233.79136294013,
          },
          [12] = {
            ["x"] = 552.07680273988,
            ["y"] = -229.48877194659,
          },
        },
      },
      [2] = {
        ["x"] = 532.85723999372,
        ["y"] = -233.95396682962,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 509.19948319518,
        ["y"] = -235.18284089714,
        ["g"] = 31,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 563.46524618433,
        ["y"] = -259.7149897343,
        ["sublevel"] = 1,
        ["patrol"] = {
          [1] = {
            ["x"] = 563.46524618433,
            ["y"] = -259.7149897343,
          },
          [2] = {
            ["x"] = 571.13332741934,
            ["y"] = -259.1177844876,
          },
          [3] = {
            ["x"] = 578.9366411802,
            ["y"] = -262.92426565765,
          },
          [4] = {
            ["x"] = 586.07379439503,
            ["y"] = -263.01943320019,
          },
          [5] = {
            ["x"] = 590.45126448466,
            ["y"] = -258.83230227957,
          },
          [6] = {
            ["x"] = 586.07379439503,
            ["y"] = -263.01943320019,
          },
          [7] = {
            ["x"] = 578.9366411802,
            ["y"] = -262.92426565765,
          },
          [8] = {
            ["x"] = 571.13332741934,
            ["y"] = -259.1177844876,
          },
          [9] = {
            ["x"] = 563.46524618433,
            ["y"] = -259.7149897343,
          },
          [10] = {
            ["x"] = 560.38001178387,
            ["y"] = -267.68238141393,
          },
          [11] = {
            ["x"] = 556.6686859046,
            ["y"] = -273.58243417018,
          },
          [12] = {
            ["x"] = 555.43156911034,
            ["y"] = -278.05505546667,
          },
          [13] = {
            ["x"] = 556.6686859046,
            ["y"] = -273.58243417018,
          },
          [14] = {
            ["x"] = 560.38001178387,
            ["y"] = -267.68238141393,
          },
        },
      },
    },
  },
  [13] = {
    ["name"] = "Scraphound",
    ["id"] = 150254,
    ["count"] = 3,
    ["health"] = 212714,
    ["scale"] = 1,
    ["stealthDetect"] = true,
    ["displayId"] = 90510,
    ["creatureType"] = "Mechanical",
    ["level"] = 120,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Silence"] = true,
      ["Stun"] = true,
    },
    ["spells"] = {
      [294107] = {
      },
      [299475] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 546.33997965134,
        ["y"] = -236.94661721044,
        ["g"] = 38,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 590.89104111179,
        ["y"] = -229.27239013254,
        ["g"] = 37,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 596.19947893282,
        ["y"] = -228.907330927,
        ["g"] = 37,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 575.8492102892,
        ["y"] = -243.19988210472,
        ["g"] = 39,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 580.57590175804,
        ["y"] = -242.75691662512,
        ["g"] = 39,
        ["sublevel"] = 1,
      },
      [6] = {
        ["x"] = 569.21961588733,
        ["y"] = -217.30262878107,
        ["g"] = 36,
        ["sublevel"] = 1,
        ["inspiring"] = true,
      },
      [7] = {
        ["x"] = 573.20671335716,
        ["y"] = -216.99232489877,
        ["g"] = 36,
        ["sublevel"] = 1,
      },
      [8] = {
        ["x"] = 532.21166173061,
        ["y"] = -214.05305018863,
        ["g"] = 29,
        ["sublevel"] = 1,
      },
      [9] = {
        ["x"] = 533.88896581337,
        ["y"] = -220.51914922482,
        ["g"] = 29,
        ["sublevel"] = 1,
      },
      [10] = {
        ["x"] = 518.34881293709,
        ["y"] = -209.00963517273,
        ["g"] = 28,
        ["sublevel"] = 1,
        ["teeming"] = true,
      },
      [11] = {
        ["x"] = 530.73194166981,
        ["y"] = -217.72374344545,
        ["g"] = 29,
        ["sublevel"] = 1,
        ["teeming"] = true,
      },
    },
  },
  [14] = {
    ["name"] = "Pistonhead Mechanic",
    ["id"] = 150251,
    ["count"] = 3,
    ["health"] = 255257,
    ["scale"] = 1,
    ["displayId"] = 92025,
    ["creatureType"] = "Humanoid",
    ["level"] = 120,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Incapacitate"] = true,
      ["Fear"] = true,
      ["Disorient"] = true,
      ["Stun"] = true,
    },
    ["spells"] = {
      [273185] = {
      },
      [299588] = {
      },
      [300087] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 551.35969171181,
        ["y"] = -240.10185881224,
        ["g"] = 38,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 518.58018958714,
        ["y"] = -215.31092507786,
        ["g"] = 28,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 512.9068857389,
        ["y"] = -232.29926630018,
        ["g"] = 31,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 526.5263931021,
        ["y"] = -228.11162956432,
        ["g"] = 30,
        ["sublevel"] = 1,
        ["scale"] = 1,
        ["disguised"] = true,
        ["patrol"] = {
          [1] = {
            ["x"] = 526.5263931021,
            ["y"] = -228.11162956432,
          },
          [2] = {
            ["x"] = 529.51292630428,
            ["y"] = -224.50719446499,
          },
          [3] = {
            ["x"] = 527.76220573556,
            ["y"] = -218.22518153164,
          },
          [4] = {
            ["x"] = 522.92196684194,
            ["y"] = -215.34164229134,
          },
          [5] = {
            ["x"] = 517.46382605117,
            ["y"] = -217.81324987993,
          },
          [6] = {
            ["x"] = 515.81609060517,
            ["y"] = -222.55050365083,
          },
          [7] = {
            ["x"] = 516.7429390313,
            ["y"] = -228.00863560244,
          },
          [8] = {
            ["x"] = 521.89212445392,
            ["y"] = -229.2444482359,
          },
          [9] = {
            ["x"] = 526.5263931021,
            ["y"] = -228.11162956432,
          },
        },
      },
    },
  },
  [15] = {
    ["name"] = "Saurolisk Bonenipper",
    ["id"] = 150154,
    ["count"] = 3,
    ["health"] = 212714,
    ["scale"] = 1,
    ["displayId"] = 77484,
    ["creatureType"] = "Beast",
    ["level"] = 120,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Stun"] = true,
    },
    ["spells"] = {
      [299474] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 559.56716043185,
        ["y"] = -160.15834250975,
        ["g"] = 25,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 564.96877990576,
        ["y"] = -158.63535484929,
        ["g"] = 25,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 555.07228075115,
        ["y"] = -167.28713456805,
        ["g"] = 26,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 551.38110375742,
        ["y"] = -165.1231570844,
        ["g"] = 26,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 552.47365105443,
        ["y"] = -150.86422790574,
        ["sublevel"] = 1,
      },
      [6] = {
        ["x"] = 541.43360700849,
        ["y"] = -156.70407958468,
        ["sublevel"] = 1,
      },
      [7] = {
        ["x"] = 497.21560964504,
        ["y"] = -125.43206920519,
        ["g"] = 12,
        ["sublevel"] = 1,
      },
      [8] = {
        ["x"] = 490.18696885505,
        ["y"] = -124.89139525075,
        ["g"] = 12,
        ["sublevel"] = 1,
      },
      [9] = {
        ["x"] = 473.118811226,
        ["y"] = -172.93259454576,
        ["sublevel"] = 1,
      },
      [10] = {
        ["x"] = 476.54886500521,
        ["y"] = -179.61065884397,
        ["g"] = 16,
        ["sublevel"] = 1,
      },
      [11] = {
        ["x"] = 462.78396187026,
        ["y"] = -187.08528543059,
        ["g"] = 17,
        ["sublevel"] = 1,
      },
      [12] = {
        ["x"] = 479.45208502288,
        ["y"] = -198.04722992198,
        ["g"] = 18,
        ["sublevel"] = 1,
      },
      [13] = {
        ["x"] = 468.13887128726,
        ["y"] = -195.71159898206,
        ["g"] = 18,
        ["sublevel"] = 1,
      },
      [14] = {
        ["x"] = 472.29921331168,
        ["y"] = -198.77711498224,
        ["g"] = 18,
        ["sublevel"] = 1,
      },
    },
  },
  [16] = {
    ["name"] = "Scrapbone Bully",
    ["id"] = 150160,
    ["count"] = 4,
    ["health"] = 340343,
    ["scale"] = 1.4,
    ["displayId"] = 11611,
    ["creatureType"] = "Humanoid",
    ["level"] = 121,
    ["instanceID"] = 1178,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [300414] = {
      },
      [300424] = {
      },
      [300427] = {
      },
      [300434] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 549.36739092281,
        ["y"] = -173.58251446884,
        ["g"] = 3,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 517.21382244627,
        ["y"] = -152.16648255968,
        ["sublevel"] = 1,
        ["disguised"] = true,
        ["patrol"] = {
          [1] = {
            ["x"] = 517.21382244627,
            ["y"] = -152.16648255968,
          },
          [2] = {
            ["x"] = 521.59921449116,
            ["y"] = -151.66529889187,
          },
          [3] = {
            ["x"] = 525.67136539937,
            ["y"] = -149.53524679503,
          },
          [4] = {
            ["x"] = 528.30259847544,
            ["y"] = -143.89688751488,
          },
          [5] = {
            ["x"] = 525.67136539937,
            ["y"] = -149.53524679503,
          },
          [6] = {
            ["x"] = 521.59921449116,
            ["y"] = -151.66529889187,
          },
          [7] = {
            ["x"] = 517.21382244627,
            ["y"] = -152.16648255968,
          },
          [8] = {
            ["x"] = 511.38751256924,
            ["y"] = -152.16648255968,
          },
          [9] = {
            ["x"] = 510.13454264539,
            ["y"] = -155.86274302845,
          },
          [10] = {
            ["x"] = 512.64048249309,
            ["y"] = -159.99754323944,
          },
          [11] = {
            ["x"] = 515.77290999129,
            ["y"] = -163.19261466324,
          },
          [12] = {
            ["x"] = 512.64048249309,
            ["y"] = -159.99754323944,
          },
          [13] = {
            ["x"] = 510.13454264539,
            ["y"] = -155.86274302845,
          },
          [14] = {
            ["x"] = 511.38751256924,
            ["y"] = -152.16648255968,
          },
        },
      },
      [3] = {
        ["x"] = 499.86129787229,
        ["y"] = -144.9505364921,
        ["g"] = 11,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 498.50333993948,
        ["y"] = -150.78427151537,
        ["g"] = 11,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 484.55264296987,
        ["y"] = -182.60138242731,
        ["g"] = 16,
        ["sublevel"] = 1,
      },
    },
  },
  [17] = {
    ["name"] = "Heavy Scrapbot",
    ["id"] = 150276,
    ["count"] = 5,
    ["health"] = 340343,
    ["scale"] = 1.4,
    ["displayId"] = 90773,
    ["creatureType"] = "Mechanical",
    ["level"] = 121,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [300159] = {
      },
      [300160] = {
      },
      [300171] = {
      },
      [300177] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 523.05219868618,
        ["y"] = -204.17296216281,
        ["g"] = 27,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 528.59932765005,
        ["y"] = -206.21664784914,
        ["g"] = 27,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 533.06023740219,
        ["y"] = -249.50266213977,
        ["g"] = 34,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 530.01503921381,
        ["y"] = -254.45109081826,
        ["g"] = 34,
        ["sublevel"] = 1,
      },
    },
  },
  [18] = {
    ["name"] = "Naeno Megacrash",
    ["id"] = 153755,
    ["count"] = 0,
    ["health"] = 575235,
    ["scale"] = 1,
    ["displayId"] = 92000,
    ["creatureType"] = "Humanoid",
    ["level"] = 122,
    ["isBoss"] = true,
    ["encounterID"] = 2360,
    ["instanceID"] = 1178,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [298898] = {
      },
      [298940] = {
      },
      [298946] = {
      },
      [298947] = {
      },
      [299241] = {
      },
      [303525] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 507.881217617,
        ["y"] = -215.30789442789,
        ["g"] = 56,
        ["sublevel"] = 1,
      },
    },
  },
  [19] = {
    ["name"] = "Trixie Tazer",
    ["id"] = 150712,
    ["count"] = 0,
    ["health"] = 766980,
    ["scale"] = 1,
    ["displayId"] = 92001,
    ["creatureType"] = "Humanoid",
    ["level"] = 122,
    ["isBoss"] = true,
    ["encounterID"] = 2360,
    ["instanceID"] = 1178,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [298669] = {
      },
      [298849] = {
      },
      [298897] = {
      },
      [299153] = {
      },
      [302681] = {
      },
      [302682] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 506.95981930495,
        ["y"] = -222.94436554572,
        ["g"] = 56,
        ["sublevel"] = 1,
      },
    },
  },
  [20] = {
    ["name"] = "King Gobbamak",
    ["id"] = 150159,
    ["count"] = 0,
    ["health"] = 1491350,
    ["scale"] = 1.2,
    ["displayId"] = 90502,
    ["creatureType"] = "Humanoid",
    ["level"] = 122,
    ["isBoss"] = true,
    ["encounterID"] = 2357,
    ["instanceID"] = 1178,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [297254] = {
      },
      [297256] = {
      },
      [297257] = {
      },
      [297261] = {
      },
      [297262] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 488.59605732131,
        ["y"] = -146.29014755791,
        ["sublevel"] = 1,
      },
    },
  },
  [21] = {
    ["name"] = "Gnome-Eating Slime",
    ["id"] = 150195,
    ["count"] = 3,
    ["health"] = 106357,
    ["scale"] = 0.6,
    ["displayId"] = 91656,
    ["creatureType"] = "Elemental",
    ["level"] = 120,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Incapacitate"] = true,
      ["Silence"] = true,
      ["Fear"] = true,
      ["Disorient"] = true,
      ["Stun"] = true,
    },
    ["spells"] = {
      [300818] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 546.55546101291,
        ["y"] = -290.38306506461,
        ["g"] = 43,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 550.89456360971,
        ["y"] = -293.31746770731,
        ["g"] = 43,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 556.23357447227,
        ["y"] = -290.41003253359,
        ["g"] = 43,
        ["sublevel"] = 1,
        ["inspiring"] = true,
      },
      [4] = {
        ["x"] = 577.74744980212,
        ["y"] = -327.92081535516,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 601.16358798141,
        ["y"] = -332.35755927455,
        ["sublevel"] = 1,
      },
      [6] = {
        ["x"] = 619.91399155749,
        ["y"] = -325.15761318913,
        ["sublevel"] = 1,
      },
      [7] = {
        ["x"] = 635.51832747306,
        ["y"] = -328.47453802399,
        ["sublevel"] = 1,
      },
      [8] = {
        ["x"] = 649.31186325111,
        ["y"] = -338.96095039562,
        ["sublevel"] = 1,
        ["inspiring"] = true,
      },
      [9] = {
        ["x"] = 622.90880875601,
        ["y"] = -305.14294550427,
        ["sublevel"] = 1,
      },
      [10] = {
        ["x"] = 656.4212766229,
        ["y"] = -317.62686649254,
        ["sublevel"] = 1,
      },
      [11] = {
        ["x"] = 645.64559796025,
        ["y"] = -278.44839782558,
        ["sublevel"] = 1,
      },
      [12] = {
        ["x"] = 655.59048477315,
        ["y"] = -266.75060921408,
        ["sublevel"] = 1,
      },
      [13] = {
        ["x"] = 644.22208206685,
        ["y"] = -261.43312945006,
        ["sublevel"] = 1,
      },
      [14] = {
        ["x"] = 632.48695973867,
        ["y"] = -262.90002367559,
        ["sublevel"] = 1,
      },
      [15] = {
        ["x"] = 572.00551149278,
        ["y"] = -295.34347579884,
        ["sublevel"] = 2,
      },
      [16] = {
        ["x"] = 574.3186912054,
        ["y"] = -301.27098175029,
        ["sublevel"] = 2,
      },
      [17] = {
        ["x"] = 584.11849197084,
        ["y"] = -309.11275049035,
        ["sublevel"] = 2,
      },
    },
  },
  [22] = {
    ["name"] = "Toxic Lurker",
    ["id"] = 150169,
    ["count"] = 4,
    ["health"] = 221223,
    ["scale"] = 1,
    ["displayId"] = 40976,
    ["creatureType"] = "Elemental",
    ["level"] = 120,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Incapacitate"] = true,
      ["Fear"] = true,
      ["Disorient"] = true,
      ["Stun"] = true,
    },
    ["spells"] = {
      [300650] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 590.96058950193,
        ["y"] = -351.30842065191,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 603.42432017277,
        ["y"] = -336.86631295812,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 606.6650322833,
        ["y"] = -314.15427359351,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 628.17126746062,
        ["y"] = -330.45705276065,
        ["sublevel"] = 1,
        ["disguised"] = true,
      },
      [5] = {
        ["x"] = 610.91728037201,
        ["y"] = -343.76728451883,
        ["sublevel"] = 1,
      },
      [6] = {
        ["x"] = 636.55181461026,
        ["y"] = -341.5489222677,
        ["sublevel"] = 1,
      },
      [7] = {
        ["x"] = 653.48523878837,
        ["y"] = -352.18047716393,
        ["sublevel"] = 1,
        ["disguised"] = true,
      },
      [8] = {
        ["x"] = 637.22342553545,
        ["y"] = -314.1786520455,
        ["sublevel"] = 1,
      },
      [9] = {
        ["x"] = 656.84522104382,
        ["y"] = -302.46970991468,
        ["sublevel"] = 1,
      },
      [10] = {
        ["x"] = 667.32613721141,
        ["y"] = -299.74132390101,
        ["sublevel"] = 1,
      },
      [11] = {
        ["x"] = 623.18893277608,
        ["y"] = -259.28393407902,
        ["sublevel"] = 1,
        ["disguised"] = true,
      },
      [12] = {
        ["x"] = 563.92990837141,
        ["y"] = -309.02801359821,
        ["sublevel"] = 2,
        ["disguised"] = true,
        ["patrol"] = {
          [1] = {
            ["x"] = 563.92990837141,
            ["y"] = -309.02801359821,
          },
          [2] = {
            ["x"] = 562.08126213092,
            ["y"] = -313.83448007207,
          },
          [3] = {
            ["x"] = 560.72558328481,
            ["y"] = -322.09175532973,
          },
          [4] = {
            ["x"] = 559.49317008785,
            ["y"] = -327.02146629669,
          },
          [5] = {
            ["x"] = 560.72558328481,
            ["y"] = -322.09175532973,
          },
          [6] = {
            ["x"] = 562.08126213092,
            ["y"] = -313.83448007207,
          },
          [7] = {
            ["x"] = 563.92990837141,
            ["y"] = -309.02801359821,
          },
          [8] = {
            ["x"] = 569.10609245755,
            ["y"] = -302.98910748234,
          },
        },
      },
      [13] = {
        ["x"] = 588.38229667253,
        ["y"] = -311.69349314333,
        ["sublevel"] = 2,
      },
      [14] = {
        ["x"] = 582.22733988647,
        ["y"] = -331.03547120531,
        ["sublevel"] = 1,
        ["teeming"] = true,
      },
    },
  },
  [23] = {
    ["name"] = "Mechagon Renormalizer",
    ["id"] = 150297,
    ["count"] = 4,
    ["health"] = 170172,
    ["scale"] = 1,
    ["displayId"] = 92207,
    ["creatureType"] = "Humanoid",
    ["level"] = 120,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Silence"] = true,
      ["Mind Control"] = true,
      ["Polymorph"] = true,
      ["Root"] = true,
      ["Fear"] = true,
      ["Disorient"] = true,
      ["Stun"] = true,
    },
    ["spells"] = {
      [284219] = {
      },
      [301629] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 585.52199920556,
        ["y"] = -301.92031074174,
        ["g"] = 42,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 524.64249833298,
        ["y"] = -332.8142663832,
        ["g"] = 48,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 500.47366466622,
        ["y"] = -296.93136653522,
        ["g"] = 52,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 512.58836705104,
        ["y"] = -292.29551035265,
        ["g"] = 51,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 494.50818707207,
        ["y"] = -314.380735423,
        ["g"] = 54,
        ["sublevel"] = 1,
      },
      [6] = {
        ["x"] = 518.87053366406,
        ["y"] = -295.30087023571,
        ["g"] = 50,
        ["sublevel"] = 1,
      },
    },
  },
  [24] = {
    ["name"] = "Mechagon Trooper",
    ["id"] = 155094,
    ["count"] = 3,
    ["health"] = 212714,
    ["scale"] = 1,
    ["displayId"] = 90851,
    ["creatureType"] = "Humanoid",
    ["level"] = 120,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Incapacitate"] = true,
      ["Silence"] = true,
      ["Root"] = true,
      ["Fear"] = true,
      ["Disorient"] = true,
      ["Stun"] = true,
    },
    ["spells"] = {
      [299498] = {
      },
      [299502] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 589.04846079122,
        ["y"] = -304.52343020329,
        ["g"] = 42,
        ["sublevel"] = 1,
        ["disguised"] = true,
      },
      [2] = {
        ["x"] = 585.96988457294,
        ["y"] = -305.91600527673,
        ["g"] = 42,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 537.29570750996,
        ["y"] = -324.13532099222,
        ["g"] = 47,
        ["sublevel"] = 1,
        ["disguised"] = true,
      },
      [4] = {
        ["x"] = 534.18980327011,
        ["y"] = -326.54368957259,
        ["g"] = 47,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 520.37829016138,
        ["y"] = -333.20531541523,
        ["g"] = 48,
        ["sublevel"] = 1,
      },
      [6] = {
        ["x"] = 548.6582570655,
        ["y"] = -307.39143553806,
        ["g"] = 45,
        ["sublevel"] = 1,
      },
      [7] = {
        ["x"] = 548.41040668091,
        ["y"] = -311.60470771633,
        ["g"] = 45,
        ["sublevel"] = 1,
      },
      [8] = {
        ["x"] = 489.1060843352,
        ["y"] = -293.09738009591,
        ["g"] = 53,
        ["sublevel"] = 1,
      },
      [9] = {
        ["x"] = 488.34370129534,
        ["y"] = -296.24662424319,
        ["g"] = 53,
        ["sublevel"] = 1,
      },
      [10] = {
        ["x"] = 491.69987199544,
        ["y"] = -297.11923046881,
        ["g"] = 53,
        ["sublevel"] = 1,
      },
      [11] = {
        ["x"] = 498.02167539878,
        ["y"] = -299.89184791031,
        ["g"] = 52,
        ["sublevel"] = 1,
        ["disguised"] = true,
      },
      [12] = {
        ["x"] = 501.88191594407,
        ["y"] = -300.21894384607,
        ["g"] = 52,
        ["sublevel"] = 1,
      },
      [13] = {
        ["x"] = 509.76062431484,
        ["y"] = -289.47473237177,
        ["g"] = 51,
        ["sublevel"] = 1,
      },
      [14] = {
        ["x"] = 509.04174868117,
        ["y"] = -293.10806208287,
        ["g"] = 51,
        ["sublevel"] = 1,
        ["inspiring"] = true,
      },
      [15] = {
        ["x"] = 500.40284858852,
        ["y"] = -317.54164143176,
        ["g"] = 54,
        ["sublevel"] = 1,
      },
      [16] = {
        ["x"] = 494.76447957245,
        ["y"] = -311.04898424542,
        ["g"] = 54,
        ["sublevel"] = 1,
        ["disguised"] = true,
      },
      [17] = {
        ["x"] = 521.94546207417,
        ["y"] = -298.46629065155,
        ["g"] = 50,
        ["sublevel"] = 1,
      },
    },
  },
  [25] = {
    ["name"] = "Slime Elemental",
    ["id"] = 150165,
    ["count"] = 4,
    ["health"] = 212714,
    ["scale"] = 1,
    ["displayId"] = 4907,
    ["creatureType"] = "Elemental",
    ["level"] = 120,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Incapacitate"] = true,
      ["Silence"] = true,
      ["Fear"] = true,
      ["Disorient"] = true,
      ["Stun"] = true,
    },
    ["spells"] = {
      [300764] = {
      },
      [300777] = {
      },
      [300816] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 551.68709835703,
        ["y"] = -286.71718491618,
        ["g"] = 43,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 579.9658576021,
        ["y"] = -347.39318725239,
        ["g"] = 41,
        ["sublevel"] = 1,
        ["inspiring"] = true,
      },
      [3] = {
        ["x"] = 582.80041769692,
        ["y"] = -351.82993646079,
        ["g"] = 41,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 577.5771302148,
        ["y"] = -338.07743333955,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 616.33997502428,
        ["y"] = -332.67543794287,
        ["sublevel"] = 1,
      },
      [6] = {
        ["x"] = 626.56911008109,
        ["y"] = -346.6018763477,
        ["sublevel"] = 1,
      },
      [7] = {
        ["x"] = 628.41777263185,
        ["y"] = -321.21384376673,
        ["sublevel"] = 1,
      },
      [8] = {
        ["x"] = 643.64263439491,
        ["y"] = -334.27772203824,
        ["sublevel"] = 1,
      },
      [9] = {
        ["x"] = 663.1150571532,
        ["y"] = -333.04529492169,
        ["sublevel"] = 1,
      },
      [10] = {
        ["x"] = 664.34745986849,
        ["y"] = -341.54905454128,
        ["sublevel"] = 1,
      },
      [11] = {
        ["x"] = 674.45344154859,
        ["y"] = -348.32742321279,
        ["sublevel"] = 1,
      },
      [12] = {
        ["x"] = 653.98688602137,
        ["y"] = -306.27522232674,
        ["sublevel"] = 1,
      },
      [13] = {
        ["x"] = 653.71347004132,
        ["y"] = -283.85753328845,
        ["sublevel"] = 1,
      },
      [14] = {
        ["x"] = 665.54026637321,
        ["y"] = -276.70644951329,
        ["sublevel"] = 1,
      },
      [15] = {
        ["x"] = 637.2109532837,
        ["y"] = -273.31426350215,
        ["sublevel"] = 1,
      },
      [16] = {
        ["x"] = 649.21580736153,
        ["y"] = -323.95376300579,
        ["sublevel"] = 1,
        ["teeming"] = true,
      },
      [17] = {
        ["x"] = 600.77962098128,
        ["y"] = -348.51960278203,
        ["sublevel"] = 1,
        ["teeming"] = true,
      },
    },
  },
  [26] = {
    ["name"] = "Anodized Coilbearer",
    ["id"] = 155090,
    ["count"] = 4,
    ["health"] = 212714,
    ["scale"] = 1,
    ["displayId"] = 91123,
    ["creatureType"] = "Mechanical",
    ["level"] = 120,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Silence"] = true,
      ["Stun"] = true,
    },
    ["spells"] = {
      [301689] = {
      },
      [301692] = {
      },
      [303941] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 568.97050422617,
        ["y"] = -308.36820839232,
        ["g"] = 44,
        ["sublevel"] = 1,
        ["inspiring"] = true,
      },
      [2] = {
        ["x"] = 564.42023070567,
        ["y"] = -307.28011058123,
        ["g"] = 44,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 519.63159935377,
        ["y"] = -315.91071720024,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 496.88041456899,
        ["y"] = -285.4701570718,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 497.68905738319,
        ["y"] = -292.68932141818,
        ["sublevel"] = 1,
        ["patrol"] = {
          [1] = {
            ["x"] = 497.68905738319,
            ["y"] = -292.68932141818,
          },
          [2] = {
            ["x"] = 502.54234299785,
            ["y"] = -292.59415510556,
          },
          [3] = {
            ["x"] = 504.92139679207,
            ["y"] = -294.97320685782,
          },
          [4] = {
            ["x"] = 508.7278942978,
            ["y"] = -297.54259063222,
          },
          [5] = {
            ["x"] = 510.63113896674,
            ["y"] = -299.54099263391,
          },
          [6] = {
            ["x"] = 508.7278942978,
            ["y"] = -297.54259063222,
          },
          [7] = {
            ["x"] = 504.92139679207,
            ["y"] = -294.97320685782,
          },
          [8] = {
            ["x"] = 502.54234299785,
            ["y"] = -292.59415510556,
          },
          [9] = {
            ["x"] = 497.68905738319,
            ["y"] = -292.68932141818,
          },
          [10] = {
            ["x"] = 492.35999177844,
            ["y"] = -291.73769725068,
          },
          [11] = {
            ["x"] = 492.35999177844,
            ["y"] = -291.73769725068,
          },
          [12] = {
            ["x"] = 488.7438293578,
            ["y"] = -285.64731349328,
          },
          [13] = {
            ["x"] = 492.35999177844,
            ["y"] = -291.73769725068,
          },
        },
      },
      [6] = {
        ["x"] = 496.90021374655,
        ["y"] = -317.37077976484,
        ["g"] = 54,
        ["sublevel"] = 1,
      },
    },
  },
  [27] = {
    ["name"] = "Mechagon Cavalry",
    ["id"] = 150292,
    ["count"] = 5,
    ["health"] = 340343,
    ["scale"] = 1.2,
    ["stealthDetect"] = true,
    ["displayId"] = 90851,
    ["creatureType"] = "Humanoid",
    ["level"] = 121,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [301622] = {
      },
      [301667] = {
      },
      [301680] = {
      },
      [301681] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 544.85803577134,
        ["y"] = -308.96108846004,
        ["g"] = 45,
        ["sublevel"] = 1,
        ["inspiring"] = true,
        ["patrol"] = {
          [1] = {
            ["x"] = 544.85803577134,
            ["y"] = -308.96108846004,
          },
          [2] = {
            ["x"] = 534.61639516613,
            ["y"] = -309.24221963565,
          },
          [3] = {
            ["x"] = 528.38210651116,
            ["y"] = -313.64289050872,
          },
          [4] = {
            ["x"] = 527.74034914013,
            ["y"] = -319.0520462437,
          },
          [5] = {
            ["x"] = 525.44832592911,
            ["y"] = -329.9620435209,
          },
          [6] = {
            ["x"] = 527.74034914013,
            ["y"] = -319.0520462437,
          },
          [7] = {
            ["x"] = 528.38210651116,
            ["y"] = -313.64289050872,
          },
          [8] = {
            ["x"] = 534.61639516613,
            ["y"] = -309.24221963565,
          },
          [9] = {
            ["x"] = 544.85803577134,
            ["y"] = -308.96108846004,
          },
          [10] = {
            ["x"] = 551.94402517122,
            ["y"] = -311.44255310493,
          },
          [11] = {
            ["x"] = 555.51957886232,
            ["y"] = -307.6836435374,
          },
          [12] = {
            ["x"] = 560.65370078266,
            ["y"] = -305.3916321299,
          },
          [13] = {
            ["x"] = 555.51957886232,
            ["y"] = -307.6836435374,
          },
          [14] = {
            ["x"] = 551.94402517122,
            ["y"] = -311.44255310493,
          },
        },
      },
      [2] = {
        ["x"] = 498.86511558368,
        ["y"] = -313.44101641927,
        ["g"] = 54,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 522.5145178619,
        ["y"] = -294.95171959607,
        ["g"] = 50,
        ["sublevel"] = 1,
        ["patrol"] = {
          [1] = {
            ["x"] = 522.5145178619,
            ["y"] = -294.95171959607,
          },
          [2] = {
            ["x"] = 526.91779381264,
            ["y"] = -290.01144517114,
          },
          [3] = {
            ["x"] = 528.63615574531,
            ["y"] = -283.35281342252,
          },
          [4] = {
            ["x"] = 535.50957582201,
            ["y"] = -276.69417245592,
          },
          [5] = {
            ["x"] = 542.16821678861,
            ["y"] = -272.72046855237,
          },
          [6] = {
            ["x"] = 535.50957582201,
            ["y"] = -276.69417245592,
          },
          [7] = {
            ["x"] = 528.63615574531,
            ["y"] = -283.35281342252,
          },
          [8] = {
            ["x"] = 526.91779381264,
            ["y"] = -290.01144517114,
          },
          [9] = {
            ["x"] = 522.5145178619,
            ["y"] = -294.95171959607,
          },
          [10] = {
            ["x"] = 515.21148425706,
            ["y"] = -298.28103547038,
          },
          [11] = {
            ["x"] = 509.62682180287,
            ["y"] = -302.57692647507,
          },
          [12] = {
            ["x"] = 505.22353663414,
            ["y"] = -308.16159353825,
          },
          [13] = {
            ["x"] = 509.62682180287,
            ["y"] = -302.57692647507,
          },
          [14] = {
            ["x"] = 515.21148425706,
            ["y"] = -298.28103547038,
          },
        },
      },
      [4] = {
        ["x"] = 537.42677013254,
        ["y"] = -328.18141080546,
        ["g"] = 47,
        ["sublevel"] = 1,
        ["teeming"] = true,
      },
    },
  },
  [28] = {
    ["name"] = "Mechagon Prowler",
    ["id"] = 150293,
    ["count"] = 3,
    ["health"] = 213311,
    ["scale"] = 1,
    ["stealth"] = true,
    ["displayId"] = 74812,
    ["creatureType"] = "Mechanical",
    ["level"] = 120,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Stun"] = true,
    },
    ["spells"] = {
      [301712] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 534.52574164739,
        ["y"] = -305.47932273064,
        ["g"] = 46,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 530.70298866605,
        ["y"] = -304.52019751927,
        ["g"] = 46,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 533.98681763346,
        ["y"] = -322.57468105635,
        ["g"] = 47,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 522.20631669991,
        ["y"] = -329.93748582462,
        ["g"] = 48,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 504.79108799869,
        ["y"] = -260.28897823736,
        ["g"] = 49,
        ["sublevel"] = 1,
        ["patrol"] = {
          [1] = {
            ["x"] = 504.79108799869,
            ["y"] = -260.28897823736,
          },
          [2] = {
            ["x"] = 499.63601637883,
            ["y"] = -262.54432005461,
          },
          [3] = {
            ["x"] = 497.70286164076,
            ["y"] = -264.79966187186,
          },
          [4] = {
            ["x"] = 499.958212676,
            ["y"] = -268.77336550473,
          },
          [5] = {
            ["x"] = 499.31382929965,
            ["y"] = -271.56569654161,
          },
          [6] = {
            ["x"] = 497.81026962448,
            ["y"] = -275.96899062838,
          },
          [7] = {
            ["x"] = 500.60259144337,
            ["y"] = -279.94268504326,
          },
          [8] = {
            ["x"] = 505.97246520367,
            ["y"] = -282.52022776668,
          },
          [9] = {
            ["x"] = 510.80534513535,
            ["y"] = -279.62050257307,
          },
          [10] = {
            ["x"] = 515.63823428501,
            ["y"] = -276.07638478511,
          },
          [11] = {
            ["x"] = 519.39712655945,
            ["y"] = -275.75419309693,
          },
          [12] = {
            ["x"] = 523.37083480131,
            ["y"] = -272.10267654325,
          },
          [13] = {
            ["x"] = 526.37795415165,
            ["y"] = -266.94760953239,
          },
          [14] = {
            ["x"] = 523.90781941194,
            ["y"] = -261.47034622435,
          },
          [15] = {
            ["x"] = 515.20863922212,
            ["y"] = -260.18158408063,
          },
          [16] = {
            ["x"] = 510.91274390107,
            ["y"] = -260.18158408063,
          },
        },
      },
      [6] = {
        ["x"] = 507.26124117437,
        ["y"] = -257.17446473028,
        ["g"] = 49,
        ["sublevel"] = 1,
      },
      [7] = {
        ["x"] = 508.01301409847,
        ["y"] = -260.93335239573,
        ["g"] = 49,
        ["sublevel"] = 1,
        ["inspiring"] = true,
      },
      [8] = {
        ["x"] = 513.26289661346,
        ["y"] = -268.38269440803,
        ["sublevel"] = 1,
        ["disguised"] = true,
      },
    },
  },
  [29] = {
    ["name"] = "Toxic Monstrosity",
    ["id"] = 150168,
    ["count"] = 5,
    ["health"] = 382886,
    ["scale"] = 1.4,
    ["displayId"] = 91906,
    ["creatureType"] = "Elemental",
    ["level"] = 121,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [300659] = {
      },
      [300687] = {
      },
      [300706] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 588.6031112309,
        ["y"] = -330.50253276388,
        ["sublevel"] = 1,
        ["patrol"] = {
        },
      },
      [2] = {
        ["x"] = 609.60301700195,
        ["y"] = -333.53482499954,
        ["sublevel"] = 1,
        ["patrol"] = {
          [1] = {
            ["x"] = 609.90142089509,
            ["y"] = -329.357107887,
          },
          [2] = {
            ["x"] = 609.0599456058,
            ["y"] = -336.76011374635,
          },
          [3] = {
            ["x"] = 613.43739962397,
            ["y"] = -341.23273122889,
          },
          [4] = {
            ["x"] = 619.24228110413,
            ["y"] = -343.70694863108,
          },
          [5] = {
            ["x"] = 623.81007021887,
            ["y"] = -342.6601627748,
          },
          [6] = {
            ["x"] = 629.90045842781,
            ["y"] = -340.37627230135,
          },
          [7] = {
            ["x"] = 633.13597537709,
            ["y"] = -336.09397766362,
          },
          [8] = {
            ["x"] = 635.22953075397,
            ["y"] = -328.48100261225,
          },
          [9] = {
            ["x"] = 629.56444579193,
            ["y"] = -321.87715500974,
          },
          [10] = {
            ["x"] = 624.0450383692,
            ["y"] = -318.92713253748,
          },
          [11] = {
            ["x"] = 616.71755779484,
            ["y"] = -319.11745538229,
          },
          [12] = {
            ["x"] = 612.05460521573,
            ["y"] = -323.68524041312,
          },
        },
      },
      [3] = {
        ["x"] = 654.48804774187,
        ["y"] = -336.24960174723,
        ["sublevel"] = 1,
      },
    },
  },
  [30] = {
    ["name"] = "Gunker",
    ["id"] = 150222,
    ["count"] = 0,
    ["health"] = 1491350,
    ["scale"] = 1.2,
    ["displayId"] = 91907,
    ["creatureType"] = "Elemental",
    ["level"] = 122,
    ["isBoss"] = true,
    ["encounterID"] = 2358,
    ["instanceID"] = 1178,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [297834] = {
      },
      [297835] = {
      },
      [297985] = {
      },
      [298124] = {
      },
      [298229] = {
      },
      [298259] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 589.22236941781,
        ["y"] = -341.6736523392,
        ["sublevel"] = 1,
      },
    },
  },
  [31] = {
    ["name"] = "Tank Buster MK1",
    ["id"] = 150295,
    ["count"] = 0,
    ["health"] = 681760,
    ["scale"] = 1.2,
    ["displayId"] = 90854,
    ["creatureType"] = "Mechanical",
    ["level"] = 122,
    ["isBoss"] = true,
    ["encounterID"] = 2355,
    ["instanceID"] = 1178,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [295445] = {
      },
      [302274] = {
      },
      [302279] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 472.17734170862,
        ["y"] = -329.607418624,
        ["g"] = 55,
        ["sublevel"] = 1,
      },
    },
  },
  [32] = {
    ["name"] = "HK-8 Aerial Oppression Unit",
    ["id"] = 150190,
    ["count"] = 0,
    ["health"] = 1661790,
    ["scale"] = 1.2,
    ["displayId"] = 92099,
    ["creatureType"] = "Mechanical",
    ["level"] = 122,
    ["isBoss"] = true,
    ["encounterID"] = 2355,
    ["instanceID"] = 1178,
    ["spells"] = {
      [294894] = {
      },
      [295536] = {
      },
      [295552] = {
      },
      [295939] = {
      },
      [296025] = {
      },
      [296080] = {
      },
      [301177] = {
      },
      [301351] = {
      },
      [302166] = {
      },
      [302272] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 460.60612432968,
        ["y"] = -335.86566559552,
        ["g"] = 55,
        ["sublevel"] = 1,
      },
    },
  },
  [33] = {
    ["name"] = "Nathrezim Infiltrator",
    ["id"] = 189878,
    ["count"] = 7,
    ["health"] = 261167,
    ["scale"] = 1.2,
    ["displayId"] = 101016,
    ["creatureType"] = "Demon",
    ["level"] = 61,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [373364] = {
      },
      [373370] = {
      },
      [373391] = {
      },
      [373429] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 564.4286325781,
        ["y"] = -201.65738508659,
        ["g"] = 35,
        ["sublevel"] = 1,
        ["shrouded"] = true,
      },
      [2] = {
        ["x"] = 510.86392455103,
        ["y"] = -241.32626446222,
        ["g"] = 32,
        ["sublevel"] = 1,
        ["shrouded"] = true,
      },
      [3] = {
        ["x"] = 516.13622264397,
        ["y"] = -212.45876407282,
        ["g"] = 28,
        ["sublevel"] = 1,
        ["shrouded"] = true,
      },
      [4] = {
        ["x"] = 509.27367775042,
        ["y"] = -184.42247310314,
        ["g"] = 19,
        ["sublevel"] = 1,
        ["shrouded"] = true,
      },
      [5] = {
        ["x"] = 551.86885889892,
        ["y"] = -159.58165079998,
        ["sublevel"] = 1,
        ["shrouded"] = true,
        ["patrol"] = {
          [1] = {
            ["x"] = 551.86885889892,
            ["y"] = -159.58165079998,
          },
          [2] = {
            ["x"] = 552.67421607235,
            ["y"] = -154.56733623081,
          },
          [3] = {
            ["x"] = 551.86885889892,
            ["y"] = -159.58165079998,
          },
          [4] = {
            ["x"] = 550.98006139361,
            ["y"] = -162.9851688528,
          },
          [5] = {
            ["x"] = 547.32704136161,
            ["y"] = -164.52049667241,
          },
          [6] = {
            ["x"] = 542.8269417182,
            ["y"] = -159.17332196167,
          },
          [7] = {
            ["x"] = 547.32704136161,
            ["y"] = -164.52049667241,
          },
          [8] = {
            ["x"] = 550.98006139361,
            ["y"] = -162.9851688528,
          },
        },
      },
      [6] = {
        ["x"] = 557.60039371291,
        ["y"] = -188.11587792557,
        ["g"] = 1,
        ["sublevel"] = 1,
        ["shrouded"] = true,
      },
      [7] = {
        ["x"] = 517.21382244627,
        ["y"] = -152.16648255968,
        ["sublevel"] = 1,
        ["shrouded"] = true,
        ["patrol"] = {
          [1] = {
            ["x"] = 517.21382244627,
            ["y"] = -152.16648255968,
          },
          [2] = {
            ["x"] = 521.59921449116,
            ["y"] = -151.66529889187,
          },
          [3] = {
            ["x"] = 525.67136539937,
            ["y"] = -149.53524679503,
          },
          [4] = {
            ["x"] = 528.30259847544,
            ["y"] = -143.89688751488,
          },
          [5] = {
            ["x"] = 525.67136539937,
            ["y"] = -149.53524679503,
          },
          [6] = {
            ["x"] = 521.59921449116,
            ["y"] = -151.66529889187,
          },
          [7] = {
            ["x"] = 517.21382244627,
            ["y"] = -152.16648255968,
          },
          [8] = {
            ["x"] = 511.38751256924,
            ["y"] = -152.16648255968,
          },
          [9] = {
            ["x"] = 510.13454264539,
            ["y"] = -155.86274302845,
          },
          [10] = {
            ["x"] = 512.64048249309,
            ["y"] = -159.99754323944,
          },
          [11] = {
            ["x"] = 515.77290999129,
            ["y"] = -163.19261466324,
          },
          [12] = {
            ["x"] = 512.64048249309,
            ["y"] = -159.99754323944,
          },
          [13] = {
            ["x"] = 510.13454264539,
            ["y"] = -155.86274302845,
          },
          [14] = {
            ["x"] = 511.38751256924,
            ["y"] = -152.16648255968,
          },
        },
      },
      [8] = {
        ["x"] = 492.76961137568,
        ["y"] = -121.03273025087,
        ["g"] = 12,
        ["sublevel"] = 1,
        ["shrouded"] = true,
      },
      [9] = {
        ["x"] = 589.04846079122,
        ["y"] = -304.52343020329,
        ["g"] = 42,
        ["sublevel"] = 1,
        ["shrouded"] = true,
      },
      [10] = {
        ["x"] = 628.17126746062,
        ["y"] = -330.45705276065,
        ["sublevel"] = 1,
        ["shrouded"] = true,
      },
      [11] = {
        ["x"] = 653.48523878837,
        ["y"] = -352.18047716393,
        ["sublevel"] = 1,
        ["shrouded"] = true,
      },
      [12] = {
        ["x"] = 623.18893277608,
        ["y"] = -259.28393407902,
        ["sublevel"] = 1,
        ["shrouded"] = true,
      },
      [13] = {
        ["x"] = 563.92990837141,
        ["y"] = -309.02801359821,
        ["sublevel"] = 2,
        ["shrouded"] = true,
        ["patrol"] = {
          [1] = {
            ["x"] = 563.92990837141,
            ["y"] = -309.02801359821,
          },
          [2] = {
            ["x"] = 562.08126213092,
            ["y"] = -313.83448007207,
          },
          [3] = {
            ["x"] = 560.72558328481,
            ["y"] = -322.09175532973,
          },
          [4] = {
            ["x"] = 559.49317008785,
            ["y"] = -327.02146629669,
          },
          [5] = {
            ["x"] = 560.72558328481,
            ["y"] = -322.09175532973,
          },
          [6] = {
            ["x"] = 562.08126213092,
            ["y"] = -313.83448007207,
          },
          [7] = {
            ["x"] = 563.92990837141,
            ["y"] = -309.02801359821,
          },
          [8] = {
            ["x"] = 569.10609245755,
            ["y"] = -302.98910748234,
          },
        },
      },
      [14] = {
        ["x"] = 537.29570750996,
        ["y"] = -324.13532099222,
        ["g"] = 47,
        ["sublevel"] = 1,
        ["shrouded"] = true,
      },
      [15] = {
        ["x"] = 513.26289661346,
        ["y"] = -268.38269440803,
        ["sublevel"] = 1,
        ["shrouded"] = true,
      },
      [16] = {
        ["x"] = 494.76447957245,
        ["y"] = -311.04898424542,
        ["g"] = 54,
        ["sublevel"] = 1,
        ["shrouded"] = true,
      },
      [17] = {
        ["x"] = 498.02167539878,
        ["y"] = -299.89184791031,
        ["g"] = 52,
        ["sublevel"] = 1,
        ["shrouded"] = true,
      },
    },
  },
  [34] = {
    ["name"] = "Zul'gamux",
    ["id"] = 190128,
    ["count"] = 21,
    ["health"] = 639150,
    ["scale"] = 1.8,
    ["displayId"] = 101106,
    ["creatureType"] = "Demon",
    ["level"] = 61,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [373509] = {
      },
      [373513] = {
      },
      [373552] = {
      },
      [373570] = {
      },
      [373607] = {
      },
      [373724] = {
      },
      [373729] = {
      },
      [373744] = {
      },
      [373747] = {
      },
      [374273] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 527.2152655307,
        ["y"] = -227.93941145717,
        ["g"] = 30,
        ["sublevel"] = 1,
        ["scale"] = 0.8,
        ["shrouded"] = true,
        ["patrol"] = {
          [1] = {
            ["x"] = 526.5263931021,
            ["y"] = -228.11162956432,
          },
          [2] = {
            ["x"] = 529.51292630428,
            ["y"] = -224.50719446499,
          },
          [3] = {
            ["x"] = 527.76220573556,
            ["y"] = -218.22518153164,
          },
          [4] = {
            ["x"] = 522.92196684194,
            ["y"] = -215.34164229134,
          },
          [5] = {
            ["x"] = 517.46382605117,
            ["y"] = -217.81324987993,
          },
          [6] = {
            ["x"] = 515.81609060517,
            ["y"] = -222.55050365083,
          },
          [7] = {
            ["x"] = 516.7429390313,
            ["y"] = -228.00863560244,
          },
          [8] = {
            ["x"] = 521.89212445392,
            ["y"] = -229.2444482359,
          },
          [9] = {
            ["x"] = 526.5263931021,
            ["y"] = -228.11162956432,
          },
        },
      },
    },
  },
};
