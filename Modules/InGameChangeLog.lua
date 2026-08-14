local _, MDT = ...

MDT.changeLog = {
  {
    tag = "6.2.2",
    date = "2026-08-14",
    notes = {
      "Corrected enemy data and map positions for Altar of Fangs, Den of Nalorakk, Murder Row, and The Blinding Vale.",
    },
  },
  {
    tag = "6.2.1",
    date = "2026-08-11",
    notes = {
      "Add WoW 12.1 support for Midnight Season 2",
      "Added an option to show each pull's total health in the route sidebar. (off by default)",
      "Added an option to automatically pan the map to the selected pull. (on by default)",
      "Enemies can now be dragged on the map to move them into pulls, with a preview showing which enemies will move.",
      "New route exports and group sharing now use Blizzard's route encoding.",
      "MDT's interface now loads only when opened, reducing memory usage while MDT is not in use and reducing loading screen impact.",
    },
  },
  {
    tag = "6.2.0-alpha5",
    date = "2026-08-04",
    notes = {
      "Added initial WoW 12.1 PTR support for Midnight Season 2.",
      "Added an option to show each pull's total health in the route sidebar. (off by default)",
      "Added an option to automatically pan the map to the selected pull. (on by default)",
      "Enemies can now be dragged on the map to move them into pulls, with a preview showing which enemies will move.",
      "New route exports and group sharing now use Blizzard's route encoding. Existing route strings still import, but new strings require this alpha or newer.",
      "MDT's interface now loads only when opened, reducing memory usage while MDT is not in use and reducing loading screen impact.",
    },
  },
}
