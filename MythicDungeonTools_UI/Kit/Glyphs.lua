local _, MDT = ...
local UI = MDT.UI
local Theme = UI.Theme

---Small vector glyphs (chevrons, check, cross, plus) drawn from lines, so the kit ships no icon textures.
---@class MDT.UI.GlyphsApi
local Glyphs = {}
UI.Glyphs = Glyphs

---Unit-square line segments {x1, y1, x2, y2}, scaled by the glyph size.
local shapes = {
  down = { { -0.5, 0.25, 0, -0.25 }, { 0, -0.25, 0.5, 0.25 } },
  up = { { -0.5, -0.25, 0, 0.25 }, { 0, 0.25, 0.5, -0.25 } },
  left = { { 0.25, 0.5, -0.25, 0 }, { -0.25, 0, 0.25, -0.5 } },
  right = { { -0.25, 0.5, 0.25, 0 }, { 0.25, 0, -0.25, -0.5 } },
  check = { { -0.5, 0.05, -0.15, -0.35 }, { -0.15, -0.35, 0.5, 0.4 } },
  cross = { { -0.4, 0.4, 0.4, -0.4 }, { -0.4, -0.4, 0.4, 0.4 } },
  plus = { { -0.5, 0, 0.5, 0 }, { 0, -0.5, 0, 0.5 } },
  minus = { { -0.5, 0, 0.5, 0 } },
}

---@class MDT.UI.Glyph : MDT.UI.Control
local Glyph = {}

---@param shape "down"|"up"|"left"|"right"|"check"|"cross"|"plus"|"minus"
function Glyph:SetShape(shape)
  local segments = shapes[shape] or error("Glyphs: unknown shape "..tostring(shape), 2)
  self.kitShape = shape
  local size = self:GetWidth()
  for i, segment in ipairs(segments) do
    local line = self.kitLines[i]
    if not line then
      line = self:CreateLine(nil, "ARTWORK")
      self.kitLines[i] = line
      if self.kitToken then Theme.Bind(line, self.kitToken) end
    end
    line:SetStartPoint("CENTER", self, segment[1] * size, segment[2] * size)
    line:SetEndPoint("CENTER", self, segment[3] * size, segment[4] * size)
    line:SetThickness(UI.Pixel.Size(self) * 1.5)
    line:Show()
  end
  for i = #segments + 1, #self.kitLines do self.kitLines[i]:Hide() end
end

function Glyph:Refresh()
  if self.kitShape then self:SetShape(self.kitShape) end
end

---@param token MDT.UI.Color
function Glyph:SetColor(token)
  self.kitToken = token
  for _, line in ipairs(self.kitLines) do Theme.Bind(line, token) end
end

---@param size number
function Glyph:SetGlyphSize(size)
  self:SetSize(size, size)
  if self.kitShape then self:SetShape(self.kitShape) end
end

---@param parent table
---@param shape string
---@param size number
---@param token MDT.UI.Color
---@return MDT.UI.Glyph
function Glyphs.Create(parent, shape, size, token)
  local frame = CreateFrame("Frame", nil, parent)
  Mixin(frame, Glyph)
  frame.kitLines = {}
  frame:SetSize(size, size)
  frame:SetColor(token)
  frame:SetShape(shape)
  UI.Pixel.Track(frame)
  return frame
end
