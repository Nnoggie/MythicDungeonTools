local MDT = MDT
local L = MDT.L

local dungeonIndex = 110
MDT.dungeonList[dungeonIndex] = L["The Stonevault"]
MDT.mapInfo[dungeonIndex] = {};

local zones = { 0 } -- TODO
for _, zone in ipairs(zones) do
  MDT.zoneIdToDungeonIdx[zone] = dungeonIndex
end

MDT.dungeonMaps[dungeonIndex] = {
  [0] = "",
  [1] = { customTextures = 'Stonevault' },
}

MDT.dungeonSubLevels[dungeonIndex] = {
  [1] = L["The Stonevault"],
}

MDT.dungeonTotalCount[dungeonIndex] = { normal = 520, teeming = 1000, teemingEnabled = true }

MDT.mapPOIs[dungeonIndex] = {};

MDT.dungeonEnemies[dungeonIndex] = {

}
