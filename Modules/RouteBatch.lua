local _, MDT = ...
local L = MDT.L
local UI = MDT.UI

-- One string can carry many routes: { routeBatch = BATCH_VERSION, routes = { route, ... } }.
-- Older MDT versions read it as an invalid route, since the wrapper has no text or value.
local BATCH_VERSION = 1
local INDENT = 22
local LIST_HEIGHT = 280
local DUNGEON_ICON_SIZE = 16
-- Inline texture coordinates are in pixels of a stated size; only their ratio matters.
local ZOOMED_MARKUP = {}
for index, coord in ipairs(UI.Icon.ZOOMED_COORDS) do ZOOMED_MARKUP[index] = math.floor(coord * 1000 + 0.5) end

---The dungeon's name after its icon, zoomed like MDT's dungeon buttons.
local function dungeonTitle(dungeonIdx, name)
  local z = ZOOMED_MARKUP
  return ("|T%s:%d:%d:0:0:1000:1000:%d:%d:%d:%d|t %s"):format(MDT:GetDungeonIcon(dungeonIdx), DUNGEON_ICON_SIZE,
    DUNGEON_ICON_SIZE, z[1], z[2], z[3], z[4], name)
end

local db

local function initializeDB()
  db = db or MDT:GetDB()
end

-- The routes picked for a batch export stay picked until the next reload, also across seasons.
local batchSelection = setmetatable({}, { __mode = "k" })

---A route worth sharing has an enemy in a pull or something drawn on the map.
local function hasContent(preset)
  if type(preset) ~= "table" or type(preset.value) ~= "table" or type(preset.value.pulls) ~= "table" then return false end
  for _, pull in pairs(preset.value.pulls) do
    for enemyIdx, clones in pairs(pull) do
      if type(enemyIdx) == "number" and type(clones) == "table" and next(clones) then return true end
    end
  end
  return type(preset.objects) == "table" and next(preset.objects) ~= nil
end

local function isListedDungeon(dungeonIdx)
  local name = MDT.dungeonList[dungeonIdx]
  return type(name) == "string" and not name:find(">", 1, true)
end

