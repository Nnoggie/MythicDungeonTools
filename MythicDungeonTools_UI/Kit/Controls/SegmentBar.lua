local _, MDT = ...
local UI = MDT.UI
local Theme, Fonts = UI.Theme, UI.Fonts

local INSET = 1
local MARKER_WIDTH = 2
local SEGMENT_ALPHA = 0.55

local function layoutSegments(self)
  local props = self.kitProps
  local innerW = self:GetWidth() - INSET * 2
  local innerH = self:GetHeight() - INSET * 2
  local max = props.max > 0 and props.max or 1
  self.kitSegmentPool:ReleaseAll()
  if innerW <= 0 then return end
  local x = 0
  for _, segment in ipairs(props.segments) do
    local w = innerW * segment.value / max
    if x >= innerW then break end
    w = math.min(w, innerW - x)
    if w > 0 then
      local texture = self.kitSegmentPool:Acquire()
      texture:ClearAllPoints()
      texture:SetPoint("TOPLEFT", self, "TOPLEFT", INSET + x, -INSET)
      texture:SetSize(w, innerH)
      Theme.Bind(texture, segment.color)
      texture:SetAlpha(SEGMENT_ALPHA)
      texture:Show()
      x = x + w
    end
  end
  if props.marker and props.marker <= max then
    self.kitMarker:ClearAllPoints()
    self.kitMarker:SetPoint("TOPLEFT", self, "TOPLEFT", INSET + innerW * props.marker / max - MARKER_WIDTH / 2, 0)
    self.kitMarker:SetSize(MARKER_WIDTH, self:GetHeight())
    self.kitMarker:Show()
  else
    self.kitMarker:Hide()
  end
end

local function repaintText(self)
  local props = self.kitProps
  self.kitText:SetText(props.text or "")
  local total = 0
  for _, segment in ipairs(props.segments) do total = total + segment.value end
  local color = "text.normal"
  if props.overflow and total > props.max then color = "warn" elseif total >= props.max and props.max > 0 then color = "ok" end
  Theme.Bind(self.kitText, color)
end

local function repaintAll(self)
  layoutSegments(self)
  repaintText(self)
end

local Methods = {}

---@param segments {value: number, color: MDT.UI.Color}[]
---@param max number?
function Methods:SetSegments(segments, max)
  self.kitProps.segments = segments
  if max then self.kitProps.max = max end
  repaintAll(self)
end

---@class MDT.UI.SegmentBarSpec : MDT.UI.CommonSpec
---@field segments {value: number, color: MDT.UI.Color}[]
---@field max number
---@field marker number? a tick at this value (the 100% line)
---@field text string? centered label
---@field overflow boolean? tint the text when the segments exceed max
UI.Define({
  name = "SegmentBar", frameType = "Frame", mixins = { Methods },
  props = {
    { name = "max", default = 1, set = repaintAll },
    { name = "segments", default = {}, set = repaintAll },
    { name = "marker", default = nil, set = layoutSegments },
    { name = "text", default = nil, set = repaintText },
    { name = "overflow", default = false, set = repaintText },
  },
  Create = function(self)
    self.kitBackground = self:CreateTexture(nil, "BACKGROUND")
    self.kitBackground:SetAllPoints()
    Theme.Bind(self.kitBackground, "bg.sunken")
    self.kitBorder = UI.Pixel.Border(self, "border.strong")
    self.kitSegmentPool = CreateTexturePool(self, "ARTWORK")
    self.kitMarker = self:CreateTexture(nil, "OVERLAY")
    Theme.Bind(self.kitMarker, "text.normal")
    self.kitText = self:CreateFontString(nil, "OVERLAY")
    self.kitText:SetFontObject(Fonts.Get("small"))
    self.kitText:SetAllPoints()
    self.kitText:SetJustifyH("CENTER")
    self.kitText:SetShadowColor(0, 0, 0, 1)
    self.kitText:SetShadowOffset(0, -1)
    self:SetScript("OnSizeChanged", function() layoutSegments(self) end)
  end,
  Measure = function(self, availW) return self.kitProps.width or availW, Theme.Size("sm") end,
})
