---Tracks spells casted by enemies and adds them to the dataset
local db
local f
local MDT = MDT

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
        return DC[event](self,...)
    end)
    DC:AddCollectedDataToEnemyTable()

end

function DC:AddCollectedDataToEnemyTable()
    --add spells/characteristics from db to dungeonEnemies
    for i=29,36 do
        if db.dataCollection[i] then
            for id,spells in pairs(db.dataCollection[i]) do
                local enemies = MDT.dungeonEnemies[i]
                for enemyIdx,enemy in pairs(enemies) do
                    if enemy.id == id then
                        enemy.spells = enemy.spells or {}
                        for spellId,_ in pairs(spells) do
                            enemy.spells[spellId] = enemy.spells[spellId] or {}
                        end
                    end

                end
            end
        end
        if db.dataCollectionCC[i] then
            for id,characteristics in pairs(db.dataCollectionCC[i]) do
                local enemies = MDT.dungeonEnemies[i]
                for enemyIdx,enemy in pairs(enemies) do
                    if enemy.id == id then
                        enemy.characteristics = enemy.characteristics or {}
                        for characteristic,_ in pairs(characteristics) do
                            enemy.characteristics[characteristic] = true
                        end
                    end
                end
            end
        end
    end
end

local trackedEvents = {
    ["SPELL_CAST_SUCCESS"]=true,
    ["SPELL_CAST_START"]=true,
    ["SPELL_MISSED"]=true,
    ["SPELL_DAMAGE"]=true,
    ["SPELL_AURA_REMOVED"]=true,
    ["SPELL_AURA_APPLIED"]=true,
}
local characteristicsSpells = {
    ["Slow"] = {
        [3409] = true; --Crippling Poison
        [45524] = true; --Chains of Ice
    };
    ["Stun"] ={
        [1833] = true, --Cheap Shot
        [408] = true, --Kidney Shot
        [179057] = true, --Chaos Nova
        [119381] = true, --Leg Sweep
        [30283] = true, --Shadowfury
        [108194] = true, --Asphyxiate
    },
    ["Sap"] ={
        [6770] = true,
    },
    ["Imprison"] = {
        [217832] = true,
    },
    ["Incapacitate"] ={
        [1776] = true, --Gouge
        [115078] = true, --Paralysis
    },
    ["Repentance"] ={
        [20066] = true,
    },
    ["Disorient"] ={
        [2094] = true, --Blind
        [31661] = true, --Dragon's breath
    },
    ["Banish"] ={
        [710] = true, --Banish
    },
    ["Fear"] = {
        [118699] = true, --Fear
        [8122] = true, --Psychich Scream
        [5246] = true, --Intimidating Shout
        [207685] = true, --Sigil of Misery
    },
    ["Root"] = {
        [122] = true, --Frost Nova
        [339] = true, --Entangling Roots
        [102359] = true, --Mass Root
        [117526] = true, --Binding Shot
    },
    ["Polymorph"] ={
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
    },
    ["Shackle Undead"] ={
        [9484] = true,
    },
    ["Mind Control"] ={
        [605] = true,
        [205364] = true,
    },
    ["Grip"] = {},
    ["Knock"] ={},
    ["Silence"] ={
        [15487] = true, --Silence
        [204490] = true, --Sigil of Silence
    },
    ["Taunt"] ={
        [56222] = true, --Dark Command
        [355] = true, --Taunt
        [185245] = true, --Torment
        [116189] = true, --Provoke
    },
    ["Control Undead"] ={
        [111673] = true,
    },
    ["Subjugate Demon"] ={
        [1098] = true,
    },
}
local cmsTimeStamp
function DC.CHALLENGE_MODE_START(self,...)
    local _, timeCM = GetWorldElapsedTime(1)
    if timeCM>0 then return end
    cmsTimeStamp = GetTime()
end
function DC.CHALLENGE_MODE_COMPLETED(self,...)
    cmsTimeStamp = nil
end
function DC.PLAYER_ENTERING_WORLD(self,...)
    if C_ChallengeMode.IsChallengeModeActive() then return end
    cmsTimeStamp = nil
end

function DC.COMBAT_LOG_EVENT_UNFILTERED(self,...)
    local timestamp,subevent,hideCaster,sourceGUID,sourceName,sourceFlags,sourceRaidFlags,destGUID,destName,destFlags,destRaidFlags,spellId,spellName,spellSchool = CombatLogGetCurrentEventInfo()
    --enemy spells
    if trackedEvents[subevent] then
        local unitType,_,serverId,instanceId,zoneId,id,spawnUid = strsplit("-", sourceGUID)
        id = tonumber(id)
        --dungeon
        for i=29,36 do
            local enemies = MDT.dungeonEnemies[i]
            --enemy
            for enemyIdx,enemy in pairs(enemies) do
                if enemy.id == id then
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
    if subevent == "SPELL_AURA_APPLIED" then
        local unitType,_,serverId,instanceId,zoneId,id,spawnUid = strsplit("-", destGUID)
        id = tonumber(id)

        --dungeon
        for i=29,36 do
            local enemies = MDT.dungeonEnemies[i]
            --enemy
            for enemyIdx,enemy in pairs(enemies) do
                if enemy.id == id then
                    for characteristic,spells in pairs(characteristicsSpells) do
                        if spells[spellId] then
                            db.dataCollectionCC[i] = db.dataCollectionCC[i] or {}
                            db.dataCollectionCC[i][id] = db.dataCollectionCC[i][id] or {}
                            db.dataCollectionCC[i][id][characteristic] = true
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
    --temporary lag fix
    if true then return end
    local distribution = self:IsPlayerInGroup()
    if not distribution then return end
    MDTcommsObject:SendCommMessage(self.dataCollectionPrefixes.request, "0", distribution, nil, "ALERT")
