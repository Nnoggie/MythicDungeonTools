local _, addon = ...

local function testFunc()
  local loadedOrLoading, loaded = C_AddOns.IsAddOnLoaded("MythicDungeonTools_UI")
  if loaded == nil then loaded = loadedOrLoading end

  assert(C_AddOns.IsAddOnLoadOnDemand("MythicDungeonTools_UI"), "UI addon is not load-on-demand")
  assert(loaded, "UI addon is not loaded")
  assert(type(_G.MDT) == "table", "Legacy MDT compatibility global is missing")
  assert(type(_G.MythicDungeonToolsAPI) == "table", "Public MDT API is missing")
  assert(_G.MDT ~= _G.MythicDungeonToolsAPI, "Public API exposes the legacy MDT table")
  assert(addon ~= _G.MDT, "Core and UI addon tables are still shared")
  assert(addon ~= _G.MythicDungeonToolsAPI, "UI table is not private")
  assert(getmetatable(addon).__index == _G.MythicDungeonToolsAPI, "UI API bridge is missing")
  assert(type(_G.MythicDungeonToolsAPI.ShowInterface) == "function", "Public UI loader is missing")
  assert(type(_G.MythicDungeonToolsAPI.GetDB) == "function", "Core database API is missing")
  assert(type(_G.MythicDungeonToolsAPI.RegisterUIInitializer) == "function", "Deferred UI initializer API is missing")
  assert(type(addon.HandleChatLink) == "function", "Chat-link bridge is missing")
  assert(_G.MythicDungeonToolsAPI.InitializeRuntime == nil, "Private UI method leaked through the API")

  local initialized
  _G.MythicDungeonToolsAPI:RegisterUIInitializer(function(pluginAPI)
    initialized = true
    assert(pluginAPI ~= addon, "Plugin API exposes the UI addon table")
    assert(pluginAPI.InitializeRuntime == nil, "Private UI method leaked through the plugin API")
    assert(type(pluginAPI.RegisterNavigationSection) == "function", "Navigation plugin bridge is missing")
    assert(type(pluginAPI.RegisterDungeonData) == "function", "Dungeon data plugin bridge is missing")
  end)
  assert(initialized, "UI initializer did not run after UI attachment")
end

---@type MDTTest
local test = {
  name = "Load-on-demand UI",
  func = testFunc,
  duration = 0,
}

tinsert(addon.test.testList, test)
