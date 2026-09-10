# Enemy search integration

External launchers can search MDT's current enemy and spell data without accessing
the private UI addon table, copying a dungeon catalog, or scraping map frames.
These methods belong to `MythicDungeonToolsAPI`; feature-detect them before use.

## Reading metadata

```lua
local API = MythicDungeonToolsAPI
if not API or not API.IterateEnemies then return end
local nextEnemy, reason = API:IterateEnemies() -- optional dungeonIndex filter
if not nextEnemy then return end -- e.g. COMBAT or UI_UNAVAILABLE

-- Advance a limited number of times per batch in a large search.
local enemy = nextEnemy()
-- enemy = {
--   dungeonIndex, dungeonName, npcID, name, englishName, isBoss, spellIDs
-- }
```

- The first call loads `MythicDungeonTools_UI`, which owns the dungeon data. It
  does not initialize or show the main window. Loading the addon itself is a
  synchronous operation and retains its normal code/data and runtime setup.
  Do not call this at login just to prewarm an index. A cold call during combat
  returns `nil, "COMBAT"`; reads of already loaded data are permitted.
- Each iterator call returns one fresh metadata table with its own `spellIDs`
  array. No clone lists, spell tables, or private UI objects are exposed.
  There is no persistent cache or background task created by this API.
- `name` and `dungeonName` use MDT's active locale. `englishName` is the source
  enemy name. Resolve spell IDs with the client's spell-data API; names may need
  asynchronous loading. The API does not request every spell's data at once.
- Spell IDs follow the enemy-info blacklist, including the dev-mode exception.
  Enemies without a navigable clone are omitted. A creature is listed per MDT
  enemy definition, not per map clone; consumers may deduplicate by
  `(dungeonIndex, npcID)` when desired. Shared spells can match multiple creatures.
- Iteration order is ascending dungeon and enemy index. The iterator snapshots
  dungeon keys and each dungeon's enemy keys when reached, while reading current
  record values. It skips deleted records. Start a new iterator to include newly
  registered data; do not treat a partly consumed iterator as a permanent index.
- A missing dungeon or an exhausted iterator returns no records. Invalid or
  secret arguments return `nil, "INVALID_ARGUMENT"` before loading the UI addon.

## Opening a creature's details

```lua
local accepted, reason = API:OpenEnemyInfo(enemy.dungeonIndex, enemy.npcID, function(ok, failure)
  -- ok means the creature's detail frame was shown.
  -- Handle expected failures such as COMBAT, NOT_FOUND or SUPERSEDED here.
end)
```

The optional callback is separate from the immediate return value: `true` means
the request was accepted, not that a window is already visible. A rejected
request returns `false, reason` and does not invoke the callback. Callback errors
are sent to the game's error handler.

MDT initializes its own window if necessary, selects the maps section and dungeon,
and opens the existing enemy-info frame. Opening an already visible window does
not toggle it closed. NPC identity is resolved again at execution time, so changes
to an enemy array's order do not redirect the request to a different creature.
If several definitions share a NPC ID in one dungeon, one navigable definition
is selected. This changes the displayed dungeon and may perform MDT's normal
default-preset initialization; it does not import a route or edit a user's pulls.

Only the latest pending request is retained. An older request receives
`false, "SUPERSEDED"`; repeated requests during first initialization share one
frame-ready callback and never cancel that initialization. An accepted request
is checked again for combat, restricted environments, and removed creatures.

Expected reasons are `INVALID_ARGUMENT`, `COMBAT`, `RESTRICTED`, `NOT_FOUND`,
`UI_UNAVAILABLE`, and `SUPERSEDED`. Unexpected failures in MDT's window
initialization still use MDT's existing error reporting; they are not completion
notifications. No call automatically enables a disabled addon.

## Validation

Run from the repository root with Lua 5.1:

```text
lua scripts/test_enemy_search_api.lua
lua scripts/test_plugin_compat.lua
```

The first command exercises the actual public loader and UI bridge with stubs,
checks copy isolation, filtering, sparse/deleted data, latest-request navigation,
combat/restricted guards and callback reentrancy, then reads all dungeon files
listed in `Midnight/load_midnight.xml`. It does not validate game rendering.
The existing `/mdt test` load-on-demand test also checks API availability and
metadata shape. In-client acceptance should cover first open, an already open
window, cross-dungeon navigation, rapid repeated requests, and entering combat
while initialization is pending.
