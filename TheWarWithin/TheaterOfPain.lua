local addonName = ...
local MDT = MDT
local L = MDT.L
local dungeonIndex = 121
MDT.dungeonList[dungeonIndex] = L["Theater of Pain"]
MDT.mapInfo[dungeonIndex] = {
  teleportId = 354467,
  shortName = L["theaterOfPainShortName"],
  englishName = "Theater of Pain",
  mapID = 382
};

local zones = { 1683, 1684, 1685, 1686, 1687 }
for _, zone in ipairs(zones) do
  MDT.zoneIdToDungeonIdx[zone] = dungeonIndex
end

MDT.dungeonMaps[dungeonIndex] = {
  [0] = "",
  [1] = { customTextures = 'Interface\\AddOns\\'..addonName..'\\TheWarWithin\\Textures\\TheaterOfPain' }
}

MDT.dungeonSubLevels[dungeonIndex] = {
  [1] = L["Theater of Pain"],
}

MDT.dungeonTotalCount[dungeonIndex] = { normal = 271, teeming = 1000, teemingEnabled = true }

MDT.mapPOIs[dungeonIndex] = {
  [1] = {
    [1] = {
      ["template"] = "MapLinkPinTemplate",
      ["type"] = "dungeonEntrance",
      ["x"] = 146.02236444473,
      ["y"] = -282.51404907435,
    },
  },
};


