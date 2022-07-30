local MDT = MDT
local db
local AceGUI = LibStub("AceGUI-3.0")
local liveShareGroup
local activeFrames = {}


local function updateLiveShareGroup()
  liveShareGroup:ReleaseChildren()
  for frameIndex,shown in pairs(activeFrames) do
    if shown then
      local child = MDT:GetLiveShareFrame(frameIndex)
      liveShareGroup:AddChild(child)
    end
  end
end

local sessions = {
  {
    ["senderName"] = "Nnoggiedh-Lycanthoth",
    ["spectators"] = {"Snipemasterx-Anasterian"},
    ["preset"] = {
      ["dungeonIdx"] = 25,
      ["presetName"] = "Super Route 123",
    }
  },
  {
    ["senderName"] = "Snipemasterx-Anasterian",
    ["spectators"] = {},
    ["preset"] = {
      ["dungeonIdx"] = 26,
      ["presetName"] = "Mega Route",
    }
  },
  {
    ["senderName"] = "Nnoggiess-Anasterian",
    ["spectators"] = {},
    ["preset"] = {
      ["dungeonIdx"] = 26,
      ["presetName"] = "Mega Route",
    }
  },

}

function MDT:GetLiveShareFrame(index)
  local liveShareFrame = AceGUI:Create("MDTLiveShareFrame")
  liveShareFrame:Initialize()
  local sessionData = sessions[index]
  if sessionData then liveShareFrame:UpdateDisplay(sessionData) end
  return liveShareFrame
end



function MDT:CreateLiveShareGroup()
  db = MDT:GetDB()
  liveShareGroup = AceGUI:Create("SimpleGroup")
  liveShareGroup.frame:SetFrameStrata("HIGH")
  liveShareGroup.frame:SetFrameLevel(50)
  if not liveShareGroup.frame.SetBackdrop then
      Mixin(liveShareGroup.frame, BackdropTemplateMixin)
  end
  liveShareGroup.frame:SetBackdropColor(unpack(MDT.BackdropColor))
  MDT:FixAceGUIShowHide(liveShareGroup)
  liveShareGroup:SetLayout("Flow")
  liveShareGroup:SetWidth(175)
  liveShareGroup.frame:SetPoint("TOPRIGHT", MDT.main_frame,"TOPRIGHT",0,-120)
  liveShareGroup.frame:Show()


  local checkBoxes = {}
  for i=1,5 do
    checkBoxes[i] = AceGUI:Create("CheckBox")
    checkBoxes[i]:SetLabel(i)
    checkBoxes[i]:SetCallback("OnValueChanged",function(widget,callbackName,value)
      activeFrames[i] = value
      updateLiveShareGroup()
    end)
    MDT.main_frame.sidePanel.WidgetGroup:AddChild(checkBoxes[i])
  end


end
