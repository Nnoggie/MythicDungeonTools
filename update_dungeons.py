#!/usr/bin/env python3
import csv
import collections
criteria = list(csv.DictReader(open('criteria.csv')))
criteria_tree = list(csv.DictReader(open('criteriatree.csv')))

def find_dungeon(internal, teeming = False):
    desc = internal
    if teeming:
        desc = f"{internal} (More Trash)"
    return next((x for x in criteria_tree if x['Description_lang'] == desc), None)

def find_forces(row):
    return next((x for x in criteria_tree if x['Description_lang'] == "Enemy Forces" and x['Parent'] == row['ID']), None)

Dungeon = collections.namedtuple('Dungeon', 'name internal')
known_dungeons = [
    Dungeon(name='AtalDazar', internal='8.0 Dungeon - City of Gold Exterior - Challenge'),
    Dungeon(name='Freehold', internal='8.0 Dungeon - Outlaw Town - Challenge'),
    Dungeon(name='KingsRest', internal='8.0 Dungeon - Kings\' Rest - Challenge'),
    Dungeon(name='ShrineoftheStorm', internal='8.0 Dungeon - Shrine of the Storm - Challenge'),
    Dungeon(name='SiegeofBoralus_Alliance', internal='Boralus Dungeon - Dungeon Scenario - Challenge'),
    Dungeon(name='SiegeofBoralus_Horde', internal='Boralus Dungeon - Dungeon Scenario - Challenge (Horde)'),
    Dungeon(name='TempleofSethraliss', internal='8.0 Dungeon - Temple of Sethraliss - Challenge'),
    Dungeon(name='TheMotherlode', internal='8.0 Dungeon - Kezan - Challenge'),
    Dungeon(name='TheUnderrot', internal='8.0 Dungeon - The Underrot - Challenge'),
    Dungeon(name='TolDagor', internal='8.0 Prison Dungeon - Kul Tiras Prison - Challenge'),
    Dungeon(name='WaycrestManor', internal='8.0 Dungeon - Drustvar Dungeon - Challenge')
]

def replace_between(text, start, end, new_text):
    pos = text.find(start)+len(start)
    pos_end = text.find(end, pos)
    return text[:pos] + new_text + text[pos_end:]

def replace_enemy_count(text, id, new_count):
    pattern = f"[\"id\"] = {id};"
    pos = text.find(pattern)+len(pattern)
    sub = replace_between(text[pos:], '["count"] = ', ';', new_count)
    return text[:pos] + sub

def update_lua_file(dungeon, normal, teeming):
    name = dungeon.name
    if '_' in name:
        # SoB alliance/horde seem to have same count requirements so we can just do this
        name = dungeon.name[:name.find('_')]

    path = f"MethodDungeonTools/BattleForAzeroth/{name}.lua"
    with open(path, "r") as file:
        text = file.read()
    text = replace_between(text, '{normal=', ',teeming', normal)
    text = replace_between(text, ',teeming=', ',teemingEnabled', teeming)
    #for enemy in enemies:
    #    eid, count = enemy
    #    text = replace_enemy_count(text, eid, count)
    with open(path, "w") as file:
        file.write(text)

for dungeon in known_dungeons:
    row = find_dungeon(dungeon.internal)
    teeming_row = find_dungeon(dungeon.internal, teeming=True)
    if not teeming_row or not row:
        print(f"Could not find {dungeon.name}")
        continue

    forces = find_forces(row)
    teeming_forces = find_forces(teeming_row)
    print(f"{dungeon.name} enemy forces normal = {forces['Amount']}, teeming = {teeming_forces['Amount']}")
    count = [x for x in criteria_tree if x['Parent'] == forces['ID']]
    enemies = {}
    for enemy in count:
        asset = next((x['Asset'] for x in criteria if x['ID'] == enemy['CriteriaID']), None)
        print(f"\tNPC {asset} gives {enemy['Amount']} count")
        enemies[asset] = enemy['Amount']
    teeming_count = [x for x in criteria_tree if x['Parent'] == teeming_forces['ID']]
    for enemy in teeming_count:
        asset = next((x['Asset'] for x in criteria if x['ID'] == enemy['CriteriaID']), None)
        count = enemy['Amount']
        if asset in enemies:
            if enemies[asset] != count:
                print(f"\tDuring teeming {asset} gives {count} count (not {enemies[asset]})")
    #update_lua_file(dungeon, forces['Amount'], teeming_forces['Amount'])
