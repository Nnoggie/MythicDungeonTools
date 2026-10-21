local _, MDT = ...
local UI = MDT.UI
local Theme, Fonts, Escape = UI.Theme, UI.Fonts, UI.Escape
local L = MDT.L

local DEFAULT_WIDTH = 320
local TITLE_HEIGHT = 30
local LEVEL_BASE = 100
local LEVEL_STEP = 20

---Stackable dialogs. Escape closes the top one; a keyed dialog re-opened replaces itself; one close path, one reason.
---Opening one closes open menus and popovers (reason "replaced"), whose click catcher would otherwise cover it.
---@class MDT.UI.DialogsApi
local Dialogs = {}
UI.Dialogs = Dialogs

---@type MDT.UI.Control[]
local stack = {}
local keyed = {}
local parentProvider

---@param provider fun(): table? returns the default parent, usually the main window
function Dialogs.SetDefaultParent(provider)
  parentProvider = provider
end

local Methods = {}

---The one close path. X, Escape, buttons, CloseAll, replacement and the parent hiding all land here; onClose runs once.
---@param reason string?
function Methods:Close(reason)
  if self.kitClosing or self.kitReleased then return end
  self.kitClosing = true
  for i = #stack, 1, -1 do
    if stack[i] == self then table.remove(stack, i) end
  end
  if self.kitKey and keyed[self.kitKey] == self then keyed[self.kitKey] = nil end
  if self.kitGlobalName and _G[self.kitGlobalName] == self then _G[self.kitGlobalName] = nil end
  Escape.Remove(self.kitEscape)
  self:Hide()
  self:Emit("onClose", self, reason or "api")
  self:Release()
end

---@class MDT.UI.DialogFrameSpec : MDT.UI.CommonSpec
---@field title string?
---@field onClose fun(dialog: MDT.UI.Control, reason: string)?
---@field pinned boolean? the title bar does not drag the dialog

UI.Define({
  name = "DialogFrame", frameType = "Frame", mixins = { Methods },
  props = {
    { name = "title", default = "", set = function(self, v) self.kitTitle:SetText(v) end },
    { name = "onClose", default = nil },
    { name = "pinned", default = false },
  },
  Create = function(self)
    self:SetClampedToScreen(true)
    self:SetMovable(true)
    self:EnableMouse(true)
    self.kitBackground = self:CreateTexture(nil, "BACKGROUND")
    self.kitBackground:SetAllPoints()
    Theme.Bind(self.kitBackground, "bg.panel")
    self.kitBorder = UI.Pixel.Border(self, "border.strong")

    self.kitTitleBar = CreateFrame("Frame", nil, self)
    self.kitTitleBar:SetPoint("TOPLEFT", self, "TOPLEFT", 0, 0)
    self.kitTitleBar:SetPoint("TOPRIGHT", self, "TOPRIGHT", 0, 0)
    self.kitTitleBar:SetHeight(TITLE_HEIGHT)
    self.kitTitleBar:EnableMouse(true)
    self.kitTitleBar:RegisterForDrag("LeftButton")
    UI.Script(self.kitTitleBar, "OnDragStart", function() if not self.kitProps.pinned then self:StartMoving() end end)
    UI.Script(self.kitTitleBar, "OnDragStop", function() self:StopMovingOrSizing() end)
    local titleBackground = self.kitTitleBar:CreateTexture(nil, "BACKGROUND")
    titleBackground:SetAllPoints()
    Theme.Bind(titleBackground, "bg.sunken")
    self.kitTitleRule = UI.Pixel.Border(self.kitTitleBar, "border.divider", { "bottom" })
    self.kitTitle = self.kitTitleBar:CreateFontString(nil, "ARTWORK")
    self.kitTitle:SetFontObject(Fonts.Get("title"))
    self.kitTitle:SetPoint("LEFT", self.kitTitleBar, "LEFT", Theme.Space("lg"), 0)
    self.kitTitle:SetPoint("RIGHT", self.kitTitleBar, "RIGHT", -TITLE_HEIGHT, 0)
    self.kitTitle:SetJustifyH("LEFT")
    self.kitTitle:SetWordWrap(false)
    Theme.Bind(self.kitTitle, "text.normal")
    self.closeButton = UI.CloseButton(self.kitTitleBar, { tooltip = L["Close"], onClick = function() self:Close("x") end })
    self.closeButton:SetPoint("RIGHT", self.kitTitleBar, "RIGHT", -(TITLE_HEIGHT - 24) / 2, 0)

    -- The dialog takes its size from its content after every layout, without waiting for OnSizeChanged.
    self.content = UI.Stack(self, { padding = "lg", gap = "md", onLayout = function(content)
      self:SetSize(content:GetWidth(), TITLE_HEIGHT + content:GetHeight())
    end })
    self.content:SetPoint("TOPLEFT", self.kitTitleBar, "BOTTOMLEFT", 0, 0)
    UI.HookScript(self, "OnHide", function() self:Close("hidden") end)
  end,
  OnRelease = function(self)
    self.content:ReleaseChildren()
    self.kitClosing, self.kitKey, self.kitGlobalName, self.kitEscape = nil, nil, nil, nil
  end,
})

