local MDT = MDT

--- AddOn / WeakAura Creators can use these functions to retrieve data from MDT

do
  local dungeonCountCache = {}

  --- Usage: local count, maxCountNormal, maxCountTeeming, teemingCount = MDT:GetEnemyForces(npcId)
  --- Prefers to find the npc in the current dungeon of the player
  --- @param npcId number
  --- @return number | nil, number | nil, number | nil, number | nil
  function MDT:GetEnemyForces(npcId)
    local zoneId = C_Map.GetBestMapForUnit("player")
    local dungeonIdx = self.zoneIdToDungeonIdx[zoneId]

    if dungeonIdx and dungeonCountCache[dungeonIdx] and dungeonCountCache[dungeonIdx][npcId] then
      local cached = dungeonCountCache[dungeonIdx][npcId]
      return cached.count, cached.maxCountNormal, cached.maxCountTeeming, cached.teemingCount
    end

    if dungeonIdx then
      local data = self.dungeonEnemies[dungeonIdx]
      for _, e in pairs(data) do
        if e.id == npcId then
          dungeonCountCache[dungeonIdx] = dungeonCountCache[dungeonIdx] or {}
          dungeonCountCache[dungeonIdx][npcId] = {
            count = e.count,
            maxCountNormal = self.dungeonTotalCount[dungeonIdx].normal,
            maxCountTeeming = self.dungeonTotalCount[dungeonIdx].teeming,
            teemingCount = e.teemingCount
          }
          local cached = dungeonCountCache[dungeonIdx][npcId]
          return cached.count, cached.maxCountNormal, cached.maxCountTeeming, cached.teemingCount
        end
      end
    end

    for i, _ in pairs(MDT.dungeonList) do
      if dungeonCountCache[i] and dungeonCountCache[i][npcId] then
        local cached = dungeonCountCache[i][npcId]
        return cached.count, cached.maxCountNormal, cached.maxCountTeeming, cached.teemingCount
      end

      local data = self.dungeonEnemies[i]
      if data then
        for _, e in pairs(data) do
          if e.id == npcId then
            dungeonCountCache[i] = dungeonCountCache[i] or {}
            dungeonCountCache[i][npcId] = {
              count = e.count,
              maxCountNormal = self.dungeonTotalCount[i].normal,
              maxCountTeeming = self.dungeonTotalCount[i].teeming,
              teemingCount = e.teemingCount or e.count,
            }
            local cached = dungeonCountCache[i][npcId]
            return cached.count, cached.maxCountNormal, cached.maxCountTeeming, cached.teemingCount
          end
        end
      end
    end
  end
end
