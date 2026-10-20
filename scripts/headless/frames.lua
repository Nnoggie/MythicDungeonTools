-- Frame widget types and CreateFrame.
return function(W)
  local S, usage, checkNumber, fireScript = W.state, W.usage, W.checkNumber, W.fireScript

  local frameScripts = {
    "OnUpdate", "OnEvent", "OnSizeChanged", "OnDragStart", "OnDragStop", "OnReceiveDrag", "OnKeyDown", "OnKeyUp",
    "OnChar", "OnAttributeChanged", "OnEnable", "OnDisable", "OnHyperlinkClick", "OnHyperlinkEnter",
    "OnHyperlinkLeave", "OnGamePadButtonDown", "OnGamePadButtonUp", "OnGamePadStick", "OnMouseWheel",
  }
  local Frame = W.defineClass("Frame", "ScriptRegion", frameScripts)

  local strata = {
    WORLD = 1, BACKGROUND = 2, LOW = 3, MEDIUM = 4, HIGH = 5, DIALOG = 6, FULLSCREEN = 7,
    FULLSCREEN_DIALOG = 8, TOOLTIP = 9, BLIZZARD = 10, PARENT = 0,
  }

  function Frame:CreateTexture(name, layer, template, sublevel)
    local texture = W.newRegion("Texture", self, name, layer, sublevel)
    if template then W.applyTemplates(texture, template) end
    return texture
  end
  function Frame:CreateMaskTexture(name, layer, template, sublevel)
    local mask = W.newRegion("MaskTexture", self, name, layer, sublevel)
    if template then W.applyTemplates(mask, template) end
    return mask
  end
  function Frame:CreateLine(name, layer, template, sublevel)
    local line = W.newRegion("Line", self, name, layer, sublevel)
    if template then W.applyTemplates(line, template) end
    return line
  end
  function Frame:CreateFontString(name, layer, inherits)
    local fontString, state = W.newRegion("FontString", self, name, layer or "ARTWORK")
    if inherits then
      for template in inherits:gmatch("[^,%s]+") do
        local font = rawget(_G, template)
        if font and S[font] and W.isA(S[font].class, "FontInstance") then
          state.fontObject = font
        else
          W.applyTemplates(fontString, template)
        end
      end
    end
    return fontString
  end

  function Frame:GetChildren() return unpack(S[self].children) end
  function Frame:GetNumChildren() return #S[self].children end
  function Frame:GetRegions() return unpack(S[self].regions) end
  function Frame:GetNumRegions() return #S[self].regions end
  function Frame:GetAdditionalRegions() return end

  local function applyStrata(frame, value)
    local state = S[frame]
    state.strata = value
    for _, child in ipairs(state.children) do
      if not S[child].fixedStrata then applyStrata(child, value) end
    end
  end
  -- The client ignores SetFrameStrata on a frame whose strata is fixed; callers unfix, set, then fix again.
  function Frame:SetFrameStrata(value)
    usage(type(value) == "string" and strata[value:upper()], 'SetFrameStrata(): unknown strata "'..tostring(value)..'"')
    if S[self].fixedStrata then return end
    applyStrata(self, value:upper())
  end
  function Frame:GetFrameStrata() return S[self].strata or "MEDIUM" end
  function Frame:SetFixedFrameStrata(value) S[self].fixedStrata = value end
  function Frame:HasFixedFrameStrata() return S[self].fixedStrata == true end
  function Frame:SetFrameLevel(level)
    checkNumber(level, "SetFrameLevel", "level")
    usage(level >= 0 and level <= 10000, "SetFrameLevel(): level out of range")
    local state = S[self]
    local delta = level - (state.level or 0)
    state.level = level
    for _, child in ipairs(state.children) do
      if not S[child].fixedLevel then child:SetFrameLevel(math.min(10000, math.max(0, (S[child].level or 0) + delta))) end
    end
  end
  function Frame:GetFrameLevel() return S[self].level or 0 end
  function Frame:SetFixedFrameLevel(value) S[self].fixedLevel = value end
  function Frame:HasFixedFrameLevel() return S[self].fixedLevel == true end
  function Frame:Raise() S[self].level = (S[self].level or 0) + 1 end
  function Frame:Lower() S[self].level = math.max(0, (S[self].level or 0) - 1) end
  function Frame:SetToplevel(value) S[self].toplevel = value end
  function Frame:IsToplevel() return S[self].toplevel == true end
  function Frame:SetFlattensRenderLayers(value) end
  function Frame:SetDrawLayerEnabled(layer, enabled) end
  function Frame:SetClipsChildren(value) S[self].clipsChildren = value end
  function Frame:DoesClipChildren() return S[self].clipsChildren == true end
  function Frame:SetIsFrameBuffer(value) end

  function Frame:EnableMouseWheel(enabled) S[self].mouseWheel = enabled ~= false end
  function Frame:IsMouseWheelEnabled() return S[self].mouseWheel == true end
  function Frame:EnableKeyboard(enabled) S[self].keyboard = enabled ~= false end
  function Frame:IsKeyboardEnabled() return S[self].keyboard == true end
  function Frame:SetPropagateKeyboardInput(value) S[self].propagateKeyboard = value end
  function Frame:GetPropagateKeyboardInput() return S[self].propagateKeyboard == true end
  function Frame:EnableGamePadButton() end
  function Frame:EnableGamePadStick() end
  function Frame:SetMovable(value) S[self].movable = value end
  function Frame:IsMovable() return S[self].movable == true end
  function Frame:SetResizable(value) S[self].resizable = value end
  function Frame:IsResizable() return S[self].resizable == true end
  function Frame:SetResizeBounds(minWidth, minHeight, maxWidth, maxHeight)
    checkNumber(minWidth, "SetResizeBounds", "minWidth")
    checkNumber(minHeight, "SetResizeBounds", "minHeight")
    S[self].resizeBounds = { minWidth, minHeight, maxWidth, maxHeight }
  end
  function Frame:GetResizeBounds()
    local bounds = S[self].resizeBounds or { 0, 0, 0, 0 }
    return bounds[1], bounds[2], bounds[3], bounds[4]
  end
  function Frame:StartMoving()
    usage(S[self].movable, "StartMoving(): frame is not movable")
    S[self].moving = true
  end
  function Frame:StartSizing(point)
    usage(S[self].resizable, "StartSizing(): frame is not resizable")
    S[self].sizing = true
  end
  function Frame:StopMovingOrSizing() S[self].moving, S[self].sizing = nil, nil end
  function Frame:SetUserPlaced(value) S[self].userPlaced = value end
  function Frame:IsUserPlaced() return S[self].userPlaced == true end
  function Frame:SetDontSavePosition(value) end
  function Frame:SetClampedToScreen(value) S[self].clamped = value end
  function Frame:IsClampedToScreen() return S[self].clamped == true end
  function Frame:SetClampRectInsets() end
  function Frame:SetHitRectInsets(left, right, top, bottom) S[self].hitRect = { left, right, top, bottom } end
  function Frame:GetHitRectInsets() return unpack(S[self].hitRect or { 0, 0, 0, 0 }) end
  function Frame:RegisterForDrag(...) S[self].dragButtons = { ... } end
  function Frame:SetID(id) checkNumber(id, "SetID", "id") S[self].id = id end
  function Frame:GetID() return S[self].id or 0 end
  function Frame:SetAttribute(key, value)
    local state = S[self]
    state.attributes = state.attributes or {}
    state.attributes[key] = value
    fireScript(self, "OnAttributeChanged", key, value)
  end
  function Frame:SetAttributeNoHandler(key, value)
    S[self].attributes = S[self].attributes or {}
    S[self].attributes[key] = value
  end
  function Frame:GetAttribute(key) return S[self].attributes and S[self].attributes[key] end
  function Frame:IsProtected() return false, false end
  function Frame:SetProtected() end
  function Frame:IsEventRegistered(event) return W.eventRegistered(self, event) end
  function Frame:RegisterEvent(event)
    usage(type(event) == "string", "RegisterEvent(): event must be a string")
    W.registerEvent(self, event)
    return true
  end
  function Frame:RegisterUnitEvent(event, ...)
    usage(type(event) == "string", "RegisterUnitEvent(): event must be a string")
    W.registerEvent(self, event)
    return true
  end
  function Frame:UnregisterEvent(event) W.unregisterEvent(self, event) end
  function Frame:UnregisterAllEvents() W.unregisterAllEvents(self) end
  function Frame:RegisterAllEvents() end
  function Frame:GetBoundsRect() return W.resolveRect(self) end
  function Frame:SetHyperlinksEnabled(value) end
  function Frame:GetHyperlinksEnabled() return true end
  function Frame:SetWindow() end
  function Frame:ExecuteAttribute() end
  local function setEnabled(self, enabled) if enabled then self:Enable() else self:Disable() end end

  -- Button
  local Button = W.defineClass("Button", "Frame", { "OnClick", "PreClick", "PostClick", "OnDoubleClick" })
  local function buttonFontString(self)
    local state = S[self]
    if not state.fontString then
      local fontString = W.newRegion("FontString", self, nil, "ARTWORK")
      S[fontString].fontObject = state.normalFont or rawget(_G, "GameFontNormal")
      fontString:SetPoint("CENTER")
      state.fontString = fontString
    end
    return state.fontString
  end
  function Button:Click(button, down)
    local state = S[self]
    if state.enabled == false then return end
    button = button or "LeftButton"
    if W.isA(state.class, "CheckButton") then state.checked = not state.checked end
    fireScript(self, "PreClick", button, down or false)
    fireScript(self, "OnClick", button, down or false)
    fireScript(self, "PostClick", button, down or false)
  end
  function Button:RegisterForClicks(...) S[self].clickButtons = { ... } end
  function Button:RegisterForMouse() end
  function Button:Enable()
    local state = S[self]
    if state.enabled == false then
      state.enabled = true
      fireScript(self, "OnEnable")
    end
  end
  function Button:Disable()
    local state = S[self]
    if state.enabled ~= false then
      state.enabled = false
      fireScript(self, "OnDisable")
    end
  end
  function Button:IsEnabled() return S[self].enabled ~= false end
  Button.SetEnabled = setEnabled
  function Button:LockHighlight() S[self].highlightLocked = true end
  function Button:UnlockHighlight() S[self].highlightLocked = false end
  function Button:SetText(text)
    usage(text == nil or type(text) == "string" or type(text) == "number", "Button:SetText(): text must be a string, number or nil")
    buttonFontString(self):SetText(text)
  end
  function Button:SetFormattedText(format, ...) self:SetText(string.format(format, ...)) end
  function Button:GetText() return S[self].fontString and S[self].fontString:GetText() end
  function Button:GetTextWidth() return S[self].fontString and S[self].fontString:GetStringWidth() or 0 end
  function Button:GetTextHeight() return S[self].fontString and S[self].fontString:GetStringHeight() or 0 end
  function Button:GetFontString() return S[self].fontString end
  function Button:SetFontString(fontString)
    usage(W.isRegion(fontString), "SetFontString(): argument is not a FontString")
    S[self].fontString = fontString
  end
  local function fontSetter(field)
    return function(self, font)
      if type(font) == "string" then font = rawget(_G, font) end
      usage(font == nil or (S[font] and W.isA(S[font].class, "FontInstance")), "Set"..field.."FontObject(): not a font object")
      S[self][field:lower().."Font"] = font
      if field == "Normal" and S[self].fontString then S[S[self].fontString].fontObject = font end
    end
  end
  Button.SetNormalFontObject = fontSetter("Normal")
  Button.SetHighlightFontObject = fontSetter("Highlight")
  Button.SetDisabledFontObject = fontSetter("Disabled")
  function Button:GetNormalFontObject() return S[self].normalFont end
  function Button:GetHighlightFontObject() return S[self].highlightFont end
  function Button:GetDisabledFontObject() return S[self].disabledFont end
  local function textureSetter(field, layer)
    return function(self, texture)
      local state = S[self]
      if texture == nil then
        if state[field] then state[field]:SetTexture(nil) end
        return
      end
      if type(texture) ~= "table" then
        local region = state[field] or self:CreateTexture(nil, layer)
        region:SetTexture(texture)
        region:SetAllPoints(self)
        texture = region
      end
      usage(W.isRegion(texture), "Set"..field.."(): argument is not a texture")
      state[field] = texture
    end
  end
  local function atlasSetter(field, layer)
    return function(self, atlas)
      local state = S[self]
      local region = state[field] or self:CreateTexture(nil, layer)
      region:SetAtlas(atlas)
      region:SetAllPoints(self)
      state[field] = region
    end
  end
  for _, kind in ipairs({ { "Normal", "ARTWORK" }, { "Pushed", "ARTWORK" }, { "Highlight", "HIGHLIGHT" }, { "Disabled", "ARTWORK" } }) do
    local field = kind[1].."Texture"
    Button["Set"..field] = textureSetter(field, kind[2])
    Button["Get"..field] = function(self) return S[self][field] end
    Button["Set"..kind[1].."Atlas"] = atlasSetter(field, kind[2])
    Button["Clear"..field] = function(self) S[self][field] = nil end
  end
  function Button:SetButtonState(value, locked) S[self].buttonState = value end
  function Button:GetButtonState() return S[self].buttonState or "NORMAL" end
  function Button:SetMotionScriptsWhileDisabled(value) end
  function Button:GetMotionScriptsWhileDisabled() return false end
  function Button:SetPushedTextOffset() end
  function Button:GetPushedTextOffset() return 0, 0 end
  function Button:SetHighlightLocked(value) S[self].highlightLocked = value end
  function Button:IsDown() return false end

  -- CheckButton
  local CheckButton = W.defineClass("CheckButton", "Button", {})
  function CheckButton:SetChecked(checked) S[self].checked = checked and true or false end
  function CheckButton:GetChecked() return S[self].checked == true end
  CheckButton.SetCheckedTexture = textureSetter("CheckedTexture", "OVERLAY")
  CheckButton.GetCheckedTexture = function(self) return S[self].CheckedTexture end
  CheckButton.SetDisabledCheckedTexture = textureSetter("DisabledCheckedTexture", "OVERLAY")
  CheckButton.GetDisabledCheckedTexture = function(self) return S[self].DisabledCheckedTexture end

  -- EditBox
  local EditBox = W.defineClass("EditBox", "Frame", {
    "OnTextChanged", "OnEnterPressed", "OnEscapePressed", "OnTabPressed", "OnSpacePressed", "OnEditFocusGained",
    "OnEditFocusLost", "OnTextSet", "OnCursorChanged", "OnInputLanguageChanged", "OnArrowPressed",
    "OnCharComposition", "OnClick",
  })
  for key, value in pairs(W.classes.fontinstance.methods) do rawset(EditBox, key, value) end
  local focusedEditBox
  function EditBox:SetText(text)
    usage(type(text) == "string" or type(text) == "number", "EditBox:SetText(): text must be a string or number, got "..type(text))
    local state = S[self]
    text = tostring(text)
    if state.maxLetters and state.maxLetters > 0 then text = text:sub(1, state.maxLetters) end
    state.text = text
    state.cursor = #text
    fireScript(self, "OnTextSet")
    fireScript(self, "OnTextChanged", false)
  end
  function EditBox:GetText() return S[self].text or "" end
  function EditBox:Insert(text)
    local state = S[self]
    state.text = (state.text or "")..tostring(text)
    fireScript(self, "OnTextChanged", true)
  end
  function EditBox:GetNumber() return tonumber(S[self].text or "") or 0 end
  function EditBox:SetNumber(value) self:SetText(tostring(value)) end
  function EditBox:GetNumLetters() return #(S[self].text or "") end
  function EditBox:SetFocus()
    if focusedEditBox == self then return end
    if focusedEditBox then focusedEditBox:ClearFocus() end
    focusedEditBox = self
    S[self].focus = true
    fireScript(self, "OnEditFocusGained")
  end
  function EditBox:ClearFocus()
    if not S[self].focus then return end
    S[self].focus = false
    if focusedEditBox == self then focusedEditBox = nil end
    fireScript(self, "OnEditFocusLost")
  end
  function EditBox:HasFocus() return S[self].focus == true end
  function EditBox:HighlightText(startPosition, endPosition) S[self].highlight = { startPosition or 0, endPosition or -1 } end
  function EditBox:SetCursorPosition(position) S[self].cursor = position end
  function EditBox:GetCursorPosition() return S[self].cursor or 0 end
  function EditBox:SetMaxLetters(value) S[self].maxLetters = value end
  function EditBox:GetMaxLetters() return S[self].maxLetters or 0 end
  function EditBox:SetMaxBytes(value) S[self].maxBytes = value end
  function EditBox:GetMaxBytes() return S[self].maxBytes or 0 end
  function EditBox:SetNumeric(value) S[self].numeric = value end
  function EditBox:IsNumeric() return S[self].numeric == true end
  function EditBox:SetMultiLine(value) S[self].multiLine = value end
  function EditBox:IsMultiLine() return S[self].multiLine == true end
  function EditBox:SetAutoFocus(value) S[self].autoFocus = value end
  function EditBox:IsAutoFocus() return S[self].autoFocus ~= false end
  function EditBox:SetTextInsets(left, right, top, bottom) S[self].insets = { left, right, top, bottom } end
  function EditBox:GetTextInsets() return unpack(S[self].insets or { 0, 0, 0, 0 }) end
  function EditBox:SetCountInvisibleLetters(value) end
  function EditBox:SetHistoryLines(value) end
  function EditBox:AddHistoryLine(text) end
  function EditBox:ClearHistory() end
  function EditBox:SetBlinkSpeed(value) end
  function EditBox:SetAltArrowKeyMode(value) end
  function EditBox:Enable() S[self].enabled = true end
  function EditBox:Disable() S[self].enabled = false end
  function EditBox:IsEnabled() return S[self].enabled ~= false end
  EditBox.SetEnabled = setEnabled
  function EditBox:SetSecureText() end
  function EditBox:SetVisibleTextByteLimit() end
  function EditBox:GetInputLanguage() return "ROMAN" end
  function EditBox:IsInIMECompositionMode() return false end
  function EditBox:SetHighlightColor() end
  function EditBox:GetDisplayText() return S[self].text or "" end
  function EditBox:SetPassword() end
  function EditBox:IsPassword() return false end
  function EditBox:ToggleInputLanguage() end
  function EditBox:Validate() end

  -- ScrollFrame
  local ScrollFrame = W.defineClass("ScrollFrame", "Frame", { "OnScrollRangeChanged", "OnVerticalScroll", "OnHorizontalScroll" })
  function ScrollFrame:SetScrollChild(child)
    usage(type(child) == "table" and S[child] and S[child].isFrame, "SetScrollChild(): child must be a frame")
    S[self].scrollChild = child
    if S[child].parent ~= self then child:SetParent(self) end
  end
  function ScrollFrame:GetScrollChild() return S[self].scrollChild end
  local function scrollRange(self, horizontal)
    local child = S[self].scrollChild
    if not child then return 0 end
    if horizontal then return math.max(0, child:GetWidth() - self:GetWidth()) end
    return math.max(0, child:GetHeight() - self:GetHeight())
  end
  function ScrollFrame:GetVerticalScrollRange() return scrollRange(self, false) end
  function ScrollFrame:GetHorizontalScrollRange() return scrollRange(self, true) end
  function ScrollFrame:SetVerticalScroll(value)
    checkNumber(value, "SetVerticalScroll", "offset")
    S[self].verticalScroll = value
    fireScript(self, "OnVerticalScroll", value)
  end
  function ScrollFrame:GetVerticalScroll() return S[self].verticalScroll or 0 end
  function ScrollFrame:SetHorizontalScroll(value)
    checkNumber(value, "SetHorizontalScroll", "offset")
    S[self].horizontalScroll = value
    fireScript(self, "OnHorizontalScroll", value)
  end
  function ScrollFrame:GetHorizontalScroll() return S[self].horizontalScroll or 0 end
  function ScrollFrame:UpdateScrollChildRect()
    fireScript(self, "OnScrollRangeChanged", scrollRange(self, true), scrollRange(self, false))
  end

  -- Slider and StatusBar share a value range.
  local function defineRanged(className, scripts)
    local methods = W.defineClass(className, "Frame", scripts)
    function methods:SetMinMaxValues(minimum, maximum)
      checkNumber(minimum, "SetMinMaxValues", "min")
      checkNumber(maximum, "SetMinMaxValues", "max")
      local state = S[self]
      state.min, state.max = minimum, maximum
      fireScript(self, "OnMinMaxChanged", minimum, maximum)
      if state.value then
        local clamped = math.max(minimum, math.min(maximum, state.value))
        if clamped ~= state.value then self:SetValue(clamped) end
      end
    end
    function methods:GetMinMaxValues() return S[self].min or 0, S[self].max or 0 end
    function methods:SetValue(value, treatAsMouseEvent)
      checkNumber(value, className..":SetValue", "value")
      local state = S[self]
      value = math.max(state.min or 0, math.min(state.max or 0, value))
      if state.value == value then return end
      state.value = value
      fireScript(self, "OnValueChanged", value, treatAsMouseEvent == true)
    end
    function methods:GetValue() return S[self].value or S[self].min or 0 end
    function methods:SetOrientation(value) S[self].orientation = value end
    function methods:GetOrientation() return S[self].orientation or "HORIZONTAL" end
    return methods
  end

  local Slider = defineRanged("Slider", { "OnValueChanged", "OnMinMaxChanged" })
  function Slider:SetValueStep(value) S[self].step = value end
  function Slider:GetValueStep() return S[self].step or 0 end
  function Slider:SetObeyStepOnDrag(value) end
  function Slider:GetObeyStepOnDrag() return false end
  function Slider:SetStepsPerPage(value) end
  function Slider:GetStepsPerPage() return 1 end
  Slider.SetThumbTexture = textureSetter("ThumbTexture", "OVERLAY")
  function Slider:GetThumbTexture() return S[self].ThumbTexture end
  function Slider:Enable() S[self].enabled = true end
  function Slider:Disable() S[self].enabled = false end
  function Slider:IsEnabled() return S[self].enabled ~= false end
  Slider.SetEnabled = setEnabled
  function Slider:IsDraggingThumb() return false end

  local StatusBar = defineRanged("StatusBar", { "OnValueChanged", "OnMinMaxChanged" })
  function StatusBar:SetStatusBarTexture(texture)
    local state = S[self]
    if type(texture) ~= "table" then
      local region = state.barTexture or self:CreateTexture(nil, "ARTWORK")
      if texture then region:SetTexture(texture) end
      texture = region
    end
    usage(W.isRegion(texture), "SetStatusBarTexture(): argument is not a texture")
    state.barTexture = texture
  end
  function StatusBar:GetStatusBarTexture()
    local state = S[self]
    if not state.barTexture then state.barTexture = self:CreateTexture(nil, "ARTWORK") end
    return state.barTexture
  end
  function StatusBar:SetStatusBarColor(r, g, b, a) S[self].barColor = { r, g, b, a or 1 } end
  function StatusBar:GetStatusBarColor() return unpack(S[self].barColor or { 1, 1, 1, 1 }) end
  function StatusBar:SetStatusBarAtlas(atlas) self:GetStatusBarTexture():SetAtlas(atlas) end
  function StatusBar:SetReverseFill(value) end
  function StatusBar:GetReverseFill() return false end
  function StatusBar:SetFillStyle(value) end
  function StatusBar:SetRotatesTexture(value) end
  function StatusBar:SetStatusBarDesaturated(value) end
  function StatusBar:SetColorFill(r, g, b, a) S[self].barColor = { r, g, b, a or 1 } end

  local Cooldown = W.defineClass("Cooldown", "Frame", { "OnCooldownDone" })
  function Cooldown:SetCooldown(start, duration) S[self].cooldown = { start, duration } end
  function Cooldown:GetCooldownTimes() local c = S[self].cooldown or { 0, 0 } return c[1] * 1000, c[2] * 1000 end
  function Cooldown:Clear() S[self].cooldown = nil end
  for _, name in ipairs({
    "SetSwipeColor", "SetSwipeTexture", "SetDrawEdge", "SetDrawSwipe", "SetDrawBling", "SetReverse",
    "SetHideCountdownNumbers", "SetEdgeTexture", "SetCountdownFont", "SetUseCircularEdge",
  }) do
    Cooldown[name] = function() end
  end

  local Model = W.defineClass("Model", "Frame", { "OnModelLoaded", "OnAnimFinished", "OnAnimStarted" })
  for _, name in ipairs({
    "SetDisplayInfo", "SetCreature", "SetModel", "SetUnit", "ClearModel", "SetPortraitZoom", "SetCamDistanceScale",
    "SetPosition", "SetRotation", "SetCamera", "RefreshCamera", "SetKeepModelOnHide", "SetModelScale", "SetSequence",
    "SetAnimation", "SetLight", "RefreshUnit", "SetDoBlend", "SetFogColor", "SetFogFar", "SetFogNear", "SetGlow",
    "SetParticlesEnabled", "SetPaused", "SetSequenceTime", "SetViewTranslation", "SetModelDrawLayer", "SetDesaturation",
    "ZeroCachedCenterXY", "SetBarberShopAlternateForm", "FreezeAnimation", "SetAutoDress", "SetCameraDistance",
    "SetCameraPosition", "SetCameraTarget", "SetTransform", "UseModelCenterToTransform", "SetPitch", "SetRoll",
    "SetYaw", "TransformCameraSpaceToModelSpace", "SetModelAlpha", "SetShadowEffect", "ClearFog", "ClearTransform",
  }) do
    Model[name] = function(self, value) S[self]["model"..name] = value end
  end
  function Model:SetFacing(value) checkNumber(value, "SetFacing", "facing") S[self].facing = value end
  function Model:GetFacing() return S[self].facing or 0 end
  function Model:GetDisplayInfo() return S[self].modelSetDisplayInfo end
  function Model:GetModelScale() return 1 end
  function Model:GetCameraDistance() return 1 end
  function Model:GetPosition() return 0, 0, 0 end
  function Model:HasCustomCamera() return false end
  function Model:GetModelFileID() return S[self].modelSetModel end
  function Model:IsUsingModelCenterToTransform() return false end
  W.defineClass("PlayerModel", "Model", {})
  W.defineClass("DressUpModel", "PlayerModel", {})
  W.defineClass("CinematicModel", "PlayerModel", {})
  W.defineClass("TabardModel", "PlayerModel", {})

  local ModelScene = W.defineClass("ModelScene", "Frame", {})
  function ModelScene:SetFromModelSceneID() end
  function ModelScene:ClearScene() end
  function ModelScene:GetActorByTag() end
  function ModelScene:SetCameraPosition() end
  function ModelScene:SetCameraOrientationByYawPitchRoll() end

  local MessageFrame = W.defineClass("MessageFrame", "Frame", {})
  for key, value in pairs(W.classes.fontinstance.methods) do rawset(MessageFrame, key, value) end
  function MessageFrame:AddMessage(text, r, g, b)
    S[self].messages = S[self].messages or {}
    table.insert(S[self].messages, text)
  end
  function MessageFrame:Clear() S[self].messages = {} end
  for _, name in ipairs({ "SetFading", "SetTimeVisible", "SetFadeDuration", "SetInsertMode", "SetMaxLines", "SetFadePower" }) do
    MessageFrame[name] = function() end
  end
  W.defineClass("ScrollingMessageFrame", "MessageFrame", { "OnMessageScrollChanged", "OnHyperlinkClick" })

  local SimpleHTML = W.defineClass("SimpleHTML", "Frame", {})
  for key, value in pairs(W.classes.fontinstance.methods) do rawset(SimpleHTML, key, value) end
  function SimpleHTML:SetText(text) S[self].text = text end
  function SimpleHTML:GetText() return S[self].text end
  function SimpleHTML:GetContentHeight() return 0 end

  W.defineClass("ColorSelect", "Frame", { "OnColorSelect" })
  W.defineClass("Minimap", "Frame", {})

  -- GameTooltip
  local GameTooltip = W.defineClass("GameTooltip", "Frame", {
    "OnTooltipCleared", "OnTooltipSetDefaultAnchor", "OnTooltipAddMoney", "OnTooltipSetItem", "OnTooltipSetUnit",
    "OnTooltipSetSpell",
  })
  function GameTooltip:SetOwner(owner, anchor, x, y)
    usage(W.isRegion(owner), "GameTooltip:SetOwner(): owner must be a frame")
    local state = S[self]
    state.owner, state.anchor, state.lines = owner, anchor, {}
  end
  function GameTooltip:GetOwner() return S[self].owner end
  function GameTooltip:IsOwned(owner) return S[self].owner == owner end
  function GameTooltip:SetAnchorType(anchor) S[self].anchor = anchor end
  function GameTooltip:GetAnchorType() return S[self].anchor end
  function GameTooltip:AddLine(text, r, g, b, wrap)
    S[self].lines = S[self].lines or {}
    table.insert(S[self].lines, text == nil and "" or tostring(text))
  end
  function GameTooltip:AddDoubleLine(left, right) self:AddLine(tostring(left).." | "..tostring(right)) end
  function GameTooltip:SetText(text) S[self].lines = { text == nil and "" or tostring(text) } end
  function GameTooltip:ClearLines()
    S[self].lines = {}
    fireScript(self, "OnTooltipCleared")
  end
  function GameTooltip:NumLines() return #(S[self].lines or {}) end
  function GameTooltip:Hide()
    W.ScriptRegion.Hide(self)
    S[self].owner = nil
  end
  for _, name in ipairs({
    "SetHyperlink", "SetSpellByID", "SetUnit", "SetItemByID", "SetMinimumWidth", "SetPadding", "AddTexture",
    "SetUnitAura", "SetUnitBuff", "SetUnitDebuff", "AppendText", "SetAction", "FadeOut", "AddSpellByID",
    "SetCustomLineSpacing", "AddAtlas",
  }) do
    GameTooltip[name] = function() end
  end
  function GameTooltip:GetUnit() return nil end
  function GameTooltip:GetSpell() return nil end
  function GameTooltip:GetItem() return nil end
  function GameTooltip:IsTooltipType() return false end
  function GameTooltip:GetTooltipData() return nil end

  local typeNames = {}
  for _, name in ipairs({
    "Frame", "Button", "CheckButton", "EditBox", "ScrollFrame", "Slider", "StatusBar", "Cooldown", "Model",
    "PlayerModel", "DressUpModel", "CinematicModel", "TabardModel", "ModelScene", "MessageFrame",
    "ScrollingMessageFrame", "SimpleHTML", "GameTooltip", "ColorSelect", "Minimap",
  }) do typeNames[name:lower()] = name end

  local function newFrame(frameType, name, parent)
    local className = typeNames[tostring(frameType):lower()]
    if not className then W.raise('CreateFrame(): Unknown frame type "'..tostring(frameType)..'"') end
    if parent ~= nil then
      if type(parent) == "string" then parent = rawget(_G, parent) end
      if not (type(parent) == "table" and S[parent] and S[parent].isFrame) then
        W.raise("CreateFrame(): Wrong object type for function (parent is not a frame)")
      end
    end
    local frame, state = W.newObject(className, {
      isRegion = true, isFrame = true, points = {}, children = {}, regions = {}, shown = true,
    })
    if name then
      usage(type(name) == "string", "CreateFrame(): name must be a string")
      state.name = name:gsub("%$[Pp]arent", parent and S[parent].name or "")
      _G[state.name] = frame
    end
    state.strata = parent and S[parent].strata or "MEDIUM"
    state.level = parent and (S[parent].level or 0) + 1 or 0
    W.attach(frame, state, parent)
    return frame, state
  end
  W.newFrame = newFrame

  function W.CreateFrame(frameType, name, parent, templates, id)
    usage(type(frameType) == "string", "CreateFrame(): frameType must be a string")
    local frame = newFrame(frameType, name, parent)
    if id then frame:SetID(id) end
    if templates then
      usage(type(templates) == "string", "CreateFrame(): template must be a string")
      W.applyTemplates(frame, templates)
    end
    fireScript(frame, "OnLoad")
    return frame
  end
end
