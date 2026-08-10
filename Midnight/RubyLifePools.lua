local _, MDT = ...
local addonName = MDT.AddonName
local L = MDT.L
local dungeonIndex = 42
MDT.dungeonList[dungeonIndex] = L["RubyLifePools"]
MDT.mapInfo[dungeonIndex] = {
  teleportId = 393256,
  shortName = L["rubyLifePoolsShortName"],
  englishName = "Ruby Life Pools",
  mapID = 399
};

local zones = { 2094, 2095 }
for _, zone in ipairs(zones) do
  MDT.zoneIdToDungeonIdx[zone] = dungeonIndex
end

MDT.dungeonMaps[dungeonIndex] = {
  [0] = "",
  [1] = { customTextures = 'Interface\\AddOns\\'..addonName..'\\Midnight\\Textures\\RubyLifePools' }
}

MDT.dungeonSubLevels[dungeonIndex] = {
  [1] = L["RubyLifePools"],
}

MDT.mapPOIs[dungeonIndex] = {};

MDT.dungeonTotalCount[dungeonIndex] = { normal = 553 }

MDT.dungeonEnemies[dungeonIndex] = {
  [1] = {
    ["name"] = "Primal Juggernaut",
    ["id"] = 188244,
    ["count"] = 25,
    ["health"] = 6486510,
    ["scale"] = 1,
    ["displayId"] = 101209,
    ["creatureType"] = "Elemental",
    ["level"] = 91,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [372730] = {
      },
      [372793] = {
      },
      [1305201] = {
      },
      [1305213] = {
      },
      [1310489] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 100.79132617688,
        ["y"] = -462.73351929648,
        ["g"] = 32,
        ["sublevel"] = 1,
        ["scale"] = 2.2,
      },
      [2] = {
        ["x"] = 138.12731769362,
        ["y"] = -186.350008352,
        ["sublevel"] = 1,
        ["scale"] = 2.2,
      },
    },
  },
  [2] = {
    ["name"] = "Deepstone Earthshaper",
    ["id"] = 187969,
    ["count"] = 5,
    ["health"] = 3891906,
    ["scale"] = 1,
    ["displayId"] = 102955,
    ["creatureType"] = "Humanoid",
    ["level"] = 90,
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
      [371471] = {
      },
      [1305225] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 130.89323000235,
        ["y"] = -374.35184176998,
        ["g"] = 1,
        ["sublevel"] = 1,
        ["scale"] = 1.6,
      },
      [2] = {
        ["x"] = 104.38231928109,
        ["y"] = -347.52499728206,
        ["g"] = 2,
        ["sublevel"] = 1,
        ["scale"] = 1.6,
      },
      [3] = {
        ["x"] = 117.1760062445,
        ["y"] = -338.64942594525,
        ["g"] = 2,
        ["sublevel"] = 1,
        ["scale"] = 1.6,
      },
      [4] = {
        ["x"] = 62.783058870974,
        ["y"] = -269.66707697627,
        ["g"] = 6,
        ["sublevel"] = 1,
        ["scale"] = 1.6,
      },
      [6] = {
        ["x"] = 124.27185743883,
        ["y"] = -144.35210690933,
        ["g"] = 12,
        ["sublevel"] = 1,
        ["scale"] = 1.6,
      },
      [7] = {
        ["x"] = 149.72914789458,
        ["y"] = -128.70695898934,
        ["g"] = 34,
        ["sublevel"] = 1,
        ["scale"] = 1.6,
      },
      [8] = {
        ["x"] = 200.61475916268,
        ["y"] = -132.62121883682,
        ["g"] = 33,
        ["sublevel"] = 1,
        ["scale"] = 1.6,
      },
      [9] = {
        ["x"] = 93.208822113861,
        ["y"] = -478.07466830498,
        ["g"] = 32,
        ["sublevel"] = 1,
        ["scale"] = 1.6,
      },
    },
  },
  [3] = {
    ["name"] = "Earthbound Guardian",
    ["id"] = 188011,
    ["count"] = 5,
    ["health"] = 3567581,
    ["scale"] = 1,
    ["displayId"] = 79800,
    ["creatureType"] = "Elemental",
    ["level"] = 90,
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
      [384933] = {
        ["interruptible"] = true,
      },
      [1307205] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 139.44271912845,
        ["y"] = -365.53792645157,
        ["g"] = 1,
        ["sublevel"] = 1,
        ["scale"] = 1.6,
      },
      [2] = {
        ["x"] = 80.39931527567,
        ["y"] = -303.05422821141,
        ["g"] = 3,
        ["sublevel"] = 1,
        ["scale"] = 1.6,
      },
      [3] = {
        ["x"] = 71.515154500318,
        ["y"] = -293.50582363109,
        ["g"] = 3,
        ["sublevel"] = 1,
        ["scale"] = 1.6,
      },
      [4] = {
        ["x"] = 47.661843299819,
        ["y"] = -262.86828441536,
        ["g"] = 6,
        ["sublevel"] = 1,
        ["scale"] = 1.6,
      },
      [5] = {
        ["x"] = 114.07641623045,
        ["y"] = -258.90898565986,
        ["g"] = 7,
        ["sublevel"] = 1,
        ["scale"] = 1.6,
      },
      [6] = {
        ["x"] = 114.49007344707,
        ["y"] = -270.73144468269,
        ["g"] = 7,
        ["sublevel"] = 1,
        ["scale"] = 1.6,
      },
      [7] = {
        ["x"] = 117.3129381105,
        ["y"] = -150.61896646271,
        ["g"] = 12,
        ["sublevel"] = 1,
        ["scale"] = 1.6,
      },
      [8] = {
        ["x"] = 110.04022186769,
        ["y"] = -477.70766968788,
        ["g"] = 32,
        ["sublevel"] = 1,
        ["scale"] = 1.6,
      },
      [9] = {
        ["x"] = 159.51479751329,
        ["y"] = -122.10158070481,
        ["g"] = 34,
        ["sublevel"] = 1,
        ["scale"] = 1.6,
      },
    },
  },
  [4] = {
    ["name"] = "Flashfrost Chillweaver",
    ["id"] = 188067,
    ["count"] = 7,
    ["health"] = 3243255,
    ["scale"] = 1,
    ["displayId"] = 107397,
    ["creatureType"] = "Humanoid",
    ["level"] = 90,
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
      [371489] = {
      },
      [371984] = {
        ["interruptible"] = true,
      },
      [372743] = {
        ["interruptible"] = true,
      },
      [372749] = {
      },
      [384933] = {
        ["interruptible"] = true,
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 102.57834453243,
        ["y"] = -333.7965356426,
        ["g"] = 2,
        ["sublevel"] = 1,
        ["scale"] = 1.6,
      },
      [3] = {
        ["x"] = 102.20083701671,
        ["y"] = -266.79033461032,
        ["g"] = 7,
        ["sublevel"] = 1,
        ["scale"] = 1.6,
      },
      [6] = {
        ["x"] = 113.05714948244,
        ["y"] = -197.48855992166,
        ["sublevel"] = 1,
        ["scale"] = 1.6,
      },
      [7] = {
        ["x"] = 131.9661541637,
        ["y"] = -209.428765984,
        ["sublevel"] = 1,
        ["scale"] = 1.6,
      },
      [8] = {
        ["x"] = 128.11860789449,
        ["y"] = -155.35617714507,
        ["g"] = 12,
        ["sublevel"] = 1,
        ["scale"] = 1.6,
      },
      [9] = {
        ["x"] = 186.76931599511,
        ["y"] = -129.08830703889,
        ["g"] = 33,
        ["sublevel"] = 1,
        ["scale"] = 1.6,
        ["patrol"] = {
        },
      },
    },
  },
  [5] = {
    ["name"] = "Infused Whelp",
    ["id"] = 187894,
    ["count"] = 0,
    ["health"] = 3243255,
    ["scale"] = 1,
    ["displayId"] = 110633,
    ["creatureType"] = "Dragonkin",
    ["level"] = 90,
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
      [1305234] = {
        ["magic"] = true,
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 59.718295925721,
        ["y"] = -219.10126451414,
        ["g"] = 8,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [2] = {
        ["x"] = 55.987737926404,
        ["y"] = -226.24433401264,
        ["g"] = 8,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [3] = {
        ["x"] = 63.805672597377,
        ["y"] = -224.97701362712,
        ["g"] = 8,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [4] = {
        ["x"] = 78.176784961501,
        ["y"] = -183.35392874762,
        ["g"] = 10,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [5] = {
        ["x"] = 83.823782739644,
        ["y"] = -176.59765636077,
        ["g"] = 10,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [6] = {
        ["x"] = 94.34576539072,
        ["y"] = -162.66339229346,
        ["g"] = 10,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [7] = {
        ["x"] = 79.944035762274,
        ["y"] = -195.79736252892,
        ["g"] = 10,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [8] = {
        ["x"] = 72.231468088836,
        ["y"] = -190.78461442393,
        ["g"] = 10,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [9] = {
        ["x"] = 101.13345467099,
        ["y"] = -168.00369232521,
        ["g"] = 10,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [10] = {
        ["x"] = 84.261964859269,
        ["y"] = -188.10562350567,
        ["g"] = 10,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [11] = {
        ["x"] = 98.155274171531,
        ["y"] = -183.02259913472,
        ["g"] = 10,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [12] = {
        ["x"] = 89.411940132042,
        ["y"] = -181.2844726764,
        ["g"] = 10,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [13] = {
        ["x"] = 87.918098365442,
        ["y"] = -195.1775249124,
        ["g"] = 10,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [14] = {
        ["x"] = 103.39081000556,
        ["y"] = -176.29307731302,
        ["g"] = 10,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [15] = {
        ["x"] = 94.609079644735,
        ["y"] = -174.39069007271,
        ["g"] = 10,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [16] = {
        ["x"] = 93.486061910135,
        ["y"] = -188.57226226234,
        ["g"] = 10,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [17] = {
        ["x"] = 142.61853245862,
        ["y"] = -230.22822093606,
        ["g"] = 11,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [18] = {
        ["x"] = 154.434547878,
        ["y"] = -210.96838518609,
        ["g"] = 11,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [19] = {
        ["x"] = 147.56978124642,
        ["y"] = -215.77955264718,
        ["g"] = 11,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [20] = {
        ["x"] = 149.27782590966,
        ["y"] = -225.07584415512,
        ["g"] = 11,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [21] = {
        ["x"] = 161.51702443786,
        ["y"] = -215.62896321769,
        ["g"] = 11,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [22] = {
        ["x"] = 141.69268435519,
        ["y"] = -221.20546638686,
        ["g"] = 11,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [23] = {
        ["x"] = 155.34009550814,
        ["y"] = -220.7828407325,
        ["g"] = 11,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [24] = {
        ["x"] = 116.53412313626,
        ["y"] = -296.4327638409,
        ["g"] = 5,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [25] = {
        ["x"] = 124.76941460128,
        ["y"] = -298.36151826728,
        ["g"] = 5,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [26] = {
        ["x"] = 114.90261910104,
        ["y"] = -304.71906777223,
        ["g"] = 5,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [27] = {
        ["x"] = 122.85151189937,
        ["y"] = -307.19407514186,
        ["g"] = 5,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [28] = {
        ["x"] = 127.06468789074,
        ["y"] = -289.77350503556,
        ["g"] = 5,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [29] = {
        ["x"] = 119.09079228629,
        ["y"] = -287.98670330525,
        ["g"] = 5,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [30] = {
        ["x"] = 56.153662623618,
        ["y"] = -330.36462675374,
        ["g"] = 4,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [31] = {
        ["x"] = 32.928864602457,
        ["y"] = -329.72636265431,
        ["g"] = 4,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [32] = {
        ["x"] = 41.208794091033,
        ["y"] = -320.68142695237,
        ["g"] = 4,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [33] = {
        ["x"] = 41.192876941146,
        ["y"] = -330.30747850605,
        ["g"] = 4,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [34] = {
        ["x"] = 48.789655789782,
        ["y"] = -320.81397328637,
        ["g"] = 4,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [35] = {
        ["x"] = 32.989903107577,
        ["y"] = -320.68983572788,
        ["g"] = 4,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [36] = {
        ["x"] = 57.125731872088,
        ["y"] = -321.90428415745,
        ["g"] = 4,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [37] = {
        ["x"] = 49.865818798961,
        ["y"] = -312.68626323434,
        ["g"] = 4,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [38] = {
        ["x"] = 50.321276946436,
        ["y"] = -303.27287419464,
        ["g"] = 4,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [39] = {
        ["x"] = 41.912678981902,
        ["y"] = -302.63763341173,
        ["g"] = 4,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [40] = {
        ["x"] = 33.27110373081,
        ["y"] = -311.16583928494,
        ["g"] = 4,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [41] = {
        ["x"] = 34.00083183676,
        ["y"] = -301.87781024316,
        ["g"] = 4,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [42] = {
        ["x"] = 41.444371178233,
        ["y"] = -311.41012750986,
        ["g"] = 4,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [43] = {
        ["x"] = 48.729048807863,
        ["y"] = -329.83506730672,
        ["g"] = 4,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [44] = {
        ["x"] = 57.506732999628,
        ["y"] = -313.73872507646,
        ["g"] = 4,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [45] = {
        ["x"] = 58.411806454703,
        ["y"] = -304.55859826656,
        ["g"] = 4,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [46] = {
        ["x"] = 65.76133887677,
        ["y"] = -318.50829834913,
        ["g"] = 4,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [47] = {
        ["x"] = 88.981667881882,
        ["y"] = -169.19197352519,
        ["g"] = 10,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [48] = {
        ["x"] = 211.61128607119,
        ["y"] = -170.98055239148,
        ["g"] = 13,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [49] = {
        ["x"] = 208.26647775123,
        ["y"] = -162.52285033651,
        ["g"] = 13,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [50] = {
        ["x"] = 203.20468458218,
        ["y"] = -169.2576091519,
        ["g"] = 13,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [51] = {
        ["x"] = 53.095382891598,
        ["y"] = -233.17853227664,
        ["g"] = 8,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [52] = {
        ["x"] = 60.679287262854,
        ["y"] = -231.22136347777,
        ["g"] = 8,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
    },
  },
  [6] = {
    ["name"] = "Defier Draghar",
    ["id"] = 187897,
    ["count"] = 30,
    ["health"] = 9729765,
    ["scale"] = 1,
    ["stealthDetect"] = true,
    ["displayId"] = 107106,
    ["creatureType"] = "Dragonkin",
    ["level"] = 91,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Mind Soothe"] = true,
    },
    ["spells"] = {
      [372047] = {
      },
      [372087] = {
      },
      [372794] = {
      },
      [1309705] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 187.68156192431,
        ["y"] = -192.12062424592,
        ["sublevel"] = 1,
        ["scale"] = 2.2,
      },
    },
  },
  [7] = {
    ["name"] = "Melidrussa Chillworn",
    ["id"] = 188252,
    ["count"] = 0,
    ["health"] = 20270342,
    ["scale"] = 1,
    ["displayId"] = 106891,
    ["creatureType"] = "Humanoid",
    ["level"] = 92,
    ["isBoss"] = true,
    ["encounterID"] = 2488,
    ["instanceID"] = 1202,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Mind Soothe"] = true,
    },
    ["spells"] = {
      [372808] = {
        ["interruptible"] = true,
      },
      [372851] = {
      },
      [372988] = {
      },
      [373046] = {
      },
      [373680] = {
      },
      [373688] = {
      },
      [373727] = {
      },
      [383925] = {
      },
      [384024] = {
      },
      [396044] = {
      },
      [397077] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 281.25653994104,
        ["y"] = -290.54103286633,
        ["sublevel"] = 1,
        ["scale"] = 2,
      },
    },
  },
  [8] = {
    ["name"] = "Scorchling",
    ["id"] = 190205,
    ["count"] = 0,
    ["health"] = 648651,
    ["scale"] = 1,
    ["displayId"] = 102535,
    ["creatureType"] = "Elemental",
    ["level"] = 90,
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
      [1307372] = {
      },
    },
    ["clones"] = {
      [22] = {
        ["x"] = 525.25198839473,
        ["y"] = -207.8374369853,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
    },
  },
  [9] = {
    ["name"] = "Thunderhead",
    ["id"] = 197698,
    ["count"] = 48,
    ["health"] = 8432463,
    ["scale"] = 1,
    ["displayId"] = 106435,
    ["creatureType"] = "Dragonkin",
    ["level"] = 91,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Mind Soothe"] = true,
    },
    ["spells"] = {
      [391726] = {
      },
      [391727] = {
      },
      [392395] = {
      },
      [392640] = {
      },
      [392641] = {
        ["magic"] = true,
      },
      [395303] = {
      },
      [1310599] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 479.31483155353,
        ["y"] = -312.22150758466,
        ["sublevel"] = 1,
        ["scale"] = 2.5,
      },
    },
  },
  [10] = {
    ["name"] = "Primalist Cinderweaver",
    ["id"] = 190207,
    ["count"] = 7,
    ["health"] = 2918930,
    ["scale"] = 1,
    ["displayId"] = 102886,
    ["creatureType"] = "Humanoid",
    ["level"] = 90,
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
      [373693] = {
      },
      [384194] = {
        ["interruptible"] = true,
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 732.67175304531,
        ["y"] = -275.40754495017,
        ["g"] = 17,
        ["sublevel"] = 1,
        ["scale"] = 1.3,
      },
      [2] = {
        ["x"] = 787.9229977042,
        ["y"] = -383.23631826682,
        ["g"] = 38,
        ["sublevel"] = 1,
        ["scale"] = 1.3,
      },
      [3] = {
        ["x"] = 498.22350206768,
        ["y"] = -423.35927878552,
        ["g"] = 15,
        ["sublevel"] = 1,
        ["scale"] = 1.3,
      },
      [4] = {
        ["x"] = 578.21035783222,
        ["y"] = -470.51856834355,
        ["g"] = 16,
        ["sublevel"] = 1,
        ["scale"] = 1.3,
      },
      [5] = {
        ["x"] = 658.01904989903,
        ["y"] = -502.29802506958,
        ["g"] = 39,
        ["sublevel"] = 1,
        ["scale"] = 1.3,
      },
      [6] = {
        ["x"] = 473.48521589194,
        ["y"] = -382.37434405068,
        ["g"] = 14,
        ["sublevel"] = 1,
        ["scale"] = 1.3,
      },
      [7] = {
        ["x"] = 570.15794409968,
        ["y"] = -229.05837815916,
        ["g"] = 20,
        ["sublevel"] = 1,
        ["scale"] = 1.3,
      },
      [9] = {
        ["x"] = 337.50491659509,
        ["y"] = -85.773923865469,
        ["g"] = 25,
        ["sublevel"] = 1,
        ["scale"] = 1.3,
      },
      [10] = {
        ["x"] = 696.27124801334,
        ["y"] = -221.60908034428,
        ["g"] = 36,
        ["sublevel"] = 1,
        ["scale"] = 1.3,
      },
    },
  },
  [11] = {
    ["name"] = "Blazebound Destroyer",
    ["id"] = 190034,
    ["count"] = 25,
    ["health"] = 7135161,
    ["scale"] = 1,
    ["displayId"] = 102505,
    ["creatureType"] = "Elemental",
    ["level"] = 91,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [373614] = {
      },
      [373692] = {
      },
      [384139] = {
      },
      [1305955] = {
        ["interruptible"] = true,
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 489.67981064042,
        ["y"] = -384.71840098227,
        ["g"] = 14,
        ["sublevel"] = 1,
        ["scale"] = 2,
      },
      [2] = {
        ["x"] = 570.70683477823,
        ["y"] = -455.99871716032,
        ["g"] = 16,
        ["sublevel"] = 1,
        ["scale"] = 2,
      },
      [3] = {
        ["x"] = 718.33316317136,
        ["y"] = -280.13290120719,
        ["g"] = 17,
        ["sublevel"] = 1,
        ["scale"] = 2,
      },
      [4] = {
        ["x"] = 631.08423028757,
        ["y"] = -201.2116183606,
        ["g"] = 19,
        ["sublevel"] = 1,
        ["scale"] = 2,
      },
    },
  },
  [12] = {
    ["name"] = "Ashseer Flamelasher",
    ["id"] = 190206,
    ["count"] = 7,
    ["health"] = 3567581,
    ["scale"] = 1,
    ["displayId"] = 102969,
    ["creatureType"] = "Humanoid",
    ["level"] = 90,
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
      [373972] = {
        ["magic"] = true,
      },
      [373973] = {
      },
      [373977] = {
      },
      [385536] = {
      },
      [385567] = {
      },
      [1305865] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 500.84652767885,
        ["y"] = -433.58313515902,
        ["g"] = 15,
        ["sublevel"] = 1,
        ["scale"] = 1.3,
      },
      [2] = {
        ["x"] = 509.46781502224,
        ["y"] = -425.84437585233,
        ["g"] = 15,
        ["sublevel"] = 1,
        ["scale"] = 1.3,
      },
      [3] = {
        ["x"] = 561.39417893819,
        ["y"] = -470.05164016785,
        ["g"] = 16,
        ["sublevel"] = 1,
        ["scale"] = 1.3,
      },
      [4] = {
        ["x"] = 732.14235893479,
        ["y"] = -287.59445359949,
        ["g"] = 17,
        ["sublevel"] = 1,
        ["scale"] = 1.3,
      },
      [6] = {
        ["x"] = 570.70180236109,
        ["y"] = -217.80693401243,
        ["g"] = 20,
        ["sublevel"] = 1,
        ["scale"] = 1.3,
      },
      [7] = {
        ["x"] = 310.15823800938,
        ["y"] = -116.61445103667,
        ["g"] = 29,
        ["sublevel"] = 1,
        ["scale"] = 1.3,
      },
      [8] = {
        ["x"] = 775.72154680341,
        ["y"] = -383.23631826682,
        ["g"] = 38,
        ["sublevel"] = 1,
        ["scale"] = 1.3,
      },
      [9] = {
        ["x"] = 685.23178143425,
        ["y"] = -228.58140175247,
        ["g"] = 36,
        ["sublevel"] = 1,
        ["scale"] = 1.3,
      },
      [10] = {
        ["x"] = 656.15967812779,
        ["y"] = -489.28303819384,
        ["g"] = 39,
        ["sublevel"] = 1,
        ["scale"] = 1.3,
      },
    },
  },
  [13] = {
    ["name"] = "Ruinous Stormbringer",
    ["id"] = 195119,
    ["count"] = 10,
    ["health"] = 10740817,
    ["scale"] = 1,
    ["displayId"] = 108753,
    ["creatureType"] = "Humanoid",
    ["level"] = 91,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Mind Soothe"] = true,
    },
    ["spells"] = {
      [385310] = {
        ["interruptible"] = true,
      },
      [385311] = {
      },
      [385312] = {
      },
      [385313] = {
      },
      [385314] = {
      },
      [385316] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 526.809602612,
        ["y"] = -338.60407286165,
        ["sublevel"] = 1,
        ["scale"] = 1.8,
      },
      [2] = {
        ["x"] = 642.8387448672,
        ["y"] = -437.4345190412,
        ["sublevel"] = 1,
        ["scale"] = 1.8,
      },
      [3] = {
        ["x"] = 715.46044756828,
        ["y"] = -356.15798360943,
        ["sublevel"] = 1,
        ["scale"] = 1.8,
      },
      [4] = {
        ["x"] = 589.32245138592,
        ["y"] = -258.01388552246,
        ["sublevel"] = 1,
        ["scale"] = 1.8,
      },
    },
  },
  [14] = {
    ["name"] = "Flamegullet",
    ["id"] = 197697,
    ["count"] = 40,
    ["health"] = 9729765,
    ["scale"] = 1,
    ["stealthDetect"] = true,
    ["displayId"] = 106023,
    ["creatureType"] = "Dragonkin",
    ["level"] = 91,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Mind Soothe"] = true,
    },
    ["spells"] = {
      [391723] = {
      },
      [392394] = {
      },
      [392569] = {
      },
      [392570] = {
      },
      [395292] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 747.89039257338,
        ["y"] = -333.65643120583,
        ["sublevel"] = 1,
        ["scale"] = 2.5,
      },
    },
  },
  [15] = {
    ["name"] = "Kokia Blazehoof",
    ["id"] = 189232,
    ["count"] = 0,
    ["health"] = 21621698,
    ["scale"] = 1,
    ["displayId"] = 106851,
    ["creatureType"] = "Humanoid",
    ["level"] = 92,
    ["isBoss"] = true,
    ["encounterID"] = 2485,
    ["instanceID"] = 1202,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Mind Soothe"] = true,
    },
    ["spells"] = {
      [372107] = {
      },
      [372811] = {
      },
      [372819] = {
      },
      [372820] = {
      },
      [372858] = {
      },
      [372859] = {
      },
      [372860] = {
      },
      [372863] = {
      },
      [1306272] = {
      },
      [1309540] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 479.87966686496,
        ["y"] = -232.88346577194,
        ["sublevel"] = 1,
        ["scale"] = 2,
      },
    },
  },
  [16] = {
    ["name"] = "Storm Warrior",
    ["id"] = 197982,
    ["count"] = 5,
    ["health"] = 3567581,
    ["scale"] = 1,
    ["displayId"] = 110964,
    ["creatureType"] = "Humanoid",
    ["level"] = 90,
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
      [392406] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 443.43388966418,
        ["y"] = -198.70941224111,
        ["g"] = 21,
        ["sublevel"] = 1,
        ["scale"] = 1.6,
      },
      [2] = {
        ["x"] = 434.3075430312,
        ["y"] = -207.35892298144,
        ["g"] = 21,
        ["sublevel"] = 1,
        ["scale"] = 1.6,
      },
      [3] = {
        ["x"] = 356.2948081972,
        ["y"] = -140.89984768495,
        ["g"] = 24,
        ["sublevel"] = 1,
        ["scale"] = 1.3,
        ["patrol"] = {
        },
      },
      [4] = {
        ["x"] = 363.66398750955,
        ["y"] = -133.79697633026,
        ["g"] = 24,
        ["sublevel"] = 1,
        ["scale"] = 1.3,
      },
      [5] = {
        ["x"] = 327.6382486225,
        ["y"] = -79.231595356086,
        ["g"] = 25,
        ["sublevel"] = 1,
        ["scale"] = 1.3,
      },
      [7] = {
        ["x"] = 286.6359342376,
        ["y"] = -85.071721637223,
        ["g"] = 27,
        ["sublevel"] = 1,
        ["scale"] = 1.3,
      },
      [8] = {
        ["x"] = 295.26883850193,
        ["y"] = -76.968911806891,
        ["g"] = 27,
        ["sublevel"] = 1,
        ["scale"] = 1.3,
      },
      [9] = {
        ["x"] = 299.00524466669,
        ["y"] = -117.07391485265,
        ["g"] = 29,
        ["sublevel"] = 1,
        ["scale"] = 1.3,
      },
      [10] = {
        ["x"] = 305.94123013793,
        ["y"] = -127.24662769628,
        ["g"] = 29,
        ["sublevel"] = 1,
        ["scale"] = 1.3,
      },
    },
  },
  [17] = {
    ["name"] = "Primal Thundercloud",
    ["id"] = 197509,
    ["count"] = 0,
    ["health"] = 1621628,
    ["scale"] = 1,
    ["displayId"] = 102516,
    ["creatureType"] = "Elemental",
    ["level"] = 89,
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
      [391031] = {
        ["magic"] = true,
      },
      [392399] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 431.13152013117,
        ["y"] = -195.6986262502,
        ["g"] = 21,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [2] = {
        ["x"] = 403.34243438809,
        ["y"] = -181.17984255837,
        ["g"] = 22,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [3] = {
        ["x"] = 410.87664211028,
        ["y"] = -173.62681853449,
        ["g"] = 22,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [4] = {
        ["x"] = 378.49521530182,
        ["y"] = -168.23196162669,
        ["g"] = 23,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [5] = {
        ["x"] = 395.32869950909,
        ["y"] = -167.42368496293,
        ["g"] = 23,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [6] = {
        ["x"] = 396.25111818363,
        ["y"] = -150.83056202294,
        ["g"] = 23,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [7] = {
        ["x"] = 256.27849430324,
        ["y"] = -101.97512481833,
        ["g"] = 26,
        ["sublevel"] = 1,
        ["scale"] = 0.8,
      },
      [8] = {
        ["x"] = 252.40707045072,
        ["y"] = -107.61596048733,
        ["g"] = 26,
        ["sublevel"] = 1,
        ["scale"] = 0.8,
      },
      [9] = {
        ["x"] = 250.58597056069,
        ["y"] = -98.047257408442,
        ["g"] = 26,
        ["sublevel"] = 1,
        ["scale"] = 0.8,
      },
      [10] = {
        ["x"] = 247.36505954987,
        ["y"] = -103.95344781756,
        ["g"] = 26,
        ["sublevel"] = 1,
        ["scale"] = 0.8,
      },
      [11] = {
        ["x"] = 296.16254480078,
        ["y"] = -66.952490137926,
        ["g"] = 27,
        ["sublevel"] = 1,
        ["scale"] = 0.8,
      },
      [12] = {
        ["x"] = 276.19173661396,
        ["y"] = -83.564560408933,
        ["g"] = 27,
        ["sublevel"] = 1,
        ["scale"] = 0.8,
      },
      [13] = {
        ["x"] = 279.37777235149,
        ["y"] = -90.893261558163,
        ["g"] = 27,
        ["sublevel"] = 1,
        ["scale"] = 0.8,
      },
      [14] = {
        ["x"] = 357.56509351749,
        ["y"] = -64.514094903674,
        ["g"] = 35,
        ["sublevel"] = 1,
        ["scale"] = 0.8,
      },
      [15] = {
        ["x"] = 355.95658057224,
        ["y"] = -71.884651716558,
        ["g"] = 35,
        ["sublevel"] = 1,
        ["scale"] = 0.8,
      },
      [16] = {
        ["x"] = 330.4612476198,
        ["y"] = -49.598898618216,
        ["g"] = 28,
        ["sublevel"] = 1,
        ["scale"] = 0.8,
      },
      [18] = {
        ["x"] = 348.53078045978,
        ["y"] = -71.02747830004,
        ["g"] = 35,
        ["sublevel"] = 1,
        ["scale"] = 0.8,
      },
      [19] = {
        ["x"] = 323.76094943351,
        ["y"] = -48.469988341458,
        ["g"] = 28,
        ["sublevel"] = 1,
        ["scale"] = 0.8,
      },
      [20] = {
        ["x"] = 329.89290560946,
        ["y"] = -42.83497997535,
        ["g"] = 28,
        ["sublevel"] = 1,
        ["scale"] = 0.8,
      },
      [21] = {
        ["x"] = 303.72259772989,
        ["y"] = -70.642750500389,
        ["g"] = 27,
        ["sublevel"] = 1,
        ["scale"] = 0.8,
      },
      [22] = {
        ["x"] = 320.89483320207,
        ["y"] = -84.880077785502,
        ["g"] = 25,
        ["sublevel"] = 1,
        ["scale"] = 0.8,
      },
      [23] = {
        ["x"] = 349.20668509862,
        ["y"] = -63.345541802625,
        ["g"] = 35,
        ["sublevel"] = 1,
        ["scale"] = 0.8,
      },
    },
  },
  [18] = {
    ["name"] = "Tempest Channeler",
    ["id"] = 198047,
    ["count"] = 25,
    ["health"] = 5189208,
    ["scale"] = 0.8,
    ["displayId"] = 110967,
    ["creatureType"] = "Humanoid",
    ["level"] = 91,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Mind Soothe"] = true,
    },
    ["spells"] = {
      [392576] = {
        ["interruptible"] = true,
      },
      [1306366] = {
      },
      [1307488] = {
      },
      [1307502] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 387.14765533399,
        ["y"] = -158.44175986472,
        ["g"] = 23,
        ["sublevel"] = 1,
        ["scale"] = 1.8,
      },
      [2] = {
        ["x"] = 327.78588952948,
        ["y"] = -91.689858030082,
        ["g"] = 25,
        ["sublevel"] = 1,
        ["scale"] = 1.8,
      },
    },
  },
  [19] = {
    ["name"] = "High Channeler Ryvati",
    ["id"] = 197535,
    ["count"] = 30,
    ["health"] = 6486510,
    ["scale"] = 1,
    ["displayId"] = 110966,
    ["creatureType"] = "Humanoid",
    ["level"] = 91,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Mind Soothe"] = true,
    },
    ["spells"] = {
      [1306366] = {
      },
      [1307488] = {
      },
      [1307511] = {
      },
      [1310355] = {
      },
      [1310361] = {
      },
      [1310363] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 281.85447935368,
        ["y"] = -71.356965310323,
        ["g"] = 27,
        ["sublevel"] = 1,
        ["scale"] = 1.8,
      },
    },
  },
  [20] = {
    ["name"] = "Erkhart Stormvein",
    ["id"] = 190485,
    ["count"] = 0,
    ["health"] = 15202757,
    ["scale"] = 1,
    ["displayId"] = 108318,
    ["creatureType"] = "Humanoid",
    ["level"] = 92,
    ["isBoss"] = true,
    ["encounterID"] = 2503,
    ["instanceID"] = 1202,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Mind Soothe"] = true,
    },
    ["spells"] = {
      [181089] = {
      },
      [381512] = {
      },
      [381513] = {
      },
      [381514] = {
      },
      [381515] = {
        ["magic"] = true,
      },
      [381516] = {
      },
      [381517] = {
      },
      [381518] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 255.0992522811,
        ["y"] = -21.384343906324,
        ["g"] = 30,
        ["sublevel"] = 1,
        ["scale"] = 2,
      },
    },
  },
  [21] = {
    ["name"] = "Kyrakka",
    ["id"] = 190484,
    ["count"] = 0,
    ["health"] = 13513562,
    ["scale"] = 1,
    ["displayId"] = 107137,
    ["creatureType"] = "Dragonkin",
    ["level"] = 92,
    ["isBoss"] = true,
    ["encounterID"] = 2503,
    ["instanceID"] = 1202,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Mind Soothe"] = true,
    },
    ["spells"] = {
      [381525] = {
      },
      [381526] = {
      },
      [381602] = {
      },
      [381605] = {
      },
      [381862] = {
      },
      [381864] = {
      },
      [384773] = {
      },
      [1312669] = {
      },
      [1312684] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 226.44679474865,
        ["y"] = -49.239741574134,
        ["g"] = 30,
        ["sublevel"] = 1,
        ["scale"] = 2,
      },
    },
  },
  [22] = {
    ["name"] = "Blazebound Firestorm",
    ["id"] = 189886,
    ["count"] = 0,
    ["health"] = 2162170,
    ["scale"] = 1.8,
    ["displayId"] = 102505,
    ["creatureType"] = "Elemental",
    ["level"] = 91,
    ["spells"] = {
      [373017] = {
        ["interruptible"] = true,
      },
      [373087] = {
      },
      [384823] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 502.59808170246,
        ["y"] = -221.38179053256,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 503.69858955364,
        ["y"] = -239.20963387208,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 494.40212463212,
        ["y"] = -255.01348143734,
        ["sublevel"] = 1,
      },
    },
  },
  [23] = {
    ["name"] = "Infused Whelp",
    ["id"] = 189893,
    ["count"] = 0,
    ["health"] = 810814,
    ["scale"] = 1,
    ["displayId"] = 110633,
    ["creatureType"] = "Dragonkin",
    ["level"] = 90,
    ["spells"] = {
      [1305234] = {
        ["magic"] = true,
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 338.06439542087,
        ["y"] = -242.29866425955,
        ["sublevel"] = 1,
      },
    },
  },
  [24] = {
    ["name"] = "Scorchling",
    ["id"] = 194622,
    ["count"] = 0,
    ["health"] = 648651,
    ["scale"] = 1,
    ["displayId"] = 102535,
    ["creatureType"] = "Elemental",
    ["level"] = 90,
    ["spells"] = {
      [1307372] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 517.03300013562,
        ["y"] = -200,
        ["sublevel"] = 1,
      },
    },
  },
};
