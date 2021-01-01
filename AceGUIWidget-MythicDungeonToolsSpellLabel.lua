local LabelType, LabelVersion = "MDTSpellLabel", 1
local AceGUI = LibStub and LibStub("AceGUI-3.0", true)

local width,height = 248,18
local tinsert,SetPortraitToTexture,SetPortraitTextureFromCreatureDisplayID,GetItemQualityColor,MouseIsOver = table.insert,SetPortraitToTexture,SetPortraitTextureFromCreatureDisplayID,GetItemQualityColor,MouseIsOver

local labelMethods = {
    ["OnAcquire"] = function(self)
        self:SetWidth(width);
        self:SetHeight(height);
    end,
    ["Initialize"] = function(self)
        self.callbacks = {
            ["OnClickNormal"] = function() end,
            ["OnKeyDown"] = function()
                if (key == "ESCAPE") then
                    --
                end
            end,
            ["OnEnter"] = function() end,
            ["OnLeave"] = function() end
        };
        self.frame:EnableKeyboard(false);
        self.frame:SetScript("OnClick", self.callbacks.OnClickNormal);
        -- self.frame:SetScript("OnKeyDown", self.callbacks.OnKeyDown);
        self.frame:SetScript("OnEnter", self.callbacks.OnEnter);
        self.frame:SetScript("OnLeave", self.callbacks.OnLeave);
        self:Enable();
    end,
    ["Disable"] = function(self)
        self.frame:Disable();
    end,
    ["Enable"] = function(self)
        self.frame:Enable();
    end,
    ["SetIndex"] = function(self, index)
        self.index = index
    end,
    ["SetTitle"] = function(self, title)
        self.titletext = title;
        self.title:SetText(title);
    end

}
--Constructor
local function LabelConstructor()
    local name = "MDTSpellLabel"..AceGUI:GetNextWidgetNum(LabelType);

    local button = CreateFrame("BUTTON", name, UIParent, "OptionsListButtonTemplate");
    button:SetHeight(height);
    button:SetWidth(width);
    button.dgroup = nil;
    button.data = {};

    local title = button:CreateFontString(nil, "OVERLAY", "GameFontNormal");
    button.title = title;
    title:SetHeight(14);
    title:SetJustifyH("LEFT");
    title:SetPoint("TOP", button, "TOP", 0, -2);
    -- title:SetPoint("LEFT", button, "RIGHT", 2, 0);
    title:SetPoint("LEFT", button, "LEFT");

    button.description = {};

    button:SetScript("OnEnter", function()

    end);
    button:SetScript("OnLeave", function()

    end);
    local widget = {
        frame = button,
        title = title,
        type = LabelType,
        parent = UIParent
    }
    for method, func in pairs(labelMethods) do
        widget[method] = func
    end

    return AceGUI:RegisterAsWidget(widget);
end

AceGUI:RegisterWidgetType(LabelType, LabelConstructor, LabelVersion)