---@param spec MDT.UI.DialogSpec
---@return MDT.UI.Control dialog with Close(reason), `.content` and `.closeButton`
function Dialogs.Open(spec)
  UI.Overlay.PopAll("menu", "replaced")
  UI.Overlay.PopAll("popover", "replaced")
  if spec.key and keyed[spec.key] then keyed[spec.key]:Close("replaced") end
  local parent = spec.parent or (parentProvider and parentProvider()) or UI.Root
  local dialog = UI.DialogFrame(parent, { title = spec.title, onClose = spec.onClose, pinned = spec.pinned })
  UI.Overlay.SetStrata(dialog, "DIALOG")
  dialog.kitKey, dialog.kitGlobalName = spec.key, spec.globalName
  if spec.key then keyed[spec.key] = dialog end
  if spec.globalName then _G[spec.globalName] = dialog end
  UI.Overlay.SetPlace(dialog, spec.place or { point = "CENTER", relativeTo = parent, y = 50 })
  dialog.content:SetWidth(spec.width or DEFAULT_WIDTH)
  dialog.content:Batch(function()
    if spec.build then spec.build(dialog.content, dialog) end
  end)
  dialog:SetSize(dialog.content:GetWidth(), TITLE_HEIGHT + dialog.content:GetHeight())
  stack[#stack + 1] = dialog
  dialog:SetFrameLevel(LEVEL_BASE + LEVEL_STEP * #stack)
  dialog.kitEscape = { close = function() dialog:Close("escape") end }
  Escape.Push(dialog.kitEscape)
  dialog:Show()
  return dialog
end

local function footer(content, dialog, spec, onConfirm)
  local row = UI.Row(content, { gap = "sm", align = "end" })
  local confirmButton = UI.Button(row, {
    id = "confirm", text = spec.confirm.text, variant = spec.confirm.variant or "primary",
    onClick = function() if onConfirm() ~= false then dialog:Close("confirm") end end,
  })
  if spec.alt then UI.Button(row, { id = "alt", text = spec.alt.text, onClick = function() dialog:Close("alt") end }) end
  UI.Button(row, { id = "cancel", text = spec.cancel and spec.cancel.text or L["Cancel"], onClick = function() dialog:Close("cancel") end })
  return confirmButton
end

local function dispatch(spec, reason, ...)
  if reason == "confirm" then
    spec.confirm.onClick(...)
  elseif reason == "alt" then
    spec.alt.onClick(...)
  elseif reason ~= "hidden" and spec.cancel and spec.cancel.onClick then
    spec.cancel.onClick()
  end
end

---@param spec MDT.UI.ConfirmSpec
---@return MDT.UI.Control
function Dialogs.Confirm(spec)
  local checked = spec.checkbox and spec.checkbox.value or nil
  return Dialogs.Open({
    key = spec.key, title = spec.title, width = spec.width, parent = spec.parent, globalName = spec.globalName,
    build = function(content, dialog)
      UI.Text(content, { text = spec.text })
      if spec.checkbox then
        UI.Checkbox(content, { label = spec.checkbox.text, value = checked, onChange = function(value)
          checked = value
          if spec.checkbox.onChange then spec.checkbox.onChange(value) end
        end })
      end
      footer(content, dialog, spec, function() end)
    end,
    onClose = function(dialog, reason)
      if spec.onClose then spec.onClose(dialog, reason) end
      dispatch(spec, reason, checked)
    end,
  })
end

---@param spec MDT.UI.PromptSpec
---@return MDT.UI.Control
function Dialogs.Prompt(spec)
  local text, checked = spec.value or "", spec.checkbox and spec.checkbox.value or nil
  local valid = true
  return Dialogs.Open({
    key = spec.key, title = spec.title, width = spec.width, parent = spec.parent, globalName = spec.globalName,
    build = function(content, dialog)
      local confirmButton, problem
      local function validate()
        local ok, message = true, nil
        if spec.validate then ok, message = spec.validate(text) end
        valid = ok and true or false
        confirmButton:SetDisabled(not valid)
        problem:SetText(message or "")
        problem:SetHidden(valid or not message)
      end
      UI.EditBox(content, {
        id = "input", label = spec.label, value = text, placeholder = spec.placeholder, multiline = spec.multiline, lines = spec.lines,
        readOnly = spec.readOnly, maxLetters = spec.maxLetters, autoFocus = not spec.readOnly, selectAllOnFocus = true,
        onChange = function(value)
          text = value
          validate()
        end,
        onCommit = function(value, _, source)
          text = value
          validate()
          if source == "enter" and valid then dialog:Close("confirm") end
        end,
        onEscape = function() dialog:Close("escape") end,
      })
      problem = UI.Text(content, { text = "", color = "warn", hidden = true })
      if spec.build then spec.build(content, dialog) end
      if spec.checkbox then
        UI.Checkbox(content, { label = spec.checkbox.text, value = checked, onChange = function(value) checked = value end })
      end
      confirmButton = footer(content, dialog, spec, function() return valid end)
      validate()
    end,
    onClose = function(dialog, reason)
      if spec.onClose then spec.onClose(dialog, reason) end
      dispatch(spec, reason, text, checked)
    end,
  })
end

---@param reason string?
---@param keep table<string, boolean>? keys of dialogs to leave open
function Dialogs.CloseAll(reason, keep)
  for i = #stack, 1, -1 do
    local dialog = stack[i]
    if dialog and not (keep and dialog.kitKey and keep[dialog.kitKey]) then dialog:Close(reason or "api") end
  end
end

---@return MDT.UI.Control?
function Dialogs.Top() return stack[#stack] end

---@param key string
---@return MDT.UI.Control?
function Dialogs.Get(key) return keyed[key] end

---@return integer
function Dialogs.Count() return #stack end
