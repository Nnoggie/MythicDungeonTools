local MDT = MDT
local L = MDT.L
local dungeonIndex = 40
MDT.dungeonList[dungeonIndex] = L["GrimrailDepot"]
MDT.mapInfo[dungeonIndex] = {
  viewportPositionOverrides = {
    [1] = {
      zoomScale = 1.2999999523163,
      horizontalPan = 108.09110952974,
      verticalPan = 18.640150307329,
    },
    [3] = {
      zoomScale = 1.2999999523163,
      horizontalPan = 8.0440521252548e-07,
      verticalPan = 69.777157123272,
    },
  }
};

local zones = { 606, 607, 608, 609 }
for _, zone in ipairs(zones) do
  MDT.zoneIdToDungeonIdx[zone] = dungeonIndex
end

MDT.dungeonMaps[dungeonIndex] = {
  [0] = "BlackrockTrainDepotDungeon",
  [1] = "BlackrockTrainDepotDungeon1_",
  [2] = "BlackrockTrainDepotDungeon3_",
  [3] = "BlackrockTrainDepotDungeon4_",
}
MDT.dungeonSubLevels[dungeonIndex] = {
  [1] = L["Train Depot"],
  [2] = L["Rear Train Cars"],
  [3] = L["Forward Train Cars"],
}

MDT.dungeonTotalCount[dungeonIndex] = { normal = 300, teeming = 1000, teemingEnabled = true }

MDT.mapPOIs[dungeonIndex] = {
  [1] = {
    [1] = {
      ["template"] = "MapLinkPinTemplate",
      ["type"] = "mapLink",
      ["x"] = 589.48503271105,
      ["y"] = -174.26793333476,
      ["target"] = 2,
      ["direction"] = 1,
      ["connectionIndex"] = 1,
    },
    [2] = {
      ["template"] = "DeathReleasePinTemplate",
      ["type"] = "graveyard",
      ["x"] = 273.83563921658,
      ["y"] = -144.28666476245,
      ["graveyardDescription"] = "",
    },
  },
  [2] = {
    [1] = {
      ["template"] = "MapLinkPinTemplate",
      ["type"] = "mapLink",
      ["x"] = 759.42277857246,
      ["y"] = -290.00086990937,
      ["target"] = 1,
      ["direction"] = -1,
      ["connectionIndex"] = 1,
    },
    [2] = {
      ["template"] = "MapLinkPinTemplate",
      ["type"] = "mapLink",
      ["x"] = 46.922927237933,
      ["y"] = -290.57782865308,
      ["target"] = 3,
      ["direction"] = -2,
      ["connectionIndex"] = 2,
    },
  },
  [3] = {
    [1] = {
      ["template"] = "MapLinkPinTemplate",
      ["type"] = "mapLink",
      ["x"] = 592.69220120775,
      ["y"] = -287.11634309425,
      ["target"] = 2,
      ["direction"] = 2,
      ["connectionIndex"] = 2,
    },
  },
};

