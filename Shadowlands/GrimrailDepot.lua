local MDT = MDT
local L = MDT.L
local dungeonIndex = 40
MDT.dungeonList[dungeonIndex] = L["GrimrailDepot"]
MDT.mapInfo[dungeonIndex] = {
  viewportPositionOverrides = {
    [1] = {
      zoomScale = 1.2999999523163;
      horizontalPan = 108.09110952974;
      verticalPan = 18.640150307329;
    };
    [3] = {
      zoomScale = 1.2999999523163;
      horizontalPan = 8.0440521252548e-07;
      verticalPan = 69.777157123272;
    };
  }
};

MDT.dungeonMaps[dungeonIndex] = {
  [0] = "BlackrockTrainDepotDungeon",
  [1] = "BlackrockTrainDepotDungeon1_",
  [2] = "BlackrockTrainDepotDungeon3_",
  [3] = "BlackrockTrainDepotDungeon4_",
}
MDT.dungeonSubLevels[dungeonIndex] = {
  [1] = L["Train Depot"],
  [2] = L["Rear Train Cars"],
  [3] = L["Forward Train Cars"],
}

MDT.dungeonTotalCount[dungeonIndex] = { normal = 300, teeming = 1000, teemingEnabled = true }

MDT.mapPOIs[dungeonIndex] = {
  [1] = {
    [1] = {
      ["template"] = "MapLinkPinTemplate";
      ["type"] = "mapLink";
      ["x"] = 589.48503271105;
      ["y"] = -174.26793333476;
      ["target"] = 2;
      ["direction"] = 1;
      ["connectionIndex"] = 1;
    };
    [2] = {
      ["template"] = "DeathReleasePinTemplate";
      ["type"] = "graveyard";
      ["x"] = 273.83563921658;
      ["y"] = -144.28666476245;
      ["graveyardDescription"] = "";
    };
  };
  [2] = {
    [1] = {
      ["template"] = "MapLinkPinTemplate";
      ["type"] = "mapLink";
      ["x"] = 759.42277857246;
      ["y"] = -290.00086990937;
      ["target"] = 1;
      ["direction"] = -1;
      ["connectionIndex"] = 1;
    };
    [2] = {
      ["template"] = "MapLinkPinTemplate";
      ["type"] = "mapLink";
      ["x"] = 46.922927237933;
      ["y"] = -290.57782865308;
      ["target"] = 3;
      ["direction"] = -2;
      ["connectionIndex"] = 2;
    };
  };
  [3] = {
    [1] = {
      ["template"] = "MapLinkPinTemplate";
      ["type"] = "mapLink";
      ["x"] = 592.69220120775;
      ["y"] = -287.11634309425;
      ["target"] = 2;
      ["direction"] = 2;
      ["connectionIndex"] = 2;
    };
  };
};

