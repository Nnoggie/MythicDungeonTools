local dungeonIndex = 19
MethodDungeonTools.dungeonTotalCount[dungeonIndex] = {normal=319,teeming=383,teemingEnabled=true}


local selectorGroup
local AceGUI = LibStub("AceGUI-3.0")
local db
local function fixBoralusShowHide(widget, frame, isFrame)
    frame = frame or MethodDungeonTools.main_frame
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

function MethodDungeonTools:ToggleBoralusSelector(show)
    db = MethodDungeonTools:GetDB()
    if not selectorGroup then
        selectorGroup = AceGUI:Create("SimpleGroup")
        selectorGroup.frame:SetFrameStrata("HIGH")
        selectorGroup.frame:SetFrameLevel(50)
        selectorGroup.frame:SetBackdropColor(unpack(MethodDungeonTools.BackdropColor))
        fixBoralusShowHide(selectorGroup)
        selectorGroup:SetLayout("Flow")
        selectorGroup.frame.bg = selectorGroup.frame:CreateTexture(nil, "BACKGROUND")
        selectorGroup.frame.bg:SetAllPoints(selectorGroup.frame)
        selectorGroup.frame.bg:SetColorTexture(unpack(MethodDungeonTools.BackdropColor))
        selectorGroup:SetWidth(120)
        selectorGroup:SetHeight(120)
        selectorGroup.frame:SetPoint("TOPRIGHT",MethodDungeonTools.main_frame,"TOPRIGHT",0,0)

        local label = AceGUI:Create("Label")
        label:SetText("  Choose Faction:")
        selectorGroup:AddChild(label)

        selectorGroup.check1 = AceGUI:Create("CheckBox")
        selectorGroup.check2 = AceGUI:Create("CheckBox")
        local check1 = selectorGroup.check1
        local check2 = selectorGroup.check2

        check1:SetLabel("Horde")
        selectorGroup:AddChild(check1)
        check1:SetCallback("OnValueChanged",function(widget,callbackName,value)
            if value then
                MethodDungeonTools:GetCurrentPreset().faction = 1
                MethodDungeonTools:UpdateBoralusSelector()
                MethodDungeonTools:ReloadPullButtons()
                MethodDungeonTools:UpdateProgressbar()
            end
            check1:SetValue(true)
        end)

        check2:SetLabel("Alliance")
        selectorGroup:AddChild(check2)
        check2:SetCallback("OnValueChanged",function(widget,callbackName,value)
            if value then
                MethodDungeonTools:GetCurrentPreset().faction = 2
                MethodDungeonTools:UpdateBoralusSelector()
                MethodDungeonTools:ReloadPullButtons()
                MethodDungeonTools:UpdateProgressbar()
            end
            check2:SetValue(true)
        end)

    end
    if show then
        selectorGroup.frame:Show()
        MethodDungeonTools:UpdateBoralusSelector()
    else
        selectorGroup.frame:Hide()
    end
end

function MethodDungeonTools:UpdateBoralusSelector()
    selectorGroup.check1:SetValue(MethodDungeonTools:GetCurrentPreset().faction==1)
    selectorGroup.check2:SetValue(MethodDungeonTools:GetCurrentPreset().faction==2)
    MethodDungeonTools:DungeonEnemies_UpdateBoralusFaction(MethodDungeonTools:GetCurrentPreset().faction)
end


MethodDungeonTools.mapPOIs[dungeonIndex] = {
    [1] = {
        [6] = {
            ["y"] = -279.04184468091;
            ["x"] = 540.43646488041;
            ["template"] = "MapLinkPinTemplate";
            ["type"] = "sobGutters";
        };
        [2] = {
            ["y"] = -96.177558505241;
            ["x"] = 634.18715497149;
            ["template"] = "DeathReleasePinTemplate";
            ["graveyardDescription"] = "";
            ["type"] = "graveyard";
        };
        [3] = {
            ["y"] = -334.61016080079;
            ["x"] = 432.0393310099;
            ["template"] = "DeathReleasePinTemplate";
            ["graveyardDescription"] = "Unlocks after killing Dread Captain Lockwood";
            ["type"] = "graveyard";
        };
        [1] = {
            ["y"] = -112.09388221952;
            ["x"] = 526.6887930726;
            ["template"] = "DeathReleasePinTemplate";
            ["graveyardDescription"] = "Unlocks after defeat Seargeant Bainbridge / Chopper Redhook";
            ["type"] = "graveyard";
        };
        [4] = {
            ["y"] = -462.91658652644;
            ["x"] = 405.60201958621;
            ["template"] = "DeathReleasePinTemplate";
            ["graveyardDescription"] = "Unlocks after defeating Hadal Darkfathom";
            ["type"] = "graveyard";
        };
        [5] = {
            ["y"] = -99.22379149751;
            ["x"] = 510.75103230284;
            ["template"] = "MapLinkPinTemplate";
            ["type"] = "sobGutters";
        };
        [7] = {
            ["y"] = -229.95502100789;
            ["x"] = 471.82728422311;
            ["template"] = "MapLinkPinTemplate";
            ["text"] = "G72 Gutters can be used for Enemy forces by tagging them with damage and triggering the instant-kill from the footmen next to them.";
            ["type"] = "generalNote";
        };
    };
};



