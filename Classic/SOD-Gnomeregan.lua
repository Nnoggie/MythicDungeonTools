local MDT = MDT
local L = MDT.L
L["The Hall of Gears"] = "The Hall of Gears"
L["The Dormitory"] = "The Dormitory"
L["Launch Bay"] = "Launch Bay"
L["Tinkers\' Court"] = "Tinkers\' Court"
L["Caverndeep Ambusher"] = "Caverndeep Ambusher"
L["Irradiated Pillager"] = "Irradiated Pillager"
L["Caverndeep Burrower"] = "Caverndeep Burrower"
L["Blastmaster Emi Shortfuse"] = "Blastmaster Emi Shortfuse"
L["Grubbis"] = "Grubbis"
L["Chomper"] = "Chomper"
L["Caverndeep Reaver"] = "Caverndeep Reaver"
L["Irradiated Horror"] = "Irradiated Horror"
L["Irradiated Slime"] = "Irradiated Slime"
L["Corrosive Lurker"] = "Corrosive Lurker"
L["Viscous Fallout"] = "Viscous Fallout"
L["Mechanized Sentry"] = "Mechanized Sentry"
L["Leprous Defender"] = "Leprous Defender"
L["Mobile Alert System"] = "Mobile Alert System"
L["Leprous Assistant"] = "Leprous Assistant"
L["Leprous Technician"] = "Leprous Technician"
L["Electrocutioner 6000"] = "Electrocutioner 6000"
L["Peacekeeper Security Suit"] = "Peacekeeper Security Suit"
L["Mechano-Tank"] = "Mechano-Tank"
L["Dark Iron Agent"] = "Dark Iron Agent"
L["Mechanized Guardian"] = "Mechanized Guardian"
L["Arcane Nullifier X-21"] = "Arcane Nullifier X-21"
L["Mechano-Frostwalker"] = "Mechano-Frostwalker"
L["Mechano-Flamewalker"] = "Mechano-Flamewalker"
L["Leprous Machinesmith"] = "Leprous Machinesmith"
L["Crowd Pummeler 9-60"] = "Crowd Pummeler 9-60"
L["Mechanical Menagrie: STX-37/CN"] = "Mechanical Menagrie: STX-37/CN"
L["Mechanical Menagrie: STX-25/NB"] = "Mechanical Menagrie: STX-25/NB"
L["Mechanical Menagrie: STX-13/LL"] = "Mechanical Menagrie: STX-13/LL"
L["Mechanical Menagrie: STX-04/BD"] = "Mechanical Menagrie: STX-04/BD"
L["Mekgineer Thermaplugg"] = "Mekgineer Thermaplugg"
L["Dark Iron Ambassador"] = "Dark Iron Ambassador"
L["Alarm-a-bomb 2600"] = "Alarm-a-bomb 2600"
L["Kernobee"] = "Kernobee"
L["Season of Discovery: Gnomeregan"] = "Season of Discovery: Gnomeregan"

local dungeonIndex = 123
MDT.dungeonList[dungeonIndex] = L["Season of Discovery: Gnomeregan"]
MDT.mapInfo[dungeonIndex] = {
    --  viewportPositionOverrides =
    --  {
    --    [1] = {
    --      zoomScale = 1.2999999523163;
    --      horizontalPan = 102.41712541524;
    --      verticalPan = 87.49594729527;
    --    };
    --  }
};

MDT.dungeonMaps[dungeonIndex] = {
    [0] = "gnomeregan",
    [1] = "gnomeregan1_",
    [2] = "gnomeregan2_",
    [3] = "gnomeregan3_",
    [4] = "gnomeregan4_",
}

MDT.dungeonSubLevels[dungeonIndex] = {
    [1] = L["The Hall of Gears"],
    [2] = L["The Dormitory"],
    [3] = L["Launch Bay"],
    [4] = L["Tinkers\' Court"],
}

MDT.dungeonTotalCount[dungeonIndex] = { normal = 300, teeming = 1000, teemingEnabled = true }

MDT.mapPOIs[dungeonIndex] = {
};


