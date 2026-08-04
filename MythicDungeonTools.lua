-- Made by Nnoggie, 2017-2025
local _, MDT = ...
local L = MDT.L

local CreateFrame, tonumber, pairs, ipairs = CreateFrame, tonumber, pairs, ipairs

_G["BINDING_NAME_CLICK MDTFocusMarkerButton:LeftButton"] = L["MDT Set Focus Macro"]

local AceGUI = LibStub("AceGUI-3.0")
local db

---@param shouldWarn boolean|nil
function MDT:IsInRestrictedEnvironment(shouldWarn)
  if C_Secrets and C_Secrets.ShouldAurasBeSecret and C_Secrets.ShouldAurasBeSecret() then
    if shouldWarn then
      print('MDT: '..(L["Action blocked: Restricted environment"] or "Action blocked: Restricted environment"))
    end
    return true
  end
  return false
end

function MDT:CreateContextMenu(ownerRegion, generator, ...)
  if self:IsInRestrictedEnvironment(true) then return end
  return MenuUtil.CreateContextMenu(ownerRegion, generator, ...)
end

function MDT:InitializeRuntime()
  db = MDT:InitializeSavedVariables()
  if not db then return end
  MDT:InitializeFadeFrame()
  return db
end

BINDING_NAME_MDTTOGGLE = L["Toggle Window"]
BINDING_NAME_MDTNPC = L["New NPC at Cursor Position"]
BINDING_NAME_MDTWAYPOINT = L["New Patrol Waypoint at Cursor Position"]
BINDING_NAME_MDTUNDODRAWING = L["undoDrawing"]
BINDING_NAME_MDTREDODRAWING = L["redoDrawing"]

function MDT:GetLocaleIndex()
  local localeToIndex = {
    ["enUS"] = 1,
    ["deDE"] = 2,
    ["esES"] = 3,
    ["esMX"] = 4,
    ["frFR"] = 5,
    ["itIT"] = 6,
    ["ptBR"] = 7,
    ["ruRU"] = 8,
    ["koKR"] = 9,
    ["zhCN"] = 10,
    ["zhTW"] = 11,
  }
  return localeToIndex[GetLocale()] or 1
end

MDT.mapInfo = {}
MDT.dungeonTotalCount = {}
MDT.scaleMultiplier = {}
MDT.dungeonMaps = {}
MDT.dungeonEnemies = {}
MDT.mapPOIs = {}
MDT.dungeonSubLevels = {}
MDT.dungeonList = {
  -- these were for the old dropdown menu, need to fix this at some point
  [14] = "-",
  [27] = "-",
  [28] = "-",
  [39] = "-",
}

function MDT:GetDungeonName(idx, forceEnglish)
  if forceEnglish and MDT.mapInfo[idx] and MDT.mapInfo[idx].englishName then
    return MDT.mapInfo[idx].englishName
  end
  return MDT.dungeonList[idx]
end

function MDT:GetDungeonSublevels()
  return MDT.dungeonSubLevels
end

---FormatEnemyForces
function MDT:FormatEnemyForces(forces, forcesmax, progressbar)
  if not forcesmax then
    forcesmax = MDT.dungeonTotalCount[db.currentDungeonIdx].normal
  end
  local percent = forcesmax > 0 and (forces / forcesmax) * 100 or 0
  if progressbar then return string.format((forces.."/"..forcesmax.." (%.2f%%)"), percent) end
  return string.format(forces.." (%.2f%%)", percent)
end

---Progressbar_SetValue
---Sets the value/progress/color of the count progressbar to the apropriate data
function MDT:Progressbar_SetValue(self, totalCurrent, totalMax)
  local percent = totalMax > 0 and (totalCurrent / totalMax) * 100 or 0
  if percent >= 102 then
    if totalCurrent - totalMax > 8 then
      self.Bar:SetStatusBarColor(1, 0, 0, 1)
    else
      self.Bar:SetStatusBarColor(0, 1, 0, 1)
    end
  elseif percent >= 100 then
    self.Bar:SetStatusBarColor(0, 1, 0, 1)
  else
    self.Bar:SetStatusBarColor(0.26, 0.42, 1)
  end
  self.Bar:SetValue(percent)
  self.Bar.Label:SetText(MDT:FormatEnemyForces(totalCurrent, totalMax, true))
  self.AnimValue = percent
end

---UpdateProgressbar
---Update the progressbar on the sidepanel with the correct values
function MDT:UpdateProgressbar()
  MDT:EnsureDBTables()
  local grandTotal = MDT:CountForces()
  MDT:Progressbar_SetValue(MDT.main_frame.sidePanel.ProgressBar, grandTotal, MDT.dungeonTotalCount[db.currentDungeonIdx].normal)
