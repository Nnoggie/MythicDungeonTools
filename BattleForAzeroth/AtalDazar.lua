local MDT = MDT
local L = MDT.L
local dungeonIndex = 15
MDT.dungeonList[dungeonIndex] = L["Atal'Dazar"]

MDT.dungeonMaps[dungeonIndex] = {
  [0] = "CityOfGold",
  [1] = "CityOfGold1_",
  [2] = "CityOfGold2_",
}
MDT.dungeonSubLevels[dungeonIndex] = {
  [1] = L["Atal'Dazar Sublevel"],
  [2] = L["Sacrificial Pits"],
}

MDT.dungeonTotalCount[dungeonIndex] = { normal = 198, teeming = 237, teemingEnabled = true }
MDT.mapPOIs[dungeonIndex] = {
  [1] = {
    [1] = {
      ["template"] = "MapLinkPinTemplate";
      ["type"] = "mapLink";
      ["x"] = 517.98001617239;
      ["y"] = -210.32103688142;
      ["target"] = 2;
      ["direction"] = -1;
      ["connectionIndex"] = 1;
    };
    [2] = {
      ["template"] = "MapLinkPinTemplate";
      ["type"] = "mapLink";
      ["x"] = 517.42667589569;
      ["y"] = -329.12649940624;
      ["target"] = 2;
      ["direction"] = -1;
      ["connectionIndex"] = 2;
    };
    [3] = {
      ["template"] = "MapLinkPinTemplate";
      ["type"] = "generalNote";
      ["x"] = 600.63207260699;
      ["y"] = -365.02988947658;
      ["scale"] = 2;
      ["formattedText"] = {
        [1] = "atalTeemingNote";
        [2] = "\n";
        [3] = "\n";
        [4] = "\n";
        [5] = "\n";
      };
      ["weeks"] = {
        [1] = true;
        [8] = true;
      };
    };
    [4] = {
      ["template"] = "MapLinkPinTemplate";
      ["type"] = "generalNote";
      ["x"] = 600.63207260699;
      ["y"] = -150.19501620336;
      ["scale"] = 2;
      ["formattedText"] = {
        [1] = "atalTeemingNote";
        [2] = "\n";
        [3] = "\n";
        [4] = "\n";
        [5] = "\n";
      };
      ["weeks"] = {
        [1] = true;
        [8] = true;
      };
    };
    [5] = {
      ["template"] = "VignettePinTemplate";
      ["type"] = "nyalothaSpire";
      ["x"] = 587.56733659681;
      ["y"] = -207.84478938144;
      ["index"] = 1;
      ["npcId"] = 161243;
      ["tooltipText"] = "Entropic Spire of Ny'alotha";
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
    };
    [6] = {
      ["template"] = "VignettePinTemplate";
      ["type"] = "nyalothaSpire";
      ["x"] = 462.89828402862;
      ["y"] = -257.18926210658;
      ["index"] = 3;
      ["npcId"] = 161124;
      ["tooltipText"] = "Brutal Spire of Ny'alotha";
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
    };
    [7] = {
      ["template"] = "VignettePinTemplate";
      ["type"] = "nyalothaSpire";
      ["x"] = 581.14504888138;
      ["y"] = -349.89286786923;
      ["index"] = 2;
      ["npcId"] = 161241;
      ["tooltipText"] = "Cursed Spire of Ny'alotha";
      ["weeks"] = {
        [1] = true;
        [2] = true;
        [5] = true;
        [6] = true;
        [9] = true;
        [10] = true;
      };
    };
    [8] = {
      ["template"] = "VignettePinTemplate";
      ["type"] = "nyalothaSpire";
      ["x"] = 417.6415060524;
      ["y"] = -139.59233583327;
      ["index"] = 4;
      ["npcId"] = 161244;
      ["tooltipText"] = "Defiled Spire of Ny'alotha";
      ["weeks"] = {
        [1] = true;
        [2] = true;
        [5] = true;
        [6] = true;
        [9] = true;
        [10] = true;
      };
    };
    [9] = {
      ["template"] = "VignettePinTemplate";
      ["type"] = "nyalothaSpire";
      ["x"] = 418.19472278238;
      ["y"] = -137.50463674291;
      ["index"] = 5;
      ["npcId"] = 161241;
      ["tooltipText"] = "Cursed Spire of Ny'alotha";
      ["weeks"] = {
        [3] = true;
        [4] = true;
        [7] = true;
        [8] = true;
        [11] = true;
        [12] = true;
      };
    };
    [10] = {
      ["template"] = "VignettePinTemplate";
      ["type"] = "nyalothaSpire";
      ["x"] = 580.99671668925;
      ["y"] = -349.61787819522;
      ["index"] = 6;
      ["npcId"] = 161244;
      ["tooltipText"] = "Defiled Spire of Ny'alotha";
      ["weeks"] = {
        [3] = true;
        [4] = true;
        [7] = true;
        [8] = true;
        [11] = true;
        [12] = true;
      };
    };
  };
  [2] = {
    [1] = {
      ["template"] = "MapLinkPinTemplate";
      ["type"] = "mapLink";
      ["x"] = 587.10715642853;
      ["y"] = -154.91903909324;
      ["target"] = 1;
      ["direction"] = 1;
      ["connectionIndex"] = 1;
    };
    [2] = {
      ["template"] = "MapLinkPinTemplate";
      ["type"] = "mapLink";
      ["x"] = 587.10715642853;
      ["y"] = -508.99905320816;
      ["target"] = 1;
      ["direction"] = 1;
      ["connectionIndex"] = 2;
    };
  };
};

