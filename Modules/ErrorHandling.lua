local _, MDT = ...
local L = MDT.L
local UI = MDT.UI
local tinsert = table.insert

-- handle most mdt errors internally and provide an easy way for users to report these errors

local caughtErrors = {}

function MDT:GetLockdownState()
  -- Same order as MethodInternalAdmin's effective addon restrictions.
  local states = {}
  local unavailable = false
  for _, name in ipairs({ "Map", "Chat", "Combat", "Encounter", "ChallengeMode", "PvPMatch" }) do
    local restriction = Enum.AddOnRestrictionType and Enum.AddOnRestrictionType[name]
    local ok, active = false, nil
    if restriction and C_RestrictedActions and C_RestrictedActions.IsAddOnRestrictionActive then
      ok, active = pcall(C_RestrictedActions.IsAddOnRestrictionActive, restriction)
    end
    if not ok then
      unavailable = true
    elseif active then
      states[#states + 1] = name
    end
  end
  if unavailable then states[#states + 1] = "Some states unavailable" end
  return #states > 0 and table.concat(states, ", ") or "None"
end

local function getDiagnostics(omitRoute)
  local presetExport
  if not omitRoute then
    local exportOK
    exportOK, presetExport = pcall(function() return MDT:TableToString(MDT:GetCurrentPreset()) end)
    if not exportOK or type(presetExport) ~= "string" then presetExport = "Unavailable: "..tostring(presetExport) end
  end
  ---@diagnostic disable-next-line: redundant-parameter
  local addonVersion = C_AddOns.GetAddOnMetadata(MDT.AddonName, "Version")
  local locale = GetLocale()
  local dateString = date("%d/%m/%y %H:%M:%S")
  local gameVersion = select(4, GetBuildInfo())
  local name, realm = UnitFullName("player")
  local regionId = GetCurrentRegion()
  local regions = {
    [1] = "US",
    [2] = "Korea",
    [3] = "Europe",
    [4] = "Taiwan",
    [5] = "China",
    [72] = "PTR",
    [90] = "BETA",
  }
  local region = regions[regionId] or "UNKNOWN"
  local combatState = InCombatLockdown() and "In combat" or "Out of combat"
  local mapID = C_Map.GetBestMapForUnit("player");
  local mapInfo = mapID and C_Map.GetMapInfo(mapID)
  local parentInfo = mapInfo and C_Map.GetMapInfo(mapInfo.parentMapID)
  local zoneInfo = format("Zone: %s (%s)", parentInfo and parentInfo.name or mapInfo and mapInfo.name or "Unknown", tostring(mapID))
  return {
    presetExport = presetExport,
    addonVersion = addonVersion,
    locale = locale,
    dateString = dateString,
    gameVersion = gameVersion,
    name = name or "Unknown",
    realm = realm or "Unknown",
    region = region,
    combatState = combatState,
    zoneInfo = zoneInfo
  }
end

local hasShown = false
local errorButtonShown = false

---The main window while it is shown, else the UI root, so a report raised with the window closed is still visible.
local function visibleParent()
  local main = MDT.main_frame
  return main and main:IsShown() and main or MDT.UI.Root
end

local function buildErrorText()
  local text = ""
  local omitRoute = false
  for _, error in ipairs(caughtErrors) do
    text = text..error.count.."x: "..error.message.."\n"
    omitRoute = omitRoute or error.omitRoute
  end
  local diagnostics = getDiagnostics(omitRoute)
  text = text.."\n"..diagnostics.dateString.."\nMDT: "..diagnostics.addonVersion.."\nClient: "..diagnostics.gameVersion.." "..diagnostics.locale.."\nCharacter: "..diagnostics.name.."-"..diagnostics.realm.." ("..diagnostics.region..")"
  text = text.."\n"..diagnostics.combatState.."\nLockdowns: "..MDT:GetLockdownState().."\n"..diagnostics.zoneInfo.."\n"
  if diagnostics.presetExport then
    text = text.."\nRoute:\n"..diagnostics.presetExport
  end
  text = text.."\nStacktraces\n\n"
  for _, error in ipairs(caughtErrors) do
    text = text..error.stackTrace.."\n"
  end
  return text
end

function MDT:DisplayErrors(force)
  if not force and hasShown then return end
  hasShown = true
  if #caughtErrors == 0 then return end
  if MDT.initSpinner then
    MDT.initSpinner:Hide()
    MDT.initSpinner.Anim:Stop()
  end
  if not errorButtonShown then
    errorButtonShown = true
    MDT:RunAfterFramesInitialized(function() MDT:ShowErrorReportButton() end)
  end
  if not MDT.copyHelper then MDT:MakeCopyHelper(MDT.UI.Root) end
  local errorText = buildErrorText()
  MDT:CloseBottomLeftPanels()
  UI.Dialogs.Open({
    key = "errors", globalName = "MDTErrorFrame", title = L["MDT Error"], width = 800, parent = visibleParent(),
    onClose = function() MDT.copyHelper:SmartHide() end,
    build = function(content, dialog)
      UI.Text(content, { text = L["errorLabel1"].."\n"..L["errorLabel2"], font = "title", color = "warn" })
      for _, link in ipairs(MDT.externalLinks) do
        if not link.hideInErrorFrame then
          MDT:AddCopyableLinkRow(content, { label = link.name..":", url = link.url, anchor = dialog, width = 400 })
        end
      end
      local box, copyButton
      box = UI.EditBox(content, {
        id = "errorText", label = L["Error Message:"], value = errorText, multiline = true, lines = 20,
        readOnly = true, selectAllOnFocus = true,
        onFocusLost = function()
          copyButton:SetDisabled(false)
          MDT.copyHelper:SmartHide()
        end,
        onCopy = function()
          MDT.copyHelper:SmartFadeOut()
          box:ClearFocus()
        end,
      })
      local row = UI.Row(content, { gap = "sm" })
      copyButton = UI.Button(row, { id = "copyError", text = L["Copy error"], onClick = function()
        box:Focus()
        box:SelectAll()
        copyButton:SetDisabled(true)
        MDT.copyHelper:SmartShow(dialog, 0, 0)
      end })
      UI.Button(row, { id = "hardReset", text = L["hardResetButton"], variant = "danger", onClick = function()
        MDT:Async(function()
          UI.Dialogs.Confirm({
            key = "hardReset", width = 450, parent = visibleParent(), title = L["hardResetPromptTitle"], text = L["hardResetPrompt"],
            confirm = { text = L["Delete"], variant = "danger", onClick = function() MDT:HardReset() end },
          })
        end, "hardReset")
      end })
    end,
  })
end

local numError = 0
local currentFunc = ""
local addTrace = false
local function onError(msg, stackTrace, name, omitRoute)
  numError = numError + 1
  local funcName = name or currentFunc
  local e = funcName..": "..msg
  -- return early on duplicate errors
  for _, error in pairs(caughtErrors) do
    if error.message == e then
      error.count = error.count + 1
      error.omitRoute = error.omitRoute or omitRoute
      addTrace = false
      return false
    end
  end
  local stackTraceValue = stackTrace and name..":\n"..stackTrace
  tinsert(caughtErrors, { message = e, stackTrace = stackTraceValue, count = 1, omitRoute = omitRoute })
  addTrace = true
  if MDT.errorTimer then MDT.errorTimer:Cancel() end
  MDT.errorTimer = C_Timer.NewTimer(0.5, function()
    MDT:DisplayErrors(true)
  end)
  --if spam erroring then show errors early otherwise risk error display never showing
  if numError > 100 then
    MDT:DisplayErrors(true)
  end
  return false
end

-- Errors inside the UI kit's frame scripts and callbacks land in the same report.
UI.SetErrorHandler(function(message, stack) onError(message, stack, "UI") end)

--accessible function for errors in coroutines
-- omitRoute suppresses route export for the combined report if any error requests it.
function MDT:OnError(msg, stackTrace, name, omitRoute)
  onError(msg, stackTrace, name, omitRoute)
end

function MDT:GetErrors()
  return caughtErrors
end

function MDT:RegisterErrorHandledFunctions()
  --register all functions except the ones that have to run as coroutines
  local blacklisted = {
    ["DungeonEnemies_UpdateSelected"] = true,
    ["DungeonEnemies_UpdateEnemiesAsync"] = true,
    ["DrawAllPresetObjects"] = true,
    ["AddPull"] = true,
    ["ClearPull"] = true,
    ["ShowInterfaceInternal"] = true,
    ["InitializeMainFrame"] = true,
    ["UpdateToDungeon"] = true,
    ["UpdateMap"] = true,
    ["MovePullUp"] = true,
    ["ShowInterface"] = true,
    ["DeletePull"] = true,
    ["ExportDungeonDataIncrementally"] = true,
    ["DrawAllHulls"] = true,
    ["PlacePullLabels"] = true,
    ["ExportString"] = true,
    ["Async"] = true,
    ["RegisterErrorHandledFunctions"] = true,
    ["OnError"] = true,
  }
  local function packResults(...) return { n = select("#", ...), ... } end
  local tablesToAdd = {
    MDT, MDTDungeonEnemyMixin
  }
  for k, table in pairs(tablesToAdd) do
    for funcName, func in pairs(table) do
      if type(func) == "function" and not blacklisted[funcName] then
        table[funcName] = function(...)
          currentFunc = funcName
          -- n keeps returns after a nil, such as `nil, problem`
          local results = packResults(xpcall(func, onError, ...))
          if not results[1] then
            if addTrace then
              --add stackTrace to the latest error
              caughtErrors[#caughtErrors].stackTrace = currentFunc..":\n"..debugstack()
            end
            return
          end
          return unpack(results, 2, results.n)
        end
      end
    end
  end
end
