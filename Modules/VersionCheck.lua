local AddonName, MDT = ...
local AceGUI = LibStub("AceGUI-3.0")
local L = MDT.L

local function createVersionCheckFrame()
  local versionCheckFrame = AceGUI:Create("Frame")
  versionCheckFrame:SetPoint("CENTER", MDT.main_frame, "CENTER")
  versionCheckFrame:EnableResize(false)
  versionCheckFrame:SetWidth(600)
  versionCheckFrame:SetHeight(400)
  versionCheckFrame:EnableResize(false)
  versionCheckFrame:SetLayout("Flow")
  versionCheckFrame:SetCallback("OnClose", function(widget) end)
  versionCheckFrame:SetTitle("Version Check")
  versionCheckFrame:Hide()
  return versionCheckFrame
end

function MDT:ToggleVersionCheckFrame()
  if not MDT.versionCheckFrame then
    MDT.versionCheckFrame = createVersionCheckFrame()
  end
  if MDT.versionCheckFrame:IsShown() then
    MDT.versionCheckFrame:Hide()
  else
    MDT.versionCheckFrame:Show()
  end
end
