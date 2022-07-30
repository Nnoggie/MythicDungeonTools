local Type, Version = "MDTLiveShareFrame", 1
local AceGUI = LibStub and LibStub("AceGUI-3.0", true)

local width,height = 175,38
local tinsert,SetPortraitToTexture,SetPortraitTextureFromCreatureDisplayID,GetItemQualityColor,MouseIsOver = table.insert,SetPortraitToTexture,SetPortraitTextureFromCreatureDisplayID,GetItemQualityColor,MouseIsOver

local methods = {
    ["OnAcquire"] = function(self)
        self:SetWidth(width);
        self:SetHeight(height);
    end,
    ["Initialize"] = function(self)
        self.callbacks = {}
        self.senderString:SetText("")
        self.presetString:SetText("")



        function self.callbacks.OnEnter()
            
        end

        function self.callbacks.OnLeave()
            
        end

        
        self.frame:SetScript("OnEnter", self.callbacks.OnEnter);
        self.frame:SetScript("OnLeave", self.callbacks.OnLeave);
    end,
    ["SetIndex"] = function(self, index)
        self.index = index
    end,
    ["UpdateDisplay"] = function(self, sessionData)
        self.sessionData = sessionData
        local coloredName = MDT.U.GetColoredNameFromFullName(sessionData.senderName)
        self.senderString:SetText(coloredName)

        local presetName = MDT:GetDungeonName(sessionData.preset.dungeonIdx)
        if presetName then
          presetName = sessionData.preset.presetName .. "\n" .. presetName
          self.presetString:SetText(presetName)
        end
    end,

}

--Constructor
local function Constructor()
    local widget
    local name = "MDTLiveShareFrame"..AceGUI:GetNextWidgetNum(Type);
    local frame = CreateFrame("Frame", name, UIParent);
    frame:SetHeight(height);
    frame:SetWidth(width);

    local background = frame:CreateTexture(nil, "BACKGROUND");
    frame.background = background;
    background:SetColorTexture(unpack(MDT.BackdropColor))
    background:SetAllPoints()

    local button = CreateFrame("BUTTON", name, frame, "OptionsListButtonTemplate");
    button:SetAllPoints(frame)
    button:SetScript("OnClick", function()
        print(widget.sessionData.senderName)
    end)

    local senderString = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall");
    senderString:SetVertexColor(1,1,1,1)
    frame.senderString = senderString;
    senderString:SetJustifyH("LEFT");
    senderString:SetPoint("TOPLEFT", frame, "TOPLEFT", 3, -4);

    local presetString = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall");
    presetString:SetVertexColor(1,1,1,1)
    frame.presetString = presetString;
    presetString:SetJustifyH("LEFT");
    presetString:SetScale(0.8)
    presetString:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", 4, 4);

    frame.description = {};


    frame:SetScript("OnEnter", function()

    end);
    frame:SetScript("OnLeave", function()

    end);

    widget = {
        frame = frame,
        button = button,
        senderString = senderString,
        presetString = presetString,
        background = background,
        type = Type
    }
    for method, func in pairs(methods) do
        widget[method] = func
    end

    return AceGUI:RegisterAsWidget(widget);
end

AceGUI:RegisterWidgetType(Type, Constructor, Version)
