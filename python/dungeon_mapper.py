import os

import numpy as np
import pandas as pd
import pyperclip
import tkinter as Tk
from tkinter import filedialog
from web_scraper import *

request_wowtools = True
toggle_door_mapping = False
GROUP_SEC_DELIMITER = 5
# How to use:
# 1. Have Advanced Combat Logging Enabled!
# 2. Delete or rename your current WoWCombatLog.txt file to start from fresh.
# 3. Run the dungeon on +2 with inspiring tagging all mobs where they spawn.
# 4. Copy the resulting WoWCombatLog.txt file to the directory of this file.
# 5. Run this script.
# 6. Open the .lua file for the given dungeon and paste what has been added to your clipboard.


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
    if len(extent) > 1:
        extent = extent.iloc[0]
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


def get_additional_boss_info(name, UiMapIDs):
    """Finds encounterID and instanceID associated with a boss

    Args:
        name (string): Boss name
        UiMapIDs (list): List of all unique UiMapIDs from the combatlog

    Returns:
        int: encounterID associated with the boss
        int: instanceID associated with the boss

    """
    boss = db["journalencounter"][((db["journalencounter"].Name_lang == name)
                                    & (db["journalencounter"].UiMapID.isin(UiMapIDs)))]
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


def get_dungeon_id(boss_info, mobHits):
    """Find a dungeons ID from boss info and combatlog hits in the dungeon

    Args:
        boss_info (dataframe): Dataframe containing information about bosses in the dungeon
        mobHits (dataframe): Dataframe containing the first combatlog hit of each creature in the dungeon

    Returns:
        int: The CriteriaTree ID for the Mythic+ dungeon

    """
    if not len(boss_info) > 0:
        return print("Error: Combat log does not contain any boss fights. A boss fight required for collecting count.")
    # Attempt to find bosses by DungeonEncounterIDs
    DungeonEncounterIDs = [int(id) for id in boss_info.sourceGUID]
    CriteriaIDs = db['criteria'][(db['criteria'].Asset.isin(DungeonEncounterIDs)) & (db['criteria'].Type == 165)].ID.values
    ParentIDs = db['criteriatree'][db['criteriatree'].CriteriaID.isin(CriteriaIDs)].Parent.values

    challenge_at_end = db['criteriatree'][(db['criteriatree'].ID.isin(ParentIDs))
                                          & (db['criteriatree'].Description_lang.str.endswith("Challenge"))
                                          & (db['criteriatree'].Operator == 4)]

    challenge_contained = db['criteriatree'][(db['criteriatree'].ID.isin(ParentIDs))
                                             & (db['criteriatree'].Description_lang.str.contains("Challenge"))
                                             & (~db['criteriatree'].Description_lang.str.contains("More Trash",
                                                                                                  na=False))
                                             & (db['criteriatree'].Operator == 4)]
    if len(challenge_at_end) > 0:
        print("Dungeon ID located.")
        return challenge_at_end.ID.values[0]

    elif len(challenge_contained) > 0:
        print("Dungeon ID located.")
        return challenge_contained.ID.values[0]

    else:
        # Weird case where blizzard doesn't use the journalencounterid, but instead the npcID
        print("-- Locating dungeon through EncounterID failed, trying NPC IDs.")
        all_npcids = mobHits[mobHits.destName.isin(boss_info.sourceName.to_list())].npcID.to_list()
        CriteriaIDs = db['criteria'][db['criteria'].Asset.isin(all_npcids)].ID.values
        ParentIDs = db['criteriatree'][db['criteriatree'].CriteriaID.isin(CriteriaIDs)].Parent.values
        if len(db['criteriatree'][(db['criteriatree'].ID.isin(ParentIDs))
                                  & (db['criteriatree'].Description_lang.str.endswith("Challenge"))]) > 0:
            dungeonID = db['criteriatree'][(db['criteriatree'].ID.isin(ParentIDs)) & (
                db['criteriatree'].Description_lang.str.endswith("Challenge"))].ID.values[0]

            print("Dungeon ID located.")
            return dungeonID
        
        if len(db['criteriatree'][(db['criteriatree'].ID.isin(ParentIDs))
                                  & (db['criteriatree'].Description_lang == "Shadowmoon Burial Grounds")]) > 0:
            dungeonID = db['criteriatree'][(db['criteriatree'].ID.isin(ParentIDs)) 
                                           & (db['criteriatree'].Description_lang == "Shadowmoon Burial Grounds")].ID.values[0]

            print("Dungeon ID located.")
            return dungeonID

        
        print("-- Locating dungeon through NPC IDs failed, trying boss names.")

    # Fixing Blizzard brain not naming bosses the same everywhere
    for boss_name in boss_info.sourceName.to_list():
        parent_dungeons = db["criteriatree"][
            db["criteriatree"].Description_lang.str.startswith(boss_name, na=False)].Parent
        if len(parent_dungeons) == 0:
            print("Fixing Blizzard Brain.")
        else:
            print("Correct boss name found.")
            mythic_regular = db["criteriatree"][(
                    (db["criteriatree"].Description_lang.str.contains('Dungeon.*Challenge', na=False)) &
                    (db["criteriatree"].ID.isin(parent_dungeons)) &
                    ~db["criteriatree"].Description_lang.str.contains("More Trash",
                                                                      na=False))]  # This means NOT Teeming
            if len(mythic_regular) > 0:
                print("Dungeon ID located.")
                return mythic_regular.ID

    print("WARNING: No dungeon ID could be located.")