MDT.dungeonEnemies[dungeonIndex] = {
  [1] = {
    ["name"] = "Grimrail Laborer",
    ["id"] = 81235,
    ["count"] = 2,
    ["health"] = 213311,
    ["scale"] = 1,
    ["displayId"] = 55909,
    ["creatureType"] = "Humanoid",
    ["level"] = 60,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [164102] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 276.36820088227,
        ["y"] = -313.27076215266,
        ["g"] = 1,
        ["sublevel"] = 1,
        ["scale"] = 2.2,
      },
      [2] = {
        ["x"] = 216.8243412798,
        ["y"] = -360.25353107345,
        ["g"] = 1,
        ["sublevel"] = 1,
        ["scale"] = 2.2,
        ["disguised"] = true,
      },
      [3] = {
        ["x"] = 378.2634880803,
        ["y"] = -335.01200564972,
        ["g"] = 2,
        ["sublevel"] = 1,
        ["scale"] = 2.2,
        ["inspiring"] = true,
      },
      [4] = {
        ["x"] = 370.09535759097,
        ["y"] = -344.73234463277,
        ["g"] = 2,
        ["sublevel"] = 1,
        ["scale"] = 2.2,
        ["disguised"] = true,
      },
      [5] = {
        ["x"] = 577.40777917189,
        ["y"] = -101.27966101695,
        ["sublevel"] = 1,
        ["disguised"] = true,
      },
    },
  },
  [2] = {
    ["name"] = "Grimrail Overseer",
    ["id"] = 81212,
    ["count"] = 7,
    ["health"] = 341298,
    ["scale"] = 1,
    ["displayId"] = 56280,
    ["creatureType"] = "Humanoid",
    ["level"] = 61,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [164163] = {
      },
      [164168] = {
      },
      [164170] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 275.33020680944,
        ["y"] = -292.56625821566,
        ["g"] = 1,
        ["sublevel"] = 1,
        ["scale"] = 2.2,
      },
      [2] = {
        ["x"] = 433.15821461989,
        ["y"] = -332.02933267962,
        ["g"] = 3,
        ["sublevel"] = 1,
        ["scale"] = 2.2,
      },
      [3] = {
        ["x"] = 435.93718644942,
        ["y"] = -313.01485606084,
        ["g"] = 3,
        ["sublevel"] = 1,
        ["scale"] = 2.2,
      },
      [4] = {
        ["x"] = 406.06035773746,
        ["y"] = -230.96485227527,
        ["sublevel"] = 1,
        ["scale"] = 2.2,
        ["patrol"] = {
          [1] = {
            ["x"] = 406.06035773746,
            ["y"] = -230.96485227527,
          },
          [2] = {
            ["x"] = 428.63090589944,
            ["y"] = -220.42171806282,
          },
          [3] = {
            ["x"] = 458.00153910596,
            ["y"] = -220.42171806282,
          },
          [4] = {
            ["x"] = 428.63090589944,
            ["y"] = -220.42171806282,
          },
          [5] = {
            ["x"] = 406.06035773746,
            ["y"] = -230.96485227527,
          },
          [6] = {
            ["x"] = 387.98404020927,
            ["y"] = -242.71191924222,
          },
          [7] = {
            ["x"] = 368.57844058971,
            ["y"] = -264.21543409541,
          },
          [8] = {
            ["x"] = 387.98404020927,
            ["y"] = -242.71191924222,
          },
        },
      },
      [5] = {
        ["x"] = 408.82553950019,
        ["y"] = -277.47530556105,
        ["sublevel"] = 1,
        ["scale"] = 2.2,
        ["patrol"] = {
          [1] = {
            ["x"] = 408.82553950019,
            ["y"] = -277.47530556105,
          },
          [2] = {
            ["x"] = 414.7322756224,
            ["y"] = -251.36578394323,
          },
          [3] = {
            ["x"] = 434.66237280706,
            ["y"] = -236.15601479095,
          },
          [4] = {
            ["x"] = 494.19037056241,
            ["y"] = -246.90771969876,
          },
          [5] = {
            ["x"] = 434.66237280706,
            ["y"] = -236.15601479095,
          },
          [6] = {
            ["x"] = 414.7322756224,
            ["y"] = -251.36578394323,
          },
          [7] = {
            ["x"] = 408.82553950019,
            ["y"] = -277.47530556105,
          },
          [8] = {
            ["x"] = 400.3092078017,
            ["y"] = -304.60006600839,
          },
          [9] = {
            ["x"] = 388.77074154084,
            ["y"] = -314.56508459,
          },
          [10] = {
            ["x"] = 340.51899127452,
            ["y"] = -317.44971616058,
          },
          [11] = {
            ["x"] = 388.77074154084,
            ["y"] = -314.56508459,
          },
          [12] = {
            ["x"] = 400.3092078017,
            ["y"] = -304.60006600839,
          },
        },
      },
    },
  },
  [3] = {
    ["name"] = "Grimrail Technician",
    ["id"] = 81236,
    ["count"] = 4,
    ["health"] = 213311,
    ["scale"] = 1,
    ["displayId"] = 56293,
    ["creatureType"] = "Humanoid",
    ["level"] = 60,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Stun"] = true,
    },
    ["spells"] = {
      [163966] = {
      },
      [164192] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 260.39575313114,
        ["y"] = -300.86475213173,
        ["g"] = 1,
        ["sublevel"] = 1,
        ["scale"] = 2.2,
      },
      [2] = {
        ["x"] = 356.2998861702,
        ["y"] = -335.76727725187,
        ["g"] = 2,
        ["sublevel"] = 1,
        ["scale"] = 2.2,
      },
      [3] = {
        ["x"] = 458.6400574575,
        ["y"] = -244.26730195355,
        ["g"] = 4,
        ["sublevel"] = 1,
        ["scale"] = 2.2,
        ["inspiring"] = true,
      },
      [4] = {
        ["x"] = 446.37515683814,
        ["y"] = -261.16878531073,
        ["g"] = 4,
        ["sublevel"] = 1,
        ["scale"] = 2.2,
        ["disguised"] = true,
      },
    },
  },
  [4] = {
    ["name"] = "Railmaster Rocketspark",
    ["id"] = 77803,
    ["count"] = 0,
    ["health"] = 937420,
    ["scale"] = 1,
    ["displayId"] = 54096,
    ["creatureType"] = "Humanoid",
    ["level"] = 62,
    ["isBoss"] = true,
    ["encounterID"] = 1138,
    ["instanceID"] = 536,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [161091] = {
      },
      [162171] = {
      },
      [162407] = {
      },
      [162422] = {
      },
      [162423] = {
      },
      [162491] = {
      },
      [162500] = {
      },
      [162507] = {
      },
      [162513] = {
      },
      [162572] = {
      },
      [163929] = {
      },
      [163930] = {
      },
      [163947] = {
      },
      [166561] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 630.53553772437,
        ["y"] = -311.54242180887,
        ["g"] = 5,
        ["sublevel"] = 1,
        ["scale"] = 2,
      },
    },
  },
  [5] = {
    ["name"] = "Borka the Brute",
    ["id"] = 77816,
    ["count"] = 0,
    ["health"] = 1129165,
    ["scale"] = 1,
    ["displayId"] = 60108,
    ["creatureType"] = "Humanoid",
    ["level"] = 62,
    ["isBoss"] = true,
    ["encounterID"] = 1138,
    ["instanceID"] = 536,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [161090] = {
      },
      [161092] = {
      },
      [162617] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 605.62735257215,
        ["y"] = -341.3615819209,
        ["g"] = 5,
        ["sublevel"] = 1,
        ["scale"] = 2,
      },
    },
  },
  [6] = {
    ["name"] = "Grimrail Bombardier",
    ["id"] = 81407,
    ["count"] = 12,
    ["health"] = 351964,
    ["scale"] = 1,
    ["displayId"] = 59182,
    ["creatureType"] = "Humanoid",
    ["level"] = 61,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [164187] = {
      },
      [164188] = {
      },
      [164218] = {
      },
      [164241] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 587.07779171895,
        ["y"] = -113.7959039548,
        ["sublevel"] = 1,
        ["disguised"] = true,
      },
      [2] = {
        ["x"] = 627.20702103734,
        ["y"] = -152.51806010229,
        ["sublevel"] = 1,
        ["scale"] = 2.2,
      },
      [3] = {
        ["x"] = 622.02429627298,
        ["y"] = -116.81843798812,
        ["sublevel"] = 1,
        ["scale"] = 2.2,
      },
    },
  },
  [7] = {
    ["name"] = "Iron Infantry",
    ["id"] = 80940,
    ["count"] = 3,
    ["health"] = 213311,
    ["scale"] = 1,
    ["displayId"] = 55374,
    ["creatureType"] = "Humanoid",
    ["level"] = 60,
    ["characteristics"] = {
      ["Root"] = true,
      ["Stun"] = true,
    },
    ["spells"] = {
    },
    ["clones"] = {
      [1] = {
        ["x"] = 587.71482232273,
        ["y"] = -309.45318642878,
        ["g"] = 6,
        ["sublevel"] = 2,
        ["scale"] = 2.7,
        ["disguised"] = true,
      },
      [2] = {
        ["x"] = 586.5097068697,
        ["y"] = -268.1606343537,
        ["g"] = 6,
        ["sublevel"] = 2,
        ["scale"] = 2.7,
        ["inspiring"] = true,
      },
      [3] = {
        ["x"] = 569.35441326982,
        ["y"] = -301.98148049295,
        ["g"] = 6,
        ["sublevel"] = 2,
        ["scale"] = 2.7,
      },
      [4] = {
        ["x"] = 381.67894861862,
        ["y"] = -270.56288281001,
        ["g"] = 7,
        ["sublevel"] = 2,
        ["scale"] = 2.7,
        ["inspiring"] = true,
      },
      [5] = {
        ["x"] = 378.52924459299,
        ["y"] = -294.66081125335,
        ["g"] = 7,
        ["sublevel"] = 2,
        ["scale"] = 2.7,
        ["disguised"] = true,
      },
      [6] = {
        ["x"] = 277.74510888991,
        ["y"] = -272.75013380142,
        ["g"] = 8,
        ["sublevel"] = 2,
        ["scale"] = 2.7,
      },
      [7] = {
        ["x"] = 279.87393957516,
        ["y"] = -295.35774966874,
        ["g"] = 8,
        ["sublevel"] = 2,
        ["scale"] = 2.7,
      },
      [8] = {
        ["x"] = 176.37838148553,
        ["y"] = -268.36049908079,
        ["g"] = 9,
        ["sublevel"] = 2,
        ["scale"] = 2.7,
      },
    },
  },
  [8] = {
    ["name"] = "Grom'kar Gunner",
    ["id"] = 80937,
    ["count"] = 6,
    ["health"] = 191980,
    ["scale"] = 1,
    ["displayId"] = 55280,
    ["creatureType"] = "Humanoid",
    ["level"] = 60,
    ["characteristics"] = {
      ["Root"] = true,
      ["Disorient"] = true,
      ["Stun"] = true,
    },
    ["spells"] = {
      [166675] = {
      },
      [166676] = {
      },
      [176147] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 570.891672321,
        ["y"] = -284.40740050289,
        ["g"] = 6,
        ["sublevel"] = 2,
        ["scale"] = 2.7,
      },
      [2] = {
        ["x"] = 265.37364648091,
        ["y"] = -305.0566003223,
        ["g"] = 8,
        ["sublevel"] = 2,
        ["scale"] = 2.7,
      },
      [3] = {
        ["x"] = 257.82125433611,
        ["y"] = -270.39348966378,
        ["g"] = 8,
        ["sublevel"] = 2,
        ["scale"] = 2.7,
      },
      [4] = {
        ["x"] = 77.79531484418,
        ["y"] = -290.46711574461,
        ["g"] = 10,
        ["sublevel"] = 2,
        ["scale"] = 2.7,
        ["inspiring"] = true,
      },
    },
  },
  [9] = {
    ["name"] = "Grom'kar Grenadier",
    ["id"] = 80936,
    ["count"] = 7,
    ["health"] = 223978,
    ["scale"] = 1,
    ["displayId"] = 55306,
    ["creatureType"] = "Humanoid",
    ["level"] = 60,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Root"] = true,
      ["Disorient"] = true,
      ["Stun"] = true,
    },
    ["spells"] = {
      [161150] = {
      },
      [161153] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 357.83804788042,
        ["y"] = -258.68799617183,
        ["g"] = 7,
        ["sublevel"] = 2,
        ["scale"] = 2.7,
      },
      [2] = {
        ["x"] = 249.93986212857,
        ["y"] = -289.15382154203,
        ["g"] = 8,
        ["sublevel"] = 2,
        ["scale"] = 2.7,
      },
      [3] = {
        ["x"] = 86.554319635335,
        ["y"] = -266.43675270651,
        ["g"] = 10,
        ["sublevel"] = 2,
        ["scale"] = 2.7,
      },
    },
  },
  [10] = {
    ["name"] = "Grom'kar Cinderseer",
    ["id"] = 88163,
    ["count"] = 8,
    ["health"] = 202646,
    ["scale"] = 1,
    ["displayId"] = 60769,
    ["creatureType"] = "Humanoid",
    ["level"] = 60,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Disorient"] = true,
    },
    ["spells"] = {
      [176025] = {
      },
      [176032] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 355.35942718229,
        ["y"] = -281.09672911703,
        ["g"] = 7,
        ["sublevel"] = 2,
        ["scale"] = 2.7,
      },
      [2] = {
        ["x"] = 190.39870927211,
        ["y"] = -311.24148151492,
        ["g"] = 9,
        ["sublevel"] = 2,
        ["scale"] = 2.7,
        ["disguised"] = true,
      },
      [3] = {
        ["x"] = 106.32292234151,
        ["y"] = -305.19875245417,
        ["g"] = 10,
        ["sublevel"] = 2,
        ["scale"] = 2.7,
      },
      [4] = {
        ["x"] = 104.30023397221,
        ["y"] = -277.62440450507,
        ["g"] = 10,
        ["sublevel"] = 2,
        ["scale"] = 2.7,
      },
    },
  },
  [11] = {
    ["name"] = "Grom'kar Boomer",
    ["id"] = 80935,
    ["count"] = 7,
    ["health"] = 202646,
    ["scale"] = 1,
    ["displayId"] = 55281,
    ["creatureType"] = "Humanoid",
    ["level"] = 60,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Root"] = true,
      ["Disorient"] = true,
      ["Stun"] = true,
    },
    ["spells"] = {
      [156301] = {
      },
      [160963] = {
      },
      [161258] = {
      },
      [176127] = {
      },
      [176131] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 176.77248263747,
        ["y"] = -315.47295031978,
        ["g"] = 9,
        ["sublevel"] = 2,
        ["scale"] = 2.7,
      },
      [2] = {
        ["x"] = 196.97365885882,
        ["y"] = -273.06395295068,
        ["g"] = 9,
        ["sublevel"] = 2,
        ["scale"] = 2.7,
      },
      [3] = {
        ["x"] = 87.305065407467,
        ["y"] = -311.12318978932,
        ["g"] = 10,
        ["sublevel"] = 2,
        ["scale"] = 2.7,
      },
    },
  },
  [12] = {
    ["name"] = "Grom'kar Hulk",
    ["id"] = 80938,
    ["count"] = 18,
    ["health"] = 426623,
    ["scale"] = 1,
    ["displayId"] = 58663,
    ["creatureType"] = "Humanoid",
    ["level"] = 61,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [176023] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 164.9933492626,
        ["y"] = -290.32628598667,
        ["g"] = 9,
        ["sublevel"] = 2,
        ["scale"] = 3.4,
      },
    },
  },
  [13] = {
    ["name"] = "Nitrogg Thundertower",
    ["id"] = 79545,
    ["count"] = 0,
    ["health"] = 1491350,
    ["scale"] = 1,
    ["displayId"] = 55162,
    ["creatureType"] = "Humanoid",
    ["level"] = 62,
    ["isBoss"] = true,
    ["encounterID"] = 1163,
    ["instanceID"] = 536,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [161153] = {
      },
      [163536] = {
      },
      [163539] = {
      },
      [163541] = {
      },
      [163550] = {
      },
      [163741] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 532.16581109577,
        ["y"] = -287.47721830965,
        ["sublevel"] = 3,
        ["scale"] = 2.4,
      },
    },
  },
  [14] = {
    ["name"] = "Grom'kar Far Seer",
    ["id"] = 82579,
    ["count"] = 12,
    ["health"] = 341298,
    ["scale"] = 1,
    ["displayId"] = 57126,
    ["creatureType"] = "Humanoid",
    ["level"] = 61,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [166335] = {
      },
      [166336] = {
      },
      [166340] = {
      },
      [166341] = {
      },
      [166364] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 247.40878026178,
        ["y"] = -307.79656645887,
        ["sublevel"] = 3,
        ["scale"] = 2.4,
      },
      [2] = {
        ["x"] = 192.93101059952,
        ["y"] = -304.59954858015,
        ["g"] = 16,
        ["sublevel"] = 3,
        ["scale"] = 2.4,
      },
      [3] = {
        ["x"] = 212.34261594043,
        ["y"] = -297.82466703704,
        ["g"] = 16,
        ["sublevel"] = 3,
        ["scale"] = 2.4,
        ["disguised"] = true,
      },
    },
  },
  [15] = {
    ["name"] = "Grimrail Loader",
    ["id"] = 82594,
    ["count"] = 1,
    ["health"] = 85325,
    ["scale"] = 1,
    ["displayId"] = 55909,
    ["creatureType"] = "Humanoid",
    ["level"] = 60,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Disorient"] = true,
    },
    ["spells"] = {
    },
    ["clones"] = {
      [1] = {
        ["x"] = 142.53467371818,
        ["y"] = -267.86234829243,
        ["g"] = 16,
        ["sublevel"] = 3,
        ["scale"] = 1.4,
      },
      [2] = {
        ["x"] = 160.99775693063,
        ["y"] = -260.84972901984,
        ["g"] = 16,
        ["sublevel"] = 3,
        ["scale"] = 1.4,
      },
      [3] = {
        ["x"] = 185.93248936271,
        ["y"] = -259.56590896679,
        ["g"] = 16,
        ["sublevel"] = 3,
        ["scale"] = 1.4,
      },
      [4] = {
        ["x"] = 121.88507659514,
        ["y"] = -269.98504620358,
        ["g"] = 16,
        ["sublevel"] = 3,
        ["scale"] = 1.4,
      },
      [5] = {
        ["x"] = 103.52526040637,
        ["y"] = -309.69970129722,
        ["g"] = 16,
        ["sublevel"] = 3,
        ["scale"] = 1.4,
      },
      [6] = {
        ["x"] = 180.13950599383,
        ["y"] = -315.12485840932,
        ["g"] = 16,
        ["sublevel"] = 3,
        ["scale"] = 1.4,
      },
      [7] = {
        ["x"] = 101.87162509532,
        ["y"] = -274.30411188067,
        ["g"] = 16,
        ["sublevel"] = 3,
        ["scale"] = 1.4,
      },
      [8] = {
        ["x"] = 128.32711473427,
        ["y"] = -310.63145174282,
        ["g"] = 16,
        ["sublevel"] = 3,
        ["scale"] = 1.4,
      },
      [9] = {
        ["x"] = 153.86857361615,
        ["y"] = -314.15626891123,
        ["g"] = 16,
        ["sublevel"] = 3,
        ["scale"] = 1.4,
        ["inspiring"] = true,
      },
    },
  },
  [16] = {
    ["name"] = "Grimrail Scout",
    ["id"] = 82590,
    ["count"] = 12,
    ["health"] = 277305,
    ["scale"] = 1,
    ["displayId"] = 57131,
    ["creatureType"] = "Humanoid",
    ["level"] = 61,
    ["spells"] = {
      [166350] = {
      },
      [166397] = {
      },
      [166404] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 192.15882443014,
        ["y"] = -278.25784729777,
        ["g"] = 16,
        ["sublevel"] = 3,
        ["scale"] = 2.4,
      },
    },
  },
  [17] = {
    ["name"] = "Grom'kar Captain",
    ["id"] = 82597,
    ["count"] = 18,
    ["health"] = 426623,
    ["scale"] = 1,
    ["displayId"] = 57133,
    ["creatureType"] = "Humanoid",
    ["level"] = 61,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [166378] = {
      },
      [166380] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 168.62552728553,
        ["y"] = -299.04665605257,
        ["g"] = 16,
        ["sublevel"] = 3,
        ["scale"] = 2.8,
      },
    },
  },
  [18] = {
    ["name"] = "Skylord Tovra",
    ["id"] = 80005,
    ["count"] = 0,
    ["health"] = 1704400,
    ["scale"] = 1,
    ["displayId"] = 55630,
    ["creatureType"] = "Humanoid",
    ["level"] = 62,
    ["isBoss"] = true,
    ["encounterID"] = 1133,
    ["instanceID"] = 536,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [161588] = {
      },
      [162055] = {
      },
      [162057] = {
      },
      [162058] = {
      },
      [162065] = {
      },
      [162066] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 45.861747629694,
        ["y"] = -289.54998617715,
        ["sublevel"] = 3,
        ["scale"] = 2.4,
      },
    },
  },
  [19] = {
    ["name"] = "Nathrezim Infiltrator",
    ["id"] = 189878,
    ["count"] = 6,
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
        ["x"] = 216.8243412798,
        ["y"] = -360.25353107345,
        ["sublevel"] = 1,
        ["scale"] = 2.2,
        ["shrouded"] = true,
      },
      [2] = {
        ["x"] = 369.9543758357,
        ["y"] = -352.44420242342,
        ["g"] = 2,
        ["sublevel"] = 1,
        ["scale"] = 2.2,
        ["shrouded"] = true,
      },
      [3] = {
        ["x"] = 446.37515683814,
        ["y"] = -261.16878531073,
        ["g"] = 4,
        ["sublevel"] = 1,
        ["scale"] = 2.2,
        ["shrouded"] = true,
      },
      [4] = {
        ["x"] = 572.49834000185,
        ["y"] = -93.180529200005,
        ["sublevel"] = 1,
        ["scale"] = 2.2,
        ["shrouded"] = true,
      },
      [5] = {
        ["x"] = 587.71482232273,
        ["y"] = -309.45318642878,
        ["g"] = 6,
        ["sublevel"] = 2,
        ["scale"] = 2.7,
        ["shrouded"] = true,
      },
      [6] = {
        ["x"] = 378.52924459299,
        ["y"] = -294.66081125335,
        ["g"] = 7,
        ["sublevel"] = 2,
        ["scale"] = 2.7,
        ["shrouded"] = true,
      },
      [7] = {
        ["x"] = 197.97083317766,
        ["y"] = -305.47221477872,
        ["g"] = 9,
        ["sublevel"] = 2,
        ["scale"] = 2.7,
        ["shrouded"] = true,
      },
      [8] = {
        ["x"] = 216.66954407067,
        ["y"] = -297.61862620891,
        ["g"] = 16,
        ["sublevel"] = 3,
        ["scale"] = 2.4,
        ["shrouded"] = true,
      },
    },
  },
  [20] = {
    ["name"] = "Zul'gamux",
    ["id"] = 190128,
    ["count"] = 18,
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
        ["x"] = 588.75980963218,
        ["y"] = -134.88837528754,
        ["sublevel"] = 1,
        ["scale"] = 2,
        ["shrouded"] = true,
      },
    },
  },
};
