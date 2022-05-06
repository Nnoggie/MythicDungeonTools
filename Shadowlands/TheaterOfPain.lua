local MDT = MDT
local L = MDT.L
local dungeonIndex = 36
MDT.dungeonList[dungeonIndex] = L["Theater of Pain"]
MDT.mapInfo[dungeonIndex] = {
    viewportPositionOverrides =
    {
        [1] = {
            zoomScale = 2.1999998092651;
            horizontalPan = 233.72766555588;
            verticalPan = 188.09071841916;
        };
        [2] = {
            zoomScale = 1.2999999523163;
            horizontalPan = 118.01058420157;
            verticalPan = 57.697244781145;
        };
        [3] = {
            zoomScale = 1.2999999523163;
            horizontalPan = 175.74260337036;
            verticalPan = 62.424803754491;
        };
        [4] = {
            zoomScale = 1.2999999523163;
            horizontalPan = 124.21960940533;
            verticalPan = 75.315651737871;
        };
        [5] = {
            zoomScale = 1.2999999523163;
            horizontalPan = 68.068100349919;
            verticalPan = 76.939706850476;
        };
    }

};
MDT.scaleMultiplier[dungeonIndex] = 1.3

MDT.dungeonMaps[dungeonIndex] = {
   [0] = "TheaterOfPain",
   [1] = "TheaterOfPain",
   [2] = "TheaterOfPain_Warlord",
   [3] = "TheaterOfPain_Lich",
   [4] = "TheaterOfPain_AbomTop",
   [5] = "TheaterOfPain_AbomBot",
}
MDT.dungeonSubLevels[dungeonIndex] = {
    [1] = L["TheaterOfPainFloor1"],
    [2] = L["TheaterOfPainFloor2"],
    [3] = L["TheaterOfPainFloor3"],
    [4] = L["TheaterOfPainFloor4"],
    [5] = L["TheaterOfPainFloor5"],
}

MDT.dungeonTotalCount[dungeonIndex] = {normal=271,teeming=1000,teemingEnabled=true}
MDT.mapPOIs[dungeonIndex] = {
    [1] = {
        [1] = {
            ["y"] = -213.03570672361;
            ["x"] = 422.3263894392;
            ["connectionIndex"] = 1;
            ["target"] = 2;
            ["type"] = "mapLink";
            ["template"] = "MapLinkPinTemplate";
            ["direction"] = -1;
        };
    };
    [2] = {
        [1] = {
            ["y"] = -190.01484617386;
            ["x"] = 271.56378333015;
            ["connectionIndex"] = 1;
            ["target"] = 1;
            ["type"] = "mapLink";
            ["template"] = "MapLinkPinTemplate";
            ["direction"] = 1;
        };
        [2] = {
            ["y"] = -98.174992961846;
            ["x"] = 270.7719140048;
            ["connectionIndex"] = 2;
            ["target"] = 3;
            ["type"] = "mapLink";
            ["template"] = "MapLinkPinTemplate";
            ["direction"] = 1;
        };
        [3] = {
            ["y"] = -160.7212020877;
            ["x"] = 179.72326263409;
            ["connectionIndex"] = 3;
            ["target"] = 4;
            ["type"] = "mapLink";
            ["template"] = "MapLinkPinTemplate";
            ["direction"] = -2;
        };
        [4] = {
            ["y"] = -371.66498923535;
            ["x"] = 395.77796738459;
            ["template"] = "MapLinkPinTemplate";
            ["text"] = L["theaterOfPain_miniBossNote"];
            ["scale"] = 2;
            ["type"] = "generalNote";
        };
        [5] = {
            ["y"] = -286.77060932602;
            ["x"] = 479.7469803976;
            ["template"] = "MapLinkPinTemplate";
            ["text"] = L["theaterOfPain_miniBossNote"];
            ["scale"] = 2;
            ["type"] = "generalNote";
        };
        [6] = {
            ["y"] = -435.65690452825;
            ["x"] = 603.84404895006;
            ["template"] = "MapLinkPinTemplate";
            ["scale"] = 2;
            ["text"] = L["theaterOfPain_miniBossNote"];
            ["type"] = "generalNote";
        };
    };
    [3] = {
        [1] = {
            ["y"] = -465.53471872035;
            ["x"] = 600.91809113105;
            ["connectionIndex"] = 2;
            ["target"] = 2;
            ["type"] = "mapLink";
            ["template"] = "MapLinkPinTemplate";
            ["direction"] = -1;
        };
    };
    [4] = {
        [1] = {
            ["y"] = -388.73733430644;
            ["x"] = 689.5927878488;
            ["connectionIndex"] = 3;
            ["target"] = 2;
            ["type"] = "mapLink";
            ["template"] = "MapLinkPinTemplate";
            ["direction"] = 2;
        };
        [2] = {
            ["y"] = -365.77737100344;
            ["x"] = 155.17979851978;
            ["connectionIndex"] = 4;
            ["target"] = 5;
            ["type"] = "mapLink";
            ["template"] = "MapLinkPinTemplate";
            ["direction"] = 1;
        };
        [3] = {
            ["y"] = -140.92807052201;
            ["x"] = 213.76718798327;
            ["connectionIndex"] = 5;
            ["target"] = 5;
            ["type"] = "mapLink";
            ["template"] = "MapLinkPinTemplate";
            ["direction"] = -1;
        };
    };
    [5] = {
        [1] = {
            ["y"] = -123.51013920768;
            ["x"] = 212.18385705726;
            ["connectionIndex"] = 5;
            ["target"] = 4;
            ["type"] = "mapLink";
            ["template"] = "MapLinkPinTemplate";
            ["direction"] = 1;
        };
        [2] = {
            ["y"] = -330.14987688884;
            ["x"] = 144.09573454242;
            ["connectionIndex"] = 4;
            ["target"] = 4;
            ["type"] = "mapLink";
            ["template"] = "MapLinkPinTemplate";
            ["direction"] = -1;
        };
        [3] = {
            ["y"] = -472.65995527842;
            ["x"] = 543.91574181367;
            ["connectionIndex"] = 6;
            ["target"] = 4;
            ["type"] = "mapLink";
            ["template"] = "MapLinkPinTemplate";
            ["direction"] = 1;
        };
    };
};

