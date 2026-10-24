local _, MDT = ...
local UI = MDT.UI or {}
MDT.UI = UI

---UTF-8 string helpers. UI.Text is the control; this is the math behind it.
---@class MDT.UI.Strings
local Text = {}
UI.Strings = Text

local byte = string.byte

---Decodes one UTF-8 sequence starting at byte `i`.
---@return integer codepoint, integer nextIndex
local function decode(s, i)
  local c = byte(s, i)
  if c < 0x80 then return c, i + 1 end
  if c < 0xE0 then return (c % 0x20) * 0x40 + (byte(s, i + 1) or 0x80) % 0x40, i + 2 end
  if c < 0xF0 then
    return ((c % 0x10) * 0x40 + (byte(s, i + 1) or 0x80) % 0x40) * 0x40 + (byte(s, i + 2) or 0x80) % 0x40, i + 3
  end
  return (((c % 0x08) * 0x40 + (byte(s, i + 1) or 0x80) % 0x40) * 0x40 + (byte(s, i + 2) or 0x80) % 0x40) * 0x40
    + (byte(s, i + 3) or 0x80) % 0x40, i + 4
end

---@param cp integer
---@return "cyrillic"|"hangul"|"cjk"|nil
local function alphabetOf(cp)
  if cp >= 0x0400 and cp <= 0x052F then return "cyrillic" end
  if (cp >= 0x1100 and cp <= 0x11FF) or (cp >= 0x3130 and cp <= 0x318F) or (cp >= 0xAC00 and cp <= 0xD7AF) then
    return "hangul"
  end
  if (cp >= 0x2E80 and cp <= 0x9FFF) or (cp >= 0xF900 and cp <= 0xFAFF) or (cp >= 0xFF00 and cp <= 0xFFEF) then
    return "cjk"
  end
  return nil
end

---First non-roman alphabet found in the string; "roman" when every glyph is Latin.
---@param text string
---@return "roman"|"cyrillic"|"hangul"|"cjk"
function Text.Alphabet(text)
  local i, n = 1, #text
  while i <= n do
    local cp, nextIndex = decode(text, i)
    local found = alphabetOf(cp)
    if found then return found end
    i = nextIndex
  end
  return "roman"
end

---@param text string
---@return integer
function Text.Length(text)
  local count, i, n = 0, 1, #text
  while i <= n do
    local _, nextIndex = decode(text, i)
    count, i = count + 1, nextIndex
  end
  return count
end

---Cuts after `maxChars` code points and appends `ellipsis` when something was cut.
---@param text string
---@param maxChars integer
---@param ellipsis string? default "..."
---@return string
function Text.Truncate(text, maxChars, ellipsis)
  local count, i, n = 0, 1, #text
  while i <= n do
    if count == maxChars then return text:sub(1, i - 1)..(ellipsis or "...") end
    local _, nextIndex = decode(text, i)
    count, i = count + 1, nextIndex
  end
  return text
end

---Case-insensitive plain substring match (ASCII case folding).
---@param text string
---@param query string
---@return boolean
function Text.Matches(text, query)
  return text:lower():find(query:lower(), 1, true) ~= nil
end
