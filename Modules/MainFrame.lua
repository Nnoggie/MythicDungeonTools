local _, MDT = ...
local L = MDT.L
local mainFrameStrata = "HIGH"
local canvasDrawLayer = "BORDER"

local tinsert, CreateFrame, tonumber, max, min, abs, pairs, ipairs, GetCursorPosition, GameTooltip =
    table.insert, CreateFrame, tonumber, math.max, math.min, math.abs, pairs, ipairs, GetCursorPosition,
    GameTooltip

local sizex = 840
local sizey = 555
local defaultSavedVars = MDT:GetDefaultSavedVariables()
local defaultNonFullscreenScale = defaultSavedVars.global.nonFullscreenScale
local minNonFullscreenScale = 0.9
local sidePanelWidth = 251
local panelHeight = 30
local screenEdgePadding = 10
local framesInitialized
local frameInitializedCallbacks = {}

local db

function MDT:RegisterMainFrameDragHandle(dragHandle, frame)
  frame = frame or MDT.main_frame
  if not dragHandle or not frame then return end

  dragHandle:EnableMouse(true)
  dragHandle:RegisterForDrag("LeftButton")
  dragHandle:SetScript("OnDragStart", function()
    frame:SetMovable(true)
    frame:StartMoving()
  end)
  dragHandle:SetScript("OnDragStop", function()
    frame:StopMovingOrSizing()
    frame:SetMovable(false)
    if MDT:IsFrameOffScreen() then
      MDT:ResetMainFramePos(true)
    else
      local from, _, to, x, y = frame:GetPoint()
      db.anchorFrom = from
      db.anchorTo = to
      db.xoffset, db.yoffset = x, y
    end
  end)
end

function MDT:ShowInterface(force)
  MDT:Async(function() MDT:ShowInterfaceInternal(force) end, "showInterface")
end

function MDT:RunAfterFramesInitialized(callback)
  if framesInitialized then
    callback()
    return true
  end
  tinsert(frameInitializedCallbacks, callback)
  return false
end

function MDT:AreFramesInitialized()
  return framesInitialized
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
  if not framesInitialized then MDT:StartMainFrameInitialization() end
  if not framesInitialized then return end
  if self.main_frame:IsShown() and not force then
    MDT:HideInterface()
  else
    self.main_frame:Show()
    MDT:UpdateSectionVisibility()
    MDT:RequestVersionCheck()
    self:CheckCurrentZone()
    MDT:UpdateBottomText()
  end
end

function MDT:InitializeFadeFrame()
  db = MDT:GetDB()
  if self.fadeFrame then return end
  self.fadeFrame = CreateFrame("Frame")
  self.fadeFrame:SetScript("OnEvent", function(self, event)
    if not MDT or not MDT.main_frame or not db then return end
    if event == "PLAYER_REGEN_DISABLED" then
      MDT.main_frame:SetAlpha(db.fadeOutAlpha or 0.5)
    elseif event == "PLAYER_REGEN_ENABLED" then
      MDT.main_frame:SetAlpha(1)
    end
  end)
  self:UpdateFadeEventRegistration()
end

function MDT:UpdateFadeEventRegistration()
  if not self.fadeFrame then return end
  if db and db.fadeOutDuringCombat then
    self.fadeFrame:RegisterEvent("PLAYER_REGEN_DISABLED")
    self.fadeFrame:RegisterEvent("PLAYER_REGEN_ENABLED")
  else
    self.fadeFrame:UnregisterEvent("PLAYER_REGEN_DISABLED")
    self.fadeFrame:UnregisterEvent("PLAYER_REGEN_ENABLED")
    if self.main_frame then
      self.main_frame:SetAlpha(1)
    end
  end
end

function MDT:HideInterface()
  if self.main_frame then
    self.main_frame:Hide()
  end
end