end

---ActivatePullTooltip
---
function MDT:ActivatePullTooltip(pull)
  local pullTooltip = MDT.pullTooltip
  pullTooltip.currentPull = pull
  pullTooltip:Show()
end

---UpdatePullTooltip
---Updates the tooltip which is being displayed when a pull is mouseovered
function MDT:UpdatePullTooltip(tooltip)
  local frame = MDT.main_frame
  if not frame.sidePanel.pullButtonsScrollFrame.frame:IsMouseOver() then
    tooltip:Hide()
  elseif frame.sidePanel.newPullButton and frame.sidePanel.newPullButton.frame:IsMouseOver() then
    tooltip:Hide()
  else
    if frame.sidePanel.newPullButtons and tooltip.currentPull and frame.sidePanel.newPullButtons[tooltip.currentPull] then
      local showData

      --enemy portraits
      for k, v in pairs(frame.sidePanel.newPullButtons[tooltip.currentPull].enemyPortraits) do
        if v:IsMouseOver() and v:IsShown() then
          --model
          if v.enemyData.displayId and (not tooltip.modelNpcId or (tooltip.modelNpcId ~= v.enemyData.displayId)) then
            tooltip.Model:SetDisplayInfo(v.enemyData.displayId)
            tooltip.modelNpcId = v.enemyData.displayId
          end
          --topString
          local newLine = "\n"
          local text = newLine..newLine..newLine..L[v.enemyData.name].." x"..v.enemyData.quantity..newLine
          text = text..string.format(L["Level %d %s"], v.enemyData.level, L[v.enemyData.creatureType])..newLine
          local boss = v.enemyData.isBoss or false
          local health = MDT:CalculateEnemyHealth(boss, v.enemyData.baseHealth, db.currentDifficulty, v.enemyData.ignoreFortified)
          text = text..string.format(L["%s HP"], MDT:FormatEnemyHealth(health))..newLine

          local totalForcesMax = MDT.dungeonTotalCount[db.currentDungeonIdx].normal
          local count = v.enemyData.count
          text = text..L["Forces"]..": "..MDT:FormatEnemyForces(count, totalForcesMax, false)

          tooltip.topString:SetText(text)
          showData = true
          break
        end
      end
      if showData then
        tooltip.topString:Show()
        tooltip.Model:Show()
      else
        tooltip.topString:Hide()
        tooltip.Model:Hide()
      end

      local countEnemies = 0
      for k, v in pairs(frame.sidePanel.newPullButtons[tooltip.currentPull].enemyPortraits) do
        if v:IsShown() then countEnemies = countEnemies + 1 end
      end
      if countEnemies == 0 then
        tooltip:Hide()
        return
      end
      local pullForces = MDT:CountForces(tooltip.currentPull, true)
      local totalForces = MDT:CountForces(tooltip.currentPull, false)
      local totalForcesMax = MDT.dungeonTotalCount[db.currentDungeonIdx].normal

      local text = L["Forces"]..": "..MDT:FormatEnemyForces(pullForces, totalForcesMax, false)
      text = text.."\n"..L["Total"]..": "..MDT:FormatEnemyForces(totalForces, totalForcesMax, true)
      -- local pullHealth = MDT:SumCurrentPullHealth(tooltip.currentPull)
      -- text = text .. "\n" .. L["Efficiency Score"] .. ": " .. MDT:GetEfficiencyScoreString(pullForces, pullHealth)

      tooltip.botString:SetText(text)
      tooltip.botString:Show()
    end
  end
end

local function round(number, decimals)
  return tonumber((("%%.%df"):format(decimals)):format(number))
end

do
  local fortMult = 1.2
  local tyrMult = 1.25
  local scalingNormal = 1.07
  local scalingExtra = 1.1 -- Xalatath's Guile
  local extraScalingLevel = 11

  local getFortTyrMult = function(level, boss, fortified, tyrannical, ignoreFortified)
    local mult = 1
    if level >= 10 then
      if not boss and (fortified and not ignoreFortified) then mult = mult * fortMult end
      if boss and tyrannical then mult = mult * tyrMult end
    end
    return mult
  end

  local function getScaling(mult, level)
    local scaling = mult * (scalingNormal ^ math.min(level - 1, extraScalingLevel - 2)) * (scalingExtra ^ math.max(0, level - extraScalingLevel + 1))
    return round(scaling, 2) --not sure if this additional rounding is needed, but it was in the original code
  end

  function MDT:CalculateEnemyHealth(boss, baseHealth, level, ignoreFortified)
    local fortified = true --fort and tyr are always present in 10 and above, we don't really care for lower levels
    local tyrannical = true
    local mult = 1

    mult = getFortTyrMult(level, boss, fortified, tyrannical, ignoreFortified)
    mult = getScaling(mult, level)

    return round(mult * baseHealth, 0)
  end

