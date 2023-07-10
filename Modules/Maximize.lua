local MDT = MDT
local db
local sizex, sizey
local canvasDrawLayer = "BORDER"

--Fullscreen the AddOn Window
function MDT:Maximize()
  db = MDT:GetDB()
  sizex, sizey = MDT:GetDefaultMapPanelSize()
  local f = MDT.main_frame

  local oldScrollH = f.scrollFrame:GetHorizontalScroll()
  local oldScrollV = f.scrollFrame:GetVerticalScroll()
  local oldSizeX = f.scrollFrame:GetWidth()
  local oldSizeY = f.scrollFrame:GetHeight()
  if not f.blackoutFrame then
    f.blackoutFrame = CreateFrame("Frame", "MDTBlackoutFrame", f)
    f.blackoutFrame:EnableMouse(true)
    f.blackoutFrameTex = f.blackoutFrame:CreateTexture(nil, "BACKGROUND", nil, 0)
    f.blackoutFrameTex:SetAllPoints()
    f.blackoutFrameTex:SetDrawLayer(canvasDrawLayer, -6)
    f.blackoutFrameTex:SetColorTexture(0.058823399245739, 0.058823399245739, 0.058823399245739, 1)
    f.blackoutFrame:ClearAllPoints()
    f.blackoutFrame:SetAllPoints(UIParent)
  end
  f.blackoutFrame:Show()
  f.topPanel:SetMouseClickEnabled(false)
  f.bottomPanel:SetMouseClickEnabled(false)
  local newSizex, newSizey, scale, isNarrow = MDT:GetFullScreenSizes()
  db.scale = scale
  f:ClearAllPoints()
  if not isNarrow then
    f:SetPoint("TOP", UIParent, "TOP", -(f.sidePanel:GetWidth() / 2), -30)
  else
    f:SetPoint("LEFT", UIParent, "LEFT")
  end
  f:SetSize(newSizex, newSizey)
  f.scrollFrame:SetSize(newSizex, newSizey)
  f.mapPanelFrame:SetSize(newSizex, newSizey)
  for i = 1, 12 do
    f["mapPanelTile"..i]:SetSize((newSizex / 4 + 5 * db.scale), (newSizex / 4 + 5 * db.scale))
  end
  for i = 1, 10 do
    for j = 1, 15 do
      f["largeMapPanelTile"..i..j]:SetSize(newSizex / 15, newSizex / 15)
    end
  end
  f.scrollFrame:SetVerticalScroll(oldScrollV * (newSizey / oldSizeY))
  f.scrollFrame:SetHorizontalScroll(oldScrollH * (newSizex / oldSizeX))
  f.scrollFrame.cursorY = f.scrollFrame.cursorY * (newSizey / oldSizeY)
  f.scrollFrame.cursorX = f.scrollFrame.cursorX * (newSizex / oldSizeX)
  MDT:ZoomMap(0)
  MDT:UpdateEnemyInfoFrame()
  MDT:UpdateMap()
  if db.devMode then
    f.devPanel:ClearAllPoints()
    f.devPanel:SetPoint("TOPLEFT", f, "TOPLEFT", 0, -45)
  end
  f.resizer:Hide()
  if MDT:IsDragonflight() then
    MDT:CreateTutorialButton(MDT.main_frame)
  end
  db.maximized = true
end

---Restore normal AddOn Window
function MDT:Minimize()
  db = MDT:GetDB()
  sizex, sizey = MDT:GetDefaultMapPanelSize()
  local f = MDT.main_frame

  local oldScrollH = f.scrollFrame:GetHorizontalScroll()
  local oldScrollV = f.scrollFrame:GetVerticalScroll()
  local oldSizeX = f.scrollFrame:GetWidth()
  local oldSizeY = f.scrollFrame:GetHeight()
  if f.blackoutFrame then f.blackoutFrame:Hide() end
  f.topPanel:SetMouseClickEnabled(true)
  f.bottomPanel:SetMouseClickEnabled(true)
  db.scale = db.nonFullscreenScale
  local newSizex = sizex * db.scale
  local newSizey = sizey * db.scale
  f:ClearAllPoints()
  f:SetPoint(db.anchorTo, UIParent, db.anchorFrom, db.xoffset, db.yoffset)
  f:SetSize(newSizex, newSizey)
  f.scrollFrame:SetSize(newSizex, newSizey)
  f.mapPanelFrame:SetSize(newSizex, newSizey)
  for i = 1, 12 do
    f["mapPanelTile"..i]:SetSize(newSizex / 4 + (5 * db.scale), newSizex / 4 + (5 * db.scale))
  end
  for i = 1, 10 do
    for j = 1, 15 do
      f["largeMapPanelTile"..i..j]:SetSize(newSizex / 15, newSizex / 15)
    end
  end
  f.scrollFrame:SetVerticalScroll(oldScrollV * (newSizey / oldSizeY))
  f.scrollFrame:SetHorizontalScroll(oldScrollH * (newSizex / oldSizeX))
  f.scrollFrame.cursorY = f.scrollFrame.cursorY * (newSizey / oldSizeY)
  f.scrollFrame.cursorX = f.scrollFrame.cursorX * (newSizex / oldSizeX)
  MDT:ZoomMap(0)
  MDT:UpdateEnemyInfoFrame()
  MDT:UpdateMap()
  if db.devMode then
    f.devPanel:ClearAllPoints()
    f.devPanel:SetPoint("TOPRIGHT", f.topPanel, "TOPLEFT", 0, 0)
  end
  f.resizer:Show()
  if MDT:IsDragonflight() then
    MDT:CreateTutorialButton(MDT.main_frame)
  end

  db.maximized = false
end
