# Created by Urtgard
# Scrapes wowhead for npcNames based on npcIds
import urllib.request
from urllib.error import HTTPError
import re
import os
from socket import error as SocketError
import threading
import math
import time
from collections import OrderedDict 

# wowhead is picky
browser_headers = {
    'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9',
    'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.116 Safari/537.36'
}

def get_npc_name(npc_id, language, ptr=False):
    try:
        if language == 'en':
            language = ''
        elif ptr and language != '':
            return False

        url = 'https://{}{}wowhead.com/tooltip/npc/{}'.format(ptr and 'ptr.' or '', language + ((language != '') and '.' or ''), str(npc_id))
        req = urllib.request.Request(url, headers=browser_headers)
        with urllib.request.urlopen(req) as response:
            response = response.read().decode('unicode_escape')
            result = re.search('"name":"(.*?)"', response)
            return result.group(1)
    except SocketError as e:
        print('Error: {}\t Url: {}'.format(e, url))
        if hasattr(e, 'code') and e.code == 404:
            if ptr:
                print(f'NPC {npc_id} fully doesn\'t exist')
                return False
            return get_npc_name(npc_id, language, True)
        else:
            time.sleep(5)
            return get_npc_name(npc_id, language)

npc_list = {}
languages = {
    'frFR': 'fr',
    'deDE': 'de',
    'itIT': 'it',
    'koKR': 'ko',
    'zhCN': 'cn',
    'ruRU': 'ru',
    'esES': 'es',
    'ptBR': 'pt',
}
#expansions = ['Legion', 'BattleForAzeroth']
expansions = ['Shadowlands']

def get_npc_names_localized(npc_id):
    name = get_npc_name(npc_id, 'en')
    if not name:
        print(f'Failed to get EN name for {npc_id}')
        return
    if name in npc_list:
        print(f'{name} is already in list, skipping ID {npc_id}')
        return
    npc_list[name] = {'enUS': name}
    for lang in languages:
        npc_list[name][lang] = get_npc_name(npc_id, languages[lang])

def collect_mdt_npcids():
    # reaping and awakening mobs
    ids = [148716, 148893, 148894, 161169, 160984, 161164, 161167]
    for expansion in expansions:
        for filename in os.listdir('..\{}'.format(expansion)):
            if not filename.endswith(".lua"):
                continue
            f = open('..\{}\\{}'.format(expansion,filename))
            line = f.readline()
            while line:
                npc_id = re.search('\[\"id\"\] = (\d*)', line)
                if npc_id:
                    npc_id = int(npc_id.group(1))
                    if npc_id > 100000000:
                        print(f'Invalid NPC ID {npc_id}, skipping')
                    elif not npc_id in ids:
                        ids.append(npc_id)
                line = f.readline()
    return ids

finished_ids = 0
total_ids = 0
lock = threading.Lock()
def get_npc_names(ids):
    for id in ids:
        get_npc_names_localized(id)
        lock.acquire()
        global finished_ids
        finished_ids = finished_ids + 1
        print(f'Finished {finished_ids}/{total_ids}')
        lock.release()

def write_to_lua(dst, src):
    file = f'{dst}.lua'
    with open(file, 'w', encoding='UTF-8') as out:
        for npc in npc_list:
            npc_name_localized = re.match('\[?([^\]]*)', str(npc_list[npc][src])).group(1)
            out.write(f'\tL["{npc}"] = "{npc_name_localized}"\n')

def split_list(a, n):
    k, m = divmod(len(a), n)
    return (a[i * k + min(i, m):(i + 1) * k + min(i + 1, m)] for i in range(n))

if __name__ == "__main__":
    ids = collect_mdt_npcids()
    total_ids = len(ids)
    print(f'{total_ids} NPC IDs in dungeon files')
    nthreads = 5 #100
    chunks = list(split_list(ids, nthreads))
    threads = []
    for i in range(0, nthreads):
        t = threading.Thread(target=get_npc_names, args=(chunks[i],))
        threads.append(t)
        t.start()
    for _, t in enumerate(threads):
        t.join()

    for lang in languages:
        write_to_lua(lang, lang)
    # scuffed languages
    write_to_lua(src='enUS', dst='enUS')
    write_to_lua(src='esES', dst='esMX')
    write_to_lua(src='zhCN', dst='zhTW')