end

function MDT:FormatEnemyHealth(amount)
  amount = tonumber(amount)
  if not amount then return "" end

  if self:GetLocaleIndex() == 9 then
    -- KR
    if amount >= 1e16 then
      return string.format("%.3f경", amount / 1e16)
    elseif amount >= 1e12 then
      return string.format("%.3f조", amount / 1e12)
    elseif amount >= 1e8 then
      return string.format("%.2f억", amount / 1e8)
    elseif amount >= 1e4 then
      return string.format("%.1f만", amount / 1e4)
    else
      return amount
    end
  elseif self:GetLocaleIndex() == 10 or self:GetLocaleIndex() == 11 then
    if amount >= 1e8 then
      return string.format("%.2f亿", amount / 1e8)
    elseif amount >= 1e4 then
      return string.format("%d万", math.floor(amount / 1e4))
    else
      return amount
    end
  else
    if amount >= 1e12 then
      return string.format("%.3ft", amount / 1e12)
    elseif amount >= 1e9 then
      return string.format("%.3fb", amount / 1e9)
    elseif amount >= 1e6 then
      return string.format("%.2fm", amount / 1e6)
    elseif amount >= 1e3 then
      return string.format("%.1fk", amount / 1e3)
    else
      return amount
    end
  end
end

function MDT:MakePullSelectionButtons(frame)
  frame.PullButtonScrollGroup = AceGUI:Create("SimpleGroup")
  frame.PullButtonScrollGroup:SetWidth(248)
  frame.PullButtonScrollGroup:SetHeight(410)
  frame.PullButtonScrollGroup:SetPoint("TOPLEFT", frame.WidgetGroup.frame, "BOTTOMLEFT", -4, -32)
  frame.PullButtonScrollGroup:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", 0, 30)
  frame.PullButtonScrollGroup:SetLayout("Fill")
  frame.PullButtonScrollGroup.frame:SetParent(frame)
  if not frame.PullButtonScrollGroup.frame.SetBackdrop then
    Mixin(frame.PullButtonScrollGroup.frame, BackdropTemplateMixin)
  end
  frame.PullButtonScrollGroup.frame:SetBackdropColor(1, 1, 1, 0)
  frame.PullButtonScrollGroup.frame:Hide()

  self:FixAceGUIShowHide(frame.PullButtonScrollGroup)

  frame.pullButtonsScrollFrame = AceGUI:Create("ScrollFrame")
  frame.pullButtonsScrollFrame:SetLayout("Flow")

  frame.PullButtonScrollGroup:AddChild(frame.pullButtonsScrollFrame)

  frame.newPullButtons = {}
  --rightclick context menu
  frame.optionsDropDown = CreateFrame("frame", "MDTPullButtonsOptionsDropDown", nil, "UIDropDownMenuTemplate")
end

