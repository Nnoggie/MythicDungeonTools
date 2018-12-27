local AddonName, MethodDungeonTools = ...



local mainFrameStrata = "HIGH"
local canvasDrawLayer = "BORDER"

_G["MethodDungeonTools"] = MethodDungeonTools

local twipe,tinsert,tremove,tgetn,CreateFrame,tonumber,pi,max,min,atan2,abs,pairs,ipairs,GetCursorPosition,GameTooltip = table.wipe,table.insert,table.remove,table.getn,CreateFrame,tonumber,math.pi,math.max,math.min,math.atan2,math.abs,pairs,ipairs,GetCursorPosition,GameTooltip

local sizex = 840
local sizey = 555
local methodColor = "|cFFF49D38"
local selectedGreen = {0,1,0,0.4}
selectedGreen = {34/255,139/255,34/255,0.7}
MethodDungeonTools.BackdropColor = {0.058823399245739,0.058823399245739,0.058823399245739,0.9}

local Dialog = LibStub("LibDialog-1.0")
local AceGUI = LibStub("AceGUI-3.0")
local db
local icon = LibStub("LibDBIcon-1.0")
local LDB = LibStub("LibDataBroker-1.1"):NewDataObject("MethodDungeonTools", {
	type = "data source",
	text = "Method Dungeon Tools",
	icon = "Interface\\AddOns\\MethodDungeonTools\\Textures\\MethodMinimap",
	OnClick = function(button,buttonPressed)
		if buttonPressed == "RightButton" then
			if db.minimap.lock then
				icon:Unlock("MethodDungeonTools")
			else
				icon:Lock("MethodDungeonTools")
			end
		else
			MethodDungeonTools:ShowInterface()
		end
	end,
	OnTooltipShow = function(tooltip)
		if not tooltip or not tooltip.AddLine then return end
		tooltip:AddLine(methodColor.."Method Dungeon Tools|r")
		tooltip:AddLine("Click to toggle AddOn Window")
		tooltip:AddLine("Right-click to lock Minimap Button")
	end,
})

local SetPortraitTextureFromCreatureDisplayID,MouseIsOver = SetPortraitTextureFromCreatureDisplayID,MouseIsOver

-- Made by: Nnogga - Tarren Mill <Method>, 2017-2018

SLASH_METHODDUNGEONTOOLS1 = "/mplus"
SLASH_METHODDUNGEONTOOLS2 = "/mdt"
SLASH_METHODDUNGEONTOOLS3 = "/methoddungeontools"

--LUA API
local pi,tinsert = math.pi,table.insert

function SlashCmdList.METHODDUNGEONTOOLS(cmd, editbox)
	local rqst, arg = strsplit(' ', cmd)
	if rqst == "devmode" then
		MethodDungeonTools:ToggleDevMode()
	elseif rqst == "reset" then
        MethodDungeonTools:ResetMainFramePos()
	elseif rqst == "dc" then
        MethodDungeonTools:ToggleDataCollection()
    else
		MethodDungeonTools:ShowInterface()
	end
end

local initFrames
-------------------------
--- Saved Variables  ----
-------------------------
local defaultSavedVars = {
	global = {
		currentExpansion = 2,
        enemyForcesFormat = 2,
        enemyStyle = 1,
		currentDungeonIdx = 15,
		currentDifficulty = 10,
		xoffset = 0,
		yoffset = -150,
		anchorFrom = "TOP",
		anchorTo = "TOP",
        tooltipInCorner = false,
		minimap = {
			hide = false,
		},
        toolbar ={
            color = {r=1,g=1,b=1,a=1},
            brushSize = 3,
        },
		presets = {},
		currentPreset = {},
        dataCollectionActive = false,
	},
}
do
    for i=1,24 do
        defaultSavedVars.global.presets[i] = {
            [1] = {text="Default",value={}},
            [2] = {text="<New Preset>",value=0},
        }
        defaultSavedVars.global.currentPreset[i] = 1
    end
end


-- Init db
do
    local frame = CreateFrame("Frame")
    frame:RegisterEvent("ADDON_LOADED")
    frame:RegisterEvent("GROUP_ROSTER_UPDATE")
    frame:RegisterEvent("PLAYER_ENTERING_WORLD")
    --TODO Register Affix Changed event
    frame:SetScript("OnEvent", function(self, event, ...)
        return MethodDungeonTools[event](self,...)
    end)

    function MethodDungeonTools.ADDON_LOADED(self,addon)
        if addon == "MethodDungeonTools" then
			db = LibStub("AceDB-3.0"):New("MethodDungeonToolsDB", defaultSavedVars).global
			icon:Register("MethodDungeonTools", LDB, db.minimap)
			if not db.minimap.hide then
				icon:Show("MethodDungeonTools")
			end
			Dialog:Register("MethodDungeonToolsPosCopyDialog", {
				text = "Pos Copy",
				width = 500,
				editboxes = {
					{ width = 484,
					  on_escape_pressed = function(self, data) self:GetParent():Hide() end,
					},
				},
				on_show = function(self, data)
					self.editboxes[1]:SetText(data.pos)
					self.editboxes[1]:HighlightText()
					self.editboxes[1]:SetFocus()
				end,
				buttons = {
					{ text = CLOSE, },
				},
				show_while_dead = true,
				hide_on_escape = true,
			})
            if db.dataCollectionActive then MethodDungeonTools.DataCollection:Init() end
            --fix db corruption
            do
                for _,presets in pairs(db.presets) do
                    for presetIdx,preset in pairs(presets) do
                        if presetIdx == 1 then
                            if preset.text ~= "Default" then
                                preset.text = "Default"
                                preset.value = {}
                            end
                        end
                    end
                end
                for k,v in pairs(db.currentPreset) do
                    if v == 0 then db.currentPreset[k] = 1 end
                end
            end
            self:UnregisterEvent("ADDON_LOADED")
        end
    end
    function MethodDungeonTools.GROUP_ROSTER_UPDATE(self,addon)
        if not MethodDungeonTools.main_frame then return end
        local inGroup = UnitInRaid("player") or IsInGroup()
        MethodDungeonTools.main_frame.LinkToChatButton:SetDisabled(not inGroup)
    end
    function MethodDungeonTools.PLAYER_ENTERING_WORLD(self,addon)
        MethodDungeonTools:GetCurrentAffixWeek()
        self:UnregisterEvent("PLAYER_ENTERING_WORLD")
    end

end



MethodDungeonTools.dungeonTotalCount = {}
MethodDungeonTools.scaleMultiplier = {}

local affixWeeks = { --affixID as used in C_ChallengeMode.GetAffixInfo(affixID)
    [1] = {[1]=6,[2]=3,[3]=9,[4]=16},
    [2] = {[1]=5,[2]=13,[3]=10,[4]=16},
    [3] = {[1]=7,[2]=12,[3]=9,[4]=16},
    [4] = {[1]=8,[2]=4,[3]=10,[4]=16},
    [5] = {[1]=11,[2]=2,[3]=9,[4]=16},
    [6] = {[1]=5,[2]=14,[3]=10,[4]=16},
    [7] = {[1]=6,[2]=4,[3]=9,[4]=16},
    [8] = {[1]=7,[2]=2,[3]=10,[4]=16},
    [9] = {[1]=5,[2]=3,[3]=9,[4]=16},
    [10] = {[1]=8,[2]=12,[3]=10,[4]=16},
    [11] = {[1]=7,[2]=13,[3]=9,[4]=16},
    [12] = {[1]=11,[2]=14,[3]=10,[4]=16},
}
--TODO Change this once BFA hits
local affixWeeksBFA = { --affixID as used in C_ChallengeMode.GetAffixInfo(affixID)
    [1] = {[1]=9,[2]=6,[3]=3,[4]=16},
    [2] = {[1]=10,[2]=5,[3]=13,[4]=16},
    [3] = {[1]=9,[2]=7,[3]=12,[4]=16},
    [4] = {[1]=10,[2]=8,[3]=4,[4]=16},
    [5] = {[1]=9,[2]=11,[3]=2,[4]=16},
    [6] = {[1]=10,[2]=5,[3]=14,[4]=16},
    [7] = {[1]=9,[2]=6,[3]=4,[4]=16},
    [8] = {[1]=10,[2]=7,[3]=2,[4]=16},
    [9] = {[1]=9,[2]=5,[3]=3,[4]=16},
    [10] = {[1]=10,[2]=8,[3]=12,[4]=16},
    [11] = {[1]=9,[2]=7,[3]=13,[4]=16},
    [12] = {[1]=10,[2]=11,[3]=14,[4]=16},
}

local dungeonList = {
    [1] = "Black Rook Hold",
    [2] = "Cathedral of Eternal Night",
    [3] = "Court of Stars",
    [4] = "Darkheart Thicket",
    [5] = "Eye of Azshara",
    [6] = "Halls of Valor",
    [7] = "Maw of Souls",
    [8] = "Neltharion's Lair",
    [9] = "Return to Karazhan Lower",
    [10] = "Return to Karazhan Upper",
    [11] = "Seat of the Triumvirate",
    [12] = "The Arcway",
    [13] = "Vault of the Wardens",
    [14] = " >Battle for Azeroth",
    [15] = "Atal'Dazar",
    [16] = "Freehold",
    [17] = "Kings' Rest",
    [18] = "Shrine of the Storm",
    [19] = "Siege of Boralus",
    [20] = "Temple of Sethraliss",
    [21] = "The MOTHERLODE!!",
    [22] = "The Underrot",
    [23] = "Tol Dagor",
    [24] = "Waycrest Manor",
    [25] = " >Legion",
}
function MethodDungeonTools:GetDungeonName(idx) return dungeonList[idx] end

local dungeonSubLevels = {
    [1] = {
        [1] = "The Ravenscrypt",
        [2] = "The Grand Hall",
        [3] = "Ravenshold",
        [4] = "The Rook's Host",
        [5] = "Lord Ravencrest's Chamber",
        [6] = "The Raven's Crown",
    },
    [2] = {
        [1] = "Hall of the Moon",
        [2] = "Twilight Grove",
        [3] = "The Emerald Archives",
        [4] = "Path of Illumination",
        [5] = "Sacristy of Elune",
    },
    [3] = {
        [1] = "Court of Stars",
        [2] = "The Jeweled Estate",
        [3] = "The Balconies",
    },
    [4] = {
        [1] = "Darkheart Thicket",
    },
    [5] = {
        [1] = "Eye of Azshara",
    },
    [6] = {
        [1] = "The High Gate",
        [2] = "Field of the Eternal Hunt",
        [3] = "Halls of Valor",
    },
    [7] = {
        [1] = "Helmouth Cliffs",
        [2] = "The Hold",
        [3] = "The Naglfar",
    },
    [8] = {
        [1] = "Neltharion's Lair",
    },
    [9] = {
        [1] = "Master's Terrace",
        [2] = "Opera Hall Balcony",
        [3] = "The Guest Chambers",
        [4] = "The Banquet Hall",
        [5] = "Upper Livery Stables",
        [6] = "The Servant's Quarters",
    },
    [10] = {
        [1] = "Lower Broken Stair",
        [2] = "Upper Broken Stair",
        [3] = "The Menagerie",
        [4] = "Guardian's Library",
        [5] = "Library Floor",
        [6] = "Upper Library",
        [7] = "Gamesman's Hall",
        [8] = "Netherspace",
    },
    [11] = {
        [1] = "Seat of the Triumvirate",
    },
    [12] = {
        [1] = "The Arcway",
    },
    [13] = {
        [1] = "The Warden's Court",
        [2] = "Vault of the Wardens",
        [3] = "Vault of the Betrayer",
    },
    [15] = {
        [1] = "Atal'Dazar",
        [2] = "Sacrificial Pits",
    },
    [16] = {
        [1] = "Freehold",
    },
    [17] = {
        [1] = "Kings' Rest",
    },
    [18] = {
        [1] = "Shrine of the Storm",
        [2] = "Storm's End",
    },
    [19] = {
        [1] = "Siege of Boralus",
    },
    [20] = {
        [1] = "Temple of Sethraliss",
        [2] = "Atrium of Sethraliss",
    },
    [21] = {
        [1] = "The MOTHERLODE!!",
    },
    [22] = {
        [1] = "The Underrot",
        [2] = "Ruin's Descent",
    },
    [23] = {
        [1] = "Tol Dagor",
        [2] = "The Drain",
        [3] = "The Brig",
        [4] = "Detention Block",
        [5] = "Officer Quarters",
        [6] = "Overseer's Redoubt",
        [7] = "Overseer's Summit",
    },
    [24] = {
        [1] = "The Grand Foyer",
        [2] = "Upstairs",
        [3] = "The Cellar",
        [4] = "Catacombs",
        [5] = "The Rupture",
    },
}
function MethodDungeonTools:GetDungeonSublevels()
    return dungeonSubLevels
end

MethodDungeonTools.dungeonMaps = {
	[1] = {
		[0]= "BlackRookHoldDungeon",
		[1]= "BlackRookHoldDungeon1_",
		[2]= "BlackRookHoldDungeon2_",
		[3]= "BlackRookHoldDungeon3_",
		[4]= "BlackRookHoldDungeon4_",
		[5]= "BlackRookHoldDungeon5_",
		[6]= "BlackRookHoldDungeon6_",
	},
	[2] = {
		[0]= "TombofSargerasDungeon",
		[1]= "TombofSargerasDungeon1_",
		[2]= "TombofSargerasDungeon2_",
		[3]= "TombofSargerasDungeon3_",
		[4]= "TombofSargerasDungeon4_",
		[5]= "TombofSargerasDungeon5_",
	},
	[3] = {
		[0] = "SuramarNoblesDistrict",
		[1] = "SuramarNoblesDistrict",
		[2] = "SuramarNoblesDistrict1_",
		[3] = "SuramarNoblesDistrict2_",
	},
	[4] = {
		[0] = "DarkheartThicket",
		[1] = "DarkheartThicket",
	},
	[5] = {
		[0]= "AszunaDungeon",
		[1]= "AszunaDungeon",
	},
	[6] = {
		[0]= "Hallsofvalor",
		[1]= "Hallsofvalor1_",
		[2]= "Hallsofvalor",
		[3]= "Hallsofvalor2_",
	},

	[7] = {
		[0] = "HelheimDungeonDock",
		[1] = "HelheimDungeonDock",
		[2] = "HelheimDungeonDock1_",
		[3] = "HelheimDungeonDock2_",
	},
	[8] = {
		[0] = "NeltharionsLair",
		[1] = "NeltharionsLair",
	},
	[9] = {
		[0] = "LegionKarazhanDungeon",
		[1] = "LegionKarazhanDungeon6_",
		[2] = "LegionKarazhanDungeon5_",
		[3] = "LegionKarazhanDungeon4_",
		[4] = "LegionKarazhanDungeon3_",
		[5] = "LegionKarazhanDungeon2_",
		[6] = "LegionKarazhanDungeon1_",
	},
	[10] = {
		[0] = "LegionKarazhanDungeon",
		[1] = "LegionKarazhanDungeon7_",
		[2] = "LegionKarazhanDungeon8_",
		[3] = "LegionKarazhanDungeon9_",
		[4] = "LegionKarazhanDungeon10_",
		[5] = "LegionKarazhanDungeon11_",
		[6] = "LegionKarazhanDungeon12_",
		[7] = "LegionKarazhanDungeon13_",
		[8] = "LegionKarazhanDungeon14_",
	},
	[11] = {
		[0] = "ArgusDungeon",
		[1] = "ArgusDungeon",
	},
	[12] = {
		[0]= "SuamarCatacombsDungeon",
		[1]= "SuamarCatacombsDungeon1_",
	},
	[13] = {
		[0]= "VaultOfTheWardens",
		[1]= "VaultOfTheWardens1_",
		[2]= "VaultOfTheWardens2_",
		[3]= "VaultOfTheWardens3_",
	},
	[15] = {
		[0]= "CityOfGold",
		[1]= "CityOfGold1_",
		[2]= "CityOfGold2_",
	},
	[16] = {
		[0]= "KulTirasPirateTownDungeon",
		[1]= "KulTirasPirateTownDungeon",
	},
	[17] = {
        [0] = "KingsRest",
        [1] = "KingsRest1_"
	},
    [18] = {
        [0] = "ShrineOfTheStorm",
        [1] = "ShrineOfTheStorm",
        [2] = "ShrineOfTheStorm1_",
    },
    [19] = {
        [0] = "SiegeOfBoralus",
        [1] = "SiegeOfBoralus",
    },
    [20] = {
        [0] = "TempleOfSethralissA",
        [1] = "TempleOfSethralissA",
        [2] = "TempleOfSethralissB",
    },
    [21] = {
        [0] = "KezanDungeon",
        [1] = "KezanDungeon",
    },
    [22] = {
        [0] = "UnderrotExterior",
        [1] = "UnderrotExterior",
        [2] = "UnderrotInterior",
    },
    [23] = {
        [0] = "PrisonDungeon",
        [1] = "PrisonDungeon",
        [2] = "PrisonDungeon1_",
        [3] = "PrisonDungeon2_",
        [4] = "PrisonDungeon3_",
        [5] = "PrisonDungeon4_",
        [6] = "PrisonDungeon5_",
        [7] = "PrisonDungeon6_",
    },
    [24] = {
        [0] = "Waycrest",
        [1] = "Waycrest1_",
        [2] = "Waycrest2_",
        [3] = "Waycrest3_",
        [4] = "Waycrest4_",
        [5] = "Waycrest5_",
    },

}
MethodDungeonTools.dungeonBosses = {}
MethodDungeonTools.dungeonEnemies = {}
MethodDungeonTools.mapPOIs = {}

