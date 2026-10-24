-- LuaLS annotations for the MDT UI kit. Not loaded by the game; scripts/test_kit.lua checks the token aliases below against Kit/Theme.lua.
---@meta

---@alias MDT.UI.ColorToken
---| "bg.panel"
---| "bg.sunken"
---| "bg.raised"
---| "bg.raised2"
---| "bg.overlay"
---| "bg.dim"
---| "bg.hover"
---| "bg.pressed"
---| "bg.selected"
---| "bg.hoverTint"
---| "bg.selectedTint"
---| "border.normal"
---| "border.strong"
---| "border.divider"
---| "text.normal"
---| "text.secondary"
---| "text.muted"
---| "text.disabled"
---| "text.inverse"
---| "accent"
---| "accent.bg"
---| "accent.bgHover"
---| "accent.border"
---| "accent.active"
---| "ok"
---| "ok.line"
---| "bar.progress"
---| "bar.ok"
---| "bar.warn"
---| "warn"
---| "live"
---| "live.bg"
---| "danger.bg"
---| "danger.bgHover"
---| "danger.border"

---@alias MDT.UI.Space
---| "xs"
---| "sm"
---| "md"
---| "lg"
---| "xl"

---@alias MDT.UI.ControlSize
---| "sm"
---| "md"
---| "lg"
---| "row"

---@alias MDT.UI.FontRole
---| "body"
---| "small"
---| "title"
---| "heading"
---| "number"
---| "display"
---| "bodyCompact"
---| "smallCompact"
---| "titleCompact"

---@alias MDT.UI.Variant
---| "default"
---| "primary"
---| "danger"
---| "ghost"
---| "icon"
---| "field"
---| "window"
---| "plain"
---| "bare"
---| "row"

---@alias MDT.UI.State "normal"|"hover"|"pressed"|"selected"|"disabled"

---@alias MDT.UI.RGBA number[] {r, g, b, a?} in 0..1. The only color shape that crosses an API.
---@alias MDT.UI.Color MDT.UI.ColorToken|MDT.UI.RGBA

---@class MDT.UI.SkinRow
---@field bg MDT.UI.ColorToken|false
---@field border MDT.UI.ColorToken|false
---@field text MDT.UI.ColorToken

---@class MDT.UI.ThemeData
---@field color table<string, string> token -> hex
---@field derived table<string, {[1]: string, [2]: "lighten"|"darken"|"mix", [3]: number, [4]: string?}>
---@field space table<MDT.UI.Space, number>
---@field size table<MDT.UI.ControlSize, number>
---@field font table<MDT.UI.FontRole, {size: number}>
---@field skin table<MDT.UI.Variant, table<MDT.UI.State, MDT.UI.SkinRow>>
---@field border number
---@field alpha {disabled: number, dragSource: number}
---@field motion {commitDelay: number, dragScrollMax: number, dragEdge: number, submenuDelay: number}

---@class MDT.UI.CommonSpec
---@field id string? container:Find(id)
---@field width number? fixed width; nil stretches in a Stack and takes the natural width in a Row. A container's natural width is the whole row, so a Stack, Row or Columns inside a Row needs an explicit width
---@field height (number|MDT.UI.ControlSize)? fixed height
---@field grow number? share of leftover space in the parent container
---@field hidden boolean? hidden children take no layout space
---@field tooltip (string|fun(): string)?

---@class MDT.UI.PropDef
---@field name string
---@field default any
---@field set fun(self: MDT.UI.Control, value: any)? nil for callback props, which are only stored
---@field relayout boolean? changing it invalidates the parent layout

---@class MDT.UI.ClassDef
---@field name string becomes UI[name]
---@field frameType string
---@field template string?
---@field mixins table[]?
---@field props MDT.UI.PropDef[] applied in declaration order on every acquire
---@field Create fun(self: MDT.UI.Control) once per physical frame
---@field OnRelease fun(self: MDT.UI.Control)?
---@field Measure (fun(self: MDT.UI.Control, availW: number): number, number)? natural width and height
---@field allProps MDT.UI.PropDef[]? filled by UI.Define: common props followed by the declared ones
---@field propIndex table<string, MDT.UI.PropDef>? filled by UI.Define
---@field pool table? filled by UI.Define

