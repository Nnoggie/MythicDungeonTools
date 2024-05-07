local AddonName, MDT = ...
local L = MDT.L
local Compresser = LibStub:GetLibrary("LibCompress")
local Encoder = Compresser:GetAddonEncodeTable()
local Serializer = LibStub:GetLibrary("AceSerializer-3.0")
local LibDeflate = LibStub:GetLibrary("LibDeflate")
local configForDeflate = {
  [1] = { level = 1 },
  [2] = { level = 2 },
  [3] = { level = 3 },
  [4] = { level = 4 },
  [5] = { level = 5 },
  [6] = { level = 6 },
  [7] = { level = 7 },
  [8] = { level = 8 },
  [9] = { level = 9 },
}
MDTcommsObject = LibStub("AceAddon-3.0"):NewAddon("MDTCommsObject", "AceComm-3.0", "AceSerializer-3.0")
local numActiveTransmissions = 0

-- Lua APIs
local string_char, tremove, tinsert = string.char, table.remove, table.insert
local pairs, type, unpack = pairs, type, unpack
local bit_band, bit_lshift, bit_rshift = bit.band, bit.lshift, bit.rshift

--Based on code from WeakAuras2, all credit goes to the authors
local bytetoB64 = {
  [0] = "a",
  "b",
  "c",
  "d",
  "e",
  "f",
  "g",
  "h",
  "i",
  "j",
  "k",
  "l",
  "m",
  "n",
  "o",
  "p",
  "q",
  "r",
  "s",
  "t",
  "u",
  "v",
  "w",
  "x",
  "y",
  "z",
  "A",
  "B",
  "C",
  "D",
  "E",
  "F",
  "G",
  "H",
  "I",
  "J",
  "K",
  "L",
  "M",
  "N",
  "O",
  "P",
  "Q",
  "R",
  "S",
  "T",
  "U",
  "V",
  "W",
  "X",
  "Y",
  "Z",
  "0",
  "1",
  "2",
  "3",
  "4",
  "5",
  "6",
  "7",
  "8",
  "9",
  "(",
  ")"
}

local B64tobyte = {
  a = 0,
  b = 1,
  c = 2,
  d = 3,
  e = 4,
  f = 5,
  g = 6,
  h = 7,
  i = 8,
  j = 9,
  k = 10,
  l = 11,
  m = 12,
  n = 13,
  o = 14,
  p = 15,
  q = 16,
  r = 17,
  s = 18,
  t = 19,
  u = 20,
  v = 21,
  w = 22,
  x = 23,
  y = 24,
  z = 25,
  A = 26,
  B = 27,
  C = 28,
  D = 29,
  E = 30,
  F = 31,
  G = 32,
  H = 33,
  I = 34,
  J = 35,
  K = 36,
  L = 37,
  M = 38,
  N = 39,
  O = 40,
  P = 41,
  Q = 42,
  R = 43,
  S = 44,
  T = 45,
  U = 46,
  V = 47,
  W = 48,
  X = 49,
  Y = 50,
  Z = 51,
  ["0"] = 52,
  ["1"] = 53,
  ["2"] = 54,
  ["3"] = 55,
  ["4"] = 56,
  ["5"] = 57,
  ["6"] = 58,
  ["7"] = 59,
  ["8"] = 60,
  ["9"] = 61,
  ["("] = 62,
  [")"] = 63
}

-- This code is based on the Encode7Bit algorithm from LibCompress
-- Credit goes to Galmok (galmok@gmail.com)
local decodeB64Table = {}

local function decodeB64(str)
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

function MDT:TableToString(inTable, forChat, level)
  local serialized = Serializer:Serialize(inTable)
  local compressed = LibDeflate:CompressDeflate(serialized, configForDeflate[level])
  -- prepend with "!" so that we know that it is not a legacy compression
  -- also this way, old versions will error out due to the "bad" encoding
  local encoded = "!"
  if (forChat) then
    encoded = encoded..LibDeflate:EncodeForPrint(compressed)
  else
    encoded = encoded..LibDeflate:EncodeForWoWAddonChannel(compressed)
  end
  return encoded
end

