# Created by Nnoggie
# Scrapes wowhead for displayIds based on npcIds
# Use MethodDungeonTools:ExportNPCIdsWithoutDisplayIds() to export npcIds to query
import urllib.request
import re
import time
import collections
from tkinter import Tk


r = Tk()
r.withdraw()
r.clipboard_clear()


def find_display_id(npc_id):
    url = 'https://www.wowhead.com/npc=' + str(npc_id)
    with urllib.request.urlopen(url) as response:
        response = response.read()
        result = re.search('displayId&quot;:(.*)}(.*)">View', str(response))
        return result.group(1)


Dungeon = collections.namedtuple('Dungeon', 'name idx npcIds')
dungeons = [
    Dungeon(name='Siege of Boralus', idx=19, npcIds=[137614, 137405, ]),
    Dungeon(name='Mechagon - Junkyard', idx=25, npcIds=[155090, 150297, 150292, 154744, 153377, 150159, 155094, 150293, 150195, 150165, 150168, 150169, 154758, ]),
]

table_output = "local dungeonData ={"


for dungeon in dungeons:
    table_output += f"[{dungeon.idx}]={{"
    for npc in dungeon.npcIds:
        displayId = find_display_id(npc)
        time.sleep(2)
        table_output += f"[{npc}]={{displayId={displayId}}},"
        print(npc, displayId)

    table_output += f"}},"

table_output += "}"
r.clipboard_append(table_output)
r.update()
r.destroy()
input("\nLua table copied to clipboard. Press Enter to exit after pasting.")