function MDT:CreateMenu()
  -- Close button
  local UI = MDT.UI
  local closeButton = UI.Button(self.main_frame, {
    variant = "window", icon = MDT:GetIconPath("close"), iconSize = 17, width = 24, height = 24,
    onClick = function() self:HideInterface() end,
  })
  closeButton:SetPoint("TOPRIGHT", self.main_frame.sidePanel, "TOPRIGHT", -4, -4)
  closeButton:SetFrameLevel(10)
  self.main_frame.closeButton = closeButton

  db.maximized = db.maximized or false
  local maximizeButton = UI.Button(self.main_frame, {
    variant = "window", icon = MDT:GetIconPath(db.maximized and "minimize" or "maximize"), iconSize = 17, width = 24, height = 24,
    onClick = function()
      if MDT:GetDB().maximized then MDT:Minimize() else MDT:Maximize() end
    end,
  })
  maximizeButton:SetPoint("RIGHT", closeButton, "LEFT", -3, 0)
  maximizeButton:SetFrameLevel(10)
  ---Leaves fullscreen if needed; kept for callers that reset the window.
  function maximizeButton:Minimize()
    if MDT:GetDB().maximized then MDT:Minimize() end
  end
  self.main_frame.maximizeButton = maximizeButton

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
  local screenWidth, screenHeight = MDT.UI.Root:GetWidth(), MDT.UI.Root:GetHeight()
  local newSizey = screenHeight - (panelHeight * 2)
  local newSizex = newSizey * (sizex / sizey)
  local navigationSidebarWidth = MDT:GetNavigationSidebarWidth()
  local isNarrow
  if newSizex + sidePanelWidth + navigationSidebarWidth > screenWidth then
    newSizex = screenWidth - sidePanelWidth - navigationSidebarWidth
    newSizey = newSizex * (sizey / sizex)
    isNarrow = true
  end
  local scale = newSizey / sizey --use this for adjusting NPC / POI positions later
  return newSizex, newSizey, scale, isNarrow
end

function MDT:GetDefaultNonFullscreenScale(xoffset, yoffset)
  xoffset = xoffset or defaultSavedVars.global.xoffset
  yoffset = yoffset or defaultSavedVars.global.yoffset

  local screenWidth, screenHeight = MDT.UI.Root:GetWidth(), MDT.UI.Root:GetHeight()
  if not screenWidth or not screenHeight or screenWidth <= 0 or screenHeight <= 0 then
    return defaultNonFullscreenScale
  end

  local navigationSidebarWidth = MDT:GetNavigationSidebarWidth()
  local maxLeftScale = ((screenWidth / 2) + xoffset - navigationSidebarWidth - screenEdgePadding) * 2 / sizex
  local maxRightScale = ((screenWidth / 2) - sidePanelWidth - xoffset - screenEdgePadding) * 2 / sizex
  local maxHeightScale = (screenHeight + yoffset - panelHeight - screenEdgePadding) / sizey
  local maxScale = min(maxLeftScale, maxRightScale, maxHeightScale)

  return min(defaultNonFullscreenScale, max(minNonFullscreenScale, maxScale))
end

