--- **LibDialog-1.0** provides methods for creating dialogs similar to Blizzard's default StaticPopup dialogs,
-- with additions (such as multiple CheckButtons) and improvements (such as multiple EditBoxes, frame and widget
-- recycling, and not tainting default UI elements).
-- @class file
-- @name LibDialog-1.0.lua
-- @release 1

-----------------------------------------------------------------------
-- Upvalued Lua API.
-----------------------------------------------------------------------
local _G = getfenv(0)

-- Functions
local error = _G.error
local pairs = _G.pairs
local tonumber = _G.tonumber

-- Libraries
local table = _G.table

-----------------------------------------------------------------------
-- Library namespace.
-----------------------------------------------------------------------
local LibStub = _G.LibStub
local MAJOR = "LibDialog-1.0"

_G.assert(LibStub, MAJOR .. " requires LibStub")

local MINOR = 8 -- Should be manually increased
local lib, oldminor = LibStub:NewLibrary(MAJOR, MINOR)

if not lib then
    return
end -- No upgrade needed

local dialog_prototype = _G.CreateFrame("Frame", nil, _G.UIParent)
local dialog_meta = {
    __index = dialog_prototype
}

-----------------------------------------------------------------------
-- Migrations.
-----------------------------------------------------------------------
lib.delegates = lib.delegates or {}
lib.queued_delegates = lib.queues_delegates or {}
lib.delegate_queue = lib.delegate_queue or {}

lib.active_dialogs = lib.active_dialogs or {}
lib.active_buttons = lib.active_buttons or {}
lib.active_checkboxes = lib.active_checkboxes or {}
lib.active_editboxes = lib.active_editboxes or {}
lib.active_icons = lib.active_icons or {}

lib.dialog_heap = lib.dialog_heap or {}
lib.button_heap = lib.button_heap or {}
lib.checkbox_heap = lib.checkbox_heap or {}
lib.editbox_heap = lib.editbox_heap or {}
lib.icon_heap = lib.icon_heap or {}

-----------------------------------------------------------------------
-- Constants.
-----------------------------------------------------------------------
local METHOD_USAGE_FORMAT = MAJOR .. ":%s() - %s."

local DEFAULT_DIALOG_WIDTH = 320
local DEFAULT_DIALOG_HEIGHT = 72

local DEFAULT_BUTTON_WIDTH = 128
local DEFAULT_BUTTON_HEIGHT = 21

local DEFAULT_EDITBOX_WIDTH = 130
local DEFAULT_EDITBOX_HEIGHT = 32

local DEFAULT_CHECKBOX_SIZE = 32

local DEFAULT_ICON_SIZE = 36

local DEFAULT_DIALOG_TEXT_WIDTH = 290

local MAX_DIALOGS = 4
local MAX_BUTTONS = 3

local DEFAULT_DIALOG_BACKDROP = {
    bgFile = [[Interface\DialogFrame\UI-DialogBox-Background]],
    edgeFile = [[Interface\DialogFrame\UI-DialogBox-Border]],
    tile = true,
    tileSize = 32,
    edgeSize = 32,
    insets = {
        left = 11,
        right = 12,
        top = 12,
        bottom = 11,
    },
}

local TEXT_HORIZONTAL_JUSTIFICATIONS = {
    CENTER = "CENTER",
    LEFT = "LEFT",
    RIGHT = "RIGHT",
}

local TEXT_VERTICAL_JUSTIFICATIONS = {
    BOTTOM = "BOTTOM",
    MIDDLE = "MIDDLE",
    TOP = "TOP",
}

-----------------------------------------------------------------------
-- Upvalues.
-----------------------------------------------------------------------
local delegates = lib.delegates
local queued_delegates = lib.queued_delegates
local delegate_queue = lib.delegate_queue

local active_dialogs = lib.active_dialogs
local active_buttons = lib.active_buttons
local active_checkboxes = lib.active_checkboxes
local active_editboxes = lib.active_editboxes
local active_icons = lib.active_icons

local dialog_heap = lib.dialog_heap
local button_heap = lib.button_heap
local checkbox_heap = lib.checkbox_heap
local editbox_heap = lib.editbox_heap
local icon_heap = lib.icon_heap