MDT.dungeonEnemies[dungeonIndex] = {
  [1] = {
    ["name"] = "Dazar'ai Honor Guard";
    ["id"] = 127799;
    ["count"] = 4;
    ["health"] = 768495;
    ["scale"] = 1;
    ["displayId"] = 81326;
    ["creatureType"] = "Humanoid";
    ["level"] = 120;
    ["reaping"] = 148716;
    ["characteristics"] = {
      ["Taunt"] = true;
      ["Incapacitate"] = true;
      ["Silence"] = true;
      ["Mind Control"] = true;
      ["Polymorph"] = true;
      ["Root"] = true;
      ["Fear"] = true;
      ["Imprison"] = true;
      ["Sap"] = true;
      ["Stun"] = true;
      ["Slow"] = true;
    };
    ["spells"] = {
      [209859] = {
      };
      [256138] = {
      };
      [277242] = {
      };
      [277564] = {
      };
    };
    ["clones"] = {
      [1] = {
        ["x"] = 578.61472163258;
        ["y"] = -340.4715395664;
        ["g"] = 1;
        ["sublevel"] = 1;
      };
      [2] = {
        ["x"] = 586.43339847879;
        ["y"] = -340.83590023072;
        ["g"] = 1;
        ["sublevel"] = 1;
        ["infested"] = {
          [2] = true;
        };
      };
      [3] = {
        ["x"] = 449.43285967335;
        ["y"] = -475.53583066501;
        ["g"] = 7;
        ["sublevel"] = 1;
      };
      [4] = {
        ["x"] = 471.16892743739;
        ["y"] = -477.6043721857;
        ["g"] = 7;
        ["sublevel"] = 1;
      };
      [5] = {
        ["x"] = 451.81090399163;
        ["y"] = -466.01230157081;
        ["g"] = 7;
        ["sublevel"] = 1;
      };
      [6] = {
        ["x"] = 467.22361490784;
        ["y"] = -361.32331300461;
        ["g"] = 8;
        ["sublevel"] = 1;
        ["infested"] = {
          [3] = true;
        };
      };
      [7] = {
        ["x"] = 453.27009933105;
        ["y"] = -361.09075175024;
        ["g"] = 8;
        ["sublevel"] = 1;
      };
    };
  };
  [2] = {
    ["name"] = "Dazar'ai Juggernaut";
    ["id"] = 122971;
    ["count"] = 4;
    ["health"] = 883769;
    ["scale"] = 1;
    ["displayId"] = 81325;
    ["creatureType"] = "Humanoid";
    ["level"] = 120;
    ["reaping"] = 148716;
    ["characteristics"] = {
      ["Taunt"] = true;
      ["Incapacitate"] = true;
      ["Silence"] = true;
      ["Mind Control"] = true;
      ["Polymorph"] = true;
      ["Root"] = true;
      ["Fear"] = true;
      ["Disorient"] = true;
      ["Imprison"] = true;
      ["Sap"] = true;
      ["Stun"] = true;
      ["Slow"] = true;
    };
    ["spells"] = {
      [209859] = {
      };
      [253239] = {
      };
      [253279] = {
      };
      [253654] = {
      };
      [253666] = {
      };
      [255824] = {
      };
      [277242] = {
      };
      [277564] = {
      };
    };
    ["clones"] = {
      [1] = {
        ["x"] = 571.37693269554;
        ["y"] = -334.55451402168;
        ["g"] = 1;
        ["sublevel"] = 1;
      };
      [2] = {
        ["x"] = 569.1457495061;
        ["y"] = -360.35580706243;
        ["g"] = 2;
        ["sublevel"] = 1;
      };
      [3] = {
        ["x"] = 580.757036442;
        ["y"] = -389.01293552463;
        ["g"] = 3;
        ["sublevel"] = 1;
        ["infested"] = {
          [3] = true;
        };
      };
      [4] = {
        ["x"] = 521.41919375683;
        ["y"] = -387.41420880268;
        ["sublevel"] = 1;
        ["patrol"] = {
          [1] = {
            ["x"] = 521.41919375683;
            ["y"] = -387.41420880268;
          };
          [2] = {
            ["x"] = 510.41917459207;
            ["y"] = -387.41420880268;
          };
          [3] = {
            ["x"] = 521.41919375683;
            ["y"] = -387.41420880268;
          };
          [4] = {
            ["x"] = 531.41915655981;
            ["y"] = -387.41420880268;
          };
        };
        ["infested"] = {
          [2] = true;
          [3] = true;
        };
      };
      [5] = {
        ["x"] = 555.83889576925;
        ["y"] = -394.96740325824;
        ["g"] = 4;
        ["sublevel"] = 1;
      };
      [6] = {
        ["x"] = 549.58314368694;
        ["y"] = -423.52378569339;
        ["g"] = 5;
        ["sublevel"] = 1;
      };
      [7] = {
        ["x"] = 573.3331411747;
        ["y"] = -423.02378969901;
        ["g"] = 5;
        ["sublevel"] = 1;
      };
      [8] = {
        ["x"] = 511.096923774;
        ["y"] = -438.62955369067;
        ["g"] = 6;
        ["sublevel"] = 1;
      };
      [9] = {
        ["x"] = 458.09438185492;
        ["y"] = -474.82268196192;
        ["g"] = 7;
        ["sublevel"] = 1;
        ["infested"] = {
          [1] = true;
        };
      };
      [10] = {
        ["x"] = 583.10517722733;
        ["y"] = -364.09809808532;
        ["g"] = 2;
        ["sublevel"] = 1;
        ["teeming"] = true;
      };
    };
  };
  [3] = {
    ["name"] = "Dazar'ai Confessor";
    ["id"] = 122973;
    ["count"] = 4;
    ["health"] = 768495;
    ["scale"] = 1;
    ["displayId"] = 81330;
    ["creatureType"] = "Humanoid";
    ["level"] = 120;
    ["reaping"] = 148893;
    ["characteristics"] = {
      ["Taunt"] = true;
      ["Incapacitate"] = true;
      ["Silence"] = true;
      ["Mind Control"] = true;
      ["Polymorph"] = true;
      ["Root"] = true;
      ["Fear"] = true;
      ["Imprison"] = true;
      ["Sap"] = true;
      ["Stun"] = true;
      ["Slow"] = true;
    };
    ["spells"] = {
      [209859] = {
      };
      [253517] = {
      };
      [253526] = {
      };
      [253544] = {
      };
      [253548] = {
      };
      [277242] = {
      };
      [277564] = {
      };
    };
    ["clones"] = {
      [1] = {
        ["x"] = 574.5294362209;
        ["y"] = -364.68933932213;
        ["g"] = 2;
        ["sublevel"] = 1;
      };
      [2] = {
        ["x"] = 544.00217871958;
        ["y"] = -388.02864926549;
        ["g"] = 4;
        ["sublevel"] = 1;
        ["infested"] = {
          [1] = true;
        };
      };
      [3] = {
        ["x"] = 563.79809777932;
        ["y"] = -388.23273361401;
        ["sublevel"] = 1;
        ["patrol"] = {
          [1] = {
            ["x"] = 563.79809777932;
            ["y"] = -388.23273361401;
          };
          [2] = {
            ["x"] = 572.36953531849;
            ["y"] = -388.84496914311;
          };
          [3] = {
            ["x"] = 563.79809777932;
            ["y"] = -388.23273361401;
          };
          [4] = {
            ["x"] = 555.6348289372;
            ["y"] = -387.82455615873;
          };
        };
        ["infested"] = {
          [2] = true;
        };
      };
      [4] = {
        ["x"] = 555.58313853486;
        ["y"] = -428.77377045649;
        ["g"] = 5;
        ["sublevel"] = 1;
      };
      [5] = {
        ["x"] = 464.89972142104;
        ["y"] = -476.78090823003;
        ["g"] = 7;
        ["sublevel"] = 1;
        ["teeming"] = true;
      };
      [6] = {
        ["x"] = 557.18566363487;
        ["y"] = -358.12858599382;
        ["g"] = 2;
        ["sublevel"] = 1;
        ["teeming"] = true;
      };
      [7] = {
        ["x"] = 560.95466375897;
        ["y"] = -370.23021977251;
        ["g"] = 29;
        ["sublevel"] = 1;
        ["teeming"] = true;
      };
    };
  };
  [4] = {
    ["name"] = "Dazar'ai Augur";
    ["id"] = 122972;
    ["count"] = 4;
    ["health"] = 768495;
    ["scale"] = 1;
    ["displayId"] = 81336;
    ["creatureType"] = "Humanoid";
    ["level"] = 120;
    ["reaping"] = 148893;
    ["characteristics"] = {
      ["Taunt"] = true;
      ["Incapacitate"] = true;
      ["Silence"] = true;
      ["Mind Control"] = true;
      ["Polymorph"] = true;
      ["Root"] = true;
      ["Fear"] = true;
      ["Disorient"] = true;
      ["Imprison"] = true;
      ["Sap"] = true;
      ["Stun"] = true;
      ["Slow"] = true;
    };
    ["spells"] = {
      [209859] = {
      };
      [253562] = {
      };
      [253583] = {
      };
      [277242] = {
      };
      [277564] = {
      };
    };
    ["clones"] = {
      [1] = {
        ["x"] = 562.52943339035;
        ["y"] = -362.32570287386;
        ["g"] = 2;
        ["sublevel"] = 1;
        ["infested"] = {
          [3] = true;
        };
      };
      [2] = {
        ["x"] = 576.50708658301;
        ["y"] = -395.01293037255;
        ["g"] = 3;
        ["sublevel"] = 1;
      };
      [3] = {
        ["x"] = 542.36952144787;
        ["y"] = -382.72252626975;
        ["g"] = 4;
        ["sublevel"] = 1;
      };
      [4] = {
        ["x"] = 569.08312694269;
        ["y"] = -428.52378855255;
        ["g"] = 5;
        ["sublevel"] = 1;
      };
      [5] = {
        ["x"] = 466.23559419455;
        ["y"] = -460.21709589194;
        ["g"] = 7;
        ["sublevel"] = 1;
      };
      [6] = {
        ["x"] = 463.46747125231;
        ["y"] = -367.88206153212;
        ["g"] = 8;
        ["sublevel"] = 1;
      };
      [7] = {
        ["x"] = 456.57091720042;
        ["y"] = -367.88206153212;
        ["g"] = 8;
        ["sublevel"] = 1;
        ["infested"] = {
          [2] = true;
        };
      };
      [8] = {
        ["x"] = 510.78413920208;
        ["y"] = -428.97026817766;
        ["g"] = 6;
        ["sublevel"] = 1;
        ["infested"] = {
          [3] = true;
        };
      };
    };
  };
  [5] = {
    ["name"] = "Dazar'ai Colossus";
    ["id"] = 122984;
    ["count"] = 6;
    ["health"] = 1306442;
    ["scale"] = 1.2;
    ["stealthDetect"] = true;
    ["displayId"] = 80338;
    ["creatureType"] = "Mechanical";
    ["level"] = 121;
    ["reaping"] = 148894;
    ["characteristics"] = {
      ["Taunt"] = true;
    };
    ["spells"] = {
      [209859] = {
      };
      [254958] = {
      };
      [254959] = {
      };
      [254974] = {
      };
      [277564] = {
      };
    };
    ["clones"] = {
      [1] = {
        ["x"] = 548.90013301827;
        ["y"] = -393.74294095827;
        ["g"] = 4;
        ["sublevel"] = 1;
        ["infested"] = {
          [3] = true;
        };
      };
      [2] = {
        ["x"] = 561.58313338278;
        ["y"] = -429.52379127015;
        ["g"] = 5;
        ["sublevel"] = 1;
        ["infested"] = {
          [3] = true;
        };
      };
      [3] = {
        ["x"] = 555.11356787669;
        ["y"] = -373.5787829515;
        ["g"] = 29;
        ["sublevel"] = 1;
        ["teeming"] = true;
      };
      [4] = {
        ["x"] = 564.97660608983;
        ["y"] = -376.72945455301;
        ["g"] = 29;
        ["sublevel"] = 1;
        ["teeming"] = true;
      };
    };
  };
  [6] = {
    ["name"] = "Gilded Priestess";
    ["id"] = 132126;
    ["count"] = 4;
    ["health"] = 768495;
    ["scale"] = 1;
    ["displayId"] = 82238;
    ["creatureType"] = "Humanoid";
    ["level"] = 120;
    ["reaping"] = 148893;
    ["characteristics"] = {
      ["Taunt"] = true;
      ["Incapacitate"] = true;
      ["Silence"] = true;
      ["Mind Control"] = true;
      ["Polymorph"] = true;
      ["Root"] = true;
      ["Fear"] = true;
      ["Imprison"] = true;
      ["Stun"] = true;
      ["Slow"] = true;
    };
    ["spells"] = {
      [209859] = {
      };
      [260666] = {
      };
      [260667] = {
      };
      [260668] = {
      };
      [277242] = {
      };
      [277564] = {
      };
    };
    ["clones"] = {
      [1] = {
        ["x"] = 496.19525601954;
        ["y"] = -471.92897904227;
        ["sublevel"] = 1;
        ["infested"] = {
          [1] = true;
          [2] = true;
        };
      };
      [2] = {
        ["x"] = 424.18247109914;
        ["y"] = -471.42806939135;
        ["sublevel"] = 1;
        ["infested"] = {
          [1] = true;
        };
      };
      [3] = {
        ["x"] = 469.34369791727;
        ["y"] = -467.39473588482;
        ["g"] = 7;
        ["sublevel"] = 1;
        ["infested"] = {
          [2] = true;
        };
      };
      [4] = {
        ["x"] = 455.51742466636;
        ["y"] = -458.80398753301;
        ["g"] = 7;
        ["sublevel"] = 1;
        ["teeming"] = true;
      };
    };
  };
  [7] = {
    ["name"] = "Priestess Alun'za";
    ["id"] = 122967;
    ["count"] = 0;
    ["health"] = 6916455;
    ["scale"] = 1;
    ["displayId"] = 80293;
    ["creatureType"] = "Humanoid";
    ["level"] = 122;
    ["isBoss"] = true;
    ["encounterID"] = 2082;
    ["instanceID"] = 968;
    ["characteristics"] = {
      ["Taunt"] = true;
    };
    ["spells"] = {
      [205276] = {
      };
      [255575] = {
      };
      [255577] = {
      };
      [255579] = {
      };
      [255581] = {
      };
      [255591] = {
      };
      [255835] = {
      };
      [255836] = {
      };
      [277564] = {
      };
    };
    ["clones"] = {
      [1] = {
        ["x"] = 459.78564177319;
        ["y"] = -490.32190350751;
        ["sublevel"] = 1;
      };
    };
  };
  [8] = {
    ["name"] = "Shadowblade Stalker";
    ["id"] = 122970;
    ["count"] = 4;
    ["health"] = 768495;
    ["scale"] = 1;
    ["stealth"] = true;
    ["displayId"] = 84712;
    ["creatureType"] = "Humanoid";
    ["level"] = 120;
    ["reaping"] = 148716;
    ["characteristics"] = {
      ["Taunt"] = true;
      ["Incapacitate"] = true;
      ["Silence"] = true;
      ["Knock"] = true;
      ["Grip"] = true;
      ["Polymorph"] = true;
      ["Root"] = true;
      ["Fear"] = true;
      ["Disorient"] = true;
      ["Repentance"] = true;
      ["Sap"] = true;
      ["Stun"] = true;
      ["Slow"] = true;
    };
    ["spells"] = {
      [132951] = {
      };
      [209859] = {
      };
      [252661] = {
      };
      [252666] = {
      };
      [252687] = {
      };
      [252692] = {
      };
      [277242] = {
      };
      [277564] = {
      };
    };
    ["clones"] = {
      [1] = {
        ["x"] = 578.02832482897;
        ["y"] = -231.02350114891;
        ["sublevel"] = 1;
        ["patrol"] = {
          [1] = {
            ["x"] = 578.02832482897;
            ["y"] = -231.02350114891;
          };
          [2] = {
            ["x"] = 578.14683954797;
            ["y"] = -248.42728194054;
          };
          [3] = {
            ["x"] = 578.02832482897;
            ["y"] = -231.02350114891;
          };
          [4] = {
            ["x"] = 578.02832482897;
            ["y"] = -216.52349929465;
          };
        };
        ["infested"] = {
          [2] = true;
        };
      };
      [2] = {
        ["x"] = 527.50945337536;
        ["y"] = -154.04509708006;
        ["sublevel"] = 1;
        ["patrol"] = {
          [1] = {
            ["x"] = 527.50945337536;
            ["y"] = -154.04509708006;
          };
          [2] = {
            ["x"] = 528.75949156657;
            ["y"] = -136.0450921515;
          };
          [3] = {
            ["x"] = 527.50945337536;
            ["y"] = -154.04509708006;
          };
          [4] = {
            ["x"] = 509.0095061264;
            ["y"] = -156.79511243617;
          };
        };
        ["infested"] = {
          [1] = true;
        };
      };
      [3] = {
        ["x"] = 463.70050232019;
        ["y"] = -158.03327728621;
        ["g"] = 15;
        ["sublevel"] = 1;
      };
      [4] = {
        ["x"] = 454.4505066867;
        ["y"] = -157.53327056299;
        ["g"] = 15;
        ["sublevel"] = 1;
        ["patrol"] = {
          [1] = {
            ["x"] = 454.4505066867;
            ["y"] = -157.53327056299;
          };
          [2] = {
            ["x"] = 454.4505066867;
            ["y"] = -132.78329181531;
          };
          [3] = {
            ["x"] = 454.4505066867;
            ["y"] = -157.53327056299;
          };
          [4] = {
            ["x"] = 454.55408558202;
            ["y"] = -175.39756174872;
          };
        };
        ["infested"] = {
          [2] = true;
        };
      };
      [5] = {
        ["x"] = 465.01085034371;
        ["y"] = -181.07969931314;
        ["g"] = 16;
        ["sublevel"] = 1;
        ["teeming"] = true;
      };
      [6] = {
        ["x"] = 602.77173726801;
        ["y"] = -192.94624716813;
        ["g"] = 28;
        ["sublevel"] = 1;
        ["infested"] = {
          [3] = true;
        };
      };
      [7] = {
        ["x"] = 604.03172802899;
        ["y"] = -201.62274042695;
        ["g"] = 28;
        ["sublevel"] = 1;
      };
      [8] = {
        ["x"] = 456.80837603918;
        ["y"] = -181.06734860891;
        ["g"] = 16;
        ["sublevel"] = 1;
        ["teeming"] = true;
      };
    };
  };
  [9] = {
    ["name"] = "Reanimated Honor Guard";
    ["id"] = 127757;
    ["count"] = 4;
    ["health"] = 845345;
    ["scale"] = 1.2;
    ["displayId"] = 80376;
    ["creatureType"] = "Undead";
    ["level"] = 120;
    ["reaping"] = 148894;
    ["characteristics"] = {
      ["Taunt"] = true;
      ["Incapacitate"] = true;
      ["Control Undead"] = true;
      ["Silence"] = true;
      ["Shackle Undead"] = true;
      ["Root"] = true;
      ["Disorient"] = true;
      ["Stun"] = true;
      ["Slow"] = true;
    };
    ["spells"] = {
      [132951] = {
      };
      [209859] = {
      };
      [255620] = {
      };
      [255814] = {
      };
      [256959] = {
      };
      [256960] = {
      };
      [277564] = {
      };
    };
    ["clones"] = {
      [1] = {
        ["x"] = 578.56400086726;
        ["y"] = -215.73948344478;
        ["g"] = 9;
        ["sublevel"] = 1;
      };
      [2] = {
        ["x"] = 574.23850127346;
        ["y"] = -184.24948923845;
        ["g"] = 10;
        ["sublevel"] = 1;
      };
      [3] = {
        ["x"] = 545.2773143908;
        ["y"] = -140.01385757439;
        ["g"] = 12;
        ["sublevel"] = 1;
        ["infested"] = {
          [3] = true;
        };
      };
      [4] = {
        ["x"] = 501.09882974782;
        ["y"] = -140.76844685786;
        ["g"] = 13;
        ["sublevel"] = 1;
      };
      [5] = {
        ["x"] = 455.19844206237;
        ["y"] = -113.87125810772;
        ["g"] = 14;
        ["sublevel"] = 1;
        ["infested"] = {
          [3] = true;
        };
      };
      [6] = {
        ["x"] = 467.51403219866;
        ["y"] = -122.65144800835;
        ["g"] = 14;
        ["sublevel"] = 1;
      };
      [7] = {
        ["x"] = 400.64217991315;
        ["y"] = -156.41043473743;
        ["g"] = 17;
        ["sublevel"] = 1;
      };
      [8] = {
        ["x"] = 407.37687583208;
        ["y"] = -150.08390751555;
        ["g"] = 17;
        ["sublevel"] = 1;
        ["infested"] = {
          [3] = true;
        };
      };
      [9] = {
        ["x"] = 561.68356577468;
        ["y"] = -171.88884800156;
        ["g"] = 27;
        ["sublevel"] = 1;
        ["teeming"] = true;
      };
      [10] = {
        ["x"] = 566.83980318175;
        ["y"] = -159.70134850622;
        ["g"] = 27;
        ["sublevel"] = 1;
        ["teeming"] = true;
      };
    };
  };
  [10] = {
    ["name"] = "Reanimation Totem";
    ["id"] = 127315;
    ["count"] = 0;
    ["health"] = 153699;
    ["scale"] = 0.6;
    ["displayId"] = 82388;
    ["creatureType"] = "Not specified";
    ["level"] = 120;
    ["characteristics"] = {
      ["Taunt"] = true;
      ["Slow"] = true;
    };
    ["spells"] = {
      [277242] = {
      };
      [277564] = {
      };
    };
    ["clones"] = {
      [1] = {
        ["x"] = 576.88320070773;
        ["y"] = -208.29627174188;
        ["g"] = 9;
        ["sublevel"] = 1;
        ["infested"] = {
          [1] = true;
        };
      };
      [2] = {
        ["x"] = 579.96481501769;
        ["y"] = -179.23259408681;
        ["g"] = 10;
        ["sublevel"] = 1;
      };
      [3] = {
        ["x"] = 546.99606019315;
        ["y"] = -146.57636349237;
        ["g"] = 12;
        ["sublevel"] = 1;
        ["infested"] = {
          [1] = true;
        };
      };
      [4] = {
        ["x"] = 497.18579001496;
        ["y"] = -144.6814772613;
        ["g"] = 13;
        ["sublevel"] = 1;
      };
      [5] = {
        ["x"] = 463.11079099857;
        ["y"] = -116.53577227204;
        ["g"] = 14;
        ["sublevel"] = 1;
        ["infested"] = {
          [1] = true;
        };
      };
      [6] = {
        ["x"] = 400.17098249987;
        ["y"] = -148.9670464846;
        ["g"] = 17;
        ["sublevel"] = 1;
        ["infested"] = {
          [1] = true;
        };
      };
      [7] = {
        ["x"] = 562.30854717967;
        ["y"] = -165.01383797006;
        ["g"] = 27;
        ["sublevel"] = 1;
        ["teeming"] = true;
      };
    };
  };
  [11] = {
    ["name"] = "Zanchuli Witch-Doctor";
    ["id"] = 122969;
    ["count"] = 4;
    ["health"] = 768495;
    ["scale"] = 1;
    ["displayId"] = 80622;
    ["creatureType"] = "Humanoid";
    ["level"] = 120;
    ["reaping"] = 148893;
    ["characteristics"] = {
      ["Taunt"] = true;
      ["Incapacitate"] = true;
      ["Silence"] = true;
      ["Mind Control"] = true;
      ["Polymorph"] = true;
      ["Root"] = true;
      ["Fear"] = true;
      ["Disorient"] = true;
      ["Imprison"] = true;
      ["Sap"] = true;
      ["Stun"] = true;
      ["Slow"] = true;
    };
    ["spells"] = {
      [209859] = {
      };
      [252781] = {
      };
      [252923] = {
        ["interruptible"] = true;
      };
      [277242] = {
      };
      [277564] = {
      };
    };
    ["clones"] = {
      [1] = {
        ["x"] = 580.84316416692;
        ["y"] = -171.21740510255;
        ["g"] = 10;
        ["sublevel"] = 1;
      };
      [2] = {
        ["x"] = 544.18354999343;
        ["y"] = -152.51384777223;
        ["g"] = 12;
        ["sublevel"] = 1;
        ["infested"] = {
          [2] = true;
        };
      };
      [3] = {
        ["x"] = 496.53360739672;
        ["y"] = -151.63799856157;
        ["g"] = 13;
        ["sublevel"] = 1;
        ["infested"] = {
          [3] = true;
        };
      };
      [4] = {
        ["x"] = 458.10152921449;
        ["y"] = -122.75224664602;
        ["g"] = 14;
        ["sublevel"] = 1;
      };
      [5] = {
        ["x"] = 471.12035622466;
        ["y"] = -116.31924253356;
        ["g"] = 14;
        ["sublevel"] = 1;
      };
      [6] = {
        ["x"] = 456.66551702163;
        ["y"] = -189.21020838642;
        ["g"] = 16;
        ["sublevel"] = 1;
      };
      [7] = {
        ["x"] = 465.59418684662;
        ["y"] = -189.38612741357;
        ["g"] = 16;
        ["sublevel"] = 1;
        ["infested"] = {
          [1] = true;
        };
      };
      [8] = {
        ["x"] = 391.88059332997;
        ["y"] = -151.99984829127;
        ["g"] = 17;
        ["sublevel"] = 1;
      };
      [9] = {
        ["x"] = 557.62105253186;
        ["y"] = -160.7951129036;
        ["g"] = 27;
        ["sublevel"] = 1;
        ["teeming"] = true;
      };
    };
  };
  [12] = {
    ["name"] = "Shieldbearer of Zul";
    ["id"] = 127879;
    ["count"] = 4;
    ["health"] = 760810;
    ["scale"] = 1;
    ["stealthDetect"] = true;
    ["displayId"] = 80904;
    ["creatureType"] = "Undead";
    ["level"] = 120;
    ["reaping"] = 148716;
    ["characteristics"] = {
      ["Taunt"] = true;
      ["Incapacitate"] = true;
      ["Control Undead"] = true;
      ["Silence"] = true;
      ["Shackle Undead"] = true;
      ["Root"] = true;
      ["Disorient"] = true;
      ["Repentance"] = true;
      ["Stun"] = true;
      ["Slow"] = true;
    };
    ["spells"] = {
      [209859] = {
      };
      [253721] = {
      };
      [258653] = {
      };
      [273185] = {
      };
      [277242] = {
      };
      [277564] = {
      };
    };
    ["clones"] = {
      [1] = {
        ["x"] = 586.21481682213;
        ["y"] = -180.17009972189;
        ["g"] = 10;
        ["sublevel"] = 1;
      };
      [2] = {
        ["x"] = 546.52731743389;
        ["y"] = -178.138849806;
        ["g"] = 11;
        ["sublevel"] = 1;
        ["infested"] = {
          [2] = true;
        };
      };
      [3] = {
        ["x"] = 551.2148120817;
        ["y"] = -174.07634997422;
        ["g"] = 11;
        ["sublevel"] = 1;
        ["patrol"] = {
          [1] = {
            ["x"] = 551.2148120817;
            ["y"] = -174.07634997422;
          };
          [2] = {
            ["x"] = 559.80855450452;
            ["y"] = -182.67009910256;
          };
          [3] = {
            ["x"] = 565.43354808189;
            ["y"] = -191.10760287966;
          };
          [4] = {
            ["x"] = 559.80855450452;
            ["y"] = -182.67009910256;
          };
          [5] = {
            ["x"] = 551.2148120817;
            ["y"] = -174.07634997422;
          };
          [6] = {
            ["x"] = 542.3085521343;
            ["y"] = -165.32635549463;
          };
          [7] = {
            ["x"] = 535.90231168414;
            ["y"] = -160.63887425787;
          };
          [8] = {
            ["x"] = 542.3085521343;
            ["y"] = -165.32635549463;
          };
        };
      };
      [4] = {
        ["x"] = 552.62105377052;
        ["y"] = -146.26384596779;
        ["g"] = 12;
        ["sublevel"] = 1;
      };
      [5] = {
        ["x"] = 509.17478672867;
        ["y"] = -148.96478547959;
        ["g"] = 13;
        ["sublevel"] = 1;
      };
      [6] = {
        ["x"] = 511.22537774386;
        ["y"] = -139.72297834971;
        ["g"] = 13;
        ["sublevel"] = 1;
      };
      [7] = {
        ["x"] = 449.66549873072;
        ["y"] = -181.2102014957;
        ["g"] = 16;
        ["sublevel"] = 1;
      };
      [8] = {
        ["x"] = 473.23693008871;
        ["y"] = -181.06734860891;
        ["g"] = 16;
        ["sublevel"] = 1;
        ["infested"] = {
          [3] = true;
        };
      };
    };
  };
  [13] = {
    ["name"] = "Vol'kaal";
    ["id"] = 122965;
    ["count"] = 0;
    ["health"] = 4918368;
    ["scale"] = 1;
    ["displayId"] = 79453;
    ["creatureType"] = "Undead";
    ["level"] = 122;
    ["isBoss"] = true;
    ["encounterID"] = 2036;
    ["instanceID"] = 968;
    ["characteristics"] = {
      ["Taunt"] = true;
    };
    ["spells"] = {
      [250241] = {
      };
      [250258] = {
      };
      [250259] = {
      };
      [250368] = {
      };
      [250372] = {
      };
      [259572] = {
      };
      [259574] = {
      };
    };
    ["clones"] = {
      [1] = {
        ["x"] = 459.77354478613;
        ["y"] = -88.199940336495;
        ["sublevel"] = 1;
      };
    };
  };
  [14] = {
    ["name"] = "Toxic Saurid";
    ["id"] = 128435;
    ["count"] = 1;
    ["health"] = 153699;
    ["scale"] = 0.6;
    ["displayId"] = 81323;
    ["creatureType"] = "Beast";
    ["level"] = 120;
    ["reaping"] = 148716;
    ["characteristics"] = {
      ["Taunt"] = true;
      ["Incapacitate"] = true;
      ["Silence"] = true;
      ["Root"] = true;
      ["Fear"] = true;
      ["Disorient"] = true;
      ["Sap"] = true;
      ["Stun"] = true;
      ["Slow"] = true;
    };
    ["spells"] = {
      [209859] = {
      };
      [251187] = {
      };
      [251188] = {
      };
      [255895] = {
      };
      [277242] = {
      };
      [277564] = {
      };
    };
    ["clones"] = {
      [1] = {
        ["x"] = 545.93839826733;
        ["y"] = -278.27607671767;
        ["g"] = 18;
        ["sublevel"] = 1;
        ["infested"] = {
          [1] = true;
        };
      };
      [2] = {
        ["x"] = 541.93834457695;
        ["y"] = -269.07605622663;
        ["g"] = 18;
        ["sublevel"] = 1;
      };
      [3] = {
        ["x"] = 545.13838752925;
        ["y"] = -273.07605841859;
        ["g"] = 18;
        ["sublevel"] = 1;
      };
      [4] = {
        ["x"] = 540.8758256645;
        ["y"] = -280.48232467856;
        ["g"] = 18;
        ["sublevel"] = 1;
      };
      [5] = {
        ["x"] = 536.93215532409;
        ["y"] = -269.25733951273;
        ["g"] = 18;
        ["sublevel"] = 1;
      };
      [6] = {
        ["x"] = 538.62927512276;
        ["y"] = -225.8201414651;
        ["g"] = 19;
        ["sublevel"] = 1;
        ["infested"] = {
          [1] = true;
        };
      };
      [7] = {
        ["x"] = 540.9580492496;
        ["y"] = -230.75165415435;
        ["g"] = 19;
        ["sublevel"] = 1;
      };
      [8] = {
        ["x"] = 546.02652652019;
        ["y"] = -231.2995947831;
        ["g"] = 19;
        ["sublevel"] = 1;
      };
      [9] = {
        ["x"] = 543.83476400519;
        ["y"] = -225.5461593931;
        ["g"] = 19;
        ["sublevel"] = 1;
      };
      [10] = {
        ["x"] = 540.68407305641;
        ["y"] = -219.65575354295;
        ["g"] = 19;
        ["sublevel"] = 1;
      };
      [11] = {
        ["x"] = 493.79757358014;
        ["y"] = -263.78347540154;
        ["g"] = 20;
        ["sublevel"] = 1;
      };
      [12] = {
        ["x"] = 487.79756170913;
        ["y"] = -268.18348296254;
        ["g"] = 20;
        ["sublevel"] = 1;
      };
      [13] = {
        ["x"] = 490.19755959108;
        ["y"] = -272.18346798836;
        ["g"] = 20;
        ["sublevel"] = 1;
      };
      [14] = {
        ["x"] = 493.79757358014;
        ["y"] = -270.18345830931;
        ["g"] = 20;
        ["sublevel"] = 1;
      };
      [15] = {
        ["x"] = 496.53590280593;
        ["y"] = -267.13793528873;
        ["g"] = 20;
        ["sublevel"] = 1;
      };
      [16] = {
        ["x"] = 453.16995680192;
        ["y"] = -242.06262037639;
        ["g"] = 21;
        ["sublevel"] = 1;
        ["infested"] = {
          [1] = true;
        };
      };
      [17] = {
        ["x"] = 459.7608258794;
        ["y"] = -239.28989084622;
        ["g"] = 21;
        ["sublevel"] = 1;
      };
      [18] = {
        ["x"] = 460.26085406029;
        ["y"] = -233.78989199268;
        ["g"] = 21;
        ["sublevel"] = 1;
      };
      [19] = {
        ["x"] = 454.2608377547;
        ["y"] = -237.03988204942;
        ["g"] = 21;
        ["sublevel"] = 1;
      };
      [20] = {
        ["x"] = 455.26085120113;
        ["y"] = -232.78987854625;
        ["g"] = 21;
        ["sublevel"] = 1;
      };
      [21] = {
        ["x"] = 457.60716602951;
        ["y"] = -211.68516075284;
        ["g"] = 22;
        ["sublevel"] = 1;
      };
      [22] = {
        ["x"] = 456.91964751086;
        ["y"] = -200.77891187358;
        ["g"] = 22;
        ["sublevel"] = 1;
      };
      [23] = {
        ["x"] = 461.78897604719;
        ["y"] = -211.82150261936;
        ["g"] = 22;
        ["sublevel"] = 1;
        ["infested"] = {
          [1] = true;
        };
      };
      [24] = {
        ["x"] = 462.82592244389;
        ["y"] = -202.87266463715;
        ["g"] = 22;
        ["sublevel"] = 1;
      };
      [25] = {
        ["x"] = 465.76339716057;
        ["y"] = -207.52890800999;
        ["g"] = 22;
        ["sublevel"] = 1;
      };
      [26] = {
        ["x"] = 454.63721809655;
        ["y"] = -294.97299967774;
        ["g"] = 23;
        ["sublevel"] = 1;
      };
      [27] = {
        ["x"] = 460.32472606329;
        ["y"] = -297.03551529626;
        ["g"] = 23;
        ["sublevel"] = 1;
      };
      [28] = {
        ["x"] = 465.34744074348;
        ["y"] = -299.03552292058;
        ["g"] = 23;
        ["sublevel"] = 1;
      };
      [29] = {
        ["x"] = 456.23097591113;
        ["y"] = -298.50427136136;
        ["g"] = 23;
        ["sublevel"] = 1;
      };
      [30] = {
        ["x"] = 461.8247033176;
        ["y"] = -303.0355123333;
        ["g"] = 23;
        ["sublevel"] = 1;
        ["infested"] = {
          [1] = true;
        };
      };
      [31] = {
        ["x"] = 463.19878438472;
        ["y"] = -331.82209612897;
        ["g"] = 24;
        ["sublevel"] = 1;
      };
      [32] = {
        ["x"] = 457.80149069551;
        ["y"] = -332.18012174767;
        ["g"] = 24;
        ["sublevel"] = 1;
      };
      [33] = {
        ["x"] = 459.0013416387;
        ["y"] = -337.8095472715;
        ["g"] = 24;
        ["sublevel"] = 1;
      };
      [34] = {
        ["x"] = 463.13585749845;
        ["y"] = -336.73951909064;
        ["g"] = 24;
        ["sublevel"] = 1;
      };
      [35] = {
        ["x"] = 439.22572279091;
        ["y"] = -265.14032267036;
        ["g"] = 25;
        ["sublevel"] = 1;
      };
      [36] = {
        ["x"] = 436.74857368902;
        ["y"] = -273.40281520645;
        ["g"] = 25;
        ["sublevel"] = 1;
        ["infested"] = {
          [1] = true;
        };
      };
      [37] = {
        ["x"] = 437.61455679274;
        ["y"] = -268.76841214407;
        ["g"] = 25;
        ["sublevel"] = 1;
      };
      [38] = {
        ["x"] = 439.45100459994;
        ["y"] = -276.707728719;
        ["g"] = 25;
        ["sublevel"] = 1;
      };
    };
  };
  [15] = {
    ["name"] = "Feasting Skyscreamer";
    ["id"] = 128434;
    ["count"] = 4;
    ["health"] = 753125;
    ["scale"] = 1;
    ["displayId"] = 76913;
    ["creatureType"] = "Beast";
    ["level"] = 120;
    ["reaping"] = 148716;
    ["characteristics"] = {
      ["Taunt"] = true;
      ["Incapacitate"] = true;
      ["Silence"] = true;
      ["Mind Control"] = true;
      ["Polymorph"] = true;
      ["Root"] = true;
      ["Fear"] = true;
      ["Disorient"] = true;
      ["Imprison"] = true;
      ["Sap"] = true;
      ["Stun"] = true;
      ["Slow"] = true;
    };
    ["spells"] = {
      [209859] = {
      };
      [255041] = {
      };
      [277242] = {
      };
      [277564] = {
      };
    };
    ["clones"] = {
      [1] = {
        ["x"] = 489.90350388003;
        ["y"] = -279.9216087774;
        ["g"] = 26;
        ["sublevel"] = 1;
        ["infested"] = {
          [2] = true;
        };
      };
      [2] = {
        ["x"] = 527.88395942802;
        ["y"] = -334.47899998112;
        ["sublevel"] = 1;
        ["infested"] = {
          [2] = true;
        };
      };
      [3] = {
        ["x"] = 542.30592320306;
        ["y"] = -347.25195468306;
        ["sublevel"] = 1;
        ["infested"] = {
          [2] = true;
          [3] = true;
        };
      };
      [4] = {
        ["x"] = 475.87887856681;
        ["y"] = -295.22113404063;
        ["sublevel"] = 1;
      };
      [5] = {
        ["x"] = 439.04239027483;
        ["y"] = -295.00076697932;
        ["sublevel"] = 1;
      };
      [6] = {
        ["x"] = 467.7141645445;
        ["y"] = -231.97955843208;
        ["sublevel"] = 1;
        ["infested"] = {
          [3] = true;
        };
      };
      [7] = {
        ["x"] = 452.18757422234;
        ["y"] = -206.57366384027;
        ["sublevel"] = 1;
        ["infested"] = {
          [2] = true;
        };
      };
      [8] = {
        ["x"] = 451.3609693652;
        ["y"] = -335.85455836855;
        ["sublevel"] = 1;
        ["infested"] = {
          [2] = true;
          [3] = true;
        };
      };
      [9] = {
        ["x"] = 497.31402487112;
        ["y"] = -279.87601828523;
        ["g"] = 26;
        ["sublevel"] = 1;
        ["teeming"] = true;
      };
      [10] = {
        ["x"] = 482.96621251728;
        ["y"] = -283.80681570174;
        ["g"] = 26;
        ["sublevel"] = 1;
        ["teeming"] = true;
      };
    };
  };
  [16] = {
    ["name"] = "Rezan";
    ["id"] = 122963;
    ["count"] = 0;
    ["health"] = 5379465;
    ["scale"] = 1;
    ["displayId"] = 78188;
    ["creatureType"] = "Undead";
    ["level"] = 122;
    ["isBoss"] = true;
    ["encounterID"] = 2083;
    ["instanceID"] = 968;
    ["characteristics"] = {
      ["Taunt"] = true;
    };
    ["spells"] = {
      [205276] = {
      };
      [255371] = {
      };
      [255372] = {
      };
      [255373] = {
      };
      [255421] = {
      };
      [255434] = {
      };
      [255445] = {
      };
      [257407] = {
      };
    };
    ["clones"] = {
      [1] = {
        ["x"] = 489.43807463015;
        ["y"] = -334.61510501455;
        ["sublevel"] = 2;
        ["patrol"] = {
          [1] = {
            ["x"] = 489.43807463015;
            ["y"] = -334.61510501455;
          };
          [2] = {
            ["x"] = 482.37036673354;
            ["y"] = -376.08020579747;
          };
          [3] = {
            ["x"] = 412.37045932562;
            ["y"] = -395.45516723723;
          };
          [4] = {
            ["x"] = 363.62040406793;
            ["y"] = -364.83021780455;
          };
          [5] = {
            ["x"] = 362.99544943846;
            ["y"] = -299.8301888311;
          };
          [6] = {
            ["x"] = 411.74539740781;
            ["y"] = -271.08023739724;
          };
          [7] = {
            ["x"] = 466.12031255152;
            ["y"] = -273.58021684761;
          };
          [8] = {
            ["x"] = 489.43807463015;
            ["y"] = -334.61510501455;
          };
        };
      };
    };
  };
  [17] = {
    ["name"] = "Dinomancer Kish'o";
    ["id"] = 129553;
    ["count"] = 10;
    ["health"] = 1844388;
    ["scale"] = 1.2;
    ["displayId"] = 80709;
    ["creatureType"] = "Humanoid";
    ["level"] = 121;
    ["reaping"] = 148894;
    ["spells"] = {
      [256846] = {
      };
      [256849] = {
      };
      [256864] = {
      };
      [277564] = {
      };
    };
    ["clones"] = {
      [1] = {
        ["x"] = 444.52062418018;
        ["y"] = -270.38129120084;
        ["g"] = 25;
        ["sublevel"] = 1;
        ["patrol"] = {
        };
        ["infested"] = {
          [3] = true;
        };
      };
    };
  };
  [18] = {
    ["name"] = "T'lonja";
    ["id"] = 128455;
    ["count"] = 6;
    ["health"] = 1536990;
    ["scale"] = 1;
    ["displayId"] = 47659;
    ["creatureType"] = "Beast";
    ["level"] = 121;
    ["reaping"] = 148894;
    ["characteristics"] = {
      ["Taunt"] = true;
    };
    ["spells"] = {
      [255567] = {
      };
      [277564] = {
      };
    };
    ["clones"] = {
      [1] = {
        ["x"] = 444.43212544974;
        ["y"] = -278.67848624537;
        ["g"] = 25;
        ["sublevel"] = 1;
      };
    };
  };
  [19] = {
    ["name"] = "Monzumi";
    ["id"] = 129552;
    ["count"] = 6;
    ["health"] = 1567730;
    ["scale"] = 1;
    ["displayId"] = 76483;
    ["creatureType"] = "Beast";
    ["level"] = 121;
    ["reaping"] = 148894;
    ["spells"] = {
      [256882] = {
      };
      [256884] = {
      };
      [277564] = {
      };
    };
    ["clones"] = {
      [1] = {
        ["x"] = 444.29744091219;
        ["y"] = -260.604081403;
        ["g"] = 25;
        ["sublevel"] = 1;
      };
    };
  };
  [20] = {
    ["name"] = "Yazma";
    ["id"] = 122968;
    ["count"] = 0;
    ["health"] = 5994261;
    ["scale"] = 1;
    ["displayId"] = 79568;
    ["creatureType"] = "Humanoid";
    ["level"] = 122;
    ["isBoss"] = true;
    ["encounterID"] = 2030;
    ["instanceID"] = 968;
    ["characteristics"] = {
      ["Taunt"] = true;
    };
    ["spells"] = {
      [249919] = {
      };
      [250022] = {
      };
      [250028] = {
      };
      [250050] = {
      };
      [250096] = {
      };
      [256577] = {
      };
      [257066] = {
      };
      [259187] = {
      };
      [259191] = {
      };
    };
    ["clones"] = {
      [1] = {
        ["x"] = 292.26608457354;
        ["y"] = -270.74025109053;
        ["sublevel"] = 1;
      };
    };
  };
  [21] = {
    ["name"] = "Emissary of the Tides";
    ["id"] = 155434;
    ["count"] = 4;
    ["health"] = 614795;
    ["ignoreFortified"] = true;
    ["scale"] = 1;
    ["displayId"] = 39391;
    ["iconTexture"] = 132315;
    ["creatureType"] = "Humanoid";
    ["level"] = 120;
    ["characteristics"] = {
      ["Taunt"] = true;
    };
    ["spells"] = {
      [302415] = {
      };
      [302417] = {
      };
      [302418] = {
      };
    };
    ["clones"] = {
      [1] = {
        ["x"] = 458.90792567836;
        ["y"] = -205.44525788581;
        ["sublevel"] = 1;
        ["week"] = {
          [1] = true;
          [4] = true;
          [7] = true;
          [10] = true;
        };
      };
      [2] = {
        ["x"] = 503.54399678749;
        ["y"] = -434.56037348003;
        ["g"] = 6;
        ["sublevel"] = 1;
        ["week"] = {
          [1] = true;
          [4] = true;
          [7] = true;
          [10] = true;
        };
      };
      [3] = {
        ["x"] = 573.53256517655;
        ["y"] = -347.06444907112;
        ["g"] = 1;
        ["sublevel"] = 1;
        ["week"] = {
          [1] = true;
          [4] = true;
          [7] = true;
          [10] = true;
        };
      };
      [4] = {
        ["x"] = 537.81386947478;
        ["y"] = -339.63691782877;
        ["sublevel"] = 1;
        ["week"] = {
          [1] = true;
          [4] = true;
          [7] = true;
          [10] = true;
        };
      };
      [5] = {
        ["x"] = 454.85084422261;
        ["y"] = -271.06802626929;
        ["g"] = 25;
        ["sublevel"] = 1;
        ["week"] = {
          [2] = true;
          [5] = true;
          [8] = true;
          [11] = true;
        };
      };
      [6] = {
        ["x"] = 461.47139765412;
        ["y"] = -195.23767109489;
        ["g"] = 16;
        ["sublevel"] = 1;
        ["week"] = {
          [2] = true;
          [5] = true;
          [8] = true;
          [11] = true;
        };
      };
      [7] = {
        ["x"] = 503.2806749384;
        ["y"] = -157.00850644419;
        ["g"] = 13;
        ["sublevel"] = 1;
        ["week"] = {
          [2] = true;
          [5] = true;
          [8] = true;
          [11] = true;
        };
      };
      [8] = {
        ["x"] = 567.57207937263;
        ["y"] = -368.74243091578;
        ["g"] = 2;
        ["sublevel"] = 1;
        ["week"] = {
          [2] = true;
          [5] = true;
          [8] = true;
          [11] = true;
        };
      };
      [9] = {
        ["x"] = 460.67986335652;
        ["y"] = -456.69885985073;
        ["g"] = 7;
        ["sublevel"] = 1;
        ["week"] = {
          [2] = true;
          [5] = true;
          [8] = true;
          [11] = true;
        };
      };
      [10] = {
        ["x"] = 550.81424412841;
        ["y"] = -385.98321486016;
        ["g"] = 4;
        ["sublevel"] = 1;
        ["week"] = {
          [3] = true;
          [6] = true;
          [9] = true;
          [12] = true;
        };
      };
      [11] = {
        ["x"] = 459.84183309614;
        ["y"] = -359.79386429516;
        ["g"] = 8;
        ["sublevel"] = 1;
        ["week"] = {
          [3] = true;
          [6] = true;
          [9] = true;
          [12] = true;
        };
      };
      [12] = {
        ["x"] = 534.54570477745;
        ["y"] = -340.65941771733;
        ["sublevel"] = 1;
        ["week"] = {
          [3] = true;
          [6] = true;
          [9] = true;
          [12] = true;
        };
      };
      [13] = {
        ["x"] = 459.14186309195;
        ["y"] = -218.49919597229;
        ["g"] = 22;
        ["sublevel"] = 1;
        ["week"] = {
          [3] = true;
          [6] = true;
          [9] = true;
          [12] = true;
        };
      };
    };
  };
  [22] = {
    ["name"] = "Void-Touched Emissary";
    ["id"] = 155433;
    ["count"] = 4;
    ["health"] = 999042;
    ["ignoreFortified"] = true;
    ["scale"] = 1;
    ["stealthDetect"] = true;
    ["displayId"] = 39391;
    ["iconTexture"] = 132886;
    ["creatureType"] = "Humanoid";
    ["level"] = 122;
    ["characteristics"] = {
      ["Taunt"] = true;
    };
    ["spells"] = {
      [302415] = {
      };
      [302419] = {
      };
      [302420] = {
      };
      [302421] = {
      };
    };
    ["clones"] = {
      [1] = {
        ["x"] = 538.51147276124;
        ["y"] = -157.46598080656;
        ["g"] = 12;
        ["sublevel"] = 1;
        ["week"] = {
          [1] = true;
          [4] = true;
          [7] = true;
          [10] = true;
        };
      };
      [2] = {
        ["x"] = 462.91832652344;
        ["y"] = -110.37230924874;
        ["sublevel"] = 1;
        ["week"] = {
          [1] = true;
          [4] = true;
          [7] = true;
          [10] = true;
        };
      };
      [3] = {
        ["x"] = 480.83074314172;
        ["y"] = -271.44664490066;
        ["g"] = 30;
        ["sublevel"] = 1;
        ["week"] = {
          [1] = true;
          [4] = true;
          [7] = true;
          [10] = true;
        };
      };
      [4] = {
        ["x"] = 459.74169977376;
        ["y"] = -361.26843981078;
        ["g"] = 8;
        ["sublevel"] = 1;
        ["week"] = {
          [1] = true;
          [4] = true;
          [7] = true;
          [10] = true;
        };
      };
      [5] = {
        ["x"] = 561.58856814642;
        ["y"] = -420.14996461394;
        ["g"] = 5;
        ["sublevel"] = 1;
        ["week"] = {
          [1] = true;
          [4] = true;
          [7] = true;
          [10] = true;
        };
      };
      [6] = {
        ["x"] = 569.02530990563;
        ["y"] = -212.71729615347;
        ["g"] = 9;
        ["sublevel"] = 1;
        ["week"] = {
          [2] = true;
          [5] = true;
          [8] = true;
          [11] = true;
        };
      };
      [7] = {
        ["x"] = 551.26909937012;
        ["y"] = -386.14922070626;
        ["g"] = 4;
        ["sublevel"] = 1;
        ["week"] = {
          [2] = true;
          [5] = true;
          [8] = true;
          [11] = true;
        };
      };
      [8] = {
        ["x"] = 460.43620984736;
        ["y"] = -443.60628265724;
        ["sublevel"] = 1;
        ["week"] = {
          [2] = true;
          [5] = true;
          [8] = true;
          [11] = true;
        };
      };
      [9] = {
        ["x"] = 541.33898704496;
        ["y"] = -211.63272463732;
        ["g"] = 19;
        ["sublevel"] = 1;
        ["week"] = {
          [3] = true;
          [6] = true;
          [9] = true;
          [12] = true;
        };
      };
      [10] = {
        ["x"] = 461.12212089003;
        ["y"] = -291.796548553;
        ["g"] = 23;
        ["sublevel"] = 1;
        ["week"] = {
          [3] = true;
          [6] = true;
          [9] = true;
          [12] = true;
        };
      };
      [11] = {
        ["x"] = 584.69361339341;
        ["y"] = -193.4544799806;
        ["g"] = 10;
        ["sublevel"] = 1;
        ["week"] = {
          [3] = true;
          [6] = true;
          [9] = true;
          [12] = true;
        };
      };
    };
  };
  [23] = {
    ["name"] = "Enchanted Emissary";
    ["id"] = 155432;
    ["count"] = 4;
    ["health"] = 15369884;
    ["ignoreFortified"] = true;
    ["scale"] = 1;
    ["displayId"] = 39391;
    ["iconTexture"] = 135735;
    ["creatureType"] = "Humanoid";
    ["level"] = 121;
    ["characteristics"] = {
      ["Taunt"] = true;
    };
    ["spells"] = {
      [290027] = {
      };
      [302415] = {
      };
      [303632] = {
      };
    };
    ["clones"] = {
      [1] = {
        ["x"] = 456.08534584781;
        ["y"] = -305.24756034958;
        ["g"] = 23;
        ["sublevel"] = 1;
        ["week"] = {
          [1] = true;
          [4] = true;
          [7] = true;
          [10] = true;
        };
      };
      [2] = {
        ["x"] = 538.35169590867;
        ["y"] = -275.28612484369;
        ["g"] = 18;
        ["sublevel"] = 1;
        ["week"] = {
          [1] = true;
          [4] = true;
          [7] = true;
          [10] = true;
        };
      };
      [3] = {
        ["x"] = 552.76500707673;
        ["y"] = -386.03223385248;
        ["g"] = 4;
        ["sublevel"] = 1;
        ["week"] = {
          [1] = true;
          [4] = true;
          [7] = true;
          [10] = true;
        };
      };
      [4] = {
        ["x"] = 535.04104978441;
        ["y"] = -340.37485465888;
        ["sublevel"] = 1;
        ["week"] = {
          [2] = true;
          [5] = true;
          [8] = true;
          [11] = true;
        };
      };
      [5] = {
        ["x"] = 540.77603555886;
        ["y"] = -213.635826986;
        ["g"] = 19;
        ["sublevel"] = 1;
        ["week"] = {
          [2] = true;
          [5] = true;
          [8] = true;
          [11] = true;
        };
      };
      [6] = {
        ["x"] = 459.95071338437;
        ["y"] = -344.11734752331;
        ["sublevel"] = 1;
        ["week"] = {
          [2] = true;
          [5] = true;
          [8] = true;
          [11] = true;
        };
      };
      [7] = {
        ["x"] = 504.84566318056;
        ["y"] = -434.58659862591;
        ["g"] = 6;
        ["sublevel"] = 1;
        ["week"] = {
          [2] = true;
          [5] = true;
          [8] = true;
          [11] = true;
        };
      };
      [8] = {
        ["x"] = 561.5286884;
        ["y"] = -420.26946718352;
        ["g"] = 5;
        ["sublevel"] = 1;
        ["week"] = {
          [3] = true;
          [6] = true;
          [9] = true;
          [12] = true;
        };
      };
      [9] = {
        ["x"] = 460.41706287576;
        ["y"] = -465.79408375889;
        ["g"] = 7;
        ["sublevel"] = 1;
        ["week"] = {
          [3] = true;
          [6] = true;
          [9] = true;
          [12] = true;
        };
      };
      [10] = {
        ["x"] = 453.74159424622;
        ["y"] = -271.27285233121;
        ["g"] = 25;
        ["sublevel"] = 1;
        ["week"] = {
          [3] = true;
          [6] = true;
          [9] = true;
          [12] = true;
        };
      };
      [11] = {
        ["x"] = 461.32282222639;
        ["y"] = -195.14841136753;
        ["g"] = 16;
        ["sublevel"] = 1;
        ["week"] = {
          [3] = true;
          [6] = true;
          [9] = true;
          [12] = true;
        };
      };
      [12] = {
        ["x"] = 503.28840889817;
        ["y"] = -154.69813183134;
        ["g"] = 13;
        ["sublevel"] = 1;
        ["week"] = {
          [3] = true;
          [6] = true;
          [9] = true;
          [12] = true;
        };
      };
    };
  };
  [24] = {
    ["name"] = "Blood of the Corruptor";
    ["id"] = 161244;
    ["count"] = 4;
    ["teemingCount"] = 6;
    ["health"] = 2151786;
    ["scale"] = 1.4;
    ["stealthDetect"] = true;
    ["displayId"] = 92229;
    ["creatureType"] = "Aberration";
    ["level"] = 122;
    ["corrupted"] = true;
    ["characteristics"] = {
      ["Taunt"] = true;
    };
    ["spells"] = {
      [314397] = {
      };
      [314565] = {
      };
      [314566] = {
      };
      [314592] = {
      };
    };
    ["clones"] = {
      [1] = {
        ["x"] = 424.03765671461;
        ["y"] = -152.06108303925;
        ["sublevel"] = 1;
        ["week"] = {
          [1] = true;
          [2] = true;
          [5] = true;
          [6] = true;
          [9] = true;
          [10] = true;
        };
      };
      [2] = {
        ["x"] = 586.3970767357;
        ["y"] = -327.64783608562;
        ["sublevel"] = 1;
        ["week"] = {
          [3] = true;
          [4] = true;
          [7] = true;
          [8] = true;
          [11] = true;
          [12] = true;
        };
      };
    };
  };
  [25] = {
    ["name"] = "Samh'rek, Beckoner of Chaos";
    ["id"] = 161243;
    ["count"] = 4;
    ["teemingCount"] = 6;
    ["health"] = 2151786;
    ["scale"] = 1.4;
    ["stealthDetect"] = true;
    ["displayId"] = 90742;
    ["creatureType"] = "Aberration";
    ["level"] = 122;
    ["corrupted"] = true;
    ["characteristics"] = {
      ["Taunt"] = true;
    };
    ["spells"] = {
      [314397] = {
      };
      [314477] = {
      };
      [314483] = {
      };
      [314531] = {
      };
    };
    ["clones"] = {
      [1] = {
        ["x"] = 585.53402608042;
        ["y"] = -194.90011987361;
        ["sublevel"] = 1;
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
      };
    };
  };
  [26] = {
    ["name"] = "Urg'roth, Breaker of Heroes";
    ["id"] = 161124;
    ["count"] = 4;
    ["teemingCount"] = 6;
    ["health"] = 2151786;
    ["scale"] = 1.4;
    ["stealthDetect"] = true;
    ["displayId"] = 89415;
    ["creatureType"] = "Aberration";
    ["level"] = 122;
    ["corrupted"] = true;
    ["characteristics"] = {
      ["Taunt"] = true;
    };
    ["spells"] = {
      [314308] = {
      };
      [314309] = {
      };
      [314387] = {
      };
      [314397] = {
      };
    };
    ["clones"] = {
      [1] = {
        ["x"] = 463.47681237374;
        ["y"] = -270.37840410776;
        ["sublevel"] = 1;
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
      };
    };
  };
  [27] = {
    ["name"] = "Voidweaver Mal'thir";
    ["id"] = 161241;
    ["count"] = 4;
    ["teemingCount"] = 6;
    ["health"] = 2151786;
    ["scale"] = 1.4;
    ["stealthDetect"] = true;
    ["displayId"] = 91910;
    ["creatureType"] = "Beast";
    ["level"] = 122;
    ["corrupted"] = true;
    ["characteristics"] = {
      ["Taunt"] = true;
    };
    ["spells"] = {
      [314397] = {
      };
      [314406] = {
      };
      [314411] = {
      };
      [314463] = {
      };
      [314467] = {
      };
    };
    ["clones"] = {
      [1] = {
        ["x"] = 586.14232316491;
        ["y"] = -330.30652587834;
        ["sublevel"] = 1;
        ["week"] = {
          [1] = true;
          [2] = true;
          [5] = true;
          [6] = true;
          [9] = true;
          [10] = true;
        };
      };
      [2] = {
        ["x"] = 424.33261162333;
        ["y"] = -151.07859031432;
        ["sublevel"] = 1;
        ["week"] = {
          [3] = true;
          [4] = true;
          [7] = true;
          [8] = true;
          [11] = true;
          [12] = true;
        };
      };
    };
  };
};
