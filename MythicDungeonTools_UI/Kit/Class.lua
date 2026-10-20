local _, MDT = ...
local UI = MDT.UI
local Theme = UI.Theme

UI.Fonts.Setup()

local Holder = CreateFrame("Frame", "MDTKitHolder", UIParent)
Holder:Hide()
UI.Holder = Holder

---Every kit control carries these methods. The control is the native frame.
---@class MDT.UI.ControlBase
local Base = {}
UI.Base = Base

---Runs a callback prop through the error handler. A release requested while the callback runs waits for it to return.
---@param name string
---@return ...
function Base:Emit(name, ...)
  local fn = self.kitProps[name]
  if not fn then return end
  self.kitEmitDepth = (self.kitEmitDepth or 0) + 1
  local results = { xpcall(fn, geterrorhandler(), ...) }
  self.kitEmitDepth = self.kitEmitDepth - 1
  if self.kitEmitDepth == 0 and self.kitReleasePending then
    self.kitReleasePending = nil
    self:Release()
  end
  if results[1] then return unpack(results, 2) end
end

---Idempotent. Releases the subtree, resets every prop to its default and parks the frame in its class pool.
function Base:Release()
  if self.kitReleased then return end
  if (self.kitEmitDepth or 0) > 0 then
    self.kitReleasePending = true
    return
  end
  self.kitReleased = true
  if self.kitChildren then
    local children = self.kitChildren
    self.kitChildren = {}
    for _, child in ipairs(children) do
      if child.kitPersistent then
        self.kitChildren[#self.kitChildren + 1] = child
        child:ReleaseChildren()
      end
    end
    for i = #children, 1, -1 do
      local child = children[i]
      if not child.kitPersistent then
        child.kitParent = nil
        child:Release()
      end
    end
  end
  local def = self.kit
  if def.OnRelease then def.OnRelease(self) end
  for _, prop in ipairs(def.allProps) do self.kitProps[prop.name] = prop.default end
  for _, prop in ipairs(def.allProps) do
    if prop.set then prop.set(self, prop.default) end
  end
  if self.kitParent then self.kitParent:kitDisown(self) end
  UI.Tooltip.Hide(self)
  self:Hide()
  self:ClearAllPoints()
  self:SetParent(Holder)
  def.pool:Release(self)
end

function Base:InvalidateLayout()
  if self.kitParent then UI.Layout.Invalidate(self.kitParent) end
end

---Natural size for the parent's layout. Classes override via def.Measure.
---@param availW number
---@return number width, number height
function Base:kitMeasure(availW)
  local measure = self.kit.Measure
  if measure then return measure(self, availW) end
  return self.kitProps.width or self:GetWidth(), self:GetHeight()
end

---@param disabled boolean
function Base:SetDisabled(disabled)
  self.kitProps.disabled = disabled and true or false
  if self.SetEnabled then self:SetEnabled(not disabled) end
  if self.kitRepaint then self:kitRepaint() end
end

function Base:IsDisabled()
  return self.kitProps.disabled == true
end

---@return MDT.UI.State
function Base:kitState()
  if self.kitProps.disabled then return "disabled" end
  if self.kitPressed then return "pressed" end
  if self.kitProps.selected or self.kitFocused then return "selected" end
  if self.kitHovered then return "hover" end
  return "normal"
end

local function onEnter(self)
  self.kitHovered = true
  if self.kitRepaint then self:kitRepaint() end
  if self.kitProps.tooltip then UI.Tooltip.Show(self, self.kitProps.tooltip) end
end

local function onLeave(self)
  self.kitHovered = nil
  self.kitPressed = nil
  if self.kitRepaint then self:kitRepaint() end
  if self.kitProps.tooltip then UI.Tooltip.Hide(self) end
end

local function onMouseDown(self)
  self.kitPressed = true
  if self.kitRepaint then self:kitRepaint() end
end

local function onMouseUp(self)
  self.kitPressed = nil
  if self.kitRepaint then self:kitRepaint() end
end

---@type MDT.UI.PropDef[]
local commonProps = {
  { name = "id", default = nil },
  { name = "width", default = nil, relayout = true, set = function(self, v) if v then self:SetWidth(v) end end },
  { name = "height", default = nil, relayout = true, set = function(self, v) if v then self:SetHeight(Theme.Size(v)) end end },
  { name = "grow", default = nil, relayout = true },
  { name = "hidden", default = false, relayout = true, set = function(self, v) self:SetShown(not v) end },
  { name = "tooltip", default = nil },
}
local nativeSetters = { width = true, height = true, id = true }

local function capitalize(name)
  return name:sub(1, 1):upper()..name:sub(2)
end

---Registers a control class and returns its constructor. The constructor applies every declared prop on every acquire.
---@param def MDT.UI.ClassDef
---@return fun(parent: table, spec: table?): MDT.UI.Control
function UI.Define(def)
  assert(def.name and def.frameType and def.props and def.Create, "UI.Define: name, frameType, props and Create are required")
  local allProps, index = {}, {}
  for _, prop in ipairs(commonProps) do
    allProps[#allProps + 1] = prop
    index[prop.name] = prop
  end
  for _, prop in ipairs(def.props) do
    assert(not index[prop.name], def.name..": prop "..prop.name.." is already declared")
    allProps[#allProps + 1] = prop
    index[prop.name] = prop
  end
  def.allProps, def.propIndex = allProps, index

  local function definedByMixin(name)
    if Base[name] then return true end
    for _, mixin in ipairs(def.mixins or {}) do
      if mixin[name] then return true end
    end
    return false
  end
  local methods = {}
  for _, prop in ipairs(allProps) do
    if not nativeSetters[prop.name] and not definedByMixin("Set"..capitalize(prop.name)) then
      methods["Set"..capitalize(prop.name)] = function(self, value)
        self.kitProps[prop.name] = value
        if prop.set then prop.set(self, value) end
        if prop.relayout then self:InvalidateLayout() end
      end
    end
  end

  local function creator()
    local frame = CreateFrame(def.frameType, nil, Holder, def.template)
    Mixin(frame, Base)
    for _, mixin in ipairs(def.mixins or {}) do Mixin(frame, mixin) end
    Mixin(frame, methods)
    frame.kit = def
    frame.kitProps = {}
    def.Create(frame)
    if frame:HasScript("OnEnter") then
      frame:HookScript("OnEnter", onEnter)
      frame:HookScript("OnLeave", onLeave)
    end
    if frame:HasScript("OnMouseDown") then
      frame:HookScript("OnMouseDown", onMouseDown)
      frame:HookScript("OnMouseUp", onMouseUp)
    end
    return frame
  end
  def.pool = CreateObjectPool(creator, nil)
  UI.classes = UI.classes or {}
  UI.classes[def.name] = def

  local function construct(parent, spec)
    spec = spec or {}
    for key in pairs(spec) do
      if not index[key] then error(def.name..": unknown spec key '"..tostring(key).."'", 2) end
    end
    local frame = def.pool:Acquire()
    frame.kitReleased = false
    frame:SetParent(parent)
    UI.Pixel.RefreshFrame(frame)
    for _, prop in ipairs(allProps) do
      local value = spec[prop.name]
      if value == nil then value = prop.default end
      frame.kitProps[prop.name] = value
    end
    for _, prop in ipairs(allProps) do
      if prop.set then prop.set(frame, frame.kitProps[prop.name]) end
    end
    if frame.kitRepaint then frame:kitRepaint() end
    if parent and parent.kitAdopt then parent:kitAdopt(frame) end
    return frame
  end
  UI[def.name] = construct
  return construct
end

---Releases every control in the kit's pools. Test and teardown helper.
function UI.ReleaseAll()
  for _, def in pairs(UI.classes or {}) do
    local active = {}
    for frame in def.pool:EnumerateActive() do active[#active + 1] = frame end
    for _, frame in ipairs(active) do frame:Release() end
  end
end

UI.Mixins = {}

---Hover, press, selected and disabled states painted from a skin variant.
---@class MDT.UI.Skinned
local Skinned = {}
UI.Mixins.Skinned = Skinned

---@param variant MDT.UI.Variant
function Skinned:kitSkinInit(variant)
  if not self.kitBackground then
    self.kitBackground = self:CreateTexture(nil, "BACKGROUND")
    self.kitBackground:SetAllPoints()
    self.kitBorder = UI.Pixel.Border(self, "border.normal")
  end
  self.kitVariant = variant
  self:kitRepaint()
end

function Skinned:kitRepaint()
  if not self.kitVariant then return end
  local row = Theme.Skin(self.kitVariant, self:kitState())
  if row.bg then
    Theme.Bind(self.kitBackground, row.bg)
    self.kitBackground:Show()
  else
    self.kitBackground:Hide()
  end
  if row.border then
    self.kitBorder:SetToken(row.border)
    self.kitBorder:SetShown(true)
  else
    self.kitBorder:SetShown(false)
  end
  if self.kitLabel then Theme.Bind(self.kitLabel, self.kitProps.textColor or row.text) end
  if self.kitOnRepaint then self:kitOnRepaint(row) end
end
