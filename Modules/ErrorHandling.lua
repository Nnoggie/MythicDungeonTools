local AddonName, MDT = ...
local AceGUI = LibStub("AceGUI-3.0")
local L = MDT.L
local tinsert, slen = table.insert, string.len

-- handle most mdt errors internally and provide an easy way for users to report these errors

local caughtErrors = {}
local DESTINATIONS = {
  {name = "GitHub", url = "https://github.com/Nnoggie/MythicDungeonTools/issues"},
  {name = "Discord", url = "https://discord.gg/tdxMPb3"},
}

function MDT:DisplayErrors()
  if #caughtErrors == 0 then return end
  if MDT.initSpinner then
    MDT.initSpinner:Hide()
    MDT.initSpinner.Anim:Stop()
  end

  local function startCopyAction(editBox,copyButton,text)
      editBox:HighlightText(0, slen(text))
      editBox:SetFocus()
      copyButton:SetDisabled(true)
      MDT.errorFrame.copyHelperLabel.label:Show()
  end

  local function stopCopyAction(copyButton)
    copyButton:SetDisabled(false)
    MDT.errorFrame.copyHelperLabel.label:Hide()
  end

  local errorBoxText = ""

  if not MDT.errorFrame then
    MDT.errorFrame = AceGUI:Create("Frame")
    _G["MDTErrorFrame"] = MDT.errorFrame.frame
    tinsert(UISpecialFrames, "MDTErrorFrame")
    local errorFrame = MDT.errorFrame
    errorFrame:EnableResize(false)
    errorFrame:SetWidth(800)
    errorFrame:SetHeight(600)
    errorFrame:EnableResize(false)
    errorFrame:SetLayout("Flow")
    errorFrame:SetCallback("OnClose", function(widget) end)
    errorFrame:SetTitle(L["MDT Error"])
    errorFrame.label = AceGUI:Create("Label")
    errorFrame.label:SetWidth(800)
    errorFrame.label:SetFontObject("GameFontNormalLarge")
    errorFrame.label.label:SetTextColor(1,0,0)
    errorFrame.label:SetText(L["errorLabel1"].."\n"..L["errorLabel2"])
    errorFrame:AddChild(errorFrame.label)

    for _,dest in ipairs(DESTINATIONS) do
      errorFrame[dest.name.."EditBox"] = AceGUI:Create("EditBox")
      local editBox = errorFrame[dest.name.."EditBox"]
      local copyButton
      editBox:SetLabel(dest.name..":")
      editBox:DisableButton(true)
      editBox:SetText(dest.url)
      editBox:SetCallback("OnTextChanged",function()
        editBox:SetText(dest.url)
      end)

      editBox:SetWidth(400)
      editBox.frame.obj.editbox:HookScript('OnEditFocusLost', function()
        stopCopyAction(copyButton)
      end);
      editBox.frame.obj.editbox:SetScript('OnKeyUp', function(_, key)
          --dont interfere with user manually ctrl+a selecting
          if (IsControlKeyDown() and (key == 'A')) or key == "LCTRL" then
              return
          end
          editBox:ClearFocus();
      end);
      errorFrame[dest.name.."CopyButton"] = AceGUI:Create("Button")
      copyButton = errorFrame[dest.name.."CopyButton"]
      copyButton:SetText(L["Copy"])
      copyButton:SetWidth(100)
      copyButton:SetCallback("OnClick", function(widget, callbackName, value)
        startCopyAction(editBox,copyButton,dest.url)
      end)
      errorFrame:AddChild(editBox)
      errorFrame:AddChild(copyButton)
    end

    local errorBox, errorBoxCopyButton
    errorFrame.errorBox = AceGUI:Create("MultiLineEditBox")
    errorBox = errorFrame.errorBox
    errorBox:SetWidth(800)
    errorBox:SetLabel(L["Error Message:"])
    errorBox:DisableButton(true)
    errorBox:SetNumLines(20)
    errorBox:SetCallback("OnTextChanged",function()
      errorBox:SetText(errorBoxText)
    end)
    errorBox.editBox:HookScript('OnEditFocusLost', function()
      stopCopyAction(errorBoxCopyButton)
    end);
    errorBox.editBox:SetScript('OnKeyUp', function(_, key)
        --dont interfere with user manually ctrl+a selecting
        if (IsControlKeyDown() and (key == 'A')) or key == "LCTRL" then
            return
        end
        errorBox:ClearFocus();
    end);

    errorFrame.errorBoxCopyButton = AceGUI:Create("Button")
    errorBoxCopyButton = errorFrame.errorBoxCopyButton
    errorBoxCopyButton:SetText(L["Copy error"])
    errorBoxCopyButton:SetHeight(40)
    errorBoxCopyButton:SetCallback("OnClick", function(widget, callbackName, value)
      startCopyAction(errorFrame.errorBox,errorBoxCopyButton,errorBoxText)
    end)

    errorFrame:AddChild(errorFrame.errorBox)
    errorFrame:AddChild(errorFrame.errorBoxCopyButton)

    errorFrame.copyHelperLabel = AceGUI:Create("Label")
    errorFrame.copyHelperLabel:SetFontObject("GameFontNormalLarge")
    errorFrame.copyHelperLabel.label:SetTextColor(1,1,0)
    errorFrame.copyHelperLabel:SetText(L["errorLabel3"])
    errorFrame.copyHelperLabel.label:Hide()
    errorFrame:AddChild(errorFrame.copyHelperLabel)
  end

  for _, error in ipairs(caughtErrors) do
    errorBoxText = errorBoxText..error.message.."\n"
  end
  --add diagnostics
  local presetExport = MDT:TableToString(MDT:GetCurrentPreset(), true, 5)
  local addonVersion = GetAddOnMetadata(AddonName, "Version")
  local locale = GetLocale()
  local dateString = date("%d/%m/%y %H:%M:%S")
  local gameVersion = select(4, GetBuildInfo())
  local name,realm = UnitFullName("player")
  local regionId = GetCurrentRegion()
  local regions = {
      [1] = "US",
      [2] = "Korea",
      [3] = "Europe",
      [4] = "Taiwan",
      [5] = "China",
  }
  local region = regions[regionId]
  errorBoxText = errorBoxText .."\n"..dateString.."\nMDT: "..addonVersion.."\nClient: "..gameVersion.." "..locale.."\nCharacter: "..name.."-"..realm.." ("..region..")".."\n\nRoute:\n"..presetExport
  errorBoxText = errorBoxText .."\n\nStacktraces\n\n"
  for _, error in ipairs(caughtErrors) do
    errorBoxText = errorBoxText..error.stackTrace.."\n"
  end

  MDT.errorFrame.errorBox:SetText(errorBoxText)
  MDT.errorFrame:Show()
