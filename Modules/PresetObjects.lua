local _, MDT = ...
local L = MDT.L
local objectDrawLayer = "OVERLAY"
local AceGUI = LibStub("AceGUI-3.0")

local twipe, tinsert, tremove, pi, max, pairs, ipairs, GameTooltip =
    table.wipe, table.insert, table.remove, math.pi, math.max, pairs, ipairs, GameTooltip

---TexturePool
local activeTextures = {}
local texturePool = {}
local noteFramePool
MDT.presetObjectActiveTextures = activeTextures
MDT.drawingActive = false

local function getTexture()
  local size = #texturePool
  if size == 0 then
    return MDT.main_frame.mapPanelFrame:CreateTexture(nil, "OVERLAY", nil, 0)
  else
    local tex = texturePool[size]
    tremove(texturePool, size)
    tex:SetRotation(0)
    tex:SetTexCoord(0, 1, 0, 1)
    tex:ClearAllPoints()
    tex.coords = nil
    tex.points = nil
    return tex
  end
end

function MDT:AcquirePresetObjectTexture()
  return getTexture()
end

local function releaseTexture(tex)
  tex:Hide()
  tinsert(texturePool, tex)
end

---ReleaseAllActiveTextures
function MDT:ReleaseAllActiveTextures()
  for k, tex in pairs(activeTextures) do
    releaseTexture(tex)
  end
  twipe(activeTextures)
  if noteFramePool then noteFramePool:ReleaseAll() end
end

function MDT:SetPresetNotesMovable(movable)
  if not noteFramePool then return end
  if movable then
    for _, note in pairs(noteFramePool.active) do
      note:SetMovable(true)
      note:RegisterForDrag("LeftButton")
      local xOffset, yOffset

      note:SetScript("OnMouseDown", function()
        local currentPreset = MDT:GetCurrentPreset()
        local x, y = MDT:GetCursorPosition()
        local scale = MDT:GetScale()
        x = x * (1 / scale)
        y = y * (1 / scale)
        local nx = currentPreset.objects[note.objectIndex].d[1]
        local ny = currentPreset.objects[note.objectIndex].d[2]
        xOffset = x - nx
        yOffset = y - ny
      end)
      note:SetScript("OnDragStart", function()
        note:StartMoving()
      end)
      note:SetScript("OnDragStop", function()
        note:StopMovingOrSizing()
        local x, y = MDT:GetCursorPosition()
        local scale = MDT:GetScale()
        x = x * (1 / scale)
        y = y * (1 / scale)
        local currentPreset = MDT:GetCurrentPreset()
        currentPreset.objects[note.objectIndex].d[1] = x - xOffset
        currentPreset.objects[note.objectIndex].d[2] = y - yOffset
        if MDT.liveSessionActive then
          MDT:LiveSession_SendNoteCommand("move", note.objectIndex, x - xOffset, y - yOffset)
        end
        MDT:DrawAllPresetObjects()
      end)
    end
  else
    for _, note in pairs(noteFramePool.active) do
      note:SetMovable(false)
      note:RegisterForDrag()
    end
  end
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
    tinsert(preset.objects, pos, CopyTable(obj))
  else
    tinsert(preset.objects, CopyTable(obj))
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
      --check if color is valid
      if not color.r or not color.g or not color.b then
        color.r, color.g, color.b = 1, 1, 1
        obj.d[5] = "ffffff"
      end
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
  if not MDT:AreFramesInitialized() then return end
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
  if not MDT:AreFramesInitialized() then return end
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

---StartMovingObject
local objectIndex
local originalX, originalY
function MDT:StartMovingObject()
  --we have to redraw all objects first, as the objectIndex needs to be set on every texture
  MDT:DrawAllPresetObjects()
  MDT.drawingActive = true
  local frame = MDT.main_frame
  objectIndex = MDT:GetHighestPresetObjectIndexAtCursor()
  local startx, starty = MDT:GetCursorPosition()
  originalX, originalY = MDT:GetCursorPosition()
  frame.toolbar:SetScript("OnUpdate", function(self, tick)
    if not MDTScrollFrame:IsMouseOver() then return end
    local x, y = MDT:GetCursorPosition()
    if x ~= startx or y ~= starty then
      for j, tex in pairs(activeTextures) do
        if tex.objectIndex == objectIndex then
          for i = 1, tex:GetNumPoints() do
            local point, relativeTo, relativePoint, xOffset, yOffset = tex:GetPoint(i)
            tex:SetPoint(point, relativeTo, relativePoint, xOffset + (x - startx), yOffset + (y - starty))
          end
        end
      end
      startx, starty = MDT:GetCursorPosition()
    end
  end)
