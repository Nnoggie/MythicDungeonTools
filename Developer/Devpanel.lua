local _, MDT = ...
local UI = MDT.UI
local db
local tonumber, tinsert, pairs, ipairs = tonumber, table.insert, pairs, ipairs
local UnitName, UnitGUID, UnitCreatureType, UnitHealthMax, UnitLevel = UnitName, UnitGUID, UnitCreatureType, UnitHealthMax, UnitLevel

--[[
  Bind macros:
  1. Add clone
  /run MDTAddCloneAtCursorPosition()
  2. Add patrol point to clone
  /run MDTAddPatrolWaypointAtCursorPosition()
  3. Add untargetable unit if needed
  /run MDT:AddNPCFromUnit("mouseover")
]]

function MDT:ToggleDevMode()
  db = MDT:GetDB()
  if db.devMode then
    MDT:Async(function()
      MDT:DisableDevMode()
    end, "toggleDevMode")
    return
  end

  MDT:Async(function()
    MDT:EnableDevMode()
  end, "toggleDevMode")
end

function MDT:PositionDevPanel(frame, maximized)
  frame = frame or MDT.main_frame
  if not frame or not frame.devPanel then return end
  if maximized == nil then maximized = db.maximized end

  frame.devPanel:ClearAllPoints()
  if maximized then
    frame.devPanel:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, -45)
  else
    frame.devPanel:SetPoint("TOPRIGHT", frame.navigationSidebar, "TOPLEFT", 0, 0)
  end
  frame.devPanel:SetShown(db.devMode == true)
end

function MDT:EnableDevMode()
  db = MDT:GetDB()
  db.devMode = true
  if not MDT:InitializeDevModeCache() then return end

  MDT:ShowInterfaceInternal(true)

  local frame = MDT.main_frame
  if not frame then return end

  frame:SetScript("OnUpdate", nil)
  MDT:HideAllBlipLabels(true)

  if MDT.CreateDevPanel and not frame.devPanel then
    MDT:CreateDevPanel(frame)
  end

  if frame.devPanel then
    MDT:PositionDevPanel(frame)
  end

  MDT:UpdatePullLabelSizeSlider()
  MDT:UpdateMap()
  MDT:UpdateEnemyInfoFrame()
end

function MDT:DisableDevMode()
  db = MDT:GetDB()
  MDT:SaveDevModeCache()
  db.devMode = false

  local frame = MDT.main_frame
  if not frame then return end

  if frame.devPanel then
    frame.devPanel:Hide()
  end

  MDT:SetUpModifiers(frame)
  MDT:HideAllBlipLabels(true)
  MDT:UpdatePullLabelSizeSlider()
  MDT:UpdateMap()
  MDT:UpdateEnemyInfoFrame()
end

function MDT:AddNPCFromUnit(unit)
  db = MDT:GetDB()
  local npcId
  local guid = UnitGUID(unit)
  if guid then
    npcId = select(6, strsplit("-", guid))
    npcId = tonumber(npcId)
  end
  local added
  for _, npcData in pairs(MDT.dungeonEnemies[db.currentDungeonIdx]) do
    if npcData.id == npcId then
      added = true; break
    end
  end
  if npcId and not added then
    local npcName = UnitName(unit)
    local npcHealth = UnitHealthMax(unit)
    local npcLevel = UnitLevel(unit)
    local npcCreatureType = UnitCreatureType(unit)
    local npcScale = 1
    local npcCount = 0
    tinsert(MDT.dungeonEnemies[db.currentDungeonIdx], {
      name = npcName,
      health = npcHealth,
      level = npcLevel,
      creatureType = npcCreatureType,
      id = npcId,
      scale = npcScale,
      count = npcCount,
      clones = {},
    })
    return npcId
  end
end

local currentEnemyIdx
local currentCloneGroup
local currentPatrol
local currentBossEnemyIdx = 1
local currentCloneScale
local selectedTab = "enemy"

