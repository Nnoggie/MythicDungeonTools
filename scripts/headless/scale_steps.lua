-- Harness steps for MDT's screen-relative scale: the MDT scale setting, and the window staying on screen as the
-- Root's size changes.
return function(ctx)
  local W, MDT, step, expect, click, asyncIdle = ctx.W, ctx.MDT, ctx.step, ctx.expect, ctx.click, ctx.asyncIdle
  local defaults = MDT:GetDefaultSavedVariables().global

  local function near(a, b) return math.abs(a - b) < 1e-6 end
  local function rootScale() return MDT.UI.Root:GetEffectiveScale() end

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
    W.settle(asyncIdle, 30)
  end

  step("scale: a saved MDT scale and a window saved by 6.3.10 on a 4K screen fit the screen after load", function()
    local db = MDT:GetDB()
    if ctx.seeded then
      expect(near(rootScale(), 768 / 1440 * ctx.seeded.uiScale), "the saved MDT scale was not applied: root scale "..rootScale())
      expect(db.nonFullscreenScale < ctx.seeded.nonFullscreenScale, "the oversized window was not scaled down")
    end
    expectOnScreen("after load")
  end)

  step("scale: the settings slider sets MDT's scale on release and saves it", function()
    local db = MDT:GetDB()
    local slider = scaleSlider()
    expect(slider.kitValueText:GetText() == ("%d%%"):format(db.uiScale * 100), "the slider shows "..tostring(slider.kitValueText:GetText()))
    local before = rootScale()
    W.userDrag(slider.kitSlider, 1.5)
    expect(db.uiScale ~= 1.5 and near(rootScale(), before), "MDT rescaled while the slider was still held")
    W.fireScript(slider.kitSlider, "OnMouseUp", "LeftButton")
    W.settle(asyncIdle, 30)
    expect(db.uiScale == 1.5, "the slider saved "..tostring(db.uiScale))
    expect(near(rootScale(), 768 / 1440 * 1.5), "root scale is "..rootScale().." at MDT scale 150%")
    expect(slider.kitValueText:GetText() == "150%", "the slider shows "..tostring(slider.kitValueText:GetText()))
    expectOnScreen("at MDT scale 150%")
  end)

  step("scale: at MDT scale 200% the window fits the screen, maximized and normal", function()
    local db, f = MDT:GetDB(), MDT.main_frame
    local slider = scaleSlider()
    click(f.maximizeButton)
    expect(db.maximized, "setup: the window did not maximize")
    dragAndRelease(slider, 2)
    expect(near(rootScale(), 768 / 1440 * 2), "root scale is "..rootScale().." at MDT scale 200%")
    expectOnScreen("maximized at MDT scale 200%")
    local left, right, bottom, top = windowRect()
    expect(math.abs(right - left - W.screenWidth) < 0.5 or math.abs(top - bottom - W.screenHeight) < 0.5,
      ("the maximized window does not fill the screen: %.1fx%.1f of %.1fx%.1f"):format(right - left, top - bottom, W.screenWidth, W.screenHeight))
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
    W.settle(asyncIdle, 30)
    expect(not db.maximized and not f.blackoutFrame:IsShown(), "the window is still maximized")
    local point, relativeTo, relativePoint, x, y = f:GetPoint()
    expect(point == "TOP" and relativeTo == MDT.UI.Root and relativePoint == "TOP" and x == defaults.xoffset and y == defaults.yoffset,
      ("the window is at %s %s %s %s"):format(point, relativePoint, x, y))
    expect(math.abs(f:GetWidth() - 840 * defaults.nonFullscreenScale) < 0.01, "the window is "..f:GetWidth().." wide")
    expect(db.uiScale == 1 and near(rootScale(), 768 / 1440), ("MDT scale is %s, root scale %s"):format(db.uiScale, rootScale()))
    expect(slider.kitValueText:GetText() == "100%", "the slider shows "..tostring(slider.kitValueText:GetText()))
    expectOnScreen("after /mdt reset")
    click(f.navigationSidebar.buttons.maps)
  end)
end
