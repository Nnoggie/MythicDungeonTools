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

def get_npc_name(npc_id, language, ptr=False):
	try:
		if language == 'en':
			language = ''
		elif ptr and language != '':
			return False
		url = 'https://{}{}wowhead.com/tooltip/npc/{}'.format(ptr and 'ptr.' or '', language + ((language != '') and '.' or ''), str(npc_id))
		with urllib.request.urlopen(url) as response:
			response = response.read().decode('unicode_escape')
			
			result = re.search('"name":"(.*?)"', response)
			return result.group(1)
	except SocketError as e:
		print('Error: {}\t Url: {}'.format(e, url))
		if hasattr(e, 'code') and e.code == 404:
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

def get_npc_names_localized(npc_id):
	name = get_npc_name(npc_id, 'en')
	if not name:
		print(npc_id)
		return
	if name in npc_list:
		return
	npc_list[name] = {}
	for key in languages:
		npc_list[name][key] = get_npc_name(npc_id, languages[key])

tmp = open('tmp', 'w', encoding='UTF-8')

def write_npc_names(language):
	for npc_name in npc_list:
		if npc_name is not None:
			if language == 'enUS':
				tmp.write('L["{}"] = true\n'.format(str(npc_name)))
			else:
				npc_name_localized = npc_list[npc_name][language]
				if npc_name_localized:
					npc_name_localized = re.match('\[?([^\]]*)', str(npc_name_localized)).group(1)
					tmp.write('\tL["{}"] = "{}"\n'.format(str(npc_name), str(npc_name_localized)))

def write_to_locales():
	delete_old_names = False
	with open("Locales.lua", "r", encoding="UTF-8") as input:
		with tmp as output: 
			for line in input:
				search_language = re.search('L = LibStub\("AceLocale-3.0"\):NewLocale\("MethodDungeonTools", "(\w*)"', line)
				if search_language:
					language = search_language.group(1)

				if re.search('-- npc_names_start', line):
					output.write(line)
					write_npc_names(language)
					delete_old_names = True
				elif re.search('-- npc_names_end', line):
					delete_old_names = False
					output.write(line)
				elif not delete_old_names:
					output.write(line)

# reaping mobs
npc_id_list = [148716, 148893, 148894]
# corruption
npc_id_list.extend([161169, 160984, 161164, 161167])

for expansion in ['Legion', 'BattleForAzeroth']:
	for filename in os.listdir('.\{}'.format(expansion)):
		if filename.endswith(".lua"):
			f = open('.\{}\\{}'.format(expansion,filename))
			line = f.readline()
			while line:
				npc_id = re.search('\[\"id\"\] = (\d*)', line)
				if npc_id:
					npc_id = npc_id.group(1)
					if not npc_id in npc_id_list:
						npc_id_list.append(npc_id)
				line = f.readline()

def get_npc_names(a, b):
	b = min(math.floor(b), len(npc_id_list))
	for i in range(a, b):
		npc_id = npc_id_list[i]
		npc_list[get_npc_names_localized(npc_id)] = True

threads = []
for i in range(100):
	k = len(npc_id_list)/100
	t = threading.Thread(target=get_npc_names, args=(math.floor(i*k), math.floor((i+1)*k)))
	threads.append(t)
	t.start()

for _, t in enumerate(threads):
	t.join()

npc_list = OrderedDict(sorted(npc_list.items(), key=lambda t: t[0] or ''))
write_to_locales()
os.remove('Locales.lua')
os.rename('tmp', 'Locales.lua')
