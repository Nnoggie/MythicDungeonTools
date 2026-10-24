-- Renders the mocked frame tree to one self-contained HTML page, so a headless browser can screenshot what the
-- harness built. Geometry is resolved here rather than with W.resolveRect because drawing needs what layout
-- queries in the mock skip: SetScale chains, scroll child offsets and the natural size of unsized FontStrings.
-- Not drawn: MaskTexture shapes, Model/ModelScene contents, animations mid-flight, tooltips' line lists,
-- EditBox selection and cursor, texture rotation pivots other than the center.
return function(W)
  local S = W.state

  local strataOrder = {
    WORLD = 1, BACKGROUND = 2, LOW = 3, MEDIUM = 4, HIGH = 5, DIALOG = 6, FULLSCREEN = 7,
    FULLSCREEN_DIALOG = 8, TOOLTIP = 9, BLIZZARD = 10,
  }
  local layerOrder = { BACKGROUND = 1, BORDER = 2, ARTWORK = 3, OVERLAY = 4, HIGHLIGHT = 5 }
  local pointFractions = {
    TOPLEFT = { 0, 1 }, TOP = { 0.5, 1 }, TOPRIGHT = { 1, 1 },
    LEFT = { 0, 0.5 }, CENTER = { 0.5, 0.5 }, RIGHT = { 1, 0.5 },
    BOTTOMLEFT = { 0, 0 }, BOTTOM = { 0.5, 0 }, BOTTOMRIGHT = { 1, 0 },
  }
  -- Client textures that are a plain white square, so vertex color alone decides the fill.
  local solidTextures = {
    ["interface/buttons/white8x8"] = true,
    ["interface/chatframe/chatframebackground"] = true,
    ["interface/tooltips/ui-tooltip-background"] = true,
  }
  local fallbackFonts = "'Arial Narrow', Arial, sans-serif"

  -- Encoding ----------------------------------------------------------------------------------

  local base64Chars = {}
  do
    local alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
    for index = 1, 64 do base64Chars[index - 1] = alphabet:sub(index, index) end
  end
  local function base64(data)
    local out = {}
    for index = 1, #data, 3 do
      local a, b, c = data:byte(index, index + 2)
      local n = a * 65536 + (b or 0) * 256 + (c or 0)
      out[#out + 1] = base64Chars[math.floor(n / 262144)]..base64Chars[math.floor(n / 4096) % 64]
        ..(b and base64Chars[math.floor(n / 64) % 64] or "=")..(c and base64Chars[n % 64] or "=")
    end
    return table.concat(out)
  end

  local function readFile(path)
    local file = io.open(path, "rb")
    if not file then return nil end
    local data = file:read("*a")
    file:close()
    return data
  end

  local function le(value, bytes)
    if value < 0 then value = value + 256 ^ bytes end
    local out = {}
    for index = 1, bytes do
      out[index] = string.char(value % 256)
      value = math.floor(value / 256)
    end
    return table.concat(out)
  end

  -- Browsers cannot show TGA; TGA rows are already BGRA, which a 32-bit bitfield BMP takes verbatim.
  local function tgaToBMP(data)
    if #data < 18 then return nil end
    local idLength, colorMapType, imageType = data:byte(1, 3)
    local width, height = data:byte(13) + data:byte(14) * 256, data:byte(15) + data:byte(16) * 256
    local bits, descriptor = data:byte(17), data:byte(18)
    if colorMapType ~= 0 or (imageType ~= 2 and imageType ~= 10) or (bits ~= 24 and bits ~= 32) then return nil end
    local size, count, position = bits / 8, width * height, 19 + idLength
    local pixels = {}
    local function pixelAt(at)
      if size == 4 then return data:sub(at, at + 3) end
      return data:sub(at, at + 2).."\255"
    end
    if imageType == 2 and size == 4 then
      pixels[1] = data:sub(position, position + count * 4 - 1)
    elseif imageType == 2 then
      for index = 0, count - 1 do pixels[#pixels + 1] = pixelAt(position + index * 3) end
    else
      local written = 0
      while written < count and position <= #data do
        local header = data:byte(position)
        local run = header % 128 + 1
        position = position + 1
        if header >= 128 then
          pixels[#pixels + 1] = pixelAt(position):rep(run)
          position = position + size
        else
          for index = 0, run - 1 do pixels[#pixels + 1] = pixelAt(position + index * size) end
          position = position + run * size
        end
        written = written + run
      end
    end
    local body = table.concat(pixels)
    if #body ~= count * 4 then return nil end
    local topDown = descriptor % 64 >= 32
    local header = table.concat({
      le(108, 4), le(width, 4), le(topDown and -height or height, 4), le(1, 2), le(32, 2), le(3, 4), le(#body, 4),
      le(2835, 4), le(2835, 4), le(0, 4), le(0, 4),
      le(0x00FF0000, 4), le(0x0000FF00, 4), le(0x000000FF, 4), le(0xFF000000, 4), le(0x73524742, 4),
      string.rep("\0", 36), string.rep("\0", 12),
    })
    return "BM"..le(14 + #header + #body, 4)..le(0, 4)..le(14 + #header, 4)..header..body, width, height
  end

  -- Assets are encoded once per run and shared by every page.
  local imageCache, fontCache = {}, {}
  local mimeTypes = { png = "image/png", jpg = "image/jpeg", jpeg = "image/jpeg" }

  local function normalizedPath(path)
    return (path:gsub("\\", "/"):gsub("%.%a%a%a%a?$", ""):lower())
  end

  ---Data URI for a texture path, trying a sibling PNG first; nil when the browser cannot show it.
  local function imageFor(path)
    if imageCache[path] ~= nil then return imageCache[path] or nil end
    local real = W.resolveAddonFile and W.resolveAddonFile(path)
    local uri
    if real then
      local stem = real:gsub("%.%a%a%a%a?$", "")
      local extension = real:match("%.(%a+)$")
      extension = extension and extension:lower()
      for _, candidate in ipairs({ stem..".png", stem..".jpg" }) do
        local data = readFile(candidate)
        if data then
          uri = "data:"..mimeTypes[candidate:match("%.(%a+)$")]..";base64,"..base64(data)
          break
        end
      end
      if not uri and extension == "tga" then
        local bmp = tgaToBMP(readFile(real) or "")
        if bmp then uri = "data:image/bmp;base64,"..base64(bmp) end
      end
    end
    imageCache[path] = uri or false
    return uri
  end

  local function fontFace(path)
    if fontCache[path] ~= nil then return fontCache[path] or nil end
    local real = W.resolveAddonFile and W.resolveAddonFile(path)
    local data = real and readFile(real)
    local face
    if data then
      local format = real:lower():match("%.otf$") and "opentype" or "truetype"
      face = { uri = "data:font/"..(format == "opentype" and "otf" or "ttf")..";base64,"..base64(data), format = format }
    end
    fontCache[path] = face or false
    return face
  end

  local function basename(path)
    return (tostring(path):gsub("\\", "/"):match("([^/]+)$") or tostring(path)):gsub("%.%a%a%a%a?$", "")
  end

  local function escapeHTML(text)
    return (text:gsub("[&<>\"]", { ["&"] = "&amp;", ["<"] = "&lt;", [">"] = "&gt;", ['"'] = "&quot;" }))
  end

  local function num(value)
    return (("%.2f"):format(value):gsub("%.?0+$", ""))
  end

  local function rgba(color, alpha)
    local a = (color[4] or 1) * (alpha or 1)
    return ("rgba(%d,%d,%d,%s)"):format(
      math.floor(math.max(0, math.min(1, color[1] or 1)) * 255 + 0.5),
      math.floor(math.max(0, math.min(1, color[2] or 1)) * 255 + 0.5),
      math.floor(math.max(0, math.min(1, color[3] or 1)) * 255 + 0.5),
      num(math.max(0, math.min(1, a))))
  end

  local function multiply(a, b)
    if not b then return a end
    return { a[1] * b[1], a[2] * b[2], a[3] * b[3], (a[4] or 1) * (b[4] or 1) }
  end

  local function colorOf(value)
    if type(value) ~= "table" then return nil end
    if value.r then return { value.r, value.g, value.b, value.a or 1 } end
    return { value[1], value[2], value[3], value[4] or 1 }
  end

  -- Object state lookups ------------------------------------------------------------------------

  local function effectiveScale(obj)
    local scale, current = 1, obj
    while current do
      local state = S[current]
      scale = scale * (state.scale or 1)
      if state.ignoreParentScale then break end
      current = state.parent
    end
    return scale
  end

  local function effectiveAlpha(obj)
    local alpha, current = 1, obj
    while current do
      local state = S[current]
      alpha = alpha * (state.alpha or 1)
      if state.ignoreParentAlpha then break end
      current = state.parent
    end
    return alpha
  end

  ---A font property from the object itself or the font objects it inherits from.
  local function fontProp(state, key, override)
    local chains = override and { S[override], state } or { state }
    for _, start in ipairs(chains) do
      local current, depth = start, 0
      while current and depth < 16 do
        if current[key] ~= nil then return current[key] end
        current = current.fontObject and S[current.fontObject]
        depth = depth + 1
      end
    end
  end

  -- Text markup -------------------------------------------------------------------------------

  ---Escape-sequence text to HTML; also returns the visible width in font-height units for natural sizing.
  local function markup(text, fontHeight, ctx)
    local out, open, width, longest = {}, 0, 0, 0
    local function newline()
      out[#out + 1] = "<br>"
      longest, width = math.max(longest, width), 0
    end
    local function plain(chunk)
      for piece, breakChar in (chunk.."\0"):gmatch("([^\n%z]*)([\n%z])") do
        if piece ~= "" then
          out[#out + 1] = escapeHTML(piece)
          width = width + #piece * 0.55
        end
        if breakChar == "\n" then newline() end
      end
    end
    local function icon(spec, kind)
      local parts = {}
      for part in (spec..":"):gmatch("([^:]*):") do parts[#parts + 1] = part end
      local height = tonumber(parts[2]) or 0
      if height <= 0 then height = fontHeight end
      local iconWidth = tonumber(parts[3]) or 0
      if iconWidth <= 0 then iconWidth = height end
      local size = ("width:%sem;height:%sem"):format(num(iconWidth / fontHeight), num(height / fontHeight))
      local uri = kind == "T" and imageFor(parts[1])
      if uri then
        out[#out + 1] = ('<i class="ic" style="%s;background-image:url(%s)"></i>'):format(size, ctx.imageClass(parts[1], uri))
      else
        out[#out + 1] = ('<i class="ic ph" style="%s" title="%s"></i>'):format(size, escapeHTML(parts[1]))
      end
      width = width + iconWidth / fontHeight
    end
    local index, length = 1, #text
    while index <= length do
      local bar = text:find("|", index, true)
      if not bar then plain(text:sub(index)) break end
      plain(text:sub(index, bar - 1))
      local code = text:sub(bar + 1, bar + 1)
      index = bar + 2
      if code == "|" then
        plain("|")
      elseif code == "c" then
        local hex = text:match("^%x%x%x%x%x%x%x%x", index)
        if hex then
          out[#out + 1] = ('<span style="color:#%s">'):format(hex:sub(3))
          index = index + 8
        else
          local named = text:match("^n[^:]*:", index)
          out[#out + 1] = "<span>"
          index = index + (named and #named or 0)
        end
        open = open + 1
      elseif code == "r" then
        if open > 0 then
          out[#out + 1] = "</span>"
          open = open - 1
        end
      elseif code == "n" then
        newline()
      elseif code == "T" or code == "A" then
        local close = text:find("|"..(code == "T" and "t" or "a"), index, true)
        icon(text:sub(index, (close or length + 1) - 1), code)
        index = close and close + 2 or length + 1
      elseif code == "H" then
        local close = text:find("|h", index, true)
        index = close and close + 2 or length + 1
      elseif code == "K" then
        local close = text:find("|k", index, true)
        index = close and close + 2 or length + 1
      elseif code ~= "h" and code ~= "k" then
        plain("|"..code)
      end
    end
    out[#out + 1] = string.rep("</span>", open)
    return table.concat(out), math.max(longest, width)
  end

  local function lineCount(text)
    local _, lines = text:gsub("\n", "")
    local _, escaped = text:gsub("|n", "")
    return lines + escaped + 1
  end

  -- Render context ------------------------------------------------------------------------------

  local function newContext(opts)
    local ctx = {
      opts = opts, items = {}, rects = {}, visited = {}, order = 0, classes = {}, classList = {}, fonts = {}, fontList = {},
    }
    ctx.stats = { frames = 0, fills = 0, unresolved = 0, placeholders = 0, images = 0, texts = 0, lines = 0 }
    ctx.unresolvedObjects = {}

    ---A shown object whose anchors lead nowhere: the client would not draw it either.
    function ctx.unresolved(obj)
      ctx.stats.unresolved = ctx.stats.unresolved + 1
      ctx.unresolvedObjects[#ctx.unresolvedObjects + 1] = obj
    end

    function ctx.imageClass(path, uri)
      local name = ctx.classes[path]
      if not name then
        name = "i"..(#ctx.classList + 1)
        ctx.classes[path] = name
        ctx.classList[#ctx.classList + 1] = { name = name, uri = uri }
      end
      return "var(--"..name..")"
    end

    function ctx.fontFamily(path)
      local face = path and fontFace(path)
      if not face then return fallbackFonts end
      local name = ctx.fonts[path]
      if not name then
        name = "f"..(#ctx.fontList + 1)
        ctx.fonts[path] = name
        ctx.fontList[#ctx.fontList + 1] = { name = name, face = face }
      end
      return "'"..name.."', "..fallbackFonts
    end
    return ctx
  end

  -- Geometry ------------------------------------------------------------------------------------

  local function textHeight(state)
    local font = fontProp(state, "font")
    return font and font.height or 12
  end

  -- Natural FontString size in its own units: width from the markup estimate, height from lines (wrapped to width).
  local function naturalTextSize(state, width)
    local text = state.text or ""
    local height = textHeight(state)
    local _, estimate = markup(text, height, { imageClass = function() return "" end })
    local textWidth = estimate * height
    local lines = lineCount(text)
    if width and width > 0 and state.wordWrap ~= false and textWidth > width then
      lines = math.max(lines, math.ceil(textWidth / width))
    end
    if state.maxLines and state.maxLines > 0 then lines = math.min(lines, state.maxLines) end
    return textWidth, lines * height + math.max(0, lines - 1) * (fontProp(state, "spacing") or 0)
  end

  local function solveAxis(constraints, size)
    local low, high, center = constraints[0], constraints[1], constraints[0.5]
    if low and high then return low, high - low, true end
    if not size then
      if low and center then return low, 2 * (center - low), true end
      if high and center then return 2 * center - high, 2 * (high - center), true end
    end
    size = size or 0
    if low then return low, size end
    if high then return high - size, size end
    if center then return center - size / 2, size end
  end

  ---Screen rect {left, bottom, width, height} in UIParent units at scale 1, or nil when anchors don't resolve.
  local function rectOf(ctx, obj, depth)
    local cached = ctx.rects[obj]
    if cached ~= nil then return cached or nil end
    depth = depth or 0
    if depth > 60 then return nil end
    local rect
    if obj == W.UIParent or obj == W.WorldFrame then
      rect = { 0, 0, W.screenWidth, W.screenHeight }
    else
      local state = S[obj]
      local scale = effectiveScale(obj)
      local parent = state.parent
      local isText = state.class.name == "FontString"
      if parent and S[parent].scrollChild == obj then
        local frame = rectOf(ctx, parent, depth + 1)
        if frame then
          local width, height = (state.width or 0) * scale, (state.height or 0) * scale
          local top = frame[2] + frame[4] + (S[parent].verticalScroll or 0) * scale
          rect = { frame[1] - (S[parent].horizontalScroll or 0) * scale, top - height, width, height }
        end
      elseif #state.points > 0 then
        local horizontal, vertical, ok = {}, {}, true
        for _, anchor in ipairs(state.points) do
          local relative = anchor.relativeTo and rectOf(ctx, anchor.relativeTo, depth + 1)
            or (not anchor.relativeTo and { 0, 0, W.screenWidth, W.screenHeight })
          if not relative then ok = false break end
          local from, to = pointFractions[anchor.relativePoint], pointFractions[anchor.point]
          horizontal[to[1]] = relative[1] + from[1] * relative[3] + anchor.x * scale
          vertical[to[2]] = relative[2] + from[2] * relative[4] + anchor.y * scale
        end
        if ok then
          -- A FontString sized 0 (or never sized) takes the size of its text, as in the client.
          local fixedWidth = state.width and (state.width > 0 or not isText) and state.width
          local fixedHeight = state.height and (state.height > 0 or not isText) and state.height
          local textWidth = isText and not fixedWidth and naturalTextSize(state) * scale
          local left, width, spans = solveAxis(horizontal, fixedWidth and fixedWidth * scale or textWidth or nil)
          local textHeightValue
          if isText and not fixedHeight then
            local _, natural = naturalTextSize(state, (spans or fixedWidth) and width / scale or nil)
            textHeightValue = natural * scale
          end
          local bottom, height = solveAxis(vertical, fixedHeight and fixedHeight * scale or textHeightValue or nil)
          rect = { left, bottom, width, height, natural = isText and not (spans or fixedWidth) }
        end
      end
    end
    ctx.rects[obj] = rect or false
    return rect
  end

  local function intersect(a, b)
    if not a then return b end
    if not b then return a end
    local left, bottom = math.max(a[1], b[1]), math.max(a[2], b[2])
    local right, top = math.min(a[1] + a[3], b[1] + b[3]), math.min(a[2] + a[4], b[2] + b[4])
    return { left, bottom, math.max(0, right - left), math.max(0, top - bottom) }
  end

  local function clipsChildren(state)
    return state.clipsChildren or W.isA(state.class, "ScrollFrame")
  end

  local function ancestorClip(ctx, obj)
    local clip, current = nil, S[obj].parent
    while current do
      if clipsChildren(S[current]) then clip = intersect(clip, rectOf(ctx, current) or { 0, 0, 0, 0 }) end
      current = S[current].parent
    end
    return clip
  end

  -- Draw items ----------------------------------------------------------------------------------

  ---@class RenderItem
  ---@field z number[] strata, frame level, frame order, draw layer, sublevel, region order
  ---@field rect number[] screen rect {left, bottom, width, height}
  ---@field clip number[]? screen rect the item is clipped to
  ---@field alpha number
  ---@field class string CSS classes
  ---@field style string extra inline CSS
  ---@field content string? inner HTML
  ---@field name string debug label

  local function frameKey(state, order)
    local strata = state.strata == "PARENT" and "MEDIUM" or state.strata or "MEDIUM"
    return { strataOrder[strata] or 4, state.level or 0, order }
  end

  local function debugName(obj)
    local state = S[obj]
    if state.name and state.name ~= "" then return state.name end
    local current = state.parent
    while current and not S[current].name do current = S[current].parent end
    return (current and S[current].name.."/" or "")..state.class.name.."#"..state.id
  end

  local function push(ctx, frameZ, layer, sublevel, index, rect, clip, alpha, class, style, content, obj)
    if alpha <= 0.001 or rect[3] <= 0 and rect[4] <= 0 then return end
    if clip and (clip[3] <= 0 or clip[4] <= 0) then return end
    ctx.items[#ctx.items + 1] = {
      z = { frameZ[1], frameZ[2], frameZ[3], layerOrder[layer] or 3, sublevel or 0, index },
      rect = rect, clip = clip, alpha = alpha, class = class, style = style or "", content = content,
      name = debugName(obj),
    }
  end

  local function texCoordStyle(state, rect, scale)
    local coords = state.texCoord
    if not coords then return "background-size:100% 100%" end
    local left, right, top, bottom
    if #coords == 4 then
      left, right, top, bottom = coords[1], coords[2], coords[3], coords[4]
    else
      left, top, bottom, right = coords[1], coords[2], coords[4], coords[5]
    end
    local flip = {}
    if left > right then left, right = right, left flip[#flip + 1] = "scaleX(-1)" end
    if top > bottom then top, bottom = bottom, top flip[#flip + 1] = "scaleY(-1)" end
    local spanX, spanY = math.max(right - left, 1e-6), math.max(bottom - top, 1e-6)
    local width, height = rect[3] * scale / spanX, rect[4] * scale / spanY
    return ("background-size:%spx %spx;background-position:%spx %spx"):format(
      num(width), num(height), num(-left * width), num(-top * height)), flip
  end

  local blendModes = { ADD = "plus-lighter", MOD = "multiply" }

  ---CSS for a texture's paint, or nil when it draws nothing (no file, color or atlas set).
  local function texturePaint(ctx, region, rect, tint)
    local state = S[region]
    local vertex = multiply(state.vertexColor or { 1, 1, 1, 1 }, tint)
    local gradient = state.gradient
    local scale = ctx.opts.scale
    local function finish(class, style, content, kind)
      local extras = {}
      if state.desaturated then extras[#extras + 1] = "filter:grayscale(1)" end
      if blendModes[state.blendMode] then extras[#extras + 1] = "mix-blend-mode:"..blendModes[state.blendMode] end
      if state.rotation and state.rotation ~= 0 then extras[#extras + 1] = ("transform:rotate(%srad)"):format(num(-state.rotation)) end
      if #extras > 0 then style = style..";"..table.concat(extras, ";") end
      ctx.stats[kind] = ctx.stats[kind] + 1
      return class, style, content
    end
    local function fill(color)
      if gradient then
        local from, to = colorOf(gradient[2]) or vertex, colorOf(gradient[3]) or vertex
        local direction = gradient[1] == "HORIZONTAL" and "to right" or "to top"
        if state.color then from, to = multiply(state.color, from), multiply(state.color, to) end
        return finish("r", ("background:linear-gradient(%s,%s,%s)"):format(direction, rgba(from), rgba(to)), nil, "fills")
      end
      return finish("r", "background:"..rgba(multiply(color, vertex)), nil, "fills")
    end
    local function placeholder(label)
      local tint = multiply({ 0.6, 0.6, 0.6, 1 }, vertex)
      local style = ("background:%s;outline:1px solid %s;outline-offset:-1px"):format(rgba(tint, 0.18), rgba(tint, 0.7))
      local content
      if rect[3] * scale >= 24 and rect[4] * scale >= 9 then content = '<b class="lb">'..escapeHTML(label).."</b>" end
      return finish("r ph", style, content, "placeholders")
    end
    if state.color then return fill(state.color) end
    if state.atlas then return placeholder("atlas:"..state.atlas) end
    local texture = state.texture
    if type(texture) == "number" then return placeholder("fileID "..texture) end
    if type(texture) ~= "string" or texture == "" then return nil end
    local key = normalizedPath(texture)
    if solidTextures[key] then return fill({ 1, 1, 1, 1 }) end
    if key:find("square_white$") then return fill({ 1, 1, 1, 1 }) end
    local uri = imageFor(texture)
    if not uri then return placeholder(basename(texture)) end
    local image = ctx.imageClass(texture, uri)
    local coords, flip = texCoordStyle(state, rect, scale)
    local style = "background-image:"..image..";"..coords
    local tint = gradient and colorOf(gradient[2]) or vertex
    if tint[1] < 0.999 or tint[2] < 0.999 or tint[3] < 0.999 then
      local mask = coords:gsub("background%-", "-webkit-mask-")
      style = style..(";background-color:%s;background-blend-mode:multiply;-webkit-mask-image:%s;%s"):format(
        rgba({ tint[1], tint[2], tint[3], 1 }), image, mask)
    end
    if (tint[4] or 1) < 1 then style = style..";opacity:"..num(tint[4]) end
    if flip and #flip > 0 then style = style..";transform:"..table.concat(flip, " ") end
    return finish("r", style, nil, "images")
  end

  local function hovered(ctx, frame)
    local state = S[frame]
    if ctx.opts.hover ~= nil then return ctx.opts.hover == frame end
    return W.mouseFocus == frame or state.highlightLocked == true
  end

  -- WoW shows one of a button's state textures at a time; the mock keeps them all shown.
  local function stateTextureHidden(region, frameState)
    if not W.isA(frameState.class, "Button") then return false end
    local disabled = frameState.enabled == false
    local pushed = frameState.buttonState == "PUSHED" and not disabled
    local checked = frameState.checked == true
    local roles = {
      NormalTexture = not (disabled and frameState.DisabledTexture) and not (pushed and frameState.PushedTexture),
      PushedTexture = pushed,
      DisabledTexture = disabled,
      CheckedTexture = checked and not (disabled and frameState.DisabledCheckedTexture),
      DisabledCheckedTexture = checked and disabled,
    }
    local hasRole = false
    for role, visible in pairs(roles) do
      if frameState[role] == region then
        if visible then return false end
        hasRole = true
      end
    end
    return hasRole
  end

  local function buttonFontOverride(region, frameState)
    if frameState.fontString ~= region then return nil end
    if frameState.enabled == false then return frameState.disabledFont end
    return nil
  end

  local function textStyle(ctx, state, scale, override)
    local font = fontProp(state, "font", override) or { path = nil, height = 12, flags = "" }
    local px = font.height * scale * ctx.opts.scale
    local color = fontProp(state, "textColor", override) or { 1, 1, 1, 1 }
    local shadows = {}
    local flags = (font.flags or ""):upper()
    if flags:find("OUTLINE") then
      local width = num((flags:find("THICK") and 2 or 1) * scale * ctx.opts.scale)
      for _, offset in ipairs({ { 1, 1 }, { -1, 1 }, { 1, -1 }, { -1, -1 } }) do
        shadows[#shadows + 1] = ("%spx %spx 0 #000"):format(offset[1] == 1 and width or "-"..width, offset[2] == 1 and width or "-"..width)
      end
    end
    local shadowOffset = fontProp(state, "shadowOffset", override)
    if shadowOffset and (shadowOffset[1] ~= 0 or shadowOffset[2] ~= 0) then
      shadows[#shadows + 1] = ("%spx %spx 0 %s"):format(num(shadowOffset[1] * scale * ctx.opts.scale),
        num(-shadowOffset[2] * scale * ctx.opts.scale), rgba(fontProp(state, "shadowColor", override) or { 0, 0, 0, 1 }))
    end
    local spacing = (fontProp(state, "spacing", override) or 0) * scale * ctx.opts.scale
    local style = ("font-family:%s;font-size:%spx;line-height:%spx;color:%s"):format(
      ctx.fontFamily(font.path), num(px), num(px * 1.12 + spacing), rgba(color))
    if #shadows > 0 then style = style..";text-shadow:"..table.concat(shadows, ",") end
    return style, font.height
  end

  local justifyFlex = { LEFT = "flex-start", CENTER = "center", RIGHT = "flex-end", TOP = "flex-start", MIDDLE = "center", BOTTOM = "flex-end" }

  local function textItem(ctx, state, rect, scale, override, defaults)
    local text = state.text
    if not text or text == "" then return nil end
    local style, fontHeight = textStyle(ctx, state, scale, override)
    local html = markup(text, fontHeight, ctx)
    local justifyH = fontProp(state, "justifyH", override) or defaults.h
    local justifyV = fontProp(state, "justifyV", override) or defaults.v
    local horizontal = justifyFlex[justifyH]
    if rect.natural and state.points[1] then
      local fraction = pointFractions[state.points[1].point][1]
      horizontal = fraction == 0 and "flex-start" or fraction == 1 and "flex-end" or "center"
    end
    local wraps = not rect.natural and defaults.wrap and state.wordWrap ~= false
    local inner = wraps and "white-space:normal" or "white-space:nowrap"
    if not rect.natural and not wraps then inner = inner..";overflow:hidden;text-overflow:ellipsis" end
    if state.maxLines and state.maxLines > 0 then
      inner = inner..(";display:-webkit-box;-webkit-box-orient:vertical;-webkit-line-clamp:%d;overflow:hidden"):format(state.maxLines)
    end
    style = ("%s;justify-content:%s;align-items:%s;text-align:%s"):format(style, horizontal, justifyFlex[justifyV], justifyH:lower())
    if not rect.natural then style = style..";overflow:hidden" end
    ctx.stats.texts = ctx.stats.texts + 1
    return "r tx", style, ('<span style="%s">%s</span>'):format(inner, html)
  end

  local function linePoint(ctx, line, spec, scale)
    local relativeTo = spec[2]
    if type(relativeTo) == "string" then relativeTo = rawget(_G, relativeTo) end
    relativeTo = relativeTo or S[line].parent
    local rect = relativeTo and rectOf(ctx, relativeTo)
    if not rect then return nil end
    local fraction = pointFractions[(spec[1] or "CENTER"):upper()] or pointFractions.CENTER
    return rect[1] + fraction[1] * rect[3] + (spec[3] or 0) * scale, rect[2] + fraction[2] * rect[4] + (spec[4] or 0) * scale
  end

  local function pushLine(ctx, line, frameZ, index, clip, alpha)
    local state = S[line]
    if not state.startPoint or not state.endPoint then return end
    local scale = effectiveScale(line)
    local x1, y1 = linePoint(ctx, line, state.startPoint, scale)
    local x2, y2 = linePoint(ctx, line, state.endPoint, scale)
    if not x1 or not x2 then
      ctx.unresolved(line)
      return
    end
    local thickness = (state.thickness or 1) * scale
    local length = math.sqrt((x2 - x1) ^ 2 + (y2 - y1) ^ 2)
    local color = multiply(state.color or { 1, 1, 1, 1 }, state.vertexColor)
    local angle = math.atan2(-(y2 - y1), x2 - x1)
    ctx.stats.lines = ctx.stats.lines + 1
    -- The rect holds the unrotated bar; the emitter rotates it about its left-center, the start point.
    local rect = { x1, y1 - thickness / 2, length, thickness, angle = angle }
    push(ctx, frameZ, state.layer, state.sublevel, index, rect, clip, alpha, "r",
      ("background:%s;transform-origin:0 50%%;transform:rotate(%srad)"):format(rgba(color), num(angle)), nil, line)
  end

  local function rangeFraction(state)
    local minimum, maximum = state.min or 0, state.max or 0
    if maximum <= minimum then return 0 end
    return math.max(0, math.min(1, ((state.value or minimum) - minimum) / (maximum - minimum)))
  end

  -- Slider thumbs and status bar fills are placed by the value, not by anchors.
  local function valueRect(region, frameState, frameRect)
    if not frameRect then return nil end
    local scale = effectiveScale(region)
    local vertical = frameState.orientation == "VERTICAL"
    local fraction = rangeFraction(frameState)
    if frameState.ThumbTexture == region then
      local width, height = (S[region].width or 16) * scale, (S[region].height or 16) * scale
      if vertical then
        local top = frameRect[2] + frameRect[4] - fraction * (frameRect[4] - height)
        return { frameRect[1] + (frameRect[3] - width) / 2, top - height, width, height }
      end
      return { frameRect[1] + fraction * (frameRect[3] - width), frameRect[2] + (frameRect[4] - height) / 2, width, height }
    end
    if frameState.barTexture == region then
      if vertical then return { frameRect[1], frameRect[2], frameRect[3], frameRect[4] * fraction } end
      return { frameRect[1], frameRect[2], frameRect[3] * fraction, frameRect[4] }
    end
  end

  local function pushBackdrop(ctx, frame, state, rect, frameZ, clip, alpha)
    local info = state.backdrop
    if not info or not rect then return end
    local scale = effectiveScale(frame)
    local insets = info.insets or {}
    local background = colorOf(state.backdropColor) or { 1, 1, 1, 1 }
    local border = colorOf(state.backdropBorderColor) or { 1, 1, 1, 1 }
    if info.bgFile then
      local inner = {
        rect[1] + (insets.left or 0) * scale, rect[2] + (insets.bottom or 0) * scale,
        rect[3] - ((insets.left or 0) + (insets.right or 0)) * scale, rect[4] - ((insets.top or 0) + (insets.bottom or 0)) * scale,
      }
      local solid = solidTextures[normalizedPath(info.bgFile)]
      local style = solid and "background:"..rgba(background) or ("background:%s"):format(rgba(multiply({ 0.1, 0.1, 0.1, 0.85 }, background)))
      push(ctx, frameZ, "BACKGROUND", -9, 0, inner, clip, alpha, "r", style, nil, frame)
    end
    if info.edgeFile then
      local solid = solidTextures[normalizedPath(info.edgeFile)]
      local size = solid and (info.edgeSize or 1) or math.min(2, (info.edgeSize or 8) / 4)
      push(ctx, frameZ, "BACKGROUND", -9, 1, rect, clip, alpha, "r",
        ("border:%spx solid %s"):format(num(size * scale * ctx.opts.scale), rgba(border, solid and 1 or 0.8)), nil, frame)
    end
  end

  ---Whether the client would draw anything for this region at all; empty ones are skipped without a report.
  local function paints(state, className)
    if className == "MaskTexture" then return false end
    if className == "FontString" or className == "EditBox" then return state.text ~= nil and state.text ~= "" end
    if className == "Line" then return true end
    return state.color ~= nil or state.atlas ~= nil or state.gradient ~= nil or (state.texture ~= nil and state.texture ~= "")
  end

  local function walk(ctx, frame, clip)
    local state = S[frame]
    if not state.shown or ctx.visited[frame] then return end
    ctx.visited[frame] = true
    ctx.order = ctx.order + 1
    ctx.stats.frames = ctx.stats.frames + 1
    local frameZ = frameKey(state, ctx.order)
    local rect = rectOf(ctx, frame)
    local frameAlpha = effectiveAlpha(frame)
    local showHighlight = hovered(ctx, frame) and state.enabled ~= false
    pushBackdrop(ctx, frame, state, rect, frameZ, clip, frameAlpha)

    for index, region in ipairs(state.regions) do
      local regionState = S[region]
      local className = regionState.class.name
      local isHighlight = regionState.layer == "HIGHLIGHT" or state.HighlightTexture == region
      if regionState.shown and paints(regionState, className) and not (isHighlight and not showHighlight)
        and not stateTextureHidden(region, state) then
        local alpha = effectiveAlpha(region)
        local layer = isHighlight and "HIGHLIGHT" or regionState.layer
        if className == "Line" then
          pushLine(ctx, region, frameZ, index, clip, alpha)
        else
          local regionRect = valueRect(region, state, rect) or rectOf(ctx, region)
          if not regionRect then
            ctx.unresolved(region)
          elseif className == "FontString" then
            local class, style, content = textItem(ctx, regionState, regionRect, effectiveScale(region),
              buttonFontOverride(region, state), { h = "CENTER", v = "MIDDLE", wrap = true })
            if class then push(ctx, frameZ, layer, regionState.sublevel, index, regionRect, clip, alpha, class, style, content, region) end
          else
            local tint = state.barTexture == region and state.barColor or nil
            local class, style, content = texturePaint(ctx, region, regionRect, tint)
            if class then push(ctx, frameZ, layer, regionState.sublevel, index, regionRect, clip, alpha, class, style, content, region) end
          end
        end
      end
    end

    if rect and state.class.name == "EditBox" then
      local insets = state.insets or { 0, 0, 0, 0 }
      local scale = effectiveScale(frame)
      local inner = {
        rect[1] + (insets[1] or 0) * scale, rect[2] + (insets[4] or 0) * scale,
        rect[3] - ((insets[1] or 0) + (insets[2] or 0)) * scale, rect[4] - ((insets[3] or 0) + (insets[4] or 0)) * scale,
      }
      local class, style, content = textItem(ctx, state, inner, scale, nil,
        { h = "LEFT", v = state.multiLine and "TOP" or "MIDDLE", wrap = state.multiLine == true })
      if class then push(ctx, frameZ, "OVERLAY", 7, #state.regions + 1, inner, clip, frameAlpha, class, style, content, frame) end
    end

    if not rect and state.class.name == "EditBox" and paints(state, "EditBox") then ctx.unresolved(frame) end
    local childClip = clip
    if clipsChildren(state) then childClip = intersect(clip, rect or { 0, 0, 0, 0 }) end
    for _, child in ipairs(state.children) do walk(ctx, child, childClip) end
  end

  -- Output --------------------------------------------------------------------------------------

  local function compareZ(a, b)
    for index = 1, 6 do
      if a.z[index] ~= b.z[index] then return a.z[index] < b.z[index] end
    end
    return false
  end

  local function boundsOf(ctx)
    local left, bottom, right, top
    for _, item in ipairs(ctx.items) do
      local rect = item.rect
      if rect.angle then
        local x2, y2 = rect[1] + math.cos(rect.angle) * rect[3], rect[2] - math.sin(rect.angle) * rect[3]
        rect = { math.min(rect[1], x2), math.min(rect[2], y2), math.abs(x2 - rect[1]), math.abs(y2 - rect[2]) + rect[4] }
      end
      local visible = item.clip and intersect(rect, item.clip) or rect
      if visible[3] > 0 or visible[4] > 0 then
        left = math.min(left or visible[1], visible[1])
        bottom = math.min(bottom or visible[2], visible[2])
        right = math.max(right or visible[1] + visible[3], visible[1] + visible[3])
        top = math.max(top or visible[2] + visible[4], visible[2] + visible[4])
      end
    end
    if not left then return { 0, 0, 0, 0 } end
    local screen = intersect({ left, bottom, right - left, top - bottom }, { 0, 0, W.screenWidth, W.screenHeight })
    return { math.floor(screen[1]), math.floor(screen[2]), math.ceil(screen[3]), math.ceil(screen[4]) }
  end

  local css = [[
html,body{margin:0;padding:0;background:#1b1b1f}
#ui{position:relative;overflow:hidden}
.r{position:absolute;box-sizing:border-box;pointer-events:auto}
.ph{overflow:hidden}
.lb{position:absolute;left:2px;top:1px;font:9px/10px Consolas,monospace;font-weight:normal;color:rgba(255,255,255,.55);white-space:nowrap}
.tx{display:flex}
.tx>span{max-width:100%;min-width:0}
.ic{display:inline-block;vertical-align:-0.15em;background-size:100% 100%}
.ic.ph{outline:1px solid rgba(255,255,255,.5);outline-offset:-1px;background:rgba(128,128,128,.25)}
]]

  local function emit(ctx, path, title)
    table.sort(ctx.items, compareZ)
    local bounds = boundsOf(ctx)
    local scale = ctx.opts.scale
    local originLeft, originTop = bounds[1], bounds[2] + bounds[4]
    local pageWidth, pageHeight = math.ceil(bounds[3] * scale), math.ceil(bounds[4] * scale)
    local body = {}
    for _, item in ipairs(ctx.items) do
      local rect = item.rect
      local x, y = (rect[1] - originLeft) * scale, (originTop - (rect[2] + rect[4])) * scale
      local width, height = rect[3] * scale, rect[4] * scale
      local style = ("left:%spx;top:%spx;width:%spx;height:%spx"):format(num(x), num(y), num(width), num(height))
      local hidden = false
      if item.clip and not rect.angle then
        local clipLeft, clipTop = (item.clip[1] - originLeft) * scale, (originTop - (item.clip[2] + item.clip[4])) * scale
        local insetTop, insetLeft = clipTop - y, clipLeft - x
        local insetRight = (x + width) - (clipLeft + item.clip[3] * scale)
        local insetBottom = (y + height) - (clipTop + item.clip[4] * scale)
        hidden = insetTop >= height or insetLeft >= width or insetRight >= width or insetBottom >= height
        if not hidden and (insetTop > 0 or insetLeft > 0 or insetRight > 0 or insetBottom > 0) then
          style = style..(";clip-path:inset(%spx %spx %spx %spx)"):format(num(math.max(0, insetTop)),
            num(math.max(0, insetRight)), num(math.max(0, insetBottom)), num(math.max(0, insetLeft)))
        end
      end
      if not hidden then
        if item.alpha < 0.999 then style = style..";opacity:"..num(item.alpha) end
        if item.style ~= "" then style = style..";"..item.style end
        body[#body + 1] = ('<div class="%s" style="%s" title="%s">%s</div>'):format(item.class, style, escapeHTML(item.name), item.content or "")
      end
    end
    local head = { css }
    for _, font in ipairs(ctx.fontList) do
      head[#head + 1] = ("@font-face{font-family:'%s';src:url(%s) format('%s')}"):format(font.name, font.face.uri, font.face.format)
    end
    local vars = {}
    for _, image in ipairs(ctx.classList) do vars[#vars + 1] = ("--%s:url(%s);"):format(image.name, image.uri) end
    head[#head + 1] = "#ui{"..table.concat(vars).."}"
    local file = assert(io.open(path, "wb"))
    file:write("<!doctype html>\n<html><head><meta charset=\"utf-8\">\n",
      ('<meta name="mdt-size" content="%d %d">\n'):format(pageWidth, pageHeight),
      "<title>", escapeHTML(title), "</title>\n<style>\n", table.concat(head, "\n"), "\n</style></head>\n<body>",
      ('<div id="ui" style="width:%dpx;height:%dpx">\n'):format(pageWidth, pageHeight),
      table.concat(body, "\n"), "\n</div></body></html>\n")
    file:close()
    return pageWidth, pageHeight
  end

  ---Writes root (and opts.also frames) as one HTML page. opts.scale: pixels per scale-1 unit (default: physical pixels).
  ---opts.hover: the frame whose HIGHLIGHT layer shows (default the mock's mouse focus).
  ---@return table stats with page width and height
  function W.renderHTML(root, path, opts)
    opts = opts or {}
    opts.scale = opts.scale or W.physicalHeight / 768
    -- The client lays out pending size changes before it draws, so a checkpoint mid-step sees settled sizes.
    for _ = 1, 10 do
      if W.layoutPass() == 0 then break end
    end
    local ctx = newContext(opts)
    local roots = { root }
    for _, extra in ipairs(opts.also or {}) do roots[#roots + 1] = extra end
    for _, frame in ipairs(roots) do
      if frame and W.isVisible(frame) then walk(ctx, frame, ancestorClip(ctx, frame)) end
    end
    ctx.stats.width, ctx.stats.height = emit(ctx, path, opts.title or debugName(root))
    ctx.stats.items = #ctx.items
    ctx.stats.unresolvedNames = {}
    for index, obj in ipairs(ctx.unresolvedObjects) do ctx.stats.unresolvedNames[index] = debugName(obj) end
    return ctx.stats
  end
end
