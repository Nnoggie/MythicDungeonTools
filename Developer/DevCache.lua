local _, MDT = ...

local function copy(value)
  return type(value) == "table" and CopyTable(value) or value
end

local function equal(a, b)
  if type(a) ~= "table" or type(b) ~= "table" then return a == b end
  for key, value in pairs(a) do if not equal(value, b[key]) then return false end end
  for key in pairs(b) do if a[key] == nil then return false end end
  return true
end

local function schemaCopy(value, schema)
  -- Compare coordinates at the same precision that Export to LUA writes.
  if type(value) == "number" then return tonumber(tostring(value)) end
  if type(value) ~= "table" then return value end
  local result = {}
  if schema.type == "schemaArray" then
    for _, field in ipairs(schema.fields) do
      if value[field.name] then result[field.name] = schemaCopy(value[field.name], field) end
    end
  else
    for key, item in pairs(value) do result[key] = schemaCopy(item, schema.fields) end
  end
  return result
end

function MDT:SnapshotDevCacheDungeon(index)
  return {
    enemies = schemaCopy(MDT.dungeonEnemies[index] or {}, MDT:GetSchema("enemies")),
    pois = schemaCopy(MDT.mapPOIs[index] or {}, MDT:GetSchema("pois")),
  }
end

local function diff(before, after, path, edits, id, enemyIndex, atomic)
  if equal(before, after) then return end
  if type(before) == "table" and type(after) == "table" and not atomic and path[#path] ~= "patrol" then
    local keys = {}
    for key in pairs(before) do keys[key] = true end
    for key in pairs(after) do keys[key] = true end
    for key in pairs(keys) do
      local child = CopyTable(path)
      child[#child + 1] = key
      diff(before[key], after[key], child, edits, id, enemyIndex)
    end
  else
    edits[#edits + 1] = { id = id, enemyIndex = enemyIndex, path = CopyTable(path), before = copy(before), after = copy(after) }
  end
end

function MDT:BuildDevCacheEdits(before, after)
  local edits = { enemies = {}, pois = {} }
  local counts, duplicate = {}, {}
  for _, data in ipairs({ before.enemies, after.enemies }) do
    wipe(counts)
    for _, enemy in ipairs(data) do
      counts[enemy.id] = (counts[enemy.id] or 0) + 1
      if counts[enemy.id] > 1 then duplicate[enemy.id] = true end
    end
  end
  local function indexEnemies(enemies)
    local result = {}
    for index, enemy in ipairs(enemies) do
      if next(enemy.clones) then
        local key = duplicate[enemy.id] and (enemy.id..":"..index) or enemy.id
        result[key] = { enemy = enemy, index = index }
      end
    end
    return result
  end
  local old, new = indexEnemies(before.enemies), indexEnemies(after.enemies)
  local keys = {}
  for key in pairs(old) do keys[key] = true end
  for key in pairs(new) do keys[key] = true end
  for key in pairs(keys) do
    local entry = new[key] or old[key]
    diff(old[key] and old[key].enemy, new[key] and new[key].enemy, {}, edits.enemies,
      entry.enemy.id, entry.index, duplicate[entry.enemy.id])
  end
  -- POI floor lists have positional indices: concurrent changes to the same list
  -- require resolution. Only changed floors (and changed patrols) are stored whole.
  keys = {}
  for floor in pairs(before.pois) do keys[floor] = true end
  for floor in pairs(after.pois) do keys[floor] = true end
  for floor in pairs(keys) do diff(before.pois[floor], after.pois[floor], { floor }, edits.pois, nil, nil, true) end
  table.sort(edits.enemies, function(a, b) return a.enemyIndex < b.enemyIndex end)
  return (#edits.enemies > 0 or #edits.pois > 0) and edits or nil
end

local function applyValue(root, edit)
  local parent = root
  for i = 1, #edit.path - 1 do
    local key = edit.path[i]
    if parent[key] == nil then
      if edit.after == nil then return true end
      if edit.before ~= nil then return false end
      parent[key] = {}
    end
    if type(parent[key]) ~= "table" then return false end
    parent = parent[key]
  end
  local key = edit.path[#edit.path]
  if equal(parent[key], edit.after) then return true end
  if not equal(parent[key], edit.before) then return false end
  parent[key] = copy(edit.after)
  return true
end

function MDT:ApplyDevCacheEdits(data, edits)
  local result = CopyTable(data)
  for _, edit in ipairs(edits.enemies or {}) do
    local matches = {}
    for index, enemy in ipairs(result.enemies) do
      if enemy.id == edit.id and next(enemy.clones) then matches[#matches + 1] = index end
    end
    local index = matches[1]
    if #matches > 1 then
      index = nil
      -- Duplicate NPC IDs require a whole-record match, never a field-level guess.
      if #edit.path == 0 then
        local expected = edit.before
        for attempt = 1, 2 do
          for _, candidate in ipairs(matches) do
            if equal(result.enemies[candidate], expected) then
              if index then return nil, "ambiguous NPC "..edit.id end
              index = candidate
            end
          end
          if index then break end
          expected = edit.after -- The edit may already be present in source.
        end
      end
      if not index then return nil, "ambiguous NPC "..edit.id end
    end
    if #edit.path == 0 then
      local current = index and result.enemies[index]
      if not equal(current, edit.after) then
        if not equal(current, edit.before) then return nil, "NPC "..edit.id end
        if not edit.after then
          result.enemies[index].clones = {}
        elseif index then
          result.enemies[index] = CopyTable(edit.after)
        else
          result.enemies[#result.enemies + 1] = CopyTable(edit.after)
        end
      end
    elseif index then
      if not applyValue(result.enemies[index], edit) then return nil, "NPC "..edit.id.." / "..table.concat(edit.path, "/") end
    elseif edit.after ~= nil then
      return nil, "missing NPC "..edit.id
    end
  end
  for _, edit in ipairs(edits.pois or {}) do
    if not applyValue(result.pois, edit) then return nil, "POI floor "..tostring(edit.path[1]) end
  end
  return result
end

-- Internal calls must propagate errors: MDT's public error wrappers return nil,
-- which would otherwise look like an unchanged dungeon and erase saved edits.
local snapshotDungeon = MDT.SnapshotDevCacheDungeon
local buildEdits = MDT.BuildDevCacheEdits
local applyEdits = MDT.ApplyDevCacheEdits
local sourceData, activeCache, blocked

function MDT:SaveDevModeCache()
  local db = MDT:GetDB()
  if not sourceData or blocked or not db.loadCache or db.devModeCache ~= activeCache then return end
  local dungeons = CopyTable(activeCache.dungeons)
  for index, original in pairs(sourceData) do
    dungeons[index] = buildEdits(MDT, original, snapshotDungeon(MDT, index))
  end
  activeCache.dungeons = dungeons
end

function MDT:InitializeDevModeCache()
  local db = MDT:GetDB()
  if not db.devMode then return true end
  if sourceData then
    if blocked then db.devMode = false end
    return not blocked
  end
  local originals = {}
  for index in pairs(MDT.dungeonEnemies) do originals[index] = snapshotDungeon(MDT, index) end
  for index in pairs(MDT.mapPOIs) do originals[index] = originals[index] or snapshotDungeon(MDT, index) end
  sourceData = originals
  -- Start fresh: old full snapshots are discarded, never migrated or replayed.
  db.dungeonEnemies, db.mapPOIs, db.devModeCacheBaseline = nil, nil, nil
  if not db.loadCache then return true end
  activeCache = db.devModeCache or { version = 1, dungeons = {} }
  db.devModeCache = activeCache
  local pending, problem = {}
  if type(activeCache) ~= "table" or activeCache.version ~= 1 or type(activeCache.dungeons) ~= "table" then
    problem = "unsupported cache format"
  else
    for index, edits in pairs(activeCache.dungeons) do
      if sourceData[index] then
        local ok, data, reason = pcall(applyEdits, MDT, sourceData[index], edits)
        if not ok or not data then
          problem = "dungeon "..index..", "..tostring(ok and reason or data)
          break
        end
        pending[index] = data
      end
    end
  end
  if problem then
    blocked, db.devMode = true, false
    print("MDT dev cache conflict: "..problem..". Saved edits were kept; dev mode is disabled until the conflict is resolved or the cache is cleared.")
    return false
  end
  for index, data in pairs(pending) do
    MDT.dungeonEnemies[index] = data.enemies
    MDT.mapPOIs[index] = data.pois
  end
  MDT:SaveDevModeCache()
  return true
end

function MDT:SetDevModeCacheEnabled(enabled)
  local db = MDT:GetDB()
  if not MDT:InitializeDevModeCache() then return end
  if enabled then
    activeCache = db.devModeCache or { version = 1, dungeons = {} }
    if type(activeCache) ~= "table" or activeCache.version ~= 1 or type(activeCache.dungeons) ~= "table" then
      print("MDT dev cache: unsupported cache format. Saved edits were kept; clear the cache before enabling it.")
      return
    end
    db.devModeCache = activeCache
  end
  db.loadCache = enabled or nil
  if enabled then MDT:SaveDevModeCache() end
end

local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_LOGOUT")
frame:SetScript("OnEvent", function() MDT:SaveDevModeCache() end)
