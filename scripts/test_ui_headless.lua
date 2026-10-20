-- Headless UI smoke test: boots MDT against a mocked WoW API, opens the UI and drives user paths.
-- Run: lua5.1 scripts/test_ui_headless.lua [repoRoot] [flags]
--   --strict                      missing WoW API calls raise errors instead of being recorded
--   --developer                   also load the #@do-not-package@ Developer files
--   --dump=path                   write a text snapshot of the visible frame tree at each checkpoint
--   --render=dir                  write <dir>/<checkpoint>.html renders of the main window at each checkpoint
--   --render-scale=n              pixels per UI unit in those renders (default 1)
--   --savedvariables=path         boot with a SavedVariables file (e.g. WTF/.../MythicDungeonTools.lua)
--   --write-savedvariables=path   write MythicDungeonToolsDB after PLAYER_LOGOUT
--   --undefined-globals           list undefined globals that were read
--   --verbose                     echo print() output
local root, flags = ".", {}
for _, value in ipairs(arg or {}) do
  local key, setting = value:match("^%-%-([%w-]+)=?(.*)$")
  if key then flags[key] = setting ~= "" and setting or true else root = value end
end

local W = dofile(root.."/scripts/headless/wow.lua")
W.strict = flags.strict == true
W.verbose = flags.verbose == true
local Loader = dofile(root.."/scripts/headless/loader.lua")(W, { developer = flags.developer == true })
Loader.register("MythicDungeonTools", root, "")
Loader.register("MythicDungeonTools_UI", root.."/MythicDungeonTools_UI", "MythicDungeonTools_UI/")

local steps, failures = {}, 0
local reportedMDTErrors = 0

local function mdtErrors()
  local ui = Loader.addons.MythicDungeonTools_UI.namespace
  return ui.GetErrors and ui:GetErrors() or {}
end

