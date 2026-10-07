local _, MDT = ...
local L = MDT.L

local tinsert, pairs, ipairs, tonumber, type, floor, min, max, unpack, CreateFrame, GameTooltip =
    table.insert, pairs, ipairs, tonumber, type, math.floor, math.min, math.max, unpack, CreateFrame, GameTooltip

---Inline icon tags for map texts, e.g. {spell:2825} or {rt8}
---texts store the tags, they are turned into texture markup when the text is drawn

local QUESTION_MARK_ICON = 134400
local RAID_TARGET_TEXTURE = "Interface\\TargetingFrame\\UI-RaidTargetingIcon_"
--square class icons, zoomed like spell icons
local CLASS_ICON_PATH = "Interface\\Icons\\ClassIcon_"
--modern role icons, the first atlas the client knows is used
local ROLE_ATLASES = {
  tank = { "groupfinder-icon-role-large-tank", "roleicon-tiny-tank" },
  healer = { "groupfinder-icon-role-large-heal", "roleicon-tiny-healer" },
  dps = { "groupfinder-icon-role-large-dps", "roleicon-tiny-dps" },
}
--fallback when none of the atlases exist
local ROLE_ICON_TEXTURE = "Interface\\LFGFrame\\UI-LFG-ICON-PORTRAITROLES"
--left, right, top, bottom in pixels of the 64x64 role texture
local ROLE_COORDS = {
  tank = { 0, 19, 22, 41 },
  healer = { 20, 39, 1, 20 },
  dps = { 20, 39, 22, 41 },
}
local ROLE_ORDER = { "tank", "healer", "dps" }
local MARKER_NAMES = { "star", "circle", "diamond", "triangle", "moon", "square", "cross", "skull" }
local MARKER_ALIASES = { x = 7 }
local CLASS_TOKENS = { "DEATHKNIGHT", "DEMONHUNTER", "DRUID", "EVOKER", "HUNTER", "MAGE", "MONK", "PALADIN", "PRIEST",
  "ROGUE", "SHAMAN", "WARLOCK", "WARRIOR" }
--class tags use the class name like Method Raid Tools notes, english names work in every client language
local ENGLISH_CLASS_NAMES = {
  DEATHKNIGHT = "Death Knight",
  DEMONHUNTER = "Demon Hunter",
  DRUID = "Druid",
  EVOKER = "Evoker",
  HUNTER = "Hunter",
  MAGE = "Mage",
  MONK = "Monk",
  PALADIN = "Paladin",
  PRIEST = "Priest",
  ROGUE = "Rogue",
  SHAMAN = "Shaman",
  WARLOCK = "Warlock",
  WARRIOR = "Warrior",
}

---Icon cache
---spell icons are kept in the saved variables so tags still render where the spell api is restricted
local sessionIcons = {}
local pendingSpells = {}
local spellLoadFrame

local function isUsableValue(value)
  return value ~= nil and not (issecretvalue and issecretvalue(value))
end

local function getSavedIcons()
  local db = MDT:GetDB()
  local build = select(2, GetBuildInfo())
  local cache = db.presetTextIconCache
  --patches can change icons, start over with a new build
  if type(cache) ~= "table" or cache.build ~= build then
    cache = { build = build, icons = {} }
    db.presetTextIconCache = cache
  end
  return cache.icons
end

local function onSpellDataLoaded(_, _, spellId, success)
  if not pendingSpells[spellId] then return end
  pendingSpells[spellId] = nil
  if not success then return end
  sessionIcons[spellId] = nil
  --redraw once for all spells loaded in the same moment
  if spellLoadFrame.redrawQueued then return end
  spellLoadFrame.redrawQueued = true
  C_Timer.After(0.1, function()
    spellLoadFrame.redrawQueued = nil
    if MDT.main_frame and MDT.main_frame:IsShown() then MDT:DrawAllPresetObjects() end
    if MDT.RefreshPresetTextIconPicker then MDT:RefreshPresetTextIconPicker() end
  end)
end

