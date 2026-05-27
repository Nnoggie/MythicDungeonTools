local _, MDT = ...
local L = MDT.L
local mainFrameStrata = "HIGH"
local panelHeight = 30

local AceGUI = LibStub("AceGUI-3.0")
local minimapIcon = LibStub("LibDBIcon-1.0")

---Dropdown menu items for color settings frame
local colorPaletteNames = {
  [1] = L["Rainbow"],
  [2] = L["Black and Yellow"],
  [3] = L["Red, Green and Blue"],
  [4] = L["High Contrast"],
  [5] = L["Color Blind Friendly"],
  [6] = L["Custom"],
}

local enemyForcesTooltipIcon = "|TInterface\\AddOns\\MythicDungeonTools\\Textures\\MDTMinimap:0:0|t"
local enemyForcesTooltipLabel = L["Enemy Info NPC Enemy Forces"]
local enemyForcesTooltipOptions = {
  [1] = "None",
  [2] = enemyForcesTooltipIcon..enemyForcesTooltipLabel..": 1.2% (5)",
  [3] = enemyForcesTooltipIcon..enemyForcesTooltipLabel..": 5",
  [4] = enemyForcesTooltipIcon..enemyForcesTooltipLabel..": 1.2%",
  [5] = enemyForcesTooltipIcon.."1.2% (5)",
  [6] = enemyForcesTooltipIcon.."5",
  [7] = enemyForcesTooltipIcon.."1.2%",
}
local enemyForcesTooltipOptionOrder = { 1, 2, 4, 3, 5, 7, 6 }

function MDT:ToggleSettingsDialog()
  local db = MDT:GetDB()
  if not db then return end

  if not MDT.main_frame.settingsFrame then
    MDT:MakeSettingsFrame(MDT.main_frame)
  end
  MDT:SetCurrentSection("settings")
  if db.colorPaletteInfo.colorPaletteIdx == 6 then
    MDT:OpenCustomColorsDialog()
  end
end

function MDT:OpenCustomColorsDialog()
  if not MDT.main_frame.settingsFrame then
    MDT:MakeSettingsFrame(MDT.main_frame)
  end
  MDT:SetCurrentSection("settings")
  MDT:Settings_RefreshLayout()
end

function MDT:Settings_RefreshLayout()
  local frame = MDT.main_frame
  if not frame or not frame.settingsFrame then return end

  frame.settingsFrame.frame:Show()
  if frame.settingsGeneralColumn then
    frame.settingsGeneralColumn.frame:Show()
    frame.settingsGeneralColumn:DoLayout()
  end
  if frame.settingsColorsColumn then
    frame.settingsColorsColumn.frame:Show()
    frame.settingsColorsColumn:DoLayout()
  end
  if frame.settingsFrame.CustomColorFrame then
    frame.settingsFrame.CustomColorFrame.frame:Show()
    frame.settingsFrame.CustomColorFrame:DoLayout()
  end
end

