-- Made by Nnoggie, 2017-2024
local AddonName, MDT = ...
local L = MDT.L
local mainFrameStrata = "HIGH"
local canvasDrawLayer = "BORDER"

local tinsert, tremove, CreateFrame, tonumber, max, min, abs, pairs, ipairs, GetCursorPosition, GameTooltip, MouseIsOver =
    table
    .insert
    , table.remove, CreateFrame, tonumber, math.max, math.min, math.abs, pairs, ipairs, GetCursorPosition, GameTooltip,
    MouseIsOver

local sizex = 840
local sizey = 555
local framesInitialized, initFrames
MDT.externalLinks = {
  {
    name = "GitHub",
    tooltip = L["Open an issue on GitHub"],
    url = "https://github.com/Nnoggie/MythicDungeonTools/issues",
    texture = { "Interface\\AddOns\\MythicDungeonTools\\Textures\\icons", 0.76, 1, 0.75, 1 }
  },
  {
    name = "Discord",
    tooltip = L["Provide feedback in Discord"],
    url = "https://discord.gg/tdxMPb3",
    texture = { "Interface\\AddOns\\MythicDungeonTools\\Textures\\icons", 0.5, .75, 0.75, 1 }
  },
}

BINDING_HEADER_MDT = "Mythic Dungeon Tools (MDT)"
BINDING_NAME_MDTTOGGLE = L["Toggle MDT"]

local mythicColor = "|cFFFFFFFF"
MDT.BackdropColor = { 0.058823399245739, 0.058823399245739, 0.058823399245739, 0.9 }

local AceGUI = LibStub("AceGUI-3.0")
local db
local minimapIcon = LibStub("LibDBIcon-1.0")

function MDT:HideMinimapButton()
  db.minimap.hide = true
  minimapIcon:Hide("MythicDungeonTools")
  -- update the checkbox in settings
  if MDT.main_frame and MDT.main_frame.minimapCheckbox then MDT.main_frame.minimapCheckbox:SetValue(false) end
  print(L["MDT: Use /mdt minimap to show the minimap icon again"])
end

function MDT:ShowMinimapButton()
  db.minimap.hide = false
  minimapIcon:Show("MythicDungeonTools")
  -- update the checkbox in settings
  if MDT.main_frame and MDT.main_frame.minimapCheckbox then MDT.main_frame.minimapCheckbox:SetValue(true) end
end

---@diagnostic disable: missing-fields
local LDB = LibStub("LibDataBroker-1.1"):NewDataObject("MythicDungeonTools", {
  type = "data source",
  text = "Mythic Dungeon Tools",
  icon = "Interface\\AddOns\\"..AddonName.."\\Textures\\MDTMinimap",
  OnClick = function(button, buttonPressed)
    if buttonPressed == "RightButton" then
      if db.minimap.lock then
        minimapIcon:Unlock("MythicDungeonTools")
      else
        minimapIcon:Lock("MythicDungeonTools")
      end
    elseif (buttonPressed == 'MiddleButton') then
      if db.minimap.hide then
        MDT:ShowMinimapButton()
      else
        MDT:HideMinimapButton()
      end
    else
      MDT:Async(function() MDT:ShowInterfaceInternal() end, "showInterface")
    end
  end,
  OnTooltipShow = function(tooltip)
    if not tooltip or not tooltip.AddLine then return end
    tooltip:AddLine(mythicColor.."Mythic Dungeon Tools|r")
    tooltip:AddLine(L["Click to toggle AddOn Window"])
    tooltip:AddLine(L["Right-click to lock Minimap Button"])
    tooltip:AddLine(L["Middle-click to disable Minimap Button"])
  end,
})

SLASH_MYTHICDUNGEONTOOLS1 = "/mplus"
SLASH_MYTHICDUNGEONTOOLS2 = "/mdt"
SLASH_MYTHICDUNGEONTOOLS3 = "/mythicdungeontools"

BINDING_NAME_MDTTOGGLE = L["Toggle Window"]
BINDING_NAME_MDTNPC = L["New NPC at Cursor Position"]
BINDING_NAME_MDTWAYPOINT = L["New Patrol Waypoint at Cursor Position"]
BINDING_NAME_MDTUNDODRAWING = L["undoDrawing"]
BINDING_NAME_MDTREDODRAWING = L["redoDrawing"]

---@diagnostic disable-next-line: duplicate-set-field
function SlashCmdList.MYTHICDUNGEONTOOLS(cmd, editbox)
  cmd = cmd:lower()
  local rqst, arg = strsplit(' ', cmd)
  if rqst == "devmode" then
    MDT:ToggleDevMode()
  elseif rqst == "reset" then
    MDT:ResetMainFramePos()
  elseif rqst == "dc" then
    MDT:ToggleDataCollection()
  elseif rqst == "hardreset" then
    if arg == "force" then
      MDT:HardReset()
    else
      MDT:Async(function()
        MDT:OpenConfirmationFrame(450, 150, L["hardResetPromptTitle"], L["Delete"], L["hardResetPrompt"], MDT.HardReset)
      end, "hardReset")
    end
  elseif rqst == "minimap" then
    if db.minimap.hide then
      MDT:ShowMinimapButton()
    else
      MDT:HideMinimapButton()
    end
  elseif rqst == "test" then
    MDT:OpenConfirmationFrame(450, 150, "MDT Test", "Run", "Run all tests?", MDT.test.RunAllTests)
  else
    MDT:Async(function() MDT:ShowInterfaceInternal() end, "showInterface")
  end
end

--MDT.WagoAnalytics = LibStub("WagoAnalytics"):Register("rN4VrAKD")

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

-------------------------
--- Saved Variables  ----
-------------------------
local defaultSavedVars = {
  global = {
    toolbarExpanded = true,
    currentSeason = 11, -- not really used for anything anymore
    scale = 1,
    nonFullscreenScale = 1.4,
    enemyForcesFormat = 2,
    useForcesCount = false, -- replaces percent in pull buttons with count
    enemyStyle = 1,
    currentDifficulty = 10,
    xoffset = -80,
    yoffset = -100,
    defaultColor = "228b22",
    anchorFrom = "TOP",
    anchorTo = "TOP",
    tooltipInCorner = false,
    minimap = {
      hide = false,
      compartmentHide = false,
    },
    toolbar = {
      color = { r = 1, g = 1, b = 1, a = 1 },
      brushSize = 3,
    },
    presets = {},
    currentPreset = {},
    newDataCollectionActive = false,
    colorPaletteInfo = {
      autoColoring = true,
      forceColorBlindMode = false,
      colorPaletteIdx = 4,
      customPaletteValues = {},
      numberCustomColors = 12,
    },
    currentDungeonIdx = 31,
    selectedDungeonList = 1,
    latestSeenDungeonList = 0,
    knownAffixWeeks = {},
  },
}
do
  for i = 1, 200 do
    defaultSavedVars.global.presets[i] = {
      [1] = {
        text = L["Default"],
        value = {},
        objects = {},
        colorPaletteInfo = { autoColoring = true, colorPaletteIdx = 4 }
      },
      [2] = { text = L["<New Preset>"], value = 0 },
    }
    defaultSavedVars.global.currentPreset[i] = 1
  end
end

function MDT:GetDefaultSavedVariables()
  return defaultSavedVars
end

-- Init db
local eventFrame
do
  eventFrame = CreateFrame("Frame")
  eventFrame:RegisterEvent("ADDON_LOADED")
  eventFrame:RegisterEvent("GROUP_ROSTER_UPDATE")
  eventFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
  --TODO Register Affix Changed event
  eventFrame:SetScript("OnEvent", function(self, event, ...)
    return MDT[event](self, ...)
  end)

  function MDT.ADDON_LOADED(self, addon)
    if addon == "MythicDungeonTools" then
      db = LibStub("AceDB-3.0"):New("MythicDungeonToolsDB", defaultSavedVars).global
      if not db then return end
      ---@diagnostic disable-next-line: param-type-mismatch
      minimapIcon:Register("MythicDungeonTools", LDB, db.minimap)
      if not db.minimap.hide then
        minimapIcon:Show("MythicDungeonTools")
      end
      if db.newDataCollectionActive or MDT:IsOnBetaServer() then
        MDT.DataCollection:Init()
        MDT.DataCollection:InitHealthTrack()
      end
      --compartment
      if not db.minimap.compartmentHide then
        minimapIcon:AddButtonToCompartment("MythicDungeonTools")
      end
      --fix db corruption
      do
        for k, v in pairs(db.currentPreset) do
          if v <= 0 then db.currentPreset[k] = 1 end
        end
      end
      eventFrame:UnregisterEvent("ADDON_LOADED")
    end
  end

  local last = 0
  function MDT.GROUP_ROSTER_UPDATE()
    --check not more than once per second (blizzard event spam)
    local now = GetTime()
    if last < now - 1 then
      if not MDT.main_frame then return end
      local inGroup = UnitInRaid("player") or IsInGroup()
      MDT.main_frame.LinkToChatButton:SetDisabled(not inGroup)
      MDT.main_frame.LiveSessionButton:SetDisabled(not inGroup)
      if inGroup then
        MDT.main_frame.LinkToChatButton.text:SetTextColor(1, 0.8196, 0)
        if MDT.liveSessionActive then
          MDT.main_frame.LiveSessionButton:SetText(L["*Live*"])
          MDT.main_frame.LiveSessionButton.text:SetTextColor(0, 1, 0)
        else
          MDT.main_frame.LiveSessionButton:SetText(L["Live"])
          MDT.main_frame.LiveSessionButton.text:SetTextColor(1, 0.8196, 0)
        end
      else
        MDT.main_frame.LinkToChatButton.text:SetTextColor(0.5, 0.5, 0.5)
        MDT.main_frame.LiveSessionButton.text:SetTextColor(0.5, 0.5, 0.5)
      end
      last = now
    end
  end

  function MDT.PLAYER_ENTERING_WORLD()
    --initialize Blizzard_ChallengesUI
    C_Timer.After(1, function()
      if db.loadOnStartUp and db.devMode then MDT:Async(function() MDT:ShowInterfaceInternal(true) end, "showInterface") end
    end)
    eventFrame:UnregisterEvent("PLAYER_ENTERING_WORLD")
  end
end

--affixID as used in C_ChallengeMode.GetAffixInfo(affixID)
--https://www.wowhead.com/affixes
--lvl 4 affix, lvl 7 affix, tyrannical/fortified, seasonal affix
local affixWeeks = {
  [1] = { 9, 148 },
  [2] = { 10 },
  [3] = { 9 },
  [4] = { 10 },
  [5] = { 9 },
  [6] = { 10 },
  [7] = { 9 },
  [8] = { 10 },
  [9] = { 9 },
  [10] = { 10 },
}

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

function MDT:IsOnBetaServer()
  local realm = GetRealmName()
  local regionID = GetCurrentRegion()
  if regionID <= 5 then return false end
  local realms = {
    ["These Go To Eleven"] = true,
    ["Turnips Delight"] = true,
    ["Alleria"] = true,
    ["Khadgar"] = true,
  }
  return realms[realm]
end

function MDT:GetNumDungeons()
  local count = 0
  for _, _ in pairs(MDT.dungeonList) do
    count = count + 1
  end
  return count
end

function MDT:GetDungeonName(idx, forceEnglish)
  -- don't fail hard for legacy dungeons
  if forceEnglish and MDT.mapInfo[idx].englishName then
    return MDT.mapInfo[idx].englishName
  end
  return MDT.dungeonList[idx]
end

function MDT:GetDungeonSublevels()
  return MDT.dungeonSubLevels
end

function MDT:GetSublevelName(dungeonIdx, sublevelIdx)
  if not dungeonIdx then dungeonIdx = db.currentDungeonIdx end
  return MDT.dungeonSubLevels[dungeonIdx][sublevelIdx]
end

function MDT:GetDB()
  return db
end

function MDT:ShowInterface(force)
  MDT:Async(function() MDT:ShowInterfaceInternal(force) end, "showInterface")
end

function MDT:ShowInterfaceInternal(force)
  if not self:IsCompatibleVersion() then
    self:ShowFallbackWindow()
    return
  end
  if self:CheckAddonConflicts() then
    self.ShowConflictFrame()
    return
  end
  MDT:DisplayErrors()
  if not framesInitialized then initFrames() end
  if not framesInitialized then return end
  if self.main_frame:IsShown() and not force then
    MDT:HideInterface()
  else
    self.main_frame:Show()
    self:CheckCurrentZone()
    --edge case if user closed MDT window while in the process of dragging a corrupted blip
    if self.draggedBlip then
      if MDT.liveSessionActive then
        MDT:LiveSession_SendCorruptedPositions(MDT:GetRiftOffsets())
      end
      self:UpdateMap()
      self.draggedBlip = nil
    end
    MDT:UpdateBottomText()
  end
end

function MDT:HideInterface()
  if self.main_frame then
    self.main_frame:Hide()
  end
end

function MDT:ToggleDataCollection()
  db.newDataCollectionActive = not db.newDataCollectionActive
  print(string.format("%sMDT|r: DataCollection %s. Reload Interface!", mythicColor,
    db.newDataCollectionActive and "|cFF00FF00Enabled|r" or "|cFFFF0000Disabled|r"))
end

function MDT:CreateMenu()
  -- Close button
  self.main_frame.closeButton = CreateFrame("Button", "MDTCloseButton", self.main_frame, "UIPanelCloseButton")
  self.main_frame.closeButton:ClearAllPoints()
  self.main_frame.closeButton:SetPoint("TOPRIGHT", self.main_frame.sidePanel, "TOPRIGHT", -1, -4)
  self.main_frame.closeButton:SetScript("OnClick", function() self:HideInterface() end)
  self.main_frame.closeButton:SetFrameLevel(4)

  --Maximize Button
  self.main_frame.maximizeButton = CreateFrame("Button", "MDTMaximizeButton", self.main_frame,
    "MaximizeMinimizeButtonFrameTemplate")
  self.main_frame.maximizeButton:ClearAllPoints()
  ---@diagnostic disable-next-line: param-type-mismatch
  self.main_frame.maximizeButton:SetPoint("RIGHT", self.main_frame.closeButton, "LEFT", 0, 0)
  self.main_frame.maximizeButton:SetFrameLevel(4)
  db.maximized = db.maximized or false
  if not db.maximized then self.main_frame.maximizeButton:Minimize() end
  self.main_frame.maximizeButton:SetOnMaximizedCallback(self.Maximize)
  self.main_frame.maximizeButton:SetOnMinimizedCallback(self.Minimize)

  --return to live preset
  self.main_frame.liveReturnButton = CreateFrame("Button", "MDTLiveReturnButton", self.main_frame, "UIPanelCloseButton")
  local liveReturnButton = self.main_frame.liveReturnButton
  liveReturnButton:ClearAllPoints()
  liveReturnButton:SetPoint("RIGHT", self.main_frame.topPanel, "RIGHT", 0, 0)
  liveReturnButton:Hide()
  liveReturnButton.Icon = liveReturnButton:CreateTexture(nil, "OVERLAY", nil, 0)
  liveReturnButton.Icon:SetTexture("Interface\\Buttons\\UI-RefreshButton")
  liveReturnButton.Icon:SetSize(16, 16)
  liveReturnButton.Icon:SetTexCoord(1, 0, 0, 1) --flipped image
  ---@diagnostic disable-next-line: param-type-mismatch
  liveReturnButton.Icon:SetPoint("CENTER", liveReturnButton, "CENTER")
  liveReturnButton:SetScript("OnClick", function() self:ReturnToLivePreset() end)
  liveReturnButton:SetFrameLevel(4)
  liveReturnButton.tooltip = L["Return to the live preset"]

  --set preset as new live preset
  self.main_frame.setLivePresetButton = CreateFrame("Button", "MDTSetLivePresetButton", self.main_frame,
    "UIPanelCloseButton")
  local setLivePresetButton = self.main_frame.setLivePresetButton
  setLivePresetButton:ClearAllPoints()
  ---@diagnostic disable-next-line: param-type-mismatch
  setLivePresetButton:SetPoint("RIGHT", liveReturnButton, "LEFT", 0, 0)
  setLivePresetButton:Hide()
  setLivePresetButton.Icon = setLivePresetButton:CreateTexture(nil, "OVERLAY", nil, 0)
  setLivePresetButton.Icon:SetTexture("Interface\\ChatFrame\\ChatFrameExpandArrow")
  setLivePresetButton.Icon:SetSize(16, 16)
  ---@diagnostic disable-next-line: param-type-mismatch
  setLivePresetButton.Icon:SetPoint("CENTER", setLivePresetButton, "CENTER")
  setLivePresetButton:SetScript("OnClick", function() self:SetLivePreset() end)
  setLivePresetButton:SetFrameLevel(4)
  setLivePresetButton.tooltip = L["Make this preset the live preset"]

  --Resize Handle
  self.main_frame.resizer = CreateFrame("BUTTON", nil, self.main_frame.sidePanel)
  local resizer = self.main_frame.resizer
  resizer:SetPoint("BOTTOMRIGHT", self.main_frame.sidePanel, "BOTTOMRIGHT", 7, -7)
  resizer:SetSize(25, 25)
  resizer:EnableMouse()
  resizer:SetScript("OnMouseDown", function()
    self.main_frame:StartSizing("BOTTOMRIGHT")
    self:StartScaling()
    self:HideAllPresetObjects()
    self:ReleaseHullTextures()
    self.main_frame:SetScript("OnSizeChanged", function()
      local height = self.main_frame:GetHeight()
      self:SetScale(height / sizey)
    end)
  end)
  resizer:SetScript("OnMouseUp", function()
    self.main_frame:StopMovingOrSizing()
    self:UpdateEnemyInfoFrame()
    self:UpdateMap()
    self:UpdateBottomText()
    self.main_frame:SetScript("OnSizeChanged", function()
    end)
  end)
  local normal = resizer:CreateTexture(nil, "OVERLAY", nil, 0)
  normal:SetTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Up")
  normal:SetTexCoord(0, 1, 0, 1)
  normal:SetPoint("BOTTOMLEFT", resizer, 0, 6)
  normal:SetPoint("TOPRIGHT", resizer, -6, 0)
  resizer:SetNormalTexture(normal)
  local pushed = resizer:CreateTexture(nil, "OVERLAY", nil, 0)
  pushed:SetTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Down")
  pushed:SetTexCoord(0, 1, 0, 1)
  pushed:SetPoint("BOTTOMLEFT", resizer, 0, 6)
  pushed:SetPoint("TOPRIGHT", resizer, -6, 0)
  resizer:SetPushedTexture(pushed)
  local highlight = resizer:CreateTexture(nil, "OVERLAY", nil, 0)
  highlight:SetTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Highlight")
  highlight:SetTexCoord(0, 1, 0, 1)
  highlight:SetPoint("BOTTOMLEFT", resizer, 0, 6)
  highlight:SetPoint("TOPRIGHT", resizer, -6, 0)
  resizer:SetHighlightTexture(highlight)
end

---GetDefaultMapPanelSize
function MDT:GetDefaultMapPanelSize()
  return sizex, sizey
end

---GetScale
---Returns scale factor stored in db
function MDT:GetScale()
  if not db.scale then db.scale = 1 end
  return db.scale
end

local oldScrollValues = {}
---StartScaling
---Stores values when we start scaling the frame
function MDT:StartScaling()
  local f = self.main_frame
  oldScrollValues.oldScrollH = f.scrollFrame:GetHorizontalScroll()
  oldScrollValues.oldScrollV = f.scrollFrame:GetVerticalScroll()
  oldScrollValues.oldSizeX = f.scrollFrame:GetWidth()
  oldScrollValues.oldSizeY = f.scrollFrame:GetHeight()
  self:DungeonEnemies_HideAllBlips()
  self:POI_HideAllPoints()
  self:KillAllAnimatedLines()
end

---SetScale
---Scales the map frame and it's sub frames to a factor and stores the scale in db
function MDT:SetScale(scale)
  local f = self.main_frame
  local newSizex = sizex * scale
  local newSizey = sizey * scale
  f:SetSize(newSizex, newSizey)
  f.scrollFrame:SetSize(newSizex, newSizey)
  f.mapPanelFrame:SetSize(newSizex, newSizey)
  for i = 1, 12 do
    f["mapPanelTile"..i]:SetSize((newSizex / 4 + 5 * scale), (newSizex / 4 + 5 * scale))
  end
  for i = 1, 10 do
    for j = 1, 15 do
      f["largeMapPanelTile"..i..j]:SetSize(newSizex / 15, newSizex / 15)
    end
  end
  f.scrollFrame:SetVerticalScroll(oldScrollValues.oldScrollV * (newSizey / oldScrollValues.oldSizeY))
  f.scrollFrame:SetHorizontalScroll(oldScrollValues.oldScrollH * (newSizex / oldScrollValues.oldSizeX))
  f.scrollFrame.cursorY = f.scrollFrame.cursorY * (newSizey / oldScrollValues.oldSizeY)
  f.scrollFrame.cursorX = f.scrollFrame.cursorX * (newSizex / oldScrollValues.oldSizeX)
  self:ZoomMap(0)
  db.scale = scale
  db.nonFullscreenScale = scale
end

function MDT:GetFullScreenSizes()
  local newSizey = GetScreenHeight() - 60 --top and bottom panel 30 each
  local newSizex = newSizey * (sizex / sizey)
  local isNarrow
  if newSizex + 251 > GetScreenWidth() then --251 sidebar
    newSizex = GetScreenWidth() - 251
    newSizey = newSizex * (sizey / sizex)
    isNarrow = true
  end
  local scale = newSizey / sizey --use this for adjusting NPC / POI positions later
  return newSizex, newSizey, scale, isNarrow
end

function MDT:SkinProgressBar(progressBar)
  local bar = progressBar and progressBar.Bar
  if not bar then return end
  bar.Icon:Hide()
  bar.IconBG:Hide()
end

function MDT:IsFrameOffScreen()
  local topPanel = MDT.main_frame.topPanel
  local bottomPanel = MDT.main_frame.bottomPanel
  local width = GetScreenWidth()
  local height = GetScreenHeight()
  local left = topPanel:GetLeft()     -->width
  local right = topPanel:GetRight()   --<0
  local bottom = topPanel:GetBottom() --<0
  local top = bottomPanel:GetTop()    -->height
  return left > width or right < 0 or bottom < 0 or top > height
end

local bottomTips = {
  [1] = L["Please report any bugs on https://github.com/Nnoggie/MythicDungeonTools/issues"],
  [2] = L["Hold CTRL to single-select enemies."],
  [3] = L["Hold SHIFT to create a new pull while selecting enemies."],
  [4] = L["Hold SHIFT to delete all presets with the delete preset button."],
  [5] = L["Right click a pull for more options."],
  [6] = L["Right click an enemy to open the enemy info window."],
  [7] = L["Drag the bottom right edge to resize MDT."],
  [8] = L["Click the fullscreen button for a maximized view of MDT."],
  [9] = L["Use /mdt reset to restore the default position and scale of MDT."],
  [10] = L["Mouseover the Live button while in a group to learn more about Live mode."],
  [11] = L["You are using MDT. You rock!"],
  [12] = L["You can choose from different color palettes in the automatic pull coloring settings menu."],
  [13] = L["You can cycle through different floors by holding CTRL and using the mousewheel."],
  [14] = L["altKeyGroupsTip"],
  [15] = L["Mouseover a patrolling enemy with a blue border to view the patrol path."],
  [16] = L["Expand the top toolbar to gain access to drawing and note features."],
  [17] = L["ConnectedTip"],
  [18] = L["EfficiencyScoreTip"],
  [19] = L["ctrlKeyCountTip"],
}

