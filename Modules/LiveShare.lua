local MDT = MDT
local db
local liveShareFrames = {}





function MDT:GetLiveShareFrame(index)
  if not liveShareFrames[index] then
    liveShareFrames[index] = CreateFrame("Frame", "MDTLiveShareFrame"..index, UIParent, "MDTLiveShareFrameTemplate")
    local frame = liveShareFrames[index]
    -- frame:SetPoint("CENTER", MDT.main_frame., "CENTER", 0, 0)

  end
end