---Dungeons of the newest season first, then older seasons, then dungeons in no season.
local function dungeonOrder()
  local order, seen = {}, {}
  for _, dungeons in ipairs(MDT.dungeonSelectionToIndex) do
    for _, dungeonIdx in ipairs(dungeons) do
      if not seen[dungeonIdx] and isListedDungeon(dungeonIdx) then
        seen[dungeonIdx] = true
        order[#order + 1] = dungeonIdx
      end
    end
  end
  local rest = {}
  for dungeonIdx in pairs(MDT.dungeonList) do
    if type(dungeonIdx) == "number" and not seen[dungeonIdx] and isListedDungeon(dungeonIdx) then rest[#rest + 1] = dungeonIdx end
  end
  table.sort(rest, function(a, b) return a > b end)
  for _, dungeonIdx in ipairs(rest) do order[#order + 1] = dungeonIdx end
  return order
end

local function findByUID(presets, uid)
  if not uid or type(presets) ~= "table" then return end
  for index, preset in ipairs(presets) do
    if preset.uid == uid then return index, preset end
  end
end

local function uniqueName(presets, name)
  local taken = {}
  for _, preset in ipairs(presets) do taken[preset.text] = true end
  if not taken[name] then return name end
  local number = 2
  while taken[name.." "..number] do number = number + 1 end
  return name.." "..number
end

---@class MDT.RouteGroup
---@field dungeonIdx integer
---@field name string
---@field routes table[] presets in the order of the route list

---The dungeons of the season selected in MDT's title bar, as a set.
local function currentSeasonDungeons()
  local set = {}
  for _, dungeonIdx in ipairs(MDT.dungeonSelectionToIndex[db.selectedDungeonList] or {}) do set[dungeonIdx] = true end
  return set
end

---The player's routes that pass `include`, grouped by dungeon, newest season first.
---@param currentSeason boolean? only dungeons of the season selected in MDT
---@param include fun(preset: table, index: integer): boolean
---@return MDT.RouteGroup[]
local function routeGroups(currentSeason, include)
  initializeDB()
  local groups = {}
  local season = currentSeason and currentSeasonDungeons()
  for _, dungeonIdx in ipairs(dungeonOrder()) do
    local routes = {}
    if not season or season[dungeonIdx] then
      for index, preset in ipairs(db.presets[dungeonIdx] or {}) do
        if include(preset, index) then routes[#routes + 1] = preset end
      end
    end
    if #routes > 0 then
      groups[#groups + 1] = { dungeonIdx = dungeonIdx, name = MDT:GetDungeonName(dungeonIdx), routes = routes }
    end
  end
  return groups
end

---The player's routes with content, grouped by dungeon, newest season first.
---@param currentSeason boolean? only dungeons of the season selected in MDT
---@return MDT.RouteGroup[]
function MDT:GetShareableRouteGroups(currentSeason)
  return routeGroups(currentSeason, hasContent)
end

---Every route of the season selected in MDT except the default route and <New Preset>, grouped by dungeon.
---@return MDT.RouteGroup[]
function MDT:GetDeletableRouteGroups()
  return routeGroups(true, function(preset, index)
    return index > 1 and type(preset) == "table" and preset.value ~= 0
  end)
end

---A copy of the route as an export carries it. The route itself gets a uid and an author first, so importing the
---string again finds it.
---@param preset table
---@return table
function MDT:GetRouteExportData(preset)
  initializeDB()
  MDT:SetUniqueID(preset)
  MDT:EnsurePresetCreatedBy(preset)
  local data = CopyTable(preset)
  data.addonVersion = db.version
  if db.colorPaletteInfo.forceColorBlindMode then MDT:ColorPullsForExport(data) end
  return data
end

---One route exports as a plain route string, so it still works everywhere a route string does.
---@param presets table[]
---@return string
function MDT:ExportRouteString(presets)
  if #presets == 1 then return MDT:TableToString(MDT:GetRouteExportData(presets[1])) end
  local routes = {}
  for index, preset in ipairs(presets) do routes[index] = MDT:GetRouteExportData(preset) end
  return MDT:TableToString({ routeBatch = BATCH_VERSION, routes = routes })
end

---Reads a route string or a batch string.
---@param text string
---@return table[]? routes routes with a valid shape; their dungeon can still be unknown
---@return string? problem when there are no routes
---@return boolean? isBatch
function MDT:DecodeRouteString(text)
  local data = type(text) == "string" and MDT:StringToTable(strtrim(text)) or nil
  if type(data) == "string" then return nil, data end
  if type(data) ~= "table" then return nil, L["Invalid import string"] end
  if data.routeBatch == nil then
    if not MDT:IsRouteShapeValid(data) then return nil, L["Invalid import string"] end
    return { data }, nil, false
  end
  if type(data.routeBatch) ~= "number" or data.routeBatch > BATCH_VERSION then return nil, L["routeBatchNewerVersion"] end
  local routes = {}
  for _, route in ipairs(type(data.routes) == "table" and data.routes or {}) do
    if MDT:IsRouteShapeValid(route) then routes[#routes + 1] = route end
  end
  if #routes == 0 then return nil, L["Invalid import string"] end
  return routes, nil, true
end

---Whether this MDT has the route's dungeon.
---@param route table
function MDT:IsRouteDungeonKnown(route)
  initializeDB()
  local dungeonIdx = route.value.currentDungeonIdx
  return isListedDungeon(dungeonIdx) and type(db.presets[dungeonIdx]) == "table"
end

---The route this player already has with the same uid, if any.
---@param route table
---@return integer? index, table? preset
function MDT:FindMatchingRoute(route)
  initializeDB()
  return findByUID(db.presets[route.value.currentDungeonIdx], route.uid)
end

---Shows a route as the current one, switching dungeon when needed.
local function showRoute(dungeonIdx, preset)
  local presets = db.presets[dungeonIdx]
  for index, candidate in ipairs(presets) do
    if candidate == preset then
      MDT:SetDungeonList(nil, dungeonIdx)
      MDT:UpdateDungeonDropDown()
      MDT:UpdateToDungeon(dungeonIdx, true)
      db.currentPreset[dungeonIdx] = index
      MDT:UpdateMap()
      return
    end
  end
end

---Adds routes without asking. A route with a matching uid replaces that route when `overwrite` is set and is added as
---a copy otherwise. Shows the imported route of the current dungeon, or else the first imported route.
---@param entries {route: table, overwrite: boolean?}[] routes of known dungeons
---@return integer count
function MDT:ImportRouteBatch(entries)
  initializeDB()
  local imported = {}
  for _, entry in ipairs(entries) do
    local preset = CopyTable(entry.route)
    local dungeonIdx = preset.value.currentDungeonIdx
    local presets = db.presets[dungeonIdx]
    local matchIndex = findByUID(presets, preset.uid)
    if matchIndex and entry.overwrite then
      presets[matchIndex] = preset
    else
      if matchIndex then preset.uid = nil end
      preset.text = uniqueName(presets, preset.text)
      MDT:SetUniqueID(preset)
      -- <New Preset> stays last
      local last = presets[#presets]
      table.insert(presets, last and last.value == 0 and #presets or #presets + 1, preset)
    end
    imported[#imported + 1] = { dungeonIdx = dungeonIdx, preset = preset }
  end
  local shown = imported[1]
  for _, entry in ipairs(imported) do
    if entry.dungeonIdx == db.currentDungeonIdx then
      shown = entry
      break
    end
  end
  if shown and MDT:AreFramesInitialized() then
    showRoute(shown.dungeonIdx, shown.preset)
    if db.colorPaletteInfo.forceColorBlindMode then MDT:ColorAllPulls() end
  end
  return #imported
end

---Lists the routes of a batch with a checkbox each; routes the player already has get an Overwrite checkbox, preset from
---"Always overwrite matching routes on import".
---@param routes table[]
---@param onDone fun(imported: table<string, boolean>)? runs once when the dialog closes, with the uids of the imported routes as the string carried them
function MDT:OpenRouteBatchImportDialog(routes, onDone)
  initializeDB()
  MDT:HideAllDialogs()
  -- A route listed twice would overwrite itself; the first one stays.
  local unique, seenUIDs = {}, {}
  for _, route in ipairs(routes) do
    if not (route.uid and seenUIDs[route.uid]) then unique[#unique + 1] = route end
    if route.uid then seenUIDs[route.uid] = true end
  end
  local rows, groups, byDungeon = {}, {}, {}
  for index, route in ipairs(unique) do
    local known = MDT:IsRouteDungeonKnown(route)
    local _, match
    if known then _, match = MDT:FindMatchingRoute(route) end
    local row = { index = index, route = route, known = known, match = match, include = known, overwrite = db.alwaysOverwriteRoutesByUID == true }
    rows[#rows + 1] = row
    local dungeonIdx = route.value.currentDungeonIdx
    local group = byDungeon[dungeonIdx]
    if not group then
      group = { dungeonIdx = dungeonIdx, name = known and MDT:GetDungeonName(dungeonIdx) or L["Unknown dungeon"], rows = {} }
      byDungeon[dungeonIdx] = group
      groups[#groups + 1] = group
    end
    group.rows[#group.rows + 1] = row
  end

  local finished
  local function finish(imported)
    if finished then return end
    finished = true
    if onDone then onDone(imported) end
  end

  local importButton
  local function selectedRows()
    local selected = {}
    for _, row in ipairs(rows) do
      if row.include then selected[#selected + 1] = row end
    end
    return selected
  end
  local function refresh()
    local count = #selectedRows()
    importButton:SetText(string.format(L["Import (%d)"], count))
    importButton:SetDisabled(count == 0)
    for _, row in ipairs(rows) do
      if row.overwriteBox then row.overwriteBox:SetDisabled(not row.include) end
    end
  end

  local function import(dialog)
    if InCombatLockdown() then
      print('MDT: '..L["Cannot import while in combat"])
      return
    end
    local entries, imported = {}, {}
    for _, row in ipairs(selectedRows()) do
      entries[#entries + 1] = { route = row.route, overwrite = row.match ~= nil and row.overwrite }
      if row.route.uid then imported[row.route.uid] = true end
    end
    dialog:Close("confirm")
    MDT:ImportRouteBatch(entries)
    finish(imported)
  end

  return UI.Dialogs.Open({
    key = "importRoutes", title = L["Import Routes"], width = 480,
    onClose = function(_, reason)
      if reason ~= "confirm" then finish({}) end
    end,
    build = function(content, dialog)
      UI.Text(content, { id = "summary", text = string.format(L["routeBatchImportSummary"], #rows, #groups) })
      local scroll = UI.Scroll(content, { id = "routes", height = math.min(LIST_HEIGHT, (#rows + #groups) * 26 + 8), gap = "xs" })
      for _, group in ipairs(groups) do
        UI.Text(scroll.content, { text = dungeonTitle(group.dungeonIdx, group.name), font = "heading", color = "text.secondary" })
        for _, row in ipairs(group.rows) do
          local line = UI.Row(scroll.content, { gap = "sm" })
          UI.Text(line, { text = "", width = INDENT })
          row.includeBox = UI.Checkbox(line, {
            id = "route"..row.index, label = MDT:GetPresetDropdownText(row.route), userText = true, value = row.include,
            disabled = not row.known, width = 1, grow = 1,
            tooltip = not row.known and L["routeBatchUnknownDungeon"] or nil,
            onChange = function(value)
              row.include = value
              refresh()
            end,
          })
          if row.match then
            row.overwriteBox = UI.Checkbox(line, {
              id = "overwrite"..row.index, label = L["Overwrite"], value = row.overwrite,
              tooltip = string.format(L["routeBatchOverwriteTooltip"], row.match.text),
              onChange = function(value) row.overwrite = value end,
            })
          end
        end
      end
      local footer = UI.Row(content, { gap = "sm", align = "end" })
      importButton = UI.Button(footer, { id = "confirm", text = "", variant = "primary", onClick = function() import(dialog) end })
      UI.Button(footer, { id = "cancel", text = L["Cancel"], onClick = function() dialog:Close("cancel") end })
      refresh()
    end,
  })
end

---A search box and a scrolling list of routes grouped by dungeon, with a checkbox for each route and each dungeon.
---@param content MDT.UI.Control
---@param groups MDT.RouteGroup[]
---@param picked table<table, true?> the picked presets; the list reads and writes it
---@param onPick fun() runs after the player picks or clears routes
---@return fun(): table[] selected the picked presets in list order
local function buildRoutePicker(content, groups, picked, onPick)
  local routeBoxes, groupBoxes, routeLines, shown = {}, {}, {}, {}
  local query = ""

  ---Whether the route's name, dungeon or creator contains the search text.
  local function matches(group, preset)
    if query == "" then return true end
    local creator = type(preset.createdBy) == "table" and preset.createdBy.name or ""
    for _, text in ipairs({ preset.text or "", group.name or "", creator }) do
      if text:lower():find(query, 1, true) then return true end
    end
    return false
  end

  local function selected()
    local presets = {}
    for _, group in ipairs(groups) do
      for _, preset in ipairs(group.routes) do
        if picked[preset] then presets[#presets + 1] = preset end
      end
    end
    return presets
  end
  local function refresh()
    for preset, box in pairs(routeBoxes) do box:SetValue(picked[preset] == true) end
    for group, box in pairs(groupBoxes) do
      local count, visible, visiblePicked = 0, 0, 0
      for _, preset in ipairs(group.routes) do
        if picked[preset] then count = count + 1 end
        if shown[preset] then
          visible = visible + 1
          if picked[preset] then visiblePicked = visiblePicked + 1 end
        end
      end
      box:SetValue(visible > 0 and visiblePicked == visible)
      box:SetLabel(string.format("%s (%d/%d)", dungeonTitle(group.dungeonIdx, group.name), count, #group.routes))
    end
  end
  local function picksChanged()
    refresh()
    onPick()
  end
  local function applySearch()
    for _, group in ipairs(groups) do
      local any = false
      for _, preset in ipairs(group.routes) do
        shown[preset] = matches(group, preset)
        routeLines[preset]:SetHidden(not shown[preset])
        any = any or shown[preset]
      end
      groupBoxes[group]:SetHidden(not any)
    end
    refresh()
  end

  UI.EditBox(content, { id = "routeSearch", placeholder = L["Search routes"], onChange = function(text)
    query = strtrim(text or ""):lower()
    applySearch()
  end })
  local scroll = UI.Scroll(content, { id = "routes", height = LIST_HEIGHT, gap = "xs" })
  for _, group in ipairs(groups) do
    groupBoxes[group] = UI.Checkbox(scroll.content, {
      id = "dungeon"..group.dungeonIdx, label = dungeonTitle(group.dungeonIdx, group.name),
      -- Picks or clears the routes of this dungeon that the search shows.
      onChange = function(value)
        for _, preset in ipairs(group.routes) do
          if shown[preset] then picked[preset] = value or nil end
        end
        picksChanged()
      end,
    })
    for position, preset in ipairs(group.routes) do
      local line = UI.Row(scroll.content, { gap = "sm" })
      routeLines[preset] = line
      UI.Text(line, { text = "", width = INDENT })
      routeBoxes[preset] = UI.Checkbox(line, {
        id = "pick"..group.dungeonIdx.."_"..position, label = MDT:GetPresetDropdownText(preset), userText = true, width = 1, grow = 1,
        onChange = function(value)
          picked[preset] = value or nil
          picksChanged()
        end,
      })
    end
  end
  applySearch()
  return selected
end

---Builds the Multiple Routes tab of the export dialog: routes grouped by dungeon, and a button that creates one string
---for all picked routes.
---@param content MDT.UI.Control
---@param dialog table the export dialog
function MDT:BuildMultipleRoutesExport(content, dialog)
  local groups = MDT:GetShareableRouteGroups(true)
  if #groups == 0 then
    UI.Text(content, { id = "noRoutes", text = L["routeBatchNoRoutes"], color = "text.secondary" })
    return
  end
  -- Without a pick in this season, the current route starts picked.
  local available, anyPicked = {}, false
  for _, group in ipairs(groups) do
    for _, preset in ipairs(group.routes) do
      available[preset] = true
      anyPicked = anyPicked or batchSelection[preset] == true
    end
  end
  if not anyPicked and available[MDT:GetCurrentPreset()] then batchSelection[MDT:GetCurrentPreset()] = true end

  local countText, createButton, output, selected
  local function updateCount()
    local count = #selected()
    countText:SetText(string.format(L["Selected: %d"], count))
    createButton:SetDisabled(count == 0)
  end
  selected = buildRoutePicker(content, groups, batchSelection, function()
    updateCount()
    -- A string made before the picks changed would leave routes out or carry extra ones.
    output:SetValue("")
    output:SetLabel(L["Export string"])
    MDT.copyHelper:SmartHide()
  end)
  local actions = UI.Row(content, { gap = "sm" })
  countText = UI.Text(actions, { id = "count", text = "", color = "text.secondary", wrap = false, grow = 1 })
  createButton = UI.Button(actions, {
    id = "createExport", text = L["Create export string"], variant = "primary",
    onClick = function()
      if InCombatLockdown() then
        print('MDT: '..L["Cannot export while in combat"])
        return
      end
      local presets = selected()
      if #presets == 0 then return end
      local export = MDT:ExportRouteString(presets)
      output:SetValue(export)
      output:SetLabel(string.format(L["routeBatchExportLabel"], #presets, string.len(export)))
      output:Focus()
      output:SelectAll()
      MDT.copyHelper:SmartShow(dialog, 0, 0)
    end,
  })
  output = UI.EditBox(content, {
    id = "text", label = L["Export string"], multiline = true, lines = 5, readOnly = true, selectAllOnFocus = true,
    placeholder = L["routeBatchExportPlaceholder"],
    onFocusLost = function() MDT.copyHelper:SmartHide() end,
    onCopy = function(box)
      if box:GetValue() == "" then return end
      MDT.copyHelper:SmartFadeOut()
      dialog:Close("confirm")
    end,
    onEscape = function() dialog:Close("escape") end,
  })
  updateCount()
end

---Lists the routes of the season selected in MDT to pick several and delete them at once.
---@param preset table? starts picked: the route whose menu opened the list
function MDT:OpenDeleteRoutesDialog(preset)
  initializeDB()
  MDT:HideAllDialogs()
  local groups = MDT:GetDeletableRouteGroups()
  local picked = {}
  for _, group in ipairs(groups) do
    for _, candidate in ipairs(group.routes) do
      if candidate == preset then picked[candidate] = true end
    end
  end
  return UI.Dialogs.Open({
    key = "deleteRoutes", title = L["Delete multiple routes"], width = 480,
    build = function(content, dialog)
      if #groups == 0 then
        UI.Text(content, { id = "noRoutes", text = L["routeBatchNoDeletableRoutes"], color = "text.secondary" })
        return
      end
      local deleteButton, selected
      local function updateCount()
        local count = #selected()
        deleteButton:SetText(string.format(L["Delete (%d)"], count))
        deleteButton:SetDisabled(count == 0)
      end
      selected = buildRoutePicker(content, groups, picked, updateCount)
      UI.Text(content, { id = "warning", text = L["routeBatchDeleteWarning"], color = "warn" })
      local footer = UI.Row(content, { gap = "sm", align = "end" })
      deleteButton = UI.Button(footer, { id = "confirm", text = "", variant = "danger", onClick = function()
        local doomed = {}
        for _, route in ipairs(selected()) do doomed[route] = true end
        dialog:Close("confirm")
        MDT:DeletePresets(doomed)
      end })
      UI.Button(footer, { id = "cancel", text = L["Cancel"], onClick = function() dialog:Close("cancel") end })
      updateCount()
    end,
  })
end

-- Route sharing for other addons, reached through MythicDungeonToolsAPI. Routes are identified by uid.

local function routeInfo(route, dungeonName)
  local pulls = type(route.value.pulls) == "table" and #route.value.pulls or 0
  return {
    uid = route.uid, name = route.text, dungeonIdx = route.value.currentDungeonIdx,
    dungeonName = dungeonName, dungeonIcon = MDT:GetDungeonIcon(route.value.currentDungeonIdx), pulls = pulls,
    author = type(route.createdBy) == "table" and route.createdBy.name or nil,
    authorClass = type(route.createdBy) == "table" and MDT:GetClassFileByIndex(route.createdBy.classIdx) or nil,
  }
end

---@return table[] {uid, name, dungeonIdx, dungeonName, dungeonIcon, pulls, author?, authorClass?, currentSeason} newest season first;
---currentSeason marks routes of the season selected in MDT
function MDT:API_GetShareableRoutes()
  initializeDB()
  local list, season = {}, currentSeasonDungeons()
  for _, group in ipairs(MDT:GetShareableRouteGroups()) do
    for _, preset in ipairs(group.routes) do
      MDT:SetUniqueID(preset)
      local info = routeInfo(preset, group.name)
      info.currentSeason = season[group.dungeonIdx] == true
      list[#list + 1] = info
    end
  end
  return list
end

---@param uids string|string[]
---@return string? export a route string for one uid, a batch string for several; nil when none is found
function MDT:API_ExportRoutes(uids)
  initializeDB()
  if type(uids) == "string" then uids = { uids } end
  if type(uids) ~= "table" then return end
  local wanted, presets = {}, {}
  for _, uid in ipairs(uids) do wanted[uid] = true end
  for _, group in ipairs(MDT:GetShareableRouteGroups()) do
    for _, preset in ipairs(group.routes) do
      if preset.uid and wanted[preset.uid] then
        wanted[preset.uid] = nil
        presets[#presets + 1] = preset
      end
    end
  end
  if #presets == 0 then return end
  return MDT:ExportRouteString(presets)
end

---@param text string
---@return table[]? routes {uid?, name, dungeonIdx, dungeonName?, dungeonIcon, pulls, author?, authorClass?, known}
---@return string? problem
function MDT:API_DecodeRoutes(text)
  local routes, problem = MDT:DecodeRouteString(text)
  if not routes then return nil, problem end
  local list = {}
  for index, route in ipairs(routes) do
    local known = MDT:IsRouteDungeonKnown(route)
    list[index] = routeInfo(route, known and MDT:GetDungeonName(route.value.currentDungeonIdx) or nil)
    list[index].known = known
  end
  return list
end

local function comparable(route)
  local copy = CopyTable(route)
  copy.addonVersion = nil
  return copy
end

local function deepEqual(a, b)
  if type(a) ~= "table" or type(b) ~= "table" then return a == b end
  for key, value in pairs(a) do
    if not deepEqual(value, b[key]) then return false end
  end
  for key in pairs(b) do
    if a[key] == nil then return false end
  end
  return true
end

---Whether two route or batch strings carry the same routes, ignoring the MDT version that exported them.
---@param textA string
---@param textB string
---@return boolean
function MDT:API_AreRouteStringsEqual(textA, textB)
  local routesA, routesB = MDT:DecodeRouteString(textA), MDT:DecodeRouteString(textB)
  if not routesA or not routesB or #routesA ~= #routesB then return false end
  for index, route in ipairs(routesA) do
    if not deepEqual(comparable(route), comparable(routesB[index])) then return false end
  end
  return true
end

---Opens MDT with the batch import list for every route in the strings.
---@param texts string|string[] route or batch strings
---@param callback fun(imported: table<string, boolean>)? runs once when the list closes, with the uids of the imported routes
---@return boolean opened
---@return string? problem
function MDT:API_ImportRoutes(texts, callback)
  if InCombatLockdown() then return false, L["Cannot import while in combat"] end
  if type(texts) == "string" then texts = { texts } end
  if type(texts) ~= "table" then return false, L["Invalid import string"] end
  local routes, lastProblem = {}, nil
  for _, text in ipairs(texts) do
    local decoded, problem = MDT:DecodeRouteString(text)
    if decoded then
      for _, route in ipairs(decoded) do routes[#routes + 1] = route end
    else
      lastProblem = problem
    end
  end
  if #routes == 0 then return false, lastProblem or L["Invalid import string"] end
  -- The window would not open; the callback could never run.
  if not MDT:IsCompatibleVersion() then return false, L["incompatibleVersionError"] end
  if MDT:CheckAddonConflicts() then return false, L["routeBatchAddonConflict"] end
  MDT:Async(function()
    if MDT.IsMapSectionActive and not MDT:IsMapSectionActive() then MDT:SetCurrentSection("maps") end
    MDT:ShowInterfaceInternal(true)
    MDT:RunAfterFramesInitialized(function()
      if not MDT:OpenRouteBatchImportDialog(routes, callback) and callback then callback({}) end
    end)
  end, "showInterfaceRouteBatchImport")
  return true
end
