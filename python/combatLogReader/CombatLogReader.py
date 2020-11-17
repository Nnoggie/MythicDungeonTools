import time
import pandas as pd
import numpy as np
import pyperclip
from get_wowtools_data import *

request_wowtools = True
# How to use:
# 1. Delete or rename your current WoWCombatLog.txt file to start from fresh
# 2. Run the dungeon tagging all mobs where they spawn.
# 3. Copy the resulting WoWCombatLog.txt file to the directory of this file
# 4. Run this script
# 5. Open the .lua file for the given dungeon and paste what has been added to your clipboard

combatlog_cnames = ["timestampevent", "sourceGUID", "sourceName", "sourceFlags", "sourceRaidFlags", "destGUID",
                    "destName", "destFlags", "destRaidFlags", "spellId", "spellName", "spellSchool", "unitGUID",
                    "ownerGUID",
                    "currHP", "maxHP", "attackPower", "spellPower", "armor", "resourceType", "currResource",
                    "maxResource",
                    "resourceCost", "unknown", "ycoord", "xcoord", "UiMapID", "facing", "level", "amount",
                    "overkill", "school", "resisted", "blocked", "absorbed", "critical", "glancing", "crushing",
                    "isOffHand"]

CL = pd.read_csv("WoWCombatLog.txt", sep=",", header=None, names=combatlog_cnames)
# Extracting the event from date and time, which are not comma separated
timesplit = CL.timestampevent.str.split(" ")
timesplitdf = pd.DataFrame.from_records(timesplit, columns=["date", "time", "remove", "event"])
CL = pd.concat([CL, timesplitdf], axis=1).drop(["remove", "timestampevent"], axis=1)

# List containing all bosses from log
boss_names = CL.loc[(CL.event == "ENCOUNTER_START")].sourceName.to_list()

# Dataframe that contains every initial SPELL_DAMAGE event against each npc
mobHits = CL.loc[(CL.event == "SPELL_DAMAGE") &
                 (~CL.destGUID.str.startswith("Player", na=True)) &     # Filters out damage events against the player
                 (~CL.ownerGUID.str.startswith("Player", na=True)),      # Filters out damage events against player pets
                 ["destGUID", "destName", "xcoord", "ycoord", "UiMapID", "maxHP", "level"]]
mobHits.drop_duplicates(subset=["destGUID"], keep="first", inplace=True)
mobHits = mobHits[mobHits.maxHP.astype(int) > 50]
# Fix Blizzard combat log coords
mobHits["xcoord"] = - mobHits.xcoord.astype(float)
mobHits["ycoord"] = mobHits.ycoord.astype(float)
mobHits = mobHits.astype({"UiMapID": int, "maxHP": int, "level": int})

unique_UiMapIDs = mobHits.UiMapID.unique().tolist()

# Importing files from wow.tools. If the file is available in the directory it is read otherwise it is downloaded first
#   uimapassignment: contains information about the extent of a UiMapID on its base minimap file.
#       Which means it contains minimap coordinate points for the borders of the in-game map
#   map: contains UiMapIDs and their associated dungeons
#   criteria: contains information about which criteria a given npc triggers when dying in a mythic dungeon
#   criteriatree: contains information about which criteria from the above list is triggered when count is
#        attributed in a mythic dungeon as well as the amount of count attributed
#   journalencounter: contains the encounterID and instanceID for bosses which MDT stores
wowtools_files = ["uimapassignment", "map", "criteria", "criteriatree", "journalencounter"]
f = {}
for file in wowtools_files:
    try:
        f[file] = pd.read_csv(f"{file}.csv")
    except FileNotFoundError:
        f[file] = get_latest_version(file)

f["uimapassignment"].rename(columns={"MapID": "continentID",
                                     "Region[0]": "ymin",
                                     "Region[1]": "xmax",
                                     "Region[3]": "ymax",
                                     "Region[4]": "xmin"},
                            inplace=True)
f["uimapassignment"].xmin = f["uimapassignment"].xmin * -1  # Multiply by -1 because of blizzard coords
f["uimapassignment"].xmax = f["uimapassignment"].xmax * -1  # Multiply by -1 because of blizzard coords
f["map"].rename(columns={"ID": "continentID",
                         "MapName_lang": "dungeon_name",
                         "Directory": "directory"},
                inplace=True)


