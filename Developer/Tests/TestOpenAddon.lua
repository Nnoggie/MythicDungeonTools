local addonName, addon = ...

local function FireUnprotectedSlashCommand(command)
  local editbox = ChatEdit_ChooseBoxForSend(DEFAULT_CHAT_FRAME); -- Get an editbox
  ChatEdit_ActivateChat(editbox);                                -- Show the editbox
  editbox:SetText(command);                                      -- Command goes here
  -- Process command and hide (runs ChatEdit_SendText() and ChatEdit_DeactivateChat() respectively)
  ChatEdit_OnEnterPressed(editbox);
end

local function testFunc()
  if addon.main_frame and addon.main_frame:IsShown() then return end
  FireUnprotectedSlashCommand("/mdt")
end

---@type MDTTest
local test = {
  name = "Open AddOn",
  func = testFunc,
  duration = 2
}

tinsert(addon.test.testList, test)