---creates frame housing settings for user customized color palette
function MDT:MakeCustomColorFrame(frame)
  local db = MDT:GetDB()
  if not db then return end

  --Base frame for custom palette setup
  if not frame.CustomColorFrame then
    local customColorParent = frame.settingsColorsColumn or frame
    frame.CustomColorFrame = AceGUI:Create("InlineGroup")
    frame.CustomColorFrame:SetTitle(L["Custom Color Palette"])
    frame.CustomColorFrame:SetWidth(frame.settingWidth or 250)
    frame.CustomColorFrame:SetLayout("Flow")
    customColorParent:AddChild(frame.CustomColorFrame)
  end

  frame.CustomColorFrame:ReleaseChildren()
  frame.CustomColorFrame.ColorPicker = {}

  --Slider to adjust number of different colors and remake the frame OnMouseUp
  frame.CustomColorFrame.ColorSlider = AceGUI:Create("Slider")
  frame.CustomColorFrame.ColorSlider:SetSliderValues(2, 20, 1)
  frame.CustomColorFrame.ColorSlider:SetLabel(L["Choose number of colors"])
  frame.CustomColorFrame.ColorSlider:SetRelativeWidth(1)
  frame.CustomColorFrame:AddChild(frame.CustomColorFrame.ColorSlider)
  frame.CustomColorFrame.ColorSlider:SetValue(db.colorPaletteInfo.numberCustomColors)
  frame.CustomColorFrame.ColorSlider:SetCallback("OnMouseUp", function(event, callbackName, value)
    if value > 20 then
      db.colorPaletteInfo.numberCustomColors = 20
    elseif value < 2 then
      db.colorPaletteInfo.numberCustomColors = 2
    else
      db.colorPaletteInfo.numberCustomColors = value
    end
    MDT:SetPresetColorPaletteInfo()
    MDT:ReloadPullButtons()
    MDT:MakeCustomColorFrame(frame)
    MDT:OpenCustomColorsDialog()
  end)

  --Loop to create as many colorpickers as requested limited by db.colorPaletteInfo.numberCustomColors
  for i = 1, db.colorPaletteInfo.numberCustomColors do
    frame.CustomColorFrame.ColorPicker[i] = AceGUI:Create("ColorPicker")
    if db.colorPaletteInfo.customPaletteValues[i] then
      frame.CustomColorFrame.ColorPicker[i]:SetColor(db.colorPaletteInfo.customPaletteValues[i][1],
        db.colorPaletteInfo.customPaletteValues[i][2], db.colorPaletteInfo.customPaletteValues[i][3])
    else
      db.colorPaletteInfo.customPaletteValues[i] = { 1, 1, 1 }
      frame.CustomColorFrame.ColorPicker[i]:SetColor(db.colorPaletteInfo.customPaletteValues[i][1],
        db.colorPaletteInfo.customPaletteValues[i][2], db.colorPaletteInfo.customPaletteValues[i][3])
    end
    frame.CustomColorFrame.ColorPicker[i]:SetLabel(" "..i)
    frame.CustomColorFrame.ColorPicker[i]:SetRelativeWidth(0.25)
    frame.CustomColorFrame.ColorPicker[i]:SetHeight(15)
    frame.CustomColorFrame.ColorPicker[i]:SetCallback("OnValueChanged", function(widget, event, r, g, b)
      db.colorPaletteInfo.customPaletteValues[i] = { r, g, b }
      MDT:SetPresetColorPaletteInfo()
      MDT:ReloadPullButtons()
    end)
    frame.CustomColorFrame:AddChild(frame.CustomColorFrame.ColorPicker[i])
  end
  if frame.settingsColorsColumn then
    frame.settingsColorsColumn:DoLayout()
  end
end

