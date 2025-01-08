local AddonName, MDT = ...
local L = MDT.L

local changeLog = {
  [1] = {
    tag = "4.3.5.0",
    date = "2024-03-15",
    notes = {
      "fix an issue with affix week dates",
      "fix another issue",
      "fix a third issue that is very long very long very long very long very long very long very long very long very long very long very long very long very long",
    }
  },
  [2] = {
    tag = "4.3.4.9",
    date = "2024-03-12",
    notes = {
      "Add AddonLocale support: Install the AddOn \"AddonLocale\" and use the MDT settings dialog to change the MDT language",
      "nil error fix",
    }
  }
}

local function createVersionCheckFrame()
  local width, height = 500, 300
  local titleText = "Version Check / Change Log"

  local f = CreateFrame("frame", "MDT_VersionCheckFrame", MDT.main_frame, "BackdropTemplate")
  f:SetSize(width, height)
  f:ClearAllPoints()
  f:SetPoint("BOTTOMLEFT", MDT.main_frame, "BOTTOMLEFT", 0, 0)
  f:SetFrameStrata("HIGH")
  f:SetFrameLevel(50)
  f:EnableMouse(true)
  f.bgTex = f:CreateTexture(nil, "BACKGROUND", nil, 0)
  f.bgTex:SetAllPoints()
  f.bgTex:SetDrawLayer("BORDER", -5)
  f.bgTex:SetColorTexture(unpack(MDT.BackdropColor))
  f:Hide()

  MDT.main_frame:HookScript("OnHide", function()
    f:Hide()
  end)

  local title = f:CreateFontString(nil, "OVERLAY", "GameFontNormal")
  title:SetPoint("TOP", f, "TOP", 0, -5)
  title:SetText(titleText)
  --bigger font size
  title:SetFontObject("GameFontNormal")
  ---@diagnostic disable-next-line: param-type-mismatch
  title:SetFont(title:GetFont(), 12);
  title:SetTextColor(1, 1, 1)

  local close = CreateFrame("Button", nil, f, "UIPanelCloseButton")
  close:SetPoint("TOPRIGHT", f, "TOPRIGHT", -2, -2)
  close:SetScript("OnClick", function()
    f:Hide()
  end)

  local scrollFrame = CreateFrame("scrollframe", nil, f, "BackdropTemplate")
  scrollFrame:SetPoint("TOPLEFT", f, "TOPLEFT", 10, -40)
  scrollFrame:SetWidth(width - 30)
  scrollFrame:SetHeight(height - 45)
  scrollFrame:SetBackdrop({
    bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
    tile = true,
    tileSize = 16,
    insets = { left = 1, right = 1, top = 0, bottom = 1 },
  })
  scrollFrame:SetBackdropColor(1, 0, 0, 1)

  vdt(scrollFrame, "scrollframe")

  local contentFrame = CreateFrame("frame", nil, scrollFrame, "BackdropTemplate")
  contentFrame:SetBackdrop({
    bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
    tile = true,
    tileSize = 16,
    insets = { left = 1, right = 1, top = 0, bottom = 1 },
  })
  contentFrame:SetBackdropColor(0, 1, 0, 1)

  contentFrame:SetSize(width - 10, height - 45)
  ---@diagnostic disable-next-line: param-type-mismatch
  scrollFrame:SetScrollChild(contentFrame)

  local slider = CreateFrame("slider", nil, f, "BackdropTemplate")
  slider:SetBackdrop({
    bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
    tile = true,
    tileSize = 16,
    insets = { left = 1, right = 1, top = 0, bottom = 1 },
  })
  slider:SetBackdropColor(.4, .4, .4, .7)

  slider.thumb = slider:CreateTexture(nil, "OVERLAY")
  slider.thumb:SetTexture("Interface\\Buttons\\UI-ScrollBar-Knob")
  slider.thumb:SetSize(25, 25)

  slider:SetThumbTexture(slider.thumb)
  slider:SetOrientation("VERTICAL");
  slider:SetSize(16, height - 45)
  slider:SetPoint("TOPLEFT", scrollFrame, "TOPRIGHT")
  slider:SetMinMaxValues(0, 1)
  slider:SetValue(0)
  slider:SetScript("OnValueChanged", function(self)
    scrollFrame:SetVerticalScroll(self:GetValue())
  end)

  scrollFrame:EnableMouseWheel(true)
  scrollFrame:SetScript("OnMouseWheel", function(self, delta)
    local current = slider:GetValue()
    if (IsShiftKeyDown() and (delta > 0)) then
      slider:SetValue(0)
    elseif (IsShiftKeyDown() and (delta < 0)) then
      slider:SetValue(1)
    elseif ((delta < 0) and (current < 1)) then
      slider:SetValue(current + 20)
    elseif ((delta > 0) and (current > 1)) then
      slider:SetValue(current - 20)
    end
  end)

  --text box
  local textBox = contentFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
  textBox:SetPoint("TOPLEFT", contentFrame, "TOPLEFT")
  textBox:SetJustifyH("LEFT")
  textBox:SetJustifyV("TOP")
  textBox:SetTextColor(1, 1, 1)
  textBox:SetWidth(450)
  textBox:SetHeight(2500)

  --create the changelog from the changelog table
  local text = ""
  for i, v in ipairs(changeLog) do
    text = text.."v"..v.tag.." ("..v.date..")\n"
    for _, note in ipairs(v.notes) do
      text = text.."  - "..note.."\n"
    end
    text = text.."\n"
  end
  textBox:SetText(text)

  return f
end

function MDT:ToggleVersionCheckFrame()
  if not MDT.versionCheckFrame then
    MDT.versionCheckFrame = createVersionCheckFrame()
  end
  if MDT.versionCheckFrame:IsShown() then
    MDT.versionCheckFrame:Hide()
  else
    MDT.versionCheckFrame:Show()
  end
end
