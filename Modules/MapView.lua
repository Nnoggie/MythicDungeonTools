local _, MDT = ...
local L = MDT.L
local canvasDrawLayer = "BORDER"

local tinsert, CreateFrame, tonumber, max, min, abs, pairs, ipairs, GetCursorPosition, GameTooltip =
    table.insert, CreateFrame, tonumber, math.max, math.min, math.abs, pairs, ipairs, GetCursorPosition, GameTooltip

local sizex = 840
local sizey = 555
local db

local function initializeDB()
  db = db or MDT:GetDB()
end

local function createAlphaWatermarkLabel(frame)
  local label = frame:CreateFontString(nil, canvasDrawLayer)
  label:SetDrawLayer(canvasDrawLayer, 6)
  label:SetFont("Fonts\\ARIALN.TTF", 40, "")
  label:SetText("ALPHA")
  label:SetTextColor(1, 1, 1, 0.25)

  local animationGroup = label:CreateAnimationGroup()
  local rotation = animationGroup:CreateAnimation("Rotation")
  rotation:SetDegrees(45)
  rotation:SetOrigin("CENTER", 0, 0)
  rotation:SetDuration(0.01)
  rotation:SetEndDelay(10 ^ 8)
  animationGroup:Play()

  return label
end

local function layoutAlphaWatermark(frame)
  local labels = frame.alphaWatermarkLabels
  if not labels then return end

  local spacingX, spacingY = 170, 110
  local columns = math.ceil(frame:GetWidth() / spacingX)
  local rows = math.ceil(frame:GetHeight() / spacingY)
  local labelIndex = 0

  for row = 0, rows do
    local rowOffset = row % 2 == 0 and 0 or spacingX / 2
    for column = -1, columns do
      labelIndex = labelIndex + 1
      local label = labels[labelIndex]
      if not label then
        label = createAlphaWatermarkLabel(frame)
        labels[labelIndex] = label
      end
      label:ClearAllPoints()
      label:SetPoint("CENTER", frame, "TOPLEFT", column * spacingX + rowOffset, -row * spacingY)
      label:Show()
    end
  end

  for i = labelIndex + 1, #labels do
    labels[i]:Hide()
  end
end

local function createAlphaWarning(frame)
  local warning = CreateFrame("Frame", "MDTAlphaWarningFrame", frame, "BackdropTemplate")
  warning:SetSize(390, 82)
  warning:SetPoint("TOPRIGHT", frame, "TOPRIGHT", 0, 0)
  warning:SetFrameStrata("HIGH")
  warning:SetFrameLevel(60)
  warning:EnableMouse(true)
  warning:SetBackdrop({
    bgFile = "Interface\\Buttons\\WHITE8X8",
    edgeFile = "Interface\\Buttons\\WHITE8X8",
    edgeSize = 1,
  })
  warning:SetBackdropColor(unpack(MDT.BackdropColor))
  warning:SetBackdropBorderColor(1, 0, 0, 1)

  local icon = warning:CreateTexture(nil, "ARTWORK")
  icon:SetTexture("Interface\\AddOns\\"..MDT.AddonName.."\\Textures\\icons")
  icon:SetTexCoord(0.75, 1, 0.25, 0.5)
  icon:SetSize(48, 48)
  icon:SetPoint("LEFT", warning, "LEFT", 8, 0)

  local close = CreateFrame("Button", nil, warning, "UIPanelCloseButton")
  close:SetSize(22, 22)
  close:SetPoint("TOPRIGHT", warning, "TOPRIGHT", -1, -1)
  close:SetScript("OnClick", function()
    warning:Hide()
    if MDT.copyHelper then MDT.copyHelper:SmartHide() end
  end)

  local title = warning:CreateFontString(nil, "OVERLAY", "GameFontNormal")
  title:SetPoint("TOPLEFT", warning, "TOPLEFT", 64, -8)
  title:SetWidth(296)
  title:SetJustifyH("LEFT")
  title:SetText(L["Alpha Version! Mapping will be inaccurate!"])
  title:SetTextColor(1, 0.15, 0.15)

  warning.linkRow = MDT:CreateCopyableLinkRow(warning, "Discord", MDT.externalLinks[2].url, {
    width = 318,
    buttonWidth = 72,
    point = true,
    xOffset = 64,
    yOffset = -25,
    label = L["Report enemy positions in Discord:"],
    copyHelperAnchor = frame,
    copyHelperY = 50,
  })
  warning.linkRow.editBox.label:SetTextColor(1, 1, 1)

  frame.alphaWarningFrame = warning
  frame:HookScript("OnShow", function()
    layoutAlphaWatermark(frame.mapPanelFrame)
    warning:Show()
  end)
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

