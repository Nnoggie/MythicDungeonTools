local AceGUI = LibStub("AceGUI-3.0")
local MDT = MDT
local db
local tonumber,tinsert,slen,pairs,ipairs,tostring,next,type,sformat = tonumber,table.insert,string.len,pairs,ipairs,tostring,next,type,string.format
local UnitName,UnitGUID,UnitCreatureType,UnitHealthMax,UnitLevel = UnitName,UnitGUID,UnitCreatureType,UnitHealthMax,UnitLevel

--[[
How to map:
1. /mdt devmode
2. Install Plater Mod that adds NPCs on Nameplate Added event
    Tov0UTniu0)f)KJuIvstI7sL2dBnQtTsnlsK8uvzMaxNGggqaol7f(231XwZUR9XjKGZ1W5Cpx4A6m6okzgL886DXINzwRuFebgbLe(TfOKtgZpPK5ucLCdDZS5lMphp(seUC1Yz53KViNswGcict(UtEW4PKBXDPKCCgxw1KHnSkWQybiw8fHaq1lR18G0OJfPEqvoowuRLHhfDGhCided6Z7yhunWkJ4kCu8Pyr7aD9DOEB2E)dot1EKxARkdot8jqlWqC8gFS3kW1)xozYeP2dUqSGBeO6Nahm0d9N7Lx6JugotflowlfXIppiFzACABJrBkQVT)X1VJuhf0YapKMp2hCERcVbsMKmUrXrdS3vPCzei83BG7nkJdR5H1yYrha6KyXOpY7Dj2Bz)sJgAq2V9TzVTIgM)Huxd8RCdgDD1bWLMm9sswwNSVNuaUe(NBNtatfo9vMltjlHTGJd6qpXgg3H16oCnTx3xF9J7kcuYNAAsdmfkdIWpC0zQTTqUI59TWkM9hsrxGZOGwK9SDixhJ3TbRSuEPfcAUPwJpc9c4Ta)kcXbd)m48yBiDZQPtNI)4WecmI0(0rjgBttQVJa9p)
3. Call MDT:AddNPCFromUnit("mouseover") with macro to add untargetable units
4. Use Keybinds to add NPCs and patrolpaths to the map
]]

local function tshow(t, name, indent)
    local cart     -- a container
    local autoref  -- for self references

    --[[ counts the number of elements in a table
    local function tablecount(t)
       local n = 0
       for _, _ in pairs(t) do n = n+1 end
       return n
    end
    ]]
    -- (RiciLake) returns true if the table is empty
    local function isemptytable(t) return next(t) == nil end

    local function basicSerialize (o)
        local so = tostring(o)
        if type(o) == "function" then
            local info = debug.getinfo(o, "S")
            -- info.name is nil because o is not a calling level
            if info.what == "C" then
                return sformat("%q", so .. ", C function")
            else
                -- the information is defined through lines
                return sformat("%q", so .. ", defined in (" ..
                        info.linedefined .. "-" .. info.lastlinedefined ..
                        ")" .. info.source)
            end
        elseif type(o) == "number" or type(o) == "boolean" then
            return so
        else
            return sformat("%q", so)
        end
    end

    local function addtocart (value, name, indent, saved, field)
        indent = indent or ""
        saved = saved or {}
        field = field or name

        cart = cart .. indent .. field

        if type(value) ~= "table" then
            cart = cart .. " = " .. basicSerialize(value) .. ";\n"
        else
            if saved[value] then
                cart = cart .. " = {}; -- " .. saved[value]
                        .. " (self reference)\n"
                autoref = autoref ..  name .. " = " .. saved[value] .. ";\n"
            else
                saved[value] = name
                --if tablecount(value) == 0 then
                if isemptytable(value) then
                    cart = cart .. " = {};\n"
                else
                    cart = cart .. " = {\n"
                    for k, v in pairs(value) do
                        k = basicSerialize(k)
                        local fname = sformat("%s[%s]", name, k)
                        field = sformat("[%s]", k)
                        -- three spaces between levels
                        addtocart(v, fname, indent .. "   ", saved, field)
                    end
                    cart = cart .. indent .. "};\n"
                end
            end
        end
    end

    name = name or "__unnamed__"
    if type(t) ~= "table" then
        return name .. " = " .. basicSerialize(t)
    end
    cart, autoref = "", ""
    addtocart(t, name, indent)
    return cart .. autoref
end

function MDT:AddNPCFromUnit(unit)
    db = MDT:GetDB()
    local npcId
    local guid = UnitGUID(unit)
    if guid then
        npcId = select(6,strsplit("-", guid))
        npcId = tonumber(npcId)
    end
    local added
    for _,npcData in pairs(MDT.dungeonEnemies[db.currentDungeonIdx]) do
        if npcData.id == npcId then added = true; break end
    end
    if npcId and not added then
        local npcName = UnitName(unit)
        local npcHealth = UnitHealthMax(unit)
        local npcLevel = UnitLevel(unit)
        local npcCreatureType = UnitCreatureType(unit)
        local npcScale = 1
        local npcCount = 0
        tinsert(MDT.dungeonEnemies[db.currentDungeonIdx], {
            name = npcName,
            health = npcHealth,
            level = npcLevel,
            creatureType = npcCreatureType,
            id = npcId,
            scale = npcScale,
            count = npcCount,
            clones = {},
        })
        return npcId
    end