function MDT:StringToTable(inString, fromChat)
  -- if gsub strips off a ! at the beginning then we know that this is not a legacy encoding
  local encoded, usesDeflate = inString:gsub("^%!", "")
  local decoded
  if (fromChat) then
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
  if not (decompressed) then
    return "Error decompressing: "..errorMsg
  end

  local success, deserialized = Serializer:Deserialize(decompressed)
  if not (success) then
    return "Error deserializing "..deserialized
  end
  return deserialized
end

local checkChatframeInteractive
do
  local lastPrintTime = 0
  checkChatframeInteractive = function(chatFrame)
    if chatFrame and chatFrame.isUninteractable then
      local currentTime = GetTime()
      if currentTime - lastPrintTime >= 5 * 60 then
        C_Timer.After(0.2, function()
          print("MDT: |cFFFF0000Warning!|r "..L["chatNoninteractiveWarning"])
        end)
        lastPrintTime = currentTime
      end
    end
  end
end

local function filterFunc(chatFrame, event, msg, player, l, cs, t, flag, channelId, ...)
  if flag == "GM" or flag == "DEV" or (event == "CHAT_MSG_CHANNEL" and type(channelId) == "number" and channelId > 0) then
    return
  end
  local newMsg = ""
  local remaining = msg
  local done
  repeat
    local start, finish, characterName, displayName = remaining:find("%[MDT_v2: ([^%s]+) %- ([^%]]+)%]")
    local startLive, finishLive, characterNameLive, displayNameLive = remaining:find("%[MDTLive: ([^%s]+) %- ([^%]]+)%]")
    if (characterName and displayName) then
      characterName = characterName:gsub("|c[Ff][Ff]......", ""):gsub("|r", "")
      displayName = displayName:gsub("|c[Ff][Ff]......", ""):gsub("|r", "")
      newMsg = newMsg..remaining:sub(1, start - 1)
      local texture = "|TInterface\\AddOns\\"..AddonName.."\\Textures\\NnoggieMinimap:12|t"
      newMsg = "|cffe6cc80|Hgarrmission:mdt-"..characterName.."|h["..displayName.."]|h|r"
      remaining = remaining:sub(finish + 1)
      checkChatframeInteractive(chatFrame)
    elseif (characterNameLive and displayNameLive) then
      characterNameLive = characterNameLive:gsub("|c[Ff][Ff]......", ""):gsub("|r", "")
      displayNameLive = displayNameLive:gsub("|c[Ff][Ff]......", ""):gsub("|r", "")
      newMsg = newMsg..remaining:sub(1, startLive - 1)
      newMsg = newMsg..
          "|Hgarrmission:mdtlive-"..
          characterNameLive.."|h[".."|cFF00FF00Live Session: |cffe6cc80"..""..displayNameLive.."]|h|r"
      remaining = remaining:sub(finishLive + 1)
      checkChatframeInteractive(chatFrame)
    else
      done = true
    end
  until (done)
  if newMsg ~= "" then
    return false, newMsg, player, l, cs, t, flag, channelId, ...
  end
end

local presetCommPrefix = "MDTPreset"

MDT.liveSessionPrefixes = {
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
  ["reqPre"] = "MDTLiveReqPre",
  ["corrupted"] = "MDTLiveCor",
  ["difficulty"] = "MDTLiveLvl",
  ["poiAssignment"] = "MDTPOIAssignment",
}

MDT.dataCollectionPrefixes = {
  ["request"] = "MDTDataReq",
  ["distribute"] = "MDTDataDist",
}

---@diagnostic disable-next-line: duplicate-set-field
function MDTcommsObject:OnEnable()
  self:RegisterComm(presetCommPrefix)
  for _, prefix in pairs(MDT.liveSessionPrefixes) do
    self:RegisterComm(prefix)
  end
  for _, prefix in pairs(MDT.dataCollectionPrefixes) do
    self:RegisterComm(prefix)
  end
  MDT.transmissionCache = {}
  ChatFrame_AddMessageEventFilter("CHAT_MSG_PARTY", filterFunc)
  ChatFrame_AddMessageEventFilter("CHAT_MSG_PARTY_LEADER", filterFunc)
  ChatFrame_AddMessageEventFilter("CHAT_MSG_RAID", filterFunc)
  ChatFrame_AddMessageEventFilter("CHAT_MSG_RAID_LEADER", filterFunc)
