local _, MDT = ...
local L = MDT.L
local UI = MDT.UI
local Theme, Fonts = UI.Theme, UI.Fonts

local NUMBER_WIDTH = 18
local PORTRAIT = 24
local PORTRAIT_OVERLAP = 4
local MAX_PORTRAITS = 7
---How far a portrait's count runs past its right edge.
local COUNT_OVERHANG = 3
local ROW_HEIGHT = 34
-- Pull colors are bright palette colors; mixing them toward the panel background keeps white text readable.
local TINT_MUTE = 0.5
local TINT_BACKGROUND = 0.07
local TINT_FROM, TINT_TO = 0.9, 0.18
local TOOLTIP_WIDTH, TOOLTIP_HEIGHT = 250, 180

local tooltip

---The model card shown while a pull row or one of its portraits is hovered.
local function ensureTooltip()
  if tooltip then return tooltip end
  tooltip = CreateFrame("Frame", "MDTPullTooltip", UI.Root, "TooltipBorderedFrameTemplate")
  tooltip:SetClampedToScreen(true)
  tooltip:SetFrameStrata("TOOLTIP")
  tooltip:SetSize(TOOLTIP_WIDTH, TOOLTIP_HEIGHT)
  tooltip:Hide()
  tooltip.Model = CreateFrame("PlayerModel", nil, tooltip)
  tooltip.Model:SetFrameLevel(1)
  tooltip.Model:SetSize(110, 110)
  tooltip.Model:SetPoint("TOPLEFT", tooltip, "TOPLEFT", 7, -7)
  tooltip.Model.facing = 0
  tooltip.Model:SetScript("OnUpdate", function(model)
    model.facing = (model.facing + 0.5) % 360
    model:SetFacing(math.pi * 2 / 360 * model.facing)
  end)
  tooltip.topString = tooltip:CreateFontString(nil, "ARTWORK")
  tooltip.topString:SetFontObject(Fonts.Get("small"))
  tooltip.topString:SetTextColor(1, 1, 1, 1)
  tooltip.topString:SetJustifyH("LEFT")
  tooltip.topString:SetJustifyV("TOP")
  tooltip.topString:SetSize(130, 110)
  tooltip.topString:SetPoint("TOPLEFT", tooltip, "TOPLEFT", 110, -7)
  local heading = tooltip:CreateTexture(nil, "OVERLAY")
  heading:SetHeight(8)
  heading:SetPoint("LEFT", tooltip, "LEFT", 12, -30)
  heading:SetPoint("RIGHT", tooltip, "RIGHT", -12, -30)
  heading:SetTexture("Interface\\Tooltips\\UI-Tooltip-Border")
  heading:SetTexCoord(0.81, 0.94, 0.5, 1)
  tooltip.botString = tooltip:CreateFontString(nil, "ARTWORK")
  tooltip.botString:SetFontObject(Fonts.Get("small"))
  tooltip.botString:SetTextColor(1, 1, 1, 1)
  tooltip.botString:SetJustifyH("CENTER")
  tooltip.botString:SetJustifyV("TOP")
  tooltip.botString:SetSize(TOOLTIP_WIDTH, 40)
  tooltip.botString:SetPoint("TOPLEFT", heading, "LEFT", -12, -7)
  return tooltip
end

---@class MDT.PullTooltipApi
local PullTooltip = {}
MDT.PullTooltip = PullTooltip

