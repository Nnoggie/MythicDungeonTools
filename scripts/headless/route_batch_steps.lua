-- Harness steps for exporting and importing several routes in one string, and the route API for other addons.
-- Driven through real frames. Not shipped code.
return function(ctx)
  local W, MDT, step, expect, click, asyncIdle = ctx.W, ctx.MDT, ctx.step, ctx.expect, ctx.click, ctx.asyncIdle
  local UI = MDT.UI
  local API = _G.MythicDungeonToolsAPI
  local db = MDT:GetDB()

  local function snapshot(name, dialog)
    W.pump(0.05)
    ctx.snapshot(name, dialog)
  end
  local function openDialog(key)
    local dialog = UI.Dialogs.Get(key)
    expect(dialog and dialog:IsVisible(), key.." dialog not shown")
    return dialog
  end
  ---Finds a control of a dialog, also inside its scrolling route list.
  local function find(content, id)
    local list = content:Find("routes")
    return content:Find(id) or list and list.content:Find(id)
  end
  local function copyAndClose(box)
    W.modifiers = { ctrl = true }
    W.fireScript(box.kitEdit, "OnKeyUp", "C")
    W.modifiers = nil
    W.settle(asyncIdle, 5)
  end

  local startDungeon, startPreset = db.currentDungeonIdx, db.currentPreset[db.currentDungeonIdx]
  local otherDungeon
  for _, dungeonIdx in ipairs(MDT.dungeonSelectionToIndex[1]) do
    if dungeonIdx ~= startDungeon and MDT.dungeonList[dungeonIdx] then
      otherDungeon = dungeonIdx
      break
    end
  end
  local added = {}

  ---Adds a route with one enemy in its first pull, before <New Preset>.
  local function addRoute(dungeonIdx, name)
    local presets = db.presets[dungeonIdx]
    local preset = {
      text = name, objects = {}, colorPaletteInfo = { autoColoring = true, colorPaletteIdx = 4 },
      value = { currentDungeonIdx = dungeonIdx, currentPull = 1, currentSublevel = 1, selection = { 1 }, pulls = { { [1] = { 1 } } } },
    }
    table.insert(presets, #presets, preset)
    MDT:SetUniqueID(preset)
    added[#added + 1] = { dungeonIdx = dungeonIdx, uid = preset.uid }
    return preset
  end
  local function indexOf(dungeonIdx, preset)
    for index, candidate in ipairs(db.presets[dungeonIdx]) do
      if candidate == preset then return index end
    end
  end
  local function findUID(dungeonIdx, uid)
    for index, preset in ipairs(db.presets[dungeonIdx]) do
      if preset.uid == uid then return preset, index end
    end
  end
  local function pickId(preset)
    local dungeonIdx = preset.value.currentDungeonIdx
    for _, group in ipairs(MDT:GetShareableRouteGroups()) do
      if group.dungeonIdx == dungeonIdx then
        for position, candidate in ipairs(group.routes) do
          if candidate == preset then return "pick"..dungeonIdx.."_"..position end
        end
      end
    end
  end

  ---Unpicks every route in the Multiple Routes tab.
  local function pickNone(content)
    for _, group in ipairs(MDT:GetShareableRouteGroups()) do
      for _, preset in ipairs(group.routes) do
        local box = find(content, pickId(preset))
        if box:GetValue() then click(box) end
      end
    end
  end
  local function search(content, text)
    local edit = content:Find("routeSearch").kitEdit
    edit:SetFocus()
    edit:SetText("")
    W.fireScript(edit, "OnTextChanged", true)
    W.userType(edit, text)
  end
  local function visible(content, preset) return find(content, pickId(preset)):IsVisible() end

  local routeA, routeB, routeC

  step("route batch: export remembers its tab and makes one string from routes of several dungeons", function()
    expect(otherDungeon, "no second dungeon in the current season")
    routeA = addRoute(startDungeon, "Batch A")
    routeB = addRoute(otherDungeon, "Batch B")
    routeC = addRoute(otherDungeon, "Batch C")
    MDT:OpenExportDialog()
    local dialog = openDialog("export")
    expect(dialog.content:Find("text") and dialog.content:Find("selectAll"), "export does not open on the Current Route tab")
    dialog.content:Find("tabs"):SetSelected("multiple")
    expect(dialog.content:Find("createExport") and dialog.content:Find("selectAll") == nil, "Multiple Routes did not replace the route string")
    expect(not MDT.copyHelper:IsShown(), "the copy hint shows before there is a string")
    dialog:Close("x")
    MDT:OpenExportDialog()
    dialog = openDialog("export")
    expect(dialog.content:Find("createExport"), "the export dialog did not remember Multiple Routes")
    local content = dialog.content

    pickNone(content)
    expect(content:Find("createExport"):IsDisabled(), "Create export string is enabled with nothing picked")
    click(find(content, "dungeon"..otherDungeon))
    click(find(content, pickId(routeA)))
    expect(find(content, pickId(routeB)):GetValue() and find(content, pickId(routeC)):GetValue(), "the dungeon checkbox did not pick its routes")
    expect(find(content, "dungeon"..otherDungeon):GetValue(), "the dungeon checkbox is not checked with all its routes picked")
    click(find(content, pickId(routeC)))
    expect(not find(content, "dungeon"..otherDungeon):GetValue(), "the dungeon checkbox stays checked with a route left out")
    click(find(content, pickId(routeC)))
    snapshot("export multiple routes", dialog)

    click(content:Find("createExport"))
    local box = content:Find("text")
    expect(box:GetValue() ~= "" and box.kitEdit:HasFocus() and MDT.copyHelper:IsShown(), "Create export string did not select the string with the hint")
    local routes, _, isBatch = MDT:DecodeRouteString(box:GetValue())
    expect(routes and isBatch == true, "the export is not a batch string")
    local uids = {}
    for _, route in ipairs(routes) do uids[route.uid] = true end
    expect(uids[routeA.uid] and uids[routeB.uid] and uids[routeC.uid], "the batch string is missing a picked route")
    snapshot("export multiple routes created", dialog)
    click(find(content, pickId(routeB)))
    expect(box:GetValue() == "", "changing the picks kept a stale string")
    copyAndClose(box)
    expect(UI.Dialogs.Get("export") == dialog, "Ctrl+C on an empty field closed the dialog")
    click(find(content, pickId(routeB)))
    click(content:Find("createExport"))
    copyAndClose(box)
    expect(UI.Dialogs.Get("export") == nil, "Ctrl+C did not close the export dialog")
  end)

  step("route batch: one picked route exports as a plain route string", function()
    MDT:OpenExportDialog()
    local content = openDialog("export").content
    pickNone(content)
    click(find(content, pickId(routeA)))
    click(content:Find("createExport"))
    local routes, _, isBatch = MDT:DecodeRouteString(content:Find("text"):GetValue())
    expect(routes and isBatch == false and routes[1].uid == routeA.uid, "a single route did not export as a route string")
    expect(MDT:ValidateImportPreset(MDT:StringToTable(content:Find("text"):GetValue())), "the single route string does not import the old way")
    content:Find("tabs"):SetSelected("current")
    MDT:HideAllDialogs()
  end)

  step("route batch: search filters routes by name, dungeon and creator", function()
    routeB.createdBy = { name = "Searchauthor", realm = "Realm", classIdx = 1 }
    MDT:OpenExportDialog()
    local content = openDialog("export").content
    content:Find("tabs"):SetSelected("multiple")
    pickNone(content)
    search(content, "batch c")
    expect(visible(content, routeC) and not visible(content, routeA) and not visible(content, routeB), "search by name shows the wrong routes")
    expect(not find(content, "dungeon"..startDungeon):IsVisible(), "a dungeon without matches keeps its heading")
    search(content, MDT:GetDungeonName(startDungeon):lower())
    expect(visible(content, routeA) and not visible(content, routeC), "search by dungeon shows the wrong routes")
    search(content, "searchAUTHOR")
    expect(visible(content, routeB) and not visible(content, routeC), "search by creator shows the wrong routes")
    click(find(content, "dungeon"..otherDungeon))
    expect(find(content, pickId(routeB)):GetValue() and not find(content, pickId(routeC)):GetValue(),
      "the dungeon checkbox picked routes the search hides")
    search(content, "")
    expect(visible(content, routeA) and visible(content, routeB) and visible(content, routeC), "clearing the search left routes hidden")
    click(content:Find("createExport"))
    local made = content:Find("text"):GetValue()
    search(content, "batch")
    expect(made ~= "" and content:Find("text"):GetValue() == made, "searching cleared the export string")
    search(content, "")
    snapshot("export multiple routes search", openDialog("export"))
    MDT:HideAllDialogs()
  end)

  step("route batch: only routes of the season selected in MDT are listed", function()
    local season = {}
    for _, dungeonIdx in ipairs(MDT.dungeonSelectionToIndex[db.selectedDungeonList]) do season[dungeonIdx] = true end
    expect(season[startDungeon] and season[otherDungeon], "the test dungeons are not in the selected season")
    local outside
    for dungeonIdx in pairs(MDT.dungeonList) do
      if type(dungeonIdx) == "number" and not season[dungeonIdx] and MDT:IsRouteDungeonKnown({ value = { currentDungeonIdx = dungeonIdx } }) then
        outside = dungeonIdx
        break
      end
    end
    expect(outside, "no dungeon outside the selected season")
    local old = addRoute(outside, "Batch Old Season")
    MDT:OpenExportDialog()
    local content = openDialog("export").content
    content:Find("tabs"):SetSelected("multiple")
    expect(find(content, "dungeon"..outside) == nil, "a dungeon of another season is listed")
    expect(find(content, "dungeon"..startDungeon), "a dungeon of the selected season is missing")
    MDT:HideAllDialogs()
    local flags = {}
    for _, route in ipairs(API:GetShareableRoutes()) do flags[route.uid] = route.currentSeason end
    expect(flags[old.uid] == false and flags[routeA.uid] == true, "GetShareableRoutes does not mark the selected season")
    expect(API:ExportRoutes(old.uid), "a route of another season can no longer be exported by uid")
  end)

  step("route batch: a pasted batch lists its routes, overwrite follows the setting, and import shows the right route", function()
    local text = MDT:ExportRouteString({ routeA, routeB, routeC })
    local presetsB = db.presets[otherDungeon]
    table.remove(presetsB, indexOf(otherDungeon, routeC))
    local countA, countB = #db.presets[startDungeon], #presetsB
    local indexB = indexOf(otherDungeon, routeB)
    local overwrite = db.alwaysOverwriteRoutesByUID
    db.alwaysOverwriteRoutesByUID = false

    MDT:OpenImportPresetDialog()
    expect(W.userType(openDialog("importPreset").content:Find("input").kitEdit, text), "the import field does not have focus")
    W.pump(0.05)
    expect(UI.Dialogs.Get("importPreset") == nil, "the import dialog stayed open for a batch string")
    local dialog = openDialog("importRoutes")
    local content = dialog.content
    expect(find(content, "route1"):GetValue() and find(content, "route2"):GetValue() and find(content, "route3"):GetValue(), "routes are not all picked")
    expect(find(content, "overwrite1") and find(content, "overwrite2") and find(content, "overwrite3") == nil, "overwrite shows for the wrong routes")
    expect(not find(content, "overwrite1"):GetValue(), "overwrite is checked with the setting off")
    snapshot("import routes", dialog)
    click(find(content, "route1"))
    expect(find(content, "overwrite1"):IsDisabled(), "overwrite stays enabled for a route left out")
    click(find(content, "overwrite2"))
    expect(content:Find("confirm"):GetText() == string.format(MDT.L["Import (%d)"], 2), "the import button does not count the picks")
    click(content:Find("confirm"))
    W.settle(asyncIdle, 30)
    expect(UI.Dialogs.Get("importRoutes") == nil, "importing left the list open")
    expect(#db.presets[startDungeon] == countA, "a route left out was imported")
    expect(#presetsB == countB + 1, "the new route was not added")
    expect(presetsB[indexB] ~= routeB and presetsB[indexB].uid == routeB.uid and presetsB[indexB].text == "Batch B", "overwrite did not replace the route in place")
    expect(findUID(otherDungeon, routeC.uid), "the new route lost its uid")
    expect(db.currentDungeonIdx == otherDungeon and MDT:GetCurrentPreset().text == "Batch B", "import did not show the first imported route")
    routeB = presetsB[indexB]
    routeC = findUID(otherDungeon, routeC.uid)

    db.alwaysOverwriteRoutesByUID = true
    MDT:OpenRouteBatchImportDialog((MDT:DecodeRouteString(text)))
    content = openDialog("importRoutes").content
    expect(find(content, "overwrite1"):GetValue() and find(content, "overwrite2"):GetValue(), "overwrite is not checked with the setting on")
    click(find(content, "route1"))
    click(find(content, "route2"))
    click(find(content, "overwrite3"))
    local before = #presetsB
    click(content:Find("confirm"))
    W.settle(asyncIdle, 30)
    local copy = presetsB[#presetsB - 1]
    expect(#presetsB == before + 1 and copy.text == "Batch C 2" and copy.uid ~= routeC.uid, "an unchecked overwrite did not import a copy")
    added[#added + 1] = { dungeonIdx = otherDungeon, uid = copy.uid }
    expect(MDT:GetCurrentPreset() == copy, "import did not show the copy")
    db.alwaysOverwriteRoutesByUID = overwrite
  end)

  step("route batch: an imported route of the current dungeon is shown first", function()
    MDT:UpdateToDungeon(startDungeon)
    W.settle(asyncIdle, 30)
    MDT:OpenRouteBatchImportDialog((MDT:DecodeRouteString(MDT:ExportRouteString({ routeB, routeA }))))
    local content = openDialog("importRoutes").content
    for _, id in ipairs({ "overwrite1", "overwrite2" }) do
      if find(content, id):GetValue() then click(find(content, id)) end
    end
    click(content:Find("confirm"))
    W.settle(asyncIdle, 30)
    expect(db.currentDungeonIdx == startDungeon and MDT:GetCurrentPreset().text == "Batch A 2", "import did not prefer the current dungeon's route")
    added[#added + 1] = { dungeonIdx = startDungeon, uid = MDT:GetCurrentPreset().uid }
    added[#added + 1] = { dungeonIdx = otherDungeon, uid = db.presets[otherDungeon][#db.presets[otherDungeon] - 1].uid }
  end)

  step("route batch: routes of unknown dungeons are listed but cannot be picked", function()
    local unknown = CopyTable(routeA)
    unknown.uid, unknown.value.currentDungeonIdx = "unknownroute", 199
    local text = MDT:TableToString({ routeBatch = 1, routes = { routeA, unknown } })
    local routes = MDT:DecodeRouteString(text)
    expect(routes and #routes == 2, "a route of an unknown dungeon was dropped")
    MDT:OpenRouteBatchImportDialog(routes)
    local content = openDialog("importRoutes").content
    expect(find(content, "route2"):IsDisabled() and not find(content, "route2"):GetValue(), "a route of an unknown dungeon can be picked")
    MDT:HideAllDialogs()
    local single = MDT:TableToString(unknown)
    local listed = MDT:DecodeRouteString(single)
    expect(listed and not MDT:IsRouteDungeonKnown(listed[1]), "a route string of an unknown dungeon was not read")
    local info = API:DecodeRoutes(single)
    expect(info and info[1].known == false, "DecodeRoutes does not mark an unknown dungeon")
    MDT:OpenImportPresetDialog()
    local import = openDialog("importPreset")
    expect(W.userType(import.content:Find("input").kitEdit, single), "the import field does not have focus")
    W.pump(0.05)
    local problem
    for _, child in ipairs(import.content.kitChildren) do
      if child.kit.name == "Text" and child.kitProps.color == "warn" then problem = child end
    end
    expect(UI.Dialogs.Get("importPreset") == import and problem:IsShown() and problem.kitProps.text == MDT.L["routeBatchUnknownDungeon"],
      "a route of an unknown dungeon did not explain itself")
    MDT:HideAllDialogs()
    local newer = MDT:TableToString({ routeBatch = 99, routes = { routeA } })
    local none, problem = MDT:DecodeRouteString(newer)
    expect(none == nil and problem == MDT.L["routeBatchNewerVersion"], "a newer batch format did not ask for an update: "..tostring(none).." / "..tostring(problem))
  end)

  step("route API: list, export by uid, decode, compare, and import with a callback", function()
    local listed = {}
    for _, route in ipairs(API:GetShareableRoutes()) do listed[route.uid] = route end
    local info = listed[routeA.uid]
    expect(info and info.name == "Batch A" and info.dungeonIdx == startDungeon and info.dungeonName == MDT:GetDungeonName(startDungeon) and info.pulls == 1,
      "GetShareableRoutes does not describe the route")
    expect(info.dungeonIcon == MDT:GetDungeonIcon(startDungeon), "GetShareableRoutes does not give the dungeon icon")
    local authored = listed[routeB.uid]
    expect(authored and authored.author == "Searchauthor" and authored.authorClass == MDT:GetClassFileByIndex(1),
      "GetShareableRoutes does not name the author's class")
    local single = API:ExportRoutes(routeA.uid)
    local both = API:ExportRoutes({ routeA.uid, routeB.uid })
    expect(API:ExportRoutes({ "nope" }) == nil, "ExportRoutes made a string for an unknown uid")
    local decoded = API:DecodeRoutes(both)
    expect(decoded and #decoded == 2 and decoded[1].known and decoded[1].uid, "DecodeRoutes does not list both routes")
    local one = API:DecodeRoutes(single)
    expect(one and #one == 1 and one[1].uid == routeA.uid, "DecodeRoutes does not read a route string")
    local missing, problem = API:DecodeRoutes("garbage")
    expect(missing == nil and type(problem) == "string", "DecodeRoutes accepted garbage: "..tostring(missing).." / "..tostring(problem))
    expect(API:AreRouteStringsEqual(both, API:ExportRoutes({ routeA.uid, routeB.uid })), "the same routes compare as different")
    routeA.text = "Batch A renamed"
    expect(not API:AreRouteStringsEqual(both, API:ExportRoutes({ routeA.uid, routeB.uid })), "a renamed route compares as equal")

    expect(select(1, API:ImportRoutes("garbage")) == false, "ImportRoutes opened for garbage")
    local results = {}
    local opened = API:ImportRoutes({ single, both }, function(imported) results[#results + 1] = imported end)
    expect(opened == true, "ImportRoutes did not open")
    W.settle(asyncIdle, 30)
    local dialog = openDialog("importRoutes")
    expect(find(dialog.content, "route2") and find(dialog.content, "route3") == nil, "ImportRoutes did not list each route of every string once")
    dialog:Close("x")
    expect(#results == 1 and next(results[1]) == nil, "closing the list did not report an empty import")
    API:ImportRoutes(single, function(imported) results[#results + 1] = imported end)
    W.settle(asyncIdle, 30)
    click(openDialog("importRoutes").content:Find("confirm"))
    W.settle(asyncIdle, 30)
    expect(#results == 2 and results[2][routeA.uid], "the callback did not name the imported route")
    if not db.alwaysOverwriteRoutesByUID then added[#added + 1] = { dungeonIdx = startDungeon, uid = MDT:GetCurrentPreset().uid } end
  end)

  step("route batch: delete multiple routes removes the picked routes of several dungeons", function()
    local function deletePickId(preset)
      for _, group in ipairs(MDT:GetDeletableRouteGroups()) do
        for position, candidate in ipairs(group.routes) do
          if candidate == preset then return "pick"..group.dungeonIdx.."_"..position end
        end
      end
    end
    local doomedA, kept = addRoute(startDungeon, "Doomed A"), addRoute(startDungeon, "Kept")
    local doomedB, doomedEmpty = addRoute(otherDungeon, "Doomed B"), addRoute(otherDungeon, "Doomed Empty")
    doomedEmpty.value.pulls = { {} }
    db.currentPreset[startDungeon] = indexOf(startDungeon, doomedA)
    local above = db.presets[startDungeon][indexOf(startDungeon, doomedA) - 1]
    expect(deletePickId(doomedEmpty), "an empty route is not listed")
    expect(deletePickId(db.presets[startDungeon][1]) == nil, "the default route is listed")

    MDT:OpenDeleteRoutesDialog(doomedA)
    local content = openDialog("deleteRoutes").content
    expect(find(content, deletePickId(doomedA)):GetValue(), "the route whose menu opened the list is not picked")
    click(find(content, deletePickId(doomedB)))
    click(find(content, deletePickId(doomedEmpty)))
    expect(content:Find("confirm"):GetText() == "Delete (3)", "the delete button shows "..content:Find("confirm"):GetText())
    snapshot("delete multiple routes", openDialog("deleteRoutes"))
    click(content:Find("confirm"))
    W.settle(asyncIdle, 30)
    expect(UI.Dialogs.Get("deleteRoutes") == nil, "the dialog stayed open")
    expect(not indexOf(startDungeon, doomedA) and not indexOf(otherDungeon, doomedB) and not indexOf(otherDungeon, doomedEmpty),
      "a picked route was not deleted")
    expect(indexOf(startDungeon, kept), "a route that was not picked was deleted")
    expect(db.presets[startDungeon][db.currentPreset[startDungeon]] == above, "the current route did not move to the route above it")

    MDT.liveSessionActive, MDT.livePresetUID = true, kept.uid
    MDT:DeletePresets({ [kept] = true })
    MDT.liveSessionActive, MDT.livePresetUID = false, nil
    expect(indexOf(startDungeon, kept), "the live route was deleted")
  end)

  step("route batch: clean up the test routes", function()
    MDT:HideAllDialogs()
    for index = #added, 1, -1 do
      local presets = db.presets[added[index].dungeonIdx]
      local _, at = findUID(added[index].dungeonIdx, added[index].uid)
      if at then table.remove(presets, at) end
    end
    db.currentPreset[otherDungeon] = 1
    MDT:UpdateToDungeon(startDungeon)
    db.currentPreset[startDungeon] = math.min(startPreset, #db.presets[startDungeon] - 1)
    MDT:UpdateMap()
    W.settle(asyncIdle, 30)
    for _, entry in ipairs(added) do expect(findUID(entry.dungeonIdx, entry.uid) == nil, "a test route was left behind") end
  end)
end
