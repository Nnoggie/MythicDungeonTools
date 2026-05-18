local _, MDT = ...
local L = MDT.L
local AceGUI = LibStub("AceGUI-3.0")

MDT.externalLinks = {
  {
    name = "GitHub",
    tooltip = L["Open an issue on GitHub"],
    url = "https://github.com/Nnoggie/MythicDungeonTools/issues",
    texture = { "Interface\\AddOns\\MythicDungeonTools\\Textures\\github", 0, 1, 0, 1 },
  },
  {
    name = "Discord",
    tooltip = L["Provide feedback in Discord"],
    url = "https://discord.gg/tdxMPb3",
    texture = { "Interface\\AddOns\\MythicDungeonTools\\Textures\\icons", 0.5, .75, 0.75, 1 },
  },
  {
    name = "Patreon",
    tooltip = L["Support MDT on Patreon"],
    url = "https://www.patreon.com/nnoggie",
    texture = { "Interface\\AddOns\\MythicDungeonTools\\Textures\\patreon", 0, 1, 0, 1 },
  },
}

function MDT:CreateCopyableLinkRow(parent, name, url, options)
  options = options or {}
  local parentFrame = parent.frame or parent
  local buttonWidth = options.buttonWidth or 64
  local buttonGap = options.buttonGap or 3
  local rowWidth = options.width or 440
  local editBoxWidth = rowWidth - buttonWidth - buttonGap
  local copyHelperAnchor = options.copyHelperAnchor or parentFrame
  local copyHelperX = options.copyHelperX or 0
  local copyHelperY = options.copyHelperY or 0
  local editBoxText = url

  local editBox = AceGUI:Create("EditBox")
  local copyButton = AceGUI:Create("Button")
  local row = {
    editBox = editBox,
    copyButton = copyButton,
  }

  local function getLabel(labelName)
    if options.label then return options.label end
    if options.addColon then return labelName..":" end
    return labelName
  end

  local function selectEditBox()
    if not MDT.copyHelper then
      MDT:MakeCopyHelper(copyHelperAnchor)
    end
    editBox:HighlightText(0, string.len(editBoxText))
    editBox:SetFocus()
    MDT.copyHelper:SmartShow(copyHelperAnchor, copyHelperX, copyHelperY)
  end

  function row:SetLink(linkName, linkUrl)
    editBoxText = linkUrl
    editBox.myText = linkUrl
    editBox:SetLabel(getLabel(linkName))
    if options.hideLabel and editBox.label then editBox.label:Hide() end
    editBox:SetText(linkUrl)
    editBox.editbox:SetCursorPosition(0)
  end

  editBox:DisableButton(true)
  editBox:SetWidth(editBoxWidth)
  editBox:SetCallback("OnTextChanged", function(widget)
    widget:SetText(editBoxText)
    widget.editbox:SetCursorPosition(0)
  end)
  editBox.editbox:HookScript("OnEditFocusLost", function()
    editBox.editbox:SetCursorPosition(0)
    if MDT.copyHelper then MDT.copyHelper:SmartHide() end
  end)
  editBox.editbox:SetScript("OnKeyUp", function(_, key)
    if MDT.copyHelper and MDT.copyHelper:WasControlKeyDown() and key == "C" then
      editBox:ClearFocus()
      if options.closeFrameOnCopy then
        options.closeFrameOnCopy:Hide()
      end
      MDT.copyHelper:SmartFadeOut()
    elseif MDT.copyHelper then
      MDT.copyHelper:SmartHide()
    end
  end)

  copyButton:SetWidth(buttonWidth)
  copyButton:SetText(L["Copy"])
  copyButton:SetCallback("OnClick", selectEditBox)

  if options.point then
    local xOffset = options.xOffset or 0
    local yOffset = options.yOffset or 0
    editBox.frame:SetParent(parentFrame)
    editBox.frame:ClearAllPoints()
    editBox.frame:SetPoint("TOPLEFT", parentFrame, "TOPLEFT", xOffset, yOffset)
    editBox.frame:Show()
    copyButton.frame:SetParent(parentFrame)
    copyButton.frame:ClearAllPoints()
    copyButton.frame:SetPoint("BOTTOMLEFT", editBox.frame, "BOTTOMRIGHT", buttonGap, 0)
    copyButton.frame:Show()
  else
    parent:AddChild(editBox)
    parent:AddChild(copyButton)
  end

  row:SetLink(name, url)

  return row
