-- Harness steps for MDT's screen-relative scale: the MDT scale setting, and the window staying on screen as the
-- Root's size changes.
return function(ctx)
  local W, MDT, step, expect, click, asyncIdle = ctx.W, ctx.MDT, ctx.step, ctx.expect, ctx.click, ctx.asyncIdle
  local defaults = MDT:GetDefaultSavedVariables().global

  local function near(a, b, tolerance) return math.abs(a - b) < (tolerance or 1e-6) end
  local function rootScale() return MDT.UI.Root:GetEffectiveScale() end
  local function settle() W.settle(asyncIdle, 30) end

  ---Runs fn and returns how often the Root reported a settled new size meanwhile.
  local function countRootResizes(fn)
    local count = 0
    local unsubscribe = MDT.UI.OnRootResized(function() count = count + 1 end)
    local ok, err = pcall(fn)
    unsubscribe()
    if not ok then error(err, 0) end
    return count
  end

  ---The visible window (sidebar, map, side panel and both bars) in screen units.
  local function windowRect()
    local f = MDT.main_frame
    local left = f.navigationSidebar:GetScaledRect()
    local sideLeft, _, sideWidth = f.sidePanel:GetScaledRect()
    local _, top, _, topHeight = f.topPanel:GetScaledRect()
    local _, bottom = f.bottomPanel:GetScaledRect()
    return left, sideLeft + sideWidth, bottom, top + topHeight
  end

  local function expectOnScreen(when)
    local left, right, bottom, top = windowRect()
    local slack = 0.01
    expect(left >= -slack and right <= W.screenWidth + slack and bottom >= -slack and top <= W.screenHeight + slack,
      ("window spans x %.1f..%.1f, y %.1f..%.1f on a %.1fx%.1f screen %s"):format(left, right, bottom, top, W.screenWidth, W.screenHeight, when))
  end

  local function expectFillsScreen(when)
    expectOnScreen(when)
    local left, right, bottom, top = windowRect()
    expect(math.abs(right - left - W.screenWidth) < 0.5 or math.abs(top - bottom - W.screenHeight) < 0.5,
      ("the maximized window does not fill the screen %s: %.1fx%.1f of %.1fx%.1f"):format(when, right - left, top - bottom, W.screenWidth, W.screenHeight))
  end

  ---What the user set: the saved window scale and position.
  local function savedWindow()
    local db = MDT:GetDB()
    return { db.nonFullscreenScale, db.anchorFrom, db.anchorTo, db.xoffset, db.yoffset }
  end

  local function expectSavedWindow(saved, when)
    local now = savedWindow()
    for index = 1, #saved do
      expect(now[index] == saved[index], ("the saved window changed %s: %s became %s"):format(when, tostring(saved[index]), tostring(now[index])))
    end
  end

  ---The shown window: its size and anchor in Root units.
  local function shownWindow()
    local f = MDT.main_frame
    local point, _, relativePoint, x, y = f:GetPoint()
    return { f:GetWidth(), f:GetHeight(), point, relativePoint, x, y }
  end

  local function expectShownWindow(shown, when)
    local now = shownWindow()
    for index = 1, #shown do
      local same = type(shown[index]) == "number" and near(now[index], shown[index], 1e-3) or now[index] == shown[index]
      expect(same, ("the window did not come back %s: %s is %s"):format(when, tostring(shown[index]), tostring(now[index])))
    end
  end

  local function scaleSlider()
    click(MDT.main_frame.navigationSidebar.buttons.settings)
    for _, child in ipairs({ MDT.main_frame.sectionContentFrames.settings:GetChildren() }) do
      if child.kit and child.kit.name == "Scroll" then
        local slider = child.content:Find("uiScale")
        expect(slider and slider:IsVisible(), "the MDT scale slider is missing or hidden")
        return slider
      end
    end
    error("settings has no kit page")
  end

  local function dragAndRelease(slider, value)
    W.userDrag(slider.kitSlider, value)
    W.fireScript(slider.kitSlider, "OnMouseUp", "LeftButton")
    settle()
  end

  ---Drags the window by its top bar and drops it with its point at x, y. The client anchors a dropped window to the
  ---same point of its parent.
  local function dragWindowTo(point, x, y)
    local f = MDT.main_frame
    W.fireScript(f.topPanel, "OnDragStart", "LeftButton")
    f:ClearAllPoints()
    f:SetPoint(point, MDT.UI.Root, point, x, y)
    W.fireScript(f.topPanel, "OnDragStop")
    settle()
  end

  local function setScreen(width, height)
    W.setScreen(width, height)
    W.FireEvent("DISPLAY_SIZE_CHANGED")
    settle()
  end

  step("scale: a saved MDT scale and a window saved by 6.3.10 on this screen fit the screen after load", function()
    local db, f = MDT:GetDB(), MDT.main_frame
    if ctx.seeded then
      local seeded = ctx.seeded
      expect(near(rootScale(), 768 / 1440 * seeded.uiScale), "the saved MDT scale was not applied: root scale "..rootScale())
      expect(f:GetHeight() < 555 * seeded.nonFullscreenScale - 0.5, "the oversized window was not shown smaller")
      expect(near(db.scale * 555, f:GetHeight()), ("the map uses scale %s for a window %s tall"):format(db.scale, f:GetHeight()))
    end
    local stored = {}
    for index, key in ipairs({ "nonFullscreenScale", "anchorFrom", "anchorTo", "xoffset", "yoffset" }) do
      if ctx.stored[key] == nil then stored[index] = defaults[key] else stored[index] = ctx.stored[key] end
    end
    expectSavedWindow(stored, "at load")
    expectOnScreen("after load")
  end)

  step("scale: the settings slider sets MDT's scale on release and saves it", function()
    local db, f = MDT:GetDB(), MDT.main_frame
    if db.maximized then click(f.maximizeButton) end
    local slider = scaleSlider()
    local format = slider.kitProps.format
    expect(slider.kitValueText:GetText() == format(db.uiScale), "the slider shows "..tostring(slider.kitValueText:GetText()))

    local scale, shown = MDT.UI.Root:GetScale(), shownWindow()
    local resized = countRootResizes(function()
      W.fireScript(slider.kitSlider, "OnMouseUp", "LeftButton")
      settle()
    end)
    expect(resized == 0, "releasing the slider without moving it rescaled MDT")
    expectShownWindow(shown, "after releasing the slider without moving it")

    local target = db.uiScale == 1.5 and 1.25 or 1.5
    W.userDrag(slider.kitSlider, target)
    expect(db.uiScale ~= target and MDT.UI.Root:GetScale() == scale, "MDT rescaled while the slider was still held")
    W.fireScript(slider.kitSlider, "OnMouseUp", "LeftButton")
    settle()
    expect(db.uiScale == target, "the slider saved "..tostring(db.uiScale))
    expect(near(rootScale(), 768 / 1440 * target), ("root scale is %s at MDT scale %s"):format(rootScale(), target))
    expect(slider.kitValueText:GetText() == format(target), "the slider shows "..tostring(slider.kitValueText:GetText()))
    expectOnScreen("at MDT scale "..target)
  end)

  step("scale: a corrupt or out of range MDT scale is applied as a valid one", function()
    local UI, db = MDT.UI, MDT:GetDB()
    for _, case in ipairs({ { "big", 1 }, { 0 / 0, 1 }, { false, 1 }, { 9, 2 }, { 0.1, 0.5 } }) do
      local applied = UI.SetUserScale(case[1])
      expect(applied == case[2] and near(rootScale(), 768 / 1440 * case[2]),
        ("MDT scale %s applied as %s, root scale %s"):format(tostring(case[1]), tostring(applied), rootScale()))
    end
    UI.SetUserScale(db.uiScale)
    settle()
  end)

  step("scale: at MDT scale 200% the window fits the screen, maximized and normal", function()
    local db, f = MDT:GetDB(), MDT.main_frame
    local slider = scaleSlider()
    click(f.maximizeButton)
    expect(db.maximized, "setup: the window did not maximize")
    dragAndRelease(slider, 2)
    expect(near(rootScale(), 768 / 1440 * 2), "root scale is "..rootScale().." at MDT scale 200%")
    expectFillsScreen("at MDT scale 200%")
    click(f.maximizeButton)
    expect(not db.maximized, "setup: the window did not leave fullscreen")
    expectOnScreen("at MDT scale 200%")
  end)

  step("scale: /mdt reset leaves fullscreen and restores the default position, window size and MDT scale", function()
    local db, f = MDT:GetDB(), MDT.main_frame
    local slider = scaleSlider()
    click(f.maximizeButton)
    expect(db.maximized and db.uiScale ~= 1, "setup: the window is not maximized at a custom MDT scale")
    W.RunSlashCommand("/mdt reset")
    settle()
    expect(not db.maximized and not f.blackoutFrame:IsShown(), "the window is still maximized")
    local point, relativeTo, relativePoint, x, y = f:GetPoint()
    expect(point == "TOP" and relativeTo == MDT.UI.Root and relativePoint == "TOP" and x == defaults.xoffset and y == defaults.yoffset,
      ("the window is at %s %s %s %s"):format(point, relativePoint, x, y))
    expect(math.abs(f:GetWidth() - 840 * defaults.nonFullscreenScale) < 0.01, "the window is "..f:GetWidth().." wide")
    expect(db.uiScale == 1 and near(rootScale(), 768 / 1440), ("MDT scale is %s, root scale %s"):format(db.uiScale, rootScale()))
    expect(slider.kitValueText:GetText() == "100%", "the slider shows "..tostring(slider.kitValueText:GetText()))
    expectOnScreen("after /mdt reset")
  end)

  step("scale: a window dropped partly off screen moves on screen and saves where it ends up", function()
    local db, f = MDT:GetDB(), MDT.main_frame
    dragWindowTo("TOPLEFT", -200, 50)
    expectOnScreen("after dropping the window past the top left corner")
    local point, _, relativePoint, x, y = f:GetPoint()
    expect(db.anchorFrom == point and db.anchorTo == relativePoint and db.xoffset == x and db.yoffset == y,
      ("the window is at %s %s %s %s but saved at %s %s %s %s"):format(point, relativePoint, x, y, db.anchorFrom, db.anchorTo, db.xoffset, db.yoffset))
    local left, _, _, top = windowRect()
    expect(near(left, 0, 0.01) and near(top, W.screenHeight, 0.01), ("the window moved further than needed, to %.1f, %.1f"):format(left, top))
  end)

  step("scale: MDT scale 200% and back restores the window, and fullscreen in between keeps where it was saved", function()
    local f = MDT.main_frame
    local slider = scaleSlider()
    dragWindowTo("TOPLEFT", MDT.UI.Root:GetWidth() - 251 - f:GetWidth() - 50, -80)
    local saved, shown = savedWindow(), shownWindow()
    dragAndRelease(slider, 2)
    expect(f:GetHeight() < shown[2] - 0.5, "setup: the window does not need to shrink at MDT scale 200%")
    expectOnScreen("at MDT scale 200%")
    click(f.maximizeButton)
    expectFillsScreen("at MDT scale 200%")
    click(f.maximizeButton)
    expectOnScreen("after leaving fullscreen at MDT scale 200%")
    expectSavedWindow(saved, "at MDT scale 200%")
    dragAndRelease(slider, 1)
    expectSavedWindow(saved, "back at MDT scale 100%")
    expectShownWindow(shown, "back at MDT scale 100%")
    click(f.navigationSidebar.buttons.maps)
  end)

  step("scale: the window fits and comes back as the screen changes, normal and maximized", function()
    local db, f = MDT:GetDB(), MDT.main_frame
    local width, height = W.physicalWidth, W.physicalHeight
    local saved = savedWindow()
    for _, maximized in ipairs({ false, true }) do
      if db.maximized ~= maximized then click(f.maximizeButton) end
      local shown = shownWindow()
      for _, screen in ipairs({ { 3440, 1440 }, { 1280, 1024 }, { 1024, 768 }, { width, height } }) do
        setScreen(screen[1], screen[2])
        local when = ("%s at %dx%d"):format(maximized and "maximized" or "normal", screen[1], screen[2])
        if maximized then expectFillsScreen(when) else expectOnScreen(when) end
      end
      expectShownWindow(shown, (maximized and "maximized" or "normal").." on the first screen again")
    end
    click(f.maximizeButton)
    expectSavedWindow(saved, "after the screen changes")
  end)

  step("scale: MDT keeps its scale when another addon rescales UIParent without UI_SCALE_CHANGED", function()
    local shown = shownWindow()
    for _, uiScale in ipairs({ 0.7, 1 }) do
      local refits = countRootResizes(function()
        UIParent:SetScale(uiScale)
        settle()
      end)
      expect(refits == 1, ("the window refit %d times after UIParent:SetScale(%s)"):format(refits, uiScale))
      expect(near(rootScale(), 768 / 1440), ("root scale is %s after UIParent:SetScale(%s)"):format(rootScale(), uiScale))
      expectShownWindow(shown, "after UIParent:SetScale("..uiScale..")")
    end
  end)

  step("scale: /mdt reset puts the window back after the scale steps", function()
    W.RunSlashCommand("/mdt reset")
    settle()
    expectOnScreen("after /mdt reset")
  end)
end