end

local currentEnemyIdx
local currentCloneGroup
local currentTeeming
local currentInspiring
local currentPatrol
local currentBossEnemyIdx = 1
---CreateDevPanel
---Creates the dev panel which contains buttons to add npcs, objects to the map
function MDT:CreateDevPanel(frame)
    db = MDT:GetDB()
    frame.devPanel = AceGUI:Create("TabGroup")
    local devPanel = frame.devPanel
    devPanel.frame:SetFrameStrata("HIGH")
    devPanel.frame:SetFrameLevel(50)

    devPanel:SetTabs(
        {
            {text="POI", value="tab1"},
            {text="Enemy", value="tab2"},
            {text="Infested", value="tab3"},
            {text="Week", value="tab4"},
            {text="Corrupted", value="tab5"},
            {text="Manage DB", value="tab6"},
        }
    )
    devPanel:SetWidth(250)
    devPanel:ClearAllPoints()
    devPanel:SetPoint("TOPRIGHT",frame.topPanel,"TOPLEFT",0,0)
    devPanel:SetLayout("Flow")
    devPanel.frame:Hide()

    MDT:FixAceGUIShowHide(devPanel)

    -- function that draws the widgets for the first tab
    local function DrawGroup1(container)
        --mapLink Options
        local option1 = AceGUI:Create("EditBox")
        option1:SetLabel("Target Floor / Bot Index")
        option1:SetText(1)
        local option2 = AceGUI:Create("EditBox")
        option2:SetLabel("Direction 1up -1d 2r -2l")
        option2:SetText(1)
        container:AddChild(option1)
        container:AddChild(option2)

        --door options
        local option3 = AceGUI:Create("EditBox")
        option3:SetLabel("Door Name / Connected Index")
        option3:SetText("")
        local option4 = AceGUI:Create("EditBox")
        option4:SetLabel("Door Descripting")
        option4:SetText("")
        local lockedCheckbox = AceGUI:Create("CheckBox")
        lockedCheckbox:SetLabel("Lockpickable")
        container:AddChild(option3)
        container:AddChild(option4)
        container:AddChild(lockedCheckbox)

        --graveyard options
        local option5 = AceGUI:Create("EditBox")
        option5:SetLabel("Graveyard Description")
        option5:SetText("")
        container:AddChild(option5)




        local buttons = {
            [1] = {
                text="MapLink",
                func=function()
                    if not MDT.mapPOIs[db.currentDungeonIdx] then MDT.mapPOIs[db.currentDungeonIdx] = {} end
                    if not MDT.mapPOIs[db.currentDungeonIdx][MDT:GetCurrentSubLevel()] then
                        MDT.mapPOIs[db.currentDungeonIdx][MDT:GetCurrentSubLevel()] = {}
                    end
                    local links = MDT.mapPOIs[db.currentDungeonIdx][MDT:GetCurrentSubLevel()]
                    local posx,posy = 300,-200
                    local t = tonumber(option1:GetText())
                    local d = tonumber(option2:GetText())
                    local c = tonumber(option3:GetText())
                    if t and d then
                        tinsert(links,{x=posx,y=posy,target=t,direction=d,connectionIndex=c,template="MapLinkPinTemplate",type="mapLink"})
                        MDT:POI_UpdateAll()
                    end
                end,
            },
            [2] = {
                text="Door",
                func=function()
                    if not MDT.mapPOIs[db.currentDungeonIdx] then MDT.mapPOIs[db.currentDungeonIdx] = {} end
                    if not MDT.mapPOIs[db.currentDungeonIdx][MDT:GetCurrentSubLevel()] then
                        MDT.mapPOIs[db.currentDungeonIdx][MDT:GetCurrentSubLevel()] = {}
                    end
                    local links = MDT.mapPOIs[db.currentDungeonIdx][MDT:GetCurrentSubLevel()]
                    local posx,posy = 300,-200
                    local doorNameText = option3:GetText()
                    local doorDescriptionText = option4:GetText()
                    local lockpickableStatus = lockedCheckbox:GetValue() or nil
                    tinsert(links,{x=posx,y=posy,template="MapLinkPinTemplate",type="door",doorName=doorNameText,doorDescription = doorDescriptionText,lockpick=lockpickableStatus})
                    MDT:POI_UpdateAll()
                end,
            },
            [3] = {
                text="Graveyard",
                func=function()
                    if not MDT.mapPOIs[db.currentDungeonIdx] then MDT.mapPOIs[db.currentDungeonIdx] = {} end
                    if not MDT.mapPOIs[db.currentDungeonIdx][MDT:GetCurrentSubLevel()] then
                        MDT.mapPOIs[db.currentDungeonIdx][MDT:GetCurrentSubLevel()] = {}
                    end
                    local links = MDT.mapPOIs[db.currentDungeonIdx][MDT:GetCurrentSubLevel()]
                    local posx,posy = 300,-200
                    local graveyardDescriptionText = option5:GetText()
                    tinsert(links,{x=posx,y=posy,template="DeathReleasePinTemplate",type="graveyard",graveyardDescription=graveyardDescriptionText})
                    MDT:POI_UpdateAll()
                end,
            },
            [4] = {
                text="General Note",
                func=function()
                    if not MDT.mapPOIs[db.currentDungeonIdx] then MDT.mapPOIs[db.currentDungeonIdx] = {} end
                    if not MDT.mapPOIs[db.currentDungeonIdx][MDT:GetCurrentSubLevel()] then
                        MDT.mapPOIs[db.currentDungeonIdx][MDT:GetCurrentSubLevel()] = {}
                    end
                    local pois = MDT.mapPOIs[db.currentDungeonIdx][MDT:GetCurrentSubLevel()]
                    local posx,posy = 300,-200
                    local noteText = option5:GetText()
                    tinsert(pois,{x=posx,y=posy,template="MapLinkPinTemplate",type="generalNote",text=noteText})
                    MDT:POI_UpdateAll()
                end,
            },
            [5] = {
                text="Heavy Cannon",
                func=function()
                    if not MDT.mapPOIs[db.currentDungeonIdx] then MDT.mapPOIs[db.currentDungeonIdx] = {} end
                    if not MDT.mapPOIs[db.currentDungeonIdx][MDT:GetCurrentSubLevel()] then
                        MDT.mapPOIs[db.currentDungeonIdx][MDT:GetCurrentSubLevel()] = {}
                    end
                    local pois = MDT.mapPOIs[db.currentDungeonIdx][MDT:GetCurrentSubLevel()]
                    local posx,posy = 300,-200
                    tinsert(pois,{x=posx,y=posy,template="MapLinkPinTemplate",type="heavyCannon"})
                    MDT:POI_UpdateAll()
                end,
            },
            [6] = {
                text="Mechagon Bot",
                func=function()
                    if not MDT.mapPOIs[db.currentDungeonIdx] then MDT.mapPOIs[db.currentDungeonIdx] = {} end
                    if not MDT.mapPOIs[db.currentDungeonIdx][MDT:GetCurrentSubLevel()] then
                        MDT.mapPOIs[db.currentDungeonIdx][MDT:GetCurrentSubLevel()] = {}
                    end
                    local pois = MDT.mapPOIs[db.currentDungeonIdx][MDT:GetCurrentSubLevel()]
                    local botIndex = tonumber(option1:GetText())
                    local posx,posy = 400+(30*botIndex),-250
                    tinsert(pois,{x=posx,y=posy,template="MapLinkPinTemplate",type="mechagonBot",botIndex=botIndex})
                    MDT:POI_UpdateAll()
                end,
            },
            [7] = {
                text="Export to LUA",
                func=function()
                    local export = tshow(MDT.mapPOIs[db.currentDungeonIdx],"MDT.mapPOIs[dungeonIndex]")
                    MDT.main_frame.ExportFrame:ClearAllPoints()
                    MDT.main_frame.ExportFrame:Show()
                    MDT.main_frame.ExportFrame:SetPoint("CENTER", MDT.main_frame,"CENTER",0,50)
                    MDT.main_frame.ExportFrameEditbox:SetText(export)
                    MDT.main_frame.ExportFrameEditbox:HighlightText(0, slen(export))
                    MDT.main_frame.ExportFrameEditbox:SetFocus()
                end,
            },
        }
        for buttonIdx,buttonData in ipairs(buttons) do
            local button = AceGUI:Create("Button")
            button:SetText(buttonData.text)
            button:SetCallback("OnClick",buttonData.func)
            container:AddChild(button)
        end
    end

    -- function that draws the widgets for the second tab
    local function DrawGroup2(container)
        local editBoxes = {}
        local countSlider
        local scaleSlider
        local dropdown

        local function updateFields(health,level,creatureType,id,scale,count,idx)
            if idx then
                local data = MDT.dungeonEnemies[db.currentDungeonIdx][idx]
                if not data then return end
                health = data.health
                level = data.level
                creatureType = data.creatureType
                id = data.id
                scale = data.scale
                count = data.count
            end
            editBoxes[1]:SetText(id)
            editBoxes[2]:SetText(health)
            editBoxes[3]:SetText(level)
            editBoxes[4]:SetText(creatureType)
            scaleSlider:SetValue(scale)
            countSlider:SetValue(count)
        end
        local function updateDropdown(npcId,idx)
            if not MDT.dungeonEnemies[db.currentDungeonIdx] then return end
            idx = idx or 1
            local enemies = {}
            for mobIdx,data in ipairs(MDT.dungeonEnemies[db.currentDungeonIdx]) do
                tinsert(enemies,mobIdx,data.name)
                if npcId then
                    if data.id == npcId then idx = mobIdx end
                end
            end
            dropdown:SetList(enemies)
            dropdown:SetValue(idx)
            currentEnemyIdx = idx
            updateFields(nil,nil,nil,nil,nil,nil,idx)
        end

        dropdown = AceGUI:Create("Dropdown")
        dropdown:SetCallback("OnValueChanged", function(widget,callbackName,key)
            currentEnemyIdx = key
            updateFields(nil,nil,nil,nil,nil,nil,key)
            local dungeonEnemyBlips = MDT:GetDungeonEnemyBlips()
            for _,v in ipairs(dungeonEnemyBlips) do
                v.devSelected = nil
            end
            MDT:UpdateMap()
        end)

        container:AddChild(dropdown)

        countSlider = AceGUI:Create("Slider")
        countSlider:SetLabel("Count")
        countSlider:SetSliderValues(0,15,1)
        countSlider:SetValue(4)
        countSlider:SetCallback("OnMouseUp",function(widget,callbackName,value)
            local count = tonumber(value)
            local npcIdx = tonumber(dropdown:GetValue())

            local data = MDT.dungeonEnemies[db.currentDungeonIdx][npcIdx]
            data["count"] = value
            MDT:UpdateMap()
        end)
        container:AddChild(countSlider)
        local fields = {
            [1] = "id",
            [2] = "health",
            [3] = "level",
            [4] = "creatureType",
        }
        for idx,name in ipairs(fields) do
            editBoxes[idx] = AceGUI:Create("EditBox")
            editBoxes[idx]:SetLabel(name)
            editBoxes[idx]:SetCallback("OnEnterPressed",function(widget,callbackName,text)
                local value = text
                if name ~= "creatureType" then
                    value = tonumber(text)
                end
                local npcIdx = dropdown:GetValue()
                local data = MDT.dungeonEnemies[db.currentDungeonIdx][npcIdx]
                data[name] = value
                MDT:UpdateMap()
            end)
            container:AddChild(editBoxes[idx])
        end

        scaleSlider = AceGUI:Create("Slider")
        scaleSlider:SetLabel("Scale")
        scaleSlider:SetSliderValues(0,5,0.1)
        scaleSlider:SetValue(1)
        scaleSlider:SetCallback("OnMouseUp",function(widget,callbackName,value)
            local npcIdx = tonumber(dropdown:GetValue())
            local data = MDT.dungeonEnemies[db.currentDungeonIdx][npcIdx]
            data["scale"] = value
            MDT:UpdateMap()
        end)
        container:AddChild(scaleSlider)

        local button1 = AceGUI:Create("Button")
        button1:SetText("Create from Target")
        button1:SetCallback("OnClick",function()
            local npcId = MDT:AddNPCFromUnit("target")
            updateDropdown(npcId)
        end)
        container:AddChild(button1)

        --make boss
        local button2 = AceGUI:Create("Button")
        button2:SetText("Make Boss")
        button2:SetCallback("OnClick",function()
            local currentBlip = MDT:GetCurrentDevmodeBlip()
            if currentBlip then
                --encounterID
                local encounterID, encounterName, description, displayInfo, iconImage = EJ_GetCreatureInfo(1)
                if not encounterID then
                    print("MDT: Error - Make sure to open Encounter Journal and navigate to the boss you want to add!")
                    return
                end
                for i=1,10000 do
                    local ixd = EJ_GetCreatureInfo(currentBossEnemyIdx,i)
                    if ixd == encounterID then
                        encounterID = i
                        break
                    end
                end
                local data = MDT.dungeonEnemies[db.currentDungeonIdx][currentBlip.enemyIdx]
                data.isBoss = true
                local mapID = C_Map.GetBestMapForUnit("player")
                data.instanceID = mapID and EJ_GetInstanceForMap(mapID) or 0
                data.encounterID = encounterID
                --use this data as follows:
                --if (not EncounterJournal) then LoadAddOn('Blizzard_EncounterJournal') end
                --EncounterJournal_OpenJournal(23,data.instanceID,data.encounterID)
                MDT:UpdateMap()
            end
        end)
        container:AddChild(button2)

        --blips movable toggle
        local blipsMovableCheckbox = AceGUI:Create("CheckBox")
        blipsMovableCheckbox:SetLabel("Blips Movable")
        blipsMovableCheckbox:SetCallback("OnValueChanged",function (widget,callbackName,value)
            db.devModeBlipsMovable = value or nil
        end)
        container:AddChild(blipsMovableCheckbox)

        --blips scrollable toggle
        local blipsScrollableCheckbox = AceGUI:Create("CheckBox")
        blipsScrollableCheckbox:SetLabel("Blips Scrollable")
        blipsScrollableCheckbox:SetCallback("OnValueChanged",function (widget,callbackName,value)
            db.devModeBlipsScrollable = value or nil
        end)
        container:AddChild(blipsScrollableCheckbox)

        --clone options

        --group
        local cloneGroup = AceGUI:Create("EditBox")
        cloneGroup:SetLabel("Group of clone:")
        cloneGroup:SetCallback("OnEnterPressed",function(widget,callbackName,text)
            local value = tonumber(text)
            if value and value>0 then currentCloneGroup = value else currentCloneGroup = nil end
            local currentBlip = MDT:GetCurrentDevmodeBlip()
            if currentBlip then
                local data = MDT.dungeonEnemies[db.currentDungeonIdx][currentBlip.enemyIdx]
                data.clones[currentBlip.cloneIdx].g = currentCloneGroup
                MDT:UpdateMap()
            end
        end)
        container:AddChild(cloneGroup)

        local cloneGroupMaxButton = AceGUI:Create("Button")
        cloneGroupMaxButton:SetText("New Group")
        cloneGroupMaxButton:SetCallback("OnClick",function (widget,callbackName)
            local maxGroup = 0
            for _,data in pairs(MDT.dungeonEnemies[db.currentDungeonIdx]) do
                for _,clone in pairs(data.clones) do
                    maxGroup = (clone.g and (clone.g>maxGroup)) and clone.g or maxGroup
                end
            end
            currentCloneGroup = maxGroup+1
            cloneGroup:SetText(currentCloneGroup)
        end)
        container:AddChild(cloneGroupMaxButton)

        local teemingCheckbox = AceGUI:Create("CheckBox")
        teemingCheckbox:SetLabel("Teeming")
        teemingCheckbox:SetCallback("OnValueChanged",function(widget,callbackName,value)
            currentTeeming = value and true or nil
            local currentBlip = MDT:GetCurrentDevmodeBlip()
            if currentBlip then
                local data = MDT.dungeonEnemies[db.currentDungeonIdx][currentBlip.enemyIdx]
                data.clones[currentBlip.cloneIdx].teeming = currentTeeming
                MDT:UpdateMap()
            end
        end)
        teemingCheckbox:SetValue(currentTeeming)
        container:AddChild(teemingCheckbox)


        --patrol
        local patrolCheckbox = AceGUI:Create("CheckBox")
        patrolCheckbox:SetLabel("Patrol")
        patrolCheckbox:SetCallback("OnValueChanged",function(widget,callbackName,value)
            currentPatrol = value or nil
            local currentBlip = MDT:GetCurrentDevmodeBlip()
            if currentBlip then
                local data = MDT.dungeonEnemies[db.currentDungeonIdx][currentBlip.enemyIdx]
                data.clones[currentBlip.cloneIdx].patrol = currentPatrol and (data.clones[currentBlip.cloneIdx].patrol or {}) or nil
                if not data.clones[currentBlip.cloneIdx].patrol then
                    currentBlip.patrolActive = false
                end
                currentBlip:ShowBlipPatrol(false)
                MDT:UpdateMap()
            end
        end)
        container:AddChild(patrolCheckbox)

        --stealthdetect
        local stealthDetectCheckbox = AceGUI:Create("CheckBox")
        stealthDetectCheckbox:SetLabel("Stealth Detect")
        stealthDetectCheckbox:SetCallback("OnValueChanged",function (widget,callbackName,value)
            local currentBlip = MDT:GetCurrentDevmodeBlip()
            local data = MDT.dungeonEnemies[db.currentDungeonIdx][currentBlip.enemyIdx]
            data.stealthDetect = value or nil
            MDT:UpdateMap()
        end)
        container:AddChild(stealthDetectCheckbox)

        --stealth
        local stealthCheckbox = AceGUI:Create("CheckBox")
        stealthCheckbox:SetLabel("Stealthed")
        stealthCheckbox:SetCallback("OnValueChanged",function (widget,callbackName,value)
            local currentBlip = MDT:GetCurrentDevmodeBlip()
            local data = MDT.dungeonEnemies[db.currentDungeonIdx][currentBlip.enemyIdx]
            data.stealth = value or nil
            MDT:UpdateMap()
        end)
        container:AddChild(stealthCheckbox)

        --neutral
        local neutralCheckbox = AceGUI:Create("CheckBox")
        neutralCheckbox:SetLabel("Neutral")
        neutralCheckbox:SetCallback("OnValueChanged",function (widget,callbackName,value)
            local currentBlip = MDT:GetCurrentDevmodeBlip()
            local data = MDT.dungeonEnemies[db.currentDungeonIdx][currentBlip.enemyIdx]
            data.neutral = value or nil
            MDT:UpdateMap()
        end)
        container:AddChild(neutralCheckbox)

        --upstairs
        local upstairsCheckbox = AceGUI:Create("CheckBox")
        upstairsCheckbox:SetLabel("Upstairs")
        upstairsCheckbox:SetCallback("OnValueChanged",function (widget,callbackName,value)
            local currentBlip = MDT:GetCurrentDevmodeBlip()
            if currentBlip then
                local data = MDT.dungeonEnemies[db.currentDungeonIdx][currentBlip.enemyIdx]
                data.clones[currentBlip.cloneIdx].upstairs = value or nil
                MDT:UpdateMap()
            end
        end)
        container:AddChild(upstairsCheckbox)

        --negative teeming
        local negativeteemingCheckbox = AceGUI:Create("CheckBox")
        negativeteemingCheckbox:SetLabel("Negative Teeming")
        negativeteemingCheckbox:SetCallback("OnValueChanged",function (widget,callbackName,value)
            local currentBlip = MDT:GetCurrentDevmodeBlip()
            if currentBlip then
                local data = MDT.dungeonEnemies[db.currentDungeonIdx][currentBlip.enemyIdx]
                data.clones[currentBlip.cloneIdx].negativeTeeming = value or nil
                MDT:UpdateMap()
            end
        end)
        container:AddChild(negativeteemingCheckbox)

        local inspiringCheckbox = AceGUI:Create("CheckBox")
        inspiringCheckbox:SetLabel("Inspiring")
        inspiringCheckbox:SetCallback("OnValueChanged",function(widget,callbackName,value)
            currentInspiring = value and true or nil
            local currentBlip = MDT:GetCurrentDevmodeBlip()
            if currentBlip then
                local data = MDT.dungeonEnemies[db.currentDungeonIdx][currentBlip.enemyIdx]
                data.clones[currentBlip.cloneIdx].inspiring = currentInspiring
                MDT:UpdateMap()
            end
        end)
        inspiringCheckbox:SetValue(currentInspiring)
        container:AddChild(inspiringCheckbox)

        --faction
        local faction = AceGUI:Create("EditBox")
        faction:SetLabel("Faction:")
        faction:SetCallback("OnEnterPressed",function(widget,callbackName,text)
            local value = tonumber(text)
            local currentBlip = MDT:GetCurrentDevmodeBlip()
            if currentBlip then
                local data = MDT.dungeonEnemies[db.currentDungeonIdx][currentBlip.enemyIdx]
                data.clones[currentBlip.cloneIdx].faction = value
                MDT:UpdateMap()
            end
        end)
        container:AddChild(faction)

        --sublevel
        local sublevel = AceGUI:Create("EditBox")
        sublevel:SetLabel("Sublevel:")
        sublevel:SetCallback("OnEnterPressed",function(widget,callbackName,text)
            local value = tonumber(text)
            local currentBlip = MDT:GetCurrentDevmodeBlip()
            if currentBlip then
                local data = MDT.dungeonEnemies[db.currentDungeonIdx][currentBlip.enemyIdx]
                data.clones[currentBlip.cloneIdx].sublevel = value
                MDT:UpdateMap()
            end
        end)
        container:AddChild(sublevel)

        --enter clone options into the GUI (red)
        local currentBlip = MDT:GetCurrentDevmodeBlip()
        if currentBlip then
            cloneGroup:SetText(currentBlip.clone.g)
            currentCloneGroup = currentBlip.clone.g
            teemingCheckbox:SetValue(currentBlip.clone.teeming)
            inspiringCheckbox:SetValue(currentBlip.clone.inspiring)
            currentTeeming = currentBlip.clone.teeming
            currentPatrol = currentBlip.patrol and true or nil
            patrolCheckbox:SetValue(currentBlip.clone.patrol)
            stealthDetectCheckbox:SetValue(currentBlip.data.stealthDetect)
            stealthCheckbox:SetValue(currentBlip.data.stealth)
            neutralCheckbox:SetValue(currentBlip.data.neutral)
            upstairsCheckbox:SetValue(currentBlip.clone.upstairs)
            negativeteemingCheckbox:SetValue(currentBlip.clone.negativeTeeming)
            faction:SetText(currentBlip.clone.faction)
            sublevel:SetText(currentBlip.clone.sublevel)
        else
            cloneGroup:SetText(currentCloneGroup)
        end
        blipsMovableCheckbox:SetValue(db.devModeBlipsMovable)
        blipsScrollableCheckbox:SetValue(db.devModeBlipsScrollable)

        local button3 = AceGUI:Create("Button")
        button3:SetText("Export to LUA")
        button3:SetCallback("OnClick",function()
            MDT:CleanEnemyData(db.currentDungeonIdx)
            local export = tshow(MDT.dungeonEnemies[db.currentDungeonIdx],"MDT.dungeonEnemies[dungeonIndex]")
            MDT.main_frame.ExportFrame:ClearAllPoints()
            MDT.main_frame.ExportFrame:Show()
            MDT.main_frame.ExportFrame:SetPoint("CENTER", MDT.main_frame,"CENTER",0,50)
            MDT.main_frame.ExportFrameEditbox:SetText(export)
            MDT.main_frame.ExportFrameEditbox:HighlightText(0, slen(export))
            MDT.main_frame.ExportFrameEditbox:SetFocus()
        end)
        container:AddChild(button3)

        local button4 = AceGUI:Create("Button")
        button4:SetText("Export Expansion")
        button4:SetCallback("OnClick",function()
            local dungeons = {}
            for i = 29,36 do
                MDT:CleanEnemyData(i)
                dungeons[i] = MDT.dungeonEnemies[i]
            end
            local export = MDT:TableToString(dungeons,true,5)
            MDT.main_frame.ExportFrame:ClearAllPoints()
            MDT.main_frame.ExportFrame:Show()
            MDT.main_frame.ExportFrame:SetPoint("CENTER", MDT.main_frame,"CENTER",0,50)
            MDT.main_frame.ExportFrameEditbox:SetText(export)
            MDT.main_frame.ExportFrameEditbox:HighlightText(0, slen(export))
            MDT.main_frame.ExportFrameEditbox:SetFocus()
        end)
        container:AddChild(button4)





        updateDropdown(nil,currentEnemyIdx)
        end

    local function DrawGroup3(container)
        for i=1,12 do
            local infestedCheckbox = AceGUI:Create("CheckBox")
            infestedCheckbox:SetLabel("Infested Week "..i)
            infestedCheckbox:SetCallback("OnValueChanged",function (widget,callbackName,value)
                local currentBlip = MDT:GetCurrentDevmodeBlip()
                local data = MDT.dungeonEnemies[db.currentDungeonIdx][currentBlip.enemyIdx]
                data.clones[currentBlip.cloneIdx].infested = data.clones[currentBlip.cloneIdx].infested or {}
                data.clones[currentBlip.cloneIdx].infested[i] = value or nil
                MDT:UpdateMap()
            end)
            local currentBlip = MDT:GetCurrentDevmodeBlip()
            if currentBlip then
                infestedCheckbox:SetValue(currentBlip.clone.infested and currentBlip.clone.infested[i])
            end
            container:AddChild(infestedCheckbox)
        end


    end

    local function DrawGroup4(container)
        for i=1,12 do
            local weekCheckbox = AceGUI:Create("CheckBox")
            weekCheckbox:SetLabel("Week "..i)
            weekCheckbox:SetCallback("OnValueChanged",function (widget,callbackName,value)
                local currentBlip = MDT:GetCurrentDevmodeBlip()
                local data = MDT.dungeonEnemies[db.currentDungeonIdx][currentBlip.enemyIdx]
                data.clones[currentBlip.cloneIdx].week = data.clones[currentBlip.cloneIdx].week or {}
                data.clones[currentBlip.cloneIdx].week[i] = value or nil
                MDT:UpdateMap()
            end)
            local currentBlip = MDT:GetCurrentDevmodeBlip()
            if currentBlip then
                weekCheckbox:SetValue(currentBlip.clone.week and currentBlip.clone.week[i])
            end
            container:AddChild(weekCheckbox)
        end


    end

    local spireNames = {
        [1] = "Entropic Spire of Ny'alotha",
        [2] = "Cursed Spire of Ny'alotha",
        [3] = "Brutal Spire of Ny'alotha",
        [4] = "Defiled Spire of Ny'alotha",
    }

    local function DrawGroup5(container)
        local index,tooltipIndex,scale
        local week = {}

        local indexEditbox = AceGUI:Create("EditBox")
        indexEditbox:SetLabel("Index")
        indexEditbox:SetCallback("OnEnterPressed",function(widget,callbackName,text)
            index = tonumber(text)
        end)
        container:AddChild(indexEditbox)


        local tooltipIndexEditbox = AceGUI:Create("EditBox")
        tooltipIndexEditbox:SetLabel("Tooltip Index")
        tooltipIndexEditbox:SetCallback("OnEnterPressed",function(widget,callbackName,text)
            tooltipIndex = tonumber(text)
        end)
        container:AddChild(tooltipIndexEditbox)

        local tooltipIndexLabel = AceGUI:Create("Label")
        tooltipIndexLabel:SetText("1 = Entropic Spire of Ny'alotha (Sam'rek)\n2 = Cursed Spire of Ny'alotha (Voidweaver)\n3 = Brutal Spire of Ny'alotha (Urg'roth)\n4 = Defiled Spire of Ny'alotha (Blood)\n")
        container:AddChild(tooltipIndexLabel)

        local scaleEditbox = AceGUI:Create("EditBox")
        scaleEditbox:SetLabel("Scale")
        scaleEditbox:SetCallback("OnEnterPressed",function(widget,callbackName,text)
            scale = tonumber(text)
        end)
        container:AddChild(scaleEditbox)

        for i=1,12 do
            local weekCheckbox = AceGUI:Create("CheckBox")
            weekCheckbox:SetLabel("Week "..i)
            weekCheckbox:SetCallback("OnValueChanged",function (widget,callbackName,value)
                if value then week[i] = true else week[i] = nil end
            end)
            container:AddChild(weekCheckbox)
        end
        local createSpireButton = AceGUI:Create("Button")
        createSpireButton:SetText("Create Spire+NPC")
        local tooltipIdxToNpcId = {
            [1] = 161243,
            [2] = 161241,
            [3] = 161124,
            [4] = 161244,
        }
        createSpireButton:SetCallback("OnClick",function()
            if not MDT.mapPOIs[db.currentDungeonIdx] then MDT.mapPOIs[db.currentDungeonIdx] = {} end
            if not MDT.mapPOIs[db.currentDungeonIdx][MDT:GetCurrentSubLevel()] then
                MDT.mapPOIs[db.currentDungeonIdx][MDT:GetCurrentSubLevel()] = {}
            end
            local pois = MDT.mapPOIs[db.currentDungeonIdx][MDT:GetCurrentSubLevel()]
            local posx,posy = 300,-200
            local newWeek = MDT:DeepCopy(week)
            tinsert(pois,{x=posx,y=posy,index=index,weeks=newWeek,tooltipText=spireNames[tooltipIndex],template="VignettePinTemplate",type="nyalothaSpire",scale=scale,npcId=tooltipIdxToNpcId[tooltipIndex]})
            newWeek = MDT:DeepCopy(week)
            MDT:POI_UpdateAll()
            --add associated NPC to the map
            MDT:AddCloneFromData(tooltipIdxToNpcId[tooltipIndex],newWeek)
        end)
        container:AddChild(createSpireButton)


    end

    local function DrawGroup6(container)
        local clearCacheButton = AceGUI:Create("Button")
        clearCacheButton:SetText("Clear Cache")
        clearCacheButton:SetCallback("OnClick",function()
            MDT:ResetDataCache()
        end)
        container:AddChild(clearCacheButton)

        local resetDbButton = AceGUI:Create("Button")
        resetDbButton:SetText("Hard Reset DB")
        resetDbButton:SetCallback("OnClick",function()
            MDT:OpenConfirmationFrame(300, 150, "Reset MDT DB", "Confirm", "Do you want to reset MDT DB?", function()
                MDT:HardReset()
            end, "Cancel", nil)
        end)
        container:AddChild(resetDbButton)

        local vdtDbButton = AceGUI:Create("Button")
        vdtDbButton:SetText("VDT DB")
        vdtDbButton:SetCallback("OnClick",function()
            ViragDevTool_AddData(db)
        end)
        container:AddChild(vdtDbButton)
    end

    -- Callback function for OnGroupSelected
    local function SelectGroup(container, event, group)
        container:ReleaseChildren()
        if group == "tab1" then
            DrawGroup1(container)
        elseif group == "tab2" then
            DrawGroup2(container)
        elseif group == "tab3" then
            DrawGroup3(container)
        elseif group == "tab4" then
            DrawGroup4(container)
        elseif group == "tab5" then
            DrawGroup5(container)
        elseif group == "tab6" then
            DrawGroup6(container)
        end
    end
    devPanel:SetCallback("OnGroupSelected", SelectGroup)
    devPanel:SelectTab("tab2")

    --hook UpdateMap
    local originalFunc = MDT.UpdateMap
    function MDT:UpdateMap(...)
        originalFunc(...)
        local selectedTab
        for k,v in pairs(devPanel.tabs) do
            if v.selected == true then selectedTab = v.value; break end
        end
        --currentEnemyIdx
        local currentBlip = MDT:GetCurrentDevmodeBlip()
        if currentBlip then
            currentEnemyIdx=currentBlip.enemyIdx
        end
        devPanel:SelectTab(selectedTab)
        --show patrol
        local dungeonEnemyBlips = MDT:GetDungeonEnemyBlips()
        for _,v in ipairs(dungeonEnemyBlips) do
            v:DisplayPatrol(v.devSelected)
        end

    end

