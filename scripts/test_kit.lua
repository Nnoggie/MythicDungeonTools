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
local UI = MDT.UI

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

test("ListMath.Changed and ScrollTo", function()
  local old = { { kind = "pull", key = 1, sig = "a" }, { kind = "pull", key = 2, sig = "b" }, { kind = "new", key = "new", sig = "" } }
  local new = { { kind = "pull", key = 1, sig = "a" }, { kind = "pull", key = 2, sig = "c" } }
  eq(UI.ListMath.Changed(old, new), { 2, 3 })
  eq(UI.ListMath.Changed(new, old), { 2, 3 })
  eq(UI.ListMath.Changed(old, old), {})
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
  eq({ UI.Theme.Resolve("accent") }, { 1, 209 / 255, 0, 1 })
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

io.write(("test_kit: %d passed, %d failed (%d pure files loaded without WoW globals)\n"):format(passed, failed, #pureFiles))
if failed > 0 then os.exit(1) end
