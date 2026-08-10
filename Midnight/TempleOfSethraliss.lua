local _, MDT = ...
local addonName = MDT.AddonName
local L = MDT.L
local dungeonIndex = 20
MDT.dungeonList[dungeonIndex] = L["Temple of Sethraliss"]
MDT.mapInfo[dungeonIndex] = {
  teleportId = 1286828,
  iconId = 2011143,
  shortName = L["templeOfSethralisShortName"],
  englishName = "Temple of Sethraliss",
  mapID = 250
};

local zones = { 1038, 1043 }
for _, zone in ipairs(zones) do
  MDT.zoneIdToDungeonIdx[zone] = dungeonIndex
end

MDT.dungeonTotalCount[dungeonIndex] = { normal = 649 }

MDT.dungeonMaps[dungeonIndex] = {
  [0] = "",
  [1] = { customTextures = 'Interface\\AddOns\\'..addonName..'\\Midnight\\Textures\\TempleOfSethraliss' },
}
MDT.dungeonSubLevels[dungeonIndex] = {
  [1] = L["Temple of Sethraliss"],
}

MDT.mapPOIs[dungeonIndex] = {};

MDT.dungeonEnemies[dungeonIndex] = {
  [1] = {
    ["name"] = "Sandswept Hunter",
    ["id"] = 134600,
    ["count"] = 7,
    ["health"] = 3567581,
    ["scale"] = 1.2,
    ["displayId"] = 83780,
    ["creatureType"] = "Humanoid",
    ["level"] = 90,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Incapacitate"] = true,
      ["Silence"] = true,
      ["Polymorph"] = true,
      ["Root"] = true,
      ["Fear"] = true,
      ["Disorient"] = true,
      ["Imprison"] = true,
      ["Sap"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
    },
    ["spells"] = {
      [1292585] = {
      },
      [1292623] = {
      },
      [1308113] = {
      },
      [1308116] = {
      },
    },
    ["clones"] = {
      [8] = {
        ["x"] = 711.31687223238,
        ["y"] = -527.0471516478,
        ["g"] = 1,
        ["sublevel"] = 1,
      },
      [13] = {
        ["x"] = 532.54624536162,
        ["y"] = -422.45967453032,
        ["g"] = 13,
        ["sublevel"] = 1,
      },
      [18] = {
        ["x"] = 500.82391333988,
        ["y"] = -392.58988983194,
        ["g"] = 16,
        ["sublevel"] = 1,
      },
      [19] = {
        ["x"] = 485.83871182871,
        ["y"] = -253.47358192893,
        ["g"] = 23,
        ["sublevel"] = 1,
      },
      [20] = {
        ["x"] = 681.93477663437,
        ["y"] = -426.34149435176,
        ["g"] = 10,
        ["sublevel"] = 1,
      },
      [21] = {
        ["x"] = 716.6062038652,
        ["y"] = -387.09246652334,
        ["g"] = 9,
        ["sublevel"] = 1,
      },
      [22] = {
        ["x"] = 682.22377309648,
        ["y"] = -488.72897472786,
        ["g"] = 6,
        ["sublevel"] = 1,
      },
      [23] = {
        ["x"] = 726.26541661423,
        ["y"] = -454.47180496837,
        ["g"] = 4,
        ["sublevel"] = 1,
      },
      [24] = {
        ["x"] = 736.6657710216,
        ["y"] = -454.58798654015,
        ["g"] = 4,
        ["sublevel"] = 1,
      },
    },
  },
  [2] = {
    ["name"] = "Barbed Krolusk",
    ["id"] = 134616,
    ["count"] = 5,
    ["health"] = 2594604,
    ["scale"] = 1.2,
    ["displayId"] = 83787,
    ["creatureType"] = "Beast",
    ["level"] = 90,
    ["characteristics"] = {
      ["Silence"] = true,
      ["Root"] = true,
      ["Fear"] = true,
      ["Disorient"] = true,
      ["Sap"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
    },
    ["spells"] = {
      [1291399] = {
      },
    },
    ["clones"] = {
      [8] = {
        ["x"] = 699.87276875718,
        ["y"] = -526.3722801382,
        ["g"] = 1,
        ["sublevel"] = 1,
      },
      [9] = {
        ["x"] = 508.35965579572,
        ["y"] = -451.68091442946,
        ["g"] = 14,
        ["sublevel"] = 1,
      },
      [10] = {
        ["x"] = 491.98411436395,
        ["y"] = -440.15891611317,
        ["g"] = 14,
        ["sublevel"] = 1,
      },
      [13] = {
        ["x"] = 701.33218784475,
        ["y"] = -397.32216193294,
        ["g"] = 9,
        ["sublevel"] = 1,
      },
      [14] = {
        ["x"] = 711.96334837735,
        ["y"] = -396.85889822295,
        ["g"] = 9,
        ["sublevel"] = 1,
      },
      [15] = {
        ["x"] = 679.22555323957,
        ["y"] = -455.06443304918,
        ["g"] = 7,
        ["sublevel"] = 1,
      },
      [16] = {
        ["x"] = 688.35935582235,
        ["y"] = -459.24785088927,
        ["g"] = 7,
        ["sublevel"] = 1,
      },
      [17] = {
        ["x"] = 726.14920088093,
        ["y"] = -465.84826713159,
        ["g"] = 4,
        ["sublevel"] = 1,
      },
    },
  },
  [3] = {
    ["name"] = "Storm Adept",
    ["id"] = 134990,
    ["count"] = 7,
    ["health"] = 2918930,
    ["scale"] = 1.2,
    ["displayId"] = 84024,
    ["creatureType"] = "Humanoid",
    ["level"] = 90,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Incapacitate"] = true,
      ["Silence"] = true,
      ["Root"] = true,
      ["Fear"] = true,
      ["Disorient"] = true,
      ["Imprison"] = true,
      ["Sap"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
    },
    ["spells"] = {
      [1291262] = {
        ["interruptible"] = true,
      },
    },
    ["clones"] = {
      [2] = {
        ["x"] = 705.44372867111,
        ["y"] = -516.20566610244,
        ["g"] = 1,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 469.45880601581,
        ["y"] = -409.16531549719,
        ["g"] = 15,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 477.46021183494,
        ["y"] = -416.58064587383,
        ["g"] = 15,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 537.78290200804,
        ["y"] = -433.428299397,
        ["g"] = 13,
        ["sublevel"] = 1,
      },
      [6] = {
        ["x"] = 706.12422021642,
        ["y"] = -387.15528660271,
        ["g"] = 9,
        ["sublevel"] = 1,
      },
      [7] = {
        ["x"] = 722.93227832559,
        ["y"] = -426.26200930948,
        ["g"] = 8,
        ["sublevel"] = 1,
      },
      [8] = {
        ["x"] = 675.25144859916,
        ["y"] = -465.11620782263,
        ["g"] = 7,
        ["sublevel"] = 1,
      },
      [9] = {
        ["x"] = 684.84992666372,
        ["y"] = -469.33440491981,
        ["g"] = 7,
        ["sublevel"] = 1,
      },
    },
  },
  [4] = {
    ["name"] = "Sandfury Stonefist",
    ["id"] = 134991,
    ["count"] = 25,
    ["health"] = 5837859,
    ["scale"] = 1.7,
    ["displayId"] = 84207,
    ["creatureType"] = "Humanoid",
    ["level"] = 91,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [265966] = {
      },
      [1291468] = {
      },
    },
    ["clones"] = {
      [3] = {
        ["x"] = 727.95717945839,
        ["y"] = -416.14433642394,
        ["g"] = 8,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 670.12677873821,
        ["y"] = -488.90328985203,
        ["g"] = 6,
        ["sublevel"] = 1,
      },
      [7] = {
        ["x"] = 677.30084880855,
        ["y"] = -414.86071053625,
        ["g"] = 10,
        ["sublevel"] = 1,
      },
      [8] = {
        ["x"] = 732.70374877419,
        ["y"] = -488.38535761725,
        ["g"] = 3,
        ["sublevel"] = 1,
      },
    },
  },
  [5] = {
    ["name"] = "Shrouded Fang",
    ["id"] = 134602,
    ["count"] = 7,
    ["health"] = 3243255,
    ["scale"] = 1.2,
    ["stealth"] = true,
    ["displayId"] = 83782,
    ["creatureType"] = "Humanoid",
    ["level"] = 90,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Polymorph"] = true,
      ["Root"] = true,
      ["Fear"] = true,
      ["Sap"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
    },
    ["spells"] = {
      [1295610] = {
      },
      [1295635] = {
      },
      [1308100] = {
        ["interruptible"] = true,
        ["poison"] = true,
      },
    },
    ["clones"] = {
      [2] = {
        ["x"] = 731.00782411623,
        ["y"] = -515.32684222536,
        ["g"] = 2,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 723.51952123551,
        ["y"] = -507.49602157895,
        ["g"] = 2,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 670.70189404273,
        ["y"] = -425.84350786231,
        ["g"] = 10,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 695.43556004088,
        ["y"] = -387.81385708651,
        ["g"] = 9,
        ["sublevel"] = 1,
      },
      [10] = {
        ["x"] = 734.75491850121,
        ["y"] = -426.99481950809,
        ["g"] = 8,
        ["sublevel"] = 1,
      },
      [11] = {
        ["x"] = 685.53497951274,
        ["y"] = -508.48375932308,
        ["g"] = 5,
        ["sublevel"] = 1,
      },
      [12] = {
        ["x"] = 736.0149858323,
        ["y"] = -465.62746528817,
        ["g"] = 4,
        ["sublevel"] = 1,
      },
    },
  },
  [6] = {
    ["name"] = "Sand-Sworn Rider",
    ["id"] = 134629,
    ["count"] = 25,
    ["health"] = 5189208,
    ["scale"] = 1.7,
    ["displayId"] = 84761,
    ["creatureType"] = "Humanoid",
    ["level"] = 91,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Silence"] = true,
      ["Root"] = true,
      ["Fear"] = true,
      ["Disorient"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
    },
    ["spells"] = {
      [262046] = {
      },
      [272655] = {
      },
      [1291399] = {
      },
      [1292990] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 641.78431958825,
        ["y"] = -391.85061845701,
        ["g"] = 12,
        ["sublevel"] = 1,
        ["patrol"] = {
          [1] = {
            ["x"] = 641.78431958825,
            ["y"] = -391.85061845701,
          },
          [2] = {
            ["x"] = 653.70738969785,
            ["y"] = -393.38908390835,
          },
          [3] = {
            ["x"] = 666.59202753663,
            ["y"] = -396.85062704738,
          },
          [4] = {
            ["x"] = 670.24587266737,
            ["y"] = -400.11985994177,
          },
          [5] = {
            ["x"] = 666.59202753663,
            ["y"] = -396.85062704738,
          },
          [6] = {
            ["x"] = 653.70738969785,
            ["y"] = -393.38908390835,
          },
          [7] = {
            ["x"] = 641.78431958825,
            ["y"] = -391.85061845701,
          },
          [8] = {
            ["x"] = 630.19483329899,
            ["y"] = -392.87638539285,
          },
          [9] = {
            ["x"] = 608.27174600864,
            ["y"] = -394.9917733252,
          },
          [10] = {
            ["x"] = 575.38715633787,
            ["y"] = -394.41485909714,
          },
          [11] = {
            ["x"] = 608.27174600864,
            ["y"] = -394.9917733252,
          },
          [12] = {
            ["x"] = 630.19483329899,
            ["y"] = -392.87638539285,
          },
        },
      },
      [2] = {
        ["x"] = 489.64437625639,
        ["y"] = -352.44154493929,
        ["g"] = 17,
        ["sublevel"] = 1,
      },
      [6] = {
        ["x"] = 494.50124704269,
        ["y"] = -279.24995126245,
        ["g"] = 19,
        ["sublevel"] = 1,
      },
      [7] = {
        ["x"] = 469.88004897779,
        ["y"] = -279.1334719261,
        ["g"] = 25,
        ["sublevel"] = 1,
      },
    },
  },
  [7] = {
    ["name"] = "Poisonous Viper",
    ["id"] = 135562,
    ["count"] = 7,
    ["health"] = 3243255,
    ["scale"] = 1.2,
    ["displayId"] = 78250,
    ["creatureType"] = "Beast",
    ["level"] = 90,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Root"] = true,
      ["Fear"] = true,
      ["Disorient"] = true,
      ["Sap"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
    },
    ["spells"] = {
      [1308148] = {
        ["interruptible"] = true,
        ["poison"] = true,
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 546.82897740729,
        ["y"] = -428.13492919763,
        ["g"] = 13,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 490.37571219524,
        ["y"] = -394.30743083008,
        ["g"] = 16,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 518.16486159562,
        ["y"] = -269.53094353189,
        ["g"] = 20,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 481.81329918503,
        ["y"] = -232.01753508529,
        ["g"] = 22,
        ["sublevel"] = 1,
      },
      [6] = {
        ["x"] = 491.87043037541,
        ["y"] = -231.17243317305,
        ["g"] = 22,
        ["sublevel"] = 1,
      },
      [7] = {
        ["x"] = 443.89238737922,
        ["y"] = -268.56932870932,
        ["g"] = 26,
        ["sublevel"] = 1,
      },
    },
  },
  [8] = {
    ["name"] = "Lightning Serpent",
    ["id"] = 135846,
    ["count"] = 5,
    ["health"] = 3243255,
    ["scale"] = 1.2,
    ["displayId"] = 78247,
    ["creatureType"] = "Beast",
    ["level"] = 90,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Root"] = true,
      ["Fear"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
    },
    ["spells"] = {
      [1293133] = {
      },
      [1310396] = {
      },
      [1310402] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 541.80977580018,
        ["y"] = -418.14007248604,
        ["g"] = 13,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 496.85046276649,
        ["y"] = -403.45389177912,
        ["g"] = 16,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 508.86851673445,
        ["y"] = -268.26324589823,
        ["g"] = 20,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 515.84071382802,
        ["y"] = -260.02333997967,
        ["g"] = 20,
        ["sublevel"] = 1,
      },
      [6] = {
        ["x"] = 448.11799766236,
        ["y"] = -278.0770329835,
        ["g"] = 26,
        ["sublevel"] = 1,
      },
      [7] = {
        ["x"] = 464.59802213471,
        ["y"] = -242.58162234544,
        ["g"] = 24,
        ["sublevel"] = 1,
      },
    },
  },
  [9] = {
    ["name"] = "Dutiful Tamer",
    ["id"] = 139422,
    ["count"] = 7,
    ["health"] = 3243255,
    ["scale"] = 1.2,
    ["displayId"] = 84761,
    ["creatureType"] = "Humanoid",
    ["level"] = 90,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [1291399] = {
      },
      [1292990] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 497.31782248064,
        ["y"] = -450.21237514546,
        ["g"] = 14,
        ["sublevel"] = 1,
      },
    },
  },
  [10] = {
    ["name"] = "Krolusk Matriarch",
    ["id"] = 134686,
    ["count"] = 16,
    ["health"] = 4216232,
    ["scale"] = 1.7,
    ["displayId"] = 75595,
    ["creatureType"] = "Beast",
    ["level"] = 91,
    ["characteristics"] = {
      ["Fear"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
    },
    ["spells"] = {
      [272654] = {
      },
      [272655] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 504.74356909226,
        ["y"] = -437.63661527492,
        ["g"] = 14,
        ["sublevel"] = 1,
      },
    },
  },
  [11] = {
    ["name"] = "Faithless Subjugator",
    ["id"] = 134364,
    ["count"] = 7,
    ["health"] = 3243255,
    ["scale"] = 1.2,
    ["displayId"] = 86510,
    ["creatureType"] = "Humanoid",
    ["level"] = 90,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Incapacitate"] = true,
      ["Silence"] = true,
      ["Polymorph"] = true,
      ["Root"] = true,
      ["Fear"] = true,
      ["Disorient"] = true,
      ["Imprison"] = true,
      ["Sap"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
    },
    ["spells"] = {
      [269896] = {
      },
      [1293307] = {
        ["interruptible"] = true,
        ["curse"] = true,
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 483.06791548824,
        ["y"] = -307.22036588248,
        ["g"] = 18,
        ["sublevel"] = 1,
      },
      [6] = {
        ["x"] = 481.30754117774,
        ["y"] = -263.04912492556,
        ["g"] = 23,
        ["sublevel"] = 1,
      },
      [7] = {
        ["x"] = 490.90952474603,
        ["y"] = -262.77001632072,
        ["g"] = 23,
        ["sublevel"] = 1,
      },
    },
  },
  [12] = {
    ["name"] = "Brood Tender",
    ["id"] = 139425,
    ["count"] = 7,
    ["health"] = 3243255,
    ["scale"] = 1.2,
    ["displayId"] = 83444,
    ["creatureType"] = "Humanoid",
    ["level"] = 90,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Incapacitate"] = true,
      ["Silence"] = true,
      ["Root"] = true,
      ["Fear"] = true,
      ["Disorient"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
    },
    ["spells"] = {
      [1310683] = {
        ["interruptible"] = true,
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 492.7236693936,
        ["y"] = -306.82722725704,
        ["g"] = 18,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 506.33305431915,
        ["y"] = -245.65604790524,
        ["g"] = 20,
        ["sublevel"] = 1,
      },
      [6] = {
        ["x"] = 456.56929656791,
        ["y"] = -248.28622252729,
        ["g"] = 24,
        ["sublevel"] = 1,
      },
    },
  },
  [13] = {
    ["name"] = "Merektha",
    ["id"] = 133384,
    ["count"] = 0,
    ["health"] = 15540596,
    ["scale"] = 2,
    ["displayId"] = 88585,
    ["creatureType"] = "Beast",
    ["level"] = 92,
    ["isBoss"] = true,
    ["encounterID"] = 2143,
    ["instanceID"] = 1030,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [264172] = {
      },
      [1289205] = {
      },
      [1289589] = {
      },
      [1289602] = {
      },
      [1290031] = {
      },
      [1290797] = {
      },
      [1291734] = {
      },
      [1293048] = {
      },
      [1296738] = {
      },
      [1296912] = {
      },
      [1297034] = {
      },
      [1298329] = {
      },
      [1308838] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 414.8547307341,
        ["y"] = -228.04592608441,
        ["g"] = 34,
        ["sublevel"] = 1,
      },
    },
  },
  [14] = {
    ["name"] = "Agitated Nimbus",
    ["id"] = 136076,
    ["count"] = 25,
    ["health"] = 5189208,
    ["scale"] = 1.7,
    ["displayId"] = 65631,
    ["creatureType"] = "Elemental",
    ["level"] = 91,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [1293464] = {
        ["magic"] = true,
      },
      [1293475] = {
      },
      [1293650] = {
      },
      [1293652] = {
      },
      [1310739] = {
        ["magic"] = true,
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 553.51901592664,
        ["y"] = -155.8833790673,
        ["g"] = 29,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 503.02263333766,
        ["y"] = -156.80776860394,
        ["g"] = 30,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 541.58231125855,
        ["y"] = -251.40338891308,
        ["g"] = 27,
        ["sublevel"] = 1,
      },
    },
  },
  [15] = {
    ["name"] = "Imbued Stormcaller",
    ["id"] = 134599,
    ["count"] = 7,
    ["health"] = 3243255,
    ["scale"] = 1.2,
    ["displayId"] = 83779,
    ["creatureType"] = "Humanoid",
    ["level"] = 90,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Silence"] = true,
      ["Root"] = true,
      ["Fear"] = true,
      ["Disorient"] = true,
      ["Imprison"] = true,
      ["Sap"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
    },
    ["spells"] = {
      [269116] = {
      },
      [1291262] = {
        ["interruptible"] = true,
      },
      [1296045] = {
      },
      [1296052] = {
        ["magic"] = true,
      },
      [1310739] = {
        ["magic"] = true,
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 557.62387888288,
        ["y"] = -168.94323876431,
        ["g"] = 29,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 546.44104695552,
        ["y"] = -168.50749855909,
        ["g"] = 29,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 515.43547735139,
        ["y"] = -152.52930738642,
        ["g"] = 30,
        ["sublevel"] = 1,
      },
      [6] = {
        ["x"] = 513.3225295204,
        ["y"] = -164.70438321247,
        ["g"] = 30,
        ["sublevel"] = 1,
      },
    },
  },
  [16] = {
    ["name"] = "Static Anomaly",
    ["id"] = 134691,
    ["count"] = 5,
    ["health"] = 3243255,
    ["scale"] = 1.2,
    ["displayId"] = 81655,
    ["creatureType"] = "Elemental",
    ["level"] = 90,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [264763] = {
      },
      [1310693] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 484.38764206587,
        ["y"] = -144.93569966322,
        ["g"] = 31,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 472.97839693686,
        ["y"] = -161.6270052093,
        ["g"] = 31,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 468.96404534479,
        ["y"] = -171.1346759095,
        ["g"] = 31,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 478.89433414907,
        ["y"] = -170.2895516146,
        ["g"] = 31,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 537.87483531924,
        ["y"] = -154.58075550007,
        ["g"] = 29,
        ["sublevel"] = 1,
      },
      [10] = {
        ["x"] = 545.01491097792,
        ["y"] = -144.659059711,
        ["g"] = 29,
        ["sublevel"] = 1,
      },
    },
  },
  [17] = {
    ["name"] = "Twisted Hexxer",
    ["id"] = 136250,
    ["count"] = 25,
    ["health"] = 4864883,
    ["scale"] = 1.7,
    ["displayId"] = 84676,
    ["creatureType"] = "Humanoid",
    ["level"] = 91,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [268013] = {
        ["interruptible"] = true,
      },
      [1300666] = {
      },
      [1300684] = {
      },
      [1311964] = {
      },
      [1311980] = {
      },
      [1311981] = {
      },
    },
    ["clones"] = {
      [6] = {
        ["x"] = 102.65578836943,
        ["y"] = -139.76667682277,
        ["g"] = 41,
        ["sublevel"] = 1,
      },
    },
  },
  [18] = {
    ["name"] = "Avatar of Sethraliss",
    ["id"] = 133392,
    ["count"] = 0,
    ["health"] = 21621700,
    ["scale"] = 2,
    ["displayId"] = 83203,
    ["creatureType"] = "Undead",
    ["level"] = 120,
    ["isBoss"] = true,
    ["encounterID"] = 2145,
    ["instanceID"] = 1030,
    ["clones"] = {
      [1] = {
        ["x"] = 66.533480164117,
        ["y"] = -80.428720447878,
        ["g"] = 44,
        ["sublevel"] = 1,
      },
    },
  },
  [19] = {
    ["name"] = "Spark Channeler",
    ["id"] = 265057,
    ["count"] = 5,
    ["health"] = 648651,
    ["scale"] = 1.5,
    ["displayId"] = 83553,
    ["creatureType"] = "Humanoid",
    ["level"] = 120,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["clones"] = {
      [1] = {
        ["x"] = 553.28505145066,
        ["y"] = -198.89025556352,
        ["g"] = 28,
        ["sublevel"] = 1,
      },
    },
  },
  [20] = {
    ["name"] = "A Knot of Snakes",
    ["id"] = 134388,
    ["count"] = 0,
    ["health"] = 540542,
    ["scale"] = 1,
    ["displayId"] = 83574,
    ["creatureType"] = "Beast",
    ["level"] = 90,
    ["spells"] = {
      [263958] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 431.31924209001,
        ["y"] = -217.47670032565,
        ["g"] = 34,
        ["sublevel"] = 1,
      },
    },
  },
  [21] = {
    ["name"] = "Toxic Viper",
    ["id"] = 134389,
    ["count"] = 0,
    ["health"] = 1405411,
    ["scale"] = 1.2,
    ["displayId"] = 78250,
    ["creatureType"] = "Beast",
    ["level"] = 90,
    ["spells"] = {
      [267027] = {
        ["interruptible"] = true,
        ["poison"] = true,
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 403.01005603595,
        ["y"] = -271.26863221765,
        ["g"] = 35,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 414.14018854934,
        ["y"] = -271.42278064034,
        ["g"] = 35,
        ["sublevel"] = 1,
      },
    },
  },
  [22] = {
    ["name"] = "Storm Serpent",
    ["id"] = 134390,
    ["count"] = 0,
    ["health"] = 2972984,
    ["scale"] = 1.7,
    ["displayId"] = 78247,
    ["creatureType"] = "Beast",
    ["level"] = 91,
    ["spells"] = {
      [1289589] = {
      },
      [1291622] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 409.83830457903,
        ["y"] = -258.51197411939,
        ["g"] = 35,
        ["sublevel"] = 1,
      },
    },
  },
  [23] = {
    ["name"] = "Merektha",
    ["id"] = 134487,
    ["count"] = 0,
    ["health"] = 307716,
    ["scale"] = 1,
    ["displayId"] = 78247,
    ["creatureType"] = "Beast",
    ["level"] = 90,
    ["clones"] = {
      [1] = {
        ["x"] = 433.48294517614,
        ["y"] = -235.77851134178,
        ["g"] = 34,
        ["sublevel"] = 1,
      },
    },
  },
  [24] = {
    ["name"] = "Orb Watcher",
    ["id"] = 135007,
    ["count"] = 25,
    ["health"] = 6486510,
    ["scale"] = 1.5,
    ["displayId"] = 84503,
    ["creatureType"] = "Humanoid",
    ["level"] = 91,
    ["spells"] = {
      [1303443] = {
      },
      [1303452] = {
      },
      [1303486] = {
      },
      [1308546] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 261.59302994071,
        ["y"] = -300.79458091312,
        ["g"] = 37,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 173.93603151449,
        ["y"] = -341.76471641297,
        ["g"] = 38,
        ["sublevel"] = 1,
      },
    },
  },
  [25] = {
    ["name"] = "Lightning Spire",
    ["id"] = 135445,
    ["count"] = 0,
    ["health"] = 21621699,
    ["scale"] = 1,
    ["displayId"] = 46710,
    ["creatureType"] = "Elemental",
    ["level"] = 90,
    ["clones"] = {
      [1] = {
        ["x"] = 458.7540979438,
        ["y"] = -149.22729854521,
        ["g"] = 33,
        ["sublevel"] = 1,
      },
    },
  },
  [26] = {
    ["name"] = "Sandswept Marksman",
    ["id"] = 139097,
    ["count"] = 0,
    ["health"] = 439629,
    ["scale"] = 1,
    ["displayId"] = 83780,
    ["creatureType"] = "Humanoid",
    ["level"] = 90,
    ["spells"] = {
      [273225] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 594.82509279125,
        ["y"] = -413.21406021377,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 595.45049930376,
        ["y"] = -379.51061558327,
        ["sublevel"] = 1,
      },
    },
  },
  [27] = {
    ["name"] = "Loose Spark",
    ["id"] = 139108,
    ["count"] = 0,
    ["health"] = 3243255,
    ["scale"] = 1,
    ["displayId"] = 51418,
    ["creatureType"] = "Elemental",
    ["level"] = 90,
    ["spells"] = {
      [267483] = {
      },
      [273241] = {
      },
      [1225638] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 258.76810415329,
        ["y"] = -380.60953728412,
        ["g"] = 36,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 556.42337340258,
        ["y"] = -219.05077055393,
        ["g"] = 28,
        ["sublevel"] = 1,
      },
    },
  },
  [28] = {
    ["name"] = "Polarized Spire",
    ["id"] = 139131,
    ["count"] = 0,
    ["health"] = 10000,
    ["scale"] = 1,
    ["displayId"] = 46710,
    ["creatureType"] = "Elemental",
    ["level"] = 90,
    ["clones"] = {
      [1] = {
        ["x"] = 457.25475314942,
        ["y"] = -139.93082760094,
        ["g"] = 33,
        ["sublevel"] = 1,
      },
    },
  },
  [29] = {
    ["name"] = "Eye of Sethraliss",
    ["id"] = 240681,
    ["count"] = 0,
    ["health"] = 287585,
    ["scale"] = 1,
    ["displayId"] = 169,
    ["creatureType"] = "Not specified",
    ["level"] = 90,
    ["spells"] = {
      [1303596] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 247.40037310624,
        ["y"] = -306.420168722,
        ["g"] = 37,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 187.77771290069,
        ["y"] = -335.18625623107,
        ["g"] = 38,
        ["sublevel"] = 1,
      },
    },
  },
  [30] = {
    ["name"] = "Adderis",
    ["id"] = 262530,
    ["count"] = 0,
    ["health"] = 10135172,
    ["scale"] = 1.5,
    ["displayId"] = 83550,
    ["creatureType"] = "Humanoid",
    ["level"] = 92,
    ["isBoss"] = true,
    ["encounterID"] = 2142,
    ["instanceID"] = 1030,
    ["spells"] = {
      [263425] = {
      },
      [1288092] = {
      },
      [1288235] = {
      },
      [1288428] = {
      },
      [1289229] = {
      },
      [1308738] = {
      },
      [1308740] = {
      },
      [1310311] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 644.7031081657,
        ["y"] = -429.24130790627,
        ["g"] = 11,
        ["sublevel"] = 1,
      },
    },
  },
  [31] = {
    ["name"] = "Aspix",
    ["id"] = 262822,
    ["count"] = 0,
    ["health"] = 10135172,
    ["scale"] = 1.5,
    ["displayId"] = 83552,
    ["creatureType"] = "Humanoid",
    ["level"] = 92,
    ["isBoss"] = true,
    ["encounterID"] = 2142,
    ["instanceID"] = 1030,
    ["spells"] = {
      [1288457] = {
      },
      [1288864] = {
      },
      [1288885] = {
      },
      [1289062] = {
      },
      [1289229] = {
      },
      [1292035] = {
      },
      [1310311] = {
      },
      [1310712] = {
      },
      [1311808] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 645.41878914688,
        ["y"] = -456.22803316419,
        ["g"] = 11,
        ["sublevel"] = 1,
      },
    },
  },
  [32] = {
    ["name"] = "Egg Marker",
    ["id"] = 263181,
    ["count"] = 0,
    ["health"] = 10000,
    ["scale"] = 1,
    ["displayId"] = 55649,
    ["creatureType"] = "Humanoid",
    ["level"] = 91,
    ["spells"] = {
      [1289208] = {
      },
      [1296738] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 429.20388549141,
        ["y"] = -244.46363491517,
        ["g"] = 34,
        ["sublevel"] = 1,
      },
    },
  },
  [33] = {
    ["name"] = "Galvazzt",
    ["id"] = 263658,
    ["count"] = 0,
    ["health"] = 21621699,
    ["scale"] = 2,
    ["displayId"] = 81654,
    ["creatureType"] = "Elemental",
    ["level"] = 92,
    ["isBoss"] = true,
    ["encounterID"] = 2142,
    ["instanceID"] = 1030,
    ["spells"] = {
      [1290531] = {
      },
      [1291815] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 438.34802463012,
        ["y"] = -149.49025339213,
        ["g"] = 33,
        ["sublevel"] = 1,
      },
    },
  },
  [34] = {
    ["name"] = "Swarming Krolusk",
    ["id"] = 264785,
    ["count"] = 0,
    ["health"] = 810814,
    ["scale"] = 1,
    ["displayId"] = 83787,
    ["creatureType"] = "Beast",
    ["level"] = 91,
    ["clones"] = {
      [1] = {
        ["x"] = 641.05885912233,
        ["y"] = -401.4072544671,
        ["g"] = 12,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 500.02297128092,
        ["y"] = -353.30759463758,
        ["g"] = 17,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 504.50114111258,
        ["y"] = -286.26995866714,
        ["g"] = 19,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 464.32821234564,
        ["y"] = -287.41135973956,
        ["g"] = 25,
        ["sublevel"] = 1,
      },
    },
  },
  [35] = {
    ["name"] = "Faithless Tormentor",
    ["id"] = 268317,
    ["count"] = 5,
    ["health"] = 1135139,
    ["scale"] = 1.2,
    ["displayId"] = 80960,
    ["creatureType"] = "Humanoid",
    ["level"] = 90,
    ["spells"] = {
      [1300704] = {
      },
      [1300714] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 84.037263839491,
        ["y"] = -134.18694797909,
        ["g"] = 41,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 75.810868814294,
        ["y"] = -119.39907191376,
        ["g"] = 41,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 98.69434682798,
        ["y"] = -111.89037328116,
        ["g"] = 41,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 104.51533130932,
        ["y"] = -124.30469403003,
        ["g"] = 41,
        ["sublevel"] = 1,
      },
    },
  },
  [36] = {
    ["name"] = "Corrupted Guardian",
    ["id"] = 268344,
    ["count"] = 0,
    ["health"] = 1702709,
    ["scale"] = 1,
    ["displayId"] = 84761,
    ["creatureType"] = "Elemental",
    ["level"] = 91,
    ["spells"] = {
      [1300803] = {
      },
      [1302616] = {
      },
      [1302618] = {
      },
      [1302761] = {
      },
      [1303446] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 142.65397817523,
        ["y"] = -100.86294537789,
        ["g"] = 42,
        ["sublevel"] = 1,
      },
    },
  },
  [37] = {
    ["name"] = "Lifeforce",
    ["id"] = 268364,
    ["count"] = 0,
    ["health"] = 330722,
    ["scale"] = 1,
    ["displayId"] = 169,
    ["creatureType"] = "Not specified",
    ["level"] = 90,
    ["spells"] = {
      [1300871] = {
      },
      [1302826] = {
      },
      [1302897] = {
      },
      [1312214] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 85.034318985311,
        ["y"] = -70.815854869705,
        ["g"] = 44,
        ["sublevel"] = 1,
      },
    },
  },
  [38] = {
    ["name"] = "Essence Defiler",
    ["id"] = 268427,
    ["count"] = 0,
    ["health"] = 4324340,
    ["scale"] = 1,
    ["displayId"] = 84024,
    ["creatureType"] = "Humanoid",
    ["level"] = 91,
    ["spells"] = {
      [1301199] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 132.71438360346,
        ["y"] = -94.579828350229,
        ["g"] = 42,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 153.921152283,
        ["y"] = -96.279070841619,
        ["g"] = 42,
        ["sublevel"] = 1,
      },
    },
  },
  [39] = {
    ["name"] = "Twisted Hexxer",
    ["id"] = 268491,
    ["count"] = 0,
    ["health"] = 2351360,
    ["scale"] = 1,
    ["displayId"] = 84676,
    ["creatureType"] = "Humanoid",
    ["level"] = 91,
    ["spells"] = {
      [1300684] = {
      },
      [1302153] = {
      },
      [1302158] = {
        ["interruptible"] = true,
      },
      [1311964] = {
      },
      [1311979] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 143.25526891455,
        ["y"] = -92.093075639537,
        ["g"] = 42,
        ["sublevel"] = 1,
      },
    },
  },
  [40] = {
    ["name"] = "Faithless Tormentor",
    ["id"] = 268729,
    ["count"] = 0,
    ["health"] = 486488,
    ["scale"] = 1,
    ["displayId"] = 80960,
    ["creatureType"] = "Humanoid",
    ["level"] = 90,
    ["spells"] = {
      [1300704] = {
      },
      [1300714] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 149.57293559817,
        ["y"] = -73.545796505804,
        ["g"] = 43,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 132.95498787325,
        ["y"] = -73.288026202475,
        ["g"] = 43,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 141.15017127267,
        ["y"] = -73.316633269877,
        ["g"] = 43,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 158.29845131035,
        ["y"] = -73.717088636118,
        ["g"] = 43,
        ["sublevel"] = 1,
      },
    },
  },
  [41] = {
    ["name"] = "Spark Channeler",
    ["id"] = 139110,
    ["count"] = 5,
    ["health"] = 972977,
    ["scale"] = 1.7,
    ["displayId"] = 83553,
    ["creatureType"] = "Humanoid",
    ["level"] = 90,
    ["spells"] = {
      [267483] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 242.37012931409,
        ["y"] = -353.12262307195,
        ["g"] = 36,
        ["sublevel"] = 1,
      },
    },
  },
  [42] = {
    ["name"] = "Faithless Conscript",
    ["id"] = 135971,
    ["count"] = 0,
    ["health"] = 648651,
    ["scale"] = 1,
    ["displayId"] = 88179,
    ["creatureType"] = "Humanoid",
    ["level"] = 90,
    ["clones"] = {
      [5] = {
        ["x"] = 135.60362721372,
        ["y"] = -199.76977405999,
        ["g"] = 39,
        ["sublevel"] = 1,
      },
      [6] = {
        ["x"] = 142.41148571327,
        ["y"] = -195.10730748517,
        ["g"] = 39,
        ["sublevel"] = 1,
      },
      [7] = {
        ["x"] = 139.93720380187,
        ["y"] = -206.06275613618,
        ["g"] = 39,
        ["sublevel"] = 1,
      },
      [8] = {
        ["x"] = 147.50301472173,
        ["y"] = -202.70169613932,
        ["g"] = 39,
        ["sublevel"] = 1,
      },
      [9] = {
        ["x"] = 115.54749941273,
        ["y"] = -168.70939246035,
        ["g"] = 40,
        ["sublevel"] = 1,
      },
      [10] = {
        ["x"] = 122.62707727903,
        ["y"] = -163.63207921383,
        ["g"] = 40,
        ["sublevel"] = 1,
      },
      [11] = {
        ["x"] = 119.68079577285,
        ["y"] = -175.31697300458,
        ["g"] = 40,
        ["sublevel"] = 1,
      },
      [12] = {
        ["x"] = 126.93200946703,
        ["y"] = -170.26831173389,
        ["g"] = 40,
        ["sublevel"] = 1,
      },
    },
  },
  [43] = {
    ["name"] = "Snake",
    ["id"] = 263383,
    ["count"] = 0,
    ["health"] = 1081085,
    ["scale"] = 1,
    ["displayId"] = 7409,
    ["creatureType"] = "Beast",
    ["level"] = 90,
    ["clones"] = {
      [1] = {
        ["x"] = 435.04008036524,
        ["y"] = -227.02416390586,
        ["g"] = 34,
        ["sublevel"] = 1,
      },
    },
  },
  [44] = {
    ["name"] = "Lesser Lifeforce",
    ["id"] = 268747,
    ["count"] = 0,
    ["health"] = 10000,
    ["scale"] = 1,
    ["displayId"] = 169,
    ["creatureType"] = "Not specified",
    ["level"] = 90,
    ["clones"] = {
      [1] = {
        ["x"] = 87.787537699566,
        ["y"] = -81.220544244441,
        ["g"] = 44,
        ["sublevel"] = 1,
      },
    },
  },
  [45] = {
    ["name"] = "Temple Disruptor",
    ["id"] = 269227,
    ["count"] = 5,
    ["health"] = 1945953,
    ["scale"] = 1,
    ["displayId"] = 80961,
    ["creatureType"] = "Humanoid",
    ["level"] = 90,
    ["clones"] = {
      [1] = {
        ["x"] = 241.541494195,
        ["y"] = -295.02362461277,
        ["g"] = 37,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 253.83981293843,
        ["y"] = -317.31924882206,
        ["g"] = 37,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 192.69788631228,
        ["y"] = -346.55294573702,
        ["g"] = 38,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 181.22753423832,
        ["y"] = -322.65403718269,
        ["g"] = 38,
        ["sublevel"] = 1,
      },
    },
  },
};
