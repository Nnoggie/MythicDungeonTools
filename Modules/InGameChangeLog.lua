local _, MDT = ...

MDT.changeLog = {
  {
    tag = "6.1.4",
    date = "2026-05-19",
    notes = {
      "Added missing dormant Dreadflails to Nexus Point Xenas.",
    },
  },
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
}
