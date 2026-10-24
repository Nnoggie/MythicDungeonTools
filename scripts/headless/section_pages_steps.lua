-- Harness steps for the settings-style navigation sections: Settings, Combat Logging and Focus Marker.
-- Driven through real frames. Not shipped code.
return function(ctx)
  local W, MDT, step, expect, click, render = ctx.W, ctx.MDT, ctx.step, ctx.expect, ctx.click, ctx.render
  local UI = MDT.UI
  local L = MDT.L
  local main = MDT.main_frame
  local db = MDT:GetDB()

  local function openSection(key)
    click(main.navigationSidebar.buttons[key])
    expect(MDT:GetCurrentSection() == key, "current section is "..tostring(MDT:GetCurrentSection()))
    for _, child in ipairs({ main.sectionContentFrames[key]:GetChildren() }) do
      if child.kit and child.kit.name == "Scroll" then
        expect(child:IsVisible(), key.." page is hidden")
        return child.content
      end
    end
    error(key.." has no kit page")
  end
  local function control(page, id)
    local found = page:Find(id)
    expect(found and found:IsVisible(), "control "..id.." is missing or hidden")
    return found
  end
  local function menuList()
    local menu = UI.Overlay.Top("menu")
    expect(menu and menu.frame:IsVisible(), "no menu is open")
    for _, child in ipairs(menu.frame.content.kitChildren) do
      if child.kit.name == "List" then return child end
    end
  end
  local function chooseFromMenu(text)
    local list = menuList()
    for index, item in ipairs(list.kitProps.items) do
      if item.text == text then
        list:ScrollTo(index, "nearest")
        click(list:GetRow(index))
        expect(UI.Overlay.Top("menu") == nil, "choosing "..text.." left the menu open")
        return
      end
    end
    error("the menu has no item "..text)
  end
  local function chooseFromDropdown(dropdown, text)
    click(dropdown.kitButton)
    chooseFromMenu(text)
  end
  local function toggle(page, id, read)
    local box = control(page, id)
    local before = read()
    click(box)
    expect(read() == not before and box:GetValue() == not before, id.." did not flip its saved value")
    return function()
      click(box)
      expect(read() == before, id.." did not flip back")
    end
  end

  step("kit button: onDragStart registers the left button and fires on drag", function()
    local dragged = 0
    local button = UI.Button(UIParent, { text = "Drag", onDragStart = function() dragged = dragged + 1 end })
    expect(W.state[button].dragButtons[1] == "LeftButton", "onDragStart did not register the left button for drag")
    W.fireScript(button, "OnDragStart")
    expect(dragged == 1, "OnDragStart did not reach onDragStart")
    button:Release()
    local plain = UI.Button(UIParent, { text = "Plain" })
    expect(plain == button, "setup: the pool did not hand back the released button")
    expect(#W.state[plain].dragButtons == 0, "a reacquired button without onDragStart is still registered for drag")
    W.fireScript(plain, "OnDragStart")
    expect(dragged == 1, "a released onDragStart still fired")
    plain:Release()
  end)

  step("settings: every checkbox flips its saved value and back", function()
    local page = openSection("settings")
    local options = {
      { "minimap", function() return not db.minimap.hide end },
      { "compartment", function() return not db.minimap.compartmentHide end },
      { "forcesCount", function() return db.useForcesCount == true end },
      { "pullHealth", function() return db.showPullButtonHealth == true end },
      { "autoPan", function() return db.autoPanToPull ~= false end },
      { "alwaysOverwriteRoutes", function() return db.alwaysOverwriteRoutesByUID == true end },
      { "muteXalatath", function() return db.muteXalatathVoiceLines == true end },
      { "announceReset", function() return db.announceDungeonReset == true end },
      { "fadeOut", function() return db.fadeOutDuringCombat == true end },
      { "autoColoring", function() return db.colorPaletteInfo.autoColoring == true end },
      { "colorBlindMode", function() return db.colorPaletteInfo.forceColorBlindMode == true end },
    }
    for _, option in ipairs(options) do toggle(page, option[1], option[2])() end
  end)

  step("settings: transparency follows the combat fade toggle and its slider saves the alpha", function()
    local page = openSection("settings")
    local slider = control(page, "fadeOutAlpha")
    local restore = toggle(page, "fadeOut", function() return db.fadeOutDuringCombat == true end)
    expect(slider:IsDisabled() == not db.fadeOutDuringCombat, "the transparency slider ignores the fade toggle")
    restore()
    expect(slider:IsDisabled() == not db.fadeOutDuringCombat, "the transparency slider did not follow the toggle back")
    local before, fading = db.fadeOutAlpha, db.fadeOutDuringCombat
    db.fadeOutDuringCombat = true
    MDT:Settings_Refresh()
    expect(not slider:IsDisabled(), "setup: the slider is still disabled")
    W.userDrag(slider.kitSlider, 0.3)
    expect(math.abs(db.fadeOutAlpha - 0.3) < 0.001, "dragging the slider saved alpha "..tostring(db.fadeOutAlpha))
    expect(slider.kitValueText:GetText() == "0.3", "the slider shows "..tostring(slider.kitValueText:GetText()))
    W.userDrag(slider.kitSlider, before)
    db.fadeOutDuringCombat = fading
    MDT:Settings_Refresh()
  end)

  step("settings: the minimap checkbox follows /mdt minimap and Settings_Refresh resyncs from saved variables", function()
    local page = openSection("settings")
    local box = control(page, "minimap")
    local before = not db.minimap.hide
    W.RunSlashCommand("/mdt minimap")
    expect(box:GetValue() == not before and box:GetValue() == not db.minimap.hide, "the checkbox did not follow /mdt minimap")
    W.RunSlashCommand("/mdt minimap")
    expect(box:GetValue() == before, "the checkbox did not follow /mdt minimap back")
    local overwrite = control(page, "alwaysOverwriteRoutes")
    local was = db.alwaysOverwriteRoutesByUID == true
    db.alwaysOverwriteRoutesByUID = not was
    MDT:Settings_Refresh()
    expect(overwrite:GetValue() == not was, "Settings_Refresh did not resync the overwrite checkbox")
    db.alwaysOverwriteRoutesByUID = was
    MDT:Settings_Refresh()
  end)

  step("settings: dropdowns save the enemy forces tooltip and the palette, which reaches the route", function()
    local page = openSection("settings")
    local tooltipBefore, paletteBefore, autoBefore = db.enemyForcesTooltip, db.colorPaletteInfo.colorPaletteIdx, db.colorPaletteInfo.autoColoring
    local tooltipDropdown = control(page, "enemyForcesTooltip")
    chooseFromDropdown(tooltipDropdown, L["None"])
    expect(db.enemyForcesTooltip == 1, "choosing None saved "..tostring(db.enemyForcesTooltip))
    chooseFromDropdown(tooltipDropdown, tooltipDropdown.kitProps.items[5].text)
    expect(db.enemyForcesTooltip == 5, "choosing the fifth format saved "..tostring(db.enemyForcesTooltip))
    db.colorPaletteInfo.autoColoring = true
    MDT:Settings_Refresh()
    chooseFromDropdown(control(page, "palette"), L["Custom"])
    expect(db.colorPaletteInfo.colorPaletteIdx == 6, "choosing Custom saved palette "..tostring(db.colorPaletteInfo.colorPaletteIdx))
    expect(MDT:GetCurrentPreset().colorPaletteInfo.colorPaletteIdx == 6, "the route did not take the custom palette")
    chooseFromDropdown(control(page, "palette"), L["Rainbow"])
    expect(MDT:GetCurrentPreset().colorPaletteInfo.colorPaletteIdx == 1, "the route did not take the rainbow palette")
    db.enemyForcesTooltip = tooltipBefore
    db.colorPaletteInfo.colorPaletteIdx, db.colorPaletteInfo.autoColoring = paletteBefore, autoBefore
    MDT:SetPresetColorPaletteInfo()
    MDT:Settings_Refresh()
    expect(control(page, "palette"):GetValue() == paletteBefore, "Settings_Refresh did not resync the palette dropdown")
  end)

  step("settings: the font dropdown saves a LibSharedMedia font and offers a reload, Archivo clears the pick", function()
    local page = openSection("settings")
    local dropdown = control(page, "font")
    expect(UI.Fonts.files.roman == UI.Fonts.defaultFile, "MDT does not draw in Archivo")
    -- A pick from an addon that is not loaded stays saved and shown, so it comes back with its addon.
    local missing = ctx.seeded and ctx.seeded.font
    expect(db.font == missing, ("loading changed the saved font %s to %s"):format(tostring(missing), tostring(db.font)))
    expect(dropdown:GetValue() == (missing or "Archivo Narrow Bold"), "the font dropdown shows "..tostring(dropdown:GetValue()))
    local reloads = 0
    local reload = ReloadUI
    ReloadUI = function() reloads = reloads + 1 end

    -- Each name is drawn in its font; the rows are reused, so a menu without fonts shows the body font again.
    click(dropdown.kitButton)
    local list = menuList()
    for index, item in ipairs(list.kitProps.items) do
      if item.text == "Morpheus" then list:ScrollTo(index, "nearest") end
    end
    local drawn = {}
    for index, item in ipairs(list.kitProps.items) do
      local row = list:GetRow(index)
      if row then drawn[item.text] = row.kitLabel:GetFont() end
    end
    expect(drawn["Morpheus"] == LibStub("LibSharedMedia-3.0"):Fetch("font", "Morpheus"), "Morpheus is drawn in "..tostring(drawn["Morpheus"]))
    UI.Overlay.PopAll("menu", "test")
    click(control(page, "palette").kitButton)
    local paletteRow = menuList():GetRow(1)
    expect(paletteRow.kitLabel:GetFont() == UI.Fonts.Get("body"):GetFont(), "a palette row kept a font name's font")
    UI.Overlay.PopAll("menu", "test")

    chooseFromDropdown(dropdown, "Friz Quadrata TT")
    expect(db.font == "Friz Quadrata TT", "choosing Friz Quadrata TT saved "..tostring(db.font))
    local dialog = UI.Dialogs.Get("fontReload")
    expect(dialog and dialog:IsVisible(), "picking another font offers no reload")
    click(dialog.content:Find("cancel"))
    expect(UI.Dialogs.Get("fontReload") == nil and reloads == 0, "Later did not close the reload prompt without reloading")
    expect(db.openAfterReload == nil, "Later still opens MDT after the next reload")
    chooseFromDropdown(dropdown, "Morpheus")
    click(UI.Dialogs.Get("fontReload").content:Find("confirm"))
    expect(reloads == 1, "Reload UI did not reload")
    expect(db.openAfterReload == true, "the font reload does not open MDT once it is back")
    db.openAfterReload = nil

    -- Back to the font MDT draws in now: nothing to reload.
    chooseFromDropdown(dropdown, "Archivo Narrow Bold")
    expect(db.font == nil, "choosing Archivo kept "..tostring(db.font))
    expect(UI.Dialogs.Get("fontReload") == nil, "choosing the font in use offers a reload")
    ReloadUI = reload
    db.font = missing
  end)

  step("settings: MDT opens once after a reload for a new font, and not on later logins", function()
    -- Fresh clients, booted from saved variables in another process; only the run that seeds its own boots them.
    if not ctx.seeded then return end
    local afterFontReload = ctx.bootWithSavedVariables("MythicDungeonToolsDB = { global = { openAfterReload = true } }", "--login-only")
    expect(afterFontReload:find("opened after login: true", 1, true), "MDT did not open after the font reload:\n"..afterFontReload:sub(-1500))
    expect(afterFontReload:find("openAfterReload: nil", 1, true), "MDT keeps opening on every login:\n"..afterFontReload:sub(-1500))
    local plainLogin = ctx.bootWithSavedVariables("MythicDungeonToolsDB = { global = {} }", "--login-only")
    expect(plainLogin:find("opened after login: false", 1, true), "MDT opened on a plain login:\n"..plainLogin:sub(-1500))
  end)

  step("settings: Apply to preset turns auto coloring on and unlocks color blind mode", function()
    local page = openSection("settings")
    if db.colorPaletteInfo.autoColoring then click(control(page, "autoColoring")) end
    expect(db.colorPaletteInfo.autoColoring == false, "setup: auto coloring is still on")
    expect(control(page, "colorBlindMode"):IsDisabled(), "color blind mode stays enabled without auto coloring")
    expect(MDT:GetCurrentPreset().colorPaletteInfo.autoColoring == false, "the route kept auto coloring")
    click(control(page, "applyToPreset"))
    expect(db.colorPaletteInfo.autoColoring == true and control(page, "autoColoring"):GetValue() == true, "Apply to preset did not turn auto coloring on")
    expect(not control(page, "colorBlindMode"):IsDisabled(), "Apply to preset left color blind mode disabled")
    expect(MDT:GetCurrentPreset().colorPaletteInfo.autoColoring == true, "Apply to preset did not reach the route")
  end)

  step("settings: the custom colors only show with the custom palette", function()
    local page = openSection("settings")
    local palette = db.colorPaletteInfo.colorPaletteIdx
    chooseFromDropdown(control(page, "palette"), L["Rainbow"])
    expect(not page:Find("customPalette"):IsVisible(), "the custom colors show with the rainbow palette")
    chooseFromDropdown(control(page, "palette"), L["Custom"])
    control(page, "customPalette")
    control(page, "customColorCount")
    db.colorPaletteInfo.colorPaletteIdx = 1
    MDT:Settings_Refresh()
    expect(not page:Find("customPalette"):IsVisible(), "Settings_Refresh did not hide the custom colors")
    db.colorPaletteInfo.colorPaletteIdx = palette
    MDT:SetPresetColorPaletteInfo()
    MDT:Settings_Refresh()
  end)

  step("settings: the custom color count rebuilds the swatches and a swatch saves its color", function()
    local page = openSection("settings")
    local palette = db.colorPaletteInfo.colorPaletteIdx
    chooseFromDropdown(control(page, "palette"), L["Custom"])
    local before = db.colorPaletteInfo.numberCustomColors
    local slider = control(page, "customColorCount")
    W.userDrag(slider.kitSlider, 5)
    expect(db.colorPaletteInfo.numberCustomColors == before, "the count saved before the mouse was released")
    W.fireScript(slider.kitSlider, "OnMouseUp", "LeftButton")
    W.settle(ctx.asyncIdle, 30)
    expect(db.colorPaletteInfo.numberCustomColors == 5, "the count saved "..tostring(db.colorPaletteInfo.numberCustomColors))
    expect(#control(page, "customColors").kitChildren == 5, "the swatch row has "..#control(page, "customColors").kitChildren.." swatches")
    render("settings custom palette", main)
    click(control(page, "customColor2"))
    expect(ColorPickerFrame:IsShown(), "the swatch did not open the color picker")
    local getColor = ColorPickerFrame.GetColorRGB
    ColorPickerFrame.GetColorRGB = function() return 0.2, 0.4, 0.6 end
    ColorPickerFrame.info.swatchFunc()
    ColorPickerFrame.GetColorRGB = getColor
    local saved = db.colorPaletteInfo.customPaletteValues[2]
    expect(saved[1] == 0.2 and saved[2] == 0.4 and saved[3] == 0.6, "the swatch saved "..table.concat(saved, ","))
    ColorPickerFrame.info.cancelFunc()
    ColorPickerFrame:Hide()
    W.userDrag(slider.kitSlider, before)
    W.fireScript(slider.kitSlider, "OnMouseUp", "LeftButton")
    W.settle(ctx.asyncIdle, 30)
    expect(#control(page, "customColors").kitChildren == before, "the swatch row did not grow back to "..before)
    db.colorPaletteInfo.colorPaletteIdx = palette
    MDT:SetPresetColorPaletteInfo()
    MDT:Settings_Refresh()
  end)

  step("settings: the language button is disabled without AddonLocale", function()
    local page = openSection("settings")
    expect(SlashCmdList.ADDONLOCALE == nil, "setup: the harness has AddonLocale")
    expect(control(page, "language"):IsDisabled(), "the language button is enabled without AddonLocale")
  end)

  local CONTENT_TYPES = { "lfr", "normal", "heroic", "mythic", "mythic_dungeon", "mythic_plus" }

  step("combat logging: the master toggle saves and gates every content checkbox", function()
    local settings = db.combatLogging
    local page = openSection("combatLogging")
    local restore = toggle(page, "enabled", function() return settings.enabled == true end)
    for _, contentType in ipairs(CONTENT_TYPES) do
      expect(control(page, contentType):IsDisabled() == not settings.enabled, contentType.." does not follow the master toggle")
    end
    restore()
    for _, contentType in ipairs(CONTENT_TYPES) do
      expect(control(page, contentType):IsDisabled() == not settings.enabled, contentType.." did not follow the master toggle back")
    end
  end)

  step("combat logging: every content checkbox flips its saved value and back, and reopening shows saved state", function()
    local settings = db.combatLogging
    local page = openSection("combatLogging")
    local wasEnabled = settings.enabled == true
    if not wasEnabled then click(control(page, "enabled")) end
    expect(settings.enabled == true, "setup: combat logging is still off")
    for _, contentType in ipairs(CONTENT_TYPES) do
      toggle(page, contentType, function() return settings.content[contentType] == true end)()
    end
    click(control(page, "mythic_plus"))
    local flipped = settings.content.mythic_plus
    click(main.navigationSidebar.buttons.maps)
    page = openSection("combatLogging")
    expect(control(page, "mythic_plus"):GetValue() == flipped, "reopening the section lost the saved content state")
    click(control(page, "mythic_plus"))
    render("combat logging section", main)
    if not wasEnabled then
      click(control(page, "enabled"))
      expect(settings.enabled == false, "turning combat logging off did not save")
    end
  end)

  local function playerFullName()
    local name, realm = UnitFullName("player")
    return realm and realm ~= "" and name.."-"..realm or name
  end

  step("focus marker: the player row picks a marker from its menu and the page shows it", function()
    local page = openSection("marks")
    local button = control(page, "marker1")
    click(button)
    local list = menuList()
    local star = list.kitProps.items[2].text
    expect(star:find("UI%-RaidTargetingIcon_1"), "the second menu item is not the star: "..tostring(star))
    chooseFromMenu(star)
    expect(MDT:FocusMarker_GetAssignments()[playerFullName()] == 1, "the star was not assigned to the player")
    W.settle(ctx.asyncIdle, 30)
    page = openSection("marks")
    expect(control(page, "marker1"):GetText() == star, "the rebuilt marker button shows "..tostring(control(page, "marker1"):GetText()))
    expect(control(page, "marker5"):IsDisabled(), "an empty roster row has an enabled marker button")
  end)

  step("focus marker: every checkbox saves, and the macro options rewrite the preview", function()
    local settings = db.focusMarker
    local page = openSection("marks")
    local preview = control(page, "macroPreview")
    for _, id in ipairs({ "announceReadyCheck", "useMacro", "suppressNotifications" }) do
      toggle(page, id, function() return settings[id] == true end)()
    end
    local probes = { disableMouseoverFocus = "@mouseover", disableTargetMarkerInRaid = "/stopmacro", preserveExistingTargetMarkers = "~" }
    for id, probe in pairs(probes) do
      local had = preview:GetValue():find(probe, 1, true) ~= nil
      local restore = toggle(page, id, function() return settings[id] == true end)
      local has = preview:GetValue():find(probe, 1, true) ~= nil
      expect(has ~= had, id.." did not change the macro preview: "..preview:GetValue())
      restore()
      expect((preview:GetValue():find(probe, 1, true) ~= nil) == had, id.." did not restore the macro preview")
    end
    local before = preview:GetValue()
    W.userClick(preview.kitEdit)
    W.userType(preview.kitEdit, "x")
    expect(preview:GetValue() == before and preview.kitEdit:GetText() == before, "the read-only macro preview took typing")
    preview:ClearFocus()
  end)

  step("focus marker: the macro icon follows Use macro, explains itself and drags the macro out", function()
    local settings = db.focusMarker
    local page = openSection("marks")
    local icon = page:Find("macroIcon")
    if settings.useMacro then click(control(page, "useMacro")) end
    expect(not icon:IsVisible(), "the macro icon shows without Use macro")
    click(control(page, "useMacro"))
    expect(settings.useMacro == true and icon:IsVisible(), "the macro icon did not appear with Use macro")
    W.pump(0.05)
    local box = control(page, "useMacro")
    expect(icon:GetLeft() >= box:GetRight() and icon:GetLeft() - box:GetRight() < 12, "the macro icon is not right after the checkbox label")
    W.hover(icon)
    expect(MDTTooltip:IsShown() and MDTTooltip:GetOwner() == icon, "the macro icon shows no tooltip")
    W.fireScript(icon, "OnLeave")
    local pickupMacro, pickedUp = _G.PickupMacro, nil
    _G.PickupMacro = function(index) pickedUp = index end
    W.fireScript(icon, "OnDragStart")
    _G.PickupMacro = pickupMacro
    local macroIndex = _G["GetMacroIndexByName"](settings.macroName or "MDTFocusMarker")
    expect(macroIndex > 0 and pickedUp == macroIndex, "dragging the icon did not pick up the macro")
    render("focus marker section", main)
    click(control(page, "useMacro"))
    expect(settings.useMacro == false and not icon:IsVisible(), "the macro icon stayed after Use macro was cleared")
  end)

  step("focus marker: Auto Assign gives the player a marker and the action buttons run", function()
    local assignments = MDT:FocusMarker_GetAssignments()
    assignments[playerFullName()] = nil
    local page = openSection("marks")
    click(control(page, "autoAssign"))
    W.settle(ctx.asyncIdle, 30)
    expect(assignments[playerFullName()] ~= nil, "Auto Assign left the player without a marker")
    page = openSection("marks")
    click(control(page, "syncMarks"))
    click(control(page, "setKeybind"))
    expect(page:Find("syncWarning") == nil, "a solo roster shows the sync warning")
    click(main.navigationSidebar.buttons.maps)
    expect(MDT:IsMapSectionActive(), "the map section did not come back")
  end)
end
