local AddonName, MDT = ...

local framePools = {}

function MDT.CreateFramePool(frametype, parent, template)
  local pool = {
    active = {},
    inactive = {},
    Acquire = function(self)
      local frame = table.remove(self.inactive)
      if not frame then
        frame = CreateFrame(frametype, nil, parent, template)
      end
      table.insert(self.active, frame)
      return frame
    end,
    ReleaseAll = function(self)
      for i = #self.active, 1, -1 do
        local frame = table.remove(self.active)
        frame:Hide()
        table.insert(self.inactive, frame)
      end
    end,
  }
  framePools[template] = pool
  return pool
end

function MDT.GetFramePool(template)
  return framePools[template]
end
