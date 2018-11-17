local dungeonIndex = 16

MethodDungeonTools.scaleMultiplier[dungeonIndex] = 0.6

MethodDungeonTools.dungeonTotalCount[dungeonIndex] = {normal=261,teeming=313,teemingEnabled=true}

local selectorGroup
local AceGUI = LibStub("AceGUI-3.0")
local db
local function fixFreeholdShowHide(widget,frame,isFrame)
    frame = frame or MethodDungeonTools.main_frame
    local originalShow,originalHide = frame.Show,frame.Hide
    if not isFrame then
        widget = widget.frame
    end
    function frame:Show(...)
        if db.currentDungeonIdx == 16 then
            widget:Show()
        end
        return originalShow(self, ...);
    end
    function frame:Hide(...)
        widget:Hide()
        return originalHide(self, ...);
    end
end

function MethodDungeonTools:ToggleFreeholdSelector(show)
    db = MethodDungeonTools:GetDB()
    if not selectorGroup then
        selectorGroup = AceGUI:Create("SimpleGroup")
        selectorGroup.frame:SetFrameStrata("HIGH")
        selectorGroup.frame:SetFrameLevel(50)
        selectorGroup.frame:SetBackdropColor(unpack(MethodDungeonTools.BackdropColor))
        fixFreeholdShowHide(selectorGroup)
        selectorGroup:SetLayout("Flow")
        selectorGroup.frame.bg = selectorGroup.frame:CreateTexture(nil, "BACKGROUND")
        selectorGroup.frame.bg:SetAllPoints(selectorGroup.frame)
        selectorGroup.frame.bg:SetColorTexture(unpack(MethodDungeonTools.BackdropColor))
        selectorGroup:SetWidth(120)
        selectorGroup:SetHeight(90)
        selectorGroup.frame:SetPoint("TOPRIGHT",MethodDungeonTools.main_frame,"TOPRIGHT",0,0)

    end
    MethodDungeonTools:UpdateFreeholdSelector(MethodDungeonTools:GetCurrentPreset().week)
    if show then
        selectorGroup.frame:Show()
        MethodDungeonTools:DungeonEnemies_UpdateFreeholdCrew(MethodDungeonTools:GetCurrentPreset().freeholdCrew)
        MethodDungeonTools:ReloadPullButtons()
        MethodDungeonTools:UpdateProgressbar()
    else
        selectorGroup.frame:Hide()
        MethodDungeonTools:DungeonEnemies_UpdateFreeholdCrew()
    end
end

function MethodDungeonTools:UpdateFreeholdSelector(week)
    if not selectorGroup then return end
    week = week%3
    if week == 0 then week = 3 end
    selectorGroup:ReleaseChildren()
    MethodDungeonTools:GetCurrentPreset().freeholdCrew = (MethodDungeonTools:GetCurrentPreset().freeholdCrew and week) or nil
    local label = AceGUI:Create("Label")
    label:SetText("  Join Crew:")
    selectorGroup:AddChild(label)
    local check = AceGUI:Create("CheckBox")
    check:SetLabel((week==1 and "Blacktooth") or (week==3 and "Cutwater") or (week==2 and "Bilge Rats"))
    selectorGroup:AddChild(check)
    check:SetCallback("OnValueChanged",function(widget,callbackName,value)
        MethodDungeonTools:GetCurrentPreset().freeholdCrew = (value and week) or nil
        MethodDungeonTools:DungeonEnemies_UpdateFreeholdCrew(MethodDungeonTools:GetCurrentPreset().freeholdCrew)
        MethodDungeonTools:ReloadPullButtons()
        MethodDungeonTools:UpdateProgressbar()
    end)
    check:SetValue(MethodDungeonTools:GetCurrentPreset().freeholdCrew)
    MethodDungeonTools:DungeonEnemies_UpdateFreeholdCrew(MethodDungeonTools:GetCurrentPreset().freeholdCrew)
end

MethodDungeonTools.mapPOIs[dungeonIndex] = {
    [1] = {
        [1] = {
            ["y"] = -200.49488376925;
            ["x"] = 591.8001100269;
            ["template"] = "DeathReleasePinTemplate";
            ["graveyardDescription"] = "";
            ["type"] = "graveyard";
        };
        [2] = {
            ["y"] = -348.54647419431;
            ["x"] = 372.07463735;
            ["template"] = "DeathReleasePinTemplate";
            ["graveyardDescription"] = "Unlocks after defeating Council o' Captains.";
            ["type"] = "graveyard";
        };
        [3] = {
            ["y"] = -343.53532845441;
            ["x"] = 576.72706599388;
            ["template"] = "DeathReleasePinTemplate";
            ["graveyardDescription"] = "Unlocks after defeating Skycap'n Kragg.";
            ["type"] = "graveyard";
        };
    };
};



