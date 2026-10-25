local _, MDT = ...
local L = MDT.L
local UI = MDT.UI
local Theme, Selection, Model = UI.Theme, UI.Selection, MDT.SidebarModel

local TOP_HEIGHT = 24
local ACTION_COUNT = 4
local STEPPER_WIDTH = 64
local MIN_LEVEL, MAX_LEVEL = 1, 35
local VISIBLE_ROUTES = 7
local ACTION_HEIGHT = 32
local ACTION_ICON = 20
local BAR_TONES = { ["text.normal"] = "bar.progress", ok = "bar.ok", warn = "bar.warn" }

local db
local sidebar
local lastRoute = {}
local routeQuery = ""

local function notifyRouteChanged(preset)
  local dungeonIdx = db.currentDungeonIdx
  local presetIdx = db.currentPreset[dungeonIdx]
  if lastRoute.dungeonIdx == dungeonIdx and lastRoute.presetIdx == presetIdx and lastRoute.preset == preset then return end
  lastRoute.dungeonIdx, lastRoute.presetIdx, lastRoute.preset = dungeonIdx, presetIdx, preset
  MDT:FireRouteChanged(dungeonIdx, presetIdx)
end

local function authorColor(createdBy)
  local classFile = createdBy and MDT:GetClassFileByIndex(createdBy.classIdx)
  if not classFile then return nil end
  local r, g, b = GetClassColor(classFile)
  if not r then return nil end
  return { r, g, b }
end

---The impure edge: everything SidebarModel.Build reads, gathered from db and the live state.
---@return MDT.SidebarContext
function MDT:SidebarContext()
  -- The map's pull labels ask for this too, and may do so before the sidebar is built.
  db = db or MDT:GetDB()
  local dungeonIdx = db.currentDungeonIdx
  local preset = MDT:GetCurrentPreset()
  local author = MDT:GetCurrentRouteAuthor()
  local totals = MDT.dungeonTotalCount[dungeonIdx]
  return {
    enemies = MDT.dungeonEnemies[dungeonIdx] or {},
    totalForces = totals and totals.normal or 0,
    level = db.currentDifficulty,
    useForcesCount = db.useForcesCount == true,
    showHealth = db.showPullButtonHealth == true,
    healthOf = function(enemy) return MDT:CalculateEnemyHealth(enemy.isBoss or false, enemy.health, db.currentDifficulty, enemy.ignoreFortified) end,
    formatHealth = function(health) return tostring(MDT:FormatEnemyHealth(health)) end,
    pullColor = function(index) return MDT:DungeonEnemies_GetPullColor(index, preset.value.pulls) end,
    authorColor = authorColor,
    player = author and { name = author.name, realm = author.realm } or nil,
    presets = db.presets[dungeonIdx],
    presetIdx = db.currentPreset[dungeonIdx],
    liveActive = MDT.liveSessionActive == true,
    livePresetUID = MDT.livePresetUID,
    inGroup = MDT:IsPlayerInGroup() and true or false,
    busy = MDT.transmissionBusy == true,
  }
end

local PREVIEW_RESET_DELAY = 0.35
local previewResetTimer

---Paints the forces bar for `current` forces; the header total, or the running total up to a hovered pull.
---@param current number
local function paintForces(current)
  local max = sidebar.state.header.forces.max
  local color = Theme.Rgba(BAR_TONES[Model.ForcesTone(current, max)])
  sidebar.forces:SetSegments({ { value = current, color = color } }, math.max(max, current, 1))
  sidebar.forces:SetText(Model.FormatForcesTotal(current, max))
end

---@param cumulative number? running total up to the hovered pull; nil ends the preview after a short delay
local function previewForces(cumulative)
  if previewResetTimer then previewResetTimer:Cancel() end
  previewResetTimer = nil
  if cumulative then
    paintForces(cumulative)
  else
    previewResetTimer = C_Timer.NewTimer(PREVIEW_RESET_DELAY, function()
      previewResetTimer = nil
      if sidebar.state then paintForces(sidebar.state.header.forces.current) end
    end)
  end
end

