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
  [1] = { customTextures = 'Interface\\AddOns\\' .. addonName .. '\\TheWarWithin\\Textures\\TheaterOfPain' }
}

MDT.dungeonSubLevels[dungeonIndex] = {
  [1] = L["Theater of Pain"],
}

MDT.dungeonTotalCount[dungeonIndex] = { normal = 271, teeming = 1000, teemingEnabled = true }

MDT.mapPOIs[dungeonIndex] = {};

MDT.dungeonEnemies[dungeonIndex] = {
  [1] = {
    ["name"] = "Battlefield Ritualist",
    ["id"] = 174197,
    ["count"] = 4,
    ["health"] = 26183974,
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
        ["x"] = 145.16592837525,
        ["y"] = -227.09086364086,
        ["g"] = 1,
        ["sublevel"] = 1,
      },
    },
  },
  [2] = {
    ["name"] = "Unyielding Contender",
    ["id"] = 170838,
    ["count"] = 4,
    ["health"] = 33457299,
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
        ["x"] = 157.46177727182,
        ["y"] = -234.93303839932,
        ["g"] = 1,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 132.82932346672,
        ["y"] = -235.78375000971,
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
    ["health"] = 52367947,
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
        ["x"] = 144.80822268576,
        ["y"] = -206.60086814044,
        ["sublevel"] = 1,
      },
    },
  },
  [4] = {
    ["name"] = "Dessia the Decapitator",
    ["id"] = 164451,
    ["count"] = 0,
    ["health"] = 104515860,
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
    ["health"] = 92902987,
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
      [320120] = {
        ["interruptible"] = true,
      },
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
    ["health"] = 81290113,
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
    ["name"] = "Xira the Underhanded",
    ["id"] = 164464,
    ["count"] = 0,
    ["health"] = 67427,
    ["scale"] = 5,
    ["displayId"] = 96440,
    ["creatureType"] = "Humanoid",
    ["level"] = 80,
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
    },
    ["clones"] = {
      [1] = {
        ["x"] = 186.25434759505,
        ["y"] = -342.03038628007,
        ["sublevel"] = 1,
      },
    },
  },
  [8] = {
    ["name"] = "Shambling Arbalest",
    ["id"] = 164510,
    ["count"] = 4,
    ["health"] = 24729308,
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
  [9] = {
    ["name"] = "Ossified Conscript",
    ["id"] = 167994,
    ["count"] = 4,
    ["health"] = 29093304,
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
  [10] = {
    ["name"] = "Dokigg the Brutalizer",
    ["id"] = 167538,
    ["count"] = 20,
    ["health"] = 93098572,
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
  [11] = {
    ["name"] = "Harugia the Bloodthirsty",
    ["id"] = 167536,
    ["count"] = 20,
    ["health"] = 91558084,
    ["scale"] = 2,
    ["displayId"] = 95969,
    ["creatureType"] = "Humanoid",
    ["level"] = 80,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [333861] = {
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
  [12] = {
    ["name"] = "Ancient Captain",
    ["id"] = 164506,
    ["count"] = 5,
    ["health"] = 34911965,
    ["scale"] = 1.5,
    ["displayId"] = 96489,
    ["creatureType"] = "Undead",
    ["level"] = 81,
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
      },
    },
  },
  [13] = {
    ["name"] = "Advent Nevermore",
    ["id"] = 167533,
    ["count"] = 20,
    ["health"] = 91558084,
    ["scale"] = 2,
    ["displayId"] = 95966,
    ["creatureType"] = "Humanoid",
    ["level"] = 80,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
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
  [14] = {
    ["name"] = "Xav the Unfallen",
    ["id"] = 162329,
    ["count"] = 0,
    ["health"] = 182902755,
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
    },
    ["clones"] = {
      [1] = {
        ["x"] = 716.14955488287,
        ["y"] = -523.56946864618,
        ["sublevel"] = 1,
      },
    },
  },
  [15] = {
    ["name"] = "Shackled Soul",
    ["id"] = 169875,
    ["count"] = 2,
    ["health"] = 17455982,
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
  [16] = {
    ["name"] = "Portal Guardian",
    ["id"] = 167998,
    ["count"] = 8,
    ["health"] = 43639956,
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
  [17] = {
    ["name"] = "Bone Magus",
    ["id"] = 170882,
    ["count"] = 4,
    ["health"] = 14546652,
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
  [18] = {
    ["name"] = "Maniacal Soulbinder",
    ["id"] = 160495,
    ["count"] = 4,
    ["health"] = 26183974,
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
  [19] = {
    ["name"] = "Soulforged Bonereaver",
    ["id"] = 162763,
    ["count"] = 8,
    ["health"] = 58186608,
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
  [20] = {
    ["name"] = "Nefarious Darkspeaker",
    ["id"] = 169893,
    ["count"] = 6,
    ["health"] = 40730625,
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
  [21] = {
    ["name"] = "Kul'tharok",
    ["id"] = 162309,
    ["count"] = 0,
    ["health"] = 185805973,
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
    },
    ["clones"] = {
      [1] = {
        ["x"] = 618.4890136762,
        ["y"] = -216.39666959202,
        ["sublevel"] = 1,
      },
    },
  },
  [22] = {
    ["name"] = "Disgusting Refuse",
    ["id"] = 163089,
    ["count"] = 1,
    ["health"] = 7273326,
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
      [9] = {
        ["x"] = 80.871051090016,
        ["y"] = -394.12623738203,
        ["g"] = 24,
        ["sublevel"] = 1,
      },
      [10] = {
        ["x"] = 70.166924912257,
        ["y"] = -414.66340144284,
        ["g"] = 24,
        ["sublevel"] = 1,
      },
      [11] = {
        ["x"] = 147.33806564831,
        ["y"] = -422.64580444393,
        ["g"] = 25,
        ["sublevel"] = 1,
      },
      [12] = {
        ["x"] = 137.94487894504,
        ["y"] = -418.53059527308,
        ["g"] = 25,
        ["sublevel"] = 1,
      },
      [14] = {
        ["x"] = 152.26466284933,
        ["y"] = -437.28501875026,
        ["g"] = 25,
        ["sublevel"] = 1,
      },
      [15] = {
        ["x"] = 156.55835365785,
        ["y"] = -427.79912890975,
        ["g"] = 25,
        ["sublevel"] = 1,
      },
      [17] = {
        ["x"] = 434.98230079658,
        ["y"] = -357.89784846811,
        ["g"] = 22,
        ["sublevel"] = 1,
      },
      [21] = {
        ["x"] = 142.20424005624,
        ["y"] = -432.38477403524,
        ["g"] = 25,
        ["sublevel"] = 1,
      },
    },
  },
  [23] = {
    ["name"] = "Diseased Horror",
    ["id"] = 170690,
    ["count"] = 4,
    ["health"] = 29093304,
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
        ["x"] = 508.23435322511,
        ["y"] = -374.93904088829,
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
  [24] = {
    ["name"] = "Putrid Butcher",
    ["id"] = 169927,
    ["count"] = 5,
    ["health"] = 34911965,
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
        ["x"] = 456.31284883304,
        ["y"] = -341.60818334308,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 372.07140393844,
        ["y"] = -334.46676463867,
        ["g"] = 23,
        ["sublevel"] = 1,
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
  [25] = {
    ["name"] = "Rancid Gasbag",
    ["id"] = 163086,
    ["count"] = 8,
    ["health"] = 55277278,
    ["scale"] = 2,
    ["displayId"] = 97161,
    ["creatureType"] = "Undead",
    ["level"] = 80,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [330614] = {
      },
      [330973] = {
      },
      [345245] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 336.89660130819,
        ["y"] = -371.09676096732,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 359.54365383931,
        ["y"] = -285.0161367375,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 107.82213323011,
        ["y"] = -414.64324040796,
        ["sublevel"] = 1,
      },
    },
  },
  [26] = {
    ["name"] = "Gorechop",
    ["id"] = 162317,
    ["count"] = 0,
    ["health"] = 203225283,
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
      [323515] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 250.15214423838,
        ["y"] = -459.73275983516,
        ["sublevel"] = 1,
      },
    },
  },
  [27] = {
    ["name"] = "Mordretha, the Endless Empress",
    ["id"] = 165946,
    ["count"] = 0,
    ["health"] = 232257466,
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
      [324079] = {
      },
      [324424] = {
      },
      [324449] = {
      },
      [339573] = {
      },
      [339759] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 149.2577922151,
        ["y"] = -83.144075549365,
        ["sublevel"] = 1,
      },
    },
  },
  [28] = {
    ["name"] = "Nekthara the Mangler",
    ["id"] = 162744,
    ["count"] = 20,
    ["health"] = 93098572,
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
  [29] = {
    ["name"] = "Heavin the Breaker",
    ["id"] = 167532,
    ["count"] = 20,
    ["health"] = 93098572,
    ["scale"] = 2,
    ["displayId"] = 97490,
    ["creatureType"] = "Humanoid",
    ["level"] = 81,
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
        ["x"] = 741.96674413448,
        ["y"] = -447.5485664194,
        ["sublevel"] = 1,
      },
    },
  },
  [30] = {
    ["name"] = "Rek the Hardened",
    ["id"] = 167534,
    ["count"] = 20,
    ["health"] = 93098572,
    ["scale"] = 2,
    ["displayId"] = 96829,
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
  [31] = {
    ["name"] = "Blighted Sludge-Spewer",
    ["id"] = 174210,
    ["count"] = 4,
    ["health"] = 23274643,
    ["scale"] = 1.3,
    ["displayId"] = 95559,
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
        ["x"] = 382.85169539159,
        ["y"] = -329.22511919756,
        ["g"] = 23,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 379.19157002754,
        ["y"] = -342.54787207856,
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
};
