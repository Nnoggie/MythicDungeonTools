local _, MDT = ...
local L = MDT.L
local mainFrameStrata = "HIGH"
local canvasDrawLayer = "BORDER"

local tinsert, CreateFrame, tonumber, max, min, abs, pairs, ipairs, GetCursorPosition, MDTTooltip =
    table.insert, CreateFrame, tonumber, math.max, math.min, math.abs, pairs, ipairs, GetCursorPosition,
    MDTTooltip

local sizex = 840
local sizey = 555
local defaultSavedVars = MDT:GetDefaultSavedVariables()
local minNonFullscreenScale = MDT:GetMinNonFullscreenScale()
local sidePanelWidth = 251
local panelHeight = 30
local framesInitialized
local frameInitializedCallbacks = {}

local db

---Whether none of the window (sidebar, side panel and both bars) lies inside the Root.
local function isOffScreen(f)
  local width, height = MDT.UI.Root:GetSize()
  return f.navigationSidebar:GetLeft() >= width or f.sidePanel:GetRight() <= 0
      or f.bottomPanel:GetBottom() >= height or f.topPanel:GetTop() <= 0
end

---How far the window must move for all of it (sidebar, side panel and both bars) to lie inside the Root.
---@return number dx, number dy
local function onScreenShift(f)
  local width, height = MDT.UI.Root:GetSize()
  local dx = max(0, -f.navigationSidebar:GetLeft()) + min(0, width - f.sidePanel:GetRight())
  local dy = max(0, -f.bottomPanel:GetBottom()) + min(0, height - f.topPanel:GetTop())
  return dx, dy
end

---Anchors the window's saved point to the same named point of the Root, offset by x, y.
local function anchorWindow(x, y)
  local f = MDT.main_frame
  f:ClearAllPoints()
  f:SetPoint(db.anchorFrom, MDT.UI.Root, db.anchorTo, x, y)
end

---Saves where the user moved or resized the normal window to. A window dropped partly off screen stays there, as users
---do on purpose to hide part of it, such as the pull list; one with none of it left on screen goes back to where it
---was. A resized window moves fully on screen unless the user parked it partly off screen.
---@param dropped boolean? the user dragged the window there
local function saveWindowPlacement(dropped)
  local f, Root = MDT.main_frame, MDT.UI.Root
  if isOffScreen(f) then
    MDT:PlaceNormalWindow()
    return
  end
  local point, relativeTo, relativePoint, x, y = f:GetPoint()
  -- The client may leave a moved or sized window anchored to another frame, or by two different points.
  if point ~= relativePoint or (relativeTo ~= Root and relativeTo ~= UIParent) then
    point, relativePoint = "TOPLEFT", "TOPLEFT"
    x, y = f:GetLeft() - Root:GetLeft(), f:GetTop() - Root:GetTop()
  end
  local dx, dy = onScreenShift(f)
  if dropped then db.windowPartlyOffScreen = abs(dx) > 0.01 or abs(dy) > 0.01 end
  if db.windowPartlyOffScreen then dx, dy = 0, 0 end
  db.anchorFrom, db.anchorTo = point, relativePoint
  db.xoffset, db.yoffset = x + dx, y + dy
  anchorWindow(db.xoffset, db.yoffset)
end

