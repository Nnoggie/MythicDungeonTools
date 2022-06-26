import time
import pandas as pd
import numpy as np
import pyperclip
from collections import OrderedDict
from get_wowtools_data import *

request_wowtools = True
# How to use:
# 1. Have Advanced Combat Logging Enabled!
# 2. Delete the following files from the directory wowdb_files
#       uimapassignment.csv, map.csv, criteria.csv, criteriatree.csv, journalencounter.csv
# 2. Delete or rename your current WoWCombatLog.txt file to start from fresh
# 3. Run the dungeon on +2 with inspiring tagging all mobs where they spawn.
# 4. Copy the resulting WoWCombatLog.txt file to the directory of this file
# 5. Run this script
# 6. Open the .lua file for the given dungeon and paste what has been added to your clipboard


# Importing files from wow.tools; If the file is available in the directory it is read otherwise it is downloaded first
#   uimapassignment: contains information about the extent of a UiMapID on its base minimap file.
#       Which means it contains minimap coordinate points for the borders of the in-game map
#   map: contains UiMapIDs and their associated dungeons
#   criteria: contains information about which criteria a given npc triggers when dying in a mythic dungeon
#   criteriatree: contains information about which criteria from the above list is triggered when count is
#        attributed in a mythic dungeon as well as the amount of count attributed
#   journalencounter: contains the encounterID and instanceID for bosses which MDT stores


def get_map_extent(UiMapID):
    """Returns map extent in minimap coordinates xmin, xmax, ymin, ymax.

    Args:
        UiMapID (int): UiMapID for a given dungeon map level

    Returns:
        dataframe row: Map extent for the given UiMapID

    """
    return map_extent.loc[
        map_extent.UiMapID == UiMapID, ["xmin", "xmax", "ymin", "ymax"]]


def convert_to_relative_coord(dataframe_row):
    """Converts mob position to relative position from (0,100).

    Args:
        dataframe_row (dataframe): X and Y coordinates for a mob hit in combatlog coordinates

    Returns:
        pandas series: X and Y coordinates for a mob hit in combatlog in relative coordinates

    """
    extent = get_map_extent(dataframe_row.UiMapID)
    x = float((dataframe_row.xcoord - extent.xmin) / (extent.xmax - extent.xmin))
    y = float((dataframe_row.ycoord - extent.ymin) / (extent.ymax - extent.ymin))
    return pd.Series([x, y])


def convert_to_MDT_coord(dataframe_row):
    """Converts mob position to coordinates used for the MDT map

    MDT width and height at scale = 1
    WIDTH = 840
    HEIGHT = 555
    Heigh is negative
    0,0 is top left corner

    Args:
        dataframe_row (dataframe): X and Y coordinates for a mob hit in combatlog coordinates

    Returns:
        pandas series: X and Y coordinates for a mob hit in combatlog in MDT coordinates

    """
    extent = get_map_extent(dataframe_row.UiMapID)
    # MDT width and height at scale = 1
    width = 840
    height = 555
    x = float((dataframe_row.xcoord - extent.xmin) / (extent.xmax - extent.xmin))
    y = float((dataframe_row.ycoord - extent.ymin) / (extent.ymax - extent.ymin))
    x = x * width
    y = -(1 - y) * height
    return pd.Series([x, y])


def get_npc_id(GUID):
    """Splits the GUID and extracts the npcID

    Args:
        GUID (string): Creature GUID

    Returns:
        int: NPC ID associated with GUID

    """
    return int(GUID.split("-")[5])


def get_boss_info(name):
    """Finds encounterID and instanceID associated with a boss

    Args:
        name (string): Boss name

    Returns:
        int: encounterID associated with the boss
        int: instanceID associated with the boss

    """
    boss = db["journalencounter"][db["journalencounter"].Name_lang == name]
    encounterID = int(boss.ID)
    instanceID = int(boss.JournalInstanceID)
    return encounterID, instanceID


def UiMapID_to_sublevel(UiMapID):
    """Converts UiMapId to MDT map sublevel

    Args:
        UiMapID (string): UiMapID for a given creature

    Returns:
        int: MDT map sublevel associated with that UiMapID (1 is first seen UiMapID, 2 is second etc.)

    """
    return unique_UiMapIDs.index(UiMapID) + 1