function MDT:UpdateBottomText()
  local f = self.main_frame.bottomPanelString
  if db.scale < 1 then
    f:SetText("")
    return
  end
  f:SetText(bottomTips[math.random(#bottomTips)])
end

function MDT:MakeTopBottomTextures(frame)
  frame:SetMovable(true)
  if frame.topPanel == nil then
    frame.topPanel = CreateFrame("Frame", "MDTTopPanel", frame)
    frame.topPanelTex = frame.topPanel:CreateTexture(nil, "BACKGROUND", nil, 0)
    frame.topPanelTex:SetAllPoints()
    frame.topPanelTex:SetDrawLayer(canvasDrawLayer, -5)
    frame.topPanelTex:SetColorTexture(unpack(MDT.BackdropColor))
    frame.topPanelString = frame.topPanel:CreateFontString("MDT name")
    frame.topPanelString:SetFontObject(GameFontNormalMed3)
    frame.topPanelString:SetTextColor(1, 1, 1, 1)
    frame.topPanelString:SetJustifyH("CENTER")
    frame.topPanelString:SetJustifyV("MIDDLE")
    --frame.topPanelString:SetWidth(600)
    frame.topPanelString:SetHeight(20)
    frame.topPanelString:SetText("Mythic Dungeon Tools")
    frame.topPanelString:ClearAllPoints()
    frame.topPanelString:SetPoint("CENTER", frame.topPanel, "CENTER", 10, 0)
    frame.topPanelString:Show()
    frame.topPanelString:SetFont(frame.topPanelString:GetFont() or '', 20, '')
    frame.topPanelLogo = frame.topPanel:CreateTexture(nil, "ARTWORK", nil, 7)
    frame.topPanelLogo:SetTexture("Interface\\AddOns\\"..AddonName.."\\Textures\\MDTFull")
    frame.topPanelLogo:SetWidth(30)
    frame.topPanelLogo:SetHeight(30)
    frame.topPanelLogo:SetPoint("RIGHT", frame.topPanelString, "LEFT", -5, -1)
    frame.topPanelLogo:Show()
  end

  frame.topPanel:ClearAllPoints()
  frame.topPanel:SetHeight(30)
  frame.topPanel:SetPoint("BOTTOMLEFT", frame, "TOPLEFT")
  frame.topPanel:SetPoint("BOTTOMRIGHT", frame, "TOPRIGHT")

  frame.topPanel:EnableMouse(true)
  frame.topPanel:RegisterForDrag("LeftButton")
  frame.topPanel:SetScript("OnDragStart", function(self, button)
    frame:SetMovable(true)
    frame:StartMoving()
  end)
  frame.topPanel:SetScript("OnDragStop", function(self, button)
    frame:StopMovingOrSizing()
    frame:SetMovable(false)
    if MDT:IsFrameOffScreen() then
      MDT:ResetMainFramePos(true)
    else
      local from, _, to, x, y = MDT.main_frame:GetPoint(nil)
      db.anchorFrom = from
      db.anchorTo = to
      db.xoffset, db.yoffset = x, y
    end
  end)

  if frame.bottomPanel == nil then
    frame.bottomPanel = CreateFrame("Frame", "MDTBottomPanel", frame)
    frame.bottomPanelTex = frame.bottomPanel:CreateTexture(nil, "BACKGROUND", nil, 0)
    frame.bottomPanelTex:SetAllPoints()
    frame.bottomPanelTex:SetDrawLayer(canvasDrawLayer, -5)
    frame.bottomPanelTex:SetColorTexture(unpack(MDT.BackdropColor))
  end

  frame.bottomPanel:ClearAllPoints()
  frame.bottomPanel:SetHeight(30)
  frame.bottomPanel:SetPoint("TOPLEFT", frame, "BOTTOMLEFT")
  frame.bottomPanel:SetPoint("TOPRIGHT", frame, "BOTTOMRIGHT")

  frame.bottomPanelString = frame.bottomPanel:CreateFontString("MDTMid")
  frame.bottomPanelString:SetFontObject(GameFontNormalSmall)
  frame.bottomPanelString:SetJustifyH("CENTER")
  frame.bottomPanelString:SetJustifyV("MIDDLE")
  frame.bottomPanelString:SetPoint("CENTER", frame.bottomPanel, "CENTER", 0, 0)
  frame.bottomPanelString:SetTextColor(1, 1, 1, 1)
  frame.bottomPanelString:Show()

  frame.bottomLeftPanelString = frame.bottomPanel:CreateFontString("MDTVersion")
  frame.bottomLeftPanelString:SetFontObject(GameFontNormalSmall)
  frame.bottomLeftPanelString:SetJustifyH("LEFT")
  frame.bottomLeftPanelString:SetJustifyV("MIDDLE")
  frame.bottomLeftPanelString:SetPoint("LEFT", frame.bottomPanel, "LEFT", 0, 0)
  frame.bottomLeftPanelString:SetTextColor(1, 1, 1, 1)
  ---@diagnostic disable-next-line: redundant-parameter
  frame.bottomLeftPanelString:SetText(" v"..C_AddOns.GetAddOnMetadata(AddonName, "Version"))
  frame.bottomLeftPanelString:Show()

  local externalButtonGroup = AceGUI:Create("SimpleGroup")
  MDT:FixAceGUIShowHide(externalButtonGroup, frame)
  externalButtonGroup.frame:ClearAllPoints()
  externalButtonGroup.frame:SetParent(frame.bottomPanel)
  if not externalButtonGroup.frame.SetBackdrop then
    Mixin(externalButtonGroup.frame, BackdropTemplateMixin)
  end
  externalButtonGroup.frame:SetBackdropColor(0, 0, 0, 0)
  externalButtonGroup:SetHeight(40)
  externalButtonGroup:SetPoint("LEFT", frame.bottomLeftPanelString, "RIGHT", 0, 0)
  externalButtonGroup:SetLayout("Flow")
  externalButtonGroup.frame:SetFrameStrata("High")
  externalButtonGroup.frame:SetFrameLevel(7)
  externalButtonGroup.frame:ClearBackdrop()
  frame.externalButtonGroup = externalButtonGroup

  for _, dest in ipairs(MDT.externalLinks) do
    local button = AceGUI:Create("Icon")
    button:SetImage(unpack(dest.texture))
    button:SetCallback("OnClick", function(widget, callbackName)
      MDT:ExportString(dest.url)
    end)
    button.tooltipText = dest.tooltip
    button:SetWidth(24)
    button:SetImageSize(20, 20)
    button:SetCallback("OnEnter", function(widget, callbackName)
      MDT:ToggleToolbarTooltip(true, widget, "ANCHOR_TOPLEFT")
    end)
    button:SetCallback("OnLeave", function()
      MDT:ToggleToolbarTooltip(false)
    end)
    externalButtonGroup:AddChild(button)
  end

  frame.statusString = frame.bottomPanel:CreateFontString("MDTStatusLabel")
  frame.statusString:SetFontObject(GameFontNormalSmall)
  frame.statusString:SetJustifyH("RIGHT")
  frame.statusString:SetJustifyV("MIDDLE")
  frame.statusString:SetPoint("RIGHT", frame.bottomPanel, "RIGHT", 0, 0)
  frame.statusString:SetTextColor(1, 1, 1, 1)
  frame.statusString:Hide()

  frame.bottomPanel:EnableMouse(true)
  frame.bottomPanel:RegisterForDrag("LeftButton")
  frame.bottomPanel:SetScript("OnDragStart", function(self, button)
    frame:SetMovable(true)
    frame:StartMoving()
  end)
  frame.bottomPanel:SetScript("OnDragStop", function(self, button)
    frame:StopMovingOrSizing()
    frame:SetMovable(false)
    if MDT:IsFrameOffScreen() then
      MDT:ResetMainFramePos(true)
    else
      ---@diagnostic disable-next-line: missing-parameter
      local from, _, to, x, y = MDT.main_frame:GetPoint()
      db.anchorFrom = from
      db.anchorTo = to
      db.xoffset, db.yoffset = x, y
    end
  end)
end

function MDT:MakeCopyHelper(frame)
  MDT.copyHelper = CreateFrame("Frame", "MDTCopyHelper", frame)
  MDT.copyHelper:SetFrameStrata("TOOLTIP")
  MDT.copyHelper:SetFrameLevel(200)
  MDT.copyHelper:SetHeight(100)
  MDT.copyHelper:SetWidth(300)
  MDT.copyHelper.tex = MDT.copyHelper:CreateTexture(nil, "BACKGROUND", nil, 0)
  MDT.copyHelper.tex:SetAllPoints()
  MDT.copyHelper.tex:SetColorTexture(unpack(MDT.BackdropColor))
  MDT.copyHelper.text = MDT.copyHelper:CreateFontString("MDT name")
  MDT.copyHelper.text:SetFontObject(GameFontNormalMed3)
  MDT.copyHelper.text:SetJustifyH("CENTER")
  MDT.copyHelper.text:SetJustifyV("MIDDLE")
  MDT.copyHelper.text:SetText(L["errorLabel3"])
  MDT.copyHelper.text:ClearAllPoints()
  MDT.copyHelper.text:SetPoint("CENTER", MDT.copyHelper, "CENTER")
  MDT.copyHelper.text:Show()
  MDT.copyHelper.text:SetFont(MDT.copyHelper.text:GetFont() or '', 20, '')
  MDT.copyHelper.text:SetTextColor(1, 1, 0)
  function MDT.copyHelper:SmartFadeOut(seconds)
    seconds = seconds or 0.3
    MDT.copyHelper.isFading = true
    MDT.copyHelper:SetAlpha(1)
    MDT.copyHelper:Show()
    UIFrameFadeOut(MDT.copyHelper, seconds, 1, 0)
    MDT.copyHelper.text:SetText(L["copiedToClipboard"])
    MDT.copyHelper.text:SetTextColor(1, 1, 1)
    MDT.copyHelper:SetScript("OnUpdate", nil)
    C_Timer.After(seconds, function()
      MDT.copyHelper.text:SetText(L["errorLabel3"])
      MDT.copyHelper.text:SetTextColor(1, 1, 0)
      MDT.copyHelper:Hide()
      MDT.copyHelper.isFading = false
    end)
  end

  function MDT.copyHelper:SmartShow(anchorFrame, x, y)
    MDT.copyHelper:ClearAllPoints()
    MDT.copyHelper:SetPoint("CENTER", anchorFrame, "CENTER", x, y)
    MDT.copyHelper:SetAlpha(1)
    MDT.copyHelper:Show()
    MDT.copyHelper:SetScript("OnUpdate", function()
      if IsControlKeyDown() then
        MDT.lastCtrlDown = GetTime()
      end
    end)
  end

  function MDT.copyHelper:SmartHide()
    if not MDT.copyHelper.isFading then MDT.copyHelper:Hide() end
  end

  --ctrl+c works when ctrl was released up to 0.5s before the c key
  function MDT.copyHelper:WasControlKeyDown()
    if IsControlKeyDown() then return true end
    if not MDT.lastCtrlDown then return false end
    return (GetTime() - MDT.lastCtrlDown) < 0.5
  end
end

function MDT:MakeSidePanel(frame)
  if frame.sidePanel == nil then
    frame.sidePanel = CreateFrame("Frame", "MDTSidePanel", frame)
    frame.sidePanelTex = frame.sidePanel:CreateTexture(nil, "BACKGROUND", nil, 0)
    frame.sidePanelTex:SetAllPoints()
    frame.sidePanelTex:SetDrawLayer(canvasDrawLayer, -5)
    frame.sidePanelTex:SetColorTexture(unpack(MDT.BackdropColor))
    frame.sidePanelTex:Show()
  end
  frame.sidePanel:EnableMouse(true)

  frame.sidePanel:ClearAllPoints()
  frame.sidePanel:SetWidth(251)
  frame.sidePanel:SetPoint("TOPLEFT", frame, "TOPRIGHT", 0, 30)
  frame.sidePanel:SetPoint("BOTTOMLEFT", frame, "BOTTOMRIGHT", 0, -30)

  frame.sidePanelString = frame.sidePanel:CreateFontString("MDTSidePanelText")
  frame.sidePanelString:SetFont("Fonts\\FRIZQT__.TTF", 10, "")
  frame.sidePanelString:SetTextColor(1, 1, 1, 1)
  frame.sidePanelString:SetJustifyH("LEFT")
  frame.sidePanelString:SetJustifyV("TOP")
  frame.sidePanelString:SetWidth(200)
  frame.sidePanelString:SetHeight(500)
  frame.sidePanelString:SetText("")
  frame.sidePanelString:ClearAllPoints()
  frame.sidePanelString:SetPoint("TOPLEFT", frame.sidePanel, "TOPLEFT", 33, -120 - 30 - 25)
  frame.sidePanelString:Hide()

  frame.sidePanel.WidgetGroup = AceGUI:Create("SimpleGroup")
  frame.sidePanel.WidgetGroup.frame:SetParent(frame.sidePanel)
  frame.sidePanel.WidgetGroup:SetWidth(245)
  frame.sidePanel.WidgetGroup:SetHeight(frame:GetHeight() + (frame.topPanel:GetHeight() * 2) - 31)
  frame.sidePanel.WidgetGroup:SetPoint("TOP", frame.sidePanel, "TOP", 3, 5)
  frame.sidePanel.WidgetGroup:SetLayout("Flow")

  frame.sidePanel.WidgetGroup.frame:SetFrameStrata(mainFrameStrata)
  if not frame.sidePanel.WidgetGroup.frame.SetBackdrop then
    Mixin(frame.sidePanel.WidgetGroup.frame, BackdropTemplateMixin)
  end
  frame.sidePanel.WidgetGroup.frame:SetBackdropColor(1, 1, 1, 0)
  frame.sidePanel.WidgetGroup.frame:Hide()

  --dirty hook to make widgetgroup show/hide
  local originalShow, originalHide = frame.Show, frame.Hide
  function frame:Show(...)
    frame.sidePanel.WidgetGroup.frame:Show()
    return originalShow(self, ...)
  end

  function frame:Hide(...)
    frame.sidePanel.WidgetGroup.frame:Hide()
    MDT.pullTooltip:Hide()
    return originalHide(self, ...)
  end

  --preset selection
  frame.sidePanel.WidgetGroup.PresetDropDown = AceGUI:Create("Dropdown")
  frame.sidePanel.WidgetGroup.PresetDropDown.pullout.frame:SetParent(frame.sidePanel.WidgetGroup.PresetDropDown.frame)
  local dropdown = frame.sidePanel.WidgetGroup.PresetDropDown
  dropdown.frame:SetWidth(170)
  dropdown.text:SetJustifyH("LEFT")
  dropdown:SetCallback("OnValueChanged", function(widget, callbackName, key)
    if db.presets[db.currentDungeonIdx][key].value == 0 then
      MDT:OpenNewPresetDialog()
      MDT.main_frame.sidePanelDeleteButton:SetDisabled(true)
      MDT.main_frame.sidePanelDeleteButton.text:SetTextColor(0.5, 0.5, 0.5)
    else
      if key == 1 then
        MDT.main_frame.sidePanelDeleteButton:SetDisabled(true)
        MDT.main_frame.sidePanelDeleteButton.text:SetTextColor(0.5, 0.5, 0.5)
      else
        if not MDT.liveSessionActive then
          MDT.main_frame.sidePanelDeleteButton:SetDisabled(false)
          MDT.main_frame.sidePanelDeleteButton.text:SetTextColor(1, 0.8196, 0)
        else
          MDT.main_frame.sidePanelDeleteButton:SetDisabled(true)
          MDT.main_frame.sidePanelDeleteButton.text:SetTextColor(0.5, 0.5, 0.5)
        end
      end
      db.currentPreset[db.currentDungeonIdx] = key
      --Set affix dropdown to preset week
      --frame.sidePanel.affixDropdown:SetAffixWeek(MDT:GetCurrentPreset().week or MDT:GetCurrentAffixWeek())
      --UpdateMap is called in SetAffixWeek, no need to call twice
      -- im not sure why this was left in here, but it was causing the map to update twice when changing presets
      -- MDT:UpdateMap()
      frame.sidePanel.affixDropdown:SetAffixWeek(MDT:GetCurrentPreset().week or MDT:GetCurrentAffixWeek() or 1)
    end
  end)
  MDT:UpdatePresetDropDown()
  frame.sidePanel.WidgetGroup:AddChild(dropdown)

  --Settings cogwheel
  frame.settingsCogwheel = AceGUI:Create("Icon")
  local settinggsCogwheel = frame.settingsCogwheel
  settinggsCogwheel:SetImage("Interface\\AddOns\\MythicDungeonTools\\Textures\\helpIconGrey")
  settinggsCogwheel:SetImageSize(25, 25)
  settinggsCogwheel:SetWidth(30)
  settinggsCogwheel:SetCallback("OnClick", function(...)
    self:ToggleSettingsDialog()
  end)
  frame.sidePanel.WidgetGroup:AddChild(frame.settingsCogwheel)

  local function anchorTooltip(anchorFrame)
    GameTooltip:SetOwner(anchorFrame, "ANCHOR_BOTTOMLEFT", -7, anchorFrame:GetHeight() + 3)
  end

  ---new profile,rename,export,delete
  local buttonWidth = 75
  frame.sidePanelNewButton = AceGUI:Create("Button")
  frame.sidePanelNewButton:SetText(L["New"])
  frame.sidePanelNewButton:SetWidth(buttonWidth)
  --button fontInstance
  local fontInstance = CreateFont("MDTButtonFont")
  if not fontInstance then return end
  fontInstance:CopyFontObject(frame.sidePanelNewButton.frame:GetNormalFontObject())
  local fontName, height = fontInstance:GetFont()
  fontInstance:SetFont(fontName, 10, "")
  frame.sidePanelNewButton.frame:SetNormalFontObject(fontInstance)
  frame.sidePanelNewButton.frame:SetHighlightFontObject(fontInstance)
  frame.sidePanelNewButton.frame:SetDisabledFontObject(fontInstance)
  frame.sidePanelNewButton:SetCallback("OnClick", function(widget, callbackName, value)
    MDT:OpenNewPresetDialog()
  end)
  frame.sidePanelNewButton.frame:SetScript("OnEnter", function()
    anchorTooltip(frame.sidePanelNewButton.frame)
    GameTooltip:AddLine(L["Create a new preset"], 1, 1, 1)
    GameTooltip:Show()
  end)
  frame.sidePanelNewButton.frame:SetScript("OnLeave", function()
    GameTooltip:Hide()
  end)

  frame.sidePanelRenameButton = AceGUI:Create("Button")
  frame.sidePanelRenameButton:SetWidth(buttonWidth)
  frame.sidePanelRenameButton:SetText(L["Rename"])
  frame.sidePanelRenameButton.frame:SetNormalFontObject(fontInstance)
  frame.sidePanelRenameButton.frame:SetHighlightFontObject(fontInstance)
  frame.sidePanelRenameButton.frame:SetDisabledFontObject(fontInstance)
  frame.sidePanelRenameButton:SetCallback("OnClick", function(widget, callbackName, value)
    MDT:HideAllDialogs()
    local currentPresetName = db.presets[db.currentDungeonIdx][db.currentPreset[db.currentDungeonIdx]].text
    MDT.main_frame.RenameFrame:Show()
    MDT.main_frame.RenameFrame.RenameButton:SetDisabled(true)
    MDT.main_frame.RenameFrame.RenameButton.text:SetTextColor(0.5, 0.5, 0.5)
    MDT.main_frame.RenameFrame:ClearAllPoints()
    MDT.main_frame.RenameFrame:SetPoint("CENTER", MDT.main_frame, "CENTER", 0, 50)
    MDT.main_frame.RenameFrame.Editbox:SetText(currentPresetName)
    MDT.main_frame.RenameFrame.Editbox:HighlightText(0, string.len(currentPresetName))
    MDT.main_frame.RenameFrame.Editbox:SetFocus()
  end)
  frame.sidePanelRenameButton.frame:SetScript("OnEnter", function()
    anchorTooltip(frame.sidePanelNewButton.frame)
    GameTooltip:AddLine(L["Rename the preset"], 1, 1, 1)
    GameTooltip:Show()
  end)
  frame.sidePanelRenameButton.frame:SetScript("OnLeave", function()
    GameTooltip:Hide()
  end)

  frame.sidePanelImportButton = AceGUI:Create("Button")
  frame.sidePanelImportButton:SetText(L["Import"])
  frame.sidePanelImportButton:SetWidth(buttonWidth)
  frame.sidePanelImportButton.frame:SetNormalFontObject(fontInstance)
  frame.sidePanelImportButton.frame:SetHighlightFontObject(fontInstance)
  frame.sidePanelImportButton.frame:SetDisabledFontObject(fontInstance)
  frame.sidePanelImportButton:SetCallback("OnClick", function(widget, callbackName, value)
    if InCombatLockdown() then
      print('MDT: '..L["Cannot import while in combat"])
      return
    end
    MDT:OpenImportPresetDialog()
  end)
  frame.sidePanelImportButton.frame:SetScript("OnEnter", function()
    anchorTooltip(frame.LinkToChatButton.frame)
    GameTooltip:AddLine(L["Import a preset from a text string"], 1, 1, 1)
    GameTooltip:Show()
  end)
  frame.sidePanelImportButton.frame:SetScript("OnLeave", function()
    GameTooltip:Hide()
  end)

  frame.sidePanelExportButton = AceGUI:Create("Button")
  frame.sidePanelExportButton:SetText(L["Export"])
  frame.sidePanelExportButton:SetWidth(buttonWidth)
  frame.sidePanelExportButton.frame:SetNormalFontObject(fontInstance)
  frame.sidePanelExportButton.frame:SetHighlightFontObject(fontInstance)
  frame.sidePanelExportButton.frame:SetDisabledFontObject(fontInstance)
  frame.sidePanelExportButton:SetCallback("OnClick", function(widget, callbackName, value)
    if InCombatLockdown() then
      print('MDT: '..L["Cannot export while in combat"])
      return
    end
    if db.colorPaletteInfo.forceColorBlindMode then MDT:ColorAllPulls(_, _, _, true) end
    local preset = MDT:GetCurrentPreset()
    MDT:SetUniqueID(preset)
    preset.difficulty = db.currentDifficulty
    preset.addonVersion = db.version
    local export = MDT:TableToString(preset, true, 5)
    MDT:HideAllDialogs()
    MDT.main_frame.ExportFrame:Show()
    MDT.main_frame.ExportFrame:ClearAllPoints()
    MDT.main_frame.ExportFrame:SetPoint("CENTER", MDT.main_frame, "CENTER", 0, 50)
    MDT.main_frame.ExportFrameEditbox:SetText(export)
    MDT.main_frame.ExportFrameEditbox:HighlightText(0, string.len(export))
    MDT.main_frame.ExportFrameEditbox:SetFocus()
    MDT.main_frame.ExportFrameEditbox:SetLabel(preset.text.." "..string.len(export))
    MDT.copyHelper:SmartShow(MDT.main_frame, 0, 50)
    if db.colorPaletteInfo.forceColorBlindMode then MDT:ColorAllPulls() end
  end)
  frame.sidePanelExportButton.frame:SetScript("OnEnter", function()
    anchorTooltip(frame.LinkToChatButton.frame)
    GameTooltip:AddLine(L["Export the preset as a text string"], 1, 1, 1)
    GameTooltip:AddLine(L["stringShareExternalWebsite"], 1, 1, 1, 1)
    GameTooltip:Show()
  end)
  frame.sidePanelExportButton.frame:SetScript("OnLeave", function()
    GameTooltip:Hide()
  end)

  frame.sidePanelDeleteButton = AceGUI:Create("Button")
  frame.sidePanelDeleteButton:SetText(L["Delete"])
  frame.sidePanelDeleteButton:SetWidth(buttonWidth)
  frame.sidePanelDeleteButton.frame:SetScript("OnEnter", function()
    anchorTooltip(frame.sidePanelNewButton.frame)
    GameTooltip:AddLine(L["Delete this preset"], 1, 1, 1)
    GameTooltip:AddLine(L["Shift-Click to delete all presets for this dungeon"], 1, 1, 1)
    GameTooltip:Show()
  end)
  frame.sidePanelDeleteButton.frame:SetScript("OnLeave", function()
    GameTooltip:Hide()
  end)
  frame.sidePanelDeleteButton.frame:SetNormalFontObject(fontInstance)
  frame.sidePanelDeleteButton.frame:SetHighlightFontObject(fontInstance)
  frame.sidePanelDeleteButton.frame:SetDisabledFontObject(fontInstance)
  frame.sidePanelDeleteButton:SetCallback("OnClick", function(widget, callbackName, value)
    if not widget.frame:IsEnabled() then return end
    if IsShiftKeyDown() then
      --delete all profiles
      local numPresets = self:CountPresets()
      local prompt = string.format(L["deleteAllWarning"], "\n", "\n", numPresets, "\n")
      MDT:OpenConfirmationFrame(450, 150, L["Delete ALL presets"], L["Delete"], prompt, MDT.DeleteAllPresets)
    else
      MDT:HideAllDialogs()
      frame.DeleteConfirmationFrame:ClearAllPoints()
      frame.DeleteConfirmationFrame:SetPoint("CENTER", MDT.main_frame, "CENTER", 0, 50)
      local currentPresetName = db.presets[db.currentDungeonIdx][db.currentPreset[db.currentDungeonIdx]].text
      frame.DeleteConfirmationFrame.label:SetText(string.format(L["Delete %s?"], currentPresetName))
      frame.DeleteConfirmationFrame:Show()
    end
  end)

  frame.LinkToChatButton = AceGUI:Create("Button")
  frame.LinkToChatButton:SetText(L["Share"])
  frame.LinkToChatButton:SetWidth(buttonWidth)
  frame.LinkToChatButton.frame:SetNormalFontObject(fontInstance)
  frame.LinkToChatButton.frame:SetHighlightFontObject(fontInstance)
  frame.LinkToChatButton.frame:SetDisabledFontObject(fontInstance)
  frame.LinkToChatButton:SetCallback("OnClick", function(widget, callbackName, value)
    local distribution = MDT:IsPlayerInGroup()
    if not distribution then return end
    local callback = function()
      frame.LinkToChatButton:SetDisabled(true)
      frame.LinkToChatButton.text:SetTextColor(0.5, 0.5, 0.5)
      frame.LiveSessionButton:SetDisabled(true)
      frame.LiveSessionButton.text:SetTextColor(0.5, 0.5, 0.5)
      frame.LinkToChatButton:SetText("...")
      frame.LiveSessionButton:SetText("...")
      MDT:SendToGroup(distribution)
    end
    MDT:CheckPresetSize(callback)
  end)
  frame.LinkToChatButton.frame:SetScript("OnEnter", function()
    anchorTooltip(frame.LinkToChatButton.frame)
    GameTooltip:AddLine(L["Share the preset with your party members"], 1, 1, 1)
    GameTooltip:Show()
  end)
  frame.LinkToChatButton.frame:SetScript("OnLeave", function()
    GameTooltip:Hide()
  end)
  local inGroup = UnitInRaid("player") or IsInGroup()
  MDT.main_frame.LinkToChatButton:SetDisabled(not inGroup)
  if inGroup then
    MDT.main_frame.LinkToChatButton.text:SetTextColor(1, 0.8196, 0)
  else
    MDT.main_frame.LinkToChatButton.text:SetTextColor(0.5, 0.5, 0.5)
  end

  frame.LiveSessionButton = AceGUI:Create("Button")
  frame.LiveSessionButton:SetText(L["Live"])
  frame.LiveSessionButton:SetWidth(buttonWidth)
  frame.LiveSessionButton.frame:SetNormalFontObject(fontInstance)
  frame.LiveSessionButton.frame:SetHighlightFontObject(fontInstance)
  frame.LiveSessionButton.frame:SetDisabledFontObject(fontInstance)
  local c1, c2, c3 = frame.LiveSessionButton.text:GetTextColor()
  frame.LiveSessionButton.normalTextColor = { r = c1, g = c2, b = c3, }
  frame.LiveSessionButton:SetCallback("OnClick", function(widget, callbackName, value)
    if MDT.liveSessionActive then
      MDT:LiveSession_Disable()
    else
      MDT:LiveSession_Enable()
    end
  end)
  frame.LiveSessionButton.frame:SetScript("OnEnter", function()
    anchorTooltip(frame.LinkToChatButton.frame)
    GameTooltip:AddLine(L["Start or join the current |cFF00FF00Live Session|r"], 1, 1, 1)
    GameTooltip:AddLine(L[
    "Clicking this button will attempt to join the ongoing Live Session of your group or create a new one if none is found"
    ], 1, 1, 1, 1)
    GameTooltip:AddLine(L[
    "The preset will continuously synchronize between all party members participating in the Live Session"], 1, 1, 1, 1)
    GameTooltip:AddLine(L[
    "Players can join the live session by either clicking this button or the Live Session chat link"], 1, 1, 1, 1)
    GameTooltip:AddLine(L[
    "To share a different preset while the live session is active simply navigate to the preferred preset and click the new 'Set to Live' Button next to the preset-dropdown"
    ], 1, 1, 1, 1)
    GameTooltip:AddLine(L[
    "You can always return to the current Live Session preset by clicking the 'Return to Live' button next to the preset-dropdown"
    ], 1, 1, 1, 1)
    GameTooltip:Show()
  end)
  frame.LiveSessionButton.frame:SetScript("OnLeave", function()
    GameTooltip:Hide()
  end)
  MDT.main_frame.LiveSessionButton:SetDisabled(not inGroup)
  if inGroup then
    MDT.main_frame.LiveSessionButton.text:SetTextColor(1, 0.8196, 0)
  else
    MDT.main_frame.LiveSessionButton.text:SetTextColor(0.5, 0.5, 0.5)
  end

  frame.sidePanel.WidgetGroup:AddChild(frame.sidePanelNewButton)
  frame.sidePanel.WidgetGroup:AddChild(frame.sidePanelRenameButton)
  frame.sidePanel.WidgetGroup:AddChild(frame.sidePanelDeleteButton)
  frame.sidePanel.WidgetGroup:AddChild(frame.LinkToChatButton)
  frame.sidePanel.WidgetGroup:AddChild(frame.sidePanelExportButton)
  frame.sidePanel.WidgetGroup:AddChild(frame.sidePanelImportButton)
  frame.sidePanel.WidgetGroup:AddChild(frame.LiveSessionButton)

  --Week Dropdown (Infested / Affixes)
  local function makeAffixString(week, affixes, longText)
    local ret
    local sep = ""
    for _, affixID in ipairs(affixes) do
      local name, _, filedataid = C_ChallengeMode.GetAffixInfo(affixID)
      name = name or L["Unknown"]
      filedataid = filedataid or 134400 --questionmark
      if longText then
        ret = ret or ""
        ret = ret..sep..name
        sep = ", "
      else
        ret = ret or week..(week > 9 and ". " or ".   ")
        if week == MDT:GetCurrentAffixWeek() then
          ret = WrapTextInColorCode(ret, "FF00FF00")
        end
        ret = ret..CreateTextureMarkup(filedataid, 64, 64, 20, 20, 0.1, 0.9, 0.1, 0.9, 0, 0).."  "
      end
    end
    --date
    local currentWeek = MDT:GetCurrentAffixWeek()
    if not longText and week ~= currentWeek then
      local deltaWeeks = week - currentWeek
      if deltaWeeks < 0 then deltaWeeks = deltaWeeks + #affixWeeks end
      local secondsInOneWeek = 604800
      local now = time()
      local secondsToReset = C_DateAndTime.GetSecondsUntilWeeklyReset()
      local reset = now + secondsToReset + (secondsInOneWeek * (deltaWeeks - 1))
      local monthDay = date("%b %d", reset)
      ret = ret.." "..monthDay
    end
    return ret
  end

  frame.sidePanel.affixDropdown = AceGUI:Create("Dropdown")
  frame.sidePanel.affixDropdown.pullout.frame:SetParent(frame.sidePanel.affixDropdown.frame)
  local affixDropdown = frame.sidePanel.affixDropdown
  affixDropdown.text:SetJustifyH("LEFT")
  affixDropdown:SetLabel(L["Affixes"])

  function affixDropdown:UpdateAffixList()
    local affixWeekMarkups = {}
    for week, affixes in ipairs(affixWeeks) do
      tinsert(affixWeekMarkups, makeAffixString(week, affixes))
    end
    local order = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 }
    affixDropdown:SetList(affixWeekMarkups, order)
    --mouseover list items
    for itemIdx, item in ipairs(affixDropdown.pullout.items) do
      item:SetOnEnter(function()
        GameTooltip:SetOwner(item.frame, "ANCHOR_LEFT", -11, -25)
        local v = affixWeeks[itemIdx]
        GameTooltip:SetText(makeAffixString(itemIdx, v, true), 1, 1, 1, 1)
        GameTooltip:Show()
      end)
      item:SetOnLeave(function()
        GameTooltip:Hide()
      end)
    end
  end

  function affixDropdown:SetAffixWeek(key, ignoreReloadPullButtons, ignoreUpdateProgressBar)
    affixDropdown:SetValue(key)
    if not MDT:GetCurrentAffixWeek() then
      frame.sidePanel.affixWeekWarning.image:Hide()
      frame.sidePanel.affixWeekWarning:SetDisabled(true)
    elseif MDT:GetCurrentAffixWeek() == key then
      frame.sidePanel.affixWeekWarning.image:Hide()
      frame.sidePanel.affixWeekWarning:SetDisabled(true)
    else
      frame.sidePanel.affixWeekWarning.image:Show()
      frame.sidePanel.affixWeekWarning:SetDisabled(false)
    end
    MDT:GetCurrentPreset().week = key
    local teeming = MDT:IsPresetTeeming(MDT:GetCurrentPreset())
    MDT:GetCurrentPreset().value.teeming = teeming

    if MDT.EnemyInfoFrame and MDT.EnemyInfoFrame.frame:IsShown() then MDT:UpdateEnemyInfoData() end
    MDT:UpdateMap(nil, ignoreReloadPullButtons, ignoreUpdateProgressBar)
  end

  affixDropdown:SetCallback("OnValueChanged", function(widget, callbackName, key)
    affixDropdown:SetAffixWeek(key)
    if MDT.liveSessionActive and MDT:GetCurrentPreset().uid == MDT.livePresetUID then
      MDT:LiveSession_SendAffixWeek(key)
    end
  end)
  affixDropdown:SetCallback("OnEnter", function(...)
    local selectedWeek = affixDropdown:GetValue()
    if not selectedWeek then return end
    GameTooltip:SetOwner(affixDropdown.frame, "ANCHOR_LEFT", -6, -41)
    local v = affixWeeks[selectedWeek]
    GameTooltip:SetText(makeAffixString(selectedWeek, v, true), 1, 1, 1, 1)
    GameTooltip:Show()
  end)
  affixDropdown:SetCallback("OnLeave", function(...)
    GameTooltip:Hide()
  end)

  -- frame.sidePanel.WidgetGroup:AddChild(affixDropdown)

  --affix not current week warning
  frame.sidePanel.affixWeekWarning = AceGUI:Create("Icon")
  local affixWeekWarning = frame.sidePanel.affixWeekWarning
  affixWeekWarning:SetImage("Interface\\DialogFrame\\UI-Dialog-Icon-AlertNew")
  affixWeekWarning:SetImageSize(25, 25)
  affixWeekWarning:SetWidth(30)
  affixWeekWarning:SetCallback("OnEnter", function(...)
    GameTooltip:SetOwner(affixDropdown.frame, "ANCHOR_CURSOR")
    GameTooltip:AddLine(L["The selected affixes are not the ones of the current week"], 1, 1, 1)
    GameTooltip:AddLine(L["Click to switch to current week"], 1, 1, 1)
    GameTooltip:Show()
  end)
  affixWeekWarning:SetCallback("OnLeave", function(...)
    GameTooltip:Hide()
  end)
  affixWeekWarning:SetCallback("OnClick", function(...)
    if not MDT:GetCurrentAffixWeek() then return end
    affixDropdown:SetAffixWeek(MDT:GetCurrentAffixWeek())
    if MDT.liveSessionActive and MDT:GetCurrentPreset().uid == MDT.livePresetUID then
      MDT:LiveSession_SendAffixWeek(MDT:GetCurrentAffixWeek())
    end
  end)
  affixWeekWarning.image:Hide()
  affixWeekWarning:SetDisabled(true)
  frame.sidePanel.WidgetGroup:AddChild(affixWeekWarning)

  --difficulty slider
  frame.sidePanel.DifficultySlider = AceGUI:Create("Slider")
  frame.sidePanel.DifficultySlider:SetSliderValues(1, 35, 1)
  frame.sidePanel.DifficultySlider:SetLabel(L["Dungeon Level"])
  frame.sidePanel.DifficultySlider.label:SetJustifyH("LEFT")
  frame.sidePanel.DifficultySlider.label:SetFontObject("GameFontNormalSmall")
  frame.sidePanel.DifficultySlider:SetWidth(200)
  frame.sidePanel.DifficultySlider:SetValue(db.currentDifficulty)
  local timer
  frame.sidePanel.DifficultySlider:SetCallback("OnValueChanged", function(widget, callbackName, value)
    local difficulty = tonumber(value)
    if (difficulty >= 10 and db.currentDifficulty < 10) or (difficulty < 10 and db.currentDifficulty >= 10) then
      db.currentDifficulty = difficulty or db.currentDifficulty
      MDT:DungeonEnemies_UpdateSeasonalAffix()
      frame.sidePanel.difficultyWarning:Toggle(difficulty)
      MDT:POI_UpdateAll()
      MDT:KillAllAnimatedLines()
      MDT:DrawAllAnimatedLines()
      MDT:ReloadPullButtons()
    else
      db.currentDifficulty = difficulty or db.currentDifficulty
    end
    MDT:GetCurrentPreset().difficulty = db.currentDifficulty
    MDT:UpdateProgressbar()
    if MDT.EnemyInfoFrame and MDT.EnemyInfoFrame.frame:IsShown() then MDT:UpdateEnemyInfoData() end
    if timer then timer:Cancel() end
    timer = C_Timer.NewTimer(2, function()
      MDT:ReloadPullButtons()
      if MDT.liveSessionActive then
        local livePreset = MDT:GetCurrentLivePreset()
        local shouldUpdate = livePreset == MDT:GetCurrentPreset()
        if shouldUpdate then MDT:LiveSession_SendDifficulty() end
      end
    end)
  end)
  frame.sidePanel.DifficultySlider:SetCallback("OnMouseUp", function()
    if timer then timer:Cancel() end
    MDT:ReloadPullButtons()
    if MDT.liveSessionActive then
      local livePreset = MDT:GetCurrentLivePreset()
      local shouldUpdate = livePreset == MDT:GetCurrentPreset()
      if shouldUpdate then MDT:LiveSession_SendDifficulty() end
    end
  end)
  frame.sidePanel.DifficultySlider:SetCallback("OnEnter", function()
    GameTooltip:SetOwner(frame.sidePanel.DifficultySlider.frame, "ANCHOR_BOTTOMLEFT", 0, 40)
    GameTooltip:AddLine(L["Select the dungeon level"], 1, 1, 1)
    GameTooltip:AddLine(L["The selected level will affect displayed npc health"], 1, 1, 1)
    GameTooltip:Show()
  end)
  frame.sidePanel.DifficultySlider:SetCallback("OnLeave", function()
    GameTooltip:Hide()
  end)
  frame.sidePanel.WidgetGroup:AddChild(frame.sidePanel.DifficultySlider)

  --dungeon level below 10 warning
  frame.sidePanel.difficultyWarning = AceGUI:Create("Icon")
  local difficultyWarning = frame.sidePanel.difficultyWarning
  difficultyWarning:SetImage("Interface\\DialogFrame\\UI-Dialog-Icon-AlertNew")
  difficultyWarning:SetImageSize(25, 25)
  difficultyWarning:SetWidth(30)
  difficultyWarning:SetCallback("OnEnter", function(...)
    GameTooltip:SetOwner(frame.sidePanel.DifficultySlider.frame, "ANCHOR_CURSOR")
    GameTooltip:AddLine(L["The selected dungeon level is below 10"], 1, 1, 1)
    GameTooltip:AddLine(L["Enemies related to seasonal affixes are currently hidden"], 1, 1, 1)
    GameTooltip:AddLine(L["Click to set dungeon level to 10"], 1, 1, 1)
    GameTooltip:Show()
  end)
  difficultyWarning:SetCallback("OnLeave", function(...)
    GameTooltip:Hide()
  end)
  difficultyWarning:SetCallback("OnClick", function(...)
    frame.sidePanel.DifficultySlider:SetValue(10)
    db.currentDifficulty = 10
    MDT:GetCurrentPreset().difficulty = db.currentDifficulty
    MDT:DungeonEnemies_UpdateSeasonalAffix()
    MDT:POI_UpdateAll()
    MDT:UpdateProgressbar()
    MDT:ReloadPullButtons()
    difficultyWarning:Toggle(db.currentDifficulty)
    if MDT.liveSessionActive then
      local livePreset = MDT:GetCurrentLivePreset()
      local shouldUpdate = livePreset == MDT:GetCurrentPreset()
      if shouldUpdate then MDT:LiveSession_SendDifficulty() end
    end
    MDT:KillAllAnimatedLines()
    MDT:DrawAllAnimatedLines()
  end)
  function difficultyWarning:Toggle(difficulty)
    if difficulty < 10 then
      self.image:Show()
      self:SetDisabled(false)
    else
      self.image:Hide()
      self:SetDisabled(true)
    end
  end

  difficultyWarning:Toggle(db.currentDifficulty)
  frame.sidePanel.WidgetGroup:AddChild(difficultyWarning)

  frame.sidePanel.middleLine = AceGUI:Create("Heading")
  frame.sidePanel.middleLine:SetWidth(240)
  frame.sidePanel.WidgetGroup:AddChild(frame.sidePanel.middleLine)
  frame.sidePanel.WidgetGroup.frame:SetFrameLevel(3)

  --progress bar
  frame.sidePanel.ProgressBar = CreateFrame("Frame", nil, frame.sidePanel, "ScenarioProgressBarTemplate")
  frame.sidePanel.ProgressBar:Show()
  frame.sidePanel.ProgressBar:ClearAllPoints()
  frame.sidePanel.ProgressBar:SetPoint("TOP", frame.sidePanel.WidgetGroup.frame, "BOTTOM", -10, 5)
  MDT:SkinProgressBar(frame.sidePanel.ProgressBar)
end

function MDT:UpdatePresetDropDown()
  local dropdown = MDT.main_frame.sidePanel.WidgetGroup.PresetDropDown
  local presetList = {}
  for k, v in pairs(db.presets[db.currentDungeonIdx]) do
    table.insert(presetList, k, v.text)
  end
  dropdown:SetList(presetList)
  dropdown:SetValue(db.currentPreset[db.currentDungeonIdx])
  dropdown:ClearFocus()
end

function MDT:UpdatePresetDropdownTextColor(forceReset)
  local preset = self:GetCurrentPreset()
  local livePreset = self:GetCurrentLivePreset()
  if self.liveSessionActive and preset == livePreset and (not forceReset) then
    local dropdown = MDT.main_frame.sidePanel.WidgetGroup.PresetDropDown
    dropdown.text:SetTextColor(0, 1, 0, 1)
  else
    local dropdown = MDT.main_frame.sidePanel.WidgetGroup.PresetDropDown
    dropdown.text:SetTextColor(1, 1, 1, 1)
  end
end

---FormatEnemyForces
function MDT:FormatEnemyForces(forces, forcesmax, progressbar)
  if not forcesmax then
    forcesmax = MDT:IsCurrentPresetTeeming() and MDT.dungeonTotalCount[db.currentDungeonIdx].teeming
        or MDT.dungeonTotalCount[db.currentDungeonIdx].normal
  end
  if db.enemyForcesFormat == 1 then
    if progressbar then return forces.."/"..forcesmax end
    return forces
  elseif db.enemyForcesFormat == 2 then
    if progressbar then return string.format((forces.."/"..forcesmax.." (%.2f%%)"), (forces / forcesmax) * 100) end
    return string.format(forces.." (%.2f%%)", (forces / forcesmax) * 100)
  end
end

---Progressbar_SetValue
---Sets the value/progress/color of the count progressbar to the apropriate data
function MDT:Progressbar_SetValue(self, totalCurrent, totalMax)
  local percent = (totalCurrent / totalMax) * 100
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
  local teeming = db.presets[db.currentDungeonIdx][db.currentPreset[db.currentDungeonIdx]].value.teeming
  MDT:EnsureDBTables()
  local grandTotal = MDT:CountForces()
  MDT:Progressbar_SetValue(MDT.main_frame.sidePanel.ProgressBar, grandTotal,
    teeming == true and MDT.dungeonTotalCount[db.currentDungeonIdx].teeming or
    MDT.dungeonTotalCount[db.currentDungeonIdx].normal)
end

function MDT:OnPan(cursorX, cursorY)
  local scrollFrame = MDTScrollFrame
  local scale = MDTMapPanelFrame:GetScale() / 1.5
  local deltaX = (scrollFrame.cursorX - cursorX) / scale
  local deltaY = (cursorY - scrollFrame.cursorY) / scale

  if (scrollFrame.panning) then
    local newHorizontalPosition = max(0, deltaX + scrollFrame:GetHorizontalScroll())
    newHorizontalPosition = min(newHorizontalPosition, scrollFrame.maxX)
    local newVerticalPosition = max(0, deltaY + scrollFrame:GetVerticalScroll())
    newVerticalPosition = min(newVerticalPosition, scrollFrame.maxY)
    scrollFrame:SetHorizontalScroll(newHorizontalPosition)
    scrollFrame:SetVerticalScroll(newVerticalPosition)
    scrollFrame.cursorX = cursorX
    scrollFrame.cursorY = cursorY

    scrollFrame.wasPanningLastFrame = true;
    scrollFrame.lastDeltaX = deltaX;
    scrollFrame.lastDeltaY = deltaY;
  else
    if (scrollFrame.wasPanningLastFrame) then
      scrollFrame.isFadeOutPanning = true
      scrollFrame.fadeOutXStart = scrollFrame.lastDeltaX
      scrollFrame.fadeOutYStart = scrollFrame.lastDeltaY
      scrollFrame.panDuration = 0

      scrollFrame.wasPanningLastFrame = false;
    end
  end
end

function MDT:OnPanFadeOut(deltaTime)
  local scrollFrame = MDTScrollFrame
  local panDuration = 0.5
  local panAtenuation = 7
  if (scrollFrame.isFadeOutPanning) then
    scrollFrame.panDuration = scrollFrame.panDuration + deltaTime

    local phase = scrollFrame.panDuration / panDuration
    local phaseLog = -math.log(phase)
    local stepX = (scrollFrame.fadeOutXStart * phaseLog) / panAtenuation
    local stepY = (scrollFrame.fadeOutYStart * phaseLog) / panAtenuation

    local newHorizontalPosition = max(0, stepX + scrollFrame:GetHorizontalScroll())
    newHorizontalPosition = min(newHorizontalPosition, scrollFrame.maxX)
    local newVerticalPosition = max(0, stepY + scrollFrame:GetVerticalScroll())
    newVerticalPosition = min(newVerticalPosition, scrollFrame.maxY)
    scrollFrame:SetHorizontalScroll(newHorizontalPosition)
    scrollFrame:SetVerticalScroll(newVerticalPosition)

    if (scrollFrame.panDuration > panDuration) then
      scrollFrame.isFadeOutPanning = false
    end
  end
end

function MDT:ExportCurrentZoomPanSettings()
  local zoom = MDTMapPanelFrame:GetScale()
  local panH = MDTScrollFrame:GetHorizontalScroll() / MDT:GetScale()
  local panV = MDTScrollFrame:GetVerticalScroll() / MDT:GetScale()

  local output = "        ["..db.presets[db.currentDungeonIdx][db.currentPreset[db.currentDungeonIdx]].value.currentSublevel.."] = {\n"
  output = output.."            zoomScale = "..zoom..";\n"
  output = output.."            horizontalPan = "..panH..";\n"
  output = output.."            verticalPan = "..panV..";\n"
  output = output.."        };\n"

  MDT:HideAllDialogs()
  MDT.main_frame.ExportFrame:Show()
  MDT.main_frame.ExportFrame:ClearAllPoints()
  MDT.main_frame.ExportFrame:SetPoint("CENTER", MDT.main_frame, "CENTER", 0, 50)
  MDT.main_frame.ExportFrameEditbox:SetText(output)
  MDT.main_frame.ExportFrameEditbox:HighlightText(0, string.len(output))
  MDT.main_frame.ExportFrameEditbox:SetFocus()
  MDT.main_frame.ExportFrameEditbox:SetLabel("Current pan/zoom settings");
end

function MDT:SetViewPortPosition(zoomScale, horizontalPan, verticalPan)
  local scaledSizeX = MDTMapPanelFrame:GetWidth() * zoomScale
  local scaledSizeY = MDTMapPanelFrame:GetHeight() * zoomScale
  MDTScrollFrame.maxX = (scaledSizeX - MDTMapPanelFrame:GetWidth()) / zoomScale
  MDTScrollFrame.maxY = (scaledSizeY - MDTMapPanelFrame:GetHeight()) / zoomScale
  MDTScrollFrame.zoomedIn = abs(zoomScale - 1) > 0.02
  MDTMapPanelFrame:SetScale(zoomScale)
  MDTScrollFrame:SetHorizontalScroll(horizontalPan * MDT:GetScale())
  MDTScrollFrame:SetVerticalScroll(verticalPan * MDT:GetScale())
end

function MDT:ZoomMapToDefault()
  local currentMap = db.presets[db.currentDungeonIdx]
  local currentSublevel = currentMap[db.currentPreset[db.currentDungeonIdx]].value.currentSublevel
  local mainFrame = MDTMapPanelFrame
  local scrollFrame = MDTScrollFrame

  local currentMapInfo = MDT.mapInfo[db.currentDungeonIdx]
  if (currentMapInfo and currentMapInfo.viewportPositionOverrides and currentMapInfo.viewportPositionOverrides[currentSublevel]) then
    local data = currentMapInfo.viewportPositionOverrides[currentSublevel];

    local scaledSizeX = mainFrame:GetWidth() * data.zoomScale
    local scaledSizeY = mainFrame:GetHeight() * data.zoomScale

    scrollFrame.maxX = (scaledSizeX - mainFrame:GetWidth()) / data.zoomScale
    scrollFrame.maxY = (scaledSizeY - mainFrame:GetHeight()) / data.zoomScale
    scrollFrame.zoomedIn = abs(data.zoomScale - 1) > 0.02

    mainFrame:SetScale(data.zoomScale)

    scrollFrame:SetHorizontalScroll(data.horizontalPan * MDT:GetScale())
    scrollFrame:SetVerticalScroll(data.verticalPan * MDT:GetScale())
  else
    scrollFrame.maxX = 1
    scrollFrame.maxY = 1
    scrollFrame.zoomedIn = false

    mainFrame:SetScale(1);

    scrollFrame:SetHorizontalScroll(0)
    scrollFrame:SetVerticalScroll(0)
  end
end

function MDT:ZoomMap(delta)
  local scrollFrame = MDTScrollFrame
  if not scrollFrame:GetLeft() then return end
  local oldScrollH = scrollFrame:GetHorizontalScroll()
  local oldScrollV = scrollFrame:GetVerticalScroll()

  local mainFrame = MDTMapPanelFrame

  local oldScale = mainFrame:GetScale()
  local newScale = oldScale + delta * 0.3

  newScale = max(1, newScale)
  newScale = min(15, newScale)

  mainFrame:SetScale(newScale)

  local scaledSizeX = mainFrame:GetWidth() * newScale
  local scaledSizeY = mainFrame:GetHeight() * newScale

  scrollFrame.maxX = (scaledSizeX - mainFrame:GetWidth()) / newScale
  scrollFrame.maxY = (scaledSizeY - mainFrame:GetHeight()) / newScale
  scrollFrame.zoomedIn = abs(newScale - 1) > 0.02

  local cursorX, cursorY = GetCursorPosition()
  local frameX = (cursorX / UIParent:GetScale()) - scrollFrame:GetLeft()
  local frameY = scrollFrame:GetTop() - (cursorY / UIParent:GetScale())
  local scaleChange = newScale / oldScale
  local newScrollH = (scaleChange * frameX - frameX) / newScale + oldScrollH
  local newScrollV = (scaleChange * frameY - frameY) / newScale + oldScrollV

  newScrollH = min(newScrollH, scrollFrame.maxX)
  newScrollH = max(0, newScrollH)
  newScrollV = min(newScrollV, scrollFrame.maxY)
  newScrollV = max(0, newScrollV)

  scrollFrame:SetHorizontalScroll(newScrollH)
  scrollFrame:SetVerticalScroll(newScrollV)

  MDT:SetPingOffsets(newScale)
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
  if not MouseIsOver(frame.sidePanel.pullButtonsScrollFrame.frame) then
    tooltip:Hide()
  elseif frame.sidePanel.newPullButton and MouseIsOver(frame.sidePanel.newPullButton.frame) then
    tooltip:Hide()
  else
    if frame.sidePanel.newPullButtons and tooltip.currentPull and frame.sidePanel.newPullButtons[tooltip.currentPull] then
      local showData

      local shroudedIcon = frame.sidePanel.newPullButtons[tooltip.currentPull].shroudedIcon
      local shroudedCounter = frame.sidePanel.newPullButtons[tooltip.currentPull].shroudedCounter
      if MouseIsOver(shroudedIcon) and shroudedIcon:IsShown() then
        tooltip.topString:SetText("\n\n\n\n"..L["Bounty stacks \nafter this pull"]..": "..shroudedCounter:GetText())
        local shroudedDisplayId = 101016
        if (not tooltip.modelNpcId or (tooltip.modelNpcId ~= shroudedDisplayId)) then
          tooltip.Model:SetDisplayInfo(shroudedDisplayId)
          tooltip.modelNpcId = shroudedDisplayId
        end
        showData = true
      end

      --enemy portraits
      for k, v in pairs(frame.sidePanel.newPullButtons[tooltip.currentPull].enemyPortraits) do
        if MouseIsOver(v) then
          if v:IsShown() then
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

            local totalForcesMax = MDT:IsCurrentPresetTeeming() and MDT.dungeonTotalCount[db.currentDungeonIdx].teeming or MDT.dungeonTotalCount[db.currentDungeonIdx].normal
            local count = MDT:IsCurrentPresetTeeming() and v.enemyData.teemingCount or v.enemyData.count
            text = text..L["Forces"]..": "..MDT:FormatEnemyForces(count, totalForcesMax, false)

            tooltip.topString:SetText(text)
            showData = true
          end
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
      local totalForcesMax = MDT:IsCurrentPresetTeeming() and MDT.dungeonTotalCount[db.currentDungeonIdx].teeming or
          MDT.dungeonTotalCount[db.currentDungeonIdx].normal

      local text = L["Forces"]..": "..MDT:FormatEnemyForces(pullForces, totalForcesMax, false)
      text = text.."\n"..L["Total"]..": "..MDT:FormatEnemyForces(totalForces, totalForcesMax, true)
      -- local pullHealth = MDT:SumCurrentPullHealth(tooltip.currentPull)
      -- text = text .. "\n" .. L["Efficiency Score"] .. ": " .. MDT:GetEfficiencyScoreString(pullForces, pullHealth)

      tooltip.botString:SetText(text)
      tooltip.botString:Show()
    end
  end
end

---CountForces
---Counts total selected enemy forces in the current preset up to pull
function MDT:CountForces(currentPull, currentOnly)
  --count up to and including the currently selected pull
  currentPull = currentPull or 1000
  local preset = self:GetCurrentPreset()
  local teeming = self:IsCurrentPresetTeeming()
  local pullCurrent = 0
  for pullIdx, pull in pairs(preset.value.pulls) do
    if not currentOnly or (currentOnly and pullIdx == currentPull) then
      if pullIdx <= currentPull then
        for enemyIdx, clones in pairs(pull) do
          if tonumber(enemyIdx) then
            for k, v in pairs(clones) do
              if MDT:IsCloneIncluded(enemyIdx, v) then
                local count = teeming
                    and self.dungeonEnemies[db.currentDungeonIdx][enemyIdx].teemingCount
                    or self.dungeonEnemies[db.currentDungeonIdx][enemyIdx].count
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
  currentPull = currentPull or 1000
  local preset = self:GetCurrentPreset()
  local totalHealth = 0
  for pullIdx, pull in pairs(preset.value.pulls) do
    if pullIdx == currentPull then
      for enemyIdx, clones in pairs(pull) do
        if tonumber(enemyIdx) then
          for k, v in pairs(clones) do
            if MDT:IsCloneIncluded(enemyIdx, v) then
              local health = self.dungeonEnemies[db.currentDungeonIdx][enemyIdx].health
              totalHealth = totalHealth + health
            end
          end
        end
      end
    end
  end
  return totalHealth
end

local emissaryIds = { [155432] = true, [155433] = true, [155434] = true }

---Checks if the specified clone is part of the current map configuration
function MDT:IsCloneIncluded(enemyIdx, cloneIdx)
  local preset = MDT:GetCurrentPreset()
  local enemy = MDT.dungeonEnemies[db.currentDungeonIdx][enemyIdx]
  local clone = enemy and enemy["clones"][cloneIdx]
  if not clone then return false end

  local week = self:GetEffectivePresetWeek()

  if db.currentSeason ~= 3 then
    if emissaryIds[enemy.id] then return false end
  elseif db.currentSeason ~= 4 then
    if enemy.corrupted then return false end
  end

  --shrouded
  local shroudedActive = db.currentSeason == 8 and db.currentDifficulty >= 10
  if shroudedActive then
    if clone.disguised then return false end
  else
    if clone.shrouded then return false end
  end


  --filter enemies out that have filters and conditions are not met
  local include = clone.include or enemy.include
  if include then
    local pass = {}
    if include.affix then
      local affixIncluded = false
      for _, value in pairs(affixWeeks[week]) do
        if value == include.affix then
          affixIncluded = true
        end
      end
      tinsert(pass, affixIncluded)
    end
    if include.level then
      local levelIncluded = db.currentDifficulty >= include.level
      tinsert(pass, levelIncluded)
    end
    --TODO: week
    local shouldInclude = true
    for _, v in pairs(pass) do
      shouldInclude = shouldInclude and v
    end
    if not shouldInclude then return false end
  end

  --beguiling weekly configuration
  local weekData = clone.week
  if weekData then
    if weekData[week] and not (clone.faction and clone.faction ~= preset.faction) and db.currentDifficulty >= 10 then
      return true
    else
      return false
    end
  end

  week = week % 3
  if week == 0 then week = 3 end
  local isBlacktoothWeek = week == 2

  if not clone.blacktoothEvent or isBlacktoothWeek then
    if not (clone.faction and clone.faction ~= preset.faction) then
      if MDT:IsCurrentPresetTeeming() or ((clone.teeming and clone.teeming == false) or (not clone.teeming)) then
        if not (MDT:IsCurrentPresetTeeming() and clone.negativeTeeming) then
          return true
        end
      end
    end
  end
end

---Returns true if the current preset has teeming turned on, false otherwise
function MDT:IsCurrentPresetTeeming()
  --return self:GetCurrentPreset().week
  return db.presets[db.currentDungeonIdx][db.currentPreset[db.currentDungeonIdx]].value.teeming
end

function MDT:IsCurrentPresetFortified()
  local currentWeek = self:GetCurrentPreset().week
  return affixWeeks[currentWeek][1] == 10 or
      affixWeeks[currentWeek][2] == 10 or
      affixWeeks[currentWeek][3] == 10 or
      affixWeeks[currentWeek][4] == 10
end

function MDT:IsCurrentPresetTyrannical()
  local currentWeek = self:GetCurrentPreset().week
  return affixWeeks[currentWeek][1] == 9 or
      affixWeeks[currentWeek][2] == 9 or
      affixWeeks[currentWeek][3] == 9 or
      affixWeeks[currentWeek][4] == 9
end

function MDT:IsCurrentPresetThundering()
  return affixWeeks[self:GetCurrentPreset().week][4] == 132
end

function MDT:MouseDownHook()

end

---Handles mouse-down events on the map scrollframe
MDT.OnMouseDown = function(self, button)
  local scrollFrame = MDT.main_frame.scrollFrame
  if scrollFrame.zoomedIn then
    scrollFrame.panning = true
    scrollFrame.cursorX, scrollFrame.cursorY = GetCursorPosition()
  end
  scrollFrame.oldX = scrollFrame.cursorX
  scrollFrame.oldY = scrollFrame.cursorY
  MDT:MouseDownHook()
end

---handles mouse-up events on the map scrollframe
MDT.OnMouseUp = function(self, button)
  local scrollFrame = MDT.main_frame.scrollFrame
  if scrollFrame.panning then scrollFrame.panning = false end

  --play minimap ping on right click at cursor position
  --only ping if we didnt pan
  if scrollFrame.oldX == scrollFrame.cursorX or scrollFrame.oldY == scrollFrame.cursorY then
    if button == "RightButton" then
      local x, y = MDT:GetCursorPosition()
      MDT:PingMap(x, y)
      local sublevel = MDT:GetCurrentSubLevel()
      if MDT.liveSessionActive then MDT:LiveSession_SendPing(x, y, sublevel) end
    end
  end
end

---Pings the map
function MDT:PingMap(x, y)
  -- self.ping:ClearAllPoints()
  -- self.ping:SetPoint("CENTER", self.main_frame.mapPanelTile1, "TOPLEFT", x, y)
  -- self.ping:SetModel("interface/minimap/ping/minimapping.m2")
  -- local mainFrame = MDTMapPanelFrame
  -- local mapScale = mainFrame:GetScale()
  -- self:SetPingOffsets(mapScale)
  -- self.ping:Show()
  -- UIFrameFadeOut(self.ping, 2, 1, 0)
  -- self.ping:SetSequence(0)
end

function MDT:SetPingOffsets(mapScale)
  --local scale = 0.35
  --local offset = (10.25 / 1000) * mapScale
  ---@diagnostic disable-next-line: redundant-parameter
  --self.ping:SetTransform(CreateVector3D(offset, offset, 0), CreateVector3D(0, 0, 0), scale)
end

---Sets the sublevel of the currently active preset, need to UpdateMap to reflect the change in UI
function MDT:SetCurrentSubLevel(sublevel)
  MDT:GetCurrentPreset().value.currentSublevel = sublevel
end

---Returns the current pull of the currently active preset
function MDT:GetCurrentPull()
  local selection = MDT:GetSelection()
  return selection[#selection]
end

---Returns the sublevel of the currently active preset
function MDT:GetCurrentSubLevel()
  return MDT:GetCurrentPreset().value.currentSublevel
end

---Returns the current preset
function MDT:GetCurrentPreset()
  return db.presets[db.currentDungeonIdx][db.currentPreset[db.currentDungeonIdx]]
end

function MDT:GetCurrentLivePreset()
  if not self.livePresetUID then return end
  if self.liveUpdateFrameOpen then
    for fullName, cachedPreset in pairs(self.transmissionCache) do
      if cachedPreset.uid == self.livePresetUID then
        return cachedPreset
      end
    end
  end
  for dungeonIdx, presets in pairs(db.presets) do
    for presetIdx, preset in pairs(presets) do
      if preset.uid and preset.uid == self.livePresetUID then
        return preset, presetIdx
      end
    end
  end
end

function MDT:GetEffectivePresetWeek(preset)
  preset = preset or self:GetCurrentPreset()
  local week
  week = preset.week
  return week
end

function MDT:GetEffectivePresetSeason(preset)
  local season = db.currentSeason
  return season
end

function MDT:ReturnToLivePreset()
  local preset, presetIdx = self:GetCurrentLivePreset()
  ---@diagnostic disable-next-line: need-check-nil
  self:UpdateToDungeon(preset.value.currentDungeonIdx, true)
  db.currentPreset[db.currentDungeonIdx] = presetIdx
  self:UpdatePresetDropDown()
  self:UpdateMap()
end

function MDT:SetLivePreset()
  local preset = self:GetCurrentPreset()
  local callback = function()
    self:SetUniqueID(preset)
    self.livePresetUID = preset.uid
    self:LiveSession_SendPreset(preset)
    self:UpdatePresetDropdownTextColor()
    self.main_frame.setLivePresetButton:Hide()
    self.main_frame.liveReturnButton:Hide()
  end
  MDT:CheckPresetSize(callback)
end

function MDT:CheckPresetSize(callback, cancelCallback, fireCancelOnClose)
  local presetSize = self:GetPresetSize(false, 5)
  if presetSize > 3500 then
    local timeToSend = 1 + math.max(presetSize - 2550, 0) / 255
    local prompt = string.format(L["LargePresetWarning"], timeToSend, "\n", "\n", "\n")
    MDT:OpenConfirmationFrame(450, 150, L["Sharing large preset"], "Share", prompt, callback, nil, cancelCallback, fireCancelOnClose)
  else
    callback()
  end
end

---Returns if the current week has an affix week set that includes the teeming affix
function MDT:IsWeekTeeming(week)
  if not week then week = MDT:GetCurrentAffixWeek() or 1 end
  return affixWeeks[week][1] == 5
end

---Returns if the current week has an affix weeks set that includes the inspiring affix
function MDT:IsWeekInspiring(week)
  if not week then week = MDT:GetCurrentAffixWeek() or 1 end
  return affixWeeks[week][1] == 122 or affixWeeks[week][2] == 122
end

---Returns if the preset is set to a week which contains the teeming affix
function MDT:IsPresetTeeming(preset)
  return MDT:IsWeekTeeming(preset.week)
end

function MDT:GetRiftOffsets()
  local week = self:GetEffectivePresetWeek()
  local preset = self:GetCurrentPreset()
  preset.value.riftOffsets = preset.value.riftOffsets or {}
  local riftOffsets = preset.value.riftOffsets
  riftOffsets[week] = riftOffsets[week] or {}
  return riftOffsets[week]
end

function MDT:MakeMapTexture(frame)
  MDT.contextMenuList = {}

  tinsert(MDT.contextMenuList, {
    text = "Close",
    notCheckable = 1,
    func = frame.contextDropdown:Hide()
  })

  -- Scroll Frame
  if frame.scrollFrame == nil then
    frame.scrollFrame = CreateFrame("ScrollFrame", "MDTScrollFrame", frame)
    frame.scrollFrame:ClearAllPoints()
    frame.scrollFrame:SetSize(sizex * db.scale, sizey * db.scale)
    --frame.scrollFrame:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, 0)
    frame.scrollFrame:SetAllPoints(frame)

    -- Enable mousewheel scrolling
    frame.scrollFrame:EnableMouseWheel(true)
    local lastModifiedScroll
    frame.scrollFrame:SetScript("OnMouseWheel", function(self, delta)
      if IsControlKeyDown() and IsShiftKeyDown() then
        if not lastModifiedScroll or lastModifiedScroll < GetTime() - 0.1 then
          lastModifiedScroll = GetTime()
          delta = delta * -1
          local target = MDT:GetCurrentSubLevel() + delta
          if MDT.dungeonSubLevels[db.currentDungeonIdx][target] then
            MDT:SetCurrentSubLevel(target)
            MDT:UpdateMap()
          end
        end
      else
        MDT:ZoomMap(delta)
      end
    end)

    --PAN
    frame.scrollFrame:EnableMouse(true)
    frame.scrollFrame:SetScript("OnMouseDown", MDT.OnMouseDown)
    frame.scrollFrame:SetScript("OnMouseUp", MDT.OnMouseUp)


    frame.scrollFrame:SetScript("OnUpdate", function(self, elapsed)
      local x, y = GetCursorPosition()
      MDT:OnPan(x, y)
      MDT:OnPanFadeOut(elapsed)
    end)

    if frame.mapPanelFrame == nil then
      frame.mapPanelFrame = CreateFrame("frame", "MDTMapPanelFrame", nil)
      frame.mapPanelFrame:ClearAllPoints()
      frame.mapPanelFrame:SetSize(sizex * db.scale, sizey * db.scale)
      --frame.mapPanelFrame:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, 0)
      frame.mapPanelFrame:SetAllPoints(frame)
    end

    --create the 12 tiles and set the scrollchild
    for i = 1, 12 do
      frame["mapPanelTile"..i] = frame.mapPanelFrame:CreateTexture("MDTmapPanelTile"..i, "BACKGROUND", nil, 0)
      frame["mapPanelTile"..i]:SetDrawLayer(canvasDrawLayer, 0)
      --frame["mapPanelTile"..i]:SetAlpha(0.3)
      frame["mapPanelTile"..i]:SetSize(frame:GetWidth() / 4 + (5 * db.scale), frame:GetWidth() / 4 + (5 * db.scale))
    end
    frame.mapPanelTile1:SetPoint("TOPLEFT", frame.mapPanelFrame, "TOPLEFT", 0, 0)
    frame.mapPanelTile2:SetPoint("TOPLEFT", frame.mapPanelTile1, "TOPRIGHT")
    frame.mapPanelTile3:SetPoint("TOPLEFT", frame.mapPanelTile2, "TOPRIGHT")
    frame.mapPanelTile4:SetPoint("TOPLEFT", frame.mapPanelTile3, "TOPRIGHT")
    frame.mapPanelTile5:SetPoint("TOPLEFT", frame.mapPanelTile1, "BOTTOMLEFT")
    frame.mapPanelTile6:SetPoint("TOPLEFT", frame.mapPanelTile5, "TOPRIGHT")
    frame.mapPanelTile7:SetPoint("TOPLEFT", frame.mapPanelTile6, "TOPRIGHT")
    frame.mapPanelTile8:SetPoint("TOPLEFT", frame.mapPanelTile7, "TOPRIGHT")
    frame.mapPanelTile9:SetPoint("TOPLEFT", frame.mapPanelTile5, "BOTTOMLEFT")
    frame.mapPanelTile10:SetPoint("TOPLEFT", frame.mapPanelTile9, "TOPRIGHT")
    frame.mapPanelTile11:SetPoint("TOPLEFT", frame.mapPanelTile10, "TOPRIGHT")
    frame.mapPanelTile12:SetPoint("TOPLEFT", frame.mapPanelTile11, "TOPRIGHT")

    --create the 150 large map tiles
    for i = 1, 10 do
      for j = 1, 15 do
        frame["largeMapPanelTile"..i..j] = frame.mapPanelFrame:CreateTexture("MDTLargeMapPanelTile"..i..j, "BACKGROUND")
        local tile = frame["largeMapPanelTile"..i..j]
        tile:SetDrawLayer(canvasDrawLayer, 5)
        tile:SetSize(frame:GetWidth() / 15, frame:GetWidth() / 15)
        if i == 1 and j == 1 then
          --to mapPanel
          tile:SetPoint("TOPLEFT", frame.mapPanelFrame, "TOPLEFT", 0, 0)
        elseif j == 1 then
          --to tile above
          tile:SetPoint("TOPLEFT", frame["largeMapPanelTile"..(i - 1)..j], "BOTTOMLEFT", 0, 0)
        else
          --to tile to the left
          tile:SetPoint("TOPLEFT", frame["largeMapPanelTile"..i..(j - 1)], "TOPRIGHT", 0, 0)
        end
        tile:SetColorTexture(i / 10, j / 10, 0, 1)
        tile:Hide()
      end
    end

    frame.scrollFrame:SetScrollChild(frame.mapPanelFrame)
    frame.scrollFrame.cursorX = 0
    frame.scrollFrame.cursorY = 0
    frame.scrollFrame.queuedDeltaX = 0;
    frame.scrollFrame.queuedDeltaY = 0;
  end
end

local function round(number, decimals)
  return tonumber((("%%.%df"):format(decimals)):format(number))
end

function MDT:CalculateEnemyHealth(boss, baseHealth, level, ignoreFortified)
  local fortified = MDT:IsCurrentPresetFortified()
  local tyrannical = MDT:IsCurrentPresetTyrannical()
  local thundering = MDT:IsCurrentPresetThundering()
  local mult = 1

  -- Adjust multipliers based on level and affixes
  if level >= 4 and level < 10 then
    -- For levels below 10, apply fortified if not a boss and not ignoring fortified
    if boss == false and fortified == true and (not ignoreFortified) then mult = mult * 1.2 end
    -- Apply tyrannical if it is a boss
    if boss == true and tyrannical == true then mult = mult * 1.25 end
  elseif level >= 10 and level < 12 then
    -- Source: https://www.wowhead.com/blue-tracker/topic/us/affix-system-updates-in-the-war-within-1882601
    -- For levels 10 and above but below 12, apply fixed multipliers regardless of affixes
    if boss == false then mult = mult * 1.2 end
    if boss == true then mult = mult * 1.25 end
  elseif level >= 12 then
    -- For levels 12 and above, apply an additional 10% health increase
    -- Xal'atath's Guile:Xal'atath betrays players, revoking her bargains and increasing the health and damage of enemies by 10%
    if boss == false then mult = mult * 1.2 * 1.1 end
    if boss == true then mult = mult * 1.25 * 1.1 end
  end


  if thundering == true then mult = mult * 1.05 end

  -- Levels 10 and below - 10% gain per level
  local levelsTenBelow = math.min(level, 10)
  mult = round((1.1 ^ math.max(levelsTenBelow - 1, 0)) * mult, 2)

  -- Levels 11 to 20 - 10% gain per level
  local levelsElevenAbove = math.max(math.min(level, 20) - 10, 0)
  mult = round((1.1 ^ levelsElevenAbove) * mult, 2)

  -- Levels 21 and above - 10% gain per level
  local levelsTwentyOneAbove = math.max(level - 20, 0)
  mult = round((1.1 ^ levelsTwentyOneAbove) * mult, 2)

  return round(mult * baseHealth, 0)
end

function MDT:ReverseCalcEnemyHealth(health, level, boss, fortified, tyrannical, thundering)
  local mult = 1

  -- Adjust multipliers based on level and affixes
  if level >= 4 and level < 10 then
    -- For levels below 10, apply fortified if not a boss
    if boss == false and fortified == true then mult = mult * 1.2 end
    -- Apply tyrannical if it is a boss
    if boss == true and tyrannical == true then mult = mult * 1.25 end
  elseif level >= 10 and level < 12 then
    -- For levels 10 and above but below 12, apply fixed multipliers regardless of affixes
    if boss == false then mult = mult * 1.2 end
    if boss == true then mult = mult * 1.25 end
  elseif level >= 12 then
    -- For levels 12 and above, apply an additional 10% health increase
    -- Source: https://www.wowhead.com/blue-tracker/topic/us/affix-system-updates-in-the-war-within-1882601
    if boss == false then mult = mult * 1.2 * 1.1 end
    if boss == true then mult = mult * 1.25 * 1.1 end
  end

  -- Apply thundering multiplier if present
  if thundering then mult = mult * 1.05 end

  -- Levels 10 and below - 8% gain per level
  local levelsTenBelow = math.min(level, 10)
  mult = round((1.1 ^ math.max(levelsTenBelow - 1, 0)) * mult, 2)

  -- Levels 11 to 20 - 10% gain per level
  local levelsElevenAbove = math.max(math.min(level, 20) - 10, 0)
  mult = round((1.1 ^ levelsElevenAbove) * mult, 2)

  -- Levels 21 and above - 8% gain per level
  local levelsTwentyOneAbove = math.max(level - 20, 0)
  mult = round((1.1 ^ levelsTwentyOneAbove) * mult, 2)

  local baseHealth = round(health / mult, 0)
  return baseHealth
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
    -- zh_TW ZH_CN
    if amount >= 1e8 then
      return string.format("%.2f亿", amount / 1e8)
    elseif amount >= 1e4 then
      return string.format("%d万", math.floor(amount / 1e4))
    else
      return amount -- 返回原数值
    end
  else
    -- 其他语言格式化
    if amount >= 1e12 then
      return string.format("%.3ft", amount / 1e12)
    elseif amount >= 1e9 then
      return string.format("%.3fb", amount / 1e9)
    elseif amount >= 1e6 then
      return string.format("%.2fm", amount / 1e6)
    elseif amount >= 1e3 then
      return string.format("%.1fk", amount / 1e3)
    else
      return amount -- 返回原数值
    end
  end
end

function MDT:HideAllDialogs()
  if MDT.main_frame then
    MDT.main_frame.presetCreationFrame:Hide()
    MDT.main_frame.presetImportFrame:Hide()
    MDT.main_frame.ExportFrame:Hide()
    MDT.main_frame.RenameFrame:Hide()
    MDT.main_frame.ClearConfirmationFrame:Hide()
    MDT.main_frame.DeleteConfirmationFrame:Hide()
    if MDT.main_frame.settingsFrame then
      MDT.main_frame.settingsFrame.CustomColorFrame:Hide()
      MDT.main_frame.settingsFrame:Hide()
    end
    if MDT.main_frame.ConfirmationFrame then MDT.main_frame.ConfirmationFrame:Hide() end
  end
  if MDT.tempConfirmationFrame then MDT.tempConfirmationFrame:Hide() end
end

function MDT:OpenImportPresetDialog()
  MDT:HideAllDialogs()
  MDT.main_frame.presetImportFrame:ClearAllPoints()
  MDT.main_frame.presetImportFrame:SetPoint("CENTER", MDT.main_frame, "CENTER", 0, 50)
  MDT.main_frame.presetImportFrame:Show()
  MDT.main_frame.presetImportBox:SetText("")
  MDT.main_frame.presetImportBox:SetFocus()
  MDT.main_frame.presetImportLabel:SetText(nil)
end

function MDT:OpenNewPresetDialog()
  MDT:HideAllDialogs()
  local presetList = {}
  local highestIndex = 1
  local countPresets = 0
  for k, v in pairs(db.presets[db.currentDungeonIdx]) do
    if v.text ~= L["<New Preset>"] then
      table.insert(presetList, k, v.text)
      local indexNumber = tonumber(v.text:match("^"..L["defaultPresetName"].."%s*(%d+)$"))
      if indexNumber and indexNumber > highestIndex then
        highestIndex = indexNumber
      end
      countPresets = countPresets + 1
    end
  end
  local newIndex = math.max(highestIndex, countPresets - 1)
  table.insert(presetList, 1, L["Empty"])
  MDT.main_frame.PresetCreationDropDown:SetList(presetList)
  MDT.main_frame.PresetCreationDropDown:SetValue(1)
  MDT.main_frame.PresetCreationEditbox:SetText(L["defaultPresetName"].." "..newIndex + 1)
  MDT.main_frame.presetCreationFrame:ClearAllPoints()
  MDT.main_frame.presetCreationFrame:SetPoint("CENTER", MDT.main_frame, "CENTER", 0, 50)
  MDT.main_frame.presetCreationFrame:SetStatusText("")
  MDT.main_frame.presetCreationFrame:Show()
  MDT.main_frame.presetCreationCreateButton:SetDisabled(false)
  MDT.main_frame.presetCreationCreateButton.text:SetTextColor(1, 0.8196, 0)
  MDT.main_frame.PresetCreationEditbox:SetFocus()
  MDT.main_frame.PresetCreationEditbox:HighlightText(0, 50)
  MDT.main_frame.presetImportBox:SetText("")
end

function MDT:OpenClearPresetDialog()
  MDT:HideAllDialogs()
  MDT.main_frame.ClearConfirmationFrame:ClearAllPoints()
  MDT.main_frame.ClearConfirmationFrame:SetPoint("CENTER", MDT.main_frame, "CENTER", 0, 50)
  local currentPresetName = db.presets[db.currentDungeonIdx][db.currentPreset[db.currentDungeonIdx]].text
  MDT.main_frame.ClearConfirmationFrame.label:SetText(string.format(L["Reset %s?"], currentPresetName))
  MDT.main_frame.ClearConfirmationFrame:Show()
end

function MDT:ToggleSettingsDialog()
  if not MDT.main_frame.settingsFrame then
    MDT:MakeSettingsFrame(MDT.main_frame)
    MDT:MakeCustomColorFrame(MDT.main_frame.settingsFrame)
  end
  if MDT.main_frame.settingsFrame:IsShown() then
    MDT.main_frame.settingsFrame:Hide()
  else
    MDT:HideAllDialogs()
    MDT.main_frame.settingsFrame:ClearAllPoints()
    MDT.main_frame.settingsFrame:SetPoint("CENTER", MDT.main_frame, "CENTER", 0, 50)
    MDT.main_frame.settingsFrame:SetStatusText("")
    MDT.main_frame.settingsFrame:Show()
    MDT.main_frame.settingsFrame.CustomColorFrame:Hide()
    if db.colorPaletteInfo.colorPaletteIdx == 6 then
      MDT:OpenCustomColorsDialog()
    end
  end
end

function MDT:OpenCustomColorsDialog()
  MDT:HideAllDialogs()
  MDT.main_frame.settingsFrame:Show() --Not the prettiest way to handle this, but it works.
  MDT.main_frame.settingsFrame.CustomColorFrame:ClearAllPoints()
  MDT.main_frame.settingsFrame.CustomColorFrame:SetPoint("TOPLEFT", MDT.main_frame.settingsFrame.frame, "TOPRIGHT", 1, 0)
  MDT.main_frame.settingsFrame.CustomColorFrame:SetStatusText("")
  MDT.main_frame.settingsFrame.CustomColorFrame:Show()
end

---Makes sure profiles are valid and have their fields set
function MDT:EnsureDBTables()
  --dungeonIdx doesnt exist
  local seasonList = MDT:GetSeasonList()
  if not MDT.dungeonList[db.currentDungeonIdx] or string.find(MDT.dungeonList[db.currentDungeonIdx], ">") or
      not db.selectedDungeonList or not seasonList[db.selectedDungeonList] then
    db.currentDungeonIdx = defaultSavedVars.global.currentDungeonIdx
    db.selectedDungeonList = defaultSavedVars.global.selectedDungeonList
  end
  local preset = MDT:GetCurrentPreset()
  if preset.value == 0 then --<New Preset> as selected preset
    db.presets[db.currentDungeonIdx] = {
      [1] = {
        text = L["Default"],
        value = {},
        objects = {},
        colorPaletteInfo = { autoColoring = true, colorPaletteIdx = 4 }
      },
      [2] = { text = L["<New Preset>"], value = 0 },
    }
    db.currentPreset[db.currentDungeonIdx] = 1
    preset = MDT:GetCurrentPreset()
  end
  if preset.objects then
    local isValid = true
    for _, obj in pairs(preset.objects) do
      if type(obj) ~= "table" then
        isValid = false
      end
    end
    if not isValid then
      preset.objects = nil
    end
  end
  if preset.week and (preset.week < 1 or preset.week > 10) then preset.week = nil end
  preset.week = preset.week or MDT:GetCurrentAffixWeek()
  db.currentPreset[db.currentDungeonIdx] = db.currentPreset[db.currentDungeonIdx] or 1
  db.presets[db.currentDungeonIdx][db.currentPreset[db.currentDungeonIdx]].value.currentDungeonIdx = db.currentDungeonIdx
  db.presets[db.currentDungeonIdx][db.currentPreset[db.currentDungeonIdx]].value.currentSublevel = db.presets[
  db.currentDungeonIdx][db.currentPreset[db.currentDungeonIdx]].value.currentSublevel or 1
  db.presets[db.currentDungeonIdx][db.currentPreset[db.currentDungeonIdx]].value.currentPull = db.presets[
  db.currentDungeonIdx][db.currentPreset[db.currentDungeonIdx]].value.currentPull or 1
  db.presets[db.currentDungeonIdx][db.currentPreset[db.currentDungeonIdx]].value.pulls = db.presets[db.currentDungeonIdx][db.currentPreset[db.currentDungeonIdx]].value.pulls or {}
  -- make sure, that at least 1 pull exists
  if #db.presets[db.currentDungeonIdx][db.currentPreset[db.currentDungeonIdx]].value.pulls == 0 then
    db.presets[db.currentDungeonIdx][db.currentPreset[db.currentDungeonIdx]].value.pulls[1] = {}
  end
  --ensure that there exists a map for the current sublevel
  local sublevel = MDT:GetCurrentSubLevel()
  if not MDT.dungeonMaps[db.currentDungeonIdx][sublevel] then
    db.presets[db.currentDungeonIdx][db.currentPreset[db.currentDungeonIdx]].value.currentSublevel = 1
  end

  --ensure the pulls table is not fully corrupted
  if not preset.value.pulls or (type(preset.value.pulls) ~= "table") then
    preset.value.pulls = {}
  else
    for pullIdx, pull in pairs(preset.value.pulls) do
      --detect gaps in pull list and delete invalid pulls
      if pullIdx == 0 or pullIdx > #preset.value.pulls then
        preset.value.pulls[pullIdx] = nil
      end
      --fix wrong indexes of clones within pulls
      for enemyIdx, clones in pairs(pull) do
        local assignmentIdx = 1
        if type(clones) == "table" then
          for actualIndex, cloneIdx in pairs(clones) do
            if actualIndex ~= assignmentIdx then
              clones[assignmentIdx] = cloneIdx
              clones[actualIndex] = nil
            end
            assignmentIdx = assignmentIdx + 1
          end
        end
      end
    end
  end

  -- Set current pull to last pull, if the actual current pull does not exists anymore
  if not
      db.presets[db.currentDungeonIdx][db.currentPreset[db.currentDungeonIdx]].value.pulls[
      db.presets[db.currentDungeonIdx][db.currentPreset[db.currentDungeonIdx]].value.currentPull] then
    db.presets[db.currentDungeonIdx][db.currentPreset[db.currentDungeonIdx]].value.currentPull = #
        db.presets[db.currentDungeonIdx][db.currentPreset[db.currentDungeonIdx]].value.pulls
  end

  for k, v in pairs(db.presets[db.currentDungeonIdx][db.currentPreset[db.currentDungeonIdx]].value.pulls) do
    if k == 0 then
      db.presets[db.currentDungeonIdx][db.currentPreset[db.currentDungeonIdx]].value.pulls[0] = nil
      break
    end
  end

  --removed clones: remove data from presets
  for pullIdx, pull in pairs(preset.value.pulls) do
    for enemyIdx, clones in pairs(pull) do
      if tonumber(enemyIdx) then
        --enemy does not exist at all anymore
        if not MDT.dungeonEnemies[db.currentDungeonIdx][enemyIdx] then
          pull[enemyIdx] = nil
        else
          --only clones
          for k, v in pairs(clones) do
            if not MDT.dungeonEnemies[db.currentDungeonIdx][enemyIdx]["clones"][v] then
              clones[k] = nil
            end
          end
        end
      end
    end
    pull["color"] = pull["color"] or db.defaultColor
  end

  MDT:GetCurrentPreset().week = MDT:GetCurrentPreset().week or MDT:GetCurrentAffixWeek()

  if db.currentDungeonIdx == 19 then
    local englishFaction = UnitFactionGroup("player")
    preset.faction       = preset.faction or (englishFaction and englishFaction == "Alliance") and 2 or 1
  end

  preset.difficulty = preset.difficulty or db.currentDifficulty

  --make sure sublevel actually exists for the dungeon
  --this might have been caused by bugged dropdowns in the past
  local maxSublevel = -1
  for _, _ in pairs(MDT.dungeonMaps[db.currentDungeonIdx]) do
    maxSublevel = maxSublevel + 1
  end
  if preset.value.currentSublevel > maxSublevel then preset.value.currentSublevel = maxSublevel end
  --make sure teeeming flag is set
  preset.value.teeming = MDT:IsWeekTeeming(preset.week)
end

function MDT:GetTileFormat(dungeonIdx, sublevel)
  local mapInfo = MDT.mapInfo[dungeonIdx]
  return mapInfo and mapInfo.tileFormat and mapInfo.tileFormat[sublevel] or 4
end

function MDT:UpdateMap(ignoreSetSelection, ignoreReloadPullButtons, ignoreUpdateProgressBar, async)
  MDT:CancelAsync("UpdateMap")
  MDT:CancelAsync("ReloadPullButtons")
  MDT:CancelAsync("DrawAllHulls")
  if not framesInitialized then coroutine.yield() end
  local mapName
  local frame = MDT.main_frame
  mapName = MDT.dungeonMaps[db.currentDungeonIdx][0]
  MDT:EnsureDBTables()
  if not framesInitialized then coroutine.yield() end
  local preset = MDT:GetCurrentPreset()
  if preset.difficulty then
    db.currentDifficulty = preset.difficulty
    frame.sidePanel.DifficultySlider:SetValue(db.currentDifficulty)
    frame.sidePanel.difficultyWarning:Toggle(db.currentDifficulty)
  end
  if not framesInitialized then coroutine.yield() end
  local textureInfo = MDT.dungeonMaps[db.currentDungeonIdx][preset.value.currentSublevel]
  if type(textureInfo) == "string" then --textures from blizzard files
    local path = "Interface\\WorldMap\\"..mapName.."\\"
    local tileFormat = MDT:GetTileFormat(db.currentDungeonIdx, preset.value.currentSublevel)
    if not framesInitialized then coroutine.yield() end
    for i = 1, 12 do
      if tileFormat == 4 then
        local texName = path..textureInfo..i
        if frame["mapPanelTile"..i] then
          frame["mapPanelTile"..i]:SetTexture(texName)
          frame["mapPanelTile"..i]:Show()
        end
      else
        if frame["mapPanelTile"..i] then
          frame["mapPanelTile"..i]:Hide()
        end
      end
    end
    if not framesInitialized then coroutine.yield() end
    for i = 1, 10 do
      for j = 1, 15 do
        if tileFormat == 15 then
          local texName = path..textureInfo..((i - 1) * 15 + j)
          frame["largeMapPanelTile"..i..j]:SetTexture(texName)
          frame["largeMapPanelTile"..i..j]:Show()
        else
          frame["largeMapPanelTile"..i..j]:Hide()
        end
      end
    end
  elseif type(textureInfo) == "table" then --textures from custom files
    local sublevel = preset.value.currentSublevel
    for i = 1, 12 do
      if frame["mapPanelTile"..i] then
        frame["mapPanelTile"..i]:Hide()
      end
    end
    for i = 1, 10 do
      for j = 1, 15 do
        local fileSuffix = (i - 1) * 15 + j
        local texName = textureInfo.customTextures..'\\'..sublevel..'_'..fileSuffix..".png"
        local tile = frame["largeMapPanelTile"..i..j]
        tile:SetTexture(texName)
        tile:Show()
      end
    end
  end
  if not framesInitialized then coroutine.yield() end
  MDT:Async(function()
    coroutine.yield()
    if not db.devMode then MDT:ZoomMapToDefault() end
    MDT:DungeonEnemies_UpdateEnemiesAsync()
    MDT:DungeonEnemies_UpdateTeeming()
    MDT:DungeonEnemies_UpdateSeasonalAffix()
    MDT:DungeonEnemies_UpdateInspiring()
    MDT:POI_UpdateAll()
    if not ignoreReloadPullButtons then
      MDT:ReloadPullButtons(true)
    end
    if not framesInitialized then coroutine.yield() end
    --handle delete button disable/enable
    local presetCount = 0
    for k, v in pairs(db.presets[db.currentDungeonIdx]) do
      presetCount = presetCount + 1
    end
    if (db.currentPreset[db.currentDungeonIdx] == 1 or db.currentPreset[db.currentDungeonIdx] == presetCount) or
        MDT.liveSessionActive then
      MDT.main_frame.sidePanelDeleteButton:SetDisabled(true)
      MDT.main_frame.sidePanelDeleteButton.text:SetTextColor(0.5, 0.5, 0.5)
    else
      MDT.main_frame.sidePanelDeleteButton:SetDisabled(false)
      MDT.main_frame.sidePanelDeleteButton.text:SetTextColor(1, 0.8196, 0)
    end
    if not framesInitialized then coroutine.yield() end
    --live mode
    local livePreset = MDT:GetCurrentLivePreset()
    if MDT.liveSessionActive and preset ~= livePreset then
      MDT.main_frame.liveReturnButton:Show()
      MDT.main_frame.setLivePresetButton:Show()
    else
      MDT.main_frame.liveReturnButton:Hide()
      MDT.main_frame.setLivePresetButton:Hide()
    end
    MDT:UpdatePresetDropdownTextColor()
    if not framesInitialized then coroutine.yield() end
    if not ignoreSetSelection then MDT:SetSelectionToPull(preset.value.currentPull) end
    MDT:UpdateDungeonDropDown()
    if not framesInitialized then coroutine.yield() end
    --frame.sidePanel.affixDropdown:SetAffixWeek(MDT:GetCurrentPreset().week,ignoreReloadPullButtons,ignoreUpdateProgressBar)
    frame.sidePanel.affixDropdown:SetValue(MDT:GetCurrentPreset().week)
    if not framesInitialized then coroutine.yield() end
    MDT:DrawAllPresetObjects()
    if not framesInitialized then coroutine.yield() end
    MDT:KillAllAnimatedLines()
    if not framesInitialized then coroutine.yield() end
    MDT:DrawAllAnimatedLines()
    if not framesInitialized then coroutine.yield() end
    MDT:UpdateProgressbar()
  end, "UpdateMap", true)
end

---Updates the map to the specified dungeon
function MDT:UpdateToDungeon(dungeonIdx, ignoreUpdateMap, init)
  if dungeonIdx == db.currentDungeonIdx then return end
  db.currentDungeonIdx = dungeonIdx
  if not db.presets[db.currentDungeonIdx][db.currentPreset[db.currentDungeonIdx]].value.currentSublevel then
    db.presets[db.currentDungeonIdx][db.currentPreset[db.currentDungeonIdx]].value.currentSublevel = 1
  end
  if init then return end
  MDT:UpdatePresetDropDown()
  if not ignoreUpdateMap then MDT:UpdateMap() end
  MDT:ZoomMapToDefault()
  --Colors the first pull in "Default" presets
  if db.currentPreset[db.currentDungeonIdx] == 1 then MDT:ColorPull() end
  MDT:UpdateProgressbar()
end

function MDT:DeletePreset(index)
  if index == 1 then return end
  tremove(db.presets[db.currentDungeonIdx], index)
  db.currentPreset[db.currentDungeonIdx] = index - 1
  MDT:UpdatePresetDropDown()
  MDT:UpdateMap()
end

--contains zoneIds to auto swap to corresponding dungeon when opening the AddOn
--ids are added in each dungeon file
--https://wowpedia.fandom.com/wiki/UiMapID
MDT.zoneIdToDungeonIdx = {}

local lastUpdatedDungeonIdx
function MDT:CheckCurrentZone(init)
  if C_ChallengeMode.IsChallengeModeActive() then return end
  local zoneId = C_Map.GetBestMapForUnit("player")
  local dungeonIdx = MDT.zoneIdToDungeonIdx[zoneId]
  if dungeonIdx and (not lastUpdatedDungeonIdx or dungeonIdx ~= lastUpdatedDungeonIdx) then
    lastUpdatedDungeonIdx = dungeonIdx
    MDT:UpdateToDungeon(dungeonIdx, nil, init)
  end
end

---Counts the number of presets of the current dungeon
function MDT:CountPresets()
  return #db.presets[db.currentDungeonIdx] - 2
end

---Deletes all presets from the current dungeon
function MDT:DeleteAllPresets()
  local countPresets = #db.presets[db.currentDungeonIdx] - 1
  for i = countPresets, 2, -1 do
    tremove(db.presets[db.currentDungeonIdx], i)
    db.currentPreset[db.currentDungeonIdx] = i - 1
  end
  MDT:UpdatePresetDropDown()
  MDT:UpdateMap()
end

function MDT:ClearPreset(preset, silent)
  if preset == self:GetCurrentPreset() then silent = false end
  table.wipe(preset.value.pulls)
  preset.value.currentPull = 1
  table.wipe(preset.value.riftOffsets)
  --MDT:DeleteAllPresetObjects()
  self:EnsureDBTables()
  if not silent then
    self:UpdateMap()
    self:ReloadPullButtons()
  end
  MDT:ColorPull()
end

function MDT:CreateNewPreset(name)
  if name == "<New Preset>" then
    MDT.main_frame.presetCreationLabel:SetText(string.format(L["Cannot create preset '%s'"], name))
    MDT.main_frame.presetCreationCreateButton:SetDisabled(true)
    MDT.main_frame.presetCreationCreateButton.text:SetTextColor(0.5, 0.5, 0.5)
    MDT.main_frame.presetCreationFrame:DoLayout()
    return
  end
  local duplicate = false
  local countPresets = 0
  for k, v in pairs(db.presets[db.currentDungeonIdx]) do
    countPresets = countPresets + 1
    if v.text == name then duplicate = true end
  end
  if duplicate == false then
    db.presets[db.currentDungeonIdx][countPresets + 1] = db.presets[db.currentDungeonIdx][countPresets] --put <New Preset> at the end of the list

    local startingPointPresetIdx = MDT.main_frame.PresetCreationDropDown:GetValue() - 1
    if startingPointPresetIdx > 0 then
      db.presets[db.currentDungeonIdx][countPresets] = MDT:CopyObject(db.presets[db.currentDungeonIdx][
      startingPointPresetIdx])
      db.presets[db.currentDungeonIdx][countPresets].text = name
      db.presets[db.currentDungeonIdx][countPresets].uid = nil
    else
      db.presets[db.currentDungeonIdx][countPresets] = { text = name, value = {} }
    end

    db.currentPreset[db.currentDungeonIdx] = countPresets
    MDT.main_frame.presetCreationFrame:Hide()
    MDT:UpdatePresetDropDown()
    MDT:UpdateMap()
    MDT:SetPresetColorPaletteInfo()
    MDT:ColorAllPulls()
  else
    MDT.main_frame.presetCreationLabel:SetText(string.format(L["Preset '%s' already exists"], name))
    MDT.main_frame.presetCreationCreateButton:SetDisabled(true)
    MDT.main_frame.presetCreationCreateButton.text:SetTextColor(0.5, 0.5, 0.5)
    MDT.main_frame.presetCreationFrame:DoLayout()
  end
end

function MDT:SanitizePresetName(text)
  --check if name is valid, block button if so, unblock if valid
  if text == "<New Preset>" then
    return false
  else
    local duplicate = false
    local countPresets = 0
    for k, v in pairs(db.presets[db.currentDungeonIdx]) do
      countPresets = countPresets + 1
      if v.text == text then duplicate = true end
    end
    return not duplicate and text or false
  end
end

function MDT:MakeChatPresetImportFrame(frame)
  frame.chatPresetImportFrame = AceGUI:Create("Frame")
  frame.chatPresetImportFrame.frame:SetParent(frame)
  frame.chatPresetImportFrame.frame:SetFrameStrata("DIALOG")
  local chatImport = frame.chatPresetImportFrame
  chatImport:SetTitle(L["Import Preset"])
  chatImport:SetWidth(400)
  chatImport:SetHeight(100)
  chatImport:EnableResize(false)
  chatImport:SetLayout("Flow")
  chatImport:SetCallback("OnClose", function(widget)
    MDT:UpdatePresetDropDown()
    if db.currentPreset[db.currentDungeonIdx] ~= 1 then
      MDT.main_frame.sidePanelDeleteButton:SetDisabled(false)
      MDT.main_frame.sidePanelDeleteButton.text:SetTextColor(1, 0.8196, 0)
    end
  end)
  chatImport.statustext:GetParent():Hide()
  chatImport.defaultText = L["Import Preset"]..":\n"
  chatImport.importLabel = AceGUI:Create("Label")
  chatImport.importLabel:SetText(chatImport.defaultText)
  chatImport.importLabel:SetWidth(250)
  --chatImport.importLabel:SetColor(1,0,0)

  chatImport.importButton = AceGUI:Create("Button")
  local importButton = chatImport.importButton
  importButton:SetText(L["Import"])
  importButton:SetWidth(100)
  importButton:SetCallback("OnClick", function()
    local newPreset = chatImport.currentPreset
    if MDT:ValidateImportPreset(newPreset) then
      chatImport:Hide()
      MDT:ImportPreset(MDT:DeepCopy(newPreset))
    else
      print(L["MDT: Error importing preset"])
    end
  end)
  chatImport:AddChild(chatImport.importLabel)
  chatImport:AddChild(importButton)
  chatImport:Hide()
end

function MDT:OpenChatImportPresetDialog(sender, preset, live)
  MDT:HideAllDialogs()
  local chatImport = MDT.main_frame.chatPresetImportFrame
  chatImport:ClearAllPoints()
  chatImport:SetPoint("CENTER", MDT.main_frame, "CENTER", 0, 50)
  chatImport.currentPreset = preset
  local dungeon = MDT:GetDungeonName(preset.value.currentDungeonIdx)
  local name = preset.text
  chatImport:Show()
  chatImport.importLabel:SetText(chatImport.defaultText..sender..": "..dungeon.." - "..name)
  chatImport:SetTitle(L["Import Preset"])
  chatImport.importButton:SetText(L["Import"])
  chatImport.live = nil
  if live then
    chatImport.importLabel:SetText(string.format(L["Join Live Session"], "\n", sender, dungeon, name))
    chatImport:SetTitle(L["Live Session"])
    chatImport.importButton:SetText(L["Join"])
    chatImport.live = true
  end
end

function MDT:MakePresetImportFrame(frame)
  frame.presetImportFrame = AceGUI:Create("Frame")
  frame.presetImportFrame.frame:SetParent(frame)
  frame.presetImportFrame.frame:SetFrameStrata("DIALOG")
  frame.presetImportFrame:SetTitle(L["Import Preset"])
  frame.presetImportFrame:SetWidth(400)
  frame.presetImportFrame:SetHeight(200)
  frame.presetImportFrame:EnableResize(false)
  frame.presetImportFrame:SetLayout("Flow")
  frame.presetImportFrame:SetCallback("OnClose", function(widget)
    MDT:UpdatePresetDropDown()
    if db.currentPreset[db.currentDungeonIdx] ~= 1 then
      MDT.main_frame.sidePanelDeleteButton:SetDisabled(false)
      MDT.main_frame.sidePanelDeleteButton.text:SetTextColor(1, 0.8196, 0)
    end
  end)
  frame.presetImportFrame.statustext:GetParent():Hide()

  frame.presetImportLabel = AceGUI:Create("Label")
  frame.presetImportLabel:SetText(nil)
  frame.presetImportLabel:SetWidth(390)
  frame.presetImportLabel:SetColor(1, 0, 0)

  local importString = ""
  frame.presetImportBox = AceGUI:Create("EditBox")
  local editbox = frame.presetImportBox
  editbox:SetLabel(L["Import Preset"]..":")
  editbox:SetWidth(255)
  editbox.OnTextChanged = function(widget, event, text) importString = text end
  editbox:SetCallback("OnTextChanged", editbox.OnTextChanged)
  editbox:DisableButton(true)
  local IMPORT_EXPORT_EDIT_MAX_BYTES = 0 --1024000*4 -- 0 appears to be "no limit"

  local pasteBuffer, pasteCharCount, isPasting = {}, 0, false

  local function clearBuffer(self)
    self:SetScript('OnUpdate', nil)
    editbox.editbox:SetMaxBytes(IMPORT_EXPORT_EDIT_MAX_BYTES)
    isPasting = false
    if InCombatLockdown() then
      print('MDT: '..L["Cannot import while in combat"])
      MDT:HideAllDialogs()
      return
    end
    if pasteCharCount > 10 then
      local pasteString = strtrim(table.concat(pasteBuffer))
      editbox:SetText(string.sub(pasteString, 1, 2000));
      local newPreset = MDT:StringToTable(pasteString, true)
      if MDT:ValidateImportPreset(newPreset) then
        MDT.main_frame.presetImportFrame:Hide()
        MDT:ImportPreset(newPreset)
        if db.colorPaletteInfo.forceColorBlindMode then
          MDT:ColorAllPulls()
        end
      else
        frame.presetImportLabel:SetText(L["Invalid import string"])
      end
    end
  end
  editbox.editbox:SetScript('OnChar', function(self, c)
    if not isPasting then
      if editbox.editbox:GetMaxBytes() ~= 1 then -- ensure this for performance!
        editbox.editbox:SetMaxBytes(1)
      end
      pasteBuffer, pasteCharCount, isPasting = {}, 0, true
      self:SetScript('OnUpdate', clearBuffer) -- clearBuffer on next frame
    end
    pasteCharCount = pasteCharCount + 1
    pasteBuffer[pasteCharCount] = c
  end)
  editbox.editbox:SetScript('OnKeyDown', function(_, key)
    -- have to use OnKeyDown here as OnKeyUp does not fire, AceGUI issue
    if key == "ESCAPE" then
      frame.presetImportFrame:Hide()
    end
  end);
  frame.presetImportFrame:AddChild(frame.presetImportBox)

  local importButton = AceGUI:Create("Button")
  importButton:SetText(L["Import"])
  importButton:SetWidth(100)
  importButton:SetCallback("OnClick", function()
    if InCombatLockdown() then
      print('MDT: '..L["Cannot import while in combat"])
      MDT:HideAllDialogs()
      return
    end
    local newPreset = MDT:StringToTable(importString, true)
    if MDT:ValidateImportPreset(newPreset) then
      MDT:HideAllDialogs()
      MDT:ImportPreset(newPreset)
      if db.colorPaletteInfo.forceColorBlindMode then
        MDT:ColorAllPulls()
      end
    else
      frame.presetImportLabel:SetText(L["Invalid import string"])
    end
  end)
  frame.presetImportButton = importButton
  frame.presetImportFrame:AddChild(importButton)
  frame.presetImportFrame:AddChild(frame.presetImportLabel)
  if db.devMode then
    local inspectButton = AceGUI:Create("Button")
    inspectButton:SetText("Inspect")
    inspectButton:SetWidth(100)
    inspectButton:SetCallback("OnClick", function()
      local newPreset = MDT:StringToTable(importString, true)
      if not ViragDevTool_AddData then
        print("MDT: Install Virag Dev Tool to inspect route")
      else
        ViragDevTool_AddData(newPreset)
      end
    end)
    frame.presetImportFrame:AddChild(inspectButton)
  end
  frame.presetImportFrame:Hide()
end

function MDT:MakePresetCreationFrame(frame)
  frame.presetCreationFrame = AceGUI:Create("Frame")
  frame.presetCreationFrame.frame:SetParent(frame)
  frame.presetCreationFrame.frame:SetFrameStrata("DIALOG")
  frame.presetCreationFrame:SetTitle(L["New Preset"])
  frame.presetCreationFrame:SetWidth(400)
  frame.presetCreationFrame:SetHeight(200)
  frame.presetCreationFrame:EnableResize(false)
  --frame.presetCreationFrame:SetCallback("OnClose", function(widget) AceGUI:Release(widget) end)
  frame.presetCreationFrame:SetLayout("Flow")
  frame.presetCreationFrame:SetCallback("OnClose", function(widget)
    MDT:UpdatePresetDropDown()
    if db.currentPreset[db.currentDungeonIdx] ~= 1 then
      MDT.main_frame.sidePanelDeleteButton:SetDisabled(false)
      MDT.main_frame.sidePanelDeleteButton.text:SetTextColor(1, 0.8196, 0)
    end
  end)
  frame.presetCreationFrame.statustext:GetParent():Hide()

  frame.PresetCreationEditbox = AceGUI:Create("EditBox")
  frame.PresetCreationEditbox:SetLabel(L["Preset Name"]..":")
  frame.PresetCreationEditbox:SetWidth(255)
  frame.PresetCreationEditbox:SetCallback("OnTextChanged", function(widget, event, text)
    --check if name is valid, block button if so, unblock if valid
    if MDT:SanitizePresetName(text) then
      frame.presetCreationLabel:SetText(nil)
      frame.presetCreationCreateButton:SetDisabled(false)
      frame.presetCreationCreateButton.text:SetTextColor(1, 0.8196, 0)
    else
      frame.presetCreationLabel:SetText(string.format(L["Cannot create preset '%s'"], text))
      frame.presetCreationCreateButton:SetDisabled(true)
      frame.presetCreationCreateButton.text:SetTextColor(0.5, 0.5, 0.5)
    end
    frame.presetCreationFrame:DoLayout()
  end)
  frame.PresetCreationEditbox:SetCallback("OnEnterPressed", function(widget, event, text)
    local name = frame.PresetCreationEditbox:GetText()
    if MDT:SanitizePresetName(name) then
      MDT:CreateNewPreset(name)
    end
  end)
  frame.presetCreationFrame:AddChild(frame.PresetCreationEditbox)

  frame.presetCreationCreateButton = AceGUI:Create("Button")
  frame.presetCreationCreateButton:SetText(L["Create"])
  frame.presetCreationCreateButton:SetWidth(100)
  frame.presetCreationCreateButton:SetCallback("OnClick", function()
    local name = frame.PresetCreationEditbox:GetText()
    MDT:CreateNewPreset(name)
  end)
  frame.presetCreationFrame:AddChild(frame.presetCreationCreateButton)

  frame.presetCreationLabel = AceGUI:Create("Label")
  frame.presetCreationLabel:SetText(nil)
  frame.presetCreationLabel:SetWidth(390)
  frame.presetCreationLabel:SetColor(1, 0, 0)
  frame.presetCreationFrame:AddChild(frame.presetCreationLabel)


  frame.PresetCreationDropDown = AceGUI:Create("Dropdown")
  frame.PresetCreationDropDown:SetLabel(L["Use as a starting point:"])
  frame.PresetCreationDropDown.text:SetJustifyH("LEFT")
  frame.presetCreationFrame:AddChild(frame.PresetCreationDropDown)

  frame.presetCreationFrame:Hide()
end

function MDT:ValidateImportPreset(preset)
  if type(preset) ~= "table" then return false end
  if not preset.text then return false end
  if not preset.value then return false end
  if type(preset.text) ~= "string" then return false end
  if type(preset.value) ~= "table" then return false end
  if not preset.value.currentDungeonIdx then return false end
  if not preset.value.currentPull then return false end
  if not preset.value.currentSublevel then return false end
  if not preset.value.pulls then return false end
  if type(preset.value.pulls) ~= "table" then return false end
  if not MDT.dungeonList[preset.value.currentDungeonIdx] then return false end
  return true
end

function MDT:ImportPreset(preset, fromLiveSession)
  --change dungeon to dungeon of the new preset
  self:UpdateToDungeon(preset.value.currentDungeonIdx, true)
  --search for uid
  local updateIndex
  local duplicatePreset
  for k, v in pairs(db.presets[db.currentDungeonIdx]) do
    if v.uid and v.uid == preset.uid then
      updateIndex = k
      duplicatePreset = v
      break
    end
  end

  local updateCallback = function()
    if self.main_frame.ConfirmationFrame then
      self.main_frame.ConfirmationFrame:SetCallback("OnClose", function()
      end)
    end
    db.presets[db.currentDungeonIdx][updateIndex] = preset
    db.currentPreset[db.currentDungeonIdx] = updateIndex
    self.liveUpdateFrameOpen = nil
    self:UpdatePresetDropDown()
    self:UpdateMap()
    if fromLiveSession then
      self.main_frame.SendingStatusBar:Hide()
      if self.main_frame.LoadingSpinner then
        self.main_frame.LoadingSpinner:Hide()
        self.main_frame.LoadingSpinner.Anim:Stop()
      end
    end
  end
  local copyCallback = function()
    if self.main_frame.ConfirmationFrame then
      self.main_frame.ConfirmationFrame:SetCallback("OnClose", function()
      end)
    end
    local name = preset.text
    local num = 2
    for k, v in pairs(db.presets[db.currentDungeonIdx]) do
      if name == v.text then
        name = preset.text.." "..num
        num = num + 1
      end
    end
    preset.text = name
    if fromLiveSession then
      if duplicatePreset then duplicatePreset.uid = nil end
    else
      preset.uid = nil
      MDT:SetUniqueID(preset)
    end
    local countPresets = 0
    for k, v in pairs(db.presets[db.currentDungeonIdx]) do
      countPresets = countPresets + 1
    end
    db.presets[db.currentDungeonIdx][countPresets + 1] = db.presets[db.currentDungeonIdx][countPresets] --put <New Preset> at the end of the list
    db.presets[db.currentDungeonIdx][countPresets] = preset
    db.currentPreset[db.currentDungeonIdx] = countPresets
    self.liveUpdateFrameOpen = nil
    self:UpdatePresetDropDown()
    self:UpdateMap()
    if fromLiveSession then
      self.main_frame.SendingStatusBar:Hide()
      if self.main_frame.LoadingSpinner then
        self.main_frame.LoadingSpinner:Hide()
        self.main_frame.LoadingSpinner.Anim:Stop()
      end
    end
  end
  local closeCallback = function()
    self.liveUpdateFrameOpen = nil
    self:LiveSession_Disable()
    self.main_frame.ConfirmationFrame:SetCallback("OnClose", function()
    end)
    if fromLiveSession then
      self.main_frame.SendingStatusBar:Hide()
      if self.main_frame.LoadingSpinner then
        self.main_frame.LoadingSpinner:Hide()
        self.main_frame.LoadingSpinner.Anim:Stop()
      end
    end
  end

  --open dialog to ask for replacing
  if updateIndex then
    local prompt = string.format(L["Earlier Version"], duplicatePreset.text, "\n", "\n", "\n", "\n")
    self:OpenConfirmationFrame(450, 150, L["Import Preset"], L["Update"], prompt, updateCallback, L["Copy"], copyCallback)
    if fromLiveSession then
      self.liveUpdateFrameOpen = true
      self.main_frame.ConfirmationFrame:SetCallback("OnClose", function() closeCallback() end)
    end
  else
    copyCallback()
  end
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

---Dropdown menu items for color settings frame
local colorPaletteNames = {
  [1] = L["Rainbow"],
  [2] = L["Black and Yellow"],
  [3] = L["Red, Green and Blue"],
  [4] = L["High Contrast"],
  [5] = L["Color Blind Friendly"],
  [6] = L["Custom"],
}

---Saves currently selected automatic coloring settings to the current
---This can be achieved easier, but it will increase the export text length significantly for non custom palettes.
function MDT:SetPresetColorPaletteInfo()
  local preset = MDT:GetCurrentPreset()
  preset.colorPaletteInfo = {}
  preset.colorPaletteInfo.autoColoring = db.colorPaletteInfo.autoColoring
  if preset.colorPaletteInfo.autoColoring then
    preset.colorPaletteInfo.colorPaletteIdx = db.colorPaletteInfo.colorPaletteIdx
    if preset.colorPaletteInfo.colorPaletteIdx == 6 then
      preset.colorPaletteInfo.customPaletteValues = db.colorPaletteInfo.customPaletteValues
      preset.colorPaletteInfo.numberCustomColors = db.colorPaletteInfo.numberCustomColors
    end
  end
  --Code below works, but in most cases it saves more data to the preset and thereby significantly increases the export string length
  --MDT:GetCurrentPreset().colorPaletteInfo = db.colorPaletteInfo
end

function MDT:GetPresetColorPaletteInfo(preset)
  preset = preset or MDT:GetCurrentPreset()
  if not preset.colorPaletteInfo then
    MDT:SetPresetColorPaletteInfo()
  end
  return preset.colorPaletteInfo
end

---Function executes full coloring of a pull and it's blips
function MDT:ColorPull(colorValues, pullIdx, preset, bypass, exportColorBlind) -- bypass can be passed as true to color even when automatic coloring is toggled off
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

---creates frame housing settings for user customized color palette
function MDT:MakeCustomColorFrame(frame)
  --Base frame for custom palette setup
  if not frame.CustomColorFrame then
    frame.CustomColorFrame = AceGUI:Create("Frame")
    frame.CustomColorFrame.frame:SetParent(frame.frame)
    frame.CustomColorFrame.frame:SetFrameStrata("DIALOG")
    frame.CustomColorFrame:SetTitle(L["Custom Color Palette"])
    frame.CustomColorFrame:SetWidth(290)
    frame.CustomColorFrame:SetHeight(220)
    frame.CustomColorFrame:EnableResize(false)
    frame.CustomColorFrame:SetLayout("Flow")
    frame.CustomColorFrame.statustext:GetParent():Hide()
    frame:AddChild(frame.CustomColorFrame)
    --Slider to adjust number of different colors and remake the frame OnMouseUp
    frame.CustomColorFrame.ColorSlider = AceGUI:Create("Slider")
    frame.CustomColorFrame.ColorSlider:SetSliderValues(2, 20, 1)
    frame.CustomColorFrame.ColorSlider:SetLabel(L["Choose number of colors"])
    frame.CustomColorFrame.ColorSlider:SetRelativeWidth(1)
    frame.CustomColorFrame:AddChild(frame.CustomColorFrame.ColorSlider)
    frame.CustomColorFrame.ColorPicker = {}
  end

  frame.CustomColorFrame.ColorSlider:SetValue(db.colorPaletteInfo.numberCustomColors)
  frame.CustomColorFrame.ColorSlider:SetCallback("OnMouseUp", function(event, callbackName, value)
    if value > 20 then
      db.colorPaletteInfo.numberCustomColors = 20
    elseif value < 2 then
      db.colorPaletteInfo.numberCustomColors = 2
    else
      db.colorPaletteInfo.numberCustomColors = value
    end
    MDT:SetPresetColorPaletteInfo()
    MDT:ReloadPullButtons()
    frame.CustomColorFrame:ReleaseChildren()
    frame.CustomColorFrame:Release()
    MDT:MakeCustomColorFrame(frame)
    MDT:OpenCustomColorsDialog()
  end)

  --Loop to create as many colorpickers as requested limited by db.colorPaletteInfo.numberCustomColors
  frame.CustomColorFrame:ReleaseChildren()

  for i = 1, db.colorPaletteInfo.numberCustomColors do
    frame.CustomColorFrame.ColorPicker[i] = frame.CustomColorFrame.ColorPicker[i] or AceGUI:Create("ColorPicker")
    if db.colorPaletteInfo.customPaletteValues[i] then
      frame.CustomColorFrame.ColorPicker[i]:SetColor(db.colorPaletteInfo.customPaletteValues[i][1],
        db.colorPaletteInfo.customPaletteValues[i][2], db.colorPaletteInfo.customPaletteValues[i][3])
    else
      db.colorPaletteInfo.customPaletteValues[i] = { 1, 1, 1 }
      frame.CustomColorFrame.ColorPicker[i]:SetColor(db.colorPaletteInfo.customPaletteValues[i][1],
        db.colorPaletteInfo.customPaletteValues[i][2], db.colorPaletteInfo.customPaletteValues[i][3])
    end
    frame.CustomColorFrame.ColorPicker[i]:SetLabel(" "..i)
    frame.CustomColorFrame.ColorPicker[i]:SetRelativeWidth(0.25)
    frame.CustomColorFrame.ColorPicker[i]:SetHeight(15)
    frame.CustomColorFrame.ColorPicker[i]:SetCallback("OnValueChanged", function(widget, event, r, g, b)
      db.colorPaletteInfo.customPaletteValues[i] = { r, g, b }
      MDT:SetPresetColorPaletteInfo()
      MDT:ReloadPullButtons()
    end)
    frame.CustomColorFrame:AddChild(frame.CustomColorFrame.ColorPicker[i])
  end
  frame.CustomColorFrame:Hide()
end

function MDT:MakeSettingsFrame(frame)
  frame.settingsFrame = AceGUI:Create("Frame")
  frame.settingsFrame.frame:SetParent(frame)
  frame.settingsFrame.frame:SetFrameStrata("DIALOG")
  frame.settingsFrame:SetTitle(L["Settings"])
  local frameWidth = 300
  frame.settingsFrame:SetWidth(frameWidth)
  frame.settingsFrame:SetHeight(350)
  frame.settingsFrame:EnableResize(false)
  frame.settingsFrame:SetLayout("Flow")
  frame.settingsFrame.statustext:GetParent():Hide()
  MDT:FixAceGUIShowHide(frame.settingsFrame, nil, nil, true)

  frame.minimapCheckbox = AceGUI:Create("CheckBox")
  frame.minimapCheckbox:SetLabel(L["Enable Minimap Button"])
  frame.minimapCheckbox:SetWidth(frameWidth - 10)
  frame.minimapCheckbox:SetValue(not db.minimap.hide)
  frame.minimapCheckbox:SetCallback("OnValueChanged", function(widget, callbackName, value)
    db.minimap.hide = not value
    if not db.minimap.hide then
      minimapIcon:Show("MythicDungeonTools")
    else
      minimapIcon:Hide("MythicDungeonTools")
    end
  end)
  frame.settingsFrame:AddChild(frame.minimapCheckbox)

  frame.compartmentCheckbox = AceGUI:Create("CheckBox")
  frame.compartmentCheckbox:SetLabel(L["Enable Compartment Button"])
  frame.compartmentCheckbox:SetWidth(frameWidth - 10)
  frame.compartmentCheckbox:SetValue(not db.minimap.compartmentHide)
  frame.compartmentCheckbox:SetCallback("OnValueChanged", function(widget, callbackName, value)
    db.minimap.compartmentHide = not value
    if not db.minimap.compartmentHide then
      minimapIcon:AddButtonToCompartment("MythicDungeonTools")
    else
      minimapIcon:RemoveButtonFromCompartment("MythicDungeonTools")
    end
  end)
  frame.settingsFrame:AddChild(frame.compartmentCheckbox)

  frame.forcesCheckbox = AceGUI:Create("CheckBox")
  frame.forcesCheckbox:SetLabel(L["Use forces count"])
  frame.forcesCheckbox:SetWidth(frameWidth - 10)
  frame.forcesCheckbox:SetValue(db.useForcesCount)
  frame.forcesCheckbox:SetCallback("OnValueChanged", function(widget, callbackName, value)
    db.useForcesCount = value
    MDT:ReloadPullButtons()
  end)
  frame.settingsFrame:AddChild(frame.forcesCheckbox)

  frame.AutomaticColorsCheck = AceGUI:Create("CheckBox")
  frame.AutomaticColorsCheck:SetLabel(L["Automatically color pulls"])
  frame.AutomaticColorsCheck:SetWidth(frameWidth - 10)
  frame.AutomaticColorsCheck:SetValue(db.colorPaletteInfo.autoColoring)
  frame.AutomaticColorsCheck:SetCallback("OnValueChanged", function(widget, callbackName, value)
    db.colorPaletteInfo.autoColoring = value
    MDT:SetPresetColorPaletteInfo()
    frame.toggleForceColorBlindMode:SetDisabled(not value)
    if value then
      MDT:ReloadPullButtons(true)
    end
  end)
  frame.settingsFrame:AddChild(frame.AutomaticColorsCheck)

  --Toggle local color blind mode
  frame.toggleForceColorBlindMode = AceGUI:Create("CheckBox")
  frame.toggleForceColorBlindMode:SetLabel(L["Local color blind mode"])
  frame.toggleForceColorBlindMode:SetWidth(frameWidth - 10)
  frame.toggleForceColorBlindMode:SetValue(db.colorPaletteInfo.forceColorBlindMode)
  frame.toggleForceColorBlindMode:SetCallback("OnValueChanged", function(widget, callbackName, value)
    db.colorPaletteInfo.forceColorBlindMode = value
    MDT:SetPresetColorPaletteInfo()
    MDT:ReloadPullButtons(true)
  end)
  frame.settingsFrame:AddChild(frame.toggleForceColorBlindMode)

  frame.PaletteSelectDropdown = AceGUI:Create("Dropdown")
  frame.PaletteSelectDropdown:SetList(colorPaletteNames)
  frame.PaletteSelectDropdown:SetLabel(L["Choose preferred color palette"])
  frame.PaletteSelectDropdown:SetWidth(frameWidth - 10)
  frame.PaletteSelectDropdown:SetValue(db.colorPaletteInfo.colorPaletteIdx)
  frame.PaletteSelectDropdown:SetCallback("OnValueChanged", function(widget, callbackName, value)
    if value == 6 then
      db.colorPaletteInfo.colorPaletteIdx = value
      MDT:OpenCustomColorsDialog()
    else
      MDT.main_frame.settingsFrame.CustomColorFrame:Hide()
      db.colorPaletteInfo.colorPaletteIdx = value
    end
    MDT:SetPresetColorPaletteInfo()
    MDT:ReloadPullButtons(true)
  end)
  frame.settingsFrame:AddChild(frame.PaletteSelectDropdown)

  -- The reason this button exists is to allow altering colorPaletteInfo of an imported preset
  -- Without the need to untoggle/toggle or swap back and forth in the PaletteSelectDropdown
  frame.button = AceGUI:Create("Button")
  frame.button:SetText(L["Apply to preset"])
  frame.button:SetWidth(frameWidth - 10)
  frame.button:SetCallback("OnClick", function(widget, callbackName)
    if not db.colorPaletteInfo.autoColoring then
      db.colorPaletteInfo.autoColoring = true
      frame.AutomaticColorsCheck:SetValue(db.colorPaletteInfo.autoColoring)
      frame.toggleForceColorBlindMode:SetDisabled(false)
    end
    MDT:SetPresetColorPaletteInfo()
    MDT:ReloadPullButtons(true)
  end)
  frame.settingsFrame:AddChild(frame.button)

  frame.localeHeading = AceGUI:Create("Heading")
  frame.localeHeading:SetText(L["Language"])
  frame.localeHeading:SetFullWidth(true)
  frame.settingsFrame:AddChild(frame.localeHeading)

  frame.localeButton = AceGUI:Create("Button")
  frame.localeButton:SetText(L["Change Language"])
  frame.localeButton:SetWidth(frameWidth - 10)
  local slashToFire = _G.SlashCmdList["ADDONLOCALE"]
  if not slashToFire then
    frame.localeButton:SetDisabled(true)
  else
    frame.localeButton:SetCallback("OnClick", function(widget, callbackName)
      slashToFire("")
    end)
  end
  frame.settingsFrame:AddChild(frame.localeButton)

  frame.localeLabel = AceGUI:Create("Label")
  if not slashToFire then
    frame.localeLabel:SetText("|cff808080"..L["localeButtonTooltip1"].."|r")
  else
    frame.localeLabel:SetText(L["localeButtonTooltip2"])
  end
  frame.settingsFrame:AddChild(frame.localeLabel)

  frame.settingsFrame:Hide()
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
  return table.getn(preset.value.pulls)
end

function MDT:CopyObject(obj, seen)
  if type(obj) ~= 'table' then return obj end
  if seen and seen[obj] then return seen[obj] end
  local s = seen or {}
  local res = setmetatable({}, getmetatable(obj))
  s[obj] = res
  for k, v in pairs(obj) do res[self:CopyObject(k, s)] = self:CopyObject(v, s) end
  return res
end

function MDT:PresetsSwapPulls(p1, p2)
  local p1copy = self:CopyObject(self:GetCurrentPreset().value.pulls[p1])
  local p2copy = self:CopyObject(self:GetCurrentPreset().value.pulls[p2])
  self:GetCurrentPreset().value.pulls[p1] = p2copy
  self:GetCurrentPreset().value.pulls[p2] = p1copy
end

function MDT:SetMapSublevel(pull)
  --set map sublevel
  local shouldResetZoom = false
  local lastSubLevel
  for enemyIdx, clones in pairs(db.presets[db.currentDungeonIdx][db.currentPreset[db.currentDungeonIdx]].value.pulls[
  pull]) do
    if tonumber(enemyIdx) then
      for idx, cloneIdx in pairs(clones) do
        if MDT.dungeonEnemies[db.currentDungeonIdx][enemyIdx]["clones"][cloneIdx] then
          lastSubLevel = MDT.dungeonEnemies[db.currentDungeonIdx][enemyIdx]["clones"][cloneIdx].sublevel
        end
      end
    end
  end
  if lastSubLevel then
    shouldResetZoom = db.presets[db.currentDungeonIdx][db.currentPreset[db.currentDungeonIdx]].value.currentSublevel ~=
        lastSubLevel
    db.presets[db.currentDungeonIdx][db.currentPreset[db.currentDungeonIdx]].value.currentSublevel = lastSubLevel
    if shouldResetZoom then
      MDT:UpdateMap(true, true, true)
    end
  end

  MDT:UpdateDungeonDropDown()
  return shouldResetZoom
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
                enemyTable[enemyTableIdx].teemingCount = MDT.dungeonEnemies[db.currentDungeonIdx][enemyIdx]["teemingCount"]
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

  --display reaping icon
  local pullForces = MDT:CountForces(idx, false)
  local totalForcesMax = MDT:IsCurrentPresetTeeming() and MDT.dungeonTotalCount[db.currentDungeonIdx].teeming or
      MDT.dungeonTotalCount[db.currentDungeonIdx].normal
  local currentPercent = pullForces / totalForcesMax
  local oldPullForces
  if idx == 1 then
    oldPullForces = 0
  else
    oldPullForces = MDT:CountForces(idx - 1, false)
  end
  local oldPercent = oldPullForces / totalForcesMax
  frame.newPullButtons[idx]:ShowReapingIcon(false, pullForces, oldPullForces, totalForcesMax)
  --prideful icon
  if (math.floor(currentPercent / 0.2) > math.floor(oldPercent / 0.2)) and oldPercent < 1 and db.currentSeason == 5 then
    frame.newPullButtons[idx]:ShowPridefulIcon(true, pullForces, oldPullForces, totalForcesMax)
  else
    frame.newPullButtons[idx]:ShowPridefulIcon(false, pullForces, oldPullForces, totalForcesMax)
  end
  --shrouded icon
  --count amount of shrouded in this pull
  local shroudedCount = 0
  if preset.value.pulls[idx] then
    for enemyIdx, clones in pairs(preset.value.pulls[idx]) do
      if tonumber(enemyIdx) then
        if MDT.dungeonEnemies[db.currentDungeonIdx][enemyIdx] then
          for k, cloneIdx in pairs(clones) do
            local cloneData = MDT.dungeonEnemies[db.currentDungeonIdx][enemyIdx]["clones"][cloneIdx]
            if cloneData and cloneData.shrouded then
              -- count zul'gamux as 3
              if MDT.dungeonEnemies[db.currentDungeonIdx][enemyIdx].id == 190128 then
                shroudedCount = shroudedCount + 3
              else
                shroudedCount = shroudedCount + 1
              end
            end
          end
        end
      end
    end
  end
  if shroudedCount > 0 then
    -- count amount of shrouded in all previous pulls
    local shroudedCountAllPrevious = 1 -- get one buff stack for free
    for i = 1, idx - 1 do
      if preset.value.pulls[i] then
        for enemyIdx, clones in pairs(preset.value.pulls[i]) do
          if tonumber(enemyIdx) then
            if MDT.dungeonEnemies[db.currentDungeonIdx][enemyIdx] then
              for k, cloneIdx in pairs(clones) do
                local cloneData = MDT.dungeonEnemies[db.currentDungeonIdx][enemyIdx]["clones"][cloneIdx]
                if cloneData and cloneData.shrouded then
                  -- count zul'gamux as 3
                  if MDT.dungeonEnemies[db.currentDungeonIdx][enemyIdx].id == 190128 then
                    shroudedCountAllPrevious = shroudedCountAllPrevious + 3
                  else
                    shroudedCountAllPrevious = shroudedCountAllPrevious + 1
                  end
                end
              end
            end
          end
        end
      end
    end
    frame.newPullButtons[idx]:ShowShroudedIcon(true, shroudedCountAllPrevious + shroudedCount)
  else
    frame.newPullButtons[idx]:ShowShroudedIcon(false)
  end

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

---Creates a new pull in the current preset and calls ReloadPullButtons to reflect the change in the scrollframe
function MDT:AddPull(index)
  MDT:PresetsAddPull(index)
  MDT:ReloadPullButtons()
  MDT:SetSelectionToPull(index)
end

function MDT:SetAutomaticColor(index)
  --if not db.colorPaletteInfo.autoColoring then return end

  local H = (index - 1) * 360 / 12 + 120 --db.automaticColorsNum
  --if db.alternatingColors and index % 2 == 0 then
  --	H = H + 180
  --end

  local V = 1 --0.5451
  --if db.brightColors then V = 1 end

  local r, g, b = self:HSVtoRGB(H, 0.7554, V)

  --self:DungeonEnemies_SetPullColor(index, r, g, b)
  --self:UpdatePullButtonColor(index, r, g, b)
  --self:DungeonEnemies_UpdateBlipColors(index, r, g, b)
  --if self.liveSessionActive and self:GetCurrentPreset().uid == self.livePresetUID then
  --	self:LiveSession_QueueColorUpdate()
  --end
end

function MDT:UpdateAutomaticColors(index)
  if not db.colorPaletteInfo.autoColoring then return end
  for i = index or 1, self:GetPullsNum() do
    self:SetAutomaticColor(i)
  end
end

---Clears all the npcs out of a pull
function MDT:ClearPull(index)
  table.wipe(db.presets[db.currentDungeonIdx][db.currentPreset[db.currentDungeonIdx]].value.pulls[index])
  MDT:EnsureDBTables()
  MDT:ReloadPullButtons()
  MDT:SetSelectionToPull(index)
  --MDT:SetAutomaticColor(index)
end

---Moves the selected pull up
function MDT:MovePullUp(index)
  MDT:PresetsSwapPulls(index, index - 1)
  MDT:ReloadPullButtons()
  MDT:SetSelectionToPull(index - 1)
  --MDT:UpdateAutomaticColors(index - 1)
end

---Moves the selected pull down
function MDT:MovePullDown(index)
  MDT:PresetsSwapPulls(index, index + 1)
  MDT:ReloadPullButtons()
  MDT:SetSelectionToPull(index + 1)
  --MDT:UpdateAutomaticColors(index)
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
  --self:UpdateAutomaticColors(index)
end

function MDT:RenamePreset(renameText)
  db.presets[db.currentDungeonIdx][db.currentPreset[db.currentDungeonIdx]].text = renameText
  MDT.main_frame.RenameFrame:Hide()
  MDT:UpdatePresetDropDown()
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

function MDT:MakeRenameFrame(frame)
  frame.RenameFrame = AceGUI:Create("Frame")
  frame.RenameFrame.frame:SetParent(frame)
  frame.RenameFrame.frame:SetFrameStrata("DIALOG")
  frame.RenameFrame:SetTitle(L["Rename Preset"])
  frame.RenameFrame:SetWidth(350)
  frame.RenameFrame:SetHeight(150)
  frame.RenameFrame:EnableResize(false)
  frame.RenameFrame:SetLayout("Flow")
  frame.RenameFrame:SetCallback("OnClose", function(widget)

  end)
  frame.RenameFrame.statustext:GetParent():Hide()
  frame.RenameFrame:Hide()

  local renameText
  frame.RenameFrame.Editbox = AceGUI:Create("EditBox")
  frame.RenameFrame.Editbox:SetLabel(L["Preset Name"]..":")
  frame.RenameFrame.Editbox:SetWidth(200)
  frame.RenameFrame.Editbox:SetCallback("OnTextChanged", function(widget, event, text)
    --check if name is valid, block button if so, unblock if valid
    if MDT:SanitizePresetName(text) then
      frame.RenameFrame.PresetRenameLabel:SetText(nil)
      frame.RenameFrame.RenameButton:SetDisabled(false)
      frame.RenameFrame.RenameButton.text:SetTextColor(1, 0.8196, 0)
      renameText = text
    else
      frame.RenameFrame.PresetRenameLabel:SetText(string.format(L["Cannot rename preset to '%s'"], text))
      frame.RenameFrame.RenameButton:SetDisabled(true)
      frame.RenameFrame.RenameButton.text:SetTextColor(0.5, 0.5, 0.5)
      renameText = nil
    end
    frame.RenameFrame:DoLayout()
  end)
  frame.RenameFrame.Editbox:SetCallback("OnEnterPressed", function(widget, event, text)
    if MDT:SanitizePresetName(renameText) then
      MDT:RenamePreset(renameText)
    end
  end)
  frame.RenameFrame.Editbox:DisableButton(true)

  frame.RenameFrame:AddChild(frame.RenameFrame.Editbox)

  frame.RenameFrame.RenameButton = AceGUI:Create("Button")
  frame.RenameFrame.RenameButton:SetText(L["Rename"])
  frame.RenameFrame.RenameButton:SetWidth(100)
  frame.RenameFrame.RenameButton:SetCallback("OnClick", function() MDT:RenamePreset(renameText) end)
  frame.RenameFrame:AddChild(frame.RenameFrame.RenameButton)

  frame.RenameFrame.PresetRenameLabel = AceGUI:Create("Label")
  frame.RenameFrame.PresetRenameLabel:SetText(nil)
  frame.RenameFrame.PresetRenameLabel:SetWidth(390)
  frame.RenameFrame.PresetRenameLabel:SetColor(1, 0, 0)
  frame.RenameFrame:AddChild(frame.RenameFrame.PresetRenameLabel)
end

---Creates the frame used to export presets to a string which can be uploaded to text sharing websites like pastebin
function MDT:MakeExportFrame(frame)
  frame.ExportFrame = AceGUI:Create("Frame")
  frame.ExportFrame.frame:SetParent(frame)
  frame.ExportFrame.frame:SetFrameStrata("DIALOG")
  frame.ExportFrame:SetTitle(L["Export"])
  frame.ExportFrame:SetWidth(600)
  frame.ExportFrame:SetHeight(400)
  frame.ExportFrame:EnableResize(false)
  frame.ExportFrame:SetLayout("Flow")
  frame.ExportFrame:SetCallback("OnClose", function(widget)
    frame.ExportFrame.statustext:GetParent():Hide()
  end)
  frame.ExportFrameEditbox = AceGUI:Create("MultiLineEditBox")
  frame.ExportFrameEditbox:SetWidth(600)
  frame.ExportFrameEditbox:DisableButton(true)
  frame.ExportFrameEditbox:SetNumLines(20)

  function frame.ExportFrameEditbox:SelectAll()
    local text = frame.ExportFrameEditbox:GetText()
    frame.ExportFrameEditbox:HighlightText(0, string.len(text))
    frame.ExportFrameEditbox:SetFocus()
  end

  local selectAllButton
  frame.ExportFrameEditbox.editBox:HookScript('OnEditFocusLost', function()
    MDT.copyHelper:Hide()
  end);

  frame.ExportFrameEditbox.editBox:SetScript('OnKeyUp', function(_, key)
    if (MDT.copyHelper:WasControlKeyDown() and key == 'A') then
      return
    end
    if (MDT.copyHelper:WasControlKeyDown() and key == 'C') then
      frame.ExportFrameEditbox:ClearFocus();
      frame.ExportFrame:Hide()
      MDT.copyHelper:SmartFadeOut()
      return
    end
  end);

  frame.ExportFrameSelectAllButton = AceGUI:Create("Button")
  selectAllButton = frame.ExportFrameSelectAllButton
  selectAllButton:SetText(L["Select all"])
  selectAllButton:SetHeight(40)
  selectAllButton:SetCallback("OnClick", function(widget, callbackName, value)
    frame.ExportFrameEditbox:SelectAll()
    MDT.copyHelper:SmartShow(frame, 0, 50)
  end)

  frame.ExportFrame:AddChild(frame.ExportFrameEditbox)
  frame.ExportFrame:AddChild(selectAllButton)
  frame.ExportFrame:Hide()
end

---MakeDeleteConfirmationFrame
---Creates the delete confirmation dialog that pops up when a user wants to delete a preset
function MDT:MakeDeleteConfirmationFrame(frame)
  frame.DeleteConfirmationFrame = AceGUI:Create("Frame")
  frame.DeleteConfirmationFrame.frame:SetParent(frame)
  frame.DeleteConfirmationFrame.frame:SetFrameStrata("DIALOG")
  frame.DeleteConfirmationFrame:SetTitle(L["Delete Preset"])
  frame.DeleteConfirmationFrame:SetWidth(250)
  frame.DeleteConfirmationFrame:SetHeight(120)
  frame.DeleteConfirmationFrame:EnableResize(false)
  frame.DeleteConfirmationFrame:SetLayout("Flow")
  frame.DeleteConfirmationFrame:SetCallback("OnClose", function(widget)

  end)
  frame.DeleteConfirmationFrame.statustext:GetParent():Hide()

  frame.DeleteConfirmationFrame.label = AceGUI:Create("Label")
  frame.DeleteConfirmationFrame.label:SetWidth(390)
  frame.DeleteConfirmationFrame.label:SetHeight(10)
  --frame.DeleteConfirmationFrame.label:SetColor(1,0,0)
  frame.DeleteConfirmationFrame:AddChild(frame.DeleteConfirmationFrame.label)

  frame.DeleteConfirmationFrame.OkayButton = AceGUI:Create("Button")
  frame.DeleteConfirmationFrame.OkayButton:SetText(L["Delete"])
  frame.DeleteConfirmationFrame.OkayButton:SetWidth(100)
  frame.DeleteConfirmationFrame.OkayButton:SetCallback("OnClick", function()
    MDT:DeletePreset(db.currentPreset[db.currentDungeonIdx])
    frame.DeleteConfirmationFrame:Hide()
  end)
  frame.DeleteConfirmationFrame.CancelButton = AceGUI:Create("Button")
  frame.DeleteConfirmationFrame.CancelButton:SetText(L["Cancel"])
  frame.DeleteConfirmationFrame.CancelButton:SetWidth(100)
  frame.DeleteConfirmationFrame.CancelButton:SetCallback("OnClick", function()
    frame.DeleteConfirmationFrame:Hide()
  end)

  frame.DeleteConfirmationFrame:AddChild(frame.DeleteConfirmationFrame.OkayButton)
  frame.DeleteConfirmationFrame:AddChild(frame.DeleteConfirmationFrame.CancelButton)
  frame.DeleteConfirmationFrame:Hide()
end

---Creates the clear confirmation dialog that pops up when a user wants to clear a preset
function MDT:MakeClearConfirmationFrame(frame)
  frame.ClearConfirmationFrame = AceGUI:Create("Frame")
  frame.ClearConfirmationFrame.frame:SetParent(frame)
  frame.ClearConfirmationFrame.frame:SetFrameStrata("DIALOG")
  frame.ClearConfirmationFrame:SetTitle(L["Reset Preset"])
  frame.ClearConfirmationFrame:SetWidth(250)
  frame.ClearConfirmationFrame:SetHeight(120)
  frame.ClearConfirmationFrame:EnableResize(false)
  frame.ClearConfirmationFrame:SetLayout("Flow")
  frame.ClearConfirmationFrame:SetCallback("OnClose", function(widget)

  end)
  frame.ClearConfirmationFrame.statustext:GetParent():Hide()

  frame.ClearConfirmationFrame.label = AceGUI:Create("Label")
  frame.ClearConfirmationFrame.label:SetWidth(390)
  frame.ClearConfirmationFrame.label:SetHeight(10)
  --frame.DeleteConfirmationFrame.label:SetColor(1,0,0)
  frame.ClearConfirmationFrame:AddChild(frame.ClearConfirmationFrame.label)

  frame.ClearConfirmationFrame.OkayButton = AceGUI:Create("Button")
  frame.ClearConfirmationFrame.OkayButton:SetText(L["Reset"])
  frame.ClearConfirmationFrame.OkayButton:SetWidth(100)
  frame.ClearConfirmationFrame.OkayButton:SetCallback("OnClick", function()
    self:ClearPreset(self:GetCurrentPreset())
    if self.liveSessionActive and self:GetCurrentPreset().uid == self.livePresetUID then
      MDT:LiveSession_SendCommand(
        "clear")
    end
    frame.ClearConfirmationFrame:Hide()
  end)
  frame.ClearConfirmationFrame.CancelButton = AceGUI:Create("Button")
  frame.ClearConfirmationFrame.CancelButton:SetText(L["Cancel"])
  frame.ClearConfirmationFrame.CancelButton:SetWidth(100)
  frame.ClearConfirmationFrame.CancelButton:SetCallback("OnClick", function()
    frame.ClearConfirmationFrame:Hide()
  end)

  frame.ClearConfirmationFrame:AddChild(frame.ClearConfirmationFrame.OkayButton)
  frame.ClearConfirmationFrame:AddChild(frame.ClearConfirmationFrame.CancelButton)
  frame.ClearConfirmationFrame:Hide()
end

---Creates a generic dialog that pops up when a user wants needs confirmation for an action
function MDT:OpenConfirmationFrame(width, height, title, buttonText, prompt, callback, buttonText2, callback2, fireCancelOnClose)
  local f
  if MDT.main_frame then
    f = MDT.main_frame.ConfirmationFrame
  else
    f = MDT.tempConfirmationFrame
  end
  if not f then
    if MDT.main_frame then
      MDT.main_frame.ConfirmationFrame = AceGUI:Create("Frame")
      MDT.main_frame.ConfirmationFrame.frame:SetParent(MDT.main_frame)
      MDT.main_frame.ConfirmationFrame.frame:SetFrameStrata("DIALOG")
      f = MDT.main_frame.ConfirmationFrame
    else
      MDT.tempConfirmationFrame = AceGUI:Create("Frame")
      f = MDT.tempConfirmationFrame
    end
    f:EnableResize(false)
    f:SetLayout("Flow")
    f:SetCallback("OnClose", function(widget)
    end)
    f.statustext:GetParent():Hide()

    f.label = AceGUI:Create("Label")
    f.label:SetWidth(390)
    f.label:SetHeight(height - 20)
    f:AddChild(f.label)

    f.OkayButton = AceGUI:Create("Button")
    f.OkayButton:SetWidth(100)
    f:AddChild(f.OkayButton)

    f.CancelButton = AceGUI:Create("Button")
    f.CancelButton:SetText(L["Cancel"])
    f.CancelButton:SetWidth(100)
    f.CancelButton:SetCallback("OnClick", function()
      if MDT.main_frame then MDT:HideAllDialogs() else f:Hide() end
    end)
    f:AddChild(f.CancelButton)
  end
  f:SetWidth(width or 250)
  f:SetHeight(height or 120)
  f:SetTitle(title)
  f.OkayButton:SetText(buttonText)
  f.OkayButton:SetCallback("OnClick", function()
    callback()
    MDT:HideAllDialogs()
  end)
  if buttonText2 then
    f.CancelButton:SetText(buttonText2)
  else
    f.CancelButton:SetText(L["Cancel"])
  end
  if callback2 then
    f.CancelButton:SetCallback("OnClick", function()
      callback2()
      MDT:HideAllDialogs()
    end)
  else
    f.CancelButton:SetCallback("OnClick", function()
      if MDT.main_frame then MDT:HideAllDialogs() else f:Hide() end
    end)
  end
  if fireCancelOnClose and callback2 then
    f:SetCallback("OnClose", function(widget)
      callback2()
    end)
  else
    f:SetCallback("OnClose", function(widget)
    end)
  end
  if MDT.main_frame then MDT:HideAllDialogs() end
  f:ClearAllPoints()
  f:SetPoint("CENTER", MDT.main_frame or UIParent, "CENTER", 0, 50)
  f.label:SetText(prompt)
  f:Show()
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

---https://en.wikipedia.org/wiki/HSL_and_HSV#HSV_to_RGB_alternative
function MDT:HSVtoRGB(H, S, V)
  H = H % 361

  local function f(n)
    local k = (n + H / 60) % 6
    return V - V * S * math.max(math.min(k, 4 - k, 1), 0)
  end

  return f(5), f(3), f(1)
end

function MDT:DeepCopy(orig)
  local orig_type = type(orig)
  local copy
  if orig_type == 'table' then
    copy = {}
    for orig_key, orig_value in next, orig, nil do
      copy[MDT:DeepCopy(orig_key)] = MDT:DeepCopy(orig_value)
    end
    setmetatable(copy, MDT:DeepCopy(getmetatable(orig)))
  else -- number, string, boolean, etc
    copy = orig
  end
  return copy
end

---scale if preset comes from live session
function MDT:StorePresetObject(obj, ignoreScale, preset)
  --adjust scale
  if not ignoreScale then
    local scale = self:GetScale()
    if obj.n then
      obj.d[1] = obj.d[1] * (1 / scale)
      obj.d[2] = obj.d[2] * (1 / scale)
    else
      for idx, coord in pairs(obj.l) do
        obj.l[idx] = self:Round(obj.l[idx] * (1 / scale), 1)
      end
    end
  end
  preset = preset or self:GetCurrentPreset()
  preset.objects = preset.objects or {}
  --we insert the object infront of the first hidden oject
  local pos = 1
  for k, v in ipairs(preset.objects) do
    pos = pos + 1
    if v.d[4] == false then
      pos = pos - 1
    end
  end
  if pos > 1 then
    tinsert(preset.objects, pos, self:DeepCopy(obj))
  else
    tinsert(preset.objects, self:DeepCopy(obj))
  end
end

---excluding notes, these are handled in OverrideScrollFrameScripts
function MDT:UpdatePresetObjectOffsets(idx, x, y, preset, silent)
  --adjust coords to scale
  local scale = self:GetScale()
  x = self:Round(x * (1 / scale), 1)
  y = self:Round(y * (1 / scale), 1)
  preset = preset or self:GetCurrentPreset()
  for objectIndex, obj in pairs(preset.objects) do
    if objectIndex == idx then
      for coordIdx, coord in pairs(obj.l) do
        if coordIdx % 2 == 1 then
          obj.l[coordIdx] = coord - x
        else
          obj.l[coordIdx] = coord - y
        end
      end
    end
  end
  --redraw everything
  if not silent then self:DrawAllPresetObjects() end
end

---Draws all Preset objects on the map canvas/sublevel
function MDT:DrawAllPresetObjects()
  MDT:Async(function()
    self:ReleaseAllActiveTextures()
    coroutine.yield()
    local scale = self:GetScale()
    local currentPreset = self:GetCurrentPreset()
    local currentSublevel = self:GetCurrentSubLevel()
    currentPreset.objects = currentPreset.objects or {}
    for objectIndex, obj in pairs(currentPreset.objects) do
      self:DrawPresetObject(obj, objectIndex, scale, currentPreset, currentSublevel)
      coroutine.yield()
    end
  end, "DrawAllPresetObjects")
end

---Draws specific preset object
function MDT:DrawPresetObject(obj, objectIndex, scale, currentPreset, currentSublevel)
  if not objectIndex then
    for oIndex, o in pairs(currentPreset.objects) do
      if o == obj then
        objectIndex = oIndex
        break
      end
    end
  end
  --d: size,lineFactor,sublevel,shown,colorstring,drawLayer,[smooth]
  --l: x1,y1,x2,y2,...
  local color = {}
  if obj.d[3] == currentSublevel and obj.d[4] then
    if obj.n then
      local x = obj.d[1] * scale
      local y = obj.d[2] * scale
      local text = obj.d[5]
      self:DrawNote(x, y, text, objectIndex)
    else
      obj.d[1] = obj.d[1] or 5
      color.r, color.g, color.b = self:HexToRGB(obj.d[5])
      --lines
      local x1, y1, x2, y2
      local lastx, lasty
      for _, coord in pairs(obj.l) do
        if not x1 then
          x1 = coord
        elseif not y1 then
          y1 = coord
        elseif not x2 then
          x2 = coord
          lastx = coord
        elseif not y2 then
          y2 = coord
          lasty = coord
        end
        if x1 and y1 and x2 and y2 then
          x1 = x1 * scale
          x2 = x2 * scale
          y1 = y1 * scale
          y2 = y2 * scale
          self:DrawLine(x1, y1, x2, y2, obj.d[1] * 0.3 * scale, color, obj.d[7], nil, obj.d[6], obj.d[2], nil,
            objectIndex)
          --circles if smooth
          if obj.d[7] then
            self:DrawCircle(x1, y1, obj.d[1] * 0.3 * scale, color, nil, obj.d[6], nil, objectIndex)
            self:DrawCircle(x2, y2, obj.d[1] * 0.3 * scale, color, nil, obj.d[6], nil, objectIndex)
          end
          x1, y1, x2, y2 = nil, nil, nil, nil
        end
      end
      --triangle
      if obj.t and lastx and lasty then
        lastx = lastx * scale
        lasty = lasty * scale
        self:DrawTriangle(lastx, lasty, obj.t[1], obj.d[1] * scale, color, nil, obj.d[6], nil, objectIndex)
      end
      --remove empty objects leftover from erasing
      if obj.l then
        local lineCount = 0
        for _, _ in pairs(obj.l) do
          lineCount = lineCount + 1
        end
        if lineCount == 0 then
          currentPreset.objects[objectIndex] = nil
        end
      end
    end
  end
end

---Deletes objects from the current preset in the current sublevel
function MDT:DeletePresetObjects(preset, silent)
  preset = preset or self:GetCurrentPreset()
  if preset == self:GetCurrentPreset() then silent = false end
  local currentSublevel = self:GetCurrentSubLevel()
  for objectIndex, obj in pairs(preset.objects) do
    if obj.d[3] == currentSublevel then
      preset.objects[objectIndex] = nil
    end
  end
  if not silent then self:DrawAllPresetObjects() end
end

---Undo the latest drawing
function MDT:PresetObjectStepBack(preset, silent, ignoreLiveSession)
  --keybind can be pressed before the frames are initialized
  if not framesInitialized then return end
  preset = preset or self:GetCurrentPreset()
  if preset == self:GetCurrentPreset() then silent = false end
  preset.objects = preset.objects or {}
  local length = 0
  for k, v in pairs(preset.objects) do
    length = length + 1
  end
  if length > 0 then
    for i = length, 1, -1 do
      if preset.objects[i] and preset.objects[i].d[4] then
        preset.objects[i].d[4] = false
        if not silent then self:DrawAllPresetObjects() end
        break
      end
    end
  end
  if self.liveSessionActive and not ignoreLiveSession then self:LiveSession_SendCommand("undo") end
end

---Redo the latest drawing
function MDT:PresetObjectStepForward(preset, silent, ignoreLiveSession)
  if not framesInitialized then return end
  preset = preset or MDT:GetCurrentPreset()
  if preset == self:GetCurrentPreset() then silent = false end
  preset.objects = preset.objects or {}
  local length = 0
  for k, v in ipairs(preset.objects) do
    length = length + 1
  end
  if length > 0 then
    for i = 1, length do
      if preset.objects[i] and not preset.objects[i].d[4] then
        preset.objects[i].d[4] = true
        if not silent then self:DrawAllPresetObjects() end
        break
      end
    end
  end
  if self.liveSessionActive and not ignoreLiveSession then self:LiveSession_SendCommand("redo") end
end

function MDT:FixAceGUIShowHide(widget, frame, isFrame, hideOnly)
  frame = frame or MDT.main_frame
  local originalShow, originalHide = frame.Show, frame.Hide
  if not isFrame then
    widget = widget.frame
  end
  function frame:Hide(...)
    widget:Hide()
    return originalHide(self, ...)
  end

  if hideOnly then return end
  function frame:Show(...)
    widget:Show()
    return originalShow(self, ...)
  end
end

function MDT:GetCurrentAffixWeek()
  if not C_AddOns.IsAddOnLoaded("Blizzard_ChallengesUI") then
    C_AddOns.LoadAddOn("Blizzard_ChallengesUI")
  end
  C_MythicPlus.RequestCurrentAffixes()
  C_MythicPlus.RequestMapInfo()
  C_MythicPlus.RequestRewards()
  local affixIds = C_MythicPlus.GetCurrentAffixes() --table
  if not affixIds then return 1 end
  if not affixIds[1] then return 1 end
  for week, affixes in ipairs(affixWeeks) do
    if affixes[1] == affixIds[2].id and affixes[2] == affixIds[3].id and affixes[3] == affixIds[1].id then
      return week
    end
  end
  return 1
end

---Helper function to print out current affixes with their ids and their names
function MDT:PrintCurrentAffixes()
  --run this once so blizz stuff is loaded
  MDT:GetCurrentAffixWeek()
  --https://www.wowhead.com/affixes
  local affixNames = {
    [1] = L["Overflowing"],
    [2] = L["Skittish"],
    [3] = L["Volcanic"],
    [4] = L["Necrotic"],
    [5] = L["Teeming"],
    [6] = L["Raging"],
    [7] = L["Bolstering"],
    [8] = L["Sanguine"],
    [9] = L["Tyrannical"],
    [10] = L["Fortified"],
    [11] = L["Bursting"],
    [12] = L["Grievous"],
    [13] = L["Explosive"],
    [14] = L["Quaking"],
    [15] = L["Relentless"],
    [16] = L["Infested"],
    [117] = L["Reaping"],
    [119] = L["Beguiling"],
    [120] = L["Awakened"],
    [121] = L["Prideful"],
    [122] = L["Inspiring"],
    [123] = L["Spiteful"],
    [124] = L["Storming"],
    [128] = L["Tormented"],
    [130] = L["Encrypted"],
    [131] = L["Shrouded"],
    [132] = L["Thundering"],
    [147] = L["Xal'atath's Guile"],
    [148] = L["Xal'atath's Bargain: Ascendant"],
    [152] = L["Challenger's Peril"],
    [158] = L["Xal'atath's Bargain: Voidbound"],
    [159] = L["Xal'atath's Bargain: Oblivion"],
    [160] = L["Xal'atath's Bargain: Devour"],
  }
  local affixIds = C_MythicPlus.GetCurrentAffixes()
  for idx, data in ipairs(affixIds) do
    print(data.id, affixNames[data.id])
  end
end

---Checks if the players is in a group/raid and returns the type
function MDT:IsPlayerInGroup()
  local inGroup = (UnitInRaid("player") and "RAID") or (IsInGroup() and "PARTY")
  return inGroup
end

function MDT:ResetMainFramePos(soft)
  MDT:Async(function()
    --soft reset just redraws the window with existing coordinates from db
    local f = self.main_frame
    if not soft then
      db.nonFullscreenScale = defaultSavedVars.global.nonFullscreenScale
      db.maximized = false
      if not framesInitialized then initFrames() end
      if not framesInitialized then return end
      f.maximizeButton:Minimize()
      db.xoffset = 0
      db.yoffset = -150
      db.anchorFrom = "TOP"
      db.anchorTo = "TOP"
    end
    f:ClearAllPoints()
    f:SetPoint(db.anchorTo, UIParent, db.anchorFrom, db.xoffset, db.yoffset)
  end, 'resetMainFramePos')
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

function MDT:GetSelection()
  if not MDT:GetCurrentPreset().value.selection or #MDT:GetCurrentPreset().value.selection == 0 then
    MDT:GetCurrentPreset().value.selection = { MDT:GetCurrentPreset().value.currentPull }
  end

  return MDT:GetCurrentPreset().value.selection
end

function MDT:GetScrollingAmount(scrollFrame, pixelPerSecond)
  local viewheight = scrollFrame.frame.obj.content:GetHeight()
  return (pixelPerSecond / viewheight) * 1000
end

function MDT:ScrollToPull(pullIdx)
  -- Get scroll frame
  local scrollFrame = MDT.main_frame.sidePanel.pullButtonsScrollFrame
  -- Get amount of total pulls plus the extra button "+ Add Pull"
  local pulls = #MDT:GetCurrentPreset().value.pulls + 1 or 1
  local percentage = pullIdx / pulls
  local value = percentage * 1000
  scrollFrame:SetScroll(value)
  scrollFrame:FixScroll()
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

--/run MDT:ResetDataCache();
function MDT:ResetDataCache()
  db.dungeonEnemies = nil
  db.mapPOIs = nil
  ReloadUI()
end

function MDT:HardReset()
  MythicDungeonToolsDB = nil
  ReloadUI()
end

MDT.modules = {}
function MDT:RegisterModule(modulename, module)
  MDT.modules[modulename] = module
end

local asyncConfig = {
  type = "everyFrame",
  maxTime = 40,
  maxTimeCombat = 8,
  errorHandler = function(msg, stackTrace, name)
    MDT:OnError(msg, stackTrace, name)
  end,
}
MDT.asyncHandler = LibStub("LibAsync"):GetHandler(asyncConfig)

function MDT:Async(func, name, singleton)
  MDT.asyncHandler:Async(func, name, singleton)
end

function MDT:CancelAsync(name)
  MDT.asyncHandler:CancelAsync(name)
end

function MDT:ShowSpinner(timeout)
  if not MDT.initSpinner then return end
  MDT.initSpinner:Show()
  MDT.initSpinner.Anim:Play()
  if timeout then
    C_Timer.After(timeout, function()
      MDT:HideSpinner()
    end)
  end
end

function MDT:HideSpinner()
  if not MDT.initSpinner then return end
  MDT.initSpinner:Hide()
  MDT.initSpinner.Anim:Stop()
end

local initStarted
function initFrames()
  if initStarted then return end
  initStarted = true
  for _, module in pairs(MDT.modules) do
    if module.OnInitialize then
      module:OnInitialize()
    end
  end
  MDT:RegisterErrorHandledFunctions()
  MDT:CheckSeenDungeonLists()

  local initSpinner = CreateFrame("Button", "MDTInitSpinner", UIParent, "LoadingSpinnerTemplate")
  initSpinner.BackgroundFrame.Background:SetVertexColor(0, 1, 0, 1)
  initSpinner.AnimFrame.Circle:SetVertexColor(0, 1, 0, 1)
  initSpinner:SetPoint("CENTER", UIParent, "CENTER", 0, 150)
  initSpinner:SetFrameStrata("DIALOG")
  initSpinner:SetSize(60, 60)
  initSpinner:Show()
  initSpinner.Anim:Play()
  MDT.initSpinner = initSpinner

  local main_frame = CreateFrame("frame", "MDTFrame", UIParent)
  main_frame:SetToplevel(true)
  MDT:SetUpModifiers(main_frame)
  main_frame:Hide()
  tinsert(UISpecialFrames, "MDTFrame")

  --cache dungeon data to not lose data during reloads
  if db.devMode and db.loadCache then
    if db.dungeonEnemies then
      MDT.dungeonEnemies = db.dungeonEnemies
    else
      db.dungeonEnemies = MDT.dungeonEnemies
    end
    if db.mapPOIs then
      MDT.mapPOIs = db.mapPOIs
    else
      db.mapPOIs = MDT.mapPOIs
    end
  end

  db.nonFullscreenScale = db.nonFullscreenScale or defaultSavedVars.global.nonFullscreenScale
  if not db.maximized then db.scale = db.nonFullscreenScale end
  main_frame:SetFrameStrata(mainFrameStrata)
  main_frame:SetFrameLevel(1)
  main_frame.background = main_frame:CreateTexture(nil, "BACKGROUND", nil, 0)
  main_frame.background:SetAllPoints()
  main_frame.background:SetDrawLayer(canvasDrawLayer, 1)
  main_frame.background:SetColorTexture(unpack(MDT.BackdropColor))
  main_frame.background:SetAlpha(0.2)
  main_frame:SetSize(sizex * db.scale, sizey * db.scale)
  main_frame:SetResizable(true)
  local _, _, fullscreenScale = MDT:GetFullScreenSizes()
  main_frame:SetResizeBounds(sizex * 0.9, sizey * 0.9, sizex * fullscreenScale, sizey * fullscreenScale)
  MDT.main_frame = main_frame

  main_frame.mainFrametex = main_frame:CreateTexture(nil, "BACKGROUND", nil, 0)
  main_frame.mainFrametex:SetAllPoints()
  main_frame.mainFrametex:SetDrawLayer(canvasDrawLayer, -5)
  main_frame.mainFrametex:SetColorTexture(unpack(MDT.BackdropColor))

  ---@diagnostic disable-next-line: redundant-parameter
  local version = C_AddOns.GetAddOnMetadata(AddonName, "Version"):gsub("%.", "")
  db.version = tonumber(version)
  -- Set frame position
  main_frame:ClearAllPoints()
  main_frame:SetPoint(db.anchorTo, UIParent, db.anchorFrom, db.xoffset, db.yoffset)
  main_frame.contextDropdown = CreateFrame("frame", "MDTContextDropDown", nil, "UIDropDownMenuTemplate")
  MDT:CheckCurrentZone(true)
  MDT:EnsureDBTables()
  MDT:MakeTopBottomTextures(main_frame)
  MDT:MakeCopyHelper(main_frame)
  coroutine.yield()
  MDT:MakeMapTexture(main_frame)
  coroutine.yield()
  MDT:MakeSidePanel(main_frame)
  coroutine.yield()
  MDT:CreateMenu()
  coroutine.yield()
  MDT:MakePresetCreationFrame(main_frame)
  coroutine.yield()
  MDT:MakePresetImportFrame(main_frame)
  coroutine.yield()
  MDT:DungeonEnemies_CreateFramePools()
  MDT:CreateSeasonDropdown(main_frame)
  MDT:CreateSublevelDropdown(main_frame)
  coroutine.yield()
  MDT:MakePullSelectionButtons(main_frame.sidePanel)
  coroutine.yield()
  MDT:MakeExportFrame(main_frame)
  coroutine.yield()
  MDT:MakeRenameFrame(main_frame)
  coroutine.yield()
  MDT:MakeDeleteConfirmationFrame(main_frame)
  coroutine.yield()
  MDT:MakeClearConfirmationFrame(main_frame)
  coroutine.yield()
  MDT:POI_CreateFramePools()
  MDT:MakeChatPresetImportFrame(main_frame)
  coroutine.yield()
  MDT:MakeSendingStatusBar(main_frame)
  MDT:POI_CreateDropDown(main_frame)

  --devMode
  if db.devMode and MDT.CreateDevPanel then
    MDT:CreateDevPanel(MDT.main_frame)
  end

  db.currentSeason = defaultSavedVars.global.currentSeason

  --tooltip new
  do
    MDT.tooltip = CreateFrame("Frame", "MDTModelTooltip", UIParent, "TooltipBorderedFrameTemplate")
    local tooltip = MDT.tooltip
    tooltip:SetClampedToScreen(true)
    tooltip:SetFrameStrata("TOOLTIP")
    tooltip.mySizes = { x = 290, y = 120 }
    tooltip:SetSize(tooltip.mySizes.x, tooltip.mySizes.y)
    tooltip.Model = CreateFrame("PlayerModel", nil, tooltip)
    tooltip.Model:SetFrameLevel(1)
    tooltip.Model:SetSize(100, 100)
    tooltip.Model.fac = 0
    tooltip.Model:SetScript("OnUpdate", function(self, elapsed)
      self.fac = self.fac + 0.5
      if self.fac >= 360 then
        self.fac = 0
      end
      self:SetFacing(PI * 2 / 360 * self.fac)
    end)
    ---@diagnostic disable-next-line: param-type-mismatch
    tooltip.Model:SetPoint("TOPLEFT", tooltip, "TOPLEFT", 7, -7)
    tooltip.String = tooltip:CreateFontString("MDTToolTipString")
    tooltip.String:SetFontObject(GameFontNormalSmall)
    tooltip.String:SetFont(tooltip.String:GetFont() or '', 10, '')
    tooltip.String:SetTextColor(1, 1, 1, 1)
    tooltip.String:SetJustifyH("LEFT")
    --tooltip.String:SetJustifyV("MIDDLE")
    tooltip.String:SetWidth(tooltip:GetWidth())
    tooltip.String:SetHeight(90)
    tooltip.String:SetWidth(175)
    tooltip.String:SetText(" ")
    ---@diagnostic disable-next-line: param-type-mismatch
    tooltip.String:SetPoint("TOPLEFT", tooltip, "TOPLEFT", 110, -10)
    tooltip.String:Show()
  end

  --pullTooltip
  do
    MDT.pullTooltip = CreateFrame("Frame", "MDTPullTooltip", UIParent, "TooltipBorderedFrameTemplate")
    --MDT.pullTooltip:SetOwner(UIParent, "ANCHOR_NONE")
    local pullTT = MDT.pullTooltip
    MDT.pullTooltip:SetClampedToScreen(true)
    MDT.pullTooltip:SetFrameStrata("TOOLTIP")
    MDT.pullTooltip.myHeight = 180
    MDT.pullTooltip:SetSize(250, MDT.pullTooltip.myHeight)
    MDT.pullTooltip.Model = CreateFrame("PlayerModel", nil, MDT.pullTooltip)
    MDT.pullTooltip.Model:SetFrameLevel(1)
    MDT.pullTooltip.Model.fac = 0
    if true then
      MDT.pullTooltip.Model:SetScript("OnUpdate", function(self, elapsed)
        self.fac = self.fac + 0.5
        if self.fac >= 360 then
          self.fac = 0
        end
        self:SetFacing(PI * 2 / 360 * self.fac)
      end)
    else
      MDT.pullTooltip.Model:SetPortraitZoom(1)
      MDT.pullTooltip.Model:SetFacing(PI * 2 / 360 * 2)
    end

    MDT.pullTooltip.Model:SetSize(110, 110)
    ---@diagnostic disable-next-line: param-type-mismatch
    MDT.pullTooltip.Model:SetPoint("TOPLEFT", MDT.pullTooltip, "TOPLEFT", 7, -7)

    MDT.pullTooltip.topString = MDT.pullTooltip:CreateFontString("MDTToolTipString")
    MDT.pullTooltip.topString:SetFontObject(GameFontNormalSmall)
    MDT.pullTooltip.topString:SetFont(MDT.pullTooltip.topString:GetFont() or '', 10, '')
    MDT.pullTooltip.topString:SetTextColor(1, 1, 1, 1)
    MDT.pullTooltip.topString:SetJustifyH("LEFT")
    MDT.pullTooltip.topString:SetJustifyV("TOP")
    MDT.pullTooltip.topString:SetHeight(110)
    MDT.pullTooltip.topString:SetWidth(130)
    ---@diagnostic disable-next-line: param-type-mismatch
    MDT.pullTooltip.topString:SetPoint("TOPLEFT", MDT.pullTooltip, "TOPLEFT", 110, -7)
    MDT.pullTooltip.topString:Hide()

    local heading = MDT.pullTooltip:CreateTexture(nil, "OVERLAY", nil, 0)
    heading:SetHeight(8)
    heading:SetPoint("LEFT", 12, -30)
    ---@diagnostic disable-next-line: param-type-mismatch
    heading:SetPoint("RIGHT", MDT.pullTooltip, "RIGHT", -12, -30)
    heading:SetTexture("Interface\\Tooltips\\UI-Tooltip-Border")
    heading:SetTexCoord(0.81, 0.94, 0.5, 1)
    heading:Show()

    MDT.pullTooltip.botString = MDT.pullTooltip:CreateFontString("MDTToolTipString")
    local botString = MDT.pullTooltip.botString
    botString:SetFontObject(GameFontNormalSmall)
    botString:SetFont(MDT.pullTooltip.topString:GetFont() or '', 10, '')
    botString:SetTextColor(1, 1, 1, 1)
    botString:SetJustifyH("CENTER")
    botString:SetJustifyV("TOP")
    botString:SetHeight(40)
    botString:SetWidth(250)
    botString:SetPoint("TOPLEFT", heading, "LEFT", -12, -7)
    botString:Hide()
  end

  coroutine.yield()
  MDT:initToolbar(main_frame)
  coroutine.yield()
  if db.toolbarExpanded then
    main_frame.toolbar.toggleButton:Click()
    main_frame.toolbar.widgetGroup.frame:Hide()
  end

  --ping
  --MDT.ping = CreateFrame("PlayerModel", nil, MDT.main_frame.mapPanelFrame)
  --local ping = MDT.ping
  --ping:SetModel("interface/minimap/ping/minimapping.m2")
  --ping:SetModel(120590)
  --ping:SetPortraitZoom(1)
  --ping:SetCamera(1)
  -- ping:SetFrameLevel(50)
  -- ping:SetFrameStrata("DIALOG")
  -- ping.mySize = 45
  -- ping:SetSize(ping.mySize, ping.mySize)
  -- ping:Hide()

  --Set affix dropdown to preset week
  --gotta set the list here, as affixes are not ready to be retrieved yet on login
  main_frame.sidePanel.affixDropdown:UpdateAffixList()
  main_frame.sidePanel.affixDropdown:SetAffixWeek(MDT:GetCurrentPreset().week or (MDT:GetCurrentAffixWeek() or 1))
  coroutine.yield()

  if MDT:IsFrameOffScreen() then
    MDT:ResetMainFramePos()
  end

  framesInitialized = true
  --Maximize if needed
  if db.maximized then MDT:Maximize() end
  initSpinner:Hide()
  initSpinner.Anim:Stop()
end
