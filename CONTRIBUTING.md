# Contributing to Mythic Dungeon Tools

- This repository comes with a `.editorconfig` file, so the following requirements will be taken care of if you have [EditorConfig](https://editorconfig.org/) installed. An editorconfig plugin for your specific editor is recommended.
  - Tabs consist of 2 spaces.
  - Files are ending with a newline.
  - Line endings in addon files must use LF.
  - No trailing whitespace at the end of a line.
- All user-facing strings must be localized via using `L["localized phrase"]`. You must use double quoted strings, and name the localization table (found at `MDT.L`) `L` in your code for this to work properly
  - Add and update translations in `Locales/` through GitHub pull requests. `enUS.lua` is the source of truth for localization keys.
- When editing enemy data please use the ingame editor available via /mdt devmode and export your changes via Enemy>Export to Lua.

