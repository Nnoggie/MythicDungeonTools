local _, MDT = ...
local L = MDT.L
local UI = MDT.UI
local Theme, Selection, Model, PullTooltip = UI.Theme, UI.Selection, MDT.SidebarModel, MDT.PullTooltip

local TOP_HEIGHT = 24
local WINDOW_BUTTONS_WIDTH = 58
local STEPPER_WIDTH = 64
local MIN_LEVEL, MAX_LEVEL = 1, 35
local VISIBLE_ROUTES = 7
local ACTION_HEIGHT = 28
local ACTION_ICON = 16
local BAR_TONES = { ["text.normal"] = "progress", ok = "ok", warn = "warn" }

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

local function paintHeader(header)
  sidebar.level:SetValue(header.level)
  local forces = header.forces
  local barColor = Theme.Rgba(BAR_TONES[forces.tone] or "progress")
  sidebar.forces:SetSegments({ { value = forces.current, color = barColor } }, math.max(forces.max, forces.current, 1))
  sidebar.forces:SetMarker(nil)
  sidebar.forces:SetText(forces.text)
  sidebar.forces:SetOverflow(false)
  local actions = header.actions
  sidebar.share:SetDisabled(not actions.canShare)
  sidebar.live:SetDisabled(not actions.canLive)
  sidebar.live:SetIconColor(actions.liveActive and "live" or nil)
  sidebar.delete:SetDisabled(not actions.canDelete and not actions.canDeleteAll)
end