MDT.dungeonEnemies[dungeonIndex] = {
  [1] = {
    ["name"] = "Grimrail Laborer";
    ["id"] = 81235;
    ["count"] = 2;
    ["health"] = 213050;
    ["scale"] = 1;
    ["displayId"] = 55909;
    ["creatureType"] = "Humanoid";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["x"] = 276.36820088227;
        ["y"] = -313.27076215266;
        ["g"] = 1;
        ["sublevel"] = 1;
        ["scale"] = 2.2;
      };
      [2] = {
        ["x"] = 216.8243412798;
        ["y"] = -360.25353107345;
        ["g"] = 1;
        ["sublevel"] = 1;
        ["scale"] = 2.2;
        ["disguised"] = true;
      };
      [3] = {
        ["x"] = 378.2634880803;
        ["y"] = -335.01200564972;
        ["g"] = 2;
        ["sublevel"] = 1;
        ["scale"] = 2.2;
        ["inspiring"] = true;
      };
      [4] = {
        ["x"] = 370.09535759097;
        ["y"] = -344.73234463277;
        ["g"] = 2;
        ["sublevel"] = 1;
        ["scale"] = 2.2;
        ["disguised"] = true;
      };
      [5] = {
        ["x"] = 577.40777917189;
        ["y"] = -101.27966101695;
        ["sublevel"] = 1;
        ["disguised"] = true;
      };
    };
  };
  [2] = {
    ["name"] = "Grimrail Overseer";
    ["id"] = 81212;
    ["count"] = 7;
    ["health"] = 340880;
    ["scale"] = 1;
    ["displayId"] = 56280;
    ["creatureType"] = "Humanoid";
    ["level"] = 61;
    ["clones"] = {
      [1] = {
        ["x"] = 275.33020680944;
        ["y"] = -292.56625821566;
        ["g"] = 1;
        ["sublevel"] = 1;
        ["scale"] = 2.2;
      };
      [2] = {
        ["x"] = 433.15821461989;
        ["y"] = -332.02933267962;
        ["g"] = 3;
        ["sublevel"] = 1;
        ["scale"] = 2.2;
      };
      [3] = {
        ["x"] = 435.93718644942;
        ["y"] = -313.01485606084;
        ["g"] = 3;
        ["sublevel"] = 1;
        ["scale"] = 2.2;
      };
      [4] = {
        ["x"] = 406.06035773746;
        ["y"] = -230.96485227527;
        ["sublevel"] = 1;
        ["scale"] = 2.2;
        ["patrol"] = {
          [1] = {
            ["x"] = 406.06035773746;
            ["y"] = -230.96485227527;
          };
          [2] = {
            ["x"] = 428.63090589944;
            ["y"] = -220.42171806282;
          };
          [3] = {
            ["x"] = 458.00153910596;
            ["y"] = -220.42171806282;
          };
          [4] = {
            ["x"] = 428.63090589944;
            ["y"] = -220.42171806282;
          };
          [5] = {
            ["x"] = 406.06035773746;
            ["y"] = -230.96485227527;
          };
          [6] = {
            ["x"] = 387.98404020927;
            ["y"] = -242.71191924222;
          };
          [7] = {
            ["x"] = 368.57844058971;
            ["y"] = -264.21543409541;
          };
          [8] = {
            ["x"] = 387.98404020927;
            ["y"] = -242.71191924222;
          };
        };
      };
      [5] = {
        ["x"] = 408.82553950019;
        ["y"] = -277.47530556105;
        ["sublevel"] = 1;
        ["scale"] = 2.2;
        ["patrol"] = {
          [1] = {
            ["x"] = 408.82553950019;
            ["y"] = -277.47530556105;
          };
          [2] = {
            ["x"] = 414.7322756224;
            ["y"] = -251.36578394323;
          };
          [3] = {
            ["x"] = 434.66237280706;
            ["y"] = -236.15601479095;
          };
          [4] = {
            ["x"] = 494.19037056241;
            ["y"] = -246.90771969876;
          };
          [5] = {
            ["x"] = 434.66237280706;
            ["y"] = -236.15601479095;
          };
          [6] = {
            ["x"] = 414.7322756224;
            ["y"] = -251.36578394323;
          };
          [7] = {
            ["x"] = 408.82553950019;
            ["y"] = -277.47530556105;
          };
          [8] = {
            ["x"] = 400.3092078017;
            ["y"] = -304.60006600839;
          };
          [9] = {
            ["x"] = 388.77074154084;
            ["y"] = -314.56508459;
          };
          [10] = {
            ["x"] = 340.51899127452;
            ["y"] = -317.44971616058;
          };
          [11] = {
            ["x"] = 388.77074154084;
            ["y"] = -314.56508459;
          };
          [12] = {
            ["x"] = 400.3092078017;
            ["y"] = -304.60006600839;
          };
        };
      };
    };
  };
  [3] = {
    ["name"] = "Grimrail Technician";
    ["id"] = 81236;
    ["count"] = 4;
    ["health"] = 213050;
    ["scale"] = 1;
    ["displayId"] = 56293;
    ["creatureType"] = "Humanoid";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["x"] = 260.39575313114;
        ["y"] = -300.86475213173;
        ["g"] = 1;
        ["sublevel"] = 1;
        ["scale"] = 2.2;
      };
      [2] = {
        ["x"] = 356.2998861702;
        ["y"] = -335.76727725187;
        ["g"] = 2;
        ["sublevel"] = 1;
        ["scale"] = 2.2;
      };
      [3] = {
        ["x"] = 458.6400574575;
        ["y"] = -244.26730195355;
        ["g"] = 4;
        ["sublevel"] = 1;
        ["scale"] = 2.2;
        ["inspiring"] = true;
      };
      [4] = {
        ["x"] = 446.37515683814;
        ["y"] = -261.16878531073;
        ["g"] = 4;
        ["sublevel"] = 1;
        ["scale"] = 2.2;
        ["disguised"] = true;
      };
    };
  };
  [4] = {
    ["name"] = "Railmaster Rocketspark";
    ["id"] = 77803;
    ["count"] = 0;
    ["health"] = 1218646;
    ["scale"] = 1;
    ["displayId"] = 54096;
    ["creatureType"] = "Humanoid";
    ["level"] = 62;
    ["isBoss"] = true;
    ["encounterID"] = 1138;
    ["instanceID"] = 536;
    ["clones"] = {
      [1] = {
        ["x"] = 630.53553772437;
        ["y"] = -311.54242180887;
        ["g"] = 5;
        ["sublevel"] = 1;
        ["scale"] = 2;
      };
    };
  };
  [5] = {
    ["name"] = "Borka the Brute";
    ["id"] = 77816;
    ["count"] = 0;
    ["health"] = 1467914;
    ["scale"] = 1;
    ["displayId"] = 60108;
    ["creatureType"] = "Humanoid";
    ["level"] = 62;
    ["isBoss"] = true;
    ["encounterID"] = 1138;
    ["instanceID"] = 536;
    ["clones"] = {
      [1] = {
        ["x"] = 605.62735257215;
        ["y"] = -341.3615819209;
        ["g"] = 5;
        ["sublevel"] = 1;
        ["scale"] = 2;
      };
    };
  };
  [6] = {
    ["name"] = "Grimrail Bombardier";
    ["id"] = 81407;
    ["count"] = 12;
    ["health"] = 351533;
    ["scale"] = 1;
    ["displayId"] = 59182;
    ["creatureType"] = "Humanoid";
    ["level"] = 61;
    ["clones"] = {
      [1] = {
        ["x"] = 587.07779171895;
        ["y"] = -113.7959039548;
        ["sublevel"] = 1;
        ["disguised"] = true;
      };
      [2] = {
        ["x"] = 627.20702103734;
        ["y"] = -152.51806010229;
        ["sublevel"] = 1;
        ["scale"] = 2.2;
      };
      [3] = {
        ["x"] = 622.02429627298;
        ["y"] = -116.81843798812;
        ["sublevel"] = 1;
        ["scale"] = 2.2;
      };
    };
  };
  [7] = {
    ["name"] = "Iron Infantry";
    ["id"] = 80940;
    ["count"] = 3;
    ["health"] = 213050;
    ["scale"] = 1;
    ["displayId"] = 55374;
    ["creatureType"] = "Humanoid";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["x"] = 586.99363819023;
        ["y"] = -300.79934822162;
        ["g"] = 6;
        ["sublevel"] = 2;
        ["scale"] = 2.7;
      };
      [2] = {
        ["x"] = 586.5097068697;
        ["y"] = -268.1606343537;
        ["g"] = 6;
        ["sublevel"] = 2;
        ["scale"] = 2.7;
      };
      [3] = {
        ["x"] = 602.52752162772;
        ["y"] = -285.03435488013;
        ["g"] = 6;
        ["sublevel"] = 2;
        ["scale"] = 2.7;
      };
      [4] = {
        ["x"] = 381.67894861862;
        ["y"] = -270.56288281001;
        ["g"] = 7;
        ["sublevel"] = 2;
        ["scale"] = 2.7;
      };
      [5] = {
        ["x"] = 378.52924459299;
        ["y"] = -294.66081125335;
        ["g"] = 7;
        ["sublevel"] = 2;
        ["scale"] = 2.7;
      };
      [6] = {
        ["x"] = 264.04318807906;
        ["y"] = -279.60111483922;
        ["g"] = 8;
        ["sublevel"] = 2;
        ["scale"] = 2.7;
      };
      [7] = {
        ["x"] = 266.89316163205;
        ["y"] = -298.96352590458;
        ["g"] = 8;
        ["sublevel"] = 2;
        ["scale"] = 2.7;
      };
      [8] = {
        ["x"] = 150.4168255993;
        ["y"] = -273.04796898586;
        ["g"] = 9;
        ["sublevel"] = 2;
        ["scale"] = 2.7;
      };
    };
  };
  [8] = {
    ["name"] = "Grom'kar Gunner";
    ["id"] = 80937;
    ["count"] = 6;
    ["health"] = 191745;
    ["scale"] = 1;
    ["displayId"] = 55280;
    ["creatureType"] = "Humanoid";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["x"] = 570.891672321;
        ["y"] = -284.40740050289;
        ["g"] = 6;
        ["sublevel"] = 2;
        ["scale"] = 2.7;
      };
      [2] = {
        ["x"] = 249.50825580208;
        ["y"] = -307.22007019028;
        ["g"] = 8;
        ["sublevel"] = 2;
        ["scale"] = 2.7;
      };
      [3] = {
        ["x"] = 233.66259688399;
        ["y"] = -290.2252486447;
        ["g"] = 8;
        ["sublevel"] = 2;
        ["scale"] = 2.7;
      };
      [4] = {
        ["x"] = 79.95876407978;
        ["y"] = -289.02480937675;
        ["g"] = 10;
        ["sublevel"] = 2;
        ["scale"] = 2.7;
      };
    };
  };
  [9] = {
    ["name"] = "Grom'kar Grenadier";
    ["id"] = 80936;
    ["count"] = 7;
    ["health"] = 223703;
    ["scale"] = 1;
    ["displayId"] = 55306;
    ["creatureType"] = "Humanoid";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["x"] = 358.19866057905;
        ["y"] = -273.1110804828;
        ["g"] = 7;
        ["sublevel"] = 2;
        ["scale"] = 2.7;
      };
      [2] = {
        ["x"] = 245.61296365737;
        ["y"] = -269.32210382587;
        ["g"] = 8;
        ["sublevel"] = 2;
        ["scale"] = 2.7;
      };
      [3] = {
        ["x"] = 86.554319635335;
        ["y"] = -266.43675270651;
        ["g"] = 10;
        ["sublevel"] = 2;
        ["scale"] = 2.7;
      };
    };
  };
  [10] = {
    ["name"] = "Grom'kar Cinderseer";
    ["id"] = 88163;
    ["count"] = 8;
    ["health"] = 202398;
    ["scale"] = 1;
    ["displayId"] = 60769;
    ["creatureType"] = "Humanoid";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["x"] = 356.44118274866;
        ["y"] = -297.32269122973;
        ["g"] = 7;
        ["sublevel"] = 2;
        ["scale"] = 2.7;
      };
      [2] = {
        ["x"] = 152.17753894289;
        ["y"] = -287.44339549667;
        ["g"] = 9;
        ["sublevel"] = 2;
        ["scale"] = 2.7;
      };
      [3] = {
        ["x"] = 104.1593905764;
        ["y"] = -294.38142374666;
        ["g"] = 10;
        ["sublevel"] = 2;
        ["scale"] = 2.7;
      };
      [4] = {
        ["x"] = 104.30023397221;
        ["y"] = -277.62440450507;
        ["g"] = 10;
        ["sublevel"] = 2;
        ["scale"] = 2.7;
      };
    };
  };
  [11] = {
    ["name"] = "Grom'kar Boomer";
    ["id"] = 80935;
    ["count"] = 7;
    ["health"] = 202398;
    ["scale"] = 1;
    ["displayId"] = 55281;
    ["creatureType"] = "Humanoid";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["x"] = 160.18596972327;
        ["y"] = -306.45854067875;
        ["g"] = 9;
        ["sublevel"] = 2;
        ["scale"] = 2.7;
      };
      [2] = {
        ["x"] = 172.8150014067;
        ["y"] = -270.17934021496;
        ["g"] = 9;
        ["sublevel"] = 2;
        ["scale"] = 2.7;
      };
      [3] = {
        ["x"] = 87.305086039845;
        ["y"] = -307.51743418586;
        ["g"] = 10;
        ["sublevel"] = 2;
        ["scale"] = 2.7;
      };
    };
  };
  [12] = {
    ["name"] = "Grom'kar Hulk";
    ["id"] = 80938;
    ["count"] = 18;
    ["health"] = 426100;
    ["scale"] = 1;
    ["displayId"] = 58663;
    ["creatureType"] = "Humanoid";
    ["level"] = 61;
    ["clones"] = {
      [1] = {
        ["x"] = 180.85865741192;
        ["y"] = -293.93204159013;
        ["g"] = 9;
        ["sublevel"] = 2;
        ["scale"] = 3.6;
      };
    };
  };
  [13] = {
    ["name"] = "Nitrogg Thundertower";
    ["id"] = 79545;
    ["count"] = 0;
    ["health"] = 1938755;
    ["scale"] = 1;
    ["displayId"] = 55162;
    ["creatureType"] = "Humanoid";
    ["level"] = 62;
    ["isBoss"] = true;
    ["encounterID"] = 1163;
    ["instanceID"] = 536;
    ["clones"] = {
      [1] = {
        ["x"] = 532.16581109577;
        ["y"] = -287.47721830965;
        ["sublevel"] = 3;
        ["scale"] = 2.4;
      };
    };
  };
  [14] = {
    ["name"] = "Grom'kar Far Seer";
    ["id"] = 82579;
    ["count"] = 12;
    ["health"] = 340880;
    ["scale"] = 1;
    ["displayId"] = 57126;
    ["creatureType"] = "Humanoid";
    ["level"] = 61;
    ["clones"] = {
      [1] = {
        ["x"] = 245.18982839375;
        ["y"] = -316.22851753379;
        ["sublevel"] = 3;
        ["scale"] = 2.4;
      };
      [2] = {
        ["x"] = 179.6174263598;
        ["y"] = -300.6054758476;
        ["g"] = 16;
        ["sublevel"] = 3;
        ["scale"] = 2.4;
      };
      [3] = {
        ["x"] = 208.34849242049;
        ["y"] = -274.74766410554;
        ["g"] = 16;
        ["sublevel"] = 3;
        ["scale"] = 2.4;
      };
    };
  };
  [15] = {
    ["name"] = "Grimrail Loader";
    ["id"] = 82594;
    ["count"] = 1;
    ["health"] = 85220;
    ["scale"] = 1;
    ["displayId"] = 55909;
    ["creatureType"] = "Humanoid";
    ["level"] = 60;
    ["clones"] = {
      [1] = {
        ["x"] = 215.75960288305;
        ["y"] = -289.60780742598;
        ["g"] = 16;
        ["sublevel"] = 3;
        ["scale"] = 1.4;
      };
      [2] = {
        ["x"] = 194.72561201769;
        ["y"] = -265.28758196852;
        ["g"] = 16;
        ["sublevel"] = 3;
        ["scale"] = 1.4;
      };
      [3] = {
        ["x"] = 191.25790274364;
        ["y"] = -276.87364212014;
        ["g"] = 16;
        ["sublevel"] = 3;
        ["scale"] = 1.4;
      };
      [4] = {
        ["x"] = 185.34658706823;
        ["y"] = -285.51763309872;
        ["g"] = 16;
        ["sublevel"] = 3;
        ["scale"] = 1.4;
      };
      [5] = {
        ["x"] = 206.92759977971;
        ["y"] = -310.14358308813;
        ["g"] = 16;
        ["sublevel"] = 3;
        ["scale"] = 1.4;
      };
      [6] = {
        ["x"] = 214.31096354115;
        ["y"] = -301.36754474086;
        ["g"] = 16;
        ["sublevel"] = 3;
        ["scale"] = 1.4;
      };
      [7] = {
        ["x"] = 84.56389194197;
        ["y"] = -284.95501482362;
        ["g"] = 17;
        ["sublevel"] = 3;
        ["scale"] = 1.4;
      };
      [8] = {
        ["x"] = 95.043039863345;
        ["y"] = -288.44211081836;
        ["g"] = 17;
        ["sublevel"] = 3;
        ["scale"] = 1.4;
      };
      [9] = {
        ["x"] = 85.969184800693;
        ["y"] = -297.73614697753;
        ["g"] = 17;
        ["sublevel"] = 3;
        ["scale"] = 1.4;
      };
    };
  };
  [16] = {
    ["name"] = "Grimrail Scout";
    ["id"] = 82590;
    ["count"] = 12;
    ["health"] = 276965;
    ["scale"] = 1;
    ["displayId"] = 57131;
    ["creatureType"] = "Humanoid";
    ["level"] = 61;
    ["clones"] = {
      [1] = {
        ["x"] = 199.70326586019;
        ["y"] = -293.34662858309;
        ["g"] = 16;
        ["sublevel"] = 3;
        ["scale"] = 2.4;
      };
    };
  };
  [17] = {
    ["name"] = "Grom'kar Captain";
    ["id"] = 82597;
    ["count"] = 18;
    ["health"] = 426100;
    ["scale"] = 1;
    ["displayId"] = 57133;
    ["creatureType"] = "Humanoid";
    ["level"] = 61;
    ["clones"] = {
      [1] = {
        ["x"] = 191.2587246072;
        ["y"] = -317.24194963818;
        ["g"] = 16;
        ["sublevel"] = 3;
        ["scale"] = 2.8;
      };
    };
  };
  [18] = {
    ["name"] = "Skylord Tovra";
    ["id"] = 80005;
    ["count"] = 0;
    ["health"] = 2215720;
    ["scale"] = 1;
    ["displayId"] = 55630;
    ["creatureType"] = "Humanoid";
    ["level"] = 62;
    ["isBoss"] = true;
    ["encounterID"] = 1133;
    ["instanceID"] = 536;
    ["clones"] = {
      [1] = {
        ["x"] = 141.71974714776;
        ["y"] = -287.33103430912;
        ["sublevel"] = 3;
        ["scale"] = 2.4;
      };
    };
  };
  [19] = {
    ["name"] = "Nathrezim Infiltrator";
    ["id"] = 189878;
    ["count"] = 0;
    ["health"] = 999999;
    ["scale"] = 1.2;
    ["displayId"] = 101016;
    ["creatureType"] = "Demon";
    ["level"] = 61;
    ["characteristics"] = {
      ["Taunt"] = true;
    };
    ["spells"] = {
      [373364] = {
      };
      [373370] = {
      };
      [373391] = {
      };
      [373429] = {
      };
    };
    ["clones"] = {
      [1] = {
        ["x"] = 216.8243412798;
        ["y"] = -360.25353107345;
        ["sublevel"] = 1;
        ["scale"] = 2.2;
        ["shrouded"] = true;
      };
      [2] = {
        ["x"] = 369.9543758357;
        ["y"] = -352.44420242342;
        ["g"] = 2;
        ["sublevel"] = 1;
        ["scale"] = 2.2;
        ["shrouded"] = true;
      };
      [3] = {
        ["x"] = 446.37515683814;
        ["y"] = -261.16878531073;
        ["g"] = 4;
        ["sublevel"] = 1;
        ["scale"] = 2.2;
        ["shrouded"] = true;
      };
      [4] = {
        ["x"] = 572.49834000185;
        ["y"] = -93.180529200005;
        ["sublevel"] = 1;
        ["scale"] = 2.2;
        ["shrouded"] = true;
      };
    };
  };
  [20] = {
    ["name"] = "Zul'gamux";
    ["id"] = 190128;
    ["count"] = 0;
    ["health"] = 999999;
    ["scale"] = 1.8;
    ["displayId"] = 101106;
    ["creatureType"] = "Demon";
    ["level"] = 61;
    ["characteristics"] = {
      ["Taunt"] = true;
    };
    ["spells"] = {
      [373509] = {
      };
      [373513] = {
      };
      [373552] = {
      };
      [373570] = {
      };
      [373607] = {
      };
      [373724] = {
      };
    };
    ["clones"] = {
      [1] = {
        ["x"] = 588.75980963218;
        ["y"] = -134.88837528754;
        ["sublevel"] = 1;
        ["scale"] = 2;
        ["shrouded"] = true;
      };
    };
  };
};
