local MDT = MDT
local L = MDT.L
local dungeonIndex = 100
MDT.dungeonList[dungeonIndex] = L["DawnOfTheInfiniteLower"]
MDT.mapInfo[dungeonIndex] = {

};

local function getSublevelMap(frame, sublevel)
  for i = 1, 12 do
    if frame["mapPanelTile"..i] then
      frame["mapPanelTile"..i]:Hide()
    end
  end
  for i = 1, 10 do
    for j = 1, 15 do
      local texName = 'Interface\\AddOns\\MythicDungeonTools\\Textures\\Nnoggie'
      local tile = frame["largeMapPanelTile"..i..j]
      tile:SetTexture(texName)
      tile:SetTexCoord(1 / i, 1, 1 / j, 1)
      tile:Show()
    end
  end
end


MDT.dungeonMaps[dungeonIndex] = {
  [0] = "",
  [1] = getSublevelMap,
}

MDT.dungeonSubLevels[dungeonIndex] = {
  [1] = L["dotiSublevel1"],
}

MDT.dungeonTotalCount[dungeonIndex] = { normal = 100, teeming = 1000, teemingEnabled = true }

MDT.mapPOIs[dungeonIndex] = {};

MDT.dungeonEnemies[dungeonIndex] = {};
