local _, MDT = ...
local L = MDT.L
local UI = MDT.UI
local Theme, Fonts = UI.Theme, UI.Fonts

local ROW_HEIGHT = 22
local ACTION_SIZE = 18
local ACTIONS = { "rename", "duplicate", "export", "delete" }
local ACTION_ICONS = { rename = "rename", duplicate = "copy", export = "export", delete = "delete" }
local ACTION_TOOLTIPS = { rename = "Rename", duplicate = "Duplicate", export = "Export", delete = "Delete" }

---A row of the route list: class-colored author / name on the left, pulls and level on the right.
---Hovering the row swaps the details for the route's actions.
local RouteRow = {}

---@param shown boolean
function RouteRow:kitShowActions(shown)
  local item = self.kitItem
  for _, action in ipairs(ACTIONS) do
    local button = self.kitActions[action]
    button:SetShown(shown and not (action == "delete" and item and item.idx == 1))
  end
  self.kitDetail:SetShown(not shown)
end

function RouteRow:OnCreate()
  local pad = Theme.Space("md")
  self.kitCurrent = self:CreateTexture(nil, "BACKGROUND", nil, 1)
  self.kitCurrent:SetAllPoints()
  Theme.Bind(self.kitCurrent, "accent.bg")
  self.kitMarker = self:CreateTexture(nil, "ARTWORK")
  self.kitMarker:SetPoint("TOPLEFT")
  self.kitMarker:SetPoint("BOTTOMLEFT")
  self.kitMarker:SetWidth(2)
  Theme.Bind(self.kitMarker, "accent")

  self.kitActions = {}
  local previous
  for i = #ACTIONS, 1, -1 do
    local action = ACTIONS[i]
    local button = UI.Button(self, {
      variant = "ghost", icon = MDT:GetIconPath(ACTION_ICONS[action]), iconSize = 12, width = ACTION_SIZE, height = ACTION_SIZE,
      iconColor = action == "delete" and "warn" or nil,
      tooltip = action == "delete" and L["Delete"].."\n"..L["Shift-Click to delete all presets for this dungeon"] or L[ACTION_TOOLTIPS[action]],
      onClick = function()
        if self.kitItem then MDT:RunRouteAction(action, self.kitItem.idx) end
      end,
    })
    if previous then
      button:SetPoint("RIGHT", previous, "LEFT", -1, 0)
    else
      button:SetPoint("RIGHT", self, "RIGHT", -Theme.Space("sm"), 0)
    end
    button:HookScript("OnLeave", function()
      if not self:IsMouseOver() then self:kitShowActions(false) end
    end)
    button:Hide()
    self.kitActions[action] = button
    previous = button
  end

  self.kitDetail = self:CreateFontString(nil, "ARTWORK")
  self.kitDetail:SetFontObject(Fonts.Get("small"))
  self.kitDetail:SetPoint("RIGHT", self, "RIGHT", -pad, 0)
  self.kitDetail:SetJustifyH("RIGHT")
  self.kitDetail:SetWordWrap(false)
  Theme.Bind(self.kitDetail, "text.muted")

  self.kitAuthor = self:CreateFontString(nil, "ARTWORK")
  self.kitAuthor:SetFontObject(Fonts.Get("body"))
  self.kitAuthor:SetPoint("LEFT", self, "LEFT", pad, 0)
  self.kitAuthor:SetWordWrap(false)
  self.kitSlash = self:CreateFontString(nil, "ARTWORK")
  self.kitSlash:SetFontObject(Fonts.Get("body"))
  self.kitSlash:SetPoint("LEFT", self.kitAuthor, "RIGHT", Theme.Space("xs"), 0)
  self.kitSlash:SetText("/")
  Theme.Bind(self.kitSlash, "text.muted")
  self.kitName = self:CreateFontString(nil, "ARTWORK")
  self.kitName:SetFontObject(Fonts.Get("body"))
  self.kitName:SetJustifyH("LEFT")
  self.kitName:SetWordWrap(false)
  self.kitLive = self:CreateFontString(nil, "ARTWORK")
  self.kitLive:SetFontObject(Fonts.Get("small"))
  self.kitLive:SetText(string.upper(L["Live"]))
  Theme.Bind(self.kitLive, "live")
end

---@param item MDT.SidebarRouteItem
function RouteRow:Bind(item)
  local hasAuthor = item.author ~= nil and item.author ~= ""
  self.kitAuthor:SetShown(hasAuthor)
  self.kitSlash:SetShown(hasAuthor)
  if hasAuthor then
    Fonts.SetUserText(self.kitAuthor, item.author, "body")
    Theme.Bind(self.kitAuthor, item.authorColor or "text.secondary")
  end
  Fonts.SetUserText(self.kitName, item.name, "body")
  Theme.Bind(self.kitName, item.isCurrent and "text.normal" or "text.secondary")
  self.kitName:ClearAllPoints()
  if hasAuthor then
    self.kitName:SetPoint("LEFT", self.kitSlash, "RIGHT", Theme.Space("xs"), 0)
  else
    self.kitName:SetPoint("LEFT", self, "LEFT", Theme.Space("md"), 0)
  end
  self.kitDetail:SetText(item.detail)
  self.kitLive:ClearAllPoints()
  self.kitLive:SetPoint("RIGHT", self.kitDetail, "LEFT", -Theme.Space("sm"), 0)
  self.kitLive:SetShown(item.isLive)
  self.kitName:SetPoint("RIGHT", item.isLive and self.kitLive or self.kitDetail, "LEFT", -Theme.Space("sm"), 0)
  self.kitCurrent:SetShown(item.isCurrent)
  self.kitMarker:SetShown(item.isCurrent)
  self:kitShowActions(false)
end

function RouteRow:OnUnbind()
  self:kitShowActions(false)
end

---@type table<string, MDT.UI.ListKind>
MDT.RouteListKinds = {
  route = { height = ROW_HEIGHT, mixin = RouteRow },
}

MDT.RouteListRowHeight = ROW_HEIGHT
