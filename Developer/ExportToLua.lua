local MDT = MDT
local slen = string.len

-- The purpose of these functions is to provide a much better way to export the dungeon data to lua format.
-- Using the tShow function from Devpanel.lua does not work well because index and field orders are not
-- preserved. The resulting data would always be in random order and even small changes in the data cause
-- the export to be completely different.
-- We want instead to have a consistent way to export the dungeon data to lua that makes versioning easier.
-- If something like x and y position chang then only those values will change in the otherwise identical
-- dungeon data string representation. This will make it easier to compare dungeon data between versions.

function MDT:ExportString(export)
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

function MDT:VerifyExportString(luaCode, originalTable)
  local func, loadError = loadstring(luaCode)
  if not func then
    print("MDT:VerifyExportString: Load Error: " .. loadError)
    return false
  end
  local success, funcError = pcall(func);
  if not success then
    print("MDT:VerifyExportString: Func Error: " .. funcError)
    return false
  end
  local exportTable = func()
  if not exportTable then return false end
  local isSame = tCompare(exportTable, originalTable, 100)
  if not isSame then
    print("MDT:VerifyExportString: Export is not the same as the original table.")
  end
  return isSame
end

local exportSchema = {
  poi = {
    "y",
    "x",
    "scale",
    "weeks",
    "template",
    "type",
    "target",
    "direction",
    "connectionIndex",
    "graveyardDescription",
    "npcId",
    "index",
    "tooltipText",
    "text",
    "formattedText",
    "formattedDoorDescription",
    "season",
    "difficulty",
    "doorDescription",
    "lockpick",
    "doorName",
    "botTypeIndex",
    "botType",
    "textAnchorTo",
    "textAnchor",
  },
  enemies = {

  },
}

-- make sure that every possible field in the data is tracked in the schema
local function verifySchema(schema)
  local fields = {}
  for dungeonIndex = 1, 50 do
    local poiTable = MDT.mapPOIs[dungeonIndex]
    if poiTable then
      for sublevel, pois in pairs(poiTable) do
        for poiIndex, poi in pairs(pois) do
          for field, value in pairs(poi) do
            if not fields[field] then
              fields[field] = true
            end
          end
        end
      end
    end
  end
  local schemaFieldLookup = {}
  for index, field in ipairs(schema) do
    schemaFieldLookup[field] = true
  end
  local valid = true
  local extraFields = {}
  for field, _ in pairs(fields) do
    if not schemaFieldLookup[field] then
      valid = false
      table.insert(extraFields, field)
    end
  end
  if not valid then
    print("MDT:VerifyExportString: Schema is not valid. Extra fields: " .. table.concat(extraFields, ", "))
  end
  return valid
end

function MDT:CreatePOIToLuaExportString(dungeonIndex)
  local poiTable = MDT.mapPOIs[dungeonIndex]
  if not poiTable then return end
  if not verifySchema(exportSchema.poi) then return end
  local res = "MDT.mapPOIs[dungeonIndex] = {\n"
  local numSublevels = #(MDT.dungeonSubLevels[dungeonIndex])

  --iterate over sublevels, is nonIndexed array
  for subLevelIdx = 1, numSublevels do
    local poiSublevel = poiTable[subLevelIdx]
    if poiSublevel then
      res = res .. "  [" .. subLevelIdx .. "] = {\n"
      -- poiSublevel is a table of poi's, is indexed array
      for poiIndex, poi in ipairs(poiSublevel) do
        res = res .. "    [" .. poiIndex .. "] = {\n"
        -- poi is a table of poi data, is nonIndexed array
        for fieldIndex, field in ipairs(exportSchema.poi) do
          local value = poi[field]
          if value then
            local valueType = type(value)
            res = res .. "      " .. field .. " = "
            if valueType == "table" then
              res = res .. "{\n"
              for i = 1, 12 do
                if value[i] then
                  -- could do recursion here but cba
                  local indexedValue = ""
                  if type(value[i]) == "string" then
                    if value[i] == "\n" then
                      indexedValue = [["]] .. "\\n" .. [["]]
                    else
                      indexedValue = [["]] .. value[i] .. [["]]
                    end
                  else
                    indexedValue = tostring(value[i])
                  end
                  res = res .. "        [" .. i .. "] = " .. indexedValue .. ",\n"
                end
              end
              res = res .. "      },\n"
            elseif valueType == "string" then
              res = res .. "\"" .. value .. "\",\n"
            else
              res = res .. "" .. tostring(value) .. ",\n"
            end
          end
        end
        res = res .. "    },\n"
      end
      res = res .. "  },\n"
    end
  end
  res = res .. "}"
  return res
end

function MDT:TestPOIToLuaExport()
  local testResult = ""
  for i = 1, 100 do
    local res
    local dungeonName = MDT:GetDungeonName(i)
    if dungeonName and dungeonName ~= "-" then
      local export = MDT:CreatePOIToLuaExportString(i)
      if export then
        if MDT:VerifyExportString("return" .. strsub(export, 28), MDT.mapPOIs[i]) then
          res = i .. ": " .. dungeonName .. ": verified"
        end
      else
        res = i .. ": " .. dungeonName .. ": No POI Data"
      end
    end
    if res then
      testResult = testResult .. res .. "\n"
    end
  end
  MDT:ExportString(testResult)
end
