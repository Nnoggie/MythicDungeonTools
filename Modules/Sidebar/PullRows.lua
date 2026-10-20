local _, MDT = ...
local L = MDT.L
local UI = MDT.UI
local Theme, Fonts = UI.Theme, UI.Fonts

local STRIPE = 3
local NUMBER_WIDTH = 16
local PORTRAIT = 20
local PORTRAIT_OVERLAP = 3
local MAX_PORTRAITS = 7
local VALUE_WIDTH = 60
local TINT_ALPHA = 0.15
local TOOLTIP_WIDTH, TOOLTIP_HEIGHT = 250, 180

local tooltip

---The model card shown while a pull row or one of its portraits is hovered.
local function ensureTooltip()
  if tooltip then return tooltip end
  tooltip = CreateFrame("Frame", "MDTPullTooltip", UIParent, "TooltipBorderedFrameTemplate")
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
  tooltip.topString:SetFontObject(GameFontNormalSmall)
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
  tooltip.botString:SetFontObject(GameFontNormalSmall)
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

local function portraitEnter(portrait)
  local row = portrait.kitRow
  local item = row.kitItem
  if not item or not item.portraits or not item.portraits[portrait.kitIndex] then return end
  PullTooltip.ShowPortrait(row, item.portraits[portrait.kitIndex])
end

local function portraitLeave(portrait)
  PullTooltip.HidePortrait(portrait.kitRow)
end

local PullRow = {}

function PullRow:OnCreate()
  self.kitTint = self:CreateTexture(nil, "BACKGROUND", nil, -1)
  self.kitTint:SetAllPoints()
  self.kitStripe = self:CreateTexture(nil, "ARTWORK")
  self.kitStripe:SetPoint("TOPLEFT", self, "TOPLEFT", 0, 0)
  self.kitStripe:SetPoint("BOTTOMLEFT", self, "BOTTOMLEFT", 0, 0)
  self.kitStripe:SetWidth(STRIPE)
  self.kitNumber = self:CreateFontString(nil, "ARTWORK")
  self.kitNumber:SetFontObject(Fonts.Get("number"))
  self.kitNumber:SetPoint("LEFT", self, "LEFT", STRIPE + Theme.Space("sm"), 0)
  self.kitNumber:SetWidth(NUMBER_WIDTH)
  self.kitNumber:SetJustifyH("CENTER")
  Theme.Bind(self.kitNumber, "text.secondary")
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
    portrait.kitRow, portrait.kitIndex = self, i
    portrait:SetMouseClickEnabled(false)
    portrait:SetMouseMotionEnabled(true)
    portrait:SetPropagateMouseMotion(true)
    portrait:SetScript("OnEnter", portraitEnter)
    portrait:SetScript("OnLeave", portraitLeave)
    portrait.ring = portrait:CreateTexture(nil, "BACKGROUND")
    portrait.ring:SetTexture("Interface\\AddOns\\MythicDungeonTools\\Textures\\Circle_White")
    portrait.ring:SetPoint("CENTER", portrait, "CENTER", 0, 0)
    portrait.ring:SetSize(PORTRAIT + 3, PORTRAIT + 3)
    Theme.Bind(portrait.ring, "bg.panel")
    portrait.texture = portrait:CreateTexture(nil, "ARTWORK")
    portrait.texture:SetAllPoints()
    portrait.mask = portrait:CreateMaskTexture()
    portrait.mask:SetTexture("Interface\\CharacterFrame\\TempPortraitAlphaMask", "CLAMPTOBLACKADDITIVE", "CLAMPTOBLACKADDITIVE")
    portrait.mask:SetAllPoints(portrait.texture)
    portrait.texture:AddMaskTexture(portrait.mask)
    portrait.count = portrait:CreateFontString(nil, "OVERLAY")
    portrait.count:SetFontObject(Fonts.Get("small"))
    portrait.count:SetPoint("BOTTOM", portrait, "BOTTOM", 0, -3)
    portrait.count:SetShadowColor(0, 0, 0, 1)
    portrait.count:SetShadowOffset(0, -1)
    portrait.count:SetTextColor(1, 1, 1, 1)
    portrait:Hide()
    self.kitPortraits[i] = portrait
  end
  self.kitBoss = CreateFrame("Frame", nil, self)
  self.kitBoss:SetHeight(13)
  self.kitBossBackground = self.kitBoss:CreateTexture(nil, "BACKGROUND")
  self.kitBossBackground:SetAllPoints()
  Theme.Bind(self.kitBossBackground, "accent")
  self.kitBossText = self.kitBoss:CreateFontString(nil, "ARTWORK")
  self.kitBossText:SetFontObject(Fonts.Get("small"))
  self.kitBossText:SetPoint("CENTER", self.kitBoss, "CENTER", 0, 0)
  self.kitBossText:SetText(string.upper(L["Boss"]))
  Theme.Bind(self.kitBossText, "text.inverse")
  self.kitBoss:SetWidth(self.kitBossText:GetStringWidth() + Theme.Space("sm") * 2)
  self.kitPull = self:CreateFontString(nil, "ARTWORK")
  self.kitPull:SetFontObject(Fonts.Get("number"))
  self.kitPull:SetPoint("TOPRIGHT", self, "TOPRIGHT", -Theme.Space("sm"), -3)
  self.kitPull:SetWidth(VALUE_WIDTH)
  self.kitPull:SetJustifyH("RIGHT")
  Theme.Bind(self.kitPull, "text.normal")
  self.kitCumulative = self:CreateFontString(nil, "ARTWORK")
  self.kitCumulative:SetFontObject(Fonts.Get("small"))
  self.kitCumulative:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT", -Theme.Space("sm"), 3)
  self.kitCumulative:SetWidth(VALUE_WIDTH)
  self.kitCumulative:SetJustifyH("RIGHT")
  Theme.Bind(self.kitCumulative, "text.muted")
  self:HookScript("OnDragStart", function(row) PullTooltip.Hide(row) end)
