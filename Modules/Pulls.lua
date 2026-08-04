local _, MDT = ...

local tinsert, tremove, tonumber, pairs, ipairs = table.insert, table.remove, tonumber, pairs, ipairs
local db

local function initializeDB()
  db = db or MDT:GetDB()
end

---CountForces
---Counts total selected enemy forces in the current preset up to pull
function MDT:CountForces(currentPull, currentOnly)
  initializeDB()
  --count up to and including the currently selected pull
  currentPull = currentPull or 1000
  local preset = self:GetCurrentPreset()
  local pullCurrent = 0
  for pullIdx, pull in pairs(preset.value.pulls) do
    if not currentOnly or (currentOnly and pullIdx == currentPull) then
      if pullIdx <= currentPull then
        for enemyIdx, clones in pairs(pull) do
          if tonumber(enemyIdx) then
            for k, v in pairs(clones) do
              if MDT:IsCloneIncluded(enemyIdx, v) then
                local count = self.dungeonEnemies[db.currentDungeonIdx][enemyIdx].count
                pullCurrent = pullCurrent + count
              end
            end
          end
        end
      else
        break
      end
    end
  end
  return pullCurrent
end

---Adds up health of all enemies in the current pull
function MDT:SumCurrentPullHealth(currentPull)
  initializeDB()
  currentPull = currentPull or 1000
  local preset = self:GetCurrentPreset()
  local pull = preset.value.pulls[currentPull]
  if not pull then return 0 end

  local totalHealth = 0
  for enemyIdx, clones in pairs(pull) do
    if tonumber(enemyIdx) then
      for k, v in pairs(clones) do
        if MDT:IsCloneIncluded(enemyIdx, v) then
          local data = self.dungeonEnemies[db.currentDungeonIdx][enemyIdx]
          local health = self:CalculateEnemyHealth(data.isBoss or false, data.health, db.currentDifficulty, data.ignoreFortified)
          totalHealth = totalHealth + health
        end
      end
    end
  end
  return totalHealth
end

---Checks if the specified clone is part of the current map configuration
function MDT:IsCloneIncluded(enemyIdx, cloneIdx)
  initializeDB()
  local enemy = MDT.dungeonEnemies[db.currentDungeonIdx][enemyIdx]
  local clone = enemy and enemy["clones"][cloneIdx]
  if not clone then return false end
  return true
end