---@param row table
---@param item MDT.SidebarPullItem
function PullTooltip.ShowPull(row, item)
  if #item.portraits == 0 then
    PullTooltip.Hide(row)
    return
  end
  local frame = ensureTooltip()
  frame.owner = row
  frame:ClearAllPoints()
  frame:SetPoint("TOPRIGHT", row, "TOPLEFT", 0, 0)
  frame:SetPoint("BOTTOMRIGHT", row, "TOPLEFT", -TOOLTIP_WIDTH, -(4 + TOOLTIP_HEIGHT))
  local mainBottom = MDT.main_frame and MDT.main_frame:GetBottom()
  if mainBottom and frame:GetBottom() and frame:GetBottom() < mainBottom then
    frame:SetPoint("TOPRIGHT", row, "BOTTOMLEFT", 0, 4 + TOOLTIP_HEIGHT)
    frame:SetPoint("BOTTOMRIGHT", row, "BOTTOMLEFT", -TOOLTIP_WIDTH, -4)
  end
  frame.botString:SetText(L["Forces"]..": "..MDT:FormatEnemyForces(item.forces, nil, false)
    .."\n"..L["Total"]..": "..MDT:FormatEnemyForces(item.cumulative, nil, true))
  frame.topString:Hide()
  frame.Model:Hide()
  frame.modelDisplayId = nil
  frame:Show()
end

---@param row table
---@param portrait MDT.SidebarPortrait
function PullTooltip.ShowPortrait(row, portrait)
  local frame = ensureTooltip()
  if frame.owner ~= row or not frame:IsShown() then return end
  local level = MDT:GetDB().currentDifficulty
  if portrait.displayId and frame.modelDisplayId ~= portrait.displayId then
    frame.Model:SetDisplayInfo(portrait.displayId)
    frame.modelDisplayId = portrait.displayId
  end
  local health = MDT:CalculateEnemyHealth(portrait.isBoss, portrait.baseHealth or 0, level, portrait.ignoreFortified)
  local lines = {
    "", "", "",
    L[portrait.name].." x"..portrait.quantity,
    string.format(L["Level %d %s"], portrait.level or 0, L[portrait.creatureType or ""]),
    string.format(L["%s HP"], MDT:FormatEnemyHealth(health)),
    L["Forces"]..": "..MDT:FormatEnemyForces(portrait.count, nil, false),
  }
  frame.topString:SetText(table.concat(lines, "\n"))
  frame.topString:Show()
  frame.Model:SetShown(portrait.displayId ~= nil)
end

---@param row table
function PullTooltip.HidePortrait(row)
  if not tooltip or tooltip.owner ~= row then return end
  tooltip.topString:Hide()
  tooltip.Model:Hide()
end

---@param row table? hides only when this row owns the tooltip; nil hides unconditionally
function PullTooltip.Hide(row)
  if not tooltip or (row and tooltip.owner ~= row) then return end
  tooltip.owner = nil
  tooltip:Hide()
end

---@return table?
function PullTooltip.Frame() return tooltip end

local PullRow = {}

-- Portraits take no mouse input, so clicks and right-clicks always reach the row; while the row is hovered
-- this checks which portrait sits under the cursor. The first portrait draws on top, so the first hit wins.
function PullRow:kitUpdatePortraitHover()
  local item = self.kitItem
  local hit
  for i, portrait in ipairs(self.kitPortraits) do
    if portrait:IsShown() and portrait:IsMouseOver() then
      hit = i
      break
    end
  end
  if hit == self.kitHoverPortrait then return end
  self.kitHoverPortrait = hit
  if hit and item and item.portraits and item.portraits[hit] then
    PullTooltip.ShowPortrait(self, item.portraits[hit])
  else
    PullTooltip.HidePortrait(self)
  end
end

---@param watching boolean
function PullRow:kitWatchPortraits(watching)
  self.kitHoverPortrait = nil
  self.kitWatcher:SetShown(watching)
  if watching then self:kitUpdatePortraitHover() end
end

