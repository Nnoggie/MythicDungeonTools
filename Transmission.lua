local Compresser = LibStub:GetLibrary("LibCompress")
local Encoder = Compresser:GetAddonEncodeTable()
local Serializer = LibStub:GetLibrary("AceSerializer-3.0")
local LibDeflate = LibStub:GetLibrary("LibDeflate")
local configForDeflate = {
    [1]= {level = 1},
    [2]= {level = 2},
    [3]= {level = 3},
    [4]= {level = 4},
    [5]= {level = 5},
    [6]= {level = 6},
    [7]= {level = 7},
    [8]= {level = 8},
    [9]= {level = 9},
}

MDTcommsObject = LibStub("AceAddon-3.0"):NewAddon("MDTCommsObject","AceComm-3.0","AceSerializer-3.0")

-- Lua APIs
local tostring, string_char, strsplit,tremove,tinsert = tostring, string.char, strsplit,table.remove,table.insert
local pairs, type, unpack = pairs, type, unpack
local bit_band, bit_lshift, bit_rshift = bit.band, bit.lshift, bit.rshift

--Based on code from WeakAuras2, all credit goes to the authors
local bytetoB64 = {
    [0]="a","b","c","d","e","f","g","h",
    "i","j","k","l","m","n","o","p",
    "q","r","s","t","u","v","w","x",
    "y","z","A","B","C","D","E","F",
    "G","H","I","J","K","L","M","N",
    "O","P","Q","R","S","T","U","V",
    "W","X","Y","Z","0","1","2","3",
    "4","5","6","7","8","9","(",")"
}

local B64tobyte = {
    a =  0,  b =  1,  c =  2,  d =  3,  e =  4,  f =  5,  g =  6,  h =  7,
    i =  8,  j =  9,  k = 10,  l = 11,  m = 12,  n = 13,  o = 14,  p = 15,
    q = 16,  r = 17,  s = 18,  t = 19,  u = 20,  v = 21,  w = 22,  x = 23,
    y = 24,  z = 25,  A = 26,  B = 27,  C = 28,  D = 29,  E = 30,  F = 31,
    G = 32,  H = 33,  I = 34,  J = 35,  K = 36,  L = 37,  M = 38,  N = 39,
    O = 40,  P = 41,  Q = 42,  R = 43,  S = 44,  T = 45,  U = 46,  V = 47,
    W = 48,  X = 49,  Y = 50,  Z = 51,["0"]=52,["1"]=53,["2"]=54,["3"]=55,
    ["4"]=56,["5"]=57,["6"]=58,["7"]=59,["8"]=60,["9"]=61,["("]=62,[")"]=63
}

-- This code is based on the Encode7Bit algorithm from LibCompress
-- Credit goes to Galmok (galmok@gmail.com)
local decodeB64Table = {}

function decodeB64(str)
    local bit8 = decodeB64Table
    local decoded_size = 0
    local ch
    local i = 1
    local bitfield_len = 0
    local bitfield = 0
    local l = #str
    while true do
        if bitfield_len >= 8 then
            decoded_size = decoded_size + 1
            bit8[decoded_size] = string_char(bit_band(bitfield, 255))
            bitfield = bit_rshift(bitfield, 8)
            bitfield_len = bitfield_len - 8
        end
        ch = B64tobyte[str:sub(i, i)]
        bitfield = bitfield + bit_lshift(ch or 0, bitfield_len)
        bitfield_len = bitfield_len + 6
        if i > l then
            break
        end
        i = i + 1
    end
    return table.concat(bit8, "", 1, decoded_size)
end

function MethodDungeonTools:TableToString(inTable, forChat,level)
    local serialized = Serializer:Serialize(inTable)
    local compressed = LibDeflate:CompressDeflate(serialized, configForDeflate[level])
    -- prepend with "!" so that we know that it is not a legacy compression
    -- also this way, old versions will error out due to the "bad" encoding
    local encoded = "!"
    if(forChat) then
        encoded = encoded .. LibDeflate:EncodeForPrint(compressed)
    else
        encoded = encoded .. LibDeflate:EncodeForWoWAddonChannel(compressed)
    end
    return encoded
