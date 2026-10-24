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

  local windowKeys = { "nonFullscreenScale", "anchorFrom", "anchorTo", "xoffset", "yoffset" }

  ---What the user set: the saved window scale and position.
  local function savedWindow()
    local db, saved = MDT:GetDB(), {}
    for index, key in ipairs(windowKeys) do saved[index] = db[key] end
    return saved
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

  ---Drags the window by handle (default: its top bar) and drops it with its point at x, y. The client moves only a
  ---window that started moving, and anchors a dropped window to the same point of its parent.
  local function dragWindowTo(point, x, y, handle)
    local f = MDT.main_frame
    handle = handle or f.topPanel
    W.fireScript(handle, "OnDragStart", "LeftButton")
    if W.state[f].moving then
      f:ClearAllPoints()
      f:SetPoint(point, MDT.UI.Root, point, x, y)
    end
    W.fireScript(handle, "OnDragStop")
    settle()
  end

  ---Drags the resize handle until the window is height tall at the map's aspect ratio and lets go in the same frame,
  ---before the client reports that last size change.
  ---@return number[] rect the window (windowRect) just before the handle was released
  local function resizeWindowTo(height)
    local f = MDT.main_frame
    local mapWidth, mapHeight = MDT:GetDefaultMapPanelSize()
    W.fireScript(f.resizer, "OnMouseDown", "LeftButton")
    local point, _, relativePoint = f:GetPoint()
    expect(point ~= relativePoint, "setup: sizing left the window anchored by matching points")
    f:SetSize(height * mapWidth / mapHeight, height)
    local rect = { windowRect() }
    W.fireScript(f.resizer, "OnMouseUp", "LeftButton")
    settle()
    return rect
  end

  ---The window is shown where it is saved, at the saved size as far as the Root fits it.
  local function expectShownAtSaved(when)
    local db, f = MDT:GetDB(), MDT.main_frame
    local _, mapHeight = MDT:GetDefaultMapPanelSize()
    local _, _, fullscreenScale = MDT:GetFullScreenSizes()
    local point, _, relativePoint, x, y = f:GetPoint()
    expect(db.anchorFrom == point and db.anchorTo == relativePoint and point == relativePoint and near(db.xoffset, x, 1e-3) and near(db.yoffset, y, 1e-3),
      ("the window is at %s %s %s %s but saved at %s %s %s %s %s"):format(point, relativePoint, x, y, db.anchorFrom, db.anchorTo, db.xoffset, db.yoffset, when))
    local scale = math.min(db.nonFullscreenScale, fullscreenScale)
    expect(near(f:GetHeight(), mapHeight * scale, 1e-3),
      ("the window is %.1f tall, expected %.1f at saved scale %s %s"):format(f:GetHeight(), mapHeight * scale, db.nonFullscreenScale, when))
  end

  local anchorPoints = {
    TOPLEFT = true, TOP = true, TOPRIGHT = true, LEFT = true, CENTER = true, RIGHT = true,
    BOTTOMLEFT = true, BOTTOM = true, BOTTOMRIGHT = true,
  }
  local function finite(value) return type(value) == "number" and value == value and math.abs(value) ~= math.huge end

  ---The MDT scale and window geometry MDT should load from what was stored: what it cannot show the window with falls
  ---back to the default, offsets together with their anchors.
  local function loadedSettings(stored)
    local loaded = {}
    for _, key in ipairs({ "uiScale", "nonFullscreenScale", "anchorFrom", "anchorTo", "xoffset", "yoffset" }) do
      if stored[key] == nil then loaded[key] = defaults[key] else loaded[key] = stored[key] end
    end
    loaded.uiScale = finite(loaded.uiScale) and loaded.uiScale > 0 and math.min(3, math.max(0.5, loaded.uiScale)) or 1
    loaded.nonFullscreenScale = finite(loaded.nonFullscreenScale) and math.max(0.9, loaded.nonFullscreenScale) or defaults.nonFullscreenScale
    if not (anchorPoints[loaded.anchorFrom] and anchorPoints[loaded.anchorTo]) then
      for _, key in ipairs({ "anchorFrom", "anchorTo", "xoffset", "yoffset" }) do loaded[key] = defaults[key] end
    end
    for _, key in ipairs({ "xoffset", "yoffset" }) do
      if not finite(loaded[key]) then loaded[key] = defaults[key] end
    end
    return loaded
  end

  local loaded = loadedSettings(ctx.stored)
  local storedWindow, storedValid = {}, true
  for index, key in ipairs(windowKeys) do
    if ctx.stored[key] == nil then storedWindow[index] = defaults[key] else storedWindow[index] = ctx.stored[key] end
    if loaded[key] ~= storedWindow[index] then storedValid = false end
  end

  local function setScreen(width, height)
    W.setScreen(width, height)
    W.FireEvent("DISPLAY_SIZE_CHANGED")
    settle()
  end

  step("scale: a saved MDT scale and a window saved by 6.3.10 on this screen fit the screen after load", function()
    local db, f = MDT:GetDB(), MDT.main_frame
    local _, mapHeight = MDT:GetDefaultMapPanelSize()
    expect(ctx.loginRelayouts == 0, ("the window was laid out %d more times after it was built"):format(ctx.loginRelayouts))
    if ctx.seeded then
      local seeded = ctx.seeded
      expect(near(rootScale(), 768 / 1440 * seeded.uiScale), "the saved MDT scale was not applied: root scale "..rootScale())
      local _, _, fullscreenScale = MDT:GetFullScreenSizes()
      local shownScale = math.min(seeded.nonFullscreenScale, fullscreenScale)
      expect(near(f:GetHeight(), mapHeight * shownScale, 1e-3),
        ("the window is %.1f tall, expected %.1f (saved scale %.3f, fullscreen scale %.3f)"):format(f:GetHeight(), mapHeight * shownScale, seeded.nonFullscreenScale, fullscreenScale))
      if seeded.nonFullscreenScale > fullscreenScale then
        expect(f:GetHeight() < mapHeight * seeded.nonFullscreenScale - 0.5, "the oversized window was not shown smaller")
      end
      expect(near(db.scale * mapHeight, f:GetHeight()), ("the map uses scale %s for a window %s tall"):format(db.scale, f:GetHeight()))
    end
    if storedValid then expectSavedWindow(storedWindow, "at load") end
    expectOnScreen("after load")
  end)

  step("scale: a broken saved MDT scale, map scale and window geometry load as valid ones", function()
    if ctx.seeded then
      local output = ctx.bootWithSavedVariables([[MythicDungeonToolsDB = { global = {
        uiScale = -3, scale = 0/0, maximized = true, nonFullscreenScale = 0.3,
        anchorFrom = "TOPLEFT", anchorTo = 12, xoffset = 300, yoffset = -50,
      } }]])
      local failures = {}
      for line in output:gmatch("[^\n]+") do
        if line:find("^FAIL") or line:find("^  ") then failures[#failures + 1] = line end
      end
      expect(output:find("\nPASSED") and #failures == 0, "booting with broken saved variables failed:\n"..table.concat(failures, "\n"):sub(1, 3000))
      return
    end
    local db = MDT:GetDB()
    for key, value in pairs(loaded) do
      expect(db[key] == value, ("saved %s %s loaded as %s, expected %s"):format(key, tostring(ctx.stored[key]), tostring(db[key]), tostring(value)))
    end
    expect(near(rootScale(), 768 / 1440 * loaded.uiScale), "root scale is "..rootScale())
    local _, _, fullscreenScale = MDT:GetFullScreenSizes()
    local scale = db.maximized and fullscreenScale or MDT:GetNormalWindowScale()
    expect(near(db.scale, scale), ("the map uses scale %s, expected %s"):format(tostring(db.scale), scale))
    if db.maximized then expectFillsScreen("after load") else expectOnScreen("after load") end
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
    for _, case in ipairs({ { "big", 1 }, { 0 / 0, 1 }, { false, 1 }, { 9, 3 }, { 0.1, 0.5 } }) do
      local applied = UI.SetUserScale(case[1])
      expect(applied == case[2] and near(rootScale(), 768 / 1440 * case[2]),
        ("MDT scale %s applied as %s, root scale %s"):format(tostring(case[1]), tostring(applied), rootScale()))
    end
    UI.SetUserScale(db.uiScale)
    settle()
  end)

  step("scale: at MDT scale 300% the window fits the screen, maximized and normal", function()
    local db, f = MDT:GetDB(), MDT.main_frame
    local slider = scaleSlider()
    click(f.maximizeButton)
    expect(db.maximized, "setup: the window did not maximize")
    dragAndRelease(slider, 3)
    expect(near(rootScale(), 768 / 1440 * 3), "root scale is "..rootScale().." at MDT scale 300%")
    expectFillsScreen("at MDT scale 300%")
    click(f.maximizeButton)
    expect(not db.maximized, "setup: the window did not leave fullscreen")
    expectOnScreen("at MDT scale 300%")
  end)

  ---Runs /mdt reset and checks that it laid the window out once, saved the defaults and shows them fitted to the Root.
  local function resetWindow(when)
    local db, f = MDT:GetDB(), MDT.main_frame
    local calls, originals = {}, {}
    for _, name in ipairs({ "Minimize", "Maximize", "PlaceNormalWindow" }) do
      calls[name], originals[name] = 0, MDT[name]
      MDT[name] = function(...)
        calls[name] = calls[name] + 1
        return originals[name](...)
      end
    end
    local ok, err = pcall(function()
      W.RunSlashCommand("/mdt reset")
      settle()
    end)
    for name, original in pairs(originals) do MDT[name] = original end
    if not ok then error(err, 0) end
    expect(calls.Minimize == 1 and calls.Maximize == 0 and calls.PlaceNormalWindow == 1,
      ("/mdt reset %s laid the window out %d times normal, %d times maximized and placed it %d times"):format(when, calls.Minimize, calls.Maximize, calls.PlaceNormalWindow))
    expect(not db.maximized and not (f.blackoutFrame and f.blackoutFrame:IsShown()), "the window is still maximized "..when)
    expectSavedWindow({ defaults.nonFullscreenScale, defaults.anchorFrom, defaults.anchorTo, defaults.xoffset, defaults.yoffset }, when)
    expect(db.uiScale == 1 and near(rootScale(), 768 / 1440), ("MDT scale is %s, root scale %s %s"):format(db.uiScale, rootScale(), when))
    local _, mapHeight = MDT:GetDefaultMapPanelSize()
    local _, _, fullscreenScale = MDT:GetFullScreenSizes()
    local shownScale = math.min(defaults.nonFullscreenScale, fullscreenScale)
    expect(near(f:GetHeight(), mapHeight * shownScale, 1e-3) and near(db.scale, shownScale),
      ("the window is %.1f tall at map scale %s, expected scale %s %s"):format(f:GetHeight(), db.scale, shownScale, when))
    expectOnScreen(when)
  end

  step("scale: /mdt reset leaves fullscreen and restores the default position, window size and MDT scale", function()
    local db, f = MDT:GetDB(), MDT.main_frame
    local slider = scaleSlider()
    click(f.maximizeButton)
    expect(db.maximized and db.uiScale ~= 1, "setup: the window is not maximized at a custom MDT scale")
    resetWindow("from fullscreen at MDT scale "..db.uiScale)
    expect(slider.kitValueText:GetText() == "100%", "the slider shows "..tostring(slider.kitValueText:GetText()))
  end)

  step("scale: a window dropped partly off screen stays there, also after fullscreen and back", function()
    local db, f = MDT:GetDB(), MDT.main_frame
    local rootWidth, rootHeight = MDT.UI.Root:GetSize()
    -- Hides most of the side panel past the bottom right corner, as users do to hide the pull list.
    dragWindowTo("BOTTOMRIGHT", f.sidePanel:GetWidth() - 40, -100)
    local left, right, bottom, top = windowRect()
    expect(right > W.screenWidth and bottom < 0, ("the window moved on screen, to x %.1f..%.1f, y %.1f..%.1f"):format(left, right, bottom, top))
    expect(db.windowPartlyOffScreen == true, "the window is not saved as parked partly off screen")
    expectShownAtSaved("after dropping the window past the bottom right corner")
    local shown = shownWindow()
    click(f.maximizeButton)
    click(f.maximizeButton)
    expectShownWindow(shown, "after fullscreen and back")
    expectShownAtSaved("after fullscreen and back")

    local saved = savedWindow()
    dragWindowTo("TOPLEFT", rootWidth + 100, -100)
    expectSavedWindow(saved, "after dropping the window past the right edge")
    expectShownWindow(shown, "after dropping the window past the right edge")
    dragWindowTo("TOPLEFT", 0, -rootHeight - 100)
    expectShownWindow(shown, "after dropping the window past the bottom edge")

    dragWindowTo("TOPLEFT", 100, -100)
    expectOnScreen("after dropping the window on screen again")
    expect(db.windowPartlyOffScreen == false, "the window is still saved as parked partly off screen")
  end)

  step("scale: dragging the maximized window changes neither it nor where the normal window is saved", function()
    local db, f = MDT:GetDB(), MDT.main_frame
    local saved, shown = savedWindow(), shownWindow()
    click(f.maximizeButton)
    expect(db.maximized, "setup: the window did not maximize")
    local maximized = shownWindow()
    for _, handle in ipairs({ f.sidePanel, f.navigationSidebar, f.topPanel }) do
      dragWindowTo("TOPLEFT", 40, -40, handle)
      expectShownWindow(maximized, "after dragging the maximized window by "..tostring(handle:GetName()))
    end
    expectSavedWindow(saved, "after dragging the maximized window")
    click(f.maximizeButton)
    expectShownWindow(shown, "after leaving fullscreen")
  end)

  ---Runs fn while the Root reports its new size in the middle of rescaling, as the client may when the pixel borders
  ---refresh, instead of on the next frame.
  local function withImmediateRootResize(fn)
    local Pixel = MDT.UI.Pixel
    local refresh = Pixel.Refresh
    Pixel.Refresh = function(...)
      refresh(...)
      W.layoutPass()
    end
    local ok, err = pcall(fn)
    Pixel.Refresh = refresh
    if not ok then error(err, 0) end
  end

  ---Runs fn while the Root never reports a new size.
  local function withoutRootResize(fn)
    local scripts = W.state[MDT.UI.Root].scripts
    local onSizeChanged = scripts.OnSizeChanged
    scripts.OnSizeChanged = nil
    local ok, err = pcall(fn)
    scripts.OnSizeChanged = onSizeChanged
    W.state[MDT.UI.Root].reportedSize = { MDT.UI.Root:GetSize() }
    if not ok then error(err, 0) end
  end

  local timings = {
    ["on the next frame"] = function(fn) fn() end,
    ["right away"] = withImmediateRootResize,
    ["never"] = withoutRootResize,
  }
  for _, timing in ipairs({ "on the next frame", "right away", "never" }) do
    step("scale: rescaling MDT keeps the window's top left corner and height on screen, also from fullscreen, with the Root resized "..timing, function()
      local db, f = MDT:GetDB(), MDT.main_frame
      local slider = scaleSlider()
      expect(db.uiScale == 1, "setup: MDT scale is not 100%")
      dragWindowTo("TOPLEFT", 150, -80)
      local shown = shownWindow()
      local left, _, bottom, top = windowRect()
      local function expectSameCorner(when)
        local nowLeft, _, nowBottom, nowTop = windowRect()
        expect(near(nowLeft, left, 0.01) and near(nowTop, top, 0.01) and near(nowTop - nowBottom, top - bottom, 0.01),
          ("the window's top left moved from %.2f, %.2f to %.2f, %.2f and its height from %.2f to %.2f %s"):format(left, top, nowLeft, nowTop, top - bottom, nowTop - nowBottom, when))
        expectShownAtSaved(when)
        -- A later refit, here from another addon rescaling UIParent, leaves the window as it is.
        local shownNow = shownWindow()
        UIParent:SetScale(0.7)
        settle()
        UIParent:SetScale(1)
        settle()
        expectShownWindow(shownNow, "after a later refit "..when)
      end
      local function run()
        dragAndRelease(slider, 1.25)
        expectSameCorner("at MDT scale 125%")
        dragAndRelease(slider, 0.8)
        expectSameCorner("at MDT scale 80%")
        click(f.maximizeButton)
        dragAndRelease(slider, 1.4)
        expectFillsScreen("at MDT scale 140%")
        click(f.maximizeButton)
        expectSameCorner("after leaving fullscreen at MDT scale 140%")
        dragAndRelease(slider, 1)
        expectSameCorner("back at MDT scale 100%")
        expectShownWindow(shown, "back at MDT scale 100%")
      end
      local ok, err = pcall(timings[timing], run)
      if not ok then
        if db.maximized then click(f.maximizeButton) end
        dragAndRelease(slider, 1)
        click(f.navigationSidebar.buttons.maps)
        error(err, 0)
      end
      click(f.navigationSidebar.buttons.maps)
    end)
  end

  step("scale: at MDT scale 200% the window grows to its smallest size and is saved at the same top left corner", function()
    local db, f = MDT:GetDB(), MDT.main_frame
    local slider = scaleSlider()
    local left, _, _, top = windowRect()
    dragAndRelease(slider, 2)
    -- On a narrow screen the grown window may be shown moved on screen; it is saved where it was.
    local scale, navigationWidth = rootScale(), MDT:GetNavigationSidebarWidth()
    local savedLeft, savedTop = (db.xoffset - navigationWidth) * scale, W.screenHeight + (db.yoffset + 30) * scale
    expect(db.anchorFrom == "TOPLEFT" and db.anchorTo == "TOPLEFT" and near(savedLeft, left, 0.01) and near(savedTop, top, 0.01),
      ("the window's top left was %.2f, %.2f and is saved at %s %.2f, %.2f"):format(left, top, db.anchorFrom, savedLeft, savedTop))
    expect(db.nonFullscreenScale == MDT:GetMinNonFullscreenScale(), "the saved window scale is "..db.nonFullscreenScale)
    expectOnScreen("at MDT scale 200%")
    dragAndRelease(slider, 1)
    click(f.navigationSidebar.buttons.maps)
  end)

  step("scale: the window is never saved bigger than the screen holds after rescaling", function()
    local db, f = MDT:GetDB(), MDT.main_frame
    local slider = scaleSlider()
    for _, target in ipairs({ 3, 0.5, 2, 0.75, 1 }) do
      dragAndRelease(slider, target)
      local _, _, fullscreenScale = MDT:GetFullScreenSizes()
      expect(db.nonFullscreenScale <= math.max(MDT:GetMinNonFullscreenScale(), fullscreenScale) + 1e-6,
        ("at MDT scale %s the window is saved at scale %.3f, but only %.3f fits"):format(target, db.nonFullscreenScale, fullscreenScale))
      expectOnScreen("at MDT scale "..target)
    end
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

  step("scale: a resized window stays where it is shown and is saved there, also when MDT rescales", function()
    local db, f = MDT:GetDB(), MDT.main_frame
    local slider = scaleSlider()
    W.RunSlashCommand("/mdt reset")
    settle()
    local shown = resizeWindowTo(f:GetHeight() * 0.9)
    local now = { windowRect() }
    for index = 1, 4 do
      expect(near(now[index], shown[index], 1e-3), ("releasing the resize handle moved the window from %.1f to %.1f"):format(shown[index], now[index]))
    end
    expectOnScreen("after resizing")
    expectShownAtSaved("after resizing")

    local uiScale = db.uiScale
    dragAndRelease(slider, uiScale - 0.1)
    expectOnScreen("after rescaling a resized window")
    expectShownAtSaved("after rescaling a resized window")
    dragAndRelease(slider, uiScale)

    dragWindowTo("TOPRIGHT", -f.sidePanel:GetWidth() - 10, -100)
    resizeWindowTo(f:GetHeight() * 1.1)
    expectOnScreen("after resizing past the right edge")
    expectShownAtSaved("after resizing past the right edge")
    click(f.navigationSidebar.buttons.maps)
  end)

  step("scale: /mdt reset at MDT scale 100% puts a moved and resized window back", function()
    expect(MDT:GetDB().uiScale == 1, "setup: MDT scale is not 100%")
    resetWindow("at MDT scale 100%")
  end)
end
