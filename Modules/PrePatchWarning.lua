local AddonName, MDT = ...
local AceGUI = LibStub("AceGUI-3.0")
local L = MDT.L

local PREPATCH_RELEASE_TIMESTAMP = 1768950035
local MIDNIGHT_RELEASE_TIMESTAMP = 1772406035
local LEGACY_DOWNLOAD_LINKS = {
  { name = "Wago",       url = "https://addons.wago.io/addons/mythic-dungeon-tools-mdt-legacy" },
  { name = "CurseForge", url = "https://legacy.curseforge.com/wow/addons/mythic-dungeon-tools-mdt-legacy" },
}

local function createCopyableLinkRow(frame, name, url, startCopyAction, stopCopyAction)
  local editBox = AceGUI:Create("EditBox")
  local copyButton
  editBox:SetLabel(name..":")
  editBox:DisableButton(true)
  editBox:SetText(url)
  editBox:SetCallback("OnTextChanged", function()
    editBox:SetText(url)
  end)
  editBox:SetWidth(340)
  editBox.editbox:HookScript("OnEditFocusLost", function()
    stopCopyAction(copyButton)
  end)
  editBox.editbox:SetScript("OnKeyUp", function(_, key)
    if (MDT.copyHelper:WasControlKeyDown() and key == "C") then
      MDT.copyHelper:SmartFadeOut()
      editBox:ClearFocus()
    else
      MDT.copyHelper:SmartHide()
    end
  end)

  copyButton = AceGUI:Create("Button")
  copyButton:SetText(L["Copy"])
  copyButton:SetWidth(100)
  copyButton:SetCallback("OnClick", function()
    startCopyAction(editBox, copyButton, url)
  end)

  frame:AddChild(editBox)
  frame:AddChild(copyButton)
end

function MDT:SetupPrePatchWarning()
  local db = MDT:GetDB()
  if not db then return end
  if db.prePatchWarningSeenFor == PREPATCH_RELEASE_TIMESTAMP then return end
  local now = time()
  if now < PREPATCH_RELEASE_TIMESTAMP then return end
  if now >= MIDNIGHT_RELEASE_TIMESTAMP then return end
  if not MDT.main_frame then return end

  if not MDT.prePatchWarningFrame then
    local frame = AceGUI:Create("Frame")
    MDT.prePatchWarningFrame = frame
    _G["MDTPrePatchWarningFrame"] = frame.frame
    tinsert(UISpecialFrames, "MDTPrePatchWarningFrame")
    frame.frame:SetFrameLevel(150)
    frame:EnableResize(false)
    frame:SetWidth(520)
    frame:SetHeight(270)
    frame:SetLayout("Flow")
    frame:SetTitle(L["MDT Legacy maps"])
    frame.statustext:GetParent():Hide()
    frame:SetCallback("OnClose", function()
      MDT.copyHelper:SmartHide()
    end)

    local label = AceGUI:Create("Label")
    label:SetWidth(480)
    label:SetText(L["PREPATCH_LAUNCH_WARNING_TEXT"])
    frame:AddChild(label)

    local function startCopyAction(editBox, copyButton, text)
      editBox:HighlightText(0, string.len(text))
      editBox:SetFocus()
      copyButton:SetDisabled(true)
      MDT.copyHelper:SmartShow(frame.frame, 0, 0)
    end

    local function stopCopyAction(copyButton)
      if copyButton then copyButton:SetDisabled(false) end
      MDT.copyHelper:SmartHide()
    end

    for _, link in ipairs(LEGACY_DOWNLOAD_LINKS) do
      createCopyableLinkRow(frame, link.name, link.url, startCopyAction, stopCopyAction)
    end
  end

  MDT:HideAllDialogs()
  MDT:FixAceGUIShowHide(MDT.prePatchWarningFrame, MDT.main_frame, nil, true)
  MDT.prePatchWarningFrame:ClearAllPoints()
  MDT.prePatchWarningFrame.frame:SetParent(MDT.main_frame)
  MDT.prePatchWarningFrame.frame:SetFrameStrata("DIALOG")
  MDT.prePatchWarningFrame:SetPoint("CENTER", MDT.main_frame, "CENTER", 0, 50)
  MDT.prePatchWarningFrame:Show()
  db.prePatchWarningSeenFor = PREPATCH_RELEASE_TIMESTAMP
end