end

function MethodDungeonTools:StringToTable(inString, fromChat)
    -- if gsub strips off a ! at the beginning then we know that this is not a legacy encoding
    local encoded, usesDeflate = inString:gsub("^%!", "")
    local decoded
    if(fromChat) then
        if usesDeflate == 1 then
            decoded = LibDeflate:DecodeForPrint(encoded)
        else
            decoded = decodeB64(encoded)
        end
    else
        decoded = LibDeflate:DecodeForWoWAddonChannel(encoded)
    end

    if not decoded then
        return "Error decoding."
    end

    local decompressed, errorMsg = nil, "unknown compression method"
    if usesDeflate == 1 then
        decompressed = LibDeflate:DecompressDeflate(decoded)
    else
        decompressed, errorMsg = Compresser:Decompress(decoded)
    end
    if not(decompressed) then
        return "Error decompressing: " .. errorMsg
    end

    local success, deserialized = Serializer:Deserialize(decompressed)
    if not(success) then
        return "Error deserializing "..deserialized
    end
    return deserialized
end

local function filterFunc(_, event, msg, player, l, cs, t, flag, channelId, ...)
    if flag == "GM" or flag == "DEV" or (event == "CHAT_MSG_CHANNEL" and type(channelId) == "number" and channelId > 0) then
        return
    end
    local newMsg = ""
    local remaining = msg
    local done
    repeat
        local start, finish, characterName, displayName = remaining:find("%[MethodDungeonTools: ([^%s]+) %- ([^%]]+)%]")
        local startLive, finishLive, characterNameLive, displayNameLive = remaining:find("%[MDTLive: ([^%s]+) %- ([^%]]+)%]")
        if(characterName and displayName) then
            characterName = characterName:gsub("|c[Ff][Ff]......", ""):gsub("|r", "")
            displayName = displayName:gsub("|c[Ff][Ff]......", ""):gsub("|r", "")
            newMsg = newMsg..remaining:sub(1, start-1)
            --newMsg = newMsg.."|HMethodDungeonTools-"..characterName.."|h|cFFF49D38[".."|r|cFFF49D38"..displayName.."]|h|r"
            newMsg = "|cfff49d38|Hgarrmission:mdt-"..characterName.."|h["..displayName.."]|h|r"
            remaining = remaining:sub(finish + 1)
        elseif (characterNameLive and displayNameLive) then
            characterNameLive = characterNameLive:gsub("|c[Ff][Ff]......", ""):gsub("|r", "")
            displayNameLive = displayNameLive:gsub("|c[Ff][Ff]......", ""):gsub("|r", "")
            newMsg = newMsg..remaining:sub(1, startLive-1)
            newMsg = newMsg.."|Hgarrmission:mdtlive-"..characterNameLive.."|h[".."|cFF00FF00Live Session: |cfff49d38"..""..displayNameLive.."]|h|r"
            remaining = remaining:sub(finishLive + 1)
        else
            done = true
        end
    until(done)
    if newMsg ~= "" then
        return false, newMsg, player, l, cs, t, flag, channelId, ...
    end
end

local presetCommPrefix = "MDTPreset"

MethodDungeonTools.liveSessionPrefixes = {
    ["enabled"] = "MDTLiveEnabled",
    ["request"] = "MDTLiveReq",
    ["ping"] = "MDTLivePing",
    ["obj"] = "MDTLiveObj",
    ["objOff"] = "MDTLiveObjOff",
    ["objChg"] = "MDTLiveObjChg",
    ["cmd"] = "MDTLiveCmd",
    ["note"] = "MDTLiveNote",
    ["preset"] = "MDTLivePreset",
    ["pull"] = "MDTLivePull",
    ["week"] = "MDTLiveWeek",
    ["free"] = "MDTLiveFree",
    ["bora"] = "MDTLiveBora",
    ["mdi"] = "MDTLiveMDI",
    ["reqPre"] = "MDTLiveReqPre",
    ["corrupted"] = "MDTLiveCor",
    ["difficulty"] = "MDTLiveLvl",
}