local PANEL_WIDTH = 250
local POI_X, POI_Y = 300, -200
local OBJECT_X, OBJECT_Y = 430, -250

local function text(value)
  return value ~= nil and tostring(value) or ""
end

local function currentSublevelPOIs()
  local dungeonPOIs = MDT.mapPOIs[db.currentDungeonIdx] or {}
  MDT.mapPOIs[db.currentDungeonIdx] = dungeonPOIs
  local sublevel = MDT:GetCurrentSubLevel()
  dungeonPOIs[sublevel] = dungeonPOIs[sublevel] or {}
  return dungeonPOIs[sublevel]
end

local function addPOI(poi)
  if not poi then return end
  poi.template = poi.template or "MapLinkPinTemplate"
  tinsert(currentSublevelPOIs(), poi)
  MDT:POI_UpdateAll()
end

local function buttonRow(container, buttons)
  local row = UI.Row(container, { gap = "xs", wrap = true })
  for _, button in ipairs(buttons) do
    UI.Button(row, { text = button.text, onClick = button.onClick })
  end
  return row
end

local function checkboxRow(container, checkboxes)
  local row = UI.Row(container, { gap = "md", wrap = true })
  for _, checkbox in ipairs(checkboxes) do
    UI.Checkbox(row, { label = checkbox.label, value = checkbox.value == true, disabled = checkbox.disabled, onChange = checkbox.onChange })
  end
  return row
end

---An edit box whose Enter commits; leaving the box does not, as before the kit.
local function enterBox(container, spec)
  local onEnter = spec.onEnter
  spec.onEnter = nil
  spec.onCommit = function(value, box, source)
    if source == "enter" then onEnter(value, box) end
  end
  return UI.EditBox(container, spec)
end

local function drawPOITab(content)
  local fields = UI.Columns(content, { weights = { 1, 1 }, gap = "sm" })
  local target = UI.EditBox(fields[1], { label = "Target Floor / Bot Index", value = "1" })
  local direction = UI.EditBox(fields[2], { label = "Direction 1up -1d 2r -2l", value = "1" })
  local doorName = UI.EditBox(content, { label = "Door Name / Connected Index" })
  local doorDescription = UI.EditBox(content, { label = "Door Descripting" })
  local lockpickable = UI.Checkbox(content, { label = "Lockpickable" })
  local note = UI.EditBox(content, { label = "Graveyard Description / General Note Text" })

  local function poiButton(label, build)
    return { text = label, onClick = function() addPOI(build()) end }
  end
  buttonRow(content, {
    poiButton("MapLink", function()
      local t, d = tonumber(target:GetValue()), tonumber(direction:GetValue())
      if not (t and d) then return end
      return { x = POI_X, y = POI_Y, target = t, direction = d, connectionIndex = tonumber(doorName:GetValue()), type = "mapLink" }
    end),
    poiButton("Door", function()
      return {
        x = POI_X, y = POI_Y, type = "door", doorName = doorName:GetValue(), doorDescription = doorDescription:GetValue(),
        lockpick = lockpickable:GetValue() or nil,
      }
    end),
    poiButton("Graveyard", function()
      return { x = POI_X, y = POI_Y, template = "DeathReleasePinTemplate", type = "graveyard", graveyardDescription = note:GetValue() }
    end),
    poiButton("General Note", function()
      return { x = POI_X, y = POI_Y, type = "generalNote", text = note:GetValue() }
    end),
    poiButton("Heavy Cannon", function() return { x = POI_X, y = POI_Y, type = "heavyCannon" } end),
    poiButton("Mechagon Bot", function()
      local botType = tonumber(target:GetValue())
      return { x = 400 + (30 * botType), y = OBJECT_Y, type = "mechagonBot", botType = botType }
    end),
    poiButton("Iron Docks Iron Star", function()
      return { x = OBJECT_X, y = OBJECT_Y, type = "ironDocksIronStar", starIndex = 1 }
    end),
    poiButton("Text Frame", function() return { x = OBJECT_X, y = OBJECT_Y, type = "textFrame", text = note:GetValue() } end),
    poiButton("Zoom Icon", function()
      local zoom = MDTMapPanelFrame:GetScale()
      return {
        x = OBJECT_X, y = OBJECT_Y, type = "zoom",
        index = zoom - 2, -- the threshold after which the button zooms out
        value1 = zoom,
        value2 = MDTScrollFrame:GetHorizontalScroll() / MDT:GetScale(),
        value3 = MDTScrollFrame:GetVerticalScroll() / MDT:GetScale(),
      }
    end),
    poiButton("World Marker", function()
      return { x = OBJECT_X, y = OBJECT_Y, type = "worldMarker", index = tonumber(note:GetValue()) }
    end),
    poiButton("Brackenhide Cage", function()
      return { x = 400, y = OBJECT_Y, type = "brackenhideCage", cageIndex = tonumber(target:GetValue()) }
    end),
  })
  buttonRow(content, {
    { text = "Export Zoom Settings", onClick = function() MDT:ExportCurrentZoomPanSettings() end },
    { text = "Export to LUA", onClick = function()
      MDT:ExportString(MDT:ExportLuaTable(MDT.mapPOIs[db.currentDungeonIdx], MDT:GetSchema("pois")))
    end },
    { text = "Export Current Zone ID", onClick = function()
      local currentZoneId = C_Map.GetBestMapForUnit("player")
      if not currentZoneId then
        print("MDT DevMode: Unable to determine current zone ID")
        return
      end
      local zones, includedZones = {}, {}
      local function addZone(zoneId)
        zoneId = tonumber(zoneId)
        if zoneId and not includedZones[zoneId] then
          tinsert(zones, zoneId)
          includedZones[zoneId] = true
        end
      end
      for zoneId, dungeonIdx in pairs(MDT.zoneIdToDungeonIdx) do
        if dungeonIdx == db.currentDungeonIdx then addZone(zoneId) end
      end
      addZone(currentZoneId)
      table.sort(zones)
      MDT:ExportString(("local zones = { %s }"):format(table.concat(zones, ", ")))
    end },
  })
