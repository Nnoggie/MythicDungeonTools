-- Harness steps for the dialogs group: route dialogs, confirmations, the error report, external links and the
-- version check, plus the kit pieces they added. Driven through real frames. Not shipped code.
return function(ctx)
  local W, MDT, step, expect, click, render = ctx.W, ctx.MDT, ctx.step, ctx.expect, ctx.click, ctx.render
  local UI = MDT.UI

  step("kit: a prompt places build controls under its field and names its footer buttons", function()
    local picked
    local dialog = UI.Dialogs.Prompt({ key = "kitPromptBuild", title = "Build", value = "Name",
      build = function(content) UI.Dropdown(content, { id = "extra", items = { { kind = "choice", text = "A", value = 1 } }, value = 1 }) end,
      confirm = { text = "Ok", onClick = function(text) picked = text end } })
    local input, extra = dialog.content:Find("input"), dialog.content:Find("extra")
    expect(input and extra and dialog.content:Find("confirm") and dialog.content:Find("cancel"), "prompt controls are not findable by id")
    expect(dialog.content:Find("alt") == nil, "a prompt without alt has an alt button")
    expect(select(2, input:GetCenter()) > select(2, extra:GetCenter()), "build control is not under the field")
    expect(select(2, extra:GetCenter()) > select(2, dialog.content:Find("confirm"):GetCenter()), "build control is not above the buttons")
    click(dialog.content:Find("confirm"))
    expect(picked == "Name" and UI.Dialogs.Get("kitPromptBuild") == nil, "confirm did not report the field value")
  end)

  step("kit: onPaste collects a burst outside the field and delivers it on the next frame", function()
    local pasted
    local dialog = UI.Dialogs.Open({ key = "kitPaste", title = "Paste", build = function(content)
      UI.EditBox(content, { id = "box", onPaste = function(text, box)
        pasted = text
        box:SetValue(text:sub(1, 4))
      end })
    end })
    local box = dialog.content:Find("box")
    click(box.kitField)
    local long = string.rep("abcdefghij", 300)
    expect(W.userType(box.kitEdit, long), "the paste box did not take focus")
    expect(#box.kitEdit:GetText() == 1, "the field took "..#box.kitEdit:GetText().." bytes during the burst")
    expect(pasted == nil, "onPaste fired before the burst ended")
    W.pump(0.05)
    expect(pasted == long, "onPaste delivered "..tostring(pasted and #pasted).." characters")
    expect(box:GetValue() == "abcd" and box.kitEdit:GetMaxBytes() == 0, "the field did not return to normal after the paste")
    dialog:Close("api")
  end)
end