function MDTcommsObject:OnEnable()
    self:RegisterComm(presetCommPrefix)
    for _,prefix in pairs(MethodDungeonTools.liveSessionPrefixes) do
        self:RegisterComm(prefix)
    end
    MethodDungeonTools.transmissionCache = {}
    ChatFrame_AddMessageEventFilter("CHAT_MSG_PARTY", filterFunc)
    ChatFrame_AddMessageEventFilter("CHAT_MSG_PARTY_LEADER", filterFunc)
    ChatFrame_AddMessageEventFilter("CHAT_MSG_RAID", filterFunc)
    ChatFrame_AddMessageEventFilter("CHAT_MSG_RAID_LEADER", filterFunc)
end

--handle preset chat link clicks
hooksecurefunc("SetItemRef", function(link, text)
    if(link and link:sub(0, 19) == "garrmission:mdtlive") then
        local sender = link:sub(21, string.len(link))
        local name,realm = string.match(sender,"(.*)+(.*)")
        sender = name.."-"..realm
        --ignore importing the live preset when sender is player, open MDT only
        local playerName,playerRealm = UnitFullName("player")
        playerName = playerName.."-"..playerRealm
        if sender==playerName then
            MethodDungeonTools:ShowInterface(true)
        else
            MethodDungeonTools:ShowInterface(true)
            MethodDungeonTools:LiveSession_Enable()
        end
        return
    elseif (link and link:sub(0, 15) == "garrmission:mdt") then
        local sender = link:sub(17, string.len(link))
        local name,realm = string.match(sender,"(.*)+(.*)")
        if (not name) or (not realm) then
            print("MDT could not properly receive a preset, please make sure sender "..sender.." has the latest version of MDT installed!")
            return
        end
        sender = name.."-"..realm
        local preset = MethodDungeonTools.transmissionCache[sender]
        if preset then
            MethodDungeonTools:ShowInterface(true)
            MethodDungeonTools:OpenChatImportPresetDialog(sender,preset)
        end
        return
    end
end)

