
local _, MethodDungeonTools = ...


local mainFrameStrata = "HIGH"

_G["MethodDungeonTools"] = MethodDungeonTools

local sizex = 840
local sizey = 555
local buttonTextFontSize = 12
local methodColor = "|cFFF49D38"

local Dialog = LibStub("LibDialog-1.0")
local dropDownLib,_ = LibStub("PhanxConfig-Dropdown")
local HBD = LibStub("HereBeDragons-1.0")
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



-- Made by: Nnogga - Tarren Mill <Method>, 2017

SLASH_METHODDUNGEONTOOLS1 = "/mplus"
SLASH_METHODDUNGEONTOOLS2 = "/mdt"
SLASH_METHODDUNGEONTOOLS3 = "/methoddungeontools"

--LUA API
local pi,tinsert = math.pi,table.insert

function SlashCmdList.METHODDUNGEONTOOLS(cmd, editbox)
	local rqst, arg = strsplit(' ', cmd)
	if rqst == "devmode" then
		MethodDungeonTools:ToggleDevMode()
	elseif rqst == "remove" then
		--
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
		currentDungeonIdx = 1,
		currentDifficulty = 15,
		xoffset = 0,
		yoffset = -150,
		anchorFrom = "TOP",
		anchorTo = "TOP",
        tooltipInCorner = false,
		minimap = {
			hide = false,
		},
		presets = {
			[1] = {
				[1] = {text="Default",value={}},
				[2] = {text="<New Preset>",value=0},
			},
			[2] = {
				[1] = {text="Default",value={}},
				[2] = {text="<New Preset>",value=0},
			},
			[3] = {
				[1] = {text="Default",value={}},
				[2] = {text="<New Preset>",value=0},
			},
			[4] = {
				[1] = {text="Default",value={}},
				[2] = {text="<New Preset>",value=0},
			},
			[5] = {
				[1] = {text="Default",value={}},
				--[[
				 --preset
					[1] = { --pull 1
						[1] = {1,2}, --wandering shellback
						[3] = {1,2},	 --warrior
					},
					[2] = { --pull 2
						[1] = {3},
						[3] = {4},
					},
					[3] = { --pull 3
						[1] = {8},
						[3] = {4,5},
					},
				]]
				[2] = {text="<New Preset>",value=0},
			},
			[6] = {
				[1] = {text="Default",value={}},
				[2] = {text="<New Preset>",value=0},
			},
			[7] = {
				[1] = {text="Default",value={}},
				[2] = {text="<New Preset>",value=0},
			},
			[8] = {
				[1] = {text="Default",value={}},
				[2] = {text="<New Preset>",value=0},
			},
			[9] = {
				[1] = {text="Default",value={}},
				[2] = {text="<New Preset>",value=0},
			},
			[10] = {
				[1] = {text="Default",value={}},
				[2] = {text="<New Preset>",value=0},
			},
			[11] = {
				[1] = {text="Default",value={}},
				[2] = {text="<New Preset>",value=0},
			},
			[12] = {
				[1] = {text="Default",value={}},
				[2] = {text="<New Preset>",value=0},
			},
			[13] = {
				[1] = {text="Default",value={}},
				[2] = {text="<New Preset>",value=0},
			},
		},
		currentPreset = {
			[1] = 1,
			[2] = 1,
			[3] = 1,
			[4] = 1,
			[5] = 1,
			[6] = 1,
			[7] = 1,
			[8] = 1,
			[9] = 1,
			[10] = 1,
			[11] = 1,
			[12] = 1,
			[13] = 1,
		},
	},
}


-- Init db
do
    local frame = CreateFrame("Frame")
    frame:RegisterEvent("ADDON_LOADED")
    frame:SetScript("OnEvent", function(self, event, ...)
        return MethodDungeonTools[event](self,...)
    end)
	
    function MethodDungeonTools.ADDON_LOADED(self,addon)
        if addon == "MethodDungeonTools" then
			db = LibStub("AceDB-3.0"):New("MethodDungeonToolsDB", defaultSavedVars).global           
			initFrames()
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
            self:UnregisterEvent("ADDON_LOADED")
        end
    end
end

local dungeonBossButtons
local dungeonEnemyBlips
local numDungeonEnemyBlips = 0
local tooltip
local tooltipLastShown
local dungeonEnemyBlipMouseoverHighlight
local dungeonEnemiesSelected = {}
MethodDungeonTools.dungeonTotalCount = {}


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
}

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

}


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
	
}
MethodDungeonTools.dungeonBosses = {}
MethodDungeonTools.dungeonEnemies = {}

function MethodDungeonTools:ShowInterface()
	if self.main_frame:IsShown() then
		MethodDungeonTools:HideInterface()
	else
		self.main_frame:Show();
		MethodDungeonTools:UpdateToDungeon(db.currentDungeonIdx)
		self.main_frame.HelpButton:Show()
	end
end

function MethodDungeonTools:HideInterface()
	self.main_frame:Hide();
	self.main_frame.HelpButton:Hide()
end

function MethodDungeonTools:ToggleDevMode()
    db.devMode = not db.devMode
    print("MDT: Reload Interface to enable dev mode features")
end


function MethodDungeonTools:CreateMenu()
	-- Close button
	self.main_frame.closeButton = CreateFrame("Button", "CloseButton", self.main_frame, "UIPanelCloseButton");
	self.main_frame.closeButton:ClearAllPoints()
	self.main_frame.closeButton:SetPoint("BOTTOMRIGHT", self.main_frame, "TOPRIGHT", 240, -2);
	self.main_frame.closeButton:SetScript("OnClick", function() MethodDungeonTools:HideInterface(); end);
	--self.main_frame.closeButton:SetSize(32, h);
end

function MethodDungeonTools:MakeTopBottomTextures(frame)

    frame:SetMovable(true)

	if frame.topPanel == nil then
		frame.topPanel = CreateFrame("Frame", "MethodDungeonToolsTopPanel", frame)
		frame.topPanelTex = frame.topPanel:CreateTexture(nil, "BACKGROUND")
		frame.topPanelTex:SetAllPoints()
		frame.topPanelTex:SetDrawLayer("ARTWORK", -5)
		frame.topPanelTex:SetColorTexture(0, 0, 0, 0.7)
		
		frame.topPanelString = frame.topPanel:CreateFontString("MethodDungeonTools name")
		frame.topPanelString:SetFont("Fonts\\FRIZQT__.TTF", 20)
		frame.topPanelString:SetTextColor(1, 1, 1, 1)
		frame.topPanelString:SetJustifyH("CENTER")
		frame.topPanelString:SetJustifyV("CENTER")
		frame.topPanelString:SetWidth(600)
		frame.topPanelString:SetHeight(20)
		frame.topPanelString:SetText("Method Dungeon Tools")
		frame.topPanelString:ClearAllPoints()
		frame.topPanelString:SetPoint("CENTER", frame.topPanel, "CENTER", 0, 0)
		frame.topPanelString:Show()
		
		frame.topPanelLogo = frame.topPanel:CreateTexture(nil, "HIGH", nil, 7)
		frame.topPanelLogo:SetTexture("Interface\\AddOns\\MethodDungeonTools\\Textures\\Method")
		frame.topPanelLogo:SetWidth(24)
		frame.topPanelLogo:SetHeight(24)
		frame.topPanelLogo:SetPoint("RIGHT",frame.topPanelString,"LEFT",183,0)
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
        frame.bottomPanelTex:SetDrawLayer("ARTWORK", -5)
        frame.bottomPanelTex:SetColorTexture(0, 0, 0, 0.7)

    end

    frame.bottomPanel:ClearAllPoints()
    frame.bottomPanel:SetSize(frame:GetWidth(), 30)
    frame.bottomPanel:SetPoint("TOPLEFT", frame, "BOTTOMLEFT", 0, 0)





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
		frame.sidePanel = CreateFrame("Frame", "MethodDungeonToolsSidePanel", frame);
		frame.sidePanelTex = frame.sidePanel:CreateTexture(nil, "BACKGROUND");
		frame.sidePanelTex:SetAllPoints();
		frame.sidePanelTex:SetDrawLayer("ARTWORK", -5);
		frame.sidePanelTex:SetColorTexture(0, 0, 0, 0.7);
		frame.sidePanelTex:Show()
	end
	
	
	frame.sidePanel:ClearAllPoints();
	frame.sidePanel:SetSize(250, frame:GetHeight()+(frame.topPanel:GetHeight()*2));
	frame.sidePanel:SetPoint("TOPLEFT", frame.topPanel, "TOPRIGHT", -1, 0);
	
	frame.sidePanelTopString = frame.sidePanel:CreateFontString("MethodDungeonToolsSidePanelTopText");
	frame.sidePanelTopString:SetFont("Fonts\\FRIZQT__.TTF", 20)
	frame.sidePanelTopString:SetTextColor(1, 1, 1, 1);
	frame.sidePanelTopString:SetJustifyH("CENTER")
	frame.sidePanelTopString:SetJustifyV("TOP")
	frame.sidePanelTopString:SetWidth(200)
	frame.sidePanelTopString:SetHeight(500)
	frame.sidePanelTopString:SetText("");
	frame.sidePanelTopString:ClearAllPoints();
	frame.sidePanelTopString:SetPoint("CENTER", frame.sidePanel, "CENTER", 0, -40-30);
	frame.sidePanelTopString:Show();
	frame.sidePanelTopString:Hide();
	
	
	frame.sidePanelString = frame.sidePanel:CreateFontString("MethodDungeonToolsSidePanelText");
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
	frame.sidePanel.WidgetGroup:SetPoint("TOP",frame.sidePanel,"TOP",3,-31)
	frame.sidePanel.WidgetGroup:SetLayout("Flow")
	
	frame.sidePanel.WidgetGroup.frame:SetFrameStrata(mainFrameStrata)
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
	
	local buttonWidth = 80
	
	---new profile,rename,export,delete
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

	frame.sidePanelClearButton = AceGUI:Create("Button")
	frame.sidePanelClearButton:SetText("Clear")
	frame.sidePanelClearButton:SetWidth(buttonWidth)
	frame.sidePanelClearButton.frame:SetNormalFontObject(fontInstance)
	frame.sidePanelClearButton.frame:SetHighlightFontObject(fontInstance)
	frame.sidePanelClearButton.frame:SetDisabledFontObject(fontInstance)
	frame.sidePanelClearButton:SetCallback("OnClick",function(widget,callbackName,value)
		MethodDungeonTools:HideAllDialogs()
		frame.ClearConfirmationFrame:SetPoint("CENTER",MethodDungeonTools.main_frame,"CENTER",0,50)
		local currentPresetName = db.presets[db.currentDungeonIdx][db.currentPreset[db.currentDungeonIdx]].text
		frame.ClearConfirmationFrame.label:SetText("Clear "..currentPresetName.."?")
		frame.ClearConfirmationFrame:Show()
	end)

	frame.sidePanel.WidgetGroup:AddChild(frame.sidePanelNewButton)
	frame.sidePanel.WidgetGroup:AddChild(frame.sidePanelImportButton)
	frame.sidePanel.WidgetGroup:AddChild(frame.sidePanelExportButton)
	frame.sidePanel.WidgetGroup:AddChild(frame.sidePanelRenameButton)
	frame.sidePanel.WidgetGroup:AddChild(frame.sidePanelClearButton)
	frame.sidePanel.WidgetGroup:AddChild(frame.sidePanelDeleteButton)
	
	
	--Tyranical/Fortified toggle
	frame.sidePanelFortifiedCheckBox = AceGUI:Create("CheckBox")
	frame.sidePanelFortifiedCheckBox:SetLabel("Fort")
	frame.sidePanelFortifiedCheckBox.text:SetTextHeight(10)
	frame.sidePanelFortifiedCheckBox:SetWidth(65)
	frame.sidePanelFortifiedCheckBox:SetHeight(15)
	if db.presets[db.currentDungeonIdx][db.currentPreset[db.currentDungeonIdx]].value.currentAffix then
		if db.presets[db.currentDungeonIdx][db.currentPreset[db.currentDungeonIdx]].value.currentAffix == "fortified" then frame.sidePanelFortifiedCheckBox:SetValue(true) end
	end
	frame.sidePanelFortifiedCheckBox:SetImage("Interface\\ICONS\\ability_toughness")	
	frame.sidePanelFortifiedCheckBox:SetCallback("OnValueChanged",function(widget,callbackName,value)
		if value == true then
			db.presets[db.currentDungeonIdx][db.currentPreset[db.currentDungeonIdx]].value.currentAffix = "fortified"
		elseif value == false then
			db.presets[db.currentDungeonIdx][db.currentPreset[db.currentDungeonIdx]].value.currentAffix = "tyrannical"
		end
		frame.sidePanelTyrannicalCheckBox:SetValue(not value)
	end) 
	frame.sidePanel.WidgetGroup:AddChild(frame.sidePanelFortifiedCheckBox)
	
	
	frame.sidePanelTyrannicalCheckBox = AceGUI:Create("CheckBox")
	frame.sidePanelTyrannicalCheckBox:SetLabel("Tyran")
	frame.sidePanelTyrannicalCheckBox.text:SetTextHeight(10)
	frame.sidePanelTyrannicalCheckBox:SetWidth(74)
	frame.sidePanelTyrannicalCheckBox:SetHeight(15)
	if db.presets[db.currentDungeonIdx][db.currentPreset[db.currentDungeonIdx]].value.currentAffix then
		if db.presets[db.currentDungeonIdx][db.currentPreset[db.currentDungeonIdx]].value.currentAffix == "tyrannical" then frame.sidePanelTyrannicalCheckBox:SetValue(true) end
	end
	frame.sidePanelTyrannicalCheckBox:SetImage("Interface\\ICONS\\achievement_boss_archaedas")	
	frame.sidePanelTyrannicalCheckBox:SetCallback("OnValueChanged",function(widget,callbackName,value)
		if value == true then
			db.presets[db.currentDungeonIdx][db.currentPreset[db.currentDungeonIdx]].value.currentAffix = "tyrannical"
		elseif value == false then
			db.presets[db.currentDungeonIdx][db.currentPreset[db.currentDungeonIdx]].value.currentAffix = "fortified"
		end
		frame.sidePanelFortifiedCheckBox:SetValue(not value)
	end) 
	frame.sidePanel.WidgetGroup:AddChild(frame.sidePanelTyrannicalCheckBox)
	
	frame.sidePanelTeemingCheckBox = AceGUI:Create("CheckBox")
	frame.sidePanelTeemingCheckBox:SetLabel("Teeming")
	frame.sidePanelTeemingCheckBox.text:SetTextHeight(10)
	frame.sidePanelTeemingCheckBox:SetWidth(90)
	frame.sidePanelTeemingCheckBox:SetHeight(15)
	frame.sidePanelTeemingCheckBox:SetDisabled(false)
	
	if db.presets[db.currentDungeonIdx][db.currentPreset[db.currentDungeonIdx]].value.teeming then
		if db.presets[db.currentDungeonIdx][db.currentPreset[db.currentDungeonIdx]].value.teeming == true then frame.sidePanelTeemingCheckBox:SetValue(true) end		
	end
	frame.sidePanelTeemingCheckBox:SetImage("Interface\\ICONS\\spell_nature_massteleport")	
	frame.sidePanelTeemingCheckBox:SetCallback("OnValueChanged",function(widget,callbackName,value)
		db.presets[db.currentDungeonIdx][db.currentPreset[db.currentDungeonIdx]].value.teeming = value
		MethodDungeonTools:UpdateMap()
        MethodDungeonTools:ReloadPullButtons()
	end) 
	frame.sidePanel.WidgetGroup:AddChild(frame.sidePanelTeemingCheckBox)
	
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
    frame.sidePanel.WidgetGroup.frame:SetFrameLevel(7)
	
	--progress bar
	
	
	frame.sidePanel.ProgressBar = CreateFrame("Frame", nil, frame.sidePanel, "ScenarioTrackerProgressBarTemplate")
	frame.sidePanel.ProgressBar:Show()
	frame.sidePanel.ProgressBar:SetPoint("TOP",frame.sidePanel.WidgetGroup.frame,"BOTTOM",-10,5)
	MethodDungeonTools:Progressbar_SetValue(frame.sidePanel.ProgressBar, 50,205,205)
	frame.sidePanel.ProgressBar.Bar.Icon:Hide();
	frame.sidePanel.ProgressBar.Bar.IconBG:Hide();
	