function MDT:MakeSettingsFrame(frame)
  if frame.settingsFrame then return end

  local db = MDT:GetDB()
  if not db then return end

  local parentFrame = frame.sectionContentFrames and frame.sectionContentFrames.settings or frame
  frame.settingsFrame = AceGUI:Create("SimpleGroup")
  frame.settingsFrame.frame:SetParent(parentFrame)
  frame.settingsFrame.frame:SetFrameStrata(mainFrameStrata)
  frame.settingsFrame.frame:SetFrameLevel(3)
  local columnWidth = 325
  local columnGap = 36
  local columnHeight = 450
  local frameWidth = (columnWidth * 2) + columnGap
  local settingWidth = columnWidth - 10
  frame.settingsFrame:SetWidth(frameWidth)
  frame.settingsFrame:SetHeight(columnHeight)
  frame.settingsFrame:SetAutoAdjustHeight(false)
  frame.settingsFrame.settingWidth = settingWidth
  frame.settingsFrame:SetLayout("Flow")
  frame.settingsFrame.frame:ClearAllPoints()
  frame.settingsFrame.frame:SetPoint("TOP", parentFrame, "TOP", 0, -(panelHeight + 15))

  local function createSettingsColumn(point, relativeTo, relativePoint, xOffset)
    local column = AceGUI:Create("SimpleGroup")
    column:SetParent(frame.settingsFrame)
    column.frame:SetFrameStrata(mainFrameStrata)
    column.frame:SetFrameLevel(frame.settingsFrame.frame:GetFrameLevel() + 1)
    column:SetWidth(columnWidth)
    column:SetHeight(columnHeight)
    column:SetLayout("Flow")
    column:SetAutoAdjustHeight(false)
    column.alignoffset = 0
    column.frame:ClearAllPoints()
    column.frame:SetPoint(point, relativeTo, relativePoint, xOffset, 0)
    column.frame:Show()
    return column
  end

  frame.settingsGeneralColumn = createSettingsColumn("TOPLEFT", frame.settingsFrame.content, "TOPLEFT", 0)
  frame.settingsColorsColumn = createSettingsColumn("TOPLEFT", frame.settingsGeneralColumn.frame, "TOPRIGHT", columnGap)
  frame.settingsFrame.settingsColorsColumn = frame.settingsColorsColumn

  frame.settingsHeading = AceGUI:Create("Heading")
  frame.settingsHeading:SetText(L["General"])
  frame.settingsHeading:SetFullWidth(true)
  frame.settingsGeneralColumn:AddChild(frame.settingsHeading)

  frame.minimapCheckbox = AceGUI:Create("CheckBox")
  frame.minimapCheckbox:SetLabel(L["Enable Minimap Button"])
  frame.minimapCheckbox:SetWidth(settingWidth)
  frame.minimapCheckbox:SetValue(not db.minimap.hide)
  frame.minimapCheckbox:SetCallback("OnValueChanged", function(widget, callbackName, value)
    db.minimap.hide = not value
    if not db.minimap.hide then
      minimapIcon:Refresh("MythicDungeonTools", db.minimap)
    else
      minimapIcon:Hide("MythicDungeonTools")
    end
  end)
  frame.settingsGeneralColumn:AddChild(frame.minimapCheckbox)

  frame.compartmentCheckbox = AceGUI:Create("CheckBox")
  frame.compartmentCheckbox:SetLabel(L["Enable Compartment Button"])
  frame.compartmentCheckbox:SetWidth(settingWidth)
  frame.compartmentCheckbox:SetValue(not db.minimap.compartmentHide)
  frame.compartmentCheckbox:SetCallback("OnValueChanged", function(widget, callbackName, value)
    db.minimap.compartmentHide = not value
    if not db.minimap.compartmentHide then
      minimapIcon:AddButtonToCompartment("MythicDungeonTools")
    else
      minimapIcon:RemoveButtonFromCompartment("MythicDungeonTools")
    end
  end)
  if MDT:IsRetail() then
    frame.settingsGeneralColumn:AddChild(frame.compartmentCheckbox)
  end

  frame.forcesCheckbox = AceGUI:Create("CheckBox")
  frame.forcesCheckbox:SetLabel(L["Use forces count"])
  frame.forcesCheckbox:SetWidth(settingWidth)
  frame.forcesCheckbox:SetValue(db.useForcesCount)
  frame.forcesCheckbox:SetCallback("OnValueChanged", function(widget, callbackName, value)
    db.useForcesCount = value
    MDT:ReloadPullButtons()
  end)
  frame.settingsGeneralColumn:AddChild(frame.forcesCheckbox)

  frame.enemyForcesTooltipDropdown = AceGUI:Create("Dropdown")
  frame.enemyForcesTooltipDropdown:SetList(enemyForcesTooltipOptions, enemyForcesTooltipOptionOrder)
  frame.enemyForcesTooltipDropdown:SetLabel(L["Enemy forces in tooltips"])
  frame.enemyForcesTooltipDropdown:SetWidth(settingWidth)
  frame.enemyForcesTooltipDropdown:SetValue(db.enemyForcesTooltip)
  frame.enemyForcesTooltipDropdown:SetCallback("OnValueChanged", function(widget, callbackName, value)
    db.enemyForcesTooltip = value
  end)
  frame.settingsGeneralColumn:AddChild(frame.enemyForcesTooltipDropdown)

  frame.alwaysOverwriteRoutesByUIDCheckbox = AceGUI:Create("CheckBox")
  frame.alwaysOverwriteRoutesByUIDCheckbox:SetLabel(L["Always overwrite matching routes on import"])
  frame.alwaysOverwriteRoutesByUIDCheckbox:SetWidth(settingWidth)
  frame.alwaysOverwriteRoutesByUIDCheckbox:SetValue(db.alwaysOverwriteRoutesByUID)
  frame.alwaysOverwriteRoutesByUIDCheckbox:SetCallback("OnValueChanged", function(widget, callbackName, value)
    db.alwaysOverwriteRoutesByUID = value
  end)
  frame.settingsGeneralColumn:AddChild(frame.alwaysOverwriteRoutesByUIDCheckbox)

  -- Initialize database values if they don't exist
  if db.fadeOutDuringCombat == nil then db.fadeOutDuringCombat = false end
  if db.fadeOutAlpha == nil then db.fadeOutAlpha = 0.5 end

  frame.fadeOutCheckbox = AceGUI:Create("CheckBox")
  frame.fadeOutCheckbox:SetLabel(L["Make window transparent in combat"])
  frame.fadeOutCheckbox:SetWidth(settingWidth)
  frame.fadeOutCheckbox:SetValue(db.fadeOutDuringCombat)
  frame.fadeOutCheckbox:SetCallback("OnValueChanged", function(widget, callbackName, value)
    db.fadeOutDuringCombat = value
    frame.fadeOutAlphaSlider:SetDisabled(not value)
    MDT:UpdateFadeEventRegistration()
  end)
  frame.settingsGeneralColumn:AddChild(frame.fadeOutCheckbox)

  frame.fadeOutAlphaSlider = AceGUI:Create("Slider")
  frame.fadeOutAlphaSlider:SetLabel(L["Combat Transparency"])
  frame.fadeOutAlphaSlider:SetWidth(settingWidth)
  frame.fadeOutAlphaSlider:SetSliderValues(0.1, 1.0, 0.1)
  frame.fadeOutAlphaSlider:SetValue(db.fadeOutAlpha)
  frame.fadeOutAlphaSlider:SetDisabled(not db.fadeOutDuringCombat)
  frame.fadeOutAlphaSlider:SetCallback("OnValueChanged", function(widget, callbackName, value)
    db.fadeOutAlpha = value
  end)
  frame.settingsGeneralColumn:AddChild(frame.fadeOutAlphaSlider)

  frame.colorsHeading = AceGUI:Create("Heading")
  frame.colorsHeading:SetText(L["Colors"])
  frame.colorsHeading:SetFullWidth(true)
  frame.settingsColorsColumn:AddChild(frame.colorsHeading)

  frame.AutomaticColorsCheck = AceGUI:Create("CheckBox")
  frame.AutomaticColorsCheck:SetLabel(L["Automatically color pulls"])
  frame.AutomaticColorsCheck:SetWidth(settingWidth)
  frame.AutomaticColorsCheck:SetValue(db.colorPaletteInfo.autoColoring)
  frame.AutomaticColorsCheck:SetCallback("OnValueChanged", function(widget, callbackName, value)
    db.colorPaletteInfo.autoColoring = value
    MDT:SetPresetColorPaletteInfo()
    frame.toggleForceColorBlindMode:SetDisabled(not value)
    if value then
      MDT:ReloadPullButtons(true)
    end
  end)
  frame.settingsColorsColumn:AddChild(frame.AutomaticColorsCheck)

  --Toggle local color blind mode
  frame.toggleForceColorBlindMode = AceGUI:Create("CheckBox")
  frame.toggleForceColorBlindMode:SetLabel(L["Local color blind mode"])
  frame.toggleForceColorBlindMode:SetWidth(settingWidth)
  frame.toggleForceColorBlindMode:SetValue(db.colorPaletteInfo.forceColorBlindMode)
  frame.toggleForceColorBlindMode:SetCallback("OnValueChanged", function(widget, callbackName, value)
    db.colorPaletteInfo.forceColorBlindMode = value
    MDT:SetPresetColorPaletteInfo()
    MDT:ReloadPullButtons(true)
  end)
  frame.settingsColorsColumn:AddChild(frame.toggleForceColorBlindMode)

  frame.PaletteSelectDropdown = AceGUI:Create("Dropdown")
  frame.PaletteSelectDropdown:SetList(colorPaletteNames)
  frame.PaletteSelectDropdown:SetLabel(L["Choose preferred color palette"])
  frame.PaletteSelectDropdown:SetWidth(settingWidth)
  frame.PaletteSelectDropdown:SetValue(db.colorPaletteInfo.colorPaletteIdx)
  frame.PaletteSelectDropdown:SetCallback("OnValueChanged", function(widget, callbackName, value)
    if value == 6 then
      db.colorPaletteInfo.colorPaletteIdx = value
      MDT:OpenCustomColorsDialog()
    else
      db.colorPaletteInfo.colorPaletteIdx = value
    end
    MDT:SetPresetColorPaletteInfo()
    MDT:ReloadPullButtons(true)
  end)
  frame.settingsColorsColumn:AddChild(frame.PaletteSelectDropdown)

  -- The reason this button exists is to allow altering colorPaletteInfo of an imported preset
  -- Without the need to untoggle/toggle or swap back and forth in the PaletteSelectDropdown
  frame.button = AceGUI:Create("Button")
  frame.button:SetText(L["Apply to preset"])
  frame.button:SetWidth(settingWidth)
  frame.button:SetCallback("OnClick", function(widget, callbackName)
    if not db.colorPaletteInfo.autoColoring then
      db.colorPaletteInfo.autoColoring = true
      frame.AutomaticColorsCheck:SetValue(db.colorPaletteInfo.autoColoring)
      frame.toggleForceColorBlindMode:SetDisabled(false)
    end
    MDT:SetPresetColorPaletteInfo()
    MDT:ReloadPullButtons(true)
  end)
  frame.settingsColorsColumn:AddChild(frame.button)

  MDT:MakeCustomColorFrame(frame.settingsFrame)

  frame.localeHeading = AceGUI:Create("Heading")
  frame.localeHeading:SetText(L["Language"])
  frame.localeHeading:SetFullWidth(true)
  frame.settingsGeneralColumn:AddChild(frame.localeHeading)

  frame.localeButton = AceGUI:Create("Button")
  frame.localeButton:SetText(L["Change Language"])
  frame.localeButton:SetWidth(settingWidth)
  local slashToFire = _G.SlashCmdList["ADDONLOCALE"]
  if not slashToFire then
    frame.localeButton:SetDisabled(true)
  else
    frame.localeButton:SetCallback("OnClick", function(widget, callbackName)
      slashToFire("")
    end)
  end
  frame.settingsGeneralColumn:AddChild(frame.localeButton)

  frame.localeLabel = AceGUI:Create("Label")
  if not slashToFire then
    frame.localeLabel:SetText("|cff808080"..L["localeButtonTooltip1"].."|r")
  else
    frame.localeLabel:SetText(L["localeButtonTooltip2"])
  end
  frame.settingsGeneralColumn:AddChild(frame.localeLabel)

  MDT:Settings_RefreshLayout()
end
