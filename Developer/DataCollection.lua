---Track spells casted by enemies, susceptibility to crowd control and base health and add them to the dataset
local db
local f
local MDT = MDT

-- CHANGE HERE TO DEFINE WHICH DUNGEONS TO TRACK FOR DATA COLLECTION
local dungeonsToTrack = {
  [1] = 31,
  [2] = 35,
  [3] = 19,
  [4] = 110,
  [5] = 111,
  [6] = 112,
  [7] = 113,
  [8] = 114,
}

MDT.DataCollection = {}
local DC = MDT.DataCollection
function DC:Init()
  db = MDT:GetDB()
  db.dataCollection = db.dataCollection or {}
  db.dataCollectionCC = db.dataCollectionCC or {}
  db.dataCollectionGUID = db.dataCollectionGUID or {}
  f = CreateFrame("Frame")
  f:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
  f:RegisterEvent("CHALLENGE_MODE_START")
  f:RegisterEvent("CHALLENGE_MODE_COMPLETED")
  f:RegisterEvent("PLAYER_ENTERING_WORLD")
  f:SetScript("OnEvent", function(self, event, ...)
    return DC[event](self, ...)
  end)

  -- add already collected spells to the data
  for k, dungeonIndex in pairs(dungeonsToTrack) do
    DC:AddCollectedDataToEnemyTable(dungeonIndex)
  end
  MDT:CleanEnemyInfoSpells()
end

function DC:AddCollectedDataToEnemyTable(dungeonIndex, ignoreSpells, ignoreCC)
  db = MDT:GetDB()
  if not dungeonIndex then dungeonIndex = db.currentDungeonIdx end
  --add spells/characteristics from db to dungeonEnemies
  local spellsAdded = 0
  local ccAdded = 0
  local enemies = MDT.dungeonEnemies[dungeonIndex]
  local collectedData = db.dataCollection[dungeonIndex]
  if collectedData and not ignoreSpells then
    for id, spells in pairs(collectedData) do
      for enemyIdx, enemy in pairs(enemies) do
        if enemy.id == id then
          enemy.spells = enemy.spells or {}
          for spellId, _ in pairs(spells) do
            if not enemy.spells[spellId] then
              spellsAdded = spellsAdded + 1
            end
            enemy.spells[spellId] = enemy.spells[spellId] or {}
          end
        end
      end
    end
  end
  local collectedCC = db.dataCollectionCC[dungeonIndex]
  if collectedCC and not ignoreCC then
    for id, characteristics in pairs(collectedCC) do
      for enemyIdx, enemy in pairs(enemies) do
        if enemy.id == id then
          enemy.characteristics = enemy.characteristics or {}
          for characteristic, _ in pairs(characteristics) do
            if not enemy.characteristics[characteristic] then
              ccAdded = ccAdded + 1
            end
            enemy.characteristics[characteristic] = true
          end
        end
      end
    end
  end

  if not ignoreSpells then print("Added "..spellsAdded.." new spells") end
  if not ignoreCC then print("Added "..ccAdded.." new CC characteristics") end
end

local trackedEvents = {
  ["SPELL_CAST_SUCCESS"] = true,
  ["SPELL_CAST_START"] = true,
  ["SPELL_MISSED"] = true,
  ["SPELL_DAMAGE"] = true,
  ["SPELL_AURA_REMOVED"] = true,
  ["SPELL_AURA_APPLIED"] = true,
}

