import requests
import time
import pandas as pd

headers = {
    'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.116 Safari/537.36'
}

creatureType_dict = {1: "Beast", 2: "Dragonkin", 3: "Demon", 4: "Elemental", 5: "Giant", 6: "Undead", 7: "Humanoid",
                     8: "Critter", 9: "Mechanical", 10: "Not specified", 11: "Totem", 12: "Non-combat Pet",
                     13: "Gas Cloud", 14: "Wild Pet", 15: "Aberration"}

def get_displayid_and_creaturetype(npcId):
    url = f"https://wow.tools/db/creature_api.php?id={npcId}"
    response = requests.get(url, headers=headers)
    time.sleep(2)
    json = response.json()
    displayId = json["CreatureDisplayInfoID[0]"]
    creatureType = int(json["CreatureType"])
    return displayId, creatureType_dict[creatureType]


def get_latest_version(filename):
    url = f"https://api.wow.tools/databases/{filename}/versions"
    response = requests.get(url, headers=headers)
    time.sleep(2)
    latest_build = response.json()[0]

    data_url = f"https://wow.tools/dbc/api/export/?name={filename}&build={latest_build}"
    data_response = requests.get(data_url, headers=headers)
    time.sleep(2)
    with open(f"{filename}.csv", "wb") as f:
        f.write(data_response.content)
    print(f"Latest version of {filename}.csv has been downloaded ({latest_build})")
    df = pd.read_csv(f"{filename}.csv")
    return df

if __name__ == "__main__":      # Meaning if this file is run itself and not imported by another script
    print("If you want to map with combat log, but scrape and import the displayIds and creatureType later,\n"
          "a rewrite of the function associated with the 'Export to LUA' button in the devpanel is necessary\n"
          "to include handling of creatureType.")