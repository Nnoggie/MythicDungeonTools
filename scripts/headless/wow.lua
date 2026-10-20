-- Headless WoW UI object model: frames, regions, fonts, animations, scripts, geometry.
-- Frame types live in frames.lua, Blizzard templates in templates.lua, globals in api.lua and game.lua.
local W = {
  strict = false,
  missing = {},
  missingOrder = {},
  errors = {},
  created = {},
  objects = {},
  topLevel = {},
  now = 0,
  onUpdateFrames = {},
  sizeWatchers = {},
  playingAnimations = {},
}

W.dir = (debug.getinfo(1, "S").source:match("^@(.*)[/\\][^/\\]*$")) or "."

local S = {}
W.state = S

-- Missing API ------------------------------------------------------------------------------

-- Blame goes to the first stack frame outside this mock, i.e. the addon or library line that called the API.
local function externalLevel()
  local level = 3
  while true do
    local info = debug.getinfo(level, "S")
    if not info then return nil end
    if info.what ~= "C" and not info.short_src:find("headless[/\\]") then return level end
    level = level + 1
  end
end

local function callSite()
  local level = externalLevel()
  local info = level and debug.getinfo(level - 1, "Sl")
  if not info then return "?" end
  return info.short_src..":"..tostring(info.currentline or 0)
end
W.callSite = callSite

local function raise(message)
  local level = externalLevel()
  error(message, level and level - 1 or 2)
end
W.raise = raise

