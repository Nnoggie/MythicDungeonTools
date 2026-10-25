local _, MDT = ...
local UI = MDT.UI

---Pure sidebar state. No frames, no db reads; scripts/test_kit.lua loads it with a stub MDT.
---@class MDT.SidebarModel
local Model = {}
MDT.SidebarModel = Model

local MAX_PORTRAITS = 7

---Everything Build needs, gathered by MDT:SidebarContext() in Sidebar.lua, the impure edge.
---@class MDT.SidebarContext
---@field enemies table<integer, table> enemies of the current dungeon
---@field totalForces integer
---@field level integer
---@field useForcesCount boolean
---@field showHealth boolean
---@field healthOf fun(enemy: table): number enemy health at the current level
---@field formatHealth fun(health: number): string
---@field pullColor fun(index: integer): number, number, number
---@field authorColor fun(createdBy: table?): MDT.UI.RGBA? class color of a route author
---@field player {name: string, realm: string}?
---@field presets table[] every preset of the current dungeon, including the <New Preset> entry
---@field presetIdx integer
---@field liveActive boolean
---@field livePresetUID string?
---@field inGroup boolean
---@field busy boolean a transmission is in progress

---@class MDT.SidebarPortrait
---@field enemyIdx integer
---@field cloneIdx integer the lowest of its clones in the pull, which the enemy card shows
---@field npcId integer
---@field displayId integer?
---@field quantity integer
---@field count integer forces per clone
---@field name string
---@field level integer?
---@field creatureType string?
---@field baseHealth number?
---@field ignoreFortified boolean?
---@field isBoss boolean

---@class MDT.SidebarPullItem : MDT.UI.ListItem
---@field index integer
---@field color MDT.UI.RGBA
---@field portraits MDT.SidebarPortrait[]
---@field isBoss boolean
---@field forces integer
---@field cumulative integer
---@field pullText string "+8.8%" or "+64", empty for a pull with no forces
---@field cumulativeText string "45.2%" or "329"
---@field healthText string? only with Show pull health on
---@field health number health of every enemy in the pull at the current level
---@field baseHealth number health of every enemy in the pull before level scaling, as efficiency scores use it
---@field completes boolean? the pull where the running total first reaches 100% (only when more pulls follow)

---@class MDT.SidebarHeader
---@field author string?
---@field authorColor MDT.UI.RGBA?
---@field route string
---@field isLiveRoute boolean
---@field level integer
---@field forces {current: integer, max: integer, text: string, tone: MDT.UI.ColorToken}
---@field actions {canDelete: boolean, canShare: boolean, canLive: boolean, shareBlocked: MDT.SidebarBlock?, liveBlocked: MDT.SidebarBlock?, liveActive: boolean, livePresetIdx: integer?, canSetLive: boolean, canReturnToLive: boolean}

---Why Share or Live is disabled: not in a group, a route is still being sent, or a live session already syncs changes.
---@alias MDT.SidebarBlock "noGroup"|"busy"|"live"

---@param value number
---@param total number
---@return string
function Model.FormatPercent(value, total)
  local percent = total > 0 and value / total * 100 or 0
  return string.format("%.1f%%", percent)
end

---The progress bar's old coloring rule: red only when over by more than 8 forces at 102% or more.
---@param current number
---@param max number
---@return MDT.UI.ColorToken
function Model.ForcesTone(current, max)
  local percent = max > 0 and current / max * 100 or 0
  if percent >= 102 and current - max > 8 then return "warn" end
  if percent >= 100 then return "ok" end
  return "text.normal"
end

---@param current number
---@param max number
---@return string
function Model.FormatForcesTotal(current, max)
  local percent = max > 0 and current / max * 100 or 0
  return string.format("%d/%d (%.2f%%)", current, max, percent)
end