local characteristicsData = {
  ["Slow"] = {
    ["spells"] = {
      [3409] = true,   --Crippling Poison
      [45524] = true,  --Chains of Ice
      [273977] = true, --Grip of the Dead
      [317898] = true, --Blinding Sleet (Slow)
      [6343] = true,   --Thunderclap
    }
  },
  ["Stun"] = {
    ["spells"] = {
      [1833] = true,   --Cheap Shot
      [408] = true,    --Kidney Shot
      [179057] = true, --Chaos Nova
      [119381] = true, --Leg Sweep
      [30283] = true,  --Shadowfury
      [221562] = true, --Asphyxiate
      [132168] = true, --Shockwave
    }
  },
  ["Sap"] = {
    ["creatureTypes"] = {
      ["Humanoid"] = true,
      ["Beast"] = true,
      ["Demon"] = true,
      ["Dragonkin"] = true,
    },
    ["spells"] = {
      [6770] = true,
    }
  },
  ["Imprison"] = {
    ["creatureTypes"] = {
      ["Humanoid"] = true,
      ["Beast"] = true,
      ["Demon"] = true,
    },
    ["spells"] = {
      [217832] = true,
    }
  },
  ["Incapacitate"] = {
    ["spells"] = {
      [1776] = true,   --Gouge
      [115078] = true, --Paralysis
      [3355] = true,   --Freezing Trap
      [99] = true,     --Incapacitating Roar
    }
  },
  ["Repentance"] = {
    ["creatureTypes"] = {
      ["Humanoid"] = true,
      ["Demon"] = true,
      ["Undead"] = true,
      ["Dragonkin"] = true,
      ["Giant"] = true,
    },
    ["spells"] = {
      [20066] = true,
    }
  },
  ["Disorient"] = {
    ["spells"] = {
      [2094] = true,   --Blind
      [31661] = true,  --Dragon's breath
      [207167] = true, --Blinding Sleet
      [105421] = true, --Blinding Light
      [33786] = true,  --Cyclone
    }
  },
  ["Banish"] = {
    ["creatureTypes"] = {
      ["Demon"] = true,
      ["Aberration"] = true,
      ["Elemental"] = true,
      ["Undead"] = true, -- with talent
    },
    ["spells"] = {
      [710] = true, --Banish
    }
  },
  ["Fear"] = {
    ["spells"] = {
      [118699] = true, --Fear
      [8122] = true,   --Psychich Scream
      [5246] = true,   --Intimidating Shout
      [316593] = true, --Intimidating Shout (Menace)
      [207685] = true, --Sigil of Misery
      [5484] = true,   --Howl of Terror
    }
  },
  ["Root"] = {
    ["spells"] = {
      [122] = true,    --Frost Nova
      [339] = true,    --Entangling Roots
      [102359] = true, --Mass Entanglement
      [355689] = true, --Landslide
    }
  },
  ["Polymorph"] = {
    ["creatureTypes"] = {
      ["Beast"] = true,
      ["Humanoid"] = true,
      ["Critter"] = true,
    },
    ["spells"] = {
      [161354] = true,
      [126819] = true,
      [61780] = true,
      [118] = true,
      [277787] = true,
      [277792] = true,
      [161355] = true,
      [161372] = true,
      [61721] = true,
      [61305] = true,
      [28271] = true,
      [28272] = true,
      [33786] = true,
      [20066] = true,
      [5782] = true,
      [51514] = true,
      [277778] = true,
      [277784] = true,
      [269352] = true,
      [211004] = true,
      [211010] = true,
      [211015] = true,
      [210873] = true,
      [383121] = true,
    }
  },
  ["Shackle Undead"] = {
    ["creatureTypes"] = {
      ["Undead"] = true,
    },
    ["spells"] = {
      [9484] = true,
    }
  },
  ["Mind Control"] = {
    ["creatureTypes"] = {
      ["Abberation"] = true,
      ["Beast"] = true,
      ["Critter"] = true,
      ["Dragonkin"] = true,
      ["Elemental"] = true,
      ["Giant"] = true,
      ["Humanoid"] = true,
    },
    ["spells"] = {
      [605] = true,
      [205364] = true,
    }
  },
  ["Grip"] = {
    ["displacement"] = true,
  },
  ["Knock"] = {
    ["displacement"] = true,
  },
  ["Silence"] = {
    ["spells"] = {
      [15487] = true,  --Silence
      [204490] = true, --Sigil of Silence
      [81261] = true,  --Solar Beam
    }
  },
  ["Taunt"] = {
    ["global"] = true,
    ["spells"] = {
      [56222] = true,  --Dark Command
      [355] = true,    --Taunt
      [185245] = true, --Torment
      [116189] = true, --Provoke
      [6795] = true,   --Growl
    }
  },
  ["Control Undead"] = {
    ["creatureTypes"] = {
      ["Undead"] = true,
    },
    ["spells"] = {
      [111673] = true,
    }
  },
  ["Subjugate Demon"] = {
    ["creatureTypes"] = {
      ["Demon"] = true,
    },
    ["spells"] = {
      [1098] = true,
    }
  },
  ["Sleep Walk"] = {
    ["spells"] = {
      [360806] = true,
    }
  },
  ["Scare Beast"] = {
    ["creatureTypes"] = {
      ["Beast"] = true,
    },
    ["spells"] = {
      [1513] = true,
    }
  },
  ["Hibernate"] = {
    ["creatureTypes"] = {
      ["Beast"] = true,
      ["Dragonkin"] = true,
    },
    ["spells"] = {
      [2637] = true,
    }
  },
  ["Turn Evil"] = {
    ["creatureTypes"] = {
      ["Undead"] = true,
      ["Abberation"] = true,
      ["Demon"] = true,
    },
    ["spells"] = {
      [10326] = true,
    }
  },
  ["Mind Soothe"] = {
    ["creatureTypes"] = {
      ["Humanoid"] = true,
      ["Dragonkin"] = true,
    },
    ["spells"] = {
      [453] = true,
    }
  },
}
local cmsTimeStamp
function DC.CHALLENGE_MODE_START(self, ...)
  local _, timeCM = GetWorldElapsedTime(1)
  if timeCM > 0 then return end
  cmsTimeStamp = GetTime()