-----------------------------------------------------------------------
-- Helper functions.
-----------------------------------------------------------------------
local function _ProcessQueue()
    if #active_dialogs == MAX_DIALOGS then
        return
    end
    local delegate = table.remove(delegate_queue)

    if not delegate then
        return
    end
    local data = queued_delegates[delegate]
    queued_delegates[delegate] = nil

    if data == "" then
        data = nil
    end
    return lib:Spawn(delegate, data)
end

local function _RefreshDialogAnchors()
    for index = 1, #active_dialogs do
        local current_dialog = active_dialogs[index]
        current_dialog:ClearAllPoints()

        if index == 1 then
            local default_dialog = _G.StaticPopup_DisplayedFrames[#_G.StaticPopup_DisplayedFrames]

            if default_dialog then
                current_dialog:SetPoint("TOP", default_dialog, "BOTTOM", 0, 0)
            else
                current_dialog:SetPoint("TOP", _G.UIParent, "TOP", 0, -135)
            end
        else
            current_dialog:SetPoint("TOP", active_dialogs[index - 1], "BOTTOM", 0, 0)
        end
    end
end

local function _RecycleWidget(widget, actives, heap)
    local remove_index

    for index = 1, #actives do
        if actives[index] == widget then
            remove_index = index
        end
    end

    if not remove_index then
        return
    end
    table.remove(actives, remove_index):ClearAllPoints()
    table.insert(heap, widget)
end

local function _ReleaseCheckBox(checkbox)
    checkbox.container:Hide()
    _RecycleWidget(checkbox, active_checkboxes, checkbox_heap)
    checkbox.container:ClearAllPoints()
    checkbox.container:SetParent(nil)
end

local function _ReleaseEditBox(editbox)
    editbox:SetMaxLetters(0)
    editbox:SetMaxBytes(0)
    editbox:Hide()
    _RecycleWidget(editbox, active_editboxes, editbox_heap)
    editbox:SetParent(nil)
end

local function _ReleaseButton(button)
    button:Hide()
    _RecycleWidget(button, active_buttons, button_heap)
    button:SetParent(nil)
end

local function _ReleaseDialog(dialog)
    dialog.delegate = nil
    dialog.data = nil

    if dialog.editboxes then
        for index = 1, #dialog.editboxes do
            _ReleaseEditBox(dialog.editboxes[index])
        end
        dialog.editboxes = nil
    end

    if dialog.checkboxes then
        for index = 1, #dialog.checkboxes do
            _ReleaseCheckBox(dialog.checkboxes[index])
        end
        dialog.checkboxes = nil
    end

    if dialog.buttons then
        for index = 1, #dialog.buttons do
            _ReleaseButton(dialog.buttons[index])
        end
        dialog.buttons = nil
    end
    _RecycleWidget(dialog, active_dialogs, dialog_heap)
    _RefreshDialogAnchors()
end

local function _Dialog_OnShow(dialog)
    local delegate = dialog.delegate

    if not delegate then
        return
    end

    _G.PlaySound(850) -- "igMainMenuOpen"

    if delegate.on_show then
        delegate.on_show(dialog, dialog.data)
    end
end

local function _Dialog_OnHide(dialog)
    local delegate = dialog.delegate

    _G.PlaySound(851) -- "igMainMenuClose"

    -- Required so lib:ActiveDialog() will return false if called from code which is called from the delegate's on_hide
    _RecycleWidget(dialog, active_dialogs, dialog_heap)

    if delegate.on_hide then
        delegate.on_hide(dialog, dialog.data)
    end
    _ReleaseDialog(dialog)

    if #delegate_queue > 0 then
        local delegate
        repeat
            delegate = _ProcessQueue()
            until not delegate
    end
end

local function _Dialog_OnUpdate(dialog, elapsed)
    local delegate = dialog.delegate

    if dialog.time_remaining and dialog.time_remaining > 0 then
        local remaining = dialog.time_remaining - elapsed

        if remaining <= 0 then
            dialog.time_remaining = nil

            if delegate and delegate.on_cancel then
                delegate.on_cancel(dialog, dialog.data, "timeout")
            end
            dialog:Hide()
            return
        end
        dialog.time_remaining = remaining
    end

    if delegate and delegate.on_update then
        delegate.on_update(dialog, elapsed)
    end
end

local function _Dialog_OnEvent(self, event, ...)
    if self[event] then
        return self[event](self, event, ...)
    end
end

if not lib.hooked_onhide then
    _G.hooksecurefunc("StaticPopup_OnHide", function()
        _RefreshDialogAnchors()

        if #delegate_queue > 0 then
            local delegate
            repeat
                delegate = _ProcessQueue()
            until not delegate
        end
    end)
    lib.hooked_onhide = true
end

if not lib.hooked_set_up_position then
    _G.hooksecurefunc("StaticPopup_SetUpPosition", function()
        _RefreshDialogAnchors()
    end)
    lib.hooked_set_up_position = true
end

if not lib.hooked_escape_pressed then
    local dialogs_to_release = {}

    _G.hooksecurefunc("StaticPopup_EscapePressed", function()
        table.wipe(dialogs_to_release)

        for index = 1, #active_dialogs do
            local dialog = active_dialogs[index]

            if dialog.delegate.hide_on_escape then
                dialogs_to_release[dialog] = true
            end
        end

        for dialog in pairs(dialogs_to_release) do
            local delegate = dialog.delegate

            if delegate.on_cancel and not delegate.no_cancel_on_escape then
                delegate.on_cancel(dialog)
            end
            dialog:Hide()
        end

        if #delegate_queue > 0 then
            local delegate
            repeat
                delegate = _ProcessQueue()
            until not delegate
        end
    end)
    lib.hooked_escape_pressed = true
end

local function CheckBox_GetValue(checkbox)
    local dialog = checkbox:GetParent():GetParent()
    local get_value = dialog.delegate.checkboxes[checkbox:GetID()].get_value

    if get_value then
        return get_value(checkbox, dialog.data)
    end
end

local function CheckBox_OnClick(checkbox, mouse_button, down)
    local dialog = checkbox:GetParent():GetParent()
    local set_value = dialog.delegate.checkboxes[checkbox:GetID()].set_value

    if set_value then
        set_value(checkbox, CheckBox_GetValue(checkbox), dialog.data, mouse_button, down)
    end
    checkbox:SetChecked(CheckBox_GetValue(checkbox))
end

local function _AcquireCheckBox(parent, index)
    local checkbox = table.remove(checkbox_heap)

    if not checkbox then
        local container = _G.CreateFrame("Frame", ("%s_CheckBoxContainer%d"):format(MAJOR, #active_checkboxes + 1), _G.UIParent)
        container:SetHeight(DEFAULT_CHECKBOX_SIZE)

        checkbox = _G.CreateFrame("CheckButton", ("%s_CheckBox%d"):format(MAJOR, #active_checkboxes + 1), container, "UICheckButtonTemplate")
        checkbox:SetScript("OnClick", CheckBox_OnClick)

        checkbox.container = container
    end
    active_checkboxes[#active_checkboxes + 1] = checkbox

    checkbox:SetPoint("LEFT", 0, 0)
    checkbox.text:SetText(parent.delegate.checkboxes[index].label or "")
    checkbox.container:SetParent(parent)
    checkbox:SetID(index)
    checkbox:SetChecked(CheckBox_GetValue(checkbox))

    checkbox.container:Show()
    return checkbox
end

local function EditBox_OnEnterPressed(editbox)
    if not editbox.autoCompleteParams or not _G.AutoCompleteEditBox_OnEnterPressed(editbox) then
        local dialog = editbox:GetParent()
        local on_enter_pressed = dialog.delegate.editboxes[editbox:GetID()].on_enter_pressed

        if on_enter_pressed then
            on_enter_pressed(editbox, dialog.data)
        end
    end
end

local function EditBox_OnEscapePressed(editbox)
    local dialog = editbox:GetParent()
    local on_escape_pressed = dialog.delegate.editboxes[editbox:GetID()].on_escape_pressed

    if on_escape_pressed then
        on_escape_pressed(editbox, dialog.data)
    end
end

local function EditBox_OnShow(editbox)
    local dialog = editbox:GetParent()
    local on_show = dialog.delegate.editboxes[editbox:GetID()].on_show

    if on_show then
        on_show(editbox, dialog.data)
    end
end

local function EditBox_OnTextChanged(editbox, user_input)
    if not editbox.autoCompleteParams or not _G.AutoCompleteEditBox_OnTextChanged(editbox, user_input) then
        local dialog = editbox:GetParent()
        local on_text_changed = dialog.delegate.editboxes[editbox:GetID()].on_text_changed

        if on_text_changed then
            on_text_changed(editbox, dialog.data)
        end
    end
end

local function _AcquireEditBox(dialog, index)
    local editbox = table.remove(editbox_heap)

    if not editbox then
        local editbox_name = ("%s_EditBox%d"):format(MAJOR, #active_editboxes + 1)

        editbox = _G.CreateFrame("EditBox", editbox_name, _G.UIParent, "AutoCompleteEditBoxTemplate")
        editbox:SetWidth(130)
        editbox:SetHeight(32)
        editbox:SetFontObject("ChatFontNormal")

        local left = editbox:CreateTexture(("%sLeft"):format(editbox_name), "BACKGROUND")
        left:SetTexture([[Interface\ChatFrame\UI-ChatInputBorder-Left2]])
        left:SetWidth(32)
        left:SetHeight(32)
        left:SetPoint("LEFT", -10, 0)

        local right = editbox:CreateTexture(("%sRight"):format(editbox_name), "BACKGROUND")
        right:SetTexture([[Interface\ChatFrame\UI-ChatInputBorder-Right2]])
        right:SetWidth(32)
        right:SetHeight(32)
        right:SetPoint("RIGHT", 10, 0)

        local mid = editbox:CreateTexture(("%sMid"):format(editbox_name), "BACKGROUND")
        mid:SetTexture([[Interface\ChatFrame\UI-ChatInputBorder-Mid2]])
        mid:SetHeight(32)
        mid:SetPoint("TOPLEFT", left, "TOPRIGHT", 0, 0)
        mid:SetPoint("TOPRIGHT", right, "TOPLEFT", 0, 0)

        local label = editbox:CreateFontString(("%sLabel"):format(editbox_name), "ARTWORK", "GameFontNormalSmall")
        label:SetPoint("RIGHT", editbox, "LEFT", -15, 0)

        editbox.left = left
        editbox.right = right
        editbox.mid = mid
        editbox.label = label

        editbox:SetScript("OnEnterPressed", EditBox_OnEnterPressed)
        editbox:SetScript("OnEscapePressed", EditBox_OnEscapePressed)
        editbox:SetScript("OnShow", EditBox_OnShow)
        editbox:SetScript("OnTextChanged", EditBox_OnTextChanged)
    end
    local template = dialog.delegate.editboxes[index]

    active_editboxes[#active_editboxes + 1] = editbox

    editbox.addHighlightedText = true

    editbox:SetParent(dialog)
    editbox:SetID(index)
    editbox:SetWidth(template.width or DEFAULT_EDITBOX_WIDTH)

    editbox:SetAutoFocus(template.auto_focus)

    if not template.auto_focus then
        editbox:ClearFocus()
    end
    editbox:SetMaxLetters(template.max_letters or 0)
    editbox:SetMaxBytes(template.max_bytes or 0)
    editbox:SetText(template.text or "")

    if template.label and template.label ~= "" then
        editbox.label:SetText(template.label)
        editbox.label:SetWidth(editbox.label:GetStringWidth())
    else
        editbox.label:Hide()
    end
    editbox:Show()

    return editbox
end

local function Button_OnClick(button, mouse_button, down)
    local dialog = button:GetParent()
    local hide = true
    local on_click = dialog.delegate.buttons[button:GetID()].on_click

    if on_click then
        hide = not on_click(dialog, dialog.data, "clicked")
    end

    if hide then
        dialog:Hide()
    end
end

local function _AcquireButton(parent, index)
    local button = table.remove(button_heap)

    if not button then
        local button_name = ("%s_Button%d"):format(MAJOR, #active_buttons + 1)
        button = _G.CreateFrame("Button", button_name, _G.UIParent)
        button:SetWidth(DEFAULT_BUTTON_WIDTH)
        button:SetHeight(DEFAULT_BUTTON_HEIGHT)

        button:SetNormalTexture([[Interface\Buttons\UI-DialogBox-Button-Up]])
        button:GetNormalTexture():SetTexCoord(0, 1, 0, 0.71875)

        button:SetPushedTexture([[Interface\Buttons\UI-DialogBox-Button-Down]])
        button:GetPushedTexture():SetTexCoord(0, 1, 0, 0.71875)

        button:SetDisabledTexture([[Interface\Buttons\UI-DialogBox-Button-Disabled]])
        button:GetDisabledTexture():SetTexCoord(0, 1, 0, 0.71875)

        button:SetHighlightTexture([[Interface\Buttons\UI-DialogBox-Button-Highlight]], "ADD")
        button:GetHighlightTexture():SetTexCoord(0, 1, 0, 0.71875)

        button:SetNormalFontObject("GameFontNormal")
        button:SetDisabledFontObject("GameFontDisable")
        button:SetHighlightFontObject("GameFontHighlight")

        button:SetScript("OnClick", Button_OnClick)
    end
    active_buttons[#active_buttons + 1] = button

    button:SetText(parent.delegate.buttons[index].text or "FOOF")
    button:SetParent(parent)
    button:SetID(index)

    button:Show()
    return button
end

local function _BuildDialog(delegate, data)
    if #active_dialogs == MAX_DIALOGS then
        if not queued_delegates[delegate] then
            delegate_queue[#delegate_queue + 1] = delegate
            queued_delegates[delegate] = data or ""
        end
        return
    end
    local dialog = table.remove(dialog_heap)

    if not dialog then
        dialog = _G.setmetatable(_G.CreateFrame("Frame", ("%s_Dialog%d"):format(MAJOR, #active_dialogs + 1), _G.UIParent), dialog_meta)
        dialog.is_new = true

        local close_button = _G.CreateFrame("Button", nil, dialog, "UIPanelCloseButton")
        close_button:SetPoint("TOPRIGHT", -3, -3)
        close_button:Hide()

        dialog.close_button = close_button

        local text = dialog:CreateFontString(nil, nil, "GameFontHighlight")
        text:SetWidth(DEFAULT_DIALOG_TEXT_WIDTH)
        text:SetPoint("TOP", 0, -16)

        dialog.text = text
    end
    dialog:Reset()
    dialog.delegate = delegate
    dialog.data = data

    dialog.text:SetText(delegate.text or "")
    dialog.text:SetJustifyH(delegate.text_justify_h and TEXT_HORIZONTAL_JUSTIFICATIONS[delegate.text_justify_h:upper()] or "CENTER")
    dialog.text:SetJustifyV(delegate.text_justify_v and TEXT_VERTICAL_JUSTIFICATIONS[delegate.text_justify_v:upper()] or "MIDDLE")

    if delegate.no_close_button then
        dialog.close_button:Hide()
    else
        dialog.close_button:Show()
    end

    if _G.type(delegate.icon) == "string" then
        if not dialog.icon then
            dialog.icon = dialog:CreateTexture(("%sIcon"):format(dialog:GetName()), "ARTWORK")
            dialog.icon:SetPoint("LEFT", dialog, "LEFT", 16, 0)
        end

        local icon_size = tonumber(delegate.icon_size) and delegate.icon_size or DEFAULT_ICON_SIZE
        dialog.icon:SetSize(icon_size, icon_size)
        dialog.icon:SetTexture(delegate.icon)
        dialog.icon:Show()
    elseif dialog.icon then
        dialog.icon:SetTexture()
        dialog.icon:Hide()
    end

    if delegate.buttons and #delegate.buttons > 0 then
        dialog.buttons = {}

        for index = 1, MAX_BUTTONS do
            local button = delegate.buttons[index]

            if not button then
                break
            end

            if button.text then
                table.insert(dialog.buttons, _AcquireButton(dialog, index))
            end
        end
        local NUM_BUTTONS = #dialog.buttons

        for index = 1, NUM_BUTTONS do
            local button = dialog.buttons[index]

            if index == 1 then
                if NUM_BUTTONS == 3 then
                    button:SetPoint("BOTTOMRIGHT", dialog, "BOTTOM", -72, 16)
                elseif NUM_BUTTONS == 2 then
                    button:SetPoint("BOTTOMRIGHT", dialog, "BOTTOM", -6, 16)
                elseif NUM_BUTTONS == 1 then
                    button:SetPoint("BOTTOM", dialog, "BOTTOM", 0, 16)
                end
            else
                button:SetPoint("LEFT", dialog.buttons[index - 1], "RIGHT", 13, 0)
            end
            local width = button:GetTextWidth()

            if width > 110 then
                button:SetWidth(width + 20)
            else
                button:SetWidth(120)
            end
            button:Enable()
        end
    end
    local NUM_EDITBOXES = 0

    if delegate.editboxes and #delegate.editboxes > 0 then
        dialog.editboxes = {}

        for index = 1, #delegate.editboxes do
            table.insert(dialog.editboxes, _AcquireEditBox(dialog, index))
        end
        NUM_EDITBOXES = #dialog.editboxes

        for index = 1, NUM_EDITBOXES do
            local editbox = dialog.editboxes[index]

            if index == 1 then
                editbox:SetPoint("TOP", dialog.text, "BOTTOM", 0, -8)
            else
                editbox:SetPoint("TOP", dialog.editboxes[index - 1], "BOTTOM", 0, 0)
            end
        end
    end

    if delegate.checkboxes and #delegate.checkboxes > 0 then
        dialog.checkboxes = {}

        for index = 1, #delegate.checkboxes do
            table.insert(dialog.checkboxes, _AcquireCheckBox(dialog, index))
        end
        local max_string_width = 0

        for index = 1, #dialog.checkboxes do
            local string_width = dialog.checkboxes[index].text:GetStringWidth()

            if string_width > max_string_width then
                max_string_width = string_width
            end
        end

        for index = 1, #dialog.checkboxes do
            local checkbox = dialog.checkboxes[index]
            checkbox.container:SetWidth(DEFAULT_CHECKBOX_SIZE + max_string_width)

            if index == 1 then
                if NUM_EDITBOXES > 0 then
                    checkbox.container:SetPoint("TOPLEFT", dialog.editboxes[NUM_EDITBOXES], "BOTTOMLEFT", -12, 0)
                else
                    checkbox.container:SetPoint("TOP", dialog.text, "BOTTOM", 0, -8)
                end
            else
                checkbox.container:SetPoint("TOPLEFT", dialog.checkboxes[index - 1].container, "BOTTOMLEFT", 0, 0)
            end
        end
    end
    dialog.time_remaining = delegate.duration
    return dialog
end

-----------------------------------------------------------------------
-- Library methods.
-----------------------------------------------------------------------
--- Register a new dialog delegate.
-- @name LibDialog-1.0:Register
-- @class function
-- @paramsig delegate_name, delegate
-- @param delegate_name The name the delegate table will be registered under.
-- @param delegate The delegate table definition.
function lib:Register(delegate_name, delegate)
    if _G.type(delegate_name) ~= "string" or delegate_name == "" then
        error(METHOD_USAGE_FORMAT:format("Register", "delegate_name must be a non-empty string"), 2)
    end

    if _G.type(delegate) ~= "table" then
        error(METHOD_USAGE_FORMAT:format("Register", "delegate must be a table"), 2)
    end
    delegates[delegate_name] = delegate
end

local function _FindDelegate(method_name, reference)
    local reference_type = _G.type(reference)

    if reference == "" or (reference_type ~= "string" and reference_type ~= "table") then
        error(METHOD_USAGE_FORMAT:format(method_name, "reference must be a delegate table or a non-empty string"), 3)
    end
    local delegate

    if reference_type == "string" then
        if not delegates[reference] then
            error(METHOD_USAGE_FORMAT:format(method_name, ("\"%s\" does not match a registered delegate"):format(reference)), 3)
        end
        delegate = delegates[reference]
    else
        delegate = reference
    end
    return delegate
end

--- Spawns a dialog from a delegate reference.
-- @name LibDialog-1.0:Spawn
-- @class function
-- @paramsig reference[, data]
-- @param reference The delegate to be used for the spawned dialog. Can be either a string, in which case the delegate must be registered, or a delegate definition table.
-- @param data Additional data to be passed on to the resultant dialog.
function lib:Spawn(reference, data)
    local delegate = _FindDelegate("Spawn", reference)

    -----------------------------------------------------------------------
    -- Check delegate conditionals before building.
    -----------------------------------------------------------------------
    if _G.UnitIsDeadOrGhost("player") and not delegate.show_while_dead then
        if delegate.on_cancel then
            delegate.on_cancel()
        end
        return
    end

    if _G.InCinematic() and not delegate.show_during_cinematic then
        if delegate.on_cancel then
            delegate.on_cancel()
        end
        return
    end

    if delegate.is_exclusive then
        for index = 1, #active_dialogs do
            local dialog = active_dialogs[index]

            if dialog.delegate.is_exclusive then
                if dialog.delegate.on_cancel then
                    dialog.delegate.on_cancel(dialog, dialog.data, "override")
                end
                dialog:Hide()
            end
        end
    end
    local cancel_list = delegate.cancels_on_spawn

    if cancel_list then
        for index = 1, #cancel_list do
            local delegate_name = cancel_list[index]
            local delegate_to_cancel = delegates[delegate_name]

            if delegate_to_cancel then
                for index = 1, #active_dialogs do
                    local dialog = active_dialogs[index]

                    if dialog.delegate == delegate_to_cancel then
                        dialog:Hide()

                        if dialog.delegate.on_cancel then
                            dialog.delegate.on_cancel(dialog, dialog.data, "override")
                        end
                    end
                end
            else
                error(("\"%s\" does not match a registered delegate - unable to cancel"):format(delegate_name), 2)
            end
        end
    end
    local dialog = self:ActiveDialog(reference, data)

    if dialog then
        local delegate = dialog.delegate

        if not delegate.no_cancel_on_reuse and delegate.on_cancel then
            delegate.on_cancel(dialog, dialog.data, "override")
        end
        dialog:Hide()
    end

    -----------------------------------------------------------------------
    -- Build new dialog and anchor it.
    -----------------------------------------------------------------------
    dialog = _BuildDialog(delegate, data)

    if not dialog then
        return
    end

    if delegate.sound then
        _G.PlaySound(delegate.sound)
    end

    -- Anchor to the bottom of existing dialogs. If none exist, check to see if there are visible default StaticPopupDialogs and anchor to that instead; else, anchor to UIParent.
    if #active_dialogs > 0 then
        dialog:SetPoint("TOP", active_dialogs[#active_dialogs], "BOTTOM", 0, 0)
    else
        local default_dialog = _G.StaticPopup_DisplayedFrames[#_G.StaticPopup_DisplayedFrames]

        if default_dialog then
            dialog:SetPoint("TOP", default_dialog, "BOTTOM", 0, 0)
        else
            dialog:SetPoint("TOP", _G.UIParent, "TOP", 0, -135)
        end
    end
    active_dialogs[#active_dialogs + 1] = dialog
    dialog:Show()

    if dialog.is_new then
        _Dialog_OnShow(dialog)
        dialog.is_new = nil
    end
    dialog:Resize()
    return dialog
end

--- Determines whether or not a specific dialog is currently active.
-- @name LibDialog-1.0:ActiveDialog
-- @class function
-- @paramsig reference[, data]
-- @param reference The delegate criteria for the dialog being targeted. Can be either a string, in which case the delegate must be registered, or a delegate definition table.
-- @param data Additional data to be used as further criteria to determine if the target dialog is active - this would be the same data used to spawn the dialog.
function lib:ActiveDialog(reference, data)
    local delegate = _FindDelegate("ActiveDialog", reference)

    for index = 1, #active_dialogs do
        local dialog = active_dialogs[index]

        if dialog.delegate == delegate and (not data or dialog.data == data) then
            return dialog
        end
    end
end

--- Dismisses a specific dialog.
-- @name LibDialog-1.0:Dismiss
-- @class function
-- @paramsig reference[, data]
-- @param reference The delegate criteria for the dialog being targeted. Can be either a string, in which case the delegate must be registered, or a delegate definition table.
-- @param data Additional data to be used as further criteria to identify the target dialog - this would be the same data used to spawn the dialog.
function lib:Dismiss(reference, data)
    local delegate = _FindDelegate("Dismiss", reference)

    for index = 1, #active_dialogs do
        local dialog = active_dialogs[index]

        if dialog.delegate == delegate and (not data or dialog.data == data) then
            dialog:Hide()
        end
    end
end

-----------------------------------------------------------------------
-- Dialog methods.
-----------------------------------------------------------------------
function dialog_prototype:Reset()
    self:SetWidth(DEFAULT_DIALOG_WIDTH)
    self:SetHeight(DEFAULT_DIALOG_HEIGHT)
    self:SetBackdrop(DEFAULT_DIALOG_BACKDROP)

    self:SetToplevel(true)
    self:EnableKeyboard(true)
    self:EnableMouse(true)
    self:SetFrameStrata("DIALOG")

    self:SetScript("OnShow", _Dialog_OnShow)
    self:SetScript("OnHide", _Dialog_OnHide)
    self:SetScript("OnUpdate", _Dialog_OnUpdate)
    self:SetScript("OnEvent", _Dialog_OnEvent)

    self:RegisterEvent("DISPLAY_SIZE_CHANGED")
end

function dialog_prototype:Resize()
    local delegate = self.delegate
    if not delegate then
        return
    end

    local width = delegate.width or DEFAULT_DIALOG_WIDTH
    local height = delegate.height or 0

    -- Static size ignores widgets for resizing purposes.
    if delegate.static_size then
        if width > 0 then
            self:SetWidth(width)
            self.text:SetWidth(self:GetWidth() - 30)
        end

        if height > 0 then
            self:SetHeight(height)
        end
        return
    end

    if self.buttons and #self.buttons > 0 then
        height = height + 8 + DEFAULT_BUTTON_HEIGHT

        if #self.buttons == MAX_BUTTONS then
            width = 440
        end
    end

    if self.editboxes and #self.editboxes > 0 then
        local dialog_left = self:GetLeft()
        local dialog_right = self:GetRight()
        local label_offset = 0
        local editbox_offset = 0

        for index = 1, #self.editboxes do
            local editbox = self.editboxes[index]
            local editbox_right = editbox:GetRight()
            height = height + DEFAULT_EDITBOX_HEIGHT

            if editbox_right then
                if editbox_offset < 25 and dialog_right > editbox_right and (dialog_right - editbox_right) < 25 then
                    editbox_offset = 25
                elseif editbox_right > dialog_right and editbox_offset < editbox_right - dialog_right then
                    editbox_offset = 25 + (editbox_right - dialog_right)
                end
            end

            if editbox.label:IsShown() then
                local label_left = editbox.label:GetLeft()

                if label_left and label_left < dialog_left and label_offset < dialog_left - label_left then
                    label_offset = dialog_left - label_left
                end
            end
        end
        width = width + label_offset + editbox_offset
    end

    if self.checkboxes then
        height = height + (DEFAULT_CHECKBOX_SIZE * #self.checkboxes)
    end

    if self.icon and self.icon:IsShown() then
        local icon_width = self.icon:GetWidth() + 32
        width = width + icon_width
        self.text:SetWidth(width - icon_width - (self.close_button:GetWidth() + 16))
    else
        self.text:SetWidth(width - 60)
    end
    height = height + 32 + self.text:GetHeight()

    self:SetWidth(width)
    self:SetHeight(height)
end

-----------------------------------------------------------------------
-- Default dialog events.
-----------------------------------------------------------------------
function dialog_prototype:DISPLAY_SIZE_CHANGED()
    self:Resize()
end