MethodDungeonTools.dungeonEnemies[dungeonIndex] = {
    [27] = {
        ["clones"] = {
            [1] = {
                ["sublevel"] = 1;
                ["x"] = 330.82048838571;
                ["y"] = -226.55082875808;
                ["g"] = 60;
                ["infested"] = {
                    [1] = true;
                };
            };
            [2] = {
                ["sublevel"] = 1;
                ["x"] = 339.76653577595;
                ["y"] = -210.0949972306;
                ["g"] = 61;
                ["infested"] = {
                    [2] = true;
                };
            };
            [4] = {
                ["y"] = -186.53721467679;
                ["x"] = 306.72725932014;
                ["g"] = 64;
                ["sublevel"] = 1;
            };
            [3] = {
                ["y"] = -197.68005864604;
                ["x"] = 315.01297198444;
                ["g"] = 64;
                ["sublevel"] = 1;
            };
        };
        ["id"] = 126919;
        ["spells"] = {
            [257736] = {};
            [257737] = {};
            [209859] = {};
            [277564] = {};
            [259092] = {};
            [277242] = {};
        };
        ["characteristics"] = {
            ["Taunt"] = true;
            ["Incapacitate"] = true;
            ["Root"] = true;
            ["Polymorph"] = true;
            ["Disorient"] = true;
            ["Sap"] = true;
            ["Imprison"] = true;
            ["Stun"] = true;
            ["Slow"] = true;
            ["Silence"] = true;
            ["Fear"] = true;
        };
        ["name"] = "Irontide Stormcaller";
        ["health"] = 235455;
        ["displayId"] = 79077;
        ["creatureType"] = "Humanoid";
        ["level"] = 120;
        ["count"] = 3;
        ["scale"] = 1;
    };
    [2] = {
        ["clones"] = {
            [7] = {
                ["y"] = -358.09938283234;
                ["x"] = 548.1908358106;
                ["g"] = 20;
                ["sublevel"] = 1;
            };
            [1] = {
                ["y"] = -223.4300274816;
                ["x"] = 581.50181759256;
                ["g"] = 1;
                ["sublevel"] = 1;
            };
            [2] = {
                ["sublevel"] = 1;
                ["x"] = 576.66309865434;
                ["y"] = -220.52680442486;
                ["g"] = 1;
                ["infested"] = {
                    [2] = true;
                };
            };
            [4] = {
                ["y"] = -318.33597514723;
                ["x"] = 611.04660479748;
                ["g"] = 8;
                ["sublevel"] = 1;
            };
            [8] = {
                ["y"] = -344.65676553796;
                ["x"] = 562.45312197414;
                ["g"] = 20;
                ["sublevel"] = 1;
            };
            [9] = {
                ["sublevel"] = 1;
                ["x"] = 344.7599440744;
                ["y"] = -176.36155345305;
                ["g"] = 63;
                ["infested"] = {
                    [1] = true;
                };
            };
            [5] = {
                ["sublevel"] = 1;
                ["x"] = 597.47520657594;
                ["y"] = -314.62168973697;
                ["g"] = 8;
                ["infested"] = {
                    [2] = true;
                };
            };
            [10] = {
                ["y"] = -196.75002336221;
                ["x"] = 319.81840615478;
                ["g"] = 64;
                ["sublevel"] = 1;
            };
            [3] = {
                ["sublevel"] = 1;
                ["x"] = 600.07649778772;
                ["y"] = -261.55965681488;
                ["g"] = 4;
                ["infested"] = {
                    [1] = true;
                    [2] = true;
                };
            };
            [6] = {
                ["sublevel"] = 1;
                ["x"] = 557.20720744203;
                ["y"] = -353.6731653106;
                ["g"] = 20;
                ["infested"] = {};
            };
            [11] = {
                ["sublevel"] = 1;
                ["x"] = 309.95540429154;
                ["y"] = -183.05139594603;
                ["g"] = 64;
                ["infested"] = {
                    [1] = true;
                };
            };
        };
        ["id"] = 128551;
        ["spells"] = {
            [257476] = {};
            [277242] = {};
            [209859] = {};
            [132951] = {};
            [257478] = {};
            [277564] = {};
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
        ["name"] = "Irontide Mastiff";
        ["health"] = 294320;
        ["displayId"] = 30221;
        ["creatureType"] = "Beast";
        ["level"] = 120;
        ["count"] = 4;
        ["scale"] = 1;
    };
    [3] = {
        ["clones"] = {
            [13] = {
                ["y"] = -285.51281918287;
                ["x"] = 579.23010552039;
                ["g"] = 18;
                ["sublevel"] = 1;
            };
            [7] = {
                ["sublevel"] = 1;
                ["x"] = 550.8884626247;
                ["y"] = -266.07816174063;
                ["g"] = 9;
                ["infested"] = {};
            };
            [14] = {
                ["sublevel"] = 1;
                ["x"] = 398.38251277098;
                ["patrol"] = {
                    [6] = {
                        ["y"] = -434.4421117003;
                        ["x"] = 418.15214967123;
                    };
                    [2] = {
                        ["y"] = -436.19210304506;
                        ["x"] = 385.1521350923;
                    };
                    [3] = {
                        ["y"] = -430.69211492035;
                        ["x"] = 382.40211957228;
                    };
                    [1] = {
                        ["y"] = -436.63910850897;
                        ["x"] = 398.38251277098;
                    };
                    [4] = {
                        ["y"] = -436.19210304506;
                        ["x"] = 385.1521350923;
                    };
                    [5] = {
                        ["y"] = -436.63910850897;
                        ["x"] = 398.38251277098;
                    };
                };
                ["upstairs"] = true;
                ["y"] = -436.63910850897;
                ["infested"] = {};
            };
            [2] = {
                ["y"] = -254.02737939683;
                ["x"] = 599.36844553568;
                ["g"] = 4;
                ["sublevel"] = 1;
            };
            [15] = {
                ["sublevel"] = 1;
                ["x"] = 427.07102168601;
                ["patrol"] = {
                    [6] = {
                        ["y"] = -406.07781822831;
                        ["x"] = 433.54582268221;
                    };
                    [2] = {
                        ["y"] = -408.86471208232;
                        ["x"] = 417.64418470973;
                    };
                    [3] = {
                        ["y"] = -418.20897096026;
                        ["x"] = 407.80813013853;
                    };
                    [1] = {
                        ["y"] = -408.93419098045;
                        ["x"] = 427.07102168601;
                    };
                    [4] = {
                        ["y"] = -408.86471208232;
                        ["x"] = 417.64418470973;
                    };
                    [5] = {
                        ["y"] = -408.93419098045;
                        ["x"] = 427.07102168601;
                    };
                };
                ["upstairs"] = true;
                ["y"] = -408.93419098045;
                ["infested"] = {
                    [2] = true;
                };
            };
            [8] = {
                ["sublevel"] = 1;
                ["x"] = 559.77976564586;
                ["y"] = -300.05438691243;
                ["g"] = 11;
                ["infested"] = {};
            };
            [1] = {
                ["sublevel"] = 1;
                ["x"] = 588.65484190154;
                ["y"] = -238.78070801174;
                ["g"] = 2;
                ["infested"] = {};
            };
            [9] = {
                ["sublevel"] = 1;
                ["x"] = 556.79975140368;
                ["y"] = -303.71066445212;
                ["g"] = 11;
                ["infested"] = {
                    [2] = true;
                };
            };
            [5] = {
                ["sublevel"] = 1;
                ["x"] = 619.2334876822;
                ["y"] = -279.83856882483;
                ["g"] = 7;
                ["infested"] = {};
            };
            [10] = {
                ["sublevel"] = 1;
                ["x"] = 526.73214471648;
                ["y"] = -274.65566223717;
                ["g"] = 12;
                ["infested"] = {};
            };
            [11] = {
                ["sublevel"] = 1;
                ["x"] = 524.05884893471;
                ["y"] = -312.666079778;
                ["g"] = 13;
                ["infested"] = {};
            };
            [3] = {
                ["sublevel"] = 1;
                ["x"] = 597.36603508842;
                ["y"] = -285.78709088423;
                ["g"] = 5;
                ["infested"] = {
                    [2] = true;
                };
            };
            [6] = {
                ["y"] = -272.53054043255;
                ["x"] = 554.42436064203;
                ["g"] = 9;
                ["sublevel"] = 1;
            };
            [12] = {
                ["y"] = -317.92258515668;
                ["x"] = 560.63458495939;
                ["g"] = 16;
                ["sublevel"] = 1;
            };
            [4] = {
                ["y"] = -286.94485788147;
                ["x"] = 593.21552800938;
                ["g"] = 5;
                ["sublevel"] = 1;
            };
        };
        ["scale"] = 1;
        ["spells"] = {
            [258673] = {};
            [277242] = {};
            [268440] = {};
            [209859] = {};
            [258672] = {};
            [277564] = {};
        };
        ["characteristics"] = {
            ["Taunt"] = true;
            ["Mind Control"] = true;
            ["Sap"] = true;
            ["Root"] = true;
            ["Silence"] = true;
            ["Slow"] = true;
            ["Stun"] = true;
            ["Fear"] = true;
        };
        ["count"] = 4;
        ["name"] = "Irontide Crackshot";
        ["displayId"] = 81254;
        ["creatureType"] = "Humanoid";
        ["level"] = 120;
        ["health"] = 264888;
        ["id"] = 126918;
    };
    [4] = {
        ["clones"] = {
            [1] = {
                ["sublevel"] = 1;
                ["x"] = 585.54966037025;
                ["y"] = -242.68192202712;
                ["g"] = 2;
                ["infested"] = {
                    [2] = true;
                };
            };
            [2] = {
                ["sublevel"] = 1;
                ["x"] = 562.73267958816;
                ["y"] = -253.13665336806;
                ["g"] = 3;
                ["infested"] = {
                    [1] = true;
                };
            };
            [4] = {
                ["y"] = -261.5273725097;
                ["x"] = 606.61847821718;
                ["g"] = 4;
                ["sublevel"] = 1;
            };
            [8] = {
                ["y"] = -297.12838683341;
                ["x"] = 562.74913108477;
                ["g"] = 11;
                ["sublevel"] = 1;
            };
            [16] = {
                ["y"] = -317.75932407748;
                ["x"] = 543.35132907592;
                ["sublevel"] = 1;
                ["g"] = 21;
                ["infested"] = {
                    [2] = true;
                };
            };
            [17] = {
                ["sublevel"] = 1;
                ["x"] = 541.50922228882;
                ["g"] = 21;
                ["y"] = -322.36458539847;
            };
            [9] = {
                ["sublevel"] = 1;
                ["x"] = 565.9136750961;
                ["y"] = -294.59674619203;
                ["g"] = 11;
                ["infested"] = {};
            };
            [18] = {
                ["sublevel"] = 1;
                ["x"] = 547.35174798458;
                ["g"] = 22;
                ["y"] = -292.75251983388;
            };
            [5] = {
                ["y"] = -257.9514065402;
                ["x"] = 602.5507214912;
                ["g"] = 4;
                ["sublevel"] = 1;
            };
            [10] = {
                ["sublevel"] = 1;
                ["x"] = 525.78848760998;
                ["y"] = -279.43331351388;
                ["g"] = 12;
                ["infested"] = {};
            };
            [20] = {
                ["sublevel"] = 1;
                ["x"] = 348.10205698293;
                ["upstairs"] = true;
                ["g"] = 32;
                ["y"] = -418.80017217098;
            };
            [21] = {
                ["sublevel"] = 1;
                ["x"] = 343.67582539059;
                ["upstairs"] = true;
                ["y"] = -420.93132670847;
                ["g"] = 32;
                ["infested"] = {
                    [1] = true;
                };
            };
            [11] = {
                ["sublevel"] = 1;
                ["x"] = 525.33974317856;
                ["y"] = -283.01008776162;
                ["g"] = 12;
                ["infested"] = {
                    [1] = true;
                };
            };
            [22] = {
                ["sublevel"] = 1;
                ["x"] = 592.75895945239;
                ["y"] = -234.54238790785;
                ["g"] = 2;
                ["infested"] = {};
            };
            [3] = {
                ["sublevel"] = 1;
                ["x"] = 559.61847130863;
                ["y"] = -250.02736876485;
                ["g"] = 3;
                ["infested"] = {};
            };
            [6] = {
                ["y"] = -283.6849123803;
                ["x"] = 601.00210963562;
                ["g"] = 5;
                ["sublevel"] = 1;
            };
            [12] = {
                ["sublevel"] = 1;
                ["x"] = 527.30621143788;
                ["y"] = -315.81871469401;
                ["g"] = 13;
                ["infested"] = {
                    [1] = true;
                };
            };
            [13] = {
                ["y"] = -302.65328824365;
                ["x"] = 610.39756181372;
                ["g"] = 17;
                ["sublevel"] = 1;
            };
            [7] = {
                ["sublevel"] = 1;
                ["x"] = 622.58796835444;
                ["y"] = -290.13103848144;
                ["g"] = 7;
                ["infested"] = {};
            };
            [14] = {
                ["y"] = -303.02134561571;
                ["x"] = 605.79892992417;
                ["sublevel"] = 1;
                ["g"] = 17;
                ["infested"] = {
                    [1] = true;
                    [3] = true;
                };
            };
            [15] = {
                ["y"] = -289.80389024593;
                ["x"] = 579.35159776985;
                ["g"] = 18;
                ["sublevel"] = 1;
            };
            [19] = {
                ["sublevel"] = 1;
                ["x"] = 543.40850929022;
                ["patrol"] = {
                    [7] = {
                        ["y"] = -280.01294286119;
                        ["x"] = 560.90851047121;
                    };
                    [1] = {
                        ["y"] = -290.39756402535;
                        ["x"] = 543.40850929022;
                    };
                    [2] = {
                        ["y"] = -278.66679590745;
                        ["x"] = 542.6392848175;
                    };
                    [4] = {
                        ["y"] = -258.6667863048;
                        ["x"] = 548.21619938299;
                    };
                    [8] = {
                        ["y"] = -288.08988235424;
                        ["x"] = 559.17775128111;
                    };
                    [9] = {
                        ["y"] = -295.39756436277;
                        ["x"] = 555.13928566106;
                    };
                    [5] = {
                        ["y"] = -264.24371737619;
                        ["x"] = 556.10083688434;
                    };
                    [10] = {
                        ["y"] = -294.24371114779;
                        ["x"] = 548.21619938299;
                    };
                    [3] = {
                        ["y"] = -267.89755425398;
                        ["x"] = 543.21621555146;
                    };
                    [6] = {
                        ["y"] = -268.08987275159;
                        ["x"] = 560.90851047121;
                    };
                };
                ["y"] = -290.39756402535;
                ["g"] = 22;
                ["infested"] = {
                    [2] = true;
                };
            };
        };
        ["id"] = 126928;
        ["spells"] = {
            [277564] = {};
            [257437] = {};
            [209859] = {};
            [257436] = {};
            [277242] = {};
        };
        ["characteristics"] = {
            ["Taunt"] = true;
            ["Sap"] = true;
            ["Root"] = true;
            ["Silence"] = true;
            ["Slow"] = true;
            ["Stun"] = true;
            ["Fear"] = true;
        };
        ["name"] = "Irontide Corsair";
        ["health"] = 294320;
        ["displayId"] = 81253;
        ["creatureType"] = "Humanoid";
        ["level"] = 120;
        ["count"] = 4;
        ["scale"] = 1;
    };
    [5] = {
        ["clones"] = {
            [13] = {
                ["y"] = -317.1931213991;
                ["x"] = 593.04662607793;
                ["sublevel"] = 1;
                ["teeming"] = true;
                ["g"] = 8;
                ["infested"] = {};
            };
            [7] = {
                ["y"] = -322.66484872977;
                ["x"] = 558.36654951403;
                ["g"] = 16;
                ["sublevel"] = 1;
            };
            [1] = {
                ["y"] = -250.77740026265;
                ["x"] = 566.86843961712;
                ["g"] = 3;
                ["sublevel"] = 1;
            };
            [2] = {
                ["y"] = -286.00298805084;
                ["x"] = 622.41722392579;
                ["g"] = 7;
                ["sublevel"] = 1;
            };
            [4] = {
                ["sublevel"] = 1;
                ["x"] = 521.66759939464;
                ["y"] = -308.27591848894;
                ["g"] = 13;
                ["infested"] = {};
            };
            [8] = {
                ["y"] = -298.3660424142;
                ["x"] = 608.20736915104;
                ["patrol"] = {
                    [7] = {
                        ["y"] = -270.35436649738;
                        ["x"] = 606.09019563549;
                    };
                    [1] = {
                        ["y"] = -298.3660424142;
                        ["x"] = 608.20736915104;
                    };
                    [2] = {
                        ["y"] = -273.19018623014;
                        ["x"] = 601.7618445952;
                    };
                    [4] = {
                        ["y"] = -282.59316036975;
                        ["x"] = 581.0155594982;
                    };
                    [8] = {
                        ["y"] = -290.95137028042;
                        ["x"] = 615.04542191234;
                    };
                    [9] = {
                        ["y"] = -305.13048175474;
                        ["x"] = 615.04542191234;
                    };
                    [5] = {
                        ["y"] = -267.96631384322;
                        ["x"] = 587.88124450661;
                    };
                    [10] = {
                        ["y"] = -313.48867244959;
                        ["x"] = 605.49317286404;
                    };
                    [3] = {
                        ["y"] = -276.02599315234;
                        ["x"] = 597.58272362668;
                    };
                    [6] = {
                        ["y"] = -261.39912740999;
                        ["x"] = 594.14989393302;
                    };
                };
                ["sublevel"] = 1;
                ["g"] = 17;
                ["infested"] = {};
            };
            [9] = {
                ["sublevel"] = 1;
                ["x"] = 579.4660130192;
                ["y"] = -294.46685997874;
                ["g"] = 18;
                ["infested"] = {};
            };
            [5] = {
                ["y"] = -302.57211597578;
                ["x"] = 521.6144083869;
                ["g"] = 13;
                ["sublevel"] = 1;
            };
            [10] = {
                ["y"] = -298.90792437747;
                ["x"] = 579.4660130192;
                ["g"] = 18;
                ["sublevel"] = 1;
            };
            [3] = {
                ["sublevel"] = 1;
                ["x"] = 558.36188436792;
                ["y"] = -273.04145606772;
                ["g"] = 9;
                ["infested"] = {
                    [2] = true;
                };
            };
            [6] = {
                ["sublevel"] = 1;
                ["x"] = 557.02635238175;
                ["y"] = -326.78856080126;
                ["g"] = 16;
                ["infested"] = {};
            };
            [12] = {
                ["y"] = -294.94763917898;
                ["x"] = 543.44931010424;
                ["g"] = 22;
                ["sublevel"] = 1;
            };
            [11] = {
                ["sublevel"] = 1;
                ["x"] = 538.08815876028;
                ["y"] = -319.07510818626;
                ["g"] = 21;
                ["infested"] = {};
            };
        };
        ["id"] = 129788;
        ["spells"] = {
            [258323] = {};
            [277242] = {};
            [209859] = {};
            [258321] = {};
            [257397] = {};
            [277564] = {};
        };
        ["characteristics"] = {
            ["Polymorph"] = true;
            ["Taunt"] = true;
            ["Sap"] = true;
            ["Silence"] = true;
            ["Stun"] = true;
            ["Slow"] = true;
            ["Root"] = true;
            ["Fear"] = true;
        };
        ["name"] = "Irontide Bonesaw";
        ["health"] = 235455;
        ["displayId"] = 81255;
        ["creatureType"] = "Humanoid";
        ["level"] = 120;
        ["count"] = 4;
        ["scale"] = 1;
    };
    [6] = {
        ["clones"] = {
            [7] = {
                ["y"] = -322.25247663777;
                ["x"] = 561.97479978871;
                ["sublevel"] = 1;
                ["infested"] = {
                    [1] = true;
                };
            };
            [1] = {
                ["y"] = -284.19397073792;
                ["x"] = 618.1045892353;
                ["sublevel"] = 1;
            };
            [2] = {
                ["y"] = -291.09990053226;
                ["x"] = 626.77360877668;
                ["sublevel"] = 1;
            };
            [4] = {
                ["y"] = -278.00640151973;
                ["x"] = 545.52881544343;
                ["sublevel"] = 1;
                ["infested"] = {
                    [1] = true;
                };
            };
            [8] = {
                ["sublevel"] = 1;
                ["x"] = 367.7844356909;
                ["upstairs"] = true;
                ["g"] = 66;
                ["y"] = -396.17955458796;
            };
            [9] = {
                ["sublevel"] = 1;
                ["x"] = 370.5298191388;
                ["upstairs"] = true;
                ["g"] = 69;
                ["y"] = -396.41062741958;
            };
            [5] = {
                ["y"] = -275.53299975819;
                ["x"] = 547.42250343186;
                ["sublevel"] = 1;
            };
            [3] = {
                ["y"] = -288.82464537504;
                ["x"] = 618.69694197096;
                ["sublevel"] = 1;
            };
            [6] = {
                ["y"] = -327.09783433993;
                ["x"] = 560.84078206604;
                ["sublevel"] = 1;
            };
        };
        ["id"] = 129598;
        ["spells"] = {
            [277242] = {};
            [277564] = {};
        };
        ["characteristics"] = {
            ["Stun"] = true;
            ["Root"] = true;
        };
        ["neutral"] = true;
        ["health"] = 36267;
        ["name"] = "Freehold Pack Mule";
        ["displayId"] = 88571;
        ["creatureType"] = "Beast";
        ["level"] = 120;
        ["count"] = 2;
        ["scale"] = 0.6;
    };
    [7] = {
        ["clones"] = {
            [1] = {
                ["y"] = -330.73817112427;
                ["x"] = 575.37965681591;
                ["g"] = 19;
                ["sublevel"] = 1;
            };
        };
        ["id"] = 129732;
        ["spells"] = {
            [277564] = {};
        };
        ["isBoss"] = true;
        ["encounterID"] = 2095;
        ["instanceID"] = 1001;
        ["scale"] = 1;
        ["count"] = 0;
        ["displayId"] = 80382;
        ["creatureType"] = "Humanoid";
        ["level"] = 122;
        ["name"] = "Skycap'n Kragg";
        ["health"] = 11772800;
    };
    [8] = {
        ["clones"] = {
            [6] = {
                ["sublevel"] = 1;
                ["x"] = 391.64222537453;
                ["y"] = -412.55852664629;
                ["g"] = 30;
                ["infested"] = {
                    [2] = true;
                };
            };
            [2] = {
                ["y"] = -400.5989497842;
                ["x"] = 441.44698636877;
                ["g"] = 25;
                ["sublevel"] = 1;
            };
            [8] = {
                ["y"] = -410.44087203575;
                ["x"] = 387.64223354956;
                ["teeming"] = true;
                ["g"] = 30;
                ["sublevel"] = 1;
            };
            [3] = {
                ["sublevel"] = 1;
                ["x"] = 433.45493363816;
                ["y"] = -415.01802570409;
                ["g"] = 27;
                ["infested"] = {
                    [1] = true;
                };
            };
            [1] = {
                ["sublevel"] = 1;
                ["x"] = 427.96338096744;
                ["infested"] = {};
                ["g"] = 23;
                ["y"] = -391.77930993249;
            };
            [4] = {
                ["sublevel"] = 1;
                ["x"] = 415.86618894122;
                ["infested"] = {
                    [3] = true;
                };
                ["g"] = 28;
                ["y"] = -426.31845966812;
            };
            [5] = {
                ["sublevel"] = 1;
                ["x"] = 401.4286623737;
                ["y"] = -426.85229781158;
                ["g"] = 29;
                ["infested"] = {};
            };
            [7] = {
                ["sublevel"] = 1;
                ["x"] = 379.75050510268;
                ["upstairs"] = true;
                ["y"] = -395.66604335926;
                ["g"] = 31;
                ["infested"] = {
                    [1] = true;
                    [2] = true;
                };
            };
        };
        ["scale"] = 1;
        ["spells"] = {
            [277564] = {};
            [274400] = {};
            [277242] = {};
            [209859] = {};
        };
        ["characteristics"] = {
            ["Taunt"] = true;
            ["Incapacitate"] = true;
            ["Sap"] = true;
            ["Root"] = true;
            ["Stun"] = true;
            ["Slow"] = true;
            ["Silence"] = true;
            ["Fear"] = true;
        };
        ["count"] = 4;
        ["name"] = "Cutwater Duelist";
        ["displayId"] = 80339;
        ["creatureType"] = "Humanoid";
        ["level"] = 120;
        ["health"] = 181335;
        ["id"] = 129559;
    };
    [10] = {
        ["clones"] = {
            [7] = {
                ["sublevel"] = 1;
                ["x"] = 333.83223376313;
                ["upstairs"] = true;
                ["g"] = 40;
                ["y"] = -408.22734060584;
            };
            [1] = {
                ["sublevel"] = 1;
                ["x"] = 423.8482270145;
                ["y"] = -393.51147578162;
                ["g"] = 23;
                ["infested"] = {
                    [2] = true;
                };
            };
            [2] = {
                ["sublevel"] = 1;
                ["x"] = 432.72321672263;
                ["y"] = -419.77411761848;
                ["g"] = 27;
                ["infested"] = {};
            };
            [4] = {
                ["y"] = -406.67617741146;
                ["x"] = 385.75988623742;
                ["g"] = 30;
                ["sublevel"] = 1;
            };
            [8] = {
                ["sublevel"] = 1;
                ["x"] = 333.48929221358;
                ["upstairs"] = true;
                ["y"] = -400.65530192996;
                ["g"] = 40;
                ["infested"] = {
                    [2] = true;
                };
            };
            [9] = {
                ["sublevel"] = 1;
                ["x"] = 372.0622278959;
                ["y"] = -374.99362441396;
                ["g"] = 42;
                ["infested"] = {};
            };
            [5] = {
                ["sublevel"] = 1;
                ["x"] = 350.71518826563;
                ["upstairs"] = true;
                ["g"] = 33;
                ["y"] = -441.95542540812;
            };
            [10] = {
                ["sublevel"] = 1;
                ["x"] = 261.8112140627;
                ["infested"] = {};
                ["g"] = 55;
                ["y"] = -344.40986833828;
            };
            [3] = {
                ["sublevel"] = 1;
                ["x"] = 397.4751809314;
                ["y"] = -430.80576927357;
                ["g"] = 29;
                ["infested"] = {
                    [2] = true;
                };
            };
            [6] = {
                ["sublevel"] = 1;
                ["x"] = 308.12486124605;
                ["upstairs"] = true;
                ["infested"] = {};
                ["g"] = 39;
                ["y"] = -392.93836700041;
            };
            [12] = {
                ["y"] = -405.66834286789;
                ["x"] = 420.39193175612;
                ["sublevel"] = 1;
                ["g"] = 72;
                ["blacktoothEvent"] = true;
            };
            [11] = {
                ["y"] = -400.62486996805;
                ["x"] = 417.00062065424;
                ["sublevel"] = 1;
                ["g"] = 72;
                ["blacktoothEvent"] = true;
            };
        };
        ["id"] = 129548;
        ["spells"] = {
            [277564] = {};
            [209859] = {};
            [257747] = {};
            [277242] = {};
        };
        ["characteristics"] = {
            ["Taunt"] = true;
            ["Incapacitate"] = true;
            ["Root"] = true;
            ["Polymorph"] = true;
            ["Disorient"] = true;
            ["Silence"] = true;
            ["Slow"] = true;
            ["Stun"] = true;
            ["Fear"] = true;
        };
        ["name"] = "Blacktooth Brute";
        ["count"] = 4;
        ["displayId"] = 80389;
        ["creatureType"] = "Humanoid";
        ["level"] = 120;
        ["health"] = 294320;
        ["scale"] = 1;
    };
    [12] = {
        ["clones"] = {
            [6] = {
                ["y"] = -381.89733346819;
                ["x"] = 393.91830507738;
                ["g"] = 26;
                ["sublevel"] = 1;
            };
            [2] = {
                ["sublevel"] = 1;
                ["x"] = 404.89390180289;
                ["g"] = 24;
                ["y"] = -401.77538656124;
            };
            [8] = {
                ["y"] = -379.82416694234;
                ["x"] = 391.72317003155;
                ["sublevel"] = 1;
                ["g"] = 26;
                ["infested"] = {};
            };
            [3] = {
                ["sublevel"] = 1;
                ["x"] = 402.82073527704;
                ["g"] = 24;
                ["y"] = -400.31197366451;
            };
            [1] = {
                ["y"] = -403.97051113992;
                ["x"] = 405.74757153767;
                ["sublevel"] = 1;
                ["g"] = 24;
                ["infested"] = {
                    [1] = true;
                };
            };
            [4] = {
                ["sublevel"] = 1;
                ["x"] = 399.89390948357;
                ["g"] = 24;
                ["y"] = -400.43391601661;
            };
            [5] = {
                ["y"] = -384.94612254807;
                ["x"] = 387.21098898925;
                ["sublevel"] = 1;
                ["g"] = 26;
                ["infested"] = {
                    [1] = true;
                };
            };
            [7] = {
                ["y"] = -381.40953265833;
                ["x"] = 387.57683174628;
                ["sublevel"] = 1;
                ["g"] = 26;
                ["infested"] = {};
            };
        };
        ["scale"] = 0.6;
        ["spells"] = {
            [257476] = {};
            [277564] = {};
            [209859] = {};
            [274555] = {};
            [277242] = {};
        };
        ["characteristics"] = {
            ["Taunt"] = true;
            ["Stun"] = true;
            ["Slow"] = true;
            ["Root"] = true;
            ["Silence"] = true;
        };
        ["count"] = 1;
        ["name"] = "Soggy Shiprat";
        ["displayId"] = 81400;
        ["creatureType"] = "Beast";
        ["level"] = 120;
        ["health"] = 29432;
        ["id"] = 130024;
    };
    [14] = {
        ["clones"] = {
            [13] = {
                ["y"] = -402.0981673499;
                ["x"] = 414.42737794132;
                ["sublevel"] = 1;
                ["g"] = 72;
                ["blacktoothEvent"] = true;
            };
            [7] = {
                ["sublevel"] = 1;
                ["x"] = 334.47771009328;
                ["infested"] = {};
                ["g"] = 49;
                ["y"] = -350.92690700733;
            };
            [1] = {
                ["sublevel"] = 1;
                ["x"] = 363.29861878332;
                ["upstairs"] = true;
                ["g"] = 34;
                ["y"] = -441.25753441285;
            };
            [2] = {
                ["sublevel"] = 1;
                ["x"] = 357.21301553033;
                ["upstairs"] = true;
                ["y"] = -395.75098366607;
                ["g"] = 38;
                ["infested"] = {
                    [2] = true;
                };
            };
            [4] = {
                ["sublevel"] = 1;
                ["x"] = 317.73905295297;
                ["y"] = -375.3940306223;
                ["g"] = 45;
                ["infested"] = {
                    [1] = true;
                    [3] = true;
                };
            };
            [8] = {
                ["y"] = -366.35547245704;
                ["x"] = 335.33486419859;
                ["g"] = 49;
                ["sublevel"] = 1;
            };
            [9] = {
                ["y"] = -351.34048832854;
                ["x"] = 287.88987353557;
                ["patrol"] = {
                    [6] = {
                        ["y"] = -371.15093454023;
                        ["x"] = 282.33489618274;
                    };
                    [2] = {
                        ["y"] = -345.11706437257;
                        ["x"] = 289.21075544493;
                    };
                    [8] = {
                        ["y"] = -371.15093454023;
                        ["x"] = 282.33489618274;
                    };
                    [3] = {
                        ["y"] = -329.02332380774;
                        ["x"] = 288.11699104756;
                    };
                    [1] = {
                        ["y"] = -351.34048832854;
                        ["x"] = 287.88987353557;
                    };
                    [4] = {
                        ["y"] = -345.11706437257;
                        ["x"] = 289.21075544493;
                    };
                    [5] = {
                        ["y"] = -351.34048832854;
                        ["x"] = 287.88987353557;
                    };
                    [7] = {
                        ["y"] = -386.25009769854;
                        ["x"] = 289.80497711643;
                    };
                };
                ["g"] = 53;
                ["sublevel"] = 1;
            };
            [5] = {
                ["y"] = -378.15437752722;
                ["x"] = 299.52134444273;
                ["g"] = 46;
                ["sublevel"] = 1;
            };
            [10] = {
                ["sublevel"] = 1;
                ["x"] = 278.58694476597;
                ["upstairs"] = true;
                ["y"] = -324.24994915898;
                ["g"] = 57;
                ["infested"] = {
                    [2] = true;
                };
            };
            [14] = {
                ["y"] = -405.75034021182;
                ["x"] = 416.25346623816;
                ["sublevel"] = 1;
                ["g"] = 72;
                ["blacktoothEvent"] = true;
            };
            [11] = {
                ["sublevel"] = 1;
                ["x"] = 278.98600277822;
                ["upstairs"] = true;
                ["y"] = -329.55858285652;
                ["g"] = 57;
                ["infested"] = {};
            };
            [6] = {
                ["y"] = -379.5452543256;
                ["x"] = 267.40221729937;
                ["g"] = 47;
                ["sublevel"] = 1;
            };
            [12] = {
                ["sublevel"] = 1;
                ["x"] = 299.24865155987;
                ["upstairs"] = true;
                ["y"] = -333.5535978722;
                ["g"] = 58;
                ["infested"] = {
                    [2] = true;
                };
            };
            [3] = {
                ["sublevel"] = 1;
                ["x"] = 318.20332812203;
                ["y"] = -371.54779768028;
                ["g"] = 45;
                ["infested"] = {};
            };
        };
        ["id"] = 129529;
        ["spells"] = {
            [277242] = {};
            [257739] = {};
            [277564] = {};
            [257741] = {};
            [209859] = {};
        };
        ["characteristics"] = {
            ["Taunt"] = true;
            ["Incapacitate"] = true;
            ["Silence"] = true;
            ["Root"] = true;
            ["Slow"] = true;
            ["Stun"] = true;
            ["Fear"] = true;
        };
        ["name"] = "Blacktooth Scrapper";
        ["health"] = 353184;
        ["displayId"] = 80380;
        ["creatureType"] = "Humanoid";
        ["level"] = 120;
        ["count"] = 4;
        ["scale"] = 1;
    };
    [16] = {
        ["clones"] = {
            [7] = {
                ["sublevel"] = 1;
                ["x"] = 334.62059321691;
                ["y"] = -361.92691026962;
                ["g"] = 49;
                ["infested"] = {
                    [2] = true;
                };
            };
            [1] = {
                ["sublevel"] = 1;
                ["x"] = 352.64160053781;
                ["upstairs"] = true;
                ["g"] = 38;
                ["y"] = -395.3224250057;
            };
            [2] = {
                ["sublevel"] = 1;
                ["x"] = 356.12039857609;
                ["upstairs"] = true;
                ["infested"] = {
                    [3] = true;
                };
                ["g"] = 38;
                ["y"] = -391.88071102513;
            };
            [4] = {
                ["y"] = -370.58390090933;
                ["x"] = 322.67575030236;
                ["g"] = 45;
                ["sublevel"] = 1;
            };
            [8] = {
                ["sublevel"] = 1;
                ["x"] = 324.58673976491;
                ["y"] = -340.75871286759;
                ["g"] = 51;
                ["infested"] = {
                    [1] = true;
                };
            };
            [9] = {
                ["sublevel"] = 1;
                ["x"] = 303.32694337274;
                ["infested"] = {};
                ["g"] = 56;
                ["y"] = -351.03294785363;
            };
            [5] = {
                ["y"] = -379.57124066837;
                ["x"] = 317.86562602171;
                ["g"] = 45;
                ["sublevel"] = 1;
            };
            [10] = {
                ["y"] = -360.27619999782;
                ["x"] = 288.47603298004;
                ["sublevel"] = 1;
                ["g"] = 53;
                ["infested"] = {
                    [1] = true;
                };
            };
            [3] = {
                ["y"] = -359.49358953592;
                ["x"] = 387.06225796645;
                ["sublevel"] = 1;
                ["infested"] = {};
            };
            [6] = {
                ["y"] = -378.50048369139;
                ["x"] = 275.16341084386;
                ["g"] = 47;
                ["sublevel"] = 1;
            };
            [12] = {
                ["y"] = -332.25328423952;
                ["x"] = 328.21441256104;
                ["teeming"] = true;
                ["g"] = 51;
                ["sublevel"] = 1;
            };
            [11] = {
                ["sublevel"] = 1;
                ["x"] = 273.51232807191;
                ["upstairs"] = true;
                ["y"] = -323.50367069466;
                ["g"] = 57;
                ["infested"] = {};
            };
        };
        ["id"] = 129527;
        ["spells"] = {
            [257756] = {};
            [257757] = {};
            [277242] = {};
            [209859] = {};
            [277564] = {};
        };
        ["scale"] = 1;
        ["name"] = "Bilge Rat Buccaneer";
        ["health"] = 294320;
        ["displayId"] = 81424;
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
            ["Fear"] = true;
            ["Silence"] = true;
            ["Slow"] = true;
            ["Stun"] = true;
            ["Imprison"] = true;
        };
    };
    [20] = {
        ["clones"] = {
            [1] = {
                ["y"] = -333.8100385074;
                ["x"] = 359.55574062333;
                ["g"] = 43;
                ["sublevel"] = 1;
            };
        };
        ["scale"] = 1;
        ["characteristics"] = {
            ["Taunt"] = true;
        };
        ["spells"] = {
            [256979] = {};
            [258352] = {};
            [258381] = {};
            [272902] = {};
            [272905] = {};
            [257821] = {};
        };
        ["isBoss"] = true;
        ["encounterID"] = 2093;
        ["instanceID"] = 1001;
        ["id"] = 126848;
        ["health"] = 2590016;
        ["displayId"] = 80346;
        ["creatureType"] = "Humanoid";
        ["level"] = 122;
        ["name"] = "Captain Eudora";
        ["count"] = 0;
    };
    [24] = {
        ["clones"] = {
            [2] = {
                ["sublevel"] = 1;
                ["x"] = 267.78112006396;
                ["y"] = -360.8307755636;
                ["infested"] = {
                    [3] = true;
                };
            };
            [3] = {
                ["sublevel"] = 1;
                ["x"] = 321.21716564031;
                ["patrol"] = {
                    [1] = {
                        ["y"] = -359.98608439708;
                        ["x"] = 321.21716564031;
                    };
                    [2] = {
                        ["y"] = -334.16791966086;
                        ["x"] = 329.21716232548;
                    };
                    [4] = {
                        ["y"] = -356.16791444647;
                        ["x"] = 299.03535026551;
                    };
                    [3] = {
                        ["y"] = -359.98608439708;
                        ["x"] = 321.21716564031;
                    };
                };
                ["infested"] = {
                    [3] = true;
                };
                ["y"] = -359.98608439708;
            };
            [1] = {
                ["y"] = -393.11478902913;
                ["x"] = 254.27578455822;
                ["sublevel"] = 1;
                ["infested"] = {};
            };
            [4] = {
                ["y"] = -322.04898522661;
                ["x"] = 251.78667036337;
                ["infested"] = {
                    [3] = true;
                };
                ["sublevel"] = 1;
            };
            [5] = {
                ["y"] = -365.82089742123;
                ["x"] = 267.66607255606;
                ["sublevel"] = 1;
                ["teeming"] = true;
            };
        };
        ["scale"] = 1.4;
        ["spells"] = {
            [277242] = {};
            [276061] = {};
            [209859] = {};
            [258181] = {};
            [258199] = {};
            [277564] = {};
        };
        ["characteristics"] = {
            ["Taunt"] = true;
        };
        ["count"] = 6;
        ["name"] = "Irontide Crusher";
        ["displayId"] = 68059;
        ["creatureType"] = "Giant";
        ["level"] = 121;
        ["health"] = 588640;
        ["id"] = 130400;
    };
    [28] = {
        ["clones"] = {
            [1] = {
                ["sublevel"] = 1;
                ["x"] = 335.38569207796;
                ["y"] = -226.55082875808;
                ["g"] = 60;
                ["infested"] = {};
            };
            [2] = {
                ["sublevel"] = 1;
                ["x"] = 343.77415219959;
                ["y"] = -213.47315303961;
                ["g"] = 61;
                ["infested"] = {};
            };
            [3] = {
                ["y"] = -180.70264486523;
                ["x"] = 356.46535620652;
                ["g"] = 63;
                ["sublevel"] = 1;
            };
        };
        ["id"] = 130012;
        ["spells"] = {
            [277242] = {};
            [257899] = {};
            [209859] = {};
            [132951] = {};
            [205276] = {};
            [277564] = {};
        };
        ["scale"] = 1;
        ["name"] = "Irontide Ravager";
        ["health"] = 294320;
        ["displayId"] = 81507;
        ["creatureType"] = "Humanoid";
        ["level"] = 120;
        ["count"] = 4;
        ["characteristics"] = {
            ["Taunt"] = true;
            ["Disorient"] = true;
            ["Sap"] = true;
            ["Root"] = true;
            ["Silence"] = true;
            ["Slow"] = true;
            ["Stun"] = true;
            ["Fear"] = true;
        };
    };
    [32] = {
        ["clones"] = {
            [1] = {
                ["y"] = -443.70737899842;
                ["x"] = 431.4327036397;
                ["sublevel"] = 1;
                ["infested"] = {};
            };
            [2] = {
                ["y"] = -440.91666390668;
                ["x"] = 426.78153843432;
                ["sublevel"] = 1;
                ["infested"] = {};
            };
            [4] = {
                ["y"] = -431.35423955244;
                ["x"] = 392.48611128988;
                ["sublevel"] = 1;
                ["infested"] = {
                    [1] = true;
                };
            };
            [8] = {
                ["sublevel"] = 1;
                ["x"] = 409.90550033856;
                ["patrol"] = {
                    [7] = {
                        ["y"] = -416.21912332401;
                        ["x"] = 398.33041148939;
                    };
                    [1] = {
                        ["y"] = -400.42291306931;
                        ["x"] = 409.90550033856;
                    };
                    [2] = {
                        ["y"] = -401.21913589891;
                        ["x"] = 416.37918799437;
                    };
                    [4] = {
                        ["y"] = -415.73132251415;
                        ["x"] = 422.72065085833;
                    };
                    [8] = {
                        ["y"] = -404.99962096;
                        ["x"] = 397.59869457387;
                    };
                    [9] = {
                        ["y"] = -400.48742945054;
                        ["x"] = 403.0864981702;
                    };
                    [5] = {
                        ["y"] = -420.97522570555;
                        ["x"] = 419.79380413055;
                    };
                    [3] = {
                        ["y"] = -409.38986488378;
                        ["x"] = 421.50113313294;
                    };
                    [6] = {
                        ["y"] = -422.19473819736;
                        ["x"] = 406.9889465177;
                    };
                };
                ["y"] = -400.42291306931;
                ["infested"] = {
                    [1] = true;
                };
            };
            [16] = {
                ["y"] = -344.6063341927;
                ["x"] = 343.23381235593;
                ["g"] = 70;
                ["sublevel"] = 1;
            };
            [17] = {
                ["y"] = -393.04170939424;
                ["x"] = 245.04100602619;
                ["sublevel"] = 1;
            };
            [9] = {
                ["y"] = -375.39600941973;
                ["x"] = 425.73693709783;
                ["sublevel"] = 1;
                ["infested"] = {};
            };
            [18] = {
                ["y"] = -397.58700738667;
                ["x"] = 247.76755448611;
                ["sublevel"] = 1;
            };
            [5] = {
                ["y"] = -431.35423955244;
                ["x"] = 389.72296240274;
                ["sublevel"] = 1;
            };
            [10] = {
                ["y"] = -444.682195676;
                ["x"] = 359.73697530238;
                ["sublevel"] = 1;
                ["upstairs"] = true;
            };
            [20] = {
                ["y"] = -396.0520724445;
                ["x"] = 262.90768116939;
                ["sublevel"] = 1;
            };
            [21] = {
                ["y"] = -386.78688288329;
                ["x"] = 266.48977407349;
                ["sublevel"] = 1;
            };
            [11] = {
                ["y"] = -438.79178982585;
                ["x"] = 358.77807038385;
                ["sublevel"] = 1;
                ["upstairs"] = true;
            };
            [22] = {
                ["y"] = -432.78722978124;
                ["x"] = 369.90063436546;
                ["sublevel"] = 1;
                ["upstairs"] = true;
            };
            [3] = {
                ["y"] = -439.98643884986;
                ["x"] = 437.01411386254;
                ["infested"] = {
                    [3] = true;
                };
                ["sublevel"] = 1;
            };
            [6] = {
                ["y"] = -428.72266004137;
                ["x"] = 389.72296240274;
                ["sublevel"] = 1;
            };
            [12] = {
                ["y"] = -420.13504628936;
                ["x"] = 373.56751166519;
                ["sublevel"] = 1;
                ["upstairs"] = true;
            };
            [13] = {
                ["sublevel"] = 1;
                ["x"] = 417.33293235944;
                ["upstairs"] = true;
                ["y"] = -410.55586394165;
                ["infested"] = {
                    [1] = true;
                };
            };
            [7] = {
                ["y"] = -421.58180185169;
                ["x"] = 384.48718115197;
                ["sublevel"] = 1;
                ["infested"] = {
                    [1] = true;
                };
            };
            [14] = {
                ["y"] = -339.97945761309;
                ["x"] = 344.57703227835;
                ["g"] = 70;
                ["sublevel"] = 1;
            };
            [15] = {
                ["sublevel"] = 1;
                ["x"] = 351.14424878273;
                ["y"] = -341.77050805467;
                ["g"] = 70;
                ["infested"] = {
                    [1] = true;
                };
            };
            [19] = {
                ["y"] = -389.92092650624;
                ["x"] = 262.34779401948;
                ["sublevel"] = 1;
            };
            [23] = {
                ["y"] = -384.66372890629;
                ["x"] = 424.31276866414;
                ["sublevel"] = 1;
                ["infested"] = {
                    [1] = true;
                };
            };
        };
        ["id"] = 127119;
        ["spells"] = {
            [277242] = {};
            [277564] = {};
        };
        ["scale"] = 0.6;
        ["name"] = "Freehold Deckhand";
        ["health"] = 58864;
        ["count"] = 1;
        ["displayId"] = 78623;
        ["creatureType"] = "Humanoid";
        ["level"] = 120;
        ["neutral"] = true;
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
    [33] = {
        ["clones"] = {
            [7] = {
                ["y"] = -345.05410767656;
                ["x"] = 346.36813066386;
                ["g"] = 70;
                ["sublevel"] = 1;
            };
            [1] = {
                ["y"] = -440.56507628456;
                ["x"] = 418.67307060213;
                ["sublevel"] = 1;
            };
            [2] = {
                ["y"] = -426.38716532254;
                ["x"] = 397.0100783833;
                ["sublevel"] = 1;
            };
            [4] = {
                ["y"] = -391.39382621995;
                ["x"] = 415.14236186031;
                ["sublevel"] = 1;
            };
            [8] = {
                ["y"] = -344.90484557843;
                ["x"] = 349.6516918541;
                ["g"] = 70;
                ["sublevel"] = 1;
            };
            [9] = {
                ["y"] = -392.83762504572;
                ["x"] = 248.30630305316;
                ["sublevel"] = 1;
            };
            [5] = {
                ["y"] = -387.75538730739;
                ["x"] = 432.06899148287;
                ["sublevel"] = 1;
                ["infested"] = {
                    [1] = true;
                };
            };
            [10] = {
                ["y"] = -396.91925070855;
                ["x"] = 244.22470366503;
                ["sublevel"] = 1;
            };
            [3] = {
                ["y"] = -428.45950434897;
                ["x"] = 392.88085329862;
                ["sublevel"] = 1;
            };
            [6] = {
                ["sublevel"] = 1;
                ["x"] = 357.48824782226;
                ["upstairs"] = true;
                ["y"] = -441.96021114246;
                ["infested"] = {
                    [1] = true;
                };
            };
            [12] = {
                ["y"] = -393.78455979609;
                ["x"] = 265.41597698255;
                ["sublevel"] = 1;
            };
            [11] = {
                ["y"] = -390.60274385876;
                ["x"] = 258.48416560637;
                ["sublevel"] = 1;
            };
        };
        ["id"] = 130522;
        ["spells"] = {
            [277564] = {};
            [277242] = {};
            [1604] = {};
        };
        ["characteristics"] = {
            ["Taunt"] = true;
            ["Disorient"] = true;
            ["Sap"] = true;
            ["Root"] = true;
            ["Silence"] = true;
            ["Slow"] = true;
            ["Stun"] = true;
            ["Fear"] = true;
        };
        ["scale"] = 0.6;
        ["health"] = 60883;
        ["count"] = 1;
        ["displayId"] = 80087;
        ["creatureType"] = "Humanoid";
        ["level"] = 120;
        ["name"] = "Freehold Shipmate";
        ["neutral"] = true;
    };
    [17] = {
        ["clones"] = {
            [7] = {
                ["y"] = -374.06336406279;
                ["x"] = 294.41708673335;
                ["g"] = 46;
                ["sublevel"] = 1;
            };
            [1] = {
                ["sublevel"] = 1;
                ["x"] = 311.97508609272;
                ["upstairs"] = true;
                ["g"] = 39;
                ["y"] = -397.3702146717;
            };
            [2] = {
                ["sublevel"] = 1;
                ["x"] = 307.68937687378;
                ["upstairs"] = true;
                ["y"] = -400.9416410644;
                ["g"] = 39;
                ["infested"] = {};
            };
            [4] = {
                ["y"] = -371.03385132999;
                ["x"] = 345.27318616201;
                ["g"] = 44;
                ["sublevel"] = 1;
            };
            [8] = {
                ["sublevel"] = 1;
                ["x"] = 269.79028276408;
                ["y"] = -382.82884754222;
                ["g"] = 47;
                ["infested"] = {};
            };
            [9] = {
                ["y"] = -355.50007547367;
                ["x"] = 290.2670756733;
                ["sublevel"] = 1;
                ["g"] = 53;
                ["infested"] = {};
            };
            [5] = {
                ["y"] = -374.91444837842;
                ["x"] = 342.13885482046;
                ["g"] = 44;
                ["sublevel"] = 1;
            };
            [10] = {
                ["sublevel"] = 1;
                ["x"] = 273.51232807191;
                ["upstairs"] = true;
                ["g"] = 57;
                ["y"] = -329.17532937599;
            };
            [3] = {
                ["sublevel"] = 1;
                ["x"] = 366.17780604811;
                ["y"] = -375.23498029718;
                ["g"] = 42;
                ["infested"] = {
                    [2] = true;
                };
            };
            [6] = {
                ["y"] = -382.57745538363;
                ["x"] = 297.40598126923;
                ["g"] = 46;
                ["sublevel"] = 1;
            };
            [12] = {
                ["sublevel"] = 1;
                ["x"] = 294.76587585058;
                ["upstairs"] = true;
                ["y"] = -333.55360031194;
                ["g"] = 58;
                ["infested"] = {
                    [1] = true;
                };
            };
            [11] = {
                ["sublevel"] = 1;
                ["x"] = 294.2486424358;
                ["upstairs"] = true;
                ["g"] = 58;
                ["y"] = -329.58807507283;
            };
        };
        ["scale"] = 1;
        ["spells"] = {
            [257784] = {};
            [277242] = {};
            [209859] = {};
            [281420] = {};
            [277564] = {};
        };
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
        ["health"] = 188364;
        ["name"] = "Bilge Rat Brinescale";
        ["displayId"] = 80475;
        ["creatureType"] = "Humanoid";
        ["level"] = 120;
        ["count"] = 3;
        ["id"] = 129600;
    };
    [21] = {
        ["clones"] = {
            [1] = {
                ["y"] = -333.81004320864;
                ["x"] = 371.64872438521;
                ["g"] = 43;
                ["sublevel"] = 1;
            };
        };
        ["scale"] = 1;
        ["characteristics"] = {
            ["Taunt"] = true;
        };
        ["spells"] = {
            [272884] = {};
            [258338] = {};
            [257821] = {};
            [256589] = {};
            [256594] = {};
        };
        ["isBoss"] = true;
        ["encounterID"] = 2093;
        ["instanceID"] = 1001;
        ["id"] = 126847;
        ["health"] = 2590016;
        ["displayId"] = 81060;
        ["creatureType"] = "Humanoid";
        ["level"] = 122;
        ["name"] = "Captain Raoul";
        ["count"] = 0;
    };
    [25] = {
        ["clones"] = {
            [1] = {
                ["y"] = -361.77744763557;
                ["x"] = 245.69808511605;
                ["sublevel"] = 1;
            };
        };
        ["id"] = 129699;
        ["spells"] = {
            [257904] = {};
        };
        ["characteristics"] = {
            ["Taunt"] = true;
        };
        ["name"] = "Ludwig Von Tortollan";
        ["health"] = 1177340;
        ["displayId"] = 80792;
        ["creatureType"] = "Beast";
        ["level"] = 121;
        ["count"] = 0;
        ["scale"] = 1.5;
    };
    [29] = {
        ["clones"] = {
            [1] = {
                ["y"] = -188.97268280079;
                ["x"] = 333.12190009083;
                ["patrol"] = {
                    [6] = {
                        ["y"] = -181.69974815482;
                        ["x"] = 326.51537691284;
                    };
                    [2] = {
                        ["y"] = -202.79123618084;
                        ["x"] = 333.8870398445;
                    };
                    [3] = {
                        ["y"] = -188.97268280079;
                        ["x"] = 333.12190009083;
                    };
                    [1] = {
                        ["y"] = -188.97268280079;
                        ["x"] = 333.12190009083;
                    };
                    [4] = {
                        ["y"] = -181.69974815482;
                        ["x"] = 326.51537691284;
                    };
                    [5] = {
                        ["y"] = -184.32269135027;
                        ["x"] = 318.81045577323;
                    };
                };
                ["infested"] = {
                    [3] = true;
                };
                ["g"] = 62;
                ["sublevel"] = 1;
            };
            [2] = {
                ["y"] = -193.43960029182;
                ["x"] = 309.84307899816;
                ["teeming"] = true;
                ["g"] = 64;
                ["sublevel"] = 1;
            };
        };
        ["id"] = 127106;
        ["spells"] = {
            [257908] = {};
            [209859] = {};
            [277564] = {};
            [132951] = {};
        };
        ["characteristics"] = {
            ["Taunt"] = true;
            ["Silence"] = true;
            ["Root"] = true;
            ["Slow"] = true;
            ["Stun"] = true;
            ["Fear"] = true;
        };
        ["name"] = "Irontide Officer";
        ["health"] = 470912;
        ["displayId"] = 81286;
        ["creatureType"] = "Humanoid";
        ["level"] = 121;
        ["count"] = 6;
        ["scale"] = 1.2;
    };
    [34] = {
        ["clones"] = {
            [1] = {
                ["y"] = -382.04446190413;
                ["x"] = 425.81058882877;
                ["sublevel"] = 1;
                ["infested"] = {};
            };
            [2] = {
                ["y"] = -385.75685278606;
                ["x"] = 421.48066262642;
                ["sublevel"] = 1;
                ["infested"] = {};
            };
        };
        ["id"] = 127124;
        ["spells"] = {
            [277242] = {};
            [277564] = {};
        };
        ["characteristics"] = {
            ["Taunt"] = true;
            ["Silence"] = true;
            ["Slow"] = true;
            ["Root"] = true;
            ["Stun"] = true;
        };
        ["neutral"] = true;
        ["name"] = "Freehold Barhand";
        ["count"] = 1;
        ["displayId"] = 79066;
        ["creatureType"] = "Humanoid";
        ["level"] = 120;
        ["health"] = 44148;
        ["scale"] = 0.6;
    };
    [9] = {
        ["clones"] = {
            [6] = {
                ["sublevel"] = 1;
                ["x"] = 343.61269115135;
                ["y"] = -206.63347059747;
                ["g"] = 61;
                ["infested"] = {};
            };
            [2] = {
                ["sublevel"] = 1;
                ["x"] = 439.8408443899;
                ["infested"] = {
                    [3] = true;
                };
                ["g"] = 25;
                ["y"] = -404.97670441317;
            };
            [8] = {
                ["y"] = -416.32322631945;
                ["x"] = 389.17164515844;
                ["teeming"] = true;
                ["g"] = 30;
                ["sublevel"] = 1;
            };
            [3] = {
                ["sublevel"] = 1;
                ["x"] = 413.15189213078;
                ["infested"] = {
                    [3] = true;
                };
                ["g"] = 28;
                ["y"] = -421.74702628331;
            };
            [1] = {
                ["y"] = -389.52899410757;
                ["x"] = 423.95089136037;
                ["g"] = 23;
                ["sublevel"] = 1;
            };
            [4] = {
                ["sublevel"] = 1;
                ["x"] = 385.17164323575;
                ["y"] = -413.97028460597;
                ["g"] = 30;
                ["infested"] = {
                    [3] = true;
                };
            };
            [5] = {
                ["sublevel"] = 1;
                ["x"] = 407.15541870807;
                ["upstairs"] = true;
                ["infested"] = {
                    [3] = true;
                };
                ["g"] = 36;
                ["y"] = -413.02468717144;
            };
            [7] = {
                ["sublevel"] = 1;
                ["x"] = 348.24830300797;
                ["infested"] = {
                    [3] = true;
                };
                ["g"] = 63;
                ["y"] = -179.15223860385;
            };
        };
        ["scale"] = 1;
        ["spells"] = {
            [258779] = {};
            [277242] = {};
            [209859] = {};
            [132951] = {};
            [258777] = {};
            [277564] = {};
        };
        ["characteristics"] = {
            ["Taunt"] = true;
            ["Root"] = true;
            ["Stun"] = true;
            ["Slow"] = true;
            ["Silence"] = true;
            ["Fear"] = true;
        };
        ["count"] = 6;
        ["name"] = "Irontide Oarsman";
        ["displayId"] = 81279;
        ["creatureType"] = "Humanoid";
        ["level"] = 120;
        ["health"] = 470912;
        ["id"] = 127111;
    };
    [11] = {
        ["clones"] = {
            [1] = {
                ["y"] = -404.0924587256;
                ["x"] = 401.84512319017;
                ["patrol"] = {
                    [7] = {
                        ["y"] = -413.19646566235;
                        ["x"] = 424.73303316923;
                    };
                    [1] = {
                        ["y"] = -402.35383442213;
                        ["x"] = 420.86786753369;
                    };
                    [2] = {
                        ["y"] = -403.30635849927;
                        ["x"] = 408.6890842739;
                    };
                    [4] = {
                        ["y"] = -416.21912332401;
                        ["x"] = 398.33041148939;
                    };
                    [8] = {
                        ["y"] = -404.40525510319;
                        ["x"] = 429.89786041239;
                    };
                    [9] = {
                        ["y"] = -397.48218197542;
                        ["x"] = 431.21654954182;
                    };
                    [5] = {
                        ["y"] = -422.19473819736;
                        ["x"] = 406.9889465177;
                    };
                    [10] = {
                        ["y"] = -397.26239888186;
                        ["x"] = 425.83192977316;
                    };
                    [3] = {
                        ["y"] = -405.2843780455;
                        ["x"] = 402.86490775006;
                    };
                    [6] = {
                        ["y"] = -421.32832694082;
                        ["x"] = 418.2495073647;
                    };
                };
                ["sublevel"] = 1;
                ["g"] = 24;
                ["infested"] = {
                    [2] = true;
                };
            };
            [2] = {
                ["y"] = -383.65549462703;
                ["x"] = 390.71212701568;
                ["patrol"] = {
                    [1] = {
                        ["y"] = -383.65549462703;
                        ["x"] = 390.71212701568;
                    };
                    [2] = {
                        ["y"] = -367.89712183073;
                        ["x"] = 383.22821899715;
                    };
                    [4] = {
                        ["y"] = -399.1040015385;
                        ["x"] = 396.15924674565;
                    };
                    [3] = {
                        ["y"] = -383.65549462703;
                        ["x"] = 390.71212701568;
                    };
                };
                ["infested"] = {
                    [3] = true;
                };
                ["g"] = 26;
                ["sublevel"] = 1;
            };
        };
        ["scale"] = 1;
        ["spells"] = {
            [277564] = {};
            [209859] = {};
            [274383] = {};
            [277242] = {};
        };
        ["characteristics"] = {
            ["Taunt"] = true;
            ["Incapacitate"] = true;
            ["Root"] = true;
            ["Stun"] = true;
            ["Slow"] = true;
            ["Silence"] = true;
            ["Disorient"] = true;
        };
        ["count"] = 4;
        ["name"] = "Vermin Trapper";
        ["displayId"] = 87975;
        ["creatureType"] = "Humanoid";
        ["level"] = 120;
        ["health"] = 470912;
        ["id"] = 130404;
    };
    [13] = {
        ["clones"] = {
            [6] = {
                ["sublevel"] = 1;
                ["x"] = 331.11793695269;
                ["upstairs"] = true;
                ["g"] = 40;
                ["y"] = -404.65592647466;
            };
            [2] = {
                ["sublevel"] = 1;
                ["x"] = 429.0646844808;
                ["y"] = -416.84729705859;
                ["g"] = 27;
                ["infested"] = {
                    [2] = true;
                };
            };
            [3] = {
                ["y"] = -430.1081054711;
                ["x"] = 401.66124358869;
                ["g"] = 29;
                ["sublevel"] = 1;
            };
            [1] = {
                ["sublevel"] = 1;
                ["x"] = 436.03002212755;
                ["infested"] = {};
                ["g"] = 25;
                ["y"] = -403.53418131343;
            };
            [4] = {
                ["y"] = -406.67617741146;
                ["x"] = 390.70105676732;
                ["g"] = 30;
                ["sublevel"] = 1;
            };
            [5] = {
                ["sublevel"] = 1;
                ["x"] = 381.82600881022;
                ["upstairs"] = true;
                ["g"] = 31;
                ["y"] = -399.00560380624;
            };
            [7] = {
                ["y"] = -404.37020843956;
                ["x"] = 337.11795438225;
                ["patrol"] = {
                    [6] = {
                        ["y"] = -398.44196714442;
                        ["x"] = 327.71024337527;
                    };
                    [2] = {
                        ["y"] = -403.91070866502;
                        ["x"] = 348.49148529343;
                    };
                    [8] = {
                        ["y"] = -398.44196714442;
                        ["x"] = 327.71024337527;
                    };
                    [3] = {
                        ["y"] = -399.22321401722;
                        ["x"] = 353.64776293362;
                    };
                    [1] = {
                        ["y"] = -404.37020843956;
                        ["x"] = 337.11795438225;
                    };
                    [4] = {
                        ["y"] = -403.91070866502;
                        ["x"] = 348.49148529343;
                    };
                    [5] = {
                        ["y"] = -404.37020843956;
                        ["x"] = 337.11795438225;
                    };
                    [7] = {
                        ["y"] = -397.66071356611;
                        ["x"] = 315.67900934774;
                    };
                };
                ["upstairs"] = true;
                ["infested"] = {};
                ["g"] = 40;
                ["sublevel"] = 1;
            };
        };
        ["scale"] = 1;
        ["spells"] = {
            [277242] = {};
            [257774] = {};
            [257775] = {};
            [209859] = {};
            [277564] = {};
        };
        ["characteristics"] = {
            ["Taunt"] = true;
            ["Disorient"] = true;
            ["Root"] = true;
            ["Stun"] = true;
            ["Slow"] = true;
            ["Silence"] = true;
            ["Fear"] = true;
        };
        ["count"] = 4;
        ["name"] = "Bilge Rat Padfoot";
        ["displayId"] = 87973;
        ["creatureType"] = "Humanoid";
        ["level"] = 120;
        ["health"] = 294320;
        ["id"] = 129550;
    };
    [15] = {
        ["clones"] = {
            [6] = {
                ["y"] = -179.07474602562;
                ["x"] = 353.20953856669;
                ["g"] = 63;
                ["sublevel"] = 1;
            };
            [2] = {
                ["sublevel"] = 1;
                ["x"] = 348.03577726071;
                ["y"] = -210.47962597286;
                ["g"] = 61;
                ["infested"] = {
                    [1] = true;
                };
            };
            [3] = {
                ["y"] = -189.54961353475;
                ["x"] = 329.66034869884;
                ["g"] = 62;
                ["sublevel"] = 1;
            };
            [1] = {
                ["sublevel"] = 1;
                ["x"] = 409.81157801481;
                ["upstairs"] = true;
                ["y"] = -409.47715302758;
                ["g"] = 36;
                ["infested"] = {};
            };
            [4] = {
                ["sublevel"] = 1;
                ["x"] = 335.04496952557;
                ["y"] = -185.31883767005;
                ["g"] = 62;
                ["infested"] = {
                    [2] = true;
                };
            };
            [5] = {
                ["sublevel"] = 1;
                ["x"] = 359.25607129825;
                ["y"] = -182.79566621356;
                ["g"] = 63;
                ["infested"] = {};
            };
        };
        ["id"] = 130011;
        ["spells"] = {
            [257870] = {};
            [257871] = {};
            [209859] = {};
            [132951] = {};
            [277564] = {};
            [277242] = {};
        };
        ["scale"] = 1;
        ["name"] = "Irontide Buccaneer";
        ["health"] = 294320;
        ["displayId"] = 79069;
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
            ["Silence"] = true;
            ["Slow"] = true;
            ["Stun"] = true;
            ["Fear"] = true;
        };
    };
    [18] = {
        ["clones"] = {
            [7] = {
                ["sublevel"] = 1;
                ["x"] = 308.61265345302;
                ["y"] = -350.46152404495;
                ["g"] = 56;
                ["infested"] = {
                    [3] = true;
                };
            };
            [1] = {
                ["sublevel"] = 1;
                ["x"] = 304.54651527221;
                ["upstairs"] = true;
                ["y"] = -396.94162535752;
                ["g"] = 39;
                ["infested"] = {
                    [2] = true;
                };
            };
            [2] = {
                ["y"] = -380.43683254409;
                ["x"] = 340.79557911019;
                ["patrol"] = {
                    [1] = {
                        ["y"] = -380.43683254409;
                        ["x"] = 340.79557911019;
                    };
                    [2] = {
                        ["y"] = -376.25773689924;
                        ["x"] = 324.82543661657;
                    };
                    [4] = {
                        ["y"] = -362.97415223144;
                        ["x"] = 354.52691167262;
                    };
                    [3] = {
                        ["y"] = -380.43683254409;
                        ["x"] = 340.79557911019;
                    };
                };
                ["sublevel"] = 1;
                ["g"] = 44;
                ["infested"] = {
                    [3] = true;
                };
            };
            [4] = {
                ["sublevel"] = 1;
                ["x"] = 267.10371872419;
                ["infested"] = {};
                ["g"] = 47;
                ["y"] = -375.96316253381;
            };
            [8] = {
                ["y"] = -356.10490048111;
                ["x"] = 286.24269012787;
                ["infested"] = {
                    [2] = true;
                };
                ["g"] = 53;
                ["sublevel"] = 1;
            };
            [9] = {
                ["y"] = -399.75530464552;
                ["x"] = 420.8267125515;
                ["sublevel"] = 1;
                ["g"] = 72;
                ["blacktoothEvent"] = true;
            };
            [5] = {
                ["sublevel"] = 1;
                ["x"] = 320.63070067245;
                ["y"] = -337.13233898354;
                ["g"] = 51;
                ["infested"] = {};
            };
            [10] = {
                ["y"] = -332.57840453241;
                ["x"] = 325.28287529806;
                ["g"] = 51;
                ["sublevel"] = 1;
            };
            [3] = {
                ["y"] = -378.54098360649;
                ["x"] = 292.62604404009;
                ["g"] = 46;
                ["sublevel"] = 1;
            };
            [6] = {
                ["y"] = -346.0329473885;
                ["x"] = 300.04123949134;
                ["g"] = 56;
                ["sublevel"] = 1;
            };
        };
        ["id"] = 129547;
        ["spells"] = {
            [266950] = {};
            [277242] = {};
            [257732] = {};
            [209859] = {};
            [277564] = {};
        };
        ["characteristics"] = {
            ["Taunt"] = true;
            ["Incapacitate"] = true;
            ["Root"] = true;
            ["Polymorph"] = true;
            ["Sap"] = true;
            ["Silence"] = true;
            ["Slow"] = true;
            ["Stun"] = true;
            ["Fear"] = true;
        };
        ["health"] = 323752;
        ["count"] = 4;
        ["displayId"] = 81207;
        ["creatureType"] = "Humanoid";
        ["level"] = 120;
        ["name"] = "Blacktooth Knuckleduster";
        ["scale"] = 1;
    };
    [22] = {
        ["clones"] = {
            [1] = {
                ["y"] = -334.39406436921;
                ["x"] = 384.21188228675;
                ["g"] = 43;
                ["sublevel"] = 1;
            };
        };
        ["scale"] = 1;
        ["characteristics"] = {
            ["Taunt"] = true;
        };
        ["spells"] = {
            [267522] = {};
            [267533] = {};
            [267523] = {};
            [281329] = {};
            [272374] = {};
            [257821] = {};
        };
        ["isBoss"] = true;
        ["encounterID"] = 2093;
        ["instanceID"] = 1001;
        ["id"] = 126845;
        ["health"] = 2590016;
        ["displayId"] = 80532;
        ["creatureType"] = "Humanoid";
        ["level"] = 122;
        ["name"] = "Captain Jolly";
        ["count"] = 0;
    };
    [26] = {
        ["clones"] = {
            [1] = {
                ["y"] = -362.02744563276;
                ["x"] = 224.69808169065;
                ["sublevel"] = 1;
            };
        };
        ["scale"] = 1;
        ["characteristics"] = {
            ["Taunt"] = true;
        };
        ["spells"] = {
            [256405] = {};
            [256546] = {};
            [256358] = {};
            [132951] = {};
            [256363] = {};
            [256706] = {};
        };
        ["isBoss"] = true;
        ["encounterID"] = 2094;
        ["instanceID"] = 1001;
        ["id"] = 126969;
        ["health"] = 2119104;
        ["displayId"] = 55657;
        ["creatureType"] = "Humanoid";
        ["level"] = 122;
        ["name"] = "Trothak";
        ["count"] = 0;
    };
    [30] = {
        ["clones"] = {
            [1] = {
                ["y"] = -205.12285598889;
                ["x"] = 294.82907727659;
                ["g"] = 65;
                ["sublevel"] = 1;
            };
        };
        ["scale"] = 1;
        ["characteristics"] = {
            ["Taunt"] = true;
        };
        ["spells"] = {
            [257308] = {};
            [257316] = {};
            [257402] = {};
            [257305] = {};
            [257278] = {};
            [257458] = {};
            [132951] = {};
        };
        ["isBoss"] = true;
        ["encounterID"] = 2095;
        ["instanceID"] = 1001;
        ["id"] = 126983;
        ["health"] = 2943200;
        ["displayId"] = 80841;
        ["creatureType"] = "Humanoid";
        ["level"] = 122;
        ["name"] = "Harlan Sweete";
        ["count"] = 0;
    };
    [36] = {
        ["clones"] = {
            [1] = {
                ["y"] = -220.70211531603;
                ["x"] = 333.26151520657;
                ["sublevel"] = 1;
                ["infested"] = {
                    [1] = true;
                };
            };
        };
        ["scale"] = 0.6;
        ["health"] = 12;
        ["count"] = 0;
        ["displayId"] = 4959;
        ["creatureType"] = "Critter";
        ["level"] = 1;
        ["id"] = 126497;
        ["name"] = "Shiprat";
    };
    [35] = {
        ["clones"] = {
            [1] = {
                ["y"] = -403.58138534747;
                ["x"] = 423.43540478732;
                ["sublevel"] = 1;
                ["g"] = 72;
                ["blacktoothEvent"] = 0;
            };
        };
        ["scale"] = 1;
        ["health"] = 323769;
        ["count"] = 0;
        ["displayId"] = 81207;
        ["creatureType"] = "Humanoid";
        ["level"] = 120;
        ["id"] = 129547000;
        ["name"] = "Blacktooth Knuckleduster";
    };
    [1] = {
        ["clones"] = {
            [13] = {
                ["sublevel"] = 1;
                ["x"] = 312.48054510155;
                ["y"] = -187.57681227386;
                ["g"] = 64;
                ["infested"] = {};
            };
            [7] = {
                ["sublevel"] = 1;
                ["x"] = 525.02858089389;
                ["y"] = -325.85163004308;
                ["g"] = 14;
                ["infested"] = {};
            };
            [1] = {
                ["sublevel"] = 1;
                ["x"] = 581.30424951742;
                ["y"] = -218.20907864623;
                ["g"] = 1;
                ["infested"] = {
                    [3] = true;
                };
            };
            [2] = {
                ["sublevel"] = 1;
                ["x"] = 604.18640290331;
                ["y"] = -280.82105834615;
                ["g"] = 5;
                ["infested"] = {
                    [3] = true;
                };
            };
            [4] = {
                ["sublevel"] = 1;
                ["x"] = 601.33233622766;
                ["y"] = -317.90736630668;
                ["g"] = 8;
                ["infested"] = {
                    [3] = true;
                };
            };
            [8] = {
                ["sublevel"] = 1;
                ["x"] = 555.78923168149;
                ["y"] = -316.99475126787;
                ["g"] = 16;
                ["infested"] = {
                    [3] = true;
                };
            };
            [9] = {
                ["sublevel"] = 1;
                ["x"] = 553.4367362721;
                ["y"] = -357.11577737522;
                ["g"] = 20;
                ["infested"] = {
                    [1] = true;
                };
            };
            [5] = {
                ["sublevel"] = 1;
                ["x"] = 607.18948489272;
                ["y"] = -319.33598213933;
                ["g"] = 8;
                ["infested"] = {};
            };
            [10] = {
                ["y"] = -349.57479282356;
                ["x"] = 560.64984764785;
                ["g"] = 20;
                ["sublevel"] = 1;
            };
            [11] = {
                ["y"] = -313.55766795587;
                ["x"] = 539.61713085603;
                ["patrol"] = {
                    [6] = {
                        ["y"] = -326.26039064007;
                        ["x"] = 540.96845397891;
                    };
                    [2] = {
                        ["y"] = -297.88199032609;
                        ["x"] = 533.40090066634;
                    };
                    [8] = {
                        ["y"] = -326.26039064007;
                        ["x"] = 540.96845397891;
                    };
                    [3] = {
                        ["y"] = -284.36846912865;
                        ["x"] = 530.69818482811;
                    };
                    [1] = {
                        ["y"] = -313.55766795587;
                        ["x"] = 539.61713085603;
                    };
                    [4] = {
                        ["y"] = -297.88199032609;
                        ["x"] = 533.40090066634;
                    };
                    [5] = {
                        ["y"] = -313.55766795587;
                        ["x"] = 539.61713085603;
                    };
                    [7] = {
                        ["y"] = -345.44954782509;
                        ["x"] = 551.50902023078;
                    };
                };
                ["g"] = 21;
                ["sublevel"] = 1;
            };
            [3] = {
                ["sublevel"] = 1;
                ["x"] = 620.16114925439;
                ["y"] = -294.14932601393;
                ["g"] = 7;
                ["infested"] = {
                    [3] = true;
                };
            };
            [6] = {
                ["sublevel"] = 1;
                ["x"] = 550.13625665189;
                ["y"] = -271.65450774438;
                ["g"] = 9;
                ["infested"] = {
                    [3] = true;
                };
            };
            [12] = {
                ["y"] = -192.36645718052;
                ["x"] = 316.11979809251;
                ["g"] = 64;
                ["sublevel"] = 1;
            };
            [14] = {
                ["y"] = -306.78415698989;
                ["x"] = 608.62964361037;
                ["sublevel"] = 1;
                ["teeming"] = true;
                ["g"] = 17;
                ["infested"] = {
                    [3] = true;
                };
            };
        };
        ["id"] = 129602;
        ["spells"] = {
            [274860] = {};
            [277242] = {};
            [209859] = {};
            [257426] = {};
            [277564] = {};
        };
        ["characteristics"] = {
            ["Taunt"] = true;
        };
        ["name"] = "Irontide Enforcer";
        ["health"] = 470912;
        ["displayId"] = 81224;
        ["creatureType"] = "Humanoid";
        ["level"] = 121;
        ["count"] = 6;
        ["scale"] = 1.2;
    };
    [19] = {
        ["clones"] = {
            [13] = {
                ["y"] = -369.80740331685;
                ["x"] = 374.21051123508;
                ["teeming"] = true;
                ["g"] = 42;
                ["sublevel"] = 1;
            };
            [7] = {
                ["y"] = -373.58426010804;
                ["x"] = 272.20444060746;
                ["g"] = 47;
                ["sublevel"] = 1;
            };
            [1] = {
                ["sublevel"] = 1;
                ["x"] = 369.63235042592;
                ["infested"] = {};
                ["g"] = 42;
                ["y"] = -370.14405061668;
            };
            [2] = {
                ["sublevel"] = 1;
                ["x"] = 348.70601609998;
                ["y"] = -374.76519267493;
                ["g"] = 44;
                ["infested"] = {
                    [2] = true;
                };
            };
            [4] = {
                ["sublevel"] = 1;
                ["x"] = 321.14477793541;
                ["infested"] = {};
                ["g"] = 45;
                ["y"] = -377.52153190744;
            };
            [8] = {
                ["sublevel"] = 1;
                ["x"] = 265.09272006431;
                ["infested"] = {
                    [3] = true;
                };
                ["g"] = 55;
                ["y"] = -338.83704787493;
            };
            [9] = {
                ["sublevel"] = 1;
                ["x"] = 278.8854561517;
                ["upstairs"] = true;
                ["y"] = -334.84696243622;
                ["g"] = 57;
                ["infested"] = {
                    [1] = true;
                };
            };
            [5] = {
                ["y"] = -373.73130792376;
                ["x"] = 298.75211997001;
                ["g"] = 46;
                ["sublevel"] = 1;
            };
            [10] = {
                ["sublevel"] = 1;
                ["x"] = 299.24865155987;
                ["upstairs"] = true;
                ["g"] = 58;
                ["y"] = -328.72602187459;
            };
            [3] = {
                ["y"] = -378.49654042515;
                ["x"] = 345.12393045852;
                ["g"] = 44;
                ["sublevel"] = 1;
            };
            [6] = {
                ["y"] = -381.33630342414;
                ["x"] = 274.4171451901;
                ["g"] = 47;
                ["sublevel"] = 1;
            };
            [12] = {
                ["y"] = -369.49490590883;
                ["x"] = 365.14799923092;
                ["teeming"] = true;
                ["g"] = 42;
                ["sublevel"] = 1;
            };
            [11] = {
                ["sublevel"] = 1;
                ["x"] = 299.12672657478;
                ["upstairs"] = true;
                ["y"] = -325.01736614394;
                ["g"] = 58;
                ["infested"] = {};
            };
        };
        ["id"] = 129599;
        ["spells"] = {
            [277242] = {};
            [272402] = {};
            [277564] = {};
            [205276] = {};
            [209859] = {};
        };
        ["scale"] = 1;
        ["health"] = 264888;
        ["count"] = 3;
        ["displayId"] = 80335;
        ["creatureType"] = "Humanoid";
        ["level"] = 120;
        ["name"] = "Cutwater Knife Juggler";
        ["characteristics"] = {
            ["Taunt"] = true;
            ["Incapacitate"] = true;
            ["Root"] = true;
            ["Polymorph"] = true;
            ["Sap"] = true;
            ["Stun"] = true;
            ["Slow"] = true;
            ["Silence"] = true;
            ["Fear"] = true;
        };
    };
    [23] = {
        ["clones"] = {
            [7] = {
                ["y"] = -351.46153716781;
                ["x"] = 300.18408177117;
                ["g"] = 56;
                ["sublevel"] = 1;
            };
            [1] = {
                ["sublevel"] = 1;
                ["x"] = 293.07381111868;
                ["y"] = -383.01859674491;
                ["g"] = 46;
                ["infested"] = {};
            };
            [2] = {
                ["y"] = -354.6411923359;
                ["x"] = 332.47772021515;
                ["g"] = 49;
                ["sublevel"] = 1;
            };
            [4] = {
                ["y"] = -332.75510566533;
                ["x"] = 320.62785439778;
                ["g"] = 51;
                ["sublevel"] = 1;
            };
            [8] = {
                ["y"] = -358.63440018687;
                ["x"] = 283.40140347543;
                ["g"] = 53;
                ["sublevel"] = 1;
            };
            [9] = {
                ["y"] = -353.41052779996;
                ["x"] = 283.69992767171;
                ["g"] = 53;
                ["sublevel"] = 1;
            };
            [5] = {
                ["sublevel"] = 1;
                ["x"] = 320.08125237049;
                ["y"] = -341.63783109392;
                ["g"] = 51;
                ["infested"] = {
                    [2] = true;
                };
            };
            [10] = {
                ["sublevel"] = 1;
                ["x"] = 273.21381668619;
                ["upstairs"] = true;
                ["g"] = 57;
                ["y"] = -334.5484510505;
            };
            [3] = {
                ["sublevel"] = 1;
                ["x"] = 334.33487518181;
                ["y"] = -358.06975971105;
                ["g"] = 49;
                ["infested"] = {};
            };
            [6] = {
                ["y"] = -345.46152586901;
                ["x"] = 305.18409833939;
                ["g"] = 56;
                ["sublevel"] = 1;
            };
        };
        ["scale"] = 1;
        ["spells"] = {
            [272412] = {};
            [209859] = {};
            [277564] = {};
            [272413] = {};
            [277242] = {};
        };
        ["characteristics"] = {
            ["Taunt"] = true;
            ["Incapacitate"] = true;
            ["Polymorph"] = true;
            ["Stun"] = true;
            ["Root"] = true;
            ["Slow"] = true;
            ["Silence"] = true;
            ["Fear"] = true;
        };
        ["count"] = 4;
        ["name"] = "Cutwater Harpooner";
        ["displayId"] = 80343;
        ["creatureType"] = "Humanoid";
        ["level"] = 120;
        ["health"] = 294320;
        ["id"] = 129601;
    };
    [31] = {
        ["clones"] = {
            [2] = {
                ["y"] = -408.32205343838;
                ["x"] = 450.41356063263;
                ["infested"] = {};
                ["sublevel"] = 1;
            };
            [3] = {
                ["y"] = -413.52147163522;
                ["x"] = 449.47082999777;
                ["sublevel"] = 1;
            };
            [1] = {
                ["y"] = -408.30408532473;
                ["x"] = 446.86213684253;
                ["sublevel"] = 1;
                ["infested"] = {};
            };
            [4] = {
                ["sublevel"] = 1;
                ["x"] = 374.79326397897;
                ["upstairs"] = true;
                ["y"] = -404.91542632925;
                ["infested"] = {
                    [3] = true;
                };
            };
            [5] = {
                ["y"] = -354.30550063995;
                ["x"] = 388.35701675341;
                ["infested"] = {
                    [3] = true;
                };
                ["sublevel"] = 1;
            };
        };
        ["id"] = 129526;
        ["spells"] = {
            [277564] = {};
            [277242] = {};
            [274507] = {};
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
        ["neutral"] = true;
        ["health"] = 294320;
        ["name"] = "Bilge Rat Swabby";
        ["displayId"] = 80322;
        ["creatureType"] = "Humanoid";
        ["level"] = 120;
        ["count"] = 4;
        ["scale"] = 0.6;
    };
};







