end

function MDT:CreateExternalLinkButtons(frame)
  local externalButtonGroup = AceGUI:Create("SimpleGroup")
  MDT:FixAceGUIShowHide(externalButtonGroup, frame)
  externalButtonGroup.frame:ClearAllPoints()
  externalButtonGroup.frame:SetParent(frame.bottomPanel)
  if not externalButtonGroup.frame.SetBackdrop then
    Mixin(externalButtonGroup.frame, BackdropTemplateMixin)
  end
  externalButtonGroup.frame:SetBackdropColor(0, 0, 0, 0)
  externalButtonGroup:SetHeight(40)
  externalButtonGroup:SetPoint("LEFT", frame.bottomLeftPanelString, "RIGHT", 0, 0)
  externalButtonGroup:SetLayout("Flow")
  externalButtonGroup.frame:SetFrameStrata("High")
  externalButtonGroup.frame:SetFrameLevel(7)
  externalButtonGroup.frame:ClearBackdrop()
  frame.externalButtonGroup = externalButtonGroup

  for _, dest in ipairs(MDT.externalLinks) do
    local button = AceGUI:Create("Icon")
    button:SetImage(unpack(dest.texture))
    button:SetCallback("OnClick", function()
      MDT:ShowExternalLinkCopyFrame(dest)
      MDT:ToggleToolbarTooltip(false)
    end)
    button.tooltipText = dest.tooltip
    button:SetWidth(24)
    button:SetImageSize(20, 20)
    button:SetCallback("OnEnter", function(widget)
      MDT:ToggleToolbarTooltip(true, widget, "ANCHOR_TOPLEFT")
    end)
    button:SetCallback("OnLeave", function()
      MDT:ToggleToolbarTooltip(false)
    end)
    externalButtonGroup:AddChild(button)
  end
end

function MDT:ShowExternalLinkCopyFrame(link)
  if not MDT.externalLinkCopyFrame then
    local frame = CreateFrame("Frame", "MDTExternalLinkCopyFrame", MDT.main_frame, "BackdropTemplate")
    MDT.externalLinkCopyFrame = frame
    frame:SetFrameStrata("HIGH")
    frame:SetFrameLevel(50)
    frame:SetSize(300, 50)
    frame:EnableMouse(true)
    frame.bgTex = frame:CreateTexture(nil, "BACKGROUND", nil, 0)
    frame.bgTex:SetAllPoints()
    frame.bgTex:SetDrawLayer("BORDER", -5)
    frame.bgTex:SetColorTexture(unpack(MDT.BackdropColor))
    frame:Hide()

    frame.close = CreateFrame("Button", nil, frame, "UIPanelCloseButton")
    frame.close:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -2, -2)
    frame.close:SetScript("OnClick", function()
      frame:Hide()
      if MDT.copyHelper then MDT.copyHelper:SmartHide() end
    end)

    frame.linkRow = MDT:CreateCopyableLinkRow(frame, link.name, link.url, {
      width = 258,
      buttonWidth = 64,
      point = true,
      xOffset = 10,
      yOffset = -2,
      copyHelperAnchor = MDT.main_frame,
      copyHelperY = 50,
      closeFrameOnCopy = frame,
    })
  end

  local frame = MDT.externalLinkCopyFrame
  if frame:IsShown() and frame.currentLinkName == link.name then
    frame:Hide()
    if MDT.copyHelper then MDT.copyHelper:SmartHide() end
    return
  end
  MDT:HideAllDialogs()
  if MDT.copyHelper then MDT.copyHelper:SmartHide() end
  frame.linkRow:SetLink(link.name, link.url)
  frame.currentLinkName = link.name
  frame:SetParent(MDT.main_frame)
  frame:SetFrameStrata("HIGH")
  frame:ClearAllPoints()
  frame:SetPoint("BOTTOMLEFT", MDT.main_frame, "BOTTOMLEFT", 0, 0)
  frame:Show()
end
