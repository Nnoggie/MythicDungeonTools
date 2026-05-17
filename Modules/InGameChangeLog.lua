local _, MDT = ...

MDT.changeLog = {
  {
    tag = "6.1.3",
    date = "2026-05-17",
    notes = {
      "Split the version check window into Change Log and Party Versions tabs.",
      "Added party member MDT versions to the Party Versions tab.",
      "Fixed Magisters Terrace and Pit of Saron detection for additional zone IDs.",
      "Added a missing Scrounger in Nexus Point Xenas.",
      "Unlinked two Maisara Caverns enemies from group 91 so they can be assigned separately.",
    },
  },
  {
    tag = "6.1.2",
    date = "2026-05-05",
    notes = {
      "Added a version check and changelog window from the version text in the bottom-left corner.",
      "Added update notifications with copyable CurseForge and Wago download links when a newer party member version is detected.",
      "Added copyable GitHub, Discord, and Patreon link dialogs in the bottom toolbar.",
      "Side panel buttons now close their open dialogs when clicked again.",
      "Fixed Maisara Caverns detection for zone 2437.",
    },
  },
  {
    tag = "6.1.1",
    date = "2026-04-30",
    notes = {
      "Added assignable Witherbark Prisoners and Captives for Maisara Caverns and Pit of Saron.",
      "Unlinked various enemies which are often assigned individually to pulls.",
      "Routes which are shared multiple times will now prompt the user to choose if they want to overwrite the existing route or create a copy. Repeatedly importing the same route will no longer create many copies of the same route.",
      "Added class colored route author to route names in the route dropdown list.",
      "Fix a rare crash when loading a route before MDT was finished initializing.",
      "Improvements for Focus Marker Syncing",
      "Added a temporary workaround for dropdowns affected by a Blizzard bug. Hopefully Blizzard fixes the underlying issue soon.",
    },
  },
}
