# Created by Urtgard
# Scrapes wowhead for npcNames based on npcIds
import math
import os
import re
import threading
import time
from collections import OrderedDict
from html import unescape
from socket import error as SocketError

import requests

# Usage:
# 1. Refer to requirements.txt to install required packages
# 2. Make sure to be in /python working directory
# 3. Run this script
# 4. Open the generated lua files and copy the contents to https://www.curseforge.com/wow/addons/mythic-dungeon-tools/localization


def create_session():
    session = requests.Session()
    # wowhead is picky
    session.headers.update(
        {
            "Accept": "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9",
            "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.116 Safari/537.36",
        }
    )

    return session


def get_npc_name(npc_id, language, session):
    try:
        if language == "en":
            language = ""

        url = f"https://{language + ((language != '') and '.' or '')}wowhead.com/npc={npc_id}"
        with session.get(url) as r:
            if r.status_code == 404:
                print(f"NPC {npc_id} fully doesn't exist")
                return False
            r.raise_for_status()
            result = re.search(r'"og:title" content="(.*)">', unescape(r.text))
            time.sleep(2)
            if result:
                return result.group(1)
            else:
                print(
                    f"Failed to get {'en' if language == '' else language} name for {npc_id} - error {r.status_code}"
                )
                return False
    except requests.exceptions.RequestException as e:
        print(f"Error: {e}\t Url: {url}")
        time.sleep(5)
        return get_npc_name(npc_id, language)


npc_list = {}
languages = {
    "frFR": "fr",
    "deDE": "de",
    "itIT": "it",
    "koKR": "ko",
    "zhCN": "cn",
    "ruRU": "ru",
    "esES": "es",
    "ptBR": "pt",
}
expansions = ["Legion", "BattleForAzeroth", "Shadowlands", "Dragonflight"]


def get_npc_names_localized(npc_id, session):
    name = get_npc_name(npc_id, "en", session)
    if not name:
        return
    if name in npc_list:
        print(f"{name} is already in list, skipping ID {npc_id}")
        return
    npc_list[name] = {"enUS": name}
    for lang in languages:
        npc_list[name][lang] = get_npc_name(npc_id, languages[lang], session)


def collect_mdt_npcids():
    # reaping and awakening mobs
    ids = [148716, 148893, 148894, 161169, 160984, 161164, 161167]
    for expansion in expansions:
        for filename in os.listdir("{}".format(expansion)):
            if not filename.endswith(".lua"):
                continue
            f = open("{}\\{}".format(expansion, filename))
            line = f.readline()
            while line:
                npc_id = re.search(r'\["id"\] = (\d*)', line)
                if npc_id:
                    npc_id = int(npc_id.group(1))
                    if npc_id > 100000000:
                        print(f"Invalid NPC ID {npc_id}, skipping")
                    elif npc_id not in ids:
                        ids.append(npc_id)
                line = f.readline()
    return ids


finished_ids = 0
total_ids = 0
lock = threading.Lock()


def get_npc_names(ids, session):
    for id in ids:
        get_npc_names_localized(id, session)
        lock.acquire()
        global finished_ids
        finished_ids = finished_ids + 1
        print(f"Finished {finished_ids}/{total_ids} NPCs")
        lock.release()


def write_to_lua(dst, src):
    file = f"{dst}.lua"
    with open(file, "w", encoding="UTF-8") as out:
        for npc in npc_list:
            npc_name_localized = re.match(
                r"\[?([^\]]*)", str(npc_list[npc][src])
            ).group(1)
            out.write(f'\tL["{npc}"] = "{npc_name_localized}"\n')


def split_list(a, n):
    k, m = divmod(len(a), n)
    return (a[i * k + min(i, m) : (i + 1) * k + min(i + 1, m)] for i in range(n))


if __name__ == "__main__":
    # Make sure initial working directory is MythicDungeonTools
    while os.getcwd().__contains__("MythicDungeonTools") and not os.getcwd().endswith(
        "MythicDungeonTools"
    ):
        os.chdir("..")
    ids = collect_mdt_npcids()
    total_ids = len(ids)
    print(f"{total_ids} NPC IDs in dungeon files")
    nthreads = 5  # 100
    chunks = list(split_list(ids, nthreads))
    threads = []
    start = time.perf_counter()
    print(f"Starting {nthreads} threads")
    for i in range(0, nthreads):
        session = create_session()
        t = threading.Thread(
            target=get_npc_names,
            args=(
                chunks[i],
                session,
            ),
        )
        threads.append(t)
        t.start()
    for _, t in enumerate(threads):
        t.join()
    end = time.perf_counter()
    print(f"Finished in {round(end - start, 2)} second(s)")

    for lang in languages:
        write_to_lua(lang, lang)
    # scuffed languages
    write_to_lua(src="enUS", dst="enUS")
    write_to_lua(src="esES", dst="esMX")
    write_to_lua(src="zhCN", dst="zhTW")
