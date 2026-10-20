local _, MDT = ...
local UI = MDT.UI
local Theme, Overlay = UI.Theme, UI.Overlay

local DEFAULT_WIDTH = 240

local Methods = {}

---@param reason string?
function Methods:Close(reason)
  if self.kitEntry then Overlay.Pop(self.kitEntry, reason or "api") end
end

---@class MDT.UI.PopoverFrameSpec : MDT.UI.CommonSpec
---@field onClose fun(reason: string)?

---The floating surface behind popovers and menus. Opened through UI.Popover or UI.Menu, never constructed directly.
UI.Define({
  name = "PopoverFrame", frameType = "Frame", mixins = { Methods },
  props = {
    { name = "onClose", default = nil },
    { name = "padding", default = "md", set = function(self, v) self.content:SetPadding(v) end },
    { name = "gap", default = "sm", set = function(self, v) self.content:SetGap(v) end },
  },
  Create = function(self)
    self:SetClampedToScreen(true)
    self.kitBackground = self:CreateTexture(nil, "BACKGROUND")
    self.kitBackground:SetAllPoints()
    Theme.Bind(self.kitBackground, "bg.overlay")
    self.kitBorder = UI.Pixel.Border(self, "border.strong")
    self.content = UI.Stack(self, {})
    self.content:SetPoint("TOPLEFT", self, "TOPLEFT", 0, 0)
    UI.HookScript(self.content, "OnSizeChanged", function(content)
      self:SetSize(content:GetWidth(), content:GetHeight())
    end)
  end,
  OnRelease = function(self)
    self.content:ReleaseChildren()
    self.kitEntry = nil
  end,
})

---@class MDT.UI.PopoverSpec
---@field anchor table the popover opens beside it, flipping to stay on screen
---@field prefer "below"|"above"|"right"|"left"?
---@field width number? default 240
---@field padding MDT.UI.Space|number?
---@field gap MDT.UI.Space|number?
---@field build fun(content: MDT.UI.Control, popover: MDT.UI.Control)
---@field onClose fun(reason: string)?

---Opens caller-built content anchored to a frame. Opening a popover closes any open popover or menu.
---@param spec MDT.UI.PopoverSpec
---@return MDT.UI.Control popover with Close(reason) and `.content`
function UI.Popover(spec)
  local popover = UI.PopoverFrame(UI.Root, { onClose = spec.onClose, padding = spec.padding, gap = spec.gap })
  popover:SetPoint("TOPLEFT", UI.Root, "TOPLEFT", 0, 0)
  popover.content:SetWidth(spec.width or DEFAULT_WIDTH)
  popover.content:Batch(function() spec.build(popover.content, popover) end)
  popover:SetSize(popover.content:GetWidth(), popover.content:GetHeight())
  popover.kitEntry = {
    frame = popover, kind = "popover",
    onDismiss = function(reason)
      popover:Emit("onClose", reason)
      popover:Release()
    end,
  }
  Overlay.Push(popover.kitEntry)
  Overlay.Place(popover, spec.anchor, spec.prefer or "below", Theme.Space("xs"))
  popover:Show()
  return popover
end
