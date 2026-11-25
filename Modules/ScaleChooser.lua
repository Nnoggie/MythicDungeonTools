local _, MDT = ...
local L = MDT.L
local UI = MDT.UI

-- The sizes offered, as MDT scales. MDT starts at 100%.
local SIZES = {
  { scale = 0.85, label = "Smaller" },
  { scale = 1, label = "Default" },
  { scale = 1.2, label = "Larger" },
  { scale = 1.4, label = "Largest" },
}

---Asks for an MDT size the first time MDT opens. Players who already moved the MDT scale off 100% never see it.
function MDT:ShowScaleChooser()
  local db = MDT:GetDB()
  if db.scaleChooserShown then return end
  if db.uiScale ~= 1 then
    db.scaleChooserShown = true
    return
  end
  -- An error report or another warning goes first; the chooser waits for the next open.
  if UI.Dialogs.Count() > 0 then return end

  local buttons = {}
  local function pick(dialog, scale)
    -- The chooser keeps its size on screen while MDT rescales behind it, so its buttons stay near the cursor. Set
    -- before the rescale, which redraws the borders for the chooser's new scale.
    dialog:SetScale(1 / scale)
    MDT:SetUserScale(scale)
    for index, button in ipairs(buttons) do button:SetSelected(SIZES[index].scale == db.uiScale) end
  end

  UI.Dialogs.Open({
    key = "scaleChooser",
    globalName = "MDTScaleChooserFrame",
    title = L["Choose your MDT size"],
    width = 400,
    pinned = true,
    -- Anchored to the map, so it moves with the window.
    place = { point = "CENTER", relativeTo = MDT.main_frame },
    onClose = function(dialog)
      -- Dialog frames are pooled: the next dialog gets this frame at scale 1, with borders one pixel thick again.
      dialog:SetScale(1)
      UI.Pixel.Refresh()
      db.scaleChooserShown = true
      MDT:Settings_Refresh()
    end,
    build = function(content, dialog)
      local columns = UI.Columns(content, { weights = { 1, 1, 1, 1 }, gap = "sm" })
      for index, size in ipairs(SIZES) do
        buttons[index] = UI.Button(columns[index], {
          id = "size"..index,
          text = ("%d%%"):format(math.floor(size.scale * 100 + 0.5)),
          height = "lg",
          selected = size.scale == db.uiScale,
          onClick = function() pick(dialog, size.scale) end,
        })
        UI.Text(columns[index], { text = L[size.label], font = "small", color = "text.muted", justify = "CENTER" })
      end
      UI.Text(content, { text = L["scaleChooserHint"]:format(L["Settings"], L["MDT Scale"]), font = "small", color = "text.muted" })
      local footer = UI.Row(content, { align = "end" })
      UI.Button(footer, { id = "done", text = L["Done"], variant = "primary", onClick = function() dialog:Close("confirm") end })
    end,
  })
end