local function refreshRoutes(ctx)
  local items = Model.RouteListItems(Model.RouteGroups(ctx or MDT:SidebarContext()), routeQuery)
  local height = math.max(1, math.min(#items, VISIBLE_ROUTES)) * MDT.RouteListRowHeight
  local routes = sidebar.routes
  if routes.kitProps.height ~= height then
    routes.kitProps.height = height
    routes:SetHeight(height)
    routes:InvalidateLayout()
  end
  routes:SetItems(items)
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
  notifyRouteChanged(preset)
end

---@param shown boolean
function MDT:SetSidebarShown(shown)
  if not sidebar then return end
  sidebar.root:SetHidden(not shown)
  if not shown then
    UI.Overlay.PopAll("popover", "api")
    PullTooltip.Hide()
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
  if MDT.EnemyInfoFrame and MDT.EnemyInfoFrame.frame:IsShown() then MDT:UpdateEnemyInfoData() end
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
  import = function() MDT:OpenImportPresetDialog() end,
  export = function() MDT:OpenExportDialog() end,
  share = function() MDT:SendCurrentPresetToGroup() end,
  toggleLive = function() MDT:ToggleLiveSession() end,
  setLive = function() MDT:SetLivePreset() end,
  returnToLive = function() MDT:ReturnToLivePreset() end,
  delete = function() MDT:OpenDeletePresetDialog() end,
  deleteAll = function() MDT:OpenDeleteAllPresetsDialog() end,
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
  local selection = MDT:GetSelection()
  if #selection <= 1 then
    MDT:SetMapSublevel(index)
    MDT:SetSelectionToPull(index)
    selection = MDT:GetSelection()
  end
  local ctx = { index = index, maxPulls = #pulls, selection = CopyTable(selection) }
  MDT:CreateContextMenu(sidebar.list, Model.PullMenuItems(ctx, pullActions, L))
  return nil
end

local function onReorder(keys, slot)
  MDT:MovePulls(keys, slot)
  sendPullsIfLive()
end

local function onHover(item, index, row)
  if item.kind ~= "pull" then return end
  PullTooltip.ShowPull(row, item)
  row:kitWatchPortraits(true)
  MDT:PullClickAreaOnEnter(index)
end

local function onHoverEnd(item, index, row)
  if item.kind ~= "pull" then return end
  row:kitWatchPortraits(false)
  PullTooltip.Hide(row)
  MDT:PullClickAreaOnLeave()
end

---Runs a route action on any route: switches to it first, because the dialogs act on the current route.
---@param action string key of routeActions
---@param presetIdx integer
function MDT:RunRouteAction(action, presetIdx)
  if presetIdx ~= db.currentPreset[db.currentDungeonIdx] then MDT:SwitchToPreset(presetIdx) end
  if action == "delete" and IsShiftKeyDown() then action = "deleteAll" end
  routeActions[action]()
end

local function openLiveMenu(button)
  local a = sidebar.state.header.actions
  if not a.liveActive then return end
  MDT:CreateContextMenu(button, {
    a.canSetLive and { text = L["Make this preset the live preset"], onSelect = routeActions.setLive } or false,
    a.canReturnToLive and { text = L["Return to the live preset"], onSelect = routeActions.returnToLive } or false,
    { text = L["Stop live session"], textColor = "live", onSelect = routeActions.toggleLive },
  })
end

local function actionButton(parent, id, icon, tooltip, onClick, onRightClick)
  return UI.Button(parent, {
    id = id, variant = "window", icon = MDT:GetIconPath(icon), iconSize = ACTION_ICON, width = 20, grow = 1, height = ACTION_HEIGHT,
    tooltip = tooltip, onClick = onClick, onRightClick = onRightClick,
  })
end

local function deleteClicked()
  local a = sidebar.state.header.actions
  if IsShiftKeyDown() then
    if a.canDeleteAll then routeActions.deleteAll() end
  elseif a.canDelete then
    routeActions.delete()
  end
end

---Every route action for one route, in the order of the action row. Actions on another route switch to it first.
---@param idx integer
---@return MDT.UI.MenuItem[]
local function routeMenuItems(idx)
  local a = sidebar.state.header.actions
  local function run(action) return function() MDT:RunRouteAction(action, idx) end end
  return {
    { text = L["Rename"], onSelect = run("rename") },
    { text = L["Duplicate"], onSelect = run("duplicate") },
    { text = L["Export"], onSelect = run("export") },
    { kind = "separator" },
    { text = L["Send to party"], disabled = not a.canShare, onSelect = run("share") },
    a.canSetLive and { text = L["Make this preset the live preset"], onSelect = run("setLive") } or false,
    { kind = "separator" },
    { text = L["Delete this preset"], textColor = "warn", disabled = idx == 1 or a.liveActive, onSelect = run("delete") },
    { text = L["Delete ALL presets"], textColor = "warn", disabled = not a.canDeleteAll, onSelect = routeActions.deleteAll },
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
    local top = UI.Row(root, { id = "top", height = TOP_HEIGHT, width = sidePanel:GetWidth() - 8 - WINDOW_BUTTONS_WIDTH, valign = "center" })
    built.search = UI.EditBox(top, { id = "routeSearch", placeholder = L["Search routes"], width = 60, grow = 1, onChange = function(text)
      routeQuery = text or ""
      refreshRoutes()
    end })
    local actions = UI.Row(root, { id = "routeActions", gap = "xs", valign = "center" })
    built.new = actionButton(actions, "newRoute", "plus", L["New Preset"], routeActions.new)
    built.import = actionButton(actions, "importRoute", "import", L["Import"], routeActions.import)
    built.rename = actionButton(actions, "renameRoute", "rename", L["Rename"], routeActions.rename)
    built.duplicate = actionButton(actions, "duplicateRoute", "copy", L["Duplicate"], routeActions.duplicate)
    built.export = actionButton(actions, "exportRoute", "export", L["Export"], routeActions.export)
    built.share = actionButton(actions, "shareRoute", "share", L["Send to party"], routeActions.share)
    built.live = actionButton(actions, "liveSession", "live", L["Live"], routeActions.toggleLive, openLiveMenu)
    built.delete = actionButton(actions, "deleteRoute", "delete", L["Delete this preset"].."\n"..L["Shift-Click to delete all presets for this dungeon"], deleteClicked)
    built.routes = UI.List(root, {
      id = "routes", kinds = MDT.RouteListKinds, gap = 0, height = MDT.RouteListRowHeight, scrollbar = true,
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
    built.forces = UI.SegmentBar(controls, { id = "forces", width = 60, grow = 1, segments = {}, max = 1 })
    built.list = UI.List(root, {
      id = "pulls", kinds = MDT.SidebarRowKinds, gap = "xs", height = 0, grow = 1,
      onSelect = onSelect, onActivate = onActivate, onContext = onContext, onReorder = onReorder,
      onHover = onHover, onHoverEnd = onHoverEnd,
    })
  end)
  sidebar = built
  sidePanel:GetParent():HookScript("OnHide", function() PullTooltip.Hide() end)
  MDT:RefreshSidebar()
end

---Test and dev-tool access to the sidebar's controls by id.
---@param id string
---@return MDT.UI.Control?
function MDT:GetSidebarControl(id)
  return sidebar and sidebar.root:Find(id)
end
