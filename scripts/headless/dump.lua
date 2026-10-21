-- Text snapshot of the visible frame tree, so refactors can be diffed structurally.
-- One line per visible frame: type, name, rounded size, texture count, then its visible FontStrings.
return function(W)
  local S = W.state

  local function size(object)
    return ("%dx%d"):format(math.floor(object:GetWidth() + 0.5), math.floor(object:GetHeight() + 0.5))
  end

  local function quote(text)
    return (("%q"):format(text):gsub("\\\n", "\\n"))
  end

  -- Siblings are sorted by their rendered text: creation order follows pairs() order, which differs per runtime.
  local function walk(frame, depth)
    local state = S[frame]
    local indent = string.rep("  ", depth)
    local textures, strings = 0, {}
    for _, region in ipairs(state.regions) do
      if W.isVisible(region) then
        if S[region].class.name == "FontString" then
          local text = S[region].text
          if text and text ~= "" then strings[#strings + 1] = indent.."  FontString "..quote(text) end
        else
          textures = textures + 1
        end
      end
    end
    table.sort(strings)
    local line = indent..state.class.name..(state.name and " "..state.name or "").." "..size(frame)
    if textures > 0 then line = line.." textures="..textures end
    if state.class.name == "EditBox" and state.text and state.text ~= "" then line = line.." text="..quote(state.text:sub(1, 60)) end
    local blocks = {}
    for _, child in ipairs(state.children) do
      if W.isVisible(child) then blocks[#blocks + 1] = walk(child, depth + 1) end
    end
    table.sort(blocks, function(a, b) return a.key < b.key end)
    local out = { line }
    for _, text in ipairs(strings) do out[#out + 1] = text end
    for _, block in ipairs(blocks) do
      for _, blockLine in ipairs(block) do out[#out + 1] = blockLine end
    end
    out.key = table.concat(out, "\n")
    return out
  end

  function W.dumpTree()
    local roots = { W.UIParent }
    for frame in pairs(W.topLevel) do
      if frame ~= W.UIParent and S[frame].isFrame and W.isVisible(frame) then roots[#roots + 1] = frame end
    end
    table.sort(roots, function(a, b) return S[a].id < S[b].id end)
    local lines = {}
    for _, root in ipairs(roots) do
      for _, line in ipairs(walk(root, 0)) do lines[#lines + 1] = line end
    end
    return lines
  end
end
