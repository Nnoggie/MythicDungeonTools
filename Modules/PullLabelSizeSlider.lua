local _, MDT = ...
local L = MDT.L
local UI = MDT.UI
local Theme = UI.Theme

-- In dev mode, a slider in the map's top right sizes the pull labels. While it moves the labels grow or shrink where
-- they are; on release the size is saved and the labels are placed again around the enemies at their new size. Out of
-- dev mode the labels keep their normal size.

---Its middle is 100%; the left half runs down to 0%, which hides the labels, and the right half up to 400%, in 5% steps.
local MAX_SIZE, STEPS_PER_SIZE = 4, 20
---Slider positions per half: the left half takes 3 per step, the right half 1.
local HALF = 60
local WIDTH = 160
---Above the pull labels, which sit at levels 100 and 105 of the same strata.
local LEVEL = 110

---@param position number
---@return number
local function toSize(position)
  local size = position <= HALF and position / HALF or 1 + (position - HALF) / HALF * (MAX_SIZE - 1)
  return math.floor(size * STEPS_PER_SIZE + 0.5) / STEPS_PER_SIZE
end

---@param size number
---@return number
local function toPosition(size)
  if size <= 1 then return size * HALF end
  return HALF + (size - 1) / (MAX_SIZE - 1) * HALF
end

---@param frame table the main window
local function createSlider(frame)
  local db = MDT:GetDB()
  local gap = Theme.Space("sm")
  local panel = UI.Stack(frame, { width = WIDTH, padding = "sm", background = "bg.panel", border = "border.strong" })
  panel:SetFrameStrata("HIGH")
  panel:SetFrameLevel(LEVEL)
  -- Clicks beside the slider would otherwise pan the map.
  panel:EnableMouse(true)
  UI.Slider(panel, {
    id = "pullLabelSize", label = L["Pull label size"], min = 0, max = HALF * 2, step = 1,
    value = toPosition(db.devPullLabelSize),
    format = function(position) return ("%d%%"):format(math.floor(toSize(position) * 100 + 0.5)) end,
    onChange = function(position) MDT:PreviewPullLabelSize(toSize(position)) end,
    onCommit = function(position)
      local size = toSize(position)
      if size == db.devPullLabelSize then return end
      db.devPullLabelSize = size
      -- Places every label again; the outlines stay as they are.
      MDT:DrawAllHulls()
    end,
  })

  -- Alpha versions show a warning in the same corner; the slider goes below it until it is closed.
  local warning = frame.alphaWarningFrame
  local function anchor()
    panel:ClearAllPoints()
    if warning and warning:IsShown() then
      panel:SetPoint("TOPRIGHT", warning, "BOTTOMRIGHT", 0, -gap)
    else
      panel:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -gap, -gap)
    end
  end
  if warning then
    warning:HookScript("OnShow", anchor)
    warning:HookScript("OnHide", anchor)
  end
  anchor()
  frame.pullLabelSizeSlider = panel
end

---Shows the slider on the map page in dev mode, and hides it otherwise. It is made the first time it shows.
function MDT:UpdatePullLabelSizeSlider()
  local frame = MDT.main_frame
  if not frame then return end
  local shown = MDT:GetDB().devMode == true and MDT:IsMapSectionActive()
  if shown and not frame.pullLabelSizeSlider then createSlider(frame) end
  if frame.pullLabelSizeSlider then frame.pullLabelSizeSlider:SetShown(shown) end
end
