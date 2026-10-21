-- Minimal XML parser for WoW UI files: elements, attributes, text, comments, CDATA.
local XML = {}

local entities = { lt = "<", gt = ">", amp = "&", quot = '"', apos = "'" }

local function decode(text)
  return (text:gsub("&(#?x?%w+);", function(entity)
    if entities[entity] then return entities[entity] end
    local hex = entity:match("^#x(%x+)$")
    if hex then return string.char(tonumber(hex, 16) % 256) end
    local dec = entity:match("^#(%d+)$")
    if dec then return string.char(tonumber(dec) % 256) end
    return "&"..entity..";"
  end))
end

local function parseAttributes(source)
  local attributes = {}
  for key, quote, value in source:gmatch("([%w_:%.%-]+)%s*=%s*([\"'])(.-)%2") do
    attributes[key] = decode(value)
  end
  return attributes
end

function XML.parse(source, path)
  source = source:gsub("^\239\187\191", "")
  local root = { tag = "#document", attrs = {}, children = {}, text = "" }
  local stack = { root }
  local position = 1
  local length = #source
  while position <= length do
    local open = source:find("<", position, true)
    local current = stack[#stack]
    if not open then
      current.text = current.text..decode(source:sub(position))
      break
    end
    if open > position then current.text = current.text..decode(source:sub(position, open - 1)) end
    if source:sub(open, open + 3) == "<!--" then
      local close = source:find("-->", open + 4, true)
      if not close then error(path..": unterminated comment") end
      position = close + 3
    elseif source:sub(open, open + 8) == "<![CDATA[" then
      local close = source:find("]]>", open + 9, true)
      if not close then error(path..": unterminated CDATA") end
      current.text = current.text..source:sub(open + 9, close - 1)
      position = close + 3
    elseif source:sub(open, open + 1) == "<?" or source:sub(open, open + 1) == "<!" then
      local close = source:find(">", open, true)
      position = close + 1
    elseif source:sub(open, open + 1) == "</" then
      local close = source:find(">", open, true)
      local tag = source:sub(open + 2, close - 1):match("^%s*([%w_:%.%-]+)")
      if current.tag ~= tag then
        error(string.format("%s: mismatched closing tag </%s>, expected </%s>", path, tostring(tag), current.tag))
      end
      stack[#stack] = nil
      position = close + 1
    else
      local close = open
      local quote
      repeat
        close = close + 1
        local char = source:sub(close, close)
        if char == "" then error(path..": unterminated tag") end
        if quote then
          if char == quote then quote = nil end
        elseif char == '"' or char == "'" then
          quote = char
        end
      until char == ">" and not quote
      local body = source:sub(open + 1, close - 1)
      local selfClosing = body:sub(-1) == "/"
      if selfClosing then body = body:sub(1, -2) end
      local tag, rest = body:match("^%s*([%w_:%.%-]+)(.*)$")
      if not tag then error(path..": malformed tag near "..body:sub(1, 40)) end
      local node = { tag = tag, attrs = parseAttributes(rest), children = {}, text = "", parent = current }
      current.children[#current.children + 1] = node
      if not selfClosing then stack[#stack + 1] = node end
      position = close + 1
    end
  end
  if #stack > 1 then error(path..": unclosed element <"..stack[#stack].tag..">") end
  return root
end

function XML.attr(node, name)
  local wanted = name:lower()
  for key, value in pairs(node.attrs) do
    if key:lower() == wanted then return value end
  end
end

function XML.child(node, tag)
  local wanted = tag:lower()
  for _, child in ipairs(node.children) do
    if child.tag:lower() == wanted then return child end
  end
end

return XML