end

---Progressbar_SetValue
---Sets the value/progress/color of the count progressbar to the apropriate data
function MethodDungeonTools:Progressbar_SetValue(self, pullCurrent,totalCurrent,totalMax)
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
	self.Bar.Label:SetText(pullCurrent.." ("..totalCurrent.."/"..totalMax..")");
	self.AnimValue = percent;
end

function MethodDungeonTools:OnPan(cursorX, cursorY)
	local scrollFrame = MethodDungeonTools.main_frame.scrollFrame
	local dx = scrollFrame.cursorX - cursorX;
	local dy = cursorY - scrollFrame.cursorY;
	if ( abs(dx) >= 1 or abs(dy) >= 1 ) then
		scrollFrame.moved = true;
		local x = max(0, dx + scrollFrame.x);
		x = min(x, scrollFrame.maxX);
		scrollFrame:SetHorizontalScroll(x);
		local y = max(0, dy + scrollFrame.y);
		y = min(y, scrollFrame.maxY);
		scrollFrame:SetVerticalScroll(y);
	end
end

--Update list of selected Enemies shown in side panel
function MethodDungeonTools:UpdateEnemiesSelected()
	local teeming = db.presets[db.currentDungeonIdx][db.currentPreset[db.currentDungeonIdx]].value.teeming
	local preset = db.presets[db.currentDungeonIdx][db.currentPreset[db.currentDungeonIdx]]
	table.wipe(dungeonEnemiesSelected)


	for enemyIdx,clones in pairs(preset.value.pulls[preset.value.currentPull]) do
		for k,cloneIdx in pairs(clones) do
			local enemyName = MethodDungeonTools.dungeonEnemies[db.currentDungeonIdx][enemyIdx]["name"]
			local count = MethodDungeonTools.dungeonEnemies[db.currentDungeonIdx][enemyIdx]["count"]
			if not dungeonEnemiesSelected[enemyName] then dungeonEnemiesSelected[enemyName] = {} end
			dungeonEnemiesSelected[enemyName].count = count
			dungeonEnemiesSelected[enemyName].quantity = dungeonEnemiesSelected[enemyName].quantity or 0
			dungeonEnemiesSelected[enemyName].quantity = dungeonEnemiesSelected[enemyName].quantity + 1
		end
	end
	
	local sidePanelStringText = ""
	local newLineString = ""
	local currentTotalCount = 0
	for enemyName,v in pairs(dungeonEnemiesSelected) do
		sidePanelStringText = sidePanelStringText..newLineString..v.quantity.."x "..enemyName.."("..v.count*v.quantity..")"
		newLineString = "\n"
		currentTotalCount = currentTotalCount + (v.count*v.quantity)
	end
	sidePanelStringText = sidePanelStringText..newLineString..newLineString.."Count: "..currentTotalCount
	self.main_frame.sidePanelString:SetText(sidePanelStringText)
	
	local grandTotal = 0	
	for pullIdx,pull in pairs(preset.value.pulls) do
		for enemyIdx,clones in pairs(pull) do
			for k,v in pairs(clones) do				
				local isCloneTeeming = MethodDungeonTools.dungeonEnemies[db.currentDungeonIdx][enemyIdx]["clones"][v].teeming
				if teeming == true or ((isCloneTeeming and isCloneTeeming == false) or (not isCloneTeeming)) then
					grandTotal = grandTotal + MethodDungeonTools.dungeonEnemies[db.currentDungeonIdx][enemyIdx].count
				end
			end			
		end
	end
	--self.main_frame.sidePanelTopString:SetText("Method Dungeon Tools") 
	
	--count up to and including the currently selected pull
	local pullCurrent = 0
	for pullIdx,pull in pairs(preset.value.pulls) do
		if pullIdx <= db.presets[db.currentDungeonIdx][db.currentPreset[db.currentDungeonIdx]].value.currentPull then
			for enemyIdx,clones in pairs(pull) do
				for k,v in pairs(clones) do
					local isCloneTeeming = MethodDungeonTools.dungeonEnemies[db.currentDungeonIdx][enemyIdx]["clones"][v].teeming
					if teeming == true or ((isCloneTeeming and isCloneTeeming == false) or (not isCloneTeeming)) then
						pullCurrent = pullCurrent + MethodDungeonTools.dungeonEnemies[db.currentDungeonIdx][enemyIdx].count
					end
				end			
			end
		else
			break
		end
	end
	MethodDungeonTools:Progressbar_SetValue(MethodDungeonTools.main_frame.sidePanel.ProgressBar, pullCurrent,grandTotal,teeming==true and MethodDungeonTools.dungeonTotalCount[db.currentDungeonIdx].teeming or MethodDungeonTools.dungeonTotalCount[db.currentDungeonIdx].normal)
	
	
end

function MethodDungeonTools:AddOrRemoveEnemyBlipToCurrentPull(i,add,ignoreGrouped)
	local pull = db.presets[db.currentDungeonIdx][db.currentPreset[db.currentDungeonIdx]].value.currentPull
	local preset = db.presets[db.currentDungeonIdx][db.currentPreset[db.currentDungeonIdx]]	
	preset.value.pulls = preset.value.pulls or {}
	preset.value.pulls[pull] = preset.value.pulls[pull] or {}
	preset.value.pulls[pull][dungeonEnemyBlips[i].enemyIdx] = preset.value.pulls[pull][dungeonEnemyBlips[i].enemyIdx] or {}
	if add == true then
		local found = false
		for k,v in pairs(preset.value.pulls[pull][dungeonEnemyBlips[i].enemyIdx]) do
			if v == dungeonEnemyBlips[i].cloneIdx then found = true end
		end
		if found==false then tinsert(preset.value.pulls[pull][dungeonEnemyBlips[i].enemyIdx],dungeonEnemyBlips[i].cloneIdx) end
		--make sure this pull is the only one that contains this npc clone (no double dipping)
		for pullIdx,p in pairs(preset.value.pulls) do
			if pullIdx ~= pull and p[dungeonEnemyBlips[i].enemyIdx] then
				for k,v in pairs(p[dungeonEnemyBlips[i].enemyIdx]) do
					if v == dungeonEnemyBlips[i].cloneIdx then
						tremove(preset.value.pulls[pullIdx][dungeonEnemyBlips[i].enemyIdx],k)
                        MethodDungeonTools:UpdatePullButtonNPCData(pullIdx)
						--print("Removing "..dungeonEnemyBlips[i].name.." "..dungeonEnemyBlips[i].cloneIdx.." from pull"..pullIdx)
					end
				end
			end
		end
	elseif add == false then
		for k,v in pairs(preset.value.pulls[pull][dungeonEnemyBlips[i].enemyIdx]) do
			if v == dungeonEnemyBlips[i].cloneIdx then tremove(preset.value.pulls[pull][dungeonEnemyBlips[i].enemyIdx],k) end
		end
	end
	--linked npcs
	if not ignoreGrouped then
		for idx=1,numDungeonEnemyBlips do
			if dungeonEnemyBlips[i].g and dungeonEnemyBlips[idx].g == dungeonEnemyBlips[i].g and i~=idx then
				MethodDungeonTools:AddOrRemoveEnemyBlipToCurrentPull(idx,add,true)
			end
		end
	end
	MethodDungeonTools:UpdatePullButtonNPCData(pull)
