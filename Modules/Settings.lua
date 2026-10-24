local _, MDT = ...
local L = MDT.L
local UI = MDT.UI

local PAGE_WIDTH = 686
local PAGE_TOP = 45
local PAGE_BOTTOM = 15
local SWATCH_WIDTH = 56

local LSM = LibStub("LibSharedMedia-3.0")
---MDT's own font in LibSharedMedia, where other addons can pick it too.
local DEFAULT_FONT = "Archivo Narrow Bold"
LSM:Register("font", DEFAULT_FONT, UI.Fonts.defaultFile)

---The palette the user colors themselves.
local CUSTOM_PALETTE = 6
local paletteItems = UI.MenuModel.FromList({
  [1] = L["Rainbow"],
  [2] = L["Black and Yellow"],
  [3] = L["Red, Green and Blue"],
  [4] = L["High Contrast"],
  [5] = L["Color Blind Friendly"],
  [CUSTOM_PALETTE] = L["Custom"],
}, { 1, 2, 3, 4, 5, 6 })

local enemyForcesTooltipIcon = "|TInterface\\AddOns\\MythicDungeonTools\\Textures\\MDTMinimap:0:0|t"
local enemyForcesTooltipLabel = L["Enemy Info NPC Enemy Forces"]
local enemyForcesTooltipItems = UI.MenuModel.FromList({
  [1] = L["None"],
  [2] = enemyForcesTooltipIcon..enemyForcesTooltipLabel..": 1.2% (5)",
  [3] = enemyForcesTooltipIcon..enemyForcesTooltipLabel..": 5",
  [4] = enemyForcesTooltipIcon..enemyForcesTooltipLabel..": 1.2%",
  [5] = enemyForcesTooltipIcon.."1.2% (5)",
  [6] = enemyForcesTooltipIcon.."5",
  [7] = enemyForcesTooltipIcon.."1.2%",
}, { 1, 2, 4, 3, 5, 7, 6 })

local db
local page
---@type {control: MDT.UI.Control, value: (fun(): any)?, disabled: (fun(): boolean)?, hidden: (fun(): boolean)?}[]
local bindings = {}

local function sync()
  for _, binding in ipairs(bindings) do
    if binding.value then binding.control:SetValue(binding.value()) end
    if binding.disabled then binding.control:SetDisabled(binding.disabled()) end
    if binding.hidden then binding.control:SetHidden(binding.hidden()) end
  end
end

