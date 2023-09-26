local MDT = MDT
local L = MDT.L
local dungeonIndex = 19
MDT.dungeonList[dungeonIndex] = L["Siege of Boralus"]
MDT.mapInfo[dungeonIndex] = {
  viewportPositionOverrides =
  {
    [2] = {
      zoomScale = 4.2999997138977,
      horizontalPan = 499.11205542634,
      verticalPan = 38.703272826513,
    },
  },
};

local zones = { 1162 }
for _, zone in ipairs(zones) do
  MDT.zoneIdToDungeonIdx[zone] = dungeonIndex
end

MDT.dungeonMaps[dungeonIndex] = {
  [0] = "SiegeOfBoralus",
  [1] = "SiegeOfBoralus",
  [2] = "SiegeOfBoralus",
}
MDT.dungeonSubLevels[dungeonIndex] = {
  [1] = L["Siege of Boralus Sublevel"],
  [2] = L["Siege of Boralus (Upstairs)"],
}

MDT.dungeonTotalCount[dungeonIndex] = { normal = 319, teeming = 383, teemingEnabled = true }

local selectorGroup
local AceGUI = LibStub("AceGUI-3.0")
local db
local function fixBoralusShowHide(widget, frame, isFrame)
  frame = frame or MDT.main_frame
  local originalShow, originalHide = frame.Show, frame.Hide
  if not isFrame then
    widget = widget.frame
  end
  function frame:Show(...)
    if db.currentDungeonIdx == 19 then
      widget:Show()
    end
    return originalShow(self, ...);
  end

  function frame:Hide(...)
    widget:Hide()
    return originalHide(self, ...);
  end
end

function MDT:ToggleBoralusSelector(show)
  db = MDT:GetDB()
  if not selectorGroup then
    selectorGroup = AceGUI:Create("SimpleGroup")
    selectorGroup.frame:SetFrameStrata("HIGH")
    selectorGroup.frame:SetFrameLevel(50)
    if not selectorGroup.frame.SetBackdrop then
      Mixin(selectorGroup.frame, BackdropTemplateMixin)
    end
    selectorGroup.frame:SetBackdropColor(unpack(MDT.BackdropColor))
    fixBoralusShowHide(selectorGroup)
    selectorGroup:SetLayout("Flow")
    selectorGroup.frame.bg = selectorGroup.frame:CreateTexture(nil, "BACKGROUND", nil, 0)
    selectorGroup.frame.bg:SetAllPoints(selectorGroup.frame)
    selectorGroup.frame.bg:SetColorTexture(unpack(MDT.BackdropColor))
    selectorGroup:SetWidth(120)
    selectorGroup:SetHeight(120)
    selectorGroup.frame:SetPoint("TOPRIGHT", MDT.main_frame, "TOPRIGHT", 0, 0)

    local label = AceGUI:Create("Label")
    label:SetText("  Faction:")
    selectorGroup:AddChild(label)

    selectorGroup.check1 = AceGUI:Create("CheckBox")
    selectorGroup.check2 = AceGUI:Create("CheckBox")
    local check1 = selectorGroup.check1
    local check2 = selectorGroup.check2

    check1:SetLabel("Horde")
    selectorGroup:AddChild(check1)
    check1:SetCallback("OnValueChanged", function(widget, callbackName, value)
      if value then
        MDT:GetCurrentPreset().faction = 1
        MDT:UpdateBoralusSelector()
        MDT:ReloadPullButtons()
        MDT:UpdateProgressbar()
      end
      if MDT.liveSessionActive and MDT:GetCurrentPreset().uid == MDT.livePresetUID then
        MDT:LiveSession_SendBoralusSelector(1)
      end
      check1:SetValue(true)
    end)

    check2:SetLabel("Alliance")
    selectorGroup:AddChild(check2)
    check2:SetCallback("OnValueChanged", function(widget, callbackName, value)
      if value then
        MDT:GetCurrentPreset().faction = 2
        MDT:UpdateBoralusSelector()
        MDT:ReloadPullButtons()
        MDT:UpdateProgressbar()
        if MDT.liveSessionActive and MDT:GetCurrentPreset().uid == MDT.livePresetUID then
          MDT:LiveSession_SendBoralusSelector(2)
        end
      end
      check2:SetValue(true)
    end)
  end
  if show then
    selectorGroup.frame:Show()
    MDT:UpdateBoralusSelector()
  else
    selectorGroup.frame:Hide()
  end
end

function MDT:UpdateBoralusSelector()
  selectorGroup.check1:SetValue(MDT:GetCurrentPreset().faction == 1)
  selectorGroup.check2:SetValue(MDT:GetCurrentPreset().faction == 2)
  MDT:DungeonEnemies_UpdateSeasonalAffix()
  MDT:DungeonEnemies_UpdateBoralusFaction(MDT:GetCurrentPreset().faction)
end

MDT.mapPOIs[dungeonIndex] = {
  [1] = {
    [1] = {
      ["template"] = "DeathReleasePinTemplate",
      ["type"] = "graveyard",
      ["x"] = 526.6887930726,
      ["y"] = -112.09388221952,
      ["graveyardDescription"] = "siegeGraveyardNote1",
    },
    [2] = {
      ["template"] = "DeathReleasePinTemplate",
      ["type"] = "graveyard",
      ["x"] = 632.01973061572,
      ["y"] = -92.022559498794,
      ["graveyardDescription"] = "",
    },
    [3] = {
      ["template"] = "DeathReleasePinTemplate",
      ["type"] = "graveyard",
      ["x"] = 432.0393310099,
      ["y"] = -334.61016080079,
      ["graveyardDescription"] = "siegeGraveyardNote2",
    },
    [4] = {
      ["template"] = "DeathReleasePinTemplate",
      ["type"] = "graveyard",
      ["x"] = 405.60201958621,
      ["y"] = -462.91658652644,
      ["graveyardDescription"] = "siegeGraveyardNote3",
    },
    [5] = {
      ["template"] = "MapLinkPinTemplate",
      ["type"] = "sobGutters",
      ["x"] = 510.75103230284,
      ["y"] = -99.22379149751,
    },
    [6] = {
      ["template"] = "MapLinkPinTemplate",
      ["type"] = "sobGutters",
      ["x"] = 540.43646488041,
      ["y"] = -279.04184468091,
    },
    [7] = {
      ["template"] = "MapLinkPinTemplate",
      ["type"] = "generalNote",
      ["x"] = 471.82728422311,
      ["y"] = -229.95502100789,
      ["text"] = "siegeGutterNote2",
    },
    [8] = {
      ["template"] = "MapLinkPinTemplate",
      ["type"] = "generalNote",
      ["x"] = 465.16418914774,
      ["y"] = -430.03927979814,
      ["text"] = "siegeDuplicateNote",
    },
    [9] = {
      ["template"] = "MapLinkPinTemplate",
      ["type"] = "mapLink",
      ["x"] = 572.9478796215,
      ["y"] = -124.84024119419,
      ["target"] = 2,
      ["direction"] = 1,
      ["connectionIndex"] = 1,
    },
    [10] = {
      ["template"] = "VignettePinTemplate",
      ["type"] = "nyalothaSpire",
      ["x"] = 550.63726674726,
      ["y"] = -122.22662170754,
      ["scale"] = 0.7,
      ["index"] = 1,
      ["npcId"] = 161124,
      ["tooltipText"] = "Brutal Spire of Ny'alotha",
      ["weeks"] = {
        [1] = true,
        [2] = true,
        [5] = true,
        [6] = true,
        [9] = true,
        [10] = true,
      },
    },
    [11] = {
      ["template"] = "VignettePinTemplate",
      ["type"] = "nyalothaSpire",
      ["x"] = 494.06258998939,
      ["y"] = -217.12907064976,
      ["scale"] = 0.7,
      ["index"] = 2,
      ["npcId"] = 161241,
      ["tooltipText"] = "Cursed Spire of Ny'alotha",
      ["weeks"] = {
        [1] = true,
        [2] = true,
        [3] = true,
        [4] = true,
        [5] = true,
        [6] = true,
        [7] = true,
        [8] = true,
        [9] = true,
        [10] = true,
        [11] = true,
        [12] = true,
      },
    },
    [12] = {
      ["template"] = "VignettePinTemplate",
      ["type"] = "nyalothaSpire",
      ["x"] = 530.89268892545,
      ["y"] = -328.36921673268,
      ["scale"] = 0.7,
      ["index"] = 3,
      ["npcId"] = 161244,
      ["tooltipText"] = "Defiled Spire of Ny'alotha",
      ["weeks"] = {
        [1] = true,
        [2] = true,
        [3] = true,
        [4] = true,
        [5] = true,
        [6] = true,
        [7] = true,
        [8] = true,
        [9] = true,
        [10] = true,
        [11] = true,
        [12] = true,
      },
    },
    [13] = {
      ["template"] = "VignettePinTemplate",
      ["type"] = "nyalothaSpire",
      ["x"] = 424.87741140656,
      ["y"] = -396.94453369288,
      ["scale"] = 0.7,
      ["index"] = 4,
      ["npcId"] = 161243,
      ["tooltipText"] = "Entropic Spire of Ny'alotha",
      ["weeks"] = {
        [1] = true,
        [2] = true,
        [5] = true,
        [6] = true,
        [9] = true,
        [10] = true,
      },
    },
    [14] = {
      ["template"] = "VignettePinTemplate",
      ["type"] = "nyalothaSpire",
      ["x"] = 550.49052504675,
      ["y"] = -121.85313378182,
      ["scale"] = 0.7,
      ["index"] = 5,
      ["npcId"] = 161243,
      ["tooltipText"] = "Entropic Spire of Ny'alotha",
      ["weeks"] = {
        [3] = true,
        [4] = true,
        [7] = true,
        [8] = true,
        [11] = true,
        [12] = true,
      },
    },
    [15] = {
      ["template"] = "VignettePinTemplate",
      ["type"] = "nyalothaSpire",
      ["x"] = 424.87741140656,
      ["y"] = -397.50552052502,
      ["scale"] = 0.7,
      ["index"] = 6,
      ["npcId"] = 161124,
      ["tooltipText"] = "Brutal Spire of Ny'alotha",
      ["weeks"] = {
        [3] = true,
        [4] = true,
        [7] = true,
        [8] = true,
        [11] = true,
        [12] = true,
      },
    },
  },
  [2] = {
    [1] = {
      ["template"] = "MapLinkPinTemplate",
      ["type"] = "mapLink",
      ["x"] = 552.76424026611,
      ["y"] = -116.64905996375,
      ["target"] = 1,
      ["direction"] = -1,
      ["connectionIndex"] = 1,
    },
  },
};