MDT.dungeonEnemies[dungeonIndex] = {
    [1] = {
        ["name"] = "Caverndeep Ambusher",
        ["id"] = 6207,
        ["count"] = 0,
        ["health"] = 15240,
        ["scale"] = 0.8,
        ["stealthDetect"] = 0,
        ["displayId"] = 764,
        ["creatureType"] = "Humanoid",
        ["level"] = 70,
        ["clones"] = {
            [1] = {
                ["sublevel"] = 1,
                ["y"] = -360.3,
                ["x"] = 494.5,
                ["patrol"] = {
                    [1] = {
                        ["y"] = -390.5,
                        ["x"] = 582.4,
                    },
                    [2] = {
                        ["y"] = -390.4,
                        ["x"] = 539.5,
                    },
                    [3] = {
                        ["y"] = -335.4,
                        ["x"] = 467.8,
                    },
                    [4] = {
                        ["y"] = -353.6,
                        ["x"] = 450.1,
                    },
                    [5] = {
                        ["y"] = -353.7,
                        ["x"] = 387,
                    },
                    [6] = {
                        ["y"] = -334,
                        ["x"] = 365.8,
                    },
                    [7] = {
                        ["y"] = -359.3,
                        ["x"] = 339.2,
                    },
                    [8] = {
                        ["y"] = -382.1,
                        ["x"] = 362.8,
                    },
                    [9] = {
                        ["y"] = -411.8,
                        ["x"] = 351.2,
                    },
                    [10] = {
                        ["y"] = -378.1,
                        ["x"] = 317.5,
                    },
                    [11] = {
                        ["y"] = -382.4,
                        ["x"] = 313.3,
                    },
                    [12] = {
                        ["y"] = -417.1,
                        ["x"] = 351.4,
                    },
                    [13] = {
                        ["y"] = -380.1,
                        ["x"] = 366.3,
                    },
                    [14] = {
                        ["y"] = -358.9,
                        ["x"] = 345.4,
                    },
                    [15] = {
                        ["y"] = -339.3,
                        ["x"] = 365.8,
                    },
                    [16] = {
                        ["y"] = -357.7,
                        ["x"] = 386.8,
                    },
                    [17] = {
                        ["y"] = -359.1,
                        ["x"] = 451.6,
                    },
                    [18] = {
                        ["y"] = -342.7,
                        ["x"] = 468.6,
                    },
                    [19] = {
                        ["y"] = -395.3,
                        ["x"] = 539.4,
                    },
                    [20] = {
                        ["y"] = -395.3,
                        ["x"] = 582.4,
                    },
                    [21] = {
                        ["y"] = -390.5,
                        ["x"] = 582.4,
                    },
                },
            },
            [2] = {
                ["sublevel"] = 1,
                ["y"] = -483.8,
                ["x"] = 348.7,
            },
            [3] = {
                ["sublevel"] = 1,
                ["y"] = -218.2,
                ["x"] = 469.8,
                ["patrol"] = {
                    [1] = {
                        ["y"] = -206.4,
                        ["x"] = 397.1,
                    },
                    [2] = {
                        ["y"] = -206.4,
                        ["x"] = 449,
                    },
                    [3] = {
                        ["y"] = -248,
                        ["x"] = 491.2,
                    },
                    [4] = {
                        ["y"] = -306.4,
                        ["x"] = 491.3,
                    },
                    [5] = {
                        ["y"] = -350.8,
                        ["x"] = 450.1,
                    },
                    [6] = {
                        ["y"] = -351.1,
                        ["x"] = 388.6,
                    },
                    [7] = {
                        ["y"] = -307.8,
                        ["x"] = 344,
                    },
                    [8] = {
                        ["y"] = -252.2,
                        ["x"] = 344.3,
                    },
                    [9] = {
                        ["y"] = -253,
                        ["x"] = 336.5,
                    },
                    [10] = {
                        ["y"] = -310.1,
                        ["x"] = 337.7,
                    },
                    [11] = {
                        ["y"] = -357.3,
                        ["x"] = 386.2,
                    },
                    [12] = {
                        ["y"] = -356.6,
                        ["x"] = 451.8,
                    },
                    [13] = {
                        ["y"] = -307.1,
                        ["x"] = 497.6,
                    },
                    [14] = {
                        ["y"] = -243.9,
                        ["x"] = 497.1,
                    },
                    [15] = {
                        ["y"] = -200.3,
                        ["x"] = 450.4,
                    },
                    [16] = {
                        ["y"] = -200,
                        ["x"] = 397,
                    },
                    [17] = {
                        ["y"] = -206.4,
                        ["x"] = 397.1,
                    },
                },
            },
        },
        ["healthPercentage"] = 100,
    },
    [2] = {
        ["name"] = "Irradiated Pillager",
        ["id"] = 6329,
        ["count"] = 0,
        ["health"] = 12260,
        ["scale"] = 1,
        ["stealthDetect"] = 0,
        ["displayId"] = 976,
        ["creatureType"] = "Humanoid",
        ["level"] = 70,
        ["clones"] = {
            [1] = {
                ["sublevel"] = 1,
                ["y"] = -351.5,
                ["x"] = 431.3,
            },
            [2] = {
                ["sublevel"] = 1,
                ["y"] = -410,
                ["x"] = 354.7,
                ["g"] = 1,
            },
            [3] = {
                ["sublevel"] = 1,
                ["y"] = -254.9,
                ["x"] = 419.9,
            },
            [4] = {
                ["sublevel"] = 1,
                ["y"] = -360.7,
                ["x"] = 477.6,
            },
            [5] = {
                ["sublevel"] = 1,
                ["y"] = -303.4,
                ["x"] = 415.9,
            },
            [6] = {
                ["sublevel"] = 2,
                ["y"] = -371.3,
                ["x"] = 707.9,
                ["g"] = 2,
            },
            [7] = {
                ["sublevel"] = 1,
                ["y"] = -277,
                ["x"] = 437,
            },
            [8] = {
                ["sublevel"] = 1,
                ["y"] = -383.1,
                ["x"] = 519.9,
            },
            [9] = {
                ["sublevel"] = 1,
                ["y"] = -301,
                ["x"] = 490,
                ["g"] = 3,
            },
            [10] = {
                ["sublevel"] = 2,
                ["y"] = -454.3,
                ["x"] = 639.1,
                ["g"] = 4,
            },
            [11] = {
                ["sublevel"] = 1,
                ["y"] = -353.5,
                ["x"] = 340.7,
                ["g"] = 5,
            },
            [12] = {
                ["sublevel"] = 1,
                ["y"] = -348.2,
                ["x"] = 397.7,
            },
            [13] = {
                ["sublevel"] = 1,
                ["y"] = -330.6,
                ["x"] = 361.3,
            },
            [14] = {
                ["sublevel"] = 1,
                ["y"] = -406.9,
                ["x"] = 349.5,
                ["g"] = 1,
            },
            [15] = {
                ["sublevel"] = 1,
                ["y"] = -204.9,
                ["x"] = 401.9,
            },
            [16] = {
                ["sublevel"] = 1,
                ["y"] = -380.1,
                ["x"] = 316.5,
                ["g"] = 6,
            },
            [17] = {
                ["sublevel"] = 1,
                ["y"] = -383.1,
                ["x"] = 320.3,
                ["g"] = 6,
            },
            [18] = {
                ["sublevel"] = 2,
                ["y"] = -404.7,
                ["x"] = 711.6,
            },
            [19] = {
                ["sublevel"] = 1,
                ["y"] = -203.1,
                ["x"] = 446.1,
            },
            [20] = {
                ["sublevel"] = 2,
                ["y"] = -405.1,
                ["x"] = 705.9,
            },
            [21] = {
                ["sublevel"] = 2,
                ["y"] = -461.6,
                ["x"] = 618.4,
            },
            [22] = {
                ["sublevel"] = 2,
                ["y"] = -390.9,
                ["x"] = 721.3,
                ["g"] = 7,
            },
            [23] = {
                ["sublevel"] = 2,
                ["y"] = -387.2,
                ["x"] = 717.6,
                ["g"] = 7,
            },
            [24] = {
                ["sublevel"] = 1,
                ["y"] = -279.7,
                ["x"] = 338.9,
                ["patrol"] = {
                    [1] = {
                        ["y"] = -253.5,
                        ["x"] = 338.6,
                    },
                    [2] = {
                        ["y"] = -311,
                        ["x"] = 339.5,
                    },
                    [3] = {
                        ["y"] = -357.8,
                        ["x"] = 386.4,
                    },
                    [4] = {
                        ["y"] = -353.1,
                        ["x"] = 389,
                    },
                    [5] = {
                        ["y"] = -308.1,
                        ["x"] = 344.5,
                    },
                    [6] = {
                        ["y"] = -253.5,
                        ["x"] = 343.1,
                    },
                    [7] = {
                        ["y"] = -253.5,
                        ["x"] = 338.7,
                    },
                },
            },
            [25] = {
                ["sublevel"] = 1,
                ["y"] = -412.4,
                ["x"] = 350.1,
                ["g"] = 1,
            },
            [26] = {
                ["sublevel"] = 1,
                ["y"] = -419.4,
                ["x"] = 279.2,
                ["g"] = 8,
            },
            [27] = {
                ["sublevel"] = 2,
                ["y"] = -368.4,
                ["x"] = 670.2,
            },
            [28] = {
                ["sublevel"] = 2,
                ["y"] = -372.4,
                ["x"] = 602.1,
            },
            [29] = {
                ["sublevel"] = 2,
                ["y"] = -447,
                ["x"] = 601.1,
            },
            [30] = {
                ["sublevel"] = 2,
                ["y"] = -420.7,
                ["x"] = 728.3,
            },
            [31] = {
                ["sublevel"] = 2,
                ["y"] = -416.3,
                ["x"] = 677.9,
            },
            [32] = {
                ["sublevel"] = 2,
                ["y"] = -407.1,
                ["x"] = 677.1,
            },
            [33] = {
                ["sublevel"] = 1,
                ["y"] = -357.2,
                ["x"] = 345.3,
                ["g"] = 5,
            },
            [34] = {
                ["sublevel"] = 2,
                ["y"] = -428.9,
                ["x"] = 612.7,
            },
            [35] = {
                ["sublevel"] = 2,
                ["y"] = -422.6,
                ["x"] = 628.3,
            },
            [36] = {
                ["sublevel"] = 2,
                ["y"] = -401.9,
                ["x"] = 627.2,
            },
            [37] = {
                ["sublevel"] = 2,
                ["y"] = -397.7,
                ["x"] = 619.3,
            },
            [38] = {
                ["sublevel"] = 1,
                ["y"] = -249,
                ["x"] = 494.1,
                ["g"] = 9,
            },
            [39] = {
                ["sublevel"] = 1,
                ["y"] = -485.8,
                ["x"] = 400,
                ["g"] = 10,
            },
        },
        ["healthPercentage"] = 100,
    },
    [3] = {
        ["name"] = "Caverndeep Burrower",
        ["id"] = 6206,
        ["count"] = 0,
        ["health"] = 13716,
        ["scale"] = 1,
        ["stealthDetect"] = 0,
        ["displayId"] = 830,
        ["creatureType"] = "Humanoid",
        ["level"] = 70,
        ["clones"] = {
            [1] = {
                ["sublevel"] = 1,
                ["y"] = -470.3,
                ["x"] = 325.8,
                ["g"] = 11,
            },
            [2] = {
                ["sublevel"] = 2,
                ["y"] = -444.6,
                ["x"] = 638.9,
                ["g"] = 4,
            },
            [3] = {
                ["sublevel"] = 1,
                ["y"] = -305.1,
                ["x"] = 342.8,
            },
            [4] = {
                ["sublevel"] = 1,
                ["y"] = -315.8,
                ["x"] = 342,
            },
            [5] = {
                ["sublevel"] = 1,
                ["y"] = -359.9,
                ["x"] = 338.9,
                ["g"] = 5,
            },
            [6] = {
                ["sublevel"] = 1,
                ["y"] = -419.1,
                ["x"] = 284.1,
                ["g"] = 8,
            },
            [7] = {
                ["sublevel"] = 1,
                ["y"] = -340.1,
                ["x"] = 369.1,
            },
            [8] = {
                ["sublevel"] = 2,
                ["y"] = -409.4,
                ["x"] = 654.4,
            },
            [9] = {
                ["sublevel"] = 2,
                ["y"] = -418.1,
                ["x"] = 658.9,
            },
            [10] = {
                ["sublevel"] = 2,
                ["y"] = -444.8,
                ["x"] = 632.7,
                ["g"] = 4,
            },
            [11] = {
                ["sublevel"] = 2,
                ["y"] = -454.4,
                ["x"] = 632.8,
                ["g"] = 4,
            },
            [12] = {
                ["sublevel"] = 1,
                ["y"] = -257.6,
                ["x"] = 347,
            },
            [13] = {
                ["sublevel"] = 1,
                ["y"] = -355.2,
                ["x"] = 407.9,
            },
            [14] = {
                ["sublevel"] = 1,
                ["y"] = -356.6,
                ["x"] = 443.6,
            },
            [15] = {
                ["sublevel"] = 1,
                ["y"] = -351.7,
                ["x"] = 470,
            },
            [16] = {
                ["sublevel"] = 1,
                ["y"] = -340.3,
                ["x"] = 478.9,
            },
            [17] = {
                ["sublevel"] = 1,
                ["y"] = -300.8,
                ["x"] = 497.4,
                ["g"] = 3,
            },
            [18] = {
                ["sublevel"] = 1,
                ["y"] = -464.9,
                ["x"] = 331.5,
                ["g"] = 11,
            },
            [19] = {
                ["sublevel"] = 1,
                ["y"] = -257.8,
                ["x"] = 494,
                ["g"] = 9,
            },
            [20] = {
                ["sublevel"] = 1,
                ["y"] = -290.7,
                ["x"] = 347.8,
            },
        },
        ["healthPercentage"] = 100,
    },
    [4] = {
        ["name"] = "Blastmaster Emi Shortfuse",
        ["id"] = 7998,
        ["count"] = 0,
        ["health"] = 840,
        ["scale"] = 1,
        ["stealthDetect"] = 0,
        ["displayId"] = 7138,
        ["creatureType"] = "Humanoid",
        ["level"] = 70,
        ["clones"] = {
            [1] = {
                ["sublevel"] = 1,
                ["y"] = -361.3,
                ["x"] = 687.6,
            },
        },
        ["healthPercentage"] = 100,
    },
    [5] = {
        ["name"] = "Grubbis",
        ["id"] = 217280,
        ["count"] = 0,
        ["health"] = 141083,
        ["scale"] = 1.6,
        ["stealthDetect"] = 0,
        ["displayId"] = 6533,
        ["creatureType"] = "Humanoid",
        ["level"] = 70,
        ["clones"] = {
            [1] = {
                ["sublevel"] = 1,
                ["y"] = -357,
                ["x"] = 636.9,
                ["g"] = 12,
            },
        },
        ["healthPercentage"] = 100,
        ["isBoss"] = true,
    },
    [6] = {
        ["name"] = "Chomper",
        ["id"] = 217956,
        ["count"] = 0,
        ["health"] = 40168,
        ["scale"] = 1,
        ["stealthDetect"] = 0,
        ["displayId"] = 46058,
        ["creatureType"] = "Beast",
        ["level"] = 70,
        ["clones"] = {
            [1] = {
                ["sublevel"] = 1,
                ["y"] = -355,
                ["x"] = 644.6,
                ["g"] = 12,
            },
        },
        ["healthPercentage"] = 100,
    },
    [7] = {
        ["name"] = "Caverndeep Reaver",
        ["id"] = 6211,
        ["count"] = 0,
        ["health"] = 15240,
        ["scale"] = 1,
        ["stealthDetect"] = 0,
        ["displayId"] = 10285,
        ["creatureType"] = "Humanoid",
        ["level"] = 70,
        ["clones"] = {
            [1] = {
                ["sublevel"] = 2,
                ["y"] = -426.4,
                ["x"] = 605.2,
            },
            [2] = {
                ["sublevel"] = 2,
                ["y"] = -384.3,
                ["x"] = 645.4,
            },
            [3] = {
                ["sublevel"] = 2,
                ["y"] = -393.1,
                ["x"] = 642.1,
            },
            [4] = {
                ["sublevel"] = 2,
                ["y"] = -370.8,
                ["x"] = 701.2,
                ["g"] = 2,
            },
            [5] = {
                ["sublevel"] = 2,
                ["y"] = -422.9,
                ["x"] = 638.8,
                ["patrol"] = {
                    [1] = {
                        ["y"] = -453,
                        ["x"] = 666.5,
                    },
                    [2] = {
                        ["y"] = -414.6,
                        ["x"] = 666.3,
                    },
                    [3] = {
                        ["y"] = -414.5,
                        ["x"] = 637.7,
                    },
                    [4] = {
                        ["y"] = -455.4,
                        ["x"] = 638.5,
                    },
                    [5] = {
                        ["y"] = -455.2,
                        ["x"] = 631.5,
                    },
                    [6] = {
                        ["y"] = -415.3,
                        ["x"] = 630.9,
                    },
                    [7] = {
                        ["y"] = -415.4,
                        ["x"] = 605.2,
                    },
                    [8] = {
                        ["y"] = -454.8,
                        ["x"] = 604.8,
                    },
                    [9] = {
                        ["y"] = -454.8,
                        ["x"] = 599,
                    },
                    [10] = {
                        ["y"] = -410.1,
                        ["x"] = 598.7,
                    },
                    [11] = {
                        ["y"] = -409.8,
                        ["x"] = 673.5,
                    },
                    [12] = {
                        ["y"] = -452.8,
                        ["x"] = 673.6,
                    },
                    [13] = {
                        ["y"] = -452.9,
                        ["x"] = 666.6,
                    },
                },
            },
            [6] = {
                ["sublevel"] = 2,
                ["y"] = -382,
                ["x"] = 605.2,
            },
            [7] = {
                ["sublevel"] = 2,
                ["y"] = -378.4,
                ["x"] = 669.6,
            },
            [8] = {
                ["sublevel"] = 2,
                ["y"] = -383.1,
                ["x"] = 720.5,
                ["g"] = 7,
            },
            [9] = {
                ["sublevel"] = 2,
                ["y"] = -457.8,
                ["x"] = 677.4,
            },
            [10] = {
                ["sublevel"] = 2,
                ["y"] = -457.2,
                ["x"] = 670.3,
            },
            [11] = {
                ["sublevel"] = 1,
                ["y"] = -494.6,
                ["x"] = 398.7,
                ["g"] = 10,
            },
            [12] = {
                ["sublevel"] = 1,
                ["y"] = -488.3,
                ["x"] = 390.4,
                ["g"] = 10,
            },
            [13] = {
                ["sublevel"] = 1,
                ["y"] = -464.5,
                ["x"] = 325.4,
                ["g"] = 11,
            },
        },
        ["healthPercentage"] = 100,
    },
    [8] = {
        ["name"] = "Alarm-a-bomb 2600",
        ["id"] = 7897,
        ["count"] = 0,
        ["health"] = 5334,
        ["scale"] = 0.8,
        ["stealthDetect"] = 0,
        ["displayId"] = 6888,
        ["creatureType"] = "Mechanical",
        ["level"] = 70,
        ["clones"] = {
            [1] = {
                ["sublevel"] = 2,
                ["y"] = -415.5,
                ["x"] = 617.7,
                ["patrol"] = {
                    [1] = {
                        ["y"] = -416.2,
                        ["x"] = 607.6,
                    },
                    [2] = {
                        ["y"] = -411.3,
                        ["x"] = 607.5,
                    },
                    [3] = {
                        ["y"] = -410.9,
                        ["x"] = 700.6,
                    },
                    [4] = {
                        ["y"] = -374.2,
                        ["x"] = 699.6,
                    },
                    [5] = {
                        ["y"] = -374.5,
                        ["x"] = 707.9,
                    },
                    [6] = {
                        ["y"] = -416.3,
                        ["x"] = 708.1,
                    },
                    [7] = {
                        ["y"] = -416.2,
                        ["x"] = 607.6,
                    },
                },
            },
        },
        ["healthPercentage"] = 100,
    },
    [9] = {
        ["name"] = "Kernobee",
        ["id"] = 7850,
        ["count"] = 0,
        ["health"] = 1600,
        ["scale"] = 0.8,
        ["stealthDetect"] = 0,
        ["displayId"] = 7132,
        ["creatureType"] = "Humanoid",
        ["level"] = 70,
        ["clones"] = {
            [1] = {
                ["sublevel"] = 2,
                ["y"] = -449.2,
                ["x"] = 593.4,
            },
        },
        ["healthPercentage"] = 100,
    },
    [10] = {
        ["name"] = "Irradiated Horror",
        ["id"] = 6220,
        ["count"] = 0,
        ["health"] = 11034,
        ["scale"] = 1,
        ["stealthDetect"] = 0,
        ["displayId"] = 4907,
        ["creatureType"] = "Elemental",
        ["level"] = 70,
        ["clones"] = {
            [1] = {
                ["sublevel"] = 2,
                ["y"] = -255.6,
                ["x"] = 692.9,
            },
            [2] = {
                ["sublevel"] = 2,
                ["y"] = -262.1,
                ["x"] = 645,
            },
            [3] = {
                ["sublevel"] = 2,
                ["y"] = -318.8,
                ["x"] = 605.4,
            },
            [4] = {
                ["sublevel"] = 2,
                ["y"] = -295.5,
                ["x"] = 583.2,
            },
            [5] = {
                ["sublevel"] = 2,
                ["y"] = -231.6,
                ["x"] = 690.7,
            },
            [6] = {
                ["sublevel"] = 2,
                ["y"] = -215.2,
                ["x"] = 677.9,
            },
        },
        ["healthPercentage"] = 100,
    },
    [11] = {
        ["name"] = "Irradiated Slime",
        ["id"] = 6218,
        ["count"] = 0,
        ["health"] = 15240,
        ["scale"] = 1,
        ["stealthDetect"] = 0,
        ["displayId"] = 358,
        ["creatureType"] = "Uncategorized",
        ["level"] = 70,
        ["clones"] = {
            [1] = {
                ["sublevel"] = 2,
                ["y"] = -290.5,
                ["x"] = 672.5,
            },
            [2] = {
                ["sublevel"] = 2,
                ["y"] = -287.1,
                ["x"] = 622.3,
            },
            [3] = {
                ["sublevel"] = 2,
                ["y"] = -204.7,
                ["x"] = 608.7,
            },
            [4] = {
                ["sublevel"] = 2,
                ["y"] = -202.8,
                ["x"] = 641.7,
            },
        },
        ["healthPercentage"] = 100,
    },
    [12] = {
        ["name"] = "Corrosive Lurker",
        ["id"] = 6219,
        ["count"] = 0,
        ["health"] = 18288,
        ["scale"] = 1,
        ["stealthDetect"] = 0,
        ["displayId"] = 33108,
        ["creatureType"] = "Uncategorized",
        ["level"] = 70,
        ["clones"] = {
            [1] = {
                ["sublevel"] = 2,
                ["y"] = -258.4,
                ["x"] = 606,
            },
            [2] = {
                ["sublevel"] = 2,
                ["y"] = -270.8,
                ["x"] = 568.8,
            },
            [3] = {
                ["sublevel"] = 2,
                ["y"] = -236.4,
                ["x"] = 579.2,
            },
        },
        ["healthPercentage"] = 100,
    },
    [13] = {
        ["name"] = "Viscous Fallout",
        ["id"] = 7079,
        ["count"] = 0,
        ["health"] = 156775,
        ["scale"] = 1.6,
        ["stealthDetect"] = 0,
        ["displayId"] = 36529,
        ["creatureType"] = "Elemental",
        ["level"] = 70,
        ["clones"] = {
            [1] = {
                ["sublevel"] = 2,
                ["y"] = -236.6,
                ["x"] = 648,
                ["patrol"] = {
                    [1] = {
                        ["y"] = -253.8,
                        ["x"] = 672.2,
                    },
                    [2] = {
                        ["y"] = -222.4,
                        ["x"] = 675.9,
                    },
                    [3] = {
                        ["y"] = -209,
                        ["x"] = 671.2,
                    },
                    [4] = {
                        ["y"] = -196.4,
                        ["x"] = 659.1,
                    },
                    [5] = {
                        ["y"] = -194.5,
                        ["x"] = 637.5,
                    },
                    [6] = {
                        ["y"] = -206.6,
                        ["x"] = 617.5,
                    },
                    [7] = {
                        ["y"] = -224.2,
                        ["x"] = 614.6,
                    },
                    [8] = {
                        ["y"] = -240.6,
                        ["x"] = 659.2,
                    },
                    [9] = {
                        ["y"] = -237.5,
                        ["x"] = 695.7,
                    },
                    [10] = {
                        ["y"] = -245.7,
                        ["x"] = 705.9,
                    },
                    [11] = {
                        ["y"] = -279.6,
                        ["x"] = 702.4,
                    },
                    [12] = {
                        ["y"] = -282.8,
                        ["x"] = 674.4,
                    },
                    [13] = {
                        ["y"] = -253.8,
                        ["x"] = 672.3,
                    },
                },
            },
        },
        ["healthPercentage"] = 100,
        ["isBoss"] = true,
    },
    [14] = {
        ["name"] = "Mechanized Sentry",
        ["id"] = 6233,
        ["count"] = 0,
        ["health"] = 15240,
        ["scale"] = 1,
        ["stealthDetect"] = 0,
        ["displayId"] = 6978,
        ["creatureType"] = "Mechanical",
        ["level"] = 70,
        ["clones"] = {
            [1] = {
                ["sublevel"] = 2,
                ["y"] = -300.5,
                ["x"] = 144.9,
                ["g"] = 13,
            },
            [2] = {
                ["sublevel"] = 2,
                ["y"] = -422.6,
                ["x"] = 112.5,
                ["g"] = 14,
            },
            [3] = {
                ["sublevel"] = 2,
                ["y"] = -479.7,
                ["x"] = 208.2,
                ["g"] = 15,
            },
            [4] = {
                ["sublevel"] = 2,
                ["y"] = -339.6,
                ["x"] = 477.2,
            },
            [5] = {
                ["sublevel"] = 2,
                ["y"] = -404.4,
                ["x"] = 417.1,
            },
            [6] = {
                ["sublevel"] = 3,
                ["y"] = -336.8,
                ["x"] = 495.2,
                ["g"] = 16,
            },
            [7] = {
                ["sublevel"] = 3,
                ["y"] = -149.2,
                ["x"] = 198.7,
                ["g"] = 17,
                ["patrol"] = {
                    [1] = {
                        ["y"] = -163.6,
                        ["x"] = 187.6,
                    },
                    [2] = {
                        ["y"] = -133.8,
                        ["x"] = 198.4,
                    },
                    [3] = {
                        ["y"] = -122.1,
                        ["x"] = 213.1,
                    },
                    [4] = {
                        ["y"] = -118.7,
                        ["x"] = 235.6,
                    },
                    [5] = {
                        ["y"] = -132.5,
                        ["x"] = 260.3,
                    },
                    [6] = {
                        ["y"] = -161.2,
                        ["x"] = 267.4,
                    },
                    [7] = {
                        ["y"] = -182.7,
                        ["x"] = 252.2,
                    },
                    [8] = {
                        ["y"] = -188.1,
                        ["x"] = 212.1,
                    },
                    [9] = {
                        ["y"] = -163.6,
                        ["x"] = 187.6,
                    },
                },
            },
            [8] = {
                ["sublevel"] = 3,
                ["y"] = -362.7,
                ["x"] = 663.3,
                ["g"] = 18,
            },
            [9] = {
                ["sublevel"] = 2,
                ["y"] = -322.8,
                ["x"] = 477.9,
                ["patrol"] = {
                    [1] = {
                        ["y"] = -273.1,
                        ["x"] = 518.6,
                    },
                    [2] = {
                        ["y"] = -277.6,
                        ["x"] = 518.7,
                    },
                    [3] = {
                        ["y"] = -278.3,
                        ["x"] = 491.2,
                    },
                    [4] = {
                        ["y"] = -285.5,
                        ["x"] = 480.6,
                    },
                    [5] = {
                        ["y"] = -293.8,
                        ["x"] = 477.8,
                    },
                    [6] = {
                        ["y"] = -338.8,
                        ["x"] = 477.7,
                    },
                    [7] = {
                        ["y"] = -361.7,
                        ["x"] = 470.8,
                    },
                    [8] = {
                        ["y"] = -385.1,
                        ["x"] = 459.6,
                    },
                    [9] = {
                        ["y"] = -401.7,
                        ["x"] = 419.6,
                    },
                    [10] = {
                        ["y"] = -402.8,
                        ["x"] = 404.9,
                    },
                    [11] = {
                        ["y"] = -398,
                        ["x"] = 405,
                    },
                    [12] = {
                        ["y"] = -397.7,
                        ["x"] = 420.1,
                    },
                    [13] = {
                        ["y"] = -380.9,
                        ["x"] = 457.9,
                    },
                    [14] = {
                        ["y"] = -359.1,
                        ["x"] = 467,
                    },
                    [15] = {
                        ["y"] = -338.2,
                        ["x"] = 473.1,
                    },
                    [16] = {
                        ["y"] = -292.2,
                        ["x"] = 472.6,
                    },
                    [17] = {
                        ["y"] = -281.9,
                        ["x"] = 477.8,
                    },
                    [18] = {
                        ["y"] = -273.9,
                        ["x"] = 489.6,
                    },
                    [19] = {
                        ["y"] = -273.1,
                        ["x"] = 518.6,
                    },
                },
            },
            [10] = {
                ["sublevel"] = 2,
                ["y"] = -302.4,
                ["x"] = 285,
                ["g"] = 19,
            },
            [11] = {
                ["sublevel"] = 2,
                ["y"] = -315,
                ["x"] = 462.9,
                ["patrol"] = {
                    [1] = {
                        ["y"] = -264,
                        ["x"] = 533.3,
                    },
                    [2] = {
                        ["y"] = -268.8,
                        ["x"] = 533.2,
                    },
                    [3] = {
                        ["y"] = -269.3,
                        ["x"] = 487.9,
                    },
                    [4] = {
                        ["y"] = -279,
                        ["x"] = 473.8,
                    },
                    [5] = {
                        ["y"] = -293.3,
                        ["x"] = 468.3,
                    },
                    [6] = {
                        ["y"] = -337.4,
                        ["x"] = 467.4,
                    },
                    [7] = {
                        ["y"] = -361.6,
                        ["x"] = 459.6,
                    },
                    [8] = {
                        ["y"] = -377.8,
                        ["x"] = 452,
                    },
                    [9] = {
                        ["y"] = -392.1,
                        ["x"] = 418.8,
                    },
                    [10] = {
                        ["y"] = -391.9,
                        ["x"] = 366.9,
                    },
                    [11] = {
                        ["y"] = -386.9,
                        ["x"] = 366.9,
                    },
                    [12] = {
                        ["y"] = -387.4,
                        ["x"] = 419.1,
                    },
                    [13] = {
                        ["y"] = -374.5,
                        ["x"] = 449.6,
                    },
                    [14] = {
                        ["y"] = -336.5,
                        ["x"] = 462.3,
                    },
                    [15] = {
                        ["y"] = -292.2,
                        ["x"] = 463.6,
                    },
                    [16] = {
                        ["y"] = -275.8,
                        ["x"] = 470.9,
                    },
                    [17] = {
                        ["y"] = -264.3,
                        ["x"] = 487.7,
                    },
                    [18] = {
                        ["y"] = -264,
                        ["x"] = 533.3,
                    },
                },
            },
            [12] = {
                ["sublevel"] = 3,
                ["y"] = -417.8,
                ["x"] = 312,
                ["g"] = 20,
            },
            [13] = {
                ["sublevel"] = 2,
                ["y"] = -470.6,
                ["x"] = 325.3,
                ["patrol"] = {
                    [1] = {
                        ["y"] = -471.9,
                        ["x"] = 275.1,
                    },
                    [2] = {
                        ["y"] = -499.9,
                        ["x"] = 296.5,
                    },
                    [3] = {
                        ["y"] = -460.6,
                        ["x"] = 350.4,
                    },
                    [4] = {
                        ["y"] = -476.8,
                        ["x"] = 364.5,
                    },
                    [5] = {
                        ["y"] = -495.9,
                        ["x"] = 342.8,
                    },
                    [6] = {
                        ["y"] = -500.1,
                        ["x"] = 345.9,
                    },
                    [7] = {
                        ["y"] = -476.6,
                        ["x"] = 372.9,
                    },
                    [8] = {
                        ["y"] = -452.4,
                        ["x"] = 351.4,
                    },
                    [9] = {
                        ["y"] = -489.4,
                        ["x"] = 298.7,
                    },
                    [10] = {
                        ["y"] = -467.9,
                        ["x"] = 281.3,
                    },
                    [11] = {
                        ["y"] = -471.9,
                        ["x"] = 275.1,
                    },
                },
            },
            [14] = {
                ["sublevel"] = 2,
                ["y"] = -276,
                ["x"] = 505,
            },
            [15] = {
                ["sublevel"] = 2,
                ["y"] = -344,
                ["x"] = 454,
            },
            [16] = {
                ["sublevel"] = 2,
                ["y"] = -263.2,
                ["x"] = 468.2,
            },
            [17] = {
                ["sublevel"] = 2,
                ["y"] = -293.6,
                ["x"] = 476.3,
            },
            [18] = {
                ["sublevel"] = 2,
                ["y"] = -429.6,
                ["x"] = 291.8,
                ["g"] = 21,
            },
            [19] = {
                ["sublevel"] = 2,
                ["y"] = -275.6,
                ["x"] = 496,
            },
            [20] = {
                ["sublevel"] = 2,
                ["y"] = -454.8,
                ["x"] = 351.1,
            },
            [21] = {
                ["sublevel"] = 2,
                ["y"] = -475.8,
                ["x"] = 367.7,
            },
        },
        ["healthPercentage"] = 100,
    },
    [15] = {
        ["name"] = "Leprous Defender",
        ["id"] = 6223,
        ["count"] = 0,
        ["health"] = 13716,
        ["scale"] = 1,
        ["stealthDetect"] = 0,
        ["displayId"] = 6982,
        ["creatureType"] = "Humanoid",
        ["level"] = 70,
        ["clones"] = {
            [1] = {
                ["sublevel"] = 2,
                ["y"] = -399.2,
                ["x"] = 417.3,
            },
            [2] = {
                ["sublevel"] = 2,
                ["y"] = -494.3,
                ["x"] = 297.9,
            },
            [3] = {
                ["sublevel"] = 2,
                ["y"] = -302.2,
                ["x"] = 477.9,
            },
            [4] = {
                ["sublevel"] = 2,
                ["y"] = -372.4,
                ["x"] = 357.3,
            },
            [5] = {
                ["sublevel"] = 2,
                ["y"] = -390.6,
                ["x"] = 356.1,
            },
            [6] = {
                ["sublevel"] = 2,
                ["y"] = -291,
                ["x"] = 454.1,
            },
            [7] = {
                ["sublevel"] = 2,
                ["y"] = -256.9,
                ["x"] = 500.9,
                ["g"] = 9,
            },
            [8] = {
                ["sublevel"] = 2,
                ["y"] = -382.4,
                ["x"] = 434.8,
            },
            [9] = {
                ["sublevel"] = 2,
                ["y"] = -346.5,
                ["x"] = 475.9,
            },
        },
        ["healthPercentage"] = 100,
    },
    [16] = {
        ["name"] = "Mobile Alert System",
        ["id"] = 7849,
        ["count"] = 0,
        ["health"] = 2286,
        ["scale"] = 0.8,
        ["stealthDetect"] = 1,
        ["displayId"] = 6888,
        ["creatureType"] = "Mechanical",
        ["level"] = 70,
        ["clones"] = {
            [1] = {
                ["sublevel"] = 3,
                ["y"] = -359.1,
                ["x"] = 340.9,
                ["g"] = 5,
                ["patrol"] = {
                    [1] = {
                        ["y"] = -490.4,
                        ["x"] = 339.6,
                    },
                    [2] = {
                        ["y"] = -484.1,
                        ["x"] = 306.4,
                    },
                    [3] = {
                        ["y"] = -471.4,
                        ["x"] = 300.1,
                    },
                    [4] = {
                        ["y"] = -367.5,
                        ["x"] = 313.4,
                    },
                    [5] = {
                        ["y"] = -357.5,
                        ["x"] = 330.8,
                    },
                    [6] = {
                        ["y"] = -372.3,
                        ["x"] = 432.8,
                    },
                    [7] = {
                        ["y"] = -383.2,
                        ["x"] = 442.7,
                    },
                    [8] = {
                        ["y"] = -490.4,
                        ["x"] = 429.8,
                    },
                    [9] = {
                        ["y"] = -500.7,
                        ["x"] = 416.9,
                    },
                    [10] = {
                        ["y"] = -490.1,
                        ["x"] = 338.2,
                    },
                },
            },
            [2] = {
                ["sublevel"] = 2,
                ["y"] = -379.3,
                ["x"] = 333.7,
                ["patrol"] = {
                    [1] = {
                        ["y"] = -364.5,
                        ["x"] = 465.9,
                    },
                    [2] = {
                        ["y"] = -384.2,
                        ["x"] = 456.3,
                    },
                    [3] = {
                        ["y"] = -399.5,
                        ["x"] = 417.3,
                    },
                    [4] = {
                        ["y"] = -400.9,
                        ["x"] = 365.9,
                    },
                    [5] = {
                        ["y"] = -372.1,
                        ["x"] = 320.5,
                    },
                    [6] = {
                        ["y"] = -352.1,
                        ["x"] = 306.5,
                    },
                    [7] = {
                        ["y"] = -307.7,
                        ["x"] = 280.3,
                    },
                    [8] = {
                        ["y"] = -282.9,
                        ["x"] = 234.7,
                    },
                    [9] = {
                        ["y"] = -277.5,
                        ["x"] = 194.3,
                    },
                    [10] = {
                        ["y"] = -288.2,
                        ["x"] = 156,
                    },
                    [11] = {
                        ["y"] = -315.3,
                        ["x"] = 122.7,
                    },
                    [12] = {
                        ["y"] = -348.8,
                        ["x"] = 105.1,
                    },
                    [13] = {
                        ["y"] = -405.6,
                        ["x"] = 101.3,
                    },
                    [14] = {
                        ["y"] = -449.1,
                        ["x"] = 118.6,
                    },
                    [15] = {
                        ["y"] = -483.8,
                        ["x"] = 173,
                    },
                    [16] = {
                        ["y"] = -487.8,
                        ["x"] = 211.2,
                    },
                    [17] = {
                        ["y"] = -479.8,
                        ["x"] = 211.6,
                    },
                    [18] = {
                        ["y"] = -477,
                        ["x"] = 175,
                    },
                    [19] = {
                        ["y"] = -444.6,
                        ["x"] = 123.6,
                    },
                    [20] = {
                        ["y"] = -403.3,
                        ["x"] = 105.8,
                    },
                    [21] = {
                        ["y"] = -349.3,
                        ["x"] = 110.1,
                    },
                    [22] = {
                        ["y"] = -316.9,
                        ["x"] = 129.3,
                    },
                    [23] = {
                        ["y"] = -292.2,
                        ["x"] = 159.3,
                    },
                    [24] = {
                        ["y"] = -283.9,
                        ["x"] = 198.8,
                    },
                    [25] = {
                        ["y"] = -289.1,
                        ["x"] = 234.4,
                    },
                    [26] = {
                        ["y"] = -313.9,
                        ["x"] = 277.7,
                    },
                    [27] = {
                        ["y"] = -351.9,
                        ["x"] = 298.2,
                    },
                    [28] = {
                        ["y"] = -375.9,
                        ["x"] = 317.3,
                    },
                    [29] = {
                        ["y"] = -404.9,
                        ["x"] = 366.2,
                    },
                    [30] = {
                        ["y"] = -403.7,
                        ["x"] = 418.7,
                    },
                    [31] = {
                        ["y"] = -386.9,
                        ["x"] = 459.6,
                    },
                    [32] = {
                        ["y"] = -343.1,
                        ["x"] = 479.8,
                    },
                    [33] = {
                        ["y"] = -309.3,
                        ["x"] = 480.8,
                    },
                    [34] = {
                        ["y"] = -285.1,
                        ["x"] = 482,
                    },
                    [35] = {
                        ["y"] = -278.4,
                        ["x"] = 494.3,
                    },
                    [36] = {
                        ["y"] = -278.4,
                        ["x"] = 521.2,
                    },
                    [37] = {
                        ["y"] = -272,
                        ["x"] = 521,
                    },
                    [38] = {
                        ["y"] = -275.1,
                        ["x"] = 488.9,
                    },
                    [39] = {
                        ["y"] = -282.2,
                        ["x"] = 478.6,
                    },
                    [40] = {
                        ["y"] = -294.1,
                        ["x"] = 473.9,
                    },
                    [41] = {
                        ["y"] = -316.2,
                        ["x"] = 473.9,
                    },
                    [42] = {
                        ["y"] = -337.9,
                        ["x"] = 474.3,
                    },
                    [43] = {
                        ["y"] = -364.5,
                        ["x"] = 465.8,
                    },
                },
            },
            [3] = {
                ["sublevel"] = 4,
                ["y"] = -364.6,
                ["x"] = 288.6,
                ["patrol"] = {
                    [1] = {
                        ["y"] = -290.4,
                        ["x"] = 407.2,
                    },
                    [2] = {
                        ["y"] = -285,
                        ["x"] = 386.4,
                    },
                    [3] = {
                        ["y"] = -340.6,
                        ["x"] = 373.3,
                    },
                    [4] = {
                        ["y"] = -371.8,
                        ["x"] = 365.8,
                    },
                    [5] = {
                        ["y"] = -380.6,
                        ["x"] = 347.3,
                    },
                    [6] = {
                        ["y"] = -352.3,
                        ["x"] = 241.6,
                    },
                    [7] = {
                        ["y"] = -333.5,
                        ["x"] = 231.9,
                    },
                    [8] = {
                        ["y"] = -269.8,
                        ["x"] = 249.4,
                    },
                    [9] = {
                        ["y"] = -267.3,
                        ["x"] = 228.6,
                    },
                    [10] = {
                        ["y"] = -332.7,
                        ["x"] = 214.6,
                    },
                    [11] = {
                        ["y"] = -353,
                        ["x"] = 220.6,
                    },
                    [12] = {
                        ["y"] = -367.4,
                        ["x"] = 233.3,
                    },
                    [13] = {
                        ["y"] = -371.5,
                        ["x"] = 240.6,
                    },
                    [14] = {
                        ["y"] = -386.1,
                        ["x"] = 298.2,
                    },
                    [15] = {
                        ["y"] = -389.2,
                        ["x"] = 297.4,
                    },
                    [16] = {
                        ["y"] = -374.6,
                        ["x"] = 239.7,
                    },
                    [17] = {
                        ["y"] = -363,
                        ["x"] = 224.6,
                    },
                    [18] = {
                        ["y"] = -353.4,
                        ["x"] = 215.5,
                    },
                    [19] = {
                        ["y"] = -332.6,
                        ["x"] = 211.8,
                    },
                    [20] = {
                        ["y"] = -262.9,
                        ["x"] = 226.2,
                    },
                    [21] = {
                        ["y"] = -265.4,
                        ["x"] = 246.9,
                    },
                    [22] = {
                        ["y"] = -295.9,
                        ["x"] = 238.4,
                    },
                    [23] = {
                        ["y"] = -333,
                        ["x"] = 227.9,
                    },
                    [24] = {
                        ["y"] = -356.2,
                        ["x"] = 239.5,
                    },
                    [25] = {
                        ["y"] = -384.3,
                        ["x"] = 348.2,
                    },
                    [26] = {
                        ["y"] = -373.2,
                        ["x"] = 370.1,
                    },
                    [27] = {
                        ["y"] = -289.6,
                        ["x"] = 388.4,
                    },
                    [28] = {
                        ["y"] = -294.3,
                        ["x"] = 406.3,
                    },
                    [29] = {
                        ["y"] = -290.3,
                        ["x"] = 407.2,
                    },
                },
            },
        },
        ["healthPercentage"] = 100,
    },
    [17] = {
        ["name"] = "Leprous Assistant",
        ["id"] = 7603,
        ["count"] = 0,
        ["health"] = 12192,
        ["scale"] = 0.8,
        ["stealthDetect"] = 0,
        ["displayId"] = 6967,
        ["creatureType"] = "Humanoid",
        ["level"] = 70,
        ["clones"] = {
            [1] = {
                ["sublevel"] = 3,
                ["y"] = -346.5,
                ["x"] = 501.7,
                ["g"] = 16,
            },
            [2] = {
                ["sublevel"] = 3,
                ["y"] = -347.2,
                ["x"] = 496,
                ["g"] = 16,
            },
            [3] = {
                ["sublevel"] = 3,
                ["y"] = -405.9,
                ["x"] = 621.8,
                ["g"] = 22,
            },
            [4] = {
                ["sublevel"] = 3,
                ["y"] = -414.2,
                ["x"] = 553.6,
                ["g"] = 23,
            },
            [5] = {
                ["sublevel"] = 3,
                ["y"] = -408.9,
                ["x"] = 553,
                ["g"] = 23,
            },
            [6] = {
                ["sublevel"] = 3,
                ["y"] = -407.3,
                ["x"] = 558.7,
                ["g"] = 23,
            },
            [7] = {
                ["sublevel"] = 3,
                ["y"] = -412.7,
                ["x"] = 560.4,
                ["g"] = 23,
            },
            [8] = {
                ["sublevel"] = 3,
                ["y"] = -407.9,
                ["x"] = 617,
                ["g"] = 22,
            },
            [9] = {
                ["sublevel"] = 3,
                ["y"] = -412.5,
                ["x"] = 616.3,
                ["g"] = 22,
            },
            [10] = {
                ["sublevel"] = 3,
                ["y"] = -407.7,
                ["x"] = 625.3,
                ["g"] = 22,
            },
            [11] = {
                ["sublevel"] = 3,
                ["y"] = -341.8,
                ["x"] = 497.9,
                ["g"] = 16,
            },
            [12] = {
                ["sublevel"] = 2,
                ["y"] = -411.3,
                ["x"] = 105.6,
                ["g"] = 14,
            },
            [13] = {
                ["sublevel"] = 3,
                ["y"] = -335.5,
                ["x"] = 487.6,
                ["g"] = 16,
            },
            [14] = {
                ["sublevel"] = 2,
                ["y"] = -288.8,
                ["x"] = 225.1,
                ["g"] = 24,
            },
            [15] = {
                ["sublevel"] = 2,
                ["y"] = -423.6,
                ["x"] = 300.7,
                ["g"] = 21,
            },
            [16] = {
                ["sublevel"] = 2,
                ["y"] = -427.4,
                ["x"] = 297.8,
                ["g"] = 21,
            },
            [17] = {
                ["sublevel"] = 2,
                ["y"] = -419.2,
                ["x"] = 297.4,
                ["g"] = 21,
            },
            [18] = {
                ["sublevel"] = 2,
                ["y"] = -424.2,
                ["x"] = 293.3,
                ["g"] = 21,
            },
            [19] = {
                ["sublevel"] = 2,
                ["y"] = -481.8,
                ["x"] = 202,
                ["g"] = 15,
            },
            [20] = {
                ["sublevel"] = 2,
                ["y"] = -485.1,
                ["x"] = 205.9,
                ["g"] = 15,
            },
            [21] = {
                ["sublevel"] = 2,
                ["y"] = -484.8,
                ["x"] = 198.2,
                ["g"] = 15,
            },
            [22] = {
                ["sublevel"] = 2,
                ["y"] = -297.1,
                ["x"] = 279.5,
                ["g"] = 19,
            },
            [23] = {
                ["sublevel"] = 2,
                ["y"] = -302.6,
                ["x"] = 278.4,
                ["g"] = 19,
            },
            [24] = {
                ["sublevel"] = 2,
                ["y"] = -307.2,
                ["x"] = 281.9,
                ["g"] = 19,
            },
            [25] = {
                ["sublevel"] = 2,
                ["y"] = -309,
                ["x"] = 287.9,
                ["g"] = 19,
            },
            [26] = {
                ["sublevel"] = 2,
                ["y"] = -294,
                ["x"] = 226.2,
                ["g"] = 24,
            },
            [27] = {
                ["sublevel"] = 2,
                ["y"] = -487.5,
                ["x"] = 201.6,
                ["g"] = 15,
            },
            [28] = {
                ["sublevel"] = 3,
                ["y"] = -441.7,
                ["x"] = 427.2,
                ["g"] = 25,
            },
            [29] = {
                ["sublevel"] = 2,
                ["y"] = -286.4,
                ["x"] = 216.5,
                ["g"] = 24,
            },
            [30] = {
                ["sublevel"] = 2,
                ["y"] = -289.9,
                ["x"] = 212.9,
                ["g"] = 24,
            },
            [31] = {
                ["sublevel"] = 2,
                ["y"] = -306,
                ["x"] = 131.8,
                ["g"] = 13,
            },
            [32] = {
                ["sublevel"] = 2,
                ["y"] = -301.6,
                ["x"] = 136.7,
                ["g"] = 13,
            },
            [33] = {
                ["sublevel"] = 2,
                ["y"] = -306.4,
                ["x"] = 141.6,
                ["g"] = 13,
            },
            [34] = {
                ["sublevel"] = 2,
                ["y"] = -309.9,
                ["x"] = 136.5,
                ["g"] = 13,
            },
            [35] = {
                ["sublevel"] = 2,
                ["y"] = -369.7,
                ["x"] = 97,
                ["g"] = 26,
            },
            [36] = {
                ["sublevel"] = 2,
                ["y"] = -378.9,
                ["x"] = 100.8,
                ["g"] = 26,
            },
            [37] = {
                ["sublevel"] = 2,
                ["y"] = -377.3,
                ["x"] = 105.9,
                ["g"] = 26,
            },
            [38] = {
                ["sublevel"] = 2,
                ["y"] = -372.8,
                ["x"] = 102.1,
                ["g"] = 26,
            },
            [39] = {
                ["sublevel"] = 2,
                ["y"] = -417.6,
                ["x"] = 107.1,
                ["g"] = 14,
            },
            [40] = {
                ["sublevel"] = 2,
                ["y"] = -415.5,
                ["x"] = 114.2,
                ["g"] = 14,
            },
            [41] = {
                ["sublevel"] = 3,
                ["y"] = -158.1,
                ["x"] = 190.8,
                ["g"] = 17,
            },
            [42] = {
                ["sublevel"] = 3,
                ["y"] = -158.8,
                ["x"] = 195.5,
                ["g"] = 17,
            },
            [43] = {
                ["sublevel"] = 3,
                ["y"] = -153.3,
                ["x"] = 192.1,
                ["g"] = 17,
            },
            [44] = {
                ["sublevel"] = 3,
                ["y"] = -154.1,
                ["x"] = 196.7,
                ["g"] = 17,
            },
            [45] = {
                ["sublevel"] = 3,
                ["y"] = -440.2,
                ["x"] = 433.2,
                ["g"] = 25,
            },
            [46] = {
                ["sublevel"] = 3,
                ["y"] = -442.1,
                ["x"] = 437.6,
                ["g"] = 25,
            },
            [47] = {
                ["sublevel"] = 3,
                ["y"] = -447.4,
                ["x"] = 437.1,
                ["g"] = 25,
            },
            [48] = {
                ["sublevel"] = 3,
                ["y"] = -433.8,
                ["x"] = 308.4,
                ["g"] = 20,
            },
            [49] = {
                ["sublevel"] = 3,
                ["y"] = -432.7,
                ["x"] = 314.2,
                ["g"] = 20,
            },
            [50] = {
                ["sublevel"] = 3,
                ["y"] = -428.8,
                ["x"] = 310.7,
                ["g"] = 20,
            },
            [51] = {
                ["sublevel"] = 3,
                ["y"] = -423.6,
                ["x"] = 312.3,
                ["g"] = 20,
            },
            [52] = {
                ["sublevel"] = 3,
                ["y"] = -362.4,
                ["x"] = 389.3,
                ["g"] = 27,
            },
            [53] = {
                ["sublevel"] = 3,
                ["y"] = -362.1,
                ["x"] = 385,
                ["g"] = 27,
            },
            [54] = {
                ["sublevel"] = 3,
                ["y"] = -358.2,
                ["x"] = 375.3,
                ["g"] = 27,
            },
            [55] = {
                ["sublevel"] = 2,
                ["y"] = -409.3,
                ["x"] = 111.8,
                ["g"] = 14,
            },
            [56] = {
                ["sublevel"] = 3,
                ["y"] = -228.9,
                ["x"] = 286,
                ["g"] = 28,
            },
            [57] = {
                ["sublevel"] = 3,
                ["y"] = -231.2,
                ["x"] = 282.3,
                ["g"] = 28,
            },
            [58] = {
                ["sublevel"] = 3,
                ["y"] = -234.5,
                ["x"] = 277.7,
                ["g"] = 28,
            },
            [59] = {
                ["sublevel"] = 4,
                ["y"] = -450.1,
                ["x"] = 538.2,
                ["g"] = 29,
                ["patrol"] = {
                    [1] = {
                        ["y"] = -451,
                        ["x"] = 538.4,
                    },
                    [2] = {
                        ["y"] = -431.3,
                        ["x"] = 542.9,
                    },
                    [3] = {
                        ["y"] = -430.9,
                        ["x"] = 537.9,
                    },
                    [4] = {
                        ["y"] = -451,
                        ["x"] = 533.3,
                    },
                    [5] = {
                        ["y"] = -472.3,
                        ["x"] = 531.9,
                    },
                    [6] = {
                        ["y"] = -476.7,
                        ["x"] = 531.6,
                    },
                    [7] = {
                        ["y"] = -495.8,
                        ["x"] = 508.4,
                    },
                    [8] = {
                        ["y"] = -500.3,
                        ["x"] = 513.2,
                    },
                    [9] = {
                        ["y"] = -482.9,
                        ["x"] = 535.8,
                    },
                    [10] = {
                        ["y"] = -481.7,
                        ["x"] = 537.6,
                    },
                    [11] = {
                        ["y"] = -484,
                        ["x"] = 553.7,
                    },
                    [12] = {
                        ["y"] = -484.5,
                        ["x"] = 567.7,
                    },
                    [13] = {
                        ["y"] = -484.5,
                        ["x"] = 574.5,
                    },
                    [14] = {
                        ["y"] = -472.9,
                        ["x"] = 595,
                    },
                    [15] = {
                        ["y"] = -464.7,
                        ["x"] = 602.1,
                    },
                    [16] = {
                        ["y"] = -462.5,
                        ["x"] = 595.8,
                    },
                    [17] = {
                        ["y"] = -469,
                        ["x"] = 590.5,
                    },
                    [18] = {
                        ["y"] = -477.5,
                        ["x"] = 575.1,
                    },
                    [19] = {
                        ["y"] = -478.7,
                        ["x"] = 567.2,
                    },
                    [20] = {
                        ["y"] = -478,
                        ["x"] = 555.9,
                    },
                    [21] = {
                        ["y"] = -475.4,
                        ["x"] = 543.2,
                    },
                    [22] = {
                        ["y"] = -497.2,
                        ["x"] = 514.2,
                    },
                    [23] = {
                        ["y"] = -495.5,
                        ["x"] = 512.1,
                    },
                    [24] = {
                        ["y"] = -473,
                        ["x"] = 538.7,
                    },
                    [25] = {
                        ["y"] = -451.1,
                        ["x"] = 538.4,
                    },
                },
            },
            [60] = {
                ["sublevel"] = 4,
                ["y"] = -450.5,
                ["x"] = 532.4,
                ["g"] = 29,
            },
            [61] = {
                ["sublevel"] = 4,
                ["y"] = -458.5,
                ["x"] = 537.2,
                ["g"] = 29,
            },
            [62] = {
                ["sublevel"] = 4,
                ["y"] = -458.2,
                ["x"] = 532.5,
                ["g"] = 29,
            },
            [63] = {
                ["sublevel"] = 2,
                ["y"] = -366.8,
                ["x"] = 297.4,
                ["g"] = 30,
            },
            [64] = {
                ["sublevel"] = 2,
                ["y"] = -371.9,
                ["x"] = 302.3,
                ["g"] = 30,
            },
            [65] = {
                ["sublevel"] = 2,
                ["y"] = -385.1,
                ["x"] = 301,
                ["g"] = 30,
            },
            [66] = {
                ["sublevel"] = 2,
                ["y"] = -388.7,
                ["x"] = 294.6,
                ["g"] = 30,
            },
            [67] = {
                ["sublevel"] = 3,
                ["y"] = -362,
                ["x"] = 380.4,
                ["g"] = 27,
            },
        },
        ["healthPercentage"] = 100,
    },
    [18] = {
        ["name"] = "Leprous Technician",
        ["id"] = 6222,
        ["count"] = 0,
        ["health"] = 7925,
        ["scale"] = 0.8,
        ["stealthDetect"] = 0,
        ["displayId"] = 6932,
        ["creatureType"] = "Humanoid",
        ["level"] = 70,
        ["clones"] = {
            [1] = {
                ["sublevel"] = 2,
                ["y"] = -378.2,
                ["x"] = 303.1,
                ["g"] = 30,
            },
            [2] = {
                ["sublevel"] = 3,
                ["y"] = -146.5,
                ["x"] = 184,
            },
            [3] = {
                ["sublevel"] = 3,
                ["y"] = -148.6,
                ["x"] = 193.3,
                ["g"] = 17,
            },
            [4] = {
                ["sublevel"] = 3,
                ["y"] = -183.9,
                ["x"] = 225,
            },
            [5] = {
                ["sublevel"] = 3,
                ["y"] = -127.1,
                ["x"] = 243.8,
            },
            [6] = {
                ["sublevel"] = 2,
                ["y"] = -433.2,
                ["x"] = 301.9,
                ["patrol"] = {
                    [1] = {
                        ["y"] = -416.3,
                        ["x"] = 288.4,
                    },
                    [2] = {
                        ["y"] = -413.2,
                        ["x"] = 289.9,
                    },
                    [3] = {
                        ["y"] = -419.5,
                        ["x"] = 310.1,
                    },
                    [4] = {
                        ["y"] = -439.2,
                        ["x"] = 298.5,
                    },
                    [5] = {
                        ["y"] = -425.3,
                        ["x"] = 284.2,
                    },
                    [6] = {
                        ["y"] = -421.9,
                        ["x"] = 286.2,
                    },
                    [7] = {
                        ["y"] = -424,
                        ["x"] = 291,
                    },
                    [8] = {
                        ["y"] = -419,
                        ["x"] = 295,
                    },
                    [9] = {
                        ["y"] = -416.4,
                        ["x"] = 288.4,
                    },
                },
            },
            [7] = {
                ["sublevel"] = 3,
                ["y"] = -170.4,
                ["x"] = 264.5,
            },
            [8] = {
                ["sublevel"] = 2,
                ["y"] = -286.4,
                ["x"] = 221.4,
                ["g"] = 24,
            },
            [9] = {
                ["sublevel"] = 3,
                ["y"] = -234.4,
                ["x"] = 286.2,
                ["g"] = 28,
            },
            [10] = {
                ["sublevel"] = 2,
                ["y"] = -292.8,
                ["x"] = 266.6,
            },
            [11] = {
                ["sublevel"] = 2,
                ["y"] = -375.4,
                ["x"] = 97,
                ["g"] = 26,
            },
            [12] = {
                ["sublevel"] = 2,
                ["y"] = -491.6,
                ["x"] = 193.9,
                ["patrol"] = {
                    [1] = {
                        ["y"] = -491.5,
                        ["x"] = 190.7,
                    },
                    [2] = {
                        ["y"] = -494,
                        ["x"] = 219.3,
                    },
                    [3] = {
                        ["y"] = -471.3,
                        ["x"] = 221,
                    },
                    [4] = {
                        ["y"] = -472.1,
                        ["x"] = 193.1,
                    },
                    [5] = {
                        ["y"] = -491.5,
                        ["x"] = 190.8,
                    },
                },
            },
            [13] = {
                ["sublevel"] = 3,
                ["y"] = -244.7,
                ["x"] = 308.2,
                ["patrol"] = {
                    [1] = {
                        ["y"] = -229.6,
                        ["x"] = 295.2,
                    },
                    [2] = {
                        ["y"] = -251.1,
                        ["x"] = 313.4,
                    },
                    [3] = {
                        ["y"] = -273.9,
                        ["x"] = 311.2,
                    },
                    [4] = {
                        ["y"] = -276.7,
                        ["x"] = 307.3,
                    },
                    [5] = {
                        ["y"] = -250.3,
                        ["x"] = 293.7,
                    },
                    [6] = {
                        ["y"] = -240.2,
                        ["x"] = 282.8,
                    },
                    [7] = {
                        ["y"] = -229.6,
                        ["x"] = 295.2,
                    },
                },
            },
            [14] = {
                ["sublevel"] = 3,
                ["y"] = -236.1,
                ["x"] = 281.6,
                ["g"] = 28,
            },
        },
        ["healthPercentage"] = 100,
    },
    [19] = {
        ["name"] = "Electrocutioner 6000",
        ["id"] = 220072,
        ["count"] = 0,
        ["health"] = 279345,
        ["scale"] = 1.6,
        ["stealthDetect"] = 0,
        ["displayId"] = 36558,
        ["creatureType"] = "Mechanical",
        ["level"] = 70,
        ["clones"] = {
            [1] = {
                ["sublevel"] = 2,
                ["y"] = -379.2,
                ["x"] = 209.6,
            },
        },
        ["healthPercentage"] = 100,
        ["isBoss"] = true,
    },
    [20] = {
        ["name"] = "Peacekeeper Security Suit",
        ["id"] = 6230,
        ["count"] = 0,
        ["health"] = 19020,
        ["scale"] = 1,
        ["stealthDetect"] = 0,
        ["displayId"] = 6774,
        ["creatureType"] = "Mechanical",
        ["level"] = 70,
        ["clones"] = {
            [1] = {
                ["sublevel"] = 2,
                ["y"] = -277.9,
                ["x"] = 178.5,
                ["patrol"] = {
                    [1] = {
                        ["y"] = -307.2,
                        ["x"] = 126.1,
                    },
                    [2] = {
                        ["y"] = -314.6,
                        ["x"] = 134.8,
                    },
                    [3] = {
                        ["y"] = -294.3,
                        ["x"] = 159.3,
                    },
                    [4] = {
                        ["y"] = -286.3,
                        ["x"] = 198.8,
                    },
                    [5] = {
                        ["y"] = -290.5,
                        ["x"] = 232.6,
                    },
                    [6] = {
                        ["y"] = -315.2,
                        ["x"] = 275,
                    },
                    [7] = {
                        ["y"] = -339.5,
                        ["x"] = 288,
                    },
                    [8] = {
                        ["y"] = -332.5,
                        ["x"] = 297.9,
                    },
                    [9] = {
                        ["y"] = -303.4,
                        ["x"] = 280.7,
                    },
                    [10] = {
                        ["y"] = -278.9,
                        ["x"] = 235.2,
                    },
                    [11] = {
                        ["y"] = -274.3,
                        ["x"] = 193.7,
                    },
                    [12] = {
                        ["y"] = -286,
                        ["x"] = 152.3,
                    },
                    [13] = {
                        ["y"] = -307.8,
                        ["x"] = 124.7,
                    },
                },
            },
            [2] = {
                ["sublevel"] = 3,
                ["y"] = -184.8,
                ["x"] = 237.7,
                ["patrol"] = {
                    [1] = {
                        ["y"] = -268.7,
                        ["x"] = 320.3,
                    },
                    [2] = {
                        ["y"] = -274.1,
                        ["x"] = 313.4,
                    },
                    [3] = {
                        ["y"] = -229.3,
                        ["x"] = 280,
                    },
                    [4] = {
                        ["y"] = -193.4,
                        ["x"] = 249.1,
                    },
                    [5] = {
                        ["y"] = -195,
                        ["x"] = 232.3,
                    },
                    [6] = {
                        ["y"] = -234,
                        ["x"] = 215.9,
                    },
                    [7] = {
                        ["y"] = -231.5,
                        ["x"] = 208.3,
                    },
                    [8] = {
                        ["y"] = -187.8,
                        ["x"] = 226.7,
                    },
                    [9] = {
                        ["y"] = -184,
                        ["x"] = 249.4,
                    },
                    [10] = {
                        ["y"] = -209.1,
                        ["x"] = 271.2,
                    },
                    [11] = {
                        ["y"] = -236,
                        ["x"] = 291.2,
                    },
                    [12] = {
                        ["y"] = -268.7,
                        ["x"] = 320.2,
                    },
                },
            },
            [3] = {
                ["sublevel"] = 3,
                ["y"] = -141.3,
                ["x"] = 205.5,
                ["patrol"] = {
                    [1] = {
                        ["y"] = -146.8,
                        ["x"] = 202.1,
                    },
                    [2] = {
                        ["y"] = -164.9,
                        ["x"] = 198.1,
                    },
                    [3] = {
                        ["y"] = -181.5,
                        ["x"] = 215.4,
                    },
                    [4] = {
                        ["y"] = -176.5,
                        ["x"] = 247.2,
                    },
                    [5] = {
                        ["y"] = -160.2,
                        ["x"] = 259.6,
                    },
                    [6] = {
                        ["y"] = -137.7,
                        ["x"] = 253.2,
                    },
                    [7] = {
                        ["y"] = -126.9,
                        ["x"] = 233.1,
                    },
                    [8] = {
                        ["y"] = -131.9,
                        ["x"] = 213,
                    },
                    [9] = {
                        ["y"] = -146.9,
                        ["x"] = 202.1,
                    },
                },
            },
        },
        ["healthPercentage"] = 100,
    },
    [21] = {
        ["name"] = "Mechano-Tank",
        ["id"] = 6225,
        ["count"] = 0,
        ["health"] = 23775,
        ["scale"] = 1,
        ["stealthDetect"] = 0,
        ["displayId"] = 5926,
        ["creatureType"] = "Mechanical",
        ["level"] = 70,
        ["clones"] = {
            [1] = {
                ["sublevel"] = 3,
                ["y"] = -124.2,
                ["x"] = 218.4,
            },
            [2] = {
                ["sublevel"] = 3,
                ["y"] = -153.9,
                ["x"] = 267.8,
            },
            [3] = {
                ["sublevel"] = 3,
                ["y"] = -188.6,
                ["x"] = 257.9,
            },
            [4] = {
                ["sublevel"] = 3,
                ["y"] = -174.3,
                ["x"] = 198.4,
            },
        },
        ["healthPercentage"] = 100,
    },
    [22] = {
        ["name"] = "Dark Iron Agent",
        ["id"] = 6212,
        ["count"] = 0,
        ["health"] = 15850,
        ["scale"] = 1,
        ["stealthDetect"] = 0,
        ["displayId"] = 3456,
        ["creatureType"] = "Humanoid",
        ["level"] = 70,
        ["clones"] = {
            [1] = {
                ["sublevel"] = 4,
                ["y"] = -372.8,
                ["x"] = 351.8,
                ["g"] = 31,
            },
            [2] = {
                ["sublevel"] = 4,
                ["y"] = -370.2,
                ["x"] = 347.6,
                ["g"] = 31,
            },
            [3] = {
                ["sublevel"] = 4,
                ["y"] = -399,
                ["x"] = 329.6,
                ["g"] = 32,
            },
            [4] = {
                ["sublevel"] = 4,
                ["y"] = -372.8,
                ["x"] = 368.2,
                ["g"] = 33,
            },
            [5] = {
                ["sublevel"] = 4,
                ["y"] = -327.9,
                ["x"] = 380.2,
                ["g"] = 34,
            },
            [6] = {
                ["sublevel"] = 4,
                ["y"] = -396.5,
                ["x"] = 334.8,
                ["g"] = 32,
            },
            [7] = {
                ["sublevel"] = 4,
                ["y"] = -400.7,
                ["x"] = 337.9,
                ["g"] = 32,
            },
            [8] = {
                ["sublevel"] = 4,
                ["y"] = -305.5,
                ["x"] = 382.1,
                ["g"] = 35,
            },
            [9] = {
                ["sublevel"] = 4,
                ["y"] = -350.4,
                ["x"] = 380.6,
                ["patrol"] = {
                    [1] = {
                        ["y"] = -385.3,
                        ["x"] = 340.8,
                    },
                    [2] = {
                        ["y"] = -386.9,
                        ["x"] = 349.5,
                    },
                    [3] = {
                        ["y"] = -374.1,
                        ["x"] = 373.6,
                    },
                    [4] = {
                        ["y"] = -302.8,
                        ["x"] = 389,
                    },
                    [5] = {
                        ["y"] = -303.9,
                        ["x"] = 392.5,
                    },
                    [6] = {
                        ["y"] = -375.1,
                        ["x"] = 376.8,
                    },
                    [7] = {
                        ["y"] = -389.7,
                        ["x"] = 350.3,
                    },
                    [8] = {
                        ["y"] = -388.2,
                        ["x"] = 339.4,
                    },
                    [9] = {
                        ["y"] = -385.3,
                        ["x"] = 340.8,
                    },
                },
            },
            [10] = {
                ["sublevel"] = 4,
                ["y"] = -344,
                ["x"] = 395.6,
                ["g"] = 36,
            },
            [11] = {
                ["sublevel"] = 4,
                ["y"] = -358.5,
                ["x"] = 308,
                ["patrol"] = {
                    [1] = {
                        ["y"] = -276.1,
                        ["x"] = 251.6,
                    },
                    [2] = {
                        ["y"] = -277.2,
                        ["x"] = 257.1,
                    },
                    [3] = {
                        ["y"] = -335.7,
                        ["x"] = 242,
                    },
                    [4] = {
                        ["y"] = -345,
                        ["x"] = 247.7,
                    },
                    [5] = {
                        ["y"] = -369.1,
                        ["x"] = 347.3,
                    },
                    [6] = {
                        ["y"] = -361.7,
                        ["x"] = 358.8,
                    },
                    [7] = {
                        ["y"] = -312.6,
                        ["x"] = 371.3,
                    },
                    [8] = {
                        ["y"] = -314.2,
                        ["x"] = 376.3,
                    },
                    [9] = {
                        ["y"] = -367.7,
                        ["x"] = 362.5,
                    },
                    [10] = {
                        ["y"] = -376.6,
                        ["x"] = 348.4,
                    },
                    [11] = {
                        ["y"] = -350.4,
                        ["x"] = 244.2,
                    },
                    [12] = {
                        ["y"] = -335.5,
                        ["x"] = 236.2,
                    },
                    [13] = {
                        ["y"] = -276.1,
                        ["x"] = 251.6,
                    },
                },
            },
            [12] = {
                ["sublevel"] = 4,
                ["y"] = -373.9,
                ["x"] = 344,
                ["g"] = 31,
            },
            [13] = {
                ["sublevel"] = 4,
                ["y"] = -375.7,
                ["x"] = 307.8,
                ["g"] = 37,
            },
            [14] = {
                ["sublevel"] = 4,
                ["y"] = -356.9,
                ["x"] = 291,
                ["g"] = 38,
            },
            [15] = {
                ["sublevel"] = 4,
                ["y"] = -352.3,
                ["x"] = 288.2,
                ["g"] = 38,
            },
            [16] = {
                ["sublevel"] = 4,
                ["y"] = -357.2,
                ["x"] = 286.2,
                ["g"] = 38,
            },
            [17] = {
                ["sublevel"] = 4,
                ["y"] = -260.7,
                ["x"] = 241.9,
                ["g"] = 39,
            },
            [18] = {
                ["sublevel"] = 4,
                ["y"] = -386.9,
                ["x"] = 282.6,
                ["g"] = 40,
            },
            [19] = {
                ["sublevel"] = 4,
                ["y"] = -354.4,
                ["x"] = 233.2,
                ["g"] = 41,
            },
            [20] = {
                ["sublevel"] = 4,
                ["y"] = -338.7,
                ["x"] = 244.5,
                ["g"] = 42,
            },
            [21] = {
                ["sublevel"] = 4,
                ["y"] = -305.1,
                ["x"] = 236.9,
                ["g"] = 43,
            },
            [22] = {
                ["sublevel"] = 4,
                ["y"] = -340.8,
                ["x"] = 239.8,
                ["g"] = 42,
            },
            [23] = {
                ["sublevel"] = 4,
                ["y"] = -335.1,
                ["x"] = 239.6,
                ["g"] = 42,
            },
        },
        ["healthPercentage"] = 100,
    },
    [23] = {
        ["name"] = "Mechanized Guardian",
        ["id"] = 6234,
        ["count"] = 0,
        ["health"] = 19020,
        ["scale"] = 1,
        ["stealthDetect"] = 0,
        ["displayId"] = 6979,
        ["creatureType"] = "Mechanical",
        ["level"] = 70,
        ["clones"] = {
            [1] = {
                ["sublevel"] = 4,
                ["y"] = -268.4,
                ["x"] = 247.1,
                ["g"] = 39,
            },
            [2] = {
                ["sublevel"] = 4,
                ["y"] = -329.1,
                ["x"] = 213.8,
                ["g"] = 44,
            },
            [3] = {
                ["sublevel"] = 4,
                ["y"] = -320.9,
                ["x"] = 215.4,
                ["g"] = 44,
            },
            [4] = {
                ["sublevel"] = 4,
                ["y"] = -307.4,
                ["x"] = 392.8,
                ["g"] = 35,
            },
            [5] = {
                ["sublevel"] = 4,
                ["y"] = -374.9,
                ["x"] = 373.4,
                ["g"] = 33,
            },
        },
        ["healthPercentage"] = 100,
    },
    [24] = {
        ["name"] = "Arcane Nullifier X-21",
        ["id"] = 6232,
        ["count"] = 0,
        ["health"] = 19020,
        ["scale"] = 1,
        ["stealthDetect"] = 0,
        ["displayId"] = 7288,
        ["creatureType"] = "Mechanical",
        ["level"] = 70,
        ["clones"] = {
            [1] = {
                ["sublevel"] = 4,
                ["y"] = -351.2,
                ["x"] = 238.8,
                ["g"] = 41,
            },
            [2] = {
                ["sublevel"] = 4,
                ["y"] = -297.3,
                ["x"] = 235.1,
                ["g"] = 43,
            },
            [3] = {
                ["sublevel"] = 4,
                ["y"] = -382.1,
                ["x"] = 284.1,
                ["g"] = 40,
            },
            [4] = {
                ["sublevel"] = 4,
                ["y"] = -330,
                ["x"] = 387.6,
                ["g"] = 34,
            },
            [5] = {
                ["sublevel"] = 4,
                ["y"] = -341.9,
                ["x"] = 391,
                ["g"] = 36,
            },
            [6] = {
                ["sublevel"] = 4,
                ["y"] = -393.9,
                ["x"] = 369.1,
            },
            [7] = {
                ["sublevel"] = 4,
                ["y"] = -347.7,
                ["x"] = 230.1,
                ["g"] = 41,
            },
            [8] = {
                ["sublevel"] = 4,
                ["y"] = -373.4,
                ["x"] = 314.4,
                ["g"] = 37,
            },
            [9] = {
                ["sublevel"] = 4,
                ["y"] = -266.8,
                ["x"] = 233,
                ["g"] = 39,
            },
        },
        ["healthPercentage"] = 100,
    },
    [25] = {
        ["name"] = "Mechano-Frostwalker",
        ["id"] = 6227,
        ["count"] = 0,
        ["health"] = 19020,
        ["scale"] = 1,
        ["stealthDetect"] = 0,
        ["displayId"] = 6891,
        ["creatureType"] = "Mechanical",
        ["level"] = 70,
        ["clones"] = {
            [1] = {
                ["sublevel"] = 4,
                ["y"] = -477.6,
                ["x"] = 537.3,
            },
            [2] = {
                ["sublevel"] = 4,
                ["y"] = -463.3,
                ["x"] = 491.3,
                ["patrol"] = {
                    [1] = {
                        ["y"] = -443.9,
                        ["x"] = 445.1,
                    },
                    [2] = {
                        ["y"] = -448.4,
                        ["x"] = 449.6,
                    },
                    [3] = {
                        ["y"] = -443,
                        ["x"] = 459.2,
                    },
                    [4] = {
                        ["y"] = -444.6,
                        ["x"] = 466.7,
                    },
                    [5] = {
                        ["y"] = -494.5,
                        ["x"] = 506.2,
                    },
                    [6] = {
                        ["y"] = -489.1,
                        ["x"] = 511.4,
                    },
                    [7] = {
                        ["y"] = -441.1,
                        ["x"] = 474.1,
                    },
                    [8] = {
                        ["y"] = -437.5,
                        ["x"] = 466.7,
                    },
                    [9] = {
                        ["y"] = -436.7,
                        ["x"] = 457.6,
                    },
                    [10] = {
                        ["y"] = -443.8,
                        ["x"] = 445.1,
                    },
                },
            },
            [3] = {
                ["sublevel"] = 4,
                ["y"] = -429.1,
                ["x"] = 399.9,
                ["patrol"] = {
                    [1] = {
                        ["y"] = -402.7,
                        ["x"] = 370.7,
                    },
                    [2] = {
                        ["y"] = -457,
                        ["x"] = 415.5,
                    },
                    [3] = {
                        ["y"] = -460.7,
                        ["x"] = 424.3,
                    },
                    [4] = {
                        ["y"] = -458.7,
                        ["x"] = 435.9,
                    },
                    [5] = {
                        ["y"] = -450.1,
                        ["x"] = 447.3,
                    },
                    [6] = {
                        ["y"] = -445.9,
                        ["x"] = 442.6,
                    },
                    [7] = {
                        ["y"] = -452.7,
                        ["x"] = 432.9,
                    },
                    [8] = {
                        ["y"] = -454,
                        ["x"] = 424.3,
                    },
                    [9] = {
                        ["y"] = -451.5,
                        ["x"] = 418.2,
                    },
                    [10] = {
                        ["y"] = -399.1,
                        ["x"] = 376.8,
                    },
                    [11] = {
                        ["y"] = -402.7,
                        ["x"] = 369.6,
                    },
                },
            },
            [4] = {
                ["sublevel"] = 3,
                ["y"] = -406.1,
                ["x"] = 589.1,
                ["patrol"] = {
                    [1] = {
                        ["y"] = -357.9,
                        ["x"] = 652.5,
                    },
                    [2] = {
                        ["y"] = -364.1,
                        ["x"] = 652.6,
                    },
                    [3] = {
                        ["y"] = -365.2,
                        ["x"] = 636.9,
                    },
                    [4] = {
                        ["y"] = -370.9,
                        ["x"] = 630.7,
                    },
                    [5] = {
                        ["y"] = -388.4,
                        ["x"] = 626.6,
                    },
                    [6] = {
                        ["y"] = -405.2,
                        ["x"] = 626.6,
                    },
                    [7] = {
                        ["y"] = -412.8,
                        ["x"] = 619.5,
                    },
                    [8] = {
                        ["y"] = -413.6,
                        ["x"] = 550.1,
                    },
                    [9] = {
                        ["y"] = -408.6,
                        ["x"] = 536.5,
                    },
                    [10] = {
                        ["y"] = -398.5,
                        ["x"] = 528.8,
                    },
                    [11] = {
                        ["y"] = -394.9,
                        ["x"] = 535,
                    },
                    [12] = {
                        ["y"] = -404.7,
                        ["x"] = 542.4,
                    },
                    [13] = {
                        ["y"] = -407.2,
                        ["x"] = 552.3,
                    },
                    [14] = {
                        ["y"] = -406.5,
                        ["x"] = 615.6,
                    },
                    [15] = {
                        ["y"] = -399.6,
                        ["x"] = 621.1,
                    },
                    [16] = {
                        ["y"] = -385.9,
                        ["x"] = 620.6,
                    },
                    [17] = {
                        ["y"] = -368.8,
                        ["x"] = 623.9,
                    },
                    [18] = {
                        ["y"] = -358.8,
                        ["x"] = 635.2,
                    },
                    [19] = {
                        ["y"] = -358,
                        ["x"] = 652.4,
                    },
                },
            },
            [5] = {
                ["sublevel"] = 3,
                ["y"] = -457.7,
                ["x"] = 304.7,
                ["patrol"] = {
                    [1] = {
                        ["y"] = -369.1,
                        ["x"] = 310.7,
                    },
                    [2] = {
                        ["y"] = -369.6,
                        ["x"] = 315.7,
                    },
                    [3] = {
                        ["y"] = -472.5,
                        ["x"] = 302.9,
                    },
                    [4] = {
                        ["y"] = -482.6,
                        ["x"] = 309.2,
                    },
                    [5] = {
                        ["y"] = -487.6,
                        ["x"] = 340.7,
                    },
                    [6] = {
                        ["y"] = -492.5,
                        ["x"] = 339.8,
                    },
                    [7] = {
                        ["y"] = -487.4,
                        ["x"] = 307.1,
                    },
                    [8] = {
                        ["y"] = -473.6,
                        ["x"] = 298,
                    },
                    [9] = {
                        ["y"] = -369.2,
                        ["x"] = 310.7,
                    },
                },
            },
            [6] = {
                ["sublevel"] = 3,
                ["y"] = -422,
                ["x"] = 308.2,
                ["g"] = 20,
            },
            [7] = {
                ["sublevel"] = 3,
                ["y"] = -366.8,
                ["x"] = 385.4,
                ["g"] = 27,
            },
        },
        ["healthPercentage"] = 100,
    },
    [26] = {
        ["name"] = "Mechano-Flamewalker",
        ["id"] = 6226,
        ["count"] = 0,
        ["health"] = 19020,
        ["scale"] = 1,
        ["stealthDetect"] = 0,
        ["displayId"] = 6890,
        ["creatureType"] = "Mechanical",
        ["level"] = 70,
        ["clones"] = {
            [1] = {
                ["sublevel"] = 4,
                ["y"] = -421.3,
                ["x"] = 555.9,
            },
            [2] = {
                ["sublevel"] = 3,
                ["y"] = -428.9,
                ["x"] = 435.8,
            },
            [3] = {
                ["sublevel"] = 4,
                ["y"] = -486.2,
                ["x"] = 576.9,
            },
            [4] = {
                ["sublevel"] = 3,
                ["y"] = -342.5,
                ["x"] = 488.4,
                ["g"] = 16,
            },
            [5] = {
                ["sublevel"] = 3,
                ["y"] = -470.7,
                ["x"] = 428.8,
                ["patrol"] = {
                    [1] = {
                        ["y"] = -500.3,
                        ["x"] = 385.7,
                    },
                    [2] = {
                        ["y"] = -504.1,
                        ["x"] = 416.2,
                    },
                    [3] = {
                        ["y"] = -491,
                        ["x"] = 432.5,
                    },
                    [4] = {
                        ["y"] = -383.1,
                        ["x"] = 444.9,
                    },
                    [5] = {
                        ["y"] = -382.3,
                        ["x"] = 440.2,
                    },
                    [6] = {
                        ["y"] = -490.3,
                        ["x"] = 426.6,
                    },
                    [7] = {
                        ["y"] = -498.3,
                        ["x"] = 415.2,
                    },
                    [8] = {
                        ["y"] = -495.1,
                        ["x"] = 386.3,
                    },
                    [9] = {
                        ["y"] = -499.6,
                        ["x"] = 385.7,
                    },
                },
            },
            [6] = {
                ["sublevel"] = 3,
                ["y"] = -357.1,
                ["x"] = 662.3,
                ["g"] = 18,
            },
        },
        ["healthPercentage"] = 100,
    },
    [27] = {
        ["name"] = "Leprous Machinesmith",
        ["id"] = 6224,
        ["count"] = 0,
        ["health"] = 12680,
        ["scale"] = 0.8,
        ["stealthDetect"] = 0,
        ["displayId"] = 6936,
        ["creatureType"] = "Humanoid",
        ["level"] = 70,
        ["clones"] = {
            [1] = {
                ["sublevel"] = 3,
                ["y"] = -361.4,
                ["x"] = 657,
                ["g"] = 18,
            },
            [2] = {
                ["sublevel"] = 4,
                ["y"] = -427.4,
                ["x"] = 581.8,
            },
            [3] = {
                ["sublevel"] = 3,
                ["y"] = -409.8,
                ["x"] = 620.5,
                ["g"] = 22,
            },
            [4] = {
                ["sublevel"] = 3,
                ["y"] = -412.9,
                ["x"] = 548.9,
                ["g"] = 23,
            },
            [5] = {
                ["sublevel"] = 3,
                ["y"] = -434.6,
                ["x"] = 435.4,
                ["g"] = 25,
            },
            [6] = {
                ["sublevel"] = 3,
                ["y"] = -447.8,
                ["x"] = 430.5,
                ["g"] = 25,
            },
            [7] = {
                ["sublevel"] = 3,
                ["y"] = -431.9,
                ["x"] = 301.8,
                ["g"] = 20,
            },
            [8] = {
                ["sublevel"] = 3,
                ["y"] = -388.4,
                ["x"] = 420.7,
                ["patrol"] = {
                    [1] = {
                        ["y"] = -355,
                        ["x"] = 334.1,
                    },
                    [2] = {
                        ["y"] = -369.7,
                        ["x"] = 434.5,
                    },
                    [3] = {
                        ["y"] = -377.7,
                        ["x"] = 441.2,
                    },
                    [4] = {
                        ["y"] = -394.8,
                        ["x"] = 418.4,
                    },
                    [5] = {
                        ["y"] = -392.3,
                        ["x"] = 416,
                    },
                    [6] = {
                        ["y"] = -377.5,
                        ["x"] = 435,
                    },
                    [7] = {
                        ["y"] = -374.2,
                        ["x"] = 432.2,
                    },
                    [8] = {
                        ["y"] = -360.5,
                        ["x"] = 332.9,
                    },
                    [9] = {
                        ["y"] = -355.1,
                        ["x"] = 334.1,
                    },
                },
            },
            [9] = {
                ["sublevel"] = 4,
                ["y"] = -474.1,
                ["x"] = 594.9,
            },
            [10] = {
                ["sublevel"] = 3,
                ["y"] = -357.6,
                ["x"] = 389.1,
                ["g"] = 27,
            },
            [11] = {
                ["sublevel"] = 4,
                ["y"] = -454.4,
                ["x"] = 535.5,
                ["g"] = 29,
            },
            [12] = {
                ["sublevel"] = 4,
                ["y"] = -472.1,
                ["x"] = 534.2,
            },
            [13] = {
                ["sublevel"] = 3,
                ["y"] = -366.7,
                ["x"] = 378.7,
                ["g"] = 27,
            },
        },
        ["healthPercentage"] = 100,
    },
    [28] = {
        ["name"] = "Crowd Pummeler 9-60",
        ["id"] = 215728,
        ["count"] = 0,
        ["health"] = 212834,
        ["scale"] = 1.6,
        ["stealthDetect"] = 0,
        ["displayId"] = 36560,
        ["creatureType"] = "Mechanical",
        ["level"] = 70,
        ["clones"] = {
            [1] = {
                ["sublevel"] = 3,
                ["y"] = -483,
                ["x"] = 364.1,
            },
        },
        ["healthPercentage"] = 100,
        ["isBoss"] = true,
    },
    [29] = {
        ["name"] = "Mechanical Menagrie: STX-04/BD",
        ["id"] = 218242,
        ["count"] = 0,
        ["health"] = 95015,
        ["scale"] = 1.6,
        ["stealthDetect"] = 0,
        ["displayId"] = 117365,
        ["creatureType"] = "Mechanical",
        ["level"] = 70,
        ["clones"] = {
            [1] = {
                ["sublevel"] = 4,
                ["y"] = -166.5,
                ["x"] = 263.1,
            },
        },
        ["healthPercentage"] = 100,
        ["isBoss"] = true,
    },
    [30] = {
        ["name"] = "Mechanical Menagrie: STX-13/LL",
        ["id"] = 218243,
        ["count"] = 0,
        ["health"] = 95015,
        ["scale"] = 1.6,
        ["stealthDetect"] = 0,
        ["displayId"] = 117366,
        ["creatureType"] = "Mechanical",
        ["level"] = 70,
        ["clones"] = {
            [1] = {
                ["sublevel"] = 4,
                ["y"] = -166.5,
                ["x"] = 263.1,
            },
        },
        ["healthPercentage"] = 100,
        ["isBoss"] = true,
    },
    [31] = {
        ["name"] = "Mechanical Menagrie: STX-25/NB",
        ["id"] = 218244,
        ["count"] = 0,
        ["health"] = 95015,
        ["scale"] = 1.6,
        ["stealthDetect"] = 0,
        ["displayId"] = 117367,
        ["creatureType"] = "Mechanical",
        ["level"] = 70,
        ["clones"] = {
            [1] = {
                ["sublevel"] = 4,
                ["y"] = -166.5,
                ["x"] = 263.1,
            },
        },
        ["healthPercentage"] = 100,
        ["isBoss"] = true,
    },
    [32] = {
        ["name"] = "Mechanical Menagrie: STX-37/CN",
        ["id"] = 218245,
        ["count"] = 0,
        ["health"] = 95015,
        ["scale"] = 1.6,
        ["stealthDetect"] = 0,
        ["displayId"] = 117368,
        ["creatureType"] = "Mechanical",
        ["level"] = 70,
        ["clones"] = {
            [1] = {
                ["sublevel"] = 4,
                ["y"] = -166.5,
                ["x"] = 263.1,
            },
        },
        ["healthPercentage"] = 100,
        ["isBoss"] = true,
    },
    [33] = {
        ["name"] = "Mekgineer Thermaplugg",
        ["id"] = 218537,
        ["count"] = 0,
        ["health"] = 692556,
        ["scale"] = 1.6,
        ["stealthDetect"] = 0,
        ["displayId"] = 36563,
        ["creatureType"] = "Mechanical",
        ["level"] = 70,
        ["clones"] = {
            [1] = {
                ["sublevel"] = 4,
                ["y"] = -166.5,
                ["x"] = 263.1,
            },
        },
        ["healthPercentage"] = 100,
        ["isBoss"] = true,
    },
    [34] = {
        ["name"] = "Dark Iron Ambassador",
        ["id"] = 6228,
        ["count"] = 0,
        ["health"] = 30432,
        ["scale"] = 1.6,
        ["stealthDetect"] = 0,
        ["displayId"] = 6669,
        ["creatureType"] = "Humanoid",
        ["level"] = 70,
        ["clones"] = {
            [1] = {
                ["sublevel"] = 4,
                ["y"] = -366.2,
                ["x"] = 266,
                ["patrol"] = {
                    [1] = {
                        ["y"] = -364.6,
                        ["x"] = 257.4,
                    },
                    [2] = {
                        ["y"] = -383.5,
                        ["x"] = 337.3,
                    },
                    [3] = {
                        ["y"] = -387,
                        ["x"] = 336,
                    },
                    [4] = {
                        ["y"] = -364.1,
                        ["x"] = 239.1,
                    },
                    [5] = {
                        ["y"] = -345.6,
                        ["x"] = 221.8,
                    },
                    [6] = {
                        ["y"] = -329.9,
                        ["x"] = 219.6,
                    },
                    [7] = {
                        ["y"] = -272.8,
                        ["x"] = 234.2,
                    },
                    [8] = {
                        ["y"] = -273.7,
                        ["x"] = 239.1,
                    },
                    [9] = {
                        ["y"] = -330.5,
                        ["x"] = 224.3,
                    },
                    [10] = {
                        ["y"] = -342.8,
                        ["x"] = 226,
                    },
                    [11] = {
                        ["y"] = -359.9,
                        ["x"] = 241.1,
                    },
                    [12] = {
                        ["y"] = -364.5,
                        ["x"] = 257.4,
                    },
                },
            },
        },
        ["healthPercentage"] = 100,
        ["isBoss"] = false,
    },
};