---Groups the clones of one pull by (enemy, forces per clone), the way the old pull button did.
---@param pull table
---@param ctx MDT.SidebarContext
---@return integer forces, MDT.SidebarPortrait[] portraits, boolean isBoss, number health, number baseHealth
function Model.SummarizePull(pull, ctx)
  local forces, health, baseHealth, isBoss = 0, 0, 0, false
  local portraits, byKey = {}, {}
  for enemyIdx, clones in pairs(pull) do
    local enemy = tonumber(enemyIdx) and ctx.enemies[enemyIdx]
    if enemy then
      for _, cloneIdx in pairs(clones) do
        local clone = enemy.clones[cloneIdx]
        if clone then
          local count = clone.count or enemy.count
          forces = forces + count
          health = health + ctx.healthOf(enemy)
          baseHealth = baseHealth + (enemy.health or 0)
          isBoss = isBoss or enemy.isBoss == true
          local key = enemyIdx.."\1"..count
          local entry = byKey[key]
          if not entry then
            entry = {
              enemyIdx = enemyIdx, cloneIdx = cloneIdx, npcId = enemy.id, displayId = enemy.displayId, quantity = 0, count = count,
              name = enemy.name, level = enemy.level, creatureType = enemy.creatureType, baseHealth = enemy.health,
              ignoreFortified = enemy.ignoreFortified, isBoss = enemy.isBoss == true,
            }
            byKey[key] = entry
            portraits[#portraits + 1] = entry
          end
          entry.quantity = entry.quantity + 1
          entry.cloneIdx = math.min(entry.cloneIdx, cloneIdx)
        end
      end
    end
  end
  table.sort(portraits, function(a, b)
    if a.count ~= b.count then return a.count > b.count end
    return a.enemyIdx < b.enemyIdx
  end)
  for i = #portraits, MAX_PORTRAITS + 1, -1 do portraits[i] = nil end
  return forces, portraits, isBoss, health, baseHealth
end

---@class MDT.PullInterrupt
---@field spellId integer
---@field casters integer how many of the pull's enemies cast it

---@class MDT.PullCaster
---@field enemyIdx integer
---@field name string
---@field displayId integer?
---@field iconTexture (string|number)? a portrait some enemies have in place of a creature display
---@field count integer how many of the pull's enemies the entry stands for
---@field cloneIdx integer? the enemy's number, when the entry stands for one enemy that is not a boss
---@field spellIds integer[] its interruptible spells

---The pull's enemies that cast interruptible spells, as the pull card lists them: enemies of a kind with one such spell
---share an entry, an enemy with several gets an entry of its own. Entries standing for the most enemies come first.
---@param pull table
---@param enemies table<integer, table> enemies of the current dungeon
---@return MDT.PullCaster[]
function Model.PullCasters(pull, enemies)
  local casters = {}
  for enemyIdx, clones in pairs(pull) do
    local enemy = tonumber(enemyIdx) and enemies[enemyIdx]
    if enemy and enemy.spells then
      local cloneIdxs = {}
      for _, cloneIdx in pairs(clones) do
        if enemy.clones[cloneIdx] then cloneIdxs[#cloneIdxs + 1] = cloneIdx end
      end
      table.sort(cloneIdxs)
      local count = #cloneIdxs
      local spellIds = {}
      for spellId, spell in pairs(enemy.spells) do
        if spell.interruptible then spellIds[#spellIds + 1] = spellId end
      end
      table.sort(spellIds)
      local function entry(stands, cloneIdx)
        return {
          enemyIdx = enemyIdx, name = enemy.name, displayId = enemy.displayId, iconTexture = enemy.iconTexture,
          count = stands, cloneIdx = not enemy.isBoss and cloneIdx or nil, spellIds = spellIds,
        }
      end
      if count > 0 and #spellIds == 1 then
        casters[#casters + 1] = entry(count, count == 1 and cloneIdxs[1] or nil)
      elseif #spellIds > 1 then
        for _, cloneIdx in ipairs(cloneIdxs) do casters[#casters + 1] = entry(1, cloneIdx) end
      end
    end
  end
  table.sort(casters, function(a, b)
    if a.count ~= b.count then return a.count > b.count end
    if a.enemyIdx ~= b.enemyIdx then return a.enemyIdx < b.enemyIdx end
    return (a.cloneIdx or 0) < (b.cloneIdx or 0)
  end)
  return casters
end

---The interruptible spells a pull's enemies cast, each with how many of them cast it; the most cast first.
---@param pull table
---@param enemies table<integer, table> enemies of the current dungeon
---@return MDT.PullInterrupt[]
function Model.PullInterrupts(pull, enemies)
  local casters = {}
  for _, caster in ipairs(Model.PullCasters(pull, enemies)) do
    for _, spellId in ipairs(caster.spellIds) do casters[spellId] = (casters[spellId] or 0) + caster.count end
  end
  local list = {}
  for spellId, count in pairs(casters) do list[#list + 1] = { spellId = spellId, casters = count } end
  table.sort(list, function(a, b)
    if a.casters ~= b.casters then return a.casters > b.casters end
    return a.spellId < b.spellId
  end)
  return list
end

---Index of the live route in the current dungeon, or nil without a live session there.
---@param ctx MDT.SidebarContext
---@return integer?
function Model.LivePresetIdx(ctx)
  if not ctx.liveActive or not ctx.livePresetUID then return nil end
  for idx, preset in ipairs(ctx.presets) do
    if preset.uid == ctx.livePresetUID then return idx end
  end
end

---One item per pull with its forces, running total, health and portraits. The pull rows and the map's pull labels
---both show these.
---@param pulls table[]
---@param ctx MDT.SidebarContext
---@return MDT.SidebarPullItem[] items, integer cumulative forces of every pull
function Model.PullItems(pulls, ctx)
  local total = ctx.totalForces
  local items = {}
  local cumulative, completed = 0, false
  for index, pull in ipairs(pulls) do
    local forces, portraits, isBoss, health, baseHealth = Model.SummarizePull(pull, ctx)
    local previous = cumulative
    cumulative = cumulative + forces
    local r, g, b = ctx.pullColor(index)
    local pullText = ""
    if forces > 0 then
      pullText = "+"..(ctx.useForcesCount and tostring(forces) or Model.FormatPercent(forces, total))
    end
    local cumulativeText = ctx.useForcesCount and tostring(cumulative) or Model.FormatPercent(cumulative, total)
    local healthText = ctx.showHealth and health > 0 and ctx.formatHealth(health) or nil
    local completes = not completed and total > 0 and previous < total and cumulative >= total and index < #pulls
    if completes then completed = true end
    local sigParts = { index, UI.Color.ToHex({ r, g, b }), pullText, cumulativeText, healthText or "", isBoss and "B" or "", completes and "C" or "" }
    for _, portrait in ipairs(portraits) do sigParts[#sigParts + 1] = tostring(portrait.displayId).."x"..portrait.quantity end
    items[#items + 1] = {
      kind = "pull", key = index, sig = table.concat(sigParts, "|"),
      index = index, color = { r, g, b }, portraits = portraits, isBoss = isBoss,
      forces = forces, cumulative = cumulative, pullText = pullText, cumulativeText = cumulativeText, healthText = healthText,
      health = health, baseHealth = baseHealth, completes = completes,
    }
  end
  return items, cumulative
end

---@param preset table
---@param ctx MDT.SidebarContext
---@return {header: MDT.SidebarHeader, items: MDT.UI.ListItem[]}
function Model.Build(preset, ctx)
  local total = ctx.totalForces
  local pullItems, cumulative = Model.PullItems(preset.value.pulls, ctx)
  local items = pullItems --[[@as MDT.UI.ListItem[] ]]
  items[#items + 1] = { kind = "newPull", key = "new" }

  local isLiveRoute = ctx.liveActive and preset.uid ~= nil and preset.uid == ctx.livePresetUID
  local shareBlocked = ctx.liveActive and "live" or not ctx.inGroup and "noGroup" or ctx.busy and "busy" or nil
  local liveBlocked = not ctx.liveActive and (not ctx.inGroup and "noGroup" or ctx.busy and "busy") or nil
  local createdBy = type(preset.createdBy) == "table" and preset.createdBy or nil
  local header = {
    author = createdBy and createdBy.name or nil,
    authorColor = ctx.authorColor(createdBy),
    route = preset.text or "",
    isLiveRoute = isLiveRoute,
    level = ctx.level,
    forces = {
      current = cumulative, max = total, text = Model.FormatForcesTotal(cumulative, total),
      tone = Model.ForcesTone(cumulative, total),
    },
    actions = {
      canDelete = ctx.presetIdx ~= 1 and not ctx.liveActive,
      canShare = shareBlocked == nil,
      canLive = liveBlocked == nil,
      shareBlocked = shareBlocked,
      liveBlocked = liveBlocked,
      livePresetIdx = Model.LivePresetIdx(ctx),
      liveActive = ctx.liveActive,
      canSetLive = ctx.liveActive and not isLiveRoute,
      canReturnToLive = ctx.liveActive and not isLiveRoute,
    },
  }
  return { header = header, items = items }
end

---Moves the pulls with the given indices, in their current order, so the block starts at `slot` (insert-before, 1..n+1).
---Same result as the old pull button's drop for a single row and for a sorted multi-selection.
---@param pulls table[]
---@param indices integer[]
---@param slot integer
---@return table[] newPulls, integer[] newSelection, boolean changed
function Model.MovePulls(pulls, indices, slot)
  local order = {}
  for i = 1, #pulls do order[i] = i end
  local newOrder, changed = UI.ListMath.Reorder(order, indices, slot)
  local moving = {}
  for _, index in ipairs(indices) do moving[index] = true end
  local newPulls, newSelection = {}, {}
  for position, index in ipairs(newOrder) do
    newPulls[position] = pulls[index]
    if moving[index] then newSelection[#newSelection + 1] = position end
  end
  return newPulls, newSelection, changed
end

local function contains(list, value)
  for _, entry in ipairs(list) do
    if entry == value then return true end
  end
  return false
end

---Removes the selected pulls in ascending order and never the last remaining pull.
---Returns the index to select afterwards: the nearest unselected pull at or above the anchor, else below, else 1.
---@param pulls table[]
---@param selection integer[]
---@param anchor integer
---@return table[] remaining, integer nextPull
function Model.DeletePulls(pulls, selection, anchor)
  local keep
  for index = anchor, 1, -1 do
    if not contains(selection, index) then keep = index break end
  end
  if not keep then
    for index = anchor, #pulls do
      if not contains(selection, index) then keep = index break end
    end
  end
  local remaining, removedBelowKeep = {}, 0
  for index, pull in ipairs(pulls) do
    local lastOne = #remaining == 0 and index == #pulls
    if contains(selection, index) and not lastOne then
      if keep and index < keep then removedBelowKeep = removedBelowKeep + 1 end
    else
      remaining[#remaining + 1] = pull
    end
  end
  local nextPull = keep and (keep - removedBelowKeep) or 1
  return remaining, math.max(1, math.min(nextPull, #remaining))
end

---@class MDT.PullMenuContext
---@field index integer right-clicked pull
---@field maxPulls integer
---@field selection integer[]

---@class MDT.PullActions
---@field moveUp fun(index: integer)
---@field moveDown fun(index: integer)
---@field insertBefore fun(index: integer)
---@field insertAfter fun(index: integer)
---@field mergeUp fun(index: integer)
---@field mergeDown fun(index: integer)
---@field merge fun(selection: integer[], into: integer)
---@field clear fun(indices: integer[])
---@field resetPreset fun()
---@field delete fun(indices: integer[], anchor: integer)

---The single and multi pull context menus of the old pull button, as data. Items that do not apply are false, which MenuModel drops.
---@param ctx MDT.PullMenuContext
---@param actions MDT.PullActions
---@param L table
---@return MDT.UI.MenuItem[]
function Model.PullMenuItems(ctx, actions, L)
  local index, maxPulls = ctx.index, ctx.maxPulls
  local selection = ctx.selection
  if #selection > 1 then
    return {
      { text = L["Pull Drop Insert before"], onSelect = function() actions.insertBefore(index) end },
      { text = L["Pull Drop Insert after"], onSelect = function() actions.insertAfter(index) end },
      { text = L["Pull Drop Merge"], onSelect = function() actions.merge(selection, index) end },
      { kind = "separator" },
      { text = L["Pull Drop Clear Pulls"], onSelect = function() actions.clear(selection) end },
      { text = L["Pull Drop Reset Preset"], onSelect = actions.resetPreset },
      maxPulls > 1 and { text = L["Pull Drop Delete"], textColor = "warn", onSelect = function() actions.delete(selection, index) end } or false,
    }
  end
  local notFirst, notLast = index ~= 1, index < maxPulls
  return {
    notFirst and { text = L["Pull Drop Move up"], onSelect = function() actions.moveUp(index) end } or false,
    notLast and { text = L["Pull Drop Move down"], onSelect = function() actions.moveDown(index) end } or false,
    { text = L["Pull Drop Insert before"], onSelect = function() actions.insertBefore(index) end },
    { text = L["Pull Drop Insert after"], onSelect = function() actions.insertAfter(index) end },
    notFirst and { text = L["Pull Drop Merge up"], onSelect = function() actions.mergeUp(index) end } or false,
    notLast and { text = L["Pull Drop Merge down"], onSelect = function() actions.mergeDown(index) end } or false,
    { kind = "separator" },
    { text = L["Pull Drop Clear Pull"], onSelect = function() actions.clear({ index }) end },
    { text = L["Pull Drop Reset Preset"], onSelect = actions.resetPreset },
    maxPulls > 1 and { text = L["Pull Drop Delete"], textColor = "warn", onSelect = function() actions.delete({ index }, index) end } or false,
  }
end

---@class MDT.RouteActions
---@field new fun()
---@field duplicate fun()
---@field rename fun()
---@field import fun()
---@field export fun()
---@field share fun()
---@field toggleLive fun()
---@field setLive fun()
---@field returnToLive fun()
---@field delete fun()

---@class MDT.RouteEntry
---@field idx integer
---@field name string
---@field author string?
---@field authorColor MDT.UI.RGBA?
---@field level integer
---@field isCurrent boolean
---@field isLive boolean

---Whether `createdBy` names the player. Routes without an author are not anyone's.
---@param createdBy table?
---@param player {name: string, realm: string}?
---@return boolean
function Model.IsAuthoredBy(createdBy, player)
  return type(createdBy) == "table" and player ~= nil and createdBy.name == player.name and createdBy.realm == player.realm
end

---Routes of the current dungeon in three groups. The <New Preset> entry (value == 0) never appears.
---@param ctx MDT.SidebarContext
---@return {live: MDT.RouteEntry[], mine: MDT.RouteEntry[], others: MDT.RouteEntry[]}
function Model.RouteGroups(ctx)
  local groups = { live = {}, mine = {}, others = {} }
  local player = ctx.player
  for idx, preset in ipairs(ctx.presets) do
    if preset.value ~= 0 then
      local createdBy = type(preset.createdBy) == "table" and preset.createdBy or nil
      local entry = {
        idx = idx, name = preset.text or "", author = createdBy and createdBy.name or nil,
        authorColor = ctx.authorColor(createdBy), level = preset.difficulty or ctx.level,
        isCurrent = idx == ctx.presetIdx,
        isLive = ctx.liveActive and preset.uid ~= nil and preset.uid == ctx.livePresetUID,
      }
      local mine = not createdBy or Model.IsAuthoredBy(createdBy, player)
      local group = entry.isLive and groups.live or mine and groups.mine or groups.others
      group[#group + 1] = entry
    end
  end
  return groups
end

---@class MDT.SidebarRouteItem : MDT.UI.ListItem
---@field idx integer
---@field name string
---@field author string?
---@field authorColor MDT.UI.RGBA?
---@field isCurrent boolean
---@field isLive boolean

---One flat list: the live route, then your routes, then everyone else's. `query` matches name or author, case-insensitive.
---@param groups {live: MDT.RouteEntry[], mine: MDT.RouteEntry[], others: MDT.RouteEntry[]}
---@param query string?
---@return MDT.SidebarRouteItem[]
function Model.RouteListItems(groups, query)
  local needle = query and query:lower() or ""
  local items = {}
  for _, group in ipairs({ groups.live, groups.mine, groups.others }) do
    for _, entry in ipairs(group) do
      local haystack = (entry.name.." "..(entry.author or "")):lower()
      if needle == "" or haystack:find(needle, 1, true) then
        items[#items + 1] = {
          kind = "route", key = entry.idx,
          sig = table.concat({ entry.name, entry.author or "", tostring(entry.isCurrent), tostring(entry.isLive) }, "|"),
          idx = entry.idx, name = entry.name, author = entry.author, authorColor = entry.authorColor,
          isCurrent = entry.isCurrent, isLive = entry.isLive,
        }
      end
    end
  end
  return items
end