end

---HideAllPresetObjects
---Hide textures during rescaling
function MDT:HideAllPresetObjects()
  --drawings
  for _, tex in pairs(activeTextures) do
    tex:Hide()
  end
  --notes
  if noteFramePool then
    for _, note in pairs(noteFramePool.active) do
      note:Hide()
    end
  end
end

---StopMovingDrawing
function MDT:StopMovingObject()
  local frame = MDT.main_frame
  frame.toolbar:SetScript("OnUpdate", nil)
  if objectIndex then
    local newX, newY = MDT:GetCursorPosition()
    MDT:UpdatePresetObjectOffsets(objectIndex, originalX - newX, originalY - newY)
    if self.liveSessionActive then self:LiveSession_SendObjectOffsets(objectIndex, originalX - newX, originalY - newY) end
  end
  objectIndex = nil
  MDT.drawingActive = false
end

---GetHighestPresetObjectIndexAtCursor
function MDT:GetHighestPresetObjectIndexAtCursor()
  local currentSublevel = -8
  local highestTexture
  for k, v in pairs(activeTextures) do
    if v:IsMouseOver() and v:IsShown() then
      local _, sublevel = v:GetDrawLayer()
      if sublevel >= currentSublevel then
        highestTexture = v
      end
      currentSublevel = max(currentSublevel, sublevel + 1)
    end
  end
  if highestTexture then
    return highestTexture.objectIndex
  end
end

---StartEraserDrawing
local changedObjects = {}
function MDT:StartEraserDrawing()
  MDT:DrawAllPresetObjects()
  MDT.drawingActive = true
  local frame = MDT.main_frame
  local startx, starty
  local scale = MDT:GetScale()
  twipe(changedObjects)
  frame.toolbar:SetScript("OnUpdate", function(self, tick)
    if not MDTScrollFrame:IsMouseOver() then return end
    local x, y = MDT:GetCursorPosition()
    if x ~= startx or y ~= starty then
      local highestObjectIdx = MDT:GetHighestPresetObjectIndexAtCursor()
      for j, tex in pairs(activeTextures) do
        if tex:IsMouseOver() and tex:IsShown() and tex.objectIndex == highestObjectIdx then --tex.coords means this is a line
          tex:Hide()
          if tex.coords then
            local x1, y1, x2, y2 = unpack(tex.coords)
            --hide circle textures of lines
            for k, v in pairs(activeTextures) do
              if v.points then
                if (v.points[1] == x1 and v.points[2] == y1) or (v.points[1] == x2 and v.points[2] == y2) then
                  v:Hide()
                end
              end
            end
            --delete saved lines
            local currentPreset = MDT:GetCurrentPreset()
            for objectIndex, obj in pairs(currentPreset.objects) do
              if objectIndex == highestObjectIdx then
                for coordIdx, coord in pairs(obj.l) do
                  if coord * scale == x1 and obj.l[coordIdx + 1] * scale == y1 and obj.l[coordIdx + 2] * scale == x2 and
                      obj.l[coordIdx + 3] * scale == y2 then
                    for i = 1, 4 do tremove(obj.l, coordIdx) end
                    changedObjects[objectIndex] = obj
                    break
                  end
                end
              end
            end
          end
          break
        end
      end
      startx, starty = x, y
    end
  end)
end

---StopEraserDrawing
function MDT:StopEraserDrawing()
  local frame = MDT.main_frame
  frame.toolbar:SetScript("OnUpdate", nil)
  if self.liveSessionActive then self:LiveSession_SendUpdatedObjects(changedObjects) end
  MDT:DrawAllPresetObjects()
  MDT.drawingActive = false
end

---DrawCircle
function MDT:DrawCircle(x, y, size, color, layer, layerSublevel, isOwn, objectIndex, tex, noinsert, extrax, extray)
  local circle = tex or getTexture()
  if not layer then layer = objectDrawLayer end
  circle:SetDrawLayer(layer, layerSublevel)
  circle:SetTexture("Interface\\AddOns\\MythicDungeonTools\\Textures\\Circle_White")
  circle:SetVertexColor(color.r, color.g, color.b, color.a)
  circle:SetWidth(1.1 * size)
  circle:SetHeight(1.1 * size)
  circle:ClearAllPoints()
  circle:SetPoint("CENTER", MDT.main_frame.mapPanelTile1, "TOPLEFT", x, y)
  circle:Show()
  circle.isOwn = isOwn
  circle.objectIndex = objectIndex
  circle.points = { x, y, extrax, extray }
  if not noinsert then
    tinsert(activeTextures, circle)
  end
