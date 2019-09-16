local Compresser = LibStub:GetLibrary("LibCompress");
local Encoder = Compresser:GetAddonEncodeTable()
local Serializer = LibStub:GetLibrary("AceSerializer-3.0");

MDTcommsObject = LibStub("AceAddon-3.0"):NewAddon("MDTCommsObject","AceComm-3.0","AceSerializer-3.0")

-- Lua APIs
local tostring, string_char, strsplit,tremove = tostring, string.char, strsplit,table.remove
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
local encodeB64Table = {};

function encodeB64(str)
    local B64 = encodeB64Table;
    local remainder = 0;
    local remainder_length = 0;
    local encoded_size = 0;
    local l=#str
    local code
    for i=1,l do
        code = string.byte(str, i);
        remainder = remainder + bit_lshift(code, remainder_length);
        remainder_length = remainder_length + 8;
        while(remainder_length) >= 6 do
            encoded_size = encoded_size + 1;
            B64[encoded_size] = bytetoB64[bit_band(remainder, 63)];
            remainder = bit_rshift(remainder, 6);
            remainder_length = remainder_length - 6;
        end
    end
    if remainder_length > 0 then
        encoded_size = encoded_size + 1;
        B64[encoded_size] = bytetoB64[remainder];
    end
    return table.concat(B64, "", 1, encoded_size)
end

local decodeB64Table = {}

function decodeB64(str)
    local bit8 = decodeB64Table;
    local decoded_size = 0;
    local ch;
    local i = 1;
    local bitfield_len = 0;
    local bitfield = 0;
    local l = #str;
    while true do
        if bitfield_len >= 8 then
            decoded_size = decoded_size + 1;
            bit8[decoded_size] = string_char(bit_band(bitfield, 255));
            bitfield = bit_rshift(bitfield, 8);
            bitfield_len = bitfield_len - 8;
        end
        ch = B64tobyte[str:sub(i, i)];
        bitfield = bitfield + bit_lshift(ch or 0, bitfield_len);
        bitfield_len = bitfield_len + 6;
        if i > l then
            break;
        end
        i = i + 1;
    end
    return table.concat(bit8, "", 1, decoded_size)
end

function MethodDungeonTools:TableToString(inTable, forChat)
    local serialized = Serializer:Serialize(inTable);
    local compressed = Compresser:CompressHuffman(serialized);
    if(forChat) then
        return encodeB64(compressed);
    else
        return Encoder:Encode(compressed);
    end
end

function MethodDungeonTools:StringToTable(inString, fromChat)
    local decoded;
    if(fromChat) then
        decoded = decodeB64(inString);
    else
        decoded = Encoder:Decode(inString);
    end

    local decompressed, errorMsg = Compresser:Decompress(decoded);
    if not(decompressed) then
        return "Error decompressing: "..errorMsg;
    end

    local success, deserialized = Serializer:Deserialize(decompressed);
    if not(success) then
        return "Error deserializing "..deserialized;
    end
    return deserialized;
end



local function filterFunc(_, event, msg, player, l, cs, t, flag, channelId, ...)
    if flag == "GM" or flag == "DEV" then
        return
    end
    local newMsg = "";
    local remaining = msg;
    local done;
    repeat
        local start, finish, characterName, displayName = remaining:find("%[MethodDungeonTools: ([^%s]+) %- ([^%]]+)%]")
        local startLive, finishLive, characterNameLive, displayNameLive = remaining:find("%[MDTLive: ([^%s]+) %- ([^%]]+)%]")
        if(characterName and displayName) then
            characterName = characterName:gsub("|c[Ff][Ff]......", ""):gsub("|r", "")
            displayName = displayName:gsub("|c[Ff][Ff]......", ""):gsub("|r", "")
            newMsg = newMsg..remaining:sub(1, start-1)
            --newMsg = newMsg.."|HMethodDungeonTools-"..characterName.."|h|cFFF49D38[".."|r|cFFF49D38"..displayName.."]|h|r"
            newMsg = "|cfff49d38|HMethodDungeonTools-"..characterName.."|h["..displayName.."]|h|r"
            remaining = remaining:sub(finish + 1)
        elseif (characterNameLive and displayNameLive) then
            characterNameLive = characterNameLive:gsub("|c[Ff][Ff]......", ""):gsub("|r", "")
            displayNameLive = displayNameLive:gsub("|c[Ff][Ff]......", ""):gsub("|r", "")
            newMsg = newMsg..remaining:sub(1, startLive-1)
            newMsg = newMsg.."|HMDTLive-"..characterNameLive.."|h[".."|cFF00FF00Live Session: |cfff49d38"..""..displayNameLive.."]|h|r"
            remaining = remaining:sub(finishLive + 1)
        else
            done = true;
        end
    until(done)
    if newMsg ~= "" then
        return false, newMsg, player, l, cs, t, flag, channelId, ...;
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
local OriginalSetItemRef = SetItemRef
function SetItemRef(link, ...)
    if(link and link:sub(0, 18) == "MethodDungeonTools") then
        local sender = link:sub(20, string.len(link))
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
    if(link and link:sub(0, 7) == "MDTLive") then
        local sender = link:sub(9, string.len(link))
        local name,realm = string.match(sender,"(.*)+(.*)")
        sender = name.."-"..realm
        --ignore importing the live preset when sender is player, open MDT only, TODO: navigate to the preset
        local playerName,playerRealm = UnitFullName("player")
        playerName = playerName.."-"..playerRealm
        if sender==playerName then
            MethodDungeonTools:ShowInterface(true)
        else
            MethodDungeonTools:ShowInterface(true)
            MethodDungeonTools:LiveSession_Enable()
        end
        return
    end
    return OriginalSetItemRef(link, ...)
