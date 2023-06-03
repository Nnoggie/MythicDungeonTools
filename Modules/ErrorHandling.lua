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

  for _, errorText in ipairs(caughtErrors) do
    errorBoxText = errorBoxText..errorText.."\n"
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
  MDT.errorFrame.errorBox:SetText(errorBoxText)

  MDT.errorFrame:Show()
end

local numError = 0
local currentFunc = ""
local function onError(s)
  numError = numError + 1
  local e = currentFunc..": "..s
  -- return early on duplicate errors
  for _,errorText in pairs(caughtErrors) do
    if errorText == e then
      return false
    end
  end
  tinsert(caughtErrors,e)
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
  local functionsToHandle = {
    "DeleteAllPresets",
    "LiveSession_RequestSession",
    "GetDungeonSublevels",
    "DungeonEnemies_UpdateSeasonalAffix",
    "HideInterface",
    "GetBlip",
    "RestoreScrollframeScripts",
    "RegisterModule",
    "ADDON_LOADED",
    "UpdateDungeonEnemies",
    "IsFrameOffScreen",
    "IsCurrentPresetTyrannical",
    "POI_CreateFramePools",
    "CreateDevPanel",
    "StartEraserDrawing",
    "SetLivePreset",
    "GetDungeonName",
    "LiveSession_SendPreset",
    "UpdateEnemyInfoData",
    "CopyPullOptions",
    "CleanEnemyData",
    "GetHighestFrameLevelAtCursor",
    "DisplayBlipTooltip",
    "StringToTable",
    "SkinProgressBar",
    "MakeRenameFrame",
    "DungeonEnemies_UpdateBoralusFaction",
    "initToolbar",
    "POI_UpdateAll",
    "OpenCustomColorsDialog",
    "LiveSession_SendCommand",
    "MakeCustomColorFrame",
    "UpdatePresetDropDown",
    "RegisterErrorHandledFunctions",
    "HSVtoRGB",
    "RequestDataCollectionUpdate",
    "GetSeasonList",
    "DungeonEnemies_GetPullColor",
    "GetEfficiencyScoreString",
    "ResetDataCache",
    "SetThrottleValues",
    "EnableBrushPreview",
    "GetCurrentSubLevel",
    "RenamePreset",
    "ZoomMapToDefault",
    "LiveSession_NotifyEnabled",
    "AddCloneFromData",
    "RGBToHex",
    "Progressbar_SetValue",
    "ClearPullButtonPicks",
    "EnsureDBTables",
    "UpdatePresetDropdownTextColor",
    "ZoomMap",
    "CheckCurrentZone",
    "MovePullDown",
    "CreateBrushPreview",
    "LiveSession_SendAffixWeek",
    "CopyObject",
    "DrawPresetObject",
    "ReverseCalcEnemyHealth",
    "ExportNPCIdsWithoutDisplayIds",
    "GetPatrolBlips",
    "SetAutomaticColor",
    "UpdatePullButtonColor",
    "DungeonEnemies_UpdateEnemies",
    "DrawLine",
    "GetDefaultMapPanelSize",
    "GetScrollingAmount",
    "DungeonEnemies_AddOrRemoveBlipToCurrentPull",
    "OnPan",
    "GetSelection",
    "Show_DropIndicator",
    "ReturnToLivePreset",
    "OnMouseUp",
    "PresetsAddPull",
    "MouseDownHook",
    "HideAnimatedLine",
    "SetMapSublevel",
    "PrintCurrentAffixes",
    "LiveSession_SendBoralusSelector",
    "GetLocaleIndex",
    "LiveSession_SendPing",
    "GetCurrentPreset",
    "GetCurrentDevmodeBlip",
    "DungeonEnemies_CreateFramePools",
    "ToggleToolbarTooltip",
    "GetSchema",
    "AddCloneAtCursorPosition",
    "UpdateBoralusSelector",
    "HideAllDialogs",
    "OpenConfirmationFrame",
    "PLAYER_ENTERING_WORLD",
    "OpenClearPresetDialog",
    "PresetsDeletePull",
    "GetDB",
    "OpenSettingsDialog",
    "MakeSidePanel",
    "Minimize",
    "GROUP_ROSTER_UPDATE",
    "GetEffectivePresetWeek",
    "OpenChatImportPresetDialog",
    "GetEnemyInfoSpellBlacklist",
    "FindConnectedDoor",
    "POI_CreateDropDown",
    "StopLineDrawing",
    "FormatEnemyForces",
    "MakeTopBottomTextures",
    "CreateCoroutineHandler",
    "GetEnemyForces",
    "PresetObjectStepBack",
    "LiveSession_SendUpdatedObjects",
    "CreateTutorialButton",
    "CreateDungeonSelectDropdown",
    "LiveSession_SendObjectOffsets",
    "UpdateAffixWeeks",
    "POI_GetPOIAssignment",
    "MakePresetCreationFrame",
    "DungeonEnemies_UpdateInfested",
    "ReleaseAllActiveTextures",
    "ColorPull",
    "POI_HideAllPoints",
    "IsPresetTeeming",
    "DungeonEnemies_UpdateReaping",
    "GetCurrentAffixWeek",
    "AddNPCFromUnit",
    "ReleaseHullFontStrings",
    "PresetObjectStepForward",
    "CountPresets",
    "UpdateProgressbar",
    "DungeonEnemies_HideAllBlips",
    "MakePullSelectionButtons",
    "StorePresetObject",
    "StopEraserDrawing",
    "TableToString",
    "GetPullButton",
    "ShowEnemyInfoFrame",
    "UpdatePullTooltip",
    "POI_SetPOIAssignment",
    "StartNoteDrawing",
    "GetEffectivePresetSeason",
    "SkinMenuButtons",
    "FindPullOfBlip",
    "POI_GetFrameForPOI",
    "GetDungeonEnemyBlips",
    "DoFramesOverlap",
    "ActivatePullTooltip",
    "IsDragonflight",
    "SetPresetColorPaletteInfo",
    "FormatEnemyHealth",
    "StartMovingObject",
    "Hide_DropIndicator",
    "CheckAddonConflicts",
    "StartPencilDrawing",
    "ShowConflictFrame",
    "IsCloneInPulls",
    "LiveSession_SendCorruptedPositions",
    "UpdateEnemyInfoFrame",
    "MakeExportFrame",
    "TestExport",
    "StartLineDrawing",
    "DeletePresetObjects",
    "ReleaseHullTextures",
    "GetNumDungeons",
    "OnPanFadeOut",
    "ValidateImportPreset",
    "IsCurrentPresetThundering",
    "ToggleBoralusSelector",
    "CreateMenu",
    "GetRiftOffsets",
    "ExportLuaTable",
    "IsWrath",
    "MakeSettingsFrame",
    "CleanEnemyInfoSpells",
    "MakeClearConfirmationFrame",
    "DeepCopy",
    "IsShown_DropIndicator",
    "AddPatrolWaypointAtCursorPosition",
    "ToggleDevMode",
    "StartArrowDrawing",
    "UpdateDungeonDropDown",
    "LiveSession_SendObject",
    "LiveSession_SendPulls",
    "IsWeekTeeming",
    "UpdatePresetObjectOffsets",
    "Maximize",
    "DrawHullCircle",
    "LiveSession_SendPOIAssignment",
    "GetPulls",
    "PickPullButton",
    "GetFullScreenSizes",
    "ScrollToNextDungeon",
    "LiveSession_SendNoteCommand",
    "FixDungeonDropDownList",
    "LiveSession_RequestPreset",
    "CalculateEnemyHealth",
    "UpdatePullButtonNPCData",
    "IsOnBetaServer",
    "LiveSession_SessionFound",
    "DeletePreset",
    "IsPlayerInGroup",
    "GetPresetColorPaletteInfo",
    "LiveSession_SendDifficulty",
    "IsCurrentPresetTeeming",
    "LiveSession_Enable",
    "GetSublevelName",
    "MakeChatPresetImportFrame",
    "SendToGroup",
    "SetUniqueID",
    "MakeDeleteConfirmationFrame",
    "MakeSendingStatusBar",
    "DrawNote",
    "IsNPCInPulls",
    "SanitizePresetName",
    "DrawTriangle",
    "DrawCircle",
    "DisableBrushPreview",
    "GetHighestPresetObjectIndexAtCursor",
    "UpdateAutomaticColors",
    "GetCurrentPull",
    "StopMovingObject",
    "GetCurrentLivePreset",
    "HideAllPresetObjects",
    "GetTileFormat",
    "IsWeekInspiring",
    "PingMap",
    "LiveSession_Disable",
    "StopPencilDrawing",
    "DungeonEnemies_SetPullColor",
    "SetCurrentSubLevel",
    "ReloadPullButtons",
    "DrawAllPresetObjects",
    "StopArrowDrawing",
    "DisplayErrors",
    "DungeonEnemies_UpdateInspiring",
    "FixAceGUIShowHide",
    "SetPingOffsets",
    "LiveSession_QueueColorUpdate",
    "DrawHullFontString",
    "GetCursorPosition",
    "ExportCurrentZoomPanSettings",
    "DungeonEnemies_UpdateTeeming",
    "OverrideScrollframeScripts",
    "UpdateSelectedToolbarTool",
    "DropIndicator",
    "ScrollToPull",
    "ColorAllPulls",
    "ShowMinimapButton",
    "PresetsSwapPulls",
    "FindClosestPull",
    "DrawAllAnimatedLines",
    "KillAllAnimatedLines",
    "HexToRGB",
    "ShowAnimatedLine",
    "StartScaling",
    "GetEnemyInfoEnemyIdx",
    "DrawHull",
    "DrawHullLine",
    "IsCloneIncluded",
    "MakePresetImportFrame",
    "HideMinimapButton",
    "DungeonEnemies_IsAnyBlipMoving",
    "UpdateDungeonData",
    "GetNPCNameById",
    "GetScale",
    "ToggleDataCollection",
    "SetSelectionToPull",
    "OpenNewPresetDialog",
    "ResetMainFramePos",
    "OnMouseDown",
    "CountForces",
    "OpenImportPresetDialog",
    "IsCurrentPresetFortified",
    "GetPullsNum",
    "SetScale",
    "GetFirstNotSelectedPullButton",
    "DungeonEnemies_UpdateBlipColors",
    "GetPresetSize",
    "ClearPreset",
    "UpdateBottomText",
    "HardReset",
    "CreateNewPreset",
    "MakeMapTexture",
    "Round",
    "SetViewPortPosition",
    "SumCurrentPullHealth",
    "PresetsMergePulls",
    "ImportPreset",
  }
  for _,funcName in pairs(functionsToHandle) do
    local func = MDT[funcName]
    MDT[funcName] = function(...)
      currentFunc = funcName
      return select(2,xpcall(func, onError , ...))
    end
  end
end