function MethodDungeonTools:GetDB()
    return db
end

local framesInitialized
function MethodDungeonTools:ShowInterface(force)
    if not framesInitialized then initFrames() end
	if self.main_frame:IsShown() and not force then
		MethodDungeonTools:HideInterface()
	else
		self.main_frame:Show()
		--MethodDungeonTools:UpdateToDungeon(db.currentDungeonIdx)
		self.main_frame.HelpButton:Show()
	end
end

function MethodDungeonTools:HideInterface()
	self.main_frame:Hide();
	self.main_frame.HelpButton:Hide()
end

function MethodDungeonTools:ToggleDevMode()
    db.devMode = not db.devMode
    ReloadUI()
end

function MethodDungeonTools:ToggleDataCollection()
    db.dataCollectionActive = not db.dataCollectionActive
    print(string.format("%sMDT|r: DataCollection %s. Reload Interface!",methodColor,db.dataCollectionActive and "|cFF00FF00Enabled|r" or "|cFFFF0000Disabled|r"))
end


function MethodDungeonTools:CreateMenu()
	-- Close button
	self.main_frame.closeButton = CreateFrame("Button", "CloseButton", self.main_frame, "UIPanelCloseButton");
	self.main_frame.closeButton:ClearAllPoints()
	self.main_frame.closeButton:SetPoint("BOTTOMRIGHT", self.main_frame, "TOPRIGHT", 240, -2);
	self.main_frame.closeButton:SetScript("OnClick", function() MethodDungeonTools:HideInterface(); end)
	self.main_frame.closeButton:SetFrameLevel(4)
	MethodDungeonTools:SkinCloseButton()
end

function MethodDungeonTools:SkinCloseButton()
	--attempt to skin close button for ElvUI
	if IsAddOnLoaded("ElvUI") then
	   local E, L, V, P, G = unpack(ElvUI)
	   local S
	   if E then S = E:GetModule("Skins") end
	   if S then
	      S:HandleCloseButton(MethodDungeonTools.main_frame.closeButton)
	   end
	end
end

function MethodDungeonTools:SkinProgressBar(progressBar)
    local bar = progressBar and progressBar.Bar
    if not bar then return end
    bar.Icon:Hide()
    bar.IconBG:Hide()
    if IsAddOnLoaded("ElvUI") then
        local E, L, V, P, G = unpack(ElvUI)
        if bar.BarFrame then bar.BarFrame:Hide() end
        if bar.BarFrame2 then bar.BarFrame2:Hide() end
        if bar.BarFrame3 then bar.BarFrame3:Hide() end
        if bar.BarGlow then bar.BarGlow:Hide() end
        if bar.Sheen then bar.Sheen:Hide() end
        if bar.IconBG then bar.IconBG:SetAlpha(0) end
        if bar.BorderLeft then bar.BorderLeft:SetAlpha(0) end
        if bar.BorderRight then bar.BorderRight:SetAlpha(0) end
        if bar.BorderMid then bar.BorderMid:SetAlpha(0) end
        bar:Height(18)
        bar:StripTextures()
        bar:CreateBackdrop("Transparent")
        bar:SetStatusBarTexture(E.media.normTex)
        local label = bar.Label
        if not label then return end
        label:ClearAllPoints()
        label:SetPoint("CENTER",bar,"CENTER")
    end
end


function MethodDungeonTools:MakeTopBottomTextures(frame)

    frame:SetMovable(true)

	if frame.topPanel == nil then
		frame.topPanel = CreateFrame("Frame", "MethodDungeonToolsTopPanel", frame)
		frame.topPanelTex = frame.topPanel:CreateTexture(nil, "BACKGROUND")
		frame.topPanelTex:SetAllPoints()
		frame.topPanelTex:SetDrawLayer(canvasDrawLayer, -5)
		frame.topPanelTex:SetColorTexture(unpack(MethodDungeonTools.BackdropColor))

		frame.topPanelString = frame.topPanel:CreateFontString("MethodDungeonTools name")

		--use default font if ElvUI is enabled
		--if IsAddOnLoaded("ElvUI") then
			frame.topPanelString:SetFontObject("GameFontNormalMed3")
		frame.topPanelString:SetTextColor(1, 1, 1, 1)
		frame.topPanelString:SetJustifyH("CENTER")
		frame.topPanelString:SetJustifyV("CENTER")
		--frame.topPanelString:SetWidth(600)
		frame.topPanelString:SetHeight(20)
		frame.topPanelString:SetText("Method Dungeon Tools")
		frame.topPanelString:ClearAllPoints()
		frame.topPanelString:SetPoint("CENTER", frame.topPanel, "CENTER", 0, 0)
		frame.topPanelString:Show()
        --frame.topPanelString:SetFont(frame.topPanelString:GetFont(), 20)

		frame.topPanelLogo = frame.topPanel:CreateTexture(nil, "HIGH", nil, 7)
		frame.topPanelLogo:SetTexture("Interface\\AddOns\\MethodDungeonTools\\Textures\\Method")
		frame.topPanelLogo:SetWidth(24)
		frame.topPanelLogo:SetHeight(24)
		frame.topPanelLogo:SetPoint("RIGHT",frame.topPanelString,"LEFT",-5,0)
		frame.topPanelLogo:Show()

	end

    frame.topPanel:ClearAllPoints()
    frame.topPanel:SetSize(frame:GetWidth(), 30)
    frame.topPanel:SetPoint("BOTTOMLEFT", frame, "TOPLEFT", 0, 0)

    frame.topPanel:EnableMouse(true)
    frame.topPanel:RegisterForDrag("LeftButton")
    frame.topPanel:SetScript("OnDragStart", function(self,button)
        frame:SetMovable(true)
        frame:StartMoving()
    end)
    frame.topPanel:SetScript("OnDragStop", function(self,button)
        frame:StopMovingOrSizing();
        frame:SetMovable(false);
        local from,_,to,x,y = MethodDungeonTools.main_frame:GetPoint()
        db.anchorFrom = from
        db.anchorTo = to
        db.xoffset,db.yoffset = x,y
    end)

    if frame.bottomPanel == nil then
        frame.bottomPanel = CreateFrame("Frame", "MethodDungeonToolsBottomPanel", frame)
        frame.bottomPanelTex = frame.bottomPanel:CreateTexture(nil, "BACKGROUND")
        frame.bottomPanelTex:SetAllPoints()
        frame.bottomPanelTex:SetDrawLayer(canvasDrawLayer, -5)
        frame.bottomPanelTex:SetColorTexture(unpack(MethodDungeonTools.BackdropColor))

    end

    frame.bottomPanel:ClearAllPoints()
    frame.bottomPanel:SetSize(frame:GetWidth(), 30)
    frame.bottomPanel:SetPoint("TOPLEFT", frame, "BOTTOMLEFT", 0, 0)

    frame.bottomPanelString = frame.bottomPanel:CreateFontString("MethodDungeonTools Version")
    frame.bottomPanelString:SetFontObject("GameFontNormalSmall")
    frame.bottomPanelString:SetJustifyH("CENTER")
	frame.bottomPanelString:SetJustifyV("CENTER")
	frame.bottomPanelString:SetText("v"..GetAddOnMetadata(AddonName, "Version"))--.." - Please report missing/wrongly positioned NPCs in discord.gg/nnogga or on github.com/nnogga/MethodDungeonTools"
	frame.bottomPanelString:SetPoint("CENTER", frame.bottomPanel, "CENTER", 0, 0)
	frame.bottomPanelString:SetTextColor(1, 1, 1, 1)
	frame.bottomPanelString:Show()


	frame.bottomPanel:EnableMouse(true)
	frame.bottomPanel:RegisterForDrag("LeftButton")
	frame.bottomPanel:SetScript("OnDragStart", function(self,button)
		frame:SetMovable(true)
        frame:StartMoving()
    end)
	frame.bottomPanel:SetScript("OnDragStop", function(self,button)
        frame:StopMovingOrSizing()
		frame:SetMovable(false)
		local from,_,to,x,y = MethodDungeonTools.main_frame:GetPoint()
		db.anchorFrom = from
		db.anchorTo = to
		db.xoffset,db.yoffset = x,y
    end)

end

