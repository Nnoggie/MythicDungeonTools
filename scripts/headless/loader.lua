-- Loads addons the way the WoW client does: TOC order, nested XML <Script>/<Include>, and
-- (addonName, namespace) varargs per file. Paths resolve inside a virtual Interface/AddOns tree.
return function(W, options)
  local XML = W.XML
  local Loader = { addons = {}, order = {}, filesLoaded = {}, developer = options.developer == true }
  local addons = Loader.addons

  local function readFile(path)
    local file = io.open(path, "rb")
    if not file then return nil end
    local contents = file:read("*a")
    file:close()
    return (contents:gsub("^\239\187\191", ""))
  end

  local function splitPath(path)
    local parts = {}
    for part in path:gsub("\\", "/"):gmatch("[^/]+") do
      if part == ".." then
        if #parts == 0 then error("path escapes Interface/AddOns: "..path) end
        parts[#parts] = nil
      elseif part ~= "." then
        parts[#parts + 1] = part
      end
    end
    return parts
  end

  local function resolve(baseParts, relative)
    local parts = {}
    for _, part in ipairs(baseParts) do parts[#parts + 1] = part end
    local combined = table.concat(parts, "/").."/"..relative:gsub("\\", "/")
    parts = splitPath(combined)
    local addon = addons[parts[1]]
    if not addon then error("file outside known addons: "..combined) end
    local rest = table.concat(parts, "/", 2)
    local display = addon.displayPrefix..rest
    return addon.dir.."/"..rest, display, parts
  end

  local function parentParts(parts)
    local result = {}
    for index = 1, #parts - 1 do result[index] = parts[index] end
    return result
  end

  function Loader.register(name, dir, displayPrefix)
    local tocPath = dir.."/"..name..".toc"
    local source = readFile(tocPath)
    if not source then error("missing TOC "..tocPath) end
    local addon = { name = name, dir = dir, displayPrefix = displayPrefix or "", metadata = {}, files = {}, namespace = {}, enabled = true }
    local skipping = false
    for line in (source.."\n"):gmatch("(.-)\r?\n") do
      line = line:match("^%s*(.-)%s*$")
      if line == "#@do-not-package@" then
        skipping = not Loader.developer
      elseif line == "#@end-do-not-package@" then
        skipping = false
      elseif line:match("^##") then
        local key, value = line:match("^##%s*([^:]+):%s*(.-)%s*$")
        if key then addon.metadata[key:lower()] = value end
      elseif line ~= "" and not line:match("^#") and not skipping then
        local path, condition = line:match("^(.-)%s*%[([^%]]+)%]$")
        if not path then path = line end
        local allowed = true
        if condition and condition:match("^AllowLoad") then
          allowed = condition:lower():find("mainline", 1, true) ~= nil or condition:lower():find("standard", 1, true) ~= nil
        end
        if allowed then addon.files[#addon.files + 1] = path end
      end
    end
    addons[name] = addon
    Loader.order[#Loader.order + 1] = name
    return addon
  end

  local loadXML

  local function runLua(addon, realPath, display, inlineSource)
    local source = inlineSource or readFile(realPath)
    if not source then
      W.errorHandler("Couldn't open "..display)
      return
    end
    local chunk, compileError = loadstring(source, "@"..display)
    if not chunk then
      W.errorHandler(compileError)
      return
    end
    Loader.filesLoaded[#Loader.filesLoaded + 1] = display
    W.protectedCall(chunk, addon.name, addon.namespace)
  end

  local function loadFont(node)
    local name = XML.attr(node, "name")
    local font = W.CreateFont(name)
    local inherits = XML.attr(node, "inherits")
    if inherits and rawget(_G, inherits) then font:CopyFontObject(rawget(_G, inherits)) end
    local file, height = XML.attr(node, "font"), tonumber(XML.attr(node, "height"))
    if file then font:SetFont(file, height or 12, XML.attr(node, "outline") or "") end
  end

  local function loadNode(addon, node, baseParts, display)
    local tag = node.tag
    if tag == "Script" then
      local file = XML.attr(node, "file")
      if file then
        local real, fileDisplay = resolve(baseParts, file)
        runLua(addon, real, fileDisplay)
      elseif node.text:match("%S") then
        runLua(addon, nil, display..":inline", node.text)
      end
    elseif tag == "Include" then
      local real, fileDisplay, parts = resolve(baseParts, XML.attr(node, "file"))
      loadXML(addon, real, fileDisplay, parentParts(parts))
    elseif tag == "Font" then
      loadFont(node)
    elseif W.frameTags[tag] then
      W.protectedCall(W.registerXMLFrame, node, display)
    end
  end

  loadXML = function(addon, realPath, display, baseParts)
    local source = readFile(realPath)
    if not source then
      W.errorHandler("Couldn't open "..display)
      return
    end
    Loader.filesLoaded[#Loader.filesLoaded + 1] = display
    local ok, document = pcall(XML.parse, source, display)
    if not ok then
      W.errorHandler(document)
      return
    end
    for _, root in ipairs(document.children) do
      for _, node in ipairs(root.children) do loadNode(addon, node, baseParts, display) end
    end
  end

  local function loadFiles(addon)
    for _, file in ipairs(addon.files) do
      local real, display, parts = resolve({ addon.name }, file)
      if display:lower():match("%.xml$") then
        loadXML(addon, real, display, parentParts(parts))
      else
        runLua(addon, real, display)
      end
    end
  end

  function Loader.load(name)
    local addon = addons[name]
    if not addon then return false, "MISSING" end
    if addon.loaded or addon.loading then return true end
    if not addon.enabled then return false, "DISABLED" end
    local dependencies = addon.metadata.dependencies or addon.metadata.requireddeps or ""
    for dependency in dependencies:gmatch("[^,%s]+") do
      local ok, reason = Loader.load(dependency)
      if not ok then return false, "DEP_"..tostring(reason) end
    end
    addon.loading = true
    loadFiles(addon)
    addon.loading, addon.loaded = nil, true
    W.FireEvent("ADDON_LOADED", name, false)
    return true
  end

  local function addonByIndexOrName(value)
    if type(value) == "number" then return addons[Loader.order[value]] end
    return addons[value]
  end

  -- Reports texture paths inside known addons that resolve to no file (the client would draw nothing).
  W.missingFiles, W.missingFileOrder = {}, {}
  local extensions = { "", ".tga", ".blp", ".png", ".jpg" }
  function W.checkAddonFile(path)
    local addonName, rest = path:gsub("\\", "/"):match("^[Ii]nterface/[Aa]dd[Oo]ns/([^/]+)/(.+)$")
    local addon = addonName and addons[addonName]
    if not addon then return end
    for _, extension in ipairs(extensions) do
      local file = io.open(addon.dir.."/"..rest..extension, "rb")
      if file then file:close() return end
    end
    local entry = W.missingFiles[path]
    if not entry then
      entry = { name = path, count = 0, site = W.callSite() }
      W.missingFiles[path] = entry
      W.missingFileOrder[#W.missingFileOrder + 1] = path
    end
    entry.count = entry.count + 1
  end

  _G.C_AddOns = {
    GetAddOnMetadata = function(name, key)
      W.usage(type(key) == "string", "GetAddOnMetadata(): field must be a string")
      local addon = addonByIndexOrName(name)
      return addon and addon.metadata[key:lower()]
    end,
    IsAddOnLoaded = function(name)
      local addon = addonByIndexOrName(name)
      if not addon then return false, false end
      return addon.loaded or addon.loading or false, addon.loaded or false
    end,
    LoadAddOn = function(name) return Loader.load(name) end,
    IsAddOnLoadOnDemand = function(name)
      local addon = addonByIndexOrName(name)
      return addon ~= nil and addon.metadata.loadondemand == "1"
    end,
    GetNumAddOns = function() return #Loader.order end,
    GetAddOnInfo = function(value)
      local addon = addonByIndexOrName(value)
      if not addon then return nil end
      return addon.name, addon.metadata.title, addon.metadata.notes, addon.enabled, addon.enabled and nil or "DISABLED", "INSECURE", false
    end,
    DoesAddOnExist = function(name) return addonByIndexOrName(name) ~= nil end,
    EnableAddOn = function(name) local addon = addonByIndexOrName(name) if addon then addon.enabled = true end end,
    DisableAddOn = function(name) local addon = addonByIndexOrName(name) if addon then addon.enabled = false end end,
    GetAddOnEnableState = function(name) local addon = addonByIndexOrName(name) return addon and addon.enabled and 2 or 0 end,
    IsAddOnLoadable = function(name) return addonByIndexOrName(name) ~= nil end,
    GetAddOnDependencies = function(name)
      local addon = addonByIndexOrName(name)
      local list = {}
      for dependency in (addon and addon.metadata.dependencies or ""):gmatch("[^,%s]+") do list[#list + 1] = dependency end
      return unpack(list)
    end,
  }
  _G.IsAddOnLoaded = _G.C_AddOns.IsAddOnLoaded
  _G.LoadAddOn = _G.C_AddOns.LoadAddOn

  return Loader
end
