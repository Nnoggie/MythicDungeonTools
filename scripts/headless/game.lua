-- Global WoW API, part 2: standard frames, pools, menus, popups, slash commands, game state, C_ namespaces.
return function(W)
  local S, usage, checkNumber = W.state, W.usage, W.checkNumber
  local G = _G

  -- Frames and widgets ---------------------------------------------------------------------

  G.CreateFrame = W.CreateFrame
  W.UIParent = W.CreateFrame("Frame", "UIParent")
  W.UIParent:SetSize(W.screenWidth, W.screenHeight)
  W.WorldFrame = W.CreateFrame("Frame", "WorldFrame")
  W.WorldFrame:SetSize(W.screenWidth, W.screenHeight)
  G.GameTooltip = W.CreateFrame("GameTooltip", "GameTooltip", W.UIParent, "GameTooltipTemplate")
  G.GameTooltip:Hide()
  G.ItemRefTooltip = W.CreateFrame("GameTooltip", "ItemRefTooltip", W.UIParent, "GameTooltipTemplate")
  G.ItemRefTooltip:Hide()
  G.EmbeddedItemTooltip = W.CreateFrame("GameTooltip", "EmbeddedItemTooltip", W.UIParent, "GameTooltipTemplate")
  G.EmbeddedItemTooltip:Hide()
  G.Minimap = W.CreateFrame("Minimap", "Minimap", W.UIParent)
  G.Minimap:SetSize(140, 140)
  G.Minimap:SetPoint("TOPRIGHT")
  G.MinimapCluster = W.CreateFrame("Frame", "MinimapCluster", W.UIParent)
  G.DEFAULT_CHAT_FRAME = W.CreateFrame("ScrollingMessageFrame", "ChatFrame1", W.UIParent)
  G.SELECTED_CHAT_FRAME = G.DEFAULT_CHAT_FRAME
  G.ChatFrame1EditBox = W.CreateFrame("EditBox", "ChatFrame1EditBox", G.DEFAULT_CHAT_FRAME)
  G.ChatFrame1EditBox:Hide()
  G.UISpecialFrames = {}
  G.ColorPickerFrame = W.CreateFrame("Frame", "ColorPickerFrame", W.UIParent)
  G.ColorPickerFrame:Hide()
  function G.ColorPickerFrame:SetupColorPickerAndShow(info) self.info = info self:Show() end
  function G.ColorPickerFrame:GetColorRGB() return 1, 1, 1 end
  function G.ColorPickerFrame:GetColorAlpha() return 1 end
  G.ColorPickerFrame.Content = { ColorPicker = { SetColorRGB = function() end, GetColorRGB = function() return 1, 1, 1 end } }
  G.OpacitySliderFrame = W.CreateFrame("Slider", "OpacitySliderFrame", G.ColorPickerFrame)
  G.AddonCompartmentFrame = W.CreateFrame("Frame", "AddonCompartmentFrame", W.UIParent)
  G.AddonCompartmentFrame.registeredAddons = {}
  function G.AddonCompartmentFrame:RegisterAddon(info) table.insert(self.registeredAddons, info) end
  function G.AddonCompartmentFrame:UpdateDisplay() end
  function G.GetScreenWidth() return W.screenWidth end
  G.PixelUtil = {
    GetPixelToUIUnitFactor = function() return 768 / W.screenHeight end,
    GetNearestPixelSize = function(uiUnitSize, layoutScale, minPixels)
      local factor = 768 / W.screenHeight
      local pixels = uiUnitSize * layoutScale / factor
      if minPixels and pixels < minPixels then pixels = minPixels end
      return math.floor(pixels + 0.5) * factor / layoutScale
    end,
    SetPoint = function(region, ...) region:SetPoint(...) end,
    SetWidth = function(region, width) region:SetWidth(width) end,
    SetHeight = function(region, height) region:SetHeight(height) end,
    SetSize = function(region, width, height) region:SetSize(width, height) end,
  }
  function G.GetScreenHeight() return W.screenHeight end
  function G.GetPhysicalScreenSize() return W.screenWidth, W.screenHeight end
  function G.GetCursorPosition() return W.cursorX or W.screenWidth / 2, W.cursorY or W.screenHeight / 2 end
  G.GetScaledCursorPosition = G.GetCursorPosition
  function G.GetMouseFocus() return W.mouseFocus end
  function G.GetMouseFoci() return { W.mouseFocus } end
  function G.IsMouseButtonDown() return W.mouseDown == true end
  G.ICON_LIST = {}
  for i = 1, 8 do
    G.ICON_LIST[i] = "|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_"..i..":"
    G["RAID_TARGET_"..i] = "Raid target "..i
  end
  function G.IsShiftKeyDown() return W.modifiers and W.modifiers.shift or false end
  function G.IsControlKeyDown() return W.modifiers and W.modifiers.ctrl or false end
  function G.IsAltKeyDown() return W.modifiers and W.modifiers.alt or false end
  function G.IsModifierKeyDown() return G.IsShiftKeyDown() or G.IsControlKeyDown() or G.IsAltKeyDown() end
  function G.IsMetaKeyDown() return false end
  function G.GetCurrentKeyBoardFocus() return nil end
  function G.CloseSpecialWindows()
    local closed = false
    for _, name in ipairs(G.UISpecialFrames) do
      local frame = G[name]
      if frame and frame:IsShown() then frame:Hide() closed = true end
    end
    return closed
  end

  function G.UIFrameFadeOut(frame, duration, from, to) frame:SetAlpha(to or 0) end
  function G.UIFrameFadeIn(frame, duration, from, to) frame:SetAlpha(to or 1) frame:Show() end
  function G.UIFrameFlash(frame) frame:Show() end
  function G.UIFrameFlashStop(frame) end
  function G.UIFrameIsFlashing() return false end
  function G.GameTooltip_SetTitle(tooltip, text) tooltip:SetText(text) end
  function G.GameTooltip_AddNormalLine(tooltip, text) tooltip:AddLine(text) end
  function G.GameTooltip_AddHighlightLine(tooltip, text) tooltip:AddLine(text) end
  function G.GameTooltip_AddColoredLine(tooltip, text) tooltip:AddLine(text) end
  function G.GameTooltip_AddBlankLineToTooltip(tooltip) tooltip:AddLine(" ") end
  function G.GameTooltip_Hide() G.GameTooltip:Hide() end
  function G.GameTooltip_SetDefaultAnchor(tooltip, parent) tooltip:SetOwner(parent, "ANCHOR_NONE") end
  function G.AddTooltipStatusLine() end
  G.TooltipDataProcessor = { AddTooltipPostCall = function() end, AddLinePreCall = function() end }
  function G.DrawLine(texture, canvas, startX, startY, endX, endY, width, factor, relativePoint)
    for _, value in ipairs({ startX, startY, endX, endY, width }) do checkNumber(value, "DrawLine", "coordinate") end
    usage(W.isRegion(texture), "DrawLine(): texture is not a region")
    usage(W.isRegion(canvas), "DrawLine(): canvas is not a region")
    relativePoint = relativePoint or "BOTTOMLEFT"
    local half = width * (factor or 1) / 2
    texture:ClearAllPoints()
    texture:SetPoint("BOTTOMLEFT", canvas, relativePoint, math.min(startX, endX) - half, math.min(startY, endY) - half)
    texture:SetPoint("TOPRIGHT", canvas, relativePoint, math.max(startX, endX) + half, math.max(startY, endY) + half)
    texture:SetTexCoord(0, 0, 0, 1, 1, 0, 1, 1)
  end
  function G.SetPortraitTextureFromCreatureDisplayID(texture, displayId) texture:SetTexture(displayId) end
  function G.SetPortraitToTexture(texture, path) texture:SetTexture(path) end
  function G.SetPortraitTexture(texture, unit) texture:SetTexture(136235) end

  function G.CreateObjectPool(creator, resetter)
    local pool = { active = {}, inactive = {}, creator = creator, resetter = resetter }
    function pool:Acquire()
      local object = table.remove(self.inactive)
      local isNew = object == nil
      if isNew then object = self.creator(self) end
      self.active[object] = true
      return object, isNew
    end
    function pool:Release(object)
      if not self.active[object] then return false end
      self.active[object] = nil
      if self.resetter then self.resetter(self, object) end
      table.insert(self.inactive, object)
      return true
    end
    function pool:ReleaseAll()
      for object in pairs(self.active) do self:Release(object) end
    end
    function pool:EnumerateActive() return pairs(self.active) end
    function pool:GetNextActive(current) return (next(self.active, current)) end
    function pool:IsActive(object) return self.active[object] == true end
    function pool:GetNumActive()
      local count = 0
      for _ in pairs(self.active) do count = count + 1 end
      return count
    end
    return pool
  end
  local function hideAndClear(_, object)
    object:Hide()
    object:ClearAllPoints()
  end
  function G.CreateFramePool(frameType, parent, template, resetter, forbidden, initializer)
    return G.CreateObjectPool(function()
      local frame = W.CreateFrame(frameType, nil, parent, template)
      if initializer then initializer(frame) end
      return frame
    end, resetter or hideAndClear)
  end
  function G.CreateTexturePool(parent, layer, sublevel, template, resetter)
    return G.CreateObjectPool(function() return parent:CreateTexture(nil, layer, template, sublevel) end, resetter or hideAndClear)
  end
  function G.CreateFontStringPool(parent, layer, sublevel, template, resetter)
    return G.CreateObjectPool(function() return parent:CreateFontString(nil, layer, template) end, resetter or hideAndClear)
  end
  G.CreateUnsecuredObjectPool = G.CreateObjectPool
  G.CreateUnsecuredFramePool = G.CreateFramePool
  G.Pool_HideAndClearAnchors = hideAndClear

  -- Menus ----------------------------------------------------------------------------------

  W.menus = {}
  local function newDescription(kind, text)
    local description = { kind = kind, text = text, children = {} }
    local function add(childKind)
      return function(self, childText, ...)
        local childDescription = newDescription(childKind, childText)
        childDescription.args = { ... }
        table.insert(self.children, childDescription)
        return childDescription
      end
    end
    for _, name in ipairs({ "CreateButton", "CreateCheckbox", "CreateRadio", "CreateTitle", "CreateDivider", "CreateSpacer", "CreateColorSwatch", "CreateTemplate", "CreateFrame" }) do
      description[name] = add(name:sub(7))
    end
    for _, name in ipairs({
      "SetTag", "SetTooltip", "SetEnabled", "SetScrollMode", "SetGridMode", "SetMinimumWidth", "AddInitializer",
      "SetResponder", "SetResponse", "SetIsSelected", "SetSelectionIgnored", "SetCanSelect", "SetShouldRespondIfSubmenu",
      "SetRadio", "SetTitleAndTextTooltip", "SetOnEnter", "SetOnLeave", "SetData", "SetFinalInitializer",
      "SetElementFactory", "DeactivateSubmenu", "SetSelectionTranslator", "QueueSpacer", "QueueDivider", "QueueTitle",
      "ClearQueuedDescriptions",
    }) do
      description[name] = function() end
    end
    function description:Insert(child) table.insert(self.children, child) return child end
    return description
  end
  G.MenuUtil = {
    CreateContextMenu = function(owner, generator, ...)
      local root = newDescription("Root")
      generator(owner, root, ...)
      table.insert(W.menus, { owner = owner, root = root })
      return { Close = function() end }
    end,
    CreateButtonMenu = function() return { Close = function() end } end,
    CreateButtonContextMenu = function() return { Close = function() end } end,
    ShowTooltip = function() end, HideTooltip = function() end,
    SetElementText = function() end, GetElementText = function() end,
  }
  G.MenuResponse = { Open = 1, Refresh = 2, Close = 3, CloseAll = 4 }
  G.Menu = { GetManager = function() return { CloseMenus = function() end, IsAnyMenuOpen = function() return false end } end, ModifyMenu = function() end }

  G.UIDROPDOWNMENU_MENU_LEVEL, G.UIDROPDOWNMENU_MENU_VALUE = 1, nil
  function G.UIDropDownMenu_Initialize(frame, initializer, displayMode, level, menuList)
    frame.initialize = initializer
    frame.displayMode = displayMode
  end
  function G.UIDropDownMenu_CreateInfo() return {} end
  function G.UIDropDownMenu_AddButton() end
  function G.UIDropDownMenu_AddSeparator() end
  function G.UIDropDownMenu_SetWidth() end
  function G.UIDropDownMenu_SetText(frame, text) frame.selectedText = text end
  function G.UIDropDownMenu_SetSelectedValue(frame, value) frame.selectedValue = value end
  function G.UIDropDownMenu_GetSelectedValue(frame) return frame.selectedValue end
  function G.UIDropDownMenu_JustifyText() end
  function G.UIDropDownMenu_EnableDropDown() end
  function G.UIDropDownMenu_DisableDropDown() end
  function G.ToggleDropDownMenu(level, value, frame)
    if frame and frame.initialize then W.protectedCall(frame.initialize, frame, level or 1, nil) end
  end
  function G.CloseDropDownMenus() end
  function G.EasyMenu() end
  G.DropDownList1 = W.CreateFrame("Frame", "DropDownList1", W.UIParent)
  G.DropDownList1:Hide()

  -- Popups ---------------------------------------------------------------------------------

  G.StaticPopupDialogs = {}
  function G.StaticPopup_Show(which, text1, text2, data)
    usage(G.StaticPopupDialogs[which], 'StaticPopup_Show(): unknown dialog "'..tostring(which)..'"')
    W.popups[#W.popups + 1] = which
    local popup = W.CreateFrame("Frame", nil, W.UIParent)
    popup.which, popup.data = which, data
    return popup
  end
  function G.StaticPopup_Hide() end
  function G.StaticPopup_Visible() return nil end
  function G.StaticPopup_FindVisible() return nil end
  G.OKAY, G.CANCEL, G.YES, G.NO, G.ACCEPT, G.CLOSE, G.DELETE, G.NONE = "Okay", "Cancel", "Yes", "No", "Accept", "Close", "Delete", "None"
  G.SAVE, G.DEFAULT, G.RESET, G.ENABLE, G.DISABLE, G.SETTINGS = "Save", "Default", "Reset", "Enable", "Disable", "Settings"
  G.SOUNDKIT = setmetatable({}, { __index = function(_, key) return 1 end })
  function G.PlaySound() return true, 1 end
  function G.PlaySoundFile() return true, 1 end
  function G.StopSound() end
  function G.MuteSoundFile() end
  function G.UnmuteSoundFile() end

  -- Slash commands and chat ----------------------------------------------------------------

  G.SlashCmdList = {}
  G.hash_SlashCmdList = {}
  function W.RunSlashCommand(line)
    local command, rest = line:match("^(%S+)%s*(.*)$")
    command = command:lower()
    for key, handler in pairs(G.SlashCmdList) do
      local index = 1
      while G["SLASH_"..key..index] do
        if G["SLASH_"..key..index]:lower() == command then
          W.protectedCall(handler, rest, G.ChatFrame1EditBox)
          return true
        end
        index = index + 1
      end
    end
    error("unknown slash command "..command)
  end
  local filters = {}
  function G.ChatFrame_AddMessageEventFilter(event, filter)
    filters[event] = filters[event] or {}
    table.insert(filters[event], filter)
  end
  function G.ChatFrame_RemoveMessageEventFilter() end
  G.ChatFrameUtil = { AddMessageEventFilter = G.ChatFrame_AddMessageEventFilter }
  function G.ChatEdit_ChooseBoxForSend() return G.ChatFrame1EditBox end
  function G.ChatEdit_ActivateChat(editBox) editBox:Show() end
  function G.ChatEdit_DeactivateChat(editBox) editBox:Hide() end
  function G.ChatEdit_SendText() end
  function G.ChatEdit_OnEnterPressed() end
  function G.ChatEdit_InsertLink() return false end
  G.ChatFrameUtil.ChooseBoxForSend = G.ChatEdit_ChooseBoxForSend
  function G.SetItemRef() end
  function G.BNSendGameData() end
  function G.BNSendWhisper() end
  function G.BNGetNumFriends() return 0, 0 end
  function G.SendChatMessage(message, chatType) table.insert(W.chatMessages, { message = message, chatType = chatType }) end

  -- Game state -----------------------------------------------------------------------------

  function G.GetBuildInfo() return "12.1.5", "65000", "Oct 1 2026", 120105 end
  function G.GetLocale() return "enUS" end
  function G.GetCurrentRegion() return 3 end
  function G.GetCurrentRegionName() return "EU" end
  function G.IsTestBuild() return false end
  function G.IsPublicBuild() return true end
  G.WOW_PROJECT_ID, G.WOW_PROJECT_MAINLINE, G.WOW_PROJECT_CLASSIC = 1, 1, 2
  G.LE_EXPANSION_LEVEL_CURRENT = 11
  function G.InCombatLockdown() return W.inCombat == true end
  function G.UnitAffectingCombat() return W.inCombat == true end
  function G.IsInInstance() return false, "none" end
  function G.GetInstanceInfo() return "Dornogal", "none", 0, "", 5, 0, false, 2552, 0 end
  function G.IsInGroup() return false end
  function G.IsInRaid() return false end
  function G.UnitInRaid() return nil end
  function G.UnitInParty() return false end
  function G.GetNumGroupMembers() return 0 end
  function G.GetNumSubgroupMembers() return 0 end
  function G.GetRaidRosterInfo() return nil end
  function G.UnitIsGroupLeader() return false end
  function G.UnitIsGroupAssistant() return false end
  function G.UnitExists(unit) return unit == "player" end
  function G.UnitIsUnit(a, b) return a == b end
  function G.UnitName(unit) if unit == "player" then return "Headless", nil end end
  function G.UnitFullName(unit) if unit == "player" then return "Headless", "Testrealm" end end
  function G.GetUnitName(unit) return G.UnitName(unit) end
  function G.UnitNameUnmodified(unit) return G.UnitName(unit) end
  function G.GetRealmName() return "Testrealm" end
  function G.GetNormalizedRealmName() return "Testrealm" end
  function G.UnitClass(unit) if unit == "player" then return "Mage", "MAGE", 8 end end
  function G.UnitClassBase(unit) return "MAGE", 8 end
  function G.UnitRace() return "Human", "Human", 1 end
  function G.UnitFactionGroup() return "Alliance", "Alliance" end
  function G.UnitLevel() return 90 end
  function G.UnitGUID(unit) if unit == "player" then return "Player-1-00000001" end end
  function G.UnitHealth() return 100 end
  function G.UnitHealthMax() return 100 end
  function G.UnitCreatureType() return nil end
  function G.UnitIsDead() return false end
  function G.UnitIsPlayer(unit) return unit == "player" end
  function G.UnitIsConnected() return true end
  function G.UnitGroupRolesAssigned() return "NONE" end
  function G.GetSpecialization() return 1 end
  function G.GetSpecializationInfo() return 62, "Arcane", "", 135932, "DAMAGER" end
  function G.GetRaidTargetIndex() return nil end
  function G.SetRaidTarget() end
  function G.GetSubZoneText() return "" end
  function G.GetZoneText() return "Dornogal" end
  function G.GetRealZoneText() return "Dornogal" end
  function G.ResetInstances() end
  function G.ReloadUI() W.reloadRequested = true end
  function G.Logout() end
  function G.GetGuildInfo() return nil end
  function G.BNGetInfo() return nil end
  function G.IsInGuild() return false end
  function G.GetNetStats() return 0, 0, 20, 20 end
  function G.LoggingCombat(enabled) if enabled ~= nil then W.combatLogging = enabled end return W.combatLogging == true end
  function G.GetDifficultyInfo() return "Normal", "party", false, false end
  function G.GetCVar() return nil end
  function G.GetCVarBool() return false end
  function G.SetCVar() return true end
  G.C_CVar = { GetCVar = G.GetCVar, GetCVarBool = G.GetCVarBool, SetCVar = G.SetCVar, RegisterCVar = function() end }
  function G.GetBindingKey() return nil end
  function G.SetBinding() return true end
  function G.SetBindingClick() return true end
  function G.SaveBindings() end
  function G.GetCurrentBindingSet() return 1 end
  function G.KeyBindingFrame_LoadUI() end
  local macros = {}
  function G.GetNumMacros() return #macros, 0 end
  function G.GetMacroIndexByName(name)
    for index, macro in ipairs(macros) do if macro.name == name then return index end end
    return 0
  end
  function G.CreateMacro(name, icon, body)
    table.insert(macros, { name = name, icon = icon, body = body })
    return #macros
  end
  function G.EditMacro(index, name, icon, body)
    if macros[index] then macros[index] = { name = name or macros[index].name, icon = icon, body = body } end
    return index
  end
  function G.GetMacroInfo(index) local macro = macros[index] if macro then return macro.name, macro.icon, macro.body end end
  function G.PickupMacro() end
  function G.ClearCursor() end
  function G.GetCursorInfo() return nil end
  function G.EJ_GetCreatureInfo() return nil end
  function G.EJ_GetInstanceForMap() return 0 end
  function G.EJ_SelectInstance() end
  function G.EJ_GetEncounterInfoByIndex() return nil end
  function G.EncounterJournal_OpenJournal() end
  function G.EncounterJournal_LoadUI() end
  function G.ShowUIPanel(frame) if frame then frame:Show() end end
  function G.HideUIPanel(frame) if frame then frame:Hide() end end
  function G.HandleModifiedItemClick() return false end
  function G.IsModifiedClick() return false end
  function G.GetAddOnMetadata(...) return G.C_AddOns.GetAddOnMetadata(...) end

  G.Enum = setmetatable({
    CompressionMethod = { Deflate = 0, Zlib = 1 },
    TooltipDataType = { Item = 0, Spell = 1, Unit = 2 },
    UIMapType = { Cosmic = 0, World = 1, Continent = 2, Zone = 3, Dungeon = 4, Micro = 5, Orphan = 6 },
    ChatChannelType = { None = 0 },
    SendAddonMessageResult = { Success = 0 },
    AddOnRestrictionType = { Map = 0, Chat = 1, Combat = 2, Encounter = 3, ChallengeMode = 4, PvPMatch = 5 },
  }, { __index = function(_, key)
    local name = "Enum."..tostring(key)
    if not W.undefinedGlobals[name] then
      W.undefinedGlobals[name] = { name = name, count = 0, site = W.callSite() }
      W.undefinedGlobalOrder[#W.undefinedGlobalOrder + 1] = name
    end
    W.undefinedGlobals[name].count = W.undefinedGlobals[name].count + 1
  end })
  G.C_RestrictedActions = { IsAddOnRestrictionActive = function() return false end }

  G.C_Map = {
    GetBestMapForUnit = function() return 2339 end,
    GetMapInfo = function(mapID)
      if not mapID then return nil end
      return { mapID = mapID, name = "Dornogal", mapType = 3, parentMapID = 2274 }
    end,
    GetAreaInfo = function(areaID) return "Area "..tostring(areaID) end,
    GetPlayerMapPosition = function() return nil end,
    GetMapGroupID = function() return nil end,
    GetMapGroupMembersInfo = function() return {} end,
  }

  local spellCache = {}
  local function spellInfo(spellID)
    spellID = tonumber(spellID)
    if not spellID then return nil end
    if not spellCache[spellID] then
      spellCache[spellID] = { name = "Spell "..spellID, iconID = 136243, originalIconID = 136243, spellID = spellID, castTime = 0, minRange = 0, maxRange = 0 }
    end
    return spellCache[spellID]
  end
  G.C_Spell = {
    GetSpellInfo = spellInfo,
    GetSpellName = function(spellID) local info = spellInfo(spellID) return info and info.name end,
    GetSpellTexture = function(spellID) local info = spellInfo(spellID) return info and info.iconID, info and info.originalIconID end,
    GetSpellLink = function(spellID) return "|cff71d5ff|Hspell:"..tostring(spellID)..":0|h[Spell "..tostring(spellID).."]|h|r" end,
    GetSpellDescription = function(spellID) return "Description of spell "..tostring(spellID) end,
    DoesSpellExist = function(spellID) return tonumber(spellID) ~= nil end,
    IsSpellDataCached = function() return true end,
    RequestLoadSpellData = function() end,
    GetSpellCooldown = function() return { startTime = 0, duration = 0, isEnabled = true, modRate = 1 } end,
    IsSpellKnown = function() return false end,
  }
  G.C_Item = {
    GetItemInfo = function() return nil end,
    GetItemIconByID = function() return 134400 end,
    RequestLoadItemDataByID = function() end,
  }
  G.C_ChallengeMode = {
    IsChallengeModeActive = function() return false end,
    GetMapUIInfo = function(mapID) return "Challenge "..tostring(mapID), mapID, 1800, 525134, 525134 end,
    GetActiveKeystoneInfo = function() return 0, {}, false end,
    GetActiveChallengeMapID = function() return nil end,
    GetMapTable = function() return {} end,
    GetAffixInfo = function(affixID) return "Affix "..tostring(affixID), "", 463829 end,
  }
  G.C_MythicPlus = {
    GetCurrentAffixes = function() return {} end,
    GetOwnedKeystoneChallengeMapID = function() return nil end,
    GetOwnedKeystoneLevel = function() return nil end,
    RequestMapInfo = function() end,
    RequestCurrentAffixes = function() end,
  }
  G.C_ScenarioInfo = { GetUnitCriteriaProgressValues = function() return nil end, GetCriteriaInfo = function() return nil end }
  G.C_ChatInfo = {
    SendChatMessage = function(message, chatType) table.insert(W.chatMessages, { message = message, chatType = chatType }) end,
    SendAddonMessage = function() return true end,
    SendAddonMessageLogged = function() return true end,
    RegisterAddonMessagePrefix = function() return true end,
    IsAddonMessagePrefixRegistered = function() return true end,
    InChatMessagingLockdown = function() return false end,
    GetNumActiveChannels = function() return 0 end,
  }
  G.C_Texture = {
    GetAtlasInfo = function(atlas)
      return {
        width = 16, height = 16, rawSize = { x = 16, y = 16 }, leftTexCoord = 0, rightTexCoord = 1, topTexCoord = 0,
        bottomTexCoord = 1, file = 0, filename = atlas, tilesHorizontally = false, tilesVertically = false,
      }
    end,
    GetFilenameFromFileDataID = function() return nil end,
  }
  G.C_PartyInfo = { IsPartyFull = function() return false end, GetMinLevel = function() return 1 end }
  G.C_GuildInfo = { IsGuildOfficer = function() return false end }
  G.C_BattleNet = { GetAccountInfoByGUID = function() return nil end }
  G.C_FriendList = { IsFriend = function() return false end }
  G.C_Calendar = { GetDate = function() return { year = 2026, month = 10, monthDay = 20, weekday = 3, hour = 12, minute = 0 } end }
  G.C_DateAndTime = { GetCurrentCalendarTime = G.C_Calendar.GetDate, GetServerTimeLocal = os.time }
  G.C_UnitAuras = { GetAuraDataByIndex = function() return nil end, GetPlayerAuraBySpellID = function() return nil end }
  G.C_StorePublic = { IsDisabledByParentalControls = function() return false end }
  G.C_LFGList = { GetActiveEntryInfo = function() return nil end, HasActiveEntryInfo = function() return false end }
  G.C_PlayerInfo = { GetPlayerMythicPlusRatingSummary = function() return { currentSeasonScore = 0, runs = {} } end }
  G.C_Club = { GetSubscribedClubs = function() return {} end }
  G.C_KeyBindings = { GetCustomBindingType = function() return nil end }
  G.C_UI = { Reload = G.ReloadUI }
  G.C_Navigation = { GetDistance = function() return 0 end }

  -- Lua-literal serializer shared by C_EncodingUtil (a faithful round trip, so import and export run end to
  -- end) and the SavedVariables writer, which skips functions like the client does.
  local function serialize(value, context, skipFunctions, seen, out)
    local kind = type(value)
    if kind == "string" then
      out[#out + 1] = string.format("%q", value)
    elseif kind == "number" then
      if value ~= value then out[#out + 1] = "0/0"
      elseif value == math.huge then out[#out + 1] = "1/0"
      elseif value == -math.huge then out[#out + 1] = "-1/0"
      else out[#out + 1] = string.format("%.17g", value) end
    elseif kind == "boolean" then
      out[#out + 1] = tostring(value)
    elseif kind == "table" then
      if seen[value] then error(context..": table contains a cycle", 0) end
      if S[value] then error(context..": refusing to serialize a widget ("..S[value].class.name..")", 0) end
      seen[value] = true
      local keys = {}
      for key, entry in pairs(value) do
        if not (skipFunctions and type(entry) == "function") then keys[#keys + 1] = key end
      end
      table.sort(keys, function(a, b)
        if type(a) == type(b) and (type(a) == "number" or type(a) == "string") then return a < b end
        return type(a) < type(b)
      end)
      out[#out + 1] = "{"
      for _, key in ipairs(keys) do
        out[#out + 1] = "["
        serialize(key, context, skipFunctions, seen, out)
        out[#out + 1] = "]="
        serialize(value[key], context, skipFunctions, seen, out)
        out[#out + 1] = ","
      end
      out[#out + 1] = "}"
      seen[value] = nil
    elseif kind == "nil" then
      out[#out + 1] = "nil"
    else
      error(context..": cannot serialize a "..kind, 0)
    end
  end

  function W.serialize(value, context, skipFunctions)
    local out = {}
    serialize(value, context, skipFunctions, {}, out)
    return table.concat(out)
  end

  local alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
  local function encodeBase64(data)
    local out = {}
    for index = 1, #data, 3 do
      local a, b, c = data:byte(index, index + 2)
      local n = a * 65536 + (b or 0) * 256 + (c or 0)
      local chars = {}
      for slot = 4, 1, -1 do
        chars[slot] = n % 64 + 1
        n = math.floor(n / 64)
      end
      out[#out + 1] = alphabet:sub(chars[1], chars[1])..alphabet:sub(chars[2], chars[2])
        ..(b and alphabet:sub(chars[3], chars[3]) or "=")..(c and alphabet:sub(chars[4], chars[4]) or "=")
    end
    return table.concat(out)
  end
  local decodeMap = {}
  for index = 1, #alphabet do decodeMap[alphabet:sub(index, index)] = index - 1 end
  local function decodeBase64(text)
    text = text:gsub("[^%w%+/=]", "")
    local out = {}
    for index = 1, #text, 4 do
      local chunk = text:sub(index, index + 3)
      local n, padding = 0, 0
      for slot = 1, 4 do
        local char = chunk:sub(slot, slot)
        if char == "=" or char == "" then padding = padding + 1 n = n * 64 else
          local value = decodeMap[char]
          if not value then return nil end
          n = n * 64 + value
        end
      end
      local bytes = string.char(math.floor(n / 65536) % 256, math.floor(n / 256) % 256, n % 256)
      out[#out + 1] = bytes:sub(1, 3 - padding)
    end
    return table.concat(out)
  end
  G.C_EncodingUtil = {
    SerializeCBOR = function(value) return "LUA:"..W.serialize(value, "C_EncodingUtil.SerializeCBOR()") end,
    DeserializeCBOR = function(text)
      if type(text) ~= "string" or text:sub(1, 4) ~= "LUA:" then W.raise("C_EncodingUtil.DeserializeCBOR(): invalid data") end
      local chunk = loadstring("return "..text:sub(5))
      if not chunk then W.raise("C_EncodingUtil.DeserializeCBOR(): invalid data") end
      setfenv(chunk, {})
      return chunk()
    end,
    CompressString = function(text) return "Z"..text end,
    DecompressString = function(text)
      if type(text) ~= "string" or text:sub(1, 1) ~= "Z" then W.raise("C_EncodingUtil.DecompressString(): invalid data") end
      return text:sub(2)
    end,
    EncodeBase64 = encodeBase64,
    DecodeBase64 = decodeBase64,
    SerializeJSON = function() return "{}" end,
    DeserializeJSON = function() return {} end,
    EncodeHex = function(text) return (text:gsub(".", function(c) return ("%02x"):format(c:byte()) end)) end,
  }

  -- Undefined global reads are recorded but return nil, so feature detection keeps working.
  setmetatable(G, {
    __index = function(_, key)
      if type(key) ~= "string" then return nil end
      local entry = W.undefinedGlobals[key]
      if not entry then
        entry = { name = key, count = 0, site = W.callSite() }
        W.undefinedGlobals[key] = entry
        W.undefinedGlobalOrder[#W.undefinedGlobalOrder + 1] = key
      end
      entry.count = entry.count + 1
      return nil
    end,
  })
end