function MDTcommsObject:OnCommReceived(prefix, message, distribution, sender)
    --[[
        Sender has no realm name attached when sender is from the same realm as the player
        UnitFullName("Nnogga") returns no realm while UnitFullName("player") does
        UnitFullName("Nnogga-TarrenMill") returns realm even if you are not on the same realm as Nnogga
        We append our realm if there is no realm
    ]]
    local name, realm = UnitFullName(sender)
    if not name then return end
    if not realm or string.len(realm)<3 then
        local _,r = UnitFullName("player")
        realm = r
    end
    local fullName = name.."-"..realm

    --standard preset transmission
    --we cache the preset here already
    --the user still decides if he wants to click the chat link and add the preset to his db
    if prefix == presetCommPrefix then
        local preset = MethodDungeonTools:StringToTable(message,false)
        MethodDungeonTools.transmissionCache[fullName] = preset
        --live session preset
        if MethodDungeonTools.liveSessionActive and MethodDungeonTools.liveSessionAcceptingPreset and preset.uid == MethodDungeonTools.livePresetUID then
            if MethodDungeonTools:ValidateImportPreset(preset) then
                MethodDungeonTools:ImportPreset(preset,true)
                MethodDungeonTools.liveSessionAcceptingPreset = false
                MethodDungeonTools.main_frame.SendingStatusBar:Hide()
                if MethodDungeonTools.main_frame.LoadingSpinner then
                    MethodDungeonTools.main_frame.LoadingSpinner:Hide()
                    MethodDungeonTools.main_frame.LoadingSpinner.Anim:Stop()
                end
                MethodDungeonTools.liveSessionRequested = false
            end
        end
    end

    if prefix == MethodDungeonTools.liveSessionPrefixes.enabled then
        if MethodDungeonTools.liveSessionRequested == true then
            MethodDungeonTools:LiveSession_SessionFound(fullName,message)
        end
    end

    --pulls
    if prefix == MethodDungeonTools.liveSessionPrefixes.pull then
        if MethodDungeonTools.liveSessionActive then
            local preset = MethodDungeonTools:GetCurrentLivePreset()
            local pulls = MethodDungeonTools:StringToTable(message,false)
            preset.value.pulls = pulls
            if preset == MethodDungeonTools:GetCurrentPreset() then
                MethodDungeonTools:ReloadPullButtons()
                MethodDungeonTools:SetSelectionToPull(MethodDungeonTools:GetCurrentPull())
                MethodDungeonTools:POI_UpdateAll() --for corrupted spires
            end
        end
    end

    --corrupted
    if prefix == MethodDungeonTools.liveSessionPrefixes.corrupted then
        if MethodDungeonTools.liveSessionActive then
            local preset = MethodDungeonTools:GetCurrentLivePreset()
            local offsets = MethodDungeonTools:StringToTable(message,false)
            --only reposition if no blip is currently moving
            if not MethodDungeonTools.draggedBlip then
                preset.value.riftOffsets = offsets
                MethodDungeonTools:UpdateMap()
            end
        end
    end

    --difficulty
    if prefix == MethodDungeonTools.liveSessionPrefixes.difficulty then
        if MethodDungeonTools.liveSessionActive then
            local db = MethodDungeonTools:GetDB()
            local difficulty = tonumber(message)
            if difficulty and difficulty~= db.currentDifficulty then
                local updateSeasonal
                if ((difficulty>=10 and db.currentDifficulty<10) or (difficulty<10 and db.currentDifficulty>=10)) then
                    updateSeasonal = true
                end
                db.currentDifficulty = difficulty
                MethodDungeonTools.main_frame.sidePanel.DifficultySlider:SetValue(difficulty)
                MethodDungeonTools:UpdateProgressbar()
                if MethodDungeonTools.EnemyInfoFrame and MethodDungeonTools.EnemyInfoFrame.frame:IsShown() then MethodDungeonTools:UpdateEnemyInfoData() end
                MethodDungeonTools:ReloadPullButtons()
                if updateSeasonal then
                    MethodDungeonTools:DungeonEnemies_UpdateSeasonalAffix()
                    MethodDungeonTools.main_frame.sidePanel.difficultyWarning:Toggle(difficulty)
                    MethodDungeonTools:POI_UpdateAll()
                    MethodDungeonTools:KillAllAnimatedLines()
                    MethodDungeonTools:DrawAllAnimatedLines()
                end
            end
        end
    end

    --week
    if prefix == MethodDungeonTools.liveSessionPrefixes.week then
        if MethodDungeonTools.liveSessionActive then
            local preset = MethodDungeonTools:GetCurrentLivePreset()
            local week = tonumber(message)
            if preset.week ~= week then
                preset.week = week
                local teeming = MethodDungeonTools:IsPresetTeeming(preset)
                preset.value.teeming = teeming
                if preset == MethodDungeonTools:GetCurrentPreset() then
                    local affixDropdown = MethodDungeonTools.main_frame.sidePanel.affixDropdown
                    affixDropdown:SetValue(week)
                    if not MethodDungeonTools:GetCurrentAffixWeek() then
                        MethodDungeonTools.main_frame.sidePanel.affixWeekWarning.image:Hide()
                        MethodDungeonTools.main_frame.sidePanel.affixWeekWarning:SetDisabled(true)
                    elseif MethodDungeonTools:GetCurrentAffixWeek() == week then
                        MethodDungeonTools.main_frame.sidePanel.affixWeekWarning.image:Hide()
                        MethodDungeonTools.main_frame.sidePanel.affixWeekWarning:SetDisabled(true)
                    else
                        MethodDungeonTools.main_frame.sidePanel.affixWeekWarning.image:Show()
                        MethodDungeonTools.main_frame.sidePanel.affixWeekWarning:SetDisabled(false)
                    end
                    MethodDungeonTools:DungeonEnemies_UpdateTeeming()
                    MethodDungeonTools:UpdateFreeholdSelector(week)
                    MethodDungeonTools:DungeonEnemies_UpdateBlacktoothEvent(week)
                    MethodDungeonTools:DungeonEnemies_UpdateSeasonalAffix()
                    MethodDungeonTools:DungeonEnemies_UpdateBoralusFaction(preset.faction)
                    MethodDungeonTools:POI_UpdateAll()
                    MethodDungeonTools:UpdateProgressbar()
                    MethodDungeonTools:ReloadPullButtons()
                    MethodDungeonTools:KillAllAnimatedLines()
                    MethodDungeonTools:DrawAllAnimatedLines()
                end
            end
        end
    end

    --live session messages that ignore concurrency from here on, we ignore our own messages
    if sender == UnitFullName("player") then return end


    if prefix == MethodDungeonTools.liveSessionPrefixes.request then
        if MethodDungeonTools.liveSessionActive then
            MethodDungeonTools:LiveSession_NotifyEnabled()
        end
    end

    --request preset
    if prefix == MethodDungeonTools.liveSessionPrefixes.reqPre then
        local playerName,playerRealm = UnitFullName("player")
        playerName = playerName.."-"..playerRealm
        if playerName == message then
            MethodDungeonTools:SendToGroup(MethodDungeonTools:IsPlayerInGroup(),true,MethodDungeonTools:GetCurrentLivePreset())
        end
    end


    --ping
    if prefix == MethodDungeonTools.liveSessionPrefixes.ping then
        local currentUID = MethodDungeonTools:GetCurrentPreset().uid
        if MethodDungeonTools.liveSessionActive and (currentUID and currentUID==MethodDungeonTools.livePresetUID) then
            local x,y,sublevel = string.match(message,"(.*):(.*):(.*)")
            x = tonumber(x)
            y = tonumber(y)
            sublevel = tonumber(sublevel)
            local scale = MethodDungeonTools:GetScale()
            if sublevel == MethodDungeonTools:GetCurrentSubLevel() then
                MethodDungeonTools:PingMap(x*scale,y*scale)
            end
        end
    end

    --preset objects
    if prefix == MethodDungeonTools.liveSessionPrefixes.obj then
        if MethodDungeonTools.liveSessionActive then
            local preset = MethodDungeonTools:GetCurrentLivePreset()
            local obj = MethodDungeonTools:StringToTable(message,false)
            MethodDungeonTools:StorePresetObject(obj,true,preset)
            if preset == MethodDungeonTools:GetCurrentPreset() then
                local scale = MethodDungeonTools:GetScale()
                local currentPreset = MethodDungeonTools:GetCurrentPreset()
                local currentSublevel = MethodDungeonTools:GetCurrentSubLevel()
                MethodDungeonTools:DrawPresetObject(obj,nil,scale,currentPreset,currentSublevel)
            end
        end
    end

    --preset object offsets
    if prefix == MethodDungeonTools.liveSessionPrefixes.objOff then
        if MethodDungeonTools.liveSessionActive then
            local preset = MethodDungeonTools:GetCurrentLivePreset()
            local objIdx,x,y = string.match(message,"(.*):(.*):(.*)")
            objIdx = tonumber(objIdx)
            x = tonumber(x)
            y = tonumber(y)
            MethodDungeonTools:UpdatePresetObjectOffsets(objIdx,x,y,preset,true)
            if preset == MethodDungeonTools:GetCurrentPreset() then MethodDungeonTools:DrawAllPresetObjects() end
        end
    end

    --preset object changed (deletions, partial deletions)
    if prefix == MethodDungeonTools.liveSessionPrefixes.objChg then
        if MethodDungeonTools.liveSessionActive then
            local preset = MethodDungeonTools:GetCurrentLivePreset()
            local changedObjects = MethodDungeonTools:StringToTable(message,false)
            for objIdx,obj in pairs(changedObjects) do
                preset.objects[objIdx] = obj
            end
            if preset == MethodDungeonTools:GetCurrentPreset() then MethodDungeonTools:DrawAllPresetObjects() end
        end
    end

    --various commands
    if prefix == MethodDungeonTools.liveSessionPrefixes.cmd then
        if MethodDungeonTools.liveSessionActive then
            local preset = MethodDungeonTools:GetCurrentLivePreset()
            if message == "deletePresetObjects" then MethodDungeonTools:DeletePresetObjects(preset, true) end
            if message == "undo" then MethodDungeonTools:PresetObjectStepBack(preset, true) end
            if message == "redo" then MethodDungeonTools:PresetObjectStepForward(preset, true) end
            if message == "clear" then MethodDungeonTools:ClearPreset(preset,true) end
        end
    end

    --note text update, delete, move
    if prefix == MethodDungeonTools.liveSessionPrefixes.note then
        if MethodDungeonTools.liveSessionActive then
            local preset = MethodDungeonTools:GetCurrentLivePreset()
            local action,noteIdx,text,y = string.match(message,"(.*):(.*):(.*):(.*)")
            noteIdx = tonumber(noteIdx)
            if action == "text" then
                preset.objects[noteIdx].d[5]=text
            elseif action == "delete" then
                tremove(preset.objects,noteIdx)
            elseif action == "move" then
                local x = tonumber(text)
                y = tonumber(y)
                preset.objects[noteIdx].d[1]=x
                preset.objects[noteIdx].d[2]=y
            end
            if preset == MethodDungeonTools:GetCurrentPreset() then MethodDungeonTools:DrawAllPresetObjects() end
        end
    end

    --preset
    if prefix == MethodDungeonTools.liveSessionPrefixes.preset then
        if MethodDungeonTools.liveSessionActive then
            local preset = MethodDungeonTools:StringToTable(message,false)
            MethodDungeonTools.transmissionCache[fullName] = preset
            if MethodDungeonTools:ValidateImportPreset(preset) then
                MethodDungeonTools.livePresetUID = preset.uid
                MethodDungeonTools:ImportPreset(preset,true)
            end
        end
    end

    --freehold
    if prefix == MethodDungeonTools.liveSessionPrefixes.free then
        if MethodDungeonTools.liveSessionActive then
            local preset = MethodDungeonTools:GetCurrentLivePreset()
            local value,week = string.match(message,"(.*):(.*)")
            value = value == "T" and true or false
            week = tonumber(week)
            preset.freeholdCrew = (value and week) or nil
            if preset == MethodDungeonTools:GetCurrentPreset() then
                MethodDungeonTools:DungeonEnemies_UpdateFreeholdCrew(preset.freeholdCrew)
                MethodDungeonTools:UpdateFreeholdSelector(week)
                MethodDungeonTools:ReloadPullButtons()
                MethodDungeonTools:UpdateProgressbar()
            end
        end
    end

    --Siege of Boralus
    if prefix == MethodDungeonTools.liveSessionPrefixes.bora then
        if MethodDungeonTools.liveSessionActive then
            local preset = MethodDungeonTools:GetCurrentLivePreset()
            local faction = tonumber(message)
            preset.faction = faction
            if preset == MethodDungeonTools:GetCurrentPreset() then
                MethodDungeonTools:UpdateBoralusSelector()
                MethodDungeonTools:ReloadPullButtons()
                MethodDungeonTools:UpdateProgressbar()
            end
        end
    end

    --MDI
    if prefix == MethodDungeonTools.liveSessionPrefixes.mdi then
        if MethodDungeonTools.liveSessionActive then
            local preset = MethodDungeonTools:GetCurrentLivePreset()
            local updateUI = preset == MethodDungeonTools:GetCurrentPreset()
            local action,data = string.match(message,"(.*):(.*)")
            data = tonumber(data)
            if action == "toggle" then
                MethodDungeonTools:GetDB().MDI.enabled = data == 1 or false
                MethodDungeonTools:DisplayMDISelector()
            elseif action == "beguiling" then
                preset.mdi.beguiling = data
                if updateUI then
                    MethodDungeonTools.MDISelector.BeguilingDropDown:SetValue(preset.mdi.beguiling)
                    MethodDungeonTools:DungeonEnemies_UpdateSeasonalAffix()
                    MethodDungeonTools:DungeonEnemies_UpdateBoralusFaction(preset.faction)
                    MethodDungeonTools:UpdateProgressbar()
                    MethodDungeonTools:ReloadPullButtons()
                    MethodDungeonTools:POI_UpdateAll()
                    MethodDungeonTools:KillAllAnimatedLines()
                    MethodDungeonTools:DrawAllAnimatedLines()
                end
            elseif action == "freehold" then
                preset.mdi.freehold = data
                if updateUI then
                    MethodDungeonTools.MDISelector.FreeholdDropDown:SetValue(preset.mdi.freehold)
                    if preset.mdi.freeholdJoined then
                        MethodDungeonTools:DungeonEnemies_UpdateFreeholdCrew(preset.mdi.freehold)
                    end
                    MethodDungeonTools:DungeonEnemies_UpdateBlacktoothEvent()
                    MethodDungeonTools:UpdateProgressbar()
                    MethodDungeonTools:ReloadPullButtons()
                end
            elseif action == "join" then
                preset.mdi.freeholdJoined = data == 1 or false
                if updateUI then
                    MethodDungeonTools:DungeonEnemies_UpdateFreeholdCrew()
                    MethodDungeonTools:ReloadPullButtons()
                    MethodDungeonTools:UpdateProgressbar()
                end
            end

        end
    end