end

---UpdateEnemyBlipSelection
---Colors blips green when they are selected
function MethodDungeonTools:UpdateEnemyBlipSelection(i, forceDeselect, ignoreLinked, otherPull)

	if otherPull and otherPull == true then
		dungeonEnemyBlips[i]:SetVertexColor(0,1,0,0.4)
	else
		if forceDeselect and forceDeselect == true then
			dungeonEnemyBlips[i].selected = false
		else
			dungeonEnemyBlips[i].selected = not dungeonEnemyBlips[i].selected		
		end
		if dungeonEnemyBlips[i].selected == true then dungeonEnemyBlips[i]:SetVertexColor(0,1,0,1) else
			local r,g,b,a = dungeonEnemyBlips[i].color.r,dungeonEnemyBlips[i].color.g,dungeonEnemyBlips[i].color.b,dungeonEnemyBlips[i].color.a
			dungeonEnemyBlips[i]:SetVertexColor(r,g,b,a) 
		end
		--select/deselect linked npcs
		if not ignoreLinked then
			for idx=1,numDungeonEnemyBlips do
				if dungeonEnemyBlips[i].g and dungeonEnemyBlips[idx].g == dungeonEnemyBlips[i].g and i~=idx then
					if forceDeselect and forceDeselect == true then
						dungeonEnemyBlips[idx].selected = false
					else
						dungeonEnemyBlips[idx].selected = dungeonEnemyBlips[i].selected
					end			
					if dungeonEnemyBlips[idx].selected == true then dungeonEnemyBlips[idx]:SetVertexColor(0,1,0,1) else
						local r,g,b,a = dungeonEnemyBlips[idx].color.r,dungeonEnemyBlips[idx].color.g,dungeonEnemyBlips[idx].color.b,dungeonEnemyBlips[idx].color.a
						dungeonEnemyBlips[idx]:SetVertexColor(r,g,b,a) 
					end
				end
			end
		end
	end
	
end

local lastModelId
local cloneOffset = 0

function MethodDungeonTools:ZoomMap(delta,resetZoom)
    local scrollFrame = MethodDungeonTools.main_frame.scrollFrame
    local oldScrollH = scrollFrame:GetHorizontalScroll();
    local oldScrollV = scrollFrame:GetVerticalScroll();

    -- get the mouse position on the frame, with 0,0 at top left
    local cursorX, cursorY = GetCursorPosition()
    local relativeFrame = UIParent
    local frameX = cursorX / relativeFrame:GetScale() - scrollFrame:GetLeft()
    local frameY = scrollFrame:GetTop() - cursorY / relativeFrame:GetScale()
    local oldScale = MethodDungeonTools.main_frame.mapPanelFrame:GetScale()
    local newScale = oldScale + delta * 0.3;
    newScale = max(1, newScale)
    newScale = min(2.2, newScale)
    if resetZoom then newScale = 1 end
    MethodDungeonTools.main_frame.mapPanelFrame:SetScale(newScale)

    if newScale == 1 then
        scrollFrame.maxX = 0
        scrollFrame.maxY = 0
    elseif newScale > 1.2 and newScale < 1.4 then
        scrollFrame.maxX = 192
        scrollFrame.maxY = 131
    elseif newScale > 1.5 and newScale < 1.7 then
        scrollFrame.maxX = 313
        scrollFrame.maxY = 211
    elseif newScale > 1.8 and newScale < 2 then
        scrollFrame.maxX = 396
        scrollFrame.maxY = 266
    elseif newScale > 2.1 and newScale < 2.3 then
        scrollFrame.maxX = 453
        scrollFrame.maxY = 305
    end
    scrollFrame.zoomedIn = abs(MethodDungeonTools.main_frame.mapPanelFrame:GetScale() - 1) > 0.02

    --frameX = 420
    --frameY = 555/2

    if newScale == 1 then

    elseif newScale > 1.2 and newScale < 1.4 then
        frameX = frameX -105
        frameY = frameY -58
    elseif newScale > 1.5 and newScale < 1.7 then
        frameX = frameX -245
        frameY = frameY -165
    elseif newScale > 1.8 and newScale < 2 then
        frameX = frameX -355
        frameY = frameY -245
    elseif newScale > 2.1 and newScale < 2.3 then
        frameX = frameX -455
        frameY = frameY -345
    end

    -- figure out new scroll values
    local scaleChange = newScale / oldScale;
    local newScrollH = scaleChange * ( frameX + oldScrollH ) - frameX
    local newScrollV = scaleChange * ( frameY + oldScrollV ) - frameY

    --[[
    if newScale == 1 then

    elseif newScale > 1.2 and newScale < 1.4 then
        newScrollH = newScrollH - 30
    elseif newScale > 1.5 and newScale < 1.7 then
        newScrollH = newScrollH - 50
    elseif newScale > 1.8 and newScale < 2 then

    end
    ]]

    -- clamp scroll values
    newScrollH = min(newScrollH, scrollFrame.maxX)
    newScrollH = max(0, newScrollH)
    newScrollV = min(newScrollV, scrollFrame.maxY)
    newScrollV = max(0, newScrollV)
    -- set scroll values

    scrollFrame:SetHorizontalScroll(newScrollH)
    scrollFrame:SetVerticalScroll(newScrollV)
end

---ActivatePullTooltip
---
function MethodDungeonTools:ActivatePullTooltip(pull)
    local pullTooltip = MethodDungeonTools.pullTooltip

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
						if not tooltip.modelNpcId or (tooltip.modelNpcId ~= v.enemyData.displayId) then
							tooltip.Model:SetDisplayInfo(v.enemyData.displayId)
							tooltip.modelNpcId = v.enemyData.displayId
						end
						tooltip.Model:Show()
                        --topString
                        local newLine = "\n"
                        local text = newLine..newLine..newLine..v.enemyData.name.." x"..v.enemyData.quantity..newLine
                        text = text.."Level "..v.enemyData.level.." "..v.enemyData.creatureType..newLine
                        --ViragDevTool_AddData(v.enemyData)
                        local fortified = false
                        local boss = false
                        if db.presets[db.currentDungeonIdx][db.currentPreset[db.currentDungeonIdx]].value.currentAffix then
                            if db.presets[db.currentDungeonIdx][db.currentPreset[db.currentDungeonIdx]].value.currentAffix == "fortified" then fortified = true end
                        end
                        local tyrannical = not fortified
                        local health = MethodDungeonTools:CalculateEnemyHealth(boss,fortified,tyrannical,v.enemyData.baseHealth,db.currentDifficulty)
                        text = text..MethodDungeonTools:FormatEnemyHealth(health).." HP"..newLine
                        text = text.."Enemy Forces: "..v.enemyData.count.." ("..v.enemyData.count*v.enemyData.quantity..")"
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
            text = string.format(MethodDungeonTools.pullTooltip.botString.defaultText,pullForces,totalForces,totalForcesMax)
            tooltip.botString:SetText(text)
            tooltip.botString:Show()
		end
	end
end

---CountForces
---Counts total selected enemy forces in the current preset up to pull
function MethodDungeonTools:CountForces(currentPull,currentOnly)
    --count up to and including the currently selected pull
    local preset = db.presets[db.currentDungeonIdx][db.currentPreset[db.currentDungeonIdx]]
    local pullCurrent = 0
    for pullIdx,pull in pairs(preset.value.pulls) do
        if not currentOnly or (currentOnly and pullIdx == currentPull) then
            if pullIdx <= currentPull then
                for enemyIdx,clones in pairs(pull) do
                    for k,v in pairs(clones) do
                        local isCloneTeeming = MethodDungeonTools.dungeonEnemies[db.currentDungeonIdx][enemyIdx]["clones"][v].teeming
                        if MethodDungeonTools:IsCurrentPresetTeeming() or ((isCloneTeeming and isCloneTeeming == false) or (not isCloneTeeming)) then
                            pullCurrent = pullCurrent + MethodDungeonTools.dungeonEnemies[db.currentDungeonIdx][enemyIdx].count
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
    return db.presets[db.currentDungeonIdx][db.currentPreset[db.currentDungeonIdx]].value.teeming
end