local requestedSpells = {}
local function requestSpellData(spellId)
  --request each spell once per session, a spell that loads without an icon would otherwise
  --keep requesting and redrawing forever
  if requestedSpells[spellId] then return end
  requestedSpells[spellId] = true
  if C_Spell.DoesSpellExist and not C_Spell.DoesSpellExist(spellId) then return end
  if not spellLoadFrame then
    spellLoadFrame = CreateFrame("Frame")
    spellLoadFrame:RegisterEvent("SPELL_DATA_LOAD_RESULT")
    spellLoadFrame:SetScript("OnEvent", onSpellDataLoaded)
  end
  pendingSpells[spellId] = true
  C_Spell.RequestLoadSpellData(spellId)
end

---Parses spell and spec ids, rejects things like 1e9, 2.5 or ids too large for the game api
local MAX_ID = 2147483647
local function parseId(text)
  if type(text) ~= "string" or not text:match("^%d+$") or #text > 10 then return end
  local id = tonumber(text)
  if id and id > 0 and id <= MAX_ID then return id end
end

---the spec functions moved to C_SpecializationInfo, the globals are deprecated
local function getSpecApi(name)
  return C_SpecializationInfo and C_SpecializationInfo[name] or _G[name]
end

---Returns the icon of a spell, false if the spell does not exist and nil while it is loading
function MDT:GetPresetTextSpellIcon(spellId)
  local icon = sessionIcons[spellId]
  if icon ~= nil then return icon end
  local savedIcons = getSavedIcons()
  icon = savedIcons[spellId]
  if not icon then
    local texture = C_Spell.GetSpellTexture(spellId)
    if isUsableValue(texture) then
      icon = texture
      savedIcons[spellId] = icon
    elseif C_Spell.DoesSpellExist and not C_Spell.DoesSpellExist(spellId) then
      icon = false
    else
      requestSpellData(spellId)
      return nil
    end
  end
  sessionIcons[spellId] = icon
  return icon
end

---Returns the spell name in the client language, falls back to the given english name
local function getSpellName(spellId, fallback)
  local name = C_Spell.GetSpellName(spellId)
  if isUsableValue(name) then return name end
  return fallback
end

---Rendering
--spell and spec icons are zoomed in by 20% to cut off their borders
local ICON_ZOOM = 0.2
local ICON_INSET = (1 - 1 / (1 + ICON_ZOOM)) / 2
local ZOOMED_COORDS = { ICON_INSET, 1 - ICON_INSET, ICON_INSET, 1 - ICON_INSET }
--markup coords are in pixels of the given texture size, only their ratio matters
local ZOOMED_MARKUP_SIZE = 1000
local ZOOMED_MARKUP_COORDS = {}
for i, coord in ipairs(ZOOMED_COORDS) do ZOOMED_MARKUP_COORDS[i] = floor(coord * ZOOMED_MARKUP_SIZE + 0.5) end

local function textureMarkup(texture, size, coords, textureSize)
  if coords then
    return ("|T%s:%d:%d:0:0:%d:%d:%d:%d:%d:%d|t"):format(texture, size, size, textureSize, textureSize, unpack(coords))
  end
  return ("|T%s:%d:%d|t"):format(texture, size, size)
end

local roleAtlases = {}
local function getRoleAtlas(role)
  if roleAtlases[role] == nil then
    roleAtlases[role] = false
    for _, atlas in ipairs(ROLE_ATLASES[role]) do
      if C_Texture.GetAtlasInfo(atlas) then
        roleAtlases[role] = atlas
        break
      end
    end
  end
  return roleAtlases[role]
end

local function getMarkerIndex(name)
  local index = tonumber(name:match("^rt(%d)$"))
  if index and index >= 1 and index <= 8 then return index end
  for i, markerName in ipairs(MARKER_NAMES) do
    --english and client language marker names
    if markerName == name or (_G["RAID_TARGET_"..i] or ""):lower() == name then return i end
  end
  if MARKER_ALIASES[name] then return MARKER_ALIASES[name] end
  --localized marker names known by the chat
  return ICON_TAG_LIST and ICON_TAG_LIST[name]
end