function MDT:IsFrameOffScreen()
  local topPanel = MDT.main_frame.topPanel
  local bottomPanel = MDT.main_frame.bottomPanel
  local width, height = MDT.UI.Root:GetWidth(), MDT.UI.Root:GetHeight()
  local left = MDT.main_frame.navigationSidebar and MDT.main_frame.navigationSidebar:GetLeft() or topPanel:GetLeft() -->width
  local right = topPanel:GetRight()                                                                                  --<0
  local bottom = topPanel:GetBottom()                                                                                --<0
  local top = bottomPanel:GetTop()                                                                                   -->height
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
  [20] = L["enemyDragToPullTip"],
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
    frame.topPanelLogo:SetTexture("Interface\\AddOns\\"..MDT.AddonName.."\\Textures\\MDTFull")
    frame.topPanelLogo:SetWidth(30)
    frame.topPanelLogo:SetHeight(30)
    frame.topPanelLogo:SetPoint("RIGHT", frame.topPanelString, "LEFT", -5, -1)
    frame.topPanelLogo:Show()
  end

  frame.topPanel:ClearAllPoints()
  frame.topPanel:SetHeight(30)
  frame.topPanel:SetPoint("BOTTOMLEFT", frame, "TOPLEFT")
  frame.topPanel:SetPoint("BOTTOMRIGHT", frame, "TOPRIGHT")

  MDT:RegisterMainFrameDragHandle(frame.topPanel, frame)

  if frame.bottomPanel == nil then
    frame.bottomPanel = CreateFrame("Frame", "MDTBottomPanel", frame)
    frame.bottomPanelTex = frame.bottomPanel:CreateTexture(nil, "BACKGROUND", nil, 0)
    frame.bottomPanelTex:SetAllPoints()
    frame.bottomPanelTex:SetDrawLayer(canvasDrawLayer, -5)
    frame.bottomPanelTex:SetColorTexture(unpack(MDT.BackdropColor))
  end

  frame.bottomPanel:ClearAllPoints()
  frame.bottomPanel:SetHeight(30)
  frame.bottomPanel:SetPoint("TOPLEFT", frame, "BOTTOMLEFT", -MDT:GetNavigationSidebarWidth(), 0)
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
  frame.bottomLeftPanelString:SetText(" v"..C_AddOns.GetAddOnMetadata(MDT.AddonName, "Version"))
  frame.bottomLeftPanelString:Show()
  --add clickarea
  frame.bottomLeftPanelString.clickArea = CreateFrame("Button", "MDTBottomLeftPanelClickArea", frame)
  local clickArea = frame.bottomLeftPanelString.clickArea
  clickArea:Show()
  clickArea:SetHeight(frame.bottomPanel:GetHeight())
  clickArea:SetWidth(50)
  clickArea:SetPoint("LEFT", frame.bottomPanel, "LEFT", 0, 0)
  clickArea:SetFrameStrata("HIGH")
  clickArea:SetFrameLevel(5)
  clickArea:SetScript("OnClick", function(self, button, down)
    MDT:ToggleVersionCheckFrame()
    MDT:ToggleToolbarTooltip(false)
  end)
  MDT:CreateHoverHighlight(clickArea, 3)
  clickArea.tooltipText = L["Open changelog / version check"]
  clickArea:SetScript("OnEnter", function()
    local widget = {
      frame = clickArea,
      tooltipText = clickArea.tooltipText,
      type = "button",
    }
    MDT:ToggleToolbarTooltip(true, widget, "ANCHOR_TOPLEFT")
  end)
  clickArea:SetScript("OnLeave", function()
    MDT:ToggleToolbarTooltip(false)
  end)
  MDT:UpdateVersionCheckDisplay()

  MDT:CreateExternalLinkButtons(frame)

  frame.statusString = frame.bottomPanel:CreateFontString("MDTStatusLabel")
  frame.statusString:SetFontObject(GameFontNormalSmall)
  frame.statusString:SetJustifyH("RIGHT")
  frame.statusString:SetJustifyV("MIDDLE")
  frame.statusString:SetPoint("RIGHT", frame.bottomPanel, "RIGHT", 0, 0)
  frame.statusString:SetTextColor(1, 1, 1, 1)
  frame.statusString:Hide()

  MDT:RegisterMainFrameDragHandle(frame.bottomPanel, frame)
end

function MDT:MakeCopyHelper(frame)
  if MDT.copyHelper then
    MDT.copyHelper:SetParent(frame)
    return MDT.copyHelper
  end
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
    MDT.copyHelper:SetFrameStrata("TOOLTIP")
    MDT.copyHelper:SetFrameLevel(200)
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
  MDT:RegisterMainFrameDragHandle(frame.sidePanel, frame)

  frame.sidePanel:ClearAllPoints()
  frame.sidePanel:SetWidth(sidePanelWidth)
  frame.sidePanel:SetPoint("TOPLEFT", frame, "TOPRIGHT", 0, 30)
  frame.sidePanel:SetPoint("BOTTOMLEFT", frame, "BOTTOMRIGHT", 0, -30)

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

function MDT:ResetMainFramePos(soft)
  MDT:Async(function()
    --soft reset just redraws the window with existing coordinates from db
    if not framesInitialized then MDT:StartMainFrameInitialization() end
    local f = self.main_frame
    if not soft then
      db.maximized = false
      if not framesInitialized then MDT:StartMainFrameInitialization() end
      if not framesInitialized then return end
      db.xoffset = defaultSavedVars.global.xoffset
      db.yoffset = defaultSavedVars.global.yoffset
      db.anchorFrom = "TOP"
      db.anchorTo = "TOP"
      db.nonFullscreenScale = MDT:GetDefaultNonFullscreenScale(db.xoffset, db.yoffset)
      db.scale = db.nonFullscreenScale
      f.maximizeButton:Minimize()
    end
    f:ClearAllPoints()
    f:SetPoint(db.anchorTo, MDT.UI.Root, db.anchorFrom, db.xoffset, db.yoffset)
  end, 'resetMainFramePos')
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