end

function MDTcommsObject:OnCommReceived(prefix, message, distribution, sender)
    --[[
        this is weird
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
        local preset = MethodDungeonTools:StringToTable(message,true)
        MethodDungeonTools.transmissionCache[fullName] = preset
        --live session preset
        if MethodDungeonTools.liveSessionActive and MethodDungeonTools.liveSessionAcceptingPreset and preset.uid == MethodDungeonTools.livePresetUID then
            if MethodDungeonTools:ValidateImportPreset(preset) then
                MethodDungeonTools:ImportPreset(preset,true)
                MethodDungeonTools.liveSessionAcceptingPreset = false
                MethodDungeonTools.main_frame.SendingStatusBar:Hide()
                MethodDungeonTools.main_frame.LoadingSpinner:Hide()
                MethodDungeonTools.main_frame.LoadingSpinner.Anim:Stop()
                MethodDungeonTools.liveSessionRequested = false
            end
        end
    end

    --live session messages from here on, we ignore our own messages
    if sender == UnitFullName("player") then return end

    if prefix == MethodDungeonTools.liveSessionPrefixes.enabled then
        if MethodDungeonTools.liveSessionRequested == true then
            MethodDungeonTools:LiveSession_SessionFound(message)
        end
    end

    if prefix == MethodDungeonTools.liveSessionPrefixes.request then
        if MethodDungeonTools.liveSessionActive then
            MethodDungeonTools:LiveSession_NotifyEnabled(fullName)
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
            local obj = MethodDungeonTools:StringToTable(message,true)
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
            local changedObjects = MethodDungeonTools:StringToTable(message,true)
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
            local preset = MethodDungeonTools:StringToTable(message,true)
            if MethodDungeonTools:ValidateImportPreset(preset) then
                MethodDungeonTools.livePresetUID = preset.uid
                MethodDungeonTools:ImportPreset(preset,true)
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
        MethodDungeonTools.main_frame.LinkToChatButton:SetDisabled(false)
        MethodDungeonTools.main_frame.LiveSessionButton:SetDisabled(false)
        MethodDungeonTools.main_frame.LinkToChatButton:SetText("Share")
        MethodDungeonTools.main_frame.LiveSessionButton:SetText(MethodDungeonTools.liveSessionActive == true and "*Live*" or "Live")
        MethodDungeonTools.main_frame.SendingStatusBar:Hide()
        --output chat link
        if not silent then
            local prefix = "[MethodDungeonTools: "
            local dungeon = MethodDungeonTools:GetDungeonName(preset.value.currentDungeonIdx)
            local presetName = preset.text
            local name, realm = UnitFullName("player")
            local fullName = name.."+"..realm
            SendChatMessage(prefix..fullName.." - "..dungeon..": "..presetName.."]",distribution)
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
    preset = preset or MethodDungeonTools:GetCurrentPreset()
    --set unique id
    MethodDungeonTools:SetUniqueID(preset)
    local export = MethodDungeonTools:TableToString(preset,true)
    MDTcommsObject:SendCommMessage("MDTPreset", export, distribution, nil, "BULK",displaySendingProgress,{distribution,preset,silent})
end

---GetPresetSize
---Returns the number of characters the string version of the preset contains
function MethodDungeonTools:GetPresetSize()
    local preset = MethodDungeonTools:GetCurrentPreset()
    local export = MethodDungeonTools:TableToString(preset,true)
    return string.len(export)
end
