local _, MDT = ...
local L = MDT.L
local UI = MDT.UI

local PAGE_WIDTH = 555
local PAGE_TOP = 20
local PAGE_BOTTOM = 15

---Content-type checkboxes, one Columns row per entry, split into equal columns.
local CONTENT_ROWS = {
  { { "lfr", L["combatLoggingLFR"] }, { "normal", L["combatLoggingNormal"] }, { "heroic", L["combatLoggingHeroic"] }, { "mythic", L["combatLoggingMythic"] } },
  { { "mythic_dungeon", L["combatLoggingMythicDungeon"] }, { "mythic_plus", L["combatLoggingMythicPlus"] } },
}

local page

local function build(content)
  local settings = MDT:GetDB().combatLogging
  local contentCheckboxes = {}

  UI.Heading(content, { text = L["Combat Logging"] })
  UI.Text(content, { text = L["combatLoggingOverview"], color = "text.secondary" })
  UI.Checkbox(content, {
    id = "enabled", label = L["combatLoggingEnable"], value = settings.enabled == true,
    onChange = function(value)
      MDT:CombatLogging_SetEnabled(value)
      for _, checkbox in ipairs(contentCheckboxes) do checkbox:SetDisabled(not value) end
    end,
  })
  for _, row in ipairs(CONTENT_ROWS) do
    local weights = {}
    for i = 1, #row do weights[i] = 1 end
    local columns = UI.Columns(content, { weights = weights, gap = "sm" })
    for i, entry in ipairs(row) do
      local contentType = entry[1]
      contentCheckboxes[#contentCheckboxes + 1] = UI.Checkbox(columns[i], {
        id = contentType, label = entry[2], value = settings.content[contentType] == true, disabled = settings.enabled ~= true,
        onChange = function(value) MDT:CombatLogging_SetContentEnabled(contentType, value) end,
      })
    end
  end
  UI.Text(content, { text = L["combatLoggingAdvancedNote"], color = "text.secondary" })
end

function MDT:CombatLogging_Open()
  if self:GetCurrentSection() ~= "combatLogging" then
    self:SetCurrentSection("combatLogging")
    return
  end

  MDT:HideAllDialogs()
  if not page then
    local content = MDT.main_frame.sectionContentFrames.combatLogging
    page = UI.Scroll(content, { padding = "md", gap = "md" })
    page:SetPoint("TOP", content, "TOP", 0, -PAGE_TOP)
    page:SetPoint("BOTTOM", content, "BOTTOM", 0, PAGE_BOTTOM)
    page:SetWidth(PAGE_WIDTH)
  end
  page.content:ReleaseChildren()
  page.content:Batch(function() build(page.content) end)
end

MDT:RegisterNavigationSection({
  key = "combatLogging",
  name = L["Combat Logging"],
  tooltip = L["Combat Logging"],
  texCoords = { 0.75, 1, 0, 0.25 },
  onShow = function()
    MDT:CombatLogging_Open()
  end,
})
