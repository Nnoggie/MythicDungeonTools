local _, MDT = ...
local UI = MDT.UI
local Theme, Fonts = UI.Theme, UI.Fonts

local INSET = 6
local LABEL_HEIGHT = 14
local LINE_HEIGHT = 14
local NATURAL_WIDTH = 160
local WHEEL_STEP = 28
-- Ctrl+C still counts when Ctrl comes up shortly before C does, as people often release both at once.
local COPY_GRACE = 0.5

---OnUpdate of a focused box with onCopy: remembers when Ctrl was last held.
local function trackCtrl(edit)
  if IsControlKeyDown() then edit.kitCtrlAt = GetTime() end
end

local Methods = {}
function Methods:GetValue() return self.kitProps.value end
function Methods:Focus() self.kitEdit:SetFocus() end
function Methods:ClearFocus() self.kitEdit:ClearFocus() end
function Methods:SelectAll() self.kitEdit:HighlightText(0, -1) end
---@param position integer
function Methods:SetCursor(position) self.kitEdit:SetCursorPosition(position) end

local function repaint(self)
  local row = Theme.Skin("field", self:kitState())
  Theme.Bind(self.kitFieldBackground, row.bg or "bg.sunken")
  self.kitFieldBorder:SetToken(row.border or "border.strong")
  Theme.Bind(self.kitEdit, row.text)
  Theme.Bind(self.kitLabel, self.kitProps.disabled and "text.disabled" or "text.muted")
  self.kitPlaceholder:SetShown(self.kitProps.value == "" and not self.kitEdit:HasFocus() and self.kitProps.placeholder ~= nil)
end

local function arrange(self)
  local props = self.kitProps
  local top = 0
  if props.label and props.label ~= "" then
    self.kitLabel:SetText(props.label)
    self.kitLabel:Show()
    top = LABEL_HEIGHT + Theme.Space("xs")
  else
    self.kitLabel:Hide()
  end
  self.kitField:SetPoint("TOPLEFT", self, "TOPLEFT", 0, -top)
  self.kitEdit:SetMultiLine(props.multiline)
  if props.multiline then
    self.kitScroll:SetPoint("BOTTOMRIGHT", self.kitField, "BOTTOMRIGHT", -(INSET + 8 + Theme.Space("xs")), INSET)
    self.kitEdit:SetJustifyV("TOP")
    self.kitBar:Show()
  else
    self.kitScroll:SetPoint("BOTTOMRIGHT", self.kitField, "BOTTOMRIGHT", -INSET, INSET)
    self.kitEdit:SetJustifyV("MIDDLE")
    self.kitBar:Hide()
  end
  self:InvalidateLayout()
end

local function fieldHeight(self)
  local props = self.kitProps
  if props.multiline then return (props.lines or 1) * LINE_HEIGHT + INSET * 2 end
  return Theme.Size("md")
end

---A multiline edit box must be as tall as its text: at a fixed one-line height the client cuts the text after the
---first line and ends it with "...". A hidden copy of the text measures the height.
local function fitHeight(self)
  if not self.kitProps.multiline then return end
  local measure = self.kitTextMeasure
  measure:SetWidth(math.max(1, self.kitEdit:GetWidth()))
  -- A trailing newline still holds the cursor on a new line.
  measure:SetText((self.kitEdit:GetText() or ""):gsub("\n$", "\n ").." ")
  local height = math.max(self.kitScroll:GetHeight(), math.ceil(measure:GetStringHeight()) + 2)
  if math.abs(self.kitEdit:GetHeight() - height) > 0.5 then self.kitEdit:SetHeight(height) end
end

local function updateScroll(self)
  if not self.kitProps.multiline then return end
  fitHeight(self)
  local viewH = self.kitScroll:GetHeight()
  local contentH = self.kitEdit:GetHeight()
  self.kitBar:SetRange(viewH, contentH)
  local maxOffset = math.max(0, contentH - viewH)
  self.kitScroll:SetVerticalScroll(math.min(maxOffset, self.kitScroll:GetVerticalScroll()))
end