end

local numError = 0
local currentFunc = ""
local addTrace = false
local function onError(s)
  numError = numError + 1
  local e = currentFunc..": "..s
  -- return early on duplicate errors
  for _,error in pairs(caughtErrors) do
    if error.message == e then
      addTrace = false
      return false
    end
  end
  tinsert(caughtErrors,{message = e})
  addTrace = true
  if MDT.errorTimer then MDT.errorTimer:Cancel() end
  MDT.errorTimer  = C_Timer.NewTimer(0.5, function()
    MDT:DisplayErrors()
  end)
  --if spam erroring then show errors early otherwise risk error display never showing
  if numError>100 then
    MDT:DisplayErrors()
  end
  return false
end

function MDT:RegisterErrorHandledFunctions()
  --register all functions except the ones that have to run as coroutines
  local blacklisted = {
    ["DungeonEnemies_UpdateSelected"] = true,
    ["AddPull"] = true,
    ["ClearPull"] = true,
    ["ShowInterfaceInternal"] = true,
    ["UpdateToDungeon"] = true,
    ["UpdateMap"] = true,
    ["MovePullUp"] = true,
    ["ShowInterface"] = true,
    ["DeletePull"] = true,
    ["ExportDungeonDataIncrementally"] = true,
    ["DrawAllHulls"] = true,
    ["ExportString"] = true,
    ["Async"] = true,
  }
  for funcName,func in pairs(MDT) do
    if type(func) == "function" and not blacklisted[funcName] then
      MDT[funcName] = function(...)
        currentFunc = funcName
        local results = {xpcall(func, onError , ...)}
        local ok = select(1,unpack(results))
        if not ok and addTrace then
          --add stackTrace to the latest error
          caughtErrors[#caughtErrors].stackTrace = currentFunc.. ":\n"..debugstack()
        end
        return select(2,unpack(results))
      end
    end
  end
end
