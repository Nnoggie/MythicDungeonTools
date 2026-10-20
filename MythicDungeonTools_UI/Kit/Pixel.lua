local _, MDT = ...
local UI = MDT.UI
local Theme = UI.Theme

---Borders exactly one physical pixel thick at any effective scale.
---@class MDT.UI.PixelApi
local Pixel = {}
UI.Pixel = Pixel

---@type table<MDT.UI.PixelBorder, true>
local registry = setmetatable({}, { __mode = "k" })

---@param frame table
---@return number size of one physical pixel in this frame's units
function Pixel.Size(frame)
  return PixelUtil.GetPixelToUIUnitFactor() / frame:GetEffectiveScale()
end

---@class MDT.UI.PixelBorder
---@field frame table
---@field textures table<string, table>
---@field token MDT.UI.Color
local Border = {}
Border.__index = Border

function Border:Refresh()
  local px = Pixel.Size(self.frame) * Theme.data.border
  for edge, texture in pairs(self.textures) do
    if edge == "top" or edge == "bottom" then texture:SetHeight(px) else texture:SetWidth(px) end
  end
end

---@param token MDT.UI.Color
function Border:SetToken(token)
  self.token = token
  for _, texture in pairs(self.textures) do Theme.Bind(texture, token) end
end

---@param shown boolean
function Border:SetShown(shown)
  for _, texture in pairs(self.textures) do texture:SetShown(shown) end
end

local anchors = {
  top = { "TOPLEFT", "TOPRIGHT" }, bottom = { "BOTTOMLEFT", "BOTTOMRIGHT" },
  left = { "TOPLEFT", "BOTTOMLEFT" }, right = { "TOPRIGHT", "BOTTOMRIGHT" },
}

---Four textures anchored to the frame's edges, so a size change needs no work; only scale changes do.
---@param frame table
---@param token MDT.UI.Color
---@param edges ("top"|"bottom"|"left"|"right")[]? default all four
---@return MDT.UI.PixelBorder
function Pixel.Border(frame, token, edges)
  local border = setmetatable({ frame = frame, textures = {}, token = token }, Border)
  for _, edge in ipairs(edges or { "top", "bottom", "left", "right" }) do
    local texture = frame:CreateTexture(nil, "BORDER")
    texture:SetSnapToPixelGrid(false)
    texture:SetTexelSnappingBias(0)
    local points = anchors[edge]
    texture:SetPoint(points[1], frame, points[1])
    texture:SetPoint(points[2], frame, points[2])
    border.textures[edge] = texture
  end
  border:SetToken(token)
  border:Refresh()
  registry[border] = true
  frame.kitPixelBorders = frame.kitPixelBorders or {}
  frame.kitPixelBorders[border] = true
  return border
end

---Re-derives every registered border's thickness from its frame's current effective scale.
function Pixel.Refresh()
  for border in pairs(registry) do border:Refresh() end
end

---@param frame table
function Pixel.RefreshFrame(frame)
  for border in pairs(frame.kitPixelBorders or {}) do border:Refresh() end
end

local events = CreateFrame("Frame")
events:RegisterEvent("UI_SCALE_CHANGED")
events:RegisterEvent("DISPLAY_SIZE_CHANGED")
events:SetScript("OnEvent", Pixel.Refresh)
