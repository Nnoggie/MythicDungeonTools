local _, MDT = ...
local AceGUI = LibStub("AceGUI-3.0")
local conflictFrame
local L = MDT.L

-- In DungeonTools case the AddOn has not been updated in over a year and has caused many users to be
-- confused about MDT not working. This will prompt users to remove the abandoned AddOn and prevent them
-- from opening up a broken instance.

local candidates = {
  ["DungeonTools"] = {
    name = "Dungeon Tools";
    detected = false;
    onDetect = function()
      SLASH_DUNGEONTOOLS1 = "/mplus"
      SLASH_DUNGEONTOOLS2 = "/mdt"
      SLASH_DUNGEONTOOLS3 = "/dungeontools"
      function SlashCmdList.DUNGEONTOOLS(cmd, editbox)
        MDT:ShowInterface()
      end

      local ldb = LibStub("LibDBIcon-1.0")
      ldb.objects["DungeonTools"]:SetScript("OnClick", function() MDT:ShowInterface() end)
    end
  }
}

local conflictCheckFrame = CreateFrame("Frame")
conflictCheckFrame:RegisterEvent("ADDON_LOADED")
conflictCheckFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
conflictCheckFrame:SetScript("OnEvent", function(self, event, ...)
  if event == "ADDON_LOADED" then
    local addonName = ...
    if candidates[addonName] then
      candidates[addonName].detected = true
    end
  end
  if event == "PLAYER_ENTERING_WORLD" then
    -- fire onDetect for all candidates that have been detected
    for _, candidate in pairs(candidates) do
      if candidate.detected then
        candidate.onDetect()
      end
    end
    conflictCheckFrame:UnregisterEvent("ADDON_LOADED")
    conflictCheckFrame:UnregisterEvent("PLAYER_ENTERING_WORLD")
  end
end)

function MDT:CheckAddonConflicts()
  for _, candidate in pairs(candidates) do
    if candidate.detected then
      return true
    end
  end
  return false
end

function MDT:ShowConflictFrame()
  if not conflictFrame then
    conflictFrame = AceGUI:Create("Frame")
    conflictFrame:EnableResize(false)
    conflictFrame:SetLayout("Flow")
    conflictFrame:SetCallback("OnClose", function(widget) end)
    conflictFrame:SetTitle(L["Addon Conflict"])

    conflictFrame.label = AceGUI:Create("Label")
    conflictFrame.label:SetWidth(390)
    local labelText = L["conflictPrompt"]
    -- add all conflicting addons to the text in red color
    for _, candidate in pairs(candidates) do
      if candidate.detected then
        labelText = labelText .. "\n|cFFFF0000" .. candidate.name .. "|r"
      end
    end

    conflictFrame.label:SetText(labelText)
    conflictFrame:AddChild(conflictFrame.label)
  end
  conflictFrame:Show()
end