end


---MakeSendingStatusBar
---Creates a bar that indicates sending progress when sharing presets with your group
---Called once from initFrames()
function MethodDungeonTools:MakeSendingStatusBar(f)
    f.SendingStatusBar = CreateFrame("StatusBar", nil, f)
    local statusbar = f.SendingStatusBar
    statusbar:SetMinMaxValues(0, 1)
    statusbar:SetPoint("LEFT", f.bottomPanel, "LEFT", 5, 0)
    statusbar:SetWidth(200)
    statusbar:SetHeight(20)
    statusbar:SetStatusBarTexture("Interface\\TARGETINGFRAME\\UI-StatusBar")
    statusbar:GetStatusBarTexture():SetHorizTile(false)
    statusbar:GetStatusBarTexture():SetVertTile(false)
    statusbar:SetStatusBarColor(0.26,0.42,1)

    statusbar.bg = statusbar:CreateTexture(nil, "BACKGROUND")
    statusbar.bg:SetTexture("Interface\\TARGETINGFRAME\\UI-StatusBar")
    statusbar.bg:SetAllPoints(true)
    statusbar.bg:SetVertexColor(0.26,0.42,1)

    statusbar.value = statusbar:CreateFontString(nil, "OVERLAY")
    statusbar.value:SetPoint("CENTER", statusbar, "CENTER", 0, 0)
    statusbar.value:SetFontObject("GameFontNormalSmall")
    statusbar.value:SetJustifyH("CENTER")
    statusbar.value:SetJustifyV("CENTER")
    statusbar.value:SetShadowOffset(1, -1)
    statusbar.value:SetTextColor(1, 1, 1)
    statusbar:Hide()

    if IsAddOnLoaded("ElvUI") then
        local E, L, V, P, G = unpack(ElvUI)
        statusbar:SetStatusBarTexture(E.media.normTex)
    end
