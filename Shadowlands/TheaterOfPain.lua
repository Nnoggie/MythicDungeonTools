local MDT = MDT
local L = MDT.L
local dungeonIndex = 36
MDT.dungeonList[dungeonIndex] = L["Theater of Pain"]
MDT.mapInfo[dungeonIndex] = {
  viewportPositionOverrides =
  {
    [1] = {
      zoomScale = 2.1999998092651,
      horizontalPan = 233.72766555588,
      verticalPan = 188.09071841916,
    },
    [2] = {
      zoomScale = 1.2999999523163,
      horizontalPan = 118.01058420157,
      verticalPan = 57.697244781145,
    },
    [3] = {
      zoomScale = 1.2999999523163,
      horizontalPan = 175.74260337036,
      verticalPan = 62.424803754491,
    },
    [4] = {
      zoomScale = 1.2999999523163,
      horizontalPan = 124.21960940533,
      verticalPan = 75.315651737871,
    },
    [5] = {
      zoomScale = 1.2999999523163,
      horizontalPan = 68.068100349919,
      verticalPan = 76.939706850476,
    },
  }
};

local zones = { 1683, 1684, 1685, 1686, 1687 }
for _, zone in ipairs(zones) do
  MDT.zoneIdToDungeonIdx[zone] = dungeonIndex
end

MDT.scaleMultiplier[dungeonIndex] = 1.3

MDT.dungeonMaps[dungeonIndex] = {
  [0] = "TheaterOfPain",
  [1] = "TheaterOfPain",
  [2] = "TheaterOfPain_Warlord",
  [3] = "TheaterOfPain_Lich",
  [4] = "TheaterOfPain_AbomTop",
  [5] = "TheaterOfPain_AbomBot",
}
MDT.dungeonSubLevels[dungeonIndex] = {
  [1] = L["TheaterOfPainFloor1"],
  [2] = L["TheaterOfPainFloor2"],
  [3] = L["TheaterOfPainFloor3"],
  [4] = L["TheaterOfPainFloor4"],
  [5] = L["TheaterOfPainFloor5"],
}

MDT.dungeonTotalCount[dungeonIndex] = { normal = 271, teeming = 1000, teemingEnabled = true }

MDT.mapPOIs[dungeonIndex] = {
  [1] = {
    [1] = {
      ["template"] = "MapLinkPinTemplate",
      ["type"] = "mapLink",
      ["x"] = 422.3263894392,
      ["y"] = -213.03570672361,
      ["target"] = 2,
      ["direction"] = -1,
      ["connectionIndex"] = 1,
    },
  },
  [2] = {
    [1] = {
      ["template"] = "MapLinkPinTemplate",
      ["type"] = "mapLink",
      ["x"] = 271.56378333015,
      ["y"] = -190.01484617386,
      ["target"] = 1,
      ["direction"] = 1,
      ["connectionIndex"] = 1,
    },
    [2] = {
      ["template"] = "MapLinkPinTemplate",
      ["type"] = "mapLink",
      ["x"] = 270.7719140048,
      ["y"] = -98.174992961846,
      ["target"] = 3,
      ["direction"] = 1,
      ["connectionIndex"] = 2,
    },
    [3] = {
      ["template"] = "MapLinkPinTemplate",
      ["type"] = "mapLink",
      ["x"] = 179.72326263409,
      ["y"] = -160.7212020877,
      ["target"] = 4,
      ["direction"] = -2,
      ["connectionIndex"] = 3,
    },
    [4] = {
      ["template"] = "MapLinkPinTemplate",
      ["type"] = "generalNote",
      ["x"] = 395.77796738459,
      ["y"] = -371.66498923535,
      ["scale"] = 2,
      ["text"] = "theaterOfPain_miniBossNote",
    },
    [5] = {
      ["template"] = "MapLinkPinTemplate",
      ["type"] = "generalNote",
      ["x"] = 479.7469803976,
      ["y"] = -286.77060932602,
      ["scale"] = 2,
      ["text"] = "theaterOfPain_miniBossNote",
    },
    [6] = {
      ["template"] = "MapLinkPinTemplate",
      ["type"] = "generalNote",
      ["x"] = 603.84404895006,
      ["y"] = -435.65690452825,
      ["scale"] = 2,
      ["text"] = "theaterOfPain_miniBossNote",
    },
  },
  [3] = {
    [1] = {
      ["template"] = "MapLinkPinTemplate",
      ["type"] = "mapLink",
      ["x"] = 600.91809113105,
      ["y"] = -465.53471872035,
      ["target"] = 2,
      ["direction"] = -1,
      ["connectionIndex"] = 2,
    },
  },
  [4] = {
    [1] = {
      ["template"] = "MapLinkPinTemplate",
      ["type"] = "mapLink",
      ["x"] = 689.5927878488,
      ["y"] = -388.73733430644,
      ["target"] = 2,
      ["direction"] = 2,
      ["connectionIndex"] = 3,
    },
    [2] = {
      ["template"] = "MapLinkPinTemplate",
      ["type"] = "mapLink",
      ["x"] = 155.17979851978,
      ["y"] = -365.77737100344,
      ["target"] = 5,
      ["direction"] = 1,
      ["connectionIndex"] = 4,
    },
    [3] = {
      ["template"] = "MapLinkPinTemplate",
      ["type"] = "mapLink",
      ["x"] = 213.76718798327,
      ["y"] = -140.92807052201,
      ["target"] = 5,
      ["direction"] = -1,
      ["connectionIndex"] = 5,
    },
  },
  [5] = {
    [1] = {
      ["template"] = "MapLinkPinTemplate",
      ["type"] = "mapLink",
      ["x"] = 212.18385705726,
      ["y"] = -123.51013920768,
      ["target"] = 4,
      ["direction"] = 1,
      ["connectionIndex"] = 5,
    },
    [2] = {
      ["template"] = "MapLinkPinTemplate",
      ["type"] = "mapLink",
      ["x"] = 144.09573454242,
      ["y"] = -330.14987688884,
      ["target"] = 4,
      ["direction"] = -1,
      ["connectionIndex"] = 4,
    },
    [3] = {
      ["template"] = "MapLinkPinTemplate",
      ["type"] = "mapLink",
      ["x"] = 543.91574181367,
      ["y"] = -472.65995527842,
      ["target"] = 4,
      ["direction"] = 1,
      ["connectionIndex"] = 6,
    },
  },
};

