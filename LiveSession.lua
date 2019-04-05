local MethodDungeonTools = MethodDungeonTools
local db

function MethodDungeonTools:LiveSession_Enable()
    self.liveSessionActive = true
end

function MethodDungeonTools:LiveSession_Disable()
    self.liveSessionActive = false
end