local function paintHeader(header)
  sidebar.level:SetValue(header.level)
  paintForces(header.forces.current)
  local actions = header.actions
  sidebar.share:SetDisabled(not actions.canShare)
end

local function refreshRoutes(ctx)
  sidebar.routes:SetItems(Model.RouteListItems(Model.RouteGroups(ctx or MDT:SidebarContext()), routeQuery))
end

---The one impure refresh: rebuilds the header and the pull list from the current preset and paints the selection.
function MDT:RefreshSidebar()
  if not sidebar then return end
  MDT:EnsureDBTables()
  MDT:ColorAllPulls(nil, 0)
  local preset = MDT:GetCurrentPreset()
  local ctx = MDT:SidebarContext()
  local state = Model.Build(preset, ctx)
  sidebar.state = state
  paintHeader(state.header)
  refreshRoutes(ctx)
  sidebar.list:SetItems(state.items)
  sidebar.list:SetSelection(MDT:GetSelection())
  MDT:CloseRouteDialogs()
  notifyRouteChanged(preset)
end

---@param shown boolean
function MDT:SetSidebarShown(shown)
  if not sidebar then return end
  sidebar.root:SetHidden(not shown)
  if not shown then
    UI.Overlay.PopAll("popover", "api")
    MDT:HidePullListCards()
  end
end

---@param presetIdx integer
function MDT:SwitchToPreset(presetIdx)
  db.currentPreset[db.currentDungeonIdx] = presetIdx
  MDT:UpdateMap()
end

local function sendPullsIfLive()
  if MDT.liveSessionActive and MDT:GetCurrentPreset().uid == MDT.livePresetUID then
    MDT:LiveSession_SendPulls(MDT:GetPulls())
  end
end

local function applyLevelChange(level)
  local crossingTen = (level >= 10 and db.currentDifficulty < 10) or (level < 10 and db.currentDifficulty >= 10)
  db.currentDifficulty = level
  MDT:GetCurrentPreset().difficulty = level
  if crossingTen then MDT:POI_UpdateAll() end
  MDT:RefreshSidebar()
  MDT:UpdateEnemyInfoData()
end

local function commitLevelChange()
  if MDT.liveSessionActive and MDT:GetCurrentLivePreset() == MDT:GetCurrentPreset() then
    MDT:LiveSession_SendDifficulty()
  end
end

---@param level integer
function MDT:SetDungeonLevel(level)
  level = math.max(MIN_LEVEL, math.min(MAX_LEVEL, level))
  if level ~= db.currentDifficulty then applyLevelChange(level) end
  commitLevelChange()
end

local routeActions = {
  new = function() MDT:OpenNewPresetDialog() end,
  duplicate = function() MDT:OpenNewPresetDialog(db.currentPreset[db.currentDungeonIdx]) end,
  rename = function() MDT:OpenRenamePresetDialog() end,
  takeOwnership = function()
    MDT:TakePresetOwnership(MDT:GetCurrentPreset())
    MDT:RefreshSidebar()
  end,
  import = function() MDT:OpenImportPresetDialog() end,
  export = function() MDT:OpenExportDialog() end,
  share = function() MDT:SendCurrentPresetToGroup() end,
  toggleLive = function() MDT:ToggleLiveSession() end,
  setLive = function() MDT:SetLivePreset() end,
  returnToLive = function() MDT:ReturnToLivePreset() end,
  delete = function() MDT:OpenDeletePresetDialog() end,
}