function PullRow:OnCreate()
  -- Above the row skin's background so hover and selection never hide the pull color; the skin still draws the selected border.
  self.kitTint = self:CreateTexture(nil, "BACKGROUND", nil, 1)
  self.kitTint:SetAllPoints()
  self.kitTint:SetColorTexture(1, 1, 1, 1)
  -- Marks the pull that completes the forces. A line inside the row, not a separate list row, so row index == pull index.
  self.kitComplete = self:CreateTexture(nil, "ARTWORK")
  self.kitComplete:SetPoint("BOTTOMLEFT")
  self.kitComplete:SetPoint("BOTTOMRIGHT")
  self.kitComplete:SetHeight(2)
  Theme.Bind(self.kitComplete, "ok")
  self.kitHover = self:CreateTexture(nil, "HIGHLIGHT")
  self.kitHover:SetAllPoints()
  self.kitHover:SetColorTexture(1, 1, 1, 0.08)
  self.kitNumber = self:CreateFontString(nil, "ARTWORK")
  self.kitNumber:SetFontObject(Fonts.Get("number"))
  self.kitNumber:SetShadowColor(0, 0, 0, 1)
  self.kitNumber:SetShadowOffset(1, -1)
  self.kitNumber:SetPoint("LEFT", self, "LEFT", Theme.Space("xs"), 0)
  self.kitNumber:SetWidth(NUMBER_WIDTH)
  self.kitNumber:SetJustifyH("CENTER")
  Theme.Bind(self.kitNumber, "text.normal")
  self.kitPortraits = {}
  for i = 1, MAX_PORTRAITS do
    local portrait = CreateFrame("Frame", nil, self)
    portrait:SetSize(PORTRAIT, PORTRAIT)
    if i == 1 then
      portrait:SetPoint("LEFT", self.kitNumber, "RIGHT", Theme.Space("sm"), 0)
    else
      portrait:SetPoint("LEFT", self.kitPortraits[i - 1], "RIGHT", -PORTRAIT_OVERLAP, 0)
    end
    portrait:SetFrameLevel(self:GetFrameLevel() + MAX_PORTRAITS - i + 1)
    portrait:EnableMouse(false)
    portrait.ring = portrait:CreateTexture(nil, "BACKGROUND")
    portrait.ring:SetTexture("Interface\\AddOns\\MythicDungeonTools\\Textures\\Circle_White")
    portrait.ring:SetPoint("CENTER", portrait, "CENTER", 0, 0)
    portrait.ring:SetSize(PORTRAIT + 3, PORTRAIT + 3)
    portrait.ring:SetVertexColor(0, 0, 0, 0.85)
    portrait.texture = portrait:CreateTexture(nil, "ARTWORK")
    portrait.texture:SetAllPoints()
    portrait.mask = portrait:CreateMaskTexture()
    portrait.mask:SetTexture("Interface\\CharacterFrame\\TempPortraitAlphaMask", "CLAMPTOBLACKADDITIVE", "CLAMPTOBLACKADDITIVE")
    portrait.mask:SetAllPoints(portrait.texture)
    portrait.texture:AddMaskTexture(portrait.mask)
    portrait.count = portrait:CreateFontString(nil, "OVERLAY")
    portrait.count:SetFontObject(Fonts.Get("small"))
    portrait.count:SetShadowColor(0, 0, 0, 1)
    portrait.count:SetShadowOffset(1, -1)
    portrait.count:SetPoint("BOTTOMRIGHT", portrait, "BOTTOMRIGHT", 3, -3)
    portrait.count:SetTextColor(1, 1, 1, 1)
    portrait:Hide()
    self.kitPortraits[i] = portrait
  end
  self.kitCumulative = self:CreateFontString(nil, "ARTWORK")
  self.kitCumulative:SetFontObject(Fonts.Get("heading"))
  self.kitCumulative:SetShadowColor(0, 0, 0, 1)
  self.kitCumulative:SetShadowOffset(1, -1)
  self.kitCumulative:SetPoint("TOPRIGHT", self, "TOPRIGHT", -Theme.Space("md"), -4)
  self.kitCumulative:SetWordWrap(false)
  self.kitCumulative:SetJustifyH("RIGHT")
  Theme.Bind(self.kitCumulative, "text.normal")
  self.kitPull = self:CreateFontString(nil, "ARTWORK")
  self.kitPull:SetFontObject(Fonts.Get("small"))
  self.kitPull:SetShadowColor(0, 0, 0, 1)
  self.kitPull:SetShadowOffset(1, -1)
  self.kitPull:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT", -Theme.Space("md"), 4)
  self.kitPull:SetWordWrap(false)
  self.kitPull:SetJustifyH("RIGHT")
  Theme.Bind(self.kitPull, "text.secondary")
  self.kitWatcher = CreateFrame("Frame", nil, self)
  self.kitWatcher:Hide()
  self.kitWatcher:SetScript("OnUpdate", function() self:kitUpdatePortraitHover() end)
  self:HookScript("OnDragStart", function(row)
    row:kitWatchPortraits(false)
    PullTooltip.Hide(row)
  end)
  self:HookScript("OnSizeChanged", function(row) row:kitFitPortraits() end)
