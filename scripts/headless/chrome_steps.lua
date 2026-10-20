-- Harness steps for the main window chrome on the kit: the season and floor dropdowns, the drawing toolbar
-- and the map note editor. Driven through real frames. Not shipped code.
return function(ctx)
  local W, MDT, step, expect, click, asyncIdle = ctx.W, ctx.MDT, ctx.step, ctx.expect, ctx.click, ctx.asyncIdle
  local UI = MDT.UI

  step("kit edit box: justify aligns the text and onWheel takes the wheel instead of scrolling", function()
    local host = CreateFrame("Frame", nil, UIParent)
    host:SetSize(120, 60)
    host:SetPoint("CENTER")
    local wheel = {}
    local edit = UI.EditBox(host, { width = 40, value = "3", justify = "CENTER", onWheel = function(delta) wheel[#wheel + 1] = delta end })
    edit:SetPoint("TOPLEFT")
    expect(edit.kitEdit:GetJustifyH() == "CENTER", "justify did not reach the edit box: "..edit.kitEdit:GetJustifyH())
    W.fireScript(edit.kitScroll, "OnMouseWheel", 1)
    W.fireScript(edit.kitScroll, "OnMouseWheel", -1)
    expect(table.concat(wheel, ",") == "1,-1", "onWheel got "..table.concat(wheel, ","))
    expect(edit.kitScroll:GetVerticalScroll() == 0, "the wheel scrolled the text although onWheel took it")
    edit:Release()
    local fresh = UI.EditBox(host, {})
    expect(fresh.kitEdit:GetJustifyH() == "LEFT" and fresh.kitProps.onWheel == nil, "a pooled edit box kept justify or onWheel")
    fresh:Release()
    host:Hide()
  end)
end
