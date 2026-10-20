local _, MDT = ...
local UI = MDT.UI
local Theme = UI.Theme

---Text tooltips go through GameTooltip; rich content gets a kit card built by the caller.
---@class MDT.UI.TooltipApi
local Tooltip = {}
UI.Tooltip = Tooltip

local card, cardOwner

local function ensureCard()
  if card then return card end
  card = CreateFrame("Frame", nil, UIParent)
  card:SetFrameStrata("TOOLTIP")
  card:SetClampedToScreen(true)
  card:Hide()
  card.kitBackground = card:CreateTexture(nil, "BACKGROUND")
  card.kitBackground:SetAllPoints()
  Theme.Bind(card.kitBackground, "bg.overlay")
  card.kitBorder = UI.Pixel.Border(card, "border.strong")
  card.content = UI.Stack(card, { padding = "md", gap = "sm" })
  card.content:SetPoint("TOPLEFT", card, "TOPLEFT", 0, 0)
  card.content:HookScript("OnSizeChanged", function(content) card:SetSize(content:GetWidth(), content:GetHeight()) end)
  return card
end

---@param owner table
---@param content string|fun(tooltip: table): string?|{build: fun(content: MDT.UI.Control), width: number?}
function Tooltip.Show(owner, content)
  if type(content) == "table" then
    local frame = ensureCard()
    frame.content:ReleaseChildren()
    frame:ClearAllPoints()
    frame:SetPoint("BOTTOMLEFT", owner, "TOPRIGHT", 0, 0)
    frame.content:SetWidth(content.width or 240)
    frame.content:Batch(function() content.build(frame.content) end)
    frame:SetSize(frame.content:GetWidth(), frame.content:GetHeight())
    frame:Show()
    cardOwner = owner
    return
  end
  GameTooltip:SetOwner(owner, "ANCHOR_RIGHT")
  if type(content) == "function" then
    local text = content(GameTooltip)
    if type(text) == "string" then GameTooltip:SetText(text, 1, 1, 1, 1, true) end
  else
    GameTooltip:SetText(content, 1, 1, 1, 1, true)
  end
  GameTooltip:Show()
end

---@param owner table
function Tooltip.Hide(owner)
  if cardOwner == owner and card then
    card:Hide()
    card.content:ReleaseChildren()
    cardOwner = nil
  end
  if GameTooltip:IsOwned(owner) then GameTooltip:Hide() end
end
