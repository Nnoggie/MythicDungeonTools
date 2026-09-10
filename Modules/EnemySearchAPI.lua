local _, MDT = ...

local function validID(value)
  return not issecretvalue(value) and type(value) == "number" and value > 0 and value < math.huge and value == math.floor(value)
end

local function sortedIDs(source)
  local ids = {}
  for id in pairs(source or {}) do
    if validID(id) then ids[#ids + 1] = id end
  end
  table.sort(ids)
  return ids
end

local function firstClone(enemy)
  if type(enemy.clones) ~= "table" then return end
  if type(enemy.clones[1]) == "table" then return 1 end
  local first
  for id, clone in pairs(enemy.clones or {}) do
    if validID(id) and type(clone) == "table" and (not first or id < first) then first = id end
  end
  return first
end

-- Copies only searchable metadata, never the internal enemy/clone tables.
-- Callers control batching by advancing the iterator at their own pace.
function MDT:IterateEnemies(dungeonIndex)
  if issecretvalue(dungeonIndex) or (dungeonIndex ~= nil and not validID(dungeonIndex)) then return nil, "INVALID_ARGUMENT" end
  local dungeons = dungeonIndex and { dungeonIndex } or sortedIDs(self.dungeonEnemies)
  local dungeonPosition, enemyPosition = 0, 0
  local enemies, currentDungeon
  return function()
    while true do
      if not enemies or enemyPosition >= #enemies then
        dungeonPosition = dungeonPosition + 1
        currentDungeon = dungeons[dungeonPosition]
        if not currentDungeon then return end
        enemies = sortedIDs(self.dungeonEnemies[currentDungeon])
        enemyPosition = 0
      end
      enemyPosition = enemyPosition + 1
      local data = self.dungeonEnemies[currentDungeon]
      local enemy = data and data[enemies[enemyPosition]]
      if type(enemy) == "table" and validID(enemy.id) and type(enemy.name) == "string" and firstClone(enemy) then
        local spellIDs = {}
        local blacklist = self:GetEnemyInfoSpellBlacklist()
        local devMode = self:GetDB().devMode
        for spellID in pairs(enemy.spells or {}) do
          if validID(spellID) and (devMode or not blacklist[spellID]) then spellIDs[#spellIDs + 1] = spellID end
        end
        table.sort(spellIDs)
        return {
          dungeonIndex = currentDungeon,
          dungeonName = self:GetDungeonName(currentDungeon),
          npcID = enemy.id,
          name = self.L[enemy.name],
          englishName = enemy.name,
          isBoss = enemy.isBoss == true,
          spellIDs = spellIDs,
        }
      end
    end
  end
end

local function findEnemy(dungeonIndex, npcID)
  for enemyIndex, enemy in pairs(MDT.dungeonEnemies[dungeonIndex] or {}) do
    if type(enemy) == "table" and enemy.id == npcID then
      local cloneIndex = firstClone(enemy)
      if cloneIndex then return enemyIndex, cloneIndex end
    end
  end
end

local pending, waitingForFrames
local requestSerial = 0
local function finish(request, ok, reason)
  if request.finished then return end
  request.finished = true
  if pending == request then pending = nil end
  local callback = request.onComplete
  request.onComplete = nil
  if callback then xpcall(function() callback(ok, reason) end, geterrorhandler()) end
end

local function blocked()
  if InCombatLockdown() then return "COMBAT" end
  if MDT:IsInRestrictedEnvironment() then return "RESTRICTED" end
  if not MDT:IsCompatibleVersion() or MDT:CheckAddonConflicts() then return "UI_UNAVAILABLE" end
end

local function navigate(request)
  request.jobName = "openEnemyInfo"..request.serial
  MDT:Async(function()
    if pending ~= request then return end
    request.running = true
    local reason = blocked()
    if reason then finish(request, false, reason); return end
    local enemyIndex, cloneIndex = findEnemy(request.dungeonIndex, request.npcID)
    if not enemyIndex then finish(request, false, "NOT_FOUND"); return end
    MDT:ShowInterfaceInternal(true)
    if pending ~= request then return end
    MDT:SetCurrentSection("maps")
    MDT:SetDungeonList(nil, request.dungeonIndex)
    MDT:UpdateToDungeon(request.dungeonIndex)
    -- Map updates may yield. Check identity and restrictions again afterwards.
    if pending ~= request then return end
    reason = blocked()
    if reason then finish(request, false, reason); return end
    enemyIndex, cloneIndex = findEnemy(request.dungeonIndex, request.npcID)
    if not enemyIndex then finish(request, false, "NOT_FOUND"); return end
    MDT:UpdateDungeonDropDown()
    MDT:ShowEnemyInfoFrame({ enemyIdx = enemyIndex, cloneIdx = cloneIndex })
    local frame = MDT.EnemyInfoFrame and MDT.EnemyInfoFrame.frame
    if not frame or not frame:IsShown() then finish(request, false, "UI_UNAVAILABLE"); return end
    finish(request, true)
  end, request.jobName)
end

-- NPC IDs survive changes to the array order; no caller-supplied blip is used.
function MDT:OpenEnemyInfo(dungeonIndex, npcID, onComplete)
  if not validID(dungeonIndex) or not validID(npcID)
      or (onComplete ~= nil and type(onComplete) ~= "function") then return false, "INVALID_ARGUMENT" end
  local reason = blocked()
  if reason then return false, reason end
  if not findEnemy(dungeonIndex, npcID) then return false, "NOT_FOUND" end
  local previous = pending
  requestSerial = requestSerial + 1
  local request = { dungeonIndex = dungeonIndex, npcID = npcID, onComplete = onComplete, serial = requestSerial }
  pending = request
  if previous then
    if previous.jobName and not previous.running then self:CancelAsync(previous.jobName) end
    finish(previous, false, "SUPERSEDED")
  end
  -- A completion callback may itself request another enemy.
  if pending ~= request then return true end
  if self:AreFramesInitialized() then
    navigate(request)
  elseif not waitingForFrames then
    waitingForFrames = true
    self:RunAfterFramesInitialized(function()
      waitingForFrames = nil
      if pending then navigate(pending) end
    end)
    -- Never cancel the main-frame initialization coroutine on repeated clicks.
    self:ShowInterface(true)
  end
  return true
end