end

--handle preset chat link clicks
hooksecurefunc("SetItemRef", function(link, text)
  if (link and link:sub(0, 19) == "garrmission:mdtlive") then
    local sender = link:sub(21, string.len(link))
    local name, realm = string.match(sender, "(.*)+(.*)")
    sender = name.."-"..realm
    --ignore importing the live preset when sender is player, open MDT only
    local playerName, playerRealm = UnitFullName("player")
    playerName = playerName.."-"..playerRealm
    if sender == playerName then
      MDT:Async(function() MDT:ShowInterfaceInternal(true) end, "showInterface")
    else
      MDT:Async(function()
        MDT:ShowInterfaceInternal(true)
        MDT:LiveSession_Enable()
      end, "showInterfaceLive")
    end
    return
  elseif (link and link:sub(0, 15) == "garrmission:mdt") then
    local sender = link:sub(17, string.len(link))
    local name, realm = string.match(sender, "(.*)+(.*)")
    if (not name) or (not realm) then
      print(string.format(L["receiveErrorUpdate"], sender))
      return
    end
    sender = name.."-"..realm
    local preset = MDT.transmissionCache[sender]
    if preset and type(preset) == "table" then
      MDT:Async(function()
        MDT:ShowInterfaceInternal(true)
        MDT:ImportPreset(CopyTable(preset))
      end, "showInterfaceChatImport")
    else
      print(string.format(L["receiveErrorUpdate"], sender))
    end
    return
  end
end)

