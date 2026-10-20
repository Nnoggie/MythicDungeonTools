-- Harness steps that drive the UI kit through real frames: a throwaway gallery of every control and container,
-- then a virtualized list with selection, drag reorder and a context menu. Not shipped code.
return function(ctx)
  local W, MDT, step, expect, click, asyncIdle = ctx.W, ctx.MDT, ctx.step, ctx.expect, ctx.click, ctx.asyncIdle
  local UI = MDT.UI
  local page, log

  local function logged(name)
    return function(...) log[#log + 1] = name end
  end

  local function lastLog() return log[#log] end

  local function visibleChildren(container)
    local list = {}
    for _, child in ipairs(container.kitChildren) do
      if not child.kitProps.hidden then list[#list + 1] = child end
    end
    return list
  end

  step("kit gallery: build every control and container once", function()
    log = {}
    local root = CreateFrame("Frame", "MDTKitGallery", UIParent)
    root:SetSize(600, 900)
    root:SetPoint("TOP")
    page = UI.Stack(root, { gap = "md", padding = "md", background = "bg.panel", border = "border.normal" })
    page:SetPoint("TOPLEFT", root, "TOPLEFT", 0, 0)
    page:SetPoint("TOPRIGHT", root, "TOPRIGHT", 0, 0)
    page:Batch(function()
      UI.Heading(page, { text = "Gallery" })
      UI.Text(page, { text = "Body text that wraps across the full width of the stack, so its height comes from the string." })
      UI.Text(page, { id = "userText", text = "Маршрут 3", userText = true })
      UI.Text(page, { id = "hiddenText", text = "hidden", hidden = true })
      local buttons = UI.Row(page, { id = "buttons", gap = "sm", wrap = true })
      UI.Button(buttons, { id = "default", text = "Default", onClick = logged("click") })
      UI.Button(buttons, { text = "Primary", variant = "primary", tooltip = "Primary action" })
      UI.Button(buttons, { text = "Danger", variant = "danger" })
      UI.Button(buttons, { text = "Ghost", variant = "ghost", chevron = true })
      UI.Button(buttons, { id = "icon", variant = "icon", icon = 136235, tooltip = function() return "An icon" end })
      UI.Button(buttons, { id = "fullColorIcon", variant = "icon", icon = 136235, iconColor = false })
      UI.Button(buttons, { id = "disabled", text = "Disabled", disabled = true, onClick = logged("disabled-click") })
      UI.Checkbox(page, { id = "check", label = "Check me", value = false, onChange = function(v) log[#log + 1] = "check:"..tostring(v) end })
      UI.EditBox(page, { id = "edit", label = "Name", value = "Route", placeholder = "Type a name",
        onChange = function(text) log[#log + 1] = "change:"..text end,
        onCommit = function(text) log[#log + 1] = "commit:"..text end })
      UI.EditBox(page, { id = "multi", multiline = true, lines = 4, value = "line one\nline two" })
      UI.EditBox(page, { id = "readOnly", value = "https://example.invalid", readOnly = true, selectAllOnFocus = true,
        onCopy = logged("copy"), onFocusLost = logged("focusLost") })
      UI.Slider(page, { id = "slider", label = "Level", min = 2, max = 35, step = 1, value = 10,
        onChange = function(v) log[#log + 1] = "slide:"..v end, onCommit = function(v) log[#log + 1] = "slideCommit:"..v end })
      UI.Dropdown(page, { id = "dropdown", label = "Pick", value = "a",
        items = UI.MenuModel.FromList({ a = "Alpha", b = "Beta" }, { "a", "b" }),
        onChange = function(v) log[#log + 1] = "pick:"..tostring(v) end })
      UI.ColorSwatch(page, { id = "swatch", color = { 1, 0, 0, 1 }, hasAlpha = true, label = "Color",
        onChange = function(r, g, b, a) log[#log + 1] = ("color:%s,%s,%s,%s"):format(r, g, b, a) end })
      UI.Stepper(page, { id = "stepper", value = 10, min = 2, max = 35, format = function(v) return "+"..v end,
        onChange = function(v) log[#log + 1] = "step:"..v end, onCommit = function(v) log[#log + 1] = "stepCommit:"..v end,
        onPick = logged("pick") })
      UI.SegmentBar(page, { id = "forces", max = 100, marker = 100, text = "110/100", overflow = true,
        segments = { { value = 40, color = { 1, 0, 0 } }, { value = 70, color = { 0, 1, 0 } } } })
      local columns = UI.Columns(page, { id = "columns", weights = { 1, 2 } })
      UI.Text(columns[1], { text = "left column" })
      UI.Text(columns[2], { text = "right column" })
      UI.Tabs(page, { id = "tabs", onSelect = function(key) log[#log + 1] = "tab:"..key end, tabs = {
        { key = "a", text = "Tab A", build = function(content) UI.Text(content, { id = "tabA", text = "tab a" }) end },
        { key = "b", text = "Tab B", build = function(content) UI.Text(content, { id = "tabB", text = "tab b" }) end },
      } })
      local scroll = UI.Scroll(page, { id = "scroll", height = 80 })
      for i = 1, 20 do UI.Text(scroll.content, { text = "line "..i }) end
    end)
    expect(page:GetHeight() > 300, "gallery stack has no height: "..page:GetHeight())
    local children = visibleChildren(page)
    expect(#children == 16, "expected 16 visible children, got "..#children)
    for i = 1, #children - 1 do
      local above, below = children[i], children[i + 1]
      expect(above:GetBottom() and below:GetTop() and below:GetTop() <= above:GetBottom() + 0.01,
        ("child %d overlaps child %d"):format(i, i + 1))
      expect(above:GetHeight() > 0, ("child %d has no height"):format(i))
    end
    expect(not page:Find("hiddenText"):IsShown(), "hidden child is shown")
    expect(page:Find("default"):GetWidth() > 0 and page:Find("default"):GetWidth() < 120, "button natural width is off")
    expect(page:Find("icon"):GetWidth() == page:Find("icon"):GetHeight(), "icon button is not square")
    local tinted = { page:Find("icon").kitIcon:GetVertexColor() }
    local untinted = { page:Find("fullColorIcon").kitIcon:GetVertexColor() }
    expect(table.concat(tinted, ",") == table.concat({ UI.Theme.Resolve("text.normal") }, ","), "icon is not tinted with the skin text color")
    expect(table.concat(untinted, ",") == "1,1,1,1", "iconColor = false still tints the icon: "..table.concat(untinted, ","))
    local columns = page:Find("columns")
    expect(math.abs(columns[1]:GetWidth() * 2 - columns[2]:GetWidth()) <= 3, "columns are not weighted 1:2")
    expect(page:Find("tabA"), "first tab did not build its content")
    expect(lastLog() == "tab:a", "tabs did not report the initial selection")
    local userText = page:Find("userText")
    expect(userText.kitLabel:GetFontObject() == UI.Fonts.fallbacks.plain.body.russian, "Cyrillic user text did not pick the russian fallback font")
    ctx.render("kit gallery", root)
  end)

  step("kit gallery: controls report user input through their callbacks", function()
    log = {}
    click(page:Find("default"))
    expect(lastLog() == "click", "button click did not fire onClick")
    click(page:Find("disabled"))
    expect(lastLog() == "click", "disabled button fired onClick")

    local check = page:Find("check")
    click(check)
    expect(check:GetValue() == true and lastLog() == "check:true", "checkbox did not toggle on")
    check:SetValue(false)
    expect(check:GetValue() == false and lastLog() == "check:true", "SetValue fired onChange")

    local edit = page:Find("edit")
    edit:Focus()
    edit.kitEdit:Insert("!")
    expect(edit:GetValue() == "Route!" and lastLog() == "change:Route!", "typing did not reach onChange")
    W.fireScript(edit.kitEdit, "OnEnterPressed")
    expect(lastLog() == "commit:Route!", "Enter did not commit")
    expect(not edit.kitEdit:HasFocus(), "Enter kept focus")
    edit:SetValue("Reset")
    expect(edit:GetValue() == "Reset" and lastLog() == "commit:Route!", "SetValue fired a callback")

    local readOnly = page:Find("readOnly")
    readOnly:Focus()
    readOnly.kitEdit:Insert("zzz")
    expect(readOnly:GetValue() == "https://example.invalid", "read-only box accepted input")
    W.modifiers = { ctrl = true }
    W.fireScript(readOnly.kitEdit, "OnKeyUp", "C")
    W.modifiers = nil
    expect(lastLog() == "copy", "Ctrl+C did not fire onCopy")
    readOnly:ClearFocus()
    expect(lastLog() == "focusLost", "blur did not fire onFocusLost")

    local slider = page:Find("slider")
    slider.kitSlider:SetValue(20, true)
    expect(slider:GetValue() == 20 and lastLog() == "slide:20", "slider drag did not fire onChange")
    W.fireScript(slider.kitSlider, "OnMouseUp", "LeftButton")
    expect(lastLog() == "slideCommit:20", "slider mouse up did not commit")
    slider:SetValue(99)
    expect(slider:GetValue() == 35 and lastLog() == "slideCommit:20", "slider SetValue did not clamp silently")

    local dropdown = page:Find("dropdown")
    expect(dropdown.kitButton:GetText() == "Alpha", "dropdown shows "..tostring(dropdown.kitButton:GetText()))
    dropdown:SetValue("b")
    expect(dropdown.kitButton:GetText() == "Beta" and dropdown:GetValue() == "b", "dropdown SetValue did not relabel")

    local swatch = page:Find("swatch")
    click(swatch)
    expect(ColorPickerFrame:IsShown(), "swatch did not open the color picker")
    ColorPickerFrame.info.swatchFunc()
    expect(lastLog() == "color:1,1,1,1", "picker swatchFunc did not reach onChange: "..tostring(lastLog()))
    ColorPickerFrame.info.cancelFunc()
    expect(lastLog() == "color:1,0,0,1", "picker cancel did not restore the color")
    ColorPickerFrame:Hide()

    local stepper = page:Find("stepper")
    click(stepper.kitUp)
    click(stepper.kitUp)
    expect(stepper:GetValue() == 12 and lastLog() == "step:12", "stepper arrows did not step")
    local commits = 0
    for _, entry in ipairs(log) do if entry:find("^stepCommit") then commits = commits + 1 end end
    expect(commits == 0, "stepper committed before the burst ended")
    W.settle(asyncIdle, 5)
    commits = 0
    for _, entry in ipairs(log) do if entry:find("^stepCommit") then commits = commits + 1 end end
    expect(commits == 1 and lastLog() == "stepCommit:12", "stepper burst did not commit exactly once")
    W.fireScript(stepper, "OnMouseWheel", -1)
    expect(stepper:GetValue() == 11, "stepper wheel did not step down")
    click(stepper.kitValue)
    expect(lastLog() == "pick", "stepper value click did not fire onPick")
    stepper:SetValue(35)
    expect(stepper.kitUp:IsDisabled() and not stepper.kitDown:IsDisabled(), "stepper arrows ignore the bounds")

    local tabs = page:Find("tabs")
    click(tabs.kitTabButtons[2])
    expect(lastLog() == "tab:b" and page:Find("tabB") and not page:Find("tabA"), "tab switch did not rebuild content")

    local scroll = page:Find("scroll")
    expect(scroll.content:GetHeight() > 200, "scroll content did not grow with its children")
    scroll:SetOffset(100)
    expect(scroll:GetOffset() == 100, "scroll offset is "..scroll:GetOffset())
    scroll:SetOffset(10000)
    expect(scroll:GetOffset() == scroll.content:GetHeight() - scroll.kitViewport:GetHeight(), "scroll offset is not clamped")
    W.fireScript(scroll.kitViewport, "OnMouseWheel", 1)
    expect(scroll:GetOffset() < scroll.content:GetHeight() - scroll.kitViewport:GetHeight(), "wheel did not scroll up")

    local forces = page:Find("forces")
    expect(forces.kitSegmentPool:GetNumActive() == 2, "segment bar did not draw two segments")
    forces:SetSegments({ { value = 10, color = { 0, 0, 1 } } }, 100)
    expect(forces.kitSegmentPool:GetNumActive() == 1, "SetSegments did not reuse the pool")

    local hidden = page:Find("hiddenText")
    local heightBefore = page:GetHeight()
    hidden:SetHidden(false)
    UI.Layout.FlushAll()
    expect(hidden:IsShown() and page:GetHeight() > heightBefore, "unhiding did not take layout space")
  end)

  step("kit lifecycle: unknown keys error, bad handlers are contained, release is deferred and pooled", function()
    local ok, err = pcall(UI.Button, page, { bogus = true })
    expect(not ok and tostring(err):find("unknown spec key 'bogus'", 1, true), "unknown spec key was accepted: "..tostring(err))

    local caught = 0
    local previous = geterrorhandler()
    seterrorhandler(function() caught = caught + 1 end)
    local bad = UI.Button(page, { text = "Bad", onClick = function() error("handler boom") end })
    UI.Layout.FlushAll()
    click(bad)
    seterrorhandler(previous)
    expect(caught == 1, "bad handler was not routed to the error handler")
    expect(bad:IsShown(), "a bad handler left the button hidden")

    local selfReleasing = UI.Button(page, { text = "Bye", onClick = function(button)
      button:Release()
      expect(button:IsShown(), "release ran inside its own callback")
    end })
    UI.Layout.FlushAll()
    click(selfReleasing)
    expect(not selfReleasing:IsShown() and selfReleasing:GetParent() == UI.Holder, "deferred release did not run after the callback")
    expect(selfReleasing.kitProps.onClick == nil and selfReleasing.kitProps.text == "", "release did not reset props")
    selfReleasing:Release()

    local reused = UI.Button(page, { id = "reused", text = "Again" })
    expect(reused == selfReleasing, "pool did not hand back the released frame")
    expect(reused:GetParent() == page and page:Find("reused") == reused, "reacquired button is not adopted")
    reused:Release()
    expect(page:Find("reused") == nil, "released child is still findable")
    bad:Release()
  end)

  step("kit lifecycle: SetDisabled at runtime makes every control inert, and SetDisabled(false) revives it", function()
    log = {}
    local box = UI.Stack(page, { id = "disabledBox" })
    local button = UI.Button(box, { text = "Go", onClick = logged("button") })
    local check = UI.Checkbox(box, { label = "Check", onChange = logged("check") })
    local edit = UI.EditBox(box, { value = "v", onChange = logged("edit") })
    local slider = UI.Slider(box, { min = 0, max = 10, step = 1, value = 2, onChange = logged("slider") })
    local dropdown = UI.Dropdown(box, { items = UI.MenuModel.FromList({ a = "Alpha" }, { "a" }), onChange = logged("dropdown") })
    local swatch = UI.ColorSwatch(box, { color = { 1, 0, 0, 1 }, onChange = logged("swatch") })
    local stepper = UI.Stepper(box, { value = 5, min = 0, max = 10, onChange = logged("stepper") })
    local controls = { button, check, edit, slider, dropdown, swatch, stepper }
    UI.Layout.FlushAll()

    local function drive()
      click(button)
      click(check)
      W.userClick(edit.kitEdit)
      W.userType(edit.kitEdit, "x")
      edit:ClearFocus()
      W.userDrag(slider.kitSlider, 7)
      click(dropdown.kitButton)
      local menuOpened = UI.Overlay.Top("menu") ~= nil
      UI.Menu.Close()
      click(swatch)
      local pickerOpened = ColorPickerFrame:IsShown()
      ColorPickerFrame:Hide()
      click(stepper.kitUp)
      return menuOpened, pickerOpened
    end

    edit:Focus()
    for _, control in ipairs(controls) do control:SetDisabled(true) end
    expect(not edit.kitEdit:HasFocus(), "disabling a focused edit box kept its focus")
    for _, control in ipairs(controls) do expect(control:IsDisabled(), control.kit.name.." does not report disabled") end
    local menuOpened, pickerOpened = drive()
    expect(#log == 0, "a disabled control reported input: "..table.concat(log, ","))
    expect(not menuOpened, "a disabled dropdown opened its menu")
    expect(not pickerOpened, "a disabled color swatch opened the picker")
    expect(edit:GetValue() == "v", "a disabled edit box took typing")
    expect(stepper.kitUp:IsDisabled() and stepper.kitDown:IsDisabled(), "a disabled stepper left its arrows live")
    expect(swatch.kitSwatch:GetAlpha() < 1, "a disabled color swatch is not dimmed")

    for _, control in ipairs(controls) do control:SetDisabled(false) end
    menuOpened, pickerOpened = drive()
    expect(table.concat(log, ",") == "button,check,edit,slider,stepper", "re-enabled controls reported "..table.concat(log, ","))
    expect(menuOpened and pickerOpened, "re-enabled dropdown or swatch did not open")
    expect(swatch.kitSwatch:GetAlpha() == 1, "a re-enabled color swatch is still dimmed")
    box:Release()
    UI.Layout.FlushAll()
    W.settle(asyncIdle, 5)
  end)

  step("kit edit box: Escape reverts without committing; commits name their source; a Prompt confirms only on Enter or its button", function()
    log = {}
    local edit = UI.EditBox(page, { value = "Route",
      onChange = function(text) log[#log + 1] = "change:"..text end,
      onCommit = function(text, _, source) log[#log + 1] = "commit:"..text..":"..tostring(source) end,
      onEscape = logged("escape") })
    UI.Layout.FlushAll()
    W.userClick(edit.kitEdit)
    W.userType(edit.kitEdit, "!")
    W.fireScript(edit.kitEdit, "OnEscapePressed")
    expect(edit:GetValue() == "Route" and not edit.kitEdit:HasFocus(), "Escape did not restore the committed text and drop focus")
    expect(table.concat(log, ",") == "change:Route!,change:Route,escape", "Escape reported "..table.concat(log, ","))
    log = {}
    W.userClick(edit.kitEdit)
    W.userType(edit.kitEdit, "1")
    W.fireScript(edit.kitEdit, "OnEnterPressed")
    W.userClick(edit.kitEdit)
    W.userType(edit.kitEdit, "2")
    edit:ClearFocus()
    W.userClick(edit.kitEdit)
    W.fireScript(edit.kitEdit, "OnEnterPressed")
    W.userClick(edit.kitEdit)
    edit:ClearFocus()
    expect(table.concat(log, ",") == "change:Route1,commit:Route1:enter,change:Route12,commit:Route12:blur,commit:Route12:enter",
      "commits reported "..table.concat(log, ","))
    edit:Release()

    log = {}
    local function promptEdit(prompt)
      for _, child in ipairs(prompt.content.kitChildren) do
        if child.kit.name == "EditBox" then return child end
      end
    end
    local function openPrompt()
      return UI.Dialogs.Prompt({ title = "Rename", value = "Old",
        confirm = { text = "Ok", onClick = function(text) log[#log + 1] = "confirm:"..text end },
        cancel = { onClick = logged("cancel") } })
    end
    local depth = UI.Escape.Depth()
    local prompt = openPrompt()
    W.userType(promptEdit(prompt).kitEdit, "X")
    W.fireScript(promptEdit(prompt).kitEdit, "OnEscapePressed")
    expect(prompt.kitReleased and table.concat(log, ",") == "cancel", "Escape in a prompt reported "..table.concat(log, ","))
    expect(UI.Escape.Depth() == depth, "Escape in a prompt left its Escape entry")

    log = {}
    prompt = openPrompt()
    W.fireScript(promptEdit(prompt).kitEdit, "OnEnterPressed")
    expect(prompt.kitReleased and table.concat(log, ",") == "confirm:Old", "Enter on an unchanged prompt reported "..table.concat(log, ","))

    log = {}
    prompt = openPrompt()
    local promptBox = promptEdit(prompt)
    W.userType(promptBox.kitEdit, "Y")
    promptBox:ClearFocus()
    expect(not prompt.kitReleased and #log == 0, "losing focus confirmed the prompt: "..table.concat(log, ","))
    local confirmButton
    for _, child in ipairs(prompt.content.kitChildren) do
      if child.kit.name == "Row" then confirmButton = child.kitChildren[1] end
    end
    click(confirmButton)
    expect(prompt.kitReleased and table.concat(log, ",") == "confirm:OldY", "the confirm button reported "..table.concat(log, ","))
    W.settle(asyncIdle, 5)
  end)

  step("kit menus: Escape in a dropdown's search box closes the menu", function()
    local list = {}
    local order = {}
    for i = 1, 13 do
      list["k"..i] = "Choice "..i
      order[i] = "k"..i
    end
    local dropdown = UI.Dropdown(page, { items = UI.MenuModel.FromList(list, order), value = "k1" })
    UI.Layout.FlushAll()
    local depth = UI.Escape.Depth()
    click(dropdown.kitButton)
    local menu = UI.Overlay.Top("menu")
    local search
    for _, child in ipairs(menu.frame.content.kitChildren) do
      if child.kit.name == "EditBox" then search = child end
    end
    expect(search and search.kitEdit:HasFocus(), "a long dropdown did not focus its search box")
    W.userType(search.kitEdit, "1")
    W.fireScript(search.kitEdit, "OnEscapePressed")
    expect(UI.Overlay.Top("menu") == nil and not menu.frame:IsShown(), "Escape in the search box left the menu open")
    expect(UI.Escape.Depth() == depth and dropdown:GetValue() == "k1", "Escape in the search box changed the stack or the value")
    dropdown:Release()
    W.settle(asyncIdle, 5)
  end)

  step("kit lifecycle: a control released mid-hover comes back from the pool unhovered, and release fires no spurious OnShow", function()
    local function paint(button)
      local color = W.state[button.kitBackground].color
      return color and table.concat(color, ",") or "none"
    end
    local hovered = UI.Button(page, { text = "Hover" })
    UI.Layout.FlushAll()
    W.fireScript(hovered, "OnEnter")
    W.fireScript(hovered, "OnMouseDown", "LeftButton")
    hovered:Release()
    local reused = UI.Button(page, { text = "Fresh" })
    local fresh = UI.Button(page, { text = "Fresh" })
    UI.Layout.FlushAll()
    expect(reused == hovered and fresh ~= hovered, "setup: the pool did not hand back the hovered button first")
    expect(paint(reused) == paint(fresh), ("reused button paints %s, a fresh one %s"):format(paint(reused), paint(fresh)))

    local shows, hides = 0, 0
    local hidden = UI.Button(page, { text = "Hidden", hidden = true })
    hidden:HookScript("OnShow", function() shows = shows + 1 end)
    hidden:HookScript("OnHide", function() hides = hides + 1 end)
    hidden:Release()
    expect(shows == 0 and hides == 0, ("releasing a hidden control fired %d OnShow and %d OnHide"):format(shows, hides))
    reused:Release()
    fresh:Release()
    UI.Layout.FlushAll()
  end)

  step("kit lifecycle: a control whose label grows measures the whole new label, not its old clipped width", function()
    local long = "A much longer label than the last one"
    local short = {}
    for _, class in ipairs({ { "Button", "SetText" }, { "Checkbox", "SetLabel" }, { "ColorSwatch", "SetLabel" } }) do
      local name, setter = class[1], class[2]
      local row = UI.Row(page, {})
      local control = UI[name](row, { [setter == "SetText" and "text" or "label"] = "Hi" })
      UI.Layout.FlushAll()
      control[setter](control, long)
      UI.Layout.FlushAll()
      local needed = control.kitLabel:GetUnboundedStringWidth()
      local room = control:GetRight() - control.kitLabel:GetLeft()
      if room < needed then short[#short + 1] = ("%s label has %d of the %d it needs"):format(name, room, needed) end
      row:Release()
    end
    UI.Layout.FlushAll()
    expect(#short == 0, table.concat(short, "; "))
  end)

  step("kit layout: wrapped text in a row takes its text's width, not the whole row", function()
    local row = UI.Row(page, { gap = "sm" })
    local text = UI.Text(row, { text = "Short" })
    local button = UI.Button(row, { text = "After" })
    UI.Layout.FlushAll()
    local needed = text.kitLabel:GetUnboundedStringWidth()
    expect(text:GetWidth() >= needed and text:GetWidth() <= needed + 1,
      ("short text in a row is %d wide for %d of text"):format(text:GetWidth(), needed))
    expect(button:GetRight() <= row:GetRight(), "the button after the text was pushed out of the row")
    local long = UI.Text(row, { text = string.rep("long words wrap ", 40) })
    UI.Layout.FlushAll()
    expect(long:GetWidth() <= row:GetWidth(), "long wrapped text grew past the row")
    row:Release()
    UI.Layout.FlushAll()
  end)

  step("kit lifecycle: a released color swatch closes its picker and ignores the picker's late callbacks", function()
    log = {}
    local first = UI.ColorSwatch(page, { color = { 1, 0, 0, 1 }, onChange = logged("first") })
    UI.Layout.FlushAll()
    click(first)
    local stale = ColorPickerFrame.info
    first:Release()
    expect(not ColorPickerFrame:IsShown(), "releasing the swatch left its color picker open")
    local second = UI.ColorSwatch(page, { color = { 0, 0, 1, 1 }, onChange = logged("second") })
    expect(second == first, "setup: the pool did not hand back the released swatch")
    stale.swatchFunc()
    stale.cancelFunc()
    expect(#log == 0, "a stale picker callback reached a control: "..table.concat(log, ","))
    local r, g, b = unpack(second:GetColor())
    expect(r == 0 and g == 0 and b == 1, "a stale picker callback recolored the reused swatch")

    click(second)
    local other = UI.ColorSwatch(page, { color = { 0, 1, 0, 1 }, onChange = logged("other") })
    UI.Layout.FlushAll()
    click(other)
    second:Release()
    expect(ColorPickerFrame:IsShown(), "releasing a swatch closed a picker another swatch owns")
    ColorPickerFrame.info.swatchFunc()
    expect(table.concat(log, ",") == "other", "the picker's owner did not get its callback: "..table.concat(log, ","))
    ColorPickerFrame:Hide()
    other:Release()
    UI.Layout.FlushAll()
  end)

  step("kit dialogs: opening a dialog closes open popovers and menus so nothing covers it", function()
    log = {}
    local depth = UI.Escape.Depth()
    local pop = UI.Popover({ anchor = page:Find("default"), onClose = function(reason) log[#log + 1] = "pop:"..reason end,
      build = function(content) UI.Text(content, { text = "popover" }) end })
    UI.Menu.Open({ anchor = page:Find("default"), items = { { text = "One" } }, onClose = function(reason) log[#log + 1] = "menu:"..reason end })
    local dialog = UI.Dialogs.Confirm({ title = "Over", text = "On top", confirm = { text = "Ok", onClick = function() end } })
    expect(not pop:IsShown() and UI.Overlay.Top("popover") == nil and UI.Overlay.Top("menu") == nil, "a popover or menu stayed open over the dialog")
    expect(table.concat(log, ",") == "menu:replaced,pop:replaced", "dismissals reported "..table.concat(log, ","))
    local covered = false
    for _, object in ipairs(W.objects) do
      local state = W.state[object]
      if state.isFrame and state.class.name == "Button" and state.parent == UIParent and W.isVisible(object) and object:GetWidth() == UIParent:GetWidth() then covered = true end
    end
    expect(not covered, "the click catcher still covers the dialog")
    expect(UI.Escape.Depth() == depth + 1, "the Escape stack holds more than the dialog")
    dialog:Close("api")
  end)

  step("kit layout: Batch returns with a 5-deep nested tree fully measured", function()
    local root = UI.Stack(page, {})
    UI.Layout.FlushAll()
    local leaf
    root:Batch(function()
      local parent = root
      for _ = 1, 5 do parent = UI.Stack(parent, { padding = "sm" }) end
      leaf = UI.Text(parent, { text = "deep" })
    end)
    local afterBatch = root:GetHeight()
    expect(not UI.Layout.IsDirty(), "Batch returned with containers still dirty")
    UI.Layout.FlushAll()
    expect(afterBatch == root:GetHeight() and afterBatch >= leaf:GetHeight() + 5 * 2 * UI.Theme.Space("sm"),
      ("root was %d tall after Batch and %d once settled"):format(afterBatch, root:GetHeight()))

    local errors = {}
    local previous = geterrorhandler()
    seterrorhandler(function(message) errors[#errors + 1] = tostring(message) end)
    local loop = UI.Stack(page, {})
    local settles = loop.kitLayout
    loop.kitLayout = function(self) UI.Layout.Invalidate(self) end
    UI.Layout.FlushAll()
    seterrorhandler(previous)
    expect(#errors == 1 and errors[1]:find("did not settle", 1, true), "a layout that never settles was not reported: "..table.concat(errors, "; "))
    loop.kitLayout = settles
    loop:Release()
    root:Release()
    UI.Layout.FlushAll()
  end)

  step("kit menus: a submenu hover timer from a closed menu does not fire into the next menu", function()
    local function menuList(entry)
      for _, child in ipairs(entry.frame.content.kitChildren) do
        if child.kit.name == "List" then return child end
      end
    end
    local function subTexts()
      local texts = {}
      local top = UI.Overlay.Top("menu")
      while top and top.submenu do
        local list = menuList(top)
        list:ForEachRow(function(row) texts[#texts + 1] = row.kitLabel:GetText() end)
        UI.Overlay.Pop(top, "api")
        top = UI.Overlay.Top("menu")
      end
      return table.concat(texts, ",")
    end
    local anchor = page:Find("default")
    UI.Menu.Open({ anchor = anchor, items = { { kind = "submenu", text = "Old", items = { { text = "Stale" } } } } })
    local first = UI.Overlay.Top("menu").frame
    W.fireScript(menuList(UI.Overlay.Top("menu")):GetRow(1), "OnEnter")
    UI.Menu.Close()
    UI.Menu.Open({ anchor = anchor, items = { { kind = "submenu", text = "New", items = { { text = "Fresh" } } } } })
    expect(UI.Overlay.Top("menu").frame == first, "setup: the second menu did not reuse the first popover")
    W.fireScript(menuList(UI.Overlay.Top("menu")):GetRow(1), "OnEnter")
    W.pump(UI.Theme.data.motion.submenuDelay + 0.05)
    local opened = subTexts()
    expect(opened == "Fresh", "submenus opened after the hover delay: "..opened)
    UI.Menu.Close()
    W.settle(asyncIdle, 5)
  end)

  step("kit segment bar: SetSegments and SetMax repaint the over-max tint", function()
    local function tint(bar) return table.concat({ bar.kitText:GetTextColor() }, ",") end
    local function bar(segments, max) return UI.SegmentBar(page, { max = max, text = "x", overflow = true, segments = segments }) end
    local over, under, full = { { value = 110, color = "ok" } }, { { value = 50, color = "ok" } }, { { value = 100, color = "ok" } }
    local updated, freshUnder, freshOver, freshFull = bar(over, 100), bar(under, 100), bar(over, 100), bar(full, 100)
    local wrong = {}
    expect(tint(freshUnder) ~= tint(freshOver) and tint(freshFull) ~= tint(freshUnder), "setup: the three states share one tint")
    updated:SetSegments(under, 100)
    if tint(updated) ~= tint(freshUnder) then wrong[#wrong + 1] = "SetSegments to under max kept "..tint(updated) end
    updated:SetSegments(full)
    if tint(updated) ~= tint(freshFull) then wrong[#wrong + 1] = "SetSegments to exactly max kept "..tint(updated) end
    updated:SetMax(200)
    if tint(updated) ~= tint(freshUnder) then wrong[#wrong + 1] = "SetMax above the total kept "..tint(updated) end
    expect(#wrong == 0, table.concat(wrong, "; "))
    for _, control in ipairs({ updated, freshUnder, freshOver, freshFull }) do control:Release() end
    UI.Layout.FlushAll()
  end)

  step("kit fonts: a font family that comes back without its font falls back to a plain font", function()
    local Fonts = UI.Fonts
    local objects, fallbacks = {}, {}
    for variant, byRole in pairs(Fonts.objects) do
      objects[variant] = {}
      for role, font in pairs(byRole) do objects[variant][role] = font end
    end
    for variant, byRole in pairs(Fonts.fallbacks) do
      fallbacks[variant] = {}
      for role, byAlphabet in pairs(byRole) do fallbacks[variant][role] = byAlphabet end
    end
    local realFamily = CreateFontFamily
    CreateFontFamily = function(name) return CreateFont(name) end
    local ok, err = pcall(Fonts.Setup)
    CreateFontFamily = realFamily
    local file = Fonts.Get("body"):GetFont()
    local _, _, outlineFlags = Fonts.Get("body", true):GetFont()
    for variant, byRole in pairs(objects) do
      for role, font in pairs(byRole) do
        Fonts.objects[variant][role] = font
        _G[W.state[font].name] = font
      end
    end
    for variant, byRole in pairs(fallbacks) do
      for role, byAlphabet in pairs(byRole) do
        Fonts.fallbacks[variant][role] = byAlphabet
        for _, font in pairs(byAlphabet) do _G[W.state[font].name] = font end
      end
    end
    expect(ok, "Fonts.Setup raised: "..tostring(err))
    expect(file == Fonts.files.roman, "a silently empty font family left the body font at "..tostring(file))
    expect(outlineFlags == "OUTLINE", "the outlined body font has flags "..tostring(outlineFlags))
  end)

  step("kit dialogs: stack, keyed replacement, every dismissal runs cancel once, Escape pops the top dialog first", function()
    log = {}
    local Dialogs = UI.Dialogs
    expect(UI.Escape.Depth() == 1, "main window is not the only Escape entry: "..UI.Escape.Depth())
    local first = Dialogs.Confirm({ key = "first", title = "First", text = "Delete it?",
      confirm = { text = "Delete", variant = "danger", onClick = logged("confirm1") },
      cancel = { onClick = logged("cancel1") } })
    expect(first:IsVisible() and first:GetHeight() > 60, "confirm dialog is not visible with content")
    expect(Dialogs.Top() == first and Dialogs.Count() == 1, "dialog stack is wrong")
    local second = Dialogs.Prompt({ key = "second", title = "Second", label = "Name", value = "x",
      validate = function(text) if text == "" then return false, "Empty" end return true end,
      checkbox = { text = "Mine", value = true },
      confirm = { text = "Rename", onClick = function(text, checked) log[#log + 1] = "rename:"..text..":"..tostring(checked) end },
      cancel = { onClick = logged("cancel2") } })
    expect(Dialogs.Count() == 2 and second:GetFrameLevel() > first:GetFrameLevel(), "second dialog is not above the first")
    expect(UI.Escape.Depth() == 3, "dialogs did not push Escape entries")

    expect(CloseSpecialWindows(), "Escape found no special window")
    expect(not second:IsShown() and lastLog() == "cancel2", "Escape did not close the top dialog with cancel")
    expect(first:IsShown() and MDT.main_frame:IsShown(), "Escape closed more than the top dialog")
    W.settle(asyncIdle, 5)

    local replaced = Dialogs.Confirm({ key = "first", title = "First again", text = "Again?",
      confirm = { text = "Yes", onClick = logged("confirm1b") }, cancel = { onClick = logged("cancel1b") } })
    expect(lastLog() == "cancel1", "keyed re-open did not run the old dialog's cancel")
    expect(Dialogs.Count() == 1 and Dialogs.Get("first") == replaced, "keyed dialog is not the replacement")
    click(replaced.closeButton)
    expect(lastLog() == "cancel1b" and Dialogs.Count() == 0, "X did not close with cancel")
    expect(UI.Escape.Depth() == 1, "Escape stack kept a closed dialog")

    local prompt = Dialogs.Prompt({ title = "Prompt", value = "",
      validate = function(text) if text == "" then return false, "Empty" end return true end,
      confirm = { text = "Ok", onClick = function(text) log[#log + 1] = "prompt:"..text end },
      cancel = { onClick = logged("promptCancel") } })
    local edit, confirmButton
    for _, child in ipairs(prompt.content.kitChildren) do
      if child.kit.name == "EditBox" then edit = child end
      if child.kit.name == "Row" then confirmButton = child.kitChildren[1] end
    end
    expect(edit and edit.kitEdit:HasFocus(), "prompt did not focus its edit box")
    expect(confirmButton:IsDisabled(), "empty prompt enabled confirm")
    click(confirmButton)
    expect(prompt:IsShown(), "disabled confirm closed the prompt")
    edit.kitEdit:Insert("Route")
    expect(not confirmButton:IsDisabled(), "valid text kept confirm disabled")
    W.fireScript(edit.kitEdit, "OnEnterPressed")
    expect(lastLog() == "prompt:Route" and not prompt:IsShown(), "Enter did not confirm the prompt")

    local counted = 0
    Dialogs.Confirm({ title = "Count", text = "once", confirm = { text = "Ok", onClick = function() end },
      cancel = { onClick = function() counted = counted + 1 end } })
    Dialogs.Open({ title = "Plain", build = function(content) UI.Text(content, { text = "plain" }) end })
    Dialogs.CloseAll("api")
    expect(counted == 1 and Dialogs.Count() == 0, "CloseAll did not run cancel exactly once per dialog")
    expect(UI.Escape.Depth() == 1 and MDT.main_frame:IsShown(), "CloseAll disturbed the main window entry")

    local pop = UI.Popover({ anchor = page:Find("default"), width = 120, onClose = function(reason) log[#log + 1] = "pop:"..reason end,
      build = function(content) UI.Text(content, { text = "popover" }) end })
    expect(pop:IsVisible() and pop:GetHeight() > 0, "popover did not open")
    expect(pop:GetTop() <= page:Find("default"):GetBottom() + 0.01, "popover is not below its anchor")
    expect(CloseSpecialWindows(), "Escape found nothing with a popover open")
    expect(lastLog() == "pop:escape" and not pop:IsShown(), "Escape did not close the popover")
    W.settle(asyncIdle, 5)
    local again = UI.Popover({ anchor = page:Find("default"), build = function(content) UI.Text(content, { text = "again" }) end,
      onClose = function(reason) log[#log + 1] = "pop:"..reason end })
    expect(again:IsVisible(), "second popover did not open")
    local catcher
    for _, object in ipairs(W.objects) do
      local state = W.state[object]
      if state.isFrame and state.class.name == "Button" and state.parent == UIParent and W.isVisible(object) and object:GetWidth() == UIParent:GetWidth() then catcher = object end
    end
    expect(catcher, "no full-screen click catcher is shown behind the popover")
    click(catcher)
    expect(lastLog() == "pop:outside" and not again:IsShown(), "click outside did not close the popover")
    expect(not catcher:IsShown(), "click catcher stayed up with nothing open")
  end)

  step("kit dialogs: a reused dialog parented to UIParent draws above the main window", function()
    local rank = { BACKGROUND = 1, LOW = 2, MEDIUM = 3, HIGH = 4, DIALOG = 5, FULLSCREEN = 6, FULLSCREEN_DIALOG = 7, TOOLTIP = 8 }
    UI.Dialogs.Open({ title = "First life", build = function(content) UI.Text(content, { text = "first" }) end }):Close("api")
    local dialog = UI.Dialogs.Open({ title = "Second life", parent = UIParent, build = function(content) UI.Text(content, { text = "second" }) end })
    expect(MDT.main_frame:IsShown() and dialog:GetParent() == UIParent, "setup: main window hidden or dialog not on UIParent")
    expect(rank[dialog:GetFrameStrata()] > rank[MDT.main_frame:GetFrameStrata()],
      ("reused dialog strata %s is not above the main window's %s"):format(dialog:GetFrameStrata(), MDT.main_frame:GetFrameStrata()))
    expect(dialog.content:GetFrameStrata() == dialog:GetFrameStrata(), "dialog content did not follow the dialog's strata")
    dialog:Close("api")
  end)

  step("kit dialogs: the title bar drags a dialog unless it is pinned", function()
    local movable = UI.Dialogs.Open({ title = "Movable" })
    W.fireScript(movable.kitTitleBar, "OnDragStart")
    expect(W.state[movable].moving, "dragging the title bar did not move the dialog")
    W.fireScript(movable.kitTitleBar, "OnDragStop")
    movable:Close("api")
    local pinned = UI.Dialogs.Open({ title = "Pinned", pinned = true })
    W.fireScript(pinned.kitTitleBar, "OnDragStart")
    expect(not W.state[pinned].moving, "a pinned dialog moved")
    pinned:Close("api")
    local reused = UI.Dialogs.Open({ title = "Reused" })
    expect(reused == pinned, "setup: the pooled dialog frame was not reused")
    W.fireScript(reused.kitTitleBar, "OnDragStart")
    expect(W.state[reused].moving, "a reused dialog stayed pinned from its last life")
    W.fireScript(reused.kitTitleBar, "OnDragStop")
    reused:Close("api")
  end)

  step("kit dialogs: a dialog closed because its parent hid reports 'hidden' and skips cancel", function()
    log = {}
    local dialog = UI.Dialogs.Confirm({ title = "Parent", text = "Parent hides",
      confirm = { text = "Ok", onClick = logged("hiddenConfirm") }, cancel = { onClick = logged("hiddenCancel") },
      onClose = function(_, reason) log[#log + 1] = "close:"..reason end })
    expect(dialog:GetParent() == MDT.main_frame, "setup: dialog is not on the main window")
    MDT:HideInterface()
    expect(dialog.kitReleased and lastLog() == "close:hidden", "parent hide did not close the dialog with 'hidden': "..tostring(lastLog()))
    for _, entry in ipairs(log) do expect(entry ~= "hiddenCancel", "parent hide ran the dialog's cancel") end
    MDT.main_frame:Show()
  end)

  local list, order, selection
  local function buildItems()
    local items = {}
    for i, key in ipairs(order) do items[i] = { kind = "row", key = key, sig = "r"..key, text = "Item "..key } end
    return items
  end

  step("kit list: 80 items virtualize, scroll, shift and ctrl selection", function()
    log = {}
    local Row = {}
    function Row:OnCreate()
      self.kitLabel = self:CreateFontString(nil, "ARTWORK")
      self.kitLabel:SetFontObject(UI.Fonts.Get("body"))
      self.kitLabel:SetPoint("LEFT", self, "LEFT", 8, 0)
    end
    function Row:Bind(item) self.kitLabel:SetText(item.text) end
    order, selection = {}, {}
    for i = 1, 80 do order[i] = i end
    list = UI.List(page, { id = "list", height = 200, selection = selection,
      kinds = { row = { height = 28, mixin = Row, draggable = true, selectable = true } },
      items = buildItems(),
      onSelect = function(newSelection) selection = newSelection list:SetSelection(newSelection) end,
      onReorder = function(keys, slot)
        order = UI.ListMath.Reorder(order, keys, slot)
        log[#log + 1] = "reorder:"..table.concat(keys, ",")..">"..slot
        list:SetItems(buildItems())
      end,
      onContext = function(item)
        return {
          { text = "Delete "..item.text, onSelect = function() log[#log + 1] = "delete:"..item.key end },
          { kind = "separator" },
          { text = "Disabled", disabled = true, onSelect = logged("never") },
        }
      end,
      onActivate = function(item) log[#log + 1] = "activate:"..item.key end,
    })
    UI.Layout.FlushAll()
    local bound = 0
    list:ForEachRow(function() bound = bound + 1 end)
    expect(bound > 0 and bound < 12, "list bound "..bound.." rows for a 200px viewport")
    expect(list:GetRow(1) and not list:GetRow(40), "visible range is wrong")
    W.fireScript(list.kitViewport, "OnMouseWheel", -1)
    local offset = list:GetOffset()
    expect(offset > 0, "wheel did not scroll the list")
    expect(list:GetRow(1) == nil or math.abs(list:GetRow(1):GetTop() - (list.kitViewport:GetTop() + offset)) < 0.01,
      "rows did not move up by the wheel's scroll offset")
    list:ScrollTo(80, "nearest")
    expect(list:GetRow(80) and not list:GetRow(1), "ScrollTo did not reach the last item")
    expect(list:GetRow(80):GetBottom() >= list.kitViewport:GetBottom() - 0.01, "last row is cut off")
    list:SetOffset(0)
    expect(list:GetRow(1) and list:GetRow(1):GetTop() == list.kitViewport:GetTop(), "offset 0 does not put row 1 at the top")

    click(list:GetRow(2))
    expect(#selection == 1 and selection[1] == 2 and lastLog() == "activate:2", "plain click did not select and activate")
    W.modifiers = { shift = true }
    click(list:GetRow(5))
    W.modifiers = { ctrl = true }
    click(list:GetRow(3))
    click(list:GetRow(7))
    W.modifiers = nil
    expect(table.concat(selection, ",") == "2,4,5,7", "shift and ctrl selection is "..table.concat(selection, ","))
    expect(list:GetRow(2).kitRowBorder.textures.top:IsShown() and not list:GetRow(3).kitRowBorder.textures.top:IsShown(), "selected rows are not painted")
  end)

  step("kit list: drag reorder with edge auto-scroll, queued SetItems, cancel and no-op drops", function()
    log = {}
    click(list:GetRow(2))
    W.modifiers = { shift = true }
    click(list:GetRow(3))
    W.modifiers = nil
    expect(table.concat(selection, ",") == "2,3", "selection before the drag is "..table.concat(selection, ","))
    local depth = UI.Escape.Depth()
    local viewport = list.kitViewport
    W.cursorX, W.cursorY = list:GetRow(2):GetCenter()
    W.fireScript(list:GetRow(2), "OnDragStart")
    expect(list:IsDragging() and list.kitGhost:IsShown(), "drag did not start")
    expect(UI.Escape.Depth() == depth + 1, "drag did not push an Escape entry")
    expect(list.kitGhost.kitBadge:GetText() == "x2", "ghost badge is "..tostring(list.kitGhost.kitBadge:GetText()))
    expect(list:GetRow(2):GetAlpha() < 1 and list:GetRow(4):GetAlpha() == 1, "drag source rows are not dimmed")
    W.pump(0.1)
    expect(not list.kitIndicator:IsShown(), "indicator shown while hovering the block's own slot")

    list:SetItems(buildItems())
    expect(list.kitPendingItems ~= nil, "SetItems during a drag was applied immediately")

    W.cursorY = viewport:GetBottom() + 4
    local before = list:GetOffset()
    W.pump(0.5)
    expect(list:GetOffset() > before + 50, "bottom edge did not auto-scroll: "..list:GetOffset())
    W.cursorY = viewport:GetTop() - 4
    W.pump(2)
    expect(list:GetOffset() == 0, "top edge did not scroll back to the start")

    local targetTop = viewport:GetTop() - (list.kitTops[6] - list:GetOffset())
    W.cursorY = targetTop - 3
    W.pump(0.05)
    expect(list.kitIndicator:IsShown(), "drop indicator hidden over a valid slot")
    expect(math.abs(list.kitIndicator:GetTop() - targetTop) <= 2, "indicator is not at the slot boundary")
    W.fireScript(list.kitGhost, "OnDragStop")
    W.fireScript(list:GetRow(1), "OnDragStop")
    expect(not list:IsDragging() and not list.kitGhost:IsShown(), "drop did not end the drag")
    expect(UI.Escape.Depth() == depth, "drag left its Escape entry")
    expect(list.kitPendingItems == nil, "queued SetItems was not applied on drop")
    expect(lastLog() == "reorder:2,3>6", "drop reported "..tostring(lastLog()))
    expect(table.concat(order, ",", 1, 10) == "1,4,5,2,3,6,7,8,9,10", "order after the drop is "..table.concat(order, ",", 1, 10))
    expect(list:GetRow(4).kitItem.key == 2 and list:GetRow(4).kitLabel:GetText() == "Item 2", "rows did not rebind to the new order")

    local function reorders()
      local count = 0
      for _, entry in ipairs(log) do if entry:find("^reorder:") then count = count + 1 end end
      return count
    end
    click(list:GetRow(5))
    W.cursorX, W.cursorY = list:GetRow(5):GetCenter()
    W.fireScript(list:GetRow(5), "OnDragStart")
    W.cursorY = list:GetRow(5):GetTop() - 2
    W.pump(0.05)
    expect(not list.kitIndicator:IsShown(), "indicator shown over the row's own slot")
    W.fireScript(list:GetRow(5), "OnDragStop")
    expect(reorders() == 1, "dropping a row onto itself reordered")

    click(list:GetRow(6))
    W.fireScript(list:GetRow(6), "OnDragStart")
    expect(list:IsDragging(), "second drag did not start")
    expect(CloseSpecialWindows(), "Escape found nothing during the drag")
    expect(not list:IsDragging() and reorders() == 1, "Escape did not cancel the drag")
    expect(MDT.main_frame:IsShown(), "Escape during a drag closed the main window")
    W.settle(asyncIdle, 5)
  end)

  step("kit menus: context menu, button menu, dropdown choices", function()
    log = {}
    click(list:GetRow(1), "RightButton")
    local menu = UI.Overlay.Top("menu")
    expect(menu and menu.frame:IsVisible(), "right-click did not open a context menu")
    local menuList
    for _, child in ipairs(menu.frame.content.kitChildren) do
      if child.kit.name == "List" then menuList = child end
    end
    expect(menuList and menuList:GetRow(1).kitLabel:GetText() == "Delete Item 1", "context menu rows are wrong")
    expect(menuList:GetRow(2).kitKind.static, "separator row is not static")
    click(menuList:GetRow(3))
    expect(UI.Overlay.Top("menu") == menu, "a disabled item closed the menu")
    expect(CloseSpecialWindows(), "Escape found nothing with a menu open")
    expect(not menu.frame:IsShown() and MDT.main_frame:IsShown(), "Escape did not close only the menu")
    W.settle(asyncIdle, 5)
    click(list:GetRow(1), "RightButton")
    menu = UI.Overlay.Top("menu")
    for _, child in ipairs(menu.frame.content.kitChildren) do
      if child.kit.name == "List" then menuList = child end
    end
    click(menuList:GetRow(1))
    expect(lastLog() == "delete:1" and UI.Overlay.Top("menu") == nil, "selecting an action did not run it and close the menu")

    local toggled = false
    local menuButton = UI.Button(page, { id = "menuButton", text = "More", chevron = true, menu = function()
      return {
        { kind = "title", text = "Route" },
        { text = "Rename", onSelect = logged("rename") },
        { kind = "toggle", text = "Live", checked = toggled, onSelect = function(item) toggled = item.checked end },
        { kind = "submenu", text = "Send", items = { { text = "Party", onSelect = logged("party") } } },
      }
    end })
    UI.Layout.FlushAll()
    click(menuButton)
    menu = UI.Overlay.Top("menu")
    expect(menu and menu.frame:IsVisible(), "button menu did not open")
    ctx.render("kit button menu", page, { menu.frame })
    expect(menu.frame:GetTop() <= menuButton:GetBottom() + 0.01, "button menu is not below the button")
    for _, child in ipairs(menu.frame.content.kitChildren) do
      if child.kit.name == "List" then menuList = child end
    end
    click(menuList:GetRow(3))
    expect(toggled == true and UI.Overlay.Top("menu") == menu, "toggle did not flip or closed the menu")
    expect(menuList:GetRow(3).kitCheck:IsShown(), "toggle row did not repaint its check")
    click(menuList:GetRow(4))
    local submenu = UI.Overlay.Top("menu")
    expect(submenu and submenu ~= menu and submenu.frame:IsVisible(), "submenu did not open")
    local subList
    for _, child in ipairs(submenu.frame.content.kitChildren) do
      if child.kit.name == "List" then subList = child end
    end
    click(subList:GetRow(1))
    expect(lastLog() == "party" and UI.Overlay.Top("menu") == nil, "submenu action did not close the whole chain")

    local dropdown = page:Find("dropdown")
    click(dropdown.kitButton)
    menu = UI.Overlay.Top("menu")
    expect(menu and menu.frame:IsVisible(), "dropdown did not open its menu")
    for _, child in ipairs(menu.frame.content.kitChildren) do
      if child.kit.name == "List" then menuList = child end
    end
    expect(menuList:GetRow(2).kitCheck:IsShown() and not menuList:GetRow(1).kitCheck:IsShown(), "dropdown menu does not mark the current value")
    click(menuList:GetRow(1))
    expect(lastLog() == "pick:a" and dropdown:GetValue() == "a" and dropdown.kitButton:GetText() == "Alpha", "dropdown choice did not apply")
    expect(UI.Overlay.Top("menu") == nil, "dropdown menu stayed open")
  end)
end
