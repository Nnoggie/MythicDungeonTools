-- Harness steps for the size chooser MDT shows once, the first time it opens at MDT scale 100%.
return function(ctx)
  local W, MDT, step, expect, click, asyncIdle, render = ctx.W, ctx.MDT, ctx.step, ctx.expect, ctx.click, ctx.asyncIdle, ctx.render
  local UI = MDT.UI

  local function near(a, b, tolerance) return math.abs(a - b) < (tolerance or 1e-3) end
  local function settle() W.settle(asyncIdle, 30) end

  local function reopen()
    MDT:HideInterface()
    MDT:ShowInterface()
    settle()
    expect(MDT.main_frame:IsVisible(), "the main window did not open again")
  end

  ---Opens MDT as if for the first time at MDT scale 100%.
  local function firstOpen()
    local db = MDT:GetDB()
    UI.Dialogs.CloseAll("api")
    MDT:SetUserScale(1)
    settle()
    db.scaleChooserShown = false
    reopen()
    local dialog = UI.Dialogs.Get("scaleChooser")
    expect(dialog and dialog:IsVisible(), "the size chooser did not open on the first open at 100%")
    return dialog
  end

  local function selected(dialog)
    local picked = {}
    for index = 1, 4 do
      if dialog.content:Find("size"..index).kitProps.selected then picked[#picked + 1] = index end
    end
    return table.concat(picked, ",")
  end

  ---The frame's width and center on screen.
  local function onScreen(frame)
    local scale = frame:GetEffectiveScale()
    local x, y = frame:GetCenter()
    return frame:GetWidth() * scale, x * scale, y * scale
  end

  local function expectOnMapCenter(dialog, when)
    local _, x, y = onScreen(dialog)
    local _, mapX, mapY = onScreen(MDT.main_frame)
    expect(near(x, mapX, 0.01) and near(y, mapY, 0.01),
      ("the chooser is not on the map's center %s: %.1f,%.1f vs %.1f,%.1f"):format(when, x, y, mapX, mapY))
  end

  step("scale chooser: not shown when the MDT scale was already set, and never later", function()
    local db = MDT:GetDB()
    if ctx.seeded then
      expect(ctx.seeded.uiScale ~= 1, "setup: the seeded MDT scale is 100%")
      expect(db.scaleChooserShown == true, "opening at a set MDT scale did not mark the size chooser as shown")
      expect(UI.Dialogs.Get("scaleChooser") == nil, "the size chooser opened although the MDT scale was set")
    end
    -- Booted with other saved variables, MDT may have opened at 100% and shown the chooser.
    UI.Dialogs.CloseAll("api")
    db.scaleChooserShown = false
    MDT:SetUserScale(1.5)
    settle()
    reopen()
    expect(UI.Dialogs.Get("scaleChooser") == nil, "the size chooser opened at MDT scale 150%")
    expect(db.scaleChooserShown == true, "skipping the size chooser did not mark it as shown")
    MDT:SetUserScale(1)
    settle()
    reopen()
    expect(UI.Dialogs.Get("scaleChooser") == nil, "the size chooser opened after it was skipped")
  end)

  step("scale chooser: it sits on the map and moves with it; a size rescales MDT, not the chooser; Done keeps it", function()
    local db = MDT:GetDB()
    local before = db.uiScale
    local dialog = firstOpen()
    expect(selected(dialog) == "2", "the default size is not the only preselected one: "..selected(dialog))
    render("scale chooser", MDT.main_frame, { dialog })
    expectOnMapCenter(dialog, "when it opens")
    local width = onScreen(dialog)
    click(dialog.content:Find("size3"))
    settle()
    expect(db.uiScale == 1.2, "picking 120% set MDT scale "..tostring(db.uiScale))
    expect(near(MDT.UI.Root:GetEffectiveScale(), 768 / 1440 * 1.2, 1e-6), "the Root did not rescale to 120%")
    expect(selected(dialog) == "3", "after picking 120% the selected sizes are "..selected(dialog))
    expect(near(width, onScreen(dialog), 0.01), ("the chooser was %.1f wide on screen and became %.1f"):format(width, onScreen(dialog)))
    expectOnMapCenter(dialog, "after a rescale")
    local _, x = onScreen(dialog)
    db.xoffset = db.xoffset - 40
    MDT:PlaceNormalWindow()
    expect(not near(x, select(2, onScreen(dialog)), 1), "the chooser stayed put while the window moved")
    expectOnMapCenter(dialog, "after the window moved")
    click(dialog.content:Find("done"))
    expect(UI.Dialogs.Get("scaleChooser") == nil, "Done did not close the size chooser")
    expect(db.scaleChooserShown == true, "closing the size chooser did not mark it as shown")
    expect(db.uiScale == 1.2, "Done did not keep the picked size: "..tostring(db.uiScale))
    expect(dialog:GetScale() == 1, "the pooled dialog frame kept the chooser's scale")
    reopen()
    expect(UI.Dialogs.Get("scaleChooser") == nil, "the size chooser opened a second time")
    MDT:SetUserScale(before)
    settle()
  end)

  step("scale chooser: closing it with the X keeps the size shown", function()
    local db = MDT:GetDB()
    local before = db.uiScale
    local dialog = firstOpen()
    click(dialog.content:Find("size1"))
    settle()
    click(dialog.closeButton)
    expect(UI.Dialogs.Get("scaleChooser") == nil, "the X did not close the size chooser")
    expect(db.uiScale == 0.85 and db.scaleChooserShown == true,
      ("after the X: MDT scale %s, shown %s"):format(tostring(db.uiScale), tostring(db.scaleChooserShown)))
    MDT:SetUserScale(before)
    settle()
  end)
end
