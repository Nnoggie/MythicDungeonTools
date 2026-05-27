local _, MDT = ...
local L = MDT.L

local enemyForcesTooltipIcon = "|TInterface\\AddOns\\MythicDungeonTools\\Textures\\MDTMinimap:0:0|t"
local enemyForcesTooltipLabel = L["Enemy Info NPC Enemy Forces"]

local function formatEnemyForces(count, percent, option)
  if option == 2 then
    return ("%s: %.1f%% (%d)"):format(enemyForcesTooltipLabel, percent, count)
  elseif option == 3 then
    return ("%s: %d"):format(enemyForcesTooltipLabel, count)
  elseif option == 4 then
    return ("%s: %.1f%%"):format(enemyForcesTooltipLabel, percent)
  elseif option == 5 then
    return ("%.1f%% (%d)"):format(percent, count)
  elseif option == 6 then
    return ("%d"):format(count)
  elseif option == 7 then
    return ("%.1f%%"):format(percent)
  end
end

local function addEnemyForcesLine(tooltip)
  local option = MDT:GetDB().enemyForcesTooltip
  if option == 1 then return end

  if not IsInInstance() then return end

  local count, percent = C_ScenarioInfo.GetUnitCriteriaProgressValues("mouseover")
  if not count or not percent then return end

  tooltip:AddLine(enemyForcesTooltipIcon..formatEnemyForces(count, percent, option), 1, 1, 1)
  tooltip:Show()
end

do
  TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Unit, addEnemyForcesLine)
end