function W.recordMissing(name)
  local entry = W.missing[name]
  if not entry then
    entry = { name = name, count = 0, sites = {} }
    W.missing[name] = entry
    W.missingOrder[#W.missingOrder + 1] = name
  end
  entry.count = entry.count + 1
  local site = callSite()
  entry.sites[site] = (entry.sites[site] or 0) + 1
  if W.strict then raise("missing WoW API: "..name) end
end

-- Keys that plain frames lack and that addons feature-detect (e.g. `if not f.SetBackdrop then Mixin(...)`).
local absentKeys = {
  SetBackdrop = true, GetBackdrop = true, SetBackdropColor = true, GetBackdropColor = true,
  SetBackdropBorderColor = true, GetBackdropBorderColor = true, ApplyBackdrop = true, ClearBackdrop = true,
  HasBackdropInfo = true, SetupTextureCoordinates = true,
}

-- Only verb-shaped keys get a recording stub; noun keys (`frame.HighlightTexture`) stay nil like template children.
local methodVerbs = {}
for verb in ([[Set Get Is Has Can Enable Disable Register Unregister Create Clear Start Stop Play Raise Lower Add
  Remove Release Acquire Toggle Insert Adjust Update Refresh Reset Apply Hook Execute Enumerate Find Copy Cancel
  Freeze Pause Restart Finish Click Show Hide Lock Unlock Should Allows Does Save Restore Run Scroll Zoom Rotate
  Validate Process Fire Request Use]]):gmatch("%a+") do methodVerbs[verb] = true end

local missingStubs = {}
local function missingMember(className, key)
  if type(key) ~= "string" or absentKeys[key] or not methodVerbs[key:match("^%u%l*")] then return nil end
  local name = className..":"..key
  local stub = missingStubs[name]
  if not stub then
    stub = function() W.recordMissing(name) end
    missingStubs[name] = stub
  end
  return stub
end

-- Class registry ---------------------------------------------------------------------------

local classes = {}
W.classes = classes

local function defineClass(name, parentName, scripts)
  local parent = parentName and classes[parentName:lower()]
  local methods = setmetatable({}, { __index = parent and parent.methods })
  local scriptSet = setmetatable({}, { __index = parent and parent.scripts })
  for _, script in ipairs(scripts or {}) do scriptSet[script] = true end
  local class = { name = name, methods = methods, scripts = scriptSet, parent = parent }
  class.meta = {
    __index = function(_, key)
      local method = methods[key]
      if method ~= nil then return method end
      return missingMember(name, key)
    end,
  }
  classes[name:lower()] = class
  return methods
end

local function isA(class, name)
  while class do
    if class.name == name then return true end
    class = class.parent
  end
  return false
end

local function newObject(className, extra)
  local class = assert(classes[className:lower()], "unknown class "..className)
  local obj = setmetatable({}, class.meta)
  local state = extra or {}
  state.class = class
  state.scripts = {}
  S[obj] = state
  W.created[class.name] = (W.created[class.name] or 0) + 1
  W.objects[#W.objects + 1] = obj
  state.id = #W.objects
  return obj, state
end
W.newObject = newObject

function W.isRegion(value)
  return type(value) == "table" and S[value] ~= nil and S[value].isRegion == true
end

local function stateOf(obj, method)
  local state = type(obj) == "table" and S[obj]
  if not state then
    raise(string.format("%s: called with an object that is not a WoW widget (missing ':'?)", method))
  end
  return state
end

local function usage(condition, message)
  if not condition then raise(message) end
end

-- WoW's xpcall forwards extra arguments; PUC Lua 5.1's does not, so install the WoW behaviour.
local nativeXpcall = xpcall
if select(2, nativeXpcall(function(value) return value end, print, true)) ~= true then
  function xpcall(fn, handler, ...)
    local count, args = select("#", ...), { ... }
    return nativeXpcall(function() return fn(unpack(args, 1, count)) end, handler)
  end
end

local function protectedCall(fn, ...)
  return xpcall(fn, W.errorHandler, ...)
end
W.protectedCall = protectedCall

function W.errorHandler(message)
  local trace = debug.traceback(tostring(message), 2)
  W.errors[#W.errors + 1] = { message = tostring(message), trace = trace }
  return message
end

-- ScriptObject -----------------------------------------------------------------------------

local Object = defineClass("Object", nil, {})
function Object:GetObjectType() return stateOf(self, "GetObjectType").class.name end
function Object:IsObjectType(name) return isA(stateOf(self, "IsObjectType").class, name) end
function Object:GetName() return stateOf(self, "GetName").name end
function Object:GetDebugName() return S[self].name or tostring(self) end
function Object:GetParent() return stateOf(self, "GetParent").parent end
function Object:IsForbidden() return false end
function Object:SetForbidden() end
function Object:CanChangeProtectedState() return true end

local function fireScript(obj, scriptName, ...)
  if scriptName == "OnDragStart" then W.mouseDown = true elseif scriptName == "OnDragStop" then W.mouseDown = false end
  local handler = S[obj].scripts[scriptName]
  if handler then return protectedCall(handler, obj, ...) end
end
W.fireScript = fireScript
-- Like the client: the cursor moves onto the frame, and a disabled button only gets OnEnter when it allows motion scripts while disabled.
function W.hover(obj)
  W.cursorTo(obj)
  if obj:IsObjectType("Button") and not obj:IsEnabled() and not obj:GetMotionScriptsWhileDisabled() then return end
  return fireScript(obj, "OnEnter")
end

local function checkScript(obj, scriptName, method)
  local state = stateOf(obj, method)
  usage(type(scriptName) == "string", method.."(): script name must be a string")
  if not state.class.scripts[scriptName] then
    raise(string.format('%s:%s(): %s doesn\'t have a "%s" script', state.class.name, method, state.class.name, scriptName))
  end
  return state
end

function Object:SetScript(scriptName, handler)
  local state = checkScript(self, scriptName, "SetScript")
  usage(handler == nil or type(handler) == "function", "SetScript(): handler must be a function or nil")
  state.scripts[scriptName] = handler
  if scriptName == "OnUpdate" then W.onUpdateFrames[self] = handler and true or nil end
  if scriptName == "OnSizeChanged" then W.sizeWatchers[self] = handler and true or nil end
end

function Object:GetScript(scriptName)
  return checkScript(self, scriptName, "GetScript").scripts[scriptName]
end

function Object:HookScript(scriptName, hook)
  local state = checkScript(self, scriptName, "HookScript")
  local original = state.scripts[scriptName]
  if original then
    state.scripts[scriptName] = function(...)
      original(...)
      return hook(...)
    end
  else
    state.scripts[scriptName] = hook
  end
  if scriptName == "OnUpdate" then W.onUpdateFrames[self] = true end
  if scriptName == "OnSizeChanged" then W.sizeWatchers[self] = true end
end

function Object:HasScript(scriptName) return S[self].class.scripts[scriptName] == true end

-- Geometry ---------------------------------------------------------------------------------

local pointFractions = {
  TOPLEFT = { 0, 1 }, TOP = { 0.5, 1 }, TOPRIGHT = { 1, 1 },
  LEFT = { 0, 0.5 }, CENTER = { 0.5, 0.5 }, RIGHT = { 1, 0.5 },
  BOTTOMLEFT = { 0, 0 }, BOTTOM = { 0.5, 0 }, BOTTOMRIGHT = { 1, 0 },
}

local resolveScreenRect

-- Like the client: positions resolve in screen pixels. A frame's anchor offsets and size are in its own units, so
-- they scale by its effective scale; GetLeft/GetWidth/... divide the screen rect back by that scale.
local function effectiveScaleOf(obj)
  local scale, current = 1, obj
  while current do
    scale = scale * (S[current].scale or 1)
    current = S[current].parent
  end
  return scale
end
W.effectiveScaleOf = effectiveScaleOf

local function anchorPosition(anchor, depth, scale)
  local relative = anchor.relativeTo
  local left, bottom, width, height
  if relative then
    left, bottom, width, height = resolveScreenRect(relative, depth + 1)
    if not left then return nil end
  else
    left, bottom, width, height = 0, 0, W.screenWidth, W.screenHeight
  end
  local fraction = pointFractions[anchor.relativePoint]
  return left + fraction[1] * width + anchor.x * scale, bottom + fraction[2] * height + anchor.y * scale
end

local function solveAxis(constraints, size)
  local low, high, center = constraints[0], constraints[1], constraints[0.5]
  if low and high then return low, high - low end
  if not size then
    if low and center then return low, 2 * (center - low) end
    if high and center then return 2 * center - high, 2 * (high - center) end
    size = 0
  end
  if low then return low, size end
  if high then return high - size, size end
  if center then return center - size / 2, size end
end

resolveScreenRect = function(obj, depth)
  depth = depth or 0
  if depth > 50 then return nil end
  local state = S[obj]
  if obj == W.UIParent or obj == W.WorldFrame then return 0, 0, W.screenWidth, W.screenHeight end
  if #state.points == 0 then return nil end
  local scale = effectiveScaleOf(obj)
  local horizontal, vertical = {}, {}
  for _, anchor in ipairs(state.points) do
    local x, y = anchorPosition(anchor, depth, scale)
    if not x then return nil end
    local fraction = pointFractions[anchor.point]
    horizontal[fraction[1]] = x
    vertical[fraction[2]] = y
  end
  local left, width = solveAxis(horizontal, state.width and state.width * scale)
  local bottom, height = solveAxis(vertical, state.height and state.height * scale)
  return left, bottom, width, height
end
W.resolveScreenRect = resolveScreenRect

-- The rect in the region's own units, as GetLeft/GetRect report it.
local function resolveRect(obj, depth)
  local left, bottom, width, height = resolveScreenRect(obj, depth)
  if not left then return nil end
  local scale = effectiveScaleOf(obj)
  return left / scale, bottom / scale, width / scale, height / scale
end
W.resolveRect = resolveRect

-- The cursor lives in screen pixels, like GetCursorPosition. These take positions in a region's own units
-- (what GetCenter/GetTop report) and convert them.
function W.cursorTo(region, x, y)
  if not x then x, y = region:GetCenter() end
  if not x then W.cursorX, W.cursorY = nil, nil return end
  local scale = effectiveScaleOf(region)
  W.cursorX, W.cursorY = x * scale, y * scale
end
function W.cursorToY(region, y)
  W.cursorY = y * effectiveScaleOf(region)
end

local ScriptRegion = defineClass("ScriptRegion", "Object", {
  "OnShow", "OnHide", "OnEnter", "OnLeave", "OnMouseDown", "OnMouseUp", "OnMouseWheel", "OnLoad",
})

local function normalizePoint(point, method)
  usage(type(point) == "string", method.."(): point must be a string")
  local upper = point:upper()
  usage(pointFractions[upper], method..'(): unknown anchor point "'..point..'"')
  return upper
end

local function resolveRelative(value, method)
  if value == nil then return nil end
  if type(value) == "string" then
    local found = rawget(_G, value)
    usage(found ~= nil and S[found], method..'(): unknown relative frame "'..value..'"')
    return found
  end
  usage(W.isRegion(value), method.."(): Wrong object type for function (relativeTo is not a region)")
  return value
end

local function dependsOn(obj, target, seen)
  if obj == target then return true end
  seen = seen or {}
  if seen[obj] then return false end
  seen[obj] = true
  for _, anchor in ipairs(S[obj].points or {}) do
    if anchor.relativeTo and dependsOn(anchor.relativeTo, target, seen) then return true end
  end
  return false
end

function ScriptRegion:SetPoint(point, a, b, c, d)
  local state = stateOf(self, "SetPoint")
  point = normalizePoint(point, "SetPoint")
  local relativeTo, relativePoint, x, y
  if type(a) == "number" then
    relativeTo, x, y = state.parent, a, b
  else
    relativeTo = a == nil and state.parent or resolveRelative(a, "SetPoint")
    if type(b) == "string" then
      relativePoint = normalizePoint(b, "SetPoint")
      x, y = c, d
    else
      x, y = b, c
    end
  end
  usage(x == nil or type(x) == "number", "SetPoint(): x offset must be a number")
  usage(y == nil or type(y) == "number", "SetPoint(): y offset must be a number")
  if relativeTo == self then raise("SetPoint(): Cannot anchor to itself") end
  if relativeTo and dependsOn(relativeTo, self) then
    raise("SetPoint(): Cannot anchor to a region dependent on it")
  end
  local anchor = { point = point, relativeTo = relativeTo, relativePoint = relativePoint or point, x = x or 0, y = y or 0 }
  for index, existing in ipairs(state.points) do
    if existing.point == point then
      state.points[index] = anchor
      return
    end
  end
  state.points[#state.points + 1] = anchor
end

function ScriptRegion:SetAllPoints(relativeTo)
  local state = stateOf(self, "SetAllPoints")
  if relativeTo == nil or relativeTo == true then relativeTo = state.parent end
  relativeTo = resolveRelative(relativeTo, "SetAllPoints")
  if relativeTo == self then raise("SetAllPoints(): Cannot anchor to itself") end
  state.points = {
    { point = "TOPLEFT", relativeTo = relativeTo, relativePoint = "TOPLEFT", x = 0, y = 0 },
    { point = "BOTTOMRIGHT", relativeTo = relativeTo, relativePoint = "BOTTOMRIGHT", x = 0, y = 0 },
  }
end

function ScriptRegion:ClearAllPoints() stateOf(self, "ClearAllPoints").points = {} end
function ScriptRegion:ClearPoint(point)
  local state = S[self]
  for index, anchor in ipairs(state.points) do
    if anchor.point == point:upper() then table.remove(state.points, index) return end
  end
end
function ScriptRegion:GetNumPoints() return #stateOf(self, "GetNumPoints").points end
function ScriptRegion:GetPoint(index)
  local anchor = stateOf(self, "GetPoint").points[index or 1]
  if not anchor then return nil end
  return anchor.point, anchor.relativeTo, anchor.relativePoint, anchor.x, anchor.y
end
function ScriptRegion:GetPointByName(point)
  for _, anchor in ipairs(S[self].points) do
    if anchor.point == point then return anchor.point, anchor.relativeTo, anchor.relativePoint, anchor.x, anchor.y end
  end
end
function ScriptRegion:AdjustPointsOffset(dx, dy)
  for _, anchor in ipairs(S[self].points) do anchor.x, anchor.y = anchor.x + dx, anchor.y + dy end
end

local function sizeChanged(obj, state, oldWidth, oldHeight)
  if state.width ~= oldWidth or state.height ~= oldHeight then
    if state.class.scripts.OnSizeChanged then
      state.reportedSize = { state.width or 0, state.height or 0 }
      fireScript(obj, "OnSizeChanged", state.width or 0, state.height or 0)
    end
  end
end

-- Once per frame the client re-resolves anchors and fires OnSizeChanged for frames whose size moved since
-- the last report, including moves that came from anchors rather than SetSize. Layouts that size from
-- OnSizeChanged (AceGUI containers, scroll children) depend on it.
function W.layoutPass()
  local frames, fired = {}, 0
  for frame in pairs(W.sizeWatchers) do frames[#frames + 1] = frame end
  table.sort(frames, function(a, b) return S[a].id < S[b].id end)
  for _, frame in ipairs(frames) do
    local state = S[frame]
    if state.scripts.OnSizeChanged and W.isVisible(frame) then
      local _, _, width, height = resolveRect(frame)
      width, height = width or state.width or 0, height or state.height or 0
      local reported = state.reportedSize or { state.width or 0, state.height or 0 }
      if math.abs(width - reported[1]) > 0.001 or math.abs(height - reported[2]) > 0.001 then
        state.reportedSize = { width, height }
        fireScript(frame, "OnSizeChanged", width, height)
        fired = fired + 1
      else
        state.reportedSize = reported
      end
    end
  end
  return fired
end

local function checkNumber(value, method, name)
  if type(value) ~= "number" or value ~= value then
    raise(string.format("%s(): %s must be a number, got %s", method, name or "value", type(value)))
  end
end

function ScriptRegion:SetWidth(width)
  local state = stateOf(self, "SetWidth")
  checkNumber(width, "SetWidth", "width")
  local oldWidth, oldHeight = state.width, state.height
  state.width = width
  sizeChanged(self, state, oldWidth, oldHeight)
end
function ScriptRegion:SetHeight(height)
  local state = stateOf(self, "SetHeight")
  checkNumber(height, "SetHeight", "height")
  local oldWidth, oldHeight = state.width, state.height
  state.height = height
  sizeChanged(self, state, oldWidth, oldHeight)
end
function ScriptRegion:SetSize(width, height)
  local state = stateOf(self, "SetSize")
  checkNumber(width, "SetSize", "width")
  checkNumber(height, "SetSize", "height")
  local oldWidth, oldHeight = state.width, state.height
  state.width, state.height = width, height
  sizeChanged(self, state, oldWidth, oldHeight)
end
function ScriptRegion:GetWidth()
  local state = stateOf(self, "GetWidth")
  local _, _, width = resolveRect(self)
  return width or state.width or 0
end
function ScriptRegion:GetHeight()
  local state = stateOf(self, "GetHeight")
  local _, _, _, height = resolveRect(self)
  return height or state.height or 0
end
function ScriptRegion:GetSize() return self:GetWidth(), self:GetHeight() end
function ScriptRegion:GetLeft() local left = resolveRect(self) return left end
function ScriptRegion:GetBottom() local _, bottom = resolveRect(self) return bottom end
function ScriptRegion:GetRight()
  local left, _, width = resolveRect(self)
  return left and left + width
end
function ScriptRegion:GetTop()
  local _, bottom, _, height = resolveRect(self)
  return bottom and bottom + height
end
function ScriptRegion:GetCenter()
  local left, bottom, width, height = resolveRect(self)
  if not left then return nil end
  return left + width / 2, bottom + height / 2
end
function ScriptRegion:GetRect() return resolveRect(self) end
function ScriptRegion:GetScaledRect() return resolveScreenRect(self) end
function ScriptRegion:IsRectValid() return resolveRect(self) ~= nil end
function ScriptRegion:IsAnchoringRestricted() return false end
function ScriptRegion:IsMouseOver(offsetTop, offsetBottom, offsetLeft, offsetRight)
  if not W.cursorX or not W.isVisible(self) then return false end
  local left, bottom, width, height = resolveScreenRect(self)
  if not left then return false end
  return W.cursorX >= left + (offsetLeft or 0) and W.cursorX <= left + width + (offsetRight or 0)
    and W.cursorY >= bottom + (offsetBottom or 0) and W.cursorY <= bottom + height + (offsetTop or 0)
end
function ScriptRegion:IsMouseMotionFocus() return W.mouseFocus == self end

-- Simulates a user click: the cursor moves to the frame's center first, so IsMouseOver() guards pass.
function W.userClick(frame, button)
  W.cursorTo(frame)
  W.mouseFocus = frame
  W.mouseDown = false
  button = button or "LeftButton"
  if isA(S[frame].class, "Button") then
    frame:Click(button)
  else
    fireScript(frame, "OnMouseDown", button)
    fireScript(frame, "OnMouseUp", button)
    if S[frame].class.name == "EditBox" and S[frame].enabled ~= false then frame:SetFocus() end
  end
end

-- Simulates typing: keystrokes reach only the focused edit box, one character at a time. Like the client, a character
-- past the byte limit is dropped but still fires OnChar.
function W.userType(editBox, text)
  if not editBox:HasFocus() then return false end
  for char in tostring(text):gmatch("[%z\1-\127\194-\244][\128-\191]*") do
    local limit = editBox:GetMaxBytes()
    if limit == 0 or #editBox:GetText() < limit then editBox:Insert(char) end
    fireScript(editBox, "OnChar", char)
  end
  return true
end

-- Simulates dragging a slider's thumb: a disabled slider ignores the mouse.
function W.userDrag(slider, value)
  if S[slider].enabled == false then return false end
  slider:SetValue(value, true)
  return true
end

function ScriptRegion:EnableMouse(enabled) S[self].mouseEnabled = enabled ~= false end
function ScriptRegion:IsMouseEnabled() return S[self].mouseEnabled == true end
function ScriptRegion:EnableMouseMotion(enabled) S[self].mouseMotion = enabled ~= false end
function ScriptRegion:SetMouseClickEnabled(enabled) S[self].mouseClick = enabled end
function ScriptRegion:SetMouseMotionEnabled(enabled) S[self].mouseMotion = enabled end
function ScriptRegion:SetPropagateMouseMotion(enabled) S[self].propagateMouseMotion = enabled end
function ScriptRegion:SetPropagateMouseClicks(enabled) S[self].propagateMouseClicks = enabled end
function ScriptRegion:SetPassThroughButtons() end

function ScriptRegion:SetAlpha(alpha)
  checkNumber(alpha, "SetAlpha", "alpha")
  S[self].alpha = math.max(0, math.min(1, alpha))
end
function ScriptRegion:GetAlpha() return S[self].alpha or 1 end
function ScriptRegion:GetEffectiveAlpha()
  local alpha, current = 1, self
  while current do
    alpha = alpha * (S[current].alpha or 1)
    current = S[current].parent
  end
  return alpha
end
function ScriptRegion:SetIgnoreParentAlpha(value) S[self].ignoreParentAlpha = value end
function ScriptRegion:IsIgnoringParentAlpha() return S[self].ignoreParentAlpha == true end
function ScriptRegion:SetIgnoreParentScale(value) S[self].ignoreParentScale = value end
function ScriptRegion:IsIgnoringParentScale() return S[self].ignoreParentScale == true end
function ScriptRegion:SetScale(scale)
  checkNumber(scale, "SetScale", "scale")
  usage(scale > 0, "SetScale(): scale must be > 0")
  S[self].scale = scale
end
function ScriptRegion:GetScale() return S[self].scale or 1 end
function ScriptRegion:GetEffectiveScale()
  local scale, current = 1, self
  while current do
    scale = scale * (S[current].scale or 1)
    current = S[current].parent
  end
  return scale
end

-- Visibility -------------------------------------------------------------------------------

local function isVisible(obj)
  local current = obj
  while current do
    local state = S[current]
    if not state.shown then return false end
    current = state.parent
  end
  return true
end
W.isVisible = isVisible

local function propagateVisibility(obj, scriptName)
  local state = S[obj]
  if state.class.scripts[scriptName] then fireScript(obj, scriptName) end
  if scriptName == "OnHide" and state.class.name == "EditBox" and state.focus then obj:ClearFocus() end
  for _, child in ipairs(state.children or {}) do
    if S[child].shown then propagateVisibility(child, scriptName) end
  end
end

local function setShown(obj, shown)
  local state = S[obj]
  shown = shown and true or false
  if state.shown == shown then return end
  local wasVisible = isVisible(obj)
  state.shown = shown
  local nowVisible = isVisible(obj)
  if wasVisible ~= nowVisible then propagateVisibility(obj, nowVisible and "OnShow" or "OnHide") end
end

function ScriptRegion:Show() stateOf(self, "Show") setShown(self, true) end
function ScriptRegion:Hide() stateOf(self, "Hide") setShown(self, false) end
function ScriptRegion:SetShown(shown) stateOf(self, "SetShown") setShown(self, shown) end
function ScriptRegion:IsShown() return stateOf(self, "IsShown").shown end
function ScriptRegion:IsVisible() stateOf(self, "IsVisible") return isVisible(self) end

local function detach(obj, state)
  local old = state.parent
  if not old then
    W.topLevel[obj] = nil
    return
  end
  local list = state.isRegion and not state.isFrame and S[old].regions or S[old].children
  for index, child in ipairs(list) do
    if child == obj then table.remove(list, index) break end
  end
end

local function attach(obj, state, parent)
  state.parent = parent
  if not parent then
    W.topLevel[obj] = true
    return
  end
  local list = state.isFrame and S[parent].children or S[parent].regions
  list[#list + 1] = obj
end

function ScriptRegion:SetParent(parent)
  local state = stateOf(self, "SetParent")
  if type(parent) == "string" then parent = rawget(_G, parent) end
  if parent ~= nil then
    usage(type(parent) == "table" and S[parent] and S[parent].isFrame, "SetParent(): Wrong object type for function (parent is not a frame)")
    usage(parent ~= self, "SetParent(): cannot parent a frame to itself")
    local current = parent
    while current do
      usage(current ~= self, "SetParent(): would create a parent cycle")
      current = S[current].parent
    end
  end
  if state.parent == parent then return end
  local wasVisible = isVisible(self)
  detach(self, state)
  attach(self, state, parent)
  -- The setters carry the new strata and level down to descendants, as the client does.
  if state.isFrame and parent then
    if not state.fixedStrata then self:SetFrameStrata(S[parent].strata or "MEDIUM") end
    if not state.fixedLevel then self:SetFrameLevel(math.min(10000, (S[parent].level or 0) + 1)) end
  end
  local nowVisible = isVisible(self)
  if wasVisible ~= nowVisible then propagateVisibility(self, nowVisible and "OnShow" or "OnHide") end
end

-- Regions ----------------------------------------------------------------------------------

local Region = defineClass("Region", "ScriptRegion", {})
local drawLayers = { BACKGROUND = true, BORDER = true, ARTWORK = true, OVERLAY = true, HIGHLIGHT = true }
function Region:SetDrawLayer(layer, sublevel)
  usage(drawLayers[layer], 'SetDrawLayer(): unknown draw layer "'..tostring(layer)..'"')
  usage(sublevel == nil or (type(sublevel) == "number" and sublevel >= -8 and sublevel <= 7), "SetDrawLayer(): sublevel must be between -8 and 7")
  S[self].layer, S[self].sublevel = layer, sublevel or 0
end
function Region:GetDrawLayer() return S[self].layer, S[self].sublevel or 0 end
function Region:SetVertexColor(r, g, b, a) S[self].vertexColor = { r, g, b, a or 1 } end
function Region:GetVertexColor()
  local color = S[self].vertexColor or { 1, 1, 1, 1 }
  return color[1], color[2], color[3], color[4]
end
function Region:IsObjectLoaded() return true end

local function newRegion(className, parent, name, layer, sublevel)
  local obj, state = newObject(className, { isRegion = true, points = {}, shown = true })
  state.name = name and name:gsub("%$parent", parent and S[parent].name or "") or nil
  if state.name and state.name ~= "" then _G[state.name] = obj end
  state.layer = layer or "ARTWORK"
  state.sublevel = sublevel or 0
  attach(obj, state, parent)
  return obj, state
end

local Texture = defineClass("Texture", "Region", {})
function Texture:SetTexture(texture, wrapH, wrapV, filter)
  usage(texture == nil or type(texture) == "string" or type(texture) == "number", "SetTexture(): texture must be a path or file id")
  local state = S[self]
  state.texture, state.atlas, state.color = texture, nil, nil
  if type(texture) == "string" and W.checkAddonFile then W.checkAddonFile(texture) end
  return true
end
function Texture:GetTexture() return S[self].texture end
function Texture:GetTextureFileID() return type(S[self].texture) == "number" and S[self].texture or nil end
function Texture:GetTextureFilePath() return S[self].texture end
function Texture:SetColorTexture(r, g, b, a)
  checkNumber(r, "SetColorTexture", "r")
  S[self].color = { r, g, b, a or 1 }
  S[self].texture = nil
end
function Texture:SetAtlas(atlas, useAtlasSize, filterMode)
  usage(type(atlas) == "string", "SetAtlas(): atlas must be a string")
  local state = S[self]
  state.atlas, state.texture = atlas, nil
  if useAtlasSize then state.width, state.height = state.width or 16, state.height or 16 end
  return true
end
function Texture:GetAtlas() return S[self].atlas end
function Texture:SetTexCoord(...)
  local count = select("#", ...)
  usage(count == 4 or count == 8, "SetTexCoord(): expected 4 or 8 numbers")
  for index = 1, count do checkNumber((select(index, ...)), "SetTexCoord", "coordinate") end
  S[self].texCoord = { ... }
end
function Texture:GetTexCoord()
  local coords = S[self].texCoord or { 0, 1, 0, 1 }
  if #coords == 4 then
    local left, right, top, bottom = coords[1], coords[2], coords[3], coords[4]
    return left, top, left, bottom, right, top, right, bottom
  end
  return unpack(coords)
end
function Texture:SetDesaturated(value) S[self].desaturated = value end
function Texture:IsDesaturated() return S[self].desaturated == true end
function Texture:SetDesaturation(value) S[self].desaturated = value and value > 0 end
function Texture:SetBlendMode(mode) S[self].blendMode = mode end
function Texture:GetBlendMode() return S[self].blendMode or "BLEND" end
function Texture:SetRotation(radians, center) S[self].rotation = radians end
function Texture:GetRotation() return S[self].rotation or 0 end
function Texture:SetGradient(orientation, minColor, maxColor) S[self].gradient = { orientation, minColor, maxColor } end
function Texture:SetHorizTile(value) S[self].horizTile = value end
function Texture:SetVertTile(value) S[self].vertTile = value end
function Texture:SetSnapToPixelGrid(value) end
function Texture:SetTexelSnappingBias(value) end
function Texture:SetMask(path) S[self].mask = path end
function Texture:AddMaskTexture(mask)
  usage(W.isRegion(mask), "AddMaskTexture(): mask must be a MaskTexture")
  S[self].masks = S[self].masks or {}
  table.insert(S[self].masks, mask)
end
function Texture:RemoveMaskTexture(mask) end
function Texture:GetNumMaskTextures() return #(S[self].masks or {}) end
function Texture:ResetTexCoord() S[self].texCoord = nil end
function Texture:SetNonBlocking() end
function Texture:IsBlockingLoadRequested() return false end
function Texture:SetSpriteSheetCell() end

defineClass("MaskTexture", "Texture", {})

local Line = defineClass("Line", "Texture", {})
function Line:SetStartPoint(relativePoint, relativeTo, x, y) S[self].startPoint = { relativePoint, relativeTo, x, y } end
function Line:SetEndPoint(relativePoint, relativeTo, x, y) S[self].endPoint = { relativePoint, relativeTo, x, y } end
function Line:GetStartPoint() return unpack(S[self].startPoint or {}) end
function Line:GetEndPoint() return unpack(S[self].endPoint or {}) end
function Line:SetThickness(thickness) checkNumber(thickness, "SetThickness") S[self].thickness = thickness end
function Line:GetThickness() return S[self].thickness or 1 end

-- Fonts ------------------------------------------------------------------------------------

local FontInstance = defineClass("FontInstance", "Object", {})

local function fontData(state)
  if state.font then return state.font end
  if state.fontObject then return fontData(S[state.fontObject]) end
end

function FontInstance:SetFont(path, height, flags)
  usage(type(path) == "string", "SetFont(): font path must be a string")
  checkNumber(height, "SetFont", "height")
  S[self].font = { path = path, height = height, flags = flags or "" }
  return true
end
function FontInstance:GetFont()
  local font = fontData(S[self])
  if not font then return nil end
  return font.path, font.height, font.flags
end
function FontInstance:SetFontObject(fontObject)
  if type(fontObject) == "string" then
    local found = rawget(_G, fontObject)
    usage(found and S[found], 'SetFontObject(): unknown font object "'..fontObject..'"')
    fontObject = found
  end
  usage(fontObject == nil or (S[fontObject] and isA(S[fontObject].class, "FontInstance")), "SetFontObject(): argument is not a font object")
  local state = S[self]
  state.fontObject, state.font = fontObject, nil
end
function FontInstance:GetFontObject() return S[self].fontObject end
function FontInstance:SetTextColor(r, g, b, a) S[self].textColor = { r, g, b, a or 1 } end
function FontInstance:GetTextColor()
  local state = S[self]
  local color = state.textColor or (state.fontObject and { state.fontObject:GetTextColor() }) or { 1, 1, 1, 1 }
  return color[1], color[2], color[3], color[4]
end
function FontInstance:SetShadowColor(r, g, b, a) S[self].shadowColor = { r, g, b, a or 1 } end
function FontInstance:GetShadowColor() return unpack(S[self].shadowColor or { 0, 0, 0, 1 }) end
function FontInstance:SetShadowOffset(x, y) S[self].shadowOffset = { x, y } end
function FontInstance:GetShadowOffset() return unpack(S[self].shadowOffset or { 0, 0 }) end
function FontInstance:SetJustifyH(value)
  usage(value == "LEFT" or value == "CENTER" or value == "RIGHT", 'SetJustifyH(): invalid value "'..tostring(value)..'"')
  S[self].justifyH = value
end
function FontInstance:GetJustifyH() return S[self].justifyH or "CENTER" end
function FontInstance:SetJustifyV(value)
  usage(value == "TOP" or value == "MIDDLE" or value == "BOTTOM", 'SetJustifyV(): invalid value "'..tostring(value)..'"')
  S[self].justifyV = value
end
function FontInstance:GetJustifyV() return S[self].justifyV or "MIDDLE" end
function FontInstance:SetSpacing(value) S[self].spacing = value end
function FontInstance:GetSpacing() return S[self].spacing or 0 end
function FontInstance:SetIndentedWordWrap(value) end
function FontInstance:GetIndentedWordWrap() return false end

local Font = defineClass("Font", "FontInstance", {})
function Font:CopyFontObject(source)
  if type(source) == "string" then source = rawget(_G, source) end
  usage(source and S[source], "CopyFontObject(): source is not a font object")
  local from, to = S[source], S[self]
  local font = fontData(from)
  to.font = font and { path = font.path, height = font.height, flags = font.flags }
  to.fontObject = nil
  to.textColor = from.textColor and { unpack(from.textColor) }
  to.justifyH, to.justifyV = from.justifyH, from.justifyV
end
function Font:GetFontObjectForAlphabet() return self end

function W.CreateFont(name, path, height, flags)
  local font, state = newObject("Font", {})
  state.name = name
  if path then state.font = { path = path, height = height or 12, flags = flags or "" } end
  if name then _G[name] = font end
  return font
end

local FontString = defineClass("FontString", "Region", {})
for key, value in pairs(FontInstance) do rawset(FontString, key, value) end

function FontString:SetText(text)
  usage(text == nil or type(text) == "string" or type(text) == "number", "FontString:SetText(): text must be a string, number or nil, got "..type(text))
  if not fontData(S[self]) then raise("FontString:SetText(): Font not set") end
  S[self].text = text ~= nil and tostring(text) or nil
end
function FontString:SetFormattedText(format, ...) self:SetText(string.format(format, ...)) end
function FontString:GetText() return S[self].text end
function FontString:GetUnboundedStringWidth()
  local font = fontData(S[self])
  local text = S[self].text or ""
  local longest = 0
  for line in (text.."\n"):gmatch("(.-)\n") do longest = math.max(longest, #line:gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", "")) end
  return longest * (font and font.height or 12) * 0.55
end
-- The width the string is laid out in: anchored on both sides, or an explicit width. nil when the string sizes itself.
local function boundedWidth(fontString)
  local state = S[fontString]
  local left, right
  for _, anchor in ipairs(state.points) do
    local fraction = pointFractions[anchor.point][1]
    if fraction == 0 then left = true elseif fraction == 1 then right = true end
  end
  local width = state.width
  if left and right then width = select(3, resolveRect(fontString)) end
  if width and width > 0 then return width end
end
-- Like the client: a bounded string reports at most its bounded width (truncated or wrapped).
function FontString:GetStringWidth()
  local width, bound = self:GetUnboundedStringWidth(), boundedWidth(self)
  return bound and math.min(width, bound) or width
end
FontString.GetWrappedWidth = FontString.GetStringWidth
-- Wrapped line count at the string's width, using the same per-character estimate as GetStringWidth.
local function wrappedLines(self)
  local state = S[self]
  local font = fontData(state)
  local height = font and font.height or 12
  local _, _, width = resolveRect(self)
  width = width or state.width
  local lines = 0
  for line in ((state.text or "").."\n"):gmatch("(.-)\n") do
    local lineWidth = #line:gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", "") * height * 0.55
    if width and width > 0 and state.wordWrap ~= false and lineWidth > width then
      lines = lines + math.ceil(lineWidth / width)
    else
      lines = lines + 1
    end
  end
  if state.maxLines and state.maxLines > 0 then lines = math.min(lines, state.maxLines) end
  return lines, height
end
function FontString:GetStringHeight()
  local lines, height = wrappedLines(self)
  return lines * height
end
function FontString:GetNumLines() return (wrappedLines(self)) end
function FontString:SetWordWrap(value) S[self].wordWrap = value end
function FontString:CanWordWrap() return S[self].wordWrap ~= false end
function FontString:SetNonSpaceWrap(value) end
function FontString:CanNonSpaceWrap() return false end
function FontString:SetMaxLines(value) S[self].maxLines = value end
function FontString:GetMaxLines() return S[self].maxLines or 0 end
function FontString:IsTruncated() return false end
function FontString:SetTextHeight(height) end
function FontString:SetTextScale(scale) end
function FontString:GetTextScale() return 1 end
function FontString:SetAlphaGradient() end
function FontString:GetFieldSize() return 0 end
function FontString:SetFixedColor() end

W.ScriptRegion = ScriptRegion
W.newRegion = newRegion
W.fontData = fontData
W.usage = usage
W.checkNumber = checkNumber
W.defineClass = defineClass
W.isA = isA
W.attach = attach

dofile(W.dir.."/animations.lua")(W)
dofile(W.dir.."/frames.lua")(W)
dofile(W.dir.."/templates.lua")(W)
dofile(W.dir.."/api.lua")(W)
dofile(W.dir.."/game.lua")(W)
dofile(W.dir.."/dump.lua")(W)
dofile(W.dir.."/render.lua")(W)

return W