local function bind(control, value, disabled, hidden)
  bindings[#bindings + 1] = { control = control, value = value, disabled = disabled, hidden = hidden }
  return control
end

local function checkbox(parent, id, label, value, onChange, disabled)
  return bind(UI.Checkbox(parent, {
    id = id, label = label, value = value(), disabled = disabled and disabled() or false,
    onChange = function(checked)
      onChange(checked)
      sync()
    end,
  }), value, disabled)
end

local function recolorPulls(force)
  MDT:SetPresetColorPaletteInfo()
  MDT:RefreshSidebar()
  MDT:DrawAllHulls(nil, force)
end

---The user's font pick, else Archivo. A pick whose addon is missing stays picked and shows here: MDT draws in Archivo
---meanwhile and goes back to the pick once its addon returns. Nothing but the user's own pick changes it.
---@return string
local function currentFont()
  return db.font or DEFAULT_FONT
end

---Every font in LibSharedMedia, each name drawn in its font. LibSharedMedia only lists fonts made for the client's
---alphabet, so Archivo joins on other clients, and so does a pick whose addon is missing.
local function fontItems()
  local names = CopyTable(LSM:List("font"))
  if not tContains(names, DEFAULT_FONT) then table.insert(names, 1, DEFAULT_FONT) end
  if db.font and not tContains(names, db.font) then table.insert(names, 1, db.font) end
  local items = {}
  for _, name in ipairs(names) do
    local file = name == DEFAULT_FONT and UI.Fonts.defaultFile or LSM:Fetch("font", name, true)
    items[#items + 1] = { kind = "choice", key = name, text = name, value = name, font = file }
  end
  return items
end

---Saves the font pick. MDT builds its fonts once as it loads, so another font shows after a reload.
---@param name string
local function pickFont(name)
  db.font = name ~= DEFAULT_FONT and name or nil
  local file = name == DEFAULT_FONT and UI.Fonts.defaultFile or LSM:Fetch("font", name, true)
  if file == UI.Fonts.files.roman then return end
  UI.Dialogs.Confirm({
    key = "fontReload", title = L["Font"], text = L["fontReloadPrompt"],
    confirm = { text = L["Reload UI"], onClick = function() MDT:ReloadAndOpen() end }, cancel = { text = L["Later"] },
  })
end

local function fillCustomColors(row)
  local palette = db.colorPaletteInfo
  row:ReleaseChildren()
  row:Batch(function()
    for i = 1, palette.numberCustomColors do
      palette.customPaletteValues[i] = palette.customPaletteValues[i] or { 1, 1, 1 }
      local color = palette.customPaletteValues[i]
      UI.ColorSwatch(row, {
        id = "customColor"..i, label = tostring(i), width = SWATCH_WIDTH, color = { color[1], color[2], color[3], 1 },
        onChange = function(r, g, b)
          palette.customPaletteValues[i] = { r, g, b }
          recolorPulls()
        end,
      })
    end
  end)
end

local function buildGeneral(column)
  UI.Heading(column, { text = L["General"] })
  -- Applied on release: rescaling the page under the cursor while dragging would move the slider away.
  bind(UI.Slider(column, {
    id = "uiScale", label = L["MDT Scale"], min = 0.5, max = 3, step = 0.05, value = db.uiScale,
    format = function(value) return ("%d%%"):format(math.floor(value * 100 + 0.5)) end,
    onCommit = function(value) MDT:SetUserScale(value) end,
  }), function() return db.uiScale end)
  bind(UI.Dropdown(column, {
    id = "font", label = L["Font"], items = fontItems(), value = currentFont(), search = true, onChange = pickFont,
  }), currentFont)
  checkbox(column, "minimap", L["Enable Minimap Button"], function() return not db.minimap.hide end, function(value)
    if value then MDT:ShowMinimapButton() else MDT:HideMinimapButton() end
  end)
  if MDT:IsRetail() then
    checkbox(column, "compartment", L["Enable Compartment Button"], function() return not db.minimap.compartmentHide end, function(value)
      MDT:SetCompartmentButtonShown(value)
    end)
  end
  checkbox(column, "forcesCount", L["Use forces count"], function() return db.useForcesCount == true end, function(value)
    db.useForcesCount = value
    MDT:RefreshSidebar()
    MDT:DrawAllHulls()
  end)
  checkbox(column, "pullHealth", L["Show pull health"], function() return db.showPullButtonHealth == true end, function(value)
    db.showPullButtonHealth = value
    MDT:RefreshSidebar()
  end)
  checkbox(column, "autoPan", L["Auto pan to selected pull"], function() return db.autoPanToPull ~= false end, function(value)
    db.autoPanToPull = value
  end)
  bind(UI.Dropdown(column, {
    id = "enemyForcesTooltip", label = L["Enemy forces in tooltips"], items = enemyForcesTooltipItems, value = db.enemyForcesTooltip,
    onChange = function(value)
      db.enemyForcesTooltip = value
      if value ~= 1 then MDT:EnableEnemyForcesTooltip() end
    end,
  }), function() return db.enemyForcesTooltip end)
  checkbox(column, "alwaysOverwriteRoutes", L["Always overwrite matching routes on import"], function() return db.alwaysOverwriteRoutesByUID == true end, function(value)
    db.alwaysOverwriteRoutesByUID = value
  end)
  if MDT:IsRetail() then
    checkbox(column, "muteXalatath", L["Mute Xal'atath Voice Lines"], function() return db.muteXalatathVoiceLines == true end, function(value)
      db.muteXalatathVoiceLines = value
      MDT:SetXalatathVoiceLinesMuted(value)
    end)
  end
  checkbox(column, "announceReset", L["announceDungeonReset"], function() return db.announceDungeonReset == true end, function(value)
    db.announceDungeonReset = value
    if value then MDT:EnableDungeonResetAnnounceHook() end
  end)
  checkbox(column, "fadeOut", L["Make window transparent in combat"], function() return db.fadeOutDuringCombat == true end, function(value)
    db.fadeOutDuringCombat = value
    MDT:UpdateFadeEventRegistration()
  end)
  local fadeOutDisabled = function() return not db.fadeOutDuringCombat end
  bind(UI.Slider(column, {
    id = "fadeOutAlpha", label = L["Combat Transparency"], min = 0.1, max = 1, step = 0.1, format = "%.1f",
    value = db.fadeOutAlpha, disabled = fadeOutDisabled(),
    onChange = function(value) db.fadeOutAlpha = value end,
  }), function() return db.fadeOutAlpha end, fadeOutDisabled)

  UI.Heading(column, { text = L["Language"] })
  local changeLanguage = _G.SlashCmdList["ADDONLOCALE"]
  UI.Button(column, { id = "language", text = L["Change Language"], disabled = not changeLanguage, onClick = function() changeLanguage("") end })
  UI.Text(column, {
    text = changeLanguage and L["localeButtonTooltip2"] or L["localeButtonTooltip1"],
    color = changeLanguage and "text.secondary" or "text.muted",
  })
end

local function buildColors(column)
  UI.Heading(column, { text = L["Colors"] })
  checkbox(column, "autoColoring", L["Automatically color pulls"], function() return db.colorPaletteInfo.autoColoring == true end, function(value)
    db.colorPaletteInfo.autoColoring = value
    MDT:SetPresetColorPaletteInfo()
    if value then
      MDT:RefreshSidebar()
      MDT:DrawAllHulls(nil, true)
    end
  end)
  checkbox(column, "colorBlindMode", L["Local color blind mode"], function() return db.colorPaletteInfo.forceColorBlindMode == true end, function(value)
    db.colorPaletteInfo.forceColorBlindMode = value
    recolorPulls(true)
  end, function()
    -- Routes keep their own auto coloring, so a mode that is on must stay switchable off.
    return not db.colorPaletteInfo.autoColoring and not db.colorPaletteInfo.forceColorBlindMode
  end)
  bind(UI.Dropdown(column, {
    id = "palette", label = L["Choose preferred color palette"], items = paletteItems, value = db.colorPaletteInfo.colorPaletteIdx,
    onChange = function(value)
      db.colorPaletteInfo.colorPaletteIdx = value
      recolorPulls(true)
      sync()
    end,
  }), function() return db.colorPaletteInfo.colorPaletteIdx end)
  -- Re-applies the palette to an imported route without toggling auto coloring or switching palettes back and forth.
  UI.Button(column, {
    id = "applyToPreset", text = L["Apply to preset"],
    onClick = function()
      db.colorPaletteInfo.autoColoring = true
      recolorPulls(true)
      sync()
    end,
  })

  -- Only for the custom palette, the one these colors make up.
  local customHidden = function() return db.colorPaletteInfo.colorPaletteIdx ~= CUSTOM_PALETTE end
  local custom = bind(UI.Stack(column, { id = "customPalette", gap = "md", hidden = customHidden() }), nil, nil, customHidden)
  UI.Heading(custom, { text = L["Custom Color Palette"] })
  local swatches
  UI.Slider(custom, {
    id = "customColorCount", label = L["Choose number of colors"], min = 2, max = 20, step = 1,
    value = db.colorPaletteInfo.numberCustomColors,
    onCommit = function(value)
      db.colorPaletteInfo.numberCustomColors = value
      recolorPulls()
      fillCustomColors(swatches)
    end,
  })
  swatches = UI.Row(custom, { id = "customColors", wrap = true, gap = "sm" })
  fillCustomColors(swatches)
end

MDT:RegisterNavigationSection({
  key = "settings",
  name = L["Settings"],
  tooltip = L["Settings"],
  texture = "Interface\\AddOns\\"..MDT.AddonName.."\\Textures\\icons",
  texCoords = { 0, 0.25, 0.25, 0.5 },
  iconSize = 25,
  iconOffsetX = 0.75,
  onShow = function()
    MDT:Settings_Refresh()
  end,
})

---Re-reads every setting from the saved variables. Call after changing one outside the settings page.
function MDT:Settings_Refresh()
  if page then sync() end
end

function MDT:MakeSettingsFrame(frame)
  if page then return end
  db = MDT:GetDB()
  if not db then return end

  local content = frame.sectionContentFrames.settings
  page = UI.Scroll(content, { padding = "md" })
  page:SetPoint("TOP", content, "TOP", 0, -PAGE_TOP)
  page:SetPoint("BOTTOM", content, "BOTTOM", 0, PAGE_BOTTOM)
  page:SetWidth(PAGE_WIDTH)
  page.content:Batch(function()
    local columns = UI.Columns(page.content, { gap = "xl" })
    columns[1]:SetGap("md")
    columns[2]:SetGap("md")
    buildGeneral(columns[1])
    buildColors(columns[2])
  end)
end
