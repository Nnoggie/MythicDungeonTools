local _, MDT = ...

-- MDT draws its text in Archivo unless the user picked another font from LibSharedMedia in the settings. The kit builds
-- its fonts once as it loads, from the file found here, so a new pick shows after a reload. A pick that is not
-- registered, such as one from an addon that is not loaded, leaves Archivo. LibSharedMedia only registers fonts whose
-- file the client knows.

local LSM = LibStub("LibSharedMedia-3.0")

local name = MythicDungeonToolsDB.global.font
MDT.userFontFile = type(name) == "string" and LSM:Fetch("font", name, true) or nil
