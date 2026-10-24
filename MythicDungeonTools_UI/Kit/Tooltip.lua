local _, MDT = ...
local UI = MDT.UI
local Theme = UI.Theme

---Text tooltips go through MDT's own GameTooltip; rich content gets a kit card built by the caller.
---@class MDT.UI.TooltipApi
local Tooltip = {}
UI.Tooltip = Tooltip

---MDT's tooltip: a GameTooltip of its own on the UI root, so it has the root's scale like the rest of MDT
---instead of following the user's UI scale. It has the whole GameTooltip API; every MDT tooltip uses it.
local frame = CreateFrame("GameTooltip", "MDTTooltip", UI.Root, "GameTooltipTemplate")
-- The tooltip template ignores its parent's scale; MDT's tooltip takes the root's.
local function useRootScale(tooltip)
  tooltip:SetIgnoreParentScale(false)
  tooltip:SetScale(1)
end
useRootScale(frame)
frame:SetFrameStrata("TOOLTIP")
frame:SetClampedToScreen(true)
Tooltip.Frame = frame

---Lines get MDT's font, keeping the colors the tooltip gave them.
local function applyFonts(tooltip)
  for i = 1, tooltip:NumLines() do
    for _, side in ipairs({ "Left", "Right" }) do
      local line = _G["MDTTooltipText"..side..i]
      if line then
        local r, g, b, a = line:GetTextColor()
        line:SetFontObject(UI.Fonts.Get(i == 1 and "heading" or "body"))
        line:SetTextColor(r, g, b, a)
      end
    end
  end
end
-- Above MDT's other TOOLTIP-strata frames, such as the enemy hover card whose icons own these tooltips.
local FRAME_LEVEL = 100
local show = frame.Show
function frame:Show()
  useRootScale(self)
  applyFonts(self)
  self:SetFrameLevel(FRAME_LEVEL)
  show(self)
end

local card, cardOwner

local function ensureCard()
  if card then return card end
  card = CreateFrame("Frame", nil, UI.Root)
  card:SetFrameStrata("TOOLTIP")
  card:SetClampedToScreen(true)
  card:Hide()
  card.kitBackground = card:CreateTexture(nil, "BACKGROUND")
  card.kitBackground:SetAllPoints()
  Theme.Bind(card.kitBackground, "bg.overlay")
  card.kitBorder = UI.Pixel.Border(card, "border.strong")
  card.content = UI.Stack(card, { padding = "md", gap = "sm" })
  card.content:SetPoint("TOPLEFT", card, "TOPLEFT", 0, 0)
  UI.HookScript(card.content, "OnSizeChanged", function(content) card:SetSize(content:GetWidth(), content:GetHeight()) end)
  return card
end

---@param owner table
---@param content string|fun(tooltip: table): string?|{build: fun(content: MDT.UI.Control), width: number?}
function Tooltip.Show(owner, content)
  if type(content) == "table" then
    local cardFrame = ensureCard()
    cardFrame.content:ReleaseChildren()
    cardFrame:ClearAllPoints()
    cardFrame:SetPoint("BOTTOMLEFT", owner, "TOPRIGHT", 0, 0)
    cardFrame.content:SetWidth(content.width or 240)
    cardFrame.content:Batch(function() content.build(cardFrame.content) end)
    cardFrame:SetSize(cardFrame.content:GetWidth(), cardFrame.content:GetHeight())
    cardFrame:Show()
    cardOwner = owner
    return
  end
  frame:SetOwner(owner, "ANCHOR_RIGHT")
  if type(content) == "function" then
    local text = content(frame)
    if type(text) == "string" then frame:SetText(text, 1, 1, 1, 1, true) end
  else
    frame:SetText(content, 1, 1, 1, 1, true)
  end
  frame:Show()
end

---@param owner table
function Tooltip.Hide(owner)
  if cardOwner == owner and card then
    card:Hide()
    card.content:ReleaseChildren()
    cardOwner = nil
  end
  if frame:IsOwned(owner) then frame:Hide() end
end