def get_count_table(ID):  # Extracts the count table for a given dungeons enemy forces criteria ID
    """Extracts the dungeon table for a dungeon

    Args:
        ID (int): dungeonID for dungeon

    Returns:
        dataframe: Count table for dungeon

    """
    dungeon_forces = db["criteriatree"][((db["criteriatree"].Parent == ID) &
                                        (db["criteriatree"].Description_lang == "Enemy Forces"))]
    enemy_forces = db["criteriatree"][db["criteriatree"].Parent == int(dungeon_forces.ID)].copy()
    enemy_forces["npcID"] = [int(db["criteria"][db["criteria"].ID == ID].Asset) for ID in enemy_forces.CriteriaID]
    count_table = enemy_forces.groupby(["npcID"]).agg(count=("Amount", "sum"))
    return count_table


def get_total_count(ID):
    """Extracts total count for a dungeon

    Args:
        ID (int): dungeonID for dungeon

    Returns:
        int: Total count needed for dungeon completion

    """
    dungeon_forces = db["criteriatree"][((db["criteriatree"].Parent == ID) &
                                        (db["criteriatree"].Description_lang == "Enemy Forces"))].Amount
    return int(dungeon_forces)


def get_dungeon_count(boss_names):
    """Find dungeon count table and total count from list of dungeon bosses

    Args:
        boss_names (list): List of names of bosses in the dungeon

    Returns:
        dataframe: Dataframe containing count information for dungeon
        int: Total count needed for dungeon completion

    """
    if not boss_names:
        return print("Error: Combat log does not contain any boss fights. A boss fight required for collecting count.")

    # Fixing Blizzard brain not naming bosses the same everywhere
    for i in range(len(boss_names)):
        parent_dungeons = db["criteriatree"][
            db["criteriatree"].Description_lang.str.startswith(boss_names[i], na=False)].Parent
        if len(parent_dungeons) == 0:
            print("Fixing Blizzard Brain.")
        else:
            print("Correct boss name found.")
            break

    mythic_regular = db["criteriatree"][(
            (db["criteriatree"].Description_lang.str.contains('Dungeon.*Challenge', na=False)) &
            (db["criteriatree"].ID.isin(parent_dungeons)) &
            ~db["criteriatree"].Description_lang.str.contains("More Trash", na=False))]  # This means NOT Teeming

    if 'Mailroom Mayhem' in boss_names:
        regular_count = get_count_table(int(94220))
        total_count = get_total_count(int(94220))
        print('Jebaited blizzard brain is perma broken')
        return regular_count, total_count

    elif 'Hyldebrande' in boss_names:
        regular_count = get_count_table(int(73619))
        total_count = get_total_count(int(73619))
        print('Jebaited blizzard brain is perma broken')
        return regular_count, total_count

    regular_count = get_count_table(int(mythic_regular.ID))
    total_count = get_total_count(int(mythic_regular.ID))
    return regular_count, total_count


def get_npc_count(npcID, regular_count):  # Returns the count of an NPC
    """Checks dungeon count table for count related to an NPC ID

    Args:
        npcID (int): Creature NPC ID
        regular_count (dataframe): Count table associated with the dungeon

    Returns:
        int: True count for the NPC ID

    """
    # If the NPC does not give count it returns 0
    # If the NPC gives the same X count and Y teemingCount it returns X, None
    #       and doesn't add teemingCount to npc in lua table
    # If the NPC gives X count and Y teemingCount it return X, Y
    npc_count_check = regular_count[regular_count.index == npcID]
    if npc_count_check.empty:
        npc_count = 0
    else:
        npc_count = int(npc_count_check.values)

    return npc_count


def is_mob_unimportant(npc, threshold):
    """Boolean check to see if an NPC's max health is above a threshold

    Args:
        npc: Information about the NPC
        threshold (int): Minimun threshold for an NPC to be important

    Returns:
        bool: Boolean controlling whether the NPC is unimportant
    """
    if npc[0].astype(str).startswith("Creature") and int(npc[1]) < threshold:
        mobcount = get_npc_count(npc.npcID, regular_count)
        if mobcount == 0:
            return True

    return False


def make_aura_check_GUID_list(CL, aura):
    """Maps auras to NPC data in MDT

    How to use
    1. Input the combatlog and the aura you want to check for like seen below
    2. Make 2 lines of code in the table_output generator below like the example below
        if npc.destGUID in inspiring_GUID_list:
            table_output += f'\t\t\t\t["inspiring"] = true;\n'
    Args:
        CL (dataframe): Combatlog dataframe
        aura (string): Name of aura to map

    Returns:
        list: List of GUIDs affected by the aura
    """
    GUID_list = CL.loc[((CL.event == "SPELL_AURA_APPLIED") &
                        (CL.spellName == aura))].destGUID.values
    return GUID_list


