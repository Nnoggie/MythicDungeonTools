local _, MDT = ...
local L = MDT.L
local UI = MDT.UI

local ATLAS = "Interface\\AddOns\\MythicDungeonTools\\Textures\\icons"

MDT.externalLinks = {
  {
    name = "GitHub",
    tooltip = L["Open an issue on GitHub"],
    url = "https://github.com/Nnoggie/MythicDungeonTools/issues",
    icon = "Interface\\AddOns\\MythicDungeonTools\\Textures\\github",
  },
  {
    name = "Discord",
    tooltip = L["Provide feedback in Discord"],
    url = "https://discord.gg/tdxMPb3",
    icon = ATLAS,
    iconCoords = { 0.5, 0.75, 0.75, 1 },
  },
  {
    name = "Patreon",
    hideInErrorFrame = true,
    tooltip = L["Support MDT on Patreon"],
    url = "https://www.patreon.com/nnoggie",
    icon = "Interface\\AddOns\\MythicDungeonTools\\Textures\\patreon",
  },
  {
    name = "Donate",
    hideInErrorFrame = true,
    label = L["Donate"],
    tooltip = L["Support MDT with a donation"],
    url = "https://streamlabs.com/nnoggie/tip",
    icon = "Interface\\AddOns\\MythicDungeonTools\\Textures\\donate",
  },
}

local linkButtons

---A labeled read-only link and a Copy button. Copy selects the link and shows the Ctrl+C hint centered on `anchor`.
---@param parent table kit container, or a plain frame the caller anchors the returned row in
---@param spec {label: string?, url: string, anchor: table, width: number?, onCopied: fun()?}
---@return MDT.UI.Control row
function MDT:AddCopyableLinkRow(parent, spec)
  local row = UI.Row(parent, { gap = "sm", valign = "end", width = spec.width })
  local editBox, copyButton
  editBox = UI.EditBox(row, {
    label = spec.label, value = spec.url, readOnly = true, selectAllOnFocus = true, grow = 1,
    onFocusLost = function()
      copyButton:SetDisabled(false)
      MDT.copyHelper:SmartHide()
    end,
    onCopy = function()
      MDT.copyHelper:SmartFadeOut()
      editBox:ClearFocus()
      if spec.onCopied then spec.onCopied() end
    end,
  })
  copyButton = UI.Button(row, { text = L["Copy"], width = 64, onClick = function()
    editBox:Focus()
    editBox:SelectAll()
    copyButton:SetDisabled(true)
    MDT.copyHelper:SmartShow(spec.anchor, 0, 0)
  end })
  return row
end

---Sets the button's highlight texture to match the navigation sidebar hover, inset vertically by yInset
function MDT:CreateHoverHighlight(button, yInset)
  yInset = yInset or 0
  local highlight = button:CreateTexture(nil, "HIGHLIGHT", nil, 0)
  highlight:SetPoint("TOPLEFT", 0, -yInset)
  highlight:SetPoint("BOTTOMRIGHT", 0, yInset)
  highlight:SetColorTexture(1, 1, 1, 0.08)
  button:SetHighlightTexture(highlight)
  return highlight
end

---The version check, the error report and the link box share the map's bottom-left corner; only one is open at a time.
function MDT:CloseBottomLeftPanels()
  for _, key in ipairs({ "versionCheck", "errors", "externalLink" }) do
    local dialog = UI.Dialogs.Get(key)
    if dialog then dialog:Close("replaced") end
  end
end

local shownLink

---Opens the link box in the map's bottom-left corner, where MDT always showed it, or closes it when it already shows
---this link. Like the version check it is a panel, not a popover: clicks elsewhere, such as on another link icon, reach
---what they click.
---@param link table an entry of MDT.externalLinks
function MDT:ToggleExternalLink(link)
  local open = UI.Dialogs.Get("externalLink")
  if open and shownLink == link then
    open:Close("api")
    return
  end
  MDT:CloseBottomLeftPanels()
  shownLink = link
  UI.Dialogs.Open({
    key = "externalLink", title = link.name, width = 420, pinned = true,
    place = { point = "BOTTOMLEFT", relativeTo = MDT.main_frame },
    onClose = function()
      shownLink = nil
      MDT.copyHelper:SmartHide()
    end,
    build = function(content, dialog)
      MDT:AddCopyableLinkRow(content, {
        url = link.url, anchor = MDT.main_frame,
        onCopied = function() dialog:Close("copied") end,
      })
    end,
  })
end

---The link icons right of the version text, plus the error report button that stays hidden until an error is caught.
function MDT:CreateExternalLinkButtons(frame)
  linkButtons = UI.Row(frame.bottomPanel, { gap = "xs", width = 300 })
  linkButtons:SetPoint("LEFT", frame.bottomLeftPanelString, "RIGHT", UI.Theme.Space("sm"), 0)
  linkButtons:SetFrameStrata("HIGH")
  linkButtons:SetFrameLevel(7)
  for _, link in ipairs(MDT.externalLinks) do
    UI.Button(linkButtons, {
      id = link.name, variant = "plain", icon = link.icon, iconCoords = link.iconCoords, iconSize = 18,
      text = link.label, width = not link.label and 24 or nil, height = "sm", tooltip = link.tooltip,
      onClick = function() MDT:ToggleExternalLink(link) end,
    })
  end
  UI.Button(linkButtons, {
    id = "errors", variant = "plain", icon = ATLAS, iconCoords = { 0.76, 1, 0.25, 0.5 }, iconSize = 18, iconColor = "warn",
    width = 24, height = "sm", hidden = true, tooltip = L["encounteredErrors"],
    onClick = function() MDT:DisplayErrors(true) end,
  })
end

---@param id string a link name, or "errors"
---@return MDT.UI.Control?
function MDT:GetExternalLinkButton(id)
  return linkButtons and linkButtons:Find(id)
end

function MDT:ShowErrorReportButton()
  MDT:GetExternalLinkButton("errors"):SetHidden(false)
end
