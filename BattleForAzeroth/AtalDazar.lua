local addonName = ...
local MDT = MDT
local L = MDT.L
local dungeonIndex = 15
MDT.dungeonList[dungeonIndex] = L["Atal'Dazar"]

MDT.mapInfo[dungeonIndex] = {
  viewportPositionOverrides = {
    [1] = {
      zoomScale = 1.2999999523163,
      horizontalPan = 136.93725088026,
      verticalPan = 71.585455597386,
    },
  }
};

local zones = { 934, 935 }
for _, zone in ipairs(zones) do
  MDT.zoneIdToDungeonIdx[zone] = dungeonIndex
end

MDT.dungeonMaps[dungeonIndex] = {
  [0] = "",
  [1] = { customTextures = 'AtalDazar' },
}

MDT.dungeonSubLevels[dungeonIndex] = {
  [1] = L["Atal'Dazar Sublevel"],
}

MDT.dungeonTotalCount[dungeonIndex] = { normal = 225, teeming = 237, teemingEnabled = true }
MDT.mapPOIs[dungeonIndex] = {

};

MDT.dungeonEnemies[dungeonIndex] = {
  [1] = {
    ["name"] = "Dazar'ai Honor Guard",
    ["id"] = 127799,
    ["count"] = 4,
    ["health"] = 1481125,
    ["scale"] = 1,
    ["displayId"] = 81326,
    ["creatureType"] = "Humanoid",
    ["level"] = 70,
    ["reaping"] = 148716,
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
      [253548] = {
      },
      [256138] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 578.61472163258,
        ["y"] = -340.4715395664,
        ["g"] = 1,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 586.43339847879,
        ["y"] = -340.83590023072,
        ["g"] = 1,
        ["sublevel"] = 1,
        ["infested"] = {
          [2] = true,
        },
      },
      [3] = {
        ["x"] = 449.43285967335,
        ["y"] = -475.53583066501,
        ["g"] = 10,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 471.16892743739,
        ["y"] = -477.6043721857,
        ["g"] = 10,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 451.81090399163,
        ["y"] = -466.01230157081,
        ["g"] = 10,
        ["sublevel"] = 1,
      },
      [6] = {
        ["x"] = 467.22361490784,
        ["y"] = -361.32331300461,
        ["g"] = 13,
        ["sublevel"] = 1,
        ["infested"] = {
          [3] = true,
        },
      },
      [7] = {
        ["x"] = 453.27009933105,
        ["y"] = -361.09075175024,
        ["g"] = 13,
        ["sublevel"] = 1,
      },
    },
  },
  [2] = {
    ["name"] = "Dazar'ai Juggernaut",
    ["id"] = 122971,
    ["count"] = 4,
    ["health"] = 1703294,
    ["scale"] = 1,
    ["displayId"] = 81325,
    ["creatureType"] = "Humanoid",
    ["level"] = 70,
    ["reaping"] = 148716,
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
      [253239] = {
      },
      [253279] = {
      },
      [253548] = {
      },
      [253654] = {
      },
      [253666] = {
      },
      [255824] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 571.37693269554,
        ["y"] = -334.55451402168,
        ["g"] = 1,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 569.1457495061,
        ["y"] = -360.35580706243,
        ["g"] = 2,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 580.757036442,
        ["y"] = -389.01293552463,
        ["g"] = 3,
        ["sublevel"] = 1,
        ["infested"] = {
          [3] = true,
        },
      },
      [4] = {
        ["x"] = 521.41919375683,
        ["y"] = -387.41420880268,
        ["g"] = 6,
        ["sublevel"] = 1,
        ["patrol"] = {
          [1] = {
            ["x"] = 521.41919375683,
            ["y"] = -387.41420880268,
          },
          [2] = {
            ["x"] = 510.41917459207,
            ["y"] = -387.41420880268,
          },
          [3] = {
            ["x"] = 521.41919375683,
            ["y"] = -387.41420880268,
          },
          [4] = {
            ["x"] = 531.41915655981,
            ["y"] = -387.41420880268,
          },
        },
        ["infested"] = {
          [2] = true,
          [3] = true,
        },
      },
      [5] = {
        ["x"] = 555.83889576925,
        ["y"] = -394.96740325824,
        ["g"] = 5,
        ["sublevel"] = 1,
      },
      [6] = {
        ["x"] = 549.58314368694,
        ["y"] = -423.52378569339,
        ["g"] = 7,
        ["sublevel"] = 1,
      },
      [7] = {
        ["x"] = 573.3331411747,
        ["y"] = -423.02378969901,
        ["g"] = 7,
        ["sublevel"] = 1,
      },
      [8] = {
        ["x"] = 511.096923774,
        ["y"] = -438.62955369067,
        ["g"] = 8,
        ["sublevel"] = 1,
      },
      [9] = {
        ["x"] = 458.09438185492,
        ["y"] = -474.82268196192,
        ["g"] = 10,
        ["sublevel"] = 1,
        ["infested"] = {
          [1] = true,
        },
      },
      [10] = {
        ["x"] = 583.10517722733,
        ["y"] = -364.09809808532,
        ["g"] = 2,
        ["sublevel"] = 1,
        ["teeming"] = true,
      },
    },
  },
  [3] = {
    ["name"] = "Dazar'ai Confessor",
    ["id"] = 122973,
    ["count"] = 4,
    ["health"] = 1184900,
    ["scale"] = 1,
    ["displayId"] = 81330,
    ["creatureType"] = "Humanoid",
    ["level"] = 70,
    ["reaping"] = 148893,
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
      [253517] = {
      },
      [253544] = {
      },
      [253548] = {
      },
      [254974] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 574.5294362209,
        ["y"] = -364.68933932213,
        ["g"] = 2,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 544.00217871958,
        ["y"] = -388.02864926549,
        ["g"] = 5,
        ["sublevel"] = 1,
        ["infested"] = {
          [1] = true,
        },
      },
      [3] = {
        ["x"] = 563.79809777932,
        ["y"] = -388.23273361401,
        ["g"] = 4,
        ["sublevel"] = 1,
        ["patrol"] = {
          [1] = {
            ["x"] = 563.79809777932,
            ["y"] = -388.23273361401,
          },
          [2] = {
            ["x"] = 572.36953531849,
            ["y"] = -388.84496914311,
          },
          [3] = {
            ["x"] = 563.79809777932,
            ["y"] = -388.23273361401,
          },
          [4] = {
            ["x"] = 555.6348289372,
            ["y"] = -387.82455615873,
          },
        },
        ["infested"] = {
          [2] = true,
        },
      },
      [4] = {
        ["x"] = 555.58313853486,
        ["y"] = -428.77377045649,
        ["g"] = 7,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 464.89972142104,
        ["y"] = -476.78090823003,
        ["g"] = 7,
        ["sublevel"] = 1,
        ["teeming"] = true,
      },
      [6] = {
        ["x"] = 557.18566363487,
        ["y"] = -358.12858599382,
        ["g"] = 2,
        ["sublevel"] = 1,
        ["teeming"] = true,
      },
      [7] = {
        ["x"] = 560.95466375897,
        ["y"] = -370.23021977251,
        ["g"] = 31,
        ["sublevel"] = 1,
        ["teeming"] = true,
      },
    },
  },
  [4] = {
    ["name"] = "Dazar'ai Augur",
    ["id"] = 122972,
    ["count"] = 4,
    ["health"] = 1333013,
    ["scale"] = 1,
    ["displayId"] = 81336,
    ["creatureType"] = "Humanoid",
    ["level"] = 70,
    ["reaping"] = 148893,
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
      [253548] = {
      },
      [253562] = {
      },
      [253583] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 562.52943339035,
        ["y"] = -362.32570287386,
        ["g"] = 2,
        ["sublevel"] = 1,
        ["infested"] = {
          [3] = true,
        },
      },
      [2] = {
        ["x"] = 576.50708658301,
        ["y"] = -395.01293037255,
        ["g"] = 3,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 542.36952144787,
        ["y"] = -382.72252626975,
        ["g"] = 5,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 569.08312694269,
        ["y"] = -428.52378855255,
        ["g"] = 7,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 466.23559419455,
        ["y"] = -460.21709589194,
        ["g"] = 10,
        ["sublevel"] = 1,
      },
      [6] = {
        ["x"] = 463.46747125231,
        ["y"] = -367.88206153212,
        ["g"] = 13,
        ["sublevel"] = 1,
      },
      [7] = {
        ["x"] = 456.57091720042,
        ["y"] = -367.88206153212,
        ["g"] = 13,
        ["sublevel"] = 1,
        ["infested"] = {
          [2] = true,
        },
      },
      [8] = {
        ["x"] = 510.78413920208,
        ["y"] = -428.97026817766,
        ["g"] = 8,
        ["sublevel"] = 1,
        ["infested"] = {
          [3] = true,
        },
      },
    },
  },
  [5] = {
    ["name"] = "Dazar'ai Colossus",
    ["id"] = 122984,
    ["count"] = 6,
    ["health"] = 2517913,
    ["scale"] = 1.2,
    ["stealthDetect"] = true,
    ["displayId"] = 80338,
    ["creatureType"] = "Mechanical",
    ["level"] = 71,
    ["reaping"] = 148894,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [254958] = {
      },
      [254959] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 548.90013301827,
        ["y"] = -393.74294095827,
        ["g"] = 5,
        ["sublevel"] = 1,
        ["infested"] = {
          [3] = true,
        },
      },
      [2] = {
        ["x"] = 561.58313338278,
        ["y"] = -429.52379127015,
        ["g"] = 7,
        ["sublevel"] = 1,
        ["infested"] = {
          [3] = true,
        },
      },
      [3] = {
        ["x"] = 555.11356787669,
        ["y"] = -373.5787829515,
        ["g"] = 31,
        ["sublevel"] = 1,
        ["teeming"] = true,
      },
      [4] = {
        ["x"] = 564.97660608983,
        ["y"] = -376.72945455301,
        ["g"] = 31,
        ["sublevel"] = 1,
        ["teeming"] = true,
      },
    },
  },
  [6] = {
    ["name"] = "Gilded Priestess",
    ["id"] = 132126,
    ["count"] = 4,
    ["health"] = 1481125,
    ["scale"] = 1,
    ["displayId"] = 82238,
    ["creatureType"] = "Humanoid",
    ["level"] = 70,
    ["reaping"] = 148893,
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
      [260666] = {
      },
      [260667] = {
      },
      [260668] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 496.19525601954,
        ["y"] = -471.92897904227,
        ["g"] = 9,
        ["sublevel"] = 1,
        ["infested"] = {
          [1] = true,
          [2] = true,
        },
      },
      [2] = {
        ["x"] = 424.18247109914,
        ["y"] = -471.42806939135,
        ["g"] = 11,
        ["sublevel"] = 1,
        ["infested"] = {
          [1] = true,
        },
      },
      [3] = {
        ["x"] = 469.34369791727,
        ["y"] = -467.39473588482,
        ["g"] = 10,
        ["sublevel"] = 1,
        ["infested"] = {
          [2] = true,
        },
      },
      [4] = {
        ["x"] = 455.51742466636,
        ["y"] = -458.80398753301,
        ["g"] = 7,
        ["sublevel"] = 1,
        ["teeming"] = true,
      },
    },
  },
  [7] = {
    ["name"] = "Priestess Alun'za",
    ["id"] = 122967,
    ["count"] = 0,
    ["health"] = 13340185,
    ["scale"] = 1,
    ["displayId"] = 80293,
    ["creatureType"] = "Humanoid",
    ["level"] = 72,
    ["isBoss"] = true,
    ["encounterID"] = 2082,
    ["instanceID"] = 968,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Slow"] = true,
      ["Mind Soothe"] = true,
    },
    ["spells"] = {
      [255575] = {
      },
      [255577] = {
      },
      [255579] = {
      },
      [255581] = {
      },
      [255591] = {
      },
      [255835] = {
      },
      [255836] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 459.78564177319,
        ["y"] = -490.32190350751,
        ["g"] = 12,
        ["sublevel"] = 1,
      },
    },
  },
  [8] = {
    ["name"] = "Shadowblade Stalker",
    ["id"] = 122970,
    ["count"] = 4,
    ["health"] = 1333013,
    ["scale"] = 1,
    ["stealth"] = true,
    ["displayId"] = 84712,
    ["creatureType"] = "Humanoid",
    ["level"] = 70,
    ["reaping"] = 148716,
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
      [252661] = {
      },
      [252666] = {
      },
      [252687] = {
      },
      [252692] = {
      },
      [258653] = {
      },
      [427000] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 578.02832482897,
        ["y"] = -231.02350114891,
        ["g"] = 27,
        ["sublevel"] = 1,
        ["patrol"] = {
          [1] = {
            ["x"] = 578.02832482897,
            ["y"] = -231.02350114891,
          },
          [2] = {
            ["x"] = 578.14683954797,
            ["y"] = -248.42728194054,
          },
          [3] = {
            ["x"] = 578.02832482897,
            ["y"] = -231.02350114891,
          },
          [4] = {
            ["x"] = 578.02832482897,
            ["y"] = -216.52349929465,
          },
        },
        ["infested"] = {
          [2] = true,
        },
      },
      [2] = {
        ["x"] = 527.50945337536,
        ["y"] = -154.04509708006,
        ["g"] = 33,
        ["sublevel"] = 1,
        ["patrol"] = {
          [1] = {
            ["x"] = 527.50945337536,
            ["y"] = -154.04509708006,
          },
          [2] = {
            ["x"] = 528.75949156657,
            ["y"] = -136.0450921515,
          },
          [3] = {
            ["x"] = 527.50945337536,
            ["y"] = -154.04509708006,
          },
          [4] = {
            ["x"] = 509.0095061264,
            ["y"] = -156.79511243617,
          },
        },
        ["infested"] = {
          [1] = true,
        },
      },
      [3] = {
        ["x"] = 463.70050232019,
        ["y"] = -158.03327728621,
        ["g"] = 37,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 454.4505066867,
        ["y"] = -157.53327056299,
        ["g"] = 37,
        ["sublevel"] = 1,
        ["patrol"] = {
          [1] = {
            ["x"] = 454.4505066867,
            ["y"] = -157.53327056299,
          },
          [2] = {
            ["x"] = 454.4505066867,
            ["y"] = -132.78329181531,
          },
          [3] = {
            ["x"] = 454.4505066867,
            ["y"] = -157.53327056299,
          },
          [4] = {
            ["x"] = 454.55408558202,
            ["y"] = -175.39756174872,
          },
        },
        ["infested"] = {
          [2] = true,
        },
      },
      [5] = {
        ["x"] = 465.01085034371,
        ["y"] = -181.07969931314,
        ["g"] = 16,
        ["sublevel"] = 1,
        ["teeming"] = true,
      },
      [6] = {
        ["x"] = 602.77173726801,
        ["y"] = -192.94624716813,
        ["g"] = 29,
        ["sublevel"] = 1,
        ["infested"] = {
          [3] = true,
        },
      },
      [7] = {
        ["x"] = 604.03172802899,
        ["y"] = -201.62274042695,
        ["g"] = 29,
        ["sublevel"] = 1,
      },
      [8] = {
        ["x"] = 456.80837603918,
        ["y"] = -181.06734860891,
        ["g"] = 16,
        ["sublevel"] = 1,
        ["teeming"] = true,
      },
    },
  },
  [9] = {
    ["name"] = "Reanimated Honor Guard",
    ["id"] = 127757,
    ["count"] = 4,
    ["health"] = 1777350,
    ["scale"] = 1.2,
    ["displayId"] = 80376,
    ["creatureType"] = "Undead",
    ["level"] = 70,
    ["reaping"] = 148894,
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
      [255620] = {
      },
      [255626] = {
      },
      [255814] = {
      },
      [256959] = {
      },
      [256960] = {
      },
      [258653] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 578.56400086726,
        ["y"] = -215.73948344478,
        ["g"] = 28,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 574.23850127346,
        ["y"] = -184.24948923845,
        ["g"] = 30,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 545.2773143908,
        ["y"] = -140.01385757439,
        ["g"] = 32,
        ["sublevel"] = 1,
        ["infested"] = {
          [3] = true,
        },
      },
      [4] = {
        ["x"] = 501.09882974782,
        ["y"] = -140.76844685786,
        ["g"] = 34,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 462.27644861407,
        ["y"] = -123.1135872179,
        ["g"] = 35,
        ["sublevel"] = 1,
      },
      [6] = {
        ["x"] = 400.64217991315,
        ["y"] = -156.41043473743,
        ["g"] = 36,
        ["sublevel"] = 1,
      },
      [7] = {
        ["x"] = 407.37687583208,
        ["y"] = -150.08390751555,
        ["g"] = 36,
        ["sublevel"] = 1,
        ["infested"] = {
          [3] = true,
        },
      },
      [8] = {
        ["x"] = 561.68356577468,
        ["y"] = -171.88884800156,
        ["g"] = 29,
        ["sublevel"] = 1,
        ["teeming"] = true,
      },
      [9] = {
        ["x"] = 566.83980318175,
        ["y"] = -159.70134850622,
        ["g"] = 29,
        ["sublevel"] = 1,
        ["teeming"] = true,
      },
    },
  },
  [10] = {
    ["name"] = "Reanimation Totem",
    ["id"] = 127315,
    ["count"] = 0,
    ["health"] = 296225,
    ["scale"] = 0.6,
    ["displayId"] = 82388,
    ["creatureType"] = "Not specified",
    ["level"] = 70,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [258653] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 576.88320070773,
        ["y"] = -208.29627174188,
        ["g"] = 28,
        ["sublevel"] = 1,
        ["infested"] = {
          [1] = true,
        },
      },
      [2] = {
        ["x"] = 579.96481501769,
        ["y"] = -179.23259408681,
        ["g"] = 30,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 546.99606019315,
        ["y"] = -146.57636349237,
        ["g"] = 32,
        ["sublevel"] = 1,
        ["infested"] = {
          [1] = true,
        },
      },
      [4] = {
        ["x"] = 497.18579001496,
        ["y"] = -144.6814772613,
        ["g"] = 34,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 462.49459950946,
        ["y"] = -114.84127652798,
        ["g"] = 35,
        ["sublevel"] = 1,
        ["infested"] = {
          [1] = true,
        },
      },
      [6] = {
        ["x"] = 400.17098249987,
        ["y"] = -148.9670464846,
        ["g"] = 36,
        ["sublevel"] = 1,
        ["infested"] = {
          [1] = true,
        },
      },
      [7] = {
        ["x"] = 562.30854717967,
        ["y"] = -165.01383797006,
        ["g"] = 29,
        ["sublevel"] = 1,
        ["teeming"] = true,
      },
    },
  },
  [11] = {
    ["name"] = "Zanchuli Witch-Doctor",
    ["id"] = 122969,
    ["count"] = 4,
    ["health"] = 1333013,
    ["scale"] = 1,
    ["displayId"] = 80622,
    ["creatureType"] = "Humanoid",
    ["level"] = 70,
    ["reaping"] = 148893,
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
      [252781] = {
      },
      [252923] = {
      },
      [258653] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 580.84316416692,
        ["y"] = -171.21740510255,
        ["g"] = 30,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 544.18354999343,
        ["y"] = -152.51384777223,
        ["g"] = 32,
        ["sublevel"] = 1,
        ["infested"] = {
          [2] = true,
        },
      },
      [3] = {
        ["x"] = 496.53360739672,
        ["y"] = -151.63799856157,
        ["g"] = 34,
        ["sublevel"] = 1,
        ["infested"] = {
          [3] = true,
        },
      },
      [4] = {
        ["x"] = 453.17205018903,
        ["y"] = -115.6661502961,
        ["g"] = 35,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 471.27439968965,
        ["y"] = -114.93283371949,
        ["g"] = 35,
        ["sublevel"] = 1,
      },
      [6] = {
        ["x"] = 456.66551702163,
        ["y"] = -189.21020838642,
        ["g"] = 38,
        ["sublevel"] = 1,
      },
      [7] = {
        ["x"] = 465.59418684662,
        ["y"] = -189.38612741357,
        ["g"] = 38,
        ["sublevel"] = 1,
        ["infested"] = {
          [1] = true,
        },
      },
      [8] = {
        ["x"] = 391.88059332997,
        ["y"] = -151.99984829127,
        ["g"] = 36,
        ["sublevel"] = 1,
      },
      [9] = {
        ["x"] = 557.62105253186,
        ["y"] = -160.7951129036,
        ["g"] = 29,
        ["sublevel"] = 1,
        ["teeming"] = true,
      },
    },
  },
  [12] = {
    ["name"] = "Shieldbearer of Zul",
    ["id"] = 127879,
    ["count"] = 4,
    ["health"] = 1629238,
    ["scale"] = 1,
    ["stealthDetect"] = true,
    ["displayId"] = 80904,
    ["creatureType"] = "Undead",
    ["level"] = 70,
    ["reaping"] = 148716,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Incapacitate"] = true,
      ["Control Undead"] = true,
      ["Silence"] = true,
      ["Knock"] = true,
      ["Grip"] = true,
      ["Shackle Undead"] = true,
      ["Root"] = true,
      ["Banish"] = true,
      ["Disorient"] = true,
      ["Repentance"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
      ["Sleep Walk"] = true,
      ["Turn Evil"] = true,
    },
    ["spells"] = {
      [253721] = {
      },
      [258653] = {
      },
      [273185] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 586.21481682213,
        ["y"] = -180.17009972189,
        ["g"] = 30,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 558.60282725123,
        ["y"] = -168.3479165937,
        ["g"] = 31,
        ["sublevel"] = 1,
        ["infested"] = {
          [2] = true,
        },
      },
      [3] = {
        ["x"] = 552.19391100536,
        ["y"] = -173.09725105056,
        ["g"] = 31,
        ["sublevel"] = 1,
        ["patrol"] = {
          [1] = {
            ["x"] = 551.2148120817,
            ["y"] = -174.07634997422,
          },
          [2] = {
            ["x"] = 559.80855450452,
            ["y"] = -182.67009910256,
          },
          [3] = {
            ["x"] = 565.43354808189,
            ["y"] = -191.10760287966,
          },
          [4] = {
            ["x"] = 559.80855450452,
            ["y"] = -182.67009910256,
          },
          [5] = {
            ["x"] = 551.2148120817,
            ["y"] = -174.07634997422,
          },
          [6] = {
            ["x"] = 542.3085521343,
            ["y"] = -165.32635549463,
          },
          [7] = {
            ["x"] = 535.90231168414,
            ["y"] = -160.63887425787,
          },
          [8] = {
            ["x"] = 542.3085521343,
            ["y"] = -165.32635549463,
          },
        },
      },
      [4] = {
        ["x"] = 552.62105377052,
        ["y"] = -146.26384596779,
        ["g"] = 32,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 509.17478672867,
        ["y"] = -148.96478547959,
        ["g"] = 34,
        ["sublevel"] = 1,
      },
      [6] = {
        ["x"] = 511.22537774386,
        ["y"] = -139.72297834971,
        ["g"] = 34,
        ["sublevel"] = 1,
      },
      [7] = {
        ["x"] = 449.66549873072,
        ["y"] = -181.2102014957,
        ["g"] = 38,
        ["sublevel"] = 1,
      },
      [8] = {
        ["x"] = 473.23693008871,
        ["y"] = -181.06734860891,
        ["g"] = 38,
        ["sublevel"] = 1,
        ["infested"] = {
          [3] = true,
        },
      },
    },
  },
  [13] = {
    ["name"] = "Vol'kaal",
    ["id"] = 122965,
    ["count"] = 0,
    ["health"] = 9338130,
    ["scale"] = 1,
    ["displayId"] = 79453,
    ["creatureType"] = "Undead",
    ["level"] = 72,
    ["isBoss"] = true,
    ["encounterID"] = 2036,
    ["instanceID"] = 968,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [250241] = {
      },
      [250258] = {
      },
      [250259] = {
      },
      [250368] = {
      },
      [250372] = {
      },
      [259572] = {
      },
      [259574] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 459.77354478613,
        ["y"] = -88.199940336495,
        ["g"] = 39,
        ["sublevel"] = 1,
      },
    },
  },
  [14] = {
    ["name"] = "Toxic Saurid",
    ["id"] = 128435,
    ["count"] = 1,
    ["health"] = 296225,
    ["scale"] = 0.6,
    ["displayId"] = 81323,
    ["creatureType"] = "Beast",
    ["level"] = 70,
    ["reaping"] = 148716,
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
      [251187] = {
      },
      [251188] = {
      },
      [255895] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 545.93839826733,
        ["y"] = -278.27607671767,
        ["g"] = 22,
        ["sublevel"] = 1,
        ["infested"] = {
          [1] = true,
        },
      },
      [2] = {
        ["x"] = 541.93834457695,
        ["y"] = -269.07605622663,
        ["g"] = 22,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 545.13838752925,
        ["y"] = -273.07605841859,
        ["g"] = 22,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 540.8758256645,
        ["y"] = -280.48232467856,
        ["g"] = 22,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 536.93215532409,
        ["y"] = -269.25733951273,
        ["g"] = 22,
        ["sublevel"] = 1,
      },
      [6] = {
        ["x"] = 538.62927512276,
        ["y"] = -225.8201414651,
        ["g"] = 23,
        ["sublevel"] = 1,
        ["infested"] = {
          [1] = true,
        },
      },
      [7] = {
        ["x"] = 540.9580492496,
        ["y"] = -230.75165415435,
        ["g"] = 23,
        ["sublevel"] = 1,
      },
      [8] = {
        ["x"] = 546.02652652019,
        ["y"] = -231.2995947831,
        ["g"] = 23,
        ["sublevel"] = 1,
      },
      [9] = {
        ["x"] = 543.83476400519,
        ["y"] = -225.5461593931,
        ["g"] = 23,
        ["sublevel"] = 1,
      },
      [10] = {
        ["x"] = 540.68407305641,
        ["y"] = -219.65575354295,
        ["g"] = 23,
        ["sublevel"] = 1,
      },
      [11] = {
        ["x"] = 493.79757358014,
        ["y"] = -263.78347540154,
        ["g"] = 19,
        ["sublevel"] = 1,
      },
      [12] = {
        ["x"] = 487.79756170913,
        ["y"] = -268.18348296254,
        ["g"] = 19,
        ["sublevel"] = 1,
      },
      [13] = {
        ["x"] = 490.19755959108,
        ["y"] = -272.18346798836,
        ["g"] = 19,
        ["sublevel"] = 1,
      },
      [14] = {
        ["x"] = 493.79757358014,
        ["y"] = -270.18345830931,
        ["g"] = 19,
        ["sublevel"] = 1,
      },
      [15] = {
        ["x"] = 496.53590280593,
        ["y"] = -267.13793528873,
        ["g"] = 19,
        ["sublevel"] = 1,
      },
      [16] = {
        ["x"] = 453.16995680192,
        ["y"] = -242.06262037639,
        ["g"] = 25,
        ["sublevel"] = 1,
        ["infested"] = {
          [1] = true,
        },
      },
      [17] = {
        ["x"] = 459.7608258794,
        ["y"] = -239.28989084622,
        ["g"] = 25,
        ["sublevel"] = 1,
      },
      [18] = {
        ["x"] = 460.26085406029,
        ["y"] = -233.78989199268,
        ["g"] = 25,
        ["sublevel"] = 1,
      },
      [19] = {
        ["x"] = 454.2608377547,
        ["y"] = -237.03988204942,
        ["g"] = 25,
        ["sublevel"] = 1,
      },
      [20] = {
        ["x"] = 455.26085120113,
        ["y"] = -232.78987854625,
        ["g"] = 25,
        ["sublevel"] = 1,
      },
      [21] = {
        ["x"] = 457.60716602951,
        ["y"] = -211.68516075284,
        ["g"] = 26,
        ["sublevel"] = 1,
      },
      [22] = {
        ["x"] = 456.91964751086,
        ["y"] = -200.77891187358,
        ["g"] = 26,
        ["sublevel"] = 1,
      },
      [23] = {
        ["x"] = 461.78897604719,
        ["y"] = -211.82150261936,
        ["g"] = 26,
        ["sublevel"] = 1,
        ["infested"] = {
          [1] = true,
        },
      },
      [24] = {
        ["x"] = 462.82592244389,
        ["y"] = -202.87266463715,
        ["g"] = 26,
        ["sublevel"] = 1,
      },
      [25] = {
        ["x"] = 465.76339716057,
        ["y"] = -207.52890800999,
        ["g"] = 26,
        ["sublevel"] = 1,
      },
      [26] = {
        ["x"] = 454.63721809655,
        ["y"] = -294.97299967774,
        ["g"] = 16,
        ["sublevel"] = 1,
      },
      [27] = {
        ["x"] = 460.32472606329,
        ["y"] = -297.03551529626,
        ["g"] = 16,
        ["sublevel"] = 1,
      },
      [28] = {
        ["x"] = 465.34744074348,
        ["y"] = -299.03552292058,
        ["g"] = 16,
        ["sublevel"] = 1,
      },
      [29] = {
        ["x"] = 455.06537755765,
        ["y"] = -300.13609838494,
        ["g"] = 16,
        ["sublevel"] = 1,
      },
      [30] = {
        ["x"] = 459.95976195897,
        ["y"] = -303.0355123333,
        ["g"] = 16,
        ["sublevel"] = 1,
        ["infested"] = {
          [1] = true,
        },
      },
      [31] = {
        ["x"] = 463.19878438472,
        ["y"] = -331.82209612897,
        ["g"] = 14,
        ["sublevel"] = 1,
      },
      [32] = {
        ["x"] = 457.80149069551,
        ["y"] = -332.18012174767,
        ["g"] = 14,
        ["sublevel"] = 1,
      },
      [33] = {
        ["x"] = 458.28928338004,
        ["y"] = -338.75896507387,
        ["g"] = 14,
        ["sublevel"] = 1,
      },
      [34] = {
        ["x"] = 464.67868434631,
        ["y"] = -337.80760647863,
        ["g"] = 14,
        ["sublevel"] = 1,
      },
      [35] = {
        ["x"] = 445.18547137694,
        ["y"] = -268.26208452665,
        ["g"] = 18,
        ["sublevel"] = 1,
      },
      [36] = {
        ["x"] = 451.22216067239,
        ["y"] = -273.82852661302,
        ["g"] = 18,
        ["sublevel"] = 1,
        ["infested"] = {
          [1] = true,
        },
      },
      [37] = {
        ["x"] = 451.37864912354,
        ["y"] = -268.62646774458,
        ["g"] = 18,
        ["sublevel"] = 1,
      },
      [38] = {
        ["x"] = 445.69451207359,
        ["y"] = -273.72787878436,
        ["g"] = 18,
        ["sublevel"] = 1,
      },
    },
  },
  [15] = {
    ["name"] = "Feasting Skyscreamer",
    ["id"] = 128434,
    ["count"] = 4,
    ["health"] = 1481125,
    ["scale"] = 1,
    ["displayId"] = 76913,
    ["creatureType"] = "Beast",
    ["level"] = 70,
    ["reaping"] = 148716,
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
      [255041] = {
      },
      [258653] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 489.90350388003,
        ["y"] = -279.9216087774,
        ["g"] = 19,
        ["sublevel"] = 1,
        ["infested"] = {
          [2] = true,
        },
      },
      [2] = {
        ["x"] = 527.88395942802,
        ["y"] = -334.47899998112,
        ["g"] = 20,
        ["sublevel"] = 1,
        ["infested"] = {
          [2] = true,
        },
      },
      [3] = {
        ["x"] = 542.30592320306,
        ["y"] = -347.25195468306,
        ["g"] = 21,
        ["sublevel"] = 1,
        ["infested"] = {
          [2] = true,
          [3] = true,
        },
      },
      [4] = {
        ["x"] = 475.87887856681,
        ["y"] = -295.22113404063,
        ["g"] = 17,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 439.04239027483,
        ["y"] = -295.00076697932,
        ["g"] = 15,
        ["sublevel"] = 1,
      },
      [6] = {
        ["x"] = 467.7141645445,
        ["y"] = -231.97955843208,
        ["g"] = 25,
        ["sublevel"] = 1,
        ["infested"] = {
          [3] = true,
        },
      },
      [7] = {
        ["x"] = 452.18757422234,
        ["y"] = -206.57366384027,
        ["g"] = 26,
        ["sublevel"] = 1,
        ["infested"] = {
          [2] = true,
        },
      },
      [8] = {
        ["x"] = 451.3609693652,
        ["y"] = -335.85455836855,
        ["g"] = 14,
        ["sublevel"] = 1,
        ["infested"] = {
          [2] = true,
          [3] = true,
        },
      },
      [9] = {
        ["x"] = 497.31402487112,
        ["y"] = -279.87601828523,
        ["g"] = 28,
        ["sublevel"] = 1,
        ["teeming"] = true,
      },
      [10] = {
        ["x"] = 482.96621251728,
        ["y"] = -283.80681570174,
        ["g"] = 28,
        ["sublevel"] = 1,
        ["teeming"] = true,
      },
    },
  },
  [16] = {
    ["name"] = "Rezan",
    ["id"] = 122963,
    ["count"] = 0,
    ["health"] = 10375700,
    ["scale"] = 1,
    ["displayId"] = 78188,
    ["creatureType"] = "Undead",
    ["level"] = 72,
    ["isBoss"] = true,
    ["encounterID"] = 2083,
    ["instanceID"] = 968,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [255371] = {
      },
      [255372] = {
      },
      [255373] = {
      },
      [255421] = {
      },
      [255434] = {
      },
      [255445] = {
      },
      [257407] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 501.0508484363,
        ["y"] = -233.58465731868,
        ["g"] = 24,
        ["sublevel"] = 1,
      },
    },
  },
  [17] = {
    ["name"] = "Dinomancer Kish'o",
    ["id"] = 129553,
    ["count"] = 10,
    ["health"] = 3554700,
    ["scale"] = 1.2,
    ["displayId"] = 80709,
    ["creatureType"] = "Humanoid",
    ["level"] = 71,
    ["reaping"] = 148894,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Mind Soothe"] = true,
    },
    ["spells"] = {
      [256846] = {
      },
      [256849] = {
      },
      [256864] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 460.83887127797,
        ["y"] = -271.5164729016,
        ["g"] = 18,
        ["sublevel"] = 1,
        ["scale"] = 1.2,
        ["patrol"] = {
        },
        ["infested"] = {
          [3] = true,
        },
      },
    },
  },
  [18] = {
    ["name"] = "T'lonja",
    ["id"] = 128455,
    ["count"] = 8,
    ["health"] = 2962250,
    ["scale"] = 1,
    ["displayId"] = 47659,
    ["creatureType"] = "Beast",
    ["level"] = 71,
    ["reaping"] = 148894,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [255567] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 454.22305746949,
        ["y"] = -280.66502580359,
        ["g"] = 18,
        ["sublevel"] = 1,
        ["scale"] = 1.2,
      },
    },
  },
  [19] = {
    ["name"] = "Monzumi",
    ["id"] = 129552,
    ["count"] = 8,
    ["health"] = 3021495,
    ["scale"] = 1,
    ["displayId"] = 76483,
    ["creatureType"] = "Beast",
    ["level"] = 71,
    ["reaping"] = 148894,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [256882] = {
      },
      [256884] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 453.94650972705,
        ["y"] = -260.88787276846,
        ["g"] = 18,
        ["sublevel"] = 1,
        ["scale"] = 1.2,
      },
    },
  },
  [20] = {
    ["name"] = "Yazma",
    ["id"] = 122968,
    ["count"] = 0,
    ["health"] = 11857942,
    ["scale"] = 1,
    ["displayId"] = 79568,
    ["creatureType"] = "Humanoid",
    ["level"] = 72,
    ["isBoss"] = true,
    ["encounterID"] = 2030,
    ["instanceID"] = 968,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Mind Soothe"] = true,
    },
    ["spells"] = {
      [249919] = {
      },
      [250022] = {
      },
      [250028] = {
      },
      [250050] = {
      },
      [250096] = {
      },
      [256577] = {
      },
      [257066] = {
      },
      [259187] = {
      },
      [259191] = {
      },
      [418339] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 292.26608457354,
        ["y"] = -270.74025109053,
        ["g"] = 40,
        ["sublevel"] = 1,
      },
    },
  },
};