end

local function exportDungeonIssues(findIssues)
  local issues = ""
  for i = 1, 200 do
    local enemies = MDT.dungeonEnemies[i]
    if enemies then
      local dungeonIssues
      for _, enemy in pairs(enemies) do
        local issue = findIssues(enemy)
        if issue then
          dungeonIssues = dungeonIssues or ("--- "..MDT.dungeonList[i]).."\n"
          dungeonIssues = dungeonIssues..issue.."\n"
        end
      end
      if dungeonIssues then issues = issues..dungeonIssues.."\n" end
    end
  end
  MDT:ExportString(issues)
end

local ENEMY_FIELDS = { "id", "health", "level", "creatureType" }

local function drawEnemyTab(content)
  local enemyBoxes = {}
  local dropdown, countSlider, scaleSlider

  local function enemies() return MDT.dungeonEnemies[db.currentDungeonIdx] end
  local function selectedEnemy() return enemies()[dropdown:GetValue()] end

  local function updateFields(idx)
    local data = enemies()[idx]
    if not data then return end
    for _, name in ipairs(ENEMY_FIELDS) do enemyBoxes[name]:SetValue(text(data[name])) end
    scaleSlider:SetValue(data.scale or 1)
    countSlider:SetValue(data.count or 0)
  end

  local function updateDropdown(npcId, idx)
    if not enemies() then return end
    idx = idx or 1
    local names, order = {}, {}
    for mobIdx, data in ipairs(enemies()) do
      names[mobIdx], order[mobIdx] = data.name, mobIdx
      if npcId and data.id == npcId then idx = mobIdx end
    end
    dropdown:SetItems(UI.MenuModel.FromList(names, order))
    dropdown:SetValue(idx)
    currentEnemyIdx = idx
    updateFields(idx)
  end

  buttonRow(content, {
    { text = "Open Enemy Info", onClick = function()
      local devBlip = MDT:GetCurrentDevmodeBlip()
      if devBlip then MDT:ShowEnemyInfoFrame(devBlip) else print("MDT DevMode: Please select a blip") end
    end },
    { text = "Find Clone Issues", onClick = function()
      exportDungeonIssues(function(enemy)
        local realLength = 0
        for _ in pairs(enemy.clones) do realLength = realLength + 1 end
        if #enemy.clones ~= realLength then return enemy.name end
      end)
    end },
    { text = "Find Missing Localizations", onClick = function()
      exportDungeonIssues(function(enemy)
        if not MDT.L[enemy.name] then return ("L[\"%s\"] = \"%s\""):format(enemy.name, enemy.name) end
      end)
    end },
    { text = "Export to LUA", onClick = function()
      MDT:CleanEnemyData(db.currentDungeonIdx)
      MDT:ExportString(MDT:ExportLuaTable(enemies(), MDT:GetSchema("enemies")))
    end },
  })

  dropdown = UI.Dropdown(content, { onChange = function(idx)
    currentEnemyIdx = idx
    updateFields(idx)
    for _, blip in ipairs(MDT:GetDungeonEnemyBlips()) do blip.devSelected = nil end
    MDT:UpdateMap()
  end })

  countSlider = UI.Slider(content, { label = "Count", min = 0, max = 15, step = 1, value = 4, onCommit = function(value)
    selectedEnemy().count = value
    MDT:UpdateMap()
  end })
  local fieldColumns = UI.Columns(content, { weights = { 1, 1 }, gap = "sm" })
  for i, name in ipairs(ENEMY_FIELDS) do
    enemyBoxes[name] = enterBox(fieldColumns[(i - 1) % 2 + 1], { label = name, onEnter = function(value)
      selectedEnemy()[name] = name == "creatureType" and value or tonumber(value)
      MDT:UpdateMap()
    end })
  end
  scaleSlider = UI.Slider(content, { label = "Scale", min = 0, max = 5, step = 0.1, value = 1, onCommit = function(value)
    selectedEnemy().scale = value
    MDT:UpdateMap()
  end })

  buttonRow(content, {
    { text = "Create from Target", onClick = function() updateDropdown(MDT:AddNPCFromUnit("target")) end },
    { text = "Make Boss", onClick = function()
      local currentBlip = MDT:GetCurrentDevmodeBlip()
      if not currentBlip then return end
      local encounterID = EJ_GetCreatureInfo(1)
      if not encounterID then
        print("MDT: Error - Make sure to open Encounter Journal and navigate to the boss you want to add!")
        return
      end
      for i = 1, 10000 do
        if EJ_GetCreatureInfo(currentBossEnemyIdx, i) == encounterID then
          encounterID = i
          break
        end
      end
      local data = enemies()[currentBlip.enemyIdx]
      data.isBoss = true
      local mapID = C_Map.GetBestMapForUnit("player")
      data.instanceID = mapID and EJ_GetInstanceForMap(mapID) or 0
      data.encounterID = encounterID
      --use this data as follows:
      --if (not EncounterJournal) then LoadAddOn('Blizzard_EncounterJournal') end
      --EncounterJournal_OpenJournal(23,data.instanceID,data.encounterID)
      MDT:UpdateMap()
    end },
  })

  checkboxRow(content, {
    { label = "Blips Movable", value = db.devModeBlipsMovable, onChange = function(value) db.devModeBlipsMovable = value or nil end },
    { label = "Blips Scrollable", value = db.devModeBlipsScrollable, onChange = function(value) db.devModeBlipsScrollable = value or nil end },
    { label = "Hide Blip Text", value = db.devModeBlipTextHidden, onChange = function(value)
      db.devModeBlipTextHidden = value or nil
      MDT:UpdateMap()
    end },
  })

  local currentBlip = MDT:GetCurrentDevmodeBlip()
  local function blipData() return currentBlip and enemies()[currentBlip.enemyIdx] end
  local function blipClone() return currentBlip and blipData().clones[currentBlip.cloneIdx] end

  enterBox(content, {
    label = MDT.L["Clone forces override (blank = default)"], value = text(currentBlip and currentBlip.clone.count),
    disabled = not currentBlip,
    onEnter = function(value, box)
      if not currentBlip then return end
      local count = tonumber(value)
      if not value:match("^%s*$") and (not count or count < 0 or count % 1 ~= 0) then
        box:SetValue(text(currentBlip.clone.count))
        return
      end
      currentBlip.clone.count = count
      MDT:UpdateMap()
    end,
  })

  if currentBlip then
    currentCloneGroup = currentBlip.clone.g
    currentCloneScale = currentBlip.clone.scale
    currentPatrol = currentBlip.patrol and true or nil
  end
  local cloneColumns = UI.Columns(content, { weights = { 1, 1 }, gap = "sm" })
  local cloneGroup = enterBox(cloneColumns[1], { label = "Group of clone:", value = text(currentCloneGroup), onEnter = function(value)
    local group = tonumber(value)
    currentCloneGroup = group and group > 0 and group or nil
    if currentBlip then
      blipClone().g = currentCloneGroup
      MDT:UpdateMap()
    end
  end })
  enterBox(cloneColumns[2], { label = "Sublevel:", value = text(currentBlip and currentBlip.clone.sublevel), onEnter = function(value)
    if currentBlip then
      blipClone().sublevel = tonumber(value)
      MDT:UpdateMap()
    end
  end })
  buttonRow(content, {
    { text = "New Group", onClick = function()
      local maxGroup = 0
      for _, data in pairs(enemies()) do
        for _, clone in pairs(data.clones) do
          if clone.g and clone.g > maxGroup then maxGroup = clone.g end
        end
      end
      currentCloneGroup = maxGroup + 1
      cloneGroup:SetValue(text(currentCloneGroup))
    end },
  })

  local function enemyFlag(label, key)
    return { label = label, value = currentBlip and blipData()[key], disabled = not currentBlip, onChange = function(value)
      blipData()[key] = value or nil
      MDT:UpdateMap()
    end }
  end
  checkboxRow(content, {
    { label = "Patrol", value = currentBlip and currentBlip.clone.patrol ~= nil, disabled = not currentBlip, onChange = function(value)
      currentPatrol = value or nil
      local clone = blipClone()
      clone.patrol = currentPatrol and (clone.patrol or {}) or nil
      if not clone.patrol then currentBlip.patrolActive = false end
      MDT:UpdateMap()
    end },
    enemyFlag("Stealth Detect", "stealthDetect"),
    enemyFlag("Stealthed", "stealth"),
    enemyFlag("Neutral", "neutral"),
  })

  updateDropdown(nil, currentEnemyIdx)
