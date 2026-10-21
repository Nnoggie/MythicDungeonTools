-- Harness steps for MDT's screen-relative scale: the window stays on screen as the Root's size changes.
return function(ctx)
  local W, MDT, step, expect = ctx.W, ctx.MDT, ctx.step, ctx.expect

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

  return { expectOnScreen = expectOnScreen }
end