MDT.dungeonEnemies[dungeonIndex] = {
   [27] = {
      ["clones"] = {
         [1] = {
            ["y"] = -358.71618298082;
            ["x"] = 592.37901639344;
            ["sublevel"] = 5;
         };
      };
      ["characteristics"] = {
         ["Taunt"] = true;
      };
      ["id"] = 162317;
      ["spells"] = {
         [323515] = {};
         [318406] = {};
      };
      ["isBoss"] = true;
      ["encounterID"] = 2401;
      ["instanceID"] = 1187;
      ["health"] = "1156970";
      ["name"] = "Gorechop";
      ["displayId"] = 95106;
      ["creatureType"] = "Undead";
      ["level"] = 60;
      ["count"] = 0;
      ["scale"] = 1.7;
   };
   [2] = {
      ["clones"] = {
         [1] = {
            ["y"] = -377.64987321577;
            ["x"] = 436.14551912457;
            ["g"] = 1;
            ["sublevel"] = 1;
         };
         [2] = {
            ["sublevel"] = 1;
            ["inspiring"] = true;
            ["x"] = 415.95011330293;
            ["g"] = 1;
            ["y"] = -378.82713636876;
         };
      };
      ["id"] = 170838;
      ["spells"] = {
         [331510] = {};
         [337178] = {};
         [320679] = {};
      };
      ["characteristics"] = {
         ["Taunt"] = true;
         ["Incapacitate"] = true;
         ["Root"] = true;
         ["Fear"] = true;
         ["Disorient"] = true;
         ["Polymorph"] = true;
         ["Mind Control"] = true;
         ["Sap"] = true;
         ["Stun"] = true;
         ["Silence"] = true;
         ["Slow"] = true;
         ["Imprison"] = true;
         ["Repentance"] = true;
      };
      ["health"] = "189974";
      ["name"] = "Unyielding Contender";
      ["displayId"] = 95570;
      ["creatureType"] = "Humanoid";
      ["level"] = 60;
      ["count"] = 4;
      ["scale"] = 1;
   };
   [38] = {
      ["clones"] = {
         [13] = {
            ["y"] = -383.84057775398;
            ["x"] = 625.10556729424;
            ["sublevel"] = 3;
         };
         [7] = {
            ["y"] = -181.17947825743;
            ["x"] = 322.55309712691;
            ["sublevel"] = 4;
         };
         [1] = {
            ["y"] = -333.89785858455;
            ["x"] = 442.74368474552;
            ["sublevel"] = 1;
         };
         [2] = {
            ["y"] = -259.62514590239;
            ["x"] = 443.81947319785;
            ["sublevel"] = 1;
         };
         [4] = {
            ["y"] = -388.99026753789;
            ["x"] = 595.03013804036;
            ["sublevel"] = 2;
         };
         [8] = {
            ["y"] = -343.48719386263;
            ["x"] = 278.32229800096;
            ["sublevel"] = 4;
         };
         [9] = {
            ["y"] = -366.97458316778;
            ["x"] = 548.48734106492;
            ["sublevel"] = 5;
         };
         [5] = {
            ["y"] = -460.79489052776;
            ["x"] = 437.76942987652;
            ["sublevel"] = 2;
         };
         [10] = {
            ["y"] = -460.23078661701;
            ["x"] = 558.0507822445;
            ["sublevel"] = 3;
         };
         [3] = {
            ["y"] = -344.65677697257;
            ["x"] = 355.78818699529;
            ["sublevel"] = 2;
         };
         [6] = {
            ["y"] = -350.31562107243;
            ["x"] = 579.37355513948;
            ["sublevel"] = 4;
         };
         [12] = {
            ["y"] = -146.90788866538;
            ["x"] = 343.81917163948;
            ["sublevel"] = 3;
         };
         [11] = {
            ["y"] = -170.97620989954;
            ["x"] = 539.90923570527;
            ["sublevel"] = 3;
         };
      };
      ["include"] = {
         ["level"] = 10;
         ["affix"] = 130;
      };
      ["id"] = 185680;
      ["level"] = 62;
      ["scale"] = 1;
      ["spells"] = {
         [366406] = {};
         [368103] = {};
         [366409] = {};
      };
      ["badCreatureModel"] = true;
      ["displayId"] = 103111;
      ["health"] = "33039";
      ["ignoreFortified"] = true;
      ["count"] = 0;
      ["bonusSpell"] = 368240;
      ["creatureType"] = "Mechanical";
      ["modelPosition"] = {
         [1] = 0;
         [2] = 0;
         [3] = 0.75;
      };
      ["name"] = "Vy Relic";
      ["iconTexture"] = 4335643;
   };
   [3] = {
      ["clones"] = {
         [1] = {
            ["y"] = -360.09502773364;
            ["x"] = 426.28482697188;
            ["g"] = 1;
            ["sublevel"] = 1;
         };
      };
      ["id"] = 170850;
      ["spells"] = {
         [333241] = {};
      };
      ["stealthDetect"] = true;
      ["characteristics"] = {
         ["Taunt"] = true;
      };
      ["health"] = "297351";
      ["name"] = "Raging Bloodhorn";
      ["displayId"] = 96471;
      ["creatureType"] = "Beast";
      ["level"] = 60;
      ["count"] = 7;
      ["scale"] = 1.4;
   };
   [4] = {
      ["clones"] = {
         [1] = {
            ["y"] = -316.62293787175;
            ["x"] = 424.80025384949;
            ["g"] = 2;
            ["sublevel"] = 1;
         };
      };
      ["characteristics"] = {
         ["Taunt"] = true;
      };
      ["id"] = 164451;
      ["spells"] = {
         [326892] = {};
         [324085] = {};
         [320069] = {};
         [320063] = {};
      };
      ["isBoss"] = true;
      ["encounterID"] = 2397;
      ["instanceID"] = 1187;
      ["health"] = "595013";
      ["name"] = "Dessia the Decapitator";
      ["displayId"] = 96820;
      ["creatureType"] = "Humanoid";
      ["level"] = 60;
      ["count"] = 0;
      ["scale"] = 1;
   };
   [5] = {
      ["clones"] = {
         [1] = {
            ["y"] = -312.17559207043;
            ["x"] = 407.16087432211;
            ["g"] = 2;
            ["sublevel"] = 1;
         };
      };
      ["characteristics"] = {
         ["Taunt"] = true;
      };
      ["id"] = 164463;
      ["spells"] = {
         [320120] = {};
         [320248] = {};
         [320180] = {};
      };
      ["isBoss"] = true;
      ["encounterID"] = 2397;
      ["instanceID"] = 1187;
      ["health"] = "528901";
      ["name"] = "Paceran the Virulent";
      ["displayId"] = 98081;
      ["creatureType"] = "Humanoid";
      ["level"] = 60;
      ["count"] = 0;
      ["scale"] = 1;
   };
   [6] = {
      ["clones"] = {
         [1] = {
            ["y"] = -310.12570727863;
            ["x"] = 447.30744238781;
            ["g"] = 2;
            ["sublevel"] = 1;
         };
      };
      ["characteristics"] = {
         ["Taunt"] = true;
      };
      ["id"] = 164461;
      ["spells"] = {
         [320300] = {
            ["interruptible"] = true;
         };
         [320293] = {};
         [320272] = {};
         [333231] = {
            ["interruptible"] = true;
         };
      };
      ["isBoss"] = true;
      ["encounterID"] = 2397;
      ["instanceID"] = 1187;
      ["health"] = "462788";
      ["name"] = "Sathel the Accursed";
      ["displayId"] = 98082;
      ["creatureType"] = "Humanoid";
      ["level"] = 60;
      ["count"] = 0;
      ["scale"] = 1;
   };
   [7] = {
      ["clones"] = {
         [1] = {
            ["y"] = -294.92170535281;
            ["x"] = 425.25134183422;
            ["g"] = 2;
            ["sublevel"] = 1;
         };
      };
      ["id"] = 164464;
      ["spells"] = {
         [333540] = {};
      };
      ["characteristics"] = {
         ["Incapacitate"] = true;
         ["Root"] = true;
         ["Polymorph"] = true;
         ["Disorient"] = true;
         ["Fear"] = true;
         ["Silence"] = true;
         ["Stun"] = true;
         ["Slow"] = true;
         ["Imprison"] = true;
         ["Repentance"] = true;
      };
      ["health"] = "67427";
      ["name"] = "Xira the Underhanded";
      ["displayId"] = 96440;
      ["creatureType"] = "Humanoid";
      ["level"] = 60;
      ["count"] = 0;
      ["scale"] = 1.3;
   };
   [8] = {
      ["clones"] = {
         [1] = {
            ["y"] = -307.15338954092;
            ["x"] = 354.98940856123;
            ["g"] = 3;
            ["sublevel"] = 2;
         };
         [2] = {
            ["y"] = -347.05532003364;
            ["x"] = 555.36255378945;
            ["g"] = 4;
            ["sublevel"] = 2;
         };
         [3] = {
            ["y"] = -357.30152934993;
            ["x"] = 543.70316598326;
            ["g"] = 4;
            ["sublevel"] = 2;
         };
      };
      ["id"] = 164510;
      ["spells"] = {
         [330532] = {};
         [319997] = {};
      };
      ["characteristics"] = {
         ["Taunt"] = true;
         ["Incapacitate"] = true;
         ["Shackle Undead"] = true;
         ["Root"] = true;
         ["Control Undead"] = true;
         ["Polymorph"] = true;
         ["Disorient"] = true;
         ["Silence"] = true;
         ["Slow"] = true;
         ["Stun"] = true;
         ["Repentance"] = true;
      };
      ["health"] = "140416";
      ["name"] = "Shambling Arbalest";
      ["displayId"] = 96212;
      ["creatureType"] = "Undead";
      ["level"] = 60;
      ["count"] = 4;
      ["scale"] = 1.4;
   };
   [10] = {
      ["clones"] = {
         [1] = {
            ["y"] = -343.48473546349;
            ["x"] = 397.85742796173;
            ["sublevel"] = 2;
         };
      };
      ["id"] = 167538;
      ["spells"] = {
         [331316] = {};
         [342125] = {};
         [342139] = {
            ["interruptible"] = true;
         };
         [320661] = {};
      };
      ["characteristics"] = {
         ["Taunt"] = true;
      };
      ["health"] = "528624";
      ["name"] = "Dokigg the Brutalizer";
      ["displayId"] = 97488;
      ["creatureType"] = "Humanoid";
      ["level"] = 60;
      ["count"] = 20;
      ["scale"] = 2;
   };
   [12] = {
      ["clones"] = {
         [1] = {
            ["sublevel"] = 2;
            ["inspiring"] = true;
            ["x"] = 540.18588235294;
            ["g"] = 4;
            ["y"] = -341.25970588235;
         };
      };
      ["id"] = 164506;
      ["spells"] = {
         [330565] = {};
         [330562] = {};
         [330545] = {};
      };
      ["characteristics"] = {
         ["Taunt"] = true;
         ["Incapacitate"] = true;
         ["Shackle Undead"] = true;
         ["Root"] = true;
         ["Control Undead"] = true;
         ["Polymorph"] = true;
         ["Disorient"] = true;
         ["Silence"] = true;
         ["Slow"] = true;
         ["Stun"] = true;
         ["Repentance"] = true;
      };
      ["health"] = "198234";
      ["name"] = "Ancient Captain";
      ["displayId"] = 96489;
      ["creatureType"] = "Undead";
      ["level"] = 60;
      ["count"] = 5;
      ["scale"] = 1.4;
   };
   [14] = {
      ["clones"] = {
         [1] = {
            ["y"] = -428.74506576871;
            ["x"] = 444.67525268025;
            ["sublevel"] = 2;
         };
      };
      ["characteristics"] = {
         ["Taunt"] = true;
      };
      ["id"] = 162329;
      ["spells"] = {
         [320050] = {};
         [320789] = {};
         [317231] = {};
         [316995] = {};
         [320644] = {};
         [318102] = {};
         [316981] = {};
         [320114] = {};
         [331618] = {};
         [320729] = {};
         [320661] = {};
         [339415] = {};
      };
      ["isBoss"] = true;
      ["encounterID"] = 2390;
      ["instanceID"] = 1187;
      ["health"] = "1041274";
      ["name"] = "Xav the Unfallen";
      ["displayId"] = 95439;
      ["creatureType"] = "Humanoid";
      ["level"] = 60;
      ["count"] = 0;
      ["scale"] = 1.6;
   };
   [16] = {
      ["clones"] = {
         [1] = {
            ["y"] = -379.31540779101;
            ["x"] = 441.02902490517;
            ["sublevel"] = 3;
         };
         [2] = {
            ["y"] = -244.00904173618;
            ["x"] = 237.13183673108;
            ["g"] = 11;
            ["sublevel"] = 3;
         };
      };
      ["id"] = 167998;
      ["spells"] = {
         [326497] = {};
         [330716] = {};
         [330725] = {};
      };
      ["characteristics"] = {
         ["Taunt"] = true;
      };
      ["health"] = "247793";
      ["name"] = "Portal Guardian";
      ["displayId"] = 96442;
      ["creatureType"] = "Elemental";
      ["level"] = 60;
      ["count"] = 8;
      ["scale"] = 1.6;
   };
   [20] = {
      ["clones"] = {
         [1] = {
            ["y"] = -181.2467434963;
            ["x"] = 688.0705148888;
            ["g"] = 20;
            ["sublevel"] = 3;
         };
         [2] = {
            ["y"] = -139.82777941021;
            ["x"] = 361.92524661901;
            ["g"] = 15;
            ["sublevel"] = 3;
         };
         [3] = {
            ["y"] = -121.70713568059;
            ["x"] = 360.50205811328;
            ["g"] = 15;
            ["sublevel"] = 3;
         };
      };
      ["id"] = 169893;
      ["spells"] = {
         [333299] = {};
         [330875] = {
            ["interruptible"] = true;
         };
         [333294] = {};
      };
      ["characteristics"] = {
         ["Taunt"] = true;
      };
      ["health"] = "231273";
      ["name"] = "Nefarious Darkspeaker";
      ["displayId"] = 97011;
      ["creatureType"] = "Undead";
      ["level"] = 60;
      ["count"] = 6;
      ["scale"] = 1.6;
   };
   [24] = {
      ["clones"] = {
         [1] = {
            ["y"] = -376.69768033662;
            ["x"] = 618.37804306107;
            ["sublevel"] = 4;
         };
         [2] = {
            ["sublevel"] = 5;
            ["inspiring"] = true;
            ["x"] = 256.26178173145;
            ["g"] = 24;
            ["y"] = -233.66050126322;
         };
         [3] = {
            ["y"] = -306.46483030005;
            ["x"] = 468.63737704918;
            ["g"] = 26;
            ["sublevel"] = 5;
         };
      };
      ["id"] = 170690;
      ["spells"] = {
         [341977] = {
            ["interruptible"] = true;
         };
         [330697] = {};
         [330700] = {};
      };
      ["characteristics"] = {
         ["Taunt"] = true;
         ["Incapacitate"] = true;
         ["Shackle Undead"] = true;
         ["Root"] = true;
         ["Control Undead"] = true;
         ["Polymorph"] = true;
         ["Disorient"] = true;
         ["Silence"] = true;
         ["Slow"] = true;
         ["Stun"] = true;
         ["Repentance"] = true;
      };
      ["health"] = "165195";
      ["name"] = "Diseased Horror";
      ["displayId"] = 97117;
      ["creatureType"] = "Undead";
      ["level"] = 60;
      ["count"] = 4;
      ["scale"] = 1.7;
   };
   [28] = {
      ["clones"] = {
         [1] = {
            ["y"] = -260.65634874517;
            ["x"] = 425.28479370126;
            ["sublevel"] = 1;
         };
      };
      ["characteristics"] = {
         ["Taunt"] = true;
      };
      ["id"] = 165946;
      ["spells"] = {
         [324449] = {};
         [339573] = {};
         [324079] = {};
         [323608] = {};
         [323683] = {};
      };
      ["isBoss"] = true;
      ["encounterID"] = 2417;
      ["instanceID"] = 1187;
      ["health"] = "1322252";
      ["name"] = "Mordretha, the Endless Empress";
      ["displayId"] = 96078;
      ["creatureType"] = "Humanoid";
      ["level"] = 60;
      ["count"] = 0;
      ["scale"] = 1;
   };
   [32] = {
      ["clones"] = {
         [1] = {
            ["sublevel"] = 3;
            ["x"] = 430.59506927145;
            ["y"] = -398.57442329702;
            ["week"] = {
               [6] = true;
               [2] = true;
               [10] = true;
               [1] = true;
               [5] = true;
               [9] = true;
            };
         };
         [2] = {
            ["y"] = -442.63947583949;
            ["x"] = 279.33024418979;
            ["week"] = {
               [11] = true;
               [7] = true;
               [8] = true;
               [3] = true;
               [12] = true;
               [4] = true;
            };
            ["sublevel"] = 4;
         };
      };
      ["powers"] = {
         [357864] = {
            ["dps"] = true;
         };
         [357889] = {
            ["healer"] = true;
         };
         [357848] = {
            ["dps"] = true;
         };
         [357900] = {
            ["healer"] = true;
         };
         [357839] = {
            ["tank"] = true;
         };
         [357897] = {
            ["tank"] = true;
         };
         [357575] = {
            ["tank"] = true;
            ["dps"] = true;
            ["healer"] = true;
         };
      };
      ["id"] = 179446;
      ["spells"] = {
         [355732] = {};
         [358967] = {
            ["interruptible"] = true;
         };
         [355707] = {};
         [355737] = {};
      };
      ["include"] = {
         ["level"] = 10;
         ["affix"] = 128;
      };
      ["scale"] = 1.5;
      ["count"] = 0;
      ["ignoreFortified"] = true;
      ["name"] = "Incinerator Arkolath";
      ["displayId"] = 100718;
      ["creatureType"] = "Humanoid";
      ["level"] = 61;
      ["health"] = 336131;
      ["iconTexture"] = 236297;
   };
   [33] = {
      ["clones"] = {
         [1] = {
            ["y"] = -442.63947583949;
            ["x"] = 279.33024418979;
            ["week"] = {
               [6] = true;
               [2] = true;
               [10] = true;
               [1] = true;
               [5] = true;
               [9] = true;
            };
            ["sublevel"] = 4;
         };
         [2] = {
            ["y"] = -398.57442329702;
            ["x"] = 430.59506927145;
            ["week"] = {
               [11] = true;
               [7] = true;
               [8] = true;
               [3] = true;
               [12] = true;
               [4] = true;
            };
            ["sublevel"] = 3;
         };
      };
      ["powers"] = {
         [357815] = {
            ["healer"] = true;
            ["dps"] = true;
         };
         [357817] = {
            ["tank"] = true;
         };
         [357842] = {
            ["healer"] = true;
         };
         [357829] = {
            ["healer"] = true;
         };
         [357825] = {
            ["dps"] = true;
         };
         [357820] = {
            ["tank"] = true;
         };
         [357834] = {
            ["tank"] = true;
            ["dps"] = true;
         };
      };
      ["id"] = 179892;
      ["spells"] = {
         [358894] = {};
         [356666] = {};
         [355710] = {};
         [356414] = {};
      };
      ["include"] = {
         ["level"] = 10;
         ["affix"] = 128;
      };
      ["scale"] = 1.5;
      ["count"] = 0;
      ["ignoreFortified"] = true;
      ["name"] = "Oros Coldheart";
      ["displayId"] = 97237;
      ["creatureType"] = "Humanoid";
      ["level"] = 61;
      ["health"] = 336131;
      ["iconTexture"] = 136213;
   };
   [17] = {
      ["clones"] = {
         [7] = {
            ["y"] = -173.83620689655;
            ["x"] = 517.60762807421;
            ["g"] = 17;
            ["sublevel"] = 3;
         };
         [1] = {
            ["y"] = -247.96379310345;
            ["x"] = 423.20502604965;
            ["g"] = 9;
            ["sublevel"] = 3;
         };
         [2] = {
            ["y"] = -261.29593453625;
            ["x"] = 422.31156773909;
            ["g"] = 9;
            ["sublevel"] = 3;
         };
         [4] = {
            ["y"] = -205.97517241379;
            ["x"] = 220.47747471652;
            ["g"] = 13;
            ["sublevel"] = 3;
         };
         [8] = {
            ["y"] = -146.19714512207;
            ["x"] = 531.65243656623;
            ["g"] = 19;
            ["sublevel"] = 3;
         };
         [9] = {
            ["y"] = -146.56018208781;
            ["x"] = 521.32170687694;
            ["g"] = 19;
            ["sublevel"] = 3;
         };
         [5] = {
            ["y"] = -208.33651035875;
            ["x"] = 230.32732814058;
            ["g"] = 13;
            ["sublevel"] = 3;
         };
         [10] = {
            ["y"] = -221.45528452265;
            ["x"] = 519.770071015;
            ["g"] = 18;
            ["sublevel"] = 3;
         };
         [3] = {
            ["sublevel"] = 3;
            ["inspiring"] = true;
            ["x"] = 223.4363635099;
            ["g"] = 11;
            ["y"] = -234.02753274733;
         };
         [6] = {
            ["y"] = -190.90730325918;
            ["x"] = 514.72439178858;
            ["g"] = 17;
            ["sublevel"] = 3;
         };
         [12] = {
            ["y"] = -182.91656629595;
            ["x"] = 673.39166607526;
            ["g"] = 20;
            ["sublevel"] = 3;
         };
         [11] = {
            ["y"] = -215.75213418438;
            ["x"] = 512.79242628588;
            ["g"] = 18;
            ["sublevel"] = 3;
         };
      };
      ["id"] = 170882;
      ["spells"] = {
         [341771] = {
            ["interruptible"] = true;
         };
         [342675] = {
            ["interruptible"] = true;
         };
         [333293] = {};
      };
      ["characteristics"] = {
         ["Taunt"] = true;
         ["Incapacitate"] = true;
         ["Shackle Undead"] = true;
         ["Root"] = true;
         ["Control Undead"] = true;
         ["Polymorph"] = true;
         ["Disorient"] = true;
         ["Stun"] = true;
         ["Slow"] = true;
         ["Silence"] = true;
         ["Repentance"] = true;
      };
      ["health"] = "82598";
      ["name"] = "Bone Magus";
      ["displayId"] = 97410;
      ["creatureType"] = "Undead";
      ["level"] = 60;
      ["count"] = 4;
      ["scale"] = 1;
   };
   [21] = {
      ["clones"] = {
         [1] = {
            ["y"] = -387.79723803804;
            ["x"] = 601.60510814109;
            ["sublevel"] = 3;
         };
      };
      ["characteristics"] = {
         ["Taunt"] = true;
      };
      ["id"] = 162309;
      ["spells"] = {
         [319567] = {};
         [319626] = {};
         [319669] = {
            ["interruptible"] = true;
         };
         [333567] = {};
         [319539] = {};
         [319521] = {};
         [322087] = {};
      };
      ["isBoss"] = true;
      ["encounterID"] = 2389;
      ["instanceID"] = 1187;
      ["health"] = "1388364";
      ["name"] = "Kul'tharok";
      ["displayId"] = 96088;
      ["creatureType"] = "Undead";
      ["level"] = 60;
      ["count"] = 0;
      ["scale"] = 1.3;
   };
   [25] = {
      ["clones"] = {
         [1] = {
            ["y"] = -333.6005902607;
            ["x"] = 561.86360655738;
            ["sublevel"] = 4;
         };
         [2] = {
            ["sublevel"] = 4;
            ["x"] = 402.42885245902;
            ["patrol"] = {
               [6] = {
                  ["y"] = -286.22073114055;
                  ["x"] = 366.42607761119;
               };
               [2] = {
                  ["y"] = -307.12220993859;
                  ["x"] = 430.39730118435;
               };
               [8] = {
                  ["y"] = -286.22073114055;
                  ["x"] = 366.42607761119;
               };
               [3] = {
                  ["y"] = -320.73984253565;
                  ["x"] = 476.31724576045;
               };
               [1] = {
                  ["y"] = -295.43580914904;
                  ["x"] = 402.42885245902;
               };
               [4] = {
                  ["y"] = -307.12220993859;
                  ["x"] = 430.39730118435;
               };
               [5] = {
                  ["y"] = -295.43580914904;
                  ["x"] = 402.42885245902;
               };
               [7] = {
                  ["y"] = -275.13661174284;
                  ["x"] = 334.12381320004;
               };
            };
            ["g"] = 23;
            ["y"] = -295.43580914904;
         };
         [4] = {
            ["y"] = -327.5400885391;
            ["x"] = 465.19475409836;
            ["g"] = 26;
            ["sublevel"] = 5;
         };
         [3] = {
            ["y"] = -255.18654883365;
            ["x"] = 233.817844216;
            ["g"] = 24;
            ["sublevel"] = 5;
         };
      };
      ["id"] = 169927;
      ["spells"] = {
         [332836] = {};
         [330586] = {};
      };
      ["characteristics"] = {
         ["Taunt"] = true;
         ["Incapacitate"] = true;
         ["Shackle Undead"] = true;
         ["Root"] = true;
         ["Control Undead"] = true;
         ["Polymorph"] = true;
         ["Disorient"] = true;
         ["Silence"] = true;
         ["Slow"] = true;
         ["Stun"] = true;
         ["Repentance"] = true;
      };
      ["health"] = "198234";
      ["name"] = "Putrid Butcher";
      ["displayId"] = 97116;
      ["creatureType"] = "Undead";
      ["level"] = 60;
      ["count"] = 5;
      ["scale"] = 1.7;
   };
   [29] = {
      ["clones"] = {
         [1] = {
            ["y"] = -359.25817412643;
            ["x"] = 372.65828278898;
            ["sublevel"] = 2;
         };
      };
      ["scale"] = 2;
      ["spells"] = {
         [342135] = {};
         [317605] = {};
         [336996] = {};
      };
      ["characteristics"] = {
         ["Taunt"] = true;
      };
      ["health"] = 256320;
      ["count"] = 20;
      ["displayId"] = 97489;
      ["creatureType"] = "Humanoid";
      ["level"] = 61;
      ["name"] = "Nekthara the Mangler";
      ["id"] = 162744;
   };
   [34] = {
      ["clones"] = {
         [1] = {
            ["y"] = -381.60862941344;
            ["x"] = 362.21784027017;
            ["week"] = {
               [6] = true;
               [2] = true;
               [10] = true;
               [1] = true;
               [5] = true;
               [9] = true;
            };
            ["sublevel"] = 2;
         };
         [2] = {
            ["y"] = -157.88409820652;
            ["x"] = 295.01191596194;
            ["week"] = {
               [11] = true;
               [7] = true;
               [8] = true;
               [3] = true;
               [12] = true;
               [4] = true;
            };
            ["sublevel"] = 2;
         };
      };
      ["powers"] = {
         [356828] = {
            ["dps"] = true;
            ["tank"] = true;
         };
         [356827] = {
            ["healer"] = true;
            ["dps"] = true;
         };
         [357524] = {
            ["tank"] = true;
            ["dps"] = true;
            ["healer"] = true;
         };
         [357778] = {
            ["tank"] = true;
         };
         [357556] = {
            ["healer"] = true;
         };
      };
      ["id"] = 179891;
      ["spells"] = {
         [358970] = {};
         [355719] = {};
         [358784] = {};
         [358968] = {};
         [355806] = {};
      };
      ["include"] = {
         ["level"] = 10;
         ["affix"] = 128;
      };
      ["scale"] = 1.5;
      ["count"] = 0;
      ["ignoreFortified"] = true;
      ["name"] = "Soggodon the Breaker";
      ["displayId"] = 98535;
      ["creatureType"] = "Humanoid";
      ["level"] = 62;
      ["health"] = 358540;
      ["iconTexture"] = 2103898;
   };
   [9] = {
      ["clones"] = {
         [1] = {
            ["y"] = -292.89961904445;
            ["x"] = 351.42831609161;
            ["g"] = 3;
            ["sublevel"] = 2;
         };
         [2] = {
            ["sublevel"] = 2;
            ["inspiring"] = true;
            ["x"] = 342.01968864097;
            ["g"] = 3;
            ["y"] = -300.98918764544;
         };
         [4] = {
            ["y"] = -350.03300694518;
            ["x"] = 528.62528718793;
            ["g"] = 4;
            ["sublevel"] = 2;
         };
         [3] = {
            ["y"] = -331.15964712066;
            ["x"] = 550.63634296576;
            ["g"] = 4;
            ["sublevel"] = 2;
         };
      };
      ["id"] = 167994;
      ["spells"] = {
         [326835] = {};
      };
      ["characteristics"] = {
         ["Taunt"] = true;
         ["Incapacitate"] = true;
         ["Shackle Undead"] = true;
         ["Root"] = true;
         ["Control Undead"] = true;
         ["Polymorph"] = true;
         ["Disorient"] = true;
         ["Silence"] = true;
         ["Slow"] = true;
         ["Stun"] = true;
         ["Repentance"] = true;
      };
      ["health"] = "165195";
      ["name"] = "Ossified Conscript";
      ["displayId"] = 96253;
      ["creatureType"] = "Undead";
      ["level"] = 60;
      ["count"] = 4;
      ["scale"] = 1.4;
   };
   [11] = {
      ["clones"] = {
         [1] = {
            ["y"] = -262.45855065989;
            ["x"] = 486.49272307954;
            ["sublevel"] = 2;
         };
      };
      ["id"] = 167536;
      ["spells"] = {
         [333861] = {};
         [342139] = {
            ["interruptible"] = true;
         };
         [334023] = {};
         [334025] = {};
      };
      ["characteristics"] = {
         ["Taunt"] = true;
      };
      ["health"] = "528624";
      ["name"] = "Harugia the Bloodthirsty";
      ["displayId"] = 95969;
      ["creatureType"] = "Humanoid";
      ["level"] = 60;
      ["count"] = 20;
      ["scale"] = 2;
   };
   [13] = {
      ["clones"] = {
         [1] = {
            ["y"] = -424.69488113351;
            ["x"] = 581.61127034463;
            ["sublevel"] = 2;
         };
      };
      ["id"] = 167533;
      ["spells"] = {
         [333861] = {};
         [331275] = {};
         [333827] = {};
      };
      ["characteristics"] = {
         ["Taunt"] = true;
      };
      ["health"] = "528624";
      ["name"] = "Advent Nevermore";
      ["displayId"] = 95966;
      ["creatureType"] = "Humanoid";
      ["level"] = 60;
      ["count"] = 20;
      ["scale"] = 2;
   };
   [15] = {
      ["clones"] = {
         [1] = {
            ["y"] = -442.99206896552;
            ["x"] = 607.15292675452;
            ["g"] = 5;
            ["sublevel"] = 3;
         };
         [2] = {
            ["y"] = -447.21070094084;
            ["x"] = 592.19400492044;
            ["g"] = 5;
            ["sublevel"] = 3;
         };
         [4] = {
            ["sublevel"] = 3;
            ["inspiring"] = true;
            ["x"] = 568.77036871258;
            ["g"] = 6;
            ["y"] = -446.99419148851;
         };
         [8] = {
            ["y"] = -421.56842984826;
            ["x"] = 546.70176186807;
            ["g"] = 7;
            ["sublevel"] = 3;
         };
         [16] = {
            ["y"] = -165.8740163814;
            ["x"] = 354.23257304131;
            ["g"] = 14;
            ["sublevel"] = 3;
         };
         [17] = {
            ["y"] = -166.11423690935;
            ["x"] = 375.57534809124;
            ["g"] = 14;
            ["sublevel"] = 3;
         };
         [9] = {
            ["y"] = -421.03779212449;
            ["x"] = 535.99685365924;
            ["g"] = 7;
            ["sublevel"] = 3;
         };
         [18] = {
            ["y"] = -160.36310344828;
            ["x"] = 364.70364695066;
            ["g"] = 14;
            ["sublevel"] = 3;
         };
         [5] = {
            ["y"] = -444.17811518964;
            ["x"] = 557.01639299851;
            ["g"] = 6;
            ["sublevel"] = 3;
         };
         [10] = {
            ["y"] = -392.05458967775;
            ["x"] = 533.54837904435;
            ["g"] = 8;
            ["sublevel"] = 3;
         };
         [20] = {
            ["y"] = -88.417241379311;
            ["x"] = 345.41386380681;
            ["g"] = 16;
            ["sublevel"] = 3;
         };
         [21] = {
            ["y"] = -95.909189201993;
            ["x"] = 355.21991310002;
            ["g"] = 16;
            ["sublevel"] = 3;
         };
         [11] = {
            ["sublevel"] = 3;
            ["inspiring"] = true;
            ["x"] = 539.45647000001;
            ["g"] = 8;
            ["y"] = -380.64675527127;
         };
         [22] = {
            ["y"] = -312.48757116958;
            ["x"] = 359.7953037422;
            ["g"] = 10;
            ["sublevel"] = 3;
         };
         [3] = {
            ["y"] = -436.53318698247;
            ["x"] = 597.21077116794;
            ["g"] = 5;
            ["sublevel"] = 3;
         };
         [6] = {
            ["y"] = -429.63703232507;
            ["x"] = 540.72369922713;
            ["g"] = 7;
            ["sublevel"] = 3;
         };
         [12] = {
            ["y"] = -392.57546897264;
            ["x"] = 547.30003064664;
            ["g"] = 8;
            ["sublevel"] = 3;
         };
         [24] = {
            ["y"] = -298.69206896552;
            ["x"] = 357.65001532332;
            ["g"] = 10;
            ["sublevel"] = 3;
         };
         [13] = {
            ["y"] = -276.58177719069;
            ["x"] = 227.83736523639;
            ["g"] = 12;
            ["sublevel"] = 3;
         };
         [7] = {
            ["y"] = -435.86740602643;
            ["x"] = 558.08954594697;
            ["g"] = 6;
            ["sublevel"] = 3;
         };
         [14] = {
            ["y"] = -282.76665742285;
            ["x"] = 215.62964707017;
            ["g"] = 12;
            ["sublevel"] = 3;
         };
         [15] = {
            ["y"] = -284.21632488259;
            ["x"] = 235.97010775668;
            ["g"] = 12;
            ["sublevel"] = 3;
         };
         [19] = {
            ["y"] = -89.489776722053;
            ["x"] = 366.9363463343;
            ["g"] = 16;
            ["sublevel"] = 3;
         };
         [23] = {
            ["y"] = -315.44838237439;
            ["x"] = 348.26114460169;
            ["g"] = 10;
            ["sublevel"] = 3;
         };
      };
      ["id"] = 169875;
      ["spells"] = {
         [330810] = {
            ["interruptible"] = true;
         };
         [332550] = {};
      };
      ["characteristics"] = {
         ["Taunt"] = true;
         ["Incapacitate"] = true;
         ["Shackle Undead"] = true;
         ["Root"] = true;
         ["Control Undead"] = true;
         ["Polymorph"] = true;
         ["Disorient"] = true;
         ["Silence"] = true;
         ["Slow"] = true;
         ["Stun"] = true;
         ["Repentance"] = true;
      };
      ["health"] = "99117";
      ["name"] = "Shackled Soul";
      ["displayId"] = 90428;
      ["creatureType"] = "Undead";
      ["level"] = 60;
      ["count"] = 2;
      ["scale"] = 1;
   };
   [18] = {
      ["clones"] = {
         [6] = {
            ["y"] = -302.58528999302;
            ["x"] = 349.11175182402;
            ["g"] = 10;
            ["sublevel"] = 3;
         };
         [2] = {
            ["y"] = -287.15159567984;
            ["x"] = 226.21764753987;
            ["g"] = 12;
            ["sublevel"] = 3;
         };
         [3] = {
            ["y"] = -197.00155699217;
            ["x"] = 680.95857564404;
            ["g"] = 20;
            ["sublevel"] = 3;
         };
         [1] = {
            ["y"] = -247.61141335538;
            ["x"] = 221.87992152087;
            ["g"] = 11;
            ["sublevel"] = 3;
         };
         [4] = {
            ["y"] = -171.11943189447;
            ["x"] = 365.17989580141;
            ["g"] = 14;
            ["sublevel"] = 3;
         };
         [5] = {
            ["sublevel"] = 3;
            ["inspiring"] = true;
            ["x"] = 356.15579768471;
            ["g"] = 16;
            ["y"] = -82.062208302467;
         };
      };
      ["id"] = 160495;
      ["spells"] = {
         [333708] = {};
         [330784] = {
            ["interruptible"] = true;
         };
         [330868] = {
            ["interruptible"] = true;
         };
      };
      ["characteristics"] = {
         ["Taunt"] = true;
         ["Incapacitate"] = true;
         ["Root"] = true;
         ["Fear"] = true;
         ["Disorient"] = true;
         ["Polymorph"] = true;
         ["Mind Control"] = true;
         ["Sap"] = true;
         ["Silence"] = true;
         ["Stun"] = true;
         ["Slow"] = true;
         ["Imprison"] = true;
         ["Repentance"] = true;
      };
      ["health"] = "148676";
      ["name"] = "Maniacal Soulbinder";
      ["displayId"] = 95233;
      ["creatureType"] = "Humanoid";
      ["level"] = 60;
      ["count"] = 4;
      ["scale"] = 1.3;
   };
   [22] = {
      ["clones"] = {
         [6] = {
            ["y"] = -294.45917066727;
            ["x"] = 377.2823203889;
            ["g"] = 25;
            ["sublevel"] = 5;
         };
         [2] = {
            ["y"] = -344.24741760944;
            ["x"] = 527.85049180328;
            ["g"] = 22;
            ["sublevel"] = 4;
         };
         [3] = {
            ["sublevel"] = 4;
            ["inspiring"] = true;
            ["x"] = 387.1448303954;
            ["g"] = 23;
            ["y"] = -302.72470508315;
         };
         [1] = {
            ["y"] = -334.71987211018;
            ["x"] = 592.24131147541;
            ["g"] = 21;
            ["sublevel"] = 4;
         };
         [4] = {
            ["y"] = -280.10958070002;
            ["x"] = 395.58594646984;
            ["g"] = 23;
            ["sublevel"] = 4;
         };
         [5] = {
            ["y"] = -264.57436553433;
            ["x"] = 247.84417032655;
            ["g"] = 24;
            ["sublevel"] = 5;
         };
      };
      ["id"] = 174210;
      ["spells"] = {
         [330700] = {};
         [341969] = {
            ["interruptible"] = true;
         };
         [330693] = {};
         [321041] = {};
         [330703] = {
            ["interruptible"] = true;
         };
      };
      ["characteristics"] = {
         ["Taunt"] = true;
         ["Incapacitate"] = true;
         ["Shackle Undead"] = true;
         ["Root"] = true;
         ["Control Undead"] = true;
         ["Polymorph"] = true;
         ["Disorient"] = true;
         ["Stun"] = true;
         ["Slow"] = true;
         ["Silence"] = true;
         ["Repentance"] = true;
      };
      ["health"] = "132156";
      ["name"] = "Blighted Sludge-Spewer";
      ["displayId"] = 95559;
      ["creatureType"] = "Undead";
      ["level"] = 60;
      ["count"] = 4;
      ["scale"] = 1.3;
   };
   [26] = {
      ["clones"] = {
         [1] = {
            ["sublevel"] = 4;
            ["x"] = 273.84279248479;
            ["patrol"] = {
               [7] = {
                  ["y"] = -407.69512655511;
                  ["x"] = 254.18318623485;
               };
               [1] = {
                  ["y"] = -363.58427181046;
                  ["x"] = 273.84279248479;
               };
               [2] = {
                  ["y"] = -355.24189473148;
                  ["x"] = 295.13065259122;
               };
               [4] = {
                  ["y"] = -355.24189473148;
                  ["x"] = 295.13065259122;
               };
               [8] = {
                  ["y"] = -426.26081255918;
                  ["x"] = 256.61584531105;
               };
               [9] = {
                  ["y"] = -407.69512655511;
                  ["x"] = 254.18318623485;
               };
               [5] = {
                  ["y"] = -363.58427181046;
                  ["x"] = 273.84279248479;
               };
               [10] = {
                  ["y"] = -381.1896189781;
                  ["x"] = 255.90433848666;
               };
               [3] = {
                  ["y"] = -349.15171586191;
                  ["x"] = 309.13808751382;
               };
               [6] = {
                  ["y"] = -381.1896189781;
                  ["x"] = 255.90433848666;
               };
            };
            ["y"] = -363.58427181046;
         };
         [2] = {
            ["y"] = -161.52078803511;
            ["x"] = 337.24513439812;
            ["patrol"] = {
               [7] = {
                  ["y"] = -118.51291531774;
                  ["x"] = 346.17400917588;
               };
               [1] = {
                  ["y"] = -161.52078803511;
                  ["x"] = 337.24513439812;
               };
               [2] = {
                  ["y"] = -181.13099569599;
                  ["x"] = 349.41288765113;
               };
               [4] = {
                  ["y"] = -181.13099569599;
                  ["x"] = 349.41288765113;
               };
               [8] = {
                  ["y"] = -106.99694757765;
                  ["x"] = 353.0116140563;
               };
               [9] = {
                  ["y"] = -118.51291531774;
                  ["x"] = 346.17400917588;
               };
               [5] = {
                  ["y"] = -161.52078803511;
                  ["x"] = 337.24513439812;
               };
               [10] = {
                  ["y"] = -136.14674574603;
                  ["x"] = 334.29819350587;
               };
               [3] = {
                  ["y"] = -196.96545519964;
                  ["x"] = 358.76961337046;
               };
               [6] = {
                  ["y"] = -136.14674574603;
                  ["x"] = 334.29819350587;
               };
            };
            ["sublevel"] = 4;
         };
         [3] = {
            ["y"] = -272.7934040428;
            ["x"] = 325.36043071135;
            ["sublevel"] = 5;
         };
      };
      ["id"] = 163086;
      ["spells"] = {
         [330614] = {};
         [330973] = {};
      };
      ["characteristics"] = {
         ["Taunt"] = true;
      };
      ["health"] = "313871";
      ["name"] = "Rancid Gasbag";
      ["displayId"] = 97161;
      ["creatureType"] = "Undead";
      ["level"] = 60;
      ["count"] = 8;
      ["scale"] = 2;
   };
   [30] = {
      ["clones"] = {
         [1] = {
            ["y"] = -284.32867018819;
            ["x"] = 502.13196302438;
            ["sublevel"] = 2;
         };
      };
      ["scale"] = 2;
      ["spells"] = {
         [342135] = {};
         [332708] = {};
         [331288] = {};
      };
      ["characteristics"] = {
         ["Taunt"] = true;
      };
      ["health"] = "528624";
      ["count"] = 20;
      ["displayId"] = 97490;
      ["creatureType"] = "Humanoid";
      ["level"] = 61;
      ["name"] = "Heavin the Breaker";
      ["id"] = 167532;
   };
   [36] = {
      ["clones"] = {
         [13] = {
            ["y"] = -364.32447724135;
            ["x"] = 622.04107921204;
            ["sublevel"] = 3;
         };
         [7] = {
            ["y"] = -186.94868709071;
            ["x"] = 341.78385926144;
            ["sublevel"] = 4;
         };
         [1] = {
            ["y"] = -335.71604528471;
            ["x"] = 425.01640830966;
            ["sublevel"] = 1;
         };
         [2] = {
            ["y"] = -238.03422029031;
            ["x"] = 423.59218273415;
            ["sublevel"] = 1;
         };
         [4] = {
            ["y"] = -410.04288764377;
            ["x"] = 563.18803516631;
            ["sublevel"] = 2;
         };
         [8] = {
            ["y"] = -354.25640349183;
            ["x"] = 292.16843881499;
            ["sublevel"] = 4;
         };
         [9] = {
            ["y"] = -343.89768181106;
            ["x"] = 552.33341426349;
            ["sublevel"] = 5;
         };
         [5] = {
            ["y"] = -454.6410281581;
            ["x"] = 458.92319559854;
            ["sublevel"] = 2;
         };
         [10] = {
            ["y"] = -442.73081215986;
            ["x"] = 542.69361707296;
            ["sublevel"] = 3;
         };
         [3] = {
            ["y"] = -322.28839493217;
            ["x"] = 389.73544572091;
            ["sublevel"] = 2;
         };
         [6] = {
            ["y"] = -357.23869147944;
            ["x"] = 562.06573056882;
            ["sublevel"] = 4;
         };
         [12] = {
            ["y"] = -113.63486013351;
            ["x"] = 341.07242859912;
            ["sublevel"] = 3;
         };
         [11] = {
            ["y"] = -202.67730283952;
            ["x"] = 532.16486790666;
            ["sublevel"] = 3;
         };
      };
      ["include"] = {
         ["level"] = 10;
         ["affix"] = 130;
      };
      ["scale"] = 1;
      ["level"] = 62;
      ["id"] = 185683;
      ["spells"] = {
         [368078] = {};
         [366566] = {};
      };
      ["badCreatureModel"] = true;
      ["displayId"] = 101046;
      ["count"] = 0;
      ["ignoreFortified"] = true;
      ["name"] = "Wo Relic";
      ["bonusSpell"] = 368241;
      ["creatureType"] = "Mechanical";
      ["modelPosition"] = {
         [1] = 0;
         [2] = 0;
         [3] = 0.6;
      };
      ["health"] = "33039";
      ["iconTexture"] = 4335644;
   };
   [37] = {
      ["clones"] = {
         [13] = {
            ["y"] = -359.80831522268;
            ["x"] = 601.87975336677;
            ["sublevel"] = 3;
         };
         [7] = {
            ["y"] = -176.94868549886;
            ["x"] = 354.86075902631;
            ["sublevel"] = 4;
         };
         [1] = {
            ["y"] = -333.67060231564;
            ["x"] = 407.28905384589;
            ["sublevel"] = 1;
         };
         [2] = {
            ["y"] = -260.07967794719;
            ["x"] = 401.09221253944;
            ["sublevel"] = 1;
         };
         [4] = {
            ["y"] = -399.25345004966;
            ["x"] = 578.71431059023;
            ["sublevel"] = 2;
         };
         [8] = {
            ["y"] = -371.08479928167;
            ["x"] = 295.52723929841;
            ["sublevel"] = 4;
         };
         [9] = {
            ["y"] = -321.20533495532;
            ["x"] = 563.1026569045;
            ["sublevel"] = 5;
         };
         [5] = {
            ["y"] = -432.33333483874;
            ["x"] = 471.61550785063;
            ["sublevel"] = 2;
         };
         [10] = {
            ["y"] = -456.65937139105;
            ["x"] = 544.12226899404;
            ["sublevel"] = 3;
         };
         [3] = {
            ["y"] = -333.60411019567;
            ["x"] = 373.15643426204;
            ["sublevel"] = 2;
         };
         [6] = {
            ["y"] = -361.85413777439;
            ["x"] = 595.14263351739;
            ["sublevel"] = 4;
         };
         [12] = {
            ["y"] = -131.26644217122;
            ["x"] = 340.79040149609;
            ["sublevel"] = 3;
         };
         [11] = {
            ["y"] = -189.03747181831;
            ["x"] = 543.75696198338;
            ["sublevel"] = 3;
         };
      };
      ["include"] = {
         ["level"] = 10;
         ["affix"] = 130;
      };
      ["scale"] = 1;
      ["level"] = 62;
      ["id"] = 185685;
      ["spells"] = {
         [368243] = {};
         [366297] = {};
         [366288] = {};
      };
      ["badCreatureModel"] = true;
      ["displayId"] = 105134;
      ["count"] = 0;
      ["ignoreFortified"] = true;
      ["health"] = "33039";
      ["bonusSpell"] = 368239;
      ["creatureType"] = "Mechanical";
      ["modelPosition"] = {
         [1] = 0;
         [2] = 0;
         [3] = 0.75;
      };
      ["name"] = "Urh Relic";
      ["iconTexture"] = 4335642;
   };
   [31] = {
      ["clones"] = {
         [1] = {
            ["y"] = -408.47326368702;
            ["x"] = 601.68461487772;
            ["sublevel"] = 2;
         };
      };
      ["scale"] = 2;
      ["spells"] = {
         [333845] = {};
         [333839] = {};
         [317605] = {};
      };
      ["characteristics"] = {
         ["Taunt"] = true;
      };
      ["health"] = 256320;
      ["count"] = 20;
      ["displayId"] = 96829;
      ["creatureType"] = "Humanoid";
      ["level"] = 61;
      ["name"] = "Rek the Hardened";
      ["id"] = 167534;
   };
   [1] = {
      ["clones"] = {
         [1] = {
            ["y"] = -374.42489015613;
            ["x"] = 425.58391854356;
            ["g"] = 1;
            ["sublevel"] = 1;
         };
      };
      ["id"] = 174197;
      ["spells"] = {
         [341902] = {};
         [330784] = {
            ["interruptible"] = true;
         };
      };
      ["characteristics"] = {
         ["Taunt"] = true;
         ["Incapacitate"] = true;
         ["Root"] = true;
         ["Fear"] = true;
         ["Disorient"] = true;
         ["Polymorph"] = true;
         ["Mind Control"] = true;
         ["Sap"] = true;
         ["Stun"] = true;
         ["Silence"] = true;
         ["Slow"] = true;
         ["Imprison"] = true;
         ["Repentance"] = true;
      };
      ["health"] = "148676";
      ["name"] = "Battlefield Ritualist";
      ["displayId"] = 98696;
      ["creatureType"] = "Humanoid";
      ["level"] = 60;
      ["count"] = 4;
      ["scale"] = 1;
   };
   [19] = {
      ["clones"] = {
         [1] = {
            ["y"] = -184.88861756349;
            ["x"] = 526.73244012243;
            ["g"] = 17;
            ["sublevel"] = 3;
         };
      };
      ["id"] = 162763;
      ["spells"] = {
         [331237] = {};
         [331223] = {};
      };
      ["characteristics"] = {
         ["Taunt"] = true;
      };
      ["health"] = "330390";
      ["name"] = "Soulforged Bonereaver";
      ["displayId"] = 94812;
      ["creatureType"] = "Undead";
      ["level"] = 60;
      ["count"] = 8;
      ["scale"] = 1.6;
   };
   [23] = {
      ["clones"] = {
         [13] = {
            ["y"] = -289.7343476393;
            ["x"] = 364.23153550334;
            ["g"] = 25;
            ["sublevel"] = 5;
         };
         [7] = {
            ["y"] = -357.35136325713;
            ["x"] = 525.48207740526;
            ["g"] = 22;
            ["sublevel"] = 4;
         };
         [1] = {
            ["sublevel"] = 4;
            ["inspiring"] = true;
            ["x"] = 599.27764418327;
            ["g"] = 21;
            ["y"] = -343.81046655103;
         };
         [2] = {
            ["y"] = -347.1248582832;
            ["x"] = 610.01857196098;
            ["g"] = 21;
            ["sublevel"] = 4;
         };
         [4] = {
            ["y"] = -333.53516892626;
            ["x"] = 602.92679659671;
            ["g"] = 21;
            ["sublevel"] = 4;
         };
         [8] = {
            ["y"] = -357.43310378751;
            ["x"] = 514.74098360656;
            ["g"] = 22;
            ["sublevel"] = 4;
         };
         [11] = {
            ["y"] = -282.35606667544;
            ["x"] = 382.98365119352;
            ["g"] = 25;
            ["sublevel"] = 5;
         };
         [9] = {
            ["y"] = -217.90039615541;
            ["x"] = 254.53394518714;
            ["g"] = 24;
            ["sublevel"] = 5;
         };
         [5] = {
            ["y"] = -336.95843580915;
            ["x"] = 515.78754098361;
            ["g"] = 22;
            ["sublevel"] = 4;
         };
         [10] = {
            ["y"] = -243.73044761436;
            ["x"] = 242.99409836066;
            ["g"] = 24;
            ["sublevel"] = 5;
         };
         [14] = {
            ["y"] = -300.05955487395;
            ["x"] = 391.53172462651;
            ["g"] = 25;
            ["sublevel"] = 5;
         };
         [3] = {
            ["y"] = -335.98126609135;
            ["x"] = 612.40081048132;
            ["g"] = 21;
            ["sublevel"] = 4;
         };
         [6] = {
            ["y"] = -347.55066404329;
            ["x"] = 513.00590163934;
            ["g"] = 22;
            ["sublevel"] = 4;
         };
         [12] = {
            ["y"] = -277.96226386751;
            ["x"] = 368.85473423501;
            ["g"] = 25;
            ["sublevel"] = 5;
         };
         [15] = {
            ["y"] = -289.73797451597;
            ["x"] = 394.15397413759;
            ["g"] = 25;
            ["sublevel"] = 5;
         };
      };
      ["id"] = 163089;
      ["spells"] = {
         [321041] = {};
         [330694] = {};
      };
      ["characteristics"] = {
         ["Taunt"] = true;
         ["Incapacitate"] = true;
         ["Shackle Undead"] = true;
         ["Root"] = true;
         ["Control Undead"] = true;
         ["Polymorph"] = true;
         ["Disorient"] = true;
         ["Silence"] = true;
         ["Slow"] = true;
         ["Stun"] = true;
         ["Repentance"] = true;
      };
      ["health"] = "41299";
      ["name"] = "Disgusting Refuse";
      ["displayId"] = 94761;
      ["creatureType"] = "Undead";
      ["level"] = 60;
      ["count"] = 1;
      ["scale"] = 1;
   };
   [35] = {
      ["clones"] = {
         [1] = {
            ["y"] = -157.88409820652;
            ["x"] = 295.01191596194;
            ["week"] = {
               [6] = true;
               [2] = true;
               [10] = true;
               [1] = true;
               [5] = true;
               [9] = true;
            };
            ["sublevel"] = 2;
         };
         [2] = {
            ["y"] = -381.60862941344;
            ["x"] = 362.21784027017;
            ["week"] = {
               [11] = true;
               [7] = true;
               [8] = true;
               [3] = true;
               [12] = true;
               [4] = true;
            };
            ["sublevel"] = 2;
         };
      };
      ["powers"] = {
         [357747] = {
            ["healer"] = true;
         };
         [357609] = {
            ["dps"] = true;
         };
         [357863] = {
            ["tank"] = true;
         };
         [357847] = {
            ["healer"] = true;
         };
         [357706] = {
            ["dps"] = true;
         };
         [357575] = {
            ["tank"] = true;
            ["dps"] = true;
            ["healer"] = true;
         };
         [357604] = {
            ["tank"] = true;
         };
      };
      ["id"] = 179890;
      ["spells"] = {
         [355714] = {};
         [356925] = {};
         [358971] = {};
         [356923] = {};
      };
      ["include"] = {
         ["level"] = 10;
         ["affix"] = 128;
      };
      ["scale"] = 1.5;
      ["count"] = 0;
      ["ignoreFortified"] = true;
      ["name"] = "Executioner Varruth";
      ["displayId"] = 92418;
      ["creatureType"] = "Humanoid";
      ["level"] = 61;
      ["health"] = 336131;
      ["iconTexture"] = 237552;
   };
};
