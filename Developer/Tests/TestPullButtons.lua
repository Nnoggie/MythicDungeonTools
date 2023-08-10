local addonName, addon = ...

local importString =
"!Tv1YUTnmqWFjts9IxttpKEqna0OhjGSfzQAvLkSPsD)77YDLOwQuKadR9XmZolfTvypBn9dE)W1LXWFTTItwZFCUFABvwtxF)803C3UpmpzBlovilTMLHER5PV)Lp)qkgF0pAnV3nU4IaDD52n3u41LXraPYuaZYLr37oiO0AUn4dF17V7c3HEaAoBdWFB1(8Y0BU5Px6FamQTMGZ9RHP3SxSM7Ur31qulqFcKbOVFdSDNIScxmxbKcyJEqH4ppoFZA8ELZ7zzpuFytsqikLK1DSxTBROu3LXQARoGrmtfMPKJ3r1OCSSuj1C1xSdHkLpgQjgOvZXUitR61jTKJTM1lST5AXFb0scRsCVataRzbjgrf1EnQoCpKKBdxOcfvFbxKaRyqbbIIa5Ont2sDg7sQrfNV6m(eufYdEmTZASNZOaCNKOiBPgLudn56yQQ0wlMVGPjgzS5qQWJdrhQICi4Frd64YtepBEWQjilwhTYvdRYsgDn6T43J4jBiafAcrY3By(((iRXvPonC4abKYMOTJMrXxZrAD)O3BjgmB9GVdLGVIDKcrsiyDT)C8ZaoJuwj(ujRwIVDM6e4bHOfSTgiaPTVkB5iYG74rGOGtWqLwLEQL2HkQTDnMDDscAL9d3iSdTC)GsIGIvqlYaTmduQJM0tKK(Wvf7eT((5ka7x4WHz7nM8TNMmd9)1miyXRKdUhWNp78DWpoynZx(bC)7D2c61Urxi4EzYpdrnDlH5pfJhVW(Pd1GxOJ4A)3"

local function setup()
  local frame = MDT.main_frame
  frame.sidePanelImportButton.frame:Click()
  C_Timer.After(0.3, function()
    frame.presetImportBox:SetText(importString)
    frame.presetImportBox:HighlightText()
    frame.presetImportBox.OnTextChanged(nil, nil, importString)
    C_Timer.After(0.3, function()
      frame.presetImportButton.frame:Click()
    end)
  end)
end

local function teardown()
  local frame = MDT.main_frame
  local deleteButton = frame.sidePanelDeleteButton.frame
  local okayButton = frame.DeleteConfirmationFrame.OkayButton.frame
  deleteButton:Click()
  C_Timer.After(0.5, function()
    okayButton:Click()
  end)
end

local function testFunc()
  local sidepanel = MDT.main_frame.sidePanel
  setup()
  C_Timer.After(1.5, function()
    local numPulls = MDT:GetPullsNum()
    for i = 1, numPulls do
      C_Timer.After(0.2 * i, function()
        local pullButton = sidepanel.newPullButtons[i].frame
        local onEnter = pullButton:GetScript("OnEnter")
        local onLeave = pullButton:GetScript("OnLeave")
        local onClick = pullButton:GetScript("OnClick")
        onEnter()
        C_Timer.After(0.2, function()
          onLeave()
          C_Timer.After(0.2, function()
            onClick(nil, "LeftButton", true)
          end)
        end)
      end)
    end
  end)

  C_Timer.After(7, function()
    teardown()
  end)
end

---@type MDTTest
local test = {
  name = "Pull Buttons",
  func = testFunc,
  duration = 8
}

tinsert(addon.test.testList, test)
