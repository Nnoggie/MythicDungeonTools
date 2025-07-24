local addonName = ...
local MDT = MDT
local L = MDT.L

local dungeonIndex = 135
MDT.dungeonList[dungeonIndex] = L["Shado-Pan Monastery"]
MDT.mapInfo[dungeonIndex] = {
  iconId = 603795,
  shortName = L["shadoPanMonasteryShortName"],
  englishName = "Shado-Pan Monastery",
  mapID = 959,
};

local zones = { 443, 444, 445, 446 }
for _, zone in ipairs(zones) do
  MDT.zoneIdToDungeonIdx[zone] = dungeonIndex
end

MDT.dungeonMaps[dungeonIndex] = {
  [0] = "",
  [1] = { customTextures = 'Interface\\AddOns\\'..addonName..'\\MistsOfPandaria\\Textures\\ShadoPanMonastery' },
}
MDT.dungeonSubLevels[dungeonIndex] = {
  [1] = L["Shado-Pan Monastery"],
}

MDT.dungeonTotalCount[dungeonIndex] = { normal = 32, teeming = 1000, teemingEnabled = true }

MDT.mapPOIs[dungeonIndex] = {};

MDT.dungeonEnemies[dungeonIndex] = {
  [1] = {
    ["name"] = "Shado-Pan Warden",
    ["id"] = 59751,
    ["count"] = 1,
    ["health"] = 4886614,
    ["scale"] = 1,
    ["displayId"] = 46083,
    ["creatureType"] = "Humanoid",
    ["characteristics"] = {
    },
    ["spells"] = {
    },
    ["clones"] = {
      [1] = {
        ["x"] = 647.1,
        ["y"] = -407,
        ["g"] = 1,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 595.5,
        ["y"] = -433.9,
        ["g"] = 4,
        ["sublevel"] = 1,
      },
    },
  },
  [2] = {
    ["name"] = "Shado-Pan Stormbringer",
    ["id"] = 59808,
    ["count"] = 1,
    ["health"] = 1630682,
    ["scale"] = 1,
    ["displayId"] = 41803,
    ["creatureType"] = "Humanoid",
    ["characteristics"] = {
    },
    ["spells"] = {
    },
    ["clones"] = {
      [1] = {
        ["x"] = 630.7,
        ["y"] = -382.3,
        ["g"] = 2,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 625.7,
        ["y"] = -379.4,
        ["g"] = 2,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 635.6,
        ["y"] = -380,
        ["g"] = 2,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 631.7,
        ["y"] = -371.1,
        ["g"] = 2,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 626.9,
        ["y"] = -373.2,
        ["g"] = 2,
        ["sublevel"] = 1,
      },
      [6] = {
        ["x"] = 635.8,
        ["y"] = -374.2,
        ["g"] = 2,
        ["sublevel"] = 1,
      },
      [7] = {
        ["x"] = 626.5,
        ["y"] = -421.6,
        ["g"] = 3,
        ["sublevel"] = 1,
      },
      [8] = {
        ["x"] = 623.6,
        ["y"] = -426.2,
        ["g"] = 3,
        ["sublevel"] = 1,
      },
      [9] = {
        ["x"] = 618.1,
        ["y"] = -425.8,
        ["g"] = 3,
        ["sublevel"] = 1,
      },
      [10] = {
        ["x"] = 623.9,
        ["y"] = -416.4,
        ["g"] = 3,
        ["sublevel"] = 1,
      },
      [11] = {
        ["x"] = 618.5,
        ["y"] = -416,
        ["g"] = 3,
        ["sublevel"] = 1,
      },
      [12] = {
        ["x"] = 615.5,
        ["y"] = -420.4,
        ["g"] = 3,
        ["sublevel"] = 1,
      },
    },
  },
  [3] = {
    ["name"] = "Shado-Pan Ambusher",
    ["id"] = 59752,
    ["count"] = 1,
    ["health"] = 1223370,
    ["scale"] = 1,
    ["displayId"] = 46084,
    ["creatureType"] = "Humanoid",
    ["characteristics"] = {
    },
    ["spells"] = {
    },
    ["clones"] = {
      [1] = {
        ["x"] = 642.2,
        ["y"] = -396.7,
        ["g"] = 1,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 636.8,
        ["y"] = -399.4,
        ["g"] = 1,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 633.6,
        ["y"] = -394.7,
        ["g"] = 1,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 645.2,
        ["y"] = -389.2,
        ["g"] = 1,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 639.2,
        ["y"] = -392.2,
        ["g"] = 1,
        ["sublevel"] = 1,
      },
      [6] = {
        ["x"] = 647.5,
        ["y"] = -394.2,
        ["g"] = 1,
        ["sublevel"] = 1,
      },
      [7] = {
        ["x"] = 590.6,
        ["y"] = -423.8,
        ["g"] = 4,
        ["sublevel"] = 1,
      },
      [8] = {
        ["x"] = 599.5,
        ["y"] = -443.7,
        ["g"] = 4,
        ["sublevel"] = 1,
      },
      [9] = {
        ["x"] = 600.8,
        ["y"] = -443.2,
        ["g"] = 4,
        ["sublevel"] = 1,
      },
      [10] = {
        ["x"] = 591.9,
        ["y"] = -423.2,
        ["g"] = 4,
        ["sublevel"] = 1,
      },
      [11] = {
        ["x"] = 590.1,
        ["y"] = -444.5,
        ["g"] = 4,
        ["sublevel"] = 1,
      },
      [12] = {
        ["x"] = 588.2,
        ["y"] = -440.5,
        ["g"] = 4,
        ["sublevel"] = 1,
      },
      [13] = {
        ["x"] = 585.6,
        ["y"] = -434.8,
        ["g"] = 4,
        ["sublevel"] = 1,
      },
      [14] = {
        ["x"] = 586.5,
        ["y"] = -436.6,
        ["g"] = 4,
        ["sublevel"] = 1,
      },
      [15] = {
        ["x"] = 584.6,
        ["y"] = -432.9,
        ["g"] = 4,
        ["sublevel"] = 1,
      },
      [16] = {
        ["x"] = 589.1,
        ["y"] = -442.5,
        ["g"] = 4,
        ["sublevel"] = 1,
      },
    },
  },
  [4] = {
    ["name"] = "Gu Cloudstrike",
    ["id"] = 56747,
    ["count"] = 0,
    ["health"] = 17445000,
    ["scale"] = 1.6,
    ["displayId"] = 39489,
    ["creatureType"] = "Humanoid",
    ["isBoss"] = true,
    ["instanceID"] = 312,
    ["characteristics"] = {
    },
    ["spells"] = {
    },
    ["clones"] = {
      [1] = {
        ["x"] = 539.2,
        ["y"] = -372.2,
        ["g"] = 5,
        ["sublevel"] = 1,
      },
    },
  },
  [5] = {
    ["name"] = "Azure Serpent",
    ["id"] = 56754,
    ["count"] = 0,
    ["health"] = 13072340,
    ["scale"] = 1,
    ["displayId"] = 39492,
    ["creatureType"] = "Beast",
    ["characteristics"] = {
    },
    ["spells"] = {
    },
    ["clones"] = {
      [1] = {
        ["x"] = 535.2,
        ["y"] = -362.6,
        ["g"] = 5,
        ["sublevel"] = 1,
      },
    },
  },
  [6] = {
    ["name"] = "Ethereal Sha",
    ["id"] = 65414,
    ["count"] = 1,
    ["health"] = 3253586,
    ["scale"] = 1,
    ["displayId"] = 40887,
    ["creatureType"] = "Elemental",
    ["characteristics"] = {
    },
    ["spells"] = {
    },
    ["clones"] = {
      [1] = {
        ["x"] = 554.4,
        ["y"] = -457.4,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 531,
        ["y"] = -454.8,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 525.6,
        ["y"] = -478.3,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 502.4,
        ["y"] = -489.4,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 488.2,
        ["y"] = -476.8,
        ["sublevel"] = 1,
      },
    },
  },
  [7] = {
    ["name"] = "Volatile Energy",
    ["id"] = 56766,
    ["count"] = 0,
    ["health"] = 611549,
    ["scale"] = 1,
    ["displayId"] = 40884,
    ["creatureType"] = "Elemental",
    ["characteristics"] = {
    },
    ["spells"] = {
    },
    ["clones"] = {
      [1] = {
        ["x"] = 148.4,
        ["y"] = -297.5,
        ["g"] = 15,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 157,
        ["y"] = -303.4,
        ["g"] = 15,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 145.8,
        ["y"] = -289.6,
        ["g"] = 15,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 174.4,
        ["y"] = -275.2,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 189.6,
        ["y"] = -258.3,
        ["sublevel"] = 1,
      },
      [6] = {
        ["x"] = 205.6,
        ["y"] = -238.9,
        ["g"] = 16,
        ["sublevel"] = 1,
      },
      [7] = {
        ["x"] = 205.4,
        ["y"] = -230.3,
        ["g"] = 16,
        ["sublevel"] = 1,
      },
      [8] = {
        ["x"] = 215.4,
        ["y"] = -235.7,
        ["g"] = 16,
        ["sublevel"] = 1,
      },
      [9] = {
        ["x"] = 235.2,
        ["y"] = -199.7,
        ["sublevel"] = 1,
      },
      [10] = {
        ["x"] = 249.7,
        ["y"] = -193.8,
        ["sublevel"] = 1,
      },
      [11] = {
        ["x"] = 245.9,
        ["y"] = -216,
        ["sublevel"] = 1,
      },
      [12] = {
        ["x"] = 260.1,
        ["y"] = -213.5,
        ["sublevel"] = 1,
      },
      [13] = {
        ["x"] = 219.8,
        ["y"] = -197.2,
        ["sublevel"] = 1,
      },
      [14] = {
        ["x"] = 236.8,
        ["y"] = -179.6,
        ["sublevel"] = 1,
      },
      [15] = {
        ["x"] = 249.8,
        ["y"] = -179.4,
        ["sublevel"] = 1,
      },
      [16] = {
        ["x"] = 124.4,
        ["y"] = -393.9,
        ["g"] = 11,
        ["sublevel"] = 1,
      },
      [17] = {
        ["x"] = 144.8,
        ["y"] = -332.2,
        ["g"] = 13,
        ["sublevel"] = 1,
      },
      [18] = {
        ["x"] = 117.8,
        ["y"] = -314,
        ["g"] = 14,
        ["sublevel"] = 1,
      },
      [19] = {
        ["x"] = 167.4,
        ["y"] = -303,
        ["g"] = 15,
        ["sublevel"] = 1,
      },
    },
  },
  [8] = {
    ["name"] = "Regenerating Sha",
    ["id"] = 56763,
    ["count"] = 1,
    ["health"] = 2530769,
    ["scale"] = 1,
    ["displayId"] = 41677,
    ["creatureType"] = "Elemental",
    ["characteristics"] = {
    },
    ["spells"] = {
    },
    ["clones"] = {
      [1] = {
        ["x"] = 161.3,
        ["y"] = -289.7,
        ["g"] = 15,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 148.4,
        ["y"] = -402.9,
        ["g"] = 9,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 162.7,
        ["y"] = -368.4,
        ["g"] = 10,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 126.9,
        ["y"] = -385.4,
        ["g"] = 11,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 70.4,
        ["y"] = -365.1,
        ["g"] = 12,
        ["sublevel"] = 1,
      },
      [6] = {
        ["x"] = 140,
        ["y"] = -338.5,
        ["g"] = 13,
        ["sublevel"] = 1,
      },
      [7] = {
        ["x"] = 109.1,
        ["y"] = -317.7,
        ["g"] = 14,
        ["sublevel"] = 1,
      },
    },
  },
  [9] = {
    ["name"] = "Destroying Sha",
    ["id"] = 56765,
    ["count"] = 1,
    ["health"] = 2527434,
    ["scale"] = 1,
    ["displayId"] = 40687,
    ["creatureType"] = "Elemental",
    ["characteristics"] = {
    },
    ["spells"] = {
    },
    ["clones"] = {
      [1] = {
        ["x"] = 226,
        ["y"] = -217.1,
        ["g"] = 17,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 222.4,
        ["y"] = -221.9,
        ["g"] = 17,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 217.3,
        ["y"] = -218.3,
        ["g"] = 17,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 154.4,
        ["y"] = -411.1,
        ["g"] = 9,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 143.1,
        ["y"] = -412.1,
        ["g"] = 9,
        ["sublevel"] = 1,
      },
      [6] = {
        ["x"] = 155.8,
        ["y"] = -367,
        ["g"] = 10,
        ["sublevel"] = 1,
      },
      [7] = {
        ["x"] = 126.9,
        ["y"] = -377.1,
        ["g"] = 11,
        ["sublevel"] = 1,
      },
      [8] = {
        ["x"] = 120.8,
        ["y"] = -384.2,
        ["g"] = 11,
        ["sublevel"] = 1,
      },
      [9] = {
        ["x"] = 137,
        ["y"] = -345.4,
        ["g"] = 13,
        ["sublevel"] = 1,
      },
      [10] = {
        ["x"] = 145.8,
        ["y"] = -344.1,
        ["g"] = 13,
        ["sublevel"] = 1,
      },
      [11] = {
        ["x"] = 101.7,
        ["y"] = -325,
        ["g"] = 14,
        ["sublevel"] = 1,
      },
      [12] = {
        ["x"] = 111.1,
        ["y"] = -328.4,
        ["g"] = 14,
        ["sublevel"] = 1,
      },
    },
  },
  [10] = {
    ["name"] = "Vestige of Hatred",
    ["id"] = 58807,
    ["count"] = 0,
    ["health"] = 2528610,
    ["scale"] = 1,
    ["displayId"] = 40296,
    ["creatureType"] = "Undead",
    ["characteristics"] = {
    },
    ["spells"] = {
    },
    ["clones"] = {
      [1] = {
        ["x"] = 376.6,
        ["y"] = -234.3,
        ["g"] = 18,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 387.2,
        ["y"] = -232.1,
        ["g"] = 18,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 399.2,
        ["y"] = -282.9,
        ["g"] = 19,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 460.1,
        ["y"] = -286.1,
        ["g"] = 20,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 505.4,
        ["y"] = -308.8,
        ["g"] = 21,
        ["sublevel"] = 1,
      },
      [6] = {
        ["x"] = 560.7,
        ["y"] = -292.1,
        ["g"] = 22,
        ["sublevel"] = 1,
      },
      [7] = {
        ["x"] = 567.4,
        ["y"] = -281.7,
        ["g"] = 22,
        ["sublevel"] = 1,
      },
    },
  },
  [11] = {
    ["name"] = "Hateful Essence",
    ["id"] = 58812,
    ["count"] = 0,
    ["health"] = 611260,
    ["scale"] = 1,
    ["creatureType"] = "Elemental",
    ["characteristics"] = {
    },
    ["spells"] = {
    },
    ["clones"] = {
      [1] = {
        ["x"] = 400.2,
        ["y"] = -257,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 419.1,
        ["y"] = -258.4,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 459.9,
        ["y"] = -295.1,
        ["g"] = 20,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 508.2,
        ["y"] = -305.5,
        ["g"] = 21,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 502.7,
        ["y"] = -291.7,
        ["g"] = 21,
        ["sublevel"] = 1,
      },
      [6] = {
        ["x"] = 580.4,
        ["y"] = -314.1,
        ["sublevel"] = 1,
      },
      [7] = {
        ["x"] = 563.7,
        ["y"] = -286.7,
        ["g"] = 22,
        ["sublevel"] = 1,
      },
      [8] = {
        ["x"] = 566.1,
        ["y"] = -290.1,
        ["g"] = 22,
        ["sublevel"] = 1,
      },
      [9] = {
        ["x"] = 549.1,
        ["y"] = -242.2,
        ["sublevel"] = 1,
      },
      [10] = {
        ["x"] = 595.6,
        ["y"] = -217.3,
        ["sublevel"] = 1,
      },
      [11] = {
        ["x"] = 603.9,
        ["y"] = -226.2,
        ["sublevel"] = 1,
      },
      [12] = {
        ["x"] = 629,
        ["y"] = -300.4,
        ["sublevel"] = 1,
      },
    },
  },
  [12] = {
    ["name"] = "Fragment of Hatred",
    ["id"] = 58810,
    ["count"] = 0,
    ["health"] = 2533677,
    ["scale"] = 1,
    ["displayId"] = 40297,
    ["creatureType"] = "Undead",
    ["characteristics"] = {
    },
    ["spells"] = {
    },
    ["clones"] = {
      [1] = {
        ["x"] = 408.4,
        ["y"] = -276,
        ["g"] = 19,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 411.1,
        ["y"] = -283,
        ["g"] = 19,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 462.8,
        ["y"] = -290.8,
        ["g"] = 20,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 465.7,
        ["y"] = -296,
        ["g"] = 20,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 469.9,
        ["y"] = -290,
        ["g"] = 20,
        ["sublevel"] = 1,
      },
      [6] = {
        ["x"] = 503.3,
        ["y"] = -302.6,
        ["g"] = 21,
        ["sublevel"] = 1,
      },
      [7] = {
        ["x"] = 508.3,
        ["y"] = -300.7,
        ["g"] = 21,
        ["sublevel"] = 1,
      },
      [8] = {
        ["x"] = 503,
        ["y"] = -297.3,
        ["g"] = 21,
        ["sublevel"] = 1,
      },
      [9] = {
        ["x"] = 558.1,
        ["y"] = -286.6,
        ["g"] = 22,
        ["sublevel"] = 1,
      },
      [10] = {
        ["x"] = 557.5,
        ["y"] = -279.9,
        ["g"] = 22,
        ["sublevel"] = 1,
      },
    },
  },
  [13] = {
    ["name"] = "Residual Hatred",
    ["id"] = 58803,
    ["count"] = 0,
    ["health"] = 2527632,
    ["scale"] = 1,
    ["displayId"] = 41051,
    ["creatureType"] = "Undead",
    ["characteristics"] = {
    },
    ["spells"] = {
    },
    ["clones"] = {
      [1] = {
        ["x"] = 399.4,
        ["y"] = -275.6,
        ["g"] = 19,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 467,
        ["y"] = -283.7,
        ["g"] = 20,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 506.2,
        ["y"] = -294.2,
        ["g"] = 21,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 562.8,
        ["y"] = -276.5,
        ["g"] = 22,
        ["sublevel"] = 1,
      },
    },
  },
  [14] = {
    ["name"] = "Shado-Pan Disciple",
    ["id"] = 58198,
    ["count"] = 1,
    ["health"] = 1630682,
    ["scale"] = 1,
    ["displayId"] = 41897,
    ["creatureType"] = "Humanoid",
    ["characteristics"] = {
    },
    ["spells"] = {
    },
    ["clones"] = {
      [1] = {
        ["x"] = 421.1,
        ["y"] = -472.6,
        ["g"] = 7,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 424,
        ["y"] = -481.1,
        ["g"] = 7,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 462.6,
        ["y"] = -472,
        ["g"] = 6,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 459.7,
        ["y"] = -481.6,
        ["g"] = 6,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 463.7,
        ["y"] = -489.1,
        ["g"] = 6,
        ["sublevel"] = 1,
      },
      [6] = {
        ["x"] = 473.3,
        ["y"] = -490,
        ["g"] = 6,
        ["sublevel"] = 1,
      },
    },
  },
  [15] = {
    ["name"] = "Master Snowdrift",
    ["id"] = 56541,
    ["count"] = 0,
    ["health"] = 19614634,
    ["scale"] = 1.6,
    ["displayId"] = 46071,
    ["creatureType"] = "Humanoid",
    ["isBoss"] = true,
    ["instanceID"] = 312,
    ["characteristics"] = {
    },
    ["spells"] = {
    },
    ["clones"] = {
      [1] = {
        ["x"] = 216.3,
        ["y"] = -382.7,
        ["sublevel"] = 1,
      },
    },
  },
  [16] = {
    ["name"] = "Fragrant Lotus",
    ["id"] = 56472,
    ["count"] = 0,
    ["health"] = 5050495,
    ["scale"] = 1,
    ["displayId"] = 41900,
    ["creatureType"] = "Humanoid",
    ["characteristics"] = {
    },
    ["spells"] = {
    },
    ["clones"] = {
      [1] = {
        ["x"] = 270.3,
        ["y"] = -413.9,
        ["g"] = 8,
        ["sublevel"] = 1,
      },
    },
  },
  [17] = {
    ["name"] = "Flying Snow",
    ["id"] = 56473,
    ["count"] = 0,
    ["health"] = 5050495,
    ["scale"] = 1,
    ["displayId"] = 41901,
    ["creatureType"] = "Humanoid",
    ["characteristics"] = {
    },
    ["spells"] = {
    },
    ["clones"] = {
      [1] = {
        ["x"] = 264.2,
        ["y"] = -421.8,
        ["g"] = 8,
        ["sublevel"] = 1,
      },
    },
  },
  [18] = {
    ["name"] = "Consuming Sha",
    ["id"] = 56764,
    ["count"] = 1,
    ["health"] = 611549,
    ["scale"] = 1,
    ["displayId"] = 40625,
    ["creatureType"] = "Elemental",
    ["characteristics"] = {
    },
    ["spells"] = {
    },
    ["clones"] = {
      [1] = {
        ["x"] = 159.1,
        ["y"] = -405.5,
        ["g"] = 9,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 161.3,
        ["y"] = -377.3,
        ["g"] = 10,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 153.6,
        ["y"] = -375,
        ["g"] = 10,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 135.6,
        ["y"] = -385.6,
        ["g"] = 11,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 86.7,
        ["y"] = -364.8,
        ["g"] = 12,
        ["sublevel"] = 1,
      },
      [6] = {
        ["x"] = 85,
        ["y"] = -375,
        ["g"] = 12,
        ["sublevel"] = 1,
      },
      [7] = {
        ["x"] = 134.6,
        ["y"] = -332.8,
        ["g"] = 13,
        ["sublevel"] = 1,
      },
      [8] = {
        ["x"] = 105.3,
        ["y"] = -310.2,
        ["g"] = 14,
        ["sublevel"] = 1,
      },
    },
  },
  [19] = {
    ["name"] = "Sha of Violence",
    ["id"] = 56719,
    ["count"] = 0,
    ["health"] = 43647059,
    ["scale"] = 1.6,
    ["displayId"] = 43283,
    ["creatureType"] = "Elemental",
    ["isBoss"] = true,
    ["instanceID"] = 312,
    ["characteristics"] = {
    },
    ["spells"] = {
    },
    ["clones"] = {
      [1] = {
        ["x"] = 362,
        ["y"] = -170.6,
        ["sublevel"] = 1,
      },
    },
    ["healthPercentage"] = 85,
  },
  [20] = {
    ["name"] = "Taran Zhu",
    ["id"] = 56884,
    ["count"] = 0,
    ["health"] = 19635628,
    ["scale"] = 1.6,
    ["displayId"] = 41121,
    ["creatureType"] = "Humanoid",
    ["isBoss"] = true,
    ["instanceID"] = 312,
    ["characteristics"] = {
    },
    ["spells"] = {
    },
    ["clones"] = {
      [1] = {
        ["x"] = 619.2,
        ["y"] = -259.2,
        ["sublevel"] = 1,
      },
    },
  },
};