end

function DC.CHALLENGE_MODE_COMPLETED(self, ...)
  cmsTimeStamp = nil
end

function DC.PLAYER_ENTERING_WORLD(self, ...)
  if C_ChallengeMode.IsChallengeModeActive() then return end
  cmsTimeStamp = nil
end

function DC.COMBAT_LOG_EVENT_UNFILTERED(self, ...)
  local timestamp, subevent, hideCaster, sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags, spellId, spellName, spellSchool = CombatLogGetCurrentEventInfo()
  --enemy spells
  if trackedEvents[subevent] and sourceGUID then
    local unitType, _, serverId, instanceId, zoneId, id, spawnUid = strsplit("-", sourceGUID)
    id = tonumber(id)
    --dungeon
    for _, i in pairs(dungeonsToTrack) do
      local enemies = MDT.dungeonEnemies[i]
      --enemy
      for enemyIdx, enemy in pairs(enemies) do
        if id and spellId and enemy.id == id then
          db.dataCollection[i] = db.dataCollection[i] or {}
          db.dataCollection[i][id] = db.dataCollection[i][id] or {}
          db.dataCollection[i][id][spellId] = {}
          enemy.spells = enemy.spells or {}
          enemy.spells[spellId] = enemy.spells[spellId] or {}
          break
        end
      end
    end
  end
  --characteristics
  if subevent == "SPELL_AURA_APPLIED" and destGUID then
    local unitType, _, serverId, instanceId, zoneId, id, spawnUid = strsplit("-", destGUID)
    id = tonumber(id) or 0

    --dungeon
    for _, i in pairs(dungeonsToTrack) do
      local enemies = MDT.dungeonEnemies[i]
      --enemy
      for enemyIdx, enemy in pairs(enemies) do
        if enemy.id == id then
          for characteristic, data in pairs(characteristicsData) do
            local spells = data.spells
            if spells and spells[spellId] then
              -- return early if already present
              db.dataCollectionCC[i] = db.dataCollectionCC[i] or {}
              db.dataCollectionCC[i][id] = db.dataCollectionCC[i][id] or {}
              db.dataCollectionCC[i][id][characteristic] = true
              if enemy.characteristics and enemy.characteristics[characteristic] then return end
              enemy.characteristics = enemy.characteristics or {}
              enemy.characteristics[characteristic] = true
            end
          end
          break
        end
      end
    end
  end
end

---Request users in party/raid to distribute their collected data
function MDT:RequestDataCollectionUpdate()
  print("MDT: Requesting collected data from group members...")
  local distribution = self:IsPlayerInGroup()
  if not distribution then return end
  MDTcommsObject:SendCommMessage(self.dataCollectionPrefixes.request, "0", distribution, nil, "ALERT")
end

---Distribute collected data to party/raid
function DC:DistributeData()
  local distribution = MDT:IsPlayerInGroup()
  if not distribution then return end
  db = MDT:GetDB()
  local package = {
    [1] = db.dataCollection,
    [2] = db.dataCollectionCC
  }
  local export = MDT:TableToString(package, false, 5)
  MDTcommsObject:SendCommMessage(MDT.dataCollectionPrefixes.distribute, export, distribution, nil, "BULK", nil, nil)
end

---Merge received collected data into own data collection
function DC:MergeReceiveData(package)
  print("MDT: Merging received collected data")
  db = MDT:GetDB()
  local collection, collectionCC = unpack(package)
  --db.dataCollection[dungeonIdx][npcId][spellId]
  for dungeonIdx, npcs in pairs(collection) do
    if not db.dataCollection[dungeonIdx] then
      db.dataCollection[dungeonIdx] = npcs
    else
      for npcId, spells in pairs(npcs) do
        if not db.dataCollection[dungeonIdx][npcId] then
          db.dataCollection[dungeonIdx][npcId] = spells
        else
          for spellId, tracked in pairs(spells) do
            db.dataCollection[dungeonIdx][npcId][spellId] = true
          end
        end
      end
    end
  end
  --db.dataCollectionCC[dungeonIdx][npcId][characteristic]
  for dungeonIdx, npcs in pairs(collectionCC) do
    if not db.dataCollectionCC[dungeonIdx] then
      db.dataCollectionCC[dungeonIdx] = npcs
    else
      for npcId, characteristics in pairs(npcs) do
        if not db.dataCollectionCC[dungeonIdx][npcId] then
          db.dataCollectionCC[dungeonIdx][npcId] = characteristics
        else
          for characteristic, tracked in pairs(characteristics) do
            db.dataCollectionCC[dungeonIdx][npcId][characteristic] = true
          end
        end
      end
    end
  end
  DC:AddCollectedDataToEnemyTable()
  MDT:CleanEnemyInfoSpells()
