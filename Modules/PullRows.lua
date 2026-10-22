local _, MDT = ...
local L = MDT.L
local UI = MDT.UI
local Theme, Fonts = UI.Theme, UI.Fonts

---The ring enemies wear on the map (texture_Background in DungeonEnemies.xml), and the share of it their face fills.
---Enemy portraits elsewhere, in the pull rows and the pull card, wear it too.
MDT.EnemyRing = {
  texture = "Interface\\AddOns\\MythicDungeonTools\\Textures\\UI-EncounterJournalTextures",
  coords = { 0.85, 0.97, 0.43, 0.4865 },
  face = 15 / 20,
}

local NUMBER_WIDTH = 18
local PORTRAIT = 27
---The ring reaches a little past the portrait's slot, so the face inside stays near the slot's size.
local PORTRAIT_RING = PORTRAIT + 4
local PORTRAIT_OVERLAP = 4
local MAX_PORTRAITS = 7
---How far a portrait's count runs past its right edge.
local COUNT_OVERHANG = 3
local ROW_HEIGHT = 34
-- Pull colors are bright palette colors; mixing them toward the panel background keeps white text readable.
local TINT_MUTE = 0.5
local TINT_BACKGROUND = 0.07
local TINT_FROM, TINT_TO = 0.9, 0.18

---Places a card beside a pull row, as the pull list's tooltips go: its top right at the row's top left, or its bottom
---right at the row's bottom left when it would leave the window below.
---@param frame table
---@param row table
function MDT:PlaceBesidePullRow(frame, row)
  frame:ClearAllPoints()
  frame:SetPoint("TOPRIGHT", row, "TOPLEFT", 0, 0)
  local main = MDT.main_frame
  if main and frame:GetBottom() and frame:GetBottom() < main:GetBottom() then
    frame:ClearAllPoints()
    frame:SetPoint("BOTTOMRIGHT", row, "BOTTOMLEFT", 0, 0)
  end
end

local PullRow = {}

-- Portraits take no mouse input, so clicks and right-clicks always reach the row; while the row is hovered
-- this checks which portrait sits under the cursor. The first portrait draws on top, so the first hit wins. A hovered
-- portrait shows its enemy's card; the rest of the row shows the pull's.
function PullRow:kitUpdatePortraitHover()
  local item = self.kitItem
  local hit
  for i, portrait in ipairs(self.kitPortraits) do
    if portrait:IsShown() and portrait:IsMouseOver() then
      hit = i
      break
    end
  end
  -- Ctrl holds an open enemy card, as on the map: the row leaves it to the card until Ctrl is let go.
  if IsControlKeyDown() and MDT:IsEnemyHoverCardShown() then
    self.kitHeldByCtrl = true
    return
  end
  if hit == self.kitHoverPortrait and not self.kitHeldByCtrl then return end
  self.kitHeldByCtrl = nil
  self.kitHoverPortrait = hit
  if hit and item and item.portraits and item.portraits[hit] then
    MDT:HidePullCardBesideRow()
    MDT:ShowEnemyCardBesideRow(self.kitPortraits[hit], item.portraits[hit], self)
  elseif item then
    MDT:HideEnemyHoverCard()
    MDT:ShowPullCardBesideRow(self, item)
  end
end

---@param watching boolean
function PullRow:kitWatchPortraits(watching)
  self.kitHoverPortrait, self.kitHeldByCtrl = nil, nil
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
    -- The enemy's ring from the map, over its face; the count stays above both.
    portrait.ring = portrait:CreateTexture(nil, "ARTWORK", nil, 1)
    portrait.ring:SetTexture(MDT.EnemyRing.texture)
    portrait.ring:SetTexCoord(unpack(MDT.EnemyRing.coords))
    portrait.ring:SetPoint("CENTER", portrait, "CENTER", 0, 0)
    portrait.ring:SetSize(PORTRAIT_RING, PORTRAIT_RING)
    portrait.texture = portrait:CreateTexture(nil, "ARTWORK")
    portrait.texture:SetPoint("CENTER", portrait, "CENTER", 0, 0)
    portrait.texture:SetSize(PORTRAIT_RING * MDT.EnemyRing.face, PORTRAIT_RING * MDT.EnemyRing.face)
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
    MDT:HidePullListCards(row)
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
  MDT:HidePullListCards(self)
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