end

---DrawLine
function MDT:DrawLine(x, y, a, b, size, color, smooth, layer, layerSublevel, lineFactor, isOwn, objectIndex)
  local line = getTexture()
  if not layer then layer = objectDrawLayer end
  line:SetTexture("Interface\\AddOns\\MythicDungeonTools\\Textures\\Square_White")
  line:SetVertexColor(color.r, color.g, color.b, color.a)
  DrawLine(line, MDT.main_frame.mapPanelTile1, x, y, a, b, size, lineFactor and lineFactor or 1.1, "TOPLEFT")
  line:SetDrawLayer(layer, layerSublevel)
  line:Show()
  line.isOwn = isOwn
  line.objectIndex = objectIndex
  line.coords = { x, y, a, b }
  tinsert(activeTextures, line)
  if smooth == true then
    MDT:DrawCircle(x, y, size, color, layer, layerSublevel, isOwn, objectIndex)
  end
end

---DrawTriangle
function MDT:DrawTriangle(x, y, rotation, size, color, layer, layerSublevel, isOwn, objectIndex)
  local triangle = getTexture()
  if not layer then layer = objectDrawLayer end
  triangle:SetTexture("Interface\\AddOns\\MythicDungeonTools\\Textures\\triangle")
  triangle:SetVertexColor(color.r, color.g, color.b, color.a)
  triangle:Show()
  triangle:SetWidth(size)
  triangle:SetHeight(size)
  triangle:SetRotation(rotation + pi)
  triangle:ClearAllPoints()
  triangle:SetPoint("CENTER", MDT.main_frame.mapPanelTile1, "TOPLEFT", x, y)
  triangle:SetDrawLayer(layer, layerSublevel)
  triangle.isOwn = isOwn
  triangle.objectIndex = objectIndex
  tinsert(activeTextures, triangle)
end

local noteEditbox

--store text in nobj
local function updateNoteObjText(text, note)
  local currentPreset = MDT:GetCurrentPreset()
  currentPreset.objects[note.objectIndex].d[5] = text
  if MDT.liveSessionActive then MDT:LiveSession_SendNoteCommand("text", note.objectIndex, text) end
end

local function deleteNoteObj(note)
  local currentPreset = MDT:GetCurrentPreset()
  tremove(currentPreset.objects, note.objectIndex)
  if MDT.liveSessionActive then MDT:LiveSession_SendNoteCommand("delete", note.objectIndex, "0") end
  MDT:DrawAllPresetObjects()
end

local function makeNoteEditbox()
  local editbox = AceGUI:Create("SimpleGroup")
  editbox.frame:SetParent(MDT.main_frame)
  editbox:SetWidth(240)
  editbox:SetHeight(120)
  editbox.frame:SetFrameStrata("DIALOG")
  editbox.frame:SetFrameLevel(50)
  if not editbox.frame.SetBackdrop then
    Mixin(editbox.frame, BackdropTemplateMixin)
  end
  editbox.frame:SetBackdropColor(unpack(MDT.BackdropColor))
  editbox:SetLayout("Flow")
  editbox.multiBox = AceGUI:Create("MultiLineEditBox")
  editbox.multiBox:SetLabel(L["Note Text:"])

  editbox.multiBox:SetCallback("OnEnterPressed", function(widget, callbackName, text)
    for _, note in pairs(noteFramePool.active) do
      if note.noteIdx == editbox.noteIdx then
        note.tooltipText = text
        updateNoteObjText(text, note)
        break
      end
    end
    editbox.frame:Hide()
  end)

  editbox.multiBox:SetWidth(240)
  editbox.multiBox:SetHeight(120)
  editbox.multiBox.label:Hide()
  --[[ hiding the scrollbar messes up the whole editbox
    editbox.multiBox.scrollBar:Hide()
    editbox.multiBox.scrollBar:ClearAllPoints()
    editbox.multiBox.scrollBar:SetPoint("BOTTOM", editbox.multiBox.button, "TOP", 0, 16)
    editbox.multiBox.scrollBar.ScrollUpButton:SetPoint("BOTTOM", editbox.multiBox.scrollBar, "TOP",0,3)
    ]]
  editbox.frame:Hide()
  editbox:AddChild(editbox.multiBox)
  MDT:FixAceGUIShowHide(editbox, nil, nil, true)
  editbox.frame:SetScript("OnShow", function()
    hooksecurefunc(MDT, "MouseDownHook", function() editbox.frame:Hide() end)
    hooksecurefunc(MDT, "ZoomMap", function() editbox.frame:Hide() end)
  end)

  return editbox
