local Type, Version = "MDTPowerButton", 1
local AceGUI = LibStub and LibStub("AceGUI-3.0", true)

local width, height = 248, 32

local methods = {
  ["OnAcquire"] = function(self)
    self:SetWidth(width);
    self:SetHeight(height);
  end,
  ["Initialize"] = function(self)
    self.callbacks = {}

    function self.callbacks.OnClickNormal(_, mouseButton)
      if (IsControlKeyDown()) then

      elseif (IsShiftKeyDown()) then
        if DEFAULT_CHAT_FRAME.editBox and DEFAULT_CHAT_FRAME.editBox:IsVisible() then
          local old = DEFAULT_CHAT_FRAME.editBox:GetText()
          local link = GetSpellLink(self.spellId) or ""
          DEFAULT_CHAT_FRAME.editBox:SetText(old .. link)
        end
      else

      end
    end

    function self.callbacks.OnEnter()
      GameTooltip:SetOwner(self.frame, "ANCHOR_BOTTOMLEFT", 0, self.frame:GetHeight())
      GameTooltip:SetSpellByID(self.spellId)
      GameTooltip:Show()
    end

    function self.callbacks.OnLeave()
      GameTooltip:Hide()
    end

    function self.callbacks.OnKeyDown(self, key)
      if (key == "ESCAPE") then
        --
      end
    end

    function self.callbacks.OnDragStart()
      --
    end

    function self.callbacks.OnDragStop()
      --
    end

    self.frame:SetScript("OnClick", self.callbacks.OnClickNormal);
    self.frame:SetScript("OnKeyDown", self.callbacks.OnKeyDown);
    self.frame:SetScript("OnEnter", self.callbacks.OnEnter);
    self.frame:SetScript("OnLeave", self.callbacks.OnLeave);
    self.frame:EnableKeyboard(false);
    self.frame:SetMovable(true);
    self.frame:RegisterForDrag("LeftButton");
    self.frame:SetScript("OnDragStart", self.callbacks.OnDragStart);
    self.frame:SetScript("OnDragStop", self.callbacks.OnDragStop);
    self:Enable();
  end,
  ["SetSpell"] = function(self, spellId, spellData)
    self.spellId = spellId
    local name, _, icon = GetSpellInfo(spellId)
    self.icon:SetTexture(icon)
    if IsAddOnLoaded("AddOnSkins") then
      if AddOnSkins then
        local AS = unpack(AddOnSkins)
        AS:SkinTexture(self.icon)
      end
    end
    self.title:SetText(name);

    local offset = 0
    if spellData.tank then
      self.tankIcon:Show()
      offset = offset + 16
    else
      self.tankIcon:Hide()
    end
    if spellData.dps then
      self.dpsIcon:Show()
      self.dpsIcon:SetPoint("BOTTOMLEFT", self.frame.icon, "BOTTOMRIGHT", offset, 2);
      offset = offset + 16
    else
      self.dpsIcon:Hide()
    end
    if spellData.healer then
      self.healerIcon:SetPoint("BOTTOMLEFT", self.frame.icon, "BOTTOMRIGHT", offset, 2);
      self.healerIcon:Show()
      offset = offset + 16
    else
      self.healerIcon:Hide()
    end
  end,
  ["Disable"] = function(self)
    self.background:Hide();
    self.frame:Disable();
  end,
  ["Enable"] = function(self)
    self.background:Show();
    self.frame:Enable();
  end,
  ["Pick"] = function(self)
    self.frame:LockHighlight();
  end,
  ["ClearPick"] = function(self)
    self.frame:UnlockHighlight();
  end,
  ["SetIndex"] = function(self, index)
    self.index = index
  end,
  ["SetTitle"] = function(self, title)
    self.titletext = title;
    self.title:SetText(title);
  end,

}

--Constructor
local function Constructor()
  local name = "MDTPowerButton" .. AceGUI:GetNextWidgetNum(Type);
  local button = CreateFrame("BUTTON", name, UIParent, "OptionsListButtonTemplate");
  button:SetHeight(height);
  button:SetWidth(width);
  button.dgroup = nil;
  button.data = {};

  local background = button:CreateTexture(nil, "BACKGROUND", nil, 0);
  button.background = background;
  background:SetTexture("Interface\\BUTTONS\\UI-Listbox-Highlight2.blp");
  background:SetBlendMode("ADD");
  background:SetVertexColor(0.5, 0.5, 0.5, 0.25);
  background:SetPoint("TOP", button, "TOP");
  background:SetPoint("BOTTOM", button, "BOTTOM");
  background:SetPoint("LEFT", button, "LEFT");
  background:SetPoint("RIGHT", button, "RIGHT");

  local icon = button:CreateTexture(nil, "OVERLAY", nil, 0);
  button.icon = icon;
  icon:SetWidth(height);
  icon:SetHeight(height);
  icon:SetPoint("LEFT", button, "LEFT");

  local tankIcon = button:CreateTexture(nil, "OVERLAY", nil, 0);
  tankIcon:SetWidth(height * 0.4);
  tankIcon:SetHeight(height * 0.4);
  tankIcon:SetTexture("Interface/LFGFrame/RoleIcons")
  tankIcon:SetAtlas("roleicon-tiny-tank")
  tankIcon:SetPoint("BOTTOMLEFT", button.icon, "BOTTOMRIGHT", 0, 2);
  tankIcon:Hide()

  local dpsIcon = button:CreateTexture(nil, "OVERLAY", nil, 0);
  dpsIcon:SetWidth(height * 0.4);
  dpsIcon:SetHeight(height * 0.4);
  dpsIcon:SetTexture("Interface/LFGFrame/RoleIcons")
  dpsIcon:SetAtlas("roleicon-tiny-dps")
  dpsIcon:SetPoint("BOTTOMLEFT", button.icon, "BOTTOMRIGHT", 16, 2);
  dpsIcon:Hide()

  local healerIcon = button:CreateTexture(nil, "OVERLAY", nil, 0);
  healerIcon:SetWidth(height * 0.4);
  healerIcon:SetHeight(height * 0.4);
  healerIcon:SetTexture("Interface/LFGFrame/RoleIcons")
  healerIcon:SetAtlas("roleicon-tiny-healer")
  healerIcon:SetPoint("BOTTOMLEFT", button.icon, "BOTTOMRIGHT", 32, 2);
  healerIcon:Hide()

  local title = button:CreateFontString(nil, "OVERLAY", "GameFontNormal");
  button.title = title;
  title:SetHeight(14);
  title:SetJustifyH("LEFT");
  title:SetPoint("TOP", button, "TOP", 0, -2);
  title:SetPoint("LEFT", icon, "RIGHT", 2, 0);
  title:SetPoint("RIGHT", button, "RIGHT");

  button.description = {};

  button:SetScript("OnEnter", function()

  end);
  button:SetScript("OnLeave", function()

  end);

  local widget = {
    frame = button,
    title = title,
    icon = icon,
    tankIcon = tankIcon,
    dpsIcon = dpsIcon,
    healerIcon = healerIcon,
    background = background,
    type = Type
  }
  for method, func in pairs(methods) do
    ---@diagnostic disable-next-line: assign-type-mismatch
    widget[method] = func
  end

  return AceGUI:RegisterAsWidget(widget);
end

AceGUI:RegisterWidgetType(Type, Constructor, Version)