info_columns = ["dungeon_name", "continentID", "UiMapID", "directory",
                "xmin", "xmax", "ymin", "ymax"]
# DataFrame merging the UiMapID and their associated dungeon from map with the map extent info from uimapassignment
map_extent = (f["map"].merge(f["uimapassignment"], on="continentID")[info_columns]
              .copy()
              .round(1)
              .drop_duplicates())


def get_map_extent(UiMapID):  # Returns map extent in minimap coordinates xmin, xmax, ymin, ymax
    return map_extent.loc[map_extent.UiMapID == UiMapID, ["xmin", "xmax", "ymin", "ymax"]] #TODO FIX THIS TO INCLUDE SL


def convert_to_relative_coord(df):  # Converts mob position to relative position from (0,100). Returns x,y
    extent = get_map_extent(df.UiMapID)
    x = float((df.xcoord - extent.xmin) / (extent.xmax - extent.xmin))
    y = float((df.ycoord - extent.ymin) / (extent.ymax - extent.ymin))
    return pd.Series([x, y])


def convert_to_MDT_coord(df):       # Converts mob position to coordinates used for the MDT map. Returns x,y as series
    # MDT INFO FOR SCALE = 1
    # WIDTH = 840
    # HEIGHT = 555
    # HEIGHT IS NEGATIVE
    # 0,0 IS TOP LEFT CORNER
    extent = get_map_extent(df.UiMapID)
    # MDT width and height at scale = 1
    width = 840
    height = 555
    x = float((df.xcoord - extent.xmin) / (extent.xmax - extent.xmin))
    y = float((df.ycoord - extent.ymin) / (extent.ymax - extent.ymin))
    x = x * width
    y = -(1 - y) * height
    return pd.Series([x, y])


def get_npc_id(GUID):       # Splits the GUID and extracts the npcID
    return int(GUID.split("-")[5])


def get_boss_info(name):    # Takes as input a boss name and returns the corresponsing encounterID and instanceID
    boss = f["journalencounter"][f["journalencounter"].Name_lang == name]
    encounterID = int(boss.ID)
    instanceID = int(boss.JournalInstanceID)
    return encounterID, instanceID


def UiMapID_to_sublevel(UiMapID):
    return unique_UiMapIDs.index(UiMapID) + 1


# Converts combat log coordinates to MDT coordinates
mobHits[["MDTx", "MDTy"]] = mobHits.apply(convert_to_MDT_coord, axis=1)
# Transforms UiMapID into MDT sublevel
# Assigns 1 to the first UiMapID seen in the log, 2 to the second and so on
# Move through the dungeon sublevels in the same order as the sublevel-dropdown to avoid errors
mobHits["sublevel"] = [UiMapID_to_sublevel(UiMapID) for UiMapID in mobHits.UiMapID]


def get_count_table(ID):    # Extracts the count table for a given dungeons enemy forces criteria ID
    dungeon_forces = f["criteriatree"][((f["criteriatree"].Parent == ID) &
                                   (f["criteriatree"].Description_lang == "Enemy Forces"))]
    enemy_forces = f["criteriatree"][f["criteriatree"].Parent == int(dungeon_forces.ID)].copy()
    enemy_forces["npcID"] = [int(f["criteria"][f["criteria"].ID == ID].Asset) for ID in enemy_forces.CriteriaID]
    count_table = enemy_forces.groupby(["npcID"]).agg(count=("Amount", "sum"))
    return count_table


def get_total_count(ID):
    dungeon_forces = f["criteriatree"][((f["criteriatree"].Parent == ID) &
                                        (f["criteriatree"].Description_lang == "Enemy Forces"))].Amount
    return int(dungeon_forces)


