local MDT = MDT
local L = MDT.L
local dungeonIndex = 19
MDT.mapInfo[dungeonIndex] = {
    viewportPositionOverrides =
    {
        [2] = {
            zoomScale = 4.2999997138977;
            horizontalPan = 499.11205542634;
            verticalPan = 38.703272826513;
        };
    };
};
MDT.dungeonTotalCount[dungeonIndex] = {normal=319,teeming=383,teemingEnabled=true}


local selectorGroup
local AceGUI = LibStub("AceGUI-3.0")
local db
local function fixBoralusShowHide(widget, frame, isFrame)
    frame = frame or MDT.main_frame
    local originalShow,originalHide = frame.Show,frame.Hide
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
        selectorGroup.frame.bg = selectorGroup.frame:CreateTexture(nil, "BACKGROUND")
        selectorGroup.frame.bg:SetAllPoints(selectorGroup.frame)
        selectorGroup.frame.bg:SetColorTexture(unpack(MDT.BackdropColor))
        selectorGroup:SetWidth(120)
        selectorGroup:SetHeight(120)
        selectorGroup.frame:SetPoint("TOPRIGHT", MDT.main_frame,"TOPRIGHT",0,0)

        local label = AceGUI:Create("Label")
        label:SetText("  Faction:")
        selectorGroup:AddChild(label)

        selectorGroup.check1 = AceGUI:Create("CheckBox")
        selectorGroup.check2 = AceGUI:Create("CheckBox")
        local check1 = selectorGroup.check1
        local check2 = selectorGroup.check2

        check1:SetLabel("Horde")
        selectorGroup:AddChild(check1)
        check1:SetCallback("OnValueChanged",function(widget,callbackName,value)
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
        check2:SetCallback("OnValueChanged",function(widget,callbackName,value)
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
    selectorGroup.check1:SetValue(MDT:GetCurrentPreset().faction==1)
    selectorGroup.check2:SetValue(MDT:GetCurrentPreset().faction==2)
    MDT:DungeonEnemies_UpdateSeasonalAffix()
    MDT:DungeonEnemies_UpdateBoralusFaction(MDT:GetCurrentPreset().faction)
end

MDT.mapPOIs[dungeonIndex] = {
    [1] = {
        [1] = {
            ["y"] = -112.09388221952;
            ["x"] = 526.6887930726;
            ["template"] = "DeathReleasePinTemplate";
            ["graveyardDescription"] = L["siegeGraveyardNote1"];
            ["type"] = "graveyard";
        };
        [2] = {
            ["y"] = -92.022559498794;
            ["x"] = 632.01973061572;
            ["template"] = "DeathReleasePinTemplate";
            ["graveyardDescription"] = "";
            ["type"] = "graveyard";
        };
        [3] = {
            ["y"] = -334.61016080079;
            ["x"] = 432.0393310099;
            ["template"] = "DeathReleasePinTemplate";
            ["graveyardDescription"] = L["siegeGraveyardNote2"];
            ["type"] = "graveyard";
        };
        [4] = {
            ["y"] = -462.91658652644;
            ["x"] = 405.60201958621;
            ["template"] = "DeathReleasePinTemplate";
            ["graveyardDescription"] = L["siegeGraveyardNote3"];
            ["type"] = "graveyard";
        };
        [5] = {
            ["y"] = -99.22379149751;
            ["x"] = 510.75103230284;
            ["template"] = "MapLinkPinTemplate";
            ["type"] = "sobGutters";
        };
        [6] = {
            ["y"] = -279.04184468091;
            ["x"] = 540.43646488041;
            ["template"] = "MapLinkPinTemplate";
            ["type"] = "sobGutters";
        };
        [7] = {
            ["y"] = -229.95502100789;
            ["x"] = 471.82728422311;
            ["template"] = "MapLinkPinTemplate";
            ["text"] = L["siegeGutterNote2"];
            ["type"] = "generalNote";
        };
        [8] = {
            ["y"] = -430.03927979814;
            ["x"] = 465.16418914774;
            ["template"] = "MapLinkPinTemplate";
            ["text"] = L["siegeDuplicateNote"];
            ["type"] = "generalNote";
        };
        [9] = {
            ["y"] = -124.84024119419;
            ["x"] = 572.9478796215;
            ["template"] = "MapLinkPinTemplate";
            ["target"] = 2;
            ["connectionIndex"] = 1;
            ["type"] = "mapLink";
            ["direction"] = 1;
        };
        [10] = {
            ["npcId"] = 161124;
            ["type"] = "nyalothaSpire";
            ["index"] = 1;
            ["scale"] = 0.7;
            ["y"] = -122.22662170754;
            ["x"] = 550.63726674726;
            ["tooltipText"] = L["Brutal Spire of Ny'alotha"];
            ["weeks"] = {
                [1] = true;
                [2] = true;
                [5] = true;
                [6] = true;
                [9] = true;
                [10] = true;
            };
            ["template"] = "VignettePinTemplate";
        };
        [11] = {
            ["npcId"] = 161241;
            ["type"] = "nyalothaSpire";
            ["index"] = 2;
            ["scale"] = 0.7;
            ["y"] = -217.12907064976;
            ["x"] = 494.06258998939;
            ["tooltipText"] = L["Cursed Spire of Ny'alotha"];
            ["weeks"] = {
                [1] = true;
                [2] = true;
                [3] = true;
                [4] = true;
                [5] = true;
                [6] = true;
                [7] = true;
                [8] = true;
                [9] = true;
                [10] = true;
                [11] = true;
                [12] = true;
            };
            ["template"] = "VignettePinTemplate";
        };
        [12] = {
            ["npcId"] = 161244;
            ["type"] = "nyalothaSpire";
            ["index"] = 3;
            ["scale"] = 0.7;
            ["y"] = -328.36921673268;
            ["x"] = 530.89268892545;
            ["tooltipText"] = L["Defiled Spire of Ny'alotha"];
            ["weeks"] = {
                [1] = true;
                [2] = true;
                [3] = true;
                [4] = true;
                [5] = true;
                [6] = true;
                [7] = true;
                [8] = true;
                [9] = true;
                [10] = true;
                [11] = true;
                [12] = true;
            };
            ["template"] = "VignettePinTemplate";
        };
        [13] = {
            ["npcId"] = 161243;
            ["type"] = "nyalothaSpire";
            ["index"] = 4;
            ["scale"] = 0.7;
            ["y"] = -396.94453369288;
            ["x"] = 424.87741140656;
            ["tooltipText"] = L["Entropic Spire of Ny'alotha"];
            ["weeks"] = {
                [1] = true;
                [2] = true;
                [5] = true;
                [6] = true;
                [9] = true;
                [10] = true;
            };
            ["template"] = "VignettePinTemplate";
        };
        [14] = {
            ["npcId"] = 161243;
            ["type"] = "nyalothaSpire";
            ["index"] = 5;
            ["scale"] = 0.7;
            ["y"] = -121.85313378182;
            ["x"] = 550.49052504675;
            ["tooltipText"] = L["Entropic Spire of Ny'alotha"];
            ["weeks"] = {
                [11] = true;
                [7] = true;
                [8] = true;
                [3] = true;
                [12] = true;
                [4] = true;
            };
            ["template"] = "VignettePinTemplate";
        };
        [15] = {
            ["npcId"] = 161124;
            ["type"] = "nyalothaSpire";
            ["index"] = 6;
            ["scale"] = 0.7;
            ["y"] = -397.50552052502;
            ["x"] = 424.87741140656;
            ["tooltipText"] = L["Brutal Spire of Ny'alotha"];
            ["weeks"] = {
                [11] = true;
                [7] = true;
                [8] = true;
                [3] = true;
                [12] = true;
                [4] = true;
            };
            ["template"] = "VignettePinTemplate";
        };
    };
    [2] = {
        [1] = {
            ["y"] = -116.64905996375;
            ["x"] = 552.76424026611;
            ["template"] = "MapLinkPinTemplate";
            ["target"] = 1;
            ["connectionIndex"] = 1;
            ["type"] = "mapLink";
            ["direction"] = -1;
        };
    };
};

MDT.dungeonEnemies[dungeonIndex] = {
    [1] = {
        ["clones"] = {
            [1] = {
                ["sublevel"] = 1;
                ["x"] = 611.53324048298;
                ["faction"] = 1;
                ["y"] = -94.74910945841;
                ["g"] = 1;
                ["infested"] = {
                    [2] = true;
                };
            };
            [2] = {
                ["sublevel"] = 1;
                ["x"] = 603.77923440022;
                ["patrol"] = {
                    [1] = {
                        ["y"] = -110.15644771174;
                        ["x"] = 603.77923440022;
                    };
                    [2] = {
                        ["y"] = -108.10053673243;
                        ["x"] = 605.50874426297;
                    };
                    [3] = {
                        ["y"] = -102.70581962774;
                        ["x"] = 606.16664761087;
                    };
                    [4] = {
                        ["y"] = -108.10053673243;
                        ["x"] = 605.50874426297;
                    };
                    [5] = {
                        ["y"] = -108.10053673243;
                        ["x"] = 605.50874426297;
                    };
                    [6] = {
                        ["y"] = -111.12685825223;
                        ["x"] = 599.19296247123;
                    };
                    [7] = {
                        ["y"] = -107.73892927049;
                        ["x"] = 583.88643955623;
                    };
                    [8] = {
                        ["y"] = -111.12685825223;
                        ["x"] = 599.19296247123;
                    };
                };
                ["faction"] = 1;
                ["y"] = -110.15644771174;
                ["infested"] = {
                    [3] = true;
                };
            };
            [3] = {
                ["sublevel"] = 1;
                ["x"] = 504.88057117788;
                ["faction"] = 1;
                ["y"] = -115.38505847239;
                ["g"] = 10;
                ["infested"] = {
                    [3] = true;
                };
            };
            [4] = {
                ["y"] = -86.689259412394;
                ["x"] = 551.02023392022;
                ["teeming"] = true;
                ["g"] = 3;
                ["sublevel"] = 1;
            };
            [5] = {
                ["y"] = -93.926094597687;
                ["x"] = 549.70442722442;
                ["teeming"] = true;
                ["g"] = 3;
                ["sublevel"] = 1;
            };
            [6] = {
                ["y"] = -88.220507692615;
                ["x"] = 587.98214466641;
                ["faction"] = 1;
                ["g"] = 50;
                ["sublevel"] = 2;
            };
            [7] = {
                ["y"] = -98.31241038307;
                ["x"] = 584.58759124865;
                ["faction"] = 1;
                ["g"] = 50;
                ["sublevel"] = 2;
            };
            [8] = {
                ["y"] = -94.042993851526;
                ["x"] = 627.7808287114;
                ["faction"] = 1;
                ["g"] = 74;
                ["sublevel"] = 2;
            };
            [9] = {
                ["y"] = -106.28007102039;
                ["x"] = 623.57019967025;
                ["faction"] = 1;
                ["g"] = 75;
                ["sublevel"] = 2;
            };
        };
        ["reaping"] = 148716;
        ["scale"] = 0.7;
        ["spells"] = {
            [277564] = {};
            [209859] = {};
            [277242] = {};
            [256627] = {};
        };
        ["id"] = 141283;
        ["count"] = 4;
        ["name"] = "Kul Tiran Halberd";
        ["displayId"] = 84074;
        ["creatureType"] = "Humanoid";
        ["level"] = 120;
        ["health"] = 768495;
        ["characteristics"] = {
            ["Taunt"] = true;
            ["Incapacitate"] = true;
            ["Root"] = true;
            ["Polymorph"] = true;
            ["Disorient"] = true;
            ["Sap"] = true;
            ["Stun"] = true;
            ["Slow"] = true;
            ["Silence"] = true;
            ["Fear"] = true;
        };
    };
    [2] = {
        ["clones"] = {
            [1] = {
                ["y"] = -90.192147612201;
                ["x"] = 618.62184297058;
                ["faction"] = 1;
                ["g"] = 1;
                ["sublevel"] = 1;
            };
            [2] = {
                ["sublevel"] = 1;
                ["x"] = 617.86235023493;
                ["faction"] = 1;
                ["infested"] = {
                    [1] = true;
                };
                ["g"] = 1;
                ["y"] = -95.255434327295;
            };
            [3] = {
                ["sublevel"] = 1;
                ["x"] = 618.11550723705;
                ["faction"] = 1;
                ["g"] = 1;
                ["y"] = -99.938963809923;
            };
            [4] = {
                ["sublevel"] = 1;
                ["x"] = 582.74720588507;
                ["faction"] = 1;
                ["g"] = 2;
                ["y"] = -100.01741254831;
            };
            [5] = {
                ["sublevel"] = 1;
                ["x"] = 581.48139914518;
                ["faction"] = 1;
                ["infested"] = {
                    [1] = true;
                };
                ["g"] = 2;
                ["y"] = -103.94146015993;
            };
            [6] = {
                ["sublevel"] = 1;
                ["x"] = 580.21555981137;
                ["faction"] = 1;
                ["g"] = 2;
                ["y"] = -108.49841657382;
            };
            [7] = {
                ["sublevel"] = 1;
                ["x"] = 510.11098019186;
                ["faction"] = 1;
                ["g"] = 10;
                ["y"] = -115.04246180632;
            };
            [8] = {
                ["sublevel"] = 1;
                ["x"] = 512.22634355934;
                ["faction"] = 1;
                ["infested"] = {
                    [1] = true;
                };
                ["g"] = 10;
                ["y"] = -117.92706622296;
            };
            [9] = {
                ["y"] = -99.545943130245;
                ["x"] = 589.89241286915;
                ["faction"] = 1;
                ["g"] = 50;
                ["sublevel"] = 2;
            };
            [10] = {
                ["y"] = -96.141952005365;
                ["x"] = 591.68189914226;
                ["faction"] = 1;
                ["g"] = 50;
                ["sublevel"] = 2;
            };
            [11] = {
                ["y"] = -93.284769448871;
                ["x"] = 592.5610358643;
                ["faction"] = 1;
                ["g"] = 50;
                ["sublevel"] = 2;
            };
            [12] = {
                ["y"] = -90.317684191023;
                ["x"] = 593.33027931706;
                ["faction"] = 1;
                ["g"] = 50;
                ["sublevel"] = 2;
            };
            [13] = {
                ["y"] = -99.17465536839;
                ["x"] = 629.096593417;
                ["faction"] = 1;
                ["g"] = 74;
                ["sublevel"] = 2;
            };
            [14] = {
                ["y"] = -97.332530885476;
                ["x"] = 633.04406433183;
                ["faction"] = 1;
                ["g"] = 74;
                ["sublevel"] = 2;
            };
            [15] = {
                ["y"] = -95.490406402562;
                ["x"] = 635.93882814964;
                ["faction"] = 1;
                ["g"] = 74;
                ["sublevel"] = 2;
            };
            [16] = {
                ["y"] = -111.14854770824;
                ["x"] = 622.78073710961;
                ["faction"] = 1;
                ["g"] = 75;
                ["sublevel"] = 2;
            };
            [17] = {
                ["y"] = -110.62222804079;
                ["x"] = 625.28075270657;
                ["faction"] = 1;
                ["g"] = 75;
                ["sublevel"] = 2;
            };
            [18] = {
                ["y"] = -109.43800031877;
                ["x"] = 627.91239621856;
                ["faction"] = 1;
                ["g"] = 75;
                ["sublevel"] = 2;
            };
            [19] = {
                ["y"] = -94.04310015081;
                ["x"] = 617.64905949405;
                ["faction"] = 1;
                ["g"] = 76;
                ["sublevel"] = 2;
            };
            [20] = {
                ["y"] = -95.358893672589;
                ["x"] = 614.49113019567;
                ["faction"] = 1;
                ["g"] = 76;
                ["sublevel"] = 2;
            };
            [21] = {
                ["y"] = -95.227322225992;
                ["x"] = 610.93843008907;
                ["faction"] = 1;
                ["g"] = 76;
                ["sublevel"] = 2;
            };
            [22] = {
                ["y"] = -104.96435185962;
                ["x"] = 604.75415689155;
                ["faction"] = 1;
                ["g"] = 64;
                ["sublevel"] = 2;
            };
            [23] = {
                ["y"] = -109.43810856084;
                ["x"] = 604.49099141099;
                ["faction"] = 1;
                ["g"] = 64;
                ["sublevel"] = 2;
            };
            [24] = {
                ["y"] = -113.1223744672;
                ["x"] = 603.4383407824;
                ["faction"] = 1;
                ["g"] = 64;
                ["sublevel"] = 2;
            };
        };
        ["reaping"] = 148716;
        ["scale"] = 0.5;
        ["spells"] = {
            [277564] = {};
            [209859] = {};
            [277242] = {};
            [273930] = {};
        };
        ["id"] = 141495;
        ["count"] = 1;
        ["name"] = "Kul Tiran Footman";
        ["displayId"] = 86025;
        ["creatureType"] = "Humanoid";
        ["level"] = 120;
        ["health"] = 249761;
        ["characteristics"] = {
            ["Taunt"] = true;
            ["Incapacitate"] = true;
            ["Root"] = true;
            ["Polymorph"] = true;
            ["Disorient"] = true;
            ["Sap"] = true;
            ["Stun"] = true;
            ["Slow"] = true;
            ["Silence"] = true;
            ["Fear"] = true;
        };
    };
    [3] = {
        ["clones"] = {
            [1] = {
                ["sublevel"] = 1;
                ["x"] = 576.53112335304;
                ["faction"] = 1;
                ["y"] = -103.47383528397;
                ["g"] = 2;
                ["infested"] = {
                    [2] = true;
                };
            };
            [2] = {
                ["sublevel"] = 1;
                ["x"] = 507.6109962998;
                ["faction"] = 1;
                ["y"] = -120.61937688321;
                ["g"] = 10;
                ["infested"] = {
                    [2] = true;
                };
            };
            [3] = {
                ["sublevel"] = 1;
                ["x"] = 508.42957993605;
                ["faction"] = 1;
                ["y"] = -156.40629336908;
                ["g"] = 14;
                ["infested"] = {
                    [3] = true;
                };
            };
            [4] = {
                ["y"] = -91.196816197011;
                ["x"] = 581.68174368838;
                ["faction"] = 1;
                ["g"] = 50;
                ["sublevel"] = 2;
            };
            [5] = {
                ["y"] = -91.148313793261;
                ["x"] = 613.96478086303;
                ["faction"] = 1;
                ["g"] = 76;
                ["sublevel"] = 2;
            };
            [6] = {
                ["y"] = -110.35918209598;
                ["x"] = 599.49091504232;
                ["faction"] = 1;
                ["g"] = 64;
                ["sublevel"] = 2;
            };
        };
        ["reaping"] = 148893;
        ["scale"] = 0.7;
        ["spells"] = {
            [257063] = {};
            [277242] = {};
            [209859] = {};
            [257069] = {};
            [256957] = {};
            [277564] = {};
        };
        ["id"] = 141284;
        ["count"] = 4;
        ["name"] = "Kul Tiran Wavetender";
        ["displayId"] = 81778;
        ["creatureType"] = "Humanoid";
        ["level"] = 120;
        ["health"] = 614795;
        ["characteristics"] = {
            ["Taunt"] = true;
            ["Disorient"] = true;
            ["Sap"] = true;
            ["Polymorph"] = true;
            ["Stun"] = true;
            ["Slow"] = true;
            ["Incapacitate"] = true;
            ["Root"] = true;
        };
    };
    [4] = {
        ["clones"] = {
            [1] = {
                ["sublevel"] = 1;
                ["x"] = 555.0334026991;
                ["faction"] = 1;
                ["g"] = 3;
                ["y"] = -97.101943149409;
            };
            [2] = {
                ["sublevel"] = 1;
                ["x"] = 557.03099549273;
                ["faction"] = 1;
                ["y"] = -87.089965272499;
                ["g"] = 3;
                ["infested"] = {
                    [2] = true;
                    [3] = true;
                };
            };
            [3] = {
                ["sublevel"] = 1;
                ["x"] = 511.06478359356;
                ["faction"] = 1;
                ["g"] = 10;
                ["y"] = -125.25348446226;
            };
            [4] = {
                ["sublevel"] = 1;
                ["x"] = 494.73669097353;
                ["faction"] = 1;
                ["g"] = 13;
                ["y"] = -136.00427567529;
            };
            [5] = {
                ["sublevel"] = 1;
                ["x"] = 504.22957666175;
                ["faction"] = 1;
                ["g"] = 14;
                ["y"] = -153.8062895029;
            };
        };
        ["reaping"] = 148716;
        ["scale"] = 0.7;
        ["spells"] = {
            [257641] = {};
            [209859] = {};
            [277242] = {};
            [277564] = {};
        };
        ["id"] = 141285;
        ["count"] = 4;
        ["name"] = "Kul Tiran Marksman";
        ["displayId"] = 88463;
        ["creatureType"] = "Humanoid";
        ["level"] = 120;
        ["health"] = 691646;
        ["characteristics"] = {
            ["Taunt"] = true;
            ["Incapacitate"] = true;
            ["Root"] = true;
            ["Disorient"] = true;
            ["Sap"] = true;
            ["Fear"] = true;
            ["Silence"] = true;
            ["Slow"] = true;
            ["Stun"] = true;
            ["Imprison"] = true;
        };
    };
    [5] = {
        ["clones"] = {
            [1] = {
                ["sublevel"] = 1;
                ["x"] = 542.86233404787;
                ["faction"] = 1;
                ["g"] = 4;
                ["y"] = -87.741893475521;
            };
            [2] = {
                ["sublevel"] = 1;
                ["x"] = 540.92218649805;
                ["faction"] = 1;
                ["g"] = 5;
                ["y"] = -99.568132398982;
            };
            [3] = {
                ["sublevel"] = 1;
                ["x"] = 539.48382239149;
                ["faction"] = 1;
                ["g"] = 6;
                ["y"] = -103.92907046769;
            };
            [4] = {
                ["sublevel"] = 1;
                ["x"] = 541.50319084819;
                ["faction"] = 1;
                ["g"] = 6;
                ["y"] = -109.93231234935;
            };
            [5] = {
                ["sublevel"] = 1;
                ["x"] = 521.62802118769;
                ["faction"] = 1;
                ["g"] = 7;
                ["y"] = -103.87973231655;
            };
            [6] = {
                ["sublevel"] = 1;
                ["x"] = 518.95715322177;
                ["faction"] = 1;
                ["g"] = 8;
                ["y"] = -116.38860063055;
            };
            [7] = {
                ["sublevel"] = 1;
                ["x"] = 523.97836687484;
                ["faction"] = 1;
                ["g"] = 9;
                ["y"] = -126.67777977295;
            };
            [8] = {
                ["sublevel"] = 1;
                ["x"] = 527.00164322093;
                ["faction"] = 1;
                ["g"] = 9;
                ["y"] = -123.65452338748;
            };
            [9] = {
                ["sublevel"] = 1;
                ["x"] = 499.93323993929;
                ["faction"] = 1;
                ["g"] = 11;
                ["y"] = -125.60478957167;
            };
            [10] = {
                ["sublevel"] = 1;
                ["x"] = 493.74373233938;
                ["faction"] = 1;
                ["g"] = 12;
                ["y"] = -128.38270722552;
            };
            [11] = {
                ["sublevel"] = 1;
                ["x"] = 531.70160159579;
                ["faction"] = 1;
                ["g"] = 25;
                ["y"] = -249.61912950879;
            };
            [12] = {
                ["sublevel"] = 1;
                ["x"] = 543.04486771625;
                ["faction"] = 1;
                ["g"] = 25;
                ["y"] = -247.52958183507;
            };
            [13] = {
                ["sublevel"] = 1;
                ["x"] = 533.81647645127;
                ["faction"] = 1;
                ["g"] = 25;
                ["y"] = -256.25419647414;
            };
            [14] = {
                ["sublevel"] = 1;
                ["x"] = 540.80607075495;
                ["faction"] = 1;
                ["g"] = 25;
                ["y"] = -252.60419852913;
            };
            [15] = {
                ["sublevel"] = 1;
                ["x"] = 534.32282304943;
                ["faction"] = 1;
                ["g"] = 25;
                ["y"] = -262.2035707229;
            };
            [16] = {
                ["sublevel"] = 1;
                ["x"] = 544.83592322006;
                ["faction"] = 1;
                ["g"] = 25;
                ["y"] = -259.17136574654;
            };
            [17] = {
                ["sublevel"] = 1;
                ["x"] = 549.31354276376;
                ["faction"] = 1;
                ["g"] = 25;
                ["y"] = -254.09674905248;
            };
            [18] = {
                ["sublevel"] = 1;
                ["x"] = 513.48725074411;
                ["faction"] = 1;
                ["g"] = 26;
                ["y"] = -281.78978442034;
            };
            [19] = {
                ["sublevel"] = 1;
                ["x"] = 520.24441555424;
                ["faction"] = 1;
                ["g"] = 27;
                ["y"] = -284.49819137727;
            };
            [20] = {
                ["sublevel"] = 1;
                ["x"] = 558.94605246634;
                ["faction"] = 1;
                ["g"] = 28;
                ["y"] = -291.49049888556;
            };
            [21] = {
                ["sublevel"] = 1;
                ["x"] = 548.67209807094;
                ["faction"] = 1;
                ["g"] = 29;
                ["y"] = -299.02474425839;
            };
            [22] = {
                ["sublevel"] = 1;
                ["x"] = 533.6977027601;
                ["faction"] = 1;
                ["g"] = 30;
                ["y"] = -303.96667733386;
            };
            [23] = {
                ["sublevel"] = 1;
                ["x"] = 525.34327180333;
                ["faction"] = 1;
                ["g"] = 31;
                ["y"] = -303.33376853159;
            };
            [24] = {
                ["sublevel"] = 1;
                ["x"] = 532.60962121856;
                ["faction"] = 1;
                ["g"] = 31;
                ["y"] = -310.38854239272;
            };
            [25] = {
                ["sublevel"] = 1;
                ["x"] = 520.05602776878;
                ["faction"] = 1;
                ["g"] = 32;
                ["y"] = -308.23708254048;
            };
            [26] = {
                ["sublevel"] = 1;
                ["x"] = 461.74934602061;
                ["y"] = -228.99519617792;
                ["g"] = 72;
                ["week"] = {
                    [5] = true;
                    [2] = true;
                    [8] = true;
                    [11] = true;
                };
            };
            [27] = {
                ["y"] = -229.08355032762;
                ["x"] = 465.85256533526;
                ["g"] = 72;
                ["sublevel"] = 1;
            };
            [28] = {
                ["y"] = -234.42998602391;
                ["x"] = 463.92330674024;
                ["g"] = 72;
                ["sublevel"] = 1;
            };
            [29] = {
                ["y"] = -234.21258248841;
                ["x"] = 467.83630915541;
                ["g"] = 72;
                ["sublevel"] = 1;
            };
        };
        ["reaping"] = 148716;
        ["scale"] = 0.5;
        ["spells"] = {
            [277564] = {};
            [256616] = {};
        };
        ["id"] = 141566;
        ["count"] = 1;
        ["name"] = "Scrimshaw Gutter";
        ["displayId"] = 83892;
        ["creatureType"] = "Humanoid";
        ["level"] = 120;
        ["health"] = 153699;
        ["characteristics"] = {
            ["Taunt"] = true;
            ["Slow"] = true;
            ["Root"] = true;
        };
    };
    [6] = {
        ["clones"] = {
            [1] = {
                ["sublevel"] = 1;
                ["x"] = 488.41561252114;
                ["faction"] = 1;
                ["g"] = 16;
                ["y"] = -155.97452951895;
            };
        };
        ["health"] = 4303572;
        ["scale"] = 0.8;
        ["spells"] = {
            [256867] = {};
            [273681] = {};
            [273716] = {};
            [260924] = {};
            [260954] = {};
            [257650] = {};
            [261428] = {};
        };
        ["isBoss"] = true;
        ["encounterID"] = 2133;
        ["instanceID"] = 1023;
        ["name"] = "Sergeant Bainbridge";
        ["count"] = 0;
        ["displayId"] = 84382;
        ["creatureType"] = "Humanoid";
        ["level"] = 122;
        ["id"] = 128649;
        ["characteristics"] = {
            ["Taunt"] = true;
        };
    };
    [7] = {
        ["clones"] = {
            [1] = {
                ["sublevel"] = 1;
                ["x"] = 480.38450693339;
                ["faction"] = 1;
                ["g"] = 16;
                ["y"] = -150.64514896904;
            };
        };
        ["reaping"] = 148894;
        ["scale"] = 1;
        ["spells"] = {
            [257292] = {};
        };
        ["id"] = 132530;
        ["name"] = "Kul Tiran Vanguard";
        ["health"] = 768495;
        ["displayId"] = 84074;
        ["creatureType"] = "Humanoid";
        ["level"] = 121;
        ["count"] = 0;
        ["characteristics"] = {
            ["Taunt"] = true;
            ["Incapacitate"] = true;
            ["Stun"] = true;
            ["Slow"] = true;
            ["Disorient"] = true;
        };
    };
    [8] = {
        ["clones"] = {
            [1] = {
                ["sublevel"] = 1;
                ["x"] = 491.66111302538;
                ["faction"] = 1;
                ["g"] = 16;
                ["y"] = -165.32599550048;
            };
        };
        ["reaping"] = 148716;
        ["scale"] = 1;
        ["spells"] = {
            [257641] = {};
        };
        ["id"] = 132532;
        ["name"] = "Kul Tiran Marksman";
        ["health"] = 768495;
        ["displayId"] = 88463;
        ["creatureType"] = "Humanoid";
        ["level"] = 120;
        ["count"] = 0;
        ["characteristics"] = {
            ["Taunt"] = true;
            ["Incapacitate"] = true;
            ["Sap"] = true;
            ["Imprison"] = true;
            ["Stun"] = true;
            ["Slow"] = true;
            ["Silence"] = true;
            ["Fear"] = true;
        };
    };
    [9] = {
        ["clones"] = {
            [1] = {
                ["y"] = -164.35636428934;
                ["x"] = 473.7446938071;
                ["g"] = 17;
                ["sublevel"] = 1;
            };
            [2] = {
                ["y"] = -116.96394053995;
                ["x"] = 514.69011845294;
                ["patrol"] = {
                    [1] = {
                        ["y"] = -115.64361615773;
                        ["x"] = 514.09318497487;
                    };
                    [2] = {
                        ["y"] = -118.6996791931;
                        ["x"] = 518.01070909048;
                    };
                    [3] = {
                        ["y"] = -123.25663588204;
                        ["x"] = 523.96007826603;
                    };
                    [4] = {
                        ["y"] = -119.83891836534;
                        ["x"] = 527.6309690971;
                    };
                    [5] = {
                        ["y"] = -110.85157263151;
                        ["x"] = 522.31450876202;
                    };
                    [6] = {
                        ["y"] = -108.1933478963;
                        ["x"] = 510.66893829298;
                    };
                    [7] = {
                        ["y"] = -115.15537230305;
                        ["x"] = 513.70690941894;
                    };
                };
                ["faction"] = 2;
                ["sublevel"] = 1;
                ["g"] = 56;
                ["infested"] = {
                    [2] = true;
                };
            };
            [3] = {
                ["y"] = -109.30460389054;
                ["x"] = 509.83375846379;
                ["patrol"] = {
                    [1] = {
                        ["y"] = -109.30460389054;
                        ["x"] = 509.83375846379;
                    };
                    [2] = {
                        ["y"] = -104.64708805649;
                        ["x"] = 511.06662366154;
                    };
                    [3] = {
                        ["y"] = -100.12653348292;
                        ["x"] = 507.09402738896;
                    };
                    [4] = {
                        ["y"] = -107.24981503127;
                        ["x"] = 499.83374009862;
                    };
                    [5] = {
                        ["y"] = -116.4278946475;
                        ["x"] = 503.94333623437;
                    };
                    [6] = {
                        ["y"] = -109.30461897796;
                        ["x"] = 509.97073057483;
                    };
                };
                ["faction"] = 2;
                ["sublevel"] = 1;
                ["g"] = 57;
                ["infested"] = {
                    [3] = true;
                };
            };
            [4] = {
                ["sublevel"] = 1;
                ["x"] = 505.91412599434;
                ["faction"] = 2;
                ["g"] = 14;
                ["y"] = -148.84981394232;
            };
            [5] = {
                ["y"] = -133.8297766545;
                ["x"] = 518.73754193276;
                ["faction"] = 2;
                ["teeming"] = true;
                ["g"] = 55;
                ["sublevel"] = 1;
            };
        };
        ["reaping"] = 148716;
        ["id"] = 129373;
        ["spells"] = {
            [277564] = {};
            [256986] = {};
            [257036] = {};
        };
        ["scale"] = 0.7;
        ["health"] = 768495;
        ["count"] = 4;
        ["displayId"] = 84143;
        ["creatureType"] = "Humanoid";
        ["level"] = 120;
        ["name"] = "Dockhound Packmaster";
        ["characteristics"] = {
            ["Taunt"] = true;
            ["Disorient"] = true;
            ["Root"] = true;
            ["Fear"] = true;
        };
    };
    [10] = {
        ["clones"] = {
            [1] = {
                ["y"] = -158.68471201329;
                ["x"] = 474.3417293891;
                ["g"] = 17;
                ["sublevel"] = 1;
            };
            [2] = {
                ["sublevel"] = 1;
                ["x"] = 501.73370958867;
                ["faction"] = 2;
                ["g"] = 54;
                ["y"] = -100.61038402785;
            };
            [3] = {
                ["sublevel"] = 1;
                ["x"] = 497.76110155846;
                ["faction"] = 2;
                ["y"] = -103.76107518243;
                ["g"] = 54;
                ["infested"] = {
                    [2] = true;
                };
            };
            [4] = {
                ["sublevel"] = 1;
                ["x"] = 509.53003373962;
                ["faction"] = 2;
                ["g"] = 56;
                ["y"] = -119.18260787833;
            };
            [5] = {
                ["sublevel"] = 1;
                ["x"] = 504.49128113579;
                ["faction"] = 2;
                ["g"] = 57;
                ["y"] = -111.77036627504;
            };
            [6] = {
                ["sublevel"] = 1;
                ["x"] = 507.88130892115;
                ["faction"] = 2;
                ["g"] = 14;
                ["y"] = -153.6039050116;
            };
            [7] = {
                ["y"] = -131.80441827157;
                ["x"] = 524.81361164915;
                ["faction"] = 2;
                ["teeming"] = true;
                ["g"] = 55;
                ["sublevel"] = 1;
            };
        };
        ["reaping"] = 148716;
        ["id"] = 129640;
        ["spells"] = {
            [277564] = {};
            [256969] = {};
            [257145] = {};
            [256971] = {};
            [256897] = {};
        };
        ["scale"] = 0.7;
        ["health"] = 768495;
        ["count"] = 4;
        ["displayId"] = 30222;
        ["creatureType"] = "Humanoid";
        ["level"] = 120;
        ["name"] = "Snarling Dockhound";
        ["characteristics"] = {
            ["Taunt"] = true;
            ["Disorient"] = true;
            ["Root"] = true;
            ["Fear"] = true;
        };
    };
    [11] = {
        ["clones"] = {
            [1] = {
                ["sublevel"] = 1;
                ["x"] = 473.14769665675;
                ["y"] = -169.28172529054;
                ["g"] = 17;
                ["infested"] = {
                    [2] = true;
                };
            };
            [2] = {
                ["sublevel"] = 1;
                ["x"] = 551.42484025945;
                ["faction"] = 2;
                ["y"] = -113.46100782736;
                ["g"] = 51;
                ["infested"] = {
                    [3] = true;
                };
            };
            [3] = {
                ["sublevel"] = 1;
                ["x"] = 535.03567479994;
                ["faction"] = 2;
                ["y"] = -118.77616417887;
                ["g"] = 52;
                ["infested"] = {
                    [2] = true;
                };
            };
            [4] = {
                ["sublevel"] = 1;
                ["x"] = 519.8173194764;
                ["faction"] = 2;
                ["g"] = 55;
                ["y"] = -128.73495120029;
            };
            [5] = {
                ["sublevel"] = 1;
                ["x"] = 516.05231481307;
                ["faction"] = 2;
                ["g"] = 55;
                ["y"] = -124.48837059538;
            };
            [6] = {
                ["sublevel"] = 1;
                ["x"] = 514.6556173333;
                ["faction"] = 2;
                ["g"] = 14;
                ["y"] = -157.25579142165;
            };
        };
        ["reaping"] = 148716;
        ["id"] = 129371;
        ["spells"] = {
            [256709] = {};
            [256866] = {};
            [277242] = {};
            [257270] = {};
        };
        ["scale"] = 0.7;
        ["health"] = 768495;
        ["count"] = 4;
        ["displayId"] = 86085;
        ["creatureType"] = "Humanoid";
        ["level"] = 120;
        ["name"] = "Riptide Shredder";
        ["characteristics"] = {
            ["Disorient"] = true;
            ["Root"] = true;
            ["Silence"] = true;
            ["Stun"] = true;
            ["Fear"] = true;
        };
    };
    [12] = {
        ["clones"] = {
            [1] = {
                ["y"] = -157.54157102797;
                ["x"] = 469.34510744504;
                ["g"] = 17;
                ["sublevel"] = 1;
            };
            [2] = {
                ["sublevel"] = 2;
                ["x"] = 601.25835863159;
                ["faction"] = 2;
                ["g"] = 49;
                ["y"] = -81.41203802658;
            };
            [3] = {
                ["sublevel"] = 2;
                ["x"] = 605.44071825455;
                ["faction"] = 2;
                ["y"] = -78.881963201472;
                ["g"] = 49;
                ["infested"] = {
                    [2] = true;
                };
            };
            [4] = {
                ["sublevel"] = 1;
                ["x"] = 537.00937367395;
                ["faction"] = 2;
                ["g"] = 52;
                ["y"] = -123.7761565288;
            };
            [5] = {
                ["sublevel"] = 1;
                ["x"] = 518.82062416232;
                ["faction"] = 2;
                ["g"] = 53;
                ["y"] = -98.008462251592;
            };
            [6] = {
                ["sublevel"] = 1;
                ["x"] = 513.01662807308;
                ["faction"] = 2;
                ["g"] = 53;
                ["y"] = -96.003117622003;
            };
            [7] = {
                ["sublevel"] = 1;
                ["x"] = 521.29167449675;
                ["faction"] = 2;
                ["g"] = 55;
                ["y"] = -123.9390118827;
            };
            [8] = {
                ["sublevel"] = 1;
                ["x"] = 494.84812645343;
                ["faction"] = 2;
                ["y"] = -138.06983172419;
                ["g"] = 13;
                ["infested"] = {
                    [2] = true;
                };
            };
            [9] = {
                ["y"] = -101.7233227299;
                ["x"] = 621.1124097053;
                ["patrol"] = {
                    [1] = {
                        ["y"] = -101.7233227299;
                        ["x"] = 621.1124097053;
                    };
                    [2] = {
                        ["y"] = -105.22847445126;
                        ["x"] = 623.99900107652;
                    };
                    [3] = {
                        ["y"] = -106.15631718858;
                        ["x"] = 628.94743963497;
                    };
                    [4] = {
                        ["y"] = -105.84703922565;
                        ["x"] = 624.51446287333;
                    };
                    [5] = {
                        ["y"] = -101.7233227299;
                        ["x"] = 620.90622144717;
                    };
                    [6] = {
                        ["y"] = -96.671785618132;
                        ["x"] = 617.09179176288;
                    };
                    [7] = {
                        ["y"] = -93.888270678931;
                        ["x"] = 612.24642963646;
                    };
                    [8] = {
                        ["y"] = -94.919198696802;
                        ["x"] = 605.33922032282;
                    };
                    [9] = {
                        ["y"] = -102.34187865577;
                        ["x"] = 603.99899664497;
                    };
                    [10] = {
                        ["y"] = -103.57899050751;
                        ["x"] = 599.46292575426;
                    };
                    [11] = {
                        ["y"] = -102.1356948219;
                        ["x"] = 603.89591136442;
                    };
                    [12] = {
                        ["y"] = -94.816108991998;
                        ["x"] = 605.44231445188;
                    };
                    [13] = {
                        ["y"] = -93.063535343451;
                        ["x"] = 613.27735323007;
                    };
                    [14] = {
                        ["y"] = -96.87796060348;
                        ["x"] = 617.09179176288;
                    };
                };
                ["faction"] = 2;
                ["sublevel"] = 2;
                ["g"] = 67;
                ["infested"] = {
                    [2] = true;
                };
            };
            [10] = {
                ["sublevel"] = 2;
                ["x"] = 624.10209520559;
                ["faction"] = 2;
                ["g"] = 67;
                ["y"] = -97.702713636003;
            };
        };
        ["reaping"] = 148893;
        ["id"] = 129372;
        ["spells"] = {
            [277564] = {};
            [256660] = {};
            [256640] = {};
            [256673] = {};
            [256639] = {};
        };
        ["scale"] = 0.7;
        ["health"] = 503570;
        ["count"] = 4;
        ["displayId"] = 84136;
        ["creatureType"] = "Humanoid";
        ["level"] = 120;
        ["name"] = "Blacktar Bomber";
        ["characteristics"] = {
            ["Taunt"] = true;
            ["Disorient"] = true;
            ["Stun"] = true;
            ["Incapacitate"] = true;
            ["Silence"] = true;
            ["Fear"] = true;
        };
    };
    [13] = {
        ["clones"] = {
            [1] = {
                ["y"] = -167.80107108496;
                ["x"] = 468.33596087699;
                ["g"] = 17;
                ["sublevel"] = 1;
            };
            [2] = {
                ["y"] = -170.28785747658;
                ["x"] = 458.70672577275;
                ["g"] = 18;
                ["sublevel"] = 1;
            };
            [3] = {
                ["y"] = -199.99033346525;
                ["x"] = 491.4545635217;
                ["sublevel"] = 1;
                ["infested"] = {
                    [3] = true;
                };
            };
            [4] = {
                ["sublevel"] = 2;
                ["x"] = 620.53354910339;
                ["patrol"] = {
                    [1] = {
                        ["y"] = -84.116425391151;
                        ["x"] = 620.53354910339;
                    };
                    [2] = {
                        ["y"] = -82.051306898429;
                        ["x"] = 607.64378304779;
                    };
                    [3] = {
                        ["y"] = -84.139227423379;
                        ["x"] = 620.17124960584;
                    };
                    [4] = {
                        ["y"] = -90.293069155625;
                        ["x"] = 628.6327949566;
                    };
                };
                ["faction"] = 2;
                ["y"] = -84.116425391151;
                ["infested"] = {
                    [3] = true;
                };
            };
            [5] = {
                ["y"] = -87.414128133822;
                ["x"] = 569.86996550556;
                ["patrol"] = {
                    [1] = {
                        ["y"] = -87.414128133822;
                        ["x"] = 569.86996550556;
                    };
                    [2] = {
                        ["y"] = -89.63270258664;
                        ["x"] = 579.33438848966;
                    };
                    [3] = {
                        ["y"] = -87.173688751619;
                        ["x"] = 569.17045994803;
                    };
                    [4] = {
                        ["y"] = -86.517942348544;
                        ["x"] = 561.79341140767;
                    };
                    [5] = {
                        ["y"] = -82.747449777977;
                        ["x"] = 561.13766500459;
                    };
                    [6] = {
                        ["y"] = -86.517942348544;
                        ["x"] = 561.79341140767;
                    };
                    [7] = {
                        ["y"] = -87.337625352388;
                        ["x"] = 569.49834722018;
                    };
                };
                ["faction"] = 2;
                ["sublevel"] = 2;
                ["infested"] = {
                    [3] = true;
                };
            };
            [6] = {
                ["sublevel"] = 1;
                ["x"] = 491.21178203991;
                ["faction"] = 2;
                ["y"] = -135.1607642719;
                ["g"] = 13;
                ["infested"] = {};
            };
            [7] = {
                ["y"] = -86.343198168183;
                ["x"] = 597.70059471696;
                ["patrol"] = {
                    [1] = {
                        ["y"] = -86.343198168183;
                        ["x"] = 597.70059471696;
                    };
                    [2] = {
                        ["y"] = -82.408769304402;
                        ["x"] = 607.53664928816;
                    };
                    [3] = {
                        ["y"] = -86.015317956974;
                        ["x"] = 597.70059471696;
                    };
                    [4] = {
                        ["y"] = -94.539922036352;
                        ["x"] = 591.96288449159;
                    };
                };
                ["faction"] = 2;
                ["teeming"] = true;
                ["sublevel"] = 2;
            };
        };
        ["reaping"] = 148894;
        ["id"] = 129369;
        ["spells"] = {
            [275775] = {};
            [272662] = {};
            [257170] = {};
            [209859] = {};
            [277564] = {};
        };
        ["scale"] = 0.7;
        ["health"] = 1229592;
        ["count"] = 8;
        ["displayId"] = 84134;
        ["creatureType"] = "Humanoid";
        ["level"] = 121;
        ["name"] = "Irontide Raider";
        ["characteristics"] = {
            ["Taunt"] = true;
        };
    };
    [14] = {
        ["clones"] = {
            [1] = {
                ["y"] = -167.89184884854;
                ["x"] = 462.86486974263;
                ["g"] = 18;
                ["sublevel"] = 1;
            };
            [2] = {
                ["y"] = -163.16658307654;
                ["x"] = 459.45828838408;
                ["g"] = 18;
                ["sublevel"] = 1;
            };
            [3] = {
                ["y"] = -166.02372556507;
                ["x"] = 452.75497948599;
                ["g"] = 18;
                ["sublevel"] = 1;
            };
            [4] = {
                ["y"] = -170.96877914661;
                ["x"] = 454.07366861541;
                ["g"] = 18;
                ["sublevel"] = 1;
            };
            [5] = {
                ["y"] = -192.00199282486;
                ["x"] = 473.5233553089;
                ["g"] = 19;
                ["sublevel"] = 1;
            };
            [6] = {
                ["y"] = -181.97309174938;
                ["x"] = 480.22183192311;
                ["g"] = 20;
                ["sublevel"] = 1;
            };
            [7] = {
                ["sublevel"] = 1;
                ["x"] = 483.53047972331;
                ["infested"] = {
                    [1] = true;
                };
                ["g"] = 20;
                ["y"] = -180.78612370641;
            };
            [8] = {
                ["y"] = -182.40350109144;
                ["x"] = 487.30441540797;
                ["g"] = 20;
                ["sublevel"] = 1;
            };
            [9] = {
                ["y"] = -185.58175782923;
                ["x"] = 479.1174607118;
                ["g"] = 20;
                ["sublevel"] = 1;
            };
            [10] = {
                ["sublevel"] = 1;
                ["x"] = 515.78610180136;
                ["infested"] = {
                    [1] = true;
                };
                ["g"] = 24;
                ["y"] = -260.75901813759;
            };
            [11] = {
                ["y"] = -270.56657035096;
                ["x"] = 519.28350922565;
                ["g"] = 24;
                ["sublevel"] = 1;
            };
            [12] = {
                ["y"] = -322.28836371105;
                ["x"] = 519.1309083453;
                ["g"] = 33;
                ["sublevel"] = 1;
            };
            [13] = {
                ["y"] = -313.2846105706;
                ["x"] = 515.44946891385;
                ["g"] = 33;
                ["sublevel"] = 1;
            };
            [14] = {
                ["y"] = -250.65116619044;
                ["x"] = 532.27750301453;
                ["faction"] = 2;
                ["g"] = 69;
                ["sublevel"] = 1;
            };
            [15] = {
                ["y"] = -256.25554547281;
                ["x"] = 533.37640905039;
                ["faction"] = 2;
                ["g"] = 69;
                ["sublevel"] = 1;
            };
            [16] = {
                ["y"] = -262.18961825941;
                ["x"] = 534.36541410753;
                ["faction"] = 2;
                ["g"] = 69;
                ["sublevel"] = 1;
            };
            [17] = {
                ["y"] = -254.82698366049;
                ["x"] = 540.84893048012;
                ["faction"] = 2;
                ["g"] = 69;
                ["sublevel"] = 1;
            };
            [18] = {
                ["y"] = -248.3434672879;
                ["x"] = 544.36542224934;
                ["faction"] = 2;
                ["g"] = 69;
                ["sublevel"] = 1;
            };
            [19] = {
                ["y"] = -253.17862460669;
                ["x"] = 546.67311643591;
                ["faction"] = 2;
                ["g"] = 69;
                ["sublevel"] = 1;
            };
            [20] = {
                ["y"] = -259.44236260169;
                ["x"] = 546.34344179557;
                ["faction"] = 2;
                ["g"] = 69;
                ["sublevel"] = 1;
            };
            [21] = {
                ["y"] = -280.19050238962;
                ["x"] = 513.20142929376;
                ["faction"] = 2;
                ["g"] = 26;
                ["sublevel"] = 1;
            };
            [22] = {
                ["y"] = -286.86374235242;
                ["x"] = 519.97006938083;
                ["faction"] = 2;
                ["g"] = 26;
                ["sublevel"] = 1;
            };
            [23] = {
                ["y"] = -310.36589122076;
                ["x"] = 522.22719227815;
                ["faction"] = 2;
                ["g"] = 71;
                ["sublevel"] = 1;
            };
            [24] = {
                ["y"] = -305.2010639776;
                ["x"] = 527.39202895326;
                ["faction"] = 2;
                ["g"] = 71;
                ["sublevel"] = 1;
            };
            [25] = {
                ["y"] = -310.47578748351;
                ["x"] = 536.51290472081;
                ["faction"] = 2;
                ["g"] = 71;
                ["sublevel"] = 1;
            };
            [26] = {
                ["y"] = -303.66259647058;
                ["x"] = 537.94146653314;
                ["faction"] = 2;
                ["g"] = 71;
                ["sublevel"] = 1;
            };
            [27] = {
                ["y"] = -300.58567088849;
                ["x"] = 551.67773067384;
                ["faction"] = 2;
                ["g"] = 71;
                ["sublevel"] = 1;
            };
            [28] = {
                ["y"] = -292.6735879876;
                ["x"] = 562.11729557082;
                ["faction"] = 2;
                ["g"] = 71;
                ["sublevel"] = 1;
            };
        };
        ["reaping"] = 148716;
        ["id"] = 135258;
        ["spells"] = {
            [277564] = {};
            [209859] = {};
            [257168] = {};
            [277242] = {};
        };
        ["scale"] = 0.5;
        ["health"] = 153699;
        ["count"] = 1;
        ["displayId"] = 79068;
        ["creatureType"] = "Humanoid";
        ["level"] = 120;
        ["name"] = "Irontide Marauder";
        ["characteristics"] = {
            ["Taunt"] = true;
            ["Disorient"] = true;
            ["Sap"] = true;
            ["Root"] = true;
            ["Slow"] = true;
            ["Silence"] = true;
            ["Stun"] = true;
        };
    };
    [15] = {
        ["clones"] = {
            [1] = {
                ["y"] = -188.50199940652;
                ["x"] = 471.52332841602;
                ["g"] = 19;
                ["sublevel"] = 1;
            };
            [2] = {
                ["sublevel"] = 1;
                ["x"] = 519.95185520218;
                ["y"] = -263.30361658651;
                ["g"] = 24;
                ["infested"] = {
                    [2] = true;
                };
            };
            [3] = {
                ["y"] = -315.91619008166;
                ["x"] = 511.89682471573;
                ["g"] = 33;
                ["sublevel"] = 1;
            };
            [4] = {
                ["sublevel"] = 2;
                ["x"] = 617.93414560563;
                ["faction"] = 2;
                ["g"] = 48;
                ["y"] = -77.353710214649;
            };
            [5] = {
                ["sublevel"] = 1;
                ["x"] = 576.44349772987;
                ["faction"] = 2;
                ["y"] = -103.73821922814;
                ["g"] = 2;
                ["infested"] = {
                    [2] = true;
                };
            };
            [6] = {
                ["sublevel"] = 2;
                ["x"] = 595.45836111139;
                ["faction"] = 2;
                ["y"] = -103.06566560425;
                ["g"] = 64;
                ["infested"] = {
                    [2] = true;
                };
            };
            [7] = {
                ["sublevel"] = 2;
                ["x"] = 600.98309032554;
                ["faction"] = 2;
                ["g"] = 65;
                ["y"] = -90.686818211602;
            };
        };
        ["reaping"] = 148893;
        ["id"] = 129370;
        ["spells"] = {
            [257063] = {};
            [277242] = {};
            [209859] = {};
            [257069] = {};
            [256957] = {};
            [277564] = {};
        };
        ["scale"] = 0.7;
        ["health"] = 614795;
        ["count"] = 4;
        ["displayId"] = 79077;
        ["creatureType"] = "Humanoid";
        ["level"] = 120;
        ["name"] = "Irontide Waveshaper";
        ["characteristics"] = {
            ["Taunt"] = true;
            ["Incapacitate"] = true;
            ["Silence"] = true;
            ["Root"] = true;
            ["Slow"] = true;
            ["Stun"] = true;
            ["Disorient"] = true;
        };
    };
    [16] = {
        ["clones"] = {
            [1] = {
                ["y"] = -206.5357810425;
                ["x"] = 484.90910033886;
                ["patrol"] = {
                    [1] = {
                        ["y"] = -206.5357810425;
                        ["x"] = 484.90910033886;
                    };
                    [2] = {
                        ["y"] = -216.35396801396;
                        ["x"] = 482.1818383178;
                    };
                    [3] = {
                        ["y"] = -206.5357810425;
                        ["x"] = 484.90910033886;
                    };
                    [4] = {
                        ["y"] = -195.80850673069;
                        ["x"] = 487.63639357109;
                    };
                    [5] = {
                        ["y"] = -184.53579405968;
                        ["x"] = 483.27274624734;
                    };
                    [6] = {
                        ["y"] = -195.80850673069;
                        ["x"] = 487.63639357109;
                    };
                };
                ["sublevel"] = 1;
                ["g"] = 22;
                ["infested"] = {};
            };
            [2] = {
                ["y"] = -320.12672068742;
                ["x"] = 510.97576002868;
                ["g"] = 33;
                ["sublevel"] = 1;
            };
            [3] = {
                ["sublevel"] = 1;
                ["x"] = 393.59753324218;
                ["infested"] = {};
                ["g"] = 43;
                ["y"] = -420.82814705587;
            };
            [4] = {
                ["y"] = -440.25697538332;
                ["x"] = 415.03165322869;
                ["g"] = 44;
                ["sublevel"] = 1;
            };
            [5] = {
                ["y"] = -351.35677964077;
                ["x"] = 438.5879804993;
                ["patrol"] = {
                    [1] = {
                        ["y"] = -351.35677964077;
                        ["x"] = 438.5879804993;
                    };
                    [2] = {
                        ["y"] = -356.75260411944;
                        ["x"] = 432.00416104678;
                    };
                    [3] = {
                        ["y"] = -364.32436306244;
                        ["x"] = 429.52889045506;
                    };
                    [4] = {
                        ["y"] = -373.09147778937;
                        ["x"] = 429.66587855166;
                    };
                    [5] = {
                        ["y"] = -377.61203206765;
                        ["x"] = 436.24122488478;
                    };
                    [6] = {
                        ["y"] = -368.8449114619;
                        ["x"] = 441.99464263833;
                    };
                    [7] = {
                        ["y"] = -359.5298443486;
                        ["x"] = 447.6110722953;
                    };
                    [8] = {
                        ["y"] = -351.85861087917;
                        ["x"] = 450.76176324408;
                    };
                    [9] = {
                        ["y"] = -346.51615741539;
                        ["x"] = 446.10422674802;
                    };
                    [10] = {
                        ["y"] = -351.03669405723;
                        ["x"] = 438.56997549637;
                    };
                };
                ["teeming"] = true;
                ["g"] = 46;
                ["sublevel"] = 1;
            };
            [6] = {
                ["y"] = -353.68238246198;
                ["x"] = 442.30890109985;
                ["patrol"] = {};
                ["teeming"] = true;
                ["g"] = 46;
                ["sublevel"] = 1;
            };
        };
        ["reaping"] = 148894;
        ["id"] = 128969;
        ["spells"] = {
            [277564] = {};
            [209859] = {};
            [275826] = {};
            [272874] = {};
        };
        ["scale"] = 0.8;
        ["health"] = 1229592;
        ["count"] = 8;
        ["displayId"] = 84067;
        ["creatureType"] = "Humanoid";
        ["level"] = 121;
        ["name"] = "Ashvane Commander";
        ["characteristics"] = {
            ["Taunt"] = true;
        };
    };
    [17] = {
        ["clones"] = {
            [1] = {
                ["sublevel"] = 1;
                ["x"] = 486.3242648423;
                ["y"] = -218.3276374044;
                ["g"] = 21;
                ["infested"] = {
                    [2] = true;
                };
            };
            [2] = {
                ["sublevel"] = 1;
                ["x"] = 489.4545682518;
                ["y"] = -207.44487618564;
                ["g"] = 22;
                ["infested"] = {
                    [2] = true;
                };
            };
            [3] = {
                ["y"] = -205.26305252377;
                ["x"] = 479.27275570754;
                ["g"] = 22;
                ["sublevel"] = 1;
            };
            [4] = {
                ["y"] = -267.32735182055;
                ["x"] = 521.17080335879;
                ["g"] = 24;
                ["sublevel"] = 1;
            };
            [5] = {
                ["sublevel"] = 1;
                ["x"] = 514.65999618989;
                ["y"] = -322.49513885932;
                ["g"] = 33;
                ["infested"] = {
                    [2] = true;
                };
            };
            [6] = {
                ["sublevel"] = 1;
                ["x"] = 554.37361696464;
                ["faction"] = 2;
                ["y"] = -88.242497399788;
                ["g"] = 3;
                ["infested"] = {
                    [2] = true;
                    [3] = true;
                };
            };
            [7] = {
                ["sublevel"] = 1;
                ["x"] = 553.50087563308;
                ["faction"] = 2;
                ["g"] = 3;
                ["y"] = -95.415274161499;
            };
        };
        ["reaping"] = 148716;
        ["id"] = 137521;
        ["spells"] = {
            [257641] = {};
            [209859] = {};
            [277242] = {};
            [277564] = {};
        };
        ["scale"] = 0.7;
        ["health"] = 153699;
        ["count"] = 4;
        ["displayId"] = 85144;
        ["creatureType"] = "Humanoid";
        ["level"] = 120;
        ["name"] = "Irontide Powdershot";
        ["characteristics"] = {
            ["Taunt"] = true;
            ["Incapacitate"] = true;
            ["Root"] = true;
            ["Polymorph"] = true;
            ["Disorient"] = true;
            ["Imprison"] = true;
            ["Silence"] = true;
            ["Slow"] = true;
            ["Stun"] = true;
            ["Fear"] = true;
        };
    };
    [18] = {
        ["clones"] = {
            [1] = {
                ["sublevel"] = 1;
                ["x"] = 497.45243530088;
                ["infested"] = {
                    [3] = true;
                };
                ["g"] = 23;
                ["y"] = -258.92156377672;
            };
            [2] = {
                ["y"] = -341.18087391862;
                ["x"] = 458.88216893754;
                ["g"] = 34;
                ["sublevel"] = 1;
            };
            [3] = {
                ["y"] = -419.76937675037;
                ["x"] = 432.90654005456;
                ["g"] = 41;
                ["sublevel"] = 1;
            };
            [4] = {
                ["y"] = -309.83593075367;
                ["x"] = 512.58587693016;
                ["teeming"] = true;
                ["g"] = 33;
                ["sublevel"] = 1;
            };
        };
        ["reaping"] = 148894;
        ["id"] = 138255;
        ["spells"] = {
            [272471] = {};
            [272421] = {};
            [209859] = {};
            [272418] = {};
            [272422] = {};
        };
        ["scale"] = 0.7;
        ["name"] = "Ashvane Spotter";
        ["health"] = 768495;
        ["displayId"] = 86436;
        ["creatureType"] = "Humanoid";
        ["level"] = 121;
        ["count"] = 4;
        ["characteristics"] = {
            ["Root"] = true;
            ["Slow"] = true;
            ["Taunt"] = true;
        };
    };
    [19] = {
        ["clones"] = {
            [1] = {
                ["sublevel"] = 1;
                ["x"] = 529.5126770395;
                ["faction"] = 1;
                ["g"] = 25;
                ["y"] = -250.43142788804;
            };
            [2] = {
                ["sublevel"] = 1;
                ["x"] = 540.52533800336;
                ["faction"] = 1;
                ["g"] = 25;
                ["y"] = -247.39345151313;
            };
            [3] = {
                ["sublevel"] = 1;
                ["x"] = 546.72788555121;
                ["faction"] = 1;
                ["g"] = 25;
                ["y"] = -253.59597733169;
            };
            [4] = {
                ["sublevel"] = 1;
                ["x"] = 541.91775040591;
                ["faction"] = 1;
                ["g"] = 25;
                ["y"] = -259.41876221475;
            };
            [5] = {
                ["sublevel"] = 1;
                ["x"] = 532.03960504283;
                ["faction"] = 1;
                ["g"] = 25;
                ["y"] = -262.3175236157;
            };
            [6] = {
                ["sublevel"] = 1;
                ["x"] = 532.33370139834;
                ["faction"] = 1;
                ["g"] = 25;
                ["y"] = -254.67045037523;
            };
            [7] = {
                ["sublevel"] = 1;
                ["x"] = 538.37345459444;
                ["faction"] = 1;
                ["g"] = 25;
                ["y"] = -253.72255583275;
            };
            [8] = {
                ["sublevel"] = 1;
                ["x"] = 514.64882686269;
                ["faction"] = 1;
                ["g"] = 26;
                ["y"] = -279.45366833983;
            };
            [9] = {
                ["sublevel"] = 1;
                ["x"] = 520.19610143157;
                ["faction"] = 1;
                ["g"] = 27;
                ["y"] = -287.10623356988;
            };
            [10] = {
                ["sublevel"] = 1;
                ["x"] = 555.72299209389;
                ["faction"] = 1;
                ["g"] = 28;
                ["y"] = -292.19452906667;
            };
            [11] = {
                ["sublevel"] = 1;
                ["x"] = 546.10276526187;
                ["faction"] = 1;
                ["g"] = 29;
                ["y"] = -300.295797589;
            };
            [12] = {
                ["sublevel"] = 1;
                ["x"] = 536.34527281636;
                ["faction"] = 1;
                ["g"] = 30;
                ["y"] = -304.20748815733;
            };
            [13] = {
                ["sublevel"] = 1;
                ["x"] = 527.67608951888;
                ["faction"] = 1;
                ["g"] = 31;
                ["y"] = -303.16501314177;
            };
            [14] = {
                ["sublevel"] = 1;
                ["x"] = 531.79896548866;
                ["faction"] = 1;
                ["g"] = 31;
                ["y"] = -312.70085465845;
            };
            [15] = {
                ["sublevel"] = 1;
                ["x"] = 520.58250449269;
                ["faction"] = 1;
                ["g"] = 32;
                ["y"] = -304.72909004106;
            };
        };
        ["reaping"] = 148716;
        ["scale"] = 0.5;
        ["spells"] = {
            [277564] = {};
            [209859] = {};
            [273930] = {};
        };
        ["id"] = 141565;
        ["health"] = 58864;
        ["count"] = 1;
        ["displayId"] = 86025;
        ["creatureType"] = "Humanoid";
        ["level"] = 120;
        ["name"] = "Kul Tiran Footman";
        ["characteristics"] = {
            ["Taunt"] = true;
            ["Silence"] = true;
            ["Stun"] = true;
            ["Slow"] = true;
            ["Root"] = true;
            ["Fear"] = true;
        };
    };
    [20] = {
        ["clones"] = {
            [1] = {
                ["y"] = -333.95126137018;
                ["x"] = 466.44485478095;
                ["g"] = 34;
                ["sublevel"] = 1;
            };
            [2] = {
                ["y"] = -330.49121809787;
                ["x"] = 462.67524850882;
                ["g"] = 34;
                ["sublevel"] = 1;
            };
            [3] = {
                ["y"] = -345.51457872792;
                ["x"] = 463.19588800752;
                ["g"] = 34;
                ["sublevel"] = 1;
            };
        };
        ["reaping"] = 148716;
        ["scale"] = 0.7;
        ["spells"] = {
            [268230] = {};
            [209859] = {};
        };
        ["id"] = 138464;
        ["count"] = 4;
        ["name"] = "Ashvane Deckhand";
        ["displayId"] = 84385;
        ["creatureType"] = "Humanoid";
        ["level"] = 120;
        ["health"] = 768495;
        ["characteristics"] = {
            ["Disorient"] = true;
            ["Root"] = true;
            ["Slow"] = true;
            ["Stun"] = true;
            ["Fear"] = true;
        };
    };
    [21] = {
        ["clones"] = {
            [1] = {
                ["sublevel"] = 1;
                ["x"] = 458.88216893754;
                ["infested"] = {
                    [3] = true;
                };
                ["g"] = 34;
                ["y"] = -336.35329052182;
            };
        };
        ["reaping"] = 148894;
        ["scale"] = 0.7;
        ["spells"] = {
            [209859] = {};
            [281388] = {};
            [268260] = {};
        };
        ["id"] = 138465;
        ["count"] = 4;
        ["name"] = "Ashvane Cannoneer";
        ["displayId"] = 88542;
        ["creatureType"] = "Humanoid";
        ["level"] = 120;
        ["health"] = 768495;
        ["characteristics"] = {
            ["Taunt"] = true;
        };
    };
    [22] = {
        ["clones"] = {
            [1] = {
                ["y"] = -332.71826679518;
                ["x"] = 445.55283973782;
                ["sublevel"] = 1;
            };
        };
        ["id"] = 129208;
        ["characteristics"] = {
            ["Root"] = true;
            ["Slow"] = true;
            ["Taunt"] = true;
        };
        ["spells"] = {
            [269029] = {};
            [272471] = {};
            [280389] = {};
            [273470] = {};
        };
        ["isBoss"] = true;
        ["encounterID"] = 2173;
        ["instanceID"] = 1023;
        ["name"] = "Dread Captain Lockwood";
        ["count"] = 0;
        ["displayId"] = 88579;
        ["creatureType"] = "Humanoid";
        ["level"] = 122;
        ["health"] = 3765626;
        ["scale"] = 0.8;
    };
    [23] = {
        ["clones"] = {
            [1] = {
                ["y"] = -401.83147783664;
                ["x"] = 449.06690463034;
                ["g"] = 35;
                ["sublevel"] = 1;
            };
            [2] = {
                ["y"] = -392.01832356905;
                ["x"] = 455.50646053809;
                ["sublevel"] = 1;
            };
            [3] = {
                ["sublevel"] = 1;
                ["x"] = 462.76218444173;
                ["infested"] = {
                    [1] = true;
                };
                ["g"] = 36;
                ["y"] = -380.26335949081;
            };
            [4] = {
                ["y"] = -375.35498047478;
                ["x"] = 453.56775616675;
                ["g"] = 36;
                ["sublevel"] = 1;
            };
            [5] = {
                ["y"] = -389.28108795245;
                ["x"] = 472.76441569494;
                ["g"] = 37;
                ["sublevel"] = 1;
            };
            [6] = {
                ["y"] = -382.68471887618;
                ["x"] = 470.47036121718;
                ["g"] = 37;
                ["sublevel"] = 1;
            };
            [7] = {
                ["sublevel"] = 1;
                ["x"] = 486.81382693685;
                ["infested"] = {};
                ["g"] = 45;
                ["y"] = -365.97079258537;
            };
            [8] = {
                ["y"] = -387.07342135317;
                ["x"] = 485.68495957621;
                ["infested"] = {
                    [1] = true;
                };
                ["sublevel"] = 1;
            };
            [9] = {
                ["y"] = -388.56596547125;
                ["x"] = 492.55064458462;
                ["sublevel"] = 1;
            };
            [10] = {
                ["y"] = -394.55660128523;
                ["x"] = 489.29848245284;
                ["g"] = 38;
                ["sublevel"] = 1;
            };
            [11] = {
                ["y"] = -402.07594876398;
                ["x"] = 476.854409421;
                ["sublevel"] = 1;
                ["infested"] = {
                    [2] = true;
                };
            };
            [12] = {
                ["y"] = -425.89415861255;
                ["x"] = 457.74586747296;
                ["g"] = 39;
                ["sublevel"] = 1;
            };
            [13] = {
                ["sublevel"] = 1;
                ["x"] = 452.93573232766;
                ["infested"] = {
                    [1] = true;
                };
                ["g"] = 39;
                ["y"] = -426.27390498037;
            };
            [14] = {
                ["sublevel"] = 1;
                ["x"] = 461.40441545586;
                ["infested"] = {};
                ["g"] = 40;
                ["y"] = -402.4909626023;
            };
            [15] = {
                ["y"] = -405.54915579598;
                ["x"] = 464.00056711768;
                ["g"] = 40;
                ["sublevel"] = 1;
            };
            [16] = {
                ["y"] = -441.99181043209;
                ["x"] = 468.47871255406;
                ["g"] = 77;
                ["sublevel"] = 1;
            };
            [17] = {
                ["y"] = -441.86387356664;
                ["x"] = 461.95484919145;
                ["g"] = 77;
                ["sublevel"] = 1;
            };
        };
        ["reaping"] = 148716;
        ["scale"] = 0.7;
        ["spells"] = {
            [277242] = {};
            [274941] = {};
            [209859] = {};
            [272546] = {};
            [277564] = {};
        };
        ["id"] = 129366;
        ["health"] = 768495;
        ["count"] = 4;
        ["displayId"] = 81424;
        ["creatureType"] = "Humanoid";
        ["level"] = 120;
        ["name"] = "Bilge Rat Buccaneer";
        ["characteristics"] = {
            ["Taunt"] = true;
            ["Incapacitate"] = true;
            ["Root"] = true;
            ["Polymorph"] = true;
            ["Disorient"] = true;
            ["Sap"] = true;
            ["Fear"] = true;
            ["Silence"] = true;
            ["Slow"] = true;
            ["Stun"] = true;
            ["Imprison"] = true;
        };
    };
    [24] = {
        ["clones"] = {
            [1] = {
                ["sublevel"] = 1;
                ["x"] = 449.64388276478;
                ["patrol"] = {
                    [1] = {
                        ["y"] = -389.12817242508;
                        ["x"] = 450.55299996036;
                    };
                    [2] = {
                        ["y"] = -393.88227015803;
                        ["x"] = 444.97924039355;
                    };
                    [3] = {
                        ["y"] = -392.5707985603;
                        ["x"] = 437.76610087659;
                    };
                    [4] = {
                        ["y"] = -393.88227015803;
                        ["x"] = 444.97924039355;
                    };
                    [5] = {
                        ["y"] = -389.12817242508;
                        ["x"] = 450.55299996036;
                    };
                    [6] = {
                        ["y"] = -383.88226492827;
                        ["x"] = 455.96283700982;
                    };
                };
                ["infested"] = {
                    [3] = true;
                };
                ["y"] = -390.21910525687;
            };
            [2] = {
                ["sublevel"] = 1;
                ["x"] = 464.90977790599;
                ["patrol"] = {
                    [1] = {
                        ["y"] = -365.76373721469;
                        ["x"] = 464.90977790599;
                    };
                    [2] = {
                        ["y"] = -376.70124037245;
                        ["x"] = 459.90977914465;
                    };
                    [3] = {
                        ["y"] = -386.07622296254;
                        ["x"] = 477.25351604706;
                    };
                    [4] = {
                        ["y"] = -373.8887234672;
                        ["x"] = 481.78474522705;
                    };
                };
                ["infested"] = {
                    [3] = true;
                };
                ["y"] = -365.76373721469;
            };
            [3] = {
                ["y"] = -403.99158371047;
                ["x"] = 471.8639059062;
                ["patrol"] = {
                    [1] = {
                        ["y"] = -407.28829763634;
                        ["x"] = 470.43535125076;
                    };
                    [2] = {
                        ["y"] = -402.07699177342;
                        ["x"] = 474.4286536529;
                    };
                    [3] = {
                        ["y"] = -392.29438311184;
                        ["x"] = 477.90690497361;
                    };
                    [4] = {
                        ["y"] = -402.07699177342;
                        ["x"] = 474.4286536529;
                    };
                    [5] = {
                        ["y"] = -407.28829763634;
                        ["x"] = 470.43535125076;
                    };
                    [6] = {
                        ["y"] = -412.60799802554;
                        ["x"] = 460.92992483847;
                    };
                    [7] = {
                        ["y"] = -416.61778152477;
                        ["x"] = 457.70648170604;
                    };
                    [8] = {
                        ["y"] = -412.60799802554;
                        ["x"] = 460.92992483847;
                    };
                };
                ["sublevel"] = 1;
            };
        };
        ["reaping"] = 148894;
        ["scale"] = 1;
        ["spells"] = {
            [277564] = {};
            [257169] = {};
            [209859] = {};
            [272713] = {};
        };
        ["id"] = 135245;
        ["health"] = 1536990;
        ["count"] = 8;
        ["displayId"] = 68059;
        ["creatureType"] = "Humanoid";
        ["level"] = 121;
        ["name"] = "Bilge Rat Demolisher";
        ["characteristics"] = {
            ["Taunt"] = true;
        };
    };
    [25] = {
        ["clones"] = {
            [1] = {
                ["sublevel"] = 1;
                ["x"] = 444.14381531771;
                ["y"] = -400.01828896058;
                ["g"] = 35;
                ["infested"] = {
                    [2] = true;
                };
            };
            [2] = {
                ["sublevel"] = 1;
                ["x"] = 476.60607351867;
                ["y"] = -384.17725658898;
                ["g"] = 37;
                ["infested"] = {
                    [2] = true;
                };
            };
            [3] = {
                ["sublevel"] = 1;
                ["x"] = 484.99568346729;
                ["y"] = -369.78897033877;
                ["g"] = 45;
                ["infested"] = {
                    [1] = true;
                    [2] = true;
                    [3] = true;
                };
            };
            [4] = {
                ["sublevel"] = 1;
                ["x"] = 456.37530835401;
                ["y"] = -421.65313166251;
                ["g"] = 39;
                ["infested"] = {
                    [2] = true;
                };
            };
            [5] = {
                ["y"] = -436.87504947154;
                ["x"] = 465.15282616421;
                ["g"] = 77;
                ["sublevel"] = 1;
            };
        };
        ["reaping"] = 148716;
        ["scale"] = 0.7;
        ["spells"] = {
            [277242] = {};
            [272834] = {};
            [209859] = {};
            [272827] = {};
            [277564] = {};
        };
        ["id"] = 135241;
        ["health"] = 768495;
        ["count"] = 4;
        ["displayId"] = 52277;
        ["creatureType"] = "Humanoid";
        ["level"] = 120;
        ["name"] = "Bilge Rat Pillager";
        ["characteristics"] = {
            ["Taunt"] = true;
            ["Incapacitate"] = true;
            ["Root"] = true;
            ["Polymorph"] = true;
            ["Mind Control"] = true;
            ["Sap"] = true;
            ["Fear"] = true;
            ["Stun"] = true;
            ["Slow"] = true;
            ["Disorient"] = true;
            ["Imprison"] = true;
        };
    };
    [26] = {
        ["clones"] = {
            [1] = {
                ["y"] = -374.60051258322;
                ["x"] = 460.09402520125;
                ["g"] = 36;
                ["sublevel"] = 1;
            };
            [2] = {
                ["y"] = -397.34140436105;
                ["x"] = 487.90605918564;
                ["g"] = 38;
                ["sublevel"] = 1;
            };
            [3] = {
                ["y"] = -404.26515494169;
                ["x"] = 456.72700463708;
                ["g"] = 40;
                ["sublevel"] = 1;
            };
        };
        ["reaping"] = 148893;
        ["scale"] = 0.7;
        ["spells"] = {
            [272571] = {};
            [277564] = {};
            [209859] = {};
            [274569] = {};
            [272581] = {};
            [277242] = {};
        };
        ["id"] = 129367;
        ["health"] = 614795;
        ["count"] = 4;
        ["displayId"] = 80475;
        ["creatureType"] = "Humanoid";
        ["level"] = 120;
        ["name"] = "Bilge Rat Tempest";
        ["characteristics"] = {
            ["Taunt"] = true;
            ["Incapacitate"] = true;
            ["Disorient"] = true;
            ["Root"] = true;
            ["Silence"] = true;
            ["Slow"] = true;
            ["Stun"] = true;
            ["Fear"] = true;
        };
    };
    [27] = {
        ["clones"] = {
            [1] = {
                ["y"] = -399.18450962432;
                ["x"] = 466.48506423415;
                ["g"] = 40;
                ["sublevel"] = 1;
            };
            [2] = {
                ["sublevel"] = 1;
                ["x"] = 460.11408997895;
                ["infested"] = {
                    [1] = true;
                };
                ["g"] = 40;
                ["y"] = -408.78128372814;
            };
        };
        ["reaping"] = 148716;
        ["scale"] = 0.7;
        ["spells"] = {
            [277564] = {};
            [209859] = {};
            [277242] = {};
            [272588] = {};
        };
        ["id"] = 137511;
        ["name"] = "Bilge Rat Cutthroat";
        ["health"] = 614796;
        ["displayId"] = 80319;
        ["creatureType"] = "Humanoid";
        ["level"] = 120;
        ["count"] = 4;
        ["characteristics"] = {
            ["Taunt"] = true;
            ["Incapacitate"] = true;
            ["Root"] = true;
            ["Polymorph"] = true;
            ["Disorient"] = true;
            ["Sap"] = true;
            ["Stun"] = true;
            ["Slow"] = true;
            ["Silence"] = true;
            ["Fear"] = true;
        };
    };
    [28] = {
        ["clones"] = {
            [1] = {
                ["y"] = -413.16388070323;
                ["x"] = 432.44783423805;
                ["g"] = 41;
                ["sublevel"] = 1;
            };
            [2] = {
                ["y"] = -416.4666287268;
                ["x"] = 437.76893352561;
                ["g"] = 41;
                ["sublevel"] = 1;
            };
            [3] = {
                ["y"] = -421.78772407717;
                ["x"] = 437.86066996429;
                ["g"] = 41;
                ["sublevel"] = 1;
            };
            [4] = {
                ["y"] = -425.27396466403;
                ["x"] = 433.27352518113;
                ["g"] = 41;
                ["sublevel"] = 1;
            };
            [5] = {
                ["sublevel"] = 1;
                ["x"] = 376.52361492942;
                ["infested"] = {
                    [1] = true;
                };
                ["g"] = 42;
                ["y"] = -440.74941557682;
            };
            [6] = {
                ["y"] = -444.21880571055;
                ["x"] = 378.76849021377;
                ["g"] = 42;
                ["sublevel"] = 1;
            };
            [7] = {
                ["y"] = -436.83537207088;
                ["x"] = 422.88587760339;
                ["g"] = 44;
                ["sublevel"] = 1;
            };
        };
        ["reaping"] = 148716;
        ["scale"] = 0.7;
        ["spells"] = {
            [277564] = {};
            [272542] = {};
            [209859] = {};
            [272528] = {};
            [277242] = {};
        };
        ["id"] = 128967;
        ["name"] = "Ashvane Sniper";
        ["health"] = 768495;
        ["displayId"] = 82843;
        ["creatureType"] = "Humanoid";
        ["level"] = 120;
        ["count"] = 4;
        ["characteristics"] = {
            ["Taunt"] = true;
            ["Incapacitate"] = true;
            ["Root"] = true;
            ["Polymorph"] = true;
            ["Disorient"] = true;
            ["Sap"] = true;
            ["Stun"] = true;
            ["Slow"] = true;
            ["Silence"] = true;
            ["Fear"] = true;
        };
    };
    [29] = {
        ["clones"] = {
            [1] = {
                ["y"] = -438.70859836629;
                ["x"] = 380.80929866607;
                ["g"] = 42;
                ["sublevel"] = 1;
            };
            [2] = {
                ["y"] = -422.40827992271;
                ["x"] = 398.22865812385;
                ["g"] = 43;
                ["sublevel"] = 1;
            };
            [3] = {
                ["sublevel"] = 1;
                ["x"] = 393.22867672236;
                ["y"] = -425.408255889;
                ["g"] = 43;
                ["infested"] = {
                    [3] = true;
                };
            };
            [4] = {
                ["y"] = -438.13970931908;
                ["x"] = 428.97285939704;
                ["g"] = 44;
                ["sublevel"] = 1;
            };
            [5] = {
                ["y"] = -443.79188404172;
                ["x"] = 426.58154178903;
                ["g"] = 44;
                ["sublevel"] = 1;
            };
        };
        ["reaping"] = 148716;
        ["scale"] = 0.7;
        ["spells"] = {
            [275836] = {};
            [209859] = {};
            [275835] = {};
            [277564] = {};
        };
        ["id"] = 137516;
        ["name"] = "Ashvane Invader";
        ["health"] = 768495;
        ["displayId"] = 79889;
        ["creatureType"] = "Humanoid";
        ["level"] = 120;
        ["count"] = 4;
        ["characteristics"] = {
            ["Taunt"] = true;
            ["Incapacitate"] = true;
            ["Disorient"] = true;
            ["Root"] = true;
            ["Stun"] = true;
            ["Slow"] = true;
            ["Silence"] = true;
            ["Fear"] = true;
        };
    };
    [30] = {
        ["clones"] = {
            [1] = {
                ["y"] = -426.15826597382;
                ["x"] = 396.97868423115;
                ["g"] = 43;
                ["sublevel"] = 1;
            };
            [2] = {
                ["sublevel"] = 1;
                ["x"] = 417.45111574567;
                ["y"] = -437.27014182419;
                ["g"] = 44;
                ["infested"] = {
                    [2] = true;
                };
            };
        };
        ["reaping"] = 148716;
        ["scale"] = 0.7;
        ["spells"] = {
            [277564] = {};
            [272888] = {};
            [277242] = {};
            [209859] = {};
        };
        ["id"] = 137517;
        ["name"] = "Ashvane Destroyer";
        ["health"] = 768495;
        ["displayId"] = 82852;
        ["creatureType"] = "Humanoid";
        ["level"] = 120;
        ["count"] = 4;
        ["characteristics"] = {
            ["Taunt"] = true;
            ["Incapacitate"] = true;
            ["Root"] = true;
            ["Polymorph"] = true;
            ["Disorient"] = true;
            ["Sap"] = true;
            ["Stun"] = true;
            ["Slow"] = true;
            ["Silence"] = true;
            ["Fear"] = true;
        };
    };
    [31] = {
        ["clones"] = {
            [1] = {
                ["y"] = -451.73365719748;
                ["x"] = 394.14927643255;
                ["patrol"] = {
                    [1] = {
                        ["y"] = -451.73365719748;
                        ["x"] = 394.14927643255;
                    };
                    [2] = {
                        ["y"] = -431.90056670682;
                        ["x"] = 384.31621286457;
                    };
                    [3] = {
                        ["y"] = -419.90056628214;
                        ["x"] = 409.31622716037;
                    };
                    [4] = {
                        ["y"] = -440.15053816504;
                        ["x"] = 420.06622150584;
                    };
                };
                ["sublevel"] = 1;
            };
        };
        ["id"] = 128651;
        ["characteristics"] = {
            ["Taunt"] = true;
        };
        ["spells"] = {
            [257882] = {};
            [261565] = {};
            [277564] = {};
            [276068] = {};
            [257883] = {};
        };
        ["isBoss"] = true;
        ["encounterID"] = 2134;
        ["instanceID"] = 1023;
        ["name"] = "Hadal Darkfathom";
        ["count"] = 0;
        ["displayId"] = 67541;
        ["creatureType"] = "Giant";
        ["level"] = 122;
        ["health"] = 5379465;
        ["scale"] = 1;
    };
    [32] = {
        ["clones"] = {
            [1] = {
                ["y"] = -522.25717126126;
                ["x"] = 433.79490519834;
                ["g"] = 78;
                ["sublevel"] = 1;
            };
        };
        ["count"] = 0;
        ["scale"] = 1;
        ["spells"] = {
            [274991] = {};
            [269456] = {};
            [275014] = {};
            [270185] = {};
            [270484] = {};
            [277535] = {};
            [270187] = {};
            [269484] = {};
        };
        ["isBoss"] = true;
        ["encounterID"] = 2140;
        ["instanceID"] = 1023;
        ["name"] = "Viq'Goth";
        ["health"] = 19212375;
        ["displayId"] = 87990;
        ["creatureType"] = "Aberration";
        ["level"] = 122;
        ["id"] = 128652;
        ["characteristics"] = {
            ["Taunt"] = true;
        };
    };
    [33] = {
        ["clones"] = {
            [1] = {
                ["sublevel"] = 1;
                ["x"] = 489.87954568438;
                ["faction"] = 1;
                ["y"] = -134.28998585695;
                ["g"] = 13;
                ["infested"] = {
                    [2] = true;
                };
            };
        };
        ["reaping"] = 148894;
        ["id"] = 138019;
        ["spells"] = {
            [257292] = {};
            [277242] = {};
            [209859] = {};
        };
        ["scale"] = 0.7;
        ["name"] = "Kul Tiran Vanguard";
        ["health"] = 768495;
        ["displayId"] = 84074;
        ["creatureType"] = "Humanoid";
        ["level"] = 121;
        ["count"] = 4;
        ["characteristics"] = {
            ["Polymorph"] = true;
            ["Incapacitate"] = true;
            ["Sap"] = true;
            ["Taunt"] = true;
            ["Root"] = true;
            ["Slow"] = true;
            ["Stun"] = true;
            ["Fear"] = true;
        };
    };
    [34] = {
        ["clones"] = {
            [1] = {
                ["sublevel"] = 1;
                ["x"] = 558.38864977509;
                ["faction"] = 1;
                ["g"] = 3;
                ["y"] = -95.768201384782;
            };
            [2] = {
                ["sublevel"] = 1;
                ["x"] = 559.17813379257;
                ["faction"] = 1;
                ["g"] = 3;
                ["y"] = -90.505042362655;
            };
            [3] = {
                ["sublevel"] = 1;
                ["x"] = 514.66541432983;
                ["faction"] = 1;
                ["g"] = 10;
                ["y"] = -121.54310148864;
            };
            [4] = {
                ["sublevel"] = 1;
                ["x"] = 497.27189948463;
                ["faction"] = 1;
                ["g"] = 13;
                ["y"] = -141.07537171561;
            };
            [5] = {
                ["sublevel"] = 1;
                ["x"] = 492.45176731099;
                ["faction"] = 1;
                ["g"] = 13;
                ["y"] = -140.28399456647;
            };
            [6] = {
                ["sublevel"] = 1;
                ["x"] = 488.42298758703;
                ["faction"] = 1;
                ["g"] = 13;
                ["y"] = -139.20486860802;
            };
            [7] = {
                ["sublevel"] = 1;
                ["x"] = 484.53809461745;
                ["faction"] = 1;
                ["g"] = 13;
                ["y"] = -136.11134043785;
            };
            [8] = {
                ["sublevel"] = 1;
                ["x"] = 504.72957459924;
                ["faction"] = 1;
                ["g"] = 14;
                ["y"] = -158.8062774609;
            };
            [9] = {
                ["sublevel"] = 1;
                ["x"] = 499.7295694751;
                ["faction"] = 1;
                ["infested"] = {
                    [1] = true;
                };
                ["g"] = 14;
                ["y"] = -156.0062838611;
            };
            [10] = {
                ["sublevel"] = 1;
                ["x"] = 500.82957523727;
                ["faction"] = 1;
                ["g"] = 14;
                ["y"] = -149.20628530368;
            };
            [11] = {
                ["sublevel"] = 1;
                ["x"] = 508.32957863194;
                ["faction"] = 1;
                ["g"] = 14;
                ["y"] = -151.00629161156;
            };
        };
        ["reaping"] = 148716;
        ["id"] = 141282;
        ["spells"] = {
            [277564] = {};
            [209859] = {};
            [273930] = {};
            [277242] = {};
        };
        ["scale"] = 0.5;
        ["health"] = 153699;
        ["count"] = 1;
        ["displayId"] = 86025;
        ["creatureType"] = "Humanoid";
        ["level"] = 120;
        ["name"] = "Kul Tiran Footman";
        ["characteristics"] = {
            ["Taunt"] = true;
            ["Incapacitate"] = true;
            ["Root"] = true;
            ["Sap"] = true;
            ["Imprison"] = true;
            ["Stun"] = true;
            ["Slow"] = true;
            ["Silence"] = true;
            ["Fear"] = true;
        };
    };
    [35] = {
        ["clones"] = {
            [1] = {
                ["sublevel"] = 1;
                ["x"] = 541.54654993909;
                ["faction"] = 1;
                ["g"] = 4;
                ["y"] = -91.426095756203;
            };
            [2] = {
                ["sublevel"] = 1;
                ["x"] = 544.33859362617;
                ["faction"] = 1;
                ["g"] = 5;
                ["y"] = -100.90035371484;
            };
            [3] = {
                ["sublevel"] = 1;
                ["x"] = 539.22227842112;
                ["faction"] = 1;
                ["g"] = 6;
                ["y"] = -113.03611956006;
            };
            [4] = {
                ["sublevel"] = 1;
                ["x"] = 536.73825337468;
                ["faction"] = 1;
                ["g"] = 6;
                ["y"] = -107.25287819831;
            };
            [5] = {
                ["sublevel"] = 1;
                ["x"] = 520.36252691696;
                ["faction"] = 1;
                ["g"] = 7;
                ["y"] = -100.10166381043;
            };
            [6] = {
                ["sublevel"] = 1;
                ["x"] = 516.73635955827;
                ["faction"] = 1;
                ["g"] = 8;
                ["y"] = -112.73097762966;
            };
            [7] = {
                ["sublevel"] = 1;
                ["x"] = 523.46034058597;
                ["faction"] = 1;
                ["g"] = 9;
                ["y"] = -130.56921656564;
            };
            [8] = {
                ["sublevel"] = 1;
                ["x"] = 531.15331851052;
                ["faction"] = 1;
                ["g"] = 9;
                ["y"] = -124.44357248319;
            };
            [9] = {
                ["sublevel"] = 1;
                ["x"] = 499.66295946276;
                ["faction"] = 1;
                ["g"] = 11;
                ["y"] = -129.45167733706;
            };
            [10] = {
                ["sublevel"] = 1;
                ["x"] = 490.16460146767;
                ["faction"] = 1;
                ["g"] = 12;
                ["y"] = -127.74441934984;
            };
        };
        ["reaping"] = 148716;
        ["id"] = 141565;
        ["spells"] = {
            [277564] = {};
            [209859] = {};
            [273930] = {};
        };
        ["scale"] = 0.5;
        ["health"] = 153699;
        ["count"] = 1;
        ["displayId"] = 86025;
        ["creatureType"] = "Humanoid";
        ["level"] = 120;
        ["name"] = "Kul Tiran Footman";
        ["characteristics"] = {
            ["Taunt"] = true;
            ["Silence"] = true;
            ["Stun"] = true;
            ["Slow"] = true;
            ["Root"] = true;
            ["Fear"] = true;
        };
    };
    [36] = {
        ["clones"] = {
            [1] = {
                ["y"] = -226.03723578157;
                ["x"] = 487.3258969407;
                ["g"] = 21;
                ["sublevel"] = 1;
            };
            [2] = {
                ["y"] = -227.17150342228;
                ["x"] = 481.80956651225;
                ["g"] = 21;
                ["sublevel"] = 1;
            };
            [3] = {
                ["y"] = -222.50958185537;
                ["x"] = 478.48013735893;
                ["g"] = 21;
                ["sublevel"] = 1;
            };
            [4] = {
                ["y"] = -327.40210468126;
                ["x"] = 466.27899063328;
                ["sublevel"] = 1;
            };
            [5] = {
                ["y"] = -321.05594030226;
                ["x"] = 469.16361155582;
                ["sublevel"] = 1;
            };
            [6] = {
                ["y"] = -319.32516444756;
                ["x"] = 461.85593713013;
                ["sublevel"] = 1;
            };
            [7] = {
                ["y"] = -351.24823883418;
                ["x"] = 463.77899023532;
                ["sublevel"] = 1;
            };
            [8] = {
                ["y"] = -354.51747202835;
                ["x"] = 469.93285260498;
                ["sublevel"] = 1;
            };
        };
        ["reaping"] = 148716;
        ["scale"] = 0.5;
        ["spells"] = {
            [277564] = {};
            [209859] = {};
            [257168] = {};
        };
        ["id"] = 138247;
        ["count"] = 1;
        ["name"] = "Irontide Marauder";
        ["displayId"] = 79068;
        ["creatureType"] = "Humanoid";
        ["level"] = 120;
        ["health"] = 153699;
        ["characteristics"] = {
            ["Taunt"] = true;
            ["Disorient"] = true;
            ["Root"] = true;
            ["Silence"] = true;
            ["Slow"] = true;
            ["Stun"] = true;
            ["Fear"] = true;
        };
    };
    [37] = {
        ["clones"] = {
            [1] = {
                ["y"] = -253.9640479065;
                ["x"] = 492.46073769056;
                ["g"] = 23;
                ["sublevel"] = 1;
            };
            [2] = {
                ["y"] = -256.98790082987;
                ["x"] = 487.56622380814;
                ["g"] = 23;
                ["sublevel"] = 1;
            };
            [3] = {
                ["y"] = -251.55176166535;
                ["x"] = 497.22566225869;
                ["g"] = 23;
                ["sublevel"] = 1;
            };
            [4] = {
                ["y"] = -250.60294103648;
                ["x"] = 501.83181533151;
                ["g"] = 23;
                ["sublevel"] = 1;
            };
        };
        ["reaping"] = 148716;
        ["scale"] = 0.7;
        ["spells"] = {
            [257641] = {};
            [209859] = {};
        };
        ["id"] = 138254;
        ["count"] = 1;
        ["name"] = "Irontide Powdershot";
        ["displayId"] = 85144;
        ["creatureType"] = "Humanoid";
        ["level"] = 120;
        ["health"] = 153699;
        ["characteristics"] = {
            ["Stun"] = true;
            ["Slow"] = true;
            ["Disorient"] = true;
        };
    };
    [38] = {
        ["clones"] = {
            [1] = {
                ["y"] = -217.97632278322;
                ["x"] = 479.33270274982;
                ["g"] = 21;
                ["sublevel"] = 1;
            };
            [2] = {
                ["sublevel"] = 2;
                ["x"] = 582.83184305457;
                ["faction"] = 2;
                ["g"] = 50;
                ["y"] = -88.264351294156;
            };
            [3] = {
                ["sublevel"] = 1;
                ["x"] = 545.56199350463;
                ["faction"] = 2;
                ["g"] = 52;
                ["y"] = -118.77616417887;
            };
        };
        ["reaping"] = 148893;
        ["scale"] = 0.7;
        ["spells"] = {
            [257063] = {};
            [277564] = {};
            [209859] = {};
            [256957] = {};
            [257069] = {};
        };
        ["id"] = 144071;
        ["count"] = 4;
        ["name"] = "Irontide Waveshaper";
        ["displayId"] = 79077;
        ["creatureType"] = "Humanoid";
        ["level"] = 120;
        ["health"] = 614795;
        ["characteristics"] = {
            ["Taunt"] = true;
            ["Incapacitate"] = true;
            ["Sap"] = true;
            ["Root"] = true;
            ["Silence"] = true;
            ["Slow"] = true;
            ["Stun"] = true;
            ["Fear"] = true;
        };
    };
    [39] = {
        ["clones"] = {
            [1] = {
                ["y"] = -114.74007442758;
                ["x"] = 624.14510461474;
                ["sublevel"] = 2;
                ["faction"] = 2;
            };
            [2] = {
                ["y"] = -112.0502018098;
                ["x"] = 633.10342590036;
                ["sublevel"] = 2;
                ["faction"] = 2;
            };
            [3] = {
                ["y"] = -104.6270537696;
                ["x"] = 635.8684261482;
                ["sublevel"] = 2;
                ["faction"] = 2;
            };
            [4] = {
                ["y"] = -108.18081779719;
                ["x"] = 643.91349274231;
                ["sublevel"] = 2;
                ["faction"] = 2;
            };
            [5] = {
                ["y"] = -119.88155209792;
                ["x"] = 500.85843247669;
                ["sublevel"] = 1;
                ["faction"] = 2;
            };
            [6] = {
                ["y"] = -122.90677710877;
                ["x"] = 492.19683975771;
                ["sublevel"] = 1;
                ["faction"] = 2;
            };
            [7] = {
                ["y"] = -103.04576615629;
                ["x"] = 588.38221337161;
                ["sublevel"] = 2;
                ["faction"] = 2;
            };
            [8] = {
                ["y"] = -108.25354459495;
                ["x"] = 590.9242170708;
                ["sublevel"] = 2;
                ["faction"] = 2;
            };
        };
        ["reaping"] = 148716;
        ["id"] = 138002;
        ["count"] = 1;
        ["name"] = "Scrimshaw Gutter";
        ["displayId"] = 83892;
        ["creatureType"] = "Humanoid";
        ["level"] = 120;
        ["scale"] = 0.5;
        ["health"] = 100714;
    };
    [40] = {
        ["clones"] = {
            [1] = {
                ["y"] = -85.663335851963;
                ["x"] = 629.52555847793;
                ["faction"] = 2;
                ["g"] = 47;
                ["sublevel"] = 2;
            };
            [2] = {
                ["sublevel"] = 2;
                ["x"] = 625.42493453893;
                ["faction"] = 2;
                ["y"] = -81.779556146624;
                ["g"] = 47;
                ["infested"] = {
                    [2] = true;
                };
            };
            [3] = {
                ["sublevel"] = 2;
                ["x"] = 615.12758440249;
                ["faction"] = 2;
                ["g"] = 48;
                ["y"] = -72.572034403379;
            };
            [4] = {
                ["sublevel"] = 2;
                ["x"] = 581.02611535183;
                ["faction"] = 2;
                ["g"] = 50;
                ["y"] = -96.247365730931;
            };
            [5] = {
                ["sublevel"] = 2;
                ["x"] = 587.86302689718;
                ["faction"] = 2;
                ["g"] = 50;
                ["y"] = -88.068913172767;
            };
            [6] = {
                ["sublevel"] = 2;
                ["x"] = 590.76348531235;
                ["faction"] = 2;
                ["g"] = 50;
                ["y"] = -90.924130579403;
            };
            [7] = {
                ["sublevel"] = 2;
                ["x"] = 590.55293510429;
                ["faction"] = 2;
                ["g"] = 50;
                ["y"] = -97.69760669614;
            };
            [8] = {
                ["sublevel"] = 1;
                ["x"] = 550.71901535146;
                ["faction"] = 2;
                ["g"] = 51;
                ["y"] = -108.37487597956;
            };
            [9] = {
                ["sublevel"] = 1;
                ["x"] = 556.03570467322;
                ["faction"] = 2;
                ["g"] = 51;
                ["y"] = -116.06204085406;
            };
            [10] = {
                ["sublevel"] = 1;
                ["x"] = 540.43043741714;
                ["faction"] = 2;
                ["g"] = 52;
                ["y"] = -124.17089573892;
            };
            [11] = {
                ["sublevel"] = 1;
                ["x"] = 543.19358647764;
                ["faction"] = 2;
                ["g"] = 52;
                ["y"] = -124.17089573892;
            };
            [12] = {
                ["sublevel"] = 1;
                ["x"] = 511.8478498386;
                ["faction"] = 2;
                ["g"] = 53;
                ["y"] = -100.59627511277;
            };
            [13] = {
                ["sublevel"] = 1;
                ["x"] = 514.06483232557;
                ["faction"] = 2;
                ["g"] = 53;
                ["y"] = -102.58903540268;
            };
            [14] = {
                ["sublevel"] = 1;
                ["x"] = 487.211754679;
                ["faction"] = 2;
                ["g"] = 13;
                ["y"] = -139.34256035327;
            };
            [15] = {
                ["sublevel"] = 1;
                ["x"] = 491.39358177612;
                ["faction"] = 2;
                ["g"] = 13;
                ["y"] = -140.61528117955;
            };
            [16] = {
                ["sublevel"] = 1;
                ["x"] = 485.57538484003;
                ["faction"] = 2;
                ["g"] = 13;
                ["y"] = -134.97894386236;
            };
            [17] = {
                ["sublevel"] = 1;
                ["x"] = 496.84812189673;
                ["faction"] = 2;
                ["g"] = 13;
                ["y"] = -141.52436079593;
            };
            [18] = {
                ["sublevel"] = 1;
                ["x"] = 508.37310465286;
                ["faction"] = 2;
                ["g"] = 14;
                ["y"] = -145.24326500783;
            };
            [19] = {
                ["sublevel"] = 1;
                ["x"] = 502.30754891864;
                ["faction"] = 2;
                ["g"] = 14;
                ["y"] = -146.22685647123;
            };
            [20] = {
                ["sublevel"] = 1;
                ["x"] = 502.96326718051;
                ["faction"] = 2;
                ["g"] = 14;
                ["y"] = -154.58752461621;
            };
            [21] = {
                ["sublevel"] = 1;
                ["x"] = 509.19282986851;
                ["faction"] = 2;
                ["g"] = 14;
                ["y"] = -157.86620034917;
            };
            [22] = {
                ["sublevel"] = 1;
                ["x"] = 558.56117302015;
                ["faction"] = 2;
                ["g"] = 3;
                ["y"] = -89.738232694182;
            };
            [23] = {
                ["sublevel"] = 1;
                ["x"] = 558.5494143663;
                ["faction"] = 2;
                ["g"] = 3;
                ["y"] = -94.508809611529;
            };
            [24] = {
                ["sublevel"] = 1;
                ["x"] = 580.88168804981;
                ["faction"] = 2;
                ["g"] = 2;
                ["y"] = -101.22626502398;
            };
            [25] = {
                ["sublevel"] = 1;
                ["x"] = 581.21135325821;
                ["faction"] = 2;
                ["g"] = 2;
                ["y"] = -104.96252573884;
            };
            [26] = {
                ["sublevel"] = 1;
                ["x"] = 578.46413061228;
                ["faction"] = 2;
                ["g"] = 2;
                ["y"] = -108.69879588565;
            };
            [27] = {
                ["sublevel"] = 1;
                ["x"] = 616.04788978266;
                ["faction"] = 2;
                ["g"] = 1;
                ["y"] = -89.217330182773;
            };
            [28] = {
                ["sublevel"] = 1;
                ["x"] = 616.89598820285;
                ["faction"] = 2;
                ["g"] = 1;
                ["y"] = -93.858053345314;
            };
            [29] = {
                ["sublevel"] = 1;
                ["x"] = 615.96710806426;
                ["faction"] = 2;
                ["g"] = 1;
                ["y"] = -98.332530828922;
            };
            [30] = {
                ["sublevel"] = 2;
                ["x"] = 614.3855565192;
                ["faction"] = 2;
                ["g"] = 63;
                ["y"] = -108.03210652236;
            };
            [31] = {
                ["sublevel"] = 2;
                ["x"] = 609.38558572733;
                ["faction"] = 2;
                ["g"] = 63;
                ["y"] = -108.03211510542;
            };
            [32] = {
                ["sublevel"] = 2;
                ["x"] = 616.18556282708;
                ["faction"] = 2;
                ["g"] = 63;
                ["y"] = -104.33210976861;
            };
            [33] = {
                ["sublevel"] = 2;
                ["x"] = 614.58555054436;
                ["faction"] = 2;
                ["g"] = 63;
                ["y"] = -100.83211562309;
            };
            [34] = {
                ["sublevel"] = 2;
                ["x"] = 608.48555682419;
                ["faction"] = 2;
                ["g"] = 63;
                ["y"] = -102.0321141063;
            };
            [35] = {
                ["sublevel"] = 2;
                ["x"] = 600.01391255356;
                ["faction"] = 2;
                ["g"] = 64;
                ["y"] = -100.17678467374;
            };
            [36] = {
                ["sublevel"] = 2;
                ["x"] = 603.52167696453;
                ["faction"] = 2;
                ["g"] = 65;
                ["y"] = -87.597628085377;
            };
            [37] = {
                ["sublevel"] = 2;
                ["x"] = 606.41424102749;
                ["faction"] = 2;
                ["y"] = -86.523244614334;
                ["g"] = 65;
                ["infested"] = {
                    [3] = true;
                };
            };
            [38] = {
                ["sublevel"] = 2;
                ["x"] = 616.21534781615;
                ["faction"] = 2;
                ["g"] = 66;
                ["y"] = -87.123302211282;
            };
            [39] = {
                ["sublevel"] = 2;
                ["x"] = 618.60970268002;
                ["faction"] = 2;
                ["g"] = 66;
                ["y"] = -88.954287637858;
            };
        };
        ["reaping"] = 148716;
        ["id"] = 133990;
        ["count"] = 1;
        ["name"] = "Scrimshaw Gutter";
        ["displayId"] = 83892;
        ["creatureType"] = "Humanoid";
        ["level"] = 120;
        ["scale"] = 0.5;
        ["health"] = 100714;
    };
    [41] = {
        ["clones"] = {
            [1] = {
                ["sublevel"] = 2;
                ["x"] = 629.63617920356;
                ["faction"] = 2;
                ["g"] = 47;
                ["y"] = -80.366791089008;
            };
            [2] = {
                ["sublevel"] = 2;
                ["x"] = 612.23283393871;
                ["faction"] = 2;
                ["g"] = 48;
                ["y"] = -76.892462466845;
            };
            [3] = {
                ["sublevel"] = 2;
                ["x"] = 585.70685223225;
                ["faction"] = 2;
                ["y"] = -97.482252471429;
                ["g"] = 50;
                ["infested"] = {
                    [2] = true;
                };
            };
            [4] = {
                ["sublevel"] = 1;
                ["x"] = 540.50309457737;
                ["faction"] = 2;
                ["g"] = 52;
                ["y"] = -119.82196527918;
            };
            [5] = {
                ["y"] = -108.73730732369;
                ["x"] = 517.47542274433;
                ["sublevel"] = 1;
                ["faction"] = 2;
            };
            [6] = {
                ["sublevel"] = 1;
                ["x"] = 603.36452143634;
                ["patrol"] = {
                    [1] = {
                        ["y"] = -110.11910498962;
                        ["x"] = 603.36452143634;
                    };
                    [2] = {
                        ["y"] = -101.54767983709;
                        ["x"] = 605.2216765295;
                    };
                    [3] = {
                        ["y"] = -110.54766980994;
                        ["x"] = 602.65023856145;
                    };
                    [4] = {
                        ["y"] = -110.11910498962;
                        ["x"] = 594.79309015305;
                    };
                    [5] = {
                        ["y"] = -106.26196029906;
                        ["x"] = 583.93596347933;
                    };
                    [6] = {
                        ["y"] = -110.11910498962;
                        ["x"] = 594.65025564882;
                    };
                };
                ["faction"] = 2;
                ["y"] = -110.11910498962;
                ["infested"] = {
                    [3] = true;
                };
            };
            [7] = {
                ["sublevel"] = 1;
                ["x"] = 611.42916286483;
                ["faction"] = 2;
                ["y"] = -94.354639890186;
                ["g"] = 1;
                ["infested"] = {
                    [2] = true;
                };
            };
            [8] = {
                ["sublevel"] = 2;
                ["x"] = 612.11166982222;
                ["faction"] = 2;
                ["y"] = -104.17900417954;
                ["g"] = 63;
                ["infested"] = {};
            };
            [9] = {
                ["sublevel"] = 2;
                ["x"] = 595.56948328715;
                ["faction"] = 2;
                ["g"] = 64;
                ["y"] = -99.287883561659;
            };
            [10] = {
                ["y"] = -129.39934559535;
                ["x"] = 514.30705654956;
                ["faction"] = 2;
                ["teeming"] = true;
                ["g"] = 55;
                ["sublevel"] = 1;
            };
        };
        ["reaping"] = 148716;
        ["id"] = 129374;
        ["count"] = 4;
        ["name"] = "Scrimshaw Enforcer";
        ["displayId"] = 86006;
        ["creatureType"] = "Humanoid";
        ["level"] = 120;
        ["scale"] = 0.7;
        ["health"] = 503570;
    };
    [42] = {
        ["clones"] = {
            [1] = {
                ["sublevel"] = 1;
                ["x"] = 490.36436521224;
                ["faction"] = 2;
                ["g"] = 58;
                ["y"] = -158.47729924025;
            };
        };
        ["id"] = 128650;
        ["isBoss"] = true;
        ["encounterID"] = 2132;
        ["instanceID"] = 1023;
        ["scale"] = 0.8;
        ["count"] = 0;
        ["displayId"] = 84821;
        ["creatureType"] = "Humanoid";
        ["level"] = 122;
        ["name"] = "Chopper Redhook";
        ["health"] = 2819992;
    };
    [43] = {
        ["clones"] = {
            [1] = {
                ["sublevel"] = 1;
                ["x"] = 481.49951633274;
                ["faction"] = 2;
                ["g"] = 58;
                ["y"] = -154.63552044934;
            };
        };
        ["reaping"] = 148894;
        ["scale"] = 1;
        ["name"] = "Irontide Cleaver";
        ["health"] = 503570;
        ["displayId"] = 81286;
        ["creatureType"] = "Humanoid";
        ["level"] = 121;
        ["id"] = 129879;
        ["count"] = 0;
    };
    [44] = {
        ["clones"] = {
            [1] = {
                ["sublevel"] = 1;
                ["x"] = 495.12011392662;
                ["faction"] = 2;
                ["g"] = 58;
                ["y"] = -168.59803506526;
            };
        };
        ["reaping"] = 148716;
        ["scale"] = 1;
        ["name"] = "Irontide Powdershot";
        ["health"] = 100714;
        ["displayId"] = 85144;
        ["creatureType"] = "Humanoid";
        ["level"] = 120;
        ["id"] = 129928;
        ["count"] = 0;
    };
    [45] = {
        ["clones"] = {
            [1] = {
                ["y"] = -91.98827358676;
                ["x"] = 553.28611263016;
                ["week"] = {
                    [1] = true;
                    [10] = true;
                    [4] = true;
                    [7] = true;
                };
                ["g"] = 3;
                ["sublevel"] = 1;
            };
            [2] = {
                ["y"] = -113.69286683266;
                ["x"] = 532.97577929837;
                ["week"] = {
                    [1] = true;
                    [10] = true;
                    [4] = true;
                    [7] = true;
                };
                ["g"] = 6;
                ["sublevel"] = 1;
            };
            [3] = {
                ["y"] = -397.57569813861;
                ["x"] = 447.98854077863;
                ["week"] = {
                    [1] = true;
                    [10] = true;
                    [4] = true;
                    [7] = true;
                };
                ["g"] = 35;
                ["sublevel"] = 1;
            };
            [4] = {
                ["y"] = -435.20804587618;
                ["x"] = 375.10515977556;
                ["week"] = {
                    [1] = true;
                    [10] = true;
                    [7] = true;
                    [4] = true;
                };
                ["g"] = 42;
                ["sublevel"] = 1;
            };
            [5] = {
                ["y"] = -97.489084425985;
                ["x"] = 577.94754111969;
                ["week"] = {
                    [5] = true;
                    [2] = true;
                    [11] = true;
                    [8] = true;
                };
                ["g"] = 2;
                ["sublevel"] = 1;
            };
            [6] = {
                ["y"] = -123.04234997355;
                ["x"] = 503.85647008963;
                ["week"] = {
                    [5] = true;
                    [2] = true;
                    [11] = true;
                    [8] = true;
                };
                ["g"] = 10;
                ["sublevel"] = 1;
            };
            [7] = {
                ["y"] = -151.99453722886;
                ["x"] = 513.3023494833;
                ["week"] = {
                    [5] = true;
                    [2] = true;
                    [11] = true;
                    [8] = true;
                };
                ["g"] = 14;
                ["sublevel"] = 1;
            };
            [8] = {
                ["y"] = -222.3930490868;
                ["x"] = 483.1577308154;
                ["week"] = {
                    [5] = true;
                    [2] = true;
                    [11] = true;
                    [8] = true;
                };
                ["g"] = 21;
                ["sublevel"] = 1;
            };
            [9] = {
                ["y"] = -317.72736086716;
                ["x"] = 516.98335609567;
                ["week"] = {
                    [5] = true;
                    [2] = true;
                    [11] = true;
                    [8] = true;
                };
                ["g"] = 33;
                ["sublevel"] = 1;
            };
            [10] = {
                ["y"] = -380.43071445262;
                ["x"] = 457.0321638318;
                ["week"] = {
                    [5] = true;
                    [2] = true;
                    [11] = true;
                    [8] = true;
                };
                ["g"] = 36;
                ["sublevel"] = 1;
            };
            [11] = {
                ["y"] = -426.2880319026;
                ["x"] = 402.1498880472;
                ["week"] = {
                    [5] = true;
                    [2] = true;
                    [11] = true;
                    [8] = true;
                };
                ["g"] = 43;
                ["sublevel"] = 1;
            };
            [12] = {
                ["sublevel"] = 1;
                ["week"] = {
                    [11] = true;
                    [2] = true;
                    [8] = true;
                    [3] = true;
                    [12] = true;
                    [6] = true;
                    [5] = true;
                    [9] = true;
                };
                ["x"] = 420.41720078873;
                ["g"] = 44;
                ["y"] = -443.43940473214;
            };
            [13] = {
                ["y"] = -144.19881465998;
                ["x"] = 494.54839393068;
                ["week"] = {
                    [3] = true;
                    [6] = true;
                    [9] = true;
                    [12] = true;
                };
                ["g"] = 13;
                ["sublevel"] = 1;
            };
            [14] = {
                ["y"] = -92.958555214125;
                ["x"] = 586.57229468789;
                ["week"] = {
                    [8] = true;
                    [2] = true;
                    [5] = true;
                    [11] = true;
                };
                ["g"] = 50;
                ["sublevel"] = 2;
            };
            [15] = {
                ["y"] = -91.814153758152;
                ["x"] = 632.20577486188;
                ["sublevel"] = 2;
                ["g"] = 74;
                ["week"] = {
                    [3] = true;
                    [6] = true;
                    [9] = true;
                    [12] = true;
                };
            };
            [16] = {
                ["y"] = -282.44947822112;
                ["x"] = 517.20600499237;
                ["sublevel"] = 1;
                ["g"] = 26;
                ["week"] = {
                    [3] = true;
                    [6] = true;
                    [9] = true;
                    [12] = true;
                };
            };
            [17] = {
                ["y"] = -408.15391588801;
                ["x"] = 454.72082679064;
                ["sublevel"] = 1;
                ["g"] = 40;
                ["week"] = {
                    [3] = true;
                    [6] = true;
                    [9] = true;
                    [12] = true;
                };
            };
        };
        ["scale"] = 0.71;
        ["spells"] = {
            [302417] = {};
            [302418] = {};
            [302415] = {};
        };
        ["characteristics"] = {
            ["Taunt"] = true;
        };
        ["id"] = 155434;
        ["name"] = "Emissary of the Tides";
        ["ignoreFortified"] = true;
        ["count"] = 4;
        ["displayId"] = 39391;
        ["creatureType"] = "Humanoid";
        ["level"] = 120;
        ["health"] = 402855;
        ["iconTexture"] = 132315;
    };
    [46] = {
        ["clones"] = {
            [1] = {
                ["y"] = -129.76866766248;
                ["x"] = 530.05919700602;
                ["week"] = {
                    [1] = true;
                    [10] = true;
                    [4] = true;
                    [7] = true;
                };
                ["g"] = 9;
                ["sublevel"] = 1;
            };
            [2] = {
                ["y"] = -151.5287610665;
                ["x"] = 513.05659382822;
                ["week"] = {
                    [1] = true;
                    [10] = true;
                    [4] = true;
                    [7] = true;
                };
                ["g"] = 14;
                ["sublevel"] = 1;
            };
            [3] = {
                ["y"] = -256.79775519363;
                ["x"] = 504.59565977095;
                ["week"] = {
                    [1] = true;
                    [10] = true;
                    [4] = true;
                    [7] = true;
                };
                ["g"] = 23;
                ["sublevel"] = 1;
            };
            [4] = {
                ["y"] = -339.23155291554;
                ["x"] = 464.81120750834;
                ["week"] = {
                    [1] = true;
                    [10] = true;
                    [4] = true;
                    [7] = true;
                };
                ["g"] = 34;
                ["sublevel"] = 1;
            };
            [5] = {
                ["y"] = -387.96105970745;
                ["x"] = 467.21278653316;
                ["week"] = {
                    [1] = true;
                    [10] = true;
                    [4] = true;
                    [7] = true;
                };
                ["g"] = 37;
                ["sublevel"] = 1;
            };
            [6] = {
                ["y"] = -162.2997205633;
                ["x"] = 468.30469461163;
                ["week"] = {
                    [5] = true;
                    [2] = true;
                    [11] = true;
                    [8] = true;
                };
                ["g"] = 17;
                ["sublevel"] = 1;
            };
            [7] = {
                ["y"] = -410.21330029219;
                ["x"] = 453.60268070019;
                ["week"] = {
                    [5] = true;
                    [2] = true;
                    [11] = true;
                    [8] = true;
                };
                ["g"] = 40;
                ["sublevel"] = 1;
            };
            [8] = {
                ["y"] = -111.15102341581;
                ["x"] = 535.51142066538;
                ["week"] = {
                    [3] = true;
                    [6] = true;
                    [9] = true;
                    [12] = true;
                };
                ["g"] = 6;
                ["sublevel"] = 1;
            };
            [9] = {
                ["y"] = -185.16808696108;
                ["x"] = 483.45287596095;
                ["week"] = {
                    [3] = true;
                    [6] = true;
                    [9] = true;
                    [12] = true;
                };
                ["g"] = 20;
                ["sublevel"] = 1;
            };
            [10] = {
                ["y"] = -104.33869054805;
                ["x"] = 600.13085253536;
                ["week"] = {
                    [11] = true;
                    [2] = true;
                    [8] = true;
                    [3] = true;
                    [12] = true;
                    [6] = true;
                    [5] = true;
                    [9] = true;
                };
                ["g"] = 64;
                ["sublevel"] = 2;
            };
        };
        ["characteristics"] = {
            ["Taunt"] = true;
        };
        ["scale"] = 0.7;
        ["spells"] = {
            [302419] = {};
            [302420] = {};
            [302421] = {};
            [302415] = {};
        };
        ["stealthDetect"] = true;
        ["id"] = 155433;
        ["name"] = "Void-Touched Emissary";
        ["ignoreFortified"] = true;
        ["count"] = 4;
        ["displayId"] = 39391;
        ["creatureType"] = "Humanoid";
        ["level"] = 122;
        ["health"] = 654640;
        ["iconTexture"] = 132886;
    };
    [47] = {
        ["clones"] = {
            [1] = {
                ["y"] = -88.574309265575;
                ["x"] = 611.15319130805;
                ["week"] = {
                    [1] = true;
                    [10] = true;
                    [4] = true;
                    [7] = true;
                };
                ["g"] = 1;
                ["sublevel"] = 1;
            };
            [2] = {
                ["y"] = -162.7838707085;
                ["x"] = 467.53707745317;
                ["week"] = {
                    [1] = true;
                    [10] = true;
                    [4] = true;
                    [7] = true;
                };
                ["g"] = 17;
                ["sublevel"] = 1;
            };
            [3] = {
                ["y"] = -304.85254766983;
                ["x"] = 542.30315452555;
                ["week"] = {
                    [1] = true;
                    [10] = true;
                    [4] = true;
                    [7] = true;
                };
                ["sublevel"] = 1;
            };
            [4] = {
                ["y"] = -410.38932404723;
                ["x"] = 453.89339523727;
                ["week"] = {
                    [1] = true;
                    [10] = true;
                    [4] = true;
                    [7] = true;
                };
                ["g"] = 40;
                ["sublevel"] = 1;
            };
            [5] = {
                ["y"] = -443.52326411391;
                ["x"] = 420.91492385304;
                ["week"] = {
                    [1] = true;
                    [10] = true;
                    [4] = true;
                    [7] = true;
                };
                ["g"] = 44;
                ["sublevel"] = 1;
            };
            [6] = {
                ["y"] = -110.85639208494;
                ["x"] = 533.9982875369;
                ["week"] = {
                    [5] = true;
                    [2] = true;
                    [11] = true;
                    [8] = true;
                };
                ["g"] = 6;
                ["sublevel"] = 1;
            };
            [7] = {
                ["y"] = -258.96340443087;
                ["x"] = 522.11041121354;
                ["week"] = {
                    [5] = true;
                    [2] = true;
                    [11] = true;
                    [8] = true;
                };
                ["g"] = 24;
                ["sublevel"] = 1;
            };
            [8] = {
                ["y"] = -416.51805129462;
                ["x"] = 428.18511485828;
                ["week"] = {
                    [5] = true;
                    [2] = true;
                    [11] = true;
                    [8] = true;
                };
                ["g"] = 41;
                ["sublevel"] = 1;
            };
            [9] = {
                ["y"] = -91.434529033634;
                ["x"] = 552.43014693802;
                ["week"] = {
                    [3] = true;
                    [6] = true;
                    [9] = true;
                    [12] = true;
                };
                ["g"] = 3;
                ["sublevel"] = 1;
            };
            [10] = {
                ["sublevel"] = 2;
                ["week"] = {
                    [8] = true;
                    [2] = true;
                    [5] = true;
                    [11] = true;
                };
                ["y"] = -92.10122188565;
                ["g"] = 74;
                ["x"] = 632.74911628192;
            };
            [11] = {
                ["y"] = -93.286352517427;
                ["x"] = 586.71705255714;
                ["sublevel"] = 2;
                ["g"] = 50;
                ["week"] = {
                    [3] = true;
                    [6] = true;
                    [9] = true;
                    [12] = true;
                };
            };
            [12] = {
                ["y"] = -98.209666835254;
                ["x"] = 617.42410492582;
                ["sublevel"] = 2;
                ["g"] = 76;
                ["week"] = {
                    [3] = true;
                    [6] = true;
                    [9] = true;
                    [12] = true;
                };
            };
            [13] = {
                ["y"] = -222.29793966383;
                ["x"] = 483.19658481283;
                ["sublevel"] = 1;
                ["g"] = 21;
                ["week"] = {
                    [3] = true;
                    [6] = true;
                    [9] = true;
                    [12] = true;
                };
            };
            [14] = {
                ["y"] = -317.97340426787;
                ["x"] = 516.98007601731;
                ["sublevel"] = 1;
                ["g"] = 33;
                ["week"] = {
                    [3] = true;
                    [6] = true;
                    [9] = true;
                    [12] = true;
                };
            };
            [15] = {
                ["y"] = -380.71228589938;
                ["x"] = 457.00352702145;
                ["sublevel"] = 1;
                ["g"] = 36;
                ["week"] = {
                    [3] = true;
                    [6] = true;
                    [9] = true;
                    [12] = true;
                };
            };
            [16] = {
                ["y"] = -420.08134133173;
                ["x"] = 427.29094862578;
                ["sublevel"] = 1;
                ["g"] = 41;
                ["week"] = {
                    [3] = true;
                    [6] = true;
                    [9] = true;
                    [12] = true;
                };
            };
            [17] = {
                ["y"] = -425.90018296071;
                ["x"] = 402.4320510277;
                ["sublevel"] = 1;
                ["g"] = 43;
                ["week"] = {
                    [3] = true;
                    [6] = true;
                    [9] = true;
                    [12] = true;
                };
            };
        };
        ["scale"] = 0.7;
        ["spells"] = {
            [303632] = {};
            [302415] = {};
            [290027] = {};
        };
        ["characteristics"] = {
            ["Taunt"] = true;
        };
        ["id"] = 155432;
        ["name"] = "Enchanted Emissary";
        ["ignoreFortified"] = true;
        ["count"] = 0;
        ["displayId"] = 39391;
        ["creatureType"] = "Humanoid";
        ["level"] = 121;
        ["health"] = 10071399;
        ["iconTexture"] = 135735;
    };
    [48] = {
        ["clones"] = {
            [1] = {
                ["y"] = -400.45707548781;
                ["x"] = 431.49685325048;
                ["week"] = {
                    [1] = true;
                    [2] = true;
                    [5] = true;
                    [6] = true;
                    [9] = true;
                    [10] = true;
                };
                ["sublevel"] = 1;
            };
            [2] = {
                ["y"] = -112.17227814258;
                ["x"] = 549.70320325251;
                ["week"] = {
                    [11] = true;
                    [7] = true;
                    [8] = true;
                    [3] = true;
                    [12] = true;
                    [4] = true;
                };
                ["sublevel"] = 1;
            };
        };
        ["characteristics"] = {
            ["Taunt"] = true;
        };
        ["id"] = 161243;
        ["spells"] = {
            [314477] = {};
            [314531] = {};
            [314397] = {};
            [314483] = {};
        };
        ["stealthDetect"] = true;
        ["health"] = 1409996;
        ["level"] = 122;
        ["teemingCount"] = 6;
        ["name"] = "Samh'rek, Beckoner of Chaos";
        ["displayId"] = 90742;
        ["creatureType"] = "Aberration";
        ["corrupted"] = true;
        ["count"] = 4;
        ["scale"] = 0.8;
    };
    [49] = {
        ["clones"] = {
            [1] = {
                ["y"] = -112.89332275349;
                ["x"] = 549.93045867439;
                ["week"] = {
                    [1] = true;
                    [2] = true;
                    [5] = true;
                    [6] = true;
                    [9] = true;
                    [10] = true;
                };
                ["sublevel"] = 1;
            };
            [2] = {
                ["y"] = -400.45946829255;
                ["x"] = 432.57146438212;
                ["week"] = {
                    [11] = true;
                    [7] = true;
                    [8] = true;
                    [3] = true;
                    [12] = true;
                    [4] = true;
                };
                ["sublevel"] = 1;
            };
        };
        ["characteristics"] = {
            ["Taunt"] = true;
        };
        ["id"] = 161124;
        ["spells"] = {
            [314308] = {};
            [314387] = {};
            [314397] = {};
            [314309] = {};
        };
        ["stealthDetect"] = true;
        ["scale"] = 0.8;
        ["corrupted"] = true;
        ["teemingCount"] = 6;
        ["name"] = "Urg'roth, Breaker of Heroes";
        ["displayId"] = 89415;
        ["creatureType"] = "Aberration";
        ["level"] = 122;
        ["count"] = 4;
        ["health"] = 1510710;
    };
    [50] = {
        ["clones"] = {
            [1] = {
                ["y"] = -212.80203276973;
                ["x"] = 500.3789025889;
                ["week"] = {
                    [1] = true;
                    [2] = true;
                    [3] = true;
                    [4] = true;
                    [5] = true;
                    [6] = true;
                    [7] = true;
                    [8] = true;
                    [9] = true;
                    [10] = true;
                    [11] = true;
                    [12] = true;
                };
                ["sublevel"] = 1;
            };
        };
        ["count"] = 4;
        ["scale"] = 0.8;
        ["spells"] = {
            [314463] = {};
            [314467] = {};
            [314397] = {};
            [314406] = {};
            [314411] = {};
        };
        ["stealthDetect"] = true;
        ["health"] = 1309282;
        ["corrupted"] = true;
        ["teemingCount"] = 6;
        ["name"] = "Voidweaver Mal'thir";
        ["displayId"] = 91910;
        ["creatureType"] = "Beast";
        ["level"] = 122;
        ["id"] = 161241;
        ["characteristics"] = {
            ["Taunt"] = true;
        };
    };
    [51] = {
        ["clones"] = {
            [1] = {
                ["y"] = -321.29631109725;
                ["x"] = 540.27364734989;
                ["week"] = {
                    [1] = true;
                    [2] = true;
                    [3] = true;
                    [4] = true;
                    [5] = true;
                    [6] = true;
                    [7] = true;
                    [8] = true;
                    [9] = true;
                    [10] = true;
                    [11] = true;
                    [12] = true;
                };
                ["sublevel"] = 1;
            };
        };
        ["characteristics"] = {
            ["Taunt"] = true;
        };
        ["id"] = 161244;
        ["spells"] = {
            [314566] = {};
            [314565] = {};
            [314592] = {};
            [314397] = {};
        };
        ["stealthDetect"] = true;
        ["scale"] = 0.8;
        ["level"] = 122;
        ["teemingCount"] = 6;
        ["health"] = 1409996;
        ["displayId"] = 92229;
        ["creatureType"] = "Aberration";
        ["corrupted"] = true;
        ["name"] = "Blood of the Corruptor";
        ["count"] = 4;
    };
    [52] = {
        ["clones"] = {
            [1] = {
                ["y"] = -511.56325370334;
                ["x"] = 446.77737426181;
                ["g"] = 78;
                ["sublevel"] = 1;
            };
        };
        ["scale"] = 1;
        ["health"] = 461097;
        ["ignoreFortified"] = true;
        ["count"] = 0;
        ["displayId"] = 86691;
        ["creatureType"] = "Aberration";
        ["level"] = 121;
        ["id"] = 137614;
        ["name"] = "Demolishing Terror";
    };
    [53] = {
        ["clones"] = {
            [1] = {
                ["y"] = -517.07456837719;
                ["x"] = 417.27559422224;
                ["g"] = 78;
                ["sublevel"] = 1;
            };
        };
        ["scale"] = 1;
        ["id"] = 137405;
        ["name"] = "Gripping Terror";
        ["displayId"] = 88448;
        ["creatureType"] = "Aberration";
        ["level"] = 122;
        ["count"] = 0;
        ["health"] = 1383291;
        ["isBoss"] = true;
    };
};
