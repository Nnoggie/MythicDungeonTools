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
  }
};

MDT.dungeonMaps[dungeonIndex] = {
  [0] = "BlackrockTrainDepotDungeon",
  [1] = "BlackrockTrainDepotDungeon1_",
  [2] = "BlackrockTrainDepotDungeon2_",
  [3] = "BlackrockTrainDepotDungeon3_",
  [4] = "BlackrockTrainDepotDungeon4_",
}
MDT.dungeonSubLevels[dungeonIndex] = {
  [1] = L["Train Depot"],
  [2] = L["Rafters"],
  [3] = L["Rear Train Cars"],
  [4] = L["Forward Train Cars"],
}

MDT.dungeonTotalCount[dungeonIndex] = { normal = 300, teeming = 1000, teemingEnabled = true }

MDT.mapPOIs[dungeonIndex] = {
  [1] = {
    [1] = {
      ["template"] = "MapLinkPinTemplate";
      ["type"] = "mapLink";
      ["x"] = 608.1555672928;
      ["y"] = -146.89221596194;
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
      ["x"] = 575.32466428391;
      ["y"] = -141.61582922212;
      ["target"] = 1;
      ["direction"] = -1;
      ["connectionIndex"] = 1;
    };
    [2] = {
      ["template"] = "MapLinkPinTemplate";
      ["type"] = "mapLink";
      ["x"] = 589.39491710193;
      ["y"] = -419.50622414568;
      ["target"] = 3;
      ["direction"] = 2;
      ["connectionIndex"] = 2;
    };
  };
  [3] = {
    [1] = {
      ["template"] = "MapLinkPinTemplate";
      ["type"] = "mapLink";
      ["x"] = 752.81400720267;
      ["y"] = -289.68656596226;
      ["target"] = 2;
      ["direction"] = 1;
      ["connectionIndex"] = 2;
    };
    [2] = {
      ["template"] = "MapLinkPinTemplate";
      ["type"] = "mapLink";
      ["x"] = 61.660226201996;
      ["y"] = -289.10965170246;
      ["target"] = 4;
      ["direction"] = -2;
      ["connectionIndex"] = 3;
    };
  };
  [4] = {
    [1] = {
      ["template"] = "MapLinkPinTemplate";
      ["type"] = "mapLink";
      ["x"] = 779.35252531897;
      ["y"] = -287.37894193484;
      ["target"] = 3;
      ["direction"] = 2;
      ["connectionIndex"] = 3;
    };
  };
};

