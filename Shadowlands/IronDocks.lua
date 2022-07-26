local MDT = MDT
local L = MDT.L
local dungeonIndex = 41
MDT.dungeonList[dungeonIndex] = L["IronDocks"]
MDT.mapInfo[dungeonIndex] = {
    
};

MDT.dungeonMaps[dungeonIndex] = {
  [0] = "IronDocks",
  [1] = "IronDocks1_",
}
MDT.dungeonSubLevels[dungeonIndex] = {
   [1] = L["IronDocks"],
}

MDT.mapPOIs[dungeonIndex] = {

};


 MDT.dungeonTotalCount[dungeonIndex] = {normal=1000,teeming=1000,teemingEnabled=true}
 MDT.dungeonEnemies[dungeonIndex] = {}