local classTokensByName
local function getClassToken(name)
  if not classTokensByName then
    classTokensByName = {}
    for _, token in ipairs(CLASS_TOKENS) do
      classTokensByName[ENGLISH_CLASS_NAMES[token]:lower()] = token
      for _, names in ipairs({ LOCALIZED_CLASS_NAMES_MALE or {}, LOCALIZED_CLASS_NAMES_FEMALE or {} }) do
        if names[token] then classTokensByName[names[token]:lower()] = token end
      end
    end
  end
  return classTokensByName[name]
end

local function getClassIcon(token)
  return CLASS_ICON_PATH..token:lower()
end

---Tags follow the Method Raid Tools note syntax, {spec:ID} is an addition
local function renderTag(tag, size)
  local name, argument = tag:match("^([^:]+):?(.*)$")
  if not name then return end
  name = name:lower()
  if name == "spell" then
    --{spell:ID:size} is accepted, icons always match the font size
    local spellId = parseId(argument:match("^(%d+)"))
    if not spellId then return end
    local icon = MDT:GetPresetTextSpellIcon(spellId)
    if icon == false then return end
    return textureMarkup(icon or QUESTION_MARK_ICON, size, ZOOMED_MARKUP_COORDS, ZOOMED_MARKUP_SIZE)
  elseif name == "icon" then
    if argument == "" or argument:find("|", 1, true) then return end
    return textureMarkup(argument, size)
  elseif name == "spec" then
    local specId = parseId(argument)
    local getSpecInfo = getSpecApi("GetSpecializationInfoByID")
    local icon = specId and getSpecInfo and select(4, getSpecInfo(specId))
    if isUsableValue(icon) then return textureMarkup(icon, size, ZOOMED_MARKUP_COORDS, ZOOMED_MARKUP_SIZE) end
  elseif argument == "" then
    if ROLE_COORDS[name] then
      local atlas = getRoleAtlas(name)
      if atlas then return ("|A:%s:%d:%d|a"):format(atlas, size, size) end
      return textureMarkup(ROLE_ICON_TEXTURE, size, ROLE_COORDS[name], 64)
    end
    local markerIndex = getMarkerIndex(name)
    if markerIndex then return textureMarkup(RAID_TARGET_TEXTURE..markerIndex, size) end
    local token = getClassToken(name)
    if token then return textureMarkup(getClassIcon(token), size, ZOOMED_MARKUP_COORDS, ZOOMED_MARKUP_SIZE) end
  end
end

---Replaces icon tags with texture markup, unknown tags stay as they are
function MDT:RenderPresetTextTags(text, size)
  size = max(1, floor(size + 0.5))
  return (text:gsub("{([^{}]+)}", function(tag)
    return renderTag(tag, size)
  end))
end

---Picker entries
local entries

local function addEntry(section, tag, texture, coords, textureSize, getName, searchTerms, spellId)
  tinsert(section.entries, {
    tag = tag,
    texture = texture,
    coords = coords,
    textureSize = textureSize,
    getName = getName,
    searchTerms = searchTerms,
    spellId = spellId,
  })
end