function MethodDungeonTools:MakeSidePanel(frame)

	if frame.sidePanel == nil then
		frame.sidePanel = CreateFrame("Frame", "MethodDungeonToolsSidePanel", frame)
		frame.sidePanelTex = frame.sidePanel:CreateTexture(nil, "BACKGROUND")
		frame.sidePanelTex:SetAllPoints()
		frame.sidePanelTex:SetDrawLayer(canvasDrawLayer, -5)
		frame.sidePanelTex:SetColorTexture(unpack(MethodDungeonTools.BackdropColor))
		frame.sidePanelTex:Show()
	end


	frame.sidePanel:ClearAllPoints();
	frame.sidePanel:SetSize(250, frame:GetHeight()+(frame.topPanel:GetHeight()*2))
	frame.sidePanel:SetPoint("TOPLEFT", frame.topPanel, "TOPRIGHT", -1, 0)

	frame.sidePanelString = frame.sidePanel:CreateFontString("MethodDungeonToolsSidePanelText")
	frame.sidePanelString:SetFont("Fonts\\FRIZQT__.TTF", 10)
	frame.sidePanelString:SetTextColor(1, 1, 1, 1);
	frame.sidePanelString:SetJustifyH("LEFT")
	frame.sidePanelString:SetJustifyV("TOP")
	frame.sidePanelString:SetWidth(200)
	frame.sidePanelString:SetHeight(500)
	frame.sidePanelString:SetText("");
	frame.sidePanelString:ClearAllPoints();
	frame.sidePanelString:SetPoint("TOPLEFT", frame.sidePanel, "TOPLEFT", 33, -120-30-25);
	frame.sidePanelString:Hide();



	frame.sidePanel.WidgetGroup = AceGUI:Create("SimpleGroup")
	frame.sidePanel.WidgetGroup:SetWidth(245);
	frame.sidePanel.WidgetGroup:SetHeight(frame:GetHeight()+(frame.topPanel:GetHeight()*2)-31);
	frame.sidePanel.WidgetGroup:SetPoint("TOP",frame.sidePanel,"TOP",3,-1)
	frame.sidePanel.WidgetGroup:SetLayout("Flow")

	frame.sidePanel.WidgetGroup.frame:SetFrameStrata(mainFrameStrata)
	frame.sidePanel.WidgetGroup.frame:SetBackdropColor(1,1,1,0)
	frame.sidePanel.WidgetGroup.frame:Hide()

	--dirty hook to make widgetgroup show/hide
	local originalShow,originalHide = frame.Show,frame.Hide
	function frame:Show(...)
		frame.sidePanel.WidgetGroup.frame:Show()
		return originalShow(self, ...);
	end
	function frame:Hide(...)
		frame.sidePanel.WidgetGroup.frame:Hide()
        MethodDungeonTools.pullTooltip:Hide()
		return originalHide(self, ...);
	end

	--preset selection
	frame.sidePanel.WidgetGroup.PresetDropDown = AceGUI:Create("Dropdown")
	local dropdown = frame.sidePanel.WidgetGroup.PresetDropDown
	dropdown.text:SetJustifyH("LEFT")
	dropdown:SetCallback("OnValueChanged",function(widget,callbackName,key)
		if db.presets[db.currentDungeonIdx][key].value==0 then
			MethodDungeonTools:OpenNewPresetDialog()
			MethodDungeonTools.main_frame.sidePanelDeleteButton:SetDisabled(true)
		else
			if key == 1 then
				MethodDungeonTools.main_frame.sidePanelDeleteButton:SetDisabled(true)
			else
				MethodDungeonTools.main_frame.sidePanelDeleteButton:SetDisabled(false)
			end
			db.currentPreset[db.currentDungeonIdx] = key
            --Set affix dropdown to preset week
            --frame.sidePanel.affixDropdown:SetAffixWeek(MethodDungeonTools:GetCurrentPreset().week or MethodDungeonTools:GetCurrentAffixWeek())
			--UpdateMap is called in SetAffixWeek, no need to call twice
            MethodDungeonTools:UpdateMap()
            frame.sidePanel.affixDropdown:SetAffixWeek(MethodDungeonTools:GetCurrentPreset().week or MethodDungeonTools:GetCurrentAffixWeek() or 1)
		end
	end)
	MethodDungeonTools:UpdatePresetDropDown()
	frame.sidePanel.WidgetGroup:AddChild(dropdown)


	---new profile,rename,export,delete
	local buttonWidth = 80
	frame.sidePanelNewButton = AceGUI:Create("Button")
	frame.sidePanelNewButton:SetText("New")
	frame.sidePanelNewButton:SetWidth(buttonWidth)
	--button fontInstance
	local fontInstance = CreateFont("MDTButtonFont");
	fontInstance:CopyFontObject(frame.sidePanelNewButton.frame:GetNormalFontObject());
	local fontName,height = fontInstance:GetFont()
	fontInstance:SetFont(fontName,10)
	frame.sidePanelNewButton.frame:SetNormalFontObject(fontInstance)
	frame.sidePanelNewButton.frame:SetHighlightFontObject(fontInstance)
	frame.sidePanelNewButton.frame:SetDisabledFontObject(fontInstance)
	frame.sidePanelNewButton:SetCallback("OnClick",function(widget,callbackName,value)
		MethodDungeonTools:OpenNewPresetDialog()
	end)

	frame.sidePanelRenameButton = AceGUI:Create("Button")
	frame.sidePanelRenameButton:SetWidth(buttonWidth)
	frame.sidePanelRenameButton:SetText("Rename")
	frame.sidePanelRenameButton.frame:SetNormalFontObject(fontInstance)
	frame.sidePanelRenameButton.frame:SetHighlightFontObject(fontInstance)
	frame.sidePanelRenameButton.frame:SetDisabledFontObject(fontInstance)
	frame.sidePanelRenameButton:SetCallback("OnClick",function(widget,callbackName,value)
		MethodDungeonTools:HideAllDialogs()
		local currentPresetName = db.presets[db.currentDungeonIdx][db.currentPreset[db.currentDungeonIdx]].text
		MethodDungeonTools.main_frame.RenameFrame:Show()
		MethodDungeonTools.main_frame.RenameFrame.RenameButton:SetDisabled(true)
		MethodDungeonTools.main_frame.RenameFrame:SetPoint("CENTER",MethodDungeonTools.main_frame,"CENTER",0,50)
		MethodDungeonTools.main_frame.RenameFrame.Editbox:SetText(currentPresetName)
		MethodDungeonTools.main_frame.RenameFrame.Editbox:HighlightText(0, string.len(currentPresetName))
		MethodDungeonTools.main_frame.RenameFrame.Editbox:SetFocus()
	end)

	frame.sidePanelImportButton = AceGUI:Create("Button")
	frame.sidePanelImportButton:SetText("Import")
	frame.sidePanelImportButton:SetWidth(buttonWidth)
	frame.sidePanelImportButton.frame:SetNormalFontObject(fontInstance)
	frame.sidePanelImportButton.frame:SetHighlightFontObject(fontInstance)
	frame.sidePanelImportButton.frame:SetDisabledFontObject(fontInstance)
	frame.sidePanelImportButton:SetCallback("OnClick",function(widget,callbackName,value)
		MethodDungeonTools:OpenImportPresetDialog()
	end)

	frame.sidePanelExportButton = AceGUI:Create("Button")
	frame.sidePanelExportButton:SetText("Export")
	frame.sidePanelExportButton:SetWidth(buttonWidth)
	frame.sidePanelExportButton.frame:SetNormalFontObject(fontInstance)
	frame.sidePanelExportButton.frame:SetHighlightFontObject(fontInstance)
	frame.sidePanelExportButton.frame:SetDisabledFontObject(fontInstance)
	frame.sidePanelExportButton:SetCallback("OnClick",function(widget,callbackName,value)
		local export = MethodDungeonTools:TableToString(db.presets[db.currentDungeonIdx][db.currentPreset[db.currentDungeonIdx]],true)
		MethodDungeonTools:HideAllDialogs()
		MethodDungeonTools.main_frame.ExportFrame:Show()
		MethodDungeonTools.main_frame.ExportFrame:SetPoint("CENTER",MethodDungeonTools.main_frame,"CENTER",0,50)
		MethodDungeonTools.main_frame.ExportFrameEditbox:SetText(export)
		MethodDungeonTools.main_frame.ExportFrameEditbox:HighlightText(0, string.len(export))
		MethodDungeonTools.main_frame.ExportFrameEditbox:SetFocus()
	end)

	frame.sidePanelDeleteButton = AceGUI:Create("Button")
	frame.sidePanelDeleteButton:SetText("Delete")
	frame.sidePanelDeleteButton:SetWidth(buttonWidth)
	frame.sidePanelDeleteButton.frame:SetNormalFontObject(fontInstance)
	frame.sidePanelDeleteButton.frame:SetHighlightFontObject(fontInstance)
	frame.sidePanelDeleteButton.frame:SetDisabledFontObject(fontInstance)
	frame.sidePanelDeleteButton:SetCallback("OnClick",function(widget,callbackName,value)
		MethodDungeonTools:HideAllDialogs()
		frame.DeleteConfirmationFrame:SetPoint("CENTER",MethodDungeonTools.main_frame,"CENTER",0,50)
		local currentPresetName = db.presets[db.currentDungeonIdx][db.currentPreset[db.currentDungeonIdx]].text
		frame.DeleteConfirmationFrame.label:SetText("Delete "..currentPresetName.."?")
		frame.DeleteConfirmationFrame:Show()
	end)

	frame.LinkToChatButton = AceGUI:Create("Button")
	frame.LinkToChatButton:SetText("Share")
	frame.LinkToChatButton:SetWidth(buttonWidth)
	frame.LinkToChatButton.frame:SetNormalFontObject(fontInstance)
	frame.LinkToChatButton.frame:SetHighlightFontObject(fontInstance)
	frame.LinkToChatButton.frame:SetDisabledFontObject(fontInstance)
	frame.LinkToChatButton:SetCallback("OnClick",function(widget,callbackName,value)
        local distribution = (UnitInRaid("player") and "RAID") or (IsInGroup() and "PARTY")
        if not distribution then return end
        frame.LinkToChatButton:SetDisabled(true)
        frame.LinkToChatButton:SetText("Sending")
        MethodDungeonTools:SendToGroup(distribution)
	end)
    local inGroup = UnitInRaid("player") or IsInGroup()
    MethodDungeonTools.main_frame.LinkToChatButton:SetDisabled(not inGroup)

	frame.sidePanel.WidgetGroup:AddChild(frame.sidePanelNewButton)
	frame.sidePanel.WidgetGroup:AddChild(frame.sidePanelImportButton)
	frame.sidePanel.WidgetGroup:AddChild(frame.sidePanelExportButton)
	frame.sidePanel.WidgetGroup:AddChild(frame.sidePanelRenameButton)
	frame.sidePanel.WidgetGroup:AddChild(frame.LinkToChatButton)
	frame.sidePanel.WidgetGroup:AddChild(frame.sidePanelDeleteButton)



    --Week Dropdown (Infested / Affixes)
    local function makeAffixString(week,affixes,longText)
        local ret
        local sep = ""
        for _,affixID in ipairs(affixes) do
            local name, _, filedataid = C_ChallengeMode.GetAffixInfo(affixID)
            if longText then
                ret = ret or ""
                ret = ret..sep..name
                sep = ", "
            else
                ret = ret or week..(week>9 and ". " or ".   ")
                if week == MethodDungeonTools:GetCurrentAffixWeek() then
                    ret = WrapTextInColorCode(ret, "FF00FF00")
                end
                ret = ret..CreateTextureMarkup(filedataid, 64, 64, 20, 20, 0.1, 0.9, 0.1, 0.9,0,0).."  "
            end
        end
        return ret
    end
    frame.sidePanel.affixDropdown = AceGUI:Create("Dropdown")
    local affixDropdown = frame.sidePanel.affixDropdown
    affixDropdown.text:SetJustifyH("LEFT")
    affixDropdown:SetLabel("Affixes")


    function affixDropdown:UpdateAffixList()
        local affixWeekMarkups = {}
        for week,affixes in ipairs(affixWeeks) do
            tinsert(affixWeekMarkups,makeAffixString(week,affixes))
        end
        affixDropdown:SetList(affixWeekMarkups)
        --mouseover list items
        for itemIdx,item in ipairs(affixDropdown.pullout.items) do
            item:SetOnEnter(function()
                GameTooltip:SetOwner(item.frame, "ANCHOR_LEFT",-11,-25)
                local v = affixWeeks[itemIdx]
                GameTooltip:SetText(makeAffixString(nil,v,true),1,1,1,1)
                GameTooltip:Show()
            end)
            item:SetOnLeave(function()
                GameTooltip:Hide()
            end)
        end
    end
    function affixDropdown:SetAffixWeek(key,ignoreReloadPullButtons,ignoreUpdateProgressBar)
        affixDropdown:SetValue(key)
        if not MethodDungeonTools:GetCurrentAffixWeek() then
            frame.sidePanel.affixWeekWarning.image:Hide()
            frame.sidePanel.affixWeekWarning:SetDisabled(true)
        elseif MethodDungeonTools:GetCurrentAffixWeek() == key then
            frame.sidePanel.affixWeekWarning.image:Hide()
            frame.sidePanel.affixWeekWarning:SetDisabled(true)
        else
            frame.sidePanel.affixWeekWarning.image:Show()
            frame.sidePanel.affixWeekWarning:SetDisabled(false)
        end
        MethodDungeonTools:GetCurrentPreset().week = key
        local teeming = MethodDungeonTools:IsPresetTeeming(MethodDungeonTools:GetCurrentPreset())
        db.presets[db.currentDungeonIdx][db.currentPreset[db.currentDungeonIdx]].value.teeming = teeming
        --dont need this here as we just change teeming and infested
        --MethodDungeonTools:UpdateMap()
        MethodDungeonTools:DungeonEnemies_UpdateTeeming()
        MethodDungeonTools:DungeonEnemies_UpdateInfested(key)
        MethodDungeonTools:UpdateFreeholdSelector(key)
        MethodDungeonTools:DungeonEnemies_UpdateBlacktoothEvent(key)
        MethodDungeonTools:DungeonEnemies_UpdateBoralusFaction(MethodDungeonTools:GetCurrentPreset().faction)
        MethodDungeonTools:POI_UpdateAll()
        if not ignoreUpdateProgressBar then
            MethodDungeonTools:UpdateProgressbar()
        end
        if not ignoreReloadPullButtons then MethodDungeonTools:ReloadPullButtons() end
    end
    affixDropdown:SetCallback("OnValueChanged",function(widget,callbackName,key)
        affixDropdown:SetAffixWeek(key)
    end)
    affixDropdown:SetCallback("OnEnter",function(...)
        local selectedWeek = affixDropdown:GetValue()
        if not selectedWeek then return end
        GameTooltip:SetOwner(affixDropdown.frame, "ANCHOR_LEFT",-6,-41)
        local v = affixWeeks[selectedWeek]
        GameTooltip:SetText(makeAffixString(nil,v,true),1,1,1,1)
        GameTooltip:Show()
    end)
    affixDropdown:SetCallback("OnLeave",function(...)
        GameTooltip:Hide()
    end)

    frame.sidePanel.WidgetGroup:AddChild(affixDropdown)

    --affix not current week warning
    frame.sidePanel.affixWeekWarning = AceGUI:Create("Icon")
    local affixWeekWarning = frame.sidePanel.affixWeekWarning
    affixWeekWarning:SetImage("Interface\\DialogFrame\\UI-Dialog-Icon-AlertNew")
    affixWeekWarning:SetImageSize(25,25)
    affixWeekWarning:SetWidth(35)
    affixWeekWarning:SetCallback("OnEnter",function(...)
        GameTooltip:SetOwner(affixDropdown.frame, "ANCHOR_CURSOR")
        GameTooltip:SetText("The selected affixes are not the ones of the current week")
        GameTooltip:Show()
    end)
    affixWeekWarning:SetCallback("OnLeave",function(...)
        GameTooltip:Hide()
    end)
    affixWeekWarning:SetCallback("OnClick",function(...)
        if not MethodDungeonTools:GetCurrentAffixWeek() then return end
        affixDropdown:SetAffixWeek(MethodDungeonTools:GetCurrentAffixWeek())
    end)
    frame.sidePanel.WidgetGroup:AddChild(affixWeekWarning)
    affixWeekWarning.image:Hide()
    affixWeekWarning:SetDisabled(true)



	--Difficulty Selection
	frame.sidePanel.DifficultySliderLabel = AceGUI:Create("Label")
	frame.sidePanel.DifficultySliderLabel:SetText(" Level: ")
	frame.sidePanel.DifficultySliderLabel:SetWidth(35)
	frame.sidePanel.WidgetGroup:AddChild(frame.sidePanel.DifficultySliderLabel)


	frame.sidePanel.DifficultySlider = AceGUI:Create("Slider")
	frame.sidePanel.DifficultySlider:SetSliderValues(1,35,1)
	frame.sidePanel.DifficultySlider:SetWidth(195)	--240
	frame.sidePanel.DifficultySlider:SetValue(db.currentDifficulty)
	frame.sidePanel.DifficultySlider:SetCallback("OnValueChanged",function(widget,callbackName,value)
		local difficulty = tonumber(value)
		db.currentDifficulty = difficulty or db.currentDifficulty
	end)
	frame.sidePanel.WidgetGroup:AddChild(frame.sidePanel.DifficultySlider)


	frame.sidePanel.middleLine = AceGUI:Create("Heading")
	frame.sidePanel.middleLine:SetWidth(240)
	frame.sidePanel.WidgetGroup:AddChild(frame.sidePanel.middleLine)
    frame.sidePanel.WidgetGroup.frame:SetFrameLevel(3)

	--progress bar
	frame.sidePanel.ProgressBar = CreateFrame("Frame", nil, frame.sidePanel, "ScenarioTrackerProgressBarTemplate")
	frame.sidePanel.ProgressBar:Show()
	frame.sidePanel.ProgressBar:SetPoint("TOP",frame.sidePanel.WidgetGroup.frame,"BOTTOM",-10,5)
    MethodDungeonTools:SkinProgressBar(frame.sidePanel.ProgressBar)
end

function MethodDungeonTools:UpdatePresetDropDown()
	local dropdown = MethodDungeonTools.main_frame.sidePanel.WidgetGroup.PresetDropDown
	local presetList = {}
	for k,v in pairs(db.presets[db.currentDungeonIdx]) do
		table.insert(presetList,k,v.text)
	end
	dropdown:SetList(presetList)
	dropdown:SetValue(db.currentPreset[db.currentDungeonIdx])
end


---FormatEnemyForces
function MethodDungeonTools:FormatEnemyForces(forces,forcesmax,progressbar)
    if not forcesmax then forcesmax = MethodDungeonTools:IsCurrentPresetTeeming() and MethodDungeonTools.dungeonTotalCount[db.currentDungeonIdx].teeming or MethodDungeonTools.dungeonTotalCount[db.currentDungeonIdx].normal end
    if db.enemyForcesFormat == 1 then
        if progressbar then return forces.."/"..forcesmax end
        return forces
    elseif db.enemyForcesFormat == 2 then
        if progressbar then return string.format((forces.."/"..forcesmax.." (%.2f%%)"),(forces/forcesmax)*100) end
        return string.format(forces.." (%.2f%%)",(forces/forcesmax)*100)
    end
end

---Progressbar_SetValue
---Sets the value/progress/color of the count progressbar to the apropriate data
function MethodDungeonTools:Progressbar_SetValue(self,totalCurrent,totalMax)
	local percent = (totalCurrent/totalMax)*100
	if percent >= 102 then
		if totalCurrent-totalMax > 8 then
			self.Bar:SetStatusBarColor(1,0,0,1)
		else
			self.Bar:SetStatusBarColor(0,1,0,1)
		end
    elseif percent >= 100 then
        self.Bar:SetStatusBarColor(0,1,0,1)
	else
		self.Bar:SetStatusBarColor(0.26,0.42,1)
	end
	self.Bar:SetValue(percent);
	self.Bar.Label:SetText(MethodDungeonTools:FormatEnemyForces(totalCurrent,totalMax,true));
	self.AnimValue = percent;
end

function MethodDungeonTools:OnPan(cursorX, cursorY)
	local scrollFrame = MethodDungeonToolsScrollFrame
    local scale = MethodDungeonToolsMapPanelFrame:GetScale()/1.5
	local deltaX = (scrollFrame.cursorX - cursorX)/scale
	local deltaY = (cursorY - scrollFrame.cursorY)/scale
	if(abs(deltaX) >= 1 or abs(deltaY) >= 1)then
		local newHorizontalPosition = max(0, deltaX + scrollFrame:GetHorizontalScroll());
		newHorizontalPosition = min(newHorizontalPosition, scrollFrame.maxX);
		local newVerticalPosition = max(0, deltaY + scrollFrame:GetVerticalScroll());
		newVerticalPosition = min(newVerticalPosition, scrollFrame.maxY);
		scrollFrame:SetHorizontalScroll(newHorizontalPosition)
		scrollFrame:SetVerticalScroll(newVerticalPosition)
		scrollFrame.cursorX = cursorX
		scrollFrame.cursorY = cursorY
	end
end

---UpdateProgressbar
---Update the progressbar on the sidepanel with the correct values
function MethodDungeonTools:UpdateProgressbar()
	local teeming = db.presets[db.currentDungeonIdx][db.currentPreset[db.currentDungeonIdx]].value.teeming
    MethodDungeonTools:EnsureDBTables()
    local grandTotal = MethodDungeonTools:CountForces()
	MethodDungeonTools:Progressbar_SetValue(MethodDungeonTools.main_frame.sidePanel.ProgressBar,grandTotal,teeming==true and MethodDungeonTools.dungeonTotalCount[db.currentDungeonIdx].teeming or MethodDungeonTools.dungeonTotalCount[db.currentDungeonIdx].normal)
end


function MethodDungeonTools:ZoomMap(delta,resetZoom)
	local scrollFrame = MethodDungeonToolsScrollFrame;
	local oldScrollH = scrollFrame:GetHorizontalScroll();
	local oldScrollV = scrollFrame:GetVerticalScroll();

	local mainFrame = MethodDungeonToolsMapPanelFrame

	local oldScale = mainFrame:GetScale();
	local newScale = oldScale + delta * 0.3;

	newScale = max(1, newScale);
	newScale = min(15, newScale);
	if resetZoom then newScale = 1 end

	mainFrame:SetScale(newScale)

	local scaledSizeX = mainFrame:GetWidth() * newScale
	local scaledSizeY = mainFrame:GetHeight() * newScale

	scrollFrame.maxX = (scaledSizeX - mainFrame:GetWidth()) / newScale
	scrollFrame.maxY = (scaledSizeY - mainFrame:GetHeight()) / newScale
	scrollFrame.zoomedIn = abs(newScale - 1) > 0.02

	local cursorX,cursorY = GetCursorPosition()
	local frameX = (cursorX / UIParent:GetScale()) - scrollFrame:GetLeft();
	local frameY = scrollFrame:GetTop() - (cursorY / UIParent:GetScale());

	local scaleChange = newScale / oldScale
	local newScrollH =  (scaleChange * frameX - frameX) / newScale + oldScrollH
	local newScrollV =  (scaleChange * frameY - frameY) / newScale + oldScrollV

	newScrollH = min(newScrollH, scrollFrame.maxX);
	newScrollH = max(0, newScrollH);
	newScrollV = min(newScrollV, scrollFrame.maxY);
	newScrollV = max(0, newScrollV);

	scrollFrame:SetHorizontalScroll(newScrollH);
	scrollFrame:SetVerticalScroll(newScrollV);

end


---ActivatePullTooltip
---
function MethodDungeonTools:ActivatePullTooltip(pull)
    local pullTooltip = MethodDungeonTools.pullTooltip
    --[[
    if not pullTooltip.ranOnce then
        --fix elvui skinning
        pullTooltip:SetPoint("TOPRIGHT",UIParent,"BOTTOMRIGHT")
        pullTooltip:SetPoint("BOTTOMRIGHT",UIParent,"BOTTOMRIGHT")
        pullTooltip:Show()
        pullTooltip.ranOnce = true
    end
    ]]
    pullTooltip.currentPull = pull
    pullTooltip:Show()
end

