local _, MDT = ...

local xalatathSoundFileIds = {
  1391165, 1391166, 2530794, 2530796, 2530797, 2530798, 2530811, 2530835, 5770084, 5770087, 5834632, 5835211,
  5835212, 5835214, 5835215, 5835725, 5835726, 5854705, 5859141, 6178475, 6178476, 6178477, 6178478, 6178479,
  6178480, 6178481, 6178488, 6178489, 6178494, 6178497, 6178498, 6178500, 6178502, 6178504, 6178506, 6178508,
}

function MDT:SetXalatathVoiceLinesMuted(muted)
  if not MDT:IsRetail() then return end

  local updateSoundFile = muted and MuteSoundFile or UnmuteSoundFile

  for _, soundFileId in ipairs(xalatathSoundFileIds) do
    updateSoundFile(soundFileId)
  end
end

function MDT:ApplyXalatathVoiceLinesMute()
  local db = MDT:GetDB()
  if db.muteXalatathVoiceLines then
    MDT:SetXalatathVoiceLinesMuted(true)
  end
end
