local _, MDT = ...
local L = MDT.L

local PREPATCH_RELEASE_TIMESTAMP = 1768950035
local MIDNIGHT_RELEASE_TIMESTAMP = 1772406035
local LEGACY_DOWNLOAD_LINKS = {
  { name = "Wago",       url = "https://addons.wago.io/addons/mythic-dungeon-tools-mdt-legacy" },
  { name = "CurseForge", url = "https://legacy.curseforge.com/wow/addons/mythic-dungeon-tools-mdt-legacy" },
}

local function addCopyableLinkRow(content, name, url, startCopyAction, stopCopyAction)
  local row = MDT.UI.Row(content, { gap = "sm", valign = "end" })
  local editBox, copyButton
  editBox = MDT.UI.EditBox(row, {
    label = name..":",
    value = url,
    width = 340,
    readOnly = true,
    selectAllOnFocus = true,
    onFocusLost = function() stopCopyAction(copyButton) end,
    onCopy = function()
      MDT.copyHelper:SmartFadeOut()
      editBox:ClearFocus()
    end,
  })
  copyButton = MDT.UI.Button(row, {
    text = L["Copy"],
    width = 100,
    onClick = function() startCopyAction(editBox, copyButton) end,
  })
end

function MDT:SetupPrePatchWarning()
  local db = MDT:GetDB()
  if not db then return end
  if db.prePatchWarningSeenFor == PREPATCH_RELEASE_TIMESTAMP then return end
  local now = time()
  if now < PREPATCH_RELEASE_TIMESTAMP then return end
  if now >= MIDNIGHT_RELEASE_TIMESTAMP then return end
  if not MDT.main_frame then return end

  MDT:HideAllDialogs()
  MDT.UI.Dialogs.Open({
    key = "prePatchWarning",
    globalName = "MDTPrePatchWarningFrame",
    title = L["MDT Legacy maps"],
    width = 520,
    onClose = function() MDT.copyHelper:SmartHide() end,
    build = function(content, dialog)
      MDT.UI.Text(content, { text = L["PREPATCH_LAUNCH_WARNING_TEXT"] })

      local function startCopyAction(editBox, copyButton)
        editBox:Focus()
        editBox:SelectAll()
        copyButton:SetDisabled(true)
        MDT.copyHelper:SmartShow(dialog, 0, 0)
      end

      local function stopCopyAction(copyButton)
        if copyButton then copyButton:SetDisabled(false) end
        MDT.copyHelper:SmartHide()
      end

      for _, link in ipairs(LEGACY_DOWNLOAD_LINKS) do
        addCopyableLinkRow(content, link.name, link.url, startCopyAction, stopCopyAction)
      end
    end,
  })
  db.prePatchWarningSeenFor = PREPATCH_RELEASE_TIMESTAMP
end
