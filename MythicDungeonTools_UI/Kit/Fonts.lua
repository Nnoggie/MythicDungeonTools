local _, MDT = ...
local UI = MDT.UI

---Font objects are the only way text gets a font. Controls name roles; nobody calls SetFont on a FontString.
---@class MDT.UI.FontsApi
local Fonts = {}
UI.Fonts = Fonts

---@alias MDT.UI.Alphabet "roman"|"russian"|"korean"|"simplifiedchinese"|"traditionalchinese"

Fonts.alphabets = { "roman", "russian", "korean", "simplifiedchinese", "traditionalchinese" }

---The font MDT ships for roman text.
Fonts.defaultFile = "Interface\\AddOns\\MythicDungeonTools\\Fonts\\ArchivoNarrow-Bold.ttf"

---Per-alphabet files. roman is the font MDT ships, or the one the user picked (MDT.userFontFile, found before the kit
---loads); the rest are files the client installs with every locale.
Fonts.files = {
  roman = MDT.userFontFile or Fonts.defaultFile,
  russian = "Fonts\\FRIZQT___CYR.TTF",
  korean = "Fonts\\2002.TTF",
  simplifiedchinese = "Fonts\\ARKai_T.ttf",
  traditionalchinese = "Fonts\\blei00d.TTF",
}

---CJK faces read smaller at equal height.
Fonts.heightScale = { roman = 1, russian = 1, korean = 1.05, simplifiedchinese = 1.05, traditionalchinese = 1.05 }

local clientAlphabets = { ruRU = "russian", koKR = "korean", zhCN = "simplifiedchinese", zhTW = "traditionalchinese" }

---@param locale string
---@return MDT.UI.Alphabet
function Fonts.ClientAlphabet(locale)
  return clientAlphabets[locale] or "roman"
end

---@class MDT.UI.FontMember
---@field alphabet MDT.UI.Alphabet
---@field file string
---@field height number
---@field flags string

---Pure. Member list per role, the client's own alphabet first so a degraded CreateFont path picks it.
---@param locale string
---@param roles table<MDT.UI.FontRole, {size: number}>
---@param flags string? "" or "OUTLINE"
---@return table<MDT.UI.FontRole, MDT.UI.FontMember[]>
function Fonts.Plan(locale, roles, flags)
  local client = Fonts.ClientAlphabet(locale)
  local plan = {}
  for role, def in pairs(roles) do
    local members = {}
    local function add(alphabet)
      members[#members + 1] = {
        alphabet = alphabet,
        file = Fonts.files[alphabet],
        height = math.floor(def.size * Fonts.heightScale[alphabet] + 0.5),
        flags = flags or "",
      }
    end
    add(client)
    for _, alphabet in ipairs(Fonts.alphabets) do
      if alphabet ~= client then add(alphabet) end
    end
    plan[role] = members
  end
  return plan
end

---Pure. The alphabet a user-authored string needs beyond the client's own, or nil when the client font covers it.
---@param text string
---@param locale string
---@return MDT.UI.Alphabet?
function Fonts.FallbackAlphabet(text, locale)
  local found = UI.Strings.Alphabet(text)
  local needed
  if found == "cyrillic" then needed = "russian"
  elseif found == "hangul" then needed = "korean"
  elseif found == "cjk" then needed = locale == "zhTW" and "traditionalchinese" or "simplifiedchinese"
  else return nil end
  if needed == Fonts.ClientAlphabet(locale) then return nil end
  return needed
end

---Plain and outlined font objects per role, and per-alphabet fallbacks for each.
---@type {plain: table<MDT.UI.FontRole, table>, outline: table<MDT.UI.FontRole, table>}
Fonts.objects = { plain = {}, outline = {} }
---@type {plain: table<MDT.UI.FontRole, table<MDT.UI.Alphabet, table>>, outline: table<MDT.UI.FontRole, table<MDT.UI.Alphabet, table>>}
Fonts.fallbacks = { plain = {}, outline = {} }
local VARIANTS = { plain = { suffix = "", flags = "" }, outline = { suffix = "_outline", flags = "OUTLINE" } }
Fonts.locale = "enUS"

local function familyName(role, variant) return "MDTFont_"..role..VARIANTS[variant].suffix end

local function samePath(a, b)
  return type(a) == "string" and (a:lower():gsub("/", "\\")) == (b:lower():gsub("/", "\\"))
end

---Creates one font family per role (or a plain font when CreateFontFamily is unavailable or returns a family without its roman font) plus one fallback font per other alphabet.
function Fonts.Setup()
  Fonts.locale = GetLocale()
  for variant, spec in pairs(VARIANTS) do
    local plan = Fonts.Plan(Fonts.locale, UI.Theme.data.font, spec.flags)
    for role, members in pairs(plan) do
      local name = familyName(role, variant)
      local ok = type(CreateFontFamily) == "function" and pcall(CreateFontFamily, name, members)
      local font = ok and _G[name] or nil
      if not (font and samePath(font:GetFont(), Fonts.files.roman)) then
        font = CreateFont(name)
        font:SetFont(members[1].file, members[1].height, members[1].flags)
      end
      Fonts.objects[variant][role] = font
      Fonts.fallbacks[variant][role] = {}
      for _, member in ipairs(members) do
        if member.alphabet ~= members[1].alphabet then
          local fallback = CreateFont(name.."_"..member.alphabet)
          fallback:SetFont(member.file, member.height, member.flags)
          Fonts.fallbacks[variant][role][member.alphabet] = fallback
        end
      end
    end
  end
end

---@param role MDT.UI.FontRole
---@param outline boolean? the outlined variant, for text drawn over colored backgrounds
---@return table font object
function Fonts.Get(role, outline)
  return Fonts.objects[outline and "outline" or "plain"][role] or error("Fonts: unknown role "..tostring(role), 2)
end

---MDT's font at any size, for map text that scales with zoom. Pass the text when users wrote it, so glyphs the client
---alphabet lacks get a font that has them.
---@param fontString table
---@param size number
---@param flags string? "" or "OUTLINE"
---@param text string?
function Fonts.Apply(fontString, size, flags, text)
  local alphabet = text and Fonts.FallbackAlphabet(text, Fonts.locale) or Fonts.ClientAlphabet(Fonts.locale)
  fontString:SetFont(Fonts.files[alphabet], math.max(1, size * Fonts.heightScale[alphabet]), flags or "")
end

---User-authored text (route names, authors, notes) may hold glyphs the client alphabet lacks; this swaps the font object when it does.
---@param fontString table
---@param text string
---@param role MDT.UI.FontRole
---@param outline boolean?
function Fonts.SetUserText(fontString, text, role, outline)
  local alphabet = Fonts.FallbackAlphabet(text or "", Fonts.locale)
  local font = alphabet and Fonts.fallbacks[outline and "outline" or "plain"][role][alphabet] or Fonts.Get(role, outline)
  fontString:SetFontObject(font)
  fontString:SetText(text)
end
