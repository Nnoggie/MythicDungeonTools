-- Harness steps for MDT's screen-relative scale: the window stays on screen as the Root's size changes.
return function(ctx)
  local W, MDT, step, expect, click, asyncIdle = ctx.W, ctx.MDT, ctx.step, ctx.expect, ctx.click, ctx.asyncIdle
  local defaults = MDT:GetDefaultSavedVariables().global

  ---The visible window (sidebar, map, side panel and both bars) lies within the screen.
  local function expectOnScreen(when)
    local f = MDT.main_frame
    local left = f.navigationSidebar:GetScaledRect()
    local sideLeft, _, sideWidth = f.sidePanel:GetScaledRect()
    local _, top, _, topHeight = f.topPanel:GetScaledRect()
    local _, bottom = f.bottomPanel:GetScaledRect()
    local right = sideLeft + sideWidth
    top = top + topHeight
    local slack = 0.01
    expect(left >= -slack and right <= W.screenWidth + slack and bottom >= -slack and top <= W.screenHeight + slack,
      ("window spans x %.1f..%.1f, y %.1f..%.1f on a %.1fx%.1f screen %s"):format(left, right, bottom, top, W.screenWidth, W.screenHeight, when))
  end

  step("scale: a window saved by 6.3.10 on a 4K screen fits the screen after load", function()
    local db = MDT:GetDB()
    local _, _, fullscreenScale = MDT:GetFullScreenSizes()
    expect(db.nonFullscreenScale <= fullscreenScale + 1e-9, ("window scale %s is above the fullscreen scale %s"):format(db.nonFullscreenScale, fullscreenScale))
    if ctx.seeded then expect(db.nonFullscreenScale < ctx.seeded.nonFullscreenScale, "the oversized window was not scaled down") end
    expectOnScreen("after load")
  end)

  step("scale: /mdt reset leaves fullscreen and restores the default position and window size", function()
    local db, f = MDT:GetDB(), MDT.main_frame
    click(f.maximizeButton)
    expect(db.maximized, "setup: the window did not maximize")
    W.RunSlashCommand("/mdt reset")
    W.settle(asyncIdle, 30)
    expect(not db.maximized and not f.blackoutFrame:IsShown(), "the window is still maximized")
    local point, relativeTo, relativePoint, x, y = f:GetPoint()
    expect(point == "TOP" and relativeTo == MDT.UI.Root and relativePoint == "TOP" and x == defaults.xoffset and y == defaults.yoffset,
      ("the window is at %s %s %s %s"):format(point, relativePoint, x, y))
    expect(math.abs(f:GetWidth() - 840 * defaults.nonFullscreenScale) < 0.01, "the window is "..f:GetWidth().." wide")
    expectOnScreen("after /mdt reset")
  end)

  return { expectOnScreen = expectOnScreen }
end