end

local function drawDatabaseTab(content)
  buttonRow(content, { { text = "Toggle DevMode", onClick = function() MDT:ToggleDevMode() end } })
  checkboxRow(content, {
    { label = "Load MDT on Startup", value = db.loadOnStartUp, onChange = function(value) db.loadOnStartUp = value or nil end },
    { label = "Load Cache in devmode", value = db.loadCache, onChange = function(value) MDT:SetDevModeCacheEnabled(value) end },
  })
  buttonRow(content, {
    { text = "Clear Cache + DC", onClick = function() MDT:ResetDataCache() end },
    { text = "Hard Reset DB", onClick = function()
      MDT.UI.Dialogs.Confirm({ title = "Reset MDT DB", text = "Do you want to reset MDT DB?",
        confirm = { text = "Confirm", onClick = function() MDT:HardReset() end } })
    end },
    { text = "VDT DB", onClick = function() DevTool:AddData(db) end },
  })
end

---CreateDevPanel
---Creates the dev panel which contains buttons to add npcs, objects to the map
function MDT:CreateDevPanel(frame)
  db = MDT:GetDB()
  local devPanel = UI.Stack(frame, { width = PANEL_WIDTH, padding = "md", background = "bg.panel", border = "border.strong" })
  frame.devPanel = devPanel
  devPanel:SetFrameStrata("HIGH")
  devPanel:SetFrameLevel(50)
  local tabs
  devPanel:Batch(function()
    tabs = UI.Tabs(devPanel, {
      tabs = {
        { key = "poi", text = "POI/Zoom", build = drawPOITab },
        { key = "enemy", text = "Enemy", build = drawEnemyTab },
        { key = "db", text = "Manage DB", build = drawDatabaseTab },
      },
      selected = selectedTab,
      onSelect = function(key) selectedTab = key end,
    })
  end)
  MDT:PositionDevPanel(frame)

  --hook UpdateMap
  local originalFunc = MDT.UpdateMap
  function MDT:UpdateMap(...)
    originalFunc(...)
    if not db.devMode then return end
    local currentBlip = MDT:GetCurrentDevmodeBlip()
    if currentBlip then
      currentEnemyIdx = currentBlip.enemyIdx
    end
    tabs:SetSelected(selectedTab)
    --show patrol
    for _, blip in ipairs(MDT:GetDungeonEnemyBlips()) do
      blip:DisplayPatrol(blip.devSelected)
    end
  end
