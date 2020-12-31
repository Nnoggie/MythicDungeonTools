local dungeonIndex = 13
local pi = math.pi
local nerfMultiplier = 1
MDT.dungeonTotalCount[dungeonIndex] = {normal=210,teeming=252,teemingEnabled=true}
MDT.dungeonBosses[dungeonIndex] = {--Vault of the Wardens
	[1] = {
		[1] = {
            ["name"] = L["Tirathon Saltheril"],
            ["health"] = 93092225,
            ["encounterID"] = 1467,
            ["level"] = 112,
            ["creatureType"] = "Humanoid",
            ["id"] = 95885,
            ["displayId"] = 65074,
            ["x"] = 204.47549935713,
            ["y"] = -314.46941439106,
        },
	},
	[2] = {
		[1] = {
            ["name"] = L["Inquisitor Tormentorum"],
            ["health"] = 109796277,
            ["encounterID"] = 1695,
            ["level"] = 112,
            ["creatureType"] = "Demon",
            ["id"] = 96015,
            ["displayId"] = 64719,
            ["x"] = 390.17487880306,
            ["y"] = -268.58577151298,
			
        },
		[2] = {
            ["name"] = L["Glazer"],
            ["health"] = 93326832,
            ["encounterID"] = 1469,
            ["level"] = 112,
            ["creatureType"] = "Demon",
            ["id"] = 95887,
            ["displayId"] = 66204,
            ["x"] = 574.40148596632,
            ["y"] = -269.54206262591,
        },
		[3] = {
            ["name"] = L["Ash'Golm"],
            ["health"] = 109796277,
            ["encounterID"] = 1468,
            ["level"] = 112,
            ["creatureType"] = "Elemental",
            ["id"] = 95886,
            ["displayId"] = 65155,
            ["x"] = 393.63983170988,
            ["y"] = -441.64306520329,
        },
	},
	[3] = {
		[1] = {
            ["name"] = L["Cordana Felsong"],
            ["health"] = 114188132,
            ["encounterID"] = 1470,
            ["level"] = 112,
            ["creatureType"] = "Humanoid",
            ["id"] = 95888,
            ["displayId"] = 66480,
            ["x"] = 418.00001899153,
            ["y"] = -428.49984993413,
        },
	},
}
MDT.dungeonEnemies[dungeonIndex] = {
	[1] = {
        ["name"] = L["Shadow Hunter"],
        ["health"] = 14819297,
        ["level"] = 110,
        ["creatureType"] = "Humanoid",
        ["id"] = 98926,
        ["displayId"] = 70675,
        ["count"] = 4,
        ["scale"] = 1,
        ["color"] = {r=1,g=1,b=1,a=0.8},
        ["clones"] = {
            [1] = {x = 499.97784192895,y = -413.28600653065,sublevel=1,g=1},
			[2] = {x = 470.6017651176,y = -396.13641428313,sublevel=1,g=2},
			[3] = {x = 473.329055287,y = -382.95466738005,sublevel=1,g=2},
			[4] = {x = 336.77996407454,y = -435.41496924696,sublevel=1,g=7},
			[5] = {x = 257.9909487862,y = -432.64733635441,sublevel=1,g=10,patrolFacing=(16/32)*pi,patrolFacing2=(49/32)*pi,patrol={
                [1] = {x = 257.9909487862,y = -432.64733635441},
                [2] = {x = 203.75883160837,y = -432.64733635441},
                [3] = {x = 257.9909487862,y = -432.64733635441},
                [4] = {x = 274.50239598381,y = -432.64733635441},
            }},
            [6] = {x = 466.55658108302,y = -474.50292229169,sublevel=1,g=4,teeming=true},
            [7] = {x = 458.37473206549,y = -475.41202529674,sublevel=1,g=4,teeming=true},
        },
    },
	[2] = {
        ["name"] = L["Felsworn Infester"],
        ["health"] = 14819297,
        ["level"] = 110,
        ["creatureType"] = "Demon",
        ["id"] = 96587,
        ["displayId"] = 64253,
        ["count"] = 4,
        ["scale"] = 1,
        ["color"] = {r=1,g=1,b=1,a=0.8},
        ["clones"] = {
            [1] = {x = 507.25054892748,y = -407.83146652827,sublevel=1,g=1},
			[2] = {x = 469.19313773329,y = -387.69106051005,sublevel=1,g=2},
			[3] = {x = 467.37493172319,y = -383.60013600129,sublevel=1,g=2},
			[4] = {x = 501.11095955087,y = -454.54036628368,sublevel=1,g=3},
			[5] = {x = 462.50386364075,y = -469.77272540214,sublevel=1,g=4},
			[6] = {x = 463.09079402327,y = -481.13635690943,sublevel=1,g=4},
			[7] = {x = 330.7060573527,y = -431.59082387242,sublevel=1,g=7},
			[8] = {x = 234.72756577054,y = -442.95437965556,sublevel=1,g=9},
			[9] = {x = 207.61762528541,y = -375.22704337807,sublevel=1,g=11},
            [10] = {x = 500.85174221874,y = -405.21617467725,sublevel=1,g=1,teeming=true},
            [11] = {x = 329.49401829693,y = -414.74428808552,sublevel=1,g=7,teeming=true},
        },
    },
	[3] = {
        ["name"] = L["Immoliant Fury"],
        ["health"] = 14819297,
        ["level"] = 110,
        ["creatureType"] = "Demon",
        ["id"] = 96584,
        ["displayId"] = 65666,
        ["count"] = 4,
        ["scale"] = 1,
        ["color"] = {r=1,g=1,b=1,a=0.8},
        ["clones"] = {
            [1] = {x = 509.97775203685,y = -461.92231153764,sublevel=1,g=3},
			[2] = {x = 470.00693237102,y = -469.77281903985,sublevel=1,g=4},
			[3] = {x = 469.55238086849,y = -478.8637125415,sublevel=1,g=4},
			[4] = {x = 330.7060573527,y = -439.77263387599,sublevel=1,g=7},
			[5] = {x = 329.79695434765,y = -422.49993037077,sublevel=1,g=7},
			[6] = {x = 244.26815375828,y = -436.13610591631,sublevel=1,g=9},
            [7] = {x = 475.7062410865,y = -390.22712640379,sublevel=1,g=2,teeming=true},
            [8] = {x = 464.34264859316,y = -392.04529339993,sublevel=1,g=2,teeming=true},
            [9] = {x = 503.59712534374,y = -463.40894296133,sublevel=1,g=3,teeming=true},

        },
    },
	[4] = {
        ["name"] = L["Glayvianna Soulrender"],
        ["health"] = 35049510,
        ["level"] = 112,
        ["creatureType"] = "Humanoid",
        ["id"] = 98177,
        ["displayId"] = 70670,
        ["count"] = 12,
        ["scale"] = 1,
        ["color"] = {r=1,g=1,b=1,a=0.8},
        ["clones"] = {
            [1] = {x = 422.70495594293,y = -431.46779002201,sublevel=1},
        },
    },
	[5] = {
        ["name"] = L["Viletongue Belcher"],
        ["health"] = 2279892,
        ["level"] = 110,
        ["creatureType"] = "Demon",
        ["id"] = 96480,
        ["displayId"] = 73258,
        ["count"] = 1,
        ["scale"] = 0.8,
        ["color"] = {r=1,g=1,b=1,a=0.8},
        ["clones"] = {
            [1] = {x = 374.54149888408,y = -384.77976903606,sublevel=1,g=5},
			[2] = {x = 381.42437846466,y = -383.89392079191,sublevel=1,g=5},
			[3] = {x = 385.06075147089,y = -387.98484530067,sublevel=1,g=5},
			[4] = {x = 383.2425454608,y = -392.07571128851,sublevel=1,g=5},
			[5] = {x = 378.69706944952,y = -396.62116779283,sublevel=1,g=5},
			[6] = {x = 369.60615644089,y = -397.53030981182,sublevel=1,g=5},
			[7] = {x = 371.87887493956,y = -391.16666680439,sublevel=1,g=5,patrolFacing=(49/32)*pi,patrolFacing2=(18/32)*pi,patrol={
                [1] = {x = 371.87887493956,y = -391.16666680439},
                [2] = {x = 379.68306075916,y = -391.13324816176},
                [3] = {x = 371.87887493956,y = -391.16666680439},
                [4] = {x = 350.84152612303,y = -394.45737911767},
                [5] = {x = 339.02334311322,y = -414.91192363358},
                [6] = {x = 350.84152612303,y = -394.45737911767},
            }},
			[8] = {x = 365.9698224486,y = -386.16663929058,sublevel=1,g=5},
			[9] = {x = 368.46503804608,y = -483.09745338105,sublevel=1,g=6},
			[10] = {x = 376.19233556108,y = -484.91565939115,sublevel=1,g=6},
			[11] = {x = 379.37413755782,y = -484.46110788862,sublevel=1,g=6},
			[12] = {x = 375.73778405856,y = -478.55199687674,sublevel=1,g=6,patrolFacing=(48/32)*pi,patrolFacing2=(13/32)*pi,patrol={
                [1] = {x = 375.73778405856,y = -478.55199687674},
                [2] = {x = 390.06289885653,y = -480.68166597353},
                [3] = {x = 375.73778405856,y = -478.55199687674},
                [4] = {x = 349.37076557935,y = -471.13624047633},
                [5] = {x = 339.27370971267,y = -451.91311081536},
                [6] = {x = 349.37076557935,y = -471.13624047633},
            }},
			[13] = {x = 369.82869255365,y = -475.82474638252,sublevel=1,g=6},
			[14] = {x = 370.2832245492,y = -470.37020638014,sublevel=1,g=6},
			[15] = {x = 376.19233556108,y = -470.37020638014,sublevel=1,g=6},
			[16] = {x = 380.73779206539,y = -471.27928987821,sublevel=1,g=6},
			[17] = {x = 299.65414579404,y = -401.59087432555,sublevel=1,g=8},
			[18] = {x = 310.56322579881,y = -401.13630331605,sublevel=1,g=8},
			[19] = {x = 297.38142729538,y = -412.95450583284,sublevel=1,g=8},
			[20] = {x = 305.10868579643,y = -417.49994283017,sublevel=1,g=8},
			[21] = {x = 295.10866978276,y = -431.59084433865,sublevel=1,g=8},
			[22] = {x = 304.19958279138,y = -436.13632034994,sublevel=1,g=8},
			[23] = {x = 296.01777278781,y = -447.49993235025,sublevel=1,g=8},
			[24] = {x = 304.19958279138,y = -452.04538885457,sublevel=1,g=8},
			[25] = {x = 306.92685279257,y = -465.6817583675,sublevel=1,g=8},
			[26] = {x = 296.9268367789,y = -464.7726943764,sublevel=1,g=8},
        },
    },
	[6] = {
        ["name"] = L["Felsworn Myrmidon"],
        ["health"] = 14819297,
        ["level"] = 110,
        ["creatureType"] = "Humanoid",
        ["id"] = 98954,
        ["displayId"] = 64727,
        ["count"] = 4,
        ["scale"] = 1,
        ["color"] = {r=1,g=1,b=1,a=0.8},
        ["clones"] = {
            [1] = {x = 336.38577075246,y = -427.04538687508,sublevel=1,g=7},
			[2] = {x = 234.27297525407,y = -421.59073213461,sublevel=1,g=9},
			[3] = {x = 199.88762658021,y = -375.22704337807,sublevel=1,g=11},
            [4] = {x = 331.76677605585,y = -446.10791600514,sublevel=1,g=7,teeming=true},
        },
    },
	[7] = {
        ["name"] = L["Fel-Infused Fury"],
        ["health"] = 14819297,
        ["level"] = 110,
        ["creatureType"] = "Humanoid",
        ["id"] = 99956,
        ["displayId"] = 70673,
        ["count"] = 4,
        ["scale"] = 1,
        ["color"] = {r=1,g=1,b=1,a=0.8},
        ["clones"] = {
            [1] = {x = 243.36204904792,y = -427.95441415598,sublevel=1,g=9},
			[2] = {x = 257.9909487862,y = -438.64733635441,sublevel=1,g=10},
            [3] = {x = 234.08966582633,y = -432.49985770644,sublevel=1,g=9,teeming=true},
        },
    },
	[8] = {
        ["name"] = L["Blazing Imp"],
        ["health"] = 2222895,
        ["level"] = 110,
        ["creatureType"] = "Demon",
        ["id"] = 98963,
        ["displayId"] = 65894,
        ["count"] = 1,
        ["scale"] = 0.6,
        ["color"] = {r=1,g=1,b=1,a=0.8},
        ["clones"] = {
            [1] = {x = 244.64884122655,y = -171.28083400093,sublevel=1,g=12},
			[2] = {x = 238.81653499465,y = -166.70545529898,sublevel=1,g=12},
			[3] = {x = 236.9983679985,y = -171.25091180329,sublevel=1,g=12},
			[4] = {x = 246.99830598428,y = -178.97818981132,sublevel=1,g=12},
			[5] = {x = 246.08928100713,y = -187.61453181044,sublevel=1,g=12},
			[6] = {x = 252.45292401456,y = -196.70542531209,sublevel=1,g=12},
			[7] = {x = 241.08929250727,y = -203.06908782649,sublevel=1,g=12},
			[8] = {x = 245.18021701603,y = -210.34181433199,sublevel=1,g=12},
			[9] = {x = 250.63475701841,y = -211.70544933259,sublevel=1,g=12},
			[10] = {x = 248.04585763146,y = -202.69115840433,sublevel=1,g=12},
			[11] = {x = 243.50045964807,y = -192.69118140461,sublevel=1,g=12},
			[12] = {x = 236.22775264954,y = -179.05481189168,sublevel=1,g=12},
			[13] = {x = 249.40955115298,y = -171.78208538618,sublevel=1,g=12},
			
			[14] = {x = 208.45173433415,y = -170.81240734245,sublevel=1,g=13},
			[15] = {x = 212.99717133149,y = -176.72151835433,sublevel=1,g=13},
			[16] = {x = 208.90624682273,y = -181.72150685419,sublevel=1,g=13},
			[17] = {x = 204.81536132792,y = -184.44877685538,sublevel=1,g=13},
			[18] = {x = 192.99721733205,y = -184.44877685538,sublevel=1,g=13},
			[19] = {x = 199.36078231159,y = -178.08513384795,sublevel=1,g=13},
			[20] = {x = 197.54265432939,y = -170.81240734245,sublevel=1,g=13},
			[21] = {x = 194.36083282567,y = -173.53969685061,sublevel=1,g=13},
			[22] = {x = 192.08807531306,y = -183.08516136176,sublevel=1,g=13},
			[23] = {x = 196.17896080787,y = -184.90336737185,sublevel=1,g=13},
			[24] = {x = 158.18104716235,y = -209.45071956758,sublevel=1,g=13},
			[25] = {x = 167.72651167349,y = -210.35982257262,sublevel=1,g=13},
			[26] = {x = 168.63561467854,y = -204.45073106772,sublevel=1,g=13},
			[27] = {x = 158.18104716235,y = -202.17801256905,sublevel=1,g=13},
			[28] = {x = 163.46911349965,y = -205.35637293184,sublevel=1,g=13},
			[29] = {x = 168.92361448809,y = -198.53819792886,sublevel=1,g=13},
			[30] = {x = 157.10543147827,y = -196.26545992322,sublevel=1,g=13},
			[31] = {x = 158.46908598584,y = -184.44727691341,sublevel=1,g=13},
			[32] = {x = 167.10544749194,y = -188.99277243166,sublevel=1,g=13},
			[33] = {x = 166.31840851218,y = -175.72763077697,sublevel=1,g=13},
			[34] = {x = 180.74183651185,y = -182.17453890776,sublevel=1,g=13},
			[35] = {x = 182.56000350799,y = -176.26544740286,sublevel=1,g=13},
			[36] = {x = 171.65088448928,y = -172.62909390359,sublevel=1,g=13},
			[37] = {x = 170.74182049818,y = -182.62910991726,sublevel=1,g=13},
			[38] = {x = 158.46908598584,y = -178.992756418,sublevel=1,g=13},
			[39] = {x = 162.10541997813,y = -171.71999089855,sublevel=1,g=13},
			
			[40] = {x = 278,y = -170,sublevel=1},
			[41] = {x = 278,y = -175,sublevel=1},
			[42] = {x = 278,y = -180,sublevel=1},
			[43] = {x = 278,y = -185,sublevel=1},
			[44] = {x = 278,y = -190,sublevel=1},
			[45] = {x = 278,y = -195,sublevel=1},
			[46] = {x = 278,y = -200,sublevel=1},
			[47] = {x = 278,y = -205,sublevel=1},
			[48] = {x = 278,y = -210,sublevel=1},
			[49] = {x = 278,y = -215,sublevel=1},
			
			[50] = {x = 285,y = -170,sublevel=1},
			[51] = {x = 285,y = -175,sublevel=1},
			[52] = {x = 285,y = -180,sublevel=1},
			[53] = {x = 285,y = -185,sublevel=1},
			[54] = {x = 285,y = -190,sublevel=1},
			[55] = {x = 285,y = -195,sublevel=1},
			[56] = {x = 285,y = -200,sublevel=1},
			[57] = {x = 285,y = -205,sublevel=1},
			[58] = {x = 285,y = -210,sublevel=1},
			[59] = {x = 285,y = -215,sublevel=1},
			
        },		
    },
	[9] = {
        ["name"] = L["Foul Mother"],
        ["health"] = 31718924,
        ["level"] = 112,
        ["creatureType"] = "Demon",
        ["id"] = 98533,
        ["displayId"] = 67347,
        ["count"] = 10,
        ["scale"] = 1.4,
        ["color"] = {r=1,g=1,b=1,a=0.8},
        ["clones"] = {
            [1] = {x = 205.676170858,y = -156.27130167759,sublevel=1},
        },
    },
	[10] = {
        ["name"] = L["Dreadlord Mendacius"],
        ["health"] = 41234602,
        ["level"] = 112,
        ["creatureType"] = "Demon",
        ["id"] = 99649,
        ["displayId"] = 66917,
        ["count"] = 12,
        ["scale"] = 1.4,
        ["color"] = {r=1,g=1,b=1,a=0.8},
        ["clones"] = {
            [1] = {x = 393.65808187387,y = -320.6443517079,sublevel=2},
        },
    },
	[11] = {
        ["name"] = L["Blade Dancer Illianna"],
        ["health"] = 39859513,
        ["level"] = 111,
        ["creatureType"] = "Demon",
        ["id"] = 96657,
        ["displayId"] = 58479,
        ["count"] = 12,
        ["scale"] = 1.4,
        ["color"] = {r=1,g=1,b=1,a=0.8},
        ["clones"] = {
            [1] = {x = 451.94745697582,y = -269.05043199793,sublevel=2,g=14},
        },
    },
	[12] = {
        ["name"] = L["Malignant Defiler"],
        ["health"] = 11855438,
        ["level"] = 110,
        ["creatureType"] = "Demon",
        ["id"] = 102584,
        ["displayId"] = 65542,
        ["count"] = 4,
        ["scale"] = 1,
        ["color"] = {r=1,g=1,b=1,a=0.8},
        ["clones"] = {
            [1] = {x = 456.87240633746,y = -274.56792852463,sublevel=2,g=14},
			[2] = {x = 447.39392225338,y = -263.25119822359,sublevel=2,g=14},
			[3] = {x = 417.60418450386,y = -245.15144120374,sublevel=2},
			[4] = {x = 415.33150501914,y = -291.51508974492,sublevel=2},
			[5] = {x = 369.87562886356,y = -226.20469801618,sublevel=2},
			[6] = {x = 349.42108434765,y = -244.84107553594,sublevel=2},
			[7] = {x = 351.69380284632,y = -289.84105006258,sublevel=2},
			[8] = {x = 370.78473186861,y = -314.3865581012,sublevel=2},
        },
    },
	[13] = {
        ["name"] = L["Fel Scorcher"],
        ["health"] = 9119568,
        ["level"] = 110,
        ["creatureType"] = "Demon",
        ["id"] = 102583,
        ["displayId"] = 62511,
        ["count"] = 4,
        ["scale"] = 1,
        ["color"] = {r=1,g=1,b=1,a=0.8},
        ["clones"] = {
            [1] = {x = 456.87240633746,y = -263.25119822359,sublevel=2,g=14},
			[2] = {x = 447.25990992183,y = -274.56792852463,sublevel=2,g=14},
			[3] = {x = 432.32125327337,y = -292.23331441113,sublevel=2},
			[4] = {x = 415.50304274975,y = -312.23330742452,sublevel=2},
			[5] = {x = 431.41215026833,y = -245.86968537693,sublevel=2},
			[6] = {x = 415.50304274975,y = -229.50606536978,sublevel=2},
			[7] = {x = 368.05746186742,y = -245.75017854099,sublevel=2},
			[8] = {x = 368.05746186742,y = -293.47746208277,sublevel=2},
        },
    },
	[14] = {
        ["name"] = L["Grimhorn the Enslaver"],
        ["health"] = 41234602,
        ["level"] = 112,
        ["creatureType"] = "Demon",
        ["id"] = 102566,
        ["displayId"] = 64805,
        ["count"] = 12,
        ["scale"] = 1,
        ["color"] = {r=1,g=1,b=1,a=0.8},
        ["clones"] = {
            [1] = {x = 335.76209808547,y = -267.74188533521,sublevel=2},
        },
    },
	[15] = {
        ["name"] = L["Spirit of Vengeance"],
        ["health"] = 15330582,
        ["level"] = 111,
        ["creatureType"] = "Humanoid",
        ["id"] = 100364,
        ["displayId"] = 66403,
        ["count"] = 4,
        ["scale"] = 1,
        ["color"] = {r=1,g=1,b=1,a=0.8},
        ["clones"] = {
            [1] = {x = 416.99621260653,y = -122.23507482616,sublevel=3},
			[2] = {x = 419.12578137125,y = -182.42108118921,sublevel=3},
			[3] = {x = 423.85310609385,y = -195.93812040052,sublevel=3},
			[4] = {x = 453.05254099069,y = -207.59634912777,sublevel=3},
			[5] = {x = 418.8746616577,y = -285.49926446427,sublevel=3},
            [6] = {x = 413.79262506423,y = -264.68065199139,sublevel=3,g=18,teeming=true},
        },
    },
	[16] = {
        ["name"] = L["Barbed Spiderling"],
        ["health"] = 8891579,
        ["level"] = 110,
        ["creatureType"] = "Demon",
        ["id"] = 97677,
        ["displayId"] = 65922,
        ["count"] = 1,
        ["scale"] = 1,
        ["color"] = {r=1,g=1,b=1,a=0.8},
        ["clones"] = {
            [1] = {x = 465.14921513279,y = -142.45250980021,sublevel=3,g=15},
			[2] = {x = 456.55029936777,y = -141.67502532883,sublevel=3,g=15},
			[3] = {x = 458.36850537786,y = -148.49321983878,sublevel=3,g=15},
			[4] = {x = 465.64117336244,y = -150.7658993235,sublevel=3,g=15},
			
			[5] = {x = 372.8944576364,y = -147.6070903976,sublevel=3,g=16},
			[6] = {x = 376.53079162869,y = -154.87985591705,sublevel=3,g=16,patrolFacing=(50/32)*pi,patrolFacing2=(24/32)*pi,patrol={
                [1] = {x = 376.53079162869,y = -154.87985591705},
                [2] = {x = 390.43303644118,y = -154.37838504196},
                [3] = {x = 413.16033846971,y = -164.37844006958},
                [4] = {x = 390.43303644118,y = -154.37838504196},
                [5] = {x = 376.53079162869,y = -154.87985591705},
                [6] = {x = 359.52396342303,y = -168.01477406187},
                [7] = {x = 369.06938892022,y = -186.65111256768},
                [8] = {x = 384.52402296417,y = -193.01475557511},
                [9] = {x = 404.52393794966,y = -199.83296959204},
                [10] = {x = 429.06944598828,y = -205.742022083},
                [11] = {x = 404.52393794966,y = -199.83296959204},
                [12] = {x = 384.52402296417,y = -193.01475557511},
                [13] = {x = 369.06938892022,y = -186.65111256768},
                [14] = {x = 359.52396342303,y = -168.01477406187},
            }},
			[7] = {x = 366.98532711755,y = -158.97076091884,sublevel=3,g=16},
			[8] = {x = 365.62175063788,y = -153.06166941393,sublevel=3,g=16},
			[9] = {x = 371.05643350722,y = -153.78816274877,sublevel=3,g=16},
			[10] = {x = 361.96563754044,y = -157.42455526199,sublevel=3,g=16},
			
			[11] = {x = 420.80378498102,y = -203.0086987853,sublevel=3,g=17},
			[12] = {x = 428.98559587128,y = -202.55410821957,sublevel=3,g=17},
			[13] = {x = 431.71286616803,y = -203.0086987853,sublevel=3,g=17},
			[14] = {x = 424.89463190522,y = -208.008707334,sublevel=3,g=17},
			[15] = {x = 428.53100530554,y = -209.37234248237,sublevel=3,g=17},
			[16] = {x = 420.80378498102,y = -207.55415578221,sublevel=3,g=17},
        },
    },
	[17] = {
        ["name"] = L["Aranasi Broodmother"],
        ["health"] = 24528930,
        ["level"] = 111,
        ["creatureType"] = "Demon",
        ["id"] = 97678,
        ["displayId"] = 65926,
        ["count"] = 8,
        ["scale"] = 1,
        ["color"] = {r=1,g=1,b=1,a=0.8},
        ["clones"] = {
            [1] = {x = 409.58031686011,y = -181.96649067274,sublevel=3},
			[2] = {x = 420.67530441394,y = -150.83814995501,sublevel=3},
			[3] = {x = 418.42011010592,y = -260.49922172079,sublevel=3,g=18},
            [4] = {x = 424.24719258042,y = -263.9533819902,sublevel=3,g=18,teeming=true},
        },
    },
	
}