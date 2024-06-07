local addonName, MDT = ...
local AceGUI = LibStub("AceGUI-3.0")
local L

function MDT:IsCompatibleVersion()
  local gameVersion = select(4, GetBuildInfo())
  return gameVersion >= 110000
end

function MDT:ShowFallbackWindow()
  if not MDT.fallbackFrame then
    L = MDT.L
    local gameVersionString = GetBuildInfo()
    local addonVersionString = C_AddOns and C_AddOns.GetAddOnMetadata(addonName, "Version") or GetAddOnMetadata(addonName, "Version")
    local labelText = L["incompatibleVersionError"].."\n\nGame: "..gameVersionString.."\nMDT: "..addonVersionString
    MDT.fallbackFrame = AceGUI:Create("Frame")
    _G["MDTFallbackFrame"] = MDT.fallbackFrame.frame
    tinsert(UISpecialFrames, "MDTFallbackFrame")
    local fallbackFrame = MDT.fallbackFrame
    fallbackFrame:EnableResize(false)
    fallbackFrame:SetWidth(600)
    fallbackFrame:SetHeight(300)
    fallbackFrame:EnableResize(false)
    fallbackFrame:SetLayout("Flow")
    fallbackFrame:SetCallback("OnClose", function(widget) end)
    fallbackFrame:SetTitle(L["MDT Error"])
    fallbackFrame.label = AceGUI:Create("Label")
    fallbackFrame.label:SetWidth(600)
    fallbackFrame.label:SetFontObject("GameFontNormalLarge")
    fallbackFrame.label.label:SetFont(fallbackFrame.label.label:GetFont(), 30);
    fallbackFrame.label.label:SetTextColor(1, 0, 0)
    fallbackFrame.label:SetText(labelText)
    fallbackFrame:AddChild(fallbackFrame.label)
  end
  MDT.fallbackFrame:Show()
end
