local _, MDT = ...

MDT.changeLog = {
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
  {
    tag = "6.3.0",
    date = "2026-10-07",
    notes = {
      "New Feature: Text tool. Write right on the map, style it with sizes, colors (including class colors) and backgrounds, and drop in spell, class, role and raid marker icons from a searchable picker or with tags like {spell:2825}. Texts sync in Live Sessions.",
      "New Feature: Box selection. Hold Shift and left-drag on the map to draw a box that adds all unpulled enemies inside it to the current pull, together with their groups unless Ctrl is held.",
      "Added Berry Bush, Barrel of Apples and Salmon Pool map icons in Den of Nalorakk. Enemies are now always drawn above map icons.",
    },
  },
}