end

--callback for SendCommMessage
local function displaySendingProgress(userArgs,bytesSent,bytesToSend)
    MethodDungeonTools.main_frame.SendingStatusBar:Show()
    MethodDungeonTools.main_frame.SendingStatusBar:SetValue(bytesSent/bytesToSend)
    MethodDungeonTools.main_frame.SendingStatusBar.value:SetText(string.format("Sending: %.1f",bytesSent/bytesToSend*100).."%")
    --done sending
    if bytesSent == bytesToSend then
        local distribution = userArgs[1]
        local preset = userArgs[2]
        local silent = userArgs[3]
        --restore "Send" and "Live" button
        if MethodDungeonTools.liveSessionActive then
            MethodDungeonTools.main_frame.LiveSessionButton:SetText("*Live*")
        else
            MethodDungeonTools.main_frame.LiveSessionButton:SetText("Live")
            MethodDungeonTools.main_frame.LiveSessionButton.text:SetTextColor(1,0.8196,0)
            MethodDungeonTools.main_frame.LinkToChatButton:SetDisabled(false)
            MethodDungeonTools.main_frame.LinkToChatButton.text:SetTextColor(1,0.8196,0)
        end
        MethodDungeonTools.main_frame.LinkToChatButton:SetText("Share")
        MethodDungeonTools.main_frame.LiveSessionButton:SetDisabled(false)
        MethodDungeonTools.main_frame.SendingStatusBar:Hide()
        --output chat link
        if not silent then
            local prefix = "[MethodDungeonTools: "
            local dungeon = MethodDungeonTools:GetDungeonName(preset.value.currentDungeonIdx)
            local presetName = preset.text
            local name, realm = UnitFullName("player")
            local fullName = name.."+"..realm
            SendChatMessage(prefix..fullName.." - "..dungeon..": "..presetName.."]",distribution)
            MethodDungeonTools:SetThrottleValues(true)
        end
    end