function MethodDungeonTools:MakeMapTexture(frame)
    MethodDungeonTools.contextMenuList = {}
	local cursorX, cursorY
    if db.devMode then
        tinsert(MethodDungeonTools.contextMenuList, {
            text = "Copy Position",
            notCheckable = true,
            func = function()
                local scrollFrame = MethodDungeonTools.main_frame.scrollFrame
                local relativeFrame = UIParent		--UIParent
                local mapPanelFrame = MethodDungeonTools.main_frame.mapPanelFrame
                local mapScale = mapPanelFrame:GetScale()
                local scrollH = scrollFrame:GetHorizontalScroll();
                local scrollV = scrollFrame:GetVerticalScroll();
                local frameX = (cursorX / relativeFrame:GetScale()) - scrollFrame:GetLeft();
                local frameY = scrollFrame:GetTop() - (cursorY / relativeFrame:GetScale());
                frameX=(frameX/mapScale)+scrollH
                frameY=(frameY/mapScale)+scrollV


                local teeming = db.presets[db.currentDungeonIdx][db.currentPreset[db.currentDungeonIdx]].value.teeming and ",teeming=true" or ""
                local group = db.currentDifficulty --hijack difficulty slider to determine linked group xd

                local cloneIdx = 1
                local targetName = UnitName("target")
                if targetName then
                    for k,v in pairs(MethodDungeonTools.dungeonEnemies[db.currentDungeonIdx]) do
                        if v["name"]==targetName then
                            for k,v in pairs(v["clones"]) do
                                cloneIdx = cloneIdx+1
                            end
                            break
                        end
                    end
                end


                local activeDialog = Dialog:ActiveDialog("MethodDungeonToolsPosCopyDialog")
                if activeDialog then
                    cloneOffset = cloneOffset + 1
                    local position = "["..cloneIdx+cloneOffset.."] = {x = " .. frameX .. ",y = "..-frameY .. ",sublevel="..db.presets[db.currentDungeonIdx][db.currentPreset[db.currentDungeonIdx]].value.currentSublevel..",g="..group..teeming.."},"
                    activeDialog.editboxes[1]:SetText(activeDialog.editboxes[1]:GetText().."\n			"..position)
                else
                    cloneOffset = 0
                    local position = "["..cloneIdx+cloneOffset.."] = {x = " .. frameX .. ",y = "..-frameY .. ",sublevel="..db.presets[db.currentDungeonIdx][db.currentPreset[db.currentDungeonIdx]].value.currentSublevel..",g="..group..teeming.."},"
                    Dialog:Spawn("MethodDungeonToolsPosCopyDialog", {pos=position})
                end
            end,
        })
        tinsert(MethodDungeonTools.contextMenuList, {
            text = "Copy Patrol Waypoint",
            notCheckable = true,
            func = function()
                local scrollFrame = MethodDungeonTools.main_frame.scrollFrame
                local relativeFrame = UIParent		--UIParent
                local mapPanelFrame = MethodDungeonTools.main_frame.mapPanelFrame
                local mapScale = mapPanelFrame:GetScale()
                local scrollH = scrollFrame:GetHorizontalScroll();
                local scrollV = scrollFrame:GetVerticalScroll();
                local frameX = (cursorX / relativeFrame:GetScale()) - scrollFrame:GetLeft();
                local frameY = scrollFrame:GetTop() - (cursorY / relativeFrame:GetScale());
                frameX=(frameX/mapScale)+scrollH
                frameY=(frameY/mapScale)+scrollV
                local teeming = db.presets[db.currentDungeonIdx][db.currentPreset[db.currentDungeonIdx]].value.teeming and ",teeming=true" or ""
                local group = db.currentDifficulty --hijack difficulty slider to determine linked group xd

                local cloneIdx = 1
                local targetName = UnitName("target")
                if targetName then
                    for k,v in pairs(MethodDungeonTools.dungeonEnemies[db.currentDungeonIdx]) do
                        if v["name"]==targetName then
                            for k,v in pairs(v["clones"]) do
                                cloneIdx = cloneIdx+1
                            end
                            break
                        end
                    end
                end


                local activeDialog = Dialog:ActiveDialog("MethodDungeonToolsPosCopyDialog")
                if activeDialog then
                    cloneOffset = cloneOffset + 1
                    local position = "["..cloneIdx+cloneOffset.."] = {x = " .. frameX .. ",y = "..-frameY .."},"
                    activeDialog.editboxes[1]:SetText(activeDialog.editboxes[1]:GetText().."\n			"..position)
                else
                    cloneOffset = 0
                    local position = "["..cloneIdx+cloneOffset.."] = {x = " .. frameX .. ",y = "..-frameY .."},"
                    Dialog:Spawn("MethodDungeonToolsPosCopyDialog", {pos=position})
                end
            end,
        })
        tinsert(MethodDungeonTools.contextMenuList, {
            text = "Create new NPC from Target here",
            notCheckable = true,
            func = function()
                local scrollFrame = MethodDungeonTools.main_frame.scrollFrame
                local relativeFrame = UIParent		--UIParent
                local mapPanelFrame = MethodDungeonTools.main_frame.mapPanelFrame
                local mapScale = mapPanelFrame:GetScale()
                local scrollH = scrollFrame:GetHorizontalScroll();
                local scrollV = scrollFrame:GetVerticalScroll();
                local frameX = (cursorX / relativeFrame:GetScale()) - scrollFrame:GetLeft();
                local frameY = scrollFrame:GetTop() - (cursorY / relativeFrame:GetScale());
                frameX=(frameX/mapScale)+scrollH
                frameY=(frameY/mapScale)+scrollV

                local id
                local guid = UnitGUID("target")
                if guid then
                    id = select(6,strsplit("-", guid))
                end
                if id then
                    local newIdx = 1
                    for enemyIdx,data in pairs(MethodDungeonTools.dungeonEnemies[db.currentDungeonIdx]) do
                        newIdx = newIdx + 1
                    end
                    local name = UnitName("target")
                    local health = UnitHealthMax("target").."*nerfMultiplier"
                    local level = UnitLevel("target")
                    local creatureType = UnitCreatureType("target")
                    local x,y = frameX,-frameY
                    local sublevel = db.presets[db.currentDungeonIdx][db.currentPreset[db.currentDungeonIdx]].value.currentSublevel
                    local s = string.format('[%s] = {\n        ["name"] = "%s",\n        ["health"] = %s,\n        ["level"] = %s,\n        ["creatureType"] = "%s",\n        ["id"] = %s,\n        ["count"] = XXX,\n        ["scale"] = 1,\n        ["color"] = {r=1,g=1,b=1,a=0.8},\n        ["clones"] = {\n            [1] = {x = %s,y = %s,sublevel=%s},\n        },\n    },',newIdx,name,health,level,creatureType,id,x,y,sublevel)

                    lastDialog = Dialog:Spawn("MethodDungeonToolsPosCopyDialog", {pos=s})
                end
            end,
        })
        tinsert(MethodDungeonTools.contextMenuList, {
            text = "Create new Boss from Target here",
            notCheckable = true,
            func = function()
                local scrollFrame = MethodDungeonTools.main_frame.scrollFrame
                local relativeFrame = UIParent		--UIParent
                local mapPanelFrame = MethodDungeonTools.main_frame.mapPanelFrame
                local mapScale = mapPanelFrame:GetScale()
                local scrollH = scrollFrame:GetHorizontalScroll();
                local scrollV = scrollFrame:GetVerticalScroll();
                local frameX = (cursorX / relativeFrame:GetScale()) - scrollFrame:GetLeft();
                local frameY = scrollFrame:GetTop() - (cursorY / relativeFrame:GetScale());
                frameX=(frameX/mapScale)+scrollH
                frameY=(frameY/mapScale)+scrollV

                local id
                local guid = UnitGUID("target")
                if guid then
                    id = select(6,strsplit("-", guid))
                end
                if id then
                    local encounterID
                    for i=1,10000 do
                        local id, name, description, displayInfo, iconImage = EJ_GetCreatureInfo(1,i)
                        --cordana fix, encouner name was "Cordana"

                        if name then
                            if string.find(name,"Galind") then print(id,name) end
                        end
                        if name == UnitName("target") --[[or name == "Lord Kur'talos Ravencrest"]] then encounterID=i; break; end

                    end

                    --with ej open
                    if false then
                        local id, name, description, displayInfo, iconImage = EJ_GetCreatureInfo(1)
                    end

                    if encounterID then
                        local name = UnitName("target")
                        local health = UnitHealthMax("target")
                        local level = UnitLevel("target")
                        local creatureType = UnitCreatureType("target")
                        local x,y = frameX,-frameY
                        local s = string.format('[1] = {\n            ["name"] = "%s",\n            ["health"] = %s,\n            ["encounterID"] = %s,\n            ["level"] = %s,\n            ["creatureType"] = "%s",\n            ["id"] = %s,\n            ["x"] = %s,\n            ["y"] = %s,\n        },',name,health,encounterID,level,creatureType,id,x,y)

                        Dialog:Spawn("MethodDungeonToolsPosCopyDialog", {pos=s})
                    end
                end
            end,
        })
        tinsert(MethodDungeonTools.contextMenuList, {
            text = " ",
            notClickable = 1,
            notCheckable = 1,
            func = nil
        })
    end


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
		frame.scrollFrame:SetScript("OnMouseDown", function(self, button)
			local scrollFrame = MethodDungeonTools.main_frame.scrollFrame			
			if ( button == "LeftButton" and scrollFrame.zoomedIn ) then
				scrollFrame.panning = true;
				local x, y = GetCursorPosition();
				scrollFrame.cursorX = x;
				scrollFrame.cursorY = y;
				scrollFrame.x = scrollFrame:GetHorizontalScroll();
				scrollFrame.y = scrollFrame:GetVerticalScroll();
				scrollFrame.moved = false;
			end
		end)

		frame.scrollFrame:SetScript("OnMouseUp", function(self, button)			
			local scrollFrame = MethodDungeonTools.main_frame.scrollFrame
			if ( button == "LeftButton") then
                frame.contextDropdown:Hide()
				if scrollFrame.panning then scrollFrame.panning = false end
				--handle clicks on enemy blips
				if MouseIsOver(MethodDungeonToolsScrollFrame) then
					for i=1,numDungeonEnemyBlips do
						if MouseIsOver(dungeonEnemyBlips[i]) then
							local isCTRLKeyDown = IsControlKeyDown() 
							MethodDungeonTools:AddOrRemoveEnemyBlipToCurrentPull(i,not dungeonEnemyBlips[i].selected,isCTRLKeyDown)
							MethodDungeonTools:UpdateEnemyBlipSelection(i,nil,isCTRLKeyDown)
							MethodDungeonTools:UpdateEnemiesSelected()	
							break;
						end
					end
					
				end
			elseif (button=="RightButton") and MouseIsOver(MethodDungeonToolsScrollFrame) then
				cursorX, cursorY = GetCursorPosition()
				L_EasyMenu(MethodDungeonTools.contextMenuList, frame.contextDropdown, "cursor", 0 , -15, "MENU",5)
                frame.contextDropdown:Show()
			end
		end)
		
		frame.scrollFrame:SetScript("OnHide", function() 
			tooltipLastShown = nil
			tooltip.Model:Hide()
			tooltip:Hide()
		end)
		
		frame.scrollFrame:SetScript("OnUpdate", function(self, button)
		
		
			local scrollFrame = MethodDungeonTools.main_frame.scrollFrame
			local cursorX, cursorY = GetCursorPosition();			
			local relativeFrame = UIParent		--UIParent		
			local mapPanelFrame = MethodDungeonTools.main_frame.mapPanelFrame
			local mapScale = mapPanelFrame:GetScale()
			local scrollH = scrollFrame:GetHorizontalScroll();
			local scrollV = scrollFrame:GetVerticalScroll();
			local frameX = (cursorX / relativeFrame:GetScale()) - scrollFrame:GetLeft();
			local frameY = scrollFrame:GetTop() - (cursorY / relativeFrame:GetScale());
			frameX=(frameX/mapScale)+scrollH
			frameY=(frameY/mapScale)+scrollV
			
			
			--MethodDungeonTools.main_frame.topPanelString:SetText(string.format("%.1f",frameX).."    "..string.format("%.1f",frameY));

			
			if ( scrollFrame.panning ) then
				local x, y = GetCursorPosition();
				MethodDungeonTools:OnPan(x, y);
			end
			
			--handle mouseover on enemy blips
			local mouseoverBlip 
			if MouseIsOver(MethodDungeonToolsScrollFrame) then
				for i=1,numDungeonEnemyBlips do
					if MouseIsOver(dungeonEnemyBlips[i]) then
						mouseoverBlip = i
						break;
					end
				end
			end
			local mouseOverBoss
			--handle mouseover on bosses
			if MouseIsOver(MethodDungeonToolsScrollFrame) then
				for k,v in pairs(dungeonBossButtons) do
					if MouseIsOver(v) then
						mouseoverBlip = nil
						mouseOverBoss = k
						break
					end
				end
			end
			if mouseOverBoss then
				local data 
			
			end

			if mouseoverBlip then
				local data = dungeonEnemyBlips[mouseoverBlip]
				local fortified = false
				local boss = false
				if db.presets[db.currentDungeonIdx][db.currentPreset[db.currentDungeonIdx]].value.currentAffix then
					if db.presets[db.currentDungeonIdx][db.currentPreset[db.currentDungeonIdx]].value.currentAffix == "fortified" then fortified = true end
				end
				local tyrannical = not fortified
				local health = MethodDungeonTools:CalculateEnemyHealth(boss,fortified,tyrannical,data.health,db.currentDifficulty)
				local group = data.g and " (G "..data.g..")" or ""
				tooltip.String:SetText("\n\n"..data.name.." "..data.cloneIdx..group.."\nLevel "..data.level.." "..data.creatureType.."\n"..MethodDungeonTools:FormatEnemyHealth(health).." HP\n".."Enemy Forces: "..data.count)
				tooltip.String:Show()
				tooltip:Show()
                if db.tooltipInCorner then
                    tooltip:SetPoint("BOTTOMRIGHT",MethodDungeonTools.main_frame,"BOTTOMRIGHT",0,0)
                    tooltip:SetPoint("TOPLEFT",MethodDungeonTools.main_frame,"BOTTOMRIGHT",-tooltip.mySizes.x,tooltip.mySizes.y)
                else
                    --check for bottom clipping
                    tooltip:SetPoint("TOPLEFT",dungeonEnemyBlips[mouseoverBlip],"BOTTOMRIGHT",30,0)
                    tooltip:SetPoint("BOTTOMRIGHT",dungeonEnemyBlips[mouseoverBlip],"BOTTOMRIGHT",30+tooltip.mySizes.x,-tooltip.mySizes.y)
                    local bottomOffset = 0
                    local rightOffset = 0
                    local tooltipBottom = tooltip:GetBottom()
                    local mainFrameBottom = MethodDungeonTools.main_frame:GetBottom()
                    if tooltipBottom<mainFrameBottom then
                        bottomOffset = tooltip.mySizes.y
                    end
                    --right side clipping
                    local tooltipRight = tooltip:GetRight()
                    local mainFrameRight = MethodDungeonTools.main_frame:GetRight()
                    if tooltipRight>mainFrameRight then
                        rightOffset = -(tooltip.mySizes.x+60)
                    end

                    tooltip:SetPoint("TOPLEFT",dungeonEnemyBlips[mouseoverBlip],"BOTTOMRIGHT",30+rightOffset,bottomOffset)
                    tooltip:SetPoint("BOTTOMRIGHT",dungeonEnemyBlips[mouseoverBlip],"BOTTOMRIGHT",30+tooltip.mySizes.x+rightOffset,-tooltip.mySizes.y+bottomOffset)
                end
				local id = dungeonEnemyBlips[mouseoverBlip].id
				if id then
					if lastModelId then 
						if lastModelId ~= id then 
							tooltip.Model:SetCreature(id)
							lastModelId = id
						end
					else
						tooltip.Model:SetCreature(id)
						lastModelId = id
					end
					tooltip.Model:Show()
				else 
					tooltip.Model:ClearModel()
					tooltip.Model:Hide()
				end
				
				lastMouseoverBlip = mouseoverBlip				
				tooltipLastShown = GetTime()
				if dungeonEnemyBlipMouseoverHighlight then
					dungeonEnemyBlipMouseoverHighlight:SetPoint("TOPLEFT", dungeonEnemyBlips[mouseoverBlip] ,"TOPLEFT", 0, 0)
					dungeonEnemyBlipMouseoverHighlight:SetPoint("BOTTOMRIGHT", dungeonEnemyBlips[mouseoverBlip] ,"BOTTOMRIGHT", -1, 0)					
					dungeonEnemyBlipMouseoverHighlight:Show()
				end


				--check if blip is in a patrol but not the "leader"
				if data.patrolFollower then
					for blipIdx,blip in pairs(dungeonEnemyBlips) do
						if blip:IsShown() and blip.g and data.g then
							if blip.g == data.g and blip.patrol then
								mouseoverBlip = blipIdx
							end
						end
					end
				end

				--display patrol waypoints and lines
				for idx,blip in pairs(dungeonEnemyBlips) do
					if blip.patrol then	
						if idx == mouseoverBlip and blip.patrolActive then
							for patrolIdx,waypointBlip in ipairs(blip.patrol) do
                                if waypointBlip.isActive then
                                    waypointBlip:Show()
                                    waypointBlip.line:Show()
                                end
							end
							if blip.patrolIndicator then
								blip.patrolIndicator:Show()
							end
							if blip.patrolIndicator2 and blip.patrolIndicator2.active then
								blip.patrolIndicator2:Show()
							end
						else
							for patrolIdx,waypointBlip in ipairs(blip.patrol) do
								waypointBlip:Hide()
								waypointBlip.line:Hide()
							end
							if blip.patrolIndicator then
								blip.patrolIndicator:Hide()
							end
							if blip.patrolIndicator2 then
								blip.patrolIndicator2:Hide()
							end
						end
					end
				end

				
			elseif tooltipLastShown and GetTime()-tooltipLastShown>0.2 then
				tooltipLastShown = nil
				--GameTooltip:Hide()
				tooltip.Model:Hide()
				tooltip:Hide()
				if dungeonEnemyBlipMouseoverHighlight then
					dungeonEnemyBlipMouseoverHighlight:Hide()
				end
				--hide all patrol waypoints and facing indicators
				for blipIdx,blip in pairs(dungeonEnemyBlips) do
					if blip.patrol then
						for patrolIdx,waypointBlip in ipairs(blip.patrol) do
							waypointBlip:Hide()
							waypointBlip.line:Hide()
						end
						if blip.patrolIndicator then
							blip.patrolIndicator:Hide()
						end
						if blip.patrolIndicator2 then
							blip.patrolIndicator2:Hide()
						end
					end
				end				
			end

			--mouseover pull button
			--[[

			elseif mouseOverPullButton then
				--tooltip.String:Show()
				--tooltip:Show()
				--tooltipLastShown = GetTime()


			local mouseOverPullButton
			if MouseIsOver(MethodDungeonTools.main_frame.sidePanel.pullButtonsScrollFrame.frame) then
				for idx,_ in pairs(MethodDungeonTools.main_frame.sidePanel.newPullButtons) do
					mouseOverPullButton = idx
					break
				end
			end

			]]




            MethodDungeonTools:UpdatePullTooltip(MethodDungeonTools.pullTooltip)



        end)


		
		if frame.mapPanelFrame == nil then
			frame.mapPanelFrame = CreateFrame("frame","MethodDungeonToolsMapPanelFrame",nil)
			frame.mapPanelFrame:ClearAllPoints();
			frame.mapPanelFrame:SetSize(frame:GetWidth(), frame:GetHeight());
			frame.mapPanelFrame:SetPoint("BOTTOM", frame, "BOTTOM", 0, 0);
			
		end

		
		--mouseover glow tex
		do
			if not dungeonEnemyBlipMouseoverHighlight then
				dungeonEnemyBlipMouseoverHighlight = MethodDungeonTools.main_frame.mapPanelFrame:CreateTexture("MethodDungeonToolsDungeonEnemyBlipMouseoverHighlight","BACKGROUND")
				dungeonEnemyBlipMouseoverHighlight:SetDrawLayer("ARTWORK", 4);				
				dungeonEnemyBlipMouseoverHighlight:SetTexture("Interface\\MINIMAP\\TRACKING\\Target")
				dungeonEnemyBlipMouseoverHighlight:SetVertexColor(1,1,1,1)
				dungeonEnemyBlipMouseoverHighlight:SetWidth(10)
				dungeonEnemyBlipMouseoverHighlight:SetHeight(10)
				dungeonEnemyBlipMouseoverHighlight:Hide()
			end
		end
		
		--create the 12 tiles and set the scrollchild
		for i=1,12 do
			frame["mapPanelTile"..i] = frame.mapPanelFrame:CreateTexture("MethodDungeonToolsmapPanelTile"..i, "BACKGROUND");
			frame["mapPanelTile"..i]:SetDrawLayer("ARTWORK", 0);
			--frame["mapPanelTile"..i]:SetAlpha(0.3)
			frame["mapPanelTile"..i]:SetSize(frame:GetWidth()/4+4,frame:GetWidth()/4+4);
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
function MethodDungeonTools:CalculateEnemyHealth(boss,fortified,tyrannical,baseHealth,level)
	local mult = 1
	if boss == false and fortified == true then mult = 1.2 end
	if boss == true and tyrannical == true then mult = 1.4 end
	mult = round((1.1^(level-1))*mult,2)
	return round(mult*baseHealth,0)
