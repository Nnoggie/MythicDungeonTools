local AddonName, MDT = ...
local DF = _G["DetailsFramework"];
local L = MDT.L

local changeLog = {
  [0] = {
    tag = "v4.3.5.0",
    date = "2024-03-15",
    notes = {
      "fix an issue with affix week dates",
      "fix another issue",
      "fix a third issue that is very long very long very long very long very long very long very long very long very long very long very long very long very long",
    }
  },
  [1] = {
    tag = "v4.3.4.9",
    date = "2024-03-12",
    notes = {
      "Add AddonLocale support: Install the AddOn \"AddonLocale\" and use the MDT settings dialog to change the MDT language",
      "nil error fix",
    }
  }
}

local function createVersionCheckFrame()
  local panelOptions = {
    DontRightClickClose = true,
    NoTUISpecialFrame = false,
    NoCloseButton = false,
    NoScripts = true, -- not movable
    -- NoTitleBar = true,
  }
  local width, height = 500, 300
  local title = "Version Check / Change Log"
  local f = DF:CreateSimplePanel(MDT.main_frame, width, height, title, nil, panelOptions);
  f:Hide();
  MDT.main_frame:HookScript("OnHide", function()
    f.Close:Click()
  end)
  f:ClearAllPoints()
  f:SetPoint("BOTTOMLEFT", MDT.main_frame, "BOTTOMLEFT", 0, 0)

  local scrollFrame = CreateFrame("scrollframe", nil, f, "BackdropTemplate")
  scrollFrame:SetPoint("TOPLEFT", f, "TOPLEFT", 10, -30)
  scrollFrame:SetWidth(width-30)
  scrollFrame:SetHeight(height-35)
  scrollFrame:SetBackdrop({
    bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
    tile = true,
    tileSize = 16,
    insets = { left = 1, right = 1, top = 0, bottom = 1 },
  })
  scrollFrame:SetBackdropColor(.1, .1, .1, .3)

  local contentFrame = CreateFrame("frame", nil, scrollFrame, "BackdropTemplate")
  contentFrame:SetSize(width-10, 1000)
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
  slider:SetSize(16, height-35)
  slider:SetPoint("TOPLEFT", scrollFrame, "TOPRIGHT")
  slider:SetMinMaxValues(0, 1000)
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
      slider:SetValue(2000)
    elseif ((delta < 0) and (current < 2000)) then
      slider:SetValue(current + 20)
    elseif ((delta > 0) and (current > 1)) then
      slider:SetValue(current - 20)
    end
  end)

  --text box
  local textBox = contentFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
  textBox:SetPoint("TOPLEFT", contentFrame, "TOPLEFT")
  textBox:SetJustifyH("left")
  textBox:SetJustifyV("top")
  textBox:SetTextColor(1, 1, 1)
  textBox:SetWidth(450)
  textBox:SetHeight(2500)

  --create the changelog from the changelog table
  local text = ""
  for i, v in ipairs(changeLog) do
    text = text .. v.tag .. " (" .. v.date .. ")\n"
    for _, note in ipairs(v.notes) do
      text = text .. "  - " .. note .. "\n"
    end
    text = text .. "\n"
  end
  textBox:SetText(text)

  -- textBox:SetText([[Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam vitae eros non est semper bibendum. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Nulla nec ornare magna, sed pharetra tortor. Pellentesque commodo ligula ac tempor vestibulum. Phasellus eu iaculis metus, eget lobortis lorem. Maecenas a dictum lacus. In placerat molestie tortor sed venenatis. Sed suscipit tincidunt vulputate. Vivamus hendrerit neque sed mi euismod sodales. Maecenas euismod pharetra ex, ut dignissim lorem viverra sed. Nullam non turpis at tellus ultricies semper vitae non risus. Curabitur ac convallis purus, at suscipit justo. Quisque eleifend nibh non lorem auctor vehicula. Curabitur ullamcorper, dolor eu dictum pulvinar, elit massa maximus velit, sit amet semper felis mauris a diam. Praesent molestie scelerisque risus sed mollis.

  -- Suspendisse tempor quam erat, ut posuere dui rhoncus non. Phasellus non urna sed odio auctor convallis. Pellentesque eget tortor et lectus porttitor mollis ut sit amet felis. Integer tortor tellus, imperdiet nec porta vitae, tempor ac libero. Vestibulum suscipit feugiat pretium. Ut euismod justo non sapien maximus euismod. Vestibulum fringilla libero a eros ultricies, eu ornare urna bibendum. Etiam tempor tempor arcu eu vestibulum. Nunc congue pharetra diam, at vulputate nisi venenatis non. Praesent convallis scelerisque semper. Fusce dapibus nec diam eu placerat. Curabitur tristique sit amet purus quis facilisis. Nullam commodo varius arcu quis finibus. Donec scelerisque urna sit amet mauris ultrices, quis molestie mi molestie. Nulla nisl nulla, maximus a blandit ac, mattis eget augue. Praesent quis laoreet libero.

  -- Pellentesque nec porttitor arcu. Sed a tempor magna, sit amet ornare velit. Nulla sagittis sem iaculis turpis cursus, et commodo lectus lacinia. Nunc malesuada ipsum eu est viverra efficitur. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Pellentesque blandit vel ante a pharetra. Morbi at libero rhoncus magna finibus eleifend non eu diam. Nam ac dictum sapien. Nullam consectetur elit sed porttitor laoreet. Sed lorem magna, sollicitudin sed est sit amet, imperdiet posuere nulla. Nulla quis lorem vel mi rhoncus sagittis. Mauris fermentum tristique lectus, sed suscipit dolor tempus a. Duis placerat lacus est, in feugiat metus pharetra vitae.

  -- Quisque lobortis facilisis ullamcorper. Vestibulum a turpis sed diam euismod gravida. Duis rhoncus bibendum mauris sit amet venenatis. Sed vitae euismod arcu, et euismod purus. Vestibulum vehicula posuere ligula, at auctor purus malesuada in. In eget eleifend felis, et mollis justo. Mauris quis ligula porttitor, congue justo vitae, congue nulla. Nulla hendrerit consequat ex, quis efficitur augue pretium fermentum. Mauris a orci iaculis, bibendum velit ut, lacinia diam. Nulla facilisi.

  -- Ut pellentesque aliquet commodo. Fusce mattis lacus vitae dolor laoreet malesuada. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam erat volutpat. Curabitur venenatis purus a neque bibendum ultricies. Quisque egestas interdum elit, quis sagittis velit vestibulum ac. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. In sem leo, imperdiet a hendrerit vitae, commodo volutpat velit.]])


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