local function setValue(self, text)
  text = text or ""
  self.kitProps.value = text
  if self.kitEdit:GetText() ~= text then
    self.kitSettingValue = true
    self.kitEdit:SetText(text)
    self.kitSettingValue = nil
  end
  updateScroll(self)
  repaint(self)
end

---@param source "enter"|"blur"
local function commit(self, source)
  local text = self.kitEdit:GetText()
  if source == "blur" and text == self.kitLastCommit then return end
  self.kitLastCommit = text
  self:Emit("onCommit", text, self, source)
end

local function flushPaste(self)
  UI.Script(self, "OnUpdate", nil)
  local text = table.concat(self.kitPaste)
  self.kitPaste = nil
  self.kitEdit:SetMaxBytes(self.kitProps.maxBytes or 0)
  self:Emit("onPaste", text, self)
end

---Collects a keystroke burst outside the field. The field holds one byte meanwhile, so a huge paste costs no layout.
local function bufferChar(self, char)
  if not self.kitProps.onPaste then return end
  if not self.kitPaste then
    self.kitPaste = {}
    self.kitEdit:SetMaxBytes(1)
    UI.Script(self, "OnUpdate", flushPaste)
  end
  self.kitPaste[#self.kitPaste + 1] = char
end

---@class MDT.UI.EditBoxSpec : MDT.UI.CommonSpec
---@field value string?
---@field label string?
---@field placeholder string?
---@field multiline boolean?
---@field lines number? visible lines when multiline
---@field numeric boolean?
---@field maxLetters number?
---@field maxBytes number?
---@field readOnly boolean? text can be selected and copied but not changed
---@field selectAllOnFocus boolean?
---@field autoFocus boolean? focus right after creation
---@field disabled boolean?
---@field font MDT.UI.FontRole?
---@field justify "LEFT"|"CENTER"|"RIGHT"? default "LEFT"
---@field onChange fun(text: string, self: MDT.UI.Control)? every user edit
---@field onCommit fun(text: string, self: MDT.UI.Control, source: "enter"|"blur")? every Enter; focus lost only when the text changed since the last commit
---@field onEscape fun(self: MDT.UI.Control)? after Escape restored the last committed text (reported through onChange) and dropped focus without committing
---@field onFocusLost fun(self: MDT.UI.Control)?
---@field onCopy fun(self: MDT.UI.Control)? Ctrl+C pressed while focused
---@field onWheel fun(delta: number, self: MDT.UI.Control)? mouse wheel over the field; replaces scrolling the text
---@field onPaste fun(text: string, self: MDT.UI.Control)? for boxes that take very long pastes (route strings): characters arriving within one frame are collected outside the field and delivered together on the next frame; the caller sets what the field shows
UI.Define({
  name = "EditBox", frameType = "Frame", mixins = { Methods },
  props = {
    { name = "font", default = "body", set = function(self, v) self.kitEdit:SetFontObject(Fonts.Get(v)) end },
    { name = "justify", default = "LEFT", set = function(self, v) self.kitEdit:SetJustifyH(v) end },
    { name = "label", default = nil, set = arrange, relayout = true },
    { name = "placeholder", default = nil, set = function(self, v) self.kitPlaceholder:SetText(v or "") repaint(self) end },
    { name = "multiline", default = false, set = arrange, relayout = true },
    { name = "lines", default = 1, set = arrange, relayout = true },
    { name = "numeric", default = false, set = function(self, v) self.kitEdit:SetNumeric(v) end },
    { name = "maxLetters", default = 0, set = function(self, v) self.kitEdit:SetMaxLetters(v or 0) end },
    { name = "maxBytes", default = 0, set = function(self, v) self.kitEdit:SetMaxBytes(v or 0) end },
    { name = "readOnly", default = false },
    { name = "selectAllOnFocus", default = false },
    { name = "disabled", default = false, set = function(self, v)
      if v then self.kitEdit:ClearFocus() end
      self.kitEdit:SetEnabled(not v)
      repaint(self)
    end },
    { name = "value", default = "", set = setValue },
    { name = "autoFocus", default = false, set = function(self, v) if v and not self.kitReleased then self.kitEdit:SetFocus() end end },
    { name = "onChange", default = nil },
    { name = "onCommit", default = nil },
    { name = "onEscape", default = nil },
    { name = "onFocusLost", default = nil },
    { name = "onCopy", default = nil },
    { name = "onWheel", default = nil },
    { name = "onPaste", default = nil },
  },
  Create = function(self)
    self.kitLabel = self:CreateFontString(nil, "ARTWORK")
    self.kitLabel:SetFontObject(Fonts.Get("small"))
    self.kitLabel:SetPoint("TOPLEFT", self, "TOPLEFT", 0, 0)
    self.kitLabel:SetPoint("TOPRIGHT", self, "TOPRIGHT", 0, 0)
    self.kitLabel:SetHeight(LABEL_HEIGHT)
    self.kitLabel:SetJustifyH("LEFT")

    self.kitField = CreateFrame("Frame", nil, self)
    self.kitField:SetPoint("TOPLEFT", self, "TOPLEFT", 0, 0)
    self.kitField:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT", 0, 0)
    self.kitFieldBackground = self.kitField:CreateTexture(nil, "BACKGROUND")
    self.kitFieldBackground:SetAllPoints()
    self.kitFieldBorder = UI.Pixel.Border(self.kitField, "border.strong")

    self.kitScroll = CreateFrame("ScrollFrame", nil, self.kitField)
    self.kitScroll:SetPoint("TOPLEFT", self.kitField, "TOPLEFT", INSET, -INSET)
    self.kitScroll:SetClipsChildren(true)
    self.kitEdit = CreateFrame("EditBox", nil, self.kitScroll)
    self.kitEdit:SetAutoFocus(false)
    self.kitEdit:SetFontObject(Fonts.Get("body"))
    self.kitEdit:SetPoint("TOPLEFT", self.kitScroll, "TOPLEFT", 0, 0)
    self.kitEdit:SetPoint("TOPRIGHT", self.kitScroll, "TOPRIGHT", 0, 0)
    self.kitEdit:SetHeight(LINE_HEIGHT)
    self.kitEdit:SetTextInsets(0, 0, 0, 0)
    self.kitScroll:SetScrollChild(self.kitEdit)
    UI.Script(self.kitScroll, "OnSizeChanged", function(scroll, width)
      self.kitEdit:SetWidth(width)
      if not self.kitProps.multiline then self.kitEdit:SetHeight(scroll:GetHeight()) end
      updateScroll(self)
    end)
    self.kitScroll:EnableMouseWheel(true)
    UI.Script(self.kitScroll, "OnMouseWheel", function(scroll, delta)
      if self.kitProps.onWheel then
        self:Emit("onWheel", delta, self)
        return
      end
      local maxOffset = math.max(0, self.kitEdit:GetHeight() - scroll:GetHeight())
      local offset = math.max(0, math.min(maxOffset, scroll:GetVerticalScroll() - delta * WHEEL_STEP))
      scroll:SetVerticalScroll(offset)
      self.kitBar:SetValue(offset)
    end)
    self.kitBar = UI.Scrollbar(self.kitField, { onChange = function(offset) self.kitScroll:SetVerticalScroll(offset) end })
    self.kitBar:SetPoint("TOPRIGHT", self.kitField, "TOPRIGHT", -INSET, -INSET)
    self.kitBar:SetPoint("BOTTOMRIGHT", self.kitField, "BOTTOMRIGHT", -INSET, INSET)

    self.kitTextMeasure = self:CreateFontString(nil, "ARTWORK")
    self.kitTextMeasure:SetFontObject(Fonts.Get("body"))
    self.kitTextMeasure:SetWordWrap(true)
    self.kitTextMeasure:SetNonSpaceWrap(true)
    self.kitTextMeasure:SetJustifyH("LEFT")
    self.kitTextMeasure:Hide()
    self.kitPlaceholder = self.kitScroll:CreateFontString(nil, "ARTWORK")
    self.kitPlaceholder:SetFontObject(Fonts.Get("body"))
    self.kitPlaceholder:SetPoint("TOPLEFT", self.kitScroll, "TOPLEFT", 0, 0)
    self.kitPlaceholder:SetJustifyH("LEFT")
    Theme.Bind(self.kitPlaceholder, "text.disabled")

    UI.Script(self.kitEdit, "OnTextChanged", function(edit, userInput)
      if self.kitSettingValue then return end
      local text = edit:GetText()
      if self.kitProps.readOnly and text ~= self.kitProps.value then
        self.kitSettingValue = true
        edit:SetText(self.kitProps.value)
        self.kitSettingValue = nil
        return
      end
      self.kitProps.value = text
      updateScroll(self)
      repaint(self)
      if userInput then self:Emit("onChange", text, self) end
    end)
    UI.Script(self.kitEdit, "OnEnterPressed", function(edit)
      if self.kitProps.multiline then return end
      commit(self, "enter")
      edit:ClearFocus()
    end)
    UI.Script(self.kitEdit, "OnEscapePressed", function(edit)
      local committed = self.kitLastCommit
      if committed and edit:GetText() ~= committed then
        edit:SetText(committed)
        self:Emit("onChange", committed, self)
      end
      edit:ClearFocus()
      self:Emit("onEscape", self)
    end)
    UI.Script(self.kitEdit, "OnEditFocusGained", function(edit)
      self.kitFocused = true
      if self.kitProps.onCopy then UI.Script(edit, "OnUpdate", trackCtrl) end
      self.kitLastCommit = edit:GetText()
      repaint(self)
      if self.kitProps.selectAllOnFocus then edit:HighlightText(0, -1) end
    end)
    UI.Script(self.kitEdit, "OnEditFocusLost", function(edit)
      self.kitFocused = nil
      UI.Script(edit, "OnUpdate", nil)
      edit.kitCtrlAt = nil
      edit:HighlightText(0, 0)
      repaint(self)
      commit(self, "blur")
      self:Emit("onFocusLost", self)
    end)
    UI.Script(self.kitEdit, "OnChar", function(_, char) bufferChar(self, char) end)
    UI.Script(self.kitEdit, "OnKeyUp", function(edit, key)
      if key ~= "C" then return end
      if IsControlKeyDown() or (edit.kitCtrlAt and GetTime() - edit.kitCtrlAt < COPY_GRACE) then
        edit.kitCtrlAt = nil
        self:Emit("onCopy", self)
      end
    end)
    UI.Script(self.kitEdit, "OnCursorChanged", function(edit, x, y, _, height)
      if not self.kitProps.multiline or not y then return end
      -- The client also reports a cursor that did not move, after a layout pass for one. Following those would pull
      -- the text back to the cursor while the user scrolls, to the bottom when all of it is selected.
      if x == self.kitCursorX and y == self.kitCursorY then return end
      self.kitCursorX, self.kitCursorY = x, y
      local offset = self.kitScroll:GetVerticalScroll()
      local viewH = self.kitScroll:GetHeight()
      if -y < offset then offset = -y elseif -y + height > offset + viewH then offset = -y + height - viewH end
      self.kitScroll:SetVerticalScroll(math.max(0, offset))
      self.kitBar:SetValue(offset)
    end)
    self.kitField:EnableMouse(true)
    self:kitForwardHover(self.kitField, self.kitEdit)
    UI.Script(self.kitField, "OnMouseDown", function() if not self.kitProps.disabled then self.kitEdit:SetFocus() end end)
    self.kitRepaint = repaint
  end,
  OnRelease = function(self)
    self.kitEdit:ClearFocus()
    self.kitLastCommit = nil
    self.kitCursorX, self.kitCursorY = nil, nil
    if self.kitPaste then
      self.kitPaste = nil
      UI.Script(self, "OnUpdate", nil)
    end
  end,
  Measure = function(self, availW)
    local props = self.kitProps
    local height = fieldHeight(self)
    if props.label and props.label ~= "" then height = height + LABEL_HEIGHT + Theme.Space("xs") end
    return props.width or math.min(availW, NATURAL_WIDTH), height
  end,
})
