-- Plain Lua 5.1 tests for the pure part of the MDT UI kit: Kit/Pure/*, Theme data, Fonts.Plan and the token aliases.
-- Run: lua5.1 scripts/test_kit.lua [repoRoot]
local root = arg and arg[1] or "."
local kitDir = root.."/MythicDungeonTools_UI/Kit/"

-- Pure files get the Lua standard library and a stub MDT. Reading any other global (a WoW API) fails the load.
local allowed = {
  math = math, string = string, table = table, pairs = pairs, ipairs = ipairs, type = type, tostring = tostring,
  tonumber = tonumber, select = select, unpack = unpack, error = error, assert = assert, setmetatable = setmetatable,
  getmetatable = getmetatable, next = next, rawget = rawget, rawset = rawset, pcall = pcall,
}
local MDT = {}
local function loadPure(path)
  local chunk = assert(loadfile(kitDir..path))
  local env = setmetatable({}, {
    __index = function(_, key)
      if allowed[key] ~= nil then return allowed[key] end
      error(path.." read global '"..tostring(key).."'", 2)
    end,
    __newindex = function(_, key) error(path.." wrote global '"..tostring(key).."'", 2) end,
  })
  setfenv(chunk, env)
  chunk("MythicDungeonTools_UI", MDT)
end

local pureFiles = { "Pure/Color.lua", "Pure/Text.lua", "Pure/Layout.lua", "Pure/ListMath.lua", "Pure/Selection.lua", "Pure/MenuModel.lua", "Theme.lua", "Fonts.lua" }
for _, path in ipairs(pureFiles) do loadPure(path) end
loadPure("../../Modules/SidebarModel.lua")
loadPure("../../Modules/PullLabelLayout.lua")
local UI = MDT.UI
local Model = MDT.SidebarModel

local passed, failed = 0, 0
local function describe(value)
  if type(value) ~= "table" then return tostring(value) end
  local parts = {}
  local keys = {}
  for key in pairs(value) do keys[#keys + 1] = key end
  table.sort(keys, function(a, b) return tostring(a) < tostring(b) end)
  for _, key in ipairs(keys) do parts[#parts + 1] = tostring(key).."="..describe(value[key]) end
  return "{"..table.concat(parts, ", ").."}"
end
local function same(a, b)
  if type(a) ~= type(b) then return false end
  if type(a) ~= "table" then
    if type(a) == "number" then return math.abs(a - b) < 1e-6 end
    return a == b
  end
  for key, value in pairs(a) do if not same(value, b[key]) then return false end end
  for key in pairs(b) do if a[key] == nil then return false end end
  return true
end
local function eq(actual, expected, label)
  if not same(actual, expected) then
    error((label or "value").." expected "..describe(expected).." got "..describe(actual), 2)
  end
end
local function test(name, fn)
  local ok, err = pcall(fn)
  if ok then
    passed = passed + 1
  else
    failed = failed + 1
    io.write("FAIL ", name, "\n  ", tostring(err), "\n")
  end
end

test("Color: hex round trip, mix, lighten, alpha", function()
  eq(UI.Color.FromHex("#ffd100"), { 1, 209 / 255, 0, 1 })
  eq(UI.Color.FromHex("00000099"), { 0, 0, 0, 153 / 255 })
  eq(UI.Color.ToHex({ 1, 209 / 255, 0 }), "ffd100")
  eq(UI.Color.Mix({ 0, 0, 0, 1 }, { 1, 1, 1, 1 }, 0.25), { 0.25, 0.25, 0.25, 1 })
  eq(UI.Color.Lighten({ 0, 0.5, 1, 1 }, 0.5), { 0.5, 0.75, 1, 1 })
  eq(UI.Color.Darken({ 1, 1, 1, 1 }, 0.5), { 0.5, 0.5, 0.5, 1 })
  eq(UI.Color.WithAlpha({ 1, 0, 0, 1 }, 0.3), { 1, 0, 0, 0.3 })
  eq(UI.Color.Escape({ 1, 0, 0 }, "x"), "|cffff0000x|r")
end)

test("Text: alphabet detection, length, truncate, matches", function()
  eq(UI.Strings.Alphabet("Route 3 / Nnoggie"), "roman")
  eq(UI.Strings.Alphabet("Ünïcode Ł"), "roman")
  eq(UI.Strings.Alphabet("Маршрут 3"), "cyrillic")
  eq(UI.Strings.Alphabet("경로 3"), "hangul")
  eq(UI.Strings.Alphabet("路线 3"), "cjk")
  eq(UI.Strings.Alphabet("ルート"), "cjk")
  eq(UI.Strings.Alphabet("Route Маршрут"), "cyrillic")
  eq(UI.Strings.Length("Маршрут"), 7)
  eq(UI.Strings.Truncate("Маршрут", 3), "Мар...")
  eq(UI.Strings.Truncate("abc", 3), "abc")
  eq(UI.Strings.Matches("Nnoggie Route", "ROUTE"), true)
  eq(UI.Strings.Matches("Nnoggie Route", "x"), false)
end)

test("Layout.Stack: stretch, gap, pad, hidden, grow", function()
  local rects, total = UI.Layout.Stack({ { h = 10 }, { h = 20, hidden = true }, { h = 30, w = 40 } }, { width = 100, gap = 4, pad = 8 })
  eq(rects[1], { x = 8, y = 8, w = 84, h = 10 })
  eq(rects[2], false)
  eq(rects[3], { x = 8, y = 22, w = 40, h = 30 })
  eq(total, 60)
  local grown = UI.Layout.Stack({ { h = 10 }, { h = 10, grow = 1 }, { h = 10, grow = 3 } }, { width = 50, height = 110, gap = 0 })
  eq(grown[2].h, 30)
  eq(grown[3].h, 70)
  local centered = UI.Layout.Stack({ { h = 10, w = 20 } }, { width = 100, align = "center" })
  eq(centered[1].x, 40)
  local _, empty = UI.Layout.Stack({}, { width = 100, pad = 5 })
  eq(empty, 10)
end)

test("Layout.Row: natural widths, wrap, grow, align, valign", function()
  local rects, total = UI.Layout.Row({ { w = 30, h = 10 }, { w = 30, h = 20 }, { w = 30, h = 10 } }, { width = 70, gap = 5, wrap = true })
  eq(rects[1], { x = 0, y = 5, w = 30, h = 10 })
  eq(rects[2], { x = 35, y = 0, w = 30, h = 20 })
  eq(rects[3], { x = 0, y = 25, w = 30, h = 10 })
  eq(total, 35)
  local grown = UI.Layout.Row({ { w = 20, h = 10 }, { w = 20, h = 10, grow = 1 } }, { width = 100, gap = 0 })
  eq(grown[2], { x = 20, y = 0, w = 80, h = 10 })
  local ended = UI.Layout.Row({ { w = 20, h = 10 } }, { width = 100, align = "end" })
  eq(ended[1].x, 80)
  local spread = UI.Layout.Row({ { w = 10, h = 10 }, { w = 10, h = 10 }, { w = 10, h = 10 } }, { width = 100, align = "spread" })
  eq(spread[2].x, 45)
  eq(spread[3].x, 90)
  local stretched = UI.Layout.Row({ { w = 10, h = 10 }, { w = 10, h = 30 } }, { width = 100, valign = "stretch" })
  eq(stretched[1].h, 30)
  local hidden = UI.Layout.Row({ { w = 10, h = 10, hidden = true }, { w = 10, h = 10 } }, { width = 100, gap = 4 })
  eq(hidden[1], false)
  eq(hidden[2].x, 0)
end)

test("Layout.Columns: weights, gap, rounding to the last column", function()
  eq(UI.Layout.Columns(100, { 1, 2 }, 10), { { x = 0, w = 30 }, { x = 40, w = 60 } })
  eq(UI.Layout.Columns(100, { 1, 1, 1 }, 0), { { x = 0, w = 33 }, { x = 33, w = 33 }, { x = 66, w = 34 } })
  eq(UI.Layout.Columns(50, { 1 }, 8), { { x = 0, w = 50 } })
end)

test("ListMath.Offsets and VisibleRange", function()
  local tops, total = UI.ListMath.Offsets({ 10, 20, 30 }, 2)
  eq(tops, { 0, 12, 34 })
  eq(total, 64)
  local heights = {}
  for i = 1, 100 do heights[i] = 28 end
  local manyTops = UI.ListMath.Offsets(heights, 0)
  eq({ UI.ListMath.VisibleRange(manyTops, heights, 0, 100, 0) }, { 1, 4 })
  eq({ UI.ListMath.VisibleRange(manyTops, heights, 28, 100, 0) }, { 2, 5 })
  eq({ UI.ListMath.VisibleRange(manyTops, heights, 30, 100, 1) }, { 1, 6 })
  eq({ UI.ListMath.VisibleRange(manyTops, heights, 2800, 100, 0) }, { 1, 0 })
  eq({ UI.ListMath.VisibleRange({}, {}, 0, 100, 0) }, { 1, 0 })
  eq({ UI.ListMath.VisibleRange(manyTops, heights, 2772, 100, 0) }, { 100, 100 })
end)

test("ListMath.DropSlot: midpoint rule, non-draggable rows, no-op block", function()
  local rows = {
    { top = 0, height = 20, draggable = true },
    { top = 20, height = 20, draggable = true, dragged = true },
    { top = 40, height = 20, draggable = true, dragged = true },
    { top = 60, height = 10, draggable = false },
    { top = 70, height = 20, draggable = true },
    { top = 90, height = 20, draggable = false },
  }
  eq({ UI.ListMath.DropSlot(5, rows) }, { 1, 0, false })
  eq({ UI.ListMath.DropSlot(15, rows) }, { 2, 20, true })
  eq({ UI.ListMath.DropSlot(55, rows) }, { 4, 70, true })
  eq({ UI.ListMath.DropSlot(65, rows) }, { 4, 70, true })
  eq({ UI.ListMath.DropSlot(85, rows) }, { 5, 90, false })
  eq({ UI.ListMath.DropSlot(95, rows) }, { 5, 90, false })
  eq({ UI.ListMath.DropSlot(500, rows) }, { 5, 90, false })
  local scattered = {
    { top = 0, height = 20, draggable = true, dragged = true },
    { top = 20, height = 20, draggable = true },
    { top = 40, height = 20, draggable = true, dragged = true },
  }
  eq({ UI.ListMath.DropSlot(5, scattered) }, { 1, 0, false })
  eq({ UI.ListMath.DropSlot(5, {}) }, { 1, 0, false })
end)

test("ListMath.AutoScroll: ramps inside the edge band, zero in the middle", function()
  eq(UI.ListMath.AutoScroll(50, 100, 20, 600), 0)
  eq(UI.ListMath.AutoScroll(10, 100, 20, 600), -300)
  eq(UI.ListMath.AutoScroll(0, 100, 20, 600), -600)
  eq(UI.ListMath.AutoScroll(-50, 100, 20, 600), -600)
  eq(UI.ListMath.AutoScroll(95, 100, 20, 600), 450)
  eq(UI.ListMath.AutoScroll(140, 100, 20, 600), 600)
  eq(UI.ListMath.AutoScroll(0, 100, 0, 600), 0)
end)

test("ListMath.Reorder: block moves, insert-before semantics, no-op detection", function()
  eq({ UI.ListMath.Reorder({ "a", "b", "c", "d" }, { "b" }, 1) }, { { "b", "a", "c", "d" }, true })
  eq({ UI.ListMath.Reorder({ "a", "b", "c", "d" }, { "a" }, 5) }, { { "b", "c", "d", "a" }, true })
  eq({ UI.ListMath.Reorder({ "a", "b", "c", "d" }, { "b", "d" }, 1) }, { { "b", "d", "a", "c" }, true })
  eq({ UI.ListMath.Reorder({ "a", "b", "c", "d" }, { "a", "b" }, 4) }, { { "c", "a", "b", "d" }, true })
  eq({ UI.ListMath.Reorder({ "a", "b", "c", "d" }, { "b", "c" }, 2) }, { { "a", "b", "c", "d" }, false })
  eq({ UI.ListMath.Reorder({ "a", "b", "c", "d" }, { "b", "c" }, 4) }, { { "a", "b", "c", "d" }, false })
  eq({ UI.ListMath.Reorder({ "a", "b", "c", "d" }, { "d", "b" }, 3) }, { { "a", "b", "d", "c" }, true })
  eq({ UI.ListMath.Reorder({}, {}, 1) }, { {}, false })
end)

test("ListMath.ScrollTo", function()
  local tops, heights = { 0, 20, 40, 60 }, { 20, 20, 20, 20 }
  eq(UI.ListMath.ScrollTo(tops, heights, 0, 50, 4, "nearest"), 30)
  eq(UI.ListMath.ScrollTo(tops, heights, 30, 50, 1, "nearest"), 0)
  eq(UI.ListMath.ScrollTo(tops, heights, 0, 50, 2, "nearest"), 0)
  eq(UI.ListMath.ScrollTo(tops, heights, 0, 50, 3, "top"), 40)
  eq(UI.ListMath.ScrollTo(tops, heights, 0, 50, 3, "center"), 25)
  eq(UI.ListMath.ScrollTo(tops, heights, 7, 50, 9), 7)
end)

test("Selection.Click: fixtures lifted from the pull button's OnClickNormal", function()
  local Click = UI.Selection.Click
  eq(Click({ 2, 5 }, 3, {}), { 3 }, "plain click selects only the row")
  eq(Click({ 2 }, 4, { ctrl = true }), { 2, 4 }, "ctrl adds")
  eq(Click({ 2, 4 }, 2, { ctrl = true }), { 4 }, "ctrl removes")
  eq(Click({ 2 }, 2, { ctrl = true }), {}, "ctrl can empty the selection")
  eq(Click({ 2 }, 5, { shift = true }), { 2, 3, 4, 5 }, "shift extends down from the last entry")
  eq(Click({ 5 }, 2, { shift = true }), { 5, 4, 3, 2 }, "shift extends up from the last entry")
  eq(Click({ 1, 4 }, 2, { shift = true }), { 1, 4, 3, 2 }, "shift anchors on the last clicked entry")
  eq(Click({ 2, 3 }, 3, { shift = true }), { 2, 3 }, "shift onto the anchor keeps the selection")
  eq(Click({}, 3, { shift = true }), { 3 }, "shift with nothing selected acts as a plain click")
  eq(Click({ 2 }, 4, { button = "RightButton" }), { 4 }, "right-click on a single selection moves it")
  eq(Click({ 2, 3 }, 4, { button = "RightButton" }), { 2, 3, 4 }, "right-click adds to a multi selection")
  eq(Click({ 2, 3 }, 3, { button = "RightButton" }), { 2, 3 }, "right-click inside the selection keeps it")
  local input = { 1, 2 }
  Click(input, 3, { ctrl = true })
  eq(input, { 1, 2 }, "input is never mutated")
end)

test("MenuModel.Normalize: defaults, separators, orphan titles, checked from value", function()
  local items = UI.MenuModel.Normalize({
    { kind = "separator" },
    { kind = "title", text = "Group" },
    { text = "A", onSelect = function() end },
    { kind = "separator" },
    { kind = "separator" },
    { kind = "choice", text = "B", value = 2 },
    { kind = "title", text = "Empty" },
    { kind = "separator" },
  }, 2)
  eq(#items, 4)
  eq(items[1].kind, "title")
  eq(items[2].kind, "action")
  eq(items[2].key, 3)
  eq(items[3].kind, "separator")
  eq(items[4].checked, true)
  eq(type(items[4].sig), "string")
  local expanded = UI.MenuModel.Normalize(function() return { false, { text = "X", onSelect = function() end } } end)
  eq(#expanded, 1)
  eq(UI.MenuModel.Normalize({ { kind = "title", text = "lonely" } }), {})
  local differentSig = UI.MenuModel.Normalize({ { kind = "choice", text = "B", value = 2 } }, 3)
  eq(differentSig[1].checked, false)
  eq(differentSig[1].sig ~= items[4].sig, true, "sig tracks checked state")
end)

test("MenuModel.Filter, Validate, FromList, LabelFor", function()
  local items = {
    { kind = "title", text = "Mine" }, { kind = "choice", text = "Route one", detail = "Nnoggie", value = 1 },
    { kind = "separator" }, { kind = "title", text = "Others" }, { kind = "choice", text = "Other", detail = "Zed", value = 2 },
  }
  local filtered = UI.MenuModel.Filter(items, "nnog")
  eq(#filtered, 2)
  eq(filtered[1].text, "Mine")
  eq(filtered[2].text, "Route one")
  eq(#UI.MenuModel.Filter(items, ""), 5)
  eq(#UI.MenuModel.Filter(items, "zzz"), 0)
  eq({ UI.MenuModel.Validate(items) }, { true })
  eq((UI.MenuModel.Validate({ { kind = "bogus", text = "x" } })), false)
  eq((UI.MenuModel.Validate({ { text = "x" } })), false)
  eq((UI.MenuModel.Validate({ { kind = "submenu", text = "x" } })), false)
  local fromList = UI.MenuModel.FromList({ a = "Zeta", b = "Alpha" })
  eq(fromList[1].text, "Alpha")
  eq(fromList[2].value, "a")
  local ordered = UI.MenuModel.FromList({ a = "Zeta", b = "Alpha" }, { "a", "b" })
  eq(ordered[1].value, "a")
  eq(ordered[1].kind, "choice")
  eq(UI.MenuModel.LabelFor(items, 2), "Other")
  eq(UI.MenuModel.LabelFor(items, 9), nil)
end)

test("Fonts.Plan: client alphabet first, every alphabet present, CJK heights scaled", function()
  local roles = { body = { size = 12 }, title = { size = 15 } }
  local expectedFirst = { enUS = "roman", deDE = "roman", frFR = "roman", ruRU = "russian", koKR = "korean", zhCN = "simplifiedchinese", zhTW = "traditionalchinese" }
  for locale, first in pairs(expectedFirst) do
    local plan = UI.Fonts.Plan(locale, roles)
    for role, members in pairs(plan) do
      eq(#members, 5, locale.." "..role.." member count")
      eq(members[1].alphabet, first, locale.." first member")
      local seen = {}
      for _, member in ipairs(members) do
        seen[member.alphabet] = true
        eq(member.flags, "")
        if member.alphabet == "roman" then
          eq(member.file, "Interface\\AddOns\\MythicDungeonTools\\Fonts\\ArchivoNarrow-Bold.ttf")
          eq(member.height, roles[role].size)
        elseif member.alphabet == "russian" then
          eq(member.height, roles[role].size)
        else
          eq(member.height, math.floor(roles[role].size * 1.05 + 0.5), locale.." "..member.alphabet.." height")
        end
      end
      eq(seen, { roman = true, russian = true, korean = true, simplifiedchinese = true, traditionalchinese = true })
    end
  end
end)

test("Fonts.FallbackAlphabet: only when the client font lacks the glyphs", function()
  local F = UI.Fonts.FallbackAlphabet
  eq(F("Маршрут", "enUS"), "russian")
  eq(F("Маршрут", "ruRU"), nil)
  eq(F("경로", "enUS"), "korean")
  eq(F("경로", "koKR"), nil)
  eq(F("路线", "enUS"), "simplifiedchinese")
  eq(F("路线", "zhTW"), nil)
  eq(F("路线", "zhCN"), nil)
  eq(F("路线", "koKR"), "simplifiedchinese")
  eq(F("Route", "koKR"), nil)
  eq(F("", "enUS"), nil)
end)

test("Theme: tokens resolve, derived colors, skins reference known tokens", function()
  eq({ UI.Theme.Resolve("accent") }, { 1, 1, 1, 1 })
  eq({ UI.Theme.Resolve({ 0.1, 0.2, 0.3 }) }, { 0.1, 0.2, 0.3, 1 })
  eq(select(4, UI.Theme.Resolve("bg.dim")), 153 / 255)
  local r = UI.Theme.Resolve("bg.hover")
  local base = UI.Theme.Resolve("bg.raised2")
  eq(r > base, true, "hover is lighter than its base")
  eq(UI.Theme.Space("md"), 8)
  eq(UI.Theme.Space(3), 3)
  eq(UI.Theme.Space(nil), 0)
  eq(UI.Theme.Size("row"), 28)
  eq(pcall(UI.Theme.Resolve, "nope"), false)
  eq(pcall(UI.Theme.Space, "nope"), false)
  local resolved = UI.Theme.ResolveAll(UI.Theme.data)
  for variant, states in pairs(UI.Theme.data.skin) do
    for state, row in pairs(states) do
      for _, part in ipairs({ "bg", "border", "text" }) do
        local token = row[part]
        if token ~= false then
          eq(resolved[token] ~= nil, true, "skin "..variant.."."..state.."."..part.." = "..tostring(token))
        end
      end
      eq(UI.Theme.Skin(variant, state), row)
    end
    eq(states.normal ~= nil, true, variant.." needs a normal row")
  end
  eq(UI.Theme.Skin("default", "bogus"), UI.Theme.data.skin.default.normal)
end)

test("Types.lua aliases match the theme tables", function()
  local file = assert(io.open(kitDir.."Types.lua", "rb"))
  local source = file:read("*a"):gsub("\r\n", "\n")
  file:close()
  local function aliasValues(name)
    local block = source:match("%-%-%-@alias "..name:gsub("%.", "%%.").."\n(.-)\n\n")
    assert(block, "alias "..name.." not found in Types.lua")
    local values = {}
    for value in block:gmatch('%-%-%-|%s*"([^"]+)"') do values[value] = true end
    return values
  end
  local function keysOf(...)
    local keys = {}
    for _, map in ipairs({ ... }) do for key in pairs(map) do keys[key] = true end end
    return keys
  end
  eq(aliasValues("MDT.UI.ColorToken"), keysOf(UI.Theme.data.color, UI.Theme.data.derived), "ColorToken alias")
  eq(aliasValues("MDT.UI.Space"), keysOf(UI.Theme.data.space), "Space alias")
  eq(aliasValues("MDT.UI.ControlSize"), keysOf(UI.Theme.data.size), "ControlSize alias")
  eq(aliasValues("MDT.UI.FontRole"), keysOf(UI.Theme.data.font), "FontRole alias")
  eq(aliasValues("MDT.UI.Variant"), keysOf(UI.Theme.data.skin), "Variant alias")
end)


local L = setmetatable({}, { __index = function(_, key) return key end })

local function fixtureEnemies()
  return {
    [1] = { id = 100, name = "Grunt", displayId = 11, count = 5, health = 1000, level = 72, creatureType = "Humanoid",
      clones = { [1] = {}, [2] = {}, [3] = { count = 8 } } },
    [2] = { id = 200, name = "Boss", displayId = 22, count = 0, health = 5000, isBoss = true, clones = { [1] = {} } },
    [3] = { id = 300, name = "Imp", displayId = 33, count = 3, health = 200, clones = { [1] = {}, [2] = {} } },
    [4] = { id = 400, name = "Rat", displayId = 44, count = 1, health = 50, clones = { [1] = {} } },
  }
end

local function fixtureContext(overrides)
  local ctx = {
    enemies = fixtureEnemies(), totalForces = 20, level = 22, useForcesCount = false, showHealth = false,
    healthOf = function(enemy) return enemy.health * 2 end,
    formatHealth = function(health) return health.."hp" end,
    pullColor = function(index) return index / 10, 0, 0 end,
    authorColor = function(createdBy) return createdBy and createdBy.classIdx == 8 and { 0, 0.5, 1 } or nil end,
    player = { name = "Me", realm = "Realm" },
    presets = {
      { text = "Default", value = { pulls = { {} } } },
      { text = "Mine", value = { pulls = { { [1] = { 1 } } } }, createdBy = { name = "Me", realm = "Realm", classIdx = 8 }, difficulty = 12, uid = "mine" },
      { text = "Theirs", value = { pulls = { { [1] = { 1, 2, 3 }, [3] = { 1, 2 } } } }, createdBy = { name = "Zed", realm = "Other", classIdx = 8 }, uid = "theirs" },
      { text = "<New Preset>", value = 0 },
    },
    presetIdx = 2, liveActive = false, livePresetUID = nil, inGroup = false, busy = false,
  }
  for key, value in pairs(overrides or {}) do ctx[key] = value end
  return ctx
end

local function fixturePreset()
  return {
    text = "Route 3", uid = "mine", createdBy = { name = "Me", realm = "Realm", classIdx = 8 },
    value = { pulls = {
      { [1] = { 1, 2 }, color = "ff0000" },
      { [1] = { 3 }, [3] = { 1, 2 } },
      { [2] = { 1 } },
      { [1] = { 1 } },
    } },
  }
end

test("SidebarModel: percent, forces tone and total text follow the old progress bar", function()
  eq(Model.FormatPercent(735, 729), "100.8%")
  eq(Model.FormatPercent(0, 0), "0.0%")
  eq(Model.FormatForcesTotal(735, 729), "735/729 (100.82%)")
  eq(Model.ForcesTone(700, 729), "text.normal")
  eq(Model.ForcesTone(729, 729), "ok")
  eq(Model.ForcesTone(735, 729), "ok", "100.8% is green")
  eq(Model.ForcesTone(740, 729), "ok", "101.5% is green")
  eq(Model.ForcesTone(307, 300), "ok", "102.3% but only 7 over stays green")
  eq(Model.ForcesTone(745, 729), "warn", "102.2% and 16 over is red")
  eq(Model.ForcesTone(5, 0), "text.normal")
end)

test("SidebarModel.SummarizePull: groups clones by enemy and per-clone forces, sorted by forces", function()
  local ctx = fixtureContext()
  local forces, portraits, isBoss, health = Model.SummarizePull({ [1] = { 3, 1 }, [3] = { 1, 2 }, color = "ff0000" }, ctx)
  eq(forces, 8 + 5 + 3 + 3)
  eq(isBoss, false)
  eq(health, 2000 * 2 + 400 * 2)
  eq(#portraits, 3)
  eq({ portraits[1].enemyIdx, portraits[1].count, portraits[1].quantity }, { 1, 8, 1 })
  eq({ portraits[2].enemyIdx, portraits[2].count, portraits[2].quantity }, { 1, 5, 1 })
  eq({ portraits[3].enemyIdx, portraits[3].count, portraits[3].quantity, portraits[3].displayId, portraits[3].name }, { 3, 3, 2, 33, "Imp" })
  local bossForces, bossPortraits, bossFlag = Model.SummarizePull({ [2] = { 1 } }, ctx)
  eq({ bossForces, #bossPortraits, bossFlag, bossPortraits[1].isBoss }, { 0, 1, true, true })
  local missing = Model.SummarizePull({ [9] = { 1 }, [1] = { 99 } }, ctx)
  eq(missing, 0, "unknown enemies and clones are skipped")
  local many = {}
  for i = 1, 9 do many[i] = { 1 } end
  local ctxMany = fixtureContext({ enemies = {} })
  for i = 1, 9 do ctxMany.enemies[i] = { id = i, count = 10 - i, health = 10, clones = { [1] = {} } } end
  local _, capped = Model.SummarizePull(many, ctxMany)
  eq(#capped, 7, "at most seven portraits")
  eq(capped[1].enemyIdx, 1, "the largest forces come first")
end)

test("SidebarModel.Build: rows, cumulative text, the pull that completes forces, header", function()
  local ctx = fixtureContext()
  local state = Model.Build(fixturePreset(), ctx)
  local items = state.items
  eq(#items, 5, "4 pulls and the new-pull row; row index == pull index")
  eq({ items[1].kind, items[1].key, items[1].index, items[1].forces, items[1].cumulative }, { "pull", 1, 1, 10, 10 })
  eq({ items[1].pullText, items[1].cumulativeText, items[1].healthText }, { "+50.0%", "50.0%", nil })
  eq(items[1].color, { 0.1, 0, 0 })
  eq({ items[2].forces, items[2].cumulative, items[2].pullText, items[2].cumulativeText }, { 14, 24, "+70.0%", "120.0%" })
  eq({ items[1].completes, items[2].completes, items[3].completes }, { false, true, false }, "pull 2 crosses the total")
  eq({ items[3].kind, items[3].index, items[3].isBoss, items[3].pullText, items[3].cumulativeText }, { "pull", 3, true, "", "120.0%" })
  eq({ items[4].kind, items[4].index, items[4].cumulative }, { "pull", 4, 29 })
  eq({ items[5].kind, items[5].key }, { "newPull", "new" })
  eq(items[1].sig ~= items[2].sig, true)
  eq(Model.Build(fixturePreset(), ctx).items[2].sig, items[2].sig, "sig is stable across builds")
  local header = state.header
  eq({ header.author, header.route, header.level, header.isLiveRoute }, { "Me", "Route 3", 22, false })
  eq(header.authorColor, { 0, 0.5, 1 })
  eq({ header.forces.current, header.forces.max, header.forces.text, header.forces.tone }, { 29, 20, "29/20 (145.00%)", "warn" })
  eq(header.actions, { canDelete = true, canDeleteAll = true, canShare = false, canLive = false, shareBlocked = "noGroup", liveBlocked = "noGroup", liveActive = false, canSetLive = false, canReturnToLive = false })

  local overflow = Model.Build(fixturePreset(), fixtureContext({ totalForces = 729 }))
  eq(overflow.header.forces.tone, "text.normal")
  for _, item in ipairs(overflow.items) do eq(item.completes == true, false, "no pull completes when forces never reach the total") end

  local lastCompletes = fixturePreset()
  lastCompletes.value.pulls[4], lastCompletes.value.pulls[3] = nil, nil
  eq(Model.Build(lastCompletes, fixtureContext({ totalForces = 20 })).items[2].completes, false, "no marker when the completing pull is the last one")

  local counted = Model.Build(fixturePreset(), fixtureContext({ useForcesCount = true, showHealth = true }))
  eq({ counted.items[1].pullText, counted.items[1].cumulativeText, counted.items[1].healthText }, { "+10", "10", "4000hp" })
  eq(counted.items[3].healthText, "10000hp", "boss health shows even with no forces")
  eq(counted.items[3].sig ~= items[3].sig, true, "health text changes the sig")

  local live = Model.Build(fixturePreset(), fixtureContext({ liveActive = true, livePresetUID = "mine", inGroup = true }))
  eq(live.header.isLiveRoute, true)
  eq(live.header.actions, { canDelete = false, canDeleteAll = false, canShare = false, canLive = true, shareBlocked = "live", liveActive = true, livePresetIdx = 2, canSetLive = false, canReturnToLive = false })
  local elsewhere = Model.Build(fixturePreset(), fixtureContext({ liveActive = true, livePresetUID = "theirs", inGroup = true, busy = true }))
  eq(elsewhere.header.actions, { canDelete = false, canDeleteAll = false, canShare = false, canLive = true, shareBlocked = "live", liveActive = true, livePresetIdx = 3, canSetLive = true, canReturnToLive = true })
  local grouped = Model.Build(fixturePreset(), fixtureContext({ inGroup = true }))
  eq({ grouped.header.actions.canShare, grouped.header.actions.canLive }, { true, true })
  local default = Model.Build(fixturePreset(), fixtureContext({ presetIdx = 1 }))
  eq(default.header.actions.canDelete, false, "the default route cannot be deleted")
  local onlyDefault = Model.Build(fixturePreset(), fixtureContext({ presets = { { text = "Default", value = {} }, { text = "<New Preset>", value = 0 } } }))
  eq(onlyDefault.header.actions.canDeleteAll, false)
end)

-- The drop algorithm of MDT's pre-kit pull button, ported to arrays of pulls that carry an `id` option.
local function oldAddPull(pulls, index, data) table.insert(pulls, index, data or {}) end
local function oldDeletePull(pulls, index) table.remove(pulls, index) end
local function oldMergePulls(pulls, list, destination)
  if type(list) == "number" then list = { list, destination } end
  local newPull, removed = {}, {}
  local function countBelow(limit)
    local count = 0
    for _, entry in ipairs(removed) do if entry < limit then count = count + 1 end end
    return count
  end
  for _, pullIdx in ipairs(list) do
    local index = pullIdx - countBelow(pullIdx)
    for key, value in pairs(pulls[index]) do
      if not tostring(key):match("^%d+$") then newPull[key] = value end
    end
    oldDeletePull(pulls, index)
    removed[#removed + 1] = pullIdx
  end
  local index = destination - countBelow(destination)
  oldAddPull(pulls, index, newPull)
  return index
end
local function oldCopyPullOptions(pulls, sourceIdx, destinationIdx)
  local source, destination = pulls[sourceIdx], pulls[destinationIdx]
  if source and destination then
    for key, value in pairs(source) do
      if not tostring(key):match("^%d+$") then destination[key] = value end
    end
  end
end
local function oldDrop(pulls, selection, draggedIndex, insertID)
  if #selection > 1 then
    local selected = {}
    for i, index in ipairs(selection) do selected[i] = index end
    table.sort(selected)
    local newPulls, progressed = {}, {}
    local function countBelow(limit)
      local count = 0
      for _, entry in ipairs(progressed) do if entry < limit then count = count + 1 end end
      return count
    end
    for offset, pullIdx in ipairs(selected) do
      local pos = insertID + (offset - 1)
      pos = pos - countBelow(pos)
      local correct = pullIdx
      if pos > correct then correct = correct - countBelow(correct) end
      if pos <= correct then correct = correct + 1 end
      oldAddPull(pulls, pos)
      oldCopyPullOptions(pulls, correct, pos)
      newPulls[#newPulls + 1] = oldMergePulls(pulls, correct, pos)
      progressed[#progressed + 1] = pullIdx
    end
    return newPulls
  end
  local index = draggedIndex
  if index > insertID then index = index + 1 end
  oldAddPull(pulls, insertID)
  oldCopyPullOptions(pulls, index, insertID)
  return { oldMergePulls(pulls, index, insertID) }
end

local function ids(pulls)
  local list = {}
  for i, pull in ipairs(pulls) do list[i] = pull.id end
  return table.concat(list, ",")
end

-- A contiguous block dropped onto its own slot is a no-op the list never commits (ListMath.DropSlot flags it).
-- The old multi-drop reordered such a block anyway, which was a bug, so those cases are excluded from the comparison.
-- Moving a non-contiguous selection upward scrambled the order inside the block (old: {1,3} to the top gives 3,1,2);
-- the block still landed in the same positions, which is what the multi comparison checks. After a multi drop the old
-- code selected pull 1 (its new_pulls bookkeeping was wrong); the model selects the moved block.
test("SidebarModel.MovePulls: every committed single and multi drop matches the old pull button's drop algorithm", function()
  local cases, noops, scrambled = 0, 0, 0
  local function contains(list, value)
    for _, entry in ipairs(list) do if entry == value then return true end end
    return false
  end
  for n = 1, 6 do
    for mask = 1, 2 ^ n - 1 do
      local selection = {}
      for i = 1, n do
        if math.floor(mask / 2 ^ (i - 1)) % 2 == 1 then selection[#selection + 1] = i end
      end
      local contiguous = selection[#selection] - selection[1] + 1 == #selection
      for _, dragged in ipairs(selection) do
        for slot = 1, n + 1 do
          local pulls, reference = {}, {}
          for i = 1, n do
            pulls[i] = { id = i, [1] = { i } }
            reference[i] = { id = i, [1] = { i } }
          end
          local moved, newSelection, changed = Model.MovePulls(pulls, selection, slot)
          local label = ("n=%d selection=%s slot=%d"):format(n, table.concat(selection, ","), slot)
          if contiguous and slot >= selection[1] and slot <= selection[#selection] + 1 then
            eq({ ids(moved), changed }, { ids(pulls), false }, label.." is a no-op")
            noops = noops + 1
          else
            local oldSelection = oldDrop(reference, selection, dragged, slot)
            local blockPositions, oldBlockPositions = {}, {}
            for position, pull in ipairs(moved) do
              if contains(selection, pull.id) then blockPositions[#blockPositions + 1] = position end
            end
            for position, pull in ipairs(reference) do
              if contains(selection, pull.id) then oldBlockPositions[#oldBlockPositions + 1] = position end
            end
            if #selection == 1 then
              eq(ids(moved), ids(reference), label.." order")
              eq(newSelection, oldSelection, label.." selection")
            else
              eq(blockPositions, oldBlockPositions, label.." block lands where the old drop put it")
              if ids(moved) ~= ids(reference) then scrambled = scrambled + 1 end
            end
            eq(newSelection, blockPositions, label.." selects the moved block")
            eq(changed, true, label.." changed flag")
            cases = cases + 1
          end
        end
      end
    end
  end
  eq(cases > 400 and noops > 50, true, "covered "..cases.." drops and "..noops.." no-ops")
  eq(scrambled > 0, true, "the sweep must see the old upward multi-drop scramble")
  eq(select(3, Model.MovePulls({ { id = 1 }, { id = 2 }, { id = 3 } }, { 2 }, 2)), false, "a block dropped on itself is unchanged")
  eq(select(3, Model.MovePulls({ { id = 1 }, { id = 2 }, { id = 3 } }, { 2 }, 3)), false, "the slot right below the block is unchanged")
end)

test("SidebarModel.DeletePulls: removes the selection, keeps the last pull, picks the nearest survivor", function()
  local function pulls(n)
    local list = {}
    for i = 1, n do list[i] = { id = i } end
    return list
  end
  local remaining, select = Model.DeletePulls(pulls(5), { 2, 3 }, 3)
  eq({ ids(remaining), select }, { "1,4,5", 1 }, "nearest unselected pull above the anchor")
  remaining, select = Model.DeletePulls(pulls(5), { 1, 2 }, 2)
  eq({ ids(remaining), select }, { "3,4,5", 1 }, "nothing above: the first survivor below, shifted by the removals")
  remaining, select = Model.DeletePulls(pulls(5), { 3, 4 }, 4)
  eq({ ids(remaining), select }, { "1,2,5", 2 })
  remaining, select = Model.DeletePulls(pulls(5), { 3 }, 3)
  eq({ ids(remaining), select }, { "1,2,4,5", 2 }, "single delete selects the pull above")
  remaining, select = Model.DeletePulls(pulls(3), { 1, 2, 3 }, 2)
  eq({ ids(remaining), select }, { "3", 1 }, "the last remaining pull is never deleted")
  remaining, select = Model.DeletePulls(pulls(1), { 1 }, 1)
  eq({ ids(remaining), select }, { "1", 1 })
end)

local function labels(items)
  local list = {}
  for _, item in ipairs(UI.MenuModel.Normalize(items)) do list[#list + 1] = item.kind == "separator" and "-" or item.text end
  return table.concat(list, "|")
end

test("SidebarModel.PullMenuItems: single and multi menus hide what the old button hid", function()
  local calls = {}
  local actions = {}
  for _, name in ipairs({ "moveUp", "moveDown", "insertBefore", "insertAfter", "mergeUp", "mergeDown", "merge", "clear", "resetPreset", "delete" }) do
    actions[name] = function(...)
      local parts = {}
      for i = 1, select("#", ...) do
        local value = select(i, ...)
        parts[#parts + 1] = type(value) == "table" and table.concat(value, ",") or tostring(value)
      end
      calls[#calls + 1] = name..":"..table.concat(parts, ";")
    end
  end
  eq(labels(Model.PullMenuItems({ index = 2, maxPulls = 3, selection = { 2 } }, actions, L)),
    "Pull Drop Move up|Pull Drop Move down|Pull Drop Insert before|Pull Drop Insert after|Pull Drop Merge up|Pull Drop Merge down|-|Pull Drop Clear Pull|Pull Drop Reset Preset|Pull Drop Delete")
  eq(labels(Model.PullMenuItems({ index = 1, maxPulls = 3, selection = { 1 } }, actions, L)),
    "Pull Drop Move down|Pull Drop Insert before|Pull Drop Insert after|Pull Drop Merge down|-|Pull Drop Clear Pull|Pull Drop Reset Preset|Pull Drop Delete")
  eq(labels(Model.PullMenuItems({ index = 3, maxPulls = 3, selection = { 3 } }, actions, L)),
    "Pull Drop Move up|Pull Drop Insert before|Pull Drop Insert after|Pull Drop Merge up|-|Pull Drop Clear Pull|Pull Drop Reset Preset|Pull Drop Delete")
  eq(labels(Model.PullMenuItems({ index = 1, maxPulls = 1, selection = { 1 } }, actions, L)),
    "Pull Drop Insert before|Pull Drop Insert after|-|Pull Drop Clear Pull|Pull Drop Reset Preset", "no move, merge or delete with one pull")
  eq(labels(Model.PullMenuItems({ index = 2, maxPulls = 4, selection = { 1, 2 } }, actions, L)),
    "Pull Drop Insert before|Pull Drop Insert after|Pull Drop Merge|-|Pull Drop Clear Pulls|Pull Drop Reset Preset|Pull Drop Delete")
  local multi = UI.MenuModel.Normalize(Model.PullMenuItems({ index = 2, maxPulls = 4, selection = { 1, 3 } }, actions, L))
  multi[3].onSelect()
  multi[5].onSelect()
  multi[7].onSelect()
  local single = UI.MenuModel.Normalize(Model.PullMenuItems({ index = 2, maxPulls = 3, selection = { 2 } }, actions, L))
  single[1].onSelect()
  single[6].onSelect()
  single[10].onSelect()
  eq(calls, { "merge:1,3;2", "clear:1,3", "delete:1,3;2", "moveUp:2", "mergeDown:2", "delete:2;2" })
end)

test("SidebarModel.RouteGroups and RouteListItems: live, then yours, then others, no headers, no <New Preset>", function()
  local ctx = fixtureContext({ liveActive = true, livePresetUID = "theirs" })
  local groups = Model.RouteGroups(ctx)
  eq({ #groups.live, #groups.mine, #groups.others }, { 1, 2, 0 })
  eq({ groups.live[1].idx, groups.live[1].name, groups.live[1].author, groups.live[1].isLive }, { 3, "Theirs", "Zed", true })
  eq({ groups.mine[2].idx, groups.mine[2].level, groups.mine[2].isCurrent }, { 2, 12, true })
  local items = Model.RouteListItems(groups, "")
  local names = {}
  for _, item in ipairs(items) do names[#names + 1] = item.kind..":"..item.name end
  eq(table.concat(names, "|"), "route:Theirs|route:Default|route:Mine")
  eq({ items[1].author, items[1].authorColor, items[1].isLive }, { "Zed", { 0, 0.5, 1 }, true })
  eq({ items[3].idx, items[3].isCurrent }, { 2, true })
  local offline = Model.RouteListItems(Model.RouteGroups(fixtureContext()), "")
  names = {}
  for _, item in ipairs(offline) do names[#names + 1] = item.name end
  eq(table.concat(names, "|"), "Default|Mine|Theirs", "your routes come before everyone else's")
  eq(#Model.RouteListItems(Model.RouteGroups(fixtureContext()), "ZED"), 1, "search matches the author, case-insensitive")
  eq(#Model.RouteListItems(Model.RouteGroups(fixtureContext()), "min"), 1, "search matches the name")
  eq(#Model.RouteListItems(Model.RouteGroups(fixtureContext()), "nothing"), 0)
end)

test("Selection.Click: Shift and Ctrl right-clicks leave the selection alone, the sidebar handles them", function()
  local Click = UI.Selection.Click
  eq(Click({ 2 }, 4, { button = "RightButton", shift = true }), { 2 })
  eq(Click({ 2, 3 }, 4, { button = "RightButton", ctrl = true }), { 2, 3 })
  eq(Click({ 2 }, 4, { button = "LeftButton", ctrl = true }), { 2, 4 }, "ctrl left-click still toggles")
end)

test("SidebarModel.PullItems: the pull rows without the new-pull row, with each pull's health", function()
  local items, cumulative = Model.PullItems(fixturePreset().value.pulls, fixtureContext())
  eq({ #items, cumulative }, { 4, 29 })
  eq({ items[1].health, items[3].health }, { 4000, 10000 }, "health is there with Show pull health off")
  eq(items[1].healthText, nil)
  -- Efficiency scores use health before level scaling.
  eq({ items[1].baseHealth, items[3].baseHealth }, { 2000, 5000 })
end)

test("SidebarModel.PullInterrupts: interruptible spells with how many of the pull's enemies cast them", function()
  local enemies = fixtureEnemies()
  enemies[1].spells = { [11] = { interruptible = true }, [12] = { magic = true } }
  enemies[3].spells = { [11] = { interruptible = true }, [33] = { interruptible = true } }
  local interrupts = Model.PullInterrupts({ [1] = { 1, 2 }, [3] = { 1, 99 }, [4] = { 1 }, color = "ff0000" }, enemies)
  eq(interrupts, { { spellId = 11, casters = 3 }, { spellId = 33, casters = 1 } }, "unknown clones and other spells do not count")
  eq(Model.PullInterrupts({ [4] = { 1 } }, enemies), {})
end)

test("SidebarModel.PullCasters: a kind with one spell to interrupt shares an entry, an enemy with several gets its own", function()
  local enemies = fixtureEnemies()
  enemies[1].spells = { [11] = { interruptible = true }, [12] = { magic = true } }
  enemies[3].spells = { [31] = { interruptible = true }, [32] = { interruptible = true } }
  local casters = Model.PullCasters({ [1] = { 1, 2, 3 }, [3] = { 1, 2, 99 }, [4] = { 1 }, color = "ff0000" }, enemies)
  local summary = {}
  for i, caster in ipairs(casters) do
    summary[i] = { caster.enemyIdx, caster.count, table.concat(caster.spellIds, "+"), caster.name, caster.displayId, caster.cloneIdx or false }
  end
  eq(summary, {
    { 1, 3, "11", "Grunt", 11, false },
    { 3, 1, "31+32", "Imp", 33, 1 },
    { 3, 1, "31+32", "Imp", 33, 2 },
  }, "three grunts share an entry, the two imps get one each with their number, unknown clones and the rat do not count")
  local single = Model.PullCasters({ [1] = { 2 } }, enemies)[1]
  eq(single.cloneIdx, 2, "a lone caster of one spell carries its number")
  eq(Model.PullCasters({ [4] = { 1 } }, enemies), {})
end)

local PullLabelLayout = MDT.PullLabelLayout

---A square outline centered on x, y.
local function square(x, y, half)
  return { { x - half, y - half }, { x + half, y - half }, { x + half, y + half }, { x - half, y + half } }
end

---Whether a placed label of the given size overlaps an enemy {x, y, r}.
---How deep a placed label of the given size reaches into an enemy {x, y, r}, as a share of its radius.
local function coverDepth(placement, width, height, enemy)
  local dx = math.max(placement.x - width / 2, math.min(enemy[1], placement.x + width / 2)) - enemy[1]
  local dy = math.max(placement.y - height / 2, math.min(enemy[2], placement.y + height / 2)) - enemy[2]
  return math.max(0, 1 - math.sqrt(dx * dx + dy * dy) / enemy[3])
end

---Whether a label covers no enemy deeper than the layout allows, so never an enemy's face.
local function clearOfFaces(placement, width, height, enemies)
  for _, enemy in ipairs(enemies) do
    if coverDepth(placement, width, height, enemy) > 0.45 + 1e-9 then return false end
  end
  return true
end

test("PullLabelLayout.AreaCenter: a dense side does not pull the center, and degenerate outlines average", function()
  local x, y = PullLabelLayout.AreaCenter(square(10, -20, 5))
  eq({ x, y }, { 10, -20 })
  -- Many points crowd the left edge; the area center stays in the middle.
  local crowded = { { 0, 0 }, { 0, 1 }, { 0, 2 }, { 0, 3 }, { 0, 4 }, { 0, 5 }, { 0, 6 }, { 0, 7 }, { 0, 8 }, { 0, 10 }, { 10, 10 }, { 10, 0 } }
  x, y = PullLabelLayout.AreaCenter(crowded)
  eq({ x, y }, { 5, 5 })
  x, y = PullLabelLayout.AreaCenter({ { 0, 0 }, { 4, 2 } })
  eq({ x, y }, { 2, 1 })
end)

test("PullLabelLayout.Contains and NearestOnOutline: either winding, edges count as inside", function()
  local ccw = square(0, 0, 10)
  local cw = { ccw[4], ccw[3], ccw[2], ccw[1] }
  for _, poly in ipairs({ ccw, cw }) do
    eq({ PullLabelLayout.Contains(poly, 0, 0), PullLabelLayout.Contains(poly, 10, 0), PullLabelLayout.Contains(poly, 11, 0) }, { true, true, false })
  end
  eq({ PullLabelLayout.NearestOnOutline(ccw, 25, 3) }, { 10, 3 })
end)

test("PullLabelLayout.Place: a free area center keeps the label there", function()
  local placements = PullLabelLayout.Place({ { key = 1, outline = square(0, 0, 50), width = 20, height = 10 } }, {})
  eq({ placements[1].x, placements[1].y, placements[1].leaderX }, { 0, 0, nil })
end)

test("PullLabelLayout.Place: a pack on the center pushes the label aside, still inside its outline", function()
  local enemies = { { 0, 0, 8 }, { 12, 0, 8 }, { -12, 0, 8 }, { 0, 12, 8 }, { 0, -12, 8 } }
  local outline = square(0, 0, 50)
  local placement = PullLabelLayout.Place({ { key = 7, outline = outline, width = 24, height = 12 } }, enemies, { pad = 1 })[7]
  eq(clearOfFaces(placement, 24, 12, enemies), true, "label covers an enemy's face")
  for _, corner in ipairs({ { -12, -6 }, { 12, -6 }, { 12, 6 }, { -12, 6 } }) do
    eq(PullLabelLayout.Contains(outline, placement.x + corner[1], placement.y + corner[2]), true, "label leaves its outline")
  end
  eq(placement.leaderX, nil)
  eq(math.sqrt(placement.x ^ 2 + placement.y ^ 2) < 40, true, "label went far: "..placement.x..", "..placement.y)
end)

test("PullLabelLayout.Place: a pull with no room inside gets a label beside it, a far one a leader line", function()
  -- The outline hugs a single enemy, so the label reaches out of it.
  local enemy = { 0, 0, 10 }
  local placement = PullLabelLayout.Place({ { key = 1, outline = square(0, 0, 12), width = 20, height = 10 } }, { enemy })[1]
  eq(clearOfFaces(placement, 20, 10, { enemy }), true, "label covers the enemy's face")
  eq(placement.leaderX, nil, "a label at its outline needs no leader")
  -- A ring of pins, which labels never cover, keeps the label further away.
  local ring = {}
  for i = 0, 15 do
    local angle = i / 16 * 2 * math.pi
    ring[#ring + 1] = { math.cos(angle) * 22, math.sin(angle) * 22, 9 }
  end
  local far = PullLabelLayout.Place({ { key = 1, outline = square(0, 0, 12), width = 20, height = 10 } }, { enemy }, { pins = ring })[1]
  for _, pin in ipairs(ring) do eq(coverDepth(far, 20, 10, pin), 0, "label covers a pin") end
  eq(far.leaderX ~= nil, true, "a label away from its outline has a leader line")
  eq({ PullLabelLayout.NearestOnOutline(square(0, 0, 12), far.x, far.y) }, { far.leaderX, far.leaderY })
end)

test("PullLabelLayout.Place: a label goes between two groups of its pull rather than outside, reaching into their edges", function()
  -- Two packs inside one long outline, the gap between them narrower than the label.
  local outline = { { -40, -12 }, { 40, -12 }, { 40, 12 }, { -40, 12 } }
  local enemies = {}
  for _, x in ipairs({ -32, -22, 22, 32 }) do
    enemies[#enemies + 1] = { x, 5, 6 }
    enemies[#enemies + 1] = { x, -5, 6 }
  end
  local placement = PullLabelLayout.Place({ { key = 1, outline = outline, width = 36, height = 10 } }, enemies)[1]
  eq(clearOfFaces(placement, 36, 10, enemies), true, "label covers an enemy's face")
  eq(PullLabelLayout.Contains(outline, placement.x, placement.y), true, "label left the pull: "..placement.x..", "..placement.y)
  eq(math.abs(placement.x) < 6, true, "label is not between the groups: "..placement.x)
end)

test("PullLabelLayout.Place: labels keep clear of each other, other outlines and the bounds", function()
  local requests = {
    { key = "a", outline = square(0, 0, 30), width = 20, height = 10 },
    { key = "b", outline = square(0, 0, 30), width = 20, height = 10 },
    { key = "c", outline = square(70, 0, 30), width = 20, height = 10 },
  }
  local placements = PullLabelLayout.Place(requests, {}, { pad = 1 })
  local a, b, c = placements.a, placements.b, placements.c
  eq({ a.x, a.y }, { 0, 0 }, "the first label takes the center")
  eq(math.abs(a.x - b.x) >= 20 or math.abs(a.y - b.y) >= 10, true, "labels a and b overlap")
  eq({ c.x, c.y }, { 70, 0 })
  -- c's outline overlaps a wide label at 0, 0 that sits inside it.
  local overlapped = PullLabelLayout.Place({
    { key = "wide", outline = square(0, 0, 40), width = 30, height = 10 },
    { key = "beside", outline = square(30, 0, 20), width = 10, height = 10 },
  }, {})
  eq(PullLabelLayout.Contains(square(30, 0, 20), overlapped.wide.x - 15, overlapped.wide.y)
    or PullLabelLayout.Contains(square(30, 0, 20), overlapped.wide.x + 15, overlapped.wide.y), false, "the label sits on another pull's outline")
  -- A small pull inside a big one keeps its label inside its own outline rather than out past the big one.
  local nested = PullLabelLayout.Place({
    { key = "big", outline = square(0, 0, 80), width = 20, height = 10 },
    { key = "small", outline = square(40, 0, 20), width = 20, height = 10 },
  }, { { 0, 0, 10 } })
  eq(PullLabelLayout.Contains(square(40, 0, 20), nested.small.x, nested.small.y), true, "the nested pull's label left its outline")
  eq(nested.small.leaderX, nil)
  eq(PullLabelLayout.Contains(square(40, 0, 20), nested.big.x, nested.big.y), false, "the big pull's label sits in the nested pull")
  local bounded = PullLabelLayout.Place({ { key = 1, outline = square(0, 0, 30), width = 20, height = 10 } }, {},
    { bounds = { left = -5, right = 100, top = 100, bottom = -100 } })[1]
  eq(bounded.x - 10 >= -5, true, "the label leaves the bounds")
end)

test("PullLabelLayout.Place: a label keeps its previous spot while it costs about the same, and pauses", function()
  local outline = square(0, 0, 50)
  local first = PullLabelLayout.Place({ { key = 1, outline = outline, width = 20, height = 10 } }, { { 0, 0, 8 } })[1]
  eq(first.cost < 1.5, true, "an inside spot costs "..first.cost)
  local function placeWith(previous, enemies)
    return PullLabelLayout.Place({ { key = 1, outline = outline, width = 20, height = 10, previous = previous } }, enemies)[1]
  end
  local kept = placeWith({ x = 30, y = 30, cost = 0.9 }, { { 0, 0, 8 } })
  eq({ kept.x, kept.y }, { 30, 30 }, "a previous spot that costs about what it did is kept over a closer one")
  local better = placeWith({ x = 30, y = 30, cost = 0.1 }, { { 0, 0, 8 } })
  eq(better.x ~= 30 or better.y ~= 30, true, "a previous spot that got dearer is given up")
  local covered = placeWith({ x = 30, y = 30, cost = 0.9 }, { { 30, 30, 8 } })
  eq(covered.x ~= 30 or covered.y ~= 30, true, "a previous spot an enemy now covers is given up")
  eq(placeWith({ x = 80, y = 0, cost = 0.2 }, {}).x, 0, "a previous spot now outside the outline is given up")
  local pauses = 0
  PullLabelLayout.Place({
    { key = 1, outline = outline, width = 20, height = 10 },
    { key = 2, outline = square(200, 0, 20), width = 20, height = 10 },
  }, {}, { pause = function() pauses = pauses + 1 end })
  eq(pauses >= 2, true, "pause runs after each label")
end)

test("PullLabelLayout.Place: a pull too narrow for its label, under a big pull, gets its label right beside it", function()
  -- A thin pull of enemies, with a big pull's outline over everything on its left.
  local thin = { { -6, -40 }, { 6, -40 }, { 6, 40 }, { -6, 40 } }
  local big = { { -200, -100 }, { 2, -100 }, { 2, 100 }, { -200, 100 } }
  local enemies = {}
  for y = -35, 35, 10 do enemies[#enemies + 1] = { 0, y, 4 } end
  local placements = PullLabelLayout.Place({
    { key = "big", outline = big, width = 30, height = 10 },
    { key = "thin", outline = thin, width = 30, height = 10 },
  }, enemies, { pad = 1 })
  local label = placements.thin
  eq(clearOfFaces(label, 30, 10, enemies), true, "the label covers an enemy's face")
  eq(label.leaderX, nil, "the label went so far it needs a leader line")
  eq(label.x - 15 >= 6 - 0.01, true, "the label is not right of the thin pull, clear of the big one: "..label.x)
  eq(label.x - 15 - 6 < 10, true, "the label is far from its pull: "..label.x)
end)

io.write(("test_kit: %d passed, %d failed (%d pure files loaded without WoW globals)\n"):format(passed, failed, #pureFiles))
if failed > 0 then os.exit(1) end