function MDT:GetPullMapCenter(pull)
  local pullData = self:GetCurrentPreset().value.pulls[pull]
  if not pullData then return end

  local currentSublevel = self:GetCurrentSubLevel()
  local scale = self:GetScale()
  local minX, maxX, minY, maxY
  for enemyIdx, clones in pairs(pullData) do
    local enemy = tonumber(enemyIdx) and self.dungeonEnemies[db.currentDungeonIdx][enemyIdx]
    if enemy then
      for _, cloneIdx in pairs(clones) do
        local clone = enemy.clones[cloneIdx]
        if clone and (clone.sublevel == currentSublevel or not clone.sublevel) then
          local x = clone.x * scale
          local y = clone.y * scale
          minX = minX and min(minX, x) or x
          maxX = maxX and max(maxX, x) or x
          minY = minY and min(minY, y) or y
          maxY = maxY and max(maxY, y) or y
        end
      end
    end
  end

  if not minX then return end
  return (minX + maxX) / 2, (minY + maxY) / 2
end

function MDT:PanMapToPull(pull)
  local centerX, centerY = self:GetPullMapCenter(pull)
  if not centerX then return end

  local scrollFrame = MDTScrollFrame
  local mapPanelFrame = MDTMapPanelFrame
  if not scrollFrame or not mapPanelFrame or not scrollFrame:GetLeft() then return end

  self:ZoomMap(0)
  local zoomScale = mapPanelFrame:GetScale()
  local targetH = centerX - scrollFrame:GetWidth() / (2 * zoomScale)
  local targetV = -centerY - scrollFrame:GetHeight() / (2 * zoomScale)
  targetH = max(0, min(targetH, scrollFrame.maxX or 0))
  targetV = max(0, min(targetV, scrollFrame.maxY or 0))

  local animationGroup = scrollFrame.autoPanAnimation
  if animationGroup and animationGroup:IsPlaying() then
    animationGroup:Stop()
  end

  scrollFrame.panning = false
  scrollFrame.isFadeOutPanning = false

  local startH = scrollFrame:GetHorizontalScroll()
  local startV = scrollFrame:GetVerticalScroll()
  if abs(startH - targetH) < 1 and abs(startV - targetV) < 1 then
    scrollFrame:SetHorizontalScroll(targetH)
    scrollFrame:SetVerticalScroll(targetV)
    return
  end

  local panData = scrollFrame.autoPanAnimationData
  if not animationGroup then
    panData = {}
    animationGroup = scrollFrame:CreateAnimationGroup()
    local animation = animationGroup:CreateAnimation("Animation")
    animation:SetDuration(0.45)
    animation:SetSmoothing("OUT")
    animation:SetScript("OnUpdate", function()
      local progress = animation:GetSmoothProgress()
      scrollFrame:SetHorizontalScroll(panData.startH + (panData.targetH - panData.startH) * progress)
      scrollFrame:SetVerticalScroll(panData.startV + (panData.targetV - panData.startV) * progress)
    end)
    animation:SetScript("OnFinished", function()
      scrollFrame:SetHorizontalScroll(panData.targetH)
      scrollFrame:SetVerticalScroll(panData.targetV)
    end)
    scrollFrame.autoPanAnimation = animationGroup
    scrollFrame.autoPanAnimationData = panData
  end

  panData.startH = startH
  panData.startV = startV
  panData.targetH = targetH
  panData.targetV = targetV
  animationGroup:Play()
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

---Returns the sublevel of the currently active preset
function MDT:GetCurrentSubLevel()
  return MDT:GetCurrentPreset().value.currentSublevel
end

function MDT:MakeMapTexture(frame)
  initializeDB()
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

    local version = C_AddOns.GetAddOnMetadata(MDT.AddonName, "Version")
    if version and version:lower():find("-alpha", 1, true) then
      frame.mapPanelFrame.alphaWatermarkLabels = {}
      frame.mapPanelFrame:SetScript("OnSizeChanged", layoutAlphaWatermark)
      createAlphaWarning(frame)
    end

    frame.scrollFrame:SetScrollChild(frame.mapPanelFrame)
    frame.scrollFrame.cursorX = 0
    frame.scrollFrame.cursorY = 0
    frame.scrollFrame.queuedDeltaX = 0;
    frame.scrollFrame.queuedDeltaY = 0;
  end
