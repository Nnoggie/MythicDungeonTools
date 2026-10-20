local _, MDT = ...
local UI = MDT.UI or {}
MDT.UI = UI

---Click semantics of the pull list, matching the pull buttons MDT had before the kit.
---The selection keeps click order; its last entry is the anchor for shift ranges.
---Shift and Ctrl right-clicks never change the selection: the list owner handles those chords.
---@class MDT.UI.SelectionMath
local Selection = {}
UI.Selection = Selection

---@class MDT.UI.ClickMods
---@field shift boolean?
---@field ctrl boolean?
---@field button "LeftButton"|"RightButton"?

---@param selection integer[]
---@param index integer
---@return boolean
function Selection.Contains(selection, index)
  for _, entry in ipairs(selection) do
    if entry == index then return true end
  end
  return false
end

local function copy(selection)
  local result = {}
  for i, entry in ipairs(selection) do result[i] = entry end
  return result
end

---@param selection integer[] current selection, not mutated
---@param index integer clicked row
---@param mods MDT.UI.ClickMods
---@return integer[] newSelection
function Selection.Click(selection, index, mods)
  if mods.button == "RightButton" then
    if mods.shift or mods.ctrl or Selection.Contains(selection, index) then return copy(selection) end
    if #selection == 1 then return { index } end
    local result = copy(selection)
    result[#result + 1] = index
    return result
  end
  if mods.ctrl then
    local result = {}
    for _, entry in ipairs(selection) do
      if entry ~= index then result[#result + 1] = entry end
    end
    if #result == #selection then result[#result + 1] = index end
    return result
  end
  if mods.shift and #selection > 0 then
    local result = copy(selection)
    local anchor = selection[#selection]
    local step = index <= anchor and -1 or 1
    for i = anchor, index, step do
      if not Selection.Contains(result, i) then result[#result + 1] = i end
    end
    return result
  end
  return { index }
end
