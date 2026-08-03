local _, MDT = ...

--- AddOn / WeakAura creators can use MythicDungeonToolsAPI to retrieve data from MDT.

do
  local dungeonCountCache = {}

  --- Usage: local count, maxCountNormal = MythicDungeonToolsAPI:GetEnemyForces(npcId)
  --- Prefers to find the npc in the current dungeon of the player
  --- @param npcId number | any
  --- @return number | nil, number | nil, number | nil, number | nil
  function MDT:GetEnemyForces(npcId)
    if not npcId or issecretvalue(npcId) then return end
    npcId = tonumber(npcId)
    if not npcId then return end
    local zoneId = C_Map.GetBestMapForUnit("player")
    local dungeonIdx = self.zoneIdToDungeonIdx[zoneId]

    if dungeonIdx and dungeonCountCache[dungeonIdx] and dungeonCountCache[dungeonIdx][npcId] then
      local cached = dungeonCountCache[dungeonIdx][npcId]
      return cached.count, cached.maxCountNormal
    end

    if dungeonIdx then
      local data = self.dungeonEnemies[dungeonIdx]
      for _, e in pairs(data) do
        if e.id == npcId then
          dungeonCountCache[dungeonIdx] = dungeonCountCache[dungeonIdx] or {}
          dungeonCountCache[dungeonIdx][npcId] = {
            count = e.count,
            maxCountNormal = self.dungeonTotalCount[dungeonIdx].normal,
          }
          local cached = dungeonCountCache[dungeonIdx][npcId]
          return cached.count, cached.maxCountNormal
        end
      end
    end

    for i, _ in pairs(MDT.dungeonList) do
      if dungeonCountCache[i] and dungeonCountCache[i][npcId] then
        local cached = dungeonCountCache[i][npcId]
        return cached.count, cached.maxCountNormal
      end

      local data = self.dungeonEnemies[i]
      if data then
        for _, e in pairs(data) do
          if e.id == npcId then
            dungeonCountCache[i] = dungeonCountCache[i] or {}
            dungeonCountCache[i][npcId] = {
              count = e.count,
              maxCountNormal = self.dungeonTotalCount[i].normal,
            }
            local cached = dungeonCountCache[i][npcId]
            return cached.count, cached.maxCountNormal
          end
        end
      end
    end
  end
end
