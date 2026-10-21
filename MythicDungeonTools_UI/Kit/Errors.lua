local _, MDT = ...
local UI = MDT.UI

-- Kit code runs from frame scripts and callbacks, outside any function the addon wraps. Every script the kit sets and
-- every callback it calls goes through here, so its errors reach the addon's own error report instead of the game's.

---@type fun(message: string, stack: string)?
local handler

---@param fn fun(message: string, stack: string) the addon's error report
function UI.SetErrorHandler(fn)
  handler = fn
end

---@return fun(message: string, stack: string)?
function UI.GetErrorHandler()
  return handler
end

---@param err any
function UI.ReportError(err)
  if handler then
    handler(tostring(err), debugstack(3) or "")
  else
    geterrorhandler()(err)
  end
end

local function onError(err)
  UI.ReportError(err)
  return err
end

local function results(ok, ...)
  if ok then return ... end
end

---Calls fn, reporting an error instead of raising it.
---@param fn function
---@return ...
function UI.Call(fn, ...)
  return results(xpcall(fn, onError, ...))
end

---@param fn function?
---@return function?
local function protect(fn)
  if not fn then return nil end
  return function(...) return results(xpcall(fn, onError, ...)) end
end

---SetScript for kit frames: the handler's errors go to the addon's error report.
---@param frame table
---@param script string
---@param fn function?
function UI.Script(frame, script, fn)
  frame:SetScript(script, protect(fn))
end

---HookScript for kit frames: the hook's errors go to the addon's error report.
---@param frame table
---@param script string
---@param fn function
function UI.HookScript(frame, script, fn)
  frame:HookScript(script, protect(fn))
end
