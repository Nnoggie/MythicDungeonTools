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
    root:SetPoint("CENTER")
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
    local columns = page:Find("columns")
    expect(math.abs(columns[1]:GetWidth() * 2 - columns[2]:GetWidth()) <= 3, "columns are not weighted 1:2")
    expect(page:Find("tabA"), "first tab did not build its content")
    expect(lastLog() == "tab:a", "tabs did not report the initial selection")
    local userText = page:Find("userText")
    expect(userText.kitLabel:GetFontObject() == UI.Fonts.fallbacks.body.russian, "Cyrillic user text did not pick the russian fallback font")
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
end