---Updates the portraits display of a button to show which and how many npcs are selected
function MDT:UpdatePullButtonNPCData(idx)
  if db.devMode then return end
  local preset = MDT:GetCurrentPreset()
  local frame = MDT.main_frame.sidePanel
  local enemyTable = {}
  if preset.value.pulls[idx] then
    local enemyTableIdx = 0
    for enemyIdx, clones in pairs(preset.value.pulls[idx]) do
      if tonumber(enemyIdx) then
        --check if enemy exists, remove if not
        if MDT.dungeonEnemies[db.currentDungeonIdx][enemyIdx] then
          local incremented = false
          local npcId = MDT.dungeonEnemies[db.currentDungeonIdx][enemyIdx]["id"]
          local name = MDT.dungeonEnemies[db.currentDungeonIdx][enemyIdx]["name"]
          local creatureType = MDT.dungeonEnemies[db.currentDungeonIdx][enemyIdx]["creatureType"]
          local level = MDT.dungeonEnemies[db.currentDungeonIdx][enemyIdx]["level"]
          local baseHealth = MDT.dungeonEnemies[db.currentDungeonIdx][enemyIdx]["health"]
          for k, cloneIdx in pairs(clones) do
            --check if clone exists, remove if not
            if MDT.dungeonEnemies[db.currentDungeonIdx][enemyIdx]["clones"][cloneIdx] then
              if self:IsCloneIncluded(enemyIdx, cloneIdx) then
                if not incremented then
                  enemyTableIdx = enemyTableIdx + 1
                  incremented = true
                end
                if not enemyTable[enemyTableIdx] then enemyTable[enemyTableIdx] = {} end
                enemyTable[enemyTableIdx].quantity = enemyTable[enemyTableIdx].quantity or 0
                enemyTable[enemyTableIdx].npcId = npcId
                enemyTable[enemyTableIdx].count = MDT.dungeonEnemies[db.currentDungeonIdx][enemyIdx]["count"]
                enemyTable[enemyTableIdx].displayId = MDT.dungeonEnemies[db.currentDungeonIdx][enemyIdx]["displayId"]
                enemyTable[enemyTableIdx].quantity = enemyTable[enemyTableIdx].quantity + 1
                enemyTable[enemyTableIdx].name = name
                enemyTable[enemyTableIdx].level = level
                enemyTable[enemyTableIdx].creatureType = creatureType
                enemyTable[enemyTableIdx].baseHealth = baseHealth
                enemyTable[enemyTableIdx].ignoreFortified = MDT.dungeonEnemies[db.currentDungeonIdx][enemyIdx]["ignoreFortified"]
                enemyTable[enemyTableIdx].isBoss = MDT.dungeonEnemies[db.currentDungeonIdx][enemyIdx]["isBoss"]
              end
            end
          end
        end
      end
    end
  end
  frame.newPullButtons[idx]:SetNPCData(enemyTable)

  local pullForces = MDT:CountForces(idx, false)
  local totalForcesMax = MDT.dungeonTotalCount[db.currentDungeonIdx].normal

  --count per health
  if pullForces > 0 then
    frame.newPullButtons[idx]:ShowCountPerHealth(true, pullForces, totalForcesMax)
  else
    frame.newPullButtons[idx]:ShowCountPerHealth(true, pullForces, totalForcesMax)
  end
end

---Reloads all pull buttons in the scroll frame
function MDT:ReloadPullButtons(force)
  MDT:Async(function()
    local frame = MDT.main_frame.sidePanel
    if not frame.pullButtonsScrollFrame then return end
    local preset = db.presets[db.currentDungeonIdx][db.currentPreset[db.currentDungeonIdx]]
    --store scroll value
    local oldScrollValue = frame.pullButtonsScrollFrame.localstatus.scrollvalue
    --first release all children of the scroll frame
    frame.pullButtonsScrollFrame:ReleaseChildren()
    coroutine.yield()
    local maxPulls = 0
    for k, v in pairs(preset.value.pulls) do
      maxPulls = maxPulls + 1
    end
    --add new children to the scrollFrame, the frames are from the widget pool so no memory is wasted
    local idx = 0
    for k, pull in ipairs(preset.value.pulls) do
      idx = idx + 1
      ---@diagnostic disable-next-line: param-type-mismatch
      frame.newPullButtons[idx] = AceGUI:Create("MDTPullButton")
      frame.newPullButtons[idx]:SetMaxPulls(maxPulls)
      frame.newPullButtons[idx]:SetIndex(idx)
      MDT:UpdatePullButtonNPCData(idx)
      frame.newPullButtons[idx]:Initialize()
      frame.newPullButtons[idx]:Enable()
      frame.pullButtonsScrollFrame:AddChild(frame.newPullButtons[idx])
      coroutine.yield()
    end
    --add the "new pull" button
    ---@diagnostic disable-next-line: param-type-mismatch
    frame.newPullButton = AceGUI:Create("MDTNewPullButton")
    frame.newPullButton:Initialize()
    frame.newPullButton:Enable()
    frame.pullButtonsScrollFrame:AddChild(frame.newPullButton)
    --set the scroll value back to the old value
    frame.pullButtonsScrollFrame.scrollframe.obj:SetScroll(oldScrollValue)
    frame.pullButtonsScrollFrame.scrollframe.obj:FixScroll()
    if self:GetCurrentPreset().value.currentPull then
      self:PickPullButton(self:GetCurrentPreset().value.currentPull)
    end
    MDT:ColorAllPulls(nil, 0)
    MDT:DrawAllHulls(preset.value.pulls, force)
  end, "ReloadPullButtons", true)
end

---Deselects all pull buttons
function MDT:ClearPullButtonPicks()
  local frame = MDT.main_frame.sidePanel
  for k, v in pairs(frame.newPullButtons) do
    v:ClearPick()
  end
end

