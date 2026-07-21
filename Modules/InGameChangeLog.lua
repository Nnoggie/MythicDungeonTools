local _, MDT = ...

MDT.changeLog = {
  {
    tag = "6.2.0-alpha3",
    date = "2026-07-21",
    notes = {
      "Added initial WoW 12.1 PTR support for Midnight Season 2.",
      "Added an option to show each pull's total health in the route sidebar. (off by default)",
      "Added an option to automatically pan the map to the selected pull. (on by default)",
      "Enemies can now be dragged on the map to move them into pulls, with a preview showing which enemies will move.",
      "New route exports and group sharing now use Blizzard's route encoding. Existing route strings still import, but new strings require this alpha or newer.",
    },
  },
  {
    tag = "6.1.20",
    date = "2026-07-03",
    notes = {
      "Added a setting to announce dungeon resets to your group",
    },
  },
}