---UpdatePullTooltip
---Updates the tooltip which is being displayed when a pull is mouseovered
function MethodDungeonTools:UpdatePullTooltip(tooltip)
    local frame = MethodDungeonTools.main_frame
	if not MouseIsOver(frame.sidePanel.pullButtonsScrollFrame.frame) then
        tooltip:Hide()
    elseif MouseIsOver(frame.sidePanel.newPullButton.frame) then
        tooltip:Hide()
	else
		if frame.sidePanel.newPullButtons and tooltip.currentPull and frame.sidePanel.newPullButtons[tooltip.currentPull] then
			for k,v in pairs(frame.sidePanel.newPullButtons[tooltip.currentPull].enemyPortraits) do
				if MouseIsOver(v) then
					if v:IsShown() then
                        --model
						if v.enemyData.displayId and (not tooltip.modelNpcId or (tooltip.modelNpcId ~= v.enemyData.displayId)) then
							tooltip.Model:SetDisplayInfo(v.enemyData.displayId)
							tooltip.modelNpcId = v.enemyData.displayId
						end
						tooltip.Model:Show()
                        --topString
                        local newLine = "\n"
                        local text = newLine..newLine..newLine..v.enemyData.name.." x"..v.enemyData.quantity..newLine
                        text = text.."Level "..v.enemyData.level.." "..v.enemyData.creatureType..newLine
                        --ViragDevTool_AddData(v.enemyData)
                        local boss = v.enemyData.isBoss or false
                        local health = MethodDungeonTools:CalculateEnemyHealth(boss,v.enemyData.baseHealth,db.currentDifficulty)
                        text = text..MethodDungeonTools:FormatEnemyHealth(health).." HP"..newLine

                        local totalForcesMax = MethodDungeonTools:IsCurrentPresetTeeming() and MethodDungeonTools.dungeonTotalCount[db.currentDungeonIdx].teeming or MethodDungeonTools.dungeonTotalCount[db.currentDungeonIdx].normal
                        text = text.."Forces: "..MethodDungeonTools:FormatEnemyForces(v.enemyData.count,totalForcesMax,false)

                        tooltip.topString:SetText(text)
                        tooltip.topString:Show()

					else
                        --model
						tooltip.Model:Hide()
                        --topString
                        tooltip.topString:Hide()
					end
					break;
				end
			end
            local countEnemies = 0
            for k,v in pairs(frame.sidePanel.newPullButtons[tooltip.currentPull].enemyPortraits) do
                if v:IsShown() then countEnemies = countEnemies + 1 end
            end
            if countEnemies == 0 then
                tooltip:Hide()
                return
            end
            local pullForces = MethodDungeonTools:CountForces(tooltip.currentPull,true)
            local totalForces = MethodDungeonTools:CountForces(tooltip.currentPull,false)
            local totalForcesMax = MethodDungeonTools:IsCurrentPresetTeeming() and MethodDungeonTools.dungeonTotalCount[db.currentDungeonIdx].teeming or MethodDungeonTools.dungeonTotalCount[db.currentDungeonIdx].normal

            local text = "Forces: "..MethodDungeonTools:FormatEnemyForces(pullForces,totalForcesMax,false)
            text = text.. "\nTotal :"..MethodDungeonTools:FormatEnemyForces(totalForces,totalForcesMax,true)

            tooltip.botString:SetText(text)
            tooltip.botString:Show()
		end
	end
end

---CountForces
---Counts total selected enemy forces in the current preset up to pull
function MethodDungeonTools:CountForces(currentPull,currentOnly)
    --count up to and including the currently selected pull
    currentPull = currentPull or 1000
    local preset = db.presets[db.currentDungeonIdx][db.currentPreset[db.currentDungeonIdx]]
    local pullCurrent = 0
    for pullIdx,pull in pairs(preset.value.pulls) do
        if not currentOnly or (currentOnly and pullIdx == currentPull) then
            if pullIdx <= currentPull then
                for enemyIdx,clones in pairs(pull) do
                    for k,v in pairs(clones) do
                        local isCloneBlacktoothEvent = MethodDungeonTools.dungeonEnemies[db.currentDungeonIdx][enemyIdx]["clones"][v].blacktoothEvent
                        local week = preset.week%3
                        if week == 0 then week = 3 end
                        local isBlacktoothWeek = week == 1
                        local cloneFaction = MethodDungeonTools.dungeonEnemies[db.currentDungeonIdx][enemyIdx]["clones"][v].faction

                        if not isCloneBlacktoothEvent or isBlacktoothWeek then
                            if not (cloneFaction and cloneFaction~= preset.faction) then
                                local isCloneTeeming = MethodDungeonTools.dungeonEnemies[db.currentDungeonIdx][enemyIdx]["clones"][v].teeming
                                local isCloneNegativeTeeming = MethodDungeonTools.dungeonEnemies[db.currentDungeonIdx][enemyIdx]["clones"][v].negativeTeeming
                                if MethodDungeonTools:IsCurrentPresetTeeming() or ((isCloneTeeming and isCloneTeeming == false) or (not isCloneTeeming)) then
                                    if not(MethodDungeonTools:IsCurrentPresetTeeming() and isCloneNegativeTeeming) then
                                        pullCurrent = pullCurrent + MethodDungeonTools.dungeonEnemies[db.currentDungeonIdx][enemyIdx].count
                                    end
                                end
                            end
                        end
                    end
                end
            else
                break
            end
        end
    end
    return pullCurrent
end

---IsCurrentPresetTeeming
---Returns true if the current preset has teeming turned on, false otherwise
function MethodDungeonTools:IsCurrentPresetTeeming()
    --return self:GetCurrentPreset().week
    return db.presets[db.currentDungeonIdx][db.currentPreset[db.currentDungeonIdx]].value.teeming
end

---IsCurrentPresetFortified
function MethodDungeonTools:IsCurrentPresetFortified()
    return self:GetCurrentPreset().week%2 == 0
end

---IsCurrentPresetTyrannical
function MethodDungeonTools:IsCurrentPresetTyrannical()
    return self:GetCurrentPreset().week%2 == 1
end

---MethodDungeonTools.OnMouseDown
---Handles mouse-down events on the map scrollframe
MethodDungeonTools.OnMouseDown = function(self,button)
	local scrollFrame = MethodDungeonTools.main_frame.scrollFrame
	if scrollFrame.zoomedIn then
		scrollFrame.panning = true;
		scrollFrame.cursorX,scrollFrame.cursorY = GetCursorPosition()
	end
end

--local here to be used for dev context menu
local cursorX, cursorY
---MethodDungeonTools.OnMouseUp
---handles mouse-up events on the map scrollframe
MethodDungeonTools.OnMouseUp = function(self,button)
	local scrollFrame = MethodDungeonTools.main_frame.scrollFrame
	--local frame = MethodDungeonTools.main_frame
    --frame.contextDropdown:Hide()
    if scrollFrame.panning then scrollFrame.panning = false end
        --cursorX, cursorY = GetCursorPosition()
        --L_EasyMenu(MethodDungeonTools.contextMenuList, frame.contextDropdown, "cursor", 0 , -15, "MENU",5)
        --frame.contextDropdown:Show()
        --dont need context menu for now

end

---SetCurrentSubLevel
---Sets the sublevel of the currently active preset, need to UpdateMap to reflect the change in UI
function MethodDungeonTools:SetCurrentSubLevel(sublevel)
    MethodDungeonTools:GetCurrentPreset().value.currentSublevel = sublevel
end

---GetCurrentPull
---Returns the current pull of the currently active preset
function MethodDungeonTools:GetCurrentPull()
    return MethodDungeonTools:GetCurrentPreset().value.currentPull
end

---GetCurrentSubLevel
---Returns the sublevel of the currently active preset
function MethodDungeonTools:GetCurrentSubLevel()
	return MethodDungeonTools:GetCurrentPreset().value.currentSublevel
end

---GetCurrentPreset
---Returns the current preset
function MethodDungeonTools:GetCurrentPreset()
    return db.presets[db.currentDungeonIdx][db.currentPreset[db.currentDungeonIdx]]
end

---GetCurrentTeeming
---Returns if the current week has an affix week set that inlcludes the teeming affix
function MethodDungeonTools:IsWeekTeeming(week)
    if not week then week = MethodDungeonTools:GetCurrentAffixWeek() or 1 end
    return week == 2 or week == 6 or week == 9
end

---IsPresetTeeming
---Returns if the preset is set to a week which contains the teeming affix
function MethodDungeonTools:IsPresetTeeming(preset)
    return MethodDungeonTools:IsWeekTeeming(preset.week)
end


function MethodDungeonTools:MakeMapTexture(frame)
    MethodDungeonTools.contextMenuList = {}

    tinsert(MethodDungeonTools.contextMenuList, {
        text = "Close",
        notCheckable = 1,
        func = frame.contextDropdown:Hide()
    })

	-- Scroll Frame
	if frame.scrollFrame == nil then
		frame.scrollFrame = CreateFrame("ScrollFrame", "MethodDungeonToolsScrollFrame",frame)
		frame.scrollFrame:ClearAllPoints();
		frame.scrollFrame:SetSize(840, 555);
		frame.scrollFrame:SetPoint("BOTTOM", frame, "BOTTOM", 0, 0);

		-- Enable mousewheel scrolling
		frame.scrollFrame:EnableMouseWheel(true)
		frame.scrollFrame:SetScript("OnMouseWheel", function(self, delta)
            MethodDungeonTools:ZoomMap(delta)
		end)

		--PAN
		frame.scrollFrame:EnableMouse(true)
		frame.scrollFrame:SetScript("OnMouseDown", MethodDungeonTools.OnMouseDown)
		frame.scrollFrame:SetScript("OnMouseUp", MethodDungeonTools.OnMouseUp)


		frame.scrollFrame:SetScript("OnUpdate", function(self)
			if (MethodDungeonTools.main_frame.scrollFrame.panning) then
				local x, y = GetCursorPosition();
				MethodDungeonTools:OnPan(x, y);
			end
        end)

		if frame.mapPanelFrame == nil then
			frame.mapPanelFrame = CreateFrame("frame","MethodDungeonToolsMapPanelFrame",nil)
			frame.mapPanelFrame:ClearAllPoints();
			frame.mapPanelFrame:SetSize(frame:GetWidth(), frame:GetHeight());
			frame.mapPanelFrame:SetPoint("BOTTOM", frame, "BOTTOM", 0, 0);

		end

		--create the 12 tiles and set the scrollchild
		for i=1,12 do
			frame["mapPanelTile"..i] = frame.mapPanelFrame:CreateTexture("MethodDungeonToolsmapPanelTile"..i, "BACKGROUND");
			frame["mapPanelTile"..i]:SetDrawLayer(canvasDrawLayer, 0);
			--frame["mapPanelTile"..i]:SetAlpha(0.3)
			frame["mapPanelTile"..i]:SetSize(frame:GetWidth()/4+4,frame:GetWidth()/4+4)
		end
		frame.mapPanelTile1:SetPoint("TOPLEFT",frame.mapPanelFrame,"TOPLEFT",1,0)
		frame.mapPanelTile2:SetPoint("TOPLEFT",frame.mapPanelTile1,"TOPRIGHT")
		frame.mapPanelTile3:SetPoint("TOPLEFT",frame.mapPanelTile2,"TOPRIGHT")
		frame.mapPanelTile4:SetPoint("TOPLEFT",frame.mapPanelTile3,"TOPRIGHT")
		frame.mapPanelTile5:SetPoint("TOPLEFT",frame.mapPanelTile1,"BOTTOMLEFT")
		frame.mapPanelTile6:SetPoint("TOPLEFT",frame.mapPanelTile5,"TOPRIGHT")
		frame.mapPanelTile7:SetPoint("TOPLEFT",frame.mapPanelTile6,"TOPRIGHT")
		frame.mapPanelTile8:SetPoint("TOPLEFT",frame.mapPanelTile7,"TOPRIGHT")
		frame.mapPanelTile9:SetPoint("TOPLEFT",frame.mapPanelTile5,"BOTTOMLEFT")
		frame.mapPanelTile10:SetPoint("TOPLEFT",frame.mapPanelTile9,"TOPRIGHT")
		frame.mapPanelTile11:SetPoint("TOPLEFT",frame.mapPanelTile10,"TOPRIGHT")
		frame.mapPanelTile12:SetPoint("TOPLEFT",frame.mapPanelTile11,"TOPRIGHT")
		frame.scrollFrame:SetScrollChild(frame.mapPanelFrame)
	end

end

local function round(number, decimals)
    return (("%%.%df"):format(decimals)):format(number)
end
function MethodDungeonTools:CalculateEnemyHealth(boss,baseHealth,level)
    local fortified = MethodDungeonTools:IsCurrentPresetFortified()
    local tyrannical = MethodDungeonTools:IsCurrentPresetTyrannical()
	local mult = 1
	if boss == false and fortified == true then mult = 1.2 end
	if boss == true and tyrannical == true then mult = 1.4 end
	mult = round((1.08^(level-2))*mult,2)
	return round(mult*baseHealth,0)
end

function MethodDungeonTools:FormatEnemyHealth(amount)
	amount = tonumber(amount)
    if not amount then return "" end
    if amount < 1e3 then
        return 0
    elseif amount >= 1e12 then
        return string.format("%.3ft", amount/1e12)
    elseif amount >= 1e9 then
        return string.format("%.3fb", amount/1e9)
    elseif amount >= 1e6 then
        return string.format("%.2fm", amount/1e6)
    elseif amount >= 1e3 then
        return string.format("%.1fk", amount/1e3)
    end
end







function MethodDungeonTools:UpdateDungeonEnemies()
    MethodDungeonTools:DungeonEnemies_UpdateEnemies()
end

function MethodDungeonTools:HideAllDialogs()
	MethodDungeonTools.main_frame.presetCreationFrame:Hide()
	MethodDungeonTools.main_frame.presetImportFrame:Hide()
	MethodDungeonTools.main_frame.ExportFrame:Hide()
	MethodDungeonTools.main_frame.RenameFrame:Hide()
	MethodDungeonTools.main_frame.ClearConfirmationFrame:Hide()
	MethodDungeonTools.main_frame.DeleteConfirmationFrame:Hide()
end

function MethodDungeonTools:OpenImportPresetDialog()
	MethodDungeonTools:HideAllDialogs()
	MethodDungeonTools.main_frame.presetImportFrame:SetPoint("CENTER",MethodDungeonTools.main_frame,"CENTER",0,50)
	MethodDungeonTools.main_frame.presetImportFrame:Show()
	MethodDungeonTools.main_frame.presetImportBox:SetText("")
	MethodDungeonTools.main_frame.presetImportBox:SetFocus()
    MethodDungeonTools.main_frame.presetImportLabel:SetText(nil)
end

function MethodDungeonTools:OpenNewPresetDialog()
	MethodDungeonTools:HideAllDialogs()
	local presetList = {}
	local countPresets = 0
	for k,v in pairs(db.presets[db.currentDungeonIdx]) do
		if v.text ~= "<New Preset>" then
			table.insert(presetList,k,v.text)
			countPresets=countPresets+1
		end
	end
	table.insert(presetList,1,"Empty")
	MethodDungeonTools.main_frame.PresetCreationDropDown:SetList(presetList)
	MethodDungeonTools.main_frame.PresetCreationDropDown:SetValue(1)
	MethodDungeonTools.main_frame.PresetCreationEditbox:SetText("Preset "..countPresets+1)
	MethodDungeonTools.main_frame.presetCreationFrame:SetPoint("CENTER",MethodDungeonTools.main_frame,"CENTER",0,50)
	MethodDungeonTools.main_frame.presetCreationFrame:SetStatusText("")
	MethodDungeonTools.main_frame.presetCreationFrame:Show()
	MethodDungeonTools.main_frame.presetCreationCreateButton:SetDisabled(false)
	MethodDungeonTools.main_frame.PresetCreationEditbox:SetFocus()
	MethodDungeonTools.main_frame.PresetCreationEditbox:HighlightText(0,50)
	MethodDungeonTools.main_frame.presetImportBox:SetText("")
end

function MethodDungeonTools:OpenClearPresetDialog()
    MethodDungeonTools:HideAllDialogs()
    MethodDungeonTools.main_frame.ClearConfirmationFrame:SetPoint("CENTER",MethodDungeonTools.main_frame,"CENTER",0,50)
    local currentPresetName = db.presets[db.currentDungeonIdx][db.currentPreset[db.currentDungeonIdx]].text
    MethodDungeonTools.main_frame.ClearConfirmationFrame.label:SetText("Clear "..currentPresetName.."?")
    MethodDungeonTools.main_frame.ClearConfirmationFrame:Show()
end


function MethodDungeonTools:UpdateDungeonDropDown()
	local group = MethodDungeonTools.main_frame.DungeonSelectionGroup
    group.DungeonDropdown:SetList({})
    if db.currentExpansion == 1 then
        for i=1,14 do
            group.DungeonDropdown:AddItem(i,dungeonList[i])
        end
    elseif db.currentExpansion == 2 then
        for i=15,25 do
            group.DungeonDropdown:AddItem(i,dungeonList[i])
        end
    end
	group.DungeonDropdown:SetValue(db.currentDungeonIdx)
	group.SublevelDropdown:SetList(dungeonSubLevels[db.currentDungeonIdx])
	group.SublevelDropdown:SetValue(db.presets[db.currentDungeonIdx][db.currentPreset[db.currentDungeonIdx]].value.currentSublevel)
