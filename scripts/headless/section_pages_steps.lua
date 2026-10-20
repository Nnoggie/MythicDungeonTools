-- Harness steps for the settings-style navigation sections: Settings, Combat Logging and Focus Marker.
-- Driven through real frames. Not shipped code.
return function(ctx)
  local W, MDT, step, expect, click = ctx.W, ctx.MDT, ctx.step, ctx.expect, ctx.click
  local UI = MDT.UI

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
end