MethodDungeonTools.dungeonEnemies[dungeonIndex] = {
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
                ["y"] = -408.78128372814;
                ["g"] = 40;
                ["infested"] = {
                    [1] = true;
                };
            };
        };
        ["scale"] = 0.7;
        ["spells"] = {
            [277564] = {};
            [209859] = {};
            [277242] = {};
            [272588] = {};
        };
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
        ["count"] = 4;
        ["name"] = "Bilge Rat Cutthroat";
        ["displayId"] = 80319;
        ["creatureType"] = "Humanoid";
        ["level"] = 120;
        ["health"] = 235456;
        ["id"] = 137511;
    };
    [2] = {
        ["clones"] = {
            [6] = {
                ["sublevel"] = 1;
                ["x"] = 580.21555981137;
                ["faction"] = 1;
                ["g"] = 2;
                ["y"] = -108.49841657382;
            };
            [2] = {
                ["sublevel"] = 1;
                ["x"] = 617.86235023493;
                ["faction"] = 1;
                ["y"] = -95.255434327295;
                ["g"] = 1;
                ["infested"] = {
                    [1] = true;
                };
            };
            [8] = {
                ["sublevel"] = 1;
                ["x"] = 512.22634355934;
                ["faction"] = 1;
                ["y"] = -117.92706622296;
                ["g"] = 10;
                ["infested"] = {
                    [1] = true;
                };
            };
            [3] = {
                ["sublevel"] = 1;
                ["x"] = 618.11550723705;
                ["faction"] = 1;
                ["g"] = 1;
                ["y"] = -99.938963809923;
            };
            [1] = {
                ["y"] = -90.192147612201;
                ["x"] = 618.62184297058;
                ["faction"] = 1;
                ["g"] = 1;
                ["sublevel"] = 1;
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
                ["y"] = -103.94146015993;
                ["g"] = 2;
                ["infested"] = {
                    [1] = true;
                };
            };
            [7] = {
                ["sublevel"] = 1;
                ["x"] = 510.11098019186;
                ["faction"] = 1;
                ["g"] = 10;
                ["y"] = -115.04246180632;
            };
        };
        ["scale"] = 0.5;
        ["spells"] = {
            [277564] = {};
            [209859] = {};
            [277242] = {};
            [273930] = {};
        };
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
        ["health"] = 95654;
        ["count"] = 1;
        ["displayId"] = 86025;
        ["creatureType"] = "Humanoid";
        ["level"] = 120;
        ["name"] = "Kul Tiran Footman";
        ["id"] = 141495;
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
                ["sublevel"] = 1;
                ["x"] = 583.49301193129;
                ["faction"] = 2;
                ["g"] = 50;
                ["y"] = -90.909016160703;
            };
            [3] = {
                ["sublevel"] = 1;
                ["x"] = 545.56199350463;
                ["faction"] = 2;
                ["g"] = 52;
                ["y"] = -118.77616417887;
            };
        };
        ["scale"] = 0.7;
        ["spells"] = {
            [257063] = {};
            [277564] = {};
            [209859] = {};
            [256957] = {};
            [257069] = {};
        };
        ["characteristics"] = {
            ["Taunt"] = true;
            ["Incapacitate"] = true;
            ["Sap"] = true;
            ["Silence"] = true;
            ["Root"] = true;
            ["Slow"] = true;
            ["Stun"] = true;
            ["Fear"] = true;
        };
        ["health"] = 235470;
        ["count"] = 4;
        ["displayId"] = 79077;
        ["creatureType"] = "Humanoid";
        ["level"] = 120;
        ["name"] = "Irontide Waveshaper";
        ["id"] = 144071;
    };
    [3] = {
        ["clones"] = {
            [1] = {
                ["sublevel"] = 1;
                ["x"] = 576.53112335304;
                ["faction"] = 1;
                ["infested"] = {
                    [2] = true;
                };
                ["g"] = 2;
                ["y"] = -103.47383528397;
            };
            [2] = {
                ["sublevel"] = 1;
                ["x"] = 507.6109962998;
                ["faction"] = 1;
                ["infested"] = {
                    [2] = true;
                };
                ["g"] = 10;
                ["y"] = -120.61937688321;
            };
            [3] = {
                ["sublevel"] = 1;
                ["x"] = 508.42957993605;
                ["faction"] = 1;
                ["infested"] = {
                    [3] = true;
                };
                ["g"] = 14;
                ["y"] = -156.40629336908;
            };
        };
        ["scale"] = 0.7;
        ["spells"] = {
            [257063] = {};
            [277242] = {};
            [209859] = {};
            [277564] = {};
            [256957] = {};
            [257069] = {};
        };
        ["characteristics"] = {
            ["Taunt"] = true;
            ["Disorient"] = true;
            ["Sap"] = true;
            ["Stun"] = true;
            ["Root"] = true;
            ["Slow"] = true;
            ["Incapacitate"] = true;
            ["Polymorph"] = true;
        };
        ["health"] = 235455;
        ["count"] = 4;
        ["displayId"] = 81778;
        ["creatureType"] = "Humanoid";
        ["level"] = 120;
        ["name"] = "Kul Tiran Wavetender";
        ["id"] = 141284;
    };
    [4] = {
        ["clones"] = {
            [2] = {
                ["sublevel"] = 1;
                ["x"] = 555.09917820964;
                ["faction"] = 1;
                ["infested"] = {
                    [2] = true;
                    [3] = true;
                };
                ["g"] = 3;
                ["y"] = -88.794516245139;
            };
            [3] = {
                ["sublevel"] = 1;
                ["x"] = 511.06478359356;
                ["faction"] = 1;
                ["g"] = 10;
                ["y"] = -125.25348446226;
            };
            [1] = {
                ["sublevel"] = 1;
                ["x"] = 553.78339410086;
                ["faction"] = 1;
                ["g"] = 3;
                ["y"] = -94.715578615164;
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
        ["scale"] = 0.7;
        ["spells"] = {
            [257641] = {};
            [209859] = {};
            [277242] = {};
            [277564] = {};
        };
        ["characteristics"] = {
            ["Taunt"] = true;
            ["Incapacitate"] = true;
            ["Root"] = true;
            ["Disorient"] = true;
            ["Sap"] = true;
            ["Imprison"] = true;
            ["Silence"] = true;
            ["Slow"] = true;
            ["Stun"] = true;
            ["Fear"] = true;
        };
        ["health"] = 264888;
        ["count"] = 4;
        ["displayId"] = 88463;
        ["creatureType"] = "Humanoid";
        ["level"] = 120;
        ["name"] = "Kul Tiran Marksman";
        ["id"] = 141285;
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
                ["x"] = 539.55853986784;
                ["faction"] = 1;
                ["g"] = 5;
                ["y"] = -102.18177787393;
            };
            [4] = {
                ["sublevel"] = 1;
                ["x"] = 537.6726369039;
                ["faction"] = 1;
                ["g"] = 6;
                ["y"] = -110.28037172644;
            };
            [8] = {
                ["sublevel"] = 1;
                ["x"] = 527.00164322093;
                ["faction"] = 1;
                ["g"] = 9;
                ["y"] = -123.65452338748;
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
            [9] = {
                ["sublevel"] = 1;
                ["x"] = 501.07249689966;
                ["faction"] = 1;
                ["g"] = 11;
                ["y"] = -124.4655326113;
            };
            [18] = {
                ["sublevel"] = 1;
                ["x"] = 513.48725074411;
                ["faction"] = 1;
                ["g"] = 26;
                ["y"] = -281.78978442034;
            };
            [5] = {
                ["sublevel"] = 1;
                ["x"] = 521.62802118769;
                ["faction"] = 1;
                ["g"] = 7;
                ["y"] = -103.87973231655;
            };
            [10] = {
                ["sublevel"] = 1;
                ["x"] = 493.74373233938;
                ["faction"] = 1;
                ["g"] = 12;
                ["y"] = -128.38270722552;
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
            [11] = {
                ["sublevel"] = 1;
                ["x"] = 531.70160159579;
                ["faction"] = 1;
                ["g"] = 25;
                ["y"] = -249.61912950879;
            };
            [22] = {
                ["sublevel"] = 1;
                ["x"] = 533.6977027601;
                ["faction"] = 1;
                ["g"] = 30;
                ["y"] = -303.96667733386;
            };
            [3] = {
                ["sublevel"] = 1;
                ["x"] = 535.88156858955;
                ["faction"] = 1;
                ["g"] = 6;
                ["y"] = -107.14604701323;
            };
            [6] = {
                ["sublevel"] = 1;
                ["x"] = 518.95715322177;
                ["faction"] = 1;
                ["g"] = 8;
                ["y"] = -116.38860063055;
            };
            [12] = {
                ["sublevel"] = 1;
                ["x"] = 543.04486771625;
                ["faction"] = 1;
                ["g"] = 25;
                ["y"] = -247.52958183507;
            };
            [24] = {
                ["sublevel"] = 1;
                ["x"] = 532.60962121856;
                ["faction"] = 1;
                ["g"] = 31;
                ["y"] = -310.38854239272;
            };
            [19] = {
                ["sublevel"] = 1;
                ["x"] = 520.24441555424;
                ["faction"] = 1;
                ["g"] = 27;
                ["y"] = -284.49819137727;
            };
            [25] = {
                ["sublevel"] = 1;
                ["x"] = 520.05602776878;
                ["faction"] = 1;
                ["g"] = 32;
                ["y"] = -308.23708254048;
            };
            [13] = {
                ["sublevel"] = 1;
                ["x"] = 533.81647645127;
                ["faction"] = 1;
                ["g"] = 25;
                ["y"] = -256.25419647414;
            };
            [26] = {
                ["y"] = -228.99519617792;
                ["x"] = 461.74934602061;
                ["g"] = 72;
                ["sublevel"] = 1;
            };
            [27] = {
                ["y"] = -229.08355032762;
                ["x"] = 465.85256533526;
                ["g"] = 72;
                ["sublevel"] = 1;
            };
            [7] = {
                ["sublevel"] = 1;
                ["x"] = 523.97836687484;
                ["faction"] = 1;
                ["g"] = 9;
                ["y"] = -126.67777977295;
            };
            [14] = {
                ["sublevel"] = 1;
                ["x"] = 540.80607075495;
                ["faction"] = 1;
                ["g"] = 25;
                ["y"] = -252.60419852913;
            };
            [28] = {
                ["y"] = -234.42998602391;
                ["x"] = 463.92330674024;
                ["g"] = 72;
                ["sublevel"] = 1;
            };
            [23] = {
                ["sublevel"] = 1;
                ["x"] = 525.34327180333;
                ["faction"] = 1;
                ["g"] = 31;
                ["y"] = -303.33376853159;
            };
            [29] = {
                ["y"] = -234.21258248841;
                ["x"] = 467.83630915541;
                ["g"] = 72;
                ["sublevel"] = 1;
            };
            [15] = {
                ["sublevel"] = 1;
                ["x"] = 534.32282304943;
                ["faction"] = 1;
                ["g"] = 25;
                ["y"] = -262.2035707229;
            };
        };
        ["scale"] = 0.5;
        ["spells"] = {
            [277564] = {};
            [256616] = {};
        };
        ["characteristics"] = {
            ["Taunt"] = true;
            ["Slow"] = true;
            ["Root"] = true;
        };
        ["health"] = 58864;
        ["count"] = 1;
        ["displayId"] = 83892;
        ["creatureType"] = "Humanoid";
        ["level"] = 120;
        ["name"] = "Scrimshaw Gutter";
        ["id"] = 141566;
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
        ["scale"] = 0.8;
        ["characteristics"] = {
            ["Taunt"] = true;
        };
        ["spells"] = {
            [256867] = {};
            [260924] = {};
            [273716] = {};
            [261428] = {};
            [257650] = {};
            [260954] = {};
            [273681] = {};
        };
        ["isBoss"] = true;
        ["encounterID"] = 2133;
        ["instanceID"] = 1023;
        ["id"] = 128649;
        ["health"] = 1648192;
        ["displayId"] = 84382;
        ["creatureType"] = "Humanoid";
        ["level"] = 122;
        ["count"] = 0;
        ["name"] = "Sergeant Bainbridge";
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
        ["scale"] = 1;
        ["spells"] = {
            [257292] = {};
        };
        ["characteristics"] = {
            ["Taunt"] = true;
            ["Incapacitate"] = true;
            ["Stun"] = true;
            ["Slow"] = true;
            ["Disorient"] = true;
        };
        ["count"] = 0;
        ["name"] = "Kul Tiran Vanguard";
        ["displayId"] = 84074;
        ["creatureType"] = "Humanoid";
        ["level"] = 121;
        ["health"] = 294320;
        ["id"] = 132530;
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
        ["scale"] = 1;
        ["spells"] = {
            [257641] = {};
        };
        ["characteristics"] = {
            ["Taunt"] = true;
            ["Incapacitate"] = true;
            ["Sap"] = true;
            ["Fear"] = true;
            ["Stun"] = true;
            ["Slow"] = true;
            ["Silence"] = true;
            ["Imprison"] = true;
        };
        ["count"] = 0;
        ["name"] = "Kul Tiran Marksman";
        ["displayId"] = 88463;
        ["creatureType"] = "Humanoid";
        ["level"] = 120;
        ["health"] = 294320;
        ["id"] = 132532;
    };
    [10] = {
        ["clones"] = {
            [6] = {
                ["sublevel"] = 1;
                ["x"] = 507.88130892115;
                ["faction"] = 2;
                ["g"] = 60;
                ["y"] = -153.6039050116;
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
                ["infested"] = {
                    [2] = true;
                };
                ["g"] = 54;
                ["y"] = -103.76107518243;
            };
            [1] = {
                ["y"] = -158.68471201329;
                ["x"] = 474.3417293891;
                ["g"] = 17;
                ["sublevel"] = 1;
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
        };
        ["id"] = 129640;
        ["spells"] = {
            [277564] = {};
            [256969] = {};
            [257145] = {};
            [256971] = {};
            [256897] = {};
        };
        ["characteristics"] = {
            ["Taunt"] = true;
            ["Disorient"] = true;
            ["Root"] = true;
            ["Fear"] = true;
        };
        ["name"] = "Snarling Dockhound";
        ["health"] = 294320;
        ["displayId"] = 30222;
        ["creatureType"] = "Humanoid";
        ["level"] = 120;
        ["count"] = 4;
        ["scale"] = 0.7;
    };
    [12] = {
        ["clones"] = {
            [7] = {
                ["sublevel"] = 1;
                ["x"] = 521.29167449675;
                ["faction"] = 2;
                ["g"] = 55;
                ["y"] = -123.9390118827;
            };
            [1] = {
                ["y"] = -159.13247909188;
                ["x"] = 469.11783138109;
                ["g"] = 17;
                ["sublevel"] = 1;
            };
            [2] = {
                ["sublevel"] = 1;
                ["x"] = 601.25835863159;
                ["faction"] = 2;
                ["g"] = 49;
                ["y"] = -81.41203802658;
            };
            [4] = {
                ["sublevel"] = 1;
                ["x"] = 537.00937367395;
                ["faction"] = 2;
                ["g"] = 52;
                ["y"] = -123.7761565288;
            };
            [8] = {
                ["sublevel"] = 1;
                ["x"] = 494.84812645343;
                ["faction"] = 2;
                ["infested"] = {
                    [2] = true;
                };
                ["g"] = 59;
                ["y"] = -138.06983172419;
            };
            [9] = {
                ["y"] = -101.7233227299;
                ["x"] = 621.1124097053;
                ["patrol"] = {
                    [13] = {
                        ["y"] = -93.063535343451;
                        ["x"] = 613.27735323007;
                    };
                    [7] = {
                        ["y"] = -93.888270678931;
                        ["x"] = 612.24642963646;
                    };
                    [1] = {
                        ["y"] = -101.7233227299;
                        ["x"] = 621.1124097053;
                    };
                    [2] = {
                        ["y"] = -105.22847445126;
                        ["x"] = 623.99900107652;
                    };
                    [4] = {
                        ["y"] = -105.84703922565;
                        ["x"] = 624.51446287333;
                    };
                    [8] = {
                        ["y"] = -94.919198696802;
                        ["x"] = 605.33922032282;
                    };
                    [9] = {
                        ["y"] = -102.34187865577;
                        ["x"] = 603.99899664497;
                    };
                    [5] = {
                        ["y"] = -101.7233227299;
                        ["x"] = 620.90622144717;
                    };
                    [10] = {
                        ["y"] = -103.57899050751;
                        ["x"] = 599.46292575426;
                    };
                    [11] = {
                        ["y"] = -102.1356948219;
                        ["x"] = 603.89591136442;
                    };
                    [3] = {
                        ["y"] = -106.15631718858;
                        ["x"] = 628.94743963497;
                    };
                    [6] = {
                        ["y"] = -96.671785618132;
                        ["x"] = 617.09179176288;
                    };
                    [12] = {
                        ["y"] = -94.816108991998;
                        ["x"] = 605.44231445188;
                    };
                    [14] = {
                        ["y"] = -96.87796060348;
                        ["x"] = 617.09179176288;
                    };
                };
                ["faction"] = 2;
                ["infested"] = {
                    [2] = true;
                };
                ["g"] = 67;
                ["sublevel"] = 1;
            };
            [5] = {
                ["sublevel"] = 1;
                ["x"] = 518.82062416232;
                ["faction"] = 2;
                ["g"] = 53;
                ["y"] = -98.008462251592;
            };
            [10] = {
                ["sublevel"] = 1;
                ["x"] = 624.10209520559;
                ["faction"] = 2;
                ["g"] = 67;
                ["y"] = -97.702713636003;
            };
            [3] = {
                ["sublevel"] = 1;
                ["x"] = 605.44071825455;
                ["faction"] = 2;
                ["infested"] = {
                    [2] = true;
                };
                ["g"] = 49;
                ["y"] = -78.881963201472;
            };
            [6] = {
                ["sublevel"] = 1;
                ["x"] = 513.01662807308;
                ["faction"] = 2;
                ["g"] = 53;
                ["y"] = -96.003117622003;
            };
        };
        ["id"] = 129372;
        ["spells"] = {
            [277564] = {};
            [256660] = {};
            [256640] = {};
            [256639] = {};
            [256673] = {};
        };
        ["characteristics"] = {
            ["Taunt"] = true;
            ["Disorient"] = true;
            ["Stun"] = true;
            ["Incapacitate"] = true;
            ["Silence"] = true;
            ["Fear"] = true;
        };
        ["name"] = "Blacktar Bomber";
        ["health"] = 294320;
        ["displayId"] = 84136;
        ["creatureType"] = "Humanoid";
        ["level"] = 120;
        ["count"] = 4;
        ["scale"] = 0.7;
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
            [4] = {
                ["y"] = -170.96877914661;
                ["x"] = 454.07366861541;
                ["g"] = 18;
                ["sublevel"] = 1;
            };
            [8] = {
                ["y"] = -182.40350109144;
                ["x"] = 487.30441540797;
                ["g"] = 20;
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
            [9] = {
                ["y"] = -185.58175782923;
                ["x"] = 479.1174607118;
                ["g"] = 20;
                ["sublevel"] = 1;
            };
            [18] = {
                ["y"] = -248.3434672879;
                ["x"] = 544.36542224934;
                ["faction"] = 2;
                ["g"] = 69;
                ["sublevel"] = 1;
            };
            [5] = {
                ["y"] = -192.00199282486;
                ["x"] = 473.5233553089;
                ["g"] = 19;
                ["sublevel"] = 1;
            };
            [10] = {
                ["sublevel"] = 1;
                ["x"] = 515.78610180136;
                ["y"] = -262.75904475622;
                ["g"] = 24;
                ["infested"] = {
                    [1] = true;
                };
            };
            [20] = {
                ["y"] = -259.44236260169;
                ["x"] = 546.34344179557;
                ["faction"] = 2;
                ["g"] = 69;
                ["sublevel"] = 1;
            };
            [21] = {
                ["y"] = -281.03957526051;
                ["x"] = 514.80523270573;
                ["faction"] = 2;
                ["g"] = 70;
                ["sublevel"] = 1;
            };
            [11] = {
                ["y"] = -267.11198743104;
                ["x"] = 514.37433879281;
                ["g"] = 24;
                ["sublevel"] = 1;
            };
            [22] = {
                ["y"] = -286.86374235242;
                ["x"] = 519.97006938083;
                ["faction"] = 2;
                ["g"] = 70;
                ["sublevel"] = 1;
            };
            [3] = {
                ["y"] = -166.02372556507;
                ["x"] = 452.75497948599;
                ["g"] = 18;
                ["sublevel"] = 1;
            };
            [6] = {
                ["y"] = -181.97309174938;
                ["x"] = 480.22183192311;
                ["g"] = 20;
                ["sublevel"] = 1;
            };
            [12] = {
                ["y"] = -322.28836371105;
                ["x"] = 519.1309083453;
                ["g"] = 33;
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
            [13] = {
                ["y"] = -313.2846105706;
                ["x"] = 515.44946891385;
                ["g"] = 33;
                ["sublevel"] = 1;
            };
            [26] = {
                ["y"] = -303.66259647058;
                ["x"] = 537.94146653314;
                ["faction"] = 2;
                ["g"] = 71;
                ["sublevel"] = 1;
            };
            [7] = {
                ["sublevel"] = 1;
                ["x"] = 483.53047972331;
                ["y"] = -180.78612370641;
                ["g"] = 20;
                ["infested"] = {
                    [1] = true;
                };
            };
            [27] = {
                ["y"] = -300.58567088849;
                ["x"] = 551.67773067384;
                ["faction"] = 2;
                ["g"] = 71;
                ["sublevel"] = 1;
            };
            [14] = {
                ["y"] = -250.65116619044;
                ["x"] = 532.27750301453;
                ["faction"] = 2;
                ["g"] = 69;
                ["sublevel"] = 1;
            };
            [28] = {
                ["y"] = -292.6735879876;
                ["x"] = 562.11729557082;
                ["faction"] = 2;
                ["g"] = 71;
                ["sublevel"] = 1;
            };
            [23] = {
                ["y"] = -310.36589122076;
                ["x"] = 522.22719227815;
                ["faction"] = 2;
                ["g"] = 71;
                ["sublevel"] = 1;
            };
            [19] = {
                ["y"] = -253.17862460669;
                ["x"] = 546.67311643591;
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
        };
        ["id"] = 135258;
        ["spells"] = {
            [277564] = {};
            [209859] = {};
            [257168] = {};
            [277242] = {};
        };
        ["characteristics"] = {
            ["Taunt"] = true;
            ["Disorient"] = true;
            ["Sap"] = true;
            ["Root"] = true;
            ["Slow"] = true;
            ["Stun"] = true;
            ["Silence"] = true;
        };
        ["name"] = "Irontide Marauder";
        ["health"] = 58864;
        ["displayId"] = 79068;
        ["creatureType"] = "Humanoid";
        ["level"] = 120;
        ["count"] = 1;
        ["scale"] = 0.5;
    };
    [16] = {
        ["clones"] = {
            [6] = {
                ["y"] = -353.68238246198;
                ["x"] = 442.30890109985;
                ["patrol"] = {};
                ["teeming"] = true;
                ["g"] = 46;
                ["sublevel"] = 1;
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
                ["y"] = -420.82814705587;
                ["g"] = 43;
                ["infested"] = {};
            };
            [1] = {
                ["y"] = -206.5357810425;
                ["x"] = 484.90910033886;
                ["patrol"] = {
                    [6] = {
                        ["y"] = -195.80850673069;
                        ["x"] = 487.63639357109;
                    };
                    [2] = {
                        ["y"] = -216.35396801396;
                        ["x"] = 482.1818383178;
                    };
                    [3] = {
                        ["y"] = -206.5357810425;
                        ["x"] = 484.90910033886;
                    };
                    [1] = {
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
                };
                ["infested"] = {
                    [3] = true;
                };
                ["g"] = 22;
                ["sublevel"] = 1;
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
                    [7] = {
                        ["y"] = -359.5298443486;
                        ["x"] = 447.6110722953;
                    };
                    [1] = {
                        ["y"] = -351.35677964077;
                        ["x"] = 438.5879804993;
                    };
                    [2] = {
                        ["y"] = -356.75260411944;
                        ["x"] = 432.00416104678;
                    };
                    [4] = {
                        ["y"] = -373.09147778937;
                        ["x"] = 429.66587855166;
                    };
                    [8] = {
                        ["y"] = -351.85861087917;
                        ["x"] = 450.76176324408;
                    };
                    [9] = {
                        ["y"] = -346.51615741539;
                        ["x"] = 446.10422674802;
                    };
                    [5] = {
                        ["y"] = -377.61203206765;
                        ["x"] = 436.24122488478;
                    };
                    [10] = {
                        ["y"] = -351.03669405723;
                        ["x"] = 438.56997549637;
                    };
                    [3] = {
                        ["y"] = -364.32436306244;
                        ["x"] = 429.52889045506;
                    };
                    [6] = {
                        ["y"] = -368.8449114619;
                        ["x"] = 441.99464263833;
                    };
                };
                ["teeming"] = true;
                ["g"] = 46;
                ["sublevel"] = 1;
            };
        };
        ["id"] = 128969;
        ["spells"] = {
            [277564] = {};
            [209859] = {};
            [275826] = {};
            [272874] = {};
        };
        ["characteristics"] = {
            ["Taunt"] = true;
        };
        ["name"] = "Ashvane Commander";
        ["health"] = 470912;
        ["displayId"] = 84067;
        ["creatureType"] = "Humanoid";
        ["level"] = 121;
        ["count"] = 8;
        ["scale"] = 0.8;
    };
    [20] = {
        ["clones"] = {
            [1] = {
                ["y"] = -334.97398415096;
                ["x"] = 464.39940921938;
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
                ["y"] = -343.12820931692;
                ["x"] = 464.78679119468;
                ["g"] = 34;
                ["sublevel"] = 1;
            };
        };
        ["scale"] = 0.7;
        ["spells"] = {
            [268230] = {};
            [209859] = {};
        };
        ["characteristics"] = {
            ["Disorient"] = true;
            ["Root"] = true;
            ["Slow"] = true;
            ["Stun"] = true;
            ["Fear"] = true;
        };
        ["health"] = 294320;
        ["count"] = 4;
        ["displayId"] = 84385;
        ["creatureType"] = "Humanoid";
        ["level"] = 120;
        ["name"] = "Ashvane Deckhand";
        ["id"] = 138464;
    };
    [24] = {
        ["clones"] = {
            [1] = {
                ["sublevel"] = 1;
                ["x"] = 450.55299996036;
                ["patrol"] = {
                    [6] = {
                        ["y"] = -383.88226492827;
                        ["x"] = 455.96283700982;
                    };
                    [2] = {
                        ["y"] = -393.88227015803;
                        ["x"] = 444.97924039355;
                    };
                    [3] = {
                        ["y"] = -392.5707985603;
                        ["x"] = 437.76610087659;
                    };
                    [1] = {
                        ["y"] = -389.12817242508;
                        ["x"] = 450.55299996036;
                    };
                    [4] = {
                        ["y"] = -393.88227015803;
                        ["x"] = 444.97924039355;
                    };
                    [5] = {
                        ["y"] = -389.12817242508;
                        ["x"] = 450.55299996036;
                    };
                };
                ["y"] = -389.12817242508;
                ["infested"] = {
                    [3] = true;
                };
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
                    [4] = {
                        ["y"] = -373.8887234672;
                        ["x"] = 481.78474522705;
                    };
                    [3] = {
                        ["y"] = -386.07622296254;
                        ["x"] = 477.25351604706;
                    };
                };
                ["y"] = -365.76373721469;
                ["infested"] = {
                    [3] = true;
                };
            };
            [3] = {
                ["y"] = -407.28829763634;
                ["x"] = 470.43535125076;
                ["patrol"] = {
                    [6] = {
                        ["y"] = -412.60799802554;
                        ["x"] = 460.92992483847;
                    };
                    [2] = {
                        ["y"] = -402.07699177342;
                        ["x"] = 474.4286536529;
                    };
                    [8] = {
                        ["y"] = -412.60799802554;
                        ["x"] = 460.92992483847;
                    };
                    [3] = {
                        ["y"] = -392.29438311184;
                        ["x"] = 477.90690497361;
                    };
                    [1] = {
                        ["y"] = -407.28829763634;
                        ["x"] = 470.43535125076;
                    };
                    [4] = {
                        ["y"] = -402.07699177342;
                        ["x"] = 474.4286536529;
                    };
                    [5] = {
                        ["y"] = -407.28829763634;
                        ["x"] = 470.43535125076;
                    };
                    [7] = {
                        ["y"] = -416.61778152477;
                        ["x"] = 457.70648170604;
                    };
                };
                ["sublevel"] = 1;
            };
        };
        ["scale"] = 1;
        ["spells"] = {
            [277564] = {};
            [257169] = {};
            [272713] = {};
            [209859] = {};
        };
        ["characteristics"] = {
            ["Taunt"] = true;
        };
        ["name"] = "Bilge Rat Demolisher";
        ["health"] = 588640;
        ["displayId"] = 68059;
        ["creatureType"] = "Humanoid";
        ["level"] = 121;
        ["count"] = 8;
        ["id"] = 135245;
    };
    [28] = {
        ["clones"] = {
            [6] = {
                ["y"] = -444.21880571055;
                ["x"] = 378.76849021377;
                ["g"] = 42;
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
            [1] = {
                ["y"] = -413.16388070323;
                ["x"] = 432.44783423805;
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
                ["y"] = -440.74941557682;
                ["g"] = 42;
                ["infested"] = {
                    [1] = true;
                };
            };
            [7] = {
                ["y"] = -436.83537207088;
                ["x"] = 422.88587760339;
                ["g"] = 44;
                ["sublevel"] = 1;
            };
        };
        ["scale"] = 0.7;
        ["spells"] = {
            [277564] = {};
            [272542] = {};
            [277242] = {};
            [272528] = {};
            [209859] = {};
        };
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
        ["count"] = 4;
        ["name"] = "Ashvane Sniper";
        ["displayId"] = 82843;
        ["creatureType"] = "Humanoid";
        ["level"] = 120;
        ["health"] = 294320;
        ["id"] = 128967;
    };
    [32] = {
        ["clones"] = {
            [1] = {
                ["y"] = -522.25717126126;
                ["x"] = 433.79490519834;
                ["sublevel"] = 1;
            };
        };
        ["scale"] = 1;
        ["characteristics"] = {
            ["Taunt"] = true;
        };
        ["spells"] = {
            [274991] = {};
            [269456] = {};
            [269484] = {};
            [277535] = {};
            [270484] = {};
            [270185] = {};
            [270187] = {};
            [275014] = {};
        };
        ["isBoss"] = true;
        ["encounterID"] = 2140;
        ["instanceID"] = 1023;
        ["id"] = 128652;
        ["count"] = 0;
        ["displayId"] = 87990;
        ["creatureType"] = "Aberration";
        ["level"] = 122;
        ["health"] = 2943200;
        ["name"] = "Viq'Goth";
    };
    [40] = {
        ["clones"] = {
            [27] = {
                ["sublevel"] = 1;
                ["x"] = 613.5888446317;
                ["faction"] = 2;
                ["g"] = 68;
                ["y"] = -90.200951057323;
            };
            [2] = {
                ["sublevel"] = 1;
                ["x"] = 625.42493453893;
                ["faction"] = 2;
                ["infested"] = {
                    [2] = true;
                };
                ["g"] = 47;
                ["y"] = -81.779556146624;
            };
            [38] = {
                ["sublevel"] = 1;
                ["x"] = 616.21534781615;
                ["faction"] = 2;
                ["g"] = 66;
                ["y"] = -87.123302211282;
            };
            [3] = {
                ["sublevel"] = 1;
                ["x"] = 615.12758440249;
                ["faction"] = 2;
                ["g"] = 48;
                ["y"] = -72.572034403379;
            };
            [4] = {
                ["sublevel"] = 1;
                ["x"] = 582.76168099314;
                ["faction"] = 2;
                ["g"] = 50;
                ["y"] = -95.668854490827;
            };
            [5] = {
                ["sublevel"] = 1;
                ["x"] = 586.87127712888;
                ["faction"] = 2;
                ["g"] = 50;
                ["y"] = -90.052412709371;
            };
            [6] = {
                ["sublevel"] = 1;
                ["x"] = 590.43289732721;
                ["faction"] = 2;
                ["g"] = 50;
                ["y"] = -91.833240444975;
            };
            [7] = {
                ["sublevel"] = 1;
                ["x"] = 588.65207547042;
                ["faction"] = 2;
                ["g"] = 50;
                ["y"] = -97.449676347618;
            };
            [8] = {
                ["sublevel"] = 1;
                ["x"] = 550.71901535146;
                ["faction"] = 2;
                ["g"] = 51;
                ["y"] = -108.37487597956;
            };
            [10] = {
                ["sublevel"] = 1;
                ["x"] = 540.43043741714;
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
            [14] = {
                ["sublevel"] = 1;
                ["x"] = 487.211754679;
                ["faction"] = 2;
                ["g"] = 59;
                ["y"] = -139.34256035327;
            };
            [16] = {
                ["sublevel"] = 1;
                ["x"] = 485.57538484003;
                ["faction"] = 2;
                ["g"] = 59;
                ["y"] = -134.97894386236;
            };
            [20] = {
                ["sublevel"] = 1;
                ["x"] = 502.96326718051;
                ["faction"] = 2;
                ["g"] = 60;
                ["y"] = -154.58752461621;
            };
            [24] = {
                ["sublevel"] = 1;
                ["x"] = 580.88168804981;
                ["faction"] = 2;
                ["g"] = 62;
                ["y"] = -101.22626502398;
            };
            [28] = {
                ["sublevel"] = 1;
                ["x"] = 615.25659662723;
                ["faction"] = 2;
                ["g"] = 68;
                ["y"] = -93.530203171836;
            };
            [32] = {
                ["sublevel"] = 1;
                ["x"] = 616.18556282708;
                ["faction"] = 2;
                ["g"] = 63;
                ["y"] = -104.33210976861;
            };
            [33] = {
                ["sublevel"] = 1;
                ["x"] = 614.58555054436;
                ["faction"] = 2;
                ["g"] = 63;
                ["y"] = -100.83211562309;
            };
            [17] = {
                ["sublevel"] = 1;
                ["x"] = 496.84812189673;
                ["faction"] = 2;
                ["g"] = 59;
                ["y"] = -141.52436079593;
            };
            [21] = {
                ["sublevel"] = 1;
                ["x"] = 509.19282986851;
                ["faction"] = 2;
                ["g"] = 60;
                ["y"] = -157.86620034917;
            };
            [25] = {
                ["sublevel"] = 1;
                ["x"] = 581.21135325821;
                ["faction"] = 2;
                ["g"] = 62;
                ["y"] = -104.96252573884;
            };
            [29] = {
                ["sublevel"] = 1;
                ["x"] = 613.34410968491;
                ["faction"] = 2;
                ["g"] = 68;
                ["y"] = -95.709532449574;
            };
            [34] = {
                ["sublevel"] = 1;
                ["x"] = 608.48555682419;
                ["faction"] = 2;
                ["g"] = 63;
                ["y"] = -102.0321141063;
            };
            [9] = {
                ["sublevel"] = 1;
                ["x"] = 556.03570467322;
                ["faction"] = 2;
                ["g"] = 51;
                ["y"] = -116.06204085406;
            };
            [11] = {
                ["sublevel"] = 1;
                ["x"] = 543.19358647764;
                ["faction"] = 2;
                ["g"] = 52;
                ["y"] = -124.17089573892;
            };
            [13] = {
                ["sublevel"] = 1;
                ["x"] = 514.06483232557;
                ["faction"] = 2;
                ["g"] = 53;
                ["y"] = -102.58903540268;
            };
            [15] = {
                ["sublevel"] = 1;
                ["x"] = 491.39358177612;
                ["faction"] = 2;
                ["g"] = 59;
                ["y"] = -140.61528117955;
            };
            [18] = {
                ["sublevel"] = 1;
                ["x"] = 508.37310465286;
                ["faction"] = 2;
                ["g"] = 60;
                ["y"] = -145.24326500783;
            };
            [22] = {
                ["sublevel"] = 1;
                ["x"] = 558.56117302015;
                ["faction"] = 2;
                ["g"] = 61;
                ["y"] = -89.738232694182;
            };
            [26] = {
                ["sublevel"] = 1;
                ["x"] = 578.46413061228;
                ["faction"] = 2;
                ["g"] = 62;
                ["y"] = -108.69879588565;
            };
            [30] = {
                ["sublevel"] = 1;
                ["x"] = 614.3855565192;
                ["faction"] = 2;
                ["g"] = 63;
                ["y"] = -108.03210652236;
            };
            [36] = {
                ["sublevel"] = 1;
                ["x"] = 603.52167696453;
                ["faction"] = 2;
                ["g"] = 65;
                ["y"] = -87.597628085377;
            };
            [37] = {
                ["sublevel"] = 1;
                ["x"] = 606.41424102749;
                ["faction"] = 2;
                ["infested"] = {
                    [3] = true;
                };
                ["g"] = 65;
                ["y"] = -86.523244614334;
            };
            [31] = {
                ["sublevel"] = 1;
                ["x"] = 609.38558572733;
                ["faction"] = 2;
                ["g"] = 63;
                ["y"] = -108.03211510542;
            };
            [35] = {
                ["sublevel"] = 1;
                ["x"] = 600.01391255356;
                ["faction"] = 2;
                ["g"] = 64;
                ["y"] = -100.17678467374;
            };
            [1] = {
                ["y"] = -85.663335851963;
                ["x"] = 629.52555847793;
                ["faction"] = 2;
                ["g"] = 47;
                ["sublevel"] = 1;
            };
            [19] = {
                ["sublevel"] = 1;
                ["x"] = 502.30754891864;
                ["faction"] = 2;
                ["g"] = 60;
                ["y"] = -146.22685647123;
            };
            [23] = {
                ["sublevel"] = 1;
                ["x"] = 557.14939991388;
                ["faction"] = 2;
                ["g"] = 61;
                ["y"] = -94.208813871612;
            };
            [39] = {
                ["sublevel"] = 1;
                ["x"] = 618.60970268002;
                ["faction"] = 2;
                ["g"] = 66;
                ["y"] = -88.954287637858;
            };
        };
        ["id"] = 133990;
        ["health"] = 58867;
        ["count"] = 1;
        ["displayId"] = 83892;
        ["creatureType"] = "Humanoid";
        ["level"] = 120;
        ["scale"] = 0.5;
        ["name"] = "Scrimshaw Gutter";
    };
    [33] = {
        ["clones"] = {
            [1] = {
                ["sublevel"] = 1;
                ["x"] = 489.87954568438;
                ["faction"] = 1;
                ["infested"] = {
                    [2] = true;
                };
                ["g"] = 13;
                ["y"] = -134.28998585695;
            };
        };
        ["id"] = 138019;
        ["spells"] = {
            [257292] = {};
            [277242] = {};
            [209859] = {};
        };
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
        ["count"] = 4;
        ["name"] = "Kul Tiran Vanguard";
        ["displayId"] = 84074;
        ["creatureType"] = "Humanoid";
        ["level"] = 121;
        ["health"] = 294335;
        ["scale"] = 0.7;
    };
    [41] = {
        ["clones"] = {
            [7] = {
                ["sublevel"] = 1;
                ["x"] = 611.26522370727;
                ["faction"] = 2;
                ["infested"] = {
                    [2] = true;
                };
                ["g"] = 68;
                ["y"] = -92.715276456211;
            };
            [1] = {
                ["sublevel"] = 1;
                ["x"] = 629.63617920356;
                ["faction"] = 2;
                ["g"] = 47;
                ["y"] = -80.366791089008;
            };
            [2] = {
                ["sublevel"] = 1;
                ["x"] = 612.23283393871;
                ["faction"] = 2;
                ["g"] = 48;
                ["y"] = -76.892462466845;
            };
            [4] = {
                ["sublevel"] = 1;
                ["x"] = 540.50309457737;
                ["faction"] = 2;
                ["g"] = 52;
                ["y"] = -119.82196527918;
            };
            [8] = {
                ["sublevel"] = 1;
                ["x"] = 612.11166982222;
                ["faction"] = 2;
                ["infested"] = {
                    [3] = true;
                };
                ["g"] = 63;
                ["y"] = -104.17900417954;
            };
            [9] = {
                ["sublevel"] = 1;
                ["x"] = 595.56948328715;
                ["faction"] = 2;
                ["g"] = 64;
                ["y"] = -99.287883561659;
            };
            [5] = {
                ["y"] = -108.73730732369;
                ["x"] = 517.47542274433;
                ["sublevel"] = 1;
                ["faction"] = 2;
            };
            [3] = {
                ["sublevel"] = 1;
                ["x"] = 586.61596209782;
                ["faction"] = 2;
                ["infested"] = {
                    [2] = true;
                };
                ["g"] = 50;
                ["y"] = -94.011135375926;
            };
            [6] = {
                ["sublevel"] = 1;
                ["x"] = 603.36452143634;
                ["patrol"] = {
                    [6] = {
                        ["y"] = -110.11910498962;
                        ["x"] = 594.65025564882;
                    };
                    [2] = {
                        ["y"] = -101.54767983709;
                        ["x"] = 605.2216765295;
                    };
                    [3] = {
                        ["y"] = -110.54766980994;
                        ["x"] = 602.65023856145;
                    };
                    [1] = {
                        ["y"] = -110.11910498962;
                        ["x"] = 603.36452143634;
                    };
                    [4] = {
                        ["y"] = -110.11910498962;
                        ["x"] = 594.79309015305;
                    };
                    [5] = {
                        ["y"] = -106.26196029906;
                        ["x"] = 583.93596347933;
                    };
                };
                ["faction"] = 2;
                ["infested"] = {
                    [3] = true;
                };
                ["y"] = -110.11910498962;
            };
        };
        ["id"] = 129374;
        ["health"] = 294335;
        ["count"] = 4;
        ["displayId"] = 86006;
        ["creatureType"] = "Humanoid";
        ["level"] = 120;
        ["scale"] = 0.7;
        ["name"] = "Scrimshaw Enforcer";
    };
    [17] = {
        ["clones"] = {
            [6] = {
                ["sublevel"] = 1;
                ["x"] = 554.37361696464;
                ["faction"] = 2;
                ["infested"] = {
                    [2] = true;
                    [3] = true;
                };
                ["g"] = 61;
                ["y"] = -88.242497399788;
            };
            [2] = {
                ["sublevel"] = 1;
                ["x"] = 489.4545682518;
                ["infested"] = {
                    [2] = true;
                };
                ["g"] = 22;
                ["y"] = -207.44487618564;
            };
            [3] = {
                ["y"] = -205.26305252377;
                ["x"] = 479.27275570754;
                ["g"] = 22;
                ["sublevel"] = 1;
            };
            [1] = {
                ["sublevel"] = 1;
                ["x"] = 484.17234770389;
                ["infested"] = {
                    [2] = true;
                };
                ["g"] = 21;
                ["y"] = -220.47957084003;
            };
            [4] = {
                ["y"] = -267.8728221379;
                ["x"] = 518.62532202863;
                ["g"] = 24;
                ["sublevel"] = 1;
            };
            [5] = {
                ["sublevel"] = 1;
                ["x"] = 514.65999618989;
                ["infested"] = {
                    [2] = true;
                };
                ["g"] = 33;
                ["y"] = -322.49513885932;
            };
            [7] = {
                ["sublevel"] = 1;
                ["x"] = 553.10087272999;
                ["faction"] = 2;
                ["g"] = 61;
                ["y"] = -91.515213669363;
            };
        };
        ["id"] = 137521;
        ["spells"] = {
            [257641] = {};
            [209859] = {};
            [277242] = {};
            [277564] = {};
        };
        ["characteristics"] = {
            ["Taunt"] = true;
            ["Incapacitate"] = true;
            ["Root"] = true;
            ["Polymorph"] = true;
            ["Disorient"] = true;
            ["Fear"] = true;
            ["Silence"] = true;
            ["Slow"] = true;
            ["Stun"] = true;
            ["Imprison"] = true;
        };
        ["name"] = "Irontide Powdershot";
        ["health"] = 58864;
        ["displayId"] = 85144;
        ["creatureType"] = "Humanoid";
        ["level"] = 120;
        ["count"] = 4;
        ["scale"] = 0.7;
    };
    [21] = {
        ["clones"] = {
            [1] = {
                ["sublevel"] = 1;
                ["x"] = 458.88216893754;
                ["y"] = -336.35329052182;
                ["g"] = 34;
                ["infested"] = {
                    [3] = true;
                };
            };
        };
        ["scale"] = 0.7;
        ["spells"] = {
            [209859] = {};
            [281388] = {};
            [268260] = {};
        };
        ["characteristics"] = {
            ["Taunt"] = true;
        };
        ["health"] = 294320;
        ["count"] = 4;
        ["displayId"] = 88542;
        ["creatureType"] = "Humanoid";
        ["level"] = 120;
        ["name"] = "Ashvane Cannoneer";
        ["id"] = 138465;
    };
    [25] = {
        ["clones"] = {
            [1] = {
                ["sublevel"] = 1;
                ["x"] = 445.79217228065;
                ["infested"] = {
                    [2] = true;
                };
                ["g"] = 35;
                ["y"] = -397.16114192187;
            };
            [2] = {
                ["sublevel"] = 1;
                ["x"] = 473.99733947372;
                ["infested"] = {
                    [2] = true;
                };
                ["g"] = 37;
                ["y"] = -385.69901189549;
            };
            [4] = {
                ["sublevel"] = 1;
                ["x"] = 456.37530835401;
                ["infested"] = {
                    [2] = true;
                };
                ["g"] = 39;
                ["y"] = -421.65313166251;
            };
            [3] = {
                ["sublevel"] = 1;
                ["x"] = 484.99568346729;
                ["infested"] = {
                    [1] = true;
                    [2] = true;
                    [3] = true;
                };
                ["g"] = 45;
                ["y"] = -369.78897033877;
            };
        };
        ["scale"] = 0.7;
        ["spells"] = {
            [277242] = {};
            [272834] = {};
            [209859] = {};
            [277564] = {};
            [272827] = {};
        };
        ["characteristics"] = {
            ["Taunt"] = true;
            ["Incapacitate"] = true;
            ["Root"] = true;
            ["Polymorph"] = true;
            ["Mind Control"] = true;
            ["Sap"] = true;
            ["Imprison"] = true;
            ["Stun"] = true;
            ["Slow"] = true;
            ["Disorient"] = true;
            ["Fear"] = true;
        };
        ["name"] = "Bilge Rat Pillager";
        ["health"] = 294320;
        ["displayId"] = 52277;
        ["creatureType"] = "Humanoid";
        ["level"] = 120;
        ["count"] = 4;
        ["id"] = 135241;
    };
    [29] = {
        ["clones"] = {
            [2] = {
                ["y"] = -422.40827992271;
                ["x"] = 398.22865812385;
                ["g"] = 43;
                ["sublevel"] = 1;
            };
            [3] = {
                ["sublevel"] = 1;
                ["x"] = 393.22867672236;
                ["infested"] = {
                    [3] = true;
                };
                ["g"] = 43;
                ["y"] = -425.408255889;
            };
            [1] = {
                ["y"] = -438.70859836629;
                ["x"] = 380.80929866607;
                ["g"] = 42;
                ["sublevel"] = 1;
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
        ["scale"] = 0.7;
        ["spells"] = {
            [275836] = {};
            [209859] = {};
            [275835] = {};
            [277564] = {};
        };
        ["characteristics"] = {
            ["Taunt"] = true;
            ["Incapacitate"] = true;
            ["Disorient"] = true;
            ["Silence"] = true;
            ["Root"] = true;
            ["Slow"] = true;
            ["Stun"] = true;
            ["Fear"] = true;
        };
        ["count"] = 4;
        ["name"] = "Ashvane Invader";
        ["displayId"] = 79889;
        ["creatureType"] = "Humanoid";
        ["level"] = 120;
        ["health"] = 294320;
        ["id"] = 137516;
    };
    [34] = {
        ["clones"] = {
            [7] = {
                ["sublevel"] = 1;
                ["x"] = 484.53809461745;
                ["faction"] = 1;
                ["g"] = 13;
                ["y"] = -136.11134043785;
            };
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
            [4] = {
                ["sublevel"] = 1;
                ["x"] = 497.27189948463;
                ["faction"] = 1;
                ["g"] = 13;
                ["y"] = -141.07537171561;
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
                ["y"] = -156.0062838611;
                ["g"] = 14;
                ["infested"] = {
                    [1] = true;
                };
            };
            [5] = {
                ["sublevel"] = 1;
                ["x"] = 492.45176731099;
                ["faction"] = 1;
                ["g"] = 13;
                ["y"] = -140.28399456647;
            };
            [10] = {
                ["sublevel"] = 1;
                ["x"] = 500.82957523727;
                ["faction"] = 1;
                ["g"] = 14;
                ["y"] = -149.20628530368;
            };
            [3] = {
                ["sublevel"] = 1;
                ["x"] = 514.66541432983;
                ["faction"] = 1;
                ["g"] = 10;
                ["y"] = -121.54310148864;
            };
            [6] = {
                ["sublevel"] = 1;
                ["x"] = 488.42298758703;
                ["faction"] = 1;
                ["g"] = 13;
                ["y"] = -139.20486860802;
            };
            [11] = {
                ["sublevel"] = 1;
                ["x"] = 508.32957863194;
                ["faction"] = 1;
                ["g"] = 14;
                ["y"] = -151.00629161156;
            };
        };
        ["id"] = 141282;
        ["spells"] = {
            [277564] = {};
            [209859] = {};
            [273930] = {};
            [277242] = {};
        };
        ["characteristics"] = {
            ["Taunt"] = true;
            ["Incapacitate"] = true;
            ["Root"] = true;
            ["Sap"] = true;
            ["Fear"] = true;
            ["Stun"] = true;
            ["Slow"] = true;
            ["Silence"] = true;
            ["Imprison"] = true;
        };
        ["name"] = "Kul Tiran Footman";
        ["health"] = 58867;
        ["displayId"] = 86025;
        ["creatureType"] = "Humanoid";
        ["level"] = 120;
        ["count"] = 1;
        ["scale"] = 0.5;
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
        ["count"] = 0;
        ["health"] = 1648276;
        ["displayId"] = 84821;
        ["creatureType"] = "Humanoid";
        ["level"] = 122;
        ["name"] = "Chopper Redhook";
        ["scale"] = 0.8;
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
                    [6] = {
                        ["y"] = -108.1933478963;
                        ["x"] = 510.66893829298;
                    };
                    [2] = {
                        ["y"] = -118.6996791931;
                        ["x"] = 518.01070909048;
                    };
                    [3] = {
                        ["y"] = -123.25663588204;
                        ["x"] = 523.96007826603;
                    };
                    [1] = {
                        ["y"] = -115.64361615773;
                        ["x"] = 514.09318497487;
                    };
                    [4] = {
                        ["y"] = -119.83891836534;
                        ["x"] = 527.6309690971;
                    };
                    [5] = {
                        ["y"] = -110.85157263151;
                        ["x"] = 522.31450876202;
                    };
                    [7] = {
                        ["y"] = -115.15537230305;
                        ["x"] = 513.70690941894;
                    };
                };
                ["faction"] = 2;
                ["infested"] = {
                    [2] = true;
                };
                ["g"] = 56;
                ["sublevel"] = 1;
            };
            [4] = {
                ["sublevel"] = 1;
                ["x"] = 505.91412599434;
                ["faction"] = 2;
                ["g"] = 60;
                ["y"] = -148.84981394232;
            };
            [3] = {
                ["y"] = -109.30460389054;
                ["x"] = 509.83375846379;
                ["patrol"] = {
                    [6] = {
                        ["y"] = -109.30461897796;
                        ["x"] = 509.97073057483;
                    };
                    [2] = {
                        ["y"] = -104.64708805649;
                        ["x"] = 511.06662366154;
                    };
                    [3] = {
                        ["y"] = -100.12653348292;
                        ["x"] = 507.09402738896;
                    };
                    [1] = {
                        ["y"] = -109.30460389054;
                        ["x"] = 509.83375846379;
                    };
                    [4] = {
                        ["y"] = -107.24981503127;
                        ["x"] = 499.83374009862;
                    };
                    [5] = {
                        ["y"] = -116.4278946475;
                        ["x"] = 503.94333623437;
                    };
                };
                ["faction"] = 2;
                ["infested"] = {
                    [3] = true;
                };
                ["g"] = 57;
                ["sublevel"] = 1;
            };
        };
        ["id"] = 129373;
        ["spells"] = {
            [277564] = {};
            [256986] = {};
            [257036] = {};
        };
        ["characteristics"] = {
            ["Taunt"] = true;
            ["Disorient"] = true;
            ["Root"] = true;
            ["Fear"] = true;
        };
        ["name"] = "Dockhound Packmaster";
        ["health"] = 294320;
        ["displayId"] = 84143;
        ["creatureType"] = "Humanoid";
        ["level"] = 120;
        ["count"] = 4;
        ["scale"] = 0.7;
    };
    [11] = {
        ["clones"] = {
            [6] = {
                ["sublevel"] = 1;
                ["x"] = 512.96332947438;
                ["faction"] = 2;
                ["g"] = 60;
                ["y"] = -151.14489117658;
            };
            [2] = {
                ["sublevel"] = 1;
                ["x"] = 551.42484025945;
                ["faction"] = 2;
                ["infested"] = {
                    [3] = true;
                };
                ["g"] = 51;
                ["y"] = -113.46100782736;
            };
            [3] = {
                ["sublevel"] = 1;
                ["x"] = 535.03567479994;
                ["faction"] = 2;
                ["infested"] = {
                    [2] = true;
                };
                ["g"] = 52;
                ["y"] = -118.77616417887;
            };
            [1] = {
                ["sublevel"] = 1;
                ["x"] = 473.14769665675;
                ["infested"] = {
                    [2] = true;
                };
                ["g"] = 17;
                ["y"] = -169.28172529054;
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
        };
        ["id"] = 129371;
        ["spells"] = {
            [257270] = {};
            [256866] = {};
            [256709] = {};
            [277242] = {};
        };
        ["characteristics"] = {
            ["Disorient"] = true;
            ["Root"] = true;
            ["Silence"] = true;
            ["Stun"] = true;
            ["Fear"] = true;
        };
        ["name"] = "Riptide Shredder";
        ["health"] = 294320;
        ["displayId"] = 86085;
        ["creatureType"] = "Humanoid";
        ["level"] = 120;
        ["count"] = 4;
        ["scale"] = 0.7;
    };
    [13] = {
        ["clones"] = {
            [6] = {
                ["sublevel"] = 1;
                ["x"] = 491.21178203991;
                ["faction"] = 2;
                ["infested"] = {
                    [3] = true;
                };
                ["g"] = 59;
                ["y"] = -135.1607642719;
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
                ["infested"] = {
                    [3] = true;
                };
                ["sublevel"] = 1;
            };
            [1] = {
                ["y"] = -164.50560717166;
                ["x"] = 468.22232284501;
                ["g"] = 17;
                ["sublevel"] = 1;
            };
            [4] = {
                ["sublevel"] = 1;
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
                    [4] = {
                        ["y"] = -90.293069155625;
                        ["x"] = 628.6327949566;
                    };
                    [3] = {
                        ["y"] = -84.139227423379;
                        ["x"] = 620.17124960584;
                    };
                };
                ["faction"] = 2;
                ["infested"] = {
                    [3] = true;
                };
                ["y"] = -84.116425391151;
            };
            [5] = {
                ["y"] = -87.414128133822;
                ["x"] = 569.86996550556;
                ["patrol"] = {
                    [6] = {
                        ["y"] = -86.517942348544;
                        ["x"] = 561.79341140767;
                    };
                    [2] = {
                        ["y"] = -89.63270258664;
                        ["x"] = 579.33438848966;
                    };
                    [3] = {
                        ["y"] = -87.173688751619;
                        ["x"] = 569.17045994803;
                    };
                    [1] = {
                        ["y"] = -87.414128133822;
                        ["x"] = 569.86996550556;
                    };
                    [4] = {
                        ["y"] = -86.517942348544;
                        ["x"] = 561.79341140767;
                    };
                    [5] = {
                        ["y"] = -82.747449777977;
                        ["x"] = 561.13766500459;
                    };
                    [7] = {
                        ["y"] = -87.337625352388;
                        ["x"] = 569.49834722018;
                    };
                };
                ["faction"] = 2;
                ["infested"] = {
                    [3] = true;
                };
                ["g"] = 50;
                ["sublevel"] = 1;
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
                    [4] = {
                        ["y"] = -94.539922036352;
                        ["x"] = 591.96288449159;
                    };
                    [3] = {
                        ["y"] = -86.015317956974;
                        ["x"] = 597.70059471696;
                    };
                };
                ["faction"] = 2;
                ["teeming"] = true;
                ["sublevel"] = 1;
            };
        };
        ["id"] = 129369;
        ["spells"] = {
            [275775] = {};
            [272662] = {};
            [257170] = {};
            [209859] = {};
            [277564] = {};
        };
        ["characteristics"] = {
            ["Taunt"] = true;
        };
        ["name"] = "Irontide Raider";
        ["health"] = 470912;
        ["displayId"] = 84134;
        ["creatureType"] = "Humanoid";
        ["level"] = 121;
        ["count"] = 8;
        ["scale"] = 0.7;
    };
    [15] = {
        ["clones"] = {
            [6] = {
                ["sublevel"] = 1;
                ["x"] = 595.45836111139;
                ["faction"] = 2;
                ["infested"] = {
                    [2] = true;
                };
                ["g"] = 64;
                ["y"] = -103.06566560425;
            };
            [2] = {
                ["sublevel"] = 1;
                ["x"] = 519.95185520218;
                ["infested"] = {
                    [2] = true;
                };
                ["g"] = 24;
                ["y"] = -263.30361658651;
            };
            [3] = {
                ["y"] = -315.91619008166;
                ["x"] = 511.89682471573;
                ["g"] = 33;
                ["sublevel"] = 1;
            };
            [1] = {
                ["y"] = -188.50199940652;
                ["x"] = 471.52332841602;
                ["g"] = 19;
                ["sublevel"] = 1;
            };
            [4] = {
                ["sublevel"] = 1;
                ["x"] = 617.93414560563;
                ["faction"] = 2;
                ["g"] = 48;
                ["y"] = -77.353710214649;
            };
            [5] = {
                ["sublevel"] = 1;
                ["x"] = 576.44349772987;
                ["faction"] = 2;
                ["infested"] = {
                    [2] = true;
                };
                ["g"] = 62;
                ["y"] = -103.73821922814;
            };
            [7] = {
                ["sublevel"] = 1;
                ["x"] = 600.98309032554;
                ["faction"] = 2;
                ["g"] = 65;
                ["y"] = -90.686818211602;
            };
        };
        ["id"] = 129370;
        ["spells"] = {
            [257063] = {};
            [277242] = {};
            [209859] = {};
            [277564] = {};
            [256957] = {};
            [257069] = {};
        };
        ["characteristics"] = {
            ["Taunt"] = true;
            ["Incapacitate"] = true;
            ["Disorient"] = true;
            ["Root"] = true;
            ["Slow"] = true;
            ["Stun"] = true;
            ["Silence"] = true;
        };
        ["name"] = "Irontide Waveshaper";
        ["health"] = 235455;
        ["displayId"] = 79077;
        ["creatureType"] = "Humanoid";
        ["level"] = 120;
        ["count"] = 4;
        ["scale"] = 0.7;
    };
    [18] = {
        ["clones"] = {
            [1] = {
                ["sublevel"] = 1;
                ["x"] = 498.83584773743;
                ["y"] = -259.64788169597;
                ["g"] = 23;
                ["infested"] = {
                    [3] = true;
                };
            };
            [2] = {
                ["y"] = -341.18087391862;
                ["x"] = 458.88216893754;
                ["g"] = 34;
                ["sublevel"] = 1;
            };
            [4] = {
                ["y"] = -309.83593075367;
                ["x"] = 512.58587693016;
                ["teeming"] = true;
                ["g"] = 33;
                ["sublevel"] = 1;
            };
            [3] = {
                ["y"] = -419.76937675037;
                ["x"] = 432.90654005456;
                ["g"] = 41;
                ["sublevel"] = 1;
            };
        };
        ["id"] = 138255;
        ["spells"] = {
            [272471] = {};
            [272421] = {};
            [209859] = {};
            [272418] = {};
            [272422] = {};
        };
        ["characteristics"] = {
            ["Root"] = true;
            ["Slow"] = true;
            ["Taunt"] = true;
        };
        ["count"] = 4;
        ["name"] = "Ashvane Spotter";
        ["displayId"] = 86436;
        ["creatureType"] = "Humanoid";
        ["level"] = 121;
        ["health"] = 294320;
        ["scale"] = 0.7;
    };
    [22] = {
        ["clones"] = {
            [1] = {
                ["y"] = -332.71826679518;
                ["x"] = 445.55283973782;
                ["sublevel"] = 1;
            };
        };
        ["health"] = 1442168;
        ["scale"] = 0.8;
        ["spells"] = {
            [269029] = {};
            [272471] = {};
            [280389] = {};
            [273470] = {};
        };
        ["isBoss"] = true;
        ["encounterID"] = 2173;
        ["instanceID"] = 1023;
        ["id"] = 129208;
        ["name"] = "Dread Captain Lockwood";
        ["displayId"] = 88579;
        ["creatureType"] = "Humanoid";
        ["level"] = 122;
        ["count"] = 0;
        ["characteristics"] = {
            ["Root"] = true;
            ["Slow"] = true;
            ["Taunt"] = true;
        };
    };
    [26] = {
        ["clones"] = {
            [1] = {
                ["y"] = -378.96425171327;
                ["x"] = 458.09399858262;
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
        ["scale"] = 0.7;
        ["spells"] = {
            [272571] = {};
            [277564] = {};
            [209859] = {};
            [277242] = {};
            [272581] = {};
            [274569] = {};
        };
        ["characteristics"] = {
            ["Taunt"] = true;
            ["Incapacitate"] = true;
            ["Disorient"] = true;
            ["Stun"] = true;
            ["Root"] = true;
            ["Slow"] = true;
            ["Silence"] = true;
            ["Fear"] = true;
        };
        ["name"] = "Bilge Rat Tempest";
        ["health"] = 235455;
        ["displayId"] = 80475;
        ["creatureType"] = "Humanoid";
        ["level"] = 120;
        ["count"] = 4;
        ["id"] = 129367;
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
                ["infested"] = {
                    [2] = true;
                };
                ["g"] = 44;
                ["y"] = -437.27014182419;
            };
        };
        ["scale"] = 0.7;
        ["spells"] = {
            [277564] = {};
            [272888] = {};
            [277242] = {};
            [209859] = {};
        };
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
        ["count"] = 4;
        ["name"] = "Ashvane Destroyer";
        ["displayId"] = 82852;
        ["creatureType"] = "Humanoid";
        ["level"] = 120;
        ["health"] = 294320;
        ["id"] = 137517;
    };
    [36] = {
        ["clones"] = {
            [6] = {
                ["y"] = -319.32516444756;
                ["x"] = 461.85593713013;
                ["sublevel"] = 1;
            };
            [2] = {
                ["y"] = -225.27273638926;
                ["x"] = 482.82224298751;
                ["g"] = 21;
                ["sublevel"] = 1;
            };
            [8] = {
                ["y"] = -354.51747202835;
                ["x"] = 469.93285260498;
                ["sublevel"] = 1;
            };
            [3] = {
                ["y"] = -222.50958185537;
                ["x"] = 478.48013735893;
                ["g"] = 21;
                ["sublevel"] = 1;
            };
            [1] = {
                ["y"] = -225.40431705884;
                ["x"] = 488.08539071613;
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
            [7] = {
                ["y"] = -351.24823883418;
                ["x"] = 463.77899023532;
                ["sublevel"] = 1;
            };
        };
        ["scale"] = 0.5;
        ["spells"] = {
            [277564] = {};
            [209859] = {};
            [257168] = {};
        };
        ["characteristics"] = {
            ["Taunt"] = true;
            ["Disorient"] = true;
            ["Silence"] = true;
            ["Root"] = true;
            ["Slow"] = true;
            ["Stun"] = true;
            ["Fear"] = true;
        };
        ["health"] = 58867;
        ["count"] = 1;
        ["displayId"] = 79068;
        ["creatureType"] = "Humanoid";
        ["level"] = 120;
        ["name"] = "Irontide Marauder";
        ["id"] = 138247;
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
        ["scale"] = 1;
        ["count"] = 0;
        ["name"] = "Irontide Powdershot";
        ["displayId"] = 85144;
        ["creatureType"] = "Humanoid";
        ["level"] = 120;
        ["id"] = 129928;
        ["health"] = 58867;
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
        ["scale"] = 1;
        ["count"] = 0;
        ["name"] = "Irontide Cleaver";
        ["displayId"] = 81286;
        ["creatureType"] = "Humanoid";
        ["level"] = 121;
        ["id"] = 129879;
        ["health"] = 294335;
    };
    [37] = {
        ["clones"] = {
            [1] = {
                ["y"] = -257.38301854863;
                ["x"] = 504.63481746092;
                ["g"] = 23;
                ["sublevel"] = 1;
            };
            [2] = {
                ["y"] = -261.73597132117;
                ["x"] = 493.81129769619;
                ["g"] = 23;
                ["sublevel"] = 1;
            };
            [4] = {
                ["y"] = -252.5594915702;
                ["x"] = 499.22306262742;
                ["g"] = 23;
                ["sublevel"] = 1;
            };
            [3] = {
                ["y"] = -255.03007683515;
                ["x"] = 494.39953060013;
                ["g"] = 23;
                ["sublevel"] = 1;
            };
        };
        ["scale"] = 0.7;
        ["spells"] = {
            [257641] = {};
            [209859] = {};
        };
        ["characteristics"] = {
            ["Stun"] = true;
            ["Slow"] = true;
            ["Disorient"] = true;
        };
        ["health"] = 58867;
        ["count"] = 1;
        ["displayId"] = 85144;
        ["creatureType"] = "Humanoid";
        ["level"] = 120;
        ["name"] = "Irontide Powdershot";
        ["id"] = 138254;
    };
    [35] = {
        ["clones"] = {
            [7] = {
                ["sublevel"] = 1;
                ["x"] = 526.30126212487;
                ["faction"] = 1;
                ["g"] = 9;
                ["y"] = -129.3192177209;
            };
            [1] = {
                ["sublevel"] = 1;
                ["x"] = 541.54654993909;
                ["faction"] = 1;
                ["g"] = 4;
                ["y"] = -91.426095756203;
            };
            [2] = {
                ["sublevel"] = 1;
                ["x"] = 542.63404265353;
                ["faction"] = 1;
                ["g"] = 5;
                ["y"] = -103.51399918979;
            };
            [4] = {
                ["sublevel"] = 1;
                ["x"] = 531.86911310946;
                ["faction"] = 1;
                ["g"] = 6;
                ["y"] = -108.11307298499;
            };
            [8] = {
                ["sublevel"] = 1;
                ["x"] = 530.35786204019;
                ["faction"] = 1;
                ["g"] = 9;
                ["y"] = -126.48903267501;
            };
            [9] = {
                ["sublevel"] = 1;
                ["x"] = 500.29587275309;
                ["faction"] = 1;
                ["g"] = 11;
                ["y"] = -127.67949622155;
            };
            [5] = {
                ["sublevel"] = 1;
                ["x"] = 520.36252691696;
                ["faction"] = 1;
                ["g"] = 7;
                ["y"] = -100.10166381043;
            };
            [10] = {
                ["sublevel"] = 1;
                ["x"] = 490.16460146767;
                ["faction"] = 1;
                ["g"] = 12;
                ["y"] = -127.74441934984;
            };
            [3] = {
                ["sublevel"] = 1;
                ["x"] = 534.06690631731;
                ["faction"] = 1;
                ["g"] = 6;
                ["y"] = -111.29988539789;
            };
            [6] = {
                ["sublevel"] = 1;
                ["x"] = 516.73635955827;
                ["faction"] = 1;
                ["g"] = 8;
                ["y"] = -112.73097762966;
            };
        };
        ["id"] = 141565;
        ["spells"] = {
            [277564] = {};
            [209859] = {};
            [273930] = {};
        };
        ["characteristics"] = {
            ["Taunt"] = true;
            ["Stun"] = true;
            ["Silence"] = true;
            ["Slow"] = true;
            ["Root"] = true;
            ["Fear"] = true;
        };
        ["name"] = "Kul Tiran Footman";
        ["health"] = 58867;
        ["displayId"] = 86025;
        ["creatureType"] = "Humanoid";
        ["level"] = 120;
        ["count"] = 1;
        ["scale"] = 0.5;
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
                    [4] = {
                        ["y"] = -440.15053816504;
                        ["x"] = 420.06622150584;
                    };
                    [3] = {
                        ["y"] = -419.90056628214;
                        ["x"] = 409.31622716037;
                    };
                };
                ["sublevel"] = 1;
            };
        };
        ["health"] = 2060240;
        ["scale"] = 1;
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
        ["id"] = 128651;
        ["name"] = "Hadal Darkfathom";
        ["displayId"] = 67541;
        ["creatureType"] = "Giant";
        ["level"] = 122;
        ["count"] = 0;
        ["characteristics"] = {
            ["Taunt"] = true;
        };
    };
    [1] = {
        ["clones"] = {
            [2] = {
                ["sublevel"] = 1;
                ["x"] = 603.77923440022;
                ["patrol"] = {
                    [6] = {
                        ["y"] = -111.12685825223;
                        ["x"] = 599.19296247123;
                    };
                    [2] = {
                        ["y"] = -108.10053673243;
                        ["x"] = 605.50874426297;
                    };
                    [8] = {
                        ["y"] = -111.12685825223;
                        ["x"] = 599.19296247123;
                    };
                    [3] = {
                        ["y"] = -102.70581962774;
                        ["x"] = 606.16664761087;
                    };
                    [1] = {
                        ["y"] = -110.15644771174;
                        ["x"] = 603.77923440022;
                    };
                    [4] = {
                        ["y"] = -108.10053673243;
                        ["x"] = 605.50874426297;
                    };
                    [5] = {
                        ["y"] = -108.10053673243;
                        ["x"] = 605.50874426297;
                    };
                    [7] = {
                        ["y"] = -107.73892927049;
                        ["x"] = 583.88643955623;
                    };
                };
                ["faction"] = 1;
                ["infested"] = {
                    [3] = true;
                };
                ["y"] = -110.15644771174;
            };
            [3] = {
                ["sublevel"] = 1;
                ["x"] = 504.88057117788;
                ["faction"] = 1;
                ["infested"] = {
                    [3] = true;
                };
                ["g"] = 10;
                ["y"] = -115.38505847239;
            };
            [1] = {
                ["sublevel"] = 1;
                ["x"] = 611.53324048298;
                ["faction"] = 1;
                ["infested"] = {
                    [2] = true;
                };
                ["g"] = 1;
                ["y"] = -94.74910945841;
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
        };
        ["scale"] = 0.7;
        ["spells"] = {
            [277564] = {};
            [209859] = {};
            [277242] = {};
            [256627] = {};
        };
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
        ["health"] = 294320;
        ["count"] = 4;
        ["displayId"] = 84074;
        ["creatureType"] = "Humanoid";
        ["level"] = 120;
        ["name"] = "Kul Tiran Halberd";
        ["id"] = 141283;
    };
    [19] = {
        ["clones"] = {
            [13] = {
                ["sublevel"] = 1;
                ["x"] = 527.67608951888;
                ["faction"] = 1;
                ["g"] = 31;
                ["y"] = -303.16501314177;
            };
            [7] = {
                ["sublevel"] = 1;
                ["x"] = 538.37345459444;
                ["faction"] = 1;
                ["g"] = 25;
                ["y"] = -253.72255583275;
            };
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
            [4] = {
                ["sublevel"] = 1;
                ["x"] = 541.91775040591;
                ["faction"] = 1;
                ["g"] = 25;
                ["y"] = -259.41876221475;
            };
            [8] = {
                ["sublevel"] = 1;
                ["x"] = 514.64882686269;
                ["faction"] = 1;
                ["g"] = 26;
                ["y"] = -279.45366833983;
            };
            [14] = {
                ["sublevel"] = 1;
                ["x"] = 531.79896548866;
                ["faction"] = 1;
                ["g"] = 31;
                ["y"] = -312.70085465845;
            };
            [9] = {
                ["sublevel"] = 1;
                ["x"] = 520.19610143157;
                ["faction"] = 1;
                ["g"] = 27;
                ["y"] = -287.10623356988;
            };
            [5] = {
                ["sublevel"] = 1;
                ["x"] = 532.03960504283;
                ["faction"] = 1;
                ["g"] = 25;
                ["y"] = -262.3175236157;
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
            [3] = {
                ["sublevel"] = 1;
                ["x"] = 546.72788555121;
                ["faction"] = 1;
                ["g"] = 25;
                ["y"] = -253.59597733169;
            };
            [6] = {
                ["sublevel"] = 1;
                ["x"] = 532.33370139834;
                ["faction"] = 1;
                ["g"] = 25;
                ["y"] = -254.67045037523;
            };
            [12] = {
                ["sublevel"] = 1;
                ["x"] = 536.34527281636;
                ["faction"] = 1;
                ["g"] = 30;
                ["y"] = -304.20748815733;
            };
            [15] = {
                ["sublevel"] = 1;
                ["x"] = 520.58250449269;
                ["faction"] = 1;
                ["g"] = 32;
                ["y"] = -304.72909004106;
            };
        };
        ["scale"] = 0.5;
        ["spells"] = {
            [277564] = {};
            [209859] = {};
            [273930] = {};
        };
        ["characteristics"] = {
            ["Taunt"] = true;
            ["Stun"] = true;
            ["Silence"] = true;
            ["Slow"] = true;
            ["Root"] = true;
            ["Fear"] = true;
        };
        ["name"] = "Kul Tiran Footman";
        ["health"] = 58864;
        ["displayId"] = 86025;
        ["creatureType"] = "Humanoid";
        ["level"] = 120;
        ["count"] = 1;
        ["id"] = 141565;
    };
    [23] = {
        ["clones"] = {
            [13] = {
                ["sublevel"] = 1;
                ["x"] = 452.93573232766;
                ["y"] = -426.27390498037;
                ["g"] = 39;
                ["infested"] = {
                    [1] = true;
                };
            };
            [7] = {
                ["sublevel"] = 1;
                ["x"] = 486.81382693685;
                ["y"] = -365.97079258537;
                ["g"] = 45;
                ["infested"] = {};
            };
            [1] = {
                ["y"] = -399.30399653134;
                ["x"] = 450.9350356049;
                ["g"] = 35;
                ["sublevel"] = 1;
            };
            [2] = {
                ["y"] = -392.01832356905;
                ["x"] = 455.50646053809;
                ["sublevel"] = 1;
            };
            [15] = {
                ["y"] = -405.54915579598;
                ["x"] = 464.00056711768;
                ["g"] = 40;
                ["sublevel"] = 1;
            };
            [8] = {
                ["y"] = -387.07342135317;
                ["x"] = 485.68495957621;
                ["sublevel"] = 1;
                ["infested"] = {
                    [1] = true;
                };
            };
            [4] = {
                ["y"] = -380.93145559221;
                ["x"] = 453.50383040232;
                ["g"] = 36;
                ["sublevel"] = 1;
            };
            [9] = {
                ["y"] = -388.56596547125;
                ["x"] = 492.55064458462;
                ["sublevel"] = 1;
            };
            [5] = {
                ["y"] = -389.28109728202;
                ["x"] = 471.45999269505;
                ["g"] = 37;
                ["sublevel"] = 1;
            };
            [10] = {
                ["y"] = -394.55660128523;
                ["x"] = 489.29848245284;
                ["g"] = 38;
                ["sublevel"] = 1;
            };
            [3] = {
                ["sublevel"] = 1;
                ["x"] = 459.40546314504;
                ["y"] = -383.06259605911;
                ["g"] = 36;
                ["infested"] = {
                    [1] = true;
                };
            };
            [11] = {
                ["y"] = -402.07594876398;
                ["x"] = 476.854409421;
                ["infested"] = {
                    [2] = true;
                };
                ["sublevel"] = 1;
            };
            [6] = {
                ["y"] = -384.20647418269;
                ["x"] = 469.81820569465;
                ["g"] = 37;
                ["sublevel"] = 1;
            };
            [12] = {
                ["y"] = -425.89415861255;
                ["x"] = 457.74586747296;
                ["g"] = 39;
                ["sublevel"] = 1;
            };
            [14] = {
                ["sublevel"] = 1;
                ["x"] = 461.40441545586;
                ["y"] = -402.4909626023;
                ["g"] = 40;
                ["infested"] = {};
            };
        };
        ["scale"] = 0.7;
        ["spells"] = {
            [277242] = {};
            [274941] = {};
            [209859] = {};
            [272546] = {};
            [277564] = {};
        };
        ["characteristics"] = {
            ["Taunt"] = true;
            ["Incapacitate"] = true;
            ["Root"] = true;
            ["Polymorph"] = true;
            ["Disorient"] = true;
            ["Sap"] = true;
            ["Imprison"] = true;
            ["Silence"] = true;
            ["Slow"] = true;
            ["Stun"] = true;
            ["Fear"] = true;
        };
        ["name"] = "Bilge Rat Buccaneer";
        ["health"] = 294320;
        ["displayId"] = 81424;
        ["creatureType"] = "Humanoid";
        ["level"] = 120;
        ["count"] = 4;
        ["id"] = 129366;
    };
    [39] = {
        ["clones"] = {
            [6] = {
                ["y"] = -122.90677710877;
                ["x"] = 492.19683975771;
                ["sublevel"] = 1;
                ["faction"] = 2;
            };
            [2] = {
                ["y"] = -112.0502018098;
                ["x"] = 633.10342590036;
                ["sublevel"] = 1;
                ["faction"] = 2;
            };
            [8] = {
                ["y"] = -108.25354459495;
                ["x"] = 590.9242170708;
                ["sublevel"] = 1;
                ["faction"] = 2;
            };
            [3] = {
                ["y"] = -104.6270537696;
                ["x"] = 635.8684261482;
                ["sublevel"] = 1;
                ["faction"] = 2;
            };
            [1] = {
                ["y"] = -114.74007442758;
                ["x"] = 624.14510461474;
                ["sublevel"] = 1;
                ["faction"] = 2;
            };
            [4] = {
                ["y"] = -108.18081779719;
                ["x"] = 643.91349274231;
                ["sublevel"] = 1;
                ["faction"] = 2;
            };
            [5] = {
                ["y"] = -119.88155209792;
                ["x"] = 500.85843247669;
                ["sublevel"] = 1;
                ["faction"] = 2;
            };
            [7] = {
                ["y"] = -103.04576615629;
                ["x"] = 588.38221337161;
                ["sublevel"] = 1;
                ["faction"] = 2;
            };
        };
        ["id"] = 138002;
        ["health"] = 58867;
        ["count"] = 0;
        ["displayId"] = 83892;
        ["creatureType"] = "Humanoid";
        ["level"] = 120;
        ["scale"] = 0.5;
        ["name"] = "Scrimshaw Gutter";
    };
};












































