local addonName = ...
local MDT = MDT
local L = MDT.L
local dungeonIndex = 122
MDT.dungeonList[dungeonIndex] = L["Mechagon - Workshop"]
MDT.mapInfo[dungeonIndex] = {
  teleportId = 373274,
  shortName = L["mechagonWorkshopShortName"],
  englishName = "Mechagon - Workshop",
  mapID = 370
};

local zones = { 1491, 1493, 1494, 1497 }
for _, zone in ipairs(zones) do
  MDT.zoneIdToDungeonIdx[zone] = dungeonIndex
end

MDT.dungeonMaps[dungeonIndex] = {
  [0] = "",
  [1] = { customTextures = 'Interface\\AddOns\\' .. addonName .. '\\TheWarWithin\\Textures\\MechagonWorkshop' }
}

MDT.dungeonSubLevels[dungeonIndex] = {
  [1] = L["Mechagon - Workshop"],
}

MDT.dungeonTotalCount[dungeonIndex] = { normal = 374, teeming = 192, teemingEnabled = true }

MDT.mapPOIs[dungeonIndex] = {};


MDT.dungeonEnemies[dungeonIndex] = {
  [1] = {
    ["name"] = "Blastatron X-80",
    ["id"] = 151476,
    ["count"] = 20,
    ["health"] = 532625,
    ["scale"] = 2.5,
    ["displayId"] = 90712,
    ["creatureType"] = "Mechanical",
    ["level"] = 81,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [293986] = {
      },
      [473436] = {
      },
      [473440] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 242.71614530374,
        ["y"] = -235.8766583427,
        ["g"] = 21,
        ["sublevel"] = 1,
      },
    },
  },
  [2] = {
    ["name"] = "Defense Bot Mk I",
    ["id"] = 151649,
    ["count"] = 5,
    ["health"] = 223703,
    ["scale"] = 2,
    ["displayId"] = 91349,
    ["creatureType"] = "Mechanical",
    ["level"] = 80,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Silence"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
    },
    ["spells"] = {
      [294195] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 237.51990863612,
        ["y"] = -285.91992361958,
        ["g"] = 20,
      },
      [2] = {
        ["x"] = 229.90107191758,
        ["y"] = -268.18844941834,
        ["g"] = 20,
      },
      [3] = {
        ["x"] = 340.87452804072,
        ["y"] = -103.27116109321,
        ["g"] = 22,
      },
      [4] = {
        ["x"] = 356.52834662902,
        ["y"] = -113.63023018382,
        ["g"] = 22,
      },
    },
  },
  [3] = {
    ["name"] = "Mechagon Tinkerer",
    ["id"] = 144294,
    ["count"] = 6,
    ["health"] = 213050,
    ["scale"] = 2,
    ["displayId"] = 91170,
    ["creatureType"] = "Humanoid",
    ["level"] = 80,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Incapacitate"] = true,
      ["Silence"] = true,
      ["Mind Control"] = true,
      ["Polymorph"] = true,
      ["Fear"] = true,
      ["Disorient"] = true,
      ["Imprison"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
    },
    ["spells"] = {
      [293827] = {
      },
      [293854] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 264.94344254941,
        ["y"] = -267.47328522937,
        ["g"] = 19,
      },
      [2] = {
        ["x"] = 274.63896763009,
        ["y"] = -251.11539864919,
        ["g"] = 19,
      },
      [4] = {
        ["x"] = 129.08528179242,
        ["y"] = -288.23635502106,
        ["g"] = 23,
      },
      [5] = {
        ["x"] = 149.94638981524,
        ["y"] = -168.74972183428,
        ["g"] = 24,
      },
      [6] = {
        ["x"] = 344.39451222478,
        ["y"] = -128.92230457847,
        ["g"] = 22,
      },
    },
  },
  [4] = {
    ["name"] = "Workshop Defender",
    ["id"] = 144299,
    ["count"] = 4,
    ["health"] = 213050,
    ["scale"] = 2,
    ["displayId"] = 91183,
    ["creatureType"] = "Humanoid",
    ["level"] = 80,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Incapacitate"] = true,
      ["Silence"] = true,
      ["Mind Control"] = true,
      ["Polymorph"] = true,
      ["Fear"] = true,
      ["Disorient"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
    },
    ["spells"] = {
      [293670] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 327.61311283608,
        ["y"] = -119.17292669336,
        ["g"] = 22,
      },
      [2] = {
        ["x"] = 111.75342364227,
        ["y"] = -294.15901328492,
        ["g"] = 23,
      },
      [3] = {
        ["x"] = 124.07475250879,
        ["y"] = -306.23527708094,
        ["g"] = 23,
      },
      [4] = {
        ["x"] = 135.95350408855,
        ["y"] = -180.72516214191,
        ["g"] = 24,
      },
    },
  },
  [5] = {
    ["name"] = "Mechagon Mechanic",
    ["id"] = 144295,
    ["count"] = 4,
    ["health"] = 213050,
    ["scale"] = 2,
    ["displayId"] = 91171,
    ["creatureType"] = "Humanoid",
    ["level"] = 80,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Incapacitate"] = true,
      ["Silence"] = true,
      ["Polymorph"] = true,
      ["Fear"] = true,
      ["Disorient"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
    },
    ["spells"] = {
      [293729] = {
      },
      [293930] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 351.14075932356,
        ["y"] = -86.695786041154,
        ["g"] = 22,
      },
      [2] = {
        ["x"] = 126.02899118717,
        ["y"] = -166.03290880106,
        ["g"] = 24,
      },
      [3] = {
        ["x"] = 121.71179355356,
        ["y"] = -191.44420030292,
        ["g"] = 24,
      },
      [6] = {
        ["x"] = 367.32507299992,
        ["y"] = -98.790870840717,
        ["g"] = 22,
      },
    },
  },
  [6] = {
    ["name"] = "Head Machinist Sparkflux",
    ["id"] = 144248,
    ["count"] = 0,
    ["health"] = 1489665,
    ["scale"] = 2,
    ["displayId"] = 23397,
    ["creatureType"] = "Mechanical",
    ["level"] = 82,
    ["isBoss"] = true,
    ["encounterID"] = 2348,
    ["instanceID"] = 1178,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [285440] = {
      },
      [285454] = {
      },
      [285460] = {
      },
      [292332] = {
      },
      [294853] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 316.89015248406,
        ["y"] = -158.60498265259,
        ["sublevel"] = 1,
      },
    },
  },
  [7] = {
    ["name"] = "Spider Tank",
    ["id"] = 144296,
    ["count"] = 12,
    ["health"] = 340880,
    ["scale"] = 2.5,
    ["displayId"] = 90710,
    ["creatureType"] = "Mechanical",
    ["level"] = 81,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [293986] = {
      },
      [296348] = {
      },
      [473436] = {
      },
      [473440] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 255.44539021688,
        ["y"] = -119.72613721386,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 215.95079729818,
        ["y"] = -92.89566134796,
        ["sublevel"] = 1,
      },
    },
  },
  [8] = {
    ["name"] = "Defense Bot Mk III",
    ["id"] = 144298,
    ["count"] = 10,
    ["health"] = 340880,
    ["scale"] = 2,
    ["displayId"] = 90855,
    ["creatureType"] = "Mechanical",
    ["level"] = 81,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [294195] = {
      },
      [297127] = {
      },
      [297128] = {
      },
      [297133] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 220.76104807262,
        ["y"] = -284.13645836919,
        ["g"] = 20,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 133.79641688773,
        ["y"] = -258.45140887272,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 151.24781908599,
        ["y"] = -231.47170304853,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 110.54255941563,
        ["y"] = -176.11195795111,
        ["g"] = 24,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 140.23901580416,
        ["y"] = -153.66886546266,
        ["g"] = 24,
        ["sublevel"] = 1,
      },
    },
  },
  [9] = {
    ["name"] = "Aerial Unit R-21/X",
    ["id"] = 150396,
    ["count"] = 0,
    ["health"] = 1021484,
    ["scale"] = 2,
    ["displayId"] = 90547,
    ["creatureType"] = "Mechanical",
    ["level"] = 82,
    ["isBoss"] = true,
    ["encounterID"] = 2331,
    ["instanceID"] = 1178,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [291613] = {
      },
      [291626] = {
      },
      [291865] = {
      },
      [291878] = {
      },
      [291928] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 54.921427502934,
        ["y"] = -225.64891267312,
        ["g"] = 25,
        ["sublevel"] = 1,
      },
    },
  },
  [10] = {
    ["name"] = "Junkyard D.0.G.",
    ["id"] = 151773,
    ["count"] = 7,
    ["health"] = 213050,
    ["scale"] = 1.5,
    ["displayId"] = 90511,
    ["creatureType"] = "Mechanical",
    ["level"] = 80,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Disorient"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
    },
    ["spells"] = {
      [294107] = {
      },
      [1217817] = {
      },
      [1217821] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 732.99630988911,
        ["y"] = -355.57282096946,
        ["g"] = 15,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 722.14237018071,
        ["y"] = -345.30454626334,
        ["g"] = 15,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 719.39811970779,
        ["y"] = -358.70134851437,
        ["g"] = 15,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 661.81134599866,
        ["y"] = -316.56990213398,
        ["g"] = 17,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 670.17406209968,
        ["y"] = -328.53187655207,
        ["g"] = 17,
        ["sublevel"] = 1,
      },
      [6] = {
        ["x"] = 592.58018352754,
        ["y"] = -359.86587110171,
        ["g"] = 18,
        ["sublevel"] = 1,
      },
      [7] = {
        ["x"] = 598.61406327745,
        ["y"] = -373.09806610334,
        ["g"] = 18,
        ["sublevel"] = 1,
      },
      [8] = {
        ["x"] = 606.65924032951,
        ["y"] = -360.81855805836,
        ["g"] = 18,
        ["sublevel"] = 1,
      },
      [9] = {
        ["x"] = 658.74138180828,
        ["y"] = -386.22451529017,
        ["g"] = 16,
        ["sublevel"] = 1,
      },
      [10] = {
        ["x"] = 646.5677570776,
        ["y"] = -378.39101798304,
        ["g"] = 16,
        ["sublevel"] = 1,
      },
    },
  },
  [11] = {
    ["name"] = "Waste Processing Unit",
    ["id"] = 144293,
    ["count"] = 10,
    ["health"] = 392012,
    ["scale"] = 2,
    ["displayId"] = 92177,
    ["creatureType"] = "Mechanical",
    ["level"] = 81,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Stun"] = true,
    },
    ["spells"] = {
      [1215409] = {
      },
      [1215410] = {
      },
      [1215411] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 583.01555623145,
        ["y"] = -480.84286460657,
        ["g"] = 5,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 654.22241678261,
        ["y"] = -461.66934358626,
        ["g"] = 8,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 765.4666511604,
        ["y"] = -441.31777365149,
        ["g"] = 13,
        ["sublevel"] = 1,
      },
    },
  },
  [12] = {
    ["name"] = "Living Waste",
    ["id"] = 144301,
    ["count"] = 1,
    ["health"] = 21305,
    ["scale"] = 1.3,
    ["displayId"] = 92217,
    ["creatureType"] = "Elemental",
    ["level"] = 80,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Silence"] = true,
      ["Disorient"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
    },
    ["spells"] = {
    },
    ["clones"] = {
      [1] = {
        ["x"] = 622.50640138016,
        ["y"] = -449.94548922978,
        ["g"] = 7,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 730.59606980792,
        ["y"] = -388.4838769751,
        ["g"] = 14,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 633.55339238719,
        ["y"] = -455.5677671945,
        ["g"] = 7,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 634.80951661688,
        ["y"] = -468.90677631283,
        ["g"] = 7,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 624.26103844813,
        ["y"] = -476.27611995777,
        ["g"] = 7,
        ["sublevel"] = 1,
      },
      [6] = {
        ["x"] = 674.92690035992,
        ["y"] = -447.57169868405,
        ["g"] = 9,
        ["sublevel"] = 1,
      },
      [7] = {
        ["x"] = 679.43662562698,
        ["y"] = -472.50229321467,
        ["g"] = 9,
        ["sublevel"] = 1,
      },
      [8] = {
        ["x"] = 686.29685019227,
        ["y"] = -446.8230559462,
        ["g"] = 9,
        ["sublevel"] = 1,
      },
      [9] = {
        ["x"] = 690.77503815686,
        ["y"] = -470.60875605261,
        ["g"] = 9,
        ["sublevel"] = 1,
      },
      [10] = {
        ["x"] = 742.29264233645,
        ["y"] = -443.15480557951,
        ["g"] = 11,
        ["sublevel"] = 1,
      },
      [11] = {
        ["x"] = 732.92482385792,
        ["y"] = -449.91411062969,
        ["g"] = 11,
        ["sublevel"] = 1,
      },
      [12] = {
        ["x"] = 720.34343139104,
        ["y"] = -427.13649865635,
        ["g"] = 11,
        ["sublevel"] = 1,
      },
      [13] = {
        ["x"] = 731.0734050422,
        ["y"] = -423.0267979611,
        ["g"] = 11,
        ["sublevel"] = 1,
      },
      [14] = {
        ["x"] = 737.3865367384,
        ["y"] = -433.70814053162,
        ["g"] = 11,
        ["sublevel"] = 1,
      },
      [15] = {
        ["x"] = 688.41301888627,
        ["y"] = -458.91605894539,
        ["g"] = 9,
        ["sublevel"] = 1,
      },
      [16] = {
        ["x"] = 742.60796406048,
        ["y"] = -387.5980780927,
        ["g"] = 14,
        ["sublevel"] = 1,
      },
      [17] = {
        ["x"] = 755.05460552233,
        ["y"] = -386.60072438169,
        ["g"] = 14,
        ["sublevel"] = 1,
      },
      [18] = {
        ["x"] = 755.70673702987,
        ["y"] = -398.91925989431,
        ["g"] = 14,
        ["sublevel"] = 1,
      },
      [19] = {
        ["x"] = 731.6545224569,
        ["y"] = -401.10329665316,
        ["g"] = 14,
        ["sublevel"] = 1,
      },
    },
  },
  [13] = {
    ["name"] = "Omega Buster",
    ["id"] = 144249,
    ["count"] = 0,
    ["health"] = 1276856,
    ["scale"] = 2,
    ["displayId"] = 90998,
    ["creatureType"] = "Mechanical",
    ["level"] = 82,
    ["isBoss"] = true,
    ["encounterID"] = 2331,
    ["instanceID"] = 1178,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [283551] = {
      },
      [292264] = {
      },
      [292267] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 57.255059848105,
        ["y"] = -171.64039525721,
        ["g"] = 25,
        ["sublevel"] = 1,
      },
    },
  },
  [14] = {
    ["name"] = "Bomb Tonk",
    ["id"] = 151657,
    ["count"] = 4,
    ["health"] = 127830,
    ["scale"] = 1.5,
    ["displayId"] = 21209,
    ["creatureType"] = "Mechanical",
    ["level"] = 80,
    ["characteristics"] = {
      ["Silence"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
    },
    ["spells"] = {
      [301088] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 135.16090828123,
        ["y"] = -471.15077755979,
        ["g"] = 1,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 122.81822681056,
        ["y"] = -477.93875099676,
        ["g"] = 1,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 191.3770887574,
        ["y"] = -445.44915922961,
        ["g"] = 3,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 172.67272008179,
        ["y"] = -500.07162514911,
        ["g"] = 2,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 183.29639151419,
        ["y"] = -491.79204824591,
        ["g"] = 2,
        ["sublevel"] = 1,
      },
      [6] = {
        ["x"] = 195.24314585266,
        ["y"] = -483.5502330265,
        ["g"] = 2,
        ["sublevel"] = 1,
      },
    },
  },
  [15] = {
    ["name"] = "Rocket Tonk",
    ["id"] = 151659,
    ["count"] = 4,
    ["health"] = 213050,
    ["scale"] = 1.5,
    ["displayId"] = 91228,
    ["creatureType"] = "Mechanical",
    ["level"] = 80,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Silence"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
    },
    ["spells"] = {
      [294103] = {
      },
      [294128] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 115.69883144051,
        ["y"] = -465.02573008318,
        ["g"] = 1,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 128.04357989436,
        ["y"] = -458.73656471863,
        ["g"] = 1,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 184.34510954794,
        ["y"] = -433.12424072125,
        ["g"] = 3,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 135.62850756239,
        ["y"] = -438.66195463968,
        ["g"] = 4,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 147.95345523627,
        ["y"] = -432.61288343635,
        ["g"] = 4,
        ["sublevel"] = 1,
      },
      [6] = {
        ["x"] = 160.24047077091,
        ["y"] = -426.45044244855,
        ["g"] = 4,
        ["sublevel"] = 1,
      },
    },
  },
  [16] = {
    ["name"] = "Strider Tonk",
    ["id"] = 151658,
    ["count"] = 4,
    ["health"] = 281758,
    ["scale"] = 1.5,
    ["displayId"] = 91229,
    ["creatureType"] = "Mechanical",
    ["level"] = 80,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Silence"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
    },
    ["spells"] = {
      [294061] = {
      },
      [294064] = {
      },
      [294073] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 142.07075359483,
        ["y"] = -482.95110502142,
        ["g"] = 1,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 129.6928345422,
        ["y"] = -490.26681681786,
        ["g"] = 1,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 197.50177166916,
        ["y"] = -432.78399275577,
        ["g"] = 3,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 128.59648691968,
        ["y"] = -426.1857725146,
        ["g"] = 4,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 141.8288009492,
        ["y"] = -419.45622513395,
        ["g"] = 4,
        ["sublevel"] = 1,
      },
      [6] = {
        ["x"] = 153.81333122446,
        ["y"] = -412.80230581871,
        ["g"] = 4,
        ["sublevel"] = 1,
      },
      [7] = {
        ["x"] = 188.92948677062,
        ["y"] = -471.41434126312,
        ["g"] = 2,
        ["sublevel"] = 1,
      },
      [8] = {
        ["x"] = 176.86933020417,
        ["y"] = -479.35368273898,
        ["g"] = 2,
        ["sublevel"] = 1,
      },
      [9] = {
        ["x"] = 165.52732992503,
        ["y"] = -486.31005712576,
        ["g"] = 2,
        ["sublevel"] = 1,
      },
    },
  },
  [17] = {
    ["name"] = "The Platinum Pummeler",
    ["id"] = 144244,
    ["count"] = 0,
    ["health"] = 510742,
    ["scale"] = 2,
    ["displayId"] = 91216,
    ["creatureType"] = "Mechanical",
    ["level"] = 82,
    ["isBoss"] = true,
    ["encounterID"] = 2336,
    ["instanceID"] = 1178,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [282801] = {
      },
      [1215065] = {
      },
      [1215102] = {
      },
      [1215103] = {
      },
      [1215194] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 97.497601758237,
        ["y"] = -512.84528780816,
        ["g"] = 26,
        ["sublevel"] = 1,
      },
    },
  },
  [18] = {
    ["name"] = "Gnomercy 4.U.",
    ["id"] = 145185,
    ["count"] = 0,
    ["health"] = 1021484,
    ["scale"] = 2,
    ["displayId"] = 91879,
    ["creatureType"] = "Mechanical",
    ["level"] = 82,
    ["isBoss"] = true,
    ["encounterID"] = 2336,
    ["instanceID"] = 1178,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [283421] = {
      },
      [283422] = {
      },
      [283565] = {
      },
      [283640] = {
      },
      [285152] = {
      },
      [285377] = {
      },
      [1215039] = {
      },
      [1216431] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 82.991252333297,
        ["y"] = -467.2471648686,
        ["g"] = 26,
        ["sublevel"] = 1,
      },
    },
  },
  [19] = {
    ["name"] = "K.U.-J.0.",
    ["id"] = 144246,
    ["count"] = 0,
    ["health"] = 1361979,
    ["scale"] = 2,
    ["displayId"] = 90775,
    ["creatureType"] = "Mechanical",
    ["level"] = 82,
    ["isBoss"] = true,
    ["encounterID"] = 2339,
    ["instanceID"] = 1178,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [291922] = {
      },
      [291946] = {
      },
      [291949] = {
      },
      [291972] = {
      },
      [291973] = {
      },
      [292035] = {
      },
      [294929] = {
      },
      [294961] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 626.47597548249,
        ["y"] = -326.61653701844,
        ["sublevel"] = 1,
      },
    },
  },
  [20] = {
    ["name"] = "G.U.A.R.D.",
    ["id"] = 144303,
    ["count"] = 5,
    ["health"] = 281758,
    ["scale"] = 2,
    ["displayId"] = 68856,
    ["creatureType"] = "Mechanical",
    ["level"] = 80,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Fear"] = true,
      ["Disorient"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
    },
    ["spells"] = {
      [294107] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 290.29407792095,
        ["y"] = -260.29739663088,
        ["g"] = 19,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 280.5965926554,
        ["y"] = -277.61672798619,
        ["g"] = 19,
        ["sublevel"] = 1,
      },
    },
  },
  [21] = {
    ["name"] = "Metal Gunk",
    ["id"] = 236033,
    ["count"] = 7,
    ["health"] = 281758,
    ["scale"] = 1.5,
    ["displayId"] = 90423,
    ["creatureType"] = "Elemental",
    ["level"] = 80,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Fear"] = true,
      ["Disorient"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
    },
    ["spells"] = {
      [1215412] = {
      },
      [1215415] = {
      },
      [1216729] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 593.63967697048,
        ["y"] = -459.48080030276,
        ["g"] = 6,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 622.76097924413,
        ["y"] = -462.63730521202,
        ["g"] = 7,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 676.82789407374,
        ["y"] = -460.36794813013,
        ["g"] = 9,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 706.75306671943,
        ["y"] = -449.26998694814,
        ["g"] = 10,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 726.5853354879,
        ["y"] = -439.09772075552,
        ["g"] = 11,
        ["sublevel"] = 1,
      },
      [6] = {
        ["x"] = 754.76852859806,
        ["y"] = -424.87329150645,
        ["g"] = 12,
        ["sublevel"] = 1,
      },
      [7] = {
        ["x"] = 744.11092166986,
        ["y"] = -401.60595824662,
        ["g"] = 14,
        ["sublevel"] = 1,
      },
    },
  },
};