end

---@param item MDT.SidebarPullItem
function PullRow:Bind(item)
  local r, g, b = item.color[1], item.color[2], item.color[3]
  self.kitTint:SetColorTexture(r, g, b, TINT_ALPHA)
  self.kitStripe:SetColorTexture(r, g, b, 1)
  self.kitNumber:SetText(item.index)
  local last = self.kitNumber
  for i, portrait in ipairs(self.kitPortraits) do
    local data = item.portraits[i]
    if data then
      if data.displayId then
        SetPortraitTextureFromCreatureDisplayID(portrait.texture, data.displayId)
      else
        portrait.texture:SetTexture("Interface\\Icons\\achievement_boss_hellfire_mannorothreanimated")
      end
      portrait.count:SetText("x"..data.quantity)
      portrait:Show()
      last = portrait
    else
      portrait:Hide()
    end
  end
  self.kitBoss:ClearAllPoints()
  self.kitBoss:SetPoint("LEFT", last, "RIGHT", Theme.Space("md"), 0)
  self.kitBoss:SetShown(item.isBoss)
  self.kitPull:SetText(item.pullText)
  local cumulative = item.cumulativeText
  if item.healthText then cumulative = cumulative.." · "..item.healthText end
  self.kitCumulative:SetText(cumulative)
end

function PullRow:OnUnbind()
  PullTooltip.Hide(self)
end

local DividerRow = {}

function DividerRow:OnCreate()
  self.kitLabel = self:CreateFontString(nil, "ARTWORK")
  self.kitLabel:SetFontObject(Fonts.Get("small"))
  self.kitLabel:SetPoint("CENTER", self, "CENTER", Theme.Space("sm"), 0)
  self.kitLabel:SetText(string.upper(L["Forces complete"]))
  Theme.Bind(self.kitLabel, "ok")
  self.kitCheck = UI.Glyphs.Create(self, "check", 8, "ok")
  self.kitCheck:SetPoint("RIGHT", self.kitLabel, "LEFT", -Theme.Space("xs"), 0)
  self.kitLeft = self:CreateTexture(nil, "ARTWORK")
  self.kitLeft:SetHeight(1)
  self.kitLeft:SetPoint("LEFT", self, "LEFT", Theme.Space("md"), 0)
  self.kitLeft:SetPoint("RIGHT", self.kitCheck, "LEFT", -Theme.Space("sm"), 0)
  Theme.Bind(self.kitLeft, "ok.line")
  self.kitRight = self:CreateTexture(nil, "ARTWORK")
  self.kitRight:SetHeight(1)
  self.kitRight:SetPoint("LEFT", self.kitLabel, "RIGHT", Theme.Space("sm"), 0)
  self.kitRight:SetPoint("RIGHT", self, "RIGHT", -Theme.Space("md"), 0)
  Theme.Bind(self.kitRight, "ok.line")
end

function DividerRow:Bind() end

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
  pull = { height = "row", mixin = PullRow, draggable = true, selectable = true },
  divider = { height = 20, mixin = DividerRow, static = true },
  newPull = { height = "md", mixin = NewPullRow },
}
