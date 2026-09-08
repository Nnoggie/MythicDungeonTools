-- Run with Lua 5.1: lua5.1 scripts/check_locales.lua [repository root]
-- Run regression checks: lua5.1 scripts/check_locales.lua --self-test
local locales = { "enUS", "deDE", "esES", "esMX", "frFR", "itIT", "koKR", "ptBR", "ruRU", "zhCN", "zhTW" }

local function sortedKeys(values)
  local keys = {}
  for key in pairs(values) do keys[#keys + 1] = key end
  table.sort(keys)
  return keys
end

local function scriptPaths(xml, directory)
  local paths = {}
  xml = xml:gsub("<!%-%-.-%-%->", "")
  for path in xml:gmatch("<Script%s+file%s*=%s*[\"']([^\"']+)[\"']") do
    paths[#paths + 1] = directory..path:gsub("\\", "/")
  end
  assert(#paths > 0, "No scripts found in XML manifest")
  return paths
end

local function run(source, path, environment, addon)
  local chunk = assert(loadstring(source, "@"..path))
  setfenv(chunk, environment)("MythicDungeonTools", addon)
end

local function loadLocale(source, path, locale)
  local values, assigned = {}, {}
  local target = setmetatable({}, {
    __index = values,
    __newindex = function(_, key, value)
      assert(type(key) == "string", path..": localization key must be a string")
      assert(not assigned[key], path..": duplicate key "..string.format("%q", key))
      assert(type(value) == "string" and value:match("%S"), path..": empty or invalid value for "..string.format("%q", key))
      assigned[key] = true
      values[key] = value
    end,
  })
  run(source, path, { GAME_LOCALE = locale, GetLocale = function() return locale end }, { L = target })
  return values
end

local function loadEnemies(source, path)
  local addon = {
    AddonName = "MythicDungeonTools",
    L = setmetatable({}, { __index = function(_, key) return key end }),
    dungeonList = {}, mapInfo = {}, zoneIdToDungeonIdx = {}, dungeonMaps = {},
    dungeonSubLevels = {}, dungeonTotalCount = {}, mapPOIs = {}, dungeonEnemies = {}, scaleMultiplier = {},
  }
  run(source, path, { ipairs = ipairs, pairs = pairs }, addon)
  local enemies = {}
  for _, dungeon in pairs(addon.dungeonEnemies) do
    for _, enemy in pairs(dungeon) do
      assert(type(enemy.name) == "string" and enemy.name:match("%S"), path..": invalid enemy name")
      enemies[enemy.name] = "NPC "..tostring(enemy.id).." in "..path
    end
  end
  assert(next(enemies), path..": no dungeon enemies found")
  return enemies
end

local function missingLocales(catalogs, key)
  local missing = {}
  for _, locale in ipairs(locales) do
    local value = rawget(catalogs[locale], key)
    if type(value) ~= "string" or not value:match("%S") then missing[#missing + 1] = locale end
  end
  return missing
end

local function check(catalogs, enemies, report)
  local failures = 0
  local function requireKey(key, source)
    local missing = missingLocales(catalogs, key)
    if #missing == 0 then return end
    failures = failures + 1
    report(string.format("%s: %q missing or empty in %s", source, key, table.concat(missing, ", ")))
  end
  -- Enemy names must be checked even when every catalogue, including enUS, omits them.
  for _, key in ipairs(sortedKeys(enemies)) do requireKey(key, enemies[key]) end
  for _, key in ipairs(sortedKeys(catalogs.enUS)) do
    if not enemies[key] then requireKey(key, "Locales/enUS.lua") end
  end
  return failures
end

local function selfTest()
  local paths = scriptPaths([[<!-- <Script file="ignored.lua"/> -->
    <Script file='one.lua'/><Script file="Locales\enUS.lua"/>]], "")
  assert(#paths == 2 and paths[1] == "one.lua" and paths[2] == "Locales/enUS.lua")
  local source = [[
    if (GAME_LOCALE or GetLocale()) ~= "deDE" then return end
    local _, MDT = ...
    MDT.L["A \"quoted\" key"] = [=[Mehrere
Zeilen]=]
  ]]
  assert(loadLocale(source, "test.lua", "deDE")['A "quoted" key'] == "Mehrere\nZeilen")
  assert(not next(loadLocale(source, "test.lua", "frFR")))
  assert(not pcall(loadLocale, "invalid Lua!", "test.lua", "enUS"))
  assert(not pcall(loadLocale, 'local _, m = ...; m.L.k = "a"; m.L.k = "b"', "test.lua", "enUS"))
  assert(not pcall(loadLocale, 'local _, m = ...; m.L.k = nil', "test.lua", "enUS"))
  local enemies = loadEnemies([[local _, m = ...
    m.dungeonEnemies[1] = { { name = "Missing NPC", id = 123 } }]], "TestDungeon.lua")
  local catalogs = {}
  for _, locale in ipairs(locales) do
    catalogs[locale] = setmetatable({ UI = "UI" }, { __index = function(_, key) return key end })
  end
  local messages = {}
  local function report(message) messages[#messages + 1] = message end
  catalogs.deDE.UI = nil
  assert(check(catalogs, enemies, report) == 2)
  assert(messages[1]:find("NPC 123", 1, true) and messages[2]:find("Locales/enUS.lua", 1, true))
  for _, locale in ipairs(locales) do catalogs[locale]["Missing NPC"] = "Missing NPC" end
  assert(check(catalogs, enemies, report) == 1)
  catalogs.deDE.UI = " \n"
  assert(check(catalogs, enemies, report) == 1)
  catalogs.deDE.UI = true
  assert(check(catalogs, enemies, report) == 1)
  catalogs.deDE.UI = "UI"
  assert(check(catalogs, enemies, report) == 0)
  print("Localization regression checks passed.")
end

local function main()
  if arg[1] == "--self-test" then selfTest(); return 0 end
  local root = arg[1] or "."
  local function read(path)
    local file = assert(io.open(root.."/"..path, "rb"))
    local source = file:read("*a")
    file:close()
    return source
  end
  local registered = {}
  for _, path in ipairs(scriptPaths(read("locales.xml"), "")) do
    assert(not registered[path], "Duplicate locale registration: "..path)
    registered[path] = true
  end
  local catalogs = {}
  for _, locale in ipairs(locales) do
    local path = "Locales/"..locale..".lua"
    assert(registered[path], path.." is missing from locales.xml")
    registered[path] = nil
    catalogs[locale] = loadLocale(read(path), path, locale)
  end
  assert(not next(registered), "Unknown locale in locales.xml; update the checker's supported locales")
  local enemies = {}
  for _, path in ipairs(scriptPaths(read("Midnight/load_midnight.xml"), "Midnight/")) do
    for key, source in pairs(loadEnemies(read(path), path)) do
      enemies[key] = enemies[key] and (enemies[key].."; "..source) or source
    end
  end
  local messages = {}
  local failures = check(catalogs, enemies, function(message)
    messages[#messages + 1] = message
    if os.getenv("GITHUB_ACTIONS") == "true" then
      print("::error::"..message:gsub("%%", "%%25"):gsub("\r", "%%0D"):gsub("\n", "%%0A"))
    else
      print(message)
    end
  end)
  local result = string.format("Localization coverage: %d enemy names, %d enUS keys, %d locales; %d incomplete keys.",
    #sortedKeys(enemies), #sortedKeys(catalogs.enUS), #locales, failures)
  print(result)
  local summaryPath = os.getenv("GITHUB_STEP_SUMMARY")
  if summaryPath then
    local summary = assert(io.open(summaryPath, "a"))
    summary:write("## Localization coverage\n\n", result, "\n")
    for _, message in ipairs(messages) do summary:write("\n- ", message) end
    summary:write("\n")
    summary:close()
  end
  return failures == 0 and 0 or 1
end

local ok, result = pcall(main)
if not ok then
  print("::error::"..tostring(result):gsub("%%", "%%25"):gsub("\r", "%%0D"):gsub("\n", "%%0A"))
  os.exit(1)
end
os.exit(result)