MDT.dungeonEnemies[dungeonIndex] = {
  [1] = {
    ["name"] = "Battlefield Ritualist",
    ["id"] = 174197,
    ["count"] = 4,
    ["health"] = 43848222,
    ["scale"] = 1.5,
    ["displayId"] = 98696,
    ["creatureType"] = "Humanoid",
    ["level"] = 80,
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
      ["Mind Soothe"] = true,
    },
    ["spells"] = {
      [330784] = {
        ["interruptible"] = true,
      },
      [341902] = {
        ["interruptible"] = true,
        ["magic"] = true,
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 146.06164353725,
        ["y"] = -230.67367584825,
        ["g"] = 1,
        ["sublevel"] = 1,
      },
    },
  },
  [2] = {
    ["name"] = "Unyielding Contender",
    ["id"] = 170838,
    ["count"] = 4,
    ["health"] = 56028285,
    ["scale"] = 1.5,
    ["displayId"] = 95570,
    ["creatureType"] = "Humanoid",
    ["level"] = 80,
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
      ["Mind Soothe"] = true,
    },
    ["spells"] = {
      [320679] = {
      },
      [331510] = {
        ["enrage"] = true,
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 158.35749243382,
        ["y"] = -238.51585060671,
        ["g"] = 1,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 133.72503862872,
        ["y"] = -239.3665622171,
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
    ["health"] = 87696445,
    ["scale"] = 1.8,
    ["stealthDetect"] = true,
    ["displayId"] = 96471,
    ["creatureType"] = "Beast",
    ["level"] = 80,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [333241] = {
        ["enrage"] = true,
      },
      [333242] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 145.70393784776,
        ["y"] = -211.07937128952,
        ["sublevel"] = 1,
      },
    },
  },
  [4] = {
    ["name"] = "Dessia the Decapitator",
    ["id"] = 164451,
    ["count"] = 0,
    ["health"] = 214544238,
    ["scale"] = 2,
    ["displayId"] = 96820,
    ["creatureType"] = "Humanoid",
    ["level"] = 80,
    ["isBoss"] = true,
    ["encounterID"] = 2397,
    ["instanceID"] = 1187,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [320069] = {
      },
      [1215741] = {
      },
      [1215747] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 146.46102088148,
        ["y"] = -176.63136924268,
        ["g"] = 2,
        ["sublevel"] = 1,
      },
    },
  },
  [5] = {
    ["name"] = "Paceran the Virulent",
    ["id"] = 164463,
    ["count"] = 0,
    ["health"] = 195040217,
    ["scale"] = 2,
    ["displayId"] = 98081,
    ["creatureType"] = "Humanoid",
    ["level"] = 80,
    ["isBoss"] = true,
    ["encounterID"] = 2397,
    ["instanceID"] = 1187,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [320180] = {
      },
      [320182] = {
      },
      [1215636] = {
      },
      [1215738] = {
      },
      [1215747] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 113.70889538908,
        ["y"] = -149.7283482467,
        ["g"] = 2,
        ["sublevel"] = 1,
      },
    },
  },
  [6] = {
    ["name"] = "Sathel the Accursed",
    ["id"] = 164461,
    ["count"] = 0,
    ["health"] = 195040217,
    ["scale"] = 2,
    ["displayId"] = 98082,
    ["creatureType"] = "Humanoid",
    ["level"] = 80,
    ["isBoss"] = true,
    ["encounterID"] = 2397,
    ["instanceID"] = 1187,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [333231] = {
      },
      [333292] = {
      },
      [1215600] = {
        ["magic"] = true,
      },
      [1215747] = {
      },
      [1217138] = {
        ["interruptible"] = true,
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 182.48217646341,
        ["y"] = -148.25264487427,
        ["g"] = 2,
        ["sublevel"] = 1,
      },
    },
  },
  [7] = {
    ["name"] = "Shambling Arbalest",
    ["id"] = 164510,
    ["count"] = 4,
    ["health"] = 41412211,
    ["scale"] = 1.5,
    ["displayId"] = 96212,
    ["creatureType"] = "Undead",
    ["level"] = 80,
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
      [327029] = {
      },
      [330532] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 667.40282817769,
        ["y"] = -463.49251007415,
        ["g"] = 3,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 774.35638821889,
        ["y"] = -481.5612151768,
        ["g"] = 4,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 763.68934710575,
        ["y"] = -490.48421208033,
        ["g"] = 4,
        ["sublevel"] = 1,
      },
    },
  },
  [8] = {
    ["name"] = "Ossified Conscript",
    ["id"] = 167994,
    ["count"] = 4,
    ["health"] = 48720247,
    ["scale"] = 1.5,
    ["displayId"] = 96253,
    ["creatureType"] = "Undead",
    ["level"] = 80,
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
    },
    ["clones"] = {
      [1] = {
        ["x"] = 668.47303282405,
        ["y"] = -449.90036367449,
        ["g"] = 3,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 656.41794476701,
        ["y"] = -457.65910233664,
        ["g"] = 3,
        ["sublevel"] = 1,
        ["inspiring"] = true,
      },
      [3] = {
        ["x"] = 773.59977885262,
        ["y"] = -468.311993925,
        ["g"] = 4,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 751.91955301363,
        ["y"] = -484.86974097241,
        ["g"] = 4,
        ["sublevel"] = 1,
      },
    },
  },
  [9] = {
    ["name"] = "Dokigg the Brutalizer",
    ["id"] = 167538,
    ["count"] = 20,
    ["health"] = 155904790,
    ["scale"] = 2,
    ["displayId"] = 97488,
    ["creatureType"] = "Humanoid",
    ["level"] = 80,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [317605] = {
      },
      [331316] = {
      },
      [331319] = {
      },
      [331320] = {
      },
      [1213695] = {
      },
      [1215850] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 691.6135001173,
        ["y"] = -477.92448257242,
        ["sublevel"] = 1,
      },
    },
  },
  [10] = {
    ["name"] = "Harugia the Bloodthirsty",
    ["id"] = 167536,
    ["count"] = 20,
    ["health"] = 155904790,
    ["scale"] = 2,
    ["displayId"] = 126297,
    ["creatureType"] = "Humanoid",
    ["level"] = 80,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [333845] = {
      },
      [333861] = {
      },
      [334023] = {
      },
      [334025] = {
      },
      [337037] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 730.89254950685,
        ["y"] = -431.69914723339,
        ["sublevel"] = 1,
      },
    },
  },
  [11] = {
    ["name"] = "Ancient Captain",
    ["id"] = 164506,
    ["count"] = 5,
    ["health"] = 58464296,
    ["scale"] = 1.5,
    ["displayId"] = 96489,
    ["creatureType"] = "Undead",
    ["level"] = 81,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [330545] = {
      },
      [330546] = {
      },
      [330562] = {
        ["interruptible"] = true,
      },
      [330565] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 762.48772992385,
        ["y"] = -476.75803717074,
        ["g"] = 4,
        ["sublevel"] = 1,
        ["inspiring"] = true,
        ["patrol"] = {
          [1] = {
            ["x"] = 762.48772992385,
            ["y"] = -476.75803717074,
          },
          [2] = {
            ["x"] = 750.29404263113,
            ["y"] = -459.26942405212,
          },
          [3] = {
            ["x"] = 762.48772992385,
            ["y"] = -476.75803717074,
          },
          [4] = {
            ["x"] = 775.40565300511,
            ["y"] = -492.69822599959,
          },
        },
      },
    },
  },
  [12] = {
    ["name"] = "Advent Nevermore",
    ["id"] = 167533,
    ["count"] = 20,
    ["health"] = 155554440,
    ["scale"] = 2,
    ["displayId"] = 126299,
    ["creatureType"] = "Humanoid",
    ["level"] = 80,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [331288] = {
      },
      [333827] = {
      },
      [333861] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 782.1461692131,
        ["y"] = -516.26210820412,
        ["sublevel"] = 1,
      },
    },
  },
  [13] = {
    ["name"] = "Xav the Unfallen",
    ["id"] = 162329,
    ["count"] = 0,
    ["health"] = 307188341,
    ["scale"] = 2,
    ["displayId"] = 95439,
    ["creatureType"] = "Humanoid",
    ["level"] = 80,
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
      [320729] = {
      },
      [320789] = {
      },
      [331618] = {
      },
      [339415] = {
      },
      [391891] = {
        ["magic"] = true,
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 716.14955488287,
        ["y"] = -523.56946864618,
        ["g"] = 31,
        ["sublevel"] = 1,
      },
    },
  },
  [14] = {
    ["name"] = "Shackled Soul",
    ["id"] = 169875,
    ["count"] = 2,
    ["health"] = 29232148,
    ["scale"] = 1,
    ["displayId"] = 90428,
    ["creatureType"] = "Undead",
    ["level"] = 80,
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
    },
    ["clones"] = {
      [1] = {
        ["x"] = 622.25614655399,
        ["y"] = -252.45989973245,
        ["g"] = 5,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 612.95940290267,
        ["y"] = -252.37034165731,
        ["g"] = 5,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 617.4838243535,
        ["y"] = -244.64699633258,
        ["g"] = 5,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 599.51832809832,
        ["y"] = -248.81809458404,
        ["g"] = 6,
        ["sublevel"] = 1,
        ["inspiring"] = true,
      },
      [5] = {
        ["x"] = 591.94945623555,
        ["y"] = -253.63363556678,
        ["g"] = 6,
        ["sublevel"] = 1,
      },
      [6] = {
        ["x"] = 579.91579483248,
        ["y"] = -238.76022989527,
        ["g"] = 7,
        ["sublevel"] = 1,
      },
      [7] = {
        ["x"] = 591.79170725089,
        ["y"] = -243.96892495746,
        ["g"] = 6,
        ["sublevel"] = 1,
      },
      [8] = {
        ["x"] = 584.41680976958,
        ["y"] = -230.69162076155,
        ["g"] = 7,
        ["sublevel"] = 1,
      },
      [9] = {
        ["x"] = 574.81970398089,
        ["y"] = -230.77644066125,
        ["g"] = 7,
        ["sublevel"] = 1,
      },
      [10] = {
        ["x"] = 575.90394976929,
        ["y"] = -215.29626823161,
        ["g"] = 8,
        ["sublevel"] = 1,
      },
      [11] = {
        ["x"] = 579.84259496919,
        ["y"] = -206.35022437757,
        ["g"] = 8,
        ["sublevel"] = 1,
        ["inspiring"] = true,
      },
      [12] = {
        ["x"] = 584.97815272361,
        ["y"] = -214.95550419089,
        ["g"] = 8,
        ["sublevel"] = 1,
      },
      [13] = {
        ["x"] = 396.50957449188,
        ["y"] = -148.5863453919,
        ["g"] = 12,
        ["sublevel"] = 1,
      },
      [14] = {
        ["x"] = 388.97929165982,
        ["y"] = -153.66340989011,
        ["g"] = 12,
        ["sublevel"] = 1,
      },
      [15] = {
        ["x"] = 404.3961179862,
        ["y"] = -152.89743922503,
        ["g"] = 12,
        ["sublevel"] = 1,
      },
      [16] = {
        ["x"] = 471.71801747112,
        ["y"] = -89.226330290977,
        ["g"] = 14,
        ["sublevel"] = 1,
      },
      [17] = {
        ["x"] = 487.89094582116,
        ["y"] = -87.49709840626,
        ["g"] = 14,
        ["sublevel"] = 1,
      },
      [18] = {
        ["x"] = 479.2348894623,
        ["y"] = -81.869057801265,
        ["g"] = 14,
        ["sublevel"] = 1,
      },
      [19] = {
        ["x"] = 480.32188303709,
        ["y"] = -36.589190554371,
        ["g"] = 16,
        ["sublevel"] = 1,
      },
      [20] = {
        ["x"] = 465.07704962964,
        ["y"] = -36.255212348079,
        ["g"] = 16,
        ["sublevel"] = 1,
      },
      [21] = {
        ["x"] = 472.54434131434,
        ["y"] = -42.516238266918,
        ["g"] = 16,
        ["sublevel"] = 1,
      },
      [22] = {
        ["x"] = 480.80297656121,
        ["y"] = -172.77006480339,
        ["g"] = 10,
        ["sublevel"] = 1,
      },
      [23] = {
        ["x"] = 463.60661261032,
        ["y"] = -172.5305083486,
        ["g"] = 10,
        ["sublevel"] = 1,
      },
      [24] = {
        ["x"] = 471.64150851347,
        ["y"] = -154.5432863497,
        ["g"] = 10,
        ["sublevel"] = 1,
      },
    },
  },
  [15] = {
    ["name"] = "Portal Guardian",
    ["id"] = 167998,
    ["count"] = 8,
    ["health"] = 73080370,
    ["scale"] = 1.6,
    ["displayId"] = 96442,
    ["creatureType"] = "Elemental",
    ["level"] = 80,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [326494] = {
      },
      [326497] = {
      },
      [330716] = {
      },
      [330720] = {
      },
      [330725] = {
        ["curse"] = true,
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 523.91371031481,
        ["y"] = -213.66174755669,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 400.95620969865,
        ["y"] = -128.16170116714,
        ["g"] = 11,
        ["sublevel"] = 1,
      },
    },
  },
  [16] = {
    ["name"] = "Bone Magus",
    ["id"] = 170882,
    ["count"] = 4,
    ["health"] = 43848222,
    ["scale"] = 1,
    ["displayId"] = 97410,
    ["creatureType"] = "Undead",
    ["level"] = 80,
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
        ["magic"] = true,
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
        ["x"] = 514.35530870897,
        ["y"] = -131.90098154699,
        ["g"] = 9,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 507.29154675786,
        ["y"] = -137.47374966297,
        ["g"] = 9,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 389.47635463157,
        ["y"] = -123.47307847901,
        ["g"] = 11,
        ["sublevel"] = 1,
        ["inspiring"] = true,
      },
      [4] = {
        ["x"] = 390.11550269902,
        ["y"] = -101.68885572996,
        ["g"] = 13,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 399.71917041092,
        ["y"] = -101.58836318105,
        ["g"] = 13,
        ["sublevel"] = 1,
      },
      [6] = {
        ["x"] = 564.2695615772,
        ["y"] = -101.22290883655,
        ["g"] = 17,
        ["sublevel"] = 1,
      },
      [7] = {
        ["x"] = 566.21877400688,
        ["y"] = -84.618832820932,
        ["g"] = 17,
        ["sublevel"] = 1,
      },
      [8] = {
        ["x"] = 580.23899358148,
        ["y"] = -67.311611577055,
        ["g"] = 19,
        ["sublevel"] = 1,
      },
      [9] = {
        ["x"] = 570.68661991183,
        ["y"] = -66.89625042801,
        ["g"] = 19,
        ["sublevel"] = 1,
      },
      [10] = {
        ["x"] = 570.31486376264,
        ["y"] = -119.06297735253,
        ["g"] = 18,
        ["sublevel"] = 1,
      },
      [11] = {
        ["x"] = 561.00208362236,
        ["y"] = -118.80840334204,
        ["g"] = 18,
        ["sublevel"] = 1,
      },
      [12] = {
        ["x"] = 660.2552073597,
        ["y"] = -94.18263414517,
        ["g"] = 20,
        ["sublevel"] = 1,
      },
    },
  },
  [17] = {
    ["name"] = "Maniacal Soulbinder",
    ["id"] = 160495,
    ["count"] = 4,
    ["health"] = 43848222,
    ["scale"] = 1.3,
    ["displayId"] = 95233,
    ["creatureType"] = "Humanoid",
    ["level"] = 80,
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
    },
    ["clones"] = {
      [1] = {
        ["x"] = 388.04299884171,
        ["y"] = -134.1027704827,
        ["g"] = 11,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 396.61311683897,
        ["y"] = -160.14088675893,
        ["g"] = 12,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 665.64269986781,
        ["y"] = -103.75308920762,
        ["g"] = 20,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 480.57278164867,
        ["y"] = -95.087203427515,
        ["g"] = 14,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 472.74168207639,
        ["y"] = -28.669264024298,
        ["g"] = 16,
        ["sublevel"] = 1,
        ["inspiring"] = true,
      },
      [6] = {
        ["x"] = 471.71959848747,
        ["y"] = -165.82195226048,
        ["g"] = 10,
        ["sublevel"] = 1,
      },
    },
  },
  [18] = {
    ["name"] = "Soulforged Bonereaver",
    ["id"] = 162763,
    ["count"] = 8,
    ["health"] = 97440494,
    ["scale"] = 1.6,
    ["displayId"] = 94812,
    ["creatureType"] = "Undead",
    ["level"] = 80,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [331223] = {
      },
      [331224] = {
      },
      [331237] = {
      },
      [331243] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 573.63113882727,
        ["y"] = -94.425850283165,
        ["g"] = 17,
        ["sublevel"] = 1,
      },
    },
  },
  [19] = {
    ["name"] = "Nefarious Darkspeaker",
    ["id"] = 169893,
    ["count"] = 6,
    ["health"] = 68208346,
    ["scale"] = 1.6,
    ["displayId"] = 97011,
    ["creatureType"] = "Undead",
    ["level"] = 80,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [330875] = {
        ["interruptible"] = true,
      },
      [333294] = {
      },
      [333297] = {
      },
      [333299] = {
        ["curse"] = true,
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 672.5989544382,
        ["y"] = -91.267409721784,
        ["g"] = 20,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 483.42530827268,
        ["y"] = -62.924438535887,
        ["g"] = 15,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 469.34266283777,
        ["y"] = -63.153814760415,
        ["g"] = 15,
        ["sublevel"] = 1,
      },
    },
  },
  [20] = {
    ["name"] = "Kul'tharok",
    ["id"] = 162309,
    ["count"] = 0,
    ["health"] = 312064346,
    ["scale"] = 1.6,
    ["displayId"] = 96088,
    ["creatureType"] = "Undead",
    ["level"] = 80,
    ["isBoss"] = true,
    ["encounterID"] = 2389,
    ["instanceID"] = 1187,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [317367] = {
      },
      [473519] = {
      },
      [473540] = {
      },
      [473576] = {
      },
      [474009] = {
      },
      [474084] = {
      },
      [474087] = {
      },
      [474298] = {
      },
      [1215787] = {
      },
      [1216475] = {
        ["interruptible"] = true,
      },
      [1216745] = {
      },
      [1222949] = {
      },
      [1223240] = {
      },
      [1223803] = {
      },
      [1223804] = {
      },
      [1225377] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 618.4890136762,
        ["y"] = -216.39666959202,
        ["g"] = 30,
        ["sublevel"] = 1,
      },
    },
  },
  [21] = {
    ["name"] = "Disgusting Refuse",
    ["id"] = 163089,
    ["count"] = 1,
    ["health"] = 12180062,
    ["scale"] = 1,
    ["displayId"] = 94761,
    ["creatureType"] = "Undead",
    ["level"] = 80,
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
      [330694] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 484.60948177629,
        ["y"] = -346.73014988254,
        ["g"] = 21,
        ["sublevel"] = 1,
        ["inspiring"] = true,
      },
      [2] = {
        ["x"] = 486.1305233889,
        ["y"] = -356.48478301002,
        ["g"] = 21,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 493.08177499947,
        ["y"] = -350.38822789396,
        ["g"] = 21,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 477.33133091851,
        ["y"] = -342.94292645573,
        ["g"] = 21,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 436.83791058993,
        ["y"] = -367.26458882428,
        ["g"] = 22,
        ["sublevel"] = 1,
      },
      [6] = {
        ["x"] = 429.44634663065,
        ["y"] = -364.70995465321,
        ["g"] = 22,
        ["sublevel"] = 1,
      },
      [7] = {
        ["x"] = 444.48360188688,
        ["y"] = -370.41291744879,
        ["g"] = 22,
        ["sublevel"] = 1,
      },
      [8] = {
        ["x"] = 80.871051090016,
        ["y"] = -394.12623738203,
        ["g"] = 24,
        ["sublevel"] = 1,
      },
      [9] = {
        ["x"] = 70.166924912257,
        ["y"] = -414.66340144284,
        ["g"] = 24,
        ["sublevel"] = 1,
      },
      [10] = {
        ["x"] = 147.33806564831,
        ["y"] = -422.64580444393,
        ["g"] = 25,
        ["sublevel"] = 1,
      },
      [11] = {
        ["x"] = 137.94487894504,
        ["y"] = -418.53059527308,
        ["g"] = 25,
        ["sublevel"] = 1,
      },
      [12] = {
        ["x"] = 152.26466284933,
        ["y"] = -437.28501875026,
        ["g"] = 25,
        ["sublevel"] = 1,
      },
      [13] = {
        ["x"] = 156.55835365785,
        ["y"] = -427.79912890975,
        ["g"] = 25,
        ["sublevel"] = 1,
      },
      [14] = {
        ["x"] = 434.98230079658,
        ["y"] = -357.89784846811,
        ["g"] = 22,
        ["sublevel"] = 1,
      },
      [15] = {
        ["x"] = 142.20424005624,
        ["y"] = -432.38477403524,
        ["g"] = 25,
        ["sublevel"] = 1,
      },
    },
  },
  [22] = {
    ["name"] = "Diseased Horror",
    ["id"] = 170690,
    ["count"] = 4,
    ["health"] = 48720247,
    ["scale"] = 1.7,
    ["displayId"] = 97117,
    ["creatureType"] = "Undead",
    ["level"] = 80,
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
      [319290] = {
      },
      [330697] = {
      },
      [330700] = {
        ["disease"] = true,
      },
      [341977] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 501.96458929414,
        ["y"] = -367.77344069382,
        ["g"] = 21,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 68.113058034615,
        ["y"] = -390.3861889978,
        ["g"] = 24,
        ["sublevel"] = 1,
        ["inspiring"] = true,
      },
      [3] = {
        ["x"] = 195.52362104312,
        ["y"] = -434.27446026159,
        ["g"] = 26,
        ["sublevel"] = 1,
      },
    },
  },
  [23] = {
    ["name"] = "Putrid Butcher",
    ["id"] = 169927,
    ["count"] = 5,
    ["health"] = 58464296,
    ["scale"] = 1.7,
    ["displayId"] = 97116,
    ["creatureType"] = "Undead",
    ["level"] = 80,
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
    },
    ["clones"] = {
      [1] = {
        ["x"] = 457.7270850473,
        ["y"] = -348.44380285066,
        ["g"] = 22,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 377.68997566581,
        ["y"] = -334.95529448071,
        ["g"] = 23,
        ["sublevel"] = 1,
        ["patrol"] = {
          [1] = {
            ["x"] = 386.85053456929,
            ["y"] = -337.60167082446,
          },
          [2] = {
            ["x"] = 412.31235546846,
            ["y"] = -340.82852159552,
          },
          [3] = {
            ["x"] = 386.85053456929,
            ["y"] = -337.60167082446,
          },
          [4] = {
            ["x"] = 358.1089859512,
            ["y"] = -331.91230016297,
          },
        },
      },
      [3] = {
        ["x"] = 60.433528690327,
        ["y"] = -405.78361345574,
        ["g"] = 24,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 189.29527264031,
        ["y"] = -448.94254694795,
        ["g"] = 26,
        ["sublevel"] = 1,
      },
    },
  },
  [24] = {
    ["name"] = "Rancid Gasbag",
    ["id"] = 163086,
    ["count"] = 8,
    ["health"] = 92568469,
    ["scale"] = 2,
    ["stealthDetect"] = true,
    ["displayId"] = 97161,
    ["creatureType"] = "Undead",
    ["level"] = 80,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [330592] = {
        ["disease"] = true,
      },
      [330608] = {
        ["disease"] = true,
      },
      [330614] = {
      },
      [330973] = {
      },
      [345245] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 328.61135617354,
        ["y"] = -372.55225589355,
        ["sublevel"] = 1,
        ["patrol"] = {
          [1] = {
            ["x"] = 339.69565702743,
            ["y"] = -372.77619682089,
          },
          [2] = {
            ["x"] = 325.51070096282,
            ["y"] = -373.97320367962,
          },
          [3] = {
            ["x"] = 315.99388971914,
            ["y"] = -385.28140913039,
          },
          [4] = {
            ["x"] = 316.55370570705,
            ["y"] = -400.6202727399,
          },
          [5] = {
            ["x"] = 326.98636058532,
            ["y"] = -409.27509519396,
          },
          [6] = {
            ["x"] = 316.55370570705,
            ["y"] = -400.6202727399,
          },
          [7] = {
            ["x"] = 315.99388971914,
            ["y"] = -385.28140913039,
          },
          [8] = {
            ["x"] = 325.51070096282,
            ["y"] = -373.97320367962,
          },
          [9] = {
            ["x"] = 339.69565702743,
            ["y"] = -372.77619682089,
          },
        },
      },
      [2] = {
        ["x"] = 346.44401785098,
        ["y"] = -276.28305818877,
        ["sublevel"] = 1,
        ["patrol"] = {
          [1] = {
            ["x"] = 344.54067740052,
            ["y"] = -275.94716496298,
          },
          [2] = {
            ["x"] = 344.68707648999,
            ["y"] = -277.68171635772,
          },
          [3] = {
            ["x"] = 344.23924312929,
            ["y"] = -262.00694322578,
          },
          [4] = {
            ["x"] = 353.19624942746,
            ["y"] = -249.91500652152,
          },
          [5] = {
            ["x"] = 364.84030433042,
            ["y"] = -248.12364885843,
          },
          [6] = {
            ["x"] = 353.19624942746,
            ["y"] = -249.91500652152,
          },
          [7] = {
            ["x"] = 344.23924312929,
            ["y"] = -262.00694322578,
          },
          [8] = {
            ["x"] = 344.68707648999,
            ["y"] = -277.68171635772,
          },
          [9] = {
            ["x"] = 359.54365383931,
            ["y"] = -285.0161367375,
          },
        },
      },
      [3] = {
        ["x"] = 120.36197595597,
        ["y"] = -416.8824919825,
        ["sublevel"] = 1,
        ["patrol"] = {
          [1] = {
            ["x"] = 120.36197595597,
            ["y"] = -416.8824919825,
          },
          [2] = {
            ["x"] = 167.33852617244,
            ["y"] = -434.87703883485,
          },
          [3] = {
            ["x"] = 94.338951484704,
            ["y"] = -409.79742604404,
          },
        },
      },
    },
  },
  [25] = {
    ["name"] = "Gorechop",
    ["id"] = 162317,
    ["count"] = 0,
    ["health"] = 341320379,
    ["scale"] = 2,
    ["displayId"] = 95106,
    ["creatureType"] = "Undead",
    ["level"] = 80,
    ["isBoss"] = true,
    ["encounterID"] = 2401,
    ["instanceID"] = 1187,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [318406] = {
      },
      [322795] = {
      },
      [323515] = {
      },
      [332859] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 249.25652595758,
        ["y"] = -458.83708100361,
        ["g"] = 28,
        ["sublevel"] = 1,
      },
    },
  },
  [26] = {
    ["name"] = "Mordretha, the Endless Empress",
    ["id"] = 165946,
    ["count"] = 0,
    ["health"] = 390080433,
    ["scale"] = 2,
    ["displayId"] = 96078,
    ["creatureType"] = "Humanoid",
    ["level"] = 80,
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
      [323825] = {
      },
      [324079] = {
      },
      [324424] = {
      },
      [324449] = {
      },
      [339550] = {
      },
      [339573] = {
      },
      [339706] = {
      },
      [339759] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 144.77926484572,
        ["y"] = -67.917208439022,
        ["g"] = 29,
        ["sublevel"] = 1,
      },
    },
  },
  [27] = {
    ["name"] = "Nekthara the Mangler",
    ["id"] = 162744,
    ["count"] = 20,
    ["health"] = 155904790,
    ["scale"] = 2,
    ["displayId"] = 97489,
    ["creatureType"] = "Humanoid",
    ["level"] = 81,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [317605] = {
      },
      [331288] = {
      },
      [336995] = {
      },
      [337037] = {
      },
      [342135] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 675.41241350024,
        ["y"] = -488.93427095926,
        ["sublevel"] = 1,
      },
    },
  },
  [28] = {
    ["name"] = "Heavin the Breaker",
    ["id"] = 167532,
    ["count"] = 20,
    ["health"] = 155904790,
    ["scale"] = 2,
    ["displayId"] = 97490,
    ["creatureType"] = "Humanoid",
    ["level"] = 81,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [317605] = {
      },
      [331288] = {
      },
      [332708] = {
      },
      [342135] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 741.96674413448,
        ["y"] = -447.5485664194,
        ["sublevel"] = 1,
      },
    },
  },
  [29] = {
    ["name"] = "Rek the Hardened",
    ["id"] = 167534,
    ["count"] = 20,
    ["health"] = 155904790,
    ["scale"] = 2,
    ["displayId"] = 126296,
    ["creatureType"] = "Humanoid",
    ["level"] = 81,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [317605] = {
      },
      [333839] = {
      },
      [333841] = {
      },
      [333845] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 797.52195767528,
        ["y"] = -506.19346406857,
        ["sublevel"] = 1,
      },
    },
  },
  [30] = {
    ["name"] = "Blighted Sludge-Spewer",
    ["id"] = 174210,
    ["count"] = 4,
    ["health"] = 38976198,
    ["scale"] = 1.3,
    ["displayId"] = 94755,
    ["creatureType"] = "Undead",
    ["level"] = 80,
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
      [330694] = {
      },
      [330700] = {
        ["disease"] = true,
      },
      [330703] = {
        ["interruptible"] = true,
        ["disease"] = true,
      },
      [341969] = {
        ["interruptible"] = true,
        ["disease"] = true,
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 476.01548134424,
        ["y"] = -353.11535728226,
        ["g"] = 21,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 444.83177202662,
        ["y"] = -360.50449627585,
        ["g"] = 22,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 390.30235688119,
        ["y"] = -329.510066385,
        ["g"] = 23,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 386.84581417175,
        ["y"] = -345.68278927358,
        ["g"] = 23,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 133.01979584571,
        ["y"] = -428.33908227925,
        ["g"] = 25,
        ["sublevel"] = 1,
      },
      [6] = {
        ["x"] = 75.050460639255,
        ["y"] = -403.78982368909,
        ["g"] = 24,
        ["sublevel"] = 1,
      },
    },
  },
  [31] = {
    ["name"] = "Oozing Leftovers",
    ["id"] = 165260,
    ["count"] = 0,
    ["health"] = 36540188,
    ["scale"] = 1.6,
    ["displayId"] = 94761,
    ["creatureType"] = "Undead",
    ["level"] = 80,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Root"] = true,
      ["Disorient"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
    },
    ["spells"] = {
      [323107] = {
      },
      [323110] = {
      },
      [323542] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 231.60845598061,
        ["y"] = -432.88196998995,
        ["g"] = 28,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 216.13521330596,
        ["y"] = -469.26429355749,
        ["g"] = 28,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 277.93844534993,
        ["y"] = -447.76749297406,
        ["g"] = 28,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 265.39872372558,
        ["y"] = -487.62612740437,
        ["g"] = 28,
        ["sublevel"] = 1,
      },
    },
  },
  [32] = {
    ["name"] = "Oppressive Banner",
    ["id"] = 170234,
    ["count"] = 0,
    ["health"] = 14210073,
    ["scale"] = 2,
    ["displayId"] = 97254,
    ["creatureType"] = "Undead",
    ["level"] = 80,
    ["spells"] = {
      [331606] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 689.94795871022,
        ["y"] = -534.54397573096,
        ["g"] = 31,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 742.55858668975,
        ["y"] = -524.80087083331,
        ["g"] = 31,
        ["sublevel"] = 1,
      },
    },
  },
  [33] = {
    ["name"] = "Lost Soul",
    ["id"] = 234443,
    ["count"] = 0,
    ["health"] = 8120042,
    ["scale"] = 1.6,
    ["displayId"] = 96131,
    ["creatureType"] = "Undead",
    ["level"] = 80,
    ["characteristics"] = {
      ["Stun"] = true,
      ["Slow"] = true,
    },
    ["spells"] = {
      [474013] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 632.84182548857,
        ["y"] = -201.49981103802,
        ["g"] = 30,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 638.53631098775,
        ["y"] = -217.42517812088,
        ["g"] = 30,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 632.39140624108,
        ["y"] = -233.77692382807,
        ["g"] = 30,
        ["sublevel"] = 1,
      },
    },
  },
  [34] = {
    ["name"] = "Deathwalker",
    ["id"] = 166524,
    ["count"] = 0,
    ["health"] = 4872025,
    ["scale"] = 1.6,
    ["displayId"] = 96337,
    ["creatureType"] = "Elemental",
    ["level"] = 80,
    ["characteristics"] = {
      ["Incapacitate"] = true,
      ["Silence"] = true,
      ["Fear"] = true,
      ["Disorient"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
    },
    ["spells"] = {
      [324589] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 167.75493233652,
        ["y"] = -73.706317765161,
        ["g"] = 29,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 159.01001631098,
        ["y"] = -88.147031780354,
        ["g"] = 29,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 121.39065767552,
        ["y"] = -75.607358596604,
        ["g"] = 29,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 144.67876748143,
        ["y"] = -92.177822670244,
        ["g"] = 29,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 129.45197303199,
        ["y"] = -88.147177102158,
        ["g"] = 29,
        ["sublevel"] = 1,
      },
    },
  },
};