function MDT:InitializeMainFrame()
  local initSpinner = CreateFrame("Button", "MDTInitSpinner", UIParent, "LoadingSpinnerTemplate")
  initSpinner.BackgroundFrame.Background:SetVertexColor(0, 1, 0, 1)
  initSpinner.AnimFrame.Circle:SetVertexColor(0, 1, 0, 1)
  initSpinner:SetPoint("CENTER", UIParent, "CENTER", 0, 150)
  initSpinner:SetFrameStrata("DIALOG")
  initSpinner:SetSize(60, 60)
  initSpinner:Show()
  initSpinner.Anim:Play()
  MDT.initSpinner = initSpinner

  local main_frame = CreateFrame("frame", "MDTFrame", MDT.UI.Root)
  main_frame:SetToplevel(true)
  MDT:SetUpModifiers(main_frame)
  main_frame:Hide()
  local escapeEntry = { close = function() MDT:HideInterface() end }
  main_frame:HookScript("OnShow", function() MDT.UI.Escape.Push(escapeEntry) end)
  main_frame:HookScript("OnHide", function() MDT.UI.Escape.Remove(escapeEntry) end)
  MDT.UI.Dialogs.SetDefaultParent(function() return MDT.main_frame end)

  if MDT.InitializeDevModeCache then MDT:InitializeDevModeCache() end

  db.nonFullscreenScale = db.nonFullscreenScale or MDT:GetDefaultNonFullscreenScale(db.xoffset, db.yoffset)
  if db.nonFullscreenScale == defaultNonFullscreenScale and db.anchorFrom == "TOP" and db.anchorTo == "TOP" then
    db.nonFullscreenScale = MDT:GetDefaultNonFullscreenScale(db.xoffset, db.yoffset)
  end
  if not db.maximized then db.scale = db.nonFullscreenScale end
  main_frame:SetFrameStrata(mainFrameStrata)
  main_frame:SetFrameLevel(1)
  MDT:RegisterMainFrameDragHandle(main_frame, main_frame)
  main_frame.background = main_frame:CreateTexture(nil, "BACKGROUND", nil, 0)
  main_frame.background:SetAllPoints()
  main_frame.background:SetDrawLayer(canvasDrawLayer, 1)
  main_frame.background:SetColorTexture(unpack(MDT.BackdropColor))
  main_frame.background:SetAlpha(0)
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
  local version = C_AddOns.GetAddOnMetadata(MDT.AddonName, "Version"):gsub("%.", "")
  db.version = tonumber(version)
  -- Set frame position
  main_frame:ClearAllPoints()
  main_frame:SetPoint(db.anchorTo, MDT.UI.Root, db.anchorFrom, db.xoffset, db.yoffset)
  main_frame.contextDropdown = CreateFrame("frame", "MDTContextDropDown", nil, "UIDropDownMenuTemplate")
  MDT:CheckCurrentZone(true)
  MDT:EnsureDBTables()
  MDT:MakeTopBottomTextures(main_frame)
  MDT:MakeNavigationSidebar(main_frame)
  MDT:MakeCopyHelper(main_frame)
  coroutine.yield()
  MDT:MakeMapTexture(main_frame)
  coroutine.yield()
  MDT:MakeSidePanel(main_frame)
  MDT:MakeSectionFrames(main_frame)
  MDT:MakeSettingsFrame(main_frame)
  coroutine.yield()
  MDT:CreateMenu()
  coroutine.yield()
  MDT:DungeonEnemies_CreateFramePools()
  MDT:CreateSeasonDropdown(main_frame)
  MDT:CreateSublevelDropdown(main_frame)
  coroutine.yield()
  MDT:MakeSidebar(main_frame.sidePanel)
  coroutine.yield()
  MDT:POI_CreateFramePools()
  MDT:MakeSendingStatusBar(main_frame)
  MDT:POI_CreateDropDown(main_frame)
  MDT:SetupPrePatchWarning()

  --devMode
  if db.devMode and MDT.CreateDevPanel then
    MDT:CreateDevPanel(MDT.main_frame)
  end

  --tooltip new
  do
    MDT.tooltip = CreateFrame("Frame", "MDTModelTooltip", MDT.UI.Root, "TooltipBorderedFrameTemplate")
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

  coroutine.yield()
  MDT:initToolbar(main_frame)
  coroutine.yield()
  if db.toolbarExpanded then
    main_frame.toolbar.toggleButton:Click()
  end
  MDT:UpdateSectionVisibility()

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

  MDT:UpdateMap()
  MDT:UpdateSectionVisibility()
  coroutine.yield()

  if MDT:IsFrameOffScreen() then
    MDT:ResetMainFramePos()
  end

  framesInitialized = true
  --Maximize if needed
  if db.maximized then MDT:Maximize() end
  initSpinner:Hide()
  initSpinner.Anim:Stop()
  local callbacks = frameInitializedCallbacks
  frameInitializedCallbacks = {}
  for _, callback in ipairs(callbacks) do
    callback()
  end
end