def get_dungeon_count(boss_names):  # Imput is a list of dungeon bosses, returns count and teeming_count for dungeon
    # The function uses the first boss name in boss_names to figure out which dungeon it is
    if not boss_names:
        return print("Error: Combat log does not contain any boss fights. A boss fight required for collecting count.")

    #Fixing Blizzard brain not naming bosses the same everywhere
    for i in range(len(boss_names)):
        parent_dungeons = f["criteriatree"][
            f["criteriatree"].Description_lang.str.startswith(boss_names[i], na=False)].Parent
        if len(parent_dungeons) == 0:
            print("Fixing Blizzard Brain.")
        else:
            print("Correct boss name found.")
            break

    mythic_regular = f["criteriatree"][(
            (f["criteriatree"].Description_lang.str.contains('Dungeon.*Challenge', na=False)) &
            (f["criteriatree"].ID.isin(parent_dungeons)) &
            ~f["criteriatree"].Description_lang.str.contains("More Trash", na=False))] # This means NOT Teeming

    regular_count = get_count_table(int(mythic_regular.ID))
    total_count = get_total_count(int(mythic_regular.ID))
    return regular_count, total_count


def get_npc_count(npcID, regular_count):       # Returns the count of an NPC
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


def make_aura_check_GUID_list(CL, aura):
    # How to use
    # 1. Input the combatlog and the aura you want to check for
    # 2. Make 2 lines of code in the table_output generator below like this
    # if npc.destGUID in inspiring_GUID_list:
    #    table_output += f'\t\t\t\t["inspiring"] = true;\n'
    GUID_list = CL.loc[((CL.event == "SPELL_AURA_APPLIED") &
                             (CL.spellName == aura))].destGUID.values
    return GUID_list


# # Inspiring Presence Mapping
inspiring_GUID_list = make_aura_check_GUID_list(CL, "Inspiring Presence")
regular_count, total_count = get_dungeon_count(boss_names)

print("Mapping Initiated [", end="")

npc_locale_en = ""
table_output = "MDT.dungeonEnemies[dungeonIndex] = {\n"

for unique_npc_index, unique_npc_name in enumerate(mobHits.destName.unique()):
    unique_npc_index += 1  # Lua is stupid
    table_output += f'\t[{unique_npc_index}] = {{\n\t\t["clones"] = {{\n'
    for npc_index, npc in enumerate(mobHits[mobHits.destName == unique_npc_name].itertuples()):
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
    table_output += f'\t\t["name"] = L["{npc.destName}"];\n'
    # Adding npc name to string for easy locale enUS
    npc_locale_en += f'L["{npc.destName}"] = "{npc.destName}"\n'
    npcID = get_npc_id(npc.destGUID)
    table_output += f'\t\t["id"] = {npcID};\n'
    table_output += f'\t\t["health"] = {npc.maxHP};\n'
    table_output += f'\t\t["level"] = {npc.level};\n'
    count = get_npc_count(npcID, regular_count)
    table_output += f'\t\t["count"] = {count};\n'
    if request_wowtools:
        displayID, creatureType = get_displayid_and_creaturetype(npcID)
        table_output += f'\t\t["displayId"] = {displayID};\n'
        table_output += f'\t\t["creatureType"] = L["{creatureType}"];\n'
    table_output += f'\t\t["scale"] = 1;\n'
    print("-", end="")

    table_output += '\t};\n'
table_output += '};'
print("] Mapping Completed")
table_output += f"\nMDT.dungeonTotalCount[dungeonIndex] = {{normal={total_count},teeming=1000,teemingEnabled=true}}\n\n"

# Checking locale_dump.txt and adding new npcs names to output
# Read file locale_dump if it exists otherwise set locale_file to []
try:
    locale_file = (pd.read_csv("locale_dump.txt", names=["text"], header=None, sep="*")
                     .text.unique()
                     .tolist())
except FileNotFoundError:
    locale_file = []

# Find new npc names from combat log that have never been seen before
new_npc_locale_en = [text for text in npc_locale_en.split("\n") if text not in locale_file]

# Update locale_dump
for item in new_npc_locale_en:
    locale_file.append(item)

with open("locale_dump.txt", "w") as f:
    for item in locale_file:
        f.write(f"{item}\n")

# Add new npc names to output
locale_en_output = output = f"\n".join(new_npc_locale_en)
table_output += locale_en_output

pyperclip.copy(table_output)

print("Lua table copied to clipboard. Paste into the correct dungeon file.")
