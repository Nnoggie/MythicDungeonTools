import os
import requests
import time
import pandas as pd



def get_displayid_and_creaturetype(npcId):
    """Collects and returns displayID and creature type of NPC.

    Args:
        npcId: Creature NPC ID

    Returns:
        int: Creature display ID
        string: Creature type

    """
    headers = {
        'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.116 Safari/537.36'
    }
    url = f"https://wow.tools/db/creature_api.php?id={npcId}"
    creatureType_dict = {1: "Beast", 2: "Dragonkin", 3: "Demon", 4: "Elemental", 5: "Giant", 6: "Undead", 7: "Humanoid",
                         8: "Critter", 9: "Mechanical", 10: "Not specified", 11: "Totem", 12: "Non-combat Pet",
                         13: "Gas Cloud", 14: "Wild Pet", 15: "Aberration"}
    response = requests.get(url, headers=headers)
    time.sleep(2)
    json = response.json()
    displayID = json["CreatureDisplayInfoID[0]"]
    creatureType = int(json["CreatureType"])
    return displayID, creatureType_dict[creatureType]


def get_latest_version(filename):
    """Creates dataframe of wowdb file.

    Loads file from disk if available, otherwise downloads the file from wowtools.

    Args:
        filename: Name of wowdb file

    Returns:
        dataframe: Pandas dataframe of wowdb data

    """
    headers = {
        'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.116 Safari/537.36'
    }
    url = f"https://api.wow.tools/databases/{filename}/versions"
    response = requests.get(url, headers=headers)
    time.sleep(2)
    latest_build = response.json()[0]
    latest_build = "9.2.7.45161" # hardcode desired build here

    data_url = f"https://wow.tools/dbc/api/export/?name={filename}&build={latest_build}&useHotfixes=true"
    data_response = requests.get(data_url, headers=headers)
    time.sleep(2)
    with open(f"wowdb_files/{filename}.csv", "wb") as f:
        f.write(data_response.content)
    print(f"Latest version of {filename}.csv has been downloaded ({latest_build})")
    df = pd.read_csv(f"wowdb_files/{filename}.csv")
    return df

def load_db_files(wowtools_files = ["uimapassignment", "map", "criteria", "criteriatree", "journalencounter"]):
    """Loads wowdb files to dictionary of dataframes.

    Args:
        wowtools_files (list): List of wowdb files to load

    Returns:
        dict: Dictionary of dataframes containing wowdb data

    """
    if not os.getcwd().endswith("python") and os.path.isdir(os.getcwd() + "/python"):
        os.chdir(os.getcwd() + "/python")

    if not os.path.exists(os.getcwd() + '/wowdb_files'):
        os.mkdir(os.getcwd() + '/wowdb_files')

    db = {}
    for file in wowtools_files:
        try:
            db[file] = pd.read_csv(f"wowdb_files/{file}.csv")
        except FileNotFoundError:
            db[file] = get_latest_version(file)

    return db


def get_npc_name(npc_id):
    """Collects and returns NPC name given an NPC ID through wowhead.

    Args:
        npcId: Creature NPC ID

    Returns:
        string: Creature name

    """
    headers = {
        'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.116 Safari/537.36'
    }
    url = f'https://ptr.wowhead.com/tooltip/npc/{npc_id}'
    response = requests.get(url, headers=headers)
    time.sleep(0.2)
    if response.status_code == 200:
        name = response.json()["name"]
        return name
    else:
        if response.status_code == 404:
            print("No NPC found.")
            return "No Name"

if __name__ == "__main__":      # Meaning if this file is run itself and not imported by another script
    print("If you want to map with combat log, but scrape and import the displayIds and creatureType later,\n"
          "a rewrite of the function associated with the 'Export to LUA' button in the devpanel is necessary\n"
          "to include handling of creatureType.")
