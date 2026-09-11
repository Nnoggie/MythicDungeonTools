local _, MDT = ...
local AceGUI = LibStub("AceGUI-3.0")
local LSM = LibStub("LibSharedMedia-3.0")
local fonts = setmetatable({}, { __mode = "k" })
local roots = setmetatable({}, { __mode = "k" })
local ownedWidgets = setmetatable({}, { __mode = "k" })
local widgetLayouts = setmetatable({}, { __mode = "k" })
local pending = {}
local scheduled

local function applyFont(font, restore)
  local path, size, flags = font:GetFont()
  if not path or not size then return end
  local original = fonts[font]
  if not original then
    if restore then return end
    original = { path = path, size = size, height = font:GetHeight() }
    fonts[font] = original
  elseif not restore then
    if size ~= original.appliedSize then original.size = size end
    if path ~= original.appliedPath then original.path = path end
  end
  local db = MDT:GetDB()
  local targetPath = not restore and db.font ~= "Default" and LSM:Fetch("font", db.font, true) or original.path
  local targetSize = math.max(0.2, original.size + (restore and 0 or db.fontSize - 12))
  font:SetFont(targetPath, targetSize, flags)
  if restore and original.layoutHeight then font:SetHeight(original.height) end
  -- Cache WoW's returned height, which can differ slightly from the requested size.
  original.appliedPath, original.appliedSize = font:GetFont()
  if restore then fonts[font] = nil end
end

local function fitText(font, minimum)
  local original = fonts[font]
  if original then original.layoutHeight = true end
  font:SetHeight(0)
  local height = font:GetStringHeight()
  font:SetHeight(math.max(minimum or 0, height))
  return height
end

local function rememberLayout(widget)
  local layout = widgetLayouts[widget]
  if not layout then
    layout = { height = widget.frame:GetHeight(), alignoffset = widget.alignoffset }
    widgetLayouts[widget] = layout
  end
  return layout
end

local function layoutWidget(widget, restore)
  local kind = widget.type
  if restore then
    local layout = widgetLayouts[widget]
    if not layout then return end
    widget.frame:SetHeight(layout.height)
    widget.alignoffset = layout.alignoffset
    if kind == "CheckBox" then widget.checkbg:SetPoint("TOPLEFT", 0, 0) end
    if kind == "Slider" then widget.editbox:SetHeight(layout.editboxHeight) end
    if kind == "Dropdown" then widget.button_cover:SetPoint("TOPLEFT", widget.frame, "BOTTOMLEFT", 0, 25) end
    widgetLayouts[widget] = nil
  elseif kind == "Label" then
    widget:SetText(widget.label:GetText() or "")
  elseif kind == "CheckBox" then
    local layout = rememberLayout(widget)
    local height = math.max(layout.height, fitText(widget.text, 18) + 6)
    widget.checkbg:SetPoint("TOPLEFT", 0, -(height - widget.checkbg:GetHeight()) / 2)
    widget:SetHeight(height)
  elseif kind == "Heading" or kind == "Button" then
    local layout = rememberLayout(widget)
    local text = widget.label or widget.text
    widget:SetHeight(math.max(layout.height, text:GetStringHeight() + (kind == "Button" and 10 or 2)))
  elseif kind == "Slider" then
    local layout = rememberLayout(widget)
    layout.editboxHeight = layout.editboxHeight or widget.editbox:GetHeight()
    fitText(widget.label, 15)
    local _, size = widget.editbox:GetFont()
    widget.editbox:SetHeight(math.max(layout.editboxHeight, size + 4))
    widget:SetHeight(math.max(layout.height, widget.label:GetHeight() + widget.slider:GetHeight()
      + math.max(widget.editbox:GetHeight(), widget.lowtext:GetStringHeight(), widget.hightext:GetStringHeight())))
  elseif kind == "Dropdown" then
    rememberLayout(widget)
    local labelHeight = widget.label:IsShown() and math.max(14, fitText(widget.label, 18)) or 0
    local _, size = widget.text:GetFont()
    local fieldHeight = math.max(26, size + 10)
    widget.dropdown:SetPoint("TOPLEFT", widget.frame, "TOPLEFT", -15, -labelHeight)
    widget.button_cover:SetPoint("TOPLEFT", widget.frame, "BOTTOMLEFT", 0, fieldHeight - 1)
    widget.alignoffset = labelHeight + fieldHeight / 2 - 1
    widget:SetHeight(labelHeight + fieldHeight)
  elseif kind == "Dropdown-Pullout" then
    local height = 8
    for _, item in ipairs(widget.items) do
      rememberLayout(item)
      local _, size = item.text:GetFont()
      local rowHeight = math.max(16, size + 4)
      item.frame:SetHeight(rowHeight)
      item:SetPoint("TOP", widget.itemFrame, "TOP", 0, 6 - height)
      height = height + rowHeight
    end
    widget.itemFrame:SetHeight(height)
    widget.frame:SetHeight(math.min(widget.maxHeight, height + 24))
    widget:FixScroll()
  end
end

local function applyFrame(frame, restore, visited, layouts)
  if visited[frame] then return end
  visited[frame] = true
  if frame:IsObjectType("EditBox") then applyFont(frame, restore) end
  for _, region in ipairs({ frame:GetRegions() }) do
    if region:IsObjectType("FontString") then applyFont(region, restore) end
  end
  for _, child in ipairs({ frame:GetChildren() }) do
    applyFrame(child, restore, visited, layouts)
  end
  local widget = frame.obj
  if widget and widget.frame == frame then
    if not restore then ownedWidgets[widget] = true end
    layoutWidget(widget, restore)
    if not restore then
      if widget.DoLayout then layouts[widget] = true end
      if widget.parent and ownedWidgets[widget.parent] then layouts[widget.parent] = true end
    end
  end
end

-- Dropdown items can be released independently when their list is rebuilt.
hooksecurefunc(AceGUI, "Release", function(_, widget)
  if not ownedWidgets[widget] then return end
  applyFrame(widget.frame, true, {})
  ownedWidgets[widget] = nil
  if roots[widget.frame] ~= nil then roots[widget.frame] = false end
end)

local function refreshFrames(frames)
  local visited, layouts = {}, {}
  for frame in pairs(frames) do
    if roots[frame] then applyFrame(frame, false, visited, layouts) end
  end
  for widget in pairs(layouts) do widget:DoLayout() end
end

local function schedule(frame)
  pending[frame] = true
  if scheduled then return end
  scheduled = true
  C_Timer.After(0, function()
    local frames = pending
    pending = {}
    scheduled = nil
    refreshFrames(frames)
  end)
end

local function track(frame)
  if roots[frame] == nil then
    frame:HookScript("OnShow", function()
      if roots[frame] then schedule(frame) end
    end)
  end
  roots[frame] = true
  schedule(frame)
end

function MDT:RegisterFontFrame(frame)
  track(frame)
end

function MDT:CreateWidget(widgetType)
  ---@type table
  local widget = AceGUI:Create(widgetType)
  track(widget.frame)
  ownedWidgets[widget] = true
  if widget.pullout then
    track(widget.pullout.frame)
    ownedWidgets[widget.pullout] = true
  end
  return widget
end

function MDT:RefreshFonts()
  refreshFrames(roots)
end

function MDT:GetFontList()
  local values = { Default = self.L["Default"] }
  local order = { "Default" }
  for _, name in ipairs(LSM:List("font")) do
    values[name] = name
    order[#order + 1] = name
  end
  return values, order
end
