local _, MDT = ...
local L = MDT.L
local LegacyCompressor = LibStub:GetLibrary("LibCompress")
local LegacySerializer = LibStub:GetLibrary("AceSerializer-3.0")
local LegacyDeflate = LibStub:GetLibrary("LibDeflate")
local MDTcommsObject = MDT.commsObject
local presetCommPrefix = MDT.presetCommPrefix

-- Lua APIs
local tremove = table.remove
local pairs, type, unpack = pairs, type, unpack

local uidCharacters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789()"

-- "~" cannot start either legacy LibDeflate encoding, so this marker cannot collide with existing exports.
local encodingPrefix = "!~MDT2~"

function MDT:TableToString(inTable)
  local serialized = C_EncodingUtil.SerializeCBOR(inTable)
  local compressed = C_EncodingUtil.CompressString(serialized, Enum.CompressionMethod.Deflate)
  local encoded = C_EncodingUtil.EncodeBase64(compressed)
  return encodingPrefix..encoded
end

function MDT:StringToTable(inString, fromChat)
  if inString:sub(1, #encodingPrefix) == encodingPrefix then
    local decoded = C_EncodingUtil.DecodeBase64(inString:sub(#encodingPrefix + 1))
    if not decoded then return "Error decoding." end
    local decompressed = C_EncodingUtil.DecompressString(decoded, Enum.CompressionMethod.Deflate)
    if not decompressed then return "Error decompressing." end
    return C_EncodingUtil.DeserializeCBOR(decompressed) or "Error deserializing."
  end

  -- Legacy "!" exports use LibDeflate; strings without the marker use LibCompress.
  local encoded, usesDeflate = inString:gsub("^%!", "")
  local decoded
  if (fromChat) then
    decoded = LegacyDeflate:DecodeForPrint(encoded)
  else
    decoded = LegacyDeflate:DecodeForWoWAddonChannel(encoded)
  end

  if not decoded then
    return "Error decoding."
  end

  local decompressed, errorMsg = nil, "unknown compression method"
  if usesDeflate == 1 then
    decompressed = LegacyDeflate:DecompressDeflate(decoded)
  else
    decompressed, errorMsg = LegacyCompressor:Decompress(decoded)
  end
  if not (decompressed) then
    return "Error decompressing: "..errorMsg
  end

  local success, deserialized = LegacySerializer:Deserialize(decompressed)
  if not (success) then
    return "Error deserializing "..deserialized
  end
  return deserialized
end

MDT.transmissionCache = {}

local function showMapSectionIfNeeded()
  if MDT.IsMapSectionActive and MDT.SetCurrentSection and not MDT:IsMapSectionActive() then
    MDT:SetCurrentSection("maps")
  end
end

function MDT:HandleChatLink(link, text)
  if (link and link:sub(0, 19) == "garrmission:mdtlive") then
    local sender = link:sub(21, string.len(link))
    local name, realm = string.match(sender, "(.*)+(.*)")
    sender = name.."-"..realm
    --ignore importing the live preset when sender is player, open MDT only
    local playerName, playerRealm = UnitFullName("player")
    playerName = playerName.."-"..playerRealm
    if sender == playerName then
      MDT:Async(function()
        showMapSectionIfNeeded()
        MDT:ShowInterfaceInternal(true)
      end, "showInterface")
    else
      MDT:Async(function()
        showMapSectionIfNeeded()
        MDT:ShowInterfaceInternal(true)
        MDT:LiveSession_Enable()
      end, "showInterfaceLive")
    end
    return
  elseif (link and link:sub(0, 15) == "garrmission:mdt") then
    local sender = link:sub(17, string.len(link))
    local name, realm = string.match(sender, "(.*)+(.*)")
    if (not name) or (not realm) then
      local msg = "\nsender: "..sender
      local escapedText = text:gsub("|", "||")
      msg = msg.."\nfull text: "..escapedText
      local cache = MDT.U.TableToString(MDT.transmissionCache)
      MDT:OnError(msg, cache, "MDT failed to import preset from chat link")
      return
    end
    -- to get the displayName (name of the preset) we need to get everything between the starting and closing brackets
    local displayName = text:match("%[(.-)%]")
    sender = name.."-"..realm
    local preset = MDT.transmissionCache[sender] and MDT.transmissionCache[sender][displayName]
    if preset and type(preset) == "table" then
      MDT:Async(function()
        showMapSectionIfNeeded()
        MDT:ShowInterfaceInternal(true)
        MDT:ImportPreset(CopyTable(preset))
      end, "showInterfaceChatImport")
    elseif preset == 0 then --special marker for old dungeon preset
      local msg = L["WARNING_OLD_DUNGEON_IMPORT"]
      print("|cFFFF0000MDT:|r "..msg)
    else
      local msg = "\nparsed displayName: "..displayName
      msg = msg.."\nsender: "..sender
      local escapedText = text:gsub("|", "||")
      msg = msg.."\nfull text: "..escapedText
      local cache = MDT.U.TableToString(MDT.transmissionCache)
      MDT:OnError(msg, cache, "MDT failed to import preset from chat link")
    end
    return
  end
end

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

  if prefix == MDT.versionCheckPrefix then
    if MDT.VersionCheck_OnCommReceived then
      MDT:VersionCheck_OnCommReceived(message, distribution, fullName)
    end
    return
  end

  --standard preset transmission
  --we cache the preset here already
  --the user still decides if he wants to click the chat link and add the preset to his db
  if prefix == presetCommPrefix then
    local preset = MDT:StringToTable(message, false)
    if not MDT:ValidateImportPreset(preset, true) then return end
    local presetName = preset.text
    local dungeon = MDT:GetDungeonName(preset.value.currentDungeonIdx, true)
    if not dungeon then
      -- check if it's dungeon that has been in MDT before but is not in the current version
      local knownDungeon = MDT.knownDungeons[preset.value.currentDungeonIdx]
      if knownDungeon then
        local displayName = knownDungeon..": "..presetName
        MDT.transmissionCache[fullName] = MDT.transmissionCache[fullName] or {}
        MDT.transmissionCache[fullName][displayName] = 0 --special marker for old dungeon preset
      end
      return
    end
    local displayName = dungeon..": "..presetName
    MDT.transmissionCache[fullName] = MDT.transmissionCache[fullName] or {}
    MDT.transmissionCache[fullName][displayName] = preset
    --live session preset
    if MDT.liveSessionActive and MDT.liveSessionAcceptingPreset and preset.uid == MDT.livePresetUID then
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
        MDT:UpdateProgressbar()
      end
    end
  end

  --difficulty
  if prefix == MDT.liveSessionPrefixes.difficulty then
    if MDT.liveSessionActive then
      local db = MDT:GetDB()
      local difficulty = tonumber(message)
      if difficulty and difficulty ~= db.currentDifficulty then
        db.currentDifficulty = difficulty
        MDT.main_frame.sidePanel.DifficultySlider:SetValue(difficulty)
        MDT:UpdateProgressbar()
        if MDT.EnemyInfoFrame and MDT.EnemyInfoFrame.frame:IsShown() then MDT:UpdateEnemyInfoData() end
        MDT:ReloadPullButtons()
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

  if prefix == MDT.liveSessionPrefixes.focusMarkerAssignment then
    if MDT.FocusMarker_OnCommReceived then
      MDT:FocusMarker_OnCommReceived(message, fullName)
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
      local dungeon = MDT:GetDungeonName(preset.value.currentDungeonIdx, true)
      local displayName = dungeon..": "..preset.text
      MDT.transmissionCache[fullName] = MDT.transmissionCache[fullName] or {}
      MDT.transmissionCache[fullName][displayName] = preset
      if MDT:ValidateImportPreset(preset) then
        MDT.livePresetUID = preset.uid
        MDT:ImportPreset(preset, true)
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
end

--callback for SendCommMessage
local function displaySendingProgress(userArgs, bytesSent, bytesToSend, didSend)
  MDT.main_frame.SendingStatusBar:Show()
  MDT.main_frame.SendingStatusBar:SetValue(bytesSent / bytesToSend)
  MDT.main_frame.SendingStatusBar.value:SetText(string.format(L["Sending: %.1f"], bytesSent / bytesToSend * 100).."%")
  --done sending
  if bytesSent == bytesToSend then
    local distribution = userArgs[1]
    local preset = userArgs[2]
    local silent = userArgs[3]
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
    if didSend ~= false and not silent and preset then
      local prefix = "[MDT_v2: "
      local dungeon = MDT:GetDungeonName(preset.value.currentDungeonIdx, true)
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
      local message = prefix..fullName.." - "..dungeon..": "..presetName.."]"
      -- ponytail: delivery gap; add receiver acknowledgements if cross-client ordering still races.
      C_Timer.After(0.5, function() C_ChatInfo.SendChatMessage(message, distribution) end)
    end
  end
end

MDT.displaySendingProgress = displaySendingProgress

---generates a unique random 11 digit number in base64
function MDT:GenerateUniqueID(length)
  local s = {}
  for i = 1, length do
    local index = math.random(1, #uidCharacters)
    s[i] = uidCharacters:sub(index, index)
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
  preset = preset or MDT:GetCurrentPreset()
  --set unique id
  MDT:SetUniqueID(preset)
  MDT:EnsurePresetCreatedBy(preset)
  --gotta encode difficulty into preset
  local db = MDT:GetDB()
  preset.difficulty = db.currentDifficulty
  local export = MDT:TableToString(preset)
  MDTcommsObject:SendCommMessage("MDTPreset", export, distribution, nil, "BULK", displaySendingProgress,
    { distribution, preset, silent })
end
