import os
import re
import pandas as pd
from web_scraper import *
from dungeon_mapper import get_count_table, get_total_count

EXPANSIONS = ['Legion', 'BattleForAzeroth', 'Shadowlands']
# How to use:
# 1. Update the list "EXPANSIONS" above to include all expansions. Use name of MDT expansion dungeon folders.
# 2. Delete the following files from the directory "/wowdb_files"
#       uimapassignment.csv, map.csv, criteria.csv, criteriatree.csv, journalencounter.csv
# 3. Run the script, it writes directly to the files automatically.

# Importing files from wow.tools. If the file is available in the directory it is read otherwise it is downloaded first
#   uimapassignment: contains information about the extent of a UiMapID on its base minimap file.
#       Which means it contains minimap coordinate points for the borders of the in-game map
#   map: contains UiMapIDs and their associated dungeons
#   criteria: contains information about which criteria a given npc triggers when dying in a mythic dungeon
#   criteriatree: contains information about which criteria from the above list is triggered when count is
#        attributed in a mythic dungeon as well as the amount of count attributed
#   journalencounter: contains the encounterID and instanceID for bosses which MDT stores
wowtools_files = ["criteria", "criteriatree", "journalencounter"]
db = load_db_files(wowtools_files)


def get_potential_new_ids(original_name, dungeon_count_table):
    """Checks dungeon_count_table for npc matching original_name

    Args:
        original_name (string): Name of npc with count changes
        dungeon_count_table (dataaframe):  True count dataframe for dungeon

    Returns:
        list: All npc ids with names matching original_name
        list: All count associated with the above npc ids

    """
    potential_new_ids = []
    potential_new_count = []
    for id in dungeon_count_table.index.to_list():
        name = get_npc_name(id)
        if name == original_name:
            potential_new_ids.append(id)
            potential_new_count.append(dungeon_count_table.loc[id, "count"])

    return potential_new_ids, potential_new_count


def fix_split_count_db(dungeon_id, true_count_table):
    """Combines count tables together when split eg. Siege of Boralus (Alliance and Horde)

    Args:
        dungeon_id: Id associated with the dungeon
        dungeon_count_table (dataframe): True count dataframe for dungeon

    Returns:
        dungeon_count_table (dataframe): Combined true count dataframe for dungeon

    """
    split_dungeons = {
        67227: [67283]  # Siege of Boralus
    }
    if dungeon_id in split_dungeons.keys():
        for other_id in split_dungeons[dungeon_id]:
            other_table = get_count_table(other_id)
            true_count_table = pd.concat((true_count_table, other_table[~other_table.index.isin(true_count_table.index)]))
        return true_count_table
    else:
        return true_count_table


def update_count(match, dungeon_count_table):
    """Updates the MDT creature information string with true count.

    Args:
        match (regex match): Regex match of a single creature
        dungeon_count_table (dataframe): True count dataframe for dungeon

    Returns:
        string: Enemy information with updated count in MDT format

    """
    # keys will be 'id' and 'count'
    info = {match.group(1): int(match.group(2)), match.group(3): int(match.group(4))}
    if len(dungeon_count_table[dungeon_count_table.index == info['id']]) > 0:
        # if npcid is found in count table
        true_count = dungeon_count_table[dungeon_count_table.index == info['id']].values[0][0]
    else:
        # if npcid is not found in count table
        true_count = 0

    # Hardcoded count for if in game count does not match db files
    unexplainable_count = {
        # npcid: {'db_count': X, 'hardcoded_count': Y}
        115765: {'db_count': 12, 'hardcoded_count': 18},    # Abstract Nullifier, Upper Karazhan
        115019: {'db_count': 3, 'hardcoded_count': 6},      # Coldmist Widow, Lower Karazhan
        115020: {'db_count': 4, 'hardcoded_count': 7},      # Arcanid, Lower Karazhan
    }
    if info['id'] in unexplainable_count.keys():
        npc_name = pattern_npc_name.search(match.group()).group(1)
        if unexplainable_count[info['id']]['db_count'] != true_count:
            # This is a warning that the db_count for the mob has changed since last looked at
            print(
                f"    {npc_name} with id {info['id']} has hardcoded count {unexplainable_count[info['id']]['hardcoded_count']}"
                f"\n        Warning this npcs db count changed: {unexplainable_count[info['id']]['db_count']} -> {true_count}"
                f" (Report to Stinth, no changes made in MDT)")
        if unexplainable_count[info['id']]['hardcoded_count'] != info['count']:
            print(
                f"    {npc_name} with id {info['id']} has been updated: {info['count']} -> {unexplainable_count[info['id']]['hardcoded_count']} (Hardcoded)")
            new_count = unexplainable_count[info['id']]['hardcoded_count']
            return match.group().replace(f'["count"] = {info["count"]}', f'["count"] = {new_count}')

    elif true_count != info['count']:
        npc_name = pattern_npc_name.search(match.group()).group(1)
        if true_count == 0:
            print(f"    {npc_name} with id {info['id']} has been updated: {info['count']} -> {true_count}")
            print(f"    Collecting potential new IDs for npc: ", end="")
            new_ids, new_counts = get_potential_new_ids(npc_name, dungeon_count_table)
            print("IDs: {}, respective count: {}".format(new_ids, new_counts))
            return match.group().replace(f'["count"] = {info["count"]}', f'["count"] = {true_count}')

        print(f"    {npc_name} with id {info['id']} has been updated: {info['count']} -> {true_count}")
        return match.group().replace(f'["count"] = {info["count"]}', f'["count"] = {true_count}')

    return match.group()


