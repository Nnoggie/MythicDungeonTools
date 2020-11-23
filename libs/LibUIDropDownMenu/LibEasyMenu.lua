--$Id: LibEasyMenu.lua 49 2020-08-18 17:17:08Z arithmandar $
-- Simplified Menu Display System
--	This is a basic system for displaying a menu from a structure table.
--
--	See UIDropDownMenu.lua for the menuList details.
--
--	Args:
--		menuList - menu table
--		menuFrame - the UI frame to populate
--		anchor - where to anchor the frame (e.g. CURSOR)
--		x - x offset
--		y - y offset
--		displayMode - border type
--		autoHideDelay - how long until the menu disappears
--
--
-- ----------------------------------------------------------------------------
-- Localized Lua globals.
-- ----------------------------------------------------------------------------
local _G = getfenv(0)
-- ----------------------------------------------------------------------------
local MAJOR_VERSION = "LibEasyMenu-1.0"
local MINOR_VERSION = 90000 + tonumber(("$Rev: 49 $"):match("%d+"))

local LibStub = _G.LibStub
if not LibStub then error(MAJOR_VERSION .. " requires LibStub.") end
local Lib = LibStub:NewLibrary(MAJOR_VERSION, MINOR_VERSION)
if not Lib then return end

function L_EasyMenu(menuList, menuFrame, anchor, x, y, displayMode, autoHideDelay )
	if ( displayMode == "MENU" ) then
		menuFrame.displayMode = displayMode;
	end
	L_UIDropDownMenu_Initialize(menuFrame, L_EasyMenu_Initialize, displayMode, nil, menuList);
	L_ToggleDropDownMenu(1, nil, menuFrame, anchor, x, y, menuList, nil, autoHideDelay);
end

function L_EasyMenu_Initialize( frame, level, menuList )
	for index = 1, #menuList do
		local value = menuList[index]
		if (value.text) then
			value.index = index;
			L_UIDropDownMenu_AddButton( value, level );
		end
	end
end

