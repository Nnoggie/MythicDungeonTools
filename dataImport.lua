local MDT = MDT
local L = MDT.L
local AceGUI = LibStub("AceGUI-3.0")
local db

function MDT:OpenDataImportDialog()
    MDT:HideAllDialogs()
    local f = MDT.main_frame.dataImportDialog
    f:ClearAllPoints()
    f:SetPoint("CENTER", MDT.main_frame,"CENTER",0,50)
    f:Show()
    f.editbox:SetText("")
    f.editbox:SetFocus()
    f.label:SetText(nil)
end

function MDT:ValidateDataImport(data)
    return true --TODO: y
end

function MDT:CreateDataImportDialog(frame)
    frame.dataImportDialog = AceGUI:Create("Frame")
    local f = frame.dataImportDialog
    f:SetTitle(L["Import Data"])
    f:SetWidth(400)
    f:SetHeight(200)
    f:EnableResize(false)
    f:SetLayout("Flow")
    f:SetCallback("OnClose", function(widget)
    end)

    f.label = AceGUI:Create("Label")
    f.label:SetText(nil)
    f.label:SetWidth(390)
    f.label:SetColor(1,0,0)

    local importString	= ""
    f.editbox = AceGUI:Create("EditBox")
    f.editbox:SetLabel(L["Import Data"]..":")
    f.editbox:SetWidth(255)
    f.editbox:SetCallback("OnEnterPressed", function(widget, event, text) importString = text end)
    f:AddChild(f.editbox)

    local importButton = AceGUI:Create("Button")
    importButton:SetText(L["Import"])
    importButton:SetWidth(100)
    importButton:SetCallback("OnClick", function()
        local data = MDT:StringToTable(importString, true)
        if MDT:ValidateDataImport(data) then
            db = MDT:GetDB()
            for dungeonIdx,dungeonData in pairs(data) do
                db.dungeonImport[dungeonIdx] = dungeonData
            end
            ReloadUI()
        else
            frame.presetImportLabel:SetText(L["Invalid import string"])
        end
    end)
    f:AddChild(importButton)
    f:AddChild(frame.presetImportLabel)
    f:Hide()
end

function MDT:OpenNoDungeonDataWarning()
    local f = MDT.main_frame.noDungeonDataWarning
    f:ClearAllPoints()
    f:SetPoint("CENTER", MDT.main_frame,"CENTER",0,50)
    f:Show()
end

function MDT:CreateNoDungeonDataWarning(frame)
    frame.noDungeonDataWarning = AceGUI:Create("Frame")
    local f = frame.noDungeonDataWarning
    f:SetTitle(L["Dungeon Data Missing"])
    f:SetWidth(600)
    f:SetHeight(220)
    f:EnableResize(false)
    f:SetLayout("Flow")
    f:SetCallback("OnClose", function(widget)
    end)

    f.label = AceGUI:Create("Label")
    f.label:SetText(L["noDungeonData1"].."\n"..L["noDungeonData2"])
    f.label:SetWidth(550)
    f.label:SetHeight(50)
    f.label:SetColor(1,0,0)
    f.label.frame:SetScale(1.75)
    f:AddChild(f.label)

    f.curseforge = AceGUI:Create("EditBox")
    f.curseforge:SetLabel("Curseforge:")
    f.curseforge:SetText("https://www.curseforge.com/wow/addons/mythic-dungeon-tools")
    f.curseforge:SetWidth(450)
    f:AddChild(f.curseforge)

    f:Hide()

end