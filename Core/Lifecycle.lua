local UIAddonName, MDT = ...
local L = MDT.L

local pairs, CreateFrame = pairs, CreateFrame

local asyncConfig = {
  type = "everyFrame",
  maxTime = 40,
  maxTimeCombat = 8,
  errorHandler = function(msg, stackTrace, name)
    MDT:OnError(msg, stackTrace, name)
  end,
}
MDT.asyncHandler = LibStub("LibAsync"):GetHandler(asyncConfig)

function MDT:Async(func, name, singleton)
  MDT.asyncHandler:Async(func, name, singleton)
end

function MDT:CancelAsync(name)
  MDT.asyncHandler:CancelAsync(name)
end

local db
function MDT:HandleSlashCommand(cmd, editbox)
  cmd = cmd:lower()
  local rqst, arg = strsplit(' ', cmd)
  if rqst == "devmode" then
    if MDT.ToggleDevMode then MDT:ToggleDevMode() end
  elseif rqst == "reset" then
    MDT:ResetMainFramePos()
  elseif rqst == "hardreset" then
    if arg == "force" then
      MDT:HardReset()
    else
      MDT:Async(function()
        MDT.UI.Dialogs.Confirm({ width = 450, parent = not (MDT.main_frame and MDT.main_frame:IsShown()) and MDT.UI.Root or nil, title = L["hardResetPromptTitle"], text = L["hardResetPrompt"], confirm = { text = L["Delete"], variant = "danger", onClick = function() MDT:HardReset() end } })
      end, "hardReset")
    end
  elseif rqst == "minimap" then
    if db.minimap.hide then
      MDT:ShowMinimapButton()
    else
      MDT:HideMinimapButton()
    end
  elseif rqst == "test" then
    if MDT.test and MDT.test.RunAllTests then
      MDT.UI.Dialogs.Confirm({ width = 450, parent = not (MDT.main_frame and MDT.main_frame:IsShown()) and MDT.UI.Root or nil, title = "MDT Test", text = "Run all tests?", confirm = { text = "Run", onClick = function() MDT.test.RunAllTests() end } })
    end
  else
    MDT:Async(function() MDT:ShowInterfaceInternal() end, "showInterface")
  end
end

local eventFrame = CreateFrame("Frame")
eventFrame:RegisterEvent("ADDON_LOADED")
eventFrame:RegisterEvent("GROUP_ROSTER_UPDATE")
eventFrame:SetScript("OnEvent", function(self, event, ...)
  if event == "ADDON_LOADED" then
    local addon = ...
    if addon ~= UIAddonName then return end
    MDT:AttachCoreAPI()
    db = MDT:InitializeRuntime()
    self:UnregisterEvent("ADDON_LOADED")
  elseif event == "GROUP_ROSTER_UPDATE" then
    MDT.GROUP_ROSTER_UPDATE()
  end
end)

local last = 0
function MDT.GROUP_ROSTER_UPDATE()
  --check not more than once per second (blizzard event spam)
  local now = GetTime()
  if last < now - 1 then
    if not MDT.main_frame then return end
    MDT:RefreshSidebar()
    last = now
  end
end

local initStarted
function MDT:StartMainFrameInitialization()
  if initStarted then return end
  initStarted = true
  MDT:RegisterErrorHandledFunctions()
  MDT:CheckSeenDungeonLists()

  -- request spell info for all teleports, so icons are instantly working
  for _, mapInfo in pairs(MDT.mapInfo) do
    if mapInfo.teleportId then
      C_Spell.RequestLoadSpellData(mapInfo.teleportId)
    end
  end

  MDT:InitializeMainFrame()
end
