local _, MDT = ...
local UI = MDT.UI
local Color = UI.Color

---Tokens own every color, spacing, size and font role. Consumers name tokens, never literals.
---@class MDT.UI.ThemeApi
local Theme = {}
UI.Theme = Theme

---@type MDT.UI.ThemeData
Theme.data = {
  color = {
    ["bg.panel"] = "111113", ["bg.sunken"] = "0b0b0c", ["bg.raised"] = "17171a", ["bg.raised2"] = "1b1b1f",
    ["bg.overlay"] = "141417", ["bg.dim"] = "00000099",
    -- White washes over whatever is behind a borderless control, matching the navigation sidebar's hover and active.
    ["bg.hoverTint"] = "ffffff14", ["bg.selectedTint"] = "ffffff24",
    ["border.normal"] = "2b2b30", ["border.strong"] = "303036", ["border.divider"] = "1f1f23",
    ["text.normal"] = "e9e6e1", ["text.secondary"] = "cfcac2", ["text.muted"] = "8e8a84", ["text.disabled"] = "55534f", ["text.inverse"] = "111113",
    ["accent"] = "ffffff", ["accent.bg"] = "26262b", ["accent.border"] = "4a4a52", ["accent.active"] = "ffffff80",
    ["ok"] = "5ee07a", ["ok.line"] = "2d5a36", ["bar.progress"] = "2f5fc4", ["bar.ok"] = "2e8f4a", ["bar.warn"] = "8e3540", ["warn"] = "ff6b5b", ["live"] = "ff4b4b", ["live.bg"] = "3a1416",
    ["danger.bg"] = "3a1416", ["danger.border"] = "5a2626",
  },
  derived = {
    ["bg.hover"] = { "bg.raised2", "lighten", 0.08 },
    ["bg.pressed"] = { "bg.raised", "darken", 0.04 },
    ["bg.selected"] = { "bg.raised", "mix", 0.08, "accent" },
    ["accent.bgHover"] = { "accent.bg", "lighten", 0.08 },
    ["danger.bgHover"] = { "danger.bg", "lighten", 0.08 },
  },
  space = { xs = 2, sm = 4, md = 8, lg = 12, xl = 16 },
  size = { sm = 22, md = 26, lg = 30, row = 28 },
  font = {
    body = { size = 12 }, small = { size = 10 }, title = { size = 15 }, heading = { size = 13 }, number = { size = 12 }, display = { size = 20 },
    -- One size down, for tooltip-like popups.
    bodyCompact = { size = 11 }, smallCompact = { size = 9 }, titleCompact = { size = 14 },
  },
  skin = {
    default = {
      normal = { bg = "bg.raised", border = "border.normal", text = "text.normal" },
      hover = { bg = "bg.hover", border = "border.strong", text = "text.normal" },
      pressed = { bg = "bg.pressed", border = "border.strong", text = "text.normal" },
      selected = { bg = "bg.selected", border = "accent", text = "accent" },
      disabled = { bg = "bg.raised", border = "border.normal", text = "text.disabled" },
    },
    primary = {
      normal = { bg = "accent.bg", border = "accent.border", text = "accent" },
      hover = { bg = "accent.bgHover", border = "accent", text = "accent" },
      pressed = { bg = "accent.bg", border = "accent", text = "accent" },
      selected = { bg = "accent", border = "accent", text = "text.inverse" },
      disabled = { bg = "bg.raised", border = "border.normal", text = "text.disabled" },
    },
    danger = {
      normal = { bg = "danger.bg", border = "danger.border", text = "warn" },
      hover = { bg = "danger.bgHover", border = "warn", text = "warn" },
      pressed = { bg = "danger.bg", border = "warn", text = "warn" },
      selected = { bg = "danger.bgHover", border = "warn", text = "warn" },
      disabled = { bg = "bg.raised", border = "border.normal", text = "text.disabled" },
    },
    ghost = {
      normal = { bg = false, border = false, text = "text.muted" },
      hover = { bg = "bg.hoverTint", border = false, text = "text.normal" },
      pressed = { bg = "bg.raised", border = false, text = "text.normal" },
      selected = { bg = "bg.selectedTint", border = false, text = "accent" },
      disabled = { bg = false, border = false, text = "text.disabled" },
    },
    -- Never a background or border: the caller shows hover itself (stepper arrows).
    bare = {
      normal = { bg = false, border = false, text = "text.muted" },
      hover = { bg = false, border = false, text = "accent" },
      pressed = { bg = false, border = false, text = "accent" },
      selected = { bg = false, border = false, text = "accent" },
      disabled = { bg = false, border = false, text = "text.disabled" },
    },
    -- Borderless icon buttons that stay at full brightness: the map toolbar and the bottom bar links.
    plain = {
      normal = { bg = false, border = false, text = "text.normal" },
      hover = { bg = "bg.hoverTint", border = false, text = "accent" },
      pressed = { bg = "bg.raised", border = false, text = "accent" },
      selected = { bg = "bg.selectedTint", border = false, text = "accent" },
      disabled = { bg = false, border = false, text = "text.disabled" },
    },
    window = {
      normal = { bg = "bg.raised2", border = "border.strong", text = "text.normal" },
      hover = { bg = "bg.hover", border = "accent.border", text = "accent" },
      pressed = { bg = "bg.pressed", border = "accent", text = "accent" },
      selected = { bg = "accent.bg", border = "accent", text = "accent" },
      disabled = { bg = false, border = "border.divider", text = "text.disabled" },
    },
    icon = {
      normal = { bg = "bg.raised2", border = "border.normal", text = "text.normal" },
      hover = { bg = "bg.hover", border = "border.strong", text = "text.normal" },
      pressed = { bg = "bg.pressed", border = "border.strong", text = "text.normal" },
      selected = { bg = "bg.selected", border = "accent", text = "accent" },
      disabled = { bg = "bg.raised2", border = "border.normal", text = "text.disabled" },
    },
    field = {
      normal = { bg = "bg.sunken", border = "border.strong", text = "text.normal" },
      hover = { bg = "bg.sunken", border = "border.strong", text = "text.normal" },
      pressed = { bg = "bg.sunken", border = "accent", text = "text.normal" },
      selected = { bg = "bg.sunken", border = "accent", text = "text.normal" },
      disabled = { bg = "bg.sunken", border = "border.normal", text = "text.disabled" },
    },
    row = {
      normal = { bg = false, border = false, text = "text.normal" },
      hover = { bg = "bg.hoverTint", border = false, text = "text.normal" },
      pressed = { bg = "bg.raised", border = false, text = "text.normal" },
      selected = { bg = "bg.selectedTint", border = "accent", text = "text.normal" },
      disabled = { bg = false, border = false, text = "text.disabled" },
    },
  },
  border = 1,
  alpha = { disabled = 0.45, dragSource = 0.35 },
  motion = { commitDelay = 0.4, dragScrollMax = 600, dragEdge = 24, submenuDelay = 0.15 },
}

