-- AnimationGroup and Animation types, advanced by the frame loop in api.lua.
return function(W)
  local S, usage, checkNumber, fireScript, defineClass, newObject =
    W.state, W.usage, W.checkNumber, W.fireScript, W.defineClass, W.newObject
  local ScriptRegion = W.ScriptRegion


  local AnimationGroup = defineClass("AnimationGroup", "Object", {
    "OnLoad", "OnPlay", "OnPause", "OnStop", "OnFinished", "OnLoop", "OnUpdate",
  })
  local Animation = defineClass("Animation", "Object", {
    "OnLoad", "OnPlay", "OnPause", "OnStop", "OnFinished", "OnLoop", "OnUpdate",
  })
  local animationTypes = { "Alpha", "Rotation", "Scale", "Translation", "Path", "LineScale", "LineTranslation", "TextureCoordTranslation", "FlipBook", "VertexColor" }
  for _, name in ipairs(animationTypes) do defineClass(name, "Animation", {}) end

  function W.CreateAnimationGroup(parent, name)
    local group, state = newObject("AnimationGroup", { owner = parent, animations = {}, elapsed = 0 })
    state.name = name
    return group
  end

  local function groupDuration(state)
    local byOrder = {}
    for _, animation in ipairs(state.animations) do
      local animationState = S[animation]
      local order = animationState.order or 1
      local length = (animationState.startDelay or 0) + (animationState.duration or 0) + (animationState.endDelay or 0)
      byOrder[order] = math.max(byOrder[order] or 0, length)
    end
    local total = 0
    for _, length in pairs(byOrder) do total = total + length end
    return total
  end

  function AnimationGroup:CreateAnimation(animationType, name, template)
    animationType = animationType or "Animation"
    local class
    for _, known in ipairs(animationTypes) do
      if known:lower() == animationType:lower() then class = known end
    end
    usage(class or animationType:lower() == "animation", 'CreateAnimation(): unknown animation type "'..tostring(animationType)..'"')
    local animation, state = newObject(class or "Animation", { group = self })
    state.name = name
    table.insert(S[self].animations, animation)
    return animation
  end
  function AnimationGroup:GetAnimations() return unpack(S[self].animations) end
  function AnimationGroup:Play(reverse, offset)
    local state = S[self]
    state.playing, state.paused, state.elapsed, state.reverse = true, false, offset or 0, reverse
    W.playingAnimations[self] = true
    fireScript(self, "OnPlay")
  end
  function AnimationGroup:Restart() self:Stop() self:Play() end
  function AnimationGroup:Stop()
    local state = S[self]
    if not state.playing then return end
    state.playing = false
    W.playingAnimations[self] = nil
    fireScript(self, "OnStop", false)
  end
  function AnimationGroup:Finish()
    local state = S[self]
    if not state.playing then return end
    state.playing = false
    W.playingAnimations[self] = nil
    for _, animation in ipairs(state.animations) do fireScript(animation, "OnFinished") end
    fireScript(self, "OnFinished", false)
  end
  function AnimationGroup:Pause() S[self].paused = true end
  function AnimationGroup:IsPlaying() return S[self].playing == true and not S[self].paused end
  function AnimationGroup:IsPaused() return S[self].paused == true end
  function AnimationGroup:IsDone() return not S[self].playing end
  function AnimationGroup:IsPendingFinish() return false end
  function AnimationGroup:SetLooping(looping) S[self].looping = looping end
  function AnimationGroup:GetLooping() return S[self].looping or "NONE" end
  function AnimationGroup:SetToFinalAlpha(value) S[self].toFinalAlpha = value end
  function AnimationGroup:IsSetToFinalAlpha() return S[self].toFinalAlpha == true end
  function AnimationGroup:GetParent() return S[self].owner end
  function AnimationGroup:GetDuration() return groupDuration(S[self]) end
  function AnimationGroup:GetElapsed() return S[self].elapsed end
  function AnimationGroup:SetPlaying(playing) if playing then self:Play() else self:Stop() end end
  function AnimationGroup:RemoveAnimations() S[self].animations = {} end
  function AnimationGroup:SetAnimationSpeedMultiplier() end
  function AnimationGroup:GetProgress()
    local duration = groupDuration(S[self])
    return duration > 0 and math.min(1, S[self].elapsed / duration) or 1
  end

  function W.advanceAnimations(elapsed)
    local playing = {}
    for group in pairs(W.playingAnimations) do playing[#playing + 1] = group end
    for _, group in ipairs(playing) do
      local state = S[group]
      if state.playing and not state.paused then
        state.elapsed = state.elapsed + elapsed
        fireScript(group, "OnUpdate", elapsed)
        local duration = groupDuration(state)
        if state.elapsed >= duration then
          if state.looping == "REPEAT" or state.looping == "BOUNCE" then
            state.elapsed = 0
            fireScript(group, "OnLoop", "FORWARD")
          else
            group:Finish()
          end
        end
      end
    end
  end

  local function animationSetter(field)
    return function(self, value) S[self][field] = value end
  end
  local function animationGetter(field, default)
    return function(self) local value = S[self][field] if value == nil then return default end return value end
  end
  Animation.SetDuration = function(self, value) checkNumber(value, "SetDuration", "duration") S[self].duration = value end
  Animation.GetDuration = animationGetter("duration", 0)
  Animation.SetStartDelay = animationSetter("startDelay")
  Animation.GetStartDelay = animationGetter("startDelay", 0)
  Animation.SetEndDelay = animationSetter("endDelay")
  Animation.GetEndDelay = animationGetter("endDelay", 0)
  Animation.SetOrder = animationSetter("order")
  Animation.GetOrder = animationGetter("order", 1)
  Animation.SetSmoothing = animationSetter("smoothing")
  Animation.GetSmoothing = animationGetter("smoothing", "NONE")
  Animation.SetSmoothProgress = animationSetter("smoothProgress")
  Animation.SetFromAlpha = animationSetter("fromAlpha")
  Animation.GetFromAlpha = animationGetter("fromAlpha", 0)
  Animation.SetToAlpha = animationSetter("toAlpha")
  Animation.GetToAlpha = animationGetter("toAlpha", 0)
  Animation.SetChange = animationSetter("change")
  Animation.SetDegrees = animationSetter("degrees")
  Animation.GetDegrees = animationGetter("degrees", 0)
  Animation.SetRadians = animationSetter("radians")
  Animation.SetOrigin = function(self, point, x, y) S[self].origin = { point, x, y } end
  Animation.GetOrigin = function(self) return unpack(S[self].origin or { "CENTER", 0, 0 }) end
  Animation.SetOffset = function(self, x, y) S[self].offset = { x, y } end
  Animation.GetOffset = function(self) return unpack(S[self].offset or { 0, 0 }) end
  Animation.SetScale = function(self, x, y) S[self].scaleTo = { x, y } end
  Animation.SetScaleFrom = function(self, x, y) S[self].scaleFrom = { x, y } end
  Animation.SetScaleTo = function(self, x, y) S[self].scaleTo = { x, y } end
  Animation.SetFromScale = Animation.SetScaleFrom
  Animation.SetToScale = Animation.SetScaleTo
  Animation.SetTarget = animationSetter("target")
  Animation.GetTarget = function(self) return S[self].target or S[S[self].group].owner end
  Animation.SetTargetKey = animationSetter("targetKey")
  Animation.SetTargetName = animationSetter("targetName")
  Animation.SetTargetParent = function() end
  Animation.SetChildKey = animationSetter("childKey")
  Animation.GetRegionParent = function(self) return S[S[self].group].owner end
  Animation.GetParent = function(self) return S[self].group end
  Animation.IsPlaying = function(self) return S[S[self].group].playing == true end
  Animation.Play = function(self) end
  Animation.Stop = function(self) end
  Animation.GetProgress = function(self) return S[S[self].group]:GetProgress() end
  Animation.GetElapsed = function(self) return S[S[self].group].elapsed end
  Animation.SetFlipBookRows = animationSetter("rows")
  Animation.SetFlipBookColumns = animationSetter("columns")
  Animation.SetFlipBookFrames = animationSetter("frames")
  Animation.SetFlipBookFrameWidth = animationSetter("frameWidth")
  Animation.SetFlipBookFrameHeight = animationSetter("frameHeight")
  Animation.SetStartColor = animationSetter("startColor")
  Animation.SetEndColor = animationSetter("endColor")

  ScriptRegion.CreateAnimationGroup = function(self, name, template)
    local group = W.CreateAnimationGroup(self, name)
    if template then W.applyTemplates(group, template) end
    return group
  end
end
