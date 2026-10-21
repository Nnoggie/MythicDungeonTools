local _, MDT = ...
local L = MDT.L
local UI = MDT.UI
local Theme, Fonts = UI.Theme, UI.Fonts

local ROW_HEIGHT = 22

---A row of the route list: class-colored author / name, and a LIVE tag on the live route. Actions live in the right-click menu.
local RouteRow = {}

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
  self.kitLive = self:CreateFontString(nil, "ARTWORK")
  self.kitLive:SetFontObject(Fonts.Get("small"))
  self.kitLive:SetPoint("RIGHT", self, "RIGHT", -pad, 0)
  self.kitLive:SetText(string.upper(L["Live"]))
  Theme.Bind(self.kitLive, "live")
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
  self.kitLive:SetShown(item.isLive)
  if item.isLive then
    self.kitName:SetPoint("RIGHT", self.kitLive, "LEFT", -Theme.Space("sm"), 0)
  else
    self.kitName:SetPoint("RIGHT", self, "RIGHT", -Theme.Space("md"), 0)
  end
  self.kitCurrent:SetShown(item.isCurrent)
  self.kitMarker:SetShown(item.isCurrent)
end

---@type table<string, MDT.UI.ListKind>
MDT.RouteListKinds = {
  route = { height = ROW_HEIGHT, mixin = RouteRow },
}

MDT.RouteListRowHeight = ROW_HEIGHT