end

function MethodDungeonTools:FormatEnemyHealth(amount)
	amount = tonumber(amount)
	if amount<1000 then return ""; end
    if amount<10000 then return string.sub(amount,1,1).."k"; end --1k
    if amount<100000 then return string.sub(amount,1,2).."k"; end --10k
    if amount<1000000 then return string.sub(amount,1,3).."k"; end --100k
    if amount<10000000 then return string.sub(amount,1,1).."."..string.sub(amount,2,3).."m"; end --1.11m
    if amount<100000000 then return string.sub(amount,1,2).."."..string.sub(amount,3,4).."m"; end --11.11m
    if amount<1000000000 then return string.sub(amount,1,3).."."..string.sub(amount,4,5).."m"; end --111.11m
    return string.sub(amount,1,1).."."..string.sub(amount,2,3).."b"; --1.11b
end

function MethodDungeonTools:DisplayEncounterInformation(encounterID)
	
	--print(db.currentDungeonIdx)
	
	
end

function MethodDungeonTools:MakeDungeonBossButtons(frame)
	if not dungeonBossButtons then
		dungeonBossButtons = {}
		for i=1,5 do
			dungeonBossButtons[i] = CreateFrame("Button", "MethodDungeonToolsBossButton"..i, frame.mapPanelFrame, "EncounterMapButtonTemplate");
			dungeonBossButtons[i]:SetScript("OnClick",nil)
			dungeonBossButtons[i]:SetSize(25,25)
			dungeonBossButtons[i]:Hide()
		end
	end
end

function MethodDungeonTools:UpdateDungeonBossButtons()
	if dungeonBossButtons then
		for i=1,5 do
			dungeonBossButtons[i]:Hide()
			if MethodDungeonTools.dungeonBosses[db.currentDungeonIdx] and MethodDungeonTools.dungeonBosses[db.currentDungeonIdx][db.presets[db.currentDungeonIdx][db.currentPreset[db.currentDungeonIdx]].value.currentSublevel] and MethodDungeonTools.dungeonBosses[db.currentDungeonIdx][db.presets[db.currentDungeonIdx][db.currentPreset[db.currentDungeonIdx]].value.currentSublevel][i] then
				local data = MethodDungeonTools.dungeonBosses[db.currentDungeonIdx][db.presets[db.currentDungeonIdx][db.currentPreset[db.currentDungeonIdx]].value.currentSublevel][i]
				dungeonBossButtons[i].tooltipTitle = data["name"]
				local encounterID = data["encounterID"]
				local _, _, _, displayInfo = EJ_GetCreatureInfo(1, encounterID);
				dungeonBossButtons[i].displayInfo = displayInfo;
				if ( displayInfo ) then
					SetPortraitTexture(dungeonBossButtons[i].bgImage, displayInfo);
					dungeonBossButtons[i]:Show()
				else
					dungeonBossButtons[i].bgImage:SetTexture("DoesNotExist");
				end
				dungeonBossButtons[i].bgImage:SetSize(16,16)
				dungeonBossButtons[i]:SetScript("OnClick",function()
					if MouseIsOver(MethodDungeonToolsScrollFrame) then
						MethodDungeonTools:DisplayEncounterInformation(encounterID)
					end
				end)
				dungeonBossButtons[i]:SetPoint("CENTER",MethodDungeonTools.main_frame.mapPanelTile1,"TOPLEFT",data["x"],data["y"])
				
			end
		end
	end
end


local patrolColor = {r=0,g=.5,b=1,a=0.8}

