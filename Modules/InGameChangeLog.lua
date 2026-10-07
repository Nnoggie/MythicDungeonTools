local _, MDT = ...

MDT.changeLog = {
  {
    tag = "6.3.3",
    date = "2026-10-08",
    notes = {
      "Fixed the text cursor and text highlighting not showing while editing a single-line map text with the map zoomed out.",
      "The style bar of a selected map text now stays inside the map when the text is scrolled out of view, instead of moving out of the MDT window.",
    },
  },
  {
    tag = "6.3.2",
    date = "2026-10-07",
    notes = {
      "Selected map texts now have a resize handle in their bottom right corner. Drag it to change the text size while the top left corner stays in place.",
      "Opening MDT in an open-world zone like Eversong Woods no longer switches to a past season dungeon located there. Inside a dungeon or at its entrance MDT still switches to it.",
    },
  },
  {
    tag = "6.3.1",
    date = "2026-10-07",
    notes = {
      "Fixed icons in map texts being too small at small text sizes and too large at big text sizes.",
    },
  },
}