local moving
function MDT:RegisterMainFrameDragHandle(dragHandle)
  if not dragHandle then return end

  dragHandle:EnableMouse(true)
  dragHandle:RegisterForDrag("LeftButton")
  dragHandle:SetScript("OnDragStart", function()
    moving = not db.maximized
    if not moving then return end
    MDT.main_frame:SetMovable(true)
    MDT.main_frame:StartMoving()
  end)
  dragHandle:SetScript("OnDragStop", function()
    if not moving then return end
    moving = false
    MDT.main_frame:StopMovingOrSizing()
    MDT.main_frame:SetMovable(false)
    saveWindowPlacement(true)
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
  local closeButton = UI.CloseButton(self.main_frame, { onClick = function() self:HideInterface() end })
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
    self:SetScale(self.main_frame:GetHeight() / sizey)
    saveWindowPlacement()
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

---@param screenWidth number? the Root's width in its own units, default its current one
---@param screenHeight number? the Root's height in its own units, default its current one
function MDT:GetFullScreenSizes(screenWidth, screenHeight)
  if not screenWidth then screenWidth, screenHeight = MDT.UI.Root:GetSize() end
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

---The normal (not maximized) window's scale as shown: the saved one, shrunk to fit the Root. The saved scale stays as
---the user left it, so the window grows back when the Root does.
function MDT:GetNormalWindowScale()
  local _, _, fullscreenScale = MDT:GetFullScreenSizes()
  return min(db.nonFullscreenScale, fullscreenScale)
end

---Anchors the normal window at the saved position, moved just enough for all of it to lie inside the Root. A window
---the user parked partly off screen only moves once none of it shows. The saved position stays as the user left it.
function MDT:PlaceNormalWindow()
  anchorWindow(db.xoffset, db.yoffset)
  if db.windowPartlyOffScreen and not isOffScreen(MDT.main_frame) then return end
  local dx, dy = onScreenShift(MDT.main_frame)
  anchorWindow(db.xoffset + dx, db.yoffset + dy)
end

---Where a named point (e.g. "TOPLEFT") lies on a box, as fractions of its width from the left and height from the bottom.
local function pointFractions(point)
  local x = point:find("LEFT") and 0 or point:find("RIGHT") and 1 or 0.5
  local y = point:find("TOP") and 1 or point:find("BOTTOM") and 0 or 0.5
  return x, y
end

---The normal window's visible top left corner (sidebar and top bar included) from the Root's top left, and its visible
---height, in Root units. While maximized this is where the saved placement puts the normal window.
---@return number left, number top, number height
local function normalWindowCorner()
  local f, Root = MDT.main_frame, MDT.UI.Root
  if not MDT:IsShownMaximized() then
    local top = f.topPanel:GetTop()
    return f.navigationSidebar:GetLeft() - Root:GetLeft(), top - Root:GetTop(), top - f.bottomPanel:GetBottom()
  end
  local rootWidth, rootHeight = Root:GetSize()
  local scale = MDT:GetNormalWindowScale()
  local width, height = sizex * scale, sizey * scale
  local fromX, fromY = pointFractions(db.anchorFrom)
  local toX, toY = pointFractions(db.anchorTo)
  local left = toX * rootWidth + db.xoffset - fromX * width
  local top = toY * rootHeight + db.yoffset + (1 - fromY) * height
  return left - MDT:GetNavigationSidebarWidth(), top + panelHeight - rootHeight, height + 2 * panelHeight
end

---Refits the window to the Root, whose size in its own units changes with the MDT scale and the screen's aspect ratio.
local function fitToRoot()
  local f = MDT.main_frame
  local fullWidth, fullHeight, fullscreenScale = MDT:GetFullScreenSizes()
  local minScale = min(minNonFullscreenScale, fullscreenScale)
  f:SetResizeBounds(sizex * minScale, sizey * minScale, sizex * fullscreenScale, sizey * fullscreenScale)
  -- /mdt reset clears db.maximized and leaves the layout to this refit.
  local shownMaximized = MDT:IsShownMaximized()
  if db.maximized then
    if not shownMaximized or abs(f:GetWidth() - fullWidth) > 0.5 or abs(f:GetHeight() - fullHeight) > 0.5 then MDT:Maximize() end
  elseif shownMaximized or abs(f:GetHeight() - sizey * MDT:GetNormalWindowScale()) > 0.5 then
    MDT:Minimize()
  else
    MDT:PlaceNormalWindow()
  end
end

MDT.UI.OnRootResized(function()
  if framesInitialized then fitToRoot() end
end)

---Sets the MDT scale (1 = 100%) and saves it. The normal window keeps its top left corner and its height on screen:
---before rescaling, it is saved anchored by its top left at the map scale that fills the same height at the new scale,
---at most one that fits the Root at the new scale.
function MDT:SetUserScale(scale)
  scale = MDT.UI.ClampUserScale(scale)
  if not framesInitialized or scale == db.uiScale then
    db.uiScale = MDT.UI.SetUserScale(scale)
    return
  end
  local left, top, height = normalWindowCorner()
  -- How many new Root units one old Root unit spans.
  local ratio = db.uiScale / scale
  local rootWidth, rootHeight = MDT.UI.Root:GetSize()
  local _, _, fullscreenScale = MDT:GetFullScreenSizes(rootWidth * ratio, rootHeight * ratio)
  local windowScale = max(minNonFullscreenScale, (height * ratio - 2 * panelHeight) / sizey)
  db.nonFullscreenScale = min(windowScale, max(minNonFullscreenScale, fullscreenScale))
  db.anchorFrom, db.anchorTo = "TOPLEFT", "TOPLEFT"
  db.xoffset = left * ratio + MDT:GetNavigationSidebarWidth()
  db.yoffset = top * ratio - panelHeight
  db.uiScale = MDT.UI.SetUserScale(scale)
  -- The client may report the Root's new size during the rescale, later or not at all, and may still return its old
  -- size until the next frame: refit on the next frame either way.
  C_Timer.After(0, fitToRoot)
end

local bottomTips = {
  [1] = L["Please report any bugs on https://github.com/Nnoggie/MythicDungeonTools/issues"],
  [2] = L["Hold CTRL to single-select enemies."],
  [3] = L["Hold SHIFT to create a new pull while selecting enemies."],
  [4] = L["Right click a pull for more options."],
  [5] = L["Right click an enemy to open the enemy info window."],
  [6] = L["Drag the bottom right edge to resize MDT."],
  [7] = L["Click the fullscreen button for a maximized view of MDT."],
  [8] = L["Use /mdt reset to restore the default position and scale of MDT."],
  [9] = L["You are using MDT. You rock!"],
  [10] = L["You can choose from different color palettes in the automatic pull coloring settings menu."],
  [11] = L["You can cycle through different floors by holding CTRL and using the mousewheel."],
  [12] = L["altKeyGroupsTip"],
  [13] = L["Mouseover a patrolling enemy with a blue border to view the patrol path."],
  [14] = L["Expand the top toolbar to gain access to drawing and note features."],
  [15] = L["ConnectedTip"],
  [16] = L["EfficiencyScoreTip"],
  [17] = L["ctrlKeyCountTip"],
  [18] = L["enemyDragToPullTip"],
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
    frame.topPanelString:SetFontObject(MDT.UI.Fonts.Get("display"))
    frame.topPanelString:SetTextColor(1, 1, 1, 1)
    frame.topPanelString:SetJustifyH("CENTER")
    frame.topPanelString:SetJustifyV("MIDDLE")
    --frame.topPanelString:SetWidth(600)
    frame.topPanelString:SetHeight(20)
    frame.topPanelString:SetText("Mythic Dungeon Tools")
    frame.topPanelString:ClearAllPoints()
    frame.topPanelString:SetPoint("CENTER", frame.topPanel, "CENTER", 10, 0)
    frame.topPanelString:Show()
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

  MDT:RegisterMainFrameDragHandle(frame.topPanel)

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
  frame.bottomPanelString:SetFontObject(MDT.UI.Fonts.Get("body"))
  frame.bottomPanelString:SetJustifyH("CENTER")
  frame.bottomPanelString:SetJustifyV("MIDDLE")
  frame.bottomPanelString:SetPoint("CENTER", frame.bottomPanel, "CENTER", 0, 0)
  frame.bottomPanelString:SetTextColor(1, 1, 1, 1)
  frame.bottomPanelString:Show()

  frame.bottomLeftPanelString = frame.bottomPanel:CreateFontString("MDTVersion")
  frame.bottomLeftPanelString:SetFontObject(MDT.UI.Fonts.Get("body"))
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
  frame.statusString:SetFontObject(MDT.UI.Fonts.Get("body"))
  frame.statusString:SetJustifyH("RIGHT")
  frame.statusString:SetJustifyV("MIDDLE")
  frame.statusString:SetPoint("RIGHT", frame.bottomPanel, "RIGHT", 0, 0)
  frame.statusString:SetTextColor(1, 1, 1, 1)
  frame.statusString:Hide()

  MDT:RegisterMainFrameDragHandle(frame.bottomPanel)
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
  MDT.copyHelper.text:SetFontObject(MDT.UI.Fonts.Get("display"))
  MDT.copyHelper.text:SetJustifyH("CENTER")
  MDT.copyHelper.text:SetJustifyV("MIDDLE")
  MDT.copyHelper.text:SetText(L["errorLabel3"])
  MDT.copyHelper.text:ClearAllPoints()
  MDT.copyHelper.text:SetPoint("CENTER", MDT.copyHelper, "CENTER")
  MDT.copyHelper.text:Show()
  MDT.copyHelper.text:SetTextColor(1, 1, 0)
  function MDT.copyHelper:SmartFadeOut(seconds)
    seconds = seconds or 0.3
    MDT.copyHelper.isFading = true
    MDT.copyHelper:SetAlpha(1)
    MDT.copyHelper:Show()
    UIFrameFadeOut(MDT.copyHelper, seconds, 1, 0)
    MDT.copyHelper.text:SetText(L["copiedToClipboard"])
    MDT.copyHelper.text:SetTextColor(1, 1, 1)
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
  end

  function MDT.copyHelper:SmartHide()
    if not MDT.copyHelper.isFading then MDT.copyHelper:Hide() end
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
  MDT:RegisterMainFrameDragHandle(frame.sidePanel)

  frame.sidePanel:ClearAllPoints()
  frame.sidePanel:SetWidth(sidePanelWidth)
  frame.sidePanel:SetPoint("TOPLEFT", frame, "TOPRIGHT", 0, 30)
  frame.sidePanel:SetPoint("BOTTOMLEFT", frame, "BOTTOMRIGHT", 0, -30)

end

---Leaves fullscreen and restores the default window position and size and MDT scale 100%.
function MDT:ResetMainFramePos()
  MDT:Async(function()
    if not framesInitialized then MDT:StartMainFrameInitialization() end
    if not framesInitialized then return end
    local defaults = defaultSavedVars.global
    db.maximized = false
    db.nonFullscreenScale = defaults.nonFullscreenScale
    db.anchorFrom, db.anchorTo = defaults.anchorFrom, defaults.anchorTo
    db.xoffset, db.yoffset = defaults.xoffset, defaults.yoffset
    db.windowPartlyOffScreen = defaults.windowPartlyOffScreen
    local rescaled
    db.uiScale, rescaled = MDT.UI.SetUserScale(defaults.uiScale)
    -- A rescaled Root changes size, and its refit lays the window out.
    if not rescaled then MDT:Minimize() end
    MDT:Settings_Refresh()
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
  main_frame:HookScript("OnHide", function()
    MDT.UI.Escape.Remove(escapeEntry)
    MDT.UI.Overlay.PopAll("menu", "hidden")
    MDT.UI.Overlay.PopAll("popover", "hidden")
  end)
  MDT.UI.Dialogs.SetDefaultParent(function() return MDT.main_frame end)

  if MDT.InitializeDevModeCache then MDT:InitializeDevModeCache() end

  db.scale = db.maximized and select(3, MDT:GetFullScreenSizes()) or MDT:GetNormalWindowScale()
  main_frame:SetFrameStrata(mainFrameStrata)
  main_frame:SetFrameLevel(1)
  MDT:RegisterMainFrameDragHandle(main_frame)
  main_frame.background = main_frame:CreateTexture(nil, "BACKGROUND", nil, 0)
  main_frame.background:SetAllPoints()
  main_frame.background:SetDrawLayer(canvasDrawLayer, 1)
  main_frame.background:SetColorTexture(unpack(MDT.BackdropColor))
  main_frame.background:SetAlpha(0)
  main_frame:SetSize(sizex * db.scale, sizey * db.scale)
  main_frame:SetResizable(true)
  MDT.main_frame = main_frame

  main_frame.mainFrametex = main_frame:CreateTexture(nil, "BACKGROUND", nil, 0)
  main_frame.mainFrametex:SetAllPoints()
  main_frame.mainFrametex:SetDrawLayer(canvasDrawLayer, -5)
  main_frame.mainFrametex:SetColorTexture(unpack(MDT.BackdropColor))

  ---@diagnostic disable-next-line: redundant-parameter
  local version = C_AddOns.GetAddOnMetadata(MDT.AddonName, "Version"):gsub("%.", "")
  db.version = tonumber(version)
  -- Set frame position
  anchorWindow(db.xoffset, db.yoffset)
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

  framesInitialized = true
  --Maximize if needed
  if db.maximized then MDT:Maximize() end
  fitToRoot()
  initSpinner:Hide()
  initSpinner.Anim:Stop()
  local callbacks = frameInitializedCallbacks
  frameInitializedCallbacks = {}
  for _, callback in ipairs(callbacks) do
    callback()
  end
end