end

local currentNote

local function openContextMenu()
  MDT:CreateContextMenu(MDT.main_frame, function(ownerRegion, rootDescription)
    rootDescription:CreateButton(L["Edit"], function()
      currentNote:OpenEditBox()
    end)
    rootDescription:CreateButton(L["Delete"], function()
      deleteNoteObj(currentNote)
    end)
    rootDescription:CreateButton(L["Close"], function() end)
  end)
end

local function POIButton_CalculateNumericTexCoords(index, color)
  if index then
    color = color or 0.5;
    local iconIndex = index - 1;
    local yOffset = color + floor(iconIndex / 8) * 0.125;
    local xOffset = mod(iconIndex, 8) * 0.125;
    return xOffset, xOffset + 0.125, yOffset, yOffset + 0.125;
  end
end

---DrawNote
function MDT:DrawNote(x, y, text, objectIndex)
  if not noteFramePool then
    noteFramePool = MDT.CreateFramePool("Button", MDT.main_frame.mapPanelFrame, "QuestPinTemplate")
  end
  local scale = MDT:GetScale()
  --setup
  local note = noteFramePool:Acquire()
  note.noteIdx = #noteFramePool.active
  note.objectIndex = objectIndex
  note:ClearAllPoints()
  note:SetPoint("CENTER", MDT.main_frame.mapPanelTile1, "TOPLEFT", x, y)
  note:SetSize(12 * scale, 12 * scale)
  local idx = note.noteIdx % 25
  if idx == 0 then idx = 1 end

  local texture = note.NormalTexture
  local highlight = note.HighlightTexture
  local number = note.Display.Icon
  local pushed = note.PushedTexture
  texture:SetSize(15 * scale, 15 * scale)
  texture:SetTexture("Interface/WorldMap/UI-QuestPoi-NumberIcons")
  texture:SetTexCoord(0.500, 0.625, 0.375, 0.5)
  highlight:SetSize(15 * scale, 15 * scale)
  highlight:SetTexture("Interface/WorldMap/UI-QuestPoi-NumberIcons")
  highlight:SetTexCoord(0.625, 0.750, 0.375, 0.5)
  number:SetSize(16 * scale, 16 * scale)
  number:SetTexture("Interface/WorldMap/UI-QuestPoi-NumberIcons")
  number:SetTexCoord(POIButton_CalculateNumericTexCoords(idx, 0))
  number:Show()
  pushed:SetSize(15 * scale, 15 * scale)
  pushed:SetTexture("Interface/WorldMap/UI-QuestPoi-NumberIcons")
  pushed:SetTexCoord(0.375, 0.500, 0.375, 0.5)
  note.tooltipText = text or ""

  note:RegisterForClicks("AnyUp")
  --click
  function note:OpenEditBox()
    if not noteEditbox then noteEditbox = makeNoteEditbox() end
    if noteEditbox.frame:IsShown() and noteEditbox.noteIdx == note.noteIdx then
      noteEditbox.frame:Hide()
    else
      noteEditbox.noteIdx = note.noteIdx
      noteEditbox:ClearAllPoints()
      noteEditbox.frame:SetPoint("TOPLEFT", note, "TOPRIGHT")
      noteEditbox.frame:Show()
      noteEditbox.multiBox:SetText(note.tooltipText)
      noteEditbox.multiBox.button:Enable()
    end
  end

  note:SetScript("OnClick", function(self, button, down)
    if button == "LeftButton" then
      CloseDropDownMenus()
      self:OpenEditBox()
    elseif button == "RightButton" then
      currentNote = note
      openContextMenu()
      if noteEditbox and noteEditbox.frame:IsShown() then
        noteEditbox.frame:Hide()
      end
    end
  end)
  note:SetScript("OnEnter", function()
    GameTooltip:SetOwner(UIParent, "ANCHOR_CURSOR")
    GameTooltip:AddLine(note.tooltipText, 1, 1, 1, 1)
    GameTooltip:Show()
  end)
  note:SetScript("OnLeave", function()
    GameTooltip:Hide()
  end)

  -- Interface\AddOns\Blizzard_MapCanvas\MapCanvas_DataProviderBase.lua calls this function when a pin is clicked
  -- to avoid lua error we create it here
  note.GetMap = function()
    return {
      ProcessGlobalPinMouseActionHandlers = function(...) end,
    }
  end

  note:Show()
end