---Selects the current pull button and deselects all other buttons
function MDT:PickPullButton(idx, keepPicked)
  if db.devMode then return end

  if not keepPicked then
    MDT:ClearPullButtonPicks()
  end
  local frame = MDT.main_frame.sidePanel
  if frame.newPullButtons[idx] then
    frame.newPullButtons[idx]:Pick()
  end
end

function MDT:GetFirstNotSelectedPullButton(start, direction)
  if not direction then
    direction = -1
  elseif direction == "UP" then
    direction = -1
  elseif direction == "DOWN" then
    direction = 1
  end

  local pullIdx = start
  while MDT.U.contains(MDT:GetCurrentPreset().value.selection, pullIdx)
    and MDT.U.isInRange(pullIdx, 1, #MDT:GetCurrentPreset().value.pulls) do
    pullIdx = pullIdx + direction
  end

  if not MDT.U.isInRange(pullIdx, 1, #MDT:GetCurrentPreset().value.pulls) then
    return
  end

  return pullIdx
end

function MDT:Round(number, decimals)
  return (("%%.%df"):format(decimals)):format(number)
end

function MDT:RGBToHex(r, g, b)
  r = r * 255
  g = g * 255
  b = b * 255
  return ("%.2x%.2x%.2x"):format(r, g, b)
end

function MDT:HexToRGB(rgb)
  if string.len(rgb) == 6 then
    local r, g, b
    r, g, b = tonumber('0x'..strsub(rgb, 0, 2)), tonumber('0x'..strsub(rgb, 3, 4)), tonumber('0x'..
      strsub(rgb, 5, 6))
    if not r then r = 0 else r = r / 255 end
    if not g then g = 0 else g = g / 255 end
    if not b then b = 0 else b = b / 255 end
    return r, g, b
  else
    return
  end
end

---Checks if the players is in a group/raid and returns the type
function MDT:IsPlayerInGroup()
  local inGroup = (UnitInRaid("player") and "RAID") or (IsInGroup() and "PARTY")
  return inGroup
end

function MDT:DropIndicator()
  local indicator = MDT.main_frame.drop_indicator
  if not indicator then
    indicator = CreateFrame("Frame", "MDT_DropIndicator")
    indicator:SetHeight(4)
    indicator:SetFrameStrata("FULLSCREEN")

    local texture = indicator:CreateTexture(nil, "OVERLAY", nil, 0)
    texture:SetBlendMode("ADD")
    texture:SetAllPoints(indicator)
    texture:SetTexture("Interface\\PaperDollInfoFrame\\UI-Character-Tab-Highlight")

    local icon = indicator:CreateTexture(nil, "OVERLAY", nil, 0)
    icon:ClearAllPoints()
    icon:SetSize(16, 16)
    icon:SetPoint("CENTER", indicator)

    indicator.icon = icon
    indicator.texture = texture
    MDT.main_frame.drop_indicator = indicator

    indicator:Hide()
  end

  return indicator
end

function MDT:IsShown_DropIndicator()
  local indicator = MDT:DropIndicator()
  return indicator:IsShown()
end

function MDT:Show_DropIndicator(target, pos)
  local indicator = MDT:DropIndicator()
  indicator:ClearAllPoints()
  if pos == "TOP" then
    indicator:SetPoint("BOTTOMLEFT", target.frame, "TOPLEFT", 0, -1)
    indicator:SetPoint("BOTTOMRIGHT", target.frame, "TOPRIGHT", 0, -1)
    indicator:Show()
  elseif pos == "BOTTOM" then
    indicator:SetPoint("TOPLEFT", target.frame, "BOTTOMLEFT", 0, 1)
    indicator:SetPoint("TOPRIGHT", target.frame, "BOTTOMRIGHT", 0, 1)
    indicator:Show()
  end
end

function MDT:Hide_DropIndicator()
  local indicator = MDT:DropIndicator()
  indicator:Hide()
end

function MDT:GetScrollingAmount(scrollFrame, pixelPerSecond)
  local viewheight = scrollFrame.frame.obj.content:GetHeight()
  return (pixelPerSecond / viewheight) * 1000
end

function MDT:GetPullButton(pullIdx)
  local frame = MDT.main_frame.sidePanel
  return frame.newPullButtons[pullIdx]
end

function MDT:UpdatePullButtonColor(pullIdx, r, g, b)
  local button = MDT:GetPullButton(pullIdx)
  if not button then return end
  button.color.r, button.color.g, button.color.b = r, g, b
  button:UpdateColor()
end

MDT.modules = {}
function MDT:RegisterModule(modulename, module)
  MDT.modules[modulename] = module
end