MDT.dungeonEnemies[dungeonIndex] = {
  [1] = {
    ["clones"] = {
      [1] = {
        ["x"] = 282.2484316185698;
        ["y"] = -315.5451977401129;
        ["sublevel"] = 1;
        ["g"] = 1;
      };
      [2] = {
        ["x"] = 216.82434127979965;
        ["y"] = -360.2535310734465;
        ["sublevel"] = 1;
        ["g"] = 1;
      };
      [3] = {
        ["x"] = 378.2634880803014;
        ["y"] = -335.0120056497175;
        ["sublevel"] = 1;
        ["g"] = 2;
      };
      [4] = {
        ["x"] = 370.095357590966;
        ["y"] = -344.73234463276845;
        ["sublevel"] = 1;
        ["g"] = 2;
      };
      [5] = {
        ["x"] = 577.4077791718946;
        ["y"] = -101.27966101694908;
        ["sublevel"] = 1;
      };
    };
    ["name"] = "Grimrail Laborer";
    ["id"] = 81235;
    ["health"] = 213050;
    ["level"] = 60;
    ["count"] = 2;
    ["displayId"] = 55909;
    ["creatureType"] = "Humanoid";
    ["scale"] = 1;
  };
  [2] = {
    ["clones"] = {
      [1] = {
        ["x"] = 266.6762860727729;
        ["y"] = -286.4364406779663;
        ["sublevel"] = 1;
        ["g"] = 1;
      };
      [2] = {
        ["x"] = 422.9510664993723;
        ["y"] = -328.035310734463;
        ["sublevel"] = 1;
        ["g"] = 3;
      };
      [3] = {
        ["x"] = 427.0614805520704;
        ["y"] = -317.4526836158191;
        ["sublevel"] = 1;
        ["g"] = 3;
      };
      [4] = {
        ["x"] = 345.6700125470514;
        ["y"] = -312.2005649717513;
        ["sublevel"] = 1;
      };
      [5] = {
        ["x"] = 390.5947302383938;
        ["y"] = -262.4752824858757;
        ["sublevel"] = 1;
      };
    };
    ["name"] = "Grimrail Overseer";
    ["id"] = 81212;
    ["health"] = 340880;
    ["level"] = 61;
    ["count"] = 7;
    ["displayId"] = 56280;
    ["creatureType"] = "Humanoid";
    ["scale"] = 1;
  };
  [3] = {
    ["clones"] = {
      [1] = {
        ["x"] = 254.26599749058954;
        ["y"] = -286.80225988700556;
        ["sublevel"] = 1;
        ["g"] = 1;
      };
      [2] = {
        ["x"] = 351.86198243412827;
        ["y"] = -333.1045197740112;
        ["sublevel"] = 1;
        ["g"] = 2;
      };
      [3] = {
        ["x"] = 451.5395232120452;
        ["y"] = -249.1490112994353;
        ["sublevel"] = 1;
        ["g"] = 4;
      };
      [4] = {
        ["x"] = 446.37515683814297;
        ["y"] = -261.1687853107345;
        ["sublevel"] = 1;
        ["g"] = 4;
      };
    };
    ["name"] = "Grimrail Technician";
    ["id"] = 81236;
    ["health"] = 213050;
    ["level"] = 60;
    ["count"] = 4;
    ["displayId"] = 56293;
    ["creatureType"] = "Humanoid";
    ["scale"] = 1;
  };
  [4] = {
    ["clones"] = {
      [1] = {
        ["x"] = 624.0451693851945;
        ["y"] = -318.3933615819211;
        ["sublevel"] = 1;
        ["g"] = 5;
      };
    };
    ["name"] = "Railmaster Rocketspark";
    ["id"] = 77803;
    ["health"] = 1218646;
    ["level"] = 62;
    ["count"] = 0;
    ["displayId"] = 54096;
    ["creatureType"] = "Humanoid";
    ["scale"] = 1;
  };
  [5] = {
    ["clones"] = {
      [1] = {
        ["x"] = 605.6273525721455;
        ["y"] = -341.3615819209041;
        ["sublevel"] = 1;
        ["g"] = 5;
      };
    };
    ["name"] = "Borka the Brute";
    ["id"] = 77816;
    ["health"] = 1467914;
    ["level"] = 62;
    ["count"] = 0;
    ["displayId"] = 60108;
    ["creatureType"] = "Humanoid";
    ["scale"] = 1;
  };
  [6] = {
    ["clones"] = {
      [1] = {
        ["x"] = 587.0777917189462;
        ["y"] = -113.79590395480211;
        ["sublevel"] = 1;
      };
      [2] = {
        ["x"] = 545.8946047678794;
        ["y"] = -144.49858757062128;
        ["sublevel"] = 2;
      };
      [3] = {
        ["x"] = 591.7415307402762;
        ["y"] = -157.04096045197772;
        ["sublevel"] = 2;
      };
    };
    ["name"] = "Grimrail Bombardier";
    ["id"] = 81407;
    ["health"] = 351533;
    ["level"] = 61;
    ["count"] = 12;
    ["displayId"] = 59182;
    ["creatureType"] = "Humanoid";
    ["scale"] = 1;
  };
  [7] = {
    ["clones"] = {
      [1] = {
        ["x"] = 574.373333333333;
        ["y"] = -296.61666666666684;
        ["sublevel"] = 3;
        ["g"] = 6;
      };
      [2] = {
        ["x"] = 572.8800000000003;
        ["y"] = -279.8433333333333;
        ["sublevel"] = 3;
        ["g"] = 6;
      };
      [3] = {
        ["x"] = 583.4888888888888;
        ["y"] = -297.7266666666665;
        ["sublevel"] = 3;
        ["g"] = 6;
      };
      [4] = {
        ["x"] = 350.5911111111113;
        ["y"] = -276.08166666666654;
        ["sublevel"] = 3;
        ["g"] = 7;
      };
      [5] = {
        ["x"] = 346.45333333333303;
        ["y"] = -279.99749999999983;
        ["sublevel"] = 3;
        ["g"] = 7;
      };
      [6] = {
        ["x"] = 244.50222222222197;
        ["y"] = -278.8566666666668;
        ["sublevel"] = 3;
        ["g"] = 8;
      };
      [7] = {
        ["x"] = 243.9111111111114;
        ["y"] = -289.71000000000015;
        ["sublevel"] = 3;
        ["g"] = 8;
      };
      [8] = {
        ["x"] = 154.49777777777805;
        ["y"] = -279.53500000000025;
        ["sublevel"] = 3;
        ["g"] = 9;
      };
    };
    ["name"] = "Iron Infantry";
    ["id"] = 80940;
    ["health"] = 213050;
    ["level"] = 60;
    ["count"] = 3;
    ["displayId"] = 55374;
    ["creatureType"] = "Humanoid";
    ["scale"] = 1;
  };
  [8] = {
    ["clones"] = {
      [1] = {
        ["x"] = 569.7377777777781;
        ["y"] = -288.4458333333332;
        ["sublevel"] = 3;
        ["g"] = 6;
      };
      [2] = {
        ["x"] = 239.21333333333362;
        ["y"] = -290.7583333333332;
        ["sublevel"] = 3;
        ["g"] = 8;
      };
      [3] = {
        ["x"] = 229.38222222222228;
        ["y"] = -296.92499999999984;
        ["sublevel"] = 3;
        ["g"] = 8;
      };
      [4] = {
        ["x"] = 89.84888888888923;
        ["y"] = -287.5824999999999;
        ["sublevel"] = 3;
        ["g"] = 10;
      };
    };
    ["name"] = "Grom'kar Gunner";
    ["id"] = 80937;
    ["health"] = 191745;
    ["level"] = 60;
    ["count"] = 6;
    ["displayId"] = 55280;
    ["creatureType"] = "Humanoid";
    ["scale"] = 1;
  };
  [9] = {
    ["clones"] = {
      [1] = {
        ["x"] = 335.7511111111113;
        ["y"] = -275.55749999999966;
        ["sublevel"] = 3;
        ["g"] = 7;
      };
      [2] = {
        ["x"] = 221.97777777777748;
        ["y"] = -296.49333333333357;
        ["sublevel"] = 3;
        ["g"] = 8;
      };
      [3] = {
        ["x"] = 96.44444444444444;
        ["y"] = -276.9449999999998;
        ["sublevel"] = 3;
        ["g"] = 10;
      };
    };
    ["name"] = "Grom'kar Grenadier";
    ["id"] = 80936;
    ["health"] = 223703;
    ["level"] = 60;
    ["count"] = 7;
    ["displayId"] = 55306;
    ["creatureType"] = "Humanoid";
    ["scale"] = 1;
  };
  [10] = {
    ["clones"] = {
      [1] = {
        ["x"] = 340.10666666666646;
        ["y"] = -282.34083333333314;
        ["sublevel"] = 3;
        ["g"] = 7;
      };
      [2] = {
        ["x"] = 171.76444444444456;
        ["y"] = -296.30833333333305;
        ["sublevel"] = 3;
        ["g"] = 9;
      };
      [3] = {
        ["x"] = 102.51111111111125;
        ["y"] = -279.1341666666666;
        ["sublevel"] = 3;
        ["g"] = 10;
      };
      [4] = {
        ["x"] = 105.12444444444432;
        ["y"] = -294.52;
        ["sublevel"] = 3;
        ["g"] = 10;
      };
    };
    ["name"] = "Grom'kar Cinderseer";
    ["id"] = 88163;
    ["health"] = 202398;
    ["level"] = 60;
    ["count"] = 8;
    ["displayId"] = 60769;
    ["creatureType"] = "Humanoid";
    ["scale"] = 1;
  };
  [11] = {
    ["clones"] = {
      [1] = {
        ["x"] = 162.89777777777746;
        ["y"] = -300.9949999999996;
        ["sublevel"] = 3;
        ["g"] = 9;
      };
      [2] = {
        ["x"] = 170.02222222222252;
        ["y"] = -278.91833333333346;
        ["sublevel"] = 3;
        ["g"] = 9;
      };
      [3] = {
        ["x"] = 97.8133333333335;
        ["y"] = -296.1849999999998;
        ["sublevel"] = 3;
        ["g"] = 10;
      };
    };
    ["name"] = "Grom'kar Boomer";
    ["id"] = 80935;
    ["health"] = 202398;
    ["level"] = 60;
    ["count"] = 7;
    ["displayId"] = 55281;
    ["creatureType"] = "Humanoid";
    ["scale"] = 1;
  };
  [12] = {
    ["clones"] = {
      [1] = {
        ["x"] = 162.4622222222223;
        ["y"] = -289.7408333333334;
        ["sublevel"] = 3;
        ["g"] = 9;
      };
    };
    ["name"] = "Grom'kar Hulk";
    ["id"] = 80938;
    ["health"] = 426100;
    ["level"] = 61;
    ["count"] = 18;
    ["displayId"] = 58663;
    ["creatureType"] = "Humanoid";
    ["scale"] = 1;
  };
  [13] = {
    ["clones"] = {
      [1] = {
        ["x"] = 730.7715254237291;
        ["y"] = -286.25127161749725;
        ["sublevel"] = 4;
      };
    };
    ["isBoss"] = true;
    ["encounterID"] = 1163;
    ["instanceID"] = 536;
    ["name"] = "Nitrogg Thundertower";
    ["id"] = 79545;
    ["health"] = 1938755;
    ["level"] = 62;
    ["count"] = 0;
    ["displayId"] = 55162;
    ["creatureType"] = "Humanoid";
    ["scale"] = 1;
  };
  [14] = {
    ["clones"] = {
      [1] = {
        ["x"] = 551.2677966101692;
        ["y"] = -286.4206510681589;
        ["sublevel"] = 4;
        ["g"] = 11;
      };
    };
    ["name"] = "Assault Cannon";
    ["id"] = 79548;
    ["health"] = 2215720;
    ["level"] = 62;
    ["count"] = 0;
    ["displayId"] = 55161;
    ["creatureType"] = "Mechanical";
    ["scale"] = 1;
  };
  [15] = {
    ["clones"] = {
      [1] = {
        ["x"] = 602.4366101694914;
        ["y"] = -334.8067141403864;
        ["sublevel"] = 4;
        ["g"] = 11;
      };
      [2] = {
        ["x"] = 612.0325423728815;
        ["y"] = -272.50330620549346;
        ["sublevel"] = 4;
        ["g"] = 13;
      };
      [3] = {
        ["x"] = 613.1145762711863;
        ["y"] = -282.92014242115994;
        ["sublevel"] = 4;
        ["g"] = 13;
      };
    };
    ["name"] = "Grom'kar Boomer";
    ["id"] = 79720;
    ["health"] = 106525;
    ["level"] = 61;
    ["count"] = 0;
    ["displayId"] = 55281;
    ["creatureType"] = "Humanoid";
    ["scale"] = 1;
  };
  [16] = {
    ["clones"] = {
      [1] = {
        ["x"] = 597.9945762711864;
        ["y"] = -340.0574771108853;
        ["sublevel"] = 4;
        ["g"] = 11;
      };
      [2] = {
        ["x"] = 600.4433898305082;
        ["y"] = -346.8891149542216;
        ["sublevel"] = 4;
        ["g"] = 12;
      };
      [3] = {
        ["x"] = 605.3410169491524;
        ["y"] = -297.65615462868794;
        ["sublevel"] = 4;
        ["g"] = 15;
      };
      [4] = {
        ["x"] = 603.9742372881353;
        ["y"] = -297.5714649033568;
        ["sublevel"] = 4;
        ["g"] = 15;
      };
    };
    ["name"] = "Grom'kar Gunner";
    ["id"] = 77483;
    ["health"] = 127830;
    ["level"] = 61;
    ["count"] = 0;
    ["displayId"] = 55280;
    ["creatureType"] = "Humanoid";
    ["scale"] = 1;
  };
  [17] = {
    ["clones"] = {
      [1] = {
        ["x"] = 599.8169491525426;
        ["y"] = -339.8034079348931;
        ["sublevel"] = 4;
        ["g"] = 11;
      };
      [2] = {
        ["x"] = 597.738305084746;
        ["y"] = -336.16174974567645;
        ["sublevel"] = 4;
        ["g"] = 11;
      };
      [3] = {
        ["x"] = 577.9484745762713;
        ["y"] = -322.44201424211616;
        ["sublevel"] = 4;
        ["g"] = 11;
      };
      [4] = {
        ["x"] = 596.0013559322032;
        ["y"] = -310.47253306205516;
        ["sublevel"] = 4;
        ["g"] = 12;
      };
      [5] = {
        ["x"] = 600.6142372881358;
        ["y"] = -308.2706002034591;
        ["sublevel"] = 4;
        ["g"] = 12;
      };
      [6] = {
        ["x"] = 599.5037288135592;
        ["y"] = -310.5854526958292;
        ["sublevel"] = 4;
        ["g"] = 12;
      };
      [7] = {
        ["x"] = 572.6806779661014;
        ["y"] = -343.72736520854545;
        ["sublevel"] = 4;
        ["g"] = 12;
      };
      [8] = {
        ["x"] = 593.7233898305084;
        ["y"] = -316.17497456765017;
        ["sublevel"] = 4;
        ["g"] = 12;
      };
      [9] = {
        ["x"] = 610.0677966101696;
        ["y"] = -313.69074262461834;
        ["sublevel"] = 4;
        ["g"] = 13;
      };
      [10] = {
        ["x"] = 603.746440677966;
        ["y"] = -318.94150559511723;
        ["sublevel"] = 4;
        ["g"] = 13;
      };
      [11] = {
        ["x"] = 639.3681355932202;
        ["y"] = -324.2487283825024;
        ["sublevel"] = 4;
        ["g"] = 13;
      };
      [12] = {
        ["x"] = 606.9640677966104;
        ["y"] = -337.82731434384505;
        ["sublevel"] = 4;
        ["g"] = 14;
      };
      [13] = {
        ["x"] = 613.313898305085;
        ["y"] = -330.4593082400814;
        ["sublevel"] = 4;
        ["g"] = 14;
      };
      [14] = {
        ["x"] = 609.6122033898303;
        ["y"] = -330.2334689725332;
        ["sublevel"] = 4;
        ["g"] = 14;
      };
      [15] = {
        ["x"] = 604.743050847458;
        ["y"] = -327.4669379450663;
        ["sublevel"] = 4;
        ["g"] = 15;
      };
      [16] = {
        ["x"] = 611.1213559322031;
        ["y"] = -325.6037639877924;
        ["sublevel"] = 4;
        ["g"] = 15;
      };
    };
    ["name"] = "Iron Infantry";
    ["id"] = 79888;
    ["health"] = 42610;
    ["level"] = 60;
    ["count"] = 0;
    ["displayId"] = 55374;
    ["creatureType"] = "Humanoid";
    ["scale"] = 1;
  };
  [18] = {
    ["clones"] = {
      [1] = {
        ["x"] = 601.9525423728817;
        ["y"] = -292.8853001017295;
        ["sublevel"] = 4;
        ["g"] = 12;
      };
    };
    ["name"] = "Grom'kar Grenadier";
    ["id"] = 79739;
    ["health"] = 95873;
    ["level"] = 62;
    ["count"] = 0;
    ["displayId"] = 55306;
    ["creatureType"] = "Humanoid";
    ["scale"] = 1;
  };
  [19] = {
    ["clones"] = {
      [1] = {
        ["x"] = 234.82983050847463;
        ["y"] = -303.52797558494416;
        ["sublevel"] = 4;
      };
      [2] = {
        ["x"] = 171.81559322033874;
        ["y"] = -295.0590030518821;
        ["sublevel"] = 4;
        ["g"] = 16;
      };
      [3] = {
        ["x"] = 208.3484745762714;
        ["y"] = -284.7268565615462;
        ["sublevel"] = 4;
        ["g"] = 16;
      };
    };
    ["name"] = "Grom'kar Far Seer";
    ["id"] = 82579;
    ["health"] = 340880;
    ["level"] = 61;
    ["count"] = 12;
    ["displayId"] = 57126;
    ["creatureType"] = "Humanoid";
    ["scale"] = 1;
  };
  [20] = {
    ["clones"] = {
      [1] = {
        ["x"] = 200.26169491525403;
        ["y"] = -290.6269074262464;
        ["sublevel"] = 4;
        ["g"] = 16;
      };
      [2] = {
        ["x"] = 202.99525423728804;
        ["y"] = -278.71388606307244;
        ["sublevel"] = 4;
        ["g"] = 16;
      };
      [3] = {
        ["x"] = 178.93423728813536;
        ["y"] = -278.12105798575794;
        ["sublevel"] = 4;
        ["g"] = 16;
      };
      [4] = {
        ["x"] = 164.9816949152544;
        ["y"] = -276.9918616480161;
        ["sublevel"] = 4;
        ["g"] = 16;
      };
      [5] = {
        ["x"] = 174.34983050847464;
        ["y"] = -300.95905391658175;
        ["sublevel"] = 4;
        ["g"] = 16;
      };
      [6] = {
        ["x"] = 177.45355932203373;
        ["y"] = -292.7159206510685;
        ["sublevel"] = 4;
        ["g"] = 16;
      };
      [7] = {
        ["x"] = 91.63118644067815;
        ["y"] = -279.56078331637843;
        ["sublevel"] = 4;
        ["g"] = 17;
      };
      [8] = {
        ["x"] = 104.27389830508443;
        ["y"] = -282.355544252289;
        ["sublevel"] = 4;
        ["g"] = 17;
      };
      [9] = {
        ["x"] = 92.94101694915283;
        ["y"] = -297.8537639877926;
        ["sublevel"] = 4;
        ["g"] = 17;
      };
    };
    ["name"] = "Grimrail Loader";
    ["id"] = 82594;
    ["health"] = 85220;
    ["level"] = 60;
    ["count"] = 1;
    ["displayId"] = 55909;
    ["creatureType"] = "Humanoid";
    ["scale"] = 1;
  };
  [21] = {
    ["clones"] = {
      [1] = {
        ["x"] = 187.8752542372882;
        ["y"] = -280.60528992878915;
        ["sublevel"] = 4;
        ["g"] = 16;
      };
    };
    ["name"] = "Grimrail Scout";
    ["id"] = 82590;
    ["health"] = 276965;
    ["level"] = 61;
    ["count"] = 12;
    ["displayId"] = 57131;
    ["creatureType"] = "Humanoid";
    ["scale"] = 1;
  };
  [22] = {
    ["clones"] = {
      [1] = {
        ["x"] = 167.94305084745767;
        ["y"] = -309.3997965412003;
        ["sublevel"] = 4;
        ["g"] = 16;
      };
    };
    ["name"] = "Grom'kar Captain";
    ["id"] = 82597;
    ["health"] = 426100;
    ["level"] = 61;
    ["count"] = 18;
    ["displayId"] = 57133;
    ["creatureType"] = "Humanoid";
    ["scale"] = 1;
  };
  [23] = {
    ["clones"] = {
      [1] = {
        ["x"] = 130.52745762711842;
        ["y"] = -284.3598677517804;
        ["sublevel"] = 4;
      };
    };
    ["isBoss"] = true;
    ["encounterID"] = 1133;
    ["instanceID"] = 536;
    ["name"] = "Skylord Tovra";
    ["id"] = 80005;
    ["health"] = 2215720;
    ["level"] = 62;
    ["count"] = 0;
    ["displayId"] = 55630;
    ["creatureType"] = "Humanoid";
    ["scale"] = 1;
  };
};

L["Grom'kar Gunner"] = "Grom'kar Gunner"
L["Grimrail Laborer"] = "Grimrail Laborer"
L["Grom'kar Far Seer"] = "Grom'kar Far Seer"
L["Grom'kar Boomer"] = "Grom'kar Boomer"
L["Skylord Tovra"] = "Skylord Tovra"
L["Assault Cannon"] = "Assault Cannon"
L["Grimrail Loader"] = "Grimrail Loader"
L["Grimrail Technician"] = "Grimrail Technician"
L["Iron Infantry"] = "Iron Infantry"
L["Grom'kar Grenadier"] = "Grom'kar Grenadier"
L["Grimrail Overseer"] = "Grimrail Overseer"
L["Borka the Brute"] = "Borka the Brute"
L["Grimrail Scout"] = "Grimrail Scout"
L["Grom'kar Cinderseer"] = "Grom'kar Cinderseer"
L["Grimrail Bombardier"] = "Grimrail Bombardier"
L["Grom'kar Hulk"] = "Grom'kar Hulk"
L["Railmaster Rocketspark"] = "Railmaster Rocketspark"
L["Nitrogg Thundertower"] = "Nitrogg Thundertower"
L["Grom'kar Captain"] = "Grom'kar Captain"