if __name__ == "__main__":
    wowtools_files = ["uimapassignment", "map", "criteria", "criteriatree", "journalencounter"]
    db = load_db_files(wowtools_files)

    combatlog_cnames = ["timestampevent", "sourceGUID", "sourceName", "sourceFlags", "sourceRaidFlags", "destGUID",
                        "destName", "destFlags", "destRaidFlags", "spellId", "spellName", "spellSchool", "unitGUID",
                        "ownerGUID",
                        "currHP", "maxHP", "attackPower", "spellPower", "armor", "resourceType", "currResource",
                        "maxResource",
                        "resourceCost", "unknown", "ycoord", "xcoord", "UiMapID", "facing", "level", "amount",
                        "overkill", "school", "resisted", "blocked", "absorbed", "critical", "glancing", "crushing",
                        "isOffHand"]

    CL = pd.read_csv("WoWCombatLog.txt", sep=",", header=None, names=combatlog_cnames, low_memory=False, on_bad_lines='skip')
    # Extracting the event from date and time, which are not comma separated
    timesplit = CL.timestampevent.str.split(" ")
    timesplitdf = pd.DataFrame.from_records(timesplit, columns=["date", "time", "remove", "event"])
    CL = pd.concat([CL, timesplitdf], axis=1).drop(["remove", "timestampevent"], axis=1)

    # List containing all bosses from log
    boss_names = CL.loc[(CL.event == "ENCOUNTER_START")].sourceName.to_list()

    # Dataframe that contains every initial SPELL_DAMAGE event against each npc
    mobHits = CL.loc[(CL.event == "SPELL_DAMAGE") &
                     (~CL.destGUID.str.startswith("Player", na=True)) &  # Filters out damage events against the player
                     (~CL.ownerGUID.str.startswith("Player", na=True)) &  # Filters out damage events against player pets
                     (CL.destName != "Unknown"),
                     ["destGUID", "ownerGUID", "destName", "xcoord", "ycoord", "UiMapID", "maxHP", "level"]]
    mobHits.drop_duplicates(subset=["destGUID"], keep="first", inplace=True)
    mobHits = mobHits[mobHits.maxHP.astype(int) > 50] # not working for Tazavesh Streets
    # Fix Blizzard combat log coords
    mobHits["xcoord"] = - mobHits.xcoord.astype(float)
    mobHits["ycoord"] = mobHits.ycoord.astype(float)
    mobHits = mobHits.astype({"UiMapID": int, "maxHP": int, "level": int}) # not working for Tazavesh Streets
    mobHits = mobHits.astype({"UiMapID": int})

    unique_UiMapIDs = mobHits.UiMapID.unique().tolist()

    db["uimapassignment"].rename(columns={"MapID": "continentID",
                                         "Region[0]": "ymin",
                                         "Region[1]": "xmax",
                                         "Region[3]": "ymax",
                                         "Region[4]": "xmin"},
                                inplace=True)
    db["uimapassignment"].xmin = db["uimapassignment"].xmin * -1  # Multiply by -1 because of blizzard coords
    db["uimapassignment"].xmax = db["uimapassignment"].xmax * -1  # Multiply by -1 because of blizzard coords
    db["map"].rename(columns={"ID": "continentID",
                             "MapName_lang": "dungeon_name",
                             "Directory": "directory"},
                    inplace=True)

    info_columns = ["dungeon_name", "continentID", "UiMapID", "directory",
                    "xmin", "xmax", "ymin", "ymax"]
    # DataFrame merging the UiMapID and their associated dungeon from map with the map extent info from uimapassignment
    map_extent = (db["map"].merge(db["uimapassignment"], on="continentID")[info_columns]
                  .copy()
                  .round(1)
                  .drop_duplicates())

    # Converts combat log coordinates to MDT coordinates
    mobHits[["MDTx", "MDTy"]] = mobHits.apply(convert_to_MDT_coord, axis=1)
    # Transforms UiMapID into MDT sublevel
    # Assigns 1 to the first UiMapID seen in the log, 2 to the second and so on
    # Move through the dungeon sublevels in the same order as the sublevel-dropdown to avoid errors
    mobHits["sublevel"] = [UiMapID_to_sublevel(UiMapID) for UiMapID in mobHits.UiMapID]

    # # Inspiring Presence Mapping
    inspiring_GUID_list = make_aura_check_GUID_list(CL, "Inspiring Presence")
    regular_count, total_count = get_dungeon_count(boss_names)

    # Account for mobs with same name, but different npcID
    mobHits["npcID"] = [get_npc_id(GUID) for GUID in mobHits.destGUID]

    # Add count to mobHits table
    mobHits["mobcount"] = [get_npc_count(npcID, regular_count) for npcID in mobHits.npcID]

    # Removing enemy pets below HP threshold and no count, this is an attempt to only remove unimportant pets
    # If you want to include all pets and remove manually simply comment out the six lines below
    HP_threshold = 20000 # not working for Tazavesh Streets
    deleted_mobs = mobHits.loc[(mobHits.ownerGUID.str.startswith("Creature")) &
                                   (mobHits.maxHP < 20000) & (mobHits.mobcount == 0)]
    mobHits.drop(mobHits.loc[(mobHits.ownerGUID.str.startswith("Creature")) & (mobHits.maxHP < 20000) &
                             (mobHits.mobcount == 0)].index, inplace=True)
    print("{} enemy pets deleted due to low health (sub {}) and no count.".format(len(deleted_mobs), HP_threshold)) # not working for Tazavesh Streets


    print("Mapping Initiated [", end="")

    npc_locale_en = ""
    table_output = f"MDT.dungeonTotalCount[dungeonIndex] = {{normal={total_count},teeming=1000,teemingEnabled=true}}\n"
    table_output += "MDT.dungeonEnemies[dungeonIndex] = {\n"

    for unique_npc_index, unique_npcID in enumerate(mobHits.npcID.unique()):
        unique_npc_index += 1  # Lua is stupid
        table_output += f'\t[{unique_npc_index}] = {{\n\t\t["clones"] = {{\n'
        for npc_index, npc in enumerate(mobHits[mobHits.npcID == unique_npcID].itertuples()):
            npc_index += 1  # Lua is stupid
            table_output += f'\t\t\t[{npc_index}] = {{\n'
            table_output += f'\t\t\t\t["x"] = {npc.MDTx};\n'
            table_output += f'\t\t\t\t["y"] = {npc.MDTy};\n'
            table_output += f'\t\t\t\t["sublevel"] = {npc.sublevel};\n'
            if npc.destGUID in inspiring_GUID_list:
                table_output += f'\t\t\t\t["inspiring"] = true;\n'
            table_output += f'\t\t\t}};\n'

        table_output += '\t\t};\n'
        if npc.destName in boss_names:
            encounterID, instanceID = get_boss_info(npc.destName)
            table_output += f'\t\t["isBoss"] = true;\n'
            table_output += f'\t\t["encounterID"] = {encounterID};\n'
            table_output += f'\t\t["instanceID"] = {instanceID};\n'
        table_output += f'\t\t["name"] = "{npc.destName}";\n'
        # Adding npc name to string for easy locale enUS
        npc_locale_en += f'L["{npc.destName}"] = "{npc.destName}"\n'
        table_output += f'\t\t["id"] = {npc.npcID};\n'
        table_output += f'\t\t["health"] = {npc.maxHP};\n'
        table_output += f'\t\t["level"] = {npc.level};\n'
        table_output += f'\t\t["count"] = {npc.mobcount};\n'
        if request_wowtools:
            displayID, creatureType = get_displayid_and_creaturetype(npc.npcID)
            table_output += f'\t\t["displayId"] = {displayID};\n'
            table_output += f'\t\t["creatureType"] = "{creatureType}";\n'
        table_output += f'\t\t["scale"] = 1;\n'
        print("-", end="")

        table_output += '\t};\n'
    table_output += '};\n\n'
    print("] Mapping Completed")



    # Read file locale_dump if it exists otherwise set locale_file to []
    try:
        locale_file = (pd.read_csv("locale_dump.txt", names=["text"], header=None, sep="*")
                       .text.unique()
                       .tolist())
    except FileNotFoundError:
        locale_file = []

    # Remove all duplicate npc names from locale output
    npc_locale_en = "\n".join(list(OrderedDict.fromkeys(npc_locale_en.split("\n"))))

    # Find new npc names from combat log that have never been seen before and add to local_dump.txt
    [locale_file.append(text) for text in npc_locale_en.split("\n") if text not in locale_file]

    with open("locale_dump.txt", "w") as f:
        for item in locale_file:
            f.write(f"{item}\n")

    # Add new npc names to output
    table_output += npc_locale_en

    pyperclip.copy(table_output)

    print("This dungeon requires {} count to complete and has {} total count. You need to clear {}% of the dungeon."
          .format(total_count, mobHits.mobcount.sum(), int(round(total_count/mobHits.mobcount.sum(), 2)*100)))
    print("Lua table copied to clipboard. Paste into the correct dungeon file.")