---Returns the current pull of the currently active preset
function MDT:GetCurrentPull()
  local selection = MDT:GetSelection()
  return selection[#selection]
end

---Stores r g b values for coloring pulls with MDT:ColorPull()
local colorPaletteValues = {
  [1] = { --Rainbow values
    [1] = { [1] = 0.2446, [2] = 1, [3] = 0.2446 },
    [2] = { [1] = 0.2446, [2] = 1, [3] = 0.6223 },
    [3] = { [1] = 0.2446, [2] = 1, [3] = 1 },
    [4] = { [1] = 0.2446, [2] = 0.6223, [3] = 1 },
    [5] = { [1] = 0.2446, [2] = 0.2446, [3] = 1 },
    [6] = { [1] = 0.6223, [2] = 0.6223, [3] = 1 },
    [7] = { [1] = 1, [2] = 0.2446, [3] = 1 },
    [8] = { [1] = 1, [2] = 0.2446, [3] = 0.6223 },
    [9] = { [1] = 1, [2] = 0.2446, [3] = 0.2446 },
    [10] = { [1] = 1, [2] = 0.60971, [3] = 0.2446 },
    [11] = { [1] = 1, [2] = 0.98741, [3] = 0.2446 },
    [12] = { [1] = 0.63489, [2] = 1, [3] = 0.2446 },
    --[13] = {[1]=1, [2]=0.2446, [3]=0.54676},
    --[14] = {[1]=1, [2]=0.2446, [3]=0.32014},
    --[15] = {[1]=1, [2]=0.38309, [3]=0.2446},
    --[16] = {[1]=1, [2]=0.60971, [3]=0.2446},
    --[17] = {[1]=1, [2]=0.83633, [3]=0.2446},
    --[18] = {[1]=0.93705, [2]=1, [3]=0.2446},
    --[19] = {[1]=0.71043, [2]=1, [3]=0.2446},
    --[20] = {[1]=0.48381, [2]=1, [3]=0.2446},
  },
  [2] = { --Black and Yellow values
    [1] = { [1] = 0.4, [2] = 0.4, [3] = 0.4 },
    [2] = { [1] = 1, [2] = 1, [3] = 0.0 },
  },
  [3] = { --Red, Green and Blue values
    [1] = { [1] = 0.85882, [2] = 0.058824, [3] = 0.15294 },
    [2] = { [1] = 0.49804, [2] = 1.0, [3] = 0.0 },
    [3] = { [1] = 0.0, [2] = 0.50196, [3] = 1.0 },
  },
  [4] = { --High Contrast values
    [1] = { [1] = 1, [2] = 0.2446, [3] = 1 },
    [2] = { [1] = 0.2446, [2] = 1, [3] = 0.6223 },
    [3] = { [1] = 1, [2] = 0.2446, [3] = 0.2446 },
    [4] = { [1] = 0.2446, [2] = 0.6223, [3] = 1 },
    [5] = { [1] = 1, [2] = 0.98741, [3] = 0.2446 },
    [6] = { [1] = 0.2446, [2] = 1, [3] = 0.2446 },
    [7] = { [1] = 1, [2] = 0.2446, [3] = 0.6223 },
    [8] = { [1] = 0.2446, [2] = 1, [3] = 1 },
    [9] = { [1] = 1, [2] = 0.60971, [3] = 0.2446 },
    [10] = { [1] = 0.2446, [2] = 0.2446, [3] = 1 },
    [11] = { [1] = 0.63489, [2] = 1, [3] = 0.2446 },
  },
  [5] = { --Color Blind Friendly values (Based on IBM's color library "Color blind safe"
    [1] = { [1] = 0.39215686274509803, [2] = 0.5607843137254902, [3] = 1.0 },
    --[2] = {[1]=0.47058823529411764, [2]=0.3686274509803922, [3]=0.9411764705882353},
    [2] = { [1] = 0.8627450980392157, [2] = 0.14901960784313725, [3] = 0.4980392156862745 },
    [3] = { [1] = 0.996078431372549, [2] = 0.3803921568627451, [3] = 0.0 },
    [4] = { [1] = 1.0, [2] = 0.6901960784313725, [3] = 0.0 },
  },
}

---Function executes full coloring of a pull and it's blips
function MDT:ColorPull(colorValues, pullIdx, preset, bypass, exportColorBlind) -- bypass can be passed as true to color even when automatic coloring is toggled off
  initializeDB()
  local colorPaletteInfo = MDT:GetPresetColorPaletteInfo(preset)
  local pullIdx = pullIdx or MDT:GetCurrentPull()
  if (pullIdx) then
    local colorValues
    local numberColors
    local r, g, b
    if colorPaletteInfo.autoColoring or bypass == true then
      --Force color blind mode locally, will not alter the color values saved to a preset
      if db.colorPaletteInfo.forceColorBlindMode == true and not exportColorBlind then
        --Local color blind mode, will not alter the colorPaletteInfo saved to a preset
        colorValues = colorValues or colorPaletteValues[colorValues] or colorPaletteValues[5]
        numberColors = #colorValues
      else
        --Regular coloring
        colorValues = colorValues or colorPaletteValues[colorValues] or colorPaletteInfo.colorPaletteIdx == 6 and colorPaletteInfo.customPaletteValues or colorPaletteValues[colorPaletteInfo.colorPaletteIdx]
        numberColors = colorPaletteInfo.colorPaletteIdx == 6 and colorPaletteInfo.numberCustomColors or #colorValues -- tables must start from 1 and have no blank rows
      end
      local colorIdx = (pullIdx - 1) % numberColors + 1
      r, g, b = colorValues[colorIdx][1], colorValues[colorIdx][2], colorValues[colorIdx][3]

      MDT:DungeonEnemies_SetPullColor(pullIdx, r, g, b)
      MDT:UpdatePullButtonColor(pullIdx, r, g, b)
      MDT:DungeonEnemies_UpdateBlipColors(pullIdx, r, g, b)
    end
  end
end

---Loops over all pulls in a preset and colors them
function MDT:ColorAllPulls(colorValues, startFrom, bypass, exportColorBlind)
  local preset = self:GetCurrentPreset()
  local startFrom = startFrom or 0
  for pullIdx, _ in pairs(preset.value.pulls) do
    if pullIdx >= startFrom then
      MDT:ColorPull(colorValues, pullIdx, preset, bypass, exportColorBlind)
    end
  end
end

function MDT:PresetsAddPull(index, data, preset)
  preset = preset or self:GetCurrentPreset()
  if not data then data = {} end
  if index then
    tinsert(preset.value.pulls, index, data)
  else
    tinsert(preset.value.pulls, data)
  end
  self:EnsureDBTables()
end

---Merges a list of pulls and inserts them at a specified destination.
---
---@param pulls table List of all pull indices, that shall be merged (and deleted). If pulls
---                   is a number, then the pull list is automatically generated from pulls
---                   and destination.
---@param destination number The pull index, where the merged pull shall be inserted.
---
---@author Dradux
function MDT:PresetsMergePulls(pulls, destination)
  if type(pulls) == "number" then
    pulls = { pulls, destination }
  end

  if not destination then
    destination = pulls[#pulls]
  end

  local count_if = self.U.count_if

  local newPull = {}
  local removed_pulls = {}

  for _, pullIdx in ipairs(pulls) do
    local offset = count_if(removed_pulls, function(entry)
      return entry < pullIdx
    end)

    local index = pullIdx - offset
    local pull = self:GetCurrentPreset().value.pulls[index]

    for enemyIdx, clones in pairs(pull) do
      if string.match(enemyIdx, "^%d+$") then
        -- it's really an enemy index
        if tonumber(enemyIdx) then
          if not newPull[enemyIdx] then
            newPull[enemyIdx] = clones
          else
            for k, v in pairs(clones) do
              if newPull[enemyIdx][k] ~= nil then
                local newIndex = #newPull[enemyIdx] + 1
                newPull[enemyIdx][newIndex] = v
              else
                newPull[enemyIdx][k] = v
              end
            end
          end
        end
      else
        -- it's another pull option like color
        local optionName = enemyIdx
        local optionValue = clones
        newPull[optionName] = optionValue
      end
    end

    self:PresetsDeletePull(index)
    tinsert(removed_pulls, pullIdx)
  end

  local offset = count_if(removed_pulls, function(entry)
    return entry < destination
  end)

  local index = destination - offset
  self:PresetsAddPull(index, newPull)
  return index
end

function MDT:PresetsDeletePull(p, preset)
  preset = preset or self:GetCurrentPreset()
  if p == preset.value.currentPull then
    preset.value.currentPull = math.max(p - 1, 1)
  end
  tremove(preset.value.pulls, p)
end

function MDT:GetPulls(preset)
  preset = preset or self:GetCurrentPreset()
  return preset.value.pulls
end

function MDT:GetPullsNum(preset)
  preset = preset or self:GetCurrentPreset()
  return #preset.value.pulls
end

function MDT:PresetsSwapPulls(p1, p2)
  local pulls = self:GetCurrentPreset().value.pulls
  pulls[p1], pulls[p2] = pulls[p2], pulls[p1]
end

function MDT:SetSelectionToPull(pull, ignoreHulls)
  --if pull is not specified set pull to last pull in preset (for adding new pulls)
  if not pull then
    local count = 0
    for k, v in pairs(MDT:GetCurrentPreset().value.pulls) do
      count = count + 1
    end
    pull = count
  end

  --SaveCurrentPresetPull
  if type(pull) == "number" and pull > 0 then
    MDT:GetCurrentPreset().value.currentPull = pull
    MDT:GetCurrentPreset().value.selection = { pull }
    MDT:PickPullButton(pull)

    MDT:DungeonEnemies_UpdateSelected(pull, nil, ignoreHulls)
  elseif type(pull) == "table" then
    MDT:GetCurrentPreset().value.currentPull = pull[#pull]
    MDT:GetCurrentPreset().value.selection = pull

    MDT:ClearPullButtonPicks()
    for _, pullIdx in ipairs(MDT:GetSelection()) do
      MDT:PickPullButton(pullIdx, true)
      MDT:DungeonEnemies_UpdateSelected(pullIdx, nil, ignoreHulls)
    end
  end
  MDT:PullClickAreaOnLeave()
end

---Creates a new pull in the current preset and calls ReloadPullButtons to reflect the change in the scrollframe
function MDT:AddPull(index)
  MDT:PresetsAddPull(index)
  MDT:ReloadPullButtons()
  MDT:SetSelectionToPull(index)
end

---Clears all the npcs out of a pull
function MDT:ClearPull(index)
  initializeDB()
  table.wipe(db.presets[db.currentDungeonIdx][db.currentPreset[db.currentDungeonIdx]].value.pulls[index])
  MDT:EnsureDBTables()
  MDT:ReloadPullButtons()
  MDT:SetSelectionToPull(index)
end

---Moves the selected pull up
function MDT:MovePullUp(index)
  MDT:PresetsSwapPulls(index, index - 1)
  MDT:ReloadPullButtons()
  MDT:SetSelectionToPull(index - 1)
end

---Moves the selected pull down
function MDT:MovePullDown(index)
  MDT:PresetsSwapPulls(index, index + 1)
  MDT:ReloadPullButtons()
  MDT:SetSelectionToPull(index + 1)
end

---Deletes the selected pull and makes sure that a pull will be selected afterwards
function MDT:DeletePull(index)
  local pulls = self:GetPulls()
  if #pulls == 1 then return end
  self:PresetsDeletePull(index)
  self:ReloadPullButtons()
  self:UpdateProgressbar()
  local pullCount = 0
  for k, v in pairs(pulls) do
    pullCount = pullCount + 1
  end
  if index > pullCount then index = pullCount end
  self:SetSelectionToPull(index)
end

function MDT:GetSelection()
  if not MDT:GetCurrentPreset().value.selection or #MDT:GetCurrentPreset().value.selection == 0 then
    MDT:GetCurrentPreset().value.selection = { MDT:GetCurrentPreset().value.currentPull }
  end

  return MDT:GetCurrentPreset().value.selection
end

function MDT:CopyPullOptions(sourceIdx, destinationIdx)
  local preset = MDT:GetCurrentPreset()
  local pulls = preset.value.pulls
  local source = pulls[sourceIdx]
  local destination = pulls[destinationIdx]

  if source and destination then
    for optionName, optionValue in pairs(source) do
      -- Assure, that it is an option and not an enemy index
      if not string.match(optionName, "^%d+$") then
        destination[optionName] = optionValue
      end
    end
  end
end