def update_total_count(match, total_count):
    """Updates the MDT dungeon count information string with true count.

    Args:
        match (regex match):  Current total dungeon count found in dungeon.lua MDT file
        total_count (int): True total dungeon count from db files

    Returns:
        string: Updated total dungeon count in MDT format

    """
    if total_count != int(match.group(1)):
        print(f"    Total dungeon count has been updated: {match.group(1)} -> {total_count}")
        return match.group().replace(f'normal = {match.group(1)}', f'normal = {total_count}')

    return match.group()


def get_dungeon_from_file_text(file_text):
    """Collects dungeon ID from MDT dungeon.lua file text.

    Args:
        file_text (string): MDT dungeon.lua file text

    Returns:
        int: Dungoen ID associated with the file

    """
    pattern_encounterID = re.compile(r"encounterID\D*([\d]+)")
    encounterIDs = pattern_encounterID.findall(file_text)
    encounterIDs = [int(ID) for ID in encounterIDs]
    DungeonEncounterIDs = db['journalencounter'][db['journalencounter'].ID.isin(encounterIDs)].DungeonEncounterID.values
    CriteriaIDs = db['criteria'][db['criteria'].Asset.isin(DungeonEncounterIDs)].ID.values
    ParentIDs = db['criteriatree'][db['criteriatree'].CriteriaID.isin(CriteriaIDs)].Parent.values

    challenge_at_end = db['criteriatree'][(db['criteriatree'].ID.isin(ParentIDs))
                             & (db['criteriatree'].Description_lang.str.endswith("Challenge"))
                             & (db['criteriatree'].Operator == 4)]
    
    challenge_contained = db['criteriatree'][(db['criteriatree'].ID.isin(ParentIDs))
                                     & (db['criteriatree'].Description_lang.str.contains("Challenge"))
                                     & (~db['criteriatree'].Description_lang.str.contains("More Trash", na=False))
                                     & (db['criteriatree'].Operator == 4)]
    if len(challenge_at_end) > 0:
        return challenge_at_end.ID.values[0]

    elif len(challenge_contained) > 0:
        return challenge_contained.ID.values[0]

    else:
        # Weird case where blizzard doesn't use the journalencounterid, but instead the npcID
        all_npcids = re.findall(r"\"id\"\] = (\d+)", file_text)
        all_npcids = [int(ID) for ID in all_npcids]
        CriteriaIDs = db['criteria'][db['criteria'].Asset.isin(all_npcids)].ID.values
        ParentIDs = db['criteriatree'][db['criteriatree'].CriteriaID.isin(CriteriaIDs)].Parent.values
        if len(db['criteriatree'][(db['criteriatree'].ID.isin(ParentIDs))
                                 & (db['criteriatree'].Description_lang.str.endswith("Challenge"))]) > 0:
            dungeonID = db['criteriatree'][(db['criteriatree'].ID.isin(ParentIDs)) & (
                db['criteriatree'].Description_lang.str.endswith("Challenge"))].ID.values[0]

            return dungeonID

        else:
            print("WARNING: NEW SHIT BLIZZARD BRAIN DISCOVERED")


