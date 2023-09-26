local MDT = MDT
local L = MDT.L
local dungeonIndex = 17
MDT.dungeonList[dungeonIndex] = L["Kings' Rest"]

local zones = { 1004 }
for _, zone in ipairs(zones) do
  MDT.zoneIdToDungeonIdx[zone] = dungeonIndex
end

MDT.dungeonTotalCount[dungeonIndex] = { normal = 246, teeming = 286, teemingEnabled = true }

MDT.dungeonMaps[dungeonIndex] = {
  [0] = "KingsRest",
  [1] = "KingsRest1_"
}
MDT.dungeonSubLevels[dungeonIndex] = {
  [1] = L["Kings' Rest Sublevel"],
}

MDT.mapPOIs[dungeonIndex] = {
  [1] = {
    [1] = {
      ["template"] = "DeathReleasePinTemplate",
      ["type"] = "graveyard",
      ["x"] = 727.18161266836,
      ["y"] = -264.6777671764,
      ["graveyardDescription"] = "",
    },
    [2] = {
      ["template"] = "DeathReleasePinTemplate",
      ["type"] = "graveyard",
      ["x"] = 369.133435873,
      ["y"] = -422.22745110791,
      ["graveyardDescription"] = "krGraveyardNote1",
    },
    [3] = {
      ["template"] = "MapLinkPinTemplate",
      ["type"] = "krSpiritGuide",
      ["x"] = 552.83936308858,
      ["y"] = -306.78957025286,
    },
    [4] = {
      ["template"] = "MapLinkPinTemplate",
      ["type"] = "generalNote",
      ["x"] = 375.6062297457,
      ["y"] = -198.38138258562,
      ["difficulty"] = 10,
      ["text"] = "krBrutePatrolNote",
      ["season"] = 3,
      ["weeks"] = {
        [2] = true,
        [5] = true,
        [8] = true,
        [11] = true,
      },
    },
    [5] = {
      ["template"] = "VignettePinTemplate",
      ["type"] = "nyalothaSpire",
      ["x"] = 568.0731143443,
      ["y"] = -310.64989276843,
      ["index"] = 1,
      ["npcId"] = 161124,
      ["tooltipText"] = "Brutal Spire of Ny'alotha",
      ["weeks"] = {
        [1] = true,
        [2] = true,
        [5] = true,
        [6] = true,
        [9] = true,
        [10] = true,
      },
    },
    [6] = {
      ["template"] = "VignettePinTemplate",
      ["type"] = "nyalothaSpire",
      ["x"] = 459.35764362381,
      ["y"] = -438.75572988328,
      ["index"] = 2,
      ["npcId"] = 161243,
      ["tooltipText"] = "Entropic Spire of Ny'alotha",
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
    [7] = {
      ["template"] = "VignettePinTemplate",
      ["type"] = "nyalothaSpire",
      ["x"] = 390.89525129512,
      ["y"] = -162.06623623627,
      ["index"] = 3,
      ["npcId"] = 161241,
      ["tooltipText"] = "Cursed Spire of Ny'alotha",
      ["weeks"] = {
        [1] = true,
        [2] = true,
        [5] = true,
        [6] = true,
        [9] = true,
        [10] = true,
      },
    },
    [8] = {
      ["template"] = "VignettePinTemplate",
      ["type"] = "nyalothaSpire",
      ["x"] = 345.69345482139,
      ["y"] = -162.93317733121,
      ["index"] = 4,
      ["npcId"] = 161244,
      ["tooltipText"] = "Defiled Spire of Ny'alotha",
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
    [9] = {
      ["template"] = "VignettePinTemplate",
      ["type"] = "nyalothaSpire",
      ["x"] = 390.98859151237,
      ["y"] = -161.83545560425,
      ["index"] = 5,
      ["npcId"] = 161124,
      ["tooltipText"] = "Brutal Spire of Ny'alotha",
      ["weeks"] = {
        [3] = true,
        [4] = true,
        [7] = true,
        [8] = true,
        [11] = true,
        [12] = true,
      },
    },
    [10] = {
      ["template"] = "VignettePinTemplate",
      ["type"] = "nyalothaSpire",
      ["x"] = 565.64698565175,
      ["y"] = -312.75780857123,
      ["index"] = 6,
      ["npcId"] = 161241,
      ["tooltipText"] = "Cursed Spire of Ny'alotha",
      ["weeks"] = {
        [3] = true,
        [4] = true,
        [7] = true,
        [8] = true,
        [11] = true,
        [12] = true,
      },
    },
  },
};

MDT.dungeonEnemies[dungeonIndex] = {
  [1] = {
    ["name"] = "Animated Guardian",
    ["id"] = 133935,
    ["count"] = 8,
    ["health"] = 1306442,
    ["scale"] = 1.2,
    ["displayId"] = 83252,
    ["creatureType"] = "Undead",
    ["level"] = 120,
    ["reaping"] = 148716,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [270003] = {
      },
      [270016] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 572.75039865962,
        ["y"] = -254.08941352266,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 572.54582578774,
        ["y"] = -272.04388546541,
        ["sublevel"] = 1,
        ["infested"] = {
          [3] = true,
        },
      },
      [3] = {
        ["x"] = 586.42175363663,
        ["y"] = -333.84661956258,
        ["g"] = 2,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 569.74657333886,
        ["y"] = -347.00519640023,
        ["g"] = 2,
        ["sublevel"] = 1,
      },
    },
  },
  [2] = {
    ["name"] = "Minion of Zul",
    ["id"] = 133943,
    ["count"] = 0,
    ["health"] = 36,
    ["scale"] = 0.6,
    ["displayId"] = 76055,
    ["creatureType"] = "Aberration",
    ["level"] = 120,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Slow"] = true,
    },
    ["spells"] = {
      [269935] = {
      },
      [269936] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 579.55736334838,
        ["y"] = -295.96232708431,
        ["g"] = 1,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 587.77164774499,
        ["y"] = -302.19794887338,
        ["g"] = 1,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 583.44740315553,
        ["y"] = -286.37755813248,
        ["g"] = 1,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 587.33737468746,
        ["y"] = -290.30617913899,
        ["g"] = 1,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 579.96281538326,
        ["y"] = -290.70197655371,
        ["g"] = 1,
        ["sublevel"] = 1,
        ["infested"] = {
          [1] = true,
        },
      },
      [6] = {
        ["x"] = 584.45123295845,
        ["y"] = -294.95855858684,
        ["g"] = 1,
        ["sublevel"] = 1,
      },
      [7] = {
        ["x"] = 590.34887106599,
        ["y"] = -296.15555540325,
        ["g"] = 1,
        ["sublevel"] = 1,
      },
      [8] = {
        ["x"] = 581.93184656812,
        ["y"] = -300.47986122602,
        ["g"] = 1,
        ["sublevel"] = 1,
      },
      [9] = {
        ["x"] = 653.14141056841,
        ["y"] = -380.41696219116,
        ["g"] = 4,
        ["sublevel"] = 1,
      },
      [10] = {
        ["x"] = 654.8721862644,
        ["y"] = -374.84003111977,
        ["g"] = 4,
        ["sublevel"] = 1,
      },
      [11] = {
        ["x"] = 660.44908432399,
        ["y"] = -373.49389241899,
        ["g"] = 4,
        ["sublevel"] = 1,
      },
      [12] = {
        ["x"] = 664.87217043335,
        ["y"] = -377.14772104383,
        ["g"] = 4,
        ["sublevel"] = 1,
      },
      [13] = {
        ["x"] = 658.52601488924,
        ["y"] = -378.68618649517,
        ["g"] = 4,
        ["sublevel"] = 1,
        ["patrol"] = {
          [1] = {
            ["x"] = 658.52601488924,
            ["y"] = -378.68618649517,
          },
          [2] = {
            ["x"] = 659.29522285606,
            ["y"] = -395.03233446118,
          },
          [3] = {
            ["x"] = 652.94908381785,
            ["y"] = -405.41694737239,
          },
          [4] = {
            ["x"] = 631.02599652751,
            ["y"] = -407.34002506008,
          },
          [5] = {
            ["x"] = 615.25677104251,
            ["y"] = -393.30156701813,
          },
          [6] = {
            ["x"] = 614.8721670591,
            ["y"] = -374.45542713636,
          },
          [7] = {
            ["x"] = 626.98753090745,
            ["y"] = -364.84001393902,
          },
          [8] = {
            ["x"] = 641.21830744701,
            ["y"] = -364.0708059722,
          },
          [9] = {
            ["x"] = 652.37215308389,
            ["y"] = -368.10927159225,
          },
        },
      },
      [14] = {
        ["x"] = 662.94908449271,
        ["y"] = -382.14772138125,
        ["g"] = 4,
        ["sublevel"] = 1,
        ["infested"] = {
          [1] = true,
        },
      },
    },
  },
  [3] = {
    ["name"] = "Shadow-Borne Witch Doctor",
    ["id"] = 134174,
    ["count"] = 5,
    ["health"] = 1152741,
    ["scale"] = 1,
    ["displayId"] = 83371,
    ["creatureType"] = "Undead",
    ["level"] = 121,
    ["reaping"] = 148894,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [269972] = {
      },
      [269973] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 644.48115161493,
        ["y"] = -369.15880658614,
        ["g"] = 3,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 613.48433294179,
        ["y"] = -371.99492624218,
        ["g"] = 6,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 625.19654199879,
        ["y"] = -404.14303243834,
        ["g"] = 7,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 649.03882925229,
        ["y"] = -406.66729442915,
        ["g"] = 5,
        ["sublevel"] = 1,
        ["teeming"] = true,
      },
    },
  },
  [4] = {
    ["name"] = "Shadow-Borne Champion",
    ["id"] = 134158,
    ["count"] = 6,
    ["health"] = 1229590,
    ["scale"] = 1.2,
    ["displayId"] = 83364,
    ["creatureType"] = "Undead",
    ["level"] = 121,
    ["reaping"] = 148894,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [269928] = {
      },
      [269976] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 649.17497479225,
        ["y"] = -360.95316686591,
        ["g"] = 3,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 618.80601065983,
        ["y"] = -399.99837265627,
        ["g"] = 7,
        ["sublevel"] = 1,
      },
    },
  },
  [5] = {
    ["name"] = "Shadow-Borne Warrior",
    ["id"] = 134157,
    ["count"] = 4,
    ["health"] = 768494,
    ["scale"] = 1,
    ["displayId"] = 83363,
    ["creatureType"] = "Undead",
    ["level"] = 120,
    ["reaping"] = 148716,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Fear"] = true,
      ["Disorient"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
    },
    ["spells"] = {
      [269931] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 656.98756594381,
        ["y"] = -404.07080041865,
        ["g"] = 5,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 617.28195299766,
        ["y"] = -363.91468550014,
        ["g"] = 6,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 610.96617120592,
        ["y"] = -379.70414562625,
        ["g"] = 6,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 631.06612958635,
        ["y"] = -407.83867796512,
        ["g"] = 7,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 611.11041646257,
        ["y"] = -397.57817954204,
        ["g"] = 7,
        ["sublevel"] = 1,
      },
      [6] = {
        ["x"] = 652.51044131347,
        ["y"] = -396.59727191278,
        ["g"] = 5,
        ["sublevel"] = 1,
      },
    },
  },
  [6] = {
    ["name"] = "The Golden Serpent",
    ["id"] = 135322,
    ["count"] = 0,
    ["health"] = 5379459,
    ["scale"] = 1,
    ["displayId"] = 84202,
    ["creatureType"] = "Elemental",
    ["level"] = 122,
    ["isBoss"] = true,
    ["encounterID"] = 2165,
    ["instanceID"] = 1041,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [265773] = {
      },
      [265781] = {
      },
      [265910] = {
      },
      [265923] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 688.65120787074,
        ["y"] = -372.2704342334,
        ["sublevel"] = 1,
      },
    },
  },
  [7] = {
    ["name"] = "Skeletal Hunting Raptor",
    ["id"] = 137487,
    ["count"] = 4,
    ["health"] = 768494,
    ["scale"] = 0.8,
    ["displayId"] = 33733,
    ["creatureType"] = "Undead",
    ["level"] = 120,
    ["reaping"] = 148716,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [270500] = {
      },
      [270502] = {
      },
      [270503] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 525.57585072102,
        ["y"] = -431.61883843803,
        ["g"] = 8,
        ["sublevel"] = 1,
      },
    },
  },
  [8] = {
    ["name"] = "Queen Patlaa",
    ["id"] = 137486,
    ["count"] = 4,
    ["health"] = 1229590,
    ["scale"] = 1,
    ["displayId"] = 85287,
    ["creatureType"] = "Undead",
    ["level"] = 121,
    ["reaping"] = 148894,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [270505] = {
      },
      [270930] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 521.22807855253,
        ["y"] = -426.40147078639,
        ["g"] = 8,
        ["sublevel"] = 1,
        ["infested"] = {
          [3] = true,
        },
      },
    },
  },
  [9] = {
    ["name"] = "King A'akul",
    ["id"] = 137484,
    ["count"] = 6,
    ["health"] = 1998085,
    ["scale"] = 1,
    ["displayId"] = 85284,
    ["creatureType"] = "Undead",
    ["level"] = 121,
    ["reaping"] = 148894,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [270865] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 521.56865290318,
        ["y"] = -457.6983857759,
        ["g"] = 9,
        ["sublevel"] = 1,
      },
    },
  },
  [10] = {
    ["name"] = "Bloodsworn Agent",
    ["id"] = 137485,
    ["count"] = 4,
    ["health"] = 768494,
    ["scale"] = 0.7,
    ["displayId"] = 85285,
    ["creatureType"] = "Undead",
    ["level"] = 120,
    ["reaping"] = 148716,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Disorient"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
    },
    ["spells"] = {
      [270872] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 514.43224899307,
        ["y"] = -460.34119353936,
        ["g"] = 9,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 514.88000326111,
        ["y"] = -452.87850497532,
        ["g"] = 9,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 527.69851004025,
        ["y"] = -452.52344758657,
        ["g"] = 9,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 528.1635677677,
        ["y"] = -459.59492148032,
        ["g"] = 9,
        ["sublevel"] = 1,
        ["infested"] = {
          [2] = true,
        },
      },
      [5] = {
        ["x"] = 521.59986789148,
        ["y"] = -448.86805921663,
        ["g"] = 9,
        ["sublevel"] = 1,
        ["teeming"] = true,
      },
    },
  },
  [11] = {
    ["name"] = "Seneschal M'bara",
    ["id"] = 134251,
    ["count"] = 4,
    ["health"] = 768494,
    ["scale"] = 1,
    ["displayId"] = 83517,
    ["creatureType"] = "Undead",
    ["level"] = 120,
    ["reaping"] = 148893,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [270901] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 540.62439938763,
        ["y"] = -455.83555927438,
        ["g"] = 10,
        ["sublevel"] = 1,
      },
    },
  },
  [12] = {
    ["name"] = "Guard Captain Atu",
    ["id"] = 137473,
    ["count"] = 4,
    ["health"] = 1248802,
    ["scale"] = 1,
    ["displayId"] = 85270,
    ["creatureType"] = "Undead",
    ["level"] = 120,
    ["reaping"] = 148716,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Disorient"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
    },
    ["spells"] = {
      [270084] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 554.1015139403,
        ["y"] = -455.06108904006,
        ["g"] = 10,
        ["sublevel"] = 1,
        ["infested"] = {
          [2] = true,
        },
      },
    },
  },
  [13] = {
    ["name"] = "King Rahu'ai",
    ["id"] = 134331,
    ["count"] = 6,
    ["health"] = 1229590,
    ["scale"] = 1,
    ["displayId"] = 83544,
    ["creatureType"] = "Undead",
    ["level"] = 121,
    ["reaping"] = 148894,
    ["spells"] = {
      [270889] = {
      },
      [270891] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 548.0568362321,
        ["y"] = -459.67649699281,
        ["g"] = 10,
        ["sublevel"] = 1,
      },
    },
  },
  [14] = {
    ["name"] = "King Timalji",
    ["id"] = 137474,
    ["count"] = 6,
    ["health"] = 1229590,
    ["scale"] = 1,
    ["displayId"] = 85272,
    ["creatureType"] = "Undead",
    ["level"] = 121,
    ["reaping"] = 148894,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [270927] = {
      },
      [270928] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 544.60908072961,
        ["y"] = -430.9731833347,
        ["g"] = 11,
        ["sublevel"] = 1,
        ["infested"] = {
          [3] = true,
        },
      },
    },
  },
  [15] = {
    ["name"] = "Queen Wasi",
    ["id"] = 137478,
    ["count"] = 6,
    ["health"] = 1229590,
    ["scale"] = 1,
    ["displayId"] = 85274,
    ["creatureType"] = "Undead",
    ["level"] = 121,
    ["reaping"] = 148894,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [589] = {
      },
      [5116] = {
      },
      [186439] = {
      },
      [212792] = {
      },
      [270920] = {
      },
      [270923] = {
      },
      [280404] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 548.07059910979,
        ["y"] = -425.39626051626,
        ["g"] = 11,
        ["sublevel"] = 1,
      },
    },
  },
  [16] = {
    ["name"] = "Purification Construct",
    ["id"] = 134739,
    ["count"] = 10,
    ["health"] = 1844388,
    ["scale"] = 1.2,
    ["displayId"] = 83836,
    ["creatureType"] = "Undead",
    ["level"] = 120,
    ["reaping"] = 148894,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [270284] = {
      },
      [270293] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 454.58731500022,
        ["y"] = -291.32358838882,
        ["g"] = 26,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 435.79581678115,
        ["y"] = -154.52287652609,
        ["sublevel"] = 1,
        ["teeming"] = true,
        ["patrol"] = {
          [1] = {
            ["x"] = 435.79581678115,
            ["y"] = -154.52287652609,
          },
          [2] = {
            ["x"] = 448.56290445001,
            ["y"] = -165.52340305175,
          },
          [3] = {
            ["x"] = 480.1013389141,
            ["y"] = -168.21570521217,
          },
          [4] = {
            ["x"] = 448.56290445001,
            ["y"] = -165.52340305175,
          },
          [5] = {
            ["x"] = 435.79581678115,
            ["y"] = -154.52287652609,
          },
          [6] = {
            ["x"] = 431.0685438846,
            ["y"] = -140.15923724727,
          },
          [7] = {
            ["x"] = 429.56321964007,
            ["y"] = -127.66456407374,
          },
          [8] = {
            ["x"] = 440.14015104888,
            ["y"] = -120.54920056281,
          },
          [9] = {
            ["x"] = 441.29397950501,
            ["y"] = -103.43379511228,
          },
          [10] = {
            ["x"] = 440.14015104888,
            ["y"] = -120.54920056281,
          },
          [11] = {
            ["x"] = 429.56321964007,
            ["y"] = -127.66456407374,
          },
          [12] = {
            ["x"] = 431.0685438846,
            ["y"] = -140.15923724727,
          },
        },
      },
    },
  },
  [17] = {
    ["name"] = "Interment Construct",
    ["id"] = 137969,
    ["count"] = 6,
    ["health"] = 1536988,
    ["scale"] = 1,
    ["displayId"] = 85677,
    ["creatureType"] = "Undead",
    ["level"] = 120,
    ["reaping"] = 148894,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [271555] = {
      },
      [271561] = {
      },
      [271562] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 489.18748663995,
        ["y"] = -154.42099320188,
        ["sublevel"] = 1,
        ["infested"] = {
          [3] = true,
        },
      },
      [2] = {
        ["x"] = 427.55797998268,
        ["y"] = -108.54318222106,
        ["sublevel"] = 1,
      },
    },
  },
  [18] = {
    ["name"] = "Mchimba the Embalmer",
    ["id"] = 134993,
    ["count"] = 0,
    ["health"] = 5379459,
    ["scale"] = 1,
    ["displayId"] = 83529,
    ["creatureType"] = "Mechanical",
    ["level"] = 122,
    ["isBoss"] = true,
    ["encounterID"] = 2171,
    ["instanceID"] = 1041,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [267618] = {
      },
      [267639] = {
      },
      [267702] = {
      },
      [271290] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 458.30808870121,
        ["y"] = -137.93607693106,
        ["sublevel"] = 1,
      },
    },
  },
  [19] = {
    ["name"] = "Spectral Hex Priest",
    ["id"] = 135204,
    ["count"] = 4,
    ["health"] = 691644,
    ["scale"] = 1,
    ["displayId"] = 84140,
    ["creatureType"] = "Undead",
    ["level"] = 120,
    ["reaping"] = 148893,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Incapacitate"] = true,
      ["Silence"] = true,
      ["Shackle Undead"] = true,
      ["Disorient"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
    },
    ["spells"] = {
      [270492] = {
      },
      [270493] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 360.49068890929,
        ["y"] = -108.4239891806,
        ["g"] = 12,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 377.3998325625,
        ["y"] = -108.64218956602,
        ["g"] = 12,
        ["sublevel"] = 1,
        ["infested"] = {
          [2] = true,
        },
      },
      [3] = {
        ["x"] = 363.8363702754,
        ["y"] = -221.4358842164,
        ["g"] = 15,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 372.54227536014,
        ["y"] = -265.35726521035,
        ["g"] = 16,
        ["sublevel"] = 1,
        ["infested"] = {
          [2] = true,
        },
      },
      [5] = {
        ["x"] = 361.2857550291,
        ["y"] = -304.8006780133,
        ["g"] = 17,
        ["sublevel"] = 1,
      },
    },
  },
  [20] = {
    ["name"] = "Spectral Berserker",
    ["id"] = 135167,
    ["count"] = 4,
    ["health"] = 922193,
    ["scale"] = 1,
    ["displayId"] = 84112,
    ["creatureType"] = "Undead",
    ["level"] = 121,
    ["reaping"] = 148894,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Incapacitate"] = true,
      ["Silence"] = true,
      ["Shackle Undead"] = true,
      ["Root"] = true,
      ["Disorient"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
    },
    ["spells"] = {
      [270482] = {
      },
      [270485] = {
      },
      [270487] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 364.63621221091,
        ["y"] = -115.69673076676,
        ["g"] = 12,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 375.20441685604,
        ["y"] = -148.52496076889,
        ["g"] = 13,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 373.25945672219,
        ["y"] = -218.35896156667,
        ["g"] = 15,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 367.75409053435,
        ["y"] = -323.47662382868,
        ["g"] = 27,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 362.25927403815,
        ["y"] = -343.70848580739,
        ["g"] = 29,
        ["sublevel"] = 1,
      },
      [6] = {
        ["x"] = 374.09595637265,
        ["y"] = -343.91254388122,
        ["g"] = 18,
        ["sublevel"] = 1,
      },
    },
  },
  [21] = {
    ["name"] = "Spectral Witch Doctor",
    ["id"] = 135239,
    ["count"] = 4,
    ["health"] = 768494,
    ["scale"] = 1,
    ["displayId"] = 84163,
    ["creatureType"] = "Undead",
    ["level"] = 120,
    ["reaping"] = 148893,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Silence"] = true,
      ["Disorient"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
    },
    ["spells"] = {
      [205276] = {
      },
      [270497] = {
      },
      [270499] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 362.30121150729,
        ["y"] = -148.20237578989,
        ["g"] = 13,
        ["sublevel"] = 1,
        ["infested"] = {
          [3] = true,
        },
      },
      [2] = {
        ["x"] = 363.06714580268,
        ["y"] = -214.51280619128,
        ["g"] = 15,
        ["sublevel"] = 1,
        ["infested"] = {
          [1] = true,
        },
      },
      [3] = {
        ["x"] = 374.79926462779,
        ["y"] = -305.34123741919,
        ["g"] = 28,
        ["sublevel"] = 1,
        ["infested"] = {
          [2] = true,
        },
      },
      [4] = {
        ["x"] = 373.41261882941,
        ["y"] = -115.89776031762,
        ["g"] = 12,
        ["sublevel"] = 1,
        ["teeming"] = true,
      },
    },
  },
  [22] = {
    ["name"] = "Spectral Brute",
    ["id"] = 135231,
    ["count"] = 8,
    ["health"] = 1536988,
    ["scale"] = 1,
    ["displayId"] = 85125,
    ["creatureType"] = "Undead",
    ["level"] = 121,
    ["reaping"] = 148894,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [270514] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 368.59110920942,
        ["y"] = -197.3859907164,
        ["sublevel"] = 1,
        ["patrol"] = {
          [1] = {
            ["x"] = 368.59110920942,
            ["y"] = -197.3859907164,
          },
          [2] = {
            ["x"] = 368.59110920942,
            ["y"] = -182.76004846191,
          },
          [3] = {
            ["x"] = 368.59110920942,
            ["y"] = -168.0541335897,
          },
          [4] = {
            ["x"] = 368.59110920942,
            ["y"] = -154.23062132159,
          },
          [5] = {
            ["x"] = 368.59110920942,
            ["y"] = -168.0541335897,
          },
          [6] = {
            ["x"] = 368.59110920942,
            ["y"] = -182.76004846191,
          },
          [7] = {
            ["x"] = 368.59110920942,
            ["y"] = -197.3859907164,
          },
          [8] = {
            ["x"] = 368.59110920942,
            ["y"] = -211.87768089417,
          },
          [9] = {
            ["x"] = 368.59110920942,
            ["y"] = -233.34826586652,
          },
          [10] = {
            ["x"] = 368.59110920942,
            ["y"] = -249.52475076828,
          },
          [11] = {
            ["x"] = 368.59110920942,
            ["y"] = -265.11729441018,
          },
          [12] = {
            ["x"] = 368.59110920942,
            ["y"] = -279.95599464804,
          },
          [13] = {
            ["x"] = 368.59110920942,
            ["y"] = -294.79470872956,
          },
          [14] = {
            ["x"] = 368.59110920942,
            ["y"] = -308.9882529027,
          },
          [15] = {
            ["x"] = 368.59110920942,
            ["y"] = -294.79470872956,
          },
          [16] = {
            ["x"] = 368.59110920942,
            ["y"] = -279.95599464804,
          },
          [17] = {
            ["x"] = 368.59110920942,
            ["y"] = -265.11729441018,
          },
          [18] = {
            ["x"] = 368.59110920942,
            ["y"] = -249.52475076828,
          },
          [19] = {
            ["x"] = 368.59110920942,
            ["y"] = -233.34826586652,
          },
          [20] = {
            ["x"] = 368.59110920942,
            ["y"] = -211.87768089417,
          },
        },
      },
      [2] = {
        ["x"] = 369.03194027949,
        ["y"] = -128.69513926384,
        ["sublevel"] = 1,
        ["teeming"] = true,
        ["patrol"] = {
        },
      },
    },
  },
  [23] = {
    ["name"] = "Spectral Beastmaster",
    ["id"] = 135235,
    ["count"] = 4,
    ["health"] = 730070,
    ["scale"] = 1,
    ["displayId"] = 84112,
    ["creatureType"] = "Undead",
    ["level"] = 120,
    ["reaping"] = 148716,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Silence"] = true,
      ["Shackle Undead"] = true,
      ["Disorient"] = true,
      ["Stun"] = true,
    },
    ["spells"] = {
      [270505] = {
      },
      [270506] = {
      },
      [270507] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 367.80611402575,
        ["y"] = -175.70361086042,
        ["g"] = 14,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 364.46537713183,
        ["y"] = -269.58804107506,
        ["g"] = 16,
        ["sublevel"] = 1,
      },
    },
  },
  [24] = {
    ["name"] = "Honored Raptor",
    ["id"] = 135192,
    ["count"] = 4,
    ["health"] = 768494,
    ["scale"] = 1,
    ["displayId"] = 84133,
    ["creatureType"] = "Undead",
    ["level"] = 120,
    ["reaping"] = 148716,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Disorient"] = true,
      ["Stun"] = true,
    },
    ["spells"] = {
      [270500] = {
      },
      [270502] = {
      },
      [270503] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 360.12370439013,
        ["y"] = -171.65071910507,
        ["g"] = 14,
        ["sublevel"] = 1,
        ["infested"] = {
        },
      },
      [2] = {
        ["x"] = 374.48196559793,
        ["y"] = -171.9096211427,
        ["g"] = 14,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 364.12400057492,
        ["y"] = -260.40448798552,
        ["g"] = 16,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 361.1921892781,
        ["y"] = -319.65113478992,
        ["g"] = 27,
        ["sublevel"] = 1,
        ["teeming"] = true,
      },
    },
  },
  [25] = {
    ["name"] = "Spectral Headhunter",
    ["id"] = 134994,
    ["count"] = 1,
    ["health"] = 249760,
    ["scale"] = 1,
    ["displayId"] = 84026,
    ["creatureType"] = "Undead",
    ["level"] = 120,
    ["reaping"] = 148716,
    ["characteristics"] = {
      ["Silence"] = true,
      ["Disorient"] = true,
      ["Stun"] = true,
    },
    ["clones"] = {
      [1] = {
        ["x"] = 374.52899072422,
        ["y"] = -313.17907623408,
        ["g"] = 28,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 360.74523041944,
        ["y"] = -312.90879073176,
        ["g"] = 17,
        ["sublevel"] = 1,
      },
    },
  },
  [26] = {
    ["name"] = "Zanazal the Wise",
    ["id"] = 135472,
    ["count"] = 0,
    ["health"] = 2766579,
    ["scale"] = 1,
    ["displayId"] = 84271,
    ["creatureType"] = "Undead",
    ["level"] = 122,
    ["isBoss"] = true,
    ["encounterID"] = 2170,
    ["instanceID"] = 1041,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [267060] = {
      },
      [267273] = {
      },
      [267308] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 368.54412153426,
        ["y"] = -452.64135913698,
        ["g"] = 19,
        ["sublevel"] = 1,
      },
    },
  },
  [27] = {
    ["name"] = "Kula the Butcher",
    ["id"] = 135475,
    ["count"] = 0,
    ["health"] = 2766579,
    ["scale"] = 1,
    ["displayId"] = 84272,
    ["creatureType"] = "Undead",
    ["level"] = 122,
    ["isBoss"] = true,
    ["encounterID"] = 2170,
    ["instanceID"] = 1041,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [266206] = {
      },
      [266231] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 392.4457697218,
        ["y"] = -443.23180510135,
        ["g"] = 19,
        ["sublevel"] = 1,
      },
    },
  },
  [28] = {
    ["name"] = "Aka'ali the Conqueror",
    ["id"] = 135470,
    ["count"] = 0,
    ["health"] = 2766579,
    ["scale"] = 1,
    ["displayId"] = 84269,
    ["creatureType"] = "Undead",
    ["level"] = 122,
    ["isBoss"] = true,
    ["encounterID"] = 2170,
    ["instanceID"] = 1041,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [266237] = {
      },
      [266939] = {
      },
      [266940] = {
      },
      [266951] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 344.87061736905,
        ["y"] = -443.04952612989,
        ["g"] = 19,
        ["sublevel"] = 1,
      },
    },
  },
  [29] = {
    ["name"] = "Shadow of Zul",
    ["id"] = 138489,
    ["count"] = 8,
    ["health"] = 2612880,
    ["scale"] = 1.2,
    ["displayId"] = 85860,
    ["creatureType"] = "Humanoid",
    ["level"] = -1,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [271640] = {
      },
      [272388] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 248.16149326946,
        ["y"] = -265.0199630942,
        ["sublevel"] = 1,
      },
    },
  },
  [30] = {
    ["name"] = "King Dazar",
    ["id"] = 136160,
    ["count"] = 0,
    ["health"] = 5994255,
    ["scale"] = 1,
    ["displayId"] = 84352,
    ["creatureType"] = "Undead",
    ["level"] = 122,
    ["isBoss"] = true,
    ["encounterID"] = 2172,
    ["instanceID"] = 1041,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [268403] = {
      },
      [268586] = {
      },
      [268587] = {
      },
      [268589] = {
      },
      [268590] = {
      },
      [268591] = {
      },
      [268932] = {
      },
      [268936] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 138.54486286561,
        ["y"] = -264.67742362195,
        ["sublevel"] = 1,
      },
    },
  },
  [31] = {
    ["name"] = "Embalming Fluid",
    ["id"] = 137989,
    ["count"] = 1,
    ["health"] = 461096,
    ["scale"] = 0.7,
    ["displayId"] = 33008,
    ["creatureType"] = "Aberration",
    ["level"] = 120,
    ["reaping"] = 148716,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Silence"] = true,
      ["Root"] = true,
      ["Disorient"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
    },
    ["spells"] = {
      [271563] = {
      },
      [271565] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 430.10136855165,
        ["y"] = -150.52339378653,
        ["g"] = 20,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 441.25521418853,
        ["y"] = -151.4849450098,
        ["g"] = 20,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 439.33214475378,
        ["y"] = -160.71570470603,
        ["g"] = 20,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 431.83212774174,
        ["y"] = -163.40800686645,
        ["g"] = 20,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 428.17379966119,
        ["y"] = -157.12851357868,
        ["g"] = 20,
        ["sublevel"] = 1,
        ["infested"] = {
          [1] = true,
        },
      },
      [6] = {
        ["x"] = 454.6196161264,
        ["y"] = -172.59592291074,
        ["g"] = 21,
        ["sublevel"] = 1,
      },
      [7] = {
        ["x"] = 459.85519814966,
        ["y"] = -173.95538022775,
        ["g"] = 21,
        ["sublevel"] = 1,
        ["infested"] = {
          [1] = true,
        },
      },
      [8] = {
        ["x"] = 420.42490764921,
        ["y"] = -170.1560238531,
        ["g"] = 22,
        ["sublevel"] = 1,
        ["infested"] = {
          [1] = true,
        },
      },
      [9] = {
        ["x"] = 423.44816403468,
        ["y"] = -174.57461782382,
        ["g"] = 22,
        ["sublevel"] = 1,
      },
      [10] = {
        ["x"] = 416.82675422692,
        ["y"] = -138.10193453494,
        ["g"] = 23,
        ["sublevel"] = 1,
      },
      [11] = {
        ["x"] = 421.6093707841,
        ["y"] = -138.10193453494,
        ["g"] = 23,
        ["sublevel"] = 1,
      },
      [12] = {
        ["x"] = 418.78328342278,
        ["y"] = -143.31932084543,
        ["g"] = 23,
        ["sublevel"] = 1,
      },
      [13] = {
        ["x"] = 424.85164060479,
        ["y"] = -118.6855326393,
        ["g"] = 24,
        ["sublevel"] = 1,
      },
      [14] = {
        ["x"] = 425.90427466792,
        ["y"] = -123.42238592338,
        ["g"] = 24,
        ["sublevel"] = 1,
      },
      [15] = {
        ["x"] = 440.64111767117,
        ["y"] = -114.8697553358,
        ["g"] = 25,
        ["sublevel"] = 1,
      },
      [16] = {
        ["x"] = 445.24638463891,
        ["y"] = -112.23817582473,
        ["g"] = 25,
        ["sublevel"] = 1,
      },
      [17] = {
        ["x"] = 445.37796530849,
        ["y"] = -118.42239388716,
        ["g"] = 25,
        ["sublevel"] = 1,
      },
    },
  },
  [32] = {
    ["name"] = "Emissary of the Tides",
    ["id"] = 155434,
    ["count"] = 4,
    ["health"] = 614795,
    ["ignoreFortified"] = true,
    ["scale"] = 1,
    ["displayId"] = 39391,
    ["iconTexture"] = 132315,
    ["creatureType"] = "Humanoid",
    ["level"] = 120,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [302415] = {
      },
      [302417] = {
      },
      [302418] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 573.58830584234,
        ["y"] = -263.96196757677,
        ["sublevel"] = 1,
        ["week"] = {
          [1] = true,
          [4] = true,
          [7] = true,
          [10] = true,
        },
      },
      [2] = {
        ["x"] = 620.55387128066,
        ["y"] = -378.11899619221,
        ["g"] = 6,
        ["sublevel"] = 1,
        ["week"] = {
          [1] = true,
          [4] = true,
          [7] = true,
          [10] = true,
        },
      },
      [3] = {
        ["x"] = 489.26017958649,
        ["y"] = -162.18514473695,
        ["sublevel"] = 1,
        ["week"] = {
          [1] = true,
          [4] = true,
          [7] = true,
          [10] = true,
        },
      },
      [4] = {
        ["x"] = 631.12951027323,
        ["y"] = -401.35554852597,
        ["g"] = 7,
        ["sublevel"] = 1,
        ["week"] = {
          [2] = true,
          [5] = true,
          [8] = true,
          [11] = true,
        },
      },
      [5] = {
        ["x"] = 424.88018291585,
        ["y"] = -153.89003453024,
        ["g"] = 20,
        ["sublevel"] = 1,
        ["week"] = {
          [2] = true,
          [5] = true,
          [8] = true,
          [11] = true,
        },
      },
      [6] = {
        ["x"] = 431.37204617622,
        ["y"] = -120.78625165462,
        ["g"] = 24,
        ["sublevel"] = 1,
        ["week"] = {
          [2] = true,
          [5] = true,
          [8] = true,
          [11] = true,
        },
      },
      [7] = {
        ["x"] = 368.44350476612,
        ["y"] = -153.47506553655,
        ["g"] = 13,
        ["sublevel"] = 1,
        ["week"] = {
          [2] = true,
          [5] = true,
          [8] = true,
          [11] = true,
        },
      },
      [8] = {
        ["x"] = 367.09589952478,
        ["y"] = -309.58912302964,
        ["g"] = 17,
        ["sublevel"] = 1,
        ["week"] = {
          [2] = true,
          [5] = true,
          [8] = true,
          [11] = true,
        },
      },
      [9] = {
        ["x"] = 642.63590145335,
        ["y"] = -377.49360765391,
        ["g"] = 3,
        ["sublevel"] = 1,
        ["week"] = {
          [3] = true,
          [6] = true,
          [9] = true,
          [12] = true,
        },
      },
      [10] = {
        ["x"] = 370.48688454397,
        ["y"] = -121.65053897829,
        ["g"] = 12,
        ["sublevel"] = 1,
        ["week"] = {
          [3] = true,
          [6] = true,
          [9] = true,
          [12] = true,
        },
      },
    },
  },
  [33] = {
    ["name"] = "Void-Touched Emissary",
    ["id"] = 155433,
    ["count"] = 4,
    ["health"] = 999042,
    ["ignoreFortified"] = true,
    ["scale"] = 1,
    ["stealthDetect"] = true,
    ["displayId"] = 39391,
    ["iconTexture"] = 132886,
    ["creatureType"] = "Humanoid",
    ["level"] = 122,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [302415] = {
      },
      [302419] = {
      },
      [302420] = {
      },
      [302421] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 577.539068238,
        ["y"] = -339.95924999324,
        ["g"] = 2,
        ["sublevel"] = 1,
        ["week"] = {
          [1] = true,
          [4] = true,
          [7] = true,
          [10] = true,
        },
      },
      [2] = {
        ["x"] = 643.81477117504,
        ["y"] = -398.33641900168,
        ["g"] = 30,
        ["sublevel"] = 1,
        ["week"] = {
          [1] = true,
          [4] = true,
          [7] = true,
          [10] = true,
        },
      },
      [3] = {
        ["x"] = 555.46722764017,
        ["y"] = -440.16276125782,
        ["g"] = 31,
        ["sublevel"] = 1,
        ["week"] = {
          [1] = true,
          [4] = true,
          [7] = true,
          [10] = true,
        },
      },
      [4] = {
        ["x"] = 446.75960982379,
        ["y"] = -291.65149273687,
        ["g"] = 26,
        ["sublevel"] = 1,
        ["week"] = {
          [1] = true,
          [4] = true,
          [7] = true,
          [10] = true,
        },
      },
      [5] = {
        ["x"] = 367.50647674627,
        ["y"] = -308.96994028012,
        ["g"] = 17,
        ["sublevel"] = 1,
        ["week"] = {
          [1] = true,
          [4] = true,
          [7] = true,
          [10] = true,
        },
      },
      [6] = {
        ["x"] = 579.17054506483,
        ["y"] = -279.88172112194,
        ["sublevel"] = 1,
        ["week"] = {
          [2] = true,
          [5] = true,
          [8] = true,
          [11] = true,
        },
      },
      [7] = {
        ["x"] = 185.65384202478,
        ["y"] = -264.31044066847,
        ["g"] = 33,
        ["sublevel"] = 1,
        ["week"] = {
          [2] = true,
          [5] = true,
          [8] = true,
          [11] = true,
        },
      },
      [8] = {
        ["x"] = 473.11521375575,
        ["y"] = -438.12968280672,
        ["sublevel"] = 1,
        ["week"] = {
          [3] = true,
          [6] = true,
          [9] = true,
          [12] = true,
        },
      },
      [9] = {
        ["x"] = 377.2786561419,
        ["y"] = -180.5994519166,
        ["g"] = 14,
        ["sublevel"] = 1,
        ["week"] = {
          [3] = true,
          [6] = true,
          [9] = true,
          [12] = true,
        },
      },
    },
  },
  [34] = {
    ["name"] = "Enchanted Emissary",
    ["id"] = 155432,
    ["count"] = 4,
    ["health"] = 15369884,
    ["ignoreFortified"] = true,
    ["scale"] = 1,
    ["displayId"] = 39391,
    ["iconTexture"] = 135735,
    ["creatureType"] = "Humanoid",
    ["level"] = 121,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [290027] = {
      },
      [302415] = {
      },
      [303632] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 419.06027599762,
        ["y"] = -108.53521722425,
        ["sublevel"] = 1,
        ["week"] = {
          [1] = true,
          [4] = true,
          [7] = true,
          [10] = true,
        },
      },
      [2] = {
        ["x"] = 368.32929375765,
        ["y"] = -183.59661534911,
        ["g"] = 32,
        ["sublevel"] = 1,
        ["week"] = {
          [1] = true,
          [4] = true,
          [7] = true,
          [10] = true,
        },
      },
      [3] = {
        ["x"] = 463.04496517688,
        ["y"] = -287.80466549342,
        ["g"] = 26,
        ["sublevel"] = 1,
        ["week"] = {
          [2] = true,
          [5] = true,
          [8] = true,
          [11] = true,
        },
      },
      [4] = {
        ["x"] = 368.50715768396,
        ["y"] = -211.58855735877,
        ["g"] = 15,
        ["sublevel"] = 1,
        ["week"] = {
          [2] = true,
          [5] = true,
          [8] = true,
          [11] = true,
        },
      },
      [5] = {
        ["x"] = 576.45345106033,
        ["y"] = -338.35594465097,
        ["sublevel"] = 1,
        ["week"] = {
          [3] = true,
          [6] = true,
          [9] = true,
          [12] = true,
        },
      },
      [6] = {
        ["x"] = 626.20288603485,
        ["y"] = -394.78617143382,
        ["g"] = 7,
        ["sublevel"] = 1,
        ["week"] = {
          [3] = true,
          [6] = true,
          [9] = true,
          [12] = true,
        },
      },
      [7] = {
        ["x"] = 520.77091827461,
        ["y"] = -448.15035264505,
        ["g"] = 9,
        ["sublevel"] = 1,
        ["week"] = {
          [3] = true,
          [6] = true,
          [9] = true,
          [12] = true,
        },
      },
      [8] = {
        ["x"] = 426.08134693695,
        ["y"] = -163.80731621307,
        ["g"] = 20,
        ["sublevel"] = 1,
        ["week"] = {
          [3] = true,
          [6] = true,
          [9] = true,
          [12] = true,
        },
      },
      [9] = {
        ["x"] = 370.03824958997,
        ["y"] = -274.39775206653,
        ["g"] = 16,
        ["sublevel"] = 1,
        ["week"] = {
          [3] = true,
          [6] = true,
          [9] = true,
          [12] = true,
        },
      },
    },
  },
  [35] = {
    ["name"] = "Samh'rek, Beckoner of Chaos",
    ["id"] = 161243,
    ["count"] = 4,
    ["teemingCount"] = 6,
    ["health"] = 2151786,
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
      [314483] = {
      },
      [314531] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 459.84349270362,
        ["y"] = -422.79453664477,
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
  [36] = {
    ["name"] = "Urg'roth, Breaker of Heroes",
    ["id"] = 161124,
    ["count"] = 4,
    ["teemingCount"] = 6,
    ["health"] = 2151786,
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
        ["x"] = 580.50022875902,
        ["y"] = -311.25817129415,
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
        ["x"] = 378.81365320707,
        ["y"] = -160.81941967987,
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
  [37] = {
    ["name"] = "Voidweaver Mal'thir",
    ["id"] = 161241,
    ["count"] = 4,
    ["teemingCount"] = 6,
    ["health"] = 2151786,
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
        ["x"] = 378.65097786114,
        ["y"] = -161.25455404597,
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
        ["x"] = 580.84056838261,
        ["y"] = -311.71985765696,
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
  [38] = {
    ["name"] = "Blood of the Corruptor",
    ["id"] = 161244,
    ["count"] = 4,
    ["teemingCount"] = 6,
    ["health"] = 2151786,
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
        ["x"] = 357.42347908216,
        ["y"] = -161.54845031692,
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
};
