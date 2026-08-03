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
        MDT:OpenConfirmationFrame(450, 150, L["hardResetPromptTitle"], L["Delete"], L["hardResetPrompt"], MDT.HardReset)
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
      MDT:OpenConfirmationFrame(450, 150, "MDT Test", "Run", "Run all tests?", MDT.test.RunAllTests)
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
    local inGroup = UnitInRaid("player") or IsInGroup()
    MDT.main_frame.LinkToChatButton:SetDisabled(not inGroup)
    MDT.main_frame.LiveSessionButton:SetDisabled(not inGroup)
    if inGroup then
      MDT.main_frame.LinkToChatButton.text:SetTextColor(1, 0.8196, 0)
      if MDT.liveSessionActive then
        MDT.main_frame.LiveSessionButton:SetText(L["*Live*"])
        MDT.main_frame.LiveSessionButton.text:SetTextColor(0, 1, 0)
      else
        MDT.main_frame.LiveSessionButton:SetText(L["Live"])
        MDT.main_frame.LiveSessionButton.text:SetTextColor(1, 0.8196, 0)
      end
    else
      MDT.main_frame.LinkToChatButton.text:SetTextColor(0.5, 0.5, 0.5)
      MDT.main_frame.LiveSessionButton.text:SetTextColor(0.5, 0.5, 0.5)
    end
    last = now
  end
end

local initStarted
function MDT:StartMainFrameInitialization()
  if initStarted then return end
  initStarted = true
  for _, module in pairs(MDT.modules) do
    if module.OnInitialize then
      module:OnInitialize()
    end
  end
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