end

---CreateDungeonSelectDropdown
---Creates both dungeon and sublevel dropdowns
function MethodDungeonTools:CreateDungeonSelectDropdown(frame)
	--Simple Group to hold both dropdowns
	frame.DungeonSelectionGroup = AceGUI:Create("SimpleGroup")
	local group = frame.DungeonSelectionGroup
    group.frame:SetFrameStrata("HIGH")
    group.frame:SetFrameLevel(50)
	group:SetWidth(200);
	group:SetHeight(50);
	group:SetPoint("TOPLEFT",frame.topPanel,"BOTTOMLEFT",0,2)
    group:SetLayout("List")

    MethodDungeonTools:FixAceGUIShowHide(group)

    --dungeon select
	group.DungeonDropdown = AceGUI:Create("Dropdown")
	group.DungeonDropdown.text:SetJustifyH("LEFT")
	group.DungeonDropdown:SetCallback("OnValueChanged",function(widget,callbackName,key)
		if key==14 or key == 25 then
            db.currentExpansion = (db.currentExpansion%2)+1
            db.currentDungeonIdx = key==14 and 15 or 1
            MethodDungeonTools:UpdateDungeonDropDown()
            MethodDungeonTools:UpdateToDungeon(db.currentDungeonIdx)
		else
            MethodDungeonTools:UpdateToDungeon(key)
		end
	end)
	group:AddChild(group.DungeonDropdown)

	--sublevel select
	group.SublevelDropdown = AceGUI:Create("Dropdown")
	group.SublevelDropdown.text:SetJustifyH("LEFT")
	group.SublevelDropdown:SetCallback("OnValueChanged",function(widget,callbackName,key)
		db.presets[db.currentDungeonIdx][db.currentPreset[db.currentDungeonIdx]].value.currentSublevel = key
		MethodDungeonTools:UpdateMap()
        MethodDungeonTools:ZoomMap(1,true)
	end)
	group:AddChild(group.SublevelDropdown)

	MethodDungeonTools:UpdateDungeonDropDown()
end

---EnsureDBTables
---Makes sure profiles are valid and have their fields set
function MethodDungeonTools:EnsureDBTables()
    local preset = MethodDungeonTools:GetCurrentPreset()
    preset.week = preset.week or MethodDungeonTools:GetCurrentAffixWeek()
	db.currentPreset[db.currentDungeonIdx] = db.currentPreset[db.currentDungeonIdx] or 1
    db.presets[db.currentDungeonIdx][db.currentPreset[db.currentDungeonIdx]].value.currentDungeonIdx = db.currentDungeonIdx
	db.presets[db.currentDungeonIdx][db.currentPreset[db.currentDungeonIdx]].value.currentSublevel = db.presets[db.currentDungeonIdx][db.currentPreset[db.currentDungeonIdx]].value.currentSublevel or 1
	db.presets[db.currentDungeonIdx][db.currentPreset[db.currentDungeonIdx]].value.currentPull = db.presets[db.currentDungeonIdx][db.currentPreset[db.currentDungeonIdx]].value.currentPull or 1
	db.presets[db.currentDungeonIdx][db.currentPreset[db.currentDungeonIdx]].value.pulls = db.presets[db.currentDungeonIdx][db.currentPreset[db.currentDungeonIdx]].value.pulls or {}
	db.presets[db.currentDungeonIdx][db.currentPreset[db.currentDungeonIdx]].value.pulls[db.presets[db.currentDungeonIdx][db.currentPreset[db.currentDungeonIdx]].value.currentPull] = db.presets[db.currentDungeonIdx][db.currentPreset[db.currentDungeonIdx]].value.pulls[db.presets[db.currentDungeonIdx][db.currentPreset[db.currentDungeonIdx]].value.currentPull] or {}

	for k,v in pairs(db.presets[db.currentDungeonIdx][db.currentPreset[db.currentDungeonIdx]].value.pulls) do
		if k ==0  then
			db.presets[db.currentDungeonIdx][db.currentPreset[db.currentDungeonIdx]].value.pulls[0] = nil
			break;
		end
	end

    --removed clones: remove data from presets
    for pullIdx,pull in pairs(preset.value.pulls) do
        for enemyIdx,clones in pairs(pull) do
            for k,v in pairs(clones) do
                if not MethodDungeonTools.dungeonEnemies[db.currentDungeonIdx][enemyIdx]["clones"][v] then
                    clones[k] = nil
                end
            end
        end
    end

    MethodDungeonTools:GetCurrentPreset().week = MethodDungeonTools:GetCurrentPreset().week or MethodDungeonTools:GetCurrentAffixWeek()

    if db.currentDungeonIdx == 19 then
        local englishFaction = UnitFactionGroup("player")
        preset.faction  = preset.faction or (englishFaction and englishFaction=="Alliance") and 2 or 1
    end

    if db.currentDungeonIdx == 16 and (not preset.freeholdCrewSelected) then
        local week = preset.week
        week = week%3
        if week == 0 then week = 3 end
        preset.freeholdCrew = week
        preset.freeholdCrewSelected = true
    end

end



function MethodDungeonTools:UpdateMap(ignoreSetSelection,ignoreReloadPullButtons,ignoreUpdateProgressBar)
	local mapName
	local frame = MethodDungeonTools.main_frame
	mapName = MethodDungeonTools.dungeonMaps[db.currentDungeonIdx][0]
	MethodDungeonTools:EnsureDBTables()
	local fileName = MethodDungeonTools.dungeonMaps[db.currentDungeonIdx][db.presets[db.currentDungeonIdx][db.currentPreset[db.currentDungeonIdx]].value.currentSublevel]
	local path = "Interface\\WorldMap\\"..mapName.."\\";
	for i=1,12 do
		local texName = path..fileName..i;
		if frame["mapPanelTile"..i] then
			frame["mapPanelTile"..i]:SetTexture(texName)
		end
	end
	MethodDungeonTools:UpdateDungeonEnemies()
	if not ignoreReloadPullButtons then
		MethodDungeonTools:ReloadPullButtons()
	end
	--handle delete button disable/enable
	local presetCount = 0
	for k,v in pairs(db.presets[db.currentDungeonIdx]) do
		presetCount = presetCount + 1
	end
	if db.currentPreset[db.currentDungeonIdx] == 1 or db.currentPreset[db.currentDungeonIdx] == presetCount then
		MethodDungeonTools.main_frame.sidePanelDeleteButton:SetDisabled(true)
	else
		MethodDungeonTools.main_frame.sidePanelDeleteButton:SetDisabled(false)
	end

	if not ignoreSetSelection then MethodDungeonTools:SetSelectionToPull(db.presets[db.currentDungeonIdx][db.currentPreset[db.currentDungeonIdx]].value.currentPull) end
	MethodDungeonTools:UpdateDungeonDropDown()
    frame.sidePanel.affixDropdown:SetAffixWeek(MethodDungeonTools:GetCurrentPreset().week,ignoreReloadPullButtons,ignoreUpdateProgressBar)
    MethodDungeonTools:POI_UpdateAll()
    MethodDungeonTools:ToggleFreeholdSelector(db.currentDungeonIdx == 16)
    MethodDungeonTools:ToggleBoralusSelector(db.currentDungeonIdx == 19)
    MethodDungeonTools:DrawAllPresetObjects()
end

---UpdateToDungeon
---Updates the map to the specified dungeon
function MethodDungeonTools:UpdateToDungeon(dungeonIdx)
    db.currentDungeonIdx = dungeonIdx
	if not db.presets[db.currentDungeonIdx][db.currentPreset[db.currentDungeonIdx]].value.currentSublevel then db.presets[db.currentDungeonIdx][db.currentPreset[db.currentDungeonIdx]].value.currentSublevel=1 end
	MethodDungeonTools:UpdatePresetDropDown()
	MethodDungeonTools:UpdateMap()
    MethodDungeonTools:ZoomMap(1,true)
end

function MethodDungeonTools:DeletePreset(index)
	tremove(db.presets[db.currentDungeonIdx],index)
	db.currentPreset[db.currentDungeonIdx] = index-1
	MethodDungeonTools:UpdatePresetDropDown()
	MethodDungeonTools:UpdateMap()
end

function MethodDungeonTools:ClearPreset(index)
	table.wipe(db.presets[db.currentDungeonIdx][index].value.pulls)
	db.presets[db.currentDungeonIdx][index].value.currentPull = 1
	--MethodDungeonTools:DeleteAllPresetObjects()
	MethodDungeonTools:EnsureDBTables()
	MethodDungeonTools:UpdateMap()
	MethodDungeonTools:ReloadPullButtons()
end

function MethodDungeonTools:CreateNewPreset(name)
	if name == "<New Preset>" then
		MethodDungeonTools.main_frame.presetCreationLabel:SetText("Cannot create preset '"..name.."'")
		MethodDungeonTools.main_frame.presetCreationCreateButton:SetDisabled(true)
		MethodDungeonTools.main_frame.presetCreationFrame:DoLayout()
		return
	end
	local duplicate = false
	local countPresets = 0
	for k,v in pairs(db.presets[db.currentDungeonIdx]) do
		countPresets = countPresets + 1
		if v.text == name then duplicate = true end
	end
	if duplicate == false then
		db.presets[db.currentDungeonIdx][countPresets+1] = db.presets[db.currentDungeonIdx][countPresets] --put <New Preset> at the end of the list

		local startingPointPresetIdx = MethodDungeonTools.main_frame.PresetCreationDropDown:GetValue()-1
		if startingPointPresetIdx>0 then
			db.presets[db.currentDungeonIdx][countPresets] = MethodDungeonTools:CopyObject(db.presets[db.currentDungeonIdx][startingPointPresetIdx])
			db.presets[db.currentDungeonIdx][countPresets].text = name
		else
			db.presets[db.currentDungeonIdx][countPresets] = {text=name,value={}}
		end

		db.currentPreset[db.currentDungeonIdx] = countPresets
		MethodDungeonTools.main_frame.presetCreationFrame:Hide()
		MethodDungeonTools:UpdatePresetDropDown()
		MethodDungeonTools:UpdateMap()
	else
		MethodDungeonTools.main_frame.presetCreationLabel:SetText("'"..name.."' already exists.")
		MethodDungeonTools.main_frame.presetCreationCreateButton:SetDisabled(true)
		MethodDungeonTools.main_frame.presetCreationFrame:DoLayout()
	end
end



function MethodDungeonTools:SanitizePresetName(text)
	--check if name is valid, block button if so, unblock if valid
	if text == "<New Preset>" then
		return false
	else
		local duplicate = false
		local countPresets = 0
		for k,v in pairs(db.presets[db.currentDungeonIdx]) do
			countPresets = countPresets + 1
			if v.text == text then duplicate = true end
		end
		return not duplicate and text or false
	end
end


function MethodDungeonTools:MakeChatPresetImportFrame(frame)
    frame.chatPresetImportFrame = AceGUI:Create("Frame")
    local chatImport = frame.chatPresetImportFrame
    chatImport:SetTitle("Import Preset")
    chatImport:SetWidth(400)
    chatImport:SetHeight(100)
    chatImport:EnableResize(false)
    chatImport:SetLayout("Flow")
    chatImport:SetCallback("OnClose", function(widget)
        MethodDungeonTools:UpdatePresetDropDown()
        if db.currentPreset[db.currentDungeonIdx] ~= 1 then
            MethodDungeonTools.main_frame.sidePanelDeleteButton:SetDisabled(false)
        end
    end)
    chatImport.defaultText = "Import Preset:\n"
    chatImport.importLabel = AceGUI:Create("Label")
    chatImport.importLabel:SetText(chatImport.defaultText)
    chatImport.importLabel:SetWidth(250)
    --chatImport.importLabel:SetColor(1,0,0)


    local importButton = AceGUI:Create("Button")
    importButton:SetText("Import")
    importButton:SetWidth(100)
    importButton:SetCallback("OnClick", function()
        local newPreset = chatImport.currentPreset
        if MethodDungeonTools:ValidateImportPreset(newPreset) then
            chatImport:Hide()
            MethodDungeonTools:ImportPreset(MethodDungeonTools:DeepCopy(newPreset))
        else
            print("MDT: Error importing preset report to author")
        end
    end)
    chatImport:AddChild(chatImport.importLabel)
    chatImport:AddChild(importButton)
    chatImport:Hide()

end

function MethodDungeonTools:OpenChatImportPresetDialog(sender,preset)
    MethodDungeonTools:HideAllDialogs()
    local chatImport = MethodDungeonTools.main_frame.chatPresetImportFrame
    chatImport:SetPoint("CENTER",MethodDungeonTools.main_frame,"CENTER",0,50)
    chatImport.currentPreset = preset
    local dungeon = MethodDungeonTools:GetDungeonName(preset.value.currentDungeonIdx)
    local name = preset.text
    chatImport.importLabel:SetText(chatImport.defaultText..sender.. ": "..dungeon.." - "..name)
    chatImport:Show()
end

function MethodDungeonTools:MakePresetImportFrame(frame)
	frame.presetImportFrame = AceGUI:Create("Frame")
	frame.presetImportFrame:SetTitle("Import Preset")
	frame.presetImportFrame:SetWidth(400)
	frame.presetImportFrame:SetHeight(200)
	frame.presetImportFrame:EnableResize(false)
	--frame.presetCreationFrame:SetCallback("OnClose", function(widget) AceGUI:Release(widget) end)
	frame.presetImportFrame:SetLayout("Flow")
	frame.presetImportFrame:SetCallback("OnClose", function(widget)
		MethodDungeonTools:UpdatePresetDropDown()
		if db.currentPreset[db.currentDungeonIdx] ~= 1 then
			MethodDungeonTools.main_frame.sidePanelDeleteButton:SetDisabled(false)
		end
	end)

	frame.presetImportLabel = AceGUI:Create("Label")
	frame.presetImportLabel:SetText(nil)
	frame.presetImportLabel:SetWidth(390)
	frame.presetImportLabel:SetColor(1,0,0)

	local importString	= ""
	frame.presetImportBox = AceGUI:Create("EditBox")
	frame.presetImportBox:SetLabel("Import Preset:")
	frame.presetImportBox:SetWidth(255)
	frame.presetImportBox:SetCallback("OnEnterPressed", function(widget, event, text) importString = text end)
	frame.presetImportFrame:AddChild(frame.presetImportBox)

	local importButton = AceGUI:Create("Button")
	importButton:SetText("Import")
	importButton:SetWidth(100)
	importButton:SetCallback("OnClick", function()
		local newPreset = MethodDungeonTools:StringToTable(importString, true)
		if MethodDungeonTools:ValidateImportPreset(newPreset) then
			MethodDungeonTools.main_frame.presetImportFrame:Hide()
			MethodDungeonTools:ImportPreset(newPreset)
		else
			frame.presetImportLabel:SetText("Invalid import string")
		end
	end)
	frame.presetImportFrame:AddChild(importButton)
	frame.presetImportFrame:AddChild(frame.presetImportLabel)
	frame.presetImportFrame:Hide()

end

function MethodDungeonTools:MakePresetCreationFrame(frame)
	frame.presetCreationFrame = AceGUI:Create("Frame")
	frame.presetCreationFrame:SetTitle("New Preset")
	frame.presetCreationFrame:SetWidth(400)
	frame.presetCreationFrame:SetHeight(200)
	frame.presetCreationFrame:EnableResize(false)
	--frame.presetCreationFrame:SetCallback("OnClose", function(widget) AceGUI:Release(widget) end)
	frame.presetCreationFrame:SetLayout("Flow")
	frame.presetCreationFrame:SetCallback("OnClose", function(widget)
		MethodDungeonTools:UpdatePresetDropDown()
		if db.currentPreset[db.currentDungeonIdx] ~= 1 then
			MethodDungeonTools.main_frame.sidePanelDeleteButton:SetDisabled(false)
		end
	end)


	frame.PresetCreationEditbox = AceGUI:Create("EditBox")
	frame.PresetCreationEditbox:SetLabel("Preset name:")
	frame.PresetCreationEditbox:SetWidth(255)
	frame.PresetCreationEditbox:SetCallback("OnEnterPressed", function(widget, event, text)
		--check if name is valid, block button if so, unblock if valid
		if MethodDungeonTools:SanitizePresetName(text) then
			frame.presetCreationLabel:SetText(nil)
			frame.presetCreationCreateButton:SetDisabled(false)
		else
			frame.presetCreationLabel:SetText("Cannot create preset '"..text.."'")
			frame.presetCreationCreateButton:SetDisabled(true)
		end
		frame.presetCreationFrame:DoLayout()
	end)
	frame.presetCreationFrame:AddChild(frame.PresetCreationEditbox)

	frame.presetCreationCreateButton = AceGUI:Create("Button")
	frame.presetCreationCreateButton:SetText("Create")
	frame.presetCreationCreateButton:SetWidth(100)
	frame.presetCreationCreateButton:SetCallback("OnClick", function()
		local name = frame.PresetCreationEditbox:GetText()
		MethodDungeonTools:CreateNewPreset(name)
	end)
	frame.presetCreationFrame:AddChild(frame.presetCreationCreateButton)

	frame.presetCreationLabel = AceGUI:Create("Label")
	frame.presetCreationLabel:SetText(nil)
	frame.presetCreationLabel:SetWidth(390)
	frame.presetCreationLabel:SetColor(1,0,0)
	frame.presetCreationFrame:AddChild(frame.presetCreationLabel)


	frame.PresetCreationDropDown = AceGUI:Create("Dropdown")
	frame.PresetCreationDropDown:SetLabel("Use as a starting point:")
	frame.PresetCreationDropDown.text:SetJustifyH("LEFT")
	frame.presetCreationFrame:AddChild(frame.PresetCreationDropDown)

	frame.presetCreationFrame:Hide()