end

function MDT:CleanEnemyInfoSpells()
  local blacklist = MDT:GetEnemyInfoSpellBlacklist()
  for i = 1, 200 do
    local enemies = MDT.dungeonEnemies[i]
    if enemies then
      for enemyIdx, enemy in pairs(enemies) do
        if enemy.spells then
          for spellId, spell in pairs(enemy.spells) do
            if blacklist[spellId] then
              enemy.spells[spellId] = nil
            end
          end
        end
      end
    end
  end
  if MDT.EnemyInfoFrame then MDT.EnemyInfoFrame:Hide() end
end

function DC:InitHealthTrack()
  db = MDT:GetDB()
  if not db.healthTrackVersion or db.healthTrackVersion < 2 then
    db.healthTrackVersion = 2
    db.healthTracking = {}
  end
  db.healthTracking = db.healthTracking or {}
  local healthTrackingFrame = CreateFrame("Frame")
  healthTrackingFrame:RegisterEvent("UPDATE_MOUSEOVER_UNIT")
  healthTrackingFrame:RegisterEvent("NAME_PLATE_UNIT_ADDED")
  healthTrackingFrame:SetScript("OnEvent", function(_, event, ...)
    --check difficulty if challenge mode and m+ level
    local difficultyID = GetDungeonDifficultyID()
    local isChallenge = difficultyID and C_ChallengeMode.IsChallengeModeActive()
    local level, activeAffixIDs = C_ChallengeMode.GetActiveKeystoneInfo()
    local fortified
    local tyrannical
    local thundering
    for k, v in pairs(activeAffixIDs) do
      if v == 10 then
        fortified = true
      end
      if v == 132 then
        thundering = true
      end
      if v == 9 then
        tyrannical = true
      end
    end
    level = isChallenge and level or -1
    if level > -1 then
      local unit
      if event == "UPDATE_MOUSEOVER_UNIT" then
        unit = "mouseover"
      elseif event == "NAME_PLATE_UNIT_ADDED" then
        unit = ...
      end
      if unit then
        local guid = UnitGUID(unit)
        local npcId
        if guid then
          npcId = select(6, strsplit("-", guid))
        end
        if npcId then
          db.healthTracking[tonumber(npcId)] = {
            ["health"] = UnitHealthMax(unit),
            ["name"] = UnitName(unit),
            ["level"] = level,
            ["fortified"] = fortified,
            ["thundering"] = thundering,
            ["tyrannical"] = tyrannical
          }
        end
      end
    end
  end)

  function MDT:ProcessHealthTrack()
    local enemies = MDT.dungeonEnemies[db.currentDungeonIdx]
    if enemies then
      local numEnemyHealthChanged = 0
      for enemyIdx, enemy in pairs(enemies) do
        local tracked = db.healthTracking[enemy.id]
        if tracked then
          local isBoss = enemy.isBoss and true or false
          local baseHealth = MDT:ReverseCalcEnemyHealth(tracked.health, tracked.level, isBoss, tracked.fortified,
            tracked.tyrannical,
            tracked.thundering)
          if baseHealth ~= enemy.health then
            numEnemyHealthChanged = numEnemyHealthChanged + 1
          end
          enemy.health = baseHealth
        else
          print("MDT HPTRACK: Missing: "..enemy.name.." id: "..enemy.id)
        end
      end
      print("MDT HPTRACK: Processed "..numEnemyHealthChanged.." enemies")
    end
  end
end

do
  function MDT:CompleteCharacteristics()
    local dungeonIdx = MDT:GetDB().currentDungeonIdx

    local function handleEnemy(enemy)
      enemy.characteristics = enemy.characteristics or {}
      enemy.characteristics["Taunt"] = true
      if enemy.creatureType == "Humanoid" or enemy.creatureType == "Dragonkin" then
        enemy.characteristics["Mind Soothe"] = true
      end
      for characteristic, _ in pairs(enemy.characteristics) do
        if characteristic ~= "Taunt" and characteristic ~= "Mind Soothe" then
          -- add all apropriate characteristics
          for ch, chdata in pairs(characteristicsData) do
            if chdata["creatureTypes"] then
              if chdata["creatureTypes"][enemy.creatureType] then
                enemy.characteristics[ch] = true
              end
            else
              enemy.characteristics[ch] = true
            end
          end
          return
        end
      end
    end

    local enemies = MDT.dungeonEnemies[dungeonIdx]
    for enemyIdx, enemy in pairs(enemies) do
      handleEnemy(enemy)
    end
  end
end