end

function MDT:GetTileFormat(dungeonIdx, sublevel)
  local mapInfo = MDT.mapInfo[dungeonIdx]
  return mapInfo and mapInfo.tileFormat and mapInfo.tileFormat[sublevel] or 4
end

function MDT:UpdateMap(ignoreSetSelection, ignoreReloadPullButtons, ignoreUpdateProgressBar, async)
  initializeDB()
  MDT:CancelAsync("UpdateMap")
  MDT:CancelAsync("ReloadPullButtons")
  MDT:CancelAsync("DrawAllHulls")
  if not MDT:AreFramesInitialized() then coroutine.yield() end
  local mapName
  local frame = MDT.main_frame
  mapName = MDT.dungeonMaps[db.currentDungeonIdx][0]
  MDT:EnsureDBTables()
  if not MDT:AreFramesInitialized() then coroutine.yield() end
  local preset = MDT:GetCurrentPreset()
  if preset.difficulty then
    db.currentDifficulty = preset.difficulty
    frame.sidePanel.DifficultySlider:SetValue(db.currentDifficulty)
  end
  if not MDT:AreFramesInitialized() then coroutine.yield() end
  local textureInfo = MDT.dungeonMaps[db.currentDungeonIdx][preset.value.currentSublevel]
  if type(textureInfo) == "string" then --textures from blizzard files
    local path = "Interface\\WorldMap\\"..mapName.."\\"
    local tileFormat = MDT:GetTileFormat(db.currentDungeonIdx, preset.value.currentSublevel)
    if not MDT:AreFramesInitialized() then coroutine.yield() end
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
    if not MDT:AreFramesInitialized() then coroutine.yield() end
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
  if not MDT:AreFramesInitialized() then coroutine.yield() end
  MDT:Async(function()
    coroutine.yield()
    if not db.devMode then MDT:ZoomMapToDefault() end
    MDT:DungeonEnemies_UpdateEnemiesAsync()
    MDT:POI_UpdateAll()
    if not ignoreReloadPullButtons then
      MDT:ReloadPullButtons(true)
    end
    if not MDT:AreFramesInitialized() then coroutine.yield() end
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
    if not MDT:AreFramesInitialized() then coroutine.yield() end
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
    if not MDT:AreFramesInitialized() then coroutine.yield() end
    if not ignoreSetSelection then MDT:SetSelectionToPull(preset.value.currentPull) end
    if MDT.pendingAutoPanToPull then
      local pull = MDT.pendingAutoPanToPull
      MDT.pendingAutoPanToPull = nil
      if db.autoPanToPull ~= false then MDT:PanMapToPull(pull) end
    end
    MDT:UpdateDungeonDropDown()
    if not MDT:AreFramesInitialized() then coroutine.yield() end
    MDT:DrawAllPresetObjects()
    if not MDT:AreFramesInitialized() then coroutine.yield() end
    MDT:UpdateProgressbar()
  end, "UpdateMap", true)
end

---Updates the map to the specified dungeon
function MDT:UpdateToDungeon(dungeonIdx, ignoreUpdateMap, init)
  initializeDB()
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

--contains zoneIds to auto swap to corresponding dungeon when opening the AddOn
--ids are added in each dungeon file
--https://wowpedia.fandom.com/wiki/UiMapID
MDT.zoneIdToDungeonIdx = {}

local lastUpdatedDungeonIdx
function MDT:CheckCurrentZone(init)
  initializeDB()
  if C_ChallengeMode.IsChallengeModeActive() then return end
  local zoneId = C_Map.GetBestMapForUnit("player")
  local dungeonIdx = MDT.zoneIdToDungeonIdx[zoneId]
  if dungeonIdx and (not lastUpdatedDungeonIdx or dungeonIdx ~= lastUpdatedDungeonIdx) then
    lastUpdatedDungeonIdx = dungeonIdx
    MDT:UpdateToDungeon(dungeonIdx, nil, init)
    MDT:SetDungeonList(nil, dungeonIdx)
  end
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