end

function MDT:AddCloneFromData(npcId, weeks)
    local sublevel= MDT:GetCurrentSubLevel()
    local x,y = 320,-200
    local data
    for _,enemyData in pairs(MDT.dungeonEnemies[db.currentDungeonIdx]) do
        if enemyData.id == npcId then
            data = enemyData
            break
        end
    end
    if not data then
        print("Could not find enemy with id "..npcId)
        return
    end
    tinsert(data.clones,{x=x,y=y,sublevel=sublevel,week=weeks})
    print(string.format("MDT: Created clone %s %d at %d,%d",data.name,#data.clones,x,y))
    MDT:UpdateMap()
end

---AddCloneAtCursorPosition
---Adds a clone at the cursor position to the dungeon enemy table
---bound to hotkey and used to add new npcs to the map
function MDT:AddCloneAtCursorPosition()
    if not MouseIsOver(MDTScrollFrame) then return end
    if currentEnemyIdx then
        local data = MDT.dungeonEnemies[db.currentDungeonIdx][currentEnemyIdx]
        local cursorx,cursory = MDT:GetCursorPosition()
        local scale = self:GetScale()
        cursorx = cursorx*(1/scale)
        cursory = cursory*(1/scale)
        tinsert(data.clones,{ x=cursorx, y=cursory, sublevel= MDT:GetCurrentSubLevel(), g=currentCloneGroup, teeming=currentTeeming})
        print(string.format("MDT: Created clone %s %d at %d,%d",data.name,#data.clones,cursorx,cursory))
        MDT:UpdateMap()
    end
end

---AddPatrolWaypointAtCursorPosition
---Adds a patrol waypoint to the selected enemy
function MDT:AddPatrolWaypointAtCursorPosition()
    if not MouseIsOver(MDTScrollFrame) then return end
    local currentBlip = MDT:GetCurrentDevmodeBlip()
    if currentBlip then
        local data = MDT.dungeonEnemies[db.currentDungeonIdx][currentBlip.enemyIdx]
        local cloneData = data.clones[currentBlip.cloneIdx]
        cloneData.patrol = cloneData.patrol or {}
        cloneData.patrol[1] = {x=cloneData.x,y=cloneData.y}
        local cursorx,cursory = MDT:GetCursorPosition()
        local scale = MDT:GetScale()
        cursorx = cursorx*(1/scale)
        cursory = cursory*(1/scale)
        --snap onto other waypoints
        local patrolBlips = MDT:GetPatrolBlips()
        for idx,waypoint in pairs(patrolBlips) do
            if MouseIsOver(waypoint) then
                cursorx = waypoint.x
                cursory = waypoint.y
            end
        end
        --snap onto blip
        if MouseIsOver(currentBlip) then
            cursorx = currentBlip.clone.x
            cursory = currentBlip.clone.y
        end
        tinsert(cloneData.patrol,{x=cursorx,y=cursory})
        print(string.format("MDT: Created Waypoint %d of %s %d at %d,%d",1,data.name,#cloneData.patrol,cursorx,cursory))
        MDT:UpdateMap()
    end
end