function MDTcommsObject:OnCommReceived(prefix, message, distribution, sender)
  --[[
        Sender has no realm name attached when sender is from the same realm as the player
        UnitFullName("Nnoggie") returns no realm while UnitFullName("player") does
        UnitFullName("Nnoggie-TarrenMill") returns realm even if you are not on the same realm as Nnoggie
        We append our realm if there is no realm
    ]]
  local name, realm = UnitFullName(sender)
  if not name then return end
  if not realm or string.len(realm) < 3 then
    local _, r = UnitFullName("player")
    realm = r
  end
  local fullName = name.."-"..realm

  --standard preset transmission
  --we cache the preset here already
  --the user still decides if he wants to click the chat link and add the preset to his db
  if prefix == presetCommPrefix then
    local preset = MDT:StringToTable(message, false)
    MDT.transmissionCache[fullName] = preset
    --live session preset
    if MDT.liveSessionActive and MDT.liveSessionAcceptingPreset and preset.uid == MDT.livePresetUID then
      if MDT:ValidateImportPreset(preset) then
        MDT:ImportPreset(preset, true)
        MDT.liveSessionAcceptingPreset = false
        MDT.main_frame.SendingStatusBar:Hide()
        if MDT.main_frame.LoadingSpinner then
          MDT.main_frame.LoadingSpinner:Hide()
          MDT.main_frame.LoadingSpinner.Anim:Stop()
        end
        MDT.liveSessionRequested = false
      end
    end
  end

  if prefix == MDT.dataCollectionPrefixes.request then
    MDT.DataCollection:DistributeData()
  end

  if prefix == MDT.dataCollectionPrefixes.distribute then
    if sender == UnitFullName("player") then return end
    local package = MDT:StringToTable(message, false)
    print("Received data package from "..fullName)
    MDT.DataCollection:MergeReceiveData(package)
  end

  if prefix == MDT.liveSessionPrefixes.enabled then
    if MDT.liveSessionRequested == true then
      MDT:LiveSession_SessionFound(fullName, message)
    end
  end

  --pulls
  if prefix == MDT.liveSessionPrefixes.pull then
    if MDT.liveSessionActive then
      local preset = MDT:GetCurrentLivePreset()
      local pulls = MDT:StringToTable(message, false)
      preset.value.pulls = pulls
      if not preset.value.pulls[preset.value.currentPull] then
        preset.value.currentPull = #preset.value.pulls
        preset.value.selection = { #preset.value.pulls }
      end
      if preset == MDT:GetCurrentPreset() then
        MDT:ReloadPullButtons()
        MDT:SetSelectionToPull(MDT:GetCurrentPull())
        MDT:POI_UpdateAll() --for corrupted spires
        MDT:UpdateProgressbar()
      end
    end
  end

  --corrupted
  if prefix == MDT.liveSessionPrefixes.corrupted then
    if MDT.liveSessionActive then
      local preset = MDT:GetCurrentLivePreset()
      local offsets = MDT:StringToTable(message, false)
      --only reposition if no blip is currently moving
      if not MDT.draggedBlip then
        preset.value.riftOffsets = offsets
        MDT:UpdateMap()
      end
    end
  end

  --difficulty
  if prefix == MDT.liveSessionPrefixes.difficulty then
    if MDT.liveSessionActive then
      local db = MDT:GetDB()
      local difficulty = tonumber(message)
      if difficulty and difficulty ~= db.currentDifficulty then
        local updateSeasonal
        if ((difficulty >= 10 and db.currentDifficulty < 10) or (difficulty < 10 and db.currentDifficulty >= 10)) then
          updateSeasonal = true
        end
        db.currentDifficulty = difficulty
        MDT.main_frame.sidePanel.DifficultySlider:SetValue(difficulty)
        MDT:UpdateProgressbar()
        if MDT.EnemyInfoFrame and MDT.EnemyInfoFrame.frame:IsShown() then MDT:UpdateEnemyInfoData() end
        MDT:ReloadPullButtons()
        if updateSeasonal then
          MDT:DungeonEnemies_UpdateSeasonalAffix()
          MDT.main_frame.sidePanel.difficultyWarning:Toggle(difficulty)
          MDT:POI_UpdateAll()
          MDT:KillAllAnimatedLines()
          MDT:DrawAllAnimatedLines()
        end
      end
    end
  end

  --week
  if prefix == MDT.liveSessionPrefixes.week then
    if MDT.liveSessionActive then
      local preset = MDT:GetCurrentLivePreset()
      local week = tonumber(message)
      if preset.week ~= week then
        preset.week = week
        local teeming = MDT:IsPresetTeeming(preset)
        preset.value.teeming = teeming
        if preset == MDT:GetCurrentPreset() then
          local affixDropdown = MDT.main_frame.sidePanel.affixDropdown
          affixDropdown:SetValue(week)
          if not MDT:GetCurrentAffixWeek() then
            MDT.main_frame.sidePanel.affixWeekWarning.image:Hide()
            MDT.main_frame.sidePanel.affixWeekWarning:SetDisabled(true)
          elseif MDT:GetCurrentAffixWeek() == week then
            MDT.main_frame.sidePanel.affixWeekWarning.image:Hide()
            MDT.main_frame.sidePanel.affixWeekWarning:SetDisabled(true)
          else
            MDT.main_frame.sidePanel.affixWeekWarning.image:Show()
            MDT.main_frame.sidePanel.affixWeekWarning:SetDisabled(false)
          end
          MDT:DungeonEnemies_UpdateTeeming()
          MDT:DungeonEnemies_UpdateInspiring()
          MDT:DungeonEnemies_UpdateSeasonalAffix()
          MDT:DungeonEnemies_UpdateBoralusFaction(preset.faction)
          MDT:POI_UpdateAll()
          MDT:UpdateProgressbar()
          MDT:ReloadPullButtons()
          MDT:KillAllAnimatedLines()
          MDT:DrawAllAnimatedLines()
        end
      end
    end
  end

  if prefix == MDT.liveSessionPrefixes.poiAssignment then
    if MDT.liveSessionActive then
      local preset = MDT:GetCurrentLivePreset()
      local deserialized = MDT:StringToTable(message, false)
      if deserialized and type(deserialized) == "table" then
        local sublevel, poiIdx, value = unpack(deserialized)
        preset.value.poiAssignments = preset.value.poiAssignments or {}
        preset.value.poiAssignments[sublevel] = preset.value.poiAssignments[sublevel] or {}
        preset.value.poiAssignments[sublevel][poiIdx] = value
        MDT:UpdateMap()
        if sender ~= UnitFullName("player") and MDT:GetCurrentSubLevel() == sublevel then
          local poiFrame = MDT:POI_GetFrameForPOI(poiIdx)
          if poiFrame then UIFrameFlash(poiFrame, 0.5, 1, 1, true, 1, 0); end
        end
      end
    end
  end

  --live session messages that ignore concurrency from here on, we ignore our own messages
  if sender == UnitFullName("player") then return end


  if prefix == MDT.liveSessionPrefixes.request then
    if MDT.liveSessionActive then
      MDT:LiveSession_NotifyEnabled()
    end
  end

  --request preset
  if prefix == MDT.liveSessionPrefixes.reqPre then
    local playerName, playerRealm = UnitFullName("player")
    playerName = playerName.."-"..playerRealm
    if playerName == message then
      MDT:SendToGroup(MDT:IsPlayerInGroup(), true, MDT:GetCurrentLivePreset())
    end
  end


  --ping
  if prefix == MDT.liveSessionPrefixes.ping then
    local currentUID = MDT:GetCurrentPreset().uid
    if MDT.liveSessionActive and (currentUID and currentUID == MDT.livePresetUID) then
      local x, y, sublevel = string.match(message, "(.*):(.*):(.*)")
      x = tonumber(x)
      y = tonumber(y)
      sublevel = tonumber(sublevel)
      local scale = MDT:GetScale()
      if sublevel == MDT:GetCurrentSubLevel() then
        MDT:PingMap(x * scale, y * scale)
      end
    end
  end

  --preset objects
  if prefix == MDT.liveSessionPrefixes.obj then
    if MDT.liveSessionActive then
      local preset = MDT:GetCurrentLivePreset()
      local obj = MDT:StringToTable(message, false)
      MDT:StorePresetObject(obj, true, preset)
      if preset == MDT:GetCurrentPreset() then
        local scale = MDT:GetScale()
        local currentPreset = MDT:GetCurrentPreset()
        local currentSublevel = MDT:GetCurrentSubLevel()
        MDT:DrawPresetObject(obj, nil, scale, currentPreset, currentSublevel)
      end
    end
  end

  --preset object offsets
  if prefix == MDT.liveSessionPrefixes.objOff then
    if MDT.liveSessionActive then
      local preset = MDT:GetCurrentLivePreset()
      local objIdx, x, y = string.match(message, "(.*):(.*):(.*)")
      objIdx = tonumber(objIdx)
      x = tonumber(x)
      y = tonumber(y)
      MDT:UpdatePresetObjectOffsets(objIdx, x, y, preset, true)
      if preset == MDT:GetCurrentPreset() then MDT:DrawAllPresetObjects() end
    end
  end

  --preset object changed (deletions, partial deletions)
  if prefix == MDT.liveSessionPrefixes.objChg then
    if MDT.liveSessionActive then
      local preset = MDT:GetCurrentLivePreset()
      local changedObjects = MDT:StringToTable(message, false)
      if changedObjects and type(changedObjects) == "table" then
        for objIdx, obj in pairs(changedObjects) do
          preset.objects[objIdx] = obj
        end
        if preset == MDT:GetCurrentPreset() then MDT:DrawAllPresetObjects() end
      end
    end
  end

  --various commands
  if prefix == MDT.liveSessionPrefixes.cmd then
    if MDT.liveSessionActive then
      local preset = MDT:GetCurrentLivePreset()
      if message == "deletePresetObjects" then MDT:DeletePresetObjects(preset, true) end
      if message == "undo" then MDT:PresetObjectStepBack(preset, true, true) end
      if message == "redo" then MDT:PresetObjectStepForward(preset, true, true) end
      if message == "clear" then MDT:ClearPreset(preset, true) end
    end
  end

  --note text update, delete, move
  if prefix == MDT.liveSessionPrefixes.note then
    if MDT.liveSessionActive then
      local preset = MDT:GetCurrentLivePreset()
      local action, noteIdx, text, y = string.match(message, "(.*):(.*):(.*):(.*)")
      noteIdx = tonumber(noteIdx)
      if action == "text" then
        preset.objects[noteIdx].d[5] = text
      elseif action == "delete" then
        tremove(preset.objects, noteIdx)
      elseif action == "move" then
        local x = tonumber(text)
        y = tonumber(y)
        preset.objects[noteIdx].d[1] = x
        preset.objects[noteIdx].d[2] = y
      end
      if preset == MDT:GetCurrentPreset() then MDT:DrawAllPresetObjects() end
    end
  end

  --preset
  if prefix == MDT.liveSessionPrefixes.preset then
    if MDT.liveSessionActive then
      local preset = MDT:StringToTable(message, false)
      MDT.transmissionCache[fullName] = preset
      if MDT:ValidateImportPreset(preset) then
        MDT.livePresetUID = preset.uid
        MDT:ImportPreset(preset, true)
      end
    end
  end

  --Siege of Boralus
  if prefix == MDT.liveSessionPrefixes.bora then
    if MDT.liveSessionActive then
      local preset = MDT:GetCurrentLivePreset()
      local faction = tonumber(message)
      preset.faction = faction
      if preset == MDT:GetCurrentPreset() then
        MDT:UpdateBoralusSelector()
        MDT:ReloadPullButtons()
        MDT:UpdateProgressbar()
      end
    end
  end
end

---MakeSendingStatusBar
---Creates a bar that indicates sending progress when sharing presets with your group
---Called once from initFrames()
function MDT:MakeSendingStatusBar(f)
  f.SendingStatusBar = CreateFrame("StatusBar", nil, f)
  local statusbar = f.SendingStatusBar
  statusbar:SetMinMaxValues(0, 1)
  statusbar:SetPoint("CENTER", MDT.main_frame.bottomPanel, "CENTER", 0, 0)
  statusbar:SetWidth(200)
  statusbar:SetHeight(20)
  statusbar:SetStatusBarTexture("Interface\\TARGETINGFRAME\\UI-StatusBar")
  statusbar:GetStatusBarTexture():SetHorizTile(false)
  statusbar:GetStatusBarTexture():SetVertTile(false)
  statusbar:SetStatusBarColor(0.26, 0.42, 1)

  statusbar.bg = statusbar:CreateTexture(nil, "BACKGROUND", nil, 0)
  statusbar.bg:SetTexture("Interface\\TARGETINGFRAME\\UI-StatusBar")
  statusbar.bg:SetAllPoints()
  statusbar.bg:SetVertexColor(0.26, 0.42, 1)

  statusbar.value = statusbar:CreateFontString(nil, "OVERLAY")
  statusbar.value:SetPoint("CENTER", statusbar, "CENTER", 0, 0)
  statusbar.value:SetFontObject(GameFontNormalSmall)
  statusbar.value:SetJustifyH("CENTER")
  statusbar.value:SetJustifyV("MIDDLE")
  statusbar.value:SetShadowOffset(1, -1)
  statusbar.value:SetTextColor(1, 1, 1)
  statusbar:Hide()

  --hooks to show/hide the bottom text
  statusbar:HookScript("OnShow", function(self)
    MDT.main_frame.bottomPanelString:Hide()
  end)
  statusbar:HookScript("OnHide", function(self)
    MDT.main_frame.bottomPanelString:Show()
  end)

  if IsAddOnLoaded("ElvUI") and ElvUI then
    local E, L, V, P, G = unpack(ElvUI)
    statusbar:SetStatusBarTexture(E.media.normTex)
  end
end

--callback for SendCommMessage
local function displaySendingProgress(userArgs, bytesSent, bytesToSend)
  MDT.main_frame.SendingStatusBar:Show()
  MDT.main_frame.SendingStatusBar:SetValue(bytesSent / bytesToSend)
  MDT.main_frame.SendingStatusBar.value:SetText(string.format(L["Sending: %.1f"], bytesSent / bytesToSend * 100).."%")
  --done sending
  if bytesSent == bytesToSend then
    local distribution = userArgs[1]
    local preset = userArgs[2]
    local silent = userArgs[3]
    local fromLiveSession = userArgs[4]
    --restore "Send" and "Live" button
    if MDT.liveSessionActive then
      MDT.main_frame.LiveSessionButton:SetText(L["*Live*"])
    else
      MDT.main_frame.LiveSessionButton:SetText(L["Live"])
      MDT.main_frame.LiveSessionButton.text:SetTextColor(1, 0.8196, 0)
      MDT.main_frame.LinkToChatButton:SetDisabled(false)
      MDT.main_frame.LinkToChatButton.text:SetTextColor(1, 0.8196, 0)
    end
    MDT.main_frame.LinkToChatButton:SetText(L["Share"])
    MDT.main_frame.LiveSessionButton:SetDisabled(false)
    MDT.main_frame.SendingStatusBar:Hide()
    --output chat link
    if not silent and preset then
      local prefix = "[MDT_v2: "
      local dungeon = MDT:GetDungeonName(preset.value.currentDungeonIdx)
      local presetName = preset.text
      local name, realm = UnitFullName("player")

      --UnitFullName("player") will always return a players name with a capitalised first letter, regardless of whether
      --or not that is actually the case, while UnitFullName("Nnoggie") will return the player name with case respected.
      --This causes a subtle bug for (the few) players who's name does not begin with a capital, where chat links do not
      --work, because line 243 in OnCommReceived respects the case of the name, but here in the sending code we do not.
      --As a result, the entry in MDT.transmissionCache is indexed with case respected, but read on line 225 of this file
      --without respect for case (due to us sending it here, without respect for case). The fix is to subsequently call
      --GetUnitName(name) on the name, in order to get the correct case.

      ---@diagnostic disable-next-line: param-type-mismatch
      name = UnitFullName(name)

      local fullName = name.."+"..realm
      SendChatMessage(prefix..fullName.." - "..dungeon..": "..presetName.."]", distribution)
    end
    numActiveTransmissions = numActiveTransmissions - 1
    if not fromLiveSession then MDT:RestoreThrottleValues() end
  end
end

MDT.displaySendingProgress = displaySendingProgress

function MDT:GetPresetByUid(presetUid)
  local db = MDT:GetDB()
  for _, dungeon in pairs(db.presets) do
    for _, preset in pairs(dungeon) do
      if preset.uid == presetUid then
        return preset
      end
    end
  end
end

---generates a unique random 11 digit number in base64
function MDT:GenerateUniqueID(length)
  local s = {}
  for i = 1, length do
    tinsert(s, bytetoB64[math.random(0, 63)])
  end
  return table.concat(s)
end

function MDT:SetUniqueID(preset)
  if not preset.uid then
    local newUid = MDT:GenerateUniqueID(11)
    -- collision check
    local inUse = false
    local presets = MDT:GetDB().presets
    for _, dungeon in pairs(presets) do
      for _, pres in pairs(dungeon) do
        if pres.uid and pres.uid == newUid then
          inUse = true
          break
        end
      end
    end
    if not inUse then
      preset.uid = newUid
    else
      MDT:SetUniqueID(preset)
    end
  end
end

---SendToGroup
---Send current preset to group/raid
function MDT:SendToGroup(distribution, silent, preset)
  MDT:SetThrottleValues()
  preset = preset or MDT:GetCurrentPreset()
  --set unique id
  MDT:SetUniqueID(preset)
  --gotta encode difficulty into preset
  local db = MDT:GetDB()
  preset.difficulty = db.currentDifficulty
  local export = MDT:TableToString(preset, false, 5)
  numActiveTransmissions = numActiveTransmissions + 1
  MDTcommsObject:SendCommMessage("MDTPreset", export, distribution, nil, "BULK", displaySendingProgress,
    { distribution, preset, silent })
end

---GetPresetSize
---Returns the number of characters the string version of the preset contains
function MDT:GetPresetSize(forChat, level)
  local preset = MDT:GetCurrentPreset()
  local export = MDT:TableToString(preset, forChat, level)
  return string.len(export)
end

do
  local defaultCPS = _G.ChatThrottleLib.MAX_CPS
  local defaultBurst = _G.ChatThrottleLib.BURST

  function MDT:SetThrottleValues()
    if not _G.ChatThrottleLib then return end
    --10.2 added throttle restrictions for PARTY and RAID
    --10 messages burst, 1 message per second all per prefix
    --255 characters per message
    if numActiveTransmissions ~= 0 then return end
    defaultCPS = _G.ChatThrottleLib.MAX_CPS
    defaultBurst = _G.ChatThrottleLib.BURST
    _G.ChatThrottleLib.MAX_CPS = 255
    _G.ChatThrottleLib.BURST = 2550
  end

  function MDT:RestoreThrottleValues()
    if not _G.ChatThrottleLib then return end
    if numActiveTransmissions ~= 0 then return end
    _G.ChatThrottleLib.MAX_CPS = defaultCPS
    _G.ChatThrottleLib.BURST = defaultBurst
  end
end
