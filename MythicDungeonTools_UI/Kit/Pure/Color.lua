local _, MDT = ...
local UI = MDT.UI or {}
MDT.UI = UI

---@class MDT.UI.ColorMath
local Color = {}
UI.Color = Color

---@param hex string "#rrggbb", "rrggbb" or "#rrggbbaa"
---@return MDT.UI.RGBA
function Color.FromHex(hex)
  local digits = hex:gsub("^#", "")
  assert(#digits == 6 or #digits == 8, "Color.FromHex: expected rrggbb or rrggbbaa, got "..hex)
  local r = tonumber(digits:sub(1, 2), 16) / 255
  local g = tonumber(digits:sub(3, 4), 16) / 255
  local b = tonumber(digits:sub(5, 6), 16) / 255
  local a = #digits == 8 and tonumber(digits:sub(7, 8), 16) / 255 or 1
  return { r, g, b, a }
end

---@param c MDT.UI.RGBA
---@return string "rrggbb"
function Color.ToHex(c)
  return string.format("%02x%02x%02x", math.floor(c[1] * 255 + 0.5), math.floor(c[2] * 255 + 0.5), math.floor(c[3] * 255 + 0.5))
end

---@param a MDT.UI.RGBA
---@param b MDT.UI.RGBA
---@param t number 0 keeps a, 1 gives b
---@return MDT.UI.RGBA
function Color.Mix(a, b, t)
  local function lerp(x, y) return x + (y - x) * t end
  return { lerp(a[1], b[1]), lerp(a[2], b[2]), lerp(a[3], b[3]), lerp(a[4] or 1, b[4] or 1) }
end

---@param c MDT.UI.RGBA
---@param amount number 0..1 toward white
---@return MDT.UI.RGBA
function Color.Lighten(c, amount)
  return Color.Mix(c, { 1, 1, 1, c[4] or 1 }, amount)
end

---@param c MDT.UI.RGBA
---@param amount number 0..1 toward black
---@return MDT.UI.RGBA
function Color.Darken(c, amount)
  return Color.Mix(c, { 0, 0, 0, c[4] or 1 }, amount)
end

---@param c MDT.UI.RGBA
---@param alpha number
---@return MDT.UI.RGBA
function Color.WithAlpha(c, alpha)
  return { c[1], c[2], c[3], alpha }
end

---@param c MDT.UI.RGBA
---@param text string
---@return string text wrapped in a |cffrrggbb escape
function Color.Escape(c, text)
  return "|cff"..Color.ToHex(c)..text.."|r"
end