def get_count_table(ID, db_files = None):
    """Extracts the dungeon count table for a dungeon

    Args:
        ID (int): dungeonID for dungeon
        db_files (dict): Dictionary of database files to use

    Returns:
        dataframe: Count table for dungeon

    """
    if db_files is None:
        db_files = db
    dungeon_forces = db_files["criteriatree"][((db_files["criteriatree"].Parent == ID) &
                                         (db_files["criteriatree"].Description_lang == "Enemy Forces"))]
    enemy_forces = db_files["criteriatree"][db_files["criteriatree"].Parent == int(dungeon_forces.ID)].copy()
    enemy_forces["npcID"] = [int(db_files["criteria"][db_files["criteria"].ID == ID].Asset) for ID in enemy_forces.CriteriaID]
    # An enemy can have multiple entries by blizzard mistake, the enemy will then attribute count from all entries
    count_table = enemy_forces.groupby(["npcID"]).agg(count=("Amount", "sum"))
    # Game event converter replaces game event ids with npc ids
    game_event_converter = {
        # format is game event: npcID
        64192: 138489,      # Shadow of Zul, Kings' Rest
        63453: 68819,       # Eye of Sethraliss, Temple of Sethraliss
        80831: 190128,      # Zul'gamux, Shrouded Affix (Big One)
        80779: 189878,      # Nathrezim Infiltrator, Shrouded Affix (Small One)
    }
    count_table.rename(index=game_event_converter, inplace=True)
    return count_table


def get_total_count(ID, db_files = None):
    """Extracts total count for a dungeon

    Args:
        ID (int): dungeonID for dungeon
        db_files (dict): Dictionary of database files to use

    Returns:
        int: Total count needed for dungeon completion

    """
    if db_files is None:
        db_files = db
    dungeon_forces = db_files["criteriatree"][((db_files["criteriatree"].Parent == ID) &
                                         (db_files["criteriatree"].Description_lang == "Enemy Forces"))].Amount
    return int(dungeon_forces)