end

---Shows the portraits that end before the forces and health on the right; a long health text can leave no room for
---the last ones.
function PullRow:kitFitPortraits()
  local item = self.kitItem
  if not item then return end
  local valuesWidth = math.max(self.kitCumulative:GetUnboundedStringWidth(), self.kitPull:GetUnboundedStringWidth())
  -- A row is bound before the list places it; until then it has no width, and OnSizeChanged fits it once placed.
  local width = self:GetWidth()
  local room = width > 0 and width - Theme.Space("md") - valuesWidth - Theme.Space("sm") or math.huge
  local left = Theme.Space("xs") + NUMBER_WIDTH + Theme.Space("sm")
  for i, portrait in ipairs(self.kitPortraits) do
    local right = left + i * PORTRAIT - (i - 1) * PORTRAIT_OVERLAP + COUNT_OVERHANG
    portrait:SetShown(item.portraits[i] ~= nil and right <= room)
  end
end

---@param item MDT.SidebarPullItem
function PullRow:Bind(item)
  local r, g, b = item.color[1], item.color[2], item.color[3]
  r, g, b = r * TINT_MUTE + TINT_BACKGROUND * (1 - TINT_MUTE), g * TINT_MUTE + TINT_BACKGROUND * (1 - TINT_MUTE), b * TINT_MUTE + TINT_BACKGROUND * (1 - TINT_MUTE)
  self.kitTint:SetGradient("HORIZONTAL", CreateColor(r, g, b, TINT_FROM), CreateColor(r, g, b, TINT_TO))
  self.kitNumber:SetText(item.index)
  for i, portrait in ipairs(self.kitPortraits) do
    local data = item.portraits[i]
    if data then
      if data.displayId then
        SetPortraitTextureFromCreatureDisplayID(portrait.texture, data.displayId)
      else
        portrait.texture:SetTexture("Interface\\Icons\\achievement_boss_hellfire_mannorothreanimated")
      end
      portrait.count:SetText("x"..data.quantity)
    end
  end
  self.kitComplete:SetShown(item.completes == true)
  self.kitCumulative:SetText(item.cumulativeText)
  -- The health is this pull's own, like the forces below the total, so it sits beside them.
  local pull, health = item.pullText, item.healthText
  if health then pull = pull ~= "" and pull.." · "..health or health end
  self.kitPull:SetText(pull)
  -- Sized to their text, so they never wrap into each other; the portraits make room instead.
  for _, text in ipairs({ self.kitCumulative, self.kitPull }) do text:SetWidth(math.ceil(text:GetUnboundedStringWidth())) end
  self:kitFitPortraits()
end

function PullRow:OnUnbind()
  self:kitWatchPortraits(false)
  PullTooltip.Hide(self)
end

local NewPullRow = {}

function NewPullRow:OnCreate()
  self.kitBorder = UI.Pixel.Border(self, "border.strong")
  self.kitLabel = self:CreateFontString(nil, "ARTWORK")
  self.kitLabel:SetFontObject(Fonts.Get("body"))
  self.kitLabel:SetPoint("CENTER", self, "CENTER", 0, 0)
  self.kitLabel:SetText(L["+ Add pull"])
  Theme.Bind(self.kitLabel, "accent")
end

function NewPullRow:Bind() end

---@type table<string, MDT.UI.ListKind>
MDT.SidebarRowKinds = {
  pull = { height = ROW_HEIGHT, mixin = PullRow, draggable = true, selectable = true },
  newPull = { height = "md", mixin = NewPullRow },
}