end

function MethodDungeonTools:ValidateImportPreset(preset)
    if type(preset) ~= "table" then return false end
    if not preset.text then return false end
    if not preset.value then return false end
    if type(preset.text) ~= "string" then return false end
    if type(preset.value) ~= "table" then return false end
    if not preset.value.currentDungeonIdx then return false end
    if not preset.value.currentPull then return false end
    if not preset.value.currentSublevel then return false end
    if not preset.value.pulls then return false end
    if type(preset.value.pulls) ~= "table" then return false end
    return true
end

function MethodDungeonTools:ImportPreset(preset)
    --change dungeon to dungeon of the new preset
    MethodDungeonTools:UpdateToDungeon(preset.value.currentDungeonIdx)
	local name = preset.text
	local num = 2;
	for k,v in pairs(db.presets[db.currentDungeonIdx]) do
		if name == v.text then
			name = preset.text.." "..num
			num = num + 1
		end
	end

	preset.text = name
	local countPresets = 0

	for k,v in pairs(db.presets[db.currentDungeonIdx]) do
		countPresets = countPresets + 1
	end
	db.presets[db.currentDungeonIdx][countPresets+1] = db.presets[db.currentDungeonIdx][countPresets] --put <New Preset> at the end of the list
	db.presets[db.currentDungeonIdx][countPresets] = preset
	db.currentPreset[db.currentDungeonIdx] = countPresets
	MethodDungeonTools:UpdatePresetDropDown()
	MethodDungeonTools:UpdateMap()
end

function MethodDungeonTools:MakePullSelectionButtons(frame)
    frame.PullButtonScrollGroup = AceGUI:Create("SimpleGroup")
    frame.PullButtonScrollGroup:SetWidth(249);
    frame.PullButtonScrollGroup:SetHeight(410)
    frame.PullButtonScrollGroup:SetPoint("TOPLEFT",frame.WidgetGroup.frame,"BOTTOMLEFT",-4,-32)
    frame.PullButtonScrollGroup:SetPoint("BOTTOMRIGHT",frame,"BOTTOMRIGHT",0,30)
    frame.PullButtonScrollGroup:SetLayout("Fill")
    frame.PullButtonScrollGroup.frame:SetFrameStrata(mainFrameStrata)
    frame.PullButtonScrollGroup.frame:SetBackdropColor(1,1,1,0)
    frame.PullButtonScrollGroup.frame:Show()

    MethodDungeonTools:FixAceGUIShowHide(frame.PullButtonScrollGroup)

    frame.pullButtonsScrollFrame = AceGUI:Create("ScrollFrame")
    frame.pullButtonsScrollFrame:SetLayout("Flow")

    frame.PullButtonScrollGroup:AddChild(frame.pullButtonsScrollFrame)

    frame.newPullButtons = {}
	--rightclick context menu
	frame.optionsDropDown = CreateFrame("Frame", "PullButtonsOptionsDropDown", nil, "L_UIDropDownMenuTemplate")
end


function MethodDungeonTools:PresetsAddPull(index, data)
    if not data then
        data = {}
    end

	if index then
		tinsert(MethodDungeonTools:GetCurrentPreset().value.pulls,index,data)
	else
		tinsert(MethodDungeonTools:GetCurrentPreset().value.pulls,data)
	end
end

