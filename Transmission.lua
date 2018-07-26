local Compresser = LibStub:GetLibrary("LibCompress");
local Encoder = Compresser:GetAddonEncodeTable()
local Serializer = LibStub:GetLibrary("AceSerializer-3.0");
local Comm = LibStub:GetLibrary("AceComm-3.0");

MDTcommsObject = LibStub("AceAddon-3.0"):NewAddon("MDTCommsObject","AceComm-3.0","AceSerializer-3.0")

-- Lua APIs
--local tinsert = table.insert
local tostring, string_char, strsplit = tostring, string.char, strsplit
local pairs, type, unpack = pairs, type, unpack
--local error = error
local bit_band, bit_lshift, bit_rshift = bit.band, bit.lshift, bit.rshift
--local coroutine = coroutine

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
        local start, finish, characterName, displayName = remaining:find("%[MethodDungeonTools: ([^%s]+) %- ([^%]]+)%]");
        if(characterName and displayName) then
            characterName = characterName:gsub("|c[Ff][Ff]......", ""):gsub("|r", "");
            displayName = displayName:gsub("|c[Ff][Ff]......", ""):gsub("|r", "");
            newMsg = newMsg..remaining:sub(1, start-1);
            newMsg = newMsg.."|HMethodDungeonTools-"..characterName.."|h|cFFF49D38["..characterName.." |r|cFFF49D38- "..displayName.."]|h|r";
            remaining = remaining:sub(finish + 1);
        else
            done = true;
        end
    until(done)
    if newMsg ~= "" then
        return false, newMsg, player, l, cs, t, flag, channelId, ...;
    end
end

local presetCommPrefix = "MDTPreset"
function MDTcommsObject:OnEnable()
    self:RegisterComm(presetCommPrefix)
    MethodDungeonTools.transmissionCache = {}
    ChatFrame_AddMessageEventFilter("CHAT_MSG_PARTY", filterFunc)
    ChatFrame_AddMessageEventFilter("CHAT_MSG_PARTY_LEADER", filterFunc)
    ChatFrame_AddMessageEventFilter("CHAT_MSG_RAID", filterFunc)
    ChatFrame_AddMessageEventFilter("CHAT_MSG_RAID_LEADER", filterFunc)
end

--handle preset chat link clicks
local OriginalSetHyperlink = ItemRefTooltip.SetHyperlink
function ItemRefTooltip:SetHyperlink(link, ...)
    if(link and link:sub(0, 18) == "MethodDungeonTools") then
        local sender = link:sub(20, string.len(link))
        local preset = MethodDungeonTools.transmissionCache[sender]
        if preset then
            MethodDungeonTools:ShowInterface(true)
            MethodDungeonTools:OpenChatImportPresetDialog(sender,preset)
        end
        return;
    end
    return OriginalSetHyperlink(self, link, ...);
end

--ignore modified (alt/shift/ctrl) clicks on link
local OriginalHandleModifiedItemClick = HandleModifiedItemClick
function HandleModifiedItemClick(link, ...)
    if(link and link:find("|HMethodDungeonTools|h")) then
        return;
    end
    return OriginalHandleModifiedItemClick(link, ...);
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
    end
end

--callback for SendCommMessage
--TODO animate a progressbar here if we want to
local function displaySendingProgress(userArgs,bytesSent,bytesToSend)
    --print(string.format("Progress: %.1f",bytesSent/bytesToSend*100))

    --done sending
    if bytesSent == bytesToSend then
        --restore "Send" button
        MethodDungeonTools.main_frame.LinkToChatButton:SetDisabled(false)
        MethodDungeonTools.main_frame.LinkToChatButton:SetText("Share")
        --output chat link
        local distribution = userArgs[1]
        local preset = userArgs[2]
        local dungeon = MethodDungeonTools:GetDungeonName(preset.value.currentDungeonIdx)
        local presetName = preset.text
        local name, realm = UnitFullName("player")
        local fullName = name.."-"..realm
        SendChatMessage("[MethodDungeonTools: "..fullName.." - "..dungeon..": "..presetName.."]",distribution)
    end
end

---SendToGroup
---Send current preset to group/raid
function MethodDungeonTools:SendToGroup(distribution)
    local preset = MethodDungeonTools:GetCurrentPreset()
    local export = MethodDungeonTools:TableToString(preset,true)
    MDTcommsObject:SendCommMessage("MDTPreset", export, distribution, nil, "BULK",displaySendingProgress,{distribution,preset})
end
