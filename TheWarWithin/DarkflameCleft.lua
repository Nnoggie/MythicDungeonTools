local addonName = ...
local MDT = MDT
local L = MDT.L

local dungeonIndex = 117
MDT.dungeonList[dungeonIndex] = L["Darkflame Cleft"]
MDT.mapInfo[dungeonIndex] = {
  teleportId = 445441,
  shortName = L["darkflameShortName"],
  englishName = "Darkflame Cleft",
  mapID = 504
}

local zones = { 2214, 2303 }
for _, zone in ipairs(zones) do
  MDT.zoneIdToDungeonIdx[zone] = dungeonIndex
end

MDT.dungeonMaps[dungeonIndex] = {
  [0] = "DarkflameCleft",
  [1] = "DarkflameCleft",
}

MDT.dungeonSubLevels[dungeonIndex] = {
  [1] = L["Darkflame Cleft"]
}

MDT.dungeonTotalCount[dungeonIndex] = { normal = 438, teeming = 1000, teemingEnabled = true }

MDT.mapPOIs[dungeonIndex] = {};

MDT.dungeonEnemies[dungeonIndex] = {
  [1] = {
    ["name"] = "Menial Laborer",
    ["id"] = 210810,
    ["count"] = 1,
    ["health"] = 5722380,
    ["scale"] = 0.8,
    ["displayId"] = 114696,
    ["creatureType"] = "Humanoid",
    ["level"] = 80,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Silence"] = true,
      ["Fear"] = true,
      ["Stun"] = true,
    },
    ["spells"] = {
      [425565] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 167.54588102631,
        ["y"] = -245.05138763633,
        ["g"] = 9,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 189.55120772741,
        ["y"] = -394.55755642672,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 184.45985969599,
        ["y"] = -370.78490015574,
        ["g"] = 1,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 180.41706310354,
        ["y"] = -377.66567789835,
        ["g"] = 1,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 188.26559465985,
        ["y"] = -377.33791062591,
        ["g"] = 1,
        ["sublevel"] = 1,
      },
      [6] = {
        ["x"] = 209.28125144987,
        ["y"] = -362.89091981151,
        ["g"] = 2,
        ["sublevel"] = 1,
      },
      [7] = {
        ["x"] = 205.24833834058,
        ["y"] = -370.49250012223,
        ["g"] = 2,
        ["sublevel"] = 1,
      },
      [8] = {
        ["x"] = 212.95076540057,
        ["y"] = -370.85578171513,
        ["g"] = 2,
        ["sublevel"] = 1,
      },
      [9] = {
        ["x"] = 197.14301957487,
        ["y"] = -343.27165544738,
        ["g"] = 3,
        ["sublevel"] = 1,
      },
      [10] = {
        ["x"] = 204.99155113119,
        ["y"] = -343.45332129043,
        ["g"] = 3,
        ["sublevel"] = 1,
      },
      [11] = {
        ["x"] = 200.90338024829,
        ["y"] = -350.62639594439,
        ["g"] = 3,
        ["sublevel"] = 1,
      },
      [12] = {
        ["x"] = 179.40395596667,
        ["y"] = -315.12283724124,
        ["g"] = 4,
        ["sublevel"] = 1,
      },
      [13] = {
        ["x"] = 199.0288317181,
        ["y"] = -314.87589724107,
        ["g"] = 4,
        ["sublevel"] = 1,
      },
      [14] = {
        ["x"] = 197.34453314675,
        ["y"] = -326.32447416375,
        ["g"] = 4,
        ["sublevel"] = 1,
      },
      [15] = {
        ["x"] = 189.26463719625,
        ["y"] = -308.42370898473,
        ["g"] = 4,
        ["sublevel"] = 1,
      },
      [16] = {
        ["x"] = 181.54097716597,
        ["y"] = -326.81399412255,
        ["g"] = 4,
        ["sublevel"] = 1,
      },
      [17] = {
        ["x"] = 220.55732660493,
        ["y"] = -241.12852921842,
        ["g"] = 7,
        ["sublevel"] = 1,
      },
      [18] = {
        ["x"] = 220.90246283605,
        ["y"] = -256.77242404775,
        ["g"] = 7,
        ["sublevel"] = 1,
      },
      [19] = {
        ["x"] = 220.46770726204,
        ["y"] = -233.36925365724,
        ["g"] = 7,
        ["sublevel"] = 1,
      },
      [20] = {
        ["x"] = 228.33896205462,
        ["y"] = -257.21229013432,
        ["g"] = 7,
        ["sublevel"] = 1,
      },
      [21] = {
        ["x"] = 228.21702048229,
        ["y"] = -240.8308314037,
        ["g"] = 7,
        ["sublevel"] = 1,
      },
      [22] = {
        ["x"] = 227.96491529094,
        ["y"] = -232.87025242508,
        ["g"] = 7,
        ["sublevel"] = 1,
      },
      [23] = {
        ["x"] = 220.53725210235,
        ["y"] = -248.7311105098,
        ["g"] = 7,
        ["sublevel"] = 1,
      },
      [24] = {
        ["x"] = 228.4097862192,
        ["y"] = -248.37173683429,
        ["g"] = 7,
        ["sublevel"] = 1,
      },
      [25] = {
        ["x"] = 219.76849628052,
        ["y"] = -200.06218121196,
        ["g"] = 12,
        ["sublevel"] = 1,
      },
      [26] = {
        ["x"] = 200.15931543283,
        ["y"] = -200.43194889902,
        ["g"] = 12,
        ["sublevel"] = 1,
      },
      [27] = {
        ["x"] = 205.76941703876,
        ["y"] = -194.74593764823,
        ["g"] = 12,
        ["sublevel"] = 1,
      },
      [28] = {
        ["x"] = 213.63170719825,
        ["y"] = -194.26047877422,
        ["g"] = 12,
        ["sublevel"] = 1,
      },
      [29] = {
        ["x"] = 197.6648829398,
        ["y"] = -218.68703468388,
        ["g"] = 11,
        ["sublevel"] = 1,
      },
      [30] = {
        ["x"] = 205.20368850318,
        ["y"] = -218.78656790292,
        ["g"] = 11,
        ["sublevel"] = 1,
      },
      [31] = {
        ["x"] = 212.60611302033,
        ["y"] = -218.19913320742,
        ["g"] = 11,
        ["sublevel"] = 1,
      },
      [32] = {
        ["x"] = 208.74419316436,
        ["y"] = -225.29507260671,
        ["g"] = 11,
        ["sublevel"] = 1,
      },
      [33] = {
        ["x"] = 201.40407139021,
        ["y"] = -226.07407853902,
        ["g"] = 11,
        ["sublevel"] = 1,
      },
      [34] = {
        ["x"] = 330.90395738776,
        ["y"] = -409.69742578297,
        ["g"] = 24,
        ["sublevel"] = 1,
      },
      [35] = {
        ["x"] = 325.12967418471,
        ["y"] = -419.94988909764,
        ["g"] = 24,
        ["sublevel"] = 1,
      },
      [36] = {
        ["x"] = 331.51043680992,
        ["y"] = -430.01253884071,
        ["g"] = 24,
        ["sublevel"] = 1,
      },
      [37] = {
        ["x"] = 160.81937940347,
        ["y"] = -240.55739361424,
        ["g"] = 9,
        ["sublevel"] = 1,
      },
      [38] = {
        ["x"] = 160.65993522392,
        ["y"] = -256.85184241948,
        ["g"] = 9,
        ["sublevel"] = 1,
      },
      [39] = {
        ["x"] = 160.73236623203,
        ["y"] = -248.73361028429,
        ["g"] = 9,
        ["sublevel"] = 1,
      },
      [40] = {
        ["x"] = 167.32847303256,
        ["y"] = -253.34361299938,
        ["g"] = 9,
        ["sublevel"] = 1,
      },
    },
  },
  [2] = {
    ["name"] = "Rank Overseer",
    ["id"] = 211121,
    ["count"] = 10,
    ["health"] = 45779042,
    ["scale"] = 1.5,
    ["displayId"] = 114091,
    ["creatureType"] = "Humanoid",
    ["level"] = 81,
    ["spells"] = {
      [423501] = {
      },
      [428064] = {
      },
      [428066] = {
      },
    },
    ["clones"] = {
      [2] = {
        ["x"] = 189.01954887993,
        ["y"] = -318.81360942073,
        ["g"] = 4,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 208.82642446501,
        ["y"] = -244.41240521039,
        ["g"] = 7,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 178.40017824647,
        ["y"] = -246.04278146831,
        ["g"] = 8,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 189.18112823438,
        ["y"] = -180.39075961932,
        ["sublevel"] = 1,
      },
    },
  },
  [3] = {
    ["name"] = "Lowly Moleherd",
    ["id"] = 210818,
    ["count"] = 5,
    ["health"] = 27181306,
    ["scale"] = 1.5,
    ["displayId"] = 114721,
    ["creatureType"] = "Humanoid",
    ["level"] = 80,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Incapacitate"] = true,
      ["Fear"] = true,
      ["Stun"] = true,
    },
    ["spells"] = {
      [424650] = {
        ["enrage"] = true,
      },
      [425536] = {
        ["interruptible"] = true,
      },
      [428089] = {
      },
    },
    ["clones"] = {
      [2] = {
        ["x"] = 174.13732630813,
        ["y"] = -289.77201623713,
        ["g"] = 5,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 172.40302317591,
        ["y"] = -221.04643232948,
        ["g"] = 10,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 178.82424637073,
        ["y"] = -169.35431323741,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 199.63886515771,
        ["y"] = -168.93834110761,
        ["sublevel"] = 1,
      },
    },
  },
  [4] = {
    ["name"] = "Pack Mole",
    ["id"] = 211977,
    ["count"] = 3,
    ["health"] = 30042496,
    ["scale"] = 1.5,
    ["displayId"] = 112394,
    ["creatureType"] = "Beast",
    ["level"] = 80,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Silence"] = true,
      ["Fear"] = true,
      ["Stun"] = true,
    },
    ["spells"] = {
      [425561] = {
      },
      [425704] = {
        ["enrage"] = true,
      },
      [427929] = {
        ["disease"] = true,
      },
    },
    ["clones"] = {
      [2] = {
        ["x"] = 160.62272002388,
        ["y"] = -289.71662965241,
        ["g"] = 5,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 161.25277401111,
        ["y"] = -275.39035567572,
        ["g"] = 5,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 174.61133097726,
        ["y"] = -276.1111919801,
        ["g"] = 5,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 159.79225707305,
        ["y"] = -221.3922912182,
        ["g"] = 10,
        ["sublevel"] = 1,
      },
      [6] = {
        ["x"] = 160.21646488714,
        ["y"] = -207.60160489065,
        ["g"] = 10,
        ["sublevel"] = 1,
      },
      [7] = {
        ["x"] = 181.75704586048,
        ["y"] = -153.69507364785,
        ["g"] = 13,
        ["sublevel"] = 1,
      },
      [8] = {
        ["x"] = 195.55000392002,
        ["y"] = -153.64746886637,
        ["g"] = 13,
        ["sublevel"] = 1,
      },
      [9] = {
        ["x"] = 256.47367866784,
        ["y"] = -105.57498942262,
        ["g"] = 14,
        ["sublevel"] = 1,
      },
      [10] = {
        ["x"] = 256.20586301971,
        ["y"] = -120.53136441282,
        ["g"] = 14,
        ["sublevel"] = 1,
      },
      [11] = {
        ["x"] = 270.83426014148,
        ["y"] = -104.90954890378,
        ["g"] = 14,
        ["sublevel"] = 1,
      },
      [12] = {
        ["x"] = 270.15891773789,
        ["y"] = -119.7751017067,
        ["g"] = 14,
        ["sublevel"] = 1,
      },
    },
  },
  [5] = {
    ["name"] = "Royal Wicklighter",
    ["id"] = 210812,
    ["count"] = 6,
    ["health"] = 25750712,
    ["scale"] = 1.5,
    ["displayId"] = 114709,
    ["creatureType"] = "Humanoid",
    ["level"] = 80,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Silence"] = true,
      ["Fear"] = true,
      ["Stun"] = true,
    },
    ["spells"] = {
      [423479] = {
        ["interruptible"] = true,
      },
      [428019] = {
        ["interruptible"] = true,
        ["magic"] = true,
      },
    },
    ["clones"] = {
      [2] = {
        ["x"] = 194.56163004213,
        ["y"] = -274.84704228369,
        ["g"] = 6,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 208.98872623263,
        ["y"] = -274.80162914544,
        ["g"] = 6,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 172.87026192623,
        ["y"] = -207.13999997236,
        ["g"] = 10,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 210.35431464521,
        ["y"] = -204.4531912368,
        ["g"] = 12,
        ["sublevel"] = 1,
      },
      [6] = {
        ["x"] = 307.04652363542,
        ["y"] = -150.66033177099,
        ["g"] = 21,
        ["sublevel"] = 1,
      },
    },
  },
  [6] = {
    ["name"] = "Kobold Taskworker",
    ["id"] = 212383,
    ["count"] = 4,
    ["health"] = 28611901,
    ["scale"] = 1.5,
    ["displayId"] = 114757,
    ["creatureType"] = "Humanoid",
    ["level"] = 80,
    ["characteristics"] = {
      ["Stun"] = true,
    },
    ["spells"] = {
      [426883] = {
      },
    },
    ["clones"] = {
      [2] = {
        ["x"] = 321.78180841067,
        ["y"] = -72.583003497847,
        ["g"] = 16,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 306.96728859064,
        ["y"] = -73.090414410364,
        ["g"] = 16,
        ["sublevel"] = 1,
      },
      [6] = {
        ["x"] = 397.30255307439,
        ["y"] = -141.34681788162,
        ["g"] = 19,
        ["sublevel"] = 1,
      },
      [7] = {
        ["x"] = 383.81586954449,
        ["y"] = -141.14710217441,
        ["g"] = 19,
        ["sublevel"] = 1,
      },
      [8] = {
        ["x"] = 383.38613334931,
        ["y"] = -155.37326843589,
        ["g"] = 19,
        ["sublevel"] = 1,
      },
      [9] = {
        ["x"] = 344.62344002615,
        ["y"] = -104.46999549228,
        ["g"] = 18,
        ["sublevel"] = 1,
      },
      [10] = {
        ["x"] = 344.80639040364,
        ["y"] = -118.97853629378,
        ["g"] = 18,
        ["sublevel"] = 1,
      },
      [11] = {
        ["x"] = 358.38372135853,
        ["y"] = -119.26963099934,
        ["g"] = 18,
        ["sublevel"] = 1,
      },
      [12] = {
        ["x"] = 315.67615314408,
        ["y"] = -113.44737939444,
        ["g"] = 15,
        ["sublevel"] = 1,
      },
    },
  },
  [7] = {
    ["name"] = "Blazing Fiend",
    ["id"] = 220815,
    ["count"] = 7,
    ["health"] = 22889521,
    ["scale"] = 1.5,
    ["displayId"] = 118916,
    ["creatureType"] = "Elemental",
    ["level"] = 80,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Silence"] = true,
      ["Stun"] = true,
    },
    ["spells"] = {
      [424322] = {
        ["interruptible"] = true,
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 313.1239855231,
        ["y"] = -138.00026366604,
        ["g"] = 21,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 314.42471647282,
        ["y"] = -85.767435867036,
        ["g"] = 16,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 321.09797760083,
        ["y"] = -150.35488989808,
        ["g"] = 21,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 397.14762749588,
        ["y"] = -155.67372218253,
        ["g"] = 19,
        ["sublevel"] = 1,
      },
      [6] = {
        ["x"] = 301.86285663252,
        ["y"] = -113.90207617676,
        ["g"] = 15,
        ["sublevel"] = 1,
      },
    },
  },
  [8] = {
    ["name"] = "Wandering Candle",
    ["id"] = 208450,
    ["count"] = 15,
    ["health"] = 45779042,
    ["scale"] = 1.7,
    ["displayId"] = 114467,
    ["creatureType"] = "Elemental",
    ["level"] = 80,
    ["spells"] = {
      [430171] = {
      },
      [440652] = {
      },
      [440653] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 341.2513804276,
        ["y"] = -149.37888562116,
        ["g"] = 20,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 358.31170389152,
        ["y"] = -104.30520948945,
        ["g"] = 18,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 367.0650415262,
        ["y"] = -83.169610633201,
        ["g"] = 17,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 350.04534095035,
        ["y"] = -229.29361090496,
        ["g"] = 22,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 356.91468487711,
        ["y"] = -148.99518188417,
        ["g"] = 20,
        ["sublevel"] = 1,
      },
    },
  },
  [9] = {
    ["name"] = "Kobold Flametender",
    ["id"] = 213913,
    ["count"] = 1,
    ["health"] = 5722380,
    ["scale"] = 1.2,
    ["displayId"] = 118173,
    ["creatureType"] = "Humanoid",
    ["level"] = 80,
    ["characteristics"] = {
      ["Silence"] = true,
      ["Fear"] = true,
      ["Stun"] = true,
    },
    ["spells"] = {
      [428563] = {
        ["interruptible"] = true,
      },
    },
    ["clones"] = {
      [2] = {
        ["x"] = 334.16917333389,
        ["y"] = -315.5547388441,
        ["g"] = 23,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 334.00241123105,
        ["y"] = -327.08648588353,
        ["g"] = 23,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 334.53170787471,
        ["y"] = -338.65369264769,
        ["g"] = 23,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 334.41295167154,
        ["y"] = -351.02954211105,
        ["g"] = 23,
        ["sublevel"] = 1,
      },
      [6] = {
        ["x"] = 365.69510093962,
        ["y"] = -315.54850674198,
        ["g"] = 23,
        ["sublevel"] = 1,
      },
      [7] = {
        ["x"] = 365.97444699516,
        ["y"] = -327.16356847558,
        ["g"] = 23,
        ["sublevel"] = 1,
      },
      [8] = {
        ["x"] = 365.52847935801,
        ["y"] = -339.37895299435,
        ["g"] = 23,
        ["sublevel"] = 1,
      },
      [9] = {
        ["x"] = 366.25986641585,
        ["y"] = -351.14834125127,
        ["g"] = 23,
        ["sublevel"] = 1,
      },
      [10] = {
        ["x"] = 350.72875689655,
        ["y"] = -332.6032084369,
        ["g"] = 23,
        ["sublevel"] = 1,
      },
      [11] = {
        ["x"] = 344.51109887188,
        ["y"] = -362.93013516189,
        ["g"] = 23,
        ["sublevel"] = 1,
      },
      [12] = {
        ["x"] = 355.18020982138,
        ["y"] = -363.00727109997,
        ["g"] = 23,
        ["sublevel"] = 1,
      },
      [13] = {
        ["x"] = 365.90361613873,
        ["y"] = -407.33018192815,
        ["g"] = 24,
        ["sublevel"] = 1,
      },
      [14] = {
        ["x"] = 372.29055101441,
        ["y"] = -416.16768966516,
        ["g"] = 24,
        ["sublevel"] = 1,
      },
      [15] = {
        ["x"] = 373.38455068043,
        ["y"] = -426.95561536836,
        ["g"] = 24,
        ["sublevel"] = 1,
      },
      [16] = {
        ["x"] = 365.45758604771,
        ["y"] = -433.8425802314,
        ["g"] = 24,
        ["sublevel"] = 1,
      },
    },
  },
  [10] = {
    ["name"] = "Sootsnout",
    ["id"] = 212412,
    ["count"] = 15,
    ["health"] = 85835704,
    ["scale"] = 1.5,
    ["displayId"] = 114736,
    ["creatureType"] = "Humanoid",
    ["level"] = 80,
    ["spells"] = {
      [426261] = {
      },
      [426265] = {
      },
      [426295] = {
        ["interruptible"] = true,
        ["magic"] = true,
      },
      [426677] = {
      },
      [1218131] = {
      },
      [1218133] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 358.91836838439,
        ["y"] = -420.26223705558,
        ["g"] = 24,
        ["sublevel"] = 1,
      },
    },
  },
  [11] = {
    ["name"] = "Torchsnarl",
    ["id"] = 212411,
    ["count"] = 15,
    ["health"] = 85835704,
    ["scale"] = 2,
    ["displayId"] = 114705,
    ["creatureType"] = "Humanoid",
    ["level"] = 80,
    ["spells"] = {
      [426259] = {
      },
      [426260] = {
      },
      [426275] = {
      },
      [426277] = {
      },
      [426619] = {
      },
      [1218117] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 341.19512170397,
        ["y"] = -420.30391001614,
        ["g"] = 24,
        ["sublevel"] = 1,
      },
    },
  },
  [12] = {
    ["name"] = "Skittering Darkness",
    ["id"] = 208457,
    ["count"] = 1,
    ["health"] = 5722380,
    ["scale"] = 0.8,
    ["displayId"] = 92318,
    ["creatureType"] = "Aberration",
    ["level"] = 80,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Disorient"] = true,
      ["Stun"] = true,
    },
    ["spells"] = {
      [422393] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 522.26429079835,
        ["y"] = -426.00469095254,
        ["g"] = 28,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 430.35769775727,
        ["y"] = -408.12460751985,
        ["g"] = 25,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 430.62513820349,
        ["y"] = -415.6028837633,
        ["g"] = 25,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 430.86207306556,
        ["y"] = -422.93254396229,
        ["g"] = 25,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 431.3746165892,
        ["y"] = -430.64033024017,
        ["g"] = 25,
        ["sublevel"] = 1,
      },
      [6] = {
        ["x"] = 437.64258779945,
        ["y"] = -408.39023993552,
        ["g"] = 25,
        ["sublevel"] = 1,
      },
      [7] = {
        ["x"] = 438.31370908131,
        ["y"] = -415.66886579477,
        ["g"] = 25,
        ["sublevel"] = 1,
      },
      [8] = {
        ["x"] = 438.089162677,
        ["y"] = -422.42808922893,
        ["g"] = 25,
        ["sublevel"] = 1,
      },
      [9] = {
        ["x"] = 438.49284351264,
        ["y"] = -430.15828052027,
        ["g"] = 25,
        ["sublevel"] = 1,
      },
      [10] = {
        ["x"] = 483.01119843879,
        ["y"] = -411.62873771057,
        ["g"] = 26,
        ["sublevel"] = 1,
      },
      [11] = {
        ["x"] = 487.40258163467,
        ["y"] = -419.56031023503,
        ["g"] = 26,
        ["sublevel"] = 1,
      },
      [12] = {
        ["x"] = 483.93668568676,
        ["y"] = -428.93372590743,
        ["g"] = 26,
        ["sublevel"] = 1,
      },
      [13] = {
        ["x"] = 529.28684085065,
        ["y"] = -401.95981256356,
        ["g"] = 27,
        ["sublevel"] = 1,
      },
      [14] = {
        ["x"] = 520.69718743649,
        ["y"] = -383.39548981064,
        ["g"] = 27,
        ["sublevel"] = 1,
      },
      [15] = {
        ["x"] = 532.91742705416,
        ["y"] = -391.58017324986,
        ["g"] = 27,
        ["sublevel"] = 1,
      },
      [16] = {
        ["x"] = 516.17612082837,
        ["y"] = -432.30112765493,
        ["g"] = 28,
        ["sublevel"] = 1,
      },
      [17] = {
        ["x"] = 516.59806315983,
        ["y"] = -410.66705334805,
        ["g"] = 28,
        ["sublevel"] = 1,
      },
      [18] = {
        ["x"] = 521.62674498051,
        ["y"] = -417.93538221422,
        ["g"] = 28,
        ["sublevel"] = 1,
      },
      [19] = {
        ["x"] = 546.60547384693,
        ["y"] = -446.03554576664,
        ["g"] = 29,
        ["sublevel"] = 1,
      },
      [20] = {
        ["x"] = 552.51059151563,
        ["y"] = -459.08558889864,
        ["g"] = 29,
        ["sublevel"] = 1,
      },
      [21] = {
        ["x"] = 555.80520725337,
        ["y"] = -436.68462392525,
        ["g"] = 29,
        ["sublevel"] = 1,
      },
      [22] = {
        ["x"] = 571.56240492218,
        ["y"] = -409.72532712858,
        ["g"] = 30,
        ["sublevel"] = 1,
      },
      [23] = {
        ["x"] = 567.20176338824,
        ["y"] = -419.52502472547,
        ["g"] = 30,
        ["sublevel"] = 1,
      },
      [24] = {
        ["x"] = 571.55253370677,
        ["y"] = -429.04231707263,
        ["g"] = 30,
        ["sublevel"] = 1,
      },
      [25] = {
        ["x"] = 606.55096719811,
        ["y"] = -404.89644972165,
        ["g"] = 31,
        ["sublevel"] = 1,
      },
      [26] = {
        ["x"] = 606.65172193942,
        ["y"] = -414.60528832809,
        ["g"] = 31,
        ["sublevel"] = 1,
      },
      [27] = {
        ["x"] = 606.65172193942,
        ["y"] = -424.4702703052,
        ["g"] = 31,
        ["sublevel"] = 1,
      },
      [28] = {
        ["x"] = 607.18099256063,
        ["y"] = -433.65977288909,
        ["g"] = 31,
        ["sublevel"] = 1,
      },
      [29] = {
        ["x"] = 598.13763332085,
        ["y"] = -433.78606441514,
        ["g"] = 31,
        ["sublevel"] = 1,
      },
      [30] = {
        ["x"] = 597.84526075853,
        ["y"] = -424.26875980025,
        ["g"] = 31,
        ["sublevel"] = 1,
      },
      [31] = {
        ["x"] = 597.84526075853,
        ["y"] = -414.89759546253,
        ["g"] = 31,
        ["sublevel"] = 1,
      },
      [32] = {
        ["x"] = 597.50764885076,
        ["y"] = -405.03267686869,
        ["g"] = 31,
        ["sublevel"] = 1,
      },
      [33] = {
        ["x"] = 649.3326437763,
        ["y"] = -410.09855661018,
        ["g"] = 32,
        ["sublevel"] = 1,
      },
      [34] = {
        ["x"] = 644.2058172053,
        ["y"] = -419.75203214504,
        ["g"] = 32,
        ["sublevel"] = 1,
      },
      [35] = {
        ["x"] = 649.14106275848,
        ["y"] = -430.5847822482,
        ["g"] = 32,
        ["sublevel"] = 1,
      },
      [36] = {
        ["x"] = 229.52954086188,
        ["y"] = -141.96033408463,
        ["g"] = 38,
        ["sublevel"] = 1,
      },
      [37] = {
        ["x"] = 242.30346232303,
        ["y"] = -168.74210220296,
        ["g"] = 39,
        ["sublevel"] = 1,
      },
      [38] = {
        ["x"] = 230.87032463706,
        ["y"] = -168.88370152802,
        ["g"] = 39,
        ["sublevel"] = 1,
      },
      [39] = {
        ["x"] = 229.4594410416,
        ["y"] = -152.29884013314,
        ["g"] = 38,
        ["sublevel"] = 1,
      },
      [40] = {
        ["x"] = 219.61457052009,
        ["y"] = -168.7427491561,
        ["g"] = 38,
        ["sublevel"] = 1,
      },
      [41] = {
        ["x"] = 212.52124389289,
        ["y"] = -161.66646231559,
        ["g"] = 38,
        ["sublevel"] = 1,
      },
      [42] = {
        ["x"] = 203.59458772249,
        ["y"] = -136.70186058792,
        ["g"] = 37,
        ["sublevel"] = 1,
      },
      [43] = {
        ["x"] = 217.17976891621,
        ["y"] = -137.26704985598,
        ["g"] = 38,
        ["sublevel"] = 1,
      },
      [44] = {
        ["x"] = 216.79178996241,
        ["y"] = -123.99949588095,
        ["g"] = 38,
        ["sublevel"] = 1,
      },
      [45] = {
        ["x"] = 159.4139641974,
        ["y"] = -122.23473958387,
        ["g"] = 36,
        ["sublevel"] = 1,
      },
      [46] = {
        ["x"] = 175.7188088793,
        ["y"] = -137.30243645539,
        ["g"] = 36,
        ["sublevel"] = 1,
      },
      [47] = {
        ["x"] = 175.93044625556,
        ["y"] = -122.2706145404,
        ["g"] = 36,
        ["sublevel"] = 1,
      },
      [48] = {
        ["x"] = 189.974668367,
        ["y"] = -122.79957599738,
        ["g"] = 37,
        ["sublevel"] = 1,
      },
      [49] = {
        ["x"] = 175.50747614758,
        ["y"] = -100.25121710423,
        ["g"] = 35,
        ["sublevel"] = 1,
      },
      [50] = {
        ["x"] = 159.73415653137,
        ["y"] = -100.39283601463,
        ["g"] = 35,
        ["sublevel"] = 1,
      },
      [51] = {
        ["x"] = 175.57782788268,
        ["y"] = -86.172303963474,
        ["g"] = 35,
        ["sublevel"] = 1,
      },
      [52] = {
        ["x"] = 201.47770098067,
        ["y"] = -85.043383867814,
        ["g"] = 34,
        ["sublevel"] = 1,
      },
      [53] = {
        ["x"] = 202.35964873071,
        ["y"] = -100.1108288245,
        ["g"] = 34,
        ["sublevel"] = 1,
      },
      [54] = {
        ["x"] = 216.79188143377,
        ["y"] = -99.758103485648,
        ["g"] = 34,
        ["sublevel"] = 1,
      },
    },
  },
  [13] = {
    ["name"] = "Shuffling Horror",
    ["id"] = 208456,
    ["count"] = 3,
    ["health"] = 28611901,
    ["scale"] = 1.6,
    ["displayId"] = 92318,
    ["creatureType"] = "Aberration",
    ["level"] = 80,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Stun"] = true,
    },
    ["spells"] = {
      [422541] = {
        ["interruptible"] = true,
      },
      [422692] = {
        ["interruptible"] = true,
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 558.64934956054,
        ["y"] = -448.38120640507,
        ["g"] = 29,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 476.73862388604,
        ["y"] = -420.44738584714,
        ["g"] = 26,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 522.28308196772,
        ["y"] = -393.88209204713,
        ["g"] = 27,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 578.58939961527,
        ["y"] = -419.42426793953,
        ["g"] = 30,
        ["sublevel"] = 1,
      },
      [6] = {
        ["x"] = 656.59651199282,
        ["y"] = -420.51828976615,
        ["g"] = 32,
        ["sublevel"] = 1,
      },
    },
  },
  [14] = {
    ["name"] = "Corridor Creeper",
    ["id"] = 210539,
    ["count"] = 7,
    ["health"] = 42917853,
    ["scale"] = 1.7,
    ["displayId"] = 92709,
    ["creatureType"] = "Beast",
    ["level"] = 80,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [422628] = {
      },
      [469620] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 511.24785262857,
        ["y"] = -421.51707995104,
        ["g"] = 28,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 618.04913124005,
        ["y"] = -410.62783132063,
        ["g"] = 31,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 618.34143019602,
        ["y"] = -428.94153779587,
        ["g"] = 31,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 228.18917353571,
        ["y"] = -129.99739482966,
        ["g"] = 38,
        ["sublevel"] = 1,
      },
      [6] = {
        ["x"] = 216.72110194495,
        ["y"] = -150.39363639345,
        ["g"] = 38,
        ["sublevel"] = 1,
      },
      [7] = {
        ["x"] = 204.15946782633,
        ["y"] = -123.08192207608,
        ["g"] = 37,
        ["sublevel"] = 1,
      },
      [8] = {
        ["x"] = 160.05144596115,
        ["y"] = -85.008021780322,
        ["g"] = 35,
        ["sublevel"] = 1,
      },
      [9] = {
        ["x"] = 215.80382331625,
        ["y"] = -83.03251451555,
        ["g"] = 34,
        ["sublevel"] = 1,
      },
      [10] = {
        ["x"] = 234.11257281553,
        ["y"] = -65.779454362596,
        ["sublevel"] = 1,
      },
      [11] = {
        ["x"] = 142.59250697661,
        ["y"] = -64.631678911728,
        ["sublevel"] = 1,
      },
      [12] = {
        ["x"] = 144.78856969423,
        ["y"] = -163.45436838394,
        ["sublevel"] = 1,
      },
    },
  },
  [15] = {
    ["name"] = "Blazing Fiend",
    ["id"] = 211228,
    ["count"] = 7,
    ["health"] = 22889521,
    ["scale"] = 1.5,
    ["displayId"] = 118916,
    ["creatureType"] = "Elemental",
    ["level"] = 80,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Silence"] = true,
    },
    ["spells"] = {
      [424322] = {
        ["interruptible"] = true,
      },
    },
    ["clones"] = {
      [2] = {
        ["x"] = 329.08999036529,
        ["y"] = -236.51362375044,
        ["g"] = 22,
        ["sublevel"] = 1,
      },
    },
  },
  [16] = {
    ["name"] = "Blazing Fiend",
    ["id"] = 223770,
    ["count"] = 7,
    ["health"] = 22889521,
    ["scale"] = 1.5,
    ["displayId"] = 118916,
    ["creatureType"] = "Elemental",
    ["level"] = 80,
    ["characteristics"] = {
      ["Silence"] = true,
      ["Fear"] = true,
    },
    ["spells"] = {
      [424322] = {
        ["interruptible"] = true,
      },
    },
    ["clones"] = {
      [2] = {
        ["x"] = 370.3419514256,
        ["y"] = -222.99352152755,
        ["g"] = 22,
        ["sublevel"] = 1,
      },
    },
  },
  [17] = {
    ["name"] = "Blazing Fiend",
    ["id"] = 223772,
    ["count"] = 7,
    ["health"] = 22889521,
    ["scale"] = 1.5,
    ["displayId"] = 118916,
    ["creatureType"] = "Elemental",
    ["level"] = 80,
    ["characteristics"] = {
      ["Silence"] = true,
      ["Fear"] = true,
    },
    ["spells"] = {
      [424322] = {
        ["interruptible"] = true,
      },
    },
    ["clones"] = {
      [2] = {
        ["x"] = 329.62205548986,
        ["y"] = -208.30606194704,
        ["g"] = 22,
        ["sublevel"] = 1,
      },
    },
  },
  [18] = {
    ["name"] = "Blazing Fiend",
    ["id"] = 223773,
    ["count"] = 7,
    ["health"] = 22889521,
    ["scale"] = 1.5,
    ["displayId"] = 118916,
    ["creatureType"] = "Elemental",
    ["level"] = 80,
    ["spells"] = {
      [424322] = {
        ["interruptible"] = true,
      },
    },
    ["clones"] = {
      [2] = {
        ["x"] = 329.64576377637,
        ["y"] = -222.87460343229,
        ["g"] = 22,
        ["sublevel"] = 1,
      },
    },
  },
  [19] = {
    ["name"] = "Blazing Fiend",
    ["id"] = 223774,
    ["count"] = 7,
    ["health"] = 22889521,
    ["scale"] = 1.5,
    ["displayId"] = 118916,
    ["creatureType"] = "Elemental",
    ["level"] = 80,
    ["characteristics"] = {
      ["Silence"] = true,
      ["Fear"] = true,
    },
    ["spells"] = {
      [424322] = {
        ["interruptible"] = true,
      },
    },
    ["clones"] = {
      [2] = {
        ["x"] = 328.80700364604,
        ["y"] = -250.13042418981,
        ["g"] = 22,
        ["sublevel"] = 1,
      },
    },
  },
  [20] = {
    ["name"] = "Blazing Fiend",
    ["id"] = 223775,
    ["count"] = 7,
    ["health"] = 22889521,
    ["scale"] = 1.5,
    ["displayId"] = 118916,
    ["creatureType"] = "Elemental",
    ["level"] = 80,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [424322] = {
        ["interruptible"] = true,
      },
    },
    ["clones"] = {
      [2] = {
        ["x"] = 369.98156060682,
        ["y"] = -237.550111186,
        ["g"] = 22,
        ["sublevel"] = 1,
      },
    },
  },
  [21] = {
    ["name"] = "Blazing Fiend",
    ["id"] = 223776,
    ["count"] = 7,
    ["health"] = 22889521,
    ["scale"] = 1.5,
    ["displayId"] = 118916,
    ["creatureType"] = "Elemental",
    ["level"] = 80,
    ["characteristics"] = {
      ["Silence"] = true,
      ["Fear"] = true,
    },
    ["spells"] = {
      [424322] = {
        ["interruptible"] = true,
      },
    },
    ["clones"] = {
      [2] = {
        ["x"] = 369.95066764928,
        ["y"] = -251.28955624243,
        ["g"] = 22,
        ["sublevel"] = 1,
      },
    },
  },
  [22] = {
    ["name"] = "Blazing Fiend",
    ["id"] = 223777,
    ["count"] = 7,
    ["health"] = 22889521,
    ["scale"] = 1.5,
    ["displayId"] = 118916,
    ["creatureType"] = "Elemental",
    ["level"] = 80,
    ["characteristics"] = {
      ["Silence"] = true,
      ["Fear"] = true,
    },
    ["spells"] = {
      [424322] = {
        ["interruptible"] = true,
      },
    },
    ["clones"] = {
      [2] = {
        ["x"] = 370.01787061146,
        ["y"] = -208.68771677253,
        ["g"] = 22,
        ["sublevel"] = 1,
      },
    },
  },
  [23] = {
    ["name"] = "Ol' Waxbeard",
    ["id"] = 210153,
    ["count"] = 0,
    ["health"] = 142958477,
    ["scale"] = 2,
    ["displayId"] = 114171,
    ["creatureType"] = "Humanoid",
    ["level"] = 82,
    ["isBoss"] = true,
    ["encounterID"] = 2569,
    ["instanceID"] = 1210,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [422122] = {
      },
      [422125] = {
      },
      [422245] = {
      },
      [422246] = {
      },
      [422274] = {
      },
      [423693] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 123.07777580868,
        ["y"] = -113.87364292063,
        ["sublevel"] = 1,
      },
    },
  },
  [24] = {
    ["name"] = "Blazikon",
    ["id"] = 208743,
    ["count"] = 0,
    ["health"] = 200141868,
    ["scale"] = 2,
    ["displayId"] = 115888,
    ["creatureType"] = "Elemental",
    ["level"] = 82,
    ["isBoss"] = true,
    ["encounterID"] = 2569,
    ["instanceID"] = 1210,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [421638] = {
      },
      [421817] = {
      },
      [421910] = {
      },
      [422700] = {
      },
      [423109] = {
      },
      [424212] = {
      },
      [424223] = {
      },
      [425394] = {
      },
      [443835] = {
      },
      [1218308] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 352.20470858222,
        ["y"] = -275.47338923516,
        ["sublevel"] = 1,
      },
    },
  },
  [25] = {
    ["name"] = "The Candle King",
    ["id"] = 208745,
    ["count"] = 0,
    ["health"] = 200141868,
    ["scale"] = 2,
    ["displayId"] = 114508,
    ["creatureType"] = "Humanoid",
    ["level"] = 82,
    ["isBoss"] = true,
    ["encounterID"] = 2569,
    ["instanceID"] = 1210,
    ["spells"] = {
      [420659] = {
      },
      [421146] = {
      },
      [421277] = {
      },
      [422648] = {
      },
      [426127] = {
      },
      [426145] = {
        ["magic"] = true,
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 351.51971397785,
        ["y"] = -485.62906785342,
        ["sublevel"] = 1,
      },
    },
  },
  [26] = {
    ["name"] = "The Darkness",
    ["id"] = 208747,
    ["count"] = 0,
    ["health"] = 643313148,
    ["scale"] = 2,
    ["displayId"] = 117773,
    ["creatureType"] = "Humanoid",
    ["level"] = 82,
    ["isBoss"] = true,
    ["encounterID"] = 2569,
    ["instanceID"] = 1210,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [424074] = {
      },
      [426943] = {
      },
      [427011] = {
      },
      [427015] = {
      },
      [427025] = {
      },
      [427100] = {
      },
      [427157] = {
        ["interruptible"] = true,
      },
      [427180] = {
      },
      [428266] = {
      },
      [428276] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 718.48655523821,
        ["y"] = -417.47078593602,
        ["sublevel"] = 1,
      },
    },
  },
};