function MethodDungeonTools:UpdateDungeonEnemies()
	if not dungeonEnemyBlips then
		dungeonEnemyBlips = {}
	end	
	for k,v in pairs(dungeonEnemyBlips) do
		v:Hide()
		if v.patrolIndicator then v.patrolIndicator:Hide() end
	end
	local idx = 1
	if MethodDungeonTools.dungeonEnemies[db.currentDungeonIdx] then
		local enemies = MethodDungeonTools.dungeonEnemies[db.currentDungeonIdx]
		for enemyIdx,data in pairs(enemies) do
			for cloneIdx,clone in pairs(data["clones"]) do
				--check sublevel
				if (clone.sublevel and clone.sublevel == db.presets[db.currentDungeonIdx][db.currentPreset[db.currentDungeonIdx]].value.currentSublevel) or ((not clone.sublevel) and db.presets[db.currentDungeonIdx][db.currentPreset[db.currentDungeonIdx]].value.currentSublevel == 1) then
					--check for teeming
					local teeming = db.presets[db.currentDungeonIdx][db.currentPreset[db.currentDungeonIdx]].value.teeming
					if (teeming==true) or (teeming==false and ((not clone.teeming) or clone.teeming==false))  then
						if not dungeonEnemyBlips[idx] then 
							dungeonEnemyBlips[idx] = MethodDungeonTools.main_frame.mapPanelFrame:CreateTexture("MethodDungeonToolsDungeonEnemyBlip"..idx,"BACKGROUND")
							dungeonEnemyBlips[idx].selected = false
						end
						dungeonEnemyBlips[idx].count = data["count"]
						dungeonEnemyBlips[idx].name = data["name"]
						dungeonEnemyBlips[idx].color = data["color"]

						dungeonEnemyBlips[idx].cloneIdx = cloneIdx
						dungeonEnemyBlips[idx].enemyIdx = enemyIdx
						dungeonEnemyBlips[idx].id = data["id"]	
						dungeonEnemyBlips[idx].g = clone.g
						dungeonEnemyBlips[idx].sublevel = clone.sublevel or 1							
						dungeonEnemyBlips[idx].creatureType = data["creatureType"]				
						dungeonEnemyBlips[idx].health = data["health"]
						dungeonEnemyBlips[idx].level = data["level"]
						dungeonEnemyBlips[idx]:SetDrawLayer("ARTWORK", 5)
						dungeonEnemyBlips[idx]:SetTexture("Interface\\Worldmap\\WorldMapPartyIcon")
						dungeonEnemyBlips[idx]:SetWidth(10*data["scale"])
						dungeonEnemyBlips[idx]:SetHeight(10*data["scale"])
						dungeonEnemyBlips[idx]:SetPoint("CENTER",MethodDungeonTools.main_frame.mapPanelTile1,"TOPLEFT",clone.x,clone.y)

                        --color patrol
                        dungeonEnemyBlips[idx].patrolFollower = nil
                        if clone.patrol then
                            dungeonEnemyBlips[idx]:SetTexture("Interface\\Worldmap\\WorldMapPlayerIcon")
                            dungeonEnemyBlips[idx].color = patrolColor
                        else
                            --iterate over all enemies again to find if this npc is linked to a patrol
                            for _,patrolCheckData in pairs(enemies) do
                                for _,patrolCheckClone in pairs(patrolCheckData["clones"]) do
                                    --check sublevel
                                    if (patrolCheckClone.sublevel and patrolCheckClone.sublevel == db.presets[db.currentDungeonIdx][db.currentPreset[db.currentDungeonIdx]].value.currentSublevel) or ((not patrolCheckClone.sublevel) and db.presets[db.currentDungeonIdx][db.currentPreset[db.currentDungeonIdx]].value.currentSublevel == 1) then
                                        --check for teeming
                                        local patrolCheckDataTeeming = db.presets[db.currentDungeonIdx][db.currentPreset[db.currentDungeonIdx]].value.teeming
                                        if (patrolCheckDataTeeming==true) or (patrolCheckDataTeeming==false and ((not patrolCheckClone.teeming) or patrolCheckClone.teeming==false))  then
                                            if clone.g and patrolCheckClone.g then
                                                if clone.g == patrolCheckClone.g and patrolCheckClone.patrol then
                                                    dungeonEnemyBlips[idx]:SetTexture("Interface\\Worldmap\\WorldMapPlayerIcon")
                                                    dungeonEnemyBlips[idx].color = patrolColor
                                                    dungeonEnemyBlips[idx].patrolFollower = true
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        end

						if dungeonEnemyBlips[idx].selected == true then dungeonEnemyBlips[idx]:SetVertexColor(0,1,0,1) else
							local r,g,b,a = dungeonEnemyBlips[idx].color.r,dungeonEnemyBlips[idx].color.g,dungeonEnemyBlips[idx].color.b,dungeonEnemyBlips[idx].color.a
							dungeonEnemyBlips[idx]:SetVertexColor(r,g,b,a)							
						end



						
						dungeonEnemyBlips[idx]:Show()
						
						
						--clear patrol flag
						if dungeonEnemyBlips[idx].patrol then
							dungeonEnemyBlips[idx].patrolActive = nil
						end
						
						
						--patrol waypoints/lines
						if clone.patrol then
							if clone.patrolFacing then
								if not dungeonEnemyBlips[idx].patrolIndicator then
									dungeonEnemyBlips[idx].patrolIndicator = MethodDungeonTools.main_frame.mapPanelFrame:CreateTexture("MethodDungeonToolsDungeonEnemyBlip"..idx.."PatrolIndicator","BACKGROUND")
								end
								dungeonEnemyBlips[idx].patrolIndicator:SetDrawLayer("ARTWORK", 6)
								dungeonEnemyBlips[idx].patrolIndicator:SetTexture("Interface\\MINIMAP\\ROTATING-MINIMAPGROUPARROW")
								dungeonEnemyBlips[idx].patrolIndicator:SetWidth(18)
								dungeonEnemyBlips[idx].patrolIndicator:SetHeight(18)
								dungeonEnemyBlips[idx].patrolIndicator:SetVertexColor(1,1,1,0.8)
								local xoffset = clone.patrolFacing < 2/4*(pi) and -0.5 or 0
								dungeonEnemyBlips[idx].patrolIndicator:SetPoint("BOTTOM",dungeonEnemyBlips[idx],"CENTER",xoffset,-9.5)
								dungeonEnemyBlips[idx].patrolIndicator:SetRotation(clone.patrolFacing,0.5,0.8)
								dungeonEnemyBlips[idx].patrolIndicator:Hide()
							end

							if clone.patrolFacing2 then
								if not dungeonEnemyBlips[idx].patrolIndicator2 then
									dungeonEnemyBlips[idx].patrolIndicator2 = MethodDungeonTools.main_frame.mapPanelFrame:CreateTexture("MethodDungeonToolsDungeonEnemyBlip"..idx.."PatrolIndicator2","BACKGROUND")
								end
								dungeonEnemyBlips[idx].patrolIndicator2:SetDrawLayer("ARTWORK", 6)
								dungeonEnemyBlips[idx].patrolIndicator2:SetTexture("Interface\\MINIMAP\\ROTATING-MINIMAPGROUPARROW")
								dungeonEnemyBlips[idx].patrolIndicator2:SetWidth(18)
								dungeonEnemyBlips[idx].patrolIndicator2:SetHeight(18)
								dungeonEnemyBlips[idx].patrolIndicator2:SetVertexColor(1,1,1,0.8)
								local xoffset = clone.patrolFacing2 < 2/4*(pi) and -0.5 or 0
								dungeonEnemyBlips[idx].patrolIndicator2:SetPoint("BOTTOM",dungeonEnemyBlips[idx],"CENTER",xoffset,-9.5)
								dungeonEnemyBlips[idx].patrolIndicator2:SetRotation(clone.patrolFacing2,0.5,0.8)
								dungeonEnemyBlips[idx].patrolIndicator2:Hide()
								dungeonEnemyBlips[idx].patrolIndicator2.active = true
							elseif dungeonEnemyBlips[idx].patrolIndicator2 then
								dungeonEnemyBlips[idx].patrolIndicator2.active = nil
							end


							dungeonEnemyBlips[idx].patrol = dungeonEnemyBlips[idx].patrol or {}
							local firstWaypointBlip
							local oldWaypointBlip

                            for k,v in pairs(dungeonEnemyBlips[idx].patrol) do
                                v.isActive = false
                            end

							for patrolIdx,waypoint in ipairs(clone.patrol) do
								if not dungeonEnemyBlips[idx].patrol[patrolIdx] then
								dungeonEnemyBlips[idx].patrol[patrolIdx] = MethodDungeonTools.main_frame.mapPanelFrame:CreateTexture("MethodDungeonToolsDungeonEnemyBlip"..idx.."Patrol"..patrolIdx,"BACKGROUND")
								end
								dungeonEnemyBlips[idx].patrol[patrolIdx]:SetDrawLayer("ARTWORK", 5)				
								dungeonEnemyBlips[idx].patrol[patrolIdx]:SetTexture("Interface\\Worldmap\\X_Mark_64Grey")
								dungeonEnemyBlips[idx].patrol[patrolIdx]:SetWidth(10*0.4)
								dungeonEnemyBlips[idx].patrol[patrolIdx]:SetHeight(10*0.4)
								dungeonEnemyBlips[idx].patrol[patrolIdx]:SetVertexColor(0,0.2,0.5,0.6) 
								dungeonEnemyBlips[idx].patrol[patrolIdx]:SetPoint("CENTER",MethodDungeonTools.main_frame.mapPanelTile1,"TOPLEFT",waypoint.x,waypoint.y)
								dungeonEnemyBlips[idx].patrol[patrolIdx]:Hide()
								dungeonEnemyBlips[idx].patrol[patrolIdx].isActive = true

								if not dungeonEnemyBlips[idx].patrol[patrolIdx].line then
									dungeonEnemyBlips[idx].patrol[patrolIdx].line = MethodDungeonTools.main_frame.mapPanelFrame:CreateTexture("MethodDungeonToolsDungeonEnemyBlip"..idx.."Patrol"..patrolIdx.."line","BACKGROUND")
								end
								dungeonEnemyBlips[idx].patrol[patrolIdx].line:SetDrawLayer("ARTWORK", 5)
								dungeonEnemyBlips[idx].patrol[patrolIdx].line:SetTexture("Interface\\AddOns\\MethodDungeonTools\\Textures\\Square_White")
								dungeonEnemyBlips[idx].patrol[patrolIdx].line:SetVertexColor(0,0.2,0.5,0.6) 
								dungeonEnemyBlips[idx].patrol[patrolIdx].line:Hide()

								--connect 2 waypoints								
								if oldWaypointBlip then
									local startPoint, startRelativeTo, startRelativePoint, startX, startY = dungeonEnemyBlips[idx].patrol[patrolIdx]:GetPoint()
									local endPoint, endRelativeTo, endRelativePoint, endX, endY = oldWaypointBlip:GetPoint()
									DrawLine(dungeonEnemyBlips[idx].patrol[patrolIdx].line, MethodDungeonTools.main_frame.mapPanelTile1, startX, startY, endX, endY, 1, 1,"TOPLEFT")
									dungeonEnemyBlips[idx].patrol[patrolIdx].line:Hide()
								else
									firstWaypointBlip = dungeonEnemyBlips[idx].patrol[patrolIdx]
								end								
								oldWaypointBlip = dungeonEnemyBlips[idx].patrol[patrolIdx]
							end
							--connect last 2 waypoints
							if firstWaypointBlip and oldWaypointBlip then
								local startPoint, startRelativeTo, startRelativePoint, startX, startY = firstWaypointBlip:GetPoint()
								local endPoint, endRelativeTo, endRelativePoint, endX, endY = oldWaypointBlip:GetPoint()
								DrawLine(firstWaypointBlip.line, MethodDungeonTools.main_frame.mapPanelTile1, startX, startY, endX, endY, 1, 1,"TOPLEFT")
								firstWaypointBlip.line:Hide()
							end
							dungeonEnemyBlips[idx].patrolActive = true
						end
						
						idx = idx + 1
					end
				end
			end
		end
	end
	numDungeonEnemyBlips = idx-1	
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
	MethodDungeonTools.main_frame.presetImportBox:SetFocus()
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

function MethodDungeonTools:UpdateSidePanelCheckBoxes()
	local frame = MethodDungeonTools.main_frame	
	local affix = db.presets[db.currentDungeonIdx][db.currentPreset[db.currentDungeonIdx]].value.currentAffix	
	frame.sidePanelTyrannicalCheckBox:SetValue(affix~="fortified")
	frame.sidePanelFortifiedCheckBox:SetValue(affix=="fortified")


	local teeming = db.presets[db.currentDungeonIdx][db.currentPreset[db.currentDungeonIdx]].value.teeming
	frame.sidePanelTeemingCheckBox:SetValue(teeming)
	local teemingEnabled = MethodDungeonTools.dungeonTotalCount[db.currentDungeonIdx].teemingEnabled
	frame.sidePanelTeemingCheckBox:SetDisabled(not teemingEnabled)

end

