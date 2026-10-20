-- Global WoW API, part 1: Lua extensions, error handler, mixins, colors, fonts, clock and timers, events.
return function(W)
  local S, usage, checkNumber = W.state, W.usage, W.checkNumber
  local G = _G

  W.screenWidth, W.screenHeight = 1920, 1080
  W.now = 1000
  W.printed = {}
  W.popups = {}
  W.chatMessages = {}
  W.undefinedGlobals = {}
  W.undefinedGlobalOrder = {}
  -- Same sequence on LuaJIT and PUC Lua, so --dump snapshots are comparable across runtimes.
  local seed = 1
  function math.random(low, high)
    seed = (seed * 1103515245 + 12345) % 2147483648
    local fraction = seed / 2147483648
    if not low then return fraction end
    if not high then low, high = 1, low end
    return low + math.floor(fraction * (high - low + 1))
  end
  function math.randomseed(value) seed = math.floor(value) % 2147483648 end

  -- Lua extensions -------------------------------------------------------------------------

  function G.strsplit(delimiter, text, limit)
    usage(type(text) == "string" or type(text) == "number", "strsplit(): text must be a string")
    text = tostring(text)
    local parts, start = {}, 1
    local pattern = "["..delimiter:gsub("[%]%^%-%%]", "%%%0").."]"
    while true do
      if limit and #parts == limit - 1 then break end
      local first, last = text:find(pattern, start)
      if not first then break end
      parts[#parts + 1] = text:sub(start, first - 1)
      start = last + 1
    end
    parts[#parts + 1] = text:sub(start)
    return unpack(parts)
  end
  function G.strtrim(text, chars)
    chars = chars and "["..chars:gsub("[%]%^%-%%]", "%%%0").."]" or "%s"
    return (text:gsub("^"..chars.."+", ""):gsub(chars.."+$", ""))
  end
  function G.strjoin(delimiter, ...) return table.concat({ ... }, delimiter) end
  function G.strconcat(...) return table.concat({ ... }) end
  G.strmatch, G.strfind, G.strsub, G.strlen = string.match, string.find, string.sub, string.len
  G.strlower, G.strupper, G.strrep, G.strbyte, G.strchar = string.lower, string.upper, string.rep, string.byte, string.char
  G.strrev, G.format, G.gsub, G.gmatch = string.reverse, string.format, string.gsub, string.gmatch
  G.strlenutf8 = function(text) local _, count = text:gsub("[^\128-\191]", "") return count end
  G.strcmputf8i = function(a, b) a, b = a:lower(), b:lower() return a < b and -1 or a > b and 1 or 0 end
  string.split, string.trim, string.join = G.strsplit, G.strtrim, G.strjoin
  G.tinsert, G.tremove, G.sort, G.tconcat = table.insert, table.remove, table.sort, table.concat
  function G.wipe(target)
    for key in pairs(target) do target[key] = nil end
    return target
  end
  table.wipe = G.wipe
  function G.tContains(list, value)
    for _, item in ipairs(list) do if item == value then return true end end
    return false
  end
  function G.tIndexOf(list, value)
    for index, item in ipairs(list) do if item == value then return index end end
  end
  function G.tInvert(source)
    local result = {}
    for key, value in pairs(source) do result[value] = key end
    return result
  end
  function G.tFilter(list, predicate, indexed)
    local result = {}
    for key, value in pairs(list) do
      if predicate(value) then if indexed then result[#result + 1] = value else result[key] = value end end
    end
    return result
  end
  function G.tAppendAll(target, source) for _, value in ipairs(source) do target[#target + 1] = value end end
  function G.tDeleteItem(list, value)
    for index = #list, 1, -1 do if list[index] == value then table.remove(list, index) end end
  end
  function G.ArrayRemove(list, value) G.tDeleteItem(list, value) end
  function G.CopyTable(source, shallow)
    local copy = {}
    for key, value in pairs(source) do
      copy[key] = (type(value) == "table" and not shallow) and G.CopyTable(value) or value
    end
    return copy
  end
  function G.GetKeysArray(source)
    local keys = {}
    for key in pairs(source) do keys[#keys + 1] = key end
    return keys
  end
  function G.GetValuesArray(source)
    local values = {}
    for _, value in pairs(source) do values[#values + 1] = value end
    return values
  end
  G.floor, G.ceil, G.abs, G.max, G.min, G.sqrt = math.floor, math.ceil, math.abs, math.max, math.min, math.sqrt
  G.exp, G.log, G.log10, G.frexp, G.ldexp = math.exp, math.log, math.log10, math.frexp, math.ldexp
  G.random, G.fastrandom = math.random, math.random
  G.mod = math.fmod
  G.PI = math.pi
  G.deg, G.rad = math.deg, math.rad
  G.sin = function(degrees) return math.sin(math.rad(degrees)) end
  G.cos = function(degrees) return math.cos(math.rad(degrees)) end
  G.tan = function(degrees) return math.tan(math.rad(degrees)) end
  G.asin = function(value) return math.deg(math.asin(value)) end
  G.acos = function(value) return math.deg(math.acos(value)) end
  G.atan = function(value) return math.deg(math.atan(value)) end
  G.atan2 = function(y, x) return math.deg(math.atan2(y, x)) end
  function G.Clamp(value, low, high) return math.min(high, math.max(low, value)) end
  function G.Lerp(from, to, amount) return from + (to - from) * amount end
  function G.Round(value) return math.floor(value + 0.5) end
  function G.Saturate(value) return G.Clamp(value, 0, 1) end
  function G.tostringall(...)
    local values = { ... }
    for index = 1, select("#", ...) do values[index] = tostring(values[index]) end
    return unpack(values, 1, select("#", ...))
  end
  G.date, G.time = os.date, os.time
  function G.GetServerTime() return os.time() end
  function G.debugprofilestop() return os.clock() * 1000 end
  function G.debugprofilestart() end
  function G.debugstack(thread, start, count1, count2)
    if type(thread) == "thread" then return debug.traceback(thread) end
    return debug.traceback("", 2)
  end
  function G.debuglocals() return "" end
  function G.securecall(fn, ...)
    if type(fn) == "string" then fn = G[fn] end
    return W.protectedCall(fn, ...)
  end
  G.securecallfunction = G.securecall
  function G.secureexecuterange(list, fn, ...)
    for key, value in pairs(list) do W.protectedCall(fn, key, value, ...) end
  end
  function G.issecure() return false end
  function G.issecurevariable() return false, nil end
  function G.forceinsecure() end
  function G.scrub(...) return ... end
  function G.hooksecurefunc(target, name, hook)
    if type(target) == "string" then target, name, hook = G, target, name end
    local original = target[name]
    usage(type(original) == "function", 'hooksecurefunc(): "'..tostring(name)..'" is not a function')
    target[name] = function(...)
      local results = { original(...) }
      hook(...)
      return unpack(results)
    end
  end

  if not G.bit then
    local function toBits(value)
      value = value % 4294967296
      local bits = {}
      for index = 1, 32 do
        bits[index] = value % 2
        value = math.floor(value / 2)
      end
      return bits
    end
    local function fromBits(bits)
      local value = 0
      for index = 32, 1, -1 do value = value * 2 + bits[index] end
      return value
    end
    local function bitwise(combine)
      local function pair(a, b)
        local left, right = toBits(a), toBits(b)
        for index = 1, 32 do left[index] = combine(left[index], right[index]) end
        return fromBits(left)
      end
      return function(a, b, ...)
        local result = pair(a, b)
        for index = 1, select("#", ...) do result = pair(result, (select(index, ...))) end
        return result
      end
    end
    G.bit = {
      band = bitwise(function(a, b) return (a == 1 and b == 1) and 1 or 0 end),
      bor = bitwise(function(a, b) return (a == 1 or b == 1) and 1 or 0 end),
      bxor = bitwise(function(a, b) return a ~= b and 1 or 0 end),
      bnot = function(a) return 4294967295 - a % 4294967296 end,
      lshift = function(a, n) return (a * 2 ^ n) % 4294967296 end,
      rshift = function(a, n) return math.floor((a % 4294967296) / 2 ^ n) end,
    }
  end

  -- Errors and output ----------------------------------------------------------------------

  local errorHandler = function(message)
    W.errorHandler(message)
    return message
  end
  function G.geterrorhandler() return errorHandler end
  function G.seterrorhandler(handler) errorHandler = handler end
  function G.print(...)
    local parts = {}
    for index = 1, select("#", ...) do parts[#parts + 1] = tostring((select(index, ...))) end
    local line = table.concat(parts, " ")
    W.printed[#W.printed + 1] = line
    if W.verbose then io.write("[print] ", line, "\n") end
  end

  -- Mixins ---------------------------------------------------------------------------------

  function W.Mixin(target, ...)
    for index = 1, select("#", ...) do
      local mixin = select(index, ...)
      usage(type(mixin) == "table", "Mixin(): mixin must be a table")
      for key, value in pairs(mixin) do target[key] = value end
    end
    return target
  end
  G.Mixin = W.Mixin
  function G.CreateFromMixins(...) return W.Mixin({}, ...) end
  function G.CreateAndInitFromMixin(mixin, ...)
    local object = W.Mixin({}, mixin)
    object:Init(...)
    return object
  end

  G.BackdropTemplateMixin = {}
  local Backdrop = G.BackdropTemplateMixin
  function Backdrop:SetBackdrop(info) S[self].backdrop = info end
  function Backdrop:GetBackdrop() return S[self].backdrop end
  function Backdrop:ApplyBackdrop() end
  function Backdrop:ClearBackdrop() S[self].backdrop = nil end
  function Backdrop:OnBackdropLoaded() end
  function Backdrop:OnBackdropSizeChanged() end
  function Backdrop:HasBackdropInfo(info) return S[self].backdrop == info end
  function Backdrop:SetupTextureCoordinates() end
  function Backdrop:SetBackdropColor(r, g, b, a) S[self].backdropColor = { r, g, b, a or 1 } end
  function Backdrop:GetBackdropColor() return unpack(S[self].backdropColor or { 1, 1, 1, 1 }) end
  function Backdrop:SetBackdropBorderColor(r, g, b, a) S[self].backdropBorderColor = { r, g, b, a or 1 } end
  function Backdrop:GetBackdropBorderColor() return unpack(S[self].backdropBorderColor or { 1, 1, 1, 1 }) end

  G.MaximizeMinimizeButtonFrameMixin = {}
  local MaxMin = G.MaximizeMinimizeButtonFrameMixin
  function MaxMin:SetOnMaximizedCallback(callback) self.maximizedCallback = callback end
  function MaxMin:SetOnMinimizedCallback(callback) self.minimizedCallback = callback end
  function MaxMin:Maximize(skipCallback)
    if self.maximizedCallback and not skipCallback then self.maximizedCallback(self) end
    self.isMinimized = false
    self.MaximizeButton:Hide()
    self.MinimizeButton:Show()
  end
  function MaxMin:Minimize(skipCallback)
    if self.minimizedCallback and not skipCallback then self.minimizedCallback(self) end
    self.isMinimized = true
    self.MaximizeButton:Show()
    self.MinimizeButton:Hide()
  end
  function MaxMin:IsMinimized() return self.isMinimized == true end
  function MaxMin:SetMinimizedCVar() end
  function MaxMin:SetMinimizedLook(minimized) end

  G.ColorMixin = {}
  local Color = G.ColorMixin
  function Color:SetRGBA(r, g, b, a) self.r, self.g, self.b, self.a = r, g, b, a end
  function Color:SetRGB(r, g, b) self:SetRGBA(r, g, b, nil) end
  function Color:GetRGB() return self.r, self.g, self.b end
  function Color:GetRGBA() return self.r, self.g, self.b, self.a or 1 end
  function Color:GetRGBAsBytes() return self.r * 255, self.g * 255, self.b * 255 end
  function Color:IsEqualTo(other) return self.r == other.r and self.g == other.g and self.b == other.b and self.a == other.a end
  function Color:GenerateHexColor() return ("ff%.2x%.2x%.2x"):format(self.r * 255, self.g * 255, self.b * 255) end
  function Color:GenerateHexColorMarkup() return "|c"..self:GenerateHexColor() end
  function Color:WrapTextInColorCode(text) return "|c"..self:GenerateHexColor()..text.."|r" end
  function G.CreateColor(r, g, b, a)
    local color = W.Mixin({}, Color)
    color:SetRGBA(r, g, b, a)
    return color
  end
  function G.CreateColorFromHexString(hex)
    local a, r, g, b = tonumber(hex:sub(1, 2), 16), tonumber(hex:sub(3, 4), 16), tonumber(hex:sub(5, 6), 16), tonumber(hex:sub(7, 8), 16)
    return G.CreateColor(r / 255, g / 255, b / 255, a / 255)
  end
  function G.WrapTextInColorCode(text, colorHex) return "|c"..colorHex..text.."|r" end
  function G.WrapTextInColor(text, color) return color:WrapTextInColorCode(text) end
  G.NORMAL_FONT_COLOR = G.CreateColor(1, 0.82, 0)
  G.HIGHLIGHT_FONT_COLOR = G.CreateColor(1, 1, 1)
  G.WHITE_FONT_COLOR = G.CreateColor(1, 1, 1)
  G.GRAY_FONT_COLOR = G.CreateColor(0.5, 0.5, 0.5)
  G.DISABLED_FONT_COLOR = G.CreateColor(0.5, 0.5, 0.5)
  G.RED_FONT_COLOR = G.CreateColor(1, 0.1, 0.1)
  G.GREEN_FONT_COLOR = G.CreateColor(0.1, 1, 0.1)
  G.YELLOW_FONT_COLOR = G.CreateColor(1, 1, 0)
  G.LIGHTBLUE_FONT_COLOR = G.CreateColor(0.53, 0.67, 1)
  G.NORMAL_FONT_COLOR_CODE, G.HIGHLIGHT_FONT_COLOR_CODE, G.FONT_COLOR_CODE_CLOSE = "|cffffd200", "|cffffffff", "|r"
  G.RED_FONT_COLOR_CODE, G.GREEN_FONT_COLOR_CODE, G.GRAY_FONT_COLOR_CODE = "|cffff2020", "|cff20ff20", "|cff808080"

  local classes = {
    { "WARRIOR", 0.78, 0.61, 0.43 }, { "PALADIN", 0.96, 0.55, 0.73 }, { "HUNTER", 0.67, 0.83, 0.45 },
    { "ROGUE", 1, 0.96, 0.41 }, { "PRIEST", 1, 1, 1 }, { "DEATHKNIGHT", 0.77, 0.12, 0.23 },
    { "SHAMAN", 0, 0.44, 0.87 }, { "MAGE", 0.25, 0.78, 0.92 }, { "WARLOCK", 0.53, 0.53, 0.93 },
    { "MONK", 0, 1, 0.6 }, { "DRUID", 1, 0.49, 0.04 }, { "DEMONHUNTER", 0.64, 0.19, 0.79 },
    { "EVOKER", 0.2, 0.58, 0.5 },
  }
  G.RAID_CLASS_COLORS = {}
  G.LOCALIZED_CLASS_NAMES_MALE = {}
  G.CLASS_SORT_ORDER = {}
  for index, entry in ipairs(classes) do
    local color = G.CreateColor(entry[2], entry[3], entry[4])
    color.colorStr = color:GenerateHexColor()
    G.RAID_CLASS_COLORS[entry[1]] = color
    G.LOCALIZED_CLASS_NAMES_MALE[entry[1]] = entry[1]:sub(1, 1)..entry[1]:sub(2):lower()
    G.CLASS_SORT_ORDER[index] = entry[1]
  end
  G.LOCALIZED_CLASS_NAMES_FEMALE = G.LOCALIZED_CLASS_NAMES_MALE
  function G.GetClassColor(classFile)
    local color = G.RAID_CLASS_COLORS[classFile] or G.HIGHLIGHT_FONT_COLOR
    return color.r, color.g, color.b, color.colorStr or color:GenerateHexColor()
  end
  G.C_ClassColor = { GetClassColor = function(classFile) return G.RAID_CLASS_COLORS[classFile] end }
  function G.GetNumClasses() return #classes end
  function G.GetClassInfo(index)
    local entry = classes[index]
    if not entry then return nil end
    return G.LOCALIZED_CLASS_NAMES_MALE[entry[1]], entry[1], index
  end

  function G.CreateVector2D(x, y)
    return { x = x, y = y, GetXY = function(self) return self.x, self.y end }
  end
  function G.CreateVector3D(x, y, z)
    return { x = x, y = y, z = z, GetXYZ = function(self) return self.x, self.y, self.z end }
  end
  function G.CreateAtlasMarkup(atlas, width, height) return ("|A:%s:%d:%d|a"):format(atlas, width or 0, height or 0) end
  function G.CreateTextureMarkup(file, ...) return "|T"..tostring(file)..":0|t" end
  function G.CreateSimpleTextureMarkup(file, width, height) return "|T"..tostring(file)..":"..(width or 0)..":"..(height or 0).."|t" end
  function G.FormatLargeNumber(value) return tostring(value) end
  function G.BreakUpLargeNumbers(value) return tostring(value) end
  function G.AbbreviateNumbers(value) return tostring(value) end
  function G.AbbreviateLargeNumbers(value) return tostring(value) end
  function G.SecondsToTime(seconds) return tostring(seconds).." sec" end
  function G.SecondsToClock(seconds) return ("%d:%02d"):format(math.floor(seconds / 60), seconds % 60) end
  function G.Ambiguate(name) return name end

  -- Fonts ----------------------------------------------------------------------------------

  G.CreateFont = function(name) return W.CreateFont(name) end
  function G.CreateFontFamily(name, members)
    local first = members and members[1]
    local font = W.CreateFont(name)
    if first then
      if first.fontObject then font:CopyFontObject(first.fontObject) end
      if first.file then font:SetFont(first.file, first.height or 12, first.flags or "") end
    end
    return font
  end
  G.STANDARD_TEXT_FONT, G.UNIT_NAME_FONT, G.DAMAGE_TEXT_FONT, G.NAMEPLATE_FONT =
    "Fonts\\FRIZQT__.TTF", "Fonts\\FRIZQT__.TTF", "Fonts\\FRIZQT__.TTF", "Fonts\\FRIZQT__.TTF"
  local fonts = {
    { "SystemFont_Small", 10 }, { "SystemFont_Med1", 12 }, { "SystemFont_Large", 16 },
    { "GameFontNormal", 12, 1, 0.82, 0 }, { "GameFontNormalSmall", 10, 1, 0.82, 0 }, { "GameFontNormalTiny", 9, 1, 0.82, 0 },
    { "GameFontNormalMed1", 13, 1, 0.82, 0 }, { "GameFontNormalMed2", 14, 1, 0.82, 0 }, { "GameFontNormalMed3", 15, 1, 0.82, 0 },
    { "GameFontNormalLarge", 16, 1, 0.82, 0 }, { "GameFontNormalLarge2", 18, 1, 0.82, 0 }, { "GameFontNormalHuge", 20, 1, 0.82, 0 },
    { "GameFontNormalOutline", 12, 1, 0.82, 0 }, { "GameFontNormalSmall2", 11, 1, 0.82, 0 },
    { "GameFontHighlight", 12, 1, 1, 1 }, { "GameFontHighlightSmall", 10, 1, 1, 1 }, { "GameFontHighlightLarge", 16, 1, 1, 1 },
    { "GameFontHighlightMedium", 14, 1, 1, 1 }, { "GameFontHighlightSmall2", 11, 1, 1, 1 }, { "GameFontHighlightOutline", 12, 1, 1, 1 },
    { "GameFontHighlightLeft", 12, 1, 1, 1 }, { "GameFontHighlightHuge", 20, 1, 1, 1 }, { "GameFontHighlightExtraSmall", 9, 1, 1, 1 },
    { "GameFontDisable", 12, 0.5, 0.5, 0.5 }, { "GameFontDisableSmall", 10, 0.5, 0.5, 0.5 }, { "GameFontDisableLarge", 16, 0.5, 0.5, 0.5 },
    { "GameFontGreen", 12, 0.1, 1, 0.1 }, { "GameFontRed", 12, 1, 0.1, 0.1 }, { "GameFontWhite", 12, 1, 1, 1 },
    { "GameFontWhiteSmall", 10, 1, 1, 1 }, { "GameFontBlack", 12, 0, 0, 0 },
    { "ChatFontNormal", 14, 1, 1, 1 }, { "ChatFontSmall", 12, 1, 1, 1 }, { "GameTooltipText", 12, 1, 1, 1 },
    { "GameTooltipTextSmall", 10, 1, 1, 1 }, { "GameTooltipHeaderText", 14, 1, 1, 1 }, { "NumberFontNormal", 14, 1, 1, 1 },
    { "NumberFontNormalSmall", 12, 1, 1, 1 }, { "NumberFontNormalLarge", 16, 1, 1, 1 }, { "QuestFont", 13, 0, 0, 0 },
    { "SubZoneTextFont", 26, 1, 0.82, 0 }, { "Game15Font_o1", 15, 1, 1, 1 }, { "Game13FontShadow", 13, 1, 1, 1 },
    { "Game11Font", 11, 1, 1, 1 }, { "Game12Font", 12, 1, 1, 1 }, { "Game18Font", 18, 1, 1, 1 }, { "Fancy16Font", 16, 1, 1, 1 },
    { "ObjectiveFont", 12, 1, 1, 1 }, { "SystemFont_Shadow_Med1", 12, 1, 1, 1 }, { "SystemFont_Outline_Small", 10, 1, 1, 1 },
  }
  for _, entry in ipairs(fonts) do
    local font = W.CreateFont(entry[1], "Fonts\\FRIZQT__.TTF", entry[2], "")
    if entry[3] then font:SetTextColor(entry[3], entry[4], entry[5]) end
  end

  -- Clock, timers, frame loop --------------------------------------------------------------

  function G.GetTime() return W.now end
  function G.GetTimePreciseSec() return W.now end
  function G.GetFramerate() return 60 end
  local timers, timerSequence = {}, 0

  local function schedule(delay, callback, handle)
    checkNumber(delay, "C_Timer", "delay")
    usage(type(callback) == "function", "C_Timer: callback must be a function")
    timerSequence = timerSequence + 1
    local entry = { due = W.now + math.max(0, delay), sequence = timerSequence, callback = callback, handle = handle, site = W.callSite() }
    timers[#timers + 1] = entry
    return entry
  end

  local TimerHandle = {}
  TimerHandle.__index = TimerHandle
  function TimerHandle:Cancel() self.cancelled = true end
  function TimerHandle:IsCancelled() return self.cancelled == true end
  function TimerHandle:Invoke(...) return self.callback(...) end

  G.C_Timer = {
    After = function(delay, callback) schedule(delay, callback) end,
    NewTimer = function(delay, callback)
      local handle = setmetatable({ callback = callback }, TimerHandle)
      schedule(delay, function() callback(handle) end, handle)
      return handle
    end,
    NewTicker = function(interval, callback, iterations)
      local handle = setmetatable({ callback = callback, remaining = iterations, ticker = true }, TimerHandle)
      local function tick()
        callback(handle)
        if handle.remaining then
          handle.remaining = handle.remaining - 1
          if handle.remaining <= 0 then return end
        end
        if not handle.cancelled then schedule(interval, tick, handle) end
      end
      schedule(interval, tick, handle)
      return handle
    end,
  }

  local function nextTimer(limit)
    local bestIndex, best
    for index, entry in ipairs(timers) do
      if entry.due <= limit and (not best or entry.due < best.due or (entry.due == best.due and entry.sequence < best.sequence)) then
        bestIndex, best = index, entry
      end
    end
    if bestIndex then table.remove(timers, bestIndex) end
    return best
  end

  function W.pendingTimers(horizon)
    local count = 0
    for _, entry in ipairs(timers) do
      local handle = entry.handle
      if not (handle and (handle.cancelled or handle.ticker)) and entry.due <= W.now + horizon then count = count + 1 end
    end
    return count
  end

  function W.step(elapsed)
    local target = W.now + elapsed
    while true do
      local entry = nextTimer(target)
      if not entry then break end
      W.now = math.max(W.now, entry.due)
      if not (entry.handle and entry.handle.cancelled) then W.protectedCall(entry.callback) end
    end
    W.now = target
    local frames = {}
    for frame in pairs(W.onUpdateFrames) do frames[#frames + 1] = frame end
    table.sort(frames, function(a, b) return S[a].id < S[b].id end)
    for _, frame in ipairs(frames) do
      if W.isVisible(frame) then W.fireScript(frame, "OnUpdate", elapsed) end
    end
    W.layoutPass()
    W.advanceAnimations(elapsed)
  end

  function W.pump(seconds, frameTime)
    frameTime = frameTime or 1 / 60
    local frames = math.max(1, math.floor(seconds / frameTime + 0.5))
    for _ = 1, frames do W.step(frameTime) end
  end

  function W.settle(isIdle, maxSeconds, horizon)
    local frameTime, elapsed, idleFrames = 1 / 60, 0, 0
    while elapsed < (maxSeconds or 30) do
      W.step(frameTime)
      elapsed = elapsed + frameTime
      if (not isIdle or isIdle()) and W.pendingTimers(horizon or 3) == 0 then
        idleFrames = idleFrames + 1
        if idleFrames >= 5 then return true, elapsed end
      else
        idleFrames = 0
      end
    end
    return false, elapsed
  end

  -- Events ---------------------------------------------------------------------------------

  local events = {}
  function W.registerEvent(frame, event)
    events[event] = events[event] or {}
    for _, registered in ipairs(events[event]) do if registered == frame then return end end
    table.insert(events[event], frame)
  end
  function W.unregisterEvent(frame, event)
    local list = events[event]
    if not list then return end
    for index, registered in ipairs(list) do
      if registered == frame then table.remove(list, index) return end
    end
  end
  function W.unregisterAllEvents(frame)
    for event in pairs(events) do W.unregisterEvent(frame, event) end
  end
  function W.eventRegistered(frame, event)
    for _, registered in ipairs(events[event] or {}) do if registered == frame then return true end end
    return false
  end
  function W.FireEvent(event, ...)
    local list = {}
    for index, frame in ipairs(events[event] or {}) do list[index] = frame end
    for _, frame in ipairs(list) do
      if W.eventRegistered(frame, event) then W.fireScript(frame, "OnEvent", event, ...) end
    end
  end

  G.EventRegistry = {
    RegisterCallback = function() end, UnregisterCallback = function() end, TriggerEvent = function() end,
    RegisterFrameEventAndCallback = function() end,
  }
end
