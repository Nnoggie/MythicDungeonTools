local _, MDT = ...
local UI = MDT.UI or {}
MDT.UI = UI

---One item model for dropdowns, button menus, context menus and the route switcher.
---@class MDT.UI.MenuModelMath
local MenuModel = {}
UI.MenuModel = MenuModel

local function text(value)
  if value == nil then return "" end
  return tostring(value)
end

local function signature(item, checked)
  return table.concat({
    item.kind, text(item.text), text(item.detail), text(item.trailing), text(item.icon),
    checked and "1" or "0", item.disabled and "1" or "0",
  }, "\1")
end

---Expands a builder function, drops nil entries, fills defaults (kind, key, checked from `value`),
---and removes separators that would lead, trail or double up, plus titles with nothing under them.
---@param items MDT.UI.MenuItem[]|fun(): MDT.UI.MenuItem[]
---@param value any? the dropdown's current value, compared with choice items
---@return MDT.UI.ListItem[]
function MenuModel.Normalize(items, value)
  if type(items) == "function" then items = items() end
  local result = {}
  for index, item in ipairs(items) do
    if item then
      local kind = item.kind or "action"
      local checked = item.checked
      if kind == "choice" and value ~= nil then checked = item.value == value end
      local copy = {}
      for k, v in pairs(item) do copy[k] = v end
      copy.kind = kind
      copy.key = item.key ~= nil and item.key or index
      copy.checked = checked
      copy.sig = signature(copy, checked)
      result[#result + 1] = copy
    end
  end
  local cleaned = {}
  for i, item in ipairs(result) do
    local previous = cleaned[#cleaned]
    if item.kind == "separator" then
      if previous and previous.kind ~= "separator" and previous.kind ~= "title" then cleaned[#cleaned + 1] = item end
    elseif item.kind == "title" then
      local nextItem = result[i + 1]
      local hasContent = nextItem and nextItem.kind ~= "separator" and nextItem.kind ~= "title"
      if hasContent then cleaned[#cleaned + 1] = item end
    else
      cleaned[#cleaned + 1] = item
    end
  end
  while #cleaned > 0 and (cleaned[#cleaned].kind == "separator" or cleaned[#cleaned].kind == "title") do
    cleaned[#cleaned] = nil
  end
  return cleaned
end

---Keeps items whose text or detail contains `query`. Titles survive when their group still has hits.
---@param items MDT.UI.MenuItem[]
---@param query string
---@param value any? marks the matching choice as checked
---@return MDT.UI.ListItem[]
function MenuModel.Filter(items, query, value)
  if type(items) == "function" then items = items() end
  if query == nil or query == "" then return MenuModel.Normalize(items, value) end
  local Text = UI.Strings
  local kept = {}
  for _, item in ipairs(items) do
    if item then
      local kind = item.kind or "action"
      if kind == "title" or kind == "separator" then
        kept[#kept + 1] = item
      elseif Text.Matches(text(item.text), query) or Text.Matches(text(item.detail), query) then
        kept[#kept + 1] = item
      end
    end
  end
  return MenuModel.Normalize(kept, value)
end

---@param items MDT.UI.MenuItem[]
---@return boolean ok, string? problem
function MenuModel.Validate(items)
  local kinds = { action = true, choice = true, toggle = true, submenu = true, title = true, separator = true }
  for index, item in ipairs(items) do
    local kind = item.kind or "action"
    if not kinds[kind] then return false, "item "..index..": unknown kind "..tostring(kind) end
    if kind ~= "separator" and item.text == nil then return false, "item "..index..": missing text" end
    if kind == "submenu" and item.items == nil then return false, "item "..index..": submenu without items" end
    if (kind == "action" or kind == "toggle") and item.onSelect == nil then
      return false, "item "..index..": "..kind.." without onSelect"
    end
  end
  return true
end

---Choice items from a value -> label map, in `order` when given, else sorted by label.
---@param map table<any, string>
---@param order any[]?
---@return MDT.UI.MenuItem[]
function MenuModel.FromList(map, order)
  local keys = {}
  if order then
    for _, key in ipairs(order) do keys[#keys + 1] = key end
  else
    for key in pairs(map) do keys[#keys + 1] = key end
    table.sort(keys, function(a, b) return tostring(map[a]) < tostring(map[b]) end)
  end
  local items = {}
  for _, key in ipairs(keys) do
    items[#items + 1] = { kind = "choice", value = key, text = tostring(map[key]), key = key }
  end
  return items
end

---Label of the choice whose value matches, or nil.
---@param items MDT.UI.MenuItem[]
---@param value any
---@return string?
function MenuModel.LabelFor(items, value)
  for _, item in ipairs(items) do
    if item and (item.kind or "action") == "choice" and item.value == value then return item.text end
  end
  return nil
end
