local addonName = ...
local MDT = MDT
local L = MDT.L
local dungeonIndex = 101
MDT.dungeonList[dungeonIndex] = L["DawnOfTheInfiniteUpper"]
MDT.mapInfo[dungeonIndex] = {

};

local zones = { 2195, 2196, 2197 }
for _, zone in ipairs(zones) do
  MDT.zoneIdToDungeonIdx[zone] = dungeonIndex
end

MDT.dungeonMaps[dungeonIndex] = {
  [0] = "",
  [1] = { customTextures = 'DawnOfTheInfiniteUpper' },
}

MDT.dungeonSubLevels[dungeonIndex] = {
  [1] = L["dotiUpperSublevel1"],
}

MDT.dungeonTotalCount[dungeonIndex] = { normal = 335, teeming = 1000, teemingEnabled = true }

MDT.mapPOIs[dungeonIndex] = {
  [1] = {
    -- [1] = {
    --   ["template"] = "MapLinkPinTemplate",
    --   ["type"] = "generalNote",
    --   ["x"] = 190.55769429672,
    --   ["y"] = -416.07924421356,
    --   ["text"] = "dawnPortalNote", --,
    -- },
    -- TODO: need research on how the spawning works exactly
  },
};

MDT.dungeonEnemies[dungeonIndex] = {
  [1] = {
    ["name"] = "Tyr's Vanguard",
    ["id"] = 205151,
    ["count"] = 5,
    ["health"] = 1481125,
    ["scale"] = 1,
    ["displayId"] = 113780,
    ["creatureType"] = "Humanoid",
    ["level"] = 70,
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
      [412505] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 35.782782742766,
        ["y"] = -222.43215290391,
        ["g"] = 1,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 27.247763226402,
        ["y"] = -223.71575091191,
        ["g"] = 1,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 29.91180938348,
        ["y"] = -215.50151967076,
        ["g"] = 1,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 75.445505869733,
        ["y"] = -209.42961793749,
        ["g"] = 2,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [5] = {
        ["x"] = 83.798457838797,
        ["y"] = -175.20740821235,
        ["g"] = 3,
        ["sublevel"] = 1,
      },
      [6] = {
        ["x"] = 96.21980931139,
        ["y"] = -178.40784466888,
        ["g"] = 3,
        ["sublevel"] = 1,
      },
      [7] = {
        ["x"] = 54.304816664672,
        ["y"] = -172.7702359893,
        ["g"] = 4,
        ["sublevel"] = 1,
      },
      [8] = {
        ["x"] = 49.687078239512,
        ["y"] = -163.4348402096,
        ["g"] = 4,
        ["sublevel"] = 1,
      },
      [9] = {
        ["x"] = 42.0500116965,
        ["y"] = -136.88277915214,
        ["g"] = 5,
        ["sublevel"] = 1,
      },
      [10] = {
        ["x"] = 58.410902227138,
        ["y"] = -108.10298406949,
        ["g"] = 7,
        ["sublevel"] = 1,
      },
      [11] = {
        ["x"] = 114.26786941998,
        ["y"] = -120.74628677544,
        ["g"] = 8,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [12] = {
        ["x"] = 111.43732035823,
        ["y"] = -137.91857595871,
        ["g"] = 9,
        ["sublevel"] = 1,
      },
      [13] = {
        ["x"] = 115.51340166524,
        ["y"] = -156.15878076692,
        ["g"] = 10,
        ["sublevel"] = 1,
      },
      [14] = {
        ["x"] = 70.539126265463,
        ["y"] = -60.947583348074,
        ["g"] = 11,
        ["sublevel"] = 1,
      },
      [15] = {
        ["x"] = 70.317147825751,
        ["y"] = -51.623269358031,
        ["g"] = 11,
        ["sublevel"] = 1,
      },
      [16] = {
        ["x"] = 76.311327899312,
        ["y"] = -54.065362482109,
        ["g"] = 11,
        ["sublevel"] = 1,
      },
      [17] = {
        ["x"] = 50.558475206837,
        ["y"] = -54.287340921821,
        ["g"] = 13,
        ["sublevel"] = 1,
      },
      [18] = {
        ["x"] = 17.035411669415,
        ["y"] = -41.854960378497,
        ["g"] = 14,
        ["sublevel"] = 1,
      },
      [19] = {
        ["x"] = 25.915667153189,
        ["y"] = -42.52095921441,
        ["g"] = 14,
        ["sublevel"] = 1,
      },
      [20] = {
        ["x"] = 71.107791889134,
        ["y"] = -17.440486187181,
        ["g"] = 15,
        ["sublevel"] = 1,
      },
      [21] = {
        ["x"] = 82.826531281988,
        ["y"] = -214.45485930301,
        ["g"] = 2,
        ["sublevel"] = 1,
      },
    },
  },
  [2] = {
    ["name"] = "Infinite Twilight Magus",
    ["id"] = 201223,
    ["count"] = 5,
    ["health"] = 1333013,
    ["scale"] = 1,
    ["displayId"] = 110868,
    ["creatureType"] = "Dragonkin",
    ["level"] = 70,
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
      [400165] = {
      },
      [400180] = {
      },
      [413606] = {
      },
      [413607] = {
      },
    },
    ["clones"] = {
      [2] = {
        ["x"] = 88.660400502962,
        ["y"] = -182.78137665841,
        ["g"] = 3,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 61.753121936274,
        ["y"] = -168.72969326827,
        ["g"] = 4,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 56.980006222683,
        ["y"] = -159.58298075157,
        ["g"] = 4,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 49.675902244663,
        ["y"] = -138.7809717488,
        ["g"] = 5,
        ["sublevel"] = 1,
      },
      [6] = {
        ["x"] = 75.696386816345,
        ["y"] = -153.46787784523,
        ["g"] = 6,
        ["sublevel"] = 1,
      },
      [7] = {
        ["x"] = 74.752827271021,
        ["y"] = -134.03117100828,
        ["g"] = 6,
        ["sublevel"] = 1,
      },
      [8] = {
        ["x"] = 59.354418581053,
        ["y"] = -116.02861862305,
        ["g"] = 7,
        ["sublevel"] = 1,
      },
      [9] = {
        ["x"] = 66.902678986601,
        ["y"] = -108.85781874833,
        ["g"] = 7,
        ["sublevel"] = 1,
      },
      [10] = {
        ["x"] = 97.661787229733,
        ["y"] = -115.08510226913,
        ["g"] = 8,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
      [11] = {
        ["x"] = 97.77501346748,
        ["y"] = -154.08299079904,
        ["g"] = 10,
        ["sublevel"] = 1,
      },
      [12] = {
        ["x"] = 50.114442107279,
        ["y"] = -68.495815753309,
        ["g"] = 12,
        ["sublevel"] = 1,
      },
      [13] = {
        ["x"] = 22.141576357283,
        ["y"] = -34.750722962753,
        ["g"] = 14,
        ["sublevel"] = 1,
      },
      [14] = {
        ["x"] = 65.876994677152,
        ["y"] = -25.870442072267,
        ["g"] = 15,
        ["sublevel"] = 1,
      },
      [15] = {
        ["x"] = 75.867320206465,
        ["y"] = -26.536453611537,
        ["g"] = 15,
        ["sublevel"] = 1,
      },
    },
  },
  [3] = {
    ["name"] = "Valow, Timesworn Keeper",
    ["id"] = 201222,
    ["count"] = 20,
    ["health"] = 3554700,
    ["scale"] = 1,
    ["displayId"] = 111368,
    ["creatureType"] = "Mechanical",
    ["level"] = 71,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [412136] = {
      },
      [412137] = {
      },
      [412138] = {
      },
      [413024] = {
      },
      [413027] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 107.25663155595,
        ["y"] = -158.9263188759,
        ["g"] = 10,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
    },
  },
  [4] = {
    ["name"] = "Lerai, Timesworn Maiden",
    ["id"] = 205152,
    ["count"] = 20,
    ["health"] = 3554700,
    ["scale"] = 1,
    ["displayId"] = 108311,
    ["creatureType"] = "Mechanical",
    ["level"] = 71,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [412128] = {
      },
      [412129] = {
      },
      [412131] = {
      },
      [413023] = {
      },
      [418435] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 108.28587889899,
        ["y"] = -114.25014871078,
        ["g"] = 8,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
    },
  },
  [5] = {
    ["name"] = "Spurlok, Timesworn Sentinel",
    ["id"] = 205158,
    ["count"] = 20,
    ["health"] = 3554700,
    ["scale"] = 1,
    ["displayId"] = 105939,
    ["creatureType"] = "Humanoid",
    ["level"] = 71,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Mind Soothe"] = true,
    },
    ["spells"] = {
      [412215] = {
      },
      [412238] = {
      },
      [412242] = {
      },
      [412922] = {
      },
      [414922] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 74.621476311086,
        ["y"] = -144.2427477527,
        ["g"] = 6,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
    },
  },
  [6] = {
    ["name"] = "Tyr, the Infinite Keeper",
    ["id"] = 198998,
    ["count"] = 0,
    ["health"] = 9607339,
    ["scale"] = 1,
    ["displayId"] = 112999,
    ["creatureType"] = "Giant",
    ["level"] = 72,
    ["isBoss"] = true,
    ["encounterID"] = 2526,
    ["instanceID"] = 1209,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [400597] = {
      },
      [400641] = {
      },
      [400642] = {
      },
      [400649] = {
      },
      [400680] = {
      },
      [400681] = {
      },
      [400683] = {
      },
      [401248] = {
      },
      [401482] = {
      },
      [403724] = {
      },
      [410249] = {
      },
      [413595] = {
      },
      [414493] = {
      },
      [417339] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 137.9665728969,
        ["y"] = -140.42372978059,
        ["g"] = 16,
        ["sublevel"] = 1,
        ["scale"] = 1,
      },
    },
  },
  [7] = {
    ["name"] = "Infinite Watchkeeper",
    ["id"] = 207177,
    ["count"] = 15,
    ["health"] = 3776869,
    ["scale"] = 1,
    ["displayId"] = 113584,
    ["creatureType"] = "Dragonkin",
    ["level"] = 71,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Mind Soothe"] = true,
    },
    ["spells"] = {
      [413618] = {
      },
      [413621] = {
      },
      [413622] = {
      },
      [413623] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 240.64785825304,
        ["y"] = -132.69979097561,
        ["g"] = 17,
        ["sublevel"] = 1,
        ["scale"] = 1.6,
      },
    },
  },
  [8] = {
    ["name"] = "Timeline Marauder",
    ["id"] = 199748,
    ["count"] = 5,
    ["health"] = 1777350,
    ["scale"] = 1,
    ["displayId"] = 113587,
    ["creatureType"] = "Dragonkin",
    ["level"] = 71,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Mind Soothe"] = true,
    },
    ["spells"] = {
      [417481] = {
      },
      [419327] = {
      },
      [419328] = {
      },
      [419339] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 240.78514541294,
        ["y"] = -146.05862017288,
        ["g"] = 17,
        ["sublevel"] = 1,
        ["scale"] = 1.6,
      },
      [2] = {
        ["x"] = 681.95623488914,
        ["y"] = -301.43663797061,
        ["g"] = 35,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
      [3] = {
        ["x"] = 695.82377413379,
        ["y"] = -312.71082109477,
        ["g"] = 35,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
    },
  },
  [9] = {
    ["name"] = "Infinite Diversionist",
    ["id"] = 206230,
    ["count"] = 15,
    ["health"] = 3258475,
    ["scale"] = 1,
    ["displayId"] = 113583,
    ["creatureType"] = "Dragonkin",
    ["level"] = 71,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Mind Soothe"] = true,
    },
    ["spells"] = {
      [413618] = {
      },
      [413621] = {
      },
      [413622] = {
      },
      [413623] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 81.275124128482,
        ["y"] = -427.41686444062,
        ["g"] = 18,
        ["sublevel"] = 1,
        ["scale"] = 1.6,
      },
    },
  },
  [10] = {
    ["name"] = "Infinite Saboteur",
    ["id"] = 208438,
    ["count"] = 15,
    ["health"] = 3776869,
    ["scale"] = 1,
    ["displayId"] = 113585,
    ["creatureType"] = "Dragonkin",
    ["level"] = 71,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Mind Soothe"] = true,
    },
    ["spells"] = {
      [413618] = {
      },
      [413621] = {
      },
      [419351] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 81.231434300578,
        ["y"] = -401.59970645175,
        ["g"] = 18,
        ["sublevel"] = 1,
        ["scale"] = 1.6,
      },
    },
  },
  [11] = {
    ["name"] = "Temporal Fusion",
    ["id"] = 206068,
    ["count"] = 2,
    ["health"] = 933109,
    ["scale"] = 1,
    ["displayId"] = 41677,
    ["creatureType"] = "Elemental",
    ["level"] = 70,
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
      [413487] = {
      },
      [413489] = {
      },
      [418085] = {
      },
      [418086] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 156.36487082797,
        ["y"] = -414.37180839827,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 148.12855458317,
        ["y"] = -407.38299192842,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 149.15792353589,
        ["y"] = -423.50879710907,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 172.24365255131,
        ["y"] = -418.21515815828,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 146.75607265926,
        ["y"] = -368.26927003375,
        ["sublevel"] = 1,
      },
      [6] = {
        ["x"] = 154.99051383717,
        ["y"] = -340.13488026141,
        ["sublevel"] = 1,
      },
      [7] = {
        ["x"] = 166.99909842887,
        ["y"] = -331.9004390835,
        ["sublevel"] = 1,
      },
      [8] = {
        ["x"] = 233.21786207676,
        ["y"] = -376.1606588787,
        ["g"] = 21,
        ["sublevel"] = 1,
      },
      [9] = {
        ["x"] = 232.87464747439,
        ["y"] = -364.49507293236,
        ["g"] = 21,
        ["sublevel"] = 1,
      },
      [10] = {
        ["x"] = 250.71592825227,
        ["y"] = -383.36573525534,
        ["sublevel"] = 1,
      },
      [11] = {
        ["x"] = 242.13839026672,
        ["y"] = -399.49156006845,
        ["sublevel"] = 1,
      },
      [12] = {
        ["x"] = 284.68306191664,
        ["y"] = -418.36214952638,
        ["sublevel"] = 1,
      },
      [13] = {
        ["x"] = 263.75380326685,
        ["y"] = -426.93969732815,
        ["sublevel"] = 1,
      },
      [14] = {
        ["x"] = 214.38742354697,
        ["y"] = -482.04579442337,
        ["g"] = 24,
        ["sublevel"] = 1,
      },
      [15] = {
        ["x"] = 209.72529228558,
        ["y"] = -465.83926387965,
        ["g"] = 24,
        ["sublevel"] = 1,
      },
      [16] = {
        ["x"] = 190.85475260339,
        ["y"] = -489.72751219158,
        ["sublevel"] = 1,
      },
      [17] = {
        ["x"] = 179.53239642149,
        ["y"] = -455.9056538969,
        ["sublevel"] = 1,
      },
      [18] = {
        ["x"] = 152.44742602741,
        ["y"] = -461.97650583939,
        ["sublevel"] = 1,
      },
    },
  },
  [12] = {
    ["name"] = "Temporal Deviation",
    ["id"] = 206063,
    ["count"] = 0,
    ["health"] = 325848,
    ["scale"] = 1,
    ["displayId"] = 88582,
    ["creatureType"] = "Aberration",
    ["level"] = 70,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Incapacitate"] = true,
      ["Silence"] = true,
      ["Knock"] = true,
      ["Grip"] = true,
      ["Root"] = true,
      ["Fear"] = true,
      ["Banish"] = true,
      ["Disorient"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
      ["Sleep Walk"] = true,
    },
    ["spells"] = {
      [413473] = {
      },
      [413474] = {
      },
      [418085] = {
      },
      [418086] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 185.28740830098,
        ["y"] = -421.94989385761,
        ["sublevel"] = 1,
        ["scale"] = 0.8,
      },
      [2] = {
        ["x"] = 190.62550251104,
        ["y"] = -405.85335864289,
        ["sublevel"] = 1,
        ["scale"] = 0.8,
      },
      [3] = {
        ["x"] = 198.01233041915,
        ["y"] = -421.69662323085,
        ["sublevel"] = 1,
        ["scale"] = 0.8,
      },
    },
  },
  [13] = {
    ["name"] = "Infinite Riftmage",
    ["id"] = 208698,
    ["count"] = 5,
    ["health"] = 1925463,
    ["scale"] = 1,
    ["displayId"] = 110868,
    ["creatureType"] = "Dragonkin",
    ["level"] = 71,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Mind Soothe"] = true,
    },
    ["spells"] = {
      [418103] = {
      },
      [418200] = {
      },
      [418202] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 170.1020418568,
        ["y"] = -390.09434117326,
        ["g"] = 20,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
        ["patrol"] = {
          [1] = {
            ["x"] = 170.1020418568,
            ["y"] = -390.09434117326,
          },
          [2] = {
            ["x"] = 158.18069409659,
            ["y"] = -379.03078299974,
          },
          [3] = {
            ["x"] = 156.96325374761,
            ["y"] = -361.9863533924,
          },
          [4] = {
            ["x"] = 158.18069409659,
            ["y"] = -379.03078299974,
          },
          [5] = {
            ["x"] = 170.1020418568,
            ["y"] = -390.09434117326,
          },
          [6] = {
            ["x"] = 176.44257798563,
            ["y"] = -406.78882700528,
          },
          [7] = {
            ["x"] = 179.85149455907,
            ["y"] = -423.34628047303,
          },
          [8] = {
            ["x"] = 200.3047989417,
            ["y"] = -451.34782648108,
          },
          [9] = {
            ["x"] = 179.85149455907,
            ["y"] = -423.34628047303,
          },
          [10] = {
            ["x"] = 176.44257798563,
            ["y"] = -406.78882700528,
          },
        },
      },
      [2] = {
        ["x"] = 220.12357622703,
        ["y"] = -375.08384195234,
        ["g"] = 21,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
      [3] = {
        ["x"] = 213.85772594022,
        ["y"] = -349.82976553437,
        ["g"] = 22,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
        ["patrol"] = {
          [1] = {
            ["x"] = 213.85772594022,
            ["y"] = -349.82976553437,
          },
          [2] = {
            ["x"] = 208.33999270078,
            ["y"] = -337.53886715262,
          },
          [3] = {
            ["x"] = 195.92187821773,
            ["y"] = -328.52964137757,
          },
          [4] = {
            ["x"] = 208.33999270078,
            ["y"] = -337.53886715262,
          },
          [5] = {
            ["x"] = 213.85772594022,
            ["y"] = -349.82976553437,
          },
          [6] = {
            ["x"] = 221.97549180197,
            ["y"] = -357.26169339315,
          },
          [7] = {
            ["x"] = 242.18530811481,
            ["y"] = -367.24484358196,
          },
          [8] = {
            ["x"] = 250.95104582006,
            ["y"] = -367.00135551216,
          },
          [9] = {
            ["x"] = 258.49925958005,
            ["y"] = -376.25404149158,
          },
          [10] = {
            ["x"] = 250.95104582006,
            ["y"] = -367.00135551216,
          },
          [11] = {
            ["x"] = 242.18530811481,
            ["y"] = -367.24484358196,
          },
          [12] = {
            ["x"] = 221.97549180197,
            ["y"] = -357.26169339315,
          },
        },
      },
      [4] = {
        ["x"] = 223.53345704386,
        ["y"] = -469.38721492389,
        ["g"] = 24,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
    },
  },
  [14] = {
    ["name"] = "Timestream Anomaly",
    ["id"] = 199749,
    ["count"] = 3,
    ["health"] = 1777350,
    ["scale"] = 1,
    ["displayId"] = 93213,
    ["creatureType"] = "Aberration",
    ["level"] = 71,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [413529] = {
      },
      [413532] = {
      },
      [413536] = {
      },
      [413544] = {
      },
      [413547] = {
      },
      [418085] = {
      },
      [418086] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 142.36291980202,
        ["y"] = -434.53865628078,
        ["g"] = 19,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
        ["patrol"] = {
          [1] = {
            ["x"] = 142.36291980202,
            ["y"] = -434.53865628078,
          },
          [2] = {
            ["x"] = 129.67265419172,
            ["y"] = -420.33586626063,
          },
          [3] = {
            ["x"] = 128.69867404711,
            ["y"] = -396.23017116747,
          },
          [4] = {
            ["x"] = 129.67265419172,
            ["y"] = -420.33586626063,
          },
          [5] = {
            ["x"] = 142.36291980202,
            ["y"] = -434.53865628078,
          },
          [6] = {
            ["x"] = 147.93451021533,
            ["y"] = -447.85042219637,
          },
          [7] = {
            ["x"] = 171.55324310161,
            ["y"] = -460.26849488129,
          },
          [8] = {
            ["x"] = 188.35417070644,
            ["y"] = -475.60848013463,
          },
          [9] = {
            ["x"] = 196.63287654124,
            ["y"] = -486.07864129481,
          },
          [10] = {
            ["x"] = 196.87636461104,
            ["y"] = -499.22719212183,
          },
          [11] = {
            ["x"] = 188.06202499594,
            ["y"] = -512.52215155164,
          },
          [12] = {
            ["x"] = 196.87636461104,
            ["y"] = -499.22719212183,
          },
          [13] = {
            ["x"] = 196.63287654124,
            ["y"] = -486.07864129481,
          },
          [14] = {
            ["x"] = 188.35417070644,
            ["y"] = -475.60848013463,
          },
          [15] = {
            ["x"] = 171.55324310161,
            ["y"] = -460.26849488129,
          },
          [16] = {
            ["x"] = 147.93451021533,
            ["y"] = -447.85042219637,
          },
        },
      },
      [2] = {
        ["x"] = 215.20733683705,
        ["y"] = -415.13673688557,
        ["g"] = 23,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
        ["patrol"] = {
          [1] = {
            ["x"] = 215.20733683705,
            ["y"] = -415.13673688557,
          },
          [2] = {
            ["x"] = 214.13478197022,
            ["y"] = -390.71609865959,
          },
          [3] = {
            ["x"] = 190.27256101415,
            ["y"] = -380.48946040098,
          },
          [4] = {
            ["x"] = 179.80249041659,
            ["y"] = -359.06218980644,
          },
          [5] = {
            ["x"] = 167.62786400334,
            ["y"] = -337.87839334899,
          },
          [6] = {
            ["x"] = 157.8881740189,
            ["y"] = -329.84316165127,
          },
          [7] = {
            ["x"] = 167.62786400334,
            ["y"] = -337.87839334899,
          },
          [8] = {
            ["x"] = 179.80249041659,
            ["y"] = -359.06218980644,
          },
          [9] = {
            ["x"] = 190.27256101415,
            ["y"] = -380.48946040098,
          },
          [10] = {
            ["x"] = 214.13478197022,
            ["y"] = -390.71609865959,
          },
          [11] = {
            ["x"] = 215.20733683705,
            ["y"] = -415.13673688557,
          },
          [12] = {
            ["x"] = 219.24814289766,
            ["y"] = -436.4925802825,
          },
          [13] = {
            ["x"] = 233.37064600387,
            ["y"] = -444.04081494156,
          },
          [14] = {
            ["x"] = 254.79793053112,
            ["y"] = -451.58904960062,
          },
          [15] = {
            ["x"] = 233.37064600387,
            ["y"] = -444.04081494156,
          },
          [16] = {
            ["x"] = 219.24814289766,
            ["y"] = -436.4925802825,
          },
        },
      },
    },
  },
  [15] = {
    ["name"] = "Infinite Timebender",
    ["id"] = 205337,
    ["count"] = 8,
    ["health"] = 2073575,
    ["scale"] = 1,
    ["displayId"] = 110868,
    ["creatureType"] = "Dragonkin",
    ["level"] = 71,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Mind Soothe"] = true,
    },
    ["spells"] = {
      [411949] = {
      },
      [411952] = {
      },
      [411969] = {
      },
      [412029] = {
      },
      [412378] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 350.81640995308,
        ["y"] = -531.58388795073,
        ["g"] = 32,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
      [2] = {
        ["x"] = 507.58785999744,
        ["y"] = -461.98724078016,
        ["g"] = 34,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
    },
  },
  [16] = {
    ["name"] = "Time-Lost Wakethrasher",
    ["id"] = 205366,
    ["count"] = 1,
    ["health"] = 444338,
    ["scale"] = 1,
    ["displayId"] = 1762,
    ["creatureType"] = "Humanoid",
    ["level"] = 70,
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
    },
    ["clones"] = {
      [1] = {
        ["x"] = 334.07522471659,
        ["y"] = -531.48538315797,
        ["g"] = 32,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 365.8067961781,
        ["y"] = -536.73634467986,
        ["g"] = 32,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 365.57305068216,
        ["y"] = -523.41213707478,
        ["g"] = 32,
        ["sublevel"] = 1,
      },
    },
  },
  [17] = {
    ["name"] = "Time-Lost Waveshaper",
    ["id"] = 205363,
    ["count"] = 4,
    ["health"] = 1184900,
    ["scale"] = 1,
    ["displayId"] = 983,
    ["creatureType"] = "Humanoid",
    ["level"] = 70,
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
      [411300] = {
      },
      [411407] = {
      },
      [411610] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 334.45741262674,
        ["y"] = -519.14573202171,
        ["g"] = 32,
        ["sublevel"] = 1,
      },
    },
  },
  [18] = {
    ["name"] = "Time-Lost Tidehunter",
    ["id"] = 205365,
    ["count"] = 4,
    ["health"] = 1333013,
    ["scale"] = 1,
    ["displayId"] = 31,
    ["creatureType"] = "Humanoid",
    ["level"] = 70,
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
      [411644] = {
      },
      [411700] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 350.20634673575,
        ["y"] = -519.08009053684,
        ["g"] = 32,
        ["sublevel"] = 1,
      },
    },
  },
  [19] = {
    ["name"] = "Morchie",
    ["id"] = 198999,
    ["count"] = 0,
    ["health"] = 9311729,
    ["scale"] = 1,
    ["displayId"] = 111457,
    ["creatureType"] = "Aberration",
    ["level"] = 72,
    ["isBoss"] = true,
    ["encounterID"] = 2536,
    ["instanceID"] = 1209,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [403891] = {
      },
      [404916] = {
      },
      [404917] = {
      },
      [405279] = {
      },
      [406481] = {
      },
      [407504] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 434.03825111324,
        ["y"] = -496.04690867082,
        ["g"] = 33,
        ["sublevel"] = 1,
      },
    },
  },
  [20] = {
    ["name"] = "Time-Lost Smack-o-Tron",
    ["id"] = 205790,
    ["count"] = 1,
    ["health"] = 518394,
    ["scale"] = 1,
    ["displayId"] = 91293,
    ["creatureType"] = "Mechanical",
    ["level"] = 70,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Incapacitate"] = true,
      ["Silence"] = true,
      ["Knock"] = true,
      ["Grip"] = true,
      ["Root"] = true,
      ["Fear"] = true,
      ["Disorient"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
      ["Sleep Walk"] = true,
    },
    ["clones"] = {
      [1] = {
        ["x"] = 498.34222463343,
        ["y"] = -452.37054732113,
        ["g"] = 34,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 518.41860996585,
        ["y"] = -457.8140073543,
        ["g"] = 34,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 524.45078250228,
        ["y"] = -466.16063340512,
        ["g"] = 34,
        ["sublevel"] = 1,
      },
    },
  },
  [21] = {
    ["name"] = "Time-Lost Rocketeer",
    ["id"] = 205727,
    ["count"] = 4,
    ["health"] = 1481125,
    ["scale"] = 1,
    ["displayId"] = 91402,
    ["creatureType"] = "Mechanical",
    ["level"] = 70,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Incapacitate"] = true,
      ["Silence"] = true,
      ["Knock"] = true,
      ["Grip"] = true,
      ["Root"] = true,
      ["Fear"] = true,
      ["Disorient"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
      ["Sleep Walk"] = true,
    },
    ["spells"] = {
      [412233] = {
      },
      [412262] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 518.18070770462,
        ["y"] = -473.89034522982,
        ["g"] = 34,
        ["sublevel"] = 1,
      },
    },
  },
  [22] = {
    ["name"] = "Time-Lost Aerobot",
    ["id"] = 205723,
    ["count"] = 4,
    ["health"] = 1481125,
    ["scale"] = 1,
    ["displayId"] = 90548,
    ["creatureType"] = "Mechanical",
    ["level"] = 70,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Incapacitate"] = true,
      ["Silence"] = true,
      ["Knock"] = true,
      ["Grip"] = true,
      ["Root"] = true,
      ["Fear"] = true,
      ["Disorient"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
      ["Sleep Walk"] = true,
    },
    ["spells"] = {
      [412156] = {
      },
      [412181] = {
      },
      [412200] = {
      },
      [412225] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 492.82252358528,
        ["y"] = -463.40256363532,
        ["g"] = 34,
        ["sublevel"] = 1,
      },
    },
  },
  [23] = {
    ["name"] = "Alliance Conjuror",
    ["id"] = 206351,
    ["count"] = 0,
    ["health"] = 222169,
    ["scale"] = 1,
    ["displayId"] = 112993,
    ["creatureType"] = "Humanoid",
    ["level"] = 70,
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
      [417018] = {
      },
      [417026] = {
      },
      [417030] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 425.05874185482,
        ["y"] = -218.67265252633,
        ["g"] = 28,
        ["sublevel"] = 1,
      },
    },
  },
  [24] = {
    ["name"] = "Alliance Destroyer",
    ["id"] = 208208,
    ["count"] = 25,
    ["health"] = 4443375,
    ["scale"] = 1,
    ["displayId"] = 113517,
    ["creatureType"] = "Mechanical",
    ["level"] = 70,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [407205] = {
      },
      [407312] = {
      },
      [407313] = {
      },
      [407315] = {
      },
      [407317] = {
      },
      [418684] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 409.26402674094,
        ["y"] = -193.92511544416,
        ["g"] = 26,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
    },
  },
  [25] = {
    ["name"] = "Alliance Archer",
    ["id"] = 206352,
    ["count"] = 0,
    ["health"] = 266602,
    ["scale"] = 1,
    ["displayId"] = 88837,
    ["creatureType"] = "Humanoid",
    ["level"] = 70,
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
      [415215] = {
      },
      [418009] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 433.1589881757,
        ["y"] = -220.91553084706,
        ["g"] = 28,
        ["sublevel"] = 1,
      },
    },
  },
  [26] = {
    ["name"] = "Alliance Footman",
    ["id"] = 203763,
    ["count"] = 0,
    ["health"] = 296225,
    ["scale"] = 1,
    ["displayId"] = 86744,
    ["creatureType"] = "Humanoid",
    ["level"] = 70,
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
    },
    ["clones"] = {
      [1] = {
        ["x"] = 442.68738673816,
        ["y"] = -219.26034961154,
        ["g"] = 28,
        ["sublevel"] = 1,
      },
    },
  },
  [27] = {
    ["name"] = "Paladin of the Silver Hand",
    ["id"] = 208193,
    ["count"] = 8,
    ["health"] = 2369800,
    ["scale"] = 1,
    ["displayId"] = 113859,
    ["creatureType"] = "Humanoid",
    ["level"] = 70,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Mind Soothe"] = true,
    },
    ["spells"] = {
      [416999] = {
      },
      [417002] = {
      },
      [417011] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 433.87112192285,
        ["y"] = -175.95011063408,
        ["g"] = 27,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
    },
  },
  [28] = {
    ["name"] = "Pendule",
    ["id"] = 206074,
    ["count"] = 3,
    ["health"] = 947920,
    ["scale"] = 1,
    ["displayId"] = 74319,
    ["creatureType"] = "Elemental",
    ["level"] = 70,
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
      [413427] = {
      },
      [413428] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 341.39594462454,
        ["y"] = -215.98730174788,
        ["g"] = 25,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 351.14283062384,
        ["y"] = -225.69362223282,
        ["g"] = 25,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 541.08015208699,
        ["y"] = -263.51475022779,
        ["g"] = 31,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 531.20692859425,
        ["y"] = -263.92629719718,
        ["g"] = 31,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 533.84877123583,
        ["y"] = -255.89282850289,
        ["g"] = 31,
        ["sublevel"] = 1,
      },
      [6] = {
        ["x"] = 525.16963329453,
        ["y"] = -227.85858135462,
        ["g"] = 30,
        ["sublevel"] = 1,
      },
      [7] = {
        ["x"] = 531.90915911174,
        ["y"] = -232.17186060108,
        ["g"] = 30,
        ["sublevel"] = 1,
      },
      [8] = {
        ["x"] = 524.09135975942,
        ["y"] = -237.02430746609,
        ["g"] = 30,
        ["sublevel"] = 1,
      },
      [9] = {
        ["x"] = 509.26445849335,
        ["y"] = -207.90964170151,
        ["g"] = 29,
        ["sublevel"] = 1,
      },
      [10] = {
        ["x"] = 515.73434651203,
        ["y"] = -209.25755303515,
        ["g"] = 29,
        ["sublevel"] = 1,
      },
      [11] = {
        ["x"] = 510.34276287947,
        ["y"] = -215.45789580831,
        ["g"] = 29,
        ["sublevel"] = 1,
      },
    },
  },
  [29] = {
    ["name"] = "Infinite Slayer",
    ["id"] = 208440,
    ["count"] = 15,
    ["health"] = 3776869,
    ["scale"] = 1,
    ["displayId"] = 113771,
    ["creatureType"] = "Dragonkin",
    ["level"] = 71,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Mind Soothe"] = true,
    },
    ["spells"] = {
      [413622] = {
      },
      [413623] = {
      },
      [419351] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 681.97332705066,
        ["y"] = -317.49687026157,
        ["g"] = 35,
        ["sublevel"] = 1,
        ["scale"] = 1.7,
      },
    },
  },
  [30] = {
    ["name"] = "Chrono-Lord Deios",
    ["id"] = 199000,
    ["count"] = 0,
    ["health"] = 106419752,
    ["scale"] = 1,
    ["displayId"] = 106056,
    ["creatureType"] = "Dragonkin",
    ["level"] = 72,
    ["isBoss"] = true,
    ["encounterID"] = 2538,
    ["instanceID"] = 1209,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Mind Soothe"] = true,
    },
    ["spells"] = {
      [410904] = {
      },
      [410908] = {
      },
      [416139] = {
      },
      [416152] = {
      },
      [416264] = {
      },
      [416265] = {
      },
      [416266] = {
      },
      [416290] = {
      },
      [417413] = {
      },
      [419596] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 791.11904422728,
        ["y"] = -394.00266829176,
        ["g"] = 36,
        ["sublevel"] = 1,
      },
    },
  },
  [31] = {
    ["name"] = "Infinite Keeper",
    ["id"] = 205212,
    ["count"] = 0,
    ["health"] = 1333013,
    ["scale"] = 1,
    ["displayId"] = 112687,
    ["creatureType"] = "Dragonkin",
    ["level"] = 71,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Mind Soothe"] = true,
    },
    ["spells"] = {
      [411763] = {
      },
      [412027] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 773.39972457374,
        ["y"] = -365.86447858037,
        ["g"] = 36,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 805.64968930261,
        ["y"] = -366.53962282682,
        ["g"] = 36,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 772.22979479297,
        ["y"] = -415.71428086646,
        ["g"] = 36,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 808.17766827882,
        ["y"] = -417.24279930711,
        ["g"] = 36,
        ["sublevel"] = 1,
      },
    },
  },
  [32] = {
    ["name"] = "Time-Displaced Trooper",
    ["id"] = 205265,
    ["count"] = 0,
    ["health"] = 355470,
    ["scale"] = 1,
    ["displayId"] = 112511,
    ["creatureType"] = "Dragonkin",
    ["level"] = 70,
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
      [411023] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 766.39874908701,
        ["y"] = -356.91769957485,
        ["g"] = 36,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 777.7394638447,
        ["y"] = -356.54025261782,
        ["g"] = 36,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 800.10117678271,
        ["y"] = -355.80220642204,
        ["g"] = 36,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 812.15886019168,
        ["y"] = -356.9155556425,
        ["g"] = 36,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 768.45461163661,
        ["y"] = -424.56453105247,
        ["g"] = 36,
        ["sublevel"] = 1,
      },
      [6] = {
        ["x"] = 777.45517475087,
        ["y"] = -425.0741153938,
        ["g"] = 36,
        ["sublevel"] = 1,
      },
      [7] = {
        ["x"] = 810.25179626448,
        ["y"] = -427.67820491287,
        ["g"] = 36,
        ["sublevel"] = 1,
      },
      [8] = {
        ["x"] = 817.19545930748,
        ["y"] = -420.90369716843,
        ["g"] = 36,
        ["sublevel"] = 1,
      },
    },
  },
  [33] = {
    ["name"] = "Anduin Lothar",
    ["id"] = 203679,
    ["count"] = 0,
    ["health"] = 7685871,
    ["scale"] = 1,
    ["displayId"] = 112018,
    ["creatureType"] = "Humanoid",
    ["level"] = 72,
    ["isBoss"] = true,
    ["encounterID"] = 2534,
    ["instanceID"] = 1209,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Mind Soothe"] = true,
    },
    ["spells"] = {
      [410234] = {
      },
      [410235] = {
      },
      [410236] = {
      },
      [410238] = {
      },
      [410497] = {
      },
      [418047] = {
      },
      [418054] = {
      },
      [418056] = {
      },
      [418059] = {
      },
      [418061] = {
      },
      [418062] = {
      },
      [419609] = {
      },
      [419611] = {
      },
      [419616] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 433.63426381181,
        ["y"] = -207.37945454993,
        ["g"] = 28,
        ["sublevel"] = 1,
      },
    },
  },
  [34] = {
    ["name"] = "Chronaxie",
    ["id"] = 206070,
    ["count"] = 6,
    ["health"] = 1895840,
    ["scale"] = 1,
    ["displayId"] = 90738,
    ["creatureType"] = "Aberration",
    ["level"] = 71,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [419511] = {
      },
      [419512] = {
      },
      [419516] = {
      },
      [419517] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 340.29346629328,
        ["y"] = -227.11735423284,
        ["g"] = 25,
        ["sublevel"] = 1,
        ["scale"] = 1.4,
      },
    },
  },
  [35] = {
    ["name"] = "Alliance Knight",
    ["id"] = 208165,
    ["count"] = 5,
    ["health"] = 1481125,
    ["scale"] = 1,
    ["displayId"] = 113860,
    ["creatureType"] = "Humanoid",
    ["level"] = 71,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Mind Soothe"] = true,
    },
    ["spells"] = {
      [407124] = {
      },
      [407125] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 441.84828870429,
        ["y"] = -168.27651468121,
        ["g"] = 27,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 425.43093651634,
        ["y"] = -167.60260390903,
        ["g"] = 27,
        ["sublevel"] = 1,
      },
    },
  },
};
