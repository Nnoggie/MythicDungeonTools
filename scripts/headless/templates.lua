-- Named templates: Lua builders for the Blizzard templates MDT uses, plus XML virtual templates.
return function(W)
  local S = W.state
  local XML = dofile(W.dir.."/xml.lua")
  W.XML = XML
  W.templates = {}
  W.xmlTemplates = {}
  W.unknownTemplates = {}
  W.unknownTemplateOrder = {}

  local function region(frame, kind, key, layer, name)
    local frameName = S[frame].name
    local object
    if kind == "FontString" then
      object = frame:CreateFontString(name and frameName and frameName..name, layer)
      S[object].fontObject = rawget(_G, "GameFontNormal")
    else
      object = frame:CreateTexture(name and frameName and frameName..name, layer)
    end
    if key then frame[key] = object end
    return object
  end

  local function child(frame, frameType, key, name, templates)
    local frameName = S[frame].name
    local object = W.CreateFrame(frameType, name and frameName and frameName..name, frame, templates)
    if key then frame[key] = object end
    return object
  end

  local function threeSlice(frame, layer)
    region(frame, "Texture", "Left", layer, "Left")
    region(frame, "Texture", "Middle", layer, "Middle")
    region(frame, "Texture", "Right", layer, "Right")
  end

  local T = W.templates

  T.BackdropTemplate = function(frame) W.Mixin(frame, _G.BackdropTemplateMixin) end
  T.TooltipBackdropTemplate = T.BackdropTemplate
  T.TooltipBorderedFrameTemplate = function(frame)
    T.BackdropTemplate(frame)
    child(frame, "Frame", "NineSlice", nil, nil)
  end
  T.SecureActionButtonTemplate = function() end
  T.SecureHandlerBaseTemplate = function() end
  T.InsecureActionButtonTemplate = function() end

  local function panelButton(frame)
    threeSlice(frame, "BACKGROUND")
    local text = region(frame, "FontString", "Text", "ARTWORK", "Text")
    text:SetPoint("CENTER")
    frame:SetFontString(text)
    frame:SetNormalFontObject(rawget(_G, "GameFontNormal"))
    frame:SetHighlightFontObject(rawget(_G, "GameFontHighlight"))
    frame:SetDisabledFontObject(rawget(_G, "GameFontDisable"))
    frame:SetHighlightTexture("Interface\\Buttons\\UI-Panel-Button-Highlight")
  end
  T.UIPanelButtonTemplate = panelButton
  T.UIPanelButtonNoTooltipTemplate = panelButton
  T.UIPanelDynamicResizeButtonTemplate = panelButton
  T.UIMenuButtonStretchTemplate = panelButton
  T.OptionsListButtonTemplate = function(frame)
    local text = region(frame, "FontString", "text", "ARTWORK", "Text")
    text:SetPoint("LEFT")
    frame:SetFontString(text)
    frame:SetNormalFontObject(rawget(_G, "GameFontNormal"))
    frame:SetHighlightTexture("Interface\\QuestFrame\\UI-QuestLogTitleHighlight")
    frame.highlight = frame:GetHighlightTexture()
    child(frame, "Button", "toggle", "Toggle", nil)
  end

  local function mapPin(frame)
    frame:SetSize(22, 22)
    region(frame, "Texture", "Texture", "ARTWORK", nil):SetAllPoints()
    region(frame, "Texture", "HighlightTexture", "HIGHLIGHT", nil):SetAllPoints()
  end
  T.MapLinkPinTemplate = mapPin
  T.DeathReleasePinTemplate = mapPin
  T.VignettePinTemplate = mapPin
  T.QuestPinTemplate = function(frame)
    frame:SetSize(32, 32)
    frame:SetNormalTexture("Interface/WorldMap/UI-QuestPoi-NumberIcons")
    frame:SetPushedTexture("Interface/WorldMap/UI-QuestPoi-NumberIcons")
    frame:SetHighlightTexture("Interface/WorldMap/UI-QuestPoi-NumberIcons")
    frame.NormalTexture, frame.PushedTexture, frame.HighlightTexture = frame:GetNormalTexture(), frame:GetPushedTexture(), frame:GetHighlightTexture()
    frame.Display = child(frame, "Frame", nil, nil, nil)
    frame.Display:SetAllPoints()
    frame.Display.Icon = frame.Display:CreateTexture(nil, "OVERLAY")
  end
  T.UIPanelCloseButton = function(frame)
    frame:SetSize(32, 32)
    frame:SetNormalTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Up")
    frame:SetPushedTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Down")
    frame:SetHighlightTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Highlight")
    frame:SetScript("OnClick", function(self) self:GetParent():Hide() end)
  end
  T.UIPanelCloseButtonNoScripts = function(frame) frame:SetSize(32, 32) end

  T.InputBoxTemplate = function(frame)
    threeSlice(frame, "BACKGROUND")
    frame:SetFontObject(rawget(_G, "ChatFontNormal"))
    frame:SetScript("OnEscapePressed", function(self) self:ClearFocus() end)
    frame:SetScript("OnEditFocusLost", function(self) self:HighlightText(0, 0) end)
  end
  T.InputBoxInstructionsTemplate = T.InputBoxTemplate
  T.SearchBoxTemplate = T.InputBoxTemplate

  T.UIDropDownMenuTemplate = function(frame)
    threeSlice(frame, "ARTWORK")
    local text = region(frame, "FontString", "Text", "ARTWORK", "Text")
    S[text].fontObject = rawget(_G, "GameFontHighlightSmall")
    region(frame, "Texture", "Icon", "OVERLAY", "Icon")
    local button = child(frame, "Button", "Button", "Button", nil)
    button:SetNormalTexture("Interface\\ChatFrame\\UI-ChatIcon-ScrollDown-Up")
    if S[button].name then _G[S[button].name.."NormalTexture"] = button:GetNormalTexture() end
    button:SetPushedTexture("Interface\\ChatFrame\\UI-ChatIcon-ScrollDown-Down")
    button:SetDisabledTexture("Interface\\ChatFrame\\UI-ChatIcon-ScrollDown-Disabled")
    button:SetHighlightTexture("Interface\\Buttons\\UI-Common-MouseHilight")
  end

  local function scrollBar(frame)
    local up = child(frame, "Button", "ScrollUpButton", "ScrollUpButton", nil)
    local down = child(frame, "Button", "ScrollDownButton", "ScrollDownButton", nil)
    up:SetPoint("BOTTOM", frame, "TOP")
    down:SetPoint("TOP", frame, "BOTTOM")
    frame:SetThumbTexture("Interface\\Buttons\\UI-ScrollBar-Knob")
    if S[frame].name then _G[S[frame].name.."ThumbTexture"] = frame:GetThumbTexture() end
    frame:SetMinMaxValues(0, 0)
    frame:SetValue(0)
  end
  T.UIPanelScrollBarTemplate = scrollBar
  T.MinimalScrollBarTemplate = scrollBar
  T.UIPanelScrollFrameTemplate = function(frame)
    local bar = child(frame, "Slider", "ScrollBar", "ScrollBar", "UIPanelScrollBarTemplate")
    bar:SetPoint("TOPLEFT", frame, "TOPRIGHT", 6, -16)
    bar:SetPoint("BOTTOMLEFT", frame, "BOTTOMRIGHT", 6, 16)
    bar:SetScript("OnValueChanged", function(self, value) self:GetParent():SetVerticalScroll(value) end)
    frame:SetScript("OnScrollRangeChanged", function(self, _, yrange)
      bar:SetMinMaxValues(0, yrange or 0)
    end)
    frame:SetScript("OnVerticalScroll", function(self, offset) bar:SetValue(offset) end)
  end
  T.UIPanelScrollFrameCodeTemplate = T.UIPanelScrollFrameTemplate
  T.ScrollFrameTemplate = T.UIPanelScrollFrameTemplate

  T.LoadingSpinnerTemplate = function(frame)
    frame:SetSize(60, 60)
    local background = child(frame, "Frame", "BackgroundFrame", nil, nil)
    background:SetAllPoints()
    background.Background = background:CreateTexture(nil, "BACKGROUND")
    background.Background:SetAllPoints()
    background.Background:SetAtlas("auctionhouse-ui-loadingspinner-background")
    local animFrame = child(frame, "Frame", "AnimFrame", nil, nil)
    animFrame:SetAllPoints()
    animFrame.Circle = animFrame:CreateTexture(nil, "ARTWORK")
    animFrame.Circle:SetAllPoints()
    animFrame.Circle:SetAtlas("auctionhouse-ui-loadingspinner")
    local anim = frame:CreateAnimationGroup()
    anim:SetLooping("REPEAT")
    local rotation = anim:CreateAnimation("Rotation")
    rotation:SetDuration(1)
    rotation:SetDegrees(-360)
    rotation:SetTarget(animFrame)
    frame.Anim = anim
  end

  T.GameTooltipTemplate = function(frame)
    T.BackdropTemplate(frame)
    child(frame, "Frame", "NineSlice", nil, nil)
    for index = 1, 2 do
      local left = region(frame, "FontString", "TextLeft"..index, "ARTWORK", "TextLeft"..index)
      local right = region(frame, "FontString", "TextRight"..index, "ARTWORK", "TextRight"..index)
      left:Hide()
      right:Hide()
    end
  end
  T.SharedTooltipTemplate = T.GameTooltipTemplate

  T.ScenarioProgressBarTemplate = function(frame)
    frame:SetSize(191, 17)
    local bar = child(frame, "StatusBar", "Bar", nil, nil)
    bar:SetSize(191, 13)
    bar:SetPoint("LEFT", 10, 0)
    bar:SetMinMaxValues(0, 100)
    bar:SetValue(0)
    bar:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar")
    bar.Label = bar:CreateFontString(nil, "OVERLAY")
    S[bar.Label].fontObject = rawget(_G, "GameFontHighlightMedium")
    bar.Label:SetPoint("CENTER")
    bar.Icon = bar:CreateTexture(nil, "OVERLAY")
    bar.IconBG = bar:CreateTexture(nil, "ARTWORK")
    bar.BarFrame = bar:CreateTexture(nil, "OVERLAY")
    bar.BarBG = bar:CreateTexture(nil, "BACKGROUND")
  end

  T.ModelWithControlsTemplate = function(frame)
    local controls = child(frame, "Frame", "controlFrame", "ControlFrame", nil)
    controls:SetSize(160, 25)
    controls:SetPoint("TOP")
    controls:Hide()
    for _, name in ipairs({ "zoomInButton", "zoomOutButton", "panButton", "rotateLeftButton", "rotateRightButton", "rotateResetButton" }) do
      child(controls, "Button", name, nil, nil)
    end
    frame.zoomLevel, frame.minZoom, frame.maxZoom = 0, 0, 1
    frame.rotation = 0
  end
  T.ModelTemplate = function() end

  T.MaximizeMinimizeButtonFrameTemplate = function(frame)
    W.Mixin(frame, _G.MaximizeMinimizeButtonFrameMixin)
    frame:SetSize(32, 32)
    local maximize = child(frame, "Button", "MaximizeButton", nil, nil)
    maximize:SetAllPoints()
    maximize:SetScript("OnClick", function(self) self:GetParent():Maximize() end)
    local minimize = child(frame, "Button", "MinimizeButton", nil, nil)
    minimize:SetAllPoints()
    minimize:SetScript("OnClick", function(self) self:GetParent():Minimize() end)
    minimize:Hide()
  end

  T.ChatConfigCheckButtonTemplate = function(frame)
    frame.Text = region(frame, "FontString", "Text", "ARTWORK", "Text")
    frame:SetFontString(frame.Text)
  end
  T.UICheckButtonTemplate = T.ChatConfigCheckButtonTemplate
  T.OptionsSliderTemplate = function(frame)
    frame.Text = region(frame, "FontString", "Text", "ARTWORK", "Text")
    frame.Low = region(frame, "FontString", "Low", "ARTWORK", "Low")
    frame.High = region(frame, "FontString", "High", "ARTWORK", "High")
    frame:SetThumbTexture("Interface\\Buttons\\UI-SliderBar-Button-Horizontal")
  end

  -- XML templates ---------------------------------------------------------------------------

  local instantiate

  local function number(value) return value and tonumber(value) end

  local function dimension(node)
    local x, y = number(XML.attr(node, "x")), number(XML.attr(node, "y"))
    local abs = XML.child(node, "AbsDimension")
    if abs then x, y = number(XML.attr(abs, "x")) or x, number(XML.attr(abs, "y")) or y end
    return x, y
  end

  local function resolveRelativeKey(owner, key)
    local current
    for part in key:gmatch("[^%.]+") do
      if part == "$parent" then
        current = current and current:GetParent() or owner
      else
        current = current and current[part]
      end
    end
    return current
  end

  local function applyAnchors(object, node, owner)
    local anchors = XML.child(node, "Anchors")
    if not anchors then return end
    object:ClearAllPoints()
    for _, anchor in ipairs(anchors.children) do
      local point = XML.attr(anchor, "point")
      local relativePoint = XML.attr(anchor, "relativePoint") or point
      local relative
      local relativeKey, relativeTo = XML.attr(anchor, "relativeKey"), XML.attr(anchor, "relativeTo")
      if relativeKey then
        relative = resolveRelativeKey(owner, relativeKey)
      elseif relativeTo then
        relative = rawget(_G, (relativeTo:gsub("%$parent", S[owner].name or "")))
      else
        relative = S[object].parent
      end
      local x, y = number(XML.attr(anchor, "x")) or 0, number(XML.attr(anchor, "y")) or 0
      local offset = XML.child(anchor, "Offset")
      if offset then
        local ox, oy = dimension(offset)
        x, y = ox or x, oy or y
      end
      object:SetPoint(point, relative, relativePoint, x, y)
    end
  end

  local function applySize(object, node)
    local size = XML.child(node, "Size")
    if size then
      local x, y = dimension(size)
      if x then object:SetWidth(x) end
      if y then object:SetHeight(y) end
    end
  end

  local function scriptHandler(node, path)
    local method, functionName = XML.attr(node, "method"), XML.attr(node, "function")
    if method then
      return function(self, ...)
        local fn = self[method]
        if not fn then error(path..": script method "..method.." is not defined on the frame") end
        return fn(self, ...)
      end
    elseif functionName then
      return function(...) return _G[functionName](...) end
    end
    local body = node.text
    if body:match("%S") then
      local chunk = assert(loadstring("return function(self, ...) "..body.."\nend", "@"..path..":"..node.tag))
      return chunk()
    end
  end

  local function createRegion(owner, node, layer, path, deferred)
    local tag = node.tag
    local name = XML.attr(node, "name")
    local object
    if tag == "FontString" then
      object = owner:CreateFontString(name, layer, XML.attr(node, "inherits"))
      local color = XML.child(node, "Color")
      if color then object:SetTextColor(number(XML.attr(color, "r")) or 1, number(XML.attr(color, "g")) or 1, number(XML.attr(color, "b")) or 1, number(XML.attr(color, "a")) or 1) end
      if XML.attr(node, "text") then
        if not W.fontData(S[object]) then S[object].fontObject = rawget(_G, "GameFontNormal") end
        object:SetText(XML.attr(node, "text"))
      end
      if XML.attr(node, "justifyH") then object:SetJustifyH(XML.attr(node, "justifyH")) end
      if XML.attr(node, "justifyV") then object:SetJustifyV(XML.attr(node, "justifyV")) end
    else
      local creator = tag == "MaskTexture" and owner.CreateMaskTexture or tag == "Line" and owner.CreateLine or owner.CreateTexture
      object = creator(owner, name, layer, XML.attr(node, "inherits"))
      if XML.attr(node, "file") then object:SetTexture(XML.attr(node, "file")) end
      if XML.attr(node, "atlas") then object:SetAtlas(XML.attr(node, "atlas"), XML.attr(node, "useAtlasSize") == "true") end
      if XML.attr(node, "alphaMode") then object:SetBlendMode(XML.attr(node, "alphaMode")) end
      local coords = XML.child(node, "TexCoords")
      if coords then
        object:SetTexCoord(number(XML.attr(coords, "left")) or 0, number(XML.attr(coords, "right")) or 1, number(XML.attr(coords, "top")) or 0, number(XML.attr(coords, "bottom")) or 1)
      end
      local color = XML.child(node, "Color")
      if color then
        local r, g, b, a = number(XML.attr(color, "r")) or 1, number(XML.attr(color, "g")) or 1, number(XML.attr(color, "b")) or 1, number(XML.attr(color, "a")) or 1
        if XML.attr(node, "file") or XML.attr(node, "atlas") then object:SetVertexColor(r, g, b, a) else object:SetColorTexture(r, g, b, a) end
      end
      local masked = XML.child(node, "MaskedTextures")
      if masked then
        for _, entry in ipairs(masked.children) do
          deferred[#deferred + 1] = function()
            local target = owner[XML.attr(entry, "childKey")]
            if target then target:AddMaskTexture(object) end
          end
        end
      end
    end
    local parentKey = XML.attr(node, "parentKey")
    if parentKey then owner[parentKey] = object end
    applySize(object, node)
    deferred[#deferred + 1] = function()
      applyAnchors(object, node, owner)
      if XML.attr(node, "setAllPoints") == "true" then object:SetAllPoints() end
    end
    if XML.attr(node, "hidden") == "true" then object:Hide() end
    return object
  end

  local frameTags = {
    Frame = true, Button = true, CheckButton = true, EditBox = true, ScrollFrame = true, Slider = true,
    StatusBar = true, Cooldown = true, Model = true, PlayerModel = true, ModelScene = true, GameTooltip = true,
    MessageFrame = true, ScrollingMessageFrame = true, SimpleHTML = true, DressUpModel = true,
  }
  W.frameTags = frameTags

  instantiate = function(frame, node, path)
    local inherits = XML.attr(node, "inherits")
    if inherits then W.applyTemplates(frame, inherits) end
    local mixins = XML.attr(node, "mixin")
    if mixins then
      for mixinName in mixins:gmatch("[^,%s]+") do
        local mixin = rawget(_G, mixinName)
        if not mixin then error(path..": unknown mixin "..mixinName) end
        W.Mixin(frame, mixin)
      end
    end
    if XML.attr(node, "enableMouse") == "true" then frame:EnableMouse(true) end
    if XML.attr(node, "frameStrata") then frame:SetFrameStrata(XML.attr(node, "frameStrata")) end
    if XML.attr(node, "frameLevel") then frame:SetFrameLevel(tonumber(XML.attr(node, "frameLevel"))) end
    if XML.attr(node, "setAllPoints") == "true" then frame:SetAllPoints() end
    applySize(frame, node)
    applyAnchors(frame, node, S[frame].parent or frame)
    local deferred = {}
    for _, section in ipairs(node.children) do
      if section.tag == "Layers" then
        for _, layerNode in ipairs(section.children) do
          local layer = XML.attr(layerNode, "level") or "ARTWORK"
          for _, regionNode in ipairs(layerNode.children) do createRegion(frame, regionNode, layer, path, deferred) end
        end
      elseif section.tag == "Frames" then
        for _, childNode in ipairs(section.children) do
          if frameTags[childNode.tag] then
            local childFrame = W.newFrame(childNode.tag, XML.attr(childNode, "name"), frame)
            instantiate(childFrame, childNode, path)
            local key = XML.attr(childNode, "parentKey")
            if key then frame[key] = childFrame end
            W.fireScript(childFrame, "OnLoad")
          end
        end
      elseif section.tag == "KeyValues" then
        for _, entry in ipairs(section.children) do
          local value, kind = XML.attr(entry, "value"), XML.attr(entry, "type")
          if kind == "number" then value = tonumber(value) elseif kind == "boolean" then value = value == "true" elseif kind == "global" then value = rawget(_G, value) end
          frame[XML.attr(entry, "key")] = value
        end
      elseif section.tag == "Animations" then
        for _, groupNode in ipairs(section.children) do
          local group = frame:CreateAnimationGroup(XML.attr(groupNode, "name"))
          if XML.attr(groupNode, "parentKey") then frame[XML.attr(groupNode, "parentKey")] = group end
          if XML.attr(groupNode, "looping") then group:SetLooping(XML.attr(groupNode, "looping")) end
          for _, animationNode in ipairs(groupNode.children) do
            if animationNode.tag ~= "Scripts" then
              local animation = group:CreateAnimation(animationNode.tag)
              if XML.attr(animationNode, "duration") then animation:SetDuration(tonumber(XML.attr(animationNode, "duration"))) end
              if XML.attr(animationNode, "order") then animation:SetOrder(tonumber(XML.attr(animationNode, "order"))) end
            end
          end
        end
      end
    end
    for _, fn in ipairs(deferred) do fn() end
    local scripts = XML.child(node, "Scripts")
    if scripts then
      for _, scriptNode in ipairs(scripts.children) do
        local handler = scriptHandler(scriptNode, path)
        if handler then
          local inheritMode = XML.attr(scriptNode, "inherit")
          local existing = S[frame].scripts[scriptNode.tag]
          if existing and inheritMode == "prepend" then
            frame:SetScript(scriptNode.tag, function(...) handler(...) return existing(...) end)
          elseif existing and inheritMode == "append" then
            frame:SetScript(scriptNode.tag, function(...) existing(...) return handler(...) end)
          else
            frame:SetScript(scriptNode.tag, handler)
          end
        end
      end
    end
    if XML.attr(node, "hidden") == "true" then frame:Hide() end
  end

  function W.registerXMLFrame(node, path)
    local name = XML.attr(node, "name")
    if XML.attr(node, "virtual") == "true" then
      W.xmlTemplates[name] = { node = node, path = path }
      return
    end
    local parentName = XML.attr(node, "parent")
    local parent = parentName and rawget(_G, parentName) or nil
    local frame = W.newFrame(node.tag, name, parent)
    instantiate(frame, node, path)
    W.fireScript(frame, "OnLoad")
    return frame
  end

  function W.applyTemplates(object, templates)
    for name in templates:gmatch("[^,%s]+") do
      local builder = T[name]
      local xmlTemplate = W.xmlTemplates[name]
      if builder then
        builder(object)
      elseif xmlTemplate then
        instantiate(object, xmlTemplate.node, xmlTemplate.path)
      else
        local entry = W.unknownTemplates[name]
        if not entry then
          entry = { name = name, count = 0, site = W.callSite() }
          W.unknownTemplates[name] = entry
          W.unknownTemplateOrder[#W.unknownTemplateOrder + 1] = name
        end
        entry.count = entry.count + 1
      end
    end
  end
end
