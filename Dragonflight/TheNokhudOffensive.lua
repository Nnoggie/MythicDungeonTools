local MDT = MDT
local L = MDT.L

local dungeonIndex = 43
MDT.dungeonList[dungeonIndex] = L["TheNokhudOffensive"]
MDT.mapInfo[dungeonIndex] = {};

local zones = { 2093 }
for _, zone in ipairs(zones) do
  MDT.zoneIdToDungeonIdx[zone] = dungeonIndex
end

MDT.dungeonMaps[dungeonIndex] = {
  [0] = "",
  [1] = { customTextures = 'NokhudOffensive' },
}

MDT.dungeonSubLevels[dungeonIndex] = {
  [1] = L["TheNokhudOffensive"],
}

MDT.dungeonTotalCount[dungeonIndex] = { normal = 520, teeming = 1000, teemingEnabled = true }

MDT.mapPOIs[dungeonIndex] = {};

MDT.dungeonEnemies[dungeonIndex] = {
  [1] = {
    ["name"] = "Nokhud Warspear",
    ["id"] = 192791,
    ["count"] = 6,
    ["health"] = 717007,
    ["scale"] = 1,
    ["displayId"] = 108672,
    ["creatureType"] = "Humanoid",
    ["level"] = 70,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Silence"] = true,
      ["Root"] = true,
      ["Fear"] = true,
      ["Disorient"] = true,
      ["Stun"] = true,
    };
    ["spells"] = {
      [381683] = {
      };
      [381692] = {
      };
      [384134] = {
      };
    };
    ["clones"] = {
      [1] = {
        ["x"] = 598.71144710723,
        ["y"] = -42.872146835377,
        ["g"] = 1,
        ["sublevel"] = 1,
        ["scale"] = 1.8,
      };
      [2] = {
        ["x"] = 651.3906370964,
        ["y"] = -88.647039322276,
        ["g"] = 2,
        ["sublevel"] = 1,
        ["scale"] = 1.8,
        ["patrol"] = {
        };
      };
      [3] = {
        ["x"] = 636.09588135484,
        ["y"] = -92.000211220131,
        ["g"] = 2,
        ["sublevel"] = 1,
        ["scale"] = 1.8,
      };
      [4] = {
        ["x"] = 552.24925930569,
        ["y"] = -139.20328337007,
        ["g"] = 3,
        ["sublevel"] = 1,
        ["scale"] = 1.8,
      };
      [5] = {
        ["x"] = 606.93744159471,
        ["y"] = -228.17774801732,
        ["g"] = 4,
        ["sublevel"] = 1,
        ["scale"] = 1.8,
      };
      [6] = {
        ["x"] = 616.89564620254,
        ["y"] = -215.05996970704,
        ["g"] = 4,
        ["sublevel"] = 1,
        ["scale"] = 1.8,
      };
      [7] = {
        ["x"] = 617.74605315834,
        ["y"] = -155.76112850364,
        ["g"] = 5,
        ["sublevel"] = 1,
        ["scale"] = 1.8,
      };
      [8] = {
        ["x"] = 605.12164820176,
        ["y"] = -146.70125062266,
        ["g"] = 5,
        ["sublevel"] = 1,
        ["scale"] = 1.8,
      };
      [9] = {
        ["x"] = 722.52732874458,
        ["y"] = -144.35143015383,
        ["g"] = 6,
        ["sublevel"] = 1,
        ["scale"] = 1.8,
      };
      [10] = {
        ["x"] = 668.64823089035,
        ["y"] = -20.773276082988,
        ["g"] = 7,
        ["sublevel"] = 1,
        ["scale"] = 1.8,
      };
      [11] = {
        ["x"] = 708.86832518275,
        ["y"] = -79.199968816677,
        ["g"] = 8,
        ["sublevel"] = 1,
        ["scale"] = 1.8,
      };
      [12] = {
        ["x"] = 316.89662805494,
        ["y"] = -150.11873990935,
        ["g"] = 38,
        ["sublevel"] = 1,
        ["scale"] = 1.6,
      };
      [13] = {
        ["x"] = 317.35453772128,
        ["y"] = -165.19940429269,
        ["g"] = 38,
        ["sublevel"] = 1,
        ["scale"] = 1.6,
      };
      [14] = {
        ["x"] = 302.17635515076,
        ["y"] = -108.03646269106,
        ["g"] = 39,
        ["sublevel"] = 1,
        ["scale"] = 1.6,
      };
      [15] = {
        ["x"] = 299.40074338004,
        ["y"] = -123.47351499376,
        ["g"] = 39,
        ["sublevel"] = 1,
        ["scale"] = 1.6,
      };
      [16] = {
        ["x"] = 242.93098018678,
        ["y"] = -121.26598505112,
        ["g"] = 41,
        ["sublevel"] = 1,
        ["scale"] = 1.6,
      };
      [17] = {
        ["x"] = 244.10813995752,
        ["y"] = -139.94891284002,
        ["g"] = 41,
        ["sublevel"] = 1,
        ["scale"] = 1.6,
      };
      [18] = {
        ["x"] = 197.26835998874,
        ["y"] = -172.59557719644,
        ["g"] = 46,
        ["sublevel"] = 1,
        ["scale"] = 1.6,
      };
      [19] = {
        ["x"] = 173.6433265702,
        ["y"] = -172.55786264766,
        ["g"] = 46,
        ["sublevel"] = 1,
        ["scale"] = 1.6,
      };
      [20] = {
        ["x"] = 221.75568393927,
        ["y"] = -65.657936882827,
        ["g"] = 43,
        ["sublevel"] = 1,
        ["scale"] = 1.6,
      };
      [21] = {
        ["x"] = 189.62622291607,
        ["y"] = -53.100372601536,
        ["g"] = 43,
        ["sublevel"] = 1,
        ["scale"] = 1.6,
      };
    };
  };
  [2] = {
    ["name"] = "Nokhud Longbow",
    ["id"] = 192789,
    ["count"] = 5,
    ["health"] = 645307,
    ["scale"] = 1,
    ["displayId"] = 108667,
    ["creatureType"] = "Humanoid",
    ["level"] = 70,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Incapacitate"] = true,
      ["Silence"] = true,
      ["Root"] = true,
      ["Fear"] = true,
      ["Disorient"] = true,
      ["Imprison"] = true,
      ["Stun"] = true,
    };
    ["spells"] = {
      [373392] = {
      };
      [384476] = {
      };
      [384479] = {
      };
      [384868] = {
      };
    };
    ["clones"] = {
      [1] = {
        ["x"] = 589.31669476741,
        ["y"] = -57.675516129569,
        ["g"] = 1,
        ["sublevel"] = 1,
        ["scale"] = 1.8,
      };
      [2] = {
        ["x"] = 601.14986235661,
        ["y"] = -63.655659177477,
        ["g"] = 1,
        ["sublevel"] = 1,
        ["scale"] = 1.8,
      };
      [3] = {
        ["x"] = 641.33704259176,
        ["y"] = -77.165249871031,
        ["g"] = 2,
        ["sublevel"] = 1,
        ["scale"] = 1.8,
      };
      [4] = {
        ["x"] = 567.69843028815,
        ["y"] = -140.80886000363,
        ["g"] = 3,
        ["sublevel"] = 1,
        ["scale"] = 1.8,
      };
      [5] = {
        ["x"] = 565.94573534516,
        ["y"] = -157.3354056411,
        ["g"] = 3,
        ["sublevel"] = 1,
        ["scale"] = 1.8,
      };
      [6] = {
        ["x"] = 594.69359207611,
        ["y"] = -229.92011057201,
        ["g"] = 4,
        ["sublevel"] = 1,
        ["scale"] = 1.8,
      };
      [7] = {
        ["x"] = 613.91504382202,
        ["y"] = -190.9415443336,
        ["g"] = 4,
        ["sublevel"] = 1,
        ["scale"] = 1.8,
      };
      [8] = {
        ["x"] = 616.83393061989,
        ["y"] = -122.40259826079,
        ["g"] = 5,
        ["sublevel"] = 1,
        ["scale"] = 1.8,
      };
      [9] = {
        ["x"] = 603.49907781993,
        ["y"] = -129.56042622461,
        ["g"] = 5,
        ["sublevel"] = 1,
        ["scale"] = 1.8,
      };
      [10] = {
        ["x"] = 684.98318798538,
        ["y"] = -26.401991440099,
        ["g"] = 7,
        ["sublevel"] = 1,
        ["scale"] = 1.8,
      };
      [11] = {
        ["x"] = 672.99946949495,
        ["y"] = -36.161361067405,
        ["g"] = 7,
        ["sublevel"] = 1,
        ["scale"] = 1.8,
      };
      [12] = {
        ["x"] = 727.10464651704,
        ["y"] = -99.223747455392,
        ["g"] = 8,
        ["sublevel"] = 1,
        ["scale"] = 1.8,
      };
      [13] = {
        ["x"] = 691.79006569381,
        ["y"] = -195.28167950437,
        ["g"] = 9,
        ["sublevel"] = 1,
        ["scale"] = 1.8,
      };
      [14] = {
        ["x"] = 677.97719394232,
        ["y"] = -202.9073934385,
        ["g"] = 9,
        ["sublevel"] = 1,
        ["scale"] = 1.8,
      };
    };
  };
  [3] = {
    ["name"] = "Nokhud Hornsounder",
    ["id"] = 192796,
    ["count"] = 5,
    ["health"] = 573606,
    ["scale"] = 1,
    ["displayId"] = 108597,
    ["creatureType"] = "Humanoid",
    ["level"] = 70,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Incapacitate"] = true,
      ["Silence"] = true,
      ["Polymorph"] = true,
      ["Root"] = true,
      ["Fear"] = true,
      ["Disorient"] = true,
      ["Imprison"] = true,
      ["Stun"] = true,
    };
    ["spells"] = {
      [373392] = {
      };
      [383823] = {
      };
    };
    ["clones"] = {
      [1] = {
        ["x"] = 611.20877118366,
        ["y"] = -53.841939841074,
        ["g"] = 1,
        ["sublevel"] = 1,
        ["scale"] = 1.8,
      };
      [2] = {
        ["x"] = 549.71219844959,
        ["y"] = -154.48955162219,
        ["g"] = 3,
        ["sublevel"] = 1,
        ["scale"] = 1.8,
      };
      [3] = {
        ["x"] = 617.16799332484,
        ["y"] = -202.40616902941,
        ["g"] = 4,
        ["sublevel"] = 1,
        ["scale"] = 1.8,
      };
      [4] = {
        ["x"] = 719.26461107989,
        ["y"] = -154.64406430751,
        ["g"] = 6,
        ["sublevel"] = 1,
        ["scale"] = 1.8,
      };
      [5] = {
        ["x"] = 724.42358695032,
        ["y"] = -82.595937770678,
        ["g"] = 8,
        ["sublevel"] = 1,
        ["scale"] = 1.8,
      };
      [6] = {
        ["x"] = 697.63172945141,
        ["y"] = -179.2149783773,
        ["g"] = 9,
        ["sublevel"] = 1,
        ["scale"] = 1.8,
      };
    };
  };
  [4] = {
    ["name"] = "Nokhud Beastmaster",
    ["id"] = 192794,
    ["count"] = 5,
    ["health"] = 717007,
    ["scale"] = 1,
    ["displayId"] = 108670,
    ["creatureType"] = "Humanoid",
    ["level"] = 70,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Incapacitate"] = true,
      ["Silence"] = true,
      ["Root"] = true,
      ["Fear"] = true,
      ["Disorient"] = true,
      ["Stun"] = true,
    };
    ["spells"] = {
      [383690] = {
      };
      [383693] = {
      };
      [384492] = {
      };
    };
    ["clones"] = {
      [1] = {
        ["x"] = 583.69303126778,
        ["y"] = -230.92584576767,
        ["g"] = 4,
        ["sublevel"] = 1,
        ["scale"] = 1.8,
      };
      [2] = {
        ["x"] = 740.40818833248,
        ["y"] = -137.68480211987,
        ["g"] = 6,
        ["sublevel"] = 1,
        ["scale"] = 1.8,
      };
      [3] = {
        ["x"] = 656.81122912578,
        ["y"] = -33.585134525053,
        ["g"] = 7,
        ["sublevel"] = 1,
        ["scale"] = 1.8,
      };
      [4] = {
        ["x"] = 664.58407262047,
        ["y"] = -198.10368292023,
        ["g"] = 9,
        ["sublevel"] = 1,
        ["scale"] = 1.8,
      };
    };
  };
  [5] = {
    ["name"] = "Nokhud Plainstomper",
    ["id"] = 191847,
    ["count"] = 8,
    ["health"] = 1290613,
    ["scale"] = 1,
    ["displayId"] = 108673,
    ["creatureType"] = "Humanoid",
    ["level"] = 71,
    ["characteristics"] = {
      ["Taunt"] = true,
    };
    ["spells"] = {
      [384336] = {
      };
      [384365] = {
      };
    };
    ["clones"] = {
      [1] = {
        ["x"] = 622.05760204141,
        ["y"] = -227.77842741156,
        ["g"] = 4,
        ["sublevel"] = 1,
        ["scale"] = 2,
        ["patrol"] = {
        };
      };
      [2] = {
        ["x"] = 726.07568919079,
        ["y"] = -126.8218504147,
        ["g"] = 6,
        ["sublevel"] = 1,
        ["scale"] = 2,
        ["patrol"] = {
        };
      };
    };
  };
  [6] = {
    ["name"] = "War Ohuna",
    ["id"] = 192803,
    ["count"] = 0,
    ["health"] = 286803,
    ["scale"] = 1,
    ["displayId"] = 101437,
    ["creatureType"] = "Beast",
    ["level"] = 70,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Silence"] = true,
      ["Fear"] = true,
      ["Disorient"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
    };
    ["spells"] = {
      [334610] = {
      };
    };
    ["clones"] = {
      [1] = {
        ["x"] = 577.87681318284,
        ["y"] = -219.6853677805,
        ["g"] = 4,
        ["sublevel"] = 1,
        ["scale"] = 1.5,
      };
      [2] = {
        ["x"] = 751.80798485429,
        ["y"] = -144.41893811619,
        ["g"] = 6,
        ["sublevel"] = 1,
        ["scale"] = 1.5,
      };
      [3] = {
        ["x"] = 648.73196031653,
        ["y"] = -23.370931153545,
        ["g"] = 7,
        ["sublevel"] = 1,
        ["scale"] = 1.5,
      };
      [4] = {
        ["x"] = 658.35613807881,
        ["y"] = -184.26717798472,
        ["g"] = 9,
        ["sublevel"] = 1,
        ["scale"] = 1.5,
      };
    };
  };
  [7] = {
    ["name"] = "Nokhud Lancemaster",
    ["id"] = 192800,
    ["count"] = 10,
    ["health"] = 1290613,
    ["scale"] = 1,
    ["displayId"] = 108528,
    ["iconTexture"] = 135127,
    ["creatureType"] = "Humanoid",
    ["level"] = 71,
    ["characteristics"] = {
      ["Taunt"] = true,
    };
    ["spells"] = {
      [384336] = {
      };
      [384365] = {
      };
      [384510] = {
      };
      [384512] = {
      };
    };
    ["clones"] = {
      [1] = {
        ["x"] = 623.88125236757,
        ["y"] = -138.64281931434,
        ["g"] = 5,
        ["sublevel"] = 1,
        ["scale"] = 2.6,
      };
      [2] = {
        ["x"] = 710.89088668566,
        ["y"] = -97.727944085612,
        ["g"] = 8,
        ["sublevel"] = 1,
        ["scale"] = 2.6,
      };
      [3] = {
        ["x"] = 678.45206413343,
        ["y"] = -181.20657496265,
        ["g"] = 9,
        ["sublevel"] = 1,
        ["scale"] = 2.6,
      };
    };
  };
  [8] = {
    ["name"] = "Granyth",
    ["id"] = 186616,
    ["count"] = 0,
    ["health"] = 5437189,
    ["scale"] = 1,
    ["displayId"] = 105823,
    ["creatureType"] = "Dragonkin",
    ["level"] = 72,
    ["isBoss"] = true,
    ["encounterID"] = 2498,
    ["instanceID"] = 1198,
    ["characteristics"] = {
      ["Taunt"] = true,
    };
    ["spells"] = {
      [385916] = {
      };
      [387155] = {
      };
      [388283] = {
      };
      [388817] = {
      };
    };
    ["clones"] = {
      [1] = {
        ["x"] = 674.28886712046,
        ["y"] = -130.17610366968,
        ["sublevel"] = 1,
        ["scale"] = 2,
      };
    };
  };
  [9] = {
    ["name"] = "Primalist Arcblade",
    ["id"] = 194898,
    ["count"] = 6,
    ["health"] = 860408,
    ["scale"] = 1,
    ["displayId"] = 109038,
    ["creatureType"] = "Humanoid",
    ["level"] = 70,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Silence"] = true,
      ["Root"] = true,
      ["Fear"] = true,
      ["Disorient"] = true,
      ["Sap"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
    };
    ["spells"] = {
      [387135] = {
      };
    };
    ["clones"] = {
      [1] = {
        ["x"] = 725.86730389567,
        ["y"] = -402.81932458114,
        ["g"] = 10,
        ["sublevel"] = 1,
        ["scale"] = 1.8,
      };
      [2] = {
        ["x"] = 703.51048518282,
        ["y"] = -380.62554362137,
        ["g"] = 10,
        ["sublevel"] = 1,
        ["scale"] = 1.8,
      };
      [3] = {
        ["x"] = 588.99149656006,
        ["y"] = -355.52460871858,
        ["g"] = 11,
        ["sublevel"] = 1,
        ["scale"] = 1.8,
      };
      [4] = {
        ["x"] = 676.67786153366,
        ["y"] = -500.93901146968,
        ["g"] = 16,
        ["sublevel"] = 1,
        ["scale"] = 1.8,
      };
      [5] = {
        ["x"] = 705.01299519196,
        ["y"] = -497.81591287067,
        ["g"] = 16,
        ["sublevel"] = 1,
        ["scale"] = 1.8,
      };
    };
  };
  [10] = {
    ["name"] = "Stormcaller Boroo",
    ["id"] = 194317,
    ["count"] = 10,
    ["health"] = 1147211,
    ["scale"] = 1,
    ["displayId"] = 108819,
    ["iconTexture"] = 136048,
    ["creatureType"] = "Humanoid",
    ["level"] = 71,
    ["characteristics"] = {
      ["Taunt"] = true,
    };
    ["spells"] = {
      [386012] = {
      };
      [387145] = {
      };
    };
    ["clones"] = {
      [1] = {
        ["x"] = 706.01914860866,
        ["y"] = -400.90334608501,
        ["g"] = 10,
        ["sublevel"] = 1,
        ["scale"] = 2.4,
      };
    };
  };
  [11] = {
    ["name"] = "Stormsurge Totem",
    ["id"] = 194897,
    ["count"] = 0,
    ["health"] = 344163,
    ["scale"] = 1,
    ["displayId"] = 107517,
    ["creatureType"] = "Not specified",
    ["level"] = 70,
    ["characteristics"] = {
      ["Taunt"] = true,
    };
    ["spells"] = {
      [382628] = {
      };
      [384881] = {
      };
      [386694] = {
      };
      [387146] = {
      };
    };
    ["clones"] = {
      [1] = {
        ["x"] = 718.71361744441,
        ["y"] = -388.67225898447,
        ["g"] = 10,
        ["sublevel"] = 1,
        ["scale"] = 1.5,
      };
      [2] = {
        ["x"] = 593.25898310523,
        ["y"] = -371.29445966481,
        ["g"] = 11,
        ["sublevel"] = 1,
        ["scale"] = 1.5,
      };
      [3] = {
        ["x"] = 602.70823573467,
        ["y"] = -457.62626533584,
        ["g"] = 13,
        ["sublevel"] = 1,
        ["scale"] = 1.5,
      };
      [4] = {
        ["x"] = 692.90422899244,
        ["y"] = -494.86171273125,
        ["g"] = 16,
        ["sublevel"] = 1,
        ["scale"] = 1.5,
      };
    };
  };
  [12] = {
    ["name"] = "Primalist Thunderbeast",
    ["id"] = 195696,
    ["count"] = 12,
    ["health"] = 1434014,
    ["scale"] = 1,
    ["displayId"] = 110545,
    ["creatureType"] = "Beast",
    ["level"] = 71,
    ["characteristics"] = {
      ["Taunt"] = true,
    };
    ["spells"] = {
      [386028] = {
      };
      [387125] = {
      };
      [387127] = {
      };
    };
    ["clones"] = {
      [1] = {
        ["x"] = 685.34127871679,
        ["y"] = -348.6439209623,
        ["sublevel"] = 1,
        ["scale"] = 2,
      };
      [2] = {
        ["x"] = 515.37186811784,
        ["y"] = -385.71458258803,
        ["sublevel"] = 1,
        ["scale"] = 2,
      };
      [3] = {
        ["x"] = 649.40299058414,
        ["y"] = -379.63730568641,
        ["g"] = 19,
        ["sublevel"] = 1,
        ["scale"] = 2,
        ["patrol"] = {
        };
      };
    };
  };
  [13] = {
    ["name"] = "Primalist Stormspeaker",
    ["id"] = 194894,
    ["count"] = 6,
    ["health"] = 717007,
    ["scale"] = 1,
    ["displayId"] = 108711,
    ["creatureType"] = "Humanoid",
    ["level"] = 70,
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
    };
    ["spells"] = {
      [386012] = {
      };
      [386015] = {
      };
      [386022] = {
      };
      [386024] = {
      };
      [386025] = {
      };
    };
    ["clones"] = {
      [1] = {
        ["x"] = 587.01722729556,
        ["y"] = -385.83995178738,
        ["g"] = 11,
        ["sublevel"] = 1,
        ["scale"] = 1.8,
      };
      [2] = {
        ["x"] = 541.94287413513,
        ["y"] = -467.50636413763,
        ["g"] = 12,
        ["sublevel"] = 1,
        ["scale"] = 1.8,
      };
      [3] = {
        ["x"] = 602.94585110057,
        ["y"] = -473.10979319172,
        ["g"] = 13,
        ["sublevel"] = 1,
        ["scale"] = 1.8,
      };
      [4] = {
        ["x"] = 702.44519029658,
        ["y"] = -481.46154503219,
        ["g"] = 16,
        ["sublevel"] = 1,
        ["scale"] = 1.8,
      };
    };
  };
  [14] = {
    ["name"] = "Unstable Squall",
    ["id"] = 194895,
    ["count"] = 0,
    ["health"] = 286803,
    ["scale"] = 1,
    ["displayId"] = 101201,
    ["creatureType"] = "Elemental",
    ["level"] = 70,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Silence"] = true,
      ["Root"] = true,
      ["Fear"] = true,
      ["Banish"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
    };
    ["spells"] = {
      [386018] = {
      };
      [386019] = {
      };
      [386026] = {
      };
    };
    ["clones"] = {
      [1] = {
        ["x"] = 602.80570089669,
        ["y"] = -384.05698536096,
        ["g"] = 11,
        ["sublevel"] = 1,
        ["scale"] = 1.8,
      };
      [2] = {
        ["x"] = 551.11444454937,
        ["y"] = -455.28078606648,
        ["g"] = 12,
        ["sublevel"] = 1,
        ["scale"] = 1.2,
      };
      [3] = {
        ["x"] = 687.72399792051,
        ["y"] = -507.06620965775,
        ["g"] = 16,
        ["sublevel"] = 1,
        ["scale"] = 1.2,
      };
      [4] = {
        ["x"] = 592.80652186748,
        ["y"] = -479.84224485441,
        ["g"] = 13,
        ["sublevel"] = 1,
        ["scale"] = 1.2,
      };
    };
  };
  [15] = {
    ["name"] = "Stormcaller Arynga",
    ["id"] = 195265,
    ["count"] = 10,
    ["health"] = 1147211,
    ["scale"] = 1,
    ["displayId"] = 108819,
    ["iconTexture"] = 136048,
    ["creatureType"] = "Humanoid",
    ["level"] = 71,
    ["spells"] = {
      [386012] = {
      };
      [387145] = {
      };
    };
    ["clones"] = {
      [1] = {
        ["x"] = 577.53591711446,
        ["y"] = -371.79799989783,
        ["g"] = 11,
        ["sublevel"] = 1,
        ["scale"] = 2.4,
      };
    };
  };
  [16] = {
    ["name"] = "Primal Stormshield",
    ["id"] = 194896,
    ["count"] = 7,
    ["health"] = 932110,
    ["scale"] = 1,
    ["displayId"] = 108335,
    ["creatureType"] = "Elemental",
    ["level"] = 70,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Incapacitate"] = true,
      ["Silence"] = true,
      ["Root"] = true,
      ["Fear"] = true,
      ["Disorient"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
    };
    ["spells"] = {
      [386223] = {
      };
      [386225] = {
      };
      [386227] = {
      };
      [386228] = {
      };
    };
    ["clones"] = {
      [1] = {
        ["x"] = 542.65161437896,
        ["y"] = -444.17208916018,
        ["g"] = 12,
        ["sublevel"] = 1,
        ["scale"] = 1.8,
      };
      [2] = {
        ["x"] = 590.17238896107,
        ["y"] = -448.28961115083,
        ["g"] = 13,
        ["sublevel"] = 1,
        ["scale"] = 1.8,
      };
      [3] = {
        ["x"] = 632.17570381348,
        ["y"] = -501.41172321869,
        ["g"] = 15,
        ["sublevel"] = 1,
        ["scale"] = 1.8,
      };
      [4] = {
        ["x"] = 627.82732431338,
        ["y"] = -510.0516246107,
        ["g"] = 15,
        ["sublevel"] = 1,
        ["scale"] = 1.8,
      };
      [5] = {
        ["x"] = 653.42142069538,
        ["y"] = -462.90970823111,
        ["g"] = 17,
        ["sublevel"] = 1,
        ["scale"] = 1.8,
      };
      [6] = {
        ["x"] = 665.57960454259,
        ["y"] = -456.19196056471,
        ["g"] = 17,
        ["sublevel"] = 1,
        ["scale"] = 1.8,
      };
      [7] = {
        ["x"] = 702.92409865973,
        ["y"] = -435.44227318791,
        ["g"] = 18,
        ["sublevel"] = 1,
        ["scale"] = 1.8,
      };
      [8] = {
        ["x"] = 719.28492828943,
        ["y"] = -440.00443558361,
        ["g"] = 18,
        ["sublevel"] = 1,
        ["scale"] = 1.8,
      };
      [9] = {
        ["x"] = 632.21635204639,
        ["y"] = -382.09574150537,
        ["g"] = 19,
        ["sublevel"] = 1,
        ["scale"] = 1.8,
      };
      [10] = {
        ["x"] = 637.34575554476,
        ["y"] = -366.74862279186,
        ["g"] = 19,
        ["sublevel"] = 1,
        ["scale"] = 1.8,
      };
    };
  };
  [17] = {
    ["name"] = "Nokhud Neophyte",
    ["id"] = 196263,
    ["count"] = 5,
    ["health"] = 717007,
    ["scale"] = 1,
    ["displayId"] = 108223,
    ["creatureType"] = "Humanoid",
    ["level"] = 70,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Silence"] = true,
      ["Fear"] = true,
      ["Stun"] = true,
    };
    ["spells"] = {
      [386012] = {
      };
    };
    ["clones"] = {
      [1] = {
        ["x"] = 528.18718210083,
        ["y"] = -437.17067946461,
        ["g"] = 12,
        ["sublevel"] = 1,
        ["scale"] = 1.8,
      };
      [2] = {
        ["x"] = 529.13534322565,
        ["y"] = -475.49141908511,
        ["g"] = 12,
        ["sublevel"] = 1,
        ["scale"] = 1.8,
      };
      [3] = {
        ["x"] = 614.05875039995,
        ["y"] = -504.58515512194,
        ["g"] = 15,
        ["sublevel"] = 1,
        ["scale"] = 1.8,
      };
      [4] = {
        ["x"] = 623.66032374168,
        ["y"] = -489.91050479647,
        ["g"] = 15,
        ["sublevel"] = 1,
        ["scale"] = 1.8,
      };
      [5] = {
        ["x"] = 699.88535937445,
        ["y"] = -448.93149531822,
        ["g"] = 18,
        ["sublevel"] = 1,
        ["scale"] = 1.8,
      };
      [6] = {
        ["x"] = 714.41364418207,
        ["y"] = -452.42840059021,
        ["g"] = 18,
        ["sublevel"] = 1,
        ["scale"] = 1.8,
      };
    };
  };
  [18] = {
    ["name"] = "Stormcaller Solongo",
    ["id"] = 194315,
    ["count"] = 10,
    ["health"] = 1147211,
    ["scale"] = 1,
    ["displayId"] = 108818,
    ["iconTexture"] = 136048,
    ["creatureType"] = "Humanoid",
    ["level"] = 71,
    ["characteristics"] = {
      ["Taunt"] = true,
    };
    ["spells"] = {
      [386012] = {
      };
      [387145] = {
      };
    };
    ["clones"] = {
      [1] = {
        ["x"] = 587.58592676919,
        ["y"] = -465.61398435038,
        ["g"] = 13,
        ["sublevel"] = 1,
        ["scale"] = 2.4,
      };
    };
  };
  [19] = {
    ["name"] = "Primal Gust",
    ["id"] = 195579,
    ["count"] = 0,
    ["health"] = 286803,
    ["scale"] = 1,
    ["displayId"] = 102511,
    ["creatureType"] = "Elemental",
    ["level"] = 70,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Root"] = true,
      ["Stun"] = true,
    };
    ["spells"] = {
      [386319] = {
      };
    };
    ["clones"] = {
      [1] = {
        ["x"] = 601.4361340159,
        ["y"] = -431.44901261575,
        ["g"] = 14,
        ["sublevel"] = 1,
        ["scale"] = 1.2,
      };
      [2] = {
        ["x"] = 609.49874964682,
        ["y"] = -427.11427276579,
        ["g"] = 14,
        ["sublevel"] = 1,
        ["scale"] = 1.2,
      };
      [3] = {
        ["x"] = 604.59470579592,
        ["y"] = -416.8438760083,
        ["g"] = 14,
        ["sublevel"] = 1,
        ["scale"] = 1.2,
      };
      [4] = {
        ["x"] = 598.19090054472,
        ["y"] = -422.54182928752,
        ["g"] = 14,
        ["sublevel"] = 1,
        ["scale"] = 1.2,
      };
    };
  };
  [20] = {
    ["name"] = "Stormcaller Zarii",
    ["id"] = 194316,
    ["count"] = 10,
    ["health"] = 1147211,
    ["scale"] = 1,
    ["displayId"] = 108818,
    ["iconTexture"] = 136048,
    ["creatureType"] = "Humanoid",
    ["level"] = 71,
    ["characteristics"] = {
      ["Taunt"] = true,
    };
    ["spells"] = {
      [386012] = {
      };
      [387145] = {
      };
    };
    ["clones"] = {
      [1] = {
        ["x"] = 681.99881682077,
        ["y"] = -482.36209293677,
        ["g"] = 16,
        ["sublevel"] = 1,
        ["scale"] = 2.4,
      };
    };
  };
  [21] = {
    ["name"] = "The Raging Tempest",
    ["id"] = 186615,
    ["count"] = 0,
    ["health"] = 7154196,
    ["scale"] = 1,
    ["displayId"] = 107145,
    ["creatureType"] = "Elemental",
    ["level"] = 72,
    ["isBoss"] = true,
    ["encounterID"] = 2497,
    ["instanceID"] = 1198,
    ["characteristics"] = {
      ["Taunt"] = true,
    };
    ["spells"] = {
      [382628] = {
      };
      [384185] = {
      };
      [384186] = {
      };
      [384316] = {
      };
      [384620] = {
      };
      [384628] = {
      };
      [384686] = {
      };
      [384687] = {
      };
      [384761] = {
      };
      [386914] = {
      };
      [386915] = {
      };
      [386916] = {
      };
      [391967] = {
      };
      [394875] = {
      };
    };
    ["clones"] = {
      [1] = {
        ["x"] = 646.66698682159,
        ["y"] = -424.82493730035,
        ["sublevel"] = 1,
        ["scale"] = 2.2,
      };
    };
  };
  [22] = {
    ["name"] = "Ukhel Corruptor",
    ["id"] = 195842,
    ["count"] = 5,
    ["health"] = 717007,
    ["scale"] = 1,
    ["displayId"] = 109006,
    ["creatureType"] = "Humanoid",
    ["level"] = 70,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Incapacitate"] = true,
      ["Silence"] = true,
      ["Root"] = true,
      ["Fear"] = true,
      ["Disorient"] = true,
      ["Imprison"] = true,
      ["Stun"] = true,
    };
    ["spells"] = {
      [387608] = {
      };
      [387611] = {
      };
      [387613] = {
      };
    };
    ["clones"] = {
      [1] = {
        ["x"] = 325.84125926815,
        ["y"] = -408.26424068891,
        ["g"] = 20,
        ["sublevel"] = 1,
        ["scale"] = 1.8,
      };
      [2] = {
        ["x"] = 318.58361165643,
        ["y"] = -422.0427368402,
        ["g"] = 20,
        ["sublevel"] = 1,
        ["scale"] = 1.8,
      };
      [3] = {
        ["x"] = 206.0768102459,
        ["y"] = -474.79079543986,
        ["g"] = 27,
        ["sublevel"] = 1,
        ["scale"] = 1.8,
      };
      [4] = {
        ["x"] = 155.2382347869,
        ["y"] = -389.18803597929,
        ["g"] = 30,
        ["sublevel"] = 1,
        ["scale"] = 1.8,
      };
      [5] = {
        ["x"] = 137.43845816631,
        ["y"] = -414.5630726741,
        ["g"] = 30,
        ["sublevel"] = 1,
        ["scale"] = 1.8,
      };
      [6] = {
        ["x"] = 177.10097487988,
        ["y"] = -346.08467408416,
        ["g"] = 31,
        ["sublevel"] = 1,
        ["scale"] = 1.8,
      };
      [7] = {
        ["x"] = 223.17560824603,
        ["y"] = -417.04309872254,
        ["g"] = 32,
        ["sublevel"] = 1,
        ["scale"] = 1.8,
      };
      [8] = {
        ["x"] = 237.69809084039,
        ["y"] = -423.46558211687,
        ["g"] = 32,
        ["sublevel"] = 1,
        ["scale"] = 1.8,
      };
      [9] = {
        ["x"] = 230.79282615545,
        ["y"] = -458.28482122082,
        ["g"] = 27,
        ["sublevel"] = 1,
        ["scale"] = 1.8,
      };
      [10] = {
        ["x"] = 186.71697578284,
        ["y"] = -356.39875008054,
        ["g"] = 31,
        ["sublevel"] = 1,
        ["scale"] = 1.8,
        ["patrol"] = {
        };
      };
      [11] = {
        ["x"] = 219.51216214297,
        ["y"] = -389.73198766598,
        ["g"] = 33,
        ["sublevel"] = 1,
        ["scale"] = 1.8,
      };
    };
  };
  [23] = {
    ["name"] = "Soulharvester Galtmaa",
    ["id"] = 195927,
    ["count"] = 10,
    ["health"] = 1147211,
    ["scale"] = 1,
    ["displayId"] = 109014,
    ["iconTexture"] = 136214,
    ["creatureType"] = "Humanoid",
    ["level"] = 71,
    ["characteristics"] = {
      ["Taunt"] = true,
    };
    ["spells"] = {
      [387411] = {
      };
      [388318] = {
      };
      [395035] = {
      };
    };
    ["clones"] = {
      [1] = {
        ["x"] = 304.07532167275,
        ["y"] = -380.63303373332,
        ["g"] = 21,
        ["sublevel"] = 1,
        ["scale"] = 2.4,
      };
    };
  };
  [24] = {
    ["name"] = "Ukhel Beastcaller",
    ["id"] = 195878,
    ["count"] = 6,
    ["health"] = 1003810,
    ["scale"] = 1,
    ["displayId"] = 109021,
    ["creatureType"] = "Humanoid",
    ["level"] = 70,
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
    };
    ["spells"] = {
      [387440] = {
      };
      [387826] = {
      };
    };
    ["clones"] = {
      [1] = {
        ["x"] = 321.49416291281,
        ["y"] = -469.46746243925,
        ["g"] = 22,
        ["sublevel"] = 1,
        ["scale"] = 1.8,
      };
      [2] = {
        ["x"] = 289.49925279185,
        ["y"] = -490.45593250811,
        ["g"] = 25,
        ["sublevel"] = 1,
        ["scale"] = 1.8,
      };
      [3] = {
        ["x"] = 190.07381309824,
        ["y"] = -507.51175883978,
        ["g"] = 28,
        ["sublevel"] = 1,
        ["scale"] = 1.8,
      };
      [4] = {
        ["x"] = 245.95617902414,
        ["y"] = -329.34125345002,
        ["g"] = 35,
        ["sublevel"] = 1,
        ["scale"] = 1.8,
      };
    };
  };
  [25] = {
    ["name"] = "Desecrated Ohuna",
    ["id"] = 195876,
    ["count"] = 2,
    ["health"] = 573606,
    ["scale"] = 1,
    ["displayId"] = 109019,
    ["creatureType"] = "Undead",
    ["level"] = 70,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Incapacitate"] = true,
      ["Silence"] = true,
      ["Root"] = true,
      ["Fear"] = true,
      ["Disorient"] = true,
      ["Stun"] = true,
    };
    ["spells"] = {
      [387629] = {
      };
    };
    ["clones"] = {
      [1] = {
        ["x"] = 305.07132274924,
        ["y"] = -363.12285707626,
        ["g"] = 21,
        ["sublevel"] = 1,
        ["scale"] = 1.6,
      };
      [2] = {
        ["x"] = 319.80498434914,
        ["y"] = -369.48820111042,
        ["g"] = 21,
        ["sublevel"] = 1,
        ["scale"] = 1.6,
      };
      [3] = {
        ["x"] = 333.82559176286,
        ["y"] = -465.73549656886,
        ["g"] = 22,
        ["sublevel"] = 1,
        ["scale"] = 1.6,
      };
      [4] = {
        ["x"] = 293.67020555665,
        ["y"] = -440.77432427914,
        ["g"] = 23,
        ["sublevel"] = 1,
        ["scale"] = 1.6,
      };
      [5] = {
        ["x"] = 282.11950555378,
        ["y"] = -431.90358344489,
        ["g"] = 23,
        ["sublevel"] = 1,
        ["scale"] = 1.6,
      };
      [6] = {
        ["x"] = 280.50313879367,
        ["y"] = -445.41019115341,
        ["g"] = 23,
        ["sublevel"] = 1,
        ["scale"] = 1.6,
        ["patrol"] = {
        };
      };
      [7] = {
        ["x"] = 244.47634510866,
        ["y"] = -377.58902732879,
        ["g"] = 33,
        ["sublevel"] = 1,
        ["scale"] = 1.6,
      };
      [8] = {
        ["x"] = 232.86230031413,
        ["y"] = -333.9340349938,
        ["g"] = 35,
        ["sublevel"] = 1,
        ["scale"] = 1.6,
      };
      [9] = {
        ["x"] = 258.3544097838,
        ["y"] = -334.50325897318,
        ["g"] = 35,
        ["sublevel"] = 1,
        ["scale"] = 1.6,
      };
      [10] = {
        ["x"] = 225.46712946703,
        ["y"] = -376.60203429837,
        ["g"] = 33,
        ["sublevel"] = 1,
        ["scale"] = 1.6,
      };
      [11] = {
        ["x"] = 296.70222939415,
        ["y"] = -504.18620207974,
        ["g"] = 25,
        ["sublevel"] = 1,
        ["scale"] = 1.6,
      };
    };
  };
  [26] = {
    ["name"] = "Desecrated Bakar",
    ["id"] = 195875,
    ["count"] = 1,
    ["health"] = 286803,
    ["scale"] = 1,
    ["displayId"] = 109018,
    ["creatureType"] = "Undead",
    ["level"] = 70,
    ["characteristics"] = {
      ["Silence"] = true,
      ["Fear"] = true,
      ["Disorient"] = true,
      ["Stun"] = true,
    };
    ["spells"] = {
    };
    ["clones"] = {
      [1] = {
        ["x"] = 326.05721945306,
        ["y"] = -481.48591022142,
        ["g"] = 22,
        ["sublevel"] = 1,
        ["scale"] = 1.5,
      };
      [2] = {
        ["x"] = 336.57796037073,
        ["y"] = -477.09015301746,
        ["g"] = 22,
        ["sublevel"] = 1,
        ["scale"] = 1.5,
      };
      [3] = {
        ["x"] = 194.15016177796,
        ["y"] = -522.69857049415,
        ["g"] = 28,
        ["sublevel"] = 1,
        ["scale"] = 1.5,
      };
      [4] = {
        ["x"] = 178.71544961749,
        ["y"] = -512.25211792171,
        ["g"] = 28,
        ["sublevel"] = 1,
        ["scale"] = 1.5,
      };
      [5] = {
        ["x"] = 200.95073249252,
        ["y"] = -515.38772108573,
        ["g"] = 28,
        ["sublevel"] = 1,
        ["scale"] = 1.5,
      };
      [6] = {
        ["x"] = 183.20041451236,
        ["y"] = -522.39128124109,
        ["g"] = 28,
        ["sublevel"] = 1,
        ["scale"] = 1.5,
      };
      [7] = {
        ["x"] = 239.76862111877,
        ["y"] = -344.22356360278,
        ["g"] = 35,
        ["sublevel"] = 1,
        ["scale"] = 1.5,
      };
      [8] = {
        ["x"] = 250.43318538837,
        ["y"] = -344.00823430618,
        ["g"] = 35,
        ["sublevel"] = 1,
        ["scale"] = 1.5,
      };
    };
  };
  [27] = {
    ["name"] = "Risen Mystic",
    ["id"] = 195877,
    ["count"] = 5,
    ["health"] = 573606,
    ["scale"] = 1,
    ["displayId"] = 109020,
    ["creatureType"] = "Undead",
    ["level"] = 70,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Silence"] = true,
      ["Root"] = true,
      ["Fear"] = true,
      ["Disorient"] = true,
      ["Stun"] = true,
    };
    ["spells"] = {
      [387596] = {
      };
    };
    ["clones"] = {
      [1] = {
        ["x"] = 270.2943799811,
        ["y"] = -411.48789422611,
        ["g"] = 24,
        ["sublevel"] = 1,
        ["scale"] = 1.8,
      };
      [2] = {
        ["x"] = 263.19659550596,
        ["y"] = -484.75613100452,
        ["g"] = 25,
        ["sublevel"] = 1,
        ["scale"] = 1.8,
      };
      [3] = {
        ["x"] = 263.23751542409,
        ["y"] = -530.01198587259,
        ["g"] = 26,
        ["sublevel"] = 1,
        ["scale"] = 1.8,
      };
      [4] = {
        ["x"] = 228.05570581918,
        ["y"] = -471.40534898704,
        ["g"] = 27,
        ["sublevel"] = 1,
        ["scale"] = 1.8,
      };
      [5] = {
        ["x"] = 162.44609325213,
        ["y"] = -441.48751896995,
        ["g"] = 29,
        ["sublevel"] = 1,
        ["scale"] = 1.8,
      };
      [6] = {
        ["x"] = 189.45759932441,
        ["y"] = -410.23961249036,
        ["g"] = 29,
        ["sublevel"] = 1,
        ["scale"] = 1.8,
      };
      [7] = {
        ["x"] = 161.88697309374,
        ["y"] = -341.02546904928,
        ["g"] = 31,
        ["sublevel"] = 1,
        ["scale"] = 1.8,
      };
      [8] = {
        ["x"] = 138.77597465637,
        ["y"] = -386.60070267283,
        ["g"] = 30,
        ["sublevel"] = 1,
        ["scale"] = 1.8,
      };
    };
  };
  [28] = {
    ["name"] = "Ukhel Deathspeaker",
    ["id"] = 195851,
    ["count"] = 6,
    ["health"] = 860408,
    ["scale"] = 1,
    ["displayId"] = 109035,
    ["creatureType"] = "Humanoid",
    ["level"] = 70,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Incapacitate"] = true,
      ["Silence"] = true,
      ["Polymorph"] = true,
      ["Root"] = true,
      ["Fear"] = true,
      ["Disorient"] = true,
      ["Imprison"] = true,
      ["Stun"] = true,
    };
    ["spells"] = {
      [387614] = {
      };
      [387615] = {
      };
      [387616] = {
      };
      [396376] = {
      };
    };
    ["clones"] = {
      [1] = {
        ["x"] = 286.51052709556,
        ["y"] = -410.42636225483,
        ["g"] = 24,
        ["sublevel"] = 1,
        ["scale"] = 1.8,
        ["patrol"] = {
        };
      };
      [2] = {
        ["x"] = 277.33792563429,
        ["y"] = -481.95177046,
        ["g"] = 25,
        ["sublevel"] = 1,
        ["scale"] = 1.8,
      };
      [3] = {
        ["x"] = 275.18253395385,
        ["y"] = -516.67707748718,
        ["g"] = 26,
        ["sublevel"] = 1,
        ["scale"] = 1.8,
      };
      [4] = {
        ["x"] = 213.95930895535,
        ["y"] = -462.02091477102,
        ["g"] = 27,
        ["sublevel"] = 1,
        ["scale"] = 2,
        ["patrol"] = {
        };
      };
      [5] = {
        ["x"] = 190.38411520345,
        ["y"] = -441.1858362484,
        ["g"] = 29,
        ["sublevel"] = 1,
        ["scale"] = 2,
      };
      [6] = {
        ["x"] = 252.23674749573,
        ["y"] = -390.91719475209,
        ["g"] = 33,
        ["sublevel"] = 1,
        ["scale"] = 1.8,
      };
      [7] = {
        ["x"] = 320.39424536316,
        ["y"] = -381.95896665073,
        ["g"] = 21,
        ["sublevel"] = 1,
        ["scale"] = 1.8,
      };
    };
  };
  [29] = {
    ["name"] = "Risen Warrior",
    ["id"] = 195855,
    ["count"] = 5,
    ["health"] = 717007,
    ["scale"] = 1,
    ["displayId"] = 109017,
    ["creatureType"] = "Undead",
    ["level"] = 70,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Silence"] = true,
      ["Root"] = true,
      ["Fear"] = true,
      ["Disorient"] = true,
      ["Stun"] = true,
    };
    ["spells"] = {
      [388801] = {
      };
    };
    ["clones"] = {
      [1] = {
        ["x"] = 277.21002663947,
        ["y"] = -397.91961047376,
        ["g"] = 24,
        ["sublevel"] = 1,
        ["scale"] = 1.8,
      };
      [2] = {
        ["x"] = 248.70873730885,
        ["y"] = -527.60036590901,
        ["g"] = 26,
        ["sublevel"] = 1,
        ["scale"] = 1.8,
      };
      [3] = {
        ["x"] = 216.60866413864,
        ["y"] = -481.25050057604,
        ["g"] = 27,
        ["sublevel"] = 1,
        ["scale"] = 1.8,
      };
      [4] = {
        ["x"] = 176.50311920312,
        ["y"] = -443.81319583279,
        ["g"] = 29,
        ["sublevel"] = 1,
        ["scale"] = 1.8,
      };
      [5] = {
        ["x"] = 189.86983078101,
        ["y"] = -425.27781955104,
        ["g"] = 29,
        ["sublevel"] = 1,
        ["scale"] = 1.8,
      };
      [6] = {
        ["x"] = 184.00291382446,
        ["y"] = -371.44502725314,
        ["g"] = 31,
        ["sublevel"] = 1,
        ["scale"] = 1.8,
      };
      [7] = {
        ["x"] = 127.54216388217,
        ["y"] = -403.40180735588,
        ["g"] = 30,
        ["sublevel"] = 1,
        ["scale"] = 1.8,
      };
      [8] = {
        ["x"] = 241.90572674634,
        ["y"] = -513.27450349811,
        ["g"] = 26,
        ["sublevel"] = 1,
        ["scale"] = 1.8,
      };
      [9] = {
        ["x"] = 290.23066907902,
        ["y"] = -370.13714790613,
        ["g"] = 21,
        ["sublevel"] = 1,
        ["scale"] = 1.8,
      };
    };
  };
  [30] = {
    ["name"] = "Soulharvester Tumen",
    ["id"] = 195929,
    ["count"] = 10,
    ["health"] = 1147211,
    ["scale"] = 1,
    ["displayId"] = 109036,
    ["iconTexture"] = 136214,
    ["creatureType"] = "Humanoid",
    ["level"] = 71,
    ["spells"] = {
      [387411] = {
      };
      [388318] = {
      };
      [395035] = {
      };
    };
    ["clones"] = {
      [1] = {
        ["x"] = 258.66919682705,
        ["y"] = -509.76228576678,
        ["g"] = 26,
        ["sublevel"] = 1,
        ["scale"] = 2.4,
      };
    };
  };
  [31] = {
    ["name"] = "Soulharvester Mandakh",
    ["id"] = 195930,
    ["count"] = 10,
    ["health"] = 1147211,
    ["scale"] = 1,
    ["displayId"] = 109037,
    ["iconTexture"] = 136214,
    ["creatureType"] = "Humanoid",
    ["level"] = 71,
    ["characteristics"] = {
      ["Taunt"] = true,
    };
    ["spells"] = {
      [387411] = {
      };
      [388318] = {
      };
      [395035] = {
      };
    };
    ["clones"] = {
      [1] = {
        ["x"] = 151.27567764635,
        ["y"] = -405.39387324041,
        ["g"] = 30,
        ["sublevel"] = 1,
        ["scale"] = 2.4,
      };
    };
  };
  [32] = {
    ["name"] = "Soulharvester Duuren",
    ["id"] = 195928,
    ["count"] = 10,
    ["health"] = 1147211,
    ["scale"] = 1,
    ["displayId"] = 109015,
    ["iconTexture"] = 136214,
    ["creatureType"] = "Humanoid",
    ["level"] = 71,
    ["characteristics"] = {
      ["Taunt"] = true,
    };
    ["spells"] = {
      [387411] = {
      };
      [388318] = {
      };
      [395035] = {
      };
    };
    ["clones"] = {
      [1] = {
        ["x"] = 234.75906461127,
        ["y"] = -391.03347101889,
        ["g"] = 33,
        ["sublevel"] = 1,
        ["scale"] = 2.4,
      };
    };
  };
  [33] = {
    ["name"] = "Teera",
    ["id"] = 186339,
    ["count"] = 0,
    ["health"] = 7154196,
    ["scale"] = 1,
    ["displayId"] = 105721,
    ["creatureType"] = "Undead",
    ["level"] = 72,
    ["isBoss"] = true,
    ["encounterID"] = 2478,
    ["instanceID"] = 537,
    ["characteristics"] = {
      ["Taunt"] = true,
    };
    ["spells"] = {
      [345561] = {
      };
      [382670] = {
      };
      [384808] = {
      };
      [385434] = {
      };
      [386016] = {
      };
      [386411] = {
      };
      [386547] = {
      };
      [392151] = {
      };
      [392198] = {
      };
    };
    ["clones"] = {
      [1] = {
        ["x"] = 119.56229309837,
        ["y"] = -522.44162985071,
        ["g"] = 36,
        ["sublevel"] = 1,
        ["scale"] = 2.2,
      };
    };
  };
  [34] = {
    ["name"] = "Maruuk",
    ["id"] = 186338,
    ["count"] = 0,
    ["health"] = 7154196,
    ["scale"] = 1,
    ["displayId"] = 105722,
    ["creatureType"] = "Undead",
    ["level"] = 72,
    ["isBoss"] = true,
    ["encounterID"] = 2478,
    ["instanceID"] = 537,
    ["characteristics"] = {
      ["Taunt"] = true,
    };
    ["spells"] = {
      [345561] = {
      };
      [382836] = {
      };
      [385339] = {
      };
      [386063] = {
      };
      [392198] = {
      };
      [395669] = {
      };
    };
    ["clones"] = {
      [1] = {
        ["x"] = 94.808142284973,
        ["y"] = -488.4832582642,
        ["g"] = 36,
        ["sublevel"] = 1,
        ["scale"] = 2.2,
      };
    };
  };
  [35] = {
    ["name"] = "Batak",
    ["id"] = 193462,
    ["count"] = 16,
    ["health"] = 1720817,
    ["scale"] = 1,
    ["displayId"] = 108221,
    ["creatureType"] = "Humanoid",
    ["level"] = 71,
    ["characteristics"] = {
      ["Taunt"] = true,
    };
    ["spells"] = {
      [373395] = {
      };
      [382233] = {
      };
      [383067] = {
      };
    };
    ["clones"] = {
      [1] = {
        ["x"] = 197.16536123039,
        ["y"] = -112.6827510673,
        ["g"] = 42,
        ["sublevel"] = 1,
        ["scale"] = 2.2,
      };
    };
  };
  [36] = {
    ["name"] = "Balara",
    ["id"] = 193457,
    ["count"] = 16,
    ["health"] = 1720817,
    ["scale"] = 1,
    ["displayId"] = 108222,
    ["creatureType"] = "Humanoid",
    ["level"] = 71,
    ["characteristics"] = {
      ["Taunt"] = true,
    };
    ["spells"] = {
      [372147] = {
      };
      [374711] = {
      };
      [382267] = {
      };
      [382274] = {
      };
      [382277] = {
      };
      [383067] = {
      };
    };
    ["clones"] = {
      [1] = {
        ["x"] = 196.45434449669,
        ["y"] = -131.95591459466,
        ["g"] = 42,
        ["sublevel"] = 1,
        ["scale"] = 2.2,
      };
    };
  };
  [37] = {
    ["name"] = "Balakar Khan",
    ["id"] = 186151,
    ["count"] = 0,
    ["health"] = 5723357,
    ["scale"] = 1,
    ["displayId"] = 107680,
    ["creatureType"] = "Humanoid",
    ["level"] = 72,
    ["isBoss"] = true,
    ["encounterID"] = 2477,
    ["instanceID"] = 1198,
    ["characteristics"] = {
      ["Taunt"] = true,
    };
    ["spells"] = {
      [375929] = {
      };
      [375937] = {
      };
      [375943] = {
      };
      [376634] = {
      };
      [376644] = {
      };
      [376660] = {
      };
      [376683] = {
      };
      [376685] = {
      };
      [376724] = {
      };
      [376727] = {
      };
      [376827] = {
      };
      [376829] = {
      };
      [376864] = {
      };
      [376865] = {
      };
      [376866] = {
      };
      [376892] = {
      };
      [376894] = {
      };
      [376896] = {
      };
      [393421] = {
      };
      [393425] = {
      };
    };
    ["clones"] = {
      [1] = {
        ["x"] = 139.81259789612,
        ["y"] = -113.56998118293,
        ["sublevel"] = 1,
        ["scale"] = 2.4,
      };
    };
  };
  [38] = {
    ["name"] = "Nokhud Defender",
    ["id"] = 199717,
    ["count"] = 10,
    ["health"] = 1326463,
    ["scale"] = 1,
    ["stealthDetect"] = true,
    ["displayId"] = 108529,
    ["creatureType"] = "Humanoid",
    ["level"] = 71,
    ["characteristics"] = {
      ["Taunt"] = true,
    };
    ["spells"] = {
      [373395] = {
      };
      [384336] = {
      };
      [384510] = {
      };
      [384512] = {
      };
    };
    ["clones"] = {
      [1] = {
        ["x"] = 349.13090828289,
        ["y"] = -145.99198890581,
        ["g"] = 37,
        ["sublevel"] = 1,
        ["scale"] = 2,
      };
      [2] = {
        ["x"] = 349.68471805392,
        ["y"] = -130.83256277332,
        ["g"] = 37,
        ["sublevel"] = 1,
        ["scale"] = 2,
      };
      [3] = {
        ["x"] = 277.34841066099,
        ["y"] = -132.82352185936,
        ["g"] = 40,
        ["sublevel"] = 1,
        ["scale"] = 2,
      };
      [4] = {
        ["x"] = 278.05742209925,
        ["y"] = -114.5658658061,
        ["g"] = 40,
        ["sublevel"] = 1,
        ["scale"] = 2,
      };
      [5] = {
        ["x"] = 252.17860318294,
        ["y"] = -130.15238436222,
        ["g"] = 41,
        ["sublevel"] = 1,
        ["scale"] = 2,
        ["patrol"] = {
        };
      };
      [6] = {
        ["x"] = 202.53091064411,
        ["y"] = -50.51336527531,
        ["g"] = 43,
        ["sublevel"] = 1,
        ["scale"] = 2,
        ["patrol"] = {
        };
      };
      [7] = {
        ["x"] = 200.20453113616,
        ["y"] = -27.654662615772,
        ["g"] = 44,
        ["sublevel"] = 1,
        ["scale"] = 2,
      };
      [8] = {
        ["x"] = 216.7556235335,
        ["y"] = -30.066402017731,
        ["g"] = 44,
        ["sublevel"] = 1,
        ["scale"] = 2,
      };
      [9] = {
        ["x"] = 187.11390410183,
        ["y"] = -214.72233879413,
        ["g"] = 45,
        ["sublevel"] = 1,
        ["scale"] = 2,
      };
      [10] = {
        ["x"] = 203.46091793465,
        ["y"] = -210.3933922836,
        ["g"] = 45,
        ["sublevel"] = 1,
        ["scale"] = 2,
      };
      [11] = {
        ["x"] = 185.1194794166,
        ["y"] = -180.71334987763,
        ["g"] = 46,
        ["sublevel"] = 1,
        ["scale"] = 2,
      };
      [12] = {
        ["x"] = 188.44963584084,
        ["y"] = -253.70259682937,
        ["g"] = 48,
        ["sublevel"] = 1,
        ["scale"] = 2,
      };
      [13] = {
        ["x"] = 204.9320149351,
        ["y"] = -250.39717324279,
        ["g"] = 48,
        ["sublevel"] = 1,
        ["scale"] = 2,
      };
    };
  };
  [39] = {
    ["name"] = "Nokhud Thunderfist",
    ["id"] = 193373,
    ["count"] = 5,
    ["health"] = 717007,
    ["scale"] = 1,
    ["displayId"] = 110840,
    ["creatureType"] = "Humanoid",
    ["level"] = 70,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Incapacitate"] = true,
      ["Silence"] = true,
      ["Root"] = true,
      ["Fear"] = true,
      ["Imprison"] = true,
      ["Stun"] = true,
    };
    ["spells"] = {
      [381530] = {
      };
      [397394] = {
      };
    };
    ["clones"] = {
      [1] = {
        ["x"] = 326.8844282343,
        ["y"] = -158.26130910202,
        ["g"] = 38,
        ["sublevel"] = 1,
        ["scale"] = 1.6,
      };
      [2] = {
        ["x"] = 234.68420946739,
        ["y"] = -147.00588781222,
        ["g"] = 41,
        ["sublevel"] = 1,
        ["scale"] = 1.6,
      };
      [3] = {
        ["x"] = 232.96708243271,
        ["y"] = -112.79089317262,
        ["g"] = 41,
        ["sublevel"] = 1,
        ["scale"] = 1.6,
      };
      [4] = {
        ["x"] = 212.57952407329,
        ["y"] = -57.397016837998,
        ["g"] = 43,
        ["sublevel"] = 1,
        ["scale"] = 1.6,
      };
      [5] = {
        ["x"] = 180.88219887877,
        ["y"] = -61.064793114656,
        ["g"] = 43,
        ["sublevel"] = 1,
        ["scale"] = 1.6,
      };
      [6] = {
        ["x"] = 204.00894112159,
        ["y"] = -164.19564220962,
        ["g"] = 46,
        ["sublevel"] = 1,
        ["scale"] = 1.6,
      };
      [7] = {
        ["x"] = 168.61859218252,
        ["y"] = -163.40795667807,
        ["g"] = 46,
        ["sublevel"] = 1,
        ["scale"] = 1.6,
      };
      [8] = {
        ["x"] = 214.9696946596,
        ["y"] = -92.551882878106,
        ["g"] = 47,
        ["sublevel"] = 1,
        ["scale"] = 1.6,
      };
      [9] = {
        ["x"] = 226.63244511729,
        ["y"] = -88.344788114942,
        ["g"] = 47,
        ["sublevel"] = 1,
        ["scale"] = 1.6,
      };
      [10] = {
        ["x"] = 310.5967180307,
        ["y"] = -118.98421896292,
        ["g"] = 39,
        ["sublevel"] = 1,
        ["scale"] = 1.6,
      };
    };
  };
};