end

---SetUniqueID
---generates a unique random 11 digit number in base64 and assigns it to a preset if it does not have one yet
---credit to WeakAuras2
function MethodDungeonTools:SetUniqueID(preset)
    if not preset.uid then
        local s = {}
        for i=1,11 do
            tinsert(s, bytetoB64[math.random(0, 63)])
        end
        preset.uid = table.concat(s)
    end
end

---SendToGroup
---Send current preset to group/raid
function MethodDungeonTools:SendToGroup(distribution,silent,preset)
    MethodDungeonTools:SetThrottleValues()
    preset = preset or MethodDungeonTools:GetCurrentPreset()
    --set unique id
    MethodDungeonTools:SetUniqueID(preset)
    --gotta encode mdi mode / difficulty into preset
    local db = MethodDungeonTools:GetDB()
    preset.mdiEnabled = db.MDI.enabled
    preset.difficulty = db.currentDifficulty
    local export = MethodDungeonTools:TableToString(preset,false,5)
    MDTcommsObject:SendCommMessage("MDTPreset", export, distribution, nil, "BULK",displaySendingProgress,{distribution,preset,silent})
end

---GetPresetSize
---Returns the number of characters the string version of the preset contains
function MethodDungeonTools:GetPresetSize(forChat,level)
    local preset = MethodDungeonTools:GetCurrentPreset()
    local export = MethodDungeonTools:TableToString(preset,forChat,level)
    return string.len(export)
end

local defaultCPS = tonumber(_G.ChatThrottleLib.MAX_CPS)
local defaultBURST = tonumber(_G.ChatThrottleLib.BURST)
function MethodDungeonTools:SetThrottleValues(default)
    if not _G.ChatThrottleLib then return end
    if default then
        _G.ChatThrottleLib.MAX_CPS = defaultCPS
        _G.ChatThrottleLib.BURST = defaultBURST
    else --4000/16000 is fine but we go safe with 2000/10000
        _G.ChatThrottleLib.MAX_CPS= 2000
        _G.ChatThrottleLib.BURST = 10000
    end
end