MDT.dungeonEnemies[dungeonIndex] = {
  [1] = {
    ["name"] = "Battlefield Ritualist",
    ["id"] = 174197,
    ["count"] = 4,
    ["health"] = 148676,
    ["scale"] = 1,
    ["displayId"] = 98696,
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
      [330784] = {
        ["interruptible"] = true,
      },
      [341902] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 425.58391854356,
        ["y"] = -374.42489015613,
        ["g"] = 1,
        ["sublevel"] = 1,
      },
    },
  },
  [2] = {
    ["name"] = "Unyielding Contender",
    ["id"] = 170838,
    ["count"] = 4,
    ["health"] = 189974,
    ["scale"] = 1,
    ["displayId"] = 95570,
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
      [320679] = {
      },
      [331510] = {
      },
      [337178] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 436.14551912457,
        ["y"] = -377.64987321577,
        ["g"] = 1,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 415.95011330293,
        ["y"] = -378.82713636876,
        ["g"] = 1,
        ["sublevel"] = 1,
        ["inspiring"] = true,
      },
    },
  },
  [3] = {
    ["name"] = "Raging Bloodhorn",
    ["id"] = 170850,
    ["count"] = 7,
    ["health"] = 297351,
    ["scale"] = 1.4,
    ["stealthDetect"] = true,
    ["displayId"] = 96471,
    ["creatureType"] = "Beast",
    ["level"] = 60,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [333241] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 426.28482697188,
        ["y"] = -360.09502773364,
        ["g"] = 1,
        ["sublevel"] = 1,
      },
    },
  },
  [4] = {
    ["name"] = "Dessia the Decapitator",
    ["id"] = 164451,
    ["count"] = 0,
    ["health"] = 595013,
    ["scale"] = 1,
    ["displayId"] = 96820,
    ["creatureType"] = "Humanoid",
    ["level"] = 60,
    ["isBoss"] = true,
    ["encounterID"] = 2397,
    ["instanceID"] = 1187,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [320063] = {
      },
      [320069] = {
      },
      [324085] = {
      },
      [326892] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 424.80025384949,
        ["y"] = -316.62293787175,
        ["g"] = 2,
        ["sublevel"] = 1,
      },
    },
  },
  [5] = {
    ["name"] = "Paceran the Virulent",
    ["id"] = 164463,
    ["count"] = 0,
    ["health"] = 528901,
    ["scale"] = 1,
    ["displayId"] = 98081,
    ["creatureType"] = "Humanoid",
    ["level"] = 60,
    ["isBoss"] = true,
    ["encounterID"] = 2397,
    ["instanceID"] = 1187,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [320120] = {
      },
      [320180] = {
      },
      [320248] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 407.16087432211,
        ["y"] = -312.17559207043,
        ["g"] = 2,
        ["sublevel"] = 1,
      },
    },
  },
  [6] = {
    ["name"] = "Sathel the Accursed",
    ["id"] = 164461,
    ["count"] = 0,
    ["health"] = 462788,
    ["scale"] = 1,
    ["displayId"] = 98082,
    ["creatureType"] = "Humanoid",
    ["level"] = 60,
    ["isBoss"] = true,
    ["encounterID"] = 2397,
    ["instanceID"] = 1187,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [320272] = {
      },
      [320293] = {
      },
      [320300] = {
        ["interruptible"] = true,
      },
      [333231] = {
        ["interruptible"] = true,
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 447.30744238781,
        ["y"] = -310.12570727863,
        ["g"] = 2,
        ["sublevel"] = 1,
      },
    },
  },
  [7] = {
    ["name"] = "Xira the Underhanded",
    ["id"] = 164464,
    ["count"] = 0,
    ["health"] = 67427,
    ["scale"] = 1.3,
    ["displayId"] = 96440,
    ["creatureType"] = "Humanoid",
    ["level"] = 60,
    ["characteristics"] = {
      ["Incapacitate"] = true,
      ["Silence"] = true,
      ["Polymorph"] = true,
      ["Root"] = true,
      ["Fear"] = true,
      ["Disorient"] = true,
      ["Repentance"] = true,
      ["Imprison"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
    },
    ["spells"] = {
      [333540] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 425.25134183422,
        ["y"] = -294.92170535281,
        ["g"] = 2,
        ["sublevel"] = 1,
      },
    },
  },
  [8] = {
    ["name"] = "Shambling Arbalest",
    ["id"] = 164510,
    ["count"] = 4,
    ["health"] = 140416,
    ["scale"] = 1.4,
    ["displayId"] = 96212,
    ["creatureType"] = "Undead",
    ["level"] = 60,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Incapacitate"] = true,
      ["Control Undead"] = true,
      ["Silence"] = true,
      ["Shackle Undead"] = true,
      ["Polymorph"] = true,
      ["Root"] = true,
      ["Disorient"] = true,
      ["Repentance"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
    },
    ["spells"] = {
      [319997] = {
      },
      [330532] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 354.98940856123,
        ["y"] = -307.15338954092,
        ["g"] = 3,
        ["sublevel"] = 2,
      },
      [2] = {
        ["x"] = 555.36255378945,
        ["y"] = -347.05532003364,
        ["g"] = 4,
        ["sublevel"] = 2,
      },
      [3] = {
        ["x"] = 543.70316598326,
        ["y"] = -357.30152934993,
        ["g"] = 4,
        ["sublevel"] = 2,
      },
    },
  },
  [9] = {
    ["name"] = "Ossified Conscript",
    ["id"] = 167994,
    ["count"] = 4,
    ["health"] = 165195,
    ["scale"] = 1.4,
    ["displayId"] = 96253,
    ["creatureType"] = "Undead",
    ["level"] = 60,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Incapacitate"] = true,
      ["Control Undead"] = true,
      ["Silence"] = true,
      ["Shackle Undead"] = true,
      ["Polymorph"] = true,
      ["Root"] = true,
      ["Disorient"] = true,
      ["Repentance"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
    },
    ["spells"] = {
      [326835] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 351.42831609161,
        ["y"] = -292.89961904445,
        ["g"] = 3,
        ["sublevel"] = 2,
      },
      [2] = {
        ["x"] = 342.01968864097,
        ["y"] = -300.98918764544,
        ["g"] = 3,
        ["sublevel"] = 2,
        ["inspiring"] = true,
      },
      [3] = {
        ["x"] = 550.63634296576,
        ["y"] = -331.15964712066,
        ["g"] = 4,
        ["sublevel"] = 2,
      },
      [4] = {
        ["x"] = 528.62528718793,
        ["y"] = -350.03300694518,
        ["g"] = 4,
        ["sublevel"] = 2,
      },
    },
  },
  [10] = {
    ["name"] = "Dokigg the Brutalizer",
    ["id"] = 167538,
    ["count"] = 20,
    ["health"] = 528624,
    ["scale"] = 2,
    ["displayId"] = 97488,
    ["creatureType"] = "Humanoid",
    ["level"] = 60,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [320661] = {
      },
      [331316] = {
      },
      [342125] = {
      },
      [342139] = {
        ["interruptible"] = true,
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 397.85742796173,
        ["y"] = -343.48473546349,
        ["sublevel"] = 2,
      },
    },
  },
  [11] = {
    ["name"] = "Harugia the Bloodthirsty",
    ["id"] = 167536,
    ["count"] = 20,
    ["health"] = 528624,
    ["scale"] = 2,
    ["displayId"] = 95969,
    ["creatureType"] = "Humanoid",
    ["level"] = 60,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [333861] = {
      },
      [334023] = {
      },
      [334025] = {
      },
      [342139] = {
        ["interruptible"] = true,
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 486.49272307954,
        ["y"] = -262.45855065989,
        ["sublevel"] = 2,
      },
    },
  },
  [12] = {
    ["name"] = "Ancient Captain",
    ["id"] = 164506,
    ["count"] = 5,
    ["health"] = 198234,
    ["scale"] = 1.4,
    ["displayId"] = 96489,
    ["creatureType"] = "Undead",
    ["level"] = 60,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Incapacitate"] = true,
      ["Control Undead"] = true,
      ["Silence"] = true,
      ["Shackle Undead"] = true,
      ["Polymorph"] = true,
      ["Root"] = true,
      ["Disorient"] = true,
      ["Repentance"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
    },
    ["spells"] = {
      [330545] = {
      },
      [330562] = {
      },
      [330565] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 540.18588235294,
        ["y"] = -341.25970588235,
        ["g"] = 4,
        ["sublevel"] = 2,
        ["inspiring"] = true,
      },
    },
  },
  [13] = {
    ["name"] = "Advent Nevermore",
    ["id"] = 167533,
    ["count"] = 20,
    ["health"] = 528624,
    ["scale"] = 2,
    ["displayId"] = 95966,
    ["creatureType"] = "Humanoid",
    ["level"] = 60,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [331275] = {
      },
      [333827] = {
      },
      [333861] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 581.61127034463,
        ["y"] = -424.69488113351,
        ["sublevel"] = 2,
      },
    },
  },
  [14] = {
    ["name"] = "Xav the Unfallen",
    ["id"] = 162329,
    ["count"] = 0,
    ["health"] = 1041274,
    ["scale"] = 1.6,
    ["displayId"] = 95439,
    ["creatureType"] = "Humanoid",
    ["level"] = 60,
    ["isBoss"] = true,
    ["encounterID"] = 2390,
    ["instanceID"] = 1187,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [316981] = {
      },
      [316995] = {
      },
      [317231] = {
      },
      [318102] = {
      },
      [320050] = {
      },
      [320114] = {
      },
      [320644] = {
      },
      [320661] = {
      },
      [320729] = {
      },
      [320789] = {
      },
      [331618] = {
      },
      [339415] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 444.67525268025,
        ["y"] = -428.74506576871,
        ["sublevel"] = 2,
      },
    },
  },
  [15] = {
    ["name"] = "Shackled Soul",
    ["id"] = 169875,
    ["count"] = 2,
    ["health"] = 99117,
    ["scale"] = 1,
    ["displayId"] = 90428,
    ["creatureType"] = "Undead",
    ["level"] = 60,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Incapacitate"] = true,
      ["Control Undead"] = true,
      ["Silence"] = true,
      ["Shackle Undead"] = true,
      ["Polymorph"] = true,
      ["Root"] = true,
      ["Disorient"] = true,
      ["Repentance"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
    },
    ["spells"] = {
      [330810] = {
        ["interruptible"] = true,
      },
      [332550] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 607.15292675452,
        ["y"] = -442.99206896552,
        ["g"] = 5,
        ["sublevel"] = 3,
      },
      [2] = {
        ["x"] = 592.19400492044,
        ["y"] = -447.21070094084,
        ["g"] = 5,
        ["sublevel"] = 3,
      },
      [3] = {
        ["x"] = 597.21077116794,
        ["y"] = -436.53318698247,
        ["g"] = 5,
        ["sublevel"] = 3,
      },
      [4] = {
        ["x"] = 568.77036871258,
        ["y"] = -446.99419148851,
        ["g"] = 6,
        ["sublevel"] = 3,
        ["inspiring"] = true,
      },
      [5] = {
        ["x"] = 557.01639299851,
        ["y"] = -444.17811518964,
        ["g"] = 6,
        ["sublevel"] = 3,
      },
      [6] = {
        ["x"] = 540.72369922713,
        ["y"] = -429.63703232507,
        ["g"] = 7,
        ["sublevel"] = 3,
      },
      [7] = {
        ["x"] = 558.08954594697,
        ["y"] = -435.86740602643,
        ["g"] = 6,
        ["sublevel"] = 3,
      },
      [8] = {
        ["x"] = 546.70176186807,
        ["y"] = -421.56842984826,
        ["g"] = 7,
        ["sublevel"] = 3,
      },
      [9] = {
        ["x"] = 535.99685365924,
        ["y"] = -421.03779212449,
        ["g"] = 7,
        ["sublevel"] = 3,
      },
      [10] = {
        ["x"] = 533.54837904435,
        ["y"] = -392.05458967775,
        ["g"] = 8,
        ["sublevel"] = 3,
      },
      [11] = {
        ["x"] = 539.45647000001,
        ["y"] = -380.64675527127,
        ["g"] = 8,
        ["sublevel"] = 3,
        ["inspiring"] = true,
      },
      [12] = {
        ["x"] = 547.30003064664,
        ["y"] = -392.57546897264,
        ["g"] = 8,
        ["sublevel"] = 3,
      },
      [13] = {
        ["x"] = 227.83736523639,
        ["y"] = -276.58177719069,
        ["g"] = 12,
        ["sublevel"] = 3,
      },
      [14] = {
        ["x"] = 215.62964707017,
        ["y"] = -282.76665742285,
        ["g"] = 12,
        ["sublevel"] = 3,
      },
      [15] = {
        ["x"] = 235.97010775668,
        ["y"] = -284.21632488259,
        ["g"] = 12,
        ["sublevel"] = 3,
      },
      [16] = {
        ["x"] = 354.23257304131,
        ["y"] = -165.8740163814,
        ["g"] = 14,
        ["sublevel"] = 3,
      },
      [17] = {
        ["x"] = 375.57534809124,
        ["y"] = -166.11423690935,
        ["g"] = 14,
        ["sublevel"] = 3,
      },
      [18] = {
        ["x"] = 364.70364695066,
        ["y"] = -160.36310344828,
        ["g"] = 14,
        ["sublevel"] = 3,
      },
      [19] = {
        ["x"] = 366.9363463343,
        ["y"] = -89.489776722053,
        ["g"] = 16,
        ["sublevel"] = 3,
      },
      [20] = {
        ["x"] = 345.41386380681,
        ["y"] = -88.417241379311,
        ["g"] = 16,
        ["sublevel"] = 3,
      },
      [21] = {
        ["x"] = 355.21991310002,
        ["y"] = -95.909189201993,
        ["g"] = 16,
        ["sublevel"] = 3,
      },
      [22] = {
        ["x"] = 359.7953037422,
        ["y"] = -312.48757116958,
        ["g"] = 10,
        ["sublevel"] = 3,
      },
      [23] = {
        ["x"] = 348.26114460169,
        ["y"] = -315.44838237439,
        ["g"] = 10,
        ["sublevel"] = 3,
      },
      [24] = {
        ["x"] = 357.65001532332,
        ["y"] = -298.69206896552,
        ["g"] = 10,
        ["sublevel"] = 3,
      },
    },
  },
  [16] = {
    ["name"] = "Portal Guardian",
    ["id"] = 167998,
    ["count"] = 8,
    ["health"] = 247793,
    ["scale"] = 1.6,
    ["displayId"] = 96442,
    ["creatureType"] = "Elemental",
    ["level"] = 60,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [326497] = {
      },
      [330716] = {
      },
      [330725] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 441.02902490517,
        ["y"] = -379.31540779101,
        ["sublevel"] = 3,
      },
      [2] = {
        ["x"] = 237.13183673108,
        ["y"] = -244.00904173618,
        ["g"] = 11,
        ["sublevel"] = 3,
      },
    },
  },
  [17] = {
    ["name"] = "Bone Magus",
    ["id"] = 170882,
    ["count"] = 4,
    ["health"] = 82598,
    ["scale"] = 1,
    ["displayId"] = 97410,
    ["creatureType"] = "Undead",
    ["level"] = 60,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Incapacitate"] = true,
      ["Control Undead"] = true,
      ["Silence"] = true,
      ["Shackle Undead"] = true,
      ["Polymorph"] = true,
      ["Root"] = true,
      ["Disorient"] = true,
      ["Repentance"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
    },
    ["spells"] = {
      [333293] = {
      },
      [341771] = {
        ["interruptible"] = true,
      },
      [342675] = {
        ["interruptible"] = true,
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 423.20502604965,
        ["y"] = -247.96379310345,
        ["g"] = 9,
        ["sublevel"] = 3,
      },
      [2] = {
        ["x"] = 422.31156773909,
        ["y"] = -261.29593453625,
        ["g"] = 9,
        ["sublevel"] = 3,
      },
      [3] = {
        ["x"] = 223.4363635099,
        ["y"] = -234.02753274733,
        ["g"] = 11,
        ["sublevel"] = 3,
        ["inspiring"] = true,
      },
      [4] = {
        ["x"] = 220.47747471652,
        ["y"] = -205.97517241379,
        ["g"] = 13,
        ["sublevel"] = 3,
      },
      [5] = {
        ["x"] = 230.32732814058,
        ["y"] = -208.33651035875,
        ["g"] = 13,
        ["sublevel"] = 3,
      },
      [6] = {
        ["x"] = 514.72439178858,
        ["y"] = -190.90730325918,
        ["g"] = 17,
        ["sublevel"] = 3,
      },
      [7] = {
        ["x"] = 517.60762807421,
        ["y"] = -173.83620689655,
        ["g"] = 17,
        ["sublevel"] = 3,
      },
      [8] = {
        ["x"] = 531.65243656623,
        ["y"] = -146.19714512207,
        ["g"] = 19,
        ["sublevel"] = 3,
      },
      [9] = {
        ["x"] = 521.32170687694,
        ["y"] = -146.56018208781,
        ["g"] = 19,
        ["sublevel"] = 3,
      },
      [10] = {
        ["x"] = 519.770071015,
        ["y"] = -221.45528452265,
        ["g"] = 18,
        ["sublevel"] = 3,
      },
      [11] = {
        ["x"] = 512.79242628588,
        ["y"] = -215.75213418438,
        ["g"] = 18,
        ["sublevel"] = 3,
      },
      [12] = {
        ["x"] = 673.39166607526,
        ["y"] = -182.91656629595,
        ["g"] = 20,
        ["sublevel"] = 3,
      },
    },
  },
  [18] = {
    ["name"] = "Maniacal Soulbinder",
    ["id"] = 160495,
    ["count"] = 4,
    ["health"] = 148676,
    ["scale"] = 1.3,
    ["displayId"] = 95233,
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
      [330784] = {
        ["interruptible"] = true,
      },
      [330868] = {
        ["interruptible"] = true,
      },
      [333708] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 221.87992152087,
        ["y"] = -247.61141335538,
        ["g"] = 11,
        ["sublevel"] = 3,
      },
      [2] = {
        ["x"] = 226.21764753987,
        ["y"] = -287.15159567984,
        ["g"] = 12,
        ["sublevel"] = 3,
      },
      [3] = {
        ["x"] = 680.95857564404,
        ["y"] = -197.00155699217,
        ["g"] = 20,
        ["sublevel"] = 3,
      },
      [4] = {
        ["x"] = 365.17989580141,
        ["y"] = -171.11943189447,
        ["g"] = 14,
        ["sublevel"] = 3,
      },
      [5] = {
        ["x"] = 356.15579768471,
        ["y"] = -82.062208302467,
        ["g"] = 16,
        ["sublevel"] = 3,
        ["inspiring"] = true,
      },
      [6] = {
        ["x"] = 349.11175182402,
        ["y"] = -302.58528999302,
        ["g"] = 10,
        ["sublevel"] = 3,
      },
    },
  },
  [19] = {
    ["name"] = "Soulforged Bonereaver",
    ["id"] = 162763,
    ["count"] = 8,
    ["health"] = 330390,
    ["scale"] = 1.6,
    ["displayId"] = 94812,
    ["creatureType"] = "Undead",
    ["level"] = 60,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [331223] = {
      },
      [331237] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 526.73244012243,
        ["y"] = -184.88861756349,
        ["g"] = 17,
        ["sublevel"] = 3,
      },
    },
  },
  [20] = {
    ["name"] = "Nefarious Darkspeaker",
    ["id"] = 169893,
    ["count"] = 6,
    ["health"] = 231273,
    ["scale"] = 1.6,
    ["displayId"] = 97011,
    ["creatureType"] = "Undead",
    ["level"] = 60,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [330875] = {
        ["interruptible"] = true,
      },
      [333294] = {
      },
      [333299] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 688.0705148888,
        ["y"] = -181.2467434963,
        ["g"] = 20,
        ["sublevel"] = 3,
      },
      [2] = {
        ["x"] = 361.92524661901,
        ["y"] = -139.82777941021,
        ["g"] = 15,
        ["sublevel"] = 3,
      },
      [3] = {
        ["x"] = 360.50205811328,
        ["y"] = -121.70713568059,
        ["g"] = 15,
        ["sublevel"] = 3,
      },
    },
  },
  [21] = {
    ["name"] = "Kul'tharok",
    ["id"] = 162309,
    ["count"] = 0,
    ["health"] = 1388364,
    ["scale"] = 1.3,
    ["displayId"] = 96088,
    ["creatureType"] = "Undead",
    ["level"] = 60,
    ["isBoss"] = true,
    ["encounterID"] = 2389,
    ["instanceID"] = 1187,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [319521] = {
      },
      [319539] = {
      },
      [319567] = {
      },
      [319626] = {
      },
      [319669] = {
        ["interruptible"] = true,
      },
      [322087] = {
      },
      [333567] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 601.60510814109,
        ["y"] = -387.79723803804,
        ["sublevel"] = 3,
      },
    },
  },
  [22] = {
    ["name"] = "Blighted Sludge-Spewer",
    ["id"] = 174210,
    ["count"] = 4,
    ["health"] = 132156,
    ["scale"] = 1.3,
    ["displayId"] = 95559,
    ["creatureType"] = "Undead",
    ["level"] = 60,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Incapacitate"] = true,
      ["Control Undead"] = true,
      ["Silence"] = true,
      ["Shackle Undead"] = true,
      ["Polymorph"] = true,
      ["Root"] = true,
      ["Disorient"] = true,
      ["Repentance"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
    },
    ["spells"] = {
      [321041] = {
      },
      [330693] = {
      },
      [330700] = {
      },
      [330703] = {
        ["interruptible"] = true,
      },
      [341969] = {
        ["interruptible"] = true,
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 592.24131147541,
        ["y"] = -334.71987211018,
        ["g"] = 21,
        ["sublevel"] = 4,
      },
      [2] = {
        ["x"] = 527.85049180328,
        ["y"] = -344.24741760944,
        ["g"] = 22,
        ["sublevel"] = 4,
      },
      [3] = {
        ["x"] = 387.1448303954,
        ["y"] = -302.72470508315,
        ["g"] = 23,
        ["sublevel"] = 4,
        ["inspiring"] = true,
      },
      [4] = {
        ["x"] = 395.58594646984,
        ["y"] = -280.10958070002,
        ["g"] = 23,
        ["sublevel"] = 4,
      },
      [5] = {
        ["x"] = 247.84417032655,
        ["y"] = -264.57436553433,
        ["g"] = 24,
        ["sublevel"] = 5,
      },
      [6] = {
        ["x"] = 377.2823203889,
        ["y"] = -294.45917066727,
        ["g"] = 25,
        ["sublevel"] = 5,
      },
    },
  },
  [23] = {
    ["name"] = "Disgusting Refuse",
    ["id"] = 163089,
    ["count"] = 1,
    ["health"] = 41299,
    ["scale"] = 1,
    ["displayId"] = 94761,
    ["creatureType"] = "Undead",
    ["level"] = 60,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Incapacitate"] = true,
      ["Control Undead"] = true,
      ["Silence"] = true,
      ["Shackle Undead"] = true,
      ["Polymorph"] = true,
      ["Root"] = true,
      ["Disorient"] = true,
      ["Repentance"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
    },
    ["spells"] = {
      [321041] = {
      },
      [330694] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 599.27764418327,
        ["y"] = -343.81046655103,
        ["g"] = 21,
        ["sublevel"] = 4,
        ["inspiring"] = true,
      },
      [2] = {
        ["x"] = 610.01857196098,
        ["y"] = -347.1248582832,
        ["g"] = 21,
        ["sublevel"] = 4,
      },
      [3] = {
        ["x"] = 612.40081048132,
        ["y"] = -335.98126609135,
        ["g"] = 21,
        ["sublevel"] = 4,
      },
      [4] = {
        ["x"] = 602.92679659671,
        ["y"] = -333.53516892626,
        ["g"] = 21,
        ["sublevel"] = 4,
      },
      [5] = {
        ["x"] = 515.78754098361,
        ["y"] = -336.95843580915,
        ["g"] = 22,
        ["sublevel"] = 4,
      },
      [6] = {
        ["x"] = 513.00590163934,
        ["y"] = -347.55066404329,
        ["g"] = 22,
        ["sublevel"] = 4,
      },
      [7] = {
        ["x"] = 525.48207740526,
        ["y"] = -357.35136325713,
        ["g"] = 22,
        ["sublevel"] = 4,
      },
      [8] = {
        ["x"] = 514.74098360656,
        ["y"] = -357.43310378751,
        ["g"] = 22,
        ["sublevel"] = 4,
      },
      [9] = {
        ["x"] = 254.53394518714,
        ["y"] = -217.90039615541,
        ["g"] = 24,
        ["sublevel"] = 5,
      },
      [10] = {
        ["x"] = 242.99409836066,
        ["y"] = -243.73044761436,
        ["g"] = 24,
        ["sublevel"] = 5,
      },
      [11] = {
        ["x"] = 382.98365119352,
        ["y"] = -282.35606667544,
        ["g"] = 25,
        ["sublevel"] = 5,
      },
      [12] = {
        ["x"] = 368.85473423501,
        ["y"] = -277.96226386751,
        ["g"] = 25,
        ["sublevel"] = 5,
      },
      [13] = {
        ["x"] = 364.23153550334,
        ["y"] = -289.7343476393,
        ["g"] = 25,
        ["sublevel"] = 5,
      },
      [14] = {
        ["x"] = 391.53172462651,
        ["y"] = -300.05955487395,
        ["g"] = 25,
        ["sublevel"] = 5,
      },
      [15] = {
        ["x"] = 394.15397413759,
        ["y"] = -289.73797451597,
        ["g"] = 25,
        ["sublevel"] = 5,
      },
    },
  },
  [24] = {
    ["name"] = "Diseased Horror",
    ["id"] = 170690,
    ["count"] = 4,
    ["health"] = 165195,
    ["scale"] = 1.7,
    ["displayId"] = 97117,
    ["creatureType"] = "Undead",
    ["level"] = 60,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Incapacitate"] = true,
      ["Control Undead"] = true,
      ["Silence"] = true,
      ["Shackle Undead"] = true,
      ["Polymorph"] = true,
      ["Root"] = true,
      ["Disorient"] = true,
      ["Repentance"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
    },
    ["spells"] = {
      [330697] = {
      },
      [330700] = {
      },
      [341977] = {
        ["interruptible"] = true,
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 618.37804306107,
        ["y"] = -376.69768033662,
        ["sublevel"] = 4,
      },
      [2] = {
        ["x"] = 256.26178173145,
        ["y"] = -233.66050126322,
        ["g"] = 24,
        ["sublevel"] = 5,
        ["inspiring"] = true,
      },
      [3] = {
        ["x"] = 468.63737704918,
        ["y"] = -306.46483030005,
        ["g"] = 26,
        ["sublevel"] = 5,
      },
    },
  },
  [25] = {
    ["name"] = "Putrid Butcher",
    ["id"] = 169927,
    ["count"] = 5,
    ["health"] = 198234,
    ["scale"] = 1.7,
    ["displayId"] = 97116,
    ["creatureType"] = "Undead",
    ["level"] = 60,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Incapacitate"] = true,
      ["Control Undead"] = true,
      ["Silence"] = true,
      ["Shackle Undead"] = true,
      ["Polymorph"] = true,
      ["Root"] = true,
      ["Disorient"] = true,
      ["Repentance"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
    },
    ["spells"] = {
      [330586] = {
      },
      [332836] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 561.86360655738,
        ["y"] = -333.6005902607,
        ["sublevel"] = 4,
      },
      [2] = {
        ["x"] = 402.42885245902,
        ["y"] = -295.43580914904,
        ["g"] = 23,
        ["sublevel"] = 4,
        ["patrol"] = {
          [1] = {
            ["x"] = 402.42885245902,
            ["y"] = -295.43580914904,
          },
          [2] = {
            ["x"] = 430.39730118435,
            ["y"] = -307.12220993859,
          },
          [3] = {
            ["x"] = 476.31724576045,
            ["y"] = -320.73984253565,
          },
          [4] = {
            ["x"] = 430.39730118435,
            ["y"] = -307.12220993859,
          },
          [5] = {
            ["x"] = 402.42885245902,
            ["y"] = -295.43580914904,
          },
          [6] = {
            ["x"] = 366.42607761119,
            ["y"] = -286.22073114055,
          },
          [7] = {
            ["x"] = 334.12381320004,
            ["y"] = -275.13661174284,
          },
          [8] = {
            ["x"] = 366.42607761119,
            ["y"] = -286.22073114055,
          },
        },
      },
      [3] = {
        ["x"] = 233.817844216,
        ["y"] = -255.18654883365,
        ["g"] = 24,
        ["sublevel"] = 5,
      },
      [4] = {
        ["x"] = 465.19475409836,
        ["y"] = -327.5400885391,
        ["g"] = 26,
        ["sublevel"] = 5,
      },
    },
  },
  [26] = {
    ["name"] = "Rancid Gasbag",
    ["id"] = 163086,
    ["count"] = 8,
    ["health"] = 313871,
    ["scale"] = 2,
    ["displayId"] = 97161,
    ["creatureType"] = "Undead",
    ["level"] = 60,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [330614] = {
      },
      [330973] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 273.84279248479,
        ["y"] = -363.58427181046,
        ["sublevel"] = 4,
        ["patrol"] = {
          [1] = {
            ["x"] = 273.84279248479,
            ["y"] = -363.58427181046,
          },
          [2] = {
            ["x"] = 295.13065259122,
            ["y"] = -355.24189473148,
          },
          [3] = {
            ["x"] = 309.13808751382,
            ["y"] = -349.15171586191,
          },
          [4] = {
            ["x"] = 295.13065259122,
            ["y"] = -355.24189473148,
          },
          [5] = {
            ["x"] = 273.84279248479,
            ["y"] = -363.58427181046,
          },
          [6] = {
            ["x"] = 255.90433848666,
            ["y"] = -381.1896189781,
          },
          [7] = {
            ["x"] = 254.18318623485,
            ["y"] = -407.69512655511,
          },
          [8] = {
            ["x"] = 256.61584531105,
            ["y"] = -426.26081255918,
          },
          [9] = {
            ["x"] = 254.18318623485,
            ["y"] = -407.69512655511,
          },
          [10] = {
            ["x"] = 255.90433848666,
            ["y"] = -381.1896189781,
          },
        },
      },
      [2] = {
        ["x"] = 337.24513439812,
        ["y"] = -161.52078803511,
        ["sublevel"] = 4,
        ["patrol"] = {
          [1] = {
            ["x"] = 337.24513439812,
            ["y"] = -161.52078803511,
          },
          [2] = {
            ["x"] = 349.41288765113,
            ["y"] = -181.13099569599,
          },
          [3] = {
            ["x"] = 358.76961337046,
            ["y"] = -196.96545519964,
          },
          [4] = {
            ["x"] = 349.41288765113,
            ["y"] = -181.13099569599,
          },
          [5] = {
            ["x"] = 337.24513439812,
            ["y"] = -161.52078803511,
          },
          [6] = {
            ["x"] = 334.29819350587,
            ["y"] = -136.14674574603,
          },
          [7] = {
            ["x"] = 346.17400917588,
            ["y"] = -118.51291531774,
          },
          [8] = {
            ["x"] = 353.0116140563,
            ["y"] = -106.99694757765,
          },
          [9] = {
            ["x"] = 346.17400917588,
            ["y"] = -118.51291531774,
          },
          [10] = {
            ["x"] = 334.29819350587,
            ["y"] = -136.14674574603,
          },
        },
      },
      [3] = {
        ["x"] = 325.36043071135,
        ["y"] = -272.7934040428,
        ["sublevel"] = 5,
      },
    },
  },
  [27] = {
    ["name"] = "Gorechop",
    ["id"] = 162317,
    ["count"] = 0,
    ["health"] = 1156970,
    ["scale"] = 1.7,
    ["displayId"] = 95106,
    ["creatureType"] = "Undead",
    ["level"] = 60,
    ["isBoss"] = true,
    ["encounterID"] = 2401,
    ["instanceID"] = 1187,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [318406] = {
      },
      [323515] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 592.37901639344,
        ["y"] = -358.71618298082,
        ["sublevel"] = 5,
      },
    },
  },
  [28] = {
    ["name"] = "Mordretha, the Endless Empress",
    ["id"] = 165946,
    ["count"] = 0,
    ["health"] = 1322252,
    ["scale"] = 1,
    ["displayId"] = 96078,
    ["creatureType"] = "Humanoid",
    ["level"] = 60,
    ["isBoss"] = true,
    ["encounterID"] = 2417,
    ["instanceID"] = 1187,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [323608] = {
      },
      [323683] = {
      },
      [324079] = {
      },
      [324449] = {
      },
      [339573] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 425.28479370126,
        ["y"] = -260.65634874517,
        ["sublevel"] = 1,
      },
    },
  },
  [29] = {
    ["name"] = "Nekthara the Mangler",
    ["id"] = 162744,
    ["count"] = 20,
    ["health"] = 528624,
    ["scale"] = 2,
    ["displayId"] = 97489,
    ["creatureType"] = "Humanoid",
    ["level"] = 61,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [317605] = {
      },
      [336996] = {
      },
      [342135] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 372.65828278898,
        ["y"] = -359.25817412643,
        ["sublevel"] = 2,
      },
    },
  },
  [30] = {
    ["name"] = "Heavin the Breaker",
    ["id"] = 167532,
    ["count"] = 20,
    ["health"] = 528624,
    ["scale"] = 2,
    ["displayId"] = 97490,
    ["creatureType"] = "Humanoid",
    ["level"] = 61,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [331288] = {
      },
      [332708] = {
      },
      [342135] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 502.13196302438,
        ["y"] = -284.32867018819,
        ["sublevel"] = 2,
      },
    },
  },
  [31] = {
    ["name"] = "Rek the Hardened",
    ["id"] = 167534,
    ["count"] = 20,
    ["health"] = 528624,
    ["scale"] = 2,
    ["displayId"] = 96829,
    ["creatureType"] = "Humanoid",
    ["level"] = 61,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [317605] = {
      },
      [333839] = {
      },
      [333845] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 601.68461487772,
        ["y"] = -408.47326368702,
        ["sublevel"] = 2,
      },
    },
  },
  [32] = {
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
        ["x"] = 430.59506927145,
        ["y"] = -398.57442329702,
        ["sublevel"] = 3,
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
        ["x"] = 279.33024418979,
        ["y"] = -442.63947583949,
        ["sublevel"] = 4,
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
  [33] = {
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
        ["x"] = 279.33024418979,
        ["y"] = -442.63947583949,
        ["sublevel"] = 4,
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
        ["x"] = 430.59506927145,
        ["y"] = -398.57442329702,
        ["sublevel"] = 3,
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
  [34] = {
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
        ["x"] = 362.21784027017,
        ["y"] = -381.60862941344,
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
        ["x"] = 295.01191596194,
        ["y"] = -157.88409820652,
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
  [35] = {
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
        ["x"] = 295.01191596194,
        ["y"] = -157.88409820652,
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
        ["x"] = 362.21784027017,
        ["y"] = -381.60862941344,
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
  [36] = {
    ["name"] = "Wo Relic",
    ["id"] = 185683,
    ["count"] = 0,
    ["health"] = 33039,
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
        ["x"] = 425.01640830966,
        ["y"] = -335.71604528471,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 423.59218273415,
        ["y"] = -238.03422029031,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 389.73544572091,
        ["y"] = -322.28839493217,
        ["sublevel"] = 2,
      },
      [4] = {
        ["x"] = 563.18803516631,
        ["y"] = -410.04288764377,
        ["sublevel"] = 2,
      },
      [5] = {
        ["x"] = 458.92319559854,
        ["y"] = -454.6410281581,
        ["sublevel"] = 2,
      },
      [6] = {
        ["x"] = 562.06573056882,
        ["y"] = -357.23869147944,
        ["sublevel"] = 4,
      },
      [7] = {
        ["x"] = 341.78385926144,
        ["y"] = -186.94868709071,
        ["sublevel"] = 4,
      },
      [8] = {
        ["x"] = 292.16843881499,
        ["y"] = -354.25640349183,
        ["sublevel"] = 4,
      },
      [9] = {
        ["x"] = 552.33341426349,
        ["y"] = -343.89768181106,
        ["sublevel"] = 5,
      },
      [10] = {
        ["x"] = 542.69361707296,
        ["y"] = -442.73081215986,
        ["sublevel"] = 3,
      },
      [11] = {
        ["x"] = 532.16486790666,
        ["y"] = -202.67730283952,
        ["sublevel"] = 3,
      },
      [12] = {
        ["x"] = 341.07242859912,
        ["y"] = -113.63486013351,
        ["sublevel"] = 3,
      },
      [13] = {
        ["x"] = 622.04107921204,
        ["y"] = -364.32447724135,
        ["sublevel"] = 3,
      },
    },
  },
  [37] = {
    ["name"] = "Urh Relic",
    ["id"] = 185685,
    ["count"] = 0,
    ["health"] = 33039,
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
        ["x"] = 407.28905384589,
        ["y"] = -333.67060231564,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 401.09221253944,
        ["y"] = -260.07967794719,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 373.15643426204,
        ["y"] = -333.60411019567,
        ["sublevel"] = 2,
      },
      [4] = {
        ["x"] = 578.71431059023,
        ["y"] = -399.25345004966,
        ["sublevel"] = 2,
      },
      [5] = {
        ["x"] = 471.61550785063,
        ["y"] = -432.33333483874,
        ["sublevel"] = 2,
      },
      [6] = {
        ["x"] = 595.14263351739,
        ["y"] = -361.85413777439,
        ["sublevel"] = 4,
      },
      [7] = {
        ["x"] = 354.86075902631,
        ["y"] = -176.94868549886,
        ["sublevel"] = 4,
      },
      [8] = {
        ["x"] = 295.52723929841,
        ["y"] = -371.08479928167,
        ["sublevel"] = 4,
      },
      [9] = {
        ["x"] = 563.1026569045,
        ["y"] = -321.20533495532,
        ["sublevel"] = 5,
      },
      [10] = {
        ["x"] = 544.12226899404,
        ["y"] = -456.65937139105,
        ["sublevel"] = 3,
      },
      [11] = {
        ["x"] = 543.75696198338,
        ["y"] = -189.03747181831,
        ["sublevel"] = 3,
      },
      [12] = {
        ["x"] = 340.79040149609,
        ["y"] = -131.26644217122,
        ["sublevel"] = 3,
      },
      [13] = {
        ["x"] = 601.87975336677,
        ["y"] = -359.80831522268,
        ["sublevel"] = 3,
      },
    },
  },
  [38] = {
    ["name"] = "Vy Relic",
    ["id"] = 185680,
    ["count"] = 0,
    ["health"] = 33039,
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
        ["x"] = 442.74368474552,
        ["y"] = -333.89785858455,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 443.81947319785,
        ["y"] = -259.62514590239,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 355.78818699529,
        ["y"] = -344.65677697257,
        ["sublevel"] = 2,
      },
      [4] = {
        ["x"] = 595.03013804036,
        ["y"] = -388.99026753789,
        ["sublevel"] = 2,
      },
      [5] = {
        ["x"] = 437.76942987652,
        ["y"] = -460.79489052776,
        ["sublevel"] = 2,
      },
      [6] = {
        ["x"] = 579.37355513948,
        ["y"] = -350.31562107243,
        ["sublevel"] = 4,
      },
      [7] = {
        ["x"] = 322.55309712691,
        ["y"] = -181.17947825743,
        ["sublevel"] = 4,
      },
      [8] = {
        ["x"] = 278.32229800096,
        ["y"] = -343.48719386263,
        ["sublevel"] = 4,
      },
      [9] = {
        ["x"] = 548.48734106492,
        ["y"] = -366.97458316778,
        ["sublevel"] = 5,
      },
      [10] = {
        ["x"] = 558.0507822445,
        ["y"] = -460.23078661701,
        ["sublevel"] = 3,
      },
      [11] = {
        ["x"] = 539.90923570527,
        ["y"] = -170.97620989954,
        ["sublevel"] = 3,
      },
      [12] = {
        ["x"] = 343.81917163948,
        ["y"] = -146.90788866538,
        ["sublevel"] = 3,
      },
      [13] = {
        ["x"] = 625.10556729424,
        ["y"] = -383.84057775398,
        ["sublevel"] = 3,
      },
    },
  },
};