function MethodDungeonTools:CreateDungeonPresetDropdown(frame)
	frame.DungeonPresetDropdown = dropDownLib:New(frame, nil, "Select Preset", db.presets[db.currentDungeonIdx],false)
	frame.DungeonPresetDropdown:SetPoint("TOPLEFT",frame,"TOPLEFT",5,17)
	frame.DungeonPresetDropdown:SetFrameStrata(mainFrameStrata)
	frame.DungeonPresetDropdown:SetFrameLevel(5)
	function frame.DungeonPresetDropdown:OnValueChanged(value, text)
		for presetIdx,preset in pairs(db.presets[db.currentDungeonIdx]) do
			if preset.value == value then
				if value == 0 then
					MethodDungeonTools:OpenNewPresetDialog()
					MethodDungeonTools.main_frame.sidePanelDeleteButton:SetDisabled(true)	
				else 
					if presetIdx == 1 then
						MethodDungeonTools.main_frame.sidePanelDeleteButton:SetDisabled(true)	
					else
						MethodDungeonTools.main_frame.sidePanelDeleteButton:SetDisabled(false)	
					end
					db.currentPreset[db.currentDungeonIdx] = presetIdx
					MethodDungeonTools:UpdateMap()
				end
			end
		end
	end

end

function MethodDungeonTools:CreateDungeonSelectDropdown(frame)
	
	--sublevel select
	frame.DungeonSublevelSelectDropdown = dropDownLib:New(frame, nil, "Select Sublevel", subLevelTable,false)
	frame.DungeonSublevelSelectDropdown:SetPoint("TOPLEFT",frame.topPanel,"TOPLEFT",0,-35)
	frame.DungeonSublevelSelectDropdown:SetFrameStrata(mainFrameStrata)
	frame.DungeonSublevelSelectDropdown:SetFrameLevel(5)
	function frame.DungeonSublevelSelectDropdown:OnValueChanged(value, text)
		for k,v in pairs(dungeonSubLevels[db.currentDungeonIdx]) do
			if v == text then
				db.presets[db.currentDungeonIdx][db.currentPreset[db.currentDungeonIdx]].value.currentSublevel = k
				MethodDungeonTools:UpdateMap()
                MethodDungeonTools:ZoomMap(1,true)
				return
			end
		end
	end
	
	--dungeon select
	frame.DungeonSelectDropdown = dropDownLib:New(frame, nil, "Select Dungeon", dungeonList,false)
	frame.DungeonSelectDropdown:SetPoint("TOPLEFT",frame.topPanel,"TOPLEFT",0,-10)
	frame.DungeonSelectDropdown:SetFrameStrata(mainFrameStrata)
	frame.DungeonSelectDropdown:SetFrameLevel(5)
	function frame.DungeonSelectDropdown:OnValueChanged(value, text)
		for k,v in pairs(dungeonList) do
			if v == text then
				MethodDungeonTools:UpdateToDungeon(k)
				return
			end
		end
	end
	
	
	
end

---EnsureDBTables
---Makes sure profiles are valid and have their fields set
function MethodDungeonTools:EnsureDBTables()
	db.currentPreset[db.currentDungeonIdx] = db.currentPreset[db.currentDungeonIdx] or 1
	db.presets[db.currentDungeonIdx][db.currentPreset[db.currentDungeonIdx]].value.currentAffix = db.presets[db.currentDungeonIdx][db.currentPreset[db.currentDungeonIdx]].value.currentAffix or "fortified"

    db.presets[db.currentDungeonIdx][db.currentPreset[db.currentDungeonIdx]].value.currentDungeonIdx = db.currentDungeonIdx

	db.presets[db.currentDungeonIdx][db.currentPreset[db.currentDungeonIdx]].value.teeming = db.presets[db.currentDungeonIdx][db.currentPreset[db.currentDungeonIdx]].value.teeming or false
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

end

function MethodDungeonTools:UpdateMap(ignoreSetSelection,ignoreReloadPullButtons)
	local mapPanel = self.main_frame.mapPanel
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
	MethodDungeonTools:UpdateDungeonBossButtons()
	MethodDungeonTools:UpdateDungeonEnemies()
	if not ignoreReloadPullButtons then
		MethodDungeonTools:ReloadPullButtons()
	end
	MethodDungeonTools:UpdateSidePanelCheckBoxes()
	
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
	--update Sublevel select dropdown
	frame.DungeonSublevelSelectDropdown:SetValue(dungeonSubLevels[db.currentDungeonIdx][db.presets[db.currentDungeonIdx][db.currentPreset[db.currentDungeonIdx]].value.currentSublevel])
end

---UpdateToDungeon
---Updates the map to the specified dungeon
function MethodDungeonTools:UpdateToDungeon(dungeonIdx,forceZone) --on open and dungeon change from dropdown TODO: decide if needed
    local frame = MethodDungeonTools.main_frame
    db.currentDungeonIdx = dungeonIdx
    --populate 2nd dropdown with apropritate list of sublevels
    frame.DungeonSublevelSelectDropdown:SetList(dungeonSubLevels[db.currentDungeonIdx])
    frame.DungeonSublevelSelectDropdown:SetValue(dungeonSubLevels[db.currentDungeonIdx][1])

	local zoneId = HBD:GetPlayerZone()
	--local dungIdx = zoneIdToIdx[zoneId]
	--if forceZone and dungIdx then db.currentDungeonIdx = dungIdx end TODO HERE
	if not db.presets[db.currentDungeonIdx][db.currentPreset[db.currentDungeonIdx]].value.currentSublevel then db.presets[db.currentDungeonIdx][db.currentPreset[db.currentDungeonIdx]].value.currentSublevel=1 end
	frame.DungeonSelectDropdown:SetValue(dungeonList[db.currentDungeonIdx])
	--populate 2nd dropdown with apropritate list of sublevels
	frame.DungeonSublevelSelectDropdown:SetList(dungeonSubLevels[db.currentDungeonIdx])
	frame.DungeonSublevelSelectDropdown:SetValue(dungeonSubLevels[db.currentDungeonIdx][db.presets[db.currentDungeonIdx][db.currentPreset[db.currentDungeonIdx]].value.currentSublevel])
	frame.sidePanel.DungeonPresetDropdown:SetList(db.presets[db.currentDungeonIdx])
	frame.sidePanel.DungeonPresetDropdown:SetValue(db.presets[db.currentDungeonIdx][db.currentPreset[db.currentDungeonIdx]].value)	
	MethodDungeonTools:UpdateMap()
    MethodDungeonTools:ZoomMap(1,true)
end

function MethodDungeonTools:DeletePreset(index)
	tremove(db.presets[db.currentDungeonIdx],index)
	db.currentPreset[db.currentDungeonIdx] = index-1
	MethodDungeonTools.main_frame.sidePanel.DungeonPresetDropdown:SetValue(db.presets[db.currentDungeonIdx][index-1].value)
	MethodDungeonTools:UpdateMap()
end

function MethodDungeonTools:ClearPreset(index)
	table.wipe(db.presets[db.currentDungeonIdx][index].value.pulls)
	db.presets[db.currentDungeonIdx][index].value.currentPull = 1
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
		MethodDungeonTools.main_frame.sidePanel.DungeonPresetDropdown:SetValue(db.presets[db.currentDungeonIdx][countPresets].value)	
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