local function buildEntries()
  local sections = {}
  local function newSection(title)
    local section = { title = title, entries = {} }
    tinsert(sections, section)
    return section
  end

  local markers = newSection(L["Raid Markers"])
  for i, markerName in ipairs(MARKER_NAMES) do
    local localizedName = _G["RAID_TARGET_"..i] or markerName
    addEntry(markers, "{"..markerName.."}", RAID_TARGET_TEXTURE..i, nil, nil, function() return localizedName end,
      { markerName })
  end

  local roles = newSection(L["Roles"])
  local roleNames = { tank = TANK, healer = HEALER, dps = DAMAGER }
  for _, role in ipairs(ROLE_ORDER) do
    local coords = ROLE_COORDS[role]
    addEntry(roles, "{"..role.."}", ROLE_ICON_TEXTURE, { coords[1] / 64, coords[2] / 64, coords[3] / 64, coords[4] / 64 },
      nil, function() return roleNames[role] or role end, { role })
    roles.entries[#roles.entries].atlas = getRoleAtlas(role)
  end

  local classNames = LOCALIZED_CLASS_NAMES_MALE or {}
  local classes = newSection(L["Classes"])
  for _, token in ipairs(CLASS_TOKENS) do
    addEntry(classes, "{"..ENGLISH_CLASS_NAMES[token].."}", getClassIcon(token), ZOOMED_COORDS, nil,
      function() return classNames[token] or ENGLISH_CLASS_NAMES[token] end, { ENGLISH_CLASS_NAMES[token] })
  end

  local specs = newSection(L["Specializations"])
  for classIndex = 1, GetNumClasses() do
    local className, _, classId = GetClassInfo(classIndex)
    local getNumSpecs = getSpecApi("GetNumSpecializationsForClassID")
    local getSpecInfo = getSpecApi("GetSpecializationInfoForClassID")
    for specIndex = 1, getNumSpecs and getSpecInfo and getNumSpecs(classId) or 0 do
      local specId, specName, _, icon = getSpecInfo(classId, specIndex)
      if specId and isUsableValue(icon) then
        addEntry(specs, "{spec:"..specId.."}", icon, ZOOMED_COORDS, nil, function() return specName.." "..className end,
          { className })
      end
    end
  end

  local categorySections = {}
  for _, category in ipairs(MDT.presetTextSpellCategories or {}) do
    categorySections[category.key] = newSection(category.title)
  end
  for _, spell in ipairs(MDT.presetTextSpells or {}) do
    local section = categorySections[spell.category]
    if section then
      local className = classNames[spell.class]
      addEntry(section, "{spell:"..spell.id.."}", nil, nil, nil, function() return getSpellName(spell.id, spell.name) end,
        { spell.name:lower(), className, spell.class and spell.class:lower() }, spell.id)
    end
  end
  return sections
end

local function matchesSearch(entry, query)
  if query == "" then return true end
  local name = entry.getName()
  if name and name:lower():find(query, 1, true) then return true end
  for _, term in pairs(entry.searchTerms or {}) do
    if term and term:lower():find(query, 1, true) then return true end
  end
  return false
end

---Picker frame
local PICKER_WIDTH, PICKER_HEIGHT = 300, 260
local ICON_SIZE, ICON_SPACING = 20, 2
local PADDING = 6
local picker

local function setButtonIcon(button, entry)
  local icon = button.icon
  icon:SetTexCoord(0, 1, 0, 1)
  if entry.spellId then
    local spellIcon = MDT:GetPresetTextSpellIcon(entry.spellId)
    icon:SetTexture(spellIcon or QUESTION_MARK_ICON)
    icon:SetTexCoord(unpack(ZOOMED_COORDS))
  elseif entry.atlas then
    icon:SetAtlas(entry.atlas)
  else
    icon:SetTexture(entry.texture)
    if entry.coords then icon:SetTexCoord(unpack(entry.coords)) end
  end
end

local function showEntryTooltip(button)
  local entry = button.entry
  if not entry then return end
  GameTooltip:SetOwner(button, "ANCHOR_RIGHT")
  if entry.spellId and GameTooltip.SetSpellByID then
    GameTooltip:SetSpellByID(entry.spellId)
  else
    GameTooltip:SetText(entry.getName() or entry.tag, 1, 1, 1)
  end
  GameTooltip:AddLine(entry.tag, 0.6, 0.6, 0.6)
  GameTooltip:Show()
end

local function acquireButton()
  picker.buttonCount = picker.buttonCount + 1
  local button = picker.buttons[picker.buttonCount]
  if not button then
    button = CreateFrame("Button", nil, picker.content)
    button:SetSize(ICON_SIZE, ICON_SIZE)
    button.icon = button:CreateTexture(nil, "ARTWORK")
    button.icon:SetAllPoints()
    local highlight = button:CreateTexture(nil, "HIGHLIGHT")
    highlight:SetAllPoints()
    highlight:SetColorTexture(1, 1, 1, 0.25)
    button:SetScript("OnEnter", showEntryTooltip)
    button:SetScript("OnLeave", function() GameTooltip:Hide() end)
    button:SetScript("OnClick", function(self)
      if self.entry and picker.onPick then picker.onPick(self.entry.tag) end
    end)
    picker.buttons[picker.buttonCount] = button
  end
  button:Show()
  return button
end

local function acquireHeader()
  picker.headerCount = picker.headerCount + 1
  local header = picker.headers[picker.headerCount]
  if not header then
    header = picker.content:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    header:SetJustifyH("LEFT")
    picker.headers[picker.headerCount] = header
  end
  header:Show()
  return header
end

local function layoutPicker()
  entries = entries or buildEntries()
  picker.buttonCount, picker.headerCount = 0, 0
  for _, button in ipairs(picker.buttons) do button:Hide() end
  for _, header in ipairs(picker.headers) do header:Hide() end

  local query = (picker.search:GetText() or ""):lower():gsub("^%s+", ""):gsub("%s+$", "")
  local contentWidth = PICKER_WIDTH - PADDING * 2 - 8
  local columns = max(1, floor((contentWidth + ICON_SPACING) / (ICON_SIZE + ICON_SPACING)))
  local y = 0

  local function placeSection(title, sectionEntries)
    if #sectionEntries == 0 then return end
    local header = acquireHeader()
    header:ClearAllPoints()
    header:SetPoint("TOPLEFT", picker.content, "TOPLEFT", 0, -y)
    header:SetText(title)
    y = y + 14
    for i, entry in ipairs(sectionEntries) do
      local column = (i - 1) % columns
      if column == 0 and i > 1 then y = y + ICON_SIZE + ICON_SPACING end
      local button = acquireButton()
      button.entry = entry
      setButtonIcon(button, entry)
      button:ClearAllPoints()
      button:SetPoint("TOPLEFT", picker.content, "TOPLEFT", column * (ICON_SIZE + ICON_SPACING), -y)
    end
    y = y + ICON_SIZE + 8
  end

  --a number searches for that spell id
  local spellId = parseId(query)
  if spellId then
    local icon = MDT:GetPresetTextSpellIcon(spellId)
    if icon ~= false then
      placeSection(L["Spell ID"], { {
        tag = "{spell:"..spellId.."}",
        spellId = spellId,
        getName = function() return getSpellName(spellId, tostring(spellId)) end,
      } })
    end
  end

  for _, section in ipairs(entries) do
    local matching = {}
    for _, entry in ipairs(section.entries) do
      if matchesSearch(entry, query) or (section.title and section.title:lower():find(query, 1, true)) then
        tinsert(matching, entry)
      end
    end
    placeSection(section.title, matching)
  end

  picker.content:SetSize(contentWidth, max(y, 1))
  picker.scrollFrame:SetVerticalScroll(0)
  picker.noResults:SetShown(y == 0)
end

local function scrollPicker(_, delta)
  local scrollFrame = picker.scrollFrame
  local maxScroll = max(0, picker.content:GetHeight() - scrollFrame:GetHeight())
  local value = min(maxScroll, max(0, scrollFrame:GetVerticalScroll() - delta * (ICON_SIZE + ICON_SPACING) * 2))
  scrollFrame:SetVerticalScroll(value)
end

---Flat search box in the style of the text style bar
local SEARCH_HEIGHT = 20
local function createSearchBox(parent)
  local search = CreateFrame("EditBox", nil, parent, "BackdropTemplate")
  search:SetHeight(SEARCH_HEIGHT)
  search:SetAutoFocus(false)
  search:SetFontObject("GameFontHighlightSmall")
  search:SetTextInsets(20, 18, 0, 0)
  search:SetBackdrop({
    bgFile = "Interface\\Buttons\\WHITE8X8",
    edgeFile = "Interface\\Buttons\\WHITE8X8",
    edgeSize = 1,
  })
  search:SetBackdropColor(0, 0, 0, 0.5)
  search:SetBackdropBorderColor(1, 1, 1, 0.2)

  local magnifier = search:CreateTexture(nil, "OVERLAY")
  magnifier:SetSize(12, 12)
  magnifier:SetPoint("LEFT", 5, 0)
  magnifier:SetAtlas("common-search-magnifyingglass")
  magnifier:SetVertexColor(0.6, 0.6, 0.6)

  local placeholder = search:CreateFontString(nil, "OVERLAY", "GameFontDisableSmall")
  placeholder:SetPoint("LEFT", 20, 0)
  placeholder:SetText(SEARCH)

  local clear = CreateFrame("Button", nil, search)
  clear:SetSize(SEARCH_HEIGHT - 4, SEARCH_HEIGHT - 4)
  clear:SetPoint("RIGHT", -2, 0)
  local clearLabel = clear:CreateFontString(nil, "OVERLAY", "GameFontDisableSmall")
  clearLabel:SetPoint("CENTER", 0, 1)
  clearLabel:SetText("x")
  local clearHighlight = clear:CreateTexture(nil, "HIGHLIGHT")
  clearHighlight:SetAllPoints()
  clearHighlight:SetColorTexture(1, 1, 1, 0.15)
  clear:SetScript("OnClick", function()
    search:SetText("")
    search:ClearFocus()
  end)
  clear:Hide()

  search:SetScript("OnTextChanged", function(self)
    local hasText = self:GetText() ~= ""
    placeholder:SetShown(not hasText)
    clear:SetShown(hasText)
    layoutPicker()
  end)
  search:SetScript("OnEditFocusGained", function(self)
    self:SetBackdropBorderColor(1, 1, 1, 0.5)
    magnifier:SetVertexColor(1, 1, 1)
  end)
  search:SetScript("OnEditFocusLost", function(self)
    self:SetBackdropBorderColor(1, 1, 1, 0.2)
    magnifier:SetVertexColor(0.6, 0.6, 0.6)
  end)
  search:SetScript("OnEnterPressed", function(self) self:ClearFocus() end)
  return search
end

---Creates the icon picker, onPick is called with the tag of the clicked icon
function MDT:CreatePresetTextIconPicker(parent, onPick)
  if picker then return picker end
  picker = CreateFrame("Frame", "MDTPresetTextIconPicker", parent, "BackdropTemplate")
  picker:SetSize(PICKER_WIDTH, PICKER_HEIGHT)
  picker:SetFrameLevel(parent:GetFrameLevel() + 10)
  picker:SetClampedToScreen(true)
  picker:EnableMouse(true)
  picker:SetBackdrop({
    bgFile = "Interface\\Buttons\\WHITE8X8",
    edgeFile = "Interface\\Buttons\\WHITE8X8",
    edgeSize = 1,
  })
  picker:SetBackdropColor(unpack(MDT.BackdropColor))
  picker:SetBackdropBorderColor(1, 1, 1, 0.2)
  picker.onPick = onPick
  picker.buttons, picker.headers = {}, {}
  picker.buttonCount, picker.headerCount = 0, 0

  picker.search = createSearchBox(picker)
  picker.search:SetPoint("TOPLEFT", PADDING, -PADDING)
  picker.search:SetPoint("TOPRIGHT", -PADDING, -PADDING)
  picker.search:SetScript("OnEscapePressed", function(self)
    self:ClearFocus()
    picker:Hide()
  end)

  picker.scrollFrame = CreateFrame("ScrollFrame", nil, picker)
  picker.scrollFrame:SetPoint("TOPLEFT", PADDING, -PADDING - 26)
  picker.scrollFrame:SetPoint("BOTTOMRIGHT", -PADDING, PADDING)
  picker.scrollFrame:EnableMouseWheel(true)
  picker.scrollFrame:SetScript("OnMouseWheel", scrollPicker)
  picker.content = CreateFrame("Frame", nil, picker.scrollFrame)
  picker.content:SetSize(1, 1)
  picker.scrollFrame:SetScrollChild(picker.content)

  picker.noResults = picker:CreateFontString(nil, "OVERLAY", "GameFontDisableSmall")
  picker.noResults:SetPoint("CENTER", picker.scrollFrame, "CENTER")
  picker.noResults:SetText(L["No results"])
  picker.noResults:Hide()

  picker:SetScript("OnShow", function()
    --clearing the search lays out the picker through OnTextChanged
    if picker.search:GetText() ~= "" then
      picker.search:SetText("")
    else
      layoutPicker()
    end
  end)
  picker:Hide()
  return picker
end

---Updates icons that finished loading while the picker is open
function MDT:RefreshPresetTextIconPicker()
  if not picker or not picker:IsShown() then return end
  for i = 1, picker.buttonCount do
    local button = picker.buttons[i]
    if button.entry then setButtonIcon(button, button.entry) end
  end
end