---@type table<string, MDT.UI.RGBA>
local resolved = {}

---@param data MDT.UI.ThemeData
---@return table<string, MDT.UI.RGBA>
local function resolveAll(data)
  local out = {}
  for token, hex in pairs(data.color) do out[token] = Color.FromHex(hex) end
  for token, rule in pairs(data.derived) do
    local base = out[rule[1]] or error("Theme: derived token "..token.." uses unknown base "..tostring(rule[1]))
    if rule[2] == "lighten" then out[token] = Color.Lighten(base, rule[3])
    elseif rule[2] == "darken" then out[token] = Color.Darken(base, rule[3])
    elseif rule[2] == "mix" then
      local other = out[rule[4]] or error("Theme: derived token "..token.." mixes toward unknown token "..tostring(rule[4]))
      out[token] = Color.Mix(base, other, rule[3])
    else
      error("Theme: unknown derivation "..tostring(rule[2]).." for "..token)
    end
  end
  return out
end
Theme.ResolveAll = resolveAll
resolved = resolveAll(Theme.data)

---@param token MDT.UI.Color
---@return number r, number g, number b, number a
function Theme.Resolve(token)
  if type(token) == "table" then return token[1], token[2], token[3], token[4] or 1 end
  local c = resolved[token]
  if not c then error("Theme: unknown color token "..tostring(token), 2) end
  return c[1], c[2], c[3], c[4]
end

---@param token MDT.UI.Color
---@return MDT.UI.RGBA
function Theme.Rgba(token)
  return { Theme.Resolve(token) }
end

---@param space MDT.UI.Space|number|nil
---@return number
function Theme.Space(space)
  if space == nil then return 0 end
  if type(space) == "number" then return space end
  return Theme.data.space[space] or error("Theme: unknown space token "..tostring(space), 2)
end

---@param size MDT.UI.ControlSize|number
---@return number
function Theme.Size(size)
  if type(size) == "number" then return size end
  return Theme.data.size[size] or error("Theme: unknown size token "..tostring(size), 2)
end

---@param variant MDT.UI.Variant
---@param state MDT.UI.State
---@return MDT.UI.SkinRow
function Theme.Skin(variant, state)
  local rows = Theme.data.skin[variant] or error("Theme: unknown variant "..tostring(variant), 2)
  return rows[state] or rows.normal
end

---@type table<table, MDT.UI.Color>
local bound = setmetatable({}, { __mode = "k" })

local function apply(region, token)
  local r, g, b, a = Theme.Resolve(token)
  if region:IsObjectType("FontString") or region:IsObjectType("EditBox") then
    region:SetTextColor(r, g, b, a)
  else
    region:SetColorTexture(r, g, b, a)
  end
end

---Colors a texture or font string from a token and remembers the binding so Theme.Set can re-apply it.
---@param region table Texture or FontString
---@param token MDT.UI.Color
function Theme.Bind(region, token)
  bound[region] = token
  apply(region, token)
end

---Replaces the token data and re-applies every bound region. No frame walk.
---@param data MDT.UI.ThemeData
function Theme.Set(data)
  Theme.data = data
  resolved = resolveAll(data)
  for region, token in pairs(bound) do apply(region, token) end
  if UI.Pixel then UI.Pixel.Refresh() end
end
