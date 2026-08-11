local addonName, MDT = ...
local API = assert(_G.MythicDungeonToolsAPI, "MythicDungeonTools_UI requires MythicDungeonTools")

MDT.UIAddonName = addonName
MDT.AddonName = API:GetAddonName()
MDT.BackdropColor = { API:GetBackdropColor() }
MDT.L = setmetatable({}, { __index = function(_, key) return key end })
MDT.presetCommPrefix = API:GetPresetCommPrefix()
MDT.versionCheckPrefix = API:GetVersionCheckPrefix()
MDT.liveSessionPrefixes = API:GetLiveSessionPrefixes()
MDT.commsObject = {
  SendCommMessage = function(_, ...)
    return API:SendCommMessage(...)
  end,
}

setmetatable(MDT, { __index = API })

local pluginAPI = {}

function pluginAPI:RegisterNavigationSection(section)
  return MDT:RegisterNavigationSection(section)
end

function pluginAPI:GetCurrentSection()
  return MDT:GetCurrentSection()
end

function pluginAPI:SetCurrentSection(sectionKey)
  return MDT:SetCurrentSection(sectionKey)
end

function pluginAPI:GetNavigationSectionContentFrame(sectionKey)
  local frames = MDT.main_frame and MDT.main_frame.sectionContentFrames
  return frames and frames[sectionKey]
end

function pluginAPI:HideAllDialogs()
  return MDT:HideAllDialogs()
end

local dungeonDataFields = {
  "dungeonEnemies",
  "dungeonList",
  "dungeonMaps",
  "dungeonSubLevels",
  "dungeonTotalCount",
  "mapInfo",
  "mapPOIs",
  "scaleMultiplier",
  "zoneIdToDungeonIdx",
}

function pluginAPI:RegisterDungeonData(data, seasons)
  assert(type(data) == "table", "Dungeon data must be a table")
  for key, value in pairs(data.L or {}) do
    if rawget(MDT.L, key) == nil then MDT.L[key] = value end
  end
  for _, fieldName in ipairs(dungeonDataFields) do
    local source = data[fieldName]
    local target = MDT[fieldName]
    assert(type(source) == "table", "Missing dungeon data field: "..fieldName)
    assert(type(target) == "table", "Missing MythicDungeonTools data field: "..fieldName)
    for key, value in pairs(source) do target[key] = value end
  end

  for dungeonIndex, name in pairs(data.dungeonList) do MDT.dungeonList[dungeonIndex] = MDT.L[name] end
  for _, info in pairs(data.mapInfo) do
    if type(info) == "table" and type(info.shortName) == "string" then info.shortName = MDT.L[info.shortName] end
  end
  for _, sublevels in pairs(data.dungeonSubLevels) do
    for sublevel, name in pairs(sublevels) do sublevels[sublevel] = MDT.L[name] end
  end

  if seasons == nil then return end
  assert(type(seasons) == "table", "Dungeon seasons must be a table")
  for _, season in ipairs(seasons) do
    assert(type(season) == "table" and type(season.name) == "string" and type(season.dungeons) == "table", "Invalid dungeon season")
    table.insert(MDT.seasonList, MDT.L[season.name])
    table.insert(MDT.dungeonSelectionToIndex, season.dungeons)
  end
end

function MDT:AttachCoreAPI()
  API:AttachUI({
    ShowInterface = function(...) return MDT:ShowInterface(...) end,
    HandleSlashCommand = function(...) return MDT:HandleSlashCommand(...) end,
    HandleChatLink = function(...) return MDT:HandleChatLink(...) end,
    OnCommReceived = function(...) return MDT.commsObject:OnCommReceived(...) end,
    GetEnemyForces = function(...) return MDT:GetEnemyForces(...) end,
    GetDungeonName = function(...) return MDT:GetDungeonName(...) end,
    GetDungeonSublevels = function(...) return MDT:GetDungeonSublevels(...) end,
    OnMinimapVisibilityChanged = function(shown)
      local checkbox = MDT.main_frame and MDT.main_frame.minimapCheckbox
      if checkbox then checkbox:SetValue(shown) end
    end,
  }, pluginAPI)
end