MDT.dungeonEnemies[dungeonIndex] = {
  [1] = {
    ["name"] = "Kul Tiran Halberd",
    ["id"] = 141283,
    ["count"] = 4,
    ["health"] = 768495,
    ["scale"] = 0.7,
    ["displayId"] = 84074,
    ["creatureType"] = "Humanoid",
    ["level"] = 120,
    ["reaping"] = 148716,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Incapacitate"] = true,
      ["Silence"] = true,
      ["Polymorph"] = true,
      ["Root"] = true,
      ["Fear"] = true,
      ["Disorient"] = true,
      ["Sap"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
    },
    ["spells"] = {
      [209859] = {
      },
      [256627] = {
      },
      [277242] = {
      },
      [277564] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 611.53324048298,
        ["y"] = -94.74910945841,
        ["g"] = 1,
        ["sublevel"] = 1,
        ["faction"] = 1,
        ["infested"] = {
          [2] = true,
        },
      },
      [2] = {
        ["x"] = 603.77923440022,
        ["y"] = -110.15644771174,
        ["sublevel"] = 1,
        ["faction"] = 1,
        ["patrol"] = {
          [1] = {
            ["x"] = 603.77923440022,
            ["y"] = -110.15644771174,
          },
          [2] = {
            ["x"] = 605.50874426297,
            ["y"] = -108.10053673243,
          },
          [3] = {
            ["x"] = 606.16664761087,
            ["y"] = -102.70581962774,
          },
          [4] = {
            ["x"] = 605.50874426297,
            ["y"] = -108.10053673243,
          },
          [5] = {
            ["x"] = 605.50874426297,
            ["y"] = -108.10053673243,
          },
          [6] = {
            ["x"] = 599.19296247123,
            ["y"] = -111.12685825223,
          },
          [7] = {
            ["x"] = 583.88643955623,
            ["y"] = -107.73892927049,
          },
          [8] = {
            ["x"] = 599.19296247123,
            ["y"] = -111.12685825223,
          },
        },
        ["infested"] = {
          [3] = true,
        },
      },
      [3] = {
        ["x"] = 504.88057117788,
        ["y"] = -115.38505847239,
        ["g"] = 10,
        ["sublevel"] = 1,
        ["faction"] = 1,
        ["infested"] = {
          [3] = true,
        },
      },
      [4] = {
        ["x"] = 551.02023392022,
        ["y"] = -86.689259412394,
        ["g"] = 3,
        ["sublevel"] = 1,
        ["teeming"] = true,
      },
      [5] = {
        ["x"] = 549.70442722442,
        ["y"] = -93.926094597687,
        ["g"] = 3,
        ["sublevel"] = 1,
        ["teeming"] = true,
      },
      [6] = {
        ["x"] = 587.98214466641,
        ["y"] = -88.220507692615,
        ["g"] = 50,
        ["sublevel"] = 2,
        ["faction"] = 1,
      },
      [7] = {
        ["x"] = 584.58759124865,
        ["y"] = -98.31241038307,
        ["g"] = 50,
        ["sublevel"] = 2,
        ["faction"] = 1,
      },
      [8] = {
        ["x"] = 627.7808287114,
        ["y"] = -94.042993851526,
        ["g"] = 74,
        ["sublevel"] = 2,
        ["faction"] = 1,
      },
      [9] = {
        ["x"] = 623.57019967025,
        ["y"] = -106.28007102039,
        ["g"] = 75,
        ["sublevel"] = 2,
        ["faction"] = 1,
      },
    },
  },
  [2] = {
    ["name"] = "Kul Tiran Footman",
    ["id"] = 141495,
    ["count"] = 1,
    ["health"] = 249761,
    ["scale"] = 0.5,
    ["displayId"] = 86025,
    ["creatureType"] = "Humanoid",
    ["level"] = 120,
    ["reaping"] = 148716,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Incapacitate"] = true,
      ["Silence"] = true,
      ["Polymorph"] = true,
      ["Root"] = true,
      ["Fear"] = true,
      ["Disorient"] = true,
      ["Sap"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
    },
    ["spells"] = {
      [209859] = {
      },
      [273930] = {
      },
      [277242] = {
      },
      [277564] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 618.62184297058,
        ["y"] = -90.192147612201,
        ["g"] = 1,
        ["sublevel"] = 1,
        ["faction"] = 1,
      },
      [2] = {
        ["x"] = 617.86235023493,
        ["y"] = -95.255434327295,
        ["g"] = 1,
        ["sublevel"] = 1,
        ["faction"] = 1,
        ["infested"] = {
          [1] = true,
        },
      },
      [3] = {
        ["x"] = 618.11550723705,
        ["y"] = -99.938963809923,
        ["g"] = 1,
        ["sublevel"] = 1,
        ["faction"] = 1,
      },
      [4] = {
        ["x"] = 582.74720588507,
        ["y"] = -100.01741254831,
        ["g"] = 2,
        ["sublevel"] = 1,
        ["faction"] = 1,
      },
      [5] = {
        ["x"] = 581.48139914518,
        ["y"] = -103.94146015993,
        ["g"] = 2,
        ["sublevel"] = 1,
        ["faction"] = 1,
        ["infested"] = {
          [1] = true,
        },
      },
      [6] = {
        ["x"] = 580.21555981137,
        ["y"] = -108.49841657382,
        ["g"] = 2,
        ["sublevel"] = 1,
        ["faction"] = 1,
      },
      [7] = {
        ["x"] = 510.11098019186,
        ["y"] = -115.04246180632,
        ["g"] = 10,
        ["sublevel"] = 1,
        ["faction"] = 1,
      },
      [8] = {
        ["x"] = 512.22634355934,
        ["y"] = -117.92706622296,
        ["g"] = 10,
        ["sublevel"] = 1,
        ["faction"] = 1,
        ["infested"] = {
          [1] = true,
        },
      },
      [9] = {
        ["x"] = 589.89241286915,
        ["y"] = -99.545943130245,
        ["g"] = 50,
        ["sublevel"] = 2,
        ["faction"] = 1,
      },
      [10] = {
        ["x"] = 591.68189914226,
        ["y"] = -96.141952005365,
        ["g"] = 50,
        ["sublevel"] = 2,
        ["faction"] = 1,
      },
      [11] = {
        ["x"] = 592.5610358643,
        ["y"] = -93.284769448871,
        ["g"] = 50,
        ["sublevel"] = 2,
        ["faction"] = 1,
      },
      [12] = {
        ["x"] = 593.33027931706,
        ["y"] = -90.317684191023,
        ["g"] = 50,
        ["sublevel"] = 2,
        ["faction"] = 1,
      },
      [13] = {
        ["x"] = 629.096593417,
        ["y"] = -99.17465536839,
        ["g"] = 74,
        ["sublevel"] = 2,
        ["faction"] = 1,
      },
      [14] = {
        ["x"] = 633.04406433183,
        ["y"] = -97.332530885476,
        ["g"] = 74,
        ["sublevel"] = 2,
        ["faction"] = 1,
      },
      [15] = {
        ["x"] = 635.93882814964,
        ["y"] = -95.490406402562,
        ["g"] = 74,
        ["sublevel"] = 2,
        ["faction"] = 1,
      },
      [16] = {
        ["x"] = 622.78073710961,
        ["y"] = -111.14854770824,
        ["g"] = 75,
        ["sublevel"] = 2,
        ["faction"] = 1,
      },
      [17] = {
        ["x"] = 625.28075270657,
        ["y"] = -110.62222804079,
        ["g"] = 75,
        ["sublevel"] = 2,
        ["faction"] = 1,
      },
      [18] = {
        ["x"] = 627.91239621856,
        ["y"] = -109.43800031877,
        ["g"] = 75,
        ["sublevel"] = 2,
        ["faction"] = 1,
      },
      [19] = {
        ["x"] = 617.64905949405,
        ["y"] = -94.04310015081,
        ["g"] = 76,
        ["sublevel"] = 2,
        ["faction"] = 1,
      },
      [20] = {
        ["x"] = 614.49113019567,
        ["y"] = -95.358893672589,
        ["g"] = 76,
        ["sublevel"] = 2,
        ["faction"] = 1,
      },
      [21] = {
        ["x"] = 610.93843008907,
        ["y"] = -95.227322225992,
        ["g"] = 76,
        ["sublevel"] = 2,
        ["faction"] = 1,
      },
      [22] = {
        ["x"] = 604.75415689155,
        ["y"] = -104.96435185962,
        ["g"] = 64,
        ["sublevel"] = 2,
        ["faction"] = 1,
      },
      [23] = {
        ["x"] = 604.49099141099,
        ["y"] = -109.43810856084,
        ["g"] = 64,
        ["sublevel"] = 2,
        ["faction"] = 1,
      },
      [24] = {
        ["x"] = 603.4383407824,
        ["y"] = -113.1223744672,
        ["g"] = 64,
        ["sublevel"] = 2,
        ["faction"] = 1,
      },
    },
  },
  [3] = {
    ["name"] = "Kul Tiran Wavetender",
    ["id"] = 141284,
    ["count"] = 4,
    ["health"] = 614795,
    ["scale"] = 0.7,
    ["displayId"] = 81778,
    ["creatureType"] = "Humanoid",
    ["level"] = 120,
    ["reaping"] = 148893,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Incapacitate"] = true,
      ["Polymorph"] = true,
      ["Root"] = true,
      ["Disorient"] = true,
      ["Sap"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
    },
    ["spells"] = {
      [209859] = {
      },
      [256957] = {
      },
      [257063] = {
      },
      [257069] = {
      },
      [277242] = {
      },
      [277564] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 576.53112335304,
        ["y"] = -103.47383528397,
        ["g"] = 2,
        ["sublevel"] = 1,
        ["faction"] = 1,
        ["infested"] = {
          [2] = true,
        },
      },
      [2] = {
        ["x"] = 507.6109962998,
        ["y"] = -120.61937688321,
        ["g"] = 10,
        ["sublevel"] = 1,
        ["faction"] = 1,
        ["infested"] = {
          [2] = true,
        },
      },
      [3] = {
        ["x"] = 508.42957993605,
        ["y"] = -156.40629336908,
        ["g"] = 14,
        ["sublevel"] = 1,
        ["faction"] = 1,
        ["infested"] = {
          [3] = true,
        },
      },
      [4] = {
        ["x"] = 581.68174368838,
        ["y"] = -91.196816197011,
        ["g"] = 50,
        ["sublevel"] = 2,
        ["faction"] = 1,
      },
      [5] = {
        ["x"] = 613.96478086303,
        ["y"] = -91.148313793261,
        ["g"] = 76,
        ["sublevel"] = 2,
        ["faction"] = 1,
      },
      [6] = {
        ["x"] = 599.49091504232,
        ["y"] = -110.35918209598,
        ["g"] = 64,
        ["sublevel"] = 2,
        ["faction"] = 1,
      },
    },
  },
  [4] = {
    ["name"] = "Kul Tiran Marksman",
    ["id"] = 141285,
    ["count"] = 4,
    ["health"] = 691646,
    ["scale"] = 0.7,
    ["displayId"] = 88463,
    ["creatureType"] = "Humanoid",
    ["level"] = 120,
    ["reaping"] = 148716,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Incapacitate"] = true,
      ["Silence"] = true,
      ["Root"] = true,
      ["Fear"] = true,
      ["Disorient"] = true,
      ["Imprison"] = true,
      ["Sap"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
    },
    ["spells"] = {
      [209859] = {
      },
      [257641] = {
      },
      [277242] = {
      },
      [277564] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 555.0334026991,
        ["y"] = -97.101943149409,
        ["g"] = 3,
        ["sublevel"] = 1,
        ["faction"] = 1,
      },
      [2] = {
        ["x"] = 557.03099549273,
        ["y"] = -87.089965272499,
        ["g"] = 3,
        ["sublevel"] = 1,
        ["faction"] = 1,
        ["infested"] = {
          [2] = true,
          [3] = true,
        },
      },
      [3] = {
        ["x"] = 511.06478359356,
        ["y"] = -125.25348446226,
        ["g"] = 10,
        ["sublevel"] = 1,
        ["faction"] = 1,
      },
      [4] = {
        ["x"] = 494.73669097353,
        ["y"] = -136.00427567529,
        ["g"] = 13,
        ["sublevel"] = 1,
        ["faction"] = 1,
      },
      [5] = {
        ["x"] = 504.22957666175,
        ["y"] = -153.8062895029,
        ["g"] = 14,
        ["sublevel"] = 1,
        ["faction"] = 1,
      },
    },
  },
  [5] = {
    ["name"] = "Scrimshaw Gutter",
    ["id"] = 141566,
    ["count"] = 1,
    ["health"] = 153699,
    ["scale"] = 0.5,
    ["displayId"] = 83892,
    ["creatureType"] = "Humanoid",
    ["level"] = 120,
    ["reaping"] = 148716,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Root"] = true,
      ["Slow"] = true,
    },
    ["spells"] = {
      [256616] = {
      },
      [277564] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 542.86233404787,
        ["y"] = -87.741893475521,
        ["g"] = 4,
        ["sublevel"] = 1,
        ["faction"] = 1,
      },
      [2] = {
        ["x"] = 540.92218649805,
        ["y"] = -99.568132398982,
        ["g"] = 5,
        ["sublevel"] = 1,
        ["faction"] = 1,
      },
      [3] = {
        ["x"] = 539.48382239149,
        ["y"] = -103.92907046769,
        ["g"] = 6,
        ["sublevel"] = 1,
        ["faction"] = 1,
      },
      [4] = {
        ["x"] = 541.50319084819,
        ["y"] = -109.93231234935,
        ["g"] = 6,
        ["sublevel"] = 1,
        ["faction"] = 1,
      },
      [5] = {
        ["x"] = 521.62802118769,
        ["y"] = -103.87973231655,
        ["g"] = 7,
        ["sublevel"] = 1,
        ["faction"] = 1,
      },
      [6] = {
        ["x"] = 518.95715322177,
        ["y"] = -116.38860063055,
        ["g"] = 8,
        ["sublevel"] = 1,
        ["faction"] = 1,
      },
      [7] = {
        ["x"] = 523.97836687484,
        ["y"] = -126.67777977295,
        ["g"] = 9,
        ["sublevel"] = 1,
        ["faction"] = 1,
      },
      [8] = {
        ["x"] = 527.00164322093,
        ["y"] = -123.65452338748,
        ["g"] = 9,
        ["sublevel"] = 1,
        ["faction"] = 1,
      },
      [9] = {
        ["x"] = 499.93323993929,
        ["y"] = -125.60478957167,
        ["g"] = 11,
        ["sublevel"] = 1,
        ["faction"] = 1,
      },
      [10] = {
        ["x"] = 493.74373233938,
        ["y"] = -128.38270722552,
        ["g"] = 12,
        ["sublevel"] = 1,
        ["faction"] = 1,
      },
      [11] = {
        ["x"] = 531.70160159579,
        ["y"] = -249.61912950879,
        ["g"] = 25,
        ["sublevel"] = 1,
        ["faction"] = 1,
      },
      [12] = {
        ["x"] = 543.04486771625,
        ["y"] = -247.52958183507,
        ["g"] = 25,
        ["sublevel"] = 1,
        ["faction"] = 1,
      },
      [13] = {
        ["x"] = 533.81647645127,
        ["y"] = -256.25419647414,
        ["g"] = 25,
        ["sublevel"] = 1,
        ["faction"] = 1,
      },
      [14] = {
        ["x"] = 540.80607075495,
        ["y"] = -252.60419852913,
        ["g"] = 25,
        ["sublevel"] = 1,
        ["faction"] = 1,
      },
      [15] = {
        ["x"] = 534.32282304943,
        ["y"] = -262.2035707229,
        ["g"] = 25,
        ["sublevel"] = 1,
        ["faction"] = 1,
      },
      [16] = {
        ["x"] = 544.83592322006,
        ["y"] = -259.17136574654,
        ["g"] = 25,
        ["sublevel"] = 1,
        ["faction"] = 1,
      },
      [17] = {
        ["x"] = 549.31354276376,
        ["y"] = -254.09674905248,
        ["g"] = 25,
        ["sublevel"] = 1,
        ["faction"] = 1,
      },
      [18] = {
        ["x"] = 513.48725074411,
        ["y"] = -281.78978442034,
        ["g"] = 26,
        ["sublevel"] = 1,
        ["faction"] = 1,
      },
      [19] = {
        ["x"] = 520.24441555424,
        ["y"] = -284.49819137727,
        ["g"] = 27,
        ["sublevel"] = 1,
        ["faction"] = 1,
      },
      [20] = {
        ["x"] = 558.94605246634,
        ["y"] = -291.49049888556,
        ["g"] = 28,
        ["sublevel"] = 1,
        ["faction"] = 1,
      },
      [21] = {
        ["x"] = 548.67209807094,
        ["y"] = -299.02474425839,
        ["g"] = 29,
        ["sublevel"] = 1,
        ["faction"] = 1,
      },
      [22] = {
        ["x"] = 533.6977027601,
        ["y"] = -303.96667733386,
        ["g"] = 30,
        ["sublevel"] = 1,
        ["faction"] = 1,
      },
      [23] = {
        ["x"] = 525.34327180333,
        ["y"] = -303.33376853159,
        ["g"] = 31,
        ["sublevel"] = 1,
        ["faction"] = 1,
      },
      [24] = {
        ["x"] = 532.60962121856,
        ["y"] = -310.38854239272,
        ["g"] = 31,
        ["sublevel"] = 1,
        ["faction"] = 1,
      },
      [25] = {
        ["x"] = 520.05602776878,
        ["y"] = -308.23708254048,
        ["g"] = 32,
        ["sublevel"] = 1,
        ["faction"] = 1,
      },
      [26] = {
        ["x"] = 461.74934602061,
        ["y"] = -228.99519617792,
        ["g"] = 72,
        ["sublevel"] = 1,
        ["week"] = {
          [2] = true,
          [5] = true,
          [8] = true,
          [11] = true,
        },
      },
      [27] = {
        ["x"] = 465.85256533526,
        ["y"] = -229.08355032762,
        ["g"] = 72,
        ["sublevel"] = 1,
      },
      [28] = {
        ["x"] = 463.92330674024,
        ["y"] = -234.42998602391,
        ["g"] = 72,
        ["sublevel"] = 1,
      },
      [29] = {
        ["x"] = 467.83630915541,
        ["y"] = -234.21258248841,
        ["g"] = 72,
        ["sublevel"] = 1,
      },
    },
  },
  [6] = {
    ["name"] = "Sergeant Bainbridge",
    ["id"] = 128649,
    ["count"] = 0,
    ["health"] = 4303572,
    ["scale"] = 0.8,
    ["displayId"] = 84382,
    ["creatureType"] = "Humanoid",
    ["level"] = 122,
    ["isBoss"] = true,
    ["encounterID"] = 2133,
    ["instanceID"] = 1023,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [256867] = {
      },
      [257650] = {
      },
      [260924] = {
      },
      [260954] = {
      },
      [261428] = {
      },
      [273681] = {
      },
      [273716] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 488.41561252114,
        ["y"] = -155.97452951895,
        ["g"] = 16,
        ["sublevel"] = 1,
        ["faction"] = 1,
      },
    },
  },
  [7] = {
    ["name"] = "Kul Tiran Vanguard",
    ["id"] = 132530,
    ["count"] = 0,
    ["health"] = 768495,
    ["scale"] = 1,
    ["displayId"] = 84074,
    ["creatureType"] = "Humanoid",
    ["level"] = 121,
    ["reaping"] = 148894,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Incapacitate"] = true,
      ["Disorient"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
    },
    ["spells"] = {
      [257292] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 480.38450693339,
        ["y"] = -150.64514896904,
        ["g"] = 16,
        ["sublevel"] = 1,
        ["faction"] = 1,
      },
    },
  },
  [8] = {
    ["name"] = "Kul Tiran Marksman",
    ["id"] = 132532,
    ["count"] = 0,
    ["health"] = 768495,
    ["scale"] = 1,
    ["displayId"] = 88463,
    ["creatureType"] = "Humanoid",
    ["level"] = 120,
    ["reaping"] = 148716,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Incapacitate"] = true,
      ["Silence"] = true,
      ["Fear"] = true,
      ["Imprison"] = true,
      ["Sap"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
    },
    ["spells"] = {
      [257641] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 491.66111302538,
        ["y"] = -165.32599550048,
        ["g"] = 16,
        ["sublevel"] = 1,
        ["faction"] = 1,
      },
    },
  },
  [9] = {
    ["name"] = "Dockhound Packmaster",
    ["id"] = 129373,
    ["count"] = 4,
    ["health"] = 768495,
    ["scale"] = 0.7,
    ["displayId"] = 84143,
    ["creatureType"] = "Humanoid",
    ["level"] = 120,
    ["reaping"] = 148716,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Root"] = true,
      ["Fear"] = true,
      ["Disorient"] = true,
    },
    ["spells"] = {
      [256986] = {
      },
      [257036] = {
      },
      [277564] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 473.7446938071,
        ["y"] = -164.35636428934,
        ["g"] = 17,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 514.69011845294,
        ["y"] = -116.96394053995,
        ["g"] = 56,
        ["sublevel"] = 1,
        ["faction"] = 2,
        ["patrol"] = {
          [1] = {
            ["x"] = 514.09318497487,
            ["y"] = -115.64361615773,
          },
          [2] = {
            ["x"] = 518.01070909048,
            ["y"] = -118.6996791931,
          },
          [3] = {
            ["x"] = 523.96007826603,
            ["y"] = -123.25663588204,
          },
          [4] = {
            ["x"] = 527.6309690971,
            ["y"] = -119.83891836534,
          },
          [5] = {
            ["x"] = 522.31450876202,
            ["y"] = -110.85157263151,
          },
          [6] = {
            ["x"] = 510.66893829298,
            ["y"] = -108.1933478963,
          },
          [7] = {
            ["x"] = 513.70690941894,
            ["y"] = -115.15537230305,
          },
        },
        ["infested"] = {
          [2] = true,
        },
      },
      [3] = {
        ["x"] = 509.83375846379,
        ["y"] = -109.30460389054,
        ["g"] = 57,
        ["sublevel"] = 1,
        ["faction"] = 2,
        ["patrol"] = {
          [1] = {
            ["x"] = 509.83375846379,
            ["y"] = -109.30460389054,
          },
          [2] = {
            ["x"] = 511.06662366154,
            ["y"] = -104.64708805649,
          },
          [3] = {
            ["x"] = 507.09402738896,
            ["y"] = -100.12653348292,
          },
          [4] = {
            ["x"] = 499.83374009862,
            ["y"] = -107.24981503127,
          },
          [5] = {
            ["x"] = 503.94333623437,
            ["y"] = -116.4278946475,
          },
          [6] = {
            ["x"] = 509.97073057483,
            ["y"] = -109.30461897796,
          },
        },
        ["infested"] = {
          [3] = true,
        },
      },
      [4] = {
        ["x"] = 505.91412599434,
        ["y"] = -148.84981394232,
        ["g"] = 14,
        ["sublevel"] = 1,
        ["faction"] = 2,
      },
      [5] = {
        ["x"] = 518.73754193276,
        ["y"] = -133.8297766545,
        ["g"] = 55,
        ["sublevel"] = 1,
        ["faction"] = 2,
        ["teeming"] = true,
      },
    },
  },
  [10] = {
    ["name"] = "Snarling Dockhound",
    ["id"] = 129640,
    ["count"] = 4,
    ["health"] = 768495,
    ["scale"] = 0.7,
    ["displayId"] = 30222,
    ["creatureType"] = "Humanoid",
    ["level"] = 120,
    ["reaping"] = 148716,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Root"] = true,
      ["Fear"] = true,
      ["Disorient"] = true,
    },
    ["spells"] = {
      [256897] = {
      },
      [256969] = {
      },
      [256971] = {
      },
      [257145] = {
      },
      [277564] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 474.3417293891,
        ["y"] = -158.68471201329,
        ["g"] = 17,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 501.73370958867,
        ["y"] = -100.61038402785,
        ["g"] = 54,
        ["sublevel"] = 1,
        ["faction"] = 2,
      },
      [3] = {
        ["x"] = 497.76110155846,
        ["y"] = -103.76107518243,
        ["g"] = 54,
        ["sublevel"] = 1,
        ["faction"] = 2,
        ["infested"] = {
          [2] = true,
        },
      },
      [4] = {
        ["x"] = 509.53003373962,
        ["y"] = -119.18260787833,
        ["g"] = 56,
        ["sublevel"] = 1,
        ["faction"] = 2,
      },
      [5] = {
        ["x"] = 504.49128113579,
        ["y"] = -111.77036627504,
        ["g"] = 57,
        ["sublevel"] = 1,
        ["faction"] = 2,
      },
      [6] = {
        ["x"] = 507.88130892115,
        ["y"] = -153.6039050116,
        ["g"] = 14,
        ["sublevel"] = 1,
        ["faction"] = 2,
      },
      [7] = {
        ["x"] = 524.81361164915,
        ["y"] = -131.80441827157,
        ["g"] = 55,
        ["sublevel"] = 1,
        ["faction"] = 2,
        ["teeming"] = true,
      },
    },
  },
  [11] = {
    ["name"] = "Riptide Shredder",
    ["id"] = 129371,
    ["count"] = 4,
    ["health"] = 768495,
    ["scale"] = 0.7,
    ["displayId"] = 86085,
    ["creatureType"] = "Humanoid",
    ["level"] = 120,
    ["reaping"] = 148716,
    ["characteristics"] = {
      ["Silence"] = true,
      ["Root"] = true,
      ["Fear"] = true,
      ["Disorient"] = true,
      ["Stun"] = true,
    },
    ["spells"] = {
      [256709] = {
      },
      [256866] = {
      },
      [257270] = {
      },
      [277242] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 473.14769665675,
        ["y"] = -169.28172529054,
        ["g"] = 17,
        ["sublevel"] = 1,
        ["infested"] = {
          [2] = true,
        },
      },
      [2] = {
        ["x"] = 551.42484025945,
        ["y"] = -113.46100782736,
        ["g"] = 51,
        ["sublevel"] = 1,
        ["faction"] = 2,
        ["infested"] = {
          [3] = true,
        },
      },
      [3] = {
        ["x"] = 535.03567479994,
        ["y"] = -118.77616417887,
        ["g"] = 52,
        ["sublevel"] = 1,
        ["faction"] = 2,
        ["infested"] = {
          [2] = true,
        },
      },
      [4] = {
        ["x"] = 519.8173194764,
        ["y"] = -128.73495120029,
        ["g"] = 55,
        ["sublevel"] = 1,
        ["faction"] = 2,
      },
      [5] = {
        ["x"] = 516.05231481307,
        ["y"] = -124.48837059538,
        ["g"] = 55,
        ["sublevel"] = 1,
        ["faction"] = 2,
      },
      [6] = {
        ["x"] = 514.6556173333,
        ["y"] = -157.25579142165,
        ["g"] = 14,
        ["sublevel"] = 1,
        ["faction"] = 2,
      },
    },
  },
  [12] = {
    ["name"] = "Blacktar Bomber",
    ["id"] = 129372,
    ["count"] = 4,
    ["health"] = 503570,
    ["scale"] = 0.7,
    ["displayId"] = 84136,
    ["creatureType"] = "Humanoid",
    ["level"] = 120,
    ["reaping"] = 148893,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Incapacitate"] = true,
      ["Silence"] = true,
      ["Fear"] = true,
      ["Disorient"] = true,
      ["Stun"] = true,
    },
    ["spells"] = {
      [256639] = {
      },
      [256640] = {
      },
      [256660] = {
      },
      [256673] = {
      },
      [277564] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 469.34510744504,
        ["y"] = -157.54157102797,
        ["g"] = 17,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 601.25835863159,
        ["y"] = -81.41203802658,
        ["g"] = 49,
        ["sublevel"] = 2,
        ["faction"] = 2,
      },
      [3] = {
        ["x"] = 605.44071825455,
        ["y"] = -78.881963201472,
        ["g"] = 49,
        ["sublevel"] = 2,
        ["faction"] = 2,
        ["infested"] = {
          [2] = true,
        },
      },
      [4] = {
        ["x"] = 537.00937367395,
        ["y"] = -123.7761565288,
        ["g"] = 52,
        ["sublevel"] = 1,
        ["faction"] = 2,
      },
      [5] = {
        ["x"] = 518.82062416232,
        ["y"] = -98.008462251592,
        ["g"] = 53,
        ["sublevel"] = 1,
        ["faction"] = 2,
      },
      [6] = {
        ["x"] = 513.01662807308,
        ["y"] = -96.003117622003,
        ["g"] = 53,
        ["sublevel"] = 1,
        ["faction"] = 2,
      },
      [7] = {
        ["x"] = 521.29167449675,
        ["y"] = -123.9390118827,
        ["g"] = 55,
        ["sublevel"] = 1,
        ["faction"] = 2,
      },
      [8] = {
        ["x"] = 494.84812645343,
        ["y"] = -138.06983172419,
        ["g"] = 13,
        ["sublevel"] = 1,
        ["faction"] = 2,
        ["infested"] = {
          [2] = true,
        },
      },
      [9] = {
        ["x"] = 621.1124097053,
        ["y"] = -101.7233227299,
        ["g"] = 67,
        ["sublevel"] = 2,
        ["faction"] = 2,
        ["patrol"] = {
          [1] = {
            ["x"] = 621.1124097053,
            ["y"] = -101.7233227299,
          },
          [2] = {
            ["x"] = 623.99900107652,
            ["y"] = -105.22847445126,
          },
          [3] = {
            ["x"] = 628.94743963497,
            ["y"] = -106.15631718858,
          },
          [4] = {
            ["x"] = 624.51446287333,
            ["y"] = -105.84703922565,
          },
          [5] = {
            ["x"] = 620.90622144717,
            ["y"] = -101.7233227299,
          },
          [6] = {
            ["x"] = 617.09179176288,
            ["y"] = -96.671785618132,
          },
          [7] = {
            ["x"] = 612.24642963646,
            ["y"] = -93.888270678931,
          },
          [8] = {
            ["x"] = 605.33922032282,
            ["y"] = -94.919198696802,
          },
          [9] = {
            ["x"] = 603.99899664497,
            ["y"] = -102.34187865577,
          },
          [10] = {
            ["x"] = 599.46292575426,
            ["y"] = -103.57899050751,
          },
          [11] = {
            ["x"] = 603.89591136442,
            ["y"] = -102.1356948219,
          },
          [12] = {
            ["x"] = 605.44231445188,
            ["y"] = -94.816108991998,
          },
          [13] = {
            ["x"] = 613.27735323007,
            ["y"] = -93.063535343451,
          },
          [14] = {
            ["x"] = 617.09179176288,
            ["y"] = -96.87796060348,
          },
        },
        ["infested"] = {
          [2] = true,
        },
      },
      [10] = {
        ["x"] = 624.10209520559,
        ["y"] = -97.702713636003,
        ["g"] = 67,
        ["sublevel"] = 2,
        ["faction"] = 2,
      },
    },
  },
  [13] = {
    ["name"] = "Irontide Raider",
    ["id"] = 129369,
    ["count"] = 8,
    ["health"] = 1229592,
    ["scale"] = 0.7,
    ["displayId"] = 84134,
    ["creatureType"] = "Humanoid",
    ["level"] = 121,
    ["reaping"] = 148894,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [209859] = {
      },
      [257170] = {
      },
      [272662] = {
      },
      [275775] = {
      },
      [277564] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 468.33596087699,
        ["y"] = -167.80107108496,
        ["g"] = 17,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 458.70672577275,
        ["y"] = -170.28785747658,
        ["g"] = 18,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 491.4545635217,
        ["y"] = -199.99033346525,
        ["sublevel"] = 1,
        ["infested"] = {
          [3] = true,
        },
      },
      [4] = {
        ["x"] = 620.53354910339,
        ["y"] = -84.116425391151,
        ["sublevel"] = 2,
        ["faction"] = 2,
        ["patrol"] = {
          [1] = {
            ["x"] = 620.53354910339,
            ["y"] = -84.116425391151,
          },
          [2] = {
            ["x"] = 607.64378304779,
            ["y"] = -82.051306898429,
          },
          [3] = {
            ["x"] = 620.17124960584,
            ["y"] = -84.139227423379,
          },
          [4] = {
            ["x"] = 628.6327949566,
            ["y"] = -90.293069155625,
          },
        },
        ["infested"] = {
          [3] = true,
        },
      },
      [5] = {
        ["x"] = 569.86996550556,
        ["y"] = -87.414128133822,
        ["sublevel"] = 2,
        ["faction"] = 2,
        ["patrol"] = {
          [1] = {
            ["x"] = 569.86996550556,
            ["y"] = -87.414128133822,
          },
          [2] = {
            ["x"] = 579.33438848966,
            ["y"] = -89.63270258664,
          },
          [3] = {
            ["x"] = 569.17045994803,
            ["y"] = -87.173688751619,
          },
          [4] = {
            ["x"] = 561.79341140767,
            ["y"] = -86.517942348544,
          },
          [5] = {
            ["x"] = 561.13766500459,
            ["y"] = -82.747449777977,
          },
          [6] = {
            ["x"] = 561.79341140767,
            ["y"] = -86.517942348544,
          },
          [7] = {
            ["x"] = 569.49834722018,
            ["y"] = -87.337625352388,
          },
        },
        ["infested"] = {
          [3] = true,
        },
      },
      [6] = {
        ["x"] = 491.21178203991,
        ["y"] = -135.1607642719,
        ["g"] = 13,
        ["sublevel"] = 1,
        ["faction"] = 2,
        ["infested"] = {
        },
      },
      [7] = {
        ["x"] = 597.70059471696,
        ["y"] = -86.343198168183,
        ["sublevel"] = 2,
        ["faction"] = 2,
        ["teeming"] = true,
        ["patrol"] = {
          [1] = {
            ["x"] = 597.70059471696,
            ["y"] = -86.343198168183,
          },
          [2] = {
            ["x"] = 607.53664928816,
            ["y"] = -82.408769304402,
          },
          [3] = {
            ["x"] = 597.70059471696,
            ["y"] = -86.015317956974,
          },
          [4] = {
            ["x"] = 591.96288449159,
            ["y"] = -94.539922036352,
          },
        },
      },
    },
  },
  [14] = {
    ["name"] = "Irontide Marauder",
    ["id"] = 135258,
    ["count"] = 1,
    ["health"] = 153699,
    ["scale"] = 0.5,
    ["displayId"] = 79068,
    ["creatureType"] = "Humanoid",
    ["level"] = 120,
    ["reaping"] = 148716,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Silence"] = true,
      ["Root"] = true,
      ["Disorient"] = true,
      ["Sap"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
    },
    ["spells"] = {
      [209859] = {
      },
      [257168] = {
      },
      [277242] = {
      },
      [277564] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 462.86486974263,
        ["y"] = -167.89184884854,
        ["g"] = 18,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 459.45828838408,
        ["y"] = -163.16658307654,
        ["g"] = 18,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 452.75497948599,
        ["y"] = -166.02372556507,
        ["g"] = 18,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 454.07366861541,
        ["y"] = -170.96877914661,
        ["g"] = 18,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 473.5233553089,
        ["y"] = -192.00199282486,
        ["g"] = 19,
        ["sublevel"] = 1,
      },
      [6] = {
        ["x"] = 480.22183192311,
        ["y"] = -181.97309174938,
        ["g"] = 20,
        ["sublevel"] = 1,
      },
      [7] = {
        ["x"] = 483.53047972331,
        ["y"] = -180.78612370641,
        ["g"] = 20,
        ["sublevel"] = 1,
        ["infested"] = {
          [1] = true,
        },
      },
      [8] = {
        ["x"] = 487.30441540797,
        ["y"] = -182.40350109144,
        ["g"] = 20,
        ["sublevel"] = 1,
      },
      [9] = {
        ["x"] = 479.1174607118,
        ["y"] = -185.58175782923,
        ["g"] = 20,
        ["sublevel"] = 1,
      },
      [10] = {
        ["x"] = 515.78610180136,
        ["y"] = -260.75901813759,
        ["g"] = 24,
        ["sublevel"] = 1,
        ["infested"] = {
          [1] = true,
        },
      },
      [11] = {
        ["x"] = 519.28350922565,
        ["y"] = -270.56657035096,
        ["g"] = 24,
        ["sublevel"] = 1,
      },
      [12] = {
        ["x"] = 519.1309083453,
        ["y"] = -322.28836371105,
        ["g"] = 33,
        ["sublevel"] = 1,
      },
      [13] = {
        ["x"] = 515.44946891385,
        ["y"] = -313.2846105706,
        ["g"] = 33,
        ["sublevel"] = 1,
      },
      [14] = {
        ["x"] = 532.27750301453,
        ["y"] = -250.65116619044,
        ["g"] = 69,
        ["sublevel"] = 1,
        ["faction"] = 2,
      },
      [15] = {
        ["x"] = 533.37640905039,
        ["y"] = -256.25554547281,
        ["g"] = 69,
        ["sublevel"] = 1,
        ["faction"] = 2,
      },
      [16] = {
        ["x"] = 534.36541410753,
        ["y"] = -262.18961825941,
        ["g"] = 69,
        ["sublevel"] = 1,
        ["faction"] = 2,
      },
      [17] = {
        ["x"] = 540.84893048012,
        ["y"] = -254.82698366049,
        ["g"] = 69,
        ["sublevel"] = 1,
        ["faction"] = 2,
      },
      [18] = {
        ["x"] = 544.36542224934,
        ["y"] = -248.3434672879,
        ["g"] = 69,
        ["sublevel"] = 1,
        ["faction"] = 2,
      },
      [19] = {
        ["x"] = 546.67311643591,
        ["y"] = -253.17862460669,
        ["g"] = 69,
        ["sublevel"] = 1,
        ["faction"] = 2,
      },
      [20] = {
        ["x"] = 546.34344179557,
        ["y"] = -259.44236260169,
        ["g"] = 69,
        ["sublevel"] = 1,
        ["faction"] = 2,
      },
      [21] = {
        ["x"] = 513.20142929376,
        ["y"] = -280.19050238962,
        ["g"] = 26,
        ["sublevel"] = 1,
        ["faction"] = 2,
      },
      [22] = {
        ["x"] = 519.97006938083,
        ["y"] = -286.86374235242,
        ["g"] = 26,
        ["sublevel"] = 1,
        ["faction"] = 2,
      },
      [23] = {
        ["x"] = 522.22719227815,
        ["y"] = -310.36589122076,
        ["g"] = 71,
        ["sublevel"] = 1,
        ["faction"] = 2,
      },
      [24] = {
        ["x"] = 527.39202895326,
        ["y"] = -305.2010639776,
        ["g"] = 71,
        ["sublevel"] = 1,
        ["faction"] = 2,
      },
      [25] = {
        ["x"] = 536.51290472081,
        ["y"] = -310.47578748351,
        ["g"] = 71,
        ["sublevel"] = 1,
        ["faction"] = 2,
      },
      [26] = {
        ["x"] = 537.94146653314,
        ["y"] = -303.66259647058,
        ["g"] = 71,
        ["sublevel"] = 1,
        ["faction"] = 2,
      },
      [27] = {
        ["x"] = 551.67773067384,
        ["y"] = -300.58567088849,
        ["g"] = 71,
        ["sublevel"] = 1,
        ["faction"] = 2,
      },
      [28] = {
        ["x"] = 562.11729557082,
        ["y"] = -292.6735879876,
        ["g"] = 71,
        ["sublevel"] = 1,
        ["faction"] = 2,
      },
    },
  },
  [15] = {
    ["name"] = "Irontide Waveshaper",
    ["id"] = 129370,
    ["count"] = 4,
    ["health"] = 614795,
    ["scale"] = 0.7,
    ["displayId"] = 79077,
    ["creatureType"] = "Humanoid",
    ["level"] = 120,
    ["reaping"] = 148893,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Incapacitate"] = true,
      ["Silence"] = true,
      ["Root"] = true,
      ["Disorient"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
    },
    ["spells"] = {
      [209859] = {
      },
      [256957] = {
      },
      [257063] = {
      },
      [257069] = {
      },
      [277242] = {
      },
      [277564] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 471.52332841602,
        ["y"] = -188.50199940652,
        ["g"] = 19,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 519.95185520218,
        ["y"] = -263.30361658651,
        ["g"] = 24,
        ["sublevel"] = 1,
        ["infested"] = {
          [2] = true,
        },
      },
      [3] = {
        ["x"] = 511.89682471573,
        ["y"] = -315.91619008166,
        ["g"] = 33,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 617.93414560563,
        ["y"] = -77.353710214649,
        ["g"] = 48,
        ["sublevel"] = 2,
        ["faction"] = 2,
      },
      [5] = {
        ["x"] = 576.44349772987,
        ["y"] = -103.73821922814,
        ["g"] = 2,
        ["sublevel"] = 1,
        ["faction"] = 2,
        ["infested"] = {
          [2] = true,
        },
      },
      [6] = {
        ["x"] = 595.45836111139,
        ["y"] = -103.06566560425,
        ["g"] = 64,
        ["sublevel"] = 2,
        ["faction"] = 2,
        ["infested"] = {
          [2] = true,
        },
      },
      [7] = {
        ["x"] = 600.98309032554,
        ["y"] = -90.686818211602,
        ["g"] = 65,
        ["sublevel"] = 2,
        ["faction"] = 2,
      },
    },
  },
  [16] = {
    ["name"] = "Ashvane Commander",
    ["id"] = 128969,
    ["count"] = 8,
    ["health"] = 1229592,
    ["scale"] = 0.8,
    ["displayId"] = 84067,
    ["creatureType"] = "Humanoid",
    ["level"] = 121,
    ["reaping"] = 148894,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [209859] = {
      },
      [272874] = {
      },
      [275826] = {
      },
      [277564] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 484.90910033886,
        ["y"] = -206.5357810425,
        ["g"] = 22,
        ["sublevel"] = 1,
        ["patrol"] = {
          [1] = {
            ["x"] = 484.90910033886,
            ["y"] = -206.5357810425,
          },
          [2] = {
            ["x"] = 482.1818383178,
            ["y"] = -216.35396801396,
          },
          [3] = {
            ["x"] = 484.90910033886,
            ["y"] = -206.5357810425,
          },
          [4] = {
            ["x"] = 487.63639357109,
            ["y"] = -195.80850673069,
          },
          [5] = {
            ["x"] = 483.27274624734,
            ["y"] = -184.53579405968,
          },
          [6] = {
            ["x"] = 487.63639357109,
            ["y"] = -195.80850673069,
          },
        },
        ["infested"] = {
        },
      },
      [2] = {
        ["x"] = 510.97576002868,
        ["y"] = -320.12672068742,
        ["g"] = 33,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 393.59753324218,
        ["y"] = -420.82814705587,
        ["g"] = 43,
        ["sublevel"] = 1,
        ["infested"] = {
        },
      },
      [4] = {
        ["x"] = 415.03165322869,
        ["y"] = -440.25697538332,
        ["g"] = 44,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 438.5879804993,
        ["y"] = -351.35677964077,
        ["g"] = 46,
        ["sublevel"] = 1,
        ["teeming"] = true,
        ["patrol"] = {
          [1] = {
            ["x"] = 438.5879804993,
            ["y"] = -351.35677964077,
          },
          [2] = {
            ["x"] = 432.00416104678,
            ["y"] = -356.75260411944,
          },
          [3] = {
            ["x"] = 429.52889045506,
            ["y"] = -364.32436306244,
          },
          [4] = {
            ["x"] = 429.66587855166,
            ["y"] = -373.09147778937,
          },
          [5] = {
            ["x"] = 436.24122488478,
            ["y"] = -377.61203206765,
          },
          [6] = {
            ["x"] = 441.99464263833,
            ["y"] = -368.8449114619,
          },
          [7] = {
            ["x"] = 447.6110722953,
            ["y"] = -359.5298443486,
          },
          [8] = {
            ["x"] = 450.76176324408,
            ["y"] = -351.85861087917,
          },
          [9] = {
            ["x"] = 446.10422674802,
            ["y"] = -346.51615741539,
          },
          [10] = {
            ["x"] = 438.56997549637,
            ["y"] = -351.03669405723,
          },
        },
      },
      [6] = {
        ["x"] = 442.30890109985,
        ["y"] = -353.68238246198,
        ["g"] = 46,
        ["sublevel"] = 1,
        ["teeming"] = true,
        ["patrol"] = {
        },
      },
    },
  },
  [17] = {
    ["name"] = "Irontide Powdershot",
    ["id"] = 137521,
    ["count"] = 4,
    ["health"] = 153699,
    ["scale"] = 0.7,
    ["displayId"] = 85144,
    ["creatureType"] = "Humanoid",
    ["level"] = 120,
    ["reaping"] = 148716,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Incapacitate"] = true,
      ["Silence"] = true,
      ["Polymorph"] = true,
      ["Root"] = true,
      ["Fear"] = true,
      ["Disorient"] = true,
      ["Imprison"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
    },
    ["spells"] = {
      [209859] = {
      },
      [257641] = {
      },
      [277242] = {
      },
      [277564] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 486.3242648423,
        ["y"] = -218.3276374044,
        ["g"] = 21,
        ["sublevel"] = 1,
        ["infested"] = {
          [2] = true,
        },
      },
      [2] = {
        ["x"] = 489.4545682518,
        ["y"] = -207.44487618564,
        ["g"] = 22,
        ["sublevel"] = 1,
        ["infested"] = {
          [2] = true,
        },
      },
      [3] = {
        ["x"] = 479.27275570754,
        ["y"] = -205.26305252377,
        ["g"] = 22,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 521.17080335879,
        ["y"] = -267.32735182055,
        ["g"] = 24,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 514.65999618989,
        ["y"] = -322.49513885932,
        ["g"] = 33,
        ["sublevel"] = 1,
        ["infested"] = {
          [2] = true,
        },
      },
      [6] = {
        ["x"] = 554.37361696464,
        ["y"] = -88.242497399788,
        ["g"] = 3,
        ["sublevel"] = 1,
        ["faction"] = 2,
        ["infested"] = {
          [2] = true,
          [3] = true,
        },
      },
      [7] = {
        ["x"] = 553.50087563308,
        ["y"] = -95.415274161499,
        ["g"] = 3,
        ["sublevel"] = 1,
        ["faction"] = 2,
      },
    },
  },
  [18] = {
    ["name"] = "Ashvane Spotter",
    ["id"] = 138255,
    ["count"] = 4,
    ["health"] = 768495,
    ["scale"] = 0.7,
    ["displayId"] = 86436,
    ["creatureType"] = "Humanoid",
    ["level"] = 121,
    ["reaping"] = 148894,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Root"] = true,
      ["Slow"] = true,
    },
    ["spells"] = {
      [209859] = {
      },
      [272418] = {
      },
      [272421] = {
      },
      [272422] = {
      },
      [272471] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 497.45243530088,
        ["y"] = -258.92156377672,
        ["g"] = 23,
        ["sublevel"] = 1,
        ["infested"] = {
          [3] = true,
        },
      },
      [2] = {
        ["x"] = 458.88216893754,
        ["y"] = -341.18087391862,
        ["g"] = 34,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 432.90654005456,
        ["y"] = -419.76937675037,
        ["g"] = 41,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 512.58587693016,
        ["y"] = -309.83593075367,
        ["g"] = 33,
        ["sublevel"] = 1,
        ["teeming"] = true,
      },
    },
  },
  [19] = {
    ["name"] = "Kul Tiran Footman",
    ["id"] = 141565,
    ["count"] = 1,
    ["health"] = 58864,
    ["scale"] = 0.5,
    ["displayId"] = 86025,
    ["creatureType"] = "Humanoid",
    ["level"] = 120,
    ["reaping"] = 148716,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Silence"] = true,
      ["Root"] = true,
      ["Fear"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
    },
    ["spells"] = {
      [209859] = {
      },
      [273930] = {
      },
      [277564] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 529.5126770395,
        ["y"] = -250.43142788804,
        ["g"] = 25,
        ["sublevel"] = 1,
        ["faction"] = 1,
      },
      [2] = {
        ["x"] = 540.52533800336,
        ["y"] = -247.39345151313,
        ["g"] = 25,
        ["sublevel"] = 1,
        ["faction"] = 1,
      },
      [3] = {
        ["x"] = 546.72788555121,
        ["y"] = -253.59597733169,
        ["g"] = 25,
        ["sublevel"] = 1,
        ["faction"] = 1,
      },
      [4] = {
        ["x"] = 541.91775040591,
        ["y"] = -259.41876221475,
        ["g"] = 25,
        ["sublevel"] = 1,
        ["faction"] = 1,
      },
      [5] = {
        ["x"] = 532.03960504283,
        ["y"] = -262.3175236157,
        ["g"] = 25,
        ["sublevel"] = 1,
        ["faction"] = 1,
      },
      [6] = {
        ["x"] = 532.33370139834,
        ["y"] = -254.67045037523,
        ["g"] = 25,
        ["sublevel"] = 1,
        ["faction"] = 1,
      },
      [7] = {
        ["x"] = 538.37345459444,
        ["y"] = -253.72255583275,
        ["g"] = 25,
        ["sublevel"] = 1,
        ["faction"] = 1,
      },
      [8] = {
        ["x"] = 514.64882686269,
        ["y"] = -279.45366833983,
        ["g"] = 26,
        ["sublevel"] = 1,
        ["faction"] = 1,
      },
      [9] = {
        ["x"] = 520.19610143157,
        ["y"] = -287.10623356988,
        ["g"] = 27,
        ["sublevel"] = 1,
        ["faction"] = 1,
      },
      [10] = {
        ["x"] = 555.72299209389,
        ["y"] = -292.19452906667,
        ["g"] = 28,
        ["sublevel"] = 1,
        ["faction"] = 1,
      },
      [11] = {
        ["x"] = 546.10276526187,
        ["y"] = -300.295797589,
        ["g"] = 29,
        ["sublevel"] = 1,
        ["faction"] = 1,
      },
      [12] = {
        ["x"] = 536.34527281636,
        ["y"] = -304.20748815733,
        ["g"] = 30,
        ["sublevel"] = 1,
        ["faction"] = 1,
      },
      [13] = {
        ["x"] = 527.67608951888,
        ["y"] = -303.16501314177,
        ["g"] = 31,
        ["sublevel"] = 1,
        ["faction"] = 1,
      },
      [14] = {
        ["x"] = 531.79896548866,
        ["y"] = -312.70085465845,
        ["g"] = 31,
        ["sublevel"] = 1,
        ["faction"] = 1,
      },
      [15] = {
        ["x"] = 520.58250449269,
        ["y"] = -304.72909004106,
        ["g"] = 32,
        ["sublevel"] = 1,
        ["faction"] = 1,
      },
    },
  },
  [20] = {
    ["name"] = "Ashvane Deckhand",
    ["id"] = 138464,
    ["count"] = 4,
    ["health"] = 768495,
    ["scale"] = 0.7,
    ["displayId"] = 84385,
    ["creatureType"] = "Humanoid",
    ["level"] = 120,
    ["reaping"] = 148716,
    ["characteristics"] = {
      ["Root"] = true,
      ["Fear"] = true,
      ["Disorient"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
    },
    ["spells"] = {
      [209859] = {
      },
      [268230] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 466.44485478095,
        ["y"] = -333.95126137018,
        ["g"] = 34,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 462.67524850882,
        ["y"] = -330.49121809787,
        ["g"] = 34,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 463.19588800752,
        ["y"] = -345.51457872792,
        ["g"] = 34,
        ["sublevel"] = 1,
      },
    },
  },
  [21] = {
    ["name"] = "Ashvane Cannoneer",
    ["id"] = 138465,
    ["count"] = 4,
    ["health"] = 768495,
    ["scale"] = 0.7,
    ["displayId"] = 88542,
    ["creatureType"] = "Humanoid",
    ["level"] = 120,
    ["reaping"] = 148894,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [209859] = {
      },
      [268260] = {
      },
      [281388] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 458.88216893754,
        ["y"] = -336.35329052182,
        ["g"] = 34,
        ["sublevel"] = 1,
        ["infested"] = {
          [3] = true,
        },
      },
    },
  },
  [22] = {
    ["name"] = "Dread Captain Lockwood",
    ["id"] = 129208,
    ["count"] = 0,
    ["health"] = 3765626,
    ["scale"] = 0.8,
    ["displayId"] = 88579,
    ["creatureType"] = "Humanoid",
    ["level"] = 122,
    ["isBoss"] = true,
    ["encounterID"] = 2173,
    ["instanceID"] = 1023,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Root"] = true,
      ["Slow"] = true,
    },
    ["spells"] = {
      [269029] = {
      },
      [272471] = {
      },
      [273470] = {
      },
      [280389] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 445.55283973782,
        ["y"] = -332.71826679518,
        ["sublevel"] = 1,
      },
    },
  },
  [23] = {
    ["name"] = "Bilge Rat Buccaneer",
    ["id"] = 129366,
    ["count"] = 4,
    ["health"] = 768495,
    ["scale"] = 0.7,
    ["displayId"] = 81424,
    ["creatureType"] = "Humanoid",
    ["level"] = 120,
    ["reaping"] = 148716,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Incapacitate"] = true,
      ["Silence"] = true,
      ["Polymorph"] = true,
      ["Root"] = true,
      ["Fear"] = true,
      ["Disorient"] = true,
      ["Imprison"] = true,
      ["Sap"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
    },
    ["spells"] = {
      [209859] = {
      },
      [272546] = {
      },
      [274941] = {
      },
      [277242] = {
      },
      [277564] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 449.06690463034,
        ["y"] = -401.83147783664,
        ["g"] = 35,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 455.50646053809,
        ["y"] = -392.01832356905,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 462.76218444173,
        ["y"] = -380.26335949081,
        ["g"] = 36,
        ["sublevel"] = 1,
        ["infested"] = {
          [1] = true,
        },
      },
      [4] = {
        ["x"] = 453.56775616675,
        ["y"] = -375.35498047478,
        ["g"] = 36,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 472.76441569494,
        ["y"] = -389.28108795245,
        ["g"] = 37,
        ["sublevel"] = 1,
      },
      [6] = {
        ["x"] = 470.47036121718,
        ["y"] = -382.68471887618,
        ["g"] = 37,
        ["sublevel"] = 1,
      },
      [7] = {
        ["x"] = 486.81382693685,
        ["y"] = -365.97079258537,
        ["g"] = 45,
        ["sublevel"] = 1,
        ["infested"] = {
        },
      },
      [8] = {
        ["x"] = 485.68495957621,
        ["y"] = -387.07342135317,
        ["sublevel"] = 1,
        ["infested"] = {
          [1] = true,
        },
      },
      [9] = {
        ["x"] = 492.55064458462,
        ["y"] = -388.56596547125,
        ["sublevel"] = 1,
      },
      [10] = {
        ["x"] = 489.29848245284,
        ["y"] = -394.55660128523,
        ["g"] = 38,
        ["sublevel"] = 1,
      },
      [11] = {
        ["x"] = 476.854409421,
        ["y"] = -402.07594876398,
        ["sublevel"] = 1,
        ["infested"] = {
          [2] = true,
        },
      },
      [12] = {
        ["x"] = 457.74586747296,
        ["y"] = -425.89415861255,
        ["g"] = 39,
        ["sublevel"] = 1,
      },
      [13] = {
        ["x"] = 452.93573232766,
        ["y"] = -426.27390498037,
        ["g"] = 39,
        ["sublevel"] = 1,
        ["infested"] = {
          [1] = true,
        },
      },
      [14] = {
        ["x"] = 461.40441545586,
        ["y"] = -402.4909626023,
        ["g"] = 40,
        ["sublevel"] = 1,
        ["infested"] = {
        },
      },
      [15] = {
        ["x"] = 464.00056711768,
        ["y"] = -405.54915579598,
        ["g"] = 40,
        ["sublevel"] = 1,
      },
      [16] = {
        ["x"] = 468.47871255406,
        ["y"] = -441.99181043209,
        ["g"] = 77,
        ["sublevel"] = 1,
      },
      [17] = {
        ["x"] = 461.95484919145,
        ["y"] = -441.86387356664,
        ["g"] = 77,
        ["sublevel"] = 1,
      },
    },
  },
  [24] = {
    ["name"] = "Bilge Rat Demolisher",
    ["id"] = 135245,
    ["count"] = 8,
    ["health"] = 1536990,
    ["scale"] = 1,
    ["displayId"] = 68059,
    ["creatureType"] = "Humanoid",
    ["level"] = 121,
    ["reaping"] = 148894,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [209859] = {
      },
      [257169] = {
      },
      [272713] = {
      },
      [277564] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 449.64388276478,
        ["y"] = -390.21910525687,
        ["sublevel"] = 1,
        ["patrol"] = {
          [1] = {
            ["x"] = 450.55299996036,
            ["y"] = -389.12817242508,
          },
          [2] = {
            ["x"] = 444.97924039355,
            ["y"] = -393.88227015803,
          },
          [3] = {
            ["x"] = 437.76610087659,
            ["y"] = -392.5707985603,
          },
          [4] = {
            ["x"] = 444.97924039355,
            ["y"] = -393.88227015803,
          },
          [5] = {
            ["x"] = 450.55299996036,
            ["y"] = -389.12817242508,
          },
          [6] = {
            ["x"] = 455.96283700982,
            ["y"] = -383.88226492827,
          },
        },
        ["infested"] = {
          [3] = true,
        },
      },
      [2] = {
        ["x"] = 464.90977790599,
        ["y"] = -365.76373721469,
        ["sublevel"] = 1,
        ["patrol"] = {
          [1] = {
            ["x"] = 464.90977790599,
            ["y"] = -365.76373721469,
          },
          [2] = {
            ["x"] = 459.90977914465,
            ["y"] = -376.70124037245,
          },
          [3] = {
            ["x"] = 477.25351604706,
            ["y"] = -386.07622296254,
          },
          [4] = {
            ["x"] = 481.78474522705,
            ["y"] = -373.8887234672,
          },
        },
        ["infested"] = {
          [3] = true,
        },
      },
      [3] = {
        ["x"] = 471.8639059062,
        ["y"] = -403.99158371047,
        ["sublevel"] = 1,
        ["patrol"] = {
          [1] = {
            ["x"] = 470.43535125076,
            ["y"] = -407.28829763634,
          },
          [2] = {
            ["x"] = 474.4286536529,
            ["y"] = -402.07699177342,
          },
          [3] = {
            ["x"] = 477.90690497361,
            ["y"] = -392.29438311184,
          },
          [4] = {
            ["x"] = 474.4286536529,
            ["y"] = -402.07699177342,
          },
          [5] = {
            ["x"] = 470.43535125076,
            ["y"] = -407.28829763634,
          },
          [6] = {
            ["x"] = 460.92992483847,
            ["y"] = -412.60799802554,
          },
          [7] = {
            ["x"] = 457.70648170604,
            ["y"] = -416.61778152477,
          },
          [8] = {
            ["x"] = 460.92992483847,
            ["y"] = -412.60799802554,
          },
        },
      },
    },
  },
  [25] = {
    ["name"] = "Bilge Rat Pillager",
    ["id"] = 135241,
    ["count"] = 4,
    ["health"] = 768495,
    ["scale"] = 0.7,
    ["displayId"] = 52277,
    ["creatureType"] = "Humanoid",
    ["level"] = 120,
    ["reaping"] = 148716,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Incapacitate"] = true,
      ["Mind Control"] = true,
      ["Polymorph"] = true,
      ["Root"] = true,
      ["Fear"] = true,
      ["Disorient"] = true,
      ["Imprison"] = true,
      ["Sap"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
    },
    ["spells"] = {
      [209859] = {
      },
      [272827] = {
      },
      [272834] = {
      },
      [277242] = {
      },
      [277564] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 444.14381531771,
        ["y"] = -400.01828896058,
        ["g"] = 35,
        ["sublevel"] = 1,
        ["infested"] = {
          [2] = true,
        },
      },
      [2] = {
        ["x"] = 476.60607351867,
        ["y"] = -384.17725658898,
        ["g"] = 37,
        ["sublevel"] = 1,
        ["infested"] = {
          [2] = true,
        },
      },
      [3] = {
        ["x"] = 484.99568346729,
        ["y"] = -369.78897033877,
        ["g"] = 45,
        ["sublevel"] = 1,
        ["infested"] = {
          [1] = true,
          [2] = true,
          [3] = true,
        },
      },
      [4] = {
        ["x"] = 456.37530835401,
        ["y"] = -421.65313166251,
        ["g"] = 39,
        ["sublevel"] = 1,
        ["infested"] = {
          [2] = true,
        },
      },
      [5] = {
        ["x"] = 465.15282616421,
        ["y"] = -436.87504947154,
        ["g"] = 77,
        ["sublevel"] = 1,
      },
    },
  },
  [26] = {
    ["name"] = "Bilge Rat Tempest",
    ["id"] = 129367,
    ["count"] = 4,
    ["health"] = 614795,
    ["scale"] = 0.7,
    ["displayId"] = 80475,
    ["creatureType"] = "Humanoid",
    ["level"] = 120,
    ["reaping"] = 148893,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Incapacitate"] = true,
      ["Silence"] = true,
      ["Root"] = true,
      ["Fear"] = true,
      ["Disorient"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
    },
    ["spells"] = {
      [209859] = {
      },
      [272571] = {
      },
      [272581] = {
      },
      [274569] = {
      },
      [277242] = {
      },
      [277564] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 460.09402520125,
        ["y"] = -374.60051258322,
        ["g"] = 36,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 487.90605918564,
        ["y"] = -397.34140436105,
        ["g"] = 38,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 456.72700463708,
        ["y"] = -404.26515494169,
        ["g"] = 40,
        ["sublevel"] = 1,
      },
    },
  },
  [27] = {
    ["name"] = "Bilge Rat Cutthroat",
    ["id"] = 137511,
    ["count"] = 4,
    ["health"] = 614796,
    ["scale"] = 0.7,
    ["displayId"] = 80319,
    ["creatureType"] = "Humanoid",
    ["level"] = 120,
    ["reaping"] = 148716,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Incapacitate"] = true,
      ["Silence"] = true,
      ["Polymorph"] = true,
      ["Root"] = true,
      ["Fear"] = true,
      ["Disorient"] = true,
      ["Sap"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
    },
    ["spells"] = {
      [209859] = {
      },
      [272588] = {
      },
      [277242] = {
      },
      [277564] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 466.48506423415,
        ["y"] = -399.18450962432,
        ["g"] = 40,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 460.11408997895,
        ["y"] = -408.78128372814,
        ["g"] = 40,
        ["sublevel"] = 1,
        ["infested"] = {
          [1] = true,
        },
      },
    },
  },
  [28] = {
    ["name"] = "Ashvane Sniper",
    ["id"] = 128967,
    ["count"] = 4,
    ["health"] = 768495,
    ["scale"] = 0.7,
    ["displayId"] = 82843,
    ["creatureType"] = "Humanoid",
    ["level"] = 120,
    ["reaping"] = 148716,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Incapacitate"] = true,
      ["Silence"] = true,
      ["Polymorph"] = true,
      ["Root"] = true,
      ["Fear"] = true,
      ["Disorient"] = true,
      ["Sap"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
    },
    ["spells"] = {
      [209859] = {
      },
      [272528] = {
      },
      [272542] = {
      },
      [277242] = {
      },
      [277564] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 432.44783423805,
        ["y"] = -413.16388070323,
        ["g"] = 41,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 437.76893352561,
        ["y"] = -416.4666287268,
        ["g"] = 41,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 437.86066996429,
        ["y"] = -421.78772407717,
        ["g"] = 41,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 433.27352518113,
        ["y"] = -425.27396466403,
        ["g"] = 41,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 376.52361492942,
        ["y"] = -440.74941557682,
        ["g"] = 42,
        ["sublevel"] = 1,
        ["infested"] = {
          [1] = true,
        },
      },
      [6] = {
        ["x"] = 378.76849021377,
        ["y"] = -444.21880571055,
        ["g"] = 42,
        ["sublevel"] = 1,
      },
      [7] = {
        ["x"] = 422.88587760339,
        ["y"] = -436.83537207088,
        ["g"] = 44,
        ["sublevel"] = 1,
      },
    },
  },
  [29] = {
    ["name"] = "Ashvane Invader",
    ["id"] = 137516,
    ["count"] = 4,
    ["health"] = 768495,
    ["scale"] = 0.7,
    ["displayId"] = 79889,
    ["creatureType"] = "Humanoid",
    ["level"] = 120,
    ["reaping"] = 148716,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Incapacitate"] = true,
      ["Silence"] = true,
      ["Root"] = true,
      ["Fear"] = true,
      ["Disorient"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
    },
    ["spells"] = {
      [209859] = {
      },
      [275835] = {
      },
      [275836] = {
      },
      [277564] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 380.80929866607,
        ["y"] = -438.70859836629,
        ["g"] = 42,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 398.22865812385,
        ["y"] = -422.40827992271,
        ["g"] = 43,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 393.22867672236,
        ["y"] = -425.408255889,
        ["g"] = 43,
        ["sublevel"] = 1,
        ["infested"] = {
          [3] = true,
        },
      },
      [4] = {
        ["x"] = 428.97285939704,
        ["y"] = -438.13970931908,
        ["g"] = 44,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 426.58154178903,
        ["y"] = -443.79188404172,
        ["g"] = 44,
        ["sublevel"] = 1,
      },
    },
  },
  [30] = {
    ["name"] = "Ashvane Destroyer",
    ["id"] = 137517,
    ["count"] = 4,
    ["health"] = 768495,
    ["scale"] = 0.7,
    ["displayId"] = 82852,
    ["creatureType"] = "Humanoid",
    ["level"] = 120,
    ["reaping"] = 148716,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Incapacitate"] = true,
      ["Silence"] = true,
      ["Polymorph"] = true,
      ["Root"] = true,
      ["Fear"] = true,
      ["Disorient"] = true,
      ["Sap"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
    },
    ["spells"] = {
      [209859] = {
      },
      [272888] = {
      },
      [277242] = {
      },
      [277564] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 396.97868423115,
        ["y"] = -426.15826597382,
        ["g"] = 43,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 417.45111574567,
        ["y"] = -437.27014182419,
        ["g"] = 44,
        ["sublevel"] = 1,
        ["infested"] = {
          [2] = true,
        },
      },
    },
  },
  [31] = {
    ["name"] = "Hadal Darkfathom",
    ["id"] = 128651,
    ["count"] = 0,
    ["health"] = 5379465,
    ["scale"] = 1,
    ["displayId"] = 67541,
    ["creatureType"] = "Giant",
    ["level"] = 122,
    ["isBoss"] = true,
    ["encounterID"] = 2134,
    ["instanceID"] = 1023,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [257882] = {
      },
      [257883] = {
      },
      [261565] = {
      },
      [276068] = {
      },
      [277564] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 394.14927643255,
        ["y"] = -451.73365719748,
        ["sublevel"] = 1,
        ["patrol"] = {
          [1] = {
            ["x"] = 394.14927643255,
            ["y"] = -451.73365719748,
          },
          [2] = {
            ["x"] = 384.31621286457,
            ["y"] = -431.90056670682,
          },
          [3] = {
            ["x"] = 409.31622716037,
            ["y"] = -419.90056628214,
          },
          [4] = {
            ["x"] = 420.06622150584,
            ["y"] = -440.15053816504,
          },
        },
      },
    },
  },
  [32] = {
    ["name"] = "Viq'Goth",
    ["id"] = 128652,
    ["count"] = 0,
    ["health"] = 19212375,
    ["scale"] = 1,
    ["displayId"] = 87990,
    ["creatureType"] = "Aberration",
    ["level"] = 122,
    ["isBoss"] = true,
    ["encounterID"] = 2140,
    ["instanceID"] = 1023,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [269456] = {
      },
      [269484] = {
      },
      [270185] = {
      },
      [270187] = {
      },
      [270484] = {
      },
      [274991] = {
      },
      [275014] = {
      },
      [277535] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 433.79490519834,
        ["y"] = -522.25717126126,
        ["g"] = 78,
        ["sublevel"] = 1,
      },
    },
  },
  [33] = {
    ["name"] = "Kul Tiran Vanguard",
    ["id"] = 138019,
    ["count"] = 4,
    ["health"] = 768495,
    ["scale"] = 0.7,
    ["displayId"] = 84074,
    ["creatureType"] = "Humanoid",
    ["level"] = 121,
    ["reaping"] = 148894,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Incapacitate"] = true,
      ["Polymorph"] = true,
      ["Root"] = true,
      ["Fear"] = true,
      ["Sap"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
    },
    ["spells"] = {
      [209859] = {
      },
      [257292] = {
      },
      [277242] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 489.87954568438,
        ["y"] = -134.28998585695,
        ["g"] = 13,
        ["sublevel"] = 1,
        ["faction"] = 1,
        ["infested"] = {
          [2] = true,
        },
      },
    },
  },
  [34] = {
    ["name"] = "Kul Tiran Footman",
    ["id"] = 141282,
    ["count"] = 1,
    ["health"] = 153699,
    ["scale"] = 0.5,
    ["displayId"] = 86025,
    ["creatureType"] = "Humanoid",
    ["level"] = 120,
    ["reaping"] = 148716,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Incapacitate"] = true,
      ["Silence"] = true,
      ["Root"] = true,
      ["Fear"] = true,
      ["Imprison"] = true,
      ["Sap"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
    },
    ["spells"] = {
      [209859] = {
      },
      [273930] = {
      },
      [277242] = {
      },
      [277564] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 558.38864977509,
        ["y"] = -95.768201384782,
        ["g"] = 3,
        ["sublevel"] = 1,
        ["faction"] = 1,
      },
      [2] = {
        ["x"] = 559.17813379257,
        ["y"] = -90.505042362655,
        ["g"] = 3,
        ["sublevel"] = 1,
        ["faction"] = 1,
      },
      [3] = {
        ["x"] = 514.66541432983,
        ["y"] = -121.54310148864,
        ["g"] = 10,
        ["sublevel"] = 1,
        ["faction"] = 1,
      },
      [4] = {
        ["x"] = 497.27189948463,
        ["y"] = -141.07537171561,
        ["g"] = 13,
        ["sublevel"] = 1,
        ["faction"] = 1,
      },
      [5] = {
        ["x"] = 492.45176731099,
        ["y"] = -140.28399456647,
        ["g"] = 13,
        ["sublevel"] = 1,
        ["faction"] = 1,
      },
      [6] = {
        ["x"] = 488.42298758703,
        ["y"] = -139.20486860802,
        ["g"] = 13,
        ["sublevel"] = 1,
        ["faction"] = 1,
      },
      [7] = {
        ["x"] = 484.53809461745,
        ["y"] = -136.11134043785,
        ["g"] = 13,
        ["sublevel"] = 1,
        ["faction"] = 1,
      },
      [8] = {
        ["x"] = 504.72957459924,
        ["y"] = -158.8062774609,
        ["g"] = 14,
        ["sublevel"] = 1,
        ["faction"] = 1,
      },
      [9] = {
        ["x"] = 499.7295694751,
        ["y"] = -156.0062838611,
        ["g"] = 14,
        ["sublevel"] = 1,
        ["faction"] = 1,
        ["infested"] = {
          [1] = true,
        },
      },
      [10] = {
        ["x"] = 500.82957523727,
        ["y"] = -149.20628530368,
        ["g"] = 14,
        ["sublevel"] = 1,
        ["faction"] = 1,
      },
      [11] = {
        ["x"] = 508.32957863194,
        ["y"] = -151.00629161156,
        ["g"] = 14,
        ["sublevel"] = 1,
        ["faction"] = 1,
      },
    },
  },
  [35] = {
    ["name"] = "Kul Tiran Footman",
    ["id"] = 141565,
    ["count"] = 1,
    ["health"] = 153699,
    ["scale"] = 0.5,
    ["displayId"] = 86025,
    ["creatureType"] = "Humanoid",
    ["level"] = 120,
    ["reaping"] = 148716,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Silence"] = true,
      ["Root"] = true,
      ["Fear"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
    },
    ["spells"] = {
      [209859] = {
      },
      [273930] = {
      },
      [277564] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 541.54654993909,
        ["y"] = -91.426095756203,
        ["g"] = 4,
        ["sublevel"] = 1,
        ["faction"] = 1,
      },
      [2] = {
        ["x"] = 544.33859362617,
        ["y"] = -100.90035371484,
        ["g"] = 5,
        ["sublevel"] = 1,
        ["faction"] = 1,
      },
      [3] = {
        ["x"] = 539.22227842112,
        ["y"] = -113.03611956006,
        ["g"] = 6,
        ["sublevel"] = 1,
        ["faction"] = 1,
      },
      [4] = {
        ["x"] = 536.73825337468,
        ["y"] = -107.25287819831,
        ["g"] = 6,
        ["sublevel"] = 1,
        ["faction"] = 1,
      },
      [5] = {
        ["x"] = 520.36252691696,
        ["y"] = -100.10166381043,
        ["g"] = 7,
        ["sublevel"] = 1,
        ["faction"] = 1,
      },
      [6] = {
        ["x"] = 516.73635955827,
        ["y"] = -112.73097762966,
        ["g"] = 8,
        ["sublevel"] = 1,
        ["faction"] = 1,
      },
      [7] = {
        ["x"] = 523.46034058597,
        ["y"] = -130.56921656564,
        ["g"] = 9,
        ["sublevel"] = 1,
        ["faction"] = 1,
      },
      [8] = {
        ["x"] = 531.15331851052,
        ["y"] = -124.44357248319,
        ["g"] = 9,
        ["sublevel"] = 1,
        ["faction"] = 1,
      },
      [9] = {
        ["x"] = 499.66295946276,
        ["y"] = -129.45167733706,
        ["g"] = 11,
        ["sublevel"] = 1,
        ["faction"] = 1,
      },
      [10] = {
        ["x"] = 490.16460146767,
        ["y"] = -127.74441934984,
        ["g"] = 12,
        ["sublevel"] = 1,
        ["faction"] = 1,
      },
    },
  },
  [36] = {
    ["name"] = "Irontide Marauder",
    ["id"] = 138247,
    ["count"] = 1,
    ["health"] = 153699,
    ["scale"] = 0.5,
    ["displayId"] = 79068,
    ["creatureType"] = "Humanoid",
    ["level"] = 120,
    ["reaping"] = 148716,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Silence"] = true,
      ["Root"] = true,
      ["Fear"] = true,
      ["Disorient"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
    },
    ["spells"] = {
      [209859] = {
      },
      [257168] = {
      },
      [277564] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 487.3258969407,
        ["y"] = -226.03723578157,
        ["g"] = 21,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 481.80956651225,
        ["y"] = -227.17150342228,
        ["g"] = 21,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 478.48013735893,
        ["y"] = -222.50958185537,
        ["g"] = 21,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 466.27899063328,
        ["y"] = -327.40210468126,
        ["sublevel"] = 1,
      },
      [5] = {
        ["x"] = 469.16361155582,
        ["y"] = -321.05594030226,
        ["sublevel"] = 1,
      },
      [6] = {
        ["x"] = 461.85593713013,
        ["y"] = -319.32516444756,
        ["sublevel"] = 1,
      },
      [7] = {
        ["x"] = 463.77899023532,
        ["y"] = -351.24823883418,
        ["sublevel"] = 1,
      },
      [8] = {
        ["x"] = 469.93285260498,
        ["y"] = -354.51747202835,
        ["sublevel"] = 1,
      },
    },
  },
  [37] = {
    ["name"] = "Irontide Powdershot",
    ["id"] = 138254,
    ["count"] = 1,
    ["health"] = 153699,
    ["scale"] = 0.7,
    ["displayId"] = 85144,
    ["creatureType"] = "Humanoid",
    ["level"] = 120,
    ["reaping"] = 148716,
    ["characteristics"] = {
      ["Disorient"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
    },
    ["spells"] = {
      [209859] = {
      },
      [257641] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 492.46073769056,
        ["y"] = -253.9640479065,
        ["g"] = 23,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 487.56622380814,
        ["y"] = -256.98790082987,
        ["g"] = 23,
        ["sublevel"] = 1,
      },
      [3] = {
        ["x"] = 497.22566225869,
        ["y"] = -251.55176166535,
        ["g"] = 23,
        ["sublevel"] = 1,
      },
      [4] = {
        ["x"] = 501.83181533151,
        ["y"] = -250.60294103648,
        ["g"] = 23,
        ["sublevel"] = 1,
      },
    },
  },
  [38] = {
    ["name"] = "Irontide Waveshaper",
    ["id"] = 144071,
    ["count"] = 4,
    ["health"] = 614795,
    ["scale"] = 0.7,
    ["displayId"] = 79077,
    ["creatureType"] = "Humanoid",
    ["level"] = 120,
    ["reaping"] = 148893,
    ["characteristics"] = {
      ["Taunt"] = true,
      ["Incapacitate"] = true,
      ["Silence"] = true,
      ["Root"] = true,
      ["Fear"] = true,
      ["Sap"] = true,
      ["Stun"] = true,
      ["Slow"] = true,
    },
    ["spells"] = {
      [209859] = {
      },
      [256957] = {
      },
      [257063] = {
      },
      [257069] = {
      },
      [277564] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 479.33270274982,
        ["y"] = -217.97632278322,
        ["g"] = 21,
        ["sublevel"] = 1,
      },
      [2] = {
        ["x"] = 582.83184305457,
        ["y"] = -88.264351294156,
        ["g"] = 50,
        ["sublevel"] = 2,
        ["faction"] = 2,
      },
      [3] = {
        ["x"] = 545.56199350463,
        ["y"] = -118.77616417887,
        ["g"] = 52,
        ["sublevel"] = 1,
        ["faction"] = 2,
      },
    },
  },
  [39] = {
    ["name"] = "Scrimshaw Gutter",
    ["id"] = 138002,
    ["count"] = 1,
    ["health"] = 100714,
    ["scale"] = 0.5,
    ["displayId"] = 83892,
    ["creatureType"] = "Humanoid",
    ["level"] = 120,
    ["reaping"] = 148716,
    ["clones"] = {
      [1] = {
        ["x"] = 624.14510461474,
        ["y"] = -114.74007442758,
        ["sublevel"] = 2,
        ["faction"] = 2,
      },
      [2] = {
        ["x"] = 633.10342590036,
        ["y"] = -112.0502018098,
        ["sublevel"] = 2,
        ["faction"] = 2,
      },
      [3] = {
        ["x"] = 635.8684261482,
        ["y"] = -104.6270537696,
        ["sublevel"] = 2,
        ["faction"] = 2,
      },
      [4] = {
        ["x"] = 643.91349274231,
        ["y"] = -108.18081779719,
        ["sublevel"] = 2,
        ["faction"] = 2,
      },
      [5] = {
        ["x"] = 500.85843247669,
        ["y"] = -119.88155209792,
        ["sublevel"] = 1,
        ["faction"] = 2,
      },
      [6] = {
        ["x"] = 492.19683975771,
        ["y"] = -122.90677710877,
        ["sublevel"] = 1,
        ["faction"] = 2,
      },
      [7] = {
        ["x"] = 588.38221337161,
        ["y"] = -103.04576615629,
        ["sublevel"] = 2,
        ["faction"] = 2,
      },
      [8] = {
        ["x"] = 590.9242170708,
        ["y"] = -108.25354459495,
        ["sublevel"] = 2,
        ["faction"] = 2,
      },
    },
  },
  [40] = {
    ["name"] = "Scrimshaw Gutter",
    ["id"] = 133990,
    ["count"] = 1,
    ["health"] = 100714,
    ["scale"] = 0.5,
    ["displayId"] = 83892,
    ["creatureType"] = "Humanoid",
    ["level"] = 120,
    ["reaping"] = 148716,
    ["clones"] = {
      [1] = {
        ["x"] = 629.52555847793,
        ["y"] = -85.663335851963,
        ["g"] = 47,
        ["sublevel"] = 2,
        ["faction"] = 2,
      },
      [2] = {
        ["x"] = 625.42493453893,
        ["y"] = -81.779556146624,
        ["g"] = 47,
        ["sublevel"] = 2,
        ["faction"] = 2,
        ["infested"] = {
          [2] = true,
        },
      },
      [3] = {
        ["x"] = 615.12758440249,
        ["y"] = -72.572034403379,
        ["g"] = 48,
        ["sublevel"] = 2,
        ["faction"] = 2,
      },
      [4] = {
        ["x"] = 581.02611535183,
        ["y"] = -96.247365730931,
        ["g"] = 50,
        ["sublevel"] = 2,
        ["faction"] = 2,
      },
      [5] = {
        ["x"] = 587.86302689718,
        ["y"] = -88.068913172767,
        ["g"] = 50,
        ["sublevel"] = 2,
        ["faction"] = 2,
      },
      [6] = {
        ["x"] = 590.76348531235,
        ["y"] = -90.924130579403,
        ["g"] = 50,
        ["sublevel"] = 2,
        ["faction"] = 2,
      },
      [7] = {
        ["x"] = 590.55293510429,
        ["y"] = -97.69760669614,
        ["g"] = 50,
        ["sublevel"] = 2,
        ["faction"] = 2,
      },
      [8] = {
        ["x"] = 550.71901535146,
        ["y"] = -108.37487597956,
        ["g"] = 51,
        ["sublevel"] = 1,
        ["faction"] = 2,
      },
      [9] = {
        ["x"] = 556.03570467322,
        ["y"] = -116.06204085406,
        ["g"] = 51,
        ["sublevel"] = 1,
        ["faction"] = 2,
      },
      [10] = {
        ["x"] = 540.43043741714,
        ["y"] = -124.17089573892,
        ["g"] = 52,
        ["sublevel"] = 1,
        ["faction"] = 2,
      },
      [11] = {
        ["x"] = 543.19358647764,
        ["y"] = -124.17089573892,
        ["g"] = 52,
        ["sublevel"] = 1,
        ["faction"] = 2,
      },
      [12] = {
        ["x"] = 511.8478498386,
        ["y"] = -100.59627511277,
        ["g"] = 53,
        ["sublevel"] = 1,
        ["faction"] = 2,
      },
      [13] = {
        ["x"] = 514.06483232557,
        ["y"] = -102.58903540268,
        ["g"] = 53,
        ["sublevel"] = 1,
        ["faction"] = 2,
      },
      [14] = {
        ["x"] = 487.211754679,
        ["y"] = -139.34256035327,
        ["g"] = 13,
        ["sublevel"] = 1,
        ["faction"] = 2,
      },
      [15] = {
        ["x"] = 491.39358177612,
        ["y"] = -140.61528117955,
        ["g"] = 13,
        ["sublevel"] = 1,
        ["faction"] = 2,
      },
      [16] = {
        ["x"] = 485.57538484003,
        ["y"] = -134.97894386236,
        ["g"] = 13,
        ["sublevel"] = 1,
        ["faction"] = 2,
      },
      [17] = {
        ["x"] = 496.84812189673,
        ["y"] = -141.52436079593,
        ["g"] = 13,
        ["sublevel"] = 1,
        ["faction"] = 2,
      },
      [18] = {
        ["x"] = 508.37310465286,
        ["y"] = -145.24326500783,
        ["g"] = 14,
        ["sublevel"] = 1,
        ["faction"] = 2,
      },
      [19] = {
        ["x"] = 502.30754891864,
        ["y"] = -146.22685647123,
        ["g"] = 14,
        ["sublevel"] = 1,
        ["faction"] = 2,
      },
      [20] = {
        ["x"] = 502.96326718051,
        ["y"] = -154.58752461621,
        ["g"] = 14,
        ["sublevel"] = 1,
        ["faction"] = 2,
      },
      [21] = {
        ["x"] = 509.19282986851,
        ["y"] = -157.86620034917,
        ["g"] = 14,
        ["sublevel"] = 1,
        ["faction"] = 2,
      },
      [22] = {
        ["x"] = 558.56117302015,
        ["y"] = -89.738232694182,
        ["g"] = 3,
        ["sublevel"] = 1,
        ["faction"] = 2,
      },
      [23] = {
        ["x"] = 558.5494143663,
        ["y"] = -94.508809611529,
        ["g"] = 3,
        ["sublevel"] = 1,
        ["faction"] = 2,
      },
      [24] = {
        ["x"] = 580.88168804981,
        ["y"] = -101.22626502398,
        ["g"] = 2,
        ["sublevel"] = 1,
        ["faction"] = 2,
      },
      [25] = {
        ["x"] = 581.21135325821,
        ["y"] = -104.96252573884,
        ["g"] = 2,
        ["sublevel"] = 1,
        ["faction"] = 2,
      },
      [26] = {
        ["x"] = 578.46413061228,
        ["y"] = -108.69879588565,
        ["g"] = 2,
        ["sublevel"] = 1,
        ["faction"] = 2,
      },
      [27] = {
        ["x"] = 616.04788978266,
        ["y"] = -89.217330182773,
        ["g"] = 1,
        ["sublevel"] = 1,
        ["faction"] = 2,
      },
      [28] = {
        ["x"] = 616.89598820285,
        ["y"] = -93.858053345314,
        ["g"] = 1,
        ["sublevel"] = 1,
        ["faction"] = 2,
      },
      [29] = {
        ["x"] = 615.96710806426,
        ["y"] = -98.332530828922,
        ["g"] = 1,
        ["sublevel"] = 1,
        ["faction"] = 2,
      },
      [30] = {
        ["x"] = 614.3855565192,
        ["y"] = -108.03210652236,
        ["g"] = 63,
        ["sublevel"] = 2,
        ["faction"] = 2,
      },
      [31] = {
        ["x"] = 609.38558572733,
        ["y"] = -108.03211510542,
        ["g"] = 63,
        ["sublevel"] = 2,
        ["faction"] = 2,
      },
      [32] = {
        ["x"] = 616.18556282708,
        ["y"] = -104.33210976861,
        ["g"] = 63,
        ["sublevel"] = 2,
        ["faction"] = 2,
      },
      [33] = {
        ["x"] = 614.58555054436,
        ["y"] = -100.83211562309,
        ["g"] = 63,
        ["sublevel"] = 2,
        ["faction"] = 2,
      },
      [34] = {
        ["x"] = 608.48555682419,
        ["y"] = -102.0321141063,
        ["g"] = 63,
        ["sublevel"] = 2,
        ["faction"] = 2,
      },
      [35] = {
        ["x"] = 600.01391255356,
        ["y"] = -100.17678467374,
        ["g"] = 64,
        ["sublevel"] = 2,
        ["faction"] = 2,
      },
      [36] = {
        ["x"] = 603.52167696453,
        ["y"] = -87.597628085377,
        ["g"] = 65,
        ["sublevel"] = 2,
        ["faction"] = 2,
      },
      [37] = {
        ["x"] = 606.41424102749,
        ["y"] = -86.523244614334,
        ["g"] = 65,
        ["sublevel"] = 2,
        ["faction"] = 2,
        ["infested"] = {
          [3] = true,
        },
      },
      [38] = {
        ["x"] = 616.21534781615,
        ["y"] = -87.123302211282,
        ["g"] = 66,
        ["sublevel"] = 2,
        ["faction"] = 2,
      },
      [39] = {
        ["x"] = 618.60970268002,
        ["y"] = -88.954287637858,
        ["g"] = 66,
        ["sublevel"] = 2,
        ["faction"] = 2,
      },
    },
  },
  [41] = {
    ["name"] = "Scrimshaw Enforcer",
    ["id"] = 129374,
    ["count"] = 4,
    ["health"] = 503570,
    ["scale"] = 0.7,
    ["displayId"] = 86006,
    ["creatureType"] = "Humanoid",
    ["level"] = 120,
    ["reaping"] = 148716,
    ["clones"] = {
      [1] = {
        ["x"] = 629.63617920356,
        ["y"] = -80.366791089008,
        ["g"] = 47,
        ["sublevel"] = 2,
        ["faction"] = 2,
      },
      [2] = {
        ["x"] = 612.23283393871,
        ["y"] = -76.892462466845,
        ["g"] = 48,
        ["sublevel"] = 2,
        ["faction"] = 2,
      },
      [3] = {
        ["x"] = 585.70685223225,
        ["y"] = -97.482252471429,
        ["g"] = 50,
        ["sublevel"] = 2,
        ["faction"] = 2,
        ["infested"] = {
          [2] = true,
        },
      },
      [4] = {
        ["x"] = 540.50309457737,
        ["y"] = -119.82196527918,
        ["g"] = 52,
        ["sublevel"] = 1,
        ["faction"] = 2,
      },
      [5] = {
        ["x"] = 517.47542274433,
        ["y"] = -108.73730732369,
        ["sublevel"] = 1,
        ["faction"] = 2,
      },
      [6] = {
        ["x"] = 603.36452143634,
        ["y"] = -110.11910498962,
        ["sublevel"] = 1,
        ["faction"] = 2,
        ["patrol"] = {
          [1] = {
            ["x"] = 603.36452143634,
            ["y"] = -110.11910498962,
          },
          [2] = {
            ["x"] = 605.2216765295,
            ["y"] = -101.54767983709,
          },
          [3] = {
            ["x"] = 602.65023856145,
            ["y"] = -110.54766980994,
          },
          [4] = {
            ["x"] = 594.79309015305,
            ["y"] = -110.11910498962,
          },
          [5] = {
            ["x"] = 583.93596347933,
            ["y"] = -106.26196029906,
          },
          [6] = {
            ["x"] = 594.65025564882,
            ["y"] = -110.11910498962,
          },
        },
        ["infested"] = {
          [3] = true,
        },
      },
      [7] = {
        ["x"] = 611.42916286483,
        ["y"] = -94.354639890186,
        ["g"] = 1,
        ["sublevel"] = 1,
        ["faction"] = 2,
        ["infested"] = {
          [2] = true,
        },
      },
      [8] = {
        ["x"] = 612.11166982222,
        ["y"] = -104.17900417954,
        ["g"] = 63,
        ["sublevel"] = 2,
        ["faction"] = 2,
        ["infested"] = {
        },
      },
      [9] = {
        ["x"] = 595.56948328715,
        ["y"] = -99.287883561659,
        ["g"] = 64,
        ["sublevel"] = 2,
        ["faction"] = 2,
      },
      [10] = {
        ["x"] = 514.30705654956,
        ["y"] = -129.39934559535,
        ["g"] = 55,
        ["sublevel"] = 1,
        ["faction"] = 2,
        ["teeming"] = true,
      },
    },
  },
  [42] = {
    ["name"] = "Chopper Redhook",
    ["id"] = 128650,
    ["count"] = 0,
    ["health"] = 2819992,
    ["scale"] = 0.8,
    ["displayId"] = 84821,
    ["creatureType"] = "Humanoid",
    ["level"] = 122,
    ["isBoss"] = true,
    ["encounterID"] = 2132,
    ["instanceID"] = 1023,
    ["clones"] = {
      [1] = {
        ["x"] = 490.36436521224,
        ["y"] = -158.47729924025,
        ["g"] = 58,
        ["sublevel"] = 1,
        ["faction"] = 2,
      },
    },
  },
  [43] = {
    ["name"] = "Irontide Cleaver",
    ["id"] = 129879,
    ["count"] = 0,
    ["health"] = 503570,
    ["scale"] = 1,
    ["displayId"] = 81286,
    ["creatureType"] = "Humanoid",
    ["level"] = 121,
    ["reaping"] = 148894,
    ["clones"] = {
      [1] = {
        ["x"] = 481.49951633274,
        ["y"] = -154.63552044934,
        ["g"] = 58,
        ["sublevel"] = 1,
        ["faction"] = 2,
      },
    },
  },
  [44] = {
    ["name"] = "Irontide Powdershot",
    ["id"] = 129928,
    ["count"] = 0,
    ["health"] = 100714,
    ["scale"] = 1,
    ["displayId"] = 85144,
    ["creatureType"] = "Humanoid",
    ["level"] = 120,
    ["reaping"] = 148716,
    ["clones"] = {
      [1] = {
        ["x"] = 495.12011392662,
        ["y"] = -168.59803506526,
        ["g"] = 58,
        ["sublevel"] = 1,
        ["faction"] = 2,
      },
    },
  },
  [45] = {
    ["name"] = "Emissary of the Tides",
    ["id"] = 155434,
    ["count"] = 4,
    ["health"] = 402855,
    ["ignoreFortified"] = true,
    ["scale"] = 0.71,
    ["displayId"] = 39391,
    ["iconTexture"] = 132315,
    ["creatureType"] = "Humanoid",
    ["level"] = 120,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [302415] = {
      },
      [302417] = {
      },
      [302418] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 553.28611263016,
        ["y"] = -91.98827358676,
        ["g"] = 3,
        ["sublevel"] = 1,
        ["week"] = {
          [1] = true,
          [4] = true,
          [7] = true,
          [10] = true,
        },
      },
      [2] = {
        ["x"] = 532.97577929837,
        ["y"] = -113.69286683266,
        ["g"] = 6,
        ["sublevel"] = 1,
        ["week"] = {
          [1] = true,
          [4] = true,
          [7] = true,
          [10] = true,
        },
      },
      [3] = {
        ["x"] = 447.98854077863,
        ["y"] = -397.57569813861,
        ["g"] = 35,
        ["sublevel"] = 1,
        ["week"] = {
          [1] = true,
          [4] = true,
          [7] = true,
          [10] = true,
        },
      },
      [4] = {
        ["x"] = 375.10515977556,
        ["y"] = -435.20804587618,
        ["g"] = 42,
        ["sublevel"] = 1,
        ["week"] = {
          [1] = true,
          [4] = true,
          [7] = true,
          [10] = true,
        },
      },
      [5] = {
        ["x"] = 577.94754111969,
        ["y"] = -97.489084425985,
        ["g"] = 2,
        ["sublevel"] = 1,
        ["week"] = {
          [2] = true,
          [5] = true,
          [8] = true,
          [11] = true,
        },
      },
      [6] = {
        ["x"] = 503.85647008963,
        ["y"] = -123.04234997355,
        ["g"] = 10,
        ["sublevel"] = 1,
        ["week"] = {
          [2] = true,
          [5] = true,
          [8] = true,
          [11] = true,
        },
      },
      [7] = {
        ["x"] = 513.3023494833,
        ["y"] = -151.99453722886,
        ["g"] = 14,
        ["sublevel"] = 1,
        ["week"] = {
          [2] = true,
          [5] = true,
          [8] = true,
          [11] = true,
        },
      },
      [8] = {
        ["x"] = 483.1577308154,
        ["y"] = -222.3930490868,
        ["g"] = 21,
        ["sublevel"] = 1,
        ["week"] = {
          [2] = true,
          [5] = true,
          [8] = true,
          [11] = true,
        },
      },
      [9] = {
        ["x"] = 516.98335609567,
        ["y"] = -317.72736086716,
        ["g"] = 33,
        ["sublevel"] = 1,
        ["week"] = {
          [2] = true,
          [5] = true,
          [8] = true,
          [11] = true,
        },
      },
      [10] = {
        ["x"] = 457.0321638318,
        ["y"] = -380.43071445262,
        ["g"] = 36,
        ["sublevel"] = 1,
        ["week"] = {
          [2] = true,
          [5] = true,
          [8] = true,
          [11] = true,
        },
      },
      [11] = {
        ["x"] = 402.1498880472,
        ["y"] = -426.2880319026,
        ["g"] = 43,
        ["sublevel"] = 1,
        ["week"] = {
          [2] = true,
          [5] = true,
          [8] = true,
          [11] = true,
        },
      },
      [12] = {
        ["x"] = 420.41720078873,
        ["y"] = -443.43940473214,
        ["g"] = 44,
        ["sublevel"] = 1,
        ["week"] = {
          [2] = true,
          [3] = true,
          [5] = true,
          [6] = true,
          [8] = true,
          [9] = true,
          [11] = true,
          [12] = true,
        },
      },
      [13] = {
        ["x"] = 494.54839393068,
        ["y"] = -144.19881465998,
        ["g"] = 13,
        ["sublevel"] = 1,
        ["week"] = {
          [3] = true,
          [6] = true,
          [9] = true,
          [12] = true,
        },
      },
      [14] = {
        ["x"] = 586.57229468789,
        ["y"] = -92.958555214125,
        ["g"] = 50,
        ["sublevel"] = 2,
        ["week"] = {
          [2] = true,
          [5] = true,
          [8] = true,
          [11] = true,
        },
      },
      [15] = {
        ["x"] = 632.20577486188,
        ["y"] = -91.814153758152,
        ["g"] = 74,
        ["sublevel"] = 2,
        ["week"] = {
          [3] = true,
          [6] = true,
          [9] = true,
          [12] = true,
        },
      },
      [16] = {
        ["x"] = 517.20600499237,
        ["y"] = -282.44947822112,
        ["g"] = 26,
        ["sublevel"] = 1,
        ["week"] = {
          [3] = true,
          [6] = true,
          [9] = true,
          [12] = true,
        },
      },
      [17] = {
        ["x"] = 454.72082679064,
        ["y"] = -408.15391588801,
        ["g"] = 40,
        ["sublevel"] = 1,
        ["week"] = {
          [3] = true,
          [6] = true,
          [9] = true,
          [12] = true,
        },
      },
    },
  },
  [46] = {
    ["name"] = "Void-Touched Emissary",
    ["id"] = 155433,
    ["count"] = 4,
    ["health"] = 654640,
    ["ignoreFortified"] = true,
    ["scale"] = 0.7,
    ["stealthDetect"] = true,
    ["displayId"] = 39391,
    ["iconTexture"] = 132886,
    ["creatureType"] = "Humanoid",
    ["level"] = 122,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [302415] = {
      },
      [302419] = {
      },
      [302420] = {
      },
      [302421] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 530.05919700602,
        ["y"] = -129.76866766248,
        ["g"] = 9,
        ["sublevel"] = 1,
        ["week"] = {
          [1] = true,
          [4] = true,
          [7] = true,
          [10] = true,
        },
      },
      [2] = {
        ["x"] = 513.05659382822,
        ["y"] = -151.5287610665,
        ["g"] = 14,
        ["sublevel"] = 1,
        ["week"] = {
          [1] = true,
          [4] = true,
          [7] = true,
          [10] = true,
        },
      },
      [3] = {
        ["x"] = 504.59565977095,
        ["y"] = -256.79775519363,
        ["g"] = 23,
        ["sublevel"] = 1,
        ["week"] = {
          [1] = true,
          [4] = true,
          [7] = true,
          [10] = true,
        },
      },
      [4] = {
        ["x"] = 464.81120750834,
        ["y"] = -339.23155291554,
        ["g"] = 34,
        ["sublevel"] = 1,
        ["week"] = {
          [1] = true,
          [4] = true,
          [7] = true,
          [10] = true,
        },
      },
      [5] = {
        ["x"] = 467.21278653316,
        ["y"] = -387.96105970745,
        ["g"] = 37,
        ["sublevel"] = 1,
        ["week"] = {
          [1] = true,
          [4] = true,
          [7] = true,
          [10] = true,
        },
      },
      [6] = {
        ["x"] = 468.30469461163,
        ["y"] = -162.2997205633,
        ["g"] = 17,
        ["sublevel"] = 1,
        ["week"] = {
          [2] = true,
          [5] = true,
          [8] = true,
          [11] = true,
        },
      },
      [7] = {
        ["x"] = 453.60268070019,
        ["y"] = -410.21330029219,
        ["g"] = 40,
        ["sublevel"] = 1,
        ["week"] = {
          [2] = true,
          [5] = true,
          [8] = true,
          [11] = true,
        },
      },
      [8] = {
        ["x"] = 535.51142066538,
        ["y"] = -111.15102341581,
        ["g"] = 6,
        ["sublevel"] = 1,
        ["week"] = {
          [3] = true,
          [6] = true,
          [9] = true,
          [12] = true,
        },
      },
      [9] = {
        ["x"] = 483.45287596095,
        ["y"] = -185.16808696108,
        ["g"] = 20,
        ["sublevel"] = 1,
        ["week"] = {
          [3] = true,
          [6] = true,
          [9] = true,
          [12] = true,
        },
      },
      [10] = {
        ["x"] = 600.13085253536,
        ["y"] = -104.33869054805,
        ["g"] = 64,
        ["sublevel"] = 2,
        ["week"] = {
          [2] = true,
          [3] = true,
          [5] = true,
          [6] = true,
          [8] = true,
          [9] = true,
          [11] = true,
          [12] = true,
        },
      },
    },
  },
  [47] = {
    ["name"] = "Enchanted Emissary",
    ["id"] = 155432,
    ["count"] = 4,
    ["health"] = 10071399,
    ["ignoreFortified"] = true,
    ["scale"] = 0.7,
    ["displayId"] = 39391,
    ["iconTexture"] = 135735,
    ["creatureType"] = "Humanoid",
    ["level"] = 121,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [290027] = {
      },
      [302415] = {
      },
      [303632] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 611.15319130805,
        ["y"] = -88.574309265575,
        ["g"] = 1,
        ["sublevel"] = 1,
        ["week"] = {
          [1] = true,
          [4] = true,
          [7] = true,
          [10] = true,
        },
      },
      [2] = {
        ["x"] = 467.53707745317,
        ["y"] = -162.7838707085,
        ["g"] = 17,
        ["sublevel"] = 1,
        ["week"] = {
          [1] = true,
          [4] = true,
          [7] = true,
          [10] = true,
        },
      },
      [3] = {
        ["x"] = 542.30315452555,
        ["y"] = -304.85254766983,
        ["sublevel"] = 1,
        ["week"] = {
          [1] = true,
          [4] = true,
          [7] = true,
          [10] = true,
        },
      },
      [4] = {
        ["x"] = 453.89339523727,
        ["y"] = -410.38932404723,
        ["g"] = 40,
        ["sublevel"] = 1,
        ["week"] = {
          [1] = true,
          [4] = true,
          [7] = true,
          [10] = true,
        },
      },
      [5] = {
        ["x"] = 420.91492385304,
        ["y"] = -443.52326411391,
        ["g"] = 44,
        ["sublevel"] = 1,
        ["week"] = {
          [1] = true,
          [4] = true,
          [7] = true,
          [10] = true,
        },
      },
      [6] = {
        ["x"] = 533.9982875369,
        ["y"] = -110.85639208494,
        ["g"] = 6,
        ["sublevel"] = 1,
        ["week"] = {
          [2] = true,
          [5] = true,
          [8] = true,
          [11] = true,
        },
      },
      [7] = {
        ["x"] = 522.11041121354,
        ["y"] = -258.96340443087,
        ["g"] = 24,
        ["sublevel"] = 1,
        ["week"] = {
          [2] = true,
          [5] = true,
          [8] = true,
          [11] = true,
        },
      },
      [8] = {
        ["x"] = 428.18511485828,
        ["y"] = -416.51805129462,
        ["g"] = 41,
        ["sublevel"] = 1,
        ["week"] = {
          [2] = true,
          [5] = true,
          [8] = true,
          [11] = true,
        },
      },
      [9] = {
        ["x"] = 552.43014693802,
        ["y"] = -91.434529033634,
        ["g"] = 3,
        ["sublevel"] = 1,
        ["week"] = {
          [3] = true,
          [6] = true,
          [9] = true,
          [12] = true,
        },
      },
      [10] = {
        ["x"] = 632.74911628192,
        ["y"] = -92.10122188565,
        ["g"] = 74,
        ["sublevel"] = 2,
        ["week"] = {
          [2] = true,
          [5] = true,
          [8] = true,
          [11] = true,
        },
      },
      [11] = {
        ["x"] = 586.71705255714,
        ["y"] = -93.286352517427,
        ["g"] = 50,
        ["sublevel"] = 2,
        ["week"] = {
          [3] = true,
          [6] = true,
          [9] = true,
          [12] = true,
        },
      },
      [12] = {
        ["x"] = 617.42410492582,
        ["y"] = -98.209666835254,
        ["g"] = 76,
        ["sublevel"] = 2,
        ["week"] = {
          [3] = true,
          [6] = true,
          [9] = true,
          [12] = true,
        },
      },
      [13] = {
        ["x"] = 483.19658481283,
        ["y"] = -222.29793966383,
        ["g"] = 21,
        ["sublevel"] = 1,
        ["week"] = {
          [3] = true,
          [6] = true,
          [9] = true,
          [12] = true,
        },
      },
      [14] = {
        ["x"] = 516.98007601731,
        ["y"] = -317.97340426787,
        ["g"] = 33,
        ["sublevel"] = 1,
        ["week"] = {
          [3] = true,
          [6] = true,
          [9] = true,
          [12] = true,
        },
      },
      [15] = {
        ["x"] = 457.00352702145,
        ["y"] = -380.71228589938,
        ["g"] = 36,
        ["sublevel"] = 1,
        ["week"] = {
          [3] = true,
          [6] = true,
          [9] = true,
          [12] = true,
        },
      },
      [16] = {
        ["x"] = 427.29094862578,
        ["y"] = -420.08134133173,
        ["g"] = 41,
        ["sublevel"] = 1,
        ["week"] = {
          [3] = true,
          [6] = true,
          [9] = true,
          [12] = true,
        },
      },
      [17] = {
        ["x"] = 402.4320510277,
        ["y"] = -425.90018296071,
        ["g"] = 43,
        ["sublevel"] = 1,
        ["week"] = {
          [3] = true,
          [6] = true,
          [9] = true,
          [12] = true,
        },
      },
    },
  },
  [48] = {
    ["name"] = "Samh'rek, Beckoner of Chaos",
    ["id"] = 161243,
    ["count"] = 4,
    ["teemingCount"] = 6,
    ["health"] = 1409996,
    ["scale"] = 0.8,
    ["stealthDetect"] = true,
    ["displayId"] = 90742,
    ["creatureType"] = "Aberration",
    ["level"] = 122,
    ["corrupted"] = true,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [314397] = {
      },
      [314477] = {
      },
      [314483] = {
      },
      [314531] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 431.49685325048,
        ["y"] = -400.45707548781,
        ["sublevel"] = 1,
        ["week"] = {
          [1] = true,
          [2] = true,
          [5] = true,
          [6] = true,
          [9] = true,
          [10] = true,
        },
      },
      [2] = {
        ["x"] = 549.70320325251,
        ["y"] = -112.17227814258,
        ["sublevel"] = 1,
        ["week"] = {
          [3] = true,
          [4] = true,
          [7] = true,
          [8] = true,
          [11] = true,
          [12] = true,
        },
      },
    },
  },
  [49] = {
    ["name"] = "Urg'roth, Breaker of Heroes",
    ["id"] = 161124,
    ["count"] = 4,
    ["teemingCount"] = 6,
    ["health"] = 1510710,
    ["scale"] = 0.8,
    ["stealthDetect"] = true,
    ["displayId"] = 89415,
    ["creatureType"] = "Aberration",
    ["level"] = 122,
    ["corrupted"] = true,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [314308] = {
      },
      [314309] = {
      },
      [314387] = {
      },
      [314397] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 549.93045867439,
        ["y"] = -112.89332275349,
        ["sublevel"] = 1,
        ["week"] = {
          [1] = true,
          [2] = true,
          [5] = true,
          [6] = true,
          [9] = true,
          [10] = true,
        },
      },
      [2] = {
        ["x"] = 432.57146438212,
        ["y"] = -400.45946829255,
        ["sublevel"] = 1,
        ["week"] = {
          [3] = true,
          [4] = true,
          [7] = true,
          [8] = true,
          [11] = true,
          [12] = true,
        },
      },
    },
  },
  [50] = {
    ["name"] = "Voidweaver Mal'thir",
    ["id"] = 161241,
    ["count"] = 4,
    ["teemingCount"] = 6,
    ["health"] = 1309282,
    ["scale"] = 0.8,
    ["stealthDetect"] = true,
    ["displayId"] = 91910,
    ["creatureType"] = "Beast",
    ["level"] = 122,
    ["corrupted"] = true,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [314397] = {
      },
      [314406] = {
      },
      [314411] = {
      },
      [314463] = {
      },
      [314467] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 500.3789025889,
        ["y"] = -212.80203276973,
        ["sublevel"] = 1,
        ["week"] = {
          [1] = true,
          [2] = true,
          [3] = true,
          [4] = true,
          [5] = true,
          [6] = true,
          [7] = true,
          [8] = true,
          [9] = true,
          [10] = true,
          [11] = true,
          [12] = true,
        },
      },
    },
  },
  [51] = {
    ["name"] = "Blood of the Corruptor",
    ["id"] = 161244,
    ["count"] = 4,
    ["teemingCount"] = 6,
    ["health"] = 1409996,
    ["scale"] = 0.8,
    ["stealthDetect"] = true,
    ["displayId"] = 92229,
    ["creatureType"] = "Aberration",
    ["level"] = 122,
    ["corrupted"] = true,
    ["characteristics"] = {
      ["Taunt"] = true,
    },
    ["spells"] = {
      [314397] = {
      },
      [314565] = {
      },
      [314566] = {
      },
      [314592] = {
      },
    },
    ["clones"] = {
      [1] = {
        ["x"] = 540.27364734989,
        ["y"] = -321.29631109725,
        ["sublevel"] = 1,
        ["week"] = {
          [1] = true,
          [2] = true,
          [3] = true,
          [4] = true,
          [5] = true,
          [6] = true,
          [7] = true,
          [8] = true,
          [9] = true,
          [10] = true,
          [11] = true,
          [12] = true,
        },
      },
    },
  },
  [52] = {
    ["name"] = "Demolishing Terror",
    ["id"] = 137614,
    ["count"] = 0,
    ["health"] = 461097,
    ["ignoreFortified"] = true,
    ["scale"] = 1,
    ["displayId"] = 86691,
    ["creatureType"] = "Aberration",
    ["level"] = 121,
    ["clones"] = {
      [1] = {
        ["x"] = 446.77737426181,
        ["y"] = -511.56325370334,
        ["g"] = 78,
        ["sublevel"] = 1,
      },
    },
  },
  [53] = {
    ["name"] = "Gripping Terror",
    ["id"] = 137405,
    ["count"] = 0,
    ["health"] = 1383291,
    ["scale"] = 1,
    ["displayId"] = 88448,
    ["creatureType"] = "Aberration",
    ["level"] = 122,
    ["isBoss"] = true,
    ["clones"] = {
      [1] = {
        ["x"] = 417.27559422224,
        ["y"] = -517.07456837719,
        ["g"] = 78,
        ["sublevel"] = 1,
      },
    },
  },
};