def get_dungeon_count(boss_info, mobHits):
    """Find dungeon count table and total count from list of dungeon bosses

    Args:
        boss_info (dataframe): Dataframe containing information about bosses in the dungeon
        mobHits (dataframe): Dataframe containing the first combatlog hit of each creature in the dungeon

    Returns:
        dataframe: Dataframe containing count information for dungeon
        int: Total count needed for dungeon completion

    """
    dungeonID = get_dungeon_id(boss_info, mobHits)
    regular_count = get_count_table(int(dungeonID))
    total_count = get_total_count(int(dungeonID))
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
            table_output += f'        ["inspiring"] = true;\n'
    Args:
        CL (dataframe): Combatlog dataframe
        aura (string): Name of aura to map

    Returns:
        list: List of GUIDs affected by the aura

    """
    GUID_list = CL.loc[((CL.event == "SPELL_AURA_APPLIED") &
                        (CL.spellName == aura))].destGUID.values
    return GUID_list


def create_mapPOIs(combatlog):
    """Searches combatlog for MAP_CHANGE and WORLD_MARKER_PLACED events

    Args:
        combatlog (dataframe): The combatlog from hitting every mob in the dungeon

    Returns:
        dataframe: A dataframe containing all MAP_CHANGED and WORLD_MARKER_PLACED events in the combatlog

    """
    pois = combatlog.loc[(combatlog.event == "MAP_CHANGE") | (combatlog.event == "WORLD_MARKER_PLACED"),
                         ["event", "sourceGUID", "sourceName", "sourceFlags", "sourceRaidFlags", "destGUID",
                          "destName", "time"]].copy(deep=True)
    pois.rename(columns={"sourceGUID": "MapID",
                         "sourceName": "markerid",
                         "sourceFlags": "ycoord",
                         "sourceRaidFlags": "xcoord"},
                inplace=True)
    pois.loc[pois.event == "MAP_CHANGE", "UiMapID"] = pois[pois.event == "MAP_CHANGE"].MapID
    pois.UiMapID.fillna(method="ffill", inplace=True)
    pois = pois.astype({"UiMapID": int, "ycoord": float, "xcoord": float})
    pois["xcoord"] = -pois["xcoord"]

    pois[["MDTx", "MDTy"]] = pois.apply(convert_to_MDT_coord, axis=1)
    return pois

def get_door_direction(door):
    """Calculates mapPOI door direction based on closest map extent border

    Args:
        door (dataframe row): A single row from pois dataframe

    Returns:
        int: mapPOI door direction based on closest map extent border

    """
    extent = get_map_extent(door.UiMapID)
    x = door.xcoord
    y = door.ycoord
    index = extent.index[0]
    distance = np.array([abs(x - extent.loc[index, "xmin"]),
                        abs(extent.loc[index, "xmax"] - x),
                        abs(y - extent.loc[index, "ymin"]),
                        abs(extent.loc[index, "ymax"] - y)])
    direction = [-2, 2, -1, 1]
    return direction[np.argmin(distance)]

def create_map_doors(pois):
    """Uses coordinate information from WORLD_MARKER_PLACED and map info from MAP_CHANGED to map "doors"

    Args:
        pois (dataframe): A dataframe containing all MAP_CHANGED and WORLD_MARKER_PLACED events in a combatlog

    Returns:
        dataframe: A dataframe containing only WORLD_MARKER_PLACED events rich with information needed for mapping

    """
    blue_pois = pois[(pois.event == "MAP_CHANGE") | ((pois.event == "WORLD_MARKER_PLACED") & (pois.markerid == "0"))].copy() # Blue world marker
    blue_pois.loc[pois.event == "MAP_CHANGE", "to_UiMapID"] = pois[pois.event == "MAP_CHANGE"].MapID
    blue_pois.to_UiMapID.fillna(method="bfill", inplace=True)

    green_pois = pois[(pois.event == "MAP_CHANGE") | ((pois.event == "WORLD_MARKER_PLACED") & (pois.markerid == "1"))].copy() # Green world marker
    green_pois.loc[pois.event == "MAP_CHANGE", "to_UiMapID"] = pois[pois.event == "MAP_CHANGE"].MapID
    # green_marker_pois.to_UiMapID.fillna(method="bfill", inplace=True)
    for index in green_pois[green_pois.event == "WORLD_MARKER_PLACED"].index.to_list():
        map_changes = green_pois[((green_pois.event == "MAP_CHANGE")
                                  & (green_pois.UiMapID != green_pois.loc[index, "UiMapID"]))].loc[:index]
        if len(map_changes) > 0:
            previous_map = int(map_changes.iloc[-1].MapID)
            green_pois.loc[:index, "to_UiMapID"] = previous_map
        else:
            green_pois.drop(index, inplace=True)

    door_pois = pd.concat([blue_pois, green_pois])
    door_pois.drop(door_pois.index[door_pois.event == "MAP_CHANGE"], axis=0, inplace=True)

    door_pois = door_pois.astype({"to_UiMapID": int})
    door_pois["from_sublevel"] = door_pois.UiMapID.apply(UiMapID_to_sublevel)
    door_pois["to_sublevel"] = door_pois.to_UiMapID.apply(UiMapID_to_sublevel)
    door_pois.sort_values(by="time", inplace=True)
    door_pois["connectionIndex"] = (-1 * (door_pois.markerid.astype(int)-1)).cumsum()
    door_pois["direction"] = door_pois.apply(get_door_direction, axis=1)
    door_pairs = door_pois.groupby('connectionIndex')['connectionIndex'].count()
    door_pairs = door_pairs[door_pairs == 2].index.to_list()

    blue_sublevels = door_pois.loc[(door_pois.connectionIndex.isin(door_pairs)) & (door_pois.markerid == "0"),
                                   "from_sublevel"].to_list()
    green_sublevels = door_pois.loc[(door_pois.connectionIndex.isin(door_pairs)) & (door_pois.markerid == "1"),
                                   "from_sublevel"].to_list()

    door_pois.loc[(door_pois.connectionIndex.isin(door_pairs)) & (door_pois.markerid == "0"),
                  "to_sublevel"] = green_sublevels
    door_pois.loc[(door_pois.connectionIndex.isin(door_pairs)) & (door_pois.markerid == "1"),
                  "to_sublevel"] = blue_sublevels

    door_pois = door_pois.astype({"from_sublevel": int, "to_sublevel": int})
    return door_pois

def pick_log_to_map():
    """Allows the user pick a log to map

    Returns:
        str: The path to the log file

    """
    root = Tk.Tk()
    root.withdraw()
    file_path = filedialog.askopenfilename(initialdir=os.getcwd(), filetypes=(("Text files", "*.txt"), ("all files", "*.*")))
    return file_path

def print_progressbar(progress, total, size=60):
    x = int(size*progress/total)
    print(f" Mapping: |{u'█'*x}{u'▁'*(size-x)}| {progress}/{total}", end="\r", flush=True)

    if progress == total:
        print("\n", flush=True)

if __name__ == "__main__":
    if not os.getcwd().endswith("python") and os.path.isdir(os.getcwd() + "/python"):
        os.chdir(os.getcwd() + "/python")

    combatlog_cnames = ["timestampevent", "sourceGUID", "sourceName", "sourceFlags", "sourceRaidFlags", "destGUID",
                        "destName", "destFlags", "destRaidFlags", "spellId", "spellName", "spellSchool", "unitGUID",
                        "ownerGUID",
                        "currHP", "maxHP", "attackPower", "spellPower", "armor", "resourceType", "currResource",
                        "maxResource",
                        "resourceCost", "unknown", "ycoord", "xcoord", "UiMapID", "facing", "level", "amount",
                        "overkill", "school", "resisted", "blocked", "absorbed", "critical", "glancing", "crushing",
                        "isOffHand"]
    
    combatlog_file_path = pick_log_to_map()

    CL = pd.read_csv(combatlog_file_path, sep=",", header=None, names=combatlog_cnames, low_memory=False,
                     on_bad_lines='skip')
    ADVANCED_COMBAT_LOGGING = CL.loc[0, "sourceFlags"] == "1"
    if not ADVANCED_COMBAT_LOGGING:
        print("WARNING: Advanced combat logging was NOT enabled!")
        
    GAME_VERSION = CL.loc[0, "destGUID"]
    wowtools_files = ["uimapassignment", "map", "criteria", "criteriatree", "journalencounter"]
    db = load_db_files(wowtools_files, GAME_VERSION)
    # Extracting the event from date and time, which are not comma separated
    timesplit = CL.timestampevent.str.split(" ")
    timesplitdf = pd.DataFrame.from_records(timesplit, columns=["date", "time", "remove", "event"])
    CL = pd.concat([CL, timesplitdf], axis=1).drop(["remove", "timestampevent"], axis=1)

    # List containing all information for bosses from log
    boss_info = CL.loc[(CL.event == "ENCOUNTER_START")]

    # Dataframe that contains every initial SPELL_DAMAGE event against each npc
    mobHits = CL.loc[(CL.event == "SPELL_DAMAGE") &
                     (~CL.destGUID.str.startswith("Player", na=True)) &  # Filters out damage events against the player
                     (~CL.ownerGUID.str.startswith("Player",
                                                   na=True)) &  # Filters out damage events against player pets
                     (CL.destName != "Unknown"),
                     ["destGUID", "ownerGUID", "destName", "xcoord",
                      "ycoord", "UiMapID", "maxHP", "level", "time"]].copy(deep=True)
    mobHits.drop_duplicates(subset=["destGUID"], keep="first", inplace=True)
    mobHits = mobHits[mobHits.maxHP.astype(int) > 50]
    # Fix Blizzard combat log coords
    mobHits["xcoord"] = - mobHits.xcoord.astype(float)
    mobHits["ycoord"] = mobHits.ycoord.astype(float)
    mobHits = mobHits.astype({"UiMapID": int, "maxHP": int, "level": int})  # not working for Tazavesh Streets
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

    # Inspiring Presence Mapping
    inspiring_GUID_list = make_aura_check_GUID_list(CL, "Inspiring Presence")

    # Shadowlands season 4 Shrouded affix (Disguised debuff)
    disguised_GUID_list = make_aura_check_GUID_list(CL, "Disguised")

    # Account for mobs with same name, but different npcID
    mobHits["npcID"] = [get_npc_id(GUID) for GUID in mobHits.destGUID]

    # Get count for dungeon
    regular_count, total_count = get_dungeon_count(boss_info, mobHits)

    # Add count to mobHits table
    mobHits["mobcount"] = [get_npc_count(npcID, regular_count) for npcID in mobHits.npcID]

    # Removing enemy pets below HP threshold and no count, this is an attempt to only remove unimportant pets
    # If you want to include all pets and remove manually simply comment out the six lines below
    HP_threshold = 130000  # not working for Tazavesh Streets
    deleted_mobs = mobHits.loc[(mobHits.ownerGUID.str.startswith("Creature")) &
                               (mobHits.maxHP < 20000) & (mobHits.mobcount == 0)]
    mobHits.drop(mobHits.loc[(mobHits.ownerGUID.str.startswith("Creature")) & (mobHits.maxHP < 20000) &
                             (mobHits.mobcount == 0)].index, inplace=True)
    print("{} enemy pets deleted due to low health (sub {}) and no count.".format(len(deleted_mobs),
                                                                                  HP_threshold))
    # Preparing data for automatic grouping
    mobHits["delta_pre"] = pd.to_datetime(mobHits.time).diff().dt.seconds.fillna(0)
    mobHits["delta_post"] = mobHits.delta_pre.shift(-1).fillna(100)
    # Find last mob of all groups
    mobHits.loc[(mobHits.delta_pre < GROUP_SEC_DELIMITER) & (mobHits.delta_post > GROUP_SEC_DELIMITER), 'group'] = 1
    # Set their group number
    mobHits['group'] = mobHits.group.cumsum()
    # Set "single mob groups" to group 0
    mobHits.loc[(mobHits.delta_pre > GROUP_SEC_DELIMITER) & (mobHits.delta_post > GROUP_SEC_DELIMITER), 'group'] = 0
    # Fill the remaning mobs with next seen group number
    mobHits.group.fillna(method="bfill", inplace=True)

    # Create mapPOIs from WORLD_MARKER_PLACED
    if toggle_door_mapping:
        pois = create_mapPOIs(CL)
        door_pois = create_map_doors(pois) # Blue (0) and green (1) marker

    total_mobs = len(mobHits)
    mapping_progress = 0
    print_progressbar(0, total_mobs, size=60)
    npc_locale_list = []
    table_output = f'MDT.dungeonTotalCount[dungeonIndex] = {{normal={total_count},teeming=1000,teemingEnabled=true}}\n'
    if toggle_door_mapping:
        table_output += f'MDT.mapPOIs[dungeonIndex] = {{\n'
        # Mapping mapPOIs
        for sublevel in door_pois["from_sublevel"].unique():
            table_output += f'  [{sublevel}] = {{\n'
            for idx, (_, door) in enumerate(door_pois[door_pois.from_sublevel == sublevel].iterrows()):
                table_output += f'    [{idx+1}] = {{\n'
                table_output += f'      ["y"] = {door.MDTy};\n'
                table_output += f'      ["x"] = {door.MDTx};\n'
                table_output += f'      ["connectionIndex"] = {door.connectionIndex};\n'
                table_output += f'      ["target"] = {door.to_sublevel};\n'
                table_output += f'      ["type"] = "mapLink";\n'
                table_output += f'      ["template"] = "MapLinkPinTemplate";\n'
                table_output += f'      ["direction"] = {door.direction};\n'
                table_output += f'    }};\n'

            table_output += f'  }};\n'
        table_output += f'}};\n\n'

    table_output += 'MDT.dungeonEnemies[dungeonIndex] = {\n'
    # Mapping dungeon enemies
    for unique_npc_index, unique_npcID in enumerate(mobHits.npcID.unique()):
        unique_npc_index += 1  # Lua is stupid
        table_output += f'  [{unique_npc_index}] = {{\n    ["clones"] = {{\n'
        for npc_index, npc in enumerate(mobHits[mobHits.npcID == unique_npcID].itertuples()):
            npc_index += 1  # Lua is stupid
            table_output += f'      [{npc_index}] = {{\n'
            table_output += f'        ["x"] = {npc.MDTx};\n'
            table_output += f'        ["y"] = {npc.MDTy};\n'
            table_output += f'        ["sublevel"] = {npc.sublevel};\n'
            if npc.group != 0:
                table_output += f'        ["g"] = {int(npc.group)};\n'
            if npc.destGUID in inspiring_GUID_list:
                table_output += f'        ["inspiring"] = true;\n'
            if npc.destGUID in disguised_GUID_list:
                table_output += f'        ["disguised"] = true;\n'
            table_output += f'      }};\n'
            mapping_progress += 1
            print_progressbar(mapping_progress, total_mobs, size=60)

        table_output += '    };\n'
        if npc.destName in boss_info.sourceName.to_list():
            encounterID, instanceID = get_additional_boss_info(npc.destName, unique_UiMapIDs)
            table_output += f'    ["isBoss"] = true;\n'
            table_output += f'    ["encounterID"] = {encounterID};\n'
            table_output += f'    ["instanceID"] = {instanceID};\n'
        table_output += f'    ["name"] = "{npc.destName}";\n'
        # Adding npc name to list for easy locale enUS
        npc_locale_list.append(npc.destName)
        table_output += f'    ["id"] = {npc.npcID};\n'
        table_output += f'    ["health"] = {npc.maxHP};\n'
        table_output += f'    ["level"] = {npc.level};\n'
        table_output += f'    ["count"] = {npc.mobcount};\n'
        if request_wowtools:
            displayID, creatureType = get_displayid_and_creaturetype(npc.npcID)
            table_output += f'    ["displayId"] = {displayID};\n'
            table_output += f'    ["creatureType"] = "{creatureType}";\n'
        table_output += f'    ["scale"] = 1;\n'
        table_output += '  };\n'
    table_output += '};\n\n'

    # Create locale enUS from unique names in npc_locale_list
    npc_locale_en = ""
    for destName in set(npc_locale_list):
        npc_locale_en += f'L["{destName}"] = "{destName}"\n'

    # Add new npc names to output
    table_output += npc_locale_en
    pyperclip.copy(table_output)
    print("This dungeon requires {} count to complete and has {} total count. You need to clear {}% of the dungeon."
          .format(total_count, mobHits.mobcount.sum(), int(round(total_count / mobHits.mobcount.sum(), 2) * 100)))
    print("Lua table copied to clipboard. Paste into the correct dungeon file.")
    