---@class MDT.UI.Control
---@field kit MDT.UI.ClassDef
---@field kitProps table<string, any>
---@field kitParent MDT.UI.Control?
---@field kitChildren MDT.UI.Control[]?
---@field [string] any

---@class MDT.UI.MenuItem
---@field kind ("action"|"choice"|"toggle"|"submenu"|"title"|"separator")? default "action"
---@field text string?
---@field detail string? muted second column
---@field trailing string? right-aligned text
---@field icon (string|number)?
---@field textColor MDT.UI.Color?
---@field font string? a font file the label is drawn in, at the body size; only rows on screen load theirs
---@field value any? choice: compared with the dropdown value
---@field checked boolean? toggle or choice
---@field disabled boolean?
---@field keepOpen boolean? toggle defaults to true, others to false
---@field tooltip string?
---@field items (MDT.UI.MenuItem[]|fun(): MDT.UI.MenuItem[])? submenu
---@field onSelect fun(item: MDT.UI.MenuItem)?
---@field key (string|number)? stable identity; defaults to the index

---@class MDT.UI.ListItem
---@field kind string selects a ListKind
---@field key string|number identity for reconcile and drag
---@field sig string? content signature; equal kind, key and sig skip the rebind
---@field [string] any

---@class MDT.UI.ListKind
---@field height number|MDT.UI.ControlSize
---@field mixin {OnCreate: fun(row: MDT.UI.Control), Bind: fun(row: MDT.UI.Control, item: MDT.UI.ListItem, index: integer, list: MDT.UI.Control), OnUnbind: fun(row: MDT.UI.Control)?}
---@field draggable boolean?
---@field selectable boolean?

---A fixed spot instead of the default placement: SetPoint(point, relativeTo, relativePoint or point, x or 0, y or 0).
---@class MDT.UI.Place
---@field point string
---@field relativeTo table
---@field relativePoint string?
---@field x number?
---@field y number?

---@class MDT.UI.DialogSpec
---@field title string
---@field key string? keyed singleton: re-opening replaces the open one with reason "replaced"
---@field width number? default 320
---@field pinned boolean? the title bar does not drag the dialog
---@field place MDT.UI.Place? default: centered on the parent, slightly above the middle
---@field parent table? default: the registered provider, else UI.Root
---@field build fun(content: MDT.UI.Control, dialog: MDT.UI.Control)?
---@field onClose fun(dialog: MDT.UI.Control, reason: "x"|"escape"|"cancel"|"confirm"|"alt"|"replaced"|"api"|"hidden")?
---@field globalName string?

---@class MDT.UI.ConfirmSpec : MDT.UI.DialogSpec
---@field text string
---@field confirm {text: string, onClick: fun(checked: boolean?), variant: MDT.UI.Variant?} footer buttons carry the ids "confirm", "alt" and "cancel"
---@field alt {text: string, onClick: fun(checked: boolean?)}?
---@field cancel {text: string?, onClick: fun()?}? onClick runs once on every dismissal except confirm, alt and "hidden" (the parent hid, usually the main window closing); a port that must react to "hidden" does it in onClose
---@field checkbox {text: string, value: boolean?, onChange: fun(value: boolean)?}?

---@class MDT.UI.PromptSpec : MDT.UI.DialogSpec
---@field label string?
---@field value string?
---@field placeholder string?
---@field multiline boolean?
---@field lines number?
---@field readOnly boolean?
---@field maxLetters number?
---@field validate (fun(text: string): boolean, string?)?
---@field build fun(content: MDT.UI.Control, dialog: MDT.UI.Control)? extra controls under the field, above the checkbox and the buttons
---@field checkbox {text: string, value: boolean?}?
---@field confirm {text: string, onClick: fun(text: string, checked: boolean?), variant: MDT.UI.Variant?}
---@field cancel {text: string?, onClick: fun()?}? same dismissal rules as MDT.UI.ConfirmSpec.cancel