end

---AddCloneAtCursorPosition
---Adds a clone at the cursor position to the dungeon enemy table
---bound to hotkey and used to add new npcs to the map
function MDT:AddCloneAtCursorPosition()
  if not MDTScrollFrame:IsMouseOver() then return end
  if currentEnemyIdx then
    local data = MDT.dungeonEnemies[db.currentDungeonIdx][currentEnemyIdx]
    local cursorx, cursory = MDT:GetCursorPosition()
    local scale = self:GetScale()
    cursorx = cursorx * (1 / scale)
    cursory = cursory * (1 / scale)
    tinsert(data.clones,
      {
        x = cursorx,
        y = cursory,
        sublevel = MDT:GetCurrentSubLevel(),
        g = currentCloneGroup,
        scale = currentCloneScale
      })
    print(string.format("MDT: Created clone %s %d at %d,%d", data.name, #data.clones, cursorx, cursory))
    MDT:UpdateMap()
  end
end

function _G.MDTAddCloneAtCursorPosition()
  MDT:AddCloneAtCursorPosition()
end

---AddPatrolWaypointAtCursorPosition
---Adds a patrol waypoint to the selected enemy
function MDT:AddPatrolWaypointAtCursorPosition()
  if not MDTScrollFrame:IsMouseOver() then return end
  local currentBlip = MDT:GetCurrentDevmodeBlip()
  if currentBlip then
    local data = MDT.dungeonEnemies[db.currentDungeonIdx][currentBlip.enemyIdx]
    local cloneData = data.clones[currentBlip.cloneIdx]
    cloneData.patrol = cloneData.patrol or {}
    cloneData.patrol[1] = { x = cloneData.x, y = cloneData.y }
    local cursorx, cursory = MDT:GetCursorPosition()
    local scale = MDT:GetScale()
    cursorx = cursorx * (1 / scale)
    cursory = cursory * (1 / scale)
    --snap onto other waypoints
    local patrolBlips = MDT:GetPatrolBlips()
    for idx, waypoint in pairs(patrolBlips) do
      if waypoint:IsMouseOver() then
        cursorx = waypoint.x
        cursory = waypoint.y
      end
    end
    --snap onto blip
    if currentBlip:IsMouseOver() then
      cursorx = currentBlip.clone.x
      cursory = currentBlip.clone.y
    end
    tinsert(cloneData.patrol, { x = cursorx, y = cursory })
    print(string.format("MDT: Created Waypoint %d of %s %d at %d,%d", 1, data.name, #cloneData.patrol, cursorx, cursory))
    MDT:UpdateMap()
  end
end

function _G.MDTAddPatrolWaypointAtCursorPosition()
  MDT:AddPatrolWaypointAtCursorPosition()
end