local function drainErrors()
  local found = {}
  for _, entry in ipairs(W.errors) do found[#found + 1] = entry.trace end
  W.errors = {}
  local caught = mdtErrors()
  for index = reportedMDTErrors + 1, #caught do
    found[#found + 1] = "MDT:OnError "..caught[index].message.."\n"..tostring(caught[index].stackTrace)
  end
  reportedMDTErrors = #caught
  return found
end

local function asyncIdle()
  local ui = Loader.addons.MythicDungeonTools_UI.namespace
  return not ui.asyncHandler or ui.asyncHandler.size == 0
end

local function step(name, fn)
  local ok, message = xpcall(fn, function(err) return debug.traceback(tostring(err), 2) end)
  local settled = W.settle(asyncIdle, 30)
  local found = drainErrors()
  if not ok then table.insert(found, 1, "step raised: "..message) end
  if not settled then found[#found + 1] = "async work or timers did not settle within 30s" end
  steps[#steps + 1] = { name = name, errors = found }
  if #found > 0 then
    failures = failures + #found
    io.write("FAIL ", name, "\n")
    for _, text in ipairs(found) do io.write("  ", (text:gsub("\n", "\n    ")), "\n") end
  else
    io.write("ok   ", name, "\n")
  end
end

local function expect(condition, message)
  if not condition then error(message, 2) end
end

local MDT, db, main

local renders = {}
if flags.render == true then flags.render = "ui-render" end
if flags.render then
  local probe = io.open(flags.render.."/.probe", "w")
  if probe then
    probe:close()
    os.remove(flags.render.."/.probe")
  else
    os.execute(('mkdir "%s"'):format(flags.render))
  end
end

---Renders frame (plus any frames in `also`) to <render dir>/<name>.html; no-op without --render.
local function render(name, frame, also)
  if not flags.render then return end
  local slug = name:lower():gsub("[^%w]+", "-"):gsub("^%-+", ""):gsub("%-+$", "")
  local path = flags.render.."/"..slug..".html"
  local stats = W.renderHTML(frame, path, { also = also, scale = tonumber(flags["render-scale"]), title = name })
  stats.path = path
  renders[#renders + 1] = stats
end

local snapshots = {}
---Checkpoint: text dump of the frame tree and a render of the main window with any extra top-level frames.
local function snapshot(label, ...)
  render(label, main, { ... })
  if not flags.dump then return end
  snapshots[#snapshots + 1] = "== "..label
  for _, line in ipairs(W.dumpTree()) do snapshots[#snapshots + 1] = line end
end

step("load core addon", function()
  if flags.savedvariables then
    local chunk = assert(loadfile(flags.savedvariables))
    local saved = {}
    setfenv(chunk, saved)()
    _G.MythicDungeonToolsDB = saved.MythicDungeonToolsDB
  end
  expect(Loader.load("MythicDungeonTools"), "core addon failed to load")
  W.FireEvent("PLAYER_LOGIN")
  W.FireEvent("PLAYER_ENTERING_WORLD", true, false)
end)

step("open main window via /mdt", function()
  W.RunSlashCommand("/mdt")
  expect(not Loader.addons.MythicDungeonTools_UI.loaded, "UI loaded before the loading spinner could render")
end)

MDT = Loader.addons.MythicDungeonTools_UI.namespace
db = MDT.GetDB and MDT:GetDB()
main = MDT.main_frame

step("main window is shown", function()
  expect(main, "MDT.main_frame was not created")
  expect(main:IsVisible(), "main window is not visible")
  expect(MDT:AreFramesInitialized(), "frames not initialized")
  snapshot("main window")
end)

local function click(widget, button)
  local frame = widget.frame or widget
  expect(frame:IsVisible(), "clicked a hidden widget: "..tostring(frame:GetName() or frame:GetObjectType()))
  W.userClick(frame, button)
end

local function typeInto(widget, text)
  local editbox = widget.editbox or widget
  editbox:SetFocus()
  editbox:SetText(text)
end

local function pulls() return MDT:GetCurrentPreset().value.pulls end
local function unusedPresetName(base)
  local taken = {}
  for _, preset in pairs(db.presets[db.currentDungeonIdx]) do taken[preset.text] = true end
  local name, suffix = base, 1
  while taken[name] do
    suffix = suffix + 1
    name = base.." "..suffix
  end
  return name
end

local function presetCount()
  local count = 0
  for _, preset in pairs(db.presets[db.currentDungeonIdx]) do
    if preset.value ~= 0 then count = count + 1 end
  end
  return count
end

step("switch dungeon via dungeon button", function()
  local before = db.currentDungeonIdx
  local button = _G.MDTDungeonButton2
  expect(button and button:IsVisible(), "dungeon button 2 is not visible")
  click(button)
  expect(db.currentDungeonIdx == button.dungeonIdx and db.currentDungeonIdx ~= before, "dungeon did not change")
end)

dofile(root.."/scripts/headless/sidebar_steps.lua")({
  W = W, MDT = MDT, step = step, expect = expect, click = click, asyncIdle = asyncIdle,
  typeInto = typeInto, unusedPresetName = unusedPresetName, presetCount = presetCount,
})

for _, section in ipairs(MDT:GetNavigationSections()) do
  step("open navigation section "..section.key, function()
    click(main.navigationSidebar.buttons[section.key])
    expect(MDT:GetCurrentSection() == section.key, "current section is "..tostring(MDT:GetCurrentSection()))
    local content = main.sectionContentFrames[section.key]
    if content then expect(content:IsVisible(), "section content frame is hidden") end
    expect(MDT:GetSidebarControl("pulls"):IsVisible() == (section.key == "maps"), "sidebar visibility is wrong in section "..section.key)
    snapshot("section "..section.key)
  end)
end

step("return to the maps section", function()
  click(main.navigationSidebar.buttons.maps)
  expect(MDT:IsMapSectionActive(), "maps section not active")
  expect(main.mapPanelFrame:IsVisible(), "map panel hidden after returning to maps")
end)

step("clear dialog opens and cancels", function()
  MDT:OpenClearPresetDialog()
  expect(main.ClearConfirmationFrame.frame:IsVisible(), "clear dialog not shown")
  click(main.ClearConfirmationFrame.CancelButton)
  expect(not main.ClearConfirmationFrame.frame:IsVisible(), "clear dialog still shown")
end)

dofile(root.."/scripts/headless/kit_gallery.lua")({
  W = W, MDT = MDT, step = step, expect = expect, click = click, asyncIdle = asyncIdle, render = render,
})
dofile(root.."/scripts/headless/kit_list_steps.lua")({
  W = W, MDT = MDT, step = step, expect = expect, click = click, asyncIdle = asyncIdle,
})
dofile(root.."/scripts/headless/section_pages_steps.lua")({
  W = W, MDT = MDT, step = step, expect = expect, click = click, asyncIdle = asyncIdle, render = render,
})
dofile(root.."/scripts/headless/chrome_steps.lua")({ W = W, MDT = MDT, step = step, expect = expect, click = click, asyncIdle = asyncIdle, render = render })
dofile(root.."/scripts/headless/enemy_info_steps.lua")({
  W = W, MDT = MDT, step = step, expect = expect, click = click, asyncIdle = asyncIdle, render = render, developer = flags.developer == true,
})

step("hover every visible widget", function()
  local hovered = 0
  for _, object in ipairs(W.objects) do
    local state = W.state[object]
    if state.isFrame and state.scripts.OnEnter and W.isVisible(object) then
      W.fireScript(object, "OnEnter")
      W.fireScript(object, "OnLeave")
      hovered = hovered + 1
    end
  end
  expect(hovered > 20, "only "..hovered.." hoverable widgets found")
end)

step("close button hides the main window", function()
  click(main.closeButton)
  expect(not main:IsShown(), "main window still shown")
end)

step("MythicDungeonToolsAPI:ShowInterface shows the main window again", function()
  _G.MythicDungeonToolsAPI:ShowInterface()
  W.settle(asyncIdle, 30)
  expect(main:IsVisible(), "main window not shown")
end)

step("maximize", function()
  click(main.maximizeButton)
  expect(db.maximized == true, "db.maximized not set")
end)

step("restore from maximized", function()
  click(main.maximizeButton)
  expect(db.maximized == false, "db.maximized still set")
end)

step("conflict dialog opens on the kit and Escape closes it, not the window", function()
  MDT:ShowConflictFrame()
  local dialog = MDT.UI.Dialogs.Get("addonConflict")
  expect(dialog and dialog:IsVisible(), "conflict dialog not shown")
  expect(dialog:GetParent() == MDT.UI.Root, "conflict dialog is not on the UI root")
  snapshot("conflict dialog", dialog)
  expect(CloseSpecialWindows(), "no special window closed")
  expect(not dialog:IsShown() and MDT.UI.Dialogs.Get("addonConflict") == nil, "Escape did not close the conflict dialog")
  expect(main:IsShown(), "Escape closed the main window instead of the dialog")
  W.settle(asyncIdle, 5)
  MDT:ShowConflictFrame()
  click(MDT.UI.Dialogs.Get("addonConflict").closeButton)
  expect(MDT.UI.Dialogs.Get("addonConflict") == nil, "X did not close the conflict dialog")
end)

step("pre-patch warning opens through its real trigger, copies a link, and Escape closes it first", function()
  local realTime = _G.time
  _G.time = function() return 1768950035 + 1 end
  db.prePatchWarningSeenFor = nil
  MDT:SetupPrePatchWarning()
  _G.time = realTime
  local dialog = rawget(_G, "MDTPrePatchWarningFrame")
  expect(dialog and dialog:IsVisible(), "pre-patch warning not shown")
  expect(db.prePatchWarningSeenFor == 1768950035, "pre-patch warning was not marked as seen")
  snapshot("pre-patch warning", dialog)
  local editBox, copyButton
  for _, child in ipairs(dialog.content.kitChildren) do
    if child.kit.name == "Row" then editBox, copyButton = child.kitChildren[1], child.kitChildren[2] end
  end
  expect(editBox and editBox:GetValue():find("legacy", 1, true), "link row is missing its url")
  click(copyButton)
  expect(editBox.kitEdit:HasFocus() and copyButton:IsDisabled(), "copy did not focus the link")
  expect(MDT.copyHelper:IsShown(), "copy helper hint not shown")
  W.modifiers = { ctrl = true }
  W.fireScript(editBox.kitEdit, "OnKeyUp", "C")
  W.modifiers = nil
  expect(not editBox.kitEdit:HasFocus() and not copyButton:IsDisabled(), "Ctrl+C did not finish the copy flow")
  MDT:SetupPrePatchWarning()
  expect(rawget(_G, "MDTPrePatchWarningFrame") == dialog, "a seen warning was shown again")
  expect(CloseSpecialWindows(), "no special window closed")
  expect(rawget(_G, "MDTPrePatchWarningFrame") == nil and not dialog:IsShown(), "Escape did not close the pre-patch warning")
  expect(main:IsShown(), "Escape closed the main window instead of the dialog")
  W.settle(asyncIdle, 5)
end)

step("escape closes the main window", function()
  render("final", main)
  expect(_G.CloseSpecialWindows(), "no special window closed")
  expect(not main:IsShown(), "main window still shown")
end)

step("PLAYER_LOGOUT leaves saved variables serializable", function()
  W.FireEvent("PLAYER_LOGOUT")
  local text = "MythicDungeonToolsDB = "..W.serialize(_G.MythicDungeonToolsDB, "MythicDungeonToolsDB", true).."\n"
  expect(loadstring(text), "serialized saved variables do not parse")
  if flags["write-savedvariables"] then
    local file = assert(io.open(flags["write-savedvariables"], "w"))
    file:write(text)
    file:close()
  end
end)

local function sortedEntries(map, order)
  local list = {}
  for _, name in ipairs(order) do list[#list + 1] = map[name] end
  table.sort(list, function(a, b) return a.count > b.count end)
  return list
end

local created, totalCreated = {}, 0
for className, count in pairs(W.created) do
  created[#created + 1] = className.."="..count
  totalCreated = totalCreated + count
end
table.sort(created)

io.write("\n== Summary ==\n")
io.write(("files loaded: %d\n"):format(#Loader.filesLoaded))
io.write(("objects created: %d (%s)\n"):format(totalCreated, table.concat(created, ", ")))
io.write(("steps: %d, captured errors: %d\n"):format(#steps, failures))
local missing = sortedEntries(W.missing, W.missingOrder)
io.write(("missing API: %d distinct\n"):format(#missing))
for _, entry in ipairs(missing) do
  local sites = {}
  for site, count in pairs(entry.sites) do sites[#sites + 1] = site.." x"..count end
  table.sort(sites)
  io.write(("  %-45s %5d  %s\n"):format(entry.name, entry.count, table.concat(sites, ", ", 1, math.min(3, #sites))))
end
local templates = sortedEntries(W.unknownTemplates, W.unknownTemplateOrder)
io.write(("unknown templates: %d\n"):format(#templates))
for _, entry in ipairs(templates) do io.write(("  %-45s %5d  %s\n"):format(entry.name, entry.count, entry.site)) end
local files = sortedEntries(W.missingFiles, W.missingFileOrder)
io.write(("texture paths with no file: %d\n"):format(#files))
for _, entry in ipairs(files) do io.write(("  %-60s %5d  %s\n"):format(entry.name, entry.count, entry.site)) end
if flags["undefined-globals"] then
  local globals = sortedEntries(W.undefinedGlobals, W.undefinedGlobalOrder)
  io.write(("undefined globals read: %d\n"):format(#globals))
  for _, entry in ipairs(globals) do io.write(("  %-45s %5d  %s\n"):format(entry.name, entry.count, entry.site)) end
end

if flags.dump then
  local path = flags.dump == true and "ui-dump.txt" or flags.dump
  local file = assert(io.open(path, "w"))
  file:write(table.concat(snapshots, "\n"), "\n")
  file:close()
  io.write(("frame tree snapshot: %s (%d lines)\n"):format(path, #snapshots))
end

for _, page in ipairs(renders) do
  io.write(("render: %s %dx%d, %d items (%d fills, %d images, %d placeholders, %d texts, %d lines), %d unresolved\n"):format(
    page.path, page.width, page.height, page.items, page.fills, page.images, page.placeholders, page.texts, page.lines, page.unresolved))
  if W.verbose and page.unresolved > 0 then io.write("  unresolved: ", table.concat(page.unresolvedNames, ", "), "\n") end
end

if failures > 0 then
  io.write("\nFAILED: ", failures, " captured error(s)\n")
  os.exit(1)
end
io.write("\nPASSED\n")
