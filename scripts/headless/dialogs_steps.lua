-- Harness steps for the dialogs group: route dialogs, confirmations, the error report, external links and the
-- version check, plus the kit pieces they added. Driven through real frames. Not shipped code.
return function(ctx)
  local W, MDT, step, expect, click, render = ctx.W, ctx.MDT, ctx.step, ctx.expect, ctx.click, ctx.render
  local UI = MDT.UI
  local L = MDT.L

  step("kit: a prompt places build controls under its field and names its footer buttons", function()
    local picked
    local dialog = UI.Dialogs.Prompt({ key = "kitPromptBuild", title = "Build", value = "Name",
      build = function(content) UI.Dropdown(content, { id = "extra", items = { { kind = "choice", text = "A", value = 1 } }, value = 1 }) end,
      confirm = { text = "Ok", onClick = function(text) picked = text end } })
    local input, extra = dialog.content:Find("input"), dialog.content:Find("extra")
    expect(input and extra and dialog.content:Find("confirm") and dialog.content:Find("cancel"), "prompt controls are not findable by id")
    expect(dialog.content:Find("alt") == nil, "a prompt without alt has an alt button")
    expect(select(2, input:GetCenter()) > select(2, extra:GetCenter()), "build control is not under the field")
    expect(select(2, extra:GetCenter()) > select(2, dialog.content:Find("confirm"):GetCenter()), "build control is not above the buttons")
    click(dialog.content:Find("confirm"))
    expect(picked == "Name" and UI.Dialogs.Get("kitPromptBuild") == nil, "confirm did not report the field value")
  end)

  step("kit: onPaste collects a burst outside the field and delivers it on the next frame", function()
    local pasted
    local dialog = UI.Dialogs.Open({ key = "kitPaste", title = "Paste", build = function(content)
      UI.EditBox(content, { id = "box", onPaste = function(text, box)
        pasted = text
        box:SetValue(text:sub(1, 4))
      end })
    end })
    local box = dialog.content:Find("box")
    click(box.kitField)
    local long = string.rep("abcdefghij", 300)
    expect(W.userType(box.kitEdit, long), "the paste box did not take focus")
    expect(#box.kitEdit:GetText() == 1, "the field took "..#box.kitEdit:GetText().." bytes during the burst")
    expect(pasted == nil, "onPaste fired before the burst ended")
    W.pump(0.05)
    expect(pasted == long, "onPaste delivered "..tostring(pasted and #pasted).." characters")
    expect(box:GetValue() == "abcd" and box.kitEdit:GetMaxBytes() == 0, "the field did not return to normal after the paste")
    dialog:Close("api")
  end)

  local db = MDT:GetDB()
  local main = MDT.main_frame
  local unusedPresetName, presetCount, asyncIdle = ctx.unusedPresetName, ctx.presetCount, ctx.asyncIdle
  local function snapshot(name, dialog)
    W.pump(0.05)
    ctx.snapshot(name, dialog)
  end
  local function openDialog(key)
    local dialog = UI.Dialogs.Get(key)
    expect(dialog and dialog:IsVisible(), key.." dialog not shown")
    return dialog
  end
  local function retype(dialog, text)
    local edit = dialog.content:Find("input").kitEdit
    edit:SetText("")
    expect(W.userType(edit, text), "the "..dialog.kitKey.." field does not have focus")
  end
  local function problemOf(dialog)
    for _, child in ipairs(dialog.content.kitChildren) do
      if child.kit.name == "Text" and child.kitProps.color == "warn" then return child end
    end
  end
  local function childOfKind(dialog, kind)
    for _, child in ipairs(dialog.content.kitChildren) do
      if child.kit.name == kind then return child end
    end
  end
  local function pulls() return MDT:GetCurrentPreset().value.pulls end

  step("dialogs: new route rejects a taken name and Enter creates it", function()
    local before = presetCount()
    MDT:OpenNewPresetDialog()
    local dialog = openDialog("newPreset")
    expect(dialog.content:Find("startingPoint"):GetValue() == 0, "new route does not start empty")
    local taken = db.presets[db.currentDungeonIdx][1].text
    retype(dialog, taken)
    local problem = problemOf(dialog)
    expect(dialog.content:Find("confirm"):IsDisabled() and problem:IsShown() and problem.kitProps.text:find(taken, 1, true), "a taken name is accepted")
    snapshot("new route dialog", dialog)
    local name = unusedPresetName("Headless Enter")
    retype(dialog, name)
    expect(not dialog.content:Find("confirm"):IsDisabled() and not problem:IsShown(), "a free name stays rejected")
    W.fireScript(dialog.content:Find("input").kitEdit, "OnEnterPressed")
    W.settle(asyncIdle, 30)
    expect(UI.Dialogs.Get("newPreset") == nil, "Enter did not close the new route dialog")
    expect(presetCount() == before + 1 and MDT:GetCurrentPreset().text == name, "Enter did not create the route")
  end)

  step("dialogs: rename has no ownership checkbox, rejects a taken name and Escape keeps the name", function()
    local current = MDT:GetCurrentPreset().text
    MDT:OpenRenamePresetDialog()
    local dialog = openDialog("renamePreset")
    expect(childOfKind(dialog, "Checkbox") == nil, "rename still offers a checkbox")
    expect(not problemOf(dialog):IsShown(), "the unchanged name shows a problem")
    retype(dialog, db.presets[db.currentDungeonIdx][1].text)
    expect(dialog.content:Find("confirm"):IsDisabled() and problemOf(dialog):IsShown(), "rename accepts a taken name")
    snapshot("rename dialog", dialog)
    W.fireScript(dialog.content:Find("input").kitEdit, "OnEscapePressed")
    expect(UI.Dialogs.Get("renamePreset") == nil, "Escape did not close the rename dialog")
    expect(MDT:GetCurrentPreset().text == current, "Escape renamed the route")
  end)

  step("dialogs: export selects the string, Select all shows the hint, Ctrl+C closes it", function()
    MDT:OpenExportDialog()
    local dialog = openDialog("export")
    local box = dialog.content:Find("text")
    expect(box.kitEdit:HasFocus() and MDT.copyHelper:IsShown(), "export did not focus the string with the copy hint")
    expect(box.kitLabel:GetText():find(MDT:GetCurrentPreset().text, 1, true), "export label does not name the route")
    local exported = box:GetValue()
    W.userType(box.kitEdit, "x")
    expect(box:GetValue() == exported, "the export string is editable")
    snapshot("export dialog", dialog)
    box:ClearFocus()
    expect(not MDT.copyHelper:IsShown(), "losing focus left the copy hint")
    click(dialog.content:Find("selectAll"))
    expect(box.kitEdit:HasFocus() and MDT.copyHelper:IsShown(), "Select all did not focus the string and show the hint")
    W.modifiers = { ctrl = true }
    W.fireScript(box.kitEdit, "OnKeyUp", "C")
    W.modifiers = nil
    expect(UI.Dialogs.Get("export") == nil, "Ctrl+C did not close the export dialog")
    expect(MDT.copyHelper.isFading, "Ctrl+C did not show the copied hint")
    W.settle(asyncIdle, 5)
  end)

  step("dialogs: an invalid import says why and keeps the dialog open", function()
    MDT:OpenImportPresetDialog()
    local dialog = openDialog("importPreset")
    expect(W.userType(dialog.content:Find("input").kitEdit, "this is not a route string"), "the import field does not have focus")
    W.pump(0.05)
    expect(UI.Dialogs.Get("importPreset") == dialog and problemOf(dialog):IsShown(), "an invalid paste did not explain itself")
    snapshot("import dialog", dialog)
    problemOf(dialog):SetHidden(true)
    click(dialog.content:Find("import"))
    expect(UI.Dialogs.Get("importPreset") == dialog and problemOf(dialog):IsShown(), "Import accepted an invalid string")
    MDT:HideAllDialogs()
    expect(UI.Dialogs.Count() == 0, "HideAllDialogs left a dialog open")
  end)

  step("dialogs: the large route warning shares on confirm and cancels on X", function()
    local realToString = MDT.TableToString
    MDT.TableToString = function() return string.rep("x", 4000) end
    local log = {}
    local function share() log[#log + 1] = "share" end
    local function cancel() log[#log + 1] = "cancel" end
    MDT:CheckPresetSize(share, cancel)
    snapshot("large route warning", openDialog("largePreset"))
    click(openDialog("largePreset").closeButton)
    MDT:CheckPresetSize(share, cancel)
    click(openDialog("largePreset").content:Find("confirm"))
    MDT:CheckPresetSize(share)
    click(openDialog("largePreset").content:Find("cancel"))
    MDT.TableToString = realToString
    expect(table.concat(log, ",") == "cancel,share", "share warning reported "..table.concat(log, ","))
  end)

  step("dialogs: an unanswered live update ends the live session", function()
    local preset = MDT:GetCurrentPreset()
    MDT:SetUniqueID(preset)
    local overwrite = db.alwaysOverwriteRoutesByUID
    db.alwaysOverwriteRoutesByUID = false
    MDT.liveSessionActive = true
    MDT:ImportPreset(CopyTable(preset), true)
    local dialog = openDialog("importOverwrite")
    expect(MDT.liveUpdateFrameOpen and dialog.content:Find("alt"), "a live update did not ask overwrite or copy")
    snapshot("import overwrite dialog", dialog)
    click(childOfKind(dialog, "Checkbox"))
    expect(db.alwaysOverwriteRoutesByUID == true, "the checkbox did not set always overwrite")
    db.alwaysOverwriteRoutesByUID = false
    click(dialog.closeButton)
    expect(not MDT.liveSessionActive and not MDT.liveUpdateFrameOpen, "closing the live update left the session running")
    MDT.liveSessionActive = true
    local before = presetCount()
    MDT:ImportPreset(CopyTable(preset), true)
    click(openDialog("importOverwrite").content:Find("confirm"))
    expect(MDT.liveSessionActive and presetCount() == before, "overwrite ended the session or added a route")
    MDT:LiveSession_Disable()
    db.alwaysOverwriteRoutesByUID = overwrite
    W.settle(asyncIdle, 30)
  end)

  step("dialogs: clear and delete all act only on confirm", function()
    MDT:AddPull()
    W.settle(asyncIdle, 30)
    local count = #pulls()
    MDT:OpenClearPresetDialog()
    click(openDialog("clearPreset").content:Find("cancel"))
    expect(#pulls() == count, "cancel cleared the route")
    MDT:OpenClearPresetDialog()
    snapshot("clear dialog", openDialog("clearPreset"))
    click(openDialog("clearPreset").content:Find("confirm"))
    W.settle(asyncIdle, 30)
    expect(#pulls() <= 1, "confirm did not clear the route: "..#pulls().." pulls")
    MDT:CreateNewPreset(unusedPresetName("Headless Doomed"))
    W.settle(asyncIdle, 30)
    expect(presetCount() > 1, "no extra route to delete")
    MDT:OpenDeleteAllPresetsDialog()
    snapshot("delete all dialog", openDialog("deleteAllPresets"))
    click(openDialog("deleteAllPresets").content:Find("confirm"))
    W.settle(asyncIdle, 30)
    expect(presetCount() == 1, "delete all left "..presetCount().." routes")
  end)

  step("dialogs: Escape closes the top dialog first", function()
    MDT:OpenRenamePresetDialog()
    MDT:OpenDeleteAllPresetsDialog()
    local rename = openDialog("renamePreset")
    W.fireScript(rename.content:Find("input").kitEdit, "OnEscapePressed")
    expect(UI.Dialogs.Get("renamePreset") == nil and UI.Dialogs.Get("deleteAllPresets"), "Escape in the rename field closed the wrong dialog")
    expect(CloseSpecialWindows(), "no special window closed")
    expect(UI.Dialogs.Count() == 0 and main:IsShown(), "Escape did not close the remaining dialog before the window")
    W.settle(asyncIdle, 5)
  end)

  local function linkBox() return UI.Dialogs.Get("externalLink") end

  step("external links: an icon opens its link, Copy shows the hint and Ctrl+C closes it", function()
    local button = MDT:GetExternalLinkButton("Discord")
    expect(button and button:IsVisible(), "the Discord link button is not visible")
    expect(MDT:GetExternalLinkButton("Donate"):GetText() == L["Donate"], "the donate button lost its label")
    expect(not MDT:GetExternalLinkButton("errors"):IsShown(), "the error button shows without errors")
    W.hover(button)
    expect(MDTTooltip:IsShown(), "hovering a link icon shows no tooltip")
    W.fireScript(button, "OnLeave")
    click(button)
    local box = linkBox()
    expect(box and box:IsVisible(), "clicking a link icon opened no link box")
    expect(math.abs(box:GetLeft() - main:GetLeft()) < 0.5 and math.abs(box:GetBottom() - main:GetBottom()) < 0.5,
      "the link box is not in the map's bottom-left corner")
    expect(box.kitTitle:GetText() == MDT.externalLinks[2].name, "the link box is not titled with its link")
    -- A panel, not a popover: nothing invisible covers the screen to swallow the next click.
    expect(UI.Overlay.Top("popover") == nil and UI.Overlay.Top("menu") == nil, "the link box catches clicks outside it")
    local row = box.content.kitChildren[1]
    local editBox, copy = row.kitChildren[1], row.kitChildren[2]
    expect(editBox:GetValue() == MDT.externalLinks[2].url, "the link box shows "..tostring(editBox:GetValue()))
    snapshot("external link box", box)
    click(copy)
    expect(editBox.kitEdit:HasFocus() and copy:IsDisabled() and MDT.copyHelper:IsShown(), "Copy did not select the link with the hint")
    W.modifiers = { ctrl = true }
    W.fireScript(editBox.kitEdit, "OnKeyUp", "C")
    W.modifiers = nil
    expect(linkBox() == nil, "Ctrl+C left the link box open")
    W.settle(asyncIdle, 5)
    click(MDT:GetExternalLinkButton("GitHub"))
    expect(linkBox(), "the GitHub icon opened no link box")
    expect(CloseSpecialWindows(), "no special window closed")
    expect(linkBox() == nil and main:IsShown(), "Escape did not close the link box before the window")
    W.settle(asyncIdle, 5)
    click(MDT:GetExternalLinkButton("GitHub"))
    click(linkBox().closeButton)
    expect(linkBox() == nil, "the link box's X did not close it")
    click(MDT:GetExternalLinkButton("GitHub"))
    click(MDT:GetExternalLinkButton("GitHub"))
    expect(linkBox() == nil, "clicking the open link's icon again did not close it")
  end)

  step("bottom left: the version check, the error report and the link box are never open together", function()
    MDT:ToggleVersionCheckFrame()
    expect(UI.Dialogs.Get("versionCheck"), "setup: the version check did not open")
    click(MDT:GetExternalLinkButton("GitHub"))
    expect(linkBox() and linkBox().kitTitle:GetText() == "GitHub" and UI.Dialogs.Get("versionCheck") == nil, "GitHub did not replace the version check")
    click(MDT:GetExternalLinkButton("Discord"))
    expect(linkBox() and linkBox().kitTitle:GetText() == "Discord", "one click on Discord did not switch the link box from GitHub")
    MDT:ToggleVersionCheckFrame()
    expect(UI.Dialogs.Get("versionCheck") and linkBox() == nil, "the version check opened over a link box")
    MDT:ToggleVersionCheckFrame()
    W.settle(asyncIdle, 5)
  end)

  step("error report: a caught error opens a copyable report and the bar button reopens it", function()
    local errors = MDT:GetErrors()
    local before = #errors
    MDT:OnError("headless test error", "headless stack line", "HeadlessTest")
    W.pump(0.6)
    local dialog = rawget(_G, "MDTErrorFrame")
    expect(dialog and dialog:IsVisible() and dialog == UI.Dialogs.Get("errors"), "the error report did not open as MDTErrorFrame")
    local box = dialog.content:Find("errorText")
    expect(box:GetValue():find("1x: HeadlessTest: headless test error", 1, true) and box:GetValue():find("headless stack line", 1, true), "the report text misses the error")
    snapshot("error report", dialog)
    local copy = dialog.content:Find("copyError")
    click(copy)
    expect(box.kitEdit:HasFocus() and copy:IsDisabled() and MDT.copyHelper:IsShown(), "Copy error did not select the report with the hint")
    W.modifiers = { ctrl = true }
    W.fireScript(box.kitEdit, "OnKeyUp", "C")
    W.modifiers = nil
    expect(not box.kitEdit:HasFocus() and not copy:IsDisabled(), "Ctrl+C did not finish the copy")
    W.settle(asyncIdle, 5)
    click(dialog.content:Find("hardReset"))
    W.settle(asyncIdle, 30)
    local confirm = openDialog("hardReset")
    expect(confirm:GetFrameLevel() > dialog:GetFrameLevel(), "the hard reset prompt opened under the report")
    click(confirm.content:Find("cancel"))
    expect(rawget(_G, "MDTErrorFrame") == dialog, "cancelling the hard reset closed the report")
    expect(CloseSpecialWindows(), "no special window closed")
    expect(rawget(_G, "MDTErrorFrame") == nil and main:IsShown(), "Escape did not close the report before the window")
    W.settle(asyncIdle, 5)
    local errorButton = MDT:GetExternalLinkButton("errors")
    expect(errorButton:IsVisible(), "the error button did not appear")
    click(errorButton)
    expect(rawget(_G, "MDTErrorFrame") and rawget(_G, "MDTErrorFrame"):IsVisible(), "the error button did not reopen the report")
    UI.Dialogs.CloseAll("api")
    for i = #errors, before + 1, -1 do table.remove(errors, i) end
  end)

  step("version check: the version text opens the changelog, a newer party version offers downloads, tabs switch", function()
    local clickArea = _G.MDTBottomLeftPanelClickArea
    click(clickArea)
    local dialog = openDialog("versionCheck")
    expect(math.abs(dialog:GetLeft() - main:GetLeft()) < 0.5 and math.abs(dialog:GetBottom() - main:GetBottom()) < 0.5,
      "the version check is not in the map's bottom-left corner")
    local text
    for _, child in ipairs(dialog.content.kitChildren) do
      local scroll = child.kitChildren and child.kitChildren[1]
      if scroll and scroll.kit.name == "Scroll" then text = scroll.content:Find("versionText") end
    end
    expect(dialog.content:Find("changelogTab").kitProps.selected and not dialog.content:Find("versionsTab").kitProps.selected, "the changelog tab is not selected")
    expect(MDT.changeLog[1] and text.kitProps.text:find("v"..MDT.changeLog[1].tag, 1, true), "the changelog text is missing")
    local downloads, report
    for _, child in ipairs(dialog.content.kitChildren) do
      if child.kit.name == "Row" and child:Find("reportVersions") then report = child end
      if child.kit.name == "Row" and #child.kitChildren == 2 and child.kitChildren[1].kit.name == "Row" then downloads = child end
    end
    expect(downloads and not downloads:IsShown() and not report:IsShown(), "downloads or the report button show while up to date")
    MDT:VersionCheck_OnCommReceived("V99.0.0", "PARTY", "Someone-Realm")
    W.pump(0.05)
    expect(downloads:IsShown(), "a newer party version did not offer the downloads")
    expect(main.bottomLeftPanelString:GetText():find(L["update available"], 1, true), "the version text does not say an update is available")
    snapshot("version check changelog", dialog)
    click(dialog.content:Find("versionsTab"))
    W.pump(0.05)
    expect(dialog.content:Find("versionsTab").kitProps.selected and report:IsShown() and not downloads:IsShown(), "the versions tab did not switch the controls")
    expect(text.kitProps.text:find(": v", 1, true), "the versions tab lists no versions")
    local sent = #W.chatMessages
    click(dialog.content:Find("reportVersions"))
    expect(#W.chatMessages > sent and W.chatMessages[sent + 1].message == "MDT Version Check:", "the report button sent nothing to party chat")
    snapshot("version check versions", dialog)
    click(clickArea)
    expect(UI.Dialogs.Get("versionCheck") == nil, "clicking the version text again did not close the dialog")
    click(clickArea)
    expect(openDialog("versionCheck").content:Find("versionsTab").kitProps.selected, "the dialog forgot the last tab")
    MDT:HideAllDialogs()
    expect(UI.Dialogs.Get("versionCheck") == nil, "HideAllDialogs left the version check open")
  end)

  step("dialogs: /mdt hardreset with the window closed asks on screen", function()
    MDT:HideInterface()
    MDT:HandleSlashCommand("hardreset")
    W.settle(asyncIdle, 30)
    local dialog = UI.Dialogs.Top()
    expect(dialog and dialog:IsVisible() and dialog:GetParent() == MDT.UI.Root, "the hard reset prompt is not visible without the window")
    click(dialog.content:Find("cancel"))
    expect(UI.Dialogs.Count() == 0, "cancel left the hard reset prompt open")
    _G.MythicDungeonToolsAPI:ShowInterface()
    W.settle(asyncIdle, 30)
    expect(main:IsVisible(), "main window did not come back")
  end)

  local function clickCatcher()
    for _, child in ipairs({ UIParent:GetChildren() }) do
      if child:GetObjectType() == "Button" and child:GetFrameStrata() == "FULLSCREEN_DIALOG" and child:GetFrameLevel() == 50 then return child end
    end
  end
  local function menuList(entry)
    for _, child in ipairs(entry.frame.content.kitChildren) do
      if child.kit.name == "List" then return child end
    end
  end
  local function menuDepth()
    local depth, top = 0, UI.Overlay.Top("menu")
    while top do
      depth = depth + 1
      if not top.submenu then break end
      UI.Overlay.Pop(top, "api")
      top = UI.Overlay.Top("menu")
    end
    return depth
  end

  step("kit menus: closing the main window closes its menu and the click catcher", function()
    W.settle(asyncIdle, 5)
    MDT:CreateContextMenu(main, { { text = "A", onSelect = function() end } })
    expect(UI.Menu.IsOpen(), "setup: the context menu did not open")
    MDT:HideInterface()
    expect(not UI.Menu.IsOpen() and not clickCatcher():IsShown(), "the menu or its click catcher outlived the window")
    _G.MythicDungeonToolsAPI:ShowInterface()
    W.settle(asyncIdle, 30)
    expect(main:IsVisible(), "main window did not come back")
  end)

  step("kit menus: one outside click closes a menu with its submenu, and a submenu opens once", function()
    W.settle(asyncIdle, 5)
    MDT:CreateContextMenu(main, {
      { kind = "submenu", text = "Marker", items = { { text = "One", onSelect = function() end } } },
      { text = "Other", onSelect = function() end },
    })
    local parent = UI.Overlay.Top("menu")
    W.userClick(menuList(parent):GetRow(1))
    W.userClick(menuList(parent):GetRow(1))
    expect(UI.Overlay.Top("menu").submenu and menuDepth() == 2, "re-activating the submenu item stacked a second submenu")
    W.userClick(menuList(parent):GetRow(1))
    W.userClick(clickCatcher())
    expect(not UI.Menu.IsOpen(), "the first outside click left the parent menu open")
  end)

  step("kit dropdown: typing in the search keeps the current choice checked", function()
    local items = {}
    for i = 1, 15 do items[i] = { kind = "choice", value = i, text = "Item "..i } end
    local host = UI.Stack(UI.Root, {})
    host:SetPoint("TOPLEFT")
    host:SetWidth(200)
    local dropdown = UI.Dropdown(host, { items = items, value = 3 })
    W.userClick(dropdown.kitButton)
    local menu = UI.Overlay.Top("menu")
    local search
    for _, child in ipairs(menu.frame.content.kitChildren) do
      if child.kit.name == "EditBox" then search = child end
    end
    expect(search, "setup: a 15-item dropdown has no search box")
    W.userType(search.kitEdit, "Item")
    local checked = 0
    menuList(menu):ForEachRow(function(row) if row.kitCheck:IsShown() then checked = checked + 1 end end)
    expect(checked == 1, checked.." rows are checked after typing")
    UI.Menu.Close()
    host:Release()
  end)

  step("kit slider: values snap to the step, not the client's float noise", function()
    local reported
    local slider = UI.Slider(UI.Root, { min = 0.5, max = 2, step = 0.1, value = 1, onChange = function(value) reported = value end })
    W.fireScript(slider.kitSlider, "OnValueChanged", 1.2000000476837, true)
    expect(reported == 1.2 and slider:GetValue() == 1.2, "the slider reported "..tostring(reported))
    slider:Release()
  end)

  step("dialogs: the large route warning cancels when the window closes over it", function()
    local realToString = MDT.TableToString
    MDT.TableToString = function() return string.rep("x", 4000) end
    local log = {}
    MDT:CheckPresetSize(function() log[#log + 1] = "share" end, function() log[#log + 1] = "cancel" end)
    openDialog("largePreset")
    MDT.TableToString = realToString
    MDT:HideInterface()
    expect(table.concat(log, ",") == "cancel", "closing the window over the warning reported "..table.concat(log, ","))
    _G.MythicDungeonToolsAPI:ShowInterface()
    W.settle(asyncIdle, 30)
  end)

  step("dialogs: a route dialog never acts on a route switched to while it was open", function()
    local dungeonIdx = db.currentDungeonIdx
    local start = db.currentPreset[dungeonIdx]
    local nameA, nameB = unusedPresetName("Switch A"), unusedPresetName("Switch B")
    MDT:CreateNewPreset(nameA)
    local aIdx = db.currentPreset[dungeonIdx]
    MDT:CreateNewPreset(nameB)
    local bIdx = db.currentPreset[dungeonIdx]
    W.settle(asyncIdle, 30)
    local function names()
      local found = {}
      for _, preset in ipairs(db.presets[dungeonIdx]) do found[preset.text] = true end
      return found
    end
    MDT:OpenDeletePresetDialog()
    local dialog = openDialog("deletePreset")
    MDT:SwitchToPreset(aIdx)
    click(dialog.content:Find("confirm"))
    expect(names()[nameA] and names()[nameB], "Delete removed a route other than the one it named")
    MDT:OpenClearPresetDialog()
    openDialog("clearPreset")
    MDT:SwitchToPreset(bIdx)
    W.settle(asyncIdle, 30)
    expect(UI.Dialogs.Get("clearPreset") == nil, "the reset dialog stayed open after its route was switched away")
    MDT:DeletePreset(bIdx)
    MDT:DeletePreset(aIdx)
    MDT:SwitchToPreset(start)
    W.settle(asyncIdle, 30)
  end)

  step("dialogs: opening a page or another dialog leaves the error report open", function()
    local errors = MDT:GetErrors()
    local before = #errors
    MDT:OnError("headless kept error", "headless stack line", "HeadlessTest")
    W.pump(0.6)
    openDialog("errors")
    local section = MDT:GetCurrentSection()
    MDT:SetCurrentSection("combatLogging")
    W.settle(asyncIdle, 5)
    MDT:HideAllDialogs()
    expect(UI.Dialogs.Get("errors"), "opening a page or HideAllDialogs closed the error report")
    UI.Dialogs.CloseAll("api")
    MDT:SetCurrentSection(section)
    W.settle(asyncIdle, 5)
    for i = #errors, before + 1, -1 do table.remove(errors, i) end
  end)
end
