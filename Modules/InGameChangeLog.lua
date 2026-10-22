local _, MDT = ...

MDT.changeLog = {
  {
    tag = "6.3.15",
    date = "2026-10-23",
    notes = {
      "You can now export several routes in one string, also from different dungeons. In Export, switch to Multiple Routes, pick your routes and create the string.",
      "Importing a string with several routes lists them so you choose which to import, and whether each one overwrites the matching route you already have or comes in as a copy.",
      "Pull numbers on the map now show the pull's forces. Hover one for the pull's details, and drag it onto another pull to merge them.",
      "Murder Row's snitches are now numbered and can be assigned to players.",
      "Flourishing Stride, Overload Golems, Proofs, Mutating Elixir, Warding Incense and Rune of Anchoring can now be assigned to players.",
    },
  },
  {
    tag = "6.3.14",
    date = "2026-10-22",
    notes = {
      "Fixed the enemy info card staying open while the cursor rests between the enemy and the card.",
    },
  },
  {
    tag = "6.3.13",
    date = "2026-10-22",
    notes = {
      "You can now pin several enemy info cards at once and drag them anywhere on the map.",
      "The enemy info card now closes as soon as you move off the enemy. Hold Ctrl to keep it open.",
      "The enemy info card now shows the enemy's efficiency score.",
      "Fixed pull health overlapping the pull's forces in the sidebar when Show pull health is on.",
    },
  },
}