---MethodDungeonTools:PresetsMergePulls
---Merges a list of pulls and inserts them at a specified destination.
---
---@param pulls table List of all pull indices, that shall be merged (and deleted). If pulls
---                   is a number, then the pull list is automatically generated from pulls
---                   and destination.
---@param destination number The pull index, where the merged pull shall be inserted.
---
---@author Dradux
function MethodDungeonTools:PresetsMergePulls(pulls, destination)
    if type(pulls) == "number" then
        pulls = {pulls, destination}
    end

    if not destination then
        destination = pulls[#pulls]
    end

    local count_if = MethodDungeonTools.U.count_if

    local newPull = {}
    local removed_pulls = {}
    for _, pullIdx in ipairs(pulls) do
        local offset = count_if(removed_pulls, function(entry)
            return entry < pullIdx
        end)

        local index = pullIdx - offset
        local pull = MethodDungeonTools:GetCurrentPreset().value.pulls[index]

        for enemyIdx,clones in pairs(pull) do
            if not newPull[enemyIdx] then
                newPull[enemyIdx] = clones
            else
                for k,v in pairs(clones) do
                    if newPull[enemyIdx][k] ~= nil then
                        local newIndex = #newPull[enemyIdx] + 1
                        newPull[enemyIdx][newIndex] = v
                    else
                        newPull[enemyIdx][k] = v
                    end

                end
            end
        end

        MethodDungeonTools:PresetsDeletePull(index)
        tinsert(removed_pulls, pullIdx)
    end

    local offset = count_if(removed_pulls, function(entry)
        return entry < destination
    end)

    local index = destination - offset
    MethodDungeonTools:PresetsAddPull(index, newPull)
    return index
end

function MethodDungeonTools:PresetsDeletePull(p,j)
	tremove(MethodDungeonTools:GetCurrentPreset().value.pulls,p)
end

function MethodDungeonTools:CopyObject(obj,seen)
    if type(obj) ~= 'table' then return obj end
    if seen and seen[obj] then return seen[obj] end
    local s = seen or {}
    local res = setmetatable({}, getmetatable(obj))
    s[obj] = res
    for k, v in pairs(obj) do res[MethodDungeonTools:CopyObject(k, s)] = MethodDungeonTools:CopyObject(v, s) end
    return res
end

function MethodDungeonTools:PresetsSwapPulls(p1,p2)
	local p1copy = MethodDungeonTools:CopyObject(MethodDungeonTools:GetCurrentPreset().value.pulls[p1])
	local p2copy = MethodDungeonTools:CopyObject(MethodDungeonTools:GetCurrentPreset().value.pulls[p2])
    MethodDungeonTools:GetCurrentPreset().value.pulls[p1] = p2copy
    MethodDungeonTools:GetCurrentPreset().value.pulls[p2] = p1copy
end

function MethodDungeonTools:SetMapSublevel(pull)
	--set map sublevel
	local shouldResetZoom = false
	local lastSubLevel
	for enemyIdx,clones in pairs(db.presets[db.currentDungeonIdx][db.currentPreset[db.currentDungeonIdx]].value.pulls[pull]) do
		for idx,cloneIdx in pairs(clones) do
			if MethodDungeonTools.dungeonEnemies[db.currentDungeonIdx][enemyIdx]["clones"][cloneIdx] then
				lastSubLevel = MethodDungeonTools.dungeonEnemies[db.currentDungeonIdx][enemyIdx]["clones"][cloneIdx].sublevel
			end
		end
	end
	if lastSubLevel then
		shouldResetZoom = db.presets[db.currentDungeonIdx][db.currentPreset[db.currentDungeonIdx]].value.currentSublevel ~= lastSubLevel
		db.presets[db.currentDungeonIdx][db.currentPreset[db.currentDungeonIdx]].value.currentSublevel = lastSubLevel
        if shouldResetZoom then
            MethodDungeonTools:UpdateMap(true,true,true)
        end
	end

	MethodDungeonTools:UpdateDungeonDropDown()
    if shouldResetZoom then MethodDungeonTools:ZoomMap(1,true) end
end


function MethodDungeonTools:SetSelectionToPull(pull)
	--if pull is not specified set pull to last pull in preset (for adding new pulls)
	if not pull then
		local count = 0
		for k,v in pairs(MethodDungeonTools:GetCurrentPreset().value.pulls) do
			count = count + 1
		end
		pull = count
	end
	--SaveCurrentPresetPull
    MethodDungeonTools:GetCurrentPreset().value.currentPull = pull
	MethodDungeonTools:PickPullButton(pull)

    MethodDungeonTools:DungeonEnemies_UpdateSelected(pull)
end


---UpdatePullButtonNPCData
---Updates the portraits display of a button to show which and how many npcs are selected
function MethodDungeonTools:UpdatePullButtonNPCData(idx)
    if db.devMode then return end
	local preset = MethodDungeonTools:GetCurrentPreset()
	local frame = MethodDungeonTools.main_frame.sidePanel
    local teeming = MethodDungeonTools:IsPresetTeeming(preset)
	local enemyTable = {}
	if preset.value.pulls[idx] then
		local enemyTableIdx = 0
		for enemyIdx,clones in pairs(preset.value.pulls[idx]) do
            --check if enemy exists, remove if not
            if not MethodDungeonTools.dungeonEnemies[db.currentDungeonIdx][enemyIdx] then

            else
                local incremented = false
                local npcId = MethodDungeonTools.dungeonEnemies[db.currentDungeonIdx][enemyIdx]["id"]
                local name = MethodDungeonTools.dungeonEnemies[db.currentDungeonIdx][enemyIdx]["name"]
                local creatureType = MethodDungeonTools.dungeonEnemies[db.currentDungeonIdx][enemyIdx]["creatureType"]
                local level = MethodDungeonTools.dungeonEnemies[db.currentDungeonIdx][enemyIdx]["level"]
                local baseHealth = MethodDungeonTools.dungeonEnemies[db.currentDungeonIdx][enemyIdx]["health"]
                for k,cloneIdx in pairs(clones) do
                    --check if clone exists, remove if not
                    if not MethodDungeonTools.dungeonEnemies[db.currentDungeonIdx][enemyIdx]["clones"][cloneIdx] then

                    else
                        --check for teeming
                        local cloneIsTeeming = MethodDungeonTools.dungeonEnemies[db.currentDungeonIdx][enemyIdx]["clones"][cloneIdx].teeming
                        if (cloneIsTeeming and teeming) or (not cloneIsTeeming and not teeming) or (not cloneIsTeeming and teeming) then

                            local isCloneBlacktoothEvent = MethodDungeonTools.dungeonEnemies[db.currentDungeonIdx][enemyIdx]["clones"][cloneIdx].blacktoothEvent
                            local continue = false
                            local week = preset.week%3
                            if week == 0 then week = 3 end
                            local isBlacktoothWeek = week == 1
                            if isCloneBlacktoothEvent then
                                if isBlacktoothWeek then
                                    continue = true
                                end
                            else
                                continue = true
                            end

                            --check for faction
                            local cloneFaction = MethodDungeonTools.dungeonEnemies[db.currentDungeonIdx][enemyIdx]["clones"][cloneIdx].faction
                            if cloneFaction then
                                if cloneFaction ~= preset.faction then continue = false end
                            end

                            if continue then
                                if not incremented then enemyTableIdx = enemyTableIdx + 1; incremented = true end
                                if not enemyTable[enemyTableIdx] then enemyTable[enemyTableIdx] = {} end
                                enemyTable[enemyTableIdx].quantity = enemyTable[enemyTableIdx].quantity or 0
                                enemyTable[enemyTableIdx].npcId = npcId
                                enemyTable[enemyTableIdx].count = MethodDungeonTools.dungeonEnemies[db.currentDungeonIdx][enemyIdx]["count"]
                                enemyTable[enemyTableIdx].displayId = MethodDungeonTools.dungeonEnemies[db.currentDungeonIdx][enemyIdx]["displayId"]
                                enemyTable[enemyTableIdx].quantity = enemyTable[enemyTableIdx].quantity + 1
                                enemyTable[enemyTableIdx].name = name
                                enemyTable[enemyTableIdx].level = level
                                enemyTable[enemyTableIdx].creatureType = creatureType
                                enemyTable[enemyTableIdx].baseHealth = baseHealth
                            end
                        end
                    end
                end
            end
		end
	end
	frame.newPullButtons[idx]:SetNPCData(enemyTable)
end


---ReloadPullButtons
---Reloads all pull buttons in the scroll frame
function MethodDungeonTools:ReloadPullButtons()
	local frame = MethodDungeonTools.main_frame.sidePanel
    if not frame.pullButtonsScrollFrame then return end
	local preset = db.presets[db.currentDungeonIdx][db.currentPreset[db.currentDungeonIdx]]
    --store scroll value
    local oldScrollValue = frame.pullButtonsScrollFrame.localstatus.scrollvalue
	--first release all children of the scroll frame
	frame.pullButtonsScrollFrame:ReleaseChildren()
	local maxPulls =  0
	for k,v in pairs(preset.value.pulls) do
		maxPulls = maxPulls + 1
	end
	--add new children to the scrollFrame, the frames are from the widget pool so no memory is wasted
    if not db.devMode then
        local idx = 0
        for k,pull in pairs(preset.value.pulls) do
            idx = idx+1
            frame.newPullButtons[idx] = AceGUI:Create("MethodDungeonToolsPullButton")
            frame.newPullButtons[idx]:SetMaxPulls(maxPulls)
            frame.newPullButtons[idx]:SetIndex(idx)
            MethodDungeonTools:UpdatePullButtonNPCData(idx)
            frame.newPullButtons[idx]:Initialize()
            frame.newPullButtons[idx]:Enable()
            frame.pullButtonsScrollFrame:AddChild(frame.newPullButtons[idx])
        end
    end
	--add the "new pull" button
	frame.newPullButton = AceGUI:Create("MethodDungeonToolsNewPullButton")
	frame.newPullButton:Initialize()
	frame.newPullButton:Enable()
	frame.pullButtonsScrollFrame:AddChild(frame.newPullButton)
    --set the scroll value back to the old value
    frame.pullButtonsScrollFrame.scrollframe.obj:SetScroll(oldScrollValue)
    frame.pullButtonsScrollFrame.scrollframe.obj:FixScroll()
end

---ClearPullButtonPicks
---Deselects all pull buttons
function MethodDungeonTools:ClearPullButtonPicks()
	local frame = MethodDungeonTools.main_frame.sidePanel
	for k,v in pairs(frame.newPullButtons) do
		v:ClearPick()
	end
end

---PickPullButton
---Selects the current pull button and deselects all other buttons
function MethodDungeonTools:PickPullButton(idx)
    if db.devMode then return end
	MethodDungeonTools:ClearPullButtonPicks()
	local frame = MethodDungeonTools.main_frame.sidePanel
	frame.newPullButtons[idx]:Pick()
end

---AddPull
---Creates a new pull in the current preset and calls ReloadPullButtons to reflect the change in the scrollframe
function MethodDungeonTools:AddPull(index)
	MethodDungeonTools:PresetsAddPull(index)
	MethodDungeonTools:ReloadPullButtons()
	MethodDungeonTools:SetSelectionToPull(index)
end

---ClearPull
---Clears all the npcs out of a pull
function MethodDungeonTools:ClearPull(index)
	table.wipe(db.presets[db.currentDungeonIdx][db.currentPreset[db.currentDungeonIdx]].value.pulls[index])
	MethodDungeonTools:ReloadPullButtons()
	MethodDungeonTools:SetSelectionToPull(index)
end

---MovePullUp
---Moves the selected pull up
function MethodDungeonTools:MovePullUp(index)
	MethodDungeonTools:PresetsSwapPulls(index,index-1)
	MethodDungeonTools:ReloadPullButtons()
	MethodDungeonTools:SetSelectionToPull(index-1)
end

---MovePullDown
---Moves the selected pull down
function MethodDungeonTools:MovePullDown(index)
	MethodDungeonTools:PresetsSwapPulls(index,index+1)
	MethodDungeonTools:ReloadPullButtons()
	MethodDungeonTools:SetSelectionToPull(index+1)
end

---DeletePull
---Deletes the selected pull and makes sure that a pull will be selected afterwards
function MethodDungeonTools:DeletePull(index)
	MethodDungeonTools:PresetsDeletePull(index)
	MethodDungeonTools:ReloadPullButtons()
	local pullCount = 0
	for k,v in pairs(db.presets[db.currentDungeonIdx][db.currentPreset[db.currentDungeonIdx]].value.pulls) do
		pullCount = pullCount + 1
	end
	if index>pullCount then index = pullCount end
	MethodDungeonTools:SetSelectionToPull(index)
end

---RenamePreset
function MethodDungeonTools:RenamePreset(renameText)
	db.presets[db.currentDungeonIdx][db.currentPreset[db.currentDungeonIdx]].text = renameText
	MethodDungeonTools.main_frame.RenameFrame:Hide()
	MethodDungeonTools:UpdatePresetDropDown()
end


function MethodDungeonTools:MakeRenameFrame(frame)
	frame.RenameFrame = AceGUI:Create("Frame")
	frame.RenameFrame:SetTitle("Rename Preset")
	frame.RenameFrame:SetWidth(350)
	frame.RenameFrame:SetHeight(150)
	frame.RenameFrame:EnableResize(false)
	frame.RenameFrame:SetLayout("Flow")
	frame.RenameFrame:SetCallback("OnClose", function(widget)

	end)
	frame.RenameFrame:Hide()

	local renameText
	frame.RenameFrame.Editbox = AceGUI:Create("EditBox")
	frame.RenameFrame.Editbox:SetLabel("Insert new Preset Name:")
	frame.RenameFrame.Editbox:SetWidth(200)
	frame.RenameFrame.Editbox:SetCallback("OnEnterPressed", function(...)
        local widget, event, text = ...
		--check if name is valid, block button if so, unblock if valid
		if MethodDungeonTools:SanitizePresetName(text) then
			frame.RenameFrame.PresetRenameLabel:SetText(nil)
			frame.RenameFrame.RenameButton:SetDisabled(false)
			renameText = text
		else
			frame.RenameFrame.PresetRenameLabel:SetText("Cannot rename preset to '"..text.."'")
			frame.RenameFrame.RenameButton:SetDisabled(true)
			renameText = nil
		end
		frame.presetCreationFrame:DoLayout()
	end)

	frame.RenameFrame:AddChild(frame.RenameFrame.Editbox)

	frame.RenameFrame.RenameButton = AceGUI:Create("Button")
	frame.RenameFrame.RenameButton:SetText("Rename")
	frame.RenameFrame.RenameButton:SetWidth(100)
	frame.RenameFrame.RenameButton:SetCallback("OnClick",function() MethodDungeonTools:RenamePreset(renameText) end)
	frame.RenameFrame:AddChild(frame.RenameFrame.RenameButton)

	frame.RenameFrame.PresetRenameLabel = AceGUI:Create("Label")
	frame.RenameFrame.PresetRenameLabel:SetText(nil)
	frame.RenameFrame.PresetRenameLabel:SetWidth(390)
	frame.RenameFrame.PresetRenameLabel:SetColor(1,0,0)
	frame.RenameFrame:AddChild(frame.RenameFrame.PresetRenameLabel)

end


---MakeExportFrame
---Creates the frame used to export presets to a string which can be uploaded to text sharing websites like pastebin
function MethodDungeonTools:MakeExportFrame(frame)
	frame.ExportFrame = AceGUI:Create("Frame")
	frame.ExportFrame:SetTitle("Preset Export")
	frame.ExportFrame:SetWidth(600)
	frame.ExportFrame:SetHeight(400)
	frame.ExportFrame:EnableResize(false)
	frame.ExportFrame:SetLayout("Flow")
	frame.ExportFrame:SetCallback("OnClose", function(widget)

	end)

	frame.ExportFrameEditbox = AceGUI:Create("MultiLineEditBox")
	frame.ExportFrameEditbox:SetLabel("Preset Export:")
	frame.ExportFrameEditbox:SetWidth(600)
	frame.ExportFrameEditbox:DisableButton(true)
	frame.ExportFrameEditbox:SetNumLines(20)
	frame.ExportFrameEditbox:SetCallback("OnEnterPressed", function(widget, event, text)

	end)
	frame.ExportFrame:AddChild(frame.ExportFrameEditbox)
	--frame.presetCreationFrame:SetStatusText("AceGUI-3.0 Example Container Frame")
	frame.ExportFrame:Hide()
end


---MakeDeleteConfirmationFrame
---Creates the delete confirmation dialog that pops up when a user wants to delete a preset
function MethodDungeonTools:MakeDeleteConfirmationFrame(frame)
	frame.DeleteConfirmationFrame = AceGUI:Create("Frame")
	frame.DeleteConfirmationFrame:SetTitle("Delete Preset")
	frame.DeleteConfirmationFrame:SetWidth(250)
	frame.DeleteConfirmationFrame:SetHeight(120)
	frame.DeleteConfirmationFrame:EnableResize(false)
	frame.DeleteConfirmationFrame:SetLayout("Flow")
	frame.DeleteConfirmationFrame:SetCallback("OnClose", function(widget)

	end)

	frame.DeleteConfirmationFrame.label = AceGUI:Create("Label")
	frame.DeleteConfirmationFrame.label:SetWidth(390)
	frame.DeleteConfirmationFrame.label:SetHeight(10)
	--frame.DeleteConfirmationFrame.label:SetColor(1,0,0)
	frame.DeleteConfirmationFrame:AddChild(frame.DeleteConfirmationFrame.label)

	frame.DeleteConfirmationFrame.OkayButton = AceGUI:Create("Button")
	frame.DeleteConfirmationFrame.OkayButton:SetText("Delete")
	frame.DeleteConfirmationFrame.OkayButton:SetWidth(100)
	frame.DeleteConfirmationFrame.OkayButton:SetCallback("OnClick",function()
		MethodDungeonTools:DeletePreset(db.currentPreset[db.currentDungeonIdx])
		frame.DeleteConfirmationFrame:Hide()
	end)
	frame.DeleteConfirmationFrame.CancelButton = AceGUI:Create("Button")
	frame.DeleteConfirmationFrame.CancelButton:SetText("Cancel")
	frame.DeleteConfirmationFrame.CancelButton:SetWidth(100)
	frame.DeleteConfirmationFrame.CancelButton:SetCallback("OnClick",function()
		frame.DeleteConfirmationFrame:Hide()
	end)

	frame.DeleteConfirmationFrame:AddChild(frame.DeleteConfirmationFrame.OkayButton)
	frame.DeleteConfirmationFrame:AddChild(frame.DeleteConfirmationFrame.CancelButton)
	frame.DeleteConfirmationFrame:Hide()

end


---MakeClearConfirmationFrame
---Creates the clear confirmation dialog that pops up when a user wants to clear a preset
function MethodDungeonTools:MakeClearConfirmationFrame(frame)
	frame.ClearConfirmationFrame = AceGUI:Create("Frame")
	frame.ClearConfirmationFrame:SetTitle("Clear Preset")
	frame.ClearConfirmationFrame:SetWidth(250)
	frame.ClearConfirmationFrame:SetHeight(120)
	frame.ClearConfirmationFrame:EnableResize(false)
	frame.ClearConfirmationFrame:SetLayout("Flow")
	frame.ClearConfirmationFrame:SetCallback("OnClose", function(widget)

	end)

	frame.ClearConfirmationFrame.label = AceGUI:Create("Label")
	frame.ClearConfirmationFrame.label:SetWidth(390)
	frame.ClearConfirmationFrame.label:SetHeight(10)
	--frame.DeleteConfirmationFrame.label:SetColor(1,0,0)
	frame.ClearConfirmationFrame:AddChild(frame.ClearConfirmationFrame.label)

	frame.ClearConfirmationFrame.OkayButton = AceGUI:Create("Button")
	frame.ClearConfirmationFrame.OkayButton:SetText("Clear")
	frame.ClearConfirmationFrame.OkayButton:SetWidth(100)
	frame.ClearConfirmationFrame.OkayButton:SetCallback("OnClick",function()
		MethodDungeonTools:ClearPreset(db.currentPreset[db.currentDungeonIdx])
		frame.ClearConfirmationFrame:Hide()
	end)
	frame.ClearConfirmationFrame.CancelButton = AceGUI:Create("Button")
	frame.ClearConfirmationFrame.CancelButton:SetText("Cancel")
	frame.ClearConfirmationFrame.CancelButton:SetWidth(100)
	frame.ClearConfirmationFrame.CancelButton:SetCallback("OnClick",function()
		frame.ClearConfirmationFrame:Hide()
	end)

	frame.ClearConfirmationFrame:AddChild(frame.ClearConfirmationFrame.OkayButton)
	frame.ClearConfirmationFrame:AddChild(frame.ClearConfirmationFrame.CancelButton)
	frame.ClearConfirmationFrame:Hide()

end


---CreateTutorialButton
---Creates the tutorial button and sets up the help plate frames
function MethodDungeonTools:CreateTutorialButton(parent)
    local button = CreateFrame("Button",parent,parent,"MainHelpPlateButton")
    button:SetPoint("TOPLEFT",parent,"TOPLEFT",0,48)
	button:SetScale(0.8)
	button:SetFrameStrata(mainFrameStrata)
	button:SetFrameLevel(6)
	button:Hide()
	--hook to make button hide
	local originalHide = parent.Hide
	function parent:Hide(...)
		button:Hide()
		return originalHide(self, ...);
	end
	local helpPlate = {
		FramePos = { x = 0,	y = 0 },
		FrameSize = { width = sizex, height = sizey	},
		[1] = { ButtonPos = { x = 190,	y = 0 }, HighLightBox = { x = 0, y = 0, width = 197, height = 56 },		ToolTipDir = "RIGHT",		ToolTipText = "Select a dungeon" },
		[2] = { ButtonPos = { x = 190,	y = -210 }, HighLightBox = { x = 0, y = -58, width = sizex-6, height = sizey-58 },	ToolTipDir = "RIGHT",	ToolTipText = "Select enemies for your pulls\nCTRL+Click to single select enemies" },
		[3] = { ButtonPos = { x = 828,	y = 0 }, HighLightBox = { x = 838, y = 30, width = 251, height = 87 },	ToolTipDir = "LEFT",	ToolTipText = "Manage presets" },
		[4] = { ButtonPos = { x = 828,	y = -87 }, HighLightBox = { x = 838, y = 30-87, width = 251, height = 83 },	ToolTipDir = "LEFT",	ToolTipText = "Customize dungeon Options" },
		[5] = { ButtonPos = { x = 828,	y = -(87+83) }, HighLightBox = { x = 838, y = 30-(87+83), width = 251, height = 415 },	ToolTipDir = "LEFT",	ToolTipText = "Create and manage your pulls\nRight click for more options" },
	}
	local function TutorialButtonOnClick(self)
		if not HelpPlate_IsShowing(helpPlate) then
			HelpPlate_Show(helpPlate, MethodDungeonTools.main_frame, self)
		else
			HelpPlate_Hide(true)
		end
	end
	local function TutorialButtonOnHide(self)
		HelpPlate_Hide(true)
	end
	parent.HelpButton = button
    button:SetScript("OnClick",TutorialButtonOnClick)
    button:SetScript("OnHide",TutorialButtonOnHide)
end

---RegisterOptions
---Register the options of the addon to the blizzard options
function MethodDungeonTools:RegisterOptions()
	LibStub("AceConfigRegistry-3.0"):RegisterOptionsTable("MethodDungeonTools", MethodDungeonTools.blizzardOptionsMenuTable);
	self.blizzardOptionsMenu = LibStub("AceConfigDialog-3.0"):AddToBlizOptions("MethodDungeonTools", "MethodDungeonTools");
end

---Round
function MethodDungeonTools:Round(number, decimals)
	return (("%%.%df"):format(decimals)):format(number)
end

---RGBToHex
function MethodDungeonTools:RGBToHex(r,g,b)
	r = r*255
	g = g*255
	b = b*255
	return ("%.2x%.2x%.2x"):format(r, g, b)
end
---HexToRGB
function MethodDungeonTools:HexToRGB(rgb)
	if string.len(rgb) == 6 then
		local r, g, b
		r, g, b = tonumber('0x'..strsub(rgb, 0, 2)), tonumber('0x'..strsub(rgb, 3, 4)), tonumber('0x'..strsub(rgb, 5, 6))
		if not r then r = 0 else r = r/255 end
		if not g then g = 0 else g = g/255 end
		if not b then b = 0 else b = b/255 end
		return r,g,b
	else
		return
	end
end

---DeepCopy
function MethodDungeonTools:DeepCopy(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in next, orig, nil do
            copy[MethodDungeonTools:DeepCopy(orig_key)] = MethodDungeonTools:DeepCopy(orig_value)
        end
        setmetatable(copy, MethodDungeonTools:DeepCopy(getmetatable(orig)))
    else -- number, string, boolean, etc
        copy = orig
    end
    return copy
end

---StorePresetObject
function MethodDungeonTools:StorePresetObject(obj)
	local currentPreset = MethodDungeonTools:GetCurrentPreset()
	currentPreset.objects = currentPreset.objects or {}
	--we insert the object infront of the first hidden oject
	local pos = 1
	for k,v in ipairs(currentPreset.objects) do
		pos = pos + 1
		if v.d[4]==false then
			pos = pos - 1
		end
	end
	if pos>1 then
		tinsert(currentPreset.objects,pos,MethodDungeonTools:DeepCopy(obj))
	else
		tinsert(currentPreset.objects,MethodDungeonTools:DeepCopy(obj))
	end
end

---UpdatePresetObjectOffsets
function MethodDungeonTools:UpdatePresetObjectOffsets(idx,x,y)
	local currentPreset = MethodDungeonTools:GetCurrentPreset()
	for objectIndex,obj in pairs(currentPreset.objects) do
		if objectIndex == idx then
			for coordIdx,coord in pairs(obj.l) do
				if coordIdx%2==1 then
					obj.l[coordIdx] = coord-x
				else
					obj.l[coordIdx] = coord-y
				end
			end
		end
	end
    --redraw everything
	MethodDungeonTools:DrawAllPresetObjects()
end


---DrawAllPresetObjects
---Draws all Preset objects on the map canvas/sublevel
function MethodDungeonTools:DrawAllPresetObjects()

    local currentPreset = MethodDungeonTools:GetCurrentPreset()
    local currentSublevel = MethodDungeonTools:GetCurrentSubLevel()

	--ViragDevTool_AddData(currentPreset.objects)
	--ViragDevTool_AddData(currentPreset)
	--ViragDevTool_AddData(string.len(MethodDungeonTools:TableToString(currentPreset, true)))

    MethodDungeonTools:ReleaseAllActiveTextures()
    currentPreset.objects = currentPreset.objects or {}
    --ViragDevTool_AddData(currentPreset.objects)
	--d: size,lineFactor,sublevel,shown,colorstring,drawLayer,[smooth]
	--l: x1,y1,x2,y2,...
	local color = {}
    for objectIndex,obj in pairs(currentPreset.objects) do
        if obj.d[3] == currentSublevel and obj.d[4] then
            if obj.n then
                local x = obj.d[1]
                local y = obj.d[2]
                local text = obj.d[5]
                MethodDungeonTools:DrawNote(x,y,text,objectIndex)
            else
                color.r,color.g,color.b = MethodDungeonTools:HexToRGB(obj.d[5])
                --lines
                local x1,y1,x2,y2
                local lastx,lasty
                for _,coord in pairs(obj.l) do
                    if not x1 then x1 = coord
                    elseif not y1 then y1 = coord
                    elseif not x2 then
                        x2 = coord
                        lastx = coord
                    elseif not y2 then
                        y2 = coord
                        lasty = coord
                    end
                    if x1 and y1 and x2 and y2 then
                        MethodDungeonTools:DrawLine(x1,y1,x2,y2,obj.d[1]*0.3,color,obj.d[7],nil,obj.d[6],obj.d[2],nil,objectIndex)
                        --circles if smooth
                        if obj.d[7] then
                            MethodDungeonTools:DrawCircle(x1,y1,obj.d[1]*0.3,color,nil,obj.d[6],nil,objectIndex)
                            MethodDungeonTools:DrawCircle(x2,y2,obj.d[1]*0.3,color,nil,obj.d[6],nil,objectIndex)
                        end
                        x1,y1,x2,y2 = nil,nil,nil,nil
                    end
                end
                --triangle
                if obj.t and lastx and lasty then
                    MethodDungeonTools:DrawTriangle(lastx,lasty,obj.t[1],obj.d[1],color,nil,obj.d[6],nil,objectIndex)
                end
                --remove empty objects leftover from erasing
                if obj.l then
                    local lineCount = 0
                    for _,_ in pairs(obj.l) do
                        lineCount = lineCount +1
                    end
                    if lineCount == 0 then
                        currentPreset.objects[objectIndex] = nil
                    end
                end
            end
        end
    end
end

---DeletePresetObjects
---Deletes objects from the current preset in the current sublevel
function MethodDungeonTools:DeletePresetObjects()
	local currentPreset = MethodDungeonTools:GetCurrentPreset()
    local currentSublevel = MethodDungeonTools:GetCurrentSubLevel()
    for objectIndex,obj in pairs(currentPreset.objects) do
        if obj.d[3] == currentSublevel then
            currentPreset.objects[objectIndex] = nil
        end
    end
    MethodDungeonTools:DrawAllPresetObjects()
end

---StepBack
---Undo the latest drawing
function MethodDungeonTools:PresetObjectStepBack()
    local currentPreset = MethodDungeonTools:GetCurrentPreset()
    currentPreset.objects = currentPreset.objects or {}
    local length = 0
    for k,v in pairs(currentPreset.objects) do
        length = length + 1
    end
    if length>0 then
        for i = length,1,-1 do
            if currentPreset.objects[i] and currentPreset.objects[i].d[4] then
                currentPreset.objects[i].d[4] = false
                MethodDungeonTools:DrawAllPresetObjects()
                break
            end
        end
    end
end

---StepForward
---Redo the latest drawing
function MethodDungeonTools:PresetObjectStepForward()
    local currentPreset = MethodDungeonTools:GetCurrentPreset()
    currentPreset.objects = currentPreset.objects or {}
    local length = 0
    for k,v in ipairs(currentPreset.objects) do
        length = length + 1
    end
    if length>0 then
        for i = 1,length do
            if currentPreset.objects[i] and not currentPreset.objects[i].d[4] then
                currentPreset.objects[i].d[4] = true
                MethodDungeonTools:DrawAllPresetObjects()
                break
            end
        end
    end
end

function MethodDungeonTools:FixAceGUIShowHide(widget,frame,isFrame,hideOnly)
    frame = frame or MethodDungeonTools.main_frame
    local originalShow,originalHide = frame.Show,frame.Hide
    if not isFrame then
        widget = widget.frame
    end
    function frame:Hide(...)
        widget:Hide()
        return originalHide(self, ...);
    end
    if hideOnly then return end
    function frame:Show(...)
        widget:Show()
        return originalShow(self, ...);
    end
end

function MethodDungeonTools:GetCurrentAffixWeek()
    if not IsAddOnLoaded("Blizzard_ChallengesUI") then
        LoadAddOn("Blizzard_ChallengesUI")
    end
    C_MythicPlus.RequestCurrentAffixes()
    C_MythicPlus.RequestMapInfo()
    C_MythicPlus.RequestRewards()
    local affixIds = C_MythicPlus.GetCurrentAffixes() --table
    if not affixIds then return end
    for week,affixes in ipairs(affixWeeks) do
        if affixes[1] == affixIds[2].id and affixes[2] == affixIds[3].id and affixes[3] == affixIds[1].id then
            return week
        end
    end
end

function MethodDungeonTools:ResetMainFramePos()
    local f = MethodDungeonTools.main_frame
    db.xoffset = 0
    db.yoffset = -150
    db.anchorFrom = "TOP"
    db.anchorTo = "TOP"
    f:ClearAllPoints()
    f:SetPoint(db.anchorTo, UIParent,db.anchorFrom, db.xoffset, db.yoffset)
end

function MethodDungeonTools:DropIndicator()
    local indicator = MethodDungeonTools.main_frame.drop_indicator
    if not indicator then
        indicator = CreateFrame("Frame", "MethodDungeonTools_DropIndicator")
        indicator:SetHeight(4)
        indicator:SetFrameStrata("FULLSCREEN")

        local texture = indicator:CreateTexture(nil, "FULLSCREEN")
        texture:SetBlendMode("ADD")
        texture:SetAllPoints(indicator)
        texture:SetTexture("Interface\\PaperDollInfoFrame\\UI-Character-Tab-Highlight")

        local icon = indicator:CreateTexture(nil, "OVERLAY")
        icon:SetSize(16, 16)
        icon:SetPoint("CENTER", indicator)

        indicator.icon = icon
        indicator.texture = texture
        MethodDungeonTools.main_frame.drop_indicator = indicator

        indicator:Hide()
    end

    return indicator
end

function MethodDungeonTools:Show_DropIndicator(target, pos)
    local indicator = MethodDungeonTools:DropIndicator()

    indicator:ClearAllPoints()
    if pos == "TOP" then
        indicator:SetPoint("BOTTOMLEFT", target.frame, "TOPLEFT", 0, -1)
        indicator:SetPoint("BOTTOMRIGHT", target.frame, "TOPRIGHT", 0, -1)
        indicator:Show()
    elseif pos == "BOTTOM" then
        indicator:SetPoint("TOPLEFT", target.frame, "BOTTOMLEFT", 0, 1)
        indicator:SetPoint("TOPRIGHT", target.frame, "BOTTOMRIGHT", 0, 1)
        indicator:Show()
    end
end

function MethodDungeonTools:Hide_DropIndicator()
    local indicator = MethodDungeonTools:DropIndicator()
    indicator:Hide()
end

function MethodDungeonTools:GetScrollingAmount(scrollFrame, pixelPerSecond)
    local viewheight = scrollFrame.frame.obj.content:GetHeight()
    return (pixelPerSecond / viewheight) * 1000
end

function initFrames()
    local main_frame = CreateFrame("frame", "MethodDungeonToolsFrame", UIParent)
    tinsert(UISpecialFrames,"MethodDungeonToolsFrame")

	main_frame:SetFrameStrata(mainFrameStrata)
	main_frame:SetFrameLevel(1)
	main_frame.background = main_frame:CreateTexture(nil, "BACKGROUND")
	main_frame.background:SetAllPoints()
	main_frame.background:SetDrawLayer(canvasDrawLayer, 1)
	main_frame.background:SetColorTexture(unpack(MethodDungeonTools.BackdropColor))
	main_frame.background:SetAlpha(0.2)
	main_frame:SetSize(sizex, sizey)
	MethodDungeonTools.main_frame = main_frame

	-- Set frame position
	main_frame:ClearAllPoints();
	main_frame:SetPoint(db.anchorTo, UIParent,db.anchorFrom, db.xoffset, db.yoffset)


    main_frame.contextDropdown = CreateFrame("Frame", "MethodDungeonToolsContextDropDown", nil, "L_UIDropDownMenuTemplate")

	MethodDungeonTools:CreateMenu();
	MethodDungeonTools:MakeTopBottomTextures(main_frame);
	MethodDungeonTools:MakeMapTexture(main_frame)
	MethodDungeonTools:MakeSidePanel(main_frame)
	MethodDungeonTools:MakePresetCreationFrame(main_frame)
	MethodDungeonTools:MakePresetImportFrame(main_frame)
    MethodDungeonTools:DungeonEnemies_CreateFramePools()
	MethodDungeonTools:UpdateDungeonEnemies(main_frame)
	MethodDungeonTools:CreateDungeonSelectDropdown(main_frame)
	MethodDungeonTools:MakePullSelectionButtons(main_frame.sidePanel)
	MethodDungeonTools:MakeExportFrame(main_frame)
	MethodDungeonTools:MakeRenameFrame(main_frame)
	MethodDungeonTools:MakeDeleteConfirmationFrame(main_frame)
	MethodDungeonTools:MakeClearConfirmationFrame(main_frame)
	MethodDungeonTools:CreateTutorialButton(main_frame)
    MethodDungeonTools:POI_CreateFramePools()
    MethodDungeonTools:MakeChatPresetImportFrame(main_frame)

    --devMode
    if db.devMode and MethodDungeonTools.CreateDevPanel then
        MethodDungeonTools:CreateDevPanel(MethodDungeonTools.main_frame)
    end

    --ElvUI skinning
    local skinTooltip = function(tooltip)
        if IsAddOnLoaded("ElvUI") and ElvUI[1].Tooltip then
            local borderTextures = {"BorderBottom","BorderBottomLeft","BorderBottomRight","BorderLeft","BorderRight","BorderTop","BorderTopLeft","BorderTopRight"}
            for k,v in pairs(borderTextures) do
                tooltip[v]:Kill()
            end
            tooltip.Background:Kill()
            tooltip:HookScript("OnShow",function(self)
                if self:IsForbidden() then return end
                self:SetTemplate("Transparent", nil, true) --ignore updates
                local r, g, b = self:GetBackdropColor()
                self:SetBackdropColor(r, g, b, ElvUI[1].Tooltip.db.colorAlpha)
            end)
            if tooltip.String then tooltip.String:SetFont(tooltip.String:GetFont(),11) end
            if tooltip.topString then tooltip.topString:SetFont(tooltip.topString:GetFont(),11) end
            if tooltip.botString then tooltip.botString:SetFont(tooltip.botString:GetFont(),11) end
        end
    end
    --tooltip new
    do
        MethodDungeonTools.tooltip = CreateFrame("Frame", "MethodDungeonToolsModelTooltip", UIParent, "TooltipBorderedFrameTemplate")
        local tooltip = MethodDungeonTools.tooltip
        tooltip:SetClampedToScreen(true)
        tooltip:SetFrameStrata("TOOLTIP")
        tooltip.mySizes ={x=270,y=120}

        tooltip:SetSize(tooltip.mySizes.x, tooltip.mySizes.y)
        tooltip.Model = CreateFrame("PlayerModel", nil, tooltip)
        tooltip.Model:SetFrameLevel(1)
        tooltip.Model:SetSize(100,100)
        tooltip.Model.fac = 0
        tooltip.Model:SetScript("OnUpdate",function (self,elapsed)
            self.fac = self.fac + 0.5
            if self.fac >= 360 then
                self.fac = 0
            end
            self:SetFacing(PI*2 / 360 * self.fac)
        end)
        tooltip.Model:SetPoint("TOPLEFT", tooltip, "TOPLEFT",7,-7)
        tooltip.String = tooltip:CreateFontString("MethodDungeonToolsToolTipString");
        tooltip.String:SetFontObject("GameFontNormalSmall")
        tooltip.String:SetFont(tooltip.String:GetFont(),10)
        tooltip.String:SetTextColor(1, 1, 1, 1);
        tooltip.String:SetJustifyH("LEFT")
        tooltip.String:SetJustifyV("CENTER")
        tooltip.String:SetWidth(tooltip:GetWidth())
        tooltip.String:SetHeight(90)
        tooltip.String:SetWidth(140)
        tooltip.String:SetText(" ");
        tooltip.String:SetPoint("TOPLEFT", tooltip, "TOPLEFT", 110, -10)
        tooltip.String:Show();
        skinTooltip(tooltip)
    end

	--pullTooltip
	do
		MethodDungeonTools.pullTooltip = CreateFrame("Frame", "MethodDungeonToolsPullTooltip", UIParent, "TooltipBorderedFrameTemplate")
        --MethodDungeonTools.pullTooltip:SetOwner(UIParent, "ANCHOR_NONE")
        local pullTT = MethodDungeonTools.pullTooltip
        MethodDungeonTools.pullTooltip:SetClampedToScreen(true)
		MethodDungeonTools.pullTooltip:SetFrameStrata("TOOLTIP")
        MethodDungeonTools.pullTooltip.myHeight = 160
		MethodDungeonTools.pullTooltip:SetSize(250, MethodDungeonTools.pullTooltip.myHeight)

        MethodDungeonTools.pullTooltip.Model = CreateFrame("PlayerModel", nil, MethodDungeonTools.pullTooltip)
        MethodDungeonTools.pullTooltip.Model:SetFrameLevel(1)

        MethodDungeonTools.pullTooltip.Model.fac = 0
        if true then
            MethodDungeonTools.pullTooltip.Model:SetScript("OnUpdate",function (self,elapsed)
                self.fac = self.fac + 0.5
                if self.fac >= 360 then
                    self.fac = 0
                end
                self:SetFacing(PI*2 / 360 * self.fac)
            end)

        else
            MethodDungeonTools.pullTooltip.Model:SetPortraitZoom(1)
            MethodDungeonTools.pullTooltip.Model:SetFacing(PI*2 / 360 * 2)
        end

        MethodDungeonTools.pullTooltip.Model:SetSize(110,110)
        MethodDungeonTools.pullTooltip.Model:SetPoint("TOPLEFT", MethodDungeonTools.pullTooltip, "TOPLEFT",7,-7)

        MethodDungeonTools.pullTooltip.topString = MethodDungeonTools.pullTooltip:CreateFontString("MethodDungeonToolsToolTipString")
        MethodDungeonTools.pullTooltip.topString:SetFontObject("GameFontNormalSmall")
        MethodDungeonTools.pullTooltip.topString:SetFont(MethodDungeonTools.pullTooltip.topString:GetFont(),10)
        MethodDungeonTools.pullTooltip.topString:SetTextColor(1, 1, 1, 1);
        MethodDungeonTools.pullTooltip.topString:SetJustifyH("LEFT")
        MethodDungeonTools.pullTooltip.topString:SetJustifyV("TOP")
        MethodDungeonTools.pullTooltip.topString:SetHeight(110)
        MethodDungeonTools.pullTooltip.topString:SetWidth(130)
        MethodDungeonTools.pullTooltip.topString:SetPoint("TOPLEFT", MethodDungeonTools.pullTooltip, "TOPLEFT", 110, -7)
        MethodDungeonTools.pullTooltip.topString:Hide()

        local heading = MethodDungeonTools.pullTooltip:CreateTexture(nil, "TOOLTIP")
        heading:SetHeight(8)
        heading:SetPoint("LEFT", 12, -30)
        heading:SetPoint("RIGHT", MethodDungeonTools.pullTooltip, "RIGHT", -12, -30)
        heading:SetTexture("Interface\\Tooltips\\UI-Tooltip-Border")
        heading:SetTexCoord(0.81, 0.94, 0.5, 1)
        heading:Show()

        MethodDungeonTools.pullTooltip.botString = MethodDungeonTools.pullTooltip:CreateFontString("MethodDungeonToolsToolTipString")
        local botString = MethodDungeonTools.pullTooltip.botString
        botString:SetFontObject("GameFontNormalSmall")
        botString:SetFont(MethodDungeonTools.pullTooltip.topString:GetFont(),10)
        botString:SetTextColor(1, 1, 1, 1);
        botString:SetJustifyH("TOP")
        botString:SetJustifyV("TOP")
        botString:SetHeight(23)
        botString:SetWidth(250)
        botString.defaultText = "Forces: %d\nTotal: %d/%d"
        botString:SetPoint("TOPLEFT", heading, "LEFT", -12, -7)
        botString:Hide()
        skinTooltip(pullTT)
	end

	--Blizzard Options
	MethodDungeonTools.blizzardOptionsMenuTable = {
		name = "Method Dungeon Tools",
		type = 'group',
		args = {
			enable = {
				type = 'toggle',
				name = "Enable Minimap Button",
				desc = "If the Minimap Button is enabled.",
				get = function() return not db.minimap.hide end,
				set = function(_, newValue)
					db.minimap.hide = not newValue
					if not db.minimap.hide then
						icon:Show("MethodDungeonTools")
					else
						icon:Hide("MethodDungeonTools")
					end
				end,
				order = 1,
				width = "full",
			},
            tooltipSelect ={
                type = 'select',
                name = "Choose NPC tooltip position",
                values = {
                    [1] = "Next to the NPC",
                    [2] = "In the bottom right corner",
                },
                get = function() return db.tooltipInCorner and 2 or 1 end,
                set = function(_,newValue)
                    if newValue == 1 then db.tooltipInCorner = false end
                    if newValue == 2 then db.tooltipInCorner = true end
                end,
                style = 'dropdown',
            },
            enemyForcesFormat = {
              type = "select",
              name = "Choose Enemy Forces Format",
              values = {
                [1] = "Forces only: 5/200",
                [2] = "Forces+%: 5/200 (2.5%)",
              },
              get = function() return db.enemyForcesFormat end,
              set = function(_,newValue) db.enemyForcesFormat = newValue end,
              style = "dropdown",
            },
            enemyStyle = {
              type = "select",
              name = "Choose Enemy Style. Requires Reload",
              values = {
                [1] = "Portrait",
                [2] = "Plain Texture",
              },
              get = function() return db.enemyStyle end,
              set = function(_,newValue) db.enemyStyle = newValue end,
              style = "dropdown",
            },

		}
	}
	MethodDungeonTools:RegisterOptions()
	MethodDungeonTools:initToolbar(main_frame)

    --Set affix dropdown to preset week
    --gotta set the list here, as affixes are not ready to be retrieved yet on login
    main_frame.sidePanel.affixDropdown:UpdateAffixList()
    main_frame.sidePanel.affixDropdown:SetAffixWeek(MethodDungeonTools:GetCurrentPreset().week or (MethodDungeonTools:GetCurrentAffixWeek() or 1))
    MethodDungeonTools:UpdateToDungeon(db.currentDungeonIdx)
	main_frame:Hide()

    framesInitialized = true
end

