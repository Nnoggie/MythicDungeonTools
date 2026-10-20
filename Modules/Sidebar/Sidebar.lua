local _, MDT = ...
local L = MDT.L
local UI = MDT.UI
local Theme, Selection, Model, PullTooltip = UI.Theme, UI.Selection, MDT.SidebarModel, MDT.PullTooltip

local TOP_HEIGHT = 24
local WINDOW_BUTTONS_WIDTH = 52
local STEPPER_WIDTH = 64
local MIN_LEVEL, MAX_LEVEL = 1, 35

local db
local sidebar
local lastRoute = {}

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
  sidebar.switcher:SetAuthor(header.author)
  sidebar.switcher:SetAuthorColor(header.authorColor)
  sidebar.switcher:SetRoute(header.route)
  sidebar.switcher:SetLive(header.isLiveRoute)
  sidebar.level:SetValue(header.level)
  local forces = header.forces
  sidebar.forces:SetSegments(forces.segments, math.max(forces.max, forces.current, 1))
  sidebar.forces:SetMarker(forces.max)
  sidebar.forces:SetText(forces.text)
  sidebar.forces:SetOverflow(forces.tone == "warn")
end

---The one impure refresh: rebuilds the header and the pull list from the current preset and paints the selection.
function MDT:RefreshSidebar()
  if not sidebar then return end
  MDT:EnsureDBTables()
  MDT:ColorAllPulls(nil, 0)
  local preset = MDT:GetCurrentPreset()
  local state = Model.Build(preset, MDT:SidebarContext())
  sidebar.state = state
  paintHeader(state.header)
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
  MDT:PullClickAreaOnEnter(index)
end

local function onHoverEnd(item, index, row)
  if item.kind ~= "pull" then return end
  PullTooltip.Hide(row)
  MDT:PullClickAreaOnLeave()
end

local function openSwitcher(button)
  MDT:OpenRouteSwitcher(button, MDT:SidebarContext(), {
    pick = function(idx) MDT:SwitchToPreset(idx) end,
    new = routeActions.new,
    import = routeActions.import,
  })
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
    built.switcher = UI.RouteSwitcher(top, { id = "switcher", width = 60, grow = 1, onClick = openSwitcher })
    local controls = UI.Row(root, { id = "controls", gap = "sm", valign = "center" })
    built.level = UI.Stepper(controls, {
      id = "level", value = db.currentDifficulty, min = MIN_LEVEL, max = MAX_LEVEL, width = STEPPER_WIDTH, variant = "primary",
      hidden = not MDT:IsRetail(), tooltip = L["Select the dungeon level"],
      format = function(value) return "+"..value end,
      onChange = applyLevelChange,
      onCommit = commitLevelChange,
      onPick = function(stepper) MDT:OpenLevelPicker(stepper, db.currentDifficulty, function(level) MDT:SetDungeonLevel(level) end) end,
    })
    built.forces = UI.SegmentBar(controls, { id = "forces", width = 60, grow = 1, segments = {}, max = 1 })
    built.more = UI.Button(controls, { id = "more", variant = "icon", text = "···", menu = function()
      return Model.RouteMenuItems(sidebar.state.header, routeActions, L)
    end })
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
