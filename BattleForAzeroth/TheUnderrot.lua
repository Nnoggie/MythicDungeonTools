local dungeonIndex = 22
local nerfMultiplier = 1
local pi = math.pi
MethodDungeonTools.dungeonTotalCount[dungeonIndex] = {normal=160,teeming=192,teemingEnabled=true}
MethodDungeonTools.mapLinks[dungeonIndex] = {
    [1] = {
        [1] = {
            ["y"] = -106.99817181006;
            ["x"] = 313.99999540486;
            ["direction"] = -2;
            ["target"] = 2;
        };
    };
    [2] = {
        [1] = {
            ["y"] = -436.99827826023;
            ["x"] = 612.99994620309;
            ["direction"] = 2;
            ["target"] = 1;
        };
    };
};

MethodDungeonTools.dungeonBosses[dungeonIndex] = {
	
}
MethodDungeonTools.dungeonEnemies[dungeonIndex] = {
    [1] = {
        ["clones"] = {
            [1] = {
                ["y"] = -451.47879325496;
                ["x"] = 366.26710647764;
                ["sublevel"] = 1;
                ["patrolFacing"]=(16/32)*pi;
                ["patrol"] = {};
            };
            [2] = {
                ["y"] = -409.56655037855;
                ["x"] = 352.15150476303;
                ["sublevel"] = 1;
            };
            [3] = {
                ["y"] = -408.26450962104;
                ["x"] = 370.19570001077;
                ["sublevel"] = 1;
            };
            [4] = {
                ["y"] = -440.40735394301;
                ["x"] = 373.05285058383;
                ["sublevel"] = 1;
            };
            [5] = {
                ["y"] = -436.83592339014;
                ["x"] = 324.48144411097;
                ["sublevel"] = 1;
            };
            [6] = {
                ["y"] = -399.6930885557;
                ["x"] = 344.83855381427;
                ["sublevel"] = 1;
            };
        };
        ["health"] = 66401;
        ["count"] = 0;
        ["id"] = "131402";
        ["scale"] = 1;
        ["level"] = 120;
        ["creatureType"] = "Beast";
        ["name"] = "Underrot Tick";
    };
    [2] = {
        ["clones"] = {};
        ["health"] = 531208;
        ["count"] = 0;
        ["id"] = "131436";
        ["scale"] = 1;
        ["level"] = 121;
        ["creatureType"] = "Humanoid";
        ["name"] = "Chosen Blood Matron";
    };
    [3] = {
        ["clones"] = {};
        ["health"] = 332005;
        ["count"] = 0;
        ["id"] = "130909";
        ["scale"] = 1;
        ["level"] = 120;
        ["creatureType"] = "Beast";
        ["name"] = "Fetid Maggot";
    };
};