local pullActions = {
  moveUp = function(index)
    MDT:MovePullUp(index)
    sendPullsIfLive()
  end,
  moveDown = function(index)
    MDT:MovePullDown(index)
    sendPullsIfLive()
  end,
  insertBefore = function(index)
    MDT:AddPull(index)
    sendPullsIfLive()
  end,
  insertAfter = function(index)
    MDT:AddPull(index + 1)
    sendPullsIfLive()
  end,
  mergeUp = function(index)
    MDT:MergePulls({ index, index - 1 }, index - 1)
    sendPullsIfLive()
  end,
  mergeDown = function(index)
    MDT:MergePulls({ index, index + 1 }, index + 1)
    sendPullsIfLive()
  end,
  merge = function(selection, into)
    local list = {}
    for _, index in ipairs(selection) do
      if index ~= into then list[#list + 1] = index end
    end
    list[#list + 1] = into
    MDT:MergePulls(list, into)
    sendPullsIfLive()
  end,
  clear = function(indices)
    for _, index in ipairs(indices) do MDT:ClearPull(index) end
    sendPullsIfLive()
  end,
  resetPreset = function() MDT:OpenClearPresetDialog() end,
  delete = function(indices, anchor)
    if #indices == 1 then
      MDT:DeletePull(indices[1])
    else
      MDT:DeletePulls(indices, anchor)
    end
    sendPullsIfLive()
  end,
}

local function selectPull(index, selection)
  local preset = MDT:GetCurrentPreset()
  preset.value.selection = selection
  local changed = MDT:SetMapSublevel(index)
  MDT:SetSelectionToPull(#selection == 1 and selection[1] or selection)
  if changed then MDT:UpdateMap() end
end

local function onSelect(selection, index, mods)
  if mods.button == "RightButton" then
    if mods.shift or mods.ctrl then return end
    if Selection.Contains(MDT:GetSelection(), index) then return end
    if #MDT:GetSelection() == 1 then
      selectPull(index, { index })
    else
      MDT:GetCurrentPreset().value.selection = selection
      sidebar.list:SetSelection(selection)
    end
    return
  end
  if mods.ctrl then
    if Selection.Contains(MDT:GetSelection(), index) then
      MDT:GetCurrentPreset().value.selection = selection
      sidebar.list:SetSelection(selection)
    else
      selectPull(index, selection)
    end
    return
  end
  if mods.shift then
    selectPull(index, selection)
    return
  end
  MDT:EnsureDBTables()
  MDT:GetCurrentPreset().value.selection = { index }
  local changed = MDT:SetMapSublevel(index)
  MDT:SetSelectionToPull(index)
  local shouldAutoPan = db.autoPanToPull ~= false
  if changed then
    if shouldAutoPan then MDT.pendingAutoPanToPull = index end
    MDT:UpdateMap()
  elseif shouldAutoPan then
    MDT:PanMapToPull(index)
  end
end

local function onActivate(item, index, mods)
  if item.kind == "newPull" and not mods.shift and not mods.ctrl then
    MDT:AddPull()
    sendPullsIfLive()
  end
end

local function onContext(item, index, mods)
  if item.kind ~= "pull" or mods.ctrl then return nil end
  local pulls = MDT:GetPulls()
  if mods.shift then
    if #pulls > 1 then MDT:DeletePull(index) end
    return nil
  end
  if #MDT:GetSelection() <= 1 then
    MDT:SetMapSublevel(index)
    MDT:SetSelectionToPull(index)
  end
  MDT:OpenPullMenu(sidebar.list, index)
  return nil
end

---Opens the pull menu for a pull, acting on the selection when the pull is part of it. The pull rows and the map's
---pull labels open it.
---@param owner table
---@param index integer
---@param title string? shown above the items
function MDT:OpenPullMenu(owner, index, title)
  local ctx = { index = index, maxPulls = #MDT:GetPulls(), selection = CopyTable(MDT:GetSelection()) }
  local items = Model.PullMenuItems(ctx, pullActions, L)
  if title then table.insert(items, 1, { kind = "title", text = title }) end
  MDT:CreateContextMenu(owner, items)
end

---Runs a pull action the way the pull menu does, sending the pulls to a live session.
---@param action string key of pullActions
function MDT:RunPullAction(action, ...)
  pullActions[action](...)
end

---Scrolls the pull list just far enough to show a pull's row, if it is out of view.
---@param index integer
function MDT:ScrollSidebarToPull(index)
  if sidebar then sidebar.list:ScrollTo(index, "nearest") end
end

---Shows the running total up to a pull on the forces bar, like hovering its row; nil goes back to the route's total.
---@param cumulative integer?
function MDT:PreviewSidebarForces(cumulative)
  if sidebar and sidebar.state then previewForces(cumulative) end
end

local function onReorder(keys, slot)
  MDT:MovePulls(keys, slot)
  sendPullsIfLive()
end

local function onHover(item, index, row)
  -- An enemy dragged across the list shows no cards.
  if item.kind ~= "pull" or MDT:IsEnemyDragging() then return end
  -- An enemy card held by Ctrl stays the only card; the row shows its own once Ctrl is let go over it.
  if not (IsControlKeyDown() and MDT:IsEnemyHoverCardShown()) then MDT:ShowPullCardBesideRow(row, item) end
  row:kitWatchPortraits(true)
  previewForces(item.cumulative)
  MDT:PullClickAreaOnEnter(index)
end

local function onHoverEnd(item, index, row)
  if item.kind ~= "pull" then return end
  row:kitWatchPortraits(false)
  -- An enemy card held by Ctrl stays; it closes itself once Ctrl is let go away from it.
  if IsControlKeyDown() then MDT:HidePullCardBesideRow(row) else MDT:HidePullListCards(row) end
  previewForces(nil)
  MDT:PullClickAreaOnLeave()
end

---Runs a route action on any route: switches to it first, because the dialogs act on the current route.
---@param action string key of routeActions
---@param presetIdx integer
function MDT:RunRouteAction(action, presetIdx)
  if presetIdx ~= db.currentPreset[db.currentDungeonIdx] then MDT:SwitchToPreset(presetIdx) end
  routeActions[action]()
end

local BLOCK_REASONS = {
  noGroup = "Join a group first",
  busy = "Wait until the current route finishes sending",
  live = "Not needed during a live session, changes sync automatically",
}

---Tooltip with a title and, when the action can't run right now, the reason in red. Evaluated on hover.
---@param title string
---@param reason fun(): string?
local function explained(title, reason)
  return function(tooltip)
    tooltip:SetText(title, 1, 1, 1)
    local why = reason()
    if why then tooltip:AddLine(why, 1, 0.42, 0.36, true) end
  end
end

local function groupReason(key)
  return function()
    if MDT:IsInRestrictedEnvironment() then return L["Action blocked: Restricted environment"] end
    local block = sidebar.state.header.actions[key]
    return block and L[BLOCK_REASONS[block]] or nil
  end
end

local function combatReason(text)
  return function() return InCombatLockdown() and L[text] or nil end
end

---@param width number? fixed width; nil lets the button take the rest of the row
local function actionButton(parent, id, icon, width, tooltip, onClick, onRightClick)
  return UI.Button(parent, {
    id = id, variant = "window", icon = MDT:GetIconPath(icon), iconSize = ACTION_ICON, width = width or 20, grow = not width and 1 or nil, height = ACTION_HEIGHT,
    tooltip = tooltip, onClick = onClick, onRightClick = onRightClick,
  })
end

---Every route action for one route, in the order of the action row. Actions on another route switch to it first.
---@param idx integer
---@return MDT.UI.MenuItem[]
local function routeMenuItems(idx)
  local a = sidebar.state.header.actions
  local function run(action) return function() MDT:RunRouteAction(action, idx) end end
  local preset = db.presets[db.currentDungeonIdx][idx]
  -- The default route has no author, and a new uid would drop the live route out of its session.
  local canTakeOwnership = idx ~= 1 and not (a.liveActive and idx == a.livePresetIdx)
    and not Model.IsAuthoredBy(preset.createdBy, MDT:GetCurrentRouteAuthor())
  return {
    { text = L["Rename"], onSelect = run("rename") },
    { text = L["Duplicate"], onSelect = run("duplicate") },
    canTakeOwnership and { text = L["Mark as my route"], onSelect = run("takeOwnership") } or false,
    { text = L["Export"], onSelect = run("export") },
    { kind = "separator" },
    { text = L["Send to party"], disabled = not a.canShare, tooltip = groupReason("shareBlocked")(), onSelect = run("share") },
    { kind = "separator" },
    not a.liveActive and { text = L["Start live session"], disabled = not a.canLive, tooltip = groupReason("liveBlocked")(), onSelect = run("toggleLive") } or false,
    a.liveActive and idx ~= a.livePresetIdx and { text = L["Make this preset the live preset"], onSelect = run("setLive") } or false,
    a.liveActive and a.canReturnToLive and { text = L["Return to the live preset"], onSelect = routeActions.returnToLive } or false,
    a.liveActive and { text = L["Stop live session"], textColor = "live", onSelect = routeActions.toggleLive } or false,
    { kind = "separator" },
    { text = L["Delete this preset"], textColor = "warn", disabled = idx == 1 or a.liveActive, onSelect = run("delete") },
    { text = L["Delete multiple routes"], textColor = "warn", disabled = a.liveActive, onSelect = function() MDT:OpenDeleteRoutesDialog(preset) end },
  }
end

---Builds the sidebar once on the side panel. Frames persist for the session; RefreshSidebar paints them.
---@param sidePanel table
function MDT:MakeSidebar(sidePanel)
  db = MDT:GetDB()
  local root = UI.Stack(sidePanel, { gap = "sm", autoHeight = false })
  root:SetPoint("TOPLEFT", sidePanel, "TOPLEFT", 4, -3)
  root:SetPoint("BOTTOMRIGHT", sidePanel, "BOTTOMRIGHT", -4, 30)
  local built = { root = root }
  root:Batch(function()
    -- The search box ends where the third action button ends; the window buttons sit above the last one.
    local gap = Theme.Space("xs")
    local buttonWidth = math.floor((sidePanel:GetWidth() - 8 - gap * (ACTION_COUNT - 1)) / ACTION_COUNT)
    local top = UI.Row(root, { id = "top", height = TOP_HEIGHT, width = buttonWidth * (ACTION_COUNT - 1) + gap * (ACTION_COUNT - 2), valign = "center" })
    built.search = UI.EditBox(top, { id = "routeSearch", placeholder = L["Search routes"], width = 60, grow = 1, onChange = function(text)
      routeQuery = text or ""
      refreshRoutes()
    end })
    local actions = UI.Row(root, { id = "routeActions", gap = "xs", valign = "center" })
    built.share = actionButton(actions, "shareRoute", "share", buttonWidth, explained(L["Send to party"], groupReason("shareBlocked")), routeActions.share)
    built.new = actionButton(actions, "newRoute", "plus", buttonWidth, L["New Preset"], routeActions.new)
    built.export = actionButton(actions, "exportRoute", "export", buttonWidth, explained(L["Export"], combatReason("Cannot export while in combat")), routeActions.export)
    built.import = actionButton(actions, "importRoute", "import", nil, explained(L["Import"], combatReason("Cannot import while in combat")), routeActions.import)
    built.routes = UI.List(root, {
      id = "routes", kinds = MDT.RouteListKinds, gap = 0, height = VISIBLE_ROUTES * MDT.RouteListRowHeight, scrollbar = true,
      onActivate = function(item) MDT:SwitchToPreset(item.idx) end,
      onContext = function(item)
        MDT:CreateContextMenu(sidebar.routes, routeMenuItems(item.idx))
        return nil
      end,
    })
    local controls = UI.Row(root, { id = "controls", gap = "sm", valign = "center" })
    built.level = UI.Stepper(controls, {
      id = "level", value = db.currentDifficulty, min = MIN_LEVEL, max = MAX_LEVEL, width = STEPPER_WIDTH, variant = "primary",
      hidden = not MDT:IsRetail(), tooltip = L["Select the dungeon level"],
      format = function(value) return "+"..value end,
      onChange = applyLevelChange,
      onCommit = commitLevelChange,
    })
    built.forces = UI.SegmentBar(controls, { id = "forces", width = 60, grow = 1, segments = {}, max = 1, font = "body" })
    built.list = UI.List(root, {
      id = "pulls", kinds = MDT.SidebarRowKinds, gap = "xs", height = 0, grow = 1,
      onSelect = onSelect, onActivate = onActivate, onContext = onContext, onReorder = onReorder,
      onHover = onHover, onHoverEnd = onHoverEnd,
    })
  end)
  sidebar = built
  sidePanel:GetParent():HookScript("OnHide", function() MDT:HidePullListCards() end)
  MDT:RefreshSidebar()
end

---Test and dev-tool access to the sidebar's controls by id.
---@param id string
---@return MDT.UI.Control?
function MDT:GetSidebarControl(id)
  return sidebar and sidebar.root:Find(id)
end