def update_file(fullpath):
    """Updates creature and total count found in a dungeon.lua MDT file directly.

    Args:
        fullpath (string): Filepath to a dungeon.lua MDT file

    Returns:
        nothing: Updates the dungeon.lua MDT file content directly

    """
    with open(fullpath, "r") as file:
        file_text = file.read()
        # Dungeon name
        print(f'Verifying {pattern_dungeon_name.search(file_text).group(1)}.')
        if pattern_empty_dungeon_file.search(file_text):
            return
        # String containing only table MDT.dungeonEnemies[dungeonIndex]
        dungeon_enemies = pattern_dungeonEnemies.search(file_text)[0]
        # Get true mob count table
        dungeon_id = get_dungeon_from_file_text(file_text)
        true_mob_count = get_count_table(dungeon_id)
        true_mob_count = fix_split_count_db(dungeon_id, true_mob_count)
        # Replace old MDT.dungeonEnemies[dungeonIndex] with new string containing true count
        dungeon_enemies_true_count = pattern_enemy_match.sub(lambda match: update_count(match, true_mob_count), dungeon_enemies)

        # String containing only table MDT.dungeonTotalCount[dungeonIndex]
        total_count = pattern_dungeonTotalCount.search(file_text)[0]
        # Get true total count
        true_total_count = get_total_count(dungeon_id)
        # Replace old count value with new true count
        true_count_string = pattern_count_value.sub(lambda match: update_total_count(match, true_total_count), total_count)

        updated_text = pattern_dungeonTotalCount.sub(true_count_string, file_text)
        updated_text = pattern_dungeonEnemies.sub(dungeon_enemies_true_count, updated_text)

    with open(fullpath, "w") as file:
        file.write(updated_text)


if __name__ == "__main__":
    # Locate dungeon
    # Get "encounterID" from MDT dungeon.lua file
    # Get DungeonEncounterID from journalencounter db by searching encounterID as ID
    # Get CriteriaID for criteria db by searching for DungeonEncounterID as Asset
    # Get Parent from CriteriaTree by searching for CriteriaID as CriteriaID
    # There will be multiple parents, the correct ID will be the one where Description_lang contains "Challenge"
    pattern_dungeon_name = re.compile(r'MDT\.dungeonList\[dungeonIndex\] = L\[\"([\w\S ]+)\"]')
    pattern_empty_dungeon_file = re.compile(r'MDT\.dungeonEnemies\[dungeonIndex\] = {\n}')
    pattern_dungeonEnemies = re.compile(r"MDT\.dungeonEnemies\[dungeonIndex\] = \{[\s\S]*};")
    pattern_enemy_match = re.compile(r"{[\s\S]+?\"(id|count)\"\D*([\d]+).*[\s\S]+?\"(id|count)\"\D*([\d]+)[\s\S]+?}")
    pattern_dungeonTotalCount = re.compile(r"MDT\.dungeonTotalCount\[dungeonIndex\] .*")
    pattern_count_value = re.compile(r"normal = (\d+)")
    pattern_npc_name = re.compile(r'\[\"name\"\] = "([^\n]+)";')
    
    # Make sure initial working directory is MythicDungeonTools
    while os.getcwd().__contains__("MythicDungeonTools") and not os.getcwd().endswith("MythicDungeonTools"):
        os.chdir('..')
    
    # Loop through all expansions and dungeons and update count information
    for expansion in EXPANSIONS:
        dungeon_filenames = os.listdir(expansion)
        print(f"- {expansion}")
        for dungeon_filename in dungeon_filenames:
            if dungeon_filename.endswith(".lua") and dungeon_filename != "overrides.lua":
                file_path = os.path.join(os.getcwd(), expansion, dungeon_filename)
                update_file(file_path)

