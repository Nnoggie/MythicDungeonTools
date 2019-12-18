# Created by Nnoggie
# Scrapes wowhead for displayIds based on npcIds
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
    Dungeon(name='Mechagon - Junkyard', idx=25, npcIds=[150143, 150160, 150276, 150547, 153755, 150142, 150146, 152703, 152009, 150250, 150253, 150254, 150249, 150251, 150712, 150154, ]),
    Dungeon(name='Mechagon - Workshop', idx=26, npcIds=[144294, 144293, 144301, 144299, 144249, 151476, 144295, 151659, 151658, 144248, 144244, 144300, 144296, 144246, 151325, 144298, 144303, 151649, 150396, 151773, 151657, 145185, ]),
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
