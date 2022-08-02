local MDT = MDT
local countCache = {}

--- AddOn / WeakAura Creators can use these functions to retrieve data from MDT

--- GetEnemyForces
--- Usage: local count, maxCountNormal, maxCountTeeming, teemingCount = MDT:GetEnemyForcers(npcId)
function MDT:GetEnemyForces(npcId)
  if countCache[npcId] then
    return countCache[npcId].count, countCache[npcId].maxCountNormal, countCache[npcId].maxCountTeeming,
        countCache[npcId].teemingCount
  else
    for i = 1, self:GetNumDungeons() do
      local data = self.dungeonEnemies[i]
      if data then
        for enemyIdx, enemy in pairs(data) do
          if enemy.id == npcId then
            --awakened fix
            if enemy.corrupted then
              local zoneId = C_Map.GetBestMapForUnit("player")
              local dungeonIdx = self.zoneIdToDungeonIdx[zoneId] or i
              data = self.dungeonEnemies[dungeonIdx]
              for enemyIdx, enemy in pairs(data) do
                if enemy.id == npcId then
                  return enemy.count, self.dungeonTotalCount[dungeonIdx].normal,
                      self.dungeonTotalCount[dungeonIdx].teeming, enemy.teemingCount
                end
              end
            else
              countCache[npcId] = {
                ["count"] = enemy.count,
                ["maxCountNormal"] = self.dungeonTotalCount[i].normal,
                ["maxCountTeeming"] = self.dungeonTotalCount[i].teeming,
                ["teemingCount"] = enemy.teemingCount or enemy.count,
              }
              return countCache[npcId].count, countCache[npcId].maxCountNormal, countCache[npcId].maxCountTeeming,
                  countCache[npcId].teemingCount
            end
          end
        end
      end
    end

  end
end
