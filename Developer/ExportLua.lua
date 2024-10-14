local MDT = MDT
local slen = string.len

-- The purpose of these functions is to provide a much better way to export the dungeon data to lua format.
-- Using the tShow function from Devpanel.lua does not work well because index and field orders are not
-- preserved. The resulting data would always be in random order and even small changes in the data cause
-- the export to be completely different.
-- We want to instead have a consistent way to export the dungeon data that makes versioning easier.
-- If for example x and y position change then only those values will change in the otherwise identical
-- dungeon data string representation. This will make it easier to compare dungeon data between versions.

--- @param export string
function MDT:ExportString(export)
  if not export then return end
  MDT:Async(function()
    MDT:ShowInterfaceInternal(true)
    local exportFrame = MDT.main_frame.ExportFrame
    local editBox = MDT.main_frame.ExportFrameEditbox
    exportFrame:ClearAllPoints()
    exportFrame:Show()
    exportFrame:SetPoint("CENTER", MDT.main_frame, "CENTER", 0, 50)
    editBox:SetText(export)
    editBox:HighlightText(0, slen(export))
    editBox:SetFocus()
    MDT.copyHelper:SmartShow(MDT.main_frame, 0, 50)
  end, "exportString")
end

--https://www.lua.org/pil/19.3.html
local function pairsByKeys(t, f)
  local a = {}
  for n in pairs(t) do table.insert(a, n) end
  table.sort(a, f)
  local i = 0             -- iterator variable
  local iter = function() -- iterator function
    i = i + 1
    if a[i] == nil then
      return nil
    else
      return a[i], t[a[i]]
    end
  end
  return iter
end

local function getIndent(indentCount)
  local indent = ""
  for i = 1, indentCount do
    indent = indent.."  " --indent with 2 spaces
  end
  return indent
end

local function recursiveExport(obj, schema, indentCount)
  local res = ""
  local actualObjectType = type(obj)
  if schema.type == "schemaArray" then
    if actualObjectType ~= "table" then
      print("MDT recursiveExport: Error in "..schema.name..": Expected table, got "..actualObjectType.." (field: "..schema.name.."; value: "..tostring(obj)..")")
      return "\"Error: Expected table, got "..actualObjectType.." (value: "..tostring(obj)..")\";\n"
    end
    res = res.."{\n"
    for _, field in ipairs(schema.fields) do
      if obj[field.name] then
        res = res..getIndent(indentCount + 1).."[\""..field.name.."\"] = "
        res = res..recursiveExport(obj[field.name], field, indentCount + 1)
      end
    end
    --handle non schema fields
    for key, value in pairs(obj) do
      local keyExists = false
      for _, field in ipairs(schema.fields) do
        if field.name == key then
          keyExists = true
        end
      end
      if not keyExists then
        local valueType
        valueType = type(value)
        if valueType == "table" then
          valueType = "array"
        end
        print("MDT recursiveExport: Error: Non schema field "..key.." of type "..valueType.." in "..(schema.name or "unnamed schema").." (field: "..key.."; value: "..tostring(value)..")")
        res = res..getIndent(indentCount + 1).."[\""..key.."\"] = "
        res = res..recursiveExport(value, { type = valueType }, indentCount + 1)
      end
    end
    return res..getIndent(indentCount).."};\n"
  elseif schema.type == "array" then
    if actualObjectType ~= "table" then
      print("MDT recursiveExport: Error: Expected table, got "..actualObjectType.." (value: "..tostring(obj)..")")
      return "\"Error: Expected table, got "..actualObjectType.." (value: "..tostring(obj)..")\";\n"
    end
    res = res.."{\n"
    for fieldName, value in pairsByKeys(obj) do
      local fieldNameType = type(fieldName)
      local maybeEscapedQuote = fieldNameType == "string" and "\"" or ""
      res = res..getIndent(indentCount + 1).."["..maybeEscapedQuote..fieldName..maybeEscapedQuote.."] = "
      res = res..recursiveExport(value, schema.fields, indentCount + 1)
    end
    return res..getIndent(indentCount).."};\n"
  elseif actualObjectType ~= schema.type then
    print("MDT recursiveExport: Error: Expected "..schema.type..", got "..actualObjectType.." (field: "..schema.name.."; value: "..tostring(obj)..")")
    return "\"TYPEERROR: "..
        schema.type.." expected, "..actualObjectType.." found".." (value: "..tostring(obj)..")\";\n"
  elseif schema.type == "string" then
    if obj == "\n" then
      return "\"\\n\",\n"
    end
    return "\""..obj.."\",\n"
  else
    return tostring(obj)..",\n"
  end
end

function MDT:ExportLuaTable(obj, schema)
  if not obj then
    print("MDT: ExportLuaTable: obj is nil")
    return
  end
  return (schema.name or "local table").." = "..recursiveExport(obj, schema, 0)
end

--- @param target "enemies" | "pois"
--- @param dungeonIndex number
function MDT:TestExport(target, dungeonIndex)
  local schema = MDT:GetSchema(target)
  local dataToExport = (target == "enemies" and MDT.dungeonEnemies) or (target == "pois" and MDT.mapPOIs) or {}
  for i = dungeonIndex or 1, dungeonIndex or 100 do
    local dungeonName = MDT:GetDungeonName(i)
    if dungeonName and dungeonName ~= "-" then
      print(dungeonName)
      local export = MDT:ExportLuaTable(dataToExport[i], schema)
      if dungeonIndex and export then
        MDT:ExportString(export)
      end
      -- see results in chat frame, we don't need to show the data in the export frame
      -- TODO: catch and throw errors with error() and pcall() and show all error details in the export frame
      -- https://stackoverflow.com/questions/35735857/how-do-you-throw-lua-error-up
      -- https://www.lua.org/manual/5.3/manual.html#pdf-error
    end
  end
end

do
  -- call 1: export enemies of dungeon 1
  -- call 2: export pois of dungeon 1
  -- call 3: export enemies of dungeon 2
  -- ...
  local dungeonIndex = 0
  local targetIsEnemies = false
  local startSet = false

  --- @param start number optional dungeonIndex to start from
  function MDT:ExportDungeonDataIncrementally(start)
    targetIsEnemies = not targetIsEnemies
    if targetIsEnemies then
      dungeonIndex = dungeonIndex + 1
    end
    if start and not startSet then
      dungeonIndex = start
      startSet = true
    end
    local dungeonName = MDT:GetDungeonName(dungeonIndex)
    if dungeonName and dungeonName ~= "-" then
      MDT:Async(function()
        MDT:ShowInterfaceInternal(true)
        MDT:UpdateToDungeon(dungeonIndex)
        MDT.main_frame.ExportFrame:Hide()
        local obj = targetIsEnemies and MDT.dungeonEnemies[dungeonIndex] or MDT.mapPOIs[dungeonIndex]
        local schema = MDT:GetSchema(targetIsEnemies and "enemies" or "pois")
        local export = MDT:ExportLuaTable(obj, schema)
        if export then
          MDT:ExportString(export)
        end
      end, "exportIncrementally")
    end
  end
end