function MethodDungeonTools:MakePresetImportFrame(frame)
	frame.presetImportFrame = AceGUI:Create("Frame")
	frame.presetImportFrame:SetTitle("Import Preset")
	frame.presetImportFrame:SetWidth(400)
	frame.presetImportFrame:SetHeight(200)
	frame.presetImportFrame:EnableResize(false)
	--frame.presetCreationFrame:SetCallback("OnClose", function(widget) AceGUI:Release(widget) end)
	frame.presetImportFrame:SetLayout("Flow")
	frame.presetImportFrame:SetCallback("OnClose", function(widget)
		if MethodDungeonTools.main_frame.sidePanel.DungeonPresetDropdown then
			MethodDungeonTools.main_frame.sidePanel.DungeonPresetDropdown:SetValue(db.presets[db.currentDungeonIdx][db.currentPreset[db.currentDungeonIdx]].value)
			if db.currentPreset[db.currentDungeonIdx] ~= 1 then
				MethodDungeonTools.main_frame.sidePanelDeleteButton:SetDisabled(false)
			end
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
		if MethodDungeonTools.main_frame.sidePanel.DungeonPresetDropdown then
			MethodDungeonTools.main_frame.sidePanel.DungeonPresetDropdown:SetValue(db.presets[db.currentDungeonIdx][db.currentPreset[db.currentDungeonIdx]].value)
			if db.currentPreset[db.currentDungeonIdx] ~= 1 then
				MethodDungeonTools.main_frame.sidePanelDeleteButton:SetDisabled(false)	
			end
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
	frame.presetCreationFrame:AddChild(frame.PresetCreationDropDown)

	frame.presetCreationFrame:Hide()
end

function MethodDungeonTools:ValidateImportPreset(preset)
    if type(preset) ~= "table" then return false end
    if not preset.text then return false end
    if not preset.value then return false end
    if type(preset.text) ~= "string" then return false end
    if type(preset.value) ~= "table" then return false end
    if not preset.value.currentAffix then return false end
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
	MethodDungeonTools.main_frame.sidePanel.DungeonPresetDropdown:SetValue(db.presets[db.currentDungeonIdx][countPresets].value)	
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
    frame.PullButtonScrollGroup.frame:Show()

    --dirty hook to make PullButtonScrollGroup show/hide
    local originalShow,originalHide = MethodDungeonTools.main_frame.Show,MethodDungeonTools.main_frame.Hide
    function MethodDungeonTools.main_frame:Show(...)
        frame.PullButtonScrollGroup.frame:Show()
        return originalShow(self, ...);
    end
    function MethodDungeonTools.main_frame:Hide(...)
        frame.PullButtonScrollGroup.frame:Hide()
        return originalHide(self, ...);
    end



    frame.pullButtonsScrollFrame = AceGUI:Create("ScrollFrame")
    frame.pullButtonsScrollFrame:SetLayout("Flow")

    frame.PullButtonScrollGroup:AddChild(frame.pullButtonsScrollFrame)

    frame.newPullButtons = {}



	--rightclick context menu
	frame.optionsDropDown = CreateFrame("Frame", "PullButtonsOptionsDropDown", nil, "L_UIDropDownMenuTemplate")
end


function MethodDungeonTools:PresetsAddPull(index)
	if index then
		tinsert(db.presets[db.currentDungeonIdx][db.currentPreset[db.currentDungeonIdx]].value.pulls,index,{})
	else
		tinsert(db.presets[db.currentDungeonIdx][db.currentPreset[db.currentDungeonIdx]].value.pulls,{})
	end
end

function MethodDungeonTools:PresetsDeletePull(p,j)	
	tremove(db.presets[db.currentDungeonIdx][db.currentPreset[db.currentDungeonIdx]].value.pulls,p)
	--TODO remove all pulls from j to end? bug where u have to remove multiple times to remove "invisible pulls"
	for k,v in ipairs(db.presets[db.currentDungeonIdx][db.currentPreset[db.currentDungeonIdx]].value.pulls) do
		--print(k,v,j)
	end
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

	local p1copy = MethodDungeonTools:CopyObject(db.presets[db.currentDungeonIdx][db.currentPreset[db.currentDungeonIdx]].value.pulls[p1])
	local p2copy = MethodDungeonTools:CopyObject(db.presets[db.currentDungeonIdx][db.currentPreset[db.currentDungeonIdx]].value.pulls[p2])
	db.presets[db.currentDungeonIdx][db.currentPreset[db.currentDungeonIdx]].value.pulls[p1] = p2copy
	db.presets[db.currentDungeonIdx][db.currentPreset[db.currentDungeonIdx]].value.pulls[p2] = p1copy
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
		MethodDungeonTools:UpdateMap(true,true)
	end
	
	--update dropdown
	local frame = MethodDungeonTools.main_frame
	frame.DungeonSublevelSelectDropdown:SetValue(dungeonSubLevels[db.currentDungeonIdx][db.presets[db.currentDungeonIdx][db.currentPreset[db.currentDungeonIdx]].value.currentSublevel])
    if shouldResetZoom then MethodDungeonTools:ZoomMap(1,true) end
end


function MethodDungeonTools:SetSelectionToPull(pull)
	--if pull is not specified set pull to last pull in preset (for adding new pulls)
	if not pull then
		local count = 0
		for k,v in pairs(db.presets[db.currentDungeonIdx][db.currentPreset[db.currentDungeonIdx]].value.pulls) do
			count = count + 1
		end
		pull = count
	end
	--SaveCurrentPresetPull
	db.presets[db.currentDungeonIdx][db.currentPreset[db.currentDungeonIdx]].value.currentPull = pull
	MethodDungeonTools:PickPullButton(pull)
	
	
	--deselect all 
	for k,v in pairs(dungeonEnemyBlips) do
		MethodDungeonTools:UpdateEnemyBlipSelection(k,true)
	end
	
	--highlight current pull enemies
	for enemyIdx,clones in pairs(db.presets[db.currentDungeonIdx][db.currentPreset[db.currentDungeonIdx]].value.pulls[pull]) do
		for j,cloneIdx in pairs(clones) do		
			for k,v in ipairs(dungeonEnemyBlips) do
				if (v.enemyIdx == enemyIdx) and (v.cloneIdx == cloneIdx) then
					MethodDungeonTools:UpdateEnemyBlipSelection(k,nil,true)
				end
			end
		end
	end
	
	--highlight other pull enemies
	for pullIdx,p in pairs(db.presets[db.currentDungeonIdx][db.currentPreset[db.currentDungeonIdx]].value.pulls) do
        if pullIdx~=pull then
            for enemyIdx,clones in pairs(p) do
                for j,cloneIdx in pairs(clones) do
                    for k,v in ipairs(dungeonEnemyBlips) do
                        if (v.enemyIdx == enemyIdx) and (v.cloneIdx == cloneIdx) then
                            MethodDungeonTools:UpdateEnemyBlipSelection(k,nil,true,true)
                        end
                    end
                end
            end
        end
	end
	MethodDungeonTools:UpdateEnemiesSelected()	
end

---UpdatePullButtonNPCData
---Updates the portraits display of a button to show which and how many npcs are selected
function MethodDungeonTools:UpdatePullButtonNPCData(idx)
	local preset = db.presets[db.currentDungeonIdx][db.currentPreset[db.currentDungeonIdx]]
	local frame = MethodDungeonTools.main_frame.sidePanel
    local teeming = db.presets[db.currentDungeonIdx][db.currentPreset[db.currentDungeonIdx]].value.teeming
	local enemyTable = {}
	if preset.value.pulls[idx] then
		local enemyTableIdx = 0
		for enemyIdx,clones in pairs(preset.value.pulls[idx]) do
			local incremented = false
			local npcId = MethodDungeonTools.dungeonEnemies[db.currentDungeonIdx][enemyIdx]["id"]
            local name = MethodDungeonTools.dungeonEnemies[db.currentDungeonIdx][enemyIdx]["name"]
            local creatureType = MethodDungeonTools.dungeonEnemies[db.currentDungeonIdx][enemyIdx]["creatureType"]
            local level = MethodDungeonTools.dungeonEnemies[db.currentDungeonIdx][enemyIdx]["level"]
            local baseHealth = MethodDungeonTools.dungeonEnemies[db.currentDungeonIdx][enemyIdx]["health"]
            for k,cloneIdx in pairs(clones) do
                --check for teeming
                local cloneIsTeeming = MethodDungeonTools.dungeonEnemies[db.currentDungeonIdx][enemyIdx]["clones"][cloneIdx].teeming
                if (cloneIsTeeming and teeming) or (not cloneIsTeeming and not teeming) or (not cloneIsTeeming and teeming) then
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
	frame.newPullButtons[idx]:SetNPCData(enemyTable)
end


---ReloadPullButtons
---Reloads all pull buttons in the scroll frame
function MethodDungeonTools:ReloadPullButtons()
	local frame = MethodDungeonTools.main_frame.sidePanel
	local preset = db.presets[db.currentDungeonIdx][db.currentPreset[db.currentDungeonIdx]]

	--first release all children of the scroll frame
	frame.pullButtonsScrollFrame:ReleaseChildren()

	local maxPulls =  0
	for k,v in pairs(preset.value.pulls) do
		maxPulls = maxPulls + 1
	end

	--add new children to the scrollFrame, the frames are from the widget pool so no memory is wasted

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

	--add the "new pull" button
	frame.newPullButton = AceGUI:Create("MethodDungeonToolsNewPullButton")
	frame.newPullButton:Initialize()
	frame.newPullButton:Enable()
	frame.pullButtonsScrollFrame:AddChild(frame.newPullButton)


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
	MethodDungeonTools.main_frame.sidePanel.DungeonPresetDropdown:SetValue(db.presets[db.currentDungeonIdx][db.currentPreset[db.currentDungeonIdx]].value)

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
---@param frame frame
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

	--dirty hook to make button hide
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


function initFrames()
	local main_frame = CreateFrame("frame", "MethodDungeonToolsFrame", UIParent);
	
	
	main_frame:SetFrameStrata(mainFrameStrata)
	main_frame:SetFrameLevel(1)
	main_frame.background = main_frame:CreateTexture(nil, "BACKGROUND");
	main_frame.background:SetAllPoints();
	main_frame.background:SetDrawLayer("ARTWORK", 1);
	main_frame.background:SetColorTexture(0, 0, 0, 0.5);
	main_frame.background:SetAlpha(0.2)
	main_frame:SetSize(sizex, sizey);
	MethodDungeonTools.main_frame = main_frame;	
	
	tinsert(UISpecialFrames,"MethodDungeonToolsFrame") 
	-- Set frame position
	main_frame:ClearAllPoints();
	main_frame:SetPoint(db.anchorTo, UIParent,db.anchorFrom, db.xoffset, db.yoffset);
	
	--TODO: fix all these
	main_frame:SetScript("OnEvent", function(self, ...)
		local event, loaded = ...;
		if event == "ADDON_LOADED" then
			if addon == loaded then
				--AltManager:OnLoad();
			end
		end
		if event == "PLAYER_LOGIN" then
			--AltManager:OnLogin();
		end
		if event == "PLAYER_LOGOUT" or event == "ARTIFACT_XP_UPDATE" then
			--local data = AltManager:CollectData();
			--AltManager:StoreData(data);
		end
		
	end)

    main_frame.contextDropdown = CreateFrame("Frame", "MethodDungeonToolsContextDropDown", nil, "L_UIDropDownMenuTemplate")
	
	MethodDungeonTools:CreateMenu();
	MethodDungeonTools:MakeTopBottomTextures(main_frame);
	MethodDungeonTools:MakeMapTexture(main_frame)
	MethodDungeonTools:MakeSidePanel(main_frame)
	MethodDungeonTools:MakePresetCreationFrame(main_frame)
	MethodDungeonTools:MakePresetImportFrame(main_frame)

	MethodDungeonTools:MakeDungeonBossButtons(main_frame)
	MethodDungeonTools:UpdateDungeonEnemies(main_frame)	
	
	MethodDungeonTools:CreateDungeonSelectDropdown(main_frame)
	MethodDungeonTools:CreateDungeonPresetDropdown(main_frame.sidePanel)
	
	MethodDungeonTools:MakePullSelectionButtons(main_frame.sidePanel)
	
	MethodDungeonTools:MakeExportFrame(main_frame)
	MethodDungeonTools:MakeRenameFrame(main_frame)
	MethodDungeonTools:MakeDeleteConfirmationFrame(main_frame)
	MethodDungeonTools:MakeClearConfirmationFrame(main_frame)

	MethodDungeonTools:CreateTutorialButton(main_frame)

	--tooltip
    do
        tooltip = CreateFrame("Frame", "MethodDungeonToolsModelTooltip", UIParent, "TooltipBorderedFrameTemplate")
        tooltip:SetClampedToScreen(true)
        tooltip:SetFrameStrata("TOOLTIP")
        tooltip.mySizes ={x=250,y=110}
        tooltip:SetSize(tooltip.mySizes.x, tooltip.mySizes.y)
        tooltip:Hide()

        tooltip.Model = CreateFrame("PlayerModel", nil, tooltip)
        tooltip.Model:SetFrameLevel(1)
        tooltip.Model:SetSize(100,100)

        tooltip.Model.fac = 0
        if true then
            tooltip.Model:SetScript("OnUpdate",function (self,elapsed)
                self.fac = self.fac + 0.5
                if self.fac >= 360 then
                    self.fac = 0
                end
                self:SetFacing(PI*2 / 360 * self.fac)
				--print(tooltip.Model:GetModelFileID())
            end)

        else
            tooltip.Model:SetPortraitZoom(1)
            tooltip.Model:SetFacing(PI*2 / 360 * 2)
        end


		tooltip.Model:SetPoint("TOPLEFT", tooltip, "TOPLEFT",7,-7)
		
		tooltip.String = tooltip:CreateFontString("MethodDungeonToolsToolTipString");
		tooltip.String:SetFont("Fonts\\FRIZQT__.TTF", 10)
		tooltip.String:SetTextColor(1, 1, 1, 1);
		tooltip.String:SetJustifyH("LEFT")
		tooltip.String:SetJustifyV("CENTER")
		tooltip.String:SetWidth(tooltip:GetWidth())
		tooltip.String:SetHeight(80)
		tooltip.String:SetWidth(120)
		tooltip.String:SetText(" ");
		tooltip.String:SetPoint("TOPLEFT", tooltip, "TOPLEFT", 110, -7)
		tooltip.String:Show();
	end

	--pullTooltip
	do
		MethodDungeonTools.pullTooltip = CreateFrame("Frame", "MethodDungeonToolsPullTooltip", UIParent, "TooltipBorderedFrameTemplate")
		MethodDungeonTools.pullTooltip:SetClampedToScreen(true)
		MethodDungeonTools.pullTooltip:SetFrameStrata("TOOLTIP")
        MethodDungeonTools.pullTooltip.myHeight = 160
		MethodDungeonTools.pullTooltip:SetSize(250, MethodDungeonTools.pullTooltip.myHeight)
		MethodDungeonTools.pullTooltip:Hide()

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
                --print(tooltip.Model:GetModelFileID())
            end)

        else
            MethodDungeonTools.pullTooltip.Model:SetPortraitZoom(1)
            MethodDungeonTools.pullTooltip.Model:SetFacing(PI*2 / 360 * 2)
        end

        MethodDungeonTools.pullTooltip.Model:SetSize(110,110)
        MethodDungeonTools.pullTooltip.Model:SetPoint("TOPLEFT", MethodDungeonTools.pullTooltip, "TOPLEFT",7,-7)

        MethodDungeonTools.pullTooltip.topString = MethodDungeonTools.pullTooltip:CreateFontString("MethodDungeonToolsToolTipString")
        MethodDungeonTools.pullTooltip.topString:SetFont("Fonts\\FRIZQT__.TTF", 10)
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
        botString:SetFont("Fonts\\FRIZQT__.TTF", 10)
        botString:SetTextColor(1, 1, 1, 1);
        botString:SetJustifyH("TOP")
        botString:SetJustifyV("TOP")
        botString:SetHeight(23)
        botString:SetWidth(250)
        botString.defaultText = "Enemy Forces: %d\nTotal: %d/%d"
        botString:SetPoint("TOPLEFT", heading, "LEFT", -12, -7)
        botString:Hide()

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
                name = "Chose npc tooltip position",
                desc = "Where the tooltip should be positioned",
                values = {
                    [1] = "Next to the npc",
                    [2] = "In the bottom right corner",
                },
                get = function() return db.tooltipInCorner and 2 or 1 end,
                set = function(_,newValue)
                    if newValue == 1 then db.tooltipInCorner = false end
                    if newValue == 2 then db.tooltipInCorner = true end
                end,
                style = 'radio',
            }
		}
	}
	MethodDungeonTools:RegisterOptions()

	main_frame:Hide();
end

