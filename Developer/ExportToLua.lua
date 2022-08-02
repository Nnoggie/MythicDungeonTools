local MDT = MDT
local slen = string.len

-- The purpose of these functions is to provide a much better way to export the dungeon data to lua format.
-- Using the tShow function from Devpanel.lua does not work well because index and field orders are not
-- preserved. The resulting data would always be in random order and even small changes in the data cause
-- the export to be completely different.
-- We want to instead have a consistent way to export the dungeon data to lua that makes versioning easier.
-- If for example x and y position change then only those values will change in the otherwise identical
-- dungeon data string representation. This will make it easier to compare dungeon data between versions.

function MDT:ExportString(export)
  if not export then return end
  MDT:ShowInterface(true)
  local exportFrame = MDT.main_frame.ExportFrame
  local editBox = MDT.main_frame.ExportFrameEditbox
  exportFrame:ClearAllPoints()
  exportFrame:Show()
  exportFrame:SetPoint("CENTER", MDT.main_frame, "CENTER", 0, 50)
  editBox:SetText(export)
  editBox:HighlightText(0, slen(export))
  editBox:SetFocus()
end

--https://www.lua.org/pil/19.3.html
local function pairsByKeys(t, f)
  local a = {}
  for n in pairs(t) do table.insert(a, n) end
  table.sort(a, f)
  local i = 0 -- iterator variable
  local iter = function() -- iterator function
    i = i + 1
    if a[i] == nil then return nil
    else return a[i], t[a[i]]
    end
  end
  return iter
end

local function getIndent(indentCount)
  local indent = ""
  for i = 1, indentCount do
    indent = indent .. "  " --indent with 2 spaces
  end
  return indent
end

local function recursiveExport(obj, schema, indentCount)
  local res = ""
  local actualObjectType = type(obj)
  if schema.type == "schemaArray" then
    res = res .. "{\n"
    for _, field in ipairs(schema.fields) do
      if obj[field.name] then
        res = res .. getIndent(indentCount + 1) .. "[\"" .. field.name .. "\"] = "
        res = res .. recursiveExport(obj[field.name], field, indentCount + 1)
      end
    end
    return res .. getIndent(indentCount) .. "};\n"
  elseif schema.type == "array" then
    res = res .. "{\n"
    for fieldName, value in pairsByKeys(obj) do
      local fieldNameType = type(fieldName)
      local maybeEscapedQuote = fieldNameType == "string" and "\"" or ""
      res = res .. getIndent(indentCount + 1) .. "[" .. maybeEscapedQuote .. fieldName .. maybeEscapedQuote .. "] = "
      res = res .. recursiveExport(value, schema.fields, indentCount + 1)
    end
    return res .. getIndent(indentCount) .. "};\n"
  elseif actualObjectType ~= schema.type then
    return "\"TYPEERROR: " .. schema.type .. " expected, " .. actualObjectType .. " found\";\n"
  elseif schema.type == "string" then
    return "\"" .. obj .. "\";\n"
  else
    return tostring(obj) .. ";\n"
  end
end

function MDT:ExportLuaTable(obj, schema)
  if not obj then
    print("MDT: ExportLuaTable: obj is nil")
    return
  end
  return (schema.name or "local table") .. " = " .. recursiveExport(obj, schema, 0)
end
