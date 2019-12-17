# Original draft by Blazeton, adjusted and enhanced by Nnoggie
# Scans criteria.csv and criteriatree.csv for enemy count
# Scrapes wowhead for displayIds
# Download criteria.csv and criteriatree.csv here:
# https://wow.tools/dbc/?dbc=criteriatree&build=8.3.0.32805#search=&page=1
# search in criteriatree for "(More Trash)" to find dungeon names
import csv
import collections
import urllib.request
import re
import time
from tkinter import Tk

criteria = list(csv.DictReader(open('criteria.csv')))
criteria_tree = list(csv.DictReader(open('criteriatree.csv')))

r = Tk()
r.withdraw()
r.clipboard_clear()


def find_dungeon(internal, teeming=False):
    desc = internal
    if teeming:
        desc = f"{internal} (More Trash)"
    return next((x for x in criteria_tree if x['Description_lang'] == desc), None)


def find_forces(row):
    return next((x for x in criteria_tree if x['Description_lang'] == "Enemy Forces" and x['Parent'] == row['ID']),
                None)


def findDisplayId(npcId):
    url = 'https://www.wowhead.com/npc=' + npcId
    with urllib.request.urlopen(url) as response:
        response = response.read()
        result = re.search('displayId&quot;:(.*)}(.*)">View', str(response))
        return result.group(1)


Dungeon = collections.namedtuple('Dungeon', 'name idx internal')
known_dungeons = [
    # Dungeon(name='AtalDazar', idx=15, internal='8.0 Dungeon - City of Gold Exterior - Challenge'),
    # Dungeon(name='Freehold', idx=16, internal='8.0 Dungeon - Outlaw Town - Challenge'),
    # Dungeon(name='KingsRest', idx=17, internal='8.0 Dungeon - Kings\' Rest - Challenge'),
    # Dungeon(name='ShrineoftheStorm', idx=18, internal='8.0 Dungeon - Shrine of the Storm - Challenge'),
    # Dungeon(name='SiegeofBoralus_Alliance', idx=19, internal='Boralus Dungeon - Dungeon Scenario - Challenge'),
    # Dungeon(name='SiegeofBoralus_Horde', idx=19, internal='Boralus Dungeon - Dungeon Scenario - Challenge (Horde)'),
    # Dungeon(name='TempleofSethraliss', idx=20, internal='8.0 Dungeon - Temple of Sethraliss - Challenge'),
    # Dungeon(name='TheMotherlode', idx=21, internal='8.0 Dungeon - Kezan - Challenge'),
    # Dungeon(name='TheUnderrot', idx=22, internal='8.0 Dungeon - The Underrot - Challenge'),
    # Dungeon(name='TolDagor', idx=23, internal='8.0 Prison Dungeon - Kul Tiras Prison - Challenge'),
    # Dungeon(name='WaycrestManor', idx=24, internal='8.0 Dungeon - Drustvar Dungeon - Challenge'),
    # Dungeon(name='MechagonIsland', idx=25, internal='8.2 Dungeon - Operation: Mechagon, Junkyard - Challenge'),
    Dungeon(name='MechagonCity', idx=26, internal='8.2 Dungeon - Operation: Mechagon, City - Challenge'),
]


def append_to_lua_table(dungeon, normal, teeming, count, teeming_count, output):
    output += f"[{dungeon.idx}]={{[0]={{count={normal},teeming_count={teeming}}},"
    for enemy in count:
        enemyCount = enemy['Amount']
        npcId = next((x['Asset'] for x in criteria if x['ID'] == enemy['CriteriaID']), None)
        enemyTeemingCount = 999
        for teemingEnemy in teeming_count:
            enemyTeemingCount = teemingEnemy['Amount']
            npcIdTeeming = next((x['Asset'] for x in criteria if x['ID'] == teemingEnemy['CriteriaID']), None)
            if npcId == npcIdTeeming:
                break

        displayId = findDisplayId(npcId)
        time.sleep(2)

        output += f"[{npcId}]={{count={enemyCount},teeming_count={enemyTeemingCount},displayId={displayId}}},"
    output += f"}},"
    return output


tableOutput = "local dungeonData ={"
for dungeon in known_dungeons:
    row = find_dungeon(dungeon.internal)
    teeming_row = find_dungeon(dungeon.internal, teeming=True)

    forces = find_forces(row)
    teeming_forces = find_forces(teeming_row)

    print(f"{dungeon.name} enemy forces normal = {forces['Amount']}, teeming = {teeming_forces['Amount']}")
    count = [x for x in criteria_tree if x['Parent'] == forces['ID']]
    teeming_count = [x for x in criteria_tree if x['Parent'] == teeming_forces['ID']]
    tableOutput = append_to_lua_table(dungeon, forces['Amount'], teeming_forces['Amount'], count, teeming_count,
                                      tableOutput)

tableOutput += "}"
r.clipboard_append(tableOutput)
r.update()
r.destroy()
input("\nLua table copied to clipboard. Press Enter to exit after pasting.")