end

---Distribute collected data to party/raid
function DC:DistributeData()
    --temporary lag fix
    if true then return end
    local distribution = MDT:IsPlayerInGroup()
    if not distribution then return end
    --throttle to 1 sync every 5 minutes
    if not DC.lastDistribution or DC.lastDistribution < GetTime() - 300 then
        DC.lastDistribution = GetTime()
        db = MDT:GetDB()
        local package = {
            [1] = db.dataCollection,
            [2] = db.dataCollectionCC
        }
        local export = MDT:TableToString(package,false,5)
        MDTcommsObject:SendCommMessage(MDT.dataCollectionPrefixes.distribute, export, distribution, nil, "BULK",nil,nil)
    end
end

---Merge received collected data into own data collection
function DC:MergeReceiveData(package)
    --temporary lag fix
    if true then return end
    db = MDT:GetDB()
    local collection,collectionCC = unpack(package)
    --db.dataCollection[dungeonIdx][npcId][spellId]
    for dungeonIdx,npcs in pairs(collection) do
        if not db.dataCollection[dungeonIdx] then
            db.dataCollection[dungeonIdx] = npcs
        else
            for npcId,spells in pairs(npcs) do
                if not db.dataCollection[dungeonIdx][npcId] then
                    db.dataCollection[dungeonIdx][npcId] = spells
                else
                    for spellId,tracked in pairs(spells) do
                        db.dataCollection[dungeonIdx][npcId][spellId] = true
                    end
                end
            end
        end
    end
    --db.dataCollectionCC[dungeonIdx][npcId][characteristic]
    for dungeonIdx,npcs in pairs(collectionCC) do
        if not db.dataCollectionCC[dungeonIdx] then
            db.dataCollectionCC[dungeonIdx] = npcs
        else
            for npcId,characteristics in pairs(npcs) do
                if not db.dataCollectionCC[dungeonIdx][npcId] then
                    db.dataCollectionCC[dungeonIdx][npcId] = characteristics
                else
                    for characteristic,tracked in pairs(characteristics) do
                        db.dataCollectionCC[dungeonIdx][npcId][characteristic] = true
                    end
                end
            end
        end
    end
    DC:AddCollectedDataToEnemyTable()
end

---HealthTrack
local enemiesToScale
function DC:InitHealthTrack()
    db = MDT:GetDB()
    local enemyCount = 0
    local totalEnemies = 0
    local changedEnemies = {}
    for _,enemy in pairs(MDT.dungeonEnemies[db.currentDungeonIdx]) do
        totalEnemies = totalEnemies + 1
    end
    f = CreateFrame("Frame")
    f:RegisterEvent("UPDATE_MOUSEOVER_UNIT")
    f:SetScript("OnEvent", function(self, event, ...)
        if event == "UPDATE_MOUSEOVER_UNIT" then
            local unit = "mouseover"
            local npcId
            local guid = UnitGUID(unit)
            if guid then
                npcId = select(6,strsplit("-", guid))
            end
            if npcId then
                local npcHealth = UnitHealthMax(unit)
                for enemyIdx,enemy in pairs(MDT.dungeonEnemies[db.currentDungeonIdx]) do
                    if enemy.id == tonumber(npcId) then
                        if enemy.health ~= npcHealth then
                            print(npcHealth/enemy.health)
                            enemy.health = npcHealth
                            enemyCount = enemyCount + 1
                            changedEnemies[enemyIdx] = true
                            local enemiesLeft = " "
                            enemiesToScale = {}
                            for k,v in pairs(MDT.dungeonEnemies[db.currentDungeonIdx]) do
                                if not changedEnemies[k] then
                                    enemiesLeft = enemiesLeft..v.name..", "
                                    enemiesToScale[k] = true
                                end
                            end
                            print(enemyCount.."/"..totalEnemies..enemiesLeft)
                        end
                        break
                    end
                end
            end
        end
    end)
end

--season 4
function MDT:FinishHPTrack()
    local multiplier = 1.526092251434
    local constantNpcs = {
        [155432]=15369884, --enchanted
        [155433]=999042,
        [155434]=614795,
        [161243]=2151786, --sam
        [161244]=2151786, --blood
        [161241]=2151786, --spider
        [161124]=2151786, --tank
    }
    for enemyIdx in pairs(enemiesToScale) do
        local enemy = MDT.dungeonEnemies[db.currentDungeonIdx][enemyIdx]
        if enemy.health>1 then
            local newHealth = constantNpcs[enemy.id] or math.floor(enemy.health*multiplier)
            enemy.health = newHealth
            print(enemy.name)
        end
    